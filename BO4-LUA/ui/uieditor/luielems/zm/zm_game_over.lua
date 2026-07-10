require("x64:488c89835c36151")
require("x64:170894c2be18f57")
require("x64:7e1697b8a432349")
CoD.zm_game_over = InheritFrom(CoD.Menu)
CoD.zm_game_over.__stateMap = {
	"DefaultState",
	"GatewayOpened",
}
LUI.createMenu.zm_game_over = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_game_over", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_game_over)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0x81EEB1F96D4BE0A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BackgroundOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundOverlay:setRGB(0, 0, 0)
	BackgroundOverlay:setAlpha(0.7)
	self:addElement(BackgroundOverlay)
	self.BackgroundOverlay = BackgroundOverlay
	local CroppedZmBacking2 = LUI.UIImage.new(0, 1, -9, 9, 0, 1, -18, 18)
	CroppedZmBacking2:setAlpha(0.5)
	CroppedZmBacking2:setImage(RegisterImage(0xA8FC401C1972BDE))
	CroppedZmBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	CroppedZmBacking2:setShaderVector(0, 0, 0, 0, 0)
	CroppedZmBacking2:setShaderVector(1, 1, 1, 0, 0)
	CroppedZmBacking2:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(CroppedZmBacking2)
	self.CroppedZmBacking2 = CroppedZmBacking2
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.4)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local TitleSequence = CoD.zm_hud_gameover_titlesequence.new(f1_local1, f1_arg0, 0.5, 0.5, -400, 400, 0, 0, -80, 390)
	TitleSequence:linkToElementModel(self, "rounds", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TitleSequence.RoundsSurvived:setText(CoD.ZombieUtility.GetSurvivedRoundsText(f2_local0))
		end
	end)
	self:addElement(TitleSequence)
	self.TitleSequence = TitleSequence
	local RestartLevelPrompt = CoD.ZM_Restart_Level_Prompt.new(f1_local1, f1_arg0, 0.5, 0.5, -350, 350, 0.5, 0.5, 203, 338)
	self:addElement(RestartLevelPrompt)
	self.RestartLevelPrompt = RestartLevelPrompt
	local Scoreboard = CoD.Rush_Gameover_Scoreboard.new(f1_local1, f1_arg0, 0.5, 0.5, -500, 500, 0.5, 0.5, -219, 160)
	self:addElement(Scoreboard)
	self.Scoreboard = Scoreboard
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() and IsInTheaterMode() then
			LockInput(self, f1_arg0, false)
		end
	end)
	RestartLevelPrompt.id = "RestartLevelPrompt"
	Scoreboard.id = "Scoreboard"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = RestartLevelPrompt
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local9 = self
	if IsPC() then
		LockInput(self, f1_arg0, true)
	end
	return self
end
CoD.zm_game_over.__resetProperties = function(f4_arg0)
	f4_arg0.RestartLevelPrompt:completeAnimation()
	f4_arg0.Scoreboard:completeAnimation()
	f4_arg0.TitleSequence:completeAnimation()
	f4_arg0.RestartLevelPrompt:setAlpha(1)
	f4_arg0.Scoreboard:setAlpha(1)
	f4_arg0.TitleSequence:setAlpha(1)
	f4_arg0.TitleSequence.TitleShadow:setText(Engine[0xF9F1239CFD921FE](0x22EF41D702EE72D))
	f4_arg0.TitleSequence.Title:setText(Engine[0xF9F1239CFD921FE](0x22EF41D702EE72D))
end
CoD.zm_game_over.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(200)
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.TitleSequence:beginAnimation(100)
				f5_arg0.TitleSequence:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.TitleSequence:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.TitleSequence:completeAnimation()
			f5_arg0.TitleSequence:setAlpha(0)
			f5_local0(f5_arg0.TitleSequence)
			local f5_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(190)
					f9_arg0:setAlpha(1)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.RestartLevelPrompt:beginAnimation(530)
				f5_arg0.RestartLevelPrompt:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.RestartLevelPrompt:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f5_arg0.RestartLevelPrompt:completeAnimation()
			f5_arg0.RestartLevelPrompt:setAlpha(0)
			f5_local1(f5_arg0.RestartLevelPrompt)
			local f5_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(229)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.Scoreboard:beginAnimation(300)
				f5_arg0.Scoreboard:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Scoreboard:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f5_arg0.Scoreboard:completeAnimation()
			f5_arg0.Scoreboard:setAlpha(0)
			f5_local2(f5_arg0.Scoreboard)
		end,
	},
	GatewayOpened = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.TitleSequence:completeAnimation()
			f12_arg0.TitleSequence.TitleShadow:completeAnimation()
			f12_arg0.TitleSequence.Title:completeAnimation()
			f12_arg0.TitleSequence.TitleShadow:setText(Engine[0xF9F1239CFD921FE](0x86BC28CC483BDEE))
			f12_arg0.TitleSequence.Title:setText(Engine[0xF9F1239CFD921FE](0x86BC28CC483BDEE))
			f12_arg0.clipFinished(f12_arg0.TitleSequence)
		end,
	},
}
CoD.zm_game_over.__onClose = function(f13_arg0)
	f13_arg0.TitleSequence:close()
	f13_arg0.RestartLevelPrompt:close()
	f13_arg0.Scoreboard:close()
end
