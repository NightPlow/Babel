//
// Created by alex on 9/8/19.
//

#include "SoundStream.hpp"

#include "AudioController.hpp"
#include <utility>

SoundStream::SoundStream(double sampleRate, int numInputChannels,
    int numOutputChannels, PaSampleFormat sampleFormat,
    unsigned long framesPerBuffer,
    PaStreamCallback* streamCallback, void* linkedData,
    std::string name)
    : stream_(nullptr)
    , name_(std::move(name))
{
    int error = Pa_OpenDefaultStream(
        &stream_, numInputChannels, numOutputChannels, paFloat32, sampleRate,
        paFramesPerBufferUnspecified, streamCallback, linkedData);

    if (error != paNoError)
        throw AudioControllerError(error);
}

int SoundStream::setFinishCallback(PaStreamFinishedCallback* finishCallback)
{
    int error = Pa_SetStreamFinishedCallback(stream_, finishCallback);

    throw AudioControllerError(error);
}

SoundStream::~SoundStream() { Pa_CloseStream(stream_); }

void SoundStream::start() const
{
    int error = Pa_StartStream(stream_);

    if (error != paNoError)
        throw AudioControllerError(error);
}

void SoundStream::stop() const
{
    int error = Pa_StopStream(stream_);

    if (error != paNoError)
        throw AudioControllerError(error);
}

bool SoundStream::isActive() const { return Pa_IsStreamActive(stream_); }

void SoundStream::abort() const
{
    int error = Pa_AbortStream(stream_);

    if (error != paNoError)
        throw AudioControllerError(error);
}

const PaStreamInfo* SoundStream::info() const
{
    return Pa_GetStreamInfo(stream_);
}

double SoundStream::getCPULoad() const { return Pa_GetStreamCpuLoad(stream_); }

SoundStream::SoundStream(PaStreamParameters* outputStream,
    PaStreamParameters* inputStream,
    double sampleParameter, unsigned long framePerBuffer,
    PaStreamFlags streamFlags, PaStreamCallback* callback,
    void* userData, std::string name)
    : stream_(nullptr)
    , name_(std::move(name))
{
    int error = Pa_OpenStream(&stream_, inputStream, outputStream, sampleParameter,
        framePerBuffer, streamFlags, callback, userData);

    if (error != paNoError)
        throw AudioControllerError(error);
}
