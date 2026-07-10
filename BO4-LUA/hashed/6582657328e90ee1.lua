require("x64:49297d254ade04b")
require("x64:b7247b8f2275336")
CoD.PlayerWidgetWZArmor = InheritFrom(LUI.UIElement)
CoD.PlayerWidgetWZArmor.__defaultWidth = 64
CoD.PlayerWidgetWZArmor.__defaultHeight = 64
CoD.PlayerWidgetWZArmor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerWidgetWZArmor)
	self.id = "PlayerWidgetWZArmor"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DestroyedLightArmorIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DestroyedLightArmorIcon:setAlpha(0)
	DestroyedLightArmorIcon:setImage(RegisterImage(0xF1E0335FF8DEB6A))
	DestroyedLightArmorIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x72987F9CD841ED7))
	DestroyedLightArmorIcon:setShaderVector(0, 10, 1, 0, 0)
	DestroyedLightArmorIcon:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(DestroyedLightArmorIcon)
	self.DestroyedLightArmorIcon = DestroyedLightArmorIcon
	local DestroyedMediumArmorIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DestroyedMediumArmorIcon:setAlpha(0)
	DestroyedMediumArmorIcon:setImage(RegisterImage(0xAE6641012ACAE2D))
	DestroyedMediumArmorIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x72987F9CD841ED7))
	DestroyedMediumArmorIcon:setShaderVector(0, 10, 1, 0, 0)
	DestroyedMediumArmorIcon:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(DestroyedMediumArmorIcon)
	self.DestroyedMediumArmorIcon = DestroyedMediumArmorIcon
	local DestroyedHeavyArmorIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DestroyedHeavyArmorIcon:setAlpha(0)
	DestroyedHeavyArmorIcon:setImage(RegisterImage(0x449615C08D1A18D))
	DestroyedHeavyArmorIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x72987F9CD841ED7))
	DestroyedHeavyArmorIcon:setShaderVector(0, 10, 1, 0, 0)
	DestroyedHeavyArmorIcon:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(DestroyedHeavyArmorIcon)
	self.DestroyedHeavyArmorIcon = DestroyedHeavyArmorIcon
	local f1_local4 = nil
	local CastTimeShard0 = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	CastTimeShard0:setLeftRight(0.5, 0.5, -16, 16)
	CastTimeShard0:setTopBottom(0.5, 0.5, -16, 16)
	CastTimeShard0:setWidgetType(CoD.WarzoneCastTimeContainer)
	CastTimeShard0:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CastTimeShard0:setDataSource("WarzoneShards")
	self:addElement(CastTimeShard0)
	self.CastTimeShard0 = CastTimeShard0
	local ArmorIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ArmorIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x72987F9CD841ED7))
	ArmorIcon:setShaderVector(0, 10, 1, 0, 0)
	ArmorIcon:subscribeToGlobalModel(f1_arg1, "HUDItems", "armorType", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ArmorIcon:setImage(RegisterImage(CoD.WZUtility.GetArmorFlipbookIconForArmorTier(f2_local0)))
		end
	end)
	ArmorIcon.__Frame = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			ArmorIcon:setShaderVector(1, CoD.WZUtility.GetArmorFlipbookFrame(self:getModel(), f1_arg1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end
	ArmorIcon:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f4_arg1)
		if f4_arg1["__ArmorIcon.__Frame_predictedClientModel->armor"] then
			f4_arg1:removeSubscription(f4_arg1["__ArmorIcon.__Frame_predictedClientModel->armor"])
			f4_arg1["__ArmorIcon.__Frame_predictedClientModel->armor"] = nil
		end
		if model then
			local f4_local0 = model:get()
			local f4_local1 = model:get()
			model = f4_local0 and f4_local1.armor
		end
		if model then
			f4_arg1["__ArmorIcon.__Frame_predictedClientModel->armor"] = f4_arg1:subscribeToModel(model, ArmorIcon.__Frame)
		end
	end)
	ArmorIcon.__Frame_FullPath = function()
		local f5_local0 = DataSources.PerController.getModel(f1_arg1)
		f5_local0 = f5_local0.predictedClientModel
		if f5_local0 then
			f5_local0 = f5_local0:get()
		end
		if f5_local0 then
			f5_local0 = f5_local0.armor
		end
		if f5_local0 then
			ArmorIcon.__Frame(f5_local0)
		end
	end
	self:addElement(ArmorIcon)
	self.ArmorIcon = ArmorIcon
	local NotAvailable = nil
	NotAvailable = CoD.AmmoWidgetWZArmorShardUnavailable_PC.new(f1_arg0, f1_arg1, 0, 0, -2, 62, 0, 0, 4, 63)
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	ArmorIcon:linkToElementModel(self, "armorMax", true, ArmorIcon.__Frame_FullPath)
	self:mergeStateConditions({
		{
			stateName = "HeavyArmor",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "hudItems.armorType", 3)
			end,
		},
		{
			stateName = "MediumArmor",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "hudItems.armorType", 2)
			end,
		},
		{
			stateName = "LightArmor",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f1_arg1, "hudItems.armorType", 1)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.armorType"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.armorType",
		})
	end, false)
	CastTimeShard0.id = "CastTimeShard0"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerWidgetWZArmor.__resetProperties = function(f10_arg0)
	f10_arg0.ArmorIcon:completeAnimation()
	f10_arg0.DestroyedHeavyArmorIcon:completeAnimation()
	f10_arg0.DestroyedMediumArmorIcon:completeAnimation()
	f10_arg0.DestroyedLightArmorIcon:completeAnimation()
	f10_arg0.ArmorIcon:setAlpha(1)
	f10_arg0.DestroyedHeavyArmorIcon:setRGB(1, 1, 1)
	f10_arg0.DestroyedHeavyArmorIcon:setAlpha(0)
	f10_arg0.DestroyedHeavyArmorIcon:setScale(1, 1)
	f10_arg0.DestroyedMediumArmorIcon:setRGB(1, 1, 1)
	f10_arg0.DestroyedMediumArmorIcon:setAlpha(0)
	f10_arg0.DestroyedMediumArmorIcon:setScale(1, 1)
	f10_arg0.DestroyedLightArmorIcon:setRGB(1, 1, 1)
	f10_arg0.DestroyedLightArmorIcon:setAlpha(0)
	f10_arg0.DestroyedLightArmorIcon:setScale(1, 1)
end
CoD.PlayerWidgetWZArmor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ArmorIcon:completeAnimation()
			f11_arg0.ArmorIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ArmorIcon)
		end,
	},
	HeavyArmor = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.DestroyedHeavyArmorIcon:beginAnimation(100)
				f13_arg0.DestroyedHeavyArmorIcon:setRGB(1, 0, 0)
				f13_arg0.DestroyedHeavyArmorIcon:setAlpha(0)
				f13_arg0.DestroyedHeavyArmorIcon:setScale(1.3, 1.3)
				f13_arg0.DestroyedHeavyArmorIcon:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.DestroyedHeavyArmorIcon:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.DestroyedHeavyArmorIcon:completeAnimation()
			f13_arg0.DestroyedHeavyArmorIcon:setRGB(1, 1, 1)
			f13_arg0.DestroyedHeavyArmorIcon:setAlpha(1)
			f13_arg0.DestroyedHeavyArmorIcon:setScale(1, 1)
			f13_local0(f13_arg0.DestroyedHeavyArmorIcon)
			f13_arg0.ArmorIcon:completeAnimation()
			f13_arg0.ArmorIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ArmorIcon)
		end,
	},
	MediumArmor = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			local f16_local0 = function(f17_arg0)
				f16_arg0.DestroyedMediumArmorIcon:beginAnimation(100)
				f16_arg0.DestroyedMediumArmorIcon:setRGB(1, 0, 0)
				f16_arg0.DestroyedMediumArmorIcon:setAlpha(0)
				f16_arg0.DestroyedMediumArmorIcon:setScale(1.3, 1.3)
				f16_arg0.DestroyedMediumArmorIcon:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.DestroyedMediumArmorIcon:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.DestroyedMediumArmorIcon:completeAnimation()
			f16_arg0.DestroyedMediumArmorIcon:setRGB(1, 1, 1)
			f16_arg0.DestroyedMediumArmorIcon:setAlpha(1)
			f16_arg0.DestroyedMediumArmorIcon:setScale(1, 1)
			f16_local0(f16_arg0.DestroyedMediumArmorIcon)
			f16_arg0.ArmorIcon:completeAnimation()
			f16_arg0.ArmorIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ArmorIcon)
		end,
	},
	LightArmor = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				f19_arg0.DestroyedLightArmorIcon:beginAnimation(100)
				f19_arg0.DestroyedLightArmorIcon:setRGB(1, 0, 0)
				f19_arg0.DestroyedLightArmorIcon:setAlpha(0)
				f19_arg0.DestroyedLightArmorIcon:setScale(1.3, 1.3)
				f19_arg0.DestroyedLightArmorIcon:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.DestroyedLightArmorIcon:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.DestroyedLightArmorIcon:completeAnimation()
			f19_arg0.DestroyedLightArmorIcon:setRGB(1, 1, 1)
			f19_arg0.DestroyedLightArmorIcon:setAlpha(1)
			f19_arg0.DestroyedLightArmorIcon:setScale(1, 1)
			f19_local0(f19_arg0.DestroyedLightArmorIcon)
			f19_arg0.ArmorIcon:completeAnimation()
			f19_arg0.ArmorIcon:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ArmorIcon)
		end,
	},
}
CoD.PlayerWidgetWZArmor.__onClose = function(f21_arg0)
	f21_arg0.CastTimeShard0:close()
	f21_arg0.ArmorIcon:close()
	f21_arg0.NotAvailable:close()
end
