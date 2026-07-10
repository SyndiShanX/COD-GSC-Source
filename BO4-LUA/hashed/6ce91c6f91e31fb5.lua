require("x64:d18f710d30d4ebf")
require("x64:afb605ef7458eea")
CoD.ReservesPromoInternal = InheritFrom(LUI.UIElement)
CoD.ReservesPromoInternal.__defaultWidth = 556
CoD.ReservesPromoInternal.__defaultHeight = 132
CoD.ReservesPromoInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesPromoInternal)
	self.id = "ReservesPromoInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusGlow = LUI.UIImage.new(0.01, 0.99, -78, 78, -0.12, 1.12, -37, 37)
	FocusGlow:setAlpha(0)
	FocusGlow:setScale(1.01, 1)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_small"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.24, 0.24)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(160, 160)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local PreviewButton = LUI.UIImage.new(0, 0, 0, 556, 0, 0, 1, 133)
	PreviewButton:setImage(RegisterImage(@"hash_9B5AB12D437292D"))
	self:addElement(PreviewButton)
	self.PreviewButton = PreviewButton
	local PreviewScene = LUI.UIImage.new(0, 0, -0.5, 555.5, 0, 0, 1, 133)
	PreviewScene:linkToElementModel(self, "bundleReservesImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PreviewScene:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PreviewScene)
	self.PreviewScene = PreviewScene
	local Title = LUI.UIText.new(0, 0, 23, 458, 0, 0, 18.5, 42.5)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setTTF("ttmussels_demibold")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Title:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Price = LUI.UIText.new(0, 0, 23, 123, 1, 1, -36.5, -18.5)
	Price:setRGB(0.95, 0.82, 0.26)
	Price:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_393F12745A24670F"))
	Price:setTTF("ttmussels_demibold")
	Price:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Price:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Price)
	self.Price = Price
	local ShopTimer = CoD.DiscountTimer.new(f1_arg0, f1_arg1, 1, 1, -59, -23, 1, 1, -29.5, -14.5)
	ShopTimer:mergeStateConditions({
		{
			stateName = "Slot1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "timerModel", 1)
			end,
		},
		{
			stateName = "Slot2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "timerModel", 2)
			end,
		},
		{
			stateName = "Slot3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "timerModel", 3)
			end,
		},
	})
	ShopTimer:linkToElementModel(ShopTimer, "timerModel", true, function(model)
		f1_arg0:updateElementState(ShopTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "timerModel",
		})
	end)
	ShopTimer:subscribeToGlobalModel(f1_arg1, "AutoEvents", "autoevent_discount1_timer", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ShopTimer.TimerSlot1.TextBox2:setText(f8_local0)
		end
	end)
	ShopTimer:subscribeToGlobalModel(f1_arg1, "AutoEvents", "autoevent_discount2_timer", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ShopTimer.TimerSlot2.TextBox2:setText(f9_local0)
		end
	end)
	ShopTimer:subscribeToGlobalModel(f1_arg1, "AutoEvents", "autoevent_discount3_timer", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			ShopTimer.TimerSlot3.TextBox2:setText(f10_local0)
		end
	end)
	self:addElement(ShopTimer)
	self.ShopTimer = ShopTimer
	local Darken = LUI.UIImage.new(0.01, 0.99, 0, 0, 0.05, 0.94, 0, 0)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local PurchasedBanner = CoD.ContractPurchasedBanner.new(f1_arg0, f1_arg1, 0, 0, 23, 173, 1, 1, -43.5, -18.5)
	PurchasedBanner:setAlpha(0)
	self:addElement(PurchasedBanner)
	self.PurchasedBanner = PurchasedBanner
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
CoD.ReservesPromoInternal.__resetProperties = function(f13_arg0)
	f13_arg0.FocusGlow:completeAnimation()
	f13_arg0.Price:completeAnimation()
	f13_arg0.PurchasedBanner:completeAnimation()
	f13_arg0.Darken:completeAnimation()
	f13_arg0.FocusGlow:setAlpha(0)
	f13_arg0.Price:setAlpha(1)
	f13_arg0.PurchasedBanner:setAlpha(0)
	f13_arg0.Darken:setAlpha(0)
end
CoD.ReservesPromoInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.FocusGlow:completeAnimation()
			f15_arg0.FocusGlow:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusGlow)
		end,
		GainFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.FocusGlow:beginAnimation(200)
				f16_arg0.FocusGlow:setAlpha(1)
				f16_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.FocusGlow:completeAnimation()
			f16_arg0.FocusGlow:setAlpha(0)
			f16_local0(f16_arg0.FocusGlow)
		end,
		LoseFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.FocusGlow:beginAnimation(100)
				f18_arg0.FocusGlow:setAlpha(0)
				f18_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FocusGlow:completeAnimation()
			f18_arg0.FocusGlow:setAlpha(1)
			f18_local0(f18_arg0.FocusGlow)
		end,
	},
	Purchased = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.Price:completeAnimation()
			f20_arg0.Price:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Price)
			f20_arg0.Darken:completeAnimation()
			f20_arg0.Darken:setAlpha(0.8)
			f20_arg0.clipFinished(f20_arg0.Darken)
			f20_arg0.PurchasedBanner:completeAnimation()
			f20_arg0.PurchasedBanner:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.PurchasedBanner)
		end,
		Focus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			f21_arg0.FocusGlow:completeAnimation()
			f21_arg0.FocusGlow:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.FocusGlow)
			f21_arg0.Price:completeAnimation()
			f21_arg0.Price:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Price)
			f21_arg0.Darken:completeAnimation()
			f21_arg0.Darken:setAlpha(0.8)
			f21_arg0.clipFinished(f21_arg0.Darken)
			f21_arg0.PurchasedBanner:completeAnimation()
			f21_arg0.PurchasedBanner:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.PurchasedBanner)
		end,
		GainFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			local f22_local0 = function(f23_arg0)
				f22_arg0.FocusGlow:beginAnimation(200)
				f22_arg0.FocusGlow:setAlpha(1)
				f22_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FocusGlow:completeAnimation()
			f22_arg0.FocusGlow:setAlpha(0)
			f22_local0(f22_arg0.FocusGlow)
			f22_arg0.Price:completeAnimation()
			f22_arg0.Price:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Price)
			f22_arg0.Darken:completeAnimation()
			f22_arg0.Darken:setAlpha(0.8)
			f22_arg0.clipFinished(f22_arg0.Darken)
			f22_arg0.PurchasedBanner:completeAnimation()
			f22_arg0.PurchasedBanner:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.PurchasedBanner)
		end,
		LoseFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			local f24_local0 = function(f25_arg0)
				f24_arg0.FocusGlow:beginAnimation(100)
				f24_arg0.FocusGlow:setAlpha(0)
				f24_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FocusGlow:completeAnimation()
			f24_arg0.FocusGlow:setAlpha(1)
			f24_local0(f24_arg0.FocusGlow)
			f24_arg0.Price:completeAnimation()
			f24_arg0.Price:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Price)
			f24_arg0.Darken:completeAnimation()
			f24_arg0.Darken:setAlpha(0.8)
			f24_arg0.clipFinished(f24_arg0.Darken)
			f24_arg0.PurchasedBanner:completeAnimation()
			f24_arg0.PurchasedBanner:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.PurchasedBanner)
		end,
	},
}
CoD.ReservesPromoInternal.__onClose = function(f26_arg0)
	f26_arg0.PreviewScene:close()
	f26_arg0.Title:close()
	f26_arg0.ShopTimer:close()
	f26_arg0.PurchasedBanner:close()
end
