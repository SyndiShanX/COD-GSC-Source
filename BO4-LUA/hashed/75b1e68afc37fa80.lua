require("x64:1de9b3de837a34c")
require("x64:54118f37219653d")
require("x64:90bfa8fd4b71a33")
require("x64:2e06eec4ea38539")
require("x64:298bd344d764bb6")
CoD.MultiItemPickupWaypoint = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupWaypoint.__defaultWidth = 1100
CoD.MultiItemPickupWaypoint.__defaultHeight = 250
CoD.MultiItemPickupWaypoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MultiItemPickupWaypoint)
	self.id = "MultiItemPickupWaypoint"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 385, 715, 0, 0, 54, 106)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local LineImage = LUI.UIImage.new(0.5, 0.5, -4, 4, 1, 1, -180, 0)
	LineImage:setAlpha(0.25)
	LineImage:setImage(RegisterImage(@"hash_56C9564494BB3117"))
	self:addElement(LineImage)
	self.LineImage = LineImage
	local ArrowImage = LUI.UIImage.new(0.5, 0.5, -22.5, 22.5, 1, 1, -57.5, -12.5)
	ArrowImage:setImage(RegisterImage(@"uie_ui_hud_weaponpickup_arrow"))
	self:addElement(ArrowImage)
	self.ArrowImage = ArrowImage
	local GridBacking = CoD.WeaponPickupPrompt_Backing.new(f1_arg0, f1_arg1, 0.5, 0.5, -165, 165, 0, 0, 54, 106)
	self:addElement(GridBacking)
	self.GridBacking = GridBacking
	local ItemPickupGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -18, 100, nil, nil, false, true, false, false)
	ItemPickupGrid:setLeftRight(0, 0, 334, 766)
	ItemPickupGrid:setTopBottom(0, 0, 39.5, 120.5)
	ItemPickupGrid:setWidgetType(CoD.MultiItemPickupWaypointItem)
	ItemPickupGrid:setHorizontalCount(3)
	ItemPickupGrid:setSpacing(-18)
	ItemPickupGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ItemPickupGrid:setDataSource("MultiItemPickup")
	ItemPickupGrid:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		if IsGamepad(f1_arg1) and not IsIntDvarNonZero("tabbedMultiItemPickup") then
			CoD.HUDUtility.SetAsCurrentMultiItemPickup(f1_arg1, element)
			ForceNotifyControllerModel(f1_arg1, "hudItems.multiItemPickup.forceNotifyActive")
		end
		return f2_local0
	end)
	ItemPickupGrid:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "status", function(model)
		local f3_local0 = ItemPickupGrid
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"]) and IsGamepad(f1_arg1) and not IsIntDvarNonZero("tabbedMultiItemPickup") then
			CoD.BaseUtility.EnableNavigation(f3_local0)
		elseif IsGamepad(f1_arg1) and not IsIntDvarNonZero("tabbedMultiItemPickup") then
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f3_local0)
			CoD.BaseUtility.DisableNavigation(f3_local0)
		end
	end)
	ItemPickupGrid:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f4_local0 = ItemPickupGrid
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_415EF5E7734C15F5") and IsGamepad(f1_arg1) and not IsIntDvarNonZero("tabbedMultiItemPickup") then
			CoD.WZUtility.SendInventoryPickUpNotify(f1_arg1, f4_local0)
			CoD.GridAndListUtility.SelectNextItemOrPrevious(f4_local0)
			BlockGameFromKeyEvent(f1_arg1)
		end
	end)
	self:addElement(ItemPickupGrid)
	self.ItemPickupGrid = ItemPickupGrid
	local ItemHeader = CoD.MultiItemPickupWaypoint_Header.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 0, 0, -9, 31)
	self:addElement(ItemHeader)
	self.ItemHeader = ItemHeader
	local HoldButtonIcon = CoD.WZHoldButtonPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -44, 45, 0, 0, 44, 86)
	HoldButtonIcon:mergeStateConditions({
		{
			stateName = "HideHold",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsProfileIntValue(f1_arg1, "warzoneInstantPickups", 1)
			end,
		},
	})
	HoldButtonIcon:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(HoldButtonIcon, f6_arg1)
	end)
	local NavigationPrompt = HoldButtonIcon
	local OpenPromptText = HoldButtonIcon.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	OpenPromptText(NavigationPrompt, f1_local10.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(HoldButtonIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	NavigationPrompt = HoldButtonIcon
	OpenPromptText = HoldButtonIcon.subscribeToModel
	f1_local10 = Engine[@"getglobalmodel"]()
	OpenPromptText(NavigationPrompt, f1_local10["storageGlobalRoot.user_settings"], function(f8_arg0)
		f1_arg0:updateElementState(HoldButtonIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	HoldButtonIcon:setScale(1.5, 1.5)
	HoldButtonIcon.ControllerDependentTextBox.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+activate}]"))
	HoldButtonIcon.ControllerDependentTextBox.GamepadText:setText(CoD.BaseUtility.AlreadyLocalized("[{+usereload}]"))
	HoldButtonIcon:subscribeToGlobalModel(f1_arg1, "HUDItems", "useHoldProgress", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			HoldButtonIcon.ButtonProgressRing.progressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4))
		end
	end)
	self:addElement(HoldButtonIcon)
	self.HoldButtonIcon = HoldButtonIcon
	OpenPromptText = LUI.UIText.new(0.5, 0.5, 29.5, 106.5, 0, 0, 57.5, 82.5)
	OpenPromptText:setRGB(0.79, 0.76, 0.58)
	OpenPromptText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"wz/open_stash"))
	OpenPromptText:setTTF("ttmussels_regular")
	OpenPromptText:setLetterSpacing(0.5)
	OpenPromptText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OpenPromptText:setBackingType(1)
	OpenPromptText:setBackingWidget(CoD.WeaponPickupPrompt_Backing, f1_arg0, f1_arg1)
	OpenPromptText:setBackingXPadding(4)
	OpenPromptText:setBackingYPadding(2)
	self:addElement(OpenPromptText)
	self.OpenPromptText = OpenPromptText
	NavigationPrompt = CoD.MultiItemPickupWaypoint_NavigationPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -232, -168, 0, 0, 48, 112)
	NavigationPrompt:mergeStateConditions({
		{
			stateName = "AtLeftAndRight",
			condition = function(menu, element, event)
				return CoD.GridAndListUtility.IsActiveElementWithinIndexOfFirstElement(self.ItemPickupGrid, 0) and CoD.GridAndListUtility.IsActiveElementWithinIndexOfLastElement(self.ItemPickupGrid, 0)
			end,
		},
		{
			stateName = "AtLeft",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "AtRight",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	NavigationPrompt:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "forceNotifyActive", function(model)
		local f13_local0 = NavigationPrompt
		if IsGamepad(f1_arg1) then
			UpdateSelfElementState(f1_arg0, f13_local0, f1_arg1)
		end
	end)
	self:addElement(NavigationPrompt)
	self.NavigationPrompt = NavigationPrompt
	ItemHeader:linkToElementModel(ItemPickupGrid, nil, false, function(model)
		ItemHeader:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "ActiveKBM",
			condition = function(menu, element, event)
				local f15_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
				if f15_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					then
						f15_local0 = IsMouseOrKeyboard(f1_arg1)
						if f15_local0 then
							if not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1) then
								f15_local0 = not IsIntDvarNonZero("tabbedMultiItemPickup")
							else
								f15_local0 = false
							end
						else
							return f15_local0
						end
					end
					f15_local0 = false
				end
				return f15_local0
			end,
		},
		{
			stateName = "ActiveSnap",
			condition = function(menu, element, event)
				local f16_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
				if f16_local0 then
					f16_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOffscreen")
					if f16_local0 then
						if
							not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
							and not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
						then
							f16_local0 = not IsIntDvarNonZero("tabbedMultiItemPickup")
						else
							f16_local0 = false
						end
					end
				end
				return f16_local0
			end,
		},
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f17_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
				if f17_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
					then
						f17_local0 = not IsIntDvarNonZero("tabbedMultiItemPickup")
					else
						f17_local0 = false
					end
				end
				return f17_local0
			end,
		},
		{
			stateName = "LockedPromptSnap",
			condition = function(menu, element, event)
				local f18_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_1C2DA8D07C271C53"])
				if f18_local0 then
					f18_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOffscreen")
					if f18_local0 then
						if
							not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						then
							f18_local0 = not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
						else
							f18_local0 = false
						end
					end
				end
				return f18_local0
			end,
		},
		{
			stateName = "LockedPrompt",
			condition = function(menu, element, event)
				local f19_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_1C2DA8D07C271C53"])
				if f19_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					then
						f19_local0 = not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
					else
						f19_local0 = false
					end
				end
				return f19_local0
			end,
		},
		{
			stateName = "OpenPromptSnap",
			condition = function(menu, element, event)
				local f20_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_BAD3011A800B6D8"])
				if f20_local0 then
					f20_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOffscreen")
					if f20_local0 then
						if
							not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						then
							f20_local0 = not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
						else
							f20_local0 = false
						end
					end
				end
				return f20_local0
			end,
		},
		{
			stateName = "OpenPrompt",
			condition = function(menu, element, event)
				local f21_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_BAD3011A800B6D8"])
				if f21_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					then
						f21_local0 = not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
					else
						f21_local0 = false
					end
				end
				return f21_local0
			end,
		},
		{
			stateName = "UnlockPromptSnap",
			condition = function(menu, element, event)
				local f22_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_1576D416952948D5"])
				if f22_local0 then
					f22_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOffscreen")
					if f22_local0 then
						if
							not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
							and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
							and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						then
							f22_local0 = not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
						else
							f22_local0 = false
						end
					end
				end
				return f22_local0
			end,
		},
		{
			stateName = "UnlockPrompt",
			condition = function(menu, element, event)
				local f23_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_1576D416952948D5"])
				if f23_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
					then
						f23_local0 = not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
					else
						f23_local0 = false
					end
				end
				return f23_local0
			end,
		},
		{
			stateName = "InRange",
			condition = function(menu, element, event)
				local f24_local0 = CoD.WaypointUtility.IsWeaponPickupInRange(f1_arg1, self)
				if f24_local0 then
					if
						not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
						and Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_visible"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
						and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
						and not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
					then
						f24_local0 = not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
					else
						f24_local0 = false
					end
				end
				return f24_local0
			end,
		},
	})
	local f1_local11 = self
	f1_local10 = self.subscribeToModel
	local f1_local12 = DataSources.MultiItemPickup.getModel(f1_arg1)
	f1_local10(f1_local11, f1_local12.status, function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_missile"]], function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_missile"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]], function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function(f36_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f37_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f38_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f39_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f40_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f41_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f42_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f43_arg0, f43_arg1)
		f43_arg1.menu = f43_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f43_arg1)
	end)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12.LastInput, function(f44_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["hudItems.inventory.open"], function(f45_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	self:linkToElementModel(self, "isOffscreen", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOffscreen",
		})
	end)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local10(f1_local11, f1_local12.showPickupHint, function(f47_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "showPickupHint",
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local10(f1_local11, f1_local12["inventory.open"], function(f48_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "inventory.open",
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["interactivePrompt.activeObjectiveID"], function(f49_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	ItemPickupGrid.id = "ItemPickupGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	f1_local10 = ItemPickupGrid
	if not IsIntDvarNonZero("tabbedMultiItemPickup") then
		CoD.GridAndListUtility.KeepSelectedItemCentered(f1_local10, true)
		CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local10, f1_arg1)
		CoD.GridAndListUtility.AddActiveLeftRightNavigation(f1_arg0, f1_local10, f1_arg1, true)
		SetElementProperty(f1_local10, "__selectFromEndIfLastElementRemoved", true)
		SetElementProperty(f1_local10, "__isForGamepad", true)
	end
	return self
end
CoD.MultiItemPickupWaypoint.__resetProperties = function(f50_arg0)
	f50_arg0.ItemPickupGrid:completeAnimation()
	f50_arg0.LineImage:completeAnimation()
	f50_arg0.ArrowImage:completeAnimation()
	f50_arg0.HoldButtonIcon:completeAnimation()
	f50_arg0.ItemHeader:completeAnimation()
	f50_arg0.OpenPromptText:completeAnimation()
	f50_arg0.NavigationPrompt:completeAnimation()
	f50_arg0.GridBacking:completeAnimation()
	f50_arg0.Blur:completeAnimation()
	f50_arg0.ItemPickupGrid:setTopBottom(0, 0, 39.5, 120.5)
	f50_arg0.ItemPickupGrid:setAlpha(1)
	f50_arg0.LineImage:setTopBottom(1, 1, -180, 0)
	f50_arg0.LineImage:setAlpha(0.25)
	f50_arg0.ArrowImage:setAlpha(1)
	f50_arg0.HoldButtonIcon:setTopBottom(0, 0, 44, 86)
	f50_arg0.HoldButtonIcon:setAlpha(1)
	f50_arg0.ItemHeader:setTopBottom(0, 0, -9, 31)
	f50_arg0.ItemHeader:setAlpha(1)
	f50_arg0.OpenPromptText:setLeftRight(0.5, 0.5, 29.5, 106.5)
	f50_arg0.OpenPromptText:setTopBottom(0, 0, 57.5, 82.5)
	f50_arg0.OpenPromptText:setAlpha(1)
	f50_arg0.OpenPromptText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"wz/open_stash"))
	f50_arg0.OpenPromptText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f50_arg0.NavigationPrompt:setTopBottom(0, 0, 48, 112)
	f50_arg0.NavigationPrompt:setAlpha(1)
	f50_arg0.GridBacking:setTopBottom(0, 0, 54, 106)
	f50_arg0.GridBacking:setAlpha(1)
	f50_arg0.Blur:setTopBottom(0, 0, 54, 106)
	f50_arg0.Blur:setAlpha(1)
end
CoD.MultiItemPickupWaypoint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(9)
			f51_arg0.Blur:completeAnimation()
			f51_arg0.Blur:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.Blur)
			f51_arg0.LineImage:completeAnimation()
			f51_arg0.LineImage:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.LineImage)
			f51_arg0.ArrowImage:completeAnimation()
			f51_arg0.ArrowImage:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.ArrowImage)
			f51_arg0.GridBacking:completeAnimation()
			f51_arg0.GridBacking:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.GridBacking)
			f51_arg0.ItemPickupGrid:completeAnimation()
			f51_arg0.ItemPickupGrid:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.ItemPickupGrid)
			f51_arg0.ItemHeader:completeAnimation()
			f51_arg0.ItemHeader:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.ItemHeader)
			f51_arg0.HoldButtonIcon:completeAnimation()
			f51_arg0.HoldButtonIcon:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.HoldButtonIcon)
			f51_arg0.OpenPromptText:completeAnimation()
			f51_arg0.OpenPromptText:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.OpenPromptText)
			f51_arg0.NavigationPrompt:completeAnimation()
			f51_arg0.NavigationPrompt:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.NavigationPrompt)
		end,
	},
	ActiveKBM = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(9)
			f52_arg0.Blur:completeAnimation()
			f52_arg0.Blur:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.Blur)
			f52_arg0.LineImage:completeAnimation()
			f52_arg0.LineImage:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.LineImage)
			f52_arg0.ArrowImage:completeAnimation()
			f52_arg0.ArrowImage:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.ArrowImage)
			f52_arg0.GridBacking:completeAnimation()
			f52_arg0.GridBacking:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.GridBacking)
			f52_arg0.ItemPickupGrid:completeAnimation()
			f52_arg0.ItemPickupGrid:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.ItemPickupGrid)
			f52_arg0.ItemHeader:completeAnimation()
			f52_arg0.ItemHeader:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.ItemHeader)
			f52_arg0.HoldButtonIcon:completeAnimation()
			f52_arg0.HoldButtonIcon:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.HoldButtonIcon)
			f52_arg0.OpenPromptText:completeAnimation()
			f52_arg0.OpenPromptText:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.OpenPromptText)
			f52_arg0.NavigationPrompt:completeAnimation()
			f52_arg0.NavigationPrompt:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.NavigationPrompt)
		end,
	},
	ActiveSnap = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(9)
			f53_arg0.Blur:completeAnimation()
			f53_arg0.Blur:setTopBottom(0, 0, 79, 131)
			f53_arg0.clipFinished(f53_arg0.Blur)
			f53_arg0.LineImage:completeAnimation()
			f53_arg0.LineImage:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.LineImage)
			f53_arg0.ArrowImage:completeAnimation()
			f53_arg0.ArrowImage:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.ArrowImage)
			f53_arg0.GridBacking:completeAnimation()
			f53_arg0.GridBacking:setTopBottom(0, 0, 79, 131)
			f53_arg0.clipFinished(f53_arg0.GridBacking)
			f53_arg0.ItemPickupGrid:completeAnimation()
			f53_arg0.ItemPickupGrid:setTopBottom(0, 0, 65, 146)
			f53_arg0.clipFinished(f53_arg0.ItemPickupGrid)
			f53_arg0.ItemHeader:completeAnimation()
			f53_arg0.ItemHeader:setTopBottom(0, 0, 25, 65)
			f53_arg0.clipFinished(f53_arg0.ItemHeader)
			f53_arg0.HoldButtonIcon:completeAnimation()
			f53_arg0.HoldButtonIcon:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.HoldButtonIcon)
			f53_arg0.OpenPromptText:completeAnimation()
			f53_arg0.OpenPromptText:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.OpenPromptText)
			f53_arg0.NavigationPrompt:completeAnimation()
			f53_arg0.NavigationPrompt:setTopBottom(0, 0, 73, 137)
			f53_arg0.clipFinished(f53_arg0.NavigationPrompt)
		end,
	},
	Active = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(3)
			f54_arg0.ArrowImage:completeAnimation()
			f54_arg0.ArrowImage:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.ArrowImage)
			f54_arg0.HoldButtonIcon:completeAnimation()
			f54_arg0.HoldButtonIcon:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.HoldButtonIcon)
			f54_arg0.OpenPromptText:completeAnimation()
			f54_arg0.OpenPromptText:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.OpenPromptText)
		end,
	},
	LockedPromptSnap = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(9)
			f55_arg0.Blur:completeAnimation()
			f55_arg0.Blur:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Blur)
			f55_arg0.LineImage:completeAnimation()
			f55_arg0.LineImage:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.LineImage)
			f55_arg0.ArrowImage:completeAnimation()
			f55_arg0.ArrowImage:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ArrowImage)
			f55_arg0.GridBacking:completeAnimation()
			f55_arg0.GridBacking:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.GridBacking)
			f55_arg0.ItemPickupGrid:completeAnimation()
			f55_arg0.ItemPickupGrid:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ItemPickupGrid)
			f55_arg0.ItemHeader:completeAnimation()
			f55_arg0.ItemHeader:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ItemHeader)
			f55_arg0.HoldButtonIcon:completeAnimation()
			f55_arg0.HoldButtonIcon:setTopBottom(0, 0, 96, 146)
			f55_arg0.HoldButtonIcon:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.HoldButtonIcon)
			f55_arg0.OpenPromptText:completeAnimation()
			f55_arg0.OpenPromptText:setLeftRight(0.5, 0.5, -38.5, 38.5)
			f55_arg0.OpenPromptText:setTopBottom(0, 0, 108.5, 133.5)
			f55_arg0.OpenPromptText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"wz/locked_stash"))
			f55_arg0.OpenPromptText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f55_arg0.clipFinished(f55_arg0.OpenPromptText)
			f55_arg0.NavigationPrompt:completeAnimation()
			f55_arg0.NavigationPrompt:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.NavigationPrompt)
		end,
	},
	LockedPrompt = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(8)
			f56_arg0.Blur:completeAnimation()
			f56_arg0.Blur:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.Blur)
			f56_arg0.ArrowImage:completeAnimation()
			f56_arg0.ArrowImage:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.ArrowImage)
			f56_arg0.GridBacking:completeAnimation()
			f56_arg0.GridBacking:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.GridBacking)
			f56_arg0.ItemPickupGrid:completeAnimation()
			f56_arg0.ItemPickupGrid:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.ItemPickupGrid)
			f56_arg0.ItemHeader:completeAnimation()
			f56_arg0.ItemHeader:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.ItemHeader)
			f56_arg0.HoldButtonIcon:completeAnimation()
			f56_arg0.HoldButtonIcon:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.HoldButtonIcon)
			f56_arg0.OpenPromptText:completeAnimation()
			f56_arg0.OpenPromptText:setLeftRight(0.5, 0.5, -38.5, 38.5)
			f56_arg0.OpenPromptText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"wz/locked_stash"))
			f56_arg0.OpenPromptText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f56_arg0.clipFinished(f56_arg0.OpenPromptText)
			f56_arg0.NavigationPrompt:completeAnimation()
			f56_arg0.NavigationPrompt:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.NavigationPrompt)
		end,
	},
	OpenPromptSnap = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(9)
			f57_arg0.Blur:completeAnimation()
			f57_arg0.Blur:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.Blur)
			f57_arg0.LineImage:completeAnimation()
			f57_arg0.LineImage:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.LineImage)
			f57_arg0.ArrowImage:completeAnimation()
			f57_arg0.ArrowImage:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.ArrowImage)
			f57_arg0.GridBacking:completeAnimation()
			f57_arg0.GridBacking:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.GridBacking)
			f57_arg0.ItemPickupGrid:completeAnimation()
			f57_arg0.ItemPickupGrid:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.ItemPickupGrid)
			f57_arg0.ItemHeader:completeAnimation()
			f57_arg0.ItemHeader:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.ItemHeader)
			f57_arg0.HoldButtonIcon:completeAnimation()
			f57_arg0.HoldButtonIcon:setTopBottom(0, 0, 96, 146)
			f57_arg0.clipFinished(f57_arg0.HoldButtonIcon)
			f57_arg0.OpenPromptText:completeAnimation()
			f57_arg0.OpenPromptText:setTopBottom(0, 0, 108.5, 133.5)
			f57_arg0.clipFinished(f57_arg0.OpenPromptText)
			f57_arg0.NavigationPrompt:completeAnimation()
			f57_arg0.NavigationPrompt:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.NavigationPrompt)
		end,
	},
	OpenPrompt = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(6)
			f58_arg0.Blur:completeAnimation()
			f58_arg0.Blur:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.Blur)
			f58_arg0.ArrowImage:completeAnimation()
			f58_arg0.ArrowImage:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.ArrowImage)
			f58_arg0.GridBacking:completeAnimation()
			f58_arg0.GridBacking:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.GridBacking)
			f58_arg0.ItemPickupGrid:completeAnimation()
			f58_arg0.ItemPickupGrid:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.ItemPickupGrid)
			f58_arg0.ItemHeader:completeAnimation()
			f58_arg0.ItemHeader:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.ItemHeader)
			f58_arg0.NavigationPrompt:completeAnimation()
			f58_arg0.NavigationPrompt:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.NavigationPrompt)
		end,
	},
	UnlockPromptSnap = {
		DefaultClip = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(9)
			f59_arg0.Blur:completeAnimation()
			f59_arg0.Blur:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.Blur)
			f59_arg0.LineImage:completeAnimation()
			f59_arg0.LineImage:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.LineImage)
			f59_arg0.ArrowImage:completeAnimation()
			f59_arg0.ArrowImage:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.ArrowImage)
			f59_arg0.GridBacking:completeAnimation()
			f59_arg0.GridBacking:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.GridBacking)
			f59_arg0.ItemPickupGrid:completeAnimation()
			f59_arg0.ItemPickupGrid:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.ItemPickupGrid)
			f59_arg0.ItemHeader:completeAnimation()
			f59_arg0.ItemHeader:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.ItemHeader)
			f59_arg0.HoldButtonIcon:completeAnimation()
			f59_arg0.HoldButtonIcon:setTopBottom(0, 0, 96, 146)
			f59_arg0.clipFinished(f59_arg0.HoldButtonIcon)
			f59_arg0.OpenPromptText:completeAnimation()
			f59_arg0.OpenPromptText:setTopBottom(0, 0, 108.5, 133.5)
			f59_arg0.OpenPromptText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"wz/unlock_stash"))
			f59_arg0.clipFinished(f59_arg0.OpenPromptText)
			f59_arg0.NavigationPrompt:completeAnimation()
			f59_arg0.NavigationPrompt:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.NavigationPrompt)
		end,
	},
	UnlockPrompt = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(7)
			f60_arg0.Blur:completeAnimation()
			f60_arg0.Blur:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.Blur)
			f60_arg0.ArrowImage:completeAnimation()
			f60_arg0.ArrowImage:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.ArrowImage)
			f60_arg0.GridBacking:completeAnimation()
			f60_arg0.GridBacking:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.GridBacking)
			f60_arg0.ItemPickupGrid:completeAnimation()
			f60_arg0.ItemPickupGrid:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.ItemPickupGrid)
			f60_arg0.ItemHeader:completeAnimation()
			f60_arg0.ItemHeader:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.ItemHeader)
			f60_arg0.OpenPromptText:completeAnimation()
			f60_arg0.OpenPromptText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"wz/unlock_stash"))
			f60_arg0.clipFinished(f60_arg0.OpenPromptText)
			f60_arg0.NavigationPrompt:completeAnimation()
			f60_arg0.NavigationPrompt:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.NavigationPrompt)
		end,
	},
	InRange = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(8)
			f61_arg0.Blur:completeAnimation()
			f61_arg0.Blur:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.Blur)
			f61_arg0.LineImage:completeAnimation()
			f61_arg0.LineImage:setTopBottom(1, 1, -20, 0)
			f61_arg0.LineImage:setAlpha(1)
			f61_arg0.clipFinished(f61_arg0.LineImage)
			f61_arg0.GridBacking:completeAnimation()
			f61_arg0.GridBacking:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.GridBacking)
			f61_arg0.ItemPickupGrid:completeAnimation()
			f61_arg0.ItemPickupGrid:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.ItemPickupGrid)
			f61_arg0.ItemHeader:completeAnimation()
			f61_arg0.ItemHeader:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.ItemHeader)
			f61_arg0.HoldButtonIcon:completeAnimation()
			f61_arg0.HoldButtonIcon:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.HoldButtonIcon)
			f61_arg0.OpenPromptText:completeAnimation()
			f61_arg0.OpenPromptText:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.OpenPromptText)
			f61_arg0.NavigationPrompt:completeAnimation()
			f61_arg0.NavigationPrompt:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.NavigationPrompt)
		end,
	},
}
CoD.MultiItemPickupWaypoint.__onClose = function(f62_arg0)
	f62_arg0.ItemHeader:close()
	f62_arg0.GridBacking:close()
	f62_arg0.ItemPickupGrid:close()
	f62_arg0.HoldButtonIcon:close()
	f62_arg0.NavigationPrompt:close()
end
