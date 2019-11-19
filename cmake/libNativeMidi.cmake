 # Native MIDI correctly works on Windows and macOS only.
if((WIN32 AND NOT EMSCRIPTEN) OR APPLE)
    set(NATIVE_MIDI_SUPPORTED ON)
else()
    set(NATIVE_MIDI_SUPPORTED OFF)
endif()

option(USE_MIDI_NATIVE     "Build with operating system native MIDI output support" ${NATIVE_MIDI_SUPPORTED})
if(USE_MIDI_NATIVE)
    add_definitions(-DMUSIC_MID_NATIVE)
    list(APPEND SDLMixerX_SOURCES
        ${SDLMixerX_SOURCE_DIR}/src/codecs/music_nativemidi.c
        ${SDLMixerX_SOURCE_DIR}/src/codecs/native_midi/native_midi_common.c)
    if(WIN32)
        list(APPEND SDLMixerX_SOURCES
            ${SDLMixerX_SOURCE_DIR}/src/codecs/native_midi/native_midi_win32.c)
        list(APPEND SDLMixerX_LINK_LIBS winmm)
    endif()
    if(APPLE)
        list(APPEND SDLMixerX_SOURCES
            ${SDLMixerX_SOURCE_DIR}/src/codecs/native_midi/native_midi_macosx.c)
    endif()
endif()