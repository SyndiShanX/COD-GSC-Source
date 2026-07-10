CoD.ButtonFrame_Medal = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_Medal.__defaultWidth = 469
CoD.ButtonFrame_Medal.__defaultHeight = 675
CoD.ButtonFrame_Medal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_Medal)
	self.id = "ButtonFrame_Medal"
	self.soundSet = "none"
	local FeaturedMedalImage = LUI.UIImage.new(0.5, 0.5, -125, 125, 0, 0, 29, 279)
	FeaturedMedalImage:setupUIStreamedImage(0)
	FeaturedMedalImage:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "FeaturedMedal.iconSmall", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FeaturedMedalImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FeaturedMedalImage)
	self.FeaturedMedalImage = FeaturedMedalImage
	local FeaturedMedalName = LUI.UIText.new(0.5, 0.5, -200, 200, 0, 0, 279, 300)
	FeaturedMedalName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FeaturedMedalName:setAlpha(0.5)
	FeaturedMedalName:setTTF("ttmussels_regular")
	FeaturedMedalName:setLetterSpacing(2)
	FeaturedMedalName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FeaturedMedalName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	FeaturedMedalName:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "FeaturedMedal.name", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FeaturedMedalName:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(FeaturedMedalName)
	self.FeaturedMedalName = FeaturedMedalName
	local FeaturedMedalTimesEarned = LUI.UIText.new(0.5, 0.5, -200, 200, 0, 0, 301, 346)
	FeaturedMedalTimesEarned:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	FeaturedMedalTimesEarned:setTTF("ttmussels_demibold")
	FeaturedMedalTimesEarned:setLetterSpacing(3)
	FeaturedMedalTimesEarned:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FeaturedMedalTimesEarned:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "FeaturedMedal.timesEarned", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			FeaturedMedalTimesEarned:setText(f4_local0)
		end
	end)
	self:addElement(FeaturedMedalTimesEarned)
	self.FeaturedMedalTimesEarned = FeaturedMedalTimesEarned
	local MultiKillTitle = LUI.UIText.new(1, 1, -215, -15, 1, 1, -292, -274)
	MultiKillTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MultiKillTitle:setAlpha(0.5)
	MultiKillTitle:setText(LocalizeToUpperString(@"hash_1D7F732D451CACD8"))
	MultiKillTitle:setTTF("ttmussels_regular")
	MultiKillTitle:setLetterSpacing(2)
	MultiKillTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MultiKillTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(MultiKillTitle)
	self.MultiKillTitle = MultiKillTitle
	local MultiKillMedalImage = LUI.UIImage.new(0, 0, 33, 197, 1, 1, -268, -104)
	MultiKillMedalImage:setupUIStreamedImage(0)
	MultiKillMedalImage:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "MultiKillMedal.iconSmall", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MultiKillMedalImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(MultiKillMedalImage)
	self.MultiKillMedalImage = MultiKillMedalImage
	local MultiKillMedalName = LUI.UIText.new(0, 0, 15, 215, 1, 1, -104, -83)
	MultiKillMedalName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MultiKillMedalName:setAlpha(0.5)
	MultiKillMedalName:setTTF("ttmussels_regular")
	MultiKillMedalName:setLetterSpacing(2)
	MultiKillMedalName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MultiKillMedalName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	MultiKillMedalName:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "MultiKillMedal.name", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MultiKillMedalName:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self:addElement(MultiKillMedalName)
	self.MultiKillMedalName = MultiKillMedalName
	local MultiKillMedalTimesEarned = LUI.UIText.new(0, 0, 15, 215, 1, 1, -82, -37)
	MultiKillMedalTimesEarned:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	MultiKillMedalTimesEarned:setTTF("ttmussels_demibold")
	MultiKillMedalTimesEarned:setLetterSpacing(3)
	MultiKillMedalTimesEarned:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MultiKillMedalTimesEarned:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "MultiKillMedal.timesEarned", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			MultiKillMedalTimesEarned:setText(f7_local0)
		end
	end)
	self:addElement(MultiKillMedalTimesEarned)
	self.MultiKillMedalTimesEarned = MultiKillMedalTimesEarned
	local KillStreakTitle = LUI.UIText.new(0, 0, 15, 215, 1, 1, -292, -274)
	KillStreakTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	KillStreakTitle:setAlpha(0.5)
	KillStreakTitle:setText(LocalizeToUpperString(0x1DCC7AB8B8F861))
	KillStreakTitle:setTTF("ttmussels_regular")
	KillStreakTitle:setLetterSpacing(2)
	KillStreakTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KillStreakTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(KillStreakTitle)
	self.KillStreakTitle = KillStreakTitle
	local KillStreakMedalImage = LUI.UIImage.new(1, 1, -197, -33, 1, 1, -268, -104)
	KillStreakMedalImage:setupUIStreamedImage(0)
	KillStreakMedalImage:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "KillStreakMedal.iconSmall", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			KillStreakMedalImage:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(KillStreakMedalImage)
	self.KillStreakMedalImage = KillStreakMedalImage
	local KillStreakMedalName = LUI.UIText.new(1, 1, -215, -15, 1, 1, -104, -83)
	KillStreakMedalName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	KillStreakMedalName:setAlpha(0.5)
	KillStreakMedalName:setTTF("ttmussels_regular")
	KillStreakMedalName:setLetterSpacing(2)
	KillStreakMedalName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KillStreakMedalName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	KillStreakMedalName:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "KillStreakMedal.name", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			KillStreakMedalName:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	self:addElement(KillStreakMedalName)
	self.KillStreakMedalName = KillStreakMedalName
	local KillStreakMedalTimesEarned = LUI.UIText.new(1, 1, -215, -15, 1, 1, -82, -37)
	KillStreakMedalTimesEarned:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	KillStreakMedalTimesEarned:setTTF("ttmussels_demibold")
	KillStreakMedalTimesEarned:setLetterSpacing(3)
	KillStreakMedalTimesEarned:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KillStreakMedalTimesEarned:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "KillStreakMedal.timesEarned", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			KillStreakMedalTimesEarned:setText(f10_local0)
		end
	end)
	self:addElement(KillStreakMedalTimesEarned)
	self.KillStreakMedalTimesEarned = KillStreakMedalTimesEarned
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_Medal.__onClose = function(f11_arg0)
	f11_arg0.FeaturedMedalImage:close()
	f11_arg0.FeaturedMedalName:close()
	f11_arg0.FeaturedMedalTimesEarned:close()
	f11_arg0.MultiKillMedalImage:close()
	f11_arg0.MultiKillMedalName:close()
	f11_arg0.MultiKillMedalTimesEarned:close()
	f11_arg0.KillStreakMedalImage:close()
	f11_arg0.KillStreakMedalName:close()
	f11_arg0.KillStreakMedalTimesEarned:close()
end
