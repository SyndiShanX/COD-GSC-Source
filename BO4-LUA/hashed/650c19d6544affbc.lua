require("x64:e272191e46af824")
require("x64:d18f710d30d4ebf")
require("x64:8c811a1d34161cf")
CoD.ReservesLootPurchaseBundleButton = InheritFrom(LUI.UIElement)
CoD.ReservesLootPurchaseBundleButton.__defaultWidth = 248
CoD.ReservesLootPurchaseBundleButton.__defaultHeight = 462
CoD.ReservesLootPurchaseBundleButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesLootPurchaseBundleButton)
	self.id = "ReservesLootPurchaseBundleButton"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -120, 120, 0.5, 0.5, -227, 225)
	Icon:setStretchedDimension(6)
	Icon:linkToElementModel(self, "reservesImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local FocusGlowPC = nil
	FocusGlowPC = LUI.UIImage.new(0.5, 0.5, -240.5, 240.5, 0.5, 0.5, -362.5, 362.5)
	FocusGlowPC:setAlpha(0)
	FocusGlowPC:setImage(RegisterImage(0x8E79E4E42B6714C))
	FocusGlowPC:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FocusGlowPC)
	self.FocusGlowPC = FocusGlowPC
	local f1_local3 = nil
	self.FocusGlow = LUI.UIElement.createFake()
	local NineSliceBMFrame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	NineSliceBMFrame:setImage(RegisterImage(0x1AC151A09D526DC))
	NineSliceBMFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NineSliceBMFrame:setShaderVector(0, 0, 0, 0, 0)
	NineSliceBMFrame:setupNineSliceShader(162, 52)
	self:addElement(NineSliceBMFrame)
	self.NineSliceBMFrame = NineSliceBMFrame
	local TextBacking = LUI.UIImage.new(0, 0, 6, 243, 0, 0, 389.5, 408.5)
	TextBacking:setRGB(0.89, 0.87, 0.75)
	TextBacking:setAlpha(0)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local Title = LUI.UIText.new(0.02, 0.98, 0.5, 0.5, 0, 0, 390.5, 408.5)
	Title:setRGB(0.89, 0.87, 0.75)
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Title:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local CategoryBacking = LUI.UIImage.new(0, 0, 6, 243, 0, 0, 11.5, 30.5)
	CategoryBacking:setRGB(0.89, 0.87, 0.75)
	self:addElement(CategoryBacking)
	self.CategoryBacking = CategoryBacking
	local Category = LUI.UIText.new(0, 0, 15, 243, 0, 0, 12.5, 30.5)
	Category:setRGB(0.11, 0.11, 0.11)
	Category:setTTF("ttmussels_demibold")
	Category:setLetterSpacing(2)
	Category:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Category:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Category:linkToElementModel(self, "category", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Category:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(Category)
	self.Category = Category
	local Price = LUI.UIText.new(0.5, 0.5, -120, 120, 1, 1, -46, -20)
	Price:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	Price:setTTF("ttmussels_demibold")
	Price:setLetterSpacing(2)
	Price:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Price:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Price:linkToElementModel(self, "price", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Price:setText(LocalizeIntoString(0x7AD54B6F8C27799, f5_local0))
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
	local Darken = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 7, -7)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local PurchasedBanner = CoD.ContractPurchasedBanner.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 1, 1, -43.5, -18.5)
	PurchasedBanner.PurchasedTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(PurchasedBanner)
	self.PurchasedBanner = PurchasedBanner
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
	ItemHintText:linkToElementModel(self, "purchaseDesc", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ItemHintText.textCenterAlign:setText(f9_local0)
		end
	end)
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	local TimerRight = CoD.TimerRight.new(f1_arg0, f1_arg1, 1, 1, -48, -12, 1, 1, -428.5, -413.5)
	TimerRight.TextBox2.__TextBox2_String_Reference = function(f10_arg0)
		local f10_local0 = f10_arg0:get()
		if f10_local0 ~= nil then
			TimerRight.TextBox2:setText(CoD.BlackMarketUtility.GetTimerModelValue(self:getModel(), f10_local0))
		end
	end
	TimerRight:subscribeToGlobalModel(f1_arg1, "ReserveDealsRotation", "currentTime", TimerRight.TextBox2.__TextBox2_String_Reference)
	TimerRight.TextBox2.__TextBox2_String_Reference_FullPath = function()
		local f11_local0 = DataSources.ReserveDealsRotation.getModel(f1_arg1)
		f11_local0 = f11_local0.currentTime
		if f11_local0 then
			TimerRight.TextBox2.__TextBox2_String_Reference(f11_local0)
		end
	end
	TimerRight:linkToElementModel(self, nil, false, function(model)
		TimerRight:setModel(model, f1_arg1)
	end)
	self:addElement(TimerRight)
	self.TimerRight = TimerRight
	local f1_local15 = TimerRight
	local f1_local16 = TimerRight.subscribeToModel
	local f1_local17 = DataSources.ReserveDealsRotation.getModel(f1_arg1)
	f1_local16(f1_local15, f1_local17.cycled, TimerRight.TextBox2.__TextBox2_String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased")
			end,
		},
	})
	self:linkToElementModel(self, "purchased", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesLootPurchaseBundleButton.__resetProperties = function(f15_arg0)
	f15_arg0.PurchasedBanner:completeAnimation()
	f15_arg0.FocusGlow:completeAnimation()
	f15_arg0.FocusBorder:completeAnimation()
	f15_arg0.ItemHintText:completeAnimation()
	f15_arg0.FocusGlowPC:completeAnimation()
	f15_arg0.Price:completeAnimation()
	f15_arg0.Darken:completeAnimation()
	f15_arg0.PurchasedBanner:setAlpha(1)
	f15_arg0.FocusGlow:setAlpha(0)
	f15_arg0.FocusBorder:setAlpha(0)
	f15_arg0.ItemHintText:setAlpha(0)
	f15_arg0.FocusGlowPC:setAlpha(0)
	f15_arg0.Price:setAlpha(1)
	f15_arg0.Darken:setAlpha(0)
end
CoD.ReservesLootPurchaseBundleButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.PurchasedBanner:completeAnimation()
			f16_arg0.PurchasedBanner:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.PurchasedBanner)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.FocusGlowPC:completeAnimation()
			f17_arg0.FocusGlowPC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusGlowPC)
			f17_arg0.FocusGlow:completeAnimation()
			f17_arg0.FocusGlow:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusGlow)
			f17_arg0.FocusBorder:completeAnimation()
			f17_arg0.FocusBorder:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusBorder)
			f17_arg0.PurchasedBanner:completeAnimation()
			f17_arg0.PurchasedBanner:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PurchasedBanner)
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
			f20_arg0:setupElementClipCounter(4)
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
				f20_arg0.FocusGlow:beginAnimation(200)
				f20_arg0.FocusGlow:setAlpha(1)
				f20_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusGlow:completeAnimation()
			f20_arg0.FocusGlow:setAlpha(0)
			f20_local1(f20_arg0.FocusGlow)
			local f20_local2 = function(f23_arg0)
				f20_arg0.FocusBorder:beginAnimation(200)
				f20_arg0.FocusBorder:setAlpha(1)
				f20_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusBorder:completeAnimation()
			f20_arg0.FocusBorder:setAlpha(0)
			f20_local2(f20_arg0.FocusBorder)
			f20_arg0.PurchasedBanner:completeAnimation()
			f20_arg0.PurchasedBanner:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PurchasedBanner)
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
			f25_arg0:setupElementClipCounter(3)
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
				f25_arg0.FocusGlow:beginAnimation(100)
				f25_arg0.FocusGlow:setAlpha(0)
				f25_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusGlow:completeAnimation()
			f25_arg0.FocusGlow:setAlpha(1)
			f25_local1(f25_arg0.FocusGlow)
			local f25_local2 = function(f28_arg0)
				f25_arg0.FocusBorder:beginAnimation(100)
				f25_arg0.FocusBorder:setAlpha(0)
				f25_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusBorder:completeAnimation()
			f25_arg0.FocusBorder:setAlpha(1)
			f25_local2(f25_arg0.FocusBorder)
			f25_arg0.PurchasedBanner:completeAnimation()
			f25_arg0.PurchasedBanner:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.PurchasedBanner)
		end,
	},
	Purchased = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.Price:completeAnimation()
			f29_arg0.Price:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.Price)
			f29_arg0.Darken:completeAnimation()
			f29_arg0.Darken:setAlpha(0.8)
			f29_arg0.clipFinished(f29_arg0.Darken)
			f29_arg0.PurchasedBanner:completeAnimation()
			f29_arg0.PurchasedBanner:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.PurchasedBanner)
		end,
		Focus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(5)
			f30_arg0.FocusGlow:completeAnimation()
			f30_arg0.FocusGlow:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FocusGlow)
			f30_arg0.Price:completeAnimation()
			f30_arg0.Price:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Price)
			f30_arg0.FocusBorder:completeAnimation()
			f30_arg0.FocusBorder:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FocusBorder)
			f30_arg0.Darken:completeAnimation()
			f30_arg0.Darken:setAlpha(0.8)
			f30_arg0.clipFinished(f30_arg0.Darken)
			f30_arg0.PurchasedBanner:completeAnimation()
			f30_arg0.PurchasedBanner:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.PurchasedBanner)
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
		end,
		GainFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(5)
			local f33_local0 = function(f34_arg0)
				f33_arg0.FocusGlow:beginAnimation(200)
				f33_arg0.FocusGlow:setAlpha(1)
				f33_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.FocusGlow:completeAnimation()
			f33_arg0.FocusGlow:setAlpha(0)
			f33_local0(f33_arg0.FocusGlow)
			f33_arg0.Price:completeAnimation()
			f33_arg0.Price:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Price)
			local f33_local1 = function(f35_arg0)
				f33_arg0.FocusBorder:beginAnimation(200)
				f33_arg0.FocusBorder:setAlpha(1)
				f33_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.FocusBorder:completeAnimation()
			f33_arg0.FocusBorder:setAlpha(0)
			f33_local1(f33_arg0.FocusBorder)
			f33_arg0.Darken:completeAnimation()
			f33_arg0.Darken:setAlpha(0.8)
			f33_arg0.clipFinished(f33_arg0.Darken)
			f33_arg0.PurchasedBanner:completeAnimation()
			f33_arg0.PurchasedBanner:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.PurchasedBanner)
			local f33_local2 = function(f36_arg0)
				f33_arg0.ItemHintText:beginAnimation(200)
				f33_arg0.ItemHintText:setAlpha(1)
				f33_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.ItemHintText:completeAnimation()
			f33_arg0.ItemHintText:setAlpha(0)
			f33_local2(f33_arg0.ItemHintText)
		end,
		LoseFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			local f37_local0 = function(f38_arg0)
				f37_arg0.FocusGlow:beginAnimation(100)
				f37_arg0.FocusGlow:setAlpha(0)
				f37_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.FocusGlow:completeAnimation()
			f37_arg0.FocusGlow:setAlpha(1)
			f37_local0(f37_arg0.FocusGlow)
			f37_arg0.Price:completeAnimation()
			f37_arg0.Price:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.Price)
			local f37_local1 = function(f39_arg0)
				f37_arg0.FocusBorder:beginAnimation(100)
				f37_arg0.FocusBorder:setAlpha(0)
				f37_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.FocusBorder:completeAnimation()
			f37_arg0.FocusBorder:setAlpha(1)
			f37_local1(f37_arg0.FocusBorder)
			f37_arg0.Darken:completeAnimation()
			f37_arg0.Darken:setAlpha(0.8)
			f37_arg0.clipFinished(f37_arg0.Darken)
			f37_arg0.PurchasedBanner:completeAnimation()
			f37_arg0.PurchasedBanner:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.PurchasedBanner)
		end,
	},
}
CoD.ReservesLootPurchaseBundleButton.__onClose = function(f40_arg0)
	f40_arg0.Icon:close()
	f40_arg0.Title:close()
	f40_arg0.Category:close()
	f40_arg0.Price:close()
	f40_arg0.PurchasedBanner:close()
	f40_arg0.ItemHintText:close()
	f40_arg0.TimerRight:close()
end
