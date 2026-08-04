require("ui/uieditor/widgets/border")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmaincorners")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
require("ui/uieditor/widgets/startmenu/startmenu_frame_nobg")
CoD.StartMenu_Options_SimpleCheckOption = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SimpleCheckOption.__defaultWidth = 760
CoD.StartMenu_Options_SimpleCheckOption.__defaultHeight = 60
CoD.StartMenu_Options_SimpleCheckOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SimpleCheckOption)
	self.id = "StartMenu_Options_SimpleCheckOption"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 60)
	Backing:setRGB(0.13, 0.12, 0.12)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 60)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 60)
	self:addElement(Corner)
	self.Corner = Corner
	local checkboxBacking = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	checkboxBacking:setScale(0.3, 0.3)
	self:addElement(checkboxBacking)
	self.checkboxBacking = checkboxBacking
	local Dash = LUI.UIImage.new(0, 0, 18.5, 42.5, 0, 0, 18, 42)
	Dash:setScale(1.5, 1.5)
	Dash:setImage(RegisterImage("uie_ui_menu_cac_allocation_pip_full"))
	self:addElement(Dash)
	self.Dash = Dash
	local LabelText = LUI.UIText.new(0, 0.89, 70, 70, 0.5, 0.5, -10.5, 10.5)
	LabelText:setRGB(0.78, 0.74, 0.67)
	LabelText:setTTF("ttmussels_regular")
	LabelText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	LabelText:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LabelText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(LabelText)
	self.LabelText = LabelText
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	local Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 0, 15.5, 43.5, 0, 0, 16.5, 44.5)
	self:addElement(Border)
	self.Border = Border
	local BorderAdd = CoD.Border.new(f1_arg0, f1_arg1, 0, 0, 15.5, 43.5, 0, 0, 16.5, 44.5)
	self:addElement(BorderAdd)
	self.BorderAdd = BorderAdd
	local Empty = LUI.UIImage.new(0, 0, 11.5, 46.5, 0, 0, 12.5, 47.5)
	Empty:setScale(0.67, 0.67)
	Empty:setImage(RegisterImage("uie_ui_menu_specialist_hub_selectbox_empty"))
	Empty:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Empty)
	self.Empty = Empty
	local DashBacking = LUI.UIImage.new(0, 0, 17, 41, 0, 0, 18, 42)
	DashBacking:setScale(1.5, 1.5)
	DashBacking:setImage(RegisterImage("uie_ui_menu_cac_allocation_pip_empty"))
	self:addElement(DashBacking)
	self.DashBacking = DashBacking
	local CornerDots = LUI.UIImage.new(0, 0, 14.5, 43.5, 0, 0, 15.5, 44.5)
	CornerDots:setAlpha(0)
	CornerDots:setScale(1.5, 1.5)
	CornerDots:setImage(RegisterImage("uie_ui_menu_cac_allocation_pip_dots"))
	self:addElement(CornerDots)
	self.CornerDots = CornerDots
	local Glow = LUI.UIImage.new(0, 0.06, 8, 8, 0, 0, -6.5, 66.5)
	Glow:setRGB(0.88, 0.8, 0.45)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage("uie_t7_menu_cac_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	self:mergeStateConditions({
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "currentValue")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "currentValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "currentValue",
		})
	end)
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		local f7_local0 = self
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SimpleCheckOption.__resetProperties = function(f8_arg0)
	f8_arg0.checkboxBacking:completeAnimation()
	f8_arg0.CornerDots:completeAnimation()
	f8_arg0.Dash:completeAnimation()
	f8_arg0.DashBacking:completeAnimation()
	f8_arg0.Backing:completeAnimation()
	f8_arg0.Frame:completeAnimation()
	f8_arg0.Corner:completeAnimation()
	f8_arg0.BorderAdd:completeAnimation()
	f8_arg0.Empty:completeAnimation()
	f8_arg0.LabelText:completeAnimation()
	f8_arg0.checkboxBacking:setRGB(1, 1, 1)
	f8_arg0.CornerDots:setAlpha(0)
	f8_arg0.Dash:setAlpha(1)
	f8_arg0.DashBacking:setAlpha(1)
	f8_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f8_arg0.Backing:setAlpha(0.5)
	f8_arg0.Frame:setAlpha(0.04)
	f8_arg0.Corner:setScale(1, 1)
	f8_arg0.BorderAdd:setAlpha(1)
	f8_arg0.Empty:setAlpha(1)
	f8_arg0.LabelText:setRGB(0.78, 0.74, 0.67)
end
CoD.StartMenu_Options_SimpleCheckOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.checkboxBacking:completeAnimation()
			f9_arg0.checkboxBacking:setRGB(0.78, 0.78, 0.78)
			f9_arg0.clipFinished(f9_arg0.checkboxBacking)
			f9_arg0.Dash:completeAnimation()
			f9_arg0.Dash:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Dash)
			f9_arg0.DashBacking:completeAnimation()
			f9_arg0.DashBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DashBacking)
			f9_arg0.CornerDots:completeAnimation()
			f9_arg0.CornerDots:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CornerDots)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(9)
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f10_arg0.Backing:setAlpha(0.2)
			f10_arg0.clipFinished(f10_arg0.Backing)
			f10_arg0.Frame:completeAnimation()
			f10_arg0.Frame:setAlpha(0.6)
			f10_arg0.clipFinished(f10_arg0.Frame)
			f10_arg0.Corner:completeAnimation()
			f10_arg0.Corner:setScale(0.98, 0.83)
			f10_arg0.clipFinished(f10_arg0.Corner)
			f10_arg0.checkboxBacking:completeAnimation()
			f10_arg0.checkboxBacking:setRGB(0.87, 0.37, 0)
			f10_arg0.clipFinished(f10_arg0.checkboxBacking)
			f10_arg0.Dash:completeAnimation()
			f10_arg0.Dash:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Dash)
			f10_arg0.BorderAdd:completeAnimation()
			f10_arg0.BorderAdd:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BorderAdd)
			f10_arg0.Empty:completeAnimation()
			f10_arg0.Empty:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Empty)
			f10_arg0.DashBacking:completeAnimation()
			f10_arg0.DashBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DashBacking)
			f10_arg0.CornerDots:completeAnimation()
			f10_arg0.CornerDots:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.CornerDots)
		end,
	},
	Checked = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.checkboxBacking:completeAnimation()
			f11_arg0.checkboxBacking:setRGB(0.78, 0.78, 0.78)
			f11_arg0.clipFinished(f11_arg0.checkboxBacking)
		end,
		Focus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f12_arg0.Backing:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.Backing)
			f12_arg0.Frame:completeAnimation()
			f12_arg0.Frame:setAlpha(0.6)
			f12_arg0.clipFinished(f12_arg0.Frame)
			f12_arg0.Corner:completeAnimation()
			f12_arg0.Corner:setScale(0.98, 0.83)
			f12_arg0.clipFinished(f12_arg0.Corner)
			f12_arg0.checkboxBacking:completeAnimation()
			f12_arg0.checkboxBacking:setRGB(0.87, 0.37, 0)
			f12_arg0.clipFinished(f12_arg0.checkboxBacking)
		end,
		GainFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			local f13_local0 = function(f14_arg0)
				f13_arg0.Backing:beginAnimation(200)
				f13_arg0.Backing:setRGB(0.78, 0.74, 0.67)
				f13_arg0.Backing:setAlpha(0.2)
				f13_arg0.Backing:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Backing:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Backing:completeAnimation()
			f13_arg0.Backing:setRGB(0.13, 0.12, 0.12)
			f13_arg0.Backing:setAlpha(0.5)
			f13_local0(f13_arg0.Backing)
			local f13_local1 = function(f15_arg0)
				f13_arg0.Frame:beginAnimation(200)
				f13_arg0.Frame:setAlpha(0.6)
				f13_arg0.Frame:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Frame:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Frame:completeAnimation()
			f13_arg0.Frame:setAlpha(0.04)
			f13_local1(f13_arg0.Frame)
			local f13_local2 = function(f16_arg0)
				f13_arg0.Corner:beginAnimation(200)
				f13_arg0.Corner:setScale(0.98, 0.83)
				f13_arg0.Corner:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Corner:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Corner:completeAnimation()
			f13_arg0.Corner:setScale(1, 1)
			f13_local2(f13_arg0.Corner)
			local f13_local3 = function(f17_arg0)
				f13_arg0.checkboxBacking:beginAnimation(200)
				f13_arg0.checkboxBacking:setRGB(0.87, 0.37, 0)
				f13_arg0.checkboxBacking:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.checkboxBacking:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.checkboxBacking:completeAnimation()
			f13_arg0.checkboxBacking:setRGB(0.78, 0.78, 0.78)
			f13_local3(f13_arg0.checkboxBacking)
		end,
		LoseFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			local f18_local0 = function(f19_arg0)
				f18_arg0.Backing:beginAnimation(200)
				f18_arg0.Backing:setRGB(0.13, 0.12, 0.12)
				f18_arg0.Backing:setAlpha(0.5)
				f18_arg0.Backing:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Backing:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Backing:completeAnimation()
			f18_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f18_arg0.Backing:setAlpha(0.2)
			f18_local0(f18_arg0.Backing)
			local f18_local1 = function(f20_arg0)
				f18_arg0.Frame:beginAnimation(200)
				f18_arg0.Frame:setAlpha(0.04)
				f18_arg0.Frame:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Frame:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Frame:completeAnimation()
			f18_arg0.Frame:setAlpha(0.6)
			f18_local1(f18_arg0.Frame)
			local f18_local2 = function(f21_arg0)
				f18_arg0.Corner:beginAnimation(200)
				f18_arg0.Corner:setScale(1, 1)
				f18_arg0.Corner:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Corner:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Corner:completeAnimation()
			f18_arg0.Corner:setScale(0.98, 0.83)
			f18_local2(f18_arg0.Corner)
			local f18_local3 = function(f22_arg0)
				f18_arg0.checkboxBacking:beginAnimation(200)
				f18_arg0.checkboxBacking:setRGB(0.78, 0.78, 0.78)
				f18_arg0.checkboxBacking:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.checkboxBacking:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.checkboxBacking:completeAnimation()
			f18_arg0.checkboxBacking:setRGB(0.87, 0.37, 0)
			f18_local3(f18_arg0.checkboxBacking)
		end,
	},
	Disabled = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.checkboxBacking:completeAnimation()
			f23_arg0.checkboxBacking:setRGB(0.2, 0.2, 0.2)
			f23_arg0.clipFinished(f23_arg0.checkboxBacking)
			f23_arg0.LabelText:completeAnimation()
			f23_arg0.LabelText:setRGB(0.2, 0.2, 0.2)
			f23_arg0.clipFinished(f23_arg0.LabelText)
		end,
	},
}
CoD.StartMenu_Options_SimpleCheckOption.__onClose = function(f24_arg0)
	f24_arg0.Frame:close()
	f24_arg0.Corner:close()
	f24_arg0.checkboxBacking:close()
	f24_arg0.LabelText:close()
	f24_arg0.StartMenuframenoBG00:close()
	f24_arg0.Border:close()
	f24_arg0.BorderAdd:close()
end
