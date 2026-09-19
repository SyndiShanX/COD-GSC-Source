/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_windmill_srv.gsc
******************************************************/

main() {
  maps\mp\mp_zombie_windmill_srv_precache::main();
  maps\createart\mp_zombie_windmill_srv_art::main();
  maps\mp\mp_zombie_windmill_srv_fx::main();
  _id_0483::main();
  maps\mp\mp_zombie_windmill_lighting::main();
  maps\mp\mp_zombie_windmill_aud::main();
  _id_0472::_id_8A2F("compass_map_mp_zombie_windmill_srv");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level._id_AC2E = 5;
  level._id_ABD3 = -3500;
  level.initnewzombietypes = ::init_new_zombie_types;
  level.sg_pack_use_small_radius = 1;
  level._id_AC71 = ::initwindmillweapons;
  level._id_783F = 0;
  level.door_data_out_of_date = 0;
  level.disable_jumpscare_playerdata = 0;
  level._id_6BB0 = ::onwindmillstartgame;
  level.reworkedconsumabledenabled = 1;
  level.loot_pap_camo_ref_override = "zom_amp_05";
  level.pap_camo_ref_override = "zom_frontline_01";
  level._id_ACA3 = 1;
  level._id_0C11 = 0;
  common_scripts\utility::flag_init("power_sz2");
  _id_5375();
  maps\mp\zombies\zombie_survival_common::init();
  thread maps\mp\mp_zombie_windmill_util::windmill_think();
  thread windmill_srv_ee();
  level thread add_windmill_ceiling_patch();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx::init();
  level.upgrade_machine_upgrade_func = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::collect_souls_to_unlock_pack_a_punch;
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::run_pack_a_punch_log();
}

initwindmillweapons() {
  level.sworddelivery_checkradius = 128;
  level thread maps\mp\zombies\zombie_survival_common::initsurvivalweapons();
}

add_windmill_ceiling_patch() {
  var_0 = common_scripts\utility::_id_46B7("ceiling_stuff_patches_05", "targetname");
  var_1 = common_scripts\utility::_id_46B7("ceiling_stuff_patches_04", "targetname");

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = var_3.angles;
    var_4 setModel("cob_floor_dmg_section_wood_05");
  }

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = var_3.angles;
    var_4 setModel("cob_floor_dmg_section_wood_04");
  }
}

_id_5375() {
  _id_055A::init();
  _id_055A::_id_530A("zone_plaza", 1);
  _id_055A::_id_088A();
  thread house_door_listener();
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_sizzler::init();
  maps\mp\zombies\zombie_survival_common::srv_init_miniboss_rounds();
}

house_door_listener() {
  common_scripts\utility::flag_init("zone_plaza_to_zone_house");
  common_scripts\utility::_id_3C9F("zone_plaza_to_zone_house");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_819A) && var_1._id_819A == "zone_plaza_to_zone_house" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1))
      var_1 notify("open", undefined);
  }
}

onwindmillstartgame() {
  level.roundstartfuncgeneric = ::windmill_srv_round_start;
  level.roundendfuncgeneric = ::windmill_srv_round_end;
}

windmill_srv_round_start() {
  level thread maps\mp\zombies\zombie_survival_common::srvroundstart();
}

windmill_srv_round_end() {
  level thread maps\mp\zombies\zombie_survival_common::srvroundend();
}

windmill_srv_ee() {
  level.ducks_per_window = 1;
  var_0 = 5;
  var_1 = getEntArray("hunt_ee", "targetname");
  var_2 = _func_18E("dog_ee", "targetname");
  var_2 setModel("zmw_tinker_toy_set_02");

  foreach(var_4 in var_1)
  var_4 setModel("zmw_belongings_toy_duck_01");

  var_2.target_struct = common_scripts\utility::_id_46B5(var_2.target, "targetname");
  var_2._id_926A = var_2.origin;
  var_2.raised_position = var_2.target_struct.origin;
  var_2.is_dog = 1;
  var_6 = _func_18E("srv_pap_fuse_spawn_loc", "targetname");
  var_6 _meth_8055(var_2);
  var_7 = _func_18E("srv_pap_fuse_pickup_trig", "targetname");
  var_7 common_scripts\utility::_id_9D9F();

  foreach(var_4 in var_1) {
    var_4._id_926A = var_4.origin;
    var_4._id_931A = "lowered";
    var_4.target_struct = common_scripts\utility::_id_46B5(var_4.target, "targetname");
    var_4.raised_position = var_4.target_struct.origin;
    var_4.damagecallback = ::ee_dmg_listen;
  }

  var_10 = 0;

  for(;;) {
    var_11 = common_scripts\utility::random(var_1);
    var_11.is_starter = 1;
    var_11 thread ee_raise();
    level waittill("ee_started", var_12);
    level.ee_contestant = var_12;
    level.ducks_per_window = 1;
    var_0 = 5;
    var_13 = 0;

    for(;;) {
      var_13++;
      var_14 = [];
      var_15 = undefined;
      var_16 = var_1;

      if(var_13 == 1)
        var_16 = common_scripts\utility::_id_0F93(var_16, var_11);

      level.ducks_killed_in_window = 0;

      while(var_14.size < level.ducks_per_window) {
        var_15 = common_scripts\utility::random(var_16);

        if(_id_0547::_id_5565(var_15._id_931A, "lowered")) {
          var_16 = common_scripts\utility::_id_0F93(var_16, var_15);
          var_14 = common_scripts\utility::_id_0F6F(var_14, var_15);
          continue;
        }

        waitframe();
      }

      foreach(var_4 in var_14)
      var_4 thread ee_raise();

      level common_scripts\utility::waittill_notify_or_timeout("all_ducks_in_window_killed", var_0);

      if(level.ducks_killed_in_window >= level.ducks_per_window) {
        if(var_13 == 3 || var_13 == 5) {
          level.ducks_per_window++;
          var_0 = var_0 + 5;
          wait 3;
        } else if(var_13 == 8) {
          var_10 = 1;
          break;
        }
      } else {
        foreach(var_4 in var_14)
        var_4 thread ee_lower();

        var_2 ee_show_dog_fail();
        level waittill("zombie_wave_started");
        var_10 = 0;
        break;
      }
    }

    if(var_10) {
      break;
    }
  }

  var_2 ee_show_dog_success(var_6);
}

ee_show_dog_fail() {
  self _meth_82B1(self.raised_position, 1, 0.1, 0.1);
  wait 1;
  self _meth_82BF(anglestoright(self.angles), 0.3, 0.3, 5);
  wait 5;
  self _meth_82B1(self._id_926A, 3, 0.1, 0.1);
  wait 3;
  self _meth_82B1(self._id_926A + (0, 0, 15), 0.25, 0.1, 0.1);
  wait 4;
  self _meth_82B1(self._id_926A, 3, 0.1, 0.1);
  wait 3;
}

ee_show_dog_success(var_0) {
  self _meth_82B1(self.raised_position, 1, 0.1, 0.1);
  wait 2;
  var_0 _meth_8057();
  var_0 thread ee_toss_fuse();
  wait 1;
  self _meth_82B1(self._id_926A, 1);
}

ee_toss_fuse() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_46B5("srv_pap_fuse_land_path", "targetname");
  var_0 _meth_82B1(var_1.origin, 0.15);
  var_2 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  wait 0.15;

  while(isDefined(var_2)) {
    var_0 _meth_82B1(var_2.origin, 0.15);

    if(isDefined(var_2.target))
      var_2 = common_scripts\utility::_id_46B5(var_2.target, "targetname");
    else
      var_2 = undefined;

    wait 0.15;
  }

  var_3 = _func_18E("srv_pap_fuse_pickup_trig", "targetname");
  var_3 common_scripts\utility::_id_9DA3();
  var_3 _meth_8177(1);
  var_3 waittill("trigger");
  var_0 delete();
  var_3 common_scripts\utility::_id_9D9F();
  level thread maps\mp\zombies\zombie_survival_common::srvshowpapfuse();
}

ee_raise(var_0) {
  if(!_id_0547::_id_5565(self._id_931A, "lowered")) {
    return;
  }
  self _meth_82C3(1);
  self _meth_849F(1);
  self._id_552B = 1;
  self._id_931A = "raising";

  if(!isDefined(var_0))
    var_0 = 0.5;

  if(var_0 <= 0)
    self.origin = self.raised_position;
  else {
    self _meth_82B1(self.raised_position, var_0, 0.1, 0.1);
    wait(var_0);
  }

  self._id_931A = "raised";
}

ee_lower(var_0, var_1) {
  if(!_id_0547::_id_5565(self._id_931A, "raised")) {
    return;
  }
  self._id_931A = "lowering";

  if(!isDefined(var_1))
    var_1 = 0;

  if(common_scripts\utility::_id_562E(var_1)) {
    self _meth_82C3(0);
    self _meth_849F(0);
    self._id_552B = 0;
  }

  if(!isDefined(var_0))
    var_0 = 0.5;

  self _meth_82B1(self._id_926A, var_0, 0.1, 0.1);
  wait(var_0);

  if(!common_scripts\utility::_id_562E(var_1)) {
    self _meth_82C3(0);
    self _meth_849F(0);
    self._id_552B = 0;
  }

  self.is_starter = 0;
  self._id_931A = "lowered";
}

ee_dmg_listen(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(_id_0547::_id_5565(var_4, "MOD_EXPLOSIVE") || _id_0547::_id_5565(var_4, "MOD_EXPLOSIVE_BULLET")) {
    return;
  }
  if(!common_scripts\utility::_id_562E(self._id_552B)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(isDefined(level.ee_contestant) && var_1 != level.ee_contestant) {
    return;
  }
  if(common_scripts\utility::_id_562E(self.is_starter)) {
    level notify("ee_started", var_1);
    thread ee_lower(undefined, 1);
  } else {
    if(common_scripts\utility::_id_562E(self.is_dog)) {
      return;
    }
    level notify("duck_killed", var_1);
    thread ee_lower(undefined, 1);
    level.ducks_killed_in_window++;

    if(level.ducks_killed_in_window >= level.ducks_per_window)
      level notify("all_ducks_in_window_killed");
  }
}