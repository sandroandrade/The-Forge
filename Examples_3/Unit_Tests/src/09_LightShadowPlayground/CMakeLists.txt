tf_add_unit_test(
    09_LightShadowPlayground 09_LightShadowPlayground.cpp ../../../Visibility_Buffer/src/SanMiguel.h
    ../../../Visibility_Buffer/src/SanMiguel.cpp ../../../Visibility_Buffer/src/SanMiguelSDF.h
    ../../../Visibility_Buffer/src/SanMiguelSDF.cpp
)

include(TheForgeUtils)
determine_resources_dir("09_LightShadowPlayground" resources_dir)

# Copy textures
add_custom_command(
    TARGET 09_LightShadowPlayground
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Textures/dds/
            ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)

# Copy meshes
add_custom_command(
    TARGET 09_LightShadowPlayground
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Meshes/
            ${resources_dir}/Meshes/
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/SDF/ ${resources_dir}/SDF/
    COMMENT "Copying meshes..."
)
