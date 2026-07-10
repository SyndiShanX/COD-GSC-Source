require("x64:c6a9eefbd64c968")
require("x64:dd5ebc3a8811f73")
require("x64:7c6bc93c499ae6e")
CoD.ZMInvObjectiveProgress = InheritFrom(LUI.UIElement)
CoD.ZMInvObjectiveProgress.__defaultWidth = 384
CoD.ZMInvObjectiveProgress.__defaultHeight = 489
CoD.ZMInvObjectiveProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvObjectiveProgress)
	self.id = "ZMInvObjectiveProgress"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0.5, 0.5, -192, 192, 1, 1, -384, 0)
	BG:linkToElementModel(self, "background", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BG:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(BG)
	self.BG = BG
	local SentinelStages = LUI.UIImage.new(0.5, 0.5, -192, 192, 1, 1, -384, 0)
	SentinelStages:linkToElementModel(self, "Eye.stage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SentinelStages:setImage(RegisterImage(CoD.ZMInventoryUtility.StageToFullSentinelImage(f3_local0)))
		end
	end)
	self:addElement(SentinelStages)
	self.SentinelStages = SentinelStages
	local TextBacking = LUI.UIImage.new(0.5, 0.5, -192, 192, 0, 0, 3, 137)
	TextBacking:setAlpha(0.9)
	TextBacking:setImage(RegisterImage(@"uie_zm_hud_inventory_objectivesmoke"))
	TextBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	TextBacking:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local ObjectiveProgRing = CoD.ZMInvObjectiveProgressRingContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 192, 1, 1, -384, 0)
	ObjectiveProgRing:linkToElementModel(self, nil, false, function(model)
		ObjectiveProgRing:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgRing)
	self.ObjectiveProgRing = ObjectiveProgRing
	local Description = LUI.UIText.new(0.5, 0.5, -185, 185, 0, 0, 55, 76)
	Description:setRGB(0, 0.75, 1)
	Description:setTTF("skorzhen")
	Description:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Description:setShaderVector(0, 0.7, 0, 0, 0)
	Description:setShaderVector(1, 1, 0, 0, 0)
	Description:setShaderVector(2, 0.05, 0, 0.2, 1)
	Description:setLetterSpacing(1)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Description:linkToElementModel(self, "description", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Description:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local SentinelArtifact = CoD.ZMInvSentinelArtifact.new(f1_arg0, f1_arg1, 0.5, 0.5, -64, 64, 1, 1, -256, -128)
	SentinelArtifact:linkToElementModel(self, nil, false, function(model)
		SentinelArtifact:setModel(model, f1_arg1)
	end)
	self:addElement(SentinelArtifact)
	self.SentinelArtifact = SentinelArtifact
	local ZMInvSentinelArtifactLarge = CoD.ZMInvSentinelArtifactLarge.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 105, 489)
	ZMInvSentinelArtifactLarge:linkToElementModel(self, nil, false, function(model)
		ZMInvSentinelArtifactLarge:setModel(model, f1_arg1)
	end)
	self:addElement(ZMInvSentinelArtifactLarge)
	self.ZMInvSentinelArtifactLarge = ZMInvSentinelArtifactLarge
	self:mergeStateConditions({
		{
			stateName = "Vanish",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztutorial", "zstandard")
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ZombieUtility.IsEasterEggsAllowed(f1_arg1)
			end,
		},
		{
			stateName = "NoDescription",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isObjProgressNonLinear")
			end,
		},
	})
	self:linkToElementModel(self, "isObjProgressNonLinear", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isObjProgressNonLinear",
		})
	end)
	self:linkToElementModel(self, "Ring.stage", true, function(model)
		local f12_local0 = self
		CoD.ZMInventoryUtility.HandleObjectiveProgressStageChange(self, model, self.ObjectiveProgRing, self.SentinelArtifact)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	CoD.ZMInventoryUtility.SetupObjectiveProgressModels(self, f1_arg1)
	return self
end
CoD.ZMInvObjectiveProgress.__resetProperties = function(f13_arg0)
	f13_arg0.BG:completeAnimation()
	f13_arg0.SentinelArtifact:completeAnimation()
	f13_arg0.Description:completeAnimation()
	f13_arg0.TextBacking:completeAnimation()
	f13_arg0.SentinelStages:completeAnimation()
	f13_arg0.ObjectiveProgRing:completeAnimation()
	f13_arg0.ZMInvSentinelArtifactLarge:completeAnimation()
	f13_arg0.BG:setAlpha(1)
	f13_arg0.SentinelArtifact:setAlpha(1)
	f13_arg0.Description:setAlpha(1)
	f13_arg0.TextBacking:setAlpha(0.9)
	f13_arg0.SentinelStages:setAlpha(1)
	f13_arg0.ObjectiveProgRing:setAlpha(1)
	f13_arg0.ZMInvSentinelArtifactLarge:setAlpha(1)
end
CoD.ZMInvObjectiveProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Vanish = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			f15_arg0.BG:completeAnimation()
			f15_arg0.BG:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.BG)
			f15_arg0.SentinelStages:completeAnimation()
			f15_arg0.SentinelStages:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SentinelStages)
			f15_arg0.TextBacking:completeAnimation()
			f15_arg0.TextBacking:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TextBacking)
			f15_arg0.ObjectiveProgRing:completeAnimation()
			f15_arg0.ObjectiveProgRing:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ObjectiveProgRing)
			f15_arg0.Description:completeAnimation()
			f15_arg0.Description:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Description)
			f15_arg0.SentinelArtifact:completeAnimation()
			f15_arg0.SentinelArtifact:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SentinelArtifact)
			f15_arg0.ZMInvSentinelArtifactLarge:completeAnimation()
			f15_arg0.ZMInvSentinelArtifactLarge:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ZMInvSentinelArtifactLarge)
		end,
	},
	Hidden = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(6)
			f16_arg0.BG:completeAnimation()
			f16_arg0.BG:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.BG)
			f16_arg0.SentinelStages:completeAnimation()
			f16_arg0.SentinelStages:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.SentinelStages)
			f16_arg0.TextBacking:completeAnimation()
			f16_arg0.TextBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TextBacking)
			f16_arg0.ObjectiveProgRing:completeAnimation()
			f16_arg0.ObjectiveProgRing:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ObjectiveProgRing)
			f16_arg0.Description:completeAnimation()
			f16_arg0.Description:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Description)
			f16_arg0.SentinelArtifact:completeAnimation()
			f16_arg0.SentinelArtifact:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.SentinelArtifact)
		end,
	},
	NoDescription = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.TextBacking:completeAnimation()
			f17_arg0.TextBacking:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TextBacking)
			f17_arg0.Description:completeAnimation()
			f17_arg0.Description:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Description)
		end,
	},
}
CoD.ZMInvObjectiveProgress.__onClose = function(f18_arg0)
	f18_arg0.BG:close()
	f18_arg0.SentinelStages:close()
	f18_arg0.ObjectiveProgRing:close()
	f18_arg0.Description:close()
	f18_arg0.SentinelArtifact:close()
	f18_arg0.ZMInvSentinelArtifactLarge:close()
end
