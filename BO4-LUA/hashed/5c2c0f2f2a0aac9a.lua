require("x64:e272191e46af824")
require("x64:1b76bc3f9278e54")
require("x64:8c811a1d34161cf")
CoD.ReservesLootCrateButton = InheritFrom(LUI.UIElement)
CoD.ReservesLootCrateButton.__defaultWidth = 248
CoD.ReservesLootCrateButton.__defaultHeight = 462
CoD.ReservesLootCrateButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesLootCrateButton)
	self.id = "ReservesLootCrateButton"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CrateScene = LUI.UIImage.new(0.5, 0.5, -120, 120, 0.5, 0.5, -226, 226)
	CrateScene:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CrateScene:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(CrateScene)
	self.CrateScene = CrateScene
	local FocusGlowPC = nil
	FocusGlowPC = LUI.UIImage.new(0.5, 0.5, -240.5, 240.5, 0.5, 0.5, -362.5, 362.5)
	FocusGlowPC:setAlpha(0)
	FocusGlowPC:setImage(RegisterImage(0x8E79E4E42B6714C))
	FocusGlowPC:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FocusGlowPC)
	self.FocusGlowPC = FocusGlowPC
	local f1_local3 = nil
	self.FocusGlow2 = LUI.UIElement.createFake()
	local NineSliceBMFrame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	NineSliceBMFrame:setImage(RegisterImage(0x1AC151A09D526DC))
	NineSliceBMFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NineSliceBMFrame:setShaderVector(0, 0, 0, 0, 0)
	NineSliceBMFrame:setupNineSliceShader(162, 52)
	self:addElement(NineSliceBMFrame)
	self.NineSliceBMFrame = NineSliceBMFrame
	local TextBacking = LUI.UIImage.new(0, 0, 6, 243, 0, 0, 11.5, 30.5)
	TextBacking:setRGB(0.89, 0.87, 0.75)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local Title = LUI.UIText.new(0, 0, 15, 243, 0, 0, 12.5, 30.5)
	Title:setRGB(0.11, 0.11, 0.11)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Title:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Price = LUI.UIText.new(0.5, 0.5, -120, 120, 1, 1, -46, -20)
	Price:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	Price:setTTF("ttmussels_demibold")
	Price:setLetterSpacing(2)
	Price:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Price:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Price:linkToElementModel(self, "price", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Price:setText(LocalizeIntoString(0x7AD54B6F8C27799, f4_local0))
		end
	end)
	self:addElement(Price)
	self.Price = Price
	local FocusBorder = LUI.UIImage.new(0, 1, -6, 6, 0, 1, -6, 6)
	FocusBorder:setRGB(1, 0.75, 0.47)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(18, 18)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local ItemHintText = CoD.CommonToolTip.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 1, 1, 30, 75)
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
	ItemHintText:linkToElementModel(self, "desc", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ItemHintText.textCenterAlign:setText(Engine[0xF9F1239CFD921FE](f8_local0))
		end
	end)
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	local ItemShopDiscountBanner = CoD.ItemShopDiscountBanner.new(f1_arg0, f1_arg1, 0, 0, 37, 248, 0, 0, 366.5, 392.5)
	ItemShopDiscountBanner:linkToElementModel(self, nil, false, function(model)
		ItemShopDiscountBanner:setModel(model, f1_arg1)
	end)
	ItemShopDiscountBanner:linkToElementModel(self, "percentOff", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ItemShopDiscountBanner.Promo:setText(ToUpper(LocalizeIntoString(0x4211D07B481977D, f10_local0)))
		end
	end)
	self:addElement(ItemShopDiscountBanner)
	self.ItemShopDiscountBanner = ItemShopDiscountBanner
	local TimerRight = CoD.TimerRight.new(f1_arg0, f1_arg1, 0, 0, 141, 243, 0, 0, 30.5, 45.5)
	TimerRight:setAlpha(0)
	TimerRight:subscribeToGlobalModel(f1_arg1, "AutoEvents", "autoevent_half_off_crate_timer", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			TimerRight.TextBox2:setText(f11_local0)
		end
	end)
	self:addElement(TimerRight)
	self.TimerRight = TimerRight
	self:mergeStateConditions({
		{
			stateName = "ShowTimer",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isCrateItem") and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "percentOff", 0)
			end,
		},
	})
	self:linkToElementModel(self, "isCrateItem", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isCrateItem",
		})
	end)
	self:linkToElementModel(self, "percentOff", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percentOff",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesLootCrateButton.__resetProperties = function(f15_arg0)
	f15_arg0.FocusBorder:completeAnimation()
	f15_arg0.FocusGlow2:completeAnimation()
	f15_arg0.ItemHintText:completeAnimation()
	f15_arg0.FocusGlowPC:completeAnimation()
	f15_arg0.TimerRight:completeAnimation()
	f15_arg0.FocusBorder:setAlpha(0)
	f15_arg0.FocusGlow2:setAlpha(0)
	f15_arg0.ItemHintText:setAlpha(0)
	f15_arg0.FocusGlowPC:setAlpha(0)
	f15_arg0.TimerRight:setAlpha(0)
end
CoD.ReservesLootCrateButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.FocusGlowPC:completeAnimation()
			f17_arg0.FocusGlowPC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusGlowPC)
			f17_arg0.FocusGlow2:completeAnimation()
			f17_arg0.FocusGlow2:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusGlow2)
			f17_arg0.FocusBorder:completeAnimation()
			f17_arg0.FocusBorder:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusBorder)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(199)
					f19_arg0:setAlpha(0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.ItemHintText:beginAnimation(5000)
				f17_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.ItemHintText:completeAnimation()
			f17_arg0.ItemHintText:setAlpha(1)
			f17_local0(f17_arg0.ItemHintText)
		end,
		GainFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			local f20_local0 = function(f21_arg0)
				f20_arg0.FocusGlowPC:beginAnimation(200)
				f20_arg0.FocusGlowPC:setAlpha(1)
				f20_arg0.FocusGlowPC:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusGlowPC:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusGlowPC:completeAnimation()
			f20_arg0.FocusGlowPC:setAlpha(0)
			f20_local0(f20_arg0.FocusGlowPC)
			local f20_local1 = function(f22_arg0)
				f20_arg0.FocusGlow2:beginAnimation(200)
				f20_arg0.FocusGlow2:setAlpha(1)
				f20_arg0.FocusGlow2:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusGlow2:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusGlow2:completeAnimation()
			f20_arg0.FocusGlow2:setAlpha(0)
			f20_local1(f20_arg0.FocusGlow2)
			local f20_local2 = function(f23_arg0)
				f20_arg0.FocusBorder:beginAnimation(200)
				f20_arg0.FocusBorder:setAlpha(1)
				f20_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusBorder:completeAnimation()
			f20_arg0.FocusBorder:setAlpha(0)
			f20_local2(f20_arg0.FocusBorder)
			local f20_local3 = function(f24_arg0)
				f20_arg0.ItemHintText:beginAnimation(200)
				f20_arg0.ItemHintText:setAlpha(1)
				f20_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ItemHintText:completeAnimation()
			f20_arg0.ItemHintText:setAlpha(0)
			f20_local3(f20_arg0.ItemHintText)
		end,
		LoseFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.FocusGlowPC:beginAnimation(100)
				f25_arg0.FocusGlowPC:setAlpha(0)
				f25_arg0.FocusGlowPC:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusGlowPC:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusGlowPC:completeAnimation()
			f25_arg0.FocusGlowPC:setAlpha(1)
			f25_local0(f25_arg0.FocusGlowPC)
			local f25_local1 = function(f27_arg0)
				f25_arg0.FocusGlow2:beginAnimation(100)
				f25_arg0.FocusGlow2:setAlpha(0)
				f25_arg0.FocusGlow2:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusGlow2:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusGlow2:completeAnimation()
			f25_arg0.FocusGlow2:setAlpha(1)
			f25_local1(f25_arg0.FocusGlow2)
			local f25_local2 = function(f28_arg0)
				f25_arg0.FocusBorder:beginAnimation(100)
				f25_arg0.FocusBorder:setAlpha(0)
				f25_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusBorder:completeAnimation()
			f25_arg0.FocusBorder:setAlpha(1)
			f25_local2(f25_arg0.FocusBorder)
		end,
	},
	ShowTimer = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.TimerRight:completeAnimation()
			f29_arg0.TimerRight:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.TimerRight)
		end,
		Focus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(4)
			f30_arg0.FocusGlowPC:completeAnimation()
			f30_arg0.FocusGlowPC:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FocusGlowPC)
			f30_arg0.FocusGlow2:completeAnimation()
			f30_arg0.FocusGlow2:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FocusGlow2)
			f30_arg0.FocusBorder:completeAnimation()
			f30_arg0.FocusBorder:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FocusBorder)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(199)
					f32_arg0:setAlpha(0)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.ItemHintText:beginAnimation(5000)
				f30_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.ItemHintText:completeAnimation()
			f30_arg0.ItemHintText:setAlpha(1)
			f30_local0(f30_arg0.ItemHintText)
			f30_arg0.TimerRight:completeAnimation()
			f30_arg0.TimerRight:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TimerRight)
		end,
		GainFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(4)
			local f33_local0 = function(f34_arg0)
				f33_arg0.FocusGlowPC:beginAnimation(200)
				f33_arg0.FocusGlowPC:setAlpha(1)
				f33_arg0.FocusGlowPC:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.FocusGlowPC:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.FocusGlowPC:completeAnimation()
			f33_arg0.FocusGlowPC:setAlpha(0)
			f33_local0(f33_arg0.FocusGlowPC)
			local f33_local1 = function(f35_arg0)
				f33_arg0.FocusGlow2:beginAnimation(200)
				f33_arg0.FocusGlow2:setAlpha(1)
				f33_arg0.FocusGlow2:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.FocusGlow2:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.FocusGlow2:completeAnimation()
			f33_arg0.FocusGlow2:setAlpha(0)
			f33_local1(f33_arg0.FocusGlow2)
			local f33_local2 = function(f36_arg0)
				f33_arg0.FocusBorder:beginAnimation(200)
				f33_arg0.FocusBorder:setAlpha(1)
				f33_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.FocusBorder:completeAnimation()
			f33_arg0.FocusBorder:setAlpha(0)
			f33_local2(f33_arg0.FocusBorder)
			local f33_local3 = function(f37_arg0)
				f33_arg0.ItemHintText:beginAnimation(200)
				f33_arg0.ItemHintText:setAlpha(1)
				f33_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.ItemHintText:completeAnimation()
			f33_arg0.ItemHintText:setAlpha(0)
			f33_local3(f33_arg0.ItemHintText)
			f33_arg0.TimerRight:completeAnimation()
			f33_arg0.TimerRight:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.TimerRight)
		end,
		LoseFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(3)
			local f38_local0 = function(f39_arg0)
				f38_arg0.FocusGlowPC:beginAnimation(100)
				f38_arg0.FocusGlowPC:setAlpha(0)
				f38_arg0.FocusGlowPC:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.FocusGlowPC:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.FocusGlowPC:completeAnimation()
			f38_arg0.FocusGlowPC:setAlpha(1)
			f38_local0(f38_arg0.FocusGlowPC)
			local f38_local1 = function(f40_arg0)
				f38_arg0.FocusGlow2:beginAnimation(100)
				f38_arg0.FocusGlow2:setAlpha(0)
				f38_arg0.FocusGlow2:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.FocusGlow2:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.FocusGlow2:completeAnimation()
			f38_arg0.FocusGlow2:setAlpha(1)
			f38_local1(f38_arg0.FocusGlow2)
			local f38_local2 = function(f41_arg0)
				f38_arg0.FocusBorder:beginAnimation(100)
				f38_arg0.FocusBorder:setAlpha(0)
				f38_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.FocusBorder:completeAnimation()
			f38_arg0.FocusBorder:setAlpha(1)
			f38_local2(f38_arg0.FocusBorder)
			f38_arg0.TimerRight:completeAnimation()
			f38_arg0.TimerRight:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.TimerRight)
		end,
	},
}
CoD.ReservesLootCrateButton.__onClose = function(f42_arg0)
	f42_arg0.CrateScene:close()
	f42_arg0.Title:close()
	f42_arg0.Price:close()
	f42_arg0.ItemHintText:close()
	f42_arg0.ItemShopDiscountBanner:close()
	f42_arg0.TimerRight:close()
end
