CoD.FooterButton_Player_Emblem = InheritFrom(LUI.UIElement)
CoD.FooterButton_Player_Emblem.__defaultWidth = 42
CoD.FooterButton_Player_Emblem.__defaultHeight = 42
CoD.FooterButton_Player_Emblem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButton_Player_Emblem)
	self.id = "FooterButton_Player_Emblem"
	self.soundSet = "default"
	local emblem = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -100, 100)
	emblem:setScale(0.2, 0.2)
	emblem:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge.xuid", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f2_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_Player_Emblem.__onClose = function(f3_arg0)
	f3_arg0.emblem:close()
end
