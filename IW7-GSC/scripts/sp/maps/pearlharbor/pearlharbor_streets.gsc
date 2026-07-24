/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_streets.gsc
***************************************************************/

_id_C9E3() {
  scripts\engine\utility::flag_init("civ_street_dropship_spawned");
  scripts\engine\utility::flag_init("civ_street_dropship_leaving");
  scripts\engine\utility::flag_init("dropship_lake_fly_away");
  scripts\engine\utility::flag_init("ethan_animation_trigger");
  scripts\engine\utility::flag_init("ethan_rocket_prep");
  scripts\engine\utility::flag_init("gas_civilain_moment");
  scripts\engine\utility::flag_init("break_execution_1");
  scripts\engine\utility::flag_init("break_execution_2");
  scripts\engine\utility::flag_init("civ_streets_alerted");
  scripts\engine\utility::flag_init("ledge_guys_fallback");
  scripts\engine\utility::flag_init("bus_enemies_alerted");
  scripts\engine\utility::flag_init("lake_ship_crash_started");
  scripts\engine\utility::flag_init("lake_crash_wave_started");
  scripts\engine\utility::flag_init("lake_ship_crash_complete");
  precachemodel("vehicle_civ_yacht_02_clr05_static");
  precachemodel("vehicle_civ_yacht_02_clr03_static");
  precachemodel("vehicle_civ_yacht_02_clr02_static");
  precachemodel("vehicle_civ_yacht_02_clr01_static");
  precachemodel("vehicle_civ_yacht_03_clr01_static");
  precachemodel("vehicle_civ_yacht_03_clr04_static");
  precachemodel("vehicle_civ_yacht_03_clr06_static");
  precachemodel("vehicle_civ_yacht_02");
  precachemodel("veh_civ_sea_sailboat_01");
  precachemodel("veh_civ_sea_yacht_01");
  precachemodel("p7_vista_buoy_03");
  precachemodel("weapon_m8_garand_wm");
  precachemodel("weapon_kb_m4_wm");
  getEnt("civ_street_dropship", "targetname") scripts\sp\utility::_id_1747(::_id_3FB2);
  scripts\sp\utility::_id_22C9("civ_street_runner", ::_id_3FB8);
  scripts\sp\utility::_id_22C9("civ_street_dropship_riders", ::_id_3FB3);
  scripts\sp\utility::_id_22C9("second_story_guys", ::_id_10B0E);
  scripts\sp\utility::_id_22C9("third_story_guys", ::_id_10B17);
  var_0 = getEntArray("street_sniper1", "script_noteworthy");

  if(var_0.size) {
    scripts\sp\utility::_id_22C9("street_sniper1", scripts\sp\maps\pearlharbor\pearlharbor_util::_id_103BE);
  }

  scripts\engine\utility::array_call(getEntArray("streets_lake_movers", "targetname"), ::notsolid);
  thread _id_A7B1();
}

_id_3FEB() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_civs");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_civs", var_0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF24("streets_scriptable_cars");
  scripts\sp\utility::_id_15F3("civ_street_entrance_colortrig");
}

_id_3FEA() {
  createthreatbiasgroup("civilians");
  thread _id_3F99();
  thread _id_3F98();
  scripts\engine\utility::flag_wait("civ_street_dropship_spawned");
  scripts\engine\utility::exploder("streets_dropship_explosion");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_F417(1);
  }

  scripts\engine\utility::flag_wait("civ_street_dropship_leaving");
  scripts\sp\vehicle::_id_1080F("civ_street_dropship_flybys");

  foreach(var_1 in level.allies) {
    wait(randomfloatrange(0.01, 0.2));
    var_1 scripts\sp\utility::_id_F417(0);
  }

  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_15F4("civ_street_dropship_ally_enemy_trig");

  if(!scripts\engine\utility::flag("player_movedup_civ_street")) {
    scripts\sp\utility::_id_15F3("civ_street_postdropship_colortrig");
  }

  scripts\engine\utility::flag_wait("civs_complete");
}

_id_3F99() {
  scripts\engine\utility::flag_wait("grenade_vo_complete");
  scripts\engine\utility::flag_wait("civ_street_dropship_spawned");
  scripts\sp\utility::_id_28D7("allies");
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_civiliansareeve");
  wait 0.6;
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_airshiptakecove");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_itstargetingciv");
  wait 0.15;
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_thisishorrible");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_hitthatgunner");
  wait 3;
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_gettoshelter");
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_gorun");
  wait 1.5;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_theyredeploying");
  scripts\sp\utility::_id_10350("phstreets_plr_cutemdown");
  scripts\sp\utility::_id_28D8("allies");
}

_id_3F98() {
  scripts\sp\utility::_id_13630("cleanup_pre_crash_enemies");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!scripts\sp\utility::_id_CFAC(var_2)) {
      var_2 scripts\sp\utility::_id_54C6();
    }
  }
}

_id_115B1() {
  scripts\sp\utility::_id_127B3("civs_execution_alerted_colortrig");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_51E1("sprint");
  }

  scripts\sp\utility::_id_127B3("post_boat_crash_color_trig");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_51E1("combat");
  }
}

_id_3FB2() {
  scripts\engine\utility::flag_set("civ_street_dropship_spawned");
  scripts\engine\utility::exploder("rattle_tree_dropship_street_civs");
  scripts\engine\utility::exploder("dropship_attack_1");
  thread _id_3FB4(5);
  var_0 = getEntArray("civ_street_dropship_runners", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_10619, 1);
  var_1 = getEnt("civ_street_dropship_mg", "targetname");
  var_1 linkTo(self);
  var_1 setmode("manual");
  var_1 setturretteam("axis");
  var_1 setbottomarc(90);
  var_2 = anglestoright(self.angles);
  var_3 = self.origin + (0, 90, 50) + var_2 * 180;
  var_4 = scripts\engine\utility::spawn_tag_origin(var_3);
  var_4 linkTo(self);
  var_5 = getEnt(var_1.target, "targetname");
  var_6 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_4 = var_6 scripts\engine\utility::spawn_tag_origin();
  var_4 linkTo(self);
  var_7 = var_5 scripts\sp\utility::_id_10619(1);
  var_7.noragdoll = 1;
  var_7.nocorpsedelete = 1;
  var_7 linkTo(var_4, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_7.ignoreme = 0;
  var_4 thread scripts\sp\anim::_id_1ECC(var_7, "turret_aim_idle");
  thread _id_5ED1(var_7);
  thread _id_0BBD::_id_5DB9("right");
  self notsolid();
  thread _id_3FB6(var_1);
  var_1 thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_035A([0.15, 0.25]);
  var_8 = scripts\engine\utility::getStruct("civ_street_dropship_riders_target", "targetname");
  level._id_1111F = var_8 scripts\engine\utility::spawn_tag_origin();
  self waittill("mg_target_path_end");
  var_1 setmode("auto_nonai");
  var_1 cleartargetentity();
  var_7 scripts\sp\utility::_id_F2A8(1);
  var_7 setCanDamage(1);
  var_7 scripts\sp\utility::_id_1101B();
  scripts\sp\utility::_id_178D(scripts\sp\utility::timeout, 9);
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "player_movedup_civ_street");
  var_7 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_57D6();

  if(isDefined(var_7) && isalive(var_7)) {
    var_7 scripts\sp\utility::_id_54C6();
  }

  var_1 setmode("manual");
  var_1 notify("stop_fire");
  scripts\sp\utility::_id_65E3("unloaded");
  scripts\engine\utility::flag_set("civ_street_dropship_leaving");
  scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_10FEC, "dropship_attack_1");
  scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_10FEC, "rattle_tree_dropship_street_civs");
  self waittill("death");
  var_1 delete();

  if(isDefined(var_7)) {
    var_7 delete();
  }
}

_id_5ED1(var_0) {
  var_0 waittill("death");

  foreach(var_2 in level.allies) {
    wait(randomfloatrange(0.01, 0.1));
    var_2 clearentitytarget();
  }
}

_id_3FB4(var_0) {
  var_1 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_B284(level.player);
  var_1 scripts\sp\utility::_id_E7C9(0.4, var_0);

  while(isDefined(self) && isalive(self) && distance2dsquared(self.origin, level.player.origin) < squared(1500)) {
    wait 0.05;
  }

  if(isDefined(self) && isalive(self)) {
    thread _id_3FB5();
  }

  var_1 scripts\sp\utility::_id_E7C9(0, 5);
  var_1 delete();
}

_id_3FB5() {
  self endon("death");

  while(distance2dsquared(self.origin, level.player.origin) > squared(1500)) {
    wait 0.05;
  }

  thread _id_3FB4(1);
}

_id_3FB6(var_0) {
  var_1 = scripts\engine\utility::getStruct("civ_dropship_mg_target", "targetname");
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_0 settargetentity(var_2);
  var_3 = var_1;

  for(;;) {
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_5 = distance(var_3.origin, var_4.origin);
    var_6 = vectorNormalize(var_4.origin - var_3.origin);
    var_7 = var_4.radius;
    var_8 = var_4._id_ED75;
    var_9 = var_5 * 0.05 / var_8;
    var_10 = int(var_5 / var_9);
    var_11 = var_3.origin;

    for(var_12 = 0; var_12 < var_10; var_12++) {
      var_2.origin = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_11, var_7);
      wait 0.05;
      var_11 = var_11 + var_6 * var_9;
    }

    var_13 = var_4 scripts\sp\utility::_id_7A97();

    foreach(var_15 in var_13) {
      if(var_15 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C120("car_blowup")) {
        radiusdamage(var_15.origin, 15, 9999, 9999);
        continue;
      }

      if(var_15 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C120("glass")) {
        var_15 thread _id_3FB7();
      }
    }

    if(!isDefined(var_4.target)) {
      break;
    }

    var_3 = var_4;
  }

  self notify("mg_target_path_end");
  var_2 delete();
}

_id_3FB0() {
  scripts\sp\utility::script_delay();
  var_0 = 0;

  if(isDefined(self._id_ED75)) {
    var_0 = self._id_ED75 * 1000;
  }

  var_1 = gettime();

  for(;;) {
    if(isDefined(self._id_ED48)) {
      if(scripts\engine\utility::flag(self._id_ED48)) {
        return;
      }
    } else if(gettime() - var_1 >= var_0) {
      return;
    }
    var_2 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(self.origin, self.radius);
    var_2 = scripts\sp\utility::_id_864C(var_2);
    var_3 = scripts\common\trace::ray_trace(self.origin, var_2);

    if(isDefined(var_3["entity"])) {
      playFX(scripts\engine\utility::getfx("hill_c6_bullet_impact"), var_3["position"], var_3["normal"]);
    }

    wait(randomfloatrange(0.05, 0.1));
  }
}

_id_3FB7() {
  scripts\sp\utility::script_delay();
  var_0 = getglassarray(self.script_parameters);

  foreach(var_2 in var_0) {
    var_3 = anglesToForward(self.angles);
    destroyglass(var_2, var_3);
  }
}

_id_3FB3() {
  self endon("death");
  scripts\sp\utility::_id_65E0("shoot_up_street");
  scripts\sp\utility::_id_65E3("shoot_up_street");
  self _meth_82DE(level._id_1111F);
  scripts\engine\utility::flag_wait("player_movedup_civ_street");
  self clearentitytarget(level._id_1111F);
}

_id_3FB8() {
  var_0 = self.spawner;
  self.grenadeawareness = 0;
  var_1 = var_0 scripts\sp\utility::_id_7A96();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_1);
}

_id_40AA() {
  scripts\sp\utility::_id_127B3("cleanup_pre_crash_enemies");
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_3 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), var_2.origin);

      if(var_3 < 0.2) {
        var_2 _meth_81D0();
        wait(randomfloatrange(0.15, 0.5));
      }
    }
  }
}

_id_3FB1() {
  wait 1;
  var_0 = getEntArray("civ_street_corner_building_shutters", "targetname");

  foreach(var_2 in var_0) {
    if(var_2 scripts\sp\maps\pearlharbor\pearlharbor_util::_id_C120("right")) {
      var_2 rotateYaw(-125, 0.25, 0, 0.1);
      continue;
    }

    var_2 rotateYaw(160, 0.25, 0, 0.1);
  }
}

_id_68DF() {
  level.player scripts\sp\utility::_id_10350("phstreets_plr_shouldbegettingclose");
  wait 1;
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_civiliansareevewatch");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_whyaretheytargeting");
  wait 0.1;
  level._id_1C5B = 1;
  level.player thread scripts\sp\utility::_id_10350("phstreets_plr_idontknowethan");
  wait 1;

  if(scripts\engine\utility::flag("lake_ship_crash_started")) {
    return;
  }
  level endon("lake_ship_crash_started");
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_motherfathers");
  level._id_CAE6 = 1;
  level.player scripts\sp\utility::_id_10350("phstreets_plr_ouratisgunsare");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_ifwedontgettoth");
}

_id_3FE5() {
  scripts\engine\utility::flag_set("civs_complete");
  getEnt("civ_street_dropship_mg", "targetname") delete();
}

_id_3FE9() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_civs_execution");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_civs_execution", var_0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF24("streets_scriptable_cars");
  scripts\sp\utility::_id_15F5("civs_execution_colortrig");
}

_id_3FE8() {
  thread _id_A7A6();
  thread _id_32D0();
  thread _id_68DF();
  scripts\engine\utility::flag_wait("execution_enemies_alerted");
}

_id_32D0() {
  var_0 = scripts\engine\utility::getStructArray("bus_screams", "targetname");
  var_1 = [];
  var_1[var_1.size] = "phstreets_fcv3_cryscream" + randomintrange(1, 7);
  var_1[var_1.size] = "phstreets_fcv2_cryscream" + randomintrange(1, 2);
  var_1[var_1.size] = "phstreets_fcv4_cryscream1";
  var_1[var_1.size] = "phstreets_fcv1_screamsatguns";
  var_1[var_1.size] = "phstreets_mcv5_cryscream" + randomintrange(1, 3);
  var_1[var_1.size] = "phstreets_mcv1_cryscream1";
  var_1[var_1.size] = "phstreets_mcv2_cryscream1";
  var_1[var_1.size] = "phstreets_mcv3_cryscream1";
  var_1[var_1.size] = "phstreets_mcv4_cryscream1";

  while(!scripts\engine\utility::flag("cap_crash_lake_complete")) {
    var_2 = scripts\engine\utility::random(var_0);
    var_3 = scripts\engine\utility::random(var_1);
    thread scripts\engine\utility::play_sound_in_space(var_3, var_2.origin);
    wait(randomfloatrange(0.8, 1.6));
  }
}

_id_32CF() {
  scripts\engine\utility::flag_wait("civ_bus_scene_start");
  thread _id_11116();
  var_0 = getEntArray("street_bus_enemies", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\utility::_id_10619(1);
    var_4 = var_2 scripts\sp\utility::_id_7A96();
    var_3 thread _id_11114(var_4);
  }
}

_id_11114(var_0) {
  self endon("death");
  self._id_C009 = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  thread _id_68E0();
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  thread scripts\engine\utility::delete_on_death(var_1);
  self _meth_82DE(var_1);
  thread _id_11115();

  while(!scripts\engine\utility::flag("execution_enemies_alerted")) {
    var_1.origin = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_0.origin, var_0.radius, var_0.height);
    wait(randomfloatrange(0.5, 1.5));
  }

  self clearentitytarget();
  self.ignoreme = 0;
  self.ignoreall = 0;
  var_1 delete();
}

_id_11115() {
  self endon("death");
  level endon("execution_enemies_alerted");

  for(;;) {
    var_0 = randomintrange(5, 15);

    for(var_1 = 0; var_1 < var_0; var_1++) {
      self shoot();
      wait 0.15;
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

_id_11116() {
  var_0 = getEnt("street_bus_runners_trig", "targetname");
  var_0 endon("trigger");
  scripts\engine\utility::flag_wait("execution_enemies_alerted");
  var_0 notify("trigger");
}

_id_68E5() {
  scripts\engine\utility::flag_wait_either("civ_execution_scene_start", "execution_enemies_alerted");
  var_0 = getEnt("street_execution_enemy", "targetname");
  var_1 = getEntArray("street_execution_civs", "targetname");
  var_2 = var_0 scripts\sp\utility::_id_10619(1);
  var_2.ignoreall = 1;
  var_2.ignoreme = 1;
  var_2 scripts\sp\utility::_id_F2A8(1);
  var_2 setCanDamage(1);
  var_2._id_1FBB = "enemy";
  var_2 thread _id_68E6();
  var_2 thread _id_68E0();
  var_3 = [];

  foreach(var_8, var_5 in var_1) {
    var_6 = var_5 scripts\sp\utility::_id_10619(1);
    var_6.ignoreall = 1;
    var_6.ignoreme = 1;
    var_6 scripts\sp\utility::_id_F2A8(1);
    var_6._id_1FBB = "civ_" + var_8;
    var_7 = var_5 scripts\sp\utility::_id_7A96();
    var_6 thread _id_68E6(var_7, 1);
    var_3[var_8] = var_6;
  }

  var_9 = scripts\engine\utility::array_add(var_3, var_2);
  var_10 = scripts\engine\utility::getStruct("street_execution_struct", "targetname");
  var_10 scripts\sp\anim::_id_1F2C(var_9, "civ_execution");
}

_id_68E6(var_0, var_1) {
  self endon("death");
  scripts\engine\utility::flag_wait("execution_enemies_alerted");
  wait 2.5;
  self.ignoreall = 0;
  self.ignoreme = 0;

  if(isDefined(var_1)) {
    self _meth_82B1(scripts\sp\utility::_id_7DC1("civ_execution"), 0);
    wait(randomfloatrange(0.25, 1));
  }

  if(isalive(self)) {
    self _meth_83A1();
  }

  if(isDefined(var_0)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_0);
  }
}

_id_68E0() {
  self endon("death");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("explode");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "execution_enemies_alerted");
  scripts\sp\utility::_id_57D6();
  scripts\engine\utility::flag_set("execution_enemies_alerted");
}

_id_3FE7() {}

_id_3954() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_cap_crash_lake");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_cap_crash_lake", var_0);
  thread _id_A7A6();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF24("streets_scriptable_cars");
  thread _id_0B0F::_id_10D23("ship_crash_ambient_battle");
}

_id_3953() {
  thread _id_10B03();
  level._id_A7AD["ships_to_delete"] = getEntArray("streets_lake_movers", "targetname");
  scripts\engine\utility::array_call(level._id_A7AD["ships_to_delete"], ::delete);
  level._id_A7AD["moving_ships"] = level._id_A7AD["boat_rig"] _id_AD02();
  thread _id_A7AD();
  scripts\engine\utility::flag_wait("cap_crash_lake_complete");
}

_id_A7A7() {
  var_0 = getEnt("run_from_boat_trigger", "targetname");

  if(!isDefined(level._id_CAE6) && isDefined(level._id_1C5B)) {
    level.player thread scripts\sp\utility::_id_10350("phstreets_plr_ouratisgunsare");
  }

  level._id_CAE6 = undefined;
  level._id_1C5B = undefined;
  level waittill("endurance_is_hit");
  level.allies["admiral"] scripts\sp\utility::_id_51E1("frantic");
  level.allies["admiral"].moveplaybackrate = 1.1;
  level.allies["salter"] scripts\sp\utility::_id_51E1("frantic");
  level.allies["salter"].moveplaybackrate = 1.1;
  wait 1.25;
  scripts\sp\utility::_id_28D7("allies");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_enduranceishit");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_gotcha");
  wait 2;

  if(isDefined(var_0)) {
    var_0 notify("trigger");
  }

  scripts\engine\utility::flag_wait("lake_crash_wave_started");
  wait 0.75;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_gorightgoright");
  wait 2.25;
  scripts\engine\utility::flag_wait("lake_ship_crash_complete");
  level.allies["admiral"] scripts\sp\utility::_id_51E1("combat");
  level.allies["admiral"].moveplaybackrate = 1.0;
  level.allies["salter"] scripts\sp\utility::_id_51E1("combat");
  level.allies["salter"].moveplaybackrate = 1.0;
  wait 1;
  level.allies["salter"] scripts\sp\utility::_id_10347("phstreets_slt_whichway");
  wait 0.2;
  level.allies["eth3n"] scripts\sp\utility::_id_10347("phstreets_eth_northupthestree");
  var_1 = getEnt("into_square_colors", "targetname");

  if(isDefined(var_1)) {
    var_1 waittill("trigger");
  }

  level.player scripts\sp\utility::_id_10350("phstreets_plr_openfire");
  scripts\sp\utility::_id_28D8("allies");
}

#using_animtree("script_model");

_id_A7B1() {
  level endon("cap_crash_lake_complete");
  level._id_A7AD = [];
  scripts\engine\utility::flag_wait("phstreets_streets_tr_loaded");
  var_0 = scripts\engine\utility::getStruct("lake_ship_crash_struct", "targetname");
  var_1 = scripts\engine\utility::getStruct("lake_crash_mayhem_struct", "targetname");
  var_2 = scripts\sp\utility::_id_10639("yacht");
  var_3 = scripts\sp\utility::_id_10639("boat_rig");

  if(!scripts\sp\utility::hastag(var_2.model, "tag_origin")) {
    var_2.clip = getEnt("lakecrash_yacht_clip", "targetname");
    var_4 = getEnt("lake_ship_crash_aatis", "targetname");
    var_2.clip delete();
    var_2 delete();
    var_4 delete();
    return;
  }

  var_2.clip = getEnt("lakecrash_yacht_clip", "targetname");
  var_2.clip linkTo(var_2, "tag_origin", (0, 0, 0), (0, 0, 0));
  level._id_A7AD["yacht"] = var_2;
  level._id_A7AD["boat_rig"] = var_3;
  var_0 scripts\sp\anim::_id_1EC3(var_2, "lake_ship_crash");
  var_1 scripts\sp\anim::_id_1EC3(var_3, "lake_ship_crash");
  var_4 = getEnt("lake_ship_crash_aatis", "targetname");
  var_4 _meth_83D0(#animtree);
  var_4._id_1FBB = "aatis";
  level._id_A7AD["aatis"] = var_4;
  var_4 scripts\sp\anim::_id_1EC3(var_4, "lake_ship_crash");
  level._id_A7AD["street_prestine"] = getEntArray("lake_crash_street_prestine", "targetname");

  foreach(var_6 in level._id_A7AD["street_prestine"]) {
    var_6 dontcastshadows();
  }

  level._id_A7AD["street_destroyed"] = getEntArray("lake_crash_street_destroyed", "targetname");

  foreach(var_6 in level._id_A7AD["street_destroyed"]) {
    var_6 dontcastshadows();
  }

  level._id_A7AD["movers"] = getEntArray("lake_crash_movers", "targetname");

  foreach(var_6 in level._id_A7AD["movers"]) {
    var_6 dontcastshadows();
  }
}

_id_AD02() {
  var_0 = [];
  var_1 = scripts\sp\utility::_id_7CCC("ph_tsunami_boat_rig");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "__");

    if(var_3 != "tag_origin") {
      var_5 = var_4 _id_7AF4();
      var_6 = scripts\sp\anim::_id_1EE5(var_5, var_3);
      var_0 = scripts\engine\utility::array_add(var_0, var_6);
    }
  }

  return var_0;
}

_id_7AF4() {
  var_0 = "";

  for(var_1 = 1; var_1 < self.size - 1; var_1++) {
    var_0 = var_0 + self[var_1];

    if(var_1 != self.size - 2) {
      var_0 = var_0 + "_";
    }
  }

  return var_0;
}

_id_A7A6() {
  var_0 = level._id_A7AD["aatis"];
  var_1 = scripts\sp\utility::_id_10639("aatis", var_0.origin, var_0.angles);

  if(isDefined(var_0._id_11583)) {
    var_0._id_11583 delete();
  }

  var_0 delete();
  var_1 thread scripts\sp\anim::_id_1EEA(var_1, "lake_ship_crash_loop", "fire_now");
  level._id_A7AD["aatis"] = var_1;
  var_1 thread _id_A7AF();
}

_id_A7AD() {
  scripts\sp\utility::_id_127B3("lake_ship_crash_trig");
  var_0 = getEnt("into_square_colors", "targetname");
  scripts\engine\utility::flag_set("lake_ship_crash_started");
  thread _id_A7A7();
  thread _id_A7AA();
  var_1 = scripts\engine\utility::getStruct("lake_ship_crash_struct", "targetname");
  var_2 = scripts\engine\utility::getStruct("lake_crash_mayhem_struct", "targetname");
  var_3 = spawnStruct();
  var_3.origin = (44936, 26400, -33752);
  var_3.angles = var_2.angles;
  var_4 = scripts\engine\utility::spawn_tag_origin((54213, 31854, -34152), (0, 43, 0));
  level._id_A7AD["aatis"] notify("fire_now");
  level._id_A7AD["aatis"] thread scripts\sp\anim::_id_1F35(level._id_A7AD["aatis"], "lake_ship_crash");
  wait 2;
  scripts\engine\utility::noself_delaycall(1.3, ::playworldsound, "scn_phstreets_endurance_falling", (44488, 37432, -34020));
  level notify("endurance_is_hit");
  thread scripts\engine\utility::play_sound_in_space("capitalship_death_explosion", var_4.origin);
  earthquake(0.5, 1, level.player.origin, 9999);
  level.player playRumbleOnEntity("artillery_rumble");
  level thread _id_A7AB();
  wait 1;
  thread scripts\engine\utility::play_sound_in_space("scn_phstreets_shipwater_incoming_lr", (44488, 37432, -34020));
  thread _id_FC34();
  spawnmayhem("lake_crash_capship_mayhem", "vfx_mayh_pearl_harbor_destroyer_crash_water_tsunami", var_3.origin, var_3.angles);
  playmayhem("lake_crash_capship_mayhem");
  wait 4;
  thread _id_8770();
  thread scripts\engine\utility::play_sound_in_space("scn_phstreets_shipwater_crash_lr", var_2.origin);
  earthquake(0.25, 2, var_2.origin, 99999);
  level.player playRumbleOnEntity("artillery_rumble");
  scripts\engine\utility::exploder("capshipsplash");
  level._id_A7AD["yacht"] thread _id_A7B2();
  thread _id_A7B3();
  spawnmayhem("lake_crash_wave_mayhem", "vfx_mayh_pearl_harbor_tsunami", var_2.origin, var_2.angles);
  playmayhem("lake_crash_wave_mayhem");
  thread _id_FD3B();
  var_2 thread scripts\sp\anim::_id_1F35(level._id_A7AD["boat_rig"], "lake_ship_crash");
  scripts\engine\utility::flag_set("lake_crash_wave_started");
  level._id_A7AD["yacht"] thread _id_D6C3();
  scripts\engine\utility::delaythread(8.5, ::_id_480A, var_2.origin);
  var_1 scripts\sp\anim::_id_1F35(level._id_A7AD["yacht"], "lake_ship_crash");
  killmayhem("lake_crash_wave_mayhem");
  scripts\engine\utility::flag_set("lake_ship_crash_complete");
  level.player thread scripts\sp\utility::_id_D2CD(100, 0.5);
  level.player scripts\engine\utility::allow_sprint(1);

  if(isDefined(var_0)) {
    var_0 notify("trigger");
    scripts\engine\utility::waitframe();
    var_0 delete();
  }

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  scripts\engine\utility::flag_wait("start_dust_area");
  level._id_A7AD["yacht"] delete();
  scripts\engine\utility::array_call(level._id_A7AD["moving_ships"], ::delete);
}

_id_A7AA() {
  level endon("lake_ship_crash_complete");
  var_0 = getEnt("shore_crash_speed_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = 100;
  var_3 = 80;
  var_4 = undefined;

  for(;;) {
    var_0 waittill("trigger");
    var_5 = distance2d(level.player.origin, var_1.origin);

    while(level.player istouching(var_0)) {
      var_6 = distance2d(level.player.origin, var_1.origin);

      if(!isDefined(var_4) && var_6 < 500) {
        var_4 = 1;
        level.player scripts\engine\utility::allow_sprint(0);
      }

      if(var_6 < var_5) {
        var_2 = var_2 - 3;

        if(var_2 < var_3) {
          var_2 = var_3;
        }

        level.player scripts\sp\utility::_id_D2CD(var_2, 0.05);
      }

      var_5 = var_6;
      wait 0.15;
    }

    level.player thread scripts\sp\utility::_id_D2CD(100, 0.5);
  }
}

_id_481F() {
  var_0 = getEnt("lake_crash_tree", "targetname");
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  var_0 rotateTo(var_1.angles, 3, 2, 1);
  var_0 moveTo(var_1.origin, 3, 2, 1);
  wait 3;
  earthquake(0.3, 0.35, var_0.origin, 1000);
}

_id_480A(var_0) {
  scripts\engine\utility::delaythread(1, ::_id_A7A9);
  var_1 = scripts\sp\math::_id_C097(4000, 6000, distance(var_0, level.player.origin));
  var_1 = 1 - var_1;
  var_2 = 7;
  scripts\sp\utility::_id_F2E1(var_2 * var_1, 0.1);
  scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_F2E1, 0, 1);
}

_id_8770() {
  wait 2;
  level.allies["salter"] scripts\sp\utility::_id_51E1("frantic");
  level.allies["admiral"] scripts\sp\utility::_id_51E1("frantic");
  level waittill("lake_crash_watersheeting");
  level.allies["salter"] scripts\sp\utility::_id_51E1("combat");
  level.allies["admiral"] scripts\sp\utility::_id_51E1("combat");
}

_id_A7AB() {
  level.player playRumbleOnEntity("damage_heavy");
  wait 4;
  level.player _meth_8244("damage_heavy");
  wait 3;
  level.player stoprumble("damage_heavy");
  level.player _meth_8244("steady_rumble");
  wait 2;
  level.player stoprumble("steady_rumble");
  wait 1;
  level.player _meth_8244("damage_heavy");
  wait 1.5;
  level.player stoprumble("damage_heavy");
  level.player _meth_8244("steady_rumble");
  wait 2.5;
  level.player stoprumble("steady_rumble");
  wait 1.2;
  level.player playRumbleOnEntity("damage_heavy");
}

_id_FD3B() {
  setmusicstate("mx_085_ship_crash_intro");
  wait 37.2;
  setmusicstate("mx_086_square_fight");
}

_id_FC34() {
  wait 5;
  playworldsound("scn_phstreets_shipwater_boat_crash", (56000, 33680, -34668));
}

_id_D6C3() {
  playFXOnTag(level._effect["vfx_ph_veh_yacht_waterdripping_a"], self, "tag_fx_wateremission_a");
  playFXOnTag(level._effect["vfx_ph_veh_yacht_waterdripping_c"], self, "tag_fx_wateremission_c");
  playFXOnTag(level._effect["vfx_ph_veh_yacht_waterdripping_d"], self, "tag_fx_wateremission_d");
}

_id_A7AF() {
  level endon("lake_ship_crash_complete");

  for(;;) {
    self waittillmatch("single anim", "aatis_fire");
    earthquake(randomfloatrange(0.17, 0.23), 0.5, self.origin, 99999);
    level.player playRumbleOnEntity("artillery_rumble");
  }
}

_id_A7B2() {
  level endon("lake_ship_crash_slide_stop");
  level waittill("lake_ship_crash_slide_start");
  var_0 = 170;
  var_1 = 784;
  var_2 = 48;
  earthquake(0.35, 0.5, self.origin, 9999);
  wait 0.25;

  for(;;) {
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoup(self.angles) * -1;
    var_5 = self.origin + var_3 * var_1;
    var_5 = var_5 + var_4 * var_2;
    var_5 = scripts\sp\utility::_id_864C(var_5);
    earthquake(0.15, 0.05, self.origin, 9999);
    wait 0.05;
  }
}

_id_A7B0() {
  self _meth_8244("tank_rumble");
  level waittill("lake_ship_crash_slide_start");
  self stoprumble("tank_rumble");
  self delete();
}

_id_A7B3() {
  level waittill("lake_crash_watersheeting");
  var_0 = getEnt("lake_crash_watersheeting_trig", "targetname");

  if(!level.player istouching(var_0)) {
    return;
  }
  level.player scripts\sp\utility::_id_D090("ges_ph_block");
  wait 0.75;
  level.player setwatersheeting(1, 3);
}

_id_A7A9() {
  var_0 = getEntArray("lake_crash_movers", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\utility::_id_7A96();
    var_2.origin = var_3.origin;
    var_2._id_4C09 = var_3;
  }

  foreach(var_6 in level._id_A7AD["street_destroyed"]) {
    var_6 scripts\sp\utility::_id_100D7();
  }

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_100D7();
    var_3 = scripts\engine\utility::getStruct(var_2._id_4C09.target, "targetname");
    var_2 scripts\engine\utility::delaycall(randomfloatrange(0, 0.25), ::moveto, var_3.origin, 2, 0, 0.5);
  }

  foreach(var_6 in level._id_A7AD["street_prestine"]) {
    var_6 delete();
  }
}

_id_A7AC() {
  var_0 = getEnt("lake_enemy_mg_dropship_mg", "targetname");
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  _id_0BBD::_id_5DB9("right");
  self notsolid();
  var_0 linkTo(self);
  var_0 setmode("manual");
  var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
  var_3 linkTo(self);
  var_4 = var_1 scripts\sp\utility::_id_10619(1);
  var_4 linkTo(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3 thread scripts\sp\anim::_id_1ECC(var_4, "turret_aim_idle");
  var_4 scripts\sp\utility::_id_F2A8(1);
  var_4 setCanDamage(1);
  var_0 setturretteam("axis");
  var_0 setmode("auto_nonai");
  var_0 setbottomarc(90);
  var_0 thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_035A();

  if(isDefined(var_4) && isalive(var_4)) {
    var_4 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
    scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "dropship_lake_fly_away");
    scripts\sp\utility::_id_57D6();

    if(isDefined(var_4)) {
      var_4 scripts\sp\utility::_id_54C6();
    }
  }

  var_0 notify("stop_fire");
  scripts\engine\utility::flag_set("dropship_lake_fly_away");
  var_3 delete();
  var_0 setmode("manual");
}

_id_3951() {
  scripts\engine\utility::flag_set("cap_crash_lake_complete");
  var_0 = getEntArray("lakeside_ship_prefab", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

_id_10B15() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_square");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  scripts\engine\utility::flag_set("setup_dead_square_actors");
  thread _id_10B03();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF24("streets_scriptable_cars");
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_square", var_0);
}

_id_10B0D() {
  thread _id_10B16();
  thread _id_10B14();
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("g");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("b");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("y");
  thread _id_10B08();
  thread _id_6765();
  thread _id_10B09();
  thread _id_10B1A();
  thread _id_10B0B();
  thread square_transient_slowload_wait();
  scripts\engine\utility::flag_wait("square_complete");
  scripts\sp\utility::_id_229F(getaiarray("axis"));
  thread _id_10B01();
}

_id_10B0B() {
  level endon("ethan_rocket_prep");
  thread _id_10B0C();
  scripts\engine\utility::flag_wait("square_street_near_van");
  scripts\sp\utility::_id_10FEC("periph_aa_fire");
  wait 8;
  scripts\engine\utility::flag_set("ethan_rocket_prep");
}

_id_10B0C() {
  level endon("ethan_rocket_prep");
  scripts\engine\utility::flag_wait("cap_crash_lake_complete");

  while(scripts\sp\utility::_id_77DD("square_intro_guys_upper") > 1) {
    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_15F5("square_street_allies_moveup");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("ethan_rocket_prep");
}

_id_10B02() {
  var_0 = getEnt("square_cqb_allies", "targetname");

  while(!scripts\engine\utility::flag("square_complete")) {
    foreach(var_2 in level.allies) {
      if(var_2 istouching(var_0)) {
        var_2 scripts\sp\utility::_id_61E7();
      }
    }

    wait 1;
  }

  foreach(var_2 in level.allies) {
    var_2 scripts\sp\utility::_id_5514();
  }
}

_id_10B0E() {
  self endon("death");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_103BE();
  var_0 = getEnt("second_story_delete", "targetname");
  scripts\engine\utility::flag_wait("upper_guys_delete");
  scripts\engine\utility::waitframe();
  self _meth_82F1(var_0);
  thread _id_5180();
}

_id_10B17() {
  self endon("death");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_103BE();
  var_0 = getEnt("third_story_delete", "targetname");
  scripts\engine\utility::flag_wait("upper_guys_delete");
  scripts\engine\utility::waitframe();
  self _meth_82F1(var_0);
  thread _id_5180();
}

_id_10B08() {
  level._id_10B07 = 0;
  var_0 = getEntArray("square_combat_spawners", "script_noteworthy");
  var_1 = getEntArray("square_colors", "targetname");
  var_2 = getEnt("square_final_color", "targetname");
  thread _id_6756(var_2);

  foreach(var_4 in var_0) {
    if(!isspawner(var_4)) {
      continue;
    }
    var_4 scripts\sp\utility::_id_1747(::_id_10B05);
  }

  while(level._id_10B07 < 6) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("first_fallback_cqb_combat");

  while(level._id_10B07 < 10) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("fallback_into_cqb_room");

  while(level._id_10B07 < 11) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("fallback_out_of_cqb_room");
  var_6 = getaiarray("axis");

  while(var_6.size > 0) {
    var_6 = scripts\sp\utility::array_removedeadvehicles(var_6);
    wait 0.05;
  }

  foreach(var_8 in var_1) {
    if(isDefined(var_8)) {
      var_8 scripts\engine\utility::trigger_off();
    }
  }

  var_2 scripts\sp\utility::_id_15F1();
}

_id_10B03() {
  scripts\engine\utility::flag_wait("setup_dead_square_actors");
  var_0 = getspawnerarray("square_dead_ally_spawner");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = scripts\sp\utility::_id_2C17(var_3);
    var_1[var_1.size] = var_4;

    if(isDefined(var_3.script_parameters) && var_3.script_parameters == "friendlyfire") {
      var_4 thread _id_0B0F::_id_19FC(1, 1);
    } else {
      var_4 notsolid();
    }

    if(var_4.weapon != "none") {
      var_4 scripts\sp\utility::_id_86E4();
    }

    if(isDefined(var_4.animation)) {
      var_4._id_1FBB = "civilian";
      var_3 thread scripts\sp\anim::_id_1EEA(var_4, var_4.animation, "stop_anim");
      continue;
    }

    var_4 startragdoll();
  }

  scripts\engine\utility::flag_wait("start_dust_area");

  foreach(var_7 in var_1) {
    var_7 delete();
  }
}

_id_6756(var_0) {
  scripts\engine\utility::flag_wait("square_complete");
  setmusicstate("");
  wait 1;
  level.player scripts\sp\utility::_id_10350("phstreets_plr_itsadeadendetha");

  if(!scripts\engine\utility::flag("eth3n_boost_jump")) {
    level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_icangetusoverth");
  }
}

_id_EA48() {
  if(scripts\engine\utility::flag("square_complete")) {
    return;
  }
  level endon("square_complete");
  var_0 = 16384;
  var_1 = getnode("start_cap_crash_dust_eth3n", "targetname");

  while(distance2dsquared(level.allies["salter"].origin, var_1.origin) > var_0) {
    wait 0.25;
  }

  var_0 = 176400;

  while(distance2dsquared(level.allies["salter"].origin, level.player.origin) < var_0) {
    wait 0.25;
  }

  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_catchupreyesweneedto");
}

_id_10B05() {
  _id_10B06();
  level._id_10B07 = level._id_10B07 + 1;
}

_id_10B06() {
  self endon("death");
  self waittill("forever");
}

_id_10B1A() {
  scripts\engine\utility::flag_wait("fallback_out_of_cqb_room");
  var_0 = getEnt("combat_square_upstairs_volume", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3("axis");

  foreach(var_3 in var_1) {
    var_3 delete();
  }
}

_id_10B0A() {
  wait 0.75;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F293("square_intro_guys", "square_main_front");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F293("square_intro_guys_upper", "square_main_front");
}

_id_10B14() {
  scripts\engine\utility::trigger_off("spawn_stair_guy_trigger", "targetname");
}

_id_6765() {
  thread _id_3F9D();
  var_0 = scripts\engine\utility::getStruct("eth3n_take_cover", "targetname");
  var_1 = scripts\engine\utility::getStruct("eth3n_take_cover_civ", "targetname");
  scripts\engine\utility::flag_wait("ethan_rocket_prep");
  thread _id_10B0A();
  thread _id_E5CF();
  scripts\sp\utility::_id_15F5("square_building_spawns");
  scripts\engine\utility::flag_wait("ethan_animation_trigger");
  thread _id_C61D();
  thread _id_2818();
  scripts\sp\utility::_id_15F5("square_building_exploder");
  thread _id_D6E6();
}

_id_3F9D() {
  var_0 = getEnt("eth3n_civ_3", "targetname");
  var_1 = scripts\engine\utility::getStruct("eth3n_take_cover", "targetname");
  scripts\sp\utility::_id_127B3("turn_on_square_civs");
  var_2 = var_0 scripts\sp\utility::_id_10619(1);
  scripts\engine\utility::waitframe();
  var_2 thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_CA95(0.5, 0.5);
}

_id_C61D() {
  level._id_10B0F = getEnt("square_shutter_01", "targetname");
  level._id_10B10 = getEnt("square_shutter_02", "targetname");
  level._id_10B11 = getEnt("square_shutter_03", "targetname");
  level._id_10B12 = getEnt("square_shutter_04", "targetname");
  level._id_10B13 = getEnt("square_shutter_05", "targetname");
  wait(randomfloatrange(0.5, 1));
  level._id_10B0F thread _id_10192();
  wait 1.2;
  scripts\engine\utility::flag_wait("trigger_3rd_floor_windows");
  thread _id_10B18();
  thread _id_10B19();
}

_id_10B18() {
  level endon("upper_guys_delete");
  var_0 = getEnt("sq_right_flank_room", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      if(scripts\sp\utility::_id_13D92(level._id_10B13.origin, 0.3)) {
        scripts\sp\utility::_id_15F5("square_building_3rd_floor2");
        level._id_10B13 thread _id_10192();
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_10B19() {
  level endon("upper_guys_delete");
  scripts\engine\utility::flag_wait("trigger_3rd_floor_windows");
  scripts\sp\utility::_id_15F5("square_building_3rd_floor1");
  level._id_10B12 thread _id_10192();
}

_id_10192() {
  var_0 = getEnt(self.target, "targetname");
  self rotateby((0, 130, 0), 0.2);
  var_0 rotateby((0, -130, 0), 0.2);
  self waittill("movedone");
}

_id_6F63() {
  while(scripts\sp\utility::_id_77DB("2nd_story_guys") >= 3) {
    wait 0.2;
  }

  wait 2.0;
  var_0 = scripts\sp\utility::_id_77DA("2nd_story_guys");
  var_1 = getEnt("second_story_delete", "targetname");

  foreach(var_3 in var_0) {
    var_3 _meth_82F1(var_1);
  }
}

_id_5180() {
  self endon("death");
  self waittill("goal");
  self delete();
}

_id_2818() {
  var_0 = getEntArray("square_bar_fan", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_speed != 0) {
      var_2 rotatevelocity((0, var_2.script_speed * -1, 0), 9999);
    }
  }
}

_id_675C() {
  var_0 = getEnt("eth3n_civ", "targetname");
  level._id_674D = var_0 _meth_8393();
  level._id_674D.ignoreall = 1;
  level._id_674D.ignoreme = 1;
  level._id_674D._id_1FBB = "generic";
  level._id_674D scripts\sp\utility::_id_B14F(1);
  var_1 = scripts\engine\utility::getStruct("eth3n_take_cover_civ", "targetname");
  var_1 scripts\sp\anim::_id_1EC3(level._id_674D, "take_cover");
  scripts\engine\utility::flag_wait("start_dust_area");
  level._id_674D delete();
}

_id_678F() {
  var_0 = getEnt("eth3n_civ_2", "targetname");
  level._id_674B = var_0 scripts\sp\utility::_id_10619();
  level._id_674B.ignoreall = 1;
  level._id_674B.ignoreme = 1;
  level._id_674B scripts\sp\utility::_id_B14F(1);
  var_1 = getEnt("eth3n_civ_3", "targetname");
  level._id_674C = var_1 scripts\sp\utility::_id_10619();
  level._id_674C.ignoreall = 1;
  level._id_674C.ignoreme = 1;
  level._id_674C scripts\sp\utility::_id_B14F(1);
  scripts\engine\utility::flag_wait("start_dust_area");
  level._id_674B delete();
  level._id_674C delete();
}

_id_6799() {
  scripts\sp\utility::_id_127B3("teleport_ethan");
  self notify("teleport");
}

_id_678E() {
  self endon("teleport");
  var_0 = scripts\engine\utility::getStruct("ethan_wall_climb_anim", "targetname");
  scripts\engine\utility::delaythread(4.5, scripts\engine\utility::flag_set, "ledge_guys_fallback");
  var_0 scripts\sp\anim::_id_1F17(level.allies["eth3n"], "rocket_wall_climb");
  scripts\engine\utility::delaythread(0.4, scripts\engine\utility::exploder, "eth3ndust");
  var_0 scripts\sp\anim::_id_1F35(level.allies["eth3n"], "rocket_wall_climb");
  var_1 = scripts\engine\utility::getStruct("eth3n_take_cover", "targetname");
  var_1 scripts\sp\anim::_id_1F17(level.allies["eth3n"], "take_cover");
  var_1 scripts\sp\anim::_id_1EC3(level.allies["eth3n"], "take_cover");
}

_id_E5CF() {
  wait 5;
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_thisway");
  wait 1;
}

_id_D6E6() {
  wait 2;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_targetssecondfl");
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_tryandflankem");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_wellcoveryou");

  while(getaiarray("axis").size > 1) {
    wait 0.1;
  }

  if(!scripts\engine\utility::flag("square_complete")) {
    level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_nothreats");
  }

  wait 1;

  if(!scripts\engine\utility::flag("player_entering_square_store") && !scripts\engine\utility::flag("square_complete")) {
    level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_optimalrouteist");
  } else if(!scripts\engine\utility::flag("square_complete")) {
    level.player scripts\sp\utility::_id_10350("phstreets_plr_throughhere");
  }

  thread _id_EA48();
}

_id_10B09() {
  var_0 = scripts\engine\utility::getStruct("table_kick", "targetname");
  level._id_6F36 = getEnt("table_flip_table", "targetname");
  level._id_6F36._id_1FBB = "table_flip_moment";
  level._id_6F36 scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1EC3(level._id_6F36, "table_flip");
  scripts\engine\utility::flag_wait("square_flank_spawn");
  var_1 = getEnt("flank_spawn_table_flipper", "targetname");
  var_2 = var_1 scripts\sp\utility::_id_10619();

  if(scripts\sp\utility::_id_106ED(var_2)) {
    return;
  }
  var_2 scripts\sp\utility::_id_B14F();
  var_2 scripts\sp\utility::_id_5564();
  var_2._id_1FBB = "generic";
  var_2.fixednode = 1;
  var_2.goalradius = 32;
  wait 0.05;
  var_0 scripts\sp\anim::_id_1F17(var_2, "table_flip");
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "table_flip");
  wait 0.1;
  var_0 thread scripts\sp\anim::_id_1F35(level._id_6F36, "table_flip");
  var_3 = getEnt("square_table_clip", "targetname");
  var_3 connectpaths();
  var_3 delete();
  var_3 = getEnt("square_table_flip_clip", "targetname");
  var_3 scripts\sp\utility::_id_100D7();
  var_3 disconnectPaths();
  var_2 scripts\sp\utility::_id_1101B();
  var_2 scripts\sp\utility::_id_6224();
  var_2 setCanDamage(1);
  var_2 scripts\sp\utility::_id_F2A8(1);
  var_4 = getnode("table_flip_cover", "targetname");
  var_2 _meth_82EE(var_4);
}

_id_3FCB() {
  wait 0.15;
  var_0 = getEnt("sfx_amb_civi_screams_01", "targetname");
  var_0 thread _id_3FBF("sfx_amb_civi_screams_01", "civi_screams_street_amb", (55037, 29685, -34448), "");
  var_1 = getEnt("sfx_amb_civi_screams_02", "targetname");
  var_1 thread _id_3FBF("sfx_amb_civi_screams_02", "civi_screams_street_amb", (57524, 29668, -34287), "med_battle");
  var_2 = getEnt("sfx_amb_civi_screams_03", "targetname");
  var_2 thread _id_3FBF("sfx_amb_civi_screams_03", "civi_screams_street_amb", (55475, 31978, -34475), "med_battle");
  var_3 = getEnt("sfx_amb_civi_screams_04", "targetname");
  var_3 thread _id_3FBF("sfx_amb_civi_screams_04", "civi_screams_street_amb", (57424, 33227, -34438), "med_battle");
  var_4 = getEnt("sfx_amb_civi_screams_05", "targetname");
  var_4 thread _id_3FBF("sfx_amb_civi_screams_05", "civi_screams_street_amb", (58649, 32413, -34074), "med_battle");
  var_5 = getEnt("sfx_amb_civi_screams_06", "targetname");
  var_5 thread _id_3FBF("sfx_amb_civi_screams_06", "civi_screams_street_amb", (60586, 32608, -34045), "med_battle");
  var_6 = getEnt("sfx_amb_civi_screams_07", "targetname");
  var_6 thread _id_3FBF("sfx_amb_civi_screams_07", "civi_screams_street_amb", (61998, 33565, -34120), "med_battle");
  var_7 = getEnt("sfx_amb_civi_screams_09", "targetname");
  var_7 thread _id_3FBF("sfx_amb_civi_screams_09", "civi_screams_street_amb", (64546, 38318, -34044), "med_battle");
  var_8 = getEnt("sfx_amb_civi_screams_10", "targetname");
  var_8 thread _id_3FBF("sfx_amb_civi_screams_10", "civi_screams_street_amb", (66882, 39413, -34167), "med_battle");
  var_9 = getEnt("sfx_amb_civi_screams_11", "targetname");
  var_9 thread _id_3FBF("sfx_amb_civi_screams_11", "civi_screams_street_amb", (69106, 40282, -34293), "med_battle");
}

_id_3FBF(var_0, var_1, var_2, var_3) {
  level endon("hill_player_in_basement");

  for(;;) {
    self waittill("trigger");
    thread scripts\sp\maps\phstreets\phstreets::_id_F51C(var_3, 5);

    while(level.player istouching(self)) {
      wait(randomfloatrange(1.0, 4.0));
      thread scripts\engine\utility::play_sound_in_space(var_1, var_2);
      wait(randomfloatrange(1.0, 4.0));
    }
  }
}

_id_10B16() {
  var_0 = getEnt("streets_square_combat_sun_trig", "targetname");
  var_0 waittill("trigger");
  setsundirection(anglesToForward((-42, -60, 0)));
  var_0 = getEnt("streets_ethan_boost_sun_trig", "targetname");
  var_0 waittill("trigger");
  setsundirection(anglesToForward((-28, 16, 0)));
  scripts\engine\utility::flag_wait("start_dust_area");
  resetsundirection();
}

square_transient_slowload_wait() {
  if(level.console) {
    return;
  }
  scripts\engine\utility::flag_wait("fallback_out_of_cqb_room");
  waitforalltransients();
}

_id_10B00() {
  scripts\sp\utility::_id_10FEC("periph_aa_fire");
  thread _id_10B01();
  scripts\engine\utility::flag_set("ledge_guys_fallback");
}

_id_10B01() {
  scripts\engine\utility::flag_wait("start_dust_area");
  clearallcorpses();
  level._id_10B0F = getEnt("square_shutter_01", "targetname");
  level._id_10B10 = getEnt("square_shutter_02", "targetname");
  level._id_10B11 = getEnt("square_shutter_03", "targetname");
  level._id_10B12 = getEnt("square_shutter_04", "targetname");
  level._id_10B13 = getEnt("square_shutter_05", "targetname");
  var_0 = getEnt(level._id_10B0F.target, "targetname");
  var_1 = getEnt(level._id_10B10.target, "targetname");
  var_2 = getEnt(level._id_10B11.target, "targetname");
  var_3 = getEnt(level._id_10B12.target, "targetname");
  var_4 = getEnt(level._id_10B13.target, "targetname");
  var_5 = getEnt("table_flip_table", "targetname");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_2);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_3);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_4);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(level._id_10B0F);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(level._id_10B10);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(level._id_10B11);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(level._id_10B12);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(level._id_10B13);
  level._id_10B0F = undefined;
  level._id_10B10 = undefined;
  level._id_10B11 = undefined;
  level._id_10B12 = undefined;
  level._id_10B13 = undefined;
  var_6 = getEnt("square_table_clip", "targetname");

  if(isDefined(var_6)) {
    var_6 delete();
  }

  var_6 = getEnt("square_table_flip_clip", "targetname");

  if(isDefined(var_6)) {
    var_6 delete();
  }

  var_7 = getEntArray("square_bar_fan", "targetname");

  foreach(var_9 in var_7) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_9);
  }

  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_5);
  thread _id_1112D();
}

_id_1112D() {
  wait 0.05;
  level notify("street_crate_cleanup");
  _id_0B0F::_id_40C5("harbor_vista_airbattle");
  _id_0B0F::_id_40C5("combat_3_ambient_battle");

  if(isDefined(level._id_4820)) {
    level._id_4820 delete();
  }

  level._id_4820 = undefined;
  level._id_13853 = undefined;
  level._id_5014 = undefined;
  level._id_B2BA = undefined;

  if(isDefined(level._id_8590)) {
    foreach(var_1 in level._id_8590) {
      scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_1);
    }
  }

  level._id_8590 = undefined;
  level._id_85AB = undefined;
  level._id_858D = undefined;
  thread _id_0B0F::_id_40C5("harbor_vista_dropships");
  thread _id_0B0F::_id_40C5("ship_crash_ambient_battle");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(getEntArray("streets_lake_movers", "targetname"));
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF26("streets_scriptable_cars");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_150F("lake_vista_aatis_guns");
  scripts\sp\utility::_id_10FEC("ganeva_fountain");
  killmayhem("lake_crash_capship_mayhem");

  if(isDefined(level._id_8B26)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(level._id_8B26);
    level._id_8B26 = undefined;
  }

  if(isDefined(level._id_A7AD["yacht"])) {
    level._id_A7AD["yacht"] delete();
  }

  var_3 = getEnt("lakecrash_yacht_clip", "targetname");

  if(isDefined(var_3)) {
    var_3 delete();
  }

  if(isDefined(level._id_A7AD["street_prestine"])) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(level._id_A7AD["street_prestine"]);
  }

  if(isDefined(level._id_A7AD["street_destroyed"])) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(level._id_A7AD["street_destroyed"]);
  }

  if(isDefined(level._id_A7AD["movers"])) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(level._id_A7AD["movers"]);
  }

  if(isDefined(level._id_A7AD["aatis"])) {
    level._id_A7AD["aatis"] delete();
  }

  level._id_A7AD = undefined;
}