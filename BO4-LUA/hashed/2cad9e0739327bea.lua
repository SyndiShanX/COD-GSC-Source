require("x64:569db342b25e6f7")
CoD.WZAAR_MeritContainer = InheritFrom(LUI.UIElement)
CoD.WZAAR_MeritContainer.__defaultWidth = 540
CoD.WZAAR_MeritContainer.__defaultHeight = 622
CoD.WZAAR_MeritContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_MeritContainer)
	self.id = "WZAAR_MeritContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Title = CoD.WZAAR_MeritContainerInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, -3, 625)
	Title:linkToElementModel(self, nil, false, function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	local Sound = LUI.UIElement.new(0, 0, 746.5, 778.5, 0, 0, -34.5, -2.5)
	Sound:setPlaySoundDirect(true)
	self:addElement(Sound)
	self.Sound = Sound
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "xpEarnedDuringMatch", 0)
			end,
		},
	})
	self:linkToElementModel(self, "xpEarnedDuringMatch", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xpEarnedDuringMatch",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsSelfInState(self, "Hidden") then
			HideWidget(element)
		elseif IsSelfInState(self, "DefaultState") then
			ShowWidget(element)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR_MeritContainer.__resetProperties = function(f6_arg0)
	f6_arg0.Title:completeAnimation()
	f6_arg0.Sound:completeAnimation()
	f6_arg0.Title:setAlpha(1)
	f6_arg0.Title:setScale(1, 1)
end
CoD.WZAAR_MeritContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Title:beginAnimation(400, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
				f7_arg0.Title:setAlpha(1)
				f7_arg0.Title:setScale(1, 1)
				f7_arg0.Title:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Title:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Title:completeAnimation()
			f7_arg0.Title:setAlpha(0)
			f7_arg0.Title:setScale(1.4, 1.4)
			f7_local0(f7_arg0.Title)
			f7_arg0.Sound:completeAnimation()
			f7_arg0.Sound:playSound("uin_wz_aar_box", f7_arg1)
			f7_arg0.clipFinished(f7_arg0.Sound)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Title:completeAnimation()
			f9_arg0.Title:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Title)
		end,
	},
}
CoD.WZAAR_MeritContainer.__onClose = function(f10_arg0)
	f10_arg0.Title:close()
end
