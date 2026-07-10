CoD.outofbounds_alert_icon = InheritFrom(LUI.UIElement)
CoD.outofbounds_alert_icon.__defaultWidth = 64
CoD.outofbounds_alert_icon.__defaultHeight = 58
CoD.outofbounds_alert_icon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_alert_icon)
	self.id = "outofbounds_alert_icon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AlertIcon = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 58)
	AlertIcon:setImage(RegisterImage(0x9E47106ADFC5151))
	AlertIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	AlertIcon:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(AlertIcon)
	self.AlertIcon = AlertIcon
	local AlertIconAdd = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 58)
	AlertIconAdd:setImage(RegisterImage(0x9E47106ADFC5151))
	AlertIconAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	AlertIconAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(AlertIconAdd)
	self.AlertIconAdd = AlertIconAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.outofbounds_alert_icon.__resetProperties = function(f2_arg0)
	f2_arg0.AlertIcon:completeAnimation()
	f2_arg0.AlertIconAdd:completeAnimation()
	f2_arg0.AlertIcon:setAlpha(1)
	f2_arg0.AlertIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	f2_arg0.AlertIcon:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.AlertIconAdd:setAlpha(1)
	f2_arg0.AlertIconAdd:setZoom(0)
	f2_arg0.AlertIconAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.AlertIconAdd:setShaderVector(0, 1, 0, 0, 0)
end
CoD.outofbounds_alert_icon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.AlertIcon:completeAnimation()
			f3_arg0.AlertIcon:setAlpha(1)
			f3_arg0.AlertIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
			f3_arg0.AlertIcon:setShaderVector(0, 1, 0, 0, 0)
			f3_arg0.clipFinished(f3_arg0.AlertIcon)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setZoom(0)
					f5_arg0:setShaderVector(0, 1, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.AlertIconAdd:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.AlertIconAdd:setZoom(20)
				f3_arg0.AlertIconAdd:setShaderVector(0, 2, 0, 0, 0)
				f3_arg0.AlertIconAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.AlertIconAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.AlertIconAdd:completeAnimation()
			f3_arg0.AlertIconAdd:setAlpha(1)
			f3_arg0.AlertIconAdd:setZoom(0)
			f3_arg0.AlertIconAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.AlertIconAdd:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.AlertIconAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
