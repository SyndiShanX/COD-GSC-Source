require("x64:c7a70f5004ad7ac")
require("x64:f732d1ff8c659ed")
CoD.Social_PlayersListButtonWithCheckbox = InheritFrom(LUI.UIElement)
CoD.Social_PlayersListButtonWithCheckbox.__defaultWidth = 514
CoD.Social_PlayersListButtonWithCheckbox.__defaultHeight = 40
CoD.Social_PlayersListButtonWithCheckbox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PlayersListButtonWithCheckbox)
	self.id = "Social_PlayersListButtonWithCheckbox"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonInternal = CoD.Social_PlayersListButtonShared.new(f1_arg0, f1_arg1, 0, 0, 27.5, 501.5, 0, 0, 0, 40)
	ButtonInternal:mergeStateConditions({
		{
			stateName = "LeaderboardsChecked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.leaderboardsPlayerListActive") and CoD.ModelUtility.IsSelfModelValueTrue(self.NineSliceShaderImage, f1_arg1, "checked")
			end,
		},
		{
			stateName = "LeaderboardsUncheckable",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.leaderboardsPlayerListActive")
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.playersListFull")
					if f3_local0 then
						f3_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.showPlayersList")
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "LeaderboardsUnchecked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("socialRoot.leaderboardsPlayerListActive") and not CoD.ModelUtility.IsSelfModelValueTrue(self.NineSliceShaderImage, f1_arg1, "checked")
			end,
		},
	})
	ButtonInternal:linkToElementModel(ButtonInternal, "primaryPresence", true, function(model)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "primaryPresence",
		})
	end)
	local f1_local2 = ButtonInternal
	local NineSliceShaderImage = ButtonInternal.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	NineSliceShaderImage(f1_local2, f1_local4["socialRoot.leaderboardsPlayerListActive"], function(f6_arg0)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "socialRoot.leaderboardsPlayerListActive",
		})
	end, false)
	ButtonInternal:linkToElementModel(ButtonInternal, "checked", true, function(model)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "checked",
		})
	end)
	f1_local2 = ButtonInternal
	NineSliceShaderImage = ButtonInternal.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	NineSliceShaderImage(f1_local2, f1_local4["socialRoot.playersListFull"], function(f8_arg0)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "socialRoot.playersListFull",
		})
	end, false)
	f1_local2 = ButtonInternal
	NineSliceShaderImage = ButtonInternal.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	NineSliceShaderImage(f1_local2, f1_local4["socialRoot.showPlayersList"], function(f9_arg0)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "socialRoot.showPlayersList",
		})
	end, false)
	ButtonInternal:linkToElementModel(ButtonInternal, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	f1_local2 = ButtonInternal
	NineSliceShaderImage = ButtonInternal.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	NineSliceShaderImage(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ButtonInternal:linkToElementModel(ButtonInternal, "xuid", true, function(model)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	ButtonInternal:linkToElementModel(ButtonInternal, "presence", true, function(model)
		f1_arg0:updateElementState(ButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "presence",
		})
	end)
	ButtonInternal:linkToElementModel(self, nil, false, function(model)
		ButtonInternal:setModel(model, f1_arg1)
	end)
	self:addElement(ButtonInternal)
	self.ButtonInternal = ButtonInternal
	NineSliceShaderImage = CoD.CommonCheckbox.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 0, 0, 0, 40)
	NineSliceShaderImage:mergeStateConditions({
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "checked")
			end,
		},
	})
	NineSliceShaderImage:linkToElementModel(NineSliceShaderImage, "checked", true, function(model)
		f1_arg0:updateElementState(NineSliceShaderImage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "checked",
		})
	end)
	NineSliceShaderImage:linkToElementModel(self, nil, false, function(model)
		NineSliceShaderImage:setModel(model, f1_arg1)
	end)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "xuid", Engine[0x9073FBE2D48C156]("0"))
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	self:linkToElementModel(self, "checked", true, function(model, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(self, controller, "checked") and not IsCurrentMenu(menu, "Leaderboards_PlayersList") then
			CoD.SocialUtility.ToggleInviteCheckbox(controller, self)
			return true
		elseif IsPC() and not IsCurrentMenu(menu, "Leaderboards_PlayersList") then
			CoD.SocialUtility.ToggleInviteCheckbox(controller, self)
			return true
		elseif IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(self, controller, "checked") and IsCurrentMenu(menu, "Leaderboards_PlayersList") then
			CoD.SocialUtility.ToggleAddCheckbox(controller, self)
			return true
		elseif IsPC() and IsCurrentMenu(menu, "Leaderboards_PlayersList") then
			CoD.SocialUtility.ToggleAddCheckbox(controller, self)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(self, controller, "checked") and not IsCurrentMenu(menu, "Leaderboards_PlayersList") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsPC() and not IsCurrentMenu(menu, "Leaderboards_PlayersList") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsPC() and CoD.ModelUtility.IsSelfModelValueTrue(self, controller, "checked") and IsCurrentMenu(menu, "Leaderboards_PlayersList") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsPC() and IsCurrentMenu(menu, "Leaderboards_PlayersList") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	ButtonInternal.id = "ButtonInternal"
	if CoD.isPC then
		NineSliceShaderImage.id = "NineSliceShaderImage"
	end
	self.__defaultFocus = ButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local2 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PlayersListButtonWithCheckbox.__resetProperties = function(f23_arg0)
	f23_arg0.NineSliceShaderImage:completeAnimation()
	f23_arg0.NineSliceShaderImage:setAlpha(1)
end
CoD.Social_PlayersListButtonWithCheckbox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.NineSliceShaderImage:completeAnimation()
			f25_arg0.NineSliceShaderImage:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.NineSliceShaderImage)
		end,
	},
}
CoD.Social_PlayersListButtonWithCheckbox.__onClose = function(f26_arg0)
	f26_arg0.ButtonInternal:close()
	f26_arg0.NineSliceShaderImage:close()
end
