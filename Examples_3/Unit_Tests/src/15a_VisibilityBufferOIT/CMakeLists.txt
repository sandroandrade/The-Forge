tf_add_unit_test(
    15a_VisibilityBufferOIT 15a_VisibilityBufferOIT.cpp ../../../Visibility_Buffer/src/SanMiguel.h
    ../../../Visibility_Buffer/src/SanMiguel.cpp
)

include(TheForgeUtils)
determine_resources_dir("15a_VisibilityBufferOIT" resources_dir)

# Copy textures
add_custom_command(
    TARGET 15a_VisibilityBufferOIT
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/../../Art/SanMiguel_3/Textures/dds/
        ${resources_dir}/Textures/
    COMMAND
        ${CMAKE_COMMAND} -E copy
        "${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Textures/dds/Stormtrooper_D.tex"
        "${resources_dir}/Textures/"
    COMMENT "Copying textures..."
)

# Copy meshes
add_custom_command(
    TARGET 15a_VisibilityBufferOIT
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Meshes/ ${resources_dir}/Meshes/
    COMMENT "Copying meshes..."
)

# Copy camera path
add_custom_command(
    TARGET 15a_VisibilityBufferOIT
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
            ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/cameraPath.bin ${resources_dir}/
    COMMENT "Copying camera path..."
)

# Copy animations
add_custom_command(
    TARGET 15a_VisibilityBufferOIT
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Animation/stormtrooper/animations/"
        "${resources_dir}/Animations/stormtrooper/"
    COMMAND
        ${CMAKE_COMMAND} -E copy
        "${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Animation/stormtrooper/skeleton.ozz"
        "${resources_dir}/Animations/stormtrooper/"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${resources_dir}/Meshes/stormtrooper/"
    COMMAND
        ${CMAKE_COMMAND} -E copy
        "${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Animation/stormtrooper/riggedMesh.bin"
        "${resources_dir}/Meshes/stormtrooper/"
    COMMENT "Copying animations..."
)
