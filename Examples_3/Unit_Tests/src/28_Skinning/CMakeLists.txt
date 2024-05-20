tf_add_unit_test(28_Skinning 28_Skinning.cpp)

include(TheForgeUtils)
determine_resources_dir("28_Skinning" resources_dir)

# Copy textures
add_custom_command(
    TARGET 28_Skinning
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory "${resources_dir}/Textures/"
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Textures/dds/Stormtrooper_D.tex
        ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)

# Copy animations
add_custom_command(
    TARGET 28_Skinning
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Animation/ ${resources_dir}/Meshes/
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Animation/ ${resources_dir}/Animation/
    COMMENT "Copying animations..."
)
