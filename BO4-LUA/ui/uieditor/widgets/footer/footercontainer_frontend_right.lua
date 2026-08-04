require("ui/uieditor/widgets/footer/footerbutton_backhold")
require("ui/uieditor/widgets/pc/footer/footer_bg")
require("ui/uieditor/widgets/pc/footer/footerbutton_frontend_pc_left")
require("ui/uieditor/widgets/pc/footer/footerbutton_frontend_pc_right")
CoD.FooterContainer_Frontend_Right = InheritFrom(LUI.UIElement)
CoD.FooterContainer_Frontend_Right.__defaultWidth = 1920
CoD.FooterContainer_Frontend_Right.__defaultHeight = 48
CoD.FooterContainer_Frontend_Right.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterContainer_Frontend_Right)
	self.id = "FooterContainer_Frontend_Right"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local BackgroundPC = nil
	BackgroundPC = CoD.Footer_BG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -54, 0)
	BackgroundPC:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToWidthOfScreen(element, f1_arg1)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(BackgroundPC)
	self.BackgroundPC = BackgroundPC
	local f1_local2 = nil
	self.BackgroundConsole = LUI.UIElement.createFake()
	local f1_local3 = nil
	self.RightContainer = LUI.UIElement.createFake()
	local LeftContainerPC = nil
	LeftContainerPC = CoD.FooterButton_Frontend_PC_Left.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -54, 0)
	LeftContainerPC:linkToElementModel(self, nil, false, function(model)
		LeftContainerPC:setModel(model, f1_arg1)
	end)
	self:addElement(LeftContainerPC)
	self.LeftContainerPC = LeftContainerPC
	local RightContainerPC = nil
	RightContainerPC = CoD.FooterButton_Frontend_PC_Right.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -54, 0)
	RightContainerPC:linkToElementModel(self, nil, false, function(model)
		RightContainerPC:setModel(model, f1_arg1)
	end)
	self:addElement(RightContainerPC)
	self.RightContainerPC = RightContainerPC
	local BackHold = CoD.FooterButton_BackHold.new(f1_arg0, f1_arg1, 0.5, 0.5, -120, 120, 1, 1, -48, 0)
	BackHold:setAlpha(0)
	BackHold:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbb_pscircle"], false, function(model)
		BackHold:setModel(model, f1_arg1)
	end)
	self:addElement(BackHold)
	self.BackHold = BackHold
	local f1_local7 = nil
	self.CenterContainer = LUI.UIElement.createFake()
	local f1_local8 = nil
	self.LeftContainer = LUI.UIElement.createFake()
	self.__on_menuOpened_self = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		local f6_local0 = self
		if IsPC() then
			CallCustomElementFunction_Self(self, "setPriority", 10)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	if CoD.isPC then
		LeftContainerPC.id = "LeftContainerPC"
	end
	if CoD.isPC then
		RightContainerPC.id = "RightContainerPC"
	end
	if CoD.isPC then
		BackHold.id = "BackHold"
	end
	self.__defaultFocus = RightContainerPC
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local9 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.FooterContainer_Frontend_Right.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.BackgroundPC:close()
	f8_arg0.BackgroundConsole:close()
	f8_arg0.RightContainer:close()
	f8_arg0.LeftContainerPC:close()
	f8_arg0.RightContainerPC:close()
	f8_arg0.BackHold:close()
	f8_arg0.CenterContainer:close()
	f8_arg0.LeftContainer:close()
end
