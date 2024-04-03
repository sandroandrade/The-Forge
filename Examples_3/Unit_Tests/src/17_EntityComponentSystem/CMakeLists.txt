tf_add_unit_test(17_EntityComponentSystem 17_EntityComponentSystem.cpp)

include(TheForgeUtils)
determine_resources_dir("17_EntityComponentSystem" resources_dir)

# Copy textures
add_custom_command(
    TARGET 17_EntityComponentSystem
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory "${resources_dir}/Textures/"
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/dds/sprites.tex
        ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)
