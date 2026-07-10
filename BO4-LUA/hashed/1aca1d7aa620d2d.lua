require("x64:ffbc64370f13dd9")
require("x64:b8e2ca68acca1fd")
require("x64:bc87ac3fc76bb82")
require("x64:b71c9857f66102f")
require("x64:4b2433bccbe24eb")
require("x64:c9a3c9eb5d5ac59")
require("x64:12d199c0b6f6540")
CoD.ItemShopInfo = InheritFrom(LUI.UIElement)
CoD.ItemShopInfo.__defaultWidth = 804
CoD.ItemShopInfo.__defaultHeight = 409
CoD.ItemShopInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopInfo)
	self.id = "ItemShopInfo"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TiledwhiteNoiseBacking = LUI.UIImage.new(0, 0, 0, 760, 0, 0, 33, 422)
	TiledwhiteNoiseBacking:setRGB(0, 0, 0)
	TiledwhiteNoiseBacking:setAlpha(0.25)
	TiledwhiteNoiseBacking:setImage(RegisterImage(0x7167D8C33A06020))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local ContractRarityHeaderBackground = LUI.UIImage.new(0.13, 0.13, -107.5, 653.5, 0, 0, 3, 27)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f2_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local ContractRarityHeader = CoD.ContractRarityHeader.new(f1_arg0, f1_arg1, 0, 0, 23, 223, 0, 0, 3, 30)
	ContractRarityHeader:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeader:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeader)
	self.ContractRarityHeader = ContractRarityHeader
	local TitleAndDesc = CoD.ItemShopTitleAndDesc.new(f1_arg0, f1_arg1, 0, 0, 277, 740, 0, 0, 25.5, 251.5)
	TitleAndDesc:linkToElementModel(self, nil, false, function(model)
		TitleAndDesc:setModel(model, f1_arg1)
	end)
	self:addElement(TitleAndDesc)
	self.TitleAndDesc = TitleAndDesc
	local FuiBox02Right = LUI.UIImage.new(0, 0, 731, 765, 0, 0, 61.5, 27.5)
	FuiBox02Right:setScale(0.3, 0.3)
	FuiBox02Right:setImage(RegisterImage(0x811A80C0AADA825))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local Linker = LUI.UIImage.new(0, 0, 758, 762, 0, 0, 29.5, 421.5)
	Linker:setAlpha(0.08)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local Linker2 = LUI.UIImage.new(0, 0, 758.5, 762.5, 0, 0, 0, 27)
	Linker2:setAlpha(0.08)
	Linker2:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker2:setShaderVector(0, 0, 0, 0, 0)
	Linker2:setupNineSliceShader(4, 8)
	self:addElement(Linker2)
	self.Linker2 = Linker2
	local CommonSearchingBar = CoD.CommonSearchingBar.new(f1_arg0, f1_arg1, 0, 0, 685, 807, 0, 0, 88, 110)
	CommonSearchingBar:setZRot(-90)
	self:addElement(CommonSearchingBar)
	self.CommonSearchingBar = CommonSearchingBar
	local togglePreviewLabel = LUI.UIText.new(0, 0, 42, 90, 0.5, 0.5, -226, -208)
	togglePreviewLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	togglePreviewLabel:setText(Engine[0xF9F1239CFD921FE](0xDE61F05A2F38605))
	togglePreviewLabel:setTTF("dinnext_regular")
	togglePreviewLabel:setLetterSpacing(2)
	togglePreviewLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(togglePreviewLabel)
	self.togglePreviewLabel = togglePreviewLabel
	local previewGestureButton = CoD.JoinButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 39, 0.5, 0.5, -236.5, -197.5)
	previewGestureButton:setScale(0.8, 0.8)
	previewGestureButton.KMprompt:setText(CoD.BaseUtility.AlreadyLocalized("P"))
	previewGestureButton:subscribeToGlobalModel(f1_arg1, "Controller", "right_stick_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			previewGestureButton.GpadButtonImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(previewGestureButton)
	self.previewGestureButton = previewGestureButton
	local PreviewButton = CoD.ItemShopPreviewButton.new(f1_arg0, f1_arg1, 0, 0, 23, 249, 0, 0, 61.5, 370.5)
	PreviewButton.Button.Text:setText(LocalizeToUpperString(0x52FB29ED3A3CA79))
	PreviewButton:linkToElementModel(self, nil, false, function(model)
		PreviewButton:setModel(model, f1_arg1)
	end)
	PreviewButton:linkToElementModel(PreviewButton, "allowFrozenMoment", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
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
		if CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) then
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") then
			SetControllerModelValue(controller, "LootStreamProgress.playAnimation", false)
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "")
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "allowFrozenMoment", true) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "movieName") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x52FB29ED3A3CA79, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(PreviewButton)
	self.PreviewButton = PreviewButton
	self:mergeStateConditions({
		{
			stateName = "Gesture",
			condition = function(menu, element, event)
				local f12_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gesture_index", -1) then
					f12_local0 = not IsMouseOrKeyboard(f1_arg1)
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
	})
	self:linkToElementModel(self, "gesture_index", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gesture_index",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f14_arg1)
	end)
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local13(f1_local12, f1_local14.LastInput, function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	PreviewButton.id = "PreviewButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopInfo.__resetProperties = function(f16_arg0)
	f16_arg0.togglePreviewLabel:completeAnimation()
	f16_arg0.previewGestureButton:completeAnimation()
	f16_arg0.togglePreviewLabel:setAlpha(1)
	f16_arg0.previewGestureButton:setAlpha(1)
end
CoD.ItemShopInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.togglePreviewLabel:completeAnimation()
			f17_arg0.togglePreviewLabel:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.togglePreviewLabel)
			f17_arg0.previewGestureButton:completeAnimation()
			f17_arg0.previewGestureButton:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.previewGestureButton)
		end,
	},
	Gesture = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.togglePreviewLabel:completeAnimation()
			f18_arg0.togglePreviewLabel:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.togglePreviewLabel)
			f18_arg0.previewGestureButton:completeAnimation()
			f18_arg0.previewGestureButton:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.previewGestureButton)
		end,
	},
}
CoD.ItemShopInfo.__onClose = function(f19_arg0)
	f19_arg0.ContractRarityHeaderBackground:close()
	f19_arg0.ContractRarityHeader:close()
	f19_arg0.TitleAndDesc:close()
	f19_arg0.CommonSearchingBar:close()
	f19_arg0.previewGestureButton:close()
	f19_arg0.PreviewButton:close()
end
