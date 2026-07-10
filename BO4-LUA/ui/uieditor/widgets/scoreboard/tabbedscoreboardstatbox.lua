CoD.TabbedScoreboardStatBox = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardStatBox.__defaultWidth = 82
CoD.TabbedScoreboardStatBox.__defaultHeight = 60
CoD.TabbedScoreboardStatBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardStatBox)
	self.id = "TabbedScoreboardStatBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BarBot = LUI.UIImage.new(0, 0, -2, 86, 0, 0, 54, 64)
	BarBot:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_score_bot"))
	self:addElement(BarBot)
	self.BarBot = BarBot
	local Tint = LUI.UIImage.new(0.5, 0.5, -42, 42, 0, 0, -1, 57)
	Tint:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_score_bg"))
	self:addElement(Tint)
	self.Tint = Tint
	local TintPC = nil
	TintPC = LUI.UIImage.new(0.5, 0.5, -42, 42, 0, 0, -1, 57)
	TintPC:setAlpha(0)
	TintPC:setImage(RegisterImage(@"uie_scoreboard_list_score_bg"))
	self:addElement(TintPC)
	self.TintPC = TintPC
	local Value = LUI.UIText.new(0.5, 0.5, -42, 42, 0.5, 0.5, -15, 15)
	Value:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Value:setTTF("ttmussels_demibold")
	Value:setLetterSpacing(-1)
	Value:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Value:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(Value)
	self.Value = Value
	self:mergeStateConditions({
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsZombies()
			end,
		},
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, element) and not IsPC()
			end,
		},
		{
			stateName = "SelfPC",
			condition = function(menu, element, event)
				return IsPC() and IsSelfClient(f1_arg1, element)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardStatBox.__resetProperties = function(f7_arg0)
	f7_arg0.Tint:completeAnimation()
	f7_arg0.BarBot:completeAnimation()
	f7_arg0.Value:completeAnimation()
	f7_arg0.TintPC:completeAnimation()
	f7_arg0.Tint:setAlpha(1)
	f7_arg0.BarBot:setAlpha(1)
	f7_arg0.Value:setRGB(1, 1, 1)
	f7_arg0.TintPC:setRGB(1, 1, 1)
	f7_arg0.TintPC:setAlpha(0)
end
CoD.TabbedScoreboardStatBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	ZM = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.BarBot:completeAnimation()
			f9_arg0.BarBot:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.BarBot)
			f9_arg0.Tint:completeAnimation()
			f9_arg0.Tint:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Tint)
		end,
	},
	Self = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Tint:completeAnimation()
			f10_arg0.Tint:setAlpha(0.7)
			f10_arg0.clipFinished(f10_arg0.Tint)
			f10_arg0.Value:completeAnimation()
			f10_arg0.Value:setRGB(1, 0.76, 0)
			f10_arg0.clipFinished(f10_arg0.Value)
		end,
	},
	SelfPC = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Tint:completeAnimation()
			f11_arg0.Tint:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Tint)
			f11_arg0.TintPC:completeAnimation()
			f11_arg0.TintPC:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.TintPC)
			f11_arg0.Value:completeAnimation()
			f11_arg0.Value:setRGB(1, 0.76, 0)
			f11_arg0.clipFinished(f11_arg0.Value)
		end,
	},
	PC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.Tint:completeAnimation()
			f12_arg0.Tint:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Tint)
			f12_arg0.TintPC:completeAnimation()
			f12_arg0.TintPC:setRGB(1, 1, 1)
			f12_arg0.TintPC:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.TintPC)
			f12_arg0.Value:completeAnimation()
			f12_arg0.Value:setRGB(1, 1, 1)
			f12_arg0.clipFinished(f12_arg0.Value)
		end,
	},
}
