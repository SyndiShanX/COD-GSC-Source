CoD.BountyHunterDollars = InheritFrom(LUI.UIElement)
CoD.BountyHunterDollars.__defaultWidth = 70
CoD.BountyHunterDollars.__defaultHeight = 18
CoD.BountyHunterDollars.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterDollars)
	self.id = "BountyHunterDollars"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setRGB(0.48, 0.59, 0.41)
	NoiseTiledBacking:setAlpha(0.75)
	NoiseTiledBacking:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBacking2 = LUI.UIImage.new(0, 0, 0, 2, 0, 1, 0, 0)
	NoiseTiledBacking2:setRGB(0.75, 0.92, 0.59)
	NoiseTiledBacking2:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	local Cost = LUI.UIText.new(0, 0, 17, 70, 0.5, 0.5, -8.5, 10.5)
	Cost:setRGB(0.76, 0.92, 0.59)
	Cost:setTTF("ttmussels_regular")
	Cost:setLetterSpacing(2)
	Cost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Cost:linkToElementModel(self, "buyCost", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Cost:setText(f2_local0)
		end
	end)
	self:addElement(Cost)
	self.Cost = Cost
	local DollarSign = LUI.UIText.new(0, 0, 6, 18, 0.5, 0.5, -8.5, 10.5)
	DollarSign:setRGB(0.76, 0.92, 0.59)
	DollarSign:setText(CoD.BaseUtility.AlreadyLocalized("$"))
	DollarSign:setTTF("ttmussels_regular")
	DollarSign:setLetterSpacing(4)
	DollarSign:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DollarSign:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(DollarSign)
	self.DollarSign = DollarSign
	self:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsTrackPackagePurchased(self, menu, f1_arg1)
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.BountyHunterUtility.IsPackageTierAvailable(self)
			end,
		},
		{
			stateName = "CannotAfford",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsTooExpensive(self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "trackModel", true, function(model)
		if self["__stateValidation_trackModel->tierPurchased"] then
			self:removeSubscription(self["__stateValidation_trackModel->tierPurchased"])
			self["__stateValidation_trackModel->tierPurchased"] = nil
		end
		if model then
			local f6_local0 = model:get()
			local f6_local1 = model:get()
			model = f6_local0 and f6_local1.tierPurchased
		end
		if model then
			self["__stateValidation_trackModel->tierPurchased"] = self:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "trackModel->tierPurchased",
				})
			end)
		end
	end)
	self:linkToElementModel(self, "buyCost", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "buyCost",
		})
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["luielement.BountyHunterLoadout.money"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "luielement.BountyHunterLoadout.money",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterDollars.__resetProperties = function(f10_arg0)
	f10_arg0.Cost:completeAnimation()
	f10_arg0.DollarSign:completeAnimation()
	f10_arg0.NoiseTiledBacking2:completeAnimation()
	f10_arg0.NoiseTiledBacking:completeAnimation()
	f10_arg0.Cost:setRGB(0.76, 0.92, 0.59)
	f10_arg0.Cost:setAlpha(1)
	f10_arg0.DollarSign:setRGB(0.76, 0.92, 0.59)
	f10_arg0.DollarSign:setAlpha(1)
	f10_arg0.NoiseTiledBacking2:setRGB(0.75, 0.92, 0.59)
	f10_arg0.NoiseTiledBacking2:setAlpha(1)
	f10_arg0.NoiseTiledBacking:setRGB(0.48, 0.59, 0.41)
	f10_arg0.NoiseTiledBacking:setAlpha(0.75)
end
CoD.BountyHunterDollars.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Purchased = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.NoiseTiledBacking:completeAnimation()
			f12_arg0.NoiseTiledBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.NoiseTiledBacking)
			f12_arg0.NoiseTiledBacking2:completeAnimation()
			f12_arg0.NoiseTiledBacking2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.NoiseTiledBacking2)
			f12_arg0.Cost:completeAnimation()
			f12_arg0.Cost:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Cost)
			f12_arg0.DollarSign:completeAnimation()
			f12_arg0.DollarSign:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DollarSign)
		end,
	},
	Unavailable = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.NoiseTiledBacking:completeAnimation()
			f13_arg0.NoiseTiledBacking:setRGB(0.39, 0.39, 0.39)
			f13_arg0.clipFinished(f13_arg0.NoiseTiledBacking)
			f13_arg0.NoiseTiledBacking2:completeAnimation()
			f13_arg0.NoiseTiledBacking2:setRGB(0.53, 0.53, 0.53)
			f13_arg0.clipFinished(f13_arg0.NoiseTiledBacking2)
			f13_arg0.Cost:completeAnimation()
			f13_arg0.Cost:setRGB(0.53, 0.53, 0.53)
			f13_arg0.clipFinished(f13_arg0.Cost)
			f13_arg0.DollarSign:completeAnimation()
			f13_arg0.DollarSign:setRGB(0.53, 0.53, 0.53)
			f13_arg0.clipFinished(f13_arg0.DollarSign)
		end,
	},
	CannotAfford = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setRGB(0.55, 0.22, 0.22)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBacking)
			f14_arg0.NoiseTiledBacking2:completeAnimation()
			f14_arg0.NoiseTiledBacking2:setRGB(1, 0.14, 0.14)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBacking2)
			f14_arg0.Cost:completeAnimation()
			f14_arg0.Cost:setRGB(1, 0.14, 0.14)
			f14_arg0.clipFinished(f14_arg0.Cost)
			f14_arg0.DollarSign:completeAnimation()
			f14_arg0.DollarSign:setRGB(1, 0.14, 0.14)
			f14_arg0.clipFinished(f14_arg0.DollarSign)
		end,
	},
}
CoD.BountyHunterDollars.__onClose = function(f15_arg0)
	f15_arg0.Cost:close()
end
