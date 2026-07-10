CoD.DoubleXPUtility = {}
CoD.DoubleXPUtility.SetupPromotionalXPTimer = function(f1_arg0, f1_arg1)
	if not f1_arg1.promotionalXPTimer then
		f1_arg1.promotionalXPTimer = LUI.UITimer.newElementTimer(5000, false, function()
			DataSourceHelperRecreate(f1_arg0, "PromotionalDoubleXP")
		end)
		f1_arg1:addElement(f1_arg1.promotionalXPTimer)
	end
end
CoD.DoubleXPUtility.HasPromotionalDoubleXP = function(f3_arg0)
	if not IsMultiplayer() or IsArenaMode() then
		return false
	else
		local f3_local0 = CoD.SafeGetModelValue(DataSources.PromotionalDoubleXP.getModel(f3_arg0), "dailyDoubleXPTimeLeft")
		return f3_local0 and f3_local0 > 0
	end
end
CoD.DoubleXPUtility.MainModeHasDoubleXP = function(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = f4_arg1 and LuaUtils.GetEModeForLobbyMainMode(f4_arg1)
	local f4_local1
	if f4_local0 then
		f4_local1 = Engine[0x1B220596080E841](f4_local0)
		if not f4_local1 then
		else
			local f4_local2
			if f4_local0 then
				f4_local2 = Engine[0xF4F47F17B3BDCB3](f4_arg0, f4_local1, f4_local0, f4_arg2)
				if not f4_local2 then
				else
					local f4_local3 = f4_local2
					local f4_local4 = CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleXP")
					if not f4_local4 then
						f4_local4 = f4_local3 or IsKoreaBonusXPSpecialEventActive(f4_arg0)
					end
					return f4_local4
				end
			end
			f4_local2 = Engine[0x2830A31C60932B5](f4_arg0, f4_local1, f4_arg2)
		end
	end
	f4_local1 = Engine[0x1B220596080E841]()
end
CoD.DoubleXPUtility.HasDoubleXP = function(f5_arg0, f5_arg1)
	local f5_local0 = CoD.DoubleXPUtility.MainModeHasDoubleXP(f5_arg0, f5_arg1 and CoD.SafeGetModelValue(f5_arg1:getModel(), "mode"), f5_arg1 and CoD.SafeGetModelValue(f5_arg1:getModel(), "playlist"))
	if not f5_local0 then
		f5_local0 = f5_arg1 and CoD.ModelUtility.IsSelfModelValueTrue(f5_arg1, f5_arg0, "hasDoubleXP")
	end
	return f5_local0
end
CoD.DoubleXPUtility.HasMainMode = function(f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = f6_arg1 and CoD.SafeGetModelValue(f6_arg1:getModel(), "mode")
	return (f6_local0 and LuaUtils.GetEModeForLobbyMainMode(f6_local0)) == f6_arg2
end
CoD.DoubleXPUtility.HasDoubleXPOrPromotionalDoubleXP = function(f7_arg0, f7_arg1)
	local f7_local0 = CoD.DoubleXPUtility.HasDoubleXP(f7_arg0, f7_arg1)
	if not f7_local0 then
		f7_local0 = CoD.DoubleXPUtility.HasPromotionalDoubleXP(f7_arg0)
	end
	return f7_local0
end
CoD.DoubleXPUtility.MainModeHasDoubleWeaponXP = function(f8_arg0, f8_arg1, f8_arg2)
	if f8_arg1 == Enum[0x89C1455C5032969][0x78C124999125C42] then
		return false
	end
	local f8_local0 = f8_arg1 and LuaUtils.GetEModeForLobbyMainMode(f8_arg1)
	local f8_local1
	if f8_local0 then
		f8_local1 = Engine[0x35B69F270CC2D1D](f8_local0)
		if not f8_local1 then
		else
			local f8_local2
			if f8_local0 then
				f8_local2 = Engine[0xF4F47F17B3BDCB3](f8_arg0, f8_local1, f8_local0, f8_arg2)
				if not f8_local2 then
				else
					return f8_local2 or CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleGunXP")
				end
			end
			f8_local2 = Engine[0x2830A31C60932B5](f8_arg0, f8_local1, f8_arg2)
		end
	end
	f8_local1 = Engine[0x35B69F270CC2D1D]()
end
CoD.DoubleXPUtility.HasDoubleWeaponXP = function(f9_arg0, f9_arg1)
	local f9_local0 = CoD.DoubleXPUtility.MainModeHasDoubleWeaponXP(f9_arg0, f9_arg1 and CoD.SafeGetModelValue(f9_arg1:getModel(), "mode"), f9_arg1 and CoD.SafeGetModelValue(f9_arg1:getModel(), "playlist"))
	if not f9_local0 then
		f9_local0 = f9_arg1 and CoD.ModelUtility.IsSelfModelValueTrue(f9_arg1, f9_arg0, "hasDoubleWeaponXP")
	end
	return f9_local0
end
CoD.DoubleXPUtility.HasDoubleLootXP = function(f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1 and CoD.SafeGetModelValue(f10_arg1:getModel(), "mode")
	local f10_local1 = f10_arg1 and CoD.SafeGetModelValue(f10_arg1:getModel(), "playlist")
	if f10_local0 then
		f10_local0 = LuaUtils.GetEModeForLobbyMainMode(f10_local0)
	end
	if f10_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] or CoD.StartMenuUtility.GetSessionModeFromLobby() == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return false
	else
		local f10_local2
		if f10_local0 then
			f10_local2 = Engine[0xACFE452C407B25B](f10_local0)
			if not f10_local2 then
			else
				local f10_local3
				if f10_local0 then
					f10_local3 = Engine[0xF4F47F17B3BDCB3](f10_arg0, f10_local2, f10_local0, f10_local1)
					if not f10_local3 then
					else
						local f10_local4 = f10_local3
						local f10_local5 = CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleLootXP")
						if not f10_local5 then
							f10_local5 = f10_local4 or IsKoreaBonusXPSpecialEventActive(f10_arg0)
						end
						return f10_local5
					end
				end
				f10_local3 = Engine[0x2830A31C60932B5](f10_arg0, f10_local2, f10_local1)
			end
		end
	end
	f10_local2 = Engine[0xACFE452C407B25B]()
end
CoD.DoubleXPUtility.HasTierBoost = function(f11_arg0, f11_arg1)
	local f11_local0 = CoD.DoubleXPUtility.HasDoubleLootXP(f11_arg0, f11_arg1)
	if not f11_local0 then
		f11_local0 = f11_arg1 and CoD.ModelUtility.IsSelfModelValueTrue(f11_arg1, f11_arg0, "hasTierBoost")
	end
	return f11_local0
end
CoD.DoubleXPUtility.CurrentLobbyHasTierBoost = function(f12_arg0)
	if not IsPublicOnlineGame() then
		return false
	end
	local f12_local0 = Engine[0x8DF2E5447F384B9]()
	f12_local0 = f12_local0.lobbyRoot.lobbyMainMode:get()
	if f12_local0 == Enum[0x89C1455C5032969][0x79D01499920B292] or f12_local0 == Enum[0x89C1455C5032969][0xD5FBB8D74AC6D62] then
		return false
	end
	local f12_local1 = LobbyData.GetCurrentMenuTarget()
	if f12_local1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
		return false
	elseif CoD.BaseUtility.IsDvarEnabled("ui_fakeTierBoost") then
		return true
	end
	local f12_local2 = CoD.StartMenuUtility.GetSessionModeFromLobby()
	local f12_local3 = nil
	if IsPublicOnlineGame() then
		f12_local3 = Engine[0x7B3B2B73B53EB34]()
	end
	if Engine[0xF4F47F17B3BDCB3](f12_arg0, Engine[0xACFE452C407B25B](f12_local2), f12_local2, f12_local3) then
		return true
	elseif IsKoreaBonusXPSpecialEventActive(f12_arg0) then
		return true
	end
	local f12_local4 = Dvar[0xFF4F2F1F645D6F0]:get()
	if not f12_local4 then
		return false
	end
	return tonumber(f12_local4) >= 2
end
CoD.DoubleXPUtility.IsDoubleXPEventActive = function(f13_arg0)
	local f13_local0 = Engine[0x83E01BB5D71FB52](f13_arg0)
	if not f13_local0 then
		f13_local0 = CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleXP")
		if not f13_local0 then
			f13_local0 = IsKoreaBonusXPSpecialEventActive(f13_arg0)
		end
	end
	return f13_local0
end
CoD.DoubleXPUtility.IsDoubleWeaponXPEventActive = function(f14_arg0)
	local f14_local0 = Engine[0x33AB4BFD0DA7DAE]()
	if not f14_local0 then
		f14_local0 = CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleGunXP")
	end
	return f14_local0
end
CoD.DoubleXPUtility.HasDoubleNP = function(f15_arg0, f15_arg1)
	local f15_local0 = f15_arg1 and CoD.SafeGetModelValue(f15_arg1:getModel(), "mode")
	local f15_local1 = f15_arg1 and CoD.SafeGetModelValue(f15_arg1:getModel(), "playlist")
	if f15_local0 then
		f15_local0 = LuaUtils.GetEModeForLobbyMainMode(f15_local0)
	end
	if (f15_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] or CoD.StartMenuUtility.GetSessionModeFromLobby() == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) and (Engine[0xF4F47F17B3BDCB3](f15_arg0, Engine[0xACFE452C407B25B](Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]), Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A], f15_local1) or CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleNP")) then
		return true
	else
		return false
	end
end
CoD.DoubleXPUtility.CurrentLobbyHasDoubleNP = function(f16_arg0)
	if not CoD.ZombieUtility.IsDoubleNP(f16_arg0) then
		return false
	else
		local f16_local0 = Engine[0x8DF2E5447F384B9]()
		return f16_local0.lobbyRoot.lobbyMainMode:get() == Enum[0x89C1455C5032969][0x79D01499920B292]
	end
end
CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP = function(f17_arg0)
	local f17_local0 = LobbyData.GetCurrentMenuTarget()
	if not IsPublicOrLeagueGame() and (not f17_local0 or f17_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223]) and not CoD.DirectorUtility.ShowDirectorPregame(f17_arg0) then
		return false
	else
		local f17_local1 = LobbyData.GetCurrentMenuTarget()
		if f17_local1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
			return false
		else
			local f17_local2 = Engine[0x8DF2E5447F384B9]()
			f17_local2 = f17_local2.lobbyRoot.playlistId:get()
			local f17_local3 = f17_local2 and Engine[0x3ACB99DBAD24D55](f17_local2)
			if f17_local3 and LuaUtils.PlaylistRulesIncludes(f17_local3.rules, 0x2319BDFEBA279FB, "0") then
				return false
			elseif CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleXP") then
				return true
			else
				return CoD.DoubleXPUtility.MainModeHasDoubleXP(f17_arg0, f17_local0 and f17_local0[0xEB7DDC7F079D51B], f17_local2)
			end
		end
	end
end
CoD.DoubleXPUtility.CurrentPlaylistHasMainMode = function(f18_arg0, f18_arg1)
	local f18_local0 = LobbyData.GetCurrentMenuTarget()
	if not IsPublicOrLeagueGame() and (not f18_local0 or f18_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223]) and not CoD.DirectorUtility.ShowDirectorPregame(f18_arg0) then
		return false
	else
		local f18_local1 = LobbyData.GetCurrentMenuTarget()
		if f18_local1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
			return false
		else
			local f18_local2 = Engine[0x8DF2E5447F384B9]()
			f18_local2 = f18_local2.lobbyRoot.playlistId:get()
			local f18_local3 = f18_local2 and Engine[0x3ACB99DBAD24D55](f18_local2)
			return (f18_local3 and f18_local3.mainMode) == f18_arg1
		end
	end
end
CoD.DoubleXPUtility.CurrentPlaylistHasDoubleWeaponXP = function(f19_arg0)
	local f19_local0 = LobbyData.GetCurrentMenuTarget()
	if not IsPublicOrLeagueGame() and (not f19_local0 or f19_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223]) and not CoD.DirectorUtility.ShowDirectorPregame(f19_arg0) then
		return false
	else
		local f19_local1 = LobbyData.GetCurrentMenuTarget()
		if f19_local1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
			return false
		else
			local f19_local2 = Engine[0x8DF2E5447F384B9]()
			f19_local2 = f19_local2.lobbyRoot.playlistId:get()
			local f19_local3 = f19_local2 and Engine[0x3ACB99DBAD24D55](f19_local2)
			if f19_local3 and LuaUtils.PlaylistRulesIncludes(f19_local3.rules, 0xCDF40B7B2EB8235, "0") then
				return false
			else
				return CoD.DoubleXPUtility.MainModeHasDoubleWeaponXP(f19_arg0, f19_local0 and f19_local0[0xEB7DDC7F079D51B])
			end
		end
	end
end
CoD.DoubleXPUtility.IsPlaylistModifierActive = function(f20_arg0, f20_arg1)
	local f20_local0 = CoD.DoubleXPUtility.HasDoubleXP(f20_arg0, f20_arg1)
	if not f20_local0 then
		f20_local0 = CoD.DoubleXPUtility.HasPromotionalDoubleXP(f20_arg0)
		if not f20_local0 then
			f20_local0 = CoD.DoubleXPUtility.HasDoubleWeaponXP(f20_arg0, f20_arg1)
			if not f20_local0 then
				f20_local0 = CoD.DoubleXPUtility.HasDoubleNP(f20_arg0, f20_arg1)
			end
		end
	end
	return f20_local0
end
DataSourceHelpers.PerControllerDataSourceSetup("PromotionalDoubleXP", "PromotionalDoubleXP", function(f21_arg0, f21_arg1)
	local f21_local0 = f21_arg0:create("dailyDoubleXPTimeLeft")
	local f21_local1 = f21_arg0:create("doubleXPTimeLeft")
	local f21_local2, f21_local3 = Engine[0x671D794BEB45EAD](f21_arg1)
	f21_local0:set(f21_local3)
	f21_local1:set(f21_local2)
end)
