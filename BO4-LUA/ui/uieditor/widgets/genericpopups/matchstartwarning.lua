require("x64:45c3699dabd929")
require("x64:22dd5a83b46fd96")
require("x64:d5c2c4fd68fecdd")
require("x64:474d14efb47ebf4")
CoD.MatchStartWarning = InheritFrom(LUI.UIElement)
CoD.MatchStartWarning.__defaultWidth = 1920
CoD.MatchStartWarning.__defaultHeight = 1080
CoD.MatchStartWarning.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("lobbyRoot.lobbyTimeRemaining")
	CoD.BaseUtility.CreateGlobalModel("lobbyRoot.lobbyMenuOccluded")
	self:setClass(CoD.MatchStartWarning)
	self.id = "MatchStartWarning"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MatchStartWarningContainer0 = CoD.MatchStartWarningContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 0, 0, 45.5, 120.5)
	MatchStartWarningContainer0:setAlpha(0)
	self:addElement(MatchStartWarningContainer0)
	self.MatchStartWarningContainer0 = MatchStartWarningContainer0
	local Frame = LUI.UIImage.new(0.5, 0.5, -65, 65, 0, 0, 55, 185)
	Frame:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Frame:setAlpha(0.9)
	Frame:setImage(RegisterImage(0x1A4736A2632AE28))
	self:addElement(Frame)
	self.Frame = Frame
	local RadialTimer = CoD.MatchstartRadialTimer.new(f1_arg0, f1_arg1, 0.5, 0.5, -44.5, 44.5, 0, 0, 75.5, 164.5)
	RadialTimer:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTimeRemaining", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RadialTimer.Clock:setShaderVector(0, SubtractVectorComponentFrom(2, 1, SetVectorComponent(1, 1, ScaleVectorComponents(1, 0.1, 1, 1, SwapVectorComponents(2, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))))))
		end
	end)
	self:addElement(RadialTimer)
	self.RadialTimer = RadialTimer
	local timerText = CoD.ArabicAlignTextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0, 0, 104.5, 137.5)
	timerText.textBox:setTTF("0arame_mono_stencil")
	timerText:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTimeRemaining", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			timerText.textBox:setText(CoD.DirectorUtility.TimeRemainingForMatchStart(f3_local0))
		end
	end)
	self:addElement(timerText)
	self.timerText = timerText
	local StrokeR = LUI.UIImage.new(0.5, 0.5, 55, 125, 0, 0, 119.5, 120.5)
	StrokeR:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	StrokeR:setAlpha(0.08)
	self:addElement(StrokeR)
	self.StrokeR = StrokeR
	local StrokeL = LUI.UIImage.new(0.5, 0.5, -125, -55, 0, 0, 119.5, 120.5)
	StrokeL:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	StrokeL:setAlpha(0.08)
	self:addElement(StrokeL)
	self.StrokeL = StrokeL
	local BoxR = LUI.UIImage.new(0.5, 0.5, 49, 51, 0, 0, 119, 121)
	BoxR:setAlpha(0)
	self:addElement(BoxR)
	self.BoxR = BoxR
	local BoxL = LUI.UIImage.new(0.5, 0.5, -51, -49, 0, 0, 119, 121)
	BoxL:setAlpha(0)
	self:addElement(BoxL)
	self.BoxL = BoxL
	local Base = LUI.UIImage.new(0.5, 0.5, -55.5, 55.5, 0, 0, 64.5, 175.5)
	Base:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	Base:setAlpha(0.4)
	Base:setScale(0, 0)
	Base:setImage(RegisterImage(0xEE39ABD2A43A84))
	self:addElement(Base)
	self.Base = Base
	local Team1PlayerList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 8, 0, nil, nil, false, false, false, false)
	Team1PlayerList:setLeftRight(0.5, 0.5, -864, -534)
	Team1PlayerList:setTopBottom(0, 0, 55, 187)
	Team1PlayerList:setAlpha(0)
	Team1PlayerList:setWidgetType(CoD.LoadingScreenTalkerWidgetCPZM)
	Team1PlayerList:setVerticalCount(4)
	Team1PlayerList:setSpacing(8)
	Team1PlayerList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Team1PlayerList:setDataSource("LoadingScreenPlayerListTeam1")
	self:addElement(Team1PlayerList)
	self.Team1PlayerList = Team1PlayerList
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f4_local0 = IsMultiplayer()
				if f4_local0 then
					f4_local0 = CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0)
					if f4_local0 then
						f4_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.lobbyMenuOccluded")
						if f4_local0 then
							f4_local0 = not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 20)
						end
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "VOIPVisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.lobbyMenuOccluded")
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local12(f1_local11, f1_local13["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local12(f1_local11, f1_local13["lobbyRoot.lobbyTimeRemaining"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyTimeRemaining",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local12(f1_local11, f1_local13["lobbyRoot.lobbyMenuOccluded"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyMenuOccluded",
		})
	end, false)
	Team1PlayerList.id = "Team1PlayerList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MatchStartWarning.__resetProperties = function(f9_arg0)
	f9_arg0.MatchStartWarningContainer0:completeAnimation()
	f9_arg0.Frame:completeAnimation()
	f9_arg0.RadialTimer:completeAnimation()
	f9_arg0.timerText:completeAnimation()
	f9_arg0.StrokeR:completeAnimation()
	f9_arg0.StrokeL:completeAnimation()
	f9_arg0.Base:completeAnimation()
	f9_arg0.Team1PlayerList:completeAnimation()
	f9_arg0.MatchStartWarningContainer0:setLeftRight(0.5, 0.5, -150, 150)
	f9_arg0.MatchStartWarningContainer0:setTopBottom(0, 0, 45.5, 120.5)
	f9_arg0.MatchStartWarningContainer0:setAlpha(0)
	f9_arg0.Frame:setAlpha(0.9)
	f9_arg0.Frame:setScale(1, 1)
	f9_arg0.RadialTimer:setAlpha(1)
	f9_arg0.RadialTimer:setScale(1, 1)
	f9_arg0.timerText:setAlpha(1)
	f9_arg0.StrokeR:setLeftRight(0.5, 0.5, 55, 125)
	f9_arg0.StrokeR:setAlpha(0.08)
	f9_arg0.StrokeL:setLeftRight(0.5, 0.5, -125, -55)
	f9_arg0.StrokeL:setAlpha(0.08)
	f9_arg0.Base:setAlpha(0.4)
	f9_arg0.Base:setScale(0, 0)
	f9_arg0.Team1PlayerList:setAlpha(0)
end
CoD.MatchStartWarning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(8)
			f10_arg0.MatchStartWarningContainer0:completeAnimation()
			f10_arg0.MatchStartWarningContainer0:setLeftRight(0.5, 0.5, -150, 150)
			f10_arg0.MatchStartWarningContainer0:setTopBottom(0, 0, -98.5, -23.5)
			f10_arg0.MatchStartWarningContainer0:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.MatchStartWarningContainer0)
			f10_arg0.Frame:completeAnimation()
			f10_arg0.Frame:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Frame)
			f10_arg0.RadialTimer:completeAnimation()
			f10_arg0.RadialTimer:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RadialTimer)
			f10_arg0.timerText:completeAnimation()
			f10_arg0.timerText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.timerText)
			f10_arg0.StrokeR:completeAnimation()
			f10_arg0.StrokeR:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.StrokeR)
			f10_arg0.StrokeL:completeAnimation()
			f10_arg0.StrokeL:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.StrokeL)
			f10_arg0.Base:completeAnimation()
			f10_arg0.Base:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Base)
			f10_arg0.Team1PlayerList:completeAnimation()
			f10_arg0.Team1PlayerList:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Team1PlayerList)
		end,
		Visible = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(7)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(89, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f14_arg0:setTopBottom(0, 0, 46.5, 121.5)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(50, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f13_arg0:setTopBottom(0, 0, 37.5, 112.5)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f12_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0:setTopBottom(0, 0, 68.5, 143.5)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.MatchStartWarningContainer0:beginAnimation(500)
			f11_arg0.MatchStartWarningContainer0:setLeftRight(0.5, 0.5, -150, 150)
			f11_arg0.MatchStartWarningContainer0:setTopBottom(0, 0, -99.5, -24.5)
			f11_arg0.MatchStartWarningContainer0:setAlpha(0)
			f11_arg0.MatchStartWarningContainer0:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.MatchStartWarningContainer0:registerEventHandler("transition_complete_keyframe", f11_local0)
			local f11_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(40)
						f17_arg0:setAlpha(1)
						f17_arg0:setScale(1, 1)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(120, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f16_arg0:setAlpha(0.75)
					f16_arg0:setScale(0.8, 0.8)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f11_arg0.Frame:beginAnimation(500)
				f11_arg0.Frame:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Frame:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f11_arg0.Frame:completeAnimation()
			f11_arg0.Frame:setAlpha(0)
			f11_arg0.Frame:setScale(1.8, 1.8)
			f11_local1(f11_arg0.Frame)
			local f11_local2 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(40)
						f20_arg0:setAlpha(1)
						f20_arg0:setScale(1, 1)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(119, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f19_arg0:setAlpha(0.75)
					f19_arg0:setScale(1.2, 1.2)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f11_arg0.RadialTimer:beginAnimation(660)
				f11_arg0.RadialTimer:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.RadialTimer:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f11_arg0.RadialTimer:completeAnimation()
			f11_arg0.RadialTimer:setAlpha(0)
			f11_arg0.RadialTimer:setScale(0.8, 0.8)
			f11_local2(f11_arg0.RadialTimer)
			local f11_local3 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(300)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.timerText:beginAnimation(800)
				f11_arg0.timerText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.timerText:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f11_arg0.timerText:completeAnimation()
			f11_arg0.timerText:setAlpha(0)
			f11_local3(f11_arg0.timerText)
			local f11_local4 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(149)
					f24_arg0:setLeftRight(0.5, 0.5, 55, 125)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.StrokeR:beginAnimation(870)
				f11_arg0.StrokeR:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.StrokeR:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f11_arg0.StrokeR:completeAnimation()
			f11_arg0.StrokeR:setLeftRight(0.5, 0.5, 55, 55)
			f11_local4(f11_arg0.StrokeR)
			local f11_local5 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(149)
					f26_arg0:setLeftRight(0.5, 0.5, -125, -55)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.StrokeL:beginAnimation(870)
				f11_arg0.StrokeL:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.StrokeL:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f11_arg0.StrokeL:completeAnimation()
			f11_arg0.StrokeL:setLeftRight(0.5, 0.5, -55, -55)
			f11_local5(f11_arg0.StrokeL)
			local f11_local6 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					local f28_local0 = function(f29_arg0)
						f29_arg0:beginAnimation(50)
						f29_arg0:setAlpha(0)
						f29_arg0:setScale(1.5, 1.5)
						f29_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f28_arg0:beginAnimation(199)
					f28_arg0:setAlpha(0.2)
					f28_arg0:setScale(1.6, 1.6)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
				end
				f11_arg0.Base:beginAnimation(500)
				f11_arg0.Base:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Base:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f11_arg0.Base:completeAnimation()
			f11_arg0.Base:setAlpha(1)
			f11_arg0.Base:setScale(0, 0)
			f11_local6(f11_arg0.Base)
		end,
	},
	Visible = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(7)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(140, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f33_arg0:setTopBottom(0, 0, -98.5, -23.5)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.MatchStartWarningContainer0:beginAnimation(160, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f31_arg0.MatchStartWarningContainer0:setTopBottom(0, 0, 67.5, 142.5)
				f31_arg0.MatchStartWarningContainer0:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.MatchStartWarningContainer0:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.MatchStartWarningContainer0:completeAnimation()
			f31_arg0.MatchStartWarningContainer0:setLeftRight(0.5, 0.5, -150, 150)
			f31_arg0.MatchStartWarningContainer0:setTopBottom(0, 0, 46.5, 121.5)
			f31_arg0.MatchStartWarningContainer0:setAlpha(0)
			f31_local0(f31_arg0.MatchStartWarningContainer0)
			local f31_local1 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(119)
					f35_arg0:setAlpha(0)
					f35_arg0:setScale(1.8, 1.8)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f34_arg0:beginAnimation(39)
				f34_arg0:setAlpha(0.75)
				f34_arg0:setScale(0.8, 0.8)
				f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f31_arg0.Frame:beginAnimation(360)
			f31_arg0.Frame:setAlpha(1)
			f31_arg0.Frame:setScale(1, 1)
			f31_arg0.Frame:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.Frame:registerEventHandler("transition_complete_keyframe", f31_local1)
			local f31_local2 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(120)
					f37_arg0:setAlpha(0)
					f37_arg0:setScale(0.8, 0.8)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f36_arg0:beginAnimation(39)
				f36_arg0:setAlpha(0.75)
				f36_arg0:setScale(1.2, 1.2)
				f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f31_arg0.RadialTimer:beginAnimation(200)
			f31_arg0.RadialTimer:setAlpha(1)
			f31_arg0.RadialTimer:setScale(1, 1)
			f31_arg0.RadialTimer:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.RadialTimer:registerEventHandler("transition_complete_keyframe", f31_local2)
			local f31_local3 = function(f38_arg0)
				f38_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f38_arg0:setAlpha(0)
				f38_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.timerText:beginAnimation(300)
			f31_arg0.timerText:setAlpha(1)
			f31_arg0.timerText:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.timerText:registerEventHandler("transition_complete_keyframe", f31_local3)
			local f31_local4 = function(f39_arg0)
				f31_arg0.StrokeR:beginAnimation(150)
				f31_arg0.StrokeR:setLeftRight(0.5, 0.5, 55, 55)
				f31_arg0.StrokeR:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.StrokeR:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.StrokeR:completeAnimation()
			f31_arg0.StrokeR:setLeftRight(0.5, 0.5, 55, 125)
			f31_local4(f31_arg0.StrokeR)
			local f31_local5 = function(f40_arg0)
				f31_arg0.StrokeL:beginAnimation(150)
				f31_arg0.StrokeL:setLeftRight(0.5, 0.5, -55, -55)
				f31_arg0.StrokeL:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.StrokeL:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.StrokeL:completeAnimation()
			f31_arg0.StrokeL:setLeftRight(0.5, 0.5, -125, -55)
			f31_local5(f31_arg0.StrokeL)
			local f31_local6 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(210)
					f42_arg0:setAlpha(1)
					f42_arg0:setScale(0, 0)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f41_arg0:beginAnimation(39)
				f41_arg0:setAlpha(0.16)
				f41_arg0:setScale(1.2, 1.2)
				f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f31_arg0.Base:beginAnimation(360)
			f31_arg0.Base:setAlpha(0)
			f31_arg0.Base:setScale(1.1, 1.1)
			f31_arg0.Base:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
			f31_arg0.Base:registerEventHandler("transition_complete_keyframe", f31_local6)
		end,
	},
	VOIPVisible = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(7)
			f43_arg0.MatchStartWarningContainer0:completeAnimation()
			f43_arg0.MatchStartWarningContainer0:setLeftRight(0.5, 0.5, -150, 150)
			f43_arg0.MatchStartWarningContainer0:setTopBottom(0, 0, -98.5, -23.5)
			f43_arg0.MatchStartWarningContainer0:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.MatchStartWarningContainer0)
			f43_arg0.Frame:completeAnimation()
			f43_arg0.Frame:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.Frame)
			f43_arg0.RadialTimer:completeAnimation()
			f43_arg0.RadialTimer:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.RadialTimer)
			f43_arg0.timerText:completeAnimation()
			f43_arg0.timerText:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.timerText)
			f43_arg0.StrokeR:completeAnimation()
			f43_arg0.StrokeR:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.StrokeR)
			f43_arg0.StrokeL:completeAnimation()
			f43_arg0.StrokeL:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.StrokeL)
			f43_arg0.Base:completeAnimation()
			f43_arg0.Base:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.Base)
		end,
		Visible = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(7)
			local f44_local0 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					local f46_local0 = function(f47_arg0)
						f47_arg0:beginAnimation(89, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f47_arg0:setTopBottom(0, 0, 46.5, 121.5)
						f47_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
					end
					f46_arg0:beginAnimation(50, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f46_arg0:setTopBottom(0, 0, 37.5, 112.5)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
				end
				f45_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f45_arg0:setTopBottom(0, 0, 68.5, 143.5)
				f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f44_arg0.MatchStartWarningContainer0:beginAnimation(500)
			f44_arg0.MatchStartWarningContainer0:setLeftRight(0.5, 0.5, -150, 150)
			f44_arg0.MatchStartWarningContainer0:setTopBottom(0, 0, -99.5, -24.5)
			f44_arg0.MatchStartWarningContainer0:setAlpha(0)
			f44_arg0.MatchStartWarningContainer0:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
			f44_arg0.MatchStartWarningContainer0:registerEventHandler("transition_complete_keyframe", f44_local0)
			local f44_local1 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					local f49_local0 = function(f50_arg0)
						f50_arg0:beginAnimation(40)
						f50_arg0:setAlpha(1)
						f50_arg0:setScale(1, 1)
						f50_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
					end
					f49_arg0:beginAnimation(120, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f49_arg0:setAlpha(0.75)
					f49_arg0:setScale(0.8, 0.8)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
				end
				f44_arg0.Frame:beginAnimation(500)
				f44_arg0.Frame:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.Frame:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f44_arg0.Frame:completeAnimation()
			f44_arg0.Frame:setAlpha(0)
			f44_arg0.Frame:setScale(1.8, 1.8)
			f44_local1(f44_arg0.Frame)
			local f44_local2 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					local f52_local0 = function(f53_arg0)
						f53_arg0:beginAnimation(40)
						f53_arg0:setAlpha(1)
						f53_arg0:setScale(1, 1)
						f53_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
					end
					f52_arg0:beginAnimation(119, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f52_arg0:setAlpha(0.75)
					f52_arg0:setScale(1.2, 1.2)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
				end
				f44_arg0.RadialTimer:beginAnimation(660)
				f44_arg0.RadialTimer:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.RadialTimer:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f44_arg0.RadialTimer:completeAnimation()
			f44_arg0.RadialTimer:setAlpha(0)
			f44_arg0.RadialTimer:setScale(0.8, 0.8)
			f44_local2(f44_arg0.RadialTimer)
			local f44_local3 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					f55_arg0:beginAnimation(300)
					f55_arg0:setAlpha(1)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
				end
				f44_arg0.timerText:beginAnimation(800)
				f44_arg0.timerText:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.timerText:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f44_arg0.timerText:completeAnimation()
			f44_arg0.timerText:setAlpha(0)
			f44_local3(f44_arg0.timerText)
			local f44_local4 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					f57_arg0:beginAnimation(149)
					f57_arg0:setLeftRight(0.5, 0.5, 55, 125)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
				end
				f44_arg0.StrokeR:beginAnimation(870)
				f44_arg0.StrokeR:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.StrokeR:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f44_arg0.StrokeR:completeAnimation()
			f44_arg0.StrokeR:setLeftRight(0.5, 0.5, 55, 55)
			f44_local4(f44_arg0.StrokeR)
			local f44_local5 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					f59_arg0:beginAnimation(149)
					f59_arg0:setLeftRight(0.5, 0.5, -125, -55)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
				end
				f44_arg0.StrokeL:beginAnimation(870)
				f44_arg0.StrokeL:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.StrokeL:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f44_arg0.StrokeL:completeAnimation()
			f44_arg0.StrokeL:setLeftRight(0.5, 0.5, -55, -55)
			f44_local5(f44_arg0.StrokeL)
			local f44_local6 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					local f61_local0 = function(f62_arg0)
						f62_arg0:beginAnimation(50)
						f62_arg0:setAlpha(0)
						f62_arg0:setScale(1.5, 1.5)
						f62_arg0:registerEventHandler("transition_complete_keyframe", f44_arg0.clipFinished)
					end
					f61_arg0:beginAnimation(199)
					f61_arg0:setAlpha(0.2)
					f61_arg0:setScale(1.6, 1.6)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
				end
				f44_arg0.Base:beginAnimation(500)
				f44_arg0.Base:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.Base:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f44_arg0.Base:completeAnimation()
			f44_arg0.Base:setAlpha(1)
			f44_arg0.Base:setScale(0, 0)
			f44_local6(f44_arg0.Base)
		end,
	},
}
CoD.MatchStartWarning.__onClose = function(f63_arg0)
	f63_arg0.MatchStartWarningContainer0:close()
	f63_arg0.RadialTimer:close()
	f63_arg0.timerText:close()
	f63_arg0.Team1PlayerList:close()
end
