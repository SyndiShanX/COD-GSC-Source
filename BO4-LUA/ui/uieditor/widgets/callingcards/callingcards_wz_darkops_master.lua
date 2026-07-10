require("x64:e7d335abae7bbd4")
CoD[@"hash_5A6A41AD9A5A2C18"] = InheritFrom(LUI.UIElement)
CoD[@"hash_5A6A41AD9A5A2C18"].__defaultWidth = 960
CoD[@"hash_5A6A41AD9A5A2C18"].__defaultHeight = 240
CoD[@"hash_5A6A41AD9A5A2C18"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_5A6A41AD9A5A2C18"])
	self.id = "CallingCards_wz_DarkOps_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_darkops_master_background"))
	self:addElement(bg)
	self.bg = bg
	local gunner = CoD.CallingCards_Asset_techGunner_Helicopter.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(gunner)
	self.gunner = gunner
	local bulletFall1 = LUI.UIImage.new(0, 0, 122.5, 506.5, 0, 0, 0, 240)
	bulletFall1:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_darkops_master_bulletdrop1"))
	bulletFall1:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	bulletFall1:setShaderVector(0, 1, 1, 0, 0)
	bulletFall1:setShaderVector(1, 0, -0.25, 0, 0)
	self:addElement(bulletFall1)
	self.bulletFall1 = bulletFall1
	local bulletFall2 = LUI.UIImage.new(0, 0, 701, 1085, 0, 0, 0, 240)
	bulletFall2:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_darkops_master_bulletdrop2"))
	bulletFall2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	bulletFall2:setShaderVector(0, 1, 1, 0, 0)
	bulletFall2:setShaderVector(1, 0, -0.25, 0, 0)
	self:addElement(bulletFall2)
	self.bulletFall2 = bulletFall2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_5A6A41AD9A5A2C18"].__resetProperties = function(f2_arg0)
	f2_arg0.gunner:completeAnimation()
	f2_arg0.gunner:setTopBottom(0, 0, 0, 240)
end
CoD[@"hash_5A6A41AD9A5A2C18"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(810)
					f5_arg0:setTopBottom(0, 0, 0, 240)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.gunner:playClip("DefaultClip")
				f3_arg0.gunner:beginAnimation(180)
				f3_arg0.gunner:setTopBottom(0, 0, -7, 233)
				f3_arg0.gunner:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gunner:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.gunner:completeAnimation()
			f3_arg0.gunner:setTopBottom(0, 0, 0, 240)
			f3_local0(f3_arg0.gunner)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_5A6A41AD9A5A2C18"].__onClose = function(f7_arg0)
	f7_arg0.gunner:close()
end
