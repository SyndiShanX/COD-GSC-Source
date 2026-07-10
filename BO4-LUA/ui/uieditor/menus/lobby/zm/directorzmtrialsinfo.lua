require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:341c1b90abc5f01")
CoD.DirectorZMTrialsInfo = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorZMTrialsInfo = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorZMTrialsInfo", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.DirectorZMTrialsInfo)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local TEMPBlackBGOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TEMPBlackBGOverlay:setRGB(0, 0, 0)
	TEMPBlackBGOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	TEMPBlackBGOverlay:setShaderVector(0, 0.01, 0.5, 0, 0)
	self:addElement(TEMPBlackBGOverlay)
	self.TEMPBlackBGOverlay = TEMPBlackBGOverlay
	local DirectorZMTrialsInfoInternal = CoD.DirectorZMTrialsInfoInternal.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self.__on_menuOpened_DirectorZMTrialsInfoInternal = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		SizeToSafeArea(DirectorZMTrialsInfoInternal, f2_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_DirectorZMTrialsInfoInternal)
	self:addElement(DirectorZMTrialsInfoInternal)
	self.DirectorZMTrialsInfoInternal = DirectorZMTrialsInfoInternal
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/zombies_modes"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, -25)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_778D439E1B360368", nil, "ESCAPE")
		return true
	end, false)
	DirectorZMTrialsInfoInternal.id = "DirectorZMTrialsInfoInternal"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_DirectorZMTrialsInfoInternal)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.DirectorZMTrialsInfo.__onClose = function(f10_arg0)
	f10_arg0.__on_close_removeOverrides()
	f10_arg0.DirectorZMTrialsInfoInternal:close()
	f10_arg0.CommonHeader:close()
	f10_arg0.BackingGrayMediumLeft:close()
	f10_arg0.FooterContainerFrontendRight:close()
end
