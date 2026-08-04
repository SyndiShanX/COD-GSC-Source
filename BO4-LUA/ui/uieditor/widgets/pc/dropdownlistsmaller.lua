require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/startmenu/pc_highlightborder")
CoD.DropDownListSmaller = InheritFrom(LUI.UIElement)
CoD.DropDownListSmaller.__defaultWidth = 200
CoD.DropDownListSmaller.__defaultHeight = 32
CoD.DropDownListSmaller.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DropDownListSmaller)
	self.id = "DropDownListSmaller"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackgroundDropDown = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundDropDown:setRGB(0.12, 0.12, 0.12)
	BackgroundDropDown:setAlpha(0.8)
	self:addElement(BackgroundDropDown)
	self.BackgroundDropDown = BackgroundDropDown
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	local Arrow = LUI.UIImage.new(1, 1, -30, 0, 0.5, 0.5, -15, 15)
	Arrow:setZRot(-90)
	Arrow:setScale(0.4, 0.4)
	Arrow:setImage(RegisterImage("uie_optionswidgets_arrow"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local TextBox = LUI.UIText.new(0.02, 0.02, 0, 174, 0.53, 0.53, -10.5, 7.5)
	TextBox:setRGB(0.76, 0.76, 0.76)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	TextBox:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local center = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	center:linkToElementModel(center, "refreshWidget", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	center:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(center, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		if not CoD.PCUtility.IsUnavailable(self, f4_arg2) then
			CoD.PCWidgetUtility.CreateDropdown(self, self, f4_arg2, f4_arg1, "PCSocialMenu_DropDown_ItemList")
			return true
		else
		end
	end, function(f5_arg0, f5_arg1, f5_arg2)
		if not CoD.PCUtility.IsUnavailable(self, f5_arg2) then
			CoD.Menu.SetButtonLabel(f5_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(center)
	self.center = center
	center.id = "center"
	self.__defaultFocus = center
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	SetElementState(self, self, f1_arg1, "DefaultState")
	return self
end
CoD.DropDownListSmaller.__resetProperties = function(f6_arg0)
	f6_arg0.PCHighlightBorder:completeAnimation()
	f6_arg0.TextBox:completeAnimation()
	f6_arg0.Arrow:completeAnimation()
	f6_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
	f6_arg0.Arrow:setAlpha(1)
	f6_arg0.Arrow:setZRot(-90)
end
CoD.DropDownListSmaller.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.PCHighlightBorder:completeAnimation()
			f7_arg0.PCHighlightBorder:playClip("DefaultClip")
			f7_arg0.clipFinished(f7_arg0.PCHighlightBorder)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.PCHighlightBorder:completeAnimation()
			f8_arg0.PCHighlightBorder:playClip("cFocus")
			f8_arg0.clipFinished(f8_arg0.PCHighlightBorder)
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setRGB(1, 1, 1)
			f8_arg0.clipFinished(f8_arg0.TextBox)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.PCHighlightBorder:completeAnimation()
			f9_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f9_arg0.clipFinished(f9_arg0.PCHighlightBorder)
			local f9_local0 = function(f10_arg0)
				f9_arg0.TextBox:beginAnimation(150)
				f9_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
				f9_arg0.TextBox:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.TextBox:completeAnimation()
			f9_arg0.TextBox:setRGB(1, 1, 1)
			f9_local0(f9_arg0.TextBox)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.PCHighlightBorder:completeAnimation()
			f11_arg0.PCHighlightBorder:playClip("cGainFocus")
			f11_arg0.clipFinished(f11_arg0.PCHighlightBorder)
			local f11_local0 = function(f12_arg0)
				f11_arg0.TextBox:beginAnimation(150)
				f11_arg0.TextBox:setRGB(1, 1, 1)
				f11_arg0.TextBox:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.TextBox:completeAnimation()
			f11_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
			f11_local0(f11_arg0.TextBox)
		end,
	},
	Unavailable = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Arrow:completeAnimation()
			f13_arg0.Arrow:setAlpha(0.18)
			f13_arg0.clipFinished(f13_arg0.Arrow)
		end,
	},
	Open = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.PCHighlightBorder:completeAnimation()
			f14_arg0.PCHighlightBorder:playClip("DefaultClip")
			f14_arg0.clipFinished(f14_arg0.PCHighlightBorder)
			f14_arg0.Arrow:completeAnimation()
			f14_arg0.Arrow:setZRot(90)
			f14_arg0.clipFinished(f14_arg0.Arrow)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.PCHighlightBorder:completeAnimation()
			f15_arg0.PCHighlightBorder:playClip("cFocus")
			f15_arg0.clipFinished(f15_arg0.PCHighlightBorder)
			f15_arg0.Arrow:completeAnimation()
			f15_arg0.Arrow:setZRot(90)
			f15_arg0.clipFinished(f15_arg0.Arrow)
			f15_arg0.TextBox:completeAnimation()
			f15_arg0.TextBox:setRGB(1, 1, 1)
			f15_arg0.clipFinished(f15_arg0.TextBox)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.PCHighlightBorder:completeAnimation()
			f16_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f16_arg0.clipFinished(f16_arg0.PCHighlightBorder)
			f16_arg0.Arrow:completeAnimation()
			f16_arg0.Arrow:setZRot(90)
			f16_arg0.clipFinished(f16_arg0.Arrow)
			local f16_local0 = function(f17_arg0)
				f16_arg0.TextBox:beginAnimation(150)
				f16_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
				f16_arg0.TextBox:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.TextBox:completeAnimation()
			f16_arg0.TextBox:setRGB(1, 1, 1)
			f16_local0(f16_arg0.TextBox)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.PCHighlightBorder:completeAnimation()
			f18_arg0.PCHighlightBorder:playClip("cGainFocus")
			f18_arg0.clipFinished(f18_arg0.PCHighlightBorder)
			f18_arg0.Arrow:completeAnimation()
			f18_arg0.Arrow:setZRot(90)
			f18_arg0.clipFinished(f18_arg0.Arrow)
			local f18_local0 = function(f19_arg0)
				f18_arg0.TextBox:beginAnimation(150)
				f18_arg0.TextBox:setRGB(1, 1, 1)
				f18_arg0.TextBox:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.TextBox:completeAnimation()
			f18_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
			f18_local0(f18_arg0.TextBox)
		end,
	},
	Close = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.PCHighlightBorder:completeAnimation()
			f20_arg0.PCHighlightBorder:playClip("DefaultClip")
			f20_arg0.clipFinished(f20_arg0.PCHighlightBorder)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.PCHighlightBorder:completeAnimation()
			f21_arg0.PCHighlightBorder:playClip("cFocus")
			f21_arg0.clipFinished(f21_arg0.PCHighlightBorder)
			f21_arg0.TextBox:completeAnimation()
			f21_arg0.TextBox:setRGB(1, 1, 1)
			f21_arg0.clipFinished(f21_arg0.TextBox)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.PCHighlightBorder:completeAnimation()
			f22_arg0.PCHighlightBorder:playClip("cGainFocus")
			f22_arg0.clipFinished(f22_arg0.PCHighlightBorder)
			local f22_local0 = function(f23_arg0)
				f22_arg0.TextBox:beginAnimation(150)
				f22_arg0.TextBox:setRGB(1, 1, 1)
				f22_arg0.TextBox:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.TextBox:completeAnimation()
			f22_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
			f22_local0(f22_arg0.TextBox)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.PCHighlightBorder:completeAnimation()
			f24_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f24_arg0.clipFinished(f24_arg0.PCHighlightBorder)
			local f24_local0 = function(f25_arg0)
				f24_arg0.TextBox:beginAnimation(150)
				f24_arg0.TextBox:setRGB(0.76, 0.76, 0.76)
				f24_arg0.TextBox:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.TextBox:completeAnimation()
			f24_arg0.TextBox:setRGB(1, 1, 1)
			f24_local0(f24_arg0.TextBox)
		end,
	},
}
CoD.DropDownListSmaller.__onClose = function(f26_arg0)
	f26_arg0.PCHighlightBorder:close()
	f26_arg0.center:close()
end
