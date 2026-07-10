require("x64:6bffb9001264254")
require("x64:fd51e83e2e6dbd1")
require("x64:150529e44cb94d7")
require("x64:478f2bd71f935fd")
CoD.MultiItemPickupWaypointItemKBM = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupWaypointItemKBM.__defaultWidth = 100
CoD.MultiItemPickupWaypointItemKBM.__defaultHeight = 100
CoD.MultiItemPickupWaypointItemKBM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MultiItemPickupWaypointItemKBM)
	self.id = "MultiItemPickupWaypointItemKBM"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.MultiItemPickupItemBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -46, 46, 0.5, 0.5, -45, 45)
	Backing:linkToElementModel(self, nil, false, function(model)
		Backing:setModel(model, f1_arg1)
	end)
	self:addElement(Backing)
	self.Backing = Backing
	local StackCount = CoD.WarzoneInventoryCounter.new(f1_arg0, f1_arg1, 0.5, 0.5, 18, 38, 0.5, 0.5, 19, 39)
	StackCount:linkToElementModel(self, nil, false, function(model)
		StackCount:setModel(model, f1_arg1)
	end)
	StackCount:linkToElementModel(self, "stackCount", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			StackCount.Counter:setText(f4_local0)
		end
	end)
	self:addElement(StackCount)
	self.StackCount = StackCount
	local PickupHintImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -46, 46, 0.5, 0.5, -23, 23)
	PickupHintImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	PickupHintImage:setShaderVector(0, 1, 0, 0, 0)
	PickupHintImage:linkToElementModel(self, "icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			PickupHintImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(PickupHintImage)
	self.PickupHintImage = PickupHintImage
	local pip1 = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -18, -11, 0, 0, 12, 19)
	pip1:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "stashStackSize", 2)
			end,
		},
	})
	pip1:linkToElementModel(pip1, "stashStackSize", true, function(model)
		f1_arg0:updateElementState(pip1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stashStackSize",
		})
	end)
	pip1:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	pip1.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	pip1:linkToElementModel(self, nil, false, function(model)
		pip1:setModel(model, f1_arg1)
	end)
	self:addElement(pip1)
	self.pip1 = pip1
	local pip2 = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -18, -11, 0, 0, 24, 31)
	pip2:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "stashStackSize", 3)
			end,
		},
	})
	pip2:linkToElementModel(pip2, "stashStackSize", true, function(model)
		f1_arg0:updateElementState(pip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stashStackSize",
		})
	end)
	pip2:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	pip2.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	pip2:linkToElementModel(self, nil, false, function(model)
		pip2:setModel(model, f1_arg1)
	end)
	self:addElement(pip2)
	self.pip2 = pip2
	local pip3 = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -18, -11, 0, 0, 36, 43)
	pip3:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "stashStackSize", 4)
			end,
		},
	})
	pip3:linkToElementModel(pip3, "stashStackSize", true, function(model)
		f1_arg0:updateElementState(pip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stashStackSize",
		})
	end)
	pip3:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	pip3.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	pip3:linkToElementModel(self, nil, false, function(model)
		pip3:setModel(model, f1_arg1)
	end)
	self:addElement(pip3)
	self.pip3 = pip3
	local pip4 = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -18, -11, 0, 0, 49, 56)
	pip4:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "stashStackSize", 5)
			end,
		},
	})
	pip4:linkToElementModel(pip4, "stashStackSize", true, function(model)
		f1_arg0:updateElementState(pip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stashStackSize",
		})
	end)
	pip4:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	pip4.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	pip4:linkToElementModel(self, nil, false, function(model)
		pip4:setModel(model, f1_arg1)
	end)
	self:addElement(pip4)
	self.pip4 = pip4
	local plusPip = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -19, -11, 0, 0, 65, 73)
	plusPip:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "stashStackSize", 6)
			end,
		},
	})
	plusPip:linkToElementModel(plusPip, "stashStackSize", true, function(model)
		f1_arg0:updateElementState(plusPip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stashStackSize",
		})
	end)
	plusPip:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	plusPip:setAlpha(0.8)
	plusPip:setScale(1.5, 1.5)
	plusPip.image:setImage(RegisterImage(0x7C4EFF3B53B8AF4))
	plusPip.image:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
	plusPip:linkToElementModel(self, nil, false, function(model)
		plusPip:setModel(model, f1_arg1)
	end)
	self:addElement(plusPip)
	self.plusPip = plusPip
	local ArmorBarWZ = CoD.ArmorBarWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -40, 40, 0, 0, 82, 90)
	ArmorBarWZ:mergeStateConditions({
		{
			stateName = "VisibleWithoutBacking",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ArmorBarWZ:linkToElementModel(ArmorBarWZ, "armor", true, function(model)
		f1_arg0:updateElementState(ArmorBarWZ, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "armor",
		})
	end)
	ArmorBarWZ:linkToElementModel(self, nil, false, function(model)
		ArmorBarWZ:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorBarWZ)
	self.ArmorBarWZ = ArmorBarWZ
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDummy")
			end,
		},
		{
			stateName = "InventoryFull",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "inventoryFull", 1)
			end,
		},
	})
	self:linkToElementModel(self, "isDummy", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isDummy",
		})
	end)
	self:linkToElementModel(self, "inventoryFull", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "inventoryFull",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "forceNotifyActive", function(model)
		local f28_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	Backing.id = "Backing"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MultiItemPickupWaypointItemKBM.__resetProperties = function(f29_arg0)
	f29_arg0.PickupHintImage:completeAnimation()
	f29_arg0.Backing:completeAnimation()
	f29_arg0.StackCount:completeAnimation()
	f29_arg0.plusPip:completeAnimation()
	f29_arg0.pip1:completeAnimation()
	f29_arg0.pip2:completeAnimation()
	f29_arg0.pip3:completeAnimation()
	f29_arg0.pip4:completeAnimation()
	f29_arg0.ArmorBarWZ:completeAnimation()
	f29_arg0.PickupHintImage:setRGB(1, 1, 1)
	f29_arg0.PickupHintImage:setAlpha(1)
	f29_arg0.PickupHintImage:setScale(1, 1)
	f29_arg0.PickupHintImage:setShaderVector(0, 1, 0, 0, 0)
	f29_arg0.Backing:setScale(1, 1)
	f29_arg0.StackCount:setLeftRight(0.5, 0.5, 18, 38)
	f29_arg0.StackCount:setTopBottom(0.5, 0.5, 19, 39)
	f29_arg0.StackCount:setAlpha(1)
	f29_arg0.StackCount:setScale(1, 1)
	f29_arg0.plusPip:setLeftRight(1, 1, -19, -11)
	f29_arg0.plusPip:setTopBottom(0, 0, 65, 73)
	f29_arg0.plusPip:setAlpha(0.8)
	f29_arg0.plusPip:setScale(1.5, 1.5)
	f29_arg0.pip1:setLeftRight(1, 1, -18, -11)
	f29_arg0.pip1:setTopBottom(0, 0, 12, 19)
	f29_arg0.pip1:setAlpha(1)
	f29_arg0.pip2:setLeftRight(1, 1, -18, -11)
	f29_arg0.pip2:setTopBottom(0, 0, 24, 31)
	f29_arg0.pip2:setAlpha(1)
	f29_arg0.pip3:setLeftRight(1, 1, -18, -11)
	f29_arg0.pip3:setTopBottom(0, 0, 36, 43)
	f29_arg0.pip3:setAlpha(1)
	f29_arg0.pip4:setLeftRight(1, 1, -18, -11)
	f29_arg0.pip4:setTopBottom(0, 0, 49, 56)
	f29_arg0.pip4:setAlpha(1)
	f29_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -40, 40)
	f29_arg0.ArmorBarWZ:setTopBottom(0, 0, 82, 90)
	f29_arg0.ArmorBarWZ:setAlpha(1)
end
CoD.MultiItemPickupWaypointItemKBM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(9)
			f31_arg0.Backing:completeAnimation()
			f31_arg0.Backing:setScale(1.08, 1.08)
			f31_arg0.clipFinished(f31_arg0.Backing)
			f31_arg0.StackCount:completeAnimation()
			f31_arg0.StackCount:setLeftRight(0.5, 0.5, 20, 40)
			f31_arg0.StackCount:setTopBottom(0.5, 0.5, 22, 42)
			f31_arg0.StackCount:setScale(1.08, 1.08)
			f31_arg0.clipFinished(f31_arg0.StackCount)
			f31_arg0.PickupHintImage:completeAnimation()
			f31_arg0.PickupHintImage:setScale(1.08, 1.08)
			f31_arg0.clipFinished(f31_arg0.PickupHintImage)
			f31_arg0.pip1:completeAnimation()
			f31_arg0.pip1:setLeftRight(1, 1, -17, -9)
			f31_arg0.pip1:setTopBottom(0, 0, 9, 17)
			f31_arg0.clipFinished(f31_arg0.pip1)
			f31_arg0.pip2:completeAnimation()
			f31_arg0.pip2:setLeftRight(1, 1, -17, -9)
			f31_arg0.pip2:setTopBottom(0, 0, 23, 31)
			f31_arg0.clipFinished(f31_arg0.pip2)
			f31_arg0.pip3:completeAnimation()
			f31_arg0.pip3:setLeftRight(1, 1, -17, -9)
			f31_arg0.pip3:setTopBottom(0, 0, 36, 44)
			f31_arg0.clipFinished(f31_arg0.pip3)
			f31_arg0.pip4:completeAnimation()
			f31_arg0.pip4:setLeftRight(1, 1, -17, -9)
			f31_arg0.pip4:setTopBottom(0, 0, 50, 58)
			f31_arg0.clipFinished(f31_arg0.pip4)
			f31_arg0.plusPip:completeAnimation()
			f31_arg0.plusPip:setLeftRight(1, 1, -17, -9)
			f31_arg0.plusPip:setTopBottom(0, 0, 67, 75)
			f31_arg0.plusPip:setScale(1.62, 1.62)
			f31_arg0.clipFinished(f31_arg0.plusPip)
			f31_arg0.ArmorBarWZ:completeAnimation()
			f31_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -44, 44)
			f31_arg0.ArmorBarWZ:setTopBottom(0, 0, 85, 94)
			f31_arg0.clipFinished(f31_arg0.ArmorBarWZ)
		end,
		GainChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(9)
			local f32_local0 = function(f33_arg0)
				f32_arg0.Backing:beginAnimation(140)
				f32_arg0.Backing:setScale(1.08, 1.08)
				f32_arg0.Backing:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.Backing:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.Backing:completeAnimation()
			f32_arg0.Backing:setScale(1, 1)
			f32_local0(f32_arg0.Backing)
			local f32_local1 = function(f34_arg0)
				f32_arg0.StackCount:beginAnimation(140)
				f32_arg0.StackCount:setLeftRight(0.5, 0.5, 20, 40)
				f32_arg0.StackCount:setTopBottom(0.5, 0.5, 22, 42)
				f32_arg0.StackCount:setScale(1.08, 1.08)
				f32_arg0.StackCount:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.StackCount:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.StackCount:completeAnimation()
			f32_arg0.StackCount:setLeftRight(0.5, 0.5, 18, 38)
			f32_arg0.StackCount:setTopBottom(0.5, 0.5, 19, 39)
			f32_arg0.StackCount:setScale(1, 1)
			f32_local1(f32_arg0.StackCount)
			local f32_local2 = function(f35_arg0)
				f32_arg0.PickupHintImage:beginAnimation(140)
				f32_arg0.PickupHintImage:setScale(1.08, 1.08)
				f32_arg0.PickupHintImage:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.PickupHintImage:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.PickupHintImage:completeAnimation()
			f32_arg0.PickupHintImage:setScale(1, 1)
			f32_local2(f32_arg0.PickupHintImage)
			local f32_local3 = function(f36_arg0)
				f32_arg0.pip1:beginAnimation(140)
				f32_arg0.pip1:setLeftRight(1, 1, -17, -9)
				f32_arg0.pip1:setTopBottom(0, 0, 9, 17)
				f32_arg0.pip1:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.pip1:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.pip1:completeAnimation()
			f32_arg0.pip1:setLeftRight(1, 1, -18, -11)
			f32_arg0.pip1:setTopBottom(0, 0, 12, 19)
			f32_local3(f32_arg0.pip1)
			local f32_local4 = function(f37_arg0)
				f32_arg0.pip2:beginAnimation(140)
				f32_arg0.pip2:setLeftRight(1, 1, -17, -9)
				f32_arg0.pip2:setTopBottom(0, 0, 23, 31)
				f32_arg0.pip2:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.pip2:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.pip2:completeAnimation()
			f32_arg0.pip2:setLeftRight(1, 1, -18, -11)
			f32_arg0.pip2:setTopBottom(0, 0, 24, 31)
			f32_local4(f32_arg0.pip2)
			local f32_local5 = function(f38_arg0)
				f32_arg0.pip3:beginAnimation(140)
				f32_arg0.pip3:setLeftRight(1, 1, -17, -9)
				f32_arg0.pip3:setTopBottom(0, 0, 36, 44)
				f32_arg0.pip3:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.pip3:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.pip3:completeAnimation()
			f32_arg0.pip3:setLeftRight(1, 1, -18, -11)
			f32_arg0.pip3:setTopBottom(0, 0, 36, 43)
			f32_local5(f32_arg0.pip3)
			local f32_local6 = function(f39_arg0)
				f32_arg0.pip4:beginAnimation(140)
				f32_arg0.pip4:setLeftRight(1, 1, -17, -9)
				f32_arg0.pip4:setTopBottom(0, 0, 50, 58)
				f32_arg0.pip4:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.pip4:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.pip4:completeAnimation()
			f32_arg0.pip4:setLeftRight(1, 1, -18, -11)
			f32_arg0.pip4:setTopBottom(0, 0, 49, 56)
			f32_local6(f32_arg0.pip4)
			local f32_local7 = function(f40_arg0)
				f32_arg0.plusPip:beginAnimation(140)
				f32_arg0.plusPip:setLeftRight(1, 1, -17, -9)
				f32_arg0.plusPip:setTopBottom(0, 0, 67, 75)
				f32_arg0.plusPip:setScale(1.62, 1.62)
				f32_arg0.plusPip:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.plusPip:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.plusPip:completeAnimation()
			f32_arg0.plusPip:setLeftRight(1, 1, -19, -11)
			f32_arg0.plusPip:setTopBottom(0, 0, 65, 73)
			f32_arg0.plusPip:setScale(1.5, 1.5)
			f32_local7(f32_arg0.plusPip)
			local f32_local8 = function(f41_arg0)
				f32_arg0.ArmorBarWZ:beginAnimation(140)
				f32_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -44, 44)
				f32_arg0.ArmorBarWZ:setTopBottom(0, 0, 85, 94)
				f32_arg0.ArmorBarWZ:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ArmorBarWZ:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.ArmorBarWZ:completeAnimation()
			f32_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -40, 40)
			f32_arg0.ArmorBarWZ:setTopBottom(0, 0, 82, 90)
			f32_local8(f32_arg0.ArmorBarWZ)
		end,
		LoseChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(9)
			local f42_local0 = function(f43_arg0)
				f42_arg0.Backing:beginAnimation(140)
				f42_arg0.Backing:setScale(1, 1)
				f42_arg0.Backing:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.Backing:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.Backing:completeAnimation()
			f42_arg0.Backing:setScale(1.08, 1.08)
			f42_local0(f42_arg0.Backing)
			local f42_local1 = function(f44_arg0)
				f42_arg0.StackCount:beginAnimation(140)
				f42_arg0.StackCount:setLeftRight(0.5, 0.5, 18, 38)
				f42_arg0.StackCount:setTopBottom(0.5, 0.5, 19, 39)
				f42_arg0.StackCount:setScale(1, 1)
				f42_arg0.StackCount:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.StackCount:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.StackCount:completeAnimation()
			f42_arg0.StackCount:setLeftRight(0.5, 0.5, 20, 40)
			f42_arg0.StackCount:setTopBottom(0.5, 0.5, 22, 42)
			f42_arg0.StackCount:setScale(1.08, 1.08)
			f42_local1(f42_arg0.StackCount)
			local f42_local2 = function(f45_arg0)
				f42_arg0.PickupHintImage:beginAnimation(140)
				f42_arg0.PickupHintImage:setScale(1, 1)
				f42_arg0.PickupHintImage:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.PickupHintImage:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.PickupHintImage:completeAnimation()
			f42_arg0.PickupHintImage:setScale(1.08, 1.08)
			f42_local2(f42_arg0.PickupHintImage)
			local f42_local3 = function(f46_arg0)
				f42_arg0.pip1:beginAnimation(140)
				f42_arg0.pip1:setLeftRight(1, 1, -18, -11)
				f42_arg0.pip1:setTopBottom(0, 0, 12, 19)
				f42_arg0.pip1:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.pip1:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.pip1:completeAnimation()
			f42_arg0.pip1:setLeftRight(1, 1, -17, -9)
			f42_arg0.pip1:setTopBottom(0, 0, 9, 17)
			f42_local3(f42_arg0.pip1)
			local f42_local4 = function(f47_arg0)
				f42_arg0.pip2:beginAnimation(140)
				f42_arg0.pip2:setLeftRight(1, 1, -18, -11)
				f42_arg0.pip2:setTopBottom(0, 0, 24, 31)
				f42_arg0.pip2:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.pip2:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.pip2:completeAnimation()
			f42_arg0.pip2:setLeftRight(1, 1, -17, -9)
			f42_arg0.pip2:setTopBottom(0, 0, 23, 31)
			f42_local4(f42_arg0.pip2)
			local f42_local5 = function(f48_arg0)
				f42_arg0.pip3:beginAnimation(140)
				f42_arg0.pip3:setLeftRight(1, 1, -18, -11)
				f42_arg0.pip3:setTopBottom(0, 0, 36, 43)
				f42_arg0.pip3:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.pip3:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.pip3:completeAnimation()
			f42_arg0.pip3:setLeftRight(1, 1, -17, -9)
			f42_arg0.pip3:setTopBottom(0, 0, 36, 44)
			f42_local5(f42_arg0.pip3)
			local f42_local6 = function(f49_arg0)
				f42_arg0.pip4:beginAnimation(140)
				f42_arg0.pip4:setLeftRight(1, 1, -18, -11)
				f42_arg0.pip4:setTopBottom(0, 0, 49, 56)
				f42_arg0.pip4:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.pip4:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.pip4:completeAnimation()
			f42_arg0.pip4:setLeftRight(1, 1, -17, -9)
			f42_arg0.pip4:setTopBottom(0, 0, 50, 58)
			f42_local6(f42_arg0.pip4)
			local f42_local7 = function(f50_arg0)
				f42_arg0.plusPip:beginAnimation(140)
				f42_arg0.plusPip:setLeftRight(1, 1, -19, -11)
				f42_arg0.plusPip:setTopBottom(0, 0, 65, 73)
				f42_arg0.plusPip:setScale(1.5, 1.5)
				f42_arg0.plusPip:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.plusPip:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.plusPip:completeAnimation()
			f42_arg0.plusPip:setLeftRight(1, 1, -17, -9)
			f42_arg0.plusPip:setTopBottom(0, 0, 67, 75)
			f42_arg0.plusPip:setScale(1.62, 1.62)
			f42_local7(f42_arg0.plusPip)
			local f42_local8 = function(f51_arg0)
				f42_arg0.ArmorBarWZ:beginAnimation(140)
				f42_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -40, 40)
				f42_arg0.ArmorBarWZ:setTopBottom(0, 0, 82, 90)
				f42_arg0.ArmorBarWZ:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.ArmorBarWZ:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.ArmorBarWZ:completeAnimation()
			f42_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -44, 44)
			f42_arg0.ArmorBarWZ:setTopBottom(0, 0, 85, 94)
			f42_local8(f42_arg0.ArmorBarWZ)
		end,
	},
	Disabled = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(8)
			f52_arg0.StackCount:completeAnimation()
			f52_arg0.StackCount:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.StackCount)
			f52_arg0.PickupHintImage:completeAnimation()
			f52_arg0.PickupHintImage:setAlpha(0)
			f52_arg0.PickupHintImage:setScale(1.25, 1.25)
			f52_arg0.clipFinished(f52_arg0.PickupHintImage)
			f52_arg0.pip1:completeAnimation()
			f52_arg0.pip1:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.pip1)
			f52_arg0.pip2:completeAnimation()
			f52_arg0.pip2:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.pip2)
			f52_arg0.pip3:completeAnimation()
			f52_arg0.pip3:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.pip3)
			f52_arg0.pip4:completeAnimation()
			f52_arg0.pip4:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.pip4)
			f52_arg0.plusPip:completeAnimation()
			f52_arg0.plusPip:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.plusPip)
			f52_arg0.ArmorBarWZ:completeAnimation()
			f52_arg0.ArmorBarWZ:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.ArmorBarWZ)
		end,
	},
	InventoryFull = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(1)
			f53_arg0.PickupHintImage:completeAnimation()
			f53_arg0.PickupHintImage:setRGB(0.36, 0.36, 0.38)
			f53_arg0.PickupHintImage:setShaderVector(0, 0, 0, 0, 0)
			f53_arg0.clipFinished(f53_arg0.PickupHintImage)
		end,
		ChildFocus = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(9)
			f54_arg0.Backing:completeAnimation()
			f54_arg0.Backing:setScale(1.08, 1.08)
			f54_arg0.clipFinished(f54_arg0.Backing)
			f54_arg0.StackCount:completeAnimation()
			f54_arg0.StackCount:setLeftRight(0.5, 0.5, 20, 40)
			f54_arg0.StackCount:setTopBottom(0.5, 0.5, 22, 42)
			f54_arg0.StackCount:setScale(1.08, 1.08)
			f54_arg0.clipFinished(f54_arg0.StackCount)
			f54_arg0.PickupHintImage:completeAnimation()
			f54_arg0.PickupHintImage:setRGB(0.36, 0.36, 0.38)
			f54_arg0.PickupHintImage:setScale(1.08, 1.08)
			f54_arg0.PickupHintImage:setShaderVector(0, 0, 0, 0, 0)
			f54_arg0.clipFinished(f54_arg0.PickupHintImage)
			f54_arg0.pip1:completeAnimation()
			f54_arg0.pip1:setLeftRight(1, 1, -17, -9)
			f54_arg0.pip1:setTopBottom(0, 0, 9, 17)
			f54_arg0.clipFinished(f54_arg0.pip1)
			f54_arg0.pip2:completeAnimation()
			f54_arg0.pip2:setLeftRight(1, 1, -17, -9)
			f54_arg0.pip2:setTopBottom(0, 0, 23, 31)
			f54_arg0.clipFinished(f54_arg0.pip2)
			f54_arg0.pip3:completeAnimation()
			f54_arg0.pip3:setLeftRight(1, 1, -17, -9)
			f54_arg0.pip3:setTopBottom(0, 0, 36, 44)
			f54_arg0.clipFinished(f54_arg0.pip3)
			f54_arg0.pip4:completeAnimation()
			f54_arg0.pip4:setLeftRight(1, 1, -17, -9)
			f54_arg0.pip4:setTopBottom(0, 0, 50, 58)
			f54_arg0.clipFinished(f54_arg0.pip4)
			f54_arg0.plusPip:completeAnimation()
			f54_arg0.plusPip:setLeftRight(1, 1, -17, -9)
			f54_arg0.plusPip:setTopBottom(0, 0, 67, 75)
			f54_arg0.plusPip:setScale(1.62, 1.62)
			f54_arg0.clipFinished(f54_arg0.plusPip)
			f54_arg0.ArmorBarWZ:completeAnimation()
			f54_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -44, 44)
			f54_arg0.ArmorBarWZ:setTopBottom(0, 0, 85, 94)
			f54_arg0.clipFinished(f54_arg0.ArmorBarWZ)
		end,
		GainChildFocus = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(9)
			local f55_local0 = function(f56_arg0)
				f55_arg0.Backing:beginAnimation(140)
				f55_arg0.Backing:setScale(1.08, 1.08)
				f55_arg0.Backing:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.Backing:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.Backing:completeAnimation()
			f55_arg0.Backing:setScale(1, 1)
			f55_local0(f55_arg0.Backing)
			local f55_local1 = function(f57_arg0)
				f55_arg0.StackCount:beginAnimation(140)
				f55_arg0.StackCount:setLeftRight(0.5, 0.5, 20, 40)
				f55_arg0.StackCount:setTopBottom(0.5, 0.5, 22, 42)
				f55_arg0.StackCount:setScale(1.08, 1.08)
				f55_arg0.StackCount:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.StackCount:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.StackCount:completeAnimation()
			f55_arg0.StackCount:setLeftRight(0.5, 0.5, 18, 38)
			f55_arg0.StackCount:setTopBottom(0.5, 0.5, 19, 39)
			f55_arg0.StackCount:setScale(1, 1)
			f55_local1(f55_arg0.StackCount)
			local f55_local2 = function(f58_arg0)
				f55_arg0.PickupHintImage:beginAnimation(140)
				f55_arg0.PickupHintImage:setScale(1.08, 1.08)
				f55_arg0.PickupHintImage:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.PickupHintImage:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.PickupHintImage:completeAnimation()
			f55_arg0.PickupHintImage:setRGB(0.36, 0.36, 0.38)
			f55_arg0.PickupHintImage:setScale(1, 1)
			f55_arg0.PickupHintImage:setShaderVector(0, 0, 0, 0, 0)
			f55_local2(f55_arg0.PickupHintImage)
			local f55_local3 = function(f59_arg0)
				f55_arg0.pip1:beginAnimation(140)
				f55_arg0.pip1:setLeftRight(1, 1, -17, -9)
				f55_arg0.pip1:setTopBottom(0, 0, 9, 17)
				f55_arg0.pip1:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.pip1:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.pip1:completeAnimation()
			f55_arg0.pip1:setLeftRight(1, 1, -18, -11)
			f55_arg0.pip1:setTopBottom(0, 0, 12, 19)
			f55_local3(f55_arg0.pip1)
			local f55_local4 = function(f60_arg0)
				f55_arg0.pip2:beginAnimation(140)
				f55_arg0.pip2:setLeftRight(1, 1, -17, -9)
				f55_arg0.pip2:setTopBottom(0, 0, 23, 31)
				f55_arg0.pip2:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.pip2:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.pip2:completeAnimation()
			f55_arg0.pip2:setLeftRight(1, 1, -18, -11)
			f55_arg0.pip2:setTopBottom(0, 0, 24, 31)
			f55_local4(f55_arg0.pip2)
			local f55_local5 = function(f61_arg0)
				f55_arg0.pip3:beginAnimation(140)
				f55_arg0.pip3:setLeftRight(1, 1, -17, -9)
				f55_arg0.pip3:setTopBottom(0, 0, 36, 44)
				f55_arg0.pip3:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.pip3:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.pip3:completeAnimation()
			f55_arg0.pip3:setLeftRight(1, 1, -18, -11)
			f55_arg0.pip3:setTopBottom(0, 0, 36, 43)
			f55_local5(f55_arg0.pip3)
			local f55_local6 = function(f62_arg0)
				f55_arg0.pip4:beginAnimation(140)
				f55_arg0.pip4:setLeftRight(1, 1, -17, -9)
				f55_arg0.pip4:setTopBottom(0, 0, 50, 58)
				f55_arg0.pip4:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.pip4:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.pip4:completeAnimation()
			f55_arg0.pip4:setLeftRight(1, 1, -18, -11)
			f55_arg0.pip4:setTopBottom(0, 0, 49, 56)
			f55_local6(f55_arg0.pip4)
			local f55_local7 = function(f63_arg0)
				f55_arg0.plusPip:beginAnimation(140)
				f55_arg0.plusPip:setLeftRight(1, 1, -17, -9)
				f55_arg0.plusPip:setTopBottom(0, 0, 67, 75)
				f55_arg0.plusPip:setScale(1.62, 1.62)
				f55_arg0.plusPip:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.plusPip:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.plusPip:completeAnimation()
			f55_arg0.plusPip:setLeftRight(1, 1, -19, -11)
			f55_arg0.plusPip:setTopBottom(0, 0, 65, 73)
			f55_arg0.plusPip:setScale(1.5, 1.5)
			f55_local7(f55_arg0.plusPip)
			local f55_local8 = function(f64_arg0)
				f55_arg0.ArmorBarWZ:beginAnimation(140)
				f55_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -44, 44)
				f55_arg0.ArmorBarWZ:setTopBottom(0, 0, 85, 94)
				f55_arg0.ArmorBarWZ:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.ArmorBarWZ:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
			end
			f55_arg0.ArmorBarWZ:completeAnimation()
			f55_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -40, 40)
			f55_arg0.ArmorBarWZ:setTopBottom(0, 0, 82, 90)
			f55_local8(f55_arg0.ArmorBarWZ)
		end,
		LoseChildFocus = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(9)
			local f65_local0 = function(f66_arg0)
				f65_arg0.Backing:beginAnimation(140)
				f65_arg0.Backing:setScale(1, 1)
				f65_arg0.Backing:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.Backing:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.Backing:completeAnimation()
			f65_arg0.Backing:setScale(1.08, 1.08)
			f65_local0(f65_arg0.Backing)
			local f65_local1 = function(f67_arg0)
				f65_arg0.StackCount:beginAnimation(140)
				f65_arg0.StackCount:setLeftRight(0.5, 0.5, 18, 38)
				f65_arg0.StackCount:setTopBottom(0.5, 0.5, 19, 39)
				f65_arg0.StackCount:setScale(1, 1)
				f65_arg0.StackCount:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.StackCount:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.StackCount:completeAnimation()
			f65_arg0.StackCount:setLeftRight(0.5, 0.5, 20, 40)
			f65_arg0.StackCount:setTopBottom(0.5, 0.5, 22, 42)
			f65_arg0.StackCount:setScale(1.08, 1.08)
			f65_local1(f65_arg0.StackCount)
			local f65_local2 = function(f68_arg0)
				f65_arg0.PickupHintImage:beginAnimation(140)
				f65_arg0.PickupHintImage:setScale(1, 1)
				f65_arg0.PickupHintImage:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.PickupHintImage:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.PickupHintImage:completeAnimation()
			f65_arg0.PickupHintImage:setRGB(0.36, 0.36, 0.38)
			f65_arg0.PickupHintImage:setScale(1.08, 1.08)
			f65_arg0.PickupHintImage:setShaderVector(0, 0, 0, 0, 0)
			f65_local2(f65_arg0.PickupHintImage)
			local f65_local3 = function(f69_arg0)
				f65_arg0.pip1:beginAnimation(140)
				f65_arg0.pip1:setLeftRight(1, 1, -18, -11)
				f65_arg0.pip1:setTopBottom(0, 0, 12, 19)
				f65_arg0.pip1:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.pip1:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.pip1:completeAnimation()
			f65_arg0.pip1:setLeftRight(1, 1, -17, -9)
			f65_arg0.pip1:setTopBottom(0, 0, 9, 17)
			f65_local3(f65_arg0.pip1)
			local f65_local4 = function(f70_arg0)
				f65_arg0.pip2:beginAnimation(140)
				f65_arg0.pip2:setLeftRight(1, 1, -18, -11)
				f65_arg0.pip2:setTopBottom(0, 0, 24, 31)
				f65_arg0.pip2:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.pip2:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.pip2:completeAnimation()
			f65_arg0.pip2:setLeftRight(1, 1, -17, -9)
			f65_arg0.pip2:setTopBottom(0, 0, 23, 31)
			f65_local4(f65_arg0.pip2)
			local f65_local5 = function(f71_arg0)
				f65_arg0.pip3:beginAnimation(140)
				f65_arg0.pip3:setLeftRight(1, 1, -18, -11)
				f65_arg0.pip3:setTopBottom(0, 0, 36, 43)
				f65_arg0.pip3:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.pip3:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.pip3:completeAnimation()
			f65_arg0.pip3:setLeftRight(1, 1, -17, -9)
			f65_arg0.pip3:setTopBottom(0, 0, 36, 44)
			f65_local5(f65_arg0.pip3)
			local f65_local6 = function(f72_arg0)
				f65_arg0.pip4:beginAnimation(140)
				f65_arg0.pip4:setLeftRight(1, 1, -18, -11)
				f65_arg0.pip4:setTopBottom(0, 0, 49, 56)
				f65_arg0.pip4:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.pip4:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.pip4:completeAnimation()
			f65_arg0.pip4:setLeftRight(1, 1, -17, -9)
			f65_arg0.pip4:setTopBottom(0, 0, 50, 58)
			f65_local6(f65_arg0.pip4)
			local f65_local7 = function(f73_arg0)
				f65_arg0.plusPip:beginAnimation(140)
				f65_arg0.plusPip:setLeftRight(1, 1, -19, -11)
				f65_arg0.plusPip:setTopBottom(0, 0, 65, 73)
				f65_arg0.plusPip:setScale(1.5, 1.5)
				f65_arg0.plusPip:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.plusPip:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.plusPip:completeAnimation()
			f65_arg0.plusPip:setLeftRight(1, 1, -17, -9)
			f65_arg0.plusPip:setTopBottom(0, 0, 67, 75)
			f65_arg0.plusPip:setScale(1.62, 1.62)
			f65_local7(f65_arg0.plusPip)
			local f65_local8 = function(f74_arg0)
				f65_arg0.ArmorBarWZ:beginAnimation(140)
				f65_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -40, 40)
				f65_arg0.ArmorBarWZ:setTopBottom(0, 0, 82, 90)
				f65_arg0.ArmorBarWZ:registerEventHandler("interrupted_keyframe", f65_arg0.clipInterrupted)
				f65_arg0.ArmorBarWZ:registerEventHandler("transition_complete_keyframe", f65_arg0.clipFinished)
			end
			f65_arg0.ArmorBarWZ:completeAnimation()
			f65_arg0.ArmorBarWZ:setLeftRight(0.5, 0.5, -44, 44)
			f65_arg0.ArmorBarWZ:setTopBottom(0, 0, 85, 94)
			f65_local8(f65_arg0.ArmorBarWZ)
		end,
	},
}
CoD.MultiItemPickupWaypointItemKBM.__onClose = function(f75_arg0)
	f75_arg0.Backing:close()
	f75_arg0.StackCount:close()
	f75_arg0.PickupHintImage:close()
	f75_arg0.pip1:close()
	f75_arg0.pip2:close()
	f75_arg0.pip3:close()
	f75_arg0.pip4:close()
	f75_arg0.plusPip:close()
	f75_arg0.ArmorBarWZ:close()
end
