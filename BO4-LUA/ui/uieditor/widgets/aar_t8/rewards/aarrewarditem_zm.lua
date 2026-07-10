require("x64:4e6143dbc749ffd")
CoD.AARRewardItem_ZM = InheritFrom(LUI.UIElement)
CoD.AARRewardItem_ZM.__defaultWidth = 380
CoD.AARRewardItem_ZM.__defaultHeight = 182
CoD.AARRewardItem_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardItem_ZM)
	self.id = "AARRewardItem_ZM"
	self.soundSet = "none"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.64, 0.24, 0.24)
	Backing:setAlpha(0.04)
	self:addElement(Backing)
	self.Backing = Backing
	local Image = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -107, 107, 0, 0, 15, 100)
	self:addElement(Image)
	self.Image = Image
	local Description = LUI.UIText.new(0.5, 0.5, -171, 89, 0, 0, 152, 169)
	Description:setRGB(0.75, 0.75, 0.75)
	Description:setText("")
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local Title = LUI.UIText.new(0.5, 0.5, -171, 89, 0, 0, 125.5, 146.5)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setText("")
	Title:setTTF("skorzhen")
	Title:setLetterSpacing(6)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Title)
	self.Title = Title
	local Corner = CoD.AARRewardBrackets.new(f1_arg0, f1_arg1, 0, 0, -1, 381, 0, 0, -1, 183)
	Corner:setAlpha(0.4)
	self:addElement(Corner)
	self.Corner = Corner
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARRewardItem_ZM.__onClose = function(f2_arg0)
	f2_arg0.Corner:close()
end
