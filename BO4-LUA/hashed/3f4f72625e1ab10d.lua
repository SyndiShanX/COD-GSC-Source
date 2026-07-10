CoD.uplinkReticle = InheritFrom(LUI.UIElement)
CoD.uplinkReticle.__defaultWidth = 195
CoD.uplinkReticle.__defaultHeight = 195
CoD.uplinkReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "ballGametype.passOption")
	self:setClass(CoD.uplinkReticle)
	self.id = "uplinkReticle"
	self.soundSet = "CAC_PrimaryWeapon"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local reticleNew = LUI.UIImage.new(0.5, 0.5, -98, 98, 0.5, 0.5, -98, 98)
	reticleNew:setAlpha(0.9)
	reticleNew:setScale(0.7, 0.7)
	reticleNew:setImage(RegisterImage(0x85FBB920615FD67))
	self:addElement(reticleNew)
	self.reticleNew = reticleNew
	self:mergeStateConditions({
		{
			stateName = "PassTarget",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "ballGametype.passOption", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["ballGametype.passOption"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "ballGametype.passOption",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.uplinkReticle.__resetProperties = function(f4_arg0)
	f4_arg0.reticleNew:completeAnimation()
	f4_arg0.reticleNew:setRGB(1, 1, 1)
end
CoD.uplinkReticle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	PassTarget = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.reticleNew:completeAnimation()
			f6_arg0.reticleNew:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
			f6_arg0.clipFinished(f6_arg0.reticleNew)
		end,
	},
}
