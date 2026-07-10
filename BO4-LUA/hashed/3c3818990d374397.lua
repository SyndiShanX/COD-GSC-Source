require("x64:29187ea00d726c3")
CoD.MeritReportHeaderText = InheritFrom(LUI.UIElement)
CoD.MeritReportHeaderText.__defaultWidth = 616
CoD.MeritReportHeaderText.__defaultHeight = 120
CoD.MeritReportHeaderText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.MeritReportHeaderText)
	self.id = "MeritReportHeaderText"
	self.soundSet = "default"
	local PlaceLabel = LUI.UIText.new(0, 0, 0, 262, 0, 0, 33, 87)
	PlaceLabel:setRGB(0.92, 0.92, 0.92)
	PlaceLabel:setAlpha(0.5)
	PlaceLabel:setText(LocalizeToUpperString(@"aar/place"))
	PlaceLabel:setTTF("default")
	PlaceLabel:setLetterSpacing(4)
	PlaceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlaceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlaceLabel)
	self.PlaceLabel = PlaceLabel
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 262, 278, 0, 0, -11, 109)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local Placement = LUI.UIText.new(0, 0, 278, 408, 0, 0, 24, 96)
	Placement:setTTF("0arame_mono_stencil")
	Placement:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Placement:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Placement:linkToElementModel(self, "placement", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Placement:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(Placement)
	self.Placement = Placement
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MeritReportHeaderText.__onClose = function(f3_arg0)
	f3_arg0.Spacer:close()
	f3_arg0.Placement:close()
end
