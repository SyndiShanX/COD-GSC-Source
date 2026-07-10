require("x64:deb8ba375fb517")
require("x64:d7ba7c36104672")
require("x64:6a86b30ee58a2f")
require("x64:34d733b496c82ec")
CoD.fe_FooterContainer_NOTLobby = InheritFrom(LUI.UIElement)
CoD.fe_FooterContainer_NOTLobby.__defaultWidth = 1920
CoD.fe_FooterContainer_NOTLobby.__defaultHeight = 97
CoD.fe_FooterContainer_NOTLobby.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.fe_FooterContainer_NOTLobby)
	self.id = "fe_FooterContainer_NOTLobby"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local feNAT = CoD.fe_NAT.new(f1_arg0, f1_arg1, 1, 1, -265, -93, 1, 1, -124, -85)
	feNAT:setAlpha(0)
	self:addElement(feNAT)
	self.feNAT = feNAT
	local feLeftContainer = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0, 0, 23, 825, 1, 1, -72, -6)
	feLeftContainer:linkToElementModel(self, nil, false, function(model)
		feLeftContainer:setModel(model, f1_arg1)
	end)
	self:addElement(feLeftContainer)
	self.feLeftContainer = feLeftContainer
	local feRightContainerWithoutRightBoxes0 = CoD.fe_RightContainerWithoutRightBoxes.new(f1_arg0, f1_arg1, 1, 1, -1352.5, -47.5, 1, 1, -54, -10)
	feRightContainerWithoutRightBoxes0:linkToElementModel(self, nil, false, function(model)
		feRightContainerWithoutRightBoxes0:setModel(model, f1_arg1)
	end)
	self:addElement(feRightContainerWithoutRightBoxes0)
	self.feRightContainerWithoutRightBoxes0 = feRightContainerWithoutRightBoxes0
	local feRightContainerWithHeroesHead = CoD.fe_RightContainerWithHeroesHead.new(f1_arg0, f1_arg1, 1, 1, -1279.5, 25.5, 1, 1, -58, -10)
	feRightContainerWithHeroesHead:setAlpha(0)
	feRightContainerWithHeroesHead:linkToElementModel(self, nil, false, function(model)
		feRightContainerWithHeroesHead:setModel(model, f1_arg1)
	end)
	self:addElement(feRightContainerWithHeroesHead)
	self.feRightContainerWithHeroesHead = feRightContainerWithHeroesHead
	self:mergeStateConditions({
		{
			stateName = "WithHeroesHead",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if CoD.isPC then
		feLeftContainer.id = "feLeftContainer"
	end
	if CoD.isPC then
		feRightContainerWithoutRightBoxes0.id = "feRightContainerWithoutRightBoxes0"
	end
	if CoD.isPC then
		feRightContainerWithHeroesHead.id = "feRightContainerWithHeroesHead"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.fe_FooterContainer_NOTLobby.__resetProperties = function(f6_arg0)
	f6_arg0.feRightContainerWithHeroesHead:completeAnimation()
	f6_arg0.feRightContainerWithoutRightBoxes0:completeAnimation()
	f6_arg0.feRightContainerWithHeroesHead:setLeftRight(1, 1, -1279.5, 25.5)
	f6_arg0.feRightContainerWithHeroesHead:setTopBottom(1, 1, -58, -10)
	f6_arg0.feRightContainerWithHeroesHead:setAlpha(0)
	f6_arg0.feRightContainerWithoutRightBoxes0:setAlpha(1)
end
CoD.fe_FooterContainer_NOTLobby.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	WithHeroesHead = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.feRightContainerWithoutRightBoxes0:completeAnimation()
			f8_arg0.feRightContainerWithoutRightBoxes0:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.feRightContainerWithoutRightBoxes0)
			f8_arg0.feRightContainerWithHeroesHead:completeAnimation()
			f8_arg0.feRightContainerWithHeroesHead:setLeftRight(1, 1, -1040.5, 264.5)
			f8_arg0.feRightContainerWithHeroesHead:setTopBottom(1, 1, -58, -10)
			f8_arg0.feRightContainerWithHeroesHead:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.feRightContainerWithHeroesHead)
		end,
	},
}
CoD.fe_FooterContainer_NOTLobby.__onClose = function(f9_arg0)
	f9_arg0.feNAT:close()
	f9_arg0.feLeftContainer:close()
	f9_arg0.feRightContainerWithoutRightBoxes0:close()
	f9_arg0.feRightContainerWithHeroesHead:close()
end
