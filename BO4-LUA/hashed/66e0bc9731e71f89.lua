require("x64:a9255c570c68aa8")
require("x64:494359e7c2de09a")
CoD.ZMInvWonderWeaponComponent = InheritFrom(LUI.UIElement)
CoD.ZMInvWonderWeaponComponent.__defaultWidth = 80
CoD.ZMInvWonderWeaponComponent.__defaultHeight = 80
CoD.ZMInvWonderWeaponComponent.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvWonderWeaponComponent)
	self.id = "ZMInvWonderWeaponComponent"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0.05, 0.05, 7.5, 107.5, 0, 0, 14, 114)
	Backing:setAlpha(0)
	Backing:setImage(RegisterImage(@"hash_5198E62429893867"))
	self:addElement(Backing)
	self.Backing = Backing
	local Stage7Image = CoD.ZMInvStageImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Stage7Image:setAlpha(0)
	Stage7Image:linkToElementModel(self, "image7", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Stage7Image.Stage1Image:setImage(RegisterImage(f2_local0))
		end
	end)
	Stage7Image:linkToElementModel(self, "numNeeded7", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Stage7Image.Stage1Image:setShaderVector(0, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))))
		end
	end)
	Stage7Image:linkToElementModel(self, "numAcquired", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Stage7Image.Stage1Image:setShaderVector(1, CoD.ZMInventoryUtility.NumStageItemsAcquiredToWipe(self:getModel(), CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	self:addElement(Stage7Image)
	self.Stage7Image = Stage7Image
	local Stage6Image = CoD.ZMInvStageImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Stage6Image:setAlpha(0)
	Stage6Image:linkToElementModel(self, "image6", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Stage6Image.Stage1Image:setImage(RegisterImage(f5_local0))
		end
	end)
	Stage6Image:linkToElementModel(self, "numNeeded6", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Stage6Image.Stage1Image:setShaderVector(0, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))))
		end
	end)
	Stage6Image:linkToElementModel(self, "numAcquired", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Stage6Image.Stage1Image:setShaderVector(1, CoD.ZMInventoryUtility.NumStageItemsAcquiredToWipe(self:getModel(), CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4)))
		end
	end)
	self:addElement(Stage6Image)
	self.Stage6Image = Stage6Image
	local Stage5Image = CoD.ZMInvStageImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Stage5Image:setAlpha(0)
	Stage5Image:linkToElementModel(self, "image5", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Stage5Image.Stage1Image:setImage(RegisterImage(f8_local0))
		end
	end)
	Stage5Image:linkToElementModel(self, "numNeeded5", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Stage5Image.Stage1Image:setShaderVector(0, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4))))
		end
	end)
	Stage5Image:linkToElementModel(self, "numAcquired", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Stage5Image.Stage1Image:setShaderVector(1, CoD.ZMInventoryUtility.NumStageItemsAcquiredToWipe(self:getModel(), CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4)))
		end
	end)
	self:addElement(Stage5Image)
	self.Stage5Image = Stage5Image
	local Stage4Image = CoD.ZMInvStageImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Stage4Image:setAlpha(0)
	Stage4Image:linkToElementModel(self, "image4", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Stage4Image.Stage1Image:setImage(RegisterImage(f11_local0))
		end
	end)
	Stage4Image:linkToElementModel(self, "numNeeded4", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Stage4Image.Stage1Image:setShaderVector(0, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f12_local0, 1), CoD.GetVectorComponentFromString(f12_local0, 2), CoD.GetVectorComponentFromString(f12_local0, 3), CoD.GetVectorComponentFromString(f12_local0, 4))))
		end
	end)
	Stage4Image:linkToElementModel(self, "numAcquired", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Stage4Image.Stage1Image:setShaderVector(1, CoD.ZMInventoryUtility.NumStageItemsAcquiredToWipe(self:getModel(), CoD.GetVectorComponentFromString(f13_local0, 1), CoD.GetVectorComponentFromString(f13_local0, 2), CoD.GetVectorComponentFromString(f13_local0, 3), CoD.GetVectorComponentFromString(f13_local0, 4)))
		end
	end)
	self:addElement(Stage4Image)
	self.Stage4Image = Stage4Image
	local Stage3Image = CoD.ZMInvStageImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Stage3Image:setAlpha(0)
	Stage3Image:linkToElementModel(self, "image3", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Stage3Image.Stage1Image:setImage(RegisterImage(f14_local0))
		end
	end)
	Stage3Image:linkToElementModel(self, "numNeeded3", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			Stage3Image.Stage1Image:setShaderVector(0, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f15_local0, 1), CoD.GetVectorComponentFromString(f15_local0, 2), CoD.GetVectorComponentFromString(f15_local0, 3), CoD.GetVectorComponentFromString(f15_local0, 4))))
		end
	end)
	Stage3Image:linkToElementModel(self, "numAcquired", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			Stage3Image.Stage1Image:setShaderVector(1, CoD.ZMInventoryUtility.NumStageItemsAcquiredToWipe(self:getModel(), CoD.GetVectorComponentFromString(f16_local0, 1), CoD.GetVectorComponentFromString(f16_local0, 2), CoD.GetVectorComponentFromString(f16_local0, 3), CoD.GetVectorComponentFromString(f16_local0, 4)))
		end
	end)
	self:addElement(Stage3Image)
	self.Stage3Image = Stage3Image
	local Stage2Image = CoD.ZMInvStageImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Stage2Image:setAlpha(0)
	Stage2Image:linkToElementModel(self, "image2", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			Stage2Image.Stage1Image:setImage(RegisterImage(f17_local0))
		end
	end)
	Stage2Image:linkToElementModel(self, "numNeeded2", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			Stage2Image.Stage1Image:setShaderVector(0, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f18_local0, 1), CoD.GetVectorComponentFromString(f18_local0, 2), CoD.GetVectorComponentFromString(f18_local0, 3), CoD.GetVectorComponentFromString(f18_local0, 4))))
		end
	end)
	Stage2Image:linkToElementModel(self, "numAcquired", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			Stage2Image.Stage1Image:setShaderVector(1, CoD.ZMInventoryUtility.NumStageItemsAcquiredToWipe(self:getModel(), CoD.GetVectorComponentFromString(f19_local0, 1), CoD.GetVectorComponentFromString(f19_local0, 2), CoD.GetVectorComponentFromString(f19_local0, 3), CoD.GetVectorComponentFromString(f19_local0, 4)))
		end
	end)
	self:addElement(Stage2Image)
	self.Stage2Image = Stage2Image
	local Stage1Image = CoD.ZMInvStageImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Stage1Image:setAlpha(0)
	Stage1Image:linkToElementModel(self, "image1", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			Stage1Image.Stage1Image:setImage(RegisterImage(f20_local0))
		end
	end)
	Stage1Image:linkToElementModel(self, "numNeeded1", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			Stage1Image.Stage1Image:setShaderVector(0, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f21_local0, 1), CoD.GetVectorComponentFromString(f21_local0, 2), CoD.GetVectorComponentFromString(f21_local0, 3), CoD.GetVectorComponentFromString(f21_local0, 4))))
		end
	end)
	Stage1Image:linkToElementModel(self, "numAcquired", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			Stage1Image.Stage1Image:setShaderVector(1, CoD.ZMInventoryUtility.NumStageItemsAcquiredToWipe(self:getModel(), CoD.GetVectorComponentFromString(f22_local0, 1), CoD.GetVectorComponentFromString(f22_local0, 2), CoD.GetVectorComponentFromString(f22_local0, 3), CoD.GetVectorComponentFromString(f22_local0, 4)))
		end
	end)
	self:addElement(Stage1Image)
	self.Stage1Image = Stage1Image
	local MainFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -30, 30)
	MainFrame:setAlpha(0.1)
	self:addElement(MainFrame)
	self.MainFrame = MainFrame
	self:mergeStateConditions({
		{
			stateName = "Stage1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 1)
			end,
		},
		{
			stateName = "Stage2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 2)
			end,
		},
		{
			stateName = "Stage3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 3)
			end,
		},
		{
			stateName = "Stage4",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 4)
			end,
		},
		{
			stateName = "Stage5",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 5)
			end,
		},
		{
			stateName = "Stage6",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 6)
			end,
		},
		{
			stateName = "Stage7",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "stage", 7)
			end,
		},
	})
	self:linkToElementModel(self, "stage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stage",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvWonderWeaponComponent.__resetProperties = function(f31_arg0)
	f31_arg0.Stage1Image:completeAnimation()
	f31_arg0.Stage2Image:completeAnimation()
	f31_arg0.Stage3Image:completeAnimation()
	f31_arg0.Stage4Image:completeAnimation()
	f31_arg0.Stage5Image:completeAnimation()
	f31_arg0.Stage6Image:completeAnimation()
	f31_arg0.Stage7Image:completeAnimation()
	f31_arg0.Stage1Image:setAlpha(0)
	f31_arg0.Stage2Image:setAlpha(0)
	f31_arg0.Stage3Image:setAlpha(0)
	f31_arg0.Stage4Image:setAlpha(0)
	f31_arg0.Stage5Image:setAlpha(0)
	f31_arg0.Stage6Image:setAlpha(0)
	f31_arg0.Stage7Image:setAlpha(0)
end
CoD.ZMInvWonderWeaponComponent.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
	},
	Stage1 = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.Stage1Image:completeAnimation()
			f33_arg0.Stage1Image:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.Stage1Image)
		end,
	},
	Stage2 = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.Stage2Image:completeAnimation()
			f34_arg0.Stage2Image:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.Stage2Image)
		end,
	},
	Stage3 = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.Stage3Image:completeAnimation()
			f35_arg0.Stage3Image:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.Stage3Image)
		end,
	},
	Stage4 = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.Stage4Image:completeAnimation()
			f36_arg0.Stage4Image:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.Stage4Image)
		end,
	},
	Stage5 = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(1)
			f37_arg0.Stage5Image:completeAnimation()
			f37_arg0.Stage5Image:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.Stage5Image)
		end,
	},
	Stage6 = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.Stage6Image:completeAnimation()
			f38_arg0.Stage6Image:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.Stage6Image)
		end,
	},
	Stage7 = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			f39_arg0.Stage7Image:completeAnimation()
			f39_arg0.Stage7Image:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.Stage7Image)
		end,
	},
}
CoD.ZMInvWonderWeaponComponent.__onClose = function(f40_arg0)
	f40_arg0.Stage7Image:close()
	f40_arg0.Stage6Image:close()
	f40_arg0.Stage5Image:close()
	f40_arg0.Stage4Image:close()
	f40_arg0.Stage3Image:close()
	f40_arg0.Stage2Image:close()
	f40_arg0.Stage1Image:close()
	f40_arg0.MainFrame:close()
end
