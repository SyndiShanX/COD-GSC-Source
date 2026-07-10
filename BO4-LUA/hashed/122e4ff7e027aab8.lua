function IsCurrentLanguageTextEqualTo(f1_arg0)
	local f1_local0 = Engine[0x8E9485024EFDB9]()
	local f1_local1
	if f1_arg0 ~= f1_local0 and (f1_arg0 ~= "english" or f1_local0 ~= "arabic_partial") and (f1_arg0 ~= "japanese" or f1_local0 ~= "japanese_full") and (f1_arg0 ~= "polish" or f1_local0 ~= "polish_full") and (f1_arg0 ~= "russian" or f1_local0 ~= "russian_full") and (f1_arg0 ~= "chinese" or f1_local0 ~= "simplifiedchinese" and f1_local0 ~= "traditionalchinese" and f1_local0 ~= "safechinese") then
		f1_local1 = false
	else
		f1_local1 = true
	end
	return f1_local1
end
function GetKillsAndOrDestroyedStat(f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = f2_arg1
	if Engine[0x86DC0510B2E2933](f2_arg0, Enum[0x6EB546760F890D2][0x569E84652131CD7], CoD.GetCombatRecordMode()) == "weapon_launcher" then
		f2_local0 = f2_arg1 + f2_arg2
	end
	return f2_local0
end
function GetSocialCachedValue(f3_arg0, f3_arg1)
	local f3_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), f3_arg0)
	return f3_local0 and Engine[0x614D394F6F9A18D](f3_local0)
end
function GetAttachmentMenuSelectTitle(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.perController[f4_arg0].classModel
	local f4_local1 = Engine[0xED84C33EC5F01EA](f4_arg2)
	if f4_local0 then
		local f4_local2 = Engine[0x40E824FE270E174](f4_local0, f4_arg1)
		if f4_local2 then
			f4_local1 = Engine[0x614D394F6F9A18D](f4_local2) .. " " .. f4_local1
		end
	end
	return f4_local1
end
function GetItemImageForIndex(f5_arg0, f5_arg1, f5_arg2)
	if not f5_arg1 then
		f5_arg1 = Enum[0x6EB546760F890D2][0x3057ABF96AF8289]
	end
	if not f5_arg2 then
		f5_arg2 = Engine[0x3EAC408F958FF05]()
	end
	return Engine[0x8518E07C1C5BC6D](f5_arg0, f5_arg1, f5_arg2)
end
function GetItemNameForIndex(f6_arg0, f6_arg1, f6_arg2)
	if not f6_arg1 then
		f6_arg1 = Enum[0x6EB546760F890D2][0x3057ABF96AF8289]
	end
	if not f6_arg2 then
		f6_arg2 = Engine[0x3EAC408F958FF05]()
	end
	return Engine[0x6B7AC889104DED3](f6_arg0, f6_arg1, f6_arg2)
end
function GetItemDescForIndex(f7_arg0, f7_arg1, f7_arg2)
	if not f7_arg1 then
		f7_arg1 = Enum[0x6EB546760F890D2][0x3057ABF96AF8289]
	end
	if not f7_arg2 then
		f7_arg2 = Engine[0x3EAC408F958FF05]()
	end
	return Engine[0x3E0DA351EF48521](f7_arg0, f7_arg1, f7_arg2)
end
function GetMedalInfo(f8_arg0)
	if f8_arg0 then
		return Engine[0xE00B2F29271C60B](Engine[0xC6F8EC444864600](CoD.scoreInfoTable, f8_arg0, CoD.AARUtility.medalrefCol))
	else
	end
end
function GetPresenceString(f9_arg0)
	local f9_local0 = tonumber(f9_arg0.presence)
	local f9_local1 = CoD.LobbyUtility.Presence.Strings[f9_local0]
	if f9_local1 ~= nil then
		if f9_local0 == Enum[0x4BBA402DE649132][0x322CC5E9D503B12] or f9_local0 == Enum[0x4BBA402DE649132][0x36C3C9302013104] or f9_local0 == Enum[0x4BBA402DE649132][0x4871D036CE76516] then
			local f9_local2 = CoD.MapUtility.GetMapValueFromMapId(f9_arg0.mapid, "mapName", 0x3949D949A3E82CF)
			local f9_local3 = Engine[0xEA74FA7EE46E195](Engine[0x940731389BA0418](f9_arg0.gametype))
			local f9_local4
			if f9_local3 then
				f9_local4 = f9_local3.nameRef
				if not f9_local4 then
				else
					return Engine[0xF9F1239CFD921FE](f9_local1, f9_local4, f9_local2)
				end
			end
			f9_local4 = ""
		elseif f9_local0 == Enum[0x4BBA402DE649132][0x36C3C9302013104] then
			return Engine[0xF9F1239CFD921FE](f9_local1, mapNameString)
		elseif f9_local0 == Enum[0x4BBA402DE649132][0x9416FBBD255A16A] or f9_local0 == Enum[0x4BBA402DE649132][0xF94CFF7D3FA72DC] then
			local f9_local2 = CoD.MapUtility.GetMapValueFromMapId(f9_arg0.mapid, "mapName", 0x3949D949A3E82CF)
			local f9_local3 = Engine[0xEA74FA7EE46E195](Engine[0x940731389BA0418](f9_arg0.gametype))
			local f9_local4
			if f9_local3 then
				f9_local4 = f9_local3.nameRef
				if not f9_local4 then
				else
					return Engine[0xF9F1239CFD921FE](f9_local1, f9_local4, f9_local2)
				end
			end
			f9_local4 = ""
		elseif f9_local0 == Enum[0x4BBA402DE649132][0xB076B46FC30D568] or f9_local0 == Enum[0x4BBA402DE649132][0xBDCE30A7024A319] or f9_local0 == Enum[0x4BBA402DE649132][0xA1D6A588ADE03B0] or f9_local0 == Enum[0x4BBA402DE649132][0x89F4CB04C20BE96] or f9_local0 == Enum[0x4BBA402DE649132][0x1F2CBBDAF02CDFB] or f9_local0 == Enum[0x4BBA402DE649132][0xAA08BA358D14172] then
			local f9_local2 = f9_arg0.modeparam
			if f9_local2 == nil then
				f9_local2 = 0
			end
			return Engine[0xF9F1239CFD921FE](f9_local1, f9_local2)
		elseif f9_local0 == Enum[0x4BBA402DE649132][0xF69882510317719] then
			local f9_local2 = CoD.MapUtility.GetMapValueFromMapId(f9_arg0.mapid, "mapName", 0x3949D949A3E82CF)
			local f9_local3 = Engine[0xEA74FA7EE46E195](Engine[0x940731389BA0418](f9_arg0.gametype))
			local f9_local4
			if f9_local3 then
				f9_local4 = f9_local3.nameRef
				if not f9_local4 then
				else
					return Engine[0xF9F1239CFD921FE](f9_local1, f9_local4, f9_local2)
				end
			end
			f9_local4 = ""
		else
			return Engine[0xF9F1239CFD921FE](f9_local1)
		end
	else
		return Engine[0xF9F1239CFD921FE](0x2C79EA24AB1A2BA)
	end
end
function GetPresenceActivityString(f10_arg0)
	local f10_local0 = tonumber(f10_arg0.activity)
	local f10_local1 = CoD.LobbyUtility.Presence.ActivityStrings[f10_local0]
	if f10_local1 ~= nil then
		local f10_local2 = CoD.MapUtility.GetMapValueFromMapId(f10_arg0.mapid, "mapName", 0x3949D949A3E82CF)
		local f10_local3 = Engine[0xED84C33EC5F01EA](f10_local2)
		if f10_local0 == Enum[0xD75FB136CB17239][0x64B773BEE133CC6] then
			return Engine[0xF9F1239CFD921FE](f10_local1, f10_local3)
		elseif f10_local0 == Enum[0xD75FB136CB17239][0xC1055BC2928B2D4] then
			return Engine[0xF9F1239CFD921FE](f10_local1, f10_local3)
		elseif f10_local0 == Enum[0xD75FB136CB17239][0x748FD38908AA0FD] then
			local f10_local4 = f10_arg0.gametype
			if f10_local4 == CoD.SocialUtility.GetFreerunGametypeId() then
				return Engine[0xF9F1239CFD921FE](0xB684F61ABD86662, Engine[0xED84C33EC5F01EA](f10_local2))
			end
			local f10_local5 = Engine[0xEA74FA7EE46E195](Engine[0x940731389BA0418](f10_local4))
			local f10_local6
			if f10_local5 then
				f10_local6 = f10_local5.nameRef
				if not f10_local6 then
				else
					return Engine[0xF9F1239CFD921FE](f10_local1, Engine[0xF9F1239CFD921FE](f10_local6), f10_local3)
				end
			end
			f10_local6 = ""
		elseif f10_local0 == Enum[0xD75FB136CB17239][0x28985D4608133B3] then
			local f10_local4 = f10_arg0.difficulty
			if f10_local4 == nil or f10_local4 == 0 then
				f10_local4 = 1
			end
			return Engine[0xF9F1239CFD921FE](f10_local1, Engine[0xED84C33EC5F01EA](f10_local2), f10_local4)
		else
			return Engine[0xF9F1239CFD921FE](f10_local1)
		end
	else
		return Engine[0xF9F1239CFD921FE](0x2C79EA24AB1A2BA)
	end
end
function GetPresenceContextString(f11_arg0)
	local f11_local0 = tonumber(f11_arg0.context)
	local f11_local1 = CoD.LobbyUtility.Presence.ContextStrings[f11_local0]
	if f11_local1 ~= nil then
		if f11_local0 == Enum[0x51366F188DF5EA1][0xAB43F5FC3B1D47F] then
			return Engine[0xED84C33EC5F01EA](f11_local1, Engine[0xED84C33EC5F01EA](CoD.CPUtility.DIFFICULTY[f11_arg0.difficulty or 1]))
		elseif f11_local0 == Enum[0x51366F188DF5EA1][0x6E5169843F8060A] then
			return Engine[0xED84C33EC5F01EA](f11_local1, Engine[0xED84C33EC5F01EA](CoD.CPUtility.DIFFICULTY[f11_arg0.difficulty or 1]))
		elseif f11_local0 == Enum[0x51366F188DF5EA1][0xEB6BF23C3E8DF40] then
			local f11_local2 = f11_arg0.playlist or 0
			if f11_local2 > 0 then
				local f11_local3 = Engine[0x3ACB99DBAD24D55](f11_local2)
				local f11_local4 = f11_local3 and Engine[0xF9F1239CFD921FE](f11_local3.name)
				if f11_local4 ~= "" then
					local f11_local5 = ""
					if f11_local5 ~= "" then
						return Engine[0xED84C33EC5F01EA](f11_local1, f11_local5, f11_local4)
					end
				end
			end
			return Engine[0xF9F1239CFD921FE](0x228A28CED0ECC72)
		elseif f11_local0 == Enum[0x51366F188DF5EA1][0x388C548A4995338] then
			local f11_local2 = f11_arg0.gametype
			if f11_local2 == CoD.SocialUtility.GetFreerunGametypeId() then
				local f11_local5 = Engine[0xEA74FA7EE46E195](Engine[0x940731389BA0418](f11_local2))
				local f11_local6
				if f11_local5 then
					f11_local6 = f11_local5.nameRef
					if not f11_local6 then
					else
						return Engine[0xF9F1239CFD921FE](f11_local6)
					end
				end
				f11_local6 = ""
			else
				return Engine[0xED84C33EC5F01EA](f11_local1)
			end
		end
		return Engine[0xED84C33EC5F01EA](f11_local1)
	else
		return Engine[0xF9F1239CFD921FE](0x2C79EA24AB1A2BA)
	end
end
function ShouldShowObjectiveForPlayer(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = Dvar[0xFF54369D6573B91]:get()
	if f12_local0 ~= nil then
		if f12_local0 == "bounty" then
			return true
		elseif f12_local0 == "control" then
			return true
		elseif f12_local0 == "ctf" then
			if Engine[0x626F871BFD9CF11](f12_arg0, f12_arg2.id) == f12_arg1 then
				return true
			end
		elseif f12_local0 == "dom" then
			if Engine[0x4C77EAF5F088DC3](f12_arg0, f12_arg2.id) == Engine[0x2C6B07FD023877B](f12_arg0, f12_arg1) then
				return false
			else
				return true
			end
		elseif f12_local0 == "dem" then
			return true
		elseif f12_local0 == "koth" then
			return true
		elseif f12_local0 == "sd" or f12_local0 == "sd_hc" then
			return true
		elseif f12_local0 == "ball" then
			if Engine[0x626F871BFD9CF11](f12_arg0, f12_arg2.id) == f12_arg1 then
				return true
			end
		elseif f12_local0 == "escort" and Engine[0x4C77EAF5F088DC3](f12_arg0, f12_arg2.id) == Engine[0x2C6B07FD023877B](f12_arg0, f12_arg1) then
			return true
		end
	end
	return false
end
function ShouldShowColorForObjective(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = Dvar[0xFF54369D6573B91]:get()
	if f13_local0 ~= nil and f13_local0 == "ball" then
		return false
	else
		return true
	end
end
function ValidateEmblemBackground(f14_arg0, f14_arg1)
	if Engine[0xD2D36C934E11EA1](f14_arg0, f14_arg1) then
		local f14_local0 = 0
		SetEmblemBackground_Internal(f14_arg0, f14_local0)
		if not IsLive() then
			Engine[0x16C9486C6451EEE](f14_arg0)
		else
			CoD.CraftUtility.UploadPublicProfile(nil, f14_arg0)
		end
		return f14_local0
	else
		return f14_arg1
	end
end
