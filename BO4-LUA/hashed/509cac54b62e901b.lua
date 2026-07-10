require("x64:c96de52191fe142")
require("x64:e272191e46af824")
CoD.ReservesLootCaseButton = InheritFrom(LUI.UIElement)
CoD.ReservesLootCaseButton.__defaultWidth = 160
CoD.ReservesLootCaseButton.__defaultHeight = 144
CoD.ReservesLootCaseButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesLootCaseButton)
	self.id = "ReservesLootCaseButton"
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
	Title:setText(LocalizeToUpperString(0xC61EEBB551BECCD))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Title)
	self.Title = Title
	local LootCaseMeter = CoD.AARTierRewardLootCaseMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0, 0, 9.5, 159.5)
	LootCaseMeter:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LootCaseMeter:setScale(0.6, 0.6)
	LootCaseMeter.PreviousProgressRing:setShaderVector(0, 0, 0, 0, 0)
	LootCaseMeter:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "caseProgress", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LootCaseMeter.CurrentProgressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	LootCaseMeter:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootCaseCount", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			LootCaseMeter.CaseCount:setText(f4_local0)
		end
	end)
	self:addElement(LootCaseMeter)
	self.LootCaseMeter = LootCaseMeter
	local FocusBorder = LUI.UIImage.new(0, 1, -9, 9, 0, 1, -7, 7)
	FocusBorder:setRGB(1, 0.75, 0.47)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(18, 18)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
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
	ItemHintText.textCenterAlign:setText(Engine[0xF9F1239CFD921FE](0xA5115BE25660ABA))
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesLootCaseButton.__resetProperties = function(f8_arg0)
	f8_arg0.FocusGlow:completeAnimation()
	f8_arg0.FocusBorder:completeAnimation()
	f8_arg0.ItemHintText:completeAnimation()
	f8_arg0.FocusGlow:setAlpha(0)
	f8_arg0.FocusBorder:setAlpha(0)
	f8_arg0.ItemHintText:setAlpha(0)
end
CoD.ReservesLootCaseButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.FocusGlow:completeAnimation()
			f10_arg0.FocusGlow:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.FocusGlow)
			f10_arg0.FocusBorder:completeAnimation()
			f10_arg0.FocusBorder:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.FocusBorder)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(199)
					f12_arg0:setAlpha(0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.ItemHintText:beginAnimation(5000)
				f10_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.ItemHintText:completeAnimation()
			f10_arg0.ItemHintText:setAlpha(1)
			f10_local0(f10_arg0.ItemHintText)
		end,
		GainFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				f13_arg0.FocusGlow:beginAnimation(200)
				f13_arg0.FocusGlow:setAlpha(1)
				f13_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.FocusGlow:completeAnimation()
			f13_arg0.FocusGlow:setAlpha(0)
			f13_local0(f13_arg0.FocusGlow)
			local f13_local1 = function(f15_arg0)
				f13_arg0.FocusBorder:beginAnimation(200)
				f13_arg0.FocusBorder:setAlpha(1)
				f13_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.FocusBorder:completeAnimation()
			f13_arg0.FocusBorder:setAlpha(0)
			f13_local1(f13_arg0.FocusBorder)
			local f13_local2 = function(f16_arg0)
				f13_arg0.ItemHintText:beginAnimation(200)
				f13_arg0.ItemHintText:setAlpha(1)
				f13_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ItemHintText:completeAnimation()
			f13_arg0.ItemHintText:setAlpha(0)
			f13_local2(f13_arg0.ItemHintText)
		end,
		LoseFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.FocusGlow:beginAnimation(200)
				f17_arg0.FocusGlow:setAlpha(0)
				f17_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.FocusGlow:completeAnimation()
			f17_arg0.FocusGlow:setAlpha(1)
			f17_local0(f17_arg0.FocusGlow)
			local f17_local1 = function(f19_arg0)
				f17_arg0.FocusBorder:beginAnimation(200)
				f17_arg0.FocusBorder:setAlpha(0)
				f17_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.FocusBorder:completeAnimation()
			f17_arg0.FocusBorder:setAlpha(1)
			f17_local1(f17_arg0.FocusBorder)
		end,
	},
}
CoD.ReservesLootCaseButton.__onClose = function(f20_arg0)
	f20_arg0.LootCaseMeter:close()
	f20_arg0.ItemHintText:close()
end
