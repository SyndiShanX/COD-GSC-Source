require("x64:253efcdfef07a1a")
CoD.AARNumericalStatHistory = InheritFrom(LUI.UIElement)
CoD.AARNumericalStatHistory.__defaultWidth = 124
CoD.AARNumericalStatHistory.__defaultHeight = 236
CoD.AARNumericalStatHistory.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARNumericalStatHistory)
	self.id = "AARNumericalStatHistory"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BarStripe = LUI.UIImage.new(0, 0, 0, 124, 0, 0, 0, 236)
	BarStripe:setXRot(180)
	BarStripe:setYRot(180)
	BarStripe:setImage(RegisterImage(0x938DF4DE0F3C3F5))
	BarStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	BarStripe:setShaderVector(0, 1, 0, 0, 0)
	BarStripe:setShaderVector(1, 0, 0, 0, 0)
	BarStripe:setShaderVector(3, 0, 0, 0, 0)
	BarStripe:setShaderVector(4, 0, 0, 0, 0)
	BarStripe:linkToElementModel(self, "barFraction", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BarStripe:setShaderVector(2, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(BarStripe)
	self.BarStripe = BarStripe
	local HistoryBar = CoD.AARHistoryBar.new(f1_arg0, f1_arg1, 0, 0, 0, 124, 0, 0, 0, 236)
	HistoryBar:mergeStateConditions({
		{
			stateName = "InValid",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "valid", 0)
			end,
		},
		{
			stateName = "Latest",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLastMatch")
			end,
		},
		{
			stateName = "BelowAvg",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "belowAvg")
			end,
		},
	})
	HistoryBar:linkToElementModel(HistoryBar, "valid", true, function(model)
		f1_arg0:updateElementState(HistoryBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "valid",
		})
	end)
	HistoryBar:linkToElementModel(HistoryBar, "isLastMatch", true, function(model)
		f1_arg0:updateElementState(HistoryBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLastMatch",
		})
	end)
	HistoryBar:linkToElementModel(HistoryBar, "belowAvg", true, function(model)
		f1_arg0:updateElementState(HistoryBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "belowAvg",
		})
	end)
	HistoryBar:linkToElementModel(self, nil, false, function(model)
		HistoryBar:setModel(model, f1_arg1)
	end)
	self:addElement(HistoryBar)
	self.HistoryBar = HistoryBar
	local BarStripeAdd = LUI.UIImage.new(0, 0, 0, 124, 0, 0, 0, 236)
	BarStripeAdd:setAlpha(0)
	BarStripeAdd:setXRot(180)
	BarStripeAdd:setYRot(180)
	BarStripeAdd:setImage(RegisterImage(0x938DF4DE0F3C3F5))
	BarStripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	BarStripeAdd:setShaderVector(0, 1, 0, 0, 0)
	BarStripeAdd:setShaderVector(1, 0, 0, 0, 0)
	BarStripeAdd:setShaderVector(3, 0, 0, 0, 0)
	BarStripeAdd:setShaderVector(4, 0, 0, 0, 0)
	BarStripeAdd:linkToElementModel(self, "barFraction", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			BarStripeAdd:setShaderVector(2, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4))
		end
	end)
	self:addElement(BarStripeAdd)
	self.BarStripeAdd = BarStripeAdd
	local InValidNormal = LUI.UIImage.new(0, 0, 14, 110, 0, 0, 22, 214)
	InValidNormal:setAlpha(0)
	InValidNormal:setImage(RegisterImage(0xFDCBFA0A9BD64AE))
	self:addElement(InValidNormal)
	self.InValidNormal = InValidNormal
	local InValidAdd = LUI.UIImage.new(0, 0, 14, 110, 0, 0, 22, 214)
	InValidAdd:setAlpha(0)
	InValidAdd:setImage(RegisterImage(0xFDCBFA0A9BD64AE))
	InValidAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(InValidAdd)
	self.InValidAdd = InValidAdd
	self:mergeStateConditions({
		{
			stateName = "InValid",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "valid", 0)
			end,
		},
		{
			stateName = "Latest",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLastMatch")
			end,
		},
		{
			stateName = "BelowAvg",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "belowAvg")
			end,
		},
	})
	self:linkToElementModel(self, "valid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "valid",
		})
	end)
	self:linkToElementModel(self, "isLastMatch", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLastMatch",
		})
	end)
	self:linkToElementModel(self, "belowAvg", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "belowAvg",
		})
	end)
	self:linkToElementModel(self, "statValue", true, function(model)
		local f17_local0 = self
		CoD.AARUtility.SetupStatHistory(self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARNumericalStatHistory.__resetProperties = function(f18_arg0)
	f18_arg0.BarStripeAdd:completeAnimation()
	f18_arg0.InValidAdd:completeAnimation()
	f18_arg0.InValidNormal:completeAnimation()
	f18_arg0.HistoryBar:completeAnimation()
	f18_arg0.BarStripe:completeAnimation()
	f18_arg0.BarStripeAdd:setAlpha(0)
	f18_arg0.InValidAdd:setAlpha(0)
	f18_arg0.InValidNormal:setAlpha(0)
	f18_arg0.HistoryBar:setAlpha(1)
	f18_arg0.BarStripe:setAlpha(1)
end
CoD.AARNumericalStatHistory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(5)
			f19_arg0.BarStripe:completeAnimation()
			f19_arg0.BarStripe:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.BarStripe)
			f19_arg0.HistoryBar:completeAnimation()
			f19_arg0.HistoryBar:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.HistoryBar)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(2000)
					f21_arg0:setAlpha(0.1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.BarStripeAdd:beginAnimation(2000)
				f19_arg0.BarStripeAdd:setAlpha(0.4)
				f19_arg0.BarStripeAdd:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.BarStripeAdd:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.BarStripeAdd:completeAnimation()
			f19_arg0.BarStripeAdd:setAlpha(0.1)
			f19_local0(f19_arg0.BarStripeAdd)
			f19_arg0.InValidNormal:completeAnimation()
			f19_arg0.InValidNormal:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.InValidNormal)
			f19_arg0.InValidAdd:completeAnimation()
			f19_arg0.InValidAdd:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.InValidAdd)
			f19_arg0.nextClip = "DefaultClip"
		end,
	},
	InValid = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.BarStripe:completeAnimation()
			f22_arg0.BarStripe:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BarStripe)
			f22_arg0.HistoryBar:completeAnimation()
			f22_arg0.HistoryBar:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.HistoryBar)
			f22_arg0.BarStripeAdd:completeAnimation()
			f22_arg0.BarStripeAdd:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BarStripeAdd)
			f22_arg0.InValidNormal:completeAnimation()
			f22_arg0.InValidNormal:setAlpha(0.05)
			f22_arg0.clipFinished(f22_arg0.InValidNormal)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(2000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.InValidAdd:beginAnimation(2000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f22_arg0.InValidAdd:setAlpha(0.05)
				f22_arg0.InValidAdd:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.InValidAdd:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.InValidAdd:completeAnimation()
			f22_arg0.InValidAdd:setAlpha(0)
			f22_local0(f22_arg0.InValidAdd)
			f22_arg0.nextClip = "DefaultClip"
		end,
	},
	Latest = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.BarStripe:completeAnimation()
			f25_arg0.BarStripe:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.BarStripe)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(2000)
					f27_arg0:setAlpha(0.2)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.BarStripeAdd:beginAnimation(2000)
				f25_arg0.BarStripeAdd:setAlpha(0.6)
				f25_arg0.BarStripeAdd:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.BarStripeAdd:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.BarStripeAdd:completeAnimation()
			f25_arg0.BarStripeAdd:setAlpha(0.2)
			f25_local0(f25_arg0.BarStripeAdd)
			f25_arg0.nextClip = "DefaultClip"
		end,
	},
	BelowAvg = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.BarStripe:completeAnimation()
			f28_arg0.BarStripe:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.BarStripe)
			f28_arg0.HistoryBar:completeAnimation()
			f28_arg0.HistoryBar:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.HistoryBar)
			f28_arg0.BarStripeAdd:completeAnimation()
			f28_arg0.BarStripeAdd:setAlpha(0.1)
			f28_arg0.clipFinished(f28_arg0.BarStripeAdd)
			f28_arg0.InValidNormal:completeAnimation()
			f28_arg0.InValidNormal:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.InValidNormal)
			f28_arg0.InValidAdd:completeAnimation()
			f28_arg0.InValidAdd:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.InValidAdd)
		end,
	},
}
CoD.AARNumericalStatHistory.__onClose = function(f29_arg0)
	f29_arg0.BarStripe:close()
	f29_arg0.HistoryBar:close()
	f29_arg0.BarStripeAdd:close()
end
