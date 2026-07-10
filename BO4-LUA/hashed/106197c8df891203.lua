require("x64:577af23798fc57e")
CoD.BountyHunterWeaponBuy = InheritFrom(LUI.UIElement)
CoD.BountyHunterWeaponBuy.__defaultWidth = 280
CoD.BountyHunterWeaponBuy.__defaultHeight = 127
CoD.BountyHunterWeaponBuy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterWeaponBuy)
	self.id = "BountyHunterWeaponBuy"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponImage = CoD.BountyHunterWeaponBuyInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 280, 0, 0, 0, 127)
	WeaponImage:linkToElementModel(self, nil, false, function(model)
		WeaponImage:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local Header = LUI.UIText.new(0, 0, 3, 203, 0, 0, -21, -4)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(4)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Header)
	self.Header = Header
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.BountyHunterUtility.SetCurrentPreviewedPackage(self, f1_arg0)
	end)
	WeaponImage.id = "WeaponImage"
	self.__defaultFocus = WeaponImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterWeaponBuy.__resetProperties = function(f4_arg0)
	f4_arg0.WeaponImage:completeAnimation()
	f4_arg0.WeaponImage:setScale(1, 1)
end
CoD.BountyHunterWeaponBuy.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.WeaponImage:completeAnimation()
			f6_arg0.WeaponImage:setScale(1.05, 1.05)
			f6_arg0.clipFinished(f6_arg0.WeaponImage)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.WeaponImage:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f7_arg0.WeaponImage:setScale(1.05, 1.05)
				f7_arg0.WeaponImage:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.WeaponImage:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.WeaponImage:completeAnimation()
			f7_arg0.WeaponImage:setScale(1, 1)
			f7_local0(f7_arg0.WeaponImage)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.WeaponImage:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f9_arg0.WeaponImage:setScale(1, 1)
				f9_arg0.WeaponImage:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.WeaponImage:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.WeaponImage:completeAnimation()
			f9_arg0.WeaponImage:setScale(1.05, 1.05)
			f9_local0(f9_arg0.WeaponImage)
		end,
	},
}
CoD.BountyHunterWeaponBuy.__onClose = function(f11_arg0)
	f11_arg0.WeaponImage:close()
end
