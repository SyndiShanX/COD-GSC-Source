require("x64:6a82c78839bab87")
CoD.DirectorPreGameSetUpMatch = InheritFrom(LUI.UIElement)
CoD.DirectorPreGameSetUpMatch.__defaultWidth = 382
CoD.DirectorPreGameSetUpMatch.__defaultHeight = 180
CoD.DirectorPreGameSetUpMatch.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPreGameSetUpMatch)
	self.id = "DirectorPreGameSetUpMatch"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MapImage = CoD.DirectorPreGameSetUpMatchContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 382, 0, 0, 0, 180)
	MapImage:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "Unselectable")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	MapImage.GamemodeIcon:setScale(0.9, 0.9)
	self:addElement(MapImage)
	self.MapImage = MapImage
	self:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f6_arg2, f6_arg3, f6_arg4)
		UpdateElementState(self, "MapImage", controller)
	end)
	MapImage.id = "MapImage"
	self.__defaultFocus = MapImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPreGameSetUpMatch.__resetProperties = function(f7_arg0)
	f7_arg0.MapImage:completeAnimation()
	f7_arg0.MapImage:setAlpha(1)
	f7_arg0.MapImage:setScale(1, 1)
end
CoD.DirectorPreGameSetUpMatch.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.MapImage:completeAnimation()
			f8_arg0.MapImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.MapImage)
		end,
	},
	Unselectable = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.MapImage:completeAnimation()
			f11_arg0.MapImage:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.MapImage)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.MapImage:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f12_arg0.MapImage:setScale(1.05, 1.05)
				f12_arg0.MapImage:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.MapImage:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.MapImage:completeAnimation()
			f12_arg0.MapImage:setScale(1, 1)
			f12_local0(f12_arg0.MapImage)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.MapImage:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
				f14_arg0.MapImage:setScale(1, 1)
				f14_arg0.MapImage:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.MapImage:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.MapImage:completeAnimation()
			f14_arg0.MapImage:setScale(1.05, 1.05)
			f14_local0(f14_arg0.MapImage)
		end,
	},
}
CoD.DirectorPreGameSetUpMatch.__onClose = function(f16_arg0)
	f16_arg0.MapImage:close()
end
