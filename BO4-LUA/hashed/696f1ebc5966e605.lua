require("x64:1b6cbbf928daf6d")
CoD.LaboratoryOfferNameAndDescription = InheritFrom(LUI.UIElement)
CoD.LaboratoryOfferNameAndDescription.__defaultWidth = 480
CoD.LaboratoryOfferNameAndDescription.__defaultHeight = 60
CoD.LaboratoryOfferNameAndDescription.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryOfferNameAndDescription)
	self.id = "LaboratoryOfferNameAndDescription"
	self.soundSet = "default"
	local BG = CoD.LaboratoryOfferNameAndDescriptionBackground.new(f1_arg0, f1_arg1, 0.01, 0.99, -26, 26, 0, 0, -16, 104)
	self:addElement(BG)
	self.BG = BG
	local name = LUI.UIText.new(0, 1, 10, -10, 0, 0, 0, 20)
	name:setRGB(0.58, 0.85, 1)
	name:setTTF("skorzhen")
	name:setLetterSpacing(3)
	name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	name:linkToElementModel(self, "labelName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			name:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(name)
	self.name = name
	local description = LUI.UIText.new(0, 1, 10, -10, 0, 0, 25, 41)
	description:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	description:setTTF("dinnext_regular")
	description:setLetterSpacing(2)
	description:setLineSpacing(1)
	description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	description:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			description:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(description)
	self.description = description
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsSelfInState(self, "Middle") then
			SetElementState(self, element, controller, "Middle")
		elseif IsSelfInState(self, "Right") then
			SetElementState(self, element, controller, "Right")
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryOfferNameAndDescription.__onClose = function(f5_arg0)
	f5_arg0.BG:close()
	f5_arg0.name:close()
	f5_arg0.description:close()
end
