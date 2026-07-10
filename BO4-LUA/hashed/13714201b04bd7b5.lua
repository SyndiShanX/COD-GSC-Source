require("x64:cee87353c67a42a")
CoD.WZAAR = InheritFrom(LUI.UIElement)
CoD.WZAAR.__defaultWidth = 1920
CoD.WZAAR.__defaultHeight = 1080
CoD.WZAAR.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitPersistentControllerModelIfNotSet(f1_arg1, "seenWZInGameAAR", false)
	CoD.AARUtility.SetupMeritRewardModels(f1_arg0, f1_arg1, false)
	self:setClass(CoD.WZAAR)
	self.id = "WZAAR"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WZAARContainers = CoD.WZAAR_Containers.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	WZAARContainers:setAlpha(0)
	self:addElement(WZAARContainers)
	self.WZAARContainers = WZAARContainers
	local f1_local2 = nil
	f1_local2 = LUI.UIElement.createFake()
	self.emptyFocusable = f1_local2
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.warzone.aarVisible")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.warzone.aarVisible"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.warzone.aarVisible",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsSelfInState(self, "Visible") then
			LockInputHUD(self, controller, true)
			MenuHidesFreeCursor(f1_arg0, controller)
			CoD.AARUtility.SetupMeritRewardModels(f1_arg0, controller, true)
		elseif IsSelfInState(self, "DefaultState") then
			LockInputHUD(self, controller, false)
			SetLoseFocusToSelf(self, controller)
		end
	end)
	WZAARContainers.id = "WZAARContainers"
	f1_local2.id = "emptyFocusable"
	self.__defaultFocus = f1_local2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR.__resetProperties = function(f5_arg0)
	f5_arg0.emptyFocusable:completeAnimation()
	f5_arg0.WZAARContainers:completeAnimation()
	f5_arg0.emptyFocusable:setAlpha(1)
	f5_arg0.WZAARContainers:setAlpha(0)
end
CoD.WZAAR.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.WZAARContainers:completeAnimation()
			f6_arg0.WZAARContainers:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.WZAARContainers)
			f6_arg0.emptyFocusable:completeAnimation()
			f6_arg0.emptyFocusable:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.emptyFocusable)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.WZAARContainers:completeAnimation()
			f7_arg0.WZAARContainers:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.WZAARContainers)
		end,
	},
}
CoD.WZAAR.__onClose = function(f8_arg0)
	f8_arg0.WZAARContainers:close()
	f8_arg0.emptyFocusable:close()
end
