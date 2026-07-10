CoD.DirectorLobbyLeader = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyLeader.__defaultWidth = 14
CoD.DirectorLobbyLeader.__defaultHeight = 64
CoD.DirectorLobbyLeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyLeader)
	self.id = "DirectorLobbyLeader"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeaderBacking = LUI.UIImage.new(0, 1.07, 0, 0, 0, 1, 0, 0)
	LeaderBacking:setRGB(ColorSet.T8__BLUE.r, ColorSet.T8__BLUE.g, ColorSet.T8__BLUE.b)
	self:addElement(LeaderBacking)
	self.LeaderBacking = LeaderBacking
	local PartyLeaderStar = LUI.UIImage.new(0.1, 0.96, 0, 0, 0.03, 0.22, 0, 0)
	PartyLeaderStar:setImage(RegisterImage(@"uie_ui_menu_director_icon_star"))
	self:addElement(PartyLeaderStar)
	self.PartyLeaderStar = PartyLeaderStar
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "isLeader", 1)
			end,
		},
	})
	self:linkToElementModel(self, "isLeader", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLeader",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbyLeader.__resetProperties = function(f4_arg0)
	f4_arg0.LeaderBacking:completeAnimation()
	f4_arg0.PartyLeaderStar:completeAnimation()
	f4_arg0.LeaderBacking:setAlpha(1)
	f4_arg0.PartyLeaderStar:setAlpha(1)
end
CoD.DirectorLobbyLeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.LeaderBacking:completeAnimation()
			f5_arg0.LeaderBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.LeaderBacking)
			f5_arg0.PartyLeaderStar:completeAnimation()
			f5_arg0.PartyLeaderStar:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PartyLeaderStar)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
