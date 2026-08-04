CoD.Notification2xpWeaponReward = InheritFrom(LUI.UIElement)
CoD.Notification2xpWeaponReward.__defaultWidth = 72
CoD.Notification2xpWeaponReward.__defaultHeight = 72
CoD.Notification2xpWeaponReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Notification2xpWeaponReward)
	self.id = "Notification2xpWeaponReward"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XpSmall = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	XpSmall:setImage(RegisterImage("ui_icon_2xp_weapon"))
	self:addElement(XpSmall)
	self.XpSmall = XpSmall
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsDoubleWeaponXP(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		if not IsSelfInState(self, "Visible") then
			HideWidget(self)
		else
			ShowWidget(self)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Notification2xpWeaponReward.__resetProperties = function(f4_arg0)
	f4_arg0.XpSmall:completeAnimation()
	f4_arg0.XpSmall:setAlpha(1)
end
CoD.Notification2xpWeaponReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.XpSmall:completeAnimation()
			f5_arg0.XpSmall:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.XpSmall)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.XpSmall:completeAnimation()
			f6_arg0.XpSmall:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.XpSmall)
		end,
	},
}
