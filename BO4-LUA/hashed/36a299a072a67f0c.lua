require("x64:94dab3a4d2d79b2")
CoD.GameEndScore_GameStatusPlayerKills = InheritFrom(LUI.UIElement)
CoD.GameEndScore_GameStatusPlayerKills.__defaultWidth = 140
CoD.GameEndScore_GameStatusPlayerKills.__defaultHeight = 50
CoD.GameEndScore_GameStatusPlayerKills.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_GameStatusPlayerKills)
	self.id = "GameEndScore_GameStatusPlayerKills"
	self.soundSet = "default"
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 50)
	DotCorner9Slice:setAlpha(0.3)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local PlayerKills = LUI.UIText.new(1, 1, -90, -8, 0, 0, 7.5, 42.5)
	PlayerKills:setTTF("0arame_mono_stencil")
	PlayerKills:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	PlayerKills:setShaderVector(0, 0.8, 0, 0, 0)
	PlayerKills:setShaderVector(1, 0, 0, 0, 0)
	PlayerKills:setShaderVector(2, 1, 1, 1, 0.35)
	PlayerKills:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayerKills:subscribeToGlobalModel(f1_arg1, "HUDItems", "playerKills", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerKills:setText(f2_local0)
		end
	end)
	self:addElement(PlayerKills)
	self.PlayerKills = PlayerKills
	local playerKillsIcon = LUI.UIImage.new(1, 1, -128, -82, 0, 0, 0, 50)
	playerKillsIcon:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_icon_kills"))
	self:addElement(playerKillsIcon)
	self.playerKillsIcon = playerKillsIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_GameStatusPlayerKills.__onClose = function(f3_arg0)
	f3_arg0.DotCorner9Slice:close()
	f3_arg0.PlayerKills:close()
end
