require("x64:52a2876f7f96010")
CoD.AttackerVictimInfoBar_Container = InheritFrom(LUI.UIElement)
CoD.AttackerVictimInfoBar_Container.__defaultWidth = 1920
CoD.AttackerVictimInfoBar_Container.__defaultHeight = 180
CoD.AttackerVictimInfoBar_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttackerVictimInfoBar_Container)
	self.id = "AttackerVictimInfoBar_Container"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AttackerVictimInfoBar = CoD.AttackerVictimInfoBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -90, 90)
	AttackerVictimInfoBar:setAlpha(0)
	self:addElement(AttackerVictimInfoBar)
	self.AttackerVictimInfoBar = AttackerVictimInfoBar
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.killedByMOD", Enum[0x52177B239BFECC1][0x2C99EB591CE8EB6]) and not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.killedByMOD", Enum[0x52177B239BFECC1][0xEBD7B5999BC11B0]) then
					f2_local0 = not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.killedByMOD", Enum[0x52177B239BFECC1][0x6EF8543A25EF511])
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.killedByMOD"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.killedByMOD",
		})
	end, false)
	AttackerVictimInfoBar.id = "AttackerVictimInfoBar"
	self.__defaultFocus = AttackerVictimInfoBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AttackerVictimInfoBar_Container.__resetProperties = function(f4_arg0)
	f4_arg0.AttackerVictimInfoBar:completeAnimation()
	f4_arg0.AttackerVictimInfoBar:setAlpha(0)
end
CoD.AttackerVictimInfoBar_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.AttackerVictimInfoBar:completeAnimation()
			f6_arg0.AttackerVictimInfoBar:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.AttackerVictimInfoBar)
		end,
	},
}
CoD.AttackerVictimInfoBar_Container.__onClose = function(f7_arg0)
	f7_arg0.AttackerVictimInfoBar:close()
end
