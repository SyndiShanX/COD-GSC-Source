CoD.TabletIcePickGadget_BgElementLines = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_BgElementLines.__defaultWidth = 300
CoD.TabletIcePickGadget_BgElementLines.__defaultHeight = 164
CoD.TabletIcePickGadget_BgElementLines.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_BgElementLines)
	self.id = "TabletIcePickGadget_BgElementLines"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Line05FUI = LUI.UIImage.new(0, 0, 0, 316, 0, 0, 8.5, 148.5)
	Line05FUI:setImage(RegisterImage(0xF7CA55290E2D1E5))
	Line05FUI:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Line05FUI:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(Line05FUI)
	self.Line05FUI = Line05FUI
	local Line04FUI = LUI.UIImage.new(0, 0, 0, 260, 0, 0, -5, 139)
	Line04FUI:setImage(RegisterImage(0xF7CA45290E2D032))
	Line04FUI:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Line04FUI:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(Line04FUI)
	self.Line04FUI = Line04FUI
	local Line03FUI = LUI.UIImage.new(0, 0, -18, 242, 0, 0, 18, 182)
	Line03FUI:setImage(RegisterImage(0xF7C9F5290E2C7B3))
	Line03FUI:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Line03FUI:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(Line03FUI)
	self.Line03FUI = Line03FUI
	local Line02FUI = LUI.UIImage.new(0, 0, 0, 320, 0, 0, 0, 128)
	Line02FUI:setImage(RegisterImage(0xF7C9E5290E2C600))
	Line02FUI:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Line02FUI:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(Line02FUI)
	self.Line02FUI = Line02FUI
	local Line01FUI = LUI.UIImage.new(0, 0, 0, 216, 0, 0, -9, 127)
	Line01FUI:setImage(RegisterImage(0xF7CA15290E2CB19))
	Line01FUI:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Line01FUI:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(Line01FUI)
	self.Line01FUI = Line01FUI
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePickGadget_BgElementLines.__resetProperties = function(f2_arg0)
	f2_arg0.Line04FUI:completeAnimation()
	f2_arg0.Line03FUI:completeAnimation()
	f2_arg0.Line02FUI:completeAnimation()
	f2_arg0.Line01FUI:completeAnimation()
	f2_arg0.Line05FUI:completeAnimation()
	f2_arg0.Line04FUI:setAlpha(1)
	f2_arg0.Line03FUI:setAlpha(1)
	f2_arg0.Line02FUI:setAlpha(1)
	f2_arg0.Line01FUI:setAlpha(1)
	f2_arg0.Line05FUI:setAlpha(1)
end
CoD.TabletIcePickGadget_BgElementLines.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											f11_arg0:beginAnimation(19)
											f11_arg0:setAlpha(0)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f10_arg0:beginAnimation(60)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(19)
									f9_arg0:setAlpha(0.8)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(400)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(20)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(60)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(19)
					f5_arg0:setAlpha(0.8)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Line05FUI:beginAnimation(300)
				f3_arg0.Line05FUI:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Line05FUI:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Line05FUI:completeAnimation()
			f3_arg0.Line05FUI:setAlpha(0)
			f3_local0(f3_arg0.Line05FUI)
			local f3_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									local f17_local0 = function(f18_arg0)
										local f18_local0 = function(f19_arg0)
											local f19_local0 = function(f20_arg0)
												local f20_local0 = function(f21_arg0)
													local f21_local0 = function(f22_arg0)
														local f22_local0 = function(f23_arg0)
															f23_arg0:beginAnimation(19)
															f23_arg0:setAlpha(0)
															f23_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f22_arg0:beginAnimation(60)
														f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
													end
													f21_arg0:beginAnimation(20)
													f21_arg0:setAlpha(0.7)
													f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
												end
												f20_arg0:beginAnimation(99)
												f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
											end
											f19_arg0:beginAnimation(20)
											f19_arg0:setAlpha(0)
											f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
										end
										f18_arg0:beginAnimation(59)
										f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
									end
									f17_arg0:beginAnimation(20)
									f17_arg0:setAlpha(0.6)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
								end
								f16_arg0:beginAnimation(199)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(20)
							f15_arg0:setAlpha(0)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(60)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(19)
					f13_arg0:setAlpha(0.8)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.Line04FUI:beginAnimation(400)
				f3_arg0.Line04FUI:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Line04FUI:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.Line04FUI:completeAnimation()
			f3_arg0.Line04FUI:setAlpha(0)
			f3_local1(f3_arg0.Line04FUI)
			local f3_local2 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						local f26_local0 = function(f27_arg0)
							local f27_local0 = function(f28_arg0)
								local f28_local0 = function(f29_arg0)
									local f29_local0 = function(f30_arg0)
										local f30_local0 = function(f31_arg0)
											f31_arg0:beginAnimation(19)
											f31_arg0:setAlpha(0)
											f31_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f30_arg0:beginAnimation(60)
										f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
									end
									f29_arg0:beginAnimation(19)
									f29_arg0:setAlpha(0.6)
									f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
								end
								f28_arg0:beginAnimation(300)
								f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
							end
							f27_arg0:beginAnimation(20)
							f27_arg0:setAlpha(0)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
						end
						f26_arg0:beginAnimation(60)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(19)
					f25_arg0:setAlpha(0.7)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f3_arg0.Line03FUI:beginAnimation(200)
				f3_arg0.Line03FUI:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Line03FUI:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f3_arg0.Line03FUI:completeAnimation()
			f3_arg0.Line03FUI:setAlpha(0)
			f3_local2(f3_arg0.Line03FUI)
			local f3_local3 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							local f35_local0 = function(f36_arg0)
								local f36_local0 = function(f37_arg0)
									local f37_local0 = function(f38_arg0)
										local f38_local0 = function(f39_arg0)
											f39_arg0:beginAnimation(19)
											f39_arg0:setAlpha(0)
											f39_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f38_arg0:beginAnimation(60)
										f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
									end
									f37_arg0:beginAnimation(19)
									f37_arg0:setAlpha(0.9)
									f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
								end
								f36_arg0:beginAnimation(800)
								f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
							end
							f35_arg0:beginAnimation(19)
							f35_arg0:setAlpha(0)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
						end
						f34_arg0:beginAnimation(60)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(19)
					f33_arg0:setAlpha(0.9)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f3_arg0.Line02FUI:beginAnimation(100)
				f3_arg0.Line02FUI:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Line02FUI:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f3_arg0.Line02FUI:completeAnimation()
			f3_arg0.Line02FUI:setAlpha(0)
			f3_local3(f3_arg0.Line02FUI)
			local f3_local4 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					local f41_local0 = function(f42_arg0)
						local f42_local0 = function(f43_arg0)
							local f43_local0 = function(f44_arg0)
								local f44_local0 = function(f45_arg0)
									local f45_local0 = function(f46_arg0)
										f46_arg0:beginAnimation(20)
										f46_arg0:setAlpha(0)
										f46_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
									end
									f45_arg0:beginAnimation(60)
									f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
								end
								f44_arg0:beginAnimation(19)
								f44_arg0:setAlpha(0.7)
								f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
							end
							f43_arg0:beginAnimation(400)
							f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
						end
						f42_arg0:beginAnimation(20)
						f42_arg0:setAlpha(0)
						f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
					end
					f41_arg0:beginAnimation(60)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
				end
				f3_arg0.Line01FUI:beginAnimation(20)
				f3_arg0.Line01FUI:setAlpha(0.8)
				f3_arg0.Line01FUI:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Line01FUI:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f3_arg0.Line01FUI:completeAnimation()
			f3_arg0.Line01FUI:setAlpha(0)
			f3_local4(f3_arg0.Line01FUI)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
