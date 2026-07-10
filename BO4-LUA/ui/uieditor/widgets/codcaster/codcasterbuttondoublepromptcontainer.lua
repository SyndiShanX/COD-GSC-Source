require("x64:e82e6931d003ae7")
CoD.CodCasterButtonDoublePromptContainer = InheritFrom(LUI.UIElement)
CoD.CodCasterButtonDoublePromptContainer.__defaultWidth = 264
CoD.CodCasterButtonDoublePromptContainer.__defaultHeight = 38
CoD.CodCasterButtonDoublePromptContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CodCasterButtonDoublePromptContainer)
	self.id = "CodCasterButtonDoublePromptContainer"
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
	local Text = Prompt
	local Prompt2 = Prompt.subscribeToModel
	local f1_local4 = DataSources.FreeCursor.getModel(f1_arg1)
	Prompt2(Text, f1_local4.usingCursorInput, function(f5_arg0)
		f1_arg0:updateElementState(Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	Text = Prompt
	Prompt2 = Prompt.subscribeToModel
	f1_local4 = DataSources.FreeCursor.getModel(f1_arg1)
	Prompt2(Text, f1_local4.hidden, function(f6_arg0)
		f1_arg0:updateElementState(Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	Text = Prompt
	Prompt2 = Prompt.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Prompt2(Text, f1_local4.activeKeys, function(f7_arg0)
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
	Text = Prompt
	Prompt2 = Prompt.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Prompt2(Text, f1_local4.LastInput, function(f10_arg0)
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
	Prompt2 = CoD.CodCasterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 160, 310, 0.5, 0.5, -24, 24)
	Prompt2:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	Prompt2:linkToElementModel(Prompt2, nil, true, function(model)
		f1_arg0:updateElementState(Prompt2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	f1_local4 = Prompt2
	Text = Prompt2.subscribeToModel
	local f1_local5 = DataSources.FreeCursor.getModel(f1_arg1)
	Text(f1_local4, f1_local5.usingCursorInput, function(f13_arg0)
		f1_arg0:updateElementState(Prompt2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local4 = Prompt2
	Text = Prompt2.subscribeToModel
	f1_local5 = DataSources.FreeCursor.getModel(f1_arg1)
	Text(f1_local4, f1_local5.hidden, function(f14_arg0)
		f1_arg0:updateElementState(Prompt2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local4 = Prompt2
	Text = Prompt2.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Text(f1_local4, f1_local5.activeKeys, function(f15_arg0)
		f1_arg0:updateElementState(Prompt2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	Prompt2:linkToElementModel(Prompt2, "flags", true, function(model)
		f1_arg0:updateElementState(Prompt2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	Prompt2:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(Prompt2, f17_arg1)
	end)
	f1_local4 = Prompt2
	Text = Prompt2.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	Text(f1_local4, f1_local5.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(Prompt2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:addElement(Prompt2)
	self.Prompt2 = Prompt2
	Text = LUI.UIText.new(0, 0, 320, 486, 0.5, 0.5, -8, 8)
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
	if CoD.isPC then
		Prompt2.id = "Prompt2"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	f1_local4 = Text
	if IsPC() then
		CoD.PCWidgetUtility.EnableShrinkToFit(f1_local4)
	end
	return self
end
CoD.CodCasterButtonDoublePromptContainer.__resetProperties = function(f20_arg0)
	f20_arg0.Text:completeAnimation()
	f20_arg0.Prompt:completeAnimation()
	f20_arg0.Text:setAlpha(1)
	f20_arg0.Prompt:setAlpha(1)
end
CoD.CodCasterButtonDoublePromptContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.Prompt:completeAnimation()
			f22_arg0.Prompt:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Prompt)
			f22_arg0.Text:completeAnimation()
			f22_arg0.Text:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Text)
		end,
	},
}
CoD.CodCasterButtonDoublePromptContainer.__onClose = function(f23_arg0)
	f23_arg0.Prompt:close()
	f23_arg0.Prompt2:close()
	f23_arg0.Text:close()
end
