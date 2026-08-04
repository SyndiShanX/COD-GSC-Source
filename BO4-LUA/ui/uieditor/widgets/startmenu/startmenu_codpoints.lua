CoD.StartMenu_CODpoints = InheritFrom(LUI.UIElement)
CoD.StartMenu_CODpoints.__defaultWidth = 104
CoD.StartMenu_CODpoints.__defaultHeight = 80
CoD.StartMenu_CODpoints.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_CODpoints)
	self.id = "StartMenu_CODpoints"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -40, 40)
	Background:setRGB(0.32, 0.32, 0.32)
	Background:setAlpha(0)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial("uie_smoke"))
	Background:setShaderVector(0, 0.4, 0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local ring = LUI.UIImage.new(0, 0, -16, 64, 0, 0, 1, 81)
	ring:setAlpha(0)
	ring:setImage(RegisterImage("uie_t7_blackmarket_keyringglow_glow"))
	self:addElement(ring)
	self.ring = ring
	local Glow = LUI.UIImage.new(0, 0, -21, 69, 0, 0, -4, 88)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage("uie_t7_blackmarket_keyglow_gold"))
	self:addElement(Glow)
	self.Glow = Glow
	local codpoints = LUI.UIImage.new(0, 0, 7, 41, 0, 0, 25, 59)
	codpoints:setImage(RegisterImage("uie_ui_codpoints_symbol_32x32"))
	self:addElement(codpoints)
	self.codpoints = codpoints
	local codpointGlint = LUI.UIImage.new(0, 0, 7, 41, 0, 0, 25, 59)
	codpointGlint:setRGB(1, 0.94, 0.57)
	codpointGlint:setImage(RegisterImage("uie_ui_codpoints_symbol_32x32"))
	codpointGlint:setMaterial(LUI.UIImage.GetCachedMaterial("uie_glint_reveal"))
	codpointGlint:setShaderVector(0, 0.01, 0, 0, 0)
	self:addElement(codpointGlint)
	self.codpointGlint = codpointGlint
	local codpointsCount = LUI.UIText.new(0, 0, 45, 107, 0, 0, 30.5, 52.5)
	codpointsCount.__Color = function()
		codpointsCount:setRGB(CodPointsColor("LootStreamProgress.codPoints", f1_arg1, ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b))
	end
	codpointsCount.__Color()
	codpointsCount:setTTF("ttmussels_demibold")
	codpointsCount:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	codpointsCount:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	codpointsCount:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "codPoints", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f3_local0))
		end
	end)
	self:addElement(codpointsCount)
	self.codpointsCount = codpointsCount
	local Image = LUI.UIImage.new(0, 0, 161, 200, 0, 0, 0, 80)
	Image:setAlpha(0)
	self:addElement(Image)
	self.Image = Image
	local f1_local8 = codpointsCount
	local f1_local9 = codpointsCount.subscribeToModel
	local f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["LootStreamProgress.codPoints"], codpointsCount.__Color)
	self:mergeStateConditions({
		{
			stateName = "ShowShimmer",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "LootStreamProgress.codPoints", 200) and AreCodPointsEnabled(f1_arg1)
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return AreCodPointsEnabled(f1_arg1)
			end,
		},
	})
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10["LootStreamProgress.codPoints"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LootStreamProgress.codPoints",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine.GetGlobalModel()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNetworkMode"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_CODpoints.__resetProperties = function(f8_arg0)
	f8_arg0.codpointGlint:completeAnimation()
	f8_arg0.codpoints:completeAnimation()
	f8_arg0.codpointsCount:completeAnimation()
	f8_arg0.Glow:completeAnimation()
	f8_arg0.ring:completeAnimation()
	f8_arg0.codpointGlint:setAlpha(1)
	f8_arg0.codpointGlint:setMaterial(LUI.UIImage.GetCachedMaterial("uie_glint_reveal"))
	f8_arg0.codpointGlint:setShaderVector(0, 0.01, 0, 0, 0)
	f8_arg0.codpoints:setAlpha(1)
	f8_arg0.codpointsCount:setAlpha(1)
	f8_arg0.Glow:setAlpha(0)
	f8_arg0.Glow:setScale(1, 1)
	f8_arg0.ring:setAlpha(0)
	f8_arg0.ring:setScale(1, 1)
end
CoD.StartMenu_CODpoints.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.codpoints:completeAnimation()
			f9_arg0.codpoints:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.codpoints)
			f9_arg0.codpointGlint:completeAnimation()
			f9_arg0.codpointGlint:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.codpointGlint)
			f9_arg0.codpointsCount:completeAnimation()
			f9_arg0.codpointsCount:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.codpointsCount)
		end,
	},
	ShowShimmer = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							local f14_local0 = function(f15_arg0)
								local f15_local0 = function(f16_arg0)
									f16_arg0:beginAnimation(60)
									f16_arg0:setScale(1.9, 1.9)
									f16_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
								end
								f15_arg0:beginAnimation(619)
								f15_arg0:setAlpha(0)
								f15_arg0:setScale(1.85, 1.85)
								f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
							end
							f14_arg0:beginAnimation(80)
							f14_arg0:setAlpha(0.5)
							f14_arg0:setScale(1.3, 1.3)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
						end
						f13_arg0:beginAnimation(29)
						f13_arg0:setAlpha(1)
						f13_arg0:setScale(1.08, 1.08)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(180, Enum[@"luitween"][@"luitween_bounce"])
					f12_arg0:setAlpha(0.86)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f10_arg0.ring:beginAnimation(1170)
				f10_arg0.ring:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ring:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.ring:completeAnimation()
			f10_arg0.ring:setAlpha(0)
			f10_arg0.ring:setScale(1, 1)
			f10_local0(f10_arg0.ring)
			local f10_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							local f20_local0 = function(f21_arg0)
								local f21_local0 = function(f22_arg0)
									f22_arg0:beginAnimation(299)
									f22_arg0:setAlpha(0)
									f22_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
								end
								f21_arg0:beginAnimation(360)
								f21_arg0:setAlpha(0.2)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
							end
							f20_arg0:beginAnimation(60)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(139)
						f19_arg0:setScale(0.8, 0.8)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(139)
					f18_arg0:setAlpha(1)
					f18_arg0:setScale(1, 1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f10_arg0.Glow:beginAnimation(1250)
				f10_arg0.Glow:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Glow:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f10_arg0.Glow:completeAnimation()
			f10_arg0.Glow:setAlpha(0)
			f10_arg0.Glow:setScale(0.8, 0.8)
			f10_local1(f10_arg0.Glow)
			local f10_local2 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						local f25_local0 = function(f26_arg0)
							local f26_local0 = function(f27_arg0)
								f27_arg0:beginAnimation(3560)
								f27_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
							end
							f26_arg0:beginAnimation(29)
							f26_arg0:setAlpha(1)
							f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
						end
						f25_arg0:beginAnimation(80)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
					end
					f24_arg0:beginAnimation(59)
					f24_arg0:setAlpha(0.85)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f10_arg0.codpoints:beginAnimation(1250)
				f10_arg0.codpoints:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.codpoints:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f10_arg0.codpoints:completeAnimation()
			f10_arg0.codpoints:setAlpha(1)
			f10_local2(f10_arg0.codpoints)
			local f10_local3 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					local f29_local0 = function(f30_arg0)
						f30_arg0:beginAnimation(60)
						f30_arg0:setAlpha(0)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
					end
					f29_arg0:beginAnimation(750)
					f29_arg0:setShaderVector(0, 0.99, 0, 0, 0)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f10_arg0.codpointGlint:beginAnimation(630)
				f10_arg0.codpointGlint:setAlpha(1)
				f10_arg0.codpointGlint:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.codpointGlint:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f10_arg0.codpointGlint:completeAnimation()
			f10_arg0.codpointGlint:setAlpha(0)
			f10_arg0.codpointGlint:setMaterial(LUI.UIImage.GetCachedMaterial("uie_glint_reveal"))
			f10_arg0.codpointGlint:setShaderVector(0, 0.01, 0, 0, 0)
			f10_local3(f10_arg0.codpointGlint)
			f10_arg0.nextClip = "DefaultClip"
		end,
	},
	Show = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.StartMenu_CODpoints.__onClose = function(f32_arg0)
	f32_arg0.codpointsCount:close()
end
