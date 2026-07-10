require("x64:395c63182187e85")
CoD.ZMTalismanListItem = InheritFrom(LUI.UIElement)
CoD.ZMTalismanListItem.__defaultWidth = 142
CoD.ZMTalismanListItem.__defaultHeight = 138
CoD.ZMTalismanListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMTalismanListItem)
	self.id = "ZMTalismanListItem"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Talisman = CoD.ZMTalismanSlotInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -80, 80)
	Talisman:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "NoConsumablesRemaining",
			condition = function(menu, element, event)
				return not CoD.CACUtility.DoesCACItemHaveConsumablesRemaining(menu, element, f1_arg1, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"])
			end,
		},
	})
	local f1_local2 = Talisman
	local f1_local3 = Talisman.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["TalismanSelect.Update"], function(f4_arg0)
		f1_arg0:updateElementState(Talisman, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "TalismanSelect.Update",
		})
	end, false)
	Talisman:linkToElementModel(Talisman, "itemIndex", true, function(model)
		f1_arg0:updateElementState(Talisman, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	Talisman:linkToElementModel(self, nil, false, function(model)
		Talisman:setModel(model, f1_arg1)
	end)
	Talisman:linkToElementModel(self, nil, false, function(model)
		Talisman.EquipIndicator:setModel(model, f1_arg1)
	end)
	Talisman:linkToElementModel(self, "image", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Talisman.itemImage:setImage(CoD.BaseUtility.AlreadyRegistered(f8_local0))
		end
	end)
	Talisman:linkToElementModel(self, nil, false, function(model)
		Talisman.ConsumableCounter:setModel(model, f1_arg1)
	end)
	Talisman:linkToElementModel(self, "displayName", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Talisman.itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](f10_local0))
		end
	end)
	self:addElement(Talisman)
	self.Talisman = Talisman
	Talisman.id = "Talisman"
	self.__defaultFocus = Talisman
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTalismanListItem.__resetProperties = function(f11_arg0)
	f11_arg0.Talisman:completeAnimation()
	f11_arg0.Talisman:setScale(1, 1)
end
CoD.ZMTalismanListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Talisman:completeAnimation()
			f13_arg0.Talisman:setScale(1.03, 1.03)
			f13_arg0.clipFinished(f13_arg0.Talisman)
		end,
		GainChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Talisman:beginAnimation(200)
				f14_arg0.Talisman:setScale(1.03, 1.03)
				f14_arg0.Talisman:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Talisman:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Talisman:completeAnimation()
			f14_arg0.Talisman:setScale(1, 1)
			f14_local0(f14_arg0.Talisman)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Talisman:beginAnimation(200)
				f16_arg0.Talisman:setScale(1, 1)
				f16_arg0.Talisman:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Talisman:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Talisman:completeAnimation()
			f16_arg0.Talisman:setScale(1.03, 1.03)
			f16_local0(f16_arg0.Talisman)
		end,
	},
}
CoD.ZMTalismanListItem.__onClose = function(f18_arg0)
	f18_arg0.Talisman:close()
end
