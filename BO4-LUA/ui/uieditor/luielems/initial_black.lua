require("x64:9296064b84bca5f")
require("x64:474d14efb47ebf4")
CoD.initial_black = InheritFrom(CoD.Menu)
LUI.createMenu.initial_black = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("initial_black", f1_arg0)
	local f1_local1 = self
	SetProperty(self, "disableBlur", true)
	SetProperty(self, "disableInputLock", true)
	self:setClass(CoD.initial_black)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Fullscreen = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Fullscreen:setImage(RegisterImage(0xD210F4BC59B4E93))
	self:addElement(Fullscreen)
	self.Fullscreen = Fullscreen
	local AnimationLoading20 = CoD.AnimationLoading2.new(f1_local1, f1_arg0, 1, 1, -288, -96, 1, 1, -246, -54)
	AnimationLoading20:setScale(0.5, 0.5)
	self:addElement(AnimationLoading20)
	self.AnimationLoading20 = AnimationLoading20
	local Team1PlayerList = LUI.UIList.new(f1_local1, f1_arg0, 8, 0, nil, false, false, false, false)
	Team1PlayerList:setLeftRight(0.5, 0.5, -864, -534)
	Team1PlayerList:setTopBottom(0, 0, 54, 186)
	Team1PlayerList:setWidgetType(CoD.LoadingScreenTalkerWidgetCPZM)
	Team1PlayerList:setVerticalCount(4)
	Team1PlayerList:setSpacing(8)
	Team1PlayerList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Team1PlayerList:setDataSource("LoadingScreenPlayerListTeam1")
	self:addElement(Team1PlayerList)
	self.Team1PlayerList = Team1PlayerList
	Team1PlayerList.id = "Team1PlayerList"
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
CoD.initial_black.__resetProperties = function(f2_arg0)
	f2_arg0.AnimationLoading20:completeAnimation()
	f2_arg0.Fullscreen:completeAnimation()
	f2_arg0.Team1PlayerList:completeAnimation()
	f2_arg0.AnimationLoading20:setAlpha(1)
	f2_arg0.AnimationLoading20:setScale(0.5, 0.5)
	f2_arg0.Fullscreen:setAlpha(1)
	f2_arg0.Team1PlayerList:setAlpha(1)
end
CoD.initial_black.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1010)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Fullscreen:beginAnimation(29000)
				f3_arg0.Fullscreen:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Fullscreen:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Fullscreen:completeAnimation()
			f3_arg0.Fullscreen:setAlpha(1)
			f3_local0(f3_arg0.Fullscreen)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(1010)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(18490)
					f7_arg0:setScale(0.5, 0.5)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.AnimationLoading20:beginAnimation(10510)
				f3_arg0.AnimationLoading20:setAlpha(1)
				f3_arg0.AnimationLoading20:setScale(0.6, 0.6)
				f3_arg0.AnimationLoading20:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.AnimationLoading20:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.AnimationLoading20:completeAnimation()
			f3_arg0.AnimationLoading20:setAlpha(0)
			f3_arg0.AnimationLoading20:setScale(0.5, 0.5)
			f3_local1(f3_arg0.AnimationLoading20)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(1010)
					f10_arg0:setAlpha(0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Team1PlayerList:beginAnimation(29000)
				f3_arg0.Team1PlayerList:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Team1PlayerList:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.Team1PlayerList:completeAnimation()
			f3_arg0.Team1PlayerList:setAlpha(1)
			f3_local2(f3_arg0.Team1PlayerList)
		end,
	},
}
CoD.initial_black.__onClose = function(f11_arg0)
	f11_arg0.AnimationLoading20:close()
	f11_arg0.Team1PlayerList:close()
end
