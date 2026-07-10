require("x64:221cc7053ccdd4f")
require("x64:46728994d8c06c0")
require("x64:50e26e98239f317")
CoD.SpecialistHeadquartersSpecialistInfo = InheritFrom(LUI.UIElement)
CoD.SpecialistHeadquartersSpecialistInfo.__defaultWidth = 487
CoD.SpecialistHeadquartersSpecialistInfo.__defaultHeight = 850
CoD.SpecialistHeadquartersSpecialistInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistHeadquartersSpecialistInfo)
	self.id = "SpecialistHeadquartersSpecialistInfo"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 487, 0, 0, 40, 830)
	CommonDetailPanel2.BackingTint:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local bgEkia = LUI.UIImage.new(0.5, 0.5, -233, 233, 0, 0, 295.5, 525.5)
	bgEkia:setRGB(0.23, 0.23, 0.23)
	bgEkia:setAlpha(0.25)
	self:addElement(bgEkia)
	self.bgEkia = bgEkia
	local SpecialistName = LUI.UIText.new(0, 0, 4, 386, 0, 0, 70, 137)
	SpecialistName:setRGB(0.92, 0.89, 0.72)
	SpecialistName:setAlpha(0.7)
	SpecialistName:setZoom(3)
	SpecialistName:setTTF("ttmussels_regular")
	SpecialistName:setLetterSpacing(5)
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpecialistName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpecialistName:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local JobTitle = LUI.UIText.new(0, 0, 9, 477, 0, 0, 51, 71)
	JobTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	JobTitle:setZoom(3)
	JobTitle:setTTF("ttmussels_regular")
	JobTitle:setLetterSpacing(5)
	JobTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	JobTitle:linkToElementModel(self, "jobTitle", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			JobTitle:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(JobTitle)
	self.JobTitle = JobTitle
	local DetailedDesc = LUI.UIText.new(0, 0, 9, 477, 0, 0, 140, 161)
	DetailedDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DetailedDesc:setAlpha(0.5)
	DetailedDesc:setTTF("ttmussels_regular")
	DetailedDesc:setLineSpacing(1)
	DetailedDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DetailedDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	DetailedDesc:linkToElementModel(self, "detailedDesc", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DetailedDesc:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(DetailedDesc)
	self.DetailedDesc = DetailedDesc
	local SpecialIssue = LUI.UIText.new(0, 0, 18, 468, 0, 0, 268, 292)
	SpecialIssue:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SpecialIssue:setAlpha(0.5)
	SpecialIssue:setText(LocalizeToUpperString(@"hash_729E45AE7FF6633E"))
	SpecialIssue:setTTF("ttmussels_regular")
	SpecialIssue:setLetterSpacing(6)
	SpecialIssue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(SpecialIssue)
	self.SpecialIssue = SpecialIssue
	local HubWeaponry = CoD.HubEquipmentItem.new(f1_arg0, f1_arg1, 0, 0, 12.5, 212.5, 0, 0, 280, 626)
	HubWeaponry:mergeStateConditions({
		{
			stateName = "NoStats",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	HubWeaponry.categoryHeader:setText(LocalizeToUpperString(@"hash_4A69F960F1CD39EE"))
	HubWeaponry.categoryHeader:setLetterSpacing(6)
	HubWeaponry.statHeader:setText("")
	HubWeaponry.statValue:setText("")
	HubWeaponry:linkToElementModel(self, "ability.image", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HubWeaponry.Icon:setImage(RegisterImage(f6_local0))
		end
	end)
	HubWeaponry:linkToElementModel(self, "ability.displayName", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			HubWeaponry.name:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(HubWeaponry)
	self.HubWeaponry = HubWeaponry
	local HubEquipment = CoD.HubEquipmentItem.new(f1_arg0, f1_arg1, 0, 0, 276, 476, 0, 0, 280, 626)
	HubEquipment:mergeStateConditions({
		{
			stateName = "NoStats",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	HubEquipment.categoryHeader:setText(LocalizeToUpperString(@"hash_5F3F4754CD03FA1D"))
	HubEquipment.categoryHeader:setLetterSpacing(6)
	HubEquipment.statHeader:setText("")
	HubEquipment.statValue:setText("")
	HubEquipment:linkToElementModel(self, "equipment.image", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			HubEquipment.Icon:setImage(RegisterImage(f9_local0))
		end
	end)
	HubEquipment:linkToElementModel(self, "equipment.displayName", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			HubEquipment.name:setText(Engine[@"hash_4F9F1239CFD921FE"](f10_local0))
		end
	end)
	self:addElement(HubEquipment)
	self.HubEquipment = HubEquipment
	local CombatTrainingProgress = CoD.SpecialistInfoCTOverallProgress.new(f1_arg0, f1_arg1, 0, 0, 0, 487, 0, 0, 540, 830)
	CombatTrainingProgress:linkToElementModel(self, nil, false, function(model)
		CombatTrainingProgress:setModel(model, f1_arg1)
	end)
	self:addElement(CombatTrainingProgress)
	self.CombatTrainingProgress = CombatTrainingProgress
	local DividerSolidBot2 = LUI.UIImage.new(0, 0, 10, 478, 0, 0, 256.5, 264.5)
	DividerSolidBot2:setAlpha(0.1)
	DividerSolidBot2:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	DividerSolidBot2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DividerSolidBot2:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidBot2:setupNineSliceShader(16, 8)
	self:addElement(DividerSolidBot2)
	self.DividerSolidBot2 = DividerSolidBot2
	local InfoDivider = LUI.UIImage.new(0, 0, 243.5, 247.5, 0, 0, 313.5, 434.5)
	InfoDivider:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_divider"))
	InfoDivider:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InfoDivider)
	self.InfoDivider = InfoDivider
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistHeadquartersSpecialistInfo.__resetProperties = function(f13_arg0)
	f13_arg0.CombatTrainingProgress:completeAnimation()
	f13_arg0.HubEquipment:completeAnimation()
	f13_arg0.HubWeaponry:completeAnimation()
	f13_arg0.SpecialIssue:completeAnimation()
	f13_arg0.DetailedDesc:completeAnimation()
	f13_arg0.JobTitle:completeAnimation()
	f13_arg0.SpecialistName:completeAnimation()
	f13_arg0.CommonDetailPanel2:completeAnimation()
	f13_arg0.bgEkia:completeAnimation()
	f13_arg0.DividerSolidBot2:completeAnimation()
	f13_arg0.InfoDivider:completeAnimation()
	f13_arg0.CombatTrainingProgress:setAlpha(1)
	f13_arg0.HubEquipment:setAlpha(1)
	f13_arg0.HubWeaponry:setAlpha(1)
	f13_arg0.SpecialIssue:setAlpha(0.5)
	f13_arg0.DetailedDesc:setAlpha(0.5)
	f13_arg0.JobTitle:setAlpha(1)
	f13_arg0.SpecialistName:setAlpha(0.7)
	f13_arg0.CommonDetailPanel2:setAlpha(1)
	f13_arg0.bgEkia:setAlpha(0.25)
	f13_arg0.DividerSolidBot2:setAlpha(0.1)
	f13_arg0.InfoDivider:setAlpha(1)
end
CoD.SpecialistHeadquartersSpecialistInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(11)
			f15_arg0.CommonDetailPanel2:completeAnimation()
			f15_arg0.CommonDetailPanel2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CommonDetailPanel2)
			f15_arg0.bgEkia:completeAnimation()
			f15_arg0.bgEkia:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.bgEkia)
			f15_arg0.SpecialistName:completeAnimation()
			f15_arg0.SpecialistName:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SpecialistName)
			f15_arg0.JobTitle:completeAnimation()
			f15_arg0.JobTitle:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.JobTitle)
			f15_arg0.DetailedDesc:completeAnimation()
			f15_arg0.DetailedDesc:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DetailedDesc)
			f15_arg0.SpecialIssue:completeAnimation()
			f15_arg0.SpecialIssue:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SpecialIssue)
			f15_arg0.HubWeaponry:completeAnimation()
			f15_arg0.HubWeaponry:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.HubWeaponry)
			f15_arg0.HubEquipment:completeAnimation()
			f15_arg0.HubEquipment:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.HubEquipment)
			f15_arg0.CombatTrainingProgress:completeAnimation()
			f15_arg0.CombatTrainingProgress:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CombatTrainingProgress)
			f15_arg0.DividerSolidBot2:completeAnimation()
			f15_arg0.DividerSolidBot2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DividerSolidBot2)
			f15_arg0.InfoDivider:completeAnimation()
			f15_arg0.InfoDivider:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.InfoDivider)
		end,
	},
}
CoD.SpecialistHeadquartersSpecialistInfo.__onClose = function(f16_arg0)
	f16_arg0.CommonDetailPanel2:close()
	f16_arg0.SpecialistName:close()
	f16_arg0.JobTitle:close()
	f16_arg0.DetailedDesc:close()
	f16_arg0.HubWeaponry:close()
	f16_arg0.HubEquipment:close()
	f16_arg0.CombatTrainingProgress:close()
end
