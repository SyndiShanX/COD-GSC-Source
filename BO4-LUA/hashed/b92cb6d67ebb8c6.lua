CoD.ZMInvSentinelArtifactLarge = InheritFrom(LUI.UIElement)
CoD.ZMInvSentinelArtifactLarge.__defaultWidth = 384
CoD.ZMInvSentinelArtifactLarge.__defaultHeight = 384
CoD.ZMInvSentinelArtifactLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvSentinelArtifactLarge)
	self.id = "ZMInvSentinelArtifactLarge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StageImage = LUI.UIImage.new(0.17, 1.17, -64, -64, 0.17, 1.17, -64, -64)
	StageImage:setAlpha(0)
	StageImage:linkToElementModel(self, "Ring.stage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StageImage:setImage(RegisterImage(CoD.ZMInventoryUtility.StageToSentinelImage(f2_local0)))
		end
	end)
	self:addElement(StageImage)
	self.StageImage = StageImage
	self:mergeStateConditions({
		{
			stateName = "ON",
			condition = function(menu, element, event)
				return IsMapName("zm_orange") and CoD.ZombieUtility.IsEasterEggsAllowed(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvSentinelArtifactLarge.__resetProperties = function(f4_arg0)
	f4_arg0.StageImage:completeAnimation()
	f4_arg0.StageImage:setAlpha(0)
end
CoD.ZMInvSentinelArtifactLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	ON = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.StageImage:completeAnimation()
			f6_arg0.StageImage:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.StageImage)
		end,
	},
}
CoD.ZMInvSentinelArtifactLarge.__onClose = function(f7_arg0)
	f7_arg0.StageImage:close()
end
