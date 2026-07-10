require("x64:79a33fa130e04bc")
CoD.CodCasterObjectiveStatusCTF = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusCTF.__defaultWidth = 412
CoD.CodCasterObjectiveStatusCTF.__defaultHeight = 64
CoD.CodCasterObjectiveStatusCTF.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusCTF)
	self.id = "CodCasterObjectiveStatusCTF"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterObjectiveStatusFlagA = CoD.CodCasterObjectiveStatusFlag.new(f1_arg0, f1_arg1, 0.05, 0.05, -32, 32, 0.85, 0.85, -32, 32)
	CodCasterObjectiveStatusFlagA:setScale(0.85, 0.85)
	CodCasterObjectiveStatusFlagA:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.color", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CodCasterObjectiveStatusFlagA.FlagIcon:setRGB(f2_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusFlagA)
	self.CodCasterObjectiveStatusFlagA = CodCasterObjectiveStatusFlagA
	local CodCasterObjectiveStatusFlagB = CoD.CodCasterObjectiveStatusFlag.new(f1_arg0, f1_arg1, 0.94, 0.94, -32, 32, 0.85, 0.85, -32, 32)
	CodCasterObjectiveStatusFlagB:setScale(0.85, 0.85)
	CodCasterObjectiveStatusFlagB:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CodCasterObjectiveStatusFlagB.FlagIcon:setRGB(f3_local0)
		end
	end)
	self:addElement(CodCasterObjectiveStatusFlagB)
	self.CodCasterObjectiveStatusFlagB = CodCasterObjectiveStatusFlagB
	local flagStatusA = LUI.UIText.new(0.08, 0.08, 0, 200, 0.87, 0.87, -7.5, 7.5)
	flagStatusA:setTTF("ttmussels_demibold")
	flagStatusA:setLetterSpacing(2)
	flagStatusA:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	flagStatusA:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	flagStatusA:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveA.text", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			flagStatusA:setText(f4_local0)
		end
	end)
	self:addElement(flagStatusA)
	self.flagStatusA = flagStatusA
	local flagStatusB = LUI.UIText.new(0.92, 0.92, -200, 0, 0.87, 0.87, -7.5, 7.5)
	flagStatusB:setTTF("ttmussels_demibold")
	flagStatusB:setLetterSpacing(2)
	flagStatusB:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	flagStatusB:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	flagStatusB:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.text", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			flagStatusB:setText(f5_local0)
		end
	end)
	self:addElement(flagStatusB)
	self.flagStatusB = flagStatusB
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatusCTF.__resetProperties = function(f6_arg0)
	f6_arg0.flagStatusA:completeAnimation()
	f6_arg0.CodCasterObjectiveStatusFlagB:completeAnimation()
	f6_arg0.CodCasterObjectiveStatusFlagA:completeAnimation()
	f6_arg0.flagStatusB:completeAnimation()
	f6_arg0.flagStatusA:setAlpha(1)
	f6_arg0.CodCasterObjectiveStatusFlagB:setAlpha(1)
	f6_arg0.CodCasterObjectiveStatusFlagA:setAlpha(1)
	f6_arg0.flagStatusB:setAlpha(1)
end
CoD.CodCasterObjectiveStatusCTF.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.CodCasterObjectiveStatusFlagA:completeAnimation()
			f8_arg0.CodCasterObjectiveStatusFlagA:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CodCasterObjectiveStatusFlagA)
			f8_arg0.CodCasterObjectiveStatusFlagB:completeAnimation()
			f8_arg0.CodCasterObjectiveStatusFlagB:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CodCasterObjectiveStatusFlagB)
			f8_arg0.flagStatusA:completeAnimation()
			f8_arg0.flagStatusA:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.flagStatusA)
			f8_arg0.flagStatusB:completeAnimation()
			f8_arg0.flagStatusB:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.flagStatusB)
		end,
	},
}
CoD.CodCasterObjectiveStatusCTF.__onClose = function(f9_arg0)
	f9_arg0.CodCasterObjectiveStatusFlagA:close()
	f9_arg0.CodCasterObjectiveStatusFlagB:close()
	f9_arg0.flagStatusA:close()
	f9_arg0.flagStatusB:close()
end
