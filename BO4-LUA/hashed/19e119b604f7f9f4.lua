CoD.NewSpecialistFooter = InheritFrom(LUI.UIElement)
CoD.NewSpecialistFooter.__defaultWidth = 600
CoD.NewSpecialistFooter.__defaultHeight = 150
CoD.NewSpecialistFooter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.NewSpecialistFooter)
	self.id = "NewSpecialistFooter"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SelForNewSpawn = LUI.UIText.new(0.5, 0.5, 102, 462, 0.5, 0.5, -18.5, 18.5)
	SelForNewSpawn:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_CC33FEF563991C6"))
	SelForNewSpawn:setTTF("default")
	SelForNewSpawn:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SelForNewSpawn:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SelForNewSpawn)
	self.SelForNewSpawn = SelForNewSpawn
	local SpecialistImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -73.5, 73.5, 0.5, 0.5, -73.5, 73.5)
	SpecialistImage:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "characterIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpecialistImage:setImage(RegisterImage(GetPositionDraftIconByIndex(f2_local0)))
		end
	end)
	self:addElement(SpecialistImage)
	self.SpecialistImage = SpecialistImage
	local SpecialistName = LUI.UIText.new(0.5, 0.5, -357.5, -101.5, 0.5, 0.5, -18.5, 18.5)
	SpecialistName:setTTF("default")
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SpecialistName:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "characterIndex", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SpecialistName:setText(Engine[@"hash_4F9F1239CFD921FE"](GetCharacterDisplayNameByIndex(f3_local0)))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NewSpecialistFooter.__resetProperties = function(f4_arg0)
	f4_arg0.SelForNewSpawn:completeAnimation()
	f4_arg0.SpecialistImage:completeAnimation()
	f4_arg0.SpecialistName:completeAnimation()
	f4_arg0.SelForNewSpawn:setAlpha(1)
	f4_arg0.SpecialistImage:setAlpha(1)
	f4_arg0.SpecialistName:setAlpha(1)
end
CoD.NewSpecialistFooter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		DeathSpecialistSwitch = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			local f6_local0 = function(f7_arg0)
				f6_arg0.SelForNewSpawn:beginAnimation(200)
				f6_arg0.SelForNewSpawn:setAlpha(1)
				f6_arg0.SelForNewSpawn:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.SelForNewSpawn:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.SelForNewSpawn:completeAnimation()
			f6_arg0.SelForNewSpawn:setAlpha(0)
			f6_local0(f6_arg0.SelForNewSpawn)
			local f6_local1 = function(f8_arg0)
				f6_arg0.SpecialistImage:beginAnimation(200)
				f6_arg0.SpecialistImage:setAlpha(1)
				f6_arg0.SpecialistImage:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.SpecialistImage:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.SpecialistImage:completeAnimation()
			f6_arg0.SpecialistImage:setAlpha(0)
			f6_local1(f6_arg0.SpecialistImage)
			local f6_local2 = function(f9_arg0)
				f6_arg0.SpecialistName:beginAnimation(200)
				f6_arg0.SpecialistName:setAlpha(1)
				f6_arg0.SpecialistName:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.SpecialistName:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.SpecialistName:completeAnimation()
			f6_arg0.SpecialistName:setAlpha(0)
			f6_local2(f6_arg0.SpecialistName)
		end,
	},
}
CoD.NewSpecialistFooter.__onClose = function(f10_arg0)
	f10_arg0.SpecialistImage:close()
	f10_arg0.SpecialistName:close()
end
