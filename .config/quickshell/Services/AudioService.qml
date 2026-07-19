pragma Singleton

import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property int outputVolume: sink?.audio ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool outputMuted: sink?.audio ? sink.audio.muted : true
    readonly property bool inputMuted: source?.audio ? source.audio.muted : true
    readonly property string sinkName: sink.description
    readonly property string sourceName: source.description
    readonly property string sinkType: {
        if (!sink)
            return "speaker";
        const name = (sink.name || "").toLowerCase();
        const desc = (sink.description || "").toLowerCase();
        if (name.includes("bluez") || desc.includes("bluetooth"))
            return "bluetooth";
        if (name.includes("headphone") || desc.includes("headphone") || desc.includes("headset"))
            return "headphones";
        return "speaker";
    }

    readonly property string outputIcon: {
        if (!sink || outputMuted)
            return "";
        if (sinkType === "headphones")
            return "";
        if (sinkType === "bluetooth")
            return "";
        if (outputVolume > 50)
            return "";
        if (outputVolume > 0)
            return "";
        return "";
    }

    function setVolume(volume: real) {
        if (sink?.ready && sink?.audio) {
            sink.audio.volume = volume;
        }
    }

    function toggleOutputMute() {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = !sink.audio.muted;
        }
    }

    function toggleInputMute() {
        if (source?.ready && source?.audio) {
            source.audio.muted = !source.audio.muted;
        }
    }

    PwObjectTracker {
        objects: [root.sink, root.source]
    }
}
