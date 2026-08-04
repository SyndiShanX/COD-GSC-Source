require("ui/uieditor/widgets/callingcards/callingcards_asset_bomber_plane")
CoD.callingcards_zm_weapons_equipment = InheritFrom(LUI.UIElement)
CoD.callingcards_zm_weapons_equipment.__defaultWidth = 960
CoD.callingcards_zm_weapons_equipment.__defaultHeight = 240
CoD.callingcards_zm_weapons_equipment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_zm_weapons_equipment)
	self.id = "Callingcards_zm_Weapons_Equipment"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_background"))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	bg:setShaderVector(0, 1, 1, 0, 0)
	bg:setShaderVector(1, 0.01, 0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local CallingCardsAssetBomberPlane = CoD.CallingCards_Asset_Bomber_Plane.new(f1_arg0, f1_arg1, 0, 0, -42.5, 213.5, 0, 0, -139, 461)
	CallingCardsAssetBomberPlane:setAlpha(0.45)
	CallingCardsAssetBomberPlane:setScale(0.5, 0.5)
	self:addElement(CallingCardsAssetBomberPlane)
	self.CallingCardsAssetBomberPlane = CallingCardsAssetBomberPlane
	local CallingCardsAssetBomberPlane2 = CoD.CallingCards_Asset_Bomber_Plane.new(f1_arg0, f1_arg1, 0, 0, 181.5, 437.5, 0, 0, -5, 595)
	CallingCardsAssetBomberPlane2:setAlpha(0.45)
	CallingCardsAssetBomberPlane2:setScale(0.75, 0.75)
	self:addElement(CallingCardsAssetBomberPlane2)
	self.CallingCardsAssetBomberPlane2 = CallingCardsAssetBomberPlane2
	local CallingCardsAssetBomberPlane3 = CoD.CallingCards_Asset_Bomber_Plane.new(f1_arg0, f1_arg1, 0, 0, 791.5, 1047.5, 0, 0, -75, 525)
	CallingCardsAssetBomberPlane3:setAlpha(0.45)
	CallingCardsAssetBomberPlane3:setScale(0.75, 0.75)
	self:addElement(CallingCardsAssetBomberPlane3)
	self.CallingCardsAssetBomberPlane3 = CallingCardsAssetBomberPlane3
	local CallingCardsAssetBomberPlane4 = CoD.CallingCards_Asset_Bomber_Plane.new(f1_arg0, f1_arg1, 0, 0, 333.5, 589.5, 0, 0, -183, 417)
	CallingCardsAssetBomberPlane4:setAlpha(0.45)
	CallingCardsAssetBomberPlane4:setScale(0.35, 0.35)
	self:addElement(CallingCardsAssetBomberPlane4)
	self.CallingCardsAssetBomberPlane4 = CallingCardsAssetBomberPlane4
	local clouds = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	clouds:setAlpha(0.1)
	clouds:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_background_clouds"))
	clouds:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll"))
	clouds:setShaderVector(0, 1, 1, 0, 0)
	clouds:setShaderVector(1, 0.03, 0, 0, 0)
	self:addElement(clouds)
	self.clouds = clouds
	local blastout = LUI.UIImage.new(0, 0, 420.5, 670.5, 0, 0, -180, 420)
	blastout:setZRot(-52)
	blastout:setScale(1.7, 1)
	blastout:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_debri"))
	blastout:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll"))
	blastout:setShaderVector(0, 1, 1, 0, 0)
	blastout:setShaderVector(1, 0, 1, 0, 0)
	self:addElement(blastout)
	self.blastout = blastout
	local BOT1 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BOT1:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_robot_01"))
	self:addElement(BOT1)
	self.BOT1 = BOT1
	local BOT2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BOT2:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_robot_02"))
	self:addElement(BOT2)
	self.BOT2 = BOT2
	local BOT3 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BOT3:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_robot_03"))
	self:addElement(BOT3)
	self.BOT3 = BOT3
	local BOT4 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BOT4:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_robot_04"))
	self:addElement(BOT4)
	self.BOT4 = BOT4
	local BOT5 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BOT5:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_robot_05"))
	self:addElement(BOT5)
	self.BOT5 = BOT5
	local BOT6 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BOT6:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_robot_06"))
	self:addElement(BOT6)
	self.BOT6 = BOT6
	local dust2 = LUI.UIImage.new(0, 0, 139, 577, 0, 0, 0, 191)
	dust2:setRGB(0.98, 0.88, 0.4)
	dust2:setScale(1.5, 1.5)
	dust2:setImage(RegisterImage("uie_dust_bloom"))
	self:addElement(dust2)
	self.dust2 = dust2
	local glowShot = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	glowShot:setImage(RegisterImage("uie_ui_icon_callingcards_zm_weapons_equipment_glowshot"))
	glowShot:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(glowShot)
	self.glowShot = glowShot
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage("uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_zm_weapons_equipment.__resetProperties = function(f2_arg0)
	f2_arg0.blastout:completeAnimation()
	f2_arg0.BOT1:completeAnimation()
	f2_arg0.BOT2:completeAnimation()
	f2_arg0.BOT3:completeAnimation()
	f2_arg0.BOT4:completeAnimation()
	f2_arg0.BOT5:completeAnimation()
	f2_arg0.BOT6:completeAnimation()
	f2_arg0.dust2:completeAnimation()
	f2_arg0.glowShot:completeAnimation()
	f2_arg0.blastout:setAlpha(1)
	f2_arg0.BOT1:setAlpha(1)
	f2_arg0.BOT2:setAlpha(1)
	f2_arg0.BOT3:setAlpha(1)
	f2_arg0.BOT4:setAlpha(1)
	f2_arg0.BOT5:setAlpha(1)
	f2_arg0.BOT6:setAlpha(1)
	f2_arg0.dust2:setAlpha(1)
	f2_arg0.dust2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_normal"))
	f2_arg0.glowShot:setAlpha(1)
end
CoD.callingcards_zm_weapons_equipment.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(9)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(120)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(760)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.blastout:beginAnimation(120)
				f3_arg0.blastout:setAlpha(1)
				f3_arg0.blastout:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.blastout:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.blastout:completeAnimation()
			f3_arg0.blastout:setAlpha(0)
			f3_local0(f3_arg0.blastout)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							local f10_local0 = function(f11_arg0)
								f11_arg0:beginAnimation(539)
								f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f10_arg0:beginAnimation(10)
							f10_arg0:setAlpha(1)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
						end
						f9_arg0:beginAnimation(109)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(9)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.BOT1:beginAnimation(330)
				f3_arg0.BOT1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BOT1:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.BOT1:completeAnimation()
			f3_arg0.BOT1:setAlpha(1)
			f3_local1(f3_arg0.BOT1)
			local f3_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									local f17_local0 = function(f18_arg0)
										local f18_local0 = function(f19_arg0)
											f19_arg0:beginAnimation(539)
											f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f18_arg0:beginAnimation(10)
										f18_arg0:setAlpha(0)
										f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
									end
									f17_arg0:beginAnimation(9)
									f17_arg0:setAlpha(1)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
								end
								f16_arg0:beginAnimation(9)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(80)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(9)
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(9)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.BOT2:beginAnimation(330)
				f3_arg0.BOT2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BOT2:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.BOT2:completeAnimation()
			f3_arg0.BOT2:setAlpha(0)
			f3_local2(f3_arg0.BOT2)
			local f3_local3 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						local f22_local0 = function(f23_arg0)
							local f23_local0 = function(f24_arg0)
								local f24_local0 = function(f25_arg0)
									local f25_local0 = function(f26_arg0)
										local f26_local0 = function(f27_arg0)
											f27_arg0:beginAnimation(550)
											f27_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f26_arg0:beginAnimation(9)
										f26_arg0:setAlpha(0)
										f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
									end
									f25_arg0:beginAnimation(9)
									f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
								end
								f24_arg0:beginAnimation(10)
								f24_arg0:setAlpha(1)
								f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
							end
							f23_arg0:beginAnimation(59)
							f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
						end
						f22_arg0:beginAnimation(10)
						f22_arg0:setAlpha(0)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
					end
					f21_arg0:beginAnimation(9)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f3_arg0.BOT3:beginAnimation(340)
				f3_arg0.BOT3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BOT3:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f3_arg0.BOT3:completeAnimation()
			f3_arg0.BOT3:setAlpha(0)
			f3_local3(f3_arg0.BOT3)
			local f3_local4 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					local f29_local0 = function(f30_arg0)
						local f30_local0 = function(f31_arg0)
							local f31_local0 = function(f32_arg0)
								local f32_local0 = function(f33_arg0)
									local f33_local0 = function(f34_arg0)
										f34_arg0:beginAnimation(570)
										f34_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
									end
									f33_arg0:beginAnimation(10)
									f33_arg0:setAlpha(0)
									f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
								end
								f32_arg0:beginAnimation(9)
								f32_arg0:setAlpha(1)
								f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
							end
							f31_arg0:beginAnimation(30)
							f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
						end
						f30_arg0:beginAnimation(19)
						f30_arg0:setAlpha(0)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
					end
					f29_arg0:beginAnimation(10)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f3_arg0.BOT4:beginAnimation(350)
				f3_arg0.BOT4:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BOT4:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f3_arg0.BOT4:completeAnimation()
			f3_arg0.BOT4:setAlpha(0)
			f3_local4(f3_arg0.BOT4)
			local f3_local5 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					local f36_local0 = function(f37_arg0)
						local f37_local0 = function(f38_arg0)
							f38_arg0:beginAnimation(590)
							f38_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f37_arg0:beginAnimation(30)
						f37_arg0:setAlpha(0)
						f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
					end
					f36_arg0:beginAnimation(19)
					f36_arg0:setAlpha(1)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
				end
				f3_arg0.BOT5:beginAnimation(360)
				f3_arg0.BOT5:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BOT5:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f3_arg0.BOT5:completeAnimation()
			f3_arg0.BOT5:setAlpha(0)
			f3_local5(f3_arg0.BOT5)
			local f3_local6 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						local f41_local0 = function(f42_arg0)
							f42_arg0:beginAnimation(580)
							f42_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f41_arg0:beginAnimation(9)
						f41_arg0:setAlpha(0)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
					end
					f40_arg0:beginAnimation(30)
					f40_arg0:setAlpha(1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f3_arg0.BOT6:beginAnimation(380)
				f3_arg0.BOT6:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BOT6:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f3_arg0.BOT6:completeAnimation()
			f3_arg0.BOT6:setAlpha(0)
			f3_local6(f3_arg0.BOT6)
			local f3_local7 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					local f44_local0 = function(f45_arg0)
						local f45_local0 = function(f46_arg0)
							local f46_local0 = function(f47_arg0)
								f47_arg0:beginAnimation(580)
								f47_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f46_arg0:beginAnimation(9)
							f46_arg0:setAlpha(0)
							f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
						end
						f45_arg0:beginAnimation(39)
						f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
					end
					f44_arg0:beginAnimation(9)
					f44_arg0:setAlpha(1)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
				end
				f3_arg0.dust2:beginAnimation(360)
				f3_arg0.dust2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dust2:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f3_arg0.dust2:completeAnimation()
			f3_arg0.dust2:setAlpha(0)
			f3_arg0.dust2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
			f3_local7(f3_arg0.dust2)
			local f3_local8 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					local f49_local0 = function(f50_arg0)
						local f50_local0 = function(f51_arg0)
							local f51_local0 = function(f52_arg0)
								f52_arg0:beginAnimation(560)
								f52_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f51_arg0:beginAnimation(9)
							f51_arg0:setAlpha(0)
							f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
						end
						f50_arg0:beginAnimation(69)
						f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
					end
					f49_arg0:beginAnimation(10)
					f49_arg0:setAlpha(1)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
				end
				f3_arg0.glowShot:beginAnimation(350)
				f3_arg0.glowShot:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.glowShot:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f3_arg0.glowShot:completeAnimation()
			f3_arg0.glowShot:setAlpha(0)
			f3_local8(f3_arg0.glowShot)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_zm_weapons_equipment.__onClose = function(f53_arg0)
	f53_arg0.CallingCardsAssetBomberPlane:close()
	f53_arg0.CallingCardsAssetBomberPlane2:close()
	f53_arg0.CallingCardsAssetBomberPlane3:close()
	f53_arg0.CallingCardsAssetBomberPlane4:close()
end
