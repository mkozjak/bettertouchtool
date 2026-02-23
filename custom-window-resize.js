async function customResize() {
  // Get the focused window app name and screen size from BTT variables
  const focusedApp = await get_string_variable('focused_window_app_name')
  const focusedScreenWidth = await get_number_variable('focused_screen_width')
  const focusedScreenHeight = await get_number_variable('focused_screen_height')

  // Helper to determine if we're on the built-in display (1440x900)
  const isBuiltin = focusedScreenWidth === 1440 && focusedScreenHeight === 900

  // Per-app configs for builtin and external displays
  const configs = {
    Safari: {
      builtin: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":66,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (Builtin)'
      },
      external: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (External)'
      }
    },
    "Google Chrome": {
      builtin: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":66,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (Builtin)'
      },
      external: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (External)'
      }
    },
    iTerm2: {
      builtin: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":60,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (Builtin)'
      },
      external: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":50,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":86,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (External)'
      }
    },
    Terminal: {
      builtin: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":60,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (Builtin)'
      },
      external: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":50,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":86,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (External)'
      }
    },
    Mail: {
      builtin: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":70,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":84,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (Builtin)'
      },
      external: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":84,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (External)'
      }
    },
    Zed: {
      builtin: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":70,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (Builtin)'
      },
      external: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (External)'
      }
    },
    Ferdium: {
      builtin: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":70,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":80,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (Builtin)'
      },
      external: {
        BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":80,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
        BTTActionMoveResizeName: 'Center and Resize (External)'
      }
    }
  }

  const appConfig = configs[focusedApp]

  if (appConfig) {
    const displayType = isBuiltin ? 'builtin' : 'external'

    await trigger_action({
      json: JSON.stringify({
        BTTIsPureAction: 1,
        BTTPredefinedActionType: 251,
        BTTPredefinedActionName: 'Custom Move  or  Resize Window',
        ...appConfig[displayType]
      }),
      wait_for_reply: false
    })
  }

  return true
}
