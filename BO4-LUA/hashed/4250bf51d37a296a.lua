CoD.ButtonFrame_ArenaMedals = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_ArenaMedals.__defaultWidth = 469
CoD.ButtonFrame_ArenaMedals.__defaultHeight = 264
CoD.ButtonFrame_ArenaMedals.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_ArenaMedals)
	self.id = "ButtonFrame_ArenaMedals"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KillStreakTitle = LUI.UIText.new(0, 0, 18, 226, 0, 0, 47.5, 65.5)
	KillStreakTitle:setAlpha(0.25)
	KillStreakTitle:setText(LocalizeToUpperString(0x1DCC7AB8B8F861))
	KillStreakTitle:setTTF("ttmussels_regular")
	KillStreakTitle:setLetterSpacing(1)
	KillStreakTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KillStreakTitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(KillStreakTitle)
	self.KillStreakTitle = KillStreakTitle
	local MultiKillTitle = LUI.UIText.new(0, 0, 242, 450, 0, 0, 47.5, 65.5)
	MultiKillTitle:setAlpha(0.25)
	MultiKillTitle:setText(LocalizeToUpperString(0xD7F732D451CACD8))
	MultiKillTitle:setTTF("ttmussels_regular")
	MultiKillTitle:setLetterSpacing(1)
	MultiKillTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MultiKillTitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(MultiKillTitle)
	self.MultiKillTitle = MultiKillTitle
	local MultiKillMedalName = LUI.UIText.new(0, 0, 38.5, 186.5, 0, 0, 178.5, 199.5)
	MultiKillMedalName:setAlpha(0.5)
	MultiKillMedalName:setTTF("ttmussels_demibold")
	MultiKillMedalName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MultiKillMedalName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MultiKillMedalName:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "MultiKillMedal.name", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MultiKillMedalName:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(MultiKillMedalName)
	self.MultiKillMedalName = MultiKillMedalName
	local MultiKillMedalTimesEarned = LUI.UIText.new(0, 0, 38.5, 186.5, 0, 0, 199.5, 244.5)
	MultiKillMedalTimesEarned:setRGB(0.69, 0.56, 0.04)
	MultiKillMedalTimesEarned:setTTF("ttmussels_demibold")
	MultiKillMedalTimesEarned:setLetterSpacing(2)
	MultiKillMedalTimesEarned:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MultiKillMedalTimesEarned:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "MultiKillMedal.timesEarned", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MultiKillMedalTimesEarned:setText(f3_local0)
		end
	end)
	self:addElement(MultiKillMedalTimesEarned)
	self.MultiKillMedalTimesEarned = MultiKillMedalTimesEarned
	local KillStreakMedalImage = LUI.UIImage.new(0, 0, 62.5, 162.5, 0, 0, 72.5, 172.5)
	KillStreakMedalImage:setupUIStreamedImage(0)
	KillStreakMedalImage:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "KillStreakMedal.iconSmall", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			KillStreakMedalImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(KillStreakMedalImage)
	self.KillStreakMedalImage = KillStreakMedalImage
	local MultiKillMedalImage = LUI.UIImage.new(0, 0, 295, 395, 0, 0, 72.5, 172.5)
	MultiKillMedalImage:setupUIStreamedImage(0)
	MultiKillMedalImage:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "MultiKillMedal.iconSmall", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MultiKillMedalImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(MultiKillMedalImage)
	self.MultiKillMedalImage = MultiKillMedalImage
	local KillStreakMedalName = LUI.UIText.new(0, 0, 268, 416, 0, 0, 178.5, 199.5)
	KillStreakMedalName:setAlpha(0.5)
	KillStreakMedalName:setTTF("ttmussels_demibold")
	KillStreakMedalName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KillStreakMedalName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	KillStreakMedalName:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "KillStreakMedal.name", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			KillStreakMedalName:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self:addElement(KillStreakMedalName)
	self.KillStreakMedalName = KillStreakMedalName
	local KillStreakMedalTimesEarned = LUI.UIText.new(0, 0, 269, 417, 0, 0, 199.5, 244.5)
	KillStreakMedalTimesEarned:setRGB(0.69, 0.56, 0.04)
	KillStreakMedalTimesEarned:setTTF("ttmussels_demibold")
	KillStreakMedalTimesEarned:setLetterSpacing(2)
	KillStreakMedalTimesEarned:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KillStreakMedalTimesEarned:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "KillStreakMedal.timesEarned", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			KillStreakMedalTimesEarned:setText(f7_local0)
		end
	end)
	self:addElement(KillStreakMedalTimesEarned)
	self.KillStreakMedalTimesEarned = KillStreakMedalTimesEarned
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_ArenaMedals.__resetProperties = function(f9_arg0)
	f9_arg0.KillStreakTitle:completeAnimation()
	f9_arg0.MultiKillTitle:completeAnimation()
	f9_arg0.KillStreakTitle:setTopBottom(0, 0, 47.5, 65.5)
	f9_arg0.MultiKillTitle:setTopBottom(0, 0, 47.5, 65.5)
end
CoD.ButtonFrame_ArenaMedals.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.KillStreakTitle:completeAnimation()
			f11_arg0.KillStreakTitle:setTopBottom(0, 0, 48, 60)
			f11_arg0.clipFinished(f11_arg0.KillStreakTitle)
			f11_arg0.MultiKillTitle:completeAnimation()
			f11_arg0.MultiKillTitle:setTopBottom(0, 0, 48, 60)
			f11_arg0.clipFinished(f11_arg0.MultiKillTitle)
		end,
	},
}
CoD.ButtonFrame_ArenaMedals.__onClose = function(f12_arg0)
	f12_arg0.MultiKillMedalName:close()
	f12_arg0.MultiKillMedalTimesEarned:close()
	f12_arg0.KillStreakMedalImage:close()
	f12_arg0.MultiKillMedalImage:close()
	f12_arg0.KillStreakMedalName:close()
	f12_arg0.KillStreakMedalTimesEarned:close()
end
