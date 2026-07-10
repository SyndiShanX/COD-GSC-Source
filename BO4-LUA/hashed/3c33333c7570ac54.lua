CoD.UnlockBonusAndXPIcon = InheritFrom(LUI.UIElement)
CoD.UnlockBonusAndXPIcon.__defaultWidth = 223
CoD.UnlockBonusAndXPIcon.__defaultHeight = 21
CoD.UnlockBonusAndXPIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.UnlockBonusAndXPIcon)
	self.id = "UnlockBonusAndXPIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UnlockBonus = LUI.UIText.new(0, 0, 23, 223, 0, 0, 0, 21)
	UnlockBonus:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	UnlockBonus:setTTF("ttmussels_regular")
	UnlockBonus:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	UnlockBonus:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	UnlockBonus:linkToElementModel(self, "unlockReward", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			UnlockBonus:setText(f2_local0)
		end
	end)
	self:addElement(UnlockBonus)
	self.UnlockBonus = UnlockBonus
	local XPIcon = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	XPIcon:setImage(RegisterImage(0x26A772C784CD242))
	self:addElement(XPIcon)
	self.XPIcon = XPIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "unlockSessionMode", Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]) then
					f3_local0 = not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "unlockSessionMode", Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	self:linkToElementModel(self, "unlockSessionMode", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlockSessionMode",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.UnlockBonusAndXPIcon.__resetProperties = function(f5_arg0)
	f5_arg0.XPIcon:completeAnimation()
	f5_arg0.UnlockBonus:completeAnimation()
	f5_arg0.XPIcon:setAlpha(1)
	f5_arg0.UnlockBonus:setAlpha(1)
end
CoD.UnlockBonusAndXPIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.UnlockBonus:completeAnimation()
			f7_arg0.UnlockBonus:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.UnlockBonus)
			f7_arg0.XPIcon:completeAnimation()
			f7_arg0.XPIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.XPIcon)
		end,
	},
}
CoD.UnlockBonusAndXPIcon.__onClose = function(f8_arg0)
	f8_arg0.UnlockBonus:close()
end
