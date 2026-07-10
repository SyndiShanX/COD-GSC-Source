require("x64:58f4aeea80f64ad")
require("x64:19c1945d2e472b0")
CoD.SpawnBeaconDeathCam = InheritFrom(LUI.UIElement)
CoD.SpawnBeaconDeathCam.__defaultWidth = 180
CoD.SpawnBeaconDeathCam.__defaultHeight = 35
CoD.SpawnBeaconDeathCam.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "hudItems.SpawnBeaconObjective")
	self:setClass(CoD.SpawnBeaconDeathCam)
	self.id = "SpawnBeaconDeathCam"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpawnLocationBackingAdd = LUI.UIImage.new(0, 0, 0, 180, 0, 0, 0, 35)
	SpawnLocationBackingAdd:setRGB(0.11, 0.11, 0.11)
	self:addElement(SpawnLocationBackingAdd)
	self.SpawnLocationBackingAdd = SpawnLocationBackingAdd
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 180, 0, 0, 0, 35)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local DotTiledBacking2 = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 180, 0, 0, 0, 35)
	DotTiledBacking2:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DotTiledBacking2)
	self.DotTiledBacking2 = DotTiledBacking2
	local Name = LUI.UIText.new(0.5, 0.5, -56, 84, 0.5, 0.5, -10, 11)
	Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_183F60BB7B4AED37"))
	Name:setTTF("0arame_mono_stencil")
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Name:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Name)
	self.Name = Name
	local ButtonBottomBracket9Slice = LUI.UIImage.new(0, 0, -4.5, 184.5, 1, 1, -5, 7)
	ButtonBottomBracket9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_bottom_line"))
	ButtonBottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonBottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomBracket9Slice:setupNineSliceShader(120, 12)
	self:addElement(ButtonBottomBracket9Slice)
	self.ButtonBottomBracket9Slice = ButtonBottomBracket9Slice
	local SpawnLocationDetail = CoD.SpawnSelectionLabelWarning.new(f1_arg0, f1_arg1, 0, 0, 25, 180, 0, 0, -20, 0)
	self:addElement(SpawnLocationDetail)
	self.SpawnLocationDetail = SpawnLocationDetail
	local BeaconImage = LUI.UIImage.new(0, 0, 2.5, 32.5, 0, 0, 3, 33)
	BeaconImage:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	BeaconImage:setImage(RegisterImage(@"icons_equipment_spawnbeacon"))
	self:addElement(BeaconImage)
	self.BeaconImage = BeaconImage
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1) then
					f2_local0 = IsVisibilityBitSet(f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"])
					if f2_local0 then
						f2_local0 = CoD.SpawnSelectionUtility.IsSpawnBeaconActive(f1_arg1, self.SpawnLocationDetail)
					end
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.showSpawnSelect"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f6_arg2, f6_arg3, f6_arg4)
		if IsSelfInState(self, "Visible") then
			UpdateElementState(self, "SpawnLocationDetail", controller)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.SpawnBeaconObjective", function(model)
		local f7_local0 = self
		CoD.SpawnSelectionUtility.SetSpawnBeaconObjectiveModel(self.SpawnLocationDetail, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnBeaconDeathCam.__resetProperties = function(f8_arg0)
	f8_arg0.BeaconImage:completeAnimation()
	f8_arg0.SpawnLocationDetail:completeAnimation()
	f8_arg0.ButtonBottomBracket9Slice:completeAnimation()
	f8_arg0.Name:completeAnimation()
	f8_arg0.DotTiledBacking2:completeAnimation()
	f8_arg0.DotTiledBacking:completeAnimation()
	f8_arg0.SpawnLocationBackingAdd:completeAnimation()
	f8_arg0.BeaconImage:setAlpha(1)
	f8_arg0.SpawnLocationDetail:setAlpha(1)
	f8_arg0.ButtonBottomBracket9Slice:setAlpha(1)
	f8_arg0.Name:setAlpha(1)
	f8_arg0.DotTiledBacking2:setAlpha(1)
	f8_arg0.DotTiledBacking:setAlpha(1)
	f8_arg0.SpawnLocationBackingAdd:setAlpha(1)
end
CoD.SpawnBeaconDeathCam.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(7)
			f9_arg0.SpawnLocationBackingAdd:completeAnimation()
			f9_arg0.SpawnLocationBackingAdd:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.SpawnLocationBackingAdd)
			f9_arg0.DotTiledBacking:completeAnimation()
			f9_arg0.DotTiledBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DotTiledBacking)
			f9_arg0.DotTiledBacking2:completeAnimation()
			f9_arg0.DotTiledBacking2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DotTiledBacking2)
			f9_arg0.Name:completeAnimation()
			f9_arg0.Name:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Name)
			f9_arg0.ButtonBottomBracket9Slice:completeAnimation()
			f9_arg0.ButtonBottomBracket9Slice:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ButtonBottomBracket9Slice)
			f9_arg0.SpawnLocationDetail:completeAnimation()
			f9_arg0.SpawnLocationDetail:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.SpawnLocationDetail)
			f9_arg0.BeaconImage:completeAnimation()
			f9_arg0.BeaconImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BeaconImage)
		end,
		Visible = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(7)
			local f10_local0 = function(f11_arg0)
				f10_arg0.SpawnLocationBackingAdd:beginAnimation(200)
				f10_arg0.SpawnLocationBackingAdd:setAlpha(1)
				f10_arg0.SpawnLocationBackingAdd:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.SpawnLocationBackingAdd:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.SpawnLocationBackingAdd:completeAnimation()
			f10_arg0.SpawnLocationBackingAdd:setAlpha(0)
			f10_local0(f10_arg0.SpawnLocationBackingAdd)
			local f10_local1 = function(f12_arg0)
				f10_arg0.DotTiledBacking:beginAnimation(200)
				f10_arg0.DotTiledBacking:setAlpha(1)
				f10_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.DotTiledBacking:completeAnimation()
			f10_arg0.DotTiledBacking:setAlpha(0)
			f10_local1(f10_arg0.DotTiledBacking)
			local f10_local2 = function(f13_arg0)
				f10_arg0.DotTiledBacking2:beginAnimation(200)
				f10_arg0.DotTiledBacking2:setAlpha(1)
				f10_arg0.DotTiledBacking2:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.DotTiledBacking2:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.DotTiledBacking2:completeAnimation()
			f10_arg0.DotTiledBacking2:setAlpha(0)
			f10_local2(f10_arg0.DotTiledBacking2)
			local f10_local3 = function(f14_arg0)
				f10_arg0.Name:beginAnimation(200)
				f10_arg0.Name:setAlpha(1)
				f10_arg0.Name:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Name:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Name:completeAnimation()
			f10_arg0.Name:setAlpha(0)
			f10_local3(f10_arg0.Name)
			local f10_local4 = function(f15_arg0)
				f10_arg0.ButtonBottomBracket9Slice:beginAnimation(200)
				f10_arg0.ButtonBottomBracket9Slice:setAlpha(1)
				f10_arg0.ButtonBottomBracket9Slice:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ButtonBottomBracket9Slice:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ButtonBottomBracket9Slice:completeAnimation()
			f10_arg0.ButtonBottomBracket9Slice:setAlpha(0)
			f10_local4(f10_arg0.ButtonBottomBracket9Slice)
			local f10_local5 = function(f16_arg0)
				f10_arg0.SpawnLocationDetail:beginAnimation(200)
				f10_arg0.SpawnLocationDetail:setAlpha(1)
				f10_arg0.SpawnLocationDetail:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.SpawnLocationDetail:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.SpawnLocationDetail:completeAnimation()
			f10_arg0.SpawnLocationDetail:setAlpha(0)
			f10_local5(f10_arg0.SpawnLocationDetail)
			local f10_local6 = function(f17_arg0)
				f10_arg0.BeaconImage:beginAnimation(200)
				f10_arg0.BeaconImage:setAlpha(1)
				f10_arg0.BeaconImage:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.BeaconImage:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.BeaconImage:completeAnimation()
			f10_arg0.BeaconImage:setAlpha(0)
			f10_local6(f10_arg0.BeaconImage)
		end,
	},
	Visible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(7)
			local f19_local0 = function(f20_arg0)
				f19_arg0.SpawnLocationBackingAdd:beginAnimation(200)
				f19_arg0.SpawnLocationBackingAdd:setAlpha(0)
				f19_arg0.SpawnLocationBackingAdd:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.SpawnLocationBackingAdd:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.SpawnLocationBackingAdd:completeAnimation()
			f19_arg0.SpawnLocationBackingAdd:setAlpha(1)
			f19_local0(f19_arg0.SpawnLocationBackingAdd)
			local f19_local1 = function(f21_arg0)
				f19_arg0.DotTiledBacking:beginAnimation(200)
				f19_arg0.DotTiledBacking:setAlpha(0)
				f19_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.DotTiledBacking:completeAnimation()
			f19_arg0.DotTiledBacking:setAlpha(1)
			f19_local1(f19_arg0.DotTiledBacking)
			local f19_local2 = function(f22_arg0)
				f19_arg0.DotTiledBacking2:beginAnimation(200)
				f19_arg0.DotTiledBacking2:setAlpha(0)
				f19_arg0.DotTiledBacking2:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.DotTiledBacking2:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.DotTiledBacking2:completeAnimation()
			f19_arg0.DotTiledBacking2:setAlpha(1)
			f19_local2(f19_arg0.DotTiledBacking2)
			local f19_local3 = function(f23_arg0)
				f19_arg0.Name:beginAnimation(200)
				f19_arg0.Name:setAlpha(0)
				f19_arg0.Name:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Name:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.Name:completeAnimation()
			f19_arg0.Name:setAlpha(1)
			f19_local3(f19_arg0.Name)
			local f19_local4 = function(f24_arg0)
				f19_arg0.ButtonBottomBracket9Slice:beginAnimation(200)
				f19_arg0.ButtonBottomBracket9Slice:setAlpha(0)
				f19_arg0.ButtonBottomBracket9Slice:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ButtonBottomBracket9Slice:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ButtonBottomBracket9Slice:completeAnimation()
			f19_arg0.ButtonBottomBracket9Slice:setAlpha(1)
			f19_local4(f19_arg0.ButtonBottomBracket9Slice)
			local f19_local5 = function(f25_arg0)
				f19_arg0.SpawnLocationDetail:beginAnimation(200)
				f19_arg0.SpawnLocationDetail:setAlpha(0)
				f19_arg0.SpawnLocationDetail:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.SpawnLocationDetail:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.SpawnLocationDetail:completeAnimation()
			f19_arg0.SpawnLocationDetail:setAlpha(1)
			f19_local5(f19_arg0.SpawnLocationDetail)
			local f19_local6 = function(f26_arg0)
				f19_arg0.BeaconImage:beginAnimation(200)
				f19_arg0.BeaconImage:setAlpha(0)
				f19_arg0.BeaconImage:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.BeaconImage:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.BeaconImage:completeAnimation()
			f19_arg0.BeaconImage:setAlpha(1)
			f19_local6(f19_arg0.BeaconImage)
		end,
	},
}
CoD.SpawnBeaconDeathCam.__onClose = function(f27_arg0)
	f27_arg0.DotTiledBacking:close()
	f27_arg0.DotTiledBacking2:close()
	f27_arg0.SpawnLocationDetail:close()
end
