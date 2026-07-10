require("x64:22e9d2bd1a9e86a")
require("x64:8575142f3bda12c")
CoD.VHUD_HCXD = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_HCXD = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_HCXD", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_HCXD)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local vignette = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	vignette:setAlpha(0)
	vignette:setImage(RegisterImage(@"uie_t7_hcxd_vignette_score_streak"))
	self:addElement(vignette)
	self.vignette = vignette
	local vignetteCenter = LUI.UIImage.new(0, 1, -304, 304, 0, 1, -177, 165)
	vignetteCenter:setAlpha(0)
	vignetteCenter:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_backgroundtint"))
	self:addElement(vignetteCenter)
	self.vignetteCenter = vignetteCenter
	local hudspeedometerwidget = CoD.hud_speedometer_widget.new(f1_local1, f1_arg0, 0.5, 0.5, -785, -533, 1, 1, -305.5, -173.5)
	hudspeedometerwidget:setAlpha(0)
	self:addElement(hudspeedometerwidget)
	self.hudspeedometerwidget = hudspeedometerwidget
	local vhudhcdxhud = CoD.vhud_hcdx_hud.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	vhudhcdxhud:linkToElementModel(self, nil, false, function(model)
		vhudhcdxhud:setModel(model, f1_arg0)
	end)
	self:addElement(vhudhcdxhud)
	self.vhudhcdxhud = vhudhcdxhud
	self:mergeStateConditions({
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg0)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		f1_local1:updateElementState(self, f4_arg1)
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local7(f1_local6, f1_local8.LastInput, function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f6_local0 = nil
		if self.menuLoaded then
			f6_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f6_local0 = self.super:menuLoaded(event)
		end
		SizeToSafeArea(self, f1_arg0)
		if not f6_local0 then
			f6_local0 = self:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	f1_local7 = self
	if IsPC() then
		SizeToHudArea(self.vhudhcdxhud, f1_arg0)
	elseif IsSplitscreenAndInGame(f1_arg0) then
		SizeToSafeArea(self.vhudhcdxhud, f1_arg0)
	end
	return self
end
CoD.VHUD_HCXD.__onClose = function(f7_arg0)
	f7_arg0.hudspeedometerwidget:close()
	f7_arg0.vhudhcdxhud:close()
end
