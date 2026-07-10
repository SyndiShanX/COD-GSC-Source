require("x64:f8db2063f73b388")
require("x64:6c6bd604aaeea32")
require("x64:76511006ba8d45c")
require("x64:474d14efb47ebf4")
require("x64:5a873e109fe152")
require("x64:bd860e6848b37d7")
require("x64:6ee653ade3452f5")
require("x64:c0887595cfb6bb1")
CoD.Loading_WZ = InheritFrom(CoD.Menu)
LUI.createMenu.Loading_WZ = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Loading_WZ", f1_arg0)
	local f1_local1 = self
	CoD.MapUtility.PlayMapLoadingMusic()
	CoD.WZUtility.InitWZLoadingFractionUpdate(self, f1_arg0)
	self:setClass(CoD.Loading_WZ)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local background = nil
	background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0, 0, 0)
	self:addElement(background)
	self.background = background
	local loadingImageOrMovie = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(loadingImageOrMovie)
	self.loadingImageOrMovie = loadingImageOrMovie
	local BlackFadeOut = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackFadeOut:setRGB(0, 0, 0)
	self:addElement(BlackFadeOut)
	self.BlackFadeOut = BlackFadeOut
	local LoadingElem2 = CoD.LoadingScreenLoadbar_WZ.new(f1_local1, f1_arg0, 0.5, 0.5, -864, -183, 0.5, 0.5, 470, 490)
	LoadingElem2:subscribeToGlobalModel(f1_arg0, "LoadingScreenTeamInfo", "wzLoadedFraction", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LoadingElem2.LoadingBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(LoadingElem2)
	self.LoadingElem2 = LoadingElem2
	local TipWidgetListWZ = CoD.TipWidgetList_WZ.new(f1_local1, f1_arg0, 0.5, 0.5, -865, -182, 0.5, 0.5, 338.5, 472.5)
	self:addElement(TipWidgetListWZ)
	self.TipWidgetListWZ = TipWidgetListWZ
	local DoubleXPIconsLeftAligned = CoD.DoubleXPIconsLeftAligned.new(f1_local1, f1_arg0, 0.5, 0.5, -865, -649, 0.5, 0.5, 282.5, 354.5)
	self:addElement(DoubleXPIconsLeftAligned)
	self.DoubleXPIconsLeftAligned = DoubleXPIconsLeftAligned
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local Team1PlayerList = LUI.UIList.new(f1_local1, f1_arg0, 8, 0, nil, false, false, false, false)
	Team1PlayerList:setLeftRight(0.5, 0.5, -865, -535)
	Team1PlayerList:setTopBottom(0, 0, 340, 472)
	Team1PlayerList:setWidgetType(CoD.LoadingScreenTalkerWidgetCPZM)
	Team1PlayerList:setVerticalCount(4)
	Team1PlayerList:setSpacing(8)
	Team1PlayerList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Team1PlayerList:setDataSource("LoadingScreenPlayerListTeam1")
	self:addElement(Team1PlayerList)
	self.Team1PlayerList = Team1PlayerList
	local PCNotifContainer = nil
	PCNotifContainer = CoD.PC_Notif_Container.new(f1_local1, f1_arg0, 0.5, 0.5, 470, 920, 0, 0, 106, 206)
	self:addElement(PCNotifContainer)
	self.PCNotifContainer = PCNotifContainer
	local TrialInfo = CoD.Loading_WZ_TrialBanner.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -50, 250)
	self:addElement(TrialInfo)
	self.TrialInfo = TrialInfo
	local LoadingScreenHeader = CoD.LoadingScreenHeader_WZ.new(f1_local1, f1_arg0, 0.5, 0.5, -794, 335, 0, 0, 101.5, 229.5)
	self:addElement(LoadingScreenHeader)
	self.LoadingScreenHeader = LoadingScreenHeader
	local GamemodeIcon = LUI.UIImage.new(0.5, 0.5, -959, -635, 0, 0, 3.5, 327.5)
	GamemodeIcon:setScale(0.8, 0.8)
	GamemodeIcon:subscribeToGlobalModel(f1_arg0, "LoadingScreenTeamInfo", "gameTypeIcon", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GamemodeIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(GamemodeIcon)
	self.GamemodeIcon = GamemodeIcon
	self:registerEventHandler("loading_startplay", function(self, event)
		local f4_local0 = nil
		if IsSplitscreenAndInGame(f1_arg0) and IsWarzone() then
			CoD.HUDUtility.StartPlay(self, f1_arg0)
			HideWidget(self)
		else
			CoD.HUDUtility.StartPlay(self, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = self:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:registerEventHandler("loading_nomovie_startplay", function(self, event)
		local f5_local0 = nil
		if IsSplitscreenAndInGame(f1_arg0) and IsWarzone() then
			CoD.HUDUtility.StartPlay(self, f1_arg0)
			HideWidget(self)
		end
		if not f5_local0 then
			f5_local0 = self:dispatchEventToChildren(event)
		end
		return f5_local0
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
	local f1_local14 = self
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
		CoD.PCUtility.SetupUIMenuShortcutBlocker(self, f1_local1)
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
	end
	CoD.HUDUtility.InitLoadingImageOrMovie(loadingImageOrMovie, f1_arg0)
	f1_local14 = PCNotifContainer
	if IsPC() and CoD.PCNotificationsUtility.HideNotificationWidgetInLoadingWZ() then
		ReplaceElementWithFake(self, "PCNotifContainer")
	end
	return self
end
CoD.Loading_WZ.__resetProperties = function(f6_arg0)
	f6_arg0.BlackFadeOut:completeAnimation()
	f6_arg0.TipWidgetListWZ:completeAnimation()
	f6_arg0.TrialInfo:completeAnimation()
	f6_arg0.GamemodeIcon:completeAnimation()
	f6_arg0.LoadingScreenHeader:completeAnimation()
	f6_arg0.LoadingElem2:completeAnimation()
	f6_arg0.loadingImageOrMovie:completeAnimation()
	f6_arg0.Team1PlayerList:completeAnimation()
	f6_arg0.DoubleXPIconsLeftAligned:completeAnimation()
	f6_arg0.BlackFadeOut:setAlpha(1)
	f6_arg0.TipWidgetListWZ:setAlpha(1)
	f6_arg0.TrialInfo:setAlpha(1)
	f6_arg0.GamemodeIcon:setAlpha(1)
	f6_arg0.LoadingScreenHeader:setAlpha(1)
	f6_arg0.LoadingElem2:setAlpha(1)
	f6_arg0.loadingImageOrMovie:setAlpha(1)
	f6_arg0.Team1PlayerList:setAlpha(1)
	f6_arg0.DoubleXPIconsLeftAligned:setAlpha(1)
end
CoD.Loading_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(6)
			f7_arg0.BlackFadeOut:completeAnimation()
			f7_arg0.BlackFadeOut:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BlackFadeOut)
			local f7_local0 = function(f8_arg0)
				f8_arg0:beginAnimation(300)
				f8_arg0:setAlpha(1)
				f8_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.LoadingElem2:beginAnimation(100)
			f7_arg0.LoadingElem2:setAlpha(0)
			f7_arg0.LoadingElem2:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
			f7_arg0.LoadingElem2:registerEventHandler("transition_complete_keyframe", f7_local0)
			local f7_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(300)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.TipWidgetListWZ:beginAnimation(200)
				f7_arg0.TipWidgetListWZ:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.TipWidgetListWZ:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f7_arg0.TipWidgetListWZ:completeAnimation()
			f7_arg0.TipWidgetListWZ:setAlpha(0)
			f7_local1(f7_arg0.TipWidgetListWZ)
			local f7_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(300)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.TrialInfo:beginAnimation(300)
				f7_arg0.TrialInfo:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.TrialInfo:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f7_arg0.TrialInfo:completeAnimation()
			f7_arg0.TrialInfo:setAlpha(0)
			f7_local2(f7_arg0.TrialInfo)
			local f7_local3 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(300)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.LoadingScreenHeader:beginAnimation(100)
				f7_arg0.LoadingScreenHeader:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.LoadingScreenHeader:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f7_arg0.LoadingScreenHeader:completeAnimation()
			f7_arg0.LoadingScreenHeader:setAlpha(0)
			f7_local3(f7_arg0.LoadingScreenHeader)
			local f7_local4 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(290)
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.GamemodeIcon:beginAnimation(100)
				f7_arg0.GamemodeIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.GamemodeIcon:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f7_arg0.GamemodeIcon:completeAnimation()
			f7_arg0.GamemodeIcon:setAlpha(0)
			f7_local4(f7_arg0.GamemodeIcon)
		end,
		Close = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(9)
			local f17_local0 = function(f18_arg0)
				f17_arg0.loadingImageOrMovie:beginAnimation(250)
				f17_arg0.loadingImageOrMovie:setAlpha(0)
				f17_arg0.loadingImageOrMovie:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.loadingImageOrMovie:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.loadingImageOrMovie:completeAnimation()
			f17_arg0.loadingImageOrMovie:setAlpha(1)
			f17_local0(f17_arg0.loadingImageOrMovie)
			local f17_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(250)
					f20_arg0:setAlpha(0)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.BlackFadeOut:beginAnimation(250)
				f17_arg0.BlackFadeOut:setAlpha(1)
				f17_arg0.BlackFadeOut:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.BlackFadeOut:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f17_arg0.BlackFadeOut:completeAnimation()
			f17_arg0.BlackFadeOut:setAlpha(0)
			f17_local1(f17_arg0.BlackFadeOut)
			local f17_local2 = function(f21_arg0)
				f17_arg0.LoadingElem2:beginAnimation(250)
				f17_arg0.LoadingElem2:setAlpha(0)
				f17_arg0.LoadingElem2:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.LoadingElem2:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.LoadingElem2:completeAnimation()
			f17_arg0.LoadingElem2:setAlpha(1)
			f17_local2(f17_arg0.LoadingElem2)
			local f17_local3 = function(f22_arg0)
				f17_arg0.TipWidgetListWZ:beginAnimation(250)
				f17_arg0.TipWidgetListWZ:setAlpha(0)
				f17_arg0.TipWidgetListWZ:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.TipWidgetListWZ:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.TipWidgetListWZ:completeAnimation()
			f17_arg0.TipWidgetListWZ:setAlpha(1)
			f17_local3(f17_arg0.TipWidgetListWZ)
			local f17_local4 = function(f23_arg0)
				f17_arg0.DoubleXPIconsLeftAligned:beginAnimation(250)
				f17_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
				f17_arg0.DoubleXPIconsLeftAligned:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DoubleXPIconsLeftAligned:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.DoubleXPIconsLeftAligned:completeAnimation()
			f17_arg0.DoubleXPIconsLeftAligned:setAlpha(1)
			f17_local4(f17_arg0.DoubleXPIconsLeftAligned)
			local f17_local5 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(250)
					f25_arg0:setAlpha(0)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.Team1PlayerList:beginAnimation(250)
				f17_arg0.Team1PlayerList:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Team1PlayerList:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f17_arg0.Team1PlayerList:completeAnimation()
			f17_arg0.Team1PlayerList:setAlpha(1)
			f17_local5(f17_arg0.Team1PlayerList)
			local f17_local6 = function(f26_arg0)
				f17_arg0.TrialInfo:beginAnimation(250)
				f17_arg0.TrialInfo:setAlpha(0)
				f17_arg0.TrialInfo:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.TrialInfo:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.TrialInfo:completeAnimation()
			f17_arg0.TrialInfo:setAlpha(1)
			f17_local6(f17_arg0.TrialInfo)
			local f17_local7 = function(f27_arg0)
				f17_arg0.LoadingScreenHeader:beginAnimation(250)
				f17_arg0.LoadingScreenHeader:setAlpha(0)
				f17_arg0.LoadingScreenHeader:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.LoadingScreenHeader:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.LoadingScreenHeader:completeAnimation()
			f17_arg0.LoadingScreenHeader:setAlpha(1)
			f17_local7(f17_arg0.LoadingScreenHeader)
			local f17_local8 = function(f28_arg0)
				f17_arg0.GamemodeIcon:beginAnimation(250)
				f17_arg0.GamemodeIcon:setAlpha(0)
				f17_arg0.GamemodeIcon:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.GamemodeIcon:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.GamemodeIcon:completeAnimation()
			f17_arg0.GamemodeIcon:setAlpha(1)
			f17_local8(f17_arg0.GamemodeIcon)
		end,
	},
}
CoD.Loading_WZ.__onClose = function(f29_arg0)
	f29_arg0.loadingImageOrMovie:close()
	f29_arg0.LoadingElem2:close()
	f29_arg0.TipWidgetListWZ:close()
	f29_arg0.DoubleXPIconsLeftAligned:close()
	f29_arg0.ScorestreakAspectRatioFix:close()
	f29_arg0.Team1PlayerList:close()
	f29_arg0.PCNotifContainer:close()
	f29_arg0.TrialInfo:close()
	f29_arg0.LoadingScreenHeader:close()
	f29_arg0.GamemodeIcon:close()
end
