require("x64:5d3ee5846655da6")
require("x64:724e515e60ad1c4")
require("x64:55aca670e9903a3")
CoD.CustomGames_OptionCategoryButton = InheritFrom(LUI.UIElement)
CoD.CustomGames_OptionCategoryButton.__defaultWidth = 250
CoD.CustomGames_OptionCategoryButton.__defaultHeight = 110
CoD.CustomGames_OptionCategoryButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomGames_OptionCategoryButton)
	self.id = "CustomGames_OptionCategoryButton"
	self.soundSet = "CustomRulesMenu"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonBG = LUI.UIImage.new(0, 0, 0, 240, 0, 0, 0, 110)
	ButtonBG:setRGB(0.38, 0.38, 0.38)
	ButtonBG:setAlpha(0.8)
	ButtonBG:setImage(RegisterImage(@"uie_ui_menu_cac_button_bg_generic01"))
	self:addElement(ButtonBG)
	self.ButtonBG = ButtonBG
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 0.96, 0, 0, 0, 1, 0, 0)
	Corner:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner:setScale(0.98, 0.97)
	self:addElement(Corner)
	self.Corner = Corner
	local CategoryName = LUI.UIText.new(0.48, 0.48, -110, 110, 0, 0, 10, 31)
	CategoryName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CategoryName:setTTF("ttmussels_regular")
	CategoryName:setLetterSpacing(2)
	CategoryName:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	CategoryName:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	CategoryName:linkToElementModel(self, "groupName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CategoryName:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(CategoryName)
	self.CategoryName = CategoryName
	local CustomLabel = CoD.CustomGames_OptionCategoryCustomLabel.new(f1_arg0, f1_arg1, 0, 0, 10, 230, 0, 0, 52, 70)
	CustomLabel:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return not CoD.OptionsUtility.IsCustomGameOptionCategoryDefault(self, f1_arg1)
			end,
		},
	})
	local PixelGrid = CustomLabel
	local SelectionOverlay = CustomLabel.subscribeToModel
	local FlyoutIndicator = Engine[@"getglobalmodel"]()
	SelectionOverlay(PixelGrid, FlyoutIndicator["GametypeSettings.Update"], function(f5_arg0)
		f1_arg0:updateElementState(CustomLabel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "GametypeSettings.Update",
		})
	end, false)
	CustomLabel.Default:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CustomLabel:linkToElementModel(self, nil, false, function(model)
		CustomLabel:setModel(model, f1_arg1)
	end)
	self:addElement(CustomLabel)
	self.CustomLabel = CustomLabel
	SelectionOverlay = LUI.UIImage.new(0, 0, 0, 240, 0, 0, 0, 112)
	SelectionOverlay:setAlpha(0)
	self:addElement(SelectionOverlay)
	self.SelectionOverlay = SelectionOverlay
	PixelGrid = LUI.UIImage.new(0, 0.96, 0, 0, -0.11, 1, 12, 0)
	PixelGrid:setAlpha(0.08)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	FlyoutIndicator = CoD.StartMenu_Options_FlyoutIndicator.new(f1_arg0, f1_arg1, 1, 1, -6.5, -2.5, 0, 0, 1, 109)
	FlyoutIndicator:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return not CoD.OptionsUtility.IsCustomGameOptionCategoryDefault(self, f1_arg1)
			end,
		},
	})
	local FrameSelected = FlyoutIndicator
	local ItemFrameAdd = FlyoutIndicator.subscribeToModel
	local ItemFrame = Engine[@"getglobalmodel"]()
	ItemFrameAdd(FrameSelected, ItemFrame["GametypeSettings.Update"], function(f9_arg0)
		f1_arg0:updateElementState(FlyoutIndicator, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "GametypeSettings.Update",
		})
	end, false)
	FlyoutIndicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FlyoutIndicator:setAlpha(0.1)
	FlyoutIndicator:linkToElementModel(self, nil, false, function(model)
		FlyoutIndicator:setModel(model, f1_arg1)
	end)
	self:addElement(FlyoutIndicator)
	self.FlyoutIndicator = FlyoutIndicator
	ItemFrameAdd = LUI.UIImage.new(0, 0, -3.5, 243.5, 0, 0, -1, 111)
	ItemFrameAdd:setAlpha(0)
	ItemFrameAdd:setImage(RegisterImage(@"uie_ui_menu_store_element_frame"))
	ItemFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ItemFrameAdd:setShaderVector(0, 0, 0, 0, 0)
	ItemFrameAdd:setupNineSliceShader(12, 164)
	self:addElement(ItemFrameAdd)
	self.ItemFrameAdd = ItemFrameAdd
	FrameSelected = LUI.UIImage.new(0, 0, -3.5, 243.5, 0, 0, -3.5, 113.5)
	FrameSelected:setAlpha(0)
	FrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrameSelected:setupNineSliceShader(8, 8)
	self:addElement(FrameSelected)
	self.FrameSelected = FrameSelected
	ItemFrame = LUI.UIImage.new(0, 0, -3.5, 243.5, 0, 0, -1, 111)
	ItemFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ItemFrame:setImage(RegisterImage(@"uie_ui_menu_store_element_frame_gray"))
	ItemFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	ItemFrame:setShaderVector(0, 0, 0, 0, 0)
	ItemFrame:setupNineSliceShader(12, 164)
	self:addElement(ItemFrame)
	self.ItemFrame = ItemFrame
	local TopBar = LUI.UIImage.new(0, 0, -56, 56, 0.5, 0.5, -0.5, 0.5)
	TopBar:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TopBar:setAlpha(0.2)
	TopBar:setZRot(-90)
	TopBar:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBar)
	self.TopBar = TopBar
	local TopBarFocus = LUI.UIImage.new(0, 0, -60, 60, 0.5, 0.5, -1, 1)
	TopBarFocus:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TopBarFocus:setAlpha(0)
	TopBarFocus:setZRot(-90)
	TopBarFocus:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar_focused"))
	TopBarFocus:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBarFocus)
	self.TopBarFocus = TopBarFocus
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Selected") and CoD.ModelUtility.IsModelValueTrue(f1_arg1, "customGamesEdit")
			end,
		},
		{
			stateName = "EditSettings",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "customGamesEdit")
			end,
		},
	})
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local14(f1_local13, f1_local15.customGamesEdit, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "customGamesEdit",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomGames_OptionCategoryButton.__resetProperties = function(f15_arg0)
	f15_arg0.TopBarFocus:completeAnimation()
	f15_arg0.Corner:completeAnimation()
	f15_arg0.ButtonBG:completeAnimation()
	f15_arg0.SelectionOverlay:completeAnimation()
	f15_arg0.CategoryName:completeAnimation()
	f15_arg0.ItemFrame:completeAnimation()
	f15_arg0.FrameSelected:completeAnimation()
	f15_arg0.ItemFrameAdd:completeAnimation()
	f15_arg0.FlyoutIndicator:completeAnimation()
	f15_arg0.CustomLabel:completeAnimation()
	f15_arg0.PixelGrid:completeAnimation()
	f15_arg0.TopBar:completeAnimation()
	f15_arg0.TopBarFocus:setAlpha(0)
	f15_arg0.Corner:setAlpha(1)
	f15_arg0.Corner:setScale(0.98, 0.97)
	f15_arg0.ButtonBG:setRGB(0.38, 0.38, 0.38)
	f15_arg0.ButtonBG:setAlpha(0.8)
	f15_arg0.SelectionOverlay:setRGB(1, 1, 1)
	f15_arg0.SelectionOverlay:setAlpha(0)
	f15_arg0.SelectionOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f15_arg0.CategoryName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f15_arg0.CategoryName:setAlpha(1)
	f15_arg0.ItemFrame:setAlpha(1)
	f15_arg0.FrameSelected:setAlpha(0)
	f15_arg0.ItemFrameAdd:setAlpha(0)
	f15_arg0.FlyoutIndicator:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f15_arg0.FlyoutIndicator:setAlpha(0.1)
	f15_arg0.CustomLabel:setAlpha(1)
	f15_arg0.CustomLabel.Default:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f15_arg0.PixelGrid:setAlpha(0.08)
	f15_arg0.TopBar:setAlpha(0.2)
end
CoD.CustomGames_OptionCategoryButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(10)
			f17_arg0.ButtonBG:completeAnimation()
			f17_arg0.ButtonBG:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f17_arg0.ButtonBG:setAlpha(0.4)
			f17_arg0.clipFinished(f17_arg0.ButtonBG)
			f17_arg0.Corner:completeAnimation()
			f17_arg0.Corner:setScale(0.94, 0.9)
			f17_arg0.clipFinished(f17_arg0.Corner)
			f17_arg0.CategoryName:completeAnimation()
			f17_arg0.CategoryName:setRGB(0.92, 0.89, 0.72)
			f17_arg0.clipFinished(f17_arg0.CategoryName)
			f17_arg0.CustomLabel:completeAnimation()
			f17_arg0.CustomLabel.Default:completeAnimation()
			f17_arg0.CustomLabel.Default:setRGB(0.92, 0.89, 0.72)
			f17_arg0.clipFinished(f17_arg0.CustomLabel)
			f17_arg0.SelectionOverlay:completeAnimation()
			f17_arg0.SelectionOverlay:setAlpha(0.02)
			f17_arg0.clipFinished(f17_arg0.SelectionOverlay)
			f17_arg0.FlyoutIndicator:completeAnimation()
			f17_arg0.FlyoutIndicator:setRGB(0.92, 0.89, 0.72)
			f17_arg0.FlyoutIndicator:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FlyoutIndicator)
			f17_arg0.ItemFrameAdd:completeAnimation()
			f17_arg0.ItemFrameAdd:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ItemFrameAdd)
			f17_arg0.FrameSelected:completeAnimation()
			f17_arg0.FrameSelected:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FrameSelected)
			f17_arg0.ItemFrame:completeAnimation()
			f17_arg0.ItemFrame:setAlpha(0.7)
			f17_arg0.clipFinished(f17_arg0.ItemFrame)
			f17_arg0.TopBarFocus:completeAnimation()
			f17_arg0.TopBarFocus:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.TopBarFocus)
		end,
		GainFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(7)
			local f18_local0 = function(f19_arg0)
				f18_arg0.ButtonBG:beginAnimation(150)
				f18_arg0.ButtonBG:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f18_arg0.ButtonBG:setAlpha(0.4)
				f18_arg0.ButtonBG:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.ButtonBG:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.ButtonBG:completeAnimation()
			f18_arg0.ButtonBG:setRGB(0.38, 0.38, 0.38)
			f18_arg0.ButtonBG:setAlpha(0.8)
			f18_local0(f18_arg0.ButtonBG)
			local f18_local1 = function(f20_arg0)
				f18_arg0.Corner:beginAnimation(150)
				f18_arg0.Corner:setScale(0.94, 0.9)
				f18_arg0.Corner:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Corner:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Corner:completeAnimation()
			f18_arg0.Corner:setScale(0.98, 0.97)
			f18_local1(f18_arg0.Corner)
			local f18_local2 = function(f21_arg0)
				f18_arg0.SelectionOverlay:beginAnimation(150)
				f18_arg0.SelectionOverlay:setAlpha(0.02)
				f18_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.SelectionOverlay:completeAnimation()
			f18_arg0.SelectionOverlay:setAlpha(0)
			f18_local2(f18_arg0.SelectionOverlay)
			local f18_local3 = function(f22_arg0)
				f18_arg0.FlyoutIndicator:beginAnimation(150)
				f18_arg0.FlyoutIndicator:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FlyoutIndicator:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FlyoutIndicator:completeAnimation()
			f18_arg0.FlyoutIndicator:setRGB(0.92, 0.89, 0.72)
			f18_arg0.FlyoutIndicator:setAlpha(1)
			f18_local3(f18_arg0.FlyoutIndicator)
			local f18_local4 = function(f23_arg0)
				f18_arg0.ItemFrameAdd:beginAnimation(150)
				f18_arg0.ItemFrameAdd:setAlpha(1)
				f18_arg0.ItemFrameAdd:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.ItemFrameAdd:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.ItemFrameAdd:completeAnimation()
			f18_arg0.ItemFrameAdd:setAlpha(0)
			f18_local4(f18_arg0.ItemFrameAdd)
			local f18_local5 = function(f24_arg0)
				f18_arg0.FrameSelected:beginAnimation(150)
				f18_arg0.FrameSelected:setAlpha(1)
				f18_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FrameSelected:completeAnimation()
			f18_arg0.FrameSelected:setAlpha(0)
			f18_local5(f18_arg0.FrameSelected)
			local f18_local6 = function(f25_arg0)
				f18_arg0.TopBarFocus:beginAnimation(150)
				f18_arg0.TopBarFocus:setAlpha(1)
				f18_arg0.TopBarFocus:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.TopBarFocus:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.TopBarFocus:completeAnimation()
			f18_arg0.TopBarFocus:setAlpha(0)
			f18_local6(f18_arg0.TopBarFocus)
		end,
		LoseFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(7)
			local f26_local0 = function(f27_arg0)
				f26_arg0.ButtonBG:beginAnimation(150)
				f26_arg0.ButtonBG:setRGB(0.38, 0.38, 0.38)
				f26_arg0.ButtonBG:setAlpha(0.8)
				f26_arg0.ButtonBG:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ButtonBG:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.ButtonBG:completeAnimation()
			f26_arg0.ButtonBG:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f26_arg0.ButtonBG:setAlpha(0.4)
			f26_local0(f26_arg0.ButtonBG)
			local f26_local1 = function(f28_arg0)
				f26_arg0.Corner:beginAnimation(150)
				f26_arg0.Corner:setScale(0.98, 0.97)
				f26_arg0.Corner:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Corner:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Corner:completeAnimation()
			f26_arg0.Corner:setScale(0.94, 0.9)
			f26_local1(f26_arg0.Corner)
			local f26_local2 = function(f29_arg0)
				f26_arg0.SelectionOverlay:beginAnimation(150)
				f26_arg0.SelectionOverlay:setAlpha(0)
				f26_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.SelectionOverlay:completeAnimation()
			f26_arg0.SelectionOverlay:setAlpha(0.02)
			f26_local2(f26_arg0.SelectionOverlay)
			local f26_local3 = function(f30_arg0)
				f26_arg0.FlyoutIndicator:beginAnimation(150)
				f26_arg0.FlyoutIndicator:setAlpha(0.1)
				f26_arg0.FlyoutIndicator:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FlyoutIndicator:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FlyoutIndicator:completeAnimation()
			f26_arg0.FlyoutIndicator:setAlpha(1)
			f26_local3(f26_arg0.FlyoutIndicator)
			local f26_local4 = function(f31_arg0)
				f26_arg0.ItemFrameAdd:beginAnimation(150)
				f26_arg0.ItemFrameAdd:setAlpha(0)
				f26_arg0.ItemFrameAdd:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ItemFrameAdd:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.ItemFrameAdd:completeAnimation()
			f26_arg0.ItemFrameAdd:setAlpha(1)
			f26_local4(f26_arg0.ItemFrameAdd)
			local f26_local5 = function(f32_arg0)
				f26_arg0.FrameSelected:beginAnimation(150)
				f26_arg0.FrameSelected:setAlpha(0)
				f26_arg0.FrameSelected:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.FrameSelected:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.FrameSelected:completeAnimation()
			f26_arg0.FrameSelected:setAlpha(1)
			f26_local5(f26_arg0.FrameSelected)
			local f26_local6 = function(f33_arg0)
				f26_arg0.TopBarFocus:beginAnimation(150)
				f26_arg0.TopBarFocus:setAlpha(0)
				f26_arg0.TopBarFocus:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.TopBarFocus:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.TopBarFocus:completeAnimation()
			f26_arg0.TopBarFocus:setAlpha(1)
			f26_local6(f26_arg0.TopBarFocus)
		end,
		Active = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.FlyoutIndicator:completeAnimation()
			f34_arg0.FlyoutIndicator:setRGB(0.92, 0.89, 0.72)
			f34_arg0.FlyoutIndicator:setAlpha(0.5)
			f34_arg0.clipFinished(f34_arg0.FlyoutIndicator)
			f34_arg0.FrameSelected:completeAnimation()
			f34_arg0.FrameSelected:setAlpha(0.5)
			f34_arg0.clipFinished(f34_arg0.FrameSelected)
		end,
		ActiveAndFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(6)
			f35_arg0.Corner:completeAnimation()
			f35_arg0.Corner:setScale(0.94, 0.9)
			f35_arg0.clipFinished(f35_arg0.Corner)
			f35_arg0.SelectionOverlay:completeAnimation()
			f35_arg0.SelectionOverlay:setRGB(0.92, 0.89, 0.72)
			f35_arg0.SelectionOverlay:setAlpha(0.08)
			f35_arg0.SelectionOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f35_arg0.clipFinished(f35_arg0.SelectionOverlay)
			f35_arg0.PixelGrid:completeAnimation()
			f35_arg0.PixelGrid:setAlpha(0.15)
			f35_arg0.clipFinished(f35_arg0.PixelGrid)
			f35_arg0.FlyoutIndicator:completeAnimation()
			f35_arg0.FlyoutIndicator:setRGB(0.92, 0.89, 0.72)
			f35_arg0.FlyoutIndicator:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.FlyoutIndicator)
			f35_arg0.FrameSelected:completeAnimation()
			f35_arg0.FrameSelected:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.FrameSelected)
			f35_arg0.TopBarFocus:completeAnimation()
			f35_arg0.TopBarFocus:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.TopBarFocus)
		end,
	},
	Disabled = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(5)
			f36_arg0.ButtonBG:completeAnimation()
			f36_arg0.ButtonBG:setAlpha(0.2)
			f36_arg0.clipFinished(f36_arg0.ButtonBG)
			f36_arg0.Corner:completeAnimation()
			f36_arg0.Corner:setAlpha(0.3)
			f36_arg0.clipFinished(f36_arg0.Corner)
			f36_arg0.CategoryName:completeAnimation()
			f36_arg0.CategoryName:setAlpha(0.3)
			f36_arg0.clipFinished(f36_arg0.CategoryName)
			f36_arg0.CustomLabel:completeAnimation()
			f36_arg0.CustomLabel:setAlpha(0.3)
			f36_arg0.clipFinished(f36_arg0.CustomLabel)
			f36_arg0.ItemFrame:completeAnimation()
			f36_arg0.ItemFrame:setAlpha(0.3)
			f36_arg0.clipFinished(f36_arg0.ItemFrame)
		end,
	},
	Selected = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			f37_arg0.Corner:completeAnimation()
			f37_arg0.Corner:setScale(0.94, 0.9)
			f37_arg0.clipFinished(f37_arg0.Corner)
			f37_arg0.SelectionOverlay:completeAnimation()
			f37_arg0.SelectionOverlay:setAlpha(0.05)
			f37_arg0.clipFinished(f37_arg0.SelectionOverlay)
			f37_arg0.TopBarFocus:completeAnimation()
			f37_arg0.TopBarFocus:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.TopBarFocus)
		end,
	},
	EditSettings = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(4)
			f38_arg0.Corner:completeAnimation()
			f38_arg0.Corner:setAlpha(0.5)
			f38_arg0.clipFinished(f38_arg0.Corner)
			f38_arg0.CategoryName:completeAnimation()
			f38_arg0.CategoryName:setAlpha(0.15)
			f38_arg0.clipFinished(f38_arg0.CategoryName)
			f38_arg0.CustomLabel:completeAnimation()
			f38_arg0.CustomLabel:setAlpha(0.15)
			f38_arg0.clipFinished(f38_arg0.CustomLabel)
			f38_arg0.TopBar:completeAnimation()
			f38_arg0.TopBar:setAlpha(0.25)
			f38_arg0.clipFinished(f38_arg0.TopBar)
		end,
	},
}
CoD.CustomGames_OptionCategoryButton.__onClose = function(f39_arg0)
	f39_arg0.Corner:close()
	f39_arg0.CategoryName:close()
	f39_arg0.CustomLabel:close()
	f39_arg0.FlyoutIndicator:close()
end
