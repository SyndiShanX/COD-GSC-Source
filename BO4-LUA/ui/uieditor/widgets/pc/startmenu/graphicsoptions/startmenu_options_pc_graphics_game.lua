require("x64:47803d0fb7647f2")
require("x64:84662ffcdea628")
local PostLoadFunc = function(self, controller, menu)
	self:dispatchEventToChildren({
		name = "options_refresh",
		controller = controller,
	})
	self.graphicsList.m_managedItemPriority = true
	self:registerEventHandler("dropdown_triggered", function(element, event)
		for f2_local0 = 1, element.graphicsList.requestedRowCount, 1 do
			local f2_local3 = element.graphicsList:getItemAtPosition(f2_local0, 1)
			if event.inUse then
				if f2_local3 ~= event.widget then
					f2_local3.m_inputDisabled = true
				end
			end
			f2_local3.m_inputDisabled = false
		end
	end)
end
CoD.StartMenu_Options_PC_Graphics_Game = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_Graphics_Game.__defaultWidth = 1650
CoD.StartMenu_Options_PC_Graphics_Game.__defaultHeight = 900
CoD.StartMenu_Options_PC_Graphics_Game.new = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	local self = LUI.UIElement.new(f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	self:setClass(CoD.StartMenu_Options_PC_Graphics_Game)
	self.id = "StartMenu_Options_PC_Graphics_Game"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local graphicsList = LUI.UIList.new(f3_arg0, f3_arg1, 0, 0, nil, false, false, false, false)
	graphicsList:setLeftRight(0, 0, 0, 750)
	graphicsList:setTopBottom(0, 0, 45, 759)
	graphicsList:setWidgetType(CoD.OptionDropdown)
	graphicsList:setVerticalCount(14)
	graphicsList:setSpacing(0)
	graphicsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	graphicsList:setDataSource("OptionGraphicsGame")
	self:addElement(graphicsList)
	self.graphicsList = graphicsList
	local optionInfo = CoD.OptionInfoWidget.new(f3_arg0, f3_arg1, 0, 0, 825, 1425, 0, 0, 45, 495)
	self:addElement(optionInfo)
	self.optionInfo = optionInfo
	optionInfo:linkToElementModel(graphicsList, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			optionInfo.description:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	optionInfo:linkToElementModel(graphicsList, "label", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			optionInfo.title.itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	graphicsList.id = "graphicsList"
	self.__defaultFocus = graphicsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg1, f3_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_Graphics_Game.__onClose = function(f6_arg0)
	f6_arg0.optionInfo:close()
	f6_arg0.graphicsList:close()
end
