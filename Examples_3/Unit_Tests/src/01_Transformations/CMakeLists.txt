tf_add_unit_test(01_Transformations 01_Transformations.cpp)

include(TheForgeUtils)
determine_resources_dir("01_Transformations" resources_dir)

# Copy textures
add_custom_command(
    TARGET 01_Transformations
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/dds/ ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)
