CoD.outofbounds_timerframedots = InheritFrom(LUI.UIElement)
CoD.outofbounds_timerframedots.__defaultWidth = 600
CoD.outofbounds_timerframedots.__defaultHeight = 128
CoD.outofbounds_timerframedots.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_timerframedots)
	self.id = "outofbounds_timerframedots"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TimerFrameElement04 = LUI.UIImage.new(0, 0, 0, 600, 0, 0, 0, 132)
	TimerFrameElement04:setAlpha(0.4)
	TimerFrameElement04:setZoom(-20)
	TimerFrameElement04:setImage(RegisterImage(@"hash_176DF8BCE8362508"))
	self:addElement(TimerFrameElement04)
	self.TimerFrameElement04 = TimerFrameElement04
	local TimerFrameElementAdd02 = LUI.UIImage.new(0, 0, 0, 600, 0, 0, 0, 132)
	TimerFrameElementAdd02:setScale(1.08, 1.08)
	TimerFrameElementAdd02:setImage(RegisterImage(@"hash_176DF8BCE8362508"))
	TimerFrameElementAdd02:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TimerFrameElementAdd02)
	self.TimerFrameElementAdd02 = TimerFrameElementAdd02
	local TimerFrameElement01 = LUI.UIImage.new(0, 0, 0, 600, 0, 0, 0, 132)
	TimerFrameElement01:setAlpha(0.8)
	TimerFrameElement01:setImage(RegisterImage(@"hash_176DF8BCE8362508"))
	TimerFrameElement01:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TimerFrameElement01)
	self.TimerFrameElement01 = TimerFrameElement01
	local TimerFrameElementAdd01 = LUI.UIImage.new(0, 0, 0, 600, 0, 0, 0, 132)
	TimerFrameElementAdd01:setAlpha(0.1)
	TimerFrameElementAdd01:setImage(RegisterImage(@"hash_176DF8BCE8362508"))
	TimerFrameElementAdd01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	TimerFrameElementAdd01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TimerFrameElementAdd01)
	self.TimerFrameElementAdd01 = TimerFrameElementAdd01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.outofbounds_timerframedots.__resetProperties = function(f2_arg0)
	f2_arg0.TimerFrameElementAdd01:completeAnimation()
	f2_arg0.TimerFrameElement01:completeAnimation()
	f2_arg0.TimerFrameElement04:completeAnimation()
	f2_arg0.TimerFrameElementAdd02:completeAnimation()
	f2_arg0.TimerFrameElementAdd01:setAlpha(0.1)
	f2_arg0.TimerFrameElementAdd01:setZoom(0)
	f2_arg0.TimerFrameElement01:setAlpha(0.8)
	f2_arg0.TimerFrameElement01:setZoom(0)
	f2_arg0.TimerFrameElement04:setAlpha(0.4)
	f2_arg0.TimerFrameElement04:setZoom(-20)
	f2_arg0.TimerFrameElementAdd02:setAlpha(1)
	f2_arg0.TimerFrameElementAdd02:setZoom(0)
	f2_arg0.TimerFrameElementAdd02:setScale(1.08, 1.08)
	f2_arg0.TimerFrameElementAdd02:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
end
CoD.outofbounds_timerframedots.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			f3_arg0.TimerFrameElement04:completeAnimation()
			f3_arg0.TimerFrameElement04:setAlpha(0.4)
			f3_arg0.TimerFrameElement04:setZoom(-20)
			f3_arg0.clipFinished(f3_arg0.TimerFrameElement04)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_both"])
						f6_arg0:setZoom(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setAlpha(0)
					f5_arg0:setZoom(10)
					f5_arg0:setScale(1.1, 1.1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.TimerFrameElementAdd02:beginAnimation(400)
				f3_arg0.TimerFrameElementAdd02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TimerFrameElementAdd02:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.TimerFrameElementAdd02:completeAnimation()
			f3_arg0.TimerFrameElementAdd02:setAlpha(1)
			f3_arg0.TimerFrameElementAdd02:setZoom(0)
			f3_arg0.TimerFrameElementAdd02:setScale(1, 1)
			f3_arg0.TimerFrameElementAdd02:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f3_local0(f3_arg0.TimerFrameElementAdd02)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_both"])
					f8_arg0:setAlpha(0.8)
					f8_arg0:setZoom(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.TimerFrameElement01:beginAnimation(700, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.TimerFrameElement01:setAlpha(1)
				f3_arg0.TimerFrameElement01:setZoom(10)
				f3_arg0.TimerFrameElement01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TimerFrameElement01:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.TimerFrameElement01:completeAnimation()
			f3_arg0.TimerFrameElement01:setAlpha(0.8)
			f3_arg0.TimerFrameElement01:setZoom(0)
			f3_local1(f3_arg0.TimerFrameElement01)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(300)
					f10_arg0:setAlpha(0.1)
					f10_arg0:setZoom(0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.TimerFrameElementAdd01:beginAnimation(700, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.TimerFrameElementAdd01:setAlpha(1)
				f3_arg0.TimerFrameElementAdd01:setZoom(30)
				f3_arg0.TimerFrameElementAdd01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TimerFrameElementAdd01:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.TimerFrameElementAdd01:completeAnimation()
			f3_arg0.TimerFrameElementAdd01:setAlpha(0.1)
			f3_arg0.TimerFrameElementAdd01:setZoom(0)
			f3_local2(f3_arg0.TimerFrameElementAdd01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
