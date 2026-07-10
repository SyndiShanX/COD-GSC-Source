CoD.WarzoneInventoryItemGrayBox = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryItemGrayBox.__defaultWidth = 16
CoD.WarzoneInventoryItemGrayBox.__defaultHeight = 16
CoD.WarzoneInventoryItemGrayBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryItemGrayBox)
	self.id = "WarzoneInventoryItemGrayBox"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	Image:setImage(RegisterImage(0xA6223620969586C))
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryItemGrayBox.__resetProperties = function(f2_arg0)
	f2_arg0.Image:completeAnimation()
	f2_arg0.Image:setAlpha(1)
end
CoD.WarzoneInventoryItemGrayBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Active = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Image:completeAnimation()
			f4_arg0.Image:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Image)
		end,
	},
}
