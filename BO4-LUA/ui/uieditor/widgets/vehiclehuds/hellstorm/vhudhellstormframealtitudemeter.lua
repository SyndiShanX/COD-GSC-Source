CoD.vhudHellstormFrameAltitudeMeter = InheritFrom(LUI.UIElement)
CoD.vhudHellstormFrameAltitudeMeter.__defaultWidth = 36
CoD.vhudHellstormFrameAltitudeMeter.__defaultHeight = 450
CoD.vhudHellstormFrameAltitudeMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhudHellstormFrameAltitudeMeter)
	self.id = "vhudHellstormFrameAltitudeMeter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 450)
	Image:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_meterverticle"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	Image:setShaderVector(0, 1, 1, 0, 0)
	Image:setShaderVector(1, 0, 0.09, 0, 0)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhudHellstormFrameAltitudeMeter.__resetProperties = function(f2_arg0)
	f2_arg0.Image:completeAnimation()
	f2_arg0.Image:setAlpha(1)
end
CoD.vhudHellstormFrameAltitudeMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Dock = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Image:completeAnimation()
			f4_arg0.Image:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Image)
		end,
	},
}
