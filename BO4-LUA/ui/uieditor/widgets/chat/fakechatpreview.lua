CoD.FakeChatPreview = InheritFrom(LUI.UIElement)
CoD.FakeChatPreview.__defaultWidth = 540
CoD.FakeChatPreview.__defaultHeight = 370
CoD.FakeChatPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FakeChatPreview)
	self.id = "FakeChatPreview"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Collapsed = nil
	Collapsed = LUI.UIImage.new(0, 0, -1, 329, 0, 0, 202, 369)
	Collapsed:setAlpha(0)
	Collapsed:setImage(RegisterImage(0xF12DFEB7A0E9911))
	self:addElement(Collapsed)
	self.Collapsed = Collapsed
	local Expanded = nil
	Expanded = LUI.UIImage.new(0, 0, 0, 540, 0, 0, 67, 370)
	Expanded:setAlpha(0)
	Expanded:setImage(RegisterImage(0x4ECAE69096D20D1))
	self:addElement(Expanded)
	self.Expanded = Expanded
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	if ChatClientShow(f1_arg1) then
		CoD.PCWidgetUtility.SetupFakeChatPreview(f1_local3, f1_arg1, "KeyPressBits.0")
	end
	return self
end
CoD.FakeChatPreview.__resetProperties = function(f2_arg0)
	f2_arg0.Collapsed:completeAnimation()
	f2_arg0.Expanded:completeAnimation()
	f2_arg0.Collapsed:setAlpha(0)
	f2_arg0.Expanded:setAlpha(0)
end
CoD.FakeChatPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Inactive = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Collapsed = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Collapsed:completeAnimation()
			f5_arg0.Collapsed:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Collapsed)
		end,
	},
	Expanded = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Expanded:completeAnimation()
			f6_arg0.Expanded:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Expanded)
		end,
	},
}
if not CoD.isPC then
	CoD.FakeChatPreview.__clipsPerState.Expanded.DefaultClip = nil
end
