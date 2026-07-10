require("x64:4fb5d5732c72812")
require("x64:246178cf189051b")
CoD.WarzoneQuickInventoryPromptBacking = InheritFrom(LUI.UIElement)
CoD.WarzoneQuickInventoryPromptBacking.__defaultWidth = 150
CoD.WarzoneQuickInventoryPromptBacking.__defaultHeight = 36
CoD.WarzoneQuickInventoryPromptBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneQuickInventoryPromptBacking)
	self.id = "WarzoneQuickInventoryPromptBacking"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local keyPrompt = nil
	keyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 36, 0, 0, 0, 36)
	keyPrompt:setAlpha(0)
	keyPrompt.keybind:setText("")
	self:addElement(keyPrompt)
	self.keyPrompt = keyPrompt
	local progressRing = CoD.ButtonProgressRingContainer.new(f1_arg0, f1_arg1, 0, 0, -3, 39, 0, 0, -3, 39)
	progressRing:setScale(0.81, 0.81)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f1_arg1)
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local buttonPromptImage = LUI.UIImage.new(0, 0, 3, 31, 0, 0, 4, 32)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[0xF4865E3551C3835][0x42F62C12777D074])
				if f3_local0 then
					f3_local0 = IsGamepad(f1_arg1)
					if f3_local0 then
						f3_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3])
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[0xF4865E3551C3835][0x901DFC093ED4187])
				if f4_local0 then
					f4_local0 = IsGamepad(f1_arg1)
					if f4_local0 then
						f4_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3])
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "DisabledPC",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[0xF4865E3551C3835][0x42F62C12777D074])
				if f5_local0 then
					if not IsGamepad(f1_arg1) and not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f5_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3])
						if f5_local0 then
							f5_local0 = IsPC()
						end
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "EnabledPC",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[0xF4865E3551C3835][0x901DFC093ED4187])
				if f6_local0 then
					if not IsGamepad(f1_arg1) and not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f6_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "flags", Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3])
						if f6_local0 then
							f6_local0 = IsPC()
						end
					else
						f6_local0 = false
					end
				end
				return f6_local0
			end,
		},
	})
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f8_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "flags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f11_arg2, f11_arg3, f11_arg4)
		if IsInDefaultState(self) and IsMouseOrKeyboard(controller) then
			DisableMouseButton(self, controller)
			CoD.FreeCursorUtility.CloseContextualPromptPC(self)
		elseif IsMouseOrKeyboard(controller) then
			EnableMouseButton(self, controller)
			CoD.FreeCursorUtility.OpenContextualPromptPC(self)
		elseif IsInDefaultState(self) and IsGamepad(controller) then
			DisableMouseButton(self, controller)
			HideWidget(self)
		elseif IsGamepad(controller) then
			EnableMouseButton(self, controller)
			ShowWidget(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	if IsPC() then
		CoD.PCUtility.SetupButtonPromptForPC(self, f1_arg1, f1_arg0)
		CoD.FreeCursorUtility.UseLocalHeight(self)
		CoD.FreeCursorUtility.SetupHideContextualPromptPC(f1_local5, f1_arg1)
	else
		CoD.FreeCursorUtility.UseLocalHeight(self)
	end
	return self
end
CoD.WarzoneQuickInventoryPromptBacking.__resetProperties = function(f12_arg0)
	f12_arg0.keyPrompt:completeAnimation()
	f12_arg0.keyPrompt:setAlpha(0)
end
CoD.WarzoneQuickInventoryPromptBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Enabled = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	DisabledPC = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.keyPrompt:completeAnimation()
			f16_arg0.keyPrompt:setAlpha(0.5)
			f16_arg0.clipFinished(f16_arg0.keyPrompt)
		end,
	},
	EnabledPC = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.keyPrompt:completeAnimation()
			f17_arg0.keyPrompt:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.keyPrompt)
		end,
	},
}
CoD.WarzoneQuickInventoryPromptBacking.__onClose = function(f18_arg0)
	f18_arg0.keyPrompt:close()
	f18_arg0.progressRing:close()
end
