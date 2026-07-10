CoD.Social_PartyMemberIconLarge = InheritFrom(LUI.UIElement)
CoD.Social_PartyMemberIconLarge.__defaultWidth = 9
CoD.Social_PartyMemberIconLarge.__defaultHeight = 90
CoD.Social_PartyMemberIconLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PartyMemberIconLarge)
	self.id = "Social_PartyMemberIconLarge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -3, 3)
	Icon:setRGB(ColorSet.PartyOther.r, ColorSet.PartyOther.g, ColorSet.PartyOther.b)
	Icon:setAlpha(0)
	Icon:setImage(RegisterImage(0xF21DA17910EC77E))
	self:addElement(Icon)
	self.Icon = Icon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PartyMemberIconLarge.__resetProperties = function(f2_arg0)
	f2_arg0.Icon:completeAnimation()
	f2_arg0.Icon:setLeftRight(0, 1, -3, 3)
	f2_arg0.Icon:setTopBottom(0, 1, -3, 3)
	f2_arg0.Icon:setRGB(ColorSet.PartyOther.r, ColorSet.PartyOther.g, ColorSet.PartyOther.b)
	f2_arg0.Icon:setAlpha(0)
end
CoD.Social_PartyMemberIconLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	PartyMemberTopOrMiddle = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Icon:completeAnimation()
			f4_arg0.Icon:setLeftRight(0, 1, -3, 3)
			f4_arg0.Icon:setTopBottom(0, 1, -5, 11)
			f4_arg0.Icon:setRGB(0.29, 0.38, 0.68)
			f4_arg0.Icon:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Icon)
		end,
	},
	PartyMember = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Icon:completeAnimation()
			f5_arg0.Icon:setRGB(0.29, 0.38, 0.68)
			f5_arg0.Icon:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Icon)
		end,
	},
	OtherPartyMemberTopOrMiddle = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Icon:completeAnimation()
			f6_arg0.Icon:setLeftRight(0, 1, -3, 3)
			f6_arg0.Icon:setTopBottom(0, 1, -4, 12)
			f6_arg0.Icon:setRGB(0.65, 0.65, 0.65)
			f6_arg0.Icon:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Icon)
		end,
	},
	OtherPartyMember = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Icon:completeAnimation()
			f7_arg0.Icon:setRGB(0.65, 0.65, 0.65)
			f7_arg0.Icon:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Icon)
		end,
	},
}
