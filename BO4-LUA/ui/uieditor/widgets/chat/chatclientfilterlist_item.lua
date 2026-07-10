CoD.ChatClientFilterList_Item = InheritFrom(LUI.UIElement)
CoD.ChatClientFilterList_Item.__defaultWidth = 125
CoD.ChatClientFilterList_Item.__defaultHeight = 30
CoD.ChatClientFilterList_Item.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatClientFilterList_Item)
	self.id = "ChatClientFilterList_Item"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.9)
	self:addElement(Image)
	self.Image = Image
	local Name = LUI.UIText.new(0.66, 0.66, -54.5, 54.5, 0.5, 0.5, -9, 9)
	Name:setRGB(0.5, 0.51, 0.52)
	Name:setTTF("ttmussels_regular")
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Name:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(f2_local0)
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local BackgroundBox = LUI.UIImage.new(0.04, 0.04, 0, 16, 0.5, 0.5, -8, 8)
	BackgroundBox:setRGB(0.13, 0.13, 0.13)
	self:addElement(BackgroundBox)
	self.BackgroundBox = BackgroundBox
	local BorderBoxTop = LUI.UIImage.new(0.03, 0.03, 1, 17, 0.2, 0.2, 1, 2)
	BorderBoxTop:setRGB(0.29, 0.29, 0.29)
	self:addElement(BorderBoxTop)
	self.BorderBoxTop = BorderBoxTop
	local BorderBoxRight = LUI.UIImage.new(0.17, 0.17, 0, 1, 0.73, 0.73, -15, 1)
	BorderBoxRight:setRGB(0.29, 0.29, 0.29)
	self:addElement(BorderBoxRight)
	self.BorderBoxRight = BorderBoxRight
	local BorderBoxBottom = LUI.UIImage.new(0.03, 0.03, 1, 17, 0.73, 0.73, 0, 1)
	BorderBoxBottom:setRGB(0.29, 0.29, 0.29)
	self:addElement(BorderBoxBottom)
	self.BorderBoxBottom = BorderBoxBottom
	local BorderBoxLeft = LUI.UIImage.new(0.03, 0.03, 1, 2, 0.73, 0.73, -15, 1)
	BorderBoxLeft:setRGB(0.29, 0.29, 0.29)
	self:addElement(BorderBoxLeft)
	self.BorderBoxLeft = BorderBoxLeft
	local DotBoxBottomRight = LUI.UIImage.new(0.17, 0.17, 0, 1, 0.7, 0.7, 1, 2)
	DotBoxBottomRight:setRGB(0.76, 0.76, 0.76)
	self:addElement(DotBoxBottomRight)
	self.DotBoxBottomRight = DotBoxBottomRight
	local DotBoxTopRight = LUI.UIImage.new(0.17, 0.17, 0, 1, 0.23, 0.23, 0, 1)
	DotBoxTopRight:setRGB(0.76, 0.76, 0.76)
	self:addElement(DotBoxTopRight)
	self.DotBoxTopRight = DotBoxTopRight
	local DotBoxBottomLeft = LUI.UIImage.new(0.03, 0.03, 1, 2, 0.73, 0.73, 0, 1)
	DotBoxBottomLeft:setRGB(0.76, 0.76, 0.76)
	self:addElement(DotBoxBottomLeft)
	self.DotBoxBottomLeft = DotBoxBottomLeft
	local DotBoxTopLeft = LUI.UIImage.new(0.03, 0.03, 1, 2, 0.2, 0.2, 1, 2)
	DotBoxTopLeft:setRGB(0.76, 0.76, 0.76)
	self:addElement(DotBoxTopLeft)
	self.DotBoxTopLeft = DotBoxTopLeft
	local CheckIcon = LUI.UIImage.new(0.03, 0.03, 0, 19, 0.5, 0.5, -9.5, 9.5)
	CheckIcon:setImage(RegisterImage(0xFEAEC46BB618295))
	CheckIcon:linkToElementModel(self, "active", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CheckIcon:setAlpha(f3_local0)
		end
	end)
	self:addElement(CheckIcon)
	self.CheckIcon = CheckIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local13 = self
	CoD.PCWidgetUtility.SetupClickableFilter(self, f1_arg1)
	return self
end
CoD.ChatClientFilterList_Item.__resetProperties = function(f4_arg0)
	f4_arg0.Name:completeAnimation()
	f4_arg0.Name:setRGB(0.5, 0.51, 0.52)
end
CoD.ChatClientFilterList_Item.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Name:completeAnimation()
			f5_arg0.Name:setRGB(1, 1, 1)
			f5_arg0.clipFinished(f5_arg0.Name)
		end,
		Over = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Name:completeAnimation()
			f6_arg0.Name:setRGB(1, 1, 1)
			f6_arg0.clipFinished(f6_arg0.Name)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Name:completeAnimation()
			f7_arg0.Name:setRGB(1, 1, 1)
			f7_arg0.clipFinished(f7_arg0.Name)
		end,
	},
}
CoD.ChatClientFilterList_Item.__onClose = function(f8_arg0)
	f8_arg0.Name:close()
	f8_arg0.CheckIcon:close()
end
