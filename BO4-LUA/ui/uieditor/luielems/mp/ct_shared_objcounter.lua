CoD.ct_shared_objcounter = InheritFrom(CoD.Menu)
CoD.ct_shared_objcounter.__stateMap = {
	"DefaultState",
	"nototal",
	"nototal_update",
	"total",
	"total_update",
	"nototal_init",
	"total_init",
}
LUI.createMenu.ct_shared_objcounter = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ct_shared_objcounter", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ct_shared_objcounter)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local separator = LUI.UIText.new(0.5, 0.5, -904, -376, 0.5, 0.5, 151, 202)
	separator:setText(Engine[0xF9F1239CFD921FE](0xA1DD8EB81BD3558))
	separator:setTTF("ttmussels_regular")
	separator:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	separator:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	separator:setBackingType(2)
	separator:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	separator:setBackingAlpha(0.8)
	separator:setBackingXPadding(140)
	self:addElement(separator)
	self.separator = separator
	local count = LUI.UIText.new(0.5, 0.5, -818, -640, 0.5, 0.5, 151, 202)
	count:setTTF("ttmussels_regular")
	count:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	count:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	count:linkToElementModel(self, "objectiveCount", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			count:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(count)
	self.count = count
	local Total = LUI.UIText.new(0.5, 0.5, -640, -462, 0.5, 0.5, 151, 202)
	Total:setTTF("ttmussels_regular")
	Total:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Total:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Total:linkToElementModel(self, "objectiveTotal", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Total:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(Total)
	self.Total = Total
	local label = LUI.UIText.new(0.5, 0.5, -903.5, -375.5, 0.5, 0.5, 100, 139)
	label:setScale(0.8, 0.8)
	label:setTTF("ttmussels_regular")
	label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	label:setBackingType(2)
	label:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	label:setBackingAlpha(0.8)
	label:setBackingXPadding(14)
	label:linkToElementModel(self, "objectiveLabel", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			label:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(label)
	self.label = label
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.ct_shared_objcounter.__resetProperties = function(f5_arg0)
	f5_arg0.count:completeAnimation()
	f5_arg0.separator:completeAnimation()
	f5_arg0.Total:completeAnimation()
	f5_arg0.label:completeAnimation()
	f5_arg0.count:setAlpha(1)
	f5_arg0.count:setXRot(0)
	f5_arg0.count:setYRot(0)
	f5_arg0.count:setScale(1, 1)
	f5_arg0.separator:setAlpha(1)
	f5_arg0.separator:setText(Engine[0xF9F1239CFD921FE](0xA1DD8EB81BD3558))
	f5_arg0.separator:setBackingXPadding(140)
	f5_arg0.Total:setAlpha(1)
	f5_arg0.label:setYRot(0)
end
CoD.ct_shared_objcounter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.count:completeAnimation()
			f6_arg0.count:setAlpha(1)
			f6_arg0.count:setYRot(0)
			f6_arg0.clipFinished(f6_arg0.count)
		end,
	},
	nototal = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.separator:completeAnimation()
			f7_arg0.separator:setAlpha(1)
			f7_arg0.separator:setText(Engine[0xF9F1239CFD921FE](0x4E027043D62D489))
			f7_arg0.separator:setBackingXPadding(30)
			f7_arg0.clipFinished(f7_arg0.separator)
			f7_arg0.count:completeAnimation()
			f7_arg0.count:setAlpha(1)
			f7_arg0.count:setYRot(0)
			f7_arg0.clipFinished(f7_arg0.count)
			f7_arg0.Total:completeAnimation()
			f7_arg0.Total:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Total)
		end,
	},
	nototal_update = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.separator:completeAnimation()
			f8_arg0.separator:setAlpha(1)
			f8_arg0.separator:setText(Engine[0xF9F1239CFD921FE](0x4E027043D62D489))
			f8_arg0.separator:setBackingXPadding(30)
			f8_arg0.clipFinished(f8_arg0.separator)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(250)
					f10_arg0:setYRot(0)
					f10_arg0:setScale(1, 1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.count:beginAnimation(250)
				f8_arg0.count:setYRot(180)
				f8_arg0.count:setScale(1.3, 1.3)
				f8_arg0.count:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.count:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.count:completeAnimation()
			f8_arg0.count:setAlpha(1)
			f8_arg0.count:setXRot(0)
			f8_arg0.count:setYRot(0)
			f8_arg0.count:setScale(1, 1)
			f8_local0(f8_arg0.count)
			f8_arg0.Total:completeAnimation()
			f8_arg0.Total:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Total)
		end,
	},
	total = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.separator:completeAnimation()
			f11_arg0.separator:setBackingXPadding(30)
			f11_arg0.clipFinished(f11_arg0.separator)
			f11_arg0.count:completeAnimation()
			f11_arg0.count:setAlpha(1)
			f11_arg0.count:setYRot(0)
			f11_arg0.clipFinished(f11_arg0.count)
		end,
	},
	total_update = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.separator:completeAnimation()
			f12_arg0.separator:setBackingXPadding(30)
			f12_arg0.clipFinished(f12_arg0.separator)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(250)
					f14_arg0:setYRot(0)
					f14_arg0:setScale(1, 1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.count:beginAnimation(250)
				f12_arg0.count:setYRot(180)
				f12_arg0.count:setScale(1.3, 1.3)
				f12_arg0.count:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.count:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.count:completeAnimation()
			f12_arg0.count:setXRot(0)
			f12_arg0.count:setYRot(0)
			f12_arg0.count:setScale(1, 1)
			f12_local0(f12_arg0.count)
		end,
	},
	nototal_init = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.separator:completeAnimation()
			f15_arg0.separator:setAlpha(1)
			f15_arg0.separator:setText(Engine[0xF9F1239CFD921FE](0x4E027043D62D489))
			f15_arg0.separator:setBackingXPadding(30)
			f15_arg0.clipFinished(f15_arg0.separator)
			f15_arg0.Total:completeAnimation()
			f15_arg0.Total:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Total)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(250)
					f17_arg0:setYRot(0)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.label:beginAnimation(250)
				f15_arg0.label:setYRot(180)
				f15_arg0.label:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.label:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.label:completeAnimation()
			f15_arg0.label:setYRot(0)
			f15_local0(f15_arg0.label)
		end,
	},
	total_init = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.separator:completeAnimation()
			f18_arg0.separator:setBackingXPadding(30)
			f18_arg0.clipFinished(f18_arg0.separator)
			f18_arg0.count:completeAnimation()
			f18_arg0.count:setAlpha(1)
			f18_arg0.count:setYRot(0)
			f18_arg0.clipFinished(f18_arg0.count)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(250)
					f20_arg0:setYRot(0)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.label:beginAnimation(250)
				f18_arg0.label:setYRot(180)
				f18_arg0.label:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.label:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.label:completeAnimation()
			f18_arg0.label:setYRot(0)
			f18_local0(f18_arg0.label)
		end,
	},
}
CoD.ct_shared_objcounter.__onClose = function(f21_arg0)
	f21_arg0.count:close()
	f21_arg0.Total:close()
	f21_arg0.label:close()
end
