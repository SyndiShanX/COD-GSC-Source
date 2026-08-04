require("ui/uieditor/widgets/callingcards/callingcards_snakegods_asset_snakehead")
CoD.callingcards_snakegods_asset_herosnake = InheritFrom(LUI.UIElement)
CoD.callingcards_snakegods_asset_herosnake.__defaultWidth = 472
CoD.callingcards_snakegods_asset_herosnake.__defaultHeight = 272
CoD.callingcards_snakegods_asset_herosnake.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_snakegods_asset_herosnake)
	self.id = "callingcards_snakegods_asset_herosnake"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local hero = LUI.UIImage.new(0, 0, 0, 472, 0, 0, 0, 272)
	hero:setImage(RegisterImage("uie_ui_menu_callingcards_snake_gods_hero"))
	self:addElement(hero)
	self.hero = hero
	local snakehead = CoD.callingcards_snakegods_asset_snakehead.new(f1_arg0, f1_arg1, 0, 0, 25, 35, 0, 0, 76.5, 86.5)
	snakehead:setZRot(15)
	self:addElement(snakehead)
	self.snakehead = snakehead
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_snakegods_asset_herosnake.__resetProperties = function(f2_arg0)
	f2_arg0.snakehead:completeAnimation()
	f2_arg0.snakehead:setZRot(15)
end
CoD.callingcards_snakegods_asset_herosnake.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setZRot(-15)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.snakehead:beginAnimation(1500, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.snakehead:setZRot(15)
				f3_arg0.snakehead:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.snakehead:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.snakehead:completeAnimation()
			f3_arg0.snakehead:setZRot(-15)
			f3_local0(f3_arg0.snakehead)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_snakegods_asset_herosnake.__onClose = function(f6_arg0)
	f6_arg0.snakehead:close()
end
