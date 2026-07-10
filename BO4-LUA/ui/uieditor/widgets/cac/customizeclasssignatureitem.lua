CoD.CustomizeClassSignatureItem = InheritFrom(LUI.UIElement)
CoD.CustomizeClassSignatureItem.__defaultWidth = 222
CoD.CustomizeClassSignatureItem.__defaultHeight = 176
CoD.CustomizeClassSignatureItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomizeClassSignatureItem)
	self.id = "CustomizeClassSignatureItem"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGMain = LUI.UIImage.new(0, 0, 0, 222, 0, 0, 0, 176)
	BGMain:setZoom(10)
	BGMain:setImage(RegisterImage(0x291549F923145AE))
	self:addElement(BGMain)
	self.BGMain = BGMain
	local BGBrackets = LUI.UIImage.new(0, 0, 0, 222, 0, 0, 0, 176)
	BGBrackets:setZoom(12)
	BGBrackets:setImage(RegisterImage(0x3ACFD068143D7A))
	self:addElement(BGBrackets)
	self.BGBrackets = BGBrackets
	local Image = LUI.UIImage.new(0, 0, 47, 175, 0, 0, 33, 161)
	Image:setZoom(10)
	Image:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local nameLabel = LUI.UIText.new(0, 0, 13, 215, 0, 0, 12, 30)
	nameLabel:setRGB(0.58, 0.58, 0.58)
	nameLabel:setZoom(10)
	nameLabel:setTTF("ttmussels_demibold")
	nameLabel:setLetterSpacing(3)
	nameLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	nameLabel:linkToElementModel(self, "displayName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			nameLabel:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(nameLabel)
	self.nameLabel = nameLabel
	local bottombar = LUI.UIImage.new(0, 0, 6, 215, 0, 0, 169, 170)
	bottombar:setAlpha(0.02)
	bottombar:setZoom(10)
	self:addElement(bottombar)
	self.bottombar = bottombar
	local sidebarLeft = LUI.UIImage.new(0, 0, 6, 7, 0, 0, 8, 170)
	sidebarLeft:setAlpha(0.02)
	sidebarLeft:setZoom(10)
	self:addElement(sidebarLeft)
	self.sidebarLeft = sidebarLeft
	local sidebarRight = LUI.UIImage.new(0, 0, 214, 215, 0, 0, 8, 170)
	sidebarRight:setAlpha(0.02)
	sidebarRight:setZoom(10)
	self:addElement(sidebarRight)
	self.sidebarRight = sidebarRight
	local topbar = LUI.UIImage.new(0, 0, 6, 215, 0, 0, 7, 8)
	topbar:setAlpha(0.02)
	topbar:setZoom(10)
	self:addElement(topbar)
	self.topbar = topbar
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomizeClassSignatureItem.__resetProperties = function(f5_arg0)
	f5_arg0.Image:completeAnimation()
	f5_arg0.nameLabel:completeAnimation()
	f5_arg0.BGMain:completeAnimation()
	f5_arg0.Image:setAlpha(1)
	f5_arg0.nameLabel:setAlpha(1)
	f5_arg0.BGMain:setAlpha(1)
end
CoD.CustomizeClassSignatureItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.BGMain:completeAnimation()
			f6_arg0.BGMain:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.BGMain)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Image)
			f6_arg0.nameLabel:completeAnimation()
			f6_arg0.nameLabel:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.nameLabel)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Image:completeAnimation()
			f7_arg0.Image:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Image)
			f7_arg0.nameLabel:completeAnimation()
			f7_arg0.nameLabel:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.nameLabel)
		end,
	},
}
CoD.CustomizeClassSignatureItem.__onClose = function(f8_arg0)
	f8_arg0.Image:close()
	f8_arg0.nameLabel:close()
end
