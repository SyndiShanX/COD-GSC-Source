require("x64:1394ae5e9cdcb54")
require("x64:37113d6053cc9f6")
require("x64:a969a8392712433")
CoD.DirectorFeaturedAccentCarousel = InheritFrom(LUI.UIElement)
CoD.DirectorFeaturedAccentCarousel.__defaultWidth = 581
CoD.DirectorFeaturedAccentCarousel.__defaultHeight = 38
CoD.DirectorFeaturedAccentCarousel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.DirectorFeaturedAccentCarousel)
	self.id = "DirectorFeaturedAccentCarousel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, -161, 39, 0, 0, 0, 34)
	LB:setRGB(0.66, 0.63, 0.52)
	LB:setAlpha(0.45)
	LB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBDCD5292604F434))
	LB.GamepadPrompt:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(LB)
	self.LB = LB
	local LeftArrow = nil
	LeftArrow = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, -251.5, -184.5, 0, 0, -4, 41)
	LeftArrow:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1) and AlwaysFalse()
			end,
		},
	})
	LeftArrow:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(LeftArrow, f3_arg1)
	end)
	local RightArrow = LeftArrow
	local PipsGrid = LeftArrow.subscribeToModel
	local RB = Engine[0x4DF5CFBC1771947](f1_arg1)
	PipsGrid(RightArrow, RB.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(LeftArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LeftArrow:setZRot(180)
	LeftArrow.KeyMouseImage:setImage(RegisterImage(0x5E74D00B45D12B6))
	LeftArrow.ControllerImage:setImage(RegisterImage(0x5E74D00B45D12B6))
	LeftArrow:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeftArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.GridAndListUtility.NavigateGridItem(self.PipsGrid, controller, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	PipsGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -19, 0, nil, nil, true, false, false, false)
	PipsGrid:setLeftRight(0, 0, 106, 475)
	PipsGrid:setTopBottom(0, 0, 8, 30)
	PipsGrid:setWidgetType(CoD.DirectorFeaturedPip)
	PipsGrid:setHorizontalCount(10)
	PipsGrid:setSpacing(-19)
	PipsGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PipsGrid:setDataSource("DirectorHomeButtons")
	PipsGrid:registerEventHandler("list_active_changed", function(element, event)
		local f8_local0 = nil
		CoD.MOTDUtility.FeatureCard_MarkAsViewed(self, f1_arg1, element)
		return f8_local0
	end)
	self:addElement(PipsGrid)
	self.PipsGrid = PipsGrid
	RightArrow = nil
	RightArrow = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, 184.5, 251.5, 0, 0, -4, 41)
	RightArrow:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1) and AlwaysFalse()
			end,
		},
	})
	RightArrow:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(RightArrow, f10_arg1)
	end)
	local f1_local6 = RightArrow
	RB = RightArrow.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	RB(f1_local6, f1_local7.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(RightArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	RightArrow.KeyMouseImage:setImage(RegisterImage(0x5E74D00B45D12B6))
	RightArrow.ControllerImage:setImage(RegisterImage(0x5E74D00B45D12B6))
	RightArrow:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightArrow, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.GridAndListUtility.NavigateGridItem(self.PipsGrid, controller, true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 542, 742, 0, 0, 0, 34)
	RB:setRGB(0.66, 0.63, 0.52)
	RB:setAlpha(0.45)
	RB.GamepadPrompt:setText(Engine[0xF9F1239CFD921FE](0xBFED5292621DA9A))
	self:addElement(RB)
	self.RB = RB
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ShowTriggers",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f17_arg1)
	end)
	f1_local7 = self
	f1_local6 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local7, f1_local8.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if CoD.isPC then
		LeftArrow.id = "LeftArrow"
	end
	PipsGrid.id = "PipsGrid"
	if CoD.isPC then
		RightArrow.id = "RightArrow"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.BaseUtility.SetUpProcessListElementOnCustomFunction(f1_arg0, self, self.PipsGrid, f1_arg1, "_activateFeaturedWidget")
	DisableKeyboardNavigationByElement(LeftArrow)
	f1_local6 = PipsGrid
	CoD.GridAndListUtility.AddBumperNavigationDontProcessAction(f1_arg0, f1_local6, f1_arg1)
	CoD.GridAndListUtility.CycleThroughItems(f1_arg0, f1_arg1, f1_local6, 3)
	CoD.DirectorUtility.AddFeaturedWidgetListAction(f1_arg0, f1_local6, f1_arg1)
	SetElementProperty(f1_local6, "__loopOnSameRow", true)
	DisableKeyboardNavigationByElement(RightArrow)
	return self
end
CoD.DirectorFeaturedAccentCarousel.__resetProperties = function(f19_arg0)
	f19_arg0.PipsGrid:completeAnimation()
	f19_arg0.PipsGrid:setAlpha(1)
end
CoD.DirectorFeaturedAccentCarousel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.PipsGrid:completeAnimation()
			f21_arg0.PipsGrid:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PipsGrid)
		end,
	},
	ShowTriggers = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorFeaturedAccentCarousel.__onClose = function(f23_arg0)
	f23_arg0.LB:close()
	f23_arg0.LeftArrow:close()
	f23_arg0.PipsGrid:close()
	f23_arg0.RightArrow:close()
	f23_arg0.RB:close()
end
