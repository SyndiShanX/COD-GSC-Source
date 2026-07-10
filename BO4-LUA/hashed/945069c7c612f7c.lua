require("x64:62407f124c5a6f8")
CoD.SetBonusWidget = InheritFrom(LUI.UIElement)
CoD.SetBonusWidget.__defaultWidth = 128
CoD.SetBonusWidget.__defaultHeight = 216
CoD.SetBonusWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SetBonusWidget)
	self.id = "SetBonusWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image2 = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 32.5, 146.5)
	Image2:setRGB(0.25, 0.27, 0.32)
	Image2:setAlpha(0.09)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 144.5, 166.5)
	Image:setRGB(0.34, 0.49, 0.15)
	self:addElement(Image)
	self.Image = Image
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 144.5, 166.5)
	PixelGridTiledBacking:setAlpha(0.05)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local BonusText = LUI.UIText.new(0, 0, 4, 125, 0, 0, 147, 163)
	BonusText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BonusText:setText(LocalizeToUpperString(0xCD7217889FE44B))
	BonusText:setTTF("default")
	BonusText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	BonusText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(BonusText)
	self.BonusText = BonusText
	local Complete = LUI.UIText.new(0, 0, 4, 122, -0.04, -0.04, 181, 196)
	Complete:setRGB(0.44, 0.67, 0.12)
	Complete:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/set_complete"))
	Complete:setTTF("default")
	Complete:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Complete)
	self.Complete = Complete
	local Incomplete = LUI.UIText.new(-0, -0, 4, 120, -0.03, -0.03, 179, 194)
	Incomplete:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Incomplete:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/set_incomplete"))
	Incomplete:setTTF("default")
	Incomplete:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Incomplete:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Incomplete)
	self.Incomplete = Incomplete
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 128, 0, 0, 32, 142)
	FixedAspectRatioImage:setStretchedDimension(6)
	FixedAspectRatioImage:linkToElementModel(self, "setBonusImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	local CallingCardImage = CoD.CallingCardImage.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 13.5, 160.5)
	CallingCardImage:linkToElementModel(self, nil, false, function(model)
		CallingCardImage:setModel(model, f1_arg1)
	end)
	CallingCardImage:linkToElementModel(self, "setBonusImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CallingCardImage.Image:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(CallingCardImage)
	self.CallingCardImage = CallingCardImage
	local HeaderGlow = LUI.UIImage.new(0, 0, -5, 132, 0, 0, 140, 171)
	HeaderGlow:setRGB(0.42, 0.64, 0.28)
	HeaderGlow:setAlpha(0.1)
	HeaderGlow:setImage(RegisterImage(@"uie_ui_menu_common_box_glow"))
	HeaderGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	HeaderGlow:setShaderVector(0, 0, 0, 0, 0)
	HeaderGlow:setupNineSliceShader(12, 12)
	self:addElement(HeaderGlow)
	self.HeaderGlow = HeaderGlow
	self:mergeStateConditions({
		{
			stateName = "SetIncomplete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "setBonusImage") and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "setComplete")
			end,
		},
		{
			stateName = "SetComplete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "setBonusImage") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "setComplete")
			end,
		},
	})
	self:linkToElementModel(self, "setBonusImage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "setBonusImage",
		})
	end)
	self:linkToElementModel(self, "setComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "setComplete",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SetBonusWidget.__resetProperties = function(f9_arg0)
	f9_arg0.Image:completeAnimation()
	f9_arg0.BonusText:completeAnimation()
	f9_arg0.Complete:completeAnimation()
	f9_arg0.FixedAspectRatioImage:completeAnimation()
	f9_arg0.Incomplete:completeAnimation()
	f9_arg0.Image2:completeAnimation()
	f9_arg0.PixelGridTiledBacking:completeAnimation()
	f9_arg0.HeaderGlow:completeAnimation()
	f9_arg0.CallingCardImage:completeAnimation()
	f9_arg0.Image:setRGB(0.34, 0.49, 0.15)
	f9_arg0.Image:setAlpha(1)
	f9_arg0.BonusText:setAlpha(1)
	f9_arg0.Complete:setAlpha(1)
	f9_arg0.FixedAspectRatioImage:setAlpha(1)
	f9_arg0.Incomplete:setAlpha(1)
	f9_arg0.Image2:setAlpha(0.09)
	f9_arg0.PixelGridTiledBacking:setAlpha(0.05)
	f9_arg0.HeaderGlow:setAlpha(0.1)
	f9_arg0.CallingCardImage:setAlpha(1)
end
CoD.SetBonusWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(9)
			f10_arg0.Image2:completeAnimation()
			f10_arg0.Image2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image2)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image)
			f10_arg0.PixelGridTiledBacking:completeAnimation()
			f10_arg0.PixelGridTiledBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PixelGridTiledBacking)
			f10_arg0.BonusText:completeAnimation()
			f10_arg0.BonusText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BonusText)
			f10_arg0.Complete:completeAnimation()
			f10_arg0.Complete:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Complete)
			f10_arg0.Incomplete:completeAnimation()
			f10_arg0.Incomplete:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Incomplete)
			f10_arg0.FixedAspectRatioImage:completeAnimation()
			f10_arg0.FixedAspectRatioImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FixedAspectRatioImage)
			f10_arg0.CallingCardImage:completeAnimation()
			f10_arg0.CallingCardImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CallingCardImage)
			f10_arg0.HeaderGlow:completeAnimation()
			f10_arg0.HeaderGlow:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.HeaderGlow)
		end,
	},
	SetIncomplete = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			f11_arg0.Image:completeAnimation()
			f11_arg0.Image:setRGB(0.25, 0.27, 0.32)
			f11_arg0.Image:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Image)
			f11_arg0.BonusText:completeAnimation()
			f11_arg0.BonusText:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.BonusText)
			f11_arg0.Complete:completeAnimation()
			f11_arg0.Complete:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Complete)
			f11_arg0.Incomplete:completeAnimation()
			f11_arg0.Incomplete:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Incomplete)
			f11_arg0.FixedAspectRatioImage:completeAnimation()
			f11_arg0.FixedAspectRatioImage:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FixedAspectRatioImage)
			f11_arg0.HeaderGlow:completeAnimation()
			f11_arg0.HeaderGlow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.HeaderGlow)
		end,
	},
	SetComplete = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			f12_arg0.Image:completeAnimation()
			f12_arg0.Image:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Image)
			f12_arg0.BonusText:completeAnimation()
			f12_arg0.BonusText:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.BonusText)
			f12_arg0.Complete:completeAnimation()
			f12_arg0.Complete:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Complete)
			f12_arg0.Incomplete:completeAnimation()
			f12_arg0.Incomplete:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Incomplete)
			f12_arg0.FixedAspectRatioImage:completeAnimation()
			f12_arg0.FixedAspectRatioImage:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.FixedAspectRatioImage)
		end,
	},
}
CoD.SetBonusWidget.__onClose = function(f13_arg0)
	f13_arg0.FixedAspectRatioImage:close()
	f13_arg0.CallingCardImage:close()
end
