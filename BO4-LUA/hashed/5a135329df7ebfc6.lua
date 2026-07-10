CoD.ClassMiniPreviewTalentItem = InheritFrom(LUI.UIElement)
CoD.ClassMiniPreviewTalentItem.__defaultWidth = 70
CoD.ClassMiniPreviewTalentItem.__defaultHeight = 70
CoD.ClassMiniPreviewTalentItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClassMiniPreviewTalentItem)
	self.id = "ClassMiniPreviewTalentItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local noslotIcon = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	noslotIcon:setAlpha(0.01)
	noslotIcon:setScale(0.4, 0.4)
	noslotIcon:setImage(RegisterImage(0x35CB0919FD78E83))
	self:addElement(noslotIcon)
	self.noslotIcon = noslotIcon
	local TalenImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -35, 35, 0.5, 0.5, -35, 35)
	TalenImage.__Image = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			TalenImage:setImage(RegisterImage(f2_local0))
		end
	end
	TalenImage:linkToElementModel(self, "loadoutListItem", true, function(model, f3_arg1)
		if f3_arg1["__TalenImage.__Image_loadoutListItem->image"] then
			f3_arg1:removeSubscription(f3_arg1["__TalenImage.__Image_loadoutListItem->image"])
			f3_arg1["__TalenImage.__Image_loadoutListItem->image"] = nil
		end
		if model then
			local f3_local0 = model:get()
			local f3_local1 = model:get()
			model = f3_local0 and f3_local1.image
		end
		if model then
			f3_arg1["__TalenImage.__Image_loadoutListItem->image"] = f3_arg1:subscribeToModel(model, TalenImage.__Image)
		end
	end)
	self:addElement(TalenImage)
	self.TalenImage = TalenImage
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ClassMiniPreviewTalentItem.__resetProperties = function(f5_arg0)
	f5_arg0.noslotIcon:completeAnimation()
	f5_arg0.TalenImage:completeAnimation()
	f5_arg0.noslotIcon:setAlpha(0.01)
	f5_arg0.TalenImage:setAlpha(1)
end
CoD.ClassMiniPreviewTalentItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.noslotIcon:completeAnimation()
			f6_arg0.noslotIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.noslotIcon)
		end,
	},
	Unavailable = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.noslotIcon:completeAnimation()
			f7_arg0.noslotIcon:setAlpha(0.02)
			f7_arg0.clipFinished(f7_arg0.noslotIcon)
			f7_arg0.TalenImage:completeAnimation()
			f7_arg0.TalenImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TalenImage)
		end,
	},
}
CoD.ClassMiniPreviewTalentItem.__onClose = function(f8_arg0)
	f8_arg0.TalenImage:close()
end
