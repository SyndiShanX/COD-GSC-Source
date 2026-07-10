require("x64:486d4604dba2b91")
CoD.lmgInfiniteReticle_UI3D = InheritFrom(LUI.UIElement)
CoD.lmgInfiniteReticle_UI3D.__defaultWidth = 321
CoD.lmgInfiniteReticle_UI3D.__defaultHeight = 138
CoD.lmgInfiniteReticle_UI3D.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.lmgInfiniteReticle_UI3D)
	self.id = "lmgInfiniteReticle_UI3D"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local internal = CoD.lmgInfiniteReticle_UI3D_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Engine[@"setupui3dwindow"](f1_arg1, 3, 321, 138)
	internal:setUI3DWindow(3)
	internal:linkToElementModel(self, nil, false, function(model)
		internal:setModel(model, f1_arg1)
	end)
	self:addElement(internal)
	self.internal = internal
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.lmgInfiniteReticle_UI3D.__resetProperties = function(f5_arg0)
	f5_arg0.internal:completeAnimation()
	f5_arg0.internal:setAlpha(1)
end
CoD.lmgInfiniteReticle_UI3D.__clipsPerState = {
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
			f7_arg0.internal:completeAnimation()
			f7_arg0.internal:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.internal)
		end,
	},
}
CoD.lmgInfiniteReticle_UI3D.__onClose = function(f8_arg0)
	f8_arg0.internal:close()
end
