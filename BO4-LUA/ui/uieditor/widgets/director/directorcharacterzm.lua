require("x64:f3b71d7ea8417f2")
require("x64:51a3136d617a48d")
CoD.DirectorCharacterZM = InheritFrom(LUI.UIElement)
CoD.DirectorCharacterZM.__defaultWidth = 240
CoD.DirectorCharacterZM.__defaultHeight = 44
CoD.DirectorCharacterZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if CoD.DirectorUtility.IsSessionModeAvailable(f1_arg1, Enum[@"emodes"][@"mode_zombies"]) and CoD.ZombieUtility.ShowZMLobbyPoseOptions() then
		CoD.BaseUtility.InitControllerModel(f1_arg1, "PositionDraft.autoSelected", -1)
		CoD.BaseUtility.CreateControllerModel(f1_arg1, "PositionDraft.stage")
		CoD.BaseUtility.CreateControllerModel(f1_arg1, "PositionDraft.focusedCharacterIndex")
		SetControllerModelValue(f1_arg1, "PositionDraft.focusedCharacterIndex", -1)
		CoD.BaseUtility.CreateGlobalModel("lobbyRoot.publicLobby.stage")
	else
		CoD.BaseUtility.CreateGlobalModel("lobbyRoot.publicLobby.stage")
	end
	self:setClass(CoD.DirectorCharacterZM)
	self.id = "DirectorCharacterZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ClientClanGamertag = CoD.DirectorLobbyClientGamertag.new(f1_arg0, f1_arg1, 0.5, 0.5, -148, 148, 0, 0, 4.5, 37.5)
	ClientClanGamertag:linkToElementModel(self, "info", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClientClanGamertag:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(ClientClanGamertag)
	self.ClientClanGamertag = ClientClanGamertag
	local ZMReadyUp = CoD.ZMReadyUp.new(f1_arg0, f1_arg1, 0, 0, 20, 220, 0, 0, -24, 0)
	ZMReadyUp:linkToElementModel(self, "info", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ZMReadyUp:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(ZMReadyUp)
	self.ZMReadyUp = ZMReadyUp
	self:mergeStateConditions({
		{
			stateName = "InvalidInfo",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsInvalidLobbyClientInfo(element, "info")
			end,
		},
		{
			stateName = "Visible3DModelNoReady",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "visible") and CoD.DirectorUtility.InReadyStage(f1_arg1)
			end,
		},
		{
			stateName = "Visible3DModel",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "visible")
			end,
		},
	})
	self:linkToElementModel(self, "info", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "info",
		})
	end)
	self:linkToElementModel(self, "visible", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "visible",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.publicLobby.stage"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	if CoD.DirectorUtility.IsSessionModeAvailable(f1_arg1, Enum[@"emodes"][@"mode_zombies"]) and CoD.ZombieUtility.ShowZMLobbyPoseOptions() then
		CoD.PlayerRoleUtility.PositionDraftClientsSizeOverride(self, f1_arg1)
	end
	return self
end
CoD.DirectorCharacterZM.__resetProperties = function(f11_arg0)
	f11_arg0.ClientClanGamertag:completeAnimation()
	f11_arg0.ZMReadyUp:completeAnimation()
	f11_arg0.ClientClanGamertag:setAlpha(1)
	f11_arg0.ZMReadyUp:setAlpha(1)
end
CoD.DirectorCharacterZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.ClientClanGamertag:completeAnimation()
			f12_arg0.ClientClanGamertag:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ClientClanGamertag)
			f12_arg0.ZMReadyUp:completeAnimation()
			f12_arg0.ZMReadyUp:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ZMReadyUp)
		end,
	},
	InvalidInfo = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.ClientClanGamertag:completeAnimation()
			f13_arg0.ClientClanGamertag:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ClientClanGamertag)
			f13_arg0.ZMReadyUp:completeAnimation()
			f13_arg0.ZMReadyUp:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ZMReadyUp)
		end,
	},
	Visible3DModelNoReady = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Visible3DModel = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.ZMReadyUp:completeAnimation()
			f15_arg0.ZMReadyUp:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ZMReadyUp)
		end,
	},
}
CoD.DirectorCharacterZM.__onClose = function(f16_arg0)
	f16_arg0.ClientClanGamertag:close()
	f16_arg0.ZMReadyUp:close()
end
