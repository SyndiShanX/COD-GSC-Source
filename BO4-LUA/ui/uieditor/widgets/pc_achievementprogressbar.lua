CoD.PC_AchievementProgressBar = InheritFrom(LUI.UIElement)
CoD.PC_AchievementProgressBar.__defaultWidth = 400
CoD.PC_AchievementProgressBar.__defaultHeight = 50
CoD.PC_AchievementProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_AchievementProgressBar)
	self.id = "PC_AchievementProgressBar"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.16, 0.16, 0.16)
	self:addElement(BG)
	self.BG = BG
	local ProgressBarBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarBacking:setRGB(0.13, 0.13, 0.52)
	ProgressBarBacking:setAlpha(0)
	ProgressBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBarBacking:setShaderVector(0, 1, 0, 0, 0)
	ProgressBarBacking:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarBacking:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarBacking:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarBacking:setShaderVector(4, 1, 0.03, 1, 0)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local ProgressBarFiller = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarFiller:setRGB(0.43, 0.41, 0.39)
	ProgressBarFiller:setAlpha(0.8)
	ProgressBarFiller:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	ProgressBarFiller:setShaderVector(0, 1, 0, 0, 0)
	ProgressBarFiller:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarFiller:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarFiller:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarFiller:setShaderVector(4, 1, 0.03, 1, 0)
	self:addElement(ProgressBarFiller)
	self.ProgressBarFiller = ProgressBarFiller
	local Texture = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Texture:setAlpha(0.65)
	Texture:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	Texture:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	Texture:setShaderVector(0, 0, 0, 0, 0)
	Texture:setupNineSliceShader(196, 88)
	self:addElement(Texture)
	self.Texture = Texture
	local CompletedText = LUI.UIText.new(1, 1, -210, -10, 0.5, 0.5, -8, 10)
	CompletedText:setRGB(0, 0, 0)
	CompletedText:setAlpha(0)
	CompletedText:setText(LocalizeToUpperString(@"menu/completed"))
	CompletedText:setTTF("ttmussels_demibold")
	CompletedText:setLetterSpacing(4)
	CompletedText:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	CompletedText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(CompletedText)
	self.CompletedText = CompletedText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_AchievementProgressBar.__resetProperties = function(f2_arg0)
	f2_arg0.ProgressBarFiller:completeAnimation()
	f2_arg0.CompletedText:completeAnimation()
	f2_arg0.Texture:completeAnimation()
	f2_arg0.ProgressBarFiller:setRGB(0.43, 0.41, 0.39)
	f2_arg0.CompletedText:setAlpha(0)
	f2_arg0.Texture:setAlpha(0.65)
end
CoD.PC_AchievementProgressBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Completed = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.ProgressBarFiller:completeAnimation()
			f4_arg0.ProgressBarFiller:setRGB(0.86, 0.74, 0.25)
			f4_arg0.clipFinished(f4_arg0.ProgressBarFiller)
			f4_arg0.Texture:completeAnimation()
			f4_arg0.Texture:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Texture)
			f4_arg0.CompletedText:completeAnimation()
			f4_arg0.CompletedText:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.CompletedText)
		end,
	},
}
