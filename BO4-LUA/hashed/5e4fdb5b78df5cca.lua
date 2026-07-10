require("x64:4a56feb602f654")
require("x64:c598e2c46494586")
CoD.DiscountDetailsWidget = InheritFrom(LUI.UIElement)
CoD.DiscountDetailsWidget.__defaultWidth = 600
CoD.DiscountDetailsWidget.__defaultHeight = 1080
CoD.DiscountDetailsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DiscountDetailsWidget)
	self.id = "DiscountDetailsWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FixedAspectRatioImage = CoD.SupplyChainDetailImage3d.new(f1_arg0, f1_arg1, 0, 0, 85, 529, 0, 0, 273, 717)
	FixedAspectRatioImage:linkToElementModel(self, nil, false, function(model)
		FixedAspectRatioImage:setModel(model, f1_arg1)
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local SetBonusWidget = CoD.DiscountDetailsInfoPanel.new(f1_arg0, f1_arg1, 0, 0, 30, 588, 0, 0, 777, 1023)
	SetBonusWidget:linkToElementModel(self, nil, false, function(model)
		SetBonusWidget:setModel(model, f1_arg1)
	end)
	self:addElement(SetBonusWidget)
	self.SetBonusWidget = SetBonusWidget
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "ShowDetails",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "reservesButton")
			end,
		},
	})
	self:linkToElementModel(self, "reservesButton", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reservesButton",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DiscountDetailsWidget.__resetProperties = function(f7_arg0)
	f7_arg0.FixedAspectRatioImage:completeAnimation()
	f7_arg0.SetBonusWidget:completeAnimation()
	f7_arg0.FixedAspectRatioImage:setAlpha(1)
	f7_arg0.SetBonusWidget:setAlpha(1)
end
CoD.DiscountDetailsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.FixedAspectRatioImage:completeAnimation()
			f8_arg0.FixedAspectRatioImage:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.FixedAspectRatioImage)
			f8_arg0.SetBonusWidget:completeAnimation()
			f8_arg0.SetBonusWidget:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.SetBonusWidget)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.FixedAspectRatioImage:completeAnimation()
			f9_arg0.FixedAspectRatioImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.FixedAspectRatioImage)
			f9_arg0.SetBonusWidget:completeAnimation()
			f9_arg0.SetBonusWidget:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.SetBonusWidget)
		end,
	},
	ShowDetails = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DiscountDetailsWidget.__onClose = function(f11_arg0)
	f11_arg0.FixedAspectRatioImage:close()
	f11_arg0.SetBonusWidget:close()
end
