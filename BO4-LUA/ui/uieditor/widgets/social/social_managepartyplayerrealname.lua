CoD.Social_ManagePartyPlayerRealName = InheritFrom(LUI.UIElement)
CoD.Social_ManagePartyPlayerRealName.__defaultWidth = 289
CoD.Social_ManagePartyPlayerRealName.__defaultHeight = 30
CoD.Social_ManagePartyPlayerRealName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 15, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.Social_ManagePartyPlayerRealName)
	self.id = "Social_ManagePartyPlayerRealName"
	self.soundSet = "default"
	local clanTag = LUI.UIText.new(0, 0, 0, 132, 0.5, 0.5, -15, 15)
	clanTag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	clanTag:setTTF("notosans_regular")
	clanTag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	clanTag:setBackingType(2)
	clanTag:setBackingColor(0, 0, 0)
	clanTag:setBackingAlpha(0.6)
	clanTag:setBackingXPadding(3)
	clanTag:linkToElementModel(self, "identityBadge.clantag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			clanTag:setText(StringAsClanTag(f2_local0))
		end
	end)
	self:addElement(clanTag)
	self.clanTag = clanTag
	local realName = LUI.UIText.new(0, 0, 147, 436, 0.5, 0.5, -15, 15)
	realName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	realName:setTTF("notosans_regular")
	realName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	realName:setBackingType(2)
	realName:setBackingColor(0, 0, 0)
	realName:setBackingAlpha(0.6)
	realName:setBackingXPadding(3)
	realName:linkToElementModel(self, "identityBadge.realName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			realName:setText(f3_local0)
		end
	end)
	self:addElement(realName)
	self.realName = realName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_ManagePartyPlayerRealName.__onClose = function(f4_arg0)
	f4_arg0.clanTag:close()
	f4_arg0.realName:close()
end
