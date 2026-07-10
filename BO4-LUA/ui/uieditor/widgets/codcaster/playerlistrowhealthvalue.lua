CoD.PlayerListRowHealthValue = InheritFrom(LUI.UIElement)
CoD.PlayerListRowHealthValue.__defaultWidth = 47
CoD.PlayerListRowHealthValue.__defaultHeight = 15
CoD.PlayerListRowHealthValue.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerListRowHealthValue)
	self.id = "PlayerListRowHealthValue"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HealthValue = LUI.UIText.new(0, 0, 0, 47, 0.5, 0.5, -7.5, 7.5)
	HealthValue:setTTF("0arame_mono_stencil")
	HealthValue:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	HealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HealthValue:setRGB(CoD.CodCasterUtility.HealthColor(f2_local0))
		end
	end)
	HealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HealthValue:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerListRowHealthValue.__resetProperties = function(f5_arg0)
	f5_arg0.HealthValue:completeAnimation()
	f5_arg0.HealthValue:setTopBottom(0.5, 0.5, -7.5, 7.5)
end
CoD.PlayerListRowHealthValue.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.HealthValue:completeAnimation()
			f7_arg0.HealthValue:setTopBottom(0.5, 0.5, -2.5, 7.5)
			f7_arg0.clipFinished(f7_arg0.HealthValue)
		end,
	},
}
CoD.PlayerListRowHealthValue.__onClose = function(f8_arg0)
	f8_arg0.HealthValue:close()
end
