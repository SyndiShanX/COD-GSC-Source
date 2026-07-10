require("x64:46e86762adf274e")
CoD.vhud_attack_helicopter_rocket_counter = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_rocket_counter.__defaultWidth = 150
CoD.vhud_attack_helicopter_rocket_counter.__defaultHeight = 100
CoD.vhud_attack_helicopter_rocket_counter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_rocket_counter)
	self.id = "vhud_attack_helicopter_rocket_counter"
	self.soundSet = "none"
	local rocket = CoD.vhud_attack_helicopter_rocket.new(f1_arg0, f1_arg1, 0, 0, 14, 34, 0, 0, 0, 100)
	self:addElement(rocket)
	self.rocket = rocket
	local rocket2 = CoD.vhud_attack_helicopter_rocket.new(f1_arg0, f1_arg1, 0, 0, 49, 69, 0, 0, 0, 100)
	self:addElement(rocket2)
	self.rocket2 = rocket2
	local rocket3 = CoD.vhud_attack_helicopter_rocket.new(f1_arg0, f1_arg1, 0, 0, 88, 108, 0, 0, 0, 100)
	self:addElement(rocket3)
	self.rocket3 = rocket3
	local rocket4 = CoD.vhud_attack_helicopter_rocket.new(f1_arg0, f1_arg1, 0, 0, 118, 138, 0, 0, 0, 100)
	self:addElement(rocket4)
	self.rocket4 = rocket4
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_attack_helicopter_rocket_counter.__onClose = function(f2_arg0)
	f2_arg0.rocket:close()
	f2_arg0.rocket2:close()
	f2_arg0.rocket3:close()
	f2_arg0.rocket4:close()
end
