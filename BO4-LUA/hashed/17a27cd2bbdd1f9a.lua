CoD.TabletConnectionArrow = InheritFrom(LUI.UIElement)
CoD.TabletConnectionArrow.__defaultWidth = 65
CoD.TabletConnectionArrow.__defaultHeight = 31
CoD.TabletConnectionArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletConnectionArrow)
	self.id = "TabletConnectionArrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RightArrow03 = LUI.UIImage.new(1, 1, -65, -41, 0, 0, 0.5, 30.5)
	RightArrow03:setImage(RegisterImage(0xB74F856BFDB37C1))
	self:addElement(RightArrow03)
	self.RightArrow03 = RightArrow03
	local RightArrow02 = LUI.UIImage.new(1, 1, -52, -28, 0, 0, 0.5, 30.5)
	RightArrow02:setImage(RegisterImage(0xB74F856BFDB37C1))
	self:addElement(RightArrow02)
	self.RightArrow02 = RightArrow02
	local RightArrow01 = LUI.UIImage.new(1, 1, -39, -15, 0, 0, 0.5, 30.5)
	RightArrow01:setImage(RegisterImage(0xB74F856BFDB37C1))
	self:addElement(RightArrow01)
	self.RightArrow01 = RightArrow01
	local RightArrow00 = LUI.UIImage.new(0, 0, 38.5, 64.5, 0, 0, 0, 30)
	RightArrow00:setImage(RegisterImage(0xB74F556BFDB32A8))
	self:addElement(RightArrow00)
	self.RightArrow00 = RightArrow00
	local RightArrowAdd03 = LUI.UIImage.new(1, 1, -65, -41, 0, 0, 0.5, 30.5)
	RightArrowAdd03:setAlpha(0)
	RightArrowAdd03:setImage(RegisterImage(0xB74F856BFDB37C1))
	RightArrowAdd03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	RightArrowAdd03:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(RightArrowAdd03)
	self.RightArrowAdd03 = RightArrowAdd03
	local RightArrowAdd02 = LUI.UIImage.new(1, 1, -52, -28, 0, 0, 0.5, 30.5)
	RightArrowAdd02:setAlpha(0)
	RightArrowAdd02:setImage(RegisterImage(0xB74F856BFDB37C1))
	RightArrowAdd02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	RightArrowAdd02:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(RightArrowAdd02)
	self.RightArrowAdd02 = RightArrowAdd02
	local RightArrowAdd01 = LUI.UIImage.new(1, 1, -39, -15, 0, 0, 0.5, 30.5)
	RightArrowAdd01:setAlpha(0)
	RightArrowAdd01:setImage(RegisterImage(0xB74F856BFDB37C1))
	RightArrowAdd01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	RightArrowAdd01:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(RightArrowAdd01)
	self.RightArrowAdd01 = RightArrowAdd01
	local RightArrowAdd00 = LUI.UIImage.new(0, 0, 38.5, 64.5, 0, 0, 0, 30)
	RightArrowAdd00:setAlpha(0)
	RightArrowAdd00:setImage(RegisterImage(0xB74F556BFDB32A8))
	RightArrowAdd00:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	RightArrowAdd00:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(RightArrowAdd00)
	self.RightArrowAdd00 = RightArrowAdd00
	self:mergeStateConditions({
		{
			stateName = "Linked",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "TeammateHealTargeting", "targetClientNum", LuaDefine.INVALID_CLIENT_INDEX)
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = DataSources.TeammateHealTargeting.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.targetClientNum, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "targetClientNum",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletConnectionArrow.__resetProperties = function(f4_arg0)
	f4_arg0.RightArrowAdd03:completeAnimation()
	f4_arg0.RightArrowAdd02:completeAnimation()
	f4_arg0.RightArrowAdd01:completeAnimation()
	f4_arg0.RightArrowAdd00:completeAnimation()
	f4_arg0.RightArrowAdd03:setAlpha(0)
	f4_arg0.RightArrowAdd02:setAlpha(0)
	f4_arg0.RightArrowAdd01:setAlpha(0)
	f4_arg0.RightArrowAdd00:setAlpha(0)
end
CoD.TabletConnectionArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.RightArrowAdd03:completeAnimation()
			f5_arg0.RightArrowAdd03:setAlpha(0.05)
			f5_arg0.clipFinished(f5_arg0.RightArrowAdd03)
			f5_arg0.RightArrowAdd02:completeAnimation()
			f5_arg0.RightArrowAdd02:setAlpha(0.05)
			f5_arg0.clipFinished(f5_arg0.RightArrowAdd02)
			f5_arg0.RightArrowAdd01:completeAnimation()
			f5_arg0.RightArrowAdd01:setAlpha(0.05)
			f5_arg0.clipFinished(f5_arg0.RightArrowAdd01)
			f5_arg0.RightArrowAdd00:completeAnimation()
			f5_arg0.RightArrowAdd00:setAlpha(0.05)
			f5_arg0.clipFinished(f5_arg0.RightArrowAdd00)
		end,
		Intro = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							f10_arg0:beginAnimation(199)
							f10_arg0:setAlpha(0.05)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
						end
						f9_arg0:beginAnimation(250)
						f9_arg0:setAlpha(1)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(750)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.RightArrowAdd03:beginAnimation(200)
				f6_arg0.RightArrowAdd03:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.RightArrowAdd03:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.RightArrowAdd03:completeAnimation()
			f6_arg0.RightArrowAdd03:setAlpha(0.05)
			f6_local0(f6_arg0.RightArrowAdd03)
			local f6_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							local f14_local0 = function(f15_arg0)
								f15_arg0:beginAnimation(199)
								f15_arg0:setAlpha(0.05)
								f15_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
							end
							f14_arg0:beginAnimation(250)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
						end
						f13_arg0:beginAnimation(250)
						f13_arg0:setAlpha(1)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(500)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f6_arg0.RightArrowAdd02:beginAnimation(200)
				f6_arg0.RightArrowAdd02:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.RightArrowAdd02:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f6_arg0.RightArrowAdd02:completeAnimation()
			f6_arg0.RightArrowAdd02:setAlpha(0.05)
			f6_local1(f6_arg0.RightArrowAdd02)
			local f6_local2 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						local f18_local0 = function(f19_arg0)
							local f19_local0 = function(f20_arg0)
								f20_arg0:beginAnimation(199)
								f20_arg0:setAlpha(0.05)
								f20_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
							end
							f19_arg0:beginAnimation(500)
							f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
						end
						f18_arg0:beginAnimation(250)
						f18_arg0:setAlpha(1)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
					end
					f17_arg0:beginAnimation(249)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f6_arg0.RightArrowAdd01:beginAnimation(200)
				f6_arg0.RightArrowAdd01:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.RightArrowAdd01:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f6_arg0.RightArrowAdd01:completeAnimation()
			f6_arg0.RightArrowAdd01:setAlpha(0.05)
			f6_local2(f6_arg0.RightArrowAdd01)
			local f6_local3 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						local f23_local0 = function(f24_arg0)
							f24_arg0:beginAnimation(199)
							f24_arg0:setAlpha(0.05)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
						end
						f23_arg0:beginAnimation(750)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(249)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f6_arg0.RightArrowAdd00:beginAnimation(200)
				f6_arg0.RightArrowAdd00:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.RightArrowAdd00:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f6_arg0.RightArrowAdd00:completeAnimation()
			f6_arg0.RightArrowAdd00:setAlpha(0.05)
			f6_local3(f6_arg0.RightArrowAdd00)
		end,
	},
	Linked = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(250, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f27_arg0:setAlpha(1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.RightArrowAdd03:beginAnimation(750)
				f25_arg0.RightArrowAdd03:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.RightArrowAdd03:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.RightArrowAdd03:completeAnimation()
			f25_arg0.RightArrowAdd03:setAlpha(0.05)
			f25_local0(f25_arg0.RightArrowAdd03)
			local f25_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					local f29_local0 = function(f30_arg0)
						f30_arg0:beginAnimation(250)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
					end
					f29_arg0:beginAnimation(250, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f25_arg0.RightArrowAdd02:beginAnimation(500)
				f25_arg0.RightArrowAdd02:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.RightArrowAdd02:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f25_arg0.RightArrowAdd02:completeAnimation()
			f25_arg0.RightArrowAdd02:setAlpha(0.05)
			f25_local1(f25_arg0.RightArrowAdd02)
			local f25_local2 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						f33_arg0:beginAnimation(500)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
					end
					f32_arg0:beginAnimation(250, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f25_arg0.RightArrowAdd01:beginAnimation(250)
				f25_arg0.RightArrowAdd01:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.RightArrowAdd01:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f25_arg0.RightArrowAdd01:completeAnimation()
			f25_arg0.RightArrowAdd01:setAlpha(0.05)
			f25_local2(f25_arg0.RightArrowAdd01)
			local f25_local3 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(750)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.RightArrowAdd00:beginAnimation(250, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f25_arg0.RightArrowAdd00:setAlpha(1)
				f25_arg0.RightArrowAdd00:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.RightArrowAdd00:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f25_arg0.RightArrowAdd00:completeAnimation()
			f25_arg0.RightArrowAdd00:setAlpha(0.05)
			f25_local3(f25_arg0.RightArrowAdd00)
			f25_arg0.nextClip = "DefaultClip"
		end,
	},
}
