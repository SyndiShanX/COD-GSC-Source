require("x64:e8c9585bd4d7a5e")
require("x64:960b8d226c888d2")
CoD.WaypointCaptured = InheritFrom(LUI.UIElement)
CoD.WaypointCaptured.__defaultWidth = 1920
CoD.WaypointCaptured.__defaultHeight = 1080
CoD.WaypointCaptured.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointCaptured)
	self.id = "WaypointCaptured"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Name = CoD.Waypoint_TextWithBG.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.26, 0.26, -37, -7)
	Name:linkToElementModel(self, "objName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name.text:setText(LocalizeToUpperString(CoD.WaypointUtility.GetContributedCaptureText(f1_arg1, f2_local0)))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Percentage = CoD.WaypointCapturedPercentMessageContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -305, 305, 0.26, 0.26, 3, 30)
	Percentage:linkToElementModel(self, nil, false, function(model)
		Percentage:setModel(model, f1_arg1)
	end)
	self:addElement(Percentage)
	self.Percentage = Percentage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointCaptured.__resetProperties = function(f4_arg0)
	f4_arg0.Name:completeAnimation()
	f4_arg0.Percentage:completeAnimation()
	f4_arg0.Name:setAlpha(1)
	f4_arg0.Percentage:setAlpha(1)
end
CoD.WaypointCaptured.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Name:beginAnimation(300)
				f5_arg0.Name:setAlpha(1)
				f5_arg0.Name:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Name:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Name:completeAnimation()
			f5_arg0.Name:setAlpha(0)
			f5_local0(f5_arg0.Name)
			local f5_local1 = function(f7_arg0)
				f5_arg0.Percentage:beginAnimation(300)
				f5_arg0.Percentage:setAlpha(1)
				f5_arg0.Percentage:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Percentage:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Percentage:completeAnimation()
			f5_arg0.Percentage:setAlpha(0)
			f5_local1(f5_arg0.Percentage)
		end,
		TimeUp = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Name:beginAnimation(300)
				f8_arg0.Name:setAlpha(0)
				f8_arg0.Name:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Name:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Name:completeAnimation()
			f8_arg0.Name:setAlpha(1)
			f8_local0(f8_arg0.Name)
			local f8_local1 = function(f10_arg0)
				f8_arg0.Percentage:beginAnimation(300)
				f8_arg0.Percentage:setAlpha(0)
				f8_arg0.Percentage:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Percentage:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Percentage:completeAnimation()
			f8_arg0.Percentage:setAlpha(1)
			f8_local1(f8_arg0.Percentage)
		end,
	},
}
CoD.WaypointCaptured.__onClose = function(f11_arg0)
	f11_arg0.Name:close()
	f11_arg0.Percentage:close()
end
