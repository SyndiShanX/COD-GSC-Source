/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_cp.gsc
***********************************************/

vehicle_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "create", ::vehicle_cp_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "createLate", ::vehicle_cp_createlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrame", ::vehicle_cp_deletenextframe);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrameLate", ::vehicle_cp_deletenextframelate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "createHint", scripts\cp\utility::createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_interact", "init", scripts\cp\vehicles\vehicle_interact_cp::vehicle_interact_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "init", scripts\cp\vehicles\vehicle_occupancy_cp::vehicle_occupancy_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "init", scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "init", scripts\cp\vehicles\vehicle_compass_cp::vehicle_compass_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "init", scripts\cp\vehicles\vehicle_damage_cp::vehicle_damage_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "init", scripts\cp\vehicles\light_tank_cp::light_tank_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "init", scripts\cp\vehicles\little_bird_cp::little_bird_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "init", scripts\cp\vehicles\atv_cp::atv_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "init", scripts\cp\vehicles\apc_rus_cp::apc_rus_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_rhib", "init", _id_6E32C3E5E141C690::_id_944A2EB36063F641);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_jltv", "init", _id_5EF6975905AE15BF::_id_52B33E520A612E1C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_jltv_mg", "init", _id_18AE04893BB2F9AC::_id_D06448E049FAB02F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_palfa", "init", _id_7C390291BF40788F::_id_59EB5F2DE04C842A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_patrol_boat", "init", _id_3BDD48AAFC976300::_id_6E5970EC1A994B0B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_suv_1996", "init", _id_228478D4175CB3B9::_id_7FBB4BDC170016B2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_sedan_hatchback_1985", "init", _id_31E1AE5E1DDCE676::_id_F8CD879642397A71);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo", "init", _id_35595DB997C6340C::_id_47A79FC51AEB5823);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo_rebel_armor", "init", _id_46CB4299182C74F9::_id_A66A9D83B9E60DB0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_mkilo23", "init", _id_5034478014672650::_id_335DD1C457C3A367);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_mil_cargo_truck", "init", _id_66DF092E7E148D2F::_id_974DACE3684B9E9B);
  _id_62F0B3C772938057::_id_B82404E40CCA2415();
  scripts\cp\vehicles\damage_cp::init();
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo_rebel_armor", "armorDamageFeedback", _id_354C862768CFE202::_id_CB98B2B16C183664);
  scripts\cp_mp\utility\script_utility::registersharedfunc("veh9_techo_rebel_armor", "armorDeathFeedback", _id_354C862768CFE202::_id_974320DD370C5572);
}

spawn_script_model_at_pos(_id_DCEF536353EA980B, tag, animname, xanim, model) {
  _id_2626560098D08682 = self gettagorigin(tag);
  _id_B7850001037AA074 = self gettagangles(tag);
  _id_D917428537562C1F = getstartorigin(_id_2626560098D08682, _id_B7850001037AA074, xanim);
  startangles = getstartangles(_id_2626560098D08682, _id_B7850001037AA074, xanim);
  spawned = spawn("script_model", _id_D917428537562C1F);
  spawned.angles = startangles;
  spawned setModel(model);
  spawned linkTo(self);

  if(isDefined(animname))
    spawned scriptmodelplayanim(animname);

  spawned.vehicle_position = _id_DCEF536353EA980B;
  spawned.disable_gun_recall = 1;
  self.attachedguys[self.attachedguys.size] = spawned;
  self.usedpositions[_id_DCEF536353EA980B] = 1;
  self.riders[self.riders.size] = spawned;

  if(_id_DCEF536353EA980B == 0)
    self.driver = spawned;

  return spawned;
}

spawn_vehicle_accessory(model, _id_FEF22745912BC53F, origin_offset, angles_offset) {
  _id_C6296A5EC3B3611E = spawn("script_model", self.origin);
  _id_C6296A5EC3B3611E setModel(model);
  _id_C6296A5EC3B3611E notsolid();
  _id_C6296A5EC3B3611E show();

  if(!isDefined(origin_offset))
    origin_offset = (0, 0, 0);

  if(!isDefined(angles_offset))
    angles_offset = (0, 0, 0);

  tag = "tag_origin";

  if(isDefined(_id_FEF22745912BC53F))
    tag = _id_FEF22745912BC53F;

  tagorigin = self gettagorigin(tag);

  if(isDefined(tagorigin))
    _id_C6296A5EC3B3611E linkTo(self, tag, origin_offset, angles_offset);
  else
    _id_C6296A5EC3B3611E linkTo(self);

  _id_C6296A5EC3B3611E.targetname = self.targetname + "_accessory";

  if(!isDefined(self.accessories))
    self.accessories = [];

  self.accessories[self.accessories.size] = _id_C6296A5EC3B3611E;
  return _id_C6296A5EC3B3611E;
}

vehicle_cp_create(vehicle, spawndata) {
  vehicle.bshouldoccupantsbeignored = 0;
  vehicle.lastkilltime = 0;
  vehicle.killedplayers = [];
  vehicle.killedby = [];
  vehicle.lastkilledby = undefined;
  vehicle.greatestuniqueplayerkills = 0;
  vehicle.damagedplayers = [];
  vehicle.lastkilltime = 0;
  vehicle.lastkilldogtime = 0;
  vehicle.recentkillcount = 0;
  vehicle.recentdefendcount = 0;
  vehicle.kills = 0;
  vehicle.deaths = 0;
  vehicle.pers["cur_kill_streak"] = 0;
  vehicle.pers["cur_death_streak"] = 0;
  vehicle.pers["cur_kill_streak_for_nuke"] = 0;
  vehicle.tookweaponfrom = [];
  vehicle.guid = vehicle getentitynumber();
  scripts\cp\cp_outofbounds::registerentforoob(vehicle, vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD());
}

vehicle_cp_createlate(vehicle, spawndata) {}

vehicle_cp_deletenextframe(vehicle) {
  scripts\cp\cp_outofbounds::clearoob(vehicle, 1);
}

vehicle_cp_deletenextframelate(vehicle) {}