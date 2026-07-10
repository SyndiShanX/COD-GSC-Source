require("x64:8293fdfde8af5f3")
CoD.ObituaryCalloutContainerPlayerKilled = InheritFrom(LUI.UIElement)
CoD.ObituaryCalloutContainerPlayerKilled.__defaultWidth = 550
CoD.ObituaryCalloutContainerPlayerKilled.__defaultHeight = 26
CoD.ObituaryCalloutContainerPlayerKilled.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 28, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ObituaryCalloutContainerPlayerKilled)
	self.id = "ObituaryCalloutContainerPlayerKilled"
	self.soundSet = "default"
	local PlayerName = LUI.UIText.new(0, 0, 33.5, 179.5, 0, 0, -2, 28)
	PlayerName:setTTF("notosans_bold")
	PlayerName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	PlayerName:setShaderVector(0, 1, 0, 0, 0)
	PlayerName:setShaderVector(1, 0, 0, 0, 0)
	PlayerName:setShaderVector(2, 0, 0, 0, 0.35)
	PlayerName:setLetterSpacing(4)
	PlayerName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlayerName:setBackingType(1)
	PlayerName:setBackingWidget(CoD.ObituaryBlurBacking, f1_arg0, f1_arg1)
	PlayerName:setBackingColor(0, 0, 0)
	PlayerName:setBackingAlpha(0.8)
	PlayerName:setBackingXPadding(14)
	PlayerName:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerName:setRGB(CoD.CodCasterUtility.GetObituaryPlayerTeamColor(f1_arg1, f2_local0))
		end
	end)
	PlayerName:linkToElementModel(self, "clientNum", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerName:setText(CoD.SocialUtility.CleanGamerTag(GetScoreboardPlayerName(f1_arg1, f3_local0)))
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local ContribText2 = LUI.UIText.new(0, 0, 207.5, 516.5, 0, 0, -2, 28)
	ContribText2:setRGB(1, 0.99, 0.99)
	ContribText2:setAlpha(0.8)
	ContribText2:setText(LocalizeToUpperString(0x585C6033C252ED7))
	ContribText2:setTTF("ttmussels_regular")
	ContribText2:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ContribText2:setShaderVector(0, 1, 0, 0, 0)
	ContribText2:setShaderVector(1, 0, 0, 0, 0)
	ContribText2:setShaderVector(2, 0, 0, 0, 0.35)
	ContribText2:setLetterSpacing(4)
	ContribText2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ContribText2:setBackingType(1)
	ContribText2:setBackingWidget(CoD.ObituaryBlurBacking, f1_arg0, f1_arg1)
	ContribText2:setBackingColor(0, 0, 0)
	ContribText2:setBackingXPadding(14)
	self:addElement(ContribText2)
	self.ContribText2 = ContribText2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ObituaryCalloutContainerPlayerKilled.__onClose = function(f4_arg0)
	f4_arg0.PlayerName:close()
end
