CoD.PC_KillCamHint = InheritFrom(LUI.UIElement)
CoD.PC_KillCamHint.__defaultWidth = 1712
CoD.PC_KillCamHint.__defaultHeight = 30
CoD.PC_KillCamHint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_KillCamHint)
	self.id = "PC_KillCamHint"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PcHint = nil
	PcHint = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	PcHint:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	PcHint:setTTF("ttmussels_regular")
	PcHint:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041]))
	self:addElement(PcHint)
	self.PcHint = PcHint
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsMouseOrKeyboard(f1_arg1)
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
CoD.PC_KillCamHint.__resetProperties = function(f5_arg0)
	f5_arg0.PcHint:completeAnimation()
	f5_arg0.PcHint:setAlpha(1)
end
CoD.PC_KillCamHint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.PcHint:completeAnimation()
			f7_arg0.PcHint:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.PcHint)
		end,
	},
}
