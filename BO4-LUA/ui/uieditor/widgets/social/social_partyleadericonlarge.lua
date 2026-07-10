CoD.Social_PartyLeaderIconLarge = InheritFrom(LUI.UIElement)
CoD.Social_PartyLeaderIconLarge.__defaultWidth = 23
CoD.Social_PartyLeaderIconLarge.__defaultHeight = 84
CoD.Social_PartyLeaderIconLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PartyLeaderIconLarge)
	self.id = "Social_PartyLeaderIconLarge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Leader = LUI.UIImage.new(0, 0, -1.5, 29.5, 0, 1, -4, 4)
	Leader:setRGB(0.29, 0.38, 0.68)
	Leader:setAlpha(0)
	Leader:setImage(RegisterImage(@"uie_t7_menu_frontend_iconpartyleaderlarge"))
	Leader:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(Leader)
	self.Leader = Leader
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PartyLeaderIconLarge.__resetProperties = function(f2_arg0)
	f2_arg0.Leader:completeAnimation()
	f2_arg0.Leader:setLeftRight(0, 0, -1.5, 29.5)
	f2_arg0.Leader:setTopBottom(0, 1, -4, 4)
end
CoD.Social_PartyLeaderIconLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Leader:completeAnimation()
			f4_arg0.Leader:setLeftRight(0, 0, -3, 32)
			f4_arg0.Leader:setTopBottom(-0.5, 0.5, 38, 46)
			f4_arg0.clipFinished(f4_arg0.Leader)
		end,
	},
}
