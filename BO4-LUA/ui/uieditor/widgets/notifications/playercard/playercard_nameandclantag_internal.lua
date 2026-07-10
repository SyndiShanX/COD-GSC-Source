CoD.PlayerCard_NameAndClanTag_Internal = InheritFrom(LUI.UIElement)
CoD.PlayerCard_NameAndClanTag_Internal.__defaultWidth = 308
CoD.PlayerCard_NameAndClanTag_Internal.__defaultHeight = 21
CoD.PlayerCard_NameAndClanTag_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.PlayerCard_NameAndClanTag_Internal)
	self.id = "PlayerCard_NameAndClanTag_Internal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerName = LUI.UIText.new(0, 0, 0, 308, 0, 0, 0, 21)
	PlayerName:setRGB(0.92, 0.92, 0.92)
	PlayerName:setTTF("notosans_regular")
	PlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayerName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	PlayerName:setBackingType(2)
	PlayerName:setBackingColor(0, 0, 0)
	PlayerName:setBackingAlpha(0.9)
	PlayerName:setBackingXPadding(5)
	PlayerName:setBackingYPadding(2)
	PlayerName:linkToElementModel(self, "playerName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerName:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	self:mergeStateConditions({
		{
			stateName = "ClanTagPC",
			condition = function(menu, element, event)
				local f3_local0
				if not IsTextEmpty(self.PlayerName) then
					f3_local0 = IsPC()
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "ClanTag",
			condition = function(menu, element, event)
				return not IsTextEmpty(self.PlayerName)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerCard_NameAndClanTag_Internal.__resetProperties = function(f5_arg0)
	f5_arg0.PlayerName:completeAnimation()
	f5_arg0.PlayerName:setTopBottom(0, 0, 0, 21)
end
CoD.PlayerCard_NameAndClanTag_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	ClanTagPC = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.PlayerName:completeAnimation()
			f7_arg0.PlayerName:setTopBottom(0, 0, 0, 21)
			f7_arg0.clipFinished(f7_arg0.PlayerName)
		end,
	},
	ClanTag = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.PlayerCard_NameAndClanTag_Internal.__onClose = function(f9_arg0)
	f9_arg0.PlayerName:close()
end
