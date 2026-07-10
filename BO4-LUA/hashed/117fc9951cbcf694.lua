CoD.AARSquadPlacement = InheritFrom(LUI.UIElement)
CoD.AARSquadPlacement.__defaultWidth = 500
CoD.AARSquadPlacement.__defaultHeight = 40
CoD.AARSquadPlacement.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 20, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.AARSquadPlacement)
	self.id = "AARSquadPlacement"
	self.soundSet = "none"
	local PlaceLabel = LUI.UIText.new(0, 0, 5, 230, 0.5, 0.5, -20, 20)
	PlaceLabel:setRGB(0.9, 0.89, 0.78)
	PlaceLabel:setText(LocalizeToUpperString(@"aar/place"))
	PlaceLabel:setTTF("dinnext_regular")
	PlaceLabel:setLetterSpacing(2)
	PlaceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlaceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(PlaceLabel)
	self.PlaceLabel = PlaceLabel
	local Place = LUI.UIText.new(0, 0, 245, 500, 0.5, 0.5, -22, 20)
	Place:setRGB(0.9, 0.89, 0.78)
	Place:setTTF("0arame_mono_stencil")
	Place:setLetterSpacing(2)
	Place:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Place:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	Place:subscribeToGlobalModel(f1_arg1, "AARMeritReport", "placement", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Place:setText(f2_local0)
		end
	end)
	self:addElement(Place)
	self.Place = Place
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSquadPlacement.__onClose = function(f3_arg0)
	f3_arg0.Place:close()
end
