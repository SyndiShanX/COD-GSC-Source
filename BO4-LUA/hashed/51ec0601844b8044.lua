CoD.PurchaseHighlight = InheritFrom(LUI.UIElement)
CoD.PurchaseHighlight.__defaultWidth = 140
CoD.PurchaseHighlight.__defaultHeight = 20
CoD.PurchaseHighlight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchaseHighlight)
	self.id = "PurchaseHighlight"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PurchaseBand = LUI.UIImage.new(0, 0, -9, 149, 0, 0, 2, 18)
	PurchaseBand:setImage(RegisterImage(0xD77FEBA1B6DF8BA))
	PurchaseBand:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	PurchaseBand:setShaderVector(0, 0, 0, 0, 0)
	PurchaseBand:setupNineSliceShader(20, 8)
	self:addElement(PurchaseBand)
	self.PurchaseBand = PurchaseBand
	self:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "toPurchase", true)
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "bottomRow", true)
					if f2_local0 then
						if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected") then
							f2_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
						else
							f2_local0 = false
						end
					end
				end
				return f2_local0
			end,
		},
	})
	self:linkToElementModel(self, "toPurchase", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "toPurchase",
		})
	end)
	self:linkToElementModel(self, "bottomRow", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bottomRow",
		})
	end)
	self:linkToElementModel(self, "selected", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
		})
	end)
	self:linkToElementModel(self, "unlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PurchaseHighlight.__resetProperties = function(f7_arg0)
	f7_arg0.PurchaseBand:completeAnimation()
	f7_arg0.PurchaseBand:setAlpha(1)
end
CoD.PurchaseHighlight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.PurchaseBand:completeAnimation()
			f8_arg0.PurchaseBand:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PurchaseBand)
		end,
	},
	On = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.PurchaseBand:completeAnimation()
			f9_arg0.PurchaseBand:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.PurchaseBand)
		end,
	},
}
