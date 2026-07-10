require("x64:c598e2c46494586")
require("x64:3f87e09b354d3dc")
require("x64:75e2a524b093c12")
CoD.ContractSupplyChainDetails = InheritFrom(LUI.UIElement)
CoD.ContractSupplyChainDetails.__defaultWidth = 600
CoD.ContractSupplyChainDetails.__defaultHeight = 1080
CoD.ContractSupplyChainDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractSupplyChainDetails)
	self.id = "ContractSupplyChainDetails"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_arg0, f1_arg1, 0, 0, -4, 596, 0, 0, 0, 1080)
	XCamMouseControl:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.ItemUses3DPreview(self, f1_arg1)
			end,
		},
	})
	XCamMouseControl:linkToElementModel(XCamMouseControl, "character", true, function(model)
		f1_arg0:updateElementState(XCamMouseControl, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "character",
		})
	end)
	XCamMouseControl:linkToElementModel(XCamMouseControl, "weaponRef", true, function(model)
		f1_arg0:updateElementState(XCamMouseControl, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponRef",
		})
	end)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local FixedAspectRatioImage = CoD.SupplyChainDetailImage3d.new(f1_arg0, f1_arg1, 0, 0, 85, 529, 0, 0, 273, 717)
	FixedAspectRatioImage:linkToElementModel(self, nil, false, function(model)
		FixedAspectRatioImage:setModel(model, f1_arg1)
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local SetBonusWidget = CoD.SupplyChainDetails_InfoPanel.new(f1_arg0, f1_arg1, 0, 0, 30, 588, 0, 0, 794, 1040)
	SetBonusWidget:linkToElementModel(self, nil, false, function(model)
		SetBonusWidget:setModel(model, f1_arg1)
	end)
	self:addElement(SetBonusWidget)
	self.SetBonusWidget = SetBonusWidget
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
	self:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f13_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
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
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractSupplyChainDetails.__resetProperties = function(f17_arg0)
	f17_arg0.XCamMouseControl:completeAnimation()
	f17_arg0.FixedAspectRatioImage:completeAnimation()
	f17_arg0.SetBonusWidget:completeAnimation()
	f17_arg0.XCamMouseControl:setAlpha(1)
	f17_arg0.FixedAspectRatioImage:setAlpha(1)
	f17_arg0.SetBonusWidget:setAlpha(1)
end
CoD.ContractSupplyChainDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.XCamMouseControl:completeAnimation()
			f18_arg0.XCamMouseControl:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.XCamMouseControl)
		end,
	},
	Hidden = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.FixedAspectRatioImage:completeAnimation()
			f19_arg0.FixedAspectRatioImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.FixedAspectRatioImage)
			f19_arg0.SetBonusWidget:completeAnimation()
			f19_arg0.SetBonusWidget:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.SetBonusWidget)
		end,
	},
	NoInfoPanel = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.XCamMouseControl:completeAnimation()
			f20_arg0.XCamMouseControl:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.XCamMouseControl)
			f20_arg0.FixedAspectRatioImage:completeAnimation()
			f20_arg0.FixedAspectRatioImage:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FixedAspectRatioImage)
			f20_arg0.SetBonusWidget:completeAnimation()
			f20_arg0.SetBonusWidget:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SetBonusWidget)
		end,
	},
	Show3DModelMouseOrKB = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	Show3DModel = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.XCamMouseControl:completeAnimation()
			f22_arg0.XCamMouseControl:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.XCamMouseControl)
		end,
	},
	DefaultStateMouseOrKB = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ContractSupplyChainDetails.__onClose = function(f24_arg0)
	f24_arg0.XCamMouseControl:close()
	f24_arg0.FixedAspectRatioImage:close()
	f24_arg0.SetBonusWidget:close()
end
