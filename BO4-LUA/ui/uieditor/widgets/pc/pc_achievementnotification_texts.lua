CoD.PC_AchievementNotification_Texts = InheritFrom(LUI.UIElement)
CoD.PC_AchievementNotification_Texts.__defaultWidth = 284
CoD.PC_AchievementNotification_Texts.__defaultHeight = 35
CoD.PC_AchievementNotification_Texts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 2, false)
	self:setAlignment(LUI.Alignment.Middle)
	self:setClass(CoD.PC_AchievementNotification_Texts)
	self.id = "PC_AchievementNotification_Texts"
	self.soundSet = "default"
	local CompletesMessage = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 13)
	CompletesMessage:setRGB(0.7, 0.67, 0.62)
	CompletesMessage:setAlpha(0.5)
	CompletesMessage:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_27B2FB935B1A0F49"))
	CompletesMessage:setTTF("ttmussels_regular")
	CompletesMessage:setLetterSpacing(2)
	CompletesMessage:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	CompletesMessage:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(CompletesMessage)
	self.CompletesMessage = CompletesMessage
	local Name = LUI.UIText.new(0, 1, 0, 0, 0, 0, 16, 34)
	Name:setRGB(0.7, 0.67, 0.62)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(2)
	Name:setLineSpacing(1)
	Name:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Name:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	Name:subscribeToGlobalModel(f1_arg1, "PCAchievementNotification", "name", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f2_local0))
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
CoD.PC_AchievementNotification_Texts.__onClose = function(f3_arg0)
	f3_arg0.Name:close()
end
