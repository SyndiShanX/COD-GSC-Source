require("x64:6ee653ade3452f5")
require("x64:3ffeed41a0295c5")
require("x64:14999ad4356466")
require("x64:d2b07b098532876")
require("x64:b9c6f6499cb39da")
require("x64:8819c673a5c0a5c")
CoD.vhud_dart_PC_reticleBacking = InheritFrom(LUI.UIElement)
CoD.vhud_dart_PC_reticleBacking.__defaultWidth = 1920
CoD.vhud_dart_PC_reticleBacking.__defaultHeight = 1165
CoD.vhud_dart_PC_reticleBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_dart_PC_reticleBacking)
	self.id = "vhud_dart_PC_reticleBacking"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ScorestreakAspectRatioFix:setAlpha(0.5)
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local CenterGlowRing = CoD.vhud_HellstormRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -368, 368, 0.5, 0.5, -370, 366)
	CenterGlowRing:setAlpha(0.01)
	CenterGlowRing:setScale(2.3, 2.3)
	self:addElement(CenterGlowRing)
	self.CenterGlowRing = CenterGlowRing
	local vignette02 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	vignette02:setRGB(0, 0, 0)
	vignette02:setAlpha(0.4)
	vignette02:setImage(RegisterImage(0xB8D7548F3591A70))
	self:addElement(vignette02)
	self.vignette02 = vignette02
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledShaderImage:setAlpha(0.55)
	TiledShaderImage:setImage(RegisterImage(0xEDF02F55208D0A6))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(64, 64)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local vhuddartCenterReticleOuterCircleDots = CoD.vhud_dart_CenterReticleOuterCircleDots.new(f1_arg0, f1_arg1, 0.5, 0.5, -299, 299, 0.5, 0.5, -153, 146)
	self:addElement(vhuddartCenterReticleOuterCircleDots)
	self.vhuddartCenterReticleOuterCircleDots = vhuddartCenterReticleOuterCircleDots
	local CenterReticleCircleBlurRGB = LUI.UIImage.new(0.5, 0.5, -116, 116, 0.5, 0.5, -118, 114)
	CenterReticleCircleBlurRGB:setAlpha(0.5)
	CenterReticleCircleBlurRGB:setImage(RegisterImage(0x2A55E154C88B2CC))
	CenterReticleCircleBlurRGB:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(CenterReticleCircleBlurRGB)
	self.CenterReticleCircleBlurRGB = CenterReticleCircleBlurRGB
	local layoutDotlineGrid = CoD.vhud_layoutDotlineGrid.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	layoutDotlineGrid:setAlpha(0.8)
	self:addElement(layoutDotlineGrid)
	self.layoutDotlineGrid = layoutDotlineGrid
	local vehicleHudCommonLayout = CoD.vhud_layoutFuiElements.new(f1_arg0, f1_arg1, 0.5, 0.5, -935, 933, 0.5, 0.5, -508, 374)
	self:addElement(vehicleHudCommonLayout)
	self.vehicleHudCommonLayout = vehicleHudCommonLayout
	local layoutPlusGrid = CoD.vhud_layoutPlusGridLarge.new(f1_arg0, f1_arg1, 0.5, 0.5, -441.5, 441.5, 0.5, 0.5, -334.5, 332.5)
	self:addElement(layoutPlusGrid)
	self.layoutPlusGrid = layoutPlusGrid
	local vignette01 = LUI.UIImage.new(0.5, 0.5, -960, 960, 0, 1, 0, 0)
	vignette01:setRGB(0, 0, 0)
	vignette01:setAlpha(0.5)
	vignette01:setImage(RegisterImage(0xB8D7548F3591A70))
	self:addElement(vignette01)
	self.vignette01 = vignette01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_dart_PC_reticleBacking.__resetProperties = function(f2_arg0)
	f2_arg0.TiledShaderImage:completeAnimation()
	f2_arg0.vehicleHudCommonLayout:completeAnimation()
	f2_arg0.layoutDotlineGrid:completeAnimation()
	f2_arg0.CenterReticleCircleBlurRGB:completeAnimation()
	f2_arg0.vhuddartCenterReticleOuterCircleDots:completeAnimation()
	f2_arg0.TiledShaderImage:setAlpha(0.55)
	f2_arg0.vehicleHudCommonLayout:setAlpha(1)
	f2_arg0.layoutDotlineGrid:setAlpha(0.8)
	f2_arg0.CenterReticleCircleBlurRGB:setAlpha(0.5)
	f2_arg0.CenterReticleCircleBlurRGB:setZRot(0)
	f2_arg0.vhuddartCenterReticleOuterCircleDots:setAlpha(1)
end
CoD.vhud_dart_PC_reticleBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(19)
					f5_arg0:setAlpha(0.55)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.TiledShaderImage:beginAnimation(300)
				f3_arg0.TiledShaderImage:setAlpha(0.6)
				f3_arg0.TiledShaderImage:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TiledShaderImage:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.TiledShaderImage:completeAnimation()
			f3_arg0.TiledShaderImage:setAlpha(0)
			f3_local0(f3_arg0.TiledShaderImage)
			local f3_local1 = function(f6_arg0)
				f6_arg0:beginAnimation(19)
				f6_arg0:setAlpha(1)
				f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.vhuddartCenterReticleOuterCircleDots:beginAnimation(300)
			f3_arg0.vhuddartCenterReticleOuterCircleDots:setAlpha(0)
			f3_arg0.vhuddartCenterReticleOuterCircleDots:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.vhuddartCenterReticleOuterCircleDots:registerEventHandler("transition_complete_keyframe", f3_local1)
			local f3_local2 = function(f7_arg0)
				f7_arg0:beginAnimation(200)
				f7_arg0:setAlpha(1)
				f7_arg0:setZRot(0)
				f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.CenterReticleCircleBlurRGB:beginAnimation(100)
			f3_arg0.CenterReticleCircleBlurRGB:setAlpha(0)
			f3_arg0.CenterReticleCircleBlurRGB:setZRot(90)
			f3_arg0.CenterReticleCircleBlurRGB:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.CenterReticleCircleBlurRGB:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(100)
					f9_arg0:setAlpha(0.8)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.layoutDotlineGrid:beginAnimation(200)
				f3_arg0.layoutDotlineGrid:setAlpha(1)
				f3_arg0.layoutDotlineGrid:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.layoutDotlineGrid:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.layoutDotlineGrid:completeAnimation()
			f3_arg0.layoutDotlineGrid:setAlpha(0)
			f3_local3(f3_arg0.layoutDotlineGrid)
			local f3_local4 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							local f13_local0 = function(f14_arg0)
								local f14_local0 = function(f15_arg0)
									f15_arg0:beginAnimation(19)
									f15_arg0:setAlpha(1)
									f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f14_arg0:beginAnimation(20)
								f14_arg0:setAlpha(0.2)
								f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
							end
							f13_arg0:beginAnimation(19)
							f13_arg0:setAlpha(0.9)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
						end
						f12_arg0:beginAnimation(20)
						f12_arg0:setAlpha(0.1)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(19)
					f11_arg0:setAlpha(0.9)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f3_arg0.vehicleHudCommonLayout:beginAnimation(100)
				f3_arg0.vehicleHudCommonLayout:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.vehicleHudCommonLayout:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.vehicleHudCommonLayout:completeAnimation()
			f3_arg0.vehicleHudCommonLayout:setAlpha(0)
			f3_local4(f3_arg0.vehicleHudCommonLayout)
		end,
	},
}
CoD.vhud_dart_PC_reticleBacking.__onClose = function(f16_arg0)
	f16_arg0.ScorestreakAspectRatioFix:close()
	f16_arg0.CenterGlowRing:close()
	f16_arg0.vhuddartCenterReticleOuterCircleDots:close()
	f16_arg0.layoutDotlineGrid:close()
	f16_arg0.vehicleHudCommonLayout:close()
	f16_arg0.layoutPlusGrid:close()
end
