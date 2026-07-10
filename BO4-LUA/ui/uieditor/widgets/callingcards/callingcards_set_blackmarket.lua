require("x64:cb0881b7c07d5f3")
require("x64:38c11a77e96e48c")
CoD.CallingCards_Set_BlackMarket = InheritFrom(LUI.UIElement)
CoD.CallingCards_Set_BlackMarket.__defaultWidth = 1725
CoD.CallingCards_Set_BlackMarket.__defaultHeight = 780
CoD.CallingCards_Set_BlackMarket.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Set_BlackMarket)
	self.id = "CallingCards_Set_BlackMarket"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CallingCardSet = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, true, false, false, false)
	CallingCardSet:setLeftRight(0.5, 0.5, -709.5, 709.5)
	CallingCardSet:setTopBottom(0, 0, 57, 723)
	CallingCardSet:setWidgetType(CoD.CallingCards_BlackMarket_Set_Widget)
	CallingCardSet:setHorizontalCount(3)
	CallingCardSet:setVerticalCount(3)
	CallingCardSet:setSpacing(30)
	CallingCardSet:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardSet:setVerticalCounter(CoD.verticalCounter)
	CallingCardSet:setDataSource("CallingCardSetBlackMarket")
	CallingCardSet:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CallingCardSet, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsGameTrial() then
			ProcessListAction(self, element, controller, menu)
			PlaySoundSetSound(self, "action")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsGameTrial() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(CallingCardSet)
	self.CallingCardSet = CallingCardSet
	CallingCardSet.id = "CallingCardSet"
	self.__defaultFocus = CallingCardSet
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Set_BlackMarket.__onClose = function(f5_arg0)
	f5_arg0.CallingCardSet:close()
end
