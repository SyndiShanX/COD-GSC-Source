CoD.multi_stage_friendly_lockon = InheritFrom(CoD.Menu)
LUI.createMenu.multi_stage_friendly_lockon = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("multi_stage_friendly_lockon", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.multi_stage_friendly_lockon)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Reticle = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40)
	Reticle:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	Reticle:setAlpha(0)
	Reticle:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_enemyindicator"))
	self:addElement(Reticle)
	self.Reticle = Reticle
	local LockOnReticle = LUI.UIImage.new(0, 0, -34, 66, 0, 0, -34, 66)
	LockOnReticle:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	LockOnReticle:setAlpha(0)
	LockOnReticle:setScale(0.75, 0.75)
	LockOnReticle:setImage(RegisterImage(@"uie_ui_hud_tak5_reticle_pointer"))
	self:addElement(LockOnReticle)
	self.LockOnReticle = LockOnReticle
	local LockOnReticleAdd = LUI.UIImage.new(0, 0, -34, 66, 0, 0, -34, 66)
	LockOnReticleAdd:setAlpha(0)
	LockOnReticleAdd:setZRot(135)
	LockOnReticleAdd:setScale(0.75, 0.75)
	LockOnReticleAdd:setImage(RegisterImage(@"uie_ui_hud_tak5_reticle_pointer"))
	LockOnReticleAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	LockOnReticleAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(LockOnReticleAdd)
	self.LockOnReticleAdd = LockOnReticleAdd
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "targetState", 0)
			end,
		},
		{
			stateName = "TargetIdentified",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "targetState", 1)
			end,
		},
		{
			stateName = "LockingOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "targetState", 2)
			end,
		},
		{
			stateName = "LockedOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "targetState", 3)
			end,
		},
		{
			stateName = "Tracking",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "targetState", 4)
			end,
		},
	})
	self:linkToElementModel(self, "targetState", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "targetState",
		})
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	local f1_local5 = self
	if IsPC() then
		CoD.HUDUtility.LinkSetupEntityContainerToModel(self, "entNum", false, false, 0, 0, 0)
		CoD.PCUtility.DisableKeyboardNavigationInMenu(f1_local1)
	else
		CoD.HUDUtility.LinkSetupEntityContainerToModel(self, "entNum", false, false, 0, 0, 0)
	end
	return self
end
CoD.multi_stage_friendly_lockon.__resetProperties = function(f8_arg0)
	f8_arg0.Reticle:completeAnimation()
	f8_arg0.LockOnReticle:completeAnimation()
	f8_arg0.LockOnReticleAdd:completeAnimation()
	f8_arg0.Reticle:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	f8_arg0.Reticle:setAlpha(0)
	f8_arg0.Reticle:setZRot(0)
	f8_arg0.Reticle:setScale(1, 1)
	f8_arg0.LockOnReticle:setAlpha(0)
	f8_arg0.LockOnReticle:setZRot(0)
	f8_arg0.LockOnReticle:setScale(0.75, 0.75)
	f8_arg0.LockOnReticleAdd:setAlpha(0)
	f8_arg0.LockOnReticleAdd:setZRot(135)
	f8_arg0.LockOnReticleAdd:setZoom(0)
	f8_arg0.LockOnReticleAdd:setScale(0.75, 0.75)
end
CoD.multi_stage_friendly_lockon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Reticle:completeAnimation()
			f10_arg0.Reticle:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Reticle)
		end,
	},
	TargetIdentified = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Reticle:completeAnimation()
			f11_arg0.Reticle:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Reticle)
		end,
	},
	LockingOn = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Reticle:beginAnimation(3000)
				f12_arg0.Reticle:setZRot(-360)
				f12_arg0.Reticle:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Reticle:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Reticle:completeAnimation()
			f12_arg0.Reticle:setAlpha(1)
			f12_arg0.Reticle:setZRot(0)
			f12_local0(f12_arg0.Reticle)
			f12_arg0.nextClip = "DefaultClip"
		end,
	},
	LockedOn = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.Reticle:completeAnimation()
			f14_arg0.Reticle:setRGB(0, 0.13, 1)
			f14_arg0.Reticle:setAlpha(0)
			f14_arg0.Reticle:setZRot(45)
			f14_arg0.clipFinished(f14_arg0.Reticle)
			local f14_local0 = function(f15_arg0)
				f14_arg0.LockOnReticle:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
				f14_arg0.LockOnReticle:setAlpha(1)
				f14_arg0.LockOnReticle:setZRot(0)
				f14_arg0.LockOnReticle:setScale(0.6, 0.6)
				f14_arg0.LockOnReticle:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.LockOnReticle:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.LockOnReticle:completeAnimation()
			f14_arg0.LockOnReticle:setAlpha(0)
			f14_arg0.LockOnReticle:setZRot(135)
			f14_arg0.LockOnReticle:setScale(0.85, 0.85)
			f14_local0(f14_arg0.LockOnReticle)
			local f14_local1 = function(f16_arg0)
				f14_arg0.LockOnReticleAdd:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
				f14_arg0.LockOnReticleAdd:setAlpha(0.15)
				f14_arg0.LockOnReticleAdd:setZRot(0)
				f14_arg0.LockOnReticleAdd:setZoom(0)
				f14_arg0.LockOnReticleAdd:setScale(0.6, 0.6)
				f14_arg0.LockOnReticleAdd:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.LockOnReticleAdd:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.LockOnReticleAdd:completeAnimation()
			f14_arg0.LockOnReticleAdd:setAlpha(0)
			f14_arg0.LockOnReticleAdd:setZRot(135)
			f14_arg0.LockOnReticleAdd:setZoom(10)
			f14_arg0.LockOnReticleAdd:setScale(0.85, 0.85)
			f14_local1(f14_arg0.LockOnReticleAdd)
		end,
	},
	Tracking = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.Reticle:completeAnimation()
			f17_arg0.Reticle:setAlpha(1)
			f17_arg0.Reticle:setZRot(45)
			f17_arg0.Reticle:setScale(0.25, 0.25)
			f17_arg0.clipFinished(f17_arg0.Reticle)
		end,
	},
}
CoD.multi_stage_friendly_lockon.__onClose = function(f18_arg0) end
