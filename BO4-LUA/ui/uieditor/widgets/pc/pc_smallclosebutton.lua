CoD.PC_SmallCloseButton = InheritFrom(LUI.UIElement)
CoD.PC_SmallCloseButton.__defaultWidth = 20
CoD.PC_SmallCloseButton.__defaultHeight = 20
CoD.PC_SmallCloseButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_SmallCloseButton)
	self.id = "PC_SmallCloseButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CloseIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CloseIcon:setAlpha(0.5)
	CloseIcon:setImage(RegisterImage("uie_close_icon"))
	self:addElement(CloseIcon)
	self.CloseIcon = CloseIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f3_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_SmallCloseButton.__resetProperties = function(f5_arg0)
	f5_arg0.CloseIcon:completeAnimation()
	f5_arg0.CloseIcon:setAlpha(0.5)
	f5_arg0.CloseIcon:setScale(1, 1)
end
CoD.PC_SmallCloseButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.CloseIcon:completeAnimation()
			f6_arg0.CloseIcon:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.CloseIcon)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.CloseIcon:completeAnimation()
			f7_arg0.CloseIcon:setAlpha(1)
			f7_arg0.CloseIcon:setScale(1.3, 1.3)
			f7_arg0.clipFinished(f7_arg0.CloseIcon)
		end,
		GainFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CloseIcon:beginAnimation(80)
				f8_arg0.CloseIcon:setAlpha(1)
				f8_arg0.CloseIcon:setScale(1.3, 1.3)
				f8_arg0.CloseIcon:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CloseIcon:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CloseIcon:completeAnimation()
			f8_arg0.CloseIcon:setAlpha(0.5)
			f8_arg0.CloseIcon:setScale(1, 1)
			f8_local0(f8_arg0.CloseIcon)
		end,
		LoseFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.CloseIcon:beginAnimation(80)
				f10_arg0.CloseIcon:setAlpha(0.5)
				f10_arg0.CloseIcon:setScale(1, 1)
				f10_arg0.CloseIcon:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.CloseIcon:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.CloseIcon:completeAnimation()
			f10_arg0.CloseIcon:setAlpha(1)
			f10_arg0.CloseIcon:setScale(1.3, 1.3)
			f10_local0(f10_arg0.CloseIcon)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.CloseIcon:completeAnimation()
			f12_arg0.CloseIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CloseIcon)
		end,
	},
}
