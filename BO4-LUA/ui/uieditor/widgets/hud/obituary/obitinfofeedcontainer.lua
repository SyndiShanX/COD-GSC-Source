require("x64:efa0348a97c04f")
require("x64:902a4f3984494c3")
CoD.ObitInfoFeedContainer = InheritFrom(LUI.UIElement)
CoD.ObitInfoFeedContainer.__defaultWidth = 500
CoD.ObitInfoFeedContainer.__defaultHeight = 360
CoD.ObitInfoFeedContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ObitInfoFeedContainer)
	self.id = "ObitInfoFeedContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Obituary = CoD.Obituary.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 150, 360)
	self:addElement(Obituary)
	self.Obituary = Obituary
	local Console = CoD.Console.new(f1_arg0, f1_arg1, 0, 0, 0, 1020, 0, 0, 0, 150)
	self:addElement(Console)
	self.Console = Console
	self:mergeStateConditions({
		{
			stateName = "CodCasterVisible",
			condition = function(menu, element, event)
				local f2_local0 = IsCodCaster(f1_arg1)
				if f2_local0 then
					f2_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_calloutcards", 1)
					if f2_local0 then
						f2_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_killfeed", 1)
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "CodCasterVisibleConsole",
			condition = function(menu, element, event)
				local f3_local0 = IsCodCaster(f1_arg1)
				if f3_local0 then
					f3_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_calloutcards", 1)
					if f3_local0 then
						f3_local0 = not CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_killfeed", 1)
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "CodCasterVisibleObituary",
			condition = function(menu, element, event)
				local f4_local0 = IsCodCaster(f1_arg1)
				if f4_local0 then
					if not CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_calloutcards", 1) then
						f4_local0 = CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_killfeed", 1)
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "VisibleKillcam",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"]) and not IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["factions.isCoDCaster"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.profileSettingsUpdated, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ObitInfoFeedContainer.__resetProperties = function(f10_arg0)
	f10_arg0.Obituary:completeAnimation()
	f10_arg0.Console:completeAnimation()
	f10_arg0.Obituary:setTopBottom(0, 0, 150, 360)
	f10_arg0.Obituary:setAlpha(1)
	f10_arg0.Console:setTopBottom(0, 0, 0, 150)
	f10_arg0.Console:setAlpha(1)
end
CoD.ObitInfoFeedContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Obituary:completeAnimation()
			f11_arg0.Obituary:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Obituary)
			f11_arg0.Console:completeAnimation()
			f11_arg0.Console:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Console)
		end,
	},
	CodCasterVisible = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	CodCasterVisibleConsole = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Obituary:completeAnimation()
			f13_arg0.Obituary:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Obituary)
		end,
	},
	CodCasterVisibleObituary = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Console:completeAnimation()
			f14_arg0.Console:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Console)
		end,
	},
	VisibleKillcam = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.Obituary:completeAnimation()
			f15_arg0.Obituary:setTopBottom(0, 0, 75, 285)
			f15_arg0.clipFinished(f15_arg0.Obituary)
			f15_arg0.Console:completeAnimation()
			f15_arg0.Console:setTopBottom(0, 0, -75, 75)
			f15_arg0.clipFinished(f15_arg0.Console)
		end,
	},
	Visible = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		VisibleKillcam = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(19)
						f20_arg0:setAlpha(1)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(180)
					f19_arg0:setTopBottom(0, 0, 75, 285)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f17_arg0.Obituary:beginAnimation(20)
				f17_arg0.Obituary:setAlpha(0)
				f17_arg0.Obituary:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Obituary:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.Obituary:completeAnimation()
			f17_arg0.Obituary:setTopBottom(0, 0, 150, 360)
			f17_arg0.Obituary:setAlpha(1)
			f17_local0(f17_arg0.Obituary)
			local f17_local1 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						f23_arg0:beginAnimation(19)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
					end
					f22_arg0:beginAnimation(180)
					f22_arg0:setTopBottom(0, 0, -75, 75)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f17_arg0.Console:beginAnimation(20)
				f17_arg0.Console:setAlpha(0)
				f17_arg0.Console:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Console:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f17_arg0.Console:completeAnimation()
			f17_arg0.Console:setTopBottom(0, 0, 0, 150)
			f17_arg0.Console:setAlpha(1)
			f17_local1(f17_arg0.Console)
		end,
	},
}
CoD.ObitInfoFeedContainer.__onClose = function(f24_arg0)
	f24_arg0.Obituary:close()
	f24_arg0.Console:close()
end
