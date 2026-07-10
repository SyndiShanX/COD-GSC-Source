CoD.FileshareBookmarkedItem = InheritFrom(LUI.UIElement)
CoD.FileshareBookmarkedItem.__defaultWidth = 140
CoD.FileshareBookmarkedItem.__defaultHeight = 26
CoD.FileshareBookmarkedItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FileshareBookmarkedItem)
	self.id = "FileshareBookmarkedItem"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Base = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Base:setRGB(0, 0, 0)
	Base:setAlpha(0.9)
	self:addElement(Base)
	self.Base = Base
	local Image = LUI.UIImage.new(0, 0, 0, 26, 0, 0, 0, 26)
	Image:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	Image:setImage(RegisterImage(0xEFEEB855F6196B3))
	self:addElement(Image)
	self.Image = Image
	local Text = LUI.UIText.new(0, 0.8, 28, 28, 0.5, 0.5, -11, 11)
	Text:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	Text:setText(Engine[0xF9F1239CFD921FE](0x49105C8DE141682))
	Text:setTTF("ttmussels_regular")
	Text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LUI.OverrideFunction_CallOriginalFirst(Text, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 5)
	end)
	self:addElement(Text)
	self.Text = Text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FileshareBookmarkedItem.__resetProperties = function(f3_arg0)
	f3_arg0.Image:completeAnimation()
	f3_arg0.Text:completeAnimation()
	f3_arg0.Base:completeAnimation()
	f3_arg0.Image:setAlpha(1)
	f3_arg0.Text:setAlpha(1)
	f3_arg0.Base:setAlpha(0.9)
end
CoD.FileshareBookmarkedItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Base:completeAnimation()
			f4_arg0.Base:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Base)
			f4_arg0.Image:completeAnimation()
			f4_arg0.Image:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Image)
			f4_arg0.Text:completeAnimation()
			f4_arg0.Text:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Text)
		end,
	},
	IconOnly = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.Base:completeAnimation()
			f5_arg0.Base:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Base)
			f5_arg0.Image:completeAnimation()
			f5_arg0.Image:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Image)
			f5_arg0.Text:completeAnimation()
			f5_arg0.Text:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Text)
		end,
	},
	IconWithText = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Base:completeAnimation()
			f6_arg0.Base:setAlpha(0.9)
			f6_arg0.clipFinished(f6_arg0.Base)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Image)
			f6_arg0.Text:completeAnimation()
			f6_arg0.Text:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Text)
		end,
	},
}
