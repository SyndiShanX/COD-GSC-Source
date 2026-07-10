require("x64:e38f7efbca64ac5")
require("x64:7a5d726641c3e4")
CoD.vhud_hellstorm_WeaponModeWidget = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_WeaponModeWidget.__defaultWidth = 220
CoD.vhud_hellstorm_WeaponModeWidget.__defaultHeight = 276
CoD.vhud_hellstorm_WeaponModeWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_WeaponModeWidget)
	self.id = "vhud_hellstorm_WeaponModeWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Cluster = CoD.vhud_hellstorm_NotificationCluster.new(f1_arg0, f1_arg1, 0.5, 0.5, -110, 110, 1, 1, -248, -226)
	Cluster.Base:setAlpha(0.1)
	self:addElement(Cluster)
	self.Cluster = Cluster
	local LockOn = CoD.vhud_hellstorm_NotificationArmed.new(f1_arg0, f1_arg1, 0.5, 0.5, -110, 110, 1, 1, -276, -254)
	LockOn.Base:setAlpha(0.1)
	self:addElement(LockOn)
	self.LockOn = LockOn
	self:mergeStateConditions({
		{
			stateName = "DockLockOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.remoteMissilePhase2", 0)
			end,
		},
		{
			stateName = "DockLockOff",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.remoteMissilePhase2", 0)
			end,
		},
		{
			stateName = "BothOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rocketAmmo", 0)
			end,
		},
		{
			stateName = "ClusterOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rocketAmmo", 0)
			end,
		},
		{
			stateName = "LockOn",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.remoteMissilePhase2"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.remoteMissilePhase2",
		})
	end, false)
	self:linkToElementModel(self, "rocketAmmo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketAmmo",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	if IsPC() then
		SizeToHudArea(f1_local4, f1_arg1)
	end
	return self
end
CoD.vhud_hellstorm_WeaponModeWidget.__resetProperties = function(f9_arg0)
	f9_arg0.Cluster:completeAnimation()
	f9_arg0.LockOn:completeAnimation()
	f9_arg0.Cluster:setAlpha(1)
	f9_arg0.Cluster.Base:setRGB(1, 1, 1)
	f9_arg0.Cluster.Base:setAlpha(0.1)
	f9_arg0.Cluster.InnerGlow:setAlpha(0)
	f9_arg0.Cluster.Frame:setRGB(1, 1, 1)
	f9_arg0.Cluster.Frame:setAlpha(0)
	f9_arg0.Cluster.GlowBot:setAlpha(0)
	f9_arg0.Cluster.GlowTop:setAlpha(0)
	f9_arg0.LockOn:setAlpha(1)
	f9_arg0.LockOn.Base:setRGB(1, 1, 1)
	f9_arg0.LockOn.Base:setAlpha(0.1)
	f9_arg0.LockOn.InnerGlow:setAlpha(0)
	f9_arg0.LockOn.Frame:setRGB(1, 1, 1)
	f9_arg0.LockOn.Frame:setAlpha(0)
	f9_arg0.LockOn.GlowBot:setAlpha(0)
	f9_arg0.LockOn.GlowTop:setAlpha(0)
end
CoD.vhud_hellstorm_WeaponModeWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	DockLockOn = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Cluster:completeAnimation()
			f11_arg0.Cluster:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Cluster)
			f11_arg0.LockOn:completeAnimation()
			f11_arg0.LockOn.Base:completeAnimation()
			f11_arg0.LockOn.InnerGlow:completeAnimation()
			f11_arg0.LockOn.Frame:completeAnimation()
			f11_arg0.LockOn.GlowBot:completeAnimation()
			f11_arg0.LockOn.GlowTop:completeAnimation()
			f11_arg0.LockOn:setAlpha(1)
			f11_arg0.LockOn.Base:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f11_arg0.LockOn.Base:setAlpha(0.3)
			f11_arg0.LockOn.InnerGlow:setAlpha(1)
			f11_arg0.LockOn.Frame:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f11_arg0.LockOn.Frame:setAlpha(0)
			f11_arg0.LockOn.GlowBot:setAlpha(1)
			f11_arg0.LockOn.GlowTop:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.LockOn)
		end,
	},
	DockLockOff = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.Cluster:completeAnimation()
			f12_arg0.Cluster:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Cluster)
			f12_arg0.LockOn:completeAnimation()
			f12_arg0.LockOn:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.LockOn)
		end,
	},
	BothOn = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.Cluster:completeAnimation()
			f13_arg0.Cluster.Base:completeAnimation()
			f13_arg0.Cluster.InnerGlow:completeAnimation()
			f13_arg0.Cluster.Frame:completeAnimation()
			f13_arg0.Cluster.GlowBot:completeAnimation()
			f13_arg0.Cluster.GlowTop:completeAnimation()
			f13_arg0.Cluster.Base:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f13_arg0.Cluster.Base:setAlpha(0.3)
			f13_arg0.Cluster.InnerGlow:setAlpha(1)
			f13_arg0.Cluster.Frame:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f13_arg0.Cluster.GlowBot:setAlpha(1)
			f13_arg0.Cluster.GlowTop:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Cluster)
			f13_arg0.LockOn:completeAnimation()
			f13_arg0.LockOn.Base:completeAnimation()
			f13_arg0.LockOn.InnerGlow:completeAnimation()
			f13_arg0.LockOn.Frame:completeAnimation()
			f13_arg0.LockOn.GlowBot:completeAnimation()
			f13_arg0.LockOn.GlowTop:completeAnimation()
			f13_arg0.LockOn.Base:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f13_arg0.LockOn.Base:setAlpha(0.3)
			f13_arg0.LockOn.InnerGlow:setAlpha(1)
			f13_arg0.LockOn.Frame:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f13_arg0.LockOn.GlowBot:setAlpha(1)
			f13_arg0.LockOn.GlowTop:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.LockOn)
		end,
	},
	ClusterOn = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Cluster:completeAnimation()
			f14_arg0.Cluster.Base:completeAnimation()
			f14_arg0.Cluster.InnerGlow:completeAnimation()
			f14_arg0.Cluster.Frame:completeAnimation()
			f14_arg0.Cluster.GlowBot:completeAnimation()
			f14_arg0.Cluster.GlowTop:completeAnimation()
			f14_arg0.Cluster.Base:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f14_arg0.Cluster.Base:setAlpha(0.3)
			f14_arg0.Cluster.InnerGlow:setAlpha(1)
			f14_arg0.Cluster.Frame:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f14_arg0.Cluster.Frame:setAlpha(0)
			f14_arg0.Cluster.GlowBot:setAlpha(1)
			f14_arg0.Cluster.GlowTop:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.Cluster)
			f14_arg0.nextClip = "DefaultClip"
		end,
	},
	LockOn = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.Cluster:completeAnimation()
			f15_arg0.Cluster.Base:completeAnimation()
			f15_arg0.Cluster.Frame:completeAnimation()
			f15_arg0.Cluster.Base:setRGB(1, 1, 1)
			f15_arg0.Cluster.Frame:setRGB(1, 1, 1)
			f15_arg0.clipFinished(f15_arg0.Cluster)
			f15_arg0.LockOn:completeAnimation()
			f15_arg0.LockOn.Base:completeAnimation()
			f15_arg0.LockOn.InnerGlow:completeAnimation()
			f15_arg0.LockOn.Frame:completeAnimation()
			f15_arg0.LockOn.GlowBot:completeAnimation()
			f15_arg0.LockOn.GlowTop:completeAnimation()
			f15_arg0.LockOn.Base:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f15_arg0.LockOn.Base:setAlpha(0.3)
			f15_arg0.LockOn.InnerGlow:setAlpha(1)
			f15_arg0.LockOn.Frame:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f15_arg0.LockOn.GlowBot:setAlpha(1)
			f15_arg0.LockOn.GlowTop:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.LockOn)
		end,
	},
}
CoD.vhud_hellstorm_WeaponModeWidget.__onClose = function(f16_arg0)
	f16_arg0.Cluster:close()
	f16_arg0.LockOn:close()
end
