require("x64:4e6143dbc749ffd")
require("x64:a9255c570c68aa8")
CoD.AARChallengeItem = InheritFrom(LUI.UIElement)
CoD.AARChallengeItem.__defaultWidth = 380
CoD.AARChallengeItem.__defaultHeight = 230
CoD.AARChallengeItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARChallengeItem)
	self.id = "AARChallengeItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -148, 148, 0, 0, 0, 150)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.64, 0.64, 0.64)
	Backing:setAlpha(0.04)
	self:addElement(Backing)
	self.Backing = Backing
	local Image = LUI.UIFixedAspectRatioImage.new(0, 0, 9, 369, 0, 0, 15.5, 105.5)
	self:addElement(Image)
	self.Image = Image
	local rotatedImage = LUI.UIFixedAspectRatioImage.new(0, 0, 149, 229, 0, 0, -129.5, 230.5)
	rotatedImage:setAlpha(0)
	rotatedImage:setZRot(90)
	rotatedImage:setStretchedDimension(4)
	self:addElement(rotatedImage)
	self.rotatedImage = rotatedImage
	local Description = LUI.UIText.new(0.5, 0.5, -171, 189, 0, 0, 147, 165)
	Description:setRGB(0.75, 0.75, 0.75)
	Description:setText("")
	Description:setTTF("ttmussels_regular")
	Description:setLetterSpacing(1)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Description)
	self.Description = Description
	local Title = LUI.UIText.new(0.5, 0.5, -171, 179, 0, 0, 120.5, 141.5)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setText("")
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(Title)
	self.Title = Title
	local Corner = CoD.AARRewardBrackets.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Corner:setAlpha(0.4)
	self:addElement(Corner)
	self.Corner = Corner
	local LockImage = LUI.UIFixedAspectRatioImage.new(0, 0, 164, 214, 0, 0, 35.5, 85.5)
	LockImage:setAlpha(0)
	LockImage:setImage(RegisterImage(@"uie_icon_locks_lock_01"))
	self:addElement(LockImage)
	self.LockImage = LockImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARChallengeItem.__resetProperties = function(f2_arg0)
	f2_arg0.LockImage:completeAnimation()
	f2_arg0.Image:completeAnimation()
	f2_arg0.rotatedImage:completeAnimation()
	f2_arg0.LockImage:setAlpha(0)
	f2_arg0.Image:setAlpha(1)
	f2_arg0.rotatedImage:setAlpha(0)
end
CoD.AARChallengeItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	RotatedLocked = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Image:completeAnimation()
			f4_arg0.Image:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Image)
			f4_arg0.rotatedImage:completeAnimation()
			f4_arg0.rotatedImage:setAlpha(0.05)
			f4_arg0.clipFinished(f4_arg0.rotatedImage)
			f4_arg0.LockImage:completeAnimation()
			f4_arg0.LockImage:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.LockImage)
		end,
	},
	Locked = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Image:completeAnimation()
			f5_arg0.Image:setAlpha(0.05)
			f5_arg0.clipFinished(f5_arg0.Image)
			f5_arg0.LockImage:completeAnimation()
			f5_arg0.LockImage:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.LockImage)
		end,
	},
	Rotated = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Image)
			f6_arg0.rotatedImage:completeAnimation()
			f6_arg0.rotatedImage:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.rotatedImage)
		end,
	},
}
CoD.AARChallengeItem.__onClose = function(f7_arg0)
	f7_arg0.Frame:close()
	f7_arg0.Corner:close()
end
