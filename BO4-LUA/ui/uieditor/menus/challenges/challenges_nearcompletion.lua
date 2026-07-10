require("x64:eda152e1d10147a")
require("x64:cd4a942309c019a")
require("x64:71d2a0ed724628e")
require("x64:3e7363f43bb91")
CoD.Challenges_NearCompletion = InheritFrom(CoD.Menu)
LUI.createMenu.Challenges_NearCompletion = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Challenges_NearCompletion", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Challenges_NearCompletion)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.9)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local FEButtonPanelShaderContainer0 = CoD.FE_ButtonPanelShaderContainer.new(f1_local1, f1_arg0, 0, 0, -16, 1928, 0, 0, 174, 1101)
	FEButtonPanelShaderContainer0:setAlpha(0)
	self:addElement(FEButtonPanelShaderContainer0)
	self.FEButtonPanelShaderContainer0 = FEButtonPanelShaderContainer0
	local CategoryListPanel = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -414, -356)
	CategoryListPanel:setRGB(0, 0, 0)
	CategoryListPanel:setAlpha(0)
	self:addElement(CategoryListPanel)
	self.CategoryListPanel = CategoryListPanel
	local MenuTitleBackground = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -504, -414)
	MenuTitleBackground:setRGB(0.12, 0.13, 0.19)
	MenuTitleBackground:setAlpha(0)
	self:addElement(MenuTitleBackground)
	self.MenuTitleBackground = MenuTitleBackground
	local ButtonBarBackground = LUI.UIImage.new(0, 1, -6, 0, 0.5, 0.5, 453, 498)
	ButtonBarBackground:setRGB(0.12, 0.13, 0.19)
	ButtonBarBackground:setAlpha(0)
	self:addElement(ButtonBarBackground)
	self.ButtonBarBackground = ButtonBarBackground
	local NearCompletionFrame = CoD.Challenges_FrameWidget_NearCompletion.new(f1_local1, f1_arg0, 0.5, 0.5, -822, 798, 0.5, 0.5, -448, 334)
	self:addElement(NearCompletionFrame)
	self.NearCompletionFrame = NearCompletionFrame
	local CategoryListLine = LUI.UIImage.new(0, 0, -16, 1940, 0, 0, 120, 132)
	CategoryListLine:setRGB(0.9, 0.9, 0.9)
	CategoryListLine:setAlpha(0)
	CategoryListLine:setImage(RegisterImage(0xFF01596CBF87338))
	self:addElement(CategoryListLine)
	self.CategoryListLine = CategoryListLine
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xD0A2CACF30B3030))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	NearCompletionFrame.id = "NearCompletionFrame"
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = NearCompletionFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.Challenges_NearCompletion.__onClose = function(f6_arg0)
	f6_arg0.FEButtonPanelShaderContainer0:close()
	f6_arg0.NearCompletionFrame:close()
	f6_arg0.MenuFrame:close()
	f6_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
end
