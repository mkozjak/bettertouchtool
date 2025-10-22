async function customResize() {
  // Get the focused window app name from BTT variable
  const focusedApp = await get_string_variable('focused_window_app_name')

  // Room for per-app configs
  // Define your configs here
  const configs = {
    Safari: {
      BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
      BTTActionMoveResizeName: 'Center and Resize'
    },
    iTerm2: {
      BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":50,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":86,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
      BTTActionMoveResizeName: 'Center and Resize'
    },
    Mail: {
      BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":84,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
      BTTActionMoveResizeName: 'Center and Resize'
    },
    Zed: {
      BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":96,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
      BTTActionMoveResizeName: 'Center and Resize'
    },
    Ferdium: {
      BTTActionMoveResizeConfig: '{"BTTOriginDisplay":0,"BTTChangeYOriginRelative":0,"BTTScreenOrigin":0,"BTTDirectionToMove":0,"BTTChangeHeightRelative":1,"BTTScreensToMove":-1,"BTTNewYAbsolute":1,"BTTNewXRelative":0,"BTTOriginToUse":0,"BTTNewWindowWidthRelative":56,"BTTChangeWindowWidth":true,"BTTNewWindowWidthAbsoluteAddition":0,"BTTNewXAbsolute":1,"BTTNewWindowHeightAbsoluteAddition":0,"BTTUseVisibleFrame":true,"BTTChangeYOrigin":1,"BTTCareForStageManager":false,"BTTChangeXOriginRelative":0,"BTTChangeWidthRelative":1,"BTTActiveOrHoveredWindow":0,"BTTNewWindowHeightRelative":80,"BTTChangeWindowHeight":true,"BTTNewYRelative":0,"BTTChangeXOrigin":1}',
      BTTActionMoveResizeName: 'Center and Resize'
    }
  }

  switch (focusedApp) {
    case 'Safari':
      await trigger_action({
        json: JSON.stringify({
          BTTIsPureAction: 1,
          BTTPredefinedActionType: 251,
          BTTPredefinedActionName: 'Custom Move  or  Resize Window',
          ...configs.Safari
        }),
        wait_for_reply: false
      })

      break
    case 'iTerm2':
      await trigger_action({
        json: JSON.stringify({
          BTTIsPureAction: 1,
          BTTPredefinedActionType: 251,
          BTTPredefinedActionName: 'Custom Move  or  Resize Window',
          ...configs.iTerm2
        }),
        wait_for_reply: false
      })

      break
    case 'Mail':
      await trigger_action({
        json: JSON.stringify({
          BTTIsPureAction: 1,
          BTTPredefinedActionType: 251,
          BTTPredefinedActionName: 'Custom Move  or  Resize Window',
          ...configs.Mail
        }),
        wait_for_reply: false
      })

      break
    case 'Zed':
      await trigger_action({
        json: JSON.stringify({
          BTTIsPureAction: 1,
          BTTPredefinedActionType: 251,
          BTTPredefinedActionName: 'Custom Move  or  Resize Window',
          ...configs.Zed
        }),
        wait_for_reply: false
      })

      break
      break
    case 'Ferdium':
      await trigger_action({
        json: JSON.stringify({
          BTTIsPureAction: 1,
          BTTPredefinedActionType: 251,
          BTTPredefinedActionName: 'Custom Move  or  Resize Window',
          ...configs.Ferdium
        }),
        wait_for_reply: false
      })

      break
  }

  return true
}
