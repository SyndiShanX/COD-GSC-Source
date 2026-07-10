CoD.StartMenuOptionsFocusBar = InheritFrom(LUI.UIElement)
CoD.StartMenuOptionsFocusBar.__defaultWidth = 144
CoD.StartMenuOptionsFocusBar.__defaultHeight = 12
CoD.StartMenuOptionsFocusBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenuOptionsFocusBar)
	self.id = "StartMenuOptionsFocusBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Glow2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Glow2:setImage(RegisterImage(@"hash_6C3B2316BAE91099"))
	self:addElement(Glow2)
	self.Glow2 = Glow2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenuOptionsFocusBar.__resetProperties = function(f2_arg0)
	f2_arg0.Glow2:completeAnimation()
	f2_arg0.Glow2:setAlpha(1)
end
CoD.StartMenuOptionsFocusBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(320)
					f5_arg0:setAlpha(0.69)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Glow2:beginAnimation(620)
				f3_arg0.Glow2:setAlpha(0.84)
				f3_arg0.Glow2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Glow2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Glow2:completeAnimation()
			f3_arg0.Glow2:setAlpha(0.69)
			f3_local0(f3_arg0.Glow2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
