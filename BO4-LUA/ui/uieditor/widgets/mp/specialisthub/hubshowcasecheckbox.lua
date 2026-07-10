require("x64:d7e092479c7b82c")
require("x64:12d199c0b6f6540")
CoD.HubShowcaseCheckbox = InheritFrom(LUI.UIElement)
CoD.HubShowcaseCheckbox.__defaultWidth = 38
CoD.HubShowcaseCheckbox.__defaultHeight = 39
CoD.HubShowcaseCheckbox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubShowcaseCheckbox)
	self.id = "HubShowcaseCheckbox"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 0, 0, 36, 0, 0, 0, 36)
	self:addElement(Border)
	self.Border = Border
	local BorderAdd = CoD.Border.new(f1_arg0, f1_arg1, 0, 0, 0, 36, 0, 0, 0, 36)
	self:addElement(BorderAdd)
	self.BorderAdd = BorderAdd
	local label = LUI.UIText.new(0, 0, 98, 245, 0, 0, 5.5, 31.5)
	label:setRGB(0.92, 0.92, 0.92)
	label:setAlpha(0.5)
	label:setText("")
	label:setTTF("ttmussels_regular")
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(label)
	self.label = label
	local Empty = LUI.UIImage.new(0, 0, -5, 43, 0, 0, -6, 42)
	Empty:setScale(0.67, 0.67)
	Empty:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_selectbox_empty"))
	Empty:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Empty)
	self.Empty = Empty
	local dashBacking = LUI.UIImage.new(0, 0, 3, 35, 0, 0, 2.5, 34.5)
	dashBacking:setScale(1.5, 1.5)
	dashBacking:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_empty"))
	self:addElement(dashBacking)
	self.dashBacking = dashBacking
	local dash = LUI.UIImage.new(0, 0, 3, 35, 0, 0, 2.5, 34.5)
	dash:setScale(1.5, 1.5)
	dash:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_full"))
	self:addElement(dash)
	self.dash = dash
	local Glow = LUI.UIImage.new(0, 0, -1.5, 40.5, 0, 0, -17.5, 55.5)
	Glow:setRGB(0.88, 0.8, 0.45)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_t7_menu_cac_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local CornerDots = LUI.UIImage.new(0, 0, 3, 35, 0, 0, 2.5, 34.5)
	CornerDots:setScale(1.5, 1.5)
	CornerDots:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_dots"))
	self:addElement(CornerDots)
	self.CornerDots = CornerDots
	local CursorOver = LUI.UIImage.new(0, 0, -3, 41, 0, 0, -3.5, 40.5)
	CursorOver:setAlpha(0)
	CursorOver:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_over"))
	self:addElement(CursorOver)
	self.CursorOver = CursorOver
	local squarePrompt = CoD.JoinButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 47, 86, 0, 0, 0, 39)
	squarePrompt.KMprompt:setText(CoD.BaseUtility.AlreadyLocalized("C"))
	squarePrompt:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			squarePrompt.GpadButtonImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(squarePrompt)
	self.squarePrompt = squarePrompt
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "PCHidden",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubShowcaseCheckbox.__resetProperties = function(f8_arg0)
	f8_arg0.CornerDots:completeAnimation()
	f8_arg0.dash:completeAnimation()
	f8_arg0.dashBacking:completeAnimation()
	f8_arg0.Glow:completeAnimation()
	f8_arg0.BorderAdd:completeAnimation()
	f8_arg0.Border:completeAnimation()
	f8_arg0.label:completeAnimation()
	f8_arg0.Empty:completeAnimation()
	f8_arg0.CursorOver:completeAnimation()
	f8_arg0.squarePrompt:completeAnimation()
	f8_arg0.CornerDots:setAlpha(1)
	f8_arg0.dash:setAlpha(1)
	f8_arg0.dashBacking:setAlpha(1)
	f8_arg0.Glow:setAlpha(0)
	f8_arg0.BorderAdd:setAlpha(1)
	f8_arg0.Border:setAlpha(1)
	f8_arg0.label:setAlpha(0.5)
	f8_arg0.Empty:setAlpha(1)
	f8_arg0.CursorOver:setAlpha(0)
	f8_arg0.squarePrompt:setAlpha(1)
end
CoD.HubShowcaseCheckbox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.dashBacking:completeAnimation()
			f9_arg0.dashBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.dashBacking)
			f9_arg0.dash:completeAnimation()
			f9_arg0.dash:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.dash)
			f9_arg0.Glow:completeAnimation()
			f9_arg0.Glow:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Glow)
			f9_arg0.CornerDots:completeAnimation()
			f9_arg0.CornerDots:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CornerDots)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(10)
			f10_arg0.Border:completeAnimation()
			f10_arg0.Border:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Border)
			f10_arg0.BorderAdd:completeAnimation()
			f10_arg0.BorderAdd:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BorderAdd)
			f10_arg0.label:completeAnimation()
			f10_arg0.label:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.label)
			f10_arg0.Empty:completeAnimation()
			f10_arg0.Empty:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Empty)
			f10_arg0.dashBacking:completeAnimation()
			f10_arg0.dashBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.dashBacking)
			f10_arg0.dash:completeAnimation()
			f10_arg0.dash:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.dash)
			f10_arg0.Glow:completeAnimation()
			f10_arg0.Glow:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Glow)
			f10_arg0.CornerDots:completeAnimation()
			f10_arg0.CornerDots:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CornerDots)
			f10_arg0.CursorOver:completeAnimation()
			f10_arg0.CursorOver:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CursorOver)
			f10_arg0.squarePrompt:completeAnimation()
			f10_arg0.squarePrompt:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.squarePrompt)
		end,
	},
	PCHidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(10)
			f11_arg0.Border:completeAnimation()
			f11_arg0.Border:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Border)
			f11_arg0.BorderAdd:completeAnimation()
			f11_arg0.BorderAdd:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BorderAdd)
			f11_arg0.label:completeAnimation()
			f11_arg0.label:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.label)
			f11_arg0.Empty:completeAnimation()
			f11_arg0.Empty:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Empty)
			f11_arg0.dashBacking:completeAnimation()
			f11_arg0.dashBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.dashBacking)
			f11_arg0.dash:completeAnimation()
			f11_arg0.dash:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.dash)
			f11_arg0.Glow:completeAnimation()
			f11_arg0.Glow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Glow)
			f11_arg0.CornerDots:completeAnimation()
			f11_arg0.CornerDots:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CornerDots)
			f11_arg0.CursorOver:completeAnimation()
			f11_arg0.CursorOver:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CursorOver)
			f11_arg0.squarePrompt:completeAnimation()
			f11_arg0.squarePrompt:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.squarePrompt)
		end,
	},
	Checked = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(7)
			f12_arg0.BorderAdd:completeAnimation()
			f12_arg0.BorderAdd:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BorderAdd)
			f12_arg0.Empty:completeAnimation()
			f12_arg0.Empty:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Empty)
			f12_arg0.dashBacking:completeAnimation()
			f12_arg0.dashBacking:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.dashBacking)
			f12_arg0.dash:completeAnimation()
			f12_arg0.dash:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.dash)
			f12_arg0.Glow:completeAnimation()
			f12_arg0.Glow:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Glow)
			f12_arg0.CornerDots:completeAnimation()
			f12_arg0.CornerDots:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.CornerDots)
			f12_arg0.CursorOver:completeAnimation()
			f12_arg0.CursorOver:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CursorOver)
		end,
	},
}
CoD.HubShowcaseCheckbox.__onClose = function(f13_arg0)
	f13_arg0.Border:close()
	f13_arg0.BorderAdd:close()
	f13_arg0.squarePrompt:close()
end
