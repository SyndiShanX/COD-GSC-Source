CoD.CommonSocialArrow = InheritFrom(LUI.UIElement)
CoD.CommonSocialArrow.__defaultWidth = 24
CoD.CommonSocialArrow.__defaultHeight = 12
CoD.CommonSocialArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonSocialArrow)
	self.id = "CommonSocialArrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SocialArrow03 = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 12)
	SocialArrow03:setAlpha(0.4)
	SocialArrow03:setImage(RegisterImage(0x3350C88BB81ABC4))
	self:addElement(SocialArrow03)
	self.SocialArrow03 = SocialArrow03
	local SocialArrow03Add = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 12)
	SocialArrow03Add:setAlpha(0.2)
	SocialArrow03Add:setImage(RegisterImage(0x3350C88BB81ABC4))
	SocialArrow03Add:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SocialArrow03Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SocialArrow03Add)
	self.SocialArrow03Add = SocialArrow03Add
	local SocialArrow02 = LUI.UIImage.new(0, 0, 8, 16, 0, 0, 0, 12)
	SocialArrow02:setAlpha(0.4)
	SocialArrow02:setImage(RegisterImage(0x3350C88BB81ABC4))
	self:addElement(SocialArrow02)
	self.SocialArrow02 = SocialArrow02
	local SocialArrow02Add = LUI.UIImage.new(0, 0, 8, 16, 0, 0, 0, 12)
	SocialArrow02Add:setAlpha(0.4)
	SocialArrow02Add:setImage(RegisterImage(0x3350C88BB81ABC4))
	SocialArrow02Add:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SocialArrow02Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SocialArrow02Add)
	self.SocialArrow02Add = SocialArrow02Add
	local SocialArrow01 = LUI.UIImage.new(0, 0, 16, 24, 0, 0, 0, 12)
	SocialArrow01:setAlpha(0.4)
	SocialArrow01:setImage(RegisterImage(0x3350C88BB81ABC4))
	self:addElement(SocialArrow01)
	self.SocialArrow01 = SocialArrow01
	local SocialArrow01Add = LUI.UIImage.new(0, 0, 16, 24, 0, 0, 0, 12)
	SocialArrow01Add:setAlpha(0.9)
	SocialArrow01Add:setImage(RegisterImage(0x3350C88BB81ABC4))
	SocialArrow01Add:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SocialArrow01Add:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SocialArrow01Add)
	self.SocialArrow01Add = SocialArrow01Add
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonSocialArrow.__resetProperties = function(f2_arg0)
	f2_arg0.SocialArrow01Add:completeAnimation()
	f2_arg0.SocialArrow02Add:completeAnimation()
	f2_arg0.SocialArrow03Add:completeAnimation()
	f2_arg0.SocialArrow01Add:setAlpha(0.9)
	f2_arg0.SocialArrow02Add:setAlpha(0.4)
	f2_arg0.SocialArrow03Add:setAlpha(0.2)
end
CoD.CommonSocialArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(2000)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.SocialArrow03Add:beginAnimation(1000)
				f3_arg0.SocialArrow03Add:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.SocialArrow03Add:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.SocialArrow03Add:completeAnimation()
			f3_arg0.SocialArrow03Add:setAlpha(0)
			f3_local0(f3_arg0.SocialArrow03Add)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(2500)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(500)
						f10_arg0:setAlpha(0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(500)
					f9_arg0:setAlpha(1)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.SocialArrow02Add:beginAnimation(500)
				f3_arg0.SocialArrow02Add:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.SocialArrow02Add:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.SocialArrow02Add:completeAnimation()
			f3_arg0.SocialArrow02Add:setAlpha(0)
			f3_local1(f3_arg0.SocialArrow02Add)
			local f3_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(3000)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(500)
					f13_arg0:setAlpha(0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.SocialArrow01Add:beginAnimation(500)
				f3_arg0.SocialArrow01Add:setAlpha(1)
				f3_arg0.SocialArrow01Add:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.SocialArrow01Add:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.SocialArrow01Add:completeAnimation()
			f3_arg0.SocialArrow01Add:setAlpha(0)
			f3_local2(f3_arg0.SocialArrow01Add)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
