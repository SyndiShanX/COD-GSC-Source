require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.PC_EULA_Buttons = InheritFrom(LUI.UIElement)
CoD.PC_EULA_Buttons.__defaultWidth = 240
CoD.PC_EULA_Buttons.__defaultHeight = 80
CoD.PC_EULA_Buttons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_EULA_Buttons)
	self.id = "PC_EULA_Buttons"
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
	local Icon = LUI.UIImage.new(0, 0, 10, 42, 0, 0, 11, 43)
	Icon:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Icon:setAlpha(0)
	Icon:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local OptionText = LUI.UIText.new(0.03, 0.97, 0, 0, 0.31, 0.69, 0, 0)
	OptionText:setRGB(0.78, 0.74, 0.67)
	OptionText:setAlpha(0.9)
	OptionText:setTTF("ttmussels_regular")
	OptionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	OptionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	OptionText:linkToElementModel(self, "displayText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			OptionText:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(OptionText)
	self.OptionText = OptionText
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_EULA_Buttons.__resetProperties = function(f6_arg0)
	f6_arg0.Backing:completeAnimation()
	f6_arg0.Corner:completeAnimation()
	f6_arg0.Frame:completeAnimation()
	f6_arg0.OptionText:completeAnimation()
	f6_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f6_arg0.Backing:setAlpha(0.6)
	f6_arg0.Corner:setScale(1, 1)
	f6_arg0.Frame:setAlpha(0.04)
	f6_arg0.OptionText:setRGB(0.78, 0.74, 0.67)
	f6_arg0.OptionText:setAlpha(0.9)
end
CoD.PC_EULA_Buttons.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f8_arg0.Backing:setAlpha(0.1)
			f8_arg0.clipFinished(f8_arg0.Backing)
			f8_arg0.Frame:completeAnimation()
			f8_arg0.Frame:setAlpha(0.6)
			f8_arg0.clipFinished(f8_arg0.Frame)
			f8_arg0.Corner:completeAnimation()
			f8_arg0.Corner:setScale(0.97, 0.9)
			f8_arg0.clipFinished(f8_arg0.Corner)
		end,
		GainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Backing:beginAnimation(150)
				f9_arg0.Backing:setRGB(0.78, 0.74, 0.67)
				f9_arg0.Backing:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Backing:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Backing:completeAnimation()
			f9_arg0.Backing:setRGB(0.13, 0.12, 0.12)
			f9_arg0.Backing:setAlpha(0.1)
			f9_local0(f9_arg0.Backing)
			local f9_local1 = function(f11_arg0)
				f9_arg0.Frame:beginAnimation(150)
				f9_arg0.Frame:setAlpha(0.6)
				f9_arg0.Frame:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Frame:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Frame:completeAnimation()
			f9_arg0.Frame:setAlpha(0.04)
			f9_local1(f9_arg0.Frame)
			local f9_local2 = function(f12_arg0)
				f9_arg0.Corner:beginAnimation(150)
				f9_arg0.Corner:setScale(0.97, 0.9)
				f9_arg0.Corner:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Corner:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Corner:completeAnimation()
			f9_arg0.Corner:setScale(1, 1)
			f9_local2(f9_arg0.Corner)
		end,
		LoseFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				f13_arg0.Backing:beginAnimation(150)
				f13_arg0.Backing:setRGB(0.13, 0.12, 0.12)
				f13_arg0.Backing:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Backing:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Backing:completeAnimation()
			f13_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f13_arg0.Backing:setAlpha(0.1)
			f13_local0(f13_arg0.Backing)
			local f13_local1 = function(f15_arg0)
				f13_arg0.Frame:beginAnimation(150)
				f13_arg0.Frame:setAlpha(0.04)
				f13_arg0.Frame:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Frame:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Frame:completeAnimation()
			f13_arg0.Frame:setAlpha(0.6)
			f13_local1(f13_arg0.Frame)
			local f13_local2 = function(f16_arg0)
				f13_arg0.Corner:beginAnimation(150)
				f13_arg0.Corner:setScale(1, 1)
				f13_arg0.Corner:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Corner:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Corner:completeAnimation()
			f13_arg0.Corner:setScale(0.97, 0.9)
			f13_local2(f13_arg0.Corner)
		end,
	},
	Disabled = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.Backing:completeAnimation()
			f17_arg0.Backing:setAlpha(0.4)
			f17_arg0.clipFinished(f17_arg0.Backing)
			f17_arg0.OptionText:completeAnimation()
			f17_arg0.OptionText:setRGB(0.31, 0.31, 0.31)
			f17_arg0.OptionText:setAlpha(0.6)
			f17_arg0.clipFinished(f17_arg0.OptionText)
		end,
	},
}
CoD.PC_EULA_Buttons.__onClose = function(f18_arg0)
	f18_arg0.Frame:close()
	f18_arg0.Corner:close()
	f18_arg0.Icon:close()
	f18_arg0.OptionText:close()
end
