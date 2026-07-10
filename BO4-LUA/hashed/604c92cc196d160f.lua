require("x64:e272191e46af824")
require("x64:e4ab7898d6eef2c")
require("x64:d18f710d30d4ebf")
require("x64:1b76bc3f9278e54")
require("x64:8c811a1d34161cf")
CoD.ReservesBribeStack = InheritFrom(LUI.UIElement)
CoD.ReservesBribeStack.__defaultWidth = 248
CoD.ReservesBribeStack.__defaultHeight = 462
CoD.ReservesBribeStack.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesBribeStack)
	self.id = "ReservesBribeStack"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CrateScene = LUI.UIImage.new(0.5, 0.5, -120, 120, 0.5, 0.5, -226, 226)
	CrateScene:linkToElementModel(self, "stackImage", true, function(model)
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
	FocusGlowPC:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_large"))
	FocusGlowPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(FocusGlowPC)
	self.FocusGlowPC = FocusGlowPC
	local f1_local3 = nil
	self.FocusGlow2 = LUI.UIElement.createFake()
	local NineSliceBMFrame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	NineSliceBMFrame:setImage(RegisterImage(@"hash_71AC151A09D526DC"))
	NineSliceBMFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
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
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Title:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local FocusBorder = LUI.UIImage.new(0, 1, -6, 6, 0, 1, -6, 6)
	FocusBorder:setRGB(1, 0.75, 0.47)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(18, 18)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local Price = CoD.ContractItemCostMultiCurrency.new(f1_arg0, f1_arg1, 0, 0, 32, 217, 0, 0, 416, 437)
	Price:linkToElementModel(self, nil, false, function(model)
		Price:setModel(model, f1_arg1)
	end)
	self:addElement(Price)
	self.Price = Price
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
			ItemHintText.textCenterAlign:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	local Darken = LUI.UIImage.new(0, 0, 0, 248, 0, 0, 0, 462)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local TimerRight = CoD.TimerRight.new(f1_arg0, f1_arg1, 0, 0, 135, 237, 0, 0, 36.5, 51.5)
	TimerRight.TextBox2.__TextBox2_String_Reference = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			TimerRight.TextBox2:setText(CoD.BlackMarketUtility.GetBribeMenuTimerModelValue(self:getModel(), f9_local0))
		end
	end
	TimerRight:subscribeToGlobalModel(f1_arg1, "BribeMenuTimer", "bribe_menu_timer", TimerRight.TextBox2.__TextBox2_String_Reference)
	TimerRight.TextBox2.__TextBox2_String_Reference_FullPath = function()
		local f10_local0 = DataSources.BribeMenuTimer.getModel(f1_arg1)
		f10_local0 = f10_local0.bribe_menu_timer
		if f10_local0 then
			TimerRight.TextBox2.__TextBox2_String_Reference(f10_local0)
		end
	end
	self:addElement(TimerRight)
	self.TimerRight = TimerRight
	local PurchasedBanner = CoD.ContractPurchasedBanner.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 1, 1, -46, -21)
	PurchasedBanner:setAlpha(0)
	PurchasedBanner.PurchasedTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(PurchasedBanner)
	self.PurchasedBanner = PurchasedBanner
	local ItemShopDiscountBanner = CoD.ItemShopDiscountBanner.new(f1_arg0, f1_arg1, 0, 0, 26, 237, 0, 0, 370.5, 396.5)
	ItemShopDiscountBanner:linkToElementModel(self, nil, false, function(model)
		ItemShopDiscountBanner:setModel(model, f1_arg1)
	end)
	ItemShopDiscountBanner:linkToElementModel(self, "percentOff", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ItemShopDiscountBanner.Promo:setText(ToUpper(LocalizeIntoString(@"hash_4650F08A0DD215DD", f12_local0)))
		end
	end)
	self:addElement(ItemShopDiscountBanner)
	self.ItemShopDiscountBanner = ItemShopDiscountBanner
	local f1_local14 = TimerRight
	local f1_local15 = TimerRight.subscribeToModel
	local f1_local16 = DataSources.BribeMenuTimer.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.cycled, TimerRight.TextBox2.__TextBox2_String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased")
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
CoD.ReservesBribeStack.__resetProperties = function(f15_arg0)
	f15_arg0.PurchasedBanner:completeAnimation()
	f15_arg0.TimerRight:completeAnimation()
	f15_arg0.Darken:completeAnimation()
	f15_arg0.Price:completeAnimation()
	f15_arg0.FocusBorder:completeAnimation()
	f15_arg0.FocusGlow2:completeAnimation()
	f15_arg0.ItemHintText:completeAnimation()
	f15_arg0.FocusGlowPC:completeAnimation()
	f15_arg0.PurchasedBanner:setAlpha(0)
	f15_arg0.TimerRight:setAlpha(1)
	f15_arg0.Darken:setAlpha(0)
	f15_arg0.Price:setAlpha(1)
	f15_arg0.FocusBorder:setAlpha(0)
	f15_arg0.FocusGlow2:setAlpha(0)
	f15_arg0.ItemHintText:setAlpha(0)
	f15_arg0.FocusGlowPC:setAlpha(0)
end
CoD.ReservesBribeStack.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.Price:completeAnimation()
			f16_arg0.Price:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Price)
			f16_arg0.Darken:completeAnimation()
			f16_arg0.Darken:setAlpha(0.7)
			f16_arg0.clipFinished(f16_arg0.Darken)
			f16_arg0.TimerRight:completeAnimation()
			f16_arg0.TimerRight:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.TimerRight)
			f16_arg0.PurchasedBanner:completeAnimation()
			f16_arg0.PurchasedBanner:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.PurchasedBanner)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(7)
			f17_arg0.FocusGlowPC:completeAnimation()
			f17_arg0.FocusGlowPC:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusGlowPC)
			f17_arg0.FocusGlow2:completeAnimation()
			f17_arg0.FocusGlow2:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusGlow2)
			f17_arg0.FocusBorder:completeAnimation()
			f17_arg0.FocusBorder:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusBorder)
			f17_arg0.Price:completeAnimation()
			f17_arg0.Price:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Price)
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
			f17_arg0.Darken:completeAnimation()
			f17_arg0.Darken:setAlpha(0.7)
			f17_arg0.clipFinished(f17_arg0.Darken)
			f17_arg0.TimerRight:completeAnimation()
			f17_arg0.TimerRight:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.TimerRight)
			f17_arg0.PurchasedBanner:completeAnimation()
			f17_arg0.PurchasedBanner:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.PurchasedBanner)
		end,
		GainFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(7)
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
			f20_arg0.Price:completeAnimation()
			f20_arg0.Price:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Price)
			local f20_local3 = function(f24_arg0)
				f20_arg0.ItemHintText:beginAnimation(200)
				f20_arg0.ItemHintText:setAlpha(1)
				f20_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ItemHintText:completeAnimation()
			f20_arg0.ItemHintText:setAlpha(0)
			f20_local3(f20_arg0.ItemHintText)
			f20_arg0.Darken:completeAnimation()
			f20_arg0.Darken:setAlpha(0.7)
			f20_arg0.clipFinished(f20_arg0.Darken)
			f20_arg0.TimerRight:completeAnimation()
			f20_arg0.TimerRight:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.TimerRight)
			f20_arg0.PurchasedBanner:completeAnimation()
			f20_arg0.PurchasedBanner:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.PurchasedBanner)
		end,
		LoseFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(6)
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
			f25_arg0.Price:completeAnimation()
			f25_arg0.Price:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Price)
			f25_arg0.Darken:completeAnimation()
			f25_arg0.Darken:setAlpha(0.7)
			f25_arg0.clipFinished(f25_arg0.Darken)
			f25_arg0.TimerRight:completeAnimation()
			f25_arg0.TimerRight:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.TimerRight)
			f25_arg0.PurchasedBanner:completeAnimation()
			f25_arg0.PurchasedBanner:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.PurchasedBanner)
		end,
	},
	Purchased = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
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
		end,
		GainFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
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
		end,
		LoseFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
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
		end,
	},
}
CoD.ReservesBribeStack.__onClose = function(f42_arg0)
	f42_arg0.CrateScene:close()
	f42_arg0.Title:close()
	f42_arg0.Price:close()
	f42_arg0.ItemHintText:close()
	f42_arg0.TimerRight:close()
	f42_arg0.PurchasedBanner:close()
	f42_arg0.ItemShopDiscountBanner:close()
end
