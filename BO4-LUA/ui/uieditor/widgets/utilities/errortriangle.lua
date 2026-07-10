CoD.ErrorTriangle = InheritFrom(LUI.UIElement)
CoD.ErrorTriangle.__defaultWidth = 250
CoD.ErrorTriangle.__defaultHeight = 25
CoD.ErrorTriangle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ErrorTriangle)
	self.id = "ErrorTriangle"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local alertIcon = LUI.UIImage.new(0.5, 0.5, -16, 16, 1, 1, -16, 9)
	alertIcon:setRGB(1, 0, 0)
	alertIcon:setImage(RegisterImage(@"uie_t8_icon_restriction_warning"))
	self:addElement(alertIcon)
	self.alertIcon = alertIcon
	local RestrictedBar = LUI.UIImage.new(0, 1, 20, -20, 1, 1, -16, 6)
	RestrictedBar:setRGB(0.98, 0.13, 0.23)
	RestrictedBar:setImage(RegisterImage(@"uie_ui_menu_common_tab_restriction_warning"))
	RestrictedBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	RestrictedBar:setShaderVector(0, 0.4, 0.05, 0.4, 0.05)
	self:addElement(RestrictedBar)
	self.RestrictedBar = RestrictedBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ErrorTriangle.__resetProperties = function(f2_arg0)
	f2_arg0.alertIcon:completeAnimation()
	f2_arg0.RestrictedBar:completeAnimation()
	f2_arg0.alertIcon:setAlpha(1)
	f2_arg0.RestrictedBar:setAlpha(1)
end
CoD.ErrorTriangle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.alertIcon:completeAnimation()
			f4_arg0.alertIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.alertIcon)
			f4_arg0.RestrictedBar:completeAnimation()
			f4_arg0.RestrictedBar:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.RestrictedBar)
		end,
	},
}
