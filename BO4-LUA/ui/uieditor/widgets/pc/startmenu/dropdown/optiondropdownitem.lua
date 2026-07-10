require("x64:3625a0d08a5c80d")
local f0_local0 = function(f1_arg0, f1_arg1, f1_arg2)
	CoD.Menu.AddButtonCallbackFunction(f1_arg2, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, f2_arg3)
		f1_arg0:processEvent({
			name = "lose_focus",
			controller = controller,
		})
		return f1_arg0:dispatchEventToParent({
			name = "dropdown_item_cancelled",
			element = f1_arg0,
		})
	end)
	CoD.Menu.AddButtonCallbackFunction(f1_arg2, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, f3_arg3)
		if not menu.m_disableNavigation and menu:AcceptGamePadButtonInputFromModelCallback(controller) then
			f1_arg0:processEvent({
				name = "lose_focus",
				controller = controller,
			})
			return f1_arg0:dispatchEventToParent({
				name = "dropdown_item_selected",
				element = f1_arg0,
			})
		else
		end
	end)
	f1_arg0.m_dropdownItem = true
end
local PostLoadFunc = function(self, controller, menu)
	if CoD.isPC then
		f0_local0(self, controller, menu)
	end
end
CoD.OptionDropdownItem = InheritFrom(LUI.UIElement)
CoD.OptionDropdownItem.__defaultWidth = 375
CoD.OptionDropdownItem.__defaultHeight = 36
CoD.OptionDropdownItem.new = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6, f5_arg7, f5_arg8, f5_arg9)
	local self = LUI.UIElement.new(f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6, f5_arg7, f5_arg8, f5_arg9)
	self:setClass(CoD.OptionDropdownItem)
	self.id = "OptionDropdownItem"
	self.soundSet = "none"
	f5_arg0:addElementToPendingUpdateStateList(self)
	local fullbacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fullbacking:setRGB(0, 0, 0)
	self:addElement(fullbacking)
	self.fullbacking = fullbacking
	local labelText = LUI.UIText.new(0, 0, 9, 364, 0, 0, 0, 36)
	labelText:setTTF("default")
	labelText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	labelText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	labelText:linkToElementModel(self, "valueDisplay", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			labelText:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(labelText)
	self.labelText = labelText
	local FocusBarT = CoD.FE_FocusBarContainer.new(f5_arg0, f5_arg1, 0, 1, -3, 3, 0, 0, -1, 5)
	FocusBarT:setAlpha(0)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	local FocusBarB = CoD.FE_FocusBarContainer.new(f5_arg0, f5_arg1, 0, 1, -3, 3, 1, 1, -3, 3)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f5_arg1, f5_arg0)
	end
	return self
end
CoD.OptionDropdownItem.__resetProperties = function(f7_arg0)
	f7_arg0.labelText:completeAnimation()
	f7_arg0.FocusBarT:completeAnimation()
	f7_arg0.FocusBarB:completeAnimation()
	f7_arg0.labelText:setLeftRight(0, 0, 9, 364)
	f7_arg0.labelText:setTopBottom(0, 0, 0, 36)
	f7_arg0.labelText:setRGB(1, 1, 1)
	f7_arg0.labelText:setAlpha(1)
	f7_arg0.FocusBarT:setAlpha(0)
	f7_arg0.FocusBarB:setAlpha(0)
end
CoD.OptionDropdownItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.labelText:completeAnimation()
			f8_arg0.labelText:setRGB(0.87, 0.37, 0)
			f8_arg0.labelText:setAlpha(0.75)
			f8_arg0.clipFinished(f8_arg0.labelText)
		end,
		Focus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.labelText:completeAnimation()
			f9_arg0.labelText:setLeftRight(0, 0, 9, 360)
			f9_arg0.labelText:setTopBottom(0, 0, 0, 36)
			f9_arg0.clipFinished(f9_arg0.labelText)
			f9_arg0.FocusBarT:completeAnimation()
			f9_arg0.FocusBarT:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.FocusBarT)
			f9_arg0.FocusBarB:completeAnimation()
			f9_arg0.FocusBarB:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.FocusBarB)
		end,
	},
}
CoD.OptionDropdownItem.__onClose = function(f10_arg0)
	f10_arg0.labelText:close()
	f10_arg0.FocusBarT:close()
	f10_arg0.FocusBarB:close()
end
