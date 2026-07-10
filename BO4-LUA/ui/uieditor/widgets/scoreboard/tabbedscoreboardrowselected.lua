CoD.TabbedScoreboardRowSelected = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardRowSelected.__defaultWidth = 684
CoD.TabbedScoreboardRowSelected.__defaultHeight = 60
CoD.TabbedScoreboardRowSelected.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardRowSelected)
	self.id = "TabbedScoreboardRowSelected"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SelectedDotGlow = LUI.UIImage.new(0, 0, -1, 685, 0, 0, 0, 56)
	SelectedDotGlow:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator_bg"))
	self:addElement(SelectedDotGlow)
	self.SelectedDotGlow = SelectedDotGlow
	local SelectedDotGlowPC = nil
	SelectedDotGlowPC = LUI.UIImage.new(0, 0, -1, 685, 0, 0, 0, 56)
	SelectedDotGlowPC:setAlpha(0)
	SelectedDotGlowPC:setImage(RegisterImage(@"hash_6B7CDF731D0F3F6"))
	self:addElement(SelectedDotGlowPC)
	self.SelectedDotGlowPC = SelectedDotGlowPC
	local SelectedDotGlowAdd = LUI.UIImage.new(0, 0, -1, 685, 0, 0, 0, 56)
	SelectedDotGlowAdd:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator_bg"))
	SelectedDotGlowAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SelectedDotGlowAdd:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(SelectedDotGlowAdd)
	self.SelectedDotGlowAdd = SelectedDotGlowAdd
	local SelectedDotGlowAddPC = nil
	SelectedDotGlowAddPC = LUI.UIImage.new(0, 0, -1, 685, 0, 0, 0, 56)
	SelectedDotGlowAddPC:setAlpha(0)
	SelectedDotGlowAddPC:setImage(RegisterImage(@"hash_6B7CDF731D0F3F6"))
	SelectedDotGlowAddPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SelectedDotGlowAddPC:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(SelectedDotGlowAddPC)
	self.SelectedDotGlowAddPC = SelectedDotGlowAddPC
	local SelectedFrame = LUI.UIImage.new(0, 0, -7.5, 692.5, 0, 0, -9, 69)
	SelectedFrame:setAlpha(0)
	SelectedFrame:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator"))
	self:addElement(SelectedFrame)
	self.SelectedFrame = SelectedFrame
	local SelectedFrameNeutral = LUI.UIImage.new(0, 0, -7.5, 692.5, 0, 0, -9, 69)
	SelectedFrameNeutral:setRGB(0.85, 0.85, 0.85)
	SelectedFrameNeutral:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator_gray"))
	self:addElement(SelectedFrameNeutral)
	self.SelectedFrameNeutral = SelectedFrameNeutral
	local SelectedFrameNeutral2 = LUI.UIImage.new(0, 0, -7.5, 692.5, 0, 0, -9, 69)
	SelectedFrameNeutral2:setRGB(0.85, 0.85, 0.85)
	SelectedFrameNeutral2:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator_gray"))
	SelectedFrameNeutral2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(SelectedFrameNeutral2)
	self.SelectedFrameNeutral2 = SelectedFrameNeutral2
	local SelectedFrameNeutral3 = LUI.UIImage.new(0, 0, -7.5, 692.5, 0, 0, -9, 69)
	SelectedFrameNeutral3:setRGB(0.85, 0.85, 0.85)
	SelectedFrameNeutral3:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator_gray"))
	SelectedFrameNeutral3:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(SelectedFrameNeutral3)
	self.SelectedFrameNeutral3 = SelectedFrameNeutral3
	local SelectedFrameAdd = LUI.UIImage.new(0, 0, -8, 692, 0, 0, -9, 69)
	SelectedFrameAdd:setAlpha(0)
	SelectedFrameAdd:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_indicator_glow"))
	SelectedFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	SelectedFrameAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SelectedFrameAdd)
	self.SelectedFrameAdd = SelectedFrameAdd
	local SelectedFrameAddNeutral = LUI.UIImage.new(0, 0, -8, 692, 0, 0, -9, 69)
	SelectedFrameAddNeutral:setRGB(0.85, 0.85, 0.85)
	SelectedFrameAddNeutral:setAlpha(0)
	SelectedFrameAddNeutral:setImage(RegisterImage(@"hash_59D6F1F2500105F7"))
	SelectedFrameAddNeutral:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SelectedFrameAddNeutral:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SelectedFrameAddNeutral)
	self.SelectedFrameAddNeutral = SelectedFrameAddNeutral
	self:mergeStateConditions({
		{
			stateName = "SelfFocus",
			condition = function(menu, element, event)
				return IsScoreboardPlayerSelf(element, f1_arg1)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["deadSpectator.playerIndex"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "deadSpectator.playerIndex",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardRowSelected.__resetProperties = function(f7_arg0)
	f7_arg0.SelectedDotGlowAdd:completeAnimation()
	f7_arg0.SelectedFrameNeutral:completeAnimation()
	f7_arg0.SelectedFrameNeutral2:completeAnimation()
	f7_arg0.SelectedFrameNeutral3:completeAnimation()
	f7_arg0.SelectedFrameAddNeutral:completeAnimation()
	f7_arg0.SelectedFrameAdd:completeAnimation()
	f7_arg0.SelectedFrame:completeAnimation()
	f7_arg0.SelectedDotGlowAddPC:completeAnimation()
	f7_arg0.SelectedDotGlow:completeAnimation()
	f7_arg0.SelectedDotGlowPC:completeAnimation()
	f7_arg0.SelectedDotGlowAdd:setAlpha(1)
	f7_arg0.SelectedDotGlowAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f7_arg0.SelectedDotGlowAdd:setShaderVector(0, 3, 0, 0, 0)
	f7_arg0.SelectedFrameNeutral:setAlpha(1)
	f7_arg0.SelectedFrameNeutral2:setAlpha(1)
	f7_arg0.SelectedFrameNeutral3:setAlpha(1)
	f7_arg0.SelectedFrameAddNeutral:setAlpha(0)
	f7_arg0.SelectedFrameAddNeutral:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f7_arg0.SelectedFrameAddNeutral:setShaderVector(0, 1, 0, 0, 0)
	f7_arg0.SelectedFrameAdd:setAlpha(0)
	f7_arg0.SelectedFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	f7_arg0.SelectedFrameAdd:setShaderVector(0, 1, 0, 0, 0)
	f7_arg0.SelectedFrame:setAlpha(0)
	f7_arg0.SelectedDotGlowAddPC:setAlpha(0)
	f7_arg0.SelectedDotGlowAddPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	f7_arg0.SelectedDotGlowAddPC:setShaderVector(0, 3, 0, 0, 0)
	f7_arg0.SelectedDotGlow:setAlpha(1)
	f7_arg0.SelectedDotGlowPC:setAlpha(0)
end
CoD.TabbedScoreboardRowSelected.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							f12_arg0:beginAnimation(799)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
						end
						f11_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
						f11_arg0:setShaderVector(0, 1, 0, 0, 0)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(700, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.SelectedDotGlowAdd:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f8_arg0.SelectedDotGlowAdd:setShaderVector(0, 2, 0, 0, 0)
				f8_arg0.SelectedDotGlowAdd:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SelectedDotGlowAdd:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.SelectedDotGlowAdd:completeAnimation()
			f8_arg0.SelectedDotGlowAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f8_arg0.SelectedDotGlowAdd:setShaderVector(0, 1, 0, 0, 0)
			f8_local0(f8_arg0.SelectedDotGlowAdd)
			f8_arg0.SelectedFrameNeutral:completeAnimation()
			f8_arg0.SelectedFrameNeutral:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.SelectedFrameNeutral)
			f8_arg0.SelectedFrameNeutral2:completeAnimation()
			f8_arg0.SelectedFrameNeutral2:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.SelectedFrameNeutral2)
			f8_arg0.SelectedFrameNeutral3:completeAnimation()
			f8_arg0.SelectedFrameNeutral3:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.SelectedFrameNeutral3)
			local f8_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								local f17_local0 = function(f18_arg0)
									f18_arg0:beginAnimation(799)
									f18_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
								end
								f17_arg0:beginAnimation(900)
								f17_arg0:setShaderVector(0, 2.5, 0, 0, 0)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
							end
							f16_arg0:beginAnimation(99)
							f16_arg0:setShaderVector(0, 4, 0, 0, 0)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(700)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(100)
					f14_arg0:setShaderVector(0, 3.4, 0, 0, 0)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f8_arg0.SelectedFrameAddNeutral:beginAnimation(900)
				f8_arg0.SelectedFrameAddNeutral:setShaderVector(0, 4, 0, 0, 0)
				f8_arg0.SelectedFrameAddNeutral:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SelectedFrameAddNeutral:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f8_arg0.SelectedFrameAddNeutral:completeAnimation()
			f8_arg0.SelectedFrameAddNeutral:setAlpha(1)
			f8_arg0.SelectedFrameAddNeutral:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f8_arg0.SelectedFrameAddNeutral:setShaderVector(0, 2.5, 0, 0, 0)
			f8_local1(f8_arg0.SelectedFrameAddNeutral)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
	SelfFocus = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						local f22_local0 = function(f23_arg0)
							f23_arg0:beginAnimation(799)
							f23_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
						end
						f22_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
						f22_arg0:setShaderVector(0, 1, 0, 0, 0)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
					end
					f21_arg0:beginAnimation(700, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f19_arg0.SelectedDotGlowAdd:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f19_arg0.SelectedDotGlowAdd:setShaderVector(0, 2, 0, 0, 0)
				f19_arg0.SelectedDotGlowAdd:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.SelectedDotGlowAdd:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.SelectedDotGlowAdd:completeAnimation()
			f19_arg0.SelectedDotGlowAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f19_arg0.SelectedDotGlowAdd:setShaderVector(0, 1, 0, 0, 0)
			f19_local0(f19_arg0.SelectedDotGlowAdd)
			f19_arg0.SelectedFrame:completeAnimation()
			f19_arg0.SelectedFrame:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.SelectedFrame)
			local f19_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						local f26_local0 = function(f27_arg0)
							local f27_local0 = function(f28_arg0)
								local f28_local0 = function(f29_arg0)
									f29_arg0:beginAnimation(799)
									f29_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
								end
								f28_arg0:beginAnimation(900, Enum[@"luitween"][@"luitween_ease_out"])
								f28_arg0:setShaderVector(0, 2.5, 0, 0, 0)
								f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
							end
							f27_arg0:beginAnimation(99)
							f27_arg0:setShaderVector(0, 4, 0, 0, 0)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
						end
						f26_arg0:beginAnimation(700)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(100)
					f25_arg0:setShaderVector(0, 3.4, 0, 0, 0)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f19_arg0.SelectedFrameAdd:beginAnimation(900, Enum[@"luitween"][@"luitween_ease_in"])
				f19_arg0.SelectedFrameAdd:setShaderVector(0, 4, 0, 0, 0)
				f19_arg0.SelectedFrameAdd:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.SelectedFrameAdd:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f19_arg0.SelectedFrameAdd:completeAnimation()
			f19_arg0.SelectedFrameAdd:setAlpha(1)
			f19_arg0.SelectedFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
			f19_arg0.SelectedFrameAdd:setShaderVector(0, 2.5, 0, 0, 0)
			f19_local1(f19_arg0.SelectedFrameAdd)
			f19_arg0.nextClip = "DefaultClip"
		end,
	},
	PC = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(5)
			f30_arg0.SelectedDotGlow:completeAnimation()
			f30_arg0.SelectedDotGlow:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.SelectedDotGlow)
			f30_arg0.SelectedDotGlowPC:completeAnimation()
			f30_arg0.SelectedDotGlowPC:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.SelectedDotGlowPC)
			f30_arg0.SelectedDotGlowAdd:completeAnimation()
			f30_arg0.SelectedDotGlowAdd:setAlpha(0.25)
			f30_arg0.clipFinished(f30_arg0.SelectedDotGlowAdd)
			f30_arg0.SelectedDotGlowAddPC:completeAnimation()
			f30_arg0.SelectedDotGlowAddPC:setAlpha(0)
			f30_arg0.SelectedDotGlowAddPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
			f30_arg0.SelectedDotGlowAddPC:setShaderVector(0, 1, 0, 0, 0)
			f30_arg0.clipFinished(f30_arg0.SelectedDotGlowAddPC)
			f30_arg0.SelectedFrameAdd:completeAnimation()
			f30_arg0.SelectedFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
			f30_arg0.SelectedFrameAdd:setShaderVector(0, 2.5, 0, 0, 0)
			f30_arg0.clipFinished(f30_arg0.SelectedFrameAdd)
			f30_arg0.nextClip = "DefaultClip"
		end,
	},
}
