CoD.WZAAR_PaintCans = InheritFrom(LUI.UIElement)
CoD.WZAAR_PaintCans.__defaultWidth = 296
CoD.WZAAR_PaintCans.__defaultHeight = 94
CoD.WZAAR_PaintCans.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_PaintCans)
	self.id = "WZAAR_PaintCans"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0.5, 0.5, -142, 142, 1, 1, -76.5, -20.5)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0.49)
	self:addElement(bg)
	self.bg = bg
	local led = LUI.UIImage.new(0, 0, 4, 296, 0, 0, 17.5, 57.5)
	led:setAlpha(0.02)
	led:setImage(RegisterImage(@"uie_wz_hud_map_danger_led"))
	led:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	led:setShaderVector(0, 0, 0.98, 0, 0)
	led:setShaderVector(1, 0, 0, 0, 0)
	led:setShaderVector(2, 0, 1, 0, 0)
	led:setShaderVector(3, 0, 0, 0, 0)
	led:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led)
	self.led = led
	local led2 = LUI.UIImage.new(0, 0, 4, 296, 0, 0, 53.5, 93.5)
	led2:setAlpha(0.02)
	led2:setImage(RegisterImage(@"uie_wz_hud_map_danger_led"))
	led2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	led2:setShaderVector(0, 0, 0.98, 0, 0)
	led2:setShaderVector(1, 0, 0, 0, 0)
	led2:setShaderVector(2, 0, 0.5, 0, 0)
	led2:setShaderVector(3, 0, 0, 0, 0)
	led2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led2)
	self.led2 = led2
	local border = LUI.UIImage.new(0, 0, 0, 296, 0, 0, 14, 77)
	border:setRGB(0.07, 0.07, 0.07)
	border:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_chamfer_border"))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setupNineSliceShader(18, 24)
	self:addElement(border)
	self.border = border
	local StatLabel = LUI.UIText.new(0, 0, 17, 177, 0, 0, 35, 57)
	StatLabel:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	StatLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_49FE863E6425C8CE"))
	StatLabel:setTTF("ttmussels_regular")
	StatLabel:setLetterSpacing(2)
	StatLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	StatLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(StatLabel)
	self.StatLabel = StatLabel
	local PaintCanImage = LUI.UIImage.new(0, 0, 177, 241, 0, 0, 14, 78)
	PaintCanImage:setZRot(38)
	PaintCanImage:setImage(RegisterImage(@"ui_icon_inventory_spray_can"))
	self:addElement(PaintCanImage)
	self.PaintCanImage = PaintCanImage
	local StatValue = LUI.UIText.new(0, 0, 237, 296, 0, 0, 24, 66)
	StatValue:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	StatValue:setText(15)
	StatValue:setTTF("ttmussels_regular")
	StatValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	StatValue:setShaderVector(0, 1, 0, 0, 0)
	StatValue:setShaderVector(1, 0.2, 0, 0, 0)
	StatValue:setShaderVector(2, 1, 0, 0, 0.25)
	StatValue:setLetterSpacing(2)
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StatValue)
	self.StatValue = StatValue
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "paintCans", 0)
			end,
		},
	})
	self:linkToElementModel(self, "paintCans", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "paintCans",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR_PaintCans.__resetProperties = function(f4_arg0)
	f4_arg0.StatLabel:completeAnimation()
	f4_arg0.PaintCanImage:completeAnimation()
	f4_arg0.StatValue:completeAnimation()
	f4_arg0.border:completeAnimation()
	f4_arg0.led2:completeAnimation()
	f4_arg0.led:completeAnimation()
	f4_arg0.bg:completeAnimation()
	f4_arg0.StatLabel:setAlpha(1)
	f4_arg0.PaintCanImage:setAlpha(1)
	f4_arg0.StatValue:setAlpha(1)
	f4_arg0.border:setAlpha(1)
	f4_arg0.led2:setAlpha(0.02)
	f4_arg0.led:setAlpha(0.02)
	f4_arg0.bg:setAlpha(0.49)
end
CoD.WZAAR_PaintCans.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(7)
			f6_arg0.bg:completeAnimation()
			f6_arg0.bg:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.bg)
			f6_arg0.led:completeAnimation()
			f6_arg0.led:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.led)
			f6_arg0.led2:completeAnimation()
			f6_arg0.led2:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.led2)
			f6_arg0.border:completeAnimation()
			f6_arg0.border:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.border)
			f6_arg0.StatLabel:completeAnimation()
			f6_arg0.StatLabel:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.StatLabel)
			f6_arg0.PaintCanImage:completeAnimation()
			f6_arg0.PaintCanImage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.PaintCanImage)
			f6_arg0.StatValue:completeAnimation()
			f6_arg0.StatValue:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.StatValue)
		end,
	},
}
