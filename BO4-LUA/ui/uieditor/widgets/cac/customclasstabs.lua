require("x64:1394ae5e9cdcb54")
require("x64:a22e4c82c4ffe1a")
require("x64:14ab47ffb48a077")
CoD.CustomClassTabs = InheritFrom(LUI.UIElement)
CoD.CustomClassTabs.__defaultWidth = 1920
CoD.CustomClassTabs.__defaultHeight = 98
CoD.CustomClassTabs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitGlobalModel("CACCurrentActiveTabIndex", 1)
	self:setClass(CoD.CustomClassTabs)
	self.id = "CustomClassTabs"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TabBackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 52, 89)
	TabBackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	TabBackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(TabBackingBlur)
	self.TabBackingBlur = TabBackingBlur
	local TabBackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 52, 89)
	TabBackingTint:setRGB(0.05, 0.05, 0.05)
	TabBackingTint:setAlpha(0)
	self:addElement(TabBackingTint)
	self.TabBackingTint = TabBackingTint
	local f1_local3 = nil
	self.NoiseTiledBacking = LUI.UIElement.createFake()
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, 695, 895, 0, 0, 53, 87)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -895, -695, 0, 0, 53, 87)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	local TabBottomLine = LUI.UIImage.new(0.5, 0.5, -960, 960, 0, 0, 86, 90)
	TabBottomLine:setAlpha(0.08)
	TabBottomLine:setImage(RegisterImage(0x5526CF3733E24C4))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	local right = nil
	right = CoD.PC_TabsArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, 720, 780, 0.5, 0.5, 2, 42)
	right:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsLastCACTabInRowActive(f1_arg1, self.grid)
			end,
		},
	})
	local grid = right
	local left = right.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	left(grid, f1_local10.CACCurrentActiveTabIndex, function(f3_arg0)
		f1_arg0:updateElementState(right, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "CACCurrentActiveTabIndex",
		})
	end, false)
	right:setAlpha(0)
	right:setZRot(180)
	right:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(right, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.GridAndListUtility.DoBumperGridButton(menu, controller, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(right)
	self.right = right
	left = nil
	left = CoD.PC_TabsArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -780, -720, 0.5, 0.5, 2, 42)
	left:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsFirstCACTabInRowActive(f1_arg1)
			end,
		},
	})
	f1_local10 = left
	grid = left.subscribeToModel
	local f1_local11 = Engine[0x8DF2E5447F384B9]()
	grid(f1_local10, f1_local11.CACCurrentActiveTabIndex, function(f8_arg0)
		f1_arg0:updateElementState(left, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "CACCurrentActiveTabIndex",
		})
	end, false)
	left:setAlpha(0)
	left:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(left, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.GridAndListUtility.DoBumperGridButton(menu, controller, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(left)
	self.left = left
	grid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	grid:setLeftRight(0.5, 0.5, -690, 690)
	grid:setTopBottom(0, 0, 52, 87)
	grid:setWidgetType(CoD.CACCustomClassListButton)
	grid:setHorizontalCount(6)
	grid:setSpacing(0)
	grid:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	grid:setStaggeredIntroTime(50)
	grid:setDataSource("ChooseClassList")
	grid:registerEventHandler("list_active_changed", function(element, event)
		local f12_local0 = nil
		CoD.CACUtility.UpdateSelectedCustomClass(f1_arg0, f1_arg1, element)
		CoD.BaseUtility.SetMenuModelToElementModel(f1_arg0, element)
		UpdateButtonPromptState(f1_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		UpdateButtonPromptState(f1_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.CACUtility.UpdateLockedStateForCustomClass(f1_arg0, f1_arg1)
		CoD.CACUtility.DelayedUpdateClassWeaponModel(f1_arg0, element, f1_arg1, 10)
		CoD.CACUtility.UpdateCACCurrentActiveTabIndexValue(f1_arg1, self.grid)
		CloseContextualMenu(f1_arg0, f1_arg1)
		return f12_local0
	end)
	self:addElement(grid)
	self.grid = grid
	self:mergeStateConditions({
		{
			stateName = "ArrowShown",
			condition = function(menu, element, event)
				return CoD.GridAndListUtility.ShowTabArrows(f1_arg1, self) and not IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f14_arg1)
	end)
	self:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f15_arg1)
	end)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if CoD.isPC then
		right.id = "right"
	end
	if CoD.isPC then
		left.id = "left"
	end
	grid.id = "grid"
	self.__defaultFocus = grid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	f1_local10 = grid
	DisableKeyboardNavigationByElement(f1_local10)
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, f1_local10, f1_arg1)
	return self
end
CoD.CustomClassTabs.__resetProperties = function(f17_arg0)
	f17_arg0.left:completeAnimation()
	f17_arg0.right:completeAnimation()
	f17_arg0.left:setAlpha(0)
	f17_arg0.right:setAlpha(0)
end
CoD.CustomClassTabs.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	ArrowShown = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.right:completeAnimation()
			f19_arg0.right:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.right)
			f19_arg0.left:completeAnimation()
			f19_arg0.left:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.left)
		end,
	},
}
CoD.CustomClassTabs.__onClose = function(f20_arg0)
	f20_arg0.RB:close()
	f20_arg0.LB:close()
	f20_arg0.right:close()
	f20_arg0.left:close()
	f20_arg0.grid:close()
end
