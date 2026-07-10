require("x64:762eec3732db918")
CoD.BGBSelectButtonPrompt = InheritFrom(LUI.UIElement)
CoD.BGBSelectButtonPrompt.__defaultWidth = 70
CoD.BGBSelectButtonPrompt.__defaultHeight = 70
CoD.BGBSelectButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BGBSelectButtonPrompt)
	self.id = "BGBSelectButtonPrompt"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Backer = LUI.UIImage.new(0, 0, 3.5, 71.5, 0, 0, 5, 73)
	Backer:setScale(1.4, 1.4)
	Backer:setImage(RegisterImage(0x67143B4B1C4D00C))
	self:addElement(Backer)
	self.Backer = Backer
	local DownArrow = CoD.ZmAmmo_BGBCarouselButtonFactory.new(f1_arg0, f1_arg1, 0.5, 0.5, -13.5, 18.5, 0.5, 0.5, 7.5, 39.5)
	DownArrow:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "BGBLoadout", "selectedIndex", "slotIndex")
			end,
		},
	})
	DownArrow:linkToElementModel(DownArrow, "unavailable", true, function(model)
		f1_arg0:updateElementState(DownArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unavailable",
		})
	end)
	local RightArrow = DownArrow
	local UpArrow = DownArrow.subscribeToModel
	local LeftArrow = DataSources.BGBLoadout.getModel(f1_arg1)
	UpArrow(RightArrow, LeftArrow.selectedIndex, function(f4_arg0)
		f1_arg0:updateElementState(DownArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	DownArrow:linkToElementModel(DownArrow, "slotIndex", true, function(model)
		f1_arg0:updateElementState(DownArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slotIndex",
		})
	end)
	DownArrow:linkToElementModel(DownArrow, "gum_idx", true, function(model)
		f1_arg0:updateElementState(DownArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gum_idx",
		})
	end)
	DownArrow:linkToElementModel(DownArrow, "lockdown", true, function(model)
		f1_arg0:updateElementState(DownArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lockdown",
		})
	end)
	DownArrow:setZRot(180)
	DownArrow:setScale(1.4, 1.4)
	DownArrow:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Down", function(model)
		DownArrow:setModel(model, f1_arg1)
	end)
	self:addElement(DownArrow)
	self.DownArrow = DownArrow
	UpArrow = CoD.ZmAmmo_BGBCarouselButtonFactory.new(f1_arg0, f1_arg1, 0.5, 0.5, -13, 19, 0.5, 0.5, -31.5, 0.5)
	UpArrow:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "BGBLoadout", "selectedIndex", "slotIndex")
			end,
		},
	})
	UpArrow:linkToElementModel(UpArrow, "unavailable", true, function(model)
		f1_arg0:updateElementState(UpArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unavailable",
		})
	end)
	LeftArrow = UpArrow
	RightArrow = UpArrow.subscribeToModel
	local f1_local6 = DataSources.BGBLoadout.getModel(f1_arg1)
	RightArrow(LeftArrow, f1_local6.selectedIndex, function(f11_arg0)
		f1_arg0:updateElementState(UpArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	UpArrow:linkToElementModel(UpArrow, "slotIndex", true, function(model)
		f1_arg0:updateElementState(UpArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slotIndex",
		})
	end)
	UpArrow:linkToElementModel(UpArrow, "gum_idx", true, function(model)
		f1_arg0:updateElementState(UpArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gum_idx",
		})
	end)
	UpArrow:linkToElementModel(UpArrow, "lockdown", true, function(model)
		f1_arg0:updateElementState(UpArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lockdown",
		})
	end)
	UpArrow:setScale(1.4, 1.4)
	UpArrow:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Up", function(model)
		UpArrow:setModel(model, f1_arg1)
	end)
	self:addElement(UpArrow)
	self.UpArrow = UpArrow
	RightArrow = CoD.ZmAmmo_BGBCarouselButtonFactory.new(f1_arg0, f1_arg1, 0.5, 0.5, 6, 38, 0.5, 0.5, -12, 20)
	RightArrow:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "BGBLoadout", "selectedIndex", "slotIndex")
			end,
		},
	})
	RightArrow:linkToElementModel(RightArrow, "unavailable", true, function(model)
		f1_arg0:updateElementState(RightArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unavailable",
		})
	end)
	f1_local6 = RightArrow
	LeftArrow = RightArrow.subscribeToModel
	local f1_local7 = DataSources.BGBLoadout.getModel(f1_arg1)
	LeftArrow(f1_local6, f1_local7.selectedIndex, function(f18_arg0)
		f1_arg0:updateElementState(RightArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	RightArrow:linkToElementModel(RightArrow, "slotIndex", true, function(model)
		f1_arg0:updateElementState(RightArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slotIndex",
		})
	end)
	RightArrow:linkToElementModel(RightArrow, "gum_idx", true, function(model)
		f1_arg0:updateElementState(RightArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gum_idx",
		})
	end)
	RightArrow:linkToElementModel(RightArrow, "lockdown", true, function(model)
		f1_arg0:updateElementState(RightArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lockdown",
		})
	end)
	RightArrow:setZRot(-90)
	RightArrow:setScale(1.4, 1.4)
	RightArrow:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Right", function(model)
		RightArrow:setModel(model, f1_arg1)
	end)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	LeftArrow = CoD.ZmAmmo_BGBCarouselButtonFactory.new(f1_arg0, f1_arg1, 0.5, 0.5, -32.5, -0.5, 0.5, 0.5, -12.5, 19.5)
	LeftArrow:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "BGBLoadout", "selectedIndex", "slotIndex")
			end,
		},
	})
	LeftArrow:linkToElementModel(LeftArrow, "unavailable", true, function(model)
		f1_arg0:updateElementState(LeftArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unavailable",
		})
	end)
	f1_local7 = LeftArrow
	f1_local6 = LeftArrow.subscribeToModel
	local f1_local8 = DataSources.BGBLoadout.getModel(f1_arg1)
	f1_local6(f1_local7, f1_local8.selectedIndex, function(f25_arg0)
		f1_arg0:updateElementState(LeftArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "selectedIndex",
		})
	end, false)
	LeftArrow:linkToElementModel(LeftArrow, "slotIndex", true, function(model)
		f1_arg0:updateElementState(LeftArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "slotIndex",
		})
	end)
	LeftArrow:linkToElementModel(LeftArrow, "gum_idx", true, function(model)
		f1_arg0:updateElementState(LeftArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gum_idx",
		})
	end)
	LeftArrow:linkToElementModel(LeftArrow, "lockdown", true, function(model)
		f1_arg0:updateElementState(LeftArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lockdown",
		})
	end)
	LeftArrow:setZRot(90)
	LeftArrow:setScale(1.4, 1.4)
	LeftArrow:subscribeToGlobalModel(f1_arg1, "BGBLoadout", "Left", function(model)
		LeftArrow:setModel(model, f1_arg1)
	end)
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BGBSelectButtonPrompt.__onClose = function(f30_arg0)
	f30_arg0.DownArrow:close()
	f30_arg0.UpArrow:close()
	f30_arg0.RightArrow:close()
	f30_arg0.LeftArrow:close()
end
