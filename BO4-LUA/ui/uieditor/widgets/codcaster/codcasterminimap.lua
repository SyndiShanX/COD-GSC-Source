require("x64:638d9c46e59e807")
require("x64:2c2bec7a9db1e9f")
CoD.CodCasterMiniMap = InheritFrom(LUI.UIElement)
CoD.CodCasterMiniMap.__defaultWidth = 841
CoD.CodCasterMiniMap.__defaultHeight = 400
CoD.CodCasterMiniMap.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.CodCasterMiniMap)
	self.id = "CodCasterMiniMap"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local minimapMap = LUI.UIImage.new(0.5, 0.5, -265, 335, 1, 1, -369, -31)
	minimapMap:setAlpha(0.8)
	minimapMap:setupCompassMap(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(minimapMap)
	self.minimapMap = minimapMap
	local minimapItems = LUI.UIImage.new(0.5, 0.5, -265.5, 334.5, 1, 1, -369, -31)
	minimapItems:setupCompassItems(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(minimapItems)
	self.minimapItems = minimapItems
	local minimapOverlay = LUI.UIImage.new(0.5, 0.5, -265.5, 334.5, 0.5, 0.5, -169, 169)
	minimapOverlay:setupCompassOverlay(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(minimapOverlay)
	self.minimapOverlay = minimapOverlay
	local CompassGroupContainer = CoD.CompassGroupMPContainerTransition.new(f1_arg0, f1_arg1, 0, 0, 203, 553, 0, 0, 0, 350)
	CompassGroupContainer:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f2_local0 = IsPC()
				if f2_local0 then
					if not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1) then
						f2_local0 = not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1) then
					f3_local0 = not CoD.CodCasterUtility.CodCasterIsInAerialCam(f1_arg1)
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	local f1_local5 = CompassGroupContainer
	local CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f4_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f5_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f6_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f7_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f8_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f9_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f11_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"]], function(f12_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_29BF57CE75A8755E"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f13_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f14_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"]], function(f15_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_scoped"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f16_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f17_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f18_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"]], function(f19_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_weapon_hud_visible"],
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["factions.isCoDCaster"], function(f20_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["hudItems.playerSpawned"], function(f21_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["hudItems.showSpawnSelect"], function(f22_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local5 = CompassGroupContainer
	CodCasterMiniMapName = CompassGroupContainer.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	CodCasterMiniMapName(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"]], function(f23_arg0)
		f1_arg0:updateElementState(CompassGroupContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_57EAF988DDEB83EA"],
		})
	end, false)
	CompassGroupContainer:setAlpha(0)
	self:addElement(CompassGroupContainer)
	self.CompassGroupContainer = CompassGroupContainer
	CodCasterMiniMapName = CoD.CodCasterMiniMapName.new(f1_arg0, f1_arg1, 0.2, 0.2, 0, 200, 0.1, 0.1, 0, 30)
	self:addElement(CodCasterMiniMapName)
	self.CodCasterMiniMapName = CodCasterMiniMapName
	self.__on_menuOpened_self = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
		local f24_local0 = self
		UpdateSelfElementState(f24_arg2, self.CompassGroupContainer, f24_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterMiniMap.__resetProperties = function(f26_arg0)
	f26_arg0.minimapItems:completeAnimation()
	f26_arg0.minimapMap:completeAnimation()
	f26_arg0.minimapOverlay:completeAnimation()
	f26_arg0.CodCasterMiniMapName:completeAnimation()
	f26_arg0.CompassGroupContainer:completeAnimation()
	f26_arg0.minimapItems:setAlpha(1)
	f26_arg0.minimapMap:setAlpha(0.8)
	f26_arg0.minimapOverlay:setAlpha(1)
	f26_arg0.CodCasterMiniMapName:setLeftRight(0.2, 0.2, 0, 200)
	f26_arg0.CodCasterMiniMapName:setAlpha(1)
	f26_arg0.CompassGroupContainer:setAlpha(0)
end
CoD.CodCasterMiniMap.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			f27_arg0.minimapMap:completeAnimation()
			f27_arg0.minimapMap:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.minimapMap)
			f27_arg0.minimapItems:completeAnimation()
			f27_arg0.minimapItems:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.minimapItems)
			f27_arg0.minimapOverlay:completeAnimation()
			f27_arg0.minimapOverlay:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.minimapOverlay)
			f27_arg0.CodCasterMiniMapName:completeAnimation()
			f27_arg0.CodCasterMiniMapName:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.CodCasterMiniMapName)
		end,
	},
	VisibleFull = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.CompassGroupContainer:completeAnimation()
			f28_arg0.CompassGroupContainer:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.CompassGroupContainer)
			f28_arg0.CodCasterMiniMapName:completeAnimation()
			f28_arg0.CodCasterMiniMapName:setLeftRight(0.22, 0.22, 0, 200)
			f28_arg0.clipFinished(f28_arg0.CodCasterMiniMapName)
		end,
	},
	VisibleStandard = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(5)
			f29_arg0.minimapMap:completeAnimation()
			f29_arg0.minimapMap:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.minimapMap)
			f29_arg0.minimapItems:completeAnimation()
			f29_arg0.minimapItems:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.minimapItems)
			f29_arg0.minimapOverlay:completeAnimation()
			f29_arg0.minimapOverlay:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.minimapOverlay)
			f29_arg0.CompassGroupContainer:completeAnimation()
			f29_arg0.CompassGroupContainer:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.CompassGroupContainer)
			f29_arg0.CodCasterMiniMapName:completeAnimation()
			f29_arg0.CodCasterMiniMapName:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.CodCasterMiniMapName)
		end,
	},
}
CoD.CodCasterMiniMap.__onClose = function(f30_arg0)
	f30_arg0.__on_close_removeOverrides()
	f30_arg0.CompassGroupContainer:close()
	f30_arg0.CodCasterMiniMapName:close()
end
