require("x64:4a0101f034c1674")
require("x64:e69a699d13ef927")
require("x64:9c0d1b3c2478454")
require("x64:5ae5c2fbe66bbe1")
CoD.FooterContainer_Ingame_Right = InheritFrom(LUI.UIElement)
CoD.FooterContainer_Ingame_Right.__defaultWidth = 1920
CoD.FooterContainer_Ingame_Right.__defaultHeight = 48
CoD.FooterContainer_Ingame_Right.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterContainer_Ingame_Right)
	self.id = "FooterContainer_Ingame_Right"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local FooterBGPC = nil
	FooterBGPC = CoD.Footer_BG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -54, 0)
	FooterBGPC:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterBGPC)
	self.FooterBGPC = FooterBGPC
	local f1_local2 = nil
	self.RightContainer = LUI.UIElement.createFake()
	local BackHold = CoD.FooterButton_BackHold.new(f1_arg0, f1_arg1, 0.5, 0.5, -120, 120, 1, 1, -48, 0)
	BackHold:setAlpha(0)
	BackHold:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xbb_pscircle"], false, function(model)
		BackHold:setModel(model, f1_arg1)
	end)
	self:addElement(BackHold)
	self.BackHold = BackHold
	local f1_local4 = nil
	self.LeftContainer = LUI.UIElement.createFake()
	local RightContainerPC = nil
	RightContainerPC = CoD.FooterButton_Frontend_PC_Right.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -54, 0)
	RightContainerPC:linkToElementModel(self, nil, false, function(model)
		RightContainerPC:setModel(model, f1_arg1)
	end)
	self:addElement(RightContainerPC)
	self.RightContainerPC = RightContainerPC
	local LeftContainerPC = nil
	LeftContainerPC = CoD.FooterButton_Frontend_PC_Left.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -54, 0)
	LeftContainerPC:linkToElementModel(self, nil, false, function(model)
		LeftContainerPC:setModel(model, f1_arg1)
	end)
	self:addElement(LeftContainerPC)
	self.LeftContainerPC = LeftContainerPC
	if CoD.isPC then
		BackHold.id = "BackHold"
	end
	if CoD.isPC then
		RightContainerPC.id = "RightContainerPC"
	end
	if CoD.isPC then
		LeftContainerPC.id = "LeftContainerPC"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterContainer_Ingame_Right.__onClose = function(f6_arg0)
	f6_arg0.FooterBGPC:close()
	f6_arg0.RightContainer:close()
	f6_arg0.BackHold:close()
	f6_arg0.LeftContainer:close()
	f6_arg0.RightContainerPC:close()
	f6_arg0.LeftContainerPC:close()
end
