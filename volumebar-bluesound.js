async function drawVolumeBar() {
    const width = 16
    const volume = await get_string_variable({variable_name:'BTTLastShortcutResult'})

    // Ensure volume is between 0 and 100
    const v = Math.max(0, Math.min(100, volume))

    // Calculate filled and empty segments
    const filledSegments = Math.round((v / 100) * width)
    const emptySegments = width - filledSegments

    // Create the bar
    const filled = '▬'.repeat(filledSegments)
    const empty = '▭'.repeat(emptySegments)

    await set_string_variable({variable_name: 'CurrentVolumeBar', to: `${filled}${empty}`})
    return `${filled}${empty}`
}
