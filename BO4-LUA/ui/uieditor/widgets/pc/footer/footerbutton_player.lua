require("ui/uieditor/widgets/pc/footer/footerbutton_player_emblem")
require("ui/uieditor/widgets/pc/footer/footerbutton_player_internal")
require("ui/uieditor/widgets/pc/footer/footerbutton_player_newbreadcrumbcount")
require("ui/uieditor/widgets/pc/utility/verticallistspacer")
CoD.FooterButton_Player = InheritFrom(LUI.UIElement)
CoD.FooterButton_Player.__defaultWidth = 150
CoD.FooterButton_Player.__defaultHeight = 54
CoD.FooterButton_Player.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.FooterButton_Player)
	self.id = "FooterButton_Player"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Internal = CoD.FooterButton_Player_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Internal)
	self.Internal = Internal
	local Spacer3 = CoD.FooterButton_Player_NewBreadcrumbCount.new(f1_arg0, f1_arg1, 0, 0, 0, 9, 0, 0, 0, 54)
	self:addElement(Spacer3)
	self.Spacer3 = Spacer3
	local emblem2 = CoD.FooterButton_Player_Emblem.new(f1_arg0, f1_arg1, 0, 0, 9, 51, 0, 0, 3, 45)
	self:addElement(emblem2)
	self.emblem2 = emblem2
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 51, 70, 0, 0, 0, 54)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local label = LUI.UIText.new(0.5, 0.5, -5, 115, 0.5, 0.5, -15.5, 5.5)
	label:setRGB(0.58, 0.56, 0.49)
	label:setAlpha(0.8)
	label:setTTF("notosans_bold")
	label:setLetterSpacing(1)
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	label:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge.gamertag", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			label:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(label)
	self.label = label
	local Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 190, 207, 0, 0, 0, 54)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1)
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9.LockUIShortcutInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	if CoD.isPC then
		Internal.id = "Internal"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	CoD.PCUtility.SetupButtonPromptForPC(self, f1_arg1, f1_arg0)
	DisableKeyboardNavigationByElement(self)
	return self
end
CoD.FooterButton_Player.__resetProperties = function(f7_arg0)
	f7_arg0.label:completeAnimation()
	f7_arg0.emblem2:completeAnimation()
	f7_arg0.Internal:completeAnimation()
	f7_arg0.Spacer3:completeAnimation()
	f7_arg0.Spacer:completeAnimation()
	f7_arg0.Spacer2:completeAnimation()
	f7_arg0.label:setRGB(0.58, 0.56, 0.49)
	f7_arg0.label:setAlpha(0.8)
	f7_arg0.emblem2:setAlpha(1)
	f7_arg0.Internal:setAlpha(1)
	f7_arg0.Spacer3:setAlpha(1)
	f7_arg0.Spacer:setAlpha(1)
	f7_arg0.Spacer2:setAlpha(1)
end
CoD.FooterButton_Player.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.emblem2:completeAnimation()
			f9_arg0.emblem2:setAlpha(0.2)
			f9_arg0.clipFinished(f9_arg0.emblem2)
			f9_arg0.label:completeAnimation()
			f9_arg0.label:setAlpha(0.2)
			f9_arg0.clipFinished(f9_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		Hide = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.label:completeAnimation()
			f11_arg0.label:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.label)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.label:completeAnimation()
			f12_arg0.label:setRGB(1, 0.87, 0.56)
			f12_arg0.label:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.label)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.label:beginAnimation(100)
				f13_arg0.label:setRGB(1, 0.87, 0.56)
				f13_arg0.label:setAlpha(1)
				f13_arg0.label:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.label:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.label:completeAnimation()
			f13_arg0.label:setRGB(0.58, 0.56, 0.49)
			f13_arg0.label:setAlpha(0.8)
			f13_local0(f13_arg0.label)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.label:beginAnimation(200)
				f15_arg0.label:setRGB(0.58, 0.56, 0.49)
				f15_arg0.label:setAlpha(0.8)
				f15_arg0.label:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.label:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.label:completeAnimation()
			f15_arg0.label:setRGB(1, 0.87, 0.56)
			f15_arg0.label:setAlpha(1)
			f15_local0(f15_arg0.label)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(6)
			f17_arg0.Internal:completeAnimation()
			f17_arg0.Internal:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Internal)
			f17_arg0.Spacer3:completeAnimation()
			f17_arg0.Spacer3:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Spacer3)
			f17_arg0.emblem2:completeAnimation()
			f17_arg0.emblem2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.emblem2)
			f17_arg0.Spacer:completeAnimation()
			f17_arg0.Spacer:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Spacer)
			f17_arg0.label:completeAnimation()
			f17_arg0.label:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.label)
			f17_arg0.Spacer2:completeAnimation()
			f17_arg0.Spacer2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Spacer2)
		end,
	},
}
if not CoD.isPC then
	CoD.FooterButton_Player.__clipsPerState.Enabled.ChildFocus = nil
	CoD.FooterButton_Player.__clipsPerState.Enabled.GainChildFocus = nil
	CoD.FooterButton_Player.__clipsPerState.Enabled.LoseChildFocus = nil
end
CoD.FooterButton_Player.__onClose = function(f18_arg0)
	f18_arg0.Internal:close()
	f18_arg0.Spacer3:close()
	f18_arg0.emblem2:close()
	f18_arg0.Spacer:close()
	f18_arg0.label:close()
	f18_arg0.Spacer2:close()
end
