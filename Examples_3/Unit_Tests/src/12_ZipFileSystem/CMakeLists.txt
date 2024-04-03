tf_add_unit_test(12_ZipFileSystem 12_ZipFileSystem.cpp)

# Copy zip files
add_custom_command(
    TARGET 12_ZipFileSystem
    POST_BUILD
    COMMAND rsync -u -r ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/ZipFilesDds/
            ${CMAKE_CURRENT_BINARY_DIR}/ZipFiles/
    COMMENT "Copying zip files..."
)
