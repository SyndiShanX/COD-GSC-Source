require("x64:cc9ca892a619096")
require("x64:68bcc307dcc87ad")
require("x64:b3df56b6d23c7ac")
CoD.WeaponOptionInfo = InheritFrom(LUI.UIElement)
CoD.WeaponOptionInfo.__defaultWidth = 1920
CoD.WeaponOptionInfo.__defaultHeight = 144
CoD.WeaponOptionInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponOptionInfo)
	self.id = "WeaponOptionInfo"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponOptionInfoInternal = CoD.WeaponOptionInfoInternal.new(f1_arg0, f1_arg1, 0, 0, 168, 648, 0, 0, 0, 130)
	WeaponOptionInfoInternal:linkToElementModel(self, nil, false, function(model)
		WeaponOptionInfoInternal:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponOptionInfoInternal)
	self.WeaponOptionInfoInternal = WeaponOptionInfoInternal
	local ItemInfoPanel = CoD.BM_ItemInfoCompactPanel.new(f1_arg0, f1_arg1, 1, 1, -650, -110, 0, 0, 54, 179)
	ItemInfoPanel:linkToElementModel(self, "lootData", false, function(model)
		ItemInfoPanel:setModel(model, f1_arg1)
	end)
	self:addElement(ItemInfoPanel)
	self.ItemInfoPanel = ItemInfoPanel
	local CamoOriginWidget = CoD.WZCamoOriginWidget.new(f1_arg0, f1_arg1, 0, 0, 1380, 1920, 0, 0, 0, 144)
	self:addElement(CamoOriginWidget)
	self.CamoOriginWidget = CamoOriginWidget
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelNil(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, nil, false, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model and model:get(),
			modelName = nil,
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponOptionInfo.__resetProperties = function(f6_arg0)
	f6_arg0.WeaponOptionInfoInternal:completeAnimation()
	f6_arg0.CamoOriginWidget:completeAnimation()
	f6_arg0.WeaponOptionInfoInternal:setAlpha(1)
	f6_arg0.CamoOriginWidget:setAlpha(1)
end
CoD.WeaponOptionInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.WeaponOptionInfoInternal:completeAnimation()
			f7_arg0.WeaponOptionInfoInternal:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.WeaponOptionInfoInternal)
			f7_arg0.CamoOriginWidget:completeAnimation()
			f7_arg0.CamoOriginWidget:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CamoOriginWidget)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WeaponOptionInfo.__onClose = function(f9_arg0)
	f9_arg0.WeaponOptionInfoInternal:close()
	f9_arg0.ItemInfoPanel:close()
	f9_arg0.CamoOriginWidget:close()
end
