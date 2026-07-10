require("x64:5cb43180fc65bb6")
require("x64:3195d3ca15044e")
require("x64:7b84dce3c602575")
CoD.HUBTagPreview = InheritFrom(LUI.UIElement)
CoD.HUBTagPreview.__defaultWidth = 547
CoD.HUBTagPreview.__defaultHeight = 690
CoD.HUBTagPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUBTagPreview)
	self.id = "HUBTagPreview"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emblemDrawWidget = CoD.EmblemDrawWidgetNoImage.new(f1_arg0, f1_arg1, 0, 0, 4, 544, 0, 0, 0, 540)
	self:addElement(emblemDrawWidget)
	self.emblemDrawWidget = emblemDrawWidget
	local PreviewedTag = LUI.UIImage.new(0, 0, 19, 529, 0, 0, 15, 525)
	PreviewedTag:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PreviewedTag:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PreviewedTag)
	self.PreviewedTag = PreviewedTag
	local TagItemInfoPanel = CoD.Tag_ItemInfoPanel.new(f1_arg0, f1_arg1, 1, 1, -543, -3, 1, 1, -150.5, -0.5)
	TagItemInfoPanel.SceneBlur:setAlpha(0)
	TagItemInfoPanel:linkToElementModel(self, nil, false, function(model)
		TagItemInfoPanel:setModel(model, f1_arg1)
	end)
	self:addElement(TagItemInfoPanel)
	self.TagItemInfoPanel = TagItemInfoPanel
	local BMGoldBar = CoD.BM_GoldBarLarge.new(f1_arg0, f1_arg1, 0, 0, 4, 544, 0, 0, 241, 299)
	BMGoldBar:setAlpha(0)
	self:addElement(BMGoldBar)
	self.BMGoldBar = BMGoldBar
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available")
			end,
		},
	})
	self:linkToElementModel(self, "available", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HUBTagPreview.__resetProperties = function(f6_arg0)
	f6_arg0.PreviewedTag:completeAnimation()
	f6_arg0.BMGoldBar:completeAnimation()
	f6_arg0.PreviewedTag:setAlpha(1)
	f6_arg0.BMGoldBar:setAlpha(0)
end
CoD.HUBTagPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Unavailable = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.PreviewedTag:completeAnimation()
			f8_arg0.PreviewedTag:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PreviewedTag)
			f8_arg0.BMGoldBar:completeAnimation()
			f8_arg0.BMGoldBar:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.BMGoldBar)
		end,
	},
}
CoD.HUBTagPreview.__onClose = function(f9_arg0)
	f9_arg0.emblemDrawWidget:close()
	f9_arg0.PreviewedTag:close()
	f9_arg0.TagItemInfoPanel:close()
	f9_arg0.BMGoldBar:close()
end
