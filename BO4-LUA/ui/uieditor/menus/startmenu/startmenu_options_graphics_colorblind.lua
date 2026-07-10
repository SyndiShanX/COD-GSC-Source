require("x64:71d4e66447f837e")
require("x64:d6ecdf7755aeddc")
require("x64:e41af73729601d6")
require("x64:447b94b1bc3bd97")
require("x64:7889ce1e3e2e8a")
require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
require("x64:a83717e9f99925a")
CoD.StartMenu_Options_Graphics_Colorblind = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_Graphics_Colorblind = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_Graphics_Colorblind", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "profile.colorblindMode")
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.StartMenu_Options_Graphics_Colorblind)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local MenuFrame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 1, 1, -1080, 0)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local Buttons = LUI.UIList.new(f1_local1, f1_arg0, 10, 0, nil, false, false, false, false)
	Buttons:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsPlayerSettingItemSelected(self, element, f1_arg0)
			end,
		},
	})
	local BGFill = Buttons
	local Description = Buttons.subscribeToModel
	local Image = Engine[0x4DF5CFBC1771947](f1_arg0)
	Description(BGFill, Image.PlayerSettingsUpdate, function(f3_arg0)
		f1_local1:updateElementState(Buttons, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f3_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	Buttons:linkToElementModel(Buttons, "currentSelection", true, function(model)
		f1_local1:updateElementState(Buttons, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "currentSelection",
		})
	end)
	Buttons:setLeftRight(0.5, 0.5, -615, 615)
	Buttons:setTopBottom(0.5, 0.5, 330, 390)
	Buttons:setZoom(50)
	Buttons:setWidgetType(CoD.StartMenu_Options_SettingGridItem)
	Buttons:setHorizontalCount(4)
	Buttons:setSpacing(10)
	Buttons:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Buttons:linkToElementModel(self, "optionsDatasource", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Buttons:setDataSource(f5_local0)
		end
	end)
	Buttons:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(Buttons, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		ForceNotifyControllerModel(controller, "profile.colorblindMode")
		PlaySoundAlias("uin_paint_decal_nav")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(Buttons)
	self.Buttons = Buttons
	Description = LUI.UIText.new(0.5, 0.5, -557, 557, 0.5, 0.5, -300.5, -279.5)
	Description:setRGB(0.6, 0.6, 0.6)
	Description:setZoom(40)
	Description:setTTF("ttmussels_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Description:linkToElementModel(self, "hintText", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Description:setText(f9_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	BGFill = LUI.UIImage.new(0.5, 0.5, -613.5, 613.5, 0.5, 0.5, -322.5, 322.5)
	BGFill:setRGB(0, 0, 0)
	BGFill:setAlpha(0.55)
	BGFill:setZoom(40)
	BGFill:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	BGFill:setShaderVector(0, 0, 0, 0, 0)
	BGFill:setupNineSliceShader(6, 6)
	self:addElement(BGFill)
	self.BGFill = BGFill
	Image = CoD.StartMenu_Options_Graphics_ColorBlindMinimapPreview.new(f1_local1, f1_arg0, 0.5, 0.5, -375, 375, 0.5, 0.5, -195, 205)
	Image:setZoom(40)
	self:addElement(Image)
	self.Image = Image
	local BGFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -613.5, 613.5, 0.5, 0.5, -322.5, 322.5)
	BGFrame:setAlpha(0.01)
	BGFrame:setZoom(40)
	self:addElement(BGFrame)
	self.BGFrame = BGFrame
	local BGCorner = CoD.StartMenuOptionsMainCorners.new(f1_local1, f1_arg0, 0.5, 0.5, -613.5, 613.5, 0.5, 0.5, -322.5, 322.5)
	BGCorner:setAlpha(0.95)
	BGCorner:setZoom(40)
	self:addElement(BGCorner)
	self.BGCorner = BGCorner
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.subtitle.subtitle:setText("")
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	self.CommonHeader:linkToElementModel(self, "name", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(f10_local0))
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_2", function(element, menu, controller, model)
		CoD.OptionsUtility.ResetPlayerSettingToDefault(self, controller)
		ForceNotifyControllerModel(controller, "profile.colorblindMode")
		PlaySoundAlias("uin_paint_decal_nav")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x19D60864B204458, nil, "ui_contextual_2")
		return true
	end, false)
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	Buttons.id = "Buttons"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = Buttons
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local12 = self
	CoD.OptionsUtility.InitPlayerSettingWidget(self, "Buttons")
	CoD.OptionsUtility.SetPlayerSettingsModel(self, f1_arg0, "colorblind_mode")
	f1_local12 = CommonHeader
	if not IsPC() then
		SizeToSafeArea(f1_local12, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Graphics_Colorblind.__onClose = function(f15_arg0)
	f15_arg0.Background:close()
	f15_arg0.MenuFrame:close()
	f15_arg0.Buttons:close()
	f15_arg0.Description:close()
	f15_arg0.Image:close()
	f15_arg0.BGFrame:close()
	f15_arg0.BGCorner:close()
	f15_arg0.CommonHeader:close()
	f15_arg0.BackingGrayMediumLeft:close()
end
