require("x64:7aa6f93320ca609")
require("x64:c829ac7d797ba4c")
CoD.BetaRewardWidget = InheritFrom(LUI.UIElement)
CoD.BetaRewardWidget.__defaultWidth = 1920
CoD.BetaRewardWidget.__defaultHeight = 1080
CoD.BetaRewardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BetaRewardWidget)
	self.id = "BetaRewardWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(0x4BF88A437F4C579))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.FooterContainerFrontendRight = f1_local3
	local CallingCardText = LUI.UIText.new(0.5, 0.5, -577.5, -108.5, 0.5, 0.5, -196, -163)
	CallingCardText:setText(Engine[0xF9F1239CFD921FE](0x3302D75BAAEA18A))
	CallingCardText:setTTF("ttmussels_regular")
	CallingCardText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CallingCardText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CallingCardText)
	self.CallingCardText = CallingCardText
	local Description = LUI.UIText.new(0.5, 0.5, -577.5, 577.5, 0.5, 0.5, 0, 27)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[0xF9F1239CFD921FE](0xC7984514F12F64))
	Description:setTTF("ttmussels_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local CallingCardsBasicImage = CoD.CallingCards_BasicImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -577.5, -169.5, 0.5, 0.5, -159, -57)
	CallingCardsBasicImage.CardIcon:setImage(RegisterImage(0xE55B039106F41F0))
	self:addElement(CallingCardsBasicImage)
	self.CallingCardsBasicImage = CallingCardsBasicImage
	local Title = LUI.UIText.new(0.5, 0.5, -577.5, 560.5, 0.5, 0.5, -319, -244)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(LocalizeToUpperString(0x4154D030647A526))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_arg0, f1_arg1, 0.5, 0.5, 417.5, 577.5, 0.5, 0.5, 267, 327)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x6393FF34EA56966))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.EntitlementUtility.SetCurrentEntitlementViewed(controller)
		CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local BoundaryBot2 = LUI.UIImage.new(0.5, 0.5, -882.5, -321.5, 0.5, 0.5, -57, -41)
	BoundaryBot2:setAlpha(0.15)
	BoundaryBot2:setZRot(-90)
	BoundaryBot2:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot2:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot2:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot2)
	self.BoundaryBot2 = BoundaryBot2
	local BoundaryBot = LUI.UIImage.new(0.5, 0.5, 297, 858, 0.5, 0.5, -57, -41)
	BoundaryBot:setAlpha(0.15)
	BoundaryBot:setZRot(90)
	BoundaryBot:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot)
	self.BoundaryBot = BoundaryBot
	f1_local3:appendEventHandler("menu_loaded", function()
		f1_local3:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BetaRewardWidget.__onClose = function(f6_arg0)
	f6_arg0.FooterContainerFrontendRight:close()
	f6_arg0.CallingCardsBasicImage:close()
	f6_arg0.featureOverlayButtonMouseOnly:close()
end
