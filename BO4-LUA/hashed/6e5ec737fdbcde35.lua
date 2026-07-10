require("x64:c3da42bd286b956")
require("x64:f7f78c2a715db3e")
CoD.AmmoWidgetZM_EquipmentContainer = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetZM_EquipmentContainer.__defaultWidth = 72
CoD.AmmoWidgetZM_EquipmentContainer.__defaultHeight = 59
CoD.AmmoWidgetZM_EquipmentContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetZM_EquipmentContainer)
	self.id = "AmmoWidgetZM_EquipmentContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bgbGlowOrangeOver = LUI.UIImage.new(0.5, 0.5, -128, 114, 0.5, 0.5, -215, 146)
	bgbGlowOrangeOver:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	bgbGlowOrangeOver:setAlpha(0)
	bgbGlowOrangeOver:setZRot(90)
	bgbGlowOrangeOver:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	bgbGlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(bgbGlowOrangeOver)
	self.bgbGlowOrangeOver = bgbGlowOrangeOver
	local TutorialHighlight = LUI.UIImage.new(0, 0, -37, 109, 0, 0, -81, 81)
	TutorialHighlight:setRGB(0.87, 0.07, 0.78)
	TutorialHighlight:setAlpha(0)
	self:addElement(TutorialHighlight)
	self.TutorialHighlight = TutorialHighlight
	local Equipment = CoD.AmmoWidgetZM_AbilityItem.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, 0, 59)
	Equipment.HeroAbilityUseString.KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_260A07A7C41A40AA"))
	Equipment.HeroAbilityUseString.GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_260A07A7C41A40AA"))
	Equipment:subscribeToGlobalModel(f1_arg1, "LethalOffhands", "0", function(model)
		Equipment:setModel(model, f1_arg1)
	end)
	self:addElement(Equipment)
	self.Equipment = Equipment
	local bgbAbilitySwirl = LUI.UIImage.new(0.5, 0.5, -60.5, 60.5, 0, 0, -31, 88)
	bgbAbilitySwirl:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	bgbAbilitySwirl:setAlpha(0)
	bgbAbilitySwirl:setScale(1.65, 1.65)
	bgbAbilitySwirl:setImage(RegisterImage(@"uie_t7_core_hud_ammowidget_abilityswirl"))
	bgbAbilitySwirl:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(bgbAbilitySwirl)
	self.bgbAbilitySwirl = bgbAbilitySwirl
	local ZMEquipmentItemCounter = CoD.ZMEquipmentItemCounter.new(f1_arg0, f1_arg1, 0, 0, 36, 72, 0, 0, 40, 64)
	ZMEquipmentItemCounter:subscribeToGlobalModel(f1_arg1, "LethalOffhands", "0", function(model)
		ZMEquipmentItemCounter:setModel(model, f1_arg1)
	end)
	ZMEquipmentItemCounter:subscribeToGlobalModel(f1_arg1, "LethalOffhands", "0.ammo", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ZMEquipmentItemCounter.Quantity:setText(CoD.BaseUtility.AlreadyLocalized(f4_local0))
		end
	end)
	self:addElement(ZMEquipmentItemCounter)
	self.ZMEquipmentItemCounter = ZMEquipmentItemCounter
	self:mergeStateConditions({
		{
			stateName = "HiddenTutorial",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztutorial") and CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.ztut.showEquipment", 0)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["hudItems.ztut.showEquipment"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.ztut.showEquipment",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetZM_EquipmentContainer.__resetProperties = function(f7_arg0)
	f7_arg0.Equipment:completeAnimation()
	f7_arg0.ZMEquipmentItemCounter:completeAnimation()
	f7_arg0.bgbAbilitySwirl:completeAnimation()
	f7_arg0.bgbGlowOrangeOver:completeAnimation()
	f7_arg0.Equipment:setAlpha(1)
	f7_arg0.ZMEquipmentItemCounter:setAlpha(1)
	f7_arg0.bgbAbilitySwirl:setLeftRight(0.5, 0.5, -60.5, 60.5)
	f7_arg0.bgbAbilitySwirl:setTopBottom(0, 0, -31, 88)
	f7_arg0.bgbAbilitySwirl:setAlpha(0)
	f7_arg0.bgbAbilitySwirl:setZRot(0)
	f7_arg0.bgbGlowOrangeOver:setLeftRight(0.5, 0.5, -128, 114)
	f7_arg0.bgbGlowOrangeOver:setTopBottom(0.5, 0.5, -215, 146)
	f7_arg0.bgbGlowOrangeOver:setAlpha(0)
end
CoD.AmmoWidgetZM_EquipmentContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenTutorial = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.Equipment:completeAnimation()
			f9_arg0.Equipment:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Equipment)
			f9_arg0.ZMEquipmentItemCounter:completeAnimation()
			f9_arg0.ZMEquipmentItemCounter:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ZMEquipmentItemCounter)
		end,
		DefaultState = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							local f14_local0 = function(f15_arg0)
								local f15_local0 = function(f16_arg0)
									local f16_local0 = function(f17_arg0)
										f17_arg0:beginAnimation(300)
										f17_arg0:setAlpha(0)
										f17_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
									end
									f16_arg0:beginAnimation(119)
									f16_arg0:setAlpha(0.7)
									f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
								end
								f15_arg0:beginAnimation(130)
								f15_arg0:setAlpha(0)
								f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
							end
							f14_arg0:beginAnimation(119)
							f14_arg0:setAlpha(0.7)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
						end
						f13_arg0:beginAnimation(130)
						f13_arg0:setAlpha(0)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(199)
					f12_arg0:setAlpha(0.7)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f10_arg0.bgbGlowOrangeOver:beginAnimation(330)
				f10_arg0.bgbGlowOrangeOver:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.bgbGlowOrangeOver:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.bgbGlowOrangeOver:completeAnimation()
			f10_arg0.bgbGlowOrangeOver:setLeftRight(0.5, 0.5, -128, 114)
			f10_arg0.bgbGlowOrangeOver:setTopBottom(0.5, 0.5, -215, 146)
			f10_arg0.bgbGlowOrangeOver:setAlpha(0)
			f10_local0(f10_arg0.bgbGlowOrangeOver)
			local f10_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(340)
						f20_arg0:setAlpha(1)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(329)
					f19_arg0:setAlpha(0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f18_arg0:beginAnimation(330)
				f18_arg0:setAlpha(1)
				f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f10_arg0.Equipment:beginAnimation(330)
			f10_arg0.Equipment:setAlpha(0)
			f10_arg0.Equipment:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.Equipment:registerEventHandler("transition_complete_keyframe", f10_local1)
			local f10_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(199)
					f22_arg0:setAlpha(0)
					f22_arg0:setZRot(360)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.bgbAbilitySwirl:beginAnimation(330)
				f10_arg0.bgbAbilitySwirl:setAlpha(1)
				f10_arg0.bgbAbilitySwirl:setZRot(240)
				f10_arg0.bgbAbilitySwirl:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.bgbAbilitySwirl:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f10_arg0.bgbAbilitySwirl:completeAnimation()
			f10_arg0.bgbAbilitySwirl:setLeftRight(0.5, 0.5, -60.5, 60.5)
			f10_arg0.bgbAbilitySwirl:setTopBottom(0, 0, -59.5, 59.5)
			f10_arg0.bgbAbilitySwirl:setAlpha(0)
			f10_arg0.bgbAbilitySwirl:setZRot(0)
			f10_local2(f10_arg0.bgbAbilitySwirl)
		end,
	},
}
CoD.AmmoWidgetZM_EquipmentContainer.__onClose = function(f23_arg0)
	f23_arg0.Equipment:close()
	f23_arg0.ZMEquipmentItemCounter:close()
end
