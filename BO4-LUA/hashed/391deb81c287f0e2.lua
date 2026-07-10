CoD.ItemDiscount = InheritFrom(LUI.UIElement)
CoD.ItemDiscount.__defaultWidth = 150
CoD.ItemDiscount.__defaultHeight = 30
CoD.ItemDiscount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemDiscount)
	self.id = "ItemDiscount"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.RewardSpecialist.r, ColorSet.RewardSpecialist.g, ColorSet.RewardSpecialist.b)
	self:addElement(Backing)
	self.Backing = Backing
	local PercentDiscount = LUI.UIText.new(0.1, 0.9, 0, 0, 0.5, 0.5, -12, 12)
	PercentDiscount:setRGB(ColorSet.HealthBarBackground.r, ColorSet.HealthBarBackground.g, ColorSet.HealthBarBackground.b)
	PercentDiscount:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5C8629D9F852A2DF"))
	PercentDiscount:setTTF("ttmussels_demibold")
	PercentDiscount:setLetterSpacing(1.5)
	PercentDiscount:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	PercentDiscount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PercentDiscount:setBackingType(1)
	PercentDiscount:setBackingXPadding(5)
	PercentDiscount:setBackingYPadding(4)
	LUI.OverrideFunction_CallOriginalFirst(PercentDiscount, "setText", function(element, controller)
		ScaleWidgetToLabelRightAligned(self, element, 6)
	end)
	self:addElement(PercentDiscount)
	self.PercentDiscount = PercentDiscount
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemDiscount.__resetProperties = function(f3_arg0)
	f3_arg0.PercentDiscount:completeAnimation()
	f3_arg0.Backing:completeAnimation()
	f3_arg0.PercentDiscount:setAlpha(1)
	f3_arg0.Backing:setAlpha(1)
end
CoD.ItemDiscount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Backing:completeAnimation()
			f4_arg0.Backing:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Backing)
			f4_arg0.PercentDiscount:completeAnimation()
			f4_arg0.PercentDiscount:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.PercentDiscount)
		end,
	},
	Available = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
