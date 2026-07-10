CoD.ui_icon_callingcards_assassin_fastlinesgroup = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_assassin_fastlinesgroup.__defaultWidth = 2496
CoD.ui_icon_callingcards_assassin_fastlinesgroup.__defaultHeight = 240
CoD.ui_icon_callingcards_assassin_fastlinesgroup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_assassin_fastlinesgroup)
	self.id = "ui_icon_callingcards_assassin_fastlinesgroup"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fastlines2 = LUI.UIImage.new(0, 0, 1664, 2496, 0, 0, 0, 240)
	fastlines2:setAlpha(0.3)
	fastlines2:setImage(RegisterImage(0xB072A430554EE9F))
	fastlines2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(fastlines2)
	self.fastlines2 = fastlines2
	local Image = LUI.UIImage.new(0, 0, 832, 1664, 0, 0, 0, 240)
	Image:setAlpha(0.3)
	Image:setYRot(180)
	Image:setImage(RegisterImage(0xB072A430554EE9F))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image)
	self.Image = Image
	local fastlines = LUI.UIImage.new(0, 0, 0, 832, 0, 0, 0, 240)
	fastlines:setAlpha(0.3)
	fastlines:setImage(RegisterImage(0xB072A430554EE9F))
	fastlines:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(fastlines)
	self.fastlines = fastlines
	local Image2 = LUI.UIImage.new(0, 0, 2496, 3328, 0, 0, 0, 240)
	Image2:setAlpha(0.3)
	Image2:setYRot(180)
	Image2:setImage(RegisterImage(0xB072A430554EE9F))
	Image2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image2)
	self.Image2 = Image2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_assassin_fastlinesgroup.__resetProperties = function(f2_arg0)
	f2_arg0.fastlines:completeAnimation()
	f2_arg0.fastlines:setLeftRight(0, 0, 0, 832)
	f2_arg0.fastlines:setTopBottom(0, 0, 0, 240)
end
CoD.ui_icon_callingcards_assassin_fastlinesgroup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.fastlines:beginAnimation(1000)
			f3_arg0.fastlines:setLeftRight(0, 0, -80, 752)
			f3_arg0.fastlines:setTopBottom(0, 0, 0, 240)
			f3_arg0.fastlines:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.fastlines:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
