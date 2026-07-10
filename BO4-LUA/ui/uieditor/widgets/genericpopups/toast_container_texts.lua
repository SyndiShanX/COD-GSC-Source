CoD.Toast_Container_Texts = InheritFrom(LUI.UIElement)
CoD.Toast_Container_Texts.__defaultWidth = 271
CoD.Toast_Container_Texts.__defaultHeight = 53
CoD.Toast_Container_Texts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Middle)
	self:setClass(CoD.Toast_Container_Texts)
	self.id = "Toast_Container_Texts"
	self.soundSet = "default"
	local NotifText = LUI.UIText.new(0, 1, 1, 1, 0, 0, 0, 21)
	NotifText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	NotifText:setTTF("ttmussels_regular")
	NotifText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NotifText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	NotifText:linkToElementModel(self, "description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NotifText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(NotifText)
	self.NotifText = NotifText
	local NotifTextMain = LUI.UIText.new(0, 1, 0, 0, 1, 1, -27, 0)
	NotifTextMain:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	NotifTextMain:setTTF("ttmussels_regular")
	NotifTextMain:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(NotifTextMain)
	self.NotifTextMain = NotifTextMain
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Toast_Container_Texts.__onClose = function(f3_arg0)
	f3_arg0.NotifText:close()
end
