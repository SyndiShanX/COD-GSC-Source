require("x64:eda152e1d10147a")
require("x64:1590f9a531858e0")
require("x64:fc95c465fba6c23")
require("x64:3e7363f43bb91")
require("x64:645619cd1eee885")
require("x64:65ed6705f0299cb")
local PostLoadFunc = function(f1_arg0, f1_arg1)
	local f1_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f1_arg1), "TeamIdentity")
	if f1_local0 then
		f1_arg0.GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F3217BFCDBF3B46" .. Engine[@"getmodelvalue"](Engine[@"getmodel"](f1_local0, "team")) .. "_LOGO")))
	end
end
CoD.EditTeamLogo = InheritFrom(CoD.Menu)
LUI.createMenu.EditTeamLogo = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("EditTeamLogo", f2_arg0)
	local f2_local1 = self
	self:setClass(CoD.EditTeamLogo)
	self.soundSet = "ChooseDecal"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	local FEButtonPanelShaderContainer0 = CoD.FE_ButtonPanelShaderContainer.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FEButtonPanelShaderContainer0:setRGB(0.31, 0.31, 0.31)
	self:addElement(FEButtonPanelShaderContainer0)
	self.FEButtonPanelShaderContainer0 = FEButtonPanelShaderContainer0
	local FadeForStreamer = CoD.LobbyStreamerBlackFade.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	FadeForStreamer:mergeStateConditions({
		{
			stateName = "Transparent",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hideWorldForStreamer", 0)
			end,
		},
	})
	local BoxButtonLrgIdle = FadeForStreamer
	local GenericMenuFrame = FadeForStreamer.subscribeToModel
	local Border = Engine[@"getglobalmodel"]()
	GenericMenuFrame(BoxButtonLrgIdle, Border.hideWorldForStreamer, function(f4_arg0)
		f2_local1:updateElementState(FadeForStreamer, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f4_arg0:get(),
			modelName = "hideWorldForStreamer",
		})
	end, false)
	self:addElement(FadeForStreamer)
	self.FadeForStreamer = FadeForStreamer
	GenericMenuFrame = CoD.GenericMenuFrame.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_64E051F15AE3B3B8"))
	GenericMenuFrame:subscribeToGlobalModel(f2_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	BoxButtonLrgIdle = LUI.UIImage.new(0.5, 0.5, -66, 697, 0, 0, 216, 694)
	BoxButtonLrgIdle:setAlpha(0.45)
	BoxButtonLrgIdle:setImage(RegisterImage(@"uie_t7_menu_cac_buttonboxlrgidlefull"))
	BoxButtonLrgIdle:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BoxButtonLrgIdle:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BoxButtonLrgIdle)
	self.BoxButtonLrgIdle = BoxButtonLrgIdle
	Border = LUI.UIImage.new(0.5, 0.5, -58, 687, 0, 0, 220, 689)
	Border:setAlpha(0.43)
	Border:setImage(RegisterImage(@"uie_t7_menu_frontend_titlenumbrdrfull"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(6, 6)
	self:addElement(Border)
	self.Border = Border
	local LogoList = LUI.UIList.new(f2_local1, f2_arg0, 10, 0, nil, true, false, false, false)
	LogoList:setLeftRight(0.5, 0.5, -762, -112)
	LogoList:setTopBottom(0, 0, 222, 792)
	LogoList:setWidgetType(CoD.CodCasterTeamLogoButton)
	LogoList:setHorizontalCount(3)
	LogoList:setVerticalCount(4)
	LogoList:setSpacing(10)
	LogoList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LogoList:setDataSource("TeamIdentityLogoList")
	LogoList:linkToElementModel(LogoList, "disabled", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	LogoList:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f2_local1:AddButtonCallbackFunction(LogoList, f2_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			SetTeamIdentityTeamLogo(self, element, controller)
			SetTeamIdentityProfileValue(self, element, controller, "icon")
			SaveShoutcasterSettings(self, element, controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(LogoList)
	self.LogoList = LogoList
	local LogoImageHintImage = LUI.UIImage.new(0.5, 0.5, 87, 556, 0, 0, 219, 688)
	self:addElement(LogoImageHintImage)
	self.LogoImageHintImage = LogoImageHintImage
	local FEMenuLeftGraphics = CoD.FE_Menu_LeftGraphics.new(f2_local1, f2_arg0, 0.5, 0.5, -949, -871, 0, 0, 129, 1055)
	self:addElement(FEMenuLeftGraphics)
	self.FEMenuLeftGraphics = FEMenuLeftGraphics
	local LabelButton = CoD.cac_ListButtonLabel.new(f2_local1, f2_arg0, 0.5, 0.5, -17, 139, 1, 1, -438, -408)
	LabelButton:setAlpha(0.6)
	LabelButton:setScale(1.25, 1.25)
	self:addElement(LabelButton)
	self.LabelButton = LabelButton
	LogoImageHintImage:linkToElementModel(LogoList, "ref", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			LogoImageHintImage:setImage(RegisterImage(f10_local0))
		end
	end)
	LabelButton:linkToElementModel(LogoList, "name", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			LabelButton.itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](f11_local0))
		end
	end)
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f12_local0 = nil
		HandleTeamIdentityKeyboardComplete(self, self, f2_arg0, event)
		if not f12_local0 then
			f12_local0 = self:dispatchEventToChildren(event)
		end
		return f12_local0
	end)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		SaveShoutcasterSettings(self, element, controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	GenericMenuFrame:setModel(self.buttonModel, f2_arg0)
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	LogoList.id = "LogoList"
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	self.__defaultFocus = LogoList
	if CoD.isPC and (IsKeyboard(f2_arg0) or self.ignoreCursor) then
		self:restoreState(f2_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.EditTeamLogo.__onClose = function(f15_arg0)
	f15_arg0.LogoImageHintImage:close()
	f15_arg0.LabelButton:close()
	f15_arg0.FEButtonPanelShaderContainer0:close()
	f15_arg0.FadeForStreamer:close()
	f15_arg0.GenericMenuFrame:close()
	f15_arg0.LogoList:close()
	f15_arg0.FEMenuLeftGraphics:close()
end
