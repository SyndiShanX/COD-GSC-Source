/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_embassy\cp_so_embassy_alley.gsc
*****************************************************************/

function alley_start() {
  scripts\engine\utility::flag_wait("fade_in");
  var_0 = scripts\engine\utility::getStruct("alley_push_1", "targetname").origin;
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(16), var_0);

  foreach(var_3 in var_1) {
    if(var_3.origin == (-2177.8, -850.952, 56)) {
      var_4 = scripts\cp\cp_weapon::buildweapon("iw8_sh_romeo870_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      var_3 thread scripts\anim\shared::forceuseweapon(var_4, "primary");
    }
  }

  thread brmoderemovefromteamlives();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::his_playerdisconnect();
  scripts\engine\utility::flag_clear("spawning_in_progress");
  thread first_convoy();
}

function brmoderemovefromteamlives() {
  var_0 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1("enemy_cp_alq_desert_lmg", (-2009.28, -486.884, 60), (0, 270, 0), 1, 1);
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_0 endon("death");
  var_0.goalradius = 50;
  var_0 allowedstances("prone");
  waitframe();
  var_0.baseaccuracy = 0.1;
  var_0.ignoresuppression = 1;
  var_0 linkTo(var_1);
  scripts\engine\utility::flag_wait("res_push");
  var_0 allowedstances("prone", "crouch", "stand");
  var_0 unlink();
  var_0.goalradius = 1000;
}

function brloadoutcratepostcapture() {
  var_0 = getdvarint("so_embassy_start", 0);

  if(var_0 <= 2) {
    var_1 = getEnt("ally_heli", "targetname");
    var_2 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134f0("ally_spawners_heli_ground");
    level.infil_heli = var_1 scripts\common\vehicle::spawn_vehicle_and_gopath();
    level.infil_heli thread scripts\cp\maps\cp_so_embassy\cp_so_embassy::givequestrewardgroup();
    thread steve();
    thread steam_trigger();
    return;
  }
}

function steam_trigger() {
  wait 4;
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_12758("dx_vom_uscc_heli_approach_infil_10");
  level.infil_heli waittill("unloaded");
  wait 1;
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_12758("dx_vom_uscc_heli_approach_infil_20");
  wait 1;
  var_0 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
  var_0 playSound("dx_vom_us2_convoy_ambush_attack_10");
}

function steve() {
  var_0 = scripts\engine\utility::getStruct("ally_spawners_heli_path_01", "targetname");
  self.target = undefined;
  self settargetyaw(var_0.angles[1]);
  self vehicle_teleport(var_0.origin, var_0.angles);
  self setvehgoalpos(var_0.origin, 1);
  self vehicle_setspeedimmediate(0);
  self sethoverparams(300, 20, 10);
  thread scripts\common\vehicle::vehicle_unload("default");
  thread scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
  self waittill("unloaded");
  var_1 = scripts\engine\utility::getStruct("ally_spawners_heli_path_02", "targetname");
  self vehicle_setspeed(20, 20, 20);
  thread scripts\common\vehicle::vehicle_paths(var_1);
  scripts\common\vehicle_paths::gopath(self);
  self waittill("goal");

  foreach(var_3 in self.riders) {
    var_3 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
  }

  self delete();
}

function ref_11a6e() {
  self.attackeraccuracy = 0.1;
  self.health = 1000;

  for(;;) {
    self waittill("damage", var_0, var_1);
    self.health += var_0;
  }
}

function bridge_two_death_func(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");

  if(!isDefined(var_3) || !isDefined(level.allies) || level.allies.size < 1) {
    return;
  }

  var_4 = scripts\engine\utility::array_removedead_or_dying(level.allies);

  foreach(var_6 in var_4) {
    if(!isalive(var_6)) {
      return;
    }

    var_6 setgoalvolumeauto(var_3);

    if(istrue(var_1)) {
      wait randomfloatrange(0.5, 2.5);
    }
  }
}

function first_convoy() {
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::brenableagents(-3800, "x", "alley_push_01");
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::brenableagents(-2700, "x", "alley_push_02");
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::brenableagents(-2200, "x", "alley_push_03");
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::brenableagents(-1000, "x", "alley_push_04");

  while(getaiarray("axis").size > 10 + level.players.size) {
    wait 0.1;
  }

  wait 8;
  ref_135b1();
  thread ref_12389();

  while(getaiarray("axis").size > 10) {
    wait 0.1;
  }

  scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::createhudelem((-1951.59, -489.52, 58.0407));
  thread createhudstring();
  wait 1;

  while(getaiarray("axis").size > 5) {
    wait 0.1;
  }

  thread ref_13525("enemy_cp_alq_desert_ar", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(16));
  wait 5;

  while(getaiarray("axis").size > 10) {
    wait 0.1;
  }

  thread ref_13d1e();

  while(getaiarray("axis").size > 4) {
    wait 0.1;
  }

  level notify("kill_complex_bombers");

  while(getaiarray("axis").size > 0) {
    wait 0.1;
  }

  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::ally_vo();
  wait 2;
  scripts\engine\utility::flag_clear("spawning_in_progress");
  thread hit_by_emp_internal();
}

function ref_13525(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = [];
  GscBinSkip0(0x2e, var_4.size, [(-277.042, 453.234, 152), (0, 270, 0)]);
}

function ref_12389() {
  badplace_cylinder("right_roof_badplace", -1, (-70.6799, -862.777, 150), 415, 100, "axis");
  scripts\engine\utility::flag_wait("res_push");
  badplace_delete("right_roof_badplace");
}

function ref_13d1e() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [(249.8, -325.5, 4), (0, 270, 0)]);
}

function gasfxground() {
  self endon("death");
  self waittill("damage");
  self.goalradius = 200;
}

function ref_11a77(var_0) {
  foreach(var_2 in var_0) {
    if(distance2d(var_2.origin, (-307.915, 463.628, 148)) <= 400) {
      var_2.og_fov = 1;
    }
  }
}

function createhudstring() {
  level endon("kill_complex_bombers");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, (203.162, -1024.91, 56));
}

function ref_135b1() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [(-1380.93, -979.18, 18.0409), (0, 270, 0)]);
}

function create_oscilloscope_screen() {
  self endon("death");

  while(isalive(self)) {
    wait 0.1;
  }
}

function hit_by_emp_internal() {
  level.ref_13bd3 = 6000;
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1238d((69.25, 399, 62), 50, 150, "axis");
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1238d((2311.76, 1671.9, 54.1039), 50, 150, "axis", "allies");
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1238d((-166.454, 139.447, 46.5), 50, 150, "axis", "allies");
  scripts\engine\utility::flag_set("illumination_flare_enabled");
  thread brloadoutcratefirstactivation();
  thread ref_12ab9();
  thread ref_12bef();
  scripts\engine\utility::flag_set("compound_cleared");
  scripts\engine\utility::flag_set("alley_push_04");
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::hitbytrain();
  level.hitslocs = 0;
  var_0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var_1 = var_0 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_11a9a(&"CP_SO_EMBASSY/SERVER_PROMPT");
  var_1 waittill("trigger", var_2);
  var_1 delete();

  foreach(var_4 in getaiarray("allies")) {
    var_4.health = 150;
  }

  setthreatbias("allies", "axis", 10000);
  var_6 = getEnt("computer_on", "targetname");
  var_7 = getEnt("computer_off", "targetname");
  var_7 hide();
  var_6 show();
  scripts\engine\utility::flag_set("transfer_started");
  scripts\engine\utility::flag_clear("transfer_paused");
  scripts\engine\utility::flag_clear("spawning_in_progress");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::justbecamehvt();
}

function ref_12bef() {
  var_0 = getnodesinradius((-676.247, 477.233, 167), 30, 0, 50);

  foreach(var_2 in var_0) {
    var_2 disconnectnode();
  }

  var_0 = getnodesinradius((-686.203, 437.787, 167), 30, 0, 50);

  foreach(var_2 in var_0) {
    var_2 disconnectnode();
  }
}

function brloadoutcratefirstactivation() {
  wait 1;
  var_0 = getaiarray("allies");
  var_0 = sortbydistance(var_0, (20.056, 205.038, 168));

  if(isDefined(var_0[0])) {
    var_1 = var_0[0];
    var_1 cleargoalvolume();
    var_1 setgoalpos((20.056, 205.038, 168));
    var_1.goalradius = 40;
  }

  if(isDefined(var_0[1])) {
    var_1 = var_0[1];
    var_1 cleargoalvolume();
    var_1 setgoalpos((-53.038, 688.056, 168));
    var_1.goalradius = 50;
    var_1.goalheight = 20;
    return;
  }
}

function ref_12ab9() {
  scripts\engine\utility::delaythread(5, &scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_beta, "sentry", 1, 1);

  if(level.players.size > 1) {
    scripts\engine\utility::delaythread(5, &scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_beta, "precision_airstrike", 1, 7);
  }

  if(level.players.size > 3) {
    scripts\engine\utility::delaythread(5, &scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_beta, "cluster_strike", 1, 7);
  }

  var_0 = getaiarray("allies");

  if(var_0.size < 3) {
    var_1 = getEnt("ally_heli", "targetname");
    var_2 = var_1 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var_2.ignoreme = 1;
    waitframe();
    var_3 = spawnStruct();
    var_3.origin = (-150.89, -56.1799, 567);
    var_3.angles = (0, 75.6521, 0);
    level.ref_12aba = var_2;
    scripts\engine\utility::array_thread(var_2.riders, &ref_12ab8);
    var_2 thread scripts\cp\maps\cp_so_embassy\cp_so_embassy::givequestrewardgroup();
    var_4 = var_2.riders;
    var_2 settargetyaw(var_3.angles[1]);
    var_2 vehicle_teleport(var_1.origin + (-2000, 1000, 1000), var_3.angles);
    var_2 setvehgoalpos(var_1.origin + (-2000, 1000, 1000), 0);
    var_2 vehicle_setspeedimmediate(40);
    var_2 setneargoalnotifydist(1000);
    var_2 waittill("near_goal");
    var_2 setvehgoalpos(var_3.origin, 1);
    var_2 vehicle_setspeedimmediate(40);
    var_2 waittill("near_goal");
    var_2 thread scripts\common\vehicle::vehicle_unload("default");
    var_2 waittill("unloaded");
    var_2 vehicle_setspeedimmediate(40);
    var_2 setvehgoalpos(var_3.origin + (0, 0, 800), 1);
    wait 5;

    foreach(var_6 in var_2.riders) {
      var_6 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
    }

    var_2 waittill("goal");
    var_2 delete();
    return;
  }
}

function ref_12ab8() {
  self endon("death");
  var_0 = getEnt("defend_vol", "targetname");
  self.ignoreme = 1;
  self.target = undefined;
  self notify("stop_going_to_node");
  self clearpath();
  self setgoalpos((-108.179, -141.79, 32));
  self setgoalvolumeauto(var_0);
  level.ref_12aba scripts\engine\utility::ref_143b9(30, "unloaded");
  self.ignoreme = 0;
}

function ref_119e5() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("ammo_crate_spawn_struct", "targetname");
  var_1 = sortbydistance(var_1, (-410.812, 520.18, 60));
  var_1[1].angles = (0, 0, 0);

  foreach(var_3 in var_1) {
    var_4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var_3.origin, var_3.angles);
    var_0 = var_4;
    setheadiconsnaptoedges(var_4.headiconid, 500);
  }

  var_6 = scripts\engine\utility::getStruct("claymore_crate_spawn_struct", "targetname");
  var_0 = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var_6.origin, var_6.angles);
  var_7 = scripts\engine\utility::getStruct("molotov_crate_spawn_struct", "targetname");
  var_0 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(var_7.origin + (0, 0, 5), var_7.angles);
  var_8 = scripts\engine\utility::getStruct("frag_crate_spawn_struct", "targetname");
  var_0 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(var_8.origin, var_8.angles);
  var_0 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime((-152.152, -361.947, 50.3), (0, 48.5995, 0));
  var_0 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled((-211.976, 207.544, 63.5), (358.6, 293.969, -1.32843));
}