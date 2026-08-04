CoD.StartMenu_Background = InheritFrom(LUI.UIElement)
CoD.StartMenu_Background.__defaultWidth = 1920
CoD.StartMenu_Background.__defaultHeight = 1080
CoD.StartMenu_Background.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Background)
	self.id = "StartMenu_Background"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1080)
	Background:setRGB(0.06, 0.06, 0.06)
	Background:setAlpha(0.95)
	self:addElement(Background)
	self.Background = Background
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Background.__resetProperties = function(f2_arg0)
	f2_arg0.Background:completeAnimation()
	f2_arg0.Background:setAlpha(0.95)
end
CoD.StartMenu_Background.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Background:completeAnimation()
			f3_arg0.Background:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.Background)
		end,
	},
	InGame = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Background:completeAnimation()
			f4_arg0.Background:setAlpha(0.2)
			f4_arg0.clipFinished(f4_arg0.Background)
		end,
	},
}
