require("x64:7b22f584852cb0")
require("x64:3625a0d08a5c80d")
require("x64:a1e2d7b19f5deb0")
CoD.demo_options_slider = InheritFrom(LUI.UIElement)
CoD.demo_options_slider.__defaultWidth = 810
CoD.demo_options_slider.__defaultHeight = 51
CoD.demo_options_slider.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.demo_options_slider)
	self.id = "demo_options_slider"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackBox2 = LUI.UIImage.new(0, 0, 364, 792, 0, 0, 5, 47)
	BlackBox2:setRGB(0, 0, 0)
	BlackBox2:setAlpha(0.8)
	BlackBox2:setImage(RegisterImage(@"uie_t7_menu_cac_buttonboxlrgidlefull"))
	self:addElement(BlackBox2)
	self.BlackBox2 = BlackBox2
	local BlackBox = LUI.UIImage.new(0, 0, 22, 351, 0, 0, 5, 47)
	BlackBox:setRGB(0, 0, 0)
	BlackBox:setAlpha(0.8)
	BlackBox:setImage(RegisterImage(@"uie_t7_menu_cac_buttonboxlrgidlefull"))
	self:addElement(BlackBox)
	self.BlackBox = BlackBox
	local BoxButtonLrgIdle = LUI.UIImage.new(0, 0, 16, 354, 0, 0, 5, 47)
	BoxButtonLrgIdle:setAlpha(0.25)
	BoxButtonLrgIdle:setImage(RegisterImage(@"uie_t7_menu_cac_buttonboxlrgidlefull"))
	BoxButtonLrgIdle:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BoxButtonLrgIdle:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BoxButtonLrgIdle)
	self.BoxButtonLrgIdle = BoxButtonLrgIdle
	local BoxButtonLrgIdle0 = LUI.UIImage.new(0, 0, 361, 792, 0, 0, 5, 47)
	BoxButtonLrgIdle0:setAlpha(0.25)
	BoxButtonLrgIdle0:setImage(RegisterImage(@"uie_t7_menu_cac_buttonboxlrgidlefull"))
	BoxButtonLrgIdle0:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BoxButtonLrgIdle0:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BoxButtonLrgIdle0)
	self.BoxButtonLrgIdle0 = BoxButtonLrgIdle0
	local StartMenuframenoBG1 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 0, 363, 794, 0, 0, 2, 50)
	self:addElement(StartMenuframenoBG1)
	self.StartMenuframenoBG1 = StartMenuframenoBG1
	local StartMenuframenoBG0 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 1, 1, -790, -456, 0, 0, 2, 50)
	self:addElement(StartMenuframenoBG0)
	self.StartMenuframenoBG0 = StartMenuframenoBG0
	local Title = LUI.UIText.new(0, 0, 36, 338, 0, 0, 11, 41)
	Title:setTTF("dinnext_regular")
	Title:setLetterSpacing(0.5)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Title:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Slider = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, true, false, false, false)
	Slider:setLeftRight(0, 0, 390, 765)
	Slider:setTopBottom(0, 0, 3, 48)
	Slider:setWidgetType(CoD.demo_options_slider_control_item)
	Slider:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Slider:linkToElementModel(self, "optionsDatasource", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Slider:setDataSource(f3_local0)
		end
	end)
	Slider:registerEventHandler("list_active_changed", function(element, event)
		local f4_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		return f4_local0
	end)
	self:addElement(Slider)
	self.Slider = Slider
	local FocusBarT = CoD.FE_FocusBarContainer.new(f1_arg0, f1_arg1, 0, 1, 360, -18, 0, 0, 3, 9)
	FocusBarT:setAlpha(0)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	local FocusBarB = CoD.FE_FocusBarContainer.new(f1_arg0, f1_arg1, 0, 1, 360, -18, 1, 1, -5, 1)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	local glitch = LUI.UIImage.new(0, 1, 352, -18, 0, 0, -4, 16)
	glitch:setRGB(1, 0.09, 0)
	glitch:setAlpha(0)
	glitch:setImage(RegisterImage(@"uie_t7_effect_glitches_menu10"))
	glitch:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(glitch)
	self.glitch = glitch
	local glitch2 = LUI.UIImage.new(0, 1, 352, -18, 1, 1, -13, 9)
	glitch2:setRGB(1, 0.15, 0)
	glitch2:setAlpha(0)
	glitch2:setImage(RegisterImage(@"uie_t7_effect_glitches_menu10"))
	glitch2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(glitch2)
	self.glitch2 = glitch2
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1) and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "buttonOnly")
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return IsSelected(element, f1_arg1)
			end,
		},
		{
			stateName = "ButtonOnly",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "buttonOnly") and not IsDisabled(element, f1_arg1)
			end,
		},
		{
			stateName = "ButtonOnlyDisabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "buttonOnly") and IsDisabled(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:linkToElementModel(self, "buttonOnly", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "buttonOnly",
		})
	end)
	self:linkToElementModel(self, "selected", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f12_arg2, f12_arg3, f12_arg4)
		if not IsElementInState(element, "Selected") then
			SetProperty(self, "hideArrows", true)
			UpdateElementState(self, "Slider", controller)
		elseif IsElementInState(element, "Selected") then
			SetProperty(self, "hideArrows", false)
			UpdateElementState(self, "Slider", controller)
		end
	end)
	self.__on_menuOpened_self = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		local f13_local0 = self
		CoD.OptionsUtility.LinkToCurrentSelectionAndSetActiveIndex(self, self.Slider)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	Slider.id = "Slider"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local13 = self
	if IsPC() then
		CoD.PCUtility.SetHandleMouse(self, false)
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	CoD.GridAndListUtility.AddRightStickSingleItemControl(f1_arg0, Slider, f1_arg1)
	return self
end
CoD.demo_options_slider.__resetProperties = function(f15_arg0)
	f15_arg0.FocusBarB:completeAnimation()
	f15_arg0.FocusBarT:completeAnimation()
	f15_arg0.glitch2:completeAnimation()
	f15_arg0.glitch:completeAnimation()
	f15_arg0.Title:completeAnimation()
	f15_arg0.StartMenuframenoBG1:completeAnimation()
	f15_arg0.StartMenuframenoBG0:completeAnimation()
	f15_arg0.FocusBarB:setAlpha(0)
	f15_arg0.FocusBarT:setAlpha(0)
	f15_arg0.glitch2:setAlpha(0)
	f15_arg0.glitch:setAlpha(0)
	f15_arg0.Title:setRGB(1, 1, 1)
	f15_arg0.Title:setAlpha(1)
	f15_arg0.StartMenuframenoBG1:setAlpha(1)
	f15_arg0.StartMenuframenoBG0:setAlpha(1)
end
CoD.demo_options_slider.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							local f21_local0 = function(f22_arg0)
								local f22_local0 = function(f23_arg0)
									f23_arg0:beginAnimation(9)
									f23_arg0:setAlpha(1)
									f23_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
								end
								f22_arg0:beginAnimation(10)
								f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
							end
							f21_arg0:beginAnimation(9)
							f21_arg0:setAlpha(0.35)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
						end
						f20_arg0:beginAnimation(10)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(10)
					f19_arg0:setAlpha(0.57)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f17_arg0.FocusBarT:beginAnimation(30)
				f17_arg0.FocusBarT:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FocusBarT:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.FocusBarT:completeAnimation()
			f17_arg0.FocusBarT:setAlpha(0)
			f17_local0(f17_arg0.FocusBarT)
			local f17_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						local f26_local0 = function(f27_arg0)
							local f27_local0 = function(f28_arg0)
								local f28_local0 = function(f29_arg0)
									f29_arg0:beginAnimation(9)
									f29_arg0:setAlpha(1)
									f29_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
								end
								f28_arg0:beginAnimation(10)
								f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
							end
							f27_arg0:beginAnimation(9)
							f27_arg0:setAlpha(0.21)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
						end
						f26_arg0:beginAnimation(10)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(10)
					f25_arg0:setAlpha(0.66)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f17_arg0.FocusBarB:beginAnimation(30)
				f17_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f17_arg0.FocusBarB:completeAnimation()
			f17_arg0.FocusBarB:setAlpha(0)
			f17_local1(f17_arg0.FocusBarB)
			local f17_local2 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					local f31_local0 = function(f32_arg0)
						local f32_local0 = function(f33_arg0)
							local f33_local0 = function(f34_arg0)
								local f34_local0 = function(f35_arg0)
									f35_arg0:beginAnimation(40)
									f35_arg0:setAlpha(0)
									f35_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
								end
								f34_arg0:beginAnimation(10)
								f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
							end
							f33_arg0:beginAnimation(9)
							f33_arg0:setAlpha(1)
							f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
						end
						f32_arg0:beginAnimation(20)
						f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
					end
					f31_arg0:beginAnimation(10)
					f31_arg0:setAlpha(0)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
				end
				f17_arg0.glitch:beginAnimation(20)
				f17_arg0.glitch:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.glitch:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f17_arg0.glitch:completeAnimation()
			f17_arg0.glitch:setAlpha(1)
			f17_local2(f17_arg0.glitch)
			local f17_local3 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					local f37_local0 = function(f38_arg0)
						local f38_local0 = function(f39_arg0)
							local f39_local0 = function(f40_arg0)
								local f40_local0 = function(f41_arg0)
									f41_arg0:beginAnimation(40)
									f41_arg0:setAlpha(0)
									f41_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
								end
								f40_arg0:beginAnimation(10)
								f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
							end
							f39_arg0:beginAnimation(9)
							f39_arg0:setAlpha(1)
							f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
						end
						f38_arg0:beginAnimation(20)
						f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
					end
					f37_arg0:beginAnimation(10)
					f37_arg0:setAlpha(0)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
				end
				f17_arg0.glitch2:beginAnimation(20)
				f17_arg0.glitch2:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.glitch2:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f17_arg0.glitch2:completeAnimation()
			f17_arg0.glitch2:setAlpha(1)
			f17_local3(f17_arg0.glitch2)
		end,
		ChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.FocusBarT:completeAnimation()
			f42_arg0.FocusBarT:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.FocusBarT)
			f42_arg0.FocusBarB:completeAnimation()
			f42_arg0.FocusBarB:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.FocusBarB)
		end,
		LoseChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(4)
			local f43_local0 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						local f46_local0 = function(f47_arg0)
							local f47_local0 = function(f48_arg0)
								local f48_local0 = function(f49_arg0)
									f49_arg0:beginAnimation(60)
									f49_arg0:setAlpha(0)
									f49_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
								end
								f48_arg0:beginAnimation(9)
								f48_arg0:setAlpha(0.35)
								f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
							end
							f47_arg0:beginAnimation(10)
							f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
						end
						f46_arg0:beginAnimation(10)
						f46_arg0:setAlpha(0.57)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
					end
					f45_arg0:beginAnimation(20)
					f45_arg0:setAlpha(0)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f43_arg0.FocusBarT:beginAnimation(10)
				f43_arg0.FocusBarT:setAlpha(0.35)
				f43_arg0.FocusBarT:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.FocusBarT:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f43_arg0.FocusBarT:completeAnimation()
			f43_arg0.FocusBarT:setAlpha(1)
			f43_local0(f43_arg0.FocusBarT)
			local f43_local1 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					local f51_local0 = function(f52_arg0)
						local f52_local0 = function(f53_arg0)
							local f53_local0 = function(f54_arg0)
								local f54_local0 = function(f55_arg0)
									f55_arg0:beginAnimation(60)
									f55_arg0:setAlpha(0)
									f55_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
								end
								f54_arg0:beginAnimation(9)
								f54_arg0:setAlpha(0.21)
								f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
							end
							f53_arg0:beginAnimation(10)
							f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
						end
						f52_arg0:beginAnimation(10)
						f52_arg0:setAlpha(0.66)
						f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
					end
					f51_arg0:beginAnimation(20)
					f51_arg0:setAlpha(0)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
				end
				f43_arg0.FocusBarB:beginAnimation(10)
				f43_arg0.FocusBarB:setAlpha(0.21)
				f43_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f43_arg0.FocusBarB:completeAnimation()
			f43_arg0.FocusBarB:setAlpha(1)
			f43_local1(f43_arg0.FocusBarB)
			local f43_local2 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					local f57_local0 = function(f58_arg0)
						local f58_local0 = function(f59_arg0)
							local f59_local0 = function(f60_arg0)
								local f60_local0 = function(f61_arg0)
									local f61_local0 = function(f62_arg0)
										f62_arg0:beginAnimation(80)
										f62_arg0:setAlpha(0)
										f62_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
									end
									f61_arg0:beginAnimation(10)
									f61_arg0:setAlpha(0.4)
									f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
								end
								f60_arg0:beginAnimation(20)
								f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
							end
							f59_arg0:beginAnimation(10)
							f59_arg0:setAlpha(0)
							f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
						end
						f58_arg0:beginAnimation(10)
						f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
					end
					f57_arg0:beginAnimation(10)
					f57_arg0:setAlpha(1)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
				end
				f43_arg0.glitch:beginAnimation(10)
				f43_arg0.glitch:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.glitch:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f43_arg0.glitch:completeAnimation()
			f43_arg0.glitch:setAlpha(0)
			f43_local2(f43_arg0.glitch)
			local f43_local3 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					local f64_local0 = function(f65_arg0)
						local f65_local0 = function(f66_arg0)
							local f66_local0 = function(f67_arg0)
								local f67_local0 = function(f68_arg0)
									local f68_local0 = function(f69_arg0)
										f69_arg0:beginAnimation(80)
										f69_arg0:setAlpha(0)
										f69_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
									end
									f68_arg0:beginAnimation(10)
									f68_arg0:setAlpha(0.57)
									f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
								end
								f67_arg0:beginAnimation(20)
								f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
							end
							f66_arg0:beginAnimation(10)
							f66_arg0:setAlpha(0)
							f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
						end
						f65_arg0:beginAnimation(10)
						f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
					end
					f64_arg0:beginAnimation(10)
					f64_arg0:setAlpha(1)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
				end
				f43_arg0.glitch2:beginAnimation(10)
				f43_arg0.glitch2:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.glitch2:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f43_arg0.glitch2:completeAnimation()
			f43_arg0.glitch2:setAlpha(0)
			f43_local3(f43_arg0.glitch2)
		end,
	},
	Disabled = {
		DefaultClip = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(3)
			f70_arg0.StartMenuframenoBG1:completeAnimation()
			f70_arg0.StartMenuframenoBG1:setAlpha(0.6)
			f70_arg0.clipFinished(f70_arg0.StartMenuframenoBG1)
			f70_arg0.StartMenuframenoBG0:completeAnimation()
			f70_arg0.StartMenuframenoBG0:setAlpha(0.6)
			f70_arg0.clipFinished(f70_arg0.StartMenuframenoBG0)
			f70_arg0.Title:completeAnimation()
			f70_arg0.Title:setRGB(0.42, 0.42, 0.42)
			f70_arg0.clipFinished(f70_arg0.Title)
		end,
	},
	Selected = {
		DefaultClip = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(0)
		end,
	},
	ButtonOnly = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(0)
		end,
		GainFocus = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(5)
			local f73_local0 = function(f74_arg0)
				f73_arg0.Title:beginAnimation(110)
				f73_arg0.Title:setAlpha(1)
				f73_arg0.Title:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.Title:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
			end
			f73_arg0.Title:completeAnimation()
			f73_arg0.Title:setAlpha(0.7)
			f73_local0(f73_arg0.Title)
			local f73_local1 = function(f75_arg0)
				local f75_local0 = function(f76_arg0)
					local f76_local0 = function(f77_arg0)
						local f77_local0 = function(f78_arg0)
							local f78_local0 = function(f79_arg0)
								local f79_local0 = function(f80_arg0)
									f80_arg0:beginAnimation(9)
									f80_arg0:setAlpha(1)
									f80_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
								end
								f79_arg0:beginAnimation(10)
								f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
							end
							f78_arg0:beginAnimation(9)
							f78_arg0:setAlpha(0.35)
							f78_arg0:registerEventHandler("transition_complete_keyframe", f78_local0)
						end
						f77_arg0:beginAnimation(10)
						f77_arg0:registerEventHandler("transition_complete_keyframe", f77_local0)
					end
					f76_arg0:beginAnimation(10)
					f76_arg0:setAlpha(0.57)
					f76_arg0:registerEventHandler("transition_complete_keyframe", f76_local0)
				end
				f73_arg0.FocusBarT:beginAnimation(30)
				f73_arg0.FocusBarT:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.FocusBarT:registerEventHandler("transition_complete_keyframe", f75_local0)
			end
			f73_arg0.FocusBarT:completeAnimation()
			f73_arg0.FocusBarT:setAlpha(0)
			f73_local1(f73_arg0.FocusBarT)
			local f73_local2 = function(f81_arg0)
				local f81_local0 = function(f82_arg0)
					local f82_local0 = function(f83_arg0)
						local f83_local0 = function(f84_arg0)
							local f84_local0 = function(f85_arg0)
								local f85_local0 = function(f86_arg0)
									f86_arg0:beginAnimation(9)
									f86_arg0:setAlpha(1)
									f86_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
								end
								f85_arg0:beginAnimation(10)
								f85_arg0:registerEventHandler("transition_complete_keyframe", f85_local0)
							end
							f84_arg0:beginAnimation(9)
							f84_arg0:setAlpha(0.21)
							f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
						end
						f83_arg0:beginAnimation(10)
						f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
					end
					f82_arg0:beginAnimation(10)
					f82_arg0:setAlpha(0.66)
					f82_arg0:registerEventHandler("transition_complete_keyframe", f82_local0)
				end
				f73_arg0.FocusBarB:beginAnimation(30)
				f73_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f81_local0)
			end
			f73_arg0.FocusBarB:completeAnimation()
			f73_arg0.FocusBarB:setAlpha(0)
			f73_local2(f73_arg0.FocusBarB)
			local f73_local3 = function(f87_arg0)
				local f87_local0 = function(f88_arg0)
					local f88_local0 = function(f89_arg0)
						local f89_local0 = function(f90_arg0)
							local f90_local0 = function(f91_arg0)
								local f91_local0 = function(f92_arg0)
									f92_arg0:beginAnimation(40)
									f92_arg0:setAlpha(0)
									f92_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
								end
								f91_arg0:beginAnimation(10)
								f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
							end
							f90_arg0:beginAnimation(9)
							f90_arg0:setAlpha(1)
							f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
						end
						f89_arg0:beginAnimation(20)
						f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
					end
					f88_arg0:beginAnimation(10)
					f88_arg0:setAlpha(0)
					f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
				end
				f73_arg0.glitch:beginAnimation(20)
				f73_arg0.glitch:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.glitch:registerEventHandler("transition_complete_keyframe", f87_local0)
			end
			f73_arg0.glitch:completeAnimation()
			f73_arg0.glitch:setAlpha(1)
			f73_local3(f73_arg0.glitch)
			local f73_local4 = function(f93_arg0)
				local f93_local0 = function(f94_arg0)
					local f94_local0 = function(f95_arg0)
						local f95_local0 = function(f96_arg0)
							local f96_local0 = function(f97_arg0)
								local f97_local0 = function(f98_arg0)
									f98_arg0:beginAnimation(40)
									f98_arg0:setAlpha(0)
									f98_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
								end
								f97_arg0:beginAnimation(10)
								f97_arg0:registerEventHandler("transition_complete_keyframe", f97_local0)
							end
							f96_arg0:beginAnimation(9)
							f96_arg0:setAlpha(1)
							f96_arg0:registerEventHandler("transition_complete_keyframe", f96_local0)
						end
						f95_arg0:beginAnimation(20)
						f95_arg0:registerEventHandler("transition_complete_keyframe", f95_local0)
					end
					f94_arg0:beginAnimation(10)
					f94_arg0:setAlpha(0)
					f94_arg0:registerEventHandler("transition_complete_keyframe", f94_local0)
				end
				f73_arg0.glitch2:beginAnimation(20)
				f73_arg0.glitch2:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.glitch2:registerEventHandler("transition_complete_keyframe", f93_local0)
			end
			f73_arg0.glitch2:completeAnimation()
			f73_arg0.glitch2:setAlpha(1)
			f73_local4(f73_arg0.glitch2)
		end,
		Focus = function(f99_arg0, f99_arg1)
			f99_arg0:__resetProperties()
			f99_arg0:setupElementClipCounter(2)
			f99_arg0.FocusBarT:completeAnimation()
			f99_arg0.FocusBarT:setAlpha(1)
			f99_arg0.clipFinished(f99_arg0.FocusBarT)
			f99_arg0.FocusBarB:completeAnimation()
			f99_arg0.FocusBarB:setAlpha(1)
			f99_arg0.clipFinished(f99_arg0.FocusBarB)
		end,
		LoseFocus = function(f100_arg0, f100_arg1)
			f100_arg0:__resetProperties()
			f100_arg0:setupElementClipCounter(5)
			local f100_local0 = function(f101_arg0)
				f100_arg0.Title:beginAnimation(160)
				f100_arg0.Title:setAlpha(0.7)
				f100_arg0.Title:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.Title:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
			end
			f100_arg0.Title:completeAnimation()
			f100_arg0.Title:setAlpha(1)
			f100_local0(f100_arg0.Title)
			local f100_local1 = function(f102_arg0)
				local f102_local0 = function(f103_arg0)
					local f103_local0 = function(f104_arg0)
						local f104_local0 = function(f105_arg0)
							local f105_local0 = function(f106_arg0)
								local f106_local0 = function(f107_arg0)
									f107_arg0:beginAnimation(60)
									f107_arg0:setAlpha(0)
									f107_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
								end
								f106_arg0:beginAnimation(9)
								f106_arg0:setAlpha(0.35)
								f106_arg0:registerEventHandler("transition_complete_keyframe", f106_local0)
							end
							f105_arg0:beginAnimation(10)
							f105_arg0:registerEventHandler("transition_complete_keyframe", f105_local0)
						end
						f104_arg0:beginAnimation(10)
						f104_arg0:setAlpha(0.57)
						f104_arg0:registerEventHandler("transition_complete_keyframe", f104_local0)
					end
					f103_arg0:beginAnimation(20)
					f103_arg0:setAlpha(0)
					f103_arg0:registerEventHandler("transition_complete_keyframe", f103_local0)
				end
				f100_arg0.FocusBarT:beginAnimation(10)
				f100_arg0.FocusBarT:setAlpha(0.35)
				f100_arg0.FocusBarT:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.FocusBarT:registerEventHandler("transition_complete_keyframe", f102_local0)
			end
			f100_arg0.FocusBarT:completeAnimation()
			f100_arg0.FocusBarT:setAlpha(1)
			f100_local1(f100_arg0.FocusBarT)
			local f100_local2 = function(f108_arg0)
				local f108_local0 = function(f109_arg0)
					local f109_local0 = function(f110_arg0)
						local f110_local0 = function(f111_arg0)
							local f111_local0 = function(f112_arg0)
								local f112_local0 = function(f113_arg0)
									f113_arg0:beginAnimation(60)
									f113_arg0:setAlpha(0)
									f113_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
								end
								f112_arg0:beginAnimation(9)
								f112_arg0:setAlpha(0.21)
								f112_arg0:registerEventHandler("transition_complete_keyframe", f112_local0)
							end
							f111_arg0:beginAnimation(10)
							f111_arg0:registerEventHandler("transition_complete_keyframe", f111_local0)
						end
						f110_arg0:beginAnimation(10)
						f110_arg0:setAlpha(0.66)
						f110_arg0:registerEventHandler("transition_complete_keyframe", f110_local0)
					end
					f109_arg0:beginAnimation(20)
					f109_arg0:setAlpha(0)
					f109_arg0:registerEventHandler("transition_complete_keyframe", f109_local0)
				end
				f100_arg0.FocusBarB:beginAnimation(10)
				f100_arg0.FocusBarB:setAlpha(0.21)
				f100_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f108_local0)
			end
			f100_arg0.FocusBarB:completeAnimation()
			f100_arg0.FocusBarB:setAlpha(1)
			f100_local2(f100_arg0.FocusBarB)
			local f100_local3 = function(f114_arg0)
				local f114_local0 = function(f115_arg0)
					local f115_local0 = function(f116_arg0)
						local f116_local0 = function(f117_arg0)
							local f117_local0 = function(f118_arg0)
								local f118_local0 = function(f119_arg0)
									local f119_local0 = function(f120_arg0)
										f120_arg0:beginAnimation(80)
										f120_arg0:setAlpha(0)
										f120_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
									end
									f119_arg0:beginAnimation(10)
									f119_arg0:setAlpha(0.4)
									f119_arg0:registerEventHandler("transition_complete_keyframe", f119_local0)
								end
								f118_arg0:beginAnimation(20)
								f118_arg0:registerEventHandler("transition_complete_keyframe", f118_local0)
							end
							f117_arg0:beginAnimation(10)
							f117_arg0:setAlpha(0)
							f117_arg0:registerEventHandler("transition_complete_keyframe", f117_local0)
						end
						f116_arg0:beginAnimation(10)
						f116_arg0:registerEventHandler("transition_complete_keyframe", f116_local0)
					end
					f115_arg0:beginAnimation(10)
					f115_arg0:setAlpha(1)
					f115_arg0:registerEventHandler("transition_complete_keyframe", f115_local0)
				end
				f100_arg0.glitch:beginAnimation(10)
				f100_arg0.glitch:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.glitch:registerEventHandler("transition_complete_keyframe", f114_local0)
			end
			f100_arg0.glitch:completeAnimation()
			f100_arg0.glitch:setAlpha(0)
			f100_local3(f100_arg0.glitch)
			local f100_local4 = function(f121_arg0)
				local f121_local0 = function(f122_arg0)
					local f122_local0 = function(f123_arg0)
						local f123_local0 = function(f124_arg0)
							local f124_local0 = function(f125_arg0)
								local f125_local0 = function(f126_arg0)
									local f126_local0 = function(f127_arg0)
										f127_arg0:beginAnimation(80)
										f127_arg0:setAlpha(0)
										f127_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
									end
									f126_arg0:beginAnimation(10)
									f126_arg0:setAlpha(0.57)
									f126_arg0:registerEventHandler("transition_complete_keyframe", f126_local0)
								end
								f125_arg0:beginAnimation(20)
								f125_arg0:registerEventHandler("transition_complete_keyframe", f125_local0)
							end
							f124_arg0:beginAnimation(10)
							f124_arg0:setAlpha(0)
							f124_arg0:registerEventHandler("transition_complete_keyframe", f124_local0)
						end
						f123_arg0:beginAnimation(10)
						f123_arg0:registerEventHandler("transition_complete_keyframe", f123_local0)
					end
					f122_arg0:beginAnimation(10)
					f122_arg0:setAlpha(1)
					f122_arg0:registerEventHandler("transition_complete_keyframe", f122_local0)
				end
				f100_arg0.glitch2:beginAnimation(10)
				f100_arg0.glitch2:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.glitch2:registerEventHandler("transition_complete_keyframe", f121_local0)
			end
			f100_arg0.glitch2:completeAnimation()
			f100_arg0.glitch2:setAlpha(0)
			f100_local4(f100_arg0.glitch2)
		end,
	},
	ButtonOnlyDisabled = {
		DefaultClip = function(f128_arg0, f128_arg1)
			f128_arg0:__resetProperties()
			f128_arg0:setupElementClipCounter(1)
			f128_arg0.Title:completeAnimation()
			f128_arg0.Title:setRGB(0.42, 0.42, 0.42)
			f128_arg0.clipFinished(f128_arg0.Title)
		end,
		GainFocus = function(f129_arg0, f129_arg1)
			f129_arg0:__resetProperties()
			f129_arg0:setupElementClipCounter(5)
			local f129_local0 = function(f130_arg0)
				f129_arg0.Title:beginAnimation(110)
				f129_arg0.Title:setAlpha(1)
				f129_arg0.Title:registerEventHandler("interrupted_keyframe", f129_arg0.clipInterrupted)
				f129_arg0.Title:registerEventHandler("transition_complete_keyframe", f129_arg0.clipFinished)
			end
			f129_arg0.Title:completeAnimation()
			f129_arg0.Title:setAlpha(0.7)
			f129_local0(f129_arg0.Title)
			local f129_local1 = function(f131_arg0)
				local f131_local0 = function(f132_arg0)
					local f132_local0 = function(f133_arg0)
						local f133_local0 = function(f134_arg0)
							local f134_local0 = function(f135_arg0)
								local f135_local0 = function(f136_arg0)
									f136_arg0:beginAnimation(9)
									f136_arg0:setAlpha(1)
									f136_arg0:registerEventHandler("transition_complete_keyframe", f129_arg0.clipFinished)
								end
								f135_arg0:beginAnimation(10)
								f135_arg0:registerEventHandler("transition_complete_keyframe", f135_local0)
							end
							f134_arg0:beginAnimation(9)
							f134_arg0:setAlpha(0.35)
							f134_arg0:registerEventHandler("transition_complete_keyframe", f134_local0)
						end
						f133_arg0:beginAnimation(10)
						f133_arg0:registerEventHandler("transition_complete_keyframe", f133_local0)
					end
					f132_arg0:beginAnimation(10)
					f132_arg0:setAlpha(0.57)
					f132_arg0:registerEventHandler("transition_complete_keyframe", f132_local0)
				end
				f129_arg0.FocusBarT:beginAnimation(30)
				f129_arg0.FocusBarT:registerEventHandler("interrupted_keyframe", f129_arg0.clipInterrupted)
				f129_arg0.FocusBarT:registerEventHandler("transition_complete_keyframe", f131_local0)
			end
			f129_arg0.FocusBarT:completeAnimation()
			f129_arg0.FocusBarT:setAlpha(0)
			f129_local1(f129_arg0.FocusBarT)
			local f129_local2 = function(f137_arg0)
				local f137_local0 = function(f138_arg0)
					local f138_local0 = function(f139_arg0)
						local f139_local0 = function(f140_arg0)
							local f140_local0 = function(f141_arg0)
								local f141_local0 = function(f142_arg0)
									f142_arg0:beginAnimation(9)
									f142_arg0:setAlpha(1)
									f142_arg0:registerEventHandler("transition_complete_keyframe", f129_arg0.clipFinished)
								end
								f141_arg0:beginAnimation(10)
								f141_arg0:registerEventHandler("transition_complete_keyframe", f141_local0)
							end
							f140_arg0:beginAnimation(9)
							f140_arg0:setAlpha(0.21)
							f140_arg0:registerEventHandler("transition_complete_keyframe", f140_local0)
						end
						f139_arg0:beginAnimation(10)
						f139_arg0:registerEventHandler("transition_complete_keyframe", f139_local0)
					end
					f138_arg0:beginAnimation(10)
					f138_arg0:setAlpha(0.66)
					f138_arg0:registerEventHandler("transition_complete_keyframe", f138_local0)
				end
				f129_arg0.FocusBarB:beginAnimation(30)
				f129_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f129_arg0.clipInterrupted)
				f129_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f137_local0)
			end
			f129_arg0.FocusBarB:completeAnimation()
			f129_arg0.FocusBarB:setAlpha(0)
			f129_local2(f129_arg0.FocusBarB)
			local f129_local3 = function(f143_arg0)
				local f143_local0 = function(f144_arg0)
					local f144_local0 = function(f145_arg0)
						local f145_local0 = function(f146_arg0)
							local f146_local0 = function(f147_arg0)
								local f147_local0 = function(f148_arg0)
									f148_arg0:beginAnimation(40)
									f148_arg0:setAlpha(0)
									f148_arg0:registerEventHandler("transition_complete_keyframe", f129_arg0.clipFinished)
								end
								f147_arg0:beginAnimation(10)
								f147_arg0:registerEventHandler("transition_complete_keyframe", f147_local0)
							end
							f146_arg0:beginAnimation(9)
							f146_arg0:setAlpha(1)
							f146_arg0:registerEventHandler("transition_complete_keyframe", f146_local0)
						end
						f145_arg0:beginAnimation(20)
						f145_arg0:registerEventHandler("transition_complete_keyframe", f145_local0)
					end
					f144_arg0:beginAnimation(10)
					f144_arg0:setAlpha(0)
					f144_arg0:registerEventHandler("transition_complete_keyframe", f144_local0)
				end
				f129_arg0.glitch:beginAnimation(20)
				f129_arg0.glitch:registerEventHandler("interrupted_keyframe", f129_arg0.clipInterrupted)
				f129_arg0.glitch:registerEventHandler("transition_complete_keyframe", f143_local0)
			end
			f129_arg0.glitch:completeAnimation()
			f129_arg0.glitch:setAlpha(1)
			f129_local3(f129_arg0.glitch)
			local f129_local4 = function(f149_arg0)
				local f149_local0 = function(f150_arg0)
					local f150_local0 = function(f151_arg0)
						local f151_local0 = function(f152_arg0)
							local f152_local0 = function(f153_arg0)
								local f153_local0 = function(f154_arg0)
									f154_arg0:beginAnimation(40)
									f154_arg0:setAlpha(0)
									f154_arg0:registerEventHandler("transition_complete_keyframe", f129_arg0.clipFinished)
								end
								f153_arg0:beginAnimation(10)
								f153_arg0:registerEventHandler("transition_complete_keyframe", f153_local0)
							end
							f152_arg0:beginAnimation(9)
							f152_arg0:setAlpha(1)
							f152_arg0:registerEventHandler("transition_complete_keyframe", f152_local0)
						end
						f151_arg0:beginAnimation(20)
						f151_arg0:registerEventHandler("transition_complete_keyframe", f151_local0)
					end
					f150_arg0:beginAnimation(10)
					f150_arg0:setAlpha(0)
					f150_arg0:registerEventHandler("transition_complete_keyframe", f150_local0)
				end
				f129_arg0.glitch2:beginAnimation(20)
				f129_arg0.glitch2:registerEventHandler("interrupted_keyframe", f129_arg0.clipInterrupted)
				f129_arg0.glitch2:registerEventHandler("transition_complete_keyframe", f149_local0)
			end
			f129_arg0.glitch2:completeAnimation()
			f129_arg0.glitch2:setAlpha(1)
			f129_local4(f129_arg0.glitch2)
		end,
		Focus = function(f155_arg0, f155_arg1)
			f155_arg0:__resetProperties()
			f155_arg0:setupElementClipCounter(2)
			f155_arg0.FocusBarT:completeAnimation()
			f155_arg0.FocusBarT:setAlpha(1)
			f155_arg0.clipFinished(f155_arg0.FocusBarT)
			f155_arg0.FocusBarB:completeAnimation()
			f155_arg0.FocusBarB:setAlpha(1)
			f155_arg0.clipFinished(f155_arg0.FocusBarB)
		end,
		LoseFocus = function(f156_arg0, f156_arg1)
			f156_arg0:__resetProperties()
			f156_arg0:setupElementClipCounter(5)
			local f156_local0 = function(f157_arg0)
				f156_arg0.Title:beginAnimation(160)
				f156_arg0.Title:setAlpha(0.7)
				f156_arg0.Title:registerEventHandler("interrupted_keyframe", f156_arg0.clipInterrupted)
				f156_arg0.Title:registerEventHandler("transition_complete_keyframe", f156_arg0.clipFinished)
			end
			f156_arg0.Title:completeAnimation()
			f156_arg0.Title:setAlpha(1)
			f156_local0(f156_arg0.Title)
			local f156_local1 = function(f158_arg0)
				local f158_local0 = function(f159_arg0)
					local f159_local0 = function(f160_arg0)
						local f160_local0 = function(f161_arg0)
							local f161_local0 = function(f162_arg0)
								local f162_local0 = function(f163_arg0)
									f163_arg0:beginAnimation(60)
									f163_arg0:setAlpha(0)
									f163_arg0:registerEventHandler("transition_complete_keyframe", f156_arg0.clipFinished)
								end
								f162_arg0:beginAnimation(9)
								f162_arg0:setAlpha(0.35)
								f162_arg0:registerEventHandler("transition_complete_keyframe", f162_local0)
							end
							f161_arg0:beginAnimation(10)
							f161_arg0:registerEventHandler("transition_complete_keyframe", f161_local0)
						end
						f160_arg0:beginAnimation(10)
						f160_arg0:setAlpha(0.57)
						f160_arg0:registerEventHandler("transition_complete_keyframe", f160_local0)
					end
					f159_arg0:beginAnimation(20)
					f159_arg0:setAlpha(0)
					f159_arg0:registerEventHandler("transition_complete_keyframe", f159_local0)
				end
				f156_arg0.FocusBarT:beginAnimation(10)
				f156_arg0.FocusBarT:setAlpha(0.35)
				f156_arg0.FocusBarT:registerEventHandler("interrupted_keyframe", f156_arg0.clipInterrupted)
				f156_arg0.FocusBarT:registerEventHandler("transition_complete_keyframe", f158_local0)
			end
			f156_arg0.FocusBarT:completeAnimation()
			f156_arg0.FocusBarT:setAlpha(1)
			f156_local1(f156_arg0.FocusBarT)
			local f156_local2 = function(f164_arg0)
				local f164_local0 = function(f165_arg0)
					local f165_local0 = function(f166_arg0)
						local f166_local0 = function(f167_arg0)
							local f167_local0 = function(f168_arg0)
								local f168_local0 = function(f169_arg0)
									f169_arg0:beginAnimation(60)
									f169_arg0:setAlpha(0)
									f169_arg0:registerEventHandler("transition_complete_keyframe", f156_arg0.clipFinished)
								end
								f168_arg0:beginAnimation(9)
								f168_arg0:setAlpha(0.21)
								f168_arg0:registerEventHandler("transition_complete_keyframe", f168_local0)
							end
							f167_arg0:beginAnimation(10)
							f167_arg0:registerEventHandler("transition_complete_keyframe", f167_local0)
						end
						f166_arg0:beginAnimation(10)
						f166_arg0:setAlpha(0.66)
						f166_arg0:registerEventHandler("transition_complete_keyframe", f166_local0)
					end
					f165_arg0:beginAnimation(20)
					f165_arg0:setAlpha(0)
					f165_arg0:registerEventHandler("transition_complete_keyframe", f165_local0)
				end
				f156_arg0.FocusBarB:beginAnimation(10)
				f156_arg0.FocusBarB:setAlpha(0.21)
				f156_arg0.FocusBarB:registerEventHandler("interrupted_keyframe", f156_arg0.clipInterrupted)
				f156_arg0.FocusBarB:registerEventHandler("transition_complete_keyframe", f164_local0)
			end
			f156_arg0.FocusBarB:completeAnimation()
			f156_arg0.FocusBarB:setAlpha(1)
			f156_local2(f156_arg0.FocusBarB)
			local f156_local3 = function(f170_arg0)
				local f170_local0 = function(f171_arg0)
					local f171_local0 = function(f172_arg0)
						local f172_local0 = function(f173_arg0)
							local f173_local0 = function(f174_arg0)
								local f174_local0 = function(f175_arg0)
									local f175_local0 = function(f176_arg0)
										f176_arg0:beginAnimation(80)
										f176_arg0:setAlpha(0)
										f176_arg0:registerEventHandler("transition_complete_keyframe", f156_arg0.clipFinished)
									end
									f175_arg0:beginAnimation(10)
									f175_arg0:setAlpha(0.4)
									f175_arg0:registerEventHandler("transition_complete_keyframe", f175_local0)
								end
								f174_arg0:beginAnimation(20)
								f174_arg0:registerEventHandler("transition_complete_keyframe", f174_local0)
							end
							f173_arg0:beginAnimation(10)
							f173_arg0:setAlpha(0)
							f173_arg0:registerEventHandler("transition_complete_keyframe", f173_local0)
						end
						f172_arg0:beginAnimation(10)
						f172_arg0:registerEventHandler("transition_complete_keyframe", f172_local0)
					end
					f171_arg0:beginAnimation(10)
					f171_arg0:setAlpha(1)
					f171_arg0:registerEventHandler("transition_complete_keyframe", f171_local0)
				end
				f156_arg0.glitch:beginAnimation(10)
				f156_arg0.glitch:registerEventHandler("interrupted_keyframe", f156_arg0.clipInterrupted)
				f156_arg0.glitch:registerEventHandler("transition_complete_keyframe", f170_local0)
			end
			f156_arg0.glitch:completeAnimation()
			f156_arg0.glitch:setAlpha(0)
			f156_local3(f156_arg0.glitch)
			local f156_local4 = function(f177_arg0)
				local f177_local0 = function(f178_arg0)
					local f178_local0 = function(f179_arg0)
						local f179_local0 = function(f180_arg0)
							local f180_local0 = function(f181_arg0)
								local f181_local0 = function(f182_arg0)
									local f182_local0 = function(f183_arg0)
										f183_arg0:beginAnimation(80)
										f183_arg0:setAlpha(0)
										f183_arg0:registerEventHandler("transition_complete_keyframe", f156_arg0.clipFinished)
									end
									f182_arg0:beginAnimation(10)
									f182_arg0:setAlpha(0.57)
									f182_arg0:registerEventHandler("transition_complete_keyframe", f182_local0)
								end
								f181_arg0:beginAnimation(20)
								f181_arg0:registerEventHandler("transition_complete_keyframe", f181_local0)
							end
							f180_arg0:beginAnimation(10)
							f180_arg0:setAlpha(0)
							f180_arg0:registerEventHandler("transition_complete_keyframe", f180_local0)
						end
						f179_arg0:beginAnimation(10)
						f179_arg0:registerEventHandler("transition_complete_keyframe", f179_local0)
					end
					f178_arg0:beginAnimation(10)
					f178_arg0:setAlpha(1)
					f178_arg0:registerEventHandler("transition_complete_keyframe", f178_local0)
				end
				f156_arg0.glitch2:beginAnimation(10)
				f156_arg0.glitch2:registerEventHandler("interrupted_keyframe", f156_arg0.clipInterrupted)
				f156_arg0.glitch2:registerEventHandler("transition_complete_keyframe", f177_local0)
			end
			f156_arg0.glitch2:completeAnimation()
			f156_arg0.glitch2:setAlpha(0)
			f156_local4(f156_arg0.glitch2)
		end,
	},
}
CoD.demo_options_slider.__onClose = function(f184_arg0)
	f184_arg0.__on_close_removeOverrides()
	f184_arg0.StartMenuframenoBG1:close()
	f184_arg0.StartMenuframenoBG0:close()
	f184_arg0.Title:close()
	f184_arg0.Slider:close()
	f184_arg0.FocusBarT:close()
	f184_arg0.FocusBarB:close()
end
