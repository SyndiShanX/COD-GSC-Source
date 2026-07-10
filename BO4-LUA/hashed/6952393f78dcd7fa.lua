require("x64:e272191e46af824")
CoD.ReservesLootBundleCrateButton = InheritFrom(LUI.UIElement)
CoD.ReservesLootBundleCrateButton.__defaultWidth = 160
CoD.ReservesLootBundleCrateButton.__defaultHeight = 144
CoD.ReservesLootBundleCrateButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesLootBundleCrateButton)
	self.id = "ReservesLootBundleCrateButton"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingPattern = LUI.UIImage.new(0, 0, 0, 160, 0, 0, 5, 139)
	BackingPattern:setImage(RegisterImage(@"hash_1CE66051AE2B8DC3"))
	BackingPattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	BackingPattern:setShaderVector(0, 0.5, 0.5, 0, 0)
	BackingPattern:setShaderVector(1, 1, 1, 0, 0)
	BackingPattern:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(BackingPattern)
	self.BackingPattern = BackingPattern
	local FocusGlow = LUI.UIImage.new(0, 1, -78, 78, 0, 1, -70, 70)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_small"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.24, 0.24)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(160, 160)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local NineSliceBMFrame = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	NineSliceBMFrame:setImage(RegisterImage(@"hash_71AC151A09D526DC"))
	NineSliceBMFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	NineSliceBMFrame:setShaderVector(0, 0, 0, 0, 0)
	NineSliceBMFrame:setupNineSliceShader(120, 52)
	self:addElement(NineSliceBMFrame)
	self.NineSliceBMFrame = NineSliceBMFrame
	local TextBacking = LUI.UIImage.new(0, 1, 2.5, -1.5, 0, 0, 11, 30)
	TextBacking:setRGB(0.89, 0.87, 0.75)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local Title = LUI.UIText.new(0, 0, 7, 157, 0, 0, 12, 30)
	Title:setRGB(0.11, 0.11, 0.11)
	Title:setText(LocalizeToUpperString(@"hash_7B2D098DC87F4F4D"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Title)
	self.Title = Title
	local FocusBorder = LUI.UIImage.new(0, 1, -9, 9, 0, 1, -7, 7)
	FocusBorder:setRGB(1, 0.75, 0.47)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(18, 18)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local bundlesIcon = LUI.UIImage.new(0.5, 0.5, -142, 142, 0.5, 0.5, -64, 88)
	bundlesIcon:setImage(RegisterImage(@"hash_1EA39342F60ED2C9"))
	self:addElement(bundlesIcon)
	self.bundlesIcon = bundlesIcon
	local CaseCount = LUI.UIText.new(0.5, 0.5, -48.5, 48.5, 0.5, 0.5, -7, 27)
	CaseCount:setRGB(0.91, 0.89, 0.89)
	CaseCount:setTTF("ttmussels_demibold")
	CaseCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	CaseCount:setShaderVector(0, 0.1, 0, 0, 0)
	CaseCount:setShaderVector(1, 0, 0, 0, 0)
	CaseCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CaseCount:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	CaseCount:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootBundleCrateCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CaseCount:setText(f2_local0)
		end
	end)
	self:addElement(CaseCount)
	self.CaseCount = CaseCount
	local ItemHintText = CoD.CommonToolTip.new(f1_arg0, f1_arg1, 0.5, 0.5, -86, 86, 1, 1, 0, 45)
	ItemHintText:mergeStateConditions({
		{
			stateName = "Mouse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "CenterAlign",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ItemHintText:setAlpha(0)
	ItemHintText.textCenterAlign:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1E57683BDB81293A"))
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesLootBundleCrateButton.__resetProperties = function(f6_arg0)
	f6_arg0.FocusGlow:completeAnimation()
	f6_arg0.FocusBorder:completeAnimation()
	f6_arg0.ItemHintText:completeAnimation()
	f6_arg0.FocusGlow:setAlpha(0)
	f6_arg0.FocusBorder:setAlpha(0)
	f6_arg0.ItemHintText:setAlpha(0)
end
CoD.ReservesLootBundleCrateButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.FocusGlow:completeAnimation()
			f8_arg0.FocusGlow:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.FocusGlow)
			f8_arg0.FocusBorder:completeAnimation()
			f8_arg0.FocusBorder:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.FocusBorder)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(199)
					f10_arg0:setAlpha(0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.ItemHintText:beginAnimation(5000)
				f8_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.ItemHintText:completeAnimation()
			f8_arg0.ItemHintText:setAlpha(1)
			f8_local0(f8_arg0.ItemHintText)
		end,
		GainFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				f11_arg0.FocusGlow:beginAnimation(200)
				f11_arg0.FocusGlow:setAlpha(1)
				f11_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FocusGlow:completeAnimation()
			f11_arg0.FocusGlow:setAlpha(0)
			f11_local0(f11_arg0.FocusGlow)
			local f11_local1 = function(f13_arg0)
				f11_arg0.FocusBorder:beginAnimation(200)
				f11_arg0.FocusBorder:setAlpha(1)
				f11_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FocusBorder:completeAnimation()
			f11_arg0.FocusBorder:setAlpha(0)
			f11_local1(f11_arg0.FocusBorder)
			local f11_local2 = function(f14_arg0)
				f11_arg0.ItemHintText:beginAnimation(200)
				f11_arg0.ItemHintText:setAlpha(1)
				f11_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.ItemHintText:completeAnimation()
			f11_arg0.ItemHintText:setAlpha(0)
			f11_local2(f11_arg0.ItemHintText)
		end,
		LoseFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.FocusGlow:beginAnimation(100)
				f15_arg0.FocusGlow:setAlpha(0)
				f15_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.FocusGlow:completeAnimation()
			f15_arg0.FocusGlow:setAlpha(1)
			f15_local0(f15_arg0.FocusGlow)
			local f15_local1 = function(f17_arg0)
				f15_arg0.FocusBorder:beginAnimation(100)
				f15_arg0.FocusBorder:setAlpha(0)
				f15_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.FocusBorder:completeAnimation()
			f15_arg0.FocusBorder:setAlpha(1)
			f15_local1(f15_arg0.FocusBorder)
		end,
	},
}
CoD.ReservesLootBundleCrateButton.__onClose = function(f18_arg0)
	f18_arg0.CaseCount:close()
	f18_arg0.ItemHintText:close()
end
