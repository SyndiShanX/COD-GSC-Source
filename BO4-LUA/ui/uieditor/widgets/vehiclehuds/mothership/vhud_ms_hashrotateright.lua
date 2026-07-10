require("x64:90715ebc19cf66a")
require("x64:d4ce3fa496074dc")
require("x64:11db5d3e59d408c")
CoD.vhud_ms_HashRotateRight = InheritFrom(LUI.UIElement)
CoD.vhud_ms_HashRotateRight.__defaultWidth = 337
CoD.vhud_ms_HashRotateRight.__defaultHeight = 736
CoD.vhud_ms_HashRotateRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_HashRotateRight)
	self.id = "vhud_ms_HashRotateRight"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VehicleGroundHashText0 = CoD.VehicleGround_HashText.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 81, 0.5, 0.5, -22, 17)
	VehicleGroundHashText0:setAlpha(0)
	VehicleGroundHashText0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	VehicleGroundHashText0:setShaderVector(0, 0.1, 0, 0, 0)
	VehicleGroundHashText0:setShaderVector(1, 1, 0, 0, 0)
	VehicleGroundHashText0:setShaderVector(2, 5, 7, 0, 0)
	VehicleGroundHashText0:setShaderVector(3, 1, 1, 0, 0)
	VehicleGroundHashText0:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(VehicleGroundHashText0)
	self.VehicleGroundHashText0 = VehicleGroundHashText0
	local VehicleGroundHashIcon0 = CoD.VehicleGround_HashIcon.new(f1_arg0, f1_arg1, 0.5, 0.5, 72, 120, 0.5, 0.5, -18, 6)
	VehicleGroundHashIcon0:setAlpha(0)
	self:addElement(VehicleGroundHashIcon0)
	self.VehicleGroundHashIcon0 = VehicleGroundHashIcon0
	local VehicleGroundHashRingLarge000 = CoD.VehicleGround_HashRingLarge.new(f1_arg0, f1_arg1, 0.5, 0.5, -364, -168, 0.5, 0.5, -223, 209)
	VehicleGroundHashRingLarge000:setRGB(0.35, 0.35, 0.35)
	VehicleGroundHashRingLarge000:setZoom(800)
	VehicleGroundHashRingLarge000:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(VehicleGroundHashRingLarge000)
	self.VehicleGroundHashRingLarge000 = VehicleGroundHashRingLarge000
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_HashRotateRight.__resetProperties = function(f2_arg0)
	f2_arg0.VehicleGroundHashIcon0:completeAnimation()
	f2_arg0.VehicleGroundHashIcon0:setAlpha(0)
end
CoD.vhud_ms_HashRotateRight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		StartUp = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f5_arg0:beginAnimation(80)
				f5_arg0:setAlpha(1)
				f5_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.VehicleGroundHashIcon0:beginAnimation(1760)
			f4_arg0.VehicleGroundHashIcon0:setAlpha(0)
			f4_arg0.VehicleGroundHashIcon0:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.VehicleGroundHashIcon0:registerEventHandler("transition_complete_keyframe", f4_local0)
		end,
		Zoom = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.vhud_ms_HashRotateRight.__onClose = function(f7_arg0)
	f7_arg0.VehicleGroundHashText0:close()
	f7_arg0.VehicleGroundHashIcon0:close()
	f7_arg0.VehicleGroundHashRingLarge000:close()
end
