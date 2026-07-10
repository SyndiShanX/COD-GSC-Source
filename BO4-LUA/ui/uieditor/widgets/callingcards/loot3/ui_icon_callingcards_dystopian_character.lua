require("x64:780c1e32038fe94")
require("x64:4397d3e9a579e9c")
require("x64:5a80a5001fdb28e")
CoD.ui_icon_callingcards_dystopian_character = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_dystopian_character.__defaultWidth = 272
CoD.ui_icon_callingcards_dystopian_character.__defaultHeight = 261
CoD.ui_icon_callingcards_dystopian_character.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_dystopian_character)
	self.id = "ui_icon_callingcards_dystopian_character"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arm = CoD.ui_icon_callingcards_dystopian_armmove.new(f1_arg0, f1_arg1, 0, 0, 106.5, 116.5, 0, 0, 92.5, 102.5)
	self:addElement(arm)
	self.arm = arm
	local body = CoD.ui_icon_callingcards_dystopian_bodyglow.new(f1_arg0, f1_arg1, 0, 0, 0, 272, 0, 0, 60.5, 260.5)
	self:addElement(body)
	self.body = body
	local uiiconcallingcardsdystopianheadglow = CoD.ui_icon_callingcards_dystopian_headglow.new(f1_arg0, f1_arg1, 0, 0, 92.5, 188.5, 0, 0, 0, 112)
	self:addElement(uiiconcallingcardsdystopianheadglow)
	self.uiiconcallingcardsdystopianheadglow = uiiconcallingcardsdystopianheadglow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_dystopian_character.__resetProperties = function(f2_arg0)
	f2_arg0.arm:completeAnimation()
	f2_arg0.body:completeAnimation()
	f2_arg0.uiiconcallingcardsdystopianheadglow:completeAnimation()
	f2_arg0.arm:setZRot(0)
	f2_arg0.uiiconcallingcardsdystopianheadglow:setLeftRight(0, 0, 92.5, 188.5)
	f2_arg0.uiiconcallingcardsdystopianheadglow:setTopBottom(0, 0, 0, 112)
end
CoD.ui_icon_callingcards_dystopian_character.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setZRot(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.arm:playClip("DefaultClip")
				f3_arg0.arm:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.arm:setZRot(24)
				f3_arg0.arm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.arm:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.arm:completeAnimation()
			f3_arg0.arm:setZRot(0)
			f3_local0(f3_arg0.arm)
			f3_arg0.body:completeAnimation()
			f3_arg0.body:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.body)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							local f10_local0 = function(f11_arg0)
								local f11_local0 = function(f12_arg0)
									f12_arg0:beginAnimation(1100)
									f12_arg0:setTopBottom(0, 0, 0, 112)
									f12_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
										element:playClip("DefaultClip")
										f3_arg0.clipFinished(element, event)
									end)
								end
								f11_arg0:beginAnimation(199)
								f11_arg0:setTopBottom(0, 0, -1, 111)
								f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
							end
							f10_arg0:beginAnimation(200)
							f10_arg0:setTopBottom(0, 0, 5, 117)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
						end
						f9_arg0:beginAnimation(1100)
						f9_arg0:setTopBottom(0, 0, 4.15, 116.15)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(200)
					f8_arg0:setTopBottom(0, 0, -0.5, 111.5)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.uiiconcallingcardsdystopianheadglow:playClip("DefaultClip")
				f3_arg0.uiiconcallingcardsdystopianheadglow:beginAnimation(200)
				f3_arg0.uiiconcallingcardsdystopianheadglow:setTopBottom(0, 0, 5, 117)
				f3_arg0.uiiconcallingcardsdystopianheadglow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.uiiconcallingcardsdystopianheadglow:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.uiiconcallingcardsdystopianheadglow:completeAnimation()
			f3_arg0.uiiconcallingcardsdystopianheadglow:setLeftRight(0, 0, 92.5, 188.5)
			f3_arg0.uiiconcallingcardsdystopianheadglow:setTopBottom(0, 0, 0, 112)
			f3_local1(f3_arg0.uiiconcallingcardsdystopianheadglow)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_dystopian_character.__onClose = function(f14_arg0)
	f14_arg0.arm:close()
	f14_arg0.body:close()
	f14_arg0.uiiconcallingcardsdystopianheadglow:close()
end
