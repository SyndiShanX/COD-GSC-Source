require("x64:1e10bd8956012bd")
require("x64:f13c3cfcae3a2d7")
require("x64:7889ce1e3e2e8a")
CoD.MPSpecialistHUBTags = InheritFrom(CoD.Menu)
LUI.createMenu.MPSpecialistHUBTags = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MPSpecialistHUBTags", f1_arg0)
	local f1_local1 = self
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, f1_local1, f1_arg1.model)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1.properties)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "MPSpecialistHUBBindWheel.NoBackground", false)
	self:setClass(CoD.MPSpecialistHUBTags)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0.2)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local TiledPlusGrid = LUI.UIImage.new(0.5, 0.5, -1095, 960, 0, 0, 0, 1080)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local Frame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	Frame:setLeftRight(0.5, 0.5, -960, 960)
	Frame:setTopBottom(0.5, 0.5, -540, 540)
	LUI.OverrideFunction_CallOriginalFirst(Frame, "changeFrameWidget", function(element, controller, f2_arg2)
		UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
		UpdateSelfState(self, f1_arg0)
	end)
	self:addElement(Frame)
	self.Frame = Frame
	local MPSpecialistHUBTagsSafeAreaContainer = CoD.MPSpecialistHUBTags_SafeAreaContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MPSpecialistHUBTagsSafeAreaContainer.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_246EFDF3FB2763B5"))
	MPSpecialistHUBTagsSafeAreaContainer:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MPSpecialistHUBTagsSafeAreaContainer.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	MPSpecialistHUBTagsSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(MPSpecialistHUBTagsSafeAreaContainer)
	self.MPSpecialistHUBTagsSafeAreaContainer = MPSpecialistHUBTagsSafeAreaContainer
	Frame:linkToElementModel(MPSpecialistHUBTagsSafeAreaContainer.CommonTabBarLeftAlign.Tabs.grid, "tabWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Frame:changeFrameWidget(f5_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "NoBackground",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueTrue(f1_arg0, "MPSpecialistHUBBindWheel.NoBackground")
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["MPSpecialistHUBBindWheel.NoBackground"], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "MPSpecialistHUBBindWheel.NoBackground",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		CoD.BaseUtility.UINoAction()
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		ClearMenuSavedState(f1_local1)
	end)
	self.__on_menuOpened_self = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		local f13_local0 = self
		MenuUnhideFreeCursor(f13_arg2, f13_arg1)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	Frame.id = "Frame"
	MPSpecialistHUBTagsSafeAreaContainer.id = "MPSpecialistHUBTagsSafeAreaContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = Frame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.MPSpecialistHUBTags.__resetProperties = function(f15_arg0)
	f15_arg0.Background:completeAnimation()
	f15_arg0.TiledPlusGrid:completeAnimation()
	f15_arg0.BlackBacking:completeAnimation()
	f15_arg0.Background:setAlpha(1)
	f15_arg0.TiledPlusGrid:setAlpha(0.05)
	f15_arg0.BlackBacking:setAlpha(0.2)
end
CoD.MPSpecialistHUBTags.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	NoBackground = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.Background:completeAnimation()
			f17_arg0.Background:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Background)
			f17_arg0.BlackBacking:completeAnimation()
			f17_arg0.BlackBacking:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.BlackBacking)
			f17_arg0.TiledPlusGrid:completeAnimation()
			f17_arg0.TiledPlusGrid:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TiledPlusGrid)
		end,
	},
}
CoD.MPSpecialistHUBTags.__onClose = function(f18_arg0)
	f18_arg0.__on_close_removeOverrides()
	f18_arg0.Frame:close()
	f18_arg0.Background:close()
	f18_arg0.MPSpecialistHUBTagsSafeAreaContainer:close()
end
