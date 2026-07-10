CoD.PositionDraft_DiamondFUI = InheritFrom(LUI.UIElement)
CoD.PositionDraft_DiamondFUI.__defaultWidth = 31
CoD.PositionDraft_DiamondFUI.__defaultHeight = 31
CoD.PositionDraft_DiamondFUI.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_DiamondFUI)
	self.id = "PositionDraft_DiamondFUI"
	self.soundSet = "default"
	local BorderRight2 = LUI.UIImage.new(1, 1, -3, 0, 1.03, 1.03, -32, -29)
	BorderRight2:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BorderRight2:setRGB(ClientGamertagColor(f1_arg1, f2_local0))
		end
	end)
	self:addElement(BorderRight2)
	self.BorderRight2 = BorderRight2
	local BorderRight3 = LUI.UIImage.new(1, 1, -30.5, -27.5, 1.03, 1.03, -4, -1)
	BorderRight3:linkToElementModel(self, "clientNum", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BorderRight3:setRGB(ClientGamertagColor(f1_arg1, f3_local0))
		end
	end)
	self:addElement(BorderRight3)
	self.BorderRight3 = BorderRight3
	local BorderRight4 = LUI.UIImage.new(1, 1, -8, 0, 1.03, 1.03, -3, -1)
	BorderRight4:linkToElementModel(self, "clientNum", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BorderRight4:setRGB(ClientGamertagColor(f1_arg1, f4_local0))
		end
	end)
	self:addElement(BorderRight4)
	self.BorderRight4 = BorderRight4
	local BorderRight = LUI.UIImage.new(1, 1, -2, 0, 1.03, 1.03, -8.5, -1.5)
	BorderRight:linkToElementModel(self, "clientNum", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			BorderRight:setRGB(ClientGamertagColor(f1_arg1, f5_local0))
		end
	end)
	self:addElement(BorderRight)
	self.BorderRight = BorderRight
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_DiamondFUI.__onClose = function(f6_arg0)
	f6_arg0.BorderRight2:close()
	f6_arg0.BorderRight3:close()
	f6_arg0.BorderRight4:close()
	f6_arg0.BorderRight:close()
end
