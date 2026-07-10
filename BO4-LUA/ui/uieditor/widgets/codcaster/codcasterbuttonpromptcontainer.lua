require("x64:e82e6931d003ae7")
CoD.CodCasterButtonPromptContainer = InheritFrom(LUI.UIElement)
CoD.CodCasterButtonPromptContainer.__defaultWidth = 264
CoD.CodCasterButtonPromptContainer.__defaultHeight = 38
CoD.CodCasterButtonPromptContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CodCasterButtonPromptContainer)
	self.id = "CodCasterButtonPromptContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Prompt = CoD.CodCasterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 150, 0.5, 0.5, -24, 24)
	Prompt:mergeStateConditions({
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[0xF4865E3551C3835][0x901DFC093ED4187])
				if f2_local0 then
					if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
						f2_local0 = IsMouseOrKeyboard(f1_arg1)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	Prompt:linkToElementModel(Prompt, nil, true, function(model)
		f1_arg0:updateElementState(Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	local f1_local2 = Prompt
	local Text = Prompt.subscribeToModel
	local f1_local4 = DataSources.FreeCursor.getModel(f1_arg1)
	Text(f1_local2, f1_local4.usingCursorInput, function(f5_arg0)
		f1_arg0:updateElementState(Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local2 = Prompt
	Text = Prompt.subscribeToModel
	f1_local4 = DataSources.FreeCursor.getModel(f1_arg1)
	Text(f1_local2, f1_local4.hidden, function(f6_arg0)
		f1_arg0:updateElementState(Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local2 = Prompt
	Text = Prompt.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Text(f1_local2, f1_local4.activeKeys, function(f7_arg0)
		f1_arg0:updateElementState(Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	Prompt:linkToElementModel(Prompt, "flags", true, function(model)
		f1_arg0:updateElementState(Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	Prompt:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(Prompt, f9_arg1)
	end)
	f1_local2 = Prompt
	Text = Prompt.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Text(f1_local2, f1_local4.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:addElement(Prompt)
	self.Prompt = Prompt
	Text = LUI.UIText.new(0, 0, 160, 326, 0.5, 0.5, -8, 8)
	Text:setText(Engine[0xF9F1239CFD921FE](0xA61241CD7E3DE2B))
	Text:setTTF("default")
	Text:setLineSpacing(2)
	Text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Text:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Text)
	self.Text = Text
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if CoD.isPC then
		Prompt.id = "Prompt"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local2 = self
	f1_local2 = Text
	if IsPC() then
		CoD.PCWidgetUtility.EnableShrinkToFit(f1_local2)
	end
	return self
end
CoD.CodCasterButtonPromptContainer.__resetProperties = function(f12_arg0)
	f12_arg0.Text:completeAnimation()
	f12_arg0.Prompt:completeAnimation()
	f12_arg0.Text:setAlpha(1)
	f12_arg0.Prompt:setAlpha(1)
end
CoD.CodCasterButtonPromptContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.Prompt:completeAnimation()
			f14_arg0.Prompt:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Prompt)
			f14_arg0.Text:completeAnimation()
			f14_arg0.Text:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Text)
		end,
	},
}
CoD.CodCasterButtonPromptContainer.__onClose = function(f15_arg0)
	f15_arg0.Prompt:close()
	f15_arg0.Text:close()
end
