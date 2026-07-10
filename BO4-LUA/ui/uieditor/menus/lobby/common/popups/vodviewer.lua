require("x64:98f7faea863c34f")
require("x64:e3be79df0c2cf28")
require("x64:94e83bb5dd21f57")
CoD.VoDViewer = InheritFrom(CoD.Menu)
LUI.createMenu.VoDViewer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VoDViewer", f1_arg0)
	local f1_local1 = self
	CoD.VideoStreamingUtility.VoDViewerPreLoadFunc(self, f1_arg0, f1_arg1)
	CoD.BaseUtility.InitGlobalModel("cutsceneSkippable", true)
	self:setClass(CoD.VoDViewer)
	self.soundSet = "Special_widgets"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local LiveEventViewerMovieAndBackground = CoD.VoDViewerMovieAndBackground.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(LiveEventViewerMovieAndBackground)
	self.LiveEventViewerMovieAndBackground = LiveEventViewerMovieAndBackground
	local LiveEventViewerFooterContainer0 = CoD.VoDViewerFooterContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 1.5, -540, -540)
	self:addElement(LiveEventViewerFooterContainer0)
	self.LiveEventViewerFooterContainer0 = LiveEventViewerFooterContainer0
	local MovieSubtitles = CoD.MovieSubtitles.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(MovieSubtitles)
	self.MovieSubtitles = MovieSubtitles
	self.__on_menuOpened_self = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = self
		if not CoD.ModelUtility.IsGlobalModelValueTrue("VoDViewerFullscreen") and IsPC() then
			SetElementStateByElementName(self, "LiveEventViewerMovieAndBackground", f2_arg1, "Windowed")
			UpdateButtonPromptState(f2_arg2, f2_local0, f2_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		elseif not CoD.ModelUtility.IsGlobalModelValueTrue("VoDViewerFullscreen") then
			SetElementStateByElementName(self, "LiveEventViewerMovieAndBackground", f2_arg1, "Windowed")
			UpdateButtonPromptState(f2_arg2, f2_local0, f2_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
			MenuHidesFreeCursor(f2_arg2, f2_arg1)
		elseif CoD.ModelUtility.IsGlobalModelValueTrue("VoDViewerFullscreen") and IsPC() then
			SetElementStateByElementName(self, "LiveEventViewerMovieAndBackground", f2_arg1, "DefaultState")
			UpdateButtonPromptState(f2_arg2, f2_local0, f2_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		elseif CoD.ModelUtility.IsGlobalModelValueTrue("VoDViewerFullscreen") then
			SetElementStateByElementName(self, "LiveEventViewerMovieAndBackground", f2_arg1, "DefaultState")
			UpdateButtonPromptState(f2_arg2, f2_local0, f2_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
			MenuHidesFreeCursor(f2_arg2, f2_arg1)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg0, "LiveEventViewer", "currentQuality", function(model)
		UpdateButtonPromptState(f1_local1, self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	if CoD.isPC then
		LiveEventViewerMovieAndBackground.id = "LiveEventViewerMovieAndBackground"
	end
	LiveEventViewerFooterContainer0:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		LiveEventViewerFooterContainer0.id = "LiveEventViewerFooterContainer0"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local5 = self
	if IsPC() then
		CoD.VideoStreamingUtility.VoDViewerPostLoadFunc(self, f1_arg0, f1_arg1)
		CoD.PCUtility.LockUIShortcutInput(f1_local1, f1_arg0)
	else
		CoD.VideoStreamingUtility.VoDViewerPostLoadFunc(self, f1_arg0, f1_arg1)
	end
	return self
end
CoD.VoDViewer.__resetProperties = function(f5_arg0)
	f5_arg0.LiveEventViewerFooterContainer0:completeAnimation()
	f5_arg0.LiveEventViewerFooterContainer0:setLeftRight(0, 1, 0, 0)
	f5_arg0.LiveEventViewerFooterContainer0:setTopBottom(0.5, 1.5, -540, -540)
end
CoD.VoDViewer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.LiveEventViewerFooterContainer0:completeAnimation()
			f6_arg0.LiveEventViewerFooterContainer0:setLeftRight(-0.5, 0.5, 0, 0)
			f6_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -885, 195)
			f6_arg0.clipFinished(f6_arg0.LiveEventViewerFooterContainer0)
		end,
		ShowPrompts = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.LiveEventViewerFooterContainer0:beginAnimation(300)
				f7_arg0.LiveEventViewerFooterContainer0:setTopBottom(0.5, 1.5, -540, -540)
				f7_arg0.LiveEventViewerFooterContainer0:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.LiveEventViewerFooterContainer0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.LiveEventViewerFooterContainer0:completeAnimation()
			f7_arg0.LiveEventViewerFooterContainer0:setLeftRight(0, 1, 0, 0)
			f7_arg0.LiveEventViewerFooterContainer0:setTopBottom(0.5, 1.5, -345, -345)
			f7_local0(f7_arg0.LiveEventViewerFooterContainer0)
		end,
	},
	ShowPrompts = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.LiveEventViewerFooterContainer0:completeAnimation()
			f9_arg0.LiveEventViewerFooterContainer0:setLeftRight(0, 1, 0, 0)
			f9_arg0.LiveEventViewerFooterContainer0:setTopBottom(0.5, 0.5, -540, 540)
			f9_arg0.clipFinished(f9_arg0.LiveEventViewerFooterContainer0)
		end,
		DefaultState = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.LiveEventViewerFooterContainer0:beginAnimation(300)
				f10_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -885, 195)
				f10_arg0.LiveEventViewerFooterContainer0:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.LiveEventViewerFooterContainer0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.LiveEventViewerFooterContainer0:completeAnimation()
			f10_arg0.LiveEventViewerFooterContainer0:setLeftRight(0, 1, 0, 0)
			f10_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -1080, 0)
			f10_local0(f10_arg0.LiveEventViewerFooterContainer0)
		end,
	},
}
CoD.VoDViewer.__onClose = function(f12_arg0)
	f12_arg0.__on_close_removeOverrides()
	f12_arg0.LiveEventViewerMovieAndBackground:close()
	f12_arg0.LiveEventViewerFooterContainer0:close()
	f12_arg0.MovieSubtitles:close()
end
