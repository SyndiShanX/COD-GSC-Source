require("x64:1394ae5e9cdcb54")
CoD.MultiItemPickupTab = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupTab.__defaultWidth = 50
CoD.MultiItemPickupTab.__defaultHeight = 34
CoD.MultiItemPickupTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MultiItemPickupTab)
	self.id = "MultiItemPickupTab"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Empty = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	Empty:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_pip_empty"))
	self:addElement(Empty)
	self.Empty = Empty
	local Selected = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	Selected:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_pip"))
	self:addElement(Selected)
	self.Selected = Selected
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 4, 204, 0, 0, 0, 34)
	RB:setAlpha(0)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, -154, 46, 0, 0, 0, 34)
	LB:setAlpha(0)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	self:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected")
			end,
		},
		{
			stateName = "LeftBumper",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "leftBumper")
			end,
		},
		{
			stateName = "RightBumper",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "rightBumper")
			end,
		},
	})
	self:linkToElementModel(self, "selected", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
		})
	end)
	self:linkToElementModel(self, "leftBumper", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "leftBumper",
		})
	end)
	self:linkToElementModel(self, "rightBumper", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rightBumper",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MultiItemPickupTab.__resetProperties = function(f8_arg0)
	f8_arg0.Selected:completeAnimation()
	f8_arg0.LB:completeAnimation()
	f8_arg0.Empty:completeAnimation()
	f8_arg0.RB:completeAnimation()
	f8_arg0.Selected:setAlpha(1)
	f8_arg0.LB:setAlpha(0)
	f8_arg0.Empty:setAlpha(1)
	f8_arg0.RB:setAlpha(0)
end
CoD.MultiItemPickupTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Selected:completeAnimation()
			f9_arg0.Selected:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Selected)
		end,
	},
	Selected = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	LeftBumper = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Empty:completeAnimation()
			f11_arg0.Empty:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Empty)
			f11_arg0.Selected:completeAnimation()
			f11_arg0.Selected:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Selected)
			f11_arg0.LB:completeAnimation()
			f11_arg0.LB:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.LB)
		end,
	},
	RightBumper = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.Empty:completeAnimation()
			f12_arg0.Empty:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Empty)
			f12_arg0.Selected:completeAnimation()
			f12_arg0.Selected:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Selected)
			f12_arg0.RB:completeAnimation()
			f12_arg0.RB:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.RB)
		end,
	},
}
CoD.MultiItemPickupTab.__onClose = function(f13_arg0)
	f13_arg0.RB:close()
	f13_arg0.LB:close()
end
