CoD.Callingcards_Asset_RacoonArm_R = InheritFrom(LUI.UIElement)
CoD.Callingcards_Asset_RacoonArm_R.__defaultWidth = 464
CoD.Callingcards_Asset_RacoonArm_R.__defaultHeight = 88
CoD.Callingcards_Asset_RacoonArm_R.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Callingcards_Asset_RacoonArm_R)
	self.id = "Callingcards_Asset_RacoonArm_R"
	self.soundSet = "default"
	local Rarm = LUI.UIImage.new(0, 0, 0, 232, 0, 0, 0, 88)
	Rarm:setImage(RegisterImage(0xF3E5D522600B8FC))
	self:addElement(Rarm)
	self.Rarm = Rarm
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
