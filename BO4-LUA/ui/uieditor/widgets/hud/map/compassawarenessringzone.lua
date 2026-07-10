CoD.CompassAwarenessRingZone = InheritFrom(LUI.UIElement)
CoD.CompassAwarenessRingZone.__defaultWidth = 330
CoD.CompassAwarenessRingZone.__defaultHeight = 330
CoD.CompassAwarenessRingZone.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassAwarenessRingZone)
	self.id = "CompassAwarenessRingZone"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0.5, 0.5, -82, 82, 0, 0, -28, 176)
	Image:setAlpha(0)
	Image:setImage(RegisterImage(@"uie_ui_hud_awareness_wedge01"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image)
	self.Image = Image
	local jammedImage = LUI.UIImage.new(0.5, 0.5, -82, 82, 0, 0, -28, 176)
	jammedImage:setAlpha(0)
	jammedImage:setImage(RegisterImage(@"uie_ui_hud_awareness_wedge01_cuav"))
	jammedImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1EA736E2B2799BB4"))
	jammedImage:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(jammedImage)
	self.jammedImage = jammedImage
	local cuavImage = LUI.UIImage.new(0.5, 0.5, -82, 82, 0, 0, -28, 176)
	cuavImage:setAlpha(0)
	cuavImage:setImage(RegisterImage(@"uie_ui_hud_awareness_wedge01_cuav"))
	cuavImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1EA736E2B2799BB4"))
	cuavImage:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(cuavImage)
	self.cuavImage = cuavImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassAwarenessRingZone.__resetProperties = function(f2_arg0)
	f2_arg0.cuavImage:completeAnimation()
	f2_arg0.jammedImage:completeAnimation()
	f2_arg0.Image:completeAnimation()
	f2_arg0.cuavImage:setAlpha(0)
	f2_arg0.jammedImage:setAlpha(0)
	f2_arg0.Image:setAlpha(0)
end
CoD.CompassAwarenessRingZone.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Detect_CUAV = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.cuavImage:completeAnimation()
			f4_arg0.cuavImage:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.cuavImage)
		end,
	},
	Detect_Jammed = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.jammedImage:completeAnimation()
			f5_arg0.jammedImage:setAlpha(0.05)
			f5_arg0.clipFinished(f5_arg0.jammedImage)
		end,
	},
	Detect = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Image)
		end,
	},
}
