require("x64:c4a8b36078c59aa")
require("x64:6180207311bd274")
require("x64:719aa631150ffd4")
require("x64:1801e1cb1abba2")
require("x64:5c396528ce30caa")
require("x64:225dbf4685ca8f6")
CoD.TabletTak5 = InheritFrom(LUI.UIElement)
CoD.TabletTak5.__defaultWidth = 500
CoD.TabletTak5.__defaultHeight = 500
CoD.TabletTak5.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletTak5)
	self.id = "TabletTak5"
	self.soundSet = "none"
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 3, 500, 500)
	self:setUI3DWindow(3)
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0.5, 0.5, -250, 250, 0.5, 0.5, -140, 140)
	background:setRGB(0, 0, 0)
	background:setAlpha(0.75)
	self:addElement(background)
	self.background = background
	local GridBackground = LUI.UIImage.new(0, 0, -30, 530, 0, 0, 108, 392)
	GridBackground:setImage(RegisterImage(0xA01874D41AD67C))
	GridBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GridBackground:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GridBackground)
	self.GridBackground = GridBackground
	local GridPlusGrid = CoD.TabletTak5Grid.new(f1_arg0, f1_arg1, 0, 0, 146, 355, 0, 0, 194, 304)
	self:addElement(GridPlusGrid)
	self.GridPlusGrid = GridPlusGrid
	local SelfPlayerInfo = CoD.TabletTak5_PlayerInfo.new(f1_arg0, f1_arg1, 0, 0, 8, 132, 0.5, 0.5, -123, 107)
	SelfPlayerInfo:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "MaxedOut",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoTarget",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	SelfPlayerInfo:setScale(0.9, 0.9)
	SelfPlayerInfo:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			SelfPlayerInfo:setModel(f5_local0, f1_arg1)
		end
	end)
	self:addElement(SelfPlayerInfo)
	self.SelfPlayerInfo = SelfPlayerInfo
	local TargetPlayerInfo = CoD.TabletTak5_PlayerInfo.new(f1_arg0, f1_arg1, 1, 1, -132, -8, 0.5, 0.5, -123, 107)
	TargetPlayerInfo:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local AmmoPip1 = TargetPlayerInfo
	local ConnectionText = TargetPlayerInfo.subscribeToModel
	local AmmoPip2 = DataSources.TeammateHealTargeting.getModel(f1_arg1)
	ConnectionText(AmmoPip1, AmmoPip2.status, function(f7_arg0)
		f1_arg0:updateElementState(TargetPlayerInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "status",
		})
	end, false)
	AmmoPip1 = TargetPlayerInfo
	ConnectionText = TargetPlayerInfo.subscribeToModel
	AmmoPip2 = DataSources.TeammateHealTargeting.getModel(f1_arg1)
	ConnectionText(AmmoPip1, AmmoPip2.targetClientNum, function(f8_arg0)
		f1_arg0:updateElementState(TargetPlayerInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "targetClientNum",
		})
	end, false)
	TargetPlayerInfo:setScale(0.9, 0.9)
	TargetPlayerInfo:subscribeToGlobalModel(f1_arg1, "TeammateHealTargeting", "targetClient", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			TargetPlayerInfo:setModel(f9_local0, f1_arg1)
		end
	end)
	self:addElement(TargetPlayerInfo)
	self.TargetPlayerInfo = TargetPlayerInfo
	ConnectionText = CoD.TabletTak5_ConnectionText.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0, 0, 122, 152)
	self:addElement(ConnectionText)
	self.ConnectionText = ConnectionText
	AmmoPip1 = CoD.TabletTak5_AmmoPip.new(f1_arg0, f1_arg1, 0, 0, 304.5, 344.5, 0, 0, 152, 232)
	AmmoPip1:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "ammoInClip", 4)
			end,
		},
	})
	local AmmoPip3 = AmmoPip1
	AmmoPip2 = AmmoPip1.subscribeToModel
	local AmmoPip4 = DataSources.CurrentWeapon.getModel(f1_arg1)
	AmmoPip2(AmmoPip3, AmmoPip4.ammoInClip, function(f11_arg0)
		f1_arg0:updateElementState(AmmoPip1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "ammoInClip",
		})
	end, false)
	self:addElement(AmmoPip1)
	self.AmmoPip1 = AmmoPip1
	AmmoPip2 = CoD.TabletTak5_AmmoPip.new(f1_arg0, f1_arg1, 0, 0, 255, 295, 0, 0, 152, 232)
	AmmoPip2:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "ammoInClip", 3)
			end,
		},
	})
	AmmoPip4 = AmmoPip2
	AmmoPip3 = AmmoPip2.subscribeToModel
	local AmmoPipBonus = DataSources.CurrentWeapon.getModel(f1_arg1)
	AmmoPip3(AmmoPip4, AmmoPipBonus.ammoInClip, function(f13_arg0)
		f1_arg0:updateElementState(AmmoPip2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "ammoInClip",
		})
	end, false)
	self:addElement(AmmoPip2)
	self.AmmoPip2 = AmmoPip2
	AmmoPip3 = CoD.TabletTak5_AmmoPip.new(f1_arg0, f1_arg1, 0, 0, 203, 243, 0, 0, 152, 232)
	AmmoPip3:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "ammoInClip", 2)
			end,
		},
	})
	AmmoPipBonus = AmmoPip3
	AmmoPip4 = AmmoPip3.subscribeToModel
	local takNumber01 = DataSources.CurrentWeapon.getModel(f1_arg1)
	AmmoPip4(AmmoPipBonus, takNumber01.ammoInClip, function(f15_arg0)
		f1_arg0:updateElementState(AmmoPip3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "ammoInClip",
		})
	end, false)
	self:addElement(AmmoPip3)
	self.AmmoPip3 = AmmoPip3
	AmmoPip4 = CoD.TabletTak5_AmmoPip.new(f1_arg0, f1_arg1, 0, 0, 153, 193, 0, 0, 152, 232)
	AmmoPip4:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "ammoInClip", 1)
			end,
		},
	})
	takNumber01 = AmmoPip4
	AmmoPipBonus = AmmoPip4.subscribeToModel
	local takNumber02 = DataSources.CurrentWeapon.getModel(f1_arg1)
	AmmoPipBonus(takNumber01, takNumber02.ammoInClip, function(f17_arg0)
		f1_arg0:updateElementState(AmmoPip4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "ammoInClip",
		})
	end, false)
	self:addElement(AmmoPip4)
	self.AmmoPip4 = AmmoPip4
	AmmoPipBonus = CoD.TabletTak5_AmmoPip.new(f1_arg0, f1_arg1, 0, 0, 153, 193, 0, 0, 237.5, 317.5)
	AmmoPipBonus:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "ammoInClip", 1)
			end,
		},
	})
	takNumber02 = AmmoPipBonus
	takNumber01 = AmmoPipBonus.subscribeToModel
	local takNumber03 = DataSources.CurrentWeapon.getModel(f1_arg1)
	takNumber01(takNumber02, takNumber03.ammoInClip, function(f19_arg0)
		f1_arg0:updateElementState(AmmoPipBonus, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "ammoInClip",
		})
	end, false)
	AmmoPipBonus:setZRot(180)
	self:addElement(AmmoPipBonus)
	self.AmmoPipBonus = AmmoPipBonus
	takNumber01 = LUI.UIText.new(0, 0, 309, 340, 0, 0, 216.5, 224.5)
	takNumber01:setText(1)
	takNumber01:setTTF("ttmussels_demibold")
	takNumber01:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	takNumber01:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(takNumber01)
	self.takNumber01 = takNumber01
	takNumber02 = LUI.UIText.new(0, 0, 258.5, 289.5, 0, 0, 216.5, 224.5)
	takNumber02:setText(2)
	takNumber02:setTTF("ttmussels_demibold")
	takNumber02:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	takNumber02:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(takNumber02)
	self.takNumber02 = takNumber02
	takNumber03 = LUI.UIText.new(0, 0, 207.5, 238.5, 0, 0, 216.5, 224.5)
	takNumber03:setText(3)
	takNumber03:setTTF("ttmussels_demibold")
	takNumber03:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	takNumber03:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(takNumber03)
	self.takNumber03 = takNumber03
	local takNumber04 = LUI.UIText.new(0, 0, 157.5, 188.5, 0, 0, 216.5, 224.5)
	takNumber04:setText(4)
	takNumber04:setTTF("ttmussels_demibold")
	takNumber04:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	takNumber04:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(takNumber04)
	self.takNumber04 = takNumber04
	local takNumber05 = LUI.UIText.new(0, 0, 157.5, 188.5, 0, 0, 245, 253)
	takNumber05:setText(5)
	takNumber05:setTTF("ttmussels_demibold")
	takNumber05:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	takNumber05:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(takNumber05)
	self.takNumber05 = takNumber05
	local HealthBonus = CoD.TabletTak5_HealthBonus.new(f1_arg0, f1_arg1, 0, 0, 150, 200, 0, 0, 335, 375)
	self:addElement(HealthBonus)
	self.HealthBonus = HealthBonus
	local BorderTop = LUI.UIImage.new(0, 0, 0, 500, 0, 0, 0, 110)
	BorderTop:setRGB(0, 0, 0)
	self:addElement(BorderTop)
	self.BorderTop = BorderTop
	local BorderBottom = LUI.UIImage.new(0, 0, 0, 500, 1, 1, -110, 0)
	BorderBottom:setRGB(0, 0, 0)
	self:addElement(BorderBottom)
	self.BorderBottom = BorderBottom
	local Tak5Version = LUI.UIImage.new(0, 0, 246, 350, 0, 0, 242, 264)
	Tak5Version:setAlpha(0.25)
	Tak5Version:setImage(RegisterImage(0xD5E0EBBEF0B319F))
	Tak5Version:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Tak5Version:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Tak5Version)
	self.Tak5Version = Tak5Version
	local tak5LinkAll = CoD.TabletTak5_LinkAll.new(f1_arg0, f1_arg1, 0, 0, 119.5, 382.5, 0, 0, 176, 371)
	self:addElement(tak5LinkAll)
	self.tak5LinkAll = tak5LinkAll
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletTak5.__resetProperties = function(f20_arg0)
	f20_arg0.BorderTop:completeAnimation()
	f20_arg0.BorderBottom:completeAnimation()
	f20_arg0.GridBackground:completeAnimation()
	f20_arg0.BorderTop:setAlpha(1)
	f20_arg0.BorderBottom:setAlpha(1)
	f20_arg0.GridBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f20_arg0.GridBackground:setShaderVector(0, 2, 0, 0, 0)
end
CoD.TabletTak5.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.GridBackground:completeAnimation()
			f21_arg0.GridBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f21_arg0.GridBackground:setShaderVector(0, 2.2, 0, 0, 0)
			f21_arg0.clipFinished(f21_arg0.GridBackground)
			f21_arg0.BorderTop:completeAnimation()
			f21_arg0.BorderTop:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.BorderTop)
			f21_arg0.BorderBottom:completeAnimation()
			f21_arg0.BorderBottom:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.BorderBottom)
		end,
	},
}
CoD.TabletTak5.__onClose = function(f22_arg0)
	f22_arg0.GridPlusGrid:close()
	f22_arg0.SelfPlayerInfo:close()
	f22_arg0.TargetPlayerInfo:close()
	f22_arg0.ConnectionText:close()
	f22_arg0.AmmoPip1:close()
	f22_arg0.AmmoPip2:close()
	f22_arg0.AmmoPip3:close()
	f22_arg0.AmmoPip4:close()
	f22_arg0.AmmoPipBonus:close()
	f22_arg0.HealthBonus:close()
	f22_arg0.tak5LinkAll:close()
end
