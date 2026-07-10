require("x64:f5e1dce43cc9eb3")
CoD.BountyHunterPackageSingleTier = InheritFrom(LUI.UIElement)
CoD.BountyHunterPackageSingleTier.__defaultWidth = 284
CoD.BountyHunterPackageSingleTier.__defaultHeight = 138
CoD.BountyHunterPackageSingleTier.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterPackageSingleTier)
	self.id = "BountyHunterPackageSingleTier"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponSelectGridItemInternal = CoD.WeaponSelectGridItemInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	WeaponSelectGridItemInternal:mergeStateConditions({
		{
			stateName = "LootNotOwned",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsItemEquippedInCurrentSlot(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "itemIndex", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	WeaponSelectGridItemInternal:linkToElementModel(WeaponSelectGridItemInternal, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(WeaponSelectGridItemInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, "item1.image", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			WeaponSelectGridItemInternal.WeaponImage:setImage(CoD.BaseUtility.AlreadyRegistered(f8_local0))
		end
	end)
	WeaponSelectGridItemInternal:linkToElementModel(self, "item1.displayName", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			WeaponSelectGridItemInternal.WeaponName.WeaponName:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	self:addElement(WeaponSelectGridItemInternal)
	self.WeaponSelectGridItemInternal = WeaponSelectGridItemInternal
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 12, 82, 0, 0, 15, 33)
	NoiseTiledBacking:setRGB(0.48, 0.59, 0.41)
	NoiseTiledBacking:setAlpha(0.75)
	NoiseTiledBacking:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBacking2 = LUI.UIImage.new(0, 0, 12, 14, 0, 0, 15, 33)
	NoiseTiledBacking2:setRGB(0.75, 0.92, 0.59)
	NoiseTiledBacking2:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	local Cost2 = LUI.UIText.new(0, 0, 29, 82, 0.5, 0.5, -54.5, -35.5)
	Cost2:setRGB(0.76, 0.92, 0.59)
	Cost2:setTTF("ttmussels_regular")
	Cost2:setLetterSpacing(2)
	Cost2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Cost2:linkToElementModel(self, "buyCost", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Cost2:setText(f10_local0)
		end
	end)
	self:addElement(Cost2)
	self.Cost2 = Cost2
	local DollarSign2 = LUI.UIText.new(0, 0, 18, 30, 0.5, 0.5, -54.5, -35.5)
	DollarSign2:setRGB(0.76, 0.92, 0.59)
	DollarSign2:setText(CoD.BaseUtility.AlreadyLocalized("$"))
	DollarSign2:setTTF("ttmussels_regular")
	DollarSign2:setLetterSpacing(4)
	DollarSign2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DollarSign2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(DollarSign2)
	self.DollarSign2 = DollarSign2
	self:mergeStateConditions({
		{
			stateName = "CannotAfford",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsTooExpensive(self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "buyCost", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "buyCost",
		})
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["luielement.BountyHunterLoadout.money"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "luielement.BountyHunterLoadout.money",
		})
	end, false)
	WeaponSelectGridItemInternal.id = "WeaponSelectGridItemInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPackageSingleTier.__resetProperties = function(f14_arg0)
	f14_arg0.WeaponSelectGridItemInternal:completeAnimation()
	f14_arg0.NoiseTiledBacking:completeAnimation()
	f14_arg0.NoiseTiledBacking2:completeAnimation()
	f14_arg0.Cost2:completeAnimation()
	f14_arg0.DollarSign2:completeAnimation()
	f14_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
	f14_arg0.NoiseTiledBacking:setLeftRight(0, 0, 12, 82)
	f14_arg0.NoiseTiledBacking:setTopBottom(0, 0, 15, 33)
	f14_arg0.NoiseTiledBacking:setRGB(0.48, 0.59, 0.41)
	f14_arg0.NoiseTiledBacking:setScale(1, 1)
	f14_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 12, 14)
	f14_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 15, 33)
	f14_arg0.NoiseTiledBacking2:setRGB(0.75, 0.92, 0.59)
	f14_arg0.NoiseTiledBacking2:setScale(1, 1)
	f14_arg0.Cost2:setLeftRight(0, 0, 29, 82)
	f14_arg0.Cost2:setTopBottom(0.5, 0.5, -54.5, -35.5)
	f14_arg0.Cost2:setRGB(0.76, 0.92, 0.59)
	f14_arg0.Cost2:setScale(1, 1)
	f14_arg0.DollarSign2:setLeftRight(0, 0, 18, 30)
	f14_arg0.DollarSign2:setTopBottom(0.5, 0.5, -54.5, -35.5)
	f14_arg0.DollarSign2:setRGB(0.76, 0.92, 0.59)
	f14_arg0.DollarSign2:setScale(1, 1)
end
CoD.BountyHunterPackageSingleTier.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(5)
			f16_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f16_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.WeaponSelectGridItemInternal)
			f16_arg0.NoiseTiledBacking:completeAnimation()
			f16_arg0.NoiseTiledBacking:setLeftRight(0, 0, 9, 79)
			f16_arg0.NoiseTiledBacking:setTopBottom(0, 0, 13, 31)
			f16_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.NoiseTiledBacking)
			f16_arg0.NoiseTiledBacking2:completeAnimation()
			f16_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 7, 9)
			f16_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 13, 31)
			f16_arg0.NoiseTiledBacking2:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.NoiseTiledBacking2)
			f16_arg0.Cost2:completeAnimation()
			f16_arg0.Cost2:setLeftRight(0, 0, 26, 79)
			f16_arg0.Cost2:setTopBottom(0.5, 0.5, -56.5, -37.5)
			f16_arg0.Cost2:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.Cost2)
			f16_arg0.DollarSign2:completeAnimation()
			f16_arg0.DollarSign2:setLeftRight(0, 0, 13, 25)
			f16_arg0.DollarSign2:setTopBottom(0.5, 0.5, -56.5, -37.5)
			f16_arg0.DollarSign2:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.DollarSign2)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			local f17_local0 = function(f18_arg0)
				f17_arg0.WeaponSelectGridItemInternal:beginAnimation(200)
				f17_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
				f17_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f17_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
			f17_local0(f17_arg0.WeaponSelectGridItemInternal)
			local f17_local1 = function(f19_arg0)
				f17_arg0.NoiseTiledBacking:beginAnimation(200)
				f17_arg0.NoiseTiledBacking:setLeftRight(0, 0, 9, 79)
				f17_arg0.NoiseTiledBacking:setTopBottom(0, 0, 13, 31)
				f17_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
				f17_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.NoiseTiledBacking:completeAnimation()
			f17_arg0.NoiseTiledBacking:setLeftRight(0, 0, 12, 82)
			f17_arg0.NoiseTiledBacking:setTopBottom(0, 0, 15, 33)
			f17_arg0.NoiseTiledBacking:setScale(1, 1)
			f17_local1(f17_arg0.NoiseTiledBacking)
			local f17_local2 = function(f20_arg0)
				f17_arg0.NoiseTiledBacking2:beginAnimation(200)
				f17_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 7, 9)
				f17_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 13, 31)
				f17_arg0.NoiseTiledBacking2:setScale(1.05, 1.05)
				f17_arg0.NoiseTiledBacking2:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.NoiseTiledBacking2:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.NoiseTiledBacking2:completeAnimation()
			f17_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 12, 14)
			f17_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 15, 33)
			f17_arg0.NoiseTiledBacking2:setScale(1, 1)
			f17_local2(f17_arg0.NoiseTiledBacking2)
			local f17_local3 = function(f21_arg0)
				f17_arg0.Cost2:beginAnimation(200)
				f17_arg0.Cost2:setLeftRight(0, 0, 26, 79)
				f17_arg0.Cost2:setTopBottom(0.5, 0.5, -56.5, -37.5)
				f17_arg0.Cost2:setScale(1.05, 1.05)
				f17_arg0.Cost2:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Cost2:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Cost2:completeAnimation()
			f17_arg0.Cost2:setLeftRight(0, 0, 29, 82)
			f17_arg0.Cost2:setTopBottom(0.5, 0.5, -54.5, -35.5)
			f17_arg0.Cost2:setScale(1, 1)
			f17_local3(f17_arg0.Cost2)
			local f17_local4 = function(f22_arg0)
				f17_arg0.DollarSign2:beginAnimation(200)
				f17_arg0.DollarSign2:setLeftRight(0, 0, 13, 25)
				f17_arg0.DollarSign2:setTopBottom(0.5, 0.5, -56.5, -37.5)
				f17_arg0.DollarSign2:setScale(1.05, 1.05)
				f17_arg0.DollarSign2:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DollarSign2:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.DollarSign2:completeAnimation()
			f17_arg0.DollarSign2:setLeftRight(0, 0, 18, 30)
			f17_arg0.DollarSign2:setTopBottom(0.5, 0.5, -54.5, -35.5)
			f17_arg0.DollarSign2:setScale(1, 1)
			f17_local4(f17_arg0.DollarSign2)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			local f23_local0 = function(f24_arg0)
				f23_arg0.WeaponSelectGridItemInternal:beginAnimation(200)
				f23_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
				f23_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f23_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f23_local0(f23_arg0.WeaponSelectGridItemInternal)
			local f23_local1 = function(f25_arg0)
				f23_arg0.NoiseTiledBacking:beginAnimation(200)
				f23_arg0.NoiseTiledBacking:setLeftRight(0, 0, 12, 82)
				f23_arg0.NoiseTiledBacking:setTopBottom(0, 0, 15, 33)
				f23_arg0.NoiseTiledBacking:setScale(1, 1)
				f23_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.NoiseTiledBacking:completeAnimation()
			f23_arg0.NoiseTiledBacking:setLeftRight(0, 0, 9, 79)
			f23_arg0.NoiseTiledBacking:setTopBottom(0, 0, 13, 31)
			f23_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
			f23_local1(f23_arg0.NoiseTiledBacking)
			local f23_local2 = function(f26_arg0)
				f23_arg0.NoiseTiledBacking2:beginAnimation(200)
				f23_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 12, 14)
				f23_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 15, 33)
				f23_arg0.NoiseTiledBacking2:setScale(1, 1)
				f23_arg0.NoiseTiledBacking2:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.NoiseTiledBacking2:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.NoiseTiledBacking2:completeAnimation()
			f23_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 7, 9)
			f23_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 13, 31)
			f23_arg0.NoiseTiledBacking2:setScale(1.05, 1.05)
			f23_local2(f23_arg0.NoiseTiledBacking2)
			local f23_local3 = function(f27_arg0)
				f23_arg0.Cost2:beginAnimation(200)
				f23_arg0.Cost2:setLeftRight(0, 0, 29, 82)
				f23_arg0.Cost2:setTopBottom(0.5, 0.5, -54.5, -35.5)
				f23_arg0.Cost2:setScale(1, 1)
				f23_arg0.Cost2:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Cost2:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Cost2:completeAnimation()
			f23_arg0.Cost2:setLeftRight(0, 0, 26, 79)
			f23_arg0.Cost2:setTopBottom(0.5, 0.5, -56.5, -37.5)
			f23_arg0.Cost2:setScale(1.05, 1.05)
			f23_local3(f23_arg0.Cost2)
			local f23_local4 = function(f28_arg0)
				f23_arg0.DollarSign2:beginAnimation(200)
				f23_arg0.DollarSign2:setLeftRight(0, 0, 18, 30)
				f23_arg0.DollarSign2:setTopBottom(0.5, 0.5, -54.5, -35.5)
				f23_arg0.DollarSign2:setScale(1, 1)
				f23_arg0.DollarSign2:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.DollarSign2:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.DollarSign2:completeAnimation()
			f23_arg0.DollarSign2:setLeftRight(0, 0, 13, 25)
			f23_arg0.DollarSign2:setTopBottom(0.5, 0.5, -56.5, -37.5)
			f23_arg0.DollarSign2:setScale(1.05, 1.05)
			f23_local4(f23_arg0.DollarSign2)
		end,
	},
	CannotAfford = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(4)
			local f29_local0 = function(f30_arg0)
				f29_arg0.NoiseTiledBacking:beginAnimation(590)
				f29_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.NoiseTiledBacking:completeAnimation()
			f29_arg0.NoiseTiledBacking:setRGB(0.55, 0.22, 0.22)
			f29_local0(f29_arg0.NoiseTiledBacking)
			local f29_local1 = function(f31_arg0)
				f29_arg0.NoiseTiledBacking2:beginAnimation(590)
				f29_arg0.NoiseTiledBacking2:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.NoiseTiledBacking2:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.NoiseTiledBacking2:completeAnimation()
			f29_arg0.NoiseTiledBacking2:setRGB(1, 0.14, 0.14)
			f29_local1(f29_arg0.NoiseTiledBacking2)
			f29_arg0.Cost2:completeAnimation()
			f29_arg0.Cost2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f29_arg0.clipFinished(f29_arg0.Cost2)
			f29_arg0.DollarSign2:completeAnimation()
			f29_arg0.DollarSign2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f29_arg0.clipFinished(f29_arg0.DollarSign2)
		end,
		ChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(5)
			f32_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f32_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f32_arg0.clipFinished(f32_arg0.WeaponSelectGridItemInternal)
			f32_arg0.NoiseTiledBacking:completeAnimation()
			f32_arg0.NoiseTiledBacking:setLeftRight(0, 0, 9, 79)
			f32_arg0.NoiseTiledBacking:setTopBottom(0, 0, 13, 31)
			f32_arg0.NoiseTiledBacking:setRGB(0.55, 0.22, 0.22)
			f32_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
			f32_arg0.clipFinished(f32_arg0.NoiseTiledBacking)
			f32_arg0.NoiseTiledBacking2:completeAnimation()
			f32_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 7, 9)
			f32_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 13, 31)
			f32_arg0.NoiseTiledBacking2:setRGB(1, 0.14, 0.14)
			f32_arg0.NoiseTiledBacking2:setScale(1.05, 1.05)
			f32_arg0.clipFinished(f32_arg0.NoiseTiledBacking2)
			f32_arg0.Cost2:completeAnimation()
			f32_arg0.Cost2:setLeftRight(0, 0, 26, 79)
			f32_arg0.Cost2:setTopBottom(0.5, 0.5, -56.5, -37.5)
			f32_arg0.Cost2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f32_arg0.Cost2:setScale(1.05, 1.05)
			f32_arg0.clipFinished(f32_arg0.Cost2)
			f32_arg0.DollarSign2:completeAnimation()
			f32_arg0.DollarSign2:setLeftRight(0, 0, 13, 25)
			f32_arg0.DollarSign2:setTopBottom(0.5, 0.5, -56.5, -37.5)
			f32_arg0.DollarSign2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f32_arg0.DollarSign2:setScale(1.05, 1.05)
			f32_arg0.clipFinished(f32_arg0.DollarSign2)
		end,
		GainChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(5)
			local f33_local0 = function(f34_arg0)
				f33_arg0.WeaponSelectGridItemInternal:beginAnimation(200)
				f33_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
				f33_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f33_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
			f33_local0(f33_arg0.WeaponSelectGridItemInternal)
			local f33_local1 = function(f35_arg0)
				f33_arg0.NoiseTiledBacking:beginAnimation(200)
				f33_arg0.NoiseTiledBacking:setLeftRight(0, 0, 9, 79)
				f33_arg0.NoiseTiledBacking:setTopBottom(0, 0, 13, 31)
				f33_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
				f33_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.NoiseTiledBacking:completeAnimation()
			f33_arg0.NoiseTiledBacking:setLeftRight(0, 0, 12, 82)
			f33_arg0.NoiseTiledBacking:setTopBottom(0, 0, 15, 33)
			f33_arg0.NoiseTiledBacking:setRGB(0.55, 0.22, 0.22)
			f33_arg0.NoiseTiledBacking:setScale(1, 1)
			f33_local1(f33_arg0.NoiseTiledBacking)
			local f33_local2 = function(f36_arg0)
				f33_arg0.NoiseTiledBacking2:beginAnimation(200)
				f33_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 7, 9)
				f33_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 13, 31)
				f33_arg0.NoiseTiledBacking2:setScale(1.05, 1.05)
				f33_arg0.NoiseTiledBacking2:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.NoiseTiledBacking2:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.NoiseTiledBacking2:completeAnimation()
			f33_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 12, 14)
			f33_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 15, 33)
			f33_arg0.NoiseTiledBacking2:setRGB(1, 0.14, 0.14)
			f33_arg0.NoiseTiledBacking2:setScale(1, 1)
			f33_local2(f33_arg0.NoiseTiledBacking2)
			local f33_local3 = function(f37_arg0)
				f33_arg0.Cost2:beginAnimation(200)
				f33_arg0.Cost2:setLeftRight(0, 0, 26, 79)
				f33_arg0.Cost2:setTopBottom(0.5, 0.5, -56.5, -37.5)
				f33_arg0.Cost2:setScale(1.05, 1.05)
				f33_arg0.Cost2:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Cost2:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.Cost2:completeAnimation()
			f33_arg0.Cost2:setLeftRight(0, 0, 29, 82)
			f33_arg0.Cost2:setTopBottom(0.5, 0.5, -54.5, -35.5)
			f33_arg0.Cost2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f33_arg0.Cost2:setScale(1, 1)
			f33_local3(f33_arg0.Cost2)
			local f33_local4 = function(f38_arg0)
				f33_arg0.DollarSign2:beginAnimation(200)
				f33_arg0.DollarSign2:setLeftRight(0, 0, 13, 25)
				f33_arg0.DollarSign2:setTopBottom(0.5, 0.5, -56.5, -37.5)
				f33_arg0.DollarSign2:setScale(1.05, 1.05)
				f33_arg0.DollarSign2:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.DollarSign2:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.DollarSign2:completeAnimation()
			f33_arg0.DollarSign2:setLeftRight(0, 0, 18, 30)
			f33_arg0.DollarSign2:setTopBottom(0.5, 0.5, -54.5, -35.5)
			f33_arg0.DollarSign2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f33_arg0.DollarSign2:setScale(1, 1)
			f33_local4(f33_arg0.DollarSign2)
		end,
		LoseChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(5)
			local f39_local0 = function(f40_arg0)
				f39_arg0.WeaponSelectGridItemInternal:beginAnimation(200)
				f39_arg0.WeaponSelectGridItemInternal:setScale(1, 1)
				f39_arg0.WeaponSelectGridItemInternal:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.WeaponSelectGridItemInternal:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.WeaponSelectGridItemInternal:completeAnimation()
			f39_arg0.WeaponSelectGridItemInternal:setScale(1.05, 1.05)
			f39_local0(f39_arg0.WeaponSelectGridItemInternal)
			local f39_local1 = function(f41_arg0)
				f39_arg0.NoiseTiledBacking:beginAnimation(200)
				f39_arg0.NoiseTiledBacking:setLeftRight(0, 0, 12, 82)
				f39_arg0.NoiseTiledBacking:setTopBottom(0, 0, 15, 33)
				f39_arg0.NoiseTiledBacking:setScale(1, 1)
				f39_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.NoiseTiledBacking:completeAnimation()
			f39_arg0.NoiseTiledBacking:setLeftRight(0, 0, 9, 79)
			f39_arg0.NoiseTiledBacking:setTopBottom(0, 0, 13, 31)
			f39_arg0.NoiseTiledBacking:setRGB(0.55, 0.22, 0.22)
			f39_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
			f39_local1(f39_arg0.NoiseTiledBacking)
			local f39_local2 = function(f42_arg0)
				f39_arg0.NoiseTiledBacking2:beginAnimation(200)
				f39_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 12, 14)
				f39_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 15, 33)
				f39_arg0.NoiseTiledBacking2:setScale(1, 1)
				f39_arg0.NoiseTiledBacking2:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.NoiseTiledBacking2:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.NoiseTiledBacking2:completeAnimation()
			f39_arg0.NoiseTiledBacking2:setLeftRight(0, 0, 7, 9)
			f39_arg0.NoiseTiledBacking2:setTopBottom(0, 0, 13, 31)
			f39_arg0.NoiseTiledBacking2:setRGB(1, 0.14, 0.14)
			f39_arg0.NoiseTiledBacking2:setScale(1.05, 1.05)
			f39_local2(f39_arg0.NoiseTiledBacking2)
			local f39_local3 = function(f43_arg0)
				f39_arg0.Cost2:beginAnimation(200)
				f39_arg0.Cost2:setLeftRight(0, 0, 29, 82)
				f39_arg0.Cost2:setTopBottom(0.5, 0.5, -54.5, -35.5)
				f39_arg0.Cost2:setScale(1, 1)
				f39_arg0.Cost2:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Cost2:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.Cost2:completeAnimation()
			f39_arg0.Cost2:setLeftRight(0, 0, 26, 79)
			f39_arg0.Cost2:setTopBottom(0.5, 0.5, -56.5, -37.5)
			f39_arg0.Cost2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f39_arg0.Cost2:setScale(1.05, 1.05)
			f39_local3(f39_arg0.Cost2)
			local f39_local4 = function(f44_arg0)
				f39_arg0.DollarSign2:beginAnimation(200)
				f39_arg0.DollarSign2:setLeftRight(0, 0, 18, 30)
				f39_arg0.DollarSign2:setTopBottom(0.5, 0.5, -54.5, -35.5)
				f39_arg0.DollarSign2:setScale(1, 1)
				f39_arg0.DollarSign2:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.DollarSign2:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.DollarSign2:completeAnimation()
			f39_arg0.DollarSign2:setLeftRight(0, 0, 13, 25)
			f39_arg0.DollarSign2:setTopBottom(0.5, 0.5, -56.5, -37.5)
			f39_arg0.DollarSign2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f39_arg0.DollarSign2:setScale(1.05, 1.05)
			f39_local4(f39_arg0.DollarSign2)
		end,
	},
}
CoD.BountyHunterPackageSingleTier.__onClose = function(f45_arg0)
	f45_arg0.WeaponSelectGridItemInternal:close()
	f45_arg0.Cost2:close()
end
