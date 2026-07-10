require("x64:1404c0d595e4eb5")
CoD.EntitlementListContainer = InheritFrom(LUI.UIElement)
CoD.EntitlementListContainer.__defaultWidth = 1110
CoD.EntitlementListContainer.__defaultHeight = 240
CoD.EntitlementListContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EntitlementListContainer)
	self.id = "EntitlementListContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EntitlementItemList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	EntitlementItemList:setLeftRight(0, 0, 0, 1110)
	EntitlementItemList:setTopBottom(0, 0, 0, 240)
	EntitlementItemList:setWidgetType(CoD.EntitlementListItem)
	EntitlementItemList:setHorizontalCount(2)
	EntitlementItemList:setVerticalCount(5)
	EntitlementItemList:setSpacing(10)
	EntitlementItemList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EntitlementItemList:setDataSource("EntitlementItemList")
	self:addElement(EntitlementItemList)
	self.EntitlementItemList = EntitlementItemList
	self:mergeStateConditions({
		{
			stateName = "hidecodpoints",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "EntitlementData.addsCODPoints")
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["EntitlementData.addsCODPoints"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "EntitlementData.addsCODPoints",
		})
	end, false)
	EntitlementItemList.id = "EntitlementItemList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EntitlementListContainer.__onClose = function(f4_arg0)
	f4_arg0.EntitlementItemList:close()
end
