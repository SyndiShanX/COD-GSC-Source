require("x64:b6f9e612c26d159")
require("x64:f8a0b937713cad5")
require("x64:5f8cf56752aa71b")
require("x64:a52bba85c50cc57")
require("x64:f3b958c51de713f")
require("x64:1b76bc3f9278e54")
require("x64:93604c7b6b216ac")
require("x64:f9f2225659f819c")
require("x64:d6a01f359d18c25")
require("x64:77c0fdd786c03d6")
require("x64:503fe83a004e58a")
CoD.BMTallItem = InheritFrom(LUI.UIElement)
CoD.BMTallItem.__defaultWidth = 240
CoD.BMTallItem.__defaultHeight = 510
CoD.BMTallItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BMTallItem)
	self.id = "BMTallItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Desat = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Desat:setRGB(0.27, 0.27, 0.27)
	Desat:setAlpha(0.24)
	self:addElement(Desat)
	self.Desat = Desat
	local LED2 = LUI.UIImage.new(0, 1, 3, -1, 0, 1, 3, -1)
	LED2:setRGB(0, 0, 0)
	LED2:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	LED2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	LED2:setShaderVector(0, 0, 0, 0, 0)
	LED2:setupNineSliceShader(24, 24)
	self:addElement(LED2)
	self.LED2 = LED2
	local GlowBorder = LUI.UIImage.new(0, 1, -26, 26, 0, 1, -26, 26)
	GlowBorder:setRGB(0.77, 0.4, 0.1)
	GlowBorder:setAlpha(0)
	GlowBorder:setImage(RegisterImage(@"uie_ui_menu_item_shop_glow_border"))
	GlowBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	GlowBorder:setShaderVector(0, 0, 0, 0, 0)
	GlowBorder:setupNineSliceShader(70, 70)
	self:addElement(GlowBorder)
	self.GlowBorder = GlowBorder
	local GlowBorder2 = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	GlowBorder2:setRGB(1, 0.87, 0)
	GlowBorder2:setAlpha(0)
	GlowBorder2:setImage(RegisterImage(@"uie_ui_menu_item_shop_glow_border"))
	GlowBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	GlowBorder2:setShaderVector(0, 0, 0, 0, 0)
	GlowBorder2:setupNineSliceShader(12, 12)
	self:addElement(GlowBorder2)
	self.GlowBorder2 = GlowBorder2
	local Backer = CoD.ContractItemBacker.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Backer:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Backer:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f2_local0))
		end
	end)
	self:addElement(Backer)
	self.Backer = Backer
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local ContractTall = CoD.ContractTall.new(f1_arg0, f1_arg1, 0, 0, 2, 238, 0, 0, 2, 508)
	ContractTall:linkToElementModel(self, nil, false, function(model)
		ContractTall:setModel(model, f1_arg1)
	end)
	self:addElement(ContractTall)
	self.ContractTall = ContractTall
	local ReserveTall = CoD.ReserveTall.new(f1_arg0, f1_arg1, 0, 0, 2, 238, 0, 0, 2, 508)
	ReserveTall:linkToElementModel(self, nil, false, function(model)
		ReserveTall:setModel(model, f1_arg1)
	end)
	self:addElement(ReserveTall)
	self.ReserveTall = ReserveTall
	local ShopReserveItemTall = CoD.ShopReserveItemTall.new(f1_arg0, f1_arg1, 0, 0, 2, 238, 0, 0, 2, 508)
	ShopReserveItemTall:linkToElementModel(self, nil, false, function(model)
		ShopReserveItemTall:setModel(model, f1_arg1)
	end)
	self:addElement(ShopReserveItemTall)
	self.ShopReserveItemTall = ShopReserveItemTall
	local ShopItemTall = CoD.ShopItemTall.new(f1_arg0, f1_arg1, 0, 0, 2, 238, 0, 0, 2, 508)
	ShopItemTall:linkToElementModel(self, nil, false, function(model)
		ShopItemTall:setModel(model, f1_arg1)
	end)
	self:addElement(ShopItemTall)
	self.ShopItemTall = ShopItemTall
	local Darken = LUI.UIImage.new(0, 0, 0, 240, 0, 0, 0, 510)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local MysteryItem = CoD.MysteryItem.new(f1_arg0, f1_arg1, 0, 0, 0, 240, 0, 0, 0, 510)
	MysteryItem:mergeStateConditions({
		{
			stateName = "NoButtonPrompt",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isInItemShop")
			end,
		},
	})
	MysteryItem:linkToElementModel(MysteryItem, "isInItemShop", true, function(model)
		f1_arg0:updateElementState(MysteryItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isInItemShop",
		})
	end)
	MysteryItem:setAlpha(0)
	MysteryItem:linkToElementModel(self, nil, false, function(model)
		MysteryItem:setModel(model, f1_arg1)
	end)
	self:addElement(MysteryItem)
	self.MysteryItem = MysteryItem
	local MysteryItemSilver = LUI.UIImage.new(0, 0, -10, 250, 0, 0, -12, 520)
	MysteryItemSilver:setAlpha(0)
	MysteryItemSilver:setImage(RegisterImage(@"hash_55CE0150279655AB"))
	self:addElement(MysteryItemSilver)
	self.MysteryItemSilver = MysteryItemSilver
	local f1_local14 = nil
	self.MyShopTimer = LUI.UIElement.createFake()
	local MyShopTimerPC = nil
	MyShopTimerPC = CoD.ListLabel.new(f1_arg0, f1_arg1, 0.5, 0.5, -100.5, 99.5, 0.5, 0.5, -295, -266)
	MyShopTimerPC:setAlpha(0)
	MyShopTimerPC:linkToElementModel(self, nil, false, function(model)
		MyShopTimerPC:setModel(model, f1_arg1)
	end)
	MyShopTimerPC:linkToElementModel(self, "timeStamp", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			MyShopTimerPC.TextBox2:setText(UTCStringAsShortDate(f11_local0))
		end
	end)
	self:addElement(MyShopTimerPC)
	self.MyShopTimerPC = MyShopTimerPC
	local NoMyShopOffers = LUI.UIText.new(0, 0, 3, 239, 0, 0, 219, 243)
	NoMyShopOffers:setAlpha(0)
	NoMyShopOffers:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_640A4373BEE19526"))
	NoMyShopOffers:setTTF("default")
	NoMyShopOffers:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NoMyShopOffers:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(NoMyShopOffers)
	self.NoMyShopOffers = NoMyShopOffers
	local NoItemsSunsetText = LUI.UIText.new(0.5, 0.5, -112, 112, 0, 0, 219, 243)
	NoItemsSunsetText:setAlpha(0)
	NoItemsSunsetText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_32D3BCAB05F9CC99"))
	NoItemsSunsetText:setTTF("default")
	NoItemsSunsetText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NoItemsSunsetText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(NoItemsSunsetText)
	self.NoItemsSunsetText = NoItemsSunsetText
	local ItemShopDiscountBanner = CoD.ItemShopDiscountBanner.new(f1_arg0, f1_arg1, 0, 0, 27, 238, 0, 0, 378, 404)
	ItemShopDiscountBanner:linkToElementModel(self, nil, false, function(model)
		ItemShopDiscountBanner:setModel(model, f1_arg1)
	end)
	ItemShopDiscountBanner:linkToElementModel(self, "percentOff", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			ItemShopDiscountBanner.Promo:setText(ToUpper(LocalizeIntoString(@"hash_44211D07B481977D", f13_local0)))
		end
	end)
	self:addElement(ItemShopDiscountBanner)
	self.ItemShopDiscountBanner = ItemShopDiscountBanner
	local GlowLarge = CoD.CommonGlowFlickerAnim.new(f1_arg0, f1_arg1, 0.5, 0.5, -128, 128, 0.5, 0.5, -128, 128)
	GlowLarge:setRGB(0.54, 0.43, 0.22)
	GlowLarge:setAlpha(0)
	GlowLarge:setScale(2, 2)
	GlowLarge.GlowLarge01:setRGB(1, 1, 1)
	GlowLarge.GlowLarge02:setRGB(1, 1, 1)
	self:addElement(GlowLarge)
	self.GlowLarge = GlowLarge
	local GlowLargeThin = CoD.CommonGlowStandard.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 0.5, 0.5, -40, 40)
	GlowLargeThin:setRGB(0.54, 0.43, 0.22)
	GlowLargeThin:setAlpha(0)
	GlowLargeThin:setZRot(4)
	GlowLargeThin.GlowLarge01:setRGB(1, 1, 1)
	GlowLargeThin.GlowLarge02:setRGB(1, 1, 1)
	self:addElement(GlowLargeThin)
	self.GlowLargeThin = GlowLargeThin
	local RevealSound = LUI.UIElement.new(0, 0, -46, -14, 0, 0, -16, 16)
	RevealSound:setPlaySoundDirect(true)
	self:addElement(RevealSound)
	self.RevealSound = RevealSound
	self:mergeStateConditions({
		{
			stateName = "EmptySunset",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_sunsetBlackjackShopActive") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "emptyItem")
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				local f15_local0
				if not IsBooleanDvarSet("loot_sunsetBlackjackShopActive") and not CoD.BlackMarketUtility.CanRevealMyShopItem(f1_arg1) then
					f15_local0 = not CoD.ModelUtility.IsSelfModelValueNil(element, f1_arg1, "revealed")
				else
					f15_local0 = false
				end
				return f15_local0
			end,
		},
		{
			stateName = "MysteryReserveItemSunset",
			condition = function(menu, element, event)
				local f16_local0 = IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
				if f16_local0 then
					if not CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "revealed") then
						f16_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isInItemShop")
						if f16_local0 then
							f16_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "slot", 3)
						end
					else
						f16_local0 = false
					end
				end
				return f16_local0
			end,
		},
		{
			stateName = "MysteryItemSunset",
			condition = function(menu, element, event)
				local f17_local0 = IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
				if f17_local0 then
					if not CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "revealed") then
						f17_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isInItemShop")
					else
						f17_local0 = false
					end
				end
				return f17_local0
			end,
		},
		{
			stateName = "MysteryItem",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "revealed")
			end,
		},
	})
	self:linkToElementModel(self, "emptyItem", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "emptyItem",
		})
	end)
	self:linkToElementModel(self, "revealed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "revealed",
		})
	end)
	self:linkToElementModel(self, "isInItemShop", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isInItemShop",
		})
	end)
	self:linkToElementModel(self, "slot", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slot",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "timeStamp") and IsPC() then
			SetAlpha(self.MyShopTimerPC, 1)
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "timeStamp") then
			SetAlpha(self.MyShopTimer, 1)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusLost", function(element)
		if IsPC() then
			SetAlpha(self.MyShopTimerPC, 0)
		else
			SetAlpha(self.MyShopTimer, 0)
		end
	end)
	self:linkToElementModel(self, "revealed", true, function(model)
		local f25_local0 = self
		if IsBooleanDvarSet("loot_sunsetBlackjackShopActive") and not CoD.ModelUtility.IsSelfModelValueNilOrTrue(f25_local0, f1_arg1, "revealed") and CoD.ModelUtility.IsSelfModelValueTrue(f25_local0, f1_arg1, "isInItemShop") then
			CoD.BlackMarketUtility.RevealItemShopSunsetItem(f1_arg0, f25_local0, 1000)
		end
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BMTallItem.__resetProperties = function(f26_arg0)
	f26_arg0.Darken:completeAnimation()
	f26_arg0.NoItemsSunsetText:completeAnimation()
	f26_arg0.NoMyShopOffers:completeAnimation()
	f26_arg0.ReserveTall:completeAnimation()
	f26_arg0.ContractTall:completeAnimation()
	f26_arg0.ShopItemTall:completeAnimation()
	f26_arg0.GlowLarge:completeAnimation()
	f26_arg0.GlowLargeThin:completeAnimation()
	f26_arg0.ShopReserveItemTall:completeAnimation()
	f26_arg0.MysteryItemSilver:completeAnimation()
	f26_arg0.RevealSound:completeAnimation()
	f26_arg0.MysteryItem:completeAnimation()
	f26_arg0.Darken:setAlpha(0)
	f26_arg0.NoItemsSunsetText:setAlpha(0)
	f26_arg0.NoMyShopOffers:setAlpha(0)
	f26_arg0.ReserveTall:setAlpha(1)
	f26_arg0.ContractTall:setAlpha(1)
	f26_arg0.ShopItemTall:setAlpha(1)
	f26_arg0.GlowLarge:setAlpha(0)
	f26_arg0.GlowLarge:setScale(2, 2)
	f26_arg0.GlowLargeThin:setLeftRight(0.5, 0.5, -150, 150)
	f26_arg0.GlowLargeThin:setTopBottom(0.5, 0.5, -40, 40)
	f26_arg0.GlowLargeThin:setAlpha(0)
	f26_arg0.GlowLargeThin:setZRot(4)
	f26_arg0.ShopReserveItemTall:setAlpha(1)
	f26_arg0.MysteryItemSilver:setAlpha(0)
	f26_arg0.MysteryItemSilver:setScale(1, 1)
	f26_arg0.MysteryItem:setAlpha(0)
	f26_arg0.MysteryItem:setScale(1, 1)
end
CoD.BMTallItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.Darken:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
				f28_arg0.Darken:setAlpha(0)
				f28_arg0.Darken:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Darken:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.Darken:completeAnimation()
			f28_arg0.Darken:setAlpha(1)
			f28_local0(f28_arg0.Darken)
		end,
		FadeOut = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.Darken:beginAnimation(500)
				f30_arg0.Darken:setAlpha(1)
				f30_arg0.Darken:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.Darken:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.Darken:completeAnimation()
			f30_arg0.Darken:setAlpha(0)
			f30_local0(f30_arg0.Darken)
		end,
	},
	EmptySunset = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.Darken:completeAnimation()
			f32_arg0.Darken:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.Darken)
			f32_arg0.NoItemsSunsetText:completeAnimation()
			f32_arg0.NoItemsSunsetText:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.NoItemsSunsetText)
		end,
	},
	Empty = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.Darken:completeAnimation()
			f33_arg0.Darken:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.Darken)
			f33_arg0.NoMyShopOffers:completeAnimation()
			f33_arg0.NoMyShopOffers:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.NoMyShopOffers)
		end,
		ChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.Darken:completeAnimation()
			f34_arg0.Darken:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.Darken)
			f34_arg0.NoMyShopOffers:completeAnimation()
			f34_arg0.NoMyShopOffers:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.NoMyShopOffers)
		end,
	},
	MysteryReserveItemSunset = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(7)
			f35_arg0.ContractTall:completeAnimation()
			f35_arg0.ContractTall:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ContractTall)
			f35_arg0.ReserveTall:completeAnimation()
			f35_arg0.ReserveTall:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ReserveTall)
			f35_arg0.ShopReserveItemTall:completeAnimation()
			f35_arg0.ShopReserveItemTall:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ShopReserveItemTall)
			f35_arg0.ShopItemTall:completeAnimation()
			f35_arg0.ShopItemTall:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ShopItemTall)
			f35_arg0.MysteryItemSilver:completeAnimation()
			f35_arg0.MysteryItemSilver:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.MysteryItemSilver)
			f35_arg0.GlowLarge:completeAnimation()
			f35_arg0.GlowLarge:setAlpha(0)
			f35_arg0.GlowLarge:setScale(2, 2)
			f35_arg0.clipFinished(f35_arg0.GlowLarge)
			f35_arg0.GlowLargeThin:completeAnimation()
			f35_arg0.GlowLargeThin:setLeftRight(0.5, 0.5, -150, 150)
			f35_arg0.GlowLargeThin:setTopBottom(0.5, 0.5, -40, 40)
			f35_arg0.GlowLargeThin:setAlpha(0)
			f35_arg0.GlowLargeThin:setZRot(4)
			f35_arg0.clipFinished(f35_arg0.GlowLargeThin)
		end,
		DefaultState = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(8)
			local f36_local0 = function(f37_arg0)
				f36_arg0.ContractTall:beginAnimation(10)
				f36_arg0.ContractTall:setAlpha(1)
				f36_arg0.ContractTall:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.ContractTall:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.ContractTall:completeAnimation()
			f36_arg0.ContractTall:setAlpha(0)
			f36_local0(f36_arg0.ContractTall)
			local f36_local1 = function(f38_arg0)
				f36_arg0.ReserveTall:beginAnimation(10)
				f36_arg0.ReserveTall:setAlpha(1)
				f36_arg0.ReserveTall:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.ReserveTall:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.ReserveTall:completeAnimation()
			f36_arg0.ReserveTall:setAlpha(0)
			f36_local1(f36_arg0.ReserveTall)
			local f36_local2 = function(f39_arg0)
				f36_arg0.ShopReserveItemTall:beginAnimation(10)
				f36_arg0.ShopReserveItemTall:setAlpha(1)
				f36_arg0.ShopReserveItemTall:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.ShopReserveItemTall:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.ShopReserveItemTall:completeAnimation()
			f36_arg0.ShopReserveItemTall:setAlpha(0)
			f36_local2(f36_arg0.ShopReserveItemTall)
			local f36_local3 = function(f40_arg0)
				f36_arg0.ShopItemTall:beginAnimation(10)
				f36_arg0.ShopItemTall:setAlpha(1)
				f36_arg0.ShopItemTall:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.ShopItemTall:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.ShopItemTall:completeAnimation()
			f36_arg0.ShopItemTall:setAlpha(0)
			f36_local3(f36_arg0.ShopItemTall)
			local f36_local4 = function(f41_arg0)
				f36_arg0.MysteryItemSilver:beginAnimation(150)
				f36_arg0.MysteryItemSilver:setAlpha(0)
				f36_arg0.MysteryItemSilver:setScale(2, 2)
				f36_arg0.MysteryItemSilver:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.MysteryItemSilver:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.MysteryItemSilver:completeAnimation()
			f36_arg0.MysteryItemSilver:setAlpha(1)
			f36_arg0.MysteryItemSilver:setScale(1, 1)
			f36_local4(f36_arg0.MysteryItemSilver)
			local f36_local5 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						f44_arg0:beginAnimation(199)
						f44_arg0:setAlpha(0)
						f44_arg0:setScale(4, 4)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
					end
					f43_arg0:beginAnimation(200)
					f43_arg0:setAlpha(1)
					f43_arg0:setScale(3, 3)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f36_arg0.GlowLarge:beginAnimation(50)
				f36_arg0.GlowLarge:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.GlowLarge:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f36_arg0.GlowLarge:completeAnimation()
			f36_arg0.GlowLarge:setAlpha(0)
			f36_arg0.GlowLarge:setScale(2, 2)
			f36_local5(f36_arg0.GlowLarge)
			local f36_local6 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					local f46_local0 = function(f47_arg0)
						f47_arg0:beginAnimation(199)
						f47_arg0:setLeftRight(0.5, 0.5, -500, 500)
						f47_arg0:setTopBottom(0.5, 0.5, -42.5, 42.5)
						f47_arg0:setAlpha(0)
						f47_arg0:setZRot(0)
						f47_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
					end
					f46_arg0:beginAnimation(200)
					f46_arg0:setLeftRight(0.5, 0.5, -400, 400)
					f46_arg0:setTopBottom(0.5, 0.5, -100, 100)
					f46_arg0:setAlpha(1)
					f46_arg0:setZRot(2)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
				end
				f36_arg0.GlowLargeThin:beginAnimation(50)
				f36_arg0.GlowLargeThin:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.GlowLargeThin:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f36_arg0.GlowLargeThin:completeAnimation()
			f36_arg0.GlowLargeThin:setLeftRight(0.5, 0.5, -150, 150)
			f36_arg0.GlowLargeThin:setTopBottom(0.5, 0.5, -40, 40)
			f36_arg0.GlowLargeThin:setAlpha(0)
			f36_arg0.GlowLargeThin:setZRot(4)
			f36_local6(f36_arg0.GlowLargeThin)
			f36_arg0.RevealSound:completeAnimation()
			f36_arg0.RevealSound:playSound("uin_mtx_my_deals", f36_arg1)
			f36_arg0.clipFinished(f36_arg0.RevealSound)
		end,
	},
	MysteryItemSunset = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(7)
			f48_arg0.ContractTall:completeAnimation()
			f48_arg0.ContractTall:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.ContractTall)
			f48_arg0.ReserveTall:completeAnimation()
			f48_arg0.ReserveTall:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.ReserveTall)
			f48_arg0.ShopReserveItemTall:completeAnimation()
			f48_arg0.ShopReserveItemTall:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.ShopReserveItemTall)
			f48_arg0.ShopItemTall:completeAnimation()
			f48_arg0.ShopItemTall:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.ShopItemTall)
			f48_arg0.MysteryItem:completeAnimation()
			f48_arg0.MysteryItem:setAlpha(1)
			f48_arg0.MysteryItem:setScale(1, 1)
			f48_arg0.clipFinished(f48_arg0.MysteryItem)
			f48_arg0.GlowLarge:completeAnimation()
			f48_arg0.GlowLarge:setAlpha(0)
			f48_arg0.GlowLarge:setScale(2, 2)
			f48_arg0.clipFinished(f48_arg0.GlowLarge)
			f48_arg0.GlowLargeThin:completeAnimation()
			f48_arg0.GlowLargeThin:setLeftRight(0.5, 0.5, -150, 150)
			f48_arg0.GlowLargeThin:setTopBottom(0.5, 0.5, -40, 40)
			f48_arg0.GlowLargeThin:setAlpha(0)
			f48_arg0.GlowLargeThin:setZRot(4)
			f48_arg0.clipFinished(f48_arg0.GlowLargeThin)
		end,
		DefaultState = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(8)
			local f49_local0 = function(f50_arg0)
				f49_arg0.ContractTall:beginAnimation(10)
				f49_arg0.ContractTall:setAlpha(1)
				f49_arg0.ContractTall:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.ContractTall:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.ContractTall:completeAnimation()
			f49_arg0.ContractTall:setAlpha(0)
			f49_local0(f49_arg0.ContractTall)
			local f49_local1 = function(f51_arg0)
				f49_arg0.ReserveTall:beginAnimation(10)
				f49_arg0.ReserveTall:setAlpha(1)
				f49_arg0.ReserveTall:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.ReserveTall:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.ReserveTall:completeAnimation()
			f49_arg0.ReserveTall:setAlpha(0)
			f49_local1(f49_arg0.ReserveTall)
			local f49_local2 = function(f52_arg0)
				f49_arg0.ShopReserveItemTall:beginAnimation(10)
				f49_arg0.ShopReserveItemTall:setAlpha(1)
				f49_arg0.ShopReserveItemTall:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.ShopReserveItemTall:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.ShopReserveItemTall:completeAnimation()
			f49_arg0.ShopReserveItemTall:setAlpha(0)
			f49_local2(f49_arg0.ShopReserveItemTall)
			local f49_local3 = function(f53_arg0)
				f49_arg0.ShopItemTall:beginAnimation(10)
				f49_arg0.ShopItemTall:setAlpha(1)
				f49_arg0.ShopItemTall:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.ShopItemTall:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.ShopItemTall:completeAnimation()
			f49_arg0.ShopItemTall:setAlpha(0)
			f49_local3(f49_arg0.ShopItemTall)
			local f49_local4 = function(f54_arg0)
				f49_arg0.MysteryItem:beginAnimation(150)
				f49_arg0.MysteryItem:setAlpha(0)
				f49_arg0.MysteryItem:setScale(2, 2)
				f49_arg0.MysteryItem:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.MysteryItem:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.MysteryItem:completeAnimation()
			f49_arg0.MysteryItem:setAlpha(1)
			f49_arg0.MysteryItem:setScale(1, 1)
			f49_local4(f49_arg0.MysteryItem)
			local f49_local5 = function(f55_arg0)
				local f55_local0 = function(f56_arg0)
					local f56_local0 = function(f57_arg0)
						f57_arg0:beginAnimation(199)
						f57_arg0:setAlpha(0)
						f57_arg0:setScale(4, 4)
						f57_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
					end
					f56_arg0:beginAnimation(200)
					f56_arg0:setAlpha(1)
					f56_arg0:setScale(3, 3)
					f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
				end
				f49_arg0.GlowLarge:beginAnimation(50)
				f49_arg0.GlowLarge:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.GlowLarge:registerEventHandler("transition_complete_keyframe", f55_local0)
			end
			f49_arg0.GlowLarge:completeAnimation()
			f49_arg0.GlowLarge:setAlpha(0)
			f49_arg0.GlowLarge:setScale(2, 2)
			f49_local5(f49_arg0.GlowLarge)
			local f49_local6 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					local f59_local0 = function(f60_arg0)
						f60_arg0:beginAnimation(199)
						f60_arg0:setLeftRight(0.5, 0.5, -500, 500)
						f60_arg0:setTopBottom(0.5, 0.5, -42.5, 42.5)
						f60_arg0:setAlpha(0)
						f60_arg0:setZRot(0)
						f60_arg0:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
					end
					f59_arg0:beginAnimation(200)
					f59_arg0:setLeftRight(0.5, 0.5, -400, 400)
					f59_arg0:setTopBottom(0.5, 0.5, -100, 100)
					f59_arg0:setAlpha(1)
					f59_arg0:setZRot(2)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
				end
				f49_arg0.GlowLargeThin:beginAnimation(50)
				f49_arg0.GlowLargeThin:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.GlowLargeThin:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f49_arg0.GlowLargeThin:completeAnimation()
			f49_arg0.GlowLargeThin:setLeftRight(0.5, 0.5, -150, 150)
			f49_arg0.GlowLargeThin:setTopBottom(0.5, 0.5, -40, 40)
			f49_arg0.GlowLargeThin:setAlpha(0)
			f49_arg0.GlowLargeThin:setZRot(4)
			f49_local6(f49_arg0.GlowLargeThin)
			f49_arg0.RevealSound:completeAnimation()
			f49_arg0.RevealSound:playSound("uin_mtx_my_deals", f49_arg1)
			f49_arg0.clipFinished(f49_arg0.RevealSound)
		end,
	},
	MysteryItem = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(1)
			f61_arg0.MysteryItem:completeAnimation()
			f61_arg0.MysteryItem:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.MysteryItem)
		end,
		DefaultState = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(8)
			local f62_local0 = function(f63_arg0)
				f62_arg0.ContractTall:beginAnimation(10)
				f62_arg0.ContractTall:setAlpha(1)
				f62_arg0.ContractTall:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.ContractTall:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.ContractTall:completeAnimation()
			f62_arg0.ContractTall:setAlpha(0)
			f62_local0(f62_arg0.ContractTall)
			local f62_local1 = function(f64_arg0)
				f62_arg0.ReserveTall:beginAnimation(10)
				f62_arg0.ReserveTall:setAlpha(1)
				f62_arg0.ReserveTall:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.ReserveTall:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.ReserveTall:completeAnimation()
			f62_arg0.ReserveTall:setAlpha(0)
			f62_local1(f62_arg0.ReserveTall)
			local f62_local2 = function(f65_arg0)
				f62_arg0.ShopReserveItemTall:beginAnimation(10)
				f62_arg0.ShopReserveItemTall:setAlpha(1)
				f62_arg0.ShopReserveItemTall:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.ShopReserveItemTall:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.ShopReserveItemTall:completeAnimation()
			f62_arg0.ShopReserveItemTall:setAlpha(0)
			f62_local2(f62_arg0.ShopReserveItemTall)
			local f62_local3 = function(f66_arg0)
				f62_arg0.ShopItemTall:beginAnimation(10)
				f62_arg0.ShopItemTall:setAlpha(1)
				f62_arg0.ShopItemTall:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.ShopItemTall:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.ShopItemTall:completeAnimation()
			f62_arg0.ShopItemTall:setAlpha(0)
			f62_local3(f62_arg0.ShopItemTall)
			local f62_local4 = function(f67_arg0)
				f62_arg0.MysteryItem:beginAnimation(150)
				f62_arg0.MysteryItem:setAlpha(0)
				f62_arg0.MysteryItem:setScale(2, 2)
				f62_arg0.MysteryItem:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.MysteryItem:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
			end
			f62_arg0.MysteryItem:completeAnimation()
			f62_arg0.MysteryItem:setAlpha(1)
			f62_arg0.MysteryItem:setScale(1, 1)
			f62_local4(f62_arg0.MysteryItem)
			local f62_local5 = function(f68_arg0)
				local f68_local0 = function(f69_arg0)
					local f69_local0 = function(f70_arg0)
						f70_arg0:beginAnimation(199)
						f70_arg0:setAlpha(0)
						f70_arg0:setScale(4, 4)
						f70_arg0:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
					end
					f69_arg0:beginAnimation(200)
					f69_arg0:setAlpha(1)
					f69_arg0:setScale(3, 3)
					f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
				end
				f62_arg0.GlowLarge:beginAnimation(50)
				f62_arg0.GlowLarge:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.GlowLarge:registerEventHandler("transition_complete_keyframe", f68_local0)
			end
			f62_arg0.GlowLarge:completeAnimation()
			f62_arg0.GlowLarge:setAlpha(0)
			f62_arg0.GlowLarge:setScale(2, 2)
			f62_local5(f62_arg0.GlowLarge)
			local f62_local6 = function(f71_arg0)
				local f71_local0 = function(f72_arg0)
					local f72_local0 = function(f73_arg0)
						f73_arg0:beginAnimation(199)
						f73_arg0:setLeftRight(0.5, 0.5, -500, 500)
						f73_arg0:setTopBottom(0.5, 0.5, -42.5, 42.5)
						f73_arg0:setAlpha(0)
						f73_arg0:setZRot(0)
						f73_arg0:registerEventHandler("transition_complete_keyframe", f62_arg0.clipFinished)
					end
					f72_arg0:beginAnimation(200)
					f72_arg0:setLeftRight(0.5, 0.5, -400, 400)
					f72_arg0:setTopBottom(0.5, 0.5, -100, 100)
					f72_arg0:setAlpha(1)
					f72_arg0:setZRot(2)
					f72_arg0:registerEventHandler("transition_complete_keyframe", f72_local0)
				end
				f62_arg0.GlowLargeThin:beginAnimation(50)
				f62_arg0.GlowLargeThin:registerEventHandler("interrupted_keyframe", f62_arg0.clipInterrupted)
				f62_arg0.GlowLargeThin:registerEventHandler("transition_complete_keyframe", f71_local0)
			end
			f62_arg0.GlowLargeThin:completeAnimation()
			f62_arg0.GlowLargeThin:setLeftRight(0.5, 0.5, -150, 150)
			f62_arg0.GlowLargeThin:setTopBottom(0.5, 0.5, -40, 40)
			f62_arg0.GlowLargeThin:setAlpha(0)
			f62_arg0.GlowLargeThin:setZRot(4)
			f62_local6(f62_arg0.GlowLargeThin)
			f62_arg0.RevealSound:completeAnimation()
			f62_arg0.RevealSound:playSound("uin_mtx_my_deals", f62_arg1)
			f62_arg0.clipFinished(f62_arg0.RevealSound)
		end,
		ChildFocus = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(1)
			f74_arg0.MysteryItem:completeAnimation()
			f74_arg0.MysteryItem:setAlpha(1)
			f74_arg0.clipFinished(f74_arg0.MysteryItem)
		end,
	},
}
CoD.BMTallItem.__onClose = function(f75_arg0)
	f75_arg0.Backer:close()
	f75_arg0.CommonButtonOutline:close()
	f75_arg0.ContractTall:close()
	f75_arg0.ReserveTall:close()
	f75_arg0.ShopReserveItemTall:close()
	f75_arg0.ShopItemTall:close()
	f75_arg0.MysteryItem:close()
	f75_arg0.MyShopTimer:close()
	f75_arg0.MyShopTimerPC:close()
	f75_arg0.ItemShopDiscountBanner:close()
	f75_arg0.GlowLarge:close()
	f75_arg0.GlowLargeThin:close()
end
