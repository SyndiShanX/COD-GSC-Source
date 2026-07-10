require("x64:d4ed3fd8d1fcc4a")
CoD.DirectorLobbyPoseMembers = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyPoseMembers.__defaultWidth = 1920
CoD.DirectorLobbyPoseMembers.__defaultHeight = 1080
CoD.DirectorLobbyPoseMembers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyPoseMembers)
	self.id = "DirectorLobbyPoseMembers"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local overheadNameContainer = CoD.DynamicContainerWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(overheadNameContainer)
	self.overheadNameContainer = overheadNameContainer
	self:mergeStateConditions({
		{
			stateName = "NotUsingLobbyPoses",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.UsingLobbyPoses(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.room, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "room",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.LobbyUtility.InitOverheadNamesPreLobby(f1_arg0, f1_arg1, overheadNameContainer)
	return self
end
CoD.DirectorLobbyPoseMembers.__onClose = function(f4_arg0)
	f4_arg0.overheadNameContainer:close()
end
