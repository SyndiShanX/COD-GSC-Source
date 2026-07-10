require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:ad3a38e5658bc26")
CoD.PC_Korea_Event_Menu = InheritFrom(CoD.Menu)
LUI.createMenu.PC_Korea_Event_Menu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_Korea_Event_Menu", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PC_Korea_Event_Menu)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local PCKoreaEventFrame = CoD.PC_Korea_Event_Frame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCKoreaEventFrame)
	self.PCKoreaEventFrame = PCKoreaEventFrame
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x47CD2396EF33FB1))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader.subtitle.subtitle:setText("")
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	PCKoreaEventFrame.id = "PCKoreaEventFrame"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
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
CoD.PC_Korea_Event_Menu.__onClose = function(f5_arg0)
	f5_arg0.PCKoreaEventFrame:close()
	f5_arg0.CommonHeader:close()
	f5_arg0.FooterContainerFrontendRight:close()
end
