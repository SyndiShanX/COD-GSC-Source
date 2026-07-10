CoD.outofbounds_box_arrow = InheritFrom(LUI.UIElement)
CoD.outofbounds_box_arrow.__defaultWidth = 127
CoD.outofbounds_box_arrow.__defaultHeight = 64
CoD.outofbounds_box_arrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_box_arrow)
	self.id = "outofbounds_box_arrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArrowSmall03 = LUI.UIImage.new(0, 0, 80.5, 126.5, 0, 0, 0, 64)
	ArrowSmall03:setAlpha(0.4)
	ArrowSmall03:setImage(RegisterImage(0x231C23C30759AA1))
	ArrowSmall03:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(ArrowSmall03)
	self.ArrowSmall03 = ArrowSmall03
	local ArrowSmallAdd03 = LUI.UIImage.new(0, 0, 80.5, 126.5, 0, 0, 0, 64)
	ArrowSmallAdd03:setAlpha(0)
	ArrowSmallAdd03:setImage(RegisterImage(0x231C23C30759AA1))
	ArrowSmallAdd03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ArrowSmallAdd03:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ArrowSmallAdd03)
	self.ArrowSmallAdd03 = ArrowSmallAdd03
	local ArrowSmall02 = LUI.UIImage.new(0, 0, 40.5, 86.5, 0, 0, 0, 64)
	ArrowSmall02:setAlpha(0.4)
	ArrowSmall02:setImage(RegisterImage(0x231C23C30759AA1))
	ArrowSmall02:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(ArrowSmall02)
	self.ArrowSmall02 = ArrowSmall02
	local ArrowSmallAdd02 = LUI.UIImage.new(0, 0, 40.5, 86.5, 0, 0, 0, 64)
	ArrowSmallAdd02:setAlpha(0)
	ArrowSmallAdd02:setImage(RegisterImage(0x231C23C30759AA1))
	ArrowSmallAdd02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ArrowSmallAdd02:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ArrowSmallAdd02)
	self.ArrowSmallAdd02 = ArrowSmallAdd02
	local ArrowSmall01 = LUI.UIImage.new(0, 0, 0, 46, 0, 0, 0, 64)
	ArrowSmall01:setAlpha(0.4)
	ArrowSmall01:setImage(RegisterImage(0x231C23C30759AA1))
	ArrowSmall01:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(ArrowSmall01)
	self.ArrowSmall01 = ArrowSmall01
	local ArrowSmallAdd01 = LUI.UIImage.new(0, 0, 0, 46, 0, 0, 0, 64)
	ArrowSmallAdd01:setAlpha(0)
	ArrowSmallAdd01:setImage(RegisterImage(0x231C23C30759AA1))
	ArrowSmallAdd01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ArrowSmallAdd01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ArrowSmallAdd01)
	self.ArrowSmallAdd01 = ArrowSmallAdd01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.outofbounds_box_arrow.__resetProperties = function(f2_arg0)
	f2_arg0.ArrowSmall01:completeAnimation()
	f2_arg0.ArrowSmall02:completeAnimation()
	f2_arg0.ArrowSmallAdd03:completeAnimation()
	f2_arg0.ArrowSmall03:completeAnimation()
	f2_arg0.ArrowSmallAdd01:completeAnimation()
	f2_arg0.ArrowSmallAdd02:completeAnimation()
	f2_arg0.ArrowSmall01:setAlpha(0.4)
	f2_arg0.ArrowSmall02:setAlpha(0.4)
	f2_arg0.ArrowSmallAdd03:setAlpha(0)
	f2_arg0.ArrowSmall03:setAlpha(0.4)
	f2_arg0.ArrowSmallAdd01:setAlpha(0)
	f2_arg0.ArrowSmallAdd01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.ArrowSmallAdd01:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.ArrowSmallAdd02:setAlpha(0)
end
CoD.outofbounds_box_arrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(6)
			f3_arg0.ArrowSmall03:completeAnimation()
			f3_arg0.ArrowSmall03:setAlpha(0.4)
			f3_arg0.clipFinished(f3_arg0.ArrowSmall03)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(300)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setAlpha(0.4)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.ArrowSmallAdd03:beginAnimation(400)
				f3_arg0.ArrowSmallAdd03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ArrowSmallAdd03:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ArrowSmallAdd03:completeAnimation()
			f3_arg0.ArrowSmallAdd03:setAlpha(0)
			f3_local0(f3_arg0.ArrowSmallAdd03)
			f3_arg0.ArrowSmall02:completeAnimation()
			f3_arg0.ArrowSmall02:setAlpha(0.4)
			f3_arg0.clipFinished(f3_arg0.ArrowSmall02)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
							f11_arg0:setAlpha(0)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(350)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f9_arg0:setAlpha(0.6)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.ArrowSmallAdd02:beginAnimation(200)
				f3_arg0.ArrowSmallAdd02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ArrowSmallAdd02:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.ArrowSmallAdd02:completeAnimation()
			f3_arg0.ArrowSmallAdd02:setAlpha(0)
			f3_local1(f3_arg0.ArrowSmallAdd02)
			f3_arg0.ArrowSmall01:completeAnimation()
			f3_arg0.ArrowSmall01:setAlpha(0.4)
			f3_arg0.clipFinished(f3_arg0.ArrowSmall01)
			local f3_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(400)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.ArrowSmallAdd01:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.ArrowSmallAdd01:setAlpha(1)
				f3_arg0.ArrowSmallAdd01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ArrowSmallAdd01:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.ArrowSmallAdd01:completeAnimation()
			f3_arg0.ArrowSmallAdd01:setAlpha(0)
			f3_arg0.ArrowSmallAdd01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.ArrowSmallAdd01:setShaderVector(0, 1, 0, 0, 0)
			f3_local2(f3_arg0.ArrowSmallAdd01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
