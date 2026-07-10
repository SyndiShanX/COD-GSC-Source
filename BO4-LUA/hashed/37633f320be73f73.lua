CoD.WarzoneInventoryNag = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryNag.__defaultWidth = 237
CoD.WarzoneInventoryNag.__defaultHeight = 37
CoD.WarzoneInventoryNag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.WarzoneInventoryNag)
	self.id = "WarzoneInventoryNag"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InventoryPromptImazge = LUI.UIImage.new(0, 0, 8, 31, 0, 0, 14, 37)
	InventoryPromptImazge:subscribeToGlobalModel(f1_arg1, "Controller", "start_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			InventoryPromptImazge:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(InventoryPromptImazge)
	self.InventoryPromptImazge = InventoryPromptImazge
	local InventoryNag = LUI.UIText.new(0, 0, 31, 217, 0, 0, 17, 35)
	InventoryNag:setText(LocalizeToUpperString(@"warzone/inventory"))
	InventoryNag:setTTF("ttmussels_regular")
	InventoryNag:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	InventoryNag:setShaderVector(0, 0.6, 0, 0, 0)
	InventoryNag:setShaderVector(1, 0.3, 0, 0, 0)
	InventoryNag:setShaderVector(2, 0, 0, 0, 1)
	InventoryNag:setLetterSpacing(2)
	InventoryNag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(InventoryNag)
	self.InventoryNag = InventoryNag
	self:mergeStateConditions({
		{
			stateName = "PC_Visible",
			condition = function(menu, element, event)
				local f3_local0 = CoD.WZUtility.ShouldShowInventoryNag(f1_arg1)
				if f3_local0 then
					if not CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.laststand.reviveProgress", 0) and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.laststand.beingRevived", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "playerAbilities.playerGadget1.state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"]) then
						f3_local0 = IsMouseOrKeyboard(f1_arg1)
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f4_local0 = CoD.WZUtility.ShouldShowInventoryNag(f1_arg1)
				if f4_local0 then
					if not CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.laststand.reviveProgress", 0) and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.laststand.beingRevived", 1) then
						f4_local0 = not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "playerAbilities.playerGadget1.state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"])
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.inventory.inventoryNag"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.inventory.inventoryNag",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.laststand.reviveProgress"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.laststand.reviveProgress",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.laststand.beingRevived"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.laststand.beingRevived",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["playerAbilities.playerGadget1.state"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "playerAbilities.playerGadget1.state",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryNag.__resetProperties = function(f11_arg0)
	f11_arg0.InventoryPromptImazge:completeAnimation()
	f11_arg0.InventoryNag:completeAnimation()
	f11_arg0.InventoryPromptImazge:setAlpha(1)
	f11_arg0.InventoryNag:setLeftRight(0, 0, 31, 217)
	f11_arg0.InventoryNag:setAlpha(1)
	f11_arg0.InventoryNag:setText(LocalizeToUpperString(@"warzone/inventory"))
	f11_arg0.InventoryNag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
end
CoD.WarzoneInventoryNag.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.InventoryPromptImazge:completeAnimation()
			f12_arg0.InventoryPromptImazge:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.InventoryPromptImazge)
			f12_arg0.InventoryNag:completeAnimation()
			f12_arg0.InventoryNag:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.InventoryNag)
		end,
		Visible = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(200)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.InventoryPromptImazge:beginAnimation(1000)
				f13_arg0.InventoryPromptImazge:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.InventoryPromptImazge:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.InventoryPromptImazge:completeAnimation()
			f13_arg0.InventoryPromptImazge:setAlpha(0)
			f13_local0(f13_arg0.InventoryPromptImazge)
			local f13_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(200)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.InventoryNag:beginAnimation(1000)
				f13_arg0.InventoryNag:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.InventoryNag:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f13_arg0.InventoryNag:completeAnimation()
			f13_arg0.InventoryNag:setAlpha(0)
			f13_local1(f13_arg0.InventoryNag)
		end,
	},
	PC_Visible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.InventoryPromptImazge:completeAnimation()
			f18_arg0.InventoryPromptImazge:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.InventoryPromptImazge)
			f18_arg0.InventoryNag:completeAnimation()
			f18_arg0.InventoryNag:setLeftRight(0, 0, 24, 210)
			f18_arg0.InventoryNag:setText(LocalizeToUpperString(@"warzone/inventory_pc"))
			f18_arg0.InventoryNag:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f18_arg0.clipFinished(f18_arg0.InventoryNag)
		end,
	},
	Visible = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WarzoneInventoryNag.__onClose = function(f20_arg0)
	f20_arg0.InventoryPromptImazge:close()
end
