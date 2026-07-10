require("x64:93a575a7ca17e04")
require("x64:eece2ec012779d1")
require("x64:8b34a2b55d6ff87")
CoD.OverheadName_WZ = InheritFrom(LUI.UIElement)
CoD.OverheadName_WZ.__defaultWidth = 200
CoD.OverheadName_WZ.__defaultHeight = 30
CoD.OverheadName_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OverheadName_WZ)
	self.id = "OverheadName_WZ"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NameAndNumber = CoD.OverheadName_WZ_NameAndNumber.new(f1_arg0, f1_arg1, 0.5, 0.5, -82, 82, 0, 0, -3, 30)
	NameAndNumber:mergeStateConditions({
		{
			stateName = "HideNumber",
			condition = function(menu, element, event)
				local f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
				if not f2_local0 then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
					if not f2_local0 then
						f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
					end
				end
				return f2_local0
			end,
		},
	})
	local WaypointBacker = NameAndNumber
	local HealthBar = NameAndNumber.subscribeToModel
	local WaypointPattern = Engine[@"getmodelforcontroller"](f1_arg1)
	HealthBar(WaypointBacker, WaypointPattern["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f3_arg0)
		f1_arg0:updateElementState(NameAndNumber, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	WaypointBacker = NameAndNumber
	HealthBar = NameAndNumber.subscribeToModel
	WaypointPattern = Engine[@"getmodelforcontroller"](f1_arg1)
	HealthBar(WaypointBacker, WaypointPattern["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f4_arg0)
		f1_arg0:updateElementState(NameAndNumber, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	WaypointBacker = NameAndNumber
	HealthBar = NameAndNumber.subscribeToModel
	WaypointPattern = Engine[@"getmodelforcontroller"](f1_arg1)
	HealthBar(WaypointBacker, WaypointPattern["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f5_arg0)
		f1_arg0:updateElementState(NameAndNumber, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	NameAndNumber:linkToElementModel(self, nil, false, function(model)
		NameAndNumber:setModel(model, f1_arg1)
	end)
	self:addElement(NameAndNumber)
	self.NameAndNumber = NameAndNumber
	HealthBar = CoD.HealthBar.new(f1_arg0, f1_arg1, 0, 0, 31, 169, 0, 0, 30, 46)
	HealthBar:linkToElementModel(self, nil, false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	WaypointBacker = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -111, -35)
	WaypointBacker:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_backer"))
	self:addElement(WaypointBacker)
	self.WaypointBacker = WaypointBacker
	WaypointPattern = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -111, -35)
	WaypointPattern:setRGB(0.13, 0.87, 0.94)
	WaypointPattern:setAlpha(0.75)
	WaypointPattern:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_led"))
	WaypointPattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	WaypointPattern:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(WaypointPattern)
	self.WaypointPattern = WaypointPattern
	local YouText2 = LUI.UIText.new(0.5, 0.5, -29, 29, 0, 0, -68.5, -47.5)
	YouText2:setText(LocalizeToUpperString(@"wz/you"))
	YouText2:setTTF("ttmussels_demibold")
	YouText2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	YouText2:setShaderVector(0, 0.5, 0, 0, 0)
	YouText2:setShaderVector(1, 0, 0, 0, 0)
	YouText2:setShaderVector(2, 0, 0, 0, 0.5)
	YouText2:setLetterSpacing(2)
	YouText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	YouText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(YouText2)
	self.YouText2 = YouText2
	local Arrows = LUI.UIImage.new(0.5, 0.5, -16, 16, 0, 0, -28.5, 3.5)
	Arrows:setImage(RegisterImage(@"uie_ui_hud_revive_arrow"))
	self:addElement(Arrows)
	self.Arrows = Arrows
	local PlatoonChevron = LUI.UIImage.new(0, 0, 81, 119, 0, 0, -8, 30)
	PlatoonChevron:setAlpha(0)
	PlatoonChevron:setImage(RegisterImage(@"uie_ui_hud_wz_hud_platoon_chevron"))
	PlatoonChevron:linkToElementModel(self, "platoonIndicatorScale", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			PlatoonChevron:setScale(f8_local0)
		end
	end)
	self:addElement(PlatoonChevron)
	self.PlatoonChevron = PlatoonChevron
	local PlatoonRevive = CoD.OverheadNamePlatoonReviveIcon.new(f1_arg0, f1_arg1, 0, 0, 62.5, 137.5, 0, 0, -75, 30)
	PlatoonRevive:setAlpha(0)
	PlatoonRevive:linkToElementModel(self, "platoonIndicatorScale", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			PlatoonRevive:setScale(f9_local0)
		end
	end)
	self:addElement(PlatoonRevive)
	self.PlatoonRevive = PlatoonRevive
	local PandemicPlatoonChevron = LUI.UIImage.new(0, 0, 81, 119, 0, 0, -8, 30)
	PandemicPlatoonChevron:setAlpha(0)
	PandemicPlatoonChevron:setImage(RegisterImage(@"hash_4860B7285A075F9F"))
	PandemicPlatoonChevron:linkToElementModel(self, "platoonIndicatorScale", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			PandemicPlatoonChevron:setScale(f10_local0)
		end
	end)
	self:addElement(PandemicPlatoonChevron)
	self.PandemicPlatoonChevron = PandemicPlatoonChevron
	self:mergeStateConditions({
		{
			stateName = "KillcamSelf",
			condition = function(menu, element, event)
				local f11_local0 = CoD.ModelUtility.IsSelfModelValueEqualToClientModelValue(f1_arg1, element, "clientNum", "clientNum")
				if f11_local0 then
					f11_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
					if not f11_local0 then
						f11_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						if not f11_local0 then
							f11_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						end
					end
				end
				return f11_local0
			end,
		},
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				local f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
				if not f12_local0 then
					f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
					if not f12_local0 then
						f12_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
					end
				end
				return f12_local0
			end,
		},
		{
			stateName = "FriendlyPlatoonMemberLastStand",
			condition = function(menu, element, event)
				local f13_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isInLastStand")
				if f13_local0 then
					f13_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showPlatoonLastStand")
					if f13_local0 then
						f13_local0 = CoD.WZUtility.IsPerClientOnFriendlyPlatoonOnly(self, f1_arg1)
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "FriendlyPlatoonMemberLastStandHidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isInLastStand") and CoD.WZUtility.IsPerClientOnFriendlyPlatoonOnly(self, f1_arg1)
			end,
		},
		{
			stateName = "FriendlyPlatoonMemberPandemic",
			condition = function(menu, element, event)
				local f15_local0 = CoD.HUDUtility.IsGameTypeEqualToString("warzone_pandemic_quad")
				if f15_local0 then
					f15_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.playerOnInfectedPlatoon", 1)
					if f15_local0 then
						f15_local0 = CoD.WZUtility.IsPerClientOnFriendlyPlatoonOnly(self, f1_arg1)
					end
				end
				return f15_local0
			end,
		},
		{
			stateName = "FriendlyPlatoonMember",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsPerClientOnFriendlyPlatoonOnly(self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	f1_local11(f1_local10, f1_local12.clientNum, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "clientNum",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	self:linkToElementModel(self, "isInLastStand", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isInLastStand",
		})
	end)
	self:linkToElementModel(self, "showPlatoonLastStand", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showPlatoonLastStand",
		})
	end)
	self:linkToElementModel(self, "platoonNumber", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "platoonNumber",
		})
	end)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["factions.actualTeam"], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "factions.actualTeam",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local10, f1_local12["hudItems.playerOnInfectedPlatoon"], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "hudItems.playerOnInfectedPlatoon",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local11 = self
	CoD.HUDUtility.UpdateSelfClientHealth(self, f1_arg1)
	SetElementProperty(f1_local11, "isOverheadName", true)
	return self
end
CoD.OverheadName_WZ.__resetProperties = function(f27_arg0)
	f27_arg0.HealthBar:completeAnimation()
	f27_arg0.YouText2:completeAnimation()
	f27_arg0.WaypointPattern:completeAnimation()
	f27_arg0.WaypointBacker:completeAnimation()
	f27_arg0.Arrows:completeAnimation()
	f27_arg0.NameAndNumber:completeAnimation()
	f27_arg0.PlatoonChevron:completeAnimation()
	f27_arg0.PlatoonRevive:completeAnimation()
	f27_arg0.PandemicPlatoonChevron:completeAnimation()
	f27_arg0.HealthBar:setTopBottom(0, 0, 30, 46)
	f27_arg0.HealthBar:setAlpha(1)
	f27_arg0.YouText2:setAlpha(1)
	f27_arg0.WaypointPattern:setRGB(0.13, 0.87, 0.94)
	f27_arg0.WaypointPattern:setAlpha(0.75)
	f27_arg0.WaypointBacker:setAlpha(1)
	f27_arg0.Arrows:setLeftRight(0.5, 0.5, -16, 16)
	f27_arg0.Arrows:setTopBottom(0, 0, -28.5, 3.5)
	f27_arg0.Arrows:setAlpha(1)
	f27_arg0.NameAndNumber:setTopBottom(0, 0, -3, 30)
	f27_arg0.NameAndNumber:setRGB(1, 1, 1)
	f27_arg0.NameAndNumber:setAlpha(1)
	f27_arg0.PlatoonChevron:setRGB(1, 1, 1)
	f27_arg0.PlatoonChevron:setAlpha(0)
	f27_arg0.PlatoonRevive:setAlpha(0)
	f27_arg0.PandemicPlatoonChevron:setAlpha(0)
end
CoD.OverheadName_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.HealthBar:completeAnimation()
			f28_arg0.HealthBar:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.HealthBar)
			f28_arg0.WaypointBacker:completeAnimation()
			f28_arg0.WaypointBacker:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.WaypointBacker)
			f28_arg0.WaypointPattern:completeAnimation()
			f28_arg0.WaypointPattern:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.WaypointPattern)
			f28_arg0.YouText2:completeAnimation()
			f28_arg0.YouText2:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.YouText2)
			f28_arg0.Arrows:completeAnimation()
			f28_arg0.Arrows:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.Arrows)
		end,
	},
	KillcamSelf = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.NameAndNumber:completeAnimation()
			f29_arg0.NameAndNumber:setTopBottom(0, 0, 16, 49)
			f29_arg0.NameAndNumber:setRGB(0.13, 0.87, 0.94)
			f29_arg0.clipFinished(f29_arg0.NameAndNumber)
			f29_arg0.HealthBar:completeAnimation()
			f29_arg0.HealthBar:setTopBottom(0, 0, 0, 16)
			f29_arg0.clipFinished(f29_arg0.HealthBar)
			f29_arg0.WaypointPattern:completeAnimation()
			f29_arg0.WaypointPattern:setRGB(0.13, 0.87, 0.94)
			f29_arg0.clipFinished(f29_arg0.WaypointPattern)
		end,
	},
	Killcam = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(6)
			f30_arg0.NameAndNumber:completeAnimation()
			f30_arg0.NameAndNumber:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.NameAndNumber)
			f30_arg0.HealthBar:completeAnimation()
			f30_arg0.HealthBar:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.HealthBar)
			f30_arg0.WaypointBacker:completeAnimation()
			f30_arg0.WaypointBacker:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WaypointBacker)
			f30_arg0.WaypointPattern:completeAnimation()
			f30_arg0.WaypointPattern:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WaypointPattern)
			f30_arg0.YouText2:completeAnimation()
			f30_arg0.YouText2:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.YouText2)
			f30_arg0.Arrows:completeAnimation()
			f30_arg0.Arrows:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Arrows)
		end,
	},
	FriendlyPlatoonMemberLastStand = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(8)
			f31_arg0.NameAndNumber:completeAnimation()
			f31_arg0.NameAndNumber:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.NameAndNumber)
			f31_arg0.HealthBar:completeAnimation()
			f31_arg0.HealthBar:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.HealthBar)
			f31_arg0.WaypointBacker:completeAnimation()
			f31_arg0.WaypointBacker:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.WaypointBacker)
			f31_arg0.WaypointPattern:completeAnimation()
			f31_arg0.WaypointPattern:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.WaypointPattern)
			f31_arg0.YouText2:completeAnimation()
			f31_arg0.YouText2:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.YouText2)
			f31_arg0.Arrows:completeAnimation()
			f31_arg0.Arrows:setTopBottom(0.5, 0.5, -16, 16)
			f31_arg0.Arrows:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Arrows)
			f31_arg0.PlatoonChevron:completeAnimation()
			f31_arg0.PlatoonChevron:setRGB(1, 0.19, 0.19)
			f31_arg0.PlatoonChevron:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.PlatoonChevron)
			f31_arg0.PlatoonRevive:completeAnimation()
			f31_arg0.PlatoonRevive:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.PlatoonRevive)
			f31_arg0.nextClip = "DefaultClip"
		end,
	},
	FriendlyPlatoonMemberLastStandHidden = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(6)
			f32_arg0.NameAndNumber:completeAnimation()
			f32_arg0.NameAndNumber:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.NameAndNumber)
			f32_arg0.HealthBar:completeAnimation()
			f32_arg0.HealthBar:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.HealthBar)
			f32_arg0.WaypointBacker:completeAnimation()
			f32_arg0.WaypointBacker:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.WaypointBacker)
			f32_arg0.WaypointPattern:completeAnimation()
			f32_arg0.WaypointPattern:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.WaypointPattern)
			f32_arg0.YouText2:completeAnimation()
			f32_arg0.YouText2:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.YouText2)
			f32_arg0.Arrows:completeAnimation()
			f32_arg0.Arrows:setLeftRight(0.5, 0.5, -24, 24)
			f32_arg0.Arrows:setTopBottom(0, 0, -12, 36)
			f32_arg0.Arrows:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Arrows)
			f32_arg0.nextClip = "DefaultClip"
		end,
	},
	FriendlyPlatoonMemberPandemic = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(8)
			f33_arg0.NameAndNumber:completeAnimation()
			f33_arg0.NameAndNumber:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.NameAndNumber)
			f33_arg0.HealthBar:completeAnimation()
			f33_arg0.HealthBar:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.HealthBar)
			f33_arg0.WaypointBacker:completeAnimation()
			f33_arg0.WaypointBacker:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.WaypointBacker)
			f33_arg0.WaypointPattern:completeAnimation()
			f33_arg0.WaypointPattern:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.WaypointPattern)
			f33_arg0.YouText2:completeAnimation()
			f33_arg0.YouText2:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.YouText2)
			f33_arg0.Arrows:completeAnimation()
			f33_arg0.Arrows:setLeftRight(0.5, 0.5, -24, 24)
			f33_arg0.Arrows:setTopBottom(0, 0, -12, 36)
			f33_arg0.Arrows:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Arrows)
			f33_arg0.PlatoonChevron:completeAnimation()
			f33_arg0.PlatoonChevron:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.PlatoonChevron)
			f33_arg0.PandemicPlatoonChevron:completeAnimation()
			f33_arg0.PandemicPlatoonChevron:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.PandemicPlatoonChevron)
		end,
	},
	FriendlyPlatoonMember = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(7)
			f34_arg0.NameAndNumber:completeAnimation()
			f34_arg0.NameAndNumber:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.NameAndNumber)
			f34_arg0.HealthBar:completeAnimation()
			f34_arg0.HealthBar:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.HealthBar)
			f34_arg0.WaypointBacker:completeAnimation()
			f34_arg0.WaypointBacker:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.WaypointBacker)
			f34_arg0.WaypointPattern:completeAnimation()
			f34_arg0.WaypointPattern:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.WaypointPattern)
			f34_arg0.YouText2:completeAnimation()
			f34_arg0.YouText2:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.YouText2)
			f34_arg0.Arrows:completeAnimation()
			f34_arg0.Arrows:setLeftRight(0.5, 0.5, -24, 24)
			f34_arg0.Arrows:setTopBottom(0, 0, -12, 36)
			f34_arg0.Arrows:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Arrows)
			f34_arg0.PlatoonChevron:completeAnimation()
			f34_arg0.PlatoonChevron:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.PlatoonChevron)
		end,
	},
}
CoD.OverheadName_WZ.__onClose = function(f35_arg0)
	f35_arg0.NameAndNumber:close()
	f35_arg0.HealthBar:close()
	f35_arg0.PlatoonChevron:close()
	f35_arg0.PlatoonRevive:close()
	f35_arg0.PandemicPlatoonChevron:close()
end
