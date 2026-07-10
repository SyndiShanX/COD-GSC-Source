require("x64:c1b8e8afdaf81b9")
require("x64:ff3f371ba869eda")
CoD.Social_InfoPane = InheritFrom(LUI.UIElement)
CoD.Social_InfoPane.__defaultWidth = 724
CoD.Social_InfoPane.__defaultHeight = 680
CoD.Social_InfoPane.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("socialRoot.recentPlayers.update")
	self:setClass(CoD.Social_InfoPane)
	self.id = "Social_InfoPane"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InfoPaneRight = CoD.Social_InfoPaneRight.new(f1_arg0, f1_arg1, 0, 0, 480, 783, 0, 0, 0, 741)
	InfoPaneRight:linkToElementModel(self, nil, false, function(model)
		InfoPaneRight:setModel(model, f1_arg1)
	end)
	self:addElement(InfoPaneRight)
	self.InfoPaneRight = InfoPaneRight
	local InfoPaneLeft = CoD.Social_InfoPaneLeft.new(f1_arg0, f1_arg1, 0, 0, 0, 460, 0, 0, 0, 741)
	InfoPaneLeft:linkToElementModel(self, nil, false, function(model)
		InfoPaneLeft:setModel(model, f1_arg1)
	end)
	self:addElement(InfoPaneLeft)
	self.InfoPaneLeft = InfoPaneLeft
	self:mergeStateConditions({
		{
			stateName = "NoPlayer",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "identityBadge.xuid", LuaDefine.INVALID_XUID_X64)
			end,
		},
	})
	self:linkToElementModel(self, "identityBadge.xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "identityBadge.xuid",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "SocialRoot", "recentPlayers.update", function(model)
		local f6_local0 = self
		DataSourceHelperGetModel(f1_arg1, "SocialPlayerInfo")
	end)
	InfoPaneRight.id = "InfoPaneRight"
	InfoPaneLeft.id = "InfoPaneLeft"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_InfoPane.__onClose = function(f7_arg0)
	f7_arg0.InfoPaneRight:close()
	f7_arg0.InfoPaneLeft:close()
end
