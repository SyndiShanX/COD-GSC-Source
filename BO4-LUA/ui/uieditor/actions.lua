require("x64:d3ad8b6812f6d2c")
function GridForceMenuOpened(f1_arg0, f1_arg1, f1_arg2)
	if f1_arg0.isGridLayout then
		f1_arg0:menuOpened(f1_arg1, f1_arg2, true)
	end
end
function OpenErrorPopup(f2_arg0, f2_arg1)
	LuaUtils.UI_ShowErrorMessageDialog(f2_arg0, Engine[0xF9F1239CFD921FE](f2_arg1))
end
function UpdateState(f3_arg0, f3_arg1)
	local f3_local0 = {}
	if f3_arg1 ~= nil then
		f3_local0 = LUI.ShallowCopy(f3_arg1)
	end
	f3_local0.name = "update_state"
	f3_local0.forceDispatch = true
	f3_arg0:processEvent(f3_local0)
end
function UpdateElementState(f4_arg0, f4_arg1, f4_arg2)
	if f4_arg0[f4_arg1] then
		f4_arg0[f4_arg1]:processEvent({
			name = "update_state",
			controller = f4_arg2,
			forceDispatch = true,
		})
	end
end
function UpdateSelfElementState(f5_arg0, f5_arg1, f5_arg2)
	f5_arg1:processEvent({
		name = "update_state",
		menu = f5_arg0,
		controller = f5_arg2,
		forceDispatch = true,
	})
end
function UpdateSelfState(f6_arg0, f6_arg1)
	f6_arg0:processEvent({
		name = "update_state",
		controller = f6_arg1,
		forceDispatch = true,
	})
end
function UpdateElementStateWithoutChildren(f7_arg0, f7_arg1, f7_arg2)
	f7_arg0:updateElementState(f7_arg1, {
		name = "update_state",
		menu = f7_arg0,
		controller = f7_arg2,
	})
end
function SetLuiKeyCatcher(f8_arg0)
	Engine[0x20E69E0F0BB745E](f8_arg0)
end
function EngineExec(f9_arg0, f9_arg1)
	Engine[0x7C75E608EA39B5C](f9_arg0, f9_arg1)
end
function UpdateAllMenuButtonPrompts(f10_arg0, f10_arg1)
	f10_arg0:UpdateAllButtonPrompts(f10_arg1)
end
function UpdateButtonPromptState(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	CoD.Menu.UpdateButtonShownState(f11_arg1, f11_arg0, f11_arg2, f11_arg3)
end
function ClearButtonsFlags(f12_arg0, f12_arg1, f12_arg2)
	CoD.Menu.ClearButtonLabel(f12_arg0, f12_arg1, f12_arg2)
end
function SendButtonPressToSiblingMenu(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4)
	local f13_local0 = f13_arg0:getParent()
	f13_local0 = f13_local0 and f13_local0[f13_arg1]
	if f13_local0 then
		CoD.Menu.HandleButtonPress(f13_local0, f13_arg2, f13_arg4, f13_arg3)
	end
end
function SendButtonPressToMenu(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
	CoD.Menu.HandleButtonPress(f14_arg0, f14_arg1, f14_arg3, f14_arg2)
end
function SendButtonPressToMenuEx(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f15_arg1), "ButtonBits." .. f15_arg2)
	if f15_local0 then
		Engine[0x83C9B5DE1D9371](f15_local0, Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464])
		Engine[0x83C9B5DE1D9371](f15_local0, 0)
	end
end
function DisableAutoButtonCallback(f16_arg0, f16_arg1, f16_arg2)
	if CoD.isPC then
		f16_arg1.__disableAutoButtonCallback = true
		if f16_arg1.__autoButtonCallback then
			for f16_local3, f16_local4 in pairs(f16_arg1.__autoButtonCallback) do
				if f16_local4 then
					f16_arg0:AddButtonCallbackFunction(f16_arg1, f16_arg2, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], f16_local3, nil, nil, nil)
				end
			end
		end
	end
end
function SetProperty(f17_arg0, f17_arg1, f17_arg2)
	f17_arg0[f17_arg1] = f17_arg2
end
function SetElementProperty(f18_arg0, f18_arg1, f18_arg2)
	f18_arg0[f18_arg1] = f18_arg2
end
function SetMenuProperty(f19_arg0, f19_arg1, f19_arg2)
	f19_arg0[f19_arg1] = f19_arg2
end
function SetElementPropertyEnum(f20_arg0, f20_arg1, f20_arg2)
	f20_arg0[f20_arg1] = f20_arg2
end
function ForceNotifyModel(f21_arg0, f21_arg1)
	Engine[0x6A489878620F3BC](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f21_arg0), f21_arg1))
end
function SetControllerModelValue(f22_arg0, f22_arg1, f22_arg2)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f22_arg0), f22_arg1), f22_arg2)
end
function ToggleControllerModelValueBoolean(f23_arg0, f23_arg1)
	local f23_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f23_arg0), f23_arg1)
	Engine[0x83C9B5DE1D9371](f23_local0, not Engine[0x614D394F6F9A18D](f23_local0))
end
function ToggleControllerModelValueNumber(f24_arg0, f24_arg1)
	local f24_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f24_arg0), f24_arg1)
	Engine[0x83C9B5DE1D9371](f24_local0, 1 - Engine[0x614D394F6F9A18D](f24_local0))
end
function SetControllerModelValueNumberIncrement(f25_arg0, f25_arg1, f25_arg2)
	local f25_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f25_arg0), f25_arg1)
	local f25_local1 = Engine[0x614D394F6F9A18D](f25_local0) + 1
	if f25_arg2 then
		f25_local1 = math.min(f25_local1, f25_arg2)
	end
	Engine[0x83C9B5DE1D9371](f25_local0, f25_local1)
end
function SetControllerModelValueNumberDecrement(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f26_arg0), f26_arg1)
	local f26_local1 = Engine[0x614D394F6F9A18D](f26_local0) - 1
	if f26_arg2 then
		f26_local1 = math.max(f26_local1, f26_arg2)
	end
	Engine[0x83C9B5DE1D9371](f26_local0, f26_local1)
end
function ToggleGlobalModelValueBoolean(f27_arg0)
	local f27_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f27_arg0)
	Engine[0x83C9B5DE1D9371](f27_local0, not Engine[0x614D394F6F9A18D](f27_local0))
end
function SetListDataSource(f28_arg0, f28_arg1)
	f28_arg0:setDataSource(f28_arg1)
end
function SetGlobalModelValueTrue(f29_arg0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f29_arg0), true)
end
function SetGlobalModelValueFalse(f30_arg0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f30_arg0), false)
end
function SetGlobalModelValue(f31_arg0, f31_arg1)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f31_arg0), f31_arg1)
end
function SetGlobalModelValueLocString(f32_arg0, f32_arg1)
	local f32_local0 = Engine[0x8DF2E5447F384B9]()
	f32_local0 = f32_local0:create(f32_arg0)
	f32_local0:set(f32_arg1)
end
function SetGlobalModelValueArg(f33_arg0, f33_arg1)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f33_arg0), f33_arg1)
end
function SetElementModelValue(f34_arg0, f34_arg1, f34_arg2)
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](f34_arg0:getModel(), f34_arg1), f34_arg2)
end
function DispatchEventToChildren(f35_arg0, f35_arg1, f35_arg2)
	return f35_arg0:dispatchEventToChildren({
		name = f35_arg1,
		controller = f35_arg2,
	})
end
function DispatchEventToParent(f36_arg0, f36_arg1, f36_arg2)
	return f36_arg0:dispatchEventToParent({
		name = f36_arg1,
		controller = f36_arg2,
	})
end
function DispatchEventToRoot(f37_arg0, f37_arg1, f37_arg2)
	return f37_arg0:dispatchEventToRoot({
		name = f37_arg1,
		controller = f37_arg2,
	})
end
function SetPerControllerTableProperty(f38_arg0, f38_arg1, f38_arg2)
	CoD.perController[f38_arg0][f38_arg1] = f38_arg2
end
function SetModelToGlobalDataSource(f39_arg0, f39_arg1, f39_arg2)
	if DataSources[f39_arg2] then
		f39_arg1:setModel(DataSources[f39_arg2].getModel(f39_arg0), f39_arg0)
	end
end
function CopyElementToPerControllerTable(f40_arg0, f40_arg1, f40_arg2)
	CoD.perController[f40_arg0][f40_arg2] = f40_arg1
end
function SendClientScriptNotify(f41_arg0, f41_arg1, f41_arg2)
	Engine[0x6ABA4D7F0840A1E](f41_arg0, f41_arg1, {
		param1 = f41_arg2,
	})
end
function SendClientScriptNotifyForAdjustedClient(f42_arg0, f42_arg1, f42_arg2)
	Engine[0x6ABA4D7F0840A1E](f42_arg0, f42_arg1, {
		param1 = f42_arg2 .. CoD.GetLocalClientAdjustedNum(f42_arg0),
	})
end
function SendCustomClientScriptNotifyForAdjustedClient(f43_arg0, f43_arg1, ...)
	Engine[0x6ABA4D7F0840A1E](f43_arg0, f43_arg1 .. CoD.GetLocalClientAdjustedNum(f43_arg0), ...)
end
function SendClientScriptMenuChangeNotify(f44_arg0, f44_arg1, f44_arg2)
	SendClientScriptMenuChangeNotifyHelper(f44_arg0, f44_arg1.menuName, f44_arg2)
end
function SendCustomClientScriptMenuChangeNotify(f45_arg0, f45_arg1, f45_arg2)
	SendClientScriptMenuChangeNotifyHelper(f45_arg0, f45_arg1, f45_arg2)
end
function SendClientScriptMenuChangeNotifyWithState(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
	SendClientScriptMenuChangeNotifyHelper(f46_arg0, f46_arg1.menuName, f46_arg2, f46_arg3)
end
function SendCustomClientScriptMenuStateChangeNotify(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
	SendClientScriptMenuChangeNotifyHelper(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
end
function SendCustomClientScriptMenuExpressionStateChangeNotify(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
	SendClientScriptMenuChangeNotifyHelper(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
end
function SendClientScriptMenuExpressionStateChangeNotify(f49_arg0, f49_arg1, f49_arg2, f49_arg3)
	SendClientScriptMenuChangeNotifyHelper(f49_arg0, f49_arg1.menuName, f49_arg2, f49_arg3)
end
function CallCustomElementFunction_Self(f50_arg0, f50_arg1, ...)
	local f50_local0 = {
		n = select("#", ...),
		...,
	}
	if f50_arg0[f50_arg1] then
		if not f50_local0 or #f50_local0 == 1 and f50_local0[1] == nil then
			f50_arg0[f50_arg1](f50_arg0)
		else
			f50_arg0[f50_arg1](f50_arg0, ...)
		end
	end
end
function CallCustomElementFunction_Element(f51_arg0, f51_arg1, ...)
	if f51_arg0[f51_arg1] then
		f51_arg0[f51_arg1](f51_arg0, ...)
	end
end
function SetProfileVar(f52_arg0, f52_arg1, f52_arg2)
	Engine[0x280E4C1191CC53D](f52_arg0, f52_arg1, f52_arg2)
end
function SetupDynamicContainer(f53_arg0)
	LUI.OverrideFunction_CallOriginalSecond(f53_arg0, "close", function(element)
		local f54_local0 = element:getFirstChild()
		while f54_local0 ~= nil do
			local f54_local1 = f54_local0:getNextSibling()
			f54_local0:close()
			f54_local0 = f54_local1
		end
	end)
end
function UseFirstElementAsBacking(f55_arg0, f55_arg1)
	f55_arg0:setupResizingUIHorizontalList(f55_arg1)
	f55_arg0.__ignoreFirstElement = f55_arg1
end
function OpenGameSettingsOptionsMenu(f56_arg0, f56_arg1, f56_arg2, f56_arg3)
	CoD.perController[f56_arg2].selectedGameSettingElement = f56_arg1
	f56_arg3:saveState(f56_arg2)
	OpenPopup(f56_arg3, "GameSettings_OptionsMenu", f56_arg2)
end
function ResetGameSettings()
	Engine[0x631AB43BA10119](Engine[0x69811927938FCD7]())
	Engine[0xB177D654FFB67BE]("bot_maxFree", 0)
	Engine[0xB177D654FFB67BE]("bot_maxAllies", 0)
	Engine[0xB177D654FFB67BE]("bot_maxAxis", 0)
	Engine[0xB177D654FFB67BE]("bot_difficulty", 1)
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Update"))
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Reset"))
end
function SetCTDifficultyEasy()
	Engine[0xB177D654FFB67BE]("overrideDifficulty", "easy")
end
function SetCTDifficultyMedium()
	Engine[0xB177D654FFB67BE]("overrideDifficulty", "medium")
end
function SetCTDifficultyHard()
	Engine[0xB177D654FFB67BE]("overrideDifficulty", "hard")
end
function SetCTDifficultyTutorial()
	Engine[0xB177D654FFB67BE]("overrideDifficulty", "tutorial")
end
function ResetSelectedGameSetting(f62_arg0, f62_arg1, f62_arg2, f62_arg3)
	local f62_local0 = CoD.perController[f62_arg2].selectedGameSettingElement
	if f62_local0 and f62_local0.revert then
		f62_local0:revert()
	end
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings.Update"))
end
function GameSettingsMenuClosed(f63_arg0, f63_arg1)
	if CoD.perController[f63_arg1].editingPresetClass then
		Engine[0x624185ED5FB5050]()
		CoD.perController[f63_arg1].isPreset = nil
	end
end
function ButtonListFocused(f64_arg0, f64_arg1, f64_arg2)
	if f64_arg1.isClassButton then
		local f64_local0 = CoD.perController[f64_arg2]
		f64_local0.classNum = f64_arg1.actionParam
		f64_local0.isPreset = true
		f64_local0.weaponSlot = nil
		f64_local0.grenadeSlot = nil
		f64_local0.perkCategory = nil
		f64_local0.slotIndex = nil
	end
end
function GameSettingsButtonGainFocus(f65_arg0, f65_arg1, f65_arg2)
	CoD.OptionsUtility.UpdateInfoModels(f65_arg1)
end
function PlaySoundSetSound(f66_arg0, f66_arg1)
	f66_arg0:playSound(f66_arg1)
end
function SetIgnorePlaySoundSetSound(f67_arg0, f67_arg1)
	f67_arg0:setIgnorePlaySound(f67_arg1)
end
function PlaySoundAlias(f68_arg0)
	Engine[0xC4146BA76D0F982](f68_arg0)
end
function DelayedPlaySoundAlias(f69_arg0, f69_arg1, f69_arg2)
	f69_arg0:addElement(LUI.UITimer.newElementTimer(f69_arg1, true, function()
		PlaySoundAlias(f69_arg2)
	end))
end
function StopSoundAlias(f71_arg0)
	Engine[0xC738A7A46EDBB34](f71_arg0)
end
function PlayMPMusicPreview(f72_arg0, f72_arg1)
	local f72_local0 = CoD.SafeGetModelValue(f72_arg1:getModel(), "alias")
	if f72_local0 and f72_local0 ~= "" then
		CoD.StopFrontendMusic()
		Engine[0xC4146BA76D0F982](f72_local0)
		if not f72_arg1.soundTimer then
			f72_arg1.soundTimer = LUI.UITimer.newElementTimer(Engine[0xC89B758761819F2](f72_local0), true, function()
				StopMPMusicPreview(f72_arg0, f72_arg1)
			end)
			f72_arg1:addElement(f72_arg1.soundTimer)
		else
			f72_arg1.soundTimer:reset()
		end
	end
end
function StopMPMusicPreview(f74_arg0, f74_arg1)
	local f74_local0 = CoD.SafeGetModelValue(f74_arg1:getModel(), "alias")
	if f74_local0 and f74_local0 ~= "" then
		Engine[0xC738A7A46EDBB34](f74_local0)
		CoD.ResetFrontendMusic()
		if f74_arg1.soundTimer then
			f74_arg1.soundTimer:close()
			f74_arg1.soundTimer = nil
		end
	end
end
function PlayMenuMusic(f75_arg0, f75_arg1, f75_arg2)
	if not f75_arg2 then
		f75_arg2 = 0
	end
	local f75_local0 = Engine[0x4DF5CFBC1771947](f75_arg0)
	f75_local0.MenuMusic.musicStateName:set(f75_arg1)
	f75_local0.MenuMusic.delayInMS:set(f75_arg2)
	f75_local0.MenuMusic:forceNotifySubscriptions()
end
function ResetFrontendMusic(f76_arg0)
	local f76_local0 = Engine[0x4DF5CFBC1771947](f76_arg0)
	f76_local0.MenuMusic.musicStateName:set("")
	f76_local0.MenuMusic.delayInMS:set(0)
	f76_local0.MenuMusic:forceNotifySubscriptions()
	CoD.ResetFrontendMusic()
end
function SetElementModelToFocusedElementModel(f77_arg0, f77_arg1, f77_arg2, f77_arg3)
	local f77_local0 = f77_arg2:getModel()
	if f77_arg1[f77_arg3] and f77_local0 then
		f77_arg1[f77_arg3]:setModel(f77_local0, f77_arg0)
	end
end
function SetElementModelToFocusedElementSubModel(f78_arg0, f78_arg1, f78_arg2, f78_arg3, f78_arg4)
	local f78_local0 = f78_arg2:getModel()
	if f78_local0 then
		local f78_local1 = f78_local0[f78_arg4]
		if f78_arg3 and f78_local1 then
			f78_arg3:setModel(f78_local1, f78_arg1)
		end
	end
end
function SetAncestorsElementModelToFocusedElementSubModel(f79_arg0, f79_arg1, f79_arg2, f79_arg3, f79_arg4)
	local f79_local0 = nil
	local f79_local1 = f79_arg2:getParent()
	while f79_local1 and not f79_local0 do
		if f79_local1[f79_arg3] then
			f79_local0 = f79_local1[f79_arg3]
		else
			f79_local1 = f79_local1:getParent()
		end
	end
	local f79_local2 = f79_arg2:getModel()
	if f79_local2 then
		local f79_local3 = f79_local2[f79_arg4]
		if f79_local0 and f79_local3 then
			f79_local0:setModel(f79_local3, f79_arg1)
		end
	end
end
function SetElementModelToSelfModelValue(f80_arg0, f80_arg1, f80_arg2, f80_arg3)
	local f80_local0 = f80_arg0:getModel()
	f80_local0 = f80_local0 and f80_local0[f80_arg3]
	if f80_local0 then
		local f80_local1 = f80_local0:get()
		if type(f80_local1) == "userdata" then
			f80_arg1:setModel(f80_local1, f80_arg2)
		end
	end
end
function ForceNotifyGlobalModel(f81_arg0, f81_arg1)
	Engine[0x6A489878620F3BC](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), f81_arg1))
end
function ForceNotifyControllerModel(f82_arg0, f82_arg1)
	local f82_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f82_arg0), f82_arg1)
	if f82_local0 then
		Engine[0x6A489878620F3BC](f82_local0)
	end
end
function DelayForceNotifyControllerModel(f83_arg0, f83_arg1, f83_arg2, f83_arg3)
	if not f83_arg3 then
		f83_arg3 = 0
	end
	f83_arg0:addElement(LUI.UITimer.newElementTimer(f83_arg3, true, function(f84_arg0)
		local f84_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f83_arg1), f83_arg2)
		if f84_local0 then
			Engine[0x6A489878620F3BC](f84_local0)
		end
	end))
end
function InitDataSourceModel(f85_arg0, f85_arg1)
	DataSources[f85_arg1].getModel(f85_arg0)
end
function DataSourceHelperRecreate(f86_arg0, f86_arg1)
	DataSources[f86_arg1].recreate(f86_arg0)
end
function DataSourceHelperGetModel(f87_arg0, f87_arg1)
	if DataSources[f87_arg1] then
		DataSources[f87_arg1].getModel(f87_arg0)
	end
end
function ShowKeyboard(f88_arg0, f88_arg1, f88_arg2, f88_arg3)
	Engine[0x7C75E608EA39B5C](f88_arg2, "ui_keyboard_new " .. Enum[0x85FCE2AA5391A7C][Engine[0xC53F8D38DF9042B](f88_arg3)])
end
function RefreshLobbyGameClient(f89_arg0, f89_arg1)
	local f89_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.gameClient.update")
	local f89_local1
	if Engine[0x614D394F6F9A18D](f89_local0) == 0 then
		f89_local1 = 1
	else
		f89_local1 = 0
	end
	Engine[0x83C9B5DE1D9371](f89_local0, f89_local1)
end
function ShowHeaderIconOnly(f90_arg0)
	f90_arg0.showHeaderKicker = false
	f90_arg0.showHeaderIcon = true
end
function ShowHeaderKickerAndIcon(f91_arg0)
	f91_arg0.showHeaderKicker = true
	f91_arg0.showHeaderIcon = true
end
function SetHeadingKickerText(f92_arg0)
	local f92_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.headingKickerText")
	if f92_local0 then
		Engine[0x83C9B5DE1D9371](f92_local0, Engine[0xF9F1239CFD921FE](f92_arg0))
	end
end
function SetHeadingKickerTextToGameMode()
	if CoD.PrestigeUtility.isInPermanentUnlockMenu then
		SetHeadingKickerText(0x56F8CED179E36FD)
		return
	elseif PregameActive() then
		SetHeadingKickerText(GetGameMode())
		return
	end
	local f93_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.headingKickerMode")
	local f93_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.headingKickerText")
	if f93_local1 then
		local f93_local2 = Engine[0x83C9B5DE1D9371]
		local f93_local3 = f93_local1
		local f93_local4
		if f93_local0 then
			f93_local4 = Engine[0x614D394F6F9A18D](f93_local0)
			if not f93_local4 then
			else
				f93_local2(f93_local3, f93_local4)
			end
		end
		f93_local4 = ""
	end
end
function SetHeadingKickerTextToSelectedWeapon(f94_arg0)
	local f94_local0 = CoD.GetCustomization(f94_arg0, "weapon_index")
	local f94_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.headingKickerText")
	if f94_local1 and f94_local0 ~= CoD.CACUtility.EmptyItemIndex then
		local f94_local2 = Engine[0xD5D69BA555E016D](f94_local0)
		local f94_local3 = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](f94_local0)))
		if f94_local1 and f94_local3 then
			Engine[0x83C9B5DE1D9371](f94_local1, f94_local3)
		end
	end
end
function ForceLobbyButtonUpdate(f95_arg0)
	LuaUtils.ForceLobbyButtonUpdate()
end
function RefreshServerList(f96_arg0, f96_arg1)
	Engine[0xBF0D3F261D1B32A](f96_arg1)
end
function JoinSystemLinkServer(f97_arg0, f97_arg1, f97_arg2)
	if not f97_arg1.gridInfoTable then
		return
	end
	local f97_local0 = f97_arg1.gridInfoTable.zeroBasedIndex
	local f97_local1 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "serverListRoot"), "server" .. tostring(f97_local0)), "sessionMode"))
	local f97_local2 = nil
	if f97_local1 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		local f97_local3 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN_CP)
		f97_local2 = f97_local3[0xC45968D6338650E]
	elseif f97_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		local f97_local3 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN_MP)
		f97_local2 = f97_local3[0xC45968D6338650E]
	elseif f97_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		local f97_local3 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN_ZM)
		f97_local2 = f97_local3[0xC45968D6338650E]
	end
	if f97_local2 == nil then
		f97_local2 = 1
	end
	local f97_local3 = function(f98_arg0)
		if f98_arg0 then
			Engine[0xA44CDBD19FD7613](f98_arg0.controller, f98_arg0.index)
		end
	end
	if f97_local2 < Engine[0x9FB56855DFACDAD]() then
		CoD.OverlayUtility.CreateOverlay(f97_arg2, f97_arg0, "LobbyLocalClientWarning", {
			controller = f97_arg2,
			navToMenu = nil,
			popupName = nil,
			openFromMenu = nil,
			actionFunc = f97_local3,
			index = f97_local0,
		})
		return
	end
	f97_local3({
		controller = f97_arg2,
		index = f97_local0,
	})
end
function LobbyAddLocalClient(f99_arg0, f99_arg1)
	if LuaUtils.OnlineOnlyDemo() then
		return
	elseif Engine[0xCB675CA7856DA25]() and not LuaUtils.TrialAllowSplitscreen() then
		return false
	elseif Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
		if CoD.isPS4 then
			if Engine[0xC58A63F57534B83](f99_arg1) then
				return
			elseif LuaUtils.RequirePaidSubscriptionForOnlinePlay() then
				local f99_local0, f99_local1 = Engine[0x1F3727F7007C506](f99_arg1)
				if f99_local0 == true then
					if f99_local1 == false and not LuaUtils.PlayStationPlusUpsell(f99_arg1) then
						return
					end
				else
					return
				end
			end
		end
		if CoD.isDurango and not Engine[0xE91B1452CB6FBE6](f99_arg1) and not Engine[0xEFC616F1C8F84F6](f99_arg1) then
			Engine[0x12AA42031FA6D11](f99_arg1, 254, true)
			return
		end
	end
	local f99_local0 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	if Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		f99_local0 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
	end
	if Engine[0x9FB56855DFACDAD]() < Dvar[0x6BAC8B42067D2C5]:get() then
		local f99_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyMainMode"))
		local f99_local3 = -1
		if f99_local2 == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
			f99_local3 = LuaEnum.FEATURE_BAN.MP_SPLIT_SCREEN
		elseif f99_local2 == Enum[0x89C1455C5032969][0x79D01499920B292] then
			f99_local3 = LuaEnum.FEATURE_BAN.ZM_SPLIT_SCREEN
		elseif f99_local2 == Enum[0x89C1455C5032969][0x7B50049993542C0] then
			f99_local3 = LuaEnum.FEATURE_BAN.CP_SPLIT_SCREEN
		end
		if f99_local3 >= 0 then
			for f99_local4 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
				if CheckIfFeatureIsBanned(f99_local4, f99_local3) then
					LuaUtils.UI_ShowErrorMessageDialog(f99_arg1, GetFeatureBanInfo(f99_local4, f99_local3))
					return
				end
			end
		end
		CoD.LobbyUtility.UnusedGamepadButton(f99_arg0, f99_arg1)
		if Engine[0x9FB56855DFACDAD]() == 3 then
			Engine[0xB81A5136C5503E4](nil, "canceldemonwareconnect")
			LuaUtils.UI_ShowWarningMessageDialog(f99_arg1, Engine[0xF9F1239CFD921FE](0x6B651D2751797A))
		end
		local f99_local4 = Engine[0x22EAAB59AA27E9B]("bot_maxAllies")
		local f99_local5 = Engine[0x22EAAB59AA27E9B]("bot_maxAxis")
		local f99_local6 = Engine[0x22EAAB59AA27E9B]("bot_maxFree")
		local f99_local7 = CoD.OptionsUtility.MaxSplitscreenBots
		if f99_local7 < f99_local4 + f99_local5 then
			Engine[0xB177D654FFB67BE]("bot_maxAllies", f99_local7 / 2)
			Engine[0xB177D654FFB67BE]("bot_maxAxis", f99_local7 / 2)
		end
		if f99_local7 < f99_local6 then
			Engine[0xB177D654FFB67BE]("bot_maxFree", f99_local7)
		end
		CoD.perController[Engine[0xA5B9C0111291A8B]()].localClientChanged = true
		ForceLobbyButtonUpdate(f99_arg1)
	end
end
function LobbyLANServerPlayerListRefresh(f100_arg0, f100_arg1, f100_arg2)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "serverPlayerListRoot"), "selectedServer"), f100_arg1.gridInfoTable.zeroBasedIndex)
	if f100_arg0.LANServerBrowserDetails and f100_arg0.LANServerBrowserDetails.PlayerList then
		f100_arg0.LANServerBrowserDetails.PlayerList:updateDataSource()
	end
end
function UploadStats(f101_arg0, f101_arg1)
	Engine[0x7C75E608EA39B5C](f101_arg1, "uploadstats")
	Engine[0x7C75E608EA39B5C](f101_arg1, "savegamerprofilestats")
end
function SaveLoadout(f102_arg0, f102_arg1)
	local f102_local0 = CoD.PlayerRoleUtility.customizationMode
	if not f102_local0 then
		f102_local0 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	end
	Engine[0xE6C09FDF6C8D188](f102_arg1, f102_local0)
	if f102_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		CoD.BreadcrumbUtility.UploadBuffer(f102_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	elseif f102_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		CoD.BreadcrumbUtility.UploadBuffer(f102_arg1, Enum[0xBBD4F9E70101BA8][0xD1A0F784B3C95A0])
	elseif f102_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		CoD.BreadcrumbUtility.UploadBuffer(f102_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end
end
function SaveLoadoutGeneric(f103_arg0)
	local f103_local0 = CoD.PlayerRoleUtility.customizationMode
	if not f103_local0 then
		f103_local0 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	end
	Engine[0xE6C09FDF6C8D188](f103_arg0, f103_local0)
	if f103_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		CoD.BreadcrumbUtility.UploadBuffer(f103_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	elseif f103_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		CoD.BreadcrumbUtility.UploadBuffer(f103_arg0, Enum[0xBBD4F9E70101BA8][0xD1A0F784B3C95A0])
	elseif f103_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		CoD.BreadcrumbUtility.UploadBuffer(f103_arg0, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end
end
function ChangeCharacter(f104_arg0, f104_arg1, f104_arg2, f104_arg3)
	Engine[0xC554A8C36EF7EFF](f104_arg2, CoD.CACUtility.PositionDraftMenuName, "changecharacter", 0)
	local f104_local0 = Engine[0x4DF5CFBC1771947](f104_arg2)
	f104_local0 = f104_local0:create("PositionDraft.focusedCharacterIndex")
	f104_local0:set(0)
	f104_local0 = Engine[0x4DF5CFBC1771947](f104_arg2)
	f104_local0 = f104_local0:create("PositionDraft.focusedCharacterWeapon")
	f104_local0:set("")
	Engine[0x6ABA4D7F0840A1E](f104_arg2, "PositionDraft_Update", {
		localClientNum = Engine[0x7192908F4764ED3](f104_arg2),
	})
end
function PositionDraftOnChangingCharacter(f105_arg0)
	Engine[0x6ABA4D7F0840A1E](f105_arg0, "PositionDraft_ChangingCharacter", {
		localClientNum = Engine[0x7192908F4764ED3](f105_arg0),
	})
end
function PositionDraftOnChangingCharacterComplete(f106_arg0)
	Engine[0x6ABA4D7F0840A1E](f106_arg0, "PositionDraft_ChangingCharacterComplete", {
		localClientNum = Engine[0x7192908F4764ED3](f106_arg0),
	})
end
function PositionDraftResetCharacterScene(f107_arg0)
	Engine[0x6ABA4D7F0840A1E](f107_arg0, "PositionDraft_ResetCharacterScene", {
		localClientNum = Engine[0x7192908F4764ED3](f107_arg0),
	})
end
function PositionDraftReady(f108_arg0, f108_arg1, f108_arg2)
	Engine[0xC554A8C36EF7EFF](f108_arg2, CoD.CACUtility.PositionDraftMenuName, "ready", 0)
	local f108_local0 = Engine[0xE4D2F32833CFA6C](Engine[0x761955642304848](f108_arg2))
	if f108_local0 ~= nil then
		f108_local0.ready:set(1)
	end
end
function PositionDraftOnFocusCharacter(f109_arg0, f109_arg1, f109_arg2)
	local f109_local0 = ""
	local f109_local1 = Engine[0x3EAC408F958FF05]()
	local f109_local2 = CoD.CACUtility.GetSelectedCustomClass(f109_arg2, f109_local1)
	if not CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]) and f109_local2 and f109_local2 >= 0 then
		local f109_local3 = CoD.CACUtility.GetClassItem(f109_arg2, f109_local2, "primary", f109_local1)
		if f109_local3 and f109_local3 > CoDShared.EmptyItemIndex then
			f109_local0 = Engine[0xD5D69BA555E016D](f109_local3, Enum[0x6EB546760F890D2][0x569E84652131CD7], f109_local1)
		end
	end
	local f109_local3 = f109_arg1.characterIndex
	if not f109_local3 then
		local f109_local4 = f109_arg1:getModel()
		f109_local3 = f109_local4.characterIndex and f109_local4 and f109_local4.characterIndex:get()
	end
	local f109_local4 = Engine[0x4DF5CFBC1771947](f109_arg2)
	f109_local4 = f109_local4:create("PositionDraft.focusedCharacterIndex")
	f109_local4:set(f109_local3)
	f109_local4 = Engine[0x4DF5CFBC1771947](f109_arg2)
	f109_local4 = f109_local4:create("PositionDraft.focusedCharacterWeapon")
	f109_local4:set(f109_local0)
	f109_local4 = Engine[0x4DF5CFBC1771947](f109_arg2)
	f109_local4 = f109_local4:create("PositionDraft.focusedCharacterHasRestriction")
	f109_local4:set(CoD.PlayerRoleUtility.IsAnyAbilityRestricted(f109_arg1))
	f109_local4 = Engine[0x4DF5CFBC1771947](f109_arg2)
	f109_local4 = f109_local4:create("PositionDraft.focusedCharacterIsRestricted")
	f109_local4:set(CoD.PlayerRoleUtility.IsCharacterRestricted(f109_local1, f109_local3))
	Engine[0x6ABA4D7F0840A1E](f109_arg2, "PositionDraft_Update", {
		localClientNum = Engine[0x7192908F4764ED3](f109_arg2),
	})
end
function PositionDraftOnFocusCharacterLost(f110_arg0, f110_arg1, f110_arg2, f110_arg3)
	if not (not f110_arg1 or f110_arg1.gridInfoTable == nil or f110_arg1.gridInfoTable.parentGrid.activeWidget ~= f110_arg1) or f110_arg3 == true then
		PositionDraftClearFocusedCharacter(f110_arg2)
	end
end
function PositionDraftClearFocusedCharacter(f111_arg0)
	local f111_local0 = Engine[0x4DF5CFBC1771947](f111_arg0)
	f111_local0 = f111_local0:create("PositionDraft.focusedCharacterIndex")
	f111_local0:set(0)
	f111_local0 = Engine[0x4DF5CFBC1771947](f111_arg0)
	f111_local0 = f111_local0:create("PositionDraft.focusedCharacterWeapon")
	f111_local0:set("")
	f111_local0 = Engine[0x4DF5CFBC1771947](f111_arg0)
	f111_local0 = f111_local0:create("PositionDraft.focusedCharacterHasRestriction")
	f111_local0:set(false)
	f111_local0 = Engine[0x4DF5CFBC1771947](f111_arg0)
	f111_local0 = f111_local0:create("PositionDraft.focusedCharacterIsRestricted")
	f111_local0:set(false)
	Engine[0x6ABA4D7F0840A1E](f111_arg0, "PositionDraft_Update", {
		localClientNum = Engine[0x7192908F4764ED3](f111_arg0),
	})
end
function PositionDraftSelectCharacter(f112_arg0, f112_arg1, f112_arg2)
	local f112_local0 = f112_arg1:getModel()
	f112_local0 = f112_local0:create("disabled")
	if f112_local0:get() == false then
		Engine[0xC554A8C36EF7EFF](f112_arg2, CoD.CACUtility.PositionDraftMenuName, "draft", f112_arg1.characterIndex)
		Engine[0x6ABA4D7F0840A1E](f112_arg2, "PositionDraft_CharacterSelected", {
			localClientNum = Engine[0x7192908F4764ED3](f112_arg2),
		})
		CoD.perController[f112_arg2].classNum = Engine[0x6C0CB7BD099633F](Engine[0x3EAC408F958FF05](), f112_arg1.characterIndex)
		f112_local0 = Engine[0x4DF5CFBC1771947](f112_arg2)
		f112_local0 = f112_local0:create("PositionDraft.focusedCharacterIndex")
		f112_local0:set(0)
		f112_local0 = Engine[0x4DF5CFBC1771947](f112_arg2)
		f112_local0 = f112_local0:create("PositionDraft.focusedCharacterWeapon")
		f112_local0:set("")
	end
end
function PositionDraftSelectCharacterFrontend(f113_arg0, f113_arg1, f113_arg2)
	local f113_local0 = f113_arg1:getModel()
	f113_local0 = f113_local0:create("disabled")
	if f113_local0:get() == false then
		f113_local0 = f113_arg1.characterIndex
		if not f113_local0 then
			local f113_local1 = f113_arg1:getModel()
			f113_local0 = f113_local1.characterIndex and f113_local1 and f113_local1.characterIndex:get()
		end
		Engine[0x11D727BB83FE0C5](f113_arg2, Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]), f113_local0)
		LuaUtils.SetLastSelectedSpecialist(f113_arg2, f113_local0)
		Engine[0x6ABA4D7F0840A1E](f113_arg2, "PositionDraft_CharacterSelected", {
			characterIndex = f113_local0,
			localClientNum = Engine[0x7192908F4764ED3](f113_arg2),
		})
		CoD.perController[f113_arg2].classNum = Engine[0x6C0CB7BD099633F](Engine[0x3EAC408F958FF05](), f113_local0)
		local f113_local2 = Engine[0x4DF5CFBC1771947](f113_arg2)
		f113_local2 = f113_local2:create("PositionDraft.focusedCharacterIndex")
		f113_local2:set(0)
		f113_local2 = Engine[0x4DF5CFBC1771947](f113_arg2)
		f113_local2 = f113_local2:create("PositionDraft.focusedCharacterWeapon")
		f113_local2:set("")
	end
end
function PositionDraftOnCloseCharacterSelection(f114_arg0)
	if CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f114_arg0), "PositionDraft.ResetOnCloseCharacterSelection") == 1 then
		PositionDraftResetCharacterScene(f114_arg0)
	else
		PositionDraftOnChangingCharacterComplete(f114_arg0)
	end
end
function CustomGameSettingsMenuClosed(f115_arg0, f115_arg1)
	local f115_local0 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	Engine[0x87AE7E64BA5AD61]("OnGametypeSettingsChange", {
		lobbyModule = Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103],
		lobbyType = f115_local0,
		fromUI = true,
	})
	Engine[0x202BEB9A6859B8B](f115_local0, Enum[0x35E410854EFA4AD][0x9EC6BB6276BDCE6])
end
function LobbyToggleNetwork(f116_arg0, f116_arg1, f116_arg2, f116_arg3)
	for f116_local0 = 1, Engine[0xB686A0A723E6442]() - 1, 1 do
		LobbyRemoveLocalClientFromLobby(f116_arg0, f116_local0)
	end
	if f116_arg3 == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
		if IsOrbis() then
			if Engine[0xC58A63F57534B83](f116_arg2) then
				return
			elseif not LuaUtils.PlayStationPlusUpsell(f116_arg2) then
				return
			end
		end
		if CoD.LobbyUtility.ForceOffline() == true then
			CoD.OverlayUtility.CreateOverlay(f116_arg2, f116_arg0, "UpdateNeeded")
			return
		elseif not Engine[0x3CD0351DA0D371](f116_arg2) then
			Engine[0x4B71A3DA353ACF0]()
			CoD.OverlayUtility.CreateOverlay(f116_arg2, f116_arg0, "ConnectingToDemonware")
			return
		end
	end
	local f116_local0 = LuaEnum.UI.DIRECTOR_LAN
	if f116_arg3 == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
		f116_local0 = LuaEnum.UI.DIRECTOR_ONLINE
	end
	Engine[0x87AE7E64BA5AD61]("OnGoForward", {
		controller = f116_arg2,
		navToMenu = f116_local0,
	})
	local f116_local2 = f116_arg0:getParent()
	f116_arg0:close()
end
function LaunchGamePrototype(f117_arg0, f117_arg1, f117_arg2)
	local f117_local0 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav"))
	local f117_local1 = {}
	local f117_local2 = function(f118_arg0, f118_arg1)
		local f118_local0 = LobbyData.GetLobbyMenuByName(f118_arg0)
		if f118_local0 then
			f117_local1[f118_local0[0x8B72E07B55C3AC0]] = f118_arg1
		end
	end
	f117_local2(LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_LAN_CP, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_LAN_MP, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_LAN_MP_ARENA, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_LAN_MP_TRAINING, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_LAN_ZM, LobbyOnlineCustomLaunchGame_SelectionList)
	f117_local2(LuaEnum.UI.DIRECTOR_LAN_WZ, LobbyOnlineCustomLaunchGame_SelectionList)
	if f117_local1[f117_local0] then
		f117_local1[f117_local0](f117_arg0, f117_arg1, f117_arg2)
	end
end
function LobbyNoAction(f119_arg0, f119_arg1, f119_arg2, f119_arg3, f119_arg4) end
function OpenMPFirstTimeFlow(f120_arg0, f120_arg1, f120_arg2, f120_arg3, f120_arg4)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "heroSelectionTutorial"), true)
	if f120_arg3 == "goBackFirst" then
		f120_arg4 = GoBack(f120_arg0, f120_arg2)
	end
	f120_arg4.openOverlayAfterSpinner = "WelcomeMenu"
	f120_arg4.openOverlayAfterSpinnerController = f120_arg2
	NavigateToLobby_FirstTimeFlowMP(f120_arg0, f120_arg1, f120_arg2, f120_arg4)
end
function FirstTimeSetup_SetNone(f121_arg0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f121_arg0), "firstTimeFlowState"), CoD.PlayerRoleUtility.FirstTimeFlowState.None)
end
function ShowReportPlayerDialogTargetingKiller(f122_arg0, f122_arg1)
	local f122_local0 = Engine[0x4DF5CFBC1771947](f122_arg1)
	f122_local0 = f122_local0.Attacker
	if f122_local0 then
		local f122_local1 = f122_local0.xuid
		if f122_local1 then
			f122_local1 = f122_local0.xuid:get()
		end
		if f122_local1 then
			local f122_local2 = Engine[0xDC3B811A6](f122_arg1, f122_local1)
			CoD.OverlayUtility.CreateOverlay(f122_arg1, f122_arg0, "ReportPlayer", f122_arg1, f122_arg0, {
				controller = f122_arg1,
				xuid = f122_local1,
				gamertag = f122_local2.info.gamertag,
				clantag = f122_local2.info.clantag,
				emblemBacking = f122_local2.info.emblemBacking,
			})
		end
	end
end
function ShowReportPlayerDialog(f123_arg0, f123_arg1, f123_arg2, f123_arg3)
	local f123_local0 = f123_arg3.controller
	local f123_local1 = f123_arg3.xuid
	local f123_local2 = Engine[0xDC3B811A6](f123_local0, f123_local1)
	local f123_local3 = f123_local2.info.gamertag
	if not f123_local3 or f123_local3 == "" then
		f123_local3 = f123_arg3.gamertag
	end
	CoD.OverlayUtility.CreateOverlay(f123_local0, f123_arg0, "ReportPlayer", f123_local0, f123_arg1, {
		controller = f123_local0,
		xuid = f123_local1,
		gamertag = f123_local3,
		clantag = f123_local2.info.clantag,
		emblemBacking = f123_local2.info.emblemBacking,
	})
end
function CheckIfFeatureIsBanned(f124_arg0, f124_arg1)
	if Engine[0xE39F1F30B306065]() then
		return false
	else
		local f124_local0, f124_local1 = Engine[0x48BF994ADFE1D81](f124_arg0, f124_arg1)
		if f124_local0 then
			return true
		else
			return false
		end
	end
end
function GetFeatureBanInfo(f125_arg0, f125_arg1)
	if Engine[0xE39F1F30B306065]() then
		return ""
	end
	local f125_local0 = Engine[0xDD8BEA7ACAB0EEE](f125_arg0, f125_arg1)
	local f125_local1 = LuaUtils.GetBanMessageForFeature(f125_arg0, f125_arg1, f125_local0)
	local f125_local2 = ""
	if not f125_local0 then
		local f125_local3 = CoD.SafeGetModelValue(Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f125_arg0), "lobbyRoot.anticheat"), "featureBans"), "feature_" .. f125_arg1 .. "_end")
		if f125_local3 then
			f125_local2 = Engine[0xC0DA370E059D2B7](f125_local3 - Engine[0xCDDDCB47F4721AB]())
		end
	end
	return string.format("%s\n\n%s", f125_local1, f125_local2)
end
function PopAnticheatMessageAndGoForward_MP(f126_arg0, f126_arg1, f126_arg2, f126_arg3)
	local f126_local0 = GoBack(f126_arg0, f126_arg2)
	Engine[0x62622EC8D03A796](f126_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.MP)
	NavigateCheckForFirstTime(f126_local0, f126_arg1, f126_arg2, {
		targetName = "MPLobbyMain",
		mode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		firstTimeFlowAction = OpenMPFirstTimeFlow,
	}, f126_local0)
end
function PopAnticheatMessageAndGoForward_ZM(f127_arg0, f127_arg1, f127_arg2, f127_arg3)
	local f127_local0 = GoBack(f127_arg0, f127_arg2)
	Engine[0x62622EC8D03A796](f127_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.ZM)
	NavigateToLobby_SelectionList(f127_local0, f127_arg1, f127_arg2, "ZMLobbyOnline", f127_local0)
end
function PopAnticheatMessageAndGoForward_Paintshop(f128_arg0, f128_arg1, f128_arg2, f128_arg3)
	local f128_local0 = GoBack(f128_arg0, f128_arg2)
	Engine[0x62622EC8D03A796](f128_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC)
	CoD.CraftUtility.OpenPaintjobWeaponSelection(f128_local0, f128_arg1, f128_arg2, "", f128_local0)
end
function PopAnticheatMessageAndGoForward_EmblemEditor(f129_arg0, f129_arg1, f129_arg2, f129_arg3)
	local f129_local0 = GoBack(f129_arg0, f129_arg2)
	Engine[0x62622EC8D03A796](f129_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC)
	OpenEmblemEditor(f129_arg1, f129_local0, f129_arg2, nil)
end
function PopAnticheatMessageAndGoForward_PaintjobEditor(f130_arg0, f130_arg1, f130_arg2, f130_arg3)
	local f130_local0 = GoBack(f130_arg0, f130_arg2)
	Engine[0x62622EC8D03A796](f130_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC)
	OpenPaintjobEditor(f130_arg1, f130_local0, f130_arg2, nil)
end
function PopAnticheatMessageAndGoForward_Loot(f131_arg0, f131_arg1, f131_arg2, f131_arg3)
	local f131_local0 = GoBack(f131_arg0, f131_arg2)
	Engine[0x62622EC8D03A796](f131_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.LOOT)
	OpenBlackMarket(f131_local0, nil, f131_arg2)
end
function PopAnticheatMessageAndGoForward_Arena(f132_arg0, f132_arg1, f132_arg2, f132_arg3)
	local f132_local0 = GoBack(f132_arg0, f132_arg2)
	Engine[0x62622EC8D03A796](f132_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.ARENA)
	NavigateToLobby_SelectionList(f132_local0, f132_arg1, f132_arg2, "MPLobbyOnlineArena", f132_local0)
end
function GetAnticheatMessageForwardFunction(f133_arg0, f133_arg1, f133_arg2)
	if f133_arg0 == LuaEnum.ANTICHEAT_MESSAGE_GROUPS.MP then
		return PopAnticheatMessageAndGoForward_MP
	elseif f133_arg0 == LuaEnum.ANTICHEAT_MESSAGE_GROUPS.ZM then
		return PopAnticheatMessageAndGoForward_ZM
	elseif f133_arg0 == LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC then
		if f133_arg1 == "EmblemEditor" then
			return PopAnticheatMessageAndGoForward_EmblemEditor
		elseif f133_arg1 == "PaintjobEditor" then
			return PopAnticheatMessageAndGoForward_PaintjobEditor
		elseif f133_arg1 == "Paintshop" then
			return PopAnticheatMessageAndGoForward_Paintshop
		end
	elseif f133_arg0 == LuaEnum.ANTICHEAT_MESSAGE_GROUPS.LOOT then
		return PopAnticheatMessageAndGoForward_Loot
	elseif f133_arg0 == LuaEnum.ANTICHEAT_MESSAGE_GROUPS.ARENA then
		return PopAnticheatMessageAndGoForward_Arena
	end
end
function DisplayAnticheatMessage(f134_arg0, f134_arg1, f134_arg2, f134_arg3, f134_arg4)
	if Engine[0xE39F1F30B306065]() then
		return
	else
		local f134_local0 = GetAnticheatMessageForwardFunction(f134_arg2, f134_arg3, f134_arg4)
		local f134_local1 = Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f134_arg1), "lobbyRoot.anticheat"), "message")
		CoD.OverlayUtility.CreateOverlay(f134_arg1, f134_arg0, "AnticheatMessage", Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f134_local1, "string")), Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f134_local1, "url")), f134_local0)
	end
end
function OpenAnticheatPolicyInBrowser(f135_arg0, f135_arg1, f135_arg2, f135_arg3)
	if Engine[0xE39F1F30B306065]() then
		return
	else
		Engine[0x480832457BF076F](f135_arg2, Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f135_arg2), "lobbyRoot.anticheat"), "message"), "url")))
	end
end
function NavigateCheckForFirstTime(f136_arg0, f136_arg1, f136_arg2, f136_arg3, f136_arg4)
	if IsFirstTimeSetup(f136_arg2, f136_arg3.mode) then
		f136_arg3.firstTimeFlowAction(f136_arg0, f136_arg1, f136_arg2, f136_arg3.targetName, f136_arg4)
	else
		NavigateToLobby_SelectionList(f136_arg0, f136_arg1, f136_arg2, f136_arg3.targetName, f136_arg4)
	end
end
function SetCharacterModeToSessionMode(f137_arg0, f137_arg1, f137_arg2)
	CoD.PlayerRoleUtility.customizationMode = f137_arg2
end
function SetCharacterModeToCurrentSessionMode(f138_arg0, f138_arg1, f138_arg2)
	CoD.PlayerRoleUtility.customizationMode = Engine[0x3EAC408F958FF05]()
end
function SetFirstTimeSetupComplete_MP(f139_arg0, f139_arg1, f139_arg2, f139_arg3, f139_arg4)
	Engine[0x11127FAB55E5F1D](f139_arg2, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5], true)
	FirstTimeSetup_SetNone(f139_arg2)
end
function OpenMegaChewFactorymenu(f140_arg0, f140_arg1, f140_arg2, f140_arg3, f140_arg4)
	CoD.LobbyUtility.OpenMegaChewFactory(f140_arg4, f140_arg2)
end
function OpenBotSettings(f141_arg0, f141_arg1)
	CoD.LobbyUtility.OpenBotSettings(f141_arg0, f141_arg1)
end
function AddLobbyBots(f142_arg0, f142_arg1)
	CoD.LobbyUtility.AddLobbyBot(f142_arg0, f142_arg1)
end
function RemoveLobbyBots(f143_arg0, f143_arg1, f143_arg2, f143_arg3, f143_arg4)
	CoD.LobbyUtility.RemoveLobbyBot(f143_arg4, f143_arg2)
end
function SetFillParty(f144_arg0, f144_arg1, f144_arg2, f144_arg3)
	Engine[0xF6CE659F166033E](f144_arg3)
end
function ResetClientLoadouts(f145_arg0)
	if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) then
		Engine[0x87AE7E64BA5AD61]("ResetClientLoadouts", {})
	end
end
function OpenStore(f146_arg0, f146_arg1, f146_arg2, f146_arg3, f146_arg4)
	if CoD.isPS4 and Engine[0xC58A63F57534B83](f146_arg2) then
		return
	elseif not CoD.StoreUtility.IsStoreEnabled(f146_arg2) then
		return
	else
		local f146_local0 = LobbyData.GetCurrentMenuTarget()
		CoD.MetricsUtility.StoreEntry(f146_arg4, f146_arg2, f146_arg3, f146_local0)
		local f146_local1 = DataSources.StoreRoot.getModel(f146_arg2)
		f146_local1.ready:set(false)
		f146_local1.actionSource:set(f146_arg3)
		f146_local1.storeSource:set(f146_local0[0x4BCADBA8E631B86])
		OpenOverlay(f146_arg4, "Store", f146_arg2)
	end
end
function OpenCredits(f147_arg0, f147_arg1, f147_arg2, f147_arg3, f147_arg4)
	OpenOverlay(f147_arg4, "Credit_Fullscreen", f147_arg2)
end
function OpenQuarterMaster(f148_arg0, f148_arg1, f148_arg2, f148_arg3, f148_arg4)
	if not Engine[0xE91B1452CB6FBE6](f148_arg2) then
		OpenOverlay(f148_arg4, "QuarterMasterMenu", f148_arg2, {
			_tab = f148_arg3,
		})
		CoD.SurveyUtility.OpenSurvey(f148_arg4, f148_arg2, Enum[0xC20EF6D686D1E5F][0x51C2AA5FA0D8715])
	end
end
function OpenSteamStore(f149_arg0, f149_arg1, f149_arg2, f149_arg3, f149_arg4)
	if not DisableSteamStore() then
		Engine[0xD3D377F5F344D2C](f149_arg2)
	end
end
function OpenScorestreaks(f150_arg0, f150_arg1, f150_arg2, f150_arg3, f150_arg4)
	CoD.LobbyUtility.OpenScorestreaks(f150_arg4, f150_arg2)
end
function PromoteToLeader(f151_arg0, f151_arg1, f151_arg2, f151_arg3, f151_arg4, f151_arg5)
	Engine[0x3CDCDFD486E97B7](f151_arg3.controller, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f151_arg3.xuid)
	if not f151_arg5 then
		f151_arg4:goBack(f151_arg2)
	end
end
function DisconnectClient(f152_arg0, f152_arg1, f152_arg2, f152_arg3, f152_arg4, f152_arg5)
	if Engine[0x5CB8E6B7FBBFFD5](f152_arg3.xuid) then
		Engine[0xD79B00C4CCE228B](Enum[0xBF54BE1BB3D618B][0xA1647599284110], f152_arg3.xuid)
	else
		Engine[0xE75D3BFE7A2FD4](f152_arg3.controller, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f152_arg3.xuid, Enum[0x3EB01916743DF12][0x75E935EEE527F8B])
		if CoD.isPC then
			CoD.PCUtility.ShowPlayerKickGameEvent(f152_arg3.xuid)
		end
	end
	if not f152_arg5 then
		f152_arg4:goBack(f152_arg2)
	end
end
function MutePlayer(f153_arg0, f153_arg1, f153_arg2, f153_arg3, f153_arg4, f153_arg5)
	if Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], f153_arg3.xuid) then
		Engine[0xE129224E5340749](f153_arg3.controller, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f153_arg3.xuid)
	end
	if Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f153_arg3.xuid) then
		Engine[0xE129224E5340749](f153_arg3.controller, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f153_arg3.xuid)
	end
	if not f153_arg5 then
		f153_arg4:goBack(f153_arg2)
	end
end
function UnMutePlayer(f154_arg0, f154_arg1, f154_arg2, f154_arg3, f154_arg4, f154_arg5)
	if Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], f154_arg3.xuid) then
		Engine[0xC2DA90B55A135AA](f154_arg3.controller, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f154_arg3.xuid)
	end
	if Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f154_arg3.xuid) then
		Engine[0xC2DA90B55A135AA](f154_arg3.controller, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f154_arg3.xuid)
	end
	if not f154_arg5 then
		f154_arg4:goBack(f154_arg2)
	end
end
function ShowSocialPartyWidget(f155_arg0)
	if CoD.perController[f155_arg0].Social_Party then
		CoD.perController[f155_arg0].Social_Party:setState(f155_arg0, "DefaultState")
	end
end
function LobbyOnlineCustomLaunchGame_SelectionList(f156_arg0, f156_arg1, f156_arg2)
	local f156_local0 = Engine[0x8DF2E5447F384B9]()
	f156_local0 = f156_local0.MapVote.timerActive
	if f156_local0 ~= nil then
		f156_local0:set(1)
	end
	Engine[0xB177D654FFB67BE]("skipto", "")
	Engine[0xB177D654FFB67BE]("sv_saveGameSkipto", "")
	CoD.LobbyUtility.LaunchGame(f156_arg0, f156_arg2, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
end
function LobbyOnlineStartMatchMaking(f157_arg0, f157_arg1, f157_arg2, f157_arg3)
	CoD.LobbyUtility.StartSearch(f157_arg0, f157_arg1, f157_arg3)
end
function OpenTheaterSelectFilm(f158_arg0, f158_arg1)
	CoD.FileshareUtility.SetFileshareMode(f158_arg1, Enum[0x25E8D8427CAB01][0x9F4C8230B0A89F2])
	CoD.FileshareUtility.SetCurrentUser(Engine[0x93B19E01B1FD1C7](f158_arg1))
	CoD.FileshareUtility.SetDirty()
	CoD.LobbyUtility.OpenTheaterSelectFilm(f158_arg0, f158_arg1)
end
function LobbyTheaterStartFilm(f159_arg0, f159_arg1)
	LobbyTheaterLaunchDemo(f159_arg0, f159_arg1)
end
function GoBackAndDisplayModalDialog(f160_arg0, f160_arg1, f160_arg2)
	f160_arg2(GoBack(f160_arg0, f160_arg1), f160_arg1)
end
function DisplayPlayGoJoinError(f161_arg0, f161_arg1)
	LuaUtils.UI_ShowWarningMessageDialog(f161_arg1, Engine[0xF9F1239CFD921FE](0x98057596B3D3C6B))
	GoBack(f161_arg0, f161_arg1)
end
function LobbyQuickJoin(f162_arg0, f162_arg1, f162_arg2, f162_arg3, f162_arg4, f162_arg5)
	if CoD.isPC then
		LobbyQuickJoinPC(f162_arg1, f162_arg2, f162_arg3, f162_arg4)
		return
	elseif LobbyData.GetLobbyNav() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) and IsFirstTimeSetup(f162_arg3, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]) then
		local f162_local0 = Engine[0x40E824FE270E174](f162_arg2:getModel(), "activity")
		if f162_local0 and GetSessionModeFromPresenceActivity(Engine[0x614D394F6F9A18D](f162_local0)) == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			if booleanArg == true then
				GoBackAndOpenOverlayOnParent(f162_arg1, "MPIntroRequired", f162_arg3)
			else
				OpenOverlay(f162_arg1, "MPIntroRequired", f162_arg3)
			end
			return
		end
	end
	local f162_local1 = false
	local f162_local0 = f162_arg2:getModel(f162_arg3, "joinable")
	if not f162_local0 then
		f162_local0 = f162_arg2:getModel(f162_arg3, "isJoinable")
	end
	if f162_local0 ~= nil then
		local f162_local2 = Engine[0x614D394F6F9A18D](f162_local0)
		if f162_local2 ~= nil and (f162_local2 == Enum[0xCA6AE10CC343A4F][0x1FD2A499E7CD0E4] or f162_local2 == Enum[0xCA6AE10CC343A4F][0xBFB4278A2E811D]) then
			f162_local1 = true
		end
	end
	if Dvar.twitchcon:exists() then
		f162_local1 = true
	end
	if not f162_local1 then
		return
	end
	f162_local0 = f162_arg2:getModel(f162_arg3, "xuid")
	if f162_local0 == nil then
		return
	end
	local f162_local2 = Engine[0x614D394F6F9A18D](f162_local0)
	if f162_local2 == nil then
		return
	end
	local f162_local3 = nil
	if f162_arg4 ~= nil and f162_arg4 >= 0 and f162_arg4 < Enum[0xC018C5F55467EB1][0xE22E4B4DDD5B19E] then
		f162_local3 = f162_arg4
	else
		f162_local3 = Enum[0xC018C5F55467EB1][0x4F9C7D45FC8CB0]
	end
	local f162_local4 = {
		controller = f162_arg3,
		xuid = f162_local2,
		joinType = f162_local3,
		platform = false,
	}
	if f162_arg5 ~= nil and f162_arg5 == true then
		GoBack(f162_arg1, f162_arg3)
	end
	if Engine[0x7B48C1ABFF0F764]() then
		if not Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f162_local4.xuid) then
			f162_local4.migrating = not CoDShared.QuitGame(f162_arg3)
			Engine[0x87AE7E64BA5AD61]("OnInGameJoin", f162_local4)
		end
	else
		Engine[0x87AE7E64BA5AD61]("OnJoin", f162_local4)
	end
end
function LobbyQuickJoinPC(f163_arg0, f163_arg1, f163_arg2, f163_arg3)
	local f163_local0 = f163_arg1:getModel(f163_arg2, "joinable")
	if not f163_local0 then
		f163_local0 = f163_arg1:getModel(f163_arg2, "isJoinable")
	end
	local f163_local1 = f163_local0 and Engine[0x614D394F6F9A18D](f163_local0)
	local f163_local2 = f163_arg1:getModel(f163_arg2, "xuid")
	local f163_local3 = f163_local2 and Engine[0x614D394F6F9A18D](f163_local2)
	local f163_local4 = nil
	if f163_arg3 and f163_arg3 >= 0 and f163_arg3 < Enum[0xC018C5F55467EB1][0xE22E4B4DDD5B19E] then
		f163_local4 = f163_arg3
	else
		f163_local4 = Enum[0xC018C5F55467EB1][0x4F9C7D45FC8CB0]
	end
	local f163_local5 = LobbyQuickJoinFinal(f163_arg0, f163_arg2, f163_local4, f163_local3, f163_local1)
	if f163_local5 and CoD.isPC then
		CoD.PCNotificationsUtility.HideNotificationWidget(f163_arg2)
		CoD.PCNotificationsUtility.CancelAllPartyInvites(f163_arg2)
	end
	return f163_local5
end
function LobbyQuickJoinWithXuid(f164_arg0, f164_arg1, f164_arg2)
	local f164_local0 = Engine[0xDC3B811A6](f164_arg1, f164_arg2)
	return LobbyQuickJoinFinal(f164_arg0, f164_arg1, Enum[0xC018C5F55467EB1][0xD4D58772DE8652], f164_arg2, f164_local0.info.joinable)
end
function LobbyQuickJoinFinal(f165_arg0, f165_arg1, f165_arg2, f165_arg3, f165_arg4)
	if not f165_arg0 or not f165_arg0:getMenu() then
		return false
	elseif CoD.isPC and f165_arg4 == Enum[0xCA6AE10CC343A4F][0x6252239318EF8A5] and not Engine[0xD3DDFE2224597C2](f165_arg1, f165_arg3) then
		return false
	elseif f165_arg4 ~= Enum[0xCA6AE10CC343A4F][0x1FD2A499E7CD0E4] and f165_arg4 ~= Enum[0xCA6AE10CC343A4F][0xBFB4278A2E811D] and f165_arg4 ~= Enum[0xCA6AE10CC343A4F][0x6252239318EF8A5] then
		return false
	elseif InFrontend() then
		local f165_local0 = f165_arg0:getMenu()
		SendClientScriptMenuChangeNotify(f165_arg1, f165_local0, false)
		GoBackToMenu(f165_local0, f165_arg1, "Director")
	end
	local f165_local0 = {
		controller = f165_arg1,
		xuid = f165_arg3,
		joinType = f165_arg2,
		platform = false,
	}
	if Engine[0x7B48C1ABFF0F764]() then
		if not Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f165_arg3) then
			f165_local0.migrating = not CoDShared.QuitGame(f165_arg1)
			Engine[0x87AE7E64BA5AD61]("OnInGameJoin", f165_local0)
		end
	else
		Engine[0x87AE7E64BA5AD61]("OnJoin", f165_local0)
	end
	return true
end
function LobbyInviteFriend(f166_arg0, f166_arg1, f166_arg2, f166_arg3)
	local f166_local0, f166_local1 = nil
	if f166_arg3 then
		f166_local0 = f166_arg3.xuid
		f166_local1 = f166_arg3.gamertag
	else
		f166_local0 = Engine[0x614D394F6F9A18D](f166_arg1:getModel(f166_arg2, "xuid"))
		f166_local1 = Engine[0x614D394F6F9A18D](f166_arg1:getModel(f166_arg2, "gamertag"))
	end
	if f166_local0 ~= nil then
		if CoD.isPC then
			CoD.invitePlayer(f166_arg2, f166_local0)
		else
			CoD.invitePlayerByGamertag(f166_arg2, f166_local0, f166_local1)
		end
	end
end
function LobbyInviteFriendGoBack(f167_arg0, f167_arg1, f167_arg2, f167_arg3, f167_arg4, f167_arg5)
	LobbyInviteFriend(f167_arg0, f167_arg1, f167_arg2, f167_arg3)
	if not f167_arg5 then
		GoBack(f167_arg0, f167_arg2)
	end
end
function LobbyInviteFriendByXuid(f168_arg0, f168_arg1, f168_arg2)
	if CoD.isPC then
		LobbyInviteFriend(f168_arg0, f168_arg1, f168_arg2, {
			xuid = Engine[0x614D394F6F9A18D](f168_arg1:getModel(f168_arg2, "xuid")),
		})
	end
end
function CancelPartyInvite(f169_arg0, f169_arg1, f169_arg2)
	Engine[0x406FC054276FCE6](f169_arg2, Engine[0x614D394F6F9A18D](f169_arg1:getModel(f169_arg2, "xuid")))
end
function LobbyRemoveLocalClientFromLobby(f170_arg0, f170_arg1)
	if not Engine[0xF285055A1A895A1](f170_arg1) or f170_arg1 == Engine[0xA5B9C0111291A8B]() then
		return
	else
		CoD.LobbyUtility.RemoveLocalPlayerFromTheLobby(f170_arg0, f170_arg1)
		CoD.perController[Engine[0xA5B9C0111291A8B]()].localClientChanged = true
		ForceLobbyButtonUpdate(f170_arg1)
	end
end
function CheckModeAvailableAndBackOut_ZM(f171_arg0, f171_arg1, f171_arg2)
	local f171_local0 = f171_arg0
	local f171_local1 = f171_arg0.subscribeToModel
	local f171_local2 = Engine[0x8DF2E5447F384B9]()
	f171_local1(f171_local0, f171_local2["lobbyRoot.lobbyNav"], function(f172_arg0)
		if IsZombies() and (CoD.PCKoreaUtility.ShowKorea15Plus() or Engine[0x5405A6484A88367]() or Engine[0xCB675CA7856DA25]()) then
			GoBackAndLeaveParty(f171_arg1, f171_arg2, LuaEnum.LEAVE_WITH_PARTY.WITHOUT)
		end
	end, false)
end
function GoBackAndLeaveParty(f173_arg0, f173_arg1, f173_arg2)
	local f173_local0 = GoBackToMenu(f173_arg0, f173_arg1, "Director")
	DisableAllMenuInput(f173_local0, nil)
	if f173_local0.ClientList ~= nil then
		f173_local0.ClientList:processEvent({
			name = "lose_focus",
			controller = f173_arg1,
		})
	end
	local f173_local1 = Engine[0x8DF2E5447F384B9]()
	f173_local1 = f173_local1.lobbyRoot.lobbyNav:get()
	if f173_local1 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		CoD.LobbyUtility.DisbandParty(f173_arg0, f173_arg1, f173_local1)
	else
		Engine[0x87AE7E64BA5AD61]("OnGoBack", {
			controller = f173_arg1,
			withParty = f173_arg2,
		})
	end
end
function SetState(f174_arg0, f174_arg1, f174_arg2)
	f174_arg0:setState(f174_arg2, f174_arg1)
end
function PulseElementToStateAndBack(f175_arg0, f175_arg1, f175_arg2)
	local f175_local0 = f175_arg0.currentState
	f175_arg0:setState(f175_arg2, f175_arg1)
	f175_arg0:setState(f175_arg2, f175_local0)
end
function SetMenuState(f176_arg0, f176_arg1, f176_arg2)
	f176_arg0:setState(f176_arg2, f176_arg1)
end
function SetElementState(f177_arg0, f177_arg1, f177_arg2, f177_arg3)
	f177_arg1:setState(f177_arg2, f177_arg3)
end
function SetElementStateByElementName(f178_arg0, f178_arg1, f178_arg2, f178_arg3)
	if f178_arg0[f178_arg1] then
		f178_arg0[f178_arg1]:setState(f178_arg2, f178_arg3)
	end
end
function SetStateByElementModel(f179_arg0, f179_arg1, f179_arg2, f179_arg3)
	local f179_local0 = CoD.SafeGetModelValue(f179_arg1:getModel(), f179_arg3)
	if f179_local0 then
		f179_arg0:setState(f179_arg2, f179_local0)
	end
end
function LockInput(f180_arg0, f180_arg1, f180_arg2)
	if f180_arg2 ~= nil then
		Engine[0x10BF7D7C03EECE6](f180_arg1, f180_arg2)
	end
end
function LockInputHUD(f181_arg0, f181_arg1, f181_arg2)
	if f181_arg2 ~= nil then
		Engine[0x10BF7D7C03EECE6](f181_arg1, f181_arg2, Enum[0x9061B48916076D5][0x59FF6C7FED5C383])
	end
end
function EnableMouseLockInputBinding(f182_arg0, f182_arg1, f182_arg2, f182_arg3)
	if CoD.isPC then
		if IsMouseOrKeyboard(f182_arg1) and f182_arg2 then
			Engine[0x6C9FBEF14D7451D](true)
			if f182_arg3 then
				Dvar[0x6A8F90E2C78062E]:set(true)
			end
			if not f182_arg0._mouseLockInputInputChangeSubscription then
				local f182_local0 = f182_arg0
				local f182_local1 = f182_arg0.subscribeToModel
				local f182_local2 = Engine[0x4DF5CFBC1771947](f182_arg1)
				f182_arg0._mouseLockInputInputChangeSubscription = f182_local1(f182_local0, f182_local2.LastInput, function()
					if IsGamepad(f182_arg1) then
						EnableMouseLockInputBinding(f182_arg0, f182_arg1, false, f182_arg3)
					end
				end, false)
			end
			SetAllowCursorMovement(f182_arg0, true)
		else
			Engine[0x6C9FBEF14D7451D](false)
			SetAllowCursorMovement(f182_arg0, false)
			if f182_arg0._mouseLockInputInputChangeSubscription then
				f182_arg0:removeSubscription(f182_arg0._mouseLockInputInputChangeSubscription)
				f182_arg0._mouseLockInputInputChangeSubscription = nil
			end
		end
	end
end
function EnableMouseLockInputForMap(f184_arg0, f184_arg1, f184_arg2)
	EnableMouseLockInputBinding(f184_arg0, f184_arg1, f184_arg2, Engine[0xD4D7317F380395F](f184_arg1, 0x908DA91B796EF6C) == 1)
end
function EnableMouseLockInputForInventory(f185_arg0, f185_arg1, f185_arg2)
	EnableMouseLockInputBinding(f185_arg0, f185_arg1, f185_arg2, Engine[0xD4D7317F380395F](f185_arg1, 0x4AE3D347A07EF76) == 1)
end
function ScaleWidgetToLabelCentered(f186_arg0, f186_arg1, f186_arg2)
	if f186_arg1 == nil then
		return
	else
		local f186_local0, f186_local1, f186_local2, f186_local3 = f186_arg0:getLocalLeftRight()
		local f186_local4, f186_local5, f186_local6, f186_local7 = f186_arg1:getLocalLeftRight()
		local f186_local8 = f186_arg1:getTextWidth()
		local f186_local9 = (f186_local3 + f186_local2) / 2
		local f186_local10 = f186_local8 + f186_arg2 * 2
		f186_arg0:setLeftRight(f186_local0, f186_local1, f186_local9 - f186_local10 / 2, f186_local9 + f186_local10 / 2)
	end
end
function ScaleWidgetToLabelCenteredWithMinimum(f187_arg0, f187_arg1, f187_arg2, f187_arg3)
	if f187_arg1 == nil then
		return
	else
		local f187_local0, f187_local1, f187_local2, f187_local3 = f187_arg0:getLocalLeftRight()
		local f187_local4 = f187_arg1:getTextWidth()
		local f187_local5 = (f187_local3 + f187_local2) / 2
		local f187_local6 = math.max(f187_local4 + f187_arg2 * 2, f187_arg3)
		f187_arg0:setLeftRight(f187_local0, f187_local1, f187_local5 - f187_local6 / 2, f187_local5 + f187_local6 / 2)
	end
end
function ScaleWidgetToLabelCenteredWrapped(f188_arg0, f188_arg1, f188_arg2, f188_arg3)
	if f188_arg1 == nil then
		return
	end
	local f188_local0, f188_local1, f188_local2, f188_local3 = f188_arg0:getLocalLeftRight()
	local f188_local4, f188_local5, f188_local6, f188_local7 = f188_arg1:getLocalLeftRight()
	if not f188_arg0._originalWidth then
		if f188_local4 == 0 and f188_local5 == 1 then
			f188_arg0._originalWidth = f188_local3 - f188_local2 + f188_local7 - f188_local6
		else
			f188_arg0._originalWidth = f188_local7 - f188_local6
		end
	end
	local f188_local8, f188_local9 = f188_arg1:getTextWidthAndHeight(f188_arg0._originalWidth)
	local f188_local10 = (f188_local3 + f188_local2) / 2
	local f188_local11 = f188_local8 + f188_arg2 * 2
	f188_arg0:setLeftRight(f188_local0, f188_local1, f188_local10 - f188_local11 / 2, f188_local10 + f188_local11 / 2)
	local f188_local12, f188_local13, f188_local14, f188_local15 = f188_arg0:getLocalTopBottom()
	f188_arg0:setTopBottom(f188_local12, f188_local13, f188_local14, f188_local9 + f188_local14 + f188_arg3)
end
function ScaleWidgetToLabelGlobalTextWidthCentered(f189_arg0, f189_arg1, f189_arg2)
	if f189_arg1 == nil then
		return
	else
		local f189_local0, f189_local1, f189_local2, f189_local3 = f189_arg0:getLocalLeftRight()
		local f189_local4 = f189_arg1:getGlobalTextWidth()
		local f189_local5 = (f189_local3 + f189_local2) / 2
		local f189_local6 = f189_local4 + f189_arg2 * 2
		f189_arg0:setLeftRight(f189_local0, f189_local1, f189_local5 - f189_local6 / 2, f189_local5 + f189_local6 / 2)
	end
end
function ScaleWidgetToLabelCore(f190_arg0, f190_arg1, f190_arg2, f190_arg3)
	if f190_arg1 == nil then
		return
	end
	local f190_local0, f190_local1, f190_local2, f190_local3 = f190_arg0:getLocalLeftRight()
	local f190_local4, f190_local5, f190_local6, f190_local7 = f190_arg0:getNextRect()
	local f190_local8 = f190_arg1:getTextWidth()
	if not f190_arg0.customGetWidth then
		f190_arg0.customGetWidth = CoD.FreeCursorUtility.GetWidthBySavedWidth
	end
	local f190_local9, f190_local10, f190_local11, f190_local12 = f190_arg1:getLocalLeftRight()
	if f190_local8 > 0 then
		f190_arg0.savedWidth = f190_local8 + 2 * f190_local11 + f190_arg2
		if not f190_arg0.widthOverridden then
			f190_arg0:setLeftRight(f190_local0, f190_local1, f190_local4, f190_local4 + f190_arg0.savedWidth)
		end
	else
		f190_arg0:setLeftRight(f190_local0, f190_local1, f190_local4, f190_local4)
	end
end
function SetStateFromText(f191_arg0, f191_arg1, f191_arg2, f191_arg3, f191_arg4)
	local f191_local0 = f191_arg3
	if f191_arg1 and f191_arg1:getTextWidth() ~= 0 then
		f191_local0 = f191_arg2
	end
	f191_arg0:setState(f191_arg4, f191_local0)
end
function ScaleWidgetToLabel(f192_arg0, f192_arg1, f192_arg2)
	ScaleWidgetToLabelCore(f192_arg0, f192_arg1, f192_arg2, true)
end
function ScaleWidgetToLabelLeftJustify(f193_arg0, f193_arg1, f193_arg2)
	ScaleWidgetToLabelCore(f193_arg0, f193_arg1, f193_arg2, false)
end
function ScaleWidgetToLabelWrapped(f194_arg0, f194_arg1, f194_arg2, f194_arg3)
	if f194_arg1 == nil then
		return
	end
	local f194_local0, f194_local1, f194_local2, f194_local3 = f194_arg0:getLocalLeftRight()
	local f194_local4, f194_local5, f194_local6, f194_local7 = f194_arg1:getLocalLeftRight()
	if not f194_arg0._originalWidth then
		f194_arg0._originalWidth = f194_local3 - f194_local2
	end
	f194_arg1:setLeftRight(true, false, f194_local6, f194_local6 + f194_arg0._originalWidth)
	local f194_local8, f194_local9 = f194_arg1:getTextWidthAndHeight(f194_arg0._originalWidth)
	if f194_arg0._originalWidth < f194_local8 then
		f194_local8 = f194_arg0._originalWidth
	end
	if f194_local8 > 0 then
		f194_arg0.savedWidth = f194_local8 + 2 * f194_local6 + f194_arg2
		f194_arg0:setLeftRight(f194_local0, f194_local1, f194_local2, f194_local2 + f194_arg0.savedWidth)
	else
		f194_arg0:setLeftRight(f194_local0, f194_local1, f194_local2, f194_local2)
	end
	local f194_local10, f194_local11, f194_local12, f194_local13 = f194_arg0:getLocalTopBottom()
	f194_arg0:setTopBottom(f194_local10, f194_local11, f194_local12, f194_local12 + f194_local9 + f194_arg3)
end
function ScaleWidgetToLabelWrappedUp(f195_arg0, f195_arg1, f195_arg2, f195_arg3)
	if f195_arg1 == nil then
		return
	end
	local f195_local0, f195_local1, f195_local2, f195_local3 = f195_arg0:getLocalLeftRight()
	local f195_local4, f195_local5, f195_local6, f195_local7 = f195_arg1:getLocalLeftRight()
	if not f195_arg0._originalWidth then
		f195_arg0._originalWidth = f195_local3 - f195_local2
	end
	local f195_local8, f195_local9 = f195_arg1:getTextWidthAndHeight(f195_arg0._originalWidth)
	if f195_arg0._originalWidth < f195_local8 then
		f195_arg0:setLeftRight(f195_local0, f195_local1, f195_local2, f195_local2 + f195_arg0._originalWidth)
	elseif f195_local8 > 0 then
		f195_arg0.savedWidth = f195_local8 + 2 * f195_local6 + f195_arg2
		f195_arg0:setLeftRight(f195_local0, f195_local1, f195_local2, f195_local2 + f195_arg0.savedWidth)
	else
		f195_arg0:setLeftRight(f195_local0, f195_local1, f195_local2, f195_local2)
	end
	local f195_local10, f195_local11, f195_local12, f195_local13 = f195_arg0:getLocalTopBottom()
	f195_arg0:setTopBottom(f195_local10, f195_local11, f195_local13 - f195_local9 - f195_arg3, f195_local13)
end
function SetContainerHeightToMultilineText(f196_arg0, f196_arg1, f196_arg2)
	local f196_local0 = f196_arg0:getParent()
	if f196_local0 ~= nil then
		local f196_local1, f196_local2 = f196_arg1:getTextWidthAndHeight()
		if f196_local2 > 0 then
			f196_local0:setHeight(f196_local2 + f196_arg2 * 2)
		else
			f196_local0:setHeight(0)
		end
	end
end
function SetContainerWidthToText(f197_arg0, f197_arg1, f197_arg2)
	local f197_local0 = f197_arg0:getParent()
	if f197_local0 ~= nil then
		local f197_local1, f197_local2 = f197_arg1:getTextWidthAndHeight()
		if f197_local1 > 0 then
			f197_local0:setWidth(f197_local1)
			f197_local0.savedWidth = f197_local1 + f197_arg2 * 4
		else
			f197_local0:setWidth(0)
			f197_local0.savedWidth = f197_arg2 * 4
		end
		f197_local0.customGetWidth = CoD.FreeCursorUtility.GetWidthBySavedWidth
	end
end
function UpdateWidgetHeightToMultilineText(f198_arg0, f198_arg1, f198_arg2)
	local f198_local0, f198_local1 = f198_arg1:getTextWidthAndHeight()
	if f198_local1 > 0 then
		f198_arg0:setHeight(f198_local1 + f198_arg2 * 2)
	else
		f198_arg0:setHeight(0)
	end
end
function UpdateWidgetHeightToMultilineTextWithMinimum(f199_arg0, f199_arg1, f199_arg2, f199_arg3)
	local f199_local0, f199_local1 = f199_arg1:getTextWidthAndHeight()
	f199_arg0:setHeight(math.max(f199_local1 + f199_arg2 * 2, f199_arg3))
end
function OverrideWidgetWidth(f200_arg0, f200_arg1)
	local f200_local0, f200_local1, f200_local2, f200_local3 = f200_arg0:getLocalLeftRight()
	f200_arg0.savedWidth = f200_local3 - f200_local2
	f200_arg0.widthOverridden = true
	f200_arg0:setWidth(f200_arg1)
end
function RestoreWidgetWidth(f201_arg0)
	if f201_arg0.savedWidth == nil then
		return
	else
		f201_arg0.widthOverridden = nil
		f201_arg0:setWidth(f201_arg0.savedWidth)
		f201_arg0.savedWidth = nil
	end
end
function SetWidth(f202_arg0, f202_arg1)
	f202_arg0.savedWidth = f202_arg0:getWidth()
	f202_arg0:setWidth(f202_arg1)
end
function RestoreWidgetHeight(f203_arg0)
	if f203_arg0.__savedHeight then
		f203_arg0:setHeight(f203_arg0.__savedHeight)
		f203_arg0.__savedHeight = nil
	end
end
function SetHeight(f204_arg0, f204_arg1)
	local f204_local0, f204_local1 = f204_arg0:getLocalSize()
	f204_arg0.__savedHeight = f204_local1
	f204_arg0:setHeight(f204_arg1)
end
function ScaleToElementWidth(f205_arg0, f205_arg1, f205_arg2)
	local f205_local0, f205_local1, f205_local2, f205_local3 = f205_arg1:getLocalLeftRight()
	f205_arg0:setWidth(f205_local3 - f205_local2 + f205_arg2)
end
function ScaleToElementHeight(f206_arg0, f206_arg1, f206_arg2)
	local f206_local0, f206_local1, f206_local2, f206_local3 = f206_arg1:getLocalTopBottom()
	f206_arg0:setHeight(f206_local3 - f206_local2 + f206_arg2)
end
function RecalculateScaleToElementHeight(f207_arg0, f207_arg1)
	local f207_local0 = 0
	local f207_local1 = f207_arg1:getSpacing()
	local f207_local2 = f207_arg1:getFirstChild()
	while f207_local2 ~= nil do
		local f207_local3, f207_local4, f207_local5, f207_local6 = f207_local2:getLocalTopBottom()
		if f207_local2:isVisible() then
			f207_local0 = f207_local0 + f207_local6 - f207_local5 + f207_local1
		end
		f207_local2 = f207_local2:getNextSibling()
	end
	if f207_local1 < f207_local0 then
		f207_local0 = f207_local0 - f207_local1
	end
	f207_arg0:setHeight(f207_local0)
end
function RecalculateScaleToElementWidth(f208_arg0, f208_arg1)
	local f208_local0 = 0
	local f208_local1 = f208_arg1:getSpacing()
	local f208_local2 = f208_arg1:getFirstChild()
	while f208_local2 ~= nil do
		if f208_local2:isVisible() then
			if f208_local2.id == "LUIText" then
				f208_local0 = f208_local0 + f208_local2:getTextWidth() + f208_local1
			else
				local f208_local3, f208_local4, f208_local5, f208_local6 = f208_local2:getLocalLeftRight()
				f208_local0 = f208_local0 + f208_local6 - f208_local5 + f208_local1
			end
		end
		f208_local2 = f208_local2:getNextSibling()
	end
	if f208_local1 < f208_local0 then
		f208_local0 = f208_local0 - f208_local1
	end
	f208_arg0:setWidth(f208_local0)
end
function ScaleWidthToWidestChildElement(f209_arg0)
	local f209_local0 = nil
	local f209_local1 = f209_arg0:getFirstChild()
	while f209_local1 ~= nil do
		if f209_local1:isVisible() then
			local f209_local2, f209_local3, f209_local4, f209_local5 = f209_local1:getLocalLeftRight()
			local f209_local6 = f209_local5 - f209_local4
			if not f209_local0 or f209_local0 < f209_local6 then
				f209_local0 = f209_local6
			end
		end
		f209_local1 = f209_local1:getNextSibling()
	end
	if f209_local0 then
		f209_arg0:setWidth(f209_local0)
	end
end
function TrimLabelIfLanguageReversed(f210_arg0, f210_arg1)
	if Engine[0x82373021BD410E]() then
		if f210_arg1 == nil then
			return
		else
			local f210_local0, f210_local1, f210_local2, f210_local3 = f210_arg1:getLocalLeftRight()
			f210_arg1:setLeftRight(f210_local0, f210_local1, f210_local2, f210_local2 + f210_arg1:getTextWidth() + 2)
			return
		end
	else
	end
end
function ScaleParentWidgetToLabel(f211_arg0, f211_arg1, f211_arg2)
	local f211_local0 = f211_arg0 and f211_arg0:getParent()
	if f211_arg1 == nil or f211_local0 == nil then
		return
	elseif f211_local0._originalWidth == nil then
		local f211_local1, f211_local2, f211_local3, f211_local4 = f211_local0:getLocalLeftRight()
		f211_local0._originalWidth = f211_local4 - f211_local3
	end
	local f211_local1, f211_local2, f211_local3, f211_local4 = f211_arg0:getLocalLeftRight()
	local f211_local5, f211_local6, f211_local7, f211_local8 = f211_local0:getLocalLeftRight()
	local f211_local9, f211_local10, f211_local11, f211_local12 = f211_arg1:getLocalLeftRight()
	f211_local0:setLeftRight(f211_local5, f211_local6, f211_local7, f211_local7 + f211_arg1:getTextWidth() + 2 * (f211_local3 + f211_local11) + f211_arg2)
end
function ScaleParentWidgetToElementLabel(f212_arg0, f212_arg1, f212_arg2)
	if f212_arg0[f212_arg1] then
		ScaleParentWidgetToLabel(f212_arg0, f212_arg0[f212_arg1], f212_arg2)
	end
end
function RestoreParentToOriginalWidth(f213_arg0)
	local f213_local0 = f213_arg0 and f213_arg0:getParent()
	if f213_local0 and f213_local0._originalWidth ~= nil then
		local f213_local1, f213_local2, f213_local3, f213_local4 = f213_local0:getLocalLeftRight()
		f213_local0:setLeftRight(f213_local1, f213_local2, f213_local3, f213_local3 + f213_local0._originalWidth)
	end
end
function ScaleWidgetToLabelRightAligned(f214_arg0, f214_arg1, f214_arg2)
	if f214_arg1 == nil then
		return
	else
		local f214_local0, f214_local1, f214_local2, f214_local3 = f214_arg0:getLocalLeftRight()
		local f214_local4, f214_local5, f214_local6, f214_local7 = f214_arg1:getLocalLeftRight()
		f214_arg0:setLeftRight(f214_local0, f214_local1, f214_local3 - f214_arg1:getTextWidth() + 2 * f214_local7 - f214_arg2, f214_local3)
	end
end
function ScaleToFitImageElement(f215_arg0, f215_arg1, f215_arg2)
	local f215_local0 = f215_arg0[f215_arg2]
	if f215_local0 then
		local f215_local1, f215_local2 = f215_local0:getImageDimensions()
		if f215_local1 > 0 and f215_local2 > 0 then
			local f215_local3, f215_local4, f215_local5 = f215_local0:getLocalLeftRight()
			local f215_local6, f215_local7, f215_local8, f215_local9 = f215_local0:getLocalTopBottom()
			local f215_local10, f215_local11, f215_local12, f215_local13 = f215_arg1:getLocalLeftRight()
			local f215_local14, f215_local15, f215_local16, f215_local17 = f215_arg1:getLocalTopBottom()
			f215_arg1:setLeftRight(true, false, f215_local12, math.floor((f215_local5 * 2 + (f215_local17 + f215_local9 - f215_local8) * f215_local1 / f215_local2 - 1) / 2) * 2)
			f215_arg1:setTopBottom(true, false, f215_local16, f215_local17)
		end
	end
end
function GoBackThroughAllAndClose(f216_arg0, f216_arg1)
	while f216_arg0 do
		while not f216_arg0.menuName do
			f216_arg0 = f216_arg0:getParent()
		end
		local f216_local0, f216_local1 = CoD.Menu.GetNavigationForMenu(f216_arg1, f216_arg0.menuName)
		if f216_local0 == 1 then
			Close(f216_arg0, f216_arg1)
			return
		end
		f216_arg0 = GoBack(f216_arg0, f216_arg1)
	end
	while not f216_arg0.menuName do
		f216_arg0 = f216_arg0:getParent()
	end
	local f216_local0, f216_local1 = CoD.Menu.GetNavigationForMenu(f216_arg1, f216_arg0.menuName)
	if f216_local0 == 1 then
		Close(f216_arg0, f216_arg1)
		return
	end
	f216_arg0 = GoBack(f216_arg0, f216_arg1)
end
function LobbyGoBack(f217_arg0, f217_arg1)
	if not f217_arg0:getParent() then
		return
	end
	local f217_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav")
	local f217_local1 = Engine[0x614D394F6F9A18D](f217_local0)
	local f217_local2 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.showSelect")
	if f217_local0 and (f217_local1 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN) or f217_local1 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) and f217_local2:get()) then
		DisableAllMenuInput(f217_arg0, true)
	end
	CoD.LobbyUtility.LobbyGoBack(f217_arg0, f217_arg1)
	f217_arg0:playSound("menu_go_back")
end
function DisplayPlayGoWarning(f218_arg0, f218_arg1)
	local f218_local0 = CoD.OverlayUtility.CreateOverlay(f218_arg1, f218_arg0, "GenericModalDialog", "", "MENU/STILLDOWNLOADING", "t7_icon_connect_overlays_bkg", {
		0x154E30A1DF77FF1,
	}, function(f219_arg0)
		return true
	end)
	f218_local0.anyControllerAllowed = true
	f218_local0.unusedControllerAllowed = true
end
function EnableAnyController(f220_arg0, f220_arg1)
	f220_arg0.anyControllerAllowed = true
end
function LobbyBeginPlay(f221_arg0, f221_arg1)
	if (IsOrbis() or IsDurango() and not Engine[0xCB675CA7856DA25]()) and Engine[0x7D47312EBA41751]() and not CoD.perController[f221_arg1].hasShownPlaygoWarning then
		CoD.perController[f221_arg1].hasShownPlaygoWarning = true
		DisplayPlayGoWarning(f221_arg0, f221_arg1)
		return false
	else
		CoD.LobbyUtility.BeginPlay(f221_arg0, f221_arg1)
		return true
	end
end
function SizeToSafeArea(f222_arg0, f222_arg1)
	f222_arg0:sizeToSafeArea(f222_arg1, false)
end
function SizeToHudArea(f223_arg0, f223_arg1)
	f223_arg0:sizeToSafeArea(f223_arg1, true)
end
function SizeToWidthOfScreen(f224_arg0, f224_arg1)
	f224_arg0:sizeToWidthOfScreen(f224_arg1)
end
function GoBackMultiple(f225_arg0, f225_arg1, f225_arg2)
	while 0 < f225_arg2 do
		f225_arg0 = GoBack(f225_arg0, f225_arg1)
		f225_arg2 = f225_arg2 - 1
	end
	return f225_arg0
end
function GoBack(f226_arg0, f226_arg1)
	if not f226_arg0 or Rat and Rat.DisableGoBack then
		return
	end
	while not f226_arg0.menuName do
		f226_arg0 = f226_arg0:getParent()
	end
	local f226_local0, f226_local1 = CoD.Menu.GetNavigationForMenu(f226_arg1, f226_arg0.menuName)
	if f226_local0 and f226_local1 then
		f226_arg0.previousMenuName = CoD.MenuNavigation[f226_arg1][f226_local0][f226_local1 - 1]
		CoD.MenuNavigation[f226_arg1][f226_local0][f226_local1] = nil
		if #CoD.MenuNavigation[f226_arg1][f226_local0] == 0 then
			table.remove(CoD.MenuNavigation[f226_arg1], f226_local0)
		else
		end
	end
	f226_arg0:saveState(f226_arg1)
	return f226_arg0:goBack(f226_arg1)
end
function DelayGoBack(f227_arg0, f227_arg1, f227_arg2)
	if not f227_arg2 then
		f227_arg2 = 0
	end
	f227_arg0:addElement(LUI.UITimer.newElementTimer(f227_arg2, true, function()
		GoBack(f227_arg0, f227_arg1)
	end))
end
function DelayUnhideFreecursorGoBack(f229_arg0, f229_arg1, f229_arg2)
	if not f229_arg2 then
		f229_arg2 = 0
	end
	f229_arg0:addElement(LUI.UITimer.newElementTimer(f229_arg2, true, function()
		MenuUnhideFreeCursor(f229_arg0, f229_arg1)
		GoBack(f229_arg0, f229_arg1)
	end))
end
function DelayCloseAndGoBack(f231_arg0, f231_arg1, f231_arg2)
	if not f231_arg2 then
		f231_arg2 = 0
	end
	f231_arg0:addElement(LUI.UITimer.newElementTimer(f231_arg2, true, function()
		GoBack(GoBack(f231_arg0, f231_arg1), f231_arg1)
	end))
end
function PrepareNavigationInDirectorRoot(f233_arg0)
	if not CoD.MenuNavigation then
		CoD.MenuNavigation = {}
	end
	if not CoD.MenuNavigation[f233_arg0] or #CoD.MenuNavigation[f233_arg0] == 0 then
		CoD.MenuNavigation[f233_arg0] = {
			{
				"Director",
			},
		}
	end
end
function GoBackToMenu(f234_arg0, f234_arg1, f234_arg2)
	local f234_local0, f234_local1 = CoD.Menu.GetNavigationForMenuToMenu(f234_arg1, f234_arg0.menuName, f234_arg2)
	local f234_local2, f234_local3 = CoD.Menu.GetNavigationForMenu(f234_arg1, f234_arg0.menuName)
	local f234_local4, f234_local5 = CoD.Menu.GetNavigationForMenu(f234_arg1, f234_arg2)
	if not f234_local2 or not f234_local3 or not f234_local4 or not f234_local5 then
		if CoD.isPC and f234_arg0.id == "Menu.Director" and f234_arg2 == "Director" then
			return f234_arg0
		else
			return GoBack(f234_arg0, f234_arg1)
		end
	elseif f234_arg0.menuName == f234_arg2 then
		return f234_arg0
	elseif f234_arg0.occludedMenu and f234_arg0.occludedMenu.menuName == f234_arg2 then
		f234_arg0.previousMenuName = nil
		table.remove(CoD.MenuNavigation[f234_arg1], f234_local2)
	elseif f234_local0 and f234_local1 then
		f234_arg0.previousMenuName = CoD.MenuNavigation[f234_arg1][f234_local0][f234_local1]
		local f234_local6 = #CoD.MenuNavigation[f234_arg1][f234_local0]
		for f234_local7 = f234_local1 + 1, f234_local6, 1 do
			CoD.MenuNavigation[f234_arg1][f234_local0][f234_local7] = nil
		end
		if #CoD.MenuNavigation[f234_arg1][f234_local0] == 0 then
			table.remove(CoD.MenuNavigation[f234_arg1], f234_local0)
		end
		if f234_local2 ~= f234_local0 then
			table.remove(CoD.MenuNavigation[f234_arg1], f234_local2)
		end
	elseif f234_arg0.occludedMenu then
		local f234_local6 = f234_arg0
		for f234_local7 = f234_local2, f234_local4 + 1, -1 do
			local f234_local10 = f234_local7
			if not f234_local6.occludedMenu then
				return f234_local6
			end
			f234_local6 = GoBackToMenu(f234_local6, f234_arg1, f234_local6.occludedMenu.menuName)
			if not f234_local6 then
				break
			end
		end
		if f234_local6 == nil or f234_local6.menuName == f234_arg2 then
			return f234_local6
		end
		return GoBackToMenu(f234_local6, f234_arg1, f234_arg2)
	end
	f234_arg0:saveState(f234_arg1)
	return CoD.Menu.goBack(f234_arg0, f234_arg1)
end
function GoBackAndUpdateStateOnPreviousMenu(f235_arg0, f235_arg1)
	local f235_local0 = GoBack(f235_arg0, f235_arg1)
	f235_local0:processEvent({
		name = "update_state",
		controller = f235_arg1,
		forceDispatch = true,
	})
	return f235_local0
end
function Close(f236_arg0, f236_arg1)
	while not f236_arg0.menuName do
		f236_arg0 = f236_arg0:getParent()
	end
	local f236_local0, f236_local1 = CoD.Menu.GetNavigationForMenu(f236_arg1, f236_arg0.menuName)
	if f236_local0 and f236_local1 then
		f236_arg0.previousMenuName = CoD.MenuNavigation[f236_arg1][f236_local0][f236_local1 - 1]
		CoD.MenuNavigation[f236_arg1][f236_local0][f236_local1] = nil
		if #CoD.MenuNavigation[f236_arg1][f236_local0] == 0 then
			table.remove(CoD.MenuNavigation[f236_arg1], f236_local0)
		end
	end
	f236_arg0:saveState(f236_arg1)
	f236_arg0:close()
end
function NavigateToLobby_SelectionList(f237_arg0, f237_arg1, f237_arg2, f237_arg3, f237_arg4)
	if f237_arg3 == LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM then
		Dvar[0x8CA6583B1EFAB4B]:set(Engine[0xB72F603CAC75B3A](f237_arg2, "com_privategame_ranked_zm") ~= 0)
		Engine[0x95FA783443EBEC3](f237_arg2)
	end
	local f237_local0 = LobbyData.GetLobbyMenuByName(f237_arg3)
	if f237_local0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x58ECA70A244C08F] and Engine[0x9E5BE3B4BBA4E0E]("arena_maintenance") == true then
		LuaUtils.UI_ShowErrorMessageDialog(f237_arg2, 0xDD0FACA77FB825A, 0x2DF6ED539CA406A)
		return
	end
	local f237_local1 = Engine[0x9E5BE3B4BBA4E0E]("probation_public_enabled")
	local f237_local2 = Engine[0x9E5BE3B4BBA4E0E]("probation_league_enabled")
	if f237_local0[0x4CB6F0DC5F1CA97] and (f237_local0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x95910ACF90F64AD] or f237_local0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x58ECA70A244C08F]) then
		Engine[0x8507161483F8C1C](f237_arg2, f237_local0[0xF7AE5746E79F2CE])
		local f237_local3 = Engine[0x5E6ED4C2EE3D514](f237_arg2, f237_local0[0xF7AE5746E79F2CE])
		if f237_local3 > 0 then
			local f237_local4 = Engine[0x4D6C65B1E9D065F](f237_local3)
			if f237_local1 and f237_local0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x95910ACF90F64AD] then
				LuaUtils.UI_ShowErrorMessageDialog(f237_arg2, Engine[0xF9F1239CFD921FE](0xA5BCA09BFBE90BB, f237_local4), 0x9AEEA73CA9BBA3)
				return
			elseif f237_local2 and f237_local0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x58ECA70A244C08F] then
				LuaUtils.UI_ShowErrorMessageDialog(f237_arg2, Engine[0xF9F1239CFD921FE](0x1E60B8AE3979C41, f237_local4), 0x9AEEA73CA9BBA3)
				return
			end
		elseif Engine[0x8A40E4C4E656286](f237_local0[0xF7AE5746E79F2CE]) then
			if f237_local1 and f237_local0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x95910ACF90F64AD] then
				LuaUtils.UI_ShowErrorMessageDialog(f237_arg2, 0x8F60BFC521CBE84)
				return
			elseif f237_local2 and f237_local0[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0x58ECA70A244C08F] then
				LuaUtils.UI_ShowErrorMessageDialog(f237_arg2, 0x2B597460DFBDD08)
				return
			end
		end
	end
	UpdateDifficulty(f237_arg0, f237_arg3, f237_arg2)
	CoD.LobbyUtility.NavigateToLobby(f237_arg4, f237_arg3, false, f237_arg2)
end
function NavigateToLobby_FirstTimeFlowMP(f238_arg0, f238_arg1, f238_arg2, f238_arg3) end
function NavigateToMenu(f239_arg0, f239_arg1, f239_arg2, f239_arg3)
	while f239_arg0 and not f239_arg0.openMenu do
		f239_arg0 = f239_arg0:getParent()
	end
	if not f239_arg0 then
		return
	elseif not CoD.MenuNavigation then
		CoD.MenuNavigation = {}
	end
	if not CoD.MenuNavigation[f239_arg3] then
		CoD.MenuNavigation[f239_arg3] = {
			{
				f239_arg0.menuName,
			},
		}
	end
	local f239_local0, f239_local1 = CoD.Menu.GetNavigationForMenu(f239_arg3, f239_arg0.menuName)
	if not f239_local0 or not f239_local1 then
		CoD.MenuNavigation[f239_arg3] = {
			{
				f239_arg0.menuName,
			},
		}
		f239_local0, f239_local1 = CoD.Menu.GetNavigationForMenu(f239_arg3, f239_arg0.menuName)
	end
	local f239_local2 = f239_arg0.userData
	local f239_local3 = f239_arg0.menuName
	local f239_local4 = f239_arg0.occludedMenu
	local f239_local5 = f239_arg0:getParent()
	f239_arg0:saveState(f239_arg3)
	f239_arg0:close()
	local f239_local6 = f239_arg0:replaceMenu(f239_arg1, f239_arg3, nil, f239_local2, f239_local3, f239_local4, f239_local5)
	if f239_local0 and f239_local1 then
		if f239_arg2 then
			table.insert(CoD.MenuNavigation[f239_arg3][f239_local0], f239_local1 + 1, f239_local6.menuName)
		else
			CoD.MenuNavigation[f239_arg3][f239_local0][f239_local1] = f239_local6.menuName
		end
	end
	return f239_local6
end
function OpenPopup(f240_arg0, f240_arg1, f240_arg2, f240_arg3)
	local f240_local0 = f240_arg0
	while f240_local0 and not f240_local0.openMenu do
		f240_local0 = f240_local0:getParent()
	end
	local f240_local1 = f240_local0:openPopup(f240_arg1, f240_arg2, f240_arg3)
	if not CoD.MenuNavigation then
		CoD.MenuNavigation = {}
	end
	if not CoD.MenuNavigation[f240_arg2] then
		CoD.MenuNavigation[f240_arg2] = {}
	end
	local f240_local2, f240_local3 = CoD.Menu.GetNavigationForMenu(f240_arg2, f240_arg0.menuName)
	if f240_local2 and f240_local3 then
		table.insert(CoD.MenuNavigation[f240_arg2], f240_local2 + 1, {
			f240_local1.menuName,
		})
	else
		table.insert(CoD.MenuNavigation[f240_arg2], {
			f240_local1.menuName,
		})
	end
	return f240_local1
end
function SetElementPriority(f241_arg0, f241_arg1)
	f241_arg0:setPriority(f241_arg1)
end
function OpenPopupWithPriority(f242_arg0, f242_arg1, f242_arg2, f242_arg3)
	local f242_local0 = OpenPopup(f242_arg0, f242_arg1, f242_arg2)
	f242_local0:setPriority(f242_arg3)
end
function OpenOverlay(f243_arg0, f243_arg1, f243_arg2, f243_arg3)
	local f243_local0 = f243_arg0
	while f243_local0 and not f243_local0.openMenu do
		f243_local0 = f243_local0:getParent()
	end
	local f243_local1 = f243_local0:openOverlay(f243_arg1, f243_arg2, f243_arg3)
	if not CoD.MenuNavigation then
		CoD.MenuNavigation = {}
	end
	if not CoD.MenuNavigation[f243_arg2] then
		CoD.MenuNavigation[f243_arg2] = {}
	end
	table.insert(CoD.MenuNavigation[f243_arg2], {
		f243_local1.menuName,
	})
	return f243_local1
end
function DelayOpenOverlay(f244_arg0, f244_arg1, f244_arg2, f244_arg3)
	f244_arg0:addElement(LUI.UITimer.newElementTimer(80, true, function()
		OpenOverlay(f244_arg0, f244_arg1, f244_arg2, f244_arg3)
	end))
end
function OpenOverlay_NoDependency(f246_arg0, f246_arg1, f246_arg2, f246_arg3)
	OpenOverlay(f246_arg0, f246_arg1, f246_arg2, f246_arg3)
end
function OpenSystemOverlay(f247_arg0, f247_arg1, f247_arg2, f247_arg3, f247_arg4)
	CoD.OverlayUtility.CreateOverlay(f247_arg2, f247_arg1, f247_arg3, f247_arg2, f247_arg4)
end
function PerformOverlayBack(f248_arg0, f248_arg1)
	if HasOverlayBackAction(f248_arg0) then
		f248_arg0[CoD.OverlayUtility.GoBackPropertyName](f248_arg0, f248_arg1)
	end
end
function PerformOverlayContinue(f249_arg0, f249_arg1)
	if HasOverlayContinueAction(f249_arg0) then
		f249_arg0[CoD.OverlayUtility.ContinuePropertyName](f249_arg0, f249_arg1)
	end
end
function GoBackAndOpenOverlayOnParent(f250_arg0, f250_arg1, f250_arg2)
	local f250_local0 = GoBack(f250_arg0, f250_arg2)
	f250_local0:openOverlay(f250_arg1, f250_arg2)
end
function OpenGenericSmallPopup(f251_arg0, f251_arg1, f251_arg2, f251_arg3, f251_arg4, f251_arg5, f251_arg6, f251_arg7)
	return CoD.OverlayUtility.CreateOverlay(f251_arg1, f251_arg0, "GenericPopup", CoD.OverlayUtility.GenericPopupSizes.Small, f251_arg2, f251_arg3, f251_arg4, f251_arg5, f251_arg6, f251_arg7)
end
function SendMenuResponse(f252_arg0, f252_arg1, f252_arg2, f252_arg3)
	Engine[0xC554A8C36EF7EFF](f252_arg3, f252_arg1, f252_arg2, 0)
end
function SendOwnMenuResponse(f253_arg0, f253_arg1, f253_arg2)
	Engine[0xC554A8C36EF7EFF](f253_arg1, f253_arg0.menuName, f253_arg2, 0)
end
function ClearMenuSavedState(f254_arg0)
	f254_arg0:clearSavedState()
end
function CloseContextualMenu(f255_arg0, f255_arg1)
	if CoD.isPC then
		CoD.PCWidgetUtility.CloseContextualMenu(f255_arg0, f255_arg1)
	end
end
function PlayClip(f256_arg0, f256_arg1, f256_arg2)
	f256_arg0:playClip(f256_arg1)
end
function PlayClipOnElement(f257_arg0, f257_arg1, f257_arg2)
	if f257_arg0[f257_arg1.elementName] then
		f257_arg0[f257_arg1.elementName]:playClip(f257_arg1.clipName)
	end
end
function PlayClipOnListItemElement(f258_arg0, f258_arg1, f258_arg2, f258_arg3)
	f258_arg1:playClip(f258_arg3)
end
function DelayedPlayClip(f259_arg0, f259_arg1, f259_arg2)
	f259_arg0:addElement(LUI.UITimer.newElementTimer(f259_arg1, true, function()
		f259_arg0:playClip(f259_arg2)
	end))
end
function SetFocusToElement(f261_arg0, f261_arg1, f261_arg2)
	if f261_arg0[f261_arg1] then
		f261_arg0[f261_arg1]:processEvent({
			name = "gain_focus",
			controller = f261_arg2,
		})
		f261_arg0[f261_arg1]._readyForCustomFocus = true
	end
end
function DelaySetFocusToElement(f262_arg0, f262_arg1, f262_arg2, f262_arg3)
	if not f262_arg3 then
		f262_arg3 = 0
	end
	f262_arg0:addElement(LUI.UITimer.newElementTimer(f262_arg3, true, function()
		SetFocusToElement(f262_arg0, f262_arg1, f262_arg2)
	end))
end
function SetLoseFocusToElement(f264_arg0, f264_arg1, f264_arg2)
	if f264_arg0[f264_arg1] then
		f264_arg0[f264_arg1]:processEvent({
			name = "lose_focus",
			controller = f264_arg2,
		})
		f264_arg0[f264_arg1]._readyForCustomFocus = false
	end
end
function SetFocusToSelf(f265_arg0, f265_arg1)
	f265_arg0:processEvent({
		name = "gain_focus",
		controller = f265_arg1,
	})
	f265_arg0._readyForCustomFocus = true
end
function SetLoseFocusToSelf(f266_arg0, f266_arg1)
	f266_arg0:processEvent({
		name = "lose_focus",
		controller = f266_arg1,
	})
	f266_arg0._readyForCustomFocus = false
end
function CheckDefaultPCFocus(f267_arg0, f267_arg1, f267_arg2)
	if not CoD.isPC then
		return
	else
		f267_arg1:DelayedCheckDefaultFocusImpl(f267_arg0, f267_arg2, false, 0)
	end
end
function SetUsingFocusInterraction(f268_arg0, f268_arg1)
	f268_arg0:setUsingFocusInteraction(f268_arg1)
end
function ForceCheckDefaultPCFocus(f269_arg0, f269_arg1, f269_arg2)
	if not CoD.isPC then
		return
	else
		f269_arg1:DelayedCheckDefaultFocusImpl(f269_arg0, f269_arg2, true, 0)
	end
end
function DelayedForceCheckDefaultPCFocus(f270_arg0, f270_arg1, f270_arg2, f270_arg3)
	if not CoD.isPC then
		return
	elseif not f270_arg3 then
		f270_arg3 = 0
	end
	f270_arg1:DelayedCheckDefaultFocusImpl(f270_arg0, f270_arg2, true, f270_arg3)
end
function ChangeDefaultFocus(f271_arg0, f271_arg1)
	f271_arg0.__defaultFocus = f271_arg1
end
function MakeElementFocusable(f272_arg0, f272_arg1, f272_arg2)
	if f272_arg0[f272_arg1] then
		f272_arg0[f272_arg1]:makeFocusableWithoutResettingNavigation(f272_arg2)
	end
end
function MakeElementNotFocusable(f273_arg0, f273_arg1, f273_arg2)
	if f273_arg0[f273_arg1] then
		f273_arg0[f273_arg1]:makeNotFocusable(f273_arg2)
	end
end
function MakeFocusable(f274_arg0, f274_arg1)
	f274_arg0:makeFocusableWithoutResettingNavigation(f274_arg1)
end
function MakeNotFocusable(f275_arg0, f275_arg1)
	f275_arg0:makeNotFocusable(f275_arg1)
end
function SetAllowCursorMovement(f276_arg0, f276_arg1)
	f276_arg0.ignoreCursor = not f276_arg1
end
function DisableNavigation(f277_arg0, f277_arg1)
	f277_arg0[f277_arg1].m_disableNavigation = true
end
function EnableNavigation(f278_arg0, f278_arg1)
	f278_arg0[f278_arg1].m_disableNavigation = false
end
function SetElementCanBeNavigatedTo(f279_arg0, f279_arg1)
	f279_arg0.m_cannotBeSelectedByDefaultNavigation = not f279_arg1
end
function DisableKeyboardNavigationByElement(f280_arg0)
	if CoD.isPC and f280_arg0 then
		f280_arg0.m_disableKeyboardNavigation = true
	end
end
function EnableKeyboardNavigationByElement(f281_arg0)
	if CoD.isPC and f281_arg0 then
		f281_arg0.m_disableKeyboardNavigation = false
	end
end
function DisableAllMenuInput(f282_arg0, f282_arg1)
	f282_arg0.m_disableAllButtonActions = f282_arg1
end
function ClearRecordedFocus(f283_arg0, f283_arg1)
	if CoD.isPC then
		if CoD.GetMouseFocus(f283_arg1) and f283_arg0:isParentOf(CoD.GetMouseFocus(f283_arg1)) then
			f283_arg0:ChangeFocusedElement(f283_arg1, nil, false)
		end
		f283_arg0:ChangeInputFocus(f283_arg1, nil)
	else
		CoD.Menu.ClearRecordedFocus(f283_arg0, {
			controller = f283_arg1,
		})
	end
end
function ClearRecordedFocusIfFocusAncestor(f284_arg0, f284_arg1, f284_arg2)
	if CoD.GetMouseFocus(f284_arg1) ~= nil and CoD.Menu.IsAncestorOf(f284_arg2, CoD.GetMouseFocus(f284_arg1)) then
		CoD.Menu.ClearRecordedFocus(f284_arg0, {
			controller = f284_arg1,
		})
	end
end
function ClearRecordedInputFocusIfInputFocusAncestor(f285_arg0, f285_arg1, f285_arg2)
	if CoD.isPC and f285_arg0.currentInputFocus ~= nil and CoD.Menu.IsAncestorOf(f285_arg2, f285_arg0.currentInputFocus) then
		CoD.Menu.ClearRecordedInputFocus(f285_arg0, {
			controller = f285_arg1,
		})
	end
end
function RestartMission(f286_arg0, f286_arg1, f286_arg2)
	local f286_local0 = f286_arg0
	while f286_local0 and not f286_local0.openMenu do
		f286_local0 = f286_local0:getParent()
	end
	CoD.OverlayUtility.CreateOverlay(f286_arg2, f286_local0, "RestartMissionPopup")
end
function EndTrainingSim(f287_arg0, f287_arg1, f287_arg2)
	Engine[0xC554A8C36EF7EFF](f287_arg2, "StartMenu", "EndTrainingSim", 0)
	StartMenuResumeGame(f287_arg0, f287_arg2)
	GoBack(f287_arg0, f287_arg2)
end
function QuitGame(f288_arg0, f288_arg1, f288_arg2)
	local f288_local0 = f288_arg0
	while f288_local0 and not f288_local0.openMenu do
		f288_local0 = f288_local0:getParent()
	end
	CoD.OverlayUtility.CreateOverlay(f288_arg2, f288_local0, "QuitGamePopup")
end
function SaveAndQuitGame(f289_arg0, f289_arg1, f289_arg2)
	local f289_local0 = f289_arg0
	while f289_local0 and not f289_local0.openMenu do
		f289_local0 = f289_local0:getParent()
	end
	CoD.OverlayUtility.CreateOverlay(f289_arg2, f289_local0, "SaveAndQuitGamePopup")
end
function RestartGame(f290_arg0, f290_arg1, f290_arg2)
	local f290_local0 = f290_arg0
	while f290_local0 and not f290_local0.openMenu do
		f290_local0 = f290_local0:getParent()
	end
	CoD.OverlayUtility.CreateOverlay(f290_arg2, f290_local0, "RestartGamePopup")
end
function RestartGameImmediate(f291_arg0, f291_arg1)
	Engine[0xB177D654FFB67BE]("cl_paused", 0)
	Dvar[0x4488B7C651BD0EC]:set(1)
	Engine[0x7C75E608EA39B5C](f291_arg1, "stopControllerRumble")
	Engine[0x7C75E608EA39B5C](f291_arg1, "fade 0 0 0 255 0 0 1")
	Engine[0x7C75E608EA39B5C](f291_arg1, "silence")
	local f291_local0 = LobbyData.GetCurrentMenuTarget()
	if (Engine[0xC68FC14365BB66B](Enum[0x1DD23D27A61F09A][0x3E66A586897A605]) == true) or (Engine[0xC68FC14365BB66B](Enum[0x1DD23D27A61F09A][0xB674220A0C7377]) == true) or f291_local0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM) then
		Engine[0x7C75E608EA39B5C](f291_arg1, "fast_restart")
	else
		SendOwnMenuResponse(f291_arg0, f291_arg1, "restart_level_zm")
	end
end
function ResumeEndGame(f292_arg0, f292_arg1)
	SendOwnMenuResponse(f292_arg0, f292_arg1, "resume_end_game")
end
function ChooseClass(f293_arg0, f293_arg1, f293_arg2, f293_arg3, f293_arg4)
	f293_arg4:saveState(f293_arg2)
	if IsMultiplayer() then
		Engine[0xC554A8C36EF7EFF](f293_arg2, "PositionDraft", "opendraft", 0)
		f293_arg4:openMenu(CoD.CACUtility.PositionDraftMenuName, f293_arg2)
	else
		f293_arg4:openMenu(CoD.CACUtility.ChangeClassMenuName, f293_arg2)
	end
	f293_arg4:close()
end
function QuitGame_MP(f294_arg0, f294_arg1, f294_arg2, f294_arg3, f294_arg4)
	if Engine[0xA1D8D9E5D79905F]() then
		Engine[0xB177D654FFB67BE]("cl_paused", 0)
	end
	StartMenuGoBack(f294_arg4, f294_arg2)
	CoDShared.QuitGame(f294_arg2, not CoD.StartMenuUtility.GetArenaQuitDeservesExtraPenalty(f294_arg2))
end
function QuitGame_Raw(f295_arg0, f295_arg1, f295_arg2, f295_arg3, f295_arg4)
	if Engine[0xA1D8D9E5D79905F]() then
		Engine[0xB177D654FFB67BE]("cl_paused", 0)
	end
	CoDShared.QuitGame(f295_arg2)
end
function SendClientScriptDebugMenuNotify(f296_arg0, f296_arg1, f296_arg2)
	local f296_local0 = f296_arg0.cscDebugMenuList
	Engine[0x6ABA4D7F0840A1E](f296_arg2, "script_debug_menu", {
		param1 = Engine[0x614D394F6F9A18D](f296_arg1:getModel(f296_arg2, "name")),
		param2 = f296_arg1.gridInfoTable.zeroBasedIndex + 1,
	})
end
function SendClientScriptDebugMenuCloseMenuNotify(f297_arg0, f297_arg1, f297_arg2)
	Engine[0x6ABA4D7F0840A1E](f297_arg2, "script_debug_menu", {
		param1 = "close",
	})
end
function GetPlayerCalloutNameColor(f298_arg0, f298_arg1)
	local f298_local0 = Enum[0x97A8DF5F2FA8BD5][0xF51088437AB5AF5]
	if CoD.IsShoutcaster(f298_arg0) then
		local f298_local1 = Engine[0x2C6B07FD023877B](f298_arg0, f298_arg1)
		local f298_local2 = LuaDefine.INVALID_CLIENT_INDEX
		local f298_local3 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f298_arg0), "deadSpectator.playerIndex")
		if f298_local3 then
			f298_local2 = Engine[0x614D394F6F9A18D](f298_local3)
		end
		if f298_local2 == f298_arg1 then
			f298_local0 = Enum[0x97A8DF5F2FA8BD5][0x207FC901B92D0D9]
		elseif f298_local1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f298_local0 = Enum[0x97A8DF5F2FA8BD5][0x482A50BDDD83EAD]
		else
			f298_local0 = Enum[0x97A8DF5F2FA8BD5][0x11F2F2575C9BB22]
		end
		return f298_local0
	elseif Engine[0x761955642304848](f298_arg0) == f298_arg1 then
		f298_local0 = Enum[0x97A8DF5F2FA8BD5][0x207FC901B92D0D9]
	elseif Engine[0x2C6B07FD023877B](f298_arg0, f298_arg1) == CoD.TeamUtility.GetTeamID(f298_arg0) then
		f298_local0 = Enum[0x97A8DF5F2FA8BD5][0x4D3BDE8AD3D7704]
	end
	return f298_local0
end
function SetMPScoreText(f299_arg0, f299_arg1, f299_arg2, f299_arg3)
	local f299_local0 = CoD.GetScriptNotifyData(f299_arg3)
	local f299_local1 = Engine[0xEFE2F6436680CF3](f299_local0[1], "CS_LOCALIZED_STRINGS")
	local f299_local2 = f299_local0[2]
	if Engine[0xA55C3ACD0D2BCF0]() == false or CoD.isZombie == false then
		f299_arg1:AddCenterScore(f299_local1, f299_local2, f299_local0[4])
	end
end
function SetupStageResultsWidget(f300_arg0, f300_arg1)
	local f300_local0 = Engine[0x8DF2E5447F384B9]()
	f300_local0:create("StageResults")
	local f300_local1 = f300_local0.StageResults:create("winningTeam")
	f300_local1:set(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
	f300_local1 = f300_local0.StageResults:create("outcomeText")
	f300_local1:set(0x0)
	f300_arg0:subscribeToGlobalModel(f300_arg1, "PerController", "scriptNotify", function(model)
		if Engine[0x614D394F6F9A18D](model) == 0x21BD3EC422E5463 then
			local f301_local0 = CoD.GetScriptNotifyData(model)
			local f301_local1 = f301_local0[1]
			f300_local0.StageResults.winningTeam:set(f301_local1)
			local f301_local2 = Engine[0xEFE2F6436680CF3](f301_local0[2], "CS_LOCALIZED_STRINGS")
			local f301_local3 = Engine[0xEFE2F6436680CF3](f301_local0[3], "CS_LOCALIZED_STRINGS")
			if CoD.TeamUtility.GetTeamID(f300_arg1) == f301_local1 then
				f301_local3 = f301_local2
			end
			f300_local0.StageResults.outcomeText:set(f301_local3)
		end
	end)
end
function PopulateCompletionTimeField(f302_arg0, f302_arg1)
	local f302_local0, f302_local1 = CoD.ZombieUtility.GetStats(f302_arg1)
	assert(f302_local1 ~= nil)
	local f302_local2 = 0x336A23C0EE93A18
	local f302_local3 = nil
	local f302_local4 = Engine[0x6F8027A8BC75673]()
	local f302_local5 = Engine[0xE67E7253CC272C9]()
	assert(f302_local4 ~= nil)
	assert(f302_local5 ~= nil)
	f302_local0 = f302_local0.PlayerStatsByMap[f302_local5].statsByGameType[f302_local4].stats
	f302_local3 = f302_local1.AfterActionReportStats.gameLength:get()
	local f302_local6 = nil
	if f302_local0 ~= nil then
		f302_local6 = f302_local0.FASTEST_TIME_TO_COMPLETE_ROUND_30.StatValue:get()
		if f302_local6 and (not (f302_local6 ~= 0 or f302_local3 == 0) or f302_local6 ~= 0 and f302_local3 ~= 0 and f302_local3 < f302_local6) then
			f302_local2 = 0x1F78DD6B35E3B
		end
	end
	f302_arg0:setText(Engine[0xF9F1239CFD921FE](f302_local2, NumberAsTime(f302_local3)))
end
function SetupObjectiveNotificationWidget(f303_arg0, f303_arg1)
	f303_arg0.ignoreCurrentStateCheck = true
	local f303_local0 = Engine[0x4DF5CFBC1771947](f303_arg1)
	local f303_local1 = f303_local0:create("showGametypeObjectiveHint")
	f303_local1:set(false)
	f303_local1 = f303_local0:create("gametypeObjectiveHint")
	f303_local1:set(0x0)
	f303_local1 = f303_local0:create("gametypeObjective")
	f303_local1:set(0x0)
	f303_local1 = f303_local0:create("gametypeAttackers")
	f303_local1:set(false)
	f303_local1 = f303_local0:create("gameTypeObjectiveIcon")
	f303_local1:set("")
	f303_arg0:subscribeToGlobalModel(f303_arg1, "PerController", "scriptNotify", function(model)
		local f304_local0 = Engine[0x614D394F6F9A18D](model)
		if f304_local0 == 0xEE9F12E547BE609 then
			local f304_local1 = {
				controller = f303_arg1,
				name = f304_local0,
				data = CoD.GetScriptNotifyData(model),
			}
			f303_local0.gametypeObjectiveHint:set(Engine[0xEFE2F6436680CF3](f304_local1.data[1], "CS_LOCALIZED_STRINGS"))
			local f304_local2 = f304_local1.data[2]
			if f304_local2 then
				f304_local2 = Engine[0xEFE2F6436680CF3](f304_local1.data[2], "CS_LOCALIZED_STRINGS")
			end
			f303_local0.gametypeAttackers:set(f304_local1.data[3] == 1)
			local f304_local3 = f304_local2 and CoD.WarUtility.MissionInfo[f304_local2]
			if f304_local3 then
				f303_local0.gametypeObjective:set(f304_local3.header)
				f303_local0.gametypeObjectiveIcon:set(f304_local3.icon)
			end
			if not f303_local0.showGametypeObjectiveHint:set(true) then
				f303_local0.showGametypeObjectiveHint:forceNotifySubscriptions()
			end
		end
	end)
end
function TryBootHUD(f305_arg0, f305_arg1)
	if not f305_arg0.hasBooted then
		f305_arg0:addElement(LUI.UITimer.new(f305_arg1, "hud_boot", true, f305_arg0))
	end
end
function AddKillstreakReceivedNotification(f306_arg0, f306_arg1, f306_arg2, f306_arg3)
	if IsCodCaster(f306_arg2) then
		if not IsCodCasterProfileValueEqualTo(f306_arg2, "shoutcaster_ds_scorestreaks_notification", 1) then
			return
		elseif CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f306_arg2), "CodCaster.showLoadout") then
			return
		end
	end
	if f306_arg1.appendNotification ~= nil then
		local f306_local0 = CoD.GetScriptNotifyData(f306_arg3)
		local f306_local1 = f306_local0[1]
		local f306_local2 = f306_local0[3]
		local f306_local3 = nil
		for f306_local7, f306_local8 in ipairs(CoD.CACUtility.KillstreakNameList) do
			local f306_local9 = CoD.ScorestreakSelectUtility.GetEquippedItemIndexForScorestreakSlot(f306_arg2, f306_local8, Engine[0x3EAC408F958FF05]())
			local f306_local10 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f306_arg2), "killstreaks.killstreak" .. f306_local7 - 1 .. ".bindingKBM")
			if f306_local10 ~= nil then
				f306_local3 = f306_local10:get()
			else
				f306_local3 = false
			end
			if f306_local1 == f306_local9 then
				break
			end
		end
		if f306_local2 == 1 then
			f306_local4 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f306_arg2), "killstreaks.killstreak" .. #CoD.CACUtility.KillstreakNameList - 1 .. ".bindingKBM")
			if f306_local4 ~= nil then
				f306_local3 = f306_local4:get()
			else
				f306_local3 = false
			end
		end
		if IsGameTypeCombatTraining() then
			f306_local4 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f306_arg2), "killstreaks.killstreak0.bindingKBM")
			f306_local3 = f306_local4:get()
		end
		f306_arg1:appendNotification({
			title = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x54EB85A28216D99, Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](f306_local1)))),
			image = RegisterImage(Engine[0x8518E07C1C5BC6D](f306_local1)),
			type = "Killstreak",
			bindingKBM = f306_local3,
			priority = 0,
		})
	end
end
function AddHeroAbilityReceivedNotification(f307_arg0, f307_arg1, f307_arg2, f307_arg3)
	if IsCodCaster(f307_arg2) then
		if not IsCodCasterProfileValueEqualTo(f307_arg2, "shoutcaster_ds_specialist_notification", 1) then
			return
		elseif CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f307_arg2), "CodCaster.showLoadout") then
			return
		end
	end
	if f307_arg1.appendNotification ~= nil then
		local f307_local0 = CoD.GetScriptNotifyData(f307_arg3)
		local f307_local1 = f307_local0[1]
		local f307_local2 = Engine[0x6B7AC889104DED3](f307_local1)
		local f307_local3 = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xEE9796129C8602E, Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](f307_local2))))
		local f307_local4 = Engine[0xF9F1239CFD921FE](0xC0031E0C32601B3)
		if f307_local2 == 0x1A5D41D6A08D74E then
			f307_local4 = Engine[0xF9F1239CFD921FE](0x86F1315B244AA64)
		end
		if Engine[0xA79B18C6B32DEA3](Engine[0xB98952F69D937F9](f307_local1)) then
			f307_local4 = Engine[0xF9F1239CFD921FE](0x1F4597DF81CF039)
		end
		f307_arg1:appendNotification({
			title = f307_local3,
			description = f307_local4,
			type = "Ability",
			priority = 1,
		})
	end
end
function AddSlotUnlockedNotification(f308_arg0, f308_arg1, f308_arg2, f308_arg3)
	if not IsGametypeSettingsValue("escalationEnabled", 1) then
		return
	elseif IsCodCaster(f308_arg2) then
		if not IsCodCasterProfileValueEqualTo(f308_arg2, "shoutcaster_ds_scorestreaks_notification", 1) then
			return
		elseif CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f308_arg2), "CodCaster.showLoadout") then
			return
		end
	end
	if f308_arg1.appendNotification ~= nil then
		local f308_local0 = CoD.GetScriptNotifyData(f308_arg3)
		local f308_local1 = Engine[0xCA0179D394E63CE](f308_local0[1])
		local f308_local2
		if f308_local1 then
			f308_local2 = f308_local1.name
			if not f308_local2 then
			else
				f308_arg1:appendNotification({
					title = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xB966AF8CFF52CEE, f308_local2)),
					description = 0x0,
					type = "Slot",
					priority = 0,
				})
			end
		end
		f308_local2 = ""
	end
end
function AddZombieNotification(f309_arg0, f309_arg1, f309_arg2, f309_arg3)
	if not Engine[0xDD333420C49E6D0](f309_arg2, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
		return
	else
		local f309_local0 = CoD.GetScriptNotifyData(f309_arg3)
		f309_arg1:appendNotification({
			clip = "TextandImageBasic_Story" .. Engine[0xBBE3328FE08B8C7]() or 0 + 1,
			title = Engine[0xED84C33EC5F01EA](Engine[0xEFE2F6436680CF3](f309_local0[1], "CS_LOCALIZED_STRINGS")),
			description = 0x0,
		})
	end
end
function AddZombieRushNotification(f310_arg0, f310_arg1, f310_arg2, f310_arg3)
	local f310_local0 = CoD.GetScriptNotifyData(f310_arg2)
	f310_arg1:appendNotification({
		clip = "TextandImage" .. f310_arg3,
		title = Engine[0xED84C33EC5F01EA](Engine[0xEFE2F6436680CF3](f310_local0[1], "CS_LOCALIZED_STRINGS")),
		description = 0x0,
	})
end
function AddZombieBGBNotification(f311_arg0, f311_arg1, f311_arg2, f311_arg3)
	if not Engine[0xDD333420C49E6D0](f311_arg2, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
		return
	else
		local f311_local0 = CoD.GetScriptNotifyData(f311_arg3)
		local f311_local1 = f311_local0[1]
		f311_arg1:appendNotification({
			clip = "TextandImageBGB",
			title = Engine[0xF9F1239CFD921FE](Engine[0x6B7AC889104DED3](f311_local1, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])),
			description = Engine[0xF9F1239CFD921FE](Engine[0x3E0DA351EF48521](f311_local1, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])),
			bgbImage = RegisterImage(GetItemImageForIndex(f311_local1, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])),
		})
	end
end
function AddZombieBGBTokenNotification(f312_arg0, f312_arg1, f312_arg2, f312_arg3)
	if not Engine[0xDD333420C49E6D0](f312_arg2, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
		return
	else
		f312_arg0:playSound("zmb_bgb_token")
		f312_arg1:appendNotification({
			clip = "TextandImageBGBToken",
			title = Engine[0xF9F1239CFD921FE](0x8BDEBA40AFA3B45),
			description = Engine[0xF9F1239CFD921FE](0xB2B401DDF606C74),
			bgbImage = RegisterImage(0x84B4BDBA28C85D),
		})
	end
end
function CreatePrematchDraft(f313_arg0, f313_arg1, f313_arg2)
	if not f313_arg0.PositionDraft and not Engine[0xA55C3ACD0D2BCF0]() then
		local f313_local0 = "PositionDraft_" .. string.upper(CoD.ModeToModeString(Engine[0x3EAC408F958FF05]()))
		if not CoD.Menu.DoesMenuExist(f313_local0) then
			f313_local0 = "PositionDraft"
		end
		local f313_local1 = OpenOverlay(f313_arg0, f313_local0, f313_arg1)
		f313_local1:setAlpha(0.01)
		f313_arg0:sendInitializationEvents(f313_arg1, f313_local1)
		f313_arg0.PositionDraft = f313_local1
		LUI.OverrideFunction_CallOriginalSecond(f313_arg0, "close", function(element)
			if element.PositionDraft then
				element.PositionDraft:close()
			end
		end)
		LUI.OverrideFunction_CallOriginalSecond(f313_local1, "close", function()
			if f313_arg0.PositionDraft then
				f313_arg0.PositionDraft = nil
			end
		end)
		f313_local1:addElement(LUI.UITimer.newElementTimer(0, true, function()
			f313_local1:beginAnimation(500)
			f313_local1:setAlpha(1)
		end))
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f313_arg1), "isInPrematchPeriod"), 1)
end
function CreatePrematchTimer(f317_arg0, f317_arg1, f317_arg2)
	local f317_local0 = CoD.GetScriptNotifyData(f317_arg2)
	local f317_local1 = f317_local0[1]
	local f317_local2 = f317_local0[2] == 1
	if f317_local1 and not f317_arg0.PrematchCountdown then
		local f317_local3 = CoD.PrematchCountdown.new(f317_arg0, f317_arg1, 0, 0, 0, CoD.PrematchCountdown.__defaultWidth, 0, 0, 0, CoD.PrematchCountdown.__defaultHeight)
		f317_local3:setupCountdown(f317_arg1, f317_local1, f317_local2)
		f317_local3:setLeftRight(0, 1, 0, 0)
		f317_local3:setTopBottom(0, 1, 0, 0)
		if f317_arg0.WaypointContainer then
			f317_local3:addElementBefore(f317_arg0.WaypointContainer)
		else
			f317_arg0:addElement(f317_local3)
		end
		f317_arg0:sendInitializationEvents(f317_arg1, f317_local3)
		f317_arg0.PrematchCountdown = f317_local3
		LUI.OverrideFunction_CallOriginalSecond(f317_arg0, "close", function(element)
			if element.PrematchCountdown then
				element.PrematchCountdown:close()
			end
		end)
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f317_arg1), "isInPrematchPeriod"), 1)
end
function CreatePrematchTimer_Minimize(f319_arg0, f319_arg1, f319_arg2, f319_arg3, f319_arg4)
	local f319_local0 = CoD.GetScriptNotifyData(f319_arg3)
	local f319_local1 = f319_local0[1]
	local f319_local2 = f319_local0[2] == 1
	local f319_local3 = f319_local0[3]
	local f319_local4 = Engine[0x4DF5CFBC1771947](f319_arg2)
	f319_local4 = f319_local4.hudItems:create("prematchTimerUsePandemicLabel")
	if f319_local3 then
		f319_local4:set(true)
	else
		f319_local4:set(false)
	end
	if f319_local1 and not f319_arg0.PrematchCountdown then
		local f319_local5 = CoD.PrematchCountdownMinimize.new(f319_arg1, f319_arg2, 0, 0, 0, CoD.PrematchCountdownMinimize.__defaultWidth, 0, 0, 0, CoD.PrematchCountdownMinimize.__defaultHeight)
		f319_local5:setupCountdown(f319_arg2, f319_local1, f319_local2, f319_arg4)
		f319_local5:setLeftRight(0, 1, 0, 0)
		f319_local5:setTopBottom(0, 1, 0, 0)
		f319_arg0:addElement(f319_local5)
		f319_arg1:sendInitializationEvents(f319_arg2, f319_local5)
		f319_arg0.PrematchCountdown = f319_local5
		LUI.OverrideFunction_CallOriginalSecond(f319_arg0, "close", function(element)
			if element.PrematchCountdown then
				element.PrematchCountdown:close()
			end
		end)
	end
	local f319_local5 = Engine[0x4DF5CFBC1771947](f319_arg2)
	local f319_local6 = f319_local5:create("isInPrematchPeriod")
	f319_local6:set(1)
end
function CreateHoldingPenNotification(f321_arg0, f321_arg1, f321_arg2, f321_arg3, f321_arg4)
	local f321_local0 = CoD.GetScriptNotifyData(f321_arg3)
	if not f321_arg0.HoldingPenNotification then
		local f321_local1 = CoD.HoldingPenNotification.new(f321_arg1, f321_arg2, 0, 0, 0, CoD.HoldingPenNotification.__defaultWidth, 0, 0, 0, CoD.HoldingPenNotification.__defaultHeight)
		f321_local1:setupHoldingPenNotification(f321_arg2, f321_arg4)
		f321_local1:setLeftRight(0, 1, 0, 0)
		f321_local1:setTopBottom(0, 1, 0, 0)
		f321_arg0:addElement(f321_local1)
		f321_arg1:sendInitializationEvents(f321_arg2, f321_local1)
		f321_local1.PrematchCountdownNumbers.GlowPanel:setAlpha(0)
		f321_local1.PrematchCountdownNumbers.Image0:setAlpha(0)
		f321_arg0.HoldingPenNotification = f321_local1
		LUI.OverrideFunction_CallOriginalSecond(f321_arg0, "close", function(element)
			if element.HoldingPenNotification then
				element.HoldingPenNotification:close()
			end
		end)
	end
end
function SelectItemIfPossible(f323_arg0, f323_arg1, f323_arg2)
	if f323_arg1.gridInfoTable then
		f323_arg1.gridInfoTable.parentGrid:setActiveItem(f323_arg1)
	end
end
function CallElementModel(f324_arg0, f324_arg1, f324_arg2, f324_arg3)
	if f324_arg1 then
		local f324_local0 = f324_arg1:getModel(f324_arg2, f324_arg3)
		if f324_local0 then
			local f324_local1 = f324_local0:get()
			if f324_local1 then
				f324_local1(f324_arg0, f324_arg1, f324_arg2)
			end
		end
	end
end
function ProcessListActionInternal(f325_arg0, f325_arg1, f325_arg2, f325_arg3, f325_arg4, f325_arg5)
	if f325_arg1.disabled then
		return
	end
	local f325_local0 = f325_arg1:getModel(f325_arg2, f325_arg4)
	local f325_local1 = f325_arg1:getModel(f325_arg2, "param")
	local f325_local2, f325_local3 = nil
	if f325_local0 then
		f325_local2 = Engine[0x614D394F6F9A18D](f325_local0)
		if f325_local1 then
			f325_local3 = Engine[0x614D394F6F9A18D](f325_local1)
		end
	else
		f325_local2 = f325_arg5
		f325_local3 = f325_arg1.actionParam
	end
	if f325_local2 then
		local f325_local4 = f325_arg1:getParentMenu()
		if f325_arg1.gridInfoTable then
			f325_local4 = f325_arg1.gridInfoTable.parentGrid.menu
		end
		f325_local2(f325_arg0, f325_arg1, f325_arg2, f325_local3, f325_local4)
	end
end
function ProcessListAction(f326_arg0, f326_arg1, f326_arg2, f326_arg3)
	ProcessListActionInternal(f326_arg0, f326_arg1, f326_arg2, f326_arg3, "action", f326_arg1.action)
end
function ProcessListSecondaryAction(f327_arg0, f327_arg1, f327_arg2, f327_arg3)
	ProcessListActionInternal(f327_arg0, f327_arg1, f327_arg2, f327_arg3, "secondaryAction", f327_arg1.secondaryAction)
end
function ProcessListLockedAction(f328_arg0, f328_arg1, f328_arg2, f328_arg3)
	ProcessListActionInternal(f328_arg0, f328_arg1, f328_arg2, f328_arg3, "lockedAction", f328_arg1.lockedAction)
end
function ProcessClassOptionAction(f329_arg0, f329_arg1, f329_arg2, f329_arg3)
	if f329_arg1.disabled then
		return
	end
	local f329_local0, f329_local1 = nil
	f329_local0 = f329_arg3.actionButtonFn
	f329_local1 = f329_arg1.actionParam
	if f329_local0 then
		f329_local0(f329_arg0, f329_arg1, f329_arg2, f329_local1, f329_arg1.gridInfoTable.parentGrid.menu)
	end
end
function ProcessKeyboardCompleteAction(f330_arg0, f330_arg1, f330_arg2, f330_arg3)
	if f330_arg1.disabled then
		return
	end
	local f330_local0, f330_local1 = nil
	f330_local0 = f330_arg3.keyboardCompleteFn
	if f330_local0 then
		f330_local0(f330_arg0, f330_arg1, f330_arg2, f330_arg3)
	end
end
function UpdateDataSource(f331_arg0, f331_arg1, f331_arg2)
	f331_arg1:updateDataSource()
end
function UpdateElementDataSource(f332_arg0, f332_arg1)
	if f332_arg0[f332_arg1] then
		f332_arg0[f332_arg1]:updateDataSource()
	end
end
function SetAsListVerticalCounter(f333_arg0, f333_arg1, f333_arg2)
	if f333_arg0[f333_arg2] then
		f333_arg0[f333_arg2]:addCustomVerticalCounter(f333_arg1)
	end
end
function SetAsListHorizontalCounter(f334_arg0, f334_arg1, f334_arg2)
	if f334_arg0[f334_arg2] then
		f334_arg0[f334_arg2]:addCustomHorizontalCounter(f334_arg1)
	end
end
function SetAsGridHorizontalCounter(f335_arg0, f335_arg1)
	if f335_arg1.addCustomHorizontalCounter then
		f335_arg1:addCustomHorizontalCounter(f335_arg0)
	end
end
function NavigateScrollButtonUp(f336_arg0)
	if f336_arg0 and f336_arg0.listWidget then
		f336_arg0.listWidget:pageUp()
	end
end
function NavigateScrollButtonDown(f337_arg0)
	if f337_arg0 and f337_arg0.listWidget then
		f337_arg0.listWidget:pageDown()
	end
end
function NavigateScrollButtonLeft(f338_arg0)
	if f338_arg0 and f338_arg0.listWidget then
		f338_arg0.listWidget:pageLeft()
	end
end
function NavigateScrollButtonRight(f339_arg0)
	if f339_arg0 and f339_arg0.listWidget then
		f339_arg0.listWidget:pageRight()
	end
end
function ForceListDispatchMouseEvents(f340_arg0)
	f340_arg0:setForceMouseEventDispatch(true)
	f340_arg0.itemStencil:setForceMouseEventDispatch(true)
end
function SetAlpha(f341_arg0, f341_arg1)
	f341_arg0:setAlpha(f341_arg1)
end
function HideWidget(f342_arg0)
	f342_arg0:setAlpha(0)
end
function ShowWidget(f343_arg0)
	f343_arg0:setAlpha(1)
end
function DisableWidget(f344_arg0, f344_arg1, f344_arg2)
	f344_arg0[f344_arg1].m_disableNavigation = true
	f344_arg0[f344_arg1]:makeNotFocusable(f344_arg2)
	f344_arg0[f344_arg1]:setAlpha(0)
end
function ReplaceElementWithFake(f345_arg0, f345_arg1)
	f345_arg0[f345_arg1]:close()
	f345_arg0[f345_arg1] = LUI.UIElement.createFake()
end
function ChangeClass(f346_arg0, f346_arg1, f346_arg2, f346_arg3)
	if not IsInGame() then
		f346_arg0:saveState(f346_arg3)
	end
	f346_arg1.menuResponseSent = true
	local f346_local0 = Engine[0x614D394F6F9A18D](f346_arg2:getModel(f346_arg3, "classNum"), nil)
	local f346_local1 = Engine[0x614D394F6F9A18D](f346_arg2:getModel(f346_arg3, "defaultClassName"), nil)
	if f346_local0 == nil and IsIntDvarNonZero("mp_prototype") and IsMultiplayer() then
		f346_local0 = f346_arg2.characterIndex
	end
	CoD.CACUtility.ChangeClass(f346_arg3, f346_local0, f346_local1)
end
function SetBubblegumPackIndex(f347_arg0, f347_arg1, f347_arg2)
	local f347_local0 = f347_arg1:getModel()
	CoD.perController[f347_arg2].bgbPackIndex = f347_arg1.bgbPackIndex
	CoD.perController[f347_arg2].bubbleGumPackModel = f347_local0
	f347_arg0:setModel(f347_local0, f347_arg2)
end
function SetMenuCustomClassData(f348_arg0, f348_arg1, f348_arg2)
	local f348_local0 = f348_arg1:getModel()
	CoD.perController[f348_arg2].classNum = f348_arg1.classNum
	CoD.perController[f348_arg2].classModel = f348_local0
	f348_arg0:setModel(f348_local0, f348_arg2)
end
function PrestigeWeapon(f349_arg0, f349_arg1, f349_arg2)
	local f349_local0 = f349_arg1:getModel(f349_arg2, "itemIndex")
	if f349_local0 then
		CoD.OverlayUtility.CreateOverlay(f349_arg2, f349_arg0, "PrestigeWeapon", f349_arg2, f349_local0)
	end
end
function chooseClass_TabMPClassesListLeft(f350_arg0, f350_arg1)
	if not f350_arg0.ClassSetTabWidget then
		return
	else
		return f350_arg0.ClassSetTabWidget.Internal.Tabs:navigateItemLeft()
	end
end
function chooseClass_TabMPClassesListRight(f351_arg0, f351_arg1)
	if not f351_arg0.ClassSetTabWidget then
		return
	else
		return f351_arg0.ClassSetTabWidget.Internal.Tabs:navigateItemRight()
	end
end
function MarkCACPaintshopDataDirty(f352_arg0, f352_arg1)
	Engine[0xF5E84EE46588907](f352_arg1, false)
end
function RemoveOverflowItemFromClass(f353_arg0, f353_arg1, f353_arg2, f353_arg3)
	local f353_local0 = CoD.BaseUtility.GetMenuModel(f353_arg0)
	local f353_local1 = CoD.BaseUtility.GetMenuSessionMode(f353_arg0)
	local f353_local2 = f353_local0.classNum:get()
	local f353_local3 = f353_arg1.acceptData.slotName
	local f353_local4 = f353_arg1.acceptData.itemIndex
	local f353_local5 = CoD.CACUtility.GetUsedAllocation(f353_arg3, f353_local2, f353_local1)
	local f353_local6 = f353_arg2:getModel()
	f353_local6 = f353_local6.loadoutSlot:get()
	local f353_local7 = LUI.splitString(f353_local6, ".")
	local f353_local8 = CoD.SafeGetModelValue(f353_local0[f353_local6], "itemIndex")
	local f353_local9 = LUI.splitString(f353_local3, ".")
	if f353_local6 then
		if f353_local7[2] and f353_local7[2] == "attachment" then
			CoD.CACUtility.RemoveAttachmentFromClassHelper(f353_arg3, f353_local0, f353_local8, CoD.CACUtility.GetAttachmentListForSlot(f353_local7[1]), f353_local1)
		else
			RemoveItemFromClassSlot(f353_local0, f353_local6, f353_arg3, false, f353_local1)
		end
	end
	local f353_local10 = f353_local5 - CoD.CACUtility.GetUsedAllocation(f353_arg3, f353_local2, f353_local1)
	if f353_arg1.itemList.activeWidget:isLastItem() then
		f353_arg1.itemList.savedActiveIndex = f353_arg1.itemList.activeWidget.gridInfoTable.zeroBasedIndex - 1
	end
	local f353_local11 = f353_arg1.itemList:getDataSource()
	if f353_local11.getCount(f353_arg1.itemList) > 1 then
		f353_arg1.itemList:updateDataSource()
	end
	f353_local11 = Engine[0x4DF5CFBC1771947](f353_arg3)
	f353_local11 = f353_local11["CACMenu.numItemsToRemove"]
	local f353_local12 = f353_local11:get() - f353_local10
	f353_local11:set(f353_local12)
	if f353_local12 <= 0 then
		AttemptAttachItem(f353_arg1, f353_arg3, f353_local1, f353_local0, f353_local3, f353_local4, nil)
		if f353_local9[2] and f353_local9[2] == "attachment" then
			CoD.CACUtility.UpdateWeaponAttachmentModel(f353_arg0, f353_arg2, f353_arg3)
		end
		if f353_local7[2] and f353_local7[2] == "attachment" then
			CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadout(f353_arg0, f353_arg3, f353_local7[1])
		end
		local f353_local13 = GoBack(f353_arg1, f353_arg3)
		if not IsCurrentMenu(f353_local13, "MPCustomizeClassMenu") then
			GoBack(f353_local13, f353_arg3)
		end
	end
end
function RemoveOverflowWildcardFromClass(f354_arg0, f354_arg1, f354_arg2, f354_arg3, f354_arg4)
	local f354_local0 = CoD.BaseUtility.GetMenuModel(f354_arg2)
	local f354_local1 = CoD.BaseUtility.GetMenuSessionMode(f354_arg2)
	local f354_local2 = f354_arg1:getModel()
	local f354_local3 = nil
	if f354_local2 then
		f354_local3 = f354_local2.loadoutSlot:get()
		RemoveItemFromClassSlot(f354_local0, f354_local3, f354_arg3, false, f354_local1)
	end
	local f354_local4 = GoBack(f354_arg0, f354_arg3)
	if not IsCurrentMenu(f354_local4, "MPCustomizeClassMenu") then
		f354_local4 = GoBack(f354_local4, f354_arg3)
	end
	if f354_local3 then
		return OpenPopup(f354_local4, f354_arg4, f354_arg3, {
			_sessionMode = f354_local1,
			_model = f354_local0,
			_loadoutSlot = "bonuscard",
			_loadoutListItemSlot = f354_local3,
			_isContextualEquipping = true,
			_contextualEquipSlot = CoD.BaseUtility.GetMenuContextualEquipSlot(f354_arg2),
		})
	else
	end
end
function UpdateAllocationBar(f355_arg0, f355_arg1, f355_arg2)
	local f355_local0 = f355_arg1:getModel(f355_arg2, "allocationSpent")
	if f355_local0 then
		local f355_local1 = Engine[0x614D394F6F9A18D](f355_local0)
		if f355_local1 >= 0 then
			local f355_local2 = -1
			local f355_local3 = f355_arg1:getModel(f355_arg2, "classNum")
			if f355_arg1._previousClassNum == f355_local3 and f355_arg1._previousAllocationSpent == f355_local1 - 1 then
				f355_local2 = f355_local1
			end
			f355_arg1._previousAllocationSpent = f355_local1
			f355_arg1._previousClassNum = f355_local3
			for f355_local4 = 1, CoD.CACUtility.GetMaxAllocation(f355_arg2), 1 do
				local f355_local7 = f355_arg1["AllocationBar" .. f355_local4 - 1]
				if f355_local7 ~= nil then
					if f355_local4 <= f355_local1 then
						local f355_local8 = f355_local7
						local f355_local9 = f355_local7.playClip
						local f355_local10
						if f355_local4 == f355_local2 then
							f355_local10 = "PointSpending"
							if not f355_local10 then
							else
								f355_local9(f355_local8, f355_local10)
							end
						end
						f355_local10 = "PointSpent"
					end
					f355_local7:playClip("DefaultClip")
				end
			end
		end
	end
end
function BubblegumPackOptionsRename(f356_arg0, f356_arg1, f356_arg2)
	local f356_local0 = f356_arg0:getModel(f356_arg2, "bgbPackIndex")
	if f356_local0 then
		local f356_local1 = Engine[0x614D394F6F9A18D](f356_local0)
		Engine[0x7C75E608EA39B5C](f356_arg2, "ui_keyboard_new " .. Enum[0x85FCE2AA5391A7C][0xC990C3C5050A0ED])
	end
end
function BubblegumPackOptionsCopy(f357_arg0, f357_arg1, f357_arg2)
	local f357_local0 = f357_arg0:getModel(f357_arg2, "bgbPackIndex")
	local f357_local1 = f357_arg1:getModel(f357_arg2, "bgbPackIndex")
	if f357_local0 == f357_local1 then
		return
	elseif f357_local0 and f357_local1 then
		local f357_local2 = Engine[0x614D394F6F9A18D](f357_local0)
		local f357_local3 = Engine[0x614D394F6F9A18D](f357_local1)
		if f357_local2 and f357_local3 then
			Engine[0xB81A5136C5503E4](f357_arg2, "copybubblegumpack " .. f357_local2 .. " " .. f357_local3)
			local f357_local4 = f357_arg0.occludedMenu
			GoBack(f357_arg0, f357_arg2)
			ClearMenuSavedState(f357_arg0, f357_arg2)
			GoBack(f357_local4, f357_arg2)
			ClearMenuSavedState(f357_local4, f357_arg2)
		end
	end
end
function ClassOptionsCopyLoadout(f358_arg0, f358_arg1, f358_arg2, f358_arg3)
	if IsCurrentClassSelectedClass(f358_arg0, f358_arg1) == true then
		return
	end
	local f358_local0 = CoD.BaseUtility.GetMenuSessionMode(f358_arg3)
	local f358_local1 = CoD.BaseUtility.GetMenuModel(f358_arg3)
	local f358_local2 = f358_arg1:getModel()
	if f358_local1 and f358_local2 then
		local f358_local3 = f358_local1.classNum:get()
		local f358_local4 = f358_local2.classNum:get()
		if f358_local3 and f358_local4 then
			Engine[0x6806E51D20F4DCC](f358_arg2, f358_local3, f358_local4, f358_local0)
			if f358_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
				Engine[0xB81A5136C5503E4](f358_arg2, "copybubblegumpack " .. f358_local3 .. " " .. f358_local4)
			end
			SaveLoadoutGeneric(f358_arg2)
			CoD.CACUtility.GetCustomClassModel(f358_arg2, f358_local4, f358_local2, nil, f358_local0)
			GoBack(GoBack(f358_arg0, f358_arg2), f358_arg2)
		end
	end
end
function ClassOptionsCopyClassSet(f359_arg0, f359_arg1, f359_arg2)
	local f359_local0 = f359_arg1:getModel(f359_arg2, "classSetId")
	if f359_local0 then
		local f359_local1 = Engine[0x614D394F6F9A18D](f359_local0)
		local f359_local2 = Engine[0x69D03275BEFBC0C](f359_arg2)
		if f359_local1 == f359_local2 then
			return
		end
		Engine[0x94D492B4C40949D](f359_arg2, f359_local2)
		Engine[0x58D823014EE1315](f359_arg2, f359_local2, f359_local1)
		local f359_local3 = GoBack(f359_arg0, f359_arg2)
		ClearMenuSavedState(f359_arg0, f359_arg2)
		f359_local3 = GoBack(f359_local3, f359_arg2)
		ClearMenuSavedState(f359_local3, f359_arg2)
		f359_local3:dispatchEventToChildren({
			name = "class_set_name_change",
			controller = f359_arg2,
		})
	end
end
function ClassOptionsResetToDefault(f360_arg0, f360_arg1, f360_arg2, f360_arg3)
	local f360_local0 = CoD.BaseUtility.GetMenuSessionMode(f360_arg3)
	local f360_local1 = CoD.BaseUtility.GetMenuModel(f360_arg3)
	local f360_local2 = f360_arg1:getModel()
	local f360_local3 = LuaUtils.IsArenaMode() and 0x4FF2B60D157BBB2 or 0x705A80062BD09C2
	local f360_local4 = nil
	if f360_local0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		f360_local3 = 0x1C53105E8C011C4
	elseif f360_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f360_local3 = 0x9EEE28789FE067A
		local f360_local5 = Engine[0x4DF5CFBC1771947](f360_arg2)
		f360_local5 = f360_local5.selectedZMStory
		f360_local4 = f360_local5 and f360_local5:get()
	end
	if f360_local1 and f360_local2 then
		local f360_local5 = f360_local1.classNum:get()
		local f360_local6 = f360_local2.customClassName:get()
		local f360_local7 = f360_local2.index:get()
		if f360_local5 and f360_local6 and f360_local7 then
			local f360_local8 = f360_local5 + 1
			local f360_local9 = Engine[0x53803AC3BB0459C](f360_arg2, f360_local5, f360_local0)
			if f360_local9 then
				local f360_local10 = Engine[0xE00B2F29271C60B](f360_local3)
				CoDShared.SetDefaultLoadoutForClass(f360_local9, f360_local8, f360_local7, f360_local10, f360_local0, f360_local4)
				if f360_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
					CoDShared.SetDefaultBubbleGumBuffsForClass(f360_local9, f360_local8, f360_local7, f360_local10, f360_local0, f360_local4)
					DataSourceHelperRecreate(f360_arg2, "BGBLoadout")
				end
				Engine[0xE6C09FDF6C8D188](f360_arg2, f360_local0)
			end
			CoD.CACUtility.GetCustomClassModel(f360_arg2, f360_local5, f360_local1, nil, f360_local0)
			CoD.CACUtility.EquippedItemsChanged(f360_arg3, f360_arg2)
		end
		GoBack(GoBack(f360_arg0, f360_arg2), f360_arg2)
	end
end
function ClassOptionsClearLoadout(f361_arg0, f361_arg1, f361_arg2, f361_arg3)
	local f361_local0 = CoD.BaseUtility.GetMenuSessionMode(f361_arg3)
	local f361_local1 = CoD.BaseUtility.GetMenuModel(f361_arg3)
	local f361_local2 = f361_local1.classNum:get()
	local f361_local3 = Engine[0x53803AC3BB0459C](f361_arg2, f361_local2, f361_local0)
	if f361_local3 then
		CoDShared.ClearLoadoutForClassIndex(f361_local3, f361_local2 + 1, f361_local0)
	end
	CoD.CACUtility.GetCustomClassModel(f361_arg2, f361_local2, f361_local1, nil, f361_local0)
	CoD.CACUtility.EquippedItemsChanged(f361_arg3, f361_arg2)
end
function ClassOptionsSetHintText(f362_arg0, f362_arg1, f362_arg2)
	local f362_local0 = f362_arg1:getModel()
	local f362_local1 = DataSources.CACClassOptions.getModel(f362_arg2)
	f362_local1 = f362_local1.customClassOptionsHintText
	if f362_local1 and f362_local0 and f362_local0.description then
		f362_local1:set(f362_local0.description:get())
	end
end
function OpenBuyExtraSlotsPackDialog(f363_arg0, f363_arg1, f363_arg2)
	CoD.OverlayUtility.CreateOverlay(f363_arg2, f363_arg0, "PurchaseExtraSlotsConfirmation", f363_arg2, {
		displayText = 0xE3634DA619F3701,
		itemCODPointCost = CoD.CACUtility.GetExtraSlotCODPointCost(),
	})
end
function CopyLoadoutFromClassSet(f364_arg0)
	if IsClassSetsAvailableForCurrentGameMode() then
		Engine[0xE4B12D7BDD63ABC](f364_arg0, Engine[0x69D03275BEFBC0C](f364_arg0))
	end
end
function SetHintText(f365_arg0, f365_arg1, f365_arg2)
	local f365_local0 = nil
	if f365_arg1 then
		if f365_arg1.hintText then
			f365_local0 = f365_arg1.hintText
		else
			local f365_local1 = f365_arg1:getModel()
			if f365_local1 then
				local f365_local2 = Engine[0x40E824FE270E174](f365_local1, "hintText")
				if f365_local2 then
					f365_local0 = Engine[0x614D394F6F9A18D](f365_local2)
				end
			end
		end
	end
	if f365_local0 == nil then
		DataSources.PerController.clearHintText(f365_arg2)
	else
		DataSources.PerController.setHintText(f365_arg2, f365_local0)
	end
end
function UpdateDifficulty(f366_arg0, f366_arg1, f366_arg2)
	local f366_local0 = Engine[0xB72F603CAC75B3A](f366_arg2, "g_gameskill") or 0
	local f366_local1 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN_CP)
	if f366_arg1 == f366_local1[0x4BCADBA8E631B86] then
		Engine[0x280E4C1191CC53D](f366_arg2, "g_gameskill", GetCPDifficulty(f366_arg2, "g_gameskill_offline_cp") or f366_local0)
		Engine[0x7C75E608EA39B5C](f366_arg2, "updategamerprofile")
	else
	end
end
function RedeemCode(f367_arg0, f367_arg1, f367_arg2)
	Engine[0x8A25D95FDD290](f367_arg2)
end
function ShowPsStoreIcon(f368_arg0, f368_arg1)
	if CoD.perController[f368_arg0].psStoreIconCount == nil or CoD.perController[f368_arg0].psStoreIconCount == 0 then
		Store_UpdatePSStoreIconCount(f368_arg0, 1)
		Engine[0x26C857A2094573B](f368_arg1)
	end
end
function HidePsStoreIcon(f369_arg0)
	if CoD.perController[f369_arg0].psStoreIconCount ~= nil and CoD.perController[f369_arg0].psStoreIconCount > 0 then
		Store_UpdatePSStoreIconCount(f369_arg0, -1)
		Engine[0x10F8E70090DE0C8]()
	end
end
function ClearSelectedStoreCategory(f370_arg0)
	CoD.perController[f370_arg0].selectedStoreCategory = nil
end
function DisplayEmptyStoreSystemDialog(f371_arg0)
	Engine[0xE493B62BBE1395E](f371_arg0)
end
function SetSelectedStoreCategory(f372_arg0, f372_arg1, f372_arg2)
	local f372_local0 = f372_arg1:getModel(f372_arg2, "category")
	if f372_local0 then
		local f372_local1 = Engine[0x614D394F6F9A18D](f372_local0)
		if CoD.perController[f372_arg2].selectedStoreCategory ~= f372_local1 then
			local f372_local2 = CoD.perController[f372_arg2].selectedStoreCategory
			CoD.perController[f372_arg2].selectedStoreCategory = f372_local1
			if f372_local1 == "featured" or f372_local1 == "codpoints" then
				if f372_local2 ~= "featured" and f372_local2 ~= "codpoints" then
					ShowPsStoreIcon(f372_arg2, Enum[0x784DC8CE13E1E13][0xF4B7EC4DCAA8AC4])
				end
			else
				ShowPsStoreIcon(f372_arg2, Enum[0x784DC8CE13E1E13][0xF4B7EC4DCAA8AC4])
			end
			Engine[0xED84BE5BCA388FA](f372_arg2, f372_local1, false)
		end
	end
end
function AutoSelectFeaturedCategory(f373_arg0, f373_arg1)
	if CoD.perController[f373_arg1].selectedStoreCategory ~= "featured" then
		CoD.perController[f373_arg1].selectedStoreCategory = "featured"
		local f373_local0 = true
		if IsDurango() then
			f373_local0 = false
		end
		ShowPsStoreIcon(f373_arg1, Enum[0x784DC8CE13E1E13][0xF4B7EC4DCAA8AC4])
		Engine[0xED84BE5BCA388FA](f373_arg1, "featured", f373_local0)
	end
end
function AutoSelectCodPointCategory(f374_arg0, f374_arg1)
	if CoD.perController[f374_arg1].selectedStoreCategory ~= "codpoints" then
		CoD.perController[f374_arg1].selectedStoreCategory = "codpoints"
		Engine[0xED84BE5BCA388FA](f374_arg1, "codpoints", false)
	end
end
function PurchaseProduct(f375_arg0, f375_arg1, f375_arg2, f375_arg3)
	if CoD.ModelUtility.IsModelValueEqualTo(f375_arg3, "StoreRoot.ready", 1) then
		local f375_local0 = CoD.perController[f375_arg3].selectedStoreCategory
		if f375_local0 ~= nil and f375_local0 ~= "" then
			if IsDurango() then
				local f375_local1 = f375_arg2:getModel(f375_arg3, "productID")
				if f375_local1 then
					Engine[0xD58E665ABB6A9AE](f375_arg3, f375_local0, Engine[0x614D394F6F9A18D](f375_local1))
				end
			elseif IsOrbis() then
				local f375_local1 = f375_arg2:getModel(f375_arg3, "serviceLabel")
				if f375_local1 then
					local f375_local2 = Engine[0x614D394F6F9A18D](f375_local1)
					local f375_local3 = f375_arg2:getModel(f375_arg3, "productID")
					if f375_local3 then
						Engine[0xD58E665ABB6A9AE](f375_arg3, f375_local0, Engine[0x614D394F6F9A18D](f375_local3), f375_local2)
					end
				end
			elseif IsPC() then
				CoD.PCUtility.DisplayPrePurchasePopup(
					function()
						local f376_local0 = f375_arg2:getModel(f375_arg3, "productID")
						local f376_local1 = Engine[0x4DF5CFBC1771947](f375_arg3)
						f376_local1 = f376_local1:create("bnetCheckoutProductID")
						f376_local1:set(f376_local0:get())
						OpenPopup(f375_arg0:getMenu(), "PC_Battlenet_Checkout", f375_arg3)
					end,
					f375_arg1,
					f375_arg3,
					{
						purchaseProductElement = f375_arg2,
					}
				)
			end
		end
	end
	return true
end
function SetWorkingStateAndPurchaseDWSKU(f377_arg0, f377_arg1, f377_arg2, f377_arg3)
	if f377_arg0.currentState ~= "DefaultState" then
		return
	end
	f377_arg0:setState(f377_arg2, "WorkingState")
	local f377_local0 = function()
		PurchaseDWSKU(f377_arg0, f377_arg1, f377_arg2)
		if not f377_arg0.purchaseTimer then
			f377_arg0.purchaseTimer = LUI.UITimer.newElementTimer(500, false, function()
				if not Engine[0xC3441D67206942](f377_arg2) and Engine[0x1C212C183ECA37](f377_arg2) ~= Enum[0x92F3EA6C43FD419][0xB7C63B8EDC5BAEA] then
					if Engine[0x1C212C183ECA37](f377_arg2) == Enum[0x92F3EA6C43FD419][0xAA14E804D79839] then
						f377_arg0:setState(f377_arg2, "FinishedState")
						if f377_arg0:getModel() then
							local f379_local0 = f377_arg0:getModel()
							if f379_local0.purchased then
								f379_local0 = f377_arg0:getModel()
								f379_local0.purchased:set(true)
							end
						end
						local f379_local0 = Engine[0x4DF5CFBC1771947](f377_arg2)
						local f379_local1 = f379_local0:create("LootStreamProgress.playAnimation")
						f379_local1:set(true)
						f379_local1 = f377_arg0:getModel(f377_arg2, "skuID")
						if f379_local1 then
							local f379_local2 = Engine[0x614D394F6F9A18D](f379_local1)
							local f379_local3 = f379_local0:create("LootStreamProgress.skuPurchased")
							f379_local3:set(tostring(f379_local2))
						end
						local f379_local2 = f377_arg0:getMenu()
						CoD.BlackMarketUtility.SendItemShopViewEvent(f377_arg2, f379_local2, "purchased")
						if f379_local2._isContract then
							CoD.ContractUtility.OnContractPurchased(f379_local2, f377_arg2)
						elseif f379_local2._isReservesItem then
							if f377_arg1.gridInfoTable and f377_arg1.gridInfoTable.parentGrid then
								f377_arg1.gridInfoTable.parentGrid:updateDataSource()
							end
						elseif f379_local2._closeAndGoBack then
							if f379_local2._openEntitlementPopups then
								CoD.EntitlementUtility.CloseAndGoBackAndOpenEntitlementPopups(f379_local2, f377_arg2, 750)
							elseif IsBooleanDvarSet(0x1A8E4D68B803874) then
								CoD.BlackMarketUtility.ItemShopSunsetDelayCloseAndGoBack(f379_local2, f377_arg0, f377_arg2, 750)
							else
								DelayCloseAndGoBack(f379_local2, f377_arg2, 750)
							end
						elseif f379_local2._openEntitlementPopups then
							CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(f379_local2, f377_arg2, 750)
						elseif IsBooleanDvarSet(0x1A8E4D68B803874) then
							CoD.BlackMarketUtility.ItemShopSunsetDelayCloseAndGoBack(f379_local2, f377_arg0, f377_arg2, 750)
						else
							DelayGoBack(f379_local2, f377_arg2, 750)
						end
						CoD.BlackMarketUtility.TriggerSkuVO(f377_arg2, f377_arg0, f379_local2, f377_arg1)
						CoD.BlackMarketUtility.UpdateReservesItemCounts(f377_arg2)
					else
						f377_arg0:setState(f377_arg2, "ErrorState")
					end
					f377_arg0.purchaseTimer:close()
					f377_arg0.purchaseTimer = nil
				end
			end)
			f377_arg0:addElement(f377_arg0.purchaseTimer)
		end
	end
	local f377_local1 = function(f380_arg0)
		f377_arg0:setState(f380_arg0, "DefaultState")
	end
	if CoD.isPC and not f377_arg3 then
		CoD.PCUtility.DisplayPrePurchasePopup(f377_local0, f377_arg0:getMenu(), f377_arg2, {
			dwSKUElement = f377_arg0,
		}, f377_local1)
	else
		f377_local0()
	end
end
function SetElementWorkingStateAndPurchaseDWSKU(f381_arg0, f381_arg1)
	SetWorkingStateAndPurchaseDWSKU(f381_arg0, f381_arg0, f381_arg1, false)
end
function PurchaseDWSKU(f382_arg0, f382_arg1, f382_arg2)
	local f382_local0 = f382_arg0:getModel(f382_arg2, "skuID")
	if f382_local0 then
		Engine[0x9EF65378FF2525E](f382_arg2, tostring(Engine[0x614D394F6F9A18D](f382_local0)), 1)
	end
end
function RecordStoreOnItemGainFocus(f383_arg0, f383_arg1, f383_arg2, f383_arg3)
	f383_arg1.onGainFocusTime = Engine[0x9D33D652B9B0F3B]()
end
function RecordStoreOnItemLoseFocus(f384_arg0, f384_arg1, f384_arg2, f384_arg3)
	local f384_local0 = CoD.perController[f384_arg2].selectedStoreCategory
	local f384_local1 = f384_arg1.onGainFocusTime
	local f384_local2 = 0
	local f384_local3 = Dvar[0xB1BF1B329DA7BA7]:get()
	if f384_local1 ~= nil then
		f384_local2 = Engine[0x9D33D652B9B0F3B]() - f384_local1
	end
	if f384_local3 and f384_local2 < f384_local3 then
		return
	end
	local f384_local4 = f384_arg1:getModel(f384_arg2, "productID")
	if f384_local4 then
		CoD.MetricsUtility.StoreItemViewed(f384_arg0, f384_arg2, Engine[0x614D394F6F9A18D](f384_local4), f384_local2)
	end
end
function RecordStoreLastFocusedItemViewed(f385_arg0, f385_arg1, f385_arg2, f385_arg3)
	RecordStoreOnItemLoseFocus(f385_arg0, f385_arg1, f385_arg2, f385_arg3)
end
function PaintshopWeaponList_Back(f386_arg0, f386_arg1, f386_arg2)
	CoD.perController[f386_arg2].selectedPaintjobModel = nil
	CoD.perController[f386_arg2].paintshopWeaponListIndex = nil
	CoD.CraftUtility.Paintjobs.CachedPaintjobs = {}
end
function FileshareGetSlots(f387_arg0, f387_arg1, f387_arg2)
	Engine[0xA96543D6A13357F](f387_arg2)
end
function OpenShowcase(f388_arg0, f388_arg1, f388_arg2, f388_arg3, f388_arg4)
	local f388_local0 = CoD.FileshareUtility.GetCurrentCategory()
	local f388_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	FileshareSetShowcasePublishMode(f388_arg2, false)
	if f388_local0 == "paintjob" then
		OpenShowcasePaintjobs(f388_arg0, f388_arg1, f388_arg2, f388_local1, f388_arg4)
	elseif f388_local0 == "emblem" then
		OpenShowcaseEmblems(f388_arg0, f388_arg1, f388_arg2, f388_local1, f388_arg4)
	elseif f388_local0 == "customgame" then
		OpenShowcaseCustomGames(f388_arg0, f388_arg1, f388_arg2, f388_local1, f388_arg4)
	elseif f388_local0 == "screenshot" then
		OpenShowcaseScreenshots(f388_arg0, f388_arg1, f388_arg2, f388_local1, f388_arg4)
	elseif f388_local0 == "recentgames" then
		OpenShowcaseRecentGames(f388_arg0, f388_arg1, f388_arg2, f388_local1, f388_arg4)
	elseif f388_local0 == "clip_private" then
		OpenShowcaseLocalClips(f388_arg0, f388_arg1, f388_arg2, f388_local1, f388_arg4)
	elseif f388_local0 == "clip" then
		OpenShowcaseClips(f388_arg0, f388_arg1, f388_arg2, f388_local1, f388_arg4)
	end
end
function OpenShowcasePaintjobs(f389_arg0, f389_arg1, f389_arg2, f389_arg3, f389_arg4)
	CoD.FileshareUtility.SetPreviousCategory("paintjob")
	CoD.FileshareUtility.SetCurrentCategory("paintjob")
	CoD.FileshareUtility.SetCurrentFilter(Enum[0xA8E3D76FFA84DE1][0xE49F684F2FFE394], Engine[0x2B3D98DC8F66DEE]())
	local f389_local0 = false
	if FileshareIsCurrentUserContext(f389_arg2) then
		f389_local0 = true
	end
	CoD.FileshareUtility.SetShowCreateButton(f389_local0)
	OpenOverlay(f389_arg0, "MyShowcase_Paintjobs", f389_arg2)
end
function OpenShowcaseEmblems(f390_arg0, f390_arg1, f390_arg2, f390_arg3, f390_arg4)
	CoD.FileshareUtility.SetPreviousCategory("emblem")
	CoD.FileshareUtility.SetCurrentCategory("emblem")
	CoD.FileshareUtility.SetCurrentFilter(Enum[0xA8E3D76FFA84DE1][0xE49F684F2FFE394], Engine[0x2B3D98DC8F66DEE]())
	local f390_local0 = false
	if FileshareIsCurrentUserContext(f390_arg2) then
		f390_local0 = true
	end
	CoD.FileshareUtility.SetShowCreateButton(f390_local0)
	OpenOverlay(f390_arg0, "MyShowcase_Emblems", f390_arg2)
end
function OpenShowcaseCustomGames(f391_arg0, f391_arg1, f391_arg2, f391_arg3, f391_arg4)
	CoD.FileshareUtility.SetPreviousCategory("customgame")
	CoD.FileshareUtility.SetCurrentCategory("customgame")
	CoD.FileshareUtility.SetCurrentFilter(Enum[0xA8E3D76FFA84DE1][0xE49F684F2FFE394], Engine[0x2B3D98DC8F66DEE]())
	local f391_local0 = false
	if FileshareIsCurrentUserContext(f391_arg2) and CoD.FileshareUtility.GetIsCommunityMode(f391_arg2) == false then
		f391_local0 = true
	end
	CoD.FileshareUtility.SetShowCreateButton(f391_local0)
	OpenOverlay(f391_arg0, "MyShowcase_CustomGames", f391_arg2)
end
function OpenShowcaseScreenshots(f392_arg0, f392_arg1, f392_arg2, f392_arg3, f392_arg4)
	CoD.FileshareUtility.SetPreviousCategory("screenshot")
	CoD.FileshareUtility.SetCurrentCategory("screenshot")
	CoD.FileshareUtility.SetCurrentFilter(Enum[0xA8E3D76FFA84DE1][0xE49F684F2FFE394], Engine[0x2B3D98DC8F66DEE]())
	local f392_local0 = false
	if FileshareIsCurrentUserContext(f392_arg2) then
		f392_local0 = true
	end
	CoD.FileshareUtility.SetShowCreateButton(f392_local0)
	OpenOverlay(f392_arg0, "MyShowcase_Screenshots", f392_arg2)
end
function OpenShowcaseRecentGames(f393_arg0, f393_arg1, f393_arg2, f393_arg3, f393_arg4)
	CoD.FileshareUtility.SetPreviousCategory("recentgames")
	CoD.FileshareUtility.SetCurrentCategory("recentgames")
	CoD.FileshareUtility.SetCurrentFilter(Enum[0xA8E3D76FFA84DE1][0xE49F684F2FFE394], Engine[0x2B3D98DC8F66DEE]())
	local f393_local0 = false
	if FileshareIsCurrentUserContext(f393_arg2) then
		f393_local0 = true
	end
	CoD.FileshareUtility.SetShowCreateButton(false)
	OpenOverlay(f393_arg4, "MyShowcase_RecentGames", f393_arg2)
end
function OpenShowcaseClips(f394_arg0, f394_arg1, f394_arg2, f394_arg3, f394_arg4)
	CoD.FileshareUtility.SetPreviousCategory("clip")
	CoD.FileshareUtility.SetCurrentCategory("clip")
	CoD.FileshareUtility.SetCurrentFilter(Enum[0xA8E3D76FFA84DE1][0xE49F684F2FFE394], Engine[0x2B3D98DC8F66DEE]())
	local f394_local0 = false
	if FileshareIsCurrentUserContext(f394_arg2) then
		f394_local0 = true
	end
	CoD.FileshareUtility.SetShowCreateButton(f394_local0)
	PreserveThumbnails(f394_arg2, true)
	OpenOverlay(f394_arg4, "MyShowcase_Clips", f394_arg2)
	PreserveThumbnails(f394_arg2, false)
end
function OpenShowcaseLocalClips(f395_arg0, f395_arg1, f395_arg2, f395_arg3, f395_arg4)
	CoD.FileshareUtility.SetPreviousCategory("clip_private")
	CoD.FileshareUtility.SetCurrentCategory("clip_private")
	CoD.FileshareUtility.SetCurrentFilter(Enum[0xA8E3D76FFA84DE1][0xE49F684F2FFE394], Engine[0x2B3D98DC8F66DEE]())
	local f395_local0 = false
	if FileshareIsCurrentUserContext(f395_arg2) then
		f395_local0 = true
	end
	CoD.FileshareUtility.SetShowCreateButton(false)
	PreserveThumbnails(f395_arg2, true)
	OpenOverlay(f395_arg4, "MyShowcase_Clips", f395_arg2)
	PreserveThumbnails(f395_arg2, false)
end
function PublishClip(f396_arg0)
	local f396_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	local f396_local1 = CoD.FileshareUtility.GetPublishName()
	local f396_local2 = CoD.FileshareUtility.GetPublishDescription()
	if Engine[0xE5F9698B0CA4ADD](f396_arg0, "clip_private", f396_local0, CoD.FileshareUtility.GetIsCommunityMode(f396_arg0)) then
		Engine[0x6EE99D6E548D42E](f396_arg0, "clip", f396_local0, f396_local1, f396_local2)
	else
		Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](CoD.FileshareUtility.GetPublishingModel()), Enum[0xE798E99E27D081E][0x2B49C044708FBA4])
	end
end
function OpenLocalClipPublishPrompt(f397_arg0, f397_arg1, f397_arg2, f397_arg3, f397_arg4)
	local f397_local0 = Engine[0x23AF33F30C69410](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]))
	if f397_local0.fileID ~= CoD.FileshareUtility.GetSelectedItemProperty("fileId") then
		LuaUtils.UI_ShowErrorMessageDialog(f397_arg2, 0xC08DDDCF42A89F1)
		return
	else
		CoD.FileshareUtility.OpenPublishPrompt(f397_arg0, f397_arg2, "clip", CoD.FileshareUtility.GetSelectedItemProperty("fileName"), CoD.FileshareUtility.GetSelectedItemProperty("fileDescription"), PublishClip)
	end
end
function OpenLocalScreenshots(f398_arg0, f398_arg1)
	local f398_local0 = "screenshot_private"
	CoD.FileshareUtility.SetCurrentCategory(f398_local0)
	if f398_local0 ~= CoD.FileshareUtility.GetPreviousCategory() then
		CoD.FileshareUtility.SetDirty()
	end
	CoD.FileshareUtility.ProcessUIIndex(f398_arg1, f398_local0, 0)
	local f398_local1 = Engine[0x93B19E01B1FD1C7](f398_arg1)
	Engine[0xB81A5136C5503E4](f398_arg1, "fileshareResetSummaryFiles")
	CoD.FileshareUtility.SetCurrentUser(f398_local1)
	CoD.FileshareUtility.SetFileshareMode(f398_arg1, Enum[0x25E8D8427CAB01][0x9F4C8230B0A89F2])
	CoD.FileshareUtility.FetchContentForUser(f398_arg1, f398_local1)
	FileshareSetShowcasePublishMode(f398_arg1, false)
	CoD.FileshareUtility.SetPreviousCategory(f398_local0)
	CoD.FileshareUtility.SetCurrentFilter(Enum[0xA8E3D76FFA84DE1][0xE49F684F2FFE394], Engine[0x2B3D98DC8F66DEE]())
	CoD.FileshareUtility.SetShowCreateButton(false)
	CoD.FileshareUtility.SetShowFileDetails(false)
	CoD.FileshareUtility.SetShowPublishNewDetails(false)
	CoD.FileshareUtility.SetShowCreateButton(false)
	OpenOverlay(f398_arg0, "LocalScreenshots", f398_arg1)
end
function PublishScreenshot(f399_arg0)
	local f399_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	local f399_local1 = CoD.FileshareUtility.GetPublishName()
	local f399_local2 = CoD.FileshareUtility.GetPublishDescription()
	if Engine[0xE5F9698B0CA4ADD](f399_arg0, "screenshot_private", f399_local0, CoD.FileshareUtility.GetIsCommunityMode(f399_arg0)) then
		Engine[0x64E73C83070FE5C](f399_arg0, "screenshot", f399_local0, f399_local1, f399_local2)
	else
		Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](CoD.FileshareUtility.GetPublishingModel()), Enum[0xE798E99E27D081E][0x2B49C044708FBA4])
	end
end
function OpenLocalScreenshotsPublishPrompt(f400_arg0, f400_arg1, f400_arg2, f400_arg3, f400_arg4)
	local f400_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	if Engine[0xF32E17FCA059C08](Enum[0xBC604DA292437E4][0x757495F8281F7D2], f400_local0) == false or Engine[0xF32E17FCA059C08](Enum[0xBC604DA292437E4][0x32D90B2AD4019FE], f400_local0) == false then
		LuaUtils.UI_ShowErrorMessageDialog(f400_arg2, 0xB2A1F25CCD4E630)
		return
	else
		CoD.FileshareUtility.OpenPublishPrompt(f400_arg0, f400_arg2, "screenshot", CoD.FileshareUtility.GetSelectedItemProperty("fileName"), CoD.FileshareUtility.GetSelectedItemProperty("fileDescription"), PublishScreenshot)
	end
end
function OpenMediaCommunity(f401_arg0, f401_arg1, f401_arg2, f401_arg3, f401_arg4, f401_arg5)
	CoD.FileshareUtility.InitModels()
	CoD.FileshareUtility.SetCurrentCommunityDataType(f401_arg5)
	CoD.FileshareUtility.SetFileshareMode(f401_arg2, Enum[0x25E8D8427CAB01][0xE4965F4E4F86DCE])
	OpenOverlay(f401_arg0, "Community", f401_arg2)
end
function FileshareSetSelectedItemAttachTimer(f402_arg0, f402_arg1, f402_arg2, f402_arg3)
	local f402_local0 = LUI.UITimer.newElementTimer(300, true, function()
		CoD.FileshareUtility.ProcessUIIndex(f402_arg1, f402_arg2, f402_arg3)
	end, f402_arg0)
	f402_arg0.processUIIndexTimer = f402_local0
	f402_arg0:addElement(f402_local0)
end
function FileshareSetSelectedItem(f404_arg0, f404_arg1, f404_arg2, f404_arg3)
	local f404_local0 = f404_arg1:getModel()
	if f404_local0 == nil then
		CoD.CraftUtility.Fileshare.ClearDisplay(f404_arg2)
		return
	end
	CoD.FileshareUtility.SetSelectedItem(f404_local0)
	local f404_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	local f404_local2 = CoD.FileshareUtility.GetSelectedItemProperty("isPublishNew")
	local f404_local3 = CoD.FileshareUtility.GetCurrentCategory()
	local f404_local4 = f404_arg3 == "true"
	if f404_local2 == true or f404_local1 == 0 then
		CoD.FileshareUtility.SetShowPublishNewDetails(true)
		CoD.CraftUtility.Fileshare.ClearDisplay(f404_arg2)
		return
	elseif f404_arg1.gridInfoTable then
		FileshareSetSelectedItemAttachTimer(f404_arg1, f404_arg2, f404_local3, f404_arg1.gridInfoTable.zeroBasedIndex)
	end
	local f404_local5 = Engine[0x9E49617B35BC1CC](f404_arg2, f404_local1)
	if f404_local3 == "paintjob" then
		CoD.CraftUtility.Fileshare.DisplayWeaponWithPaintjob(f404_arg2, f404_local5, f404_local1, f404_local4)
	end
	if CoD.FileshareUtility.ShouldSetPreviewIconSizeShort(f404_local3) then
		FileshareSetPreviewIconSizeShort()
	else
		FileshareSetPreviewIconSizeNormal()
	end
end
function FileshareCategorySelectorItemSelected(f405_arg0, f405_arg1, f405_arg2)
	local f405_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f405_arg1:getModel(), "category"))
	local f405_local1 = CoD.FileshareUtility.GetCurrentCommunityDataType()
	local f405_local2 = false
	local f405_local3 = Engine[0x40E824FE270E174](f405_arg1:getModel(), "communityDataType")
	if f405_local3 then
		local f405_local4 = CoD.FileshareUtility.GetCurrentCommunityDataType()
		local f405_local5 = Engine[0x614D394F6F9A18D](f405_local3)
		if f405_local5 ~= nil and f405_local5 ~= "" and f405_local4 ~= f405_local5 then
			CoD.FileshareUtility.SetCurrentCommunityDataType(f405_local5)
			f405_local1 = f405_local5
			f405_local2 = true
		end
	end
	if f405_arg0.TabFrame and f405_arg0.TabFrame.framedWidget then
		if f405_arg1.tabId == "bookmarkedgames" then
			CoD.FileshareUtility.SetFilterOnFileshareContentList(f405_arg0.TabFrame.framedWidget, Enum[0xA8E3D76FFA84DE1][0x9DD15D8811C2E4], 1)
		else
			CoD.FileshareUtility.SetFilterOnFileshareContentList(f405_arg0.TabFrame.framedWidget, nil, nil)
		end
	end
	CoD.FileshareUtility.FileshareCategorySelectorCategoryChanged(f405_arg2, f405_local0, f405_local1, f405_local2)
end
function FileshareHandleKeyboardComplete(f406_arg0, f406_arg1, f406_arg2, f406_arg3)
	if f406_arg3.type == Enum[0x85FCE2AA5391A7C][0x130DD17C58BD287] then
		CoD.FileshareUtility.SetPublishName(f406_arg3.input)
	elseif f406_arg3.type == Enum[0x85FCE2AA5391A7C][0x14045CBFEAB8B66] then
		CoD.FileshareUtility.SetPublishDescription(f406_arg3.input)
	elseif f406_arg3.type == Enum[0x85FCE2AA5391A7C][0xFE567CB7EB356F5] then
		CoD.FileshareUtility.SetPublishTags(f406_arg3.input)
	elseif f406_arg3.type == Enum[0x85FCE2AA5391A7C][0x8AB7EF4104BBA8E] then
		CoD.FileshareUtility.SetDownloadFileName(f406_arg3.input)
	end
end
function FileshareEnterPublishName(f407_arg0, f407_arg1, f407_arg2)
	ShowKeyboard(f407_arg0, f407_arg1, f407_arg2, "KEYBOARD_TYPE_FILESHARE_PUBLISH_NAME")
end
function FileshareEnterPublishDescription(f408_arg0, f408_arg1, f408_arg2)
	ShowKeyboard(f408_arg0, f408_arg1, f408_arg2, "KEYBOARD_TYPE_FILESHARE_PUBLISH_DESCRIPTION")
end
function FileshareEnterPublishTags(f409_arg0, f409_arg1, f409_arg2)
	ShowKeyboard(f409_arg0, f409_arg1, f409_arg2, "KEYBOARD_TYPE_FILESHARE_PUBLISH_TAGS")
end
function FileshareSetPreviewIconSizeNormal()
	local f410_local0 = CoD.FileshareUtility.GetRootModel()
	local f410_local1 = Engine[0xA798E4552F5E872](f410_local0, "isNormalSize", false)
	local f410_local2 = Engine[0xA798E4552F5E872](f410_local0, "listVerticalCount", false)
	Engine[0x83C9B5DE1D9371](f410_local1, true)
	Engine[0x83C9B5DE1D9371](f410_local2, 2)
end
function FileshareSetPreviewIconSizeShort()
	local f411_local0 = CoD.FileshareUtility.GetRootModel()
	local f411_local1 = Engine[0xA798E4552F5E872](f411_local0, "isNormalSize", false)
	local f411_local2 = Engine[0xA798E4552F5E872](f411_local0, "listVerticalCount", false)
	Engine[0x83C9B5DE1D9371](f411_local1, false)
	Engine[0x83C9B5DE1D9371](f411_local2, 8)
end
function FileshareSummaryFileUpdate(f412_arg0)
	local f412_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "fileshareRoot", false)
	local f412_local1 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f412_local0, "summaryFileUpdated", false))
	if f412_local1 == nil then
		return
	elseif CoD.FileshareUtility.GetIsFullscreenMode(f412_arg0) == true then
		local f412_local2 = CoD.FileshareUtility.GetSelectedItem()
		if Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f412_local2, "fileId")) == f412_local1 then
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f412_local2, "renderFileId"), f412_local1)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f412_local2, "showDetailsViewSpinner"), 0)
			local f412_local3 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f412_local2, "fileId"))
			local f412_local4 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f412_local2, "fileCategory"))
			local f412_local5 = Engine[0x9E49617B35BC1CC](f412_arg0, f412_local3)
			if f412_local4 == "paintjob" then
				CoD.CraftUtility.Fileshare.DisplayWeaponWithPaintjob(f412_arg0, f412_local5, f412_local3, true)
			end
		end
	else
		for f412_local2 = 1, 12, 1 do
			local f412_local3 = "fileshareData_" .. f412_local2
			if FileshareIsCommunityMode(nil, f412_arg0) == true then
				f412_local3 = "fileshareData_community_" .. f412_local2
			end
			local f412_local4 = Engine[0xA798E4552F5E872](f412_local0, f412_local3, false)
			local f412_local5 = Engine[0xA798E4552F5E872](f412_local4, "fileID", false)
			local f412_local8 = Engine[0xA798E4552F5E872](f412_local4, "renderFileId", false)
			if Engine[0x614D394F6F9A18D](f412_local5) == f412_local1 then
				Engine[0x83C9B5DE1D9371](f412_local8, f412_local1)
				break
			end
		end
	end
end
function FileshareBookmarkRecentGame(f413_arg0)
	local f413_local0 = CoD.AARUtility.GetCurrentStats(f413_arg0)
	local f413_local1 = f413_local0 and f413_local0.AfterActionReportStats
	local f413_local2 = f413_local1
	local f413_local3 = f413_local1.demoFileID
	if f413_local3 then
		f413_local3 = f413_local2 and Engine[0x90B6BCE69A8E08B](f413_local1.demoFileID:get())
	end
	if f413_local3 ~= nil and f413_local3 ~= Engine[0x2B3D98DC8F66DEE]() then
		Engine[0x55C203B6C56B470](f413_arg0, f413_local3)
		CoD.OverlayUtility.ShowToast("RecentGameBookmarked", Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xA009F37E1567367)), Engine[0xF9F1239CFD921FE](0x6534C8ED6B43677), "uie_bookmark")
	end
end
function FileshareSetShowcasePublishMode(f414_arg0, f414_arg1)
	local f414_local0 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "FileshareRoot", false), "PublishMode", false)
	local f414_local1 = 0
	if f414_arg1 == true then
		f414_local1 = 1
	end
	Engine[0x83C9B5DE1D9371](f414_local0, f414_local1)
end
function GetMediaManagerCategoryCount()
	return #CoD.FileshareUtility.ShowcaseManagerTabs
end
function MediaManagerMarkDirty(f416_arg0)
	local f416_local0 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MediaManager", false), "dirty", false)
	ForceNotifyGlobalModel(f416_arg0, "MediaManager.dirty")
	MediaManagerUpdateSlotsUsed(f416_arg0, CoD.perController[f416_arg0].selectedMediaManagerTab)
end
function MediaManagerUpdateSlotsUsed(f417_arg0, f417_arg1)
	if f417_arg1 then
		local f417_local0 = Engine[0xBD4558D421599D6](f417_arg0, f417_arg1)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MediaManager", false), "slotsUsed", false), f417_local0.categorySlotsUsed)
	end
end
function MediaManagerClearDisplay(f418_arg0, f418_arg1, f418_arg2)
	if CoD.FileshareUtility.IsCategoryFilm(f418_arg2, f418_arg1) or CoD.FileshareUtility.IsCategoryClip(f418_arg2, f418_arg1) or CoD.FileshareUtility.IsCategoryScreenshot(f418_arg2, f418_arg1) or CoD.FileshareUtility.IsCategoryCustomGames(f418_arg2, f418_arg1) then
		return
	else
		CoD.CraftUtility.Fileshare.ClearDisplay(f418_arg2)
	end
end
function OpenMediaManager(f419_arg0, f419_arg1, f419_arg2, f419_arg3, f419_arg4)
	CoD.FileshareUtility.SetPreviousCategory(CoD.FileshareUtility.GetCurrentCategory())
	CoD.FileshareUtility.SetCurrentCategory(f419_arg3)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MediaManager", false), "previousWeaponIndex", false), CoD.GetCustomization(f419_arg2, "weapon_index"))
	MediaManagerClearDisplay(f419_arg0, f419_arg1, f419_arg2)
	OpenOverlay(f419_arg0, "MediaManager", f419_arg2)
end
function GoBackAndOpenMediaManagerOnParent(f420_arg0, f420_arg1, f420_arg2, f420_arg3, f420_arg4)
	CoD.FileshareUtility.SetPreviousCategory(CoD.FileshareUtility.GetCurrentCategory())
	if f420_arg3 ~= nil and f420_arg3 ~= "" then
		CoD.FileshareUtility.SetCurrentCategory(f420_arg3)
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "MediaManager", false), "previousWeaponIndex", false), CoD.GetCustomization(f420_arg2, "weapon_index"))
	MediaManagerClearDisplay(f420_arg0, f420_arg1, f420_arg2)
	GoBackAndOpenOverlayOnParent(f420_arg0, "MediaManager", f420_arg2)
end
function PaintjobSelector_GainFocus(f421_arg0, f421_arg1, f421_arg2)
	CoD.perController[f421_arg2].selectedPaintjobModel = f421_arg1:getModel()
	CoD.perController[f421_arg2].viewIndex = 1
	local f421_local0 = CoD.CraftUtility.PaintshopView[CoD.perController[f421_arg2].viewIndex].customization_type
	local f421_local1 = f421_arg1:getModel(f421_arg2, "paintjobSlot")
	CoD.CraftUtility.Gunsmith.DisplayWeaponWithPaintjob(f421_arg2, f421_local1:get())
end
function PaintjobSelector_ChoosePaintjob(f422_arg0, f422_arg1, f422_arg2)
	local f422_local0 = f422_arg1:getModel(f422_arg2, "paintjobSlot")
	CoD.perController[f422_arg2].selectedPaintjobModel = f422_arg1:getModel()
	if f422_local0 then
		Engine[0xAF3C2D1A783917D](f422_arg2, Engine[0x614D394F6F9A18D](f422_local0))
	end
	CoD.perController[f422_arg2].viewIndex = 1
	local f422_local1 = CoD.CraftUtility.PaintshopView[CoD.perController[f422_arg2].viewIndex].view_name
	local f422_local2 = CoD.CraftUtility.PaintshopView[CoD.perController[f422_arg2].viewIndex].customization_type
	local f422_local3 = CoD.CraftUtility.PaintshopView[CoD.perController[f422_arg2].viewIndex].view_string_ref
	CoD.SetCustomization(f422_arg2, f422_local2, "type")
	CoD.SetCustomization(f422_arg2, f422_local3, "view_string_ref")
	Engine[0x31FE7A26A55BD96](f422_arg2, f422_local2, CoD.GetCustomization(f422_arg2, "weapon_index"))
	CoD.CraftUtility.DisplayWeaponInPaintshop(f422_arg2, f422_local1)
	CoD.CraftUtility.SetEmblemEditorProperties(f422_arg2, Enum[0x3ED85BA45B1D650][0x3EBDFD4FFDC7DA3], "editorMode")
end
function FileshareOpenFullscreenView(f423_arg0, f423_arg1, f423_arg2, f423_arg3)
	if f423_arg1.gridInfoTable then
		CoD.FileshareUtility.ReportView(f423_arg2, f423_arg1.gridInfoTable.zeroBasedIndex)
	end
	if FileshareIsCategory(f423_arg2, "screenshot_private") or FileshareIsCategory(f423_arg2, "screenshot") then
		CoD.Menu.ModelToUse = f423_arg1:getModel()
		OpenOverlay(f423_arg0, "Fileshare_ScreenshotDetailsView", f423_arg2)
		CoD.Menu.ModelToUse = nil
	else
		OpenOverlay(f423_arg0, "Fileshare_DetailsView", f423_arg2)
	end
end
function FilesharePublish(f424_arg0, f424_arg1, f424_arg2)
	CoD.FileshareUtility.Publish(f424_arg2)
end
function FileshareDownload(f425_arg0, f425_arg1, f425_arg2)
	CoD.FileshareUtility.Download(f425_arg2)
end
function SteamWorkshopPublish(f426_arg0, f426_arg1, f426_arg2)
	CoD.SteamWorkshopUtility.Publish(f426_arg0, f426_arg1, f426_arg2)
end
function SteamWorkshopOpenAgreement(f427_arg0, f427_arg1, f427_arg2)
	CoD.SteamWorkshopUtility.OpenAgreement(f427_arg0, f427_arg1, f427_arg2)
end
function SteamWorkshopOpenFAQ(f428_arg0, f428_arg1, f428_arg2)
	CoD.SteamWorkshopUtility.OpenFAQ(f428_arg0, f428_arg1, f428_arg2)
end
function SteamWorkshopOpenItem(f429_arg0, f429_arg1, f429_arg2)
	CoD.SteamWorkshopUtility.OpenItemOnSteam(f429_arg0, f429_arg1, f429_arg2)
end
function SteamWorkshopViewWorkshop(f430_arg0, f430_arg1, f430_arg2)
	CoD.SteamWorkshopUtility.ViewWorkshop(f430_arg0, f430_arg1, f430_arg2)
end
function PaintjobSelector_ClearPaintjob(f431_arg0, f431_arg1)
	CoD.CraftUtility.Paintjobs.ClearPaintjob(f431_arg1, Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](CoD.perController[f431_arg1].selectedPaintjobModel, "paintjobSlot")))
	CoD.CraftUtility.Paintjobs.ParseDDL(f431_arg1, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61])
	if IsMediaManager() == true then
		MediaManagerMarkDirty(f431_arg1)
	end
	ForceNotifyModel(f431_arg1, "Paintshop.UpdateDataSource")
	CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(nil, f431_arg1)
end
function PaintjobSelector_CopyPaintjob(f432_arg0, f432_arg1, f432_arg2, f432_arg3, f432_arg4)
	local f432_local0 = CoD.CraftUtility.Paintjobs.Copy(f432_arg2, CoD.perController[f432_arg2].selectedPaintjobModel)
	if f432_local0 then
		CoD.CraftUtility.Paintjobs.ParseDDL(f432_arg2, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61])
		CoD.CraftUtility.InvalidateWCItemRender(f432_local0)
		ForceNotifyModel(f432_arg2, "Paintshop.UpdateDataSource")
		CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f432_arg1, f432_arg2)
	end
end
function PaintjobSelector_RenamePaintjob(f433_arg0, f433_arg1)
	local f433_local0 = CoD.perController[f433_arg1].selectedPaintjobModel
	CoD.CraftUtility.Paintjobs.RenamePaintjob(f433_arg1, Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f433_local0, "paintjobSlot")), Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f433_local0, "paintjobName")))
end
function PaintjobSelector_HandleRenameKeyboardComplete(f434_arg0, f434_arg1, f434_arg2, f434_arg3)
	local f434_local0 = CoD.perController[f434_arg2].selectedPaintjobModel
	local f434_local1 = nil
	if not f434_local0 then
		return
	elseif f434_arg3.type == Enum[0x85FCE2AA5391A7C][0xD8A95D32ACF41D1] then
		f434_local1 = Engine[0x40E824FE270E174](f434_local0, "paintjobName")
	end
	if f434_local1 then
		Engine[0x83C9B5DE1D9371](f434_local1, f434_arg3.input)
	end
end
function PaintjobEditor_OpenSavePopup(f435_arg0, f435_arg1, f435_arg2, f435_arg3)
	CoD.OverlayUtility.CreateOverlay(f435_arg2, f435_arg0, "PaintjobSave", CoD.perController[f435_arg2].selectedPaintjobModel)
end
function PaintjobEditor_ToggleGrid(f436_arg0, f436_arg1, f436_arg2, f436_arg3)
	local f436_local0 = CoD.CraftUtility.GetGridTypeName(f436_arg2)
	local f436_local1 = 0
	if not IsGridOn(f436_arg2, f436_local0) then
		f436_local1 = CoD.CraftUtility.GetGridSize(f436_arg2)
	end
	SetProfileVar(f436_arg2, f436_local0, f436_local1)
	Engine[0x25528FFBC14FC0C](CoD.GetCustomization(f436_arg2, "type"), f436_local1)
end
function PaintjobEditor_RemoveGrid(f437_arg0)
	Engine[0x25528FFBC14FC0C](CoD.GetCustomization(f437_arg0, "type"), 0)
end
function PaintjobEditor_RestoreGridState(f438_arg0)
	Engine[0x25528FFBC14FC0C](CoD.GetCustomization(f438_arg0, "type"), Engine[0xB72F603CAC75B3A](f438_arg0, CoD.CraftUtility.GetGridTypeName(f438_arg0)))
end
function PaintjobEditor_SavePaintjob(f439_arg0, f439_arg1, f439_arg2)
	local f439_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f439_arg2, "paintjobTextEntry"))
	local f439_local1 = Engine[0x40E824FE270E174](f439_arg2, "paintjobName")
	local f439_local2 = Engine[0xBD4558D421599D6](f439_arg1, "paintjob")
	Engine[0x83C9B5DE1D9371](f439_local1, f439_local0)
	CoD.CraftUtility.Paintjobs.UploadPaintjob(f439_arg1, f439_arg2)
	CoD.CraftUtility.Paintjobs.ParseDDL(f439_arg1, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61])
	CoD.CraftUtility.Paintjobs.InvalidateRender(f439_arg1, f439_arg2)
	PaintJobEditor_RecordMetrics(f439_arg0, f439_arg1, f439_arg2, "save", f439_local2.categorySlotsUsed, f439_local2.categoryQuota)
	local f439_local3 = GoBack(f439_arg0, f439_arg1)
	CoD.CraftUtility.EmblemEditor_HandleBackInBrowseMode(f439_local3, f439_arg1)
	ClearMenuSavedState(f439_local3, f439_arg1)
end
function OnSocialMenuBack(f440_arg0, f440_arg1)
	local f440_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "socialRoot.tab"))
	if f440_local0 == "groups" then
		local f440_local1 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f440_arg1), "groups.frameType"))
		if f440_local1 == "invites" or f440_local1 == "members" then
			GroupsSocialChangeTabFrameWidget(f440_arg0, f440_arg0, f440_arg1, "main")
			return
		end
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f440_arg1), "groups.frameType"), "")
	if string.find(f440_local0, "clan_") ~= nil then
		local f440_local1 = Engine[0x8DF2E5447F384B9]()
		f440_local1.socialRoot.tab:set("clan")
	else
		local f440_local1 = Engine[0x8DF2E5447F384B9]()
		f440_local1.socialRoot.tab:set("friends")
	end
	if not IsInGame() then
		SendClientScriptMenuChangeNotify(f440_arg1, f440_arg0, false)
	end
end
function SetSocialTab(f441_arg0, f441_arg1, f441_arg2)
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "socialRoot"), "tab"), f441_arg1.tabId)
end
function FetchOnlineFriendsData(f442_arg0, f442_arg1, f442_arg2)
	if "friends" == f442_arg1.tabId or f442_arg1.tabId == "friendsPlayersList" then
		Engine[0x88BF7ED870A274D](f442_arg2, Enum[0xEA28383B5DEC206][0x98ED4DF2FE3AFF0])
	end
end
function OpenPlatformProfile(f443_arg0, f443_arg1, f443_arg2, f443_arg3, f443_arg4)
	local f443_local0 = Engine[0x4DF5CFBC1771947](f443_arg2)
	local f443_local1
	if f443_arg3 then
		f443_local1 = f443_arg3.xuid
		if not f443_local1 then
		else
			local f443_local2
			if f443_arg3 then
				f443_local2 = f443_arg3.gamertag
				if not f443_local2 then
				else
					Engine[0x730068F00F68FD0](f443_arg2, f443_local1, f443_local2)
				end
			end
			f443_local2 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f443_local0, "Social.selectedFriendGamertag"))
		end
	end
	f443_local1 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f443_local0, "Social.selectedFriendXUID"))
end
function OpenPlatformFriendRequest(f444_arg0, f444_arg1, f444_arg2, f444_arg3, f444_arg4)
	local f444_local0 = Engine[0x4DF5CFBC1771947](f444_arg2)
	local f444_local1
	if f444_arg3 then
		f444_local1 = f444_arg3.xuid
		if not f444_local1 then
		else
			local f444_local2
			if f444_arg3 then
				f444_local2 = f444_arg3.gamertag
				if not f444_local2 then
				else
					if CoD.isPC then
						Engine[0xAF6BD480E7BDBAB](f444_local1)
					else
						Engine[0xF9C6B7BC719697C](f444_arg2, f444_local1, f444_local2)
					end
				end
			end
			f444_local2 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f444_local0, "Social.selectedFriendGamertag"))
		end
	end
	f444_local1 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f444_local0, "Social.selectedFriendXUID"))
end
function SocialJoin(f445_arg0, f445_arg1, f445_arg2, f445_arg3, f445_arg4, f445_arg5)
	if CoD.isPC then
		LobbyQuickJoinWithXuid(f445_arg0, f445_arg2, f445_arg3.xuid)
		return
	elseif Engine[0x7B48C1ABFF0F764]() then
		if not Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f445_arg3.xuid) then
			f445_arg3.migrating = not CoDShared.QuitGame(f445_arg2)
			Engine[0x87AE7E64BA5AD61]("OnInGameJoin", f445_arg3)
		end
	else
		Engine[0x87AE7E64BA5AD61]("OnJoin", f445_arg3)
	end
	if not f445_arg5 then
		local f445_local0 = Engine[0x8DF2E5447F384B9]()
		f445_local0 = f445_local0.lobbyRoot:create("closePopups")
		f445_local0:forceNotifySubscriptions()
	end
end
function CacheSocialOnlinePlayersListModels(f446_arg0, f446_arg1, f446_arg2)
	if Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "socialRoot"), "tab")) == "party" then
		return
	end
	local f446_local0, f446_local1, f446_local2, f446_local3, f446_local4, f446_local5, f446_local6 = nil
	if f446_arg0.cacheRootModel ~= nil then
		f446_local0 = f446_arg0.cacheXuid
		f446_local1 = f446_arg0.cacheParty
		f446_local2 = f446_arg0.cachePartyUpdate
		f446_local6 = f446_arg0.cachePartyGamertags
		f446_local3 = f446_arg0.cachePartyTotal
		f446_local4 = f446_arg0.cachePartyAvailable
		f446_local5 = f446_arg0.cachePartyLeader
	else
		local f446_local7 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "socialRoot")
		f446_local0 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](f446_local7, "cache"), "xuid")
		f446_local1 = Engine[0xA798E4552F5E872](f446_local7, "party")
		f446_local2 = Engine[0xA798E4552F5E872](f446_local1, "update")
		f446_local3 = Engine[0xA798E4552F5E872](f446_local1, "total")
		f446_local4 = Engine[0xA798E4552F5E872](f446_local1, "available")
		f446_local5 = Engine[0xA798E4552F5E872](f446_local1, "leader")
		Engine[0x83C9B5DE1D9371](f446_local0, Engine[0x9073FBE2D48C156]("0"))
		f446_local6 = {}
		for f446_local8 = 1, 18, 1 do
			f446_local6[f446_local8] = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](f446_local1, "pm_" .. f446_local8), "gamertag")
			Engine[0x83C9B5DE1D9371](f446_local6[f446_local8], "")
		end
	end
	if f446_arg1.party ~= nil then
		Engine[0x83C9B5DE1D9371](f446_local0, f446_arg1.xuid)
		Engine[0x83C9B5DE1D9371](f446_local3, f446_arg1.party.total)
		Engine[0x83C9B5DE1D9371](f446_local4, f446_arg1.party.available)
		Engine[0x83C9B5DE1D9371](f446_local5, f446_arg1.party.leader)
		if f446_arg1.party.members ~= nil then
			for f446_local7 = 1, #f446_local6, 1 do
				local f446_local10 = f446_local6[f446_local7]
				if f446_arg1.party.members[f446_local7] ~= nil then
					Engine[0x83C9B5DE1D9371](f446_local10, f446_arg1.party.members[f446_local7].gamertag)
				end
			end
			local f446_local7 = Engine[0x614D394F6F9A18D](f446_local2)
			if f446_local7 < 100000 then
				f446_local7 = f446_local7 + 1
			else
				f446_local7 = 0
			end
			Engine[0x83C9B5DE1D9371](f446_local2, f446_local7)
		end
	end
end
function SetSelectedFriendXUID(f447_arg0, f447_arg1, f447_arg2)
	local f447_local0 = nil
	if f447_arg1 ~= nil then
		local f447_local1 = f447_arg1:getModel()
		local f447_local2 = f447_local1
		local f447_local3 = f447_local1.xuid
		if f447_local3 then
			f447_local3 = f447_local2 and f447_local1.xuid:get()
		end
		if f447_local3 ~= nil then
			local f447_local4 = Engine[0x4DF5CFBC1771947](f447_arg2)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f447_local4, "Social.selectedFriendXUID"), f447_local3)
			local f447_local5 = f447_local1.info and f447_local1.info:get() or f447_local1
			local f447_local6 = f447_local5 and f447_local5.gamertag
			local f447_local7 = f447_local6 and f447_local6:get()
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f447_local4, "Social.selectedFriendGamertag"), f447_local7)
			if Engine[0x4C599F1694E23EF](f447_local3) == "fefefefefefefefe" then
				local f447_local8 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f447_arg2), "socialPlayerInfo.identityBadge")
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f447_local8, "gamertag"), f447_local7)
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f447_local8, "clantag"), "")
			end
			if not CoD.isPC then
				local f447_local8 = f447_local5 and f447_local5.presence
				if f447_local8 ~= nil then
					Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f447_local4, "Social.selectedFriendInTitle"), f447_local8:get() > Enum[0x4BBA402DE649132][0xA2184EBB293AF2D])
				end
			else
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f447_local4, "Social.selectedFriendInTitle"), (f447_local1.battlenetPresence and f447_local1.battlenetPresence:get() or CoD.PCBattlenetUtility.GetBattlenetPresence(f447_local3)) ~= Enum[0x8811A60F2FF3ADA][0xD7B6D45F00CF380])
			end
		end
	end
end
function SocialToggleSorting(f448_arg0, f448_arg1, f448_arg2)
	local f448_local0 = Engine[0x40E824FE270E174](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "socialRoot"), "sort")
	local f448_local1 = Engine[0x614D394F6F9A18D](f448_local0)
	if f448_local1 == Enum[0x3908242653FAC08][0x378D2974EF235BB] then
		Engine[0x83C9B5DE1D9371](f448_local0, Enum[0x3908242653FAC08][0x874C3506F8D93CE])
		Engine[0x1942EEB6839D7E](f448_arg2, Enum[0x3908242653FAC08][0x874C3506F8D93CE])
	elseif f448_local1 == Enum[0x3908242653FAC08][0x874C3506F8D93CE] then
		Engine[0x83C9B5DE1D9371](f448_local0, Enum[0x3908242653FAC08][0x378D2974EF235BB])
		Engine[0x1942EEB6839D7E](f448_arg2, Enum[0x3908242653FAC08][0x378D2974EF235BB])
	end
end
function SocialEnablePresenceCacheAutoupdate(f449_arg0, f449_arg1)
	if Engine[0xC594D9B32C1C725] ~= nil then
		Engine[0xC594D9B32C1C725](f449_arg0, f449_arg1)
	end
end
function UpdateFriends(f450_arg0, f450_arg1, f450_arg2)
	local f450_local0 = f450_arg0
	Engine[0x88BF7ED870A274D](f450_arg2, Enum[0xEA28383B5DEC206][0x98ED4DF2FE3AFF0])
end
function SpectateSelectedPlayer(f451_arg0, f451_arg1, f451_arg2)
	Engine[0xC554A8C36EF7EFF](f451_arg2, "spectate", "clientNum", Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f451_arg1:getModel(), "clientNum")))
end
function SetShoutcastHighlightedPlayer(f452_arg0, f452_arg1, f452_arg2)
	Dvar[0x69E29B87C17AED9]:set(Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f452_arg1:getModel(), "clientNum")))
end
function ToggleCodCasterQuickSettings(f453_arg0, f453_arg1, f453_arg2)
	if not f453_arg1.profileVar then
		return
	elseif not CoD.ShoutcasterProfileVarBool(f453_arg2, f453_arg1.profileVar) then
		CoD.SetShoutcasterProfileVarValue(f453_arg2, f453_arg1.profileVar, 1)
	else
		CoD.SetShoutcasterProfileVarValue(f453_arg2, f453_arg1.profileVar, 0)
	end
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](f453_arg1:getModel(), "profileVarValue"), CoD.ShoutcasterProfileVarBool(f453_arg2, f453_arg1.profileVar))
	if Engine[0x7B48C1ABFF0F764]() and f453_arg1.profileVar == "shoutcaster_ds_thirdperson" then
		Engine[0xB81A5136C5503E4](f453_arg2, "shoutcaster_thirdperson " .. CoD.ShoutcasterProfileVarValue(f453_arg2, f453_arg1.profileVar))
	end
end
function SetCodCasterProfileValue(f454_arg0, f454_arg1, f454_arg2, f454_arg3, f454_arg4)
	CoD.SetShoutcasterProfileVarValue(f454_arg2, f454_arg3, f454_arg4)
end
function AdjustShoutcasterTeam(f455_arg0, f455_arg1, f455_arg2, f455_arg3)
	local f455_local0 = CoD.TeamUtility.GetTeams()
	local f455_local1 = CoD.ShoutcasterProfileVarValue(f455_arg2, "shoutcaster_team")
	local f455_local2 = 0
	for f455_local6, f455_local7 in pairs(f455_local0) do
		if f455_local7 == f455_local1 then
			f455_local2 = f455_local6 - 1
			break
		end
	end
	f455_local4 = f455_local0[(f455_local2 + f455_arg3) % #f455_local0 + 1]
	if f455_local4 then
		CoD.SetShoutcasterProfileVarValue(f455_arg2, "shoutcaster_team", f455_local4)
	end
end
function HandleTeamIdentityKeyboardComplete(f456_arg0, f456_arg1, f456_arg2, f456_arg3)
	local f456_local0, f456_local1 = nil
	local f456_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.TeamIdentity.getModel(f456_arg2), "team"))
	local f456_local3 = DataSources.TeamIdentityInformation.getModel(f456_arg2, f456_local2)
	if f456_arg3.type == Enum[0x85FCE2AA5391A7C][0x24364F159D318D1] then
		f456_local0 = Engine[0x40E824FE270E174](f456_local3, "teamName")
		f456_local1 = "shoutcaster_fe_" .. f456_local2 .. "_name"
	end
	if f456_local0 then
		Engine[0x83C9B5DE1D9371](f456_local0, f456_arg3.input)
		CoD.SetShoutcasterProfileVarValue(f456_arg2, f456_local1, f456_arg3.input)
	end
end
function SetTeamIdentityProfileValue(f457_arg0, f457_arg1, f457_arg2, f457_arg3)
	if not f457_arg3 or f457_arg3 == "" then
		return
	else
		local f457_local0 = Engine[0x40E824FE270E174](f457_arg1:getModel(), "id")
		if not f457_local0 then
			return
		else
			CoD.SetShoutcasterProfileVarValue(f457_arg2, "shoutcaster_fe_" .. Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.TeamIdentity.getModel(f457_arg2), "team")) .. "_" .. f457_arg3, Engine[0x614D394F6F9A18D](f457_local0))
		end
	end
end
function SetTeamIdentityTeamLogo(f458_arg0, f458_arg1, f458_arg2)
	local f458_local0 = DataSources.TeamIdentityInformation.getModel(f458_arg2, Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.TeamIdentity.getModel(f458_arg2), "team")))
	local f458_local1 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f458_arg1:getModel(), "ref"))
	local f458_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f458_arg1:getModel(), "name"))
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](f458_local0, "teamLogo"), f458_local1)
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](f458_local0, "teamLogoName"), f458_local2)
end
function SetTeamIdentityTeamColor(f459_arg0, f459_arg1, f459_arg2)
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](DataSources.TeamIdentityInformation.getModel(f459_arg2, Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.TeamIdentity.getModel(f459_arg2), "team"))), "teamColor"), Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f459_arg1:getModel(), "color")))
end
function UpdateSelectedTeamIdentityColorElement(f460_arg0, f460_arg1, f460_arg2)
	local f460_local0 = CoD.ShoutcasterProfileVarValue(f460_arg2, "shoutcaster_fe_" .. Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](DataSources.TeamIdentity.getModel(f460_arg2), "team")) .. "_color")
	local f460_local1 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f460_arg1:getModel(), "id"))
	local f460_local2 = f460_arg0.TeamColorList:findItem({
		id = f460_local0,
	})
	if f460_local2 then
		Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](f460_local2:getModel(), "selected"), false)
	end
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](f460_arg1:getModel(), "selected"), true)
end
function SaveShoutcasterSettings(f461_arg0, f461_arg1, f461_arg2)
	Engine[0x28A466EF7723621](f461_arg2, Enum[0xBBD4F9E70101BA8][0xED1503A2D3DAE6])
end
function OpenBlackMarket(f462_arg0, f462_arg1, f462_arg2)
	if Engine[0xCD0619BD5508280](f462_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.LOOT) then
		DisplayAnticheatMessage(f462_arg0, f462_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.LOOT, "", "")
		return
	end
	for f462_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
		if CheckIfFeatureIsBanned(f462_local0, LuaEnum.FEATURE_BAN.LOOT) then
			LuaUtils.UI_ShowErrorMessageDialog(f462_arg2, GetFeatureBanInfo(f462_local0, LuaEnum.FEATURE_BAN.LOOT))
			return
		end
	end
	OpenOverlay(f462_arg0, "BlackMarket", f462_arg2)
end
function QuitPCGame_MP(f463_arg0, f463_arg1, f463_arg2)
	if CoD.isPC then
		if LuaUtils.IsArenaMode() then
			return CoD.OverlayUtility.CreateOverlay(f463_arg1, f463_arg0, "QuitPCArenaMatchPopup", f463_arg2)
		else
			return CoD.OverlayUtility.CreateOverlay(f463_arg1, f463_arg0, "QuitPCMatchPopup", f463_arg2)
		end
	else
	end
end
function QuitPCGame_WZ_Spectating(f464_arg0, f464_arg1)
	if CoD.isPC then
		return CoD.OverlayUtility.CreateOverlay(f464_arg1, f464_arg0, "QuitPCMatchWhileSpectatingPopup")
	else
	end
end
function OpenPCQuit(f465_arg0, f465_arg1, f465_arg2, f465_arg3)
	if CoD.isPC and not Engine[0x498D0E20C7F1218]() then
		local f465_local0 = f465_arg0:getMenu()
		if f465_local0.pcQuitOverlayActive ~= nil then
			f465_local0.pcQuitOverlayActive = true
		end
		local f465_local1 = nil
		if f465_local0.id ~= "Menu.Main" and IsArenaMode() then
			f465_local1 = CoD.OverlayUtility.CreateOverlay(f465_arg3, f465_arg0, "QuitPCArenaGamePopup")
		else
			f465_local1 = CoD.OverlayUtility.CreateOverlay(f465_arg3, f465_arg0, "QuitPCGamePopup")
		end
		if f465_local1 and CoD.PCKoreaUtility.IsInKorea() then
			f465_local1.KoreaIcons = CoD.PC_Quit_Korea_Container.new(f465_arg0, f465_arg3, 0, 1, 0, 0, 0, 1, 0, 0)
			f465_local1:addElement(f465_local1.KoreaIcons)
			f465_arg0:sendInitializationEvents(f465_arg3, f465_local1.KoreaIcons)
			LUI.OverrideFunction_CallOriginalSecond(f465_local1, "close", function(element)
				if f465_local1.KoreaIcons then
					f465_local1.KoreaIcons:close()
					f465_local1.KoreaIcons = nil
				end
			end)
		end
		f465_local0._quitOverlay = f465_local1
		LUI.OverrideFunction_CallOriginalSecond(f465_local0, "close", function(element)
			if element.pcQuitOverlayActive then
				element.pcQuitOverlayActive = false
				element._quitOverlay:close()
				element._quitOverlay = nil
			end
		end)
	end
end
function ResetPCControlsToDefault(f468_arg0, f468_arg1)
	Engine[0xF5E06BF5D4254B3](f468_arg1)
	CoD.PCOptionsUtility.RevertPCHardwareChanges(f468_arg0, f468_arg1)
end
function ResetEverythingOnPC(f469_arg0, f469_arg1)
	ResetPCControlsToDefault(f469_arg0, f469_arg1)
	ResetPCBindingsToDefault(f469_arg0, f469_arg1)
	Dvar.cl_firstTimeOpenControlsOptionsScreen:set(true)
	CoD.CACUtility.SetDefaultLoadouts({
		controller = f469_arg1,
		storageFileType = Enum[0xBBD4F9E70101BA8][0xF9A4C4451E3499E],
	})
	CoD.CACUtility.SetDefaultLoadouts({
		controller = f469_arg1,
		storageFileType = Enum[0xBBD4F9E70101BA8][0xD062FA7B47FC13A],
	})
end
function GetGameplayOptionsAndSendToDlog(f470_arg0)
	local f470_local0 = {}
	for f470_local4, f470_local5 in ipairs({
		0x449C35D713F0591,
		0xC0183841682A478,
		0x8E2603F64924C43,
		0x51ACED7DF0546AF,
		0x908DA91B796EF6C,
		0x4AE3D347A07EF76,
		0xCA67B57C1673886,
		0xA1248989633ACD3,
		0x149D47F55A63FCE,
		0x8307BBD1B08F4F6,
		0x2067E82557971DD,
		0x5C8A34838083469,
		0x2A230CA7EF4FC3B,
		0x1ACC323E6BB7F60,
		0x8CE07BBB4571454,
		0x1AE8EB2799AFFDD,
		0x40948D6DAD927CC,
		0x3ACD00BFA946E04,
		0x2F32416F055FB97,
		0x776C366A031E7AA,
		0xE40A5983CFC89E,
		0xE097D1CD549FC9F,
		0x9EC6E9BBF1E624,
		0xA8185C366CE482D,
		0xDC87A9A3F0598F7,
		0x5CAB10393A53422,
		0x7752D94F07335E2,
		0x822BC17B9C05B55,
		0x390921F2448418A,
		0xDD0F63C56107AFE,
		0xEB73EA37514AB9B,
		0x6DE9FB5C4249D93,
		0x8F129F338DA3F71,
		0x17E6145DFB22A72,
		0x4450BE10E911B4A,
		0x638BD10A42E5F63,
		0x66E5DDF4F903021,
		0xC6C61740D1F775A,
		0x5162012A7259ACA,
		0x7F5133E1E3E624A,
	}) do
		if f470_local5 == 0x6DE9FB5C4249D93 then
			f470_local0[0x6DE9FB5C4249D93] = CoD.PCOptionsUtility.GetCurrentOptionValue(f470_local5, f470_arg0) ~= 0
		end
		if f470_local5 == 0x149D47F55A63FCE then
			f470_local0[0x149D47F55A63FCE] = CoD.PCOptionsUtility.GetCurrentOptionValue(f470_local5, f470_arg0) ~= 0
		else
			f470_local0[f470_local5] = CoD.PCOptionsUtility.GetCurrentOptionValue(f470_local5, f470_arg0) ~= 0
		end
	end
	f470_local0[0x659B9A54E5830C7] = Dvar[0x659B9A54E5830C7]:get()
	f470_local0[0x7ED85B05E9BCDB9] = Dvar[0x7ED85B05E9BCDB9]:get()
	f470_local0[0xB790F54FC3DEE14] = Dvar[0x4EB1835CF0F023D]:get()
	Engine[0xDE279ECDDDD966](f470_arg0, 0x21034E1157F040C, f470_local0)
end
function GetKeybindsAndSendToDlog(f471_arg0)
	local f471_local0 = function(f472_arg0)
		return string.gsub(string.gsub(string.gsub(string.gsub(f472_arg0, "%^", ""), "BmouseWheelDown", "MW_Down"), "BmouseWheelUp", "MW_Up"), "BmouseButton", "MB_")
	end
	local f471_local1 = {}
	local f471_local2 = {
		"+forward",
		"+back",
		"+moveleft",
		"+moveright",
		"+gostand",
		"+movedown",
		"togglecrouch",
		"gocrouch",
		"+prone",
		"toggleprone",
		"goprone",
		"+breath_sprint",
		"+breath_holdsprint",
		"+sprint",
		"+hold_sprint",
		"+holdbreath",
		"togglebreath",
		"+stance",
		"slide",
		"autorun",
		"+raisestance",
		"+raisestancejump",
		"+lowerstance",
		"+mantle",
		"+attack",
		"+speed_throw",
		"+toggleads_throw",
		"weapnext",
		"weapprev",
		"weapswitchprimary",
		"weapswitchsecondary",
		"+frag",
		"+smoke",
		"+weapoffhandspecial",
		"+melee_zoom",
		"+melee",
		"+activate",
		"scorestreak1",
		"scorestreak2",
		"scorestreak3",
		"scorestreak4",
		"+scores",
		"togglescores",
		"+scoreszm",
		"togglescoreszm",
		"+map",
		"togglemap",
		"+inventoryzm",
		"toggleinventoryzm",
		"togglescoreswz",
	}
	local f471_local3 = "+scoreswz"
	local f471_local4 = "chooseclass_1"
	local f471_local5 = "chooseclass_2"
	local f471_local6 = "chooseclass_3"
	local f471_local7 = "chooseclass_4"
	local f471_local8 = "chooseclass_5"
	local f471_local9 = "chooseclass_6"
	local f471_local10 = "chooseclass_7"
	local f471_local11 = "chooseclass_8"
	local f471_local12 = "chooseclass_9"
	local f471_local13 = "chooseclass_10"
	local f471_local14 = "chooseclass_11"
	local f471_local15 = "chooseclass_12"
	local f471_local16 = "flourish"
	local f471_local17 = "+calloutwheel"
	local f471_local18 = "quickspray"
	local f471_local19 = "+spraygesturewheel"
	local f471_local20 = "quickcallout"
	local f471_local21 = "+vehiclealtcontrol"
	local f471_local22 = "+vehicleboost"
	local f471_local23 = "+vehicleattack"
	local f471_local24 = "+vehicleattacksecond"
	local f471_local25 = "+vehiclemovedown"
	local f471_local26 = "+vehiclemoveup"
	local f471_local27 = "+handbrake"
	local f471_local28 = "+switchseat"
	local f471_local29 = "+vehicleseat1"
	local f471_local30 = "+vehicleseat2"
	local f471_local31 = "+vehicleseat3"
	local f471_local32 = "+vehicleseat4"
	local f471_local33 = "+vehicleseat5"
	local f471_local34 = "+vehiclehorn"
	local f471_local35 = "+pickup"
	local f471_local36 = "+inventory"
	local f471_local37 = "toggleinventory"
	local f471_local38 = "quickcycle_equipment"
	local f471_local39 = "quickcycle_health"
	local f471_local40 = "+armorrepair"
	local f471_local41 = "quickconsume1"
	local f471_local42 = "quickconsume2"
	local f471_local43 = "usebgb1"
	local f471_local44 = "usebgb2"
	local f471_local45 = "usebgb3"
	local f471_local46 = "usebgb4"
	local f471_local47 = "chatmodepublic"
	local f471_local48 = "chatmodeteam"
	local f471_local49 = "chatmodeparty"
	local f471_local50 = "+talk"
	local f471_local51 = "chatmodelast"
	local f471_local52 = "+lookup"
	f471_local2[33] = f471_local3
	f471_local2[34] = f471_local4
	f471_local2[35] = f471_local5
	f471_local2[36] = f471_local6
	f471_local2[37] = f471_local7
	f471_local2[38] = f471_local8
	f471_local2[39] = f471_local9
	f471_local2[40] = f471_local10
	f471_local2[41] = f471_local11
	f471_local2[42] = f471_local12
	f471_local2[43] = f471_local13
	f471_local2[44] = f471_local14
	f471_local2[45] = f471_local15
	f471_local2[46] = f471_local16
	f471_local2[47] = f471_local17
	f471_local2[48] = f471_local18
	f471_local2[49] = f471_local19
	f471_local2[50] = f471_local20
	f471_local2[51] = f471_local21
	f471_local2[52] = f471_local22
	f471_local2[53] = f471_local23
	f471_local2[54] = f471_local24
	f471_local2[55] = f471_local25
	f471_local2[56] = f471_local26
	f471_local2[57] = f471_local27
	f471_local2[58] = f471_local28
	f471_local2[59] = f471_local29
	f471_local2[60] = f471_local30
	f471_local2[61] = f471_local31
	f471_local2[62] = f471_local32
	f471_local2[63] = f471_local33
	f471_local2[64] = f471_local34
	f471_local2[65] = f471_local35
	f471_local2[66] = f471_local36
	f471_local2[67] = f471_local37
	f471_local2[68] = f471_local38
	f471_local2[69] = f471_local39
	f471_local2[70] = f471_local40
	f471_local2[71] = f471_local41
	f471_local2[72] = f471_local42
	f471_local2[73] = f471_local43
	f471_local2[74] = f471_local44
	f471_local2[75] = f471_local45
	f471_local2[76] = f471_local46
	f471_local2[77] = f471_local47
	f471_local2[78] = f471_local48
	f471_local2[79] = f471_local49
	f471_local2[80] = f471_local50
	f471_local2[81] = f471_local51
	f471_local2[82] = f471_local52
	f471_local3 = "+lookdown"
	f471_local4 = "+left"
	f471_local5 = "+right"
	f471_local6 = "centerview"
	f471_local7 = "ui_contextual_1"
	f471_local8 = "ui_contextual_2"
	f471_local9 = "ui_contextual_3"
	f471_local2[65] = f471_local3
	f471_local2[66] = f471_local4
	f471_local2[67] = f471_local5
	f471_local2[68] = f471_local6
	f471_local2[69] = f471_local7
	f471_local2[70] = f471_local8
	f471_local2[71] = f471_local9
	for f471_local6, f471_local7 in ipairs(f471_local2) do
		f471_local8 = Engine[0xDFD7EFA83DD8C75](f471_arg0, f471_local7, false)
		f471_local9 = string.gsub(f471_local7, "+", "")
		if string.find(f471_local8, "%^") ~= nil then
			f471_local8 = f471_local0(f471_local8)
		end
		f471_local1[Engine[0xC53F8D38DF9042B](f471_local9)] = f471_local8
	end
	f471_local1[0x88C9F291EEBF570] = Dvar.cl_bindings_presetId:get()
	Engine[0xDE279ECDDDD966](f471_arg0, 0x519B7131242305E, f471_local1)
end
function DispatchOptionRefreshEvent(f473_arg0, f473_arg1)
	f473_arg0:dispatchEventToRoot({
		name = "options_refresh",
		controller = f473_arg1,
	})
end
function ResetPCBindingsToDefault(f474_arg0, f474_arg1)
	if Dvar[0xF52444CC548D39F]:get() then
		Engine[0xB81A5136C5503E4](f474_arg1, "resetprofilecommon")
		Engine[0xB81A5136C5503E4](f474_arg1, "updategamerprofile")
		Engine[0xB81A5136C5503E4](f474_arg1, "storagereset stats_mp_offline")
	end
	Engine[0xB81A5136C5503E4](f474_arg1, "defaultbindings")
	Engine[0xB81A5136C5503E4](f474_arg1, "execcontrollerbindings")
	Engine[0x8257260A97ACE1F]()
	Dvar.cl_bindings_presetId:set(0)
	Dvar.cl_bindings_presetIsModified:set(false)
	DispatchOptionRefreshEvent(f474_arg0, f474_arg1)
end
function LoadPCBindings(f475_arg0, f475_arg1, f475_arg2)
	Engine[0xB81A5136C5503E4](f475_arg1, "selectbindings " .. f475_arg2)
	DispatchOptionRefreshEvent(f475_arg0, f475_arg1)
end
function ResetPCBindings(f476_arg0, f476_arg1)
	Engine[0xB81A5136C5503E4](f476_arg1, "defaultbindings")
	DispatchOptionRefreshEvent(f476_arg0, f476_arg1)
end
function ResetPCGraphicsOptions(f477_arg0, f477_arg1, f477_arg2, f477_arg3)
	Engine[0x31862D5C316E640](f477_arg2)
	Engine[0x8380915E32EF0B5]()
	Engine[0x7C75E608EA39B5C](nil, "vid_restart")
	CoD.PCOptionsUtility.RevertPCHardwareChanges(f477_arg0, f477_arg2)
	CoD.PCOptionsUtility.RefreshAllOptions(f477_arg1, f477_arg2)
	CoD.PCOptionsUtility.DelayVRAMBarUpdate(f477_arg3:getParent(), f477_arg2, 0)
end
function SetVerticaListSpacerHeight(f478_arg0, f478_arg1)
	if f478_arg1 then
		local f478_local0 = Engine[0x614D394F6F9A18D](f478_arg1)
		if f478_local0 then
			f478_arg0:setTopBottom(true, false, 0, f478_local0)
		end
	end
end
function EnableMouseButton(f479_arg0, f479_arg1)
	f479_arg0:setHandleMouseButton(true)
end
function DisableMouseButton(f480_arg0, f480_arg1)
	f480_arg0:setHandleMouseButton(false)
end
function EnableMouseMove(f481_arg0, f481_arg1)
	f481_arg0:setHandleMouseMove(true)
end
function Gunsmith_ClearSelectedGunsmithVariantStats(f482_arg0)
	local f482_local0 = CoD.perController[f482_arg0].gunsmithVariantModel
	if f482_local0 then
		local f482_local1 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f482_local0, "variantIndex"))
		CoD.CraftUtility.Gunsmith.ClearVariantStats(f482_arg0, f482_local1, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
		CoD.CraftUtility.Gunsmith.ClearVariantStats(f482_arg0, f482_local1, Enum[0x9C0C2196D8313A0][0x60063C67132EB69])
	end
end
function Gunsmith_ClearCACWithUpdatedVariant(f483_arg0, f483_arg1)
	local f483_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](CoD.perController[f483_arg1].gunsmithVariantModel, "variantIndex")) + 1
	local f483_local1 = function(f484_arg0, f484_arg1, f484_arg2)
		local f484_local0 = Engine[0x2CE1809FB455852](f483_arg1, f484_arg0, f484_arg1, f484_arg2)
		if f484_local0 > CoD.CACUtility.EmptyItemIndex and f484_local0 == f483_local0 then
			Engine[0xDC8E7F5A60958D6](f483_arg1, f484_arg0, f484_arg1, CoD.CACUtility.EmptyItemIndex, f484_arg2)
		end
	end
	local f483_local2 = function(f485_arg0)
		local f485_local0 = CoD.CACUtility.GetCustomClassCount(f483_arg1, f485_arg0)
		for f485_local1 = 1, f485_local0, 1 do
			local f485_local4 = f485_local1 - 1
			f483_local1(f485_local4, "primarygunsmithvariant", f485_arg0)
			f483_local1(f485_local4, "secondarygunsmithvariant", f485_arg0)
		end
	end
	f483_local2(Enum[0x9C0C2196D8313A0][0x60063C67132EB69])
	f483_local2(Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
end
function Gunsmith_SnapshotToggleDisplayProperty(f486_arg0, f486_arg1, f486_arg2)
	local f486_local0 = f486_arg1:getModel(f486_arg2, "param")
	if f486_local0 then
		local f486_local1 = Engine[0x614D394F6F9A18D](f486_local0)
		if f486_local1 then
			local f486_local2 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), f486_local1)
			if f486_local2 then
				Engine[0x83C9B5DE1D9371](f486_local2, (Engine[0x614D394F6F9A18D](f486_local2) + 1) % 2)
			end
		end
	end
end
function OpenCustomGamesLobby(f487_arg0, f487_arg1)
	if not IsLobbyNetworkModeLAN() then
		CoD.DirectorUtility.NavigateToCustomLobbyForCurrentMode(f487_arg0, f487_arg1)
	else
		CoD.DirectorUtility.OfflineNavigateToCustomGames(f487_arg0, f487_arg1)
	end
end
function OpenResetGameSettingsPopup(f488_arg0, f488_arg1, f488_arg2, f488_arg3, f488_arg4)
	f488_arg4:saveState(f488_arg2)
	CoD.OverlayUtility.CreateOverlay(f488_arg2, f488_arg0, "ResetCustomGameSettingsPC")
end
function CopyModelFindElement(f489_arg0, f489_arg1, f489_arg2, f489_arg3)
	local f489_local0 = f489_arg2
	while f489_local0 and not f489_local0[f489_arg3] do
		f489_local0 = f489_local0:getParent()
	end
	if f489_local0 and f489_local0[f489_arg3] then
		f489_local0[f489_arg3]:setModel(f489_arg2:getModel(), f489_arg1)
	end
end
function CopyScrollViewActiveModelToElementAndCacheSocialData(f490_arg0, f490_arg1, f490_arg2, f490_arg3)
	local f490_local0 = f490_arg2.ScrollView.View.activeWidget
	if f490_local0 then
		f490_arg3:setModel(f490_local0:getModel(), f490_arg1)
		CacheSocialOnlinePlayersListModels(f490_arg0, f490_local0, f490_arg1)
	end
end
function StartMenuGoBack_ListElement(f491_arg0, f491_arg1, f491_arg2, f491_arg3, f491_arg4)
	StartMenuGoBack(f491_arg4, f491_arg2)
end
function StartMenuGoBack(f492_arg0, f492_arg1)
	if f492_arg0.onStartMenuClosed then
		f492_arg0:onStartMenuClosed(f492_arg1)
	end
	StartMenuResumeGame(f492_arg0, f492_arg1)
	if IsInGame() then
		if f492_arg0:getParent() then
		else
			ClearMenuSavedState(f492_arg0)
		end
		while f492_arg0.occludedBy ~= nil do
			GoBack(f492_arg0.occludedBy, f492_arg1)
		end
		if f492_arg0.occludedMenu ~= nil and f492_arg0.occludedMenu.occludedBy == f492_arg0 then
			if f492_arg0.occludedBy ~= nil then
				f492_arg0.occludedMenu.occludedBy = f492_arg0.occludedBy
			else
				if IsGameTypeDOA() and Engine[0xBC62B0E988DCCAF]() then
					f492_arg0.occludedMenu:setOwner(f492_arg0:getOwner())
				end
				f492_arg0.occludedMenu:processEvent({
					name = "occlusion_change",
					occluded = false,
					occludedBy = f492_arg0,
					controller = f492_arg1,
				})
				local f492_local0 = Engine[0x4DF5CFBC1771947](f492_arg1)
				f492_local0 = f492_local0.PositionDraft.stage:get()
				if f492_local0 and f492_local0 > 0 then
					f492_arg0.occludedMenu:setAlpha(1)
				end
			end
		end
		f492_arg0.m_disableAllButtonActions = true
		if DataSources.FreeCursor.getButtonPromptsModel(f492_arg1) == f492_arg0.buttonModel then
			DataSources.FreeCursor.registerButtonPrompts(f492_arg1, nil)
		end
		f492_arg0:processEvent({
			name = "lose_focus",
			controller = f492_arg1,
		})
		if CoD.GetMouseFocus(f492_arg1) and f492_arg0:isParentOf(CoD.GetMouseFocus(f492_arg1)) then
			CoD.SetCurrentMouseFocus(f492_arg1, nil)
		end
		CoD.HUDUtility.GiveFocus(f492_arg0.occludedMenu, f492_arg1)
		if CoD.isPC then
			CoD.PCUtility.MigrateStickyElementsBackward(f492_arg0, f492_arg1)
			if IsDemoPlaying() then
				CoD.DemoUtility.GiveFocusToDemoEmptyFocusableOnPC(f492_arg0.occludedMenu, f492_arg1)
			end
		end
		local f492_local0 = f492_arg0:getParent()
		f492_local0:removeElement(f492_arg0)
	else
		GoBack(f492_arg0, f492_arg1)
		if CoD.isPC then
			CoD.PCUtility.MigrateStickyElementsBackward(f492_arg0, f492_arg1)
		end
	end
	ClearMenuSavedState(f492_arg0)
end
function UpdateTabDatasource(f493_arg0)
	local f493_local0 = LUI.getTableFromPath("Tabs.grid", f493_arg0)
	if f493_local0 then
		f493_local0:updateDataSource(true)
	end
end
function UpdateStartMenuTabsDatasource(f494_arg0)
	local f494_local0 = LUI.getTableFromPath("FETabBar.Tabs.grid", f494_arg0)
	if f494_local0 then
		f494_local0:updateDataSource(true)
	end
end
function StartMenuResumeGame(f495_arg0, f495_arg1)
	if Engine[0x7B48C1ABFF0F764]() and Engine[0xA1D8D9E5D79905F]() and not Engine[0xA55C3ACD0D2BCF0]() then
		if IsZombies() then
			Engine[0xFA25B276065ED3C]()
		else
			Engine[0xB177D654FFB67BE]("cl_paused", 0)
		end
	end
	if Engine[0x7B48C1ABFF0F764]() then
		local f495_local0 = 0
		local f495_local1 = Engine[0x370E918BE7B2017]() - 1
		for f495_local2 = f495_local0, f495_local1, 1 do
			if Engine[0xF285055A1A895A1](f495_local2) then
				Engine[0x70B0A2EF2A81722](f495_local2, Enum[0x52E616D9ABDBF0E][0xA1CE036AEF3710F])
			end
		end
	end
end
function CloseStartMenu(f496_arg0, f496_arg1)
	local f496_local0 = GoBackToMenu(f496_arg0, f496_arg1, "StartMenu_Main")
	if f496_local0.menuName == "StartMenu_Main" or f496_local0.menuName == "DOA_INGAME_PAUSE" then
		StartMenuGoBack(f496_local0, f496_arg1)
	end
end
function RefreshLobbyRoom(f497_arg0, f497_arg1)
	if Engine[0x7B48C1ABFF0F764]() then
		return
	end
	local f497_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyGameMode")
	local f497_local1 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyMainMode")
	local f497_local2 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.isMatchmaking")
	local f497_local3 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.showSelect")
	local f497_local4 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.room")
	if f497_local4 then
		local f497_local5 = Engine[0x614D394F6F9A18D](f497_local4)
		if f497_local5 == "auto" then
			f497_local5 = Engine[0x4967D1FBE8D3CB5](Engine[0x19A789A53E7F2F](f497_arg1))
			if Engine[0xC68FC14365BB66B](Enum[0x1DD23D27A61F09A][0x3E66A586897A605]) == true then
				f497_local5 = f497_local5 .. "_local"
			end
			if IsCustomLobby() then
				f497_local5 = f497_local5 .. "_custom"
			end
		end
		local f497_local6 = LobbyData.GetCurrentMenuTarget()
		if f497_local2:get() and f497_local1:get() == Enum[0x89C1455C5032969][0x7E41449995CD57E] and IsLobbyMode(Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9]) then
			SendCustomClientScriptMenuStateChangeNotify(f497_arg1, "Main", true, "matchmaking")
		elseif not f497_local3:get() and f497_local6[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE then
			SendCustomClientScriptMenuStateChangeNotify(f497_arg1, "Main", true, "room3")
		else
			SendCustomClientScriptMenuStateChangeNotify(f497_arg1, "Main", true, f497_local5)
		end
		f497_arg0.previousRoom = f497_local5
	end
	if LuaUtils.GetEModeForLobbyMainMode(f497_local1:get()) == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] and not IsFirstTimeSetup(f497_arg1, Enum[0x9C0C2196D8313A0][0x60063C67132EB69]) then
		CoD.CPUtility.EnteredCP_FlowComplete(f497_arg1)
	end
end
function OpenLobbyInspection(f498_arg0, f498_arg1, f498_arg2)
	if CoD.DirectorUtility.DisableForCurrentMilestone(f498_arg2) then
		SetSelectedFriendXUID(f498_arg0, f498_arg1, f498_arg2)
		OpenOverlay(f498_arg1, "Social_PlayerDetailsPopup", f498_arg2, {
			disableInspection = true,
		})
	else
		local f498_local0 = OpenOverlay
		local f498_local1 = f498_arg0
		local f498_local2 = "LobbyInspection"
		local f498_local3 = f498_arg2
		local f498_local4 = {}
		local f498_local5 = f498_arg1:getModel()
		f498_local5 = f498_local5.info:get()
		f498_local4.selectedXUID = f498_local5.xuid:get()
		f498_local0(f498_local1, f498_local2, f498_local3, f498_local4)
	end
end
function UpdatePlayerInspection(f499_arg0, f499_arg1, f499_arg2)
	local f499_local0 = f499_arg1:getModel()
	f499_local0 = f499_local0.info
	local f499_local1
	if f499_local0 then
		f499_local1 = f499_local0:get()
		f499_local1 = f499_local1.xuid:get()
		if not f499_local1 then
		else
			if Engine[0xF7F835CF63F45B](f499_local1) then
				Engine[0x6ABA4D7F0840A1E](f499_arg2, "inspect_player", {
					xuid = Engine[0x5065E759595C457](f499_local1),
				})
			end
		end
	end
	f499_local1 = f499_arg1:getModel()
	f499_local1 = f499_local1.xuid:get()
end
function UpdatePlayerInspectionWeapon(f500_arg0, f500_arg1, f500_arg2)
	local f500_local0 = f500_arg1:getModel()
	f500_local0 = f500_local0.info
	local f500_local1
	if f500_local0 then
		f500_local1 = f500_local0:get()
		f500_local1 = f500_local1.xuid:get()
		if not f500_local1 then
		else
			local f500_local2 = Engine[0x3EAC408F958FF05]()
			if f500_local2 >= Enum[0x9C0C2196D8313A0][0x96642BDE9B5962E] then
				return
			end
			local f500_local3 = {
				clear_weapon = true,
			}
			if Engine[0xF7F835CF63F45B](f500_local1) then
				local f500_local4 = Engine[0x8D62F7DFF8054F6](f500_local1)
				if f500_local4 then
					local f500_local5 = DataSources.InspectionWeapon.getModel(f500_arg2)
					f500_local5.weaponIndex:set(f500_local4.weaponIndex)
					f500_local5.camoIndex:set(f500_local4.camoIndex)
					local f500_local6 = f500_local4.weaponIndex
					if f500_local6 > CoD.CACUtility.EmptyItemIndex then
						local f500_local7 = Engine[0xB98952F69D937F9](f500_local6, Enum[0x6EB546760F890D2][0x569E84652131CD7], f500_local2)
						local f500_local8 = ""
						for f500_local12, f500_local13 in ipairs(f500_local4.attachments) do
							if f500_local13.attachmentIndex > CoD.CACUtility.EmptyItemIndex then
								f500_local8 = LUI.appendStringWithDelimiter(f500_local8, Engine[0x2E29FB421AD554B](f500_local6, f500_local13.attachmentIndex), "+")
							end
						end
						f500_local3 = {
							weapon = f500_local7,
							attachments = f500_local8,
							camoIndex = f500_local4.camoIndex,
							paintjobSlot = f500_local4.paintjobSlot,
							weaponModelSlot = f500_local4.weaponModelSlot,
						}
					end
				end
			end
			Engine[0x6ABA4D7F0840A1E](f500_arg2, "inspect_player_weapon", f500_local3)
		end
	end
	f500_local1 = f500_arg1:getModel()
	f500_local1 = f500_local1.xuid:get()
end
function UpdateGamerprofile(f501_arg0, f501_arg1, f501_arg2)
	Engine[0x7C75E608EA39B5C](f501_arg2, "updategamerprofile")
end
function OpenGroupEmblemSelect(f502_arg0, f502_arg1, f502_arg2, f502_arg3, f502_arg4)
	CoD.SetCustomization(f502_arg2, Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2], "type")
	Engine[0x74D36976C1BD7E](f502_arg2)
	local f502_local0 = true
	CoD.perController[f502_arg2].selectedEmblemTabStorageType = f502_arg3
	CoD.CraftUtility.SetSelectedStorageFileType(f502_arg2, f502_arg3)
	f502_local0 = CoD.CraftUtility.Emblems.ParseDDL(f502_arg2, CoD.perController[f502_arg2].selectedEmblemTabStorageType, CoD.perController[f502_arg2].selectedEmblemTabStickerCategory)
	if f502_local0 then
		f502_local0 = CoD.CraftUtility.Groups.ParseDDL(f502_arg2)
	end
	if f502_local0 then
		OpenOverlay(f502_arg0, "EmblemSelect", f502_arg2, {
			_selectGroupEmblem = true,
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f502_arg2, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]),
		})
	end
end
function OpenEmblemSelect(f503_arg0, f503_arg1, f503_arg2, f503_arg3, f503_arg4, f503_arg5)
	if f503_arg5 then
		if Engine[0xCD0619BD5508280](f503_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC) then
			DisplayAnticheatMessage(f503_arg4, f503_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC, "EmblemEditor", "")
			return
		elseif CheckIfFeatureIsBanned(f503_arg2, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT) then
			LuaUtils.UI_ShowErrorMessageDialog(f503_arg2, GetFeatureBanInfo(f503_arg2, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT))
			return
		end
	end
	CoD.SetCustomization(f503_arg2, Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2], "type")
	Engine[0x74D36976C1BD7E](f503_arg2)
	local f503_local0 = true
	if f503_arg5 == "true" then
		CoD.perController[f503_arg2].selectedEmblemTabStorageType = f503_arg3
		CoD.CraftUtility.SetSelectedStorageFileType(f503_arg2, f503_arg3)
		f503_local0 = CoD.CraftUtility.Emblems.ParseDDL(f503_arg2, CoD.perController[f503_arg2].selectedEmblemTabStorageType, CoD.perController[f503_arg2].selectedEmblemTabStickerCategory)
	else
		CoD.perController[f503_arg2].selectedEmblemTabStorageType = nil
	end
	if f503_local0 then
		f503_local0 = CoD.CraftUtility.Groups.ParseDDL(f503_arg2)
	end
	if f503_local0 then
		OpenOverlay(f503_arg0, "EmblemSelect", f503_arg2, {
			_isEditor = f503_arg5,
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f503_arg2, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]),
		})
	end
end
function OpenEmblemEditor(f504_arg0, f504_arg1, f504_arg2, f504_arg3)
	if Engine[0xCD0619BD5508280](f504_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC) then
		DisplayAnticheatMessage(f504_arg1, f504_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC, "EmblemEditor", "")
		return
	elseif CheckIfFeatureIsBanned(f504_arg2, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT) then
		LuaUtils.UI_ShowErrorMessageDialog(f504_arg2, GetFeatureBanInfo(f504_arg2, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT))
		return
	else
		CoD.CraftUtility.EmblemSelect_ChooseEmblem(f504_arg1, f504_arg0, f504_arg2)
		OpenOverlay(f504_arg1, "EmblemEditor", f504_arg2, {
			_storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f504_arg2, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]),
		})
	end
end
function OpenPaintjobEditor(f505_arg0, f505_arg1, f505_arg2, f505_arg3)
	if Engine[0xCD0619BD5508280](f505_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC) then
		DisplayAnticheatMessage(f505_arg1, f505_arg2, LuaEnum.ANTICHEAT_MESSAGE_GROUPS.UGC, "PaintjobEditor", "")
		return
	elseif CheckIfFeatureIsBanned(f505_arg2, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT) then
		LuaUtils.UI_ShowErrorMessageDialog(f505_arg2, GetFeatureBanInfo(f505_arg2, LuaEnum.FEATURE_BAN.USER_GENERATED_CONTENT))
		return
	else
		PaintjobSelector_ChoosePaintjob(f505_arg1, f505_arg0, f505_arg2)
		OpenOverlay(f505_arg1, "PaintjobEditor", f505_arg2, {
			_sessionMode = f505_arg1._sessionMode,
			_storageClientBuffer = f505_arg1._storageClientBuffer,
		})
	end
end
function OpenGunsmith(f506_arg0, f506_arg1, f506_arg2, f506_arg3, f506_arg4) end
function OpenCallingCards(f507_arg0, f507_arg1, f507_arg2, f507_arg3, f507_arg4)
	local f507_local0 = {}
	if f507_arg3 and f507_arg3 ~= "" then
		f507_local0.callingCardShowcaseSlot = f507_arg3
	end
	f507_local0._storageClientBuffer = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f507_arg2, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
	f507_local0._sessionMode = f507_arg4._sessionMode
	f507_arg4:openOverlay("CallingCards", f507_arg2, f507_local0)
end
function OpenGroups(f508_arg0, f508_arg1, f508_arg2, f508_arg3, f508_arg4)
	if IsGroupsEnabled(f508_arg2) then
		InitializeGroups(f508_arg0, nil, f508_arg2)
		GoBackAndOpenOverlayOnParent(f508_arg0, "Groups", f508_arg2)
		CoD.FileshareUtility.SetFileshareMode(f508_arg2, Enum[0x25E8D8427CAB01][0xE6B0DF550E4BA4D])
	end
end
function OpenChooseCharacterLoadout(f509_arg0, f509_arg1, f509_arg2, f509_arg3, f509_arg4)
	CoD.PlayerRoleUtility.customizationMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	CoD.LobbyUtility.OpenChooseCharacterLoadout(f509_arg4, f509_arg2, f509_arg3)
end
function EditClanTag(f510_arg0, f510_arg1, f510_arg2)
	ShowKeyboard(f510_arg0, f510_arg1, f510_arg2, "KEYBOARD_TYPE_CLAN_TAG")
end
function OpenPopupMenuByNameParam(f511_arg0, f511_arg1, f511_arg2, f511_arg3, f511_arg4)
	f511_arg4:openPopup(f511_arg3, f511_arg2)
end
function ResetThumbnailViewer(f512_arg0)
	Engine[0xB81A5136C5503E4](f512_arg0, "resetThumbnailViewer")
end
function PreserveThumbnails(f513_arg0, f513_arg1)
	if f513_arg1 == true then
		Engine[0xB81A5136C5503E4](f513_arg0, "preservethumbnails 1")
	else
		Engine[0xB81A5136C5503E4](f513_arg0, "preservethumbnails 0")
	end
end
function TimelineEditorRefresh()
	local f514_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "DemoSegments.refresh")
	Engine[0x83C9B5DE1D9371](f514_local0, Engine[0x614D394F6F9A18D](f514_local0) + 1)
end
function TimelineEditorPreviewClip(f515_arg0, f515_arg1, f515_arg2)
	CoD.InGameMenu.CloseAllInGameMenus(f515_arg0, {
		name = "close_all_ingame_menus",
		controller = f515_arg2,
	})
	Engine[0x7C75E608EA39B5C](f515_arg2, "demo_previewclip")
end
function TimelineEditorFilmOptions(f516_arg0, f516_arg1, f516_arg2)
	OpenPopupWithPriority(f516_arg0, "TimelineEditorFilmOptions", f516_arg2)
end
function TimelineEditorChangeTransition(f517_arg0, f517_arg1, f517_arg2)
	local f517_local0 = Engine[0x40E824FE270E174](f517_arg1:getModel(), "segmentNumber")
	if f517_local0 then
		local f517_local1 = Engine[0x614D394F6F9A18D](f517_local0) - 1
		local f517_local2 = tonumber(Engine[0x61A661773462085](f517_local1, "transitionValue")) + 1
		if f517_local2 > Enum[0x816B1501DFCC3][0x2CF5379491134FA] then
			f517_local2 = Enum[0x816B1501DFCC3][0xE6C0AB0E6047AF4]
		end
		Engine[0xB81A5136C5503E4](f517_arg2, "demo_switchtransition " .. f517_local1 .. " " .. f517_local2)
	end
end
function TimelineEditorUpdateHighlightedSegmentModel(f518_arg0, f518_arg1, f518_arg2, f518_arg3, f518_arg4)
	local f518_local0 = nil
	if CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") then
		return
	elseif f518_arg3 == "gain_focus" then
		f518_local0 = true
	else
		f518_local0 = false
	end
	local f518_local1 = f518_arg1:getModel()
	if not f518_local1 then
		return
	end
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f518_local1, "highlighted"), f518_local0)
end
function TimelineEditorKeyboardComplete(f519_arg0, f519_arg1, f519_arg2, f519_arg3)
	Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](CoD.DemoUtility.Timeline_GetHighlightedSegmentModel(), "name"), f519_arg3.input)
end
function IncreaseSafeAreaVertical(f520_arg0, f520_arg1, f520_arg2, f520_arg3, f520_arg4)
	if f520_arg3 == nil then
		f520_arg3 = 0xAAB73AB54470DF2
	end
	if not CoD.SafeArea or not CoD.SafeArea.Maximum or not CoD.SafeArea.AdjustAmount then
		return
	elseif not f520_arg4 then
		f520_arg4 = CoD.SafeArea.AdjustAmount
	end
	local f520_local0 = (tonumber(Engine[0x8C7ADE01B406F5E](f520_arg2, f520_arg3)) or 1) + f520_arg4
	if f520_local0 <= CoD.SafeArea.Maximum then
		Engine[0x280E4C1191CC53D](f520_arg2, f520_arg3, f520_local0)
	else
		Engine[0x280E4C1191CC53D](f520_arg2, f520_arg3, CoD.SafeArea.Maximum)
	end
end
function DecreaseSafeAreaVertical(f521_arg0, f521_arg1, f521_arg2, f521_arg3, f521_arg4)
	if f521_arg3 == nil then
		f521_arg3 = 0xAAB73AB54470DF2
	end
	if not CoD.SafeArea or not CoD.SafeArea.Maximum or not CoD.SafeArea.AdjustAmount then
		return
	elseif not f521_arg4 then
		f521_arg4 = CoD.SafeArea.AdjustAmount
	end
	local f521_local0 = (tonumber(Engine[0x8C7ADE01B406F5E](f521_arg2, f521_arg3)) or 1) - f521_arg4
	if f521_local0 >= CoD.SafeArea.Minimum then
		Engine[0x280E4C1191CC53D](f521_arg2, f521_arg3, f521_local0)
	else
		Engine[0x280E4C1191CC53D](f521_arg2, f521_arg3, CoD.SafeArea.Minimum)
	end
end
function IncreaseSafeAreaHorizontal(f522_arg0, f522_arg1, f522_arg2, f522_arg3, f522_arg4)
	if f522_arg3 == nil then
		f522_arg3 = 0x169739596DE678
	end
	if not CoD.SafeArea or not CoD.SafeArea.Maximum or not CoD.SafeArea.AdjustAmount then
		return
	elseif not f522_arg4 then
		f522_arg4 = CoD.SafeArea.AdjustAmount
	end
	local f522_local0 = (tonumber(Engine[0x8C7ADE01B406F5E](f522_arg2, f522_arg3)) or 1) + f522_arg4
	if f522_local0 <= CoD.SafeArea.Maximum then
		Engine[0x280E4C1191CC53D](f522_arg2, f522_arg3, f522_local0)
	else
		Engine[0x280E4C1191CC53D](f522_arg2, f522_arg3, CoD.SafeArea.Maximum)
	end
end
function DecreaseSafeAreaHorizontal(f523_arg0, f523_arg1, f523_arg2, f523_arg3, f523_arg4)
	if f523_arg3 == nil then
		f523_arg3 = 0x169739596DE678
	end
	if not CoD.SafeArea or not CoD.SafeArea.Maximum or not CoD.SafeArea.AdjustAmount then
		return
	elseif not f523_arg4 then
		f523_arg4 = CoD.SafeArea.AdjustAmount
	end
	local f523_local0 = (tonumber(Engine[0x8C7ADE01B406F5E](f523_arg2, f523_arg3)) or 1) - f523_arg4
	if CoD.isPC then
		local f523_local1, f523_local2, f523_local3 = Engine[0x6913E41040C17FD](f523_arg2)
		if f523_local1 / f523_local2 < CoD.SafeArea.MinimumWidthHeightRatioPC then
			Engine[0x280E4C1191CC53D](f523_arg2, f523_arg3, 1)
		elseif CoD.SafeArea.MinimumWidthHeightRatioPC * f523_local2 / f523_local1 < f523_local0 then
			Engine[0x280E4C1191CC53D](f523_arg2, f523_arg3, f523_local0)
		else
			Engine[0x280E4C1191CC53D](f523_arg2, f523_arg3, CoD.SafeArea.MinimumWidthHeightRatioPC * f523_local2 / f523_local1)
		end
	elseif f523_local0 >= CoD.SafeArea.Minimum then
		Engine[0x280E4C1191CC53D](f523_arg2, f523_arg3, f523_local0)
	else
		Engine[0x280E4C1191CC53D](f523_arg2, f523_arg3, CoD.SafeArea.Minimum)
	end
end
function AdjustSafeArea(f524_arg0, f524_arg1, f524_arg2, f524_arg3, f524_arg4, f524_arg5, f524_arg6, f524_arg7)
	local f524_local0 = math.abs(f524_arg4)
	if f524_arg3 then
		if f524_arg4 > 0 then
			f524_arg6(f524_arg0, f524_arg1, f524_arg2, f524_arg5, f524_local0)
		elseif f524_arg4 < 0 then
			f524_arg7(f524_arg0, f524_arg1, f524_arg2, f524_arg5, f524_local0)
		end
	elseif f524_arg4 > 0 then
		f524_arg7(f524_arg0, f524_arg1, f524_arg2, f524_arg5, f524_local0)
	elseif f524_arg4 < 0 then
		f524_arg6(f524_arg0, f524_arg1, f524_arg2, f524_arg5, f524_local0)
	end
end
function SetSafeArea(f525_arg0, f525_arg1, f525_arg2, f525_arg3, f525_arg4)
	Engine[0x280E4C1191CC53D](f525_arg2, f525_arg3, f525_arg4)
end
function ResetSafeAreaHorizontal(f526_arg0, f526_arg1, f526_arg2)
	local f526_local0, f526_local1, f526_local2 = Engine[0x6913E41040C17FD](f526_arg2)
	if f526_local0 / f526_local1 <= CoD.SafeArea.DefaultWidthHeightRatioPC then
		SetSafeArea(f526_arg0, f526_arg1, f526_arg2, 0x7664E60A992DFDA, CoD.SafeArea.Maximum)
	else
		SetSafeArea(f526_arg0, f526_arg1, f526_arg2, 0x7664E60A992DFDA, CoD.SafeArea.DefaultWidthHeightRatioPC * f526_local1 / f526_local0)
	end
	DispatchEventToRoot(f526_arg0, "update_safe_area", f526_arg2)
end
function CallingCards_SetPlayerBackground(f527_arg0, f527_arg1, f527_arg2)
	local f527_local0 = Engine[0x40E824FE270E174](f527_arg1:getModel(), "iconId")
	if f527_local0 ~= nil then
		local f527_local1 = Engine[0x614D394F6F9A18D](f527_local0)
		if f527_arg0.callingCardShowcaseSlot then
			Engine[0x24E359C3015685F](f527_arg2, CoD.InspectionUtility.GetShowcaseCategoryForCurrentSessionMode(), f527_local1, f527_arg0.callingCardShowcaseSlot)
			local f527_local2 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "CallingCardShowcaseUpdated")
			if f527_local2 then
				Engine[0x6A489878620F3BC](f527_local2)
			end
			if f527_arg0.callingCardShowcaseIsBM then
				GoBack(GoBack(f527_arg0, f527_arg2), f527_arg2)
			else
				GoBack(f527_arg0, f527_arg2)
			end
		else
			SetEmblemBackground_Internal(f527_arg2, f527_local1)
		end
		f527_arg1:playSound("list_action", f527_arg2)
	end
	ForceNotifyControllerModel(f527_arg2, "identityBadge.xuid")
end
function CallingCards_EmblemGetProfile(f528_arg0, f528_arg1, f528_arg2)
	Engine[0x74D36976C1BD7E](f528_arg2)
	ForceNotifyControllerModel(f528_arg2, "identityBadge.xuid")
end
function CallingCards_GoBack(f529_arg0, f529_arg1)
	if not IsLive() then
		Engine[0x16C9486C6451EEE](f529_arg1)
	else
		CoD.CraftUtility.UploadPublicProfile(f529_arg0, f529_arg1)
		CoD.BreadcrumbUtility.UploadBuffer(f529_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end
	CoD.BlackMarketUtility.CleanupCachedCallingCardData(f529_arg1)
	DataSources.CallingCardsBlackMarketMasterCard.invalidate(f529_arg1)
end
function OpenEnterPrestigeModeMenu(f530_arg0, f530_arg1, f530_arg2)
	if CheckIfFeatureIsBanned(f530_arg1, LuaEnum.FEATURE_BAN.PRESTIGE) then
		LuaUtils.UI_ShowErrorMessageDialog(f530_arg1, GetFeatureBanInfo(f530_arg1, LuaEnum.FEATURE_BAN.PRESTIGE))
		return
	else
		OpenSystemOverlay(f530_arg0, f530_arg2, f530_arg1, "EnterPrestigeMode", nil)
	end
end
function OpenPrestigeFreshStartMenu(f531_arg0, f531_arg1, f531_arg2)
	OpenSystemOverlay(f531_arg0, f531_arg2, f531_arg1, "PrestigeFreshStart1", nil)
end
function OpenCustomizePrestigeMenu(f532_arg0, f532_arg1, f532_arg2)
	if CheckIfFeatureIsBanned(f532_arg1, LuaEnum.FEATURE_BAN.PRESTIGE_EXTRAS) then
		LuaUtils.UI_ShowErrorMessageDialog(f532_arg1, GetFeatureBanInfo(f532_arg1, LuaEnum.FEATURE_BAN.PRESTIGE_EXTRAS))
		return
	elseif CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		OpenOverlay(f532_arg0, "Prestige_CustomizePrestigeIconZM", f532_arg1, "", "")
	else
		OpenOverlay(f532_arg0, "Prestige_CustomizePrestigeIcon", f532_arg1, "", "")
	end
end
function OpenPermanentUnlockMenu(f533_arg0, f533_arg1, f533_arg2)
	if CheckIfFeatureIsBanned(f533_arg1, LuaEnum.FEATURE_BAN.PRESTIGE_EXTRAS) then
		LuaUtils.UI_ShowErrorMessageDialog(f533_arg1, GetFeatureBanInfo(f533_arg1, LuaEnum.FEATURE_BAN.PRESTIGE_EXTRAS))
		return
	else
		CoD.PrestigeUtility.previousGameMode = CoD.gameMode
		CoD.PrestigeUtility.previousStatsMilestonePath = CoD.statsMilestonePath
		CoD.gameMode = "MP"
		CoD.statsMilestonePath = "gamedata/stats/mp/statsmilestones"
		SetHeadingKickerText(0x56F8CED179E36FD)
		CoD.PrestigeUtility.CreatePermanentUnlockTokenModel(f533_arg1)
		local f533_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f533_arg1), "PermanentlyUnlockClass")
		CoD.CACUtility.GetCustomClassModel(f533_arg1, 0, f533_local0)
		CoD.perController[f533_arg1].classModel = f533_local0
		OpenOverlay(f533_arg0, "Prestige_PermanentUnlocks", f533_arg1)
	end
end
function OpenPermanentUnlockCategoryMenu(f534_arg0, f534_arg1, f534_arg2, f534_arg3, f534_arg4)
	local f534_local0 = CoD.PrestigeUtility.GetContentCategoryData(f534_arg3)
	CoD.perController[f534_arg2].weaponCategory = f534_local0.weaponCategory
	NavigateToMenu(f534_arg0, f534_local0.menuName, true, f534_arg2)
end
function OpenPermanentWeaponUnlockCategoryMenu(f535_arg0, f535_arg1, f535_arg2, f535_arg3, f535_arg4)
	OpenPermanentUnlockCategoryMenu(f535_arg0, f535_arg1, f535_arg2, f535_arg3, f535_arg4)
end
function SetIsInPrestigeMenu(f536_arg0)
	CoD.PrestigeUtility.isInPermanentUnlockMenu = f536_arg0
end
function SetStableStatsBuffer(f537_arg0) end
function CloseCPAAR(f538_arg0, f538_arg1)
	CoD.perController[f538_arg1].lastAARMapName = Engine[0xE67E7253CC272C9]()
	CoD.perController[f538_arg1].fromMaxLevelMessage = false
end
function OpenCRMFeaturedPopup(f539_arg0, f539_arg1, f539_arg2, f539_arg3, f539_arg4)
	if f539_arg3 == "MOTDBanner" then
		local f539_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "CRMPopup")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f539_local0, "location"), "registration")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f539_local0, "actionSource"), f539_arg3)
	elseif f539_arg3 == "Featured" then
		local f539_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "CRMPopup")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f539_local0, "location"), "crm_featured")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f539_local0, "actionSource"), f539_arg3)
	end
	OpenOverlay(f539_arg4, "CRMPopup", f539_arg2)
end
function SetBubbleGumPackNameFromPackIndex(f540_arg0, f540_arg1, f540_arg2)
	return Engine[0xE03CF6CFA9CA162](f540_arg0, f540_arg1, f540_arg2)
end
function SetMap(f541_arg0, f541_arg1, f541_arg2)
	local f541_local0 = CoD.MapUtility.MapsTable[f541_arg1]
	if f541_local0 == nil then
		f541_arg1 = Engine[0xC53F8D38DF9042B](LuaUtils.GetDefaultMap(LobbyData.GetCurrentMenuTarget()))
		f541_local0 = CoD.MapUtility.MapsTable[f541_arg1]
	end
	if f541_local0[0xB514EC7141EE89B] and f541_local0[0xB514EC7141EE89B] ~= "" then
		Engine[0x7C75E608EA39B5C](f541_arg0, f541_local0[0xB514EC7141EE89B])
	end
	local f541_local1 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	if f541_local0[0xE2D141CB22F2813] and f541_local0[0xE2D141CB22F2813] ~= "" then
		Engine[0x9DB4788AE93C72D](f541_local1, f541_local0[0xE2D141CB22F2813])
	else
		Engine[0x9DB4788AE93C72D](f541_local1, f541_local0.mapToLoad)
	end
	Engine[0x280E4C1191CC53D](f541_arg0, CoD.profileKey_map, f541_local0.mapToLoad)
	local f541_local2 = Engine[0x8DF2E5447F384B9]()
	f541_local2 = f541_local2:create("lobbyRoot.selectedMapId")
	f541_local2:set(f541_arg1)
	Engine[0x16C9486C6451EEE](f541_arg0)
end
function OpenPurchaseMapPackConfirmation(f542_arg0, f542_arg1, f542_arg2)
	local f542_local0 = Engine[0x943893A16399DCF]
	local f542_local1 = f542_arg1.mapName
	if not f542_local1 then
		f542_local1 = f542_arg1.mapId or f542_arg1.id
	end
	f542_local0 = f542_local0(f542_local1)
	CoD.OverlayUtility.CreateOverlay(f542_arg0, f542_arg2, "Store", f542_arg0, {
		dlcPack = f542_local0 and CoD.DLCPackFromBit[f542_local0],
	})
end
function MapSelected(f543_arg0, f543_arg1)
	SetMap(f543_arg1, f543_arg0.mapName, false)
end
function SetInCustomGames(f544_arg0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "CustomGamesRoot"), "inCustomGames"), f544_arg0)
end
function GetCurrentGameType(f545_arg0)
	return Engine[0x69811927938FCD7]()
end
function GetCurrentUIGameType(f546_arg0)
	return Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "CustomGamesRoot"), "gameType")) or "tdm"
end
function LoadFileshareCustomGame(f547_arg0, f547_arg1, f547_arg2)
	local f547_local0 = CoD.FileshareUtility.GetSelectedItem()
	local f547_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	if f547_local1 then
		Engine[0xCEBDE8484F9B1CF](f547_arg2, f547_local1)
	end
end
function SaveCustomGame(f548_arg0, f548_arg1, f548_arg2)
	local f548_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "CustomGamesRoot")
	local f548_local1 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f548_local0, "isOfficial"))
	local f548_local2 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f548_local0, "slot"))
	local f548_local3 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f548_local0, "index"))
	local f548_local4 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f548_local0, "gameName"))
	local f548_local5 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f548_local0, "gameDescription"))
	if not f548_local4 or f548_local4 == "" then
		f548_local4 = "Custom Game"
	end
	if not f548_local5 or f548_local5 == "" then
		local f548_local6 = Engine[0xEA74FA7EE46E195](GetCurrentGameType())
		f548_local5 = Engine[0xF9F1239CFD921FE](f548_local6.descriptionRef)
	end
	if f548_local1 == nil or f548_local1 == 1 or f548_local1 == true then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f548_local0, "gameName"), "Custom Game")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f548_local0, "gameDescription"), "Game Description")
		OpenOverlay(f548_arg0, "CustomGamesSave", f548_arg2)
	else
		Engine[0x1E25C1DA54194B4](f548_arg1, Engine[0xFFDD58B353B5C0B](), f548_local2, GetCurrentGameType(), f548_local4, f548_local5)
	end
end
function DeleteCustomGame(f549_arg0, f549_arg1, f549_arg2, f549_arg3, f549_arg4)
	if Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "SelectedCustomGame"), "isOfficial")) then
		return
	else
		OpenOverlay(f549_arg4, "CustomGamesDelete", f549_arg2)
	end
end
function DeleteCustomGameYes(f550_arg0, f550_arg1, f550_arg2, f550_arg3, f550_arg4)
	local f550_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "SelectedCustomGame")
	local f550_local1 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f550_local0, "slot"))
	local f550_local2 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f550_local0, "index"))
	GoBack(f550_arg0, f550_arg2)
	Engine[0x66AE7045141A0D6](f550_arg2, f550_local1)
end
function DeleteCustomGameNo(f551_arg0, f551_arg1, f551_arg2, f551_arg3, f551_arg4)
	GoBack(f551_arg4, f551_arg2)
end
function OpenCustomGamePublishPrompt(f552_arg0, f552_arg1, f552_arg2, f552_arg3, f552_arg4)
	local f552_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "SelectedCustomGame")
	local f552_local1 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f552_local0, "isOfficial"))
	local f552_local2 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f552_local0, "gameName"))
	local f552_local3 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f552_local0, "gameDescription"))
	if f552_local1 then
		return
	elseif not f552_local2 then
		f552_local2 = "Custom Game"
	end
	if not f552_local3 then
		f552_local3 = 0x0
	end
	CoD.FileshareUtility.OpenPublishPrompt(f552_arg4, f552_arg2, "customgame", f552_local2, f552_local3, PublishCustomGame)
end
function PublishCustomGame(f553_arg0)
	local f553_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "SelectedCustomGame")
	Engine[0x14480F6C9427ED1](f553_arg0, "customgame", Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f553_local0, "slot")), Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](f553_local0, "index")), CoD.FileshareUtility.GetPublishName(), GetCurrentUIGameType(f553_arg0), CoD.FileshareUtility.GetPublishDescription())
end
function OpenPopularCustomGames(f554_arg0, f554_arg1, f554_arg2)
	CoD.FileshareUtility.SetCurrentCommunityDataType(Enum[0x8CAE469B871008F][0x2BFAFB98AF0D86F])
	CoD.FileshareUtility.SetFileshareMode(f554_arg2, Enum[0x25E8D8427CAB01][0xE4965F4E4F86DCE])
	local f554_local0 = Engine[0xA798E4552F5E872](f554_arg1:getModel(), "category")
	local f554_local1 = Engine[0xA798E4552F5E872](f554_arg1:getModel(), "communityDataType")
	Engine[0x83C9B5DE1D9371](f554_local0, "customgame")
	Engine[0x83C9B5DE1D9371](f554_local1, Enum[0x8CAE469B871008F][0x2BFAFB98AF0D86F])
	SetInCustomGames(1)
	FileshareCategorySelectorItemSelected(f554_arg0, f554_arg1, f554_arg2)
	CoD.FileshareUtility.SetShowCreateButton(false)
	CoD.FileshareUtility.SetShowFileDetails(false)
	CoD.FileshareUtility.SetShowPublishNewDetails(false)
	OpenShowcase(f554_arg0, f554_arg1, f554_arg2, nil, f554_arg0)
end
function OpenTrendingCustomGames(f555_arg0, f555_arg1, f555_arg2)
	CoD.FileshareUtility.SetCurrentCommunityDataType(Enum[0x8CAE469B871008F][0x8602C141CE170A7])
	CoD.FileshareUtility.SetFileshareMode(f555_arg2, Enum[0x25E8D8427CAB01][0xE4965F4E4F86DCE])
	local f555_local0 = Engine[0xA798E4552F5E872](f555_arg1:getModel(), "category")
	local f555_local1 = Engine[0xA798E4552F5E872](f555_arg1:getModel(), "communityDataType")
	Engine[0x83C9B5DE1D9371](f555_local0, "customgame")
	Engine[0x83C9B5DE1D9371](f555_local1, Enum[0x8CAE469B871008F][0x8602C141CE170A7])
	SetInCustomGames(1)
	FileshareCategorySelectorItemSelected(f555_arg0, f555_arg1, f555_arg2)
	CoD.FileshareUtility.SetShowCreateButton(false)
	CoD.FileshareUtility.SetShowFileDetails(false)
	CoD.FileshareUtility.SetShowPublishNewDetails(false)
	OpenShowcase(f555_arg0, f555_arg1, f555_arg2, nil, f555_arg0)
end
function OpenrRecentCustomGames(f556_arg0, f556_arg1, f556_arg2)
	CoD.FileshareUtility.SetCurrentCommunityDataType(Enum[0x8CAE469B871008F][0xF7377F1CB49D0C5])
	CoD.FileshareUtility.SetFileshareMode(f556_arg2, Enum[0x25E8D8427CAB01][0xE4965F4E4F86DCE])
	local f556_local0 = Engine[0xA798E4552F5E872](f556_arg1:getModel(), "category")
	local f556_local1 = Engine[0xA798E4552F5E872](f556_arg1:getModel(), "communityDataType")
	Engine[0x83C9B5DE1D9371](f556_local0, "customgame")
	Engine[0x83C9B5DE1D9371](f556_local1, Enum[0x8CAE469B871008F][0xF7377F1CB49D0C5])
	SetInCustomGames(1)
	FileshareCategorySelectorItemSelected(f556_arg0, f556_arg1, f556_arg2)
	CoD.FileshareUtility.SetShowCreateButton(false)
	CoD.FileshareUtility.SetShowFileDetails(false)
	CoD.FileshareUtility.SetShowPublishNewDetails(false)
	OpenShowcase(f556_arg0, f556_arg1, f556_arg2, nil, f556_arg0)
end
function SetGameType(f557_arg0, f557_arg1)
	Engine[0x7C75E608EA39B5C](f557_arg0, "resetCustomGametype")
	local f557_local0 = CoDShared.IsGametypeTeamBased()
	if f557_arg1 == "" then
		return
	end
	Engine[0x631AB43BA10119](f557_arg1)
	if f557_local0 ~= CoDShared.IsGametypeTeamBased() then
		Engine[0xB177D654FFB67BE]("bot_friends", 0)
		Engine[0xB177D654FFB67BE]("bot_enemies", 0)
	end
	if not CoD.GameTypeUtility.DoesGameTypeSupportBots(f557_arg1) then
		local f557_local1 = Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]
		local f557_local2 = Engine[0xC3DF042E7492B66](f557_local1)
		local f557_local3 = Engine[0x44FC97037CE42ED](f557_local1, f557_local2, Enum[0x575E471C039DBD6][0x7D6D125E5450799])
		if f557_local3 > 0 then
			Engine[0xA468BF674010CE8](f557_local2, f557_local3)
		end
	end
	Engine[0x7C75E608EA39B5C](f557_arg0, "xupdatepartystate")
	Engine[0x280E4C1191CC53D](f557_arg0, CoD.profileKey_gametype, f557_arg1)
	Engine[0x16C9486C6451EEE](f557_arg0)
	Engine[0x7C75E608EA39B5C](f557_arg0, "lobby_setgametype " .. f557_arg1)
	local f557_local1 = Engine[0x8DF2E5447F384B9]()
	f557_local1 = f557_local1:create("lobbyRoot.selectedGameType")
	f557_local1:set(Engine[0xC53F8D38DF9042B](f557_arg1))
	Engine[0x87AE7E64BA5AD61]("OnGametypeSettingsChange", {
		lobbyModule = Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103],
		lobbyType = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]),
		fromUI = true,
	})
end
function GameModeSelected(f558_arg0, f558_arg1)
	local f558_local0 = CoD.SafeGetModelValue(f558_arg0:getModel(), "id")
	if f558_local0 then
		local f558_local1 = Engine[0xC53F8D38DF9042B](f558_local0)
		local f558_local2 = Engine[0x8DF2E5447F384B9]()
		f558_local2 = f558_local2:create("lobbyRoot.selectedGameType")
		if f558_local1 == f558_local2:get() then
			return
		end
	end
	SetGameType(f558_arg1, f558_local0)
end
function BlockGameFromKeyEvent(f559_arg0)
	Engine[0x55C112D1D899B7D]()
end
function ShowGamerCardForScoreboardRow(f560_arg0, f560_arg1)
	local f560_local0 = CoD.SafeGetModelValue(f560_arg1:getModel(), "clientNum")
	if not Engine[0xDD333420C49E6D0](f560_arg0, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f560_arg0), "forceScoreboard") ~= 1 then
		return
	else
		Engine[0x793FB272C3B5EC2](f560_arg0, f560_local0)
	end
end
function ShowAccountPicker(f561_arg0)
	Engine[0x4DECC2B7654EAB1](f561_arg0)
end
function FinishRegistrationFlow(f562_arg0, f562_arg1, f562_arg2)
	CoD.LobbyUtility.NavigateToLobby(f562_arg0, "ModeSelect", false, f562_arg1)
	SendClientScriptMenuChangeNotify(f562_arg1, f562_arg2, false)
end
function ChatClientInputArrangeText(f563_arg0, f563_arg1, f563_arg2)
	if f563_arg0 and f563_arg0.arrangeText ~= nil then
		f563_arg0:arrangeText()
		return
	end
	local f563_local0 = f563_arg0:getParent()
	if f563_local0 and f563_local0.arrangeText ~= nil then
		f563_local0:arrangeText()
	end
end
function ResetControlsToDefault(f564_arg0, f564_arg1, f564_arg2, f564_arg3)
	Engine[0x7C75E608EA39B5C](f564_arg2, "resetprofilecommon")
	Engine[0x7C75E608EA39B5C](f564_arg2, "updategamerprofile")
	Engine[0x7C75E608EA39B5C](f564_arg2, "storagereset stats_mp_offline")
	CoD.OverlayUtility.AddSystemOverlay("ResetControlsToDefault", {
		menuName = "SystemOverlay_Compact",
		title = 0x49770A897DE23D4,
		description = 0x409E828997F3F6C,
		[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
		categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
		listDatasource = function()
			DataSources.TestPopup_List = DataSourceHelpers.ListSetup("ResetControlsToDefault_List", function(f566_arg0)
				return {
					{
						models = {
							displayText = "Yes",
						},
						properties = {
							action = function(f567_arg0, f567_arg1, f567_arg2, f567_arg3, f567_arg4)
								GoBack(f567_arg2)
							end,
						},
					},
				}
			end, true, nil)
			return "ResetControlsToDefault_List"
		end,
	})
	CoD.OverlayUtility.CreateOverlay(f564_arg2, f564_arg3, "ResetControlsToDefault")
end
function ChangeLanguage(f568_arg0, f568_arg1, f568_arg2, f568_arg3, f568_arg4, f568_arg5)
	if f568_arg3 == Engine[0x8E9485024EFDB9]() or f568_arg3 == nil then
		return
	else
		local f568_local0 = f568_arg0
		CoD.OverlayUtility.AddAutoDetectOverlay("Restart_Popup", {
			title = 0xA009F37E1567367,
			description = 0x5A171736553C17D,
			categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
			options = function()
				return {
					{
						action = function(f570_arg0, f570_arg1)
							GoBack(f570_arg0, f570_arg1)
							f568_arg1.gridInfoTable.parentGrid:updateDataSource()
							f568_local0.changingLanguage = nil
						end,
						text = 0xC2E92C54C2BE289,
						isCancelOption = true,
					},
					{
						action = function(f571_arg0, f571_arg1)
							local f571_local0 = f568_local0:getModel(f571_arg1, "optionAssetName")
							if f571_local0 then
								CoD.OptionsUtility.NotifyPlayerSettingsUpdate(f571_arg1, f571_local0:get())
								Engine[0xEA23CAA4B132C55](f568_arg3)
								Engine[0xD9F617D3018B64A]()
							end
						end,
						text = 0x5BE4A02B20F31F1,
					},
				}
			end,
		})
		CoD.OverlayUtility.CreateOverlay(f568_arg2, f568_arg5, "Restart_Popup")
		return true
	end
end
function SetFirstTimeDurangoDownloadSettingDisplayed(f572_arg0)
	CoD.LobbyUtility.DisplayedFirstTimeDurangoDownloadSetting = true
end
function CombatRecordShowHero(f573_arg0, f573_arg1)
	local f573_local0 = 0
	local f573_local1 = f573_arg1:getModel(f573_arg0, "heroIndex")
	if f573_local1 then
		f573_local0 = Engine[0x614D394F6F9A18D](f573_local1)
	end
	Engine[0x6ABA4D7F0840A1E](f573_arg0, CoD.PlayerRoleUtility.Heroes.heroUpdateEvent .. CoD.GetLocalClientAdjustedNum(f573_arg0), {
		event_name = "changeHero",
		character_index = f573_local0,
		mode = CoD.GetCombatRecordMode(),
	})
end
function CombatRecordTabChanged(f574_arg0, f574_arg1, f574_arg2)
	if not CoD.CombatRecordPreventModeChange then
		CoD.CombatRecordMode = f574_arg1.tabId
	end
end
function CombatRecordSetHeadingKickerTextToCombatRecordGameMode()
	local f575_local0 = SessionModeToLocalizedSessionMode(CoD.GetCombatRecordMode())
	local f575_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.headingKickerText")
	if f575_local1 then
		Engine[0x83C9B5DE1D9371](f575_local1, f575_local0)
	end
end
function CombatRecordSetHeadingKickerTextToCombatRecordMode()
	if CoD.GetCombatRecordMode() ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		CombatRecordSetHeadingKickerTextToCombatRecordGameMode()
		return
	end
	local f576_local0 = Engine[0xF9F1239CFD921FE](0x7BAA05710CE37D3)
	if CoD.CombatRecordMode == "public" then
		f576_local0 = Engine[0xF9F1239CFD921FE](0x8159ECA1876AE99)
	elseif CoD.CombatRecordMode == "arena" then
		f576_local0 = Engine[0xF9F1239CFD921FE](0x4B08B09636ECD9E)
	end
	local f576_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.headingKickerText")
	if f576_local1 then
		Engine[0x83C9B5DE1D9371](f576_local1, f576_local0)
	end
end
function CombatRecordSetXUIDForLocalController(f577_arg0)
	CoD.CombatRecordXUID = Engine[0x93B19E01B1FD1C7](f577_arg0)
	CoD.CombatRecordOtherPlayerStats = false
end
function CombatRecordSetXUIDFromSelectedFriend(f578_arg0)
	local f578_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f578_arg0), "Social.selectedFriendXUID")
	if f578_local0 then
		CoD.CombatRecordXUID = Engine[0x614D394F6F9A18D](f578_local0)
		CoD.CombatRecordMode = "public"
	end
end
function CombatRecordOpenFromPlayerDetails(f579_arg0, f579_arg1, f579_arg2, f579_arg3, f579_arg4)
	CombatRecordSetMenuForPostStatsLoad(f579_arg0, "ViewRemoteCombatRecord")
	CombatRecordSetXUIDFromSelectedFriend(f579_arg2)
	OpenPopup(f579_arg0, "Social_InspectPlayerPopupLoading", f579_arg2)
	CombatRecordReadOtherPlayerStats(f579_arg2)
end
function CombatRecordSetMenuForPostStatsLoad(f580_arg0, f580_arg1)
	CoD.CombatRecordPostStatsLoadMenuName = f580_arg1
end
function CombatRecordReadOtherPlayerStats(f581_arg0)
	CoD.CombatRecordOtherPlayerStats = true
	Engine[0x2D6D878BE391F63](f581_arg0, CoD.CombatRecordXUID, CoD.GetCombatRecordMode())
end
function CombatRecordCompareAgainstLocalPlayer(f582_arg0)
	local f582_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "OtherPlayerStats")
	if f582_local0 then
		local f582_local1 = Engine[0x54689B3A7B3899E](f582_arg0)
		if f582_local1 then
			local f582_local2 = Engine[0xA798E4552F5E872](f582_local0, "gamertag")
			if f582_local2 then
				Engine[0x83C9B5DE1D9371](f582_local2, f582_local1)
			end
		end
		local f582_local2 = Engine[0x93B19E01B1FD1C7](f582_arg0)
		if f582_local2 then
			local f582_local3 = Engine[0xA798E4552F5E872](f582_local0, "xuid")
			if f582_local3 then
				Engine[0x83C9B5DE1D9371](f582_local3, f582_local2)
			end
		end
	end
end
function CombatRecordSelectFriend(f583_arg0, f583_arg1, f583_arg2)
	local f583_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "OtherPlayerStats")
	local f583_local1 = nil
	if f583_local0 then
		local f583_local2 = f583_arg1:getModel(f583_arg2, "identityBadge.gamertag")
		if f583_local2 then
			f583_local1 = Engine[0x614D394F6F9A18D](f583_local2)
		end
	end
	if f583_local1 then
		local f583_local2 = Engine[0xA798E4552F5E872](f583_local0, "gamertag")
		if f583_local2 then
			Engine[0x83C9B5DE1D9371](f583_local2, f583_local1)
		end
	end
	local f583_local2 = nil
	local f583_local3 = f583_arg1:getModel(f583_arg2, "identityBadge.xuid")
	if f583_local3 then
		f583_local2 = Engine[0x614D394F6F9A18D](f583_local3)
	end
	if f583_local2 then
		if f583_local0 then
			local f583_local4 = Engine[0xA798E4552F5E872](f583_local0, "XUID")
			if f583_local4 then
				Engine[0x83C9B5DE1D9371](f583_local4, f583_local2)
			end
		end
		Engine[0x2D6D878BE391F63](f583_arg2, f583_local2, CoD.GetCombatRecordMode())
	end
end
function CombatRecordSetComparing(f584_arg0, f584_arg1, f584_arg2)
	local f584_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f584_arg1), "CombatRecordComparing")
	if f584_local0 then
		Engine[0x83C9B5DE1D9371](f584_local0, f584_arg2)
	end
end
function CombatRecordUpdateSelfIdentityWidget(f585_arg0, f585_arg1)
	if CoD.CombatRecordOtherPlayerStats == true then
		local f585_local0 = f585_arg0.MenuFrame
		local f585_local1 = Engine[0x4DF5CFBC1771947](f585_arg1)
		local f585_local2 = Engine[0x40E824FE270E174](f585_local1, "socialPlayerInfo")
		local f585_local3 = Engine[0x40E824FE270E174](f585_local1, "socialPlayerInfo.identityBadge")
		if f585_local0 and f585_local2 and f585_local3 then
			if f585_local0.SelfIdentityBadge then
				f585_local0.SelfIdentityBadge:setModel(f585_local3, f585_arg1)
			end
			if f585_local0.SelfIdentityBadge.CallingCard.CallingCardsFrameWidget then
				f585_local0.SelfIdentityBadge.CallingCard.CallingCardsFrameWidget:setModel(f585_local2, f585_arg1)
			end
		end
	end
end
function StartLiveEvent(f586_arg0, f586_arg1)
	Engine[0x7C75E608EA39B5C](f586_arg0, "setliveevent " .. (Engine[0x2DCF0973239E909]("gamedata/tables/common/live_event_streamers.csv", 1, 0, f586_arg1 or 0) or ""))
end
function CollapseFreeCursorElementParent(f587_arg0)
	local f587_local0 = f587_arg0:getParent()
	if f587_local0 then
		f587_local0:setHeight(0)
	end
end
function CollapseFreeCursorElement(f588_arg0)
	if not f588_arg0._originalHeight then
		local f588_local0, f588_local1 = f588_arg0:getLocalSize()
		f588_arg0._originalHeight = f588_local1
	end
	f588_arg0:setHeight(0)
end
function ExpandFreeCursorElement(f589_arg0)
	if f589_arg0._originalHeight then
		f589_arg0:setHeight(f589_arg0._originalHeight)
	end
end
function DisableRestoreState(f590_arg0)
	f590_arg0.restoreState = AlwaysTrue
end
function DisableDefaultGainFocus(f591_arg0, f591_arg1)
	f591_arg0.__defaultFocus = nil
end
function MenuHidesFreeCursor(f592_arg0, f592_arg1)
	if Engine[0x8069F5969D47DEF]() then
		if f592_arg0._delayedUnlockAndUnhideTimer ~= nil then
			f592_arg0._delayedUnlockAndUnhideTimer:close()
			f592_arg0._delayedUnlockAndUnhideTimer = nil
			LockInput(f592_arg0, f592_arg1, false)
		end
		if not f592_arg0.hasHidingFreeCursorClose then
			f592_arg0.hasHidingFreeCursorClose = true
			LUI.OverrideFunction_CallOriginalFirst(f592_arg0, "close", function()
				MenuUnhideFreeCursor(f592_arg0, f592_arg1)
			end)
		end
		if not f592_arg0.hidFreeCursor then
			local f592_local0 = DataSources.FreeCursor.getModel(f592_arg1)
			f592_local0 = f592_local0.hidden
			local f592_local1 = DataSources.FreeCursor.getModel(f592_arg1)
			f592_local1 = f592_local1.ignoreNextMenuHides
			f592_arg0.hidFreeCursor = true
			if f592_local1 and f592_local1:get() then
				f592_local1:set(false)
			else
				f592_local0:set(f592_local0:get() + 1)
			end
		end
	end
end
function MenuUnhideFreeCursor(f594_arg0, f594_arg1)
	if Engine[0x8069F5969D47DEF]() then
		local f594_local0 = DataSources.FreeCursor.getModel(f594_arg1)
		f594_local0 = f594_local0.hidden
		if f594_arg0.hidFreeCursor then
			f594_local0:set(f594_local0:get() - 1)
			f594_arg0.hidFreeCursor = false
			if f594_local0:get() <= 0 then
				CoD.FreeCursorUtility.RetriggerCursorPosition(f594_arg0, f594_arg1)
			end
		end
		if f594_arg0._delayedUnlockAndUnhideTimer ~= nil then
			f594_arg0._delayedUnlockAndUnhideTimer:close()
			f594_arg0._delayedUnlockAndUnhideTimer = nil
			LockInput(f594_arg0, f594_arg1, false)
		end
	end
end
function DisableGainActiveAndLoseActive(f595_arg0)
	f595_arg0:registerEventHandler("gain_active", function(element, event)
		return true
	end)
	f595_arg0:registerEventHandler("lose_active", function(element, event)
		return true
	end)
end
function SetCurrentElementAsActive(f598_arg0, f598_arg1, f598_arg2)
	if f598_arg1.gridInfoTable and f598_arg1.gridInfoTable.parentGrid then
		LUI.GridLayout.setActiveItem(f598_arg1.gridInfoTable.parentGrid, f598_arg1, nil)
	end
end
function ChangeHorizontalCount(f599_arg0, f599_arg1)
	f599_arg0:setHorizontalCount(f599_arg1)
end
function ClearResetPropertiesFunc(f600_arg0, f600_arg1)
	f600_arg0.__resetProperties = function() end
end
function ResetServerTimer(f602_arg0, f602_arg1, f602_arg2)
	if f602_arg2 ~= nil then
		local f602_local0 = Engine[0x614D394F6F9A18D](f602_arg2)
		if f602_local0 ~= nil then
			f602_arg1:setupServerTime(f602_local0)
		end
	end
end
function ReverseChildrenOrder(f603_arg0)
	local f603_local0 = f603_arg0:getFirstChild()
	if f603_local0 == nil then
		return
	end
	local f603_local1 = nil
	if f603_arg0.__ignoreFirstElement then
		f603_local1 = f603_local0
		f603_local0 = f603_local0:getNextSibling()
		f603_arg0:removeElement(f603_local1)
	end
	local f603_local2 = {}
	local f603_local3 = 0
	while f603_local0 ~= nil do
		f603_local2[f603_local3] = f603_local0
		f603_local3 = f603_local3 + 1
		local f603_local4 = f603_local0:getNextSibling()
		f603_arg0:removeElement(f603_local0)
		f603_local0 = f603_local4
	end
	if f603_local1 then
		f603_arg0:addElement(f603_local1)
	end
	if f603_local3 > 0 then
		for f603_local4 = f603_local3 - 1, 0, -1 do
			f603_arg0:addElement(f603_local2[f603_local4])
		end
	end
end
function ActivateTextStencilCulling(f604_arg0)
	f604_arg0:setTextStencilCull(true)
end
function DisableModelStringReplacement(f605_arg0)
	f605_arg0:disableModelStringReplacement()
end
function SetFocusedTierModelValue(f606_arg0, f606_arg1, f606_arg2)
	local f606_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f606_arg0), "FocusedTier")
	local f606_local1 = tonumber(f606_arg1)
	local f606_local2 = 5
	local f606_local3 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f606_arg0), "MaxTier")
	local f606_local4
	if f606_local3 then
		f606_local4 = f606_local3:get()
		if not f606_local4 then
		else
			if f606_local4 == CoD.BlackMarketUtility.SupplyChainMaxTiers then
				f606_local4 = math.max(CoD.BlackMarketUtility.GetCurrentSeasonTier(f606_arg0) + CoD.BlackMarketUtility.SupplyChainPeekTiers, CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers())
			end
			if f606_local0 ~= nil then
				local f606_local5 = Engine[0x614D394F6F9A18D](f606_local0)
				if f606_local1 == 1 then
					CoD.perController[f606_arg0].ignoreResetFocusToFirstSelectable = true
				end
				if (CoD.BlackMarketUtility.FillBackfill() or CoD.BlackMarketUtility.FillContrabandDropNumber() > 0) and f606_local5 ~= nil then
					f606_local4 = f606_local5 + 10 * f606_local1
				end
				if f606_arg2 == "increment" and f606_local5 ~= nil then
					if f606_local5 + f606_local2 + f606_local1 - 1 < f606_local4 then
						Engine[0x83C9B5DE1D9371](f606_local0, f606_local5 + f606_local1)
					else
						Engine[0x83C9B5DE1D9371](f606_local0, math.max(f606_local4 + 1 - f606_local2, 1))
					end
				elseif f606_arg2 == "decrement" and f606_local5 ~= nil then
					if f606_local1 < f606_local5 then
						Engine[0x83C9B5DE1D9371](f606_local0, f606_local5 - f606_local1)
					else
						Engine[0x83C9B5DE1D9371](f606_local0, 1)
					end
				elseif f606_arg2 == "set" and f606_local5 ~= nil then
					Engine[0x83C9B5DE1D9371](f606_local0, f606_local1)
				else
					local f606_local6 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f606_arg0)
					if f606_local6 < 1 then
						f606_local6 = 1
					end
					Engine[0x83C9B5DE1D9371](f606_local0, f606_local6)
				end
			end
		end
	end
	f606_local4 = CoD.BlackMarketUtility.SupplyChainMaxTiers
end
function HighlightCodPointPackage(f607_arg0, f607_arg1, f607_arg2)
	local f607_local0 = CoD.SafeGetModelValue(f607_arg1:getModel(), "price")
	if f607_local0 then
		local f607_local1 = f607_local0 - Engine[0xF40679B550DCCA2](f607_arg0, CoD.Currencies.COD_POINTS)
		for f607_local2 = 1, f607_arg2.requestedRowCount, 1 do
			for f607_local5 = 1, f607_arg2.requestedColumnCount, 1 do
				local f607_local8 = f607_arg2:getModelForPosition(f607_local2, f607_local5)
				if f607_local8 then
					local f607_local9 = f607_local8.name
					if f607_local9 then
						local f607_local10 = f607_local9:get()
						local f607_local11 = tonumber(string.gsub(Engine[0xF9F1239CFD921FE](f607_local10), "[^0-9\\.]", ""))
						if f607_local11 and f607_local1 <= f607_local11 then
							f607_arg2:findItem({
								name = f607_local10,
							}, nil, true, 0)
							return
						end
					end
				end
			end
		end
	end
end
function UpdateStateOnListUpdate(f608_arg0, f608_arg1, f608_arg2)
	LUI.OverrideFunction_CallOriginalFirst(f608_arg2, "updateDataSource", function(element)
		UpdateSelfState(f608_arg1, f608_arg0)
	end)
end
function UpdateParentElementDataSource(f610_arg0, f610_arg1)
	UpdateElementDataSource(f610_arg0:getParent(), f610_arg1)
end
