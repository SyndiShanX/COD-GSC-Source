require("x64:bda9dc9c42ba19a")
CoD.ItemNewBreadcrumbWidget = InheritFrom(LUI.UIElement)
CoD.ItemNewBreadcrumbWidget.__defaultWidth = 156
CoD.ItemNewBreadcrumbWidget.__defaultHeight = 36
CoD.ItemNewBreadcrumbWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemNewBreadcrumbWidget)
	self.id = "ItemNewBreadcrumbWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BgIcon = CoD.NewBreadcrumbLarge.new(f1_arg0, f1_arg1, 0.5, 0.5, -66, 66, 0.5, 0.5, -22, 22)
	self:addElement(BgIcon)
	self.BgIcon = BgIcon
	local itemName = LUI.UIText.new(0.5, 0.5, -49, 49, 0.5, 0.5, -10, 11)
	itemName:setRGB(0, 0, 0)
	itemName:setText(LocalizeToUpperString(0x93E719493E9E18F))
	itemName:setTTF("ttmussels_demibold")
	itemName:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	itemName:setLetterSpacing(1.5)
	itemName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(itemName)
	self.itemName = itemName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemNewBreadcrumbWidget.__resetProperties = function(f2_arg0)
	f2_arg0.itemName:completeAnimation()
	f2_arg0.BgIcon:completeAnimation()
	f2_arg0.itemName:setAlpha(1)
	f2_arg0.BgIcon:setAlpha(1)
end
CoD.ItemNewBreadcrumbWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.BgIcon:beginAnimation(150)
				f3_arg0.BgIcon:setAlpha(1)
				f3_arg0.BgIcon:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BgIcon:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.BgIcon:completeAnimation()
			f3_arg0.BgIcon:setAlpha(0)
			f3_local0(f3_arg0.BgIcon)
			local f3_local1 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(150, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f6_arg0:setAlpha(1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.itemName:beginAnimation(100)
				f3_arg0.itemName:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.itemName:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f3_arg0.itemName:completeAnimation()
			f3_arg0.itemName:setAlpha(0)
			f3_local1(f3_arg0.itemName)
		end,
	},
}
CoD.ItemNewBreadcrumbWidget.__onClose = function(f7_arg0)
	f7_arg0.BgIcon:close()
end
