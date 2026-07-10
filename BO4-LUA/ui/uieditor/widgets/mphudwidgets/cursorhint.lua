require("x64:f952907358e6c55")
CoD.CursorHint = InheritFrom(LUI.UIElement)
CoD.CursorHint.__defaultWidth = 750
CoD.CursorHint.__defaultHeight = 135
CoD.CursorHint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 22, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.CursorHint)
	self.id = "CursorHint"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local cursorhinttext0 = CoD.cursorhint_text.new(f1_arg0, f1_arg1, 0.5, 0.5, -361, 183, 0, 0, 0, 28)
	self:addElement(cursorhinttext0)
	self.cursorhinttext0 = cursorhinttext0
	local cursorHintImage = LUI.UIFixedAspectRatioImage.new(0, 0, 580, 736, 0, 0, -26.5, 54.5)
	cursorHintImage:setStretchedDimension(0)
	cursorHintImage:subscribeToGlobalModel(f1_arg1, "HUDItems", "cursorHintImage", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			cursorHintImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(cursorHintImage)
	self.cursorHintImage = cursorHintImage
	self:mergeStateConditions({
		{
			stateName = "Active_NoImage",
			condition = function(menu, element, event)
				local f3_local0 = IsCursorHintActive(f1_arg1)
				if f3_local0 then
					if
						not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f3_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "cursorHintImage", 0x7615068F50B3D66)
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f4_local0 = IsCursorHintActive(f1_arg1)
				if f4_local0 then
					if
						not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
					then
						f4_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.showCursorHint"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.showCursorHint",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.inventory.open"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.cursorHintImage, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "cursorHintImage",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CursorHint.__resetProperties = function(f22_arg0)
	f22_arg0.cursorhinttext0:completeAnimation()
	f22_arg0.cursorHintImage:completeAnimation()
	f22_arg0.cursorhinttext0:setAlpha(1)
	f22_arg0.cursorHintImage:setAlpha(1)
end
CoD.CursorHint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.cursorhinttext0:completeAnimation()
			f23_arg0.cursorhinttext0:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.cursorhinttext0)
			f23_arg0.cursorHintImage:completeAnimation()
			f23_arg0.cursorHintImage:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.cursorHintImage)
		end,
		Active = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.cursorhinttext0:beginAnimation(300)
				f24_arg0.cursorhinttext0:setAlpha(1)
				f24_arg0.cursorhinttext0:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.cursorhinttext0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.cursorhinttext0:completeAnimation()
			f24_arg0.cursorhinttext0:setAlpha(0.44)
			f24_local0(f24_arg0.cursorhinttext0)
			local f24_local1 = function(f26_arg0)
				f24_arg0.cursorHintImage:beginAnimation(300)
				f24_arg0.cursorHintImage:setAlpha(1)
				f24_arg0.cursorHintImage:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.cursorHintImage:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.cursorHintImage:completeAnimation()
			f24_arg0.cursorHintImage:setAlpha(0.44)
			f24_local1(f24_arg0.cursorHintImage)
		end,
		Active_NoImage = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.cursorhinttext0:beginAnimation(300)
				f27_arg0.cursorhinttext0:setAlpha(1)
				f27_arg0.cursorhinttext0:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.cursorhinttext0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.cursorhinttext0:completeAnimation()
			f27_arg0.cursorhinttext0:setAlpha(0.45)
			f27_local0(f27_arg0.cursorhinttext0)
			f27_arg0.cursorHintImage:completeAnimation()
			f27_arg0.cursorHintImage:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.cursorHintImage)
		end,
	},
	Active_NoImage = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.cursorhinttext0:completeAnimation()
			f29_arg0.cursorhinttext0:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.cursorhinttext0)
			f29_arg0.cursorHintImage:completeAnimation()
			f29_arg0.cursorHintImage:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.cursorHintImage)
		end,
	},
	Active = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.cursorhinttext0:completeAnimation()
			f30_arg0.cursorhinttext0:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.cursorhinttext0)
			f30_arg0.cursorHintImage:completeAnimation()
			f30_arg0.cursorHintImage:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.cursorHintImage)
		end,
		DefaultState = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			local f31_local0 = function(f32_arg0)
				f31_arg0.cursorhinttext0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f31_arg0.cursorhinttext0:setAlpha(0)
				f31_arg0.cursorhinttext0:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.cursorhinttext0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.cursorhinttext0:completeAnimation()
			f31_arg0.cursorhinttext0:setAlpha(1)
			f31_local0(f31_arg0.cursorhinttext0)
			local f31_local1 = function(f33_arg0)
				f31_arg0.cursorHintImage:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f31_arg0.cursorHintImage:setAlpha(0)
				f31_arg0.cursorHintImage:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.cursorHintImage:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.cursorHintImage:completeAnimation()
			f31_arg0.cursorHintImage:setAlpha(1)
			f31_local1(f31_arg0.cursorHintImage)
		end,
	},
}
CoD.CursorHint.__onClose = function(f34_arg0)
	f34_arg0.cursorhinttext0:close()
	f34_arg0.cursorHintImage:close()
end
