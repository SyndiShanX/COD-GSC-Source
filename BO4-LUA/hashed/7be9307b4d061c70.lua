CoD.WZCamoOriginWidget = InheritFrom(LUI.UIElement)
CoD.WZCamoOriginWidget.__defaultWidth = 540
CoD.WZCamoOriginWidget.__defaultHeight = 144
CoD.WZCamoOriginWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZCamoOriginWidget)
	self.id = "WZCamoOriginWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CamoOriginWidget = LUI.UIText.new(0, 0, 0, 540, 0.5, 0.5, -10, 10)
	CamoOriginWidget:setTTF("dinnext_regular")
	CamoOriginWidget:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CamoOriginWidget:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	CamoOriginWidget:linkToElementModel(self, "origin", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CamoOriginWidget:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(CamoOriginWidget)
	self.CamoOriginWidget = CamoOriginWidget
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "originVisible")
			end,
		},
	})
	self:linkToElementModel(self, "originVisible", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "originVisible",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZCamoOriginWidget.__resetProperties = function(f5_arg0)
	f5_arg0.CamoOriginWidget:completeAnimation()
	f5_arg0.CamoOriginWidget:setAlpha(1)
end
CoD.WZCamoOriginWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.CamoOriginWidget:completeAnimation()
			f6_arg0.CamoOriginWidget:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CamoOriginWidget)
		end,
	},
	Show = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WZCamoOriginWidget.__onClose = function(f8_arg0)
	f8_arg0.CamoOriginWidget:close()
end
