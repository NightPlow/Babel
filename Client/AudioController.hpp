//
// Created by alex on 9/8/19.
//

#ifndef BABEL_AUDIO_HPP
#define BABEL_AUDIO_HPP

#include "AudioControllerError.hpp"
#include "SoundManager.hpp"
#include <exception>
#include <memory>
#include <portaudio.h>
#include <vector>

class AudioController {
public:
    // Initialize the AudioController can fail and throw `AudioControllerError`.
    AudioController();

    ~AudioController();

    // Get number version of the program.
    static int getVersion() { return Pa_GetVersion(); }

    // Get text version of the program.
    static std::string getTextVersion() { return std::string(Pa_GetVersionText()); }

    [[nodiscard]] std::vector<const PaDeviceInfo*> getDevicesInfo() const;

    [[nodiscard]] std::unique_ptr<SoundManager> createManager() const;

    [[nodiscard]] const PaDeviceInfo* getDefaultInputDevice() const;

    [[nodiscard]] const PaDeviceInfo* getDefaultOutputDevice() const;

    [[nodiscard]] int getDefaultOutputId() const;

    [[nodiscard]] int getDefaultInputId() const;

    inline void sleep(long ms) { Pa_Sleep(ms); }
};

#endif // BABEL_AUDIO_HPP
