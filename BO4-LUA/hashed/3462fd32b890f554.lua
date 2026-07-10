CoD.bleedOutHealthMP = InheritFrom(LUI.UIElement)
CoD.bleedOutHealthMP.__defaultWidth = 210
CoD.bleedOutHealthMP.__defaultHeight = 250
CoD.bleedOutHealthMP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.bleedOutHealthMP)
	self.id = "bleedOutHealthMP"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WaypointBackerBlur = LUI.UIImage.new(0.5, 0.5, -94, 94, 0.5, 0.5, -118, 70)
	WaypointBackerBlur:setImage(RegisterImage(0x8DDD1FDE43242E1))
	WaypointBackerBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	WaypointBackerBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(WaypointBackerBlur)
	self.WaypointBackerBlur = WaypointBackerBlur
	local WaypointBacker = LUI.UIImage.new(0.5, 0.5, -94, 94, 0.5, 0.5, -118, 70)
	WaypointBacker:setImage(RegisterImage(0x8DDD1FDE43242E1))
	self:addElement(WaypointBacker)
	self.WaypointBacker = WaypointBacker
	local WaypointProgressMeterEmpty = LUI.UIImage.new(0.5, 0.5, -94, 94, 0.5, 0.5, -118, 70)
	WaypointProgressMeterEmpty:setRGB(1, 0.98, 0.91)
	WaypointProgressMeterEmpty:setImage(RegisterImage(0x2608D8F924FABD2))
	self:addElement(WaypointProgressMeterEmpty)
	self.WaypointProgressMeterEmpty = WaypointProgressMeterEmpty
	local WaypointPattern = LUI.UIImage.new(0.5, 0.5, -80, 80, 0.5, 0.5, -104, 56)
	WaypointPattern:setRGB(0.13, 0.87, 0.94)
	WaypointPattern:setImage(RegisterImage(0x159D9B7B7294C91))
	WaypointPattern:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	WaypointPattern:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(WaypointPattern)
	self.WaypointPattern = WaypointPattern
	local reviveiconBackplate = LUI.UIImage.new(0.5, 0.5, -60, 60, 0.5, 0.5, -84, 36)
	reviveiconBackplate:setRGB(0, 0, 0)
	reviveiconBackplate:setAlpha(0.66)
	reviveiconBackplate:setImage(RegisterImage(0x41C05E66E33E85A))
	self:addElement(reviveiconBackplate)
	self.reviveiconBackplate = reviveiconBackplate
	local reviveicon = LUI.UIImage.new(0.5, 0.5, -55, 55, 0.5, 0.5, -79, 31)
	reviveicon:setImage(RegisterImage(0x41C05E66E33E85A))
	reviveicon:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	reviveicon:setShaderVector(0, 1.16, 0, 0, 0)
	self:addElement(reviveicon)
	self.reviveicon = reviveicon
	local bleedingOutRing = LUI.UIImage.new(0.5, 0.5, -87, 87, 0.5, 0.5, -111, 63)
	bleedingOutRing:setImage(RegisterImage(0x2E4DBA41E983343))
	bleedingOutRing:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	bleedingOutRing:setShaderVector(1, 0.5, 0, 0, 0)
	bleedingOutRing:setShaderVector(2, 0.5, 0, 0, 0)
	bleedingOutRing:setShaderVector(3, 0, 0, 0, 0)
	bleedingOutRing:setShaderVector(4, 0, 0, 0, 0)
	bleedingOutRing:linkToElementModel(self, "health", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			bleedingOutRing:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(bleedingOutRing)
	self.bleedingOutRing = bleedingOutRing
	local revivingRing = LUI.UIImage.new(0.5, 0.5, -87, 87, 0.5, 0.5, -111, 63)
	revivingRing:setRGB(0.13, 0.87, 0.94)
	revivingRing:setImage(RegisterImage(0x2E4DBA41E983343))
	revivingRing:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	revivingRing:setShaderVector(1, 0.5, 0, 0, 0)
	revivingRing:setShaderVector(2, 0.5, 0, 0, 0)
	revivingRing:setShaderVector(3, 0, 0, 0, 0)
	revivingRing:setShaderVector(4, 0, 0, 0, 0)
	revivingRing:linkToElementModel(self, "reviveProgress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			revivingRing:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(revivingRing)
	self.revivingRing = revivingRing
	self:mergeStateConditions({
		{
			stateName = "Reviving",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "reviveProgress", 0)
			end,
		},
		{
			stateName = "BleedingOut_Low",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "health", 0.2)
			end,
		},
		{
			stateName = "BleedingOut",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "reviveProgress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reviveProgress",
		})
	end)
	self:linkToElementModel(self, "health", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.bleedOutHealthMP.__onClose = function(f9_arg0)
	f9_arg0.bleedingOutRing:close()
	f9_arg0.revivingRing:close()
end
