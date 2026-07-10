CoD.PC_AchievementDetailedView_Points_BG = InheritFrom(LUI.UIElement)
CoD.PC_AchievementDetailedView_Points_BG.__defaultWidth = 600
CoD.PC_AchievementDetailedView_Points_BG.__defaultHeight = 129
CoD.PC_AchievementDetailedView_Points_BG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_AchievementDetailedView_Points_BG)
	self.id = "PC_AchievementDetailedView_Points_BG"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.09, 0.09, 0.09)
	self:addElement(BG)
	self.BG = BG
	local InnerGlow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	InnerGlow:setRGB(0.78, 0.78, 0.78)
	InnerGlow:setAlpha(0.01)
	InnerGlow:setImage(RegisterImage(0xFC86B798048CDF0))
	self:addElement(InnerGlow)
	self.InnerGlow = InnerGlow
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.31, 0.31, 0.31)
	Border:setAlpha(0.15)
	Border:setImage(RegisterImage(0xF1E3082B39E99BB))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(6, 6)
	self:addElement(Border)
	self.Border = Border
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_AchievementDetailedView_Points_BG.__resetProperties = function(f2_arg0)
	f2_arg0.Border:completeAnimation()
	f2_arg0.InnerGlow:completeAnimation()
	f2_arg0.Border:setAlpha(0.15)
	f2_arg0.InnerGlow:setAlpha(0.01)
end
CoD.PC_AchievementDetailedView_Points_BG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Completed = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.InnerGlow:completeAnimation()
			f4_arg0.InnerGlow:setAlpha(0.02)
			f4_arg0.clipFinished(f4_arg0.InnerGlow)
			f4_arg0.Border:completeAnimation()
			f4_arg0.Border:setAlpha(0.45)
			f4_arg0.clipFinished(f4_arg0.Border)
		end,
	},
}
