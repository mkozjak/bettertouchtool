async function capture() {
  let hovered_element = await get_string_variable("hovered_element_details")
  const regex =
    /AXFrame:\s+"x=(\d+(?:\.\d+)?) y=(\d+(?:\.\d+)?) w=(\d+(?:\.\d+)?) h=(\d+(?:\.\d+)?)/m;

  const match = regex.exec(hovered_element)

  if (match) {
    const [, x, y, w, h] = match

    await trigger_action({
      json: JSON.stringify({
        BTTIsPureAction: 1,
        BTTPredefinedActionType: 169,
        BTTPredefinedActionName: 'Capture Screenshot (Configurable)',
        BTTScreenshotOptions: `-R;;${x},${y},${w},${h};;-c;;-t;;png;;-u;;\/Users\/mkozjak\/Desktop\/Screenshot_{datetime}_{random}.png;;`,
        BTTScreenshotDateFormat: 'yyyy-MM-dd HH.mm.ss',
      }),
      wait_for_reply: false
    })

    // await trigger_action({
    //   json: JSON.stringify({
    //     BTTIsPureAction: 1,
    //     BTTPredefinedActionType: 254,
    //     BTTPredefinedActionName: 'Show HUD Overlay',
    //     BTTHUDActionConfiguration: '{\"BTTActionHUDBlur\":0,\"BTTActionHUDBackground\":\"255.000000, 64.462059, 255.000000, 88.916210\",\"BTTIconConfigResizeImage\":0,\"BTTIconConfigImageHeight\":100,\"BTTActionHUDPosition\":6,\"BTTActionHUDDetail\":\"\",\"BTTActionHUDDuration\":100,\"BTTActionHUDCloseOnClick\":1,\"BTTActionHUDDisplayToUse\":1,\"BTTIconConfigImageWidth\":100,\"BTTActionHUDSlideDirection\":0,\"BTTActionHUDHideWhenOtherHUDAppears\":false,\"BTTActionHUDAttributedTitle\":\"{\\\\rtf1\\\\ansi\\\\ansicpg1252\\\\cocoartf2822\\n\\\\cocoatextscaling0\\\\cocoaplatform0{\\\\fonttbl}\\n{\\\\colortbl;\\\\red255\\\\green255\\\\blue255;}\\n{\\\\*\\\\expandedcolortbl;;}\\n}\",\"BTTActionHUDWidth\":220,\"BTTActionHUDBorderWidth\":0,\"BTTActionHUDTitle\":\"\",\"BTTActionHUDHeight\":220}',
    //   }),
    //   wait_for_reply: true
    // })

    // let screenshot_command = `/usr/sbin/screencapture -c -R ${x},${y},${w},${h}`

    // let cfg_screenshot = {
    //   script: screenshot_command,
    //   launchPath: "/bin/bash",
    //   parameters: "-c",
    // }

    // await runShellScript(cfg_screenshot);
  }
}
