require("x64:4442a39de25d22b")
require("x64:3febbde5ef32cb5")
CoD.ZMInvObjectiveProgressRingContainer = InheritFrom(LUI.UIElement)
CoD.ZMInvObjectiveProgressRingContainer.__defaultWidth = 384
CoD.ZMInvObjectiveProgressRingContainer.__defaultHeight = 384
CoD.ZMInvObjectiveProgressRingContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvObjectiveProgressRingContainer)
	self.id = "ZMInvObjectiveProgressRingContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ObjectiveProgRing = CoD.ZMInvObjectiveProgressRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 0.5, 0.5, -192, 192)
	ObjectiveProgRing:setScale(0.56, 0.56)
	ObjectiveProgRing:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgRing:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgRing)
	self.ObjectiveProgRing = ObjectiveProgRing
	local NonlinearObjectProgressRing = CoD.ZMInvNonlinearObjectProgressRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 0.5, 0.5, -192, 192)
	NonlinearObjectProgressRing:setAlpha(0)
	NonlinearObjectProgressRing:setScale(0.56, 0.56)
	NonlinearObjectProgressRing:linkToElementModel(self, nil, false, function(model)
		NonlinearObjectProgressRing:setModel(model, f1_arg1)
	end)
	self:addElement(NonlinearObjectProgressRing)
	self.NonlinearObjectProgressRing = NonlinearObjectProgressRing
	self:mergeStateConditions({
		{
			stateName = "NonLinear",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isObjProgressNonLinear")
			end,
		},
	})
	self:linkToElementModel(self, "isObjProgressNonLinear", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isObjProgressNonLinear",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvObjectiveProgressRingContainer.__resetProperties = function(f6_arg0)
	f6_arg0.ObjectiveProgRing:completeAnimation()
	f6_arg0.NonlinearObjectProgressRing:completeAnimation()
	f6_arg0.ObjectiveProgRing:setAlpha(1)
	f6_arg0.NonlinearObjectProgressRing:setAlpha(0)
end
CoD.ZMInvObjectiveProgressRingContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	NonLinear = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.ObjectiveProgRing:completeAnimation()
			f8_arg0.ObjectiveProgRing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ObjectiveProgRing)
			f8_arg0.NonlinearObjectProgressRing:completeAnimation()
			f8_arg0.NonlinearObjectProgressRing:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.NonlinearObjectProgressRing)
		end,
	},
}
CoD.ZMInvObjectiveProgressRingContainer.__onClose = function(f9_arg0)
	f9_arg0.ObjectiveProgRing:close()
	f9_arg0.NonlinearObjectProgressRing:close()
end
