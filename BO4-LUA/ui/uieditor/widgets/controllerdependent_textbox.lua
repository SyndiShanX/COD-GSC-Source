require("ui/uieditor/widgets/pc/hud/hud_keypromptframe")
require("ui/uieditor/widgets/pc/hud/hud_keypromptframe_ability")
require("ui/uieditor/widgets/pc/hud/hud_keypromptframe_scorestreak")
require("ui/uieditor/widgets/pc/hud/hud_keypromptframe_ultimate")
require("ui/uieditor/widgets/pc/hud/keypromptbacking")
CoD.ControllerDependent_TextBox = InheritFrom(LUI.UIElement)
CoD.ControllerDependent_TextBox.__defaultWidth = 89
CoD.ControllerDependent_TextBox.__defaultHeight = 22
CoD.ControllerDependent_TextBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ControllerDependent_TextBox)
	self.id = "ControllerDependent_TextBox"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AbilityFrame = nil
	AbilityFrame = CoD.HUD_KeyPromptFrame_Ability.new(f1_arg0, f1_arg1, 0.5, 0.5, -33.5, 33.5, 0.5, 0.5, -33, 13)
	AbilityFrame:setAlpha(0)
	self:addElement(AbilityFrame)
	self.AbilityFrame = AbilityFrame
	local Frame = nil
	Frame = CoD.HUD_KeyPromptFrame.new(f1_arg0, f1_arg1, 0.37, 0.37, -25, 47, 1.05, 1.05, -41, -1)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local UltimateFrame = nil
	UltimateFrame = CoD.HUD_KeyPromptFrame_Ultimate.new(f1_arg0, f1_arg1, 0.5, 0.5, -44, 46, 0.5, 0.5, -28, 42)
	UltimateFrame:setAlpha(0)
	self:addElement(UltimateFrame)
	self.UltimateFrame = UltimateFrame
	local ScoreStreakFrame = nil
	ScoreStreakFrame = CoD.HUD_KeyPromptFrame_ScoreStreak.new(f1_arg0, f1_arg1, 0.5, 0.5, -48.5, 28.5, 0.5, 0.5, -25, 11)
	ScoreStreakFrame:setAlpha(0)
	self:addElement(ScoreStreakFrame)
	self.ScoreStreakFrame = ScoreStreakFrame
	local KBMText = nil
	KBMText = LUI.UIText.new(0, 0, 0, 89, 0, 0, -8, 14)
	KBMText:setAlpha(0)
	KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	KBMText:setTTF("ttmussels_demibold")
	KBMText:setLetterSpacing(-2)
	KBMText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	KBMText:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	self:addElement(KBMText)
	self.KBMText = KBMText
	local GamepadText = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	GamepadText:setAlpha(0.8)
	GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	GamepadText:setTTF("default")
	GamepadText:setLetterSpacing(-1)
	GamepadText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GamepadText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(GamepadText)
	self.GamepadText = GamepadText
	self:mergeStateConditions({
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f4_local0 = Engine.IsVisibilityBitSet(f1_arg1, Enum.UIVisibilityBit[@"bit_in_killcam"])
				if not f4_local0 then
					f4_local0 = Engine.IsVisibilityBitSet(f1_arg1, Enum.UIVisibilityBit[@"bit_play_of_the_match"])
				end
				return f4_local0
			end,
		},
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "KeyboardAndMouseAbility",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "KeyboardAndMouseUltimate",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "KeyboardAndMouseScoreStreak",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "KeyboardAndMouseAbilityWZ",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "PCGamepadReadyEvents",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "KeyboardAndMouseZM",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden2",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_in_killcam"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_in_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_play_of_the_match"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_play_of_the_match"],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f15_arg1)
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ControllerDependent_TextBox.__resetProperties = function(f17_arg0)
	f17_arg0.GamepadText:completeAnimation()
	f17_arg0.KBMText:completeAnimation()
	f17_arg0.AbilityFrame:completeAnimation()
	f17_arg0.Frame:completeAnimation()
	f17_arg0.UltimateFrame:completeAnimation()
	f17_arg0.ScoreStreakFrame:completeAnimation()
	f17_arg0.GamepadText:setLeftRight(0, 1, 0, 0)
	f17_arg0.GamepadText:setTopBottom(0, 1, 0, 0)
	f17_arg0.GamepadText:setAlpha(0.8)
	f17_arg0.KBMText:setLeftRight(0, 0, 0, 89)
	f17_arg0.KBMText:setTopBottom(0, 0, -8, 14)
	f17_arg0.KBMText:setAlpha(0)
	f17_arg0.KBMText:setLetterSpacing(-2)
	f17_arg0.KBMText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	f17_arg0.AbilityFrame:setLeftRight(0.5, 0.5, -33.5, 33.5)
	f17_arg0.AbilityFrame:setTopBottom(0.5, 0.5, -33, 13)
	f17_arg0.AbilityFrame:setAlpha(0)
	f17_arg0.Frame:setLeftRight(0.37, 0.37, -25, 47)
	f17_arg0.Frame:setTopBottom(1.05, 1.05, -41, -1)
	f17_arg0.Frame:setAlpha(0)
	f17_arg0.UltimateFrame:setLeftRight(0.5, 0.5, -44, 46)
	f17_arg0.UltimateFrame:setTopBottom(0.5, 0.5, -28, 42)
	f17_arg0.UltimateFrame:setAlpha(0)
	f17_arg0.ScoreStreakFrame:setAlpha(0)
end
CoD.ControllerDependent_TextBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.GamepadText:completeAnimation()
			f19_arg0.GamepadText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.GamepadText)
		end,
	},
	Visible = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.GamepadText:completeAnimation()
			f20_arg0.GamepadText:setAlpha(0.8)
			f20_arg0.clipFinished(f20_arg0.GamepadText)
		end,
	},
	Hidden = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.GamepadText:completeAnimation()
			f21_arg0.GamepadText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.GamepadText)
		end,
	},
	KeyboardAndMouse = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.AbilityFrame:completeAnimation()
			f22_arg0.AbilityFrame:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.AbilityFrame)
			f22_arg0.Frame:completeAnimation()
			f22_arg0.Frame:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.Frame)
			f22_arg0.KBMText:completeAnimation()
			f22_arg0.KBMText:setLeftRight(0, 1, 6, -6)
			f22_arg0.KBMText:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.KBMText)
			f22_arg0.GamepadText:completeAnimation()
			f22_arg0.GamepadText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.GamepadText)
		end,
	},
	KeyboardAndMouseAbility = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.AbilityFrame:completeAnimation()
			f23_arg0.AbilityFrame:setLeftRight(0.5, 0.5, -35, 34)
			f23_arg0.AbilityFrame:setTopBottom(0.5, 0.5, -33, 13)
			f23_arg0.AbilityFrame:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.AbilityFrame)
			f23_arg0.Frame:completeAnimation()
			f23_arg0.Frame:setLeftRight(0.37, 0.37, -33.5, 33.5)
			f23_arg0.Frame:setTopBottom(1.05, 1.05, -32, 14)
			f23_arg0.clipFinished(f23_arg0.Frame)
			f23_arg0.KBMText:completeAnimation()
			f23_arg0.KBMText:setLeftRight(0, 1, 6, -6)
			f23_arg0.KBMText:setTopBottom(0, 0, -11, 11)
			f23_arg0.KBMText:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.KBMText)
			f23_arg0.GamepadText:completeAnimation()
			f23_arg0.GamepadText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.GamepadText)
		end,
	},
	KeyboardAndMouseUltimate = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.AbilityFrame:completeAnimation()
			f24_arg0.AbilityFrame:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.AbilityFrame)
			f24_arg0.UltimateFrame:completeAnimation()
			f24_arg0.UltimateFrame:setLeftRight(0.5, 0.5, -46.5, 44.5)
			f24_arg0.UltimateFrame:setTopBottom(0.5, 0.5, -27, 39)
			f24_arg0.UltimateFrame:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.UltimateFrame)
			f24_arg0.KBMText:completeAnimation()
			f24_arg0.KBMText:setLeftRight(0.5, 0.5, -42, 39)
			f24_arg0.KBMText:setTopBottom(0, 0, -6.5, 15.5)
			f24_arg0.KBMText:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.KBMText)
			f24_arg0.GamepadText:completeAnimation()
			f24_arg0.GamepadText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.GamepadText)
		end,
	},
	KeyboardAndMouseScoreStreak = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(5)
			f25_arg0.AbilityFrame:completeAnimation()
			f25_arg0.AbilityFrame:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.AbilityFrame)
			f25_arg0.UltimateFrame:completeAnimation()
			f25_arg0.UltimateFrame:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.UltimateFrame)
			f25_arg0.ScoreStreakFrame:completeAnimation()
			f25_arg0.ScoreStreakFrame:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.ScoreStreakFrame)
			f25_arg0.KBMText:completeAnimation()
			f25_arg0.KBMText:setLeftRight(0, 1, -27, -27)
			f25_arg0.KBMText:setTopBottom(0, 0, -6.5, 15.5)
			f25_arg0.KBMText:setAlpha(1)
			f25_arg0.KBMText:setLetterSpacing(-2)
			f25_arg0.KBMText:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
			f25_arg0.clipFinished(f25_arg0.KBMText)
			f25_arg0.GamepadText:completeAnimation()
			f25_arg0.GamepadText:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.GamepadText)
		end,
	},
	KeyboardAndMouseAbilityWZ = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			f26_arg0.AbilityFrame:completeAnimation()
			f26_arg0.AbilityFrame:setLeftRight(0.5, 0.5, -36.5, 32.5)
			f26_arg0.AbilityFrame:setTopBottom(0.5, 0.5, -129, -83)
			f26_arg0.AbilityFrame:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.AbilityFrame)
			f26_arg0.Frame:completeAnimation()
			f26_arg0.Frame:setLeftRight(0.37, 0.37, -33.5, 33.5)
			f26_arg0.Frame:setTopBottom(1.05, 1.05, -32, 14)
			f26_arg0.clipFinished(f26_arg0.Frame)
			f26_arg0.KBMText:completeAnimation()
			f26_arg0.KBMText:setLeftRight(0.5, 0.5, -34, 30)
			f26_arg0.KBMText:setTopBottom(0, 0, -107.5, -85.5)
			f26_arg0.KBMText:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.KBMText)
			f26_arg0.GamepadText:completeAnimation()
			f26_arg0.GamepadText:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.GamepadText)
		end,
	},
	PCGamepadReadyEvents = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.GamepadText:completeAnimation()
			f27_arg0.GamepadText:setLeftRight(0.19, 1.19, 6, 6)
			f27_arg0.GamepadText:setTopBottom(-0.05, 0.95, -8, -8)
			f27_arg0.clipFinished(f27_arg0.GamepadText)
		end,
	},
	KeyboardAndMouseZM = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(4)
			f28_arg0.AbilityFrame:completeAnimation()
			f28_arg0.AbilityFrame:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.AbilityFrame)
			f28_arg0.Frame:completeAnimation()
			f28_arg0.Frame:setLeftRight(0.5, 0.5, -36, 36)
			f28_arg0.Frame:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Frame)
			f28_arg0.KBMText:completeAnimation()
			f28_arg0.KBMText:setLeftRight(0.15, 0.87, 6, -6)
			f28_arg0.KBMText:setTopBottom(0, 0, -4.5, 13.5)
			f28_arg0.KBMText:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.KBMText)
			f28_arg0.GamepadText:completeAnimation()
			f28_arg0.GamepadText:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.GamepadText)
		end,
	},
	Hidden2 = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.GamepadText:completeAnimation()
			f29_arg0.GamepadText:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.GamepadText)
		end,
	},
}
if not CoD.isPC then
	CoD.ControllerDependent_TextBox.__clipsPerState.KeyboardAndMouse.DefaultClip = nil
	CoD.ControllerDependent_TextBox.__clipsPerState.KeyboardAndMouseAbility.DefaultClip = nil
	CoD.ControllerDependent_TextBox.__clipsPerState.KeyboardAndMouseScoreStreak.DefaultClip = nil
	CoD.ControllerDependent_TextBox.__clipsPerState.KeyboardAndMouseAbilityWZ.DefaultClip = nil
	CoD.ControllerDependent_TextBox.__clipsPerState.KeyboardAndMouseZM.DefaultClip = nil
end
CoD.ControllerDependent_TextBox.__onClose = function(f30_arg0)
	f30_arg0.AbilityFrame:close()
	f30_arg0.Frame:close()
	f30_arg0.UltimateFrame:close()
	f30_arg0.ScoreStreakFrame:close()
end
