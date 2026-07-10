require("x64:eeba57f916954d1")
CoD.WZAARTierLock = InheritFrom(LUI.UIElement)
CoD.WZAARTierLock.__defaultWidth = 228
CoD.WZAARTierLock.__defaultHeight = 37
CoD.WZAARTierLock.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.WZAARTierLock)
	self.id = "WZAARTierLock"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 1.06, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.94)
	self:addElement(Backing)
	self.Backing = Backing
	local LockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 0, 0, 0, 28, 0, 0, 4.5, 32.5)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local LockedTier = LUI.UIText.new(0, 0, 28, 228, 0, 0, 7.5, 29.5)
	LockedTier:setTTF("ttmussels_regular")
	LockedTier:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LockedTier:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LockedTier:linkToElementModel(self, "maxTier", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LockedTier:setText(CoD.ChallengesUtility.MakeChallengeTierString(f2_local0))
		end
	end)
	self:addElement(LockedTier)
	self.LockedTier = LockedTier
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAARTierLock.__onClose = function(f3_arg0)
	f3_arg0.LockedIcon:close()
	f3_arg0.LockedTier:close()
end
