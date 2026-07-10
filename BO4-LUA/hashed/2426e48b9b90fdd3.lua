CoD.ButtonFrame_MedalWZ = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_MedalWZ.__defaultWidth = 469
CoD.ButtonFrame_MedalWZ.__defaultHeight = 249
CoD.ButtonFrame_MedalWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_MedalWZ)
	self.id = "ButtonFrame_MedalWZ"
	self.soundSet = "none"
	local FeaturedMedalImage = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -72, 28)
	FeaturedMedalImage:setupUIStreamedImage(0)
	FeaturedMedalImage:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "FeaturedMedal.iconSmall", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FeaturedMedalImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FeaturedMedalImage)
	self.FeaturedMedalImage = FeaturedMedalImage
	local FeaturedMedalName = LUI.UIText.new(0.5, 0.5, -70, 70, 0.5, 0.5, 37, 55)
	FeaturedMedalName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FeaturedMedalName:setAlpha(0.5)
	FeaturedMedalName:setTTF("ttmussels_regular")
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
	local FeaturedMedalTimesEarned = LUI.UIText.new(0.5, 0.5, -70, 70, 0.5, 0.5, 55, 76)
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
	local MultiKillMedalImage = LUI.UIImage.new(0, 0, 34.5, 134.5, 0.5, 0.5, -72, 28)
	MultiKillMedalImage:setupUIStreamedImage(0)
	MultiKillMedalImage:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "MultiKillMedal.iconSmall", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MultiKillMedalImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(MultiKillMedalImage)
	self.MultiKillMedalImage = MultiKillMedalImage
	local MultiKillMedalName = LUI.UIText.new(0, 0, 14, 154, 0.5, 0.5, 37, 55)
	MultiKillMedalName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MultiKillMedalName:setAlpha(0.5)
	MultiKillMedalName:setTTF("ttmussels_regular")
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
	local MultiKillMedalTimesEarned = LUI.UIText.new(0, 0, 14, 154, 0.5, 0.5, 55, 76)
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
	local KillStreakMedalImage = LUI.UIImage.new(1, 1, -134.5, -34.5, 0.5, 0.5, -72, 28)
	KillStreakMedalImage:setupUIStreamedImage(0)
	KillStreakMedalImage:subscribeToGlobalModel(f1_arg1, "FeaturedMedals", "KillStreakMedal.iconSmall", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			KillStreakMedalImage:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(KillStreakMedalImage)
	self.KillStreakMedalImage = KillStreakMedalImage
	local KillStreakMedalName = LUI.UIText.new(1, 1, -154, -14, 0.5, 0.5, 37, 55)
	KillStreakMedalName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	KillStreakMedalName:setAlpha(0.5)
	KillStreakMedalName:setTTF("ttmussels_regular")
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
	local KillStreakMedalTimesEarned = LUI.UIText.new(1, 1, -154, -14, 0.5, 0.5, 55, 76)
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
CoD.ButtonFrame_MedalWZ.__onClose = function(f11_arg0)
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
