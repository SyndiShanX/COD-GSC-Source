require("x64:6d8b28cbda2f13e")
CoD.DoubleWeaponXPIcon = InheritFrom(LUI.UIElement)
CoD.DoubleWeaponXPIcon.__defaultWidth = 72
CoD.DoubleWeaponXPIcon.__defaultHeight = 72
CoD.DoubleWeaponXPIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DoubleWeaponXPIcon)
	self.id = "DoubleWeaponXPIcon"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleWeaponXpIcon = CoD.Notification2xpWeaponReward.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, 0, 72)
	self:addElement(DoubleWeaponXpIcon)
	self.DoubleWeaponXpIcon = DoubleWeaponXpIcon
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsDoubleWeaponXP(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleWeaponXPIcon.__resetProperties = function(f3_arg0)
	f3_arg0.DoubleWeaponXpIcon:completeAnimation()
	f3_arg0.DoubleWeaponXpIcon:setAlpha(1)
end
CoD.DoubleWeaponXPIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.DoubleWeaponXpIcon:completeAnimation()
			f4_arg0.DoubleWeaponXpIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DoubleWeaponXpIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DoubleWeaponXPIcon.__onClose = function(f6_arg0)
	f6_arg0.DoubleWeaponXpIcon:close()
end
