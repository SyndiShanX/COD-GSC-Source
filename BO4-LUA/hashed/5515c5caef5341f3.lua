require("x64:244642a9b881531")
CoD.ZMInvPhasedItemsContainer = InheritFrom(LUI.UIElement)
CoD.ZMInvPhasedItemsContainer.__defaultWidth = 248
CoD.ZMInvPhasedItemsContainer.__defaultHeight = 80
CoD.ZMInvPhasedItemsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ZMInvPhasedItemsContainer)
	self.id = "ZMInvPhasedItemsContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ItemsPhase0 = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	ItemsPhase0:setLeftRight(0.5, 0.5, -652, -326)
	ItemsPhase0:setTopBottom(0, 0, 0, 80)
	ItemsPhase0:setWidgetType(CoD.ZMInvWonderWeaponComponent)
	ItemsPhase0:setHorizontalCount(4)
	ItemsPhase0:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemsPhase0:setFilter(function(f2_arg0)
		return f2_arg0.displayedInPhase:get() == 0
	end)
	ItemsPhase0:setDataSource("ZMInventoryPhasedItemsInfo")
	self:addElement(ItemsPhase0)
	self.ItemsPhase0 = ItemsPhase0
	local ItemsPhase1 = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	ItemsPhase1:setLeftRight(0.5, 0.5, -326, 0)
	ItemsPhase1:setTopBottom(0, 0, 0, 80)
	ItemsPhase1:setAlpha(0)
	ItemsPhase1:setWidgetType(CoD.ZMInvWonderWeaponComponent)
	ItemsPhase1:setHorizontalCount(4)
	ItemsPhase1:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemsPhase1:setFilter(function(f3_arg0)
		return f3_arg0.displayedInPhase:get() == 1
	end)
	ItemsPhase1:setDataSource("ZMInventoryPhasedItemsInfo")
	self:addElement(ItemsPhase1)
	self.ItemsPhase1 = ItemsPhase1
	local ItemsPhase2 = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	ItemsPhase2:setLeftRight(0.5, 0.5, 0, 326)
	ItemsPhase2:setTopBottom(0, 0, 0, 80)
	ItemsPhase2:setAlpha(0)
	ItemsPhase2:setWidgetType(CoD.ZMInvWonderWeaponComponent)
	ItemsPhase2:setHorizontalCount(4)
	ItemsPhase2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemsPhase2:setFilter(function(f4_arg0)
		return f4_arg0.displayedInPhase:get() == 2
	end)
	ItemsPhase2:setDataSource("ZMInventoryPhasedItemsInfo")
	self:addElement(ItemsPhase2)
	self.ItemsPhase2 = ItemsPhase2
	local ItemsPhase3 = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	ItemsPhase3:setLeftRight(0.5, 0.5, 326, 652)
	ItemsPhase3:setTopBottom(0, 0, 0, 80)
	ItemsPhase3:setAlpha(0)
	ItemsPhase3:setWidgetType(CoD.ZMInvWonderWeaponComponent)
	ItemsPhase3:setHorizontalCount(4)
	ItemsPhase3:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemsPhase3:setFilter(function(f5_arg0)
		return f5_arg0.displayedInPhase:get() == 3
	end)
	ItemsPhase3:setDataSource("ZMInventoryPhasedItemsInfo")
	self:addElement(ItemsPhase3)
	self.ItemsPhase3 = ItemsPhase3
	self:mergeStateConditions({
		{
			stateName = "Phase0",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "phase", 0)
			end,
		},
		{
			stateName = "Phase1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "phase", 1)
			end,
		},
		{
			stateName = "Phase2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "phase", 2)
			end,
		},
		{
			stateName = "Phase3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "phase", 3)
			end,
		},
	})
	self:linkToElementModel(self, "phase", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "phase",
		})
	end)
	ItemsPhase0.id = "ItemsPhase0"
	ItemsPhase1.id = "ItemsPhase1"
	ItemsPhase2.id = "ItemsPhase2"
	ItemsPhase3.id = "ItemsPhase3"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvPhasedItemsContainer.__resetProperties = function(f11_arg0)
	f11_arg0.ItemsPhase1:completeAnimation()
	f11_arg0.ItemsPhase0:completeAnimation()
	f11_arg0.ItemsPhase2:completeAnimation()
	f11_arg0.ItemsPhase3:completeAnimation()
	f11_arg0.ItemsPhase1:setAlpha(0)
	f11_arg0.ItemsPhase0:setAlpha(1)
	f11_arg0.ItemsPhase2:setAlpha(0)
	f11_arg0.ItemsPhase3:setAlpha(0)
end
CoD.ZMInvPhasedItemsContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Phase0 = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Phase1 = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.ItemsPhase0:completeAnimation()
			f14_arg0.ItemsPhase0:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ItemsPhase0)
			f14_arg0.ItemsPhase1:completeAnimation()
			f14_arg0.ItemsPhase1:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ItemsPhase1)
			f14_arg0.ItemsPhase2:completeAnimation()
			f14_arg0.ItemsPhase2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ItemsPhase2)
			f14_arg0.ItemsPhase3:completeAnimation()
			f14_arg0.ItemsPhase3:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ItemsPhase3)
		end,
	},
	Phase2 = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.ItemsPhase0:completeAnimation()
			f15_arg0.ItemsPhase0:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ItemsPhase0)
			f15_arg0.ItemsPhase1:completeAnimation()
			f15_arg0.ItemsPhase1:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ItemsPhase1)
			f15_arg0.ItemsPhase2:completeAnimation()
			f15_arg0.ItemsPhase2:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.ItemsPhase2)
			f15_arg0.ItemsPhase3:completeAnimation()
			f15_arg0.ItemsPhase3:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ItemsPhase3)
		end,
	},
	Phase3 = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.ItemsPhase0:completeAnimation()
			f16_arg0.ItemsPhase0:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ItemsPhase0)
			f16_arg0.ItemsPhase1:completeAnimation()
			f16_arg0.ItemsPhase1:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ItemsPhase1)
			f16_arg0.ItemsPhase2:completeAnimation()
			f16_arg0.ItemsPhase2:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ItemsPhase2)
			f16_arg0.ItemsPhase3:completeAnimation()
			f16_arg0.ItemsPhase3:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.ItemsPhase3)
		end,
	},
}
CoD.ZMInvPhasedItemsContainer.__onClose = function(f17_arg0)
	f17_arg0.ItemsPhase0:close()
	f17_arg0.ItemsPhase1:close()
	f17_arg0.ItemsPhase2:close()
	f17_arg0.ItemsPhase3:close()
end
