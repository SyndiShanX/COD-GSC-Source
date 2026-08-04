require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/startmenu/options/flyout/startmenu_options_settingsliderarrow")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmaincorners")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
local PostLoadFunc = function(self, controller, menu)
	if CursorInputEnabledForBuild() then
		self.m_preventFromBeingCurrentMouseFocus = true
		self:setForceMouseEventDispatch(true)
	end
end
CoD.StartMenu_Options_Slider_Control_Item = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Slider_Control_Item.__defaultWidth = 324
CoD.StartMenu_Options_Slider_Control_Item.__defaultHeight = 60
CoD.StartMenu_Options_Slider_Control_Item.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setClass(CoD.StartMenu_Options_Slider_Control_Item)
	self.id = "StartMenu_Options_Slider_Control_Item"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local emptyFocusable = CoD.emptyFocusable.new(f2_arg0, f2_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local LabelBacking = LUI.UIImage.new(0, 0.61, 0, 0, 0, 0, 0, 55)
	LabelBacking:setRGB(0.13, 0.12, 0.12)
	LabelBacking:setAlpha(0.5)
	self:addElement(LabelBacking)
	self.LabelBacking = LabelBacking
	local Frame = CoD.StartMenuOptionsMainFrame.new(f2_arg0, f2_arg1, 0, 0, 0, 198, 0, 0, 0, 55)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f2_arg0, f2_arg1, 0, 0, 0, 198, 0, 0, 0, 55)
	Corner:setAlpha(0)
	self:addElement(Corner)
	self.Corner = Corner
	local SettingLabel = LUI.UIText.new(0, 1, 5, -129, 0, 0, 11.5, 41.5)
	SettingLabel:setRGB(0.78, 0.74, 0.67)
	SettingLabel:setTTF("ttmussels_regular")
	SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	SettingLabel:linkToElementModel(self, "text", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SettingLabel:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(SettingLabel)
	self.SettingLabel = SettingLabel
	local OptionCountBorder = LUI.UIImage.new(0, 0.61, 0, 0, 1, 1, -4, 0)
	OptionCountBorder:setRGB(0.3, 0.29, 0.28)
	OptionCountBorder:setAlpha(0.9)
	OptionCountBorder:setImage(RegisterImage("uie_hud_core_loadout_panel1"))
	OptionCountBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_631E7B3C72564429"))
	OptionCountBorder:setShaderVector(0, 0, 0, 0.55, 0.13)
	OptionCountBorder:setShaderVector(2, 0, 1, 0, 1)
	OptionCountBorder:setupNineSliceShader(25, 4)
	OptionCountBorder:linkToElementModel(self, "totalOptionsCount", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			OptionCountBorder:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	self:addElement(OptionCountBorder)
	self.OptionCountBorder = OptionCountBorder
	local CurrentOptionBorder = LUI.UIImage.new(0, 0.61, 0, 0, 1, 1, -4, 0)
	CurrentOptionBorder:setRGB(0.8, 0.8, 0.8)
	CurrentOptionBorder:setImage(RegisterImage("uie_hud_core_loadout_panel1"))
	CurrentOptionBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_631E7B3C72564429"))
	CurrentOptionBorder:setShaderVector(0, 0, 0, 0.55, 0.13)
	CurrentOptionBorder:setupNineSliceShader(25, 4)
	CurrentOptionBorder:linkToElementModel(self, "totalOptionsCount", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CurrentOptionBorder:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	CurrentOptionBorder:linkToElementModel(self, "index", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CurrentOptionBorder:setShaderVector(2, CoD.OptionsUtility.GetSettingSliderCurrentOptionPip(f2_arg1, self:getModel(), CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	self:addElement(CurrentOptionBorder)
	self.CurrentOptionBorder = CurrentOptionBorder
	local RightArrow = CoD.StartMenu_Options_SettingSliderArrow.new(f2_arg0, f2_arg1, 1, 1, -60, 0, 0, 0, 0, 60)
	RightArrow:setZRot(90)
	RightArrow:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_arg0, f2_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f2_arg0:AddButtonCallbackFunction(RightArrow, f2_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		SendButtonPressToMenuEx(f8_arg1, f8_arg2, Enum.LUIButton[@"lui_key_right"])
		return true
	end, function(f9_arg0, f9_arg1, f9_arg2)
		CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	local LeftArrow = CoD.StartMenu_Options_SettingSliderArrow.new(f2_arg0, f2_arg1, 1, 1, -123, -63, 0, 0, 0, 60)
	LeftArrow:setZRot(-90)
	LeftArrow:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_arg0, f2_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f10_local0
	end)
	f2_arg0:AddButtonCallbackFunction(LeftArrow, f2_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		SendButtonPressToMenuEx(f11_arg1, f11_arg2, Enum.LUIButton[@"lui_key_left"])
		return true
	end, function(f12_arg0, f12_arg1, f12_arg2)
		CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	emptyFocusable.id = "emptyFocusable"
	RightArrow.id = "RightArrow"
	LeftArrow.id = "LeftArrow"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	local f2_local10 = self
	CallCustomElementFunction_Element(self, "setForceMouseEventDispatch", true)
	return self
end
CoD.StartMenu_Options_Slider_Control_Item.__onClose = function(f13_arg0)
	f13_arg0.emptyFocusable:close()
	f13_arg0.Frame:close()
	f13_arg0.Corner:close()
	f13_arg0.SettingLabel:close()
	f13_arg0.OptionCountBorder:close()
	f13_arg0.CurrentOptionBorder:close()
	f13_arg0.RightArrow:close()
	f13_arg0.LeftArrow:close()
end
