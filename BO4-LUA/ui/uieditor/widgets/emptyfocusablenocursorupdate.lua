CoD.emptyFocusableNoCursorUpdate = InheritFrom(LUI.UIElement)
CoD.emptyFocusableNoCursorUpdate.__defaultWidth = 1920
CoD.emptyFocusableNoCursorUpdate.__defaultHeight = 1080
CoD.emptyFocusableNoCursorUpdate.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "_yieldFocus", true)
	SetProperty(self, "__forceCursorTypeNormal", true)
	SetProperty(self, "ignorePlaySound", true)
	self:setClass(CoD.emptyFocusableNoCursorUpdate)
	self.id = "emptyFocusableNoCursorUpdate"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local spacer = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	spacer:setAlpha(0)
	self:addElement(spacer)
	self.spacer = spacer
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsGamepadOrKeyboardNavigation(f1_arg1)
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
CoD.emptyFocusableNoCursorUpdate.__resetProperties = function(f5_arg0)
	f5_arg0.spacer:completeAnimation()
	f5_arg0.spacer:setAlpha(0)
end
CoD.emptyFocusableNoCursorUpdate.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.spacer:completeAnimation()
			f7_arg0.spacer:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.spacer)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
