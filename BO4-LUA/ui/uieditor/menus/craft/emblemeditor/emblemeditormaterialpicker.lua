require("x64:eda152e1d10147a")
require("x64:da97d095e7674d3")
require("x64:9827234958dd6bd")
require("x64:3a3e3d8a297e8f")
require("x64:ece21f2f02e5733")
require("x64:543d2b49d2efc00")
CoD.EmblemEditorMaterialPicker = InheritFrom(CoD.Menu)
LUI.createMenu.EmblemEditorMaterialPicker = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("EmblemEditorMaterialPicker", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.EmblemEditorMaterialPicker)
	self.soundSet = "SelectColor"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 3, 3, 0.5, 1.5, -540, -540)
	Background:setImage(RegisterImage(@"uie_t7_mp_menu_cac_version6_backdrop720p"))
	self:addElement(Background)
	self.Background = Background
	local ScreenBkgd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ScreenBkgd:setRGB(0, 0, 0)
	ScreenBkgd:setAlpha(0.75)
	self:addElement(ScreenBkgd)
	self.ScreenBkgd = ScreenBkgd
	local emblemDrawWidget0 = CoD.EmblemDrawWidgetNew.new(f1_local1, f1_arg0, 0.5, 0.5, -270, 270, 0, 0, 168, 708)
	self:addElement(emblemDrawWidget0)
	self.emblemDrawWidget0 = emblemDrawWidget0
	local materialSwatch = CoD.EmblemEditorMaterialSwatch.new(f1_local1, f1_arg0, 0.5, 0.5, -457.5, 422.5, 0, 0, 731, 971)
	self:addElement(materialSwatch)
	self.materialSwatch = materialSwatch
	local materialInfo = CoD.EmblemEditorMaterialInfo.new(f1_local1, f1_arg0, 0.5, 0.5, -270, 270, 0.5, 0.5, -449, -381)
	materialInfo:subscribeToGlobalModel(f1_arg0, "EmblemSelectedLayerProperties", nil, function(model)
		materialInfo:setModel(model, f1_arg0)
	end)
	self:addElement(materialInfo)
	self.materialInfo = materialInfo
	local materialControls = CoD.EmblemEditorMaterialControls.new(f1_local1, f1_arg0, 0.5, 0.5, 348, 768, 0, 0, 168, 358)
	materialControls:mergeStateConditions({
		{
			stateName = "FixedScale",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.materialScaleMode", Enum[@"customizationscaletype"][@"customization_scale_type_fixed"])
			end,
		},
		{
			stateName = "FreeScale",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "Emblem.EmblemProperties.materialScaleMode", Enum[@"customizationscaletype"][@"customization_scale_type_free"])
			end,
		},
	})
	local actionsListPC = materialControls
	local f1_local9 = materialControls.subscribeToModel
	local EmblemEditorFrame = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local9(actionsListPC, EmblemEditorFrame["Emblem.EmblemProperties.materialScaleMode"], function(f5_arg0)
		f1_local1:updateElementState(materialControls, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "Emblem.EmblemProperties.materialScaleMode",
		})
	end, false)
	self:addElement(materialControls)
	self.materialControls = materialControls
	f1_local9 = nil
	actionsListPC = LUI.UIList.new(f1_local1, f1_arg0, 0, 0, nil, false, false, false, false)
	actionsListPC:setLeftRight(0.5, 0.5, 390, 765)
	actionsListPC:setTopBottom(0, 0, 150, 700)
	actionsListPC:setAlpha(0)
	actionsListPC:setWidgetType(CoD.CraftActionHeader)
	actionsListPC:setVerticalCount(10)
	actionsListPC:setSpacing(0)
	actionsListPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	actionsListPC:setDataSource("CraftMaterialActionsPC")
	self:addElement(actionsListPC)
	self.actionsListPC = actionsListPC
	EmblemEditorFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	EmblemEditorFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_7E8932DB4373E47F"))
	EmblemEditorFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			EmblemEditorFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(EmblemEditorFrame)
	self.EmblemEditorFrame = EmblemEditorFrame
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				local f7_local0
				if not IsGamepad(f1_arg0) then
					f7_local0 = IsPC()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f8_arg1)
	end)
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13.LastInput, function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if IsPC() then
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		else
			CoD.CraftUtility.EmblemEditor_RevertLayerChanges(self, controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_ltrig"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseMaterial_UpdateMaterialAngleByStep(self, element, -1, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rtrig"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseMaterial_UpdateMaterialAngleByStep(self, element, 1, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_0", nil, nil)
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseMaterial_ToggleScaleMode(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_0", nil, nil)
		return false
	end, false)
	if CoD.isPC then
		emblemDrawWidget0.id = "emblemDrawWidget0"
	end
	materialSwatch.id = "materialSwatch"
	actionsListPC.id = "actionsListPC"
	EmblemEditorFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		EmblemEditorFrame.id = "EmblemEditorFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = materialSwatch
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local12 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.CraftUtility.SetupMouseScrollingEmblemMaterialScale(f1_local1, f1_arg0)
	CoD.CraftUtility.SetupRightStickEmblemMaterialScale(f1_local1, f1_arg0)
	return self
end
CoD.EmblemEditorMaterialPicker.__resetProperties = function(f18_arg0)
	f18_arg0.ScreenBkgd:completeAnimation()
	f18_arg0.Background:completeAnimation()
	f18_arg0.actionsListPC:completeAnimation()
	f18_arg0.materialInfo:completeAnimation()
	f18_arg0.materialControls:completeAnimation()
	f18_arg0.ScreenBkgd:setAlpha(0.75)
	f18_arg0.Background:setAlpha(1)
	f18_arg0.actionsListPC:setLeftRight(0.5, 0.5, 390, 765)
	f18_arg0.actionsListPC:setTopBottom(0, 0, 150, 700)
	f18_arg0.actionsListPC:setAlpha(0)
	f18_arg0.materialInfo:setLeftRight(0.5, 0.5, -270, 270)
	f18_arg0.materialInfo:setTopBottom(0.5, 0.5, -449, -381)
	f18_arg0.materialControls:setAlpha(1)
end
CoD.EmblemEditorMaterialPicker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.Background:completeAnimation()
			f19_arg0.Background:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Background)
			f19_arg0.ScreenBkgd:completeAnimation()
			f19_arg0.ScreenBkgd:setAlpha(0.75)
			f19_arg0.clipFinished(f19_arg0.ScreenBkgd)
			f19_arg0.materialInfo:completeAnimation()
			f19_arg0.materialInfo:setLeftRight(0.5, 0.5, -270, 270)
			f19_arg0.materialInfo:setTopBottom(0.5, 0.5, -449, -381)
			f19_arg0.clipFinished(f19_arg0.materialInfo)
			f19_arg0.actionsListPC:completeAnimation()
			f19_arg0.actionsListPC:setLeftRight(0.5, 0.5, 96, 471)
			f19_arg0.actionsListPC:setTopBottom(0, 0, 193.5, 520.5)
			f19_arg0.clipFinished(f19_arg0.actionsListPC)
		end,
	},
	PC = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.materialInfo:completeAnimation()
			f20_arg0.materialInfo:setLeftRight(0.5, 0.5, -721, -469)
			f20_arg0.clipFinished(f20_arg0.materialInfo)
			f20_arg0.materialControls:completeAnimation()
			f20_arg0.materialControls:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.materialControls)
			f20_arg0.actionsListPC:completeAnimation()
			f20_arg0.actionsListPC:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.actionsListPC)
		end,
	},
}
CoD.EmblemEditorMaterialPicker.__onClose = function(f21_arg0)
	f21_arg0.emblemDrawWidget0:close()
	f21_arg0.materialSwatch:close()
	f21_arg0.materialInfo:close()
	f21_arg0.materialControls:close()
	f21_arg0.actionsListPC:close()
	f21_arg0.EmblemEditorFrame:close()
end
