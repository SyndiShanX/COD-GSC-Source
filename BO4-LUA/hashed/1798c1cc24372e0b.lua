CoD.PC_VodViewerQuitButton = InheritFrom(LUI.UIElement)
CoD.PC_VodViewerQuitButton.__defaultWidth = 50
CoD.PC_VodViewerQuitButton.__defaultHeight = 50
CoD.PC_VodViewerQuitButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_VodViewerQuitButton)
	self.id = "PC_VodViewerQuitButton"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BTNQuit = LUI.UIImage.new(0.98, 0.98, -49, 1, 0.02, 0.02, -1, 49)
	BTNQuit:setImage(RegisterImage(0x9ECB977BE93F2AB))
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	self:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
		{
			stateName = "HiddenUnskippable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable")
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4.cutsceneSkippable, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "cutsceneSkippable",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_VodViewerQuitButton.__resetProperties = function(f7_arg0)
	f7_arg0.BTNQuit:completeAnimation()
	f7_arg0.BTNQuit:setAlpha(1)
end
CoD.PC_VodViewerQuitButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.BTNQuit:completeAnimation()
			f9_arg0.clipFinished(f9_arg0.BTNQuit)
		end,
	},
	Gamepad = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.BTNQuit:completeAnimation()
			f10_arg0.BTNQuit:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BTNQuit)
		end,
	},
	HiddenUnskippable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.BTNQuit:completeAnimation()
			f11_arg0.BTNQuit:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BTNQuit)
		end,
	},
}
