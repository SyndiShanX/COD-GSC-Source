CoD.KeyboardTextFieldInputCursor = InheritFrom(LUI.UIElement)
CoD.KeyboardTextFieldInputCursor.__defaultWidth = 195
CoD.KeyboardTextFieldInputCursor.__defaultHeight = 72
CoD.KeyboardTextFieldInputCursor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KeyboardTextFieldInputCursor)
	self.id = "KeyboardTextFieldInputCursor"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local text = LUI.UIText.new(0, 0, -1, 194, 0, 1, 0, 0)
	text:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	text:setAlpha(0.8)
	text:setText(CoD.BaseUtility.AlreadyLocalized("|"))
	text:setTTF("notosans_regular")
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(text)
	self.text = text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KeyboardTextFieldInputCursor.__resetProperties = function(f2_arg0)
	f2_arg0.text:completeAnimation()
	f2_arg0.text:setAlpha(0.8)
end
CoD.KeyboardTextFieldInputCursor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(490)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(9)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.text:beginAnimation(500)
				f3_arg0.text:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.text:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.text:completeAnimation()
			f3_arg0.text:setAlpha(0.8)
			f3_local0(f3_arg0.text)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
