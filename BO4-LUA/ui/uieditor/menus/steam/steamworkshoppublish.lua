require("x64:c56b1e49074706b")
require("x64:90718a0f86dc27e")
require("x64:b970b1c400291ca")
require("x64:4ad93de6a0b1ca6")
CoD.SteamWorkshopPublish = InheritFrom(CoD.Menu)
LUI.createMenu.SteamWorkshopPublish = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SteamWorkshopPublish", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.SteamWorkshopPublish)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local FullscreenPopupForm = CoD.FullscreeenPupupSteamForm.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	FullscreenPopupForm:mergeStateConditions({
		{
			stateName = "WorkingState",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.FileshareIsPublishing()
			end,
		},
		{
			stateName = "ErrorState",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.FileshareIsPublishingInError()
			end,
		},
		{
			stateName = "DoneState",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.FileshareIsPublishingInSuccess()
			end,
		},
	})
	local LblName = FullscreenPopupForm
	local InputName = FullscreenPopupForm.subscribeToModel
	local InputDescription = Engine[0x8DF2E5447F384B9]()
	InputName(LblName, InputDescription["fileshareRoot.publishTask.state"], function(f5_arg0)
		f1_local1:updateElementState(FullscreenPopupForm, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "fileshareRoot.publishTask.state",
		})
	end, false)
	FullscreenPopupForm.Title:setText(Engine[0xF9F1239CFD921FE](0x4AF025B2AC483FF))
	FullscreenPopupForm.Subtitle:setText(Engine[0xF9F1239CFD921FE](0xEA7FE43590F310F))
	FullscreenPopupForm.WorkingTitle:setText(Engine[0xF9F1239CFD921FE](0xAB9731DB460FB68))
	FullscreenPopupForm.DoneTitle:setText(Engine[0xF9F1239CFD921FE](0x253C3842517883))
	FullscreenPopupForm.ErrorSubtitle:setText(Engine[0xF9F1239CFD921FE](0x9A2C1E7041DD6A0))
	self:addElement(FullscreenPopupForm)
	self.FullscreenPopupForm = FullscreenPopupForm
	InputName = CoD.InputButton.new(f1_local1, f1_arg0, 0, 0, 693, 1017, 0, 0, 566.5, 617.5)
	InputName:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "publishName", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			InputName.Text:setText(f6_local0)
		end
	end)
	InputName:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(InputName, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		FileshareEnterPublishName(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(InputName)
	self.InputName = InputName
	LblName = LUI.UIText.new(0, 0, 693, 993, 0, 0, 529, 567)
	LblName:setText(Engine[0xF9F1239CFD921FE](0x808E4CA838AD72E))
	LblName:setTTF("default")
	LblName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(LblName)
	self.LblName = LblName
	InputDescription = CoD.InputButton.new(f1_local1, f1_arg0, 0, 0, 693, 1616, 0, 0, 655, 795)
	InputDescription:subscribeToGlobalModel(f1_arg0, "FileshareRoot", "publishDescription", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			InputDescription.Text:setText(f10_local0)
		end
	end)
	InputDescription:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f11_local0
	end)
	f1_local1:AddButtonCallbackFunction(InputDescription, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		FileshareEnterPublishDescription(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(InputDescription)
	self.InputDescription = InputDescription
	local LblDescription = LUI.UIText.new(0, 0, 693, 795, 0, 0, 618, 656)
	LblDescription:setText(Engine[0xF9F1239CFD921FE](0xDEB3A3A04FA2E85))
	LblDescription:setTTF("default")
	LblDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(LblDescription)
	self.LblDescription = LblDescription
	local InputTags = CoD.InputButton.new(f1_local1, f1_arg0, 0, 0, 1062, 1616, 0, 0, 566.5, 617.5)
	InputTags:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f14_local0
	end)
	f1_local1:AddButtonCallbackFunction(InputTags, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		FileshareEnterPublishTags(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(InputTags)
	self.InputTags = InputTags
	local LblTags = LUI.UIText.new(0, 0, 1062, 1287, 0, 0, 529, 567)
	LblTags:setText(Engine[0xF9F1239CFD921FE](0x969EB8206BF916C))
	LblTags:setTTF("default")
	LblTags:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(LblTags)
	self.LblTags = LblTags
	local BtnPublish = CoD.List1ButtonLarge_Left_ND.new(f1_local1, f1_arg0, 0, 0, 1477, 1615, 0, 0, 846, 892)
	BtnPublish:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return FilesharePublishToSteamDisabled(f1_arg0)
			end,
		},
	})
	local BtnFAQ = BtnPublish
	local BtnAgreement = BtnPublish.subscribeToModel
	local BtnViewSteamWorkshop = Engine[0x8DF2E5447F384B9]()
	BtnAgreement(BtnFAQ, BtnViewSteamWorkshop["fileshareRoot.publishSteamAgreement"], function(f18_arg0)
		f1_local1:updateElementState(BtnPublish, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "fileshareRoot.publishSteamAgreement",
		})
	end, false)
	BtnPublish.btnDisplayText:setText(Engine[0xF9F1239CFD921FE](0x15DBA93D2EC63CC))
	BtnPublish.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](0x15DBA93D2EC63CC))
	BtnFAQ = BtnPublish
	BtnAgreement = BtnPublish.subscribeToModel
	BtnViewSteamWorkshop = Engine[0x8DF2E5447F384B9]()
	BtnAgreement(BtnFAQ, BtnViewSteamWorkshop["fileshareRoot.ready"], function(f19_arg0, f19_arg1)
		CoD.Menu.UpdateButtonShownState(f19_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BtnFAQ = BtnPublish
	BtnAgreement = BtnPublish.subscribeToModel
	BtnViewSteamWorkshop = Engine[0x8DF2E5447F384B9]()
	BtnAgreement(BtnFAQ, BtnViewSteamWorkshop["fileshareRoot.publishSteamAgreement"], function(f20_arg0, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BtnPublish:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		if not FileshareIsSteamAgreed() then
			SetHintText(self, element, f1_arg0)
		else
			CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		end
		return f21_local0
	end)
	f1_local1:AddButtonCallbackFunction(BtnPublish, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if FileshareIsReady(controller) and FileshareIsSteamAgreed() then
			SteamWorkshopPublish(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if FileshareIsReady(controller) and FileshareIsSteamAgreed() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(BtnPublish)
	self.BtnPublish = BtnPublish
	BtnAgreement = CoD.List1ButtonLarge_Left_ND.new(f1_local1, f1_arg0, 0, 0, 1020, 1158, 0, 0, 846, 892)
	BtnAgreement.btnDisplayText:setText(Engine[0xF9F1239CFD921FE](0xE019652E4A6C5C7))
	BtnAgreement.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](0xE019652E4A6C5C7))
	BtnAgreement:registerEventHandler("gain_focus", function(element, event)
		local f24_local0 = nil
		if element.gainFocus then
			f24_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f24_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f24_local0
	end)
	f1_local1:AddButtonCallbackFunction(BtnAgreement, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		SteamWorkshopOpenAgreement(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(BtnAgreement)
	self.BtnAgreement = BtnAgreement
	BtnFAQ = CoD.List1ButtonLarge_Left_ND.new(f1_local1, f1_arg0, 0, 0, 693, 831, 0, 0, 846, 892)
	BtnFAQ.btnDisplayText:setText(Engine[0xF9F1239CFD921FE](0x118884CB1951783))
	BtnFAQ.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](0x118884CB1951783))
	BtnFAQ:registerEventHandler("gain_focus", function(element, event)
		local f27_local0 = nil
		if element.gainFocus then
			f27_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f27_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f27_local0
	end)
	f1_local1:AddButtonCallbackFunction(BtnFAQ, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		SteamWorkshopOpenFAQ(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(BtnFAQ)
	self.BtnFAQ = BtnFAQ
	BtnViewSteamWorkshop = CoD.List1ButtonLarge_Left_ND.new(f1_local1, f1_arg0, 0, 0, 693, 831, 0, 0, 846, 892)
	BtnViewSteamWorkshop.btnDisplayText:setText(Engine[0xF9F1239CFD921FE](0x7111887771E806A))
	BtnViewSteamWorkshop.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](0x7111887771E806A))
	BtnViewSteamWorkshop:registerEventHandler("gain_focus", function(element, event)
		local f30_local0 = nil
		if element.gainFocus then
			f30_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f30_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f30_local0
	end)
	f1_local1:AddButtonCallbackFunction(BtnViewSteamWorkshop, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		SteamWorkshopViewWorkshop(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(BtnViewSteamWorkshop)
	self.BtnViewSteamWorkshop = BtnViewSteamWorkshop
	local BtnViewItemInWorkshop = CoD.List1ButtonLarge_Left_ND.new(f1_local1, f1_arg0, 0, 0, 1020, 1158, 0, 0, 846, 892)
	BtnViewItemInWorkshop.btnDisplayText:setText(Engine[0xF9F1239CFD921FE](0xFD8F63F98C3B108))
	BtnViewItemInWorkshop.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](0xFD8F63F98C3B108))
	BtnViewItemInWorkshop:registerEventHandler("gain_focus", function(element, event)
		local f33_local0 = nil
		if element.gainFocus then
			f33_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f33_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f33_local0
	end)
	f1_local1:AddButtonCallbackFunction(BtnViewItemInWorkshop, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		SteamWorkshopOpenItem(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(BtnViewItemInWorkshop)
	self.BtnViewItemInWorkshop = BtnViewItemInWorkshop
	local BtnDone = CoD.List1ButtonLarge_Left_ND.new(f1_local1, f1_arg0, 0, 0, 1477, 1615, 0, 0, 846, 892)
	BtnDone.btnDisplayText:setText(Engine[0xF9F1239CFD921FE](0xA1809370478D8D))
	BtnDone.btnDisplayTextStroke:setText(Engine[0xF9F1239CFD921FE](0xA1809370478D8D))
	BtnDone:registerEventHandler("gain_focus", function(element, event)
		local f36_local0 = nil
		if element.gainFocus then
			f36_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f36_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f36_local0
	end)
	f1_local1:AddButtonCallbackFunction(BtnDone, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(BtnDone)
	self.BtnDone = BtnDone
	local checkboxSteamAgreement = CoD.checkbox.new(f1_local1, f1_arg0, 0.5, 0.5, -267, 663, 0, 0, 794.5, 845.5)
	checkboxSteamAgreement:mergeStateConditions({
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("FileshareRoot.publishSteamAgreement")
			end,
		},
	})
	local f1_local16 = checkboxSteamAgreement
	local f1_local17 = checkboxSteamAgreement.subscribeToModel
	local f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local17(f1_local16, f1_local18["FileshareRoot.publishSteamAgreement"], function(f40_arg0)
		f1_local1:updateElementState(checkboxSteamAgreement, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f40_arg0:get(),
			modelName = "FileshareRoot.publishSteamAgreement",
		})
	end, false)
	checkboxSteamAgreement.labelText:setText(Engine[0xF9F1239CFD921FE](0x4D6F8A11B251C6))
	checkboxSteamAgreement:registerEventHandler("gain_focus", function(element, event)
		local f41_local0 = nil
		if element.gainFocus then
			f41_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f41_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f41_local0
	end)
	f1_local1:AddButtonCallbackFunction(checkboxSteamAgreement, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		ToggleGlobalModelValueBoolean("FileshareRoot.publishSteamAgreement")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(checkboxSteamAgreement, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 0)
	end)
	self:addElement(checkboxSteamAgreement)
	self.checkboxSteamAgreement = checkboxSteamAgreement
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f45_local0 = nil
		FileshareHandleKeyboardComplete(self, self, f1_arg0, event)
		if not f45_local0 then
			f45_local0 = self:dispatchEventToChildren(event)
		end
		return f45_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x0, nil, nil)
		return false
	end, false)
	InputName.id = "InputName"
	InputDescription.id = "InputDescription"
	InputTags.id = "InputTags"
	BtnPublish.id = "BtnPublish"
	BtnAgreement.id = "BtnAgreement"
	BtnFAQ.id = "BtnFAQ"
	BtnViewSteamWorkshop.id = "BtnViewSteamWorkshop"
	BtnViewItemInWorkshop.id = "BtnViewItemInWorkshop"
	BtnDone.id = "BtnDone"
	checkboxSteamAgreement.id = "checkboxSteamAgreement"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = InputName
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.SteamWorkshopPublish.__resetProperties = function(f48_arg0)
	f48_arg0.BtnViewSteamWorkshop:completeAnimation()
	f48_arg0.BtnViewItemInWorkshop:completeAnimation()
	f48_arg0.BtnDone:completeAnimation()
	f48_arg0.BtnPublish:completeAnimation()
	f48_arg0.LblName:completeAnimation()
	f48_arg0.InputName:completeAnimation()
	f48_arg0.InputDescription:completeAnimation()
	f48_arg0.InputTags:completeAnimation()
	f48_arg0.LblTags:completeAnimation()
	f48_arg0.LblDescription:completeAnimation()
	f48_arg0.checkboxSteamAgreement:completeAnimation()
	f48_arg0.BtnAgreement:completeAnimation()
	f48_arg0.BtnFAQ:completeAnimation()
	f48_arg0.BtnViewSteamWorkshop:setAlpha(1)
	f48_arg0.BtnViewItemInWorkshop:setAlpha(1)
	f48_arg0.BtnDone:setAlpha(1)
	f48_arg0.BtnPublish:setAlpha(1)
	f48_arg0.LblName:setAlpha(1)
	f48_arg0.InputName:setAlpha(1)
	f48_arg0.InputDescription:setAlpha(1)
	f48_arg0.InputTags:setAlpha(1)
	f48_arg0.LblTags:setAlpha(1)
	f48_arg0.LblDescription:setAlpha(1)
	f48_arg0.checkboxSteamAgreement:setAlpha(1)
	f48_arg0.BtnAgreement:setAlpha(1)
	f48_arg0.BtnFAQ:setAlpha(1)
end
CoD.SteamWorkshopPublish.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			f49_arg0.BtnViewSteamWorkshop:completeAnimation()
			f49_arg0.BtnViewSteamWorkshop:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.BtnViewSteamWorkshop)
			f49_arg0.BtnViewItemInWorkshop:completeAnimation()
			f49_arg0.BtnViewItemInWorkshop:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.BtnViewItemInWorkshop)
			f49_arg0.BtnDone:completeAnimation()
			f49_arg0.BtnDone:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.BtnDone)
		end,
	},
	Working = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(10)
			f50_arg0.InputName:completeAnimation()
			f50_arg0.InputName:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.InputName)
			f50_arg0.LblName:completeAnimation()
			f50_arg0.LblName:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.LblName)
			f50_arg0.InputDescription:completeAnimation()
			f50_arg0.InputDescription:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.InputDescription)
			f50_arg0.LblDescription:completeAnimation()
			f50_arg0.LblDescription:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.LblDescription)
			f50_arg0.InputTags:completeAnimation()
			f50_arg0.InputTags:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.InputTags)
			f50_arg0.LblTags:completeAnimation()
			f50_arg0.LblTags:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.LblTags)
			f50_arg0.BtnPublish:completeAnimation()
			f50_arg0.BtnPublish:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.BtnPublish)
			f50_arg0.BtnAgreement:completeAnimation()
			f50_arg0.BtnAgreement:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.BtnAgreement)
			f50_arg0.BtnDone:completeAnimation()
			f50_arg0.BtnDone:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.BtnDone)
			f50_arg0.checkboxSteamAgreement:completeAnimation()
			f50_arg0.checkboxSteamAgreement:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.checkboxSteamAgreement)
		end,
	},
	Success = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(10)
			f51_arg0.InputName:completeAnimation()
			f51_arg0.InputName:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.InputName)
			f51_arg0.LblName:completeAnimation()
			f51_arg0.LblName:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.LblName)
			f51_arg0.InputDescription:completeAnimation()
			f51_arg0.InputDescription:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.InputDescription)
			f51_arg0.LblDescription:completeAnimation()
			f51_arg0.LblDescription:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.LblDescription)
			f51_arg0.InputTags:completeAnimation()
			f51_arg0.InputTags:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.InputTags)
			f51_arg0.LblTags:completeAnimation()
			f51_arg0.LblTags:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.LblTags)
			f51_arg0.BtnPublish:completeAnimation()
			f51_arg0.BtnPublish:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.BtnPublish)
			f51_arg0.BtnAgreement:completeAnimation()
			f51_arg0.BtnAgreement:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.BtnAgreement)
			f51_arg0.BtnFAQ:completeAnimation()
			f51_arg0.BtnFAQ:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.BtnFAQ)
			f51_arg0.checkboxSteamAgreement:completeAnimation()
			f51_arg0.checkboxSteamAgreement:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.checkboxSteamAgreement)
		end,
	},
}
CoD.SteamWorkshopPublish.__onClose = function(f52_arg0)
	f52_arg0.FullscreenPopupForm:close()
	f52_arg0.InputName:close()
	f52_arg0.InputDescription:close()
	f52_arg0.InputTags:close()
	f52_arg0.BtnPublish:close()
	f52_arg0.BtnAgreement:close()
	f52_arg0.BtnFAQ:close()
	f52_arg0.BtnViewSteamWorkshop:close()
	f52_arg0.BtnViewItemInWorkshop:close()
	f52_arg0.BtnDone:close()
	f52_arg0.checkboxSteamAgreement:close()
end
