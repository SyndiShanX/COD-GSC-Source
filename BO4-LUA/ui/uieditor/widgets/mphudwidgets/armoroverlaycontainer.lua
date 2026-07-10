CoD.ArmorOverlayContainer = InheritFrom(LUI.UIElement)
CoD.ArmorOverlayContainer.__defaultWidth = 1920
CoD.ArmorOverlayContainer.__defaultHeight = 1080
CoD.ArmorOverlayContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArmorOverlayContainer)
	self.id = "ArmorOverlayContainer"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArmorOverlayImage = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	ArmorOverlayImage:setAlpha(0)
	ArmorOverlayImage:subscribeToGlobalModel(f1_arg1, "HUDItems", "armorOverlay", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ArmorOverlayImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ArmorOverlayImage)
	self.ArmorOverlayImage = ArmorOverlayImage
	self:mergeStateConditions({
		{
			stateName = "ArmorActive",
			condition = function(menu, element, event)
				return IsArmorOverlayActive(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.armorOverlay"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.armorOverlay",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArmorOverlayContainer.__resetProperties = function(f5_arg0)
	f5_arg0.ArmorOverlayImage:completeAnimation()
	f5_arg0.ArmorOverlayImage:setAlpha(0)
end
CoD.ArmorOverlayContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	ArmorActive = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ArmorOverlayImage:completeAnimation()
			f7_arg0.ArmorOverlayImage:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.ArmorOverlayImage)
		end,
	},
}
CoD.ArmorOverlayContainer.__onClose = function(f8_arg0)
	f8_arg0.ArmorOverlayImage:close()
end
