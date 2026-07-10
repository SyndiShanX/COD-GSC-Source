CoD.AmmoWidget_AmmoCaliber = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_AmmoCaliber.__defaultWidth = 164
CoD.AmmoWidget_AmmoCaliber.__defaultHeight = 14
CoD.AmmoWidget_AmmoCaliber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_AmmoCaliber)
	self.id = "AmmoWidget_AmmoCaliber"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ammoType = LUI.UIText.new(0, 0, 0, 164, 0, 0, 0, 14)
	ammoType:setRGB(0.73, 0.71, 0.64)
	ammoType:setTTF("ttmussels_regular")
	ammoType:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ammoType:setShaderVector(0, 1, 0, 0, 0)
	ammoType:setShaderVector(1, 0, 0, 0, 0)
	ammoType:setShaderVector(2, 0.8, 0.8, 0.8, 0.3)
	ammoType:setLetterSpacing(1)
	ammoType:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ammoType:linkToElementModel(self, "ammoCaliberName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ammoType:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(ammoType)
	self.ammoType = ammoType
	self:mergeStateConditions({
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_AmmoCaliber.__resetProperties = function(f5_arg0)
	f5_arg0.ammoType:completeAnimation()
	f5_arg0.ammoType:setAlpha(1)
end
CoD.AmmoWidget_AmmoCaliber.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ammoType:completeAnimation()
			f6_arg0.ammoType:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ammoType)
		end,
	},
	WZ = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.AmmoWidget_AmmoCaliber.__onClose = function(f8_arg0)
	f8_arg0.ammoType:close()
end
