CoD.DirectorLobbyMemberName = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyMemberName.__defaultWidth = 241
CoD.DirectorLobbyMemberName.__defaultHeight = 28
CoD.DirectorLobbyMemberName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyMemberName)
	self.id = "DirectorLobbyMemberName"
	self.soundSet = "default"
	local gamertag = LUI.UIText.new(0, 0, 0, 250, 0, 0, -2, 20)
	gamertag.__Color = function()
		gamertag:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	gamertag.__Color()
	gamertag:setTTF("notosans_bold")
	gamertag:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	gamertag:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	gamertag:setBackingType(2)
	gamertag:setBackingColor(0, 0, 0)
	gamertag:setBackingAlpha(0.9)
	gamertag:setBackingXPadding(2)
	gamertag:linkToElementModel(self, "gamertag", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			gamertag:setText(CoD.SocialUtility.CleanGamerTag(f3_local0))
		end
	end)
	self:addElement(gamertag)
	self.gamertag = gamertag
	gamertag:linkToElementModel(self, "xuid", true, gamertag.__Color)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbyMemberName.__onClose = function(f4_arg0)
	f4_arg0.gamertag:close()
end
