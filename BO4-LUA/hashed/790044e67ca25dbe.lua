CoD.SupplyChainItemGlint = InheritFrom(LUI.UIElement)
CoD.SupplyChainItemGlint.__defaultWidth = 140
CoD.SupplyChainItemGlint.__defaultHeight = 158
CoD.SupplyChainItemGlint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainItemGlint)
	self.id = "SupplyChainItemGlint"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Glint:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint"))
	Glint:setShaderVector(0, 1.12, 0, 0, 0)
	Glint:setShaderVector(1, -46.8, 0, 0, 0)
	Glint:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Glint:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f2_local0))
		end
	end)
	self:addElement(Glint)
	self.Glint = Glint
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isContrabandCrate")
			end,
		},
		{
			stateName = "HiddenCommon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rarity", 0)
			end,
		},
	})
	self:linkToElementModel(self, "isContrabandCrate", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isContrabandCrate",
		})
	end)
	self:linkToElementModel(self, "rarity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainItemGlint.__resetProperties = function(f7_arg0)
	f7_arg0.Glint:completeAnimation()
	f7_arg0.Glint:setAlpha(1)
	f7_arg0.Glint:setShaderVector(0, 1.12, 0, 0, 0)
	f7_arg0.Glint:setShaderVector(1, -46.8, 0, 0, 0)
end
CoD.SupplyChainItemGlint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(3600)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(500)
					f10_arg0:setAlpha(0)
					f10_arg0:setShaderVector(0, 1.12, 0, 0, 0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.Glint:beginAnimation(500)
				f8_arg0.Glint:setAlpha(1)
				f8_arg0.Glint:setShaderVector(0, 0.51, 0, 0, 0)
				f8_arg0.Glint:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Glint:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.Glint:completeAnimation()
			f8_arg0.Glint:setAlpha(0)
			f8_arg0.Glint:setShaderVector(0, -0.1, 0, 0, 0)
			f8_arg0.Glint:setShaderVector(1, -46.8, 0, 0, 0)
			f8_local0(f8_arg0.Glint)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Glint:completeAnimation()
			f12_arg0.Glint:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Glint)
		end,
	},
	HiddenCommon = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Glint:completeAnimation()
			f13_arg0.Glint:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Glint)
		end,
	},
}
CoD.SupplyChainItemGlint.__onClose = function(f14_arg0)
	f14_arg0.Glint:close()
end
