require("x64:6d1324c9b04dea0")
CoD.remote_missile_target_lockon = InheritFrom(CoD.Menu)
LUI.createMenu.remote_missile_target_lockon = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("remote_missile_target_lockon", f1_arg0)
	local f1_local1 = self
	CoD.HUDUtility.InitLuiElemSelfModel(self, "lockonScale", 1)
	CoD.HUDUtility.InitLuiElemSelfModel(self, "lockonObscured", 0)
	self:setClass(CoD.remote_missile_target_lockon)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local LockonInternal = CoD.remoteMissileTargetLockonInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -64, 64, 0.5, 0.5, -64, 64)
	LockonInternal:linkToElementModel(self, nil, false, function(model)
		LockonInternal:setModel(model, f1_arg0)
	end)
	self:addElement(LockonInternal)
	self.LockonInternal = LockonInternal
	self:mergeStateConditions({
		{
			stateName = "Obscurred",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg0, "lockonObscured", 0)
			end,
		},
	})
	self:linkToElementModel(self, "lockonObscured", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "lockonObscured",
		})
	end)
	self:linkToElementModel(self, "lockonScale", true, function(model)
		local f5_local0 = self
		CoD.HUDUtility.SetRemoteMissileLockonScale(self.LockonInternal, model)
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	local f1_local3 = self
	if IsPC() then
		CoD.HUDUtility.LinkSetupEntityContainerToModel(self, "clientnum", false, false, 0, 0, 0)
		CoD.PCUtility.DisableKeyboardNavigationInMenu(f1_local1)
	else
		CoD.HUDUtility.LinkSetupEntityContainerToModel(self, "clientnum", false, false, 0, 0, 0)
	end
	return self
end
CoD.remote_missile_target_lockon.__resetProperties = function(f6_arg0)
	f6_arg0.LockonInternal:completeAnimation()
	f6_arg0.LockonInternal:setAlpha(1)
end
CoD.remote_missile_target_lockon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		Obscurred = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.LockonInternal:beginAnimation(150)
				f8_arg0.LockonInternal:setAlpha(0.5)
				f8_arg0.LockonInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.LockonInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.LockonInternal:completeAnimation()
			f8_arg0.LockonInternal:setAlpha(1)
			f8_local0(f8_arg0.LockonInternal)
		end,
	},
	Obscurred = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.LockonInternal:completeAnimation()
			f10_arg0.LockonInternal:setAlpha(0.5)
			f10_arg0.clipFinished(f10_arg0.LockonInternal)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.LockonInternal:beginAnimation(150)
				f11_arg0.LockonInternal:setAlpha(1)
				f11_arg0.LockonInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LockonInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.LockonInternal:completeAnimation()
			f11_arg0.LockonInternal:setAlpha(0.5)
			f11_local0(f11_arg0.LockonInternal)
		end,
	},
}
CoD.remote_missile_target_lockon.__onClose = function(f13_arg0)
	f13_arg0.LockonInternal:close()
end
