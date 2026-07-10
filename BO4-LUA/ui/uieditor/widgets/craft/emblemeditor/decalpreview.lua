require("x64:fbffc86e9a93477")
require("x64:da97d095e7674d3")
require("x64:a24b28b508f6914")
CoD.DecalPreview = InheritFrom(LUI.UIElement)
CoD.DecalPreview.__defaultWidth = 540
CoD.DecalPreview.__defaultHeight = 725
CoD.DecalPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DecalPreview)
	self.id = "DecalPreview"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emblemDraw = CoD.EmblemDrawWidgetNew.new(f1_arg0, f1_arg1, 0.5, 0.5, -270, 270, 0, 0, 8, 548)
	emblemDraw:linkToElementModel(self, nil, false, function(model)
		emblemDraw:setModel(model, f1_arg1)
	end)
	emblemDraw:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		MakeNotFocusable(element, f1_arg1)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(emblemDraw)
	self.emblemDraw = emblemDraw
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 2, 114, 0, 0, -8, 8)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local ItemInfoPanel = CoD.BM_ItemInfoPanel.new(f1_arg0, f1_arg1, 1, 1, -540, 0, 1, 1, -177, -27)
	ItemInfoPanel:linkToElementModel(self, nil, false, function(model)
		ItemInfoPanel:setModel(model, f1_arg1)
	end)
	self:addElement(ItemInfoPanel)
	self.ItemInfoPanel = ItemInfoPanel
	self:mergeStateConditions({
		{
			stateName = "HideInfoPanel",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if CoD.isPC then
		emblemDraw.id = "emblemDraw"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DecalPreview.__resetProperties = function(f6_arg0)
	f6_arg0.ItemInfoPanel:completeAnimation()
	f6_arg0.ItemInfoPanel:setAlpha(1)
end
CoD.DecalPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	HideInfoPanel = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ItemInfoPanel:completeAnimation()
			f8_arg0.ItemInfoPanel:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ItemInfoPanel)
		end,
	},
}
CoD.DecalPreview.__onClose = function(f9_arg0)
	f9_arg0.emblemDraw:close()
	f9_arg0.TabbedScoreboardFuiBox:close()
	f9_arg0.ItemInfoPanel:close()
end
