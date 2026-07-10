require("x64:bdc4956715f81d7")
CoD.ChangeLayerArrows = InheritFrom(LUI.UIElement)
CoD.ChangeLayerArrows.__defaultWidth = 250
CoD.ChangeLayerArrows.__defaultHeight = 45
CoD.ChangeLayerArrows.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChangeLayerArrows)
	self.id = "ChangeLayerArrows"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0.5)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.75)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local ViewName = LUI.UIText.new(0.5, 0.5, -71, 71, 0.5, 0.5, -7.5, 7.5)
	ViewName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ViewName:setText(Engine[0xF9F1239CFD921FE](0x74E5E31461D378F))
	ViewName:setTTF("ttmussels_demibold")
	ViewName:setLetterSpacing(6)
	ViewName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ViewName:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(ViewName)
	self.ViewName = ViewName
	local ChangeViewRight = CoD.CyclingList_Arrow.new(f1_arg0, f1_arg1, 1, 1, -45, 0, 0.5, 0.5, -22.5, 22.5)
	ChangeViewRight.Image:setRGB(1, 1, 1)
	local f1_local5 = ChangeViewRight
	local ChangeViewLeft = ChangeViewRight.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ChangeViewLeft(f1_local5, f1_local7["Emblem.EmblemProperties.editorMode"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ChangeViewRight:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ChangeViewRight, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_MoveLayer(self, menu, controller, "right")
			PlaySoundSetSound(self, "layer_switch")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ChangeViewRight)
	self.ChangeViewRight = ChangeViewRight
	ChangeViewLeft = CoD.CyclingList_Arrow.new(f1_arg0, f1_arg1, 0, 0, 0, 45, 0.5, 0.5, -22.5, 22.5)
	ChangeViewLeft:setZRot(180)
	ChangeViewLeft.Image:setRGB(1, 1, 1)
	f1_local7 = ChangeViewLeft
	f1_local5 = ChangeViewLeft.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local7, f1_local8["Emblem.EmblemProperties.editorMode"], function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ChangeViewLeft:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ChangeViewLeft, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.CraftUtility.EmblemEditor_MoveLayer(self, menu, controller, "left")
			PlaySoundSetSound(self, "layer_switch")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CraftUtility.IsEditMode(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ChangeViewLeft)
	self.ChangeViewLeft = ChangeViewLeft
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.IsEditMode(f1_arg1)
			end,
		},
	})
	f1_local7 = self
	f1_local5 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local7, f1_local8["Emblem.EmblemProperties.editorMode"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	ChangeViewRight.id = "ChangeViewRight"
	ChangeViewLeft.id = "ChangeViewLeft"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChangeLayerArrows.__resetProperties = function(f12_arg0)
	f12_arg0.ChangeViewLeft:completeAnimation()
	f12_arg0.ChangeViewRight:completeAnimation()
	f12_arg0.ViewName:completeAnimation()
	f12_arg0.NoiseTiledBacking:completeAnimation()
	f12_arg0.Backing:completeAnimation()
	f12_arg0.ChangeViewLeft:setAlpha(1)
	f12_arg0.ChangeViewRight:setAlpha(1)
	f12_arg0.ViewName:setAlpha(1)
	f12_arg0.NoiseTiledBacking:setAlpha(0.75)
	f12_arg0.Backing:setAlpha(0.5)
end
CoD.ChangeLayerArrows.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.Backing:completeAnimation()
			f14_arg0.Backing:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Backing)
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBacking)
			f14_arg0.ViewName:completeAnimation()
			f14_arg0.ViewName:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ViewName)
			f14_arg0.ChangeViewRight:completeAnimation()
			f14_arg0.ChangeViewRight:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ChangeViewRight)
			f14_arg0.ChangeViewLeft:completeAnimation()
			f14_arg0.ChangeViewLeft:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ChangeViewLeft)
		end,
	},
}
CoD.ChangeLayerArrows.__onClose = function(f15_arg0)
	f15_arg0.ChangeViewRight:close()
	f15_arg0.ChangeViewLeft:close()
end
