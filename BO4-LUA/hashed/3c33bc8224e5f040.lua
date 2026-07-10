CoD.PC_VoDViewerOverlayResizeButton = InheritFrom(LUI.UIElement)
CoD.PC_VoDViewerOverlayResizeButton.__defaultWidth = 35
CoD.PC_VoDViewerOverlayResizeButton.__defaultHeight = 35
CoD.PC_VoDViewerOverlayResizeButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_VoDViewerOverlayResizeButton)
	self.id = "PC_VoDViewerOverlayResizeButton"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BTNResize = LUI.UIImage.new(0.98, 0.98, -34.5, 0.5, 0.98, 0.98, -34.5, 0.5)
	BTNResize:setImage(RegisterImage(0xD1A05682DF07D9))
	self:addElement(BTNResize)
	self.BTNResize = BTNResize
	self:mergeStateConditions({
		{
			stateName = "Gamepad",
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
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
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
CoD.PC_VoDViewerOverlayResizeButton.__resetProperties = function(f5_arg0)
	f5_arg0.BTNResize:completeAnimation()
	f5_arg0.BTNResize:setAlpha(1)
	f5_arg0.BTNResize:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
end
CoD.PC_VoDViewerOverlayResizeButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.BTNResize:completeAnimation()
			f7_arg0.BTNResize:setMaterial(LUI.UIImage.GetCachedMaterial(0x6B34AA3F39208EF))
			f7_arg0.clipFinished(f7_arg0.BTNResize)
		end,
	},
	Gamepad = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.BTNResize:completeAnimation()
			f8_arg0.BTNResize:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.BTNResize)
		end,
	},
}
