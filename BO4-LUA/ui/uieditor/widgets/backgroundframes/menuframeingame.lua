require("x64:ce1e6b6549d478c")
CoD.MenuFrameIngame = InheritFrom(LUI.UIElement)
CoD.MenuFrameIngame.__defaultWidth = 1920
CoD.MenuFrameIngame.__defaultHeight = 1080
CoD.MenuFrameIngame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MenuFrameIngame)
	self.id = "MenuFrameIngame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:linkToElementModel(self, nil, false, function(model)
		FooterContainerFrontendRight:setModel(model, f1_arg1)
	end)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MenuFrameIngame.__onClose = function(f4_arg0)
	f4_arg0.FooterContainerFrontendRight:close()
end
