require("x64:beca79f2b24494b")
require("x64:93dc93d9fba3bb8")
require("x64:b51ec62a29bba9a")
CoD.TabbedScoreboardMapInfoboxRight = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardMapInfoboxRight.__defaultWidth = 188
CoD.TabbedScoreboardMapInfoboxRight.__defaultHeight = 94
CoD.TabbedScoreboardMapInfoboxRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardMapInfoboxRight)
	self.id = "TabbedScoreboardMapInfoboxRight"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InfoRIghtBG = LUI.UIImage.new(0, 0, 0, 188, 0, 0, 75, 75)
	InfoRIghtBG:setImage(RegisterImage(0x179F8C7A3100CD7))
	self:addElement(InfoRIghtBG)
	self.InfoRIghtBG = InfoRIghtBG
	local TerrainAdd = CoD.TabbedScoreboardInfoTerrain.new(f1_arg0, f1_arg1, 0, 0, -1, 189, 0, 0, 7, 77)
	self:addElement(TerrainAdd)
	self.TerrainAdd = TerrainAdd
	local InfoRightBotBar = LUI.UIImage.new(0, 0, 0, 188, 0, 0, 89, 97)
	InfoRightBotBar:setRGB(0.95, 0.95, 0.95)
	InfoRightBotBar:setImage(RegisterImage(0xFCFDB982EBF8906))
	self:addElement(InfoRightBotBar)
	self.InfoRightBotBar = InfoRightBotBar
	local InfoStripe = CoD.TabbedScoreboardInfoStripe.new(f1_arg0, f1_arg1, 0, 0, -4, 184, 0, 0, 71, 95)
	self:addElement(InfoStripe)
	self.InfoStripe = InfoStripe
	local InfoRightRedBar = LUI.UIImage.new(0, 0, 0, 188, 0, 0, 75, 91)
	InfoRightRedBar:setImage(RegisterImage(0x78CAD9EF906ADDA))
	self:addElement(InfoRightRedBar)
	self.InfoRightRedBar = InfoRightRedBar
	local InfoRightTopBar = LUI.UIImage.new(0, 0, 0, 188, 0, 0, 69, 77)
	InfoRightTopBar:setRGB(0.95, 0.95, 0.95)
	InfoRightTopBar:setImage(RegisterImage(0xFCFDB982EBF8906))
	self:addElement(InfoRightTopBar)
	self.InfoRightTopBar = InfoRightTopBar
	local Fui = LUI.UIImage.new(0, 0, 2, 188, 0, 0, -3, 71)
	Fui:setImage(RegisterImage(0x2BFA29122B19C83))
	self:addElement(Fui)
	self.Fui = Fui
	local CursorFocus = CoD.TabbedScoreboardInfoCursor.new(f1_arg0, f1_arg1, 0, 0, 51.5, 81.5, 0, 0, 23, 53)
	self:addElement(CursorFocus)
	self.CursorFocus = CursorFocus
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardMapInfoboxRight.__resetProperties = function(f2_arg0)
	f2_arg0.InfoStripe:completeAnimation()
	f2_arg0.InfoRightRedBar:completeAnimation()
	f2_arg0.InfoRIghtBG:completeAnimation()
	f2_arg0.InfoRightTopBar:completeAnimation()
	f2_arg0.Fui:completeAnimation()
	f2_arg0.TerrainAdd:completeAnimation()
	f2_arg0.CursorFocus:completeAnimation()
	f2_arg0.InfoStripe:setAlpha(1)
	f2_arg0.InfoRightRedBar:setAlpha(1)
	f2_arg0.InfoRIghtBG:setTopBottom(0, 0, 75, 75)
	f2_arg0.InfoRIghtBG:setAlpha(1)
	f2_arg0.InfoRightTopBar:setTopBottom(0, 0, 69, 77)
	f2_arg0.InfoRightTopBar:setAlpha(1)
	f2_arg0.Fui:setAlpha(1)
	f2_arg0.TerrainAdd:setAlpha(1)
	f2_arg0.CursorFocus:setAlpha(1)
end
CoD.TabbedScoreboardMapInfoboxRight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(7)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f5_arg0:setTopBottom(0, 0, 7, 75)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f4_arg0:beginAnimation(199)
				f4_arg0:setTopBottom(0, 0, 55.57, 75)
				f4_arg0:setAlpha(1)
				f4_arg0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.InfoRIghtBG:beginAnimation(1900)
			f3_arg0.InfoRIghtBG:setTopBottom(0, 0, 75, 75)
			f3_arg0.InfoRIghtBG:setAlpha(0)
			f3_arg0.InfoRIghtBG:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.InfoRIghtBG:registerEventHandler("transition_complete_keyframe", f3_local0)
			local f3_local1 = function(f6_arg0)
				f6_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f6_arg0:setAlpha(1)
				f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.TerrainAdd:beginAnimation(2600)
			f3_arg0.TerrainAdd:setAlpha(0)
			f3_arg0.TerrainAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.TerrainAdd:registerEventHandler("transition_complete_keyframe", f3_local1)
			local f3_local2 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(199)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f7_arg0:playClip("DefaultClip")
				f7_arg0:beginAnimation(799)
				f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.InfoStripe:beginAnimation(1100)
			f3_arg0.InfoStripe:setAlpha(1)
			f3_arg0.InfoStripe:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.InfoStripe:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(199)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f10_arg0:beginAnimation(799)
				f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.InfoRightRedBar:beginAnimation(1100)
			f3_arg0.InfoRightRedBar:setAlpha(0)
			f3_arg0.InfoRightRedBar:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.InfoRightRedBar:registerEventHandler("transition_complete_keyframe", f3_local3)
			local f3_local4 = function(f12_arg0)
				f12_arg0:beginAnimation(699, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f12_arg0:setTopBottom(0, 0, 0, 8)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.InfoRightTopBar:beginAnimation(1900)
			f3_arg0.InfoRightTopBar:setTopBottom(0, 0, 69, 77)
			f3_arg0.InfoRightTopBar:setAlpha(1)
			f3_arg0.InfoRightTopBar:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.InfoRightTopBar:registerEventHandler("transition_complete_keyframe", f3_local4)
			local f3_local5 = function(f13_arg0)
				f13_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f13_arg0:setAlpha(1)
				f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Fui:beginAnimation(2600)
			f3_arg0.Fui:setAlpha(0)
			f3_arg0.Fui:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.Fui:registerEventHandler("transition_complete_keyframe", f3_local5)
			f3_arg0.CursorFocus:beginAnimation(2900)
			f3_arg0.CursorFocus:setAlpha(1)
			f3_arg0.CursorFocus:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.CursorFocus:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playClip("DefaultClip")
				f3_arg0.clipFinished(element, event)
			end)
		end,
	},
}
CoD.TabbedScoreboardMapInfoboxRight.__onClose = function(f15_arg0)
	f15_arg0.TerrainAdd:close()
	f15_arg0.InfoStripe:close()
	f15_arg0.CursorFocus:close()
end
