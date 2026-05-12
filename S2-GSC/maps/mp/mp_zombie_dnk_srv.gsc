/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dnk_srv.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_zombie_dnk_srv_precache::func_F9();
  maps\createart\mp_zombie_dnk_srv_art::func_F9();
  maps\mp\mp_zombie_dnk_srv_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_zombie_dnk_lighting::func_F9();
  maps\mp\mp_zombie_dnk_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_zombie_dnk_srv");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("1520", "-1 -1 -1 50");
  setDvar("2494", "0.12, 0, 0");
  level.var_AC2E = 6;
  level.sg_pack_use_small_radius = 1;
  level.var_ACA3 = 1;
  level.var_323A = 1;
  level.var_6BB0 = ::ondnksrvstartgame;
  level.var_AC71 = ::initdnksrvweapons;
  level.initnewzombietypes = ::init_new_zombie_types;
  level.door_data_out_of_date = 0;
  level.var_C11 = 0;
  level.var_ABD3 = -1500;
  level.var_783F = 0;
  level.reworkedconsumabledenabled = 1;
  level.loot_pap_camo_ref_override = "zom_amp_04";
  level.pap_camo_ref_override = "zom_camo_01";
  thread maps\mp\mp_zombie_dnk_code::ship_tilting_init();
  thread performance_stuff();
  common_scripts\utility::func_3C87("dnk_defense_drop_spawner_enabled");
  common_scripts\utility::func_3C8F("dnk_defense_drop_spawner_enabled");
  lib_055A::func_D5();
  lib_055A::func_530A("zone_dunkirk", 1);
  lib_055A::func_88A();
  level.wavetabletypestoexclude = ["zombie_heavy"];
  thread dnk_srv_ee();
  maps\mp\zombies\zombie_survival_common::func_D5();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx::func_D5();
  level.upgrade_machine_upgrade_func = ::maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::collect_souls_to_unlock_pack_a_punch;
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::run_pack_a_punch_log();
}

initdnksrvweapons() {
  level.sworddelivery_checkradius = 128;
  level thread maps\mp\zombies\zombie_survival_common::initsurvivalweapons();
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_sizzler::func_D5();
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
  var_00 = getEntArray("ee_wheel", "targetname");
  level.dnk_srv_wheel_turn_max = var_00.size;
  foreach(var_02 in var_00) {
    var_02 thread dnk_srv_ee_wheel_listen();
  }
}

dnk_srv_ee_wheel_listen() {
  if(!isDefined(self.var_1A2)) {
    return;
  }

  var_00 = getent(self.var_1A2, "targetname");
  var_00 usetriggerrequirelookat(1);
  var_00 waittill("trigger", var_01);
  var_00 delete();
  self rotateto((self.var_1D[0], self.var_1D[1], self.var_1D[2] + 180), 1, 0.25, 0.25);
  level.dnk_srv_wheel_turn_count++;
  if(level.dnk_srv_wheel_turn_count >= level.dnk_srv_wheel_turn_max) {
    dnk_srv_drop_fuse();
  }
}

dnk_srv_drop_fuse() {
  var_00 = getent("srv_pap_fuse_spawn_loc", "targetname");
  var_01 = common_scripts\utility::func_46B5(var_00.var_1A2, "targetname");
  var_02 = getent(var_01.var_1A2, "targetname");
  if(isDefined(var_01)) {
    var_00 lib_0547::obj_fall_to_ent_location(var_01);
  }

  var_02 usetriggerrequirelookat(1);
  var_02 waittill("trigger", var_03);
  var_00 delete();
  var_02 delete();
  level thread maps\mp\zombies\zombie_survival_common::srvshowpapfuse();
}