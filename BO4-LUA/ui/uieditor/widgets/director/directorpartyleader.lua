CoD.DirectorPartyLeader = InheritFrom(LUI.UIElement)
CoD.DirectorPartyLeader.__defaultWidth = 20
CoD.DirectorPartyLeader.__defaultHeight = 20
CoD.DirectorPartyLeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPartyLeader)
	self.id = "DirectorPartyLeader"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PartyLeaderStar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PartyLeaderStar:setRGB(0.02, 0.29, 0.49)
	PartyLeaderStar:setImage(RegisterImage("uie_ui_menu_director_icon_star"))
	self:addElement(PartyLeaderStar)
	self.PartyLeaderStar = PartyLeaderStar
	self:mergeStateConditions({
		{
			stateName = "IsLeader",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "isMemberLeader", 1)
			end,
		},
	})
	self:linkToElementModel(self, "isMemberLeader", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isMemberLeader",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPartyLeader.__resetProperties = function(f4_arg0)
	f4_arg0.PartyLeaderStar:completeAnimation()
	f4_arg0.PartyLeaderStar:setAlpha(1)
end
CoD.DirectorPartyLeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.PartyLeaderStar:completeAnimation()
			f5_arg0.PartyLeaderStar:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PartyLeaderStar)
		end,
	},
	IsLeader = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
