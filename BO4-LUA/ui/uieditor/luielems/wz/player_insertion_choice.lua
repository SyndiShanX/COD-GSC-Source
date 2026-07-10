CoD.player_insertion_choice = InheritFrom(CoD.Menu)
CoD.player_insertion_choice.__stateMap = {
	"DefaultState",
	"GroundVehicle",
	"HaloJump",
	"Heli",
}
LUI.createMenu.player_insertion_choice = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("player_insertion_choice", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.player_insertion_choice)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local InsertionChoice = LUI.UIText.new(0, 0, 43, 444, 0, 0, 545, 582)
	InsertionChoice:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1A2EEE6D4BBFD6FD"))
	InsertionChoice:setTTF("default")
	InsertionChoice:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	InsertionChoice:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	InsertionChoice:setBackingType(2)
	InsertionChoice:setBackingXPadding(3)
	InsertionChoice:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	InsertionChoice:setBackingShaderVector(0, 0, 0, 0, 0)
	self:addElement(InsertionChoice)
	self.InsertionChoice = InsertionChoice
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
CoD.player_insertion_choice.__resetProperties = function(f2_arg0)
	f2_arg0.InsertionChoice:completeAnimation()
	f2_arg0.InsertionChoice:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1A2EEE6D4BBFD6FD"))
end
CoD.player_insertion_choice.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.InsertionChoice:completeAnimation()
			f3_arg0.InsertionChoice:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1A2EEE6D4BBFD6FD"))
			f3_arg0.clipFinished(f3_arg0.InsertionChoice)
		end,
	},
	GroundVehicle = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.InsertionChoice:completeAnimation()
			f4_arg0.InsertionChoice:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_539502279B642251"))
			f4_arg0.clipFinished(f4_arg0.InsertionChoice)
		end,
	},
	HaloJump = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.InsertionChoice:completeAnimation()
			f5_arg0.InsertionChoice:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_117AB36B067E50BC"))
			f5_arg0.clipFinished(f5_arg0.InsertionChoice)
		end,
	},
	Heli = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.InsertionChoice:completeAnimation()
			f6_arg0.InsertionChoice:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_534AD229607585B5"))
			f6_arg0.clipFinished(f6_arg0.InsertionChoice)
		end,
	},
}
CoD.player_insertion_choice.__onClose = function(f7_arg0) end
