tf_add_unit_test(15_Transparency 15_Transparency.cpp)

include(TheForgeUtils)
determine_resources_dir("15_Transparency" resources_dir)

# Copy textures
add_custom_command(
    TARGET 15_Transparency
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Textures/dds/skybox/
        ${resources_dir}/Textures/skybox/
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Textures/dds/grid.tex
        ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)

# Copy meshes
add_custom_command(
    TARGET 15_Transparency
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Meshes/ ${resources_dir}/Meshes/
    COMMENT "Copying meshes..."
)
