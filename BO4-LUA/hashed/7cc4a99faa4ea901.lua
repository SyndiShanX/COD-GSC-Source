require("x64:c598e2c46494586")
CoD.BM_BountyItemPreview = InheritFrom(LUI.UIElement)
CoD.BM_BountyItemPreview.__defaultWidth = 1920
CoD.BM_BountyItemPreview.__defaultHeight = 1080
CoD.BM_BountyItemPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_BountyItemPreview)
	self.id = "BM_BountyItemPreview"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FixedAspectRatioImage = CoD.SupplyChainDetailImage3d.new(f1_arg0, f1_arg1, 0.5, 0.5, -222, 222, 0.5, 0.5, -422, 22)
	FixedAspectRatioImage:linkToElementModel(self, nil, false, function(model)
		FixedAspectRatioImage:setModel(model, f1_arg1)
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name")
			end,
		},
		{
			stateName = "NoInfoPanel",
			condition = function(menu, element, event)
				return not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Show3DModelMouseOrKB",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.BlackMarketUtility.ItemUses3DPreview(element, f1_arg1)
			end,
		},
		{
			stateName = "Show3DModel",
			condition = function(menu, element, event)
				return CoD.BlackMarketUtility.ItemUses3DPreview(element, f1_arg1)
			end,
		},
		{
			stateName = "DefaultStateMouseOrKB",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "name", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "character", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "character",
		})
	end)
	self:linkToElementModel(self, "weaponRef", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponRef",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_BountyItemPreview.__resetProperties = function(f13_arg0)
	f13_arg0.FixedAspectRatioImage:completeAnimation()
	f13_arg0.FixedAspectRatioImage:setAlpha(1)
end
CoD.BM_BountyItemPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.FixedAspectRatioImage:completeAnimation()
			f15_arg0.FixedAspectRatioImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.FixedAspectRatioImage)
		end,
	},
	NoInfoPanel = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.FixedAspectRatioImage:completeAnimation()
			f16_arg0.FixedAspectRatioImage:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.FixedAspectRatioImage)
		end,
	},
	Show3DModelMouseOrKB = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	Show3DModel = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStateMouseOrKB = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.BM_BountyItemPreview.__onClose = function(f20_arg0)
	f20_arg0.FixedAspectRatioImage:close()
end
