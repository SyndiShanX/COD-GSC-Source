require("x64:c2f840fd2528321")
require("x64:96b29a3176ada0f")
require("x64:5ebe1d17ed0d7b9")
require("x64:3f0c583dc4db051")
require("x64:d7ba7c36104672")
require("x64:a9255c570c68aa8")
require("x64:5498fd235ed9285")
require("x64:8a2bfd7fd77a149")
CoD.DemoFileshareUpload = InheritFrom(CoD.Menu)
LUI.createMenu.DemoFileshareUpload = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DemoFileshareUpload", f1_arg0)
	local f1_local1 = self
	if IsPC() then
		SetGlobalModelValueArg("fileshareRoot.uploadTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_idle"])
		CoD.FileshareUtility.UpdateCurrentQuota(f1_arg0)
		CoD.BaseUtility.InitControllerModel(f1_arg0, "DemoTitleText")
		CoD.BaseUtility.InitControllerModel(f1_arg0, "DemoDescText")
	else
		SetGlobalModelValueArg("fileshareRoot.uploadTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_idle"])
		CoD.FileshareUtility.UpdateCurrentQuota(f1_arg0)
	end
	self:setClass(CoD.DemoFileshareUpload)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local emptyFocusableNoCursorUpdate = nil
	emptyFocusableNoCursorUpdate = CoD.emptyFocusableNoCursorUpdate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusableNoCursorUpdate)
	self.emptyFocusableNoCursorUpdate = emptyFocusableNoCursorUpdate
	local FullscreenPopupTemplate = CoD.FullscreenPopupTemplate.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FullscreenPopupTemplate:mergeStateConditions({
		{
			stateName = "WorkingState",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.FileshareIsUploading()
			end,
		},
		{
			stateName = "ErrorState",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.FileshareIsUploadingInError()
			end,
		},
	})
	local TitleText = FullscreenPopupTemplate
	local TitleDescription = FullscreenPopupTemplate.subscribeToModel
	local LblPermissions = Engine[@"getglobalmodel"]()
	TitleDescription(TitleText, LblPermissions["fileshareRoot.uploadTask.state"], function(f4_arg0)
		f1_local1:updateElementState(FullscreenPopupTemplate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "fileshareRoot.uploadTask.state",
		})
	end, false)
	FullscreenPopupTemplate.Subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29503CD034274830"))
	FullscreenPopupTemplate.ErrorSubtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_39C62D3C1C35DC01"))
	FullscreenPopupTemplate.WorkingTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5C76223999D97EC9"))
	FullscreenPopupTemplate.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_34FBFD6B591E8B59"))
	FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(@"menu/new"))
	self:addElement(FullscreenPopupTemplate)
	self.FullscreenPopupTemplate = FullscreenPopupTemplate
	TitleDescription = LUI.UIText.new(0.5, 0.5, -273, 829, 0.5, 0.5, -1, 20)
	TitleDescription:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TitleDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/description"))
	TitleDescription:setTTF("ttmussels_regular")
	TitleDescription:setLetterSpacing(2)
	TitleDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TitleDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TitleDescription)
	self.TitleDescription = TitleDescription
	TitleText = LUI.UIText.new(0.5, 0.5, -273, 829, 0.5, 0.5, -94, -73)
	TitleText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TitleText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/title"))
	TitleText:setTTF("ttmussels_regular")
	TitleText:setLetterSpacing(2)
	TitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TitleText)
	self.TitleText = TitleText
	LblPermissions = LUI.UIText.new(0.5, 0.5, -267, -217, 0.5, 0.5, 88, 126)
	LblPermissions:setAlpha(0)
	LblPermissions:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_permissions"))
	LblPermissions:setTTF("default")
	LblPermissions:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LblPermissions:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(LblPermissions)
	self.LblPermissions = LblPermissions
	local AllowDownload0 = CoD.AllowDownload.new(f1_local1, f1_arg0, 0.5, 0.5, -304, -274, 0.5, 0.5, 136, 164)
	AllowDownload0:setAlpha(0)
	self:addElement(AllowDownload0)
	self.AllowDownload0 = AllowDownload0
	local leftButtonBar = CoD.fe_LeftContainer_NOTLobby.new(f1_local1, f1_arg0, 0.5, 0.5, -350, 298, 0.5, 0.5, 188, 236)
	self:addElement(leftButtonBar)
	self.leftButtonBar = leftButtonBar
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 181, 711, 0.5, 0.5, 83, 176)
	SlotsUsedWidget:mergeStateConditions({
		{
			stateName = "Warning",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.IsLowOnSlots(f1_arg0) and not CoD.FileshareUtility.AreSlotsFull(f1_arg0)
			end,
		},
		{
			stateName = "SlotsFull",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.AreSlotsFull(f1_arg0)
			end,
		},
	})
	SlotsUsedWidget.Title:setText(LocalizeToUpperString(0xE192601D65F99E))
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuota", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f7_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuotaUsed", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f8_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuota", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuota", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuotaUsedPercent", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4))))))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "GlobalModel", "FileshareRoot.ready", function(model)
		local f12_local0 = SlotsUsedWidget
		CoD.FileshareUtility.UpdateCurrentQuota(f1_arg0)
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	local GametypeOnMapName = LUI.UIText.new(0.5, 0.5, -749, -289, 0.5, 0.5, 150, 171)
	GametypeOnMapName:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	GametypeOnMapName:setText(GetGameModeOnMapName())
	GametypeOnMapName:setTTF("ttmussels_regular")
	GametypeOnMapName:setLetterSpacing(2)
	GametypeOnMapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GametypeOnMapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GametypeOnMapName)
	self.GametypeOnMapName = GametypeOnMapName
	local Thumbnail = LUI.UIElement.new(0.5, 0.5, -742, -296, 0.5, 0.5, -126.5, 134.5)
	Thumbnail:subscribeToGlobalModel(f1_arg0, "Demo", "savePopupThumbnailFileId", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Thumbnail:setupImageViewer(GetImageViewerParams("UI_SCREENSHOT_TYPE_THUMBNAIL", f13_local0))
		end
	end)
	self:addElement(Thumbnail)
	self.Thumbnail = Thumbnail
	local ThumbnailFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -749, -289, 0.5, 0.5, -133, 141)
	ThumbnailFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ThumbnailFrame:setAlpha(0.04)
	self:addElement(ThumbnailFrame)
	self.ThumbnailFrame = ThumbnailFrame
	local ButtonSave2 = CoD.EmblemOptionsButton.new(f1_local1, f1_arg0, 0.5, 0.5, -273, 127, 0.5, 0.5, 113, 173)
	ButtonSave2.Button.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_38BF98F9DA1FC248"))
	local f1_local14 = ButtonSave2
	local f1_local15 = ButtonSave2.subscribeToModel
	local TitleTextBox = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, TitleTextBox["fileshareRoot.uploadTask.state"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	ButtonSave2:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f15_local0
	end)
	f1_local1:AddButtonCallbackFunction(ButtonSave2, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ENTER", function(element, menu, controller, model)
		if not CoD.FileshareUtility.FileshareIsUploading() and not CoD.FileshareUtility.ShouldDisablePrivateUpload(controller) then
			CoD.FileshareUtility.FilesharePrivateUpload(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.FileshareUtility.FileshareIsUploading() and not CoD.FileshareUtility.ShouldDisablePrivateUpload(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ENTER")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ButtonSave2)
	self.ButtonSave2 = ButtonSave2
	f1_local15 = nil
	f1_local15 = LUI.UIElement.createFake()
	self.ButtonDescription2 = f1_local15
	f1_local14 = nil
	f1_local14 = LUI.UIElement.createFake()
	self.ButtonTitle2 = f1_local14
	TitleTextBox = nil
	TitleTextBox = CoD.DemoRenameTextBox.new(f1_local1, f1_arg0, 0.5, 0.5, -280, 132, 0.5, 0.5, -68, -8)
	TitleTextBox:mergeStateConditions({
		{
			stateName = "InputState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "DemoTitleText")
			end,
		},
	})
	local f1_local17 = TitleTextBox
	local DescTextBox = TitleTextBox.subscribeToModel
	local f1_local19 = Engine[@"getmodelforcontroller"](f1_arg0)
	DescTextBox(f1_local17, f1_local19.DemoTitleText, function(f19_arg0)
		f1_local1:updateElementState(TitleTextBox, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "DemoTitleText",
		})
	end, false)
	TitleTextBox:subscribeToGlobalModel(f1_arg0, "Demo", "savePopupTitle", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			TitleTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f20_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(TitleTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "DemoTitleText") and CoD.FileshareUtility.IsCurrentCategoryEqualToValue("clip_private") then
			SetElementState(self, element, f1_arg0, "DefaultState")
			CoD.DemoUtility.SaveFileProperty(element, Enum[@"demokeyboardmodes"][@"demo_keyboard_clip_name_ingame"])
		elseif CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "DemoTitleText") and CoD.FileshareUtility.IsCurrentCategoryEqualToValue("screenshot_private") then
			SetElementState(self, element, f1_arg0, "DefaultState")
			CoD.DemoUtility.SaveFileProperty(element, Enum[@"demokeyboardmodes"][@"demo_keyboard_screenshot_name_ingame"])
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(TitleTextBox, "close", function(element)
		if IsPC() then
			SetControllerModelValue(f1_arg0, "DemoTitleText", "")
		end
	end)
	self:addElement(TitleTextBox)
	self.TitleTextBox = TitleTextBox
	DescTextBox = nil
	DescTextBox = CoD.DemoRenameTextBox.new(f1_local1, f1_arg0, 0.5, 0.5, -280, 132, 0.5, 0.5, 23, 83)
	DescTextBox:mergeStateConditions({
		{
			stateName = "InputState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "DemoDescText")
			end,
		},
	})
	f1_local19 = DescTextBox
	f1_local17 = DescTextBox.subscribeToModel
	local f1_local20 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local17(f1_local19, f1_local20.DemoDescText, function(f24_arg0)
		f1_local1:updateElementState(DescTextBox, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f24_arg0:get(),
			modelName = "DemoDescText",
		})
	end, false)
	DescTextBox:subscribeToGlobalModel(f1_arg0, "Demo", "savePopupDescription", function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			DescTextBox.RenameText:setText(CoD.BaseUtility.LocalizeIfXHash(f25_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(DescTextBox, "childFocusLost", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "DemoDescText") and CoD.FileshareUtility.IsCurrentCategoryEqualToValue("clip_private") then
			SetElementState(self, element, f1_arg0, "DefaultState")
			CoD.DemoUtility.SaveFileProperty(element, Enum[@"demokeyboardmodes"][@"demo_keyboard_clip_desc_ingame"])
		elseif CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "DemoDescText") and CoD.FileshareUtility.IsCurrentCategoryEqualToValue("screenshot_private") then
			SetElementState(self, element, f1_arg0, "DefaultState")
			CoD.DemoUtility.SaveFileProperty(element, Enum[@"demokeyboardmodes"][@"demo_keyboard_screenshot_desc_ingame"])
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(DescTextBox, "close", function(element)
		if IsPC() then
			SetControllerModelValue(f1_arg0, "DemoDescText", "")
		end
	end)
	self:addElement(DescTextBox)
	self.DescTextBox = DescTextBox
	self:mergeStateConditions({
		{
			stateName = "Working",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.FileshareIsUploading()
			end,
		},
		{
			stateName = "Fetching",
			condition = function(menu, element, event)
				return not CoD.FileshareUtility.FileshareIsReadyToUpload(f1_arg0)
			end,
		},
	})
	f1_local19 = self
	f1_local17 = self.subscribeToModel
	f1_local20 = Engine[@"getglobalmodel"]()
	f1_local17(f1_local19, f1_local20["fileshareRoot.uploadTask.state"], function(f30_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f30_arg0:get(),
			modelName = "fileshareRoot.uploadTask.state",
		})
	end, false)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f31_local0 = nil
		if self.OcclusionChange then
			f31_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f31_local0 = self.super:OcclusionChange(event)
		end
		UpdateSelfState(self, f1_arg0)
		if not f31_local0 then
			f31_local0 = self:dispatchEventToChildren(event)
		end
		return f31_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.DemoUtility.UploadClip_GoBack(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if CoD.FileshareUtility.AreSlotsFull(controller) then
			CoD.FileshareUtility.OpenDeleteFileshareFile(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.FileshareUtility.AreSlotsFull(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_5A9A7F1FDCC1803E", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f36_arg2, f36_arg3, f36_arg4)
		if IsMenuInState(f1_local1, "SlotsFull") then
			SetFocusToElement(self, "FullscreenPopupTemplate", controller)
		elseif IsMenuInState(f1_local1, "DefaultState") then
			SetFocusToElement(self, "GunsmithInputButton", controller)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "ready", function(model)
		local f37_local0 = self
		if CoD.FileshareUtility.FileshareIsReadyToUpload(f1_arg0) and not FileshareShowcaseSlotsAvailable(f1_arg0) then
			SetState(self, "SlotsFull", f1_arg0)
		elseif CoD.FileshareUtility.FileshareIsReadyToUpload(f1_arg0) and FileshareShowcaseSlotsAvailable(f1_arg0) then
			SetState(self, "DefaultState", f1_arg0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "fileshareRoot.uploadTask.state", function(model)
		local f38_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.uploadTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_done"]) then
			CoD.DemoUtility.UploadClip_GoBack(self, f38_local0, f1_arg0, f1_local1)
			CoD.FileshareUtility.ShowToast(f1_arg0, CoD.FileshareUtility.ToastTypes.UPLOAD)
		elseif CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.uploadTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_error"]) then
			CoD.FileshareUtility.ShowSimpleToast(f1_arg0, CoD.FileshareUtility.ToastTypes.ERROR)
		end
	end)
	if CoD.isPC then
		emptyFocusableNoCursorUpdate.id = "emptyFocusableNoCursorUpdate"
	end
	FullscreenPopupTemplate.id = "FullscreenPopupTemplate"
	leftButtonBar:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		leftButtonBar.id = "leftButtonBar"
	end
	ButtonSave2.id = "ButtonSave2"
	f1_local15.id = "ButtonDescription2"
	f1_local14.id = "ButtonTitle2"
	if CoD.isPC then
		TitleTextBox.id = "TitleTextBox"
	end
	if CoD.isPC then
		DescTextBox.id = "DescTextBox"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FullscreenPopupTemplate
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local17 = self
	f1_local17 = FullscreenPopupTemplate
	if IsPC() then
		CoD.PCUtility.LinkPCSmallCloseButtonToInput(f1_local1, f1_arg0, f1_local17, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
	end
	f1_local17 = SlotsUsedWidget
	CoD.FileshareUtility.UpdateCurrentQuota(f1_arg0)
	f1_local17 = TitleTextBox
	if IsPC() then
		CoD.PCUtility.SetElementEditBoxMaxChar(f1_local17, 16)
		CoD.PCUtility.MakeElementEditBoxRealtime(f1_local17, "DemoTitleText")
		CoD.PCUtility.SetupElementEditControlWithControllerModel(f1_local17, f1_arg0, f1_local1, "DemoTitleText")
	end
	f1_local17 = DescTextBox
	if IsPC() then
		CoD.PCUtility.SetElementEditBoxMaxChar(f1_local17, 64)
		CoD.PCUtility.MakeElementEditBoxRealtime(f1_local17, "DemoDescText")
		CoD.PCUtility.SetupElementEditControlWithControllerModel(f1_local17, f1_arg0, f1_local1, "DemoDescText")
	end
	return self
end
CoD.DemoFileshareUpload.__resetProperties = function(f39_arg0)
	f39_arg0.SlotsUsedWidget:completeAnimation()
	f39_arg0.ThumbnailFrame:completeAnimation()
	f39_arg0.Thumbnail:completeAnimation()
	f39_arg0.GametypeOnMapName:completeAnimation()
	f39_arg0.ButtonSave2:completeAnimation()
	f39_arg0.ButtonDescription2:completeAnimation()
	f39_arg0.ButtonTitle2:completeAnimation()
	f39_arg0.TitleText:completeAnimation()
	f39_arg0.TitleDescription:completeAnimation()
	f39_arg0.TitleTextBox:completeAnimation()
	f39_arg0.DescTextBox:completeAnimation()
	f39_arg0.FullscreenPopupTemplate:completeAnimation()
	f39_arg0.SlotsUsedWidget:setAlpha(1)
	f39_arg0.ThumbnailFrame:setAlpha(0.04)
	f39_arg0.Thumbnail:setAlpha(1)
	f39_arg0.GametypeOnMapName:setAlpha(1)
	f39_arg0.ButtonSave2:setAlpha(1)
	f39_arg0.ButtonDescription2:setAlpha(1)
	f39_arg0.ButtonTitle2:setAlpha(1)
	f39_arg0.TitleText:setAlpha(1)
	f39_arg0.TitleDescription:setAlpha(1)
	f39_arg0.TitleTextBox:setAlpha(1)
	f39_arg0.DescTextBox:setAlpha(1)
	f39_arg0.FullscreenPopupTemplate.Subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29503CD034274830"))
	f39_arg0.FullscreenPopupTemplate.WorkingTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5C76223999D97EC9"))
	f39_arg0.FullscreenPopupTemplate.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_34FBFD6B591E8B59"))
	f39_arg0.FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(@"menu/new"))
end
CoD.DemoFileshareUpload.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(6)
			f40_arg0.FullscreenPopupTemplate:completeAnimation()
			f40_arg0.clipFinished(f40_arg0.FullscreenPopupTemplate)
			f40_arg0.SlotsUsedWidget:completeAnimation()
			f40_arg0.SlotsUsedWidget:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.SlotsUsedWidget)
			f40_arg0.GametypeOnMapName:completeAnimation()
			f40_arg0.GametypeOnMapName:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.GametypeOnMapName)
			f40_arg0.Thumbnail:completeAnimation()
			f40_arg0.Thumbnail:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.Thumbnail)
			f40_arg0.ThumbnailFrame:completeAnimation()
			f40_arg0.ThumbnailFrame:setAlpha(0.04)
			f40_arg0.clipFinished(f40_arg0.ThumbnailFrame)
			f40_arg0.ButtonSave2:completeAnimation()
			f40_arg0.ButtonSave2:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.ButtonSave2)
			f40_arg0.ButtonDescription2:completeAnimation()
			f40_arg0.ButtonDescription2:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.ButtonDescription2)
			f40_arg0.ButtonTitle2:completeAnimation()
			f40_arg0.ButtonTitle2:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.ButtonTitle2)
		end,
	},
	Working = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(9)
			f41_arg0.FullscreenPopupTemplate:completeAnimation()
			f41_arg0.clipFinished(f41_arg0.FullscreenPopupTemplate)
			f41_arg0.TitleDescription:completeAnimation()
			f41_arg0.TitleDescription:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.TitleDescription)
			f41_arg0.TitleText:completeAnimation()
			f41_arg0.TitleText:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.TitleText)
			f41_arg0.SlotsUsedWidget:completeAnimation()
			f41_arg0.SlotsUsedWidget:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.SlotsUsedWidget)
			f41_arg0.GametypeOnMapName:completeAnimation()
			f41_arg0.GametypeOnMapName:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.GametypeOnMapName)
			f41_arg0.Thumbnail:completeAnimation()
			f41_arg0.Thumbnail:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.Thumbnail)
			f41_arg0.ButtonSave2:completeAnimation()
			f41_arg0.ButtonSave2:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ButtonSave2)
			f41_arg0.ButtonDescription2:completeAnimation()
			f41_arg0.ButtonDescription2:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ButtonDescription2)
			f41_arg0.ButtonTitle2:completeAnimation()
			f41_arg0.ButtonTitle2:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ButtonTitle2)
			f41_arg0.TitleTextBox:completeAnimation()
			f41_arg0.TitleTextBox:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.TitleTextBox)
			f41_arg0.DescTextBox:completeAnimation()
			f41_arg0.DescTextBox:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.DescTextBox)
		end,
	},
	Fetching = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(10)
			f42_arg0.FullscreenPopupTemplate:completeAnimation()
			f42_arg0.FullscreenPopupTemplate.Subtitle:completeAnimation()
			f42_arg0.FullscreenPopupTemplate.WorkingTitle:completeAnimation()
			f42_arg0.FullscreenPopupTemplate.Title:completeAnimation()
			f42_arg0.FullscreenPopupTemplate.DoneTitle:completeAnimation()
			f42_arg0.FullscreenPopupTemplate.Subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2C79EA24AB1A2BA"))
			f42_arg0.FullscreenPopupTemplate.WorkingTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_waiting"))
			f42_arg0.FullscreenPopupTemplate.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_waiting"))
			f42_arg0.FullscreenPopupTemplate.DoneTitle:setText(LocalizeToUpperString(@"hash_2C79EA24AB1A2BA"))
			f42_arg0.clipFinished(f42_arg0.FullscreenPopupTemplate)
			f42_arg0.TitleDescription:completeAnimation()
			f42_arg0.TitleDescription:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.TitleDescription)
			f42_arg0.TitleText:completeAnimation()
			f42_arg0.TitleText:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.TitleText)
			f42_arg0.SlotsUsedWidget:completeAnimation()
			f42_arg0.SlotsUsedWidget:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.SlotsUsedWidget)
			f42_arg0.GametypeOnMapName:completeAnimation()
			f42_arg0.GametypeOnMapName:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.GametypeOnMapName)
			f42_arg0.Thumbnail:completeAnimation()
			f42_arg0.Thumbnail:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Thumbnail)
			f42_arg0.ThumbnailFrame:completeAnimation()
			f42_arg0.ThumbnailFrame:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ThumbnailFrame)
			f42_arg0.ButtonSave2:completeAnimation()
			f42_arg0.ButtonSave2:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ButtonSave2)
			f42_arg0.ButtonDescription2:completeAnimation()
			f42_arg0.ButtonDescription2:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ButtonDescription2)
			f42_arg0.ButtonTitle2:completeAnimation()
			f42_arg0.ButtonTitle2:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ButtonTitle2)
			f42_arg0.TitleTextBox:completeAnimation()
			f42_arg0.TitleTextBox:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.TitleTextBox)
			f42_arg0.DescTextBox:completeAnimation()
			f42_arg0.DescTextBox:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.DescTextBox)
		end,
	},
}
CoD.DemoFileshareUpload.__onClose = function(f43_arg0)
	f43_arg0.emptyFocusableNoCursorUpdate:close()
	f43_arg0.FullscreenPopupTemplate:close()
	f43_arg0.AllowDownload0:close()
	f43_arg0.leftButtonBar:close()
	f43_arg0.SlotsUsedWidget:close()
	f43_arg0.Thumbnail:close()
	f43_arg0.ThumbnailFrame:close()
	f43_arg0.ButtonSave2:close()
	f43_arg0.ButtonDescription2:close()
	f43_arg0.ButtonTitle2:close()
	f43_arg0.TitleTextBox:close()
	f43_arg0.DescTextBox:close()
end
