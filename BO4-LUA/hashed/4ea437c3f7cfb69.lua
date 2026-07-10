CoD.grapple_reticle_prong = InheritFrom(LUI.UIElement)
CoD.grapple_reticle_prong.__defaultWidth = 100
CoD.grapple_reticle_prong.__defaultHeight = 100
CoD.grapple_reticle_prong.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.grapple_reticle_prong)
	self.id = "grapple_reticle_prong"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local validProngTop = LUI.UIImage.new(0.5, 0.5, -23, 23, 0, 0, 0, 28)
	validProngTop:setImage(RegisterImage(@"uie_ui_hud_reticles_grapple_valid_prong"))
	self:addElement(validProngTop)
	self.validProngTop = validProngTop
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.grapple_reticle_prong.__resetProperties = function(f2_arg0) end
CoD.grapple_reticle_prong.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
}
