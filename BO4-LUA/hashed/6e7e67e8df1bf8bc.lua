require("x64:ffbc64370f13dd9")
require("x64:b8e2ca68acca1fd")
require("x64:1f253af5b383fa8")
require("x64:c9a3c9eb5d5ac59")
CoD.ContractDetailsPanelInfo = InheritFrom(LUI.UIElement)
CoD.ContractDetailsPanelInfo.__defaultWidth = 804
CoD.ContractDetailsPanelInfo.__defaultHeight = 409
CoD.ContractDetailsPanelInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractDetailsPanelInfo)
	self.id = "ContractDetailsPanelInfo"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TiledwhiteNoiseBacking = LUI.UIImage.new(0, 0, 0, 760, 0, 0, 9, 398)
	TiledwhiteNoiseBacking:setRGB(0, 0, 0)
	TiledwhiteNoiseBacking:setAlpha(0.25)
	TiledwhiteNoiseBacking:setImage(RegisterImage(0x7167D8C33A06020))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local ContractDescription = LUI.UIText.new(0, 0, 279, 727, 0, 0, 72, 89)
	ContractDescription:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ContractDescription:setTTF("dinnext_regular")
	ContractDescription:setLetterSpacing(1)
	ContractDescription:setLineSpacing(1)
	ContractDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ContractDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ContractDescription:linkToElementModel(self, "contentsDetailedDesc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContractDescription:setText(f2_local0)
		end
	end)
	self:addElement(ContractDescription)
	self.ContractDescription = ContractDescription
	local PreviewLabel = LUI.UIText.new(0, 0, 23, 758, 0, 0, 422, 438)
	PreviewLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PreviewLabel:setText(LocalizeToUpperString(0x5BF1E7A46978C32))
	PreviewLabel:setTTF("ttmussels_regular")
	PreviewLabel:setLetterSpacing(4)
	PreviewLabel:setLineSpacing(1)
	PreviewLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PreviewLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PreviewLabel)
	self.PreviewLabel = PreviewLabel
	local ContractTitle = LUI.UIText.new(0, 0, 278, 728, 0, 0, 28, 66)
	ContractTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ContractTitle:setTTF("ttmussels_demibold")
	ContractTitle:setLetterSpacing(4)
	ContractTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ContractTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ContractTitle:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContractTitle:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(ContractTitle)
	self.ContractTitle = ContractTitle
	local Linker = LUI.UIImage.new(0, 0, 758, 762, 0, 0, 5, 399)
	Linker:setAlpha(0.08)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local CommonSearchingBar = CoD.CommonSearchingBar.new(f1_arg0, f1_arg1, 0, 0, 681.5, 803.5, 0, 0, 57.5, 79.5)
	CommonSearchingBar:setZRot(-90)
	self:addElement(CommonSearchingBar)
	self.CommonSearchingBar = CommonSearchingBar
	local FuiBox02Right = LUI.UIImage.new(0, 0, 727.5, 761.5, 0, 0, 34, 0)
	FuiBox02Right:setScale(0.3, 0.3)
	FuiBox02Right:setImage(RegisterImage(0x811A80C0AADA825))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local PreviewButton = CoD.ContractPreviewButton.new(f1_arg0, f1_arg1, 0, 0, 23, 249, 0, 0, 33, 342)
	PreviewButton.Button.Text:setText(LocalizeToUpperString(0x52FB29ED3A3CA79))
	PreviewButton:linkToElementModel(self, nil, false, function(model)
		PreviewButton:setModel(model, f1_arg1)
	end)
	PreviewButton:linkToElementModel(PreviewButton, "allowFrozenMoment", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	PreviewButton:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local f1_local9 = PreviewButton
	local f1_local10 = PreviewButton.subscribeToModel
	local f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PreviewButton:linkToElementModel(PreviewButton, "movieName", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	PreviewButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PreviewButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) and IsGamepad(controller) then
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(PreviewButton)
	self.PreviewButton = PreviewButton
	PreviewButton.id = "PreviewButton"
	self.__defaultFocus = PreviewButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractDetailsPanelInfo.__onClose = function(f12_arg0)
	f12_arg0.ContractDescription:close()
	f12_arg0.ContractTitle:close()
	f12_arg0.CommonSearchingBar:close()
	f12_arg0.PreviewButton:close()
end
