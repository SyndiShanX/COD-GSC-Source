require("x64:e272191e46af824")
CoD.ReservesLootBribeButton = InheritFrom(LUI.UIElement)
CoD.ReservesLootBribeButton.__defaultWidth = 160
CoD.ReservesLootBribeButton.__defaultHeight = 144
CoD.ReservesLootBribeButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesLootBribeButton)
	self.id = "ReservesLootBribeButton"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingPattern = LUI.UIImage.new(0, 0, 0, 160, 0, 0, 5, 139)
	BackingPattern:setImage(RegisterImage(0xCE66051AE2B8DC3))
	BackingPattern:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	BackingPattern:setShaderVector(0, 0.5, 0.5, 0, 0)
	BackingPattern:setShaderVector(1, 1, 1, 0, 0)
	BackingPattern:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(BackingPattern)
	self.BackingPattern = BackingPattern
	local FocusGlow = LUI.UIImage.new(0, 1, -78, 78, 0, 1, -70, 70)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(0xB8F10D49D85E9C4))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlow:setShaderVector(0, 0, 0, 0.24, 0.24)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(160, 160)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local NineSliceBMFrame = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	NineSliceBMFrame:setImage(RegisterImage(0x1AC151A09D526DC))
	NineSliceBMFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NineSliceBMFrame:setShaderVector(0, 0, 0, 0, 0)
	NineSliceBMFrame:setupNineSliceShader(162, 52)
	self:addElement(NineSliceBMFrame)
	self.NineSliceBMFrame = NineSliceBMFrame
	local TextBacking = LUI.UIImage.new(0, 1, 2.5, -1.5, 0, 0, 11, 30)
	TextBacking:setRGB(0.89, 0.87, 0.75)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local Title = LUI.UIText.new(0, 0, 7, 159, 0, 0, 12, 30)
	Title:setRGB(0.11, 0.11, 0.11)
	Title:setText(LocalizeToUpperString(0xABC9E44852AC644))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Title)
	self.Title = Title
	local FocusBorder = LUI.UIImage.new(0, 1, -9, 9, 0, 1, -7, 7)
	FocusBorder:setRGB(1, 0.75, 0.47)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(18, 18)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local BribeIcon = LUI.UIImage.new(0.5, 0.5, -142, 142, 0.5, 0.5, -64, 88)
	BribeIcon:setImage(RegisterImage(0x528E1773F2922D1))
	self:addElement(BribeIcon)
	self.BribeIcon = BribeIcon
	local BribeCount = LUI.UIText.new(0.5, 0.5, -48.5, 48.5, 0.5, 0.5, -7, 27)
	BribeCount:setRGB(0.91, 0.89, 0.89)
	BribeCount:setTTF("ttmussels_demibold")
	BribeCount:setMaterial(LUI.UIImage.GetCachedMaterial(0x6250C6FCAC36BD4))
	BribeCount:setShaderVector(0, 0.1, 0, 0, 0)
	BribeCount:setShaderVector(1, 0, 0, 0, 0)
	BribeCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	BribeCount:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	BribeCount:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootBribeCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BribeCount:setText(f2_local0)
		end
	end)
	self:addElement(BribeCount)
	self.BribeCount = BribeCount
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
	ItemHintText.textCenterAlign:setText("")
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesLootBribeButton.__resetProperties = function(f6_arg0)
	f6_arg0.FocusGlow:completeAnimation()
	f6_arg0.FocusBorder:completeAnimation()
	f6_arg0.ItemHintText:completeAnimation()
	f6_arg0.FocusGlow:setAlpha(0)
	f6_arg0.FocusBorder:setAlpha(0)
	f6_arg0.ItemHintText:setAlpha(0)
end
CoD.ReservesLootBribeButton.__clipsPerState = {
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
CoD.ReservesLootBribeButton.__onClose = function(f18_arg0)
	f18_arg0.BribeCount:close()
	f18_arg0.ItemHintText:close()
end
