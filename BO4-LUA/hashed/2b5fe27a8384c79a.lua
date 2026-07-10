require("x64:4875c56ab1b9ca8")
require("x64:2bf3da84e7ff2d3")
CoD.NameAndXPBonus = InheritFrom(LUI.UIElement)
CoD.NameAndXPBonus.__defaultWidth = 500
CoD.NameAndXPBonus.__defaultHeight = 56
CoD.NameAndXPBonus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Bottom)
	self:setClass(CoD.NameAndXPBonus)
	self.id = "NameAndXPBonus"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local XPIcon = CoD.UnlockBonusAndXPIcon.new(f1_arg0, f1_arg1, 0, 0, 0, 223, 0, 0, 35, 56)
	XPIcon:linkToElementModel(self, nil, false, function(model)
		XPIcon:setModel(model, f1_arg1)
	end)
	self:addElement(XPIcon)
	self.XPIcon = XPIcon
	local MastercraftName = CoD.onOffText.new(f1_arg0, f1_arg1, 0, 0, 0, 347, 0, 0, 17, 35)
	MastercraftName:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isMastercraft")
			end,
		},
	})
	MastercraftName:linkToElementModel(MastercraftName, "isMastercraft", true, function(model)
		f1_arg0:updateElementState(MastercraftName, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isMastercraft",
		})
	end)
	MastercraftName:setRGB(0.39, 0.39, 0.39)
	MastercraftName.TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	MastercraftName:linkToElementModel(self, nil, false, function(model)
		MastercraftName:setModel(model, f1_arg1)
	end)
	MastercraftName:linkToElementModel(self, "signatureVariantName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MastercraftName.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(MastercraftName)
	self.MastercraftName = MastercraftName
	local Spacer = LUI.UIImage.new(0, 0, 0, 500, 0, 0, 7, 17)
	Spacer:setImage(RegisterImage(@"blacktransparent"))
	self:addElement(Spacer)
	self.Spacer = Spacer
	local Name = LUI.UIText.new(0, 0, 0, 500, 0, 0, -25, 7)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(14)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Name:setText(ConvertToUpperString(CoD.BaseUtility.LocalizeIfXHash(f7_local0)))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NameAndXPBonus.__onClose = function(f8_arg0)
	f8_arg0.XPIcon:close()
	f8_arg0.MastercraftName:close()
	f8_arg0.Name:close()
end
