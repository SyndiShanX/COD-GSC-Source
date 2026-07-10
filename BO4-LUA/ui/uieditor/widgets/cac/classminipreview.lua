require("x64:86addcd8b941876")
require("x64:b850fac3ef8b863")
require("x64:14da682871bc56e")
require("x64:6dfdc4f59440b7c")
CoD.ClassMiniPreview = InheritFrom(LUI.UIElement)
CoD.ClassMiniPreview.__defaultWidth = 1400
CoD.ClassMiniPreview.__defaultHeight = 80
CoD.ClassMiniPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ClassMiniPreview)
	self.id = "ClassMiniPreview"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local inventoryline4 = LUI.UIImage.new(0.5, 0.5, -542, -538, 1, 1, -64, -16)
	inventoryline4:setAlpha(0.1)
	inventoryline4:setImage(RegisterImage(0x40E8461C131060A))
	self:addElement(inventoryline4)
	self.inventoryline4 = inventoryline4
	local Primary = CoD.ClassMiniPreviewWeaponItem.new(f1_arg0, f1_arg1, 0, 0, 162, 402, 0.5, 0.5, -35, 35)
	Primary:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
	})
	Primary:linkToElementModel(Primary, "itemIndex", true, function(model)
		f1_arg0:updateElementState(Primary, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	Primary:linkToElementModel(self, "primary", false, function(model)
		Primary:setModel(model, f1_arg1)
	end)
	Primary:linkToElementModel(self, "primaryattachments", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Primary.PrimaryAttachments:setDataSource(f5_local0)
		end
	end)
	self:addElement(Primary)
	self.Primary = Primary
	local inventoryline6 = LUI.UIImage.new(0.5, 0.5, -298, -294, 1, 1, -64, -16)
	inventoryline6:setAlpha(0.1)
	inventoryline6:setImage(RegisterImage(0x40E8461C131060A))
	self:addElement(inventoryline6)
	self.inventoryline6 = inventoryline6
	local Secondary = CoD.ClassMiniPreviewWeaponItem.new(f1_arg0, f1_arg1, 0, 0, 406, 646, 0.5, 0.5, -35, 35)
	Secondary:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
	})
	Secondary:linkToElementModel(Secondary, "itemIndex", true, function(model)
		f1_arg0:updateElementState(Secondary, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	Secondary:linkToElementModel(self, "secondary", false, function(model)
		Secondary:setModel(model, f1_arg1)
	end)
	Secondary:linkToElementModel(self, "secondaryattachments", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Secondary.PrimaryAttachments:setDataSource(f9_local0)
		end
	end)
	self:addElement(Secondary)
	self.Secondary = Secondary
	local inventoryline7 = LUI.UIImage.new(0.5, 0.5, -54, -50, 1, 1, -64, -16)
	inventoryline7:setAlpha(0.1)
	inventoryline7:setImage(RegisterImage(0x40E8461C131060A))
	self:addElement(inventoryline7)
	self.inventoryline7 = inventoryline7
	local Gear = CoD.ClassMiniPreviewGearItem.new(f1_arg0, f1_arg1, 0, 0, 650, 730, 0.5, 0.5, -35, 35)
	Gear:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
	})
	Gear:linkToElementModel(Gear, "itemIndex", true, function(model)
		f1_arg0:updateElementState(Gear, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	Gear:linkToElementModel(self, "tacticalgear", false, function(model)
		Gear:setModel(model, f1_arg1)
	end)
	self:addElement(Gear)
	self.Gear = Gear
	local inventoryline5 = LUI.UIImage.new(0.5, 0.5, 30, 34, 1, 1, -64, -16)
	inventoryline5:setAlpha(0.1)
	inventoryline5:setImage(RegisterImage(0x40E8461C131060A))
	self:addElement(inventoryline5)
	self.inventoryline5 = inventoryline5
	local Equipment = CoD.ClassMiniPreviewEquipmentItem.new(f1_arg0, f1_arg1, 0, 0, 734, 814, 0, 0, 5, 75)
	Equipment:mergeStateConditions({
		{
			stateName = "Unavailable_Dual",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "canTakeTwo") and CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "primarygrenade.itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
		{
			stateName = "UnavailableSingle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "primarygrenade.itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
		{
			stateName = "TakeTwo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "canTakeTwo")
			end,
		},
	})
	Equipment:linkToElementModel(Equipment, "canTakeTwo", true, function(model)
		f1_arg0:updateElementState(Equipment, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "canTakeTwo",
		})
	end)
	Equipment:linkToElementModel(Equipment, "primarygrenade.itemIndex", true, function(model)
		f1_arg0:updateElementState(Equipment, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "primarygrenade.itemIndex",
		})
	end)
	Equipment:linkToElementModel(self, nil, false, function(model)
		Equipment:setModel(model, f1_arg1)
	end)
	self:addElement(Equipment)
	self.Equipment = Equipment
	local inventoryline2 = LUI.UIImage.new(0.5, 0.5, 114, 118, 1, 1, -64, -16)
	inventoryline2:setAlpha(0.1)
	inventoryline2:setImage(RegisterImage(0x40E8461C131060A))
	self:addElement(inventoryline2)
	self.inventoryline2 = inventoryline2
	local Talents = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	Talents:setLeftRight(0, 0, 818, 1238)
	Talents:setTopBottom(0.5, 0.5, -35, 35)
	Talents:setWidgetType(CoD.ClassMiniPreviewTalentItem)
	Talents:setHorizontalCount(6)
	Talents:setSpacing(0)
	Talents:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Talents:linkToElementModel(self, "talentsMiniPreview", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			Talents:setDataSource(f19_local0)
		end
	end)
	self:addElement(Talents)
	self.Talents = Talents
	local inventoryline3 = LUI.UIImage.new(0.5, 0.5, 538, 542, 1, 1, -64, -16)
	inventoryline3:setAlpha(0.1)
	inventoryline3:setImage(RegisterImage(0x40E8461C131060A))
	self:addElement(inventoryline3)
	self.inventoryline3 = inventoryline3
	Primary.id = "Primary"
	Secondary.id = "Secondary"
	Talents.id = "Talents"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local12 = self
	SetElementProperty(Talents, "_ignoreEmptyPerks", true)
	return self
end
CoD.ClassMiniPreview.__onClose = function(f20_arg0)
	f20_arg0.Primary:close()
	f20_arg0.Secondary:close()
	f20_arg0.Gear:close()
	f20_arg0.Equipment:close()
	f20_arg0.Talents:close()
end
