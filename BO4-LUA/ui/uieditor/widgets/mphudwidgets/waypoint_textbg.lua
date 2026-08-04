require("ui/uieditor/widgets/hud/corner9slice")
require("ui/uieditor/widgets/mphudwidgets/waypoint_contestedarrowwidget")
require("ui/uieditor/widgets/mphudwidgets/waypoint_textwithbg")
CoD.Waypoint_TextBG = InheritFrom(LUI.UIElement)
CoD.Waypoint_TextBG.__defaultWidth = 120
CoD.Waypoint_TextBG.__defaultHeight = 31
CoD.Waypoint_TextBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Waypoint_TextBG)
	self.id = "Waypoint_TextBG"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arrowTExt = LUI.UIImage.new(0.5, 0.5, -15, 15, 1, 1, -9, 0)
	arrowTExt:setImage(RegisterImage("uie_t7_hud_waypoints_bg_arrow"))
	self:addElement(arrowTExt)
	self.arrowTExt = arrowTExt
	local WaypointTextWithBG = CoD.Waypoint_TextWithBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 1, 1, -30, 8)
	self:addElement(WaypointTextWithBG)
	self.WaypointTextWithBG = WaypointTextWithBG
	local DistanceTextWithBG = CoD.Waypoint_TextWithBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 1, 1, -30, 8)
	DistanceTextWithBG:setAlpha(0)
	DistanceTextWithBG:linkToElementModel(self, "distanceText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DistanceTextWithBG.text:setText(LocalizeIntoStringIfNotEmpty(@"hash_37235825812D46C6", f2_local0))
		end
	end)
	self:addElement(DistanceTextWithBG)
	self.DistanceTextWithBG = DistanceTextWithBG
	local ContestedText = LUI.UIText.new(0, 0, -40, 160, 0, 0, 5.5, 35.5)
	ContestedText:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	ContestedText:setAlpha(0)
	ContestedText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/waypoint_contested"))
	ContestedText:setTTF("ttmussels_regular")
	ContestedText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	ContestedText:setShaderVector(0, 0.8, 0, 0, 0)
	ContestedText:setShaderVector(1, 0, 0, 0, 0)
	ContestedText:setShaderVector(2, 1, 0, 0, 0.4)
	ContestedText:setLetterSpacing(2)
	ContestedText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	ContestedText:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	ContestedText:setBackingType(1)
	ContestedText:setBackingWidget(CoD.Corner9Slice, f1_arg0, f1_arg1)
	ContestedText:setBackingAlpha(0.7)
	ContestedText:setBackingXPadding(12)
	ContestedText:setBackingYPadding(4)
	self:addElement(ContestedText)
	self.ContestedText = ContestedText
	local Arrow = CoD.Waypoint_ContestedArrowWidget.new(f1_arg0, f1_arg1, 0, 0, 161, 185, 0, 0, 8.5, 32.5)
	Arrow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	Arrow:setAlpha(0)
	self:addElement(Arrow)
	self.Arrow = Arrow
	local Arrow2 = CoD.Waypoint_ContestedArrowWidget.new(f1_arg0, f1_arg1, 0, 0, -64, -40, 0, 0, 8.5, 32.5)
	Arrow2:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	Arrow2:setAlpha(0)
	Arrow2:setYRot(180)
	self:addElement(Arrow2)
	self.Arrow2 = Arrow2
	self:mergeStateConditions({
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Protect",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ShowDistance",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "distanceText") and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "text")
				if f6_local0 then
					if not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "distanceText") then
						f6_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clamped")
					else
						f6_local0 = false
					end
				end
				return f6_local0
			end,
		},
	})
	self:linkToElementModel(self, "distanceText", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "distanceText",
		})
	end)
	self:linkToElementModel(self, "clamped", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	self:linkToElementModel(self, "text", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "text",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Waypoint_TextBG.__resetProperties = function(f10_arg0)
	f10_arg0.arrowTExt:completeAnimation()
	f10_arg0.WaypointTextWithBG:completeAnimation()
	f10_arg0.ContestedText:completeAnimation()
	f10_arg0.Arrow2:completeAnimation()
	f10_arg0.Arrow:completeAnimation()
	f10_arg0.DistanceTextWithBG:completeAnimation()
	f10_arg0.arrowTExt:setLeftRight(0.5, 0.5, -15, 15)
	f10_arg0.arrowTExt:setTopBottom(1, 1, -9, 0)
	f10_arg0.arrowTExt:setAlpha(1)
	f10_arg0.WaypointTextWithBG:setAlpha(1)
	f10_arg0.ContestedText:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	f10_arg0.ContestedText:setAlpha(0)
	f10_arg0.ContestedText:setScale(1, 1)
	f10_arg0.ContestedText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/waypoint_contested"))
	f10_arg0.Arrow2:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	f10_arg0.Arrow2:setAlpha(0)
	f10_arg0.Arrow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	f10_arg0.Arrow:setAlpha(0)
	f10_arg0.DistanceTextWithBG:setAlpha(0)
end
CoD.Waypoint_TextBG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			f11_arg0.arrowTExt:completeAnimation()
			f11_arg0.arrowTExt:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.arrowTExt)
			f11_arg0.WaypointTextWithBG:completeAnimation()
			f11_arg0.WaypointTextWithBG:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.WaypointTextWithBG)
			f11_arg0.ContestedText:completeAnimation()
			f11_arg0.ContestedText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ContestedText)
			f11_arg0.Arrow:completeAnimation()
			f11_arg0.Arrow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Arrow)
			f11_arg0.Arrow2:completeAnimation()
			f11_arg0.Arrow2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Arrow2)
		end,
	},
	Contested = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			f12_arg0.arrowTExt:completeAnimation()
			f12_arg0.arrowTExt:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.arrowTExt)
			f12_arg0.WaypointTextWithBG:completeAnimation()
			f12_arg0.WaypointTextWithBG:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.WaypointTextWithBG)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							f16_arg0:beginAnimation(490)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
						end
						f15_arg0:beginAnimation(30, Enum[@"luitween"][@"luitween_ease_both"])
						f15_arg0:setScale(1, 1)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(80, Enum[@"luitween"][@"luitween_ease_both"])
					f14_arg0:setScale(1.1, 1.1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f12_arg0.ContestedText:beginAnimation(380)
				f12_arg0.ContestedText:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ContestedText:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.ContestedText:completeAnimation()
			f12_arg0.ContestedText:setAlpha(1)
			f12_arg0.ContestedText:setScale(1, 1)
			f12_arg0.ContestedText:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/waypoint_contested"))
			f12_local0(f12_arg0.ContestedText)
			f12_arg0.Arrow:completeAnimation()
			f12_arg0.Arrow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
			f12_arg0.Arrow:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Arrow)
			f12_arg0.Arrow2:completeAnimation()
			f12_arg0.Arrow2:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
			f12_arg0.Arrow2:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Arrow2)
			f12_arg0.nextClip = "DefaultClip"
		end,
	},
	Protect = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			f17_arg0.arrowTExt:completeAnimation()
			f17_arg0.arrowTExt:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.arrowTExt)
			f17_arg0.WaypointTextWithBG:completeAnimation()
			f17_arg0.WaypointTextWithBG:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.WaypointTextWithBG)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(470)
					f19_arg0:setScale(1, 1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.ContestedText:beginAnimation(530)
				f17_arg0.ContestedText:setScale(1.4, 1.4)
				f17_arg0.ContestedText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ContestedText:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.ContestedText:completeAnimation()
			f17_arg0.ContestedText:setRGB(0.97, 0.92, 0.49)
			f17_arg0.ContestedText:setAlpha(1)
			f17_arg0.ContestedText:setScale(1, 1)
			f17_arg0.ContestedText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/waypoint_protect"))
			f17_local0(f17_arg0.ContestedText)
			f17_arg0.Arrow:completeAnimation()
			f17_arg0.Arrow:setRGB(0.97, 0.92, 0.49)
			f17_arg0.Arrow:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.Arrow)
			f17_arg0.Arrow2:completeAnimation()
			f17_arg0.Arrow2:setRGB(0.97, 0.92, 0.49)
			f17_arg0.Arrow2:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.Arrow2)
			f17_arg0.nextClip = "DefaultClip"
		end,
	},
	ShowDistance = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(6)
			f20_arg0.arrowTExt:completeAnimation()
			f20_arg0.arrowTExt:setLeftRight(0.5, 0.5, -15, 15)
			f20_arg0.arrowTExt:setTopBottom(1, 1, -9, 0)
			f20_arg0.arrowTExt:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.arrowTExt)
			f20_arg0.WaypointTextWithBG:completeAnimation()
			f20_arg0.WaypointTextWithBG:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.WaypointTextWithBG)
			f20_arg0.DistanceTextWithBG:completeAnimation()
			f20_arg0.DistanceTextWithBG:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.DistanceTextWithBG)
			f20_arg0.ContestedText:completeAnimation()
			f20_arg0.ContestedText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ContestedText)
			f20_arg0.Arrow:completeAnimation()
			f20_arg0.Arrow:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Arrow)
			f20_arg0.Arrow2:completeAnimation()
			f20_arg0.Arrow2:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Arrow2)
		end,
	},
	Show = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(5)
			f21_arg0.arrowTExt:completeAnimation()
			f21_arg0.arrowTExt:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.arrowTExt)
			f21_arg0.WaypointTextWithBG:completeAnimation()
			f21_arg0.WaypointTextWithBG:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.WaypointTextWithBG)
			f21_arg0.ContestedText:completeAnimation()
			f21_arg0.ContestedText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ContestedText)
			f21_arg0.Arrow:completeAnimation()
			f21_arg0.Arrow:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Arrow)
			f21_arg0.Arrow2:completeAnimation()
			f21_arg0.Arrow2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Arrow2)
		end,
	},
}
CoD.Waypoint_TextBG.__onClose = function(f22_arg0)
	f22_arg0.WaypointTextWithBG:close()
	f22_arg0.DistanceTextWithBG:close()
	f22_arg0.Arrow:close()
	f22_arg0.Arrow2:close()
end
