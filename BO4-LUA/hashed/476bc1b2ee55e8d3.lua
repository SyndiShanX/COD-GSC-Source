require("x64:446e073397f8479")
require("x64:e52957b45821d12")
CoD.HUD_ZM_Trial_Round_Failed = InheritFrom(LUI.UIElement)
CoD.HUD_ZM_Trial_Round_Failed.__defaultWidth = 1920
CoD.HUD_ZM_Trial_Round_Failed.__defaultHeight = 300
CoD.HUD_ZM_Trial_Round_Failed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_ZM_Trial_Round_Failed)
	self.id = "HUD_ZM_Trial_Round_Failed"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Reason = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 188, 221)
	Reason:setTTF("skorzhen")
	Reason:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Reason:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Reason:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.failureReason", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Reason:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(Reason)
	self.Reason = Reason
	local RoundReached = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 50, 83)
	RoundReached:setTTF("skorzhen")
	RoundReached:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RoundReached:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	RoundReached:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.roundNumber", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RoundReached:setText(CoD.ZombieUtility.GetSurvivedRoundsText(f3_local0))
		end
	end)
	self:addElement(RoundReached)
	self.RoundReached = RoundReached
	local Failed = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, -50, 40)
	Failed:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
	Failed:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3D9D6E119FDD76AE"))
	Failed:setTTF("skorzhen")
	Failed:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Failed:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Failed)
	self.Failed = Failed
	local Strikes = CoD.Hud_ZM_Trial_Strikes.new(f1_arg0, f1_arg1, 0.5, 0.5, -112, 112, 0, 0, 88, 168)
	Strikes:mergeStateConditions({
		{
			stateName = "HiddenRoundFail",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "HiddenCopy",
			condition = function(menu, element, event)
				local f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f5_local0 then
					f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f5_local0 then
						f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						if not f5_local0 then
							f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
							if not f5_local0 then
								f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
								if not f5_local0 then
									if Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
										f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
										if not f5_local0 then
											f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
											if not f5_local0 then
												f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
												if not f5_local0 then
													f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"])
													if not f5_local0 then
														f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
														if not f5_local0 then
															f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
															if not f5_local0 then
																f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
																if not f5_local0 then
																	f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
																	if not f5_local0 then
																		f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
																		if not f5_local0 then
																			f5_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
																		end
																	end
																end
															end
														end
													end
												end
											end
										end
									else
										f5_local0 = true
									end
								end
							end
						end
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.strikes", 0)
			end,
		},
	})
	local HudZMTrialShame2 = Strikes
	local HudZMTrialShame1 = Strikes.subscribeToModel
	local HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f7_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f8_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f9_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f11_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f12_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f13_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f14_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f15_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f16_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f17_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f18_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f19_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f20_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f21_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getmodelforcontroller"](f1_arg1)
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f22_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	HudZMTrialShame2 = Strikes
	HudZMTrialShame1 = Strikes.subscribeToModel
	HudZMTrialShame3 = Engine[@"getglobalmodel"]()
	HudZMTrialShame1(HudZMTrialShame2, HudZMTrialShame3["ZMHudGlobal.trials.strikes"], function(f23_arg0)
		f1_arg0:updateElementState(Strikes, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "ZMHudGlobal.trials.strikes",
		})
	end, false)
	self:addElement(Strikes)
	self.Strikes = Strikes
	HudZMTrialShame1 = CoD.Hud_ZM_Trial_Shame.new(f1_arg0, f1_arg1, 0.5, 0.5, -446, -244, 0, 0, 252, 491)
	HudZMTrialShame1.Portrait.Portrait.__Portrait_Portrait_Image = function()
		HudZMTrialShame1.Portrait.Portrait:setImage(RegisterImage(CoD.ZombieUtility.GetShamedPlayerPortrait(f1_arg1, 1, @"ui_icon_hero_portrait_draft_stanton")))
	end
	HudZMTrialShame1.Portrait.Portrait.__Portrait_Portrait_Image()
	HudZMTrialShame1.Gamertag.__Gamertag_String_Reference = function()
		HudZMTrialShame1.Gamertag:setText(CoD.ZombieUtility.GetTrialFailurePlayerGamertagByCount(f1_arg1, 1, "-"))
	end
	HudZMTrialShame1.Gamertag.__Gamertag_String_Reference()
	self:addElement(HudZMTrialShame1)
	self.HudZMTrialShame1 = HudZMTrialShame1
	HudZMTrialShame2 = CoD.Hud_ZM_Trial_Shame.new(f1_arg0, f1_arg1, 0.5, 0.5, -216, -14, 0, 0, 252, 491)
	HudZMTrialShame2.Portrait.Portrait.__Portrait_Portrait_Image = function()
		HudZMTrialShame2.Portrait.Portrait:setImage(RegisterImage(CoD.ZombieUtility.GetShamedPlayerPortrait(f1_arg1, 2, @"ui_icon_hero_portrait_draft_bruno")))
	end
	HudZMTrialShame2.Portrait.Portrait.__Portrait_Portrait_Image()
	HudZMTrialShame2.Gamertag.__Gamertag_String_Reference = function()
		HudZMTrialShame2.Gamertag:setText(CoD.ZombieUtility.GetTrialFailurePlayerGamertagByCount(f1_arg1, 2, "-"))
	end
	HudZMTrialShame2.Gamertag.__Gamertag_String_Reference()
	self:addElement(HudZMTrialShame2)
	self.HudZMTrialShame2 = HudZMTrialShame2
	HudZMTrialShame3 = CoD.Hud_ZM_Trial_Shame.new(f1_arg0, f1_arg1, 0.5, 0.5, 14, 216, 0, 0, 252, 491)
	HudZMTrialShame3.Portrait.Portrait.__Portrait_Portrait_Image = function()
		HudZMTrialShame3.Portrait.Portrait:setImage(RegisterImage(CoD.ZombieUtility.GetShamedPlayerPortrait(f1_arg1, 3, @"ui_icon_hero_portrait_draft_diego")))
	end
	HudZMTrialShame3.Portrait.Portrait.__Portrait_Portrait_Image()
	HudZMTrialShame3.Gamertag.__Gamertag_String_Reference = function()
		HudZMTrialShame3.Gamertag:setText(CoD.ZombieUtility.GetTrialFailurePlayerGamertagByCount(f1_arg1, 3, "-"))
	end
	HudZMTrialShame3.Gamertag.__Gamertag_String_Reference()
	self:addElement(HudZMTrialShame3)
	self.HudZMTrialShame3 = HudZMTrialShame3
	local HudZMTrialShame4 = CoD.Hud_ZM_Trial_Shame.new(f1_arg0, f1_arg1, 0.5, 0.5, 244, 446, 0, 0, 252, 491)
	HudZMTrialShame4.Portrait.Portrait.__Portrait_Portrait_Image = function()
		HudZMTrialShame4.Portrait.Portrait:setImage(RegisterImage(CoD.ZombieUtility.GetShamedPlayerPortrait(f1_arg1, 4, @"ui_icon_hero_portrait_draft_scarlett")))
	end
	HudZMTrialShame4.Portrait.Portrait.__Portrait_Portrait_Image()
	HudZMTrialShame4.Gamertag.__Gamertag_String_Reference = function()
		HudZMTrialShame4.Gamertag:setText(CoD.ZombieUtility.GetTrialFailurePlayerGamertagByCount(f1_arg1, 4, "-"))
	end
	HudZMTrialShame4.Gamertag.__Gamertag_String_Reference()
	self:addElement(HudZMTrialShame4)
	self.HudZMTrialShame4 = HudZMTrialShame4
	local DescriptionDivider = LUI.UIImage.new(0.5, 0.5, -288, 288, 0, 0, 38, 40)
	DescriptionDivider:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
	self:addElement(DescriptionDivider)
	self.DescriptionDivider = DescriptionDivider
	local CornerL = LUI.UIImage.new(0, 0, 658, 673, 0, 0, 31, 46)
	CornerL:setImage(RegisterImage(@"hash_61EC82771A88A0E6"))
	self:addElement(CornerL)
	self.CornerL = CornerL
	local CornerR = LUI.UIImage.new(0, 0, 1247, 1262, 0, 0, 31, 46)
	CornerR:setImage(RegisterImage(@"hash_61EC82771A88A0E6"))
	self:addElement(CornerR)
	self.CornerR = CornerR
	local f1_local12 = HudZMTrialShame1
	local f1_local13 = HudZMTrialShame1.subscribeToModel
	local f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], HudZMTrialShame1.Portrait.Portrait.__Portrait_Portrait_Image)
	f1_local12 = HudZMTrialShame1
	f1_local13 = HudZMTrialShame1.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], HudZMTrialShame1.Gamertag.__Gamertag_String_Reference)
	f1_local12 = HudZMTrialShame2
	f1_local13 = HudZMTrialShame2.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], HudZMTrialShame2.Portrait.Portrait.__Portrait_Portrait_Image)
	f1_local12 = HudZMTrialShame2
	f1_local13 = HudZMTrialShame2.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], HudZMTrialShame2.Gamertag.__Gamertag_String_Reference)
	f1_local12 = HudZMTrialShame3
	f1_local13 = HudZMTrialShame3.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], HudZMTrialShame3.Portrait.Portrait.__Portrait_Portrait_Image)
	f1_local12 = HudZMTrialShame3
	f1_local13 = HudZMTrialShame3.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], HudZMTrialShame3.Gamertag.__Gamertag_String_Reference)
	f1_local12 = HudZMTrialShame4
	f1_local13 = HudZMTrialShame4.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], HudZMTrialShame4.Portrait.Portrait.__Portrait_Portrait_Image)
	f1_local12 = HudZMTrialShame4
	f1_local13 = HudZMTrialShame4.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], HudZMTrialShame4.Gamertag.__Gamertag_String_Reference)
	self:mergeStateConditions({
		{
			stateName = "HideForPostGameScoreboard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.showScoreboard", 1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f33_local0
				if not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 1) then
					f33_local0 = not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 3)
				else
					f33_local0 = false
				end
				return f33_local0
			end,
		},
		{
			stateName = "VisibleNoShame",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 1) and not CoD.ZombieUtility.ShouldShowFailurePlayer(f1_arg1)
			end,
		},
		{
			stateName = "Visible_4_Shame",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 1) and CoD.ZombieUtility.FailurePlayerCountMatchesNum(f1_arg1, 4)
			end,
		},
		{
			stateName = "Visible_3_Shame",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 1) and CoD.ZombieUtility.FailurePlayerCountMatchesNum(f1_arg1, 3)
			end,
		},
		{
			stateName = "Visible_2_Shame",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 1) and CoD.ZombieUtility.FailurePlayerCountMatchesNum(f1_arg1, 2)
			end,
		},
		{
			stateName = "Visible_1_Shame",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 1) and CoD.ZombieUtility.FailurePlayerCountMatchesNum(f1_arg1, 1)
			end,
		},
		{
			stateName = "VisibleNoShame_GameOver",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 3) and not CoD.ZombieUtility.ShouldShowFailurePlayer(f1_arg1)
			end,
		},
		{
			stateName = "Visible_4_Shame_GameOver",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 3) and CoD.ZombieUtility.FailurePlayerCountMatchesNum(f1_arg1, 4)
			end,
		},
		{
			stateName = "Visible_3_Shame_GameOver",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 3) and CoD.ZombieUtility.FailurePlayerCountMatchesNum(f1_arg1, 3)
			end,
		},
		{
			stateName = "Visible_2_Shame_GameOver",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 3) and CoD.ZombieUtility.FailurePlayerCountMatchesNum(f1_arg1, 2)
			end,
		},
		{
			stateName = "Visible_1_Shame_GameOver",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 3) and CoD.ZombieUtility.FailurePlayerCountMatchesNum(f1_arg1, 1)
			end,
		},
	})
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.showScoreboard"], function(f44_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "ZMHudGlobal.trials.showScoreboard",
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.gameState"], function(f45_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "ZMHudGlobal.trials.gameState",
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["ZMHudGlobal.trials.failurePlayer"], function(f46_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "ZMHudGlobal.trials.failurePlayer",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HUD_ZM_Trial_Round_Failed.__resetProperties = function(f47_arg0)
	f47_arg0.DescriptionDivider:completeAnimation()
	f47_arg0.HudZMTrialShame1:completeAnimation()
	f47_arg0.Strikes:completeAnimation()
	f47_arg0.Failed:completeAnimation()
	f47_arg0.Reason:completeAnimation()
	f47_arg0.HudZMTrialShame3:completeAnimation()
	f47_arg0.HudZMTrialShame2:completeAnimation()
	f47_arg0.HudZMTrialShame4:completeAnimation()
	f47_arg0.RoundReached:completeAnimation()
	f47_arg0.CornerR:completeAnimation()
	f47_arg0.CornerL:completeAnimation()
	f47_arg0.DescriptionDivider:setAlpha(1)
	f47_arg0.HudZMTrialShame1:setLeftRight(0.5, 0.5, -446, -244)
	f47_arg0.HudZMTrialShame1:setTopBottom(0, 0, 252, 491)
	f47_arg0.HudZMTrialShame1:setAlpha(1)
	f47_arg0.Strikes:setTopBottom(0, 0, 88, 168)
	f47_arg0.Strikes:setAlpha(1)
	f47_arg0.Failed:setAlpha(1)
	f47_arg0.Failed:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3D9D6E119FDD76AE"))
	f47_arg0.Reason:setTopBottom(0, 0, 188, 221)
	f47_arg0.Reason:setAlpha(1)
	f47_arg0.HudZMTrialShame3:setLeftRight(0.5, 0.5, 14, 216)
	f47_arg0.HudZMTrialShame3:setTopBottom(0, 0, 252, 491)
	f47_arg0.HudZMTrialShame3:setAlpha(1)
	f47_arg0.HudZMTrialShame2:setLeftRight(0.5, 0.5, -216, -14)
	f47_arg0.HudZMTrialShame2:setTopBottom(0, 0, 252, 491)
	f47_arg0.HudZMTrialShame2:setAlpha(1)
	f47_arg0.HudZMTrialShame4:setLeftRight(0.5, 0.5, 244, 446)
	f47_arg0.HudZMTrialShame4:setTopBottom(0, 0, 252, 491)
	f47_arg0.HudZMTrialShame4:setAlpha(1)
	f47_arg0.RoundReached:setAlpha(1)
	f47_arg0.CornerR:setAlpha(1)
	f47_arg0.CornerL:setAlpha(1)
end
CoD.HUD_ZM_Trial_Round_Failed.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(11)
			f48_arg0.Reason:completeAnimation()
			f48_arg0.Reason:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.Reason)
			f48_arg0.RoundReached:completeAnimation()
			f48_arg0.RoundReached:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.RoundReached)
			f48_arg0.Failed:completeAnimation()
			f48_arg0.Failed:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.Failed)
			f48_arg0.Strikes:completeAnimation()
			f48_arg0.Strikes:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.Strikes)
			f48_arg0.HudZMTrialShame1:completeAnimation()
			f48_arg0.HudZMTrialShame1:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.HudZMTrialShame1)
			f48_arg0.HudZMTrialShame2:completeAnimation()
			f48_arg0.HudZMTrialShame2:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.HudZMTrialShame2)
			f48_arg0.HudZMTrialShame3:completeAnimation()
			f48_arg0.HudZMTrialShame3:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.HudZMTrialShame3)
			f48_arg0.HudZMTrialShame4:completeAnimation()
			f48_arg0.HudZMTrialShame4:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.HudZMTrialShame4)
			f48_arg0.DescriptionDivider:completeAnimation()
			f48_arg0.DescriptionDivider:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.DescriptionDivider)
			f48_arg0.CornerL:completeAnimation()
			f48_arg0.CornerL:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.CornerL)
			f48_arg0.CornerR:completeAnimation()
			f48_arg0.CornerR:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.CornerR)
		end,
	},
	HideForPostGameScoreboard = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(11)
			f49_arg0.Reason:completeAnimation()
			f49_arg0.Reason:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.Reason)
			f49_arg0.RoundReached:completeAnimation()
			f49_arg0.RoundReached:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.RoundReached)
			f49_arg0.Failed:completeAnimation()
			f49_arg0.Failed:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.Failed)
			f49_arg0.Strikes:completeAnimation()
			f49_arg0.Strikes:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.Strikes)
			f49_arg0.HudZMTrialShame1:completeAnimation()
			f49_arg0.HudZMTrialShame1:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.HudZMTrialShame1)
			f49_arg0.HudZMTrialShame2:completeAnimation()
			f49_arg0.HudZMTrialShame2:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.HudZMTrialShame2)
			f49_arg0.HudZMTrialShame3:completeAnimation()
			f49_arg0.HudZMTrialShame3:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.HudZMTrialShame3)
			f49_arg0.HudZMTrialShame4:completeAnimation()
			f49_arg0.HudZMTrialShame4:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.HudZMTrialShame4)
			f49_arg0.DescriptionDivider:completeAnimation()
			f49_arg0.DescriptionDivider:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.DescriptionDivider)
			f49_arg0.CornerL:completeAnimation()
			f49_arg0.CornerL:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.CornerL)
			f49_arg0.CornerR:completeAnimation()
			f49_arg0.CornerR:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.CornerR)
		end,
	},
	Hidden = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(11)
			f50_arg0.Reason:completeAnimation()
			f50_arg0.Reason:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.Reason)
			f50_arg0.RoundReached:completeAnimation()
			f50_arg0.RoundReached:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.RoundReached)
			f50_arg0.Failed:completeAnimation()
			f50_arg0.Failed:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.Failed)
			f50_arg0.Strikes:completeAnimation()
			f50_arg0.Strikes:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.Strikes)
			f50_arg0.HudZMTrialShame1:completeAnimation()
			f50_arg0.HudZMTrialShame1:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.HudZMTrialShame1)
			f50_arg0.HudZMTrialShame2:completeAnimation()
			f50_arg0.HudZMTrialShame2:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.HudZMTrialShame2)
			f50_arg0.HudZMTrialShame3:completeAnimation()
			f50_arg0.HudZMTrialShame3:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.HudZMTrialShame3)
			f50_arg0.HudZMTrialShame4:completeAnimation()
			f50_arg0.HudZMTrialShame4:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.HudZMTrialShame4)
			f50_arg0.DescriptionDivider:completeAnimation()
			f50_arg0.DescriptionDivider:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.DescriptionDivider)
			f50_arg0.CornerL:completeAnimation()
			f50_arg0.CornerL:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.CornerL)
			f50_arg0.CornerR:completeAnimation()
			f50_arg0.CornerR:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.CornerR)
		end,
	},
	VisibleNoShame = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(5)
			f51_arg0.RoundReached:completeAnimation()
			f51_arg0.RoundReached:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.RoundReached)
			f51_arg0.HudZMTrialShame1:completeAnimation()
			f51_arg0.HudZMTrialShame1:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.HudZMTrialShame1)
			f51_arg0.HudZMTrialShame2:completeAnimation()
			f51_arg0.HudZMTrialShame2:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.HudZMTrialShame2)
			f51_arg0.HudZMTrialShame3:completeAnimation()
			f51_arg0.HudZMTrialShame3:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.HudZMTrialShame3)
			f51_arg0.HudZMTrialShame4:completeAnimation()
			f51_arg0.HudZMTrialShame4:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.HudZMTrialShame4)
		end,
	},
	Visible_4_Shame = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(1)
			f52_arg0.RoundReached:completeAnimation()
			f52_arg0.RoundReached:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.RoundReached)
		end,
	},
	Visible_3_Shame = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(5)
			f53_arg0.RoundReached:completeAnimation()
			f53_arg0.RoundReached:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.RoundReached)
			f53_arg0.HudZMTrialShame1:completeAnimation()
			f53_arg0.HudZMTrialShame1:setLeftRight(0.5, 0.5, -331, -129)
			f53_arg0.clipFinished(f53_arg0.HudZMTrialShame1)
			f53_arg0.HudZMTrialShame2:completeAnimation()
			f53_arg0.HudZMTrialShame2:setLeftRight(0.5, 0.5, -101, 101)
			f53_arg0.clipFinished(f53_arg0.HudZMTrialShame2)
			f53_arg0.HudZMTrialShame3:completeAnimation()
			f53_arg0.HudZMTrialShame3:setLeftRight(0.5, 0.5, 129, 331)
			f53_arg0.clipFinished(f53_arg0.HudZMTrialShame3)
			f53_arg0.HudZMTrialShame4:completeAnimation()
			f53_arg0.HudZMTrialShame4:setLeftRight(0.5, 0.5, 359, 561)
			f53_arg0.HudZMTrialShame4:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.HudZMTrialShame4)
		end,
	},
	Visible_2_Shame = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(5)
			f54_arg0.RoundReached:completeAnimation()
			f54_arg0.RoundReached:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.RoundReached)
			f54_arg0.HudZMTrialShame1:completeAnimation()
			f54_arg0.HudZMTrialShame1:setLeftRight(0.5, 0.5, -216, -14)
			f54_arg0.clipFinished(f54_arg0.HudZMTrialShame1)
			f54_arg0.HudZMTrialShame2:completeAnimation()
			f54_arg0.HudZMTrialShame2:setLeftRight(0.5, 0.5, 14, 216)
			f54_arg0.clipFinished(f54_arg0.HudZMTrialShame2)
			f54_arg0.HudZMTrialShame3:completeAnimation()
			f54_arg0.HudZMTrialShame3:setLeftRight(0.5, 0.5, 244, 446)
			f54_arg0.HudZMTrialShame3:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.HudZMTrialShame3)
			f54_arg0.HudZMTrialShame4:completeAnimation()
			f54_arg0.HudZMTrialShame4:setLeftRight(0.5, 0.5, 474, 676)
			f54_arg0.HudZMTrialShame4:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.HudZMTrialShame4)
		end,
	},
	Visible_1_Shame = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(5)
			f55_arg0.RoundReached:completeAnimation()
			f55_arg0.RoundReached:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.RoundReached)
			f55_arg0.HudZMTrialShame1:completeAnimation()
			f55_arg0.HudZMTrialShame1:setLeftRight(0.5, 0.5, -101, 101)
			f55_arg0.clipFinished(f55_arg0.HudZMTrialShame1)
			f55_arg0.HudZMTrialShame2:completeAnimation()
			f55_arg0.HudZMTrialShame2:setLeftRight(0.5, 0.5, 129, 331)
			f55_arg0.HudZMTrialShame2:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.HudZMTrialShame2)
			f55_arg0.HudZMTrialShame3:completeAnimation()
			f55_arg0.HudZMTrialShame3:setLeftRight(0.5, 0.5, 359, 561)
			f55_arg0.HudZMTrialShame3:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.HudZMTrialShame3)
			f55_arg0.HudZMTrialShame4:completeAnimation()
			f55_arg0.HudZMTrialShame4:setLeftRight(0.5, 0.5, 589, 791)
			f55_arg0.HudZMTrialShame4:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.HudZMTrialShame4)
		end,
	},
	VisibleNoShame_GameOver = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(7)
			f56_arg0.Reason:completeAnimation()
			f56_arg0.Reason:setTopBottom(0, 0, 240, 273)
			f56_arg0.clipFinished(f56_arg0.Reason)
			f56_arg0.Failed:completeAnimation()
			f56_arg0.Failed:setText(Engine[@"hash_4F9F1239CFD921FE"](@"zombie/game_over"))
			f56_arg0.clipFinished(f56_arg0.Failed)
			f56_arg0.Strikes:completeAnimation()
			f56_arg0.Strikes:setTopBottom(0, 0, 140, 220)
			f56_arg0.clipFinished(f56_arg0.Strikes)
			f56_arg0.HudZMTrialShame1:completeAnimation()
			f56_arg0.HudZMTrialShame1:setTopBottom(0, 0, 304, 504)
			f56_arg0.HudZMTrialShame1:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.HudZMTrialShame1)
			f56_arg0.HudZMTrialShame2:completeAnimation()
			f56_arg0.HudZMTrialShame2:setTopBottom(0, 0, 304, 504)
			f56_arg0.HudZMTrialShame2:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.HudZMTrialShame2)
			f56_arg0.HudZMTrialShame3:completeAnimation()
			f56_arg0.HudZMTrialShame3:setTopBottom(0, 0, 304, 504)
			f56_arg0.HudZMTrialShame3:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.HudZMTrialShame3)
			f56_arg0.HudZMTrialShame4:completeAnimation()
			f56_arg0.HudZMTrialShame4:setTopBottom(0, 0, 304, 504)
			f56_arg0.HudZMTrialShame4:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.HudZMTrialShame4)
		end,
	},
	Visible_4_Shame_GameOver = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(7)
			f57_arg0.Reason:completeAnimation()
			f57_arg0.Reason:setTopBottom(0, 0, 240, 273)
			f57_arg0.clipFinished(f57_arg0.Reason)
			f57_arg0.Failed:completeAnimation()
			f57_arg0.Failed:setText(Engine[@"hash_4F9F1239CFD921FE"](@"zombie/game_over"))
			f57_arg0.clipFinished(f57_arg0.Failed)
			f57_arg0.Strikes:completeAnimation()
			f57_arg0.Strikes:setTopBottom(0, 0, 140, 220)
			f57_arg0.clipFinished(f57_arg0.Strikes)
			f57_arg0.HudZMTrialShame1:completeAnimation()
			f57_arg0.HudZMTrialShame1:setTopBottom(0, 0, 304, 504)
			f57_arg0.clipFinished(f57_arg0.HudZMTrialShame1)
			f57_arg0.HudZMTrialShame2:completeAnimation()
			f57_arg0.HudZMTrialShame2:setTopBottom(0, 0, 304, 504)
			f57_arg0.clipFinished(f57_arg0.HudZMTrialShame2)
			f57_arg0.HudZMTrialShame3:completeAnimation()
			f57_arg0.HudZMTrialShame3:setTopBottom(0, 0, 304, 504)
			f57_arg0.clipFinished(f57_arg0.HudZMTrialShame3)
			f57_arg0.HudZMTrialShame4:completeAnimation()
			f57_arg0.HudZMTrialShame4:setTopBottom(0, 0, 304, 504)
			f57_arg0.clipFinished(f57_arg0.HudZMTrialShame4)
		end,
	},
	Visible_3_Shame_GameOver = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(7)
			f58_arg0.Reason:completeAnimation()
			f58_arg0.Reason:setTopBottom(0, 0, 240, 273)
			f58_arg0.clipFinished(f58_arg0.Reason)
			f58_arg0.Failed:completeAnimation()
			f58_arg0.Failed:setText(Engine[@"hash_4F9F1239CFD921FE"](@"zombie/game_over"))
			f58_arg0.clipFinished(f58_arg0.Failed)
			f58_arg0.Strikes:completeAnimation()
			f58_arg0.Strikes:setTopBottom(0, 0, 140, 220)
			f58_arg0.clipFinished(f58_arg0.Strikes)
			f58_arg0.HudZMTrialShame1:completeAnimation()
			f58_arg0.HudZMTrialShame1:setLeftRight(0.5, 0.5, -331, -129)
			f58_arg0.HudZMTrialShame1:setTopBottom(0, 0, 304, 543)
			f58_arg0.clipFinished(f58_arg0.HudZMTrialShame1)
			f58_arg0.HudZMTrialShame2:completeAnimation()
			f58_arg0.HudZMTrialShame2:setLeftRight(0.5, 0.5, -101, 101)
			f58_arg0.HudZMTrialShame2:setTopBottom(0, 0, 304, 543)
			f58_arg0.clipFinished(f58_arg0.HudZMTrialShame2)
			f58_arg0.HudZMTrialShame3:completeAnimation()
			f58_arg0.HudZMTrialShame3:setLeftRight(0.5, 0.5, 129, 331)
			f58_arg0.HudZMTrialShame3:setTopBottom(0, 0, 304, 543)
			f58_arg0.clipFinished(f58_arg0.HudZMTrialShame3)
			f58_arg0.HudZMTrialShame4:completeAnimation()
			f58_arg0.HudZMTrialShame4:setLeftRight(0.5, 0.5, 359, 561)
			f58_arg0.HudZMTrialShame4:setTopBottom(0, 0, 304, 543)
			f58_arg0.HudZMTrialShame4:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.HudZMTrialShame4)
		end,
	},
	Visible_2_Shame_GameOver = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(7)
			f59_arg0.Reason:completeAnimation()
			f59_arg0.Reason:setTopBottom(0, 0, 240, 273)
			f59_arg0.clipFinished(f59_arg0.Reason)
			f59_arg0.Failed:completeAnimation()
			f59_arg0.Failed:setText(Engine[@"hash_4F9F1239CFD921FE"](@"zombie/game_over"))
			f59_arg0.clipFinished(f59_arg0.Failed)
			f59_arg0.Strikes:completeAnimation()
			f59_arg0.Strikes:setTopBottom(0, 0, 140, 220)
			f59_arg0.clipFinished(f59_arg0.Strikes)
			f59_arg0.HudZMTrialShame1:completeAnimation()
			f59_arg0.HudZMTrialShame1:setLeftRight(0.5, 0.5, -216, -14)
			f59_arg0.HudZMTrialShame1:setTopBottom(0, 0, 304, 543)
			f59_arg0.clipFinished(f59_arg0.HudZMTrialShame1)
			f59_arg0.HudZMTrialShame2:completeAnimation()
			f59_arg0.HudZMTrialShame2:setLeftRight(0.5, 0.5, 14, 216)
			f59_arg0.HudZMTrialShame2:setTopBottom(0, 0, 304, 543)
			f59_arg0.clipFinished(f59_arg0.HudZMTrialShame2)
			f59_arg0.HudZMTrialShame3:completeAnimation()
			f59_arg0.HudZMTrialShame3:setLeftRight(0.5, 0.5, 244, 446)
			f59_arg0.HudZMTrialShame3:setTopBottom(0, 0, 304, 543)
			f59_arg0.HudZMTrialShame3:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.HudZMTrialShame3)
			f59_arg0.HudZMTrialShame4:completeAnimation()
			f59_arg0.HudZMTrialShame4:setLeftRight(0.5, 0.5, 474, 676)
			f59_arg0.HudZMTrialShame4:setTopBottom(0, 0, 304, 543)
			f59_arg0.HudZMTrialShame4:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.HudZMTrialShame4)
		end,
	},
	Visible_1_Shame_GameOver = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(7)
			f60_arg0.Reason:completeAnimation()
			f60_arg0.Reason:setTopBottom(0, 0, 240, 273)
			f60_arg0.clipFinished(f60_arg0.Reason)
			f60_arg0.Failed:completeAnimation()
			f60_arg0.Failed:setText(Engine[@"hash_4F9F1239CFD921FE"](@"zombie/game_over"))
			f60_arg0.clipFinished(f60_arg0.Failed)
			f60_arg0.Strikes:completeAnimation()
			f60_arg0.Strikes:setTopBottom(0, 0, 140, 220)
			f60_arg0.clipFinished(f60_arg0.Strikes)
			f60_arg0.HudZMTrialShame1:completeAnimation()
			f60_arg0.HudZMTrialShame1:setLeftRight(0.5, 0.5, -101, 101)
			f60_arg0.HudZMTrialShame1:setTopBottom(0, 0, 304, 543)
			f60_arg0.clipFinished(f60_arg0.HudZMTrialShame1)
			f60_arg0.HudZMTrialShame2:completeAnimation()
			f60_arg0.HudZMTrialShame2:setLeftRight(0.5, 0.5, 129, 331)
			f60_arg0.HudZMTrialShame2:setTopBottom(0, 0, 304, 543)
			f60_arg0.HudZMTrialShame2:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.HudZMTrialShame2)
			f60_arg0.HudZMTrialShame3:completeAnimation()
			f60_arg0.HudZMTrialShame3:setLeftRight(0.5, 0.5, 359, 561)
			f60_arg0.HudZMTrialShame3:setTopBottom(0, 0, 304, 543)
			f60_arg0.HudZMTrialShame3:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.HudZMTrialShame3)
			f60_arg0.HudZMTrialShame4:completeAnimation()
			f60_arg0.HudZMTrialShame4:setLeftRight(0.5, 0.5, 589, 791)
			f60_arg0.HudZMTrialShame4:setTopBottom(0, 0, 303, 542)
			f60_arg0.HudZMTrialShame4:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.HudZMTrialShame4)
		end,
	},
}
CoD.HUD_ZM_Trial_Round_Failed.__onClose = function(f61_arg0)
	f61_arg0.Reason:close()
	f61_arg0.RoundReached:close()
	f61_arg0.Strikes:close()
	f61_arg0.HudZMTrialShame1:close()
	f61_arg0.HudZMTrialShame2:close()
	f61_arg0.HudZMTrialShame3:close()
	f61_arg0.HudZMTrialShame4:close()
end
