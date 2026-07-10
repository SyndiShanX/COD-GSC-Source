CoD.vhud_HellstormRing = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormRing.__defaultWidth = 736
CoD.vhud_HellstormRing.__defaultHeight = 736
CoD.vhud_HellstormRing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormRing)
	self.id = "vhud_HellstormRing"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local L1 = LUI.UIImage.new(0, 0, 0, 368, 0, 0, 0, 368)
	L1:setAlpha(0.2)
	L1:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	L1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(L1)
	self.L1 = L1
	local R1 = LUI.UIImage.new(0.5, 0.5, 368, 0, 0, 0, 0, 368)
	R1:setAlpha(0.2)
	R1:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	R1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(R1)
	self.R1 = R1
	local L2 = LUI.UIImage.new(0, 0, 0, 368, 0.5, 0.5, 368, 0)
	L2:setAlpha(0.2)
	L2:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	L2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(L2)
	self.L2 = L2
	local R2 = LUI.UIImage.new(0.5, 0.5, 368, 0, 0.5, 0.5, 368, 0)
	R2:setAlpha(0.2)
	R2:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring"))
	R2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(R2)
	self.R2 = R2
	local GlowL = LUI.UIImage.new(0, 0, 0, 368, 0, 0, 0, 736)
	GlowL:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring_glow"))
	GlowL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GlowL)
	self.GlowL = GlowL
	local GlowR = LUI.UIImage.new(0.5, 0.5, 368, 0, 0, 0, 0, 736)
	GlowR:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ring_glow"))
	GlowR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(GlowR)
	self.GlowR = GlowR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_HellstormRing.__resetProperties = function(f2_arg0)
	f2_arg0.GlowL:completeAnimation()
	f2_arg0.GlowR:completeAnimation()
	f2_arg0.GlowL:setAlpha(1)
	f2_arg0.GlowL:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.GlowR:setAlpha(1)
	f2_arg0.GlowR:setShaderVector(0, 1, 0, 0, 0)
end
CoD.vhud_HellstormRing.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(500)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setShaderVector(0, 1, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.GlowL:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.GlowL:setShaderVector(0, 2, 0, 0, 0)
				f3_arg0.GlowL:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowL:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GlowL:completeAnimation()
			f3_arg0.GlowL:setAlpha(1)
			f3_arg0.GlowL:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.GlowL)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(500)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f8_arg0:setShaderVector(0, 1, 0, 0, 0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.GlowR:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.GlowR:setShaderVector(0, 2, 0, 0, 0)
				f3_arg0.GlowR:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowR:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.GlowR:completeAnimation()
			f3_arg0.GlowR:setAlpha(1)
			f3_arg0.GlowR:setShaderVector(0, 1, 0, 0, 0)
			f3_local1(f3_arg0.GlowR)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
