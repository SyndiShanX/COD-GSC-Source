require("x64:f00a10fc8301da2")
require("x64:eda152e1d10147a")
require("x64:57cc8e6b7e37b6b")
require("x64:7889ce1e3e2e8a")
CoD.PaintshopChooseIcon = InheritFrom(CoD.Menu)
LUI.createMenu.PaintshopChooseIcon = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PaintshopChooseIcon", f1_arg0)
	local f1_local1 = self
	SetMenuProperty(f1_local1, "_isEditor", "true")
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.CraftUtility.InvalidateSelectedDecalCategory(f1_arg0)
	self:setClass(CoD.PaintshopChooseIcon)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	Background:setAlpha(0)
	Background.BGBlur:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local AARCommonBacking = CoD.AARCommonBacking.new(f1_local1, f1_arg0, -0.5, 0.5, 130, 130, 0, 1, 0, 0)
	AARCommonBacking.Backer:setRGB(0, 0, 0)
	AARCommonBacking.Backer:setAlpha(0.6)
	self:addElement(AARCommonBacking)
	self.AARCommonBacking = AARCommonBacking
	local BGEnhancement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGEnhancement:setRGB(0, 0, 0)
	BGEnhancement:setAlpha(0)
	self:addElement(BGEnhancement)
	self.BGEnhancement = BGEnhancement
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.05)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TiledPlusGrid = LUI.UIImage.new(0, 1.07, -135, -135, 0, 0, 0, 1080)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
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
	BgGrain:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BgGrain:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BgGrain:setShaderVector(0, 0, 0, 0, 0)
	BgGrain:setupNineSliceShader(196, 88)
	self:addElement(BgGrain)
	self.BgGrain = BgGrain
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_BC5A0D7A77F15BB"))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local DecalListFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	DecalListFrame:setLeftRight(0.5, 0.5, -910, 910)
	DecalListFrame:setTopBottom(0.5, 0.5, -452.5, 512.5)
	self:addElement(DecalListFrame)
	self.DecalListFrame = DecalListFrame
	local SafeAreaContainer = CoD.PaintshopSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	SafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(SafeAreaContainer)
	self.SafeAreaContainer = SafeAreaContainer
	DecalListFrame:linkToElementModel(SafeAreaContainer.CommonTabBar.Tabs.grid, nil, false, function(model)
		DecalListFrame:setModel(model, f1_arg0)
	end)
	DecalListFrame:linkToElementModel(SafeAreaContainer.CommonTabBar.Tabs.grid, "frameWidget", true, function(model)
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
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
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
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsPaintshop(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_start"], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"hash_0", nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.CraftUtility.EmblemChooseIcon_Cleanup(self, f1_arg0)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
	end)
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	DecalListFrame.id = "DecalListFrame"
	SafeAreaContainer.id = "SafeAreaContainer"
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
CoD.PaintshopChooseIcon.__resetProperties = function(f14_arg0)
	f14_arg0.editorBackground:completeAnimation()
	f14_arg0.editorBackground:setAlpha(0.75)
end
CoD.PaintshopChooseIcon.__clipsPerState = {
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
CoD.PaintshopChooseIcon.__onClose = function(f18_arg0)
	f18_arg0.DecalListFrame:close()
	f18_arg0.Background:close()
	f18_arg0.AARCommonBacking:close()
	f18_arg0.MenuFrame:close()
	f18_arg0.SafeAreaContainer:close()
end
