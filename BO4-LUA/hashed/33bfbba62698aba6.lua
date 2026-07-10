CoD.WarzonePlayerMarker = InheritFrom(LUI.UIElement)
CoD.WarzonePlayerMarker.__defaultWidth = 64
CoD.WarzonePlayerMarker.__defaultHeight = 64
CoD.WarzonePlayerMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzonePlayerMarker)
	self.id = "WarzonePlayerMarker"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MarkerImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MarkerImage:setImage(RegisterImage(@"ui_icon_minimap_warzone_waypoint"))
	self:addElement(MarkerImage)
	self.MarkerImage = MarkerImage
	local MarkerImageAnim = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MarkerImageAnim:setAlpha(0)
	MarkerImageAnim:setImage(RegisterImage(@"ui_icon_minimap_warzone_waypoint"))
	self:addElement(MarkerImageAnim)
	self.MarkerImageAnim = MarkerImageAnim
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzonePlayerMarker.__resetProperties = function(f6_arg0)
	f6_arg0.MarkerImage:completeAnimation()
	f6_arg0.MarkerImageAnim:completeAnimation()
	f6_arg0.MarkerImage:setAlpha(1)
	f6_arg0.MarkerImageAnim:setAlpha(0)
	f6_arg0.MarkerImageAnim:setScale(1, 1)
end
CoD.WarzonePlayerMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.MarkerImage:completeAnimation()
			f7_arg0.MarkerImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.MarkerImage)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
	KBM = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.MarkerImage:completeAnimation()
			f8_arg0.MarkerImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.MarkerImage)
			f8_arg0.MarkerImageAnim:completeAnimation()
			f8_arg0.MarkerImageAnim:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.MarkerImageAnim)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(800, Enum[@"luitween"][@"luitween_ease_both"])
					f11_arg0:setAlpha(0)
					f11_arg0:setScale(1.5, 1.5)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.MarkerImageAnim:beginAnimation(200)
				f9_arg0.MarkerImageAnim:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.MarkerImageAnim:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.MarkerImageAnim:completeAnimation()
			f9_arg0.MarkerImageAnim:setAlpha(1)
			f9_arg0.MarkerImageAnim:setScale(1, 1)
			f9_local0(f9_arg0.MarkerImageAnim)
			f9_arg0.nextClip = "DefaultClip"
		end,
	},
}
