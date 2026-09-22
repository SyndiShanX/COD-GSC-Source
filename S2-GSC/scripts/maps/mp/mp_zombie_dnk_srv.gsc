/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dnk_srv.gsc
*************************************************/

main() {
  maps\mp\mp_zombie_dnk_srv_precache::main();
  maps\createart\mp_zombie_dnk_srv_art::main();
  maps\mp\mp_zombie_dnk_srv_fx::main();
  _id_0483::main();
  maps\mp\mp_zombie_dnk_lighting::main();
  maps\mp\mp_zombie_dnk_aud::main();
  _id_0472::_id_8A2F("compass_map_mp_zombie_dnk_srv");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("1520", "-1 -1 -1 50");
  setDvar("2494", "0.12, 0, 0");
  level._id_AC2E = 6;
  level.sg_pack_use_small_radius = 1;
  level._id_ACA3 = 1;
  level._id_323A = 1;
  level._id_6BB0 = ::ondnksrvstartgame;
  level._id_AC71 = ::initdnksrvweapons;
  level.initnewzombietypes = ::init_new_zombie_types;
  level.door_data_out_of_date = 0;
  level._id_0C11 = 0;
  level._id_ABD3 = -1500;
  level._id_783F = 0;
  level.reworkedconsumabledenabled = 1;
  level.loot_pap_camo_ref_override = "zom_amp_04";
  level.pap_camo_ref_override = "zom_camo_01";
  thread maps\mp\mp_zombie_dnk_code::ship_tilting_init();
  thread performance_stuff();
  common_scripts\utility::flag_init("dnk_defense_drop_spawner_enabled");
  common_scripts\utility::flag_set("dnk_defense_drop_spawner_enabled");
  _id_055A::init();
  _id_055A::_id_530A("zone_dunkirk", 1);
  _id_055A::_id_088A();
  level.wavetabletypestoexclude = ["zombie_heavy"];
  thread dnk_srv_ee();
  maps\mp\zombies\zombie_survival_common::init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx::init();
  level.upgrade_machine_upgrade_func = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::collect_souls_to_unlock_pack_a_punch;
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::run_pack_a_punch_log();
}

initdnksrvweapons() {
  level.sworddelivery_checkradius = 128;
  level thread maps\mp\zombies\zombie_survival_common::initsurvivalweapons();
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_sizzler::init();
}

ondnksrvstartgame() {
  thread maps\mp\mp_zombie_dnk_code::water_trap_init();
  level.roundstartfuncgeneric = ::dnk_srv_round_start;
  level.roundendfuncgeneric = ::dnk_srv_round_end;
}

dnk_srv_round_start() {
  level thread maps\mp\zombies\zombie_survival_common::srvroundstart();
}

dnk_srv_round_end() {
  level thread maps\mp\zombies\zombie_survival_common::srvroundend();
}

performance_stuff() {
  setDvar("634", 0);
}

dnk_srv_ee() {
  level.dnk_srv_wheel_turn_count = 0;
  var_0 = getEntArray("ee_wheel", "targetname");
  level.dnk_srv_wheel_turn_max = var_0.size;

  foreach(var_2 in var_0) {
    var_2 thread dnk_srv_ee_wheel_listen();
  }
}

dnk_srv_ee_wheel_listen() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = _getEnt(self.target, "targetname");
  var_0 useTriggerRequireLookAt(1);
  var_0 waittill("trigger", var_1);
  var_0 delete();
  self rotateTo((self.angles[0], self.angles[1], self.angles[2] + 180), 1, 0.25, 0.25);
  level.dnk_srv_wheel_turn_count++;

  if(level.dnk_srv_wheel_turn_count >= level.dnk_srv_wheel_turn_max) {
    dnk_srv_drop_fuse();
  }
}

dnk_srv_drop_fuse() {
  var_0 = _getEnt("srv_pap_fuse_spawn_loc", "targetname");
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_2 = _getEnt(var_1.target, "targetname");

  if(isDefined(var_1)) {
    var_0 _id_0547::obj_fall_to_ent_location(var_1);
  }

  var_2 useTriggerRequireLookAt(1);
  var_2 waittill("trigger", var_3);
  var_0 delete();
  var_2 delete();
  level thread maps\mp\zombies\zombie_survival_common::srvshowpapfuse();
}