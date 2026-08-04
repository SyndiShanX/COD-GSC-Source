CoD.fe_NAT = InheritFrom(LUI.UIElement)
CoD.fe_NAT.__defaultWidth = 198
CoD.fe_NAT.__defaultHeight = 30
CoD.fe_NAT.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.fe_NAT)
	self.id = "fe_NAT"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Nat = LUI.UIText.new(0, 0, 0, 289, 0, 0, 5, 25)
	Nat:setTTF("ttmussels_regular")
	Nat:setLetterSpacing(6)
	Nat:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Nat:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	Nat:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyNatType", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Nat:setText(ConvertToUpperString(LocalizeWithNatType(f2_local0)))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(Nat, "setText", function(element, controller)
		ScaleWidgetToLabelRightAligned(self, element, 0)
	end)
	self:addElement(Nat)
	self.Nat = Nat
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsLAN()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetGlobalModel()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNetworkMode"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine.GetGlobalModel()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.fe_NAT.__resetProperties = function(f7_arg0)
	f7_arg0.Nat:completeAnimation()
	f7_arg0.Nat:setAlpha(1)
end
CoD.fe_NAT.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Nat:completeAnimation()
			f9_arg0.Nat:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Nat)
		end,
	},
}
CoD.fe_NAT.__onClose = function(f10_arg0)
	f10_arg0.Nat:close()
end
