require("x64:9c28c8f05d254f8")
CoD.SurveyResponseList = InheritFrom(LUI.UIElement)
CoD.SurveyResponseList.__defaultWidth = 371
CoD.SurveyResponseList.__defaultHeight = 428
CoD.SurveyResponseList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SurveyResponseList)
	self.id = "SurveyResponseList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ResponseOptions = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	ResponseOptions:setLeftRight(0, 0, 0, 400)
	ResponseOptions:setTopBottom(0, 0, 0, 520)
	ResponseOptions:setWidgetType(CoD.SurveyButton)
	ResponseOptions:setVerticalCount(6)
	ResponseOptions:setSpacing(20)
	ResponseOptions:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ResponseOptions:setDataSource("SurveyResponseOptions")
	self:addElement(ResponseOptions)
	self.ResponseOptions = ResponseOptions
	ResponseOptions.id = "ResponseOptions"
	self.__defaultFocus = ResponseOptions
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SurveyResponseList.__onClose = function(f2_arg0)
	f2_arg0.ResponseOptions:close()
end
