cmake_minimum_required(VERSION 3.5)

project(The-Forge LANGUAGES CXX C ASM)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_UNIT_TESTS "Build The-Forge's example programs" OFF)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(TheForgeUtils)

if(BUILD_UNIT_TESTS AND NOT EXISTS ${CMAKE_SOURCE_DIR}/Art)
    message(
        STATUS
            "Downloading art assets, please grab a cup of coffee and wait a few minutes. This will be executed only once!"
    )
    if(WIN32)
        execute_process(COMMAND ${CMAKE_SOURCE_DIR}/PRE_BUILD.bat)
    else()
        execute_process(COMMAND chmod +x ${CMAKE_SOURCE_DIR}/PRE_BUILD.command)
        execute_process(COMMAND ${CMAKE_SOURCE_DIR}/PRE_BUILD.command)
    endif()
endif()

set(RENDERER_SRC
    # cmake-format: sortable
    Common_3/Game/ThirdParty/OpenSource/flecs/flecs.c
    Common_3/Game/ThirdParty/OpenSource/flecs/flecs.h
    Common_3/Graphics/GraphicsConfig.h
    Common_3/Graphics/Interfaces/IGraphics.h
    Common_3/Graphics/Interfaces/IShaderReflection.h
    Common_3/Renderer/Interfaces/IVisibilityBuffer.h
    Common_3/Resources/ResourceLoader/Interfaces/IResourceLoader.h
)
set(RENDERER_OBJCPP_SRC
    # cmake-format: sortable
    Common_3/Graphics/CommonShaderReflection.cpp
    Common_3/Graphics/GraphicsConfig.cpp
    Common_3/Graphics/PickRenderingAPI.cpp
    Common_3/Renderer/VisibilityBuffer/VisibilityBuffer.cpp
    Common_3/Resources/ResourceLoader/ResourceLoader.cpp
)

set(OS_SRC
    # cmake-format: sortable
    Common_3/Application/CameraController.cpp
    Common_3/Application/Config.h
    Common_3/Application/Fonts/Shaders/FSL/fontstash.frag.fsl
    Common_3/Application/Fonts/Shaders/FSL/fontstash2D.vert.fsl
    Common_3/Application/Fonts/Shaders/FSL/fontstash3D.vert.fsl
    Common_3/Application/Fonts/Shaders/FSL/resources.h
    Common_3/Application/Fonts/stbtt.cpp
    Common_3/Application/Interfaces/IApp.h
    Common_3/Application/Interfaces/ICameraController.h
    Common_3/Application/Interfaces/IFont.h
    Common_3/Application/Interfaces/IInput.h
    Common_3/Application/Interfaces/IMiddleware.h
    Common_3/Application/Interfaces/IProfiler.h
    Common_3/Application/Interfaces/IScreenshot.h
    Common_3/Application/Interfaces/IUI.h
    Common_3/Application/Profiler/GpuProfiler.h
    Common_3/Application/Profiler/ProfilerBase.h
    Common_3/Application/Profiler/ProfilerHTML.h
    Common_3/Application/ThirdParty/OpenSource/imgui/imconfig.h
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui.h
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_demo.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_draw.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_internal.h
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_tables.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_widgets.cpp
    Common_3/Application/UI/Shaders/FSL/imgui.frag.fsl
    Common_3/Application/UI/Shaders/FSL/imgui.vert.fsl
    Common_3/Application/UI/Shaders/FSL/textured_mesh.frag.fsl
    Common_3/Application/UI/Shaders/FSL/textured_mesh.vert.fsl
    Common_3/Game/Interfaces/IScripting.h
    Common_3/Game/Scripting/LuaManager.cpp
    Common_3/Game/Scripting/LuaManagerImpl.cpp
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lapi.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lapi.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lauxlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lauxlib.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lbaselib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lbitlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lcode.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lcode.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lcorolib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lctype.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lctype.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldblib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldebug.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldebug.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldo.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldo.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldump.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lfunc.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lfunc.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lgc.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lgc.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/linit.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/liolib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/llex.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/llex.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/llimits.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lmathlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lmem.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lmem.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/loadlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lobject.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lobject.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lopcodes.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lopcodes.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/loslib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lparser.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lparser.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lprefix.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lstate.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lstate.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lstring.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lstring.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lstrlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ltable.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ltable.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ltablib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ltm.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ltm.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lua.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lua.hpp
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/luaconf.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lualib.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lundump.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lundump.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lutf8lib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lvm.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lvm.h
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lzio.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lzio.h
    Common_3/OS/CPUConfig.cpp
    Common_3/OS/Interfaces/IOperatingSystem.h
    Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_linux_or_android.c
    Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_linux_or_android.c
    Common_3/Resources/AnimationSystem/Animation/AnimatedObject.cpp
    Common_3/Resources/AnimationSystem/Animation/AnimatedObject.h
    Common_3/Resources/AnimationSystem/Animation/Animation.cpp
    Common_3/Resources/AnimationSystem/Animation/Animation.h
    Common_3/Resources/AnimationSystem/Animation/Clip.cpp
    Common_3/Resources/AnimationSystem/Animation/Clip.h
    Common_3/Resources/AnimationSystem/Animation/ClipController.cpp
    Common_3/Resources/AnimationSystem/Animation/ClipController.h
    Common_3/Resources/AnimationSystem/Animation/ClipMask.cpp
    Common_3/Resources/AnimationSystem/Animation/ClipMask.h
    Common_3/Resources/AnimationSystem/Animation/Rig.cpp
    Common_3/Resources/AnimationSystem/Animation/Rig.h
    Common_3/Resources/AnimationSystem/Animation/Shaders/FSL/Animation_ShaderList.fsl
    Common_3/Resources/AnimationSystem/Animation/Shaders/FSL/bone.frag.fsl
    Common_3/Resources/AnimationSystem/Animation/Shaders/FSL/bone.vert.fsl
    Common_3/Resources/AnimationSystem/Animation/Shaders/FSL/joint.frag.fsl
    Common_3/Resources/AnimationSystem/Animation/Shaders/FSL/joint.vert.fsl
    Common_3/Resources/AnimationSystem/Animation/SkeletonBatcher.h
    Common_3/Tools/Network/Network.c
    Common_3/Tools/Network/Network.h
    Common_3/Tools/ReloadServer/ReloadClient.cpp
    Common_3/Tools/ReloadServer/ReloadClient.h
    Common_3/Utilities/FileSystem/FileSystem.c
    Common_3/Utilities/FileSystem/SystemRun.c
    Common_3/Utilities/Interfaces/IFileSystem.h
    Common_3/Utilities/Interfaces/ILog.h
    Common_3/Utilities/Interfaces/IMemory.h
    Common_3/Utilities/Interfaces/IThread.h
    Common_3/Utilities/Interfaces/ITime.h
    Common_3/Utilities/Log/Log.c
    Common_3/Utilities/Log/Log.h
    Common_3/Utilities/Math/Algorithms.c
    Common_3/Utilities/Math/Algorithms.h
    Common_3/Utilities/Math/BStringHashMap.h
    Common_3/Utilities/Math/MathTypes.h
    Common_3/Utilities/Math/Random.h
    Common_3/Utilities/Math/ShaderUtilities.h
    Common_3/Utilities/Math/StbDs.c
    Common_3/Utilities/MemoryTracking/MemoryTracking.c
    Common_3/Utilities/RingBuffer.h
    Common_3/Utilities/ThirdParty/OpenSource/bstrlib/bstrlib.c
    Common_3/Utilities/ThirdParty/OpenSource/bstrlib/bstrlib.h
    Common_3/Utilities/ThirdParty/OpenSource/lz4/lz4.c
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_get_module_info.cpp
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_hook.cpp
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_lib.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTDefaultAppInterop.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTFiberContext.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTScheduler.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTThreadContext.cpp
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/debug.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/entropy_common.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/error_private.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/fse_decompress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/pool.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/threading.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/xxhash.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/zstd_common.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/huf_decompress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/zstd_ddict.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/zstd_decompress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/zstd_decompress_block.c
    Common_3/Utilities/Threading/Atomics.h
    Common_3/Utilities/Threading/ThreadSystem.c
    Common_3/Utilities/Threading/ThreadSystem.h
    Common_3/Utilities/Timer.c
    Middleware_3/PaniniProjection/Shaders/FSL/panini_projection.frag.fsl
    Middleware_3/PaniniProjection/Shaders/FSL/panini_projection.vert.fsl
    Middleware_3/PaniniProjection/Shaders/FSL/resources.h
)

set(OS_OBJCPP_SRC
    # cmake-format: sortable
    Common_3/Application/Fonts/FontSystem.cpp
    Common_3/Application/InputSystem.cpp
    Common_3/Application/Profiler/GpuProfiler.cpp
    Common_3/Application/Profiler/ProfilerBase.cpp
    Common_3/Application/RemoteControl.cpp
    Common_3/Application/Screenshot.cpp
    Common_3/Application/UI/UI.cpp
    Common_3/Game/Scripting/LuaSystem.cpp
    Common_3/OS/WindowSystem/WindowSystem.cpp
    Common_3/Resources/AnimationSystem/Animation/SkeletonBatcher.cpp
)

set(OZZ_BASE_SRC
    # cmake-format: sortable
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/containers/string.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/containers/string_archive.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/containers/vector.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/containers/vector_archive.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/endianness.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/io/archive.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/io/archive_traits.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/maths/math_archive.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/maths/math_constant.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/maths/math_ex.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/maths/simd_math_archive.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/maths/soa_math_archive.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/memory/allocator.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/base/platform.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/containers/string_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/io/archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/maths/math_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/maths/simd_math_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/maths/soa_math_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/memory/allocator.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/platform.cc
)

set(OZZ_ANIMATION_SRC
    # cmake-format: sortable
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/animation.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/blending_job.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/ik_aim_job.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/ik_two_bone_job.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/local_to_model_job.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/sampling_job.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/skeleton.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/skeleton_utils.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/track.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/track_sampling_job.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/animation/runtime/track_triggering_job.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/animation.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/animation_keyframe.h
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/blending_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/ik_aim_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/ik_two_bone_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/local_to_model_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/sampling_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/skeleton.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/skeleton_utils.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/track.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/track_sampling_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/track_triggering_job.cc
)

set(SPIRVTOOLS_SRC
    # cmake-format: sortable
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cfg.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cpp.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross_parsed_ir.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross_util.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_glsl.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_hlsl.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_msl.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_parser.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_reflect.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/SpirvTools.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/SpirvTools.h
)

set(GAINPUT_SRC
    # cmake-format: sortable
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gainput.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputAllocator.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputContainers.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputDebugRenderer.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputHelpers.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputDeltaState.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputDevice.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputDeviceBuiltIn.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputDeviceKeyboard.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputDeviceMouse.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputDevicePad.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputDeviceTouch.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputListener.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputManager.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputMap.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputInputState.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputLog.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/GainputMapFilters.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gestures/GainputButtonStickGesture.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gestures/GainputDoubleClickGesture.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gestures/GainputGestures.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gestures/GainputHoldGesture.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gestures/GainputPinchGesture.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gestures/GainputRotateGesture.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gestures/GainputSimultaneouslyDownGesture.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/gestures/GainputTapGesture.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/recorder/GainputInputPlayer.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/recorder/GainputInputRecorder.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/gainput/recorder/GainputInputRecording.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/builtin/GainputInputDeviceBuiltIn.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/builtin/GainputInputDeviceBuiltInImpl.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/builtin/GainputInputDeviceBuiltInNull.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputDev.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputDev.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputDevProtocol.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputMemoryStream.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputMemoryStream.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetAddress.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetAddress.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetConnection.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetConnection.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetListener.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetListener.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputStream.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gainput.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputAllocator.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputDeltaState.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputDevice.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputMap.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputState.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputMapFilters.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputButtonStickGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputDoubleClickGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputHoldGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputPinchGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputRotateGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputSimultaneouslyDownGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputTapGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/GainputHID.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/GainputHID.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/GainputHIDTypes.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/GainputHIDWhitelist.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/GainputHIDWhitelist.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS4Controller.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS4Controller.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS5Controller.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS5Controller.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserSwitchController.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserSwitchController.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboard.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboardImpl.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboardNull.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/keyboard/GainputKeyboardKeyNames.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/linux/GainputHelpersEvdev.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/linux/GainputInputDeviceKeyboardEvdev.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/linux/GainputInputDeviceKeyboardLinux.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/linux/GainputInputDeviceMouseEvdev.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/linux/GainputInputDeviceMouseLinux.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/linux/GainputInputDeviceMouseLinuxRaw.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/linux/GainputInputDevicePadLinux.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputInputDeviceMouseImpl.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputInputDeviceMouseNull.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputMouseInfo.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePadImpl.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePadNull.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputPlayer.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputRecorder.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputRecording.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/touch/GainputInputDeviceTouch.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/touch/GainputInputDeviceTouchImpl.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/touch/GainputInputDeviceTouchNull.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/touch/GainputTouchInfo.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/windows/GainputWindows.h
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/hidapi.h
)
set(GAINPUT_OBJCPP_SRC
    # cmake-format: sortable
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputManager.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputInputDeviceMouse.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePad.cpp
)

if(LINUX)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
    pkg_check_modules(XRANDR REQUIRED xrandr)
    pkg_check_modules(LIBUDEV REQUIRED libudev)
    find_package(X11 REQUIRED)

    set(FSL_LANGUAGES "VULKAN")

    list(APPEND RENDERER_SRC Common_3/Graphics/Vulkan/Vulkan.cpp
         Common_3/Graphics/Vulkan/VulkanRaytracing.cpp Common_3/Graphics/Vulkan/VulkanShaderReflection.cpp
    )
    list(
        APPEND
        OS_SRC
        Common_3/OS/Linux/LinuxBase.cpp
        Common_3/OS/Linux/LinuxFileSystem.c
        Common_3/OS/Linux/LinuxLog.c
        Common_3/OS/Linux/LinuxThread.c
        Common_3/OS/Linux/LinuxTime.c
        Common_3/OS/Linux/LinuxWindow.cpp
        Common_3/Utilities/FileSystem/UnixFileSystem.c
        Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/huf_decompress_amd64.S
    )
    list(APPEND GAINPUT_SRC Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/linux/hid.c)

    execute_process(
        COMMAND
            chmod +x
            ${CMAKE_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/VulkanSDK/bin/Linux/glslangValidator
    )
endif()

if(WIN32)
    set(FSL_LANGUAGES "DIRECT3D12")

    if(MSVC)
        add_compile_options(/wd4996)
    endif()

    list(
        APPEND
        RENDERER_SRC
        Common_3/Graphics/Direct3D11/Direct3D11.cpp
        Common_3/Graphics/Direct3D11/Direct3D11ShaderReflection.cpp
        Common_3/Graphics/Direct3D12/Direct3D12.cpp
        Common_3/Graphics/Direct3D12/Direct3D12Hooks.cpp
        Common_3/Graphics/Direct3D12/Direct3D12Raytracing.cpp
        Common_3/Graphics/Direct3D12/Direct3D12ShaderReflection.cpp
    )
    list(
        APPEND
        OS_SRC
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_windows.c
        Common_3/OS/Windows/WindowsBase.cpp
        Common_3/OS/Windows/WindowsFileSystem.cpp
        Common_3/OS/Windows/WindowsLog.c
        Common_3/OS/Windows/WindowsThread.c
        Common_3/OS/Windows/WindowsTime.c
        Common_3/OS/Windows/WindowsWindow.cpp
    )
    list(APPEND GAINPUT_SRC
         Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/windows/hid.c
    )
endif()

if(APPLE)
    if(IOS)
        set(FSL_LANGUAGES "IOS")
    else()
        find_library(IOKIT_LIBRARY IOKit)
        find_library(APPKIT_LIBRARY AppKit)
        find_library(METAL_LIBRARY Metal)
        find_library(QUARTZCORE_LIBRARY QuartzCore)
        find_library(GAMECONTROLLER_LIBRARY GameController)
        find_library(MPS_LIBRARY MetalPerformanceShaders)

        set(FSL_LANGUAGES "MACOS")

        list(
            APPEND
            OS_SRC
            Common_3/OS/Darwin/DarwinLog.c
            Common_3/OS/Darwin/DarwinThread.c
            Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_iOS.c
            Common_3/Utilities/FileSystem/UnixFileSystem.c
        )
        list(APPEND OS_OBJCPP_SRC
            Common_3/OS/Darwin/CocoaFileSystem.mm
             Common_3/OS/Darwin/macOSBase.mm
             Common_3/OS/Darwin/macOSWindow.mm
        )
        list(APPEND RENDERER_OBJCPP_SRC
            Common_3/Graphics/Metal/MetalRaytracing.mm
             Common_3/Graphics/Metal/MetalRenderer.mm
             Common_3/Graphics/Metal/MetalShaderReflection.mm
        )
        list(
            APPEND
            GAINPUT_SRC
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDevicePadMac.cpp
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDeviceMouseMac.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDevicePadAppleGCKit.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDeviceKeyboardMac.cpp
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDeviceMouseMacRaw.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputMac.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/mac/hid.c
        )
        set_source_files_properties(
            ${RENDERER_OBJCPP_SRC} ${OS_OBJCPP_SRC} ${GAINPUT_OBJCPP_SRC}
            PROPERTIES COMPILE_FLAGS "-x objective-c++ -fobjc-arc"
        )
    endif()
endif()

add_library(
    Forge STATIC
    ${RENDERER_SRC}
    ${RENDERER_OBJCPP_SRC}
    ${OS_SRC}
    ${OS_OBJCPP_SRC}
    ${OZZ_BASE_SRC}
    ${OZZ_ANIMATION_SRC}
    ${GAINPUT_SRC}
    ${GAINPUT_OBJCPP_SRC}
    ${SPIRVTOOLS_SRC}
)

target_link_libraries(
    Forge
    PUBLIC
        $<$<PLATFORM_ID:Linux>:${LIBUDEV_LIBRARIES}>
        $<$<PLATFORM_ID:Linux>:${X11_LIBRARIES}>
        $<$<PLATFORM_ID:Linux>:${GTK3_LIBRARIES}>
        $<$<PLATFORM_ID:Linux>:${XRANDR_LIBRARIES}>
        $<$<PLATFORM_ID:Darwin>:${IOKIT_LIBRARY}>
        $<$<PLATFORM_ID:Darwin>:${APPKIT_LIBRARY}>
        $<$<PLATFORM_ID:Darwin>:${METAL_LIBRARY}>
        $<$<PLATFORM_ID:Darwin>:${QUARTZCORE_LIBRARY}>
        $<$<PLATFORM_ID:Darwin>:${GAMECONTROLLER_LIBRARY}>
        $<$<PLATFORM_ID:Darwin>:${MPS_LIBRARY}>
        $<$<PLATFORM_ID:Windows>:Xinput>
        $<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/Common_3/OS/ThirdParty/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.lib>
        $<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/DirectXShaderCompiler/lib/x64/dxcompiler.lib>
        $<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/ags/ags_lib/lib/amd_ags_x64.lib>
        $<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/nvapi/amd64/nvapi64.lib>
)

target_include_directories(
    Forge
    PUBLIC
        ${GTK3_INCLUDE_DIRS}
        ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Include/
)

if(BUILD_UNIT_TESTS)
    execute_process(
        COMMAND chmod +x
                ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/src/06_MaterialPlayground/compile_materials.sh
    )

    tf_add_shader(Forge ${CMAKE_SOURCE_DIR}/Middleware_3/PaniniProjection/Shaders/FSL/Panini_ShaderList.fsl)
    tf_add_shader(Forge ${CMAKE_SOURCE_DIR}/Common_3/Application/Fonts/Shaders/FSL/Fonts_ShaderList.fsl)
    tf_add_shader(Forge ${CMAKE_SOURCE_DIR}/Common_3/Application/UI/Shaders/FSL/UI_ShaderList.fsl)
    tf_add_shader(
        Forge
        ${CMAKE_SOURCE_DIR}/Common_3/Resources/AnimationSystem/Animation/Shaders/FSL/Animation_ShaderList.fsl
    )

    add_subdirectory(Examples_3/Unit_Tests/src)
endif()
