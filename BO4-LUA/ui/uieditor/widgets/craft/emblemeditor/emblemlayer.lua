require("x64:1ae3646e9c07675")
CoD.EmblemLayer = InheritFrom(LUI.UIElement)
CoD.EmblemLayer.__defaultWidth = 172
CoD.EmblemLayer.__defaultHeight = 172
CoD.EmblemLayer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemLayer)
	self.id = "EmblemLayer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local background = LUI.UIImage.new(0, 1, 22, -22, 0, 1, 22, -22)
	background:setAlpha(0)
	self:addElement(background)
	self.background = background
	local backgroundMask = LUI.UIImage.new(0, 1, 22, -22, 0, 1, 22, -22)
	backgroundMask:setRGB(0, 0, 0)
	backgroundMask:setAlpha(0)
	self:addElement(backgroundMask)
	self.backgroundMask = backgroundMask
	local layerIcon = CoD.LayerIcon.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	layerIcon:mergeStateConditions({
		{
			stateName = "EmptyLayer",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsLayerEmpty(self, element, f1_arg1)
			end,
		},
	})
	layerIcon:linkToElementModel(layerIcon, "layerIndex", true, function(model)
		f1_arg0:updateElementState(layerIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "layerIndex",
		})
	end)
	layerIcon:linkToElementModel(layerIcon, "iconID", true, function(model)
		f1_arg0:updateElementState(layerIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	local f1_local4 = layerIcon
	local f1_local5 = layerIcon.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["Emblem.EmblemProperties.groupsUsed"], function(f5_arg0)
		f1_arg0:updateElementState(layerIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	f1_local4 = layerIcon
	f1_local5 = layerIcon.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["Emblem.EmblemProperties.layersUsed"], function(f6_arg0)
		f1_arg0:updateElementState(layerIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	layerIcon:linkToElementModel(self, nil, false, function(model)
		layerIcon:setModel(model, f1_arg1)
	end)
	self:addElement(layerIcon)
	self.layerIcon = layerIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemLayer.__onClose = function(f8_arg0)
	f8_arg0.layerIcon:close()
end
