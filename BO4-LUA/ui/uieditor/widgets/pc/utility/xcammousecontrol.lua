CoD.XCamMouseControl = InheritFrom(LUI.UIElement)
CoD.XCamMouseControl.__defaultWidth = 750
CoD.XCamMouseControl.__defaultHeight = 600
CoD.XCamMouseControl.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.XCamMouseControl)
	self.id = "XCamMouseControl"
	self.soundSet = "CAC_EditLoadout"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local debugImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -2, 0)
	debugImage:setAlpha(0)
	self:addElement(debugImage)
	self.debugImage = debugImage
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
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	if IsPC() then
		CoD.PCUtility.SetupXCamMouseControlWidget(self)
		DisableKeyboardNavigationByElement(self)
		SetProperty(self, "__xcamRotationWidget", true)
	end
	return self
end
CoD.XCamMouseControl.__resetProperties = function(f5_arg0)
	f5_arg0.debugImage:completeAnimation()
	f5_arg0.debugImage:setAlpha(0)
end
CoD.XCamMouseControl.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.debugImage:completeAnimation()
			f7_arg0.debugImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.debugImage)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
if not CoD.isPC then
	CoD.XCamMouseControl.__clipsPerState.DefaultState.Focus = nil
end
