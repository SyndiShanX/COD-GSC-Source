require("x64:b91a4a0888680f8")
require("x64:c436463942f5d92")
CoD.StreamLevel = InheritFrom(LUI.UIElement)
CoD.StreamLevel.__defaultWidth = 140
CoD.StreamLevel.__defaultHeight = 80
CoD.StreamLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StreamLevel)
	self.id = "StreamLevel"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 140, 0, 0, 17, 76)
	Background:setRGB(0.11, 0.18, 0.24)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	Background:setShaderVector(0, 1, 0, 0, 0)
	Background:setShaderVector(1, 0, 0, 0, 0)
	Background:setShaderVector(2, 1, 0, 0, 0)
	Background:setShaderVector(3, 0, 0, 0, 0)
	Background:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 140, 0.09, 0.09, 10, 69)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Gradient = LUI.UIImage.new(0, 0, 0, 140, 0, 0, 17, 73)
	Gradient:setRGB(0.08, 0.21, 0.31)
	Gradient:setAlpha(0.94)
	Gradient:setImage(RegisterImage(@"uie_ui_menu_common_gradient"))
	Gradient:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Gradient)
	self.Gradient = Gradient
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 0.74, 17, 17)
	TiledShaderImage:setRGB(0, 0, 0)
	TiledShaderImage:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local TiledShaderImage2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0.74, 17, 17)
	TiledShaderImage2:setRGB(0, 0, 0)
	TiledShaderImage2:setAlpha(0.7)
	TiledShaderImage2:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage2:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage2:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage2)
	self.TiledShaderImage2 = TiledShaderImage2
	local bar = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 72, 76)
	bar:setRGB(0.17, 0.17, 0.18)
	bar:setAlpha(0)
	self:addElement(bar)
	self.bar = bar
	local bar2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 17, 21)
	bar2:setRGB(0.17, 0.17, 0.18)
	bar2:setAlpha(0)
	self:addElement(bar2)
	self.bar2 = bar2
	local TileableLinePattern01 = LUI.UIImage.new(0, 0, 0, 140, 0, 0, 72, 76)
	TileableLinePattern01:setRGB(0.23, 0.23, 0.25)
	TileableLinePattern01:setAlpha(0)
	TileableLinePattern01:setImage(RegisterImage(@"uie_hud_common_stripe_pattern01"))
	TileableLinePattern01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TileableLinePattern01:setShaderVector(0, 0, 0, 0, 0)
	TileableLinePattern01:setupNineSliceShader(24, 12)
	self:addElement(TileableLinePattern01)
	self.TileableLinePattern01 = TileableLinePattern01
	local TileableLinePattern = LUI.UIImage.new(0, 0, 0, 140, 0, 0, 17, 21)
	TileableLinePattern:setRGB(0.23, 0.23, 0.25)
	TileableLinePattern:setAlpha(0)
	TileableLinePattern:setImage(RegisterImage(@"uie_hud_common_stripe_pattern01"))
	TileableLinePattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TileableLinePattern:setShaderVector(0, 0, 0, 0, 0)
	TileableLinePattern:setupNineSliceShader(24, 12)
	self:addElement(TileableLinePattern)
	self.TileableLinePattern = TileableLinePattern
	local TextBox = LUI.UIText.new(0.5, 0.5, -70, 70, 0.5, 0.5, -5.5, 18.5)
	TextBox:setRGB(0.95, 0.95, 0.95)
	TextBox:setTTF("ttmussels_demibold")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	TextBox:setShaderVector(0, 1, 0, 0, 0)
	TextBox:setShaderVector(1, 0, 0, 0, 0)
	TextBox:setShaderVector(2, 0, 0.37, 1, 0.3)
	TextBox:setLetterSpacing(2)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TextBox:linkToElementModel(self, "tier", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(f2_local0)
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	local PurchaseHighlight = CoD.PurchaseHighlight.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, -2, 18)
	PurchaseHighlight:linkToElementModel(self, nil, false, function(model)
		PurchaseHighlight:setModel(model, f1_arg1)
	end)
	self:addElement(PurchaseHighlight)
	self.PurchaseHighlight = PurchaseHighlight
	local Border = LUI.UIImage.new(0, 0, 0, 140, 0, 0, 17, 76)
	Border:setRGB(0.54, 0.48, 0.27)
	Border:setAlpha(0)
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3E7BDCB879A5176D"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setShaderVector(1, 0, 0, 0, 0)
	Border:setupNineSliceShader(1, 1)
	self:addElement(Border)
	self.Border = Border
	local StreamLevelGlow = CoD.StreamLevelGlow.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 17, 76)
	StreamLevelGlow:setAlpha(0)
	self:addElement(StreamLevelGlow)
	self.StreamLevelGlow = StreamLevelGlow
	local GlowBorder = LUI.UIImage.new(0.02, 0.98, -31.5, 30.5, 0.05, 0.94, -9.5, 22.5)
	GlowBorder:setRGB(0.29, 0.48, 0.62)
	GlowBorder:setAlpha(0)
	GlowBorder:setImage(RegisterImage(@"uie_ui_menu_item_shop_glow_border"))
	GlowBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	GlowBorder:setShaderVector(0, 0, 0, 0, 0)
	GlowBorder:setupNineSliceShader(70, 70)
	self:addElement(GlowBorder)
	self.GlowBorder = GlowBorder
	local GlowBorder2 = LUI.UIImage.new(0.02, 0.98, -8.5, 7.5, 0.05, 0.94, 7.5, 5.5)
	GlowBorder2:setRGB(0.89, 0.98, 0.99)
	GlowBorder2:setAlpha(0)
	GlowBorder2:setImage(RegisterImage(@"uie_ui_menu_item_shop_glow_border"))
	GlowBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	GlowBorder2:setShaderVector(0, 0, 0, 0, 0)
	GlowBorder2:setupNineSliceShader(12, 12)
	self:addElement(GlowBorder2)
	self.GlowBorder2 = GlowBorder2
	self:mergeStateConditions({
		{
			stateName = "LockedSelected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected") and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
			end,
		},
		{
			stateName = "ToPurchase",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "toPurchase") and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
			end,
		},
		{
			stateName = "PostSeason",
			condition = function(menu, element, event)
				local f6_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked") then
					f6_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "tier", CoD.BlackMarketUtility.GetCurrentSeasonMaxTiers())
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "unlocked")
			end,
		},
		{
			stateName = "UnlockedRecentlySelected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "recentlyUnlocked") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected")
			end,
		},
		{
			stateName = "UnlockedSelected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected")
			end,
		},
		{
			stateName = "UnlockedRecently",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "recentlyUnlocked")
			end,
		},
	})
	self:linkToElementModel(self, "selected", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
		})
	end)
	self:linkToElementModel(self, "unlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	self:linkToElementModel(self, "toPurchase", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "toPurchase",
		})
	end)
	self:linkToElementModel(self, "tier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tier",
		})
	end)
	self:linkToElementModel(self, "recentlyUnlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "recentlyUnlocked",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StreamLevel.__resetProperties = function(f16_arg0)
	f16_arg0.Background:completeAnimation()
	f16_arg0.TextBox:completeAnimation()
	f16_arg0.TileableLinePattern01:completeAnimation()
	f16_arg0.TileableLinePattern:completeAnimation()
	f16_arg0.Gradient:completeAnimation()
	f16_arg0.TiledShaderImage:completeAnimation()
	f16_arg0.TiledShaderImage2:completeAnimation()
	f16_arg0.NoiseTiledBacking:completeAnimation()
	f16_arg0.bar2:completeAnimation()
	f16_arg0.bar:completeAnimation()
	f16_arg0.Border:completeAnimation()
	f16_arg0.StreamLevelGlow:completeAnimation()
	f16_arg0.GlowBorder:completeAnimation()
	f16_arg0.GlowBorder2:completeAnimation()
	f16_arg0.Background:setRGB(0.11, 0.18, 0.24)
	f16_arg0.TextBox:setRGB(0.95, 0.95, 0.95)
	f16_arg0.TextBox:setShaderVector(0, 1, 0, 0, 0)
	f16_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
	f16_arg0.TextBox:setShaderVector(2, 0, 0.37, 1, 0.3)
	f16_arg0.TileableLinePattern01:setRGB(0.23, 0.23, 0.25)
	f16_arg0.TileableLinePattern01:setAlpha(0)
	f16_arg0.TileableLinePattern:setRGB(0.23, 0.23, 0.25)
	f16_arg0.TileableLinePattern:setAlpha(0)
	f16_arg0.Gradient:setRGB(0.08, 0.21, 0.31)
	f16_arg0.Gradient:setAlpha(0.94)
	f16_arg0.TiledShaderImage:setAlpha(1)
	f16_arg0.TiledShaderImage2:setAlpha(0.7)
	f16_arg0.NoiseTiledBacking:setAlpha(0)
	f16_arg0.bar2:setRGB(0.17, 0.17, 0.18)
	f16_arg0.bar2:setAlpha(0)
	f16_arg0.bar:setRGB(0.17, 0.17, 0.18)
	f16_arg0.bar:setAlpha(0)
	f16_arg0.Border:setRGB(0.54, 0.48, 0.27)
	f16_arg0.Border:setAlpha(0)
	f16_arg0.StreamLevelGlow:setAlpha(0)
	f16_arg0.GlowBorder:setAlpha(0)
	f16_arg0.GlowBorder2:setAlpha(0)
end
CoD.StreamLevel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.Background:completeAnimation()
			f17_arg0.Background:setRGB(0.11, 0.18, 0.24)
			f17_arg0.clipFinished(f17_arg0.Background)
		end,
	},
	LockedSelected = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(11)
			f18_arg0.Background:completeAnimation()
			f18_arg0.Background:setRGB(0.57, 0.51, 0.44)
			f18_arg0.clipFinished(f18_arg0.Background)
			f18_arg0.NoiseTiledBacking:completeAnimation()
			f18_arg0.NoiseTiledBacking:setAlpha(0.5)
			f18_arg0.clipFinished(f18_arg0.NoiseTiledBacking)
			f18_arg0.Gradient:completeAnimation()
			f18_arg0.Gradient:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Gradient)
			f18_arg0.TiledShaderImage:completeAnimation()
			f18_arg0.TiledShaderImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.TiledShaderImage)
			f18_arg0.TiledShaderImage2:completeAnimation()
			f18_arg0.TiledShaderImage2:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.TiledShaderImage2)
			f18_arg0.bar:completeAnimation()
			f18_arg0.bar:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.bar)
			f18_arg0.bar2:completeAnimation()
			f18_arg0.bar2:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.bar2)
			f18_arg0.TileableLinePattern01:completeAnimation()
			f18_arg0.TileableLinePattern01:setRGB(0.42, 0.38, 0.32)
			f18_arg0.TileableLinePattern01:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.TileableLinePattern01)
			f18_arg0.TileableLinePattern:completeAnimation()
			f18_arg0.TileableLinePattern:setRGB(0.42, 0.38, 0.32)
			f18_arg0.TileableLinePattern:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.TileableLinePattern)
			f18_arg0.TextBox:completeAnimation()
			f18_arg0.TextBox:setRGB(0.98, 0.91, 0.48)
			f18_arg0.TextBox:setShaderVector(0, 1, 0, 0, 0)
			f18_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
			f18_arg0.TextBox:setShaderVector(2, 1, 0.1, 0, 0.6)
			f18_arg0.clipFinished(f18_arg0.TextBox)
			f18_arg0.Border:completeAnimation()
			f18_arg0.Border:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Border)
		end,
	},
	ToPurchase = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(11)
			f19_arg0.Background:completeAnimation()
			f19_arg0.Background:setRGB(0.42, 0.38, 0.32)
			f19_arg0.clipFinished(f19_arg0.Background)
			f19_arg0.NoiseTiledBacking:completeAnimation()
			f19_arg0.NoiseTiledBacking:setAlpha(0.5)
			f19_arg0.clipFinished(f19_arg0.NoiseTiledBacking)
			f19_arg0.Gradient:completeAnimation()
			f19_arg0.Gradient:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Gradient)
			f19_arg0.TiledShaderImage:completeAnimation()
			f19_arg0.TiledShaderImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TiledShaderImage)
			f19_arg0.TiledShaderImage2:completeAnimation()
			f19_arg0.TiledShaderImage2:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TiledShaderImage2)
			f19_arg0.bar:completeAnimation()
			f19_arg0.bar:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.bar)
			f19_arg0.bar2:completeAnimation()
			f19_arg0.bar2:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.bar2)
			f19_arg0.TileableLinePattern01:completeAnimation()
			f19_arg0.TileableLinePattern01:setRGB(0.42, 0.38, 0.32)
			f19_arg0.TileableLinePattern01:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.TileableLinePattern01)
			f19_arg0.TileableLinePattern:completeAnimation()
			f19_arg0.TileableLinePattern:setRGB(0.42, 0.38, 0.32)
			f19_arg0.TileableLinePattern:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.TileableLinePattern)
			f19_arg0.TextBox:completeAnimation()
			f19_arg0.TextBox:setRGB(0.98, 0.91, 0.48)
			f19_arg0.TextBox:setShaderVector(0, 1, 0, 0, 0)
			f19_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
			f19_arg0.TextBox:setShaderVector(2, 1, 0.1, 0, 0.6)
			f19_arg0.clipFinished(f19_arg0.TextBox)
			f19_arg0.Border:completeAnimation()
			f19_arg0.Border:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Border)
		end,
	},
	PostSeason = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(11)
			f20_arg0.Background:completeAnimation()
			f20_arg0.Background:setRGB(0.22, 0.25, 0.29)
			f20_arg0.clipFinished(f20_arg0.Background)
			f20_arg0.NoiseTiledBacking:completeAnimation()
			f20_arg0.NoiseTiledBacking:setAlpha(0.47)
			f20_arg0.clipFinished(f20_arg0.NoiseTiledBacking)
			f20_arg0.Gradient:completeAnimation()
			f20_arg0.Gradient:setRGB(0.08, 0.28, 0.31)
			f20_arg0.Gradient:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Gradient)
			f20_arg0.TiledShaderImage:completeAnimation()
			f20_arg0.TiledShaderImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.TiledShaderImage)
			f20_arg0.TiledShaderImage2:completeAnimation()
			f20_arg0.TiledShaderImage2:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.TiledShaderImage2)
			f20_arg0.bar:completeAnimation()
			f20_arg0.bar:setRGB(0.01, 0.14, 0.19)
			f20_arg0.bar:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.bar)
			f20_arg0.bar2:completeAnimation()
			f20_arg0.bar2:setRGB(0.01, 0.14, 0.19)
			f20_arg0.bar2:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.bar2)
			f20_arg0.TileableLinePattern01:completeAnimation()
			f20_arg0.TileableLinePattern01:setRGB(0.12, 0.35, 0.39)
			f20_arg0.TileableLinePattern01:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.TileableLinePattern01)
			f20_arg0.TileableLinePattern:completeAnimation()
			f20_arg0.TileableLinePattern:setRGB(0.12, 0.35, 0.39)
			f20_arg0.TileableLinePattern:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.TileableLinePattern)
			f20_arg0.TextBox:completeAnimation()
			f20_arg0.TextBox:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f20_arg0.TextBox:setShaderVector(0, 1, 0, 0, 0)
			f20_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
			f20_arg0.TextBox:setShaderVector(2, 0, 0.63, 1, 0.1)
			f20_arg0.clipFinished(f20_arg0.TextBox)
			f20_arg0.Border:completeAnimation()
			f20_arg0.Border:setRGB(0, 0.76, 1)
			f20_arg0.Border:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Border)
		end,
	},
	Locked = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(10)
			f21_arg0.Background:completeAnimation()
			f21_arg0.Background:setRGB(0.24, 0.24, 0.26)
			f21_arg0.clipFinished(f21_arg0.Background)
			f21_arg0.NoiseTiledBacking:completeAnimation()
			f21_arg0.NoiseTiledBacking:setAlpha(0.5)
			f21_arg0.clipFinished(f21_arg0.NoiseTiledBacking)
			f21_arg0.Gradient:completeAnimation()
			f21_arg0.Gradient:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Gradient)
			f21_arg0.TiledShaderImage:completeAnimation()
			f21_arg0.TiledShaderImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TiledShaderImage)
			f21_arg0.TiledShaderImage2:completeAnimation()
			f21_arg0.TiledShaderImage2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TiledShaderImage2)
			f21_arg0.bar:completeAnimation()
			f21_arg0.bar:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.bar)
			f21_arg0.bar2:completeAnimation()
			f21_arg0.bar2:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.bar2)
			f21_arg0.TileableLinePattern01:completeAnimation()
			f21_arg0.TileableLinePattern01:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.TileableLinePattern01)
			f21_arg0.TileableLinePattern:completeAnimation()
			f21_arg0.TileableLinePattern:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.TileableLinePattern)
			f21_arg0.TextBox:completeAnimation()
			f21_arg0.TextBox:setRGB(0.54, 0.56, 0.58)
			f21_arg0.TextBox:setShaderVector(0, 0.8, 0, 0, 0)
			f21_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
			f21_arg0.TextBox:setShaderVector(2, 1, 1, 1, 0)
			f21_arg0.clipFinished(f21_arg0.TextBox)
		end,
	},
	UnlockedRecentlySelected = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.Background:completeAnimation()
			f22_arg0.Background:setRGB(0.22, 0.33, 0.44)
			f22_arg0.clipFinished(f22_arg0.Background)
			f22_arg0.TextBox:completeAnimation()
			f22_arg0.TextBox:setRGB(0.95, 0.95, 0.95)
			f22_arg0.TextBox:setShaderVector(0, 1, 0, 0, 0)
			f22_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
			f22_arg0.TextBox:setShaderVector(2, 0, 0.37, 1, 0.3)
			f22_arg0.clipFinished(f22_arg0.TextBox)
			f22_arg0.StreamLevelGlow:completeAnimation()
			f22_arg0.StreamLevelGlow:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.StreamLevelGlow)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(1500)
					f24_arg0:setAlpha(0.2)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.GlowBorder:beginAnimation(1500)
				f22_arg0.GlowBorder:setAlpha(1)
				f22_arg0.GlowBorder:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.GlowBorder:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.GlowBorder:completeAnimation()
			f22_arg0.GlowBorder:setAlpha(0.2)
			f22_local0(f22_arg0.GlowBorder)
			local f22_local1 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(1500)
					f26_arg0:setAlpha(0.2)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.GlowBorder2:beginAnimation(1500)
				f22_arg0.GlowBorder2:setAlpha(1)
				f22_arg0.GlowBorder2:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.GlowBorder2:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f22_arg0.GlowBorder2:completeAnimation()
			f22_arg0.GlowBorder2:setAlpha(0.2)
			f22_local1(f22_arg0.GlowBorder2)
			f22_arg0.nextClip = "DefaultClip"
		end,
	},
	UnlockedSelected = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.Background:completeAnimation()
			f27_arg0.Background:setRGB(0.22, 0.33, 0.44)
			f27_arg0.clipFinished(f27_arg0.Background)
		end,
	},
	UnlockedRecently = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.Background:completeAnimation()
			f28_arg0.Background:setRGB(0.11, 0.18, 0.24)
			f28_arg0.clipFinished(f28_arg0.Background)
			f28_arg0.TextBox:completeAnimation()
			f28_arg0.TextBox:setRGB(0.95, 0.95, 0.95)
			f28_arg0.TextBox:setShaderVector(0, 1, 0, 0, 0)
			f28_arg0.TextBox:setShaderVector(1, 0, 0, 0, 0)
			f28_arg0.TextBox:setShaderVector(2, 0, 0.37, 1, 0.3)
			f28_arg0.clipFinished(f28_arg0.TextBox)
			f28_arg0.StreamLevelGlow:completeAnimation()
			f28_arg0.StreamLevelGlow:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.StreamLevelGlow)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(1500)
					f30_arg0:setAlpha(0.2)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.GlowBorder:beginAnimation(1500)
				f28_arg0.GlowBorder:setAlpha(1)
				f28_arg0.GlowBorder:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.GlowBorder:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.GlowBorder:completeAnimation()
			f28_arg0.GlowBorder:setAlpha(0.2)
			f28_local0(f28_arg0.GlowBorder)
			local f28_local1 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(1500)
					f32_arg0:setAlpha(0.2)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.GlowBorder2:beginAnimation(1500)
				f28_arg0.GlowBorder2:setAlpha(1)
				f28_arg0.GlowBorder2:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.GlowBorder2:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f28_arg0.GlowBorder2:completeAnimation()
			f28_arg0.GlowBorder2:setAlpha(0.2)
			f28_local1(f28_arg0.GlowBorder2)
			f28_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.StreamLevel.__onClose = function(f33_arg0)
	f33_arg0.TextBox:close()
	f33_arg0.PurchaseHighlight:close()
	f33_arg0.StreamLevelGlow:close()
end
