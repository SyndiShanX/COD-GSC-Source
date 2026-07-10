require("x64:10f65358f6a6663")
require("x64:3aafe748c812429")
require("x64:be811794932364b")
CoD.ScrStk_Container = InheritFrom(LUI.UIElement)
CoD.ScrStk_Container.__defaultWidth = 163
CoD.ScrStk_Container.__defaultHeight = 262
CoD.ScrStk_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ScorestreakSelectUtility.ScorestreakPreLoad(self, f1_arg1)
	self:setClass(CoD.ScrStk_Container)
	self.id = "ScrStk_Container"
	self.soundSet = "HUD"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScrStkCombatEfficiencyBackGlow0 = CoD.ScrStk_CombatEfficiencyBackGlow.new(f1_arg0, f1_arg1, 1, 1, -232.5, 85.5, 1, 1, -333, 37)
	ScrStkCombatEfficiencyBackGlow0:setAlpha(0.53)
	ScrStkCombatEfficiencyBackGlow0:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget2", function(model)
		ScrStkCombatEfficiencyBackGlow0:setModel(model, f1_arg1)
	end)
	self:addElement(ScrStkCombatEfficiencyBackGlow0)
	self.ScrStkCombatEfficiencyBackGlow0 = ScrStkCombatEfficiencyBackGlow0
	local Blur = LUI.UIImage.new(0, 0, 91.5, 155.5, 1, 1, -208, -31)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local PanelDark = LUI.UIImage.new(0, 0, 94, 156, 1, 1, -205, -29)
	PanelDark:setRGB(0.18, 0.17, 0.16)
	PanelDark:setAlpha(0.94)
	self:addElement(PanelDark)
	self.PanelDark = PanelDark
	local MeterBacker = LUI.UIImage.new(0, 0, 142.5, 155.5, 0, 0, 58.5, 209.5)
	MeterBacker:setRGB(0.07, 0.07, 0.07)
	self:addElement(MeterBacker)
	self.MeterBacker = MeterBacker
	local Frame = LUI.UIImage.new(0, 0, 77, 169, 1, 1, -221.5, -21.5)
	Frame:setImage(RegisterImage(0x549EBDC959884EE))
	self:addElement(Frame)
	self.Frame = Frame
	local LED = LUI.UIImage.new(0, 0, 77, 169, 1, 1, -221.5, -21.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.2)
	LED:setImage(RegisterImage(0xDCACA794C855791))
	self:addElement(LED)
	self.LED = LED
	local ScrStkMeter1 = CoD.ScrStk_Meter.new(f1_arg0, f1_arg1, 1, 1, -67.5, 7.5, 1, 1, -249, -54)
	ScrStkMeter1:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget2", function(model)
		ScrStkMeter1:setModel(model, f1_arg1)
	end)
	self:addElement(ScrStkMeter1)
	self.ScrStkMeter1 = ScrStkMeter1
	local ScrStkButtons = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	ScrStkButtons:setLeftRight(1, 1, -64, -24)
	ScrStkButtons:setTopBottom(1, 1, -243, -61)
	ScrStkButtons:setWidgetType(CoD.Support_Button)
	ScrStkButtons:setVerticalCount(4)
	ScrStkButtons:setSpacing(6)
	ScrStkButtons:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ScrStkButtons:setDataSource("KillstreakRewardsList")
	ScrStkButtons:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		CoD.ScorestreakInGameUtility.SetScorestreakSelectedSlot(element, f1_arg1)
		return f4_local0
	end)
	self:addElement(ScrStkButtons)
	self.ScrStkButtons = ScrStkButtons
	local Rule = LUI.UIImage.new(0, 0, 98, 138, 1, 1, -202.5, -193.5)
	Rule:setRGB(0.92, 0.89, 0.72)
	Rule:setAlpha(0.08)
	Rule:setImage(RegisterImage(0x44F091BA4D4DD60))
	self:addElement(Rule)
	self.Rule = Rule
	local Rule2 = LUI.UIImage.new(0, 0, 98, 138, 1, 1, -61, -53)
	Rule2:setRGB(0.92, 0.89, 0.72)
	Rule2:setAlpha(0.08)
	Rule2:setImage(RegisterImage(0x44F091BA4D4DD60))
	self:addElement(Rule2)
	self.Rule2 = Rule2
	local Rule3 = LUI.UIImage.new(0, 0, 98, 138, 1, 1, -108, -100)
	Rule3:setRGB(0.92, 0.89, 0.72)
	Rule3:setAlpha(0.08)
	Rule3:setImage(RegisterImage(0x44F091BA4D4DD60))
	self:addElement(Rule3)
	self.Rule3 = Rule3
	local Rule4 = LUI.UIImage.new(0, 0, 98, 138, 1, 1, -154.5, -146.5)
	Rule4:setRGB(0.92, 0.89, 0.72)
	Rule4:setAlpha(0.08)
	Rule4:setImage(RegisterImage(0x44F091BA4D4DD60))
	self:addElement(Rule4)
	self.Rule4 = Rule4
	local triangle2 = LUI.UIImage.new(0, 0, 140, 144, 0, 0, 205.5, 209.5)
	triangle2:setRGB(0.07, 0.07, 0.07)
	triangle2:setZRot(90)
	triangle2:setImage(RegisterImage(0x41B9B3CAF3B7BE2))
	self:addElement(triangle2)
	self.triangle2 = triangle2
	local triangle = LUI.UIImage.new(0, 0, 139, 143, 0, 0, 60.5, 64.5)
	triangle:setRGB(0.07, 0.07, 0.07)
	triangle:setZRot(180)
	triangle:setImage(RegisterImage(0x41B9B3CAF3B7BE2))
	self:addElement(triangle)
	self.triangle = triangle
	self:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	ScrStkButtons.id = "ScrStkButtons"
	self.__defaultFocus = ScrStkButtons
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local15 = self
	if not IsDemoPlaying() then
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.ScrStkButtons)
	end
	f1_local15 = ScrStkButtons
	CoD.FreeCursorUtility.SetListFocusIgnoresFreeCursor(f1_local15, f1_arg1)
	CoD.ScorestreakInGameUtility.AddScorestreakListNavigation(f1_arg0, f1_local15, f1_arg1)
	CoD.ScorestreakInGameUtility.InitScorestreakUpdateListener(f1_local15, f1_arg1, "Usable")
	return self
end
CoD.ScrStk_Container.__resetProperties = function(f6_arg0)
	f6_arg0.ScrStkMeter1:completeAnimation()
	f6_arg0.ScrStkButtons:completeAnimation()
	f6_arg0.ScrStkCombatEfficiencyBackGlow0:completeAnimation()
	f6_arg0.ScrStkMeter1:setAlpha(1)
	f6_arg0.ScrStkButtons:setAlpha(1)
	f6_arg0.ScrStkCombatEfficiencyBackGlow0:setAlpha(0.53)
end
CoD.ScrStk_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.ScrStkCombatEfficiencyBackGlow0:completeAnimation()
			f7_arg0.ScrStkCombatEfficiencyBackGlow0:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ScrStkCombatEfficiencyBackGlow0)
			f7_arg0.ScrStkMeter1:completeAnimation()
			f7_arg0.ScrStkMeter1:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ScrStkMeter1)
			f7_arg0.ScrStkButtons:completeAnimation()
			f7_arg0.ScrStkButtons:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ScrStkButtons)
		end,
		HudStart = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ScrStkCombatEfficiencyBackGlow0:beginAnimation(60)
				f8_arg0.ScrStkCombatEfficiencyBackGlow0:setAlpha(0.53)
				f8_arg0.ScrStkCombatEfficiencyBackGlow0:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ScrStkCombatEfficiencyBackGlow0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ScrStkCombatEfficiencyBackGlow0:completeAnimation()
			f8_arg0.ScrStkCombatEfficiencyBackGlow0:setAlpha(0)
			f8_local0(f8_arg0.ScrStkCombatEfficiencyBackGlow0)
			local f8_local1 = function(f10_arg0)
				f8_arg0.ScrStkMeter1:beginAnimation(150, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f8_arg0.ScrStkMeter1:setAlpha(1)
				f8_arg0.ScrStkMeter1:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ScrStkMeter1:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ScrStkMeter1:completeAnimation()
			f8_arg0.ScrStkMeter1:setAlpha(0)
			f8_local1(f8_arg0.ScrStkMeter1)
			local f8_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.ScrStkButtons:beginAnimation(110)
				f8_arg0.ScrStkButtons:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ScrStkButtons:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f8_arg0.ScrStkButtons:completeAnimation()
			f8_arg0.ScrStkButtons:setAlpha(0)
			f8_local2(f8_arg0.ScrStkButtons)
		end,
	},
	HudStart = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		HudStop = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			local f14_local0 = function(f15_arg0)
				f14_arg0.ScrStkCombatEfficiencyBackGlow0:beginAnimation(240)
				f14_arg0.ScrStkCombatEfficiencyBackGlow0:setAlpha(0)
				f14_arg0.ScrStkCombatEfficiencyBackGlow0:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ScrStkCombatEfficiencyBackGlow0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ScrStkCombatEfficiencyBackGlow0:completeAnimation()
			f14_arg0.ScrStkCombatEfficiencyBackGlow0:setAlpha(0.53)
			f14_local0(f14_arg0.ScrStkCombatEfficiencyBackGlow0)
			local f14_local1 = function(f16_arg0)
				f14_arg0.ScrStkMeter1:beginAnimation(130, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f14_arg0.ScrStkMeter1:setAlpha(0)
				f14_arg0.ScrStkMeter1:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ScrStkMeter1:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.ScrStkMeter1:completeAnimation()
			f14_arg0.ScrStkMeter1:setAlpha(1)
			f14_local1(f14_arg0.ScrStkMeter1)
			local f14_local2 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(130, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
					f18_arg0:setAlpha(0)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.ScrStkButtons:beginAnimation(70)
				f14_arg0.ScrStkButtons:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ScrStkButtons:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f14_arg0.ScrStkButtons:completeAnimation()
			f14_arg0.ScrStkButtons:setAlpha(1)
			f14_local2(f14_arg0.ScrStkButtons)
		end,
	},
}
CoD.ScrStk_Container.__onClose = function(f19_arg0)
	f19_arg0.ScrStkCombatEfficiencyBackGlow0:close()
	f19_arg0.ScrStkMeter1:close()
	f19_arg0.ScrStkButtons:close()
end
