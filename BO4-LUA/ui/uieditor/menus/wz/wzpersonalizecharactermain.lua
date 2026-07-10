require("x64:eda152e1d10147a")
require("x64:78d9663be3f826")
require("x64:62080ad3aaa22da")
require("x64:1f150bc74d5590f")
CoD.WZPersonalizeCharacterMain = InheritFrom(CoD.Menu)
LUI.createMenu.WZPersonalizeCharacterMain = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WZPersonalizeCharacterMain", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	self:setClass(CoD.WZPersonalizeCharacterMain)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0.5)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local CommonBgLayoutLinkLine = CoD.CommonBgLayoutLinkLine.new(f1_local1, f1_arg0, 0.5, 0.5, 234, 943, 0, 0, 180.5, 209.5)
	CommonBgLayoutLinkLine:setAlpha(0.5)
	CommonBgLayoutLinkLine:setZRot(180)
	self:addElement(CommonBgLayoutLinkLine)
	self.CommonBgLayoutLinkLine = CommonBgLayoutLinkLine
	local CommonBgLayoutLinkLine2 = CoD.CommonBgLayoutLinkLine.new(f1_local1, f1_arg0, 0.5, 0.5, -30.5, 678.5, 0, 0, 428.5, 457.5)
	CommonBgLayoutLinkLine2:setAlpha(0.9)
	CommonBgLayoutLinkLine2:setZRot(-90)
	self:addElement(CommonBgLayoutLinkLine2)
	self.CommonBgLayoutLinkLine2 = CommonBgLayoutLinkLine2
	local CommonInformationFrame = CoD.CommonInformationFrame.new(f1_local1, f1_arg0, 0.5, 0.5, 324, 811, 0, 1, 0, 0)
	CommonInformationFrame.altHeader:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	CommonInformationFrame.header:setText(LocalizeToUpperString(@"menu/new"))
	CommonInformationFrame.description:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	self:addElement(CommonInformationFrame)
	self.CommonInformationFrame = CommonInformationFrame
	local SocialFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SocialFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	SocialFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_72AA2EA68ACC2317"))
	SocialFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SocialFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(SocialFrame)
	self.SocialFrame = SocialFrame
	local SpecialistCornerTR = LUI.UIImage.new(0.5, 0.5, 75, 99, 0, 0, 229, 253)
	SpecialistCornerTR:setAlpha(0.25)
	SpecialistCornerTR:setZRot(-90)
	SpecialistCornerTR:setScale(0.5, 0.5)
	SpecialistCornerTR:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	SpecialistCornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpecialistCornerTR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTR)
	self.SpecialistCornerTR = SpecialistCornerTR
	local SpecialistCornerTL = LUI.UIImage.new(0.5, 0.5, -634, -610, 0, 0, 229, 253)
	SpecialistCornerTL:setAlpha(0.2)
	SpecialistCornerTL:setScale(0.5, 0.5)
	SpecialistCornerTL:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	SpecialistCornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpecialistCornerTL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTL)
	self.SpecialistCornerTL = SpecialistCornerTL
	local SpecialistCornerBR = LUI.UIImage.new(0.5, 0.5, 75, 99, 0, 0, 805.5, 829.5)
	SpecialistCornerBR:setAlpha(0.2)
	SpecialistCornerBR:setZRot(180)
	SpecialistCornerBR:setScale(0.5, 0.5)
	SpecialistCornerBR:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	SpecialistCornerBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpecialistCornerBR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerBR)
	self.SpecialistCornerBR = SpecialistCornerBR
	local SpecialistCornerBL = LUI.UIImage.new(0.5, 0.5, -634, -610, 0, 0, 805.5, 829.5)
	SpecialistCornerBL:setAlpha(0.2)
	SpecialistCornerBL:setZRot(90)
	SpecialistCornerBL:setScale(0.5, 0.5)
	SpecialistCornerBL:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	SpecialistCornerBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpecialistCornerBL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerBL)
	self.SpecialistCornerBL = SpecialistCornerBL
	local CategoryTabs = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0, 0, 103, 811, 0.5, 0.5, -340.5, -279.5)
	CategoryTabs.Tabs.grid:setHorizontalCount(3)
	CategoryTabs.Tabs.grid:setDataSource("WZCharacterCategories")
	self:addElement(CategoryTabs)
	self.CategoryTabs = CategoryTabs
	local TabBottomLine = LUI.UIImage.new(0, 0, 80, 900, 0.5, 0.5, -281.5, -277.5)
	TabBottomLine:setAlpha(0.08)
	TabBottomLine:setImage(RegisterImage(@"uie_ui_menu_common_tab_line_bottom"))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	local FrameWidget = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	FrameWidget:setLeftRight(0.5, 0.5, -819, 87)
	FrameWidget:setTopBottom(0.5, 0.5, -281.5, 518.5)
	LUI.OverrideFunction_CallOriginalFirst(FrameWidget, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg0, self, element, "CommonInformationFrame")
	end)
	self:addElement(FrameWidget)
	self.FrameWidget = FrameWidget
	FrameWidget:linkToElementModel(CategoryTabs.Tabs.grid, nil, false, function(model)
		FrameWidget:setModel(model, f1_arg0)
	end)
	FrameWidget:linkToElementModel(CategoryTabs.Tabs.grid, "personalizeFrameWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			FrameWidget:changeFrameWidget(f5_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		SendClientScriptMenuChangeNotify(controller, menu, false)
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
		return true
	end, false)
	SocialFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		SocialFrame.id = "SocialFrame"
	end
	CategoryTabs.id = "CategoryTabs"
	FrameWidget.id = "FrameWidget"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FrameWidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.WZPersonalizeCharacterMain.__onClose = function(f8_arg0)
	f8_arg0.FrameWidget:close()
	f8_arg0.CommonBgLayoutLinkLine:close()
	f8_arg0.CommonBgLayoutLinkLine2:close()
	f8_arg0.CommonInformationFrame:close()
	f8_arg0.SocialFrame:close()
	f8_arg0.CategoryTabs:close()
end
