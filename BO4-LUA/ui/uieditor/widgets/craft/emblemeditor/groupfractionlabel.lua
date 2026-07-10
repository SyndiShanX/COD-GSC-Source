CoD.GroupFractionLabel = InheritFrom(LUI.UIElement)
CoD.GroupFractionLabel.__defaultWidth = 180
CoD.GroupFractionLabel.__defaultHeight = 42
CoD.GroupFractionLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GroupFractionLabel)
	self.id = "GroupFractionLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local groupsUsedValue = LUI.UIText.new(0, 0, 0, 180, 0, 0, 7.5, 32.5)
	groupsUsedValue:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	groupsUsedValue:setTTF("dinnext_regular")
	groupsUsedValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	groupsUsedValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(groupsUsedValue)
	self.groupsUsedValue = groupsUsedValue
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GroupFractionLabel.__resetProperties = function(f2_arg0)
	f2_arg0.groupsUsedValue:completeAnimation()
	f2_arg0.groupsUsedValue:setRGB(1, 1, 1)
end
CoD.GroupFractionLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	GroupsFull = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.groupsUsedValue:completeAnimation()
			f4_arg0.groupsUsedValue:setRGB(1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.groupsUsedValue)
		end,
	},
}
