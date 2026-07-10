require("x64:53e8db3768fb02a")
Lobby.Storage = {}
Lobby.Gunsmith = {}
Lobby.Storage.OnStorageRead = function(f1_arg0)
	if f1_arg0.result ~= Enum[0x3D77E7B1DF67F2F][0xD3A42700EBC78E6] then
	else
		if f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] then
			Lobby.Stats.OnMPOnlineStatsDownloaded(f1_arg0.controller)
		elseif f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA] then
			Lobby.Stats.OnMPLoadoutsDownloaded(f1_arg0.controller, f1_arg0.fileType, "cacLoadouts")
		elseif f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0xF9A4C4451E3499E] or f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0xD062FA7B47FC13A] then
			Lobby.Stats.OnMPLoadoutsDownloaded(f1_arg0.controller, f1_arg0.fileType, "cacLoadouts")
		elseif f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0x67DF1879D992E] or f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0xCEBE62E27709AD0] then
			Lobby.Stats.OnMPLoadoutsDownloaded(f1_arg0.controller, f1_arg0.fileType, "cacLoadouts")
		elseif f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882] then
			Lobby.Stats.OnProfileCommonStatsDownloaded(f1_arg0.controller)
		elseif f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0] then
			Lobby.Stats.OnZMOnlineStatsDownloaded(f1_arg0.controller)
		end
		if f1_arg0.fileType == Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC] then
			Lobby.Stats.UpdateWZStatsCheck(f1_arg0)
		end
	end
end
Lobby.Storage.OnStorageWrite = function(f2_arg0)
	if f2_arg0.result ~= Enum[0x3D77E7B1DF67F2F][0xD3A42700EBC78E6] then
		Engine[0xDE279ECDDDD966](f2_arg0.controller, 0x7EA1B684C689794, {
			[0x8B8DE5B56F6D021] = f2_arg0.controller,
			[0x3E2AC46BE8D2A8] = f2_arg0.fileName,
			[0xAC73F17A2CAE7DB] = f2_arg0.fileType,
			[0xA771618F6FE31D1] = f2_arg0.slot,
			[0xB51CD7CD76778C4] = f2_arg0.result,
			[0x3E618BD2B303DEE] = f2_arg0.attempt,
		})
	elseif f2_arg0.fileType == Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA] then
	elseif f2_arg0.fileType == Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] then
	else
	end
end
Lobby.Storage.OnStorageWriteDispatch = function(f3_arg0)
	local f3_local0 = f3_arg0.controller
end
Lobby.Gunsmith.InitializeBuffer = function(f4_arg0)
	local f4_local0 = #f4_arg0.variant
	for f4_local1 = 0, f4_local0 - 1, 1 do
		local f4_local4 = f4_arg0.variant[f4_local1]
		f4_local4.variantIndex:set(f4_local1)
		f4_local4.paintjobSlot:set(Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5])
	end
end
Lobby.Gunsmith.ClearBuffer = function(f5_arg0)
	local f5_local0 = #f5_arg0.variant
	for f5_local1 = 0, f5_local0 - 1, 1 do
		local f5_local4 = f5_arg0.variant[f5_local1]
		f5_local4.variantName:set("")
		local f5_local5 = #f5_local4.attachment
		for f5_local6 = 0, f5_local5 - 1, 1 do
			f5_local4.attachment[f5_local6]:set(0)
		end
		f5_local4.reticleIndex:set(0)
		f5_local4.camoIndex:set(0)
		f5_local4.paintjobSlot:set(0)
		f5_local4.weaponIndex:set(0)
		f5_local4.variantIndex:set(0)
		f5_local4.sortIndex:set(0)
		f5_local4.readOnly:set(0)
		f5_local4.createTime:set(0)
	end
end
Lobby.Storage.OnInitilizeZMLoadoutBuffer = function(f6_arg0)
	local f6_local0 = Engine[0x8BF970606552F4C](f6_arg0.controller, f6_arg0.storageFileType)
	if f6_local0 then
		local f6_local1 = f6_local0.cacLoadouts
		if f6_local1 then
			Lobby.Gunsmith.ClearBuffer(f6_local1)
			Lobby.Gunsmith.InitializeBuffer(f6_local1)
		end
	end
end
Lobby.Storage.SetUninitializedEmblemBackground = function(f7_arg0)
	Lobby.Storage.BackgroundRamdomlyInitialized = true
	local f7_local0 = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
	}
	local f7_local1 = math.random(1, #f7_local0)
	local f7_local2 = Engine[0x4DF5CFBC1771947](f7_arg0)
	f7_local2 = f7_local2:create("defaultBackgroundNeeded")
	f7_local2:set(f7_local0[f7_local1])
end
Lobby.Storage.OnInitializeStats = function(f8_arg0)
	local f8_local0 = f8_arg0.controller
	local f8_local1 = f8_arg0.storageFileType
	if not Lobby.Storage.BackgroundRamdomlyInitialized then
		Lobby.Storage.SetUninitializedEmblemBackground(f8_local0)
	end
	if f8_local1 == Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] then
		local f8_local2 = Engine[0x8BF970606552F4C](f8_local0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
		f8_local2 = f8_local2.ItemStats
		local f8_local3 = Engine[0x8BF970606552F4C](f8_local0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
		f8_local3 = f8_local3.WeaponStats
		if f8_local2 then
			for f8_local4 = 1, 255, 1 do
				if Engine[0x4F26CFE792AD57C](f8_local4, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]) and Engine[0x6A28AE1C9C05372](f8_local4, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]) == 0 and not Engine[0x6250DDC418D8ABD](f8_local4, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]) then
					f8_local2[f8_local4].markedOld:set(1)
				end
			end
		end
		if f8_local3 then
			for f8_local4 = 1, 199, 1 do
				f8_local3[f8_local4].attachmentMarkedOld.clantag:set(1)
				f8_local3[f8_local4].attachmentMarkedOld.killcounter:set(1)
			end
		end
	elseif f8_local1 == Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0] then
		local f8_local2 = Engine[0x8BF970606552F4C](f8_local0, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
		f8_local2 = f8_local2.ItemStats
		if f8_local2 then
			for f8_local3 = 1, 255, 1 do
				if Engine[0x4F26CFE792AD57C](f8_local3, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) and Engine[0x6A28AE1C9C05372](f8_local3, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) == 0 and Engine[0x708EB21A8740A71](f8_local3, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) == nil then
					f8_local2[f8_local3].markedOld:set(1)
				end
			end
		end
	elseif f8_local1 == Enum[0xBBD4F9E70101BA8][0xA5B261DA142B9F6] then
		Lobby.Stats.InitializeCareerStats(f8_local0, f8_local1)
	elseif f8_local1 == Enum[0xBBD4F9E70101BA8][0xC0D6F9114852994] then
		Lobby.Stats.InitializeCareerStats(f8_local0, f8_local1)
	elseif f8_local1 == Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC] or f8_local1 == Enum[0xBBD4F9E70101BA8][0xDF87425733853AE] or f8_local1 == Enum[0xBBD4F9E70101BA8][0x7036247812689DA] or f8_local1 == Enum[0xBBD4F9E70101BA8][0x38AE20E1AEFD6F0] or f8_local1 == Enum[0xBBD4F9E70101BA8][0x9E0698F1D820882] then
		Lobby.Stats.ValidateWZCharacterSelection(f8_local0)
		if f8_local1 == Enum[0xBBD4F9E70101BA8][0xDF87425733853AE] or f8_local1 == Enum[0xBBD4F9E70101BA8][0x7036247812689DA] or f8_local1 == Enum[0xBBD4F9E70101BA8][0x38AE20E1AEFD6F0] then
			Lobby.Stats.ValidateJumpkitSelection(f8_local0, f8_local1)
		end
	end
end
Lobby.Storage.OnSettingDDLConversionInt = function(f9_arg0)
	return f9_arg0.currentValue
end
Lobby.Storage.OnSettingDDLConversionFloat = function(f10_arg0)
	if f10_arg0.settingNameHash == 0xFAAB52E587C217F and f10_arg0.fromVersion <= 71 and f10_arg0.toVersion > 71 then
		return 1
	elseif f10_arg0.settingNameHash == 0xD14AEFC49E850E6 and f10_arg0.fromVersion <= 83 and f10_arg0.toVersion > 83 then
		return 1
	elseif f10_arg0.settingNameHash == 0xB339F4869815875 and f10_arg0.fromVersion <= 83 and f10_arg0.toVersion > 83 then
		return 1
	else
		return f10_arg0.currentValue
	end
end
