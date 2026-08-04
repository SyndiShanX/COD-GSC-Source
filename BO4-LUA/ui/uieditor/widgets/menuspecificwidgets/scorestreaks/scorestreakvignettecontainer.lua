require("ui/uieditor/widgets/vehiclehuds/ground/vehicleground_vignetteback")
CoD.scorestreakVignetteContainer = InheritFrom(LUI.UIElement)
CoD.scorestreakVignetteContainer.__defaultWidth = 1920
CoD.scorestreakVignetteContainer.__defaultHeight = 1080
CoD.scorestreakVignetteContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.scorestreakVignetteContainer)
	self.id = "scorestreakVignetteContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VignetteBack = CoD.VehicleGround_VignetteBack.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	VignetteBack:setAlpha(0.2)
	self:addElement(VignetteBack)
	self.VignetteBack = VignetteBack
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.scorestreakVignetteContainer.__resetProperties = function(f2_arg0)
	f2_arg0.VignetteBack:completeAnimation()
	f2_arg0.VignetteBack:setAlpha(0.2)
end
CoD.scorestreakVignetteContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.VignetteBack:beginAnimation(3930)
				f3_arg0.VignetteBack:setAlpha(0.2)
				f3_arg0.VignetteBack:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.VignetteBack:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.VignetteBack:completeAnimation()
			f3_arg0.VignetteBack:setAlpha(0.01)
			f3_local0(f3_arg0.VignetteBack)
		end,
	},
}
CoD.scorestreakVignetteContainer.__onClose = function(f5_arg0)
	f5_arg0.VignetteBack:close()
end
