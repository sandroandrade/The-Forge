tf_add_unit_test(19_CodeHotReload 19_CodeHotReload_Main.cpp)
add_library(19a_CodeHotReload_Game SHARED 19_CodeHotReload_Game.cpp)

include(TheForgeUtils)
determine_resources_dir("19_CodeHotReload" resources_dir)

if(WIN32)
    set_target_properties(19a_CodeHotReload_Game PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${resources_dir})
endif()

# Copy textures
add_custom_command(
    TARGET 19_CodeHotReload
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory "${resources_dir}/Textures/"
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Textures/dds/sprites.tex
        ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)

install_files(19a_CodeHotReload_Game ${resources_dir})
