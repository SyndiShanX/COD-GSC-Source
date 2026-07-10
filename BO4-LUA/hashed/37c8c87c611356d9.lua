CoD.DupeMeterIcon = InheritFrom(LUI.UIElement)
CoD.DupeMeterIcon.__defaultWidth = 20
CoD.DupeMeterIcon.__defaultHeight = 20
CoD.DupeMeterIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DupeMeterIcon)
	self.id = "DupeMeterIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Empty = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	Empty:setRGB(0.6, 0.6, 0.6)
	Empty:setScale(0.9, 0.9)
	Empty:setImage(RegisterImage(@"hash_76EA29FB8CACC5EC"))
	self:addElement(Empty)
	self.Empty = Empty
	local Full = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	Full:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Full:setAlpha(0)
	Full:setImage(RegisterImage(@"hash_F395928C19E9B99"))
	self:addElement(Full)
	self.Full = Full
	local FullPulse = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	FullPulse:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	FullPulse:setAlpha(0)
	FullPulse:setImage(RegisterImage(@"hash_F395928C19E9B99"))
	FullPulse:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(FullPulse)
	self.FullPulse = FullPulse
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DupeMeterIcon.__resetProperties = function(f2_arg0)
	f2_arg0.Empty:completeAnimation()
	f2_arg0.Full:completeAnimation()
	f2_arg0.FullPulse:completeAnimation()
	f2_arg0.Empty:setAlpha(1)
	f2_arg0.Full:setAlpha(0)
	f2_arg0.FullPulse:setAlpha(0)
	f2_arg0.FullPulse:setScale(1, 1)
end
CoD.DupeMeterIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Empty:completeAnimation()
			f3_arg0.Empty:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.Empty)
			f3_arg0.Full:completeAnimation()
			f3_arg0.Full:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Full)
		end,
	},
	Full = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Empty:completeAnimation()
			f4_arg0.Empty:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Empty)
			f4_arg0.Full:completeAnimation()
			f4_arg0.Full:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Full)
		end,
		Pulse = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.Empty:completeAnimation()
			f5_arg0.Empty:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Empty)
			f5_arg0.Full:completeAnimation()
			f5_arg0.Full:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Full)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
					f7_arg0:setAlpha(0)
					f7_arg0:setScale(3, 3)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.FullPulse:beginAnimation(100)
				f5_arg0.FullPulse:setAlpha(1)
				f5_arg0.FullPulse:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.FullPulse:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.FullPulse:completeAnimation()
			f5_arg0.FullPulse:setAlpha(0)
			f5_arg0.FullPulse:setScale(1, 1)
			f5_local0(f5_arg0.FullPulse)
		end,
	},
	Empty = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Full:completeAnimation()
			f8_arg0.Full:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Full)
		end,
	},
}
