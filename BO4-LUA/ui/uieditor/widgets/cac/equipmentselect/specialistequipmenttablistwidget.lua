require("x64:1394ae5e9cdcb54")
require("x64:7198f4a2c6418a6")
require("x64:341ce33d59fafd1")
require("x64:fb1672b52d23ecc")
require("x64:37113d6053cc9f6")
require("x64:14ab47ffb48a077")
CoD.SpecialistEquipmentTabListWidget = InheritFrom(LUI.UIElement)
CoD.SpecialistEquipmentTabListWidget.__defaultWidth = 1920
CoD.SpecialistEquipmentTabListWidget.__defaultHeight = 1080
CoD.SpecialistEquipmentTabListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistEquipmentTabListWidget)
	self.id = "SpecialistEquipmentTabListWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialistEquipmentName = LUI.UIText.new(0.5, 0.5, -172, 170, 0, 0, 87.5, 105.5)
	SpecialistEquipmentName:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	SpecialistEquipmentName:setZoom(3)
	SpecialistEquipmentName:setTTF("ttmussels_regular")
	SpecialistEquipmentName:setLetterSpacing(10)
	SpecialistEquipmentName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SpecialistEquipmentName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SpecialistEquipmentName)
	self.SpecialistEquipmentName = SpecialistEquipmentName
	local SpecialistName = LUI.UIText.new(0.5, 0.5, -192, 190, 0, 0, 60, 86)
	SpecialistName:setRGB(0.92, 0.92, 0.92)
	SpecialistName:setZoom(3)
	SpecialistName:setTTF("ttmussels_regular")
	SpecialistName:setLetterSpacing(10)
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local positions = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -25, 0, nil, nil, false, false, false, false)
	positions:setLeftRight(0.5, 0.5, -200, 202)
	positions:setTopBottom(0, 0, 20, 42)
	positions:setZoom(4)
	positions:setWidgetType(CoD.DirectorFeaturedPip)
	positions:setHorizontalCount(13)
	positions:setSpacing(-25)
	positions:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	positions:setDataSource("PositionLoadoutList")
	positions:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		SetControllerModelValue(f1_arg1, "PositionLoadoutList.SelectedCharacterIndex", element.characterIndex)
		CoD.CACUtility.UpdateEquipmentModelFromPositionList(f1_arg0, element, f1_arg1)
		return f2_local0
	end)
	LUI.OverrideFunction_CallOriginalFirst(positions, "childFocusGained", function(element)
		ForceCheckDefaultPCFocus(f1_arg0, f1_arg0, f1_arg1)
	end)
	self:addElement(positions)
	self.positions = positions
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 186, 386, 0, 0, 14, 48)
	RB:setZoom(4)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -384, -184, 0, 0, 14, 48)
	LB:setZoom(4)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local SpecialIssueInfo = CoD.SpecialistEquipmentNameDesc.new(f1_arg0, f1_arg1, 1, 1, -559, -59, 0, 0, 371, 477)
	SpecialIssueInfo:setZoom(85)
	self:addElement(SpecialIssueInfo)
	self.SpecialIssueInfo = SpecialIssueInfo
	local SpecialistEquipmentWidget = CoD.SpecialistIssueEquipmentWidget.new(f1_arg0, f1_arg1, 0, 0, 83, 483, 0, 0, 236.5, 636.5)
	SpecialistEquipmentWidget:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(SpecialistEquipmentWidget)
	self.SpecialistEquipmentWidget = SpecialistEquipmentWidget
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_arg0, f1_arg1, 0.5, 0.5, -247, 247, 0.5, 0.5, 41, 71)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	local left = nil
	left = CoD.PC_TabsArrow.new(f1_arg0, f1_arg1, 0, 0, 708, 773, 0, 0, -3, 62)
	left:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	left:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(left, f6_arg1)
	end)
	local f1_local10 = left
	local right = left.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	right(f1_local10, f1_local12.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(left, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	left:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(left, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.GridAndListUtility.DoBumperGridButton(menu, controller, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(left)
	self.left = left
	right = nil
	right = CoD.PC_TabsArrow.new(f1_arg0, f1_arg1, 0, 0, 1150, 1215, 0, 0, -3, 62)
	right:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	right:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(right, f12_arg1)
	end)
	f1_local12 = right
	f1_local10 = right.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local12, f1_local13.LastInput, function(f13_arg0)
		f1_arg0:updateElementState(right, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	right:setZRot(180)
	right:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(right, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.GridAndListUtility.DoBumperGridButton(menu, controller, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(right)
	self.right = right
	SpecialistEquipmentName:linkToElementModel(positions, "equipment.displayName", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			SpecialistEquipmentName:setText(LocalizeToUpperString(f17_local0))
		end
	end)
	SpecialistName:linkToElementModel(positions, "name", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			SpecialistName:setText(LocalizeToUpperString(f18_local0))
		end
	end)
	SpecialIssueInfo:linkToElementModel(positions, "equipment", false, function(model)
		SpecialIssueInfo:setModel(model, f1_arg1)
	end)
	RestrictedText:linkToElementModel(positions, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg1)
	end)
	positions.id = "positions"
	if CoD.isPC then
		left.id = "left"
	end
	if CoD.isPC then
		right.id = "right"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	CoD.CACUtility.AddSpecialistEquipmentBumperNavigation(f1_arg0, positions, f1_arg1)
	DisableKeyboardNavigationByElement(self.positions)
	return self
end
CoD.SpecialistEquipmentTabListWidget.__resetProperties = function(f21_arg0)
	f21_arg0.SpecialistEquipmentName:completeAnimation()
	f21_arg0.SpecialistName:completeAnimation()
	f21_arg0.positions:completeAnimation()
	f21_arg0.RB:completeAnimation()
	f21_arg0.LB:completeAnimation()
	f21_arg0.SpecialIssueInfo:completeAnimation()
	f21_arg0.SpecialistEquipmentWidget:completeAnimation()
	f21_arg0.RestrictedText:completeAnimation()
	f21_arg0.left:completeAnimation()
	f21_arg0.right:completeAnimation()
	f21_arg0.SpecialistEquipmentName:setAlpha(1)
	f21_arg0.SpecialistName:setAlpha(1)
	f21_arg0.positions:setAlpha(1)
	f21_arg0.RB:setAlpha(1)
	f21_arg0.LB:setAlpha(1)
	f21_arg0.SpecialIssueInfo:setAlpha(1)
	f21_arg0.SpecialistEquipmentWidget:setAlpha(1)
	f21_arg0.RestrictedText:setAlpha(1)
	f21_arg0.left:setAlpha(1)
	f21_arg0.right:setAlpha(1)
end
CoD.SpecialistEquipmentTabListWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	NotVisible = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(10)
			f23_arg0.SpecialistEquipmentName:completeAnimation()
			f23_arg0.SpecialistEquipmentName:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SpecialistEquipmentName)
			f23_arg0.SpecialistName:completeAnimation()
			f23_arg0.SpecialistName:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SpecialistName)
			f23_arg0.positions:completeAnimation()
			f23_arg0.positions:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.positions)
			f23_arg0.RB:completeAnimation()
			f23_arg0.RB:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RB)
			f23_arg0.LB:completeAnimation()
			f23_arg0.LB:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.LB)
			f23_arg0.SpecialIssueInfo:completeAnimation()
			f23_arg0.SpecialIssueInfo:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SpecialIssueInfo)
			f23_arg0.SpecialistEquipmentWidget:completeAnimation()
			f23_arg0.SpecialistEquipmentWidget:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SpecialistEquipmentWidget)
			f23_arg0.RestrictedText:completeAnimation()
			f23_arg0.RestrictedText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RestrictedText)
			f23_arg0.left:completeAnimation()
			f23_arg0.left:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.left)
			f23_arg0.right:completeAnimation()
			f23_arg0.right:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.right)
		end,
	},
}
CoD.SpecialistEquipmentTabListWidget.__onClose = function(f24_arg0)
	f24_arg0.SpecialistEquipmentName:close()
	f24_arg0.SpecialistName:close()
	f24_arg0.SpecialIssueInfo:close()
	f24_arg0.RestrictedText:close()
	f24_arg0.positions:close()
	f24_arg0.RB:close()
	f24_arg0.LB:close()
	f24_arg0.SpecialistEquipmentWidget:close()
	f24_arg0.left:close()
	f24_arg0.right:close()
end
