CoD.InGamePlayerListRow = InheritFrom(LUI.UIElement)
CoD.InGamePlayerListRow.__defaultWidth = 600
CoD.InGamePlayerListRow.__defaultHeight = 37
CoD.InGamePlayerListRow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InGamePlayerListRow)
	self.id = "InGamePlayerListRow"
	self.soundSet = "ChooseDecal"
	local TeamColorBacking = LUI.UIImage.new(0, 1.01, -5, -5, 0, 1.19, -3, -3)
	TeamColorBacking:setAlpha(0.8)
	TeamColorBacking:setImage(RegisterImage(@"uie_ui_menu_cac_text_bg01"))
	TeamColorBacking:linkToElementModel(self, "teamBGColor", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamColorBacking:setRGB(f2_local0)
		end
	end)
	self:addElement(TeamColorBacking)
	self.TeamColorBacking = TeamColorBacking
	local rankBackground = LUI.UIImage.new(0, 0, 0, 75, 0, 0, 0, 38)
	rankBackground:setRGB(0, 0, 0)
	rankBackground:setAlpha(0)
	self:addElement(rankBackground)
	self.rankBackground = rankBackground
	local rankText = LUI.UIText.new(0, 0, 7.5, 37.5, 0, 0, 0, 38)
	rankText:setAlpha(0)
	rankText:setTTF("ttmussels_regular")
	rankText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	rankText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(rankText)
	self.rankText = rankText
	local rankImage = LUI.UIImage.new(0, 0, 41, 71, 0, 0, 4, 34)
	rankImage:setAlpha(0)
	self:addElement(rankImage)
	self.rankImage = rankImage
	local playerName = LUI.UIText.new(0, 0, 7.5, 588.5, 0, 0, 4.5, 32.5)
	playerName:setTTF("notosans_bold")
	playerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(playerName)
	self.playerName = playerName
	self.rankText:linkToElementModel(self, "rankText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			rankText:setText(f3_local0)
		end
	end)
	self.rankImage:linkToElementModel(self, "rankIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			rankImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self.playerName:linkToElementModel(self, "playerNameColor", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			playerName:setRGB(f5_local0)
		end
	end)
	self.playerName:linkToElementModel(self, "playerNameText", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			playerName:setText(CoD.SocialUtility.CleanGamerTag(f6_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InGamePlayerListRow.__onClose = function(f7_arg0)
	f7_arg0.TeamColorBacking:close()
	f7_arg0.rankText:close()
	f7_arg0.rankImage:close()
	f7_arg0.playerName:close()
end
