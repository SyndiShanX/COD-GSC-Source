require("x64:c61a61dbc4fee01")
require("x64:3f0c583dc4db051")
require("x64:d7ba7c36104672")
CoD.FileshareOptions_Delete = InheritFrom(CoD.Menu)
LUI.createMenu.FileshareOptions_Delete = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FileshareOptions_Delete", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.FileshareOptions_Delete)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local FullscreenPopupTemplate0 = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FullscreenPopupTemplate0:mergeStateConditions({
		{
			stateName = "WorkingState",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.FileshareIsDeleting()
			end,
		},
		{
			stateName = "ErrorState",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.FileshareIsDeletingInError()
			end,
		},
	})
	local FileshareSelectedItemPreview = FullscreenPopupTemplate0
	local buttons = FullscreenPopupTemplate0.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	buttons(FileshareSelectedItemPreview, f1_local5["fileshareRoot.deleteTask.state"], function(f4_arg0)
		f1_local1:updateElementState(FullscreenPopupTemplate0, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "fileshareRoot.deleteTask.state",
		})
	end, false)
	FullscreenPopupTemplate0.ButtonList:setDataSource("FileshareOptionsDeleteButtonList")
	FullscreenPopupTemplate0.Subtitle:setText(Engine[0xF9F1239CFD921FE](0xE14B8D67CB9DA83))
	FullscreenPopupTemplate0.ErrorSubtitle:setText(Engine[0xF9F1239CFD921FE](0xA4F6521ABCD39B3))
	FullscreenPopupTemplate0.WorkingTitle:setText(Engine[0xF9F1239CFD921FE](0x8873C1F9EB8F341))
	FullscreenPopupTemplate0.Title:setText(Engine[0xF9F1239CFD921FE](0x310C36882644FC9))
	FullscreenPopupTemplate0.DoneTitle:setText(Engine[0xF9F1239CFD921FE](0x961E616AE14B756))
	self:addElement(FullscreenPopupTemplate0)
	self.FullscreenPopupTemplate0 = FullscreenPopupTemplate0
	buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_local1, f1_arg0, 0.5, 0.5, -811, -163, 0.5, 0.5, 258, 306)
	self:addElement(buttons)
	self.buttons = buttons
	FileshareSelectedItemPreview = CoD.FileshareSelectedItemPreview.new(f1_local1, f1_arg0, 0.5, 0.5, -897.5, -397.5, 0.5, 0.5, -176.5, 203.5)
	FileshareSelectedItemPreview:subscribeToGlobalModel(f1_arg0, "FileshareSelectedItem", nil, function(model)
		FileshareSelectedItemPreview:setModel(model, f1_arg0)
	end)
	self:addElement(FileshareSelectedItemPreview)
	self.FileshareSelectedItemPreview = FileshareSelectedItemPreview
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ENTER", function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ENTER")
		return false
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "fileshareRoot.deleteTask.state", function(model)
		local f10_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.deleteTask.state", Enum[0xE798E99E27D081E][0xFE5B3BE5B00EEEA]) then
			CoD.FileshareUtility.DeleteDone(self, f10_local0, f1_arg0, "", f1_local1)
			GoBackToMenu(f1_local1, f1_arg0, "Theater_SelectFilm")
		end
	end)
	FullscreenPopupTemplate0.buttonPC:setModel(self.buttonModel, f1_arg0)
	FullscreenPopupTemplate0.id = "FullscreenPopupTemplate0"
	buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		buttons.id = "buttons"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FullscreenPopupTemplate0
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = FullscreenPopupTemplate0
	if IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local5, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
	end
	return self
end
CoD.FileshareOptions_Delete.__onClose = function(f11_arg0)
	f11_arg0.FullscreenPopupTemplate0:close()
	f11_arg0.buttons:close()
	f11_arg0.FileshareSelectedItemPreview:close()
end
