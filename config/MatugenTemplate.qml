pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
    id: root
    property QtObject mColors

    mColors: QtObject {
        // Primary
        readonly property color mPrimary: Colour.primary
        readonly property color mPrimaryOn: Colour.primaryOn
        readonly property color mPrimaryContainer: Colour.primaryContainer
        readonly property color mPrimaryContainerOn: Colour.primaryContainerOn

        // Secondary
        readonly property color mSecondary: Colour.secondary
        readonly property color mSecondaryOn: Colour.secondaryOn
        readonly property color mSecondaryContainer: Colour.secondaryContainer
        readonly property color mSecondaryContainerOn: Colour.secondaryContainerOn

        // Tertiary
        readonly property color mTertiary: Colour.tertiary
        readonly property color mTertiaryOn: Colour.tertiaryOn
        readonly property color mTertiaryContainer: Colour.tertiaryContainer
        readonly property color mTertiaryContainerOn: Colour.tertiaryContainerOn

        // Error
        readonly property color mError: Colour.error
        readonly property color mErrorOn: Colour.errorOn
        readonly property color mErrorContainer: Colour.errorContainer
        readonly property color mErrorContainerOn: Colour.errorContainerOn

        // Surface
        readonly property color mBackground: Colour.background
        readonly property color mBackgroundOn: Colour.backgroundOn
        readonly property color mSurface: Colour.surface
        readonly property color mSurfaceOn: Colour.surfaceOn
        readonly property color mSurfaceVariant: Colour.surfaceVariant
        readonly property color mSurfaceVariantOn: Colour.surfaceVariantOn
        readonly property color mSurfaceContainer: Colour.surfaceContainer
        readonly property color mSurfaceContainerLow: Colour.surfaceContainerLow
        readonly property color mSurfaceContainerHigh: Colour.surfaceContainerHigh
        readonly property color mSurfaceContainerHighest: Colour.surfaceContainerHighest
        readonly property color mSurfaceContainerLowest: Colour.surfaceContainerLowest

        // Outline / misc
        readonly property color mOutline: Colour.outline
        readonly property color mOutlineVariant: Colour.outlineVariant
        readonly property color mInverseSurface: Colour.inverseSurface
        readonly property color mInverseSurfaceOn: Colour.inverseSurfaceOn
        readonly property color mInversePrimary: Colour.inversePrimary
        readonly property color mShadow: Colour.shadow
        readonly property color mScrim: Colour.scrim
    }
}
