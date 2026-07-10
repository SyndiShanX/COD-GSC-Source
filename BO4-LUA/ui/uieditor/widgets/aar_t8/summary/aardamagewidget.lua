require("x64:3c71a587b3212e8")
require("x64:8330b7987fe0d45")
CoD.AARDamageWidget = InheritFrom(LUI.UIElement)
CoD.AARDamageWidget.__defaultWidth = 340
CoD.AARDamageWidget.__defaultHeight = 132
CoD.AARDamageWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARDamageWidget)
	self.id = "AARDamageWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 0, -7, 347, 0, 0, 0, 140)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local DamageGlow = LUI.UIText.new(0, 0, 21, 200, 0, 0, 42, 122)
	DamageGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	DamageGlow:setAlpha(0.4)
	DamageGlow:setTTF("ttmussels_regular")
	DamageGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	DamageGlow:setShaderVector(0, 0.3, 0, 0, 0)
	DamageGlow:setShaderVector(1, 0, 0, 0, 0)
	DamageGlow:setShaderVector(2, 1, 0, 0, 0.8)
	DamageGlow:setLetterSpacing(2)
	DamageGlow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DamageGlow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	DamageGlow:linkToElementModel(self, "damage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DamageGlow:setText(f2_local0)
		end
	end)
	self:addElement(DamageGlow)
	self.DamageGlow = DamageGlow
	local DamageLabel = LUI.UIText.new(0, 0, 18, 311, 0, 0, 12, 33)
	DamageLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	DamageLabel:setAlpha(0.2)
	DamageLabel:setText(Engine[0xF9F1239CFD921FE](0xC4B84A4968AAC62))
	DamageLabel:setTTF("dinnext_regular")
	DamageLabel:setLetterSpacing(2)
	DamageLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DamageLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DamageLabel)
	self.DamageLabel = DamageLabel
	local Damage = LUI.UIText.new(0, 0, 21, 200, 0, 0, 42, 122)
	Damage:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Damage:setAlpha(0.8)
	Damage:setTTF("ttmussels_regular")
	Damage:setLetterSpacing(2)
	Damage:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Damage:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Damage:linkToElementModel(self, "damage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Damage:setText(f3_local0)
		end
	end)
	self:addElement(Damage)
	self.Damage = Damage
	local ObjectiveScoreLargeGlow = LUI.UIText.new(0, 0, 18, 197, 0, 0, 42, 122)
	ObjectiveScoreLargeGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ObjectiveScoreLargeGlow:setAlpha(0)
	ObjectiveScoreLargeGlow:setTTF("ttmussels_regular")
	ObjectiveScoreLargeGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ObjectiveScoreLargeGlow:setShaderVector(0, 0.3, 0, 0, 0)
	ObjectiveScoreLargeGlow:setShaderVector(1, 0, 0, 0, 0)
	ObjectiveScoreLargeGlow:setShaderVector(2, 1, 0, 0, 0.8)
	ObjectiveScoreLargeGlow:setLetterSpacing(2)
	ObjectiveScoreLargeGlow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ObjectiveScoreLargeGlow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ObjectiveScoreLargeGlow:linkToElementModel(self, "objectiveScore", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ObjectiveScoreLargeGlow:setText(f4_local0)
		end
	end)
	self:addElement(ObjectiveScoreLargeGlow)
	self.ObjectiveScoreLargeGlow = ObjectiveScoreLargeGlow
	local ObjectiveScoreLarge = LUI.UIText.new(0, 0, 18, 197, 0, 0, 42, 122)
	ObjectiveScoreLarge:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ObjectiveScoreLarge:setAlpha(0)
	ObjectiveScoreLarge:setTTF("ttmussels_regular")
	ObjectiveScoreLarge:setLetterSpacing(2)
	ObjectiveScoreLarge:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ObjectiveScoreLarge:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ObjectiveScoreLarge:linkToElementModel(self, "objectiveScore", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ObjectiveScoreLarge:setText(f5_local0)
		end
	end)
	self:addElement(ObjectiveScoreLarge)
	self.ObjectiveScoreLarge = ObjectiveScoreLarge
	local ObjectiveTotalGlow = LUI.UIText.new(0, 0, 18, 197, 0, 0, 42, 122)
	ObjectiveTotalGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ObjectiveTotalGlow:setAlpha(0)
	ObjectiveTotalGlow:setTTF("ttmussels_regular")
	ObjectiveTotalGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ObjectiveTotalGlow:setShaderVector(0, 0.3, 0, 0, 0)
	ObjectiveTotalGlow:setShaderVector(1, 0, 0, 0, 0)
	ObjectiveTotalGlow:setShaderVector(2, 1, 0, 0, 0.8)
	ObjectiveTotalGlow:setLetterSpacing(2)
	ObjectiveTotalGlow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ObjectiveTotalGlow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ObjectiveTotalGlow:linkToElementModel(self, "objectiveTotal", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ObjectiveTotalGlow:setText(f6_local0)
		end
	end)
	self:addElement(ObjectiveTotalGlow)
	self.ObjectiveTotalGlow = ObjectiveTotalGlow
	local ObjectiveTotal = LUI.UIText.new(0, 0, 18, 197, 0, 0, 42, 122)
	ObjectiveTotal:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ObjectiveTotal:setAlpha(0)
	ObjectiveTotal:setTTF("ttmussels_regular")
	ObjectiveTotal:setLetterSpacing(2)
	ObjectiveTotal:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ObjectiveTotal:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ObjectiveTotal:linkToElementModel(self, "objectiveTotal", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ObjectiveTotal:setText(f7_local0)
		end
	end)
	self:addElement(ObjectiveTotal)
	self.ObjectiveTotal = ObjectiveTotal
	local EscortDeliveries = LUI.UIText.new(0, 0, 122, 300, 0, 0, 59.5, 80.5)
	EscortDeliveries:setRGB(0.9, 0.89, 0.78)
	EscortDeliveries:setAlpha(0)
	EscortDeliveries:setTTF("dinnext_regular")
	EscortDeliveries:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EscortDeliveries:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	EscortDeliveries:linkToElementModel(self, "escortDeliveries", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			EscortDeliveries:setText(LocalizeStringWithParameter(0x7AEA6CA48B89901, f8_local0))
		end
	end)
	self:addElement(EscortDeliveries)
	self.EscortDeliveries = EscortDeliveries
	local CleanDeposits = LUI.UIText.new(0, 0, 122, 300, 0, 0, 36, 57)
	CleanDeposits:setRGB(0.9, 0.89, 0.78)
	CleanDeposits:setAlpha(0)
	CleanDeposits:setTTF("dinnext_regular")
	CleanDeposits:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CleanDeposits:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CleanDeposits:linkToElementModel(self, "cleanDeposits", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CleanDeposits:setText(LocalizeStringWithParameter(0x7946EF6C8E2AAFF, f9_local0))
		end
	end)
	self:addElement(CleanDeposits)
	self.CleanDeposits = CleanDeposits
	local EscortDisables = LUI.UIText.new(0, 0, 122, 300, 0, 0, 36, 57)
	EscortDisables:setRGB(0.9, 0.89, 0.78)
	EscortDisables:setAlpha(0)
	EscortDisables:setTTF("dinnext_regular")
	EscortDisables:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EscortDisables:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	EscortDisables:linkToElementModel(self, "escortDisables", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			EscortDisables:setText(LocalizeStringWithParameter(0xD310F5466D82F18, f10_local0))
		end
	end)
	self:addElement(EscortDisables)
	self.EscortDisables = EscortDisables
	local CleanDenies = LUI.UIText.new(0, 0, 122, 300, 0, 0, 59.5, 80.5)
	CleanDenies:setRGB(0.9, 0.89, 0.78)
	CleanDenies:setAlpha(0)
	CleanDenies:setTTF("dinnext_regular")
	CleanDenies:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CleanDenies:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CleanDenies:linkToElementModel(self, "cleanDenies", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CleanDenies:setText(LocalizeStringWithParameter(0x13FB98504BD012, f11_local0))
		end
	end)
	self:addElement(CleanDenies)
	self.CleanDenies = CleanDenies
	local ObjectiveScore = CoD.AARSubStat.new(f1_arg0, f1_arg1, 0, 0, 125.5, 525.5, 0, 0, 55, 79)
	ObjectiveScore:setAlpha(0)
	ObjectiveScore:linkToElementModel(self, "objectiveScore", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ObjectiveScore.Score:setText(f12_local0)
		end
	end)
	self:addElement(ObjectiveScore)
	self.ObjectiveScore = ObjectiveScore
	local ObjectiveEKIA = CoD.AARSubStat.new(f1_arg0, f1_arg1, 0, 0, 125.5, 525.5, 0, 0, 83, 104)
	ObjectiveEKIA:setAlpha(0)
	ObjectiveEKIA.ScoreLabel:setText(Engine[0xF9F1239CFD921FE](0x1C51D749B365E54))
	ObjectiveEKIA:linkToElementModel(self, "objectiveEkia", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			ObjectiveEKIA.Score:setText(f13_local0)
		end
	end)
	self:addElement(ObjectiveEKIA)
	self.ObjectiveEKIA = ObjectiveEKIA
	local ObjectiveCaptures = CoD.AARSubStat.new(f1_arg0, f1_arg1, 0, 0, 125.5, 525.5, 0, 0, 55, 76)
	ObjectiveCaptures:setAlpha(0)
	ObjectiveCaptures:linkToElementModel(self, "ctfCaptures", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			ObjectiveCaptures.Score:setText(f14_local0)
		end
	end)
	self:addElement(ObjectiveCaptures)
	self.ObjectiveCaptures = ObjectiveCaptures
	local ObjectiveReturns = CoD.AARSubStat.new(f1_arg0, f1_arg1, 0, 0, 125.5, 525.5, 0, 0, 83, 104)
	ObjectiveReturns:setAlpha(0)
	ObjectiveReturns.ScoreLabel:setText(Engine[0xF9F1239CFD921FE](0x813EDE9EBB8843E))
	ObjectiveReturns:linkToElementModel(self, "ctfReturns", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			ObjectiveReturns.Score:setText(f15_local0)
		end
	end)
	self:addElement(ObjectiveReturns)
	self.ObjectiveReturns = ObjectiveReturns
	self:mergeStateConditions({
		{
			stateName = "Escort",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("escort", f1_arg1)
			end,
		},
		{
			stateName = "Clean",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("clean", f1_arg1)
			end,
		},
		{
			stateName = "PropHunt",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("prop", f1_arg1)
			end,
		},
		{
			stateName = "Ctf",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("ctf", f1_arg1)
			end,
		},
		{
			stateName = "Objective",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGametypeObjectiveType(f1_arg1)
			end,
		},
	})
	local f1_local17 = self
	local f1_local18 = self.subscribeToModel
	local f1_local19 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local18(f1_local17, f1_local19["AAR.gametype"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "AAR.gametype",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARDamageWidget.__resetProperties = function(f22_arg0)
	f22_arg0.DamageGlow:completeAnimation()
	f22_arg0.ObjectiveTotal:completeAnimation()
	f22_arg0.ObjectiveTotalGlow:completeAnimation()
	f22_arg0.Damage:completeAnimation()
	f22_arg0.DamageLabel:completeAnimation()
	f22_arg0.EscortDeliveries:completeAnimation()
	f22_arg0.EscortDisables:completeAnimation()
	f22_arg0.CleanDeposits:completeAnimation()
	f22_arg0.CleanDenies:completeAnimation()
	f22_arg0.ObjectiveScoreLarge:completeAnimation()
	f22_arg0.ObjectiveScoreLargeGlow:completeAnimation()
	f22_arg0.ObjectiveCaptures:completeAnimation()
	f22_arg0.ObjectiveReturns:completeAnimation()
	f22_arg0.ObjectiveScore:completeAnimation()
	f22_arg0.ObjectiveEKIA:completeAnimation()
	f22_arg0.DamageGlow:setAlpha(0.4)
	f22_arg0.ObjectiveTotal:setAlpha(0)
	f22_arg0.ObjectiveTotalGlow:setAlpha(0)
	f22_arg0.Damage:setAlpha(0.8)
	f22_arg0.DamageLabel:setText(Engine[0xF9F1239CFD921FE](0xC4B84A4968AAC62))
	f22_arg0.EscortDeliveries:setTopBottom(0, 0, 59.5, 80.5)
	f22_arg0.EscortDeliveries:setAlpha(0)
	f22_arg0.EscortDisables:setTopBottom(0, 0, 36, 57)
	f22_arg0.EscortDisables:setAlpha(0)
	f22_arg0.CleanDeposits:setTopBottom(0, 0, 36, 57)
	f22_arg0.CleanDeposits:setAlpha(0)
	f22_arg0.CleanDenies:setTopBottom(0, 0, 59.5, 80.5)
	f22_arg0.CleanDenies:setAlpha(0)
	f22_arg0.ObjectiveScoreLarge:setAlpha(0)
	f22_arg0.ObjectiveScoreLargeGlow:setAlpha(0)
	f22_arg0.ObjectiveCaptures:setAlpha(0)
	f22_arg0.ObjectiveReturns:setAlpha(0)
	f22_arg0.ObjectiveScore:setAlpha(0)
	f22_arg0.ObjectiveEKIA:setAlpha(0)
end
CoD.AARDamageWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						f26_arg0:beginAnimation(500)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
					end
					f25_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f25_arg0:setAlpha(0.4)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f23_arg0.DamageGlow:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f23_arg0.DamageGlow:setAlpha(0.55)
				f23_arg0.DamageGlow:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.DamageGlow:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f23_arg0.DamageGlow:completeAnimation()
			f23_arg0.DamageGlow:setAlpha(0.4)
			f23_local0(f23_arg0.DamageGlow)
			f23_arg0.nextClip = "DefaultClip"
		end,
	},
	Escort = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(7)
			f27_arg0.DamageGlow:completeAnimation()
			f27_arg0.DamageGlow:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DamageGlow)
			f27_arg0.DamageLabel:completeAnimation()
			f27_arg0.DamageLabel:setText(Engine[0xF9F1239CFD921FE](0x2832FDB48FB8003))
			f27_arg0.clipFinished(f27_arg0.DamageLabel)
			f27_arg0.Damage:completeAnimation()
			f27_arg0.Damage:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Damage)
			local f27_local0 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					local f29_local0 = function(f30_arg0)
						f30_arg0:beginAnimation(500)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
					end
					f29_arg0:beginAnimation(1000)
					f29_arg0:setAlpha(0.4)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f27_arg0.ObjectiveTotalGlow:beginAnimation(1000)
				f27_arg0.ObjectiveTotalGlow:setAlpha(0.55)
				f27_arg0.ObjectiveTotalGlow:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.ObjectiveTotalGlow:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f27_arg0.ObjectiveTotalGlow:completeAnimation()
			f27_arg0.ObjectiveTotalGlow:setAlpha(0.4)
			f27_local0(f27_arg0.ObjectiveTotalGlow)
			f27_arg0.ObjectiveTotal:completeAnimation()
			f27_arg0.ObjectiveTotal:setAlpha(0.8)
			f27_arg0.clipFinished(f27_arg0.ObjectiveTotal)
			f27_arg0.EscortDeliveries:completeAnimation()
			f27_arg0.EscortDeliveries:setTopBottom(0, 0, 64.5, 85.5)
			f27_arg0.EscortDeliveries:setAlpha(0.25)
			f27_arg0.clipFinished(f27_arg0.EscortDeliveries)
			f27_arg0.EscortDisables:completeAnimation()
			f27_arg0.EscortDisables:setTopBottom(0, 0, 41, 62)
			f27_arg0.EscortDisables:setAlpha(0.25)
			f27_arg0.clipFinished(f27_arg0.EscortDisables)
		end,
	},
	Clean = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(9)
			f31_arg0.DamageGlow:completeAnimation()
			f31_arg0.DamageGlow:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.DamageGlow)
			f31_arg0.DamageLabel:completeAnimation()
			f31_arg0.DamageLabel:setText(Engine[0xF9F1239CFD921FE](0x2832FDB48FB8003))
			f31_arg0.clipFinished(f31_arg0.DamageLabel)
			f31_arg0.Damage:completeAnimation()
			f31_arg0.Damage:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Damage)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						f34_arg0:beginAnimation(500)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
					end
					f33_arg0:beginAnimation(1000)
					f33_arg0:setAlpha(0.4)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f31_arg0.ObjectiveTotalGlow:beginAnimation(1000)
				f31_arg0.ObjectiveTotalGlow:setAlpha(0.55)
				f31_arg0.ObjectiveTotalGlow:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ObjectiveTotalGlow:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.ObjectiveTotalGlow:completeAnimation()
			f31_arg0.ObjectiveTotalGlow:setAlpha(0.4)
			f31_local0(f31_arg0.ObjectiveTotalGlow)
			f31_arg0.ObjectiveTotal:completeAnimation()
			f31_arg0.ObjectiveTotal:setAlpha(0.8)
			f31_arg0.clipFinished(f31_arg0.ObjectiveTotal)
			f31_arg0.EscortDeliveries:completeAnimation()
			f31_arg0.EscortDeliveries:setTopBottom(0, 0, 79, 100)
			f31_arg0.EscortDeliveries:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EscortDeliveries)
			f31_arg0.CleanDeposits:completeAnimation()
			f31_arg0.CleanDeposits:setTopBottom(0, 0, 59.5, 80.5)
			f31_arg0.CleanDeposits:setAlpha(0.25)
			f31_arg0.clipFinished(f31_arg0.CleanDeposits)
			f31_arg0.EscortDisables:completeAnimation()
			f31_arg0.EscortDisables:setTopBottom(0, 0, 75, 96)
			f31_arg0.EscortDisables:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EscortDisables)
			f31_arg0.CleanDenies:completeAnimation()
			f31_arg0.CleanDenies:setTopBottom(0, 0, 83, 104)
			f31_arg0.CleanDenies:setAlpha(0.25)
			f31_arg0.clipFinished(f31_arg0.CleanDenies)
		end,
	},
	PropHunt = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(5)
			f35_arg0.DamageGlow:completeAnimation()
			f35_arg0.DamageGlow:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.DamageGlow)
			f35_arg0.DamageLabel:completeAnimation()
			f35_arg0.DamageLabel:setText(Engine[0xF9F1239CFD921FE](0x2832FDB48FB8003))
			f35_arg0.clipFinished(f35_arg0.DamageLabel)
			f35_arg0.Damage:completeAnimation()
			f35_arg0.Damage:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.Damage)
			f35_arg0.ObjectiveScoreLargeGlow:completeAnimation()
			f35_arg0.ObjectiveScoreLargeGlow:setAlpha(0.4)
			f35_arg0.clipFinished(f35_arg0.ObjectiveScoreLargeGlow)
			f35_arg0.ObjectiveScoreLarge:completeAnimation()
			f35_arg0.ObjectiveScoreLarge:setAlpha(0.8)
			f35_arg0.clipFinished(f35_arg0.ObjectiveScoreLarge)
		end,
	},
	Ctf = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(9)
			f36_arg0.DamageGlow:completeAnimation()
			f36_arg0.DamageGlow:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.DamageGlow)
			f36_arg0.DamageLabel:completeAnimation()
			f36_arg0.DamageLabel:setText(Engine[0xF9F1239CFD921FE](0x2832FDB48FB8003))
			f36_arg0.clipFinished(f36_arg0.DamageLabel)
			f36_arg0.Damage:completeAnimation()
			f36_arg0.Damage:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Damage)
			f36_arg0.ObjectiveScoreLargeGlow:completeAnimation()
			f36_arg0.ObjectiveScoreLargeGlow:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ObjectiveScoreLargeGlow)
			f36_arg0.ObjectiveScoreLarge:completeAnimation()
			f36_arg0.ObjectiveScoreLarge:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ObjectiveScoreLarge)
			f36_arg0.ObjectiveTotalGlow:completeAnimation()
			f36_arg0.ObjectiveTotalGlow:setAlpha(0.4)
			f36_arg0.clipFinished(f36_arg0.ObjectiveTotalGlow)
			f36_arg0.ObjectiveTotal:completeAnimation()
			f36_arg0.ObjectiveTotal:setAlpha(0.8)
			f36_arg0.clipFinished(f36_arg0.ObjectiveTotal)
			f36_arg0.ObjectiveCaptures:completeAnimation()
			f36_arg0.ObjectiveCaptures:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.ObjectiveCaptures)
			f36_arg0.ObjectiveReturns:completeAnimation()
			f36_arg0.ObjectiveReturns:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.ObjectiveReturns)
		end,
	},
	Objective = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(7)
			f37_arg0.DamageGlow:completeAnimation()
			f37_arg0.DamageGlow:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.DamageGlow)
			f37_arg0.DamageLabel:completeAnimation()
			f37_arg0.DamageLabel:setText(Engine[0xF9F1239CFD921FE](0x2832FDB48FB8003))
			f37_arg0.clipFinished(f37_arg0.DamageLabel)
			f37_arg0.Damage:completeAnimation()
			f37_arg0.Damage:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.Damage)
			local f37_local0 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						f40_arg0:beginAnimation(500)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
					end
					f39_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f39_arg0:setAlpha(0.4)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f37_arg0.ObjectiveTotalGlow:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f37_arg0.ObjectiveTotalGlow:setAlpha(0.55)
				f37_arg0.ObjectiveTotalGlow:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.ObjectiveTotalGlow:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f37_arg0.ObjectiveTotalGlow:completeAnimation()
			f37_arg0.ObjectiveTotalGlow:setAlpha(0.4)
			f37_local0(f37_arg0.ObjectiveTotalGlow)
			f37_arg0.ObjectiveTotal:completeAnimation()
			f37_arg0.ObjectiveTotal:setAlpha(0.8)
			f37_arg0.clipFinished(f37_arg0.ObjectiveTotal)
			f37_arg0.ObjectiveScore:completeAnimation()
			f37_arg0.ObjectiveScore:setAlpha(0.25)
			f37_arg0.clipFinished(f37_arg0.ObjectiveScore)
			f37_arg0.ObjectiveEKIA:completeAnimation()
			f37_arg0.ObjectiveEKIA:setAlpha(0.25)
			f37_arg0.clipFinished(f37_arg0.ObjectiveEKIA)
		end,
	},
}
CoD.AARDamageWidget.__onClose = function(f41_arg0)
	f41_arg0.PerformBg:close()
	f41_arg0.DamageGlow:close()
	f41_arg0.Damage:close()
	f41_arg0.ObjectiveScoreLargeGlow:close()
	f41_arg0.ObjectiveScoreLarge:close()
	f41_arg0.ObjectiveTotalGlow:close()
	f41_arg0.ObjectiveTotal:close()
	f41_arg0.EscortDeliveries:close()
	f41_arg0.CleanDeposits:close()
	f41_arg0.EscortDisables:close()
	f41_arg0.CleanDenies:close()
	f41_arg0.ObjectiveScore:close()
	f41_arg0.ObjectiveEKIA:close()
	f41_arg0.ObjectiveCaptures:close()
	f41_arg0.ObjectiveReturns:close()
end
