/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_jackal_arena_dogfight.gsc
*****************************************************************/

_id_11985() {}

_id_1195A() {
  thread _id_A172();
  level._id_588A = [];
  level._id_588A["allies"] = [];
  level._id_588A["enemies"] = [];
  level._id_5872 = 0;
  level._id_5873 = [];
  var_0 = ["ally_jackal_1", "ally_jackal_2"];
  var_1 = ["ally_trigger_1", "ally_trigger_2"];
  var_2 = ["enemy_jackal_1", "enemy_jackal_2"];
  var_3 = ["ally_jackal_10"];
  var_4 = ["ally_trigger_10"];
  var_5 = ["enemy_jackal_10"];
  var_6 = ["ally_jackal_4"];
  var_7 = ["ally_trigger_4"];
  var_8 = ["enemy_jackal_4"];
  var_9 = ["ally_jackal_9", "ally_jackal_8"];
  var_10 = ["ally_trigger_9", "ally_trigger_8"];
  var_11 = ["enemy_jackal_9", "enemy_jackal_8"];
  var_12 = ["ally_jackal_5"];
  var_13 = ["ally_trigger_11"];
  var_14 = ["enemy_jackal_5"];
  level thread _id_F9B5(var_0, var_2, var_1, "arena_spline_1");
  level thread _id_F9B5(var_6, var_8, var_7, "arena_spline_2");
  level thread _id_F9B5(var_9, var_11, var_10, "arena_spline_3");
}

_id_119A2() {
  level thread _id_56F7("turbine_location_1", 135000, "start_turbine_1_fight");
  level waittill("start_turbine_1_fight");
  thread _id_134CE();
  scripts\engine\utility::flag_wait("player_at_bottleneck");
  var_0 = getEnt("ally_jackal_3", "script_noteworthy");
  var_1 = getEnt("ally_jackal_6", "script_noteworthy");
  var_2 = ["ally_intro_spline_1", "ally_intro_spline_2"];
  var_3 = getEnt("enemy_intro_jackal_1", "script_noteworthy");
  var_4 = getEnt("enemy_intro_jackal_2", "script_noteworthy");
  var_5 = getEnt("enemy_intro_jackal_3", "script_noteworthy");
  var_6 = ["enemy_intro_spline_1", "enemy_intro_spline_2", "enemy_intro_spline_3"];
  var_7 = _id_0BDC::_id_7BBA() + (anglestoup(_id_0BDC::_id_7BB9()) * 500 + anglestoright(_id_0BDC::_id_7BB9()) * 500 + anglesToForward(_id_0BDC::_id_7BB9()) * 10);
  var_8 = _id_0BDC::_id_7BBA() + (anglestoup(_id_0BDC::_id_7BB9()) * 1000 + anglestoright(_id_0BDC::_id_7BB9()) * -1000 + anglesToForward(_id_0BDC::_id_7BB9()) * 20);
  var_9 = _id_0BDC::_id_7BBA() + (anglestoup(_id_0BDC::_id_7BB9()) * 700 + anglestoright(_id_0BDC::_id_7BB9()) * 1000 + anglesToForward(_id_0BDC::_id_7BB9()) * 30);
  var_10 = var_3 scripts\sp\utility::_id_10808();
  var_11 = var_4 scripts\sp\utility::_id_10808();
  var_12 = var_5 scripts\sp\utility::_id_10808();
  var_13 = [var_10, var_11, var_12];
  var_10 vehicle_teleport(var_7, _id_0BDC::_id_7BB9());
  var_11 vehicle_teleport(var_8, _id_0BDC::_id_7BB9());
  var_12 vehicle_teleport(var_9, _id_0BDC::_id_7BB9());

  foreach(var_19, var_15 in var_13) {
    var_15 _id_0BDC::_id_19AB(750);
    var_15 _id_0BDC::_id_19A0(1);
    var_15 _id_0BDC::_id_19B2("face motion");
    var_15 _id_0BDC::_id_19B0("fly");
    var_15._id_932F = 1;
    var_15.ignoreall = 1;
    var_16 = getcsplineid(var_6[var_19]);
    var_17 = calccsplineclosestpoint(var_16, var_15.origin);
    var_18 = scripts\engine\utility::spawn_tag_origin(var_17);

    if(!_id_0B76::_id_9C19(var_18)) {
      var_15 vehicle_teleport(var_17, _id_0BDC::_id_7BB9());
    }

    var_18 delete();
    var_15 thread _id_6447("turbine_location_1", 36000, "enemy_fighter_through");
    var_15 thread _id_0BDC::_id_A1EF(var_16, _id_0BDC::_id_7B9E() * 2, 4000, 1);
    var_15 scripts\sp\vehicle::_id_8441();
  }

  foreach(var_19, var_15 in var_13) {
    var_15 thread _id_1059D(level._id_D127, randomint(20) + 10, 0, 10, 0.05);
    wait(randomfloatrange(0.2, 0.5));
  }

  wait 1.0;

  foreach(var_19, var_15 in var_13) {
    var_15 scripts\sp\vehicle::_id_8440();
  }

  level thread _id_3D58(var_13);
  level thread _id_56F7("turbine_location_1", 36000, "start_turbine_1_fight");
  level scripts\engine\utility::waittill_any("start_turbine_1_fight", "enemy_fighter_through");
  var_22 = var_0 scripts\sp\utility::_id_10808();
  var_23 = var_1 scripts\sp\utility::_id_10808();
  var_24 = [var_22, var_23];
  var_25 = scripts\engine\utility::getStruct("ally_follow_in_pos_1", "targetname");
  var_26 = scripts\engine\utility::getStruct("ally_follow_in_pos_2", "targetname");
  var_27 = scripts\engine\utility::getStruct("ally_end_pos_1", "targetname");
  var_28 = scripts\engine\utility::getStruct("ally_end_pos_2", "targetname");
  var_29 = [var_25, var_26];
  var_30 = [var_27, var_28];

  foreach(var_19, var_32 in var_24) {
    var_32.ignoreall = 1;
    var_32.ignoreme = 1;
    var_16 = getcsplineid(var_2[var_19]);
    var_17 = calccsplineclosestpoint(var_16, var_32.origin);
    var_32 vehicle_teleport(var_17, _id_0BDC::_id_7BB9());
    var_32 thread _id_0BDC::_id_A1EF(var_16, _id_0BDC::_id_7B9E() * 2, 4000, 1);
    var_33 = undefined;

    foreach(var_15 in var_13) {
      if(isDefined(var_15) && isalive(var_15)) {
        var_33 = var_15;
        break;
      }
    }

    var_32 thread _id_1059D(var_33, randomint(60) + 30, 50, 100, 0.05);
  }

  scripts\engine\utility::flag_set("enemy_jackal_down");
  wait 1.0;

  foreach(var_19, var_32 in var_24) {
    var_32 _id_0BDC::_id_1990(1);
  }

  foreach(var_15 in var_13) {
    if(isDefined(var_15) && isalive(var_15)) {
      var_15 _meth_81D0();
    }

    wait(randomfloatrange(0.5, 1.0));
  }

  scripts\engine\utility::flag_wait("missile_boats_destroyed");
}

_id_1359D(var_0) {
  self endon("death");
  self waittill("near_goal");
  thread _id_A2A0(scripts\sp\utility::_id_7C9A(var_0));
  thread _id_1364A(20.0);
}

_id_134CE() {
  if(scripts\engine\utility::flag_exist("intro_vo_complete")) {
    scripts\engine\utility::flag_wait("intro_vo_complete");
  }

  var_0 = ["titan_slt_scar2wehaveabogey", "titan_s21_11weareengaged"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
  scripts\engine\utility::flag_wait("enemy_jackal_down");
  level thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_s21_spashdown");
  wait 0.5;
  var_0 = ["titan_slt_21ineedyoubattin", "titan_s21_rogerthatfever"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
  wait 0.35;
  wait 10;
}

_id_134CD() {
  var_0 = ["titan_slt_21ineedyoubattin", "titan_s21_rogerthatfever"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
  wait 0.35;
}

_id_119A1() {
  level thread _id_1195A();
  scripts\engine\utility::flag_wait("missile_boats_destroyed");
  scripts\engine\utility::flag_set("turbine_jackal_dead");
}

_id_A188() {
  _id_0BDC::_id_A321(0.25);
  _id_A186("dogfight_arena_jackal_wave_1");
  thread _id_A17A();
  thread _id_D15D();
  _id_13796(level._id_5873, 2, 45);
  scripts\sp\utility::_id_2669("jackal_dogfight_wave_1");
  level notify("disable_combat_reminder_vo");
  level thread _id_A180();
}

_id_A17A() {
  level endon("disable_combat_reminder_vo");
  var_0 = [];
  var_0[0] = "titan_slt_weneedtotake";
  var_0[1] = "titan_slt_letsputsomeheat";
  var_0[2] = "titan_slt_pickupthepace";
  var_0[3] = "titan_slt_quitsittingaroundand";
  var_0[4] = "titan_slt_cleartheskythen";
  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    wait(randomfloatrange(25, 35));
    scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8(var_0[var_1]);

    if(var_1 == 1) {
      scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_tryin");
    }
  }
}

_id_A171() {
  level endon("disable_ajak_combat_reminder_vo");
  var_0 = [];
  var_0[0] = "titan_slt_takeoutthatajaks";
  var_0[1] = "titan_slt_focusyourfireon";
  var_0[2] = "titan_slt_targetthatfloatingscrap";
  var_0[3] = "titan_slt_dropthatajak";
  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    wait(randomfloatrange(25, 35));
    scripts\sp\utility::_id_56BE("destroy_ajak", 5);
    scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8(var_0[var_1]);
  }
}

_id_D15D() {
  level endon("disable_jackal_hover_monitor");
  var_0 = getEnt("turbine_1_combat_volume", "targetname");

  for(;;) {
    wait 1;

    if(level._id_D127.spaceship_mode != "hover") {
      continue;
    }
    _id_D15F(var_0);
  }
}

_id_D15F(var_0) {
  var_1 = randomintrange(10, 15);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(level._id_D127.spaceship_mode == "hover") {
      wait 1;
      continue;
    }

    return;
  }

  if(level._id_D127 istouching(var_0)) {
    _id_D15E();
  }
}

_id_D15E() {
  var_0 = [];

  foreach(var_2 in level._id_5873) {
    if(isDefined(var_2) && _id_0B76::_id_9C19(var_2)) {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  if(var_0.size <= 0) {
    return;
  }
  var_4 = scripts\sp\utility::_id_7EB4(level._id_D127.origin, var_0);
  var_4 _id_0B76::_id_1945(level._id_D127, ["tag_flash_right", "tag_flash_left"], 3);
}

_id_A189() {
  scripts\sp\utility::_id_2669("jackal_dogfight_wave_2");
  _id_0BDC::_id_A321(0.75);

  foreach(var_1 in level._id_A056._id_A82D) {
    _id_0BDC::_id_16EE(var_1, 25000);
  }

  _id_A186("dogfight_arena_jackal_wave_2");
  wait 1.5;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_jackalsquadcomingin");
  thread _id_A17A();
  _id_13796(level._id_5873, 2, 30);
  level notify("disable_combat_reminder_vo");
  thread _id_A177();
  wait 5;
  scripts\engine\utility::flag_set("arena_jackals_destroyed");

  while(level._id_5873.size > 0) {
    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_2669("jackal_dogfighting_clear");
}

_id_A184() {
  level._id_EAD6 endon("disable_rubberband_speed");

  for(;;) {
    var_0 = _id_0BDC::_id_7B9E();

    if(var_0 > 25) {
      level._id_EAD6 _meth_845F(clamp(var_0 + 50, 100, 500));
    } else {
      level._id_EAD6 _meth_845F(0);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_A183() {
  level._id_EAD6 endon("disable_dogfight_attack_logic");
  level._id_EAD6 notify("stop_friendly_wingman");
  level._id_EAD6 notify("disable_rubberband_speed");
  level._id_EAD6.ignoreall = 1;
  level._id_EAD6 _id_0BDC::_id_19A0(0);
  level._id_EAD6 _id_0BDC::_id_1990(1);
}

_id_A185() {
  level._id_EAD6 _meth_847A();
  level._id_EAD6 _id_0BDC::_id_1990(0);
  level._id_EAD6 _id_0BDC::_id_19A0(1);
  level._id_EAD6 _meth_8491("hover");
  level._id_EAD6 thread _id_0BDC::_id_198A();
  var_0 = scripts\engine\utility::getStructArray("salter_landing_pad_wait", "targetname");
  level._id_EAD6 scripts\sp\maps\titanjackal\titanjackal_arena_events::_id_EADD(var_0[0].origin, 400, 1, var_0[0].angles, 256);
}

_id_A186(var_0) {
  var_1 = scripts\sp\utility::_id_8201(var_0, "targetname");
  scripts\sp\utility::_id_22C7(var_1, ::_id_A173);
  scripts\sp\utility::_id_22C6(var_1);
  scripts\engine\utility::waitframe();
}

_id_A173() {
  self endon("death");
  level._id_5873 = scripts\engine\utility::add_to_array(level._id_5873, self);
  scripts\engine\utility::waitframe();
  thread _id_A174();
  var_0 = scripts\sp\utility::_id_7C9A(self.target);
  self _meth_8479(var_0);
  self _meth_847B(0.05, self.origin);
  self waittill("near_goal");
  _id_0C24::_id_10A44(var_0);

  if(isDefined(self.script_noteworthy)) {
    thread _id_A176(scripts\sp\utility::_id_7C9A(self.script_noteworthy));
  } else {
    thread _id_A175();
  }
}

_id_A176(var_0) {
  self endon("death");
  _id_0BDC::_id_1990(1);
  _id_0BDC::_id_19B1(1);
  scripts\engine\utility::flag_wait("jackals_retreated");
  thread _id_0BDC::_id_105D8();
  _id_A182();
}

_id_A175() {
  self endon("death");
  _id_0BDC::_id_19AB(300, 300, 300, 300);
  _id_0BDC::_id_19B1(1);
  _id_0BDC::_id_1990(0);
  _id_0BDC::_id_19AF(75, 75, 75);
  self._id_6E9C._id_50D1 = 0.4;
  self._id_6E9C._id_50D0 = 0.5;
  scripts\engine\utility::flag_wait("jackals_retreated");
  thread _id_0BDC::_id_105D8();
  _id_0BDC::_id_A321(0);
  _id_0BDC::_id_19B1(0);
  _id_A182();
}

_id_A174() {
  self waittill("death");
  level._id_5872++;
  level._id_5873 = scripts\engine\utility::array_removeundefined(level._id_5873);
}

_id_A177() {
  scripts\engine\utility::flag_set("jackals_retreated");
  level notify("stop_arena_dogfighting");
  _id_A185();
}

_id_A182() {
  self endon("death");

  while(isDefined(level.player._id_58B7) && level.player._id_58B7 == self) {
    scripts\engine\utility::waitframe();
  }

  self _meth_847A();
  self.ignoreall = 1;
  _id_0BDC::_id_1990(0);
  _id_0BDC::_id_19B1(0);
  _id_0BDC::_id_19A0(1);
  _id_0BDC::_id_19AB(1200, 300, 300, 300);
  thread _id_0BDC::_id_A1F4("enemy_jackal_retreat_point", 1, 1024);
  scripts\engine\utility::waittill_any_timeout(15, "goal");
  self delete();
}

_id_A172() {
  level waittill("player_landed");
  level._id_5873 = scripts\engine\utility::array_removeundefined(level._id_5873);

  foreach(var_1 in level._id_5873) {
    var_1 _meth_81D0();
  }
}

_id_A180() {
  wait 2;
  var_0 = scripts\engine\utility::getStructArray("missile_boat_pre_spawn_los", "targetname");
  var_1 = scripts\sp\utility::_id_7EB4(level._id_D127.origin, var_0);
  var_2 = getEnt(var_1.target, "targetname");
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_5 _id_0BDC::_id_9C1B(0.9)) {
      var_3 = scripts\engine\utility::array_add(var_3, var_5);
    }
  }

  if(var_3.size > 0) {
    var_7 = scripts\sp\utility::_id_7EB4(level._id_D127.origin, var_3);
    var_2 = getEnt(var_7.target, "targetname");
  }

  var_8 = var_2 _id_0BB1::_id_B870();
  var_8 waittill("ftl_complete");
  scripts\engine\utility::flag_set("missile_boat_spawned");
  var_9 = getEnt("missile_boat_central_volume", "script_noteworthy");
  var_8 thread _id_0BB1::_id_F486(var_9, [level._id_D127], 35000);
  var_8 notify("no_ftl_escape");
  var_8 thread _id_A17E();
  var_8 thread _id_A17B();
  var_8 thread _id_A17F();
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_watchoutanajak");
  setmusicstate("mx_499_titan_ajak");
  wait 2;
  thread _id_A171();
  level notify("disable_jackal_hover_monitor");
  var_8 waittill("death");
  level notify("disable_ajak_combat_reminder_vo");
  wait 0.25;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_ajakgoingdown");
  scripts\engine\utility::flag_set("missile_boats_destroyed");
}

_id_A17E() {
  level.player endon("death");
  self waittill("engine_destroyed");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_keepitupengine");
  scripts\sp\utility::_id_2669("jackal_dogfight_ajak_engine_damaged");
}

_id_A17B() {
  level.player endon("death");
  self endon("death");
  self waittill("all_turrets_dead");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titanjackal_slt_targettheajakse");
  scripts\sp\utility::_id_2669("jackal_dogfight_ajak_all_turrets_destroyed");
}

_id_A17F() {
  self waittill("death");
  wait 5;
  _id_A189();
}

_id_13796(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread scripts\sp\utility_code::_id_13758(var_2);
  }

  var_10.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_10.count) {
    var_10.count = var_1;
  }

  scripts\engine\utility::array_thread(var_0, scripts\sp\utility_code::_id_13757, var_10);

  while(var_10.count > 0) {
    var_10 waittill("waittill_dead guy died");
  }
}

_id_648B() {
  level thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_Itsbehindyou");
  var_0 = getEnt("enemy_jackal_7", "script_noteworthy");
  var_1 = var_0 scripts\sp\utility::_id_10808();
  var_1 _id_0BDC::_id_19AB(500);
  var_2 = _id_0BDC::_id_7BBA() + anglestoup(_id_0BDC::_id_7BB9()) * 200.0 + anglesToForward(_id_0BDC::_id_7BB9()) * 1.0;
  var_1 vehicle_teleport(var_2, _id_0BDC::_id_7BB9());
  var_1.ignoreme = 1;
  var_3 = getEnt("turbine_1_combat_volume", "targetname");
  var_1 _meth_84B7(var_3);
  var_1 thread _id_6491();
  wait 0.7;
  level thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_copythat");
  var_1 waittill("death");
  level thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("sc_titan_plr_Clear");
  wait 1.0;
  scripts\engine\utility::flag_set("turbine_jackal_dead");
}

_id_6490() {
  self endon("death");
  level.player endon("flag_player_is_landing");
  var_0 = ["player_fight_jackal_spline", "player_fight_jackal_spline_2", "player_fight_jackal_spline_3"];
  var_1 = scripts\engine\utility::getStruct("enemy_hover_attack_point", "targetname");
  self._id_24DD = "trubine_1_enemy_jackal";
  self.ignoreall = 1;
  thread _id_A327();
  _id_0BDC::_id_19A0(1);
  _id_0BDC::_id_19B0("fly");
  _id_0BDC::_id_19B2("face motion");
  _id_0BDC::_id_A1EC(var_1.origin, 1, 2000.0);
  self.ignoreall = 0;
  self._id_932F = 1;
  thread _id_0BDC::_id_19B5(level._id_D127);
  _id_0BDC::_id_19AB(200);
  _id_0BDC::_id_19B0("hover");
  _id_0BDC::_id_19A0(0);
  _id_0BDC::_id_19B2("face enemy");
  _id_0BDC::_id_19AE("shoot_now");
}

_id_648F() {
  self endon("death");
  level.player endon("flag_player_is_landing");
  var_0 = scripts\engine\utility::getStruct("enemy_hover_attack_point", "targetname");
  self._id_24DD = "trubine_1_enemy_jackal";
  self.ignoreall = 1;
  thread _id_A327();
  _id_0BDC::_id_19A0(1);
  _id_0BDC::_id_19B0("fly");
  _id_0BDC::_id_19B2("face motion");
  _id_0BDC::_id_A1EC(var_0.origin, 1, 2000.0);
  self.ignoreall = 0;
  self._id_932F = 1;
  thread _id_0BDC::_id_19B5(level._id_D127);
  _id_0BDC::_id_19AB(400);
  _id_0BDC::_id_19A0(0);
  _id_0BDC::_id_19B2("face enemy");
  _id_0BDC::_id_19AE("shoot_now");
  var_1 = getEnt("turbine_1_combat_volume", "targetname");
  self _meth_84B7(var_1);
}

_id_6491() {
  self endon("death");
  level.player endon("flag_player_is_landing");
  var_0 = ["player_fight_jackal_spline", "player_fight_jackal_spline_2", "player_fight_jackal_spline_3"];
  var_1 = scripts\engine\utility::getStruct("enemy_hover_attack_point", "targetname");
  self._id_24DD = "trubine_1_enemy_jackal";
  self.ignoreall = 1;
  thread _id_A327();
  _id_0BDC::_id_19A0(1);
  _id_0BDC::_id_19B0("fly");
  _id_0BDC::_id_19B2("face motion");

  for(;;) {
    _id_0BDC::_id_A1EC(var_1.origin, 1, 2000.0);
    _id_0BDC::_id_19B0("hover");
    thread _id_A56D();
    wait 1.0;
    _id_0BDC::_id_19A0(0);
    self notify("stop_tracking_player");
    _id_0BDC::_id_19B0("fly");
    _id_0BDC::_id_19B2("face motion");
    self.ignoreall = 0;
    self._id_932F = 1;
    thread _id_0BDC::_id_19B5(level._id_D127);
    _id_0BDC::_id_19AB(700);
    var_2 = 0;

    for(;;) {
      level._id_D127 waittill("damage", var_3, var_4);

      if(isDefined(var_4._id_24DD) && var_4._id_24DD == "trubine_1_enemy_jackal") {
        var_2++;
      }

      if(var_2 >= 1) {
        break;
      }

      scripts\engine\utility::waitframe();
    }

    thread _id_0BDC::_id_198A();
    self.ignoreall = 1;
    _id_0BDC::_id_19A0(1);
    _id_0BDC::_id_19AB(400);
    var_5 = scripts\engine\utility::random(var_0);
    var_6 = scripts\sp\utility::_id_7C9A("player_fight_jackal_spline");
    _id_0BDC::_id_A1ED(var_6, 2000, 4000.0);
    _id_0BDC::_id_A342(var_6);
  }
}

_id_A56D() {
  self endon("death");
  self endon("stop_tracking_player");

  for(;;) {
    var_0 = vectorNormalize(_id_0BDC::_id_7BBA() - self.origin);
    _id_0BDC::_id_19B2("face angle", vectortoangles(var_0));
    scripts\engine\utility::waitframe();
  }
}

_id_A327() {
  self endon("death");
  level.player endon("flag_player_is_landing");
  target_set(self);
  target_setshader(self, "ac130_hud_target_flash");
  target_setoffscreenshader(self, "jackal_objective_offscreen");
}

_id_F9B5(var_0, var_1, var_2, var_3, var_4) {
  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = getEnt(var_0[var_5], "script_noteworthy");
    var_7 = getEnt(var_1[var_5], "script_noteworthy");
    var_8 = var_3;
    var_9 = strtok(var_3, "_");
    var_10 = var_9[0] + "_enemy_" + var_9[1] + "_" + var_9[2];
    var_11 = var_6 scripts\sp\utility::_id_10808();
    var_11.ignoreall = 1;
    var_11 scripts\sp\vehicle::_id_8441();
    var_11 thread _id_A2A1(var_8);
    var_11 thread _id_1CCD(var_2[var_5], var_7, var_10);
    level._id_588A["allies"] = ::scripts\engine\utility::array_add(level._id_588A["allies"], var_11);
  }
}

_id_A2A0(var_0) {
  self endon("death");

  if(issentient(self)) {
    _id_0BDC::_id_19A0(1);
  }

  _id_0BDC::_id_A1EF(var_0, 500, 4000, 1);

  for(;;) {
    _id_0BDC::_id_A1EF(var_0, 500, 4000);
  }
}

_id_A2A1(var_0) {
  self endon("death");
  var_1 = getcsplineid(var_0);
  self._id_10A43 = var_1;
  self _meth_847A();
  self _meth_8479(self._id_10A43);
  self _meth_847B(0.05, self.origin);
  self waittill("near_goal");
  _id_0C24::_id_10A44(var_1);
  scripts\engine\utility::waitframe();

  for(;;) {
    self _meth_8479(self._id_10A43);
    self _meth_847B(0.05);
    self waittill("near_goal");
    _id_0C24::_id_10A44(var_1);
  }
}

_id_1CCD(var_0, var_1, var_2) {
  self endon("death");
  level endon("stop_arena_dogfighting");
  var_3 = undefined;

  for(;;) {
    var_3 = getEnt(var_0, "targetname");
    var_3 waittill("trigger");

    if(scripts\engine\utility::flag("jackals_retreated")) {
      continue;
    }
    var_4 = vectorNormalize(self.origin - _id_0BDC::_id_7BBA());
    var_5 = vectordot(var_4, anglesToForward(_id_0BDC::_id_7BB9()));

    if(var_5 < 0.8) {
      var_6 = self.origin + anglesToForward(self.angles) * 6000;
      var_7 = getcsplineid(var_2);
      var_6 = calccsplineclosestpoint(var_7, var_6);
      var_8 = var_1 scripts\sp\utility::_id_10808();
      var_8 _id_0BDC::_id_19B1(0);
      var_8 vehicle_teleport(var_6, self.angles);
      var_8 thread _id_1DC3();
      level._id_588A["enemies"] = ::scripts\engine\utility::array_add(level._id_588A["enemies"], var_8);
      var_8 thread _id_A2A1(var_2);
      var_9 = randomintrange(3, 6);

      for(var_10 = 0; var_10 < var_9; var_10++) {
        _id_1D1F(var_8);
      }

      _id_1DC2(var_8);

      if(isDefined(var_8)) {
        thread _id_1D1F(var_8);
        level._id_588A["enemies"] = ::scripts\engine\utility::array_remove(level._id_588A["enemies"], var_8);
        var_8 thread _id_0BDC::_id_6B4C("none");
        var_8 _meth_81D0();
      }

      wait 3.0;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_1DC2(var_0) {
  var_0 endon("death");

  for(;;) {
    _id_1D1F(var_0);

    if(_id_0B76::_id_9C19(self)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_1DC3() {
  self endon("death");
  scripts\engine\utility::flag_wait("jackals_retreated");
  scripts\sp\vehicle::_id_8440();
  level._id_588A["enemies"] = ::scripts\engine\utility::array_remove(level._id_588A["enemies"], self);
  self _meth_81D0();
}

_id_4EA6() {
  self waittill("death", var_0, var_1, var_2);
}

_id_DFF7() {
  if(isDefined(level._id_588A["allies"])) {
    foreach(var_1 in level._id_588A["allies"]) {
      if(isalive(var_1)) {
        var_1 delete();
      }
    }
  }

  if(isDefined(level._id_588A["enemies"])) {
    foreach(var_4 in level._id_588A["enemies"]) {
      if(isalive(var_4)) {
        var_4 delete();
      }
    }
  }
}

_id_1D1F(var_0) {
  self endon("death");
  _id_1059D(var_0, randomintrange(7, 12), 0, 15, 0.05);
}

_id_1059D(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self._id_B165 = "tag_flash_left";
  self._id_B166 = "tag_flash_right";
  self._id_B6B6 = "magic_spaceship_30mm_projectile";
  var_5 = 1;

  if(!isDefined(var_4)) {
    var_4 = 0.15;
  }

  if(!isDefined(var_1)) {
    var_1 = randomintrange(15, 25);
  }

  for(var_6 = 0; var_6 < var_1; var_6++) {
    if(var_5) {
      var_7 = self gettagorigin(self._id_B165) + anglesToForward(self.angles) * 100;
      var_8 = "tag_flash_left";
    } else {
      var_7 = self gettagorigin(self._id_B166) + anglesToForward(self.angles) * 100;
      var_8 = "tag_flash_right";
    }

    if(!isDefined(var_0)) {
      var_9 = var_7 + anglesToForward(self.angles) * 1000;
    } else {
      var_10 = scripts\engine\utility::cointoss();
      var_11 = randomfloatrange(var_2, var_3);
      var_12 = randomfloatrange(var_2, var_3);

      if(var_10) {
        var_11 = var_11 * -1;
        var_12 = var_12 * -1;
      }

      var_9 = var_0.origin + (0, 0, 35) + (var_11, 0, var_12);
    }

    magicbullet(self._id_B6B6, var_7, var_9, level.player, self);

    if(var_5) {
      var_5 = 0;
    } else {
      var_5 = 1;
    }

    wait(var_4);
  }
}

_id_10CDC(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = var_2.origin;
  var_4 = undefined;

  if(scripts\engine\utility::player_is_in_jackal()) {
    var_4 = _id_0BDC::_id_7BBA();
  } else {
    var_4 = level.player.origin;
  }

  var_5 = distance2dsquared(var_4, var_3);

  if(var_5 <= squared(var_1)) {
    return 1;
  } else {
    return 0;
  }
}

_id_56F7(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_4 = var_3.origin;

  for(;;) {
    var_5 = _id_0BDC::_id_7BBA();
    var_6 = distance2dsquared(var_5, var_4);

    if(var_6 <= squared(var_1)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::waitframe();
  level notify(var_2);
}

_id_6447(var_0, var_1, var_2) {
  self endon("death");
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_4 = squared(var_1);

  for(;;) {
    if(distance2dsquared(self.origin, var_3.origin) <= var_4) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level notify(var_2);
}

_id_1067B(var_0) {
  level endon("stop_arena_dogfighting");
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  for(;;) {
    var_2 = vectorNormalize(var_1.origin - _id_0BDC::_id_7BBA());
    var_3 = anglesToForward(_id_0BDC::_id_7BB9());
    var_4 = vectordot(var_2, var_3);

    if(var_4 < 0.6) {
      var_5 = randomintrange(1, 3);

      for(var_6 = 0; var_6 < var_5; var_6++) {
        var_7 = scripts\engine\utility::cointoss();
        var_8 = var_1.origin + scripts\engine\utility::randomvectorrange(-10000, 10000);
        var_9 = spawn("script_model", var_8);
        var_9 setModel("veh_mil_air_un_jackal_02");
        var_9.angles = var_1.angles;
        var_9._id_5294 = var_9.origin + anglesToForward(var_9.angles) * 80000;
        var_9 moveTo(var_9._id_5294, randomfloatrange(8.0, 12.0), 0, 0);
        playFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_dying"), var_9, "tag_origin");
        var_9 thread _id_3D50(randomfloatrange(2.0, 5.0));
      }

      wait(randomfloatrange(3.0, 5.0));
    }

    wait 0.15;
  }
}

_id_3D50(var_0) {
  wait(var_0);
  stopFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_damage_med_linger"), self, "tag_origin");
  playFX(scripts\engine\utility::getfx("fighter_spaceship_explosion"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  playworldsound("jackal_explode", self.origin);
  self delete();
}

_id_1364A(var_0) {
  self endon("death");
  wait(var_0);
  self _meth_81D0();
}

_id_3D58(var_0) {
  for(;;) {
    foreach(var_2 in var_0) {
      if(!isalive(var_2)) {
        level thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("jk_slt_target_acquired");
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_EA96() {
  if(scripts\engine\utility::flag_exist("intro_vo_complete")) {
    scripts\engine\utility::flag_wait("intro_vo_complete");
  }

  level thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("jk_slt_target_sighted");
}

_id_4051() {
  level notify("stop_arena_dogfighting");

  if(!isDefined(level._id_588A)) {
    return;
  }
  foreach(var_1 in level._id_588A["allies"]) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }

  foreach(var_1 in level._id_588A["enemies"]) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}