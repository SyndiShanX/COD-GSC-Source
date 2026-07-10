CoD.SpectreRisingIndicator = InheritFrom(CoD.Menu)
LUI.createMenu.SpectreRisingIndicator = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SpectreRisingIndicator", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.SpectreRisingIndicator)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BountyIndicator = LUI.UIImage.new(0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	BountyIndicator:setImage(RegisterImage(0x651B795DA754E93))
	self:addElement(BountyIndicator)
	self.BountyIndicator = BountyIndicator
	local pointer = LUI.UIImage.new(0.5, 0.5, -37.5, 37.5, 0.5, 0.5, -1, 74)
	pointer:setImage(RegisterImage(0x63910B0A0B26F0D))
	self:addElement(pointer)
	self.pointer = pointer
	self:mergeStateConditions({
		{
			stateName = "VisibleBounty",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "hudItems.isSpectre", 1)
				if f2_local0 then
					if not CoD.ModelUtility.IsSelfModelValueEqualToClientModelValue(f1_arg0, element, "clientnum", "clientNum") then
						f2_local0 = CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "isAlive", 1)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local5(f1_local4, f1_local6["hudItems.isSpectre"], function(f3_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.isSpectre",
		})
	end, false)
	self:linkToElementModel(self, "clientnum", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clientnum",
		})
	end)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0xE4D2F32833CFA6C](Engine[0x761955642304848](f1_arg0))
	f1_local5(f1_local4, f1_local6.clientNum, function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "clientNum",
		})
	end, false)
	self:linkToElementModel(self, "isAlive", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "isAlive",
		})
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local5 = self
	CoD.HUDUtility.LinkSetupEntityContainerToModel(self, "clientnum", false, true, 0, 0, 40)
	SetProperty(self, "_priority", -1)
	return self
end
CoD.SpectreRisingIndicator.__resetProperties = function(f7_arg0)
	f7_arg0.BountyIndicator:completeAnimation()
	f7_arg0.pointer:completeAnimation()
	f7_arg0.BountyIndicator:setAlpha(1)
	f7_arg0.pointer:setAlpha(1)
end
CoD.SpectreRisingIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.BountyIndicator:completeAnimation()
			f8_arg0.BountyIndicator:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.BountyIndicator)
			f8_arg0.pointer:completeAnimation()
			f8_arg0.pointer:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.pointer)
		end,
	},
	VisibleBounty = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.SpectreRisingIndicator.__onClose = function(f10_arg0) end
