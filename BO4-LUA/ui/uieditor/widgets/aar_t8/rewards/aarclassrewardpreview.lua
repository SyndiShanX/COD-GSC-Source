require("x64:46fa4015e14fa27")
require("x64:4e6143dbc749ffd")
require("x64:377569138f4cdb9")
CoD.AARClassRewardPreview = InheritFrom(LUI.UIElement)
CoD.AARClassRewardPreview.__defaultWidth = 380
CoD.AARClassRewardPreview.__defaultHeight = 440
CoD.AARClassRewardPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARClassRewardPreview)
	self.id = "AARClassRewardPreview"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.64, 0.64, 0.64)
	Backing:setAlpha(0.04)
	self:addElement(Backing)
	self.Backing = Backing
	local Primary = LUI.UIFixedAspectRatioImage.new(0, 0, 19, 228, 0, 0, 22.5, 86.5)
	Primary:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Primary:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Primary)
	self.Primary = Primary
	local Secondary = LUI.UIFixedAspectRatioImage.new(0, 0, 226.5, 358.5, 0, 0, 22.5, 86.5)
	Secondary:linkToElementModel(self, "secondaryImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Secondary:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(Secondary)
	self.Secondary = Secondary
	local Perks = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	Perks:setLeftRight(0, 0, 31, 347)
	Perks:setTopBottom(0, 0, 206, 270)
	Perks:setWidgetType(CoD.AARClassRewardItemPreview)
	Perks:setHorizontalCount(4)
	Perks:setSpacing(20)
	Perks:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Perks:linkToElementModel(self, "perksDataSource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Perks:setDataSource(f4_local0)
		end
	end)
	self:addElement(Perks)
	self.Perks = Perks
	local Wildcards = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	Wildcards:setLeftRight(0, 0, 31, 347)
	Wildcards:setTopBottom(0, 0, 297.5, 361.5)
	Wildcards:setWidgetType(CoD.AARClassRewardItemPreview)
	Wildcards:setHorizontalCount(4)
	Wildcards:setSpacing(20)
	Wildcards:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Wildcards:linkToElementModel(self, "wildcardsDataSource", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Wildcards:setDataSource(f5_local0)
		end
	end)
	self:addElement(Wildcards)
	self.Wildcards = Wildcards
	local Grenade = CoD.AARRewardsEquipmentRow.new(f1_arg0, f1_arg1, 0, 0, 31, 181, 0, 0, 114, 178)
	Grenade:linkToElementModel(self, nil, false, function(model)
		Grenade:setModel(model, f1_arg1)
	end)
	self:addElement(Grenade)
	self.Grenade = Grenade
	local rewardTitle = LUI.UIText.new(0, 0, 17, 383, 0, 0, 383, 404)
	rewardTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	rewardTitle:setTTF("ttmussels_demibold")
	rewardTitle:setLetterSpacing(4)
	rewardTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rewardTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	rewardTitle:linkToElementModel(self, "reward1Title", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			rewardTitle:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	self:addElement(rewardTitle)
	self.rewardTitle = rewardTitle
	local rewardDesc = LUI.UIText.new(0, 0, 17, 383, 0, 0, 409, 427)
	rewardDesc:setRGB(0.75, 0.75, 0.75)
	rewardDesc:setTTF("ttmussels_regular")
	rewardDesc:setLetterSpacing(1)
	rewardDesc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rewardDesc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	rewardDesc:linkToElementModel(self, "reward1Desc", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			rewardDesc:setText(LocalizeToUpperString(f8_local0))
		end
	end)
	self:addElement(rewardDesc)
	self.rewardDesc = rewardDesc
	local Corner = CoD.AARRewardBrackets.new(f1_arg0, f1_arg1, 0, 0, -1, 381, 0, 0, -1, 440)
	Corner:setAlpha(0.4)
	self:addElement(Corner)
	self.Corner = Corner
	local Linker = LUI.UIImage.new(0, 0, 187, 189, 0, 0, 108.5, 458.5)
	Linker:setAlpha(0.18)
	Linker:setZRot(90)
	Linker:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker:setShaderVector(0, 0, 0, 0, 0)
	Linker:setupNineSliceShader(4, 8)
	self:addElement(Linker)
	self.Linker = Linker
	local Linker2 = LUI.UIImage.new(0, 0, 187, 189, 0, 0, 16.5, 366.5)
	Linker2:setAlpha(0.18)
	Linker2:setZRot(90)
	Linker2:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker2:setShaderVector(0, 0, 0, 0, 0)
	Linker2:setupNineSliceShader(4, 8)
	self:addElement(Linker2)
	self.Linker2 = Linker2
	local Linker3 = LUI.UIImage.new(0, 0, 187, 189, 0, 0, -80.5, 269.5)
	Linker3:setAlpha(0.18)
	Linker3:setZRot(90)
	Linker3:setImage(RegisterImage(0xC49B0C8991A541F))
	Linker3:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Linker3:setShaderVector(0, 0, 0, 0, 0)
	Linker3:setupNineSliceShader(4, 8)
	self:addElement(Linker3)
	self.Linker3 = Linker3
	Perks.id = "Perks"
	Wildcards.id = "Wildcards"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARClassRewardPreview.__onClose = function(f9_arg0)
	f9_arg0.Primary:close()
	f9_arg0.Secondary:close()
	f9_arg0.Perks:close()
	f9_arg0.Wildcards:close()
	f9_arg0.Grenade:close()
	f9_arg0.rewardTitle:close()
	f9_arg0.rewardDesc:close()
	f9_arg0.Corner:close()
end
