require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmaincorners")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
CoD.StartMenu_Options_SettingSliderArrow = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SettingSliderArrow.__defaultWidth = 60
CoD.StartMenu_Options_SettingSliderArrow.__defaultHeight = 60
CoD.StartMenu_Options_SettingSliderArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SettingSliderArrow)
	self.id = "StartMenu_Options_SettingSliderArrow"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.13, 0.12, 0.12)
	Backing:setAlpha(0.6)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Corner)
	self.Corner = Corner
	local Arrow = LUI.UIImage.new(0.5, 0.5, -10, 10, 0.5, 0.5, -20, 20)
	Arrow:setRGB(0.78, 0.74, 0.67)
	Arrow:setZRot(90)
	Arrow:setImage(RegisterImage("uie_ui_menu_social_common_arrow"))
	Arrow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local Unlimited = nil
	Unlimited = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	Unlimited:setRGB(0.78, 0.74, 0.67)
	Unlimited:setAlpha(0)
	Unlimited:setImage(RegisterImage("uie_ui_pc_unlimited_button"))
	Unlimited:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Unlimited)
	self.Unlimited = Unlimited
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Unlimited",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SettingSliderArrow.__resetProperties = function(f4_arg0)
	f4_arg0.Frame:completeAnimation()
	f4_arg0.Backing:completeAnimation()
	f4_arg0.Corner:completeAnimation()
	f4_arg0.Arrow:completeAnimation()
	f4_arg0.Unlimited:completeAnimation()
	f4_arg0.Frame:setRGB(0.78, 0.74, 0.67)
	f4_arg0.Frame:setAlpha(0.04)
	f4_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f4_arg0.Backing:setAlpha(0.6)
	f4_arg0.Corner:setScale(1, 1)
	f4_arg0.Arrow:setRGB(0.78, 0.74, 0.67)
	f4_arg0.Arrow:setAlpha(1)
	f4_arg0.Unlimited:setAlpha(0)
end
CoD.StartMenu_Options_SettingSliderArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Frame:completeAnimation()
			f5_arg0.Frame:setRGB(1, 1, 1)
			f5_arg0.clipFinished(f5_arg0.Frame)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Backing:beginAnimation(150)
				f6_arg0.Backing:setAlpha(0.2)
				f6_arg0.Backing:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Backing:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f6_arg0.Backing:setAlpha(0.1)
			f6_local0(f6_arg0.Backing)
			local f6_local1 = function(f8_arg0)
				f6_arg0.Frame:beginAnimation(150)
				f6_arg0.Frame:setAlpha(0.6)
				f6_arg0.Frame:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Frame:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Frame:completeAnimation()
			f6_arg0.Frame:setAlpha(0.04)
			f6_local1(f6_arg0.Frame)
			local f6_local2 = function(f9_arg0)
				f6_arg0.Corner:beginAnimation(150)
				f6_arg0.Corner:setScale(0.9, 0.9)
				f6_arg0.Corner:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Corner:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Corner:completeAnimation()
			f6_arg0.Corner:setScale(1, 1)
			f6_local2(f6_arg0.Corner)
		end,
	},
	Unavailable = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setRGB(0, 0, 0)
			f10_arg0.Backing:setAlpha(0.4)
			f10_arg0.clipFinished(f10_arg0.Backing)
			f10_arg0.Arrow:completeAnimation()
			f10_arg0.Arrow:setRGB(0.31, 0.31, 0.31)
			f10_arg0.Arrow:setAlpha(0.6)
			f10_arg0.clipFinished(f10_arg0.Arrow)
		end,
	},
	Unlimited = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Frame:completeAnimation()
			f11_arg0.Frame:setRGB(1, 1, 1)
			f11_arg0.clipFinished(f11_arg0.Frame)
			f11_arg0.Arrow:completeAnimation()
			f11_arg0.Arrow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Arrow)
			f11_arg0.Unlimited:completeAnimation()
			f11_arg0.Unlimited:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Unlimited)
		end,
		Focus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Backing:beginAnimation(150)
				f12_arg0.Backing:setAlpha(0.2)
				f12_arg0.Backing:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Backing:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f12_arg0.Backing:setAlpha(0.1)
			f12_local0(f12_arg0.Backing)
			local f12_local1 = function(f14_arg0)
				f12_arg0.Frame:beginAnimation(150)
				f12_arg0.Frame:setAlpha(0.6)
				f12_arg0.Frame:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Frame:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Frame:completeAnimation()
			f12_arg0.Frame:setAlpha(0.04)
			f12_local1(f12_arg0.Frame)
			local f12_local2 = function(f15_arg0)
				f12_arg0.Corner:beginAnimation(150)
				f12_arg0.Corner:setScale(0.9, 0.9)
				f12_arg0.Corner:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Corner:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Corner:completeAnimation()
			f12_arg0.Corner:setScale(1, 1)
			f12_local2(f12_arg0.Corner)
			f12_arg0.Arrow:completeAnimation()
			f12_arg0.Arrow:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Arrow)
			f12_arg0.Unlimited:completeAnimation()
			f12_arg0.Unlimited:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Unlimited)
		end,
	},
}
CoD.StartMenu_Options_SettingSliderArrow.__onClose = function(f16_arg0)
	f16_arg0.Frame:close()
	f16_arg0.Corner:close()
end
