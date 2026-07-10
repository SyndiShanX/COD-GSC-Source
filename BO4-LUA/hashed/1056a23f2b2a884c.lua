require("x64:dab75006e381081")
CoD.ReticleEnemyIndicator = InheritFrom(LUI.UIElement)
CoD.ReticleEnemyIndicator.__defaultWidth = 600
CoD.ReticleEnemyIndicator.__defaultHeight = 600
CoD.ReticleEnemyIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReticleEnemyIndicator)
	self.id = "ReticleEnemyIndicator"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Triangle = CoD.ReticleEnemyIndicatorInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 600)
	Triangle:linkToElementModel(self, "angle", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Triangle:setZRot(f2_local0)
		end
	end)
	Triangle:linkToElementModel(self, nil, false, function(model)
		Triangle:setModel(model, f1_arg1)
	end)
	self:addElement(Triangle)
	self.Triangle = Triangle
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "enabled", true)
			end,
		},
	})
	self:linkToElementModel(self, "enabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "enabled",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReticleEnemyIndicator.__resetProperties = function(f6_arg0)
	f6_arg0.Triangle:completeAnimation()
	f6_arg0.Triangle:setAlpha(1)
end
CoD.ReticleEnemyIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Triangle:completeAnimation()
			f7_arg0.Triangle:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Triangle)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ReticleEnemyIndicator.__onClose = function(f9_arg0)
	f9_arg0.Triangle:close()
end
