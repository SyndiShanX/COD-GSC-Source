require("x64:9d631a7a85e5f82")
CoD.grenadeWarning = InheritFrom(LUI.UIElement)
CoD.grenadeWarning.__defaultWidth = 130
CoD.grenadeWarning.__defaultHeight = 180
CoD.grenadeWarning.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.grenadeWarning)
	self.id = "grenadeWarning"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local grenadeWarningInternal = CoD.grenadeWarning_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	grenadeWarningInternal:linkToElementModel(self, nil, false, function(model)
		grenadeWarningInternal:setModel(model, f1_arg1)
	end)
	self:addElement(grenadeWarningInternal)
	self.grenadeWarningInternal = grenadeWarningInternal
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CallCustomElementFunction_Element(element, "setupGrenadeWarning", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.ZombieUtility.TrialsNoHudPostLoad(self, f1_arg1, f1_arg0)
	return self
end
CoD.grenadeWarning.__resetProperties = function(f4_arg0)
	f4_arg0.grenadeWarningInternal:completeAnimation()
	f4_arg0.grenadeWarningInternal:setAlpha(1)
end
CoD.grenadeWarning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.grenadeWarningInternal:completeAnimation()
			f6_arg0.grenadeWarningInternal:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.grenadeWarningInternal)
		end,
	},
}
CoD.grenadeWarning.__onClose = function(f7_arg0)
	f7_arg0.grenadeWarningInternal:close()
end
