CoD.ItemShopSlotTimer = InheritFrom(LUI.UIElement)
CoD.ItemShopSlotTimer.__defaultWidth = 355
CoD.ItemShopSlotTimer.__defaultHeight = 50
CoD.ItemShopSlotTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 24, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ItemShopSlotTimer)
	self.id = "ItemShopSlotTimer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 1, 0, 0, 0, 0, 14, 32)
	TextBox:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	TextBox:setText("")
	TextBox:setTTF("ttmussels_regular")
	TextBox:setLetterSpacing(2)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopSlotTimer.__resetProperties = function(f2_arg0)
	f2_arg0.TextBox:completeAnimation()
	f2_arg0.TextBox:setAlpha(1)
end
CoD.ItemShopSlotTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TextBox:completeAnimation()
			f4_arg0.TextBox:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TextBox)
		end,
	},
}
