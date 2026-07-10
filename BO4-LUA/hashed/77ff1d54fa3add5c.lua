require("x64:2675595fa323085")
require("x64:63f19ba54f5d69c")
require("x64:ef0b3a40a4c018f")
CoD.PC_VoDViewerOverlay = InheritFrom(LUI.UIElement)
CoD.PC_VoDViewerOverlay.__defaultWidth = 1920
CoD.PC_VoDViewerOverlay.__defaultHeight = 1080
CoD.PC_VoDViewerOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_VoDViewerOverlay)
	self.id = "PC_VoDViewerOverlay"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PCVoDViewerResizeButton = CoD.PC_VoDViewerOverlayResizeButton.new(f1_arg0, f1_arg1, 0.98, 0.98, -17, 18, 0.98, 0.98, -35, 0)
	PCVoDViewerResizeButton:setAlpha(0)
	PCVoDViewerResizeButton:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCVoDViewerResizeButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.PCWidgetUtility.SetStateOnVideoViewerParent(self, controller, "DefaultState", "Windowed")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCVoDViewerResizeButton)
	self.PCVoDViewerResizeButton = PCVoDViewerResizeButton
	local PCVodViewerQuitButton = CoD.PC_VodViewerQuitButton.new(f1_arg0, f1_arg1, 0.98, 0.98, -34, 16, 0.02, 0.02, 0, 50)
	PCVodViewerQuitButton:setAlpha(0)
	local f1_local3 = PCVodViewerQuitButton
	local emptyFocusable = PCVodViewerQuitButton.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	emptyFocusable(f1_local3, f1_local5.cutsceneSkippable, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PCVodViewerQuitButton:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCVodViewerQuitButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable") then
			CoD.VideoStreamingUtility.SkipVoDViewer(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(PCVodViewerQuitButton)
	self.PCVodViewerQuitButton = PCVodViewerQuitButton
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	PCVoDViewerResizeButton.id = "PCVoDViewerResizeButton"
	PCVodViewerQuitButton.id = "PCVodViewerQuitButton"
	emptyFocusable.id = "emptyFocusable"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_VoDViewerOverlay.__resetProperties = function(f9_arg0)
	f9_arg0.PCVoDViewerResizeButton:completeAnimation()
	f9_arg0.PCVodViewerQuitButton:completeAnimation()
	f9_arg0.PCVoDViewerResizeButton:setLeftRight(0.98, 0.98, -17, 18)
	f9_arg0.PCVoDViewerResizeButton:setTopBottom(0.98, 0.98, -35, 0)
	f9_arg0.PCVoDViewerResizeButton:setAlpha(0)
	f9_arg0.PCVodViewerQuitButton:setLeftRight(0.98, 0.98, -34, 16)
	f9_arg0.PCVodViewerQuitButton:setTopBottom(0.02, 0.02, 0, 50)
	f9_arg0.PCVodViewerQuitButton:setAlpha(0)
end
CoD.PC_VoDViewerOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.PCVoDViewerResizeButton:completeAnimation()
			f10_arg0.clipFinished(f10_arg0.PCVoDViewerResizeButton)
			f10_arg0.PCVodViewerQuitButton:completeAnimation()
			f10_arg0.clipFinished(f10_arg0.PCVodViewerQuitButton)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.PCVoDViewerResizeButton:completeAnimation()
			f11_arg0.PCVoDViewerResizeButton:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.PCVoDViewerResizeButton)
			f11_arg0.PCVodViewerQuitButton:completeAnimation()
			f11_arg0.PCVodViewerQuitButton:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.PCVodViewerQuitButton)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(120)
					f14_arg0:setLeftRight(0.98, 0.98, -17, 18)
					f14_arg0:setTopBottom(0.98, 0.98, -35, 0)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.PCVoDViewerResizeButton:beginAnimation(80)
				f12_arg0.PCVoDViewerResizeButton:setLeftRight(0.98, 0.98, 9.5, 44.5)
				f12_arg0.PCVoDViewerResizeButton:setTopBottom(0.98, 0.98, -7, 28)
				f12_arg0.PCVoDViewerResizeButton:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.PCVoDViewerResizeButton:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.PCVoDViewerResizeButton:completeAnimation()
			f12_arg0.PCVoDViewerResizeButton:setLeftRight(0.98, 0.98, 28.5, 63.5)
			f12_arg0.PCVoDViewerResizeButton:setTopBottom(0.98, 0.98, 11.5, 46.5)
			f12_arg0.PCVoDViewerResizeButton:setAlpha(1)
			f12_local0(f12_arg0.PCVoDViewerResizeButton)
			local f12_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(120)
					f16_arg0:setLeftRight(0.98, 0.98, -34, 16)
					f16_arg0:setTopBottom(0.02, 0.02, 0, 50)
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.PCVodViewerQuitButton:beginAnimation(80)
				f12_arg0.PCVodViewerQuitButton:setLeftRight(0.98, 0.98, -5.5, 44.5)
				f12_arg0.PCVodViewerQuitButton:setTopBottom(0.02, 0.02, -29.5, 20.5)
				f12_arg0.PCVodViewerQuitButton:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.PCVodViewerQuitButton:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f12_arg0.PCVodViewerQuitButton:completeAnimation()
			f12_arg0.PCVodViewerQuitButton:setLeftRight(0.98, 0.98, 38.5, 88.5)
			f12_arg0.PCVodViewerQuitButton:setTopBottom(0.02, 0.02, -71.5, -21.5)
			f12_arg0.PCVodViewerQuitButton:setAlpha(0.4)
			f12_local1(f12_arg0.PCVodViewerQuitButton)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(80)
					f19_arg0:setLeftRight(0.98, 0.98, 28.5, 63.5)
					f19_arg0:setTopBottom(0.98, 0.98, 11.5, 46.5)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.PCVoDViewerResizeButton:beginAnimation(120)
				f17_arg0.PCVoDViewerResizeButton:setLeftRight(0.98, 0.98, 10.5, 45.5)
				f17_arg0.PCVoDViewerResizeButton:setTopBottom(0.98, 0.98, -7, 28)
				f17_arg0.PCVoDViewerResizeButton:setAlpha(0)
				f17_arg0.PCVoDViewerResizeButton:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.PCVoDViewerResizeButton:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.PCVoDViewerResizeButton:completeAnimation()
			f17_arg0.PCVoDViewerResizeButton:setLeftRight(0.98, 0.98, -17, 18)
			f17_arg0.PCVoDViewerResizeButton:setTopBottom(0.98, 0.98, -35, 0)
			f17_arg0.PCVoDViewerResizeButton:setAlpha(1)
			f17_local0(f17_arg0.PCVoDViewerResizeButton)
			local f17_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(80)
					f21_arg0:setLeftRight(0.98, 0.98, 38.5, 88.5)
					f21_arg0:setTopBottom(0.02, 0.02, -71.5, -21.5)
					f21_arg0:setAlpha(0)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.PCVodViewerQuitButton:beginAnimation(120)
				f17_arg0.PCVodViewerQuitButton:setLeftRight(0.98, 0.98, -5.5, 44.5)
				f17_arg0.PCVodViewerQuitButton:setTopBottom(0.02, 0.02, -29.5, 20.5)
				f17_arg0.PCVodViewerQuitButton:setAlpha(0.4)
				f17_arg0.PCVodViewerQuitButton:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.PCVodViewerQuitButton:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f17_arg0.PCVodViewerQuitButton:completeAnimation()
			f17_arg0.PCVodViewerQuitButton:setLeftRight(0.98, 0.98, -34, 16)
			f17_arg0.PCVodViewerQuitButton:setTopBottom(0.02, 0.02, 0, 50)
			f17_arg0.PCVodViewerQuitButton:setAlpha(1)
			f17_local1(f17_arg0.PCVodViewerQuitButton)
		end,
	},
}
CoD.PC_VoDViewerOverlay.__onClose = function(f22_arg0)
	f22_arg0.PCVoDViewerResizeButton:close()
	f22_arg0.PCVodViewerQuitButton:close()
	f22_arg0.emptyFocusable:close()
end
