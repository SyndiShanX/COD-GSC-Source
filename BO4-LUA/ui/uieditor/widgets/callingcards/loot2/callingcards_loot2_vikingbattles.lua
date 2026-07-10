require("x64:5e3a2795c098049")
require("x64:b1e66064c1e62b6")
CoD[@"hash_18C2EA50F867B09B"] = InheritFrom(LUI.UIElement)
CoD[@"hash_18C2EA50F867B09B"].__defaultWidth = 960
CoD[@"hash_18C2EA50F867B09B"].__defaultHeight = 240
CoD[@"hash_18C2EA50F867B09B"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_18C2EA50F867B09B"])
	self.id = "callingcards_loot2_vikingbattles"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_menu_callingcards_vikingbattles_bg"))
	self:addElement(bg)
	self.bg = bg
	local crowd = LUI.UIImage.new(0, 0, 0, 952, 0, 0, -60, 308)
	crowd:setImage(RegisterImage(@"uie_ui_menu_callingcards_vikingbattles_crowd"))
	self:addElement(crowd)
	self.crowd = crowd
	local characters = CoD.callingcards_loot2_vikingbattles_characters.new(f1_arg0, f1_arg1, 0, 0, 216.5, 964.5, 0, 0, -48, 402)
	self:addElement(characters)
	self.characters = characters
	local blood02 = LUI.UIImage.new(0, 0, 511, 951, 0, 0, 0, 104)
	blood02:setImage(RegisterImage(@"uie_ui_menu_callingcards_vikingbattles_blood2"))
	self:addElement(blood02)
	self.blood02 = blood02
	local blood01 = CoD.callingcards_loot2_vikingbattles_blood01.new(f1_arg0, f1_arg1, 0, 0, 414.5, 424.5, 0, 0, 235, 245)
	self:addElement(blood01)
	self.blood01 = blood01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_18C2EA50F867B09B"].__resetProperties = function(f2_arg0)
	f2_arg0.characters:completeAnimation()
	f2_arg0.crowd:completeAnimation()
	f2_arg0.blood01:completeAnimation()
	f2_arg0.blood02:completeAnimation()
	f2_arg0.characters:setLeftRight(0, 0, 216.5, 964.5)
	f2_arg0.crowd:setLeftRight(0, 0, 0, 952)
	f2_arg0.crowd:setTopBottom(0, 0, -60, 308)
	f2_arg0.blood01:setLeftRight(0, 0, 414.5, 424.5)
	f2_arg0.blood01:setTopBottom(0, 0, 235, 245)
	f2_arg0.blood01:setZRot(0)
	f2_arg0.blood02:setLeftRight(0, 0, 511, 951)
	f2_arg0.blood02:setTopBottom(0, 0, 0, 104)
end
CoD[@"hash_18C2EA50F867B09B"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500)
					f5_arg0:setLeftRight(0, 0, -25, 927)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.crowd:beginAnimation(1500)
				f3_arg0.crowd:setLeftRight(0, 0, 0, 952)
				f3_arg0.crowd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.crowd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.crowd:completeAnimation()
			f3_arg0.crowd:setLeftRight(0, 0, -25, 927)
			f3_arg0.crowd:setTopBottom(0, 0, -60, 308)
			f3_local0(f3_arg0.crowd)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f7_arg0:setLeftRight(0, 0, 278, 1026)
					f7_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.characters:playClip("DefaultClip")
				f3_arg0.characters:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.characters:setLeftRight(0, 0, 244.5, 992.5)
				f3_arg0.characters:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.characters:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.characters:completeAnimation()
			f3_arg0.characters:setLeftRight(0, 0, 278, 1026)
			f3_local1(f3_arg0.characters)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f10_arg0:setLeftRight(0, 0, 511, 951)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.blood02:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.blood02:setLeftRight(0, 0, 552.5, 992.5)
				f3_arg0.blood02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.blood02:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.blood02:completeAnimation()
			f3_arg0.blood02:setLeftRight(0, 0, 511, 951)
			f3_arg0.blood02:setTopBottom(0, 0, 0, 104)
			f3_local2(f3_arg0.blood02)
			local f3_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f12_arg0:setLeftRight(0, 0, 475, 485)
					f12_arg0:setZRot(0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.blood01:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.blood01:setLeftRight(0, 0, 449, 459)
				f3_arg0.blood01:setZRot(10)
				f3_arg0.blood01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.blood01:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.blood01:completeAnimation()
			f3_arg0.blood01:setLeftRight(0, 0, 475, 485)
			f3_arg0.blood01:setTopBottom(0, 0, 240, 250)
			f3_arg0.blood01:setZRot(0)
			f3_local3(f3_arg0.blood01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_18C2EA50F867B09B"].__onClose = function(f13_arg0)
	f13_arg0.characters:close()
	f13_arg0.blood01:close()
end
