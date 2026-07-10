require("x64:78d9663be3f826")
require("x64:81a24c5340caa1e")
CoD.DirectorTheaterSelectFile = InheritFrom(LUI.UIElement)
CoD.DirectorTheaterSelectFile.__defaultWidth = 1920
CoD.DirectorTheaterSelectFile.__defaultHeight = 1080
CoD.DirectorTheaterSelectFile.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTheaterSelectFile)
	self.id = "DirectorTheaterSelectFile"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TabFrame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -782.5, 782.5)
	TabFrame:setTopBottom(0.5, 0.5, -398, 382)
	TabFrame:setScale(0.96, 0.96)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local TabBacking = CoD.CommonTabBarBacking.new(f1_arg0, f1_arg1, -0.5, 1.5, 0, 0, 0, 0, 52, 89)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local Tabs = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, 36.5, 97.5)
	Tabs.Tabs.grid:setDataSource("FileshareMyTheaterCategoriesList")
	Tabs:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		FileshareCategorySelectorItemSelected(self, element, f1_arg1)
		return f2_local0
	end)
	self:addElement(Tabs)
	self.Tabs = Tabs
	TabFrame:linkToElementModel(Tabs.Tabs.grid, "tabWidget", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TabFrame:changeFrameWidget(f3_local0)
		end
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x0, nil, nil)
		return false
	end, false)
	TabFrame.id = "TabFrame"
	Tabs.id = "Tabs"
	self.__defaultFocus = TabFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTheaterSelectFile.__onClose = function(f6_arg0)
	f6_arg0.TabFrame:close()
	f6_arg0.TabBacking:close()
	f6_arg0.Tabs:close()
end
