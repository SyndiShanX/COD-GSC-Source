CoD.vhud_gunship_recticle_25mm = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_recticle_25mm.__defaultWidth = 270
CoD.vhud_gunship_recticle_25mm.__defaultHeight = 256
CoD.vhud_gunship_recticle_25mm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_recticle_25mm)
	self.id = "vhud_gunship_recticle_25mm"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local reticle25Circle = LUI.UIImage.new(0, 0, 126, 144, 0, 0, 119, 137)
	reticle25Circle:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_inner_circle"))
	reticle25Circle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	reticle25Circle:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(reticle25Circle)
	self.reticle25Circle = reticle25Circle
	local reticle25CenterBox = LUI.UIImage.new(0, 0, 113, 157, 0, 0, 106, 150)
	reticle25CenterBox:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_outer_box"))
	reticle25CenterBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	reticle25CenterBox:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(reticle25CenterBox)
	self.reticle25CenterBox = reticle25CenterBox
	local reticle25InnerLineR = LUI.UIImage.new(0, 0, 150, 270, 0, 0, 123, 133)
	reticle25InnerLineR:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_inner_line"))
	self:addElement(reticle25InnerLineR)
	self.reticle25InnerLineR = reticle25InnerLineR
	local reticle25InnerLineL = LUI.UIImage.new(0, 0, 0, 120, 0, 0, 122.5, 132.5)
	reticle25InnerLineL:setZRot(180)
	reticle25InnerLineL:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_inner_line"))
	self:addElement(reticle25InnerLineL)
	self.reticle25InnerLineL = reticle25InnerLineL
	local reticle25InnerLineT = LUI.UIImage.new(0, 0, 75.5, 195.5, 0, 0, 48, 58)
	reticle25InnerLineT:setZRot(90)
	reticle25InnerLineT:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_inner_line"))
	self:addElement(reticle25InnerLineT)
	self.reticle25InnerLineT = reticle25InnerLineT
	local reticle25InnerLineB = LUI.UIImage.new(0, 0, 75, 195, 0, 0, 198.5, 208.5)
	reticle25InnerLineB:setZRot(270)
	reticle25InnerLineB:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_inner_line"))
	self:addElement(reticle25InnerLineB)
	self.reticle25InnerLineB = reticle25InnerLineB
	local reticle25CornerTR = LUI.UIImage.new(0, 0, 213, 263, 0, 0, 0, 50)
	reticle25CornerTR:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_outer_corner"))
	reticle25CornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	reticle25CornerTR:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(reticle25CornerTR)
	self.reticle25CornerTR = reticle25CornerTR
	local reticle25CornerTL = LUI.UIImage.new(0, 0, 7.5, 57.5, 0, 0, 0, 50)
	reticle25CornerTL:setZRot(90)
	reticle25CornerTL:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_outer_corner"))
	reticle25CornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	reticle25CornerTL:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(reticle25CornerTL)
	self.reticle25CornerTL = reticle25CornerTL
	local reticle25CornerBL = LUI.UIImage.new(0, 0, 7, 57, 0, 0, 205.5, 255.5)
	reticle25CornerBL:setZRot(180)
	reticle25CornerBL:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_outer_corner"))
	reticle25CornerBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	reticle25CornerBL:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(reticle25CornerBL)
	self.reticle25CornerBL = reticle25CornerBL
	local reticle25CornerBR = LUI.UIImage.new(0, 0, 213, 263, 0, 0, 206, 256)
	reticle25CornerBR:setZRot(270)
	reticle25CornerBR:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_outer_corner"))
	reticle25CornerBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	reticle25CornerBR:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(reticle25CornerBR)
	self.reticle25CornerBR = reticle25CornerBR
	local reticle25InnerArrows = LUI.UIImage.new(0, 0, 150, 222, 0, 0, 143.5, 215.5)
	reticle25InnerArrows:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_reticle_25_inner_arrows"))
	self:addElement(reticle25InnerArrows)
	self.reticle25InnerArrows = reticle25InnerArrows
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_recticle_25mm.__resetProperties = function(f2_arg0)
	f2_arg0.reticle25CenterBox:completeAnimation()
	f2_arg0.reticle25Circle:completeAnimation()
	f2_arg0.reticle25InnerArrows:completeAnimation()
	f2_arg0.reticle25CenterBox:setAlpha(1)
	f2_arg0.reticle25CenterBox:setScale(1, 1)
	f2_arg0.reticle25CenterBox:setShaderVector(0, 1.5, 0, 0, 0)
	f2_arg0.reticle25Circle:setAlpha(1)
	f2_arg0.reticle25InnerArrows:setAlpha(1)
end
CoD.vhud_gunship_recticle_25mm.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(49)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.reticle25Circle:beginAnimation(300)
				f3_arg0.reticle25Circle:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.reticle25Circle:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.reticle25Circle:completeAnimation()
			f3_arg0.reticle25Circle:setAlpha(0)
			f3_local0(f3_arg0.reticle25Circle)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(49)
						f8_arg0:setShaderVector(0, 1.5, 0, 0, 0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(100)
					f7_arg0:setAlpha(1)
					f7_arg0:setScale(1, 1)
					f7_arg0:setShaderVector(0, 2, 0, 0, 0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.reticle25CenterBox:beginAnimation(100)
				f3_arg0.reticle25CenterBox:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.reticle25CenterBox:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.reticle25CenterBox:completeAnimation()
			f3_arg0.reticle25CenterBox:setAlpha(0)
			f3_arg0.reticle25CenterBox:setScale(2, 2)
			f3_arg0.reticle25CenterBox:setShaderVector(0, 1.5, 0, 0, 0)
			f3_local1(f3_arg0.reticle25CenterBox)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.reticle25InnerArrows:beginAnimation(200)
				f3_arg0.reticle25InnerArrows:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.reticle25InnerArrows:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.reticle25InnerArrows:completeAnimation()
			f3_arg0.reticle25InnerArrows:setAlpha(0)
			f3_local2(f3_arg0.reticle25InnerArrows)
		end,
	},
}
