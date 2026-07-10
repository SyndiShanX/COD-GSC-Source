CoD.AARMissionReward_CharacterListItem = InheritFrom(LUI.UIElement)
CoD.AARMissionReward_CharacterListItem.__defaultWidth = 100
CoD.AARMissionReward_CharacterListItem.__defaultHeight = 100
CoD.AARMissionReward_CharacterListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARMissionReward_CharacterListItem)
	self.id = "AARMissionReward_CharacterListItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARMissionReward_CharacterListItem.__resetProperties = function(f2_arg0)
	f2_arg0.Backing:completeAnimation()
	f2_arg0.Backing:setAlpha(0)
end
CoD.AARMissionReward_CharacterListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Backing:completeAnimation()
			f4_arg0.Backing:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Backing)
		end,
	},
}
