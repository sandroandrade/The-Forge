tf_add_unit_test(
    10_ScreenSpaceReflections 10_ScreenSpaceReflections.cpp ../../../Visibility_Buffer/src/SanMiguel.h
    ../../../Visibility_Buffer/src/SanMiguel.cpp
)

include(TheForgeUtils)
determine_resources_dir("10_ScreenSpaceReflections" resources_dir)

# Copy textures
add_custom_command(
    TARGET 10_ScreenSpaceReflections
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Textures/dds/
        ${resources_dir}/Textures/
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Textures/dds/LA_Helipad3D.tex
        ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)

# Copy meshes
add_custom_command(
    TARGET 10_ScreenSpaceReflections
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Meshes/ ${resources_dir}/Meshes/
    COMMENT "Copying meshes..."
)
