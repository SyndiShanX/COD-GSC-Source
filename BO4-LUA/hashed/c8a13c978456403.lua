require("x64:6bffb9001264254")
require("x64:93a575a7ca17e04")
require("x64:8d675186365db0e")
require("x64:bf664385ad802d2")
require("x64:8ad2c5f2a781472")
require("x64:2824ac3e38d1e18")
require("x64:ee88ebccb2271bc")
CoD.WZTeamListItem = InheritFrom(LUI.UIElement)
CoD.WZTeamListItem.__defaultWidth = 385
CoD.WZTeamListItem.__defaultHeight = 50
CoD.WZTeamListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamListItem)
	self.id = "WZTeamListItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 0, 274, 0, 0, 1, 49)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backer = LUI.UIImage.new(0, 0, -4, 296, 0, 0, -1, 51)
	Backer:setRGB(0, 0, 0)
	Backer:setImage(RegisterImage(0x53750D521737D1B))
	self:addElement(Backer)
	self.Backer = Backer
	local ArmorBar = CoD.ArmorBarWZ.new(f1_arg0, f1_arg1, 0, 0, 43, 169, 0, 0, 26, 34)
	ArmorBar:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ArmorBar:linkToElementModel(ArmorBar, "armor", true, function(model)
		f1_arg0:updateElementState(ArmorBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "armor",
		})
	end)
	ArmorBar.Border:setAlpha(0)
	ArmorBar.Frame:setAlpha(0)
	ArmorBar:linkToElementModel(self, nil, false, function(model)
		ArmorBar:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorBar)
	self.ArmorBar = ArmorBar
	local HealthBar = CoD.HealthBar.new(f1_arg0, f1_arg1, 0, 0, 41, 169, 0, 0, 33, 50)
	HealthBar:setRGB(ColorSet.FriendlyHealthBar.r, ColorSet.FriendlyHealthBar.g, ColorSet.FriendlyHealthBar.b)
	HealthBar.Backer:setAlpha(0.01)
	HealthBar:linkToElementModel(self, "health", false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local BleedoutBar = CoD.WZBleedoutBar.new(f1_arg0, f1_arg1, 0, 0, 40.5, 168.5, 0, 0, 35, 49)
	BleedoutBar:setAlpha(0)
	self:addElement(BleedoutBar)
	self.BleedoutBar = BleedoutBar
	local StatusIcon = CoD.WZStatusIcon.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 0, 0, 4, 44)
	StatusIcon:setScale(0.8, 0.8)
	StatusIcon:linkToElementModel(self, nil, false, function(model)
		StatusIcon:setModel(model, f1_arg1)
	end)
	self:addElement(StatusIcon)
	self.StatusIcon = StatusIcon
	local PlayerInfoContainer = CoD.WZTeamListItemContainer.new(f1_arg0, f1_arg1, 0, 0, 39.5, 423.5, 0, 0, 1, 28)
	PlayerInfoContainer:linkToElementModel(self, nil, false, function(model)
		PlayerInfoContainer:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerInfoContainer)
	self.PlayerInfoContainer = PlayerInfoContainer
	local IsTarget = CoD.WZTeamPlayerIsTarget.new(f1_arg0, f1_arg1, 0, 0, 168, 198, 0, 0, 21, 51)
	IsTarget:setScale(0.85, 0.85)
	IsTarget:linkToElementModel(self, nil, false, function(model)
		IsTarget:setModel(model, f1_arg1)
	end)
	self:addElement(IsTarget)
	self.IsTarget = IsTarget
	local EMP = CoD.Warzone_EMP_Team.new(f1_arg0, f1_arg1, 0, 0, -21, 295, 0, 0, -19, 69)
	self:addElement(EMP)
	self.EMP = EMP
	self:mergeStateConditions({
		{
			stateName = "DeadDisconnected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue(element, f1_arg1, "inGamePlayerStatus", Enum[0x4A07561A78E340B][0xC233F1FA9F35C02], Enum[0x4A07561A78E340B][0x58F9A363F8FBB07])
			end,
		},
		{
			stateName = "LastStand",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "inGamePlayerStatus", Enum[0x4A07561A78E340B][0x9BD8FECA6158847])
			end,
		},
	})
	self:linkToElementModel(self, "inGamePlayerStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "inGamePlayerStatus",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.WZUtility.SetupLastStandBleedoutBar(f1_arg0, self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local10 = self
	CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
	return self
end
CoD.WZTeamListItem.__resetProperties = function(f13_arg0)
	f13_arg0.HealthBar:completeAnimation()
	f13_arg0.BleedoutBar:completeAnimation()
	f13_arg0.PlayerInfoContainer:completeAnimation()
	f13_arg0.HealthBar:setAlpha(1)
	f13_arg0.BleedoutBar:setAlpha(0)
	f13_arg0.PlayerInfoContainer:setAlpha(1)
end
CoD.WZTeamListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.HealthBar:completeAnimation()
			f14_arg0.HealthBar:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.HealthBar)
			f14_arg0.BleedoutBar:completeAnimation()
			f14_arg0.BleedoutBar:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BleedoutBar)
		end,
	},
	DeadDisconnected = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.HealthBar:completeAnimation()
			f15_arg0.HealthBar:setAlpha(0.02)
			f15_arg0.clipFinished(f15_arg0.HealthBar)
			f15_arg0.BleedoutBar:completeAnimation()
			f15_arg0.BleedoutBar:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.BleedoutBar)
			f15_arg0.PlayerInfoContainer:completeAnimation()
			f15_arg0.PlayerInfoContainer:setAlpha(0.35)
			f15_arg0.clipFinished(f15_arg0.PlayerInfoContainer)
		end,
	},
	LastStand = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.HealthBar:completeAnimation()
			f16_arg0.HealthBar:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.HealthBar)
			f16_arg0.BleedoutBar:completeAnimation()
			f16_arg0.BleedoutBar:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.BleedoutBar)
		end,
	},
}
CoD.WZTeamListItem.__onClose = function(f17_arg0)
	f17_arg0.ArmorBar:close()
	f17_arg0.HealthBar:close()
	f17_arg0.BleedoutBar:close()
	f17_arg0.StatusIcon:close()
	f17_arg0.PlayerInfoContainer:close()
	f17_arg0.IsTarget:close()
	f17_arg0.EMP:close()
end
