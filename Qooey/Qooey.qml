// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

pragma Singleton
import QtQuick 2.15

QtObject {
    /**
     * @param color
     * @param alpha
     * @returns a color with new alpha value.
     */
    function alpha(color: color, alpha: real): color {
        return Qt.rgba(color.r, color.g, color.b, alpha);
    }

    /**
     * @param value
     * @param low1
     * @param high1
     * @param low2
     * @param high2
     * @returns remaped value
     */
    function remap(value: real, low1: real, high1: real, low2: real, high2: real): real {
        return low2 + (high2 - low2) * (value - low1) / (high1 - low1);
    }

    /**
     * @param x
     * @param a
     * @param b
     * @returns clamp value between @var a and @var b
     */
    function clamp(value: real, a: real, b: real): real {
        return Math.min(Math.max(value, a), b);
    }
}
