require("x64:2675595fa323085")
require("x64:2b3a36f75bb6e0e")
require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.StartMenu_Options_SettingSliderList = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SettingSliderList.__defaultWidth = 324
CoD.StartMenu_Options_SettingSliderList.__defaultHeight = 60
CoD.StartMenu_Options_SettingSliderList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SettingSliderList)
	self.id = "StartMenu_Options_SettingSliderList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local LabelBacking = LUI.UIImage.new(0, 0.61, 0, 0, 0, 0, 0, 55)
	LabelBacking:setRGB(0.13, 0.12, 0.12)
	LabelBacking:setAlpha(0.5)
	self:addElement(LabelBacking)
	self.LabelBacking = LabelBacking
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 198, 0, 0, 0, 55)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 0, 0, 198, 0, 0, 0, 55)
	Corner:setAlpha(0)
	self:addElement(Corner)
	self.Corner = Corner
	local SettingLabel = LUI.UIText.new(0, 1, 5, -129, 0, 0, 17.5, 38.5)
	SettingLabel:setRGB(0.78, 0.74, 0.67)
	SettingLabel:setTTF("ttmussels_regular")
	SettingLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SettingLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	SettingLabel:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SettingLabel:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(SettingLabel)
	self.SettingLabel = SettingLabel
	local OptionCountBorder = LUI.UIImage.new(0, 0.61, 0, 0, 1, 1, -4, 0)
	OptionCountBorder:setRGB(0.3, 0.29, 0.28)
	OptionCountBorder:setAlpha(0.9)
	OptionCountBorder:setImage(RegisterImage(@"uie_hud_core_loadout_panel1"))
	OptionCountBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_631E7B3C72564429"))
	OptionCountBorder:setShaderVector(0, 0, 0, 0.55, 0.13)
	OptionCountBorder:setShaderVector(2, 0, 1, 0, 1)
	OptionCountBorder:setupNineSliceShader(25, 4)
	OptionCountBorder:linkToElementModel(self, "totalOptionsCount", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			OptionCountBorder:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(OptionCountBorder)
	self.OptionCountBorder = OptionCountBorder
	local CurrentOptionBorder = LUI.UIImage.new(0, 0.61, 0, 0, 1, 1, -4, 0)
	CurrentOptionBorder:setRGB(0.8, 0.8, 0.8)
	CurrentOptionBorder:setImage(RegisterImage(@"uie_hud_core_loadout_panel1"))
	CurrentOptionBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_631E7B3C72564429"))
	CurrentOptionBorder:setShaderVector(0, 0, 0, 0.55, 0.13)
	CurrentOptionBorder:setupNineSliceShader(25, 4)
	CurrentOptionBorder:linkToElementModel(self, "totalOptionsCount", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CurrentOptionBorder:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	CurrentOptionBorder:linkToElementModel(self, "index", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CurrentOptionBorder:setShaderVector(2, CoD.OptionsUtility.GetSettingSliderCurrentOptionPip(f1_arg1, self:getModel(), CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	self:addElement(CurrentOptionBorder)
	self.CurrentOptionBorder = CurrentOptionBorder
	local RightArrow = CoD.StartMenu_Options_SettingSliderArrow.new(f1_arg0, f1_arg1, 1, 1, -60, 0, 0, 0, 0, 60)
	RightArrow:setZRot(90)
	RightArrow:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightArrow, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		SendButtonPressToMenuEx(menu, controller, Enum[@"luibutton"][@"lui_key_right"])
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	local LeftArrow = CoD.StartMenu_Options_SettingSliderArrow.new(f1_arg0, f1_arg1, 1, 1, -123, -63, 0, 0, 0, 60)
	LeftArrow:setZRot(-90)
	LeftArrow:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeftArrow, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		SendButtonPressToMenuEx(menu, controller, Enum[@"luibutton"][@"lui_key_left"])
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	self:mergeStateConditions({
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDefault")
			end,
		},
	})
	self:linkToElementModel(self, "isDefault", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isDefault",
		})
	end)
	emptyFocusable.id = "emptyFocusable"
	RightArrow.id = "RightArrow"
	LeftArrow.id = "LeftArrow"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SettingSliderList.__resetProperties = function(f14_arg0)
	f14_arg0.LabelBacking:completeAnimation()
	f14_arg0.Frame:completeAnimation()
	f14_arg0.Corner:completeAnimation()
	f14_arg0.SettingLabel:completeAnimation()
	f14_arg0.CurrentOptionBorder:completeAnimation()
	f14_arg0.LabelBacking:setRGB(0.13, 0.12, 0.12)
	f14_arg0.LabelBacking:setAlpha(0.5)
	f14_arg0.Frame:setAlpha(0)
	f14_arg0.Corner:setAlpha(0)
	f14_arg0.Corner:setScale(1, 1)
	f14_arg0.SettingLabel:setRGB(0.78, 0.74, 0.67)
	f14_arg0.CurrentOptionBorder:setRGB(0.8, 0.8, 0.8)
end
CoD.StartMenu_Options_SettingSliderList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.LabelBacking:completeAnimation()
			f16_arg0.LabelBacking:setRGB(0.78, 0.74, 0.67)
			f16_arg0.LabelBacking:setAlpha(0.2)
			f16_arg0.clipFinished(f16_arg0.LabelBacking)
			f16_arg0.Frame:completeAnimation()
			f16_arg0.Frame:setAlpha(0.6)
			f16_arg0.clipFinished(f16_arg0.Frame)
			f16_arg0.Corner:completeAnimation()
			f16_arg0.Corner:setAlpha(1)
			f16_arg0.Corner:setScale(0.96, 0.88)
			f16_arg0.clipFinished(f16_arg0.Corner)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			local f17_local0 = function(f18_arg0)
				f17_arg0.LabelBacking:beginAnimation(150)
				f17_arg0.LabelBacking:setRGB(0.78, 0.74, 0.67)
				f17_arg0.LabelBacking:setAlpha(0.2)
				f17_arg0.LabelBacking:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.LabelBacking:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.LabelBacking:completeAnimation()
			f17_arg0.LabelBacking:setRGB(0.13, 0.12, 0.12)
			f17_arg0.LabelBacking:setAlpha(0.5)
			f17_local0(f17_arg0.LabelBacking)
			local f17_local1 = function(f19_arg0)
				f17_arg0.Frame:beginAnimation(150)
				f17_arg0.Frame:setAlpha(0.6)
				f17_arg0.Frame:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Frame:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Frame:completeAnimation()
			f17_arg0.Frame:setAlpha(0)
			f17_local1(f17_arg0.Frame)
			local f17_local2 = function(f20_arg0)
				f17_arg0.Corner:beginAnimation(150)
				f17_arg0.Corner:setAlpha(1)
				f17_arg0.Corner:setScale(0.96, 0.88)
				f17_arg0.Corner:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Corner:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Corner:completeAnimation()
			f17_arg0.Corner:setAlpha(0)
			f17_arg0.Corner:setScale(1, 1)
			f17_local2(f17_arg0.Corner)
		end,
	},
	Custom = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.SettingLabel:completeAnimation()
			f21_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f21_arg0.clipFinished(f21_arg0.SettingLabel)
			f21_arg0.CurrentOptionBorder:completeAnimation()
			f21_arg0.CurrentOptionBorder:setRGB(0.93, 0.45, 0.05)
			f21_arg0.clipFinished(f21_arg0.CurrentOptionBorder)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.LabelBacking:completeAnimation()
			f22_arg0.LabelBacking:setRGB(0.78, 0.74, 0.67)
			f22_arg0.LabelBacking:setAlpha(0.2)
			f22_arg0.clipFinished(f22_arg0.LabelBacking)
			f22_arg0.Frame:completeAnimation()
			f22_arg0.Frame:setAlpha(0.6)
			f22_arg0.clipFinished(f22_arg0.Frame)
			f22_arg0.Corner:completeAnimation()
			f22_arg0.Corner:setAlpha(1)
			f22_arg0.Corner:setScale(0.96, 0.88)
			f22_arg0.clipFinished(f22_arg0.Corner)
			f22_arg0.SettingLabel:completeAnimation()
			f22_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f22_arg0.clipFinished(f22_arg0.SettingLabel)
			f22_arg0.CurrentOptionBorder:completeAnimation()
			f22_arg0.CurrentOptionBorder:setRGB(0.93, 0.45, 0.05)
			f22_arg0.clipFinished(f22_arg0.CurrentOptionBorder)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			local f23_local0 = function(f24_arg0)
				f23_arg0.LabelBacking:beginAnimation(150)
				f23_arg0.LabelBacking:setRGB(0.78, 0.74, 0.67)
				f23_arg0.LabelBacking:setAlpha(0.2)
				f23_arg0.LabelBacking:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.LabelBacking:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.LabelBacking:completeAnimation()
			f23_arg0.LabelBacking:setRGB(0.13, 0.12, 0.12)
			f23_arg0.LabelBacking:setAlpha(0.5)
			f23_local0(f23_arg0.LabelBacking)
			local f23_local1 = function(f25_arg0)
				f23_arg0.Frame:beginAnimation(150)
				f23_arg0.Frame:setAlpha(0.6)
				f23_arg0.Frame:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Frame:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Frame:completeAnimation()
			f23_arg0.Frame:setAlpha(0)
			f23_local1(f23_arg0.Frame)
			local f23_local2 = function(f26_arg0)
				f23_arg0.Corner:beginAnimation(150)
				f23_arg0.Corner:setAlpha(1)
				f23_arg0.Corner:setScale(0.96, 0.88)
				f23_arg0.Corner:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Corner:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Corner:completeAnimation()
			f23_arg0.Corner:setAlpha(0)
			f23_arg0.Corner:setScale(1, 1)
			f23_local2(f23_arg0.Corner)
			f23_arg0.SettingLabel:completeAnimation()
			f23_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f23_arg0.clipFinished(f23_arg0.SettingLabel)
			f23_arg0.CurrentOptionBorder:completeAnimation()
			f23_arg0.CurrentOptionBorder:setRGB(0.93, 0.45, 0.05)
			f23_arg0.clipFinished(f23_arg0.CurrentOptionBorder)
		end,
		LoseChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(5)
			local f27_local0 = function(f28_arg0)
				f27_arg0.LabelBacking:beginAnimation(150)
				f27_arg0.LabelBacking:setRGB(0.13, 0.12, 0.12)
				f27_arg0.LabelBacking:setAlpha(0.5)
				f27_arg0.LabelBacking:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.LabelBacking:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.LabelBacking:completeAnimation()
			f27_arg0.LabelBacking:setRGB(0.78, 0.74, 0.67)
			f27_arg0.LabelBacking:setAlpha(0.2)
			f27_local0(f27_arg0.LabelBacking)
			local f27_local1 = function(f29_arg0)
				f27_arg0.Frame:beginAnimation(150)
				f27_arg0.Frame:setAlpha(0)
				f27_arg0.Frame:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.Frame:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.Frame:completeAnimation()
			f27_arg0.Frame:setAlpha(0.6)
			f27_local1(f27_arg0.Frame)
			local f27_local2 = function(f30_arg0)
				f27_arg0.Corner:beginAnimation(150)
				f27_arg0.Corner:setAlpha(0)
				f27_arg0.Corner:setScale(1, 1)
				f27_arg0.Corner:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.Corner:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.Corner:completeAnimation()
			f27_arg0.Corner:setAlpha(1)
			f27_arg0.Corner:setScale(0.96, 0.88)
			f27_local2(f27_arg0.Corner)
			f27_arg0.SettingLabel:completeAnimation()
			f27_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f27_arg0.clipFinished(f27_arg0.SettingLabel)
			f27_arg0.CurrentOptionBorder:completeAnimation()
			f27_arg0.CurrentOptionBorder:setRGB(0.93, 0.45, 0.05)
			f27_arg0.clipFinished(f27_arg0.CurrentOptionBorder)
		end,
	},
}
CoD.StartMenu_Options_SettingSliderList.__onClose = function(f31_arg0)
	f31_arg0.emptyFocusable:close()
	f31_arg0.Frame:close()
	f31_arg0.Corner:close()
	f31_arg0.SettingLabel:close()
	f31_arg0.OptionCountBorder:close()
	f31_arg0.CurrentOptionBorder:close()
	f31_arg0.RightArrow:close()
	f31_arg0.LeftArrow:close()
end
