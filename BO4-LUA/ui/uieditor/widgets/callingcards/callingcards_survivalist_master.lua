CoD[@"hash_5FBA6FA155C2731A"] = InheritFrom(LUI.UIElement)
CoD[@"hash_5FBA6FA155C2731A"].__defaultWidth = 960
CoD[@"hash_5FBA6FA155C2731A"].__defaultHeight = 240
CoD[@"hash_5FBA6FA155C2731A"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_5FBA6FA155C2731A"])
	self.id = "CallingCards_Survivalist_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(@"uie_callingcards_survivalist_master_background"))
	background:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	background:setShaderVector(0, 0, 3, 0, 0)
	background:setShaderVector(1, 12, 0, 0, 0)
	self:addElement(background)
	self.background = background
	local clouds = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	clouds:setAlpha(0.3)
	clouds:setImage(RegisterImage(@"uie_callingcards_survivalist_master_clouds"))
	clouds:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	clouds:setShaderVector(0, 0, 3, 0, 0)
	clouds:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(clouds)
	self.clouds = clouds
	local dude2 = LUI.UIImage.new(0, 0, 427.5, 507.5, 0, 0, 74, 146)
	dude2:setImage(RegisterImage(@"uie_callingcards_survivalist_master_dude2"))
	self:addElement(dude2)
	self.dude2 = dude2
	local dude1 = LUI.UIImage.new(0, 0, 620.5, 932.5, 0, 0, 16, 240)
	dude1:setImage(RegisterImage(@"uie_callingcards_survivalist_master_dude1"))
	dude1:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	dude1:setShaderVector(0, 0, 3, 0, 0)
	dude1:setShaderVector(1, 18, 0, 0, 0)
	self:addElement(dude1)
	self.dude1 = dude1
	local particles = LUI.UIImage.new(0, 0, -6.5, 967.5, 0, 0, -4.5, 244.5)
	particles:setAlpha(0.25)
	particles:setZRot(6)
	particles:setImage(RegisterImage(@"uie_callingcards_survivalist_master_particles"))
	particles:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	particles:setShaderVector(0, 1, 1, 0, 0)
	particles:setShaderVector(1, 0, -4, 0, 0)
	self:addElement(particles)
	self.particles = particles
	local vignette = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	vignette:setImage(RegisterImage(@"uie_callingcards_survivalist_master_vignette"))
	self:addElement(vignette)
	self.vignette = vignette
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(@"uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_5FBA6FA155C2731A"].__resetProperties = function(f2_arg0)
	f2_arg0.dude1:completeAnimation()
	f2_arg0.dude2:completeAnimation()
	f2_arg0.cropper:completeAnimation()
	f2_arg0.dude1:setLeftRight(0, 0, 620.5, 932.5)
	f2_arg0.dude1:setTopBottom(0, 0, 16, 240)
	f2_arg0.dude1:setZRot(0)
	f2_arg0.dude1:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	f2_arg0.dude1:setShaderVector(0, 0, 3, 0, 0)
	f2_arg0.dude1:setShaderVector(1, 18, 0, 0, 0)
	f2_arg0.dude2:setLeftRight(0, 0, 427.5, 507.5)
	f2_arg0.dude2:setTopBottom(0, 0, 74, 146)
	f2_arg0.dude2:setZRot(0)
	f2_arg0.cropper:setAlpha(0)
end
CoD[@"hash_5FBA6FA155C2731A"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(639)
						f6_arg0:setLeftRight(0, 0, 427.5, 507.5)
						f6_arg0:setTopBottom(0, 0, 74, 146)
						f6_arg0:setZRot(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(740)
					f5_arg0:setLeftRight(0, 0, 433, 513)
					f5_arg0:setTopBottom(0, 0, 69.5, 141.5)
					f5_arg0:setZRot(-2)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.dude2:beginAnimation(700)
				f3_arg0.dude2:setLeftRight(0, 0, 447.5, 527.5)
				f3_arg0.dude2:setZRot(19)
				f3_arg0.dude2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dude2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.dude2:completeAnimation()
			f3_arg0.dude2:setLeftRight(0, 0, 427.5, 507.5)
			f3_arg0.dude2:setTopBottom(0, 0, 74, 146)
			f3_arg0.dude2:setZRot(0)
			f3_local0(f3_arg0.dude2)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(539)
						f9_arg0:setLeftRight(0, 0, 620.5, 932.5)
						f9_arg0:setTopBottom(0, 0, 16, 240)
						f9_arg0:setZRot(0)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(229)
					f8_arg0:setLeftRight(0, 0, 537, 849)
					f8_arg0:setTopBottom(0, 0, 56.5, 280.5)
					f8_arg0:setZRot(-29)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.dude1:beginAnimation(1320)
				f3_arg0.dude1:setLeftRight(0, 0, 501.5, 813.5)
				f3_arg0.dude1:setTopBottom(0, 0, 74, 298)
				f3_arg0.dude1:setZRot(-23)
				f3_arg0.dude1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dude1:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.dude1:completeAnimation()
			f3_arg0.dude1:setLeftRight(0, 0, 620.5, 932.5)
			f3_arg0.dude1:setTopBottom(0, 0, 16, 240)
			f3_arg0.dude1:setZRot(0)
			f3_arg0.dude1:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
			f3_arg0.dude1:setShaderVector(0, 0, 3, 0, 0)
			f3_arg0.dude1:setShaderVector(1, 9, 0, 0, 0)
			f3_local1(f3_arg0.dude1)
			local f3_local2 = function(f10_arg0)
				f3_arg0.cropper:beginAnimation(40)
				f3_arg0.cropper:setAlpha(1)
				f3_arg0.cropper:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cropper:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.cropper:completeAnimation()
			f3_arg0.cropper:setAlpha(0)
			f3_local2(f3_arg0.cropper)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
