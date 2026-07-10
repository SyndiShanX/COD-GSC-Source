require("x64:f3b71d7ea8417f2")
require("x64:a2d871ecfc40de")
CoD.DirectorCharacterDynamic = InheritFrom(LUI.UIElement)
CoD.DirectorCharacterDynamic.__defaultWidth = 240
CoD.DirectorCharacterDynamic.__defaultHeight = 44
CoD.DirectorCharacterDynamic.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCharacterDynamic)
	self.id = "DirectorCharacterDynamic"
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
	local DirectorStickyPartyStatus = CoD.DirectorStickyPartyStatus.new(f1_arg0, f1_arg1, 0, 0, 20, 220, 0, 0, -30, -6)
	DirectorStickyPartyStatus.TextBox.__stickyPartyStatus = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			DirectorStickyPartyStatus.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](StickyPartyStatusToString(f3_local0)))
		end
	end
	DirectorStickyPartyStatus:linkToElementModel(self, "info", true, function(model, f4_arg1)
		if f4_arg1["__DirectorStickyPartyStatus.TextBox.__stickyPartyStatus_info->whereAmI"] then
			f4_arg1:removeSubscription(f4_arg1["__DirectorStickyPartyStatus.TextBox.__stickyPartyStatus_info->whereAmI"])
			f4_arg1["__DirectorStickyPartyStatus.TextBox.__stickyPartyStatus_info->whereAmI"] = nil
		end
		if model then
			local f4_local0 = model:get()
			local f4_local1 = model:get()
			model = f4_local0 and f4_local1.whereAmI
		end
		if model then
			f4_arg1["__DirectorStickyPartyStatus.TextBox.__stickyPartyStatus_info->whereAmI"] = f4_arg1:subscribeToModel(model, DirectorStickyPartyStatus.TextBox.__stickyPartyStatus)
		end
	end)
	self:addElement(DirectorStickyPartyStatus)
	self.DirectorStickyPartyStatus = DirectorStickyPartyStatus
	self:mergeStateConditions({
		{
			stateName = "Visible3DModelWZ",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "visible")
				if f5_local0 then
					f5_local0 = IsWarzone()
					if f5_local0 then
						f5_local0 = not CoD.LobbyUtility.AllMembersInFrontend()
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "Visible3DModel",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "visible") and not IsZombies()
			end,
		},
		{
			stateName = "VisibleAddPrompt",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available")
			end,
		},
	})
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
	f1_local4(f1_local3, f1_local5["lobbyRoot.privateClient.update"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	self:linkToElementModel(self, "available", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorCharacterDynamic.__resetProperties = function(f12_arg0)
	f12_arg0.ClientClanGamertag:completeAnimation()
	f12_arg0.DirectorStickyPartyStatus:completeAnimation()
	f12_arg0.ClientClanGamertag:setAlpha(1)
	f12_arg0.DirectorStickyPartyStatus:setAlpha(1)
end
CoD.DirectorCharacterDynamic.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.ClientClanGamertag:completeAnimation()
			f13_arg0.ClientClanGamertag:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ClientClanGamertag)
			f13_arg0.DirectorStickyPartyStatus:completeAnimation()
			f13_arg0.DirectorStickyPartyStatus:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DirectorStickyPartyStatus)
		end,
	},
	Visible3DModelWZ = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Visible3DModel = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.DirectorStickyPartyStatus:completeAnimation()
			f15_arg0.DirectorStickyPartyStatus:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DirectorStickyPartyStatus)
		end,
	},
	VisibleAddPrompt = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.ClientClanGamertag:completeAnimation()
			f16_arg0.ClientClanGamertag:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ClientClanGamertag)
			f16_arg0.DirectorStickyPartyStatus:completeAnimation()
			f16_arg0.DirectorStickyPartyStatus:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.DirectorStickyPartyStatus)
		end,
	},
}
CoD.DirectorCharacterDynamic.__onClose = function(f17_arg0)
	f17_arg0.ClientClanGamertag:close()
	f17_arg0.DirectorStickyPartyStatus:close()
end
