require("x64:b3bf131ef4361fc")
require("x64:c3f792f661c64a2")
require("x64:90c5cee147893f1")
CoD.Hud_WZ_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.Hud_WZ_SafeAreaContainer.__defaultWidth = 1920
CoD.Hud_WZ_SafeAreaContainer.__defaultHeight = 1080
CoD.Hud_WZ_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_WZ_SafeAreaContainer)
	self.id = "Hud_WZ_SafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Back = CoD.Hud_WZ_SafeAreaContainer_Back.new(f1_arg0, f1_arg1, 0, 0, -31, 1889, 0, 0, -1, 1079)
	Back:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(Back)
	self.Back = Back
	local WarzoneStreamHider = CoD.WarzoneStreamHider.new(f1_arg0, f1_arg1, -0.05, 1.05, 0, 0, -0.05, 1.05, 0, 0)
	WarzoneStreamHider:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(WarzoneStreamHider)
	self.WarzoneStreamHider = WarzoneStreamHider
	local Front = CoD.Hud_WZ_SafeAreaContainer_Front.new(f1_arg0, f1_arg1, 0, 0, -31, 1889, 0, 0, 0, 1080)
	Front:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg1)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(Front)
	self.Front = Front
	self:mergeStateConditions({
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerhud", 1)
			end,
		},
		{
			stateName = "HideForSpawnSelect",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["factions.isCoDCaster"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.profileSettingsUpdated, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.showSpawnSelect"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	Back.id = "Back"
	Front.id = "Front"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = Back
	if IsPC() then
		SizeToHudArea(f1_local5, f1_arg1)
	end
	f1_local5 = Front
	if IsPC() then
		SizeToHudArea(f1_local5, f1_arg1)
	end
	return self
end
CoD.Hud_WZ_SafeAreaContainer.__onClose = function(f10_arg0)
	f10_arg0.Back:close()
	f10_arg0.WarzoneStreamHider:close()
	f10_arg0.Front:close()
end
