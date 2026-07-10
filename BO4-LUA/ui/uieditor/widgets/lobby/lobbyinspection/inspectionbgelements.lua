require("x64:6fdb923ebdf4557")
require("x64:7091ab951f39f56")
require("x64:74865184d366449")
require("x64:74864184d366296")
require("x64:1f150bc74d5590f")
CoD.InspectionBgElements = InheritFrom(LUI.UIElement)
CoD.InspectionBgElements.__defaultWidth = 1748
CoD.InspectionBgElements.__defaultHeight = 618
CoD.InspectionBgElements.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionBgElements)
	self.id = "InspectionBgElements"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local LinkVline02 = CoD.CommonBgLayoutLinkLine.new(f1_arg0, f1_arg1, 0, 0, 691, 1400, 0, 0, 589, 618)
	LinkVline02:setZRot(90)
	LinkVline02:setZoom(40)
	self:addElement(LinkVline02)
	self.LinkVline02 = LinkVline02
	local AnalysingBacking = CoD.CommonAnalysingIndicator.new(f1_arg0, f1_arg1, 0, 0, 1390, 1708, 0, 0, -278, -166)
	self:addElement(AnalysingBacking)
	self.AnalysingBacking = AnalysingBacking
	local InspecReticle = CoD.CommonAnalysingReticle.new(f1_arg0, f1_arg1, 0, 0, 1057, 1333, 0, 0, 89, 365)
	InspecReticle:setAlpha(0)
	self:addElement(InspecReticle)
	self.InspecReticle = InspecReticle
	local LinkHline01 = CoD.CommonBgLayoutLinkLine.new(f1_arg0, f1_arg1, 0, 0, 490, 1199, 0, 0, 464, 493)
	LinkHline01:setZoom(-80)
	self:addElement(LinkHline01)
	self.LinkHline01 = LinkHline01
	local LinkVline01 = CoD.CommonBgLayoutLinkLine.new(f1_arg0, f1_arg1, 0, 0, -82, 627, 0, 0, 0, 29)
	LinkVline01:setZRot(-90)
	LinkVline01:setZoom(40)
	self:addElement(LinkVline01)
	self.LinkVline01 = LinkVline01
	local LayoutElement02 = CoD.CommonBgLayoutElement02.new(f1_arg0, f1_arg1, 0, 0, 81, 385, 0, 0, -256, -180)
	LayoutElement02:setZoom(100)
	LayoutElement02:setScale(0.5, 0.5)
	self:addElement(LayoutElement02)
	self.LayoutElement02 = LayoutElement02
	local BoxHighlighted = CoD.CommonBgLayoutElement03.new(f1_arg0, f1_arg1, 0.5, 0.5, 1029, 1105, 0, 0, 374, 754)
	BoxHighlighted:setScale(0.5, 0.5)
	self:addElement(BoxHighlighted)
	self.BoxHighlighted = BoxHighlighted
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionBgElements.__onClose = function(f2_arg0)
	f2_arg0.LinkVline02:close()
	f2_arg0.AnalysingBacking:close()
	f2_arg0.InspecReticle:close()
	f2_arg0.LinkHline01:close()
	f2_arg0.LinkVline01:close()
	f2_arg0.LayoutElement02:close()
	f2_arg0.BoxHighlighted:close()
end
