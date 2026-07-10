require("x64:4d90108dbbf039d")
require("x64:a86bdd41c06859a")
require("x64:bce07fcd345de2a")
CoD.PaintshopBrowseControlsFull = InheritFrom(LUI.UIElement)
CoD.PaintshopBrowseControlsFull.__defaultWidth = 420
CoD.PaintshopBrowseControlsFull.__defaultHeight = 540
CoD.PaintshopBrowseControlsFull.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintshopBrowseControlsFull)
	self.id = "PaintshopBrowseControlsFull"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingMid = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 237, 420)
	BackingMid:setImage(RegisterImage(0x34839E8065B1E53))
	BackingMid:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingMid:setShaderVector(0, 0, 0, 0, 0)
	BackingMid:setupNineSliceShader(196, 88)
	self:addElement(BackingMid)
	self.BackingMid = BackingMid
	local BackingTop = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 0, 190)
	BackingTop:setImage(RegisterImage(0x34839E8065B1E53))
	BackingTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingTop:setShaderVector(0, 0, 0, 0, 0)
	BackingTop:setupNineSliceShader(196, 88)
	self:addElement(BackingTop)
	self.BackingTop = BackingTop
	local SlotsFull = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 420, 460)
	SlotsFull:setAlpha(0)
	SlotsFull.buttonPromptImage:setImage(RegisterImage(0x1F10DEAAEFC50A4))
	SlotsFull.label:setText(Engine[0xF9F1239CFD921FE](0x345431B325139E6))
	self:addElement(SlotsFull)
	self.SlotsFull = SlotsFull
	local SaveGroup = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 380, 420)
	SaveGroup.label:setText(Engine[0xF9F1239CFD921FE](0x345431B325139E6))
	SaveGroup:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_trigger_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SaveGroup.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(SaveGroup)
	self.SaveGroup = SaveGroup
	local GroupLinkedLayers = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 340, 380)
	GroupLinkedLayers.label:setText(Engine[0xF9F1239CFD921FE](0x343441CAE04FDED))
	GroupLinkedLayers:subscribeToGlobalModel(f1_arg1, "VehicleController", "right_shoulder_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GroupLinkedLayers.buttonPromptImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(GroupLinkedLayers)
	self.GroupLinkedLayers = GroupLinkedLayers
	local LinkAll = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 304, 350)
	LinkAll.label:setText(Engine[0xF9F1239CFD921FE](0x18BF56C4998FCB2))
	LinkAll:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_trigger_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			LinkAll.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(LinkAll)
	self.LinkAll = LinkAll
	local LinkLayers = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 264, 304)
	LinkLayers.label:setText(Engine[0xF9F1239CFD921FE](0x972C68080927021))
	LinkLayers:subscribeToGlobalModel(f1_arg1, "VehicleController", "left_shoulder_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			LinkLayers.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(LinkLayers)
	self.LinkLayers = LinkLayers
	local GroupingTitle = CoD.EmblemEditorHeaderRight.new(f1_arg0, f1_arg1, 0, 0, 5, 325, 0, 0, 239, 276)
	GroupingTitle.text:setText(LocalizeToUpperString(0x7619D823AA62EBA))
	self:addElement(GroupingTitle)
	self.GroupingTitle = GroupingTitle
	local NewLayerBelow = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 371, 0, 0, 111, 157)
	NewLayerBelow:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsLayerEmpty(self, self, f1_arg1)
			end,
		},
	})
	NewLayerBelow:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(NewLayerBelow, f7_arg1)
	end)
	local ChangeDecal = NewLayerBelow
	local Cut = NewLayerBelow.subscribeToModel
	local PaintshopChooseSide = Engine[0x4DF5CFBC1771947](f1_arg1)
	Cut(ChangeDecal, PaintshopChooseSide.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(NewLayerBelow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	NewLayerBelow:linkToElementModel(NewLayerBelow, "layerIndex", true, function(model)
		f1_arg0:updateElementState(NewLayerBelow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "layerIndex",
		})
	end)
	NewLayerBelow:linkToElementModel(NewLayerBelow, "iconID", true, function(model)
		f1_arg0:updateElementState(NewLayerBelow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	ChangeDecal = NewLayerBelow
	Cut = NewLayerBelow.subscribeToModel
	PaintshopChooseSide = Engine[0x4DF5CFBC1771947](f1_arg1)
	Cut(ChangeDecal, PaintshopChooseSide["Emblem.EmblemProperties.groupsUsed"], function(f11_arg0)
		f1_arg0:updateElementState(NewLayerBelow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	ChangeDecal = NewLayerBelow
	Cut = NewLayerBelow.subscribeToModel
	PaintshopChooseSide = Engine[0x4DF5CFBC1771947](f1_arg1)
	Cut(ChangeDecal, PaintshopChooseSide["Emblem.EmblemProperties.layersUsed"], function(f12_arg0)
		f1_arg0:updateElementState(NewLayerBelow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	NewLayerBelow.label:setText(Engine[0xF9F1239CFD921FE](0x7E26022B0886ED3))
	NewLayerBelow:subscribeToGlobalModel(f1_arg1, "VehicleController", "dpad_down_button_image", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			NewLayerBelow.buttonPromptImage:setImage(RegisterImage(f13_local0))
		end
	end)
	self:addElement(NewLayerBelow)
	self.NewLayerBelow = NewLayerBelow
	Cut = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 71, 117)
	Cut:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsLayerEmpty(self, self, f1_arg1)
			end,
		},
	})
	Cut:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(Cut, f15_arg1)
	end)
	PaintshopChooseSide = Cut
	ChangeDecal = Cut.subscribeToModel
	local dividerH01 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ChangeDecal(PaintshopChooseSide, dividerH01.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(Cut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	Cut:linkToElementModel(Cut, "layerIndex", true, function(model)
		f1_arg0:updateElementState(Cut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "layerIndex",
		})
	end)
	Cut:linkToElementModel(Cut, "iconID", true, function(model)
		f1_arg0:updateElementState(Cut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	PaintshopChooseSide = Cut
	ChangeDecal = Cut.subscribeToModel
	dividerH01 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ChangeDecal(PaintshopChooseSide, dividerH01["Emblem.EmblemProperties.groupsUsed"], function(f19_arg0)
		f1_arg0:updateElementState(Cut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	PaintshopChooseSide = Cut
	ChangeDecal = Cut.subscribeToModel
	dividerH01 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ChangeDecal(PaintshopChooseSide, dividerH01["Emblem.EmblemProperties.layersUsed"], function(f20_arg0)
		f1_arg0:updateElementState(Cut, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	Cut.label:setText(Engine[0xF9F1239CFD921FE](0xE4FD6AD543818C0))
	Cut:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			Cut.buttonPromptImage:setImage(RegisterImage(f21_local0))
		end
	end)
	self:addElement(Cut)
	self.Cut = Cut
	ChangeDecal = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 33, 79)
	ChangeDecal:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsLayerEmpty(self, self, f1_arg1)
			end,
		},
	})
	ChangeDecal:appendEventHandler("input_source_changed", function(f23_arg0, f23_arg1)
		f23_arg1.menu = f23_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ChangeDecal, f23_arg1)
	end)
	dividerH01 = ChangeDecal
	PaintshopChooseSide = ChangeDecal.subscribeToModel
	local dividerH02 = Engine[0x4DF5CFBC1771947](f1_arg1)
	PaintshopChooseSide(dividerH01, dividerH02.LastInput, function(f24_arg0)
		f1_arg0:updateElementState(ChangeDecal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ChangeDecal:linkToElementModel(ChangeDecal, "layerIndex", true, function(model)
		f1_arg0:updateElementState(ChangeDecal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "layerIndex",
		})
	end)
	ChangeDecal:linkToElementModel(ChangeDecal, "iconID", true, function(model)
		f1_arg0:updateElementState(ChangeDecal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "iconID",
		})
	end)
	dividerH01 = ChangeDecal
	PaintshopChooseSide = ChangeDecal.subscribeToModel
	dividerH02 = Engine[0x4DF5CFBC1771947](f1_arg1)
	PaintshopChooseSide(dividerH01, dividerH02["Emblem.EmblemProperties.groupsUsed"], function(f27_arg0)
		f1_arg0:updateElementState(ChangeDecal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "Emblem.EmblemProperties.groupsUsed",
		})
	end, false)
	dividerH01 = ChangeDecal
	PaintshopChooseSide = ChangeDecal.subscribeToModel
	dividerH02 = Engine[0x4DF5CFBC1771947](f1_arg1)
	PaintshopChooseSide(dividerH01, dividerH02["Emblem.EmblemProperties.layersUsed"], function(f28_arg0)
		f1_arg0:updateElementState(ChangeDecal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	ChangeDecal.label:setText(Engine[0xF9F1239CFD921FE](0x4389B00AC580011))
	ChangeDecal:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			ChangeDecal.buttonPromptImage:setImage(RegisterImage(f29_local0))
		end
	end)
	self:addElement(ChangeDecal)
	self.ChangeDecal = ChangeDecal
	PaintshopChooseSide = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 0, 5, 325, 0, 0, 4, 36)
	PaintshopChooseSide.text:setText(LocalizeToUpperString(0xF5CA503839CA925))
	self:addElement(PaintshopChooseSide)
	self.PaintshopChooseSide = PaintshopChooseSide
	dividerH01 = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 22, 26)
	dividerH01:setAlpha(0.2)
	dividerH01:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH01:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH01:setShaderVector(0, 0, 0, 0, 0)
	dividerH01:setupNineSliceShader(8, 4)
	self:addElement(dividerH01)
	self.dividerH01 = dividerH01
	dividerH02 = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 260, 264)
	dividerH02:setAlpha(0.2)
	dividerH02:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH02:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH02:setShaderVector(0, 0, 0, 0, 0)
	dividerH02:setupNineSliceShader(8, 4)
	self:addElement(dividerH02)
	self.dividerH02 = dividerH02
	local Frame01 = LUI.UIImage.new(0, 1, -1, 1, 0, 0, 0, 190)
	Frame01:setAlpha(0.2)
	Frame01:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame01:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame01:setShaderVector(0, 0, 0, 0, 0)
	Frame01:setupNineSliceShader(16, 16)
	self:addElement(Frame01)
	self.Frame01 = Frame01
	local Frame02 = LUI.UIImage.new(0, 1, -1, 1, 0, 0, 237, 420)
	Frame02:setAlpha(0.2)
	Frame02:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame02:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame02:setShaderVector(0, 0, 0, 0, 0)
	Frame02:setupNineSliceShader(16, 16)
	self:addElement(Frame02)
	self.Frame02 = Frame02
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintshopBrowseControlsFull.__resetProperties = function(f30_arg0)
	f30_arg0.SaveGroup:completeAnimation()
	f30_arg0.GroupLinkedLayers:completeAnimation()
	f30_arg0.ChangeDecal:completeAnimation()
	f30_arg0.Cut:completeAnimation()
	f30_arg0.NewLayerBelow:completeAnimation()
	f30_arg0.LinkAll:completeAnimation()
	f30_arg0.GroupingTitle:completeAnimation()
	f30_arg0.PaintshopChooseSide:completeAnimation()
	f30_arg0.BackingTop:completeAnimation()
	f30_arg0.BackingMid:completeAnimation()
	f30_arg0.Frame02:completeAnimation()
	f30_arg0.Frame01:completeAnimation()
	f30_arg0.dividerH02:completeAnimation()
	f30_arg0.dividerH01:completeAnimation()
	f30_arg0.LinkLayers:completeAnimation()
	f30_arg0.SlotsFull:completeAnimation()
	f30_arg0.SaveGroup:setAlpha(1)
	f30_arg0.GroupLinkedLayers:setAlpha(1)
	f30_arg0.GroupLinkedLayers.label:setText(Engine[0xF9F1239CFD921FE](0x343441CAE04FDED))
	f30_arg0.ChangeDecal:setAlpha(1)
	f30_arg0.Cut:setAlpha(1)
	f30_arg0.NewLayerBelow:setAlpha(1)
	f30_arg0.LinkAll:setAlpha(1)
	f30_arg0.GroupingTitle:setAlpha(1)
	f30_arg0.PaintshopChooseSide:setAlpha(1)
	f30_arg0.BackingTop:setAlpha(1)
	f30_arg0.BackingMid:setTopBottom(0, 0, 237, 420)
	f30_arg0.BackingMid:setAlpha(1)
	f30_arg0.Frame02:setLeftRight(0, 1, -1, 1)
	f30_arg0.Frame02:setTopBottom(0, 0, 237, 420)
	f30_arg0.Frame02:setAlpha(0.2)
	f30_arg0.Frame01:setAlpha(0.2)
	f30_arg0.dividerH02:setAlpha(0.2)
	f30_arg0.dividerH01:setAlpha(0.2)
	f30_arg0.LinkLayers:setAlpha(1)
	f30_arg0.LinkLayers.label:setText(Engine[0xF9F1239CFD921FE](0x972C68080927021))
	f30_arg0.SlotsFull:setTopBottom(0, 0, 420, 460)
	f30_arg0.SlotsFull:setRGB(1, 1, 1)
	f30_arg0.SlotsFull:setAlpha(0)
	f30_arg0.SlotsFull.buttonPromptImage:setImage(RegisterImage(0x1F10DEAAEFC50A4))
	f30_arg0.SlotsFull.label:setText(Engine[0xF9F1239CFD921FE](0x345431B325139E6))
end
CoD.PaintshopBrowseControlsFull.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.SaveGroup:completeAnimation()
			f31_arg0.SaveGroup:setAlpha(0.2)
			f31_arg0.clipFinished(f31_arg0.SaveGroup)
			f31_arg0.GroupLinkedLayers:completeAnimation()
			f31_arg0.GroupLinkedLayers:setAlpha(0.2)
			f31_arg0.clipFinished(f31_arg0.GroupLinkedLayers)
		end,
	},
	EditModeControlsState = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(15)
			f32_arg0.BackingMid:completeAnimation()
			f32_arg0.BackingMid:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.BackingMid)
			f32_arg0.BackingTop:completeAnimation()
			f32_arg0.BackingTop:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.BackingTop)
			f32_arg0.SaveGroup:completeAnimation()
			f32_arg0.SaveGroup:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.SaveGroup)
			f32_arg0.GroupLinkedLayers:completeAnimation()
			f32_arg0.GroupLinkedLayers:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.GroupLinkedLayers)
			f32_arg0.LinkAll:completeAnimation()
			f32_arg0.LinkAll:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.LinkAll)
			f32_arg0.LinkLayers:completeAnimation()
			f32_arg0.LinkLayers:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.LinkLayers)
			f32_arg0.GroupingTitle:completeAnimation()
			f32_arg0.GroupingTitle:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.GroupingTitle)
			f32_arg0.NewLayerBelow:completeAnimation()
			f32_arg0.NewLayerBelow:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.NewLayerBelow)
			f32_arg0.Cut:completeAnimation()
			f32_arg0.Cut:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Cut)
			f32_arg0.ChangeDecal:completeAnimation()
			f32_arg0.ChangeDecal:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ChangeDecal)
			f32_arg0.PaintshopChooseSide:completeAnimation()
			f32_arg0.PaintshopChooseSide:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.PaintshopChooseSide)
			f32_arg0.dividerH01:completeAnimation()
			f32_arg0.dividerH01:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.dividerH01)
			f32_arg0.dividerH02:completeAnimation()
			f32_arg0.dividerH02:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.dividerH02)
			f32_arg0.Frame01:completeAnimation()
			f32_arg0.Frame01:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Frame01)
			f32_arg0.Frame02:completeAnimation()
			f32_arg0.Frame02:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Frame02)
		end,
	},
	BrowseLayersLinked = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.SaveGroup:completeAnimation()
			f33_arg0.SaveGroup:setAlpha(0.2)
			f33_arg0.clipFinished(f33_arg0.SaveGroup)
			f33_arg0.LinkLayers:completeAnimation()
			f33_arg0.LinkLayers.label:completeAnimation()
			f33_arg0.LinkLayers.label:setText(Engine[0xF9F1239CFD921FE](0x82789B43F936B78))
			f33_arg0.clipFinished(f33_arg0.LinkLayers)
		end,
	},
	BrowseLayerGrouped = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(3)
			f34_arg0.GroupLinkedLayers:completeAnimation()
			f34_arg0.GroupLinkedLayers.label:completeAnimation()
			f34_arg0.GroupLinkedLayers.label:setText(Engine[0xF9F1239CFD921FE](0x6EA1EDF54B8F820))
			f34_arg0.clipFinished(f34_arg0.GroupLinkedLayers)
			f34_arg0.LinkAll:completeAnimation()
			f34_arg0.LinkAll:setAlpha(0.2)
			f34_arg0.clipFinished(f34_arg0.LinkAll)
			f34_arg0.LinkLayers:completeAnimation()
			f34_arg0.LinkLayers:setAlpha(0.2)
			f34_arg0.clipFinished(f34_arg0.LinkLayers)
		end,
	},
	BrowseLayerGroupedMax = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(7)
			f35_arg0.BackingMid:completeAnimation()
			f35_arg0.BackingMid:setTopBottom(0, 0, 237, 460)
			f35_arg0.clipFinished(f35_arg0.BackingMid)
			f35_arg0.SlotsFull:completeAnimation()
			f35_arg0.SlotsFull.buttonPromptImage:completeAnimation()
			f35_arg0.SlotsFull.label:completeAnimation()
			f35_arg0.SlotsFull:setTopBottom(0, 0, 420, 460)
			f35_arg0.SlotsFull:setRGB(1, 0, 0)
			f35_arg0.SlotsFull:setAlpha(1)
			f35_arg0.SlotsFull.buttonPromptImage:setImage(RegisterImage(0x1F10DEAAEFC50A4))
			f35_arg0.SlotsFull.label:setText(Engine[0xF9F1239CFD921FE](0x35E24C3255091DF))
			f35_arg0.clipFinished(f35_arg0.SlotsFull)
			f35_arg0.SaveGroup:completeAnimation()
			f35_arg0.SaveGroup:setAlpha(0.2)
			f35_arg0.clipFinished(f35_arg0.SaveGroup)
			f35_arg0.GroupLinkedLayers:completeAnimation()
			f35_arg0.GroupLinkedLayers.label:completeAnimation()
			f35_arg0.GroupLinkedLayers.label:setText(Engine[0xF9F1239CFD921FE](0x6EA1EDF54B8F820))
			f35_arg0.clipFinished(f35_arg0.GroupLinkedLayers)
			f35_arg0.LinkAll:completeAnimation()
			f35_arg0.LinkAll:setAlpha(0.2)
			f35_arg0.clipFinished(f35_arg0.LinkAll)
			f35_arg0.LinkLayers:completeAnimation()
			f35_arg0.LinkLayers:setAlpha(0.2)
			f35_arg0.clipFinished(f35_arg0.LinkLayers)
			f35_arg0.Frame02:completeAnimation()
			f35_arg0.Frame02:setLeftRight(0, 1, -1, 1)
			f35_arg0.Frame02:setTopBottom(0, 0, 238, 459)
			f35_arg0.clipFinished(f35_arg0.Frame02)
		end,
	},
	BrowseEmptyLayer = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(4)
			f36_arg0.SaveGroup:completeAnimation()
			f36_arg0.SaveGroup:setAlpha(0.2)
			f36_arg0.clipFinished(f36_arg0.SaveGroup)
			f36_arg0.GroupLinkedLayers:completeAnimation()
			f36_arg0.GroupLinkedLayers:setAlpha(0.2)
			f36_arg0.clipFinished(f36_arg0.GroupLinkedLayers)
			f36_arg0.LinkAll:completeAnimation()
			f36_arg0.LinkAll:setAlpha(0.2)
			f36_arg0.clipFinished(f36_arg0.LinkAll)
			f36_arg0.LinkLayers:completeAnimation()
			f36_arg0.LinkLayers:setAlpha(0.2)
			f36_arg0.clipFinished(f36_arg0.LinkLayers)
		end,
	},
}
CoD.PaintshopBrowseControlsFull.__onClose = function(f37_arg0)
	f37_arg0.SlotsFull:close()
	f37_arg0.SaveGroup:close()
	f37_arg0.GroupLinkedLayers:close()
	f37_arg0.LinkAll:close()
	f37_arg0.LinkLayers:close()
	f37_arg0.GroupingTitle:close()
	f37_arg0.NewLayerBelow:close()
	f37_arg0.Cut:close()
	f37_arg0.ChangeDecal:close()
	f37_arg0.PaintshopChooseSide:close()
end
