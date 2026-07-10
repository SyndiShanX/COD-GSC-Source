require("x64:5677da2fba4b1c9")
CoD.ZMTributeSplash = InheritFrom(LUI.UIElement)
CoD.ZMTributeSplash.__defaultWidth = 1920
CoD.ZMTributeSplash.__defaultHeight = 230
CoD.ZMTributeSplash.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "zmhud.playTributeSplash", 0)
	self:setClass(CoD.ZMTributeSplash)
	self.id = "ZMTributeSplash"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Text = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 112, 179)
	Text:setRGB(0.96, 0.67, 0)
	Text:setText(Engine[0xF9F1239CFD921FE](0x26FC3CB1BAC1018))
	Text:setTTF("skorzhen")
	Text:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Text:setShaderVector(0, 0.02, 0, 0, 0)
	Text:setShaderVector(1, 0.04, 0, 0, 0)
	Text:setShaderVector(2, 0, 0, 0, 1)
	Text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Text)
	self.Text = Text
	local ZMTitleFog = CoD.ZM_Title_Fog.new(f1_arg0, f1_arg1, 0, 0, 691, 1203, 0, 0, -166, 346)
	ZMTitleFog:setAlpha(0)
	ZMTitleFog:setScale(1.5, 0.8)
	self:addElement(ZMTitleFog)
	self.ZMTitleFog = ZMTitleFog
	self:mergeStateConditions({
		{
			stateName = "ItemUpgraded",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "luielement.zm_red_challenges_hud.tributeAvailable", 1)
			end,
		},
		{
			stateName = "ItemAvailable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "luielement.zm_red_challenges_hud.tributeAvailable", 0)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["luielement.zm_red_challenges_hud.tributeAvailable"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "luielement.zm_red_challenges_hud.tributeAvailable",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "zmhud.playTributeSplash", function(model)
		local f5_local0 = self
		if CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "zmhud.playTributeSplash", 0) then
			PlayClip(self, "DefaultClip", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTributeSplash.__resetProperties = function(f6_arg0)
	f6_arg0.Text:completeAnimation()
	f6_arg0.ZMTitleFog:completeAnimation()
	f6_arg0.Text:setLeftRight(0, 0, 0, 1920)
	f6_arg0.Text:setTopBottom(0, 0, 112, 179)
	f6_arg0.Text:setAlpha(1)
	f6_arg0.Text:setScale(1, 1)
	f6_arg0.Text:setText(Engine[0xF9F1239CFD921FE](0x26FC3CB1BAC1018))
	f6_arg0.ZMTitleFog:setTopBottom(0, 0, -166, 346)
	f6_arg0.ZMTitleFog:setAlpha(0)
	f6_arg0.ZMTitleFog:setScale(1.5, 0.8)
end
CoD.ZMTributeSplash.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Text:completeAnimation()
			f7_arg0.Text:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Text)
		end,
	},
	ItemUpgraded = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							local f12_local0 = function(f13_arg0)
								f13_arg0:beginAnimation(660)
								f13_arg0:setAlpha(0)
								f13_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
							end
							f12_arg0:beginAnimation(289)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
						end
						f11_arg0:beginAnimation(2300)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(940)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.Text:beginAnimation(690)
				f8_arg0.Text:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Text:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.Text:completeAnimation()
			f8_arg0.Text:setLeftRight(0, 0, 0, 1920)
			f8_arg0.Text:setTopBottom(0, 0, 114, 181)
			f8_arg0.Text:setAlpha(0)
			f8_arg0.Text:setScale(1, 1)
			f8_arg0.Text:setText(Engine[0xF9F1239CFD921FE](0xAB00E68B32F8B69))
			f8_local0(f8_arg0.Text)
			local f8_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							local f17_local0 = function(f18_arg0)
								f18_arg0:beginAnimation(909)
								f18_arg0:setAlpha(0)
								f18_arg0:setScale(1.8, 0.6)
								f18_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
							end
							f17_arg0:beginAnimation(700)
							f17_arg0:setAlpha(1)
							f17_arg0:setScale(1.6, 0.9)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
						end
						f16_arg0:beginAnimation(640)
						f16_arg0:setAlpha(0.2)
						f16_arg0:setScale(1.59, 0.8)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(2310)
					f15_arg0:setAlpha(0)
					f15_arg0:setScale(1.57, 0.8)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f8_arg0.ZMTitleFog:beginAnimation(690)
				f8_arg0.ZMTitleFog:setAlpha(1)
				f8_arg0.ZMTitleFog:setScale(1.5, 0.8)
				f8_arg0.ZMTitleFog:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ZMTitleFog:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f8_arg0.ZMTitleFog:completeAnimation()
			f8_arg0.ZMTitleFog:setTopBottom(0, 0, -103, 321)
			f8_arg0.ZMTitleFog:setAlpha(0)
			f8_arg0.ZMTitleFog:setScale(1.5, 0.6)
			f8_local1(f8_arg0.ZMTitleFog)
		end,
	},
	ItemAvailable = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						local f22_local0 = function(f23_arg0)
							local f23_local0 = function(f24_arg0)
								f24_arg0:beginAnimation(439)
								f24_arg0:setAlpha(0)
								f24_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
							end
							f23_arg0:beginAnimation(510)
							f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
						end
						f22_arg0:beginAnimation(1270)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
					end
					f21_arg0:beginAnimation(1040)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f19_arg0.Text:beginAnimation(1960)
				f19_arg0.Text:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Text:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.Text:completeAnimation()
			f19_arg0.Text:setLeftRight(0, 0, 0, 1920)
			f19_arg0.Text:setTopBottom(0, 0, 114, 181)
			f19_arg0.Text:setAlpha(0)
			f19_arg0.Text:setScale(1, 1)
			f19_local0(f19_arg0.Text)
			local f19_local1 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						local f27_local0 = function(f28_arg0)
							local f28_local0 = function(f29_arg0)
								f29_arg0:beginAnimation(1619)
								f29_arg0:setAlpha(0)
								f29_arg0:setScale(1.8, 0.6)
								f29_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
							end
							f28_arg0:beginAnimation(920)
							f28_arg0:setAlpha(1)
							f28_arg0:setScale(1.6, 0.9)
							f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
						end
						f27_arg0:beginAnimation(980)
						f27_arg0:setAlpha(0.2)
						f27_arg0:setScale(1.59, 0.8)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
					end
					f26_arg0:beginAnimation(1730)
					f26_arg0:setAlpha(0)
					f26_arg0:setScale(1.56, 0.8)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f19_arg0.ZMTitleFog:beginAnimation(1270)
				f19_arg0.ZMTitleFog:setAlpha(1)
				f19_arg0.ZMTitleFog:setScale(1.5, 0.8)
				f19_arg0.ZMTitleFog:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ZMTitleFog:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f19_arg0.ZMTitleFog:completeAnimation()
			f19_arg0.ZMTitleFog:setTopBottom(0, 0, -103, 321)
			f19_arg0.ZMTitleFog:setAlpha(0)
			f19_arg0.ZMTitleFog:setScale(1.5, 0.6)
			f19_local1(f19_arg0.ZMTitleFog)
		end,
	},
}
CoD.ZMTributeSplash.__onClose = function(f30_arg0)
	f30_arg0.ZMTitleFog:close()
end
