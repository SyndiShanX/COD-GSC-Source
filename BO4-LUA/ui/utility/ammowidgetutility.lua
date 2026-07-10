CoD.AmmoWidgetUtility = {}
CoD.AmmoWidgetUtility.InitTacticalEmptyPulse = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local f1_local0 = Engine[@"getmodelforcontroller"](f1_arg2)
	f1_arg1.previousPulseValue = 0
	f1_arg1:subscribeToModel(Engine[@"getmodel"](f1_local0, "hudItems.pulseNoTactical"), function(model)
		local f2_local0 = Engine[@"getmodelvalue"](model)
		if f1_arg1.previousPulseValue == f2_local0 then
			return
		else
			f1_arg1.previousPulseValue = f2_local0
			if not PulseNoTactical(f1_arg2) then
				return
			elseif Engine[@"getmodelvalue"](Engine[@"getmodel"](f1_local0, "currentSecondaryOffhand.secondaryOffhand")) == nil then
				return
			else
				local f2_local1 = f1_arg3.new(f1_arg4, f1_arg2, 0, 0, 0, f1_arg3.__defaultWidth, 0, 0, 0, f1_arg3.__defaultHeight)
				f2_local1:setLeftRight(f1_arg1:getLocalLeftRight())
				f2_local1:setTopBottom(f1_arg1:getLocalTopBottom())
				f2_local1:subscribeToGlobalModel(f1_arg2, "CurrentSecondaryOffhand", "secondaryOffhand", function(model)
					local f3_local0 = Engine[@"getmodelvalue"](model)
					if f3_local0 then
						f2_local1.ImgIcon:setImage(RegisterImage(f3_local0))
						f2_local1.ImgIconGrow:setImage(RegisterImage(f3_local0))
					end
				end)
				f2_local1:registerEventHandler("clip_over", function(element, event)
					element:close()
				end)
				f2_local1:setState(f1_arg2, "Empty")
				f1_arg0:addElement(f2_local1)
				f1_arg4:sendInitializationEvents(f1_arg2, f2_local1)
			end
		end
	end)
end
CoD.AmmoWidgetUtility.InitLethalEmptyPulse = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = Engine[@"getmodelforcontroller"](f5_arg2)
	f5_arg1.previousPulseValue = 0
	f5_arg1:subscribeToModel(Engine[@"getmodel"](f5_local0, "hudItems.pulseNoLethal"), function(model)
		local f6_local0 = Engine[@"getmodelvalue"](model)
		if f5_arg1.previousPulseValue == f6_local0 then
			return
		end
		f5_arg1.previousPulseValue = f6_local0
		if not PulseNoLethal(f5_arg2) then
			return
		end
		local f6_local1 = f5_arg0:getModel()
		if f6_local1 then
			f6_local1 = f5_arg0:getModel()
			f6_local1 = f6_local1.image
		end
		if not f6_local1 then
			return
		end
		local f6_local2 = f5_arg3.new(f5_arg4, f5_arg2, 0, 0, 0, f5_arg3.__defaultWidth, 0, 0, 0, f5_arg3.__defaultHeight)
		f6_local2:setLeftRight(f5_arg1:getLocalLeftRight())
		f6_local2:setTopBottom(f5_arg1:getLocalTopBottom())
		f6_local2:subscribeToElementModel(f5_arg0, "image", function(f7_arg0)
			local f7_local0 = Engine[@"getmodelvalue"](f7_arg0)
			if f7_local0 then
				f6_local2.ImgIcon:setImage(RegisterImage(f7_local0))
				f6_local2.ImgIconGrow:setImage(RegisterImage(f7_local0))
			end
		end)
		f6_local2:registerEventHandler("clip_over", function(element, event)
			element:close()
		end)
		f6_local2:setState(f5_arg2, "Empty")
		f5_arg0:addElement(f6_local2)
		f5_arg4:sendInitializationEvents(f5_arg2, f6_local2)
	end)
end
CoD.AmmoWidgetUtility.IsAbilityRestricted = function(f9_arg0)
	local f9_local0 = f9_arg0:getModel()
	return Engine[@"isitemindexrestricted"](Engine[@"hash_2D97229B24C685D5"](Engine[@"hash_26341D58561B3B7E"](f9_local0.id:get())), false)
end
CoD.AmmoWidgetUtility.TankState = LuaEnum.createEnum("TANK_NONE", "TANK_INBOUND", "TANK_READY_FOR_COMMANDS", "TANK_ENTERED")
CoD.AmmoWidgetUtility.DogState = LuaEnum.createEnum("DOG_NONE", "DOG_PATROLLING", "DOG_FOLLOWING", "DOG_LEAVING")
CoD.AmmoWidgetUtility.SmartCoverState = LuaEnum.createEnum("SMART_COVER_HUD_NONE", "SMART_COVER_HUD_DESTROY")
