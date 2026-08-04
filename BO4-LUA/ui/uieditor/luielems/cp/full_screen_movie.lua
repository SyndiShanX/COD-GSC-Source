require("x64:5ec5b3e9479f805")
require("ui/uieditor/widgets/hud/movieplayback/moviesubtitles")
local PreLoadFunc = function(self, controller)
	self:registerEventHandler("finished_movie_playback", function(element, event)
		CoD.VideoStreamingUtility.SkipFullScreenMovie(element, controller)
	end)
	self.Movie:linkToElementModel(self, "movieName", true, function(model)
		if not (IsGameTypeCombatTraining() or IsMPTrainingLobby()) or not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
			local f3_local0 = Engine.GetModelValue(model)
			if f3_local0 then
				local f3_local1 = CoD.SafeGetModelValue(self:getModel(), "additive")
				f3_local1 = f3_local1 and f3_local1 ~= 0
				local f3_local2 = CoD.SafeGetModelValue(self:getModel(), "looping")
				f3_local2 = f3_local2 and f3_local2 ~= 0
				local f3_local3 = CoD.SafeGetModelValue(self:getModel(), "movieKey")
				if f3_local1 and Engine.issplitscreen() then
					self.SplitscreenSideBarLeft:setAlpha(100)
					self.SplitscreenSideBarRight:setAlpha(100)
				end
				self.Movie:setupMoviePlayback(f3_local0, f3_local1, f3_local2, f3_local3)
			end
		else
			CoD.VideoStreamingUtility.SkipFullScreenMovie(self, controller)
		end
	end)
	self.Movie:linkToElementModel(self, "playOutroMovie", true, function(model)
		if not IsGameTypeCombatTraining() or not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
			if Engine.GetModelValue(model) then
				local f4_local0 = CoD.mapsTable[Engine.GetCurrentMap()]
				if f4_local0 and f4_local0.outroMovie then
					self.Movie:setupMoviePlayback(f4_local0.outroMovie, false, false)
				end
			end
		else
			CoD.VideoStreamingUtility.SkipFullScreenMovie(self, controller)
		end
	end)
	self.BlackBg:linkToElementModel(self, "showBlackScreen", true, function(model)
		local modelValue = Engine.GetModelValue(model)
		if not modelValue or modelValue == 0 then
			self.BlackBg:setAlpha(0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		element.Movie:close()
	end)
end
CoD.full_screen_movie = InheritFrom(CoD.Menu)
LUI.createMenu.full_screen_movie = function(f7_arg0, f7_arg1)
	local self = CoD.Menu.NewForUIEditor("full_screen_movie", f7_arg0)
	local f7_local1 = self
	CoD.BaseUtility.InitGlobalModel("cutsceneSkippable", false)
	self:setClass(CoD.full_screen_movie)
	self.soundSet = "HUD"
	self:setOwner(f7_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f7_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f7_local1:addElementToPendingUpdateStateList(self)
	local SplitscreenSideBarRight = LUI.UIImage.new(0.5, 0.5, 960, 1672, 0.5, 0.5, -540, 540)
	SplitscreenSideBarRight:setRGB(0, 0, 0)
	SplitscreenSideBarRight:setAlpha(0)
	self:addElement(SplitscreenSideBarRight)
	self.SplitscreenSideBarRight = SplitscreenSideBarRight
	local SplitscreenSideBarLeft = LUI.UIImage.new(0.5, 0.5, -1712, -960, 0.5, 0.5, -540, 540)
	SplitscreenSideBarLeft:setRGB(0, 0, 0)
	SplitscreenSideBarLeft:setAlpha(0)
	self:addElement(SplitscreenSideBarLeft)
	self.SplitscreenSideBarLeft = SplitscreenSideBarLeft
	local BlackBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBg:setRGB(0, 0, 0)
	self:addElement(BlackBg)
	self.BlackBg = BlackBg
	local Movie = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	Movie:setupMoviePlayback("")
	self:addElement(Movie)
	self.Movie = Movie
	local VoDViewerSkipPrompt = CoD.VoDViewerSkipPrompt.new(f7_local1, f7_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(VoDViewerSkipPrompt)
	self.VoDViewerSkipPrompt = VoDViewerSkipPrompt
	local MovieSubtitles = CoD.MovieSubtitles.new(f7_local1, f7_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(MovieSubtitles)
	self.MovieSubtitles = MovieSubtitles
	self:mergeStateConditions({
		{
			stateName = "Skippable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable")
			end,
		},
	})
	local f7_local8 = self
	local f7_local9 = self.subscribeToModel
	local f7_local10 = Engine.GetGlobalModel()
	f7_local9(f7_local8, f7_local10.cutsceneSkippable, function(f9_arg0)
		f7_local1:updateElementState(self, {
			name = "model_validation",
			menu = f7_local1,
			controller = f7_arg0,
			modelValue = f9_arg0:get(),
			modelName = "cutsceneSkippable",
		})
	end, false)
	self:linkToElementModel(self, "skippable", true, function(model, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f7_local1, f7_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	f7_local1:AddButtonCallbackFunction(self, f7_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		if CoD.BaseUtility.IsSelfInState(self, "Skippable") and CoD.ModelUtility.IsSelfModelValueEqualTo(f11_arg0, f11_arg2, "skippable", 1) and not CoD.VideoStreamingUtility.IsMoviePaused(self.Movie) then
			CoD.VideoStreamingUtility.SkipFullScreenMovie(self, f11_arg2)
			return true
		else
		end
	end, function(f12_arg0, f12_arg1, f12_arg2)
		if CoD.BaseUtility.IsSelfInState(self, "Skippable") and CoD.ModelUtility.IsSelfModelValueEqualTo(f12_arg0, f12_arg2, "skippable", 1) and not CoD.VideoStreamingUtility.IsMoviePaused(self.Movie) then
			CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f13_arg2, f13_arg3, f13_arg4)
		if IsSelfInState(self, "Skippable") and IsPC() then
			LockInput(self, controller, true)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() then
			LockInput(self, f7_arg0, false)
			CoD.PCUtility.UnlockUIShortcutInput(f7_local1, f7_arg0)
		end
	end)
	VoDViewerSkipPrompt:setModel(self.buttonModel, f7_arg0)
	self:processEvent({
		name = "menu_loaded",
		controller = f7_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f7_arg0)
	end
	f7_local9 = self
	if IsPC() and CoD.ModelUtility.IsSelfModelValueEqualTo(f7_local9, f7_arg0, "skippable", 1) then
		CoD.CTUtility.StartSkipTimer(f7_local1, 5000)
		CoD.PCUtility.LockUIShortcutInput(f7_local1, f7_arg0)
	elseif CoD.ModelUtility.IsSelfModelValueEqualTo(f7_local9, f7_arg0, "skippable", 1) then
		CoD.CTUtility.StartSkipTimer(f7_local1, 5000)
	end
	return self
end
CoD.full_screen_movie.__onClose = function(f15_arg0)
	f15_arg0.VoDViewerSkipPrompt:close()
	f15_arg0.MovieSubtitles:close()
end
