(async () => {
	const triggers = [
		'393B5081-AB7F-4A83-A288-0263AA13B68E', // separator
		'E6ED7E55-E8F7-48A2-9DE2-C361F43274FE', // extra strip
		'64BF1673-89F9-4FD0-95AB-42E9D226C42F', // media control
		'3E01F6DE-35D0-4D0D-A80A-768BACC838D9', // brightness control
		'1E1CA1A9-F8F0-418B-B1F5-6392A0E23825', // volume control
		'F08FE2D9-E853-4CDF-9382-4693D8AA60EC', // mute
		'B18FB05B-9D3D-4CD4-8B32-8D7393FE7E5F', // do not disturb
	]

	const foo = []

	for (let i = 0; i < triggers.length; i++) {
		const trigger = await get_trigger({uuid: triggers[i] })
		const params = JSON.parse(trigger)

		if (params.BTTEnabled2 === 1)
			await update_trigger({ uuid: triggers[i], json: JSON.stringify({ "BTTEnabled2": 0 }) })
		else
			await update_trigger({ uuid: triggers[i], json: JSON.stringify({ "BTTEnabled2": 1 }) })
	}

	returnToBTT("done")
})()
