CoD.CallingCards_BasicImage = InheritFrom(LUI.UIElement)
CoD.CallingCards_BasicImage.__defaultWidth = 960
CoD.CallingCards_BasicImage.__defaultHeight = 240
CoD.CallingCards_BasicImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_BasicImage)
	self.id = "CallingCards_BasicImage"
	self.soundSet = "default"
	local CardIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CardIcon:setImage(RegisterImage("uie_t7_icon_callingcard_temp2_lrg"))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
