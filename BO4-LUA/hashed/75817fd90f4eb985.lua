require("x64:a68f4a37f2218c4")
CoD.ZMInvObjectiveProgressRing = InheritFrom(LUI.UIElement)
CoD.ZMInvObjectiveProgressRing.__defaultWidth = 384
CoD.ZMInvObjectiveProgressRing.__defaultHeight = 400
CoD.ZMInvObjectiveProgressRing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvObjectiveProgressRing)
	self.id = "ZMInvObjectiveProgressRing"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ObjectiveProgItem1 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem1:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 0)
			end,
		},
	})
	ObjectiveProgItem1:linkToElementModel(ObjectiveProgItem1, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem1:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem1:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem1)
	self.ObjectiveProgItem1 = ObjectiveProgItem1
	local ObjectiveProgItem2 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem2:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 1)
			end,
		},
	})
	ObjectiveProgItem2:linkToElementModel(ObjectiveProgItem2, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem2:setZRot(-40)
	ObjectiveProgItem2:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem2:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem2)
	self.ObjectiveProgItem2 = ObjectiveProgItem2
	local ObjectiveProgItem3 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem3:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 2)
			end,
		},
	})
	ObjectiveProgItem3:linkToElementModel(ObjectiveProgItem3, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem3:setZRot(-80)
	ObjectiveProgItem3:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem3:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem3)
	self.ObjectiveProgItem3 = ObjectiveProgItem3
	local ObjectiveProgItem4 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem4:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 3)
			end,
		},
	})
	ObjectiveProgItem4:linkToElementModel(ObjectiveProgItem4, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem4:setZRot(-120)
	ObjectiveProgItem4:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem4:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem4)
	self.ObjectiveProgItem4 = ObjectiveProgItem4
	local ObjectiveProgItem5 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem5:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 4)
			end,
		},
	})
	ObjectiveProgItem5:linkToElementModel(ObjectiveProgItem5, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem5:setZRot(-160)
	ObjectiveProgItem5:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem5:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem5)
	self.ObjectiveProgItem5 = ObjectiveProgItem5
	local ObjectiveProgItem6 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem6:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 5)
			end,
		},
	})
	ObjectiveProgItem6:linkToElementModel(ObjectiveProgItem6, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem6, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem6:setZRot(-200)
	ObjectiveProgItem6:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem6:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem6)
	self.ObjectiveProgItem6 = ObjectiveProgItem6
	local ObjectiveProgItem7 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem7:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 6)
			end,
		},
	})
	ObjectiveProgItem7:linkToElementModel(ObjectiveProgItem7, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem7, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem7:setZRot(-240)
	ObjectiveProgItem7:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem7:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem7)
	self.ObjectiveProgItem7 = ObjectiveProgItem7
	local ObjectiveProgItem8 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem8:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 7)
			end,
		},
	})
	ObjectiveProgItem8:linkToElementModel(ObjectiveProgItem8, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem8, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem8:setZRot(-280)
	ObjectiveProgItem8:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem8:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem8)
	self.ObjectiveProgItem8 = ObjectiveProgItem8
	local ObjectiveProgItem9 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem9:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 8)
			end,
		},
	})
	ObjectiveProgItem9:linkToElementModel(ObjectiveProgItem9, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem9, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem9:setZRot(-320)
	ObjectiveProgItem9:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem9:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem9)
	self.ObjectiveProgItem9 = ObjectiveProgItem9
	local ObjectiveProgItem10 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem10:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 9)
			end,
		},
	})
	ObjectiveProgItem10:linkToElementModel(ObjectiveProgItem10, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem10, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem10:setAlpha(0)
	ObjectiveProgItem10:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem10:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem10)
	self.ObjectiveProgItem10 = ObjectiveProgItem10
	local ObjectiveProgItem11 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem11:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 10)
			end,
		},
	})
	ObjectiveProgItem11:linkToElementModel(ObjectiveProgItem11, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem11, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem11:setAlpha(0)
	ObjectiveProgItem11:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem11:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem11)
	self.ObjectiveProgItem11 = ObjectiveProgItem11
	local ObjectiveProgItem12 = CoD.ZMInvObjectiveProgressItem.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 400)
	ObjectiveProgItem12:mergeStateConditions({
		{
			stateName = "Earned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "Ring.stage", 11)
			end,
		},
	})
	ObjectiveProgItem12:linkToElementModel(ObjectiveProgItem12, "Ring.stage", true, function(model)
		f1_arg0:updateElementState(ObjectiveProgItem12, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Ring.stage",
		})
	end)
	ObjectiveProgItem12:setAlpha(0)
	ObjectiveProgItem12:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgItem12:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgItem12)
	self.ObjectiveProgItem12 = ObjectiveProgItem12
	self:mergeStateConditions({
		{
			stateName = "NineItemsZMWhite",
			condition = function(menu, element, event)
				return IsMapName("zm_white")
			end,
		},
		{
			stateName = "FiveItems",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "numObjectiveProgressItems", 5)
			end,
		},
		{
			stateName = "TwelveItems",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "numObjectiveProgressItems", 12)
			end,
		},
		{
			stateName = "NineItems",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "numObjectiveProgressItems", 9)
			end,
		},
		{
			stateName = "TwelveItemsZMOrange",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "numObjectiveProgressItems", 12)
			end,
		},
	})
	self:linkToElementModel(self, "numObjectiveProgressItems", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "numObjectiveProgressItems",
		})
	end)
	self:linkToElementModel(self, "stage", true, function(model)
		local f44_local0 = self
		CoD.ZMInventoryUtility.HandleObjectiveProgressRingStageChange(self)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local13 = self
	CoD.ZMInventoryUtility.SetupObjectiveProgressRingItems(self, f1_arg1)
	return self
end
CoD.ZMInvObjectiveProgressRing.__resetProperties = function(f45_arg0)
	f45_arg0.ObjectiveProgItem8:completeAnimation()
	f45_arg0.ObjectiveProgItem9:completeAnimation()
	f45_arg0.ObjectiveProgItem2:completeAnimation()
	f45_arg0.ObjectiveProgItem4:completeAnimation()
	f45_arg0.ObjectiveProgItem5:completeAnimation()
	f45_arg0.ObjectiveProgItem6:completeAnimation()
	f45_arg0.ObjectiveProgItem7:completeAnimation()
	f45_arg0.ObjectiveProgItem3:completeAnimation()
	f45_arg0.ObjectiveProgItem1:completeAnimation()
	f45_arg0.ObjectiveProgItem10:completeAnimation()
	f45_arg0.ObjectiveProgItem11:completeAnimation()
	f45_arg0.ObjectiveProgItem12:completeAnimation()
	f45_arg0.ObjectiveProgItem8:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem8:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem8:setAlpha(1)
	f45_arg0.ObjectiveProgItem8:setZRot(-280)
	f45_arg0.ObjectiveProgItem8:setScale(1, 1)
	f45_arg0.ObjectiveProgItem9:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem9:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem9:setAlpha(1)
	f45_arg0.ObjectiveProgItem9:setZRot(-320)
	f45_arg0.ObjectiveProgItem9:setScale(1, 1)
	f45_arg0.ObjectiveProgItem2:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem2:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem2:setAlpha(1)
	f45_arg0.ObjectiveProgItem2:setZRot(-40)
	f45_arg0.ObjectiveProgItem2:setScale(1, 1)
	f45_arg0.ObjectiveProgItem4:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem4:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem4:setAlpha(1)
	f45_arg0.ObjectiveProgItem4:setZRot(-120)
	f45_arg0.ObjectiveProgItem4:setScale(1, 1)
	f45_arg0.ObjectiveProgItem5:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem5:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem5:setAlpha(1)
	f45_arg0.ObjectiveProgItem5:setZRot(-160)
	f45_arg0.ObjectiveProgItem5:setScale(1, 1)
	f45_arg0.ObjectiveProgItem6:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem6:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem6:setAlpha(1)
	f45_arg0.ObjectiveProgItem6:setZRot(-200)
	f45_arg0.ObjectiveProgItem6:setScale(1, 1)
	f45_arg0.ObjectiveProgItem7:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem7:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem7:setAlpha(1)
	f45_arg0.ObjectiveProgItem7:setZRot(-240)
	f45_arg0.ObjectiveProgItem7:setScale(1, 1)
	f45_arg0.ObjectiveProgItem3:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem3:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem3:setAlpha(1)
	f45_arg0.ObjectiveProgItem3:setZRot(-80)
	f45_arg0.ObjectiveProgItem3:setScale(1, 1)
	f45_arg0.ObjectiveProgItem1:setLeftRight(0, 0, 0, 384)
	f45_arg0.ObjectiveProgItem1:setTopBottom(0, 0, 0, 400)
	f45_arg0.ObjectiveProgItem1:setAlpha(1)
	f45_arg0.ObjectiveProgItem1:setZRot(0)
	f45_arg0.ObjectiveProgItem1:setScale(1, 1)
	f45_arg0.ObjectiveProgItem10:setAlpha(0)
	f45_arg0.ObjectiveProgItem10:setZRot(0)
	f45_arg0.ObjectiveProgItem11:setAlpha(0)
	f45_arg0.ObjectiveProgItem11:setZRot(0)
	f45_arg0.ObjectiveProgItem12:setAlpha(0)
	f45_arg0.ObjectiveProgItem12:setZRot(0)
end
CoD.ZMInvObjectiveProgressRing.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(8)
			f46_arg0.ObjectiveProgItem2:completeAnimation()
			f46_arg0.ObjectiveProgItem2:setZRot(-51)
			f46_arg0.clipFinished(f46_arg0.ObjectiveProgItem2)
			f46_arg0.ObjectiveProgItem3:completeAnimation()
			f46_arg0.ObjectiveProgItem3:setZRot(-103)
			f46_arg0.clipFinished(f46_arg0.ObjectiveProgItem3)
			f46_arg0.ObjectiveProgItem4:completeAnimation()
			f46_arg0.ObjectiveProgItem4:setZRot(-154)
			f46_arg0.clipFinished(f46_arg0.ObjectiveProgItem4)
			f46_arg0.ObjectiveProgItem5:completeAnimation()
			f46_arg0.ObjectiveProgItem5:setZRot(-206)
			f46_arg0.clipFinished(f46_arg0.ObjectiveProgItem5)
			f46_arg0.ObjectiveProgItem6:completeAnimation()
			f46_arg0.ObjectiveProgItem6:setZRot(-257)
			f46_arg0.clipFinished(f46_arg0.ObjectiveProgItem6)
			f46_arg0.ObjectiveProgItem7:completeAnimation()
			f46_arg0.ObjectiveProgItem7:setZRot(-308)
			f46_arg0.clipFinished(f46_arg0.ObjectiveProgItem7)
			f46_arg0.ObjectiveProgItem8:completeAnimation()
			f46_arg0.ObjectiveProgItem8:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.ObjectiveProgItem8)
			f46_arg0.ObjectiveProgItem9:completeAnimation()
			f46_arg0.ObjectiveProgItem9:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.ObjectiveProgItem9)
		end,
	},
	NineItemsZMWhite = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(12)
			f47_arg0.ObjectiveProgItem1:completeAnimation()
			f47_arg0.ObjectiveProgItem1:setLeftRight(0, 0, 6, 390)
			f47_arg0.ObjectiveProgItem1:setTopBottom(0, 0, 35, 435)
			f47_arg0.ObjectiveProgItem1:setAlpha(1)
			f47_arg0.ObjectiveProgItem1:setZRot(-345)
			f47_arg0.ObjectiveProgItem1:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem1)
			f47_arg0.ObjectiveProgItem2:completeAnimation()
			f47_arg0.ObjectiveProgItem2:setLeftRight(0, 0, -1, 383)
			f47_arg0.ObjectiveProgItem2:setTopBottom(0, 0, 37, 437)
			f47_arg0.ObjectiveProgItem2:setAlpha(1)
			f47_arg0.ObjectiveProgItem2:setZRot(0)
			f47_arg0.ObjectiveProgItem2:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem2)
			f47_arg0.ObjectiveProgItem3:completeAnimation()
			f47_arg0.ObjectiveProgItem3:setLeftRight(0, 0, -32, 352)
			f47_arg0.ObjectiveProgItem3:setTopBottom(0, 0, 27, 427)
			f47_arg0.ObjectiveProgItem3:setAlpha(1)
			f47_arg0.ObjectiveProgItem3:setZRot(-21)
			f47_arg0.ObjectiveProgItem3:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem3)
			f47_arg0.ObjectiveProgItem4:completeAnimation()
			f47_arg0.ObjectiveProgItem4:setLeftRight(0, 0, -36, 348)
			f47_arg0.ObjectiveProgItem4:setTopBottom(0, 0, -34, 366)
			f47_arg0.ObjectiveProgItem4:setAlpha(1)
			f47_arg0.ObjectiveProgItem4:setZRot(-116)
			f47_arg0.ObjectiveProgItem4:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem4)
			f47_arg0.ObjectiveProgItem5:completeAnimation()
			f47_arg0.ObjectiveProgItem5:setLeftRight(0, 0, -30, 354)
			f47_arg0.ObjectiveProgItem5:setTopBottom(0, 0, -43, 357)
			f47_arg0.ObjectiveProgItem5:setAlpha(1)
			f47_arg0.ObjectiveProgItem5:setZRot(-132)
			f47_arg0.ObjectiveProgItem5:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem5)
			f47_arg0.ObjectiveProgItem6:completeAnimation()
			f47_arg0.ObjectiveProgItem6:setLeftRight(0, 0, -18, 366)
			f47_arg0.ObjectiveProgItem6:setTopBottom(0, 0, -51, 349)
			f47_arg0.ObjectiveProgItem6:setAlpha(1)
			f47_arg0.ObjectiveProgItem6:setZRot(-148)
			f47_arg0.ObjectiveProgItem6:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem6)
			f47_arg0.ObjectiveProgItem7:completeAnimation()
			f47_arg0.ObjectiveProgItem7:setLeftRight(0, 0, 13, 397)
			f47_arg0.ObjectiveProgItem7:setTopBottom(0, 0, -52, 348)
			f47_arg0.ObjectiveProgItem7:setAlpha(1)
			f47_arg0.ObjectiveProgItem7:setZRot(-211)
			f47_arg0.ObjectiveProgItem7:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem7)
			f47_arg0.ObjectiveProgItem8:completeAnimation()
			f47_arg0.ObjectiveProgItem8:setLeftRight(0, 0, 33, 417)
			f47_arg0.ObjectiveProgItem8:setTopBottom(0, 0, -37, 363)
			f47_arg0.ObjectiveProgItem8:setAlpha(1)
			f47_arg0.ObjectiveProgItem8:setZRot(-230)
			f47_arg0.ObjectiveProgItem8:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem8)
			f47_arg0.ObjectiveProgItem9:completeAnimation()
			f47_arg0.ObjectiveProgItem9:setLeftRight(0, 0, 38, 422)
			f47_arg0.ObjectiveProgItem9:setTopBottom(0, 0, -26, 374)
			f47_arg0.ObjectiveProgItem9:setAlpha(1)
			f47_arg0.ObjectiveProgItem9:setZRot(-246)
			f47_arg0.ObjectiveProgItem9:setScale(1.76, 1.76)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem9)
			f47_arg0.ObjectiveProgItem10:completeAnimation()
			f47_arg0.ObjectiveProgItem10:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem10)
			f47_arg0.ObjectiveProgItem11:completeAnimation()
			f47_arg0.ObjectiveProgItem11:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem11)
			f47_arg0.ObjectiveProgItem12:completeAnimation()
			f47_arg0.ObjectiveProgItem12:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.ObjectiveProgItem12)
		end,
	},
	FiveItems = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(9)
			f48_arg0.ObjectiveProgItem1:completeAnimation()
			f48_arg0.ObjectiveProgItem1:setTopBottom(0, 0, -4, 396)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem1)
			f48_arg0.ObjectiveProgItem2:completeAnimation()
			f48_arg0.ObjectiveProgItem2:setLeftRight(0, 0, 18, 402)
			f48_arg0.ObjectiveProgItem2:setTopBottom(0, 0, -33, 367)
			f48_arg0.ObjectiveProgItem2:setZRot(-72)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem2)
			f48_arg0.ObjectiveProgItem3:completeAnimation()
			f48_arg0.ObjectiveProgItem3:setLeftRight(0, 0, 16, 400)
			f48_arg0.ObjectiveProgItem3:setTopBottom(0, 0, 57, 457)
			f48_arg0.ObjectiveProgItem3:setZRot(-144)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem3)
			f48_arg0.ObjectiveProgItem4:completeAnimation()
			f48_arg0.ObjectiveProgItem4:setLeftRight(0, 0, -10, 374)
			f48_arg0.ObjectiveProgItem4:setTopBottom(0, 0, 60, 460)
			f48_arg0.ObjectiveProgItem4:setZRot(-216)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem4)
			f48_arg0.ObjectiveProgItem5:completeAnimation()
			f48_arg0.ObjectiveProgItem5:setLeftRight(0, 0, -16, 368)
			f48_arg0.ObjectiveProgItem5:setTopBottom(0, 0, -35, 365)
			f48_arg0.ObjectiveProgItem5:setZRot(-288)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem5)
			f48_arg0.ObjectiveProgItem6:completeAnimation()
			f48_arg0.ObjectiveProgItem6:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem6)
			f48_arg0.ObjectiveProgItem7:completeAnimation()
			f48_arg0.ObjectiveProgItem7:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem7)
			f48_arg0.ObjectiveProgItem8:completeAnimation()
			f48_arg0.ObjectiveProgItem8:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem8)
			f48_arg0.ObjectiveProgItem9:completeAnimation()
			f48_arg0.ObjectiveProgItem9:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.ObjectiveProgItem9)
		end,
	},
	TwelveItems = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(11)
			f49_arg0.ObjectiveProgItem2:completeAnimation()
			f49_arg0.ObjectiveProgItem2:setZRot(-36)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem2)
			f49_arg0.ObjectiveProgItem3:completeAnimation()
			f49_arg0.ObjectiveProgItem3:setZRot(-60)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem3)
			f49_arg0.ObjectiveProgItem4:completeAnimation()
			f49_arg0.ObjectiveProgItem4:setZRot(-84)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem4)
			f49_arg0.ObjectiveProgItem5:completeAnimation()
			f49_arg0.ObjectiveProgItem5:setZRot(-120)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem5)
			f49_arg0.ObjectiveProgItem6:completeAnimation()
			f49_arg0.ObjectiveProgItem6:setZRot(-156)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem6)
			f49_arg0.ObjectiveProgItem7:completeAnimation()
			f49_arg0.ObjectiveProgItem7:setZRot(-180)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem7)
			f49_arg0.ObjectiveProgItem8:completeAnimation()
			f49_arg0.ObjectiveProgItem8:setZRot(-204)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem8)
			f49_arg0.ObjectiveProgItem9:completeAnimation()
			f49_arg0.ObjectiveProgItem9:setZRot(-240)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem9)
			f49_arg0.ObjectiveProgItem10:completeAnimation()
			f49_arg0.ObjectiveProgItem10:setAlpha(1)
			f49_arg0.ObjectiveProgItem10:setZRot(-276)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem10)
			f49_arg0.ObjectiveProgItem11:completeAnimation()
			f49_arg0.ObjectiveProgItem11:setAlpha(1)
			f49_arg0.ObjectiveProgItem11:setZRot(-300)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem11)
			f49_arg0.ObjectiveProgItem12:completeAnimation()
			f49_arg0.ObjectiveProgItem12:setAlpha(1)
			f49_arg0.ObjectiveProgItem12:setZRot(-324)
			f49_arg0.clipFinished(f49_arg0.ObjectiveProgItem12)
		end,
	},
	NineItems = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(12)
			f50_arg0.ObjectiveProgItem1:completeAnimation()
			f50_arg0.ObjectiveProgItem1:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem1)
			f50_arg0.ObjectiveProgItem2:completeAnimation()
			f50_arg0.ObjectiveProgItem2:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem2)
			f50_arg0.ObjectiveProgItem3:completeAnimation()
			f50_arg0.ObjectiveProgItem3:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem3)
			f50_arg0.ObjectiveProgItem4:completeAnimation()
			f50_arg0.ObjectiveProgItem4:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem4)
			f50_arg0.ObjectiveProgItem5:completeAnimation()
			f50_arg0.ObjectiveProgItem5:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem5)
			f50_arg0.ObjectiveProgItem6:completeAnimation()
			f50_arg0.ObjectiveProgItem6:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem6)
			f50_arg0.ObjectiveProgItem7:completeAnimation()
			f50_arg0.ObjectiveProgItem7:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem7)
			f50_arg0.ObjectiveProgItem8:completeAnimation()
			f50_arg0.ObjectiveProgItem8:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem8)
			f50_arg0.ObjectiveProgItem9:completeAnimation()
			f50_arg0.ObjectiveProgItem9:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem9)
			f50_arg0.ObjectiveProgItem10:completeAnimation()
			f50_arg0.ObjectiveProgItem10:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem10)
			f50_arg0.ObjectiveProgItem11:completeAnimation()
			f50_arg0.ObjectiveProgItem11:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem11)
			f50_arg0.ObjectiveProgItem12:completeAnimation()
			f50_arg0.ObjectiveProgItem12:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.ObjectiveProgItem12)
		end,
	},
	TwelveItemsZMOrange = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(11)
			f51_arg0.ObjectiveProgItem2:completeAnimation()
			f51_arg0.ObjectiveProgItem2:setZRot(-36)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem2)
			f51_arg0.ObjectiveProgItem3:completeAnimation()
			f51_arg0.ObjectiveProgItem3:setZRot(-60)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem3)
			f51_arg0.ObjectiveProgItem4:completeAnimation()
			f51_arg0.ObjectiveProgItem4:setZRot(-84)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem4)
			f51_arg0.ObjectiveProgItem5:completeAnimation()
			f51_arg0.ObjectiveProgItem5:setZRot(-120)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem5)
			f51_arg0.ObjectiveProgItem6:completeAnimation()
			f51_arg0.ObjectiveProgItem6:setZRot(-156)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem6)
			f51_arg0.ObjectiveProgItem7:completeAnimation()
			f51_arg0.ObjectiveProgItem7:setZRot(-180)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem7)
			f51_arg0.ObjectiveProgItem8:completeAnimation()
			f51_arg0.ObjectiveProgItem8:setZRot(-204)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem8)
			f51_arg0.ObjectiveProgItem9:completeAnimation()
			f51_arg0.ObjectiveProgItem9:setZRot(-240)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem9)
			f51_arg0.ObjectiveProgItem10:completeAnimation()
			f51_arg0.ObjectiveProgItem10:setAlpha(1)
			f51_arg0.ObjectiveProgItem10:setZRot(-276)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem10)
			f51_arg0.ObjectiveProgItem11:completeAnimation()
			f51_arg0.ObjectiveProgItem11:setAlpha(1)
			f51_arg0.ObjectiveProgItem11:setZRot(-300)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem11)
			f51_arg0.ObjectiveProgItem12:completeAnimation()
			f51_arg0.ObjectiveProgItem12:setAlpha(1)
			f51_arg0.ObjectiveProgItem12:setZRot(-324)
			f51_arg0.clipFinished(f51_arg0.ObjectiveProgItem12)
		end,
	},
}
CoD.ZMInvObjectiveProgressRing.__onClose = function(f52_arg0)
	f52_arg0.ObjectiveProgItem1:close()
	f52_arg0.ObjectiveProgItem2:close()
	f52_arg0.ObjectiveProgItem3:close()
	f52_arg0.ObjectiveProgItem4:close()
	f52_arg0.ObjectiveProgItem5:close()
	f52_arg0.ObjectiveProgItem6:close()
	f52_arg0.ObjectiveProgItem7:close()
	f52_arg0.ObjectiveProgItem8:close()
	f52_arg0.ObjectiveProgItem9:close()
	f52_arg0.ObjectiveProgItem10:close()
	f52_arg0.ObjectiveProgItem11:close()
	f52_arg0.ObjectiveProgItem12:close()
end
