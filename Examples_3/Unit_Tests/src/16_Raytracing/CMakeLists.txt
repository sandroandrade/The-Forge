tf_add_unit_test(
    16_Raytracing 16_Raytracing.cpp ../../../Visibility_Buffer/src/SanMiguel.h
    ../../../Visibility_Buffer/src/SanMiguel.cpp
)

include(TheForgeUtils)
determine_resources_dir("16_Raytracing" resources_dir)

# Copy textures
add_custom_command(
    TARGET 16_Raytracing
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Textures/dds/
        ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)

# Copy meshes
add_custom_command(
    TARGET 16_Raytracing
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Meshes/ ${resources_dir}/Meshes/
    COMMENT "Copying meshes..."
)
