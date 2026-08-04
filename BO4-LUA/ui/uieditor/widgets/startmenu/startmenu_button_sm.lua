require("ui/uieditor/widgets/startmenu/options/startmenubuttonsmcontainer")
CoD.StartMenu_Button_SM = InheritFrom(LUI.UIElement)
CoD.StartMenu_Button_SM.__defaultWidth = 500
CoD.StartMenu_Button_SM.__defaultHeight = 500
CoD.StartMenu_Button_SM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Button_SM)
	self.id = "StartMenu_Button_SM"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuOptionsSubFrame = CoD.StartMenuButtonSmContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuOptionsSubFrame)
	self.StartMenuOptionsSubFrame = StartMenuOptionsSubFrame
	local BlackLine = LUI.UIImage.new(0, 1, 4, -4, 0.5, 0.5, -25, 27)
	BlackLine:setRGB(0, 0, 0)
	BlackLine:setAlpha(0)
	self:addElement(BlackLine)
	self.BlackLine = BlackLine
	local LockIcon = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	LockIcon:setAlpha(0)
	LockIcon:setImage(RegisterImage("uie_ui_icon_global_lock"))
	self:addElement(LockIcon)
	self.LockIcon = LockIcon
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "OnlineOnly",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ComingSoon",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	StartMenuOptionsSubFrame.id = "StartMenuOptionsSubFrame"
	self.__defaultFocus = StartMenuOptionsSubFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Button_SM.__resetProperties = function(f6_arg0)
	f6_arg0.StartMenuOptionsSubFrame:completeAnimation()
	f6_arg0.BlackLine:completeAnimation()
	f6_arg0.LockIcon:completeAnimation()
	f6_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
	f6_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
	f6_arg0.StartMenuOptionsSubFrame:setRGB(1, 1, 1)
	f6_arg0.StartMenuOptionsSubFrame:setAlpha(1)
	f6_arg0.StartMenuOptionsSubFrame:setScale(1, 1)
	f6_arg0.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setAlpha(1)
	f6_arg0.BlackLine:setTopBottom(0.5, 0.5, -25, 27)
	f6_arg0.BlackLine:setAlpha(0)
	f6_arg0.LockIcon:setRGB(1, 1, 1)
	f6_arg0.LockIcon:setAlpha(0)
	f6_arg0.LockIcon:setScale(1, 1)
end
CoD.StartMenu_Button_SM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f7_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
			f7_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
			f7_arg0.StartMenuOptionsSubFrame:setScale(1, 1)
			f7_arg0.clipFinished(f7_arg0.StartMenuOptionsSubFrame)
			f7_arg0.BlackLine:completeAnimation()
			f7_arg0.BlackLine:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BlackLine)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f8_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
			f8_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
			f8_arg0.StartMenuOptionsSubFrame:setScale(1.04, 1.04)
			f8_arg0.clipFinished(f8_arg0.StartMenuOptionsSubFrame)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.StartMenuOptionsSubFrame:beginAnimation(200)
				f9_arg0.StartMenuOptionsSubFrame:setScale(1.04, 1.04)
				f9_arg0.StartMenuOptionsSubFrame:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.StartMenuOptionsSubFrame:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f9_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
			f9_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
			f9_arg0.StartMenuOptionsSubFrame:setScale(1, 1)
			f9_local0(f9_arg0.StartMenuOptionsSubFrame)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.StartMenuOptionsSubFrame:beginAnimation(200)
				f11_arg0.StartMenuOptionsSubFrame:setScale(1, 1)
				f11_arg0.StartMenuOptionsSubFrame:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.StartMenuOptionsSubFrame:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f11_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
			f11_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
			f11_arg0.StartMenuOptionsSubFrame:setScale(1.04, 1.04)
			f11_local0(f11_arg0.StartMenuOptionsSubFrame)
		end,
	},
	Disabled = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f13_arg0.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:completeAnimation()
			f13_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
			f13_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
			f13_arg0.StartMenuOptionsSubFrame:setRGB(0.33, 0.33, 0.33)
			f13_arg0.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.StartMenuOptionsSubFrame)
			f13_arg0.BlackLine:completeAnimation()
			f13_arg0.BlackLine:setTopBottom(0.5, 0.5, -25, 27)
			f13_arg0.BlackLine:setAlpha(0.5)
			f13_arg0.clipFinished(f13_arg0.BlackLine)
			f13_arg0.LockIcon:completeAnimation()
			f13_arg0.LockIcon:setRGB(1, 1, 1)
			f13_arg0.LockIcon:setAlpha(0.1)
			f13_arg0.LockIcon:setScale(0.75, 0.75)
			f13_arg0.clipFinished(f13_arg0.LockIcon)
		end,
		Childfocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f14_arg0.StartMenuOptionsSubFrame:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.StartMenuOptionsSubFrame)
			f14_arg0.BlackLine:completeAnimation()
			f14_arg0.BlackLine:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BlackLine)
			local f14_local0 = function(f15_arg0)
				f14_arg0.LockIcon:beginAnimation(180)
				f14_arg0.LockIcon:setAlpha(0.1)
				f14_arg0.LockIcon:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.LockIcon:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.LockIcon:completeAnimation()
			f14_arg0.LockIcon:setAlpha(0.02)
			f14_local0(f14_arg0.LockIcon)
		end,
	},
	OnlineOnly = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f16_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
			f16_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
			f16_arg0.clipFinished(f16_arg0.StartMenuOptionsSubFrame)
			f16_arg0.BlackLine:completeAnimation()
			f16_arg0.BlackLine:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.BlackLine)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f17_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
			f17_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
			f17_arg0.StartMenuOptionsSubFrame:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.StartMenuOptionsSubFrame)
			f17_arg0.BlackLine:completeAnimation()
			f17_arg0.BlackLine:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.BlackLine)
		end,
	},
	ComingSoon = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.StartMenuOptionsSubFrame:completeAnimation()
			f18_arg0.StartMenuOptionsSubFrame:setLeftRight(0, 1, 0, 0)
			f18_arg0.StartMenuOptionsSubFrame:setTopBottom(0, 1, 0, 0)
			f18_arg0.clipFinished(f18_arg0.StartMenuOptionsSubFrame)
			f18_arg0.BlackLine:completeAnimation()
			f18_arg0.BlackLine:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.BlackLine)
		end,
	},
}
CoD.StartMenu_Button_SM.__onClose = function(f19_arg0)
	f19_arg0.StartMenuOptionsSubFrame:close()
end
