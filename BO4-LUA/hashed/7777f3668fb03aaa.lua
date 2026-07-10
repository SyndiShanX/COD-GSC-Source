require("x64:94dab3a4d2d79b2")
CoD.GameEndScore_GameStatusPlayerLeft = InheritFrom(LUI.UIElement)
CoD.GameEndScore_GameStatusPlayerLeft.__defaultWidth = 140
CoD.GameEndScore_GameStatusPlayerLeft.__defaultHeight = 50
CoD.GameEndScore_GameStatusPlayerLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_GameStatusPlayerLeft)
	self.id = "GameEndScore_GameStatusPlayerLeft"
	self.soundSet = "default"
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 50)
	DotCorner9Slice:setAlpha(0.3)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local playersLeftIcon = LUI.UIImage.new(1, 1, -128, -80, 0, 0, 0, 50)
	playersLeftIcon:setImage(RegisterImage(0x14B2E7558F68939))
	self:addElement(playersLeftIcon)
	self.playersLeftIcon = playersLeftIcon
	local PlayerCount = LUI.UIText.new(1, 1, -90, -10, 0, 0, 7.5, 42.5)
	PlayerCount:setTTF("0arame_mono_stencil")
	PlayerCount:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	PlayerCount:setShaderVector(0, 0.8, 0, 0, 0)
	PlayerCount:setShaderVector(1, 0, 0, 0, 0)
	PlayerCount:setShaderVector(2, 1, 1, 1, 0.35)
	PlayerCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlayerCount:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	PlayerCount:subscribeToGlobalModel(f1_arg1, "HUDItems", "alivePlayerCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerCount:setText(LocalizeIntoString(0x5D5258F7E7AB49, f2_local0))
		end
	end)
	self:addElement(PlayerCount)
	self.PlayerCount = PlayerCount
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_GameStatusPlayerLeft.__onClose = function(f3_arg0)
	f3_arg0.DotCorner9Slice:close()
	f3_arg0.PlayerCount:close()
end
