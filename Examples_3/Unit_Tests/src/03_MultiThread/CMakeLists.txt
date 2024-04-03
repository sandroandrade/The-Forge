tf_add_unit_test(03_MultiThread 03_MultiThread.cpp)

include(TheForgeUtils)
determine_resources_dir("03_MultiThread" resources_dir)

# Copy textures
add_custom_command(
    TARGET 03_MultiThread
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/dds/ ${resources_dir}/Textures/
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/dds/ ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)
