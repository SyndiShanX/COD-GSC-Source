function IsCurrentLanguageTextEqualTo(f1_arg0)
	local f1_local0 = Engine[@"getlanguage"]()
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
	if Engine[@"getitemgroup"](f2_arg0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], CoD.GetCombatRecordMode()) == "weapon_launcher" then
		f2_local0 = f2_arg1 + f2_arg2
	end
	return f2_local0
end
function GetSocialCachedValue(f3_arg0, f3_arg1)
	local f3_local0 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), f3_arg0)
	return f3_local0 and Engine[@"getmodelvalue"](f3_local0)
end
function GetAttachmentMenuSelectTitle(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.perController[f4_arg0].classModel
	local f4_local1 = Engine[@"localize"](f4_arg2)
	if f4_local0 then
		local f4_local2 = Engine[@"getmodel"](f4_local0, f4_arg1)
		if f4_local2 then
			f4_local1 = Engine[@"getmodelvalue"](f4_local2) .. " " .. f4_local1
		end
	end
	return f4_local1
end
function GetItemImageForIndex(f5_arg0, f5_arg1, f5_arg2)
	if not f5_arg1 then
		f5_arg1 = Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"]
	end
	if not f5_arg2 then
		f5_arg2 = Engine[@"currentsessionmode"]()
	end
	return Engine[@"getitemimage"](f5_arg0, f5_arg1, f5_arg2)
end
function GetItemNameForIndex(f6_arg0, f6_arg1, f6_arg2)
	if not f6_arg1 then
		f6_arg1 = Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"]
	end
	if not f6_arg2 then
		f6_arg2 = Engine[@"currentsessionmode"]()
	end
	return Engine[@"getitemname"](f6_arg0, f6_arg1, f6_arg2)
end
function GetItemDescForIndex(f7_arg0, f7_arg1, f7_arg2)
	if not f7_arg1 then
		f7_arg1 = Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"]
	end
	if not f7_arg2 then
		f7_arg2 = Engine[@"currentsessionmode"]()
	end
	return Engine[@"getitemdesc"](f7_arg0, f7_arg1, f7_arg2)
end
function GetMedalInfo(f8_arg0)
	if f8_arg0 then
		return Engine[@"hash_2E00B2F29271C60B"](Engine[@"hash_4C6F8EC444864600"](CoD.scoreInfoTable, f8_arg0, CoD.AARUtility.medalrefCol))
	else
	end
end
function GetPresenceString(f9_arg0)
	local f9_local0 = tonumber(f9_arg0.presence)
	local f9_local1 = CoD.LobbyUtility.Presence.Strings[f9_local0]
	if f9_local1 ~= nil then
		if f9_local0 == Enum[@"presencetitle"][@"hash_2322CC5E9D503B12"] or f9_local0 == Enum[@"presencetitle"][@"hash_436C3C9302013104"] or f9_local0 == Enum[@"presencetitle"][@"hash_74871D036CE76516"] then
			local f9_local2 = CoD.MapUtility.GetMapValueFromMapId(f9_arg0.mapid, "mapName", @"menu/map")
			local f9_local3 = Engine[@"getgametypeinfo"](Engine[@"getgametypenameforid"](f9_arg0.gametype))
			local f9_local4
			if f9_local3 then
				f9_local4 = f9_local3.nameRef
				if not f9_local4 then
				else
					return Engine[@"hash_4F9F1239CFD921FE"](f9_local1, f9_local4, f9_local2)
				end
			end
			f9_local4 = ""
		elseif f9_local0 == Enum[@"presencetitle"][@"hash_436C3C9302013104"] then
			return Engine[@"hash_4F9F1239CFD921FE"](f9_local1, mapNameString)
		elseif f9_local0 == Enum[@"presencetitle"][@"hash_29416FBBD255A16A"] or f9_local0 == Enum[@"presencetitle"][@"hash_6F94CFF7D3FA72DC"] then
			local f9_local2 = CoD.MapUtility.GetMapValueFromMapId(f9_arg0.mapid, "mapName", @"menu/map")
			local f9_local3 = Engine[@"getgametypeinfo"](Engine[@"getgametypenameforid"](f9_arg0.gametype))
			local f9_local4
			if f9_local3 then
				f9_local4 = f9_local3.nameRef
				if not f9_local4 then
				else
					return Engine[@"hash_4F9F1239CFD921FE"](f9_local1, f9_local4, f9_local2)
				end
			end
			f9_local4 = ""
		elseif f9_local0 == Enum[@"presencetitle"][@"hash_2B076B46FC30D568"] or f9_local0 == Enum[@"presencetitle"][@"hash_3BDCE30A7024A319"] or f9_local0 == Enum[@"presencetitle"][@"hash_7A1D6A588ADE03B0"] or f9_local0 == Enum[@"presencetitle"][@"hash_689F4CB04C20BE96"] or f9_local0 == Enum[@"presencetitle"][@"hash_51F2CBBDAF02CDFB"] or f9_local0 == Enum[@"presencetitle"][@"hash_3AA08BA358D14172"] then
			local f9_local2 = f9_arg0.modeparam
			if f9_local2 == nil then
				f9_local2 = 0
			end
			return Engine[@"hash_4F9F1239CFD921FE"](f9_local1, f9_local2)
		elseif f9_local0 == Enum[@"presencetitle"][@"hash_4F69882510317719"] then
			local f9_local2 = CoD.MapUtility.GetMapValueFromMapId(f9_arg0.mapid, "mapName", @"menu/map")
			local f9_local3 = Engine[@"getgametypeinfo"](Engine[@"getgametypenameforid"](f9_arg0.gametype))
			local f9_local4
			if f9_local3 then
				f9_local4 = f9_local3.nameRef
				if not f9_local4 then
				else
					return Engine[@"hash_4F9F1239CFD921FE"](f9_local1, f9_local4, f9_local2)
				end
			end
			f9_local4 = ""
		else
			return Engine[@"hash_4F9F1239CFD921FE"](f9_local1)
		end
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_2C79EA24AB1A2BA")
	end
end
function GetPresenceActivityString(f10_arg0)
	local f10_local0 = tonumber(f10_arg0.activity)
	local f10_local1 = CoD.LobbyUtility.Presence.ActivityStrings[f10_local0]
	if f10_local1 ~= nil then
		local f10_local2 = CoD.MapUtility.GetMapValueFromMapId(f10_arg0.mapid, "mapName", @"menu/map")
		local f10_local3 = Engine[@"localize"](f10_local2)
		if f10_local0 == Enum[@"presenceactivity"][@"presence_activity_cp_playing_coop_on_map"] then
			return Engine[@"hash_4F9F1239CFD921FE"](f10_local1, f10_local3)
		elseif f10_local0 == Enum[@"presenceactivity"][@"presence_activity_cp_playing_solo_on_map"] then
			return Engine[@"hash_4F9F1239CFD921FE"](f10_local1, f10_local3)
		elseif f10_local0 == Enum[@"presenceactivity"][@"presence_activity_mp_playing_gmode_on_map"] then
			local f10_local4 = f10_arg0.gametype
			if f10_local4 == CoD.SocialUtility.GetFreerunGametypeId() then
				return Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B684F61ABD86662", Engine[@"localize"](f10_local2))
			end
			local f10_local5 = Engine[@"getgametypeinfo"](Engine[@"getgametypenameforid"](f10_local4))
			local f10_local6
			if f10_local5 then
				f10_local6 = f10_local5.nameRef
				if not f10_local6 then
				else
					return Engine[@"hash_4F9F1239CFD921FE"](f10_local1, Engine[@"hash_4F9F1239CFD921FE"](f10_local6), f10_local3)
				end
			end
			f10_local6 = ""
		elseif f10_local0 == Enum[@"presenceactivity"][@"presence_activity_zm_playing_map_on_round"] then
			local f10_local4 = f10_arg0.difficulty
			if f10_local4 == nil or f10_local4 == 0 then
				f10_local4 = 1
			end
			return Engine[@"hash_4F9F1239CFD921FE"](f10_local1, Engine[@"localize"](f10_local2), f10_local4)
		else
			return Engine[@"hash_4F9F1239CFD921FE"](f10_local1)
		end
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_2C79EA24AB1A2BA")
	end
end
function GetPresenceContextString(f11_arg0)
	local f11_local0 = tonumber(f11_arg0.context)
	local f11_local1 = CoD.LobbyUtility.Presence.ContextStrings[f11_local0]
	if f11_local1 ~= nil then
		if f11_local0 == Enum[@"presencectx"][@"presence_ctx_cp_private_game"] then
			return Engine[@"localize"](f11_local1, Engine[@"localize"](CoD.CPUtility.DIFFICULTY[f11_arg0.difficulty or 1]))
		elseif f11_local0 == Enum[@"presencectx"][@"presence_ctx_cp_public_match"] then
			return Engine[@"localize"](f11_local1, Engine[@"localize"](CoD.CPUtility.DIFFICULTY[f11_arg0.difficulty or 1]))
		elseif f11_local0 == Enum[@"presencectx"][@"presence_ctx_mp_public_match"] then
			local f11_local2 = f11_arg0.playlist or 0
			if f11_local2 > 0 then
				local f11_local3 = Engine[@"getplaylistinfobyid"](f11_local2)
				local f11_local4 = f11_local3 and Engine[@"hash_4F9F1239CFD921FE"](f11_local3.name)
				if f11_local4 ~= "" then
					local f11_local5 = ""
					if f11_local5 ~= "" then
						return Engine[@"localize"](f11_local1, f11_local5, f11_local4)
					end
				end
			end
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_3228A28CED0ECC72")
		elseif f11_local0 == Enum[@"presencectx"][@"presence_ctx_mp_custom_games"] then
			local f11_local2 = f11_arg0.gametype
			if f11_local2 == CoD.SocialUtility.GetFreerunGametypeId() then
				local f11_local5 = Engine[@"getgametypeinfo"](Engine[@"getgametypenameforid"](f11_local2))
				local f11_local6
				if f11_local5 then
					f11_local6 = f11_local5.nameRef
					if not f11_local6 then
					else
						return Engine[@"hash_4F9F1239CFD921FE"](f11_local6)
					end
				end
				f11_local6 = ""
			else
				return Engine[@"localize"](f11_local1)
			end
		end
		return Engine[@"localize"](f11_local1)
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_2C79EA24AB1A2BA")
	end
end
function ShouldShowObjectiveForPlayer(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = Dvar[@"g_gametype"]:get()
	if f12_local0 ~= nil then
		if f12_local0 == "bounty" then
			return true
		elseif f12_local0 == "control" then
			return true
		elseif f12_local0 == "ctf" then
			if Engine[@"getobjectiveentity"](f12_arg0, f12_arg2.id) == f12_arg1 then
				return true
			end
		elseif f12_local0 == "dom" then
			if Engine[@"getobjectiveteam"](f12_arg0, f12_arg2.id) == Engine[@"getteamid"](f12_arg0, f12_arg1) then
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
			if Engine[@"getobjectiveentity"](f12_arg0, f12_arg2.id) == f12_arg1 then
				return true
			end
		elseif f12_local0 == "escort" and Engine[@"getobjectiveteam"](f12_arg0, f12_arg2.id) == Engine[@"getteamid"](f12_arg0, f12_arg1) then
			return true
		end
	end
	return false
end
function ShouldShowColorForObjective(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = Dvar[@"g_gametype"]:get()
	if f13_local0 ~= nil and f13_local0 == "ball" then
		return false
	else
		return true
	end
end
function ValidateEmblemBackground(f14_arg0, f14_arg1)
	if Engine[@"isemblembackgroundlocked"](f14_arg0, f14_arg1) then
		local f14_local0 = 0
		SetEmblemBackground_Internal(f14_arg0, f14_local0)
		if not IsLive() then
			Engine[@"commitprofilechanges"](f14_arg0)
		else
			CoD.CraftUtility.UploadPublicProfile(nil, f14_arg0)
		end
		return f14_local0
	else
		return f14_arg1
	end
end
