CoD.genericVHUDdamageArea = InheritFrom(LUI.UIElement)
CoD.genericVHUDdamageArea.__defaultWidth = 150
CoD.genericVHUDdamageArea.__defaultHeight = 150
CoD.genericVHUDdamageArea.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericVHUDdamageArea)
	self.id = "genericVHUDdamageArea"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lineBack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	lineBack:setRGB(0.6, 0.82, 0.91)
	lineBack:setAlpha(0.3)
	lineBack:setZoom(-20)
	lineBack:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_raps_damageiconlinergb"))
	lineBack:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(lineBack)
	self.lineBack = lineBack
	local fill = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fill:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_raps_damageiconred"))
	fill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	fill:setShaderVector(0, 0, 1, 0, 0)
	fill:setShaderVector(1, 0, 0, 0, 0)
	fill:setShaderVector(3, 0, 0, 0, 0)
	fill:setShaderVector(4, 0, 0, 0, 0)
	fill:linkToElementModel(self, "damage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			fill:setShaderVector(2, SubtractVectorComponentFrom(1, 1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))))
		end
	end)
	self:addElement(fill)
	self.fill = fill
	local lineFront = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	lineFront:setRGB(0.6, 0.82, 0.91)
	lineFront:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_raps_damageiconlinergb"))
	lineFront:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(lineFront)
	self.lineFront = lineFront
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUDdamageArea.__resetProperties = function(f4_arg0)
	f4_arg0.lineBack:completeAnimation()
	f4_arg0.fill:completeAnimation()
	f4_arg0.lineFront:completeAnimation()
	f4_arg0.lineBack:setAlpha(0.3)
	f4_arg0.fill:setAlpha(1)
	f4_arg0.lineFront:setAlpha(1)
end
CoD.genericVHUDdamageArea.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.lineBack:completeAnimation()
			f5_arg0.lineBack:setAlpha(0.3)
			f5_arg0.clipFinished(f5_arg0.lineBack)
			f5_arg0.fill:completeAnimation()
			f5_arg0.fill:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.fill)
			f5_arg0.lineFront:completeAnimation()
			f5_arg0.lineFront:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.lineFront)
		end,
	},
	Invisible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.lineBack:completeAnimation()
			f6_arg0.lineBack:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.lineBack)
			f6_arg0.fill:completeAnimation()
			f6_arg0.fill:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.fill)
			f6_arg0.lineFront:completeAnimation()
			f6_arg0.lineFront:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.lineFront)
		end,
	},
}
CoD.genericVHUDdamageArea.__onClose = function(f7_arg0)
	f7_arg0.fill:close()
end
