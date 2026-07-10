require("x64:94dab3a4d2d79b2")
require("x64:497823eefd2b04b")
CoD.WZHorizontalCompass = InheritFrom(LUI.UIElement)
CoD.WZHorizontalCompass.__defaultWidth = 788
CoD.WZHorizontalCompass.__defaultHeight = 80
CoD.WZHorizontalCompass.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(true)
	self:setClass(CoD.WZHorizontalCompass)
	self.id = "WZHorizontalCompass"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = LUI.UIImage.new(0, 0, -76, 864, 0, 0, 27, 79)
	Backer:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_compass_backer"))
	Backer:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	Backer:setShaderVector(0, 0.45, 0.01, 0.45, 0.01)
	self:addElement(Backer)
	self.Backer = Backer
	local HorizontalCompassDirections = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	HorizontalCompassDirections:setLeftRight(0.5, 0.5, -1550, 1550)
	HorizontalCompassDirections:setTopBottom(0, 0, 47, 84)
	HorizontalCompassDirections:setWidgetType(CoD.WZCompassMinor)
	HorizontalCompassDirections:setHorizontalCount(50)
	HorizontalCompassDirections:setSpacing(0)
	HorizontalCompassDirections:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HorizontalCompassDirections:setDataSource("HorizontalCompassPips")
	self:addElement(HorizontalCompassDirections)
	self.HorizontalCompassDirections = HorizontalCompassDirections
	local Corner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 359, 429, 0, 0, -2, 32)
	Corner9Slice:setAlpha(0.75)
	self:addElement(Corner9Slice)
	self.Corner9Slice = Corner9Slice
	local Text = LUI.UIText.new(0, 0, 254, 534, 0, 0, 1, 31)
	Text:setTTF("0arame_mono_stencil")
	Text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Text:setShaderVector(0, 0.8, 0, 0, 0)
	Text:setShaderVector(1, 0, 0, 0, 0)
	Text:setShaderVector(2, 1, 1, 1, 0.35)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Text:subscribeToGlobalModel(f1_arg1, "HUDItems", "yaw", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Text:setText(CoD.BaseUtility.StringModulo(360, StringAdd(360, StringMultiply(-1, CoD.BaseUtility.RoundFraction(0, f2_local0)))))
		end
	end)
	self:addElement(Text)
	self.Text = Text
	local HorizontalCompassItems = LUI.UIImage.new(0, 1, 22, -22, 0, 0, 62, 108)
	HorizontalCompassItems:setRGB(0, 0, 0)
	HorizontalCompassItems:setAlpha(0.5)
	HorizontalCompassItems:setupHorizontalCompassItems(180)
	self:addElement(HorizontalCompassItems)
	self.HorizontalCompassItems = HorizontalCompassItems
	local HorizontalCompassItemsAdd = LUI.UIImage.new(0, 1, 22, -22, 0, 0, 62, 108)
	HorizontalCompassItemsAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	HorizontalCompassItemsAdd:setShaderVector(0, 1, 0, 0, 0)
	HorizontalCompassItemsAdd:setupHorizontalCompassItems(180)
	self:addElement(HorizontalCompassItemsAdd)
	self.HorizontalCompassItemsAdd = HorizontalCompassItemsAdd
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f3_local0
				if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]) and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
					f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					if f3_local0 then
					else
						return f3_local0
					end
				end
				f3_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
			end,
		},
		{
			stateName = "HiddenPC",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsPcInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideCompassUI", "warzoneHideCompass")
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f11_arg1)
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.isOpen, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "isOpen",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9.PlayerSettingsUpdate, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	HorizontalCompassDirections.id = "HorizontalCompassDirections"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZHorizontalCompass.__resetProperties = function(f15_arg0)
	f15_arg0.HorizontalCompassItemsAdd:completeAnimation()
	f15_arg0.HorizontalCompassItems:completeAnimation()
	f15_arg0.Text:completeAnimation()
	f15_arg0.Corner9Slice:completeAnimation()
	f15_arg0.HorizontalCompassDirections:completeAnimation()
	f15_arg0.Backer:completeAnimation()
	f15_arg0.HorizontalCompassItemsAdd:setAlpha(1)
	f15_arg0.HorizontalCompassItems:setAlpha(0.5)
	f15_arg0.Text:setAlpha(1)
	f15_arg0.Corner9Slice:setAlpha(0.75)
	f15_arg0.HorizontalCompassDirections:setAlpha(1)
	f15_arg0.Backer:setAlpha(1)
end
CoD.WZHorizontalCompass.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(6)
			f17_arg0.Backer:completeAnimation()
			f17_arg0.Backer:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Backer)
			f17_arg0.HorizontalCompassDirections:completeAnimation()
			f17_arg0.HorizontalCompassDirections:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.HorizontalCompassDirections)
			f17_arg0.Corner9Slice:completeAnimation()
			f17_arg0.Corner9Slice:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Corner9Slice)
			f17_arg0.Text:completeAnimation()
			f17_arg0.Text:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Text)
			f17_arg0.HorizontalCompassItems:completeAnimation()
			f17_arg0.HorizontalCompassItems:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.HorizontalCompassItems)
			f17_arg0.HorizontalCompassItemsAdd:completeAnimation()
			f17_arg0.HorizontalCompassItemsAdd:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.HorizontalCompassItemsAdd)
		end,
	},
	HiddenPC = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(6)
			f18_arg0.Backer:completeAnimation()
			f18_arg0.Backer:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Backer)
			f18_arg0.HorizontalCompassDirections:completeAnimation()
			f18_arg0.HorizontalCompassDirections:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.HorizontalCompassDirections)
			f18_arg0.Corner9Slice:completeAnimation()
			f18_arg0.Corner9Slice:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Corner9Slice)
			f18_arg0.Text:completeAnimation()
			f18_arg0.Text:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Text)
			f18_arg0.HorizontalCompassItems:completeAnimation()
			f18_arg0.HorizontalCompassItems:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.HorizontalCompassItems)
			f18_arg0.HorizontalCompassItemsAdd:completeAnimation()
			f18_arg0.HorizontalCompassItemsAdd:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.HorizontalCompassItemsAdd)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(6)
			f19_arg0.Backer:completeAnimation()
			f19_arg0.Backer:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Backer)
			f19_arg0.HorizontalCompassDirections:completeAnimation()
			f19_arg0.HorizontalCompassDirections:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.HorizontalCompassDirections)
			f19_arg0.Corner9Slice:completeAnimation()
			f19_arg0.Corner9Slice:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Corner9Slice)
			f19_arg0.Text:completeAnimation()
			f19_arg0.Text:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Text)
			f19_arg0.HorizontalCompassItems:completeAnimation()
			f19_arg0.HorizontalCompassItems:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.HorizontalCompassItems)
			f19_arg0.HorizontalCompassItemsAdd:completeAnimation()
			f19_arg0.HorizontalCompassItemsAdd:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.HorizontalCompassItemsAdd)
		end,
	},
}
CoD.WZHorizontalCompass.__onClose = function(f20_arg0)
	f20_arg0.HorizontalCompassDirections:close()
	f20_arg0.Corner9Slice:close()
	f20_arg0.Text:close()
end
