require("x64:6b30f0c9149a583")
CoD.vhud_ms_DamageSideContainer = InheritFrom(LUI.UIElement)
CoD.vhud_ms_DamageSideContainer.__defaultWidth = 91
CoD.vhud_ms_DamageSideContainer.__defaultHeight = 39
CoD.vhud_ms_DamageSideContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_DamageSideContainer)
	self.id = "vhud_ms_DamageSideContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local vhudmsDamageIconSideLeft = CoD.vhud_ms_DamageIconSide.new(f1_arg0, f1_arg1, 0.5, 0.5, -48.5, -9.5, 0.5, 0.5, -19, 19)
	vhudmsDamageIconSideLeft:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfEnumModelValueTrue(element, f1_arg1, Enum[0x76254DAF867D1BD][0x97458278F61A801])
			end,
		},
	})
	vhudmsDamageIconSideLeft:linkToElementModel(vhudmsDamageIconSideLeft, Enum[0x76254DAF867D1BD][0x97458278F61A801], true, function(model)
		f1_arg0:updateElementState(vhudmsDamageIconSideLeft, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[0x76254DAF867D1BD][0x97458278F61A801],
		})
	end)
	vhudmsDamageIconSideLeft:setYRot(180)
	vhudmsDamageIconSideLeft:linkToElementModel(self, nil, false, function(model)
		vhudmsDamageIconSideLeft:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsDamageIconSideLeft)
	self.vhudmsDamageIconSideLeft = vhudmsDamageIconSideLeft
	local vhudmsDamageIconSideRight = CoD.vhud_ms_DamageIconSide.new(f1_arg0, f1_arg1, 0.5, 0.5, 7, 45, 0.5, 0.5, -19, 19)
	vhudmsDamageIconSideRight:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfEnumModelValueTrue(element, f1_arg1, Enum[0x76254DAF867D1BD][0x97455278F61A2E8])
			end,
		},
	})
	vhudmsDamageIconSideRight:linkToElementModel(vhudmsDamageIconSideRight, Enum[0x76254DAF867D1BD][0x97455278F61A2E8], true, function(model)
		f1_arg0:updateElementState(vhudmsDamageIconSideRight, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[0x76254DAF867D1BD][0x97455278F61A2E8],
		})
	end)
	vhudmsDamageIconSideRight:linkToElementModel(self, nil, false, function(model)
		vhudmsDamageIconSideRight:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsDamageIconSideRight)
	self.vhudmsDamageIconSideRight = vhudmsDamageIconSideRight
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_DamageSideContainer.__onClose = function(f8_arg0)
	f8_arg0.vhudmsDamageIconSideLeft:close()
	f8_arg0.vhudmsDamageIconSideRight:close()
end
