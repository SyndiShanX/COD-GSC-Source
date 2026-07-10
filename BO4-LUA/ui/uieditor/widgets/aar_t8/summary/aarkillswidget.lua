require("x64:3c71a587b3212e8")
CoD.AARKillsWidget = InheritFrom(LUI.UIElement)
CoD.AARKillsWidget.__defaultWidth = 415
CoD.AARKillsWidget.__defaultHeight = 132
CoD.AARKillsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARKillsWidget)
	self.id = "AARKillsWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 0, 0, 415, 0, 0, 0, 132)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local KillsLabel = LUI.UIText.new(0, 0, 18, 311, 0, 0, 12, 33)
	KillsLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	KillsLabel:setAlpha(0.2)
	KillsLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/kills"))
	KillsLabel:setTTF("dinnext_regular")
	KillsLabel:setLetterSpacing(2)
	KillsLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	KillsLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(KillsLabel)
	self.KillsLabel = KillsLabel
	local KillsGlow = LUI.UIText.new(0, 0, 21, 200, 0, 0, 42, 122)
	KillsGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	KillsGlow:setAlpha(0.4)
	KillsGlow:setTTF("ttmussels_regular")
	KillsGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	KillsGlow:setShaderVector(0, 0.3, 0, 0, 0)
	KillsGlow:setShaderVector(1, 0, 0, 0, 0)
	KillsGlow:setShaderVector(2, 1, 0, 0, 0.8)
	KillsGlow:setLetterSpacing(2)
	KillsGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	KillsGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	KillsGlow:linkToElementModel(self, "kills", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			KillsGlow:setText(f2_local0)
		end
	end)
	self:addElement(KillsGlow)
	self.KillsGlow = KillsGlow
	local Kills = LUI.UIText.new(0, 0, 21, 200, 0, 0, 42, 122)
	Kills:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Kills:setAlpha(0.8)
	Kills:setTTF("ttmussels_regular")
	Kills:setLetterSpacing(2)
	Kills:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Kills:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Kills:linkToElementModel(self, "kills", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Kills:setText(f3_local0)
		end
	end)
	self:addElement(Kills)
	self.Kills = Kills
	local FinishesLabel = LUI.UIText.new(0, 0, 170, 425, 0, 0, 57, 78)
	FinishesLabel:setRGB(0.9, 0.89, 0.78)
	FinishesLabel:setAlpha(0.25)
	FinishesLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_25BBC8944B6945C7"))
	FinishesLabel:setTTF("dinnext_regular")
	FinishesLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FinishesLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(FinishesLabel)
	self.FinishesLabel = FinishesLabel
	local Finishes = LUI.UIText.new(0, 0, 104.5, 164.5, 0, 0, 57, 78)
	Finishes:setRGB(0.9, 0.89, 0.78)
	Finishes:setAlpha(0.25)
	Finishes:setTTF("dinnext_regular")
	Finishes:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Finishes:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Finishes:linkToElementModel(self, "finishes", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Finishes:setText(f4_local0)
		end
	end)
	self:addElement(Finishes)
	self.Finishes = Finishes
	local DistanceKillLabel = LUI.UIText.new(0, 0, 170, 425, 0, 0, 83, 104)
	DistanceKillLabel:setRGB(0.9, 0.89, 0.78)
	DistanceKillLabel:setAlpha(0.25)
	DistanceKillLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_384EAC91CFC17A55"))
	DistanceKillLabel:setTTF("dinnext_regular")
	DistanceKillLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DistanceKillLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(DistanceKillLabel)
	self.DistanceKillLabel = DistanceKillLabel
	local DistanceKill = LUI.UIText.new(0, 0, 30.5, 164.5, 0, 0, 83, 104)
	DistanceKill:setRGB(0.9, 0.89, 0.78)
	DistanceKill:setAlpha(0.25)
	DistanceKill:setTTF("dinnext_regular")
	DistanceKill:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	DistanceKill:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	DistanceKill:linkToElementModel(self, "longestDistanceKill", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DistanceKill:setText(LocalizeStringWithParameter(@"menu/distance_m", UnitsToMeters(f5_local0)))
		end
	end)
	self:addElement(DistanceKill)
	self.DistanceKill = DistanceKill
	self:mergeStateConditions({
		{
			stateName = "Solo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gametype", @"warzone_solo")
			end,
		},
	})
	self:linkToElementModel(self, "gametype", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gametype",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARKillsWidget.__resetProperties = function(f8_arg0)
	f8_arg0.KillsGlow:completeAnimation()
	f8_arg0.DistanceKill:completeAnimation()
	f8_arg0.DistanceKillLabel:completeAnimation()
	f8_arg0.Finishes:completeAnimation()
	f8_arg0.FinishesLabel:completeAnimation()
	f8_arg0.KillsGlow:setAlpha(0.4)
	f8_arg0.DistanceKill:setTopBottom(0, 0, 83, 104)
	f8_arg0.DistanceKillLabel:setTopBottom(0, 0, 83, 104)
	f8_arg0.Finishes:setAlpha(0.25)
	f8_arg0.FinishesLabel:setAlpha(0.25)
end
CoD.AARKillsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(500)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f11_arg0:setAlpha(0.4)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.KillsGlow:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f9_arg0.KillsGlow:setAlpha(0.55)
				f9_arg0.KillsGlow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.KillsGlow:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.KillsGlow:completeAnimation()
			f9_arg0.KillsGlow:setAlpha(0.4)
			f9_local0(f9_arg0.KillsGlow)
			f9_arg0.nextClip = "DefaultClip"
		end,
	},
	Solo = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.FinishesLabel:completeAnimation()
			f13_arg0.FinishesLabel:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FinishesLabel)
			f13_arg0.Finishes:completeAnimation()
			f13_arg0.Finishes:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Finishes)
			f13_arg0.DistanceKillLabel:completeAnimation()
			f13_arg0.DistanceKillLabel:setTopBottom(0, 0, 62, 83)
			f13_arg0.clipFinished(f13_arg0.DistanceKillLabel)
			f13_arg0.DistanceKill:completeAnimation()
			f13_arg0.DistanceKill:setTopBottom(0, 0, 62, 83)
			f13_arg0.clipFinished(f13_arg0.DistanceKill)
		end,
	},
}
CoD.AARKillsWidget.__onClose = function(f14_arg0)
	f14_arg0.PerformBg:close()
	f14_arg0.KillsGlow:close()
	f14_arg0.Kills:close()
	f14_arg0.Finishes:close()
	f14_arg0.DistanceKill:close()
end
