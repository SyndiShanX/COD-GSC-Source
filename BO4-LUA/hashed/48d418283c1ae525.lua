CoD.ArenaGauntletLossSlot = InheritFrom(LUI.UIElement)
CoD.ArenaGauntletLossSlot.__defaultWidth = 40
CoD.ArenaGauntletLossSlot.__defaultHeight = 40
CoD.ArenaGauntletLossSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaGauntletLossSlot)
	self.id = "ArenaGauntletLossSlot"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Slot = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Slot:setRGB(ColorSet.HealthBarBackground.r, ColorSet.HealthBarBackground.g, ColorSet.HealthBarBackground.b)
	self:addElement(Slot)
	self.Slot = Slot
	local Fill = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Fill:setImage(RegisterImage(0x69BEFB7E55FBA50))
	self:addElement(Fill)
	self.Fill = Fill
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaGauntletLossSlot.__resetProperties = function(f2_arg0)
	f2_arg0.Fill:completeAnimation()
	f2_arg0.Fill:setAlpha(1)
end
CoD.ArenaGauntletLossSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Fill:completeAnimation()
			f3_arg0.Fill:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Fill)
		end,
	},
	Filled = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Fill:completeAnimation()
			f4_arg0.Fill:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Fill)
		end,
	},
}
