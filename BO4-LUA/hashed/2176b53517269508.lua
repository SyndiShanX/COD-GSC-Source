CoD.LobbyMemberStarCount = InheritFrom(LUI.UIElement)
CoD.LobbyMemberStarCount.__defaultWidth = 65
CoD.LobbyMemberStarCount.__defaultHeight = 65
CoD.LobbyMemberStarCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LobbyMemberStarCount)
	self.id = "LobbyMemberStarCount"
	self.soundSet = "default"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.25)
	self:addElement(Backing)
	self.Backing = Backing
	local StarImage = LUI.UIImage.new(0.5, 0.5, -17.5, 17.5, 0, 0, 4, 39)
	StarImage:setImage(RegisterImage(0xA5CED7A3CD5BCF1))
	self:addElement(StarImage)
	self.StarImage = StarImage
	local StarCount = LUI.UIText.new(0, 0, 0, 65, 0, 0, 41, 65)
	StarCount:setTTF("ttmussels_regular")
	StarCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	StarCount:subscribeToGlobalModel(f1_arg1, "SpecialistHeadquarters", "StarCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StarCount:setText(f2_local0)
		end
	end)
	self:addElement(StarCount)
	self.StarCount = StarCount
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LobbyMemberStarCount.__onClose = function(f3_arg0)
	f3_arg0.StarCount:close()
end
