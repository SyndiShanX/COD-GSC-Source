CoD.DecalGroupsAvailable = InheritFrom(LUI.UIElement)
CoD.DecalGroupsAvailable.__defaultWidth = 1016
CoD.DecalGroupsAvailable.__defaultHeight = 20
CoD.DecalGroupsAvailable.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DecalGroupsAvailable)
	self.id = "DecalGroupsAvailable"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local groupsAvailableText = LUI.UIText.new(0, 0, 0, 567, 0, 0, 0.5, 20.5)
	groupsAvailableText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	groupsAvailableText:setText(LocalizeStringWithDatasource("Emblem.EmblemProperties.groupsAvailable", f1_arg1, @"hash_A79924F6E867D6C"))
	groupsAvailableText:setTTF("dinnext_regular")
	groupsAvailableText:setLetterSpacing(1)
	groupsAvailableText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	groupsAvailableText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(groupsAvailableText)
	self.groupsAvailableText = groupsAvailableText
	local noMoreGroupsText = LUI.UIText.new(0, 0, 380, 947, 0, 0, 0.5, 20.5)
	noMoreGroupsText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	noMoreGroupsText:setText(Engine[@"hash_4F9F1239CFD921FE"](0xF922F82F145E9B))
	noMoreGroupsText:setTTF("dinnext_regular")
	noMoreGroupsText:setLetterSpacing(1)
	noMoreGroupsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	noMoreGroupsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(noMoreGroupsText)
	self.noMoreGroupsText = noMoreGroupsText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DecalGroupsAvailable.__resetProperties = function(f2_arg0)
	f2_arg0.noMoreGroupsText:completeAnimation()
	f2_arg0.groupsAvailableText:completeAnimation()
	f2_arg0.noMoreGroupsText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	f2_arg0.noMoreGroupsText:setAlpha(1)
	f2_arg0.groupsAvailableText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
end
CoD.DecalGroupsAvailable.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.noMoreGroupsText:completeAnimation()
			f3_arg0.noMoreGroupsText:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.noMoreGroupsText)
		end,
	},
	GroupsFilled = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.groupsAvailableText:completeAnimation()
			f4_arg0.groupsAvailableText:setRGB(1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.groupsAvailableText)
			f4_arg0.noMoreGroupsText:completeAnimation()
			f4_arg0.noMoreGroupsText:setRGB(1, 0, 0)
			f4_arg0.noMoreGroupsText:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.noMoreGroupsText)
		end,
	},
}
