require("x64:3c71a587b3212e8")
require("x64:e0a647a9aa431ab")
CoD.AAREnemiesKIAWidget = InheritFrom(LUI.UIElement)
CoD.AAREnemiesKIAWidget.__defaultWidth = 340
CoD.AAREnemiesKIAWidget.__defaultHeight = 132
CoD.AAREnemiesKIAWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AAREnemiesKIAWidget)
	self.id = "AAREnemiesKIAWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 0, -7, 347, 0, 0, 0, 140)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local Title = LUI.UIText.new(0, 0, 18, 426, 0, 0, 12, 33)
	Title:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Title:setAlpha(0.2)
	Title:setText(Engine[0xF9F1239CFD921FE](0x69DB6D07C46E748))
	Title:setTTF("dinnext_regular")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local TimeGlow = LUI.UIText.new(0, 0, 18, 197, 0, 0, 42, 122)
	TimeGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	TimeGlow:setAlpha(0)
	TimeGlow:setTTF("ttmussels_regular")
	TimeGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	TimeGlow:setShaderVector(0, 0.3, 0, 0, 0)
	TimeGlow:setShaderVector(1, 0, 0, 0, 0)
	TimeGlow:setShaderVector(2, 1, 0, 0, 0.8)
	TimeGlow:setLetterSpacing(2)
	TimeGlow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimeGlow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TimeGlow:linkToElementModel(self, "objectiveTime", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TimeGlow:setText(f2_local0)
		end
	end)
	self:addElement(TimeGlow)
	self.TimeGlow = TimeGlow
	local Time = LUI.UIText.new(0, 0, 18, 197, 0, 0, 42, 122)
	Time:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Time:setAlpha(0)
	Time:setTTF("ttmussels_regular")
	Time:setLetterSpacing(2)
	Time:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Time:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Time:linkToElementModel(self, "objectiveTime", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Time:setText(f3_local0)
		end
	end)
	self:addElement(Time)
	self.Time = Time
	local KillsGlow = LUI.UIText.new(0, 0, 18, 197, 0, 0, 42, 122)
	KillsGlow:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	KillsGlow:setAlpha(0.4)
	KillsGlow:setTTF("ttmussels_regular")
	KillsGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	KillsGlow:setShaderVector(0, 0.3, 0, 0, 0)
	KillsGlow:setShaderVector(1, 0, 0, 0, 0)
	KillsGlow:setShaderVector(2, 1, 0, 0, 0.8)
	KillsGlow:setLetterSpacing(2)
	KillsGlow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	KillsGlow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	KillsGlow:linkToElementModel(self, "kills", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			KillsGlow:setText(f4_local0)
		end
	end)
	self:addElement(KillsGlow)
	self.KillsGlow = KillsGlow
	local Kills = LUI.UIText.new(0, 0, 18, 197, 0, 0, 42, 122)
	Kills:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Kills:setAlpha(0.8)
	Kills:setTTF("ttmussels_regular")
	Kills:setLetterSpacing(2)
	Kills:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Kills:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Kills:linkToElementModel(self, "kills", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Kills:setText(f5_local0)
		end
	end)
	self:addElement(Kills)
	self.Kills = Kills
	local StatRatio = CoD.AARStatLine.new(f1_arg0, f1_arg1, 0, 0, 140, 383, 0, 0, 55.5, 76.5)
	StatRatio:linkToElementModel(self, nil, false, function(model)
		StatRatio:setModel(model, f1_arg1)
	end)
	StatRatio:linkToElementModel(self, "kdRatio", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StatRatio.KDRatio:setText(f7_local0)
		end
	end)
	self:addElement(StatRatio)
	self.StatRatio = StatRatio
	local StatDeath = CoD.AARStatLine.new(f1_arg0, f1_arg1, 0, 0, 140, 383, 0, 0, 83, 104)
	StatDeath.RatioLabel:setText(Engine[0xF9F1239CFD921FE](0xAC9A72BC7A21122))
	StatDeath:linkToElementModel(self, nil, false, function(model)
		StatDeath:setModel(model, f1_arg1)
	end)
	StatDeath:linkToElementModel(self, "deaths", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			StatDeath.KDRatio:setText(f9_local0)
		end
	end)
	self:addElement(StatDeath)
	self.StatDeath = StatDeath
	self:mergeStateConditions({
		{
			stateName = "PropHunt",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("prop", f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AAREnemiesKIAWidget.__resetProperties = function(f11_arg0)
	f11_arg0.KillsGlow:completeAnimation()
	f11_arg0.StatDeath:completeAnimation()
	f11_arg0.StatRatio:completeAnimation()
	f11_arg0.Title:completeAnimation()
	f11_arg0.Time:completeAnimation()
	f11_arg0.TimeGlow:completeAnimation()
	f11_arg0.Kills:completeAnimation()
	f11_arg0.KillsGlow:setAlpha(0.4)
	f11_arg0.StatDeath:setAlpha(1)
	f11_arg0.StatRatio:setAlpha(1)
	f11_arg0.Title:setText(Engine[0xF9F1239CFD921FE](0x69DB6D07C46E748))
	f11_arg0.Time:setAlpha(0)
	f11_arg0.TimeGlow:setAlpha(0)
	f11_arg0.Kills:setAlpha(0.8)
end
CoD.AAREnemiesKIAWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(500)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f14_arg0:setAlpha(0.4)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f12_arg0.KillsGlow:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f12_arg0.KillsGlow:setAlpha(0.55)
				f12_arg0.KillsGlow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.KillsGlow:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.KillsGlow:completeAnimation()
			f12_arg0.KillsGlow:setAlpha(0.4)
			f12_local0(f12_arg0.KillsGlow)
		end,
	},
	PropHunt = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(7)
			f16_arg0.Title:completeAnimation()
			f16_arg0.Title:setText(Engine[0xF9F1239CFD921FE](0xAD795C41AE2FC56))
			f16_arg0.clipFinished(f16_arg0.Title)
			f16_arg0.TimeGlow:completeAnimation()
			f16_arg0.TimeGlow:setAlpha(0.4)
			f16_arg0.clipFinished(f16_arg0.TimeGlow)
			f16_arg0.Time:completeAnimation()
			f16_arg0.Time:setAlpha(0.8)
			f16_arg0.clipFinished(f16_arg0.Time)
			f16_arg0.KillsGlow:completeAnimation()
			f16_arg0.KillsGlow:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.KillsGlow)
			f16_arg0.Kills:completeAnimation()
			f16_arg0.Kills:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Kills)
			f16_arg0.StatRatio:completeAnimation()
			f16_arg0.StatRatio:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.StatRatio)
			f16_arg0.StatDeath:completeAnimation()
			f16_arg0.StatDeath:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.StatDeath)
		end,
	},
}
CoD.AAREnemiesKIAWidget.__onClose = function(f17_arg0)
	f17_arg0.PerformBg:close()
	f17_arg0.TimeGlow:close()
	f17_arg0.Time:close()
	f17_arg0.KillsGlow:close()
	f17_arg0.Kills:close()
	f17_arg0.StatRatio:close()
	f17_arg0.StatDeath:close()
end
