require("x64:ab8f7f2a4bde709")
require("x64:a86bdd41c06859a")
require("x64:bce07fcd345de2a")
CoD.EmblemIconClipboard = InheritFrom(LUI.UIElement)
CoD.EmblemIconClipboard.__defaultWidth = 252
CoD.EmblemIconClipboard.__defaultHeight = 275
CoD.EmblemIconClipboard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemIconClipboard)
	self.id = "EmblemIconClipboard"
	self.soundSet = "CustomizationEditor"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking2:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBackingAdd:setAlpha(0.2)
	NoiseTiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local Paste = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0.02, 1.02, 6, -36, -0.54, 0.32, 199, -3)
	Paste:mergeStateConditions({
		{
			stateName = "KM",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	Paste:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(Paste, f4_arg1)
	end)
	local bgBorder = Paste
	local Copy = Paste.subscribeToModel
	local bgMask = Engine[0x4DF5CFBC1771947](f1_arg1)
	Copy(bgBorder, bgMask.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(Paste, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	Paste:setAlpha(0.25)
	Paste.label:setText(Engine[0xF9F1239CFD921FE](0xC557F1B0FF34983))
	Paste:subscribeToGlobalModel(f1_arg1, "Controller", "right_stick_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Paste.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(Paste)
	self.Paste = Paste
	Copy = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0.02, 1.02, 6, -36, -0.65, 0.21, 199, -3)
	Copy:mergeStateConditions({
		{
			stateName = "KM",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	Copy:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(Copy, f9_arg1)
	end)
	bgMask = Copy
	bgBorder = Copy.subscribeToModel
	local allGroupsUsedText = Engine[0x4DF5CFBC1771947](f1_arg1)
	bgBorder(bgMask, allGroupsUsedText.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(Copy, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	Copy.label:setText(Engine[0xF9F1239CFD921FE](0x5942F6C8861D985))
	Copy:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Copy.buttonPromptImage:setImage(RegisterImage(f11_local0))
		end
	end)
	self:addElement(Copy)
	self.Copy = Copy
	bgBorder = LUI.UIImage.new(0, 0, 0, 252, 0, 0, 22, 274)
	bgBorder:setRGB(0, 0, 0)
	bgBorder:setAlpha(0)
	self:addElement(bgBorder)
	self.bgBorder = bgBorder
	bgMask = LUI.UIImage.new(0, 0, 0, 252, 0, 0, 22, 274)
	bgMask:setRGB(0, 0, 0)
	bgMask:setAlpha(0)
	self:addElement(bgMask)
	self.bgMask = bgMask
	allGroupsUsedText = LUI.UIText.new(0, 0, 7, 244, 0, 0, 245, 270)
	allGroupsUsedText:setRGB(1, 0, 0)
	allGroupsUsedText:setAlpha(0)
	allGroupsUsedText:setText(Engine[0xF9F1239CFD921FE](0x7E72EBA24396E53))
	allGroupsUsedText:setTTF("ttmussels_regular")
	allGroupsUsedText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	allGroupsUsedText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(allGroupsUsedText)
	self.allGroupsUsedText = allGroupsUsedText
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local copyIcon = LUI.UIElement.new(0.5, 0.5, -57, 57, 0.5, 0.5, -22, 102)
	copyIcon:setAlpha(0)
	copyIcon:setupEmblemCopyWidget()
	self:addElement(copyIcon)
	self.copyIcon = copyIcon
	local CraftLayerCount = CoD.CraftLayerCount.new(f1_arg0, f1_arg1, 0, 0, 13, 93, 0, 0, 89.5, 119.5)
	CraftLayerCount:mergeStateConditions({
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.Clipboard_HasEnoughLayersToPaste(self, f1_arg1)
			end,
		},
	})
	local FooterStripe1 = CraftLayerCount
	local PaintshopChooseSide = CraftLayerCount.subscribeToModel
	local dividerH02 = Engine[0x4DF5CFBC1771947](f1_arg1)
	PaintshopChooseSide(FooterStripe1, dividerH02["Emblem.EmblemProperties.layersUsed"], function(f13_arg0)
		f1_arg0:updateElementState(CraftLayerCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	FooterStripe1 = CraftLayerCount
	PaintshopChooseSide = CraftLayerCount.subscribeToModel
	dividerH02 = Engine[0x4DF5CFBC1771947](f1_arg1)
	PaintshopChooseSide(FooterStripe1, dividerH02["Emblem.EmblemProperties.groupsUsed"], function(f14_arg0)
		f1_arg0:updateElementState(CraftLayerCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	CraftLayerCount:setAlpha(0)
	self:addElement(CraftLayerCount)
	self.CraftLayerCount = CraftLayerCount
	PaintshopChooseSide = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 0, 7, 327, 0, 0, 3, 35)
	PaintshopChooseSide.text:setText(LocalizeToUpperString(0x3F566919BED4406))
	self:addElement(PaintshopChooseSide)
	self.PaintshopChooseSide = PaintshopChooseSide
	FooterStripe1 = LUI.UIImage.new(0, 0, 0, 252, 1, 1, -36, -1)
	FooterStripe1:setAlpha(0.1)
	FooterStripe1:setImage(RegisterImage(0xC7A051F5EFC70E5))
	FooterStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	FooterStripe1:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe1:setupNineSliceShader(245, 40)
	self:addElement(FooterStripe1)
	self.FooterStripe1 = FooterStripe1
	dividerH02 = LUI.UIImage.new(0, 0, 1, 252, 0, 0, 237, 241)
	dividerH02:setAlpha(0.2)
	dividerH02:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH02:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH02:setShaderVector(0, 0, 0, 0, 0)
	dividerH02:setupNineSliceShader(8, 4)
	self:addElement(dividerH02)
	self.dividerH02 = dividerH02
	local dividerH03 = LUI.UIImage.new(0, 0, 0, 252, 0, 0, 20, 24)
	dividerH03:setAlpha(0.2)
	dividerH03:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH03:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH03:setShaderVector(0, 0, 0, 0, 0)
	dividerH03:setupNineSliceShader(8, 4)
	self:addElement(dividerH03)
	self.dividerH03 = dividerH03
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f15_arg2, f15_arg3, f15_arg4)
		UpdateElementState(self, "CraftLayerCount", controller)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemIconClipboard.__resetProperties = function(f16_arg0)
	f16_arg0.copyIcon:completeAnimation()
	f16_arg0.Paste:completeAnimation()
	f16_arg0.CraftLayerCount:completeAnimation()
	f16_arg0.allGroupsUsedText:completeAnimation()
	f16_arg0.FooterStripe1:completeAnimation()
	f16_arg0.Backing:completeAnimation()
	f16_arg0.dividerH03:completeAnimation()
	f16_arg0.dividerH02:completeAnimation()
	f16_arg0.PaintshopChooseSide:completeAnimation()
	f16_arg0.Frame:completeAnimation()
	f16_arg0.bgMask:completeAnimation()
	f16_arg0.bgBorder:completeAnimation()
	f16_arg0.Copy:completeAnimation()
	f16_arg0.NoiseTiledBackingAdd:completeAnimation()
	f16_arg0.NoiseTiledBacking2:completeAnimation()
	f16_arg0.copyIcon:setAlpha(0)
	f16_arg0.Paste:setAlpha(0.25)
	f16_arg0.CraftLayerCount:setAlpha(0)
	f16_arg0.allGroupsUsedText:setAlpha(0)
	f16_arg0.FooterStripe1:setTopBottom(1, 1, -36, -1)
	f16_arg0.FooterStripe1:setAlpha(0.1)
	f16_arg0.Backing:setAlpha(1)
	f16_arg0.dividerH03:setAlpha(0.2)
	f16_arg0.dividerH02:setAlpha(0.2)
	f16_arg0.PaintshopChooseSide:setAlpha(1)
	f16_arg0.Frame:setAlpha(0.2)
	f16_arg0.bgMask:setAlpha(0)
	f16_arg0.bgBorder:setAlpha(0)
	f16_arg0.Copy:setAlpha(1)
	f16_arg0.NoiseTiledBackingAdd:setAlpha(0.2)
	f16_arg0.NoiseTiledBacking2:setAlpha(1)
end
CoD.EmblemIconClipboard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	PasteState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.Paste:completeAnimation()
			f18_arg0.Paste:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Paste)
			f18_arg0.copyIcon:completeAnimation()
			f18_arg0.copyIcon:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.copyIcon)
			f18_arg0.CraftLayerCount:completeAnimation()
			f18_arg0.CraftLayerCount:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.CraftLayerCount)
		end,
	},
	AllGroupsUsed = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.Paste:completeAnimation()
			f19_arg0.Paste:setAlpha(0.5)
			f19_arg0.clipFinished(f19_arg0.Paste)
			f19_arg0.allGroupsUsedText:completeAnimation()
			f19_arg0.allGroupsUsedText:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.allGroupsUsedText)
			f19_arg0.copyIcon:completeAnimation()
			f19_arg0.copyIcon:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.copyIcon)
			f19_arg0.CraftLayerCount:completeAnimation()
			f19_arg0.CraftLayerCount:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.CraftLayerCount)
			f19_arg0.FooterStripe1:completeAnimation()
			f19_arg0.FooterStripe1:setTopBottom(1, 1, -42, -1)
			f19_arg0.clipFinished(f19_arg0.FooterStripe1)
		end,
	},
	Hidden = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(15)
			f20_arg0.Backing:completeAnimation()
			f20_arg0.Backing:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Backing)
			f20_arg0.NoiseTiledBacking2:completeAnimation()
			f20_arg0.NoiseTiledBacking2:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.NoiseTiledBacking2)
			f20_arg0.NoiseTiledBackingAdd:completeAnimation()
			f20_arg0.NoiseTiledBackingAdd:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.NoiseTiledBackingAdd)
			f20_arg0.Paste:completeAnimation()
			f20_arg0.Paste:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Paste)
			f20_arg0.Copy:completeAnimation()
			f20_arg0.Copy:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Copy)
			f20_arg0.bgBorder:completeAnimation()
			f20_arg0.bgBorder:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.bgBorder)
			f20_arg0.bgMask:completeAnimation()
			f20_arg0.bgMask:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.bgMask)
			f20_arg0.allGroupsUsedText:completeAnimation()
			f20_arg0.allGroupsUsedText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.allGroupsUsedText)
			f20_arg0.Frame:completeAnimation()
			f20_arg0.Frame:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Frame)
			f20_arg0.copyIcon:completeAnimation()
			f20_arg0.copyIcon:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.copyIcon)
			f20_arg0.CraftLayerCount:completeAnimation()
			f20_arg0.CraftLayerCount:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CraftLayerCount)
			f20_arg0.PaintshopChooseSide:completeAnimation()
			f20_arg0.PaintshopChooseSide:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PaintshopChooseSide)
			f20_arg0.FooterStripe1:completeAnimation()
			f20_arg0.FooterStripe1:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.FooterStripe1)
			f20_arg0.dividerH02:completeAnimation()
			f20_arg0.dividerH02:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.dividerH02)
			f20_arg0.dividerH03:completeAnimation()
			f20_arg0.dividerH03:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.dividerH03)
		end,
	},
}
CoD.EmblemIconClipboard.__onClose = function(f21_arg0)
	f21_arg0.Paste:close()
	f21_arg0.Copy:close()
	f21_arg0.CraftLayerCount:close()
	f21_arg0.PaintshopChooseSide:close()
end
