require("x64:8d52912a320cd2e")
require("x64:e01da863e7cc28f")
require("x64:9690c6fa0e7be3f")
require("x64:8e954fb331b89f8")
require("x64:203538cb29e5bca")
require("x64:8d447a0d3920f3e")
CoD.PlayerWidget = InheritFrom(LUI.UIElement)
CoD.PlayerWidget.__defaultWidth = 358
CoD.PlayerWidget.__defaultHeight = 112
CoD.PlayerWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.lastStand.progress", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.lastStand.beingRevived", 0)
	self:setClass(CoD.PlayerWidget)
	self.id = "PlayerWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArmorPortraitBG = CoD.ArmorPortraitBG.new(f1_arg0, f1_arg1, 0, 0, 307, 399, 0, 0, 22, 86)
	ArmorPortraitBG:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ArmorPortraitBG:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(ArmorPortraitBG)
	self.ArmorPortraitBG = ArmorPortraitBG
	local Blur = LUI.UIImage.new(0, 0, 21, 334, 0, 0, 22, 88)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backer = LUI.UIImage.new(0, 0, -32.5, 334.5, 0, 0, 8, 101)
	Backer:setAlpha(0)
	Backer:setImage(RegisterImage(0xA3887D32AFD1940))
	Backer:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Backer:setShaderVector(0, 0.05, 0.2, 0.05, 0.2)
	self:addElement(Backer)
	self.Backer = Backer
	local PanelLight = LUI.UIImage.new(0, 0, 22.5, 103.5, 0, 0, 21, 87)
	PanelLight:setRGB(0.22, 0.21, 0.19)
	PanelLight:setAlpha(0.75)
	self:addElement(PanelLight)
	self.PanelLight = PanelLight
	local PanelDark = LUI.UIImage.new(0, 0, 103, 334, 0, 0, 21, 87)
	PanelDark:setRGB(0.18, 0.17, 0.16)
	PanelDark:setAlpha(0.94)
	self:addElement(PanelDark)
	self.PanelDark = PanelDark
	local headshotBarBacking = CoD.AmmoWidget_SpecialistEscalation.new(f1_arg0, f1_arg1, 0, 0, 21, 299, 0, 0, -2, 110)
	self:addElement(headshotBarBacking)
	self.headshotBarBacking = headshotBarBacking
	local Frame = LUI.UIImage.new(0, 0, -6, 344, 0, 0, 7, 97)
	Frame:setImage(RegisterImage(0xDABC2B0CF140508))
	self:addElement(Frame)
	self.Frame = Frame
	local AmmoHeal_Prompt = CoD.AmmoWidget_Prompt.new(f1_arg0, f1_arg1, 0, 0, 94, 158, 0, 0, 93, 105)
	AmmoHeal_Prompt:mergeStateConditions({
		{
			stateName = "LowHealth",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsClientModelValueGreaterThan(f1_arg1, "health.healthValue", 0) and CoD.ModelUtility.IsClientModelValueLessThanOrEqualTo(f1_arg1, "health.healthValue", 75)
			end,
		},
	})
	local LEDgraph = AmmoHeal_Prompt
	local BleedOutProgress = AmmoHeal_Prompt.subscribeToModel
	local LEDscreen = Engine[0xE4D2F32833CFA6C](Engine[0x761955642304848](f1_arg1))
	BleedOutProgress(LEDgraph, LEDscreen["health.healthValue"], function(f4_arg0)
		f1_arg0:updateElementState(AmmoHeal_Prompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "health.healthValue",
		})
	end, false)
	AmmoHeal_Prompt:setAlpha(0)
	AmmoHeal_Prompt.PromptText:setText(Engine[0xF9F1239CFD921FE](0x8CADD3D78C04519))
	self:addElement(AmmoHeal_Prompt)
	self.AmmoHeal_Prompt = AmmoHeal_Prompt
	BleedOutProgress = CoD.progressBar.new(f1_arg0, f1_arg1, 0, 0, 157, 315, 0, 0, 51, 63)
	BleedOutProgress:setAlpha(0)
	BleedOutProgress:subscribeToGlobalModel(f1_arg1, "HUDItems", "laststand.progress", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			BleedOutProgress.ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	self:addElement(BleedOutProgress)
	self.BleedOutProgress = BleedOutProgress
	LEDgraph = LUI.UIImage.new(0, 0, -6.5, 343.5, 0, 0, 7, 97)
	LEDgraph:setRGB(0, 0, 0)
	LEDgraph:setAlpha(0.75)
	LEDgraph:setImage(RegisterImage(0xAB34D43D9ABFF83))
	self:addElement(LEDgraph)
	self.LEDgraph = LEDgraph
	LEDscreen = LUI.UIImage.new(0, 0, -5.5, 344.5, 0, 0, 7, 97)
	LEDscreen:setRGB(0, 0, 0)
	LEDscreen:setAlpha(0.2)
	LEDscreen:setImage(RegisterImage(0x45B9712A20EE455))
	self:addElement(LEDscreen)
	self.LEDscreen = LEDscreen
	local HealthValue = CoD.HealthInfo.new(f1_arg0, f1_arg1, 0, 0, -17, 221, 0, 0, 1, 167)
	HealthValue:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HealthValue:setModel(f6_local0, f1_arg1)
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	local Sheen = LUI.UIImage.new(0, 0, -6, 344, 0, 0, 6, 96)
	Sheen:setAlpha(0.01)
	Sheen:setImage(RegisterImage(0xD4F65E240610DC8))
	self:addElement(Sheen)
	self.Sheen = Sheen
	local DemoPip = CoD.DemoPip.new(f1_arg0, f1_arg1, 0, 0, 21, 26, 0, 0, 93, 98)
	self:addElement(DemoPip)
	self.DemoPip = DemoPip
	self:mergeStateConditions({
		{
			stateName = "WZLastStand",
			condition = function(menu, element, event)
				return IsWarzone() and CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand")
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local16(f1_local15, f1_local17["hudItems.lastStand.progress"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.lastStand.progress",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local16(f1_local15, f1_local17["hudItems.lastStand.beingRevived"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.lastStand.beingRevived",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerWidget.__resetProperties = function(f11_arg0)
	f11_arg0.BleedOutProgress:completeAnimation()
	f11_arg0.HealthValue:completeAnimation()
	f11_arg0.BleedOutProgress:setAlpha(0)
	f11_arg0.HealthValue:setAlpha(1)
end
CoD.PlayerWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.BleedOutProgress:completeAnimation()
			f12_arg0.BleedOutProgress:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BleedOutProgress)
			f12_arg0.HealthValue:completeAnimation()
			f12_arg0.HealthValue:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.HealthValue)
		end,
	},
	WZLastStand = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.BleedOutProgress:completeAnimation()
			f13_arg0.BleedOutProgress:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.BleedOutProgress)
			f13_arg0.HealthValue:completeAnimation()
			f13_arg0.HealthValue:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.HealthValue)
		end,
	},
}
CoD.PlayerWidget.__onClose = function(f14_arg0)
	f14_arg0.ArmorPortraitBG:close()
	f14_arg0.headshotBarBacking:close()
	f14_arg0.AmmoHeal_Prompt:close()
	f14_arg0.BleedOutProgress:close()
	f14_arg0.HealthValue:close()
	f14_arg0.DemoPip:close()
end
