require("x64:e95436bf279d160")
require("x64:7bfec74b48e738a")
require("x64:89269e9b52711e3")
CoD.vhud_hellstorm_internal = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_internal.__defaultWidth = 1920
CoD.vhud_hellstorm_internal.__defaultHeight = 1080
CoD.vhud_hellstorm_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_internal)
	self.id = "vhud_hellstorm_internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vhudhellstormreticle = CoD.vhud_hellstorm_reticle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudhellstormreticle:linkToElementModel(self, nil, false, function(model)
		vhudhellstormreticle:setModel(model, f1_arg1)
	end)
	self:addElement(vhudhellstormreticle)
	self.vhudhellstormreticle = vhudhellstormreticle
	local vhudhellstormProximityWarning = CoD.vhud_hellstorm_ProximityWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -171, 171, 0.5, 0.5, -266, -229)
	vhudhellstormProximityWarning:mergeStateConditions({
		{
			stateName = "ApproachingTarget",
			condition = function(menu, element, event)
				return IsCampaign() and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "vehicle.collisionWarning", 1)
			end,
		},
		{
			stateName = "TargetInRange",
			condition = function(menu, element, event)
				return IsCampaign() and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "vehicle.collisionWarning", 2)
			end,
		},
	})
	local f1_local3 = vhudhellstormProximityWarning
	local vhudhellstormbuttonlayout = vhudhellstormProximityWarning.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	vhudhellstormbuttonlayout(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(vhudhellstormProximityWarning, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local3 = vhudhellstormProximityWarning
	vhudhellstormbuttonlayout = vhudhellstormProximityWarning.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	vhudhellstormbuttonlayout(f1_local3, f1_local5["vehicle.collisionWarning"], function(f6_arg0)
		f1_arg0:updateElementState(vhudhellstormProximityWarning, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "vehicle.collisionWarning",
		})
	end, false)
	self:addElement(vhudhellstormProximityWarning)
	self.vhudhellstormProximityWarning = vhudhellstormProximityWarning
	vhudhellstormbuttonlayout = CoD.vhud_hellstorm_button_layout.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	vhudhellstormbuttonlayout:linkToElementModel(self, "bindings", false, function(model)
		vhudhellstormbuttonlayout:setModel(model, f1_arg1)
	end)
	self:addElement(vhudhellstormbuttonlayout)
	self.vhudhellstormbuttonlayout = vhudhellstormbuttonlayout
	self:mergeStateConditions({
		{
			stateName = "HiddenCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local5, f1_local6["factions.isCoDCaster"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = vhudhellstormbuttonlayout
	if IsPC() then
		SizeToHudArea(self.vhudhellstormbuttonlayout, f1_arg1)
	end
	return self
end
CoD.vhud_hellstorm_internal.__resetProperties = function(f10_arg0)
	f10_arg0.vhudhellstormbuttonlayout:completeAnimation()
	f10_arg0.vhudhellstormbuttonlayout:setAlpha(1)
end
CoD.vhud_hellstorm_internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenCodCaster = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.vhudhellstormbuttonlayout:completeAnimation()
			f12_arg0.vhudhellstormbuttonlayout:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.vhudhellstormbuttonlayout)
		end,
	},
}
CoD.vhud_hellstorm_internal.__onClose = function(f13_arg0)
	f13_arg0.vhudhellstormreticle:close()
	f13_arg0.vhudhellstormProximityWarning:close()
	f13_arg0.vhudhellstormbuttonlayout:close()
end
