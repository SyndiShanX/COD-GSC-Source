require("ui/uieditor/widgets/mphudwidgets/waypointarrow")
CoD.WaypointArrowContainer = InheritFrom(LUI.UIElement)
CoD.WaypointArrowContainer.__defaultWidth = 43
CoD.WaypointArrowContainer.__defaultHeight = 46
CoD.WaypointArrowContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointArrowContainer)
	self.id = "WaypointArrowContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Arrow = CoD.WaypointArrow.new(f1_arg0, f1_arg1, 0, 0, -8, 52, 0, 0, 46, 82)
	Arrow:linkToElementModel(self, nil, false, function(model)
		Arrow:setModel(model, f1_arg1)
	end)
	self:addElement(Arrow)
	self.Arrow = Arrow
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f3_local0
				if not ParentObjectivePropertyIsTrue(element, "hide_arrow") then
					f3_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	self:linkToElementModel(self, "clamped", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointArrowContainer.__resetProperties = function(f5_arg0)
	f5_arg0.Arrow:completeAnimation()
	f5_arg0.Arrow:setAlpha(1)
end
CoD.WaypointArrowContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Arrow:completeAnimation()
			f6_arg0.Arrow:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Arrow)
		end,
	},
	Show = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Arrow:completeAnimation()
			f7_arg0.Arrow:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Arrow)
		end,
	},
}
CoD.WaypointArrowContainer.__onClose = function(f8_arg0)
	f8_arg0.Arrow:close()
end
