require("ui/uieditor/widgets/pc/socialmenu/pc_battlenetfriend_addfriend_name")
CoD.PC_Battlenet_FriendRequestPopup = InheritFrom(LUI.UIElement)
CoD.PC_Battlenet_FriendRequestPopup.__defaultWidth = 435
CoD.PC_Battlenet_FriendRequestPopup.__defaultHeight = 51
CoD.PC_Battlenet_FriendRequestPopup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "social_screen_editbox_add_friends", "")
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "social_screen_editbox_add_friends_last", "")
	self:setClass(CoD.PC_Battlenet_FriendRequestPopup)
	self.id = "PC_Battlenet_FriendRequestPopup"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FriendRequestBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FriendRequestBackground:setRGB(0.11, 0.11, 0.11)
	FriendRequestBackground:setAlpha(0)
	self:addElement(FriendRequestBackground)
	self.FriendRequestBackground = FriendRequestBackground
	local FriendRequestSentGlow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FriendRequestSentGlow:setAlpha(0)
	FriendRequestSentGlow:setImage(RegisterImage("uie_social_friendrequest_glow"))
	self:addElement(FriendRequestSentGlow)
	self.FriendRequestSentGlow = FriendRequestSentGlow
	local FriendIcon = LUI.UIImage.new(0.02, 0.02, 0, 17, 0.5, 0.5, -8.5, 8.5)
	FriendIcon:setAlpha(0)
	FriendIcon:setImage(RegisterImage(@"hash_2A16F29EFD38E823"))
	self:addElement(FriendIcon)
	self.FriendIcon = FriendIcon
	local CheckIcon = LUI.UIImage.new(0.02, 0.02, 0, 30, -0.02, -0.02, 0, 30)
	CheckIcon:setRGB(0.54, 1, 0)
	CheckIcon:setAlpha(0)
	CheckIcon:setImage(RegisterImage("uie_success_icon"))
	self:addElement(CheckIcon)
	self.CheckIcon = CheckIcon
	local RequestSentText = LUI.UIText.new(0.09, 0.09, -0.5, 390.5, 0.07, 0.07, 0, 21)
	RequestSentText:setAlpha(0)
	RequestSentText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_21AE94021C967D51"))
	RequestSentText:setTTF("notosans_regular")
	RequestSentText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	RequestSentText:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	self:addElement(RequestSentText)
	self.RequestSentText = RequestSentText
	local FriendName = CoD.PC_BattlenetFriend_AddFriend_Name.new(f1_arg0, f1_arg1, 0, 0, 38.5, 430.5, 0, 0, 26, 48)
	FriendName:setAlpha(0)
	FriendName:setRFTMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_delta_rft"))
	FriendName:setShaderVector(0, 1, 0, 0, 0)
	FriendName:setShaderVector(1, 0, 0.12, 0, 0)
	FriendName:setShaderVector(2, 0, 1, 0, 0)
	FriendName:setShaderVector(3, 0, 0, 0, 0)
	self:addElement(FriendName)
	self.FriendName = FriendName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.PCUtility.CloseFriendPopupOnClipOver(self, f1_arg1)
	return self
end
CoD.PC_Battlenet_FriendRequestPopup.__resetProperties = function(f2_arg0)
	f2_arg0.FriendRequestSentGlow:completeAnimation()
	f2_arg0.CheckIcon:completeAnimation()
	f2_arg0.FriendRequestBackground:completeAnimation()
	f2_arg0.RequestSentText:completeAnimation()
	f2_arg0.FriendName:completeAnimation()
	f2_arg0.FriendRequestSentGlow:setRGB(1, 1, 1)
	f2_arg0.FriendRequestSentGlow:setAlpha(0)
	f2_arg0.CheckIcon:setTopBottom(-0.02, -0.02, 0, 30)
	f2_arg0.CheckIcon:setRGB(0.54, 1, 0)
	f2_arg0.CheckIcon:setAlpha(0)
	f2_arg0.CheckIcon:setImage(RegisterImage("uie_success_icon"))
	f2_arg0.FriendRequestBackground:setAlpha(0)
	f2_arg0.RequestSentText:setTopBottom(0.07, 0.07, 0, 21)
	f2_arg0.RequestSentText:setAlpha(0)
	f2_arg0.FriendName:setAlpha(0)
end
CoD.PC_Battlenet_FriendRequestPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		FriendRequestSent = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(5)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						f7_arg0:beginAnimation(160)
						f7_arg0:setAlpha(0)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f6_arg0:beginAnimation(2189)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f5_arg0:beginAnimation(160)
				f5_arg0:setAlpha(1)
				f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.FriendRequestBackground:beginAnimation(240)
			f4_arg0.FriendRequestBackground:setAlpha(0)
			f4_arg0.FriendRequestBackground:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.FriendRequestBackground:registerEventHandler("transition_complete_keyframe", f4_local0)
			local f4_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							local f11_local0 = function(f12_arg0)
								f12_arg0:beginAnimation(99)
								f12_arg0:setAlpha(0)
								f12_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
							end
							f11_arg0:beginAnimation(60)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
						end
						f10_arg0:beginAnimation(2189)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(160)
					f9_arg0:setAlpha(0.8)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f4_arg0.FriendRequestSentGlow:beginAnimation(240)
				f4_arg0.FriendRequestSentGlow:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.FriendRequestSentGlow:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f4_arg0.FriendRequestSentGlow:completeAnimation()
			f4_arg0.FriendRequestSentGlow:setRGB(1, 1, 1)
			f4_arg0.FriendRequestSentGlow:setAlpha(0)
			f4_local1(f4_arg0.FriendRequestSentGlow)
			local f4_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							f16_arg0:beginAnimation(60)
							f16_arg0:setAlpha(0)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
						end
						f15_arg0:beginAnimation(2189)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(60)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f4_arg0.CheckIcon:beginAnimation(340)
				f4_arg0.CheckIcon:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.CheckIcon:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f4_arg0.CheckIcon:completeAnimation()
			f4_arg0.CheckIcon:setRGB(0.54, 1, 0)
			f4_arg0.CheckIcon:setAlpha(0)
			f4_arg0.CheckIcon:setImage(RegisterImage("uie_success_icon"))
			f4_local2(f4_arg0.CheckIcon)
			local f4_local3 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						f19_arg0:beginAnimation(60)
						f19_arg0:setAlpha(0)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f18_arg0:beginAnimation(2189)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f17_arg0:beginAnimation(60)
				f17_arg0:setAlpha(1)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f4_arg0.RequestSentText:beginAnimation(340)
			f4_arg0.RequestSentText:setAlpha(0)
			f4_arg0.RequestSentText:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.RequestSentText:registerEventHandler("transition_complete_keyframe", f4_local3)
			local f4_local4 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						f22_arg0:beginAnimation(60)
						f22_arg0:setAlpha(0)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f21_arg0:beginAnimation(2189)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f20_arg0:beginAnimation(60)
				f20_arg0:setAlpha(1)
				f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f4_arg0.FriendName:beginAnimation(340)
			f4_arg0.FriendName:setAlpha(0)
			f4_arg0.FriendName:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.FriendName:registerEventHandler("transition_complete_keyframe", f4_local4)
		end,
		InvalidFriendRequestSent = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			local f23_local0 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						f26_arg0:beginAnimation(160)
						f26_arg0:setAlpha(0)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
					end
					f25_arg0:beginAnimation(2199)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f24_arg0:beginAnimation(160)
				f24_arg0:setAlpha(1)
				f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f23_arg0.FriendRequestBackground:beginAnimation(240)
			f23_arg0.FriendRequestBackground:setAlpha(0)
			f23_arg0.FriendRequestBackground:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
			f23_arg0.FriendRequestBackground:registerEventHandler("transition_complete_keyframe", f23_local0)
			local f23_local1 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					local f28_local0 = function(f29_arg0)
						local f29_local0 = function(f30_arg0)
							local f30_local0 = function(f31_arg0)
								f31_arg0:beginAnimation(99)
								f31_arg0:setAlpha(0)
								f31_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
							end
							f30_arg0:beginAnimation(60)
							f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
						end
						f29_arg0:beginAnimation(2199)
						f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
					end
					f28_arg0:beginAnimation(160)
					f28_arg0:setAlpha(0.8)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
				end
				f23_arg0.FriendRequestSentGlow:beginAnimation(240)
				f23_arg0.FriendRequestSentGlow:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.FriendRequestSentGlow:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f23_arg0.FriendRequestSentGlow:completeAnimation()
			f23_arg0.FriendRequestSentGlow:setRGB(1, 0, 0)
			f23_arg0.FriendRequestSentGlow:setAlpha(0)
			f23_local1(f23_arg0.FriendRequestSentGlow)
			local f23_local2 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							local f35_local0 = function(f36_arg0)
								f36_arg0:beginAnimation(60)
								f36_arg0:setAlpha(0)
								f36_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
							end
							f35_arg0:beginAnimation(39)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
						end
						f34_arg0:beginAnimation(2159)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(60)
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f23_arg0.CheckIcon:beginAnimation(340)
				f23_arg0.CheckIcon:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.CheckIcon:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f23_arg0.CheckIcon:completeAnimation()
			f23_arg0.CheckIcon:setTopBottom(0.21, 0.21, 0, 30)
			f23_arg0.CheckIcon:setRGB(1, 0, 0)
			f23_arg0.CheckIcon:setAlpha(0)
			f23_arg0.CheckIcon:setImage(RegisterImage("uie_error_icon"))
			f23_local2(f23_arg0.CheckIcon)
			local f23_local3 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					local f38_local0 = function(f39_arg0)
						local f39_local0 = function(f40_arg0)
							f40_arg0:beginAnimation(60)
							f40_arg0:setAlpha(0)
							f40_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
						end
						f39_arg0:beginAnimation(39)
						f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
					end
					f38_arg0:beginAnimation(2159)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
				end
				f37_arg0:beginAnimation(60)
				f37_arg0:setAlpha(1)
				f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f23_arg0.RequestSentText:beginAnimation(340)
			f23_arg0.RequestSentText:setTopBottom(0.3, 0.3, 0, 21)
			f23_arg0.RequestSentText:setAlpha(0)
			f23_arg0.RequestSentText:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
			f23_arg0.RequestSentText:registerEventHandler("transition_complete_keyframe", f23_local3)
			local f23_local4 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					local f42_local0 = function(f43_arg0)
						f43_arg0:beginAnimation(60)
						f43_arg0:setAlpha(0)
						f43_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
					end
					f42_arg0:beginAnimation(2199)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
				end
				f41_arg0:beginAnimation(60)
				f41_arg0:setAlpha(1)
				f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f23_arg0.FriendName:beginAnimation(340)
			f23_arg0.FriendName:setAlpha(0)
			f23_arg0.FriendName:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
			f23_arg0.FriendName:registerEventHandler("transition_complete_keyframe", f23_local4)
		end,
	},
}
CoD.PC_Battlenet_FriendRequestPopup.__onClose = function(f44_arg0)
	f44_arg0.FriendName:close()
end
