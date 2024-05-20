find_package(Python 3.11 REQUIRED COMPONENTS Interpreter)

function(determine_resources_dir unit_test_name result_var)
    if(LINUX)
        set(${result_var}
            "${CMAKE_CURRENT_BINARY_DIR}"
            PARENT_SCOPE
        )
    elseif(WIN32)
        set(${result_var}
            ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>
            PARENT_SCOPE
        )
    elseif(APPLE)
        set(${result_var}
            "${CMAKE_CURRENT_BINARY_DIR}/${unit_test_name}.app/Contents/Resources"
            PARENT_SCOPE
        )
    else()
        message(FATAL_ERROR "Unsupported platform.")
    endif()
endfunction()

function(determine_forge_resources_dir result_var)
    if(LINUX)
        set(${result_var}
            "${CMAKE_BINARY_DIR}"
            PARENT_SCOPE
        )
    elseif(WIN32)
        set(${result_var}
            "${CMAKE_BINARY_DIR}/$<CONFIG>"
            PARENT_SCOPE
        )
    elseif(APPLE)
        set(${result_var}
            "${CMAKE_BINARY_DIR}/Forge.app/Contents/Resources"
            PARENT_SCOPE
        )
    else()
        message(FATAL_ERROR "Unsupported platform.")
    endif()
endfunction()

function(tf_add_shader target_name shader_list_file)
    # Step 1: Read the shader list file and extract .fsl file paths
    file(READ ${shader_list_file} shaders_content)
    string(REGEX MATCHALL "#include \"([^\"]*.fsl)\"" matched_fsl_files ${shaders_content})

    # Step 2: Create a list to hold the full paths of the .fsl files
    set(full_path_fsl_files "")
    get_filename_component(shaders_path "${shader_list_file}" DIRECTORY)
    get_filename_component(shader_list_filename "${shader_list_file}" NAME_WE)
    foreach(match ${matched_fsl_files})
        string(REGEX REPLACE "#include \"([^\"]*.fsl)\"" "\\1" fsl_file ${match})
        list(APPEND full_path_fsl_files "${shaders_path}/${fsl_file}")
    endforeach()

    determine_resources_dir(${target_name} resources_dir)

    # Step 3: Define the custom command with dependencies on the .fsl files
    add_custom_command(
        OUTPUT ${resources_dir}/Shaders/${shader_list_filename}.fsl.deps
        COMMAND
            ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Common_3/Tools/ForgeShadingLanguage/fsl.py -l
            ${FSL_LANGUAGES} -d ${resources_dir}/Shaders -b ${resources_dir}/CompiledShaders -i
            ${resources_dir}/ --verbose --cache-args --incremental --compile ${shader_list_file}
        DEPENDS ${full_path_fsl_files} ${shader_list_file}
        COMMENT "Compiling shaders ${shader_list_file}..."
    )

    # Step 4: Create a custom target that depends on the custom command's output
    add_custom_target(
        ${unit_test_name}-${shader_list_filename} ALL
        DEPENDS ${resources_dir}/Shaders/${shader_list_filename}.fsl.deps
    )

    # Step 5: Ensure your main target depends on the Shaders target
    add_dependencies(${target_name} ${unit_test_name}-${shader_list_filename})
endfunction()

function(tf_add_unit_test unit_test_name)
    # Use ARGN to capture all additional arguments, which are your source files
    set(unit_test_sources ${ARGN})

    if(APPLE)
        if(IOS)
            set(FSL_LANGUAGES "IOS")
        else()
            set(FSL_LANGUAGES "MACOS")
            # Link against the application's delegate class since it's not visible if built inside
            # libThe-Forge.a
            list(APPEND unit_test_sources ${CMAKE_SOURCE_DIR}/Common_3/OS/Darwin/macOSAppDelegate.m)
            set_source_files_properties(
                ${unit_test_sources} PROPERTIES COMPILE_FLAGS "-x objective-c++ -fobjc-arc"
            )
        endif()
    endif()

    determine_resources_dir(${unit_test_name} resources_dir)
    determine_forge_resources_dir(forge_resources_dir)

    add_executable(${unit_test_name} MACOSX_BUNDLE ${unit_test_sources})
    if(WIN32)
        set_target_properties(${unit_test_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${resources_dir})
    endif()
    target_link_libraries(${unit_test_name} Forge)

    if(WIN32)
        add_custom_command(
            TARGET ${unit_test_name}
            POST_BUILD
            COMMAND
                ${CMAKE_COMMAND} -E copy
                ${CMAKE_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/ags/ags_lib/lib/amd_ags_x64.dll
                ${CMAKE_SOURCE_DIR}/Common_3/OS/ThirdParty/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.dll
                ${resources_dir}
            COMMENT "Copying Windows dependencies"
        )
    endif()

    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Shaders/FSL/ShaderList.fsl")
        tf_add_shader(${unit_test_name} "${CMAKE_CURRENT_SOURCE_DIR}/Shaders/FSL/ShaderList.fsl")
    endif()

    if(APPLE
       AND EXISTS
           "${CMAKE_CURRENT_SOURCE_DIR}/../../macOS Xcode/${unit_test_name}/${unit_test_name}/Base.lproj/MainMenu.xib"
    )
        add_custom_command(
            TARGET ${unit_test_name}
            POST_BUILD
            COMMAND
                xcrun ibtool --compile "${resources_dir}/Base.lproj/MainMenu.nib"
                "${CMAKE_CURRENT_SOURCE_DIR}/../../macOS Xcode/${unit_test_name}/${unit_test_name}/Base.lproj/MainMenu.xib"
            COMMENT "Compiling unit test xib file"
        )
    endif()

    # COPY ASSETS COMMON TO ALL UNIT TESTS

    # Copy common shaders
    add_custom_command(
        TARGET ${unit_test_name}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${forge_resources_dir}/Shaders ${resources_dir}/Shaders
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${forge_resources_dir}/CompiledShaders
                ${resources_dir}/CompiledShaders
        COMMENT "Copying common shaders..."
    )

    # Copy GPU config
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/GPUCfg")
        add_custom_command(
            TARGET ${unit_test_name}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/GPUCfg
                    ${resources_dir}/GPUCfg
            COMMENT "Copying GPU config..."
        )
    endif()

    # Define the GPU data file path
    set(GPU_DATA_FILE
        "$<$<PLATFORM_ID:Linux>:${CMAKE_SOURCE_DIR}/Common_3/OS/Linux/steamdeck_gpu.data>"
        "$<$<PLATFORM_ID:Darwin>:${CMAKE_SOURCE_DIR}/Common_3/OS/Darwin/apple_gpu.data>"
        "$<$<PLATFORM_ID:Windows>:${CMAKE_SOURCE_DIR}/Common_3/OS/Windows/pc_gpu.data>"
        "$<$<PLATFORM_ID:Android>:${CMAKE_SOURCE_DIR}/Common_3/OS/Android/android_gpu.data>"
    )

    add_custom_command(
        TARGET ${unit_test_name}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy ${GPU_DATA_FILE} ${resources_dir}/GPUCfg/gpu.data
        COMMENT "Copying GPU data..."
    )

    # Copy fonts
    add_custom_command(
        TARGET ${unit_test_name}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Fonts ${resources_dir}/Fonts
        COMMENT "Copying fonts..."
    )

    # Copy scripts
    add_custom_command(
        TARGET ${unit_test_name}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Scripts ${resources_dir}/Scripts
        COMMENT "Copying scripts..."
    )
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/Scripts")
        add_custom_command(
            TARGET ${unit_test_name}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/Scripts
                    ${resources_dir}/Scripts
            COMMENT "Copying scripts..."
        )
    endif()

    if(LINUX)
        # Copy Vulkan utilities
        add_custom_command(
            TARGET ${unit_test_name}
            POST_BUILD
            COMMAND
                rsync -u -r --include '*.so' --include '*.json' --exclude '*'
                ${CMAKE_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/VulkanSDK/bin/Linux/
                ${resources_dir}/
            COMMENT "Copying Vulkan utilities..."
        )
    endif()
endfunction()
