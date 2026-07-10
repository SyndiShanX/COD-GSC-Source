require("x64:c96de52191fe142")
require("x64:5f8cf56752aa71b")
require("x64:19c1945d2e472b0")
CoD.DirectorBlackMarketButtonInternal_v2 = InheritFrom(LUI.UIElement)
CoD.DirectorBlackMarketButtonInternal_v2.__defaultWidth = 354
CoD.DirectorBlackMarketButtonInternal_v2.__defaultHeight = 110
CoD.DirectorBlackMarketButtonInternal_v2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorBlackMarketButtonInternal_v2)
	self.id = "DirectorBlackMarketButtonInternal_v2"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local BgTint = LUI.UIImage.new(0, 1, 4, -4, 0, 0, 3.5, 105.5)
	BgTint:setRGB(0, 0, 0)
	BgTint:setAlpha(0.5)
	self:addElement(BgTint)
	self.BgTint = BgTint
	local BgTintAll = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgTintAll:setRGB(0, 0, 0)
	BgTintAll:setAlpha(0.2)
	self:addElement(BgTintAll)
	self.BgTintAll = BgTintAll
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 0, 3.5, 105.5)
	DotTiledBacking.NoiseBacking:setAlpha(0.9)
	DotTiledBacking.TiledShaderImage:setAlpha(0.3)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local DotTiledBackingTop = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0.5, 1.5, -221, -229, 0, 0, 4, 30)
	DotTiledBackingTop.NoiseBacking:setAlpha(0)
	DotTiledBackingTop.TiledShaderImage:setAlpha(0.2)
	DotTiledBackingTop.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBackingTop)
	self.DotTiledBackingTop = DotTiledBackingTop
	local SpecialEventBanner = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	SpecialEventBanner.__Image = function()
		SpecialEventBanner:setImage(RegisterImage(CoD.BlackMarketUtility.GetCurrentBlackMarketBannerImage(@"blacktransparent")))
	end
	SpecialEventBanner.__Image()
	self:addElement(SpecialEventBanner)
	self.SpecialEventBanner = SpecialEventBanner
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.01, 0.99, 1, -1)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local LootCaseMeter = CoD.AARTierRewardLootCaseMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0.5, 0.5, -75, 75)
	LootCaseMeter:setScale(0.5, 0.5)
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
			LootCaseMeter.CaseCount:setText(SetValueIfNumberEqualTo(-1, "-", f4_local0))
		end
	end)
	self:addElement(LootCaseMeter)
	self.LootCaseMeter = LootCaseMeter
	local f1_local9 = SpecialEventBanner
	local f1_local10 = SpecialEventBanner.subscribeToModel
	local f1_local11 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.cycled, SpecialEventBanner.__Image)
	self:mergeStateConditions({
		{
			stateName = "DefaultStateAsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorBlackMarketButtonInternal_v2.__resetProperties = function(f6_arg0)
	f6_arg0.CommonButtonOutline:completeAnimation()
	f6_arg0.CommonButtonOutline:setAlpha(1)
end
CoD.DirectorBlackMarketButtonInternal_v2.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.CommonButtonOutline:completeAnimation()
			f8_arg0.CommonButtonOutline:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.CommonButtonOutline)
		end,
	},
	DefaultStateAsianLanguage = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.CommonButtonOutline:completeAnimation()
			f10_arg0.CommonButtonOutline:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.CommonButtonOutline)
		end,
	},
}
CoD.DirectorBlackMarketButtonInternal_v2.__onClose = function(f11_arg0)
	f11_arg0.DotTiledBacking:close()
	f11_arg0.DotTiledBackingTop:close()
	f11_arg0.SpecialEventBanner:close()
	f11_arg0.CommonButtonOutline:close()
	f11_arg0.LootCaseMeter:close()
end
