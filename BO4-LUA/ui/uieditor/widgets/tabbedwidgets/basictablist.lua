require("x64:31f27d414cc7ab7")
CoD.basicTabList = InheritFrom(LUI.UIElement)
CoD.basicTabList.__defaultWidth = 1635
CoD.basicTabList.__defaultHeight = 60
CoD.basicTabList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.basicTabList)
	self.id = "basicTabList"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local grid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 3, 0, nil, nil, false, false, false, false)
	grid:setLeftRight(0, 0, 0, 1635)
	grid:setTopBottom(0, 0, 0, 60)
	grid:setWidgetType(CoD.basicTabWidget)
	grid:setHorizontalCount(6)
	grid:setSpacing(3)
	grid:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	grid:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(grid, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		SelectItemIfPossible(self, element, controller)
		PlaySoundSetSound(self, "list_right")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(grid, "setWidth", function(element, controller)
		ScaleToElementWidth(self, element, 0)
	end)
	grid:subscribeToGlobalModel(f1_arg1, "PerController", "PositionDraft.stage", function(model)
		local f6_local0 = grid
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "PositionDraft.stage", 5) then
			CoD.GridAndListUtility.UpdateDataSource(f6_local0, false, false, true)
		end
	end)
	self:addElement(grid)
	self.grid = grid
	grid.id = "grid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, grid, f1_arg1)
	return self
end
CoD.basicTabList.__resetProperties = function(f7_arg0)
	f7_arg0.grid:completeAnimation()
	f7_arg0.grid:setAlpha(1)
end
CoD.basicTabList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.grid:completeAnimation()
			f9_arg0.grid:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.grid)
		end,
	},
}
CoD.basicTabList.__onClose = function(f10_arg0)
	f10_arg0.grid:close()
end
