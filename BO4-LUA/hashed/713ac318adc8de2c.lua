require("x64:246178cf189051b")
CoD.SpawnPromptContainer = InheritFrom(LUI.UIElement)
CoD.SpawnPromptContainer.__defaultWidth = 20
CoD.SpawnPromptContainer.__defaultHeight = 20
CoD.SpawnPromptContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnPromptContainer)
	self.id = "SpawnPromptContainer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Icon:setAlpha(0)
	Icon:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local KeyPrompt = nil
	KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	KeyPrompt:setAlpha(0)
	KeyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](@"key/space"))
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnBeaconPromptHidden(f1_arg1, element)
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnPromptContainer.__resetProperties = function(f8_arg0)
	f8_arg0.KeyPrompt:completeAnimation()
	f8_arg0.Icon:completeAnimation()
	f8_arg0.KeyPrompt:setAlpha(0)
	f8_arg0.Icon:setAlpha(0)
end
CoD.SpawnPromptContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Icon:completeAnimation()
			f10_arg0.Icon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Icon)
			f10_arg0.KeyPrompt:completeAnimation()
			f10_arg0.KeyPrompt:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.KeyPrompt)
		end,
	},
	KBM = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Icon:completeAnimation()
			f11_arg0.Icon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Icon)
			f11_arg0.KeyPrompt:completeAnimation()
			f11_arg0.KeyPrompt:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.KeyPrompt)
		end,
	},
	Gamepad = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.Icon:completeAnimation()
			f12_arg0.Icon:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Icon)
			f12_arg0.KeyPrompt:completeAnimation()
			f12_arg0.KeyPrompt:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.KeyPrompt)
		end,
	},
}
CoD.SpawnPromptContainer.__onClose = function(f13_arg0)
	f13_arg0.Icon:close()
	f13_arg0.KeyPrompt:close()
end
