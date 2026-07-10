require("x64:7dacefed967e3df")
CoD.DirectorTierSkipNotificationCompleteInternal = InheritFrom(LUI.UIElement)
CoD.DirectorTierSkipNotificationCompleteInternal.__defaultWidth = 450
CoD.DirectorTierSkipNotificationCompleteInternal.__defaultHeight = 80
CoD.DirectorTierSkipNotificationCompleteInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTierSkipNotificationCompleteInternal)
	self.id = "DirectorTierSkipNotificationCompleteInternal"
	self.soundSet = "none"
	local Backing = CoD.CommonBackingWithBrackets.new(f1_arg0, f1_arg1, 0, 1.05, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local Header = LUI.UIText.new(0, 0, 47, 425, 0.5, 0.5, -30, -6)
	Header:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	Header:setText(LocalizeToUpperString(@"hash_57694D34181BA0D5"))
	Header:setTTF("ttmussels_regular")
	Header:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Header:setLetterSpacing(3)
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Header:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Header)
	self.Header = Header
	local Description = LUI.UIText.new(-0.05, 0.71, 71.5, 71.5, 0, 0, 46.5, 64.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	Description:subscribeToGlobalModel(f1_arg1, "TierSkip", "remainingTimeString", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Description:setText(LocalizeIntoStringIfNotEmpty(@"hash_3235B6BD10DA7135", f2_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTierSkipNotificationCompleteInternal.__onClose = function(f3_arg0)
	f3_arg0.Backing:close()
	f3_arg0.Description:close()
end
