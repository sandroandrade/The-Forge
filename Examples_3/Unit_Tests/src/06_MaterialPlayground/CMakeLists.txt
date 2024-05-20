tf_add_unit_test(06_MaterialPlayground 06_MaterialPlayground.cpp)

include(TheForgeUtils)
determine_resources_dir("06_MaterialPlayground" resources_dir)

# Copy textures
add_custom_command(
    TARGET 06_MaterialPlayground
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/PBR/dds/ ${resources_dir}/Textures/PBR/
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Textures/dds/LA_Helipad3D.tex
        ${resources_dir}/Textures/
    COMMENT "Copying textures..."
)

# Copy meshes
add_custom_command(
    TARGET 06_MaterialPlayground
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Meshes/ ${resources_dir}/Meshes/
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Hair/ ${resources_dir}/Meshes/Hair/
    COMMENT "Copying meshes..."
)

# Copy animations
add_custom_command(
    TARGET 06_MaterialPlayground
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/Art/UnitTestResources/Animation/ ${resources_dir}/Animation/
    COMMENT "Copying animations..."
)

set(FORGE_MATERIAL_COMPILER
    "${CMAKE_SOURCE_DIR}/Common_3/Tools/ForgeMaterialCompiler/forge_material_compiler.py"
)

# Compile materials
add_custom_command(
    TARGET 06_MaterialPlayground
    POST_BUILD
    COMMAND
        ${Python_EXECUTABLE} "${FORGE_MATERIAL_COMPILER}" -d
        "${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/src/06_MaterialPlayground/Materials" -o
        "${resources_dir}/CompiledMaterials/" --verbose
    COMMENT "Compiling materials..."
)
