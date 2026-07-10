require("x64:fc73a2ac60b7625")
require("x64:2e63ab9f9bde55b")
CoD.WZTeamListItemContainer = InheritFrom(LUI.UIElement)
CoD.WZTeamListItemContainer.__defaultWidth = 384
CoD.WZTeamListItemContainer.__defaultHeight = 27
CoD.WZTeamListItemContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamListItemContainer)
	self.id = "WZTeamListItemContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerInfoAsian = CoD.WZTeamPlayerInfoAsian.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 27)
	PlayerInfoAsian:setAlpha(0)
	PlayerInfoAsian:linkToElementModel(self, nil, false, function(model)
		PlayerInfoAsian:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerInfoAsian)
	self.PlayerInfoAsian = PlayerInfoAsian
	local PlayerInfo = CoD.WZTeamPlayerInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 0, 27)
	PlayerInfo:linkToElementModel(self, nil, false, function(model)
		PlayerInfo:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerInfo)
	self.PlayerInfo = PlayerInfo
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZTeamListItemContainer.__resetProperties = function(f5_arg0)
	f5_arg0.PlayerInfo:completeAnimation()
	f5_arg0.PlayerInfoAsian:completeAnimation()
	f5_arg0.PlayerInfo:setAlpha(1)
	f5_arg0.PlayerInfoAsian:setAlpha(0)
end
CoD.WZTeamListItemContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.PlayerInfoAsian:completeAnimation()
			f7_arg0.PlayerInfoAsian:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.PlayerInfoAsian)
			f7_arg0.PlayerInfo:completeAnimation()
			f7_arg0.PlayerInfo:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.PlayerInfo)
		end,
	},
}
CoD.WZTeamListItemContainer.__onClose = function(f8_arg0)
	f8_arg0.PlayerInfoAsian:close()
	f8_arg0.PlayerInfo:close()
end
