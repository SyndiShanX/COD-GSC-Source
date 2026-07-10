require("x64:213d6270090adf7")
CoD.PCStartMenuOptionsUnbindKeybindMessage = InheritFrom(LUI.UIElement)
CoD.PCStartMenuOptionsUnbindKeybindMessage.__defaultWidth = 126
CoD.PCStartMenuOptionsUnbindKeybindMessage.__defaultHeight = 24
CoD.PCStartMenuOptionsUnbindKeybindMessage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCStartMenuOptionsUnbindKeybindMessage)
	self.id = "PCStartMenuOptionsUnbindKeybindMessage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 0, 0, 126, 0, 1, 0, 0)
	TextBox:setRGB(0.76, 0.76, 0.76)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_37C0D99E99809ED"))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCStartMenuOptionsUnbindKeybindMessage.__resetProperties = function(f6_arg0)
	f6_arg0.TextBox:completeAnimation()
	f6_arg0.TextBox:setAlpha(1)
end
CoD.PCStartMenuOptionsUnbindKeybindMessage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Gamepad = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TextBox)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.TextBox:completeAnimation()
			f9_arg0.TextBox:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TextBox)
		end,
	},
}
