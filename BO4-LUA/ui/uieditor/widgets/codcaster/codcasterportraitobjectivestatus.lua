CoD.CodCasterPortraitObjectiveStatus = InheritFrom(LUI.UIElement)
CoD.CodCasterPortraitObjectiveStatus.__defaultWidth = 64
CoD.CodCasterPortraitObjectiveStatus.__defaultHeight = 64
CoD.CodCasterPortraitObjectiveStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPortraitObjectiveStatus)
	self.id = "CodCasterPortraitObjectiveStatus"
	self.soundSet = "default"
	local ObjectiveStatusImage = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	ObjectiveStatusImage:linkToElementModel(self, "clientNumScoreInfoUpdated", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ObjectiveStatusImage:setRGB(GetPlayerListObjectiveColor(f1_arg1, f2_local0))
		end
	end)
	ObjectiveStatusImage:linkToElementModel(self, "clientNumScoreInfoUpdated", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ObjectiveStatusImage:setImage(RegisterImage(GetPlayerListObjectiveMinimapImage(f1_arg1, f3_local0)))
		end
	end)
	self:addElement(ObjectiveStatusImage)
	self.ObjectiveStatusImage = ObjectiveStatusImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.CodCasterUtility.InitPortraitObjectiveStatus(self, f1_arg1)
	return self
end
CoD.CodCasterPortraitObjectiveStatus.__onClose = function(f4_arg0)
	f4_arg0.ObjectiveStatusImage:close()
end
