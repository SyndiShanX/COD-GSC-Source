require("x64:5ec5b3e9479f805")
require("x64:98f7faea863c34f")
require("x64:94e83bb5dd21f57")
CoD.SkippableVoDViewer = InheritFrom(CoD.Menu)
LUI.createMenu.SkippableVoDViewer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SkippableVoDViewer", f1_arg0)
	local f1_local1 = self
	CoD.VideoStreamingUtility.VoDViewerPreLoadFunc(self, f1_arg0, f1_arg1)
	CoD.BaseUtility.InitGlobalModel("cutsceneSkippable", false)
	self:setClass(CoD.SkippableVoDViewer)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local LiveEventViewerMovieAndBackground = CoD.VoDViewerMovieAndBackground.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	LiveEventViewerMovieAndBackground:mergeStateConditions({
		{
			stateName = "Windowed",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:addElement(LiveEventViewerMovieAndBackground)
	self.LiveEventViewerMovieAndBackground = LiveEventViewerMovieAndBackground
	local VoDViewerSkipPrompt = CoD.VoDViewerSkipPrompt.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(VoDViewerSkipPrompt)
	self.VoDViewerSkipPrompt = VoDViewerSkipPrompt
	local MovieSubtitles = CoD.MovieSubtitles.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(MovieSubtitles)
	self.MovieSubtitles = MovieSubtitles
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7.cutsceneSkippable, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable") then
			CoD.VideoStreamingUtility.SkipVoDViewer(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		local f6_local0 = self
		SetElementStateByElementName(self, "LiveEventViewerMovieAndBackground", f6_arg1, "DefaultState")
		MenuHidesFreeCursor(f6_arg2, f6_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg0, "LiveEventViewer", "currentQuality", function(model)
		UpdateButtonPromptState(f1_local1, self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	if CoD.isPC then
		LiveEventViewerMovieAndBackground.id = "LiveEventViewerMovieAndBackground"
	end
	VoDViewerSkipPrompt:setModel(self.buttonModel, f1_arg0)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = LiveEventViewerMovieAndBackground
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local6 = self
	if IsPC() then
		CoD.VideoStreamingUtility.VoDViewerPostLoadFunc(self, f1_arg0, f1_arg1)
		CoD.PCUtility.LockUIShortcutInput(f1_local1, f1_arg0)
		CoD.CTUtility.StartSkipTimer(f1_local1, 5000)
	else
		CoD.VideoStreamingUtility.VoDViewerPostLoadFunc(self, f1_arg0, f1_arg1)
		CoD.CTUtility.StartSkipTimer(f1_local1, 5000)
	end
	return self
end
CoD.SkippableVoDViewer.__onClose = function(f9_arg0)
	f9_arg0.__on_close_removeOverrides()
	f9_arg0.LiveEventViewerMovieAndBackground:close()
	f9_arg0.VoDViewerSkipPrompt:close()
	f9_arg0.MovieSubtitles:close()
end
