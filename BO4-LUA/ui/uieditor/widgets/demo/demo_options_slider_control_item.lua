require("x64:2675595fa323085")
require("x64:8db2f3c7352224c")
local PostLoadFunc = function(self, controller, menu)
	if CoD.isPC then
		self.m_preventFromBeingCurrentMouseFocus = true
		self:setForceMouseEventDispatch(true)
	end
end
CoD.demo_options_slider_control_item = InheritFrom(LUI.UIElement)
CoD.demo_options_slider_control_item.__defaultWidth = 375
CoD.demo_options_slider_control_item.__defaultHeight = 45
CoD.demo_options_slider_control_item.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setClass(CoD.demo_options_slider_control_item)
	self.id = "demo_options_slider_control_item"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	f2_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -15, 15)
	TextBox:setTTF("dinnext_regular")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	TextBox:linkToElementModel(self, "text", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	local left = CoD.StartMenu_Options_Slider_Item_Arrow.new(f2_arg0, f2_arg1, 0, 0, -31, -1, 0.5, 0.5, -15, 15)
	left:setZRot(-90)
	left:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_arg0, f2_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f2_arg0:AddButtonCallbackFunction(left, f2_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		CallElementModel(self, self, controller, "prevAction")
		SendButtonPressToMenuEx(menu, controller, Enum[@"luibutton"][@"lui_key_left"])
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "MOUSE1")
		return true
	end, false)
	self:addElement(left)
	self.left = left
	local right = CoD.StartMenu_Options_Slider_Item_Arrow.new(f2_arg0, f2_arg1, 1, 1, 1, 31, 0.5, 0.5, -15, 15)
	right:setYRot(180)
	right:setZRot(-90)
	right:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_arg0, f2_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f2_arg0:AddButtonCallbackFunction(right, f2_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		CallElementModel(self, self, controller, "nextAction")
		SendButtonPressToMenuEx(menu, controller, Enum[@"luibutton"][@"lui_key_right"])
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "MOUSE1")
		return true
	end, false)
	self:addElement(right)
	self.right = right
	local emptyFocusable = CoD.emptyFocusable.new(f2_arg0, f2_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f10_arg2, f10_arg3, f10_arg4)
		if IsElementInState(element, "DefaultState") then
			SetElementStateByElementName(self, "arrow", controller, "DefaultState")
			SetElementStateByElementName(self, "arrow", controller, "DefaultState")
			SetElementStateByElementName(self, "left", controller, "DefaultState")
			SetElementStateByElementName(self, "right", controller, "DefaultState")
		elseif IsElementInState(element, "ArrowsHidden") then
			SetElementStateByElementName(self, "arrow", controller, "Hidden")
			SetElementStateByElementName(self, "arrow0", controller, "Hidden")
			SetElementStateByElementName(self, "left", controller, "Hidden")
			SetElementStateByElementName(self, "right", controller, "Hidden")
		end
	end)
	left.id = "left"
	right.id = "right"
	emptyFocusable.id = "emptyFocusable"
	self.__defaultFocus = left
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	return self
end
CoD.demo_options_slider_control_item.__resetProperties = function(f11_arg0)
	f11_arg0.TextBox:completeAnimation()
	f11_arg0.right:completeAnimation()
	f11_arg0.left:completeAnimation()
	f11_arg0.TextBox:setRGB(1, 1, 1)
	f11_arg0.right:setAlpha(1)
	f11_arg0.left:setAlpha(1)
end
CoD.demo_options_slider_control_item.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.TextBox:completeAnimation()
			f13_arg0.TextBox:setRGB(ColorSet.FocusColor.r, ColorSet.FocusColor.g, ColorSet.FocusColor.b)
			f13_arg0.clipFinished(f13_arg0.TextBox)
		end,
	},
	ArrowsHidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.left:completeAnimation()
			f14_arg0.left:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.left)
			f14_arg0.right:completeAnimation()
			f14_arg0.right:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.right)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.TextBox:completeAnimation()
			f15_arg0.TextBox:setRGB(1, 0.41, 0)
			f15_arg0.clipFinished(f15_arg0.TextBox)
			f15_arg0.left:completeAnimation()
			f15_arg0.left:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.left)
			f15_arg0.right:completeAnimation()
			f15_arg0.right:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.right)
		end,
	},
}
CoD.demo_options_slider_control_item.__onClose = function(f16_arg0)
	f16_arg0.TextBox:close()
	f16_arg0.left:close()
	f16_arg0.right:close()
	f16_arg0.emptyFocusable:close()
end
