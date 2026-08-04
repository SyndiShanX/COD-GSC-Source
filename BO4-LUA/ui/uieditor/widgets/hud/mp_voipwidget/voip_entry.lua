CoD.Voip_Entry = InheritFrom(LUI.UIElement)
CoD.Voip_Entry.__defaultWidth = 348
CoD.Voip_Entry.__defaultHeight = 27
CoD.Voip_Entry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Voip_Entry)
	self.id = "Voip_Entry"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Entry = LUI.UIText.new(0, 0, 30, 348, 0.5, 0.5, -9, 12)
	Entry:setTTF("ttmussels_demibold")
	Entry:setLetterSpacing(0.2)
	Entry:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Entry:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Entry:setText(f2_local0)
		end
	end)
	self:addElement(Entry)
	self.Entry = Entry
	local talker = LUI.UIImage.new(0, 0, 0, 27, 0, 0, 0, 27)
	talker:setImage(RegisterImage("uie_t7_core_hud_voiptemp-01"))
	self:addElement(talker)
	self.talker = talker
	local enemyEntry = LUI.UIText.new(0, 0, 30, 348, 0.5, 0.5, -9, 12)
	enemyEntry:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	enemyEntry:setAlpha(0)
	enemyEntry:setTTF("notosans_regular")
	enemyEntry:setLetterSpacing(0.2)
	enemyEntry:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	enemyEntry:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			enemyEntry:setText(f3_local0)
		end
	end)
	self:addElement(enemyEntry)
	self.enemyEntry = enemyEntry
	local enemyTalker = LUI.UIImage.new(0, 0, 0, 27, 0, 0, 0, 27)
	enemyTalker:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	enemyTalker:setAlpha(0)
	enemyTalker:setImage(RegisterImage("uie_t7_core_hud_voiptemp-01"))
	self:addElement(enemyTalker)
	self.enemyTalker = enemyTalker
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "status", Enum.eVoipStatus[0xC43512B960F0D38])
			end,
		},
		{
			stateName = "EnemyTalking",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "status", Enum.eVoipStatus[@"voip_enemy_talking"])
			end,
		},
	})
	self:linkToElementModel(self, "status", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "status",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Voip_Entry.__resetProperties = function(f7_arg0)
	f7_arg0.Entry:completeAnimation()
	f7_arg0.talker:completeAnimation()
	f7_arg0.enemyTalker:completeAnimation()
	f7_arg0.enemyEntry:completeAnimation()
	f7_arg0.Entry:setAlpha(1)
	f7_arg0.talker:setAlpha(1)
	f7_arg0.enemyTalker:setAlpha(0)
	f7_arg0.enemyEntry:setAlpha(0)
end
CoD.Voip_Entry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.Entry:completeAnimation()
			f9_arg0.Entry:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Entry)
			f9_arg0.talker:completeAnimation()
			f9_arg0.talker:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.talker)
		end,
	},
	EnemyTalking = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.Entry:completeAnimation()
			f10_arg0.Entry:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Entry)
			f10_arg0.talker:completeAnimation()
			f10_arg0.talker:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.talker)
			f10_arg0.enemyEntry:completeAnimation()
			f10_arg0.enemyEntry:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.enemyEntry)
			f10_arg0.enemyTalker:completeAnimation()
			f10_arg0.enemyTalker:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.enemyTalker)
		end,
	},
}
CoD.Voip_Entry.__onClose = function(f11_arg0)
	f11_arg0.Entry:close()
	f11_arg0.enemyEntry:close()
end
