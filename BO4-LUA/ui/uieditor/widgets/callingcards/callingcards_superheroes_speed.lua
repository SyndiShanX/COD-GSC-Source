require("ui/uieditor/widgets/callingcards/callingcards_asset_superheroes_speed_hero")
require("ui/uieditor/widgets/callingcards/callingcards_asset_superheroes_speed_lightning")
CoD.callingcards_superheroes_speed = InheritFrom(LUI.UIElement)
CoD.callingcards_superheroes_speed.__defaultWidth = 960
CoD.callingcards_superheroes_speed.__defaultHeight = 240
CoD.callingcards_superheroes_speed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_superheroes_speed)
	self.id = "CallingCards_superheroes_speed"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"hash_4145C605F078F213"))
	self:addElement(bg)
	self.bg = bg
	local lightning03 = CoD.CallingCards_Asset_superheroes_speed_lightning.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(lightning03)
	self.lightning03 = lightning03
	local hero = CoD.CallingCards_Asset_superheroes_speed_hero.new(f1_arg0, f1_arg1, 0, 0, 576, 960, 0, 0, 0, 240)
	self:addElement(hero)
	self.hero = hero
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_superheroes_speed.__resetProperties = function(f2_arg0)
	f2_arg0.hero:completeAnimation()
	f2_arg0.lightning03:completeAnimation()
	f2_arg0.hero:setLeftRight(0, 0, 576, 960)
end
CoD.callingcards_superheroes_speed.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.lightning03:completeAnimation()
			f3_arg0.lightning03:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.lightning03)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1000)
					f5_arg0:setLeftRight(0, 0, 576, 960)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.hero:playClip("DefaultClip")
				f3_arg0.hero:beginAnimation(2000, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.hero:setLeftRight(0, 0, 686, 1070)
				f3_arg0.hero:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hero:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.hero:completeAnimation()
			f3_arg0.hero:setLeftRight(0, 0, 576, 960)
			f3_local0(f3_arg0.hero)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_superheroes_speed.__onClose = function(f7_arg0)
	f7_arg0.lightning03:close()
	f7_arg0.hero:close()
end
