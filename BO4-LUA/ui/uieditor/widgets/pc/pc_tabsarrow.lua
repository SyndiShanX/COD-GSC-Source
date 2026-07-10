CoD.PC_TabsArrow = InheritFrom(LUI.UIElement)
CoD.PC_TabsArrow.__defaultWidth = 65
CoD.PC_TabsArrow.__defaultHeight = 65
CoD.PC_TabsArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_TabsArrow)
	self.id = "PC_TabsArrow"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Arrow = LUI.UIImage.new(-0.1, 1.1, -1, -1, -0.1, 1.1, 0, 0)
	Arrow:setRGB(0.78, 0.74, 0.67)
	Arrow:setZRot(180)
	Arrow:setScale(0.4, 0.4)
	Arrow:setImage(RegisterImage(0x5E74D00B45D12B6))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local ArrowFocus = LUI.UIImage.new(0.36, 0.64, -1, -1, 0.23, 0.77, 0, 0)
	ArrowFocus:setRGB(0.85, 0.79, 0.5)
	ArrowFocus:setAlpha(0)
	ArrowFocus:setImage(RegisterImage(0x91C23A1DFE18E55))
	self:addElement(ArrowFocus)
	self.ArrowFocus = ArrowFocus
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_TabsArrow.__resetProperties = function(f3_arg0)
	f3_arg0.ArrowFocus:completeAnimation()
	f3_arg0.Arrow:completeAnimation()
	f3_arg0.ArrowFocus:setAlpha(0)
	f3_arg0.ArrowFocus:setScale(1, 1)
	f3_arg0.Arrow:setAlpha(1)
end
CoD.PC_TabsArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Arrow:completeAnimation()
			f5_arg0.Arrow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Arrow)
			f5_arg0.ArrowFocus:completeAnimation()
			f5_arg0.ArrowFocus:setAlpha(1)
			f5_arg0.ArrowFocus:setScale(1.1, 1.1)
			f5_arg0.clipFinished(f5_arg0.ArrowFocus)
		end,
		GainFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Arrow:beginAnimation(100)
				f6_arg0.Arrow:setAlpha(0)
				f6_arg0.Arrow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Arrow:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Arrow:completeAnimation()
			f6_arg0.Arrow:setAlpha(1)
			f6_local0(f6_arg0.Arrow)
			local f6_local1 = function(f8_arg0)
				f6_arg0.ArrowFocus:beginAnimation(100)
				f6_arg0.ArrowFocus:setAlpha(1)
				f6_arg0.ArrowFocus:setScale(1.1, 1.1)
				f6_arg0.ArrowFocus:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ArrowFocus:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.ArrowFocus:completeAnimation()
			f6_arg0.ArrowFocus:setAlpha(0)
			f6_arg0.ArrowFocus:setScale(1, 1)
			f6_local1(f6_arg0.ArrowFocus)
		end,
		LoseFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Arrow:beginAnimation(100)
				f9_arg0.Arrow:setAlpha(1)
				f9_arg0.Arrow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Arrow:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Arrow:completeAnimation()
			f9_arg0.Arrow:setAlpha(0)
			f9_local0(f9_arg0.Arrow)
			local f9_local1 = function(f11_arg0)
				f9_arg0.ArrowFocus:beginAnimation(100)
				f9_arg0.ArrowFocus:setAlpha(0)
				f9_arg0.ArrowFocus:setScale(1, 1)
				f9_arg0.ArrowFocus:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ArrowFocus:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ArrowFocus:completeAnimation()
			f9_arg0.ArrowFocus:setAlpha(1)
			f9_arg0.ArrowFocus:setScale(1.1, 1.1)
			f9_local1(f9_arg0.ArrowFocus)
		end,
	},
	Disabled = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Arrow:completeAnimation()
			f12_arg0.Arrow:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Arrow)
		end,
	},
}
