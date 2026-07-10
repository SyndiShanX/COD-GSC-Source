CoD.StreamItemBonusWidget = InheritFrom(LUI.UIElement)
CoD.StreamItemBonusWidget.__defaultWidth = 138
CoD.StreamItemBonusWidget.__defaultHeight = 30
CoD.StreamItemBonusWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StreamItemBonusWidget)
	self.id = "StreamItemBonusWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 138, 0, 0, 4, 26)
	Background:setRGB(0.34, 0.49, 0.15)
	self:addElement(Background)
	self.Background = Background
	local Bonus = LUI.UIText.new(0, 0, 3, 136, 0, 0, 6, 24)
	Bonus:setText(Engine[0xF9F1239CFD921FE](0xCD7217889FE44B))
	Bonus:setTTF("ttmussels_demibold")
	Bonus:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Bonus:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Bonus)
	self.Bonus = Bonus
	local PixelGridTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.13, 0.87, 0, 0)
	PixelGridTiledBacking:setAlpha(0.3)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local HeaderGlow = LUI.UIImage.new(0, 0, -5, 143, 0, 0, -1, 32)
	HeaderGlow:setRGB(0.42, 0.64, 0.28)
	HeaderGlow:setAlpha(0.1)
	HeaderGlow:setImage(RegisterImage(0xFAA6C81834660D3))
	HeaderGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	HeaderGlow:setShaderVector(0, 0, 0, 0, 0)
	HeaderGlow:setupNineSliceShader(12, 12)
	self:addElement(HeaderGlow)
	self.HeaderGlow = HeaderGlow
	self:mergeStateConditions({
		{
			stateName = "SetComplete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "setComplete")
			end,
		},
	})
	self:linkToElementModel(self, "setComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "setComplete",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StreamItemBonusWidget.__resetProperties = function(f4_arg0)
	f4_arg0.Bonus:completeAnimation()
	f4_arg0.Background:completeAnimation()
	f4_arg0.PixelGridTiledBacking:completeAnimation()
	f4_arg0.HeaderGlow:completeAnimation()
	f4_arg0.Bonus:setAlpha(1)
	f4_arg0.Background:setAlpha(1)
	f4_arg0.PixelGridTiledBacking:setAlpha(0.3)
	f4_arg0.HeaderGlow:setAlpha(0.1)
end
CoD.StreamItemBonusWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.Background:completeAnimation()
			f5_arg0.Background:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Background)
			f5_arg0.Bonus:completeAnimation()
			f5_arg0.Bonus:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Bonus)
			f5_arg0.PixelGridTiledBacking:completeAnimation()
			f5_arg0.PixelGridTiledBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PixelGridTiledBacking)
			f5_arg0.HeaderGlow:completeAnimation()
			f5_arg0.HeaderGlow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.HeaderGlow)
		end,
	},
	SetComplete = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Background:completeAnimation()
			f6_arg0.Background:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Background)
			f6_arg0.Bonus:completeAnimation()
			f6_arg0.Bonus:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Bonus)
		end,
	},
}
