require("x64:d21920ef47fc4d0")
require("x64:efb4937f8502f72")
CoD.LiveEventViewerQualities = InheritFrom(CoD.Menu)
LUI.createMenu.LiveEventViewerQualities = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LiveEventViewerQualities", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.LiveEventViewerQualities)
	self.soundSet = "Special_widgets"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setAlpha(0.5)
	self:addElement(backing)
	self.backing = backing
	local qualityList = LUI.UIList.new(f1_local1, f1_arg0, 2, 0, nil, false, false, false, false)
	qualityList:setLeftRight(0, 0, 96, 636)
	qualityList:setTopBottom(0, 0, 59, 597)
	qualityList:setWidgetType(CoD.ListButton)
	qualityList:setVerticalCount(10)
	qualityList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	qualityList:setDataSource("LiveEventViewerQualities")
	qualityList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(qualityList, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(qualityList, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0xC2E92C54C2BE289, nil, nil)
		return true
	end, false)
	self:addElement(qualityList)
	self.qualityList = qualityList
	local footer = CoD.fe_FooterContainer_NOTLobby.new(f1_local1, f1_arg0, 0, 1, 2, -2, 1, 1, -100, 0)
	footer:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(footer)
	self.footer = footer
	qualityList.id = "qualityList"
	footer:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		footer.id = "footer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.LiveEventViewerQualities.__onClose = function(f8_arg0)
	f8_arg0.qualityList:close()
	f8_arg0.footer:close()
end
