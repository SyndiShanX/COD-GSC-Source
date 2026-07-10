CoD.PurchaseTiersInternal = InheritFrom(LUI.UIElement)
CoD.PurchaseTiersInternal.__defaultWidth = 180
CoD.PurchaseTiersInternal.__defaultHeight = 67
CoD.PurchaseTiersInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchaseTiersInternal)
	self.id = "PurchaseTiersInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PurchaseText = LUI.UIText.new(0.5, 0.5, -90, 90, 0, 0, 29, 43)
	PurchaseText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PurchaseText:setText(LocalizeToUpperString(@"menu/purchase_tier"))
	PurchaseText:setTTF("ttmussels_demibold")
	PurchaseText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	PurchaseText:setShaderVector(0, 1, 0, 0, 0)
	PurchaseText:setShaderVector(1, 0, 0, 0, 0)
	PurchaseText:setShaderVector(2, 0, 0, 0, 1)
	PurchaseText:setLetterSpacing(2)
	PurchaseText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PurchaseText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(PurchaseText)
	self.PurchaseText = PurchaseText
	local PurchaseBand = LUI.UIImage.new(0.5, 0.5, -78.5, -12.5, 0, 0, 3, 19)
	PurchaseBand:setImage(RegisterImage(@"hash_7D77FEBA1B6DF8BA"))
	PurchaseBand:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	PurchaseBand:setShaderVector(0, 0, 0, 0, 0)
	PurchaseBand:setupNineSliceShader(20, 8)
	self:addElement(PurchaseBand)
	self.PurchaseBand = PurchaseBand
	local PurchaseBand2 = LUI.UIImage.new(0.5, 0.5, 12.5, 78.5, 0, 0, 3, 19)
	PurchaseBand2:setImage(RegisterImage(@"hash_7D77FEBA1B6DF8BA"))
	PurchaseBand2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	PurchaseBand2:setShaderVector(0, 0, 0, 0, 0)
	PurchaseBand2:setupNineSliceShader(20, 8)
	self:addElement(PurchaseBand2)
	self.PurchaseBand2 = PurchaseBand2
	local Image = LUI.UIImage.new(0.5, 0.5, -12.5, 12.5, 0, 0, -1.5, 23.5)
	Image:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local TierText = LUI.UIText.new(0.5, 0.5, -70, 70, 0, 0, 48, 64)
	TierText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	TierText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	TierText:setTTF("ttmussels_demibold")
	TierText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	TierText:setShaderVector(0, 0.8, 0, 0, 0)
	TierText:setShaderVector(1, 0, 0, 0, 0)
	TierText:setShaderVector(2, 1, 0.8, 0, 0.1)
	TierText:setLetterSpacing(2)
	TierText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TierText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TierText)
	self.TierText = TierText
	self:mergeStateConditions({
		{
			stateName = "PCandtrial",
			condition = function(menu, element, event)
				return IsPC() and IsGameTrial()
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PurchaseTiersInternal.__resetProperties = function(f7_arg0)
	f7_arg0.Image:completeAnimation()
	f7_arg0.PurchaseBand2:completeAnimation()
	f7_arg0.PurchaseText:completeAnimation()
	f7_arg0.TierText:completeAnimation()
	f7_arg0.PurchaseBand:completeAnimation()
	f7_arg0.Image:setAlpha(1)
	f7_arg0.PurchaseBand2:setAlpha(1)
	f7_arg0.PurchaseText:setTopBottom(0, 0, 29, 43)
	f7_arg0.PurchaseText:setAlpha(1)
	f7_arg0.TierText:setTopBottom(0, 0, 48, 64)
	f7_arg0.TierText:setAlpha(1)
	f7_arg0.PurchaseBand:setLeftRight(0.5, 0.5, -78.5, -12.5)
end
CoD.PurchaseTiersInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	PCandtrial = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.PurchaseText:completeAnimation()
			f9_arg0.PurchaseText:setTopBottom(0, 0, 20, 36)
			f9_arg0.PurchaseText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PurchaseText)
			f9_arg0.PurchaseBand:completeAnimation()
			f9_arg0.PurchaseBand:setLeftRight(0.5, 0.5, -78.5, 78.5)
			f9_arg0.clipFinished(f9_arg0.PurchaseBand)
			f9_arg0.PurchaseBand2:completeAnimation()
			f9_arg0.PurchaseBand2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PurchaseBand2)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Image)
			f9_arg0.TierText:completeAnimation()
			f9_arg0.TierText:setTopBottom(0, 0, 36, 55)
			f9_arg0.TierText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TierText)
		end,
	},
	PC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.PurchaseText:completeAnimation()
			f10_arg0.PurchaseText:setTopBottom(0, 0, 20, 36)
			f10_arg0.clipFinished(f10_arg0.PurchaseText)
			f10_arg0.PurchaseBand:completeAnimation()
			f10_arg0.PurchaseBand:setLeftRight(0.5, 0.5, -78.5, 78.5)
			f10_arg0.clipFinished(f10_arg0.PurchaseBand)
			f10_arg0.PurchaseBand2:completeAnimation()
			f10_arg0.PurchaseBand2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PurchaseBand2)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image)
			f10_arg0.TierText:completeAnimation()
			f10_arg0.TierText:setTopBottom(0, 0, 36, 55)
			f10_arg0.clipFinished(f10_arg0.TierText)
		end,
	},
}
CoD.PurchaseTiersInternal.__onClose = function(f11_arg0)
	f11_arg0.Image:close()
end
