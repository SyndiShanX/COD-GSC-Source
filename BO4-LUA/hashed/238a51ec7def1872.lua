CoD.WarzoneDirectorStageBar = InheritFrom(LUI.UIElement)
CoD.WarzoneDirectorStageBar.__defaultWidth = 180
CoD.WarzoneDirectorStageBar.__defaultHeight = 24
CoD.WarzoneDirectorStageBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDirectorStageBar)
	self.id = "WarzoneDirectorStageBar"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bg:setImage(RegisterImage(0x82B8B1E3E73BCF5))
	self:addElement(bg)
	self.bg = bg
	local Bar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Bar:setAlpha(0)
	Bar:setImage(RegisterImage(0x87BE43A2A727AF))
	self:addElement(Bar)
	self.Bar = Bar
	local dots = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	dots:setImage(RegisterImage(0xD264154A80493DE))
	self:addElement(dots)
	self.dots = dots
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneDirectorStageBar.__resetProperties = function(f2_arg0)
	f2_arg0.Bar:completeAnimation()
	f2_arg0.Bar:setRGB(1, 1, 1)
	f2_arg0.Bar:setAlpha(0)
end
CoD.WarzoneDirectorStageBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	On = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Bar:completeAnimation()
			f4_arg0.Bar:setRGB(1, 1, 1)
			f4_arg0.Bar:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Bar)
		end,
	},
}
