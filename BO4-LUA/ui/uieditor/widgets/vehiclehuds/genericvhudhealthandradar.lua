require("x64:9505c06d12eccc1")
require("x64:b211c35aaad19f5")
CoD.genericVHUDHealthAndRadar = InheritFrom(LUI.UIElement)
CoD.genericVHUDHealthAndRadar.__defaultWidth = 293
CoD.genericVHUDHealthAndRadar.__defaultHeight = 749
CoD.genericVHUDHealthAndRadar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericVHUDHealthAndRadar)
	self.id = "genericVHUDHealthAndRadar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurMask = LUI.UIImage.new(1, 1, -366, -86, 1, 1, -308, -28)
	BlurMask:setImage(RegisterImage(@"uie_hud_minimap_outer_ring"))
	BlurMask:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurMask:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurMask)
	self.BlurMask = BlurMask
	local vehicleRadar = CoD.vehicleRadar.new(f1_arg0, f1_arg1, 1, 1, -366, -86, 1, 1, -308, -28)
	vehicleRadar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "enableRadar")
			end,
		},
	})
	vehicleRadar:linkToElementModel(vehicleRadar, "enableRadar", true, function(model)
		f1_arg0:updateElementState(vehicleRadar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "enableRadar",
		})
	end)
	vehicleRadar:linkToElementModel(self, nil, false, function(model)
		vehicleRadar:setModel(model, f1_arg1)
	end)
	self:addElement(vehicleRadar)
	self.vehicleRadar = vehicleRadar
	local PooledVehicleHealthWidget = CoD.genericPooledVehicleHealthWidget.new(f1_arg0, f1_arg1, 1, 1, -125, -31, 0.5, 0.5, 85.5, 301.5)
	PooledVehicleHealthWidget:linkToElementModel(self, nil, false, function(model)
		PooledVehicleHealthWidget:setModel(model, f1_arg1)
	end)
	self:addElement(PooledVehicleHealthWidget)
	self.PooledVehicleHealthWidget = PooledVehicleHealthWidget
	self:mergeStateConditions({
		{
			stateName = "HideRadarBlur",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "enableRadar")
			end,
		},
	})
	self:linkToElementModel(self, "enableRadar", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "enableRadar",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUDHealthAndRadar.__resetProperties = function(f8_arg0)
	f8_arg0.BlurMask:completeAnimation()
	f8_arg0.BlurMask:setAlpha(1)
end
CoD.genericVHUDHealthAndRadar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	HideRadarBlur = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.BlurMask:completeAnimation()
			f10_arg0.BlurMask:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BlurMask)
		end,
	},
}
CoD.genericVHUDHealthAndRadar.__onClose = function(f11_arg0)
	f11_arg0.vehicleRadar:close()
	f11_arg0.PooledVehicleHealthWidget:close()
end
