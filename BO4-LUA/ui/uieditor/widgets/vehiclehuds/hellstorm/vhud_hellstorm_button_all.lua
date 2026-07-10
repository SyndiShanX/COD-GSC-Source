CoD.vhud_hellstorm_button_all = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_button_all.__defaultWidth = 1058
CoD.vhud_hellstorm_button_all.__defaultHeight = 360
CoD.vhud_hellstorm_button_all.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_button_all)
	self.id = "vhud_hellstorm_button_all"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonBacking01 = LUI.UIImage.new(0.5, 0.5, -313, -115, 1, 1, -123.5, -81.5)
	buttonBacking01:setAlpha(0.8)
	buttonBacking01:setImage(RegisterImage(0x9EBE9E1B70D78CC))
	self:addElement(buttonBacking01)
	self.buttonBacking01 = buttonBacking01
	local buttonBacking02 = LUI.UIImage.new(0.5, 0.5, 116, 314, 1, 1, -123.5, -81.5)
	buttonBacking02:setAlpha(0.8)
	buttonBacking02:setImage(RegisterImage(0x9EBE9E1B70D78CC))
	self:addElement(buttonBacking02)
	self.buttonBacking02 = buttonBacking02
	local buttonBacking03 = LUI.UIImage.new(0.5, 0.5, 330, 528, 1, 1, -174.5, -132.5)
	buttonBacking03:setAlpha(0.8)
	buttonBacking03:setImage(RegisterImage(0x9EBE9E1B70D78CC))
	self:addElement(buttonBacking03)
	self.buttonBacking03 = buttonBacking03
	local buttonBacking04 = LUI.UIImage.new(0.5, 0.5, -528, -330, 1, 1, -174.5, -132.5)
	buttonBacking04:setAlpha(0.8)
	buttonBacking04:setImage(RegisterImage(0x9EBE9E1B70D78CC))
	self:addElement(buttonBacking04)
	self.buttonBacking04 = buttonBacking04
	local buttonFrame01 = LUI.UIImage.new(0.5, 0.5, -313, -115, 1, 1, -125, -73)
	buttonFrame01:setImage(RegisterImage(0x18D8A1BD8B8BC5E))
	buttonFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	buttonFrame01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonFrame01)
	self.buttonFrame01 = buttonFrame01
	local buttonFrame02 = LUI.UIImage.new(0.5, 0.5, 116, 314, 1, 1, -125, -73)
	buttonFrame02:setImage(RegisterImage(0x18D8A1BD8B8BC5E))
	buttonFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	buttonFrame02:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonFrame02)
	self.buttonFrame02 = buttonFrame02
	local buttonFrame03 = LUI.UIImage.new(0.5, 0.5, 330, 528, 1, 1, -175.5, -123.5)
	buttonFrame03:setImage(RegisterImage(0x18D8A1BD8B8BC5E))
	buttonFrame03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	buttonFrame03:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonFrame03)
	self.buttonFrame03 = buttonFrame03
	local buttonFrame04 = LUI.UIImage.new(0.5, 0.5, -528, -330, 1, 1, -175.5, -123.5)
	buttonFrame04:setImage(RegisterImage(0x18D8A1BD8B8BC5E))
	buttonFrame04:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	buttonFrame04:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonFrame04)
	self.buttonFrame04 = buttonFrame04
	local buttonLinks = LUI.UIImage.new(0.5, 0.5, -217, 217, 1, 1, -360, -140)
	buttonLinks:setImage(RegisterImage(0x26D16092FB5EE37))
	buttonLinks:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	buttonLinks:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonLinks)
	self.buttonLinks = buttonLinks
	local buttonEmpty01 = LUI.UIImage.new(0.5, 0.5, -100, 100, 1, 1, -123.5, -79.5)
	buttonEmpty01:setImage(RegisterImage(0xDF5E4D5902EC2EF))
	buttonEmpty01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	buttonEmpty01:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonEmpty01)
	self.buttonEmpty01 = buttonEmpty01
	self:mergeStateConditions({
		{
			stateName = "Codcaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["factions.isCoDCaster"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	if IsPC() then
		SizeToHudArea(f1_local12, f1_arg1)
	end
	return self
end
CoD.vhud_hellstorm_button_all.__resetProperties = function(f7_arg0)
	f7_arg0.buttonFrame02:completeAnimation()
	f7_arg0.buttonBacking02:completeAnimation()
	f7_arg0.buttonFrame01:completeAnimation()
	f7_arg0.buttonBacking01:completeAnimation()
	f7_arg0.buttonEmpty01:completeAnimation()
	f7_arg0.buttonFrame04:completeAnimation()
	f7_arg0.buttonFrame03:completeAnimation()
	f7_arg0.buttonBacking04:completeAnimation()
	f7_arg0.buttonBacking03:completeAnimation()
	f7_arg0.buttonLinks:completeAnimation()
	f7_arg0.buttonFrame02:setAlpha(1)
	f7_arg0.buttonBacking02:setAlpha(0.8)
	f7_arg0.buttonFrame01:setLeftRight(0.5, 0.5, -313, -115)
	f7_arg0.buttonFrame01:setTopBottom(1, 1, -125, -73)
	f7_arg0.buttonFrame01:setAlpha(1)
	f7_arg0.buttonBacking01:setLeftRight(0.5, 0.5, -313, -115)
	f7_arg0.buttonBacking01:setTopBottom(1, 1, -123.5, -81.5)
	f7_arg0.buttonBacking01:setAlpha(0.8)
	f7_arg0.buttonEmpty01:setLeftRight(0.5, 0.5, -100, 100)
	f7_arg0.buttonEmpty01:setTopBottom(1, 1, -123.5, -79.5)
	f7_arg0.buttonEmpty01:setAlpha(1)
	f7_arg0.buttonFrame04:setLeftRight(0.5, 0.5, -528, -330)
	f7_arg0.buttonFrame04:setTopBottom(1, 1, -175.5, -123.5)
	f7_arg0.buttonFrame04:setAlpha(1)
	f7_arg0.buttonFrame03:setLeftRight(0.5, 0.5, 330, 528)
	f7_arg0.buttonFrame03:setTopBottom(1, 1, -175.5, -123.5)
	f7_arg0.buttonFrame03:setAlpha(1)
	f7_arg0.buttonBacking04:setLeftRight(0.5, 0.5, -528, -330)
	f7_arg0.buttonBacking04:setTopBottom(1, 1, -174.5, -132.5)
	f7_arg0.buttonBacking04:setAlpha(0.8)
	f7_arg0.buttonBacking03:setLeftRight(0.5, 0.5, 330, 528)
	f7_arg0.buttonBacking03:setTopBottom(1, 1, -174.5, -132.5)
	f7_arg0.buttonBacking03:setAlpha(0.8)
	f7_arg0.buttonLinks:setLeftRight(0.5, 0.5, -217, 217)
	f7_arg0.buttonLinks:setTopBottom(1, 1, -360, -140)
end
CoD.vhud_hellstorm_button_all.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Codcaster = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(9)
			f9_arg0.buttonBacking01:completeAnimation()
			f9_arg0.buttonBacking01:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonBacking01)
			f9_arg0.buttonBacking02:completeAnimation()
			f9_arg0.buttonBacking02:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonBacking02)
			f9_arg0.buttonBacking03:completeAnimation()
			f9_arg0.buttonBacking03:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonBacking03)
			f9_arg0.buttonBacking04:completeAnimation()
			f9_arg0.buttonBacking04:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonBacking04)
			f9_arg0.buttonFrame01:completeAnimation()
			f9_arg0.buttonFrame01:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonFrame01)
			f9_arg0.buttonFrame02:completeAnimation()
			f9_arg0.buttonFrame02:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonFrame02)
			f9_arg0.buttonFrame03:completeAnimation()
			f9_arg0.buttonFrame03:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonFrame03)
			f9_arg0.buttonFrame04:completeAnimation()
			f9_arg0.buttonFrame04:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonFrame04)
			f9_arg0.buttonEmpty01:completeAnimation()
			f9_arg0.buttonEmpty01:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonEmpty01)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(10)
			f10_arg0.buttonBacking01:completeAnimation()
			f10_arg0.buttonBacking01:setLeftRight(0.5, 0.5, -99, 99)
			f10_arg0.buttonBacking01:setTopBottom(1, 1, -124.5, -82.5)
			f10_arg0.clipFinished(f10_arg0.buttonBacking01)
			f10_arg0.buttonBacking02:completeAnimation()
			f10_arg0.buttonBacking02:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.buttonBacking02)
			f10_arg0.buttonBacking03:completeAnimation()
			f10_arg0.buttonBacking03:setLeftRight(0.5, 0.5, 331, 529)
			f10_arg0.buttonBacking03:setTopBottom(1, 1, -173.5, -131.5)
			f10_arg0.clipFinished(f10_arg0.buttonBacking03)
			f10_arg0.buttonBacking04:completeAnimation()
			f10_arg0.buttonBacking04:setLeftRight(0.5, 0.5, -528, -330)
			f10_arg0.buttonBacking04:setTopBottom(1, 1, -173.5, -131.5)
			f10_arg0.clipFinished(f10_arg0.buttonBacking04)
			f10_arg0.buttonFrame01:completeAnimation()
			f10_arg0.buttonFrame01:setLeftRight(0.5, 0.5, -99, 99)
			f10_arg0.buttonFrame01:setTopBottom(1, 1, -124.5, -72.5)
			f10_arg0.clipFinished(f10_arg0.buttonFrame01)
			f10_arg0.buttonFrame02:completeAnimation()
			f10_arg0.buttonFrame02:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.buttonFrame02)
			f10_arg0.buttonFrame03:completeAnimation()
			f10_arg0.buttonFrame03:setLeftRight(0.5, 0.5, 331, 529)
			f10_arg0.buttonFrame03:setTopBottom(1, 1, -173.5, -121.5)
			f10_arg0.clipFinished(f10_arg0.buttonFrame03)
			f10_arg0.buttonFrame04:completeAnimation()
			f10_arg0.buttonFrame04:setLeftRight(0.5, 0.5, -528, -330)
			f10_arg0.buttonFrame04:setTopBottom(1, 1, -173.5, -121.5)
			f10_arg0.clipFinished(f10_arg0.buttonFrame04)
			f10_arg0.buttonLinks:completeAnimation()
			f10_arg0.buttonLinks:setLeftRight(0.5, 0.5, -217, 217)
			f10_arg0.buttonLinks:setTopBottom(1, 1, -383, -163)
			f10_arg0.clipFinished(f10_arg0.buttonLinks)
			f10_arg0.buttonEmpty01:completeAnimation()
			f10_arg0.buttonEmpty01:setLeftRight(0, 0, 429, 629)
			f10_arg0.buttonEmpty01:setTopBottom(1, 1, -124.5, -80.5)
			f10_arg0.clipFinished(f10_arg0.buttonEmpty01)
		end,
	},
}
