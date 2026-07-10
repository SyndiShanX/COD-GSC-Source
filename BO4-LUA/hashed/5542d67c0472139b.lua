require("x64:76fa323de4745ba")
require("x64:5f8cf56752aa71b")
require("x64:a6c788fd067cb9")
CoD.EquippedBGBInternal = InheritFrom(LUI.UIElement)
CoD.EquippedBGBInternal.__defaultWidth = 204
CoD.EquippedBGBInternal.__defaultHeight = 204
CoD.EquippedBGBInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EquippedBGBInternal)
	self.id = "EquippedBGBInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Selected = LUI.UIImage.new(0, 0, 35, 170, 0, 0, 34.5, 169.5)
	Selected:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Selected:setAlpha(0.05)
	Selected:setZRot(45)
	self:addElement(Selected)
	self.Selected = Selected
	local DiamondBacking = LUI.UIImage.new(0.5, 0.5, -102, 102, 0.5, 0.5, -102, 102)
	DiamondBacking:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	DiamondBacking:setAlpha(0.5)
	DiamondBacking:setImage(RegisterImage(0xB548E386E78802E))
	self:addElement(DiamondBacking)
	self.DiamondBacking = DiamondBacking
	local EmptyHighlight = LUI.UIImage.new(0.5, 0.5, -102, 102, 0.5, 0.5, -102, 102)
	EmptyHighlight:setAlpha(0)
	EmptyHighlight:setImage(RegisterImage(0xFA49018B8B7B52D))
	self:addElement(EmptyHighlight)
	self.EmptyHighlight = EmptyHighlight
	local Dots = LUI.UIImage.new(0.5, 0.5, -102, 102, 0.5, 0.5, -102, 102)
	Dots:setRGB(0.49, 0.09, 0.09)
	Dots:setImage(RegisterImage(0x233E2450B088E37))
	self:addElement(Dots)
	self.Dots = Dots
	local ElixirImage = LUI.UIImage.new(0.5, 0.5, -45, 45, 0.5, 0.5, -45, 45)
	ElixirImage:setScale(1.2, 1.2)
	ElixirImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ElixirImage:setImage(CoD.BaseUtility.AlreadyRegistered(f2_local0))
		end
	end)
	self:addElement(ElixirImage)
	self.ElixirImage = ElixirImage
	local ElixirCount = CoD.EquippedBGBCount.new(f1_arg0, f1_arg1, 0, 0, 92, 170, 0, 0, 114, 142)
	ElixirCount:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsCACItemConsumable(menu, element, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE])
			end,
		},
	})
	ElixirCount:linkToElementModel(ElixirCount, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ElixirCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	ElixirCount:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ElixirCount:linkToElementModel(self, nil, false, function(model)
		ElixirCount:setModel(model, f1_arg1)
	end)
	ElixirCount:linkToElementModel(self, "itemIndex", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ElixirCount.Count:setText(CoD.CACUtility.GetConsumableCountFromIndex(f1_arg1, f1_arg0, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], f6_local0))
		end
	end)
	self:addElement(ElixirCount)
	self.ElixirCount = ElixirCount
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 35.5, -34.5, 0, 1, 35.5, -36.5)
	CommonButtonOutline:setZRot(45)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
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
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EquippedBGBInternal.__resetProperties = function(f13_arg0)
	f13_arg0.Dots:completeAnimation()
	f13_arg0.Selected:completeAnimation()
	f13_arg0.DiamondBacking:completeAnimation()
	f13_arg0.EmptyHighlight:completeAnimation()
	f13_arg0.ElixirCount:completeAnimation()
	f13_arg0.Dots:setRGB(0.49, 0.09, 0.09)
	f13_arg0.Dots:setAlpha(1)
	f13_arg0.Selected:setAlpha(0.05)
	f13_arg0.DiamondBacking:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	f13_arg0.DiamondBacking:setAlpha(0.5)
	f13_arg0.EmptyHighlight:setAlpha(0)
	f13_arg0.ElixirCount:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
end
CoD.EquippedBGBInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.Selected:completeAnimation()
			f14_arg0.Selected:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Selected)
			f14_arg0.Dots:completeAnimation()
			f14_arg0.Dots:setAlpha(0.3)
			f14_arg0.clipFinished(f14_arg0.Dots)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			local f15_local0 = function(f16_arg0)
				f15_arg0.Selected:beginAnimation(200)
				f15_arg0.Selected:setAlpha(0)
				f15_arg0.Selected:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Selected:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Selected:completeAnimation()
			f15_arg0.Selected:setAlpha(0.05)
			f15_local0(f15_arg0.Selected)
			local f15_local1 = function(f17_arg0)
				f15_arg0.DiamondBacking:beginAnimation(200)
				f15_arg0.DiamondBacking:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
				f15_arg0.DiamondBacking:setAlpha(0.5)
				f15_arg0.DiamondBacking:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.DiamondBacking:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.DiamondBacking:completeAnimation()
			f15_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f15_arg0.DiamondBacking:setAlpha(0.8)
			f15_local1(f15_arg0.DiamondBacking)
			local f15_local2 = function(f18_arg0)
				f15_arg0.Dots:beginAnimation(200)
				f15_arg0.Dots:setRGB(0.49, 0.09, 0.09)
				f15_arg0.Dots:setAlpha(0.3)
				f15_arg0.Dots:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Dots:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Dots:completeAnimation()
			f15_arg0.Dots:setRGB(1, 0, 0)
			f15_arg0.Dots:setAlpha(1)
			f15_local2(f15_arg0.Dots)
		end,
		ChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.DiamondBacking:completeAnimation()
			f19_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f19_arg0.DiamondBacking:setAlpha(0.8)
			f19_arg0.clipFinished(f19_arg0.DiamondBacking)
			f19_arg0.Dots:completeAnimation()
			f19_arg0.Dots:setRGB(1, 0, 0)
			f19_arg0.Dots:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Dots)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			local f20_local0 = function(f21_arg0)
				f20_arg0.Selected:beginAnimation(200)
				f20_arg0.Selected:setAlpha(0.05)
				f20_arg0.Selected:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Selected:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Selected:completeAnimation()
			f20_arg0.Selected:setAlpha(0)
			f20_local0(f20_arg0.Selected)
			local f20_local1 = function(f22_arg0)
				f20_arg0.DiamondBacking:beginAnimation(200)
				f20_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f20_arg0.DiamondBacking:setAlpha(0.8)
				f20_arg0.DiamondBacking:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.DiamondBacking:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.DiamondBacking:completeAnimation()
			f20_arg0.DiamondBacking:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
			f20_arg0.DiamondBacking:setAlpha(0.5)
			f20_local1(f20_arg0.DiamondBacking)
			local f20_local2 = function(f23_arg0)
				f20_arg0.Dots:beginAnimation(200)
				f20_arg0.Dots:setRGB(1, 0, 0)
				f20_arg0.Dots:setAlpha(1)
				f20_arg0.Dots:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Dots:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Dots:completeAnimation()
			f20_arg0.Dots:setRGB(0.49, 0.09, 0.09)
			f20_arg0.Dots:setAlpha(0.3)
			f20_local2(f20_arg0.Dots)
		end,
	},
	ZeroInventorySelected = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.Selected:completeAnimation()
			f24_arg0.Selected:setAlpha(0.05)
			f24_arg0.clipFinished(f24_arg0.Selected)
			f24_arg0.DiamondBacking:completeAnimation()
			f24_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f24_arg0.DiamondBacking:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.DiamondBacking)
			f24_arg0.EmptyHighlight:completeAnimation()
			f24_arg0.EmptyHighlight:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.EmptyHighlight)
			f24_arg0.ElixirCount:completeAnimation()
			f24_arg0.ElixirCount:setRGB(1, 0, 0)
			f24_arg0.clipFinished(f24_arg0.ElixirCount)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			f25_arg0.Selected:completeAnimation()
			f25_arg0.Selected:setAlpha(0.05)
			f25_arg0.clipFinished(f25_arg0.Selected)
			f25_arg0.DiamondBacking:completeAnimation()
			f25_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f25_arg0.DiamondBacking:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.DiamondBacking)
			f25_arg0.EmptyHighlight:completeAnimation()
			f25_arg0.EmptyHighlight:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.EmptyHighlight)
			f25_arg0.ElixirCount:completeAnimation()
			f25_arg0.ElixirCount:setRGB(1, 0, 0)
			f25_arg0.clipFinished(f25_arg0.ElixirCount)
		end,
		GainChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			f26_arg0.Selected:completeAnimation()
			f26_arg0.Selected:setAlpha(0.05)
			f26_arg0.clipFinished(f26_arg0.Selected)
			f26_arg0.DiamondBacking:completeAnimation()
			f26_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f26_arg0.DiamondBacking:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.DiamondBacking)
			f26_arg0.EmptyHighlight:completeAnimation()
			f26_arg0.EmptyHighlight:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.EmptyHighlight)
			f26_arg0.ElixirCount:completeAnimation()
			f26_arg0.ElixirCount:setRGB(1, 0, 0)
			f26_arg0.clipFinished(f26_arg0.ElixirCount)
		end,
		LoseChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			f27_arg0.Selected:completeAnimation()
			f27_arg0.Selected:setAlpha(0.05)
			f27_arg0.clipFinished(f27_arg0.Selected)
			f27_arg0.DiamondBacking:completeAnimation()
			f27_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f27_arg0.DiamondBacking:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.DiamondBacking)
			f27_arg0.EmptyHighlight:completeAnimation()
			f27_arg0.EmptyHighlight:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.EmptyHighlight)
			f27_arg0.ElixirCount:completeAnimation()
			f27_arg0.ElixirCount:setRGB(1, 0, 0)
			f27_arg0.clipFinished(f27_arg0.ElixirCount)
		end,
	},
	Selected = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.Selected:completeAnimation()
			f28_arg0.Selected:setAlpha(0.05)
			f28_arg0.clipFinished(f28_arg0.Selected)
			f28_arg0.DiamondBacking:completeAnimation()
			f28_arg0.DiamondBacking:setRGB(0.66, 0.63, 0.52)
			f28_arg0.clipFinished(f28_arg0.DiamondBacking)
		end,
		ChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.Selected:completeAnimation()
			f29_arg0.Selected:setAlpha(0.05)
			f29_arg0.clipFinished(f29_arg0.Selected)
			f29_arg0.DiamondBacking:completeAnimation()
			f29_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f29_arg0.DiamondBacking:setAlpha(0.8)
			f29_arg0.clipFinished(f29_arg0.DiamondBacking)
			f29_arg0.Dots:completeAnimation()
			f29_arg0.Dots:setRGB(1, 0, 0)
			f29_arg0.clipFinished(f29_arg0.Dots)
		end,
		GainChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.Selected:completeAnimation()
			f30_arg0.Selected:setAlpha(0.05)
			f30_arg0.clipFinished(f30_arg0.Selected)
			local f30_local0 = function(f31_arg0)
				f30_arg0.DiamondBacking:beginAnimation(200)
				f30_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f30_arg0.DiamondBacking:setAlpha(0.8)
				f30_arg0.DiamondBacking:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.DiamondBacking:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.DiamondBacking:completeAnimation()
			f30_arg0.DiamondBacking:setRGB(0.66, 0.63, 0.52)
			f30_arg0.DiamondBacking:setAlpha(0.5)
			f30_local0(f30_arg0.DiamondBacking)
			local f30_local1 = function(f32_arg0)
				f30_arg0.Dots:beginAnimation(200)
				f30_arg0.Dots:setRGB(1, 0, 0)
				f30_arg0.Dots:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.Dots:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.Dots:completeAnimation()
			f30_arg0.Dots:setRGB(0.49, 0.09, 0.09)
			f30_local1(f30_arg0.Dots)
		end,
		LoseChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
			f33_arg0.Selected:completeAnimation()
			f33_arg0.Selected:setAlpha(0.05)
			f33_arg0.clipFinished(f33_arg0.Selected)
			local f33_local0 = function(f34_arg0)
				f33_arg0.DiamondBacking:beginAnimation(200)
				f33_arg0.DiamondBacking:setRGB(0.66, 0.63, 0.52)
				f33_arg0.DiamondBacking:setAlpha(0.5)
				f33_arg0.DiamondBacking:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.DiamondBacking:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.DiamondBacking:completeAnimation()
			f33_arg0.DiamondBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f33_arg0.DiamondBacking:setAlpha(0.8)
			f33_local0(f33_arg0.DiamondBacking)
			local f33_local1 = function(f35_arg0)
				f33_arg0.Dots:beginAnimation(200)
				f33_arg0.Dots:setRGB(0.49, 0.09, 0.09)
				f33_arg0.Dots:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Dots:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.Dots:completeAnimation()
			f33_arg0.Dots:setRGB(1, 0, 0)
			f33_local1(f33_arg0.Dots)
		end,
	},
	ZeroInventory = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(3)
			f36_arg0.DiamondBacking:completeAnimation()
			f36_arg0.DiamondBacking:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
			f36_arg0.clipFinished(f36_arg0.DiamondBacking)
			f36_arg0.EmptyHighlight:completeAnimation()
			f36_arg0.EmptyHighlight:setAlpha(0.6)
			f36_arg0.clipFinished(f36_arg0.EmptyHighlight)
			f36_arg0.ElixirCount:completeAnimation()
			f36_arg0.ElixirCount:setRGB(1, 0, 0)
			f36_arg0.clipFinished(f36_arg0.ElixirCount)
		end,
		ChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			f37_arg0.DiamondBacking:completeAnimation()
			f37_arg0.DiamondBacking:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
			f37_arg0.clipFinished(f37_arg0.DiamondBacking)
			f37_arg0.EmptyHighlight:completeAnimation()
			f37_arg0.EmptyHighlight:setAlpha(0.6)
			f37_arg0.clipFinished(f37_arg0.EmptyHighlight)
			f37_arg0.ElixirCount:completeAnimation()
			f37_arg0.ElixirCount:setRGB(1, 0, 0)
			f37_arg0.clipFinished(f37_arg0.ElixirCount)
		end,
		GainChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(3)
			f38_arg0.DiamondBacking:completeAnimation()
			f38_arg0.DiamondBacking:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
			f38_arg0.clipFinished(f38_arg0.DiamondBacking)
			f38_arg0.EmptyHighlight:completeAnimation()
			f38_arg0.EmptyHighlight:setAlpha(0.6)
			f38_arg0.clipFinished(f38_arg0.EmptyHighlight)
			f38_arg0.ElixirCount:completeAnimation()
			f38_arg0.ElixirCount:setRGB(1, 0, 0)
			f38_arg0.clipFinished(f38_arg0.ElixirCount)
		end,
		LoseChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(3)
			f39_arg0.DiamondBacking:completeAnimation()
			f39_arg0.DiamondBacking:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
			f39_arg0.clipFinished(f39_arg0.DiamondBacking)
			f39_arg0.EmptyHighlight:completeAnimation()
			f39_arg0.EmptyHighlight:setAlpha(0.6)
			f39_arg0.clipFinished(f39_arg0.EmptyHighlight)
			f39_arg0.ElixirCount:completeAnimation()
			f39_arg0.ElixirCount:setRGB(1, 0, 0)
			f39_arg0.clipFinished(f39_arg0.ElixirCount)
		end,
	},
}
CoD.EquippedBGBInternal.__onClose = function(f40_arg0)
	f40_arg0.ElixirImage:close()
	f40_arg0.ElixirCount:close()
	f40_arg0.CommonButtonOutline:close()
	f40_arg0.RestrictionIcon:close()
end
