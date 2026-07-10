require("x64:a90c651f34c6414")
require("x64:ab46e4d00941143")
CoD[0xF9B8B7EB4A5FEE] = InheritFrom(LUI.UIElement)
CoD[0xF9B8B7EB4A5FEE].__defaultWidth = 960
CoD[0xF9B8B7EB4A5FEE].__defaultHeight = 240
CoD[0xF9B8B7EB4A5FEE].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0xF9B8B7EB4A5FEE])
	self.id = "callingcards_loot2_surrealistlandscapes"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0xA260E4DE48FDD91))
	self:addElement(bg)
	self.bg = bg
	local ball = CoD.callingcards_loot2_surrealistlandscapes_stairs.new(f1_arg0, f1_arg1, 0, 0, 0, 512, 0, 0, 0, 240)
	self:addElement(ball)
	self.ball = ball
	local cloud01 = LUI.UIImage.new(0, 0, 0, 424, 0, 0, 120, 240)
	cloud01:setAlpha(0.5)
	cloud01:setImage(RegisterImage(0xB9B10B7FFA7EE98))
	cloud01:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cloud01)
	self.cloud01 = cloud01
	local book = CoD.callingcards_loot2_surrealistlandscapes_book.new(f1_arg0, f1_arg1, 0, 0, 256, 960, 0, 0, 0, 240)
	self:addElement(book)
	self.book = book
	local cloud02 = LUI.UIImage.new(0, 0, 424, 960, 0, 0, 80, 240)
	cloud02:setAlpha(0.7)
	cloud02:setImage(RegisterImage(0xB9B13B7FFA7F3B1))
	cloud02:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cloud02)
	self.cloud02 = cloud02
	local cloud = LUI.UIImage.new(0, 0, 167, 519, 0, 0, 0, 64)
	cloud:setAlpha(0.7)
	cloud:setImage(RegisterImage(0xB9B12B7FFA7F1FE))
	cloud:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(cloud)
	self.cloud = cloud
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0xF9B8B7EB4A5FEE].__resetProperties = function(f2_arg0)
	f2_arg0.book:completeAnimation()
	f2_arg0.ball:completeAnimation()
	f2_arg0.cloud01:completeAnimation()
	f2_arg0.cloud02:completeAnimation()
	f2_arg0.cloud:completeAnimation()
	f2_arg0.book:setLeftRight(0, 0, 256, 960)
	f2_arg0.book:setTopBottom(0, 0, 0, 240)
	f2_arg0.ball:setLeftRight(0, 0, 0, 512)
	f2_arg0.ball:setTopBottom(0, 0, 0, 240)
	f2_arg0.cloud01:setLeftRight(0, 0, 0, 424)
	f2_arg0.cloud01:setTopBottom(0, 0, 120, 240)
	f2_arg0.cloud02:setLeftRight(0, 0, 424, 960)
	f2_arg0.cloud02:setTopBottom(0, 0, 80, 240)
	f2_arg0.cloud:setLeftRight(0, 0, 167, 519)
	f2_arg0.cloud:setTopBottom(0, 0, 0, 64)
end
CoD[0xF9B8B7EB4A5FEE].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500)
					f5_arg0:setLeftRight(0, 0, -23, 489)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.ball:playClip("DefaultClip")
				f3_arg0.ball:beginAnimation(1500)
				f3_arg0.ball:setLeftRight(0, 0, 0, 512)
				f3_arg0.ball:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ball:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ball:completeAnimation()
			f3_arg0.ball:setLeftRight(0, 0, -23, 489)
			f3_arg0.ball:setTopBottom(0, 0, 0, 240)
			f3_local0(f3_arg0.ball)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(1500)
					f8_arg0:setLeftRight(0, 0, 0, 424)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.cloud01:beginAnimation(1500)
				f3_arg0.cloud01:setLeftRight(0, 0, -5, 419)
				f3_arg0.cloud01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cloud01:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.cloud01:completeAnimation()
			f3_arg0.cloud01:setLeftRight(0, 0, 0, 424)
			f3_arg0.cloud01:setTopBottom(0, 0, 120, 240)
			f3_local1(f3_arg0.cloud01)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(1500)
					f10_arg0:setLeftRight(0, 0, 285, 989)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.book:beginAnimation(1500)
				f3_arg0.book:setLeftRight(0, 0, 256, 960)
				f3_arg0.book:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.book:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.book:completeAnimation()
			f3_arg0.book:setLeftRight(0, 0, 285, 989)
			f3_arg0.book:setTopBottom(0, 0, 0, 240)
			f3_local2(f3_arg0.book)
			local f3_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(1500)
					f12_arg0:setLeftRight(0, 0, 424, 960)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.cloud02:beginAnimation(1500)
				f3_arg0.cloud02:setLeftRight(0, 0, 444, 980)
				f3_arg0.cloud02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cloud02:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.cloud02:completeAnimation()
			f3_arg0.cloud02:setLeftRight(0, 0, 424, 960)
			f3_arg0.cloud02:setTopBottom(0, 0, 80, 240)
			f3_local3(f3_arg0.cloud02)
			local f3_local4 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(1500)
					f14_arg0:setLeftRight(0, 0, 167, 519)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.cloud:beginAnimation(1500)
				f3_arg0.cloud:setLeftRight(0, 0, 222, 574)
				f3_arg0.cloud:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cloud:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.cloud:completeAnimation()
			f3_arg0.cloud:setLeftRight(0, 0, 167, 519)
			f3_arg0.cloud:setTopBottom(0, 0, 0, 64)
			f3_local4(f3_arg0.cloud)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0xF9B8B7EB4A5FEE].__onClose = function(f15_arg0)
	f15_arg0.ball:close()
	f15_arg0.book:close()
end
