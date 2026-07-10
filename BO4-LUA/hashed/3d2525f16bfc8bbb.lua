require("x64:26290111109cc42")
require("x64:21f553dc351a375")
require("x64:d40b3cbaff75c1b")
require("x64:9b6351e62cb72af")
require("x64:a3cd2c05bf5a4e0")
require("x64:c74b18409878e59")
require("x64:e1a4e89cbfd7d12")
CoD.SpecialistHeadquarters = InheritFrom(LUI.UIElement)
CoD.SpecialistHeadquarters.__defaultWidth = 1920
CoD.SpecialistHeadquarters.__defaultHeight = 1080
CoD.SpecialistHeadquarters.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("lobbyRoot.lobbyList.playerCount")
	CoD.BaseUtility.CreateGlobalModel("MapVote.timerActive")
	self:setClass(CoD.SpecialistHeadquarters)
	self.id = "SpecialistHeadquarters"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MainInfoText = LUI.UIText.new(0.5, 0.5, 448, 860, 0.5, 0.5, -45, -21)
	MainInfoText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MainInfoText:setTTF("ttmussels_regular")
	MainInfoText:setLineSpacing(1)
	MainInfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MainInfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	MainInfoText:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "MainInfoText", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MainInfoText:setText(f2_local0)
		end
	end)
	self:addElement(MainInfoText)
	self.MainInfoText = MainInfoText
	local DossierButton = CoD.DirectorSelectButtonSpecialistHeadquarters.new(f1_arg0, f1_arg1, 0.5, 0.5, -860, -464, 0.5, 0.5, -289, -149)
	DossierButton.Header:setText(LocalizeToUpperString(@"menu/dossier"))
	DossierButton:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "ChosenSpecialistID", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DossierButton.Image:setImage(RegisterImage(CoD.CTUtility.PlayerRoleIndexToBioHeaderImage(f3_local0)))
		end
	end)
	DossierButton:appendEventHandler("on_session_start", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	DossierButton:appendEventHandler("on_session_end", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local LowerSideInfoText = DossierButton
	local ArchivesButton = DossierButton.subscribeToModel
	local UpperSideInfoText = Engine[@"getglobalmodel"]()
	ArchivesButton(LowerSideInfoText, UpperSideInfoText["lobbyRoot.lobbyNav"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LowerSideInfoText = DossierButton
	ArchivesButton = DossierButton.subscribeToModel
	UpperSideInfoText = Engine[@"getglobalmodel"]()
	ArchivesButton(LowerSideInfoText, UpperSideInfoText["lobbyRoot.gameClient.update"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	LowerSideInfoText = DossierButton
	ArchivesButton = DossierButton.subscribeToModel
	UpperSideInfoText = Engine[@"getglobalmodel"]()
	ArchivesButton(LowerSideInfoText, UpperSideInfoText["lobbyRoot.privateClient.update"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	DossierButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DossierButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ENTER", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() then
			CoD.CTUtility.UpdateSpecialistDossier(controller)
			OpenOverlay(self, "SpecialistDossier", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, "ENTER")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(DossierButton, "childFocusGained", function(element)
		CoD.CTUtility.SetDossierButtonInfoText(f1_arg1)
		PlayClip(self, "ShowUpperDesc", f1_arg1)
	end)
	self:addElement(DossierButton)
	self.DossierButton = DossierButton
	ArchivesButton = CoD.DirectorSelectButtonSpecialistHeadquarters.new(f1_arg0, f1_arg1, 0.5, 0.5, -860, -464, 0.5, 0.5, -21, 184)
	ArchivesButton.Image:setImage(RegisterImage(@"ui_icon_specialist_story"))
	ArchivesButton.Header:setText(LocalizeToUpperString(@"menu/archives"))
	ArchivesButton:appendEventHandler("on_session_start", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f13_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	ArchivesButton:appendEventHandler("on_session_end", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	UpperSideInfoText = ArchivesButton
	LowerSideInfoText = ArchivesButton.subscribeToModel
	local SpecialistName = Engine[@"getglobalmodel"]()
	LowerSideInfoText(UpperSideInfoText, SpecialistName["lobbyRoot.lobbyNav"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	UpperSideInfoText = ArchivesButton
	LowerSideInfoText = ArchivesButton.subscribeToModel
	SpecialistName = Engine[@"getglobalmodel"]()
	LowerSideInfoText(UpperSideInfoText, SpecialistName["lobbyRoot.gameClient.update"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	UpperSideInfoText = ArchivesButton
	LowerSideInfoText = ArchivesButton.subscribeToModel
	SpecialistName = Engine[@"getglobalmodel"]()
	LowerSideInfoText(UpperSideInfoText, SpecialistName["lobbyRoot.privateClient.update"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ArchivesButton:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f18_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ArchivesButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ENTER", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() then
			OpenOverlay(self, "SpecialistHeadquartersArchives", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, "ENTER")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(ArchivesButton, "childFocusGained", function(element)
		CoD.CTUtility.SetArchivesButtonInfoText(f1_arg1)
		PlayClip(self, "ShowLowerDesc", f1_arg1)
	end)
	self:addElement(ArchivesButton)
	self.ArchivesButton = ArchivesButton
	LowerSideInfoText = LUI.UIText.new(0.5, 0.5, -860, -464, 0.5, 0.5, 199, 223)
	LowerSideInfoText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LowerSideInfoText:setAlpha(0)
	LowerSideInfoText:setTTF("ttmussels_regular")
	LowerSideInfoText:setLineSpacing(1)
	LowerSideInfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LowerSideInfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LowerSideInfoText:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "SideInfoText", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			LowerSideInfoText:setText(f22_local0)
		end
	end)
	self:addElement(LowerSideInfoText)
	self.LowerSideInfoText = LowerSideInfoText
	UpperSideInfoText = LUI.UIText.new(0.5, 0.5, -860, -464, 0.5, 0.5, -134.5, -110.5)
	UpperSideInfoText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	UpperSideInfoText:setAlpha(0)
	UpperSideInfoText:setTTF("ttmussels_regular")
	UpperSideInfoText:setLineSpacing(1)
	UpperSideInfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	UpperSideInfoText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	UpperSideInfoText:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "SideInfoText", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			UpperSideInfoText:setText(f23_local0)
		end
	end)
	self:addElement(UpperSideInfoText)
	self.UpperSideInfoText = UpperSideInfoText
	SpecialistName = LUI.UIText.new(0.5, 0.5, -191, 191, 1, 1, -277, -187)
	SpecialistName:setRGB(0.92, 0.89, 0.72)
	SpecialistName:setAlpha(0.7)
	SpecialistName:setZoom(3)
	SpecialistName:setTTF("ttmussels_regular")
	SpecialistName:setLetterSpacing(10)
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SpecialistName:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "ChosenSpecialistID", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			SpecialistName:setText(LocalizeToUpperString(CoD.CTUtility.PlayerRoleIndexToName(f24_local0)))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local JobTitle = LUI.UIText.new(0.5, 0.5, -171, 171, 1, 1, -297, -277)
	JobTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	JobTitle:setZoom(3)
	JobTitle:setTTF("ttmussels_regular")
	JobTitle:setLetterSpacing(10)
	JobTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	JobTitle:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "ChosenSpecialistID", function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			JobTitle:setText(LocalizeToUpperString(CoD.CTUtility.PlayerRoleIndexToJobTitle(f25_local0)))
		end
	end)
	self:addElement(JobTitle)
	self.JobTitle = JobTitle
	local PlayButton = CoD.SpecialistHeadquartersButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 448, 860, 0.5, 0.5, -289, -159)
	PlayButton:mergeStateConditions({
		{
			stateName = "MatchStart",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0)
			end,
		},
	})
	local RightProgress = PlayButton
	local Specialists = PlayButton.subscribeToModel
	local MiddleProgress = Engine[@"getglobalmodel"]()
	Specialists(RightProgress, MiddleProgress["lobbyRoot.lobbyTimeRemaining"], function(f27_arg0)
		f1_arg0:updateElementState(PlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "lobbyRoot.lobbyTimeRemaining",
		})
	end, false)
	PlayButton:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "ChosenSpecialistID", function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			PlayButton.Header:setText(LocalizeToUpperString(CoD.CTUtility.GetChosenSpecialistIDLocString(f1_arg1, f28_local0)))
		end
	end)
	PlayButton:appendEventHandler("on_session_start", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	PlayButton:appendEventHandler("on_session_end", function(f30_arg0, f30_arg1)
		f30_arg1.menu = f30_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f30_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	RightProgress = PlayButton
	Specialists = PlayButton.subscribeToModel
	MiddleProgress = Engine[@"getglobalmodel"]()
	Specialists(RightProgress, MiddleProgress["lobbyRoot.lobbyNav"], function(f31_arg0, f31_arg1)
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	RightProgress = PlayButton
	Specialists = PlayButton.subscribeToModel
	MiddleProgress = Engine[@"getglobalmodel"]()
	Specialists(RightProgress, MiddleProgress["lobbyRoot.gameClient.update"], function(f32_arg0, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	RightProgress = PlayButton
	Specialists = PlayButton.subscribeToModel
	MiddleProgress = Engine[@"getglobalmodel"]()
	Specialists(RightProgress, MiddleProgress["lobbyRoot.privateClient.update"], function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	RightProgress = PlayButton
	Specialists = PlayButton.subscribeToModel
	MiddleProgress = Engine[@"getglobalmodel"]()
	Specialists(RightProgress, MiddleProgress["lobbyRoot.lobbyList.playerCount"], function(f34_arg0, f34_arg1)
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	RightProgress = PlayButton
	Specialists = PlayButton.subscribeToModel
	MiddleProgress = Engine[@"getglobalmodel"]()
	Specialists(RightProgress, MiddleProgress["MapVote.timerActive"], function(f35_arg0, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PlayButton:registerEventHandler("gain_focus", function(element, event)
		local f36_local0 = nil
		if element.gainFocus then
			f36_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f36_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f36_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PlayButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.lobbyList.playerCount", 1) and not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.CTUtility.RefreshChosenSpecialistParams(controller)
			CoD.CTUtility.LaunchGame(menu, self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.lobbyList.playerCount", 1) and not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(PlayButton, "childFocusGained", function(element)
		CoD.CTUtility.SetPlayButtonInfoText(f1_arg1)
	end)
	self:addElement(PlayButton)
	self.PlayButton = PlayButton
	Specialists = CoD.SpecialistHeadquartersButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 448, 860, 0.5, 0.5, -126.5, -59.5)
	Specialists.Header:setText(LocalizeToUpperString(@"hash_6FF94A9EB646C873"))
	Specialists:appendEventHandler("on_session_start", function(f40_arg0, f40_arg1)
		f40_arg1.menu = f40_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f40_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	Specialists:appendEventHandler("on_session_end", function(f41_arg0, f41_arg1)
		f41_arg1.menu = f41_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f41_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	MiddleProgress = Specialists
	RightProgress = Specialists.subscribeToModel
	local LeftProgress = Engine[@"getglobalmodel"]()
	RightProgress(MiddleProgress, LeftProgress["lobbyRoot.lobbyNav"], function(f42_arg0, f42_arg1)
		CoD.Menu.UpdateButtonShownState(f42_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	MiddleProgress = Specialists
	RightProgress = Specialists.subscribeToModel
	LeftProgress = Engine[@"getglobalmodel"]()
	RightProgress(MiddleProgress, LeftProgress["lobbyRoot.gameClient.update"], function(f43_arg0, f43_arg1)
		CoD.Menu.UpdateButtonShownState(f43_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	MiddleProgress = Specialists
	RightProgress = Specialists.subscribeToModel
	LeftProgress = Engine[@"getglobalmodel"]()
	RightProgress(MiddleProgress, LeftProgress["lobbyRoot.privateClient.update"], function(f44_arg0, f44_arg1)
		CoD.Menu.UpdateButtonShownState(f44_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	MiddleProgress = Specialists
	RightProgress = Specialists.subscribeToModel
	LeftProgress = Engine[@"getglobalmodel"]()
	RightProgress(MiddleProgress, LeftProgress["MapVote.timerActive"], function(f45_arg0, f45_arg1)
		CoD.Menu.UpdateButtonShownState(f45_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	Specialists:registerEventHandler("gain_focus", function(element, event)
		local f46_local0 = nil
		if element.gainFocus then
			f46_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f46_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f46_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Specialists, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and not CoD.LobbyUtility.MapVoteTimerActive() then
			SetControllerModelValue(controller, "SpecialistHeadquarters.ShowPlayButtonInSpecialistSelect", true)
			OpenOverlay(self, "SpecialistHeadquartersSelectSpecialist", controller)
			PlaySoundAlias("uin_paint_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and not CoD.LobbyUtility.MapVoteTimerActive() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_3AC3B80C833B60E1", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(Specialists, "childFocusGained", function(element)
		CoD.CTUtility.SetSpecialistsButtonInfoText(f1_arg1)
	end)
	self:addElement(Specialists)
	self.Specialists = Specialists
	RightProgress = CoD.SpecialistInfoCTProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, 112.5, 187.5, 1, 1, -187, -87)
	RightProgress:mergeStateConditions({
		{
			stateName = "NotShown",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShouldShowStars")
			end,
		},
	})
	LeftProgress = RightProgress
	MiddleProgress = RightProgress.subscribeToModel
	local PartyList = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	MiddleProgress(LeftProgress, PartyList.ShouldShowStars, function(f51_arg0)
		f1_arg0:updateElementState(RightProgress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "ShouldShowStars",
		})
	end, false)
	RightProgress:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "veteranStars", function(model)
		RightProgress:setModel(model, f1_arg1)
	end)
	self:addElement(RightProgress)
	self.RightProgress = RightProgress
	MiddleProgress = CoD.SpecialistInfoCTProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -37.5, 37.5, 1, 1, -187, -87)
	MiddleProgress:mergeStateConditions({
		{
			stateName = "NotShown",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShouldShowStars")
			end,
		},
	})
	PartyList = MiddleProgress
	LeftProgress = MiddleProgress.subscribeToModel
	local f1_local14 = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	LeftProgress(PartyList, f1_local14.ShouldShowStars, function(f54_arg0)
		f1_arg0:updateElementState(MiddleProgress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "ShouldShowStars",
		})
	end, false)
	MiddleProgress:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "regularStars", function(model)
		MiddleProgress:setModel(model, f1_arg1)
	end)
	self:addElement(MiddleProgress)
	self.MiddleProgress = MiddleProgress
	LeftProgress = CoD.SpecialistInfoCTProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -187.5, -112.5, 1, 1, -187, -87)
	LeftProgress:mergeStateConditions({
		{
			stateName = "NotShown",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "ShouldShowStars")
			end,
		},
	})
	f1_local14 = LeftProgress
	PartyList = LeftProgress.subscribeToModel
	local f1_local15 = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	PartyList(f1_local14, f1_local15.ShouldShowStars, function(f57_arg0)
		f1_arg0:updateElementState(LeftProgress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f57_arg0:get(),
			modelName = "ShouldShowStars",
		})
	end, false)
	LeftProgress:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "recruitStars", function(model)
		LeftProgress:setModel(model, f1_arg1)
	end)
	self:addElement(LeftProgress)
	self.LeftProgress = LeftProgress
	PartyList = CoD.PC_PartyListContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 726, 794, 0.5, 0.5, -440, -372)
	self:addElement(PartyList)
	self.PartyList = PartyList
	DossierButton.id = "DossierButton"
	ArchivesButton.id = "ArchivesButton"
	PlayButton.id = "PlayButton"
	Specialists.id = "Specialists"
	PartyList.id = "PartyList"
	self.__defaultFocus = PlayButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistHeadquarters.__resetProperties = function(f59_arg0)
	f59_arg0.UpperSideInfoText:completeAnimation()
	f59_arg0.LowerSideInfoText:completeAnimation()
	f59_arg0.UpperSideInfoText:setAlpha(0)
	f59_arg0.LowerSideInfoText:setAlpha(0)
end
CoD.SpecialistHeadquarters.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(0)
		end,
		ShowUpperDesc = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(2)
			f61_arg0.LowerSideInfoText:completeAnimation()
			f61_arg0.LowerSideInfoText:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.LowerSideInfoText)
			f61_arg0.UpperSideInfoText:completeAnimation()
			f61_arg0.UpperSideInfoText:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.UpperSideInfoText)
		end,
		ShowLowerDesc = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(2)
			f62_arg0.LowerSideInfoText:completeAnimation()
			f62_arg0.LowerSideInfoText:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.LowerSideInfoText)
			f62_arg0.UpperSideInfoText:completeAnimation()
			f62_arg0.UpperSideInfoText:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.UpperSideInfoText)
		end,
	},
}
CoD.SpecialistHeadquarters.__onClose = function(f63_arg0)
	f63_arg0.MainInfoText:close()
	f63_arg0.DossierButton:close()
	f63_arg0.ArchivesButton:close()
	f63_arg0.LowerSideInfoText:close()
	f63_arg0.UpperSideInfoText:close()
	f63_arg0.SpecialistName:close()
	f63_arg0.JobTitle:close()
	f63_arg0.PlayButton:close()
	f63_arg0.Specialists:close()
	f63_arg0.RightProgress:close()
	f63_arg0.MiddleProgress:close()
	f63_arg0.LeftProgress:close()
	f63_arg0.PartyList:close()
end
