require("ui/uieditor/widgets/hud/movieplayback/moviesubtitles")
require("ui/uieditor/widgets/loadinganimation/loadingscreenskipprompt")
require("ui/uieditor/widgets/notifications/xp/doublexpiconsleftaligned")
require("ui/uieditor/widgets/startgameflow/loadingscreenheader")
require("ui/uieditor/widgets/startgameflow/loadingscreenloadbar")
require("ui/uieditor/widgets/startgameflow/loadingscreentalkerwidgetcpzm")
require("ui/uieditor/widgets/startgameflow/tipwidgetlist")
require("ui/uieditor/widgets/pc/notifications/pc_notif_container")
CoD.Loading_MP = InheritFrom(CoD.Menu)
LUI.createMenu.Loading_MP = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Loading_MP", f1_arg0)
	local f1_local1 = self
	if IsPC() and IsGameTypeCombatTraining() and CoD.CTUtility.ShouldPlayIntroTutorialMovie(f1_arg0) then
		CoD.MapUtility.PlayMapLoadingMusic()
		CoD.BaseUtility.InitGlobalModel("cutsceneSkippable", false)
		CoD.BaseUtility.InitGlobalModel("mapLoaded", false)
		CoD.BaseUtility.InitGlobalModel("isIntroTutorialMovie", true)
	elseif IsPC() and IsGameTypeCombatTraining() then
		CoD.MapUtility.PlayMapLoadingMusic()
		CoD.BaseUtility.InitGlobalModel("cutsceneSkippable", false)
		CoD.BaseUtility.InitGlobalModel("mapLoaded", false)
		CoD.BaseUtility.InitGlobalModel("isIntroTutorialMovie", false)
		LockInput(self, f1_arg0, true)
	else
		CoD.MapUtility.PlayMapLoadingMusic()
		CoD.BaseUtility.InitGlobalModel("cutsceneSkippable", false)
		CoD.BaseUtility.InitGlobalModel("mapLoaded", false)
		CoD.BaseUtility.InitGlobalModel("isIntroTutorialMovie", false)
	end
	self:setClass(CoD.Loading_MP)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlackBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBackground:setRGB(0, 0, 0)
	self:addElement(BlackBackground)
	self.BlackBackground = BlackBackground
	local loadingImageOrMovie = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(loadingImageOrMovie)
	self.loadingImageOrMovie = loadingImageOrMovie
	local LoadingElem2 = CoD.LoadingScreenLoadbar.new(f1_local1, f1_arg0, 0.5, 0.5, -865, -182, 1, 1, -70, -50)
	LoadingElem2:subscribeToGlobalModel(f1_arg0, "LoadingScreenTeamInfo", "loadedFraction", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LoadingElem2.LoadingBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(LoadingElem2)
	self.LoadingElem2 = LoadingElem2
	local BlackFadeOut = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackFadeOut:setRGB(0, 0, 0)
	BlackFadeOut:setAlpha(0)
	self:addElement(BlackFadeOut)
	self.BlackFadeOut = BlackFadeOut
	local TipWidgetList = CoD.TipWidgetList.new(f1_local1, f1_arg0, 0.5, 0.5, -865, -182, 1, 1, -197, -109)
	self:addElement(TipWidgetList)
	self.TipWidgetList = TipWidgetList
	local DoubleXPIconsLeftAligned = CoD.DoubleXPIconsLeftAligned.new(f1_local1, f1_arg0, 0.5, 0.5, -886, -670, 1, 1, -254.5, -182.5)
	self:addElement(DoubleXPIconsLeftAligned)
	self.DoubleXPIconsLeftAligned = DoubleXPIconsLeftAligned
	local LoadingScreenHeader = CoD.LoadingScreenHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -795, 334, 0, 0, 52.5, 252.5)
	self:addElement(LoadingScreenHeader)
	self.LoadingScreenHeader = LoadingScreenHeader
	local GamemodeIcon = LUI.UIImage.new(0.5, 0.5, -932, -608, 0, 0, -16.5, 307.5)
	GamemodeIcon:subscribeToGlobalModel(f1_arg0, "LoadingScreenTeamInfo", "gameTypeIcon", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GamemodeIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(GamemodeIcon)
	self.GamemodeIcon = GamemodeIcon
	local Team1PlayerList = LUI.UIList.new(f1_local1, f1_arg0, 8, 0, nil, false, false, false, false)
	Team1PlayerList:setLeftRight(0.5, 0.5, -865, -535)
	Team1PlayerList:setTopBottom(0, 0, 284, 416)
	Team1PlayerList:setWidgetType(CoD.LoadingScreenTalkerWidgetCPZM)
	Team1PlayerList:setVerticalCount(4)
	Team1PlayerList:setSpacing(8)
	Team1PlayerList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Team1PlayerList:setDataSource("LoadingScreenPlayerListTeam1")
	self:addElement(Team1PlayerList)
	self.Team1PlayerList = Team1PlayerList
	local label = CoD.LoadingScreenSkipPrompt.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	label:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f4_local0 = IsMouseOrKeyboard(f1_arg0)
				if f4_local0 then
					f4_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable")
					if f4_local0 then
						f4_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded")
						if f4_local0 then
							f4_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("isIntroTutorialMovie")
						end
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f5_local0 = IsGamepad(f1_arg0)
				if f5_local0 then
					f5_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable")
					if f5_local0 then
						f5_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded")
						if f5_local0 then
							f5_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("isIntroTutorialMovie")
						end
					end
				end
				return f5_local0
			end,
		},
	})
	label:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_local1
		f1_local1:updateElementState(label, f6_arg1)
	end)
	local PCNotifContainer = label
	local MovieSubtitles = label.subscribeToModel
	local f1_local14 = Engine.GetModelForController(f1_arg0)
	MovieSubtitles(PCNotifContainer, f1_local14.LastInput, function(f7_arg0)
		f1_local1:updateElementState(label, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	PCNotifContainer = label
	MovieSubtitles = label.subscribeToModel
	f1_local14 = Engine.GetGlobalModel()
	MovieSubtitles(PCNotifContainer, f1_local14.cutsceneSkippable, function(f8_arg0)
		f1_local1:updateElementState(label, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "cutsceneSkippable",
		})
	end, false)
	PCNotifContainer = label
	MovieSubtitles = label.subscribeToModel
	f1_local14 = Engine.GetGlobalModel()
	MovieSubtitles(PCNotifContainer, f1_local14.mapLoaded, function(f9_arg0)
		f1_local1:updateElementState(label, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "mapLoaded",
		})
	end, false)
	PCNotifContainer = label
	MovieSubtitles = label.subscribeToModel
	f1_local14 = Engine.GetGlobalModel()
	MovieSubtitles(PCNotifContainer, f1_local14.isIntroTutorialMovie, function(f10_arg0)
		f1_local1:updateElementState(label, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "isIntroTutorialMovie",
		})
	end, false)
	label.label:setTTF("ttmussels_regular")
	self:addElement(label)
	self.label = label
	MovieSubtitles = CoD.MovieSubtitles.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(MovieSubtitles)
	self.MovieSubtitles = MovieSubtitles
	PCNotifContainer = nil
	PCNotifContainer = CoD.PC_Notif_Container.new(f1_local1, f1_arg0, 0.5, 0.5, 468, 918, 0, 0, 102.5, 202.5)
	self:addElement(PCNotifContainer)
	self.PCNotifContainer = PCNotifContainer
	self:mergeStateConditions({
		{
			stateName = "CombatTraining",
			condition = function(menu, element, event)
				return CoD.HUDUtility.LoadingHeaderNotShown()
			end,
		},
		{
			stateName = "SplitScreen",
			condition = function(menu, element, event)
				return IsSplitscreenAndInGame(f1_arg0)
			end,
		},
	})
	local f1_local15 = self
	f1_local14 = self.subscribeToModel
	local f1_local16 = Engine.GetGlobalModel()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNav"], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local15 = self
	f1_local14 = self.subscribeToModel
	f1_local16 = Engine.GetGlobalModel()
	f1_local14(f1_local15, f1_local16["lobbyRoot.gameClient.update"], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local15 = self
	f1_local14 = self.subscribeToModel
	f1_local16 = Engine.GetGlobalModel()
	f1_local14(f1_local15, f1_local16["lobbyRoot.privateClient.update"], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	f1_local15 = self
	f1_local14 = self.subscribeToModel
	f1_local16 = Engine.GetGlobalModel()
	f1_local14(f1_local15, f1_local16.cutsceneSkippable, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
	end, false)
	f1_local15 = self
	f1_local14 = self.subscribeToModel
	f1_local16 = Engine.GetGlobalModel()
	f1_local14(f1_local15, f1_local16.mapLoaded, function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
	end, false)
	f1_local15 = self
	f1_local14 = self.subscribeToModel
	f1_local16 = Engine.GetGlobalModel()
	f1_local14(f1_local15, f1_local16.isIntroTutorialMovie, function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
	end, false)
	self:registerEventHandler("loading_startplay", function(element, event)
		local f19_local0 = nil
		CoD.HUDUtility.StartPlay(element, f1_arg0)
		if not f19_local0 then
			f19_local0 = element:dispatchEventToChildren(event)
		end
		return f19_local0
	end)
	self:registerEventHandler("loading_nomovie_startplay", function(element, event)
		local f20_local0 = nil
		if IsSplitscreenAndInGame(f1_arg0) and IsWarzone() then
			CoD.HUDUtility.StartPlay(element, f1_arg0)
		end
		if not f20_local0 then
			f20_local0 = element:dispatchEventToChildren(event)
		end
		return f20_local0
	end)
	self:registerEventHandler("loading_displaycontinue", function(element, event)
		local f21_local0 = nil
		SetGlobalModelValueTrue("mapLoaded")
		if not f21_local0 then
			f21_local0 = element:dispatchEventToChildren(event)
		end
		return f21_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
		if CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable") and CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded") and not CoD.ModelUtility.IsGlobalModelValueTrue("isIntroTutorialMovie") then
			CoD.HUDUtility.StartPlay(f22_arg0, f22_arg2)
			return true
		else
		end
	end, function(f23_arg0, f23_arg1, f23_arg2)
		if CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable") and CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded") and not CoD.ModelUtility.IsGlobalModelValueTrue("isIntroTutorialMovie") then
			CoD.Menu.SetButtonLabel(f23_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_none"], "ESCAPE", function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
		if CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable") and CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded") and not CoD.ModelUtility.IsGlobalModelValueTrue("isIntroTutorialMovie") then
			CoD.HUDUtility.StartPlay(f24_arg0, f24_arg2)
			return true
		else
		end
	end, function(f25_arg0, f25_arg1, f25_arg2)
		if CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable") and CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded") and not CoD.ModelUtility.IsGlobalModelValueTrue("isIntroTutorialMovie") then
			CoD.Menu.SetButtonLabel(f25_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "ESCAPE")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsGameTypeCombatTraining() and IsPC() then
			LockInput(self, f1_arg0, false)
			CoD.PCUtility.UnlockUIShortcutInput(f1_local1, f1_arg0)
		elseif IsPC() then
			CoD.PCUtility.UnlockUIShortcutInput(f1_local1, f1_arg0)
		end
	end)
	Team1PlayerList.id = "Team1PlayerList"
	if CoD.isPC then
		PCNotifContainer.id = "PCNotifContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local14 = self
	if IsPC() then
		PlayClip(self, "StartLoading", f1_arg0)
		PlayClipOnElement(self, {
			elementName = "LoadingScreenTeamGameInfo",
			clipName = "StartLoading",
		}, f1_arg0)
		PlayClipOnElement(self, {
			elementName = "LoadingScreenHeaderFooter",
			clipName = "StartLoading",
		}, f1_arg0)
		CoD.PCWidgetUtility.ResetAllKeysColor()
		CoD.PCUtility.LockUIShortcutInput(f1_local1, f1_arg0)
		CoD.CTUtility.StartSkipTimer(f1_local1, 5000)
	else
		PlayClip(self, "StartLoading", f1_arg0)
		PlayClipOnElement(self, {
			elementName = "LoadingScreenTeamGameInfo",
			clipName = "StartLoading",
		}, f1_arg0)
		PlayClipOnElement(self, {
			elementName = "LoadingScreenHeaderFooter",
			clipName = "StartLoading",
		}, f1_arg0)
		CoD.CTUtility.StartSkipTimer(f1_local1, 5000)
	end
	CoD.HUDUtility.InitLoadingImageOrMovie(loadingImageOrMovie, f1_arg0)
	return self
end
CoD.Loading_MP.__resetProperties = function(f27_arg0)
	f27_arg0.GamemodeIcon:completeAnimation()
	f27_arg0.BlackBackground:completeAnimation()
	f27_arg0.loadingImageOrMovie:completeAnimation()
	f27_arg0.LoadingElem2:completeAnimation()
	f27_arg0.LoadingScreenHeader:completeAnimation()
	f27_arg0.TipWidgetList:completeAnimation()
	f27_arg0.DoubleXPIconsLeftAligned:completeAnimation()
	f27_arg0.Team1PlayerList:completeAnimation()
	f27_arg0.GamemodeIcon:setAlpha(1)
	f27_arg0.GamemodeIcon:setScale(1, 1)
	f27_arg0.BlackBackground:setAlpha(1)
	f27_arg0.loadingImageOrMovie:setAlpha(1)
	f27_arg0.LoadingElem2:setAlpha(1)
	f27_arg0.LoadingScreenHeader:setAlpha(1)
	f27_arg0.TipWidgetList:setAlpha(1)
	f27_arg0.DoubleXPIconsLeftAligned:setAlpha(1)
	f27_arg0.DoubleXPIconsLeftAligned:setScale(1, 1)
	f27_arg0.Team1PlayerList:setTopBottom(0, 0, 284, 416)
	f27_arg0.Team1PlayerList:setAlpha(1)
end
CoD.Loading_MP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(7)
			f28_arg0.BlackBackground:completeAnimation()
			f28_arg0.BlackBackground:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.BlackBackground)
			f28_arg0.loadingImageOrMovie:completeAnimation()
			f28_arg0.loadingImageOrMovie:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.loadingImageOrMovie)
			local f28_local0 = function(f29_arg0)
				f29_arg0:beginAnimation(300)
				f29_arg0:setAlpha(1)
				f29_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.LoadingElem2:beginAnimation(100)
			f28_arg0.LoadingElem2:setAlpha(0)
			f28_arg0.LoadingElem2:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
			f28_arg0.LoadingElem2:registerEventHandler("transition_complete_keyframe", f28_local0)
			local f28_local1 = function(f30_arg0)
				f30_arg0:beginAnimation(300)
				f30_arg0:setAlpha(1)
				f30_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.TipWidgetList:beginAnimation(210)
			f28_arg0.TipWidgetList:setAlpha(0)
			f28_arg0.TipWidgetList:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
			f28_arg0.TipWidgetList:registerEventHandler("transition_complete_keyframe", f28_local1)
			local f28_local2 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(79)
					f32_arg0:setAlpha(1)
					f32_arg0:setScale(1, 1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f31_arg0:beginAnimation(139)
				f31_arg0:setAlpha(0.64)
				f31_arg0:setScale(0.6, 0.6)
				f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f28_arg0.DoubleXPIconsLeftAligned:beginAnimation(370)
			f28_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
			f28_arg0.DoubleXPIconsLeftAligned:setScale(3, 3)
			f28_arg0.DoubleXPIconsLeftAligned:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
			f28_arg0.DoubleXPIconsLeftAligned:registerEventHandler("transition_complete_keyframe", f28_local2)
			local f28_local3 = function(f33_arg0)
				f33_arg0:beginAnimation(300)
				f33_arg0:setAlpha(1)
				f33_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.LoadingScreenHeader:beginAnimation(100)
			f28_arg0.LoadingScreenHeader:setAlpha(0)
			f28_arg0.LoadingScreenHeader:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
			f28_arg0.LoadingScreenHeader:registerEventHandler("transition_complete_keyframe", f28_local3)
			local f28_local4 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(60)
					f35_arg0:setAlpha(1)
					f35_arg0:setScale(1, 1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.GamemodeIcon:beginAnimation(240)
				f28_arg0.GamemodeIcon:setAlpha(0.8)
				f28_arg0.GamemodeIcon:setScale(0.8, 0.8)
				f28_arg0.GamemodeIcon:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.GamemodeIcon:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f28_arg0.GamemodeIcon:completeAnimation()
			f28_arg0.GamemodeIcon:setAlpha(0)
			f28_arg0.GamemodeIcon:setScale(3, 3)
			f28_local4(f28_arg0.GamemodeIcon)
		end,
		Close = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(8)
			f36_arg0.BlackBackground:completeAnimation()
			f36_arg0.BlackBackground:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.BlackBackground)
			f36_arg0.loadingImageOrMovie:completeAnimation()
			f36_arg0.loadingImageOrMovie:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.loadingImageOrMovie)
			f36_arg0.LoadingElem2:completeAnimation()
			f36_arg0.LoadingElem2:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.LoadingElem2)
			f36_arg0.TipWidgetList:completeAnimation()
			f36_arg0.TipWidgetList:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.TipWidgetList)
			f36_arg0.DoubleXPIconsLeftAligned:completeAnimation()
			f36_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.DoubleXPIconsLeftAligned)
			local f36_local0 = function(f37_arg0)
				f36_arg0.LoadingScreenHeader:beginAnimation(250)
				f36_arg0.LoadingScreenHeader:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.LoadingScreenHeader:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.LoadingScreenHeader:completeAnimation()
			f36_arg0.LoadingScreenHeader:setAlpha(0)
			f36_local0(f36_arg0.LoadingScreenHeader)
			local f36_local1 = function(f38_arg0)
				f36_arg0.GamemodeIcon:beginAnimation(250)
				f36_arg0.GamemodeIcon:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.GamemodeIcon:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.GamemodeIcon:completeAnimation()
			f36_arg0.GamemodeIcon:setAlpha(0)
			f36_local1(f36_arg0.GamemodeIcon)
			local f36_local2 = function(f39_arg0)
				f36_arg0.Team1PlayerList:beginAnimation(250)
				f36_arg0.Team1PlayerList:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.Team1PlayerList:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.Team1PlayerList:completeAnimation()
			f36_arg0.Team1PlayerList:setAlpha(0)
			f36_local2(f36_arg0.Team1PlayerList)
		end,
	},
	CombatTraining = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(6)
			f40_arg0.LoadingElem2:completeAnimation()
			f40_arg0.LoadingElem2:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.LoadingElem2)
			f40_arg0.TipWidgetList:completeAnimation()
			f40_arg0.TipWidgetList:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.TipWidgetList)
			local f40_local0 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(79)
					f42_arg0:setAlpha(1)
					f42_arg0:setScale(1, 1)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f41_arg0:beginAnimation(139)
				f41_arg0:setAlpha(0.64)
				f41_arg0:setScale(0.6, 0.6)
				f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f40_arg0.DoubleXPIconsLeftAligned:beginAnimation(370)
			f40_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
			f40_arg0.DoubleXPIconsLeftAligned:setScale(3, 3)
			f40_arg0.DoubleXPIconsLeftAligned:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
			f40_arg0.DoubleXPIconsLeftAligned:registerEventHandler("transition_complete_keyframe", f40_local0)
			f40_arg0.LoadingScreenHeader:completeAnimation()
			f40_arg0.LoadingScreenHeader:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.LoadingScreenHeader)
			f40_arg0.GamemodeIcon:completeAnimation()
			f40_arg0.GamemodeIcon:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.GamemodeIcon)
			f40_arg0.Team1PlayerList:completeAnimation()
			f40_arg0.Team1PlayerList:setTopBottom(0, 0, 79.5, 211.5)
			f40_arg0.clipFinished(f40_arg0.Team1PlayerList)
		end,
		Close = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(7)
			local f43_local0 = function(f44_arg0)
				f43_arg0.BlackBackground:beginAnimation(500)
				f43_arg0.BlackBackground:setAlpha(0)
				f43_arg0.BlackBackground:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.BlackBackground:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.BlackBackground:completeAnimation()
			f43_arg0.BlackBackground:setAlpha(1)
			f43_local0(f43_arg0.BlackBackground)
			local f43_local1 = function(f45_arg0)
				f43_arg0.loadingImageOrMovie:beginAnimation(500)
				f43_arg0.loadingImageOrMovie:setAlpha(0)
				f43_arg0.loadingImageOrMovie:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.loadingImageOrMovie:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.loadingImageOrMovie:completeAnimation()
			f43_arg0.loadingImageOrMovie:setAlpha(1)
			f43_local1(f43_arg0.loadingImageOrMovie)
			local f43_local2 = function(f46_arg0)
				f43_arg0.LoadingElem2:beginAnimation(250)
				f43_arg0.LoadingElem2:setAlpha(0)
				f43_arg0.LoadingElem2:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.LoadingElem2:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.LoadingElem2:completeAnimation()
			f43_arg0.LoadingElem2:setAlpha(1)
			f43_local2(f43_arg0.LoadingElem2)
			f43_arg0.TipWidgetList:completeAnimation()
			f43_arg0.TipWidgetList:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.TipWidgetList)
			local f43_local3 = function(f47_arg0)
				f43_arg0.DoubleXPIconsLeftAligned:beginAnimation(250)
				f43_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
				f43_arg0.DoubleXPIconsLeftAligned:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.DoubleXPIconsLeftAligned:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.DoubleXPIconsLeftAligned:completeAnimation()
			f43_arg0.DoubleXPIconsLeftAligned:setAlpha(1)
			f43_local3(f43_arg0.DoubleXPIconsLeftAligned)
			f43_arg0.LoadingScreenHeader:completeAnimation()
			f43_arg0.LoadingScreenHeader:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.LoadingScreenHeader)
			f43_arg0.GamemodeIcon:completeAnimation()
			f43_arg0.GamemodeIcon:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.GamemodeIcon)
		end,
	},
	SplitScreen = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(6)
			f48_arg0.BlackBackground:completeAnimation()
			f48_arg0.BlackBackground:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.BlackBackground)
			local f48_local0 = function(f49_arg0)
				f49_arg0:beginAnimation(300)
				f49_arg0:setAlpha(1)
				f49_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.LoadingElem2:beginAnimation(100)
			f48_arg0.LoadingElem2:setAlpha(0)
			f48_arg0.LoadingElem2:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
			f48_arg0.LoadingElem2:registerEventHandler("transition_complete_keyframe", f48_local0)
			local f48_local1 = function(f50_arg0)
				f50_arg0:beginAnimation(300)
				f50_arg0:setAlpha(1)
				f50_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.TipWidgetList:beginAnimation(210)
			f48_arg0.TipWidgetList:setAlpha(0)
			f48_arg0.TipWidgetList:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
			f48_arg0.TipWidgetList:registerEventHandler("transition_complete_keyframe", f48_local1)
			local f48_local2 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(79)
					f52_arg0:setAlpha(1)
					f52_arg0:setScale(1, 1)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f51_arg0:beginAnimation(139)
				f51_arg0:setAlpha(0.64)
				f51_arg0:setScale(0.6, 0.6)
				f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f48_arg0.DoubleXPIconsLeftAligned:beginAnimation(370)
			f48_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
			f48_arg0.DoubleXPIconsLeftAligned:setScale(3, 3)
			f48_arg0.DoubleXPIconsLeftAligned:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
			f48_arg0.DoubleXPIconsLeftAligned:registerEventHandler("transition_complete_keyframe", f48_local2)
			local f48_local3 = function(f53_arg0)
				f53_arg0:beginAnimation(300)
				f53_arg0:setAlpha(1)
				f53_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.LoadingScreenHeader:beginAnimation(100)
			f48_arg0.LoadingScreenHeader:setAlpha(0)
			f48_arg0.LoadingScreenHeader:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
			f48_arg0.LoadingScreenHeader:registerEventHandler("transition_complete_keyframe", f48_local3)
			local f48_local4 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					f55_arg0:beginAnimation(60)
					f55_arg0:setAlpha(1)
					f55_arg0:setScale(1, 1)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f48_arg0.GamemodeIcon:beginAnimation(240)
				f48_arg0.GamemodeIcon:setAlpha(0.8)
				f48_arg0.GamemodeIcon:setScale(0.8, 0.8)
				f48_arg0.GamemodeIcon:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.GamemodeIcon:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f48_arg0.GamemodeIcon:completeAnimation()
			f48_arg0.GamemodeIcon:setAlpha(0)
			f48_arg0.GamemodeIcon:setScale(3, 3)
			f48_local4(f48_arg0.GamemodeIcon)
		end,
	},
}
CoD.Loading_MP.__onClose = function(f56_arg0)
	f56_arg0.loadingImageOrMovie:close()
	f56_arg0.LoadingElem2:close()
	f56_arg0.TipWidgetList:close()
	f56_arg0.DoubleXPIconsLeftAligned:close()
	f56_arg0.LoadingScreenHeader:close()
	f56_arg0.GamemodeIcon:close()
	f56_arg0.Team1PlayerList:close()
	f56_arg0.label:close()
	f56_arg0.MovieSubtitles:close()
	f56_arg0.PCNotifContainer:close()
end
