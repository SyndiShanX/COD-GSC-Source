require("x64:330d3ffa470e968")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
CoD.GenericMenuFrameCAC = InheritFrom(LUI.UIElement)
CoD.GenericMenuFrameCAC.__defaultWidth = 1920
CoD.GenericMenuFrameCAC.__defaultHeight = 1080
CoD.GenericMenuFrameCAC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GenericMenuFrameCAC)
	self.id = "GenericMenuFrameCAC"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CommonHeader = CoD.CACHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xBB7AA7A26F39DFA))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local HeaderStripe = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	HeaderStripe:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		elseif IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	FooterContainerFrontendRight:appendEventHandler("menu_loaded", function()
		FooterContainerFrontendRight:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GenericMenuFrameCAC.__onClose = function(f7_arg0)
	f7_arg0.FooterContainerFrontendRight:close()
	f7_arg0.CommonHeader:close()
	f7_arg0.HeaderStripe:close()
end
