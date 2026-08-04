CoD.LoadingScreenTalkerContainerCPZM = InheritFrom(LUI.UIElement)
CoD.LoadingScreenTalkerContainerCPZM.__defaultWidth = 330
CoD.LoadingScreenTalkerContainerCPZM.__defaultHeight = 25
CoD.LoadingScreenTalkerContainerCPZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.LoadingScreenTalkerContainerCPZM)
	self.id = "LoadingScreenTalkerContainerCPZM"
	self.soundSet = "default"
	local PlayerName = LUI.UIText.new(0, 0, 0, 313, 0, 0, 0, 26)
	PlayerName:setTTF("notosans_regular")
	PlayerName:setLetterSpacing(0.5)
	PlayerName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	PlayerName:setBackingType(2)
	PlayerName:setBackingColor(0, 0, 0)
	PlayerName:setBackingAlpha(0.8)
	PlayerName:linkToElementModel(self, "playerName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerName:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(PlayerName, "setText", function(element, controller)
		ScaleWidgetToLabelLeftJustify(self, element, 20)
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local VOIPImageByXUID = LUI.UIImage.new(1, 1, -17.5, 6.5, 0, 0, 1, 25)
	self:addElement(VOIPImageByXUID)
	self.VOIPImageByXUID = VOIPImageByXUID
	self.VOIPImageByXUID:linkToElementModel(self, "playerxuid", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			VOIPImageByXUID:setupVoipImageByXUID(f4_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadingScreenTalkerContainerCPZM.__onClose = function(f5_arg0)
	f5_arg0.PlayerName:close()
	f5_arg0.VOIPImageByXUID:close()
end
