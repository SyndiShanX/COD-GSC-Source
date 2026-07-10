require("x64:c0a558f234790a5")
CoD.callingcards_snakegods_asset_hero = InheritFrom(LUI.UIElement)
CoD.callingcards_snakegods_asset_hero.__defaultWidth = 10
CoD.callingcards_snakegods_asset_hero.__defaultHeight = 10
CoD.callingcards_snakegods_asset_hero.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_snakegods_asset_hero)
	self.id = "callingcards_snakegods_asset_hero"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local snakehead = CoD.callingcards_snakegods_asset_herosnake.new(f1_arg0, f1_arg1, 0, 0, -244, 228, 0, 0, -262, 10)
	self:addElement(snakehead)
	self.snakehead = snakehead
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_snakegods_asset_hero.__resetProperties = function(f2_arg0)
	f2_arg0.snakehead:completeAnimation()
	f2_arg0.snakehead:setZRot(0)
end
CoD.callingcards_snakegods_asset_hero.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setZRot(10)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.snakehead:playClip("DefaultClip")
				f3_arg0.snakehead:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.snakehead:setZRot(0)
				f3_arg0.snakehead:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.snakehead:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.snakehead:completeAnimation()
			f3_arg0.snakehead:setZRot(10)
			f3_local0(f3_arg0.snakehead)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_snakegods_asset_hero.__onClose = function(f7_arg0)
	f7_arg0.snakehead:close()
end
