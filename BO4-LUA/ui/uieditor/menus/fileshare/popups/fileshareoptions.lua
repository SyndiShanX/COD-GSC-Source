require("x64:c2f840fd2528321")
require("x64:96b29a3176ada0f")
require("x64:c61a61dbc4fee01")
require("x64:413987f664adb29")
require("x64:2eec2299e62b6b8")
CoD.FileshareOptions = InheritFrom(CoD.Menu)
LUI.createMenu.FileshareOptions = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FileshareOptions", f1_arg0)
	local f1_local1 = self
	SetGlobalModelValueArg("fileshareRoot.deleteTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_idle"])
	CoD.FileshareUtility.UpdateCurrentQuota(f1_arg0)
	self:setClass(CoD.FileshareOptions)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blackfade = LUI.UIImage.new(0.39, 0.61, -740, 740, 0, 0, 0, 1080)
	Blackfade:setRGB(0, 0, 0)
	Blackfade:setAlpha(0.35)
	self:addElement(Blackfade)
	self.Blackfade = Blackfade
	local tileTexture = LUI.UIImage.new(1, 1, -532, 0, 0, 1, 0, 0)
	tileTexture:setAlpha(0.5)
	tileTexture:setImage(RegisterImage(@"uie_t7_tile_texture"))
	tileTexture:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	tileTexture:setShaderVector(0, 30, 55, 0, 0)
	tileTexture:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(tileTexture)
	self.tileTexture = tileTexture
	local leftBackground = LUI.UIImage.new(1, 1, -532, 0, 0, 1, 0, 0)
	leftBackground:setRGB(0.04, 0.04, 0.04)
	leftBackground:setAlpha(0.98)
	self:addElement(leftBackground)
	self.leftBackground = leftBackground
	local OptionsList = LUI.UIList.new(f1_local1, f1_arg0, 2, 0, nil, false, false, false, false)
	OptionsList:setLeftRight(1, 1, -451, -51)
	OptionsList:setTopBottom(0, 0, 498, 558)
	OptionsList:setWidgetType(CoD.EmblemOptionsButton)
	OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionsList:setDataSource("FileshareOptionsButtonList")
	OptionsList:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(OptionsList)
	self.OptionsList = OptionsList
	local Title = LUI.UIText.new(1, 1, -451, -21, 0, 0, 35, 80)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2FA47140D97F89D"))
	Title:setTTF("ttmussels_demibold")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	local Border00 = LUI.UIImage.new(1, 1, -533, -531, 0, 0, 0, 1080)
	Border00:setAlpha(0.42)
	self:addElement(Border00)
	self.Border00 = Border00
	local Border0 = LUI.UIImage.new(1, 1, -533, -531, 0, 0, 0, 1080)
	Border0:setAlpha(0.42)
	self:addElement(Border0)
	self.Border0 = Border0
	local fefooterRighSlideIn = CoD.fe_footerRighSlideIn.new(f1_local1, f1_arg0, 1, 1, -670, -22, 1, 1, -48, 0)
	fefooterRighSlideIn:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(fefooterRighSlideIn)
	self.fefooterRighSlideIn = fefooterRighSlideIn
	local hintText = CoD.Theater_HintText.new(f1_local1, f1_arg0, 0, 0, 1469, 1869, 0, 0, 578, 598)
	self:addElement(hintText)
	self.hintText = hintText
	local SlotsUsedWidget = CoD.SlotsUsedWidget.new(f1_local1, f1_arg0, 0, 0, 1404, 1934, 0, 0, 874, 967)
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
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			SlotsUsedWidget.Total:setText(f8_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuotaUsed", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			SlotsUsedWidget.Used:setText(f9_local0)
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuota", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			SlotsUsedWidget.totalBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuota", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4)))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "currentCategoryQuotaUsedPercent", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			SlotsUsedWidget.usedBar:setShaderVector(2, SetVectorComponent(4, 1, SetVectorComponent(3, 0, SetVectorComponent(1, 0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f12_local0, 1), CoD.GetVectorComponentFromString(f12_local0, 2), CoD.GetVectorComponentFromString(f12_local0, 3), CoD.GetVectorComponentFromString(f12_local0, 4))))))
		end
	end)
	SlotsUsedWidget:subscribeToGlobalModel(f1_arg0, "GlobalModel", "FileshareRoot.ready", function(model)
		local f13_local0 = SlotsUsedWidget
		CoD.FileshareUtility.UpdateCurrentQuota(f1_arg0)
	end)
	self:addElement(SlotsUsedWidget)
	self.SlotsUsedWidget = SlotsUsedWidget
	local FileshareSelectedItemPreview = CoD.FileshareSelectedItemPreview.new(f1_local1, f1_arg0, 0, 0, 1398, 1898, 0, 0, 80, 460)
	FileshareSelectedItemPreview:subscribeToGlobalModel(f1_arg0, "FileshareSelectedItem", nil, function(model)
		FileshareSelectedItemPreview:setModel(model, f1_arg0)
	end)
	self:addElement(FileshareSelectedItemPreview)
	self.FileshareSelectedItemPreview = FileshareSelectedItemPreview
	hintText:linkToElementModel(OptionsList, "hintText", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			hintText.ItemHintText:setText(Engine[@"hash_4F9F1239CFD921FE"](f15_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
		PreserveThumbnails(f1_arg0, false)
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "fileshareRoot.publishTask.state", function(model)
		local f20_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.publishTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_done"]) and CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.publishTask.success") then
			GoBack(self, f1_arg0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg0, "GlobalModel", "fileshareRoot.deleteTask.state", function(model)
		local f21_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.deleteTask.state", Enum[@"filesharetaskuistate"][@"fileshare_task_ui_done"]) and CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.deleteTask.success") then
			CoD.FileshareUtility.ShowToast(f1_arg0, CoD.FileshareUtility.ToastTypes.DELETE)
			CoD.FileshareUtility.DeleteDone(self, f21_local0, f1_arg0, "", f1_local1)
		end
	end)
	OptionsList.id = "OptionsList"
	fefooterRighSlideIn.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		fefooterRighSlideIn.id = "fefooterRighSlideIn"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = OptionsList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local13 = self
	CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.OptionsList)
	f1_local13 = SlotsUsedWidget
	CoD.FileshareUtility.UpdateCurrentQuota(f1_arg0)
	return self
end
CoD.FileshareOptions.__resetProperties = function(f22_arg0)
	f22_arg0.hintText:completeAnimation()
	f22_arg0.fefooterRighSlideIn:completeAnimation()
	f22_arg0.Border0:completeAnimation()
	f22_arg0.Border00:completeAnimation()
	f22_arg0.Title:completeAnimation()
	f22_arg0.OptionsList:completeAnimation()
	f22_arg0.leftBackground:completeAnimation()
	f22_arg0.tileTexture:completeAnimation()
	f22_arg0.SlotsUsedWidget:completeAnimation()
	f22_arg0.hintText:setLeftRight(0, 0, 1469, 1869)
	f22_arg0.hintText:setAlpha(1)
	f22_arg0.fefooterRighSlideIn:setLeftRight(1, 1, -670, -22)
	f22_arg0.fefooterRighSlideIn:setAlpha(1)
	f22_arg0.Border0:setLeftRight(1, 1, -533, -531)
	f22_arg0.Border00:setLeftRight(1, 1, -533, -531)
	f22_arg0.Title:setLeftRight(1, 1, -451, -21)
	f22_arg0.OptionsList:setLeftRight(1, 1, -451, -51)
	f22_arg0.OptionsList:setTopBottom(0, 0, 498, 558)
	f22_arg0.leftBackground:setLeftRight(1, 1, -532, 0)
	f22_arg0.tileTexture:setLeftRight(1, 1, -532, 0)
	f22_arg0.SlotsUsedWidget:setLeftRight(0, 0, 1404, 1934)
	f22_arg0.SlotsUsedWidget:setTopBottom(0, 0, 874, 967)
end
CoD.FileshareOptions.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(9)
			f24_arg0.tileTexture:completeAnimation()
			f24_arg0.tileTexture:setLeftRight(0.5, 0.5, -266, 266)
			f24_arg0.clipFinished(f24_arg0.tileTexture)
			f24_arg0.leftBackground:completeAnimation()
			f24_arg0.leftBackground:setLeftRight(0.5, 0.5, -266, 266)
			f24_arg0.clipFinished(f24_arg0.leftBackground)
			f24_arg0.OptionsList:completeAnimation()
			f24_arg0.OptionsList:setLeftRight(0.5, 0.5, -200, 200)
			f24_arg0.OptionsList:setTopBottom(0, 0, 593, 839)
			f24_arg0.clipFinished(f24_arg0.OptionsList)
			f24_arg0.Title:completeAnimation()
			f24_arg0.Title:setLeftRight(0.5, 0.5, -215, 215)
			f24_arg0.clipFinished(f24_arg0.Title)
			f24_arg0.Border00:completeAnimation()
			f24_arg0.Border00:setLeftRight(0.5, 0.5, 265, 267)
			f24_arg0.clipFinished(f24_arg0.Border00)
			f24_arg0.Border0:completeAnimation()
			f24_arg0.Border0:setLeftRight(0.5, 0.5, -267, -265)
			f24_arg0.clipFinished(f24_arg0.Border0)
			f24_arg0.fefooterRighSlideIn:completeAnimation()
			f24_arg0.fefooterRighSlideIn:setLeftRight(0.5, 0.5, -324, 324)
			f24_arg0.fefooterRighSlideIn:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.fefooterRighSlideIn)
			f24_arg0.hintText:completeAnimation()
			f24_arg0.hintText:setLeftRight(0.5, 0.5, -210, 210)
			f24_arg0.hintText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.hintText)
			f24_arg0.SlotsUsedWidget:completeAnimation()
			f24_arg0.SlotsUsedWidget:setLeftRight(0.5, 0.5, -250, 250)
			f24_arg0.SlotsUsedWidget:setTopBottom(0.5, 0.5, 324, 454)
			f24_arg0.clipFinished(f24_arg0.SlotsUsedWidget)
		end,
	},
}
CoD.FileshareOptions.__onClose = function(f25_arg0)
	f25_arg0.hintText:close()
	f25_arg0.OptionsList:close()
	f25_arg0.fefooterRighSlideIn:close()
	f25_arg0.SlotsUsedWidget:close()
	f25_arg0.FileshareSelectedItemPreview:close()
end
