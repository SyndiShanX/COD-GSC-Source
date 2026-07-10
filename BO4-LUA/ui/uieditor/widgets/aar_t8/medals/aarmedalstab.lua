require("x64:72385e8fa11e573")
CoD.AARMedalsTab = InheritFrom(LUI.UIElement)
CoD.AARMedalsTab.__defaultWidth = 1920
CoD.AARMedalsTab.__defaultHeight = 900
CoD.AARMedalsTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARMedalsTab)
	self.id = "AARMedalsTab"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GametypeAndMap = CoD.AARMedalsTabInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	self:addElement(GametypeAndMap)
	self.GametypeAndMap = GametypeAndMap
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_MEDALS)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["AAR.activeTab"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	GametypeAndMap.id = "GametypeAndMap"
	self.__defaultFocus = GametypeAndMap
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARMedalsTab.__resetProperties = function(f4_arg0)
	f4_arg0.GametypeAndMap:completeAnimation()
	f4_arg0.GametypeAndMap:setAlpha(1)
end
CoD.AARMedalsTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.GametypeAndMap:completeAnimation()
			f5_arg0.GametypeAndMap:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.GametypeAndMap)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.GametypeAndMap:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f6_arg0.GametypeAndMap:setAlpha(1)
				f6_arg0.GametypeAndMap:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.GametypeAndMap:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.GametypeAndMap:completeAnimation()
			f6_arg0.GametypeAndMap:setAlpha(0)
			f6_local0(f6_arg0.GametypeAndMap)
		end,
	},
}
CoD.AARMedalsTab.__onClose = function(f8_arg0)
	f8_arg0.GametypeAndMap:close()
end
