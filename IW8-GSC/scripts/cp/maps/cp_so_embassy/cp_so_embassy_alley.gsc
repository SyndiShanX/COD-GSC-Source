/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_embassy\cp_so_embassy_alley.gsc
*****************************************************************/

function alley_start() {
  scripts\engine\utility::flag_wait("fade_in");
  var0 = scripts\engine\utility::getStruct("alley_push_1", "targetname").origin;
  var1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(16), var0);

  foreach(var3 in var1) {
    if(var3.origin == (-2177.8, -850.952, 56)) {
      var4 = scripts\cp\cp_weapon::buildweapon("iw8_sh_romeo870_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      var3 thread scripts\anim\shared::forceuseweapon(var4, "primary");
    }
  }

  thread brmoderemovefromteamlives();
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::his_playerdisconnect();
  scripts\engine\utility::flag_clear("spawning_in_progress");
  thread first_convoy();
}

function brmoderemovefromteamlives() {
  var0 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1("enemy_cp_alq_desert_lmg", (-2009.28, -486.884, 60), (0, 270, 0), 1, 1);
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var0 endon("death");
  var0.goalradius = 50;
  var0 allowedstances("prone");
  waitframe();
  var0.baseaccuracy = 0.1;
  var0.ignoresuppression = 1;
  var0 linkTo(var1);
  scripts\engine\utility::flag_wait("res_push");
  var0 allowedstances("prone", "crouch", "stand");
  var0 unlink();
  var0.goalradius = 1000;
}

function brloadoutcratepostcapture() {
  var0 = getdvarint("so_embassy_start", 0);

  if(var0 <= 2) {
    var1 = getEnt("ally_heli", "targetname");
    var2 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134f0("ally_spawners_heli_ground");
    level.infil_heli = var1 scripts\common\vehicle::spawn_vehicle_and_gopath();
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
  var0 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
  var0 playSound("dx_vom_us2_convoy_ambush_attack_10");
}

function steve() {
  var0 = scripts\engine\utility::getStruct("ally_spawners_heli_path_01", "targetname");
  self.target = undefined;
  self settargetyaw(var0.angles[1]);
  self vehicle_teleport(var0.origin, var0.angles);
  self setvehgoalpos(var0.origin, 1);
  self vehicle_setspeedimmediate(0);
  self sethoverparams(300, 20, 10);
  thread scripts\common\vehicle::vehicle_unload("default");
  thread scripts\common\vehicle::attach_vehicle_and_gopath(var0);
  self waittill("unloaded");
  var1 = scripts\engine\utility::getStruct("ally_spawners_heli_path_02", "targetname");
  self vehicle_setspeed(20, 20, 20);
  thread scripts\common\vehicle::vehicle_paths(var1);
  scripts\common\vehicle_paths::gopath(self);
  self waittill("goal");

  foreach(var3 in self.riders) {
    var3 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
  }

  self delete();
}

function ref_11a6e() {
  self.attackeraccuracy = 0.1;
  self.health = 1000;

  for(;;) {
    self waittill("damage", var0, var1);
    self.health += var0;
  }
}

function bridge_two_death_func(var0, var1, var2) {
  var3 = getEnt(var0, "targetname");

  if(!isDefined(var3) || !isDefined(level.allies) || level.allies.size < 1) {
    return;
  }

  var4 = scripts\engine\utility::array_removedead_or_dying(level.allies);

  foreach(var6 in var4) {
    if(!isalive(var6)) {
      return;
    }

    var6 setgoalvolumeauto(var3);

    if(istrue(var1)) {
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

function ref_13525(var0, var1) {
  var2 = [];
  var3 = 0;
  var4 = [];
  GscBinSkip0(0x2e, var4.size, [(-277.042, 453.234, 152), (0, 270, 0)]);
}

function ref_12389() {
  badplace_cylinder("right_roof_badplace", -1, (-70.6799, -862.777, 150), 415, 100, "axis");
  scripts\engine\utility::flag_wait("res_push");
  badplace_delete("right_roof_badplace");
}

function ref_13d1e() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [(249.8, -325.5, 4), (0, 270, 0)]);
}

function gasfxground() {
  self endon("death");
  self waittill("damage");
  self.goalradius = 200;
}

function ref_11a77(var0) {
  foreach(var2 in var0) {
    if(distance2d(var2.origin, (-307.915, 463.628, 148)) <= 400) {
      var2.og_fov = 1;
    }
  }
}

function createhudstring() {
  level endon("kill_complex_bombers");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, (203.162, -1024.91, 56));
}

function ref_135b1() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [(-1380.93, -979.18, 18.0409), (0, 270, 0)]);
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
  var0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var1 = var0 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_11a9a(&"CP_SO_EMBASSY/SERVER_PROMPT");
  var1 waittill("trigger", var2);
  var1 delete();

  foreach(var4 in getaiarray("allies")) {
    var4.health = 150;
  }

  setthreatbias("allies", "axis", 10000);
  var6 = getEnt("computer_on", "targetname");
  var7 = getEnt("computer_off", "targetname");
  var7 hide();
  var6 show();
  scripts\engine\utility::flag_set("transfer_started");
  scripts\engine\utility::flag_clear("transfer_paused");
  scripts\engine\utility::flag_clear("spawning_in_progress");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend::justbecamehvt();
}

function ref_12bef() {
  var0 = getnodesinradius((-676.247, 477.233, 167), 30, 0, 50);

  foreach(var2 in var0) {
    var2 disconnectnode();
  }

  var0 = getnodesinradius((-686.203, 437.787, 167), 30, 0, 50);

  foreach(var2 in var0) {
    var2 disconnectnode();
  }
}

function brloadoutcratefirstactivation() {
  wait 1;
  var0 = getaiarray("allies");
  var0 = sortbydistance(var0, (20.056, 205.038, 168));

  if(isDefined(var0[0])) {
    var1 = var0[0];
    var1 cleargoalvolume();
    var1 setgoalpos((20.056, 205.038, 168));
    var1.goalradius = 40;
  }

  if(isDefined(var0[1])) {
    var1 = var0[1];
    var1 cleargoalvolume();
    var1 setgoalpos((-53.038, 688.056, 168));
    var1.goalradius = 50;
    var1.goalheight = 20;
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

  var0 = getaiarray("allies");

  if(var0.size < 3) {
    var1 = getEnt("ally_heli", "targetname");
    var2 = var1 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var2.ignoreme = 1;
    waitframe();
    var3 = spawnStruct();
    var3.origin = (-150.89, -56.1799, 567);
    var3.angles = (0, 75.6521, 0);
    level.ref_12aba = var2;
    scripts\engine\utility::array_thread(var2.riders, &ref_12ab8);
    var2 thread scripts\cp\maps\cp_so_embassy\cp_so_embassy::givequestrewardgroup();
    var4 = var2.riders;
    var2 settargetyaw(var3.angles[1]);
    var2 vehicle_teleport(var1.origin + (-2000, 1000, 1000), var3.angles);
    var2 setvehgoalpos(var1.origin + (-2000, 1000, 1000), 0);
    var2 vehicle_setspeedimmediate(40);
    var2 setneargoalnotifydist(1000);
    var2 waittill("near_goal");
    var2 setvehgoalpos(var3.origin, 1);
    var2 vehicle_setspeedimmediate(40);
    var2 waittill("near_goal");
    var2 thread scripts\common\vehicle::vehicle_unload("default");
    var2 waittill("unloaded");
    var2 vehicle_setspeedimmediate(40);
    var2 setvehgoalpos(var3.origin + (0, 0, 800), 1);
    wait 5;

    foreach(var6 in var2.riders) {
      var6 scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
    }

    var2 waittill("goal");
    var2 delete();
    return;
  }
}

function ref_12ab8() {
  self endon("death");
  var0 = getEnt("defend_vol", "targetname");
  self.ignoreme = 1;
  self.target = undefined;
  self notify("stop_going_to_node");
  self clearpath();
  self setgoalpos((-108.179, -141.79, 32));
  self setgoalvolumeauto(var0);
  level.ref_12aba scripts\engine\utility::ref_143b9(30, "unloaded");
  self.ignoreme = 0;
}

function ref_119e5() {
  var0 = [];
  var1 = scripts\engine\utility::getStructArray("ammo_crate_spawn_struct", "targetname");
  var1 = sortbydistance(var1, (-410.812, 520.18, 60));
  var1[1].angles = (0, 0, 0);

  foreach(var3 in var1) {
    var4 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var3.origin, var3.angles);
    var0 = var4;
    setheadiconsnaptoedges(var4.headiconid, 500);
  }

  var6 = scripts\engine\utility::getStruct("claymore_crate_spawn_struct", "targetname");
  var0 = scripts\cp\laser_traps\cp_laser_traps::handle_leads_collected_hideiconbuilding(var6.origin, var6.angles);
  var7 = scripts\engine\utility::getStruct("molotov_crate_spawn_struct", "targetname");
  var0 = scripts\cp\laser_traps\cp_laser_traps::player_limitedammo(var7.origin + (0, 0, 5), var7.angles);
  var8 = scripts\engine\utility::getStruct("frag_crate_spawn_struct", "targetname");
  var0 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(var8.origin, var8.angles);
  var0 = scripts\cp\laser_traps\cp_laser_traps::binoculars_getpendingtime((-152.152, -361.947, 50.3), (0, 48.5995, 0));
  var0 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled((-211.976, 207.544, 63.5), (358.6, 293.969, -1.32843));
}