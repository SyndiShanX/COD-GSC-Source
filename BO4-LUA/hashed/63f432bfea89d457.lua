CoD.ZMInvSentinelArtifact = InheritFrom(LUI.UIElement)
CoD.ZMInvSentinelArtifact.__defaultWidth = 128
CoD.ZMInvSentinelArtifact.__defaultHeight = 128
CoD.ZMInvSentinelArtifact.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvSentinelArtifact)
	self.id = "ZMInvSentinelArtifact"
	self.soundSet = "default"
	local StageImage = LUI.UIImage.new(0.5, 0.5, -64, 64, 0.5, 0.5, -64, 64)
	StageImage:linkToElementModel(self, "Ring.stage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StageImage:setImage(RegisterImage(CoD.ZMInventoryUtility.StageToSentinelImage(f2_local0)))
		end
	end)
	self:addElement(StageImage)
	self.StageImage = StageImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvSentinelArtifact.__onClose = function(f3_arg0)
	f3_arg0.StageImage:close()
end
