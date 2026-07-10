require("x64:79c1e59bb4c023d")
require("x64:c9b6064dd80670a")
require("x64:97f230a5a1a43f8")
require("x64:21d6535d40a8875")
require("x64:29187ea00d726c3")
CoD.AARClassReward = InheritFrom(LUI.UIElement)
CoD.AARClassReward.__defaultWidth = 412
CoD.AARClassReward.__defaultHeight = 772
CoD.AARClassReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.AARClassReward)
	self.id = "AARClassReward"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = CoD.AARRewardBacker.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backer)
	self.Backer = Backer
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 0, 19)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local AARRewardHeader = CoD.AARRewardHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0, 0, 19, 229)
	AARRewardHeader.Pointer:setRGB(0.43, 0.45, 0.18)
	AARRewardHeader.headerBacking:setRGB(0.43, 0.45, 0.18)
	AARRewardHeader.TopStripBase:setRGB(0.43, 0.45, 0.18)
	AARRewardHeader.mainTitle:setRGB(0.82, 0.89, 0.26)
	AARRewardHeader:linkToElementModel(self, "levelText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AARRewardHeader.levelText:setText(f2_local0)
		end
	end)
	AARRewardHeader:linkToElementModel(self, "mainTitle", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AARRewardHeader.mainTitle:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	AARRewardHeader:linkToElementModel(self, "mainIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			AARRewardHeader.mainIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(AARRewardHeader)
	self.AARRewardHeader = AARRewardHeader
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 229, 245)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local rewardTitle = CoD.AARClassRewardCACPreview.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 245, 427)
	rewardTitle:linkToElementModel(self, nil, false, function(model)
		rewardTitle:setModel(model, f1_arg1)
	end)
	self:addElement(rewardTitle)
	self.rewardTitle = rewardTitle
	local VerticalListSpacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 427, 443)
	self:addElement(VerticalListSpacer3)
	self.VerticalListSpacer3 = VerticalListSpacer3
	local ClassPreview = CoD.AARClassRewardPreview.new(f1_arg0, f1_arg1, 0, 0, 16, 396, 0, 0, 443, 883)
	ClassPreview:setAlpha(0)
	ClassPreview:linkToElementModel(self, nil, false, function(model)
		ClassPreview:setModel(model, f1_arg1)
	end)
	self:addElement(ClassPreview)
	self.ClassPreview = ClassPreview
	local VerticalListSpacer5 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 883, 899)
	self:addElement(VerticalListSpacer5)
	self.VerticalListSpacer5 = VerticalListSpacer5
	local VerticalListSpacer4 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 412, 0, 0, 899, 915)
	self:addElement(VerticalListSpacer4)
	self.VerticalListSpacer4 = VerticalListSpacer4
	self:mergeStateConditions({
		{
			stateName = "ClassReward",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "featureType", CoD.AARUtility.AARFeatureRewardType.CAC)
			end,
		},
	})
	self:linkToElementModel(self, "featureType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featureType",
		})
	end)
	ClassPreview.id = "ClassPreview"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARClassReward.__resetProperties = function(f9_arg0)
	f9_arg0.VerticalListSpacer5:completeAnimation()
	f9_arg0.VerticalListSpacer4:completeAnimation()
	f9_arg0.ClassPreview:completeAnimation()
	f9_arg0.VerticalListSpacer3:completeAnimation()
	f9_arg0.rewardTitle:completeAnimation()
	f9_arg0.VerticalListSpacer5:setTopBottom(0, 0, 883, 899)
	f9_arg0.VerticalListSpacer5:setAlpha(1)
	f9_arg0.VerticalListSpacer4:setLeftRight(0, 0, 0, 412)
	f9_arg0.VerticalListSpacer4:setTopBottom(0, 0, 899, 915)
	f9_arg0.VerticalListSpacer4:setAlpha(1)
	f9_arg0.ClassPreview:setLeftRight(0, 0, 16, 396)
	f9_arg0.ClassPreview:setTopBottom(0, 0, 443, 883)
	f9_arg0.ClassPreview:setAlpha(0)
	f9_arg0.ClassPreview.Corner:setRGB(1, 1, 1)
	f9_arg0.VerticalListSpacer3:setTopBottom(0, 0, 427, 443)
	f9_arg0.VerticalListSpacer3:setAlpha(1)
	f9_arg0.rewardTitle:setAlpha(1)
end
CoD.AARClassReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.VerticalListSpacer5:completeAnimation()
			f10_arg0.VerticalListSpacer5:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VerticalListSpacer5)
			f10_arg0.VerticalListSpacer4:completeAnimation()
			f10_arg0.VerticalListSpacer4:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VerticalListSpacer4)
		end,
	},
	ClassReward = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			f11_arg0.rewardTitle:completeAnimation()
			f11_arg0.rewardTitle:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.rewardTitle)
			f11_arg0.VerticalListSpacer3:completeAnimation()
			f11_arg0.VerticalListSpacer3:setTopBottom(0, 0, 720, 736)
			f11_arg0.VerticalListSpacer3:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.VerticalListSpacer3)
			f11_arg0.ClassPreview:completeAnimation()
			f11_arg0.ClassPreview.Corner:completeAnimation()
			f11_arg0.ClassPreview:setLeftRight(0, 0, 16, 396)
			f11_arg0.ClassPreview:setTopBottom(0, 0, 248, 688)
			f11_arg0.ClassPreview:setAlpha(1)
			f11_arg0.ClassPreview.Corner:setRGB(0.82, 0.89, 0.26)
			f11_arg0.clipFinished(f11_arg0.ClassPreview)
			f11_arg0.VerticalListSpacer5:completeAnimation()
			f11_arg0.VerticalListSpacer5:setTopBottom(0, 0, 704, 720)
			f11_arg0.VerticalListSpacer5:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.VerticalListSpacer5)
			f11_arg0.VerticalListSpacer4:completeAnimation()
			f11_arg0.VerticalListSpacer4:setLeftRight(0, 0, 0, 412)
			f11_arg0.VerticalListSpacer4:setTopBottom(0, 0, 688, 704)
			f11_arg0.VerticalListSpacer4:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.VerticalListSpacer4)
		end,
	},
}
CoD.AARClassReward.__onClose = function(f12_arg0)
	f12_arg0.Backer:close()
	f12_arg0.VerticalListSpacer:close()
	f12_arg0.AARRewardHeader:close()
	f12_arg0.VerticalListSpacer2:close()
	f12_arg0.rewardTitle:close()
	f12_arg0.VerticalListSpacer3:close()
	f12_arg0.ClassPreview:close()
	f12_arg0.VerticalListSpacer5:close()
	f12_arg0.VerticalListSpacer4:close()
end
