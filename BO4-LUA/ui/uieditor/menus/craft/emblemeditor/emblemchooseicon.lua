require("x64:eda152e1d10147a")
require("x64:de039829a2f4ec4")
require("x64:7889ce1e3e2e8a")
CoD.EmblemChooseIcon = InheritFrom(CoD.Menu)
LUI.createMenu.EmblemChooseIcon = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EmblemChooseIcon", f1_arg0)
	local f1_local1 = self
	SetMenuProperty(f1_local1, "_isEditor", "true")
	CoD.BreadcrumbUtility.SetClientStorageBufferForMode(f1_local1, f1_arg0, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
	CoD.CraftUtility.InvalidateSelectedDecalCategory(f1_arg0)
	self:setClass(CoD.EmblemChooseIcon)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0.2)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.05)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TiledPlusGrid = LUI.UIImage.new(0, 1.07, -135, -135, 0, 1, 0, 0)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local editorBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	editorBackground:setRGB(0, 0, 0)
	editorBackground:setAlpha(0.75)
	self:addElement(editorBackground)
	self.editorBackground = editorBackground
	local BgGrain = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgGrain:setAlpha(0.3)
	BgGrain:setImage(RegisterImage(0x34839E8065B1E53))
	BgGrain:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BgGrain:setShaderVector(0, 0, 0, 0, 0)
	BgGrain:setupNineSliceShader(196, 88)
	self:addElement(BgGrain)
	self.BgGrain = BgGrain
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xBC5A0D7A77F15BB))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local DecalListFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	DecalListFrame:setLeftRight(0.5, 0.5, -910, 910)
	DecalListFrame:setTopBottom(0.5, 0.5, -432.5, 532.5)
	self:addElement(DecalListFrame)
	self.DecalListFrame = DecalListFrame
	local EmblemSafeAreaContainer = CoD.EmblemSafeAreaContainer.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	EmblemSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(EmblemSafeAreaContainer)
	self.EmblemSafeAreaContainer = EmblemSafeAreaContainer
	DecalListFrame:linkToElementModel(EmblemSafeAreaContainer.CommonTabBar.Tabs.grid, nil, false, function(model)
		DecalListFrame:setModel(model, f1_arg0)
	end)
	DecalListFrame:linkToElementModel(EmblemSafeAreaContainer.CommonTabBar.Tabs.grid, "frameWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DecalListFrame:changeFrameWidget(f5_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "EmblemEditor",
			condition = function(menu, element, event)
				return IsEmblemEditor(f1_arg0)
			end,
		},
		{
			stateName = "Paintshop",
			condition = function(menu, element, event)
				return IsPaintshop(f1_arg0)
			end,
		},
	})
	self:registerEventHandler("menu_loaded", function(self, event)
		local f8_local0 = nil
		if self.menuLoaded then
			f8_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f8_local0 = self.super:menuLoaded(event)
		end
		if IsEmblemEditor(f1_arg0) then
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
		elseif IsPaintshop(f1_arg0) then
			CoD.CraftUtility.EmblemChooseIcon_SetPreviewDecalCamera(self, self, f1_arg0)
		end
		if not f8_local0 then
			f8_local0 = self:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if IsEmblemEditor(controller) then
			CoD.CraftUtility.EmblemChooseIcon_SelectionRejected(self, element, controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif IsPaintshop(controller) then
			CoD.CraftUtility.EmblemChooseIcon_SelectionRejected(self, element, controller)
			CoD.CraftUtility.EmblemChooseIcon_RevertPreviewDecalCamera(self, element, controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsEmblemEditor(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif IsPaintshop(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x0, nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.CraftUtility.EmblemChooseIcon_Cleanup(self, f1_arg0)
		CoD.CraftUtility.CraftEditor_RestoreDecalCategory(self, element, f1_arg0)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	DecalListFrame.id = "DecalListFrame"
	EmblemSafeAreaContainer.id = "EmblemSafeAreaContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = DecalListFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.EmblemChooseIcon.__resetProperties = function(f14_arg0)
	f14_arg0.editorBackground:completeAnimation()
	f14_arg0.editorBackground:setAlpha(0.75)
end
CoD.EmblemChooseIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	EmblemEditor = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Paintshop = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.editorBackground:completeAnimation()
			f17_arg0.editorBackground:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.editorBackground)
		end,
	},
}
CoD.EmblemChooseIcon.__onClose = function(f18_arg0)
	f18_arg0.DecalListFrame:close()
	f18_arg0.Background:close()
	f18_arg0.MenuFrame:close()
	f18_arg0.EmblemSafeAreaContainer:close()
end
