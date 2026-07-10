CoD.DirectorPlaylistHeaderB = InheritFrom(LUI.UIElement)
CoD.DirectorPlaylistHeaderB.__defaultWidth = 500
CoD.DirectorPlaylistHeaderB.__defaultHeight = 24
CoD.DirectorPlaylistHeaderB.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPlaylistHeaderB)
	self.id = "DirectorPlaylistHeaderB"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 0, -7, 521, 0, 0, 0, 24)
	Image:setAlpha(0.18)
	self:addElement(Image)
	self.Image = Image
	local description4 = LUI.UIText.new(0, 0, 0, 500, 0, 0, 0, 24)
	description4:setRGB(0.14, 0.14, 0.14)
	description4:setText(Engine[0xF9F1239CFD921FE](0xFB6B6B58798A982))
	description4:setTTF("ttmussels_demibold")
	description4:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	description4:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(description4)
	self.description4 = description4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
