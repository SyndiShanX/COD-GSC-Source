CoD.KillcamCover = InheritFrom(LUI.UIElement)
CoD.KillcamCover.__defaultWidth = 550
CoD.KillcamCover.__defaultHeight = 325
CoD.KillcamCover.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamCover)
	self.id = "KillcamCover"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	self:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.killcamActive", 0)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.killcamActive", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.showSpawnSelect"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.killcamActive"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.killcamActive",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamCover.__resetProperties = function(f6_arg0)
	f6_arg0.Background:completeAnimation()
	f6_arg0.Background:setAlpha(1)
end
CoD.KillcamCover.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Background:completeAnimation()
			f7_arg0.Background:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Background)
		end,
	},
	On = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Background:completeAnimation()
			f8_arg0.Background:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Background)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Background:beginAnimation(250)
				f9_arg0.Background:setAlpha(0)
				f9_arg0.Background:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Background:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Background:completeAnimation()
			f9_arg0.Background:setAlpha(1)
			f9_local0(f9_arg0.Background)
		end,
	},
}
