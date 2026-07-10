require("x64:e272191e46af824")
require("x64:5f8cf56752aa71b")
require("x64:e4ab7898d6eef2c")
require("x64:d18f710d30d4ebf")
require("x64:19c1945d2e472b0")
CoD.ReservesBribeStackTall = InheritFrom(LUI.UIElement)
CoD.ReservesBribeStackTall.__defaultWidth = 240
CoD.ReservesBribeStackTall.__defaultHeight = 510
CoD.ReservesBribeStackTall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesBribeStackTall)
	self.id = "ReservesBribeStackTall"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CrateScene = LUI.UIImage.new(0.5, 0.5, -120, 120, 0.5, 0.5, -254, 254)
	CrateScene:linkToElementModel(self, "stackTallImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CrateScene:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(CrateScene)
	self.CrateScene = CrateScene
	local TextBacking2 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -94, 0)
	TextBacking2:setRGB(0, 0, 0)
	TextBacking2:setAlpha(0.95)
	self:addElement(TextBacking2)
	self.TextBacking2 = TextBacking2
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 1, 1, -91, -4)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	DotTiledBacking.TiledShaderImage:setAlpha(0.5)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(32, 32)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local NineSliceBMFrame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	NineSliceBMFrame:setImage(RegisterImage(0x1AC151A09D526DC))
	NineSliceBMFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NineSliceBMFrame:setShaderVector(0, 0, 0, 0, 0)
	NineSliceBMFrame:setupNineSliceShader(162, 52)
	self:addElement(NineSliceBMFrame)
	self.NineSliceBMFrame = NineSliceBMFrame
	local TextBacking = LUI.UIImage.new(0, 0, 6, 236, 0, 0, 11.5, 30.5)
	TextBacking:setRGB(0.89, 0.87, 0.75)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local Title = LUI.UIText.new(0, 0, 15, 236, 0, 0, 12.5, 30.5)
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
	local Price = CoD.ContractItemCostMultiCurrency.new(f1_arg0, f1_arg1, 0, 0, 32, 217, 0, 0, 472, 493)
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
			ItemHintText.textCenterAlign:setText(Engine[0xF9F1239CFD921FE](f8_local0))
		end
	end)
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	local Darken = LUI.UIImage.new(0, 0, 3, 237, 0, 0, 5, 504)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local PurchasedBanner = CoD.ContractPurchasedBanner.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 1, 1, -46, -21)
	PurchasedBanner:setAlpha(0)
	PurchasedBanner.PurchasedTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(PurchasedBanner)
	self.PurchasedBanner = PurchasedBanner
	local TabBottomLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -96, -92)
	TabBottomLine:setAlpha(0.09)
	TabBottomLine:setImage(RegisterImage(0x5526CF3733E24C4))
	TabBottomLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	self:mergeStateConditions({
		{
			stateName = "NotPurchased",
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
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesBribeStackTall.__resetProperties = function(f11_arg0)
	f11_arg0.PurchasedBanner:completeAnimation()
	f11_arg0.Darken:completeAnimation()
	f11_arg0.Price:completeAnimation()
	f11_arg0.ItemHintText:completeAnimation()
	f11_arg0.PurchasedBanner:setAlpha(0)
	f11_arg0.Darken:setAlpha(0)
	f11_arg0.Price:setAlpha(1)
	f11_arg0.ItemHintText:setAlpha(0)
end
CoD.ReservesBribeStackTall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.Price:completeAnimation()
			f12_arg0.Price:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Price)
			f12_arg0.Darken:completeAnimation()
			f12_arg0.Darken:setAlpha(0.7)
			f12_arg0.clipFinished(f12_arg0.Darken)
			f12_arg0.PurchasedBanner:completeAnimation()
			f12_arg0.PurchasedBanner:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.PurchasedBanner)
		end,
		ChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.Price:completeAnimation()
			f13_arg0.Price:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Price)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(199)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.ItemHintText:beginAnimation(10000)
				f13_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.ItemHintText:completeAnimation()
			f13_arg0.ItemHintText:setAlpha(1)
			f13_local0(f13_arg0.ItemHintText)
			f13_arg0.Darken:completeAnimation()
			f13_arg0.Darken:setAlpha(0.7)
			f13_arg0.clipFinished(f13_arg0.Darken)
			f13_arg0.PurchasedBanner:completeAnimation()
			f13_arg0.PurchasedBanner:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.PurchasedBanner)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.Price:completeAnimation()
			f16_arg0.Price:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Price)
			local f16_local0 = function(f17_arg0)
				f16_arg0.ItemHintText:beginAnimation(200)
				f16_arg0.ItemHintText:setAlpha(1)
				f16_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.ItemHintText:completeAnimation()
			f16_arg0.ItemHintText:setAlpha(0)
			f16_local0(f16_arg0.ItemHintText)
			f16_arg0.Darken:completeAnimation()
			f16_arg0.Darken:setAlpha(0.7)
			f16_arg0.clipFinished(f16_arg0.Darken)
			f16_arg0.PurchasedBanner:completeAnimation()
			f16_arg0.PurchasedBanner:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.PurchasedBanner)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.Price:completeAnimation()
			f18_arg0.Price:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Price)
			f18_arg0.Darken:completeAnimation()
			f18_arg0.Darken:setAlpha(0.7)
			f18_arg0.clipFinished(f18_arg0.Darken)
			f18_arg0.PurchasedBanner:completeAnimation()
			f18_arg0.PurchasedBanner:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.PurchasedBanner)
		end,
	},
	NotPurchased = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(199)
					f22_arg0:setAlpha(0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.ItemHintText:beginAnimation(10000)
				f20_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.ItemHintText:completeAnimation()
			f20_arg0.ItemHintText:setAlpha(1)
			f20_local0(f20_arg0.ItemHintText)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.ItemHintText:beginAnimation(200)
				f23_arg0.ItemHintText:setAlpha(1)
				f23_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.ItemHintText:completeAnimation()
			f23_arg0.ItemHintText:setAlpha(0)
			f23_local0(f23_arg0.ItemHintText)
		end,
	},
}
CoD.ReservesBribeStackTall.__onClose = function(f25_arg0)
	f25_arg0.CrateScene:close()
	f25_arg0.DotTiledBacking:close()
	f25_arg0.CommonButtonOutline:close()
	f25_arg0.Title:close()
	f25_arg0.Price:close()
	f25_arg0.ItemHintText:close()
	f25_arg0.PurchasedBanner:close()
end
