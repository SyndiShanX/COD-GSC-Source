require("x64:76fa323de4745ba")
require("x64:a6c788fd067cb9")
CoD.PC_EquippedBGB = InheritFrom(LUI.UIElement)
CoD.PC_EquippedBGB.__defaultWidth = 110
CoD.PC_EquippedBGB.__defaultHeight = 110
CoD.PC_EquippedBGB.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_EquippedBGB)
	self.id = "PC_EquippedBGB"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DiamondBacking2 = LUI.UIImage.new(-0.26, 1.26, 0, 0, -0.26, 1.26, 0, 0)
	DiamondBacking2:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	DiamondBacking2:setAlpha(0.5)
	DiamondBacking2:setZRot(45)
	DiamondBacking2:setImage(RegisterImage(0xB548E386E78802E))
	self:addElement(DiamondBacking2)
	self.DiamondBacking2 = DiamondBacking2
	local Selected = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Selected:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Selected:setAlpha(0)
	Selected:setZRot(90)
	self:addElement(Selected)
	self.Selected = Selected
	local EmptyHighlight2 = LUI.UIImage.new(-0.28, 1.28, 0, 0, -0.28, 1.28, 0, 0)
	EmptyHighlight2:setAlpha(0)
	EmptyHighlight2:setImage(RegisterImage(0xFA49018B8B7B52D))
	self:addElement(EmptyHighlight2)
	self.EmptyHighlight2 = EmptyHighlight2
	local Dots2 = LUI.UIImage.new(-0.28, 1.28, 0, 0, -0.28, 1.28, 0, 0)
	Dots2:setRGB(0.49, 0.09, 0.09)
	Dots2:setZRot(45)
	Dots2:setImage(RegisterImage(0x233E2450B088E37))
	self:addElement(Dots2)
	self.Dots2 = Dots2
	local ElixirImage = LUI.UIImage.new(0.15, 0.85, 0, 0, 0.15, 0.85, 0, 0)
	ElixirImage:setScale(1.2, 1.2)
	ElixirImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ElixirImage:setImage(CoD.BaseUtility.AlreadyRegistered(f2_local0))
		end
	end)
	self:addElement(ElixirImage)
	self.ElixirImage = ElixirImage
	local BGBCount = CoD.EquippedBGBCount.new(f1_arg0, f1_arg1, 0.5, 1.1, -7, -7, 0.77, 0.99, 0, 0)
	BGBCount:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsCACItemConsumable(menu, element, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE])
			end,
		},
	})
	BGBCount:linkToElementModel(BGBCount, "itemIndex", true, function(model)
		f1_arg0:updateElementState(BGBCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	BGBCount:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BGBCount:linkToElementModel(self, nil, false, function(model)
		BGBCount:setModel(model, f1_arg1)
	end)
	BGBCount:linkToElementModel(self, "itemIndex", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			BGBCount.Count:setText(CoD.CACUtility.GetConsumableCountFromIndex(f1_arg1, f1_arg0, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], f6_local0))
		end
	end)
	self:addElement(BGBCount)
	self.BGBCount = BGBCount
	local PCkeybind = LUI.UIText.new(0.01, 0.99, 0, 0, 0, 0.2, 0, 0)
	PCkeybind:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	PCkeybind:setTTF("notosans_regular")
	PCkeybind:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PCkeybind:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PCkeybind)
	self.PCkeybind = PCkeybind
	local RestrictionIcon = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -29, 21)
	RestrictionIcon:linkToElementModel(self, nil, false, function(model)
		RestrictionIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictionIcon)
	self.RestrictionIcon = RestrictionIcon
	self:mergeStateConditions({
		{
			stateName = "ZeroInventorySelected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "BGBLoadout", "selectedIndex", "slotIndex")
			end,
		},
		{
			stateName = "ZeroInventory",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = DataSources.BGBLoadout.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.selectedIndex, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	self:linkToElementModel(self, "slotIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slotIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_EquippedBGB.__resetProperties = function(f13_arg0)
	f13_arg0.DiamondBacking2:completeAnimation()
	f13_arg0.BGBCount:completeAnimation()
	f13_arg0.ElixirImage:completeAnimation()
	f13_arg0.PCkeybind:completeAnimation()
	f13_arg0.Selected:completeAnimation()
	f13_arg0.DiamondBacking2:setAlpha(0.5)
	f13_arg0.DiamondBacking2:setScale(1, 1)
	f13_arg0.BGBCount:setScale(1, 1)
	f13_arg0.ElixirImage:setScale(1.2, 1.2)
	f13_arg0.PCkeybind:setLeftRight(0.01, 0.99, 0, 0)
	f13_arg0.PCkeybind:setScale(1, 1)
	f13_arg0.Selected:setAlpha(0)
end
CoD.PC_EquippedBGB.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.DiamondBacking2:completeAnimation()
			f15_arg0.DiamondBacking2:setAlpha(1)
			f15_arg0.DiamondBacking2:setScale(1.04, 1.04)
			f15_arg0.clipFinished(f15_arg0.DiamondBacking2)
			f15_arg0.ElixirImage:completeAnimation()
			f15_arg0.ElixirImage:setScale(1.24, 1.24)
			f15_arg0.clipFinished(f15_arg0.ElixirImage)
			f15_arg0.BGBCount:completeAnimation()
			f15_arg0.BGBCount:setScale(1.04, 1.04)
			f15_arg0.clipFinished(f15_arg0.BGBCount)
			f15_arg0.PCkeybind:completeAnimation()
			f15_arg0.PCkeybind:setScale(1.04, 1.04)
			f15_arg0.clipFinished(f15_arg0.PCkeybind)
		end,
		GainFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				f16_arg0.DiamondBacking2:beginAnimation(200)
				f16_arg0.DiamondBacking2:setAlpha(1)
				f16_arg0.DiamondBacking2:setScale(1.04, 1.04)
				f16_arg0.DiamondBacking2:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.DiamondBacking2:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.DiamondBacking2:completeAnimation()
			f16_arg0.DiamondBacking2:setAlpha(0.5)
			f16_arg0.DiamondBacking2:setScale(1, 1)
			f16_local0(f16_arg0.DiamondBacking2)
			local f16_local1 = function(f18_arg0)
				f16_arg0.ElixirImage:beginAnimation(200)
				f16_arg0.ElixirImage:setScale(1.24, 1.24)
				f16_arg0.ElixirImage:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ElixirImage:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.ElixirImage:completeAnimation()
			f16_arg0.ElixirImage:setScale(1.2, 1.2)
			f16_local1(f16_arg0.ElixirImage)
			local f16_local2 = function(f19_arg0)
				f16_arg0.BGBCount:beginAnimation(200)
				f16_arg0.BGBCount:setScale(1.04, 1.04)
				f16_arg0.BGBCount:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.BGBCount:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.BGBCount:completeAnimation()
			f16_arg0.BGBCount:setScale(1, 1)
			f16_local2(f16_arg0.BGBCount)
			local f16_local3 = function(f20_arg0)
				f16_arg0.PCkeybind:beginAnimation(200)
				f16_arg0.PCkeybind:setScale(1.04, 1.04)
				f16_arg0.PCkeybind:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.PCkeybind:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.PCkeybind:completeAnimation()
			f16_arg0.PCkeybind:setScale(1, 1)
			f16_local3(f16_arg0.PCkeybind)
		end,
		LoseFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			local f21_local0 = function(f22_arg0)
				f21_arg0.DiamondBacking2:beginAnimation(200)
				f21_arg0.DiamondBacking2:setAlpha(0.5)
				f21_arg0.DiamondBacking2:setScale(1, 1)
				f21_arg0.DiamondBacking2:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.DiamondBacking2:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.DiamondBacking2:completeAnimation()
			f21_arg0.DiamondBacking2:setAlpha(1)
			f21_arg0.DiamondBacking2:setScale(1.04, 1.04)
			f21_local0(f21_arg0.DiamondBacking2)
			local f21_local1 = function(f23_arg0)
				f21_arg0.ElixirImage:beginAnimation(200)
				f21_arg0.ElixirImage:setScale(1.2, 1.2)
				f21_arg0.ElixirImage:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ElixirImage:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.ElixirImage:completeAnimation()
			f21_arg0.ElixirImage:setScale(1.24, 1.24)
			f21_local1(f21_arg0.ElixirImage)
			local f21_local2 = function(f24_arg0)
				f21_arg0.BGBCount:beginAnimation(200)
				f21_arg0.BGBCount:setScale(1, 1)
				f21_arg0.BGBCount:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.BGBCount:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.BGBCount:completeAnimation()
			f21_arg0.BGBCount:setScale(1.04, 1.04)
			f21_local2(f21_arg0.BGBCount)
			local f21_local3 = function(f25_arg0)
				f21_arg0.PCkeybind:beginAnimation(200)
				f21_arg0.PCkeybind:setScale(1, 1)
				f21_arg0.PCkeybind:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.PCkeybind:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.PCkeybind:completeAnimation()
			f21_arg0.PCkeybind:setScale(1.04, 1.04)
			f21_local3(f21_arg0.PCkeybind)
		end,
	},
	ZeroInventorySelected = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	Selected = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.Selected:completeAnimation()
			f27_arg0.Selected:setAlpha(0.05)
			f27_arg0.clipFinished(f27_arg0.Selected)
			f27_arg0.PCkeybind:completeAnimation()
			f27_arg0.PCkeybind:setLeftRight(0, 1, 1, 1)
			f27_arg0.clipFinished(f27_arg0.PCkeybind)
		end,
		Focus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.DiamondBacking2:completeAnimation()
			f28_arg0.DiamondBacking2:setAlpha(1)
			f28_arg0.DiamondBacking2:setScale(1.04, 1.04)
			f28_arg0.clipFinished(f28_arg0.DiamondBacking2)
			f28_arg0.Selected:completeAnimation()
			f28_arg0.Selected:setAlpha(0.05)
			f28_arg0.clipFinished(f28_arg0.Selected)
			f28_arg0.ElixirImage:completeAnimation()
			f28_arg0.ElixirImage:setScale(1.24, 1.24)
			f28_arg0.clipFinished(f28_arg0.ElixirImage)
			f28_arg0.BGBCount:completeAnimation()
			f28_arg0.BGBCount:setScale(1.04, 1.04)
			f28_arg0.clipFinished(f28_arg0.BGBCount)
			f28_arg0.PCkeybind:completeAnimation()
			f28_arg0.PCkeybind:setScale(1.04, 1.04)
			f28_arg0.clipFinished(f28_arg0.PCkeybind)
		end,
		GainFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(5)
			local f29_local0 = function(f30_arg0)
				f29_arg0.DiamondBacking2:beginAnimation(200)
				f29_arg0.DiamondBacking2:setAlpha(1)
				f29_arg0.DiamondBacking2:setScale(1.04, 1.04)
				f29_arg0.DiamondBacking2:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DiamondBacking2:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DiamondBacking2:completeAnimation()
			f29_arg0.DiamondBacking2:setAlpha(0.5)
			f29_arg0.DiamondBacking2:setScale(1, 1)
			f29_local0(f29_arg0.DiamondBacking2)
			f29_arg0.Selected:completeAnimation()
			f29_arg0.Selected:setAlpha(0.05)
			f29_arg0.clipFinished(f29_arg0.Selected)
			local f29_local1 = function(f31_arg0)
				f29_arg0.ElixirImage:beginAnimation(200)
				f29_arg0.ElixirImage:setScale(1.24, 1.24)
				f29_arg0.ElixirImage:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ElixirImage:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.ElixirImage:completeAnimation()
			f29_arg0.ElixirImage:setScale(1.2, 1.2)
			f29_local1(f29_arg0.ElixirImage)
			local f29_local2 = function(f32_arg0)
				f29_arg0.BGBCount:beginAnimation(200)
				f29_arg0.BGBCount:setScale(1.04, 1.04)
				f29_arg0.BGBCount:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.BGBCount:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.BGBCount:completeAnimation()
			f29_arg0.BGBCount:setScale(1, 1)
			f29_local2(f29_arg0.BGBCount)
			local f29_local3 = function(f33_arg0)
				f29_arg0.PCkeybind:beginAnimation(200)
				f29_arg0.PCkeybind:setScale(1.04, 1.04)
				f29_arg0.PCkeybind:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.PCkeybind:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.PCkeybind:completeAnimation()
			f29_arg0.PCkeybind:setScale(1, 1)
			f29_local3(f29_arg0.PCkeybind)
		end,
		LoseFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(5)
			local f34_local0 = function(f35_arg0)
				f34_arg0.DiamondBacking2:beginAnimation(200)
				f34_arg0.DiamondBacking2:setAlpha(0.5)
				f34_arg0.DiamondBacking2:setScale(1, 1)
				f34_arg0.DiamondBacking2:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.DiamondBacking2:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.DiamondBacking2:completeAnimation()
			f34_arg0.DiamondBacking2:setAlpha(1)
			f34_arg0.DiamondBacking2:setScale(1.04, 1.04)
			f34_local0(f34_arg0.DiamondBacking2)
			f34_arg0.Selected:completeAnimation()
			f34_arg0.Selected:setAlpha(0.05)
			f34_arg0.clipFinished(f34_arg0.Selected)
			local f34_local1 = function(f36_arg0)
				f34_arg0.ElixirImage:beginAnimation(200)
				f34_arg0.ElixirImage:setScale(1.2, 1.2)
				f34_arg0.ElixirImage:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.ElixirImage:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.ElixirImage:completeAnimation()
			f34_arg0.ElixirImage:setScale(1.24, 1.24)
			f34_local1(f34_arg0.ElixirImage)
			local f34_local2 = function(f37_arg0)
				f34_arg0.BGBCount:beginAnimation(200)
				f34_arg0.BGBCount:setScale(1, 1)
				f34_arg0.BGBCount:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.BGBCount:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.BGBCount:completeAnimation()
			f34_arg0.BGBCount:setScale(1.04, 1.04)
			f34_local2(f34_arg0.BGBCount)
			local f34_local3 = function(f38_arg0)
				f34_arg0.PCkeybind:beginAnimation(200)
				f34_arg0.PCkeybind:setScale(1, 1)
				f34_arg0.PCkeybind:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.PCkeybind:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.PCkeybind:completeAnimation()
			f34_arg0.PCkeybind:setScale(1.04, 1.04)
			f34_local3(f34_arg0.PCkeybind)
		end,
	},
	ZeroInventory = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.PC_EquippedBGB.__onClose = function(f40_arg0)
	f40_arg0.ElixirImage:close()
	f40_arg0.BGBCount:close()
	f40_arg0.RestrictionIcon:close()
end
