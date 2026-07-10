require("x64:4f13af0f746b8f8")
require("x64:ade61cc095aa2bc")
require("x64:42713807971f727")
require("x64:be779d5e87238aa")
CoD.systemOverlay_reportPlayer = InheritFrom(LUI.UIElement)
CoD.systemOverlay_reportPlayer.__defaultWidth = 1920
CoD.systemOverlay_reportPlayer.__defaultHeight = 480
CoD.systemOverlay_reportPlayer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_reportPlayer)
	self.id = "systemOverlay_reportPlayer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.9)
	self:addElement(Background)
	self.Background = Background
	local blur = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, 0, 525)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 480)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.7)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.09, 0.09, -44.5, 439.5)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Title = LUI.UIText.new(0.5, 0.5, -342, 864, 0, 0, 10, 44)
	Title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Title:setText(Engine[0xF9F1239CFD921FE](0xA9BFB932EE4FB07))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local f1_local6 = nil
	self.Description = LUI.UIElement.createFake()
	local f1_local7 = nil
	f1_local7 = LUI.UIElement.createFake()
	self.ButtonList = f1_local7
	local ReportTextBox = nil
	ReportTextBox = CoD.PC_ReportTextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -340, 236, 0, 0, 175, 331)
	ReportTextBox:setRGB(0.85, 0.85, 0.85)
	self:addElement(ReportTextBox)
	self.ReportTextBox = ReportTextBox
	local ReportTextBoxLabel = nil
	ReportTextBoxLabel = LUI.UIText.new(0.5, 0.5, -340, 236, 0, 0, 150, 169)
	ReportTextBoxLabel:setRGB(0.76, 0.76, 0.76)
	ReportTextBoxLabel:setText(Engine[0xF9F1239CFD921FE](0xF4902B629151E78))
	ReportTextBoxLabel:setTTF("ttmussels_regular")
	ReportTextBoxLabel:setLetterSpacing(2)
	ReportTextBoxLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ReportTextBoxLabel:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(ReportTextBoxLabel)
	self.ReportTextBoxLabel = ReportTextBoxLabel
	local ReportTextBoxLimit = nil
	ReportTextBoxLimit = LUI.UIText.new(0.5, 0.5, -340, 236, 0, 0, 331, 350)
	ReportTextBoxLimit:setRGB(0.42, 0.42, 0.42)
	ReportTextBoxLimit:setText(Engine[0xF9F1239CFD921FE](0xDD2240592242F36))
	ReportTextBoxLimit:setTTF("notosans_regular")
	ReportTextBoxLimit:setLetterSpacing(1)
	ReportTextBoxLimit:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ReportTextBoxLimit:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ReportTextBoxLimit)
	self.ReportTextBoxLimit = ReportTextBoxLimit
	local VerticalLine = nil
	VerticalLine = LUI.UIImage.new(0.5, 0.5, 267, 268, 0, 0, 68, 346)
	VerticalLine:setRGB(0.21, 0.21, 0.21)
	self:addElement(VerticalLine)
	self.VerticalLine = VerticalLine
	local ConfirmationText = nil
	ConfirmationText = LUI.UIText.new(0.5, 0.5, -340, 236, 0, 0, 357, 378)
	ConfirmationText:setRGB(0.74, 0.17, 0.17)
	ConfirmationText:setAlpha(0)
	ConfirmationText:setTTF("notosans_regular")
	ConfirmationText:setLetterSpacing(2)
	ConfirmationText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ConfirmationText:subscribeToGlobalModel(f1_arg1, "ReportPlayerDropDown", "currentValue", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ConfirmationText:setText(CoD.BaseUtility.LocalizeIfXHash(CoD.PCWidgetUtility.ReportReasonToConfirmation(f1_arg1, f2_local0)))
		end
	end)
	self:addElement(ConfirmationText)
	self.ConfirmationText = ConfirmationText
	local ReportButton = nil
	ReportButton = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 0.5, 0.5, -340, -140, 0, 0, 370, 430)
	ReportButton:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.IsReportDefault(f1_arg1)
			end,
		},
	})
	local ReportDescription = ReportButton
	local CancelButton = ReportButton.subscribeToModel
	local ReportDropdown = DataSources.ReportPlayerDropDown.getModel(f1_arg1)
	CancelButton(ReportDescription, ReportDropdown.currentValue, function(f4_arg0)
		f1_arg0:updateElementState(ReportButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "currentValue",
		})
	end, false)
	ReportButton.ButtonContainer.Title:setText(LocalizeToUpperString(0x74834ABE9827A3))
	ReportButton:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ReportButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.PCWidgetUtility.SendReportPlayer(self, controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(ReportButton)
	self.ReportButton = ReportButton
	CancelButton = nil
	CancelButton = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 0.5, 0.5, -123, 77, 0, 0, 370, 430)
	CancelButton.ButtonContainer.Title:setText(LocalizeToUpperString(0xC2E92C54C2BE289))
	CancelButton:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CancelButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(CancelButton)
	self.CancelButton = CancelButton
	ReportDescription = nil
	ReportDescription = LUI.UIText.new(0.5, 0.5, 293, 674, 0, 0, 66, 86)
	ReportDescription:setRGB(0.54, 0.54, 0.54)
	ReportDescription:setTTF("notosans_regular")
	ReportDescription:setLetterSpacing(1)
	ReportDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ReportDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ReportDescription:subscribeToGlobalModel(f1_arg1, "ReportPlayerDropDown", "currentValue", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ReportDescription:setText(CoD.BaseUtility.LocalizeIfXHash(CoD.PCWidgetUtility.ReportReasonToDescription(f1_arg1, f11_local0)))
		end
	end)
	self:addElement(ReportDescription)
	self.ReportDescription = ReportDescription
	ReportDropdown = nil
	ReportDropdown = CoD.ReportDropdown_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, -340, 236, 0, 0, 68, 128)
	ReportDropdown:subscribeToGlobalModel(f1_arg1, "ReportPlayerDropDown", nil, function(model)
		ReportDropdown:setModel(model, f1_arg1)
	end)
	self:addElement(ReportDropdown)
	self.ReportDropdown = ReportDropdown
	local CallingCard = CoD.CallingCard.new(f1_arg0, f1_arg1, 0.5, 0.5, -737, -310, 0, 0, 397, 515)
	CallingCard.CallingCardsFrameWidget.CardIconFrame:setScale(0.66, 1)
	CallingCard:linkToElementModel(self, nil, false, function(model)
		CallingCard:setModel(model, f1_arg1)
	end)
	CallingCard:linkToElementModel(self, nil, false, function(model)
		CallingCard.CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCard)
	self.CallingCard = CallingCard
	local emblembackplate = LUI.UIImage.new(0.5, 0.5, -742, -388, 0, 0, 18.5, 382.5)
	emblembackplate:setRGB(0, 0, 0)
	emblembackplate:setAlpha(0.5)
	self:addElement(emblembackplate)
	self.emblembackplate = emblembackplate
	local emblem = LUI.UIImage.new(0.5, 0.5, -737.5, -392.5, 0, 0, 27.5, 372.5)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f15_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local optionTextBracketR = LUI.UIImage.new(0.5, 0.5, -388, -376, 0, 0, 211, 223)
	optionTextBracketR:setAlpha(0.5)
	optionTextBracketR:setImage(RegisterImage(0x34B555F15CDD010))
	optionTextBracketR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	optionTextBracketR:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(optionTextBracketR)
	self.optionTextBracketR = optionTextBracketR
	local optionTextBracketL = LUI.UIImage.new(0.5, 0.5, -756, -744, 0, 0, 211, 223)
	optionTextBracketL:setAlpha(0.5)
	optionTextBracketL:setZRot(180)
	optionTextBracketL:setImage(RegisterImage(0x34B555F15CDD010))
	optionTextBracketL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	optionTextBracketL:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(optionTextBracketL)
	self.optionTextBracketL = optionTextBracketL
	local cornerBracket = LUI.UIImage.new(0.5, 0.5, -748, -736, 0, 0, 13, 25)
	cornerBracket:setAlpha(0.5)
	cornerBracket:setZRot(180)
	cornerBracket:setImage(RegisterImage(0x535662F512D5F90))
	cornerBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cornerBracket)
	self.cornerBracket = cornerBracket
	local cornerBracket4 = LUI.UIImage.new(0.5, 0.5, -748, -736, 0, 0, 377, 389)
	cornerBracket4:setAlpha(0.5)
	cornerBracket4:setZRot(270)
	cornerBracket4:setImage(RegisterImage(0x535662F512D5F90))
	cornerBracket4:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cornerBracket4)
	self.cornerBracket4 = cornerBracket4
	local cornerBracket2 = LUI.UIImage.new(0.5, 0.5, -394, -382, 0, 0, 13, 25)
	cornerBracket2:setAlpha(0.5)
	cornerBracket2:setZRot(90)
	cornerBracket2:setImage(RegisterImage(0x535662F512D5F90))
	cornerBracket2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cornerBracket2)
	self.cornerBracket2 = cornerBracket2
	local cornerBracket3 = LUI.UIImage.new(0.5, 0.5, -394, -382, 0, 0, 377, 389)
	cornerBracket3:setAlpha(0.5)
	cornerBracket3:setImage(RegisterImage(0x535662F512D5F90))
	cornerBracket3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cornerBracket3)
	self.cornerBracket3 = cornerBracket3
	local Image = LUI.UIImage.new(0.5, 0.5, -733, -397, 0, 0, 15, 17)
	Image:setAlpha(0.01)
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(0.5, 0.5, -733, -397, 0, 0, 385, 387)
	Image2:setAlpha(0.01)
	self:addElement(Image2)
	self.Image2 = Image2
	f1_local7.id = "ButtonList"
	if CoD.isPC then
		ReportTextBox.id = "ReportTextBox"
	end
	if CoD.isPC then
		ReportButton.id = "ReportButton"
	end
	if CoD.isPC then
		CancelButton.id = "CancelButton"
	end
	if CoD.isPC then
		ReportDropdown.id = "ReportDropdown"
	end
	CallingCard.id = "CallingCard"
	self.__defaultFocus = f1_local7
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_reportPlayer.__onClose = function(f16_arg0)
	f16_arg0.ButtonList:close()
	f16_arg0.ReportTextBox:close()
	f16_arg0.ConfirmationText:close()
	f16_arg0.ReportButton:close()
	f16_arg0.CancelButton:close()
	f16_arg0.ReportDescription:close()
	f16_arg0.ReportDropdown:close()
	f16_arg0.CallingCard:close()
	f16_arg0.emblem:close()
end
