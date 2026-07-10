require("x64:998f71c212fcd7c")
local f0_local0 = function(f1_arg0, f1_arg1)
	GoBack(f1_arg0, f1_arg1.controller)
	SendClientScriptDebugMenuCloseMenuNotify(f1_arg0, nil, f1_arg1.controller)
end
local PostLoadFunc = function(f2_arg0)
	f2_arg0:registerEventHandler("close_ScriptDebugMenu", f0_local0)
end
CoD.ScriptDebugMenu = InheritFrom(CoD.Menu)
LUI.createMenu.ScriptDebugMenu = function(f3_arg0, f3_arg1)
	local self = CoD.Menu.NewForUIEditor("ScriptDebugMenu", f3_arg0)
	local f3_local1 = self
	self:setClass(CoD.ScriptDebugMenu)
	self.soundSet = "default"
	self:setOwner(f3_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f3_arg0)
	self.anyChildUsesUpdateState = true
	local cscDebugMenuList = LUI.UIList.new(f3_local1, f3_arg0, 2, 0, nil, false, false, false, false)
	cscDebugMenuList:setLeftRight(0, 0, 148, 1048)
	cscDebugMenuList:setTopBottom(0, 0, 389, 763)
	cscDebugMenuList:setWidgetType(CoD.ScriptDebugMenuListWidget)
	cscDebugMenuList:setVerticalCount(8)
	cscDebugMenuList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	cscDebugMenuList:setDataSource("ClientscriptDebugMenu")
	cscDebugMenuList:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f3_local1, f3_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f3_local1:AddButtonCallbackFunction(cscDebugMenuList, f3_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		SendClientScriptDebugMenuNotify(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(cscDebugMenuList)
	self.cscDebugMenuList = cscDebugMenuList
	f3_local1:AddButtonCallbackFunction(self, f3_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		SendClientScriptDebugMenuCloseMenuNotify(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_0", nil, nil)
		return false
	end, false)
	cscDebugMenuList.id = "cscDebugMenuList"
	self:processEvent({
		name = "menu_loaded",
		controller = f3_arg0,
	})
	self.__defaultFocus = cscDebugMenuList
	if CoD.isPC and (IsKeyboard(f3_arg0) or self.ignoreCursor) then
		self:restoreState(f3_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg0)
	end
	return self
end
CoD.ScriptDebugMenu.__onClose = function(f9_arg0)
	f9_arg0.cscDebugMenuList:close()
end
