require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.PC_MOTD_Buttons = InheritFrom(LUI.UIElement)
CoD.PC_MOTD_Buttons.__defaultWidth = 240
CoD.PC_MOTD_Buttons.__defaultHeight = 80
CoD.PC_MOTD_Buttons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_MOTD_Buttons)
	self.id = "PC_MOTD_Buttons"
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
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, self, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_MOTD_Buttons.__resetProperties = function(f8_arg0)
	f8_arg0.Backing:completeAnimation()
	f8_arg0.Corner:completeAnimation()
	f8_arg0.Frame:completeAnimation()
	f8_arg0.Icon:completeAnimation()
	f8_arg0.OptionText:completeAnimation()
	f8_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f8_arg0.Backing:setAlpha(0.6)
	f8_arg0.Corner:setAlpha(1)
	f8_arg0.Corner:setScale(1, 1)
	f8_arg0.Frame:setAlpha(0.04)
	f8_arg0.Icon:setAlpha(0)
	f8_arg0.OptionText:setAlpha(0.9)
end
CoD.PC_MOTD_Buttons.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f10_arg0.Backing:setAlpha(0.1)
			f10_arg0.clipFinished(f10_arg0.Backing)
			f10_arg0.Frame:completeAnimation()
			f10_arg0.Frame:setAlpha(0.6)
			f10_arg0.clipFinished(f10_arg0.Frame)
			f10_arg0.Corner:completeAnimation()
			f10_arg0.Corner:setScale(0.97, 0.9)
			f10_arg0.clipFinished(f10_arg0.Corner)
		end,
		GainFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Backing:beginAnimation(150)
				f11_arg0.Backing:setRGB(0.78, 0.74, 0.67)
				f11_arg0.Backing:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Backing:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setRGB(0.13, 0.12, 0.12)
			f11_arg0.Backing:setAlpha(0.1)
			f11_local0(f11_arg0.Backing)
			local f11_local1 = function(f13_arg0)
				f11_arg0.Frame:beginAnimation(150)
				f11_arg0.Frame:setAlpha(0.6)
				f11_arg0.Frame:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Frame:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Frame:completeAnimation()
			f11_arg0.Frame:setAlpha(0.04)
			f11_local1(f11_arg0.Frame)
			local f11_local2 = function(f14_arg0)
				f11_arg0.Corner:beginAnimation(150)
				f11_arg0.Corner:setScale(0.97, 0.9)
				f11_arg0.Corner:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Corner:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Corner:completeAnimation()
			f11_arg0.Corner:setScale(1, 1)
			f11_local2(f11_arg0.Corner)
		end,
		LoseFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			local f15_local0 = function(f16_arg0)
				f15_arg0.Backing:beginAnimation(150)
				f15_arg0.Backing:setRGB(0.13, 0.12, 0.12)
				f15_arg0.Backing:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Backing:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Backing:completeAnimation()
			f15_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f15_arg0.Backing:setAlpha(0.1)
			f15_local0(f15_arg0.Backing)
			local f15_local1 = function(f17_arg0)
				f15_arg0.Frame:beginAnimation(150)
				f15_arg0.Frame:setAlpha(0.04)
				f15_arg0.Frame:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Frame:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Frame:completeAnimation()
			f15_arg0.Frame:setAlpha(0.6)
			f15_local1(f15_arg0.Frame)
			local f15_local2 = function(f18_arg0)
				f15_arg0.Corner:beginAnimation(150)
				f15_arg0.Corner:setScale(1, 1)
				f15_arg0.Corner:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Corner:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Corner:completeAnimation()
			f15_arg0.Corner:setScale(0.97, 0.9)
			f15_local2(f15_arg0.Corner)
		end,
	},
	Disabled = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Backing)
			f19_arg0.Frame:completeAnimation()
			f19_arg0.Frame:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Frame)
			f19_arg0.Corner:completeAnimation()
			f19_arg0.Corner:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Corner)
			f19_arg0.Icon:completeAnimation()
			f19_arg0.Icon:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Icon)
			f19_arg0.OptionText:completeAnimation()
			f19_arg0.OptionText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.OptionText)
		end,
	},
}
CoD.PC_MOTD_Buttons.__onClose = function(f20_arg0)
	f20_arg0.Frame:close()
	f20_arg0.Corner:close()
	f20_arg0.Icon:close()
	f20_arg0.OptionText:close()
end
