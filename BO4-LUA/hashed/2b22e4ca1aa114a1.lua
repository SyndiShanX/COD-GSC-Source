CoD.SpawnSelectInfoLine = InheritFrom(LUI.UIElement)
CoD.SpawnSelectInfoLine.__defaultWidth = 100
CoD.SpawnSelectInfoLine.__defaultHeight = 4
CoD.SpawnSelectInfoLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectInfoLine)
	self.id = "SpawnSelectInfoLine"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpawnInfoLine = LUI.UIImage.new(0, 0, 0, 100, 0, 0, 0, 4)
	SpawnInfoLine:setRGB(0.92, 0.92, 0.92)
	SpawnInfoLine:setImage(RegisterImage(0xAB806B88B73F037))
	self:addElement(SpawnInfoLine)
	self.SpawnInfoLine = SpawnInfoLine
	local SpawnInfoLineAdd = LUI.UIImage.new(0, 0, 0, 100, 0, 0, 0, 4)
	SpawnInfoLineAdd:setRGB(0.92, 0.92, 0.92)
	SpawnInfoLineAdd:setImage(RegisterImage(0xAB806B88B73F037))
	SpawnInfoLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(SpawnInfoLineAdd)
	self.SpawnInfoLineAdd = SpawnInfoLineAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnSelectInfoLine.__resetProperties = function(f2_arg0)
	f2_arg0.SpawnInfoLineAdd:completeAnimation()
	f2_arg0.SpawnInfoLine:completeAnimation()
	f2_arg0.SpawnInfoLineAdd:setLeftRight(0, 0, 0, 100)
	f2_arg0.SpawnInfoLineAdd:setAlpha(1)
	f2_arg0.SpawnInfoLine:setLeftRight(0, 0, 0, 100)
	f2_arg0.SpawnInfoLine:setAlpha(1)
end
CoD.SpawnSelectInfoLine.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.SpawnInfoLine:completeAnimation()
			f3_arg0.SpawnInfoLine:setLeftRight(0, 0, 0, 4)
			f3_arg0.SpawnInfoLine:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.SpawnInfoLine)
			f3_arg0.SpawnInfoLineAdd:completeAnimation()
			f3_arg0.SpawnInfoLineAdd:setLeftRight(0, 0, 0, 4)
			f3_arg0.SpawnInfoLineAdd:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.SpawnInfoLineAdd)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.SpawnInfoLine:completeAnimation()
			f4_arg0.SpawnInfoLine:setLeftRight(0, 0, 0, 100)
			f4_arg0.SpawnInfoLine:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.SpawnInfoLine)
			f4_arg0.SpawnInfoLineAdd:completeAnimation()
			f4_arg0.SpawnInfoLineAdd:setLeftRight(0, 0, 0, 100)
			f4_arg0.SpawnInfoLineAdd:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.SpawnInfoLineAdd)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.SpawnInfoLine:beginAnimation(100)
				f5_arg0.SpawnInfoLine:setLeftRight(0, 0, 0, 100)
				f5_arg0.SpawnInfoLine:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.SpawnInfoLine:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.SpawnInfoLine:completeAnimation()
			f5_arg0.SpawnInfoLine:setLeftRight(0, 0, 0, 4)
			f5_arg0.SpawnInfoLine:setAlpha(1)
			f5_local0(f5_arg0.SpawnInfoLine)
			local f5_local1 = function(f7_arg0)
				f5_arg0.SpawnInfoLineAdd:beginAnimation(100)
				f5_arg0.SpawnInfoLineAdd:setLeftRight(0, 0, 0, 100)
				f5_arg0.SpawnInfoLineAdd:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.SpawnInfoLineAdd:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.SpawnInfoLineAdd:completeAnimation()
			f5_arg0.SpawnInfoLineAdd:setLeftRight(0, 0, 0, 4)
			f5_arg0.SpawnInfoLineAdd:setAlpha(1)
			f5_local1(f5_arg0.SpawnInfoLineAdd)
		end,
		LoseFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.SpawnInfoLine:beginAnimation(100)
				f8_arg0.SpawnInfoLine:setLeftRight(0, 0, 0, 4)
				f8_arg0.SpawnInfoLine:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SpawnInfoLine:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SpawnInfoLine:completeAnimation()
			f8_arg0.SpawnInfoLine:setLeftRight(0, 0, 0, 100)
			f8_arg0.SpawnInfoLine:setAlpha(1)
			f8_local0(f8_arg0.SpawnInfoLine)
			local f8_local1 = function(f10_arg0)
				f8_arg0.SpawnInfoLineAdd:beginAnimation(100)
				f8_arg0.SpawnInfoLineAdd:setLeftRight(0, 0, 0, 4)
				f8_arg0.SpawnInfoLineAdd:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SpawnInfoLineAdd:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SpawnInfoLineAdd:completeAnimation()
			f8_arg0.SpawnInfoLineAdd:setLeftRight(0, 0, 0, 100)
			f8_arg0.SpawnInfoLineAdd:setAlpha(1)
			f8_local1(f8_arg0.SpawnInfoLineAdd)
		end,
	},
}
