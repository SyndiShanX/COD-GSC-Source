CoD.WheelTriangleIndicator = InheritFrom(LUI.UIElement)
CoD.WheelTriangleIndicator.__defaultWidth = 24
CoD.WheelTriangleIndicator.__defaultHeight = 24
CoD.WheelTriangleIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WheelTriangleIndicator)
	self.id = "WheelTriangleIndicator"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PointerImage = LUI.UIImage.new(0, 0, 62, 130, 0.5, 0.5, -12, 8)
	PointerImage:setZRot(-90)
	PointerImage:setImage(RegisterImage(0xE08357911B44221))
	self:addElement(PointerImage)
	self.PointerImage = PointerImage
	local PointerImageAdd = LUI.UIImage.new(0, 0, 62, 130, 0.5, 0.5, -12, 8)
	PointerImageAdd:setAlpha(0)
	PointerImageAdd:setZRot(-90)
	PointerImageAdd:setImage(RegisterImage(0xE08357911B44221))
	PointerImageAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PointerImageAdd)
	self.PointerImageAdd = PointerImageAdd
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsWheelPointerVisible(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f3_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.RightStick.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.WheelSelectionEnabled, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "WheelSelectionEnabled",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.LeftStick.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.WheelSelectionEnabled, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "WheelSelectionEnabled",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WheelTriangleIndicator.__resetProperties = function(f7_arg0)
	f7_arg0.PointerImage:completeAnimation()
	f7_arg0.PointerImageAdd:completeAnimation()
	f7_arg0.PointerImage:setAlpha(1)
	f7_arg0.PointerImageAdd:setAlpha(0)
end
CoD.WheelTriangleIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.PointerImage:completeAnimation()
			f8_arg0.PointerImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PointerImage)
		end,
		Visible = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.PointerImage:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f9_arg0.PointerImage:setAlpha(1)
				f9_arg0.PointerImage:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.PointerImage:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.PointerImage:completeAnimation()
			f9_arg0.PointerImage:setAlpha(0)
			f9_local0(f9_arg0.PointerImage)
			f9_arg0.PointerImageAdd:completeAnimation()
			f9_arg0.PointerImageAdd:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PointerImageAdd)
		end,
	},
	Visible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.PointerImage:completeAnimation()
			f11_arg0.PointerImage:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.PointerImage)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f13_arg0:setAlpha(0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.PointerImageAdd:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f11_arg0.PointerImageAdd:setAlpha(0.5)
				f11_arg0.PointerImageAdd:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.PointerImageAdd:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.PointerImageAdd:completeAnimation()
			f11_arg0.PointerImageAdd:setAlpha(0)
			f11_local0(f11_arg0.PointerImageAdd)
			f11_arg0.nextClip = "DefaultClip"
		end,
	},
}
