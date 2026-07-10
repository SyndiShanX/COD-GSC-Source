require("x64:8d52912a320cd2e")
require("x64:6a9f6e228c42bc6")
require("x64:e27b70e4e9a228")
require("x64:6ab52417b210efb")
require("x64:61911de5d586c0e")
require("x64:279f0c61251e1f")
require("x64:92b630a6698ccff")
CoD.PlayerWidget_ZM = InheritFrom(LUI.UIElement)
CoD.PlayerWidget_ZM.__defaultWidth = 278
CoD.PlayerWidget_ZM.__defaultHeight = 112
CoD.PlayerWidget_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerWidget_ZM)
	self.id = "PlayerWidget_ZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBlur = LUI.UIImage.new(0.5, 0.5, -176, 176, 0.5, 0.5, -64, 64)
	BackingBlur:setAlpha(0.9)
	BackingBlur:setYRot(180)
	BackingBlur:setScale(0.9, 0.9)
	BackingBlur:setImage(RegisterImage(@"hash_6907FA1028168086"))
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local Backing = LUI.UIImage.new(0.5, 0.5, -176, 176, 0.5, 0.5, -64, 64)
	Backing:setYRot(180)
	Backing:setScale(0.9, 0.9)
	Backing:setImage(RegisterImage(@"hash_62656BC725F9EEB"))
	self:addElement(Backing)
	self.Backing = Backing
	local headshotBarBacking = CoD.AmmoWidgetZM_Specialist.new(f1_arg0, f1_arg1, 0.5, 0.5, -171, -36, 0.5, 0.5, -67, 68)
	headshotBarBacking:subscribeToGlobalModel(f1_arg1, "PlayerListZM", "0", function(model)
		headshotBarBacking:setModel(model, f1_arg1)
	end)
	self:addElement(headshotBarBacking)
	self.headshotBarBacking = headshotBarBacking
	local HealthValue = CoD.HealthInfoZM.new(f1_arg0, f1_arg1, 0, 0, -4, 234, 0, 0, 42.5, 208.5)
	HealthValue:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HealthValue:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	local ScoreShadow = LUI.UIText.new(0, 0, 115.5, 244.5, 0, 0, 27.5, 74.5)
	ScoreShadow:setRGB(0.1, 0.1, 0.1)
	ScoreShadow:setTTF("skorzhen")
	ScoreShadow:setLetterSpacing(2)
	ScoreShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ScoreShadow:subscribeToGlobalModel(f1_arg1, "PlayerListZM", "0.playerScore", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ScoreShadow:setText(CoD.ZombieUtility.ReturnScoreifNotArcade(f4_local0))
		end
	end)
	self:addElement(ScoreShadow)
	self.ScoreShadow = ScoreShadow
	local Score = LUI.UIText.new(0, 0, 115, 244, 0, 0, 26.5, 73.5)
	Score:setTTF("skorzhen")
	Score:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Score:setShaderVector(0, 0.11, 0, 0, 0)
	Score:setShaderVector(1, 0.13, 0, 0, 0)
	Score:setShaderVector(2, 0, 0, 0, 1)
	Score:setLetterSpacing(2)
	Score:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Score:subscribeToGlobalModel(f1_arg1, "PlayerListZM", "0.clientNum", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Score:setRGB(ZombieClientScoreboardColor(f5_local0))
		end
	end)
	Score:subscribeToGlobalModel(f1_arg1, "PlayerListZM", "0.playerScore", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Score:setText(CoD.ZombieUtility.ReturnScoreifNotArcade(f6_local0))
		end
	end)
	self:addElement(Score)
	self.Score = Score
	local SelfReviveCounter = CoD.ZM_SelfReviveCounter.new(f1_arg0, f1_arg1, 0, 0, -51, 34, 0, 0, 69.5, 114.5)
	SelfReviveCounter:setScale(0.75, 0.75)
	self:addElement(SelfReviveCounter)
	self.SelfReviveCounter = SelfReviveCounter
	local Checkbox = CoD.PlayerWidget_ZM_Trials.new(f1_arg0, f1_arg1, 0, 0, -38.5, 90.5, 0, 0, 68, 124)
	self:addElement(Checkbox)
	self.Checkbox = Checkbox
	local GlobalTracker = CoD.Hud_ZM_Trial_Global_Tracker.new(f1_arg0, f1_arg1, 0, 0, -38.5, 90.5, 0, 0, 68, 124)
	GlobalTracker:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials", function(model)
		GlobalTracker:setModel(model, f1_arg1)
	end)
	self:addElement(GlobalTracker)
	self.GlobalTracker = GlobalTracker
	local ZMExtraPerkVapors = LUI.UIList.new(f1_arg0, f1_arg1, -25, 0, nil, false, false, false, false)
	ZMExtraPerkVapors:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue(element, f1_arg1, "state", CoD.ZMPerkUtility.PerkVaporStates.DEFAULT, CoD.ZMPerkUtility.PerkVaporStates.HIDDEN)
			end,
		},
		{
			stateName = "Available",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ZMExtraPerkVapors:linkToElementModel(ZMExtraPerkVapors, "state", true, function(model)
		f1_arg0:updateElementState(ZMExtraPerkVapors, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	ZMExtraPerkVapors:setLeftRight(0.5, 0.5, 201, 631)
	ZMExtraPerkVapors:setTopBottom(0.5, 0.5, -28.5, 69.5)
	ZMExtraPerkVapors:setScale(1.25, 1.25)
	ZMExtraPerkVapors:setWidgetType(CoD.ZMPerkVaporItem)
	ZMExtraPerkVapors:setHorizontalCount(9)
	ZMExtraPerkVapors:setSpacing(-25)
	ZMExtraPerkVapors:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ZMExtraPerkVapors:setDataSource("ExtraPerkVapors")
	self:addElement(ZMExtraPerkVapors)
	self.ZMExtraPerkVapors = ZMExtraPerkVapors
	local DemoPip = CoD.DemoPip.new(f1_arg0, f1_arg1, 0, 0, 8, 13, 0, 0, 114.5, 119.5)
	self:addElement(DemoPip)
	self.DemoPip = DemoPip
	self:mergeStateConditions({
		{
			stateName = "HiddenCopy",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f12_local0 then
					f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
					if not f12_local0 then
						f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
						if not f12_local0 then
							f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"])
							if not f12_local0 then
								if Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
									f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
									if not f12_local0 then
										f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
										if not f12_local0 then
											f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
											if not f12_local0 then
												f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
												if not f12_local0 then
													f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_scoped"])
													if not f12_local0 then
														f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
														if not f12_local0 then
															f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
														end
													end
												end
											end
										end
									end
								else
									f12_local0 = true
								end
							end
						end
					end
				end
				return f12_local0
			end,
		},
	})
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "zmhud.damage_point_shake", function(model)
		local f25_local0 = self
		PlayClip(self, "DefaultClip", f1_arg1)
	end)
	ZMExtraPerkVapors.id = "ZMExtraPerkVapors"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerWidget_ZM.__resetProperties = function(f26_arg0)
	f26_arg0.SelfReviveCounter:completeAnimation()
	f26_arg0.Score:completeAnimation()
	f26_arg0.HealthValue:completeAnimation()
	f26_arg0.headshotBarBacking:completeAnimation()
	f26_arg0.Backing:completeAnimation()
	f26_arg0.Checkbox:completeAnimation()
	f26_arg0.BackingBlur:completeAnimation()
	f26_arg0.ScoreShadow:completeAnimation()
	f26_arg0.GlobalTracker:completeAnimation()
	f26_arg0.ZMExtraPerkVapors:completeAnimation()
	f26_arg0.DemoPip:completeAnimation()
	f26_arg0.SelfReviveCounter:setLeftRight(0, 0, -51, 34)
	f26_arg0.SelfReviveCounter:setTopBottom(0, 0, 69.5, 114.5)
	f26_arg0.SelfReviveCounter:setAlpha(1)
	f26_arg0.Score:setLeftRight(0, 0, 115, 244)
	f26_arg0.Score:setTopBottom(0, 0, 26.5, 73.5)
	f26_arg0.Score:setAlpha(1)
	f26_arg0.HealthValue:setLeftRight(0, 0, -4, 234)
	f26_arg0.HealthValue:setTopBottom(0, 0, 42.5, 208.5)
	f26_arg0.HealthValue:setAlpha(1)
	f26_arg0.headshotBarBacking:setLeftRight(0.5, 0.5, -171, -36)
	f26_arg0.headshotBarBacking:setTopBottom(0.5, 0.5, -67, 68)
	f26_arg0.headshotBarBacking:setAlpha(1)
	f26_arg0.Backing:setLeftRight(0.5, 0.5, -176, 176)
	f26_arg0.Backing:setTopBottom(0.5, 0.5, -64, 64)
	f26_arg0.Backing:setAlpha(1)
	f26_arg0.Checkbox:setAlpha(1)
	f26_arg0.BackingBlur:setAlpha(0.9)
	f26_arg0.ScoreShadow:setAlpha(1)
	f26_arg0.GlobalTracker:setAlpha(1)
	f26_arg0.ZMExtraPerkVapors:setAlpha(1)
	f26_arg0.DemoPip:setAlpha(1)
end
CoD.PlayerWidget_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
		Shake = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						f31_arg0:beginAnimation(89)
						f31_arg0:setLeftRight(0.5, 0.5, -176, 176)
						f31_arg0:setTopBottom(0.5, 0.5, -64, 64)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f30_arg0:beginAnimation(90)
					f30_arg0:setLeftRight(0.5, 0.5, -171, 181)
					f30_arg0:setTopBottom(0.5, 0.5, -62, 66)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f28_arg0.Backing:beginAnimation(80)
				f28_arg0.Backing:setLeftRight(0.5, 0.5, -166, 186)
				f28_arg0.Backing:setTopBottom(0.5, 0.5, -69, 59)
				f28_arg0.Backing:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Backing:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.Backing:completeAnimation()
			f28_arg0.Backing:setLeftRight(0.5, 0.5, -176, 176)
			f28_arg0.Backing:setTopBottom(0.5, 0.5, -64, 64)
			f28_local0(f28_arg0.Backing)
			local f28_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						f34_arg0:beginAnimation(89)
						f34_arg0:setLeftRight(0, 0, -28, 75)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f33_arg0:beginAnimation(90)
					f33_arg0:setLeftRight(0, 0, -31.5, 71.5)
					f33_arg0:setTopBottom(0, 0, 4.5, 107.5)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f28_arg0.headshotBarBacking:beginAnimation(80)
				f28_arg0.headshotBarBacking:setLeftRight(0, 0, -23, 80)
				f28_arg0.headshotBarBacking:setTopBottom(0, 0, 0.5, 103.5)
				f28_arg0.headshotBarBacking:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.headshotBarBacking:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f28_arg0.headshotBarBacking:completeAnimation()
			f28_arg0.headshotBarBacking:setLeftRight(0, 0, -28, 75)
			f28_arg0.headshotBarBacking:setTopBottom(0, 0, 4.5, 107.5)
			f28_local1(f28_arg0.headshotBarBacking)
			local f28_local2 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					local f36_local0 = function(f37_arg0)
						f37_arg0:beginAnimation(89)
						f37_arg0:setLeftRight(0, 0, -6, 232)
						f37_arg0:setTopBottom(0, 0, 42, 208)
						f37_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f36_arg0:beginAnimation(90)
					f36_arg0:setLeftRight(0, 0, -4, 234)
					f36_arg0:setTopBottom(0, 0, 32, 198)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
				end
				f28_arg0.HealthValue:beginAnimation(80)
				f28_arg0.HealthValue:setLeftRight(0, 0, 5, 243)
				f28_arg0.HealthValue:setTopBottom(0, 0, 50, 216)
				f28_arg0.HealthValue:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.HealthValue:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f28_arg0.HealthValue:completeAnimation()
			f28_arg0.HealthValue:setLeftRight(0, 0, -6, 232)
			f28_arg0.HealthValue:setTopBottom(0, 0, 42, 208)
			f28_local2(f28_arg0.HealthValue)
			local f28_local3 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						f40_arg0:beginAnimation(89)
						f40_arg0:setLeftRight(0, 0, 115, 244)
						f40_arg0:setTopBottom(0, 0, 26.5, 73.5)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f39_arg0:beginAnimation(90)
					f39_arg0:setLeftRight(0, 0, 113, 242)
					f39_arg0:setTopBottom(0, 0, 16.5, 63.5)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f28_arg0.Score:beginAnimation(80)
				f28_arg0.Score:setLeftRight(0, 0, 117.5, 246.5)
				f28_arg0.Score:setTopBottom(0, 0, 12.5, 59.5)
				f28_arg0.Score:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Score:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f28_arg0.Score:completeAnimation()
			f28_arg0.Score:setLeftRight(0, 0, 115, 244)
			f28_arg0.Score:setTopBottom(0, 0, 26.5, 73.5)
			f28_local3(f28_arg0.Score)
			local f28_local4 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					local f42_local0 = function(f43_arg0)
						f43_arg0:beginAnimation(89)
						f43_arg0:setLeftRight(0, 0, -38, 32)
						f43_arg0:setTopBottom(0, 0, -14.5, 30.5)
						f43_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f42_arg0:beginAnimation(90)
					f42_arg0:setLeftRight(0, 0, -46, 24)
					f42_arg0:setTopBottom(0, 0, -33.5, 11.5)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
				end
				f28_arg0.SelfReviveCounter:beginAnimation(80)
				f28_arg0.SelfReviveCounter:setLeftRight(0, 0, -21, 49)
				f28_arg0.SelfReviveCounter:setTopBottom(0, 0, -23.44, 21.56)
				f28_arg0.SelfReviveCounter:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.SelfReviveCounter:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f28_arg0.SelfReviveCounter:completeAnimation()
			f28_arg0.SelfReviveCounter:setLeftRight(0, 0, -38, 47)
			f28_arg0.SelfReviveCounter:setTopBottom(0, 0, -14.5, 30.5)
			f28_local4(f28_arg0.SelfReviveCounter)
		end,
		Hidden = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(9)
			local f44_local0 = function(f45_arg0)
				f44_arg0.BackingBlur:beginAnimation(150)
				f44_arg0.BackingBlur:setAlpha(0)
				f44_arg0.BackingBlur:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.BackingBlur:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.BackingBlur:completeAnimation()
			f44_arg0.BackingBlur:setAlpha(0.9)
			f44_local0(f44_arg0.BackingBlur)
			local f44_local1 = function(f46_arg0)
				f44_arg0.Backing:beginAnimation(150)
				f44_arg0.Backing:setAlpha(0)
				f44_arg0.Backing:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.Backing:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.Backing:completeAnimation()
			f44_arg0.Backing:setAlpha(1)
			f44_local1(f44_arg0.Backing)
			local f44_local2 = function(f47_arg0)
				f44_arg0.headshotBarBacking:beginAnimation(150)
				f44_arg0.headshotBarBacking:setAlpha(0)
				f44_arg0.headshotBarBacking:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.headshotBarBacking:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.headshotBarBacking:completeAnimation()
			f44_arg0.headshotBarBacking:setAlpha(1)
			f44_local2(f44_arg0.headshotBarBacking)
			local f44_local3 = function(f48_arg0)
				f44_arg0.HealthValue:beginAnimation(150)
				f44_arg0.HealthValue:setAlpha(0)
				f44_arg0.HealthValue:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.HealthValue:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.HealthValue:completeAnimation()
			f44_arg0.HealthValue:setAlpha(1)
			f44_local3(f44_arg0.HealthValue)
			local f44_local4 = function(f49_arg0)
				f44_arg0.ScoreShadow:beginAnimation(150)
				f44_arg0.ScoreShadow:setAlpha(0)
				f44_arg0.ScoreShadow:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.ScoreShadow:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.ScoreShadow:completeAnimation()
			f44_arg0.ScoreShadow:setAlpha(1)
			f44_local4(f44_arg0.ScoreShadow)
			local f44_local5 = function(f50_arg0)
				f44_arg0.Score:beginAnimation(150)
				f44_arg0.Score:setAlpha(0)
				f44_arg0.Score:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.Score:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.Score:completeAnimation()
			f44_arg0.Score:setAlpha(1)
			f44_local5(f44_arg0.Score)
			local f44_local6 = function(f51_arg0)
				f44_arg0.SelfReviveCounter:beginAnimation(150)
				f44_arg0.SelfReviveCounter:setAlpha(0)
				f44_arg0.SelfReviveCounter:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.SelfReviveCounter:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.SelfReviveCounter:completeAnimation()
			f44_arg0.SelfReviveCounter:setAlpha(1)
			f44_local6(f44_arg0.SelfReviveCounter)
			local f44_local7 = function(f52_arg0)
				f44_arg0.Checkbox:beginAnimation(150)
				f44_arg0.Checkbox:setAlpha(0)
				f44_arg0.Checkbox:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.Checkbox:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.Checkbox:completeAnimation()
			f44_arg0.Checkbox:setAlpha(1)
			f44_local7(f44_arg0.Checkbox)
			local f44_local8 = function(f53_arg0)
				f44_arg0.GlobalTracker:beginAnimation(150)
				f44_arg0.GlobalTracker:setAlpha(0)
				f44_arg0.GlobalTracker:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.GlobalTracker:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
			end
			f44_arg0.GlobalTracker:completeAnimation()
			f44_arg0.GlobalTracker:setAlpha(1)
			f44_local8(f44_arg0.GlobalTracker)
		end,
	},
	HiddenCopy = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(11)
			f54_arg0.BackingBlur:completeAnimation()
			f54_arg0.BackingBlur:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.BackingBlur)
			f54_arg0.Backing:completeAnimation()
			f54_arg0.Backing:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.Backing)
			f54_arg0.headshotBarBacking:completeAnimation()
			f54_arg0.headshotBarBacking:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.headshotBarBacking)
			f54_arg0.HealthValue:completeAnimation()
			f54_arg0.HealthValue:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.HealthValue)
			f54_arg0.ScoreShadow:completeAnimation()
			f54_arg0.ScoreShadow:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.ScoreShadow)
			f54_arg0.Score:completeAnimation()
			f54_arg0.Score:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.Score)
			f54_arg0.SelfReviveCounter:completeAnimation()
			f54_arg0.SelfReviveCounter:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.SelfReviveCounter)
			f54_arg0.Checkbox:completeAnimation()
			f54_arg0.Checkbox:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.Checkbox)
			f54_arg0.GlobalTracker:completeAnimation()
			f54_arg0.GlobalTracker:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.GlobalTracker)
			f54_arg0.ZMExtraPerkVapors:completeAnimation()
			f54_arg0.ZMExtraPerkVapors:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.ZMExtraPerkVapors)
			f54_arg0.DemoPip:completeAnimation()
			f54_arg0.DemoPip:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.DemoPip)
		end,
	},
	Hidden = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(11)
			f55_arg0.BackingBlur:completeAnimation()
			f55_arg0.BackingBlur:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.BackingBlur)
			f55_arg0.Backing:completeAnimation()
			f55_arg0.Backing:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Backing)
			f55_arg0.headshotBarBacking:completeAnimation()
			f55_arg0.headshotBarBacking:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.headshotBarBacking)
			f55_arg0.HealthValue:completeAnimation()
			f55_arg0.HealthValue:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.HealthValue)
			f55_arg0.ScoreShadow:completeAnimation()
			f55_arg0.ScoreShadow:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ScoreShadow)
			f55_arg0.Score:completeAnimation()
			f55_arg0.Score:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Score)
			f55_arg0.SelfReviveCounter:completeAnimation()
			f55_arg0.SelfReviveCounter:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.SelfReviveCounter)
			f55_arg0.Checkbox:completeAnimation()
			f55_arg0.Checkbox:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Checkbox)
			f55_arg0.GlobalTracker:completeAnimation()
			f55_arg0.GlobalTracker:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.GlobalTracker)
			f55_arg0.ZMExtraPerkVapors:completeAnimation()
			f55_arg0.ZMExtraPerkVapors:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ZMExtraPerkVapors)
			f55_arg0.DemoPip:completeAnimation()
			f55_arg0.DemoPip:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.DemoPip)
		end,
		DefaultState = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(9)
			local f56_local0 = function(f57_arg0)
				f56_arg0.BackingBlur:beginAnimation(150)
				f56_arg0.BackingBlur:setAlpha(0.9)
				f56_arg0.BackingBlur:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.BackingBlur:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.BackingBlur:completeAnimation()
			f56_arg0.BackingBlur:setAlpha(0)
			f56_local0(f56_arg0.BackingBlur)
			local f56_local1 = function(f58_arg0)
				f56_arg0.Backing:beginAnimation(150)
				f56_arg0.Backing:setAlpha(1)
				f56_arg0.Backing:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.Backing:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.Backing:completeAnimation()
			f56_arg0.Backing:setAlpha(0)
			f56_local1(f56_arg0.Backing)
			local f56_local2 = function(f59_arg0)
				f56_arg0.headshotBarBacking:beginAnimation(150)
				f56_arg0.headshotBarBacking:setAlpha(1)
				f56_arg0.headshotBarBacking:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.headshotBarBacking:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.headshotBarBacking:completeAnimation()
			f56_arg0.headshotBarBacking:setAlpha(0)
			f56_local2(f56_arg0.headshotBarBacking)
			local f56_local3 = function(f60_arg0)
				f56_arg0.HealthValue:beginAnimation(150)
				f56_arg0.HealthValue:setAlpha(1)
				f56_arg0.HealthValue:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.HealthValue:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.HealthValue:completeAnimation()
			f56_arg0.HealthValue:setAlpha(0)
			f56_local3(f56_arg0.HealthValue)
			local f56_local4 = function(f61_arg0)
				f56_arg0.ScoreShadow:beginAnimation(150)
				f56_arg0.ScoreShadow:setAlpha(1)
				f56_arg0.ScoreShadow:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.ScoreShadow:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.ScoreShadow:completeAnimation()
			f56_arg0.ScoreShadow:setAlpha(0)
			f56_local4(f56_arg0.ScoreShadow)
			local f56_local5 = function(f62_arg0)
				f56_arg0.Score:beginAnimation(150)
				f56_arg0.Score:setAlpha(1)
				f56_arg0.Score:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.Score:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.Score:completeAnimation()
			f56_arg0.Score:setAlpha(0)
			f56_local5(f56_arg0.Score)
			local f56_local6 = function(f63_arg0)
				f56_arg0.SelfReviveCounter:beginAnimation(150)
				f56_arg0.SelfReviveCounter:setAlpha(1)
				f56_arg0.SelfReviveCounter:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.SelfReviveCounter:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.SelfReviveCounter:completeAnimation()
			f56_arg0.SelfReviveCounter:setAlpha(0)
			f56_local6(f56_arg0.SelfReviveCounter)
			local f56_local7 = function(f64_arg0)
				f56_arg0.Checkbox:beginAnimation(150)
				f56_arg0.Checkbox:setAlpha(1)
				f56_arg0.Checkbox:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.Checkbox:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.Checkbox:completeAnimation()
			f56_arg0.Checkbox:setAlpha(0)
			f56_local7(f56_arg0.Checkbox)
			local f56_local8 = function(f65_arg0)
				f56_arg0.GlobalTracker:beginAnimation(150)
				f56_arg0.GlobalTracker:setAlpha(1)
				f56_arg0.GlobalTracker:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.GlobalTracker:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.GlobalTracker:completeAnimation()
			f56_arg0.GlobalTracker:setAlpha(0)
			f56_local8(f56_arg0.GlobalTracker)
		end,
	},
}
CoD.PlayerWidget_ZM.__onClose = function(f66_arg0)
	f66_arg0.headshotBarBacking:close()
	f66_arg0.HealthValue:close()
	f66_arg0.ScoreShadow:close()
	f66_arg0.Score:close()
	f66_arg0.SelfReviveCounter:close()
	f66_arg0.Checkbox:close()
	f66_arg0.GlobalTracker:close()
	f66_arg0.ZMExtraPerkVapors:close()
	f66_arg0.DemoPip:close()
end
