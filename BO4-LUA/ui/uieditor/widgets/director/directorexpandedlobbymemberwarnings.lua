CoD.DirectorExpandedLobbyMemberWarnings = InheritFrom(LUI.UIElement)
CoD.DirectorExpandedLobbyMemberWarnings.__defaultWidth = 40
CoD.DirectorExpandedLobbyMemberWarnings.__defaultHeight = 40
CoD.DirectorExpandedLobbyMemberWarnings.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorExpandedLobbyMemberWarnings)
	self.id = "DirectorExpandedLobbyMemberWarnings"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local notificationIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	notificationIcon:setAlpha(0)
	self:addElement(notificationIcon)
	self.notificationIcon = notificationIcon
	self:mergeStateConditions({
		{
			stateName = "SpectreRisingWarning",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility.IsSelfModelSpectreRisingRestricted(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "selectedCharacterType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selectedCharacterType",
		})
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.playlistId"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.playlistId",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorExpandedLobbyMemberWarnings.__resetProperties = function(f5_arg0)
	f5_arg0.notificationIcon:completeAnimation()
	f5_arg0.notificationIcon:setRGB(1, 1, 1)
	f5_arg0.notificationIcon:setAlpha(0)
end
CoD.DirectorExpandedLobbyMemberWarnings.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	SpectreRisingWarning = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.notificationIcon:completeAnimation()
			f7_arg0.notificationIcon:setRGB(ColorSet.EnemyScorestreakTarget.r, ColorSet.EnemyScorestreakTarget.g, ColorSet.EnemyScorestreakTarget.b)
			f7_arg0.notificationIcon:setAlpha(1)
			f7_arg0.notificationIcon:setImage(RegisterImage(@"warning_triangle"))
			f7_arg0.clipFinished(f7_arg0.notificationIcon)
		end,
	},
}
