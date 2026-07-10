require("x64:c598e2c46494586")
require("x64:3f87e09b354d3dc")
require("x64:75e2a524b093c12")
CoD.SupplyChainDetails = InheritFrom(LUI.UIElement)
CoD.SupplyChainDetails.__defaultWidth = 600
CoD.SupplyChainDetails.__defaultHeight = 1080
CoD.SupplyChainDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainDetails)
	self.id = "SupplyChainDetails"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_arg0, f1_arg1, 0, 0, -4, 596, 0, 0, 0, 1080)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local FixedAspectRatioImage = CoD.SupplyChainDetailImage3d.new(f1_arg0, f1_arg1, 0, 0, 85, 529, 0, 0, 273, 717)
	FixedAspectRatioImage:linkToElementModel(self, nil, false, function(model)
		FixedAspectRatioImage:setModel(model, f1_arg1)
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local SetBonusWidget = CoD.SupplyChainDetails_InfoPanel.new(f1_arg0, f1_arg1, 0, 0, 30, 588, 0, 0, 777, 1023)
	SetBonusWidget:mergeStateConditions({
		{
			stateName = "NoRarityWithButtons",
			condition = function(menu, element, event)
				local f3_local0
				if not MenuPropertyIsTrue(menu, "__hideSupplyChainDetailsButtons") then
					f3_local0 = CoD.BlackMarketUtility.ShowSupplyChainDetailsButtonPrompts(element, f1_arg1)
					if f3_local0 then
						f3_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "rarity", Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180])
						if f3_local0 then
							if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0x4F35AE761BD424) then
								f3_local0 = not IsElementPropertyValue(self, "__selfHideSupplyChainDetailsButtons", true)
							else
								f3_local0 = false
							end
						end
					end
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "ButtonPrompts",
			condition = function(menu, element, event)
				local f4_local0
				if not MenuPropertyIsTrue(menu, "__hideSupplyChainDetailsButtons") then
					f4_local0 = CoD.BlackMarketUtility.ShowSupplyChainDetailsButtonPrompts(element, f1_arg1)
					if f4_local0 then
						f4_local0 = not IsElementPropertyValue(self, "__selfHideSupplyChainDetailsButtons", true)
					end
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
	})
	SetBonusWidget:linkToElementModel(SetBonusWidget, "allowTogglePreview", true, function(model)
		f1_arg0:updateElementState(SetBonusWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allowTogglePreview",
		})
	end)
	SetBonusWidget:linkToElementModel(SetBonusWidget, "gesture_index", true, function(model)
		f1_arg0:updateElementState(SetBonusWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gesture_index",
		})
	end)
	SetBonusWidget:linkToElementModel(SetBonusWidget, "movieName", true, function(model)
		f1_arg0:updateElementState(SetBonusWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "movieName",
		})
	end)
	SetBonusWidget:linkToElementModel(SetBonusWidget, "allowFrozenMoment", true, function(model)
		f1_arg0:updateElementState(SetBonusWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allowFrozenMoment",
		})
	end)
	SetBonusWidget:linkToElementModel(SetBonusWidget, "rarity", true, function(model)
		f1_arg0:updateElementState(SetBonusWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
		})
	end)
	SetBonusWidget:linkToElementModel(SetBonusWidget, "itemCategory", true, function(model)
		f1_arg0:updateElementState(SetBonusWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
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
	self:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f17_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
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
CoD.SupplyChainDetails.__resetProperties = function(f21_arg0)
	f21_arg0.XCamMouseControl:completeAnimation()
	f21_arg0.FixedAspectRatioImage:completeAnimation()
	f21_arg0.SetBonusWidget:completeAnimation()
	f21_arg0.XCamMouseControl:setAlpha(1)
	f21_arg0.FixedAspectRatioImage:setAlpha(1)
	f21_arg0.SetBonusWidget:setAlpha(1)
end
CoD.SupplyChainDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.XCamMouseControl:completeAnimation()
			f22_arg0.XCamMouseControl:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.XCamMouseControl)
		end,
		reveal_common = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.XCamMouseControl:completeAnimation()
			f23_arg0.XCamMouseControl:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.XCamMouseControl)
			f23_arg0.FixedAspectRatioImage:completeAnimation()
			f23_arg0.FixedAspectRatioImage:playClip("reveal_common")
			f23_arg0.clipFinished(f23_arg0.FixedAspectRatioImage)
		end,
		reveal_rare = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.XCamMouseControl:completeAnimation()
			f24_arg0.XCamMouseControl:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.XCamMouseControl)
			f24_arg0.FixedAspectRatioImage:completeAnimation()
			f24_arg0.FixedAspectRatioImage:playClip("reveal_rare")
			f24_arg0.clipFinished(f24_arg0.FixedAspectRatioImage)
		end,
		reveal_legend = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.XCamMouseControl:completeAnimation()
			f25_arg0.XCamMouseControl:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.XCamMouseControl)
			f25_arg0.FixedAspectRatioImage:completeAnimation()
			f25_arg0.FixedAspectRatioImage:playClip("reveal_legend")
			f25_arg0.clipFinished(f25_arg0.FixedAspectRatioImage)
		end,
		reveal_epic = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.XCamMouseControl:completeAnimation()
			f26_arg0.XCamMouseControl:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.XCamMouseControl)
			f26_arg0.FixedAspectRatioImage:completeAnimation()
			f26_arg0.FixedAspectRatioImage:playClip("reveal_epic")
			f26_arg0.clipFinished(f26_arg0.FixedAspectRatioImage)
		end,
		reveal_ultra = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.XCamMouseControl:completeAnimation()
			f27_arg0.XCamMouseControl:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.XCamMouseControl)
			f27_arg0.FixedAspectRatioImage:completeAnimation()
			f27_arg0.FixedAspectRatioImage:playClip("reveal_ultra")
			f27_arg0.clipFinished(f27_arg0.FixedAspectRatioImage)
		end,
	},
	Hidden = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			f28_arg0.XCamMouseControl:completeAnimation()
			f28_arg0.XCamMouseControl:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.XCamMouseControl)
			f28_arg0.FixedAspectRatioImage:completeAnimation()
			f28_arg0.FixedAspectRatioImage:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.FixedAspectRatioImage)
			f28_arg0.SetBonusWidget:completeAnimation()
			f28_arg0.SetBonusWidget:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.SetBonusWidget)
		end,
	},
	Show3DModelMouseOrKB = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
	},
	Show3DModel = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			f30_arg0.XCamMouseControl:completeAnimation()
			f30_arg0.XCamMouseControl:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.XCamMouseControl)
		end,
	},
	DefaultStateMouseOrKB = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			f31_arg0.XCamMouseControl:completeAnimation()
			f31_arg0.XCamMouseControl:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.XCamMouseControl)
		end,
	},
}
CoD.SupplyChainDetails.__onClose = function(f32_arg0)
	f32_arg0.XCamMouseControl:close()
	f32_arg0.FixedAspectRatioImage:close()
	f32_arg0.SetBonusWidget:close()
end
