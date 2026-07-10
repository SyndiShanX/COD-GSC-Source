CoD.Callingcards_Asset_RacoonArm_L = InheritFrom(LUI.UIElement)
CoD.Callingcards_Asset_RacoonArm_L.__defaultWidth = 464
CoD.Callingcards_Asset_RacoonArm_L.__defaultHeight = 96
CoD.Callingcards_Asset_RacoonArm_L.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Callingcards_Asset_RacoonArm_L)
	self.id = "Callingcards_Asset_RacoonArm_L"
	self.soundSet = "default"
	local Larm = LUI.UIImage.new(0, 0, 232, 464, 0, 0, 0, 96)
	Larm:setImage(RegisterImage(0xF9D2D5F24055B4A))
	self:addElement(Larm)
	self.Larm = Larm
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
