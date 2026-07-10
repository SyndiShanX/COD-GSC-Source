require("x64:fb9033c21f3c893")
CoD.HealthBoostPlayerList = InheritFrom(LUI.UIElement)
CoD.HealthBoostPlayerList.__defaultWidth = 1060
CoD.HealthBoostPlayerList.__defaultHeight = 190
CoD.HealthBoostPlayerList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBoostPlayerList)
	self.id = "HealthBoostPlayerList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local PlayerList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	PlayerList:setLeftRight(0, 0, 0, 1060)
	PlayerList:setTopBottom(0, 0, 0, 190)
	PlayerList:setWidgetType(CoD.HealthBoostPlayerListWidget)
	PlayerList:setHorizontalCount(6)
	PlayerList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayerList:setDataSource("HealthBoostPlayerList")
	PlayerList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PlayerList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.ScorestreakInGameUtility.HealthBoostPlayerSelected(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(PlayerList)
	self.PlayerList = PlayerList
	self.__on_menuOpened_self = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		local f5_local0 = self
		SetFocusToSelf(self, f5_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	PlayerList.id = "PlayerList"
	self.__defaultFocus = PlayerList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	f1_local2 = PlayerList
	CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local2, f1_arg1)
	CoD.GridAndListUtility.AddListLeftRightNavigation(f1_arg0, f1_local2, f1_arg1)
	return self
end
CoD.HealthBoostPlayerList.__onClose = function(f7_arg0)
	f7_arg0.__on_close_removeOverrides()
	f7_arg0.PlayerList:close()
end
