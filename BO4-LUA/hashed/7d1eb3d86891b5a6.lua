CoD.vhud_attack_helicopter_rocket = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_rocket.__defaultWidth = 20
CoD.vhud_attack_helicopter_rocket.__defaultHeight = 100
CoD.vhud_attack_helicopter_rocket.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_rocket)
	self.id = "vhud_attack_helicopter_rocket"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local rocketOutline = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -10, 10)
	rocketOutline:setZRot(270)
	rocketOutline:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_dart_notificationboxammoline"))
	self:addElement(rocketOutline)
	self.rocketOutline = rocketOutline
	local rocket = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -10, 10)
	rocket:setZRot(270)
	rocket:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_dart_notificationboxammo"))
	self:addElement(rocket)
	self.rocket = rocket
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_attack_helicopter_rocket.__resetProperties = function(f2_arg0)
	f2_arg0.rocket:completeAnimation()
	f2_arg0.rocket:setAlpha(1)
end
CoD.vhud_attack_helicopter_rocket.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Inactive = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.rocket:completeAnimation()
			f4_arg0.rocket:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.rocket)
		end,
	},
}
