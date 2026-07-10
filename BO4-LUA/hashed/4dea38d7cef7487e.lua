require("x64:bc87ac3fc76bb82")
CoD.BM_BountyDetails = InheritFrom(LUI.UIElement)
CoD.BM_BountyDetails.__defaultWidth = 800
CoD.BM_BountyDetails.__defaultHeight = 100
CoD.BM_BountyDetails.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_BountyDetails)
	self.id = "BM_BountyDetails"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ContractRarityHeader = CoD.ContractRarityHeader.new(f1_arg0, f1_arg1, 0, 0, 23, 223, 0, 0, 3, 30)
	ContractRarityHeader:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeader:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeader)
	self.ContractRarityHeader = ContractRarityHeader
	local Name = LUI.UIText.new(0, 0, 0, 383, 0, 0, 34.5, 64.5)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(4)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Name:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Desc = LUI.UIText.new(0, 0, 0, 383, 0, 0, 70.5, 88.5)
	Desc:setTTF("dinnext_regular")
	Desc:setLetterSpacing(1)
	Desc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Desc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Desc:linkToElementModel(self, "desc", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Desc:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_BountyDetails.__resetProperties = function(f5_arg0)
	f5_arg0.Desc:completeAnimation()
	f5_arg0.Name:completeAnimation()
	f5_arg0.ContractRarityHeader:completeAnimation()
	f5_arg0.Desc:setAlpha(1)
	f5_arg0.Name:setAlpha(1)
	f5_arg0.ContractRarityHeader:setAlpha(1)
end
CoD.BM_BountyDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.ContractRarityHeader:completeAnimation()
			f7_arg0.ContractRarityHeader:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ContractRarityHeader)
			f7_arg0.Name:completeAnimation()
			f7_arg0.Name:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Name)
			f7_arg0.Desc:completeAnimation()
			f7_arg0.Desc:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Desc)
		end,
	},
}
CoD.BM_BountyDetails.__onClose = function(f8_arg0)
	f8_arg0.ContractRarityHeader:close()
	f8_arg0.Name:close()
	f8_arg0.Desc:close()
end
