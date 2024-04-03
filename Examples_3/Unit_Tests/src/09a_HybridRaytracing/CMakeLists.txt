tf_add_unit_test(
    09a_HybridRaytracing 09a_HybridRaytracing.cpp ../../../Visibility_Buffer/src/SanMiguel.h
    ../../../Visibility_Buffer/src/SanMiguel.cpp
)

include(TheForgeUtils)
determine_resources_dir("09a_HybridRaytracing" resources_dir)

# Copy textures
add_custom_command(
    TARGET 09a_HybridRaytracing
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/../../Art/SanMiguel_3/Textures/dds/
        ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)

# Copy meshes
add_custom_command(
    TARGET 09a_HybridRaytracing
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/../../Art/SanMiguel_3/Meshes/ ${resources_dir}/Meshes/
    COMMENT "Copying meshes..."
)
