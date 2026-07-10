CoD.PC_BattlenetFriend_NameAndRealId = InheritFrom(LUI.UIElement)
CoD.PC_BattlenetFriend_NameAndRealId.__defaultWidth = 300
CoD.PC_BattlenetFriend_NameAndRealId.__defaultHeight = 21
CoD.PC_BattlenetFriend_NameAndRealId.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.PC_BattlenetFriend_NameAndRealId)
	self.id = "PC_BattlenetFriend_NameAndRealId"
	self.soundSet = "default"
	local TXTPlayerTag = LUI.UIText.new(0.23, 0.23, -69, 184, 0.17, 0.17, -3.5, 17.5)
	TXTPlayerTag:setRGB(ColorSet.EnemyOrange_Protanopia.r, ColorSet.EnemyOrange_Protanopia.g, ColorSet.EnemyOrange_Protanopia.b)
	TXTPlayerTag:setTTF("notosans_light")
	TXTPlayerTag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TXTPlayerTag:linkToElementModel(self, "identityBadge.gamertag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TXTPlayerTag:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(TXTPlayerTag)
	self.TXTPlayerTag = TXTPlayerTag
	local TXTRealId = LUI.UIText.new(0.23, 0.23, 189, 442, 0.17, 0.17, -3.5, 17.5)
	TXTRealId:setTTF("notosans_light")
	TXTRealId:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TXTRealId:linkToElementModel(self, "identityBadge.realName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TXTRealId:setText(f3_local0)
		end
	end)
	self:addElement(TXTRealId)
	self.TXTRealId = TXTRealId
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	ActivateTextStencilCulling(TXTPlayerTag)
	ActivateTextStencilCulling(TXTRealId)
	return self
end
CoD.PC_BattlenetFriend_NameAndRealId.__onClose = function(f4_arg0)
	f4_arg0.TXTPlayerTag:close()
	f4_arg0.TXTRealId:close()
end
