CoD.PositionDraft_AttackDefend = InheritFrom(LUI.UIElement)
CoD.PositionDraft_AttackDefend.__defaultWidth = 230
CoD.PositionDraft_AttackDefend.__defaultHeight = 40
CoD.PositionDraft_AttackDefend.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_AttackDefend)
	self.id = "PositionDraft_AttackDefend"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Text = LUI.UIText.new(0, 1, 0, 0, 0, 0, 11, 29)
	Text:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1B24A4CDDBB668DB"))
	Text:setTTF("ttmussels_regular")
	Text:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Text:setLetterSpacing(5)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Text)
	self.Text = Text
	self:mergeStateConditions({
		{
			stateName = "Defending",
			condition = function(menu, element, event)
				local f2_local0
				if not IsAttackingTeam(f1_arg1) then
					f2_local0 = IsAttackDefendGametype()
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "Attacking",
			condition = function(menu, element, event)
				return IsAttackingTeam(f1_arg1) and IsAttackDefendGametype()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["hudItems.war.attackingTeam"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.war.attackingTeam",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.profileSettingsUpdated, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_AttackDefend.__resetProperties = function(f6_arg0)
	f6_arg0.Text:completeAnimation()
	f6_arg0.Text:setAlpha(1)
	f6_arg0.Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1B24A4CDDBB668DB"))
end
CoD.PositionDraft_AttackDefend.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Text:completeAnimation()
			f7_arg0.Text:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Text)
		end,
	},
	Defending = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Text:completeAnimation()
			f8_arg0.Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F803B470392D1C7"))
			f8_arg0.clipFinished(f8_arg0.Text)
		end,
	},
	Attacking = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
