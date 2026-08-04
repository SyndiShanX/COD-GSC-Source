require("ui/uieditor/widgets/backgroundframes/identitybadgeupperrightsafe")
require("ui/uieditor/widgets/common/commonheader")
require("ui/uieditor/widgets/common/commonidentitywidgetstreamlinedsafeareacontainer")
require("ui/uieditor/widgets/footer/footercontainer_frontend_right")
require("ui/uieditor/widgets/header/header_container_frontend")
CoD.GenericMenuFrameIdentity = InheritFrom(LUI.UIElement)
CoD.GenericMenuFrameIdentity.__defaultWidth = 1920
CoD.GenericMenuFrameIdentity.__defaultHeight = 1080
CoD.GenericMenuFrameIdentity.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GenericMenuFrameIdentity)
	self.id = "GenericMenuFrameIdentity"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_BB7AA7A26F39DFA"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local HeaderStripe = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	HeaderStripe:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		elseif IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local SelfIdentityBadge = CoD.IdentityBadgeUpperRightSafe.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	SelfIdentityBadge:setAlpha(0)
	SelfIdentityBadge:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		SelfIdentityBadge:setModel(model, f1_arg1)
	end)
	self:addElement(SelfIdentityBadge)
	self.SelfIdentityBadge = SelfIdentityBadge
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg1)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		if IsElementInState(element, "Update") then
			SetElementStateByElementName(self, "cac3dTitleIntermediary0", controller, "Update")
		end
	end)
	FooterContainerFrontendRight:appendEventHandler("menu_loaded", function()
		FooterContainerFrontendRight:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	SelfIdentityBadge.id = "SelfIdentityBadge"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GenericMenuFrameIdentity.__onClose = function(f10_arg0)
	f10_arg0.CommonHeader:close()
	f10_arg0.HeaderStripe:close()
	f10_arg0.FooterContainerFrontendRight:close()
	f10_arg0.SelfIdentityBadge:close()
	f10_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
end
