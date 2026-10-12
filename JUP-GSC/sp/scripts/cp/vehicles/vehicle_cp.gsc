/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_cp.gsc
***********************************************/



#using script_18ae04893bb2f9ac;
#using script_228478d4175cb3b9;
#using script_31e1ae5e1ddce676;
#using script_3bdd48aafc976300;
#using script_5ef6975905ae15bf;
#using script_66df092e7e148d2f;
#using script_6e32c3e5e141c690;
#using script_7c390291bf40788f;
#using scripts\common\utility;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\damagefeedback;
#using scripts\cp\utility;
#using scripts\cp\vehicles\damage_cp;
#using scripts\cp\vehicles\vehicle_compass_cp;
#using scripts\cp\vehicles\vehicle_damage_cp;
#using scripts\cp\vehicles\vehicle_interact_cp;
#using scripts\cp\vehicles\vehicle_occupancy_cp;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp\vehicles\vehicle_spawn_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace vehicle_cp;

function vehicle_cp_init() {
  scripts\engine\utility::registersharedfunc("vehicle", "create", &vehicle_cp_create);
  scripts\engine\utility::registersharedfunc("vehicle", "createLate", &vehicle_cp_createlate);
  scripts\engine\utility::registersharedfunc("vehicle", "deleteNextFrame", &vehicle_cp_deletenextframe);
  scripts\engine\utility::registersharedfunc("vehicle", "deleteNextFrameLate", &vehicle_cp_deletenextframelate);
  scripts\engine\utility::registersharedfunc("vehicle", "createHint", &scripts\cp\utility::createhintobject);
  scripts\engine\utility::registersharedfunc("vehicle_interact", "init", &scripts\cp\vehicles\vehicle_interact_cp::vehicle_interact_cp_init);
  scripts\engine\utility::registersharedfunc("vehicle_occupancy", "init", &scripts\cp\vehicles\vehicle_occupancy_cp::vehicle_occupancy_cp_init);
  scripts\engine\utility::registersharedfunc("vehicle_spawn", "init", &scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_init);
  scripts\engine\utility::registersharedfunc("vehicle_compass", "init", &scripts\cp\vehicles\vehicle_compass_cp::vehicle_compass_cp_init);
  scripts\engine\utility::registersharedfunc("vehicle_damage", "init", &scripts\cp\vehicles\vehicle_damage_cp::vehicle_damage_cp_init);
  scripts\engine\utility::registersharedfunc("veh9_rhib", "init", &namespace_d8a94de1eaf55642::function_944a2eb36063f641);
  scripts\engine\utility::registersharedfunc("veh9_jltv", "init", &namespace_b66b4ef2e3a7020d::function_52b33e520a612e1c);
  scripts\engine\utility::registersharedfunc("veh9_jltv_mg", "init", &namespace_f5874001d201a304::function_d06448e049fab02f);
  scripts\engine\utility::registersharedfunc("veh9_palfa", "init", &namespace_b0ffbd8b9a4c0b87::function_59eb5f2de04c842a);
  scripts\engine\utility::registersharedfunc("veh9_patrol_boat", "init", &namespace_855ebb0984f091f0::function_6e5970ec1a994b0b);
  scripts\engine\utility::registersharedfunc("veh9_suv_1996", "init", &namespace_8600c6128c661c9f::function_7fbb4bdc170016b2);
  scripts\engine\utility::registersharedfunc("veh9_sedan_hatchback_1985", "init", &namespace_50d0b417576cdea4::function_f8cd879642397a71);
  scripts\engine\utility::registersharedfunc("veh9_mil_cargo_truck", "init", &namespace_cb8c441d992fbeff::function_974dace3684b9e9b);
  scripts\cp\vehicles\damage_cp::init();
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_init();
  scripts\engine\utility::registersharedfunc("veh9_techo_rebel_armor", "armorDamageFeedback", &scripts\cp\damagefeedback::function_cb98b2b16c183664);
  scripts\engine\utility::registersharedfunc("veh9_techo_rebel_armor", "armorDeathFeedback", &scripts\cp\damagefeedback::function_974320dd370c5572);
}

function spawn_script_model_at_pos(posindex, tag, animname, xanim, model) {
  assertex(!istrue(self.usedpositions[posindex]), "Trying to assign to a position already in use");
  spawnorg = self gettagorigin(tag);
  spawnang = self gettagangles(tag);
  startorg = getstartorigin(spawnorg, spawnang, xanim);
  startangles = getstartangles(spawnorg, spawnang, xanim);
  spawned = spawn("script_model", startorg);
  spawned.angles = startangles;
  spawned setModel(model);
  spawned linkTo(self);

  if(isDefined(animname)) {
    spawned scriptmodelplayanim(animname);
  }

  spawned.vehicle_position = posindex;
  spawned.disable_gun_recall = 1;
  self.attachedguys[self.attachedguys.size] = spawned;
  self.usedpositions[posindex] = 1;
  self.riders[self.riders.size] = spawned;

  if(posindex == 0) {
    self.driver = spawned;
  }

  return spawned;
}

function spawn_vehicle_accessory(model, on_tag, origin_offset, angles_offset) {
  modeltospawn = spawn("script_model", self.origin);
  modeltospawn setModel(model);
  modeltospawn notsolid();
  modeltospawn show();

  if(!isDefined(origin_offset)) {
    origin_offset = (0, 0, 0);
  }

  if(!isDefined(angles_offset)) {
    angles_offset = (0, 0, 0);
  }

  tag = "tag_origin";

  if(isDefined(on_tag)) {
    tag = on_tag;
  }

  tagorigin = self gettagorigin(tag);

  if(isDefined(tagorigin)) {
    modeltospawn linkTo(self, tag, origin_offset, angles_offset);
  } else {
    modeltospawn linkTo(self);
  }

  modeltospawn.targetname = self.targetname + "_accessory";

  if(!isDefined(self.accessories)) {
    self.accessories = [];
  }

  self.accessories[self.accessories.size] = modeltospawn;
  return modeltospawn;
}

function vehicle_cp_create(vehicle, spawndata) {
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
  vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth(vehicle);
  vehicle.health = vehicle.maxhealth;
  scripts\cp\cp_outofbounds::registerentforoob(vehicle, vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());
}

function vehicle_cp_createlate(vehicle, spawndata) {}

function vehicle_cp_deletenextframe(vehicle) {
  scripts\cp\cp_outofbounds::clearoob(vehicle, 1);
}

function vehicle_cp_deletenextframelate(vehicle) {}