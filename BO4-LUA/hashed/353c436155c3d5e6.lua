require("x64:c01c702d0c9c363")
CoD.AARContractsTab = InheritFrom(LUI.UIElement)
CoD.AARContractsTab.__defaultWidth = 1920
CoD.AARContractsTab.__defaultHeight = 900
CoD.AARContractsTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARContractsTab)
	self.id = "AARContractsTab"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AARContractsTabInternal = CoD.AARContractsTabInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	self:addElement(AARContractsTabInternal)
	self.AARContractsTabInternal = AARContractsTabInternal
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_CONTRACTS)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["AAR.activeTab"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	AARContractsTabInternal.id = "AARContractsTabInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARContractsTab.__resetProperties = function(f4_arg0)
	f4_arg0.AARContractsTabInternal:completeAnimation()
	f4_arg0.AARContractsTabInternal:setAlpha(1)
end
CoD.AARContractsTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.AARContractsTabInternal:completeAnimation()
			f5_arg0.AARContractsTabInternal:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.AARContractsTabInternal)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.AARContractsTabInternal:completeAnimation()
			f6_arg0.AARContractsTabInternal:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.AARContractsTabInternal)
		end,
	},
}
CoD.AARContractsTab.__onClose = function(f7_arg0)
	f7_arg0.AARContractsTabInternal:close()
end
