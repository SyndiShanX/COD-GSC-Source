require("x64:ef643b0f71e0bc5")
CoD.PlayerWidget_ZM_Trials = InheritFrom(LUI.UIElement)
CoD.PlayerWidget_ZM_Trials.__defaultWidth = 129
CoD.PlayerWidget_ZM_Trials.__defaultHeight = 56
CoD.PlayerWidget_ZM_Trials.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerWidget_ZM_Trials)
	self.id = "PlayerWidget_ZM_Trials"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CheckBox2 = LUI.UIImage.new(0, 0, 0, 45, 0, 0, 10, 55)
	CheckBox2:setImage(RegisterImage(0x3A6C1FB3B354832))
	self:addElement(CheckBox2)
	self.CheckBox2 = CheckBox2
	local white = LUI.UIImage.new(0, 0, 0, 55, 0, 0, 0, 55)
	white:setAlpha(0)
	white:setImage(RegisterImage(0xC7BD74A16D7054B))
	self:addElement(white)
	self.white = white
	local yellow = LUI.UIImage.new(0, 0, 0, 55, 0, 0, 0, 55)
	yellow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	yellow:setAlpha(0)
	yellow:setImage(RegisterImage(0x1E5C0EED08D22D))
	yellow:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	yellow:setShaderVector(0, 1, 0, 0, 0)
	yellow:setShaderVector(1, 0, 0, 0, 0)
	yellow:setShaderVector(2, 1, 0, 0, 0)
	yellow:setShaderVector(3, 0, 0, 0, 0)
	yellow:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(yellow)
	self.yellow = yellow
	local glow = LUI.UIImage.new(0, 0, 0, 55, 0, 0, 0, 55)
	glow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	glow:setAlpha(0)
	glow:setImage(RegisterImage(0x1E5C0EED08D22D))
	self:addElement(glow)
	self.glow = glow
	local ZmFxSpark2Ext0 = CoD.ZmFx_Spark2Ext.new(f1_arg0, f1_arg1, 0, 0, -1, 84, 0, 0, -68, 60)
	ZmFxSpark2Ext0:setAlpha(0)
	ZmFxSpark2Ext0:setZRot(9)
	ZmFxSpark2Ext0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ZmFxSpark2Ext0)
	self.ZmFxSpark2Ext0 = ZmFxSpark2Ext0
	local Counter = LUI.UIText.new(0, 0, 0, 129, 0, 0, 22, 49)
	Counter:setTTF("skorzhen")
	Counter:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Counter.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			Counter:setText(CoD.ZombieUtility.GetCounterProgress(f2_local0))
		end
	end
	Counter:linkToElementModel(self, "trialsCounterValue", true, Counter.__String_Reference)
	Counter.__String_Reference_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.trialsCounterValue
		end
		if f3_local0 then
			Counter.__String_Reference(f3_local0)
		end
	end
	self:addElement(Counter)
	self.Counter = Counter
	local f1_local7 = Counter
	local f1_local8 = Counter.subscribeToModel
	local f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["ZMHudGlobal.trials.playerCounterMax"], Counter.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "HideForRoundSplash",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden")
			end,
		},
		{
			stateName = "Counter",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "trialsCheckState", CoD.ZombieUtility.TrialsInfoStates.STATE_COUNTER)
			end,
		},
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "trialsCheckState", CoD.ZombieUtility.TrialsInfoStates.STATE_CHECKED)
			end,
		},
		{
			stateName = "Unchecked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "trialsCheckState", CoD.ZombieUtility.TrialsInfoStates.STATE_UNCHECKED)
			end,
		},
	})
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["ZMHudGlobal.trials.infoHidden"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "ZMHudGlobal.trials.infoHidden",
		})
	end, false)
	self:linkToElementModel(self, "trialsCheckState", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialsCheckState",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	if CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials") then
		CoD.ZombieUtility.TrialsCreatePlayerListClientModel(self, f1_arg1)
	end
	return self
end
CoD.PlayerWidget_ZM_Trials.__resetProperties = function(f10_arg0)
	f10_arg0.Counter:completeAnimation()
	f10_arg0.CheckBox2:completeAnimation()
	f10_arg0.white:completeAnimation()
	f10_arg0.ZmFxSpark2Ext0:completeAnimation()
	f10_arg0.glow:completeAnimation()
	f10_arg0.Counter:setAlpha(1)
	f10_arg0.CheckBox2:setAlpha(1)
	f10_arg0.CheckBox2:setImage(RegisterImage(0x3A6C1FB3B354832))
	f10_arg0.white:setAlpha(0)
	f10_arg0.white:setImage(RegisterImage(0xC7BD74A16D7054B))
	f10_arg0.ZmFxSpark2Ext0:setLeftRight(0, 0, -1, 84)
	f10_arg0.ZmFxSpark2Ext0:setTopBottom(0, 0, -68, 60)
	f10_arg0.ZmFxSpark2Ext0:setAlpha(0)
	f10_arg0.glow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	f10_arg0.glow:setAlpha(0)
	f10_arg0.glow:setImage(RegisterImage(0x1E5C0EED08D22D))
end
CoD.PlayerWidget_ZM_Trials.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.CheckBox2:completeAnimation()
			f11_arg0.CheckBox2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CheckBox2)
			f11_arg0.Counter:completeAnimation()
			f11_arg0.Counter:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Counter)
		end,
	},
	HideForRoundSplash = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.CheckBox2:completeAnimation()
			f12_arg0.CheckBox2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CheckBox2)
			f12_arg0.Counter:completeAnimation()
			f12_arg0.Counter:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Counter)
		end,
	},
	Counter = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.CheckBox2:completeAnimation()
			f13_arg0.CheckBox2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.CheckBox2)
			f13_arg0.Counter:completeAnimation()
			f13_arg0.Counter:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Counter)
		end,
		Checked = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(430)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(279)
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f14_arg0.white:beginAnimation(1150)
				f14_arg0.white:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.white:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.white:completeAnimation()
			f14_arg0.white:setAlpha(0)
			f14_arg0.white:setImage(RegisterImage(0xC7BD74A16D7054B))
			f14_local0(f14_arg0.white)
			local f14_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							f21_arg0:beginAnimation(710)
							f21_arg0:setAlpha(0)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
						end
						f20_arg0:beginAnimation(339)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(180)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f14_arg0.glow:beginAnimation(630)
				f14_arg0.glow:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.glow:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f14_arg0.glow:completeAnimation()
			f14_arg0.glow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
			f14_arg0.glow:setAlpha(0)
			f14_arg0.glow:setImage(RegisterImage(0x1E5C0EED08D22D))
			f14_local1(f14_arg0.glow)
			local f14_local2 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							f25_arg0:beginAnimation(439)
							f25_arg0:setAlpha(0)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
						end
						f24_arg0:beginAnimation(570)
						f24_arg0:setLeftRight(0, 0, 12.5, 97.5)
						f24_arg0:setTopBottom(0, 0, -105, 23)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(329)
					f23_arg0:setLeftRight(0, 0, -15, 70)
					f23_arg0:setTopBottom(0, 0, -73, 55)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f14_arg0.ZmFxSpark2Ext0:beginAnimation(170)
				f14_arg0.ZmFxSpark2Ext0:setLeftRight(0, 0, -30, 55)
				f14_arg0.ZmFxSpark2Ext0:setTopBottom(0, 0, -90, 38)
				f14_arg0.ZmFxSpark2Ext0:setAlpha(1)
				f14_arg0.ZmFxSpark2Ext0:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ZmFxSpark2Ext0:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f14_arg0.ZmFxSpark2Ext0:completeAnimation()
			f14_arg0.ZmFxSpark2Ext0:setLeftRight(0, 0, -34.5, 50.5)
			f14_arg0.ZmFxSpark2Ext0:setTopBottom(0, 0, -92, 36)
			f14_arg0.ZmFxSpark2Ext0:setAlpha(0)
			f14_local2(f14_arg0.ZmFxSpark2Ext0)
			f14_arg0.Counter:completeAnimation()
			f14_arg0.Counter:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Counter)
		end,
	},
	Checked = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.CheckBox2:completeAnimation()
			f26_arg0.CheckBox2:setImage(RegisterImage(0x3A6C1FB3B354832))
			f26_arg0.clipFinished(f26_arg0.CheckBox2)
			f26_arg0.white:completeAnimation()
			f26_arg0.white:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.white)
			f26_arg0.Counter:completeAnimation()
			f26_arg0.Counter:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Counter)
		end,
	},
	Unchecked = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.CheckBox2:completeAnimation()
			f27_arg0.CheckBox2:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.CheckBox2)
			f27_arg0.Counter:completeAnimation()
			f27_arg0.Counter:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Counter)
		end,
		Checked = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(4)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						f31_arg0:beginAnimation(430)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f30_arg0:beginAnimation(279)
					f30_arg0:setAlpha(1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f28_arg0.white:beginAnimation(1150)
				f28_arg0.white:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.white:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.white:completeAnimation()
			f28_arg0.white:setAlpha(0)
			f28_arg0.white:setImage(RegisterImage(0xC7BD74A16D7054B))
			f28_local0(f28_arg0.white)
			local f28_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							f35_arg0:beginAnimation(710)
							f35_arg0:setAlpha(0)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
						end
						f34_arg0:beginAnimation(339)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(180)
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f28_arg0.glow:beginAnimation(630)
				f28_arg0.glow:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.glow:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f28_arg0.glow:completeAnimation()
			f28_arg0.glow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
			f28_arg0.glow:setAlpha(0)
			f28_arg0.glow:setImage(RegisterImage(0x1E5C0EED08D22D))
			f28_local1(f28_arg0.glow)
			local f28_local2 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					local f37_local0 = function(f38_arg0)
						local f38_local0 = function(f39_arg0)
							f39_arg0:beginAnimation(439)
							f39_arg0:setAlpha(0)
							f39_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
						end
						f38_arg0:beginAnimation(570)
						f38_arg0:setLeftRight(0, 0, 12.5, 97.5)
						f38_arg0:setTopBottom(0, 0, -105, 23)
						f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
					end
					f37_arg0:beginAnimation(329)
					f37_arg0:setLeftRight(0, 0, -15, 70)
					f37_arg0:setTopBottom(0, 0, -73, 55)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
				end
				f28_arg0.ZmFxSpark2Ext0:beginAnimation(170)
				f28_arg0.ZmFxSpark2Ext0:setLeftRight(0, 0, -30, 55)
				f28_arg0.ZmFxSpark2Ext0:setTopBottom(0, 0, -90, 38)
				f28_arg0.ZmFxSpark2Ext0:setAlpha(1)
				f28_arg0.ZmFxSpark2Ext0:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ZmFxSpark2Ext0:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f28_arg0.ZmFxSpark2Ext0:completeAnimation()
			f28_arg0.ZmFxSpark2Ext0:setLeftRight(0, 0, -34.5, 50.5)
			f28_arg0.ZmFxSpark2Ext0:setTopBottom(0, 0, -92, 36)
			f28_arg0.ZmFxSpark2Ext0:setAlpha(0)
			f28_local2(f28_arg0.ZmFxSpark2Ext0)
			f28_arg0.Counter:completeAnimation()
			f28_arg0.Counter:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.Counter)
		end,
	},
}
CoD.PlayerWidget_ZM_Trials.__onClose = function(f40_arg0)
	f40_arg0.ZmFxSpark2Ext0:close()
	f40_arg0.Counter:close()
end
