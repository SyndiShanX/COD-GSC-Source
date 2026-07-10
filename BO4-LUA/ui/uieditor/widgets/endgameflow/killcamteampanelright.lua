CoD.KIllcamTeamPanelRight = InheritFrom(LUI.UIElement)
CoD.KIllcamTeamPanelRight.__defaultWidth = 444
CoD.KIllcamTeamPanelRight.__defaultHeight = 69
CoD.KIllcamTeamPanelRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.KIllcamTeamPanelRight)
	self.id = "KIllcamTeamPanelRight"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BottomBackplateRight = LUI.UIImage.new(0, 0, 58, 444, 0, 0, 0, 68)
	BottomBackplateRight:setAlpha(0)
	BottomBackplateRight:setImage(RegisterImage(0xC87BEF5640733AB))
	self:addElement(BottomBackplateRight)
	self.BottomBackplateRight = BottomBackplateRight
	local CallingCardHighlightRigh2 = LUI.UIImage.new(0, 0, 0, 386, 0, 0, 0, 68)
	CallingCardHighlightRigh2:setRGB(ColorSet.Client_Self.r, ColorSet.Client_Self.g, ColorSet.Client_Self.b)
	CallingCardHighlightRigh2:setImage(RegisterImage(0x84A15B7F82C942C))
	self:addElement(CallingCardHighlightRigh2)
	self.CallingCardHighlightRigh2 = CallingCardHighlightRigh2
	local CallingCardGridPatternRight = LUI.UIImage.new(0, 0, 64, 450, 0, 0, 0, 68)
	CallingCardGridPatternRight:setRGB(0.79, 0.61, 0.11)
	CallingCardGridPatternRight:setImage(RegisterImage(0x684DCF03A2BF70F))
	CallingCardGridPatternRight:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	CallingCardGridPatternRight:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(CallingCardGridPatternRight)
	self.CallingCardGridPatternRight = CallingCardGridPatternRight
	local CallingcardHighlightRight1 = LUI.UIImage.new(0, 0, 8, 394, 0, 0, 0.5, 68.5)
	CallingcardHighlightRight1:setRGB(ColorSet.Client_Self.r, ColorSet.Client_Self.g, ColorSet.Client_Self.b)
	CallingcardHighlightRight1:setAlpha(0.35)
	CallingcardHighlightRight1:setImage(RegisterImage(0x277059AB3BFAEFA))
	CallingcardHighlightRight1:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(CallingcardHighlightRight1)
	self.CallingcardHighlightRight1 = CallingcardHighlightRight1
	local CallingCardFlareRight = LUI.UIImage.new(0, 0, 61, 447, 0, 0, -0.5, 67.5)
	CallingCardFlareRight:setRGB(ColorSet.EnemyOrange_Protanopia.r, ColorSet.EnemyOrange_Protanopia.g, ColorSet.EnemyOrange_Protanopia.b)
	CallingCardFlareRight:setImage(RegisterImage(0x4C0D64C8709CA1C))
	CallingCardFlareRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(CallingCardFlareRight)
	self.CallingCardFlareRight = CallingCardFlareRight
	self:mergeStateConditions({
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				local f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
				if not f2_local0 then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF])
				end
				return f2_local0
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF],
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KIllcamTeamPanelRight.__resetProperties = function(f5_arg0)
	f5_arg0.CallingCardFlareRight:completeAnimation()
	f5_arg0.CallingCardGridPatternRight:completeAnimation()
	f5_arg0.CallingcardHighlightRight1:completeAnimation()
	f5_arg0.CallingCardHighlightRigh2:completeAnimation()
	f5_arg0.BottomBackplateRight:completeAnimation()
	f5_arg0.CallingCardFlareRight:setAlpha(1)
	f5_arg0.CallingCardGridPatternRight:setAlpha(1)
	f5_arg0.CallingcardHighlightRight1:setAlpha(0.35)
	f5_arg0.CallingCardHighlightRigh2:setAlpha(1)
	f5_arg0.BottomBackplateRight:setAlpha(0)
end
CoD.KIllcamTeamPanelRight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			f6_arg0.BottomBackplateRight:completeAnimation()
			f6_arg0.BottomBackplateRight:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.BottomBackplateRight)
			f6_arg0.CallingCardHighlightRigh2:completeAnimation()
			f6_arg0.CallingCardHighlightRigh2:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CallingCardHighlightRigh2)
			f6_arg0.CallingCardGridPatternRight:completeAnimation()
			f6_arg0.CallingCardGridPatternRight:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CallingCardGridPatternRight)
			f6_arg0.CallingcardHighlightRight1:completeAnimation()
			f6_arg0.CallingcardHighlightRight1:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CallingcardHighlightRight1)
			f6_arg0.CallingCardFlareRight:completeAnimation()
			f6_arg0.CallingCardFlareRight:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CallingCardFlareRight)
		end,
	},
	Killcam = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
