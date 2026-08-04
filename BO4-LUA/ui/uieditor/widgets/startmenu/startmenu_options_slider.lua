require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmaincorners")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
require("ui/uieditor/widgets/startmenu/startmenu_options_slider_control_item")
require("ui/uieditor/widgets/common/commonfocusbrackets")
CoD.StartMenu_Options_Slider = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Slider.__defaultWidth = 600
CoD.StartMenu_Options_Slider.__defaultHeight = 60
CoD.StartMenu_Options_Slider.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Slider)
	self.id = "StartMenu_Options_Slider"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusGlow = nil
	FocusGlow = LUI.UIImage.new(0, 1, -79, 79, 0, 1, -30, 30)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage("uie_ui_menu_common_focus_glow_small"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0, 0)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(160, 100)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local LabelBacking = LUI.UIImage.new(0, 0, 0, 274, 0, 0, 0, 60)
	LabelBacking:setRGB(0.13, 0.12, 0.12)
	LabelBacking:setAlpha(0.5)
	self:addElement(LabelBacking)
	self.LabelBacking = LabelBacking
	local ButtonBacking = LUI.UIImage.new(0, 0, 276, 600, 0, 0, 0, 60)
	ButtonBacking:setRGB(0.13, 0.12, 0.12)
	ButtonBacking:setAlpha(0)
	self:addElement(ButtonBacking)
	self.ButtonBacking = ButtonBacking
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 274, 0, 0, 0, 60)
	Frame:setAlpha(0.01)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 0, 0, 274, 0, 0, 0, 60)
	Corner:setAlpha(0)
	self:addElement(Corner)
	self.Corner = Corner
	local SettingLabel = LUI.UIText.new(0, 0, 16, 267, 0, 0, 17.5, 38.5)
	SettingLabel:setRGB(0.78, 0.74, 0.67)
	SettingLabel:setTTF("ttmussels_regular")
	SettingLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	SettingLabel:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	SettingLabel:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SettingLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(SettingLabel)
	self.SettingLabel = SettingLabel
	local ButtonLabel = LUI.UIText.new(0, 0, 283.5, 593.5, 0, 0, 17.5, 38.5)
	ButtonLabel:setRGB(0.78, 0.74, 0.67)
	ButtonLabel:setAlpha(0)
	ButtonLabel:setTTF("ttmussels_regular")
	ButtonLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	ButtonLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	ButtonLabel:linkToElementModel(self, "altText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ButtonLabel:setText(CoD.BaseUtility.LocalizeIfXHash(f3_local0))
		end
	end)
	self:addElement(ButtonLabel)
	self.ButtonLabel = ButtonLabel
	local Slider = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, true, false, false, false)
	Slider:setLeftRight(0, 0, 276, 600)
	Slider:setTopBottom(0, 0, 0, 60)
	Slider:setWidgetType(CoD.StartMenu_Options_Slider_Control_Item)
	Slider:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Slider:linkToElementModel(self, "optionsDatasource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Slider:setDataSource(f4_local0)
		end
	end)
	Slider:linkToElementModel(Slider, "alias", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"])
	end)
	Slider:registerEventHandler("list_active_changed", function(element, event)
		local f6_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		return f6_local0
	end)
	Slider:registerEventHandler("list_item_lose_focus", function(element, event)
		local f7_local0 = nil
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "alias") then
			StopMPMusicPreview(f1_arg1, element)
		end
		return f7_local0
	end)
	Slider:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Slider, f1_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], "P", function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f9_arg0, f9_arg2, "alias") then
			StopMPMusicPreview(f9_arg2, f9_arg0)
			PlayMPMusicPreview(f9_arg2, f9_arg0)
			return true
		else
		end
	end, function(f10_arg0, f10_arg1, f10_arg2)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(f10_arg0, f10_arg2, "alias") then
			CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xby_pstriangle"], "menu/play_music_sample", nil, "P")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Slider)
	self.Slider = Slider
	local FrameSelected = nil
	FrameSelected = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	FrameSelected:setAlpha(0)
	FrameSelected:setImage(RegisterImage("uie_ui_menu_store_focus_frame"))
	FrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	FrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrameSelected:setupNineSliceShader(8, 8)
	self:addElement(FrameSelected)
	self.FrameSelected = FrameSelected
	local FocusBrackets = nil
	FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -10, 10, 0, 1, -10, 10)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local SelectorOverlay = nil
	SelectorOverlay = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	SelectorOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlay:setAlpha(0)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	self:mergeStateConditions({
		{
			stateName = "ButtonPC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "altText") and IsPC()
			end,
		},
		{
			stateName = "Button",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "altText")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "altText", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "altText",
		})
	end)
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f16_arg2, f16_arg3, f16_arg4)
		if IsInDefaultState(element) and CoD.ModelUtility.IsSelfModelPathNil(element, controller, "action") and IsSelfPropertyValue(self, "action", nil) then
			DisableMouseButton(self, controller)
		end
	end)
	emptyFocusable.id = "emptyFocusable"
	Slider.id = "Slider"
	self.__defaultFocus = Slider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local13 = self
	CoD.GridAndListUtility.AddRightStickSingleItemControl(f1_arg0, Slider, f1_arg1)
	return self
end
CoD.StartMenu_Options_Slider.__resetProperties = function(f17_arg0)
	f17_arg0.Slider:completeAnimation()
	f17_arg0.ButtonLabel:completeAnimation()
	f17_arg0.ButtonBacking:completeAnimation()
	f17_arg0.FocusBrackets:completeAnimation()
	f17_arg0.FocusGlow:completeAnimation()
	f17_arg0.FrameSelected:completeAnimation()
	f17_arg0.SelectorOverlay:completeAnimation()
	f17_arg0.Slider:setAlpha(1)
	f17_arg0.ButtonLabel:setAlpha(0)
	f17_arg0.ButtonBacking:setAlpha(0)
	f17_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
	f17_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
	f17_arg0.FocusBrackets:setAlpha(0)
	f17_arg0.FocusGlow:setAlpha(0)
	f17_arg0.FrameSelected:setAlpha(0)
	f17_arg0.SelectorOverlay:setAlpha(0)
end
CoD.StartMenu_Options_Slider.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.Slider:completeAnimation()
			f18_arg0.Slider:setAlpha(0.7)
			f18_arg0.clipFinished(f18_arg0.Slider)
		end,
	},
	ButtonPC = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.ButtonBacking:completeAnimation()
			f19_arg0.ButtonBacking:setAlpha(0.5)
			f19_arg0.clipFinished(f19_arg0.ButtonBacking)
			f19_arg0.ButtonLabel:completeAnimation()
			f19_arg0.ButtonLabel:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.ButtonLabel)
			f19_arg0.Slider:completeAnimation()
			f19_arg0.Slider:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Slider)
			f19_arg0.FocusBrackets:completeAnimation()
			f19_arg0.FocusBrackets:setLeftRight(0, 1, -20, 20)
			f19_arg0.FocusBrackets:setTopBottom(0, 1, -20, 20)
			f19_arg0.FocusBrackets:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.FocusBrackets)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(7)
			f20_arg0.FocusGlow:completeAnimation()
			f20_arg0.FocusGlow:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FocusGlow)
			f20_arg0.ButtonBacking:completeAnimation()
			f20_arg0.ButtonBacking:setAlpha(0.5)
			f20_arg0.clipFinished(f20_arg0.ButtonBacking)
			f20_arg0.ButtonLabel:completeAnimation()
			f20_arg0.ButtonLabel:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ButtonLabel)
			f20_arg0.Slider:completeAnimation()
			f20_arg0.Slider:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Slider)
			f20_arg0.FrameSelected:completeAnimation()
			f20_arg0.FrameSelected:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FrameSelected)
			f20_arg0.FocusBrackets:completeAnimation()
			f20_arg0.FocusBrackets:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FocusBrackets)
			f20_arg0.SelectorOverlay:completeAnimation()
			f20_arg0.SelectorOverlay:setAlpha(0.03)
			f20_arg0.clipFinished(f20_arg0.SelectorOverlay)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(7)
			local f21_local0 = function(f22_arg0)
				f21_arg0.FocusGlow:beginAnimation(150)
				f21_arg0.FocusGlow:setAlpha(1)
				f21_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.FocusGlow:completeAnimation()
			f21_arg0.FocusGlow:setAlpha(0)
			f21_local0(f21_arg0.FocusGlow)
			f21_arg0.ButtonBacking:completeAnimation()
			f21_arg0.ButtonBacking:setAlpha(0.5)
			f21_arg0.clipFinished(f21_arg0.ButtonBacking)
			f21_arg0.ButtonLabel:completeAnimation()
			f21_arg0.ButtonLabel:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ButtonLabel)
			f21_arg0.Slider:completeAnimation()
			f21_arg0.Slider:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Slider)
			local f21_local1 = function(f23_arg0)
				f21_arg0.FrameSelected:beginAnimation(150)
				f21_arg0.FrameSelected:setAlpha(1)
				f21_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.FrameSelected:completeAnimation()
			f21_arg0.FrameSelected:setAlpha(0)
			f21_local1(f21_arg0.FrameSelected)
			local f21_local2 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(50)
					f25_arg0:setLeftRight(0, 1, -10, 10)
					f25_arg0:setTopBottom(0, 1, -10, 10)
					f25_arg0:setAlpha(1)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.FocusBrackets:beginAnimation(100)
				f21_arg0.FocusBrackets:setLeftRight(0, 1, -7, 7)
				f21_arg0.FocusBrackets:setTopBottom(0, 1, -7, 7)
				f21_arg0.FocusBrackets:setAlpha(0.67)
				f21_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f21_arg0.FocusBrackets:completeAnimation()
			f21_arg0.FocusBrackets:setLeftRight(0, 1, -20, 20)
			f21_arg0.FocusBrackets:setTopBottom(0, 1, -20, 20)
			f21_arg0.FocusBrackets:setAlpha(0)
			f21_local2(f21_arg0.FocusBrackets)
			local f21_local3 = function(f26_arg0)
				f21_arg0.SelectorOverlay:beginAnimation(150)
				f21_arg0.SelectorOverlay:setAlpha(0.03)
				f21_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.SelectorOverlay:completeAnimation()
			f21_arg0.SelectorOverlay:setAlpha(0)
			f21_local3(f21_arg0.SelectorOverlay)
		end,
		LoseChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(7)
			local f27_local0 = function(f28_arg0)
				f27_arg0.FocusGlow:beginAnimation(150)
				f27_arg0.FocusGlow:setAlpha(0)
				f27_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.FocusGlow:completeAnimation()
			f27_arg0.FocusGlow:setAlpha(1)
			f27_local0(f27_arg0.FocusGlow)
			f27_arg0.ButtonBacking:completeAnimation()
			f27_arg0.ButtonBacking:setAlpha(0.5)
			f27_arg0.clipFinished(f27_arg0.ButtonBacking)
			f27_arg0.ButtonLabel:completeAnimation()
			f27_arg0.ButtonLabel:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.ButtonLabel)
			f27_arg0.Slider:completeAnimation()
			f27_arg0.Slider:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Slider)
			local f27_local1 = function(f29_arg0)
				f27_arg0.FrameSelected:beginAnimation(150)
				f27_arg0.FrameSelected:setAlpha(0)
				f27_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.FrameSelected:completeAnimation()
			f27_arg0.FrameSelected:setAlpha(1)
			f27_local1(f27_arg0.FrameSelected)
			local f27_local2 = function(f30_arg0)
				f27_arg0.FocusBrackets:beginAnimation(150)
				f27_arg0.FocusBrackets:setAlpha(0)
				f27_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.FocusBrackets:completeAnimation()
			f27_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f27_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f27_arg0.FocusBrackets:setAlpha(1)
			f27_local2(f27_arg0.FocusBrackets)
			local f27_local3 = function(f31_arg0)
				f27_arg0.SelectorOverlay:beginAnimation(150)
				f27_arg0.SelectorOverlay:setAlpha(0)
				f27_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.SelectorOverlay:completeAnimation()
			f27_arg0.SelectorOverlay:setAlpha(0.03)
			f27_local3(f27_arg0.SelectorOverlay)
		end,
	},
	Button = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(3)
			f32_arg0.ButtonBacking:completeAnimation()
			f32_arg0.ButtonBacking:setAlpha(0.5)
			f32_arg0.clipFinished(f32_arg0.ButtonBacking)
			f32_arg0.ButtonLabel:completeAnimation()
			f32_arg0.ButtonLabel:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.ButtonLabel)
			f32_arg0.Slider:completeAnimation()
			f32_arg0.Slider:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Slider)
		end,
	},
	Disabled = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.Slider:completeAnimation()
			f33_arg0.Slider:setAlpha(0.4)
			f33_arg0.clipFinished(f33_arg0.Slider)
		end,
	},
}
CoD.StartMenu_Options_Slider.__onClose = function(f34_arg0)
	f34_arg0.emptyFocusable:close()
	f34_arg0.Frame:close()
	f34_arg0.Corner:close()
	f34_arg0.SettingLabel:close()
	f34_arg0.ButtonLabel:close()
	f34_arg0.Slider:close()
	f34_arg0.FocusBrackets:close()
end
