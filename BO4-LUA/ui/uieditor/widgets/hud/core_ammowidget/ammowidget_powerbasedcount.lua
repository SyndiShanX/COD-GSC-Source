require("x64:e9c0321bb7002d6")
CoD.AmmoWidget_PowerBasedCount = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_PowerBasedCount.__defaultWidth = 64
CoD.AmmoWidget_PowerBasedCount.__defaultHeight = 20
CoD.AmmoWidget_PowerBasedCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_PowerBasedCount)
	self.id = "AmmoWidget_PowerBasedCount"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local pipx1 = CoD.AmmoWidget_PowerBasedCountPip.new(f1_arg0, f1_arg1, 0, 0, 15, 49, 0, 0, 0, 4)
	pipx1:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(self, f1_arg1, "ammo", 2)
			end,
		},
		{
			stateName = "Inactive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(self, f1_arg1, "clipMaxAmmo", 2)
			end,
		},
	})
	pipx1:linkToElementModel(pipx1, "ammo", true, function(model)
		f1_arg0:updateElementState(pipx1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammo",
		})
	end)
	pipx1:linkToElementModel(pipx1, "clipMaxAmmo", true, function(model)
		f1_arg0:updateElementState(pipx1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clipMaxAmmo",
		})
	end)
	pipx1:linkToElementModel(self, nil, false, function(model)
		pipx1:setModel(model, f1_arg1)
	end)
	self:addElement(pipx1)
	self.pipx1 = pipx1
	local pipx2 = CoD.AmmoWidget_PowerBasedCountPip.new(f1_arg0, f1_arg1, 0, 0, 15, 49, 0, 0, 5, 9)
	pipx2:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(self, f1_arg1, "ammo", 3)
			end,
		},
		{
			stateName = "Inactive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(self, f1_arg1, "clipMaxAmmo", 3)
			end,
		},
	})
	pipx2:linkToElementModel(pipx2, "ammo", true, function(model)
		f1_arg0:updateElementState(pipx2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammo",
		})
	end)
	pipx2:linkToElementModel(pipx2, "clipMaxAmmo", true, function(model)
		f1_arg0:updateElementState(pipx2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clipMaxAmmo",
		})
	end)
	pipx2.Image:setImage(RegisterImage(0x78EFD6D25F6ECDF))
	pipx2:linkToElementModel(self, nil, false, function(model)
		pipx2:setModel(model, f1_arg1)
	end)
	self:addElement(pipx2)
	self.pipx2 = pipx2
	local pipx3 = CoD.AmmoWidget_PowerBasedCountPip.new(f1_arg0, f1_arg1, 0, 0, 15, 49, 0, 0, 10, 14)
	pipx3:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(self, f1_arg1, "ammo", 4)
			end,
		},
		{
			stateName = "Inactive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(self, f1_arg1, "clipMaxAmmo", 4)
			end,
		},
	})
	pipx3:linkToElementModel(pipx3, "ammo", true, function(model)
		f1_arg0:updateElementState(pipx3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammo",
		})
	end)
	pipx3:linkToElementModel(pipx3, "clipMaxAmmo", true, function(model)
		f1_arg0:updateElementState(pipx3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clipMaxAmmo",
		})
	end)
	pipx3.Image:setImage(RegisterImage(0x78EFD6D25F6ECDF))
	pipx3:linkToElementModel(self, nil, false, function(model)
		pipx3:setModel(model, f1_arg1)
	end)
	self:addElement(pipx3)
	self.pipx3 = pipx3
	self:mergeStateConditions({
		{
			stateName = "NoReserve",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "ammo", 2) and CoD.ModelUtility.IsSelfModelValueLessThan(self, f1_arg1, "clipMaxAmmo", 2)
			end,
		},
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "fireableUntilEmpty")
			end,
		},
	})
	self:linkToElementModel(self, "ammo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammo",
		})
	end)
	self:linkToElementModel(self, "clipMaxAmmo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clipMaxAmmo",
		})
	end)
	self:linkToElementModel(self, "fireableUntilEmpty", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "fireableUntilEmpty",
		})
	end)
	self:linkToElementModel(self, "ammo", true, function(model)
		local f22_local0 = self
		if CoD.HUDUtility.ShouldPulseNewAmmo(self) then
			PlayClip(self, "Pulse", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_PowerBasedCount.__resetProperties = function(f23_arg0)
	f23_arg0.pipx3:completeAnimation()
	f23_arg0.pipx2:completeAnimation()
	f23_arg0.pipx1:completeAnimation()
	f23_arg0.pipx3:setAlpha(1)
	f23_arg0.pipx2:setAlpha(1)
	f23_arg0.pipx1:setAlpha(1)
end
CoD.AmmoWidget_PowerBasedCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	NoReserve = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.pipx1:completeAnimation()
			f25_arg0.pipx1:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.pipx1)
			f25_arg0.pipx2:completeAnimation()
			f25_arg0.pipx2:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.pipx2)
			f25_arg0.pipx3:completeAnimation()
			f25_arg0.pipx3:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.pipx3)
		end,
	},
	Invisible = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.pipx1:completeAnimation()
			f26_arg0.pipx1:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.pipx1)
			f26_arg0.pipx2:completeAnimation()
			f26_arg0.pipx2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.pipx2)
			f26_arg0.pipx3:completeAnimation()
			f26_arg0.pipx3:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.pipx3)
		end,
	},
}
CoD.AmmoWidget_PowerBasedCount.__onClose = function(f27_arg0)
	f27_arg0.pipx1:close()
	f27_arg0.pipx2:close()
	f27_arg0.pipx3:close()
end
