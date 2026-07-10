require("x64:51cb89ab7a8399b")
require("x64:1cd7f68136f9cc0")
CoD.LaboratoryElixirLabel = InheritFrom(LUI.UIElement)
CoD.LaboratoryElixirLabel.__defaultWidth = 325
CoD.LaboratoryElixirLabel.__defaultHeight = 90
CoD.LaboratoryElixirLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryElixirLabel)
	self.id = "LaboratoryElixirLabel"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local rarity = CoD.LaboratoryElixirRarityLabel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 30)
	rarity:linkToElementModel(self, nil, false, function(model)
		rarity:setModel(model, f1_arg1)
	end)
	self:addElement(rarity)
	self.rarity = rarity
	local name = LUI.UIText.new(0, 0, 1.5, 323.5, 0, 0, 52, 70)
	name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	name:setTTF("dinnext_regular")
	name:setLetterSpacing(1)
	name:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	name:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	name:linkToElementModel(self, "id", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			name:setText(Engine[0xF9F1239CFD921FE](GetItemNameFromRef(Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A], f3_local0)))
		end
	end)
	self:addElement(name)
	self.name = name
	local quantity = LUI.UIText.new(0, 0, 1.5, 323.5, 0, 0, 62, 89)
	quantity:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	quantity:setAlpha(0)
	quantity:setTTF("dinnext_regular")
	quantity:setLetterSpacing(1)
	quantity:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	quantity:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	quantity:linkToElementModel(self, "quantity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			quantity:setText(LocalizeIntoStringIfNotEmpty(0x9DB9C526E6370AB, f4_local0))
		end
	end)
	self:addElement(quantity)
	self.quantity = quantity
	local Divider = CoD.zm_LaboratoryDescriptionDividerSecondary.new(f1_arg0, f1_arg1, 0.5, 0.5, -162, 162, 0.5, 0.5, -30, 2)
	Divider.R:setScale(0.6, 0.6)
	Divider.L:setScale(0.6, 0.6)
	self:addElement(Divider)
	self.Divider = Divider
	self:mergeStateConditions({
		{
			stateName = "VisibleQuantity",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "visible", 1) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "quantity", 1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "visible", 1)
			end,
		},
	})
	self:linkToElementModel(self, "visible", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "visible",
		})
	end)
	self:linkToElementModel(self, "quantity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "quantity",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryElixirLabel.__resetProperties = function(f9_arg0)
	f9_arg0.name:completeAnimation()
	f9_arg0.rarity:completeAnimation()
	f9_arg0.SceneBlur:completeAnimation()
	f9_arg0.Divider:completeAnimation()
	f9_arg0.quantity:completeAnimation()
	f9_arg0.name:setTopBottom(0, 0, 52, 70)
	f9_arg0.name:setAlpha(1)
	f9_arg0.rarity:setAlpha(1)
	f9_arg0.SceneBlur:setAlpha(1)
	f9_arg0.Divider:setAlpha(1)
	f9_arg0.quantity:setAlpha(0)
end
CoD.LaboratoryElixirLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.SceneBlur:completeAnimation()
			f10_arg0.SceneBlur:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.SceneBlur)
			f10_arg0.rarity:completeAnimation()
			f10_arg0.rarity:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.rarity)
			f10_arg0.name:completeAnimation()
			f10_arg0.name:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.name)
			f10_arg0.Divider:completeAnimation()
			f10_arg0.Divider:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Divider)
		end,
		Visible = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				f11_arg0.SceneBlur:beginAnimation(250)
				f11_arg0.SceneBlur:setAlpha(1)
				f11_arg0.SceneBlur:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SceneBlur:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.SceneBlur:completeAnimation()
			f11_arg0.SceneBlur:setAlpha(0)
			f11_local0(f11_arg0.SceneBlur)
			local f11_local1 = function(f13_arg0)
				f11_arg0.rarity:beginAnimation(250)
				f11_arg0.rarity:setAlpha(1)
				f11_arg0.rarity:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.rarity:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.rarity:completeAnimation()
			f11_arg0.rarity:setAlpha(0)
			f11_local1(f11_arg0.rarity)
			local f11_local2 = function(f14_arg0)
				f11_arg0.name:beginAnimation(250)
				f11_arg0.name:setAlpha(1)
				f11_arg0.name:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.name:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.name:completeAnimation()
			f11_arg0.name:setAlpha(0)
			f11_local2(f11_arg0.name)
		end,
	},
	VisibleQuantity = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.SceneBlur:completeAnimation()
			f15_arg0.SceneBlur:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.SceneBlur)
			f15_arg0.rarity:completeAnimation()
			f15_arg0.rarity:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.rarity)
			f15_arg0.name:completeAnimation()
			f15_arg0.name:setTopBottom(0, 0, 42, 60)
			f15_arg0.name:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.name)
			f15_arg0.quantity:completeAnimation()
			f15_arg0.quantity:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.quantity)
		end,
		DefaultState = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				f16_arg0.SceneBlur:beginAnimation(250)
				f16_arg0.SceneBlur:setAlpha(0)
				f16_arg0.SceneBlur:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SceneBlur:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.SceneBlur:completeAnimation()
			f16_arg0.SceneBlur:setAlpha(1)
			f16_local0(f16_arg0.SceneBlur)
			local f16_local1 = function(f18_arg0)
				f16_arg0.rarity:beginAnimation(250)
				f16_arg0.rarity:setAlpha(0)
				f16_arg0.rarity:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.rarity:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.rarity:completeAnimation()
			f16_arg0.rarity:setAlpha(1)
			f16_local1(f16_arg0.rarity)
			local f16_local2 = function(f19_arg0)
				f16_arg0.name:beginAnimation(250)
				f16_arg0.name:setAlpha(0)
				f16_arg0.name:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.name:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.name:completeAnimation()
			f16_arg0.name:setTopBottom(0, 0, 42, 60)
			f16_arg0.name:setAlpha(1)
			f16_local2(f16_arg0.name)
			local f16_local3 = function(f20_arg0)
				f16_arg0.quantity:beginAnimation(250)
				f16_arg0.quantity:setAlpha(0)
				f16_arg0.quantity:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.quantity:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.quantity:completeAnimation()
			f16_arg0.quantity:setAlpha(1)
			f16_local3(f16_arg0.quantity)
		end,
	},
	Visible = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.SceneBlur:completeAnimation()
			f21_arg0.SceneBlur:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.SceneBlur)
			f21_arg0.rarity:completeAnimation()
			f21_arg0.rarity:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.rarity)
			f21_arg0.name:completeAnimation()
			f21_arg0.name:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.name)
		end,
		DefaultState = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.SceneBlur:beginAnimation(250)
				f22_arg0.SceneBlur:setAlpha(0)
				f22_arg0.SceneBlur:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.SceneBlur:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.SceneBlur:completeAnimation()
			f22_arg0.SceneBlur:setAlpha(1)
			f22_local0(f22_arg0.SceneBlur)
			local f22_local1 = function(f24_arg0)
				f22_arg0.rarity:beginAnimation(250)
				f22_arg0.rarity:setAlpha(0)
				f22_arg0.rarity:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.rarity:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.rarity:completeAnimation()
			f22_arg0.rarity:setAlpha(1)
			f22_local1(f22_arg0.rarity)
			local f22_local2 = function(f25_arg0)
				f22_arg0.name:beginAnimation(250)
				f22_arg0.name:setAlpha(0)
				f22_arg0.name:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.name:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.name:completeAnimation()
			f22_arg0.name:setAlpha(1)
			f22_local2(f22_arg0.name)
		end,
	},
}
CoD.LaboratoryElixirLabel.__onClose = function(f26_arg0)
	f26_arg0.rarity:close()
	f26_arg0.name:close()
	f26_arg0.quantity:close()
	f26_arg0.Divider:close()
end
