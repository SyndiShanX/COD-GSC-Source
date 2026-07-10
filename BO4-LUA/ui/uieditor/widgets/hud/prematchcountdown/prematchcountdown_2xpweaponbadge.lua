CoD.PrematchCountdown_2xpWeaponBadge = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_2xpWeaponBadge.__defaultWidth = 192
CoD.PrematchCountdown_2xpWeaponBadge.__defaultHeight = 192
CoD.PrematchCountdown_2xpWeaponBadge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown_2xpWeaponBadge)
	self.id = "PrematchCountdown_2xpWeaponBadge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXPIcon = LUI.UIImage.new(0, 0, 0, 192, 0, 0, 0, 192)
	DoubleXPIcon:setImage(RegisterImage(@"ui_icon_2xp_weapon_large"))
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	self:mergeStateConditions({
		{
			stateName = "french",
			condition = function(menu, element, event)
				return IsCurrentLanguageFrench()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
