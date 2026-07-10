require("x64:f57501704c2ea0d")
require("x64:a9edd6e43be05c8")
require("x64:455a007bcf31cdf")
CoD.DeathCamPlayerKilledBy = InheritFrom(LUI.UIElement)
CoD.DeathCamPlayerKilledBy.__defaultWidth = 600
CoD.DeathCamPlayerKilledBy.__defaultHeight = 300
CoD.DeathCamPlayerKilledBy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DeathCamPlayerKilledBy)
	self.id = "DeathCamPlayerKilledBy"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpawnSelectBackground = LUI.UIImage.new(0.5, 0.5, -450, 450, 0.5, 0.5, -21, 109)
	SpawnSelectBackground:setAlpha(0)
	SpawnSelectBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	SpawnSelectBackground:setShaderVector(0, 0, 1, 0, 0)
	SpawnSelectBackground:setShaderVector(1, 0.8, 0.8, 0, 0)
	SpawnSelectBackground:setShaderVector(2, 0, 1, 0, 0)
	SpawnSelectBackground:setShaderVector(3, 0, 0, 0, 0)
	SpawnSelectBackground:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(SpawnSelectBackground)
	self.SpawnSelectBackground = SpawnSelectBackground
	local NewSpecialistFooter = CoD.NewSpecialistFooter.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.5, 0.5, -31, 119)
	NewSpecialistFooter:setAlpha(0)
	self:addElement(NewSpecialistFooter)
	self.NewSpecialistFooter = NewSpecialistFooter
	local KilledByHeader = CoD.KilledByHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.5, 0.5, -75, 75)
	self:addElement(KilledByHeader)
	self.KilledByHeader = KilledByHeader
	local PlayerCardKilledBy = CoD.PlayerCard_KilledBy.new(f1_arg0, f1_arg1, 0.5, 0.5, -231, 231, 0.5, 0.5, 16, 106)
	self:addElement(PlayerCardKilledBy)
	self.PlayerCardKilledBy = PlayerCardKilledBy
	self:mergeStateConditions({
		{
			stateName = "ShouldHidePlayerCard",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1) then
					f2_local0 = CoD.DeathCamUtility.InDeathCamShouldHidePlayerCard(f1_arg1)
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "SpecSwitchSpawnSelect",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1) and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.killedByMOD", Enum[0x52177B239BFECC1][0x6EF8543A25EF511])
			end,
		},
		{
			stateName = "NormalSpawnSelect",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.showSpawnSelect"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.killedByMOD"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.killedByMOD",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DeathCamPlayerKilledBy.__resetProperties = function(f7_arg0)
	f7_arg0.PlayerCardKilledBy:completeAnimation()
	f7_arg0.KilledByHeader:completeAnimation()
	f7_arg0.SpawnSelectBackground:completeAnimation()
	f7_arg0.NewSpecialistFooter:completeAnimation()
	f7_arg0.PlayerCardKilledBy:setAlpha(1)
	f7_arg0.KilledByHeader:setAlpha(1)
	f7_arg0.SpawnSelectBackground:setAlpha(0)
	f7_arg0.NewSpecialistFooter:setAlpha(0)
end
CoD.DeathCamPlayerKilledBy.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	ShouldHidePlayerCard = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.PlayerCardKilledBy:completeAnimation()
			f9_arg0.PlayerCardKilledBy:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PlayerCardKilledBy)
		end,
	},
	SpecSwitchSpawnSelect = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.SpawnSelectBackground:completeAnimation()
			f10_arg0.SpawnSelectBackground:setAlpha(0.15)
			f10_arg0.clipFinished(f10_arg0.SpawnSelectBackground)
			f10_arg0.NewSpecialistFooter:completeAnimation()
			f10_arg0.NewSpecialistFooter:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.NewSpecialistFooter)
			f10_arg0.KilledByHeader:completeAnimation()
			f10_arg0.KilledByHeader:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.KilledByHeader)
			f10_arg0.PlayerCardKilledBy:completeAnimation()
			f10_arg0.PlayerCardKilledBy:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PlayerCardKilledBy)
		end,
	},
	NormalSpawnSelect = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.SpawnSelectBackground:completeAnimation()
			f11_arg0.SpawnSelectBackground:setAlpha(0.15)
			f11_arg0.clipFinished(f11_arg0.SpawnSelectBackground)
		end,
	},
}
CoD.DeathCamPlayerKilledBy.__onClose = function(f12_arg0)
	f12_arg0.NewSpecialistFooter:close()
	f12_arg0.KilledByHeader:close()
	f12_arg0.PlayerCardKilledBy:close()
end
