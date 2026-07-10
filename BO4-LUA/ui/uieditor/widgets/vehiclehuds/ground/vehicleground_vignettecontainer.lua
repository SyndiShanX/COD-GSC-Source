require("x64:479c90f39533c8a")
require("x64:86230ebb093d3d7")
CoD.VehicleGround_VignetteContainer = InheritFrom(LUI.UIElement)
CoD.VehicleGround_VignetteContainer.__defaultWidth = 1920
CoD.VehicleGround_VignetteContainer.__defaultHeight = 1080
CoD.VehicleGround_VignetteContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_VignetteContainer)
	self.id = "VehicleGround_VignetteContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VignetteBack = CoD.VehicleGround_VignetteBack.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	VignetteBack:setAlpha(0.2)
	self:addElement(VignetteBack)
	self.VignetteBack = VignetteBack
	local VignetteFore = CoD.VehicleGround_VignetteFore.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	VignetteFore:setAlpha(0.6)
	self:addElement(VignetteFore)
	self.VignetteFore = VignetteFore
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_VignetteContainer.__resetProperties = function(f2_arg0)
	f2_arg0.VignetteBack:completeAnimation()
	f2_arg0.VignetteFore:completeAnimation()
	f2_arg0.VignetteBack:setAlpha(0.2)
	f2_arg0.VignetteFore:setAlpha(0.6)
end
CoD.VehicleGround_VignetteContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.VignetteBack:beginAnimation(3930)
				f3_arg0.VignetteBack:setAlpha(0.2)
				f3_arg0.VignetteBack:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.VignetteBack:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.VignetteBack:completeAnimation()
			f3_arg0.VignetteBack:setAlpha(0)
			f3_local0(f3_arg0.VignetteBack)
			local f3_local1 = function(f5_arg0)
				f3_arg0.VignetteFore:beginAnimation(3030)
				f3_arg0.VignetteFore:setAlpha(0.6)
				f3_arg0.VignetteFore:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.VignetteFore:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.VignetteFore:completeAnimation()
			f3_arg0.VignetteFore:setAlpha(0)
			f3_local1(f3_arg0.VignetteFore)
		end,
	},
}
CoD.VehicleGround_VignetteContainer.__onClose = function(f6_arg0)
	f6_arg0.VignetteBack:close()
	f6_arg0.VignetteFore:close()
end
