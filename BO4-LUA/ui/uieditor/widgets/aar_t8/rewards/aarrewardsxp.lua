require("x64:4e6143dbc749ffd")
require("x64:f72d4606ccc678a")
require("x64:a9255c570c68aa8")
CoD.AARRewardsXP = InheritFrom(LUI.UIElement)
CoD.AARRewardsXP.__defaultWidth = 380
CoD.AARRewardsXP.__defaultHeight = 94
CoD.AARRewardsXP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardsXP)
	self.id = "AARRewardsXP"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.64, 0.64, 0.64)
	Backing:setAlpha(0.06)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -148, 148, 0, 0, 0, 150)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local XPIcon = LUI.UIFixedAspectRatioImage.new(0, 0, 25, 85, 0, 0, 17, 77)
	XPIcon:setImage(RegisterImage(@"t7_hud_mp_notifications_xp_blue"))
	self:addElement(XPIcon)
	self.XPIcon = XPIcon
	local DoubleXP = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0, 0, 19, 91, 0, 0, 11, 83)
	DoubleXP:setAlpha(0)
	DoubleXP:setScale(0.8, 0.8)
	self:addElement(DoubleXP)
	self.DoubleXP = DoubleXP
	local XP = LUI.UIText.new(1, 1, -276, -15, 0, 0, 33, 61)
	XP:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	XP:setText("")
	XP:setTTF("ttmussels_demibold")
	XP:setLetterSpacing(2)
	XP:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	XP:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(XP)
	self.XP = XP
	local Corner = CoD.AARRewardBrackets.new(f1_arg0, f1_arg1, 0, 0, -1, 381, 0, 0, -1, 95)
	Corner:setAlpha(0.3)
	self:addElement(Corner)
	self.Corner = Corner
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARRewardsXP.__resetProperties = function(f2_arg0)
	f2_arg0.XP:completeAnimation()
	f2_arg0.XPIcon:completeAnimation()
	f2_arg0.Backing:completeAnimation()
	f2_arg0.Corner:completeAnimation()
	f2_arg0.DoubleXP:completeAnimation()
	f2_arg0.XP:setLeftRight(1, 1, -276, -15)
	f2_arg0.XP:setAlpha(1)
	f2_arg0.XPIcon:setAlpha(1)
	f2_arg0.Backing:setAlpha(0.06)
	f2_arg0.Corner:setAlpha(0.3)
	f2_arg0.DoubleXP:setAlpha(0)
end
CoD.AARRewardsXP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.Backing:completeAnimation()
			f4_arg0.Backing:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Backing)
			f4_arg0.XPIcon:completeAnimation()
			f4_arg0.XPIcon:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.XPIcon)
			f4_arg0.XP:completeAnimation()
			f4_arg0.XP:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.XP)
			f4_arg0.Corner:completeAnimation()
			f4_arg0.Corner:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Corner)
		end,
	},
	DoubleXP = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.XPIcon:completeAnimation()
			f5_arg0.XPIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.XPIcon)
			f5_arg0.DoubleXP:completeAnimation()
			f5_arg0.DoubleXP:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.DoubleXP)
		end,
	},
	Merit = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.XPIcon:completeAnimation()
			f6_arg0.XPIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.XPIcon)
			f6_arg0.DoubleXP:completeAnimation()
			f6_arg0.DoubleXP:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.DoubleXP)
			f6_arg0.XP:completeAnimation()
			f6_arg0.XP:setLeftRight(1, 1, -355, -94)
			f6_arg0.clipFinished(f6_arg0.XP)
		end,
	},
}
CoD.AARRewardsXP.__onClose = function(f7_arg0)
	f7_arg0.Frame:close()
	f7_arg0.DoubleXP:close()
	f7_arg0.Corner:close()
end
