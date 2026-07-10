require("x64:341ce33d59fafd1")
require("x64:c894f1061c2c2a8")
require("x64:2190adaba331dcb")
CoD.PositionDraft_FocusedCharacterInfo = InheritFrom(LUI.UIElement)
CoD.PositionDraft_FocusedCharacterInfo.__defaultWidth = 1201
CoD.PositionDraft_FocusedCharacterInfo.__defaultHeight = 210
CoD.PositionDraft_FocusedCharacterInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_FocusedCharacterInfo)
	self.id = "PositionDraft_FocusedCharacterInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SignatureEquipment = CoD.StartMenu_SignatureItem.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 94, 209)
	SignatureEquipment:setZoom(10)
	SignatureEquipment:linkToElementModel(self, "ability", false, function(model)
		SignatureEquipment:setModel(model, f1_arg1)
	end)
	self:addElement(SignatureEquipment)
	self.SignatureEquipment = SignatureEquipment
	local SignatureAbility = CoD.StartMenu_SignatureItem.new(f1_arg0, f1_arg1, 0, 0, 566, 1106, 0, 0, 94, 209)
	SignatureAbility:setZoom(10)
	SignatureAbility:linkToElementModel(self, "equipment", false, function(model)
		SignatureAbility:setModel(model, f1_arg1)
	end)
	self:addElement(SignatureAbility)
	self.SignatureAbility = SignatureAbility
	local FocusedCharacterName = CoD.PositionDraft_FocusedCharacterName.new(f1_arg0, f1_arg1, 0, 0, -12, 666, 0, 0, -1, 62)
	FocusedCharacterName:linkToElementModel(self, nil, false, function(model)
		FocusedCharacterName:setModel(model, f1_arg1)
	end)
	self:addElement(FocusedCharacterName)
	self.FocusedCharacterName = FocusedCharacterName
	local RestrictedText = CoD.RestrictedItemWarningText.new(f1_arg0, f1_arg1, 0.5, 0.5, -293, 201, 0.5, 0.5, -58, -28)
	RestrictedText:mergeStateConditions({
		{
			stateName = "CharacterRestricted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PositionDraft.focusedCharacterIsRestricted") and CoD.HUDUtility.IsGameTypeCWL()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f6_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f6_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PositionDraft.focusedCharacterHasRestriction")
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
	})
	local f1_local5 = RestrictedText
	local f1_local6 = RestrictedText.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["PositionDraft.focusedCharacterIsRestricted"], function(f7_arg0)
		f1_arg0:updateElementState(RestrictedText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "PositionDraft.focusedCharacterIsRestricted",
		})
	end, false)
	f1_local5 = RestrictedText
	f1_local6 = RestrictedText.subscribeToModel
	f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(RestrictedText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local5 = RestrictedText
	f1_local6 = RestrictedText.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["PositionDraft.focusedCharacterHasRestriction"], function(f9_arg0)
		f1_arg0:updateElementState(RestrictedText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "PositionDraft.focusedCharacterHasRestriction",
		})
	end, false)
	RestrictedText:linkToElementModel(self, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "PositionDraft.focusedCharacterIndex", 0)
			end,
		},
	})
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["PositionDraft.focusedCharacterIndex"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "PositionDraft.focusedCharacterIndex",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_FocusedCharacterInfo.__resetProperties = function(f13_arg0)
	f13_arg0.SignatureEquipment:completeAnimation()
	f13_arg0.SignatureAbility:completeAnimation()
	f13_arg0.FocusedCharacterName:completeAnimation()
	f13_arg0.SignatureEquipment:setAlpha(1)
	f13_arg0.SignatureAbility:setAlpha(1)
	f13_arg0.FocusedCharacterName:setAlpha(1)
end
CoD.PositionDraft_FocusedCharacterInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.SignatureEquipment:completeAnimation()
			f14_arg0.SignatureEquipment:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.SignatureEquipment)
			f14_arg0.SignatureAbility:completeAnimation()
			f14_arg0.SignatureAbility:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.SignatureAbility)
			f14_arg0.FocusedCharacterName:completeAnimation()
			f14_arg0.FocusedCharacterName:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.FocusedCharacterName)
		end,
	},
	Visible = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.PositionDraft_FocusedCharacterInfo.__onClose = function(f16_arg0)
	f16_arg0.SignatureEquipment:close()
	f16_arg0.SignatureAbility:close()
	f16_arg0.FocusedCharacterName:close()
	f16_arg0.RestrictedText:close()
end
