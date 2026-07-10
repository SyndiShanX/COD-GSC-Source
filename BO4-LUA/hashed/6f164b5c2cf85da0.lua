CoD.Tak5ReticleBracketBoxes = InheritFrom(LUI.UIElement)
CoD.Tak5ReticleBracketBoxes.__defaultWidth = 46
CoD.Tak5ReticleBracketBoxes.__defaultHeight = 16
CoD.Tak5ReticleBracketBoxes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tak5ReticleBracketBoxes)
	self.id = "Tak5ReticleBracketBoxes"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReticleBox03 = LUI.UIImage.new(0, 0, 30, 46, 0, 0, 0, 16)
	ReticleBox03:setAlpha(0.2)
	ReticleBox03:setImage(RegisterImage(0xD3A68D4E41728CE))
	self:addElement(ReticleBox03)
	self.ReticleBox03 = ReticleBox03
	local ReticleBox03Add = LUI.UIImage.new(0, 0, 30, 46, 0, 0, 0, 16)
	ReticleBox03Add:setAlpha(0)
	ReticleBox03Add:setImage(RegisterImage(0xD3A68D4E41728CE))
	ReticleBox03Add:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ReticleBox03Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ReticleBox03Add)
	self.ReticleBox03Add = ReticleBox03Add
	local ReticleBox02 = LUI.UIImage.new(0, 0, 15, 31, 0, 0, 0, 16)
	ReticleBox02:setAlpha(0.5)
	ReticleBox02:setImage(RegisterImage(0xD3A68D4E41728CE))
	self:addElement(ReticleBox02)
	self.ReticleBox02 = ReticleBox02
	local ReticleBox02Add = LUI.UIImage.new(0, 0, 15, 31, 0, 0, 0, 16)
	ReticleBox02Add:setAlpha(0)
	ReticleBox02Add:setImage(RegisterImage(0xD3A68D4E41728CE))
	ReticleBox02Add:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ReticleBox02Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ReticleBox02Add)
	self.ReticleBox02Add = ReticleBox02Add
	local ReticleBox01 = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 0, 16)
	ReticleBox01:setImage(RegisterImage(0xD3A68D4E41728CE))
	self:addElement(ReticleBox01)
	self.ReticleBox01 = ReticleBox01
	local ReticleBox01Add = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 0, 16)
	ReticleBox01Add:setAlpha(0)
	ReticleBox01Add:setImage(RegisterImage(0xD3A68D4E41728CE))
	ReticleBox01Add:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ReticleBox01Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ReticleBox01Add)
	self.ReticleBox01Add = ReticleBox01Add
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Tak5ReticleBracketBoxes.__resetProperties = function(f2_arg0)
	f2_arg0.ReticleBox03Add:completeAnimation()
	f2_arg0.ReticleBox02Add:completeAnimation()
	f2_arg0.ReticleBox01Add:completeAnimation()
	f2_arg0.ReticleBox03Add:setAlpha(0)
	f2_arg0.ReticleBox02Add:setAlpha(0)
	f2_arg0.ReticleBox01Add:setAlpha(0)
end
CoD.Tak5ReticleBracketBoxes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.ReticleBox03Add:beginAnimation(200)
				f3_arg0.ReticleBox03Add:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ReticleBox03Add:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ReticleBox03Add:completeAnimation()
			f3_arg0.ReticleBox03Add:setAlpha(0)
			f3_local0(f3_arg0.ReticleBox03Add)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f9_arg0:setAlpha(0)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.ReticleBox02Add:beginAnimation(400)
				f3_arg0.ReticleBox02Add:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ReticleBox02Add:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.ReticleBox02Add:completeAnimation()
			f3_arg0.ReticleBox02Add:setAlpha(0)
			f3_local1(f3_arg0.ReticleBox02Add)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f12_arg0:setAlpha(0)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f3_arg0.ReticleBox01Add:beginAnimation(600)
				f3_arg0.ReticleBox01Add:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ReticleBox01Add:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.ReticleBox01Add:completeAnimation()
			f3_arg0.ReticleBox01Add:setAlpha(0)
			f3_local2(f3_arg0.ReticleBox01Add)
		end,
	},
}
