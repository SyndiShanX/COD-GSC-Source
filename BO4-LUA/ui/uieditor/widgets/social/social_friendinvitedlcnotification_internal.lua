CoD.Social_FriendInviteDLCNotification_Internal = InheritFrom(LUI.UIElement)
CoD.Social_FriendInviteDLCNotification_Internal.__defaultWidth = 615
CoD.Social_FriendInviteDLCNotification_Internal.__defaultHeight = 50
CoD.Social_FriendInviteDLCNotification_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_FriendInviteDLCNotification_Internal)
	self.id = "Social_FriendInviteDLCNotification_Internal"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(-0.01, 1, 60, -8, 0, 0, 4, 25)
	label:setAlpha(0)
	label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5D986F1A4D6B83BD"))
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(2)
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(label)
	self.label = label
	local buttonPromptImage = LUI.UIImage.new(0, 0, 0, 40, 0, 0, 0, 36)
	buttonPromptImage:setAlpha(0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	self:mergeStateConditions({
		{
			stateName = "Warning",
			condition = function(menu, element, event)
				return CoD.SocialUtility.IsUserMissingUsedDLCForSelectedPlaylist(f1_arg1, element)
			end,
		},
		{
			stateName = "Error",
			condition = function(menu, element, event)
				return CoD.SocialUtility.IsUserMissingRequiredDLCForSelectedPlaylist(f1_arg1, element)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.playlistId, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "playlistId",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5["privateClient.count"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "privateClient.count",
		})
	end, false)
	self:linkToElementModel(self, "blackopsPass", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "blackopsPass",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_FriendInviteDLCNotification_Internal.__resetProperties = function(f7_arg0)
	f7_arg0.label:completeAnimation()
	f7_arg0.buttonPromptImage:completeAnimation()
	f7_arg0.label:setLeftRight(-0.01, 1, 60, -8)
	f7_arg0.label:setTopBottom(0, 0, 4, 25)
	f7_arg0.label:setAlpha(0)
	f7_arg0.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5D986F1A4D6B83BD"))
	f7_arg0.buttonPromptImage:setRGB(1, 1, 1)
	f7_arg0.buttonPromptImage:setAlpha(0)
end
CoD.Social_FriendInviteDLCNotification_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Warning = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.label:completeAnimation()
			f9_arg0.label:setAlpha(1)
			f9_arg0.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_746B5A4A4E88274B"))
			f9_arg0.clipFinished(f9_arg0.label)
			f9_arg0.buttonPromptImage:completeAnimation()
			f9_arg0.buttonPromptImage:setRGB(1, 0.92, 0)
			f9_arg0.buttonPromptImage:setAlpha(1)
			f9_arg0.buttonPromptImage:setImage(RegisterImage("uie_warning_triangle"))
			f9_arg0.clipFinished(f9_arg0.buttonPromptImage)
		end,
	},
	Error = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.label:completeAnimation()
			f10_arg0.label:setLeftRight(0, 1, 60, -8)
			f10_arg0.label:setTopBottom(0, 0, 5.5, 30.5)
			f10_arg0.label:setAlpha(1)
			f10_arg0.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5D986F1A4D6B83BD"))
			f10_arg0.clipFinished(f10_arg0.label)
			f10_arg0.buttonPromptImage:completeAnimation()
			f10_arg0.buttonPromptImage:setRGB(1, 0, 0)
			f10_arg0.buttonPromptImage:setAlpha(1)
			f10_arg0.buttonPromptImage:setImage(RegisterImage("uie_warning_triangle"))
			f10_arg0.clipFinished(f10_arg0.buttonPromptImage)
		end,
	},
}
