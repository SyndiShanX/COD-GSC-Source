CoD.zm_trial_weapon_locked = InheritFrom(CoD.Menu)
LUI.createMenu.zm_trial_weapon_locked = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_trial_weapon_locked", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_trial_weapon_locked)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local WeaponLockedIcon = LUI.UIImage.new(0.5, 0.5, -43, 43, 0.5, 0.5, -43, 43)
	WeaponLockedIcon:setImage(RegisterImage(0x8BF44F9388C3E5A))
	self:addElement(WeaponLockedIcon)
	self.WeaponLockedIcon = WeaponLockedIcon
	self:linkToElementModel(self, "show_icon", true, function(model)
		local f2_local0 = self
		PlayClip(self, "Show", f1_arg0)
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.zm_trial_weapon_locked.__resetProperties = function(f3_arg0)
	f3_arg0.WeaponLockedIcon:completeAnimation()
	f3_arg0.WeaponLockedIcon:setAlpha(1)
end
CoD.zm_trial_weapon_locked.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.WeaponLockedIcon:completeAnimation()
			f4_arg0.WeaponLockedIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.WeaponLockedIcon)
		end,
		Show = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.WeaponLockedIcon:beginAnimation(1000)
				f5_arg0.WeaponLockedIcon:setAlpha(0)
				f5_arg0.WeaponLockedIcon:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.WeaponLockedIcon:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.WeaponLockedIcon:completeAnimation()
			f5_arg0.WeaponLockedIcon:setAlpha(1)
			f5_local0(f5_arg0.WeaponLockedIcon)
		end,
	},
}
CoD.zm_trial_weapon_locked.__onClose = function(f7_arg0) end
