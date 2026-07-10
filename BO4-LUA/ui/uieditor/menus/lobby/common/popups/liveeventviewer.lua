require("x64:d2acf2450da8c29")
require("x64:a36f59f783725c4")
require("x64:ee90388406a6f9f")
CoD.LiveEventViewer = InheritFrom(CoD.Menu)
LUI.createMenu.LiveEventViewer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LiveEventViewer", f1_arg0)
	local f1_local1 = self
	CoD.DirectorUtility.LiveEventViewerPreLoad(self, f1_arg0)
	self:setClass(CoD.LiveEventViewer)
	self.soundSet = "Special_widgets"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local LiveEventViewerMovieAndBackground = CoD.LiveEventViewerMovieAndBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	LiveEventViewerMovieAndBackground:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(LiveEventViewerMovieAndBackground)
	self.LiveEventViewerMovieAndBackground = LiveEventViewerMovieAndBackground
	local LiveEventViewerFooterContainer0 = CoD.LiveEventViewerFooterContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -1080, 0)
	self:addElement(LiveEventViewerFooterContainer0)
	self.LiveEventViewerFooterContainer0 = LiveEventViewerFooterContainer0
	local LiveEventViewerStatusWidget0 = CoD.LiveEventViewerStatusWidget.new(f1_local1, f1_arg0, 1, 1, -172, -96, 0, 0, 54, 92)
	self:addElement(LiveEventViewerStatusWidget0)
	self.LiveEventViewerStatusWidget0 = LiveEventViewerStatusWidget0
	self.__on_menuOpened_self = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = self
		SetElementStateByElementName(self, "LiveEventViewerMovieAndBackground", f3_arg1, "Windowed")
		UpdateButtonPromptState(f3_arg2, f3_local0, f3_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		MenuHidesFreeCursor(f3_arg2, f3_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg0, "LiveEventViewer", "stream", function(model)
		local f4_local0 = self
		if not CoD.VideoStreamingUtility.HasLiveEvent(f1_arg0) then
			DelayGoBack(f1_local1, f1_arg0, 0)
		end
	end)
	if CoD.isPC then
		LiveEventViewerFooterContainer0.id = "LiveEventViewerFooterContainer0"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = LiveEventViewerFooterContainer0
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
	local f1_local5 = self
	CoD.DirectorUtility.LiveEventViewerPostLoad(self, f1_arg0)
	return self
end
CoD.LiveEventViewer.__resetProperties = function(f6_arg0)
	f6_arg0.LiveEventViewerFooterContainer0:completeAnimation()
	f6_arg0.LiveEventViewerFooterContainer0:setLeftRight(0, 1, 0, 0)
	f6_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -1080, 0)
end
CoD.LiveEventViewer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.LiveEventViewerFooterContainer0:completeAnimation()
			f7_arg0.LiveEventViewerFooterContainer0:setLeftRight(0, 1, 0, 0)
			f7_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -885, 195)
			f7_arg0.clipFinished(f7_arg0.LiveEventViewerFooterContainer0)
		end,
		ShowPrompts = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.LiveEventViewerFooterContainer0:beginAnimation(300)
				f8_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -1080, 0)
				f8_arg0.LiveEventViewerFooterContainer0:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.LiveEventViewerFooterContainer0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.LiveEventViewerFooterContainer0:completeAnimation()
			f8_arg0.LiveEventViewerFooterContainer0:setLeftRight(0, 1, 0, 0)
			f8_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -885, 195)
			f8_local0(f8_arg0.LiveEventViewerFooterContainer0)
		end,
	},
	ShowPrompts = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.LiveEventViewerFooterContainer0:beginAnimation(300)
				f11_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -885, 195)
				f11_arg0.LiveEventViewerFooterContainer0:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LiveEventViewerFooterContainer0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.LiveEventViewerFooterContainer0:completeAnimation()
			f11_arg0.LiveEventViewerFooterContainer0:setLeftRight(0, 1, 0, 0)
			f11_arg0.LiveEventViewerFooterContainer0:setTopBottom(1, 1, -1080, 0)
			f11_local0(f11_arg0.LiveEventViewerFooterContainer0)
		end,
	},
}
CoD.LiveEventViewer.__onClose = function(f13_arg0)
	f13_arg0.__on_close_removeOverrides()
	f13_arg0.LiveEventViewerMovieAndBackground:close()
	f13_arg0.LiveEventViewerFooterContainer0:close()
	f13_arg0.LiveEventViewerStatusWidget0:close()
end
