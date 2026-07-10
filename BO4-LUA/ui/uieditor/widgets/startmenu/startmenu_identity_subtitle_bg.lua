CoD.StartMenu_Identity_Subtitle_BG = InheritFrom(LUI.UIElement)
CoD.StartMenu_Identity_Subtitle_BG.__defaultWidth = 352
CoD.StartMenu_Identity_Subtitle_BG.__defaultHeight = 36
CoD.StartMenu_Identity_Subtitle_BG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Identity_Subtitle_BG)
	self.id = "StartMenu_Identity_Subtitle_BG"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setImage(RegisterImage(@"uie_t7_menu_frontend_listheaderpanelfull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setupNineSliceShader(24, 6)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Identity_Subtitle_BG.__resetProperties = function(f2_arg0)
	f2_arg0.Image:completeAnimation()
	f2_arg0.Image:setAlpha(1)
end
CoD.StartMenu_Identity_Subtitle_BG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Image:completeAnimation()
			f5_arg0.Image:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Image)
		end,
	},
}
