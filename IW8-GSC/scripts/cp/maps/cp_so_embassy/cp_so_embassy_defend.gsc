/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_embassy\cp_so_embassy_defend.gsc
******************************************************************/

function justbecamehvt() {
  level.playerscoreeventvalue = 1;
  thread min_pt();
  thread min_player_health();
  wait 3;
  brevent2();
  setsaveddvar("NQNQPRLRQM", 1);
  scripts\engine\utility::flag_clear("spawning_in_progress");
  thread keephudhiddentillfadein();
  scripts\engine\utility::flag_wait("transfer_complete");
  ref_1233f();
  scripts\engine\utility::flag_wait("data_retrieved");
  has_target_player_with_battle_stations();
  wait 3;
  bonus_targets((-221, -588, 34), 0, 600);
  setsaveddvar("NQNQPRLRQM", 1);
  scripts\cp\maps\cp_so_embassy\cp_so_embassy::ref_12f4b();
}

function createhudtimer() {}

function ref_13d20() {
  var0 = getEnt("glass_triggers", "targetname");
  radiusdamage((32, 377, 112), 50, 50, 50);
  radiusdamage((-1042, 1890, 645), 50, 50, 50);
  waitframe();
  radiusdamage((-309, 1885, 275), 50, 50, 50);
}

function createheliextractobjectiveicons() {
  level.createhistorydestination = [];
  level.createhistorydestination[level.createhistorydestination.size] = (4778, 811, 17.4804);
  level.createhistorydestination[level.createhistorydestination.size] = (3621, 698, -20);
  level.createhistorydestination[level.createhistorydestination.size] = (4148, -1864, -7.49091);
  level.createhistorydestination[level.createhistorydestination.size] = (5123, -855, 4.50909);
  level.createhistorydestination[level.createhistorydestination.size] = (2165, 1857, 25);
}

function has_target_player_with_battle_stations() {
  wait 1;
  bonus_targets((-221, -588, 34), 1, 600);

  if(getaiarray("axis").size) {
    thread hatch_model_linkto_train();
    return;
  }
}

function ref_1233f() {
  var0 = spawn("script_model", (-427, 393, 58));
  var0 setModel("me_hardware_harddrive_01");
  var1 = var0 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_11a9a(undefined, (0, 0, 4));
  thread iscaliberattachment(var1);
  thread ref_12cdd(var1);
  var2 = getEnt("computer_on", "targetname");
  var3 = getEnt("computer_off", "targetname");
  var3 show();
  var2 hide();
}

function iscacsecondaryweapongroup(var0) {
  scripts\engine\utility::flag_set("data_retrieved");
}

function iscaliberattachment(var0) {
  self waittill("trigger", var1);
  var0 delete();
  self delete();
  scripts\engine\utility::flag_set("data_retrieved");
}

function method_for_calling_reinforcement() {
  var0 = 0;

  if(level.players.size > 1) {
    var0 = randomintrange(0, level.players.size - 1);
  }

  wait 5;
  level.players[var0].team = "axis";
}

function play_nags_from_array() {
  createhudelem(level.createhistorydestination[1]);
  createhudelem(level.createhistorydestination[4]);
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_left", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(10));
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_right", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(2));
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    if(!bomb_carrier(var2)) {
      continue;
    }

    var2.goalradius = 500;
    var2 setgoalpos((1860.9, 963.5, 44));
    var2 scripts\engine\utility::set_movement_speed(280);
  }

  wait 10;
  createhudelem(level.createhistorydestination[4]);
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    if(!bomb_carrier(var2)) {
      continue;
    }

    var2.goalradius = 700;
    var2 setgoalpos(level.oncrateactivate);
    var2 scripts\engine\utility::set_movement_speed(280);
  }
}

function brevent2() {
  level endon("transfer_complete");
  GscBinSkip4(0x35);
}

function ref_11bda() {
  scripts\engine\utility::flag_wait("download_50_percent");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_beta("incendiary_launcher", 1, 4);

  if(level.players.size > 3) {
    scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_beta("sentry", 1, 7);
    return;
  }
}

function ref_11ce3() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [(60.2156, -1296.45, 16), (0, 0, 0)]);
}

function set_vehicle_anims_techo(var0, var1) {
  self endon("death");
  var0 endon("death_or_disconnect");
  self.og_fov = 1;

  if(distance2dsquared(self.origin, (-813.331, -420.376, 16.0002)) > 6250000) {
    var2 = var1[randomintrange(4, 8)];
    self forceteleport(var2[0], var2[1]);
  }

  var3 = sortbydistance(level.ref_13af5, self.origin)[0].origin;
  level.ref_13af3 = scripts\engine\utility::array_randomize(level.ref_13af3);
  var4 = open_this_door();
  self setgoalpos(var3);
  self.goalradius = 150;
  self.goalheight = 40;
  self waittill("goal");
  self setgoalpos(var4);
  self waittill("goal");
  self setgoalpos(var0.origin);

  if(var0 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::getdefaultstreamhinttimeoutms()) {
    self getenemyinfo(var0);
    self setgoalentity(var0);
  }

  self.goalradius = 200;
  self.goalheight = 30;
  self.goalradius = 200;
  self.goalheight = 30;
}

function ref_12bcc(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!bomb_carrier(var3)) {
      var1 = var3;
    }
  }

  var5 = scripts\engine\utility::array_remove_array(var0, var1);
  return var5;
}

function keep_firing_minigun() {
  GscBinSkip1(0x45, 1, 10);
}

function ally_vo() {
  var0 = getaiarray("allies");

  if(isDefined(var0[0])) {
    var1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var1 playSound("dx_vom_us1_groundfloor_combat_160");
  }

  scripts\engine\utility::flag_wait("wave_1_start");
  wait 6;
  var0 = getaiarray("allies");

  if(isDefined(var0[0])) {
    var1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var1 playSound("dx_vom_us2_defend_grounds_100");
  }

  wait 10;
  var0 = getaiarray("allies");

  if(isDefined(var0[0])) {
    var1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var1 playSound("dx_vom_us1_defend_combat1_50");
  }

  scripts\engine\utility::flag_wait("wave_2_start");
  wait 2;
  var0 = getaiarray("allies");

  if(isDefined(var0[0])) {
    var1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var1 playSound("dx_vom_us1_alley_combat_30");
  }

  scripts\engine\utility::flag_wait("wave_3_start");
  wait 2;
  var0 = getaiarray("allies");

  if(isDefined(var0[0])) {
    var1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var1 playSound("dx_vom_us1_street_approach_170");
    return;
  }
}

function ref_13554() {
  level endon("download_50_percent");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_rear", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(10));
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_left", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(6));
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_right", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(8));
}

function ref_13555() {
  level endon("download_50_percent");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_right", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(5));
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_left", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(6));
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_rear", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(4));
}

function blockingcover(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1000;
  }

  var2 = gettime();
  var3 = var2 + var1 * 1000;

  if(!isDefined(var0)) {
    var0 = 0;
  }

  GscBinSkip1(0x45, 1, 18);
}

function bonus_targets(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 800;
  }

  var3 = getaiarray("axis");

  foreach(var5 in var3) {
    if(!bomb_carrier(var5)) {
      continue;
    }

    var5.grenadeammo = 2;
    var5.grenadeweapon = getcompleteweaponname("molotov");
    var5.goalradius = var2;
    var5 setgoalpos(var0);

    if(istrue(var1)) {
      GscBinSkip4(0x6e, var5);
    }

    wait 0.1;
  }
}

function ctgs_compareweaponxp() {
  createhudelem(level.createhistorydestination[level.createhistorydestination.size - 1]);
  wait 1;

  if(level.players.size < 2) {
    wait 6;
  }

  createhudelem(level.createhistorydestination[level.createhistorydestination.size - 2]);
  wait 1;

  if(level.players.size < 2) {
    wait 6;
  }

  createhudelem(level.createhistorydestination[level.createhistorydestination.size - 3]);

  if(level.players.size < 2) {
    return;
  }

  wait 5;
  createhudelem(level.createhistorydestination[4]);
  wait 1;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));
  wait 1;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));

  if(level.players.size < 4) {
    return;
  }

  wait 10;
  createhudelem(level.createhistorydestination[4]);
  wait 1;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));
  wait 2;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));
  wait 2;
  createhudelem(scripts\engine\utility::random(level.createhistorydestination));
}

function createhudelem(var0) {
  var1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1352b("enemy_cp_alq_desert_bomber", var0, (0, 0, 0), 1, 1);
  var1 endon("death");
  var1.create_head_icon_for_crate = 1;
  var1.attackeraccuracy = 0.01;
  var2 = level.players;
  var3 = [];

  foreach(var5 in var2) {
    if(var5 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::getdefaultstreamhinttimeoutms()) {
      var3 = var5;
    }
  }

  var1 scripts\engine\utility::set_movement_speed(300);
  var2 = scripts\engine\utility::array_remove_array(var2, var3);
  var5 = scripts\engine\utility::random(var2);

  if(isDefined(var5)) {
    var1 setgoalpos(var5.origin);
    var1 getenemyinfo(var5);
    var1 setgoalentity(var5);
  }

  GscBinSkip4(0x6e, var1);
}

function create_nav_obstacle_for_wheelson() {
  self waittill("detonated");
  var0 = self magicgrenade(self.origin + (0, 0, 60), self.origin, 0.05, 0);
}

function create_name_fx_base() {
  for(;;) {
    self waittill("damage");

    if(isDefined(self.is_specops_gametype)) {
      self getenemyinfo(self.is_specops_gametype);
    }

    waitframe();
  }
}

function bomb_carrier(var0) {
  if(!isalive(var0)) {
    return 0;
  }

  if(isDefined(var0.create_head_icon_for_crate)) {
    return 0;
  }

  if(isDefined(var0.ref_13af2)) {
    return 0;
  }

  if(isDefined(var0.ref_12dc3)) {
    return 0;
  }

  if(isDefined(var0.og_fov)) {
    return 0;
  }

  return 1;
}

function objective_manager() {
  var0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var1 = "transfer_data";
  var2 = scripts\cp\cp_objectives::requestworldid(var1, 1);
  objective_setlabel(var2, "Transfer Data");
  objective_setplayintro(var2, 1);
  objective_setplayoutro(var2, 0);
  objective_position(var2, var0.origin + (0, 0, 12));
  objective_state(var2, "current");
  objective_icon(var2, "icon_electrical_box");
}

function his_playerdisconnect() {
  var0 = "assualt_compound";
  var1 = spawnStruct();
  var1.origin = (-319.79, -51.821, 100);
  var2 = scripts\cp\cp_objectives::requestworldid(var0, 2);
  objective_setdescription(var2, &"CP_SO_EMBASSY/SECURE_COMPOUND");
  objective_setlabel(var2, &"CP_SO_EMBASSY/SECURE_COMPOUND");
  objective_setplayintro(var2, 1);
  objective_setplayoutro(var2, 0);
  objective_position(var2, var1.origin);
  objective_state(var2, "current");
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_1_index", 2);
  objective_icon(var2, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("compound_cleared");
  objective_state(var2, "done");
}

function hitbytrain() {
  var0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var1 = "transfer_data";
  var2 = scripts\cp\cp_objectives::requestworldid(var1, 1);
  objective_setlabel(var2, &"CP_SO_EMBASSY/TERMINAL");
  objective_setplayintro(var2, 1);
  objective_setplayoutro(var2, 0);
  objective_position(var2, var0.origin + (0, 0, 12));
  objective_state(var2, "current");
  setomnvar("cp_objective_sub_1_index", 3);
  objective_icon(var2, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("transfer_started");
  thread ref_12d8d();
  objective_state(var2, "empty");

  for(;;) {
    scripts\engine\utility::flag_wait("transfer_paused");
    objective_state(var2, "current");
    setomnvar("cp_objective_sub_1_index", 4);
    objective_setlabel(var2, &"CP_SO_EMBASSY/RESUME_TRANSFER");
    scripts\engine\utility::flag_waitopen("transfer_paused");
    objective_state(var2, "empty");
    setomnvar("cp_objective_sub_1_index", 6);
  }
}

function ref_12cdd(var0) {
  scripts\engine\utility::flag_wait("transfer_complete");
  var1 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var2 = "retrieve_data";
  var3 = scripts\cp\cp_objectives::requestworldid(var2, 4);
  objective_setlabel(var3, &"CP_SO_EMBASSY/RETRIEVE_DATA");
  objective_setplayintro(var3, 1);
  objective_setplayoutro(var3, 0);
  objective_position(var3, var0.origin + (0, 0, 12));
  objective_state(var3, "current");
  setomnvar("cp_objective_sub_1_index", 5);
  objective_icon(var3, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("data_retrieved");
  objective_state(var3, "empty");
  setomnvar("cp_objective_sub_1_index", 8);
}

function ref_12d8d() {
  wait 3;
  var0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var1 = "defend_compound";
  var2 = scripts\cp\cp_objectives::requestworldid(var1, 2);
  objective_setlabel(var2, &"CP_SO_EMBASSY/DEFEND_COMPOUND");
  objective_setplayintro(var2, 1);
  objective_setplayoutro(var2, 0);
  objective_position(var2, var0.origin + (200, 0, 150));
  objective_state(var2, "current");
  setomnvar("cp_objective_sub_1_index", 6);
  objective_icon(var2, "icon_waypoint_objective_general");
  thread ref_12be3("transfer_complete", var2);
  level endon("transfer_complete");

  while(!scripts\engine\utility::flag("transfer_complete")) {
    scripts\engine\utility::flag_wait("transfer_paused");
    objective_state(var2, "empty");
    scripts\engine\utility::flag_waitopen("transfer_paused");
    objective_state(var2, "current");
  }
}

function ref_12be3(var0, var1) {
  scripts\engine\utility::flag_wait(var0);
  objective_state(var1, "empty");
}

function omnvars() {
  scripts\engine\utility::flag_wait("transfer_complete");
  wait 1;
  var0 = "assualt_compound";
  var1 = spawnStruct();
  var2 = scripts\engine\utility::getStruct("exfil_heli_nodes_09", "targetname");
  var1.origin = (1147.58, -75.013, -8);
  level.oncrateactivate = var1.origin;
  var3 = scripts\cp\cp_objectives::requestworldid(var0, 3);
  objective_setdescription(var3, &"CP_SO_EMBASSY/EXTRACTION_POINT");
  objective_setlabel(var3, &"CP_SO_EMBASSY/EXTRACTION_POINT");
  objective_setplayintro(var3, 1);
  objective_setplayoutro(var3, 0);
  objective_position(var3, var1.origin);
  objective_state(var3, "current");
  setomnvar("cp_objective_sub_1_index", 7);
  objective_icon(var3, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("exfil_unsafe");
  objective_state(var3, "empty");
  scripts\engine\utility::flag_waitopen("exfil_unsafe");
  scripts\engine\utility::flag_set("regroup_on_exfil");
  objective_setdescription(var3, &"CP_SO_EMBASSY/EXTRACTION_POINT");
  objective_setlabel(var3, &"CP_SO_EMBASSY/EXTRACTION_POINT");
  objective_state(var3, "current");
  setomnvar("cp_objective_sub_1_index", 7);
}

function old_getspawnpoint_func() {
  scripts\engine\utility::flag_wait("exfil_unsafe");
  wait 1;
  var0 = "clear_exfil_threats";
  var1 = spawnStruct();
  var1.origin = (1860.9, 963.5, 600);
  var2 = scripts\cp\cp_objectives::requestworldid(var0, 6);
  objective_setdescription(var2, &"CP_SO_EMBASSY/CLEAR_THREATS");
  objective_state(var2, "current");
  setomnvar("cp_objective_sub_1_index", 8);
  scripts\engine\utility::flag_waitopen("exfil_unsafe");
  objective_state(var2, "empty");
}

function hatch_model_linkto_train() {
  scripts\engine\utility::flag_set("exfil_unsafe");
  wait 1;
  var0 = "clear_compound";
  var1 = spawnStruct();
  var1.origin = (1860.9, 963.5, 600);
  var2 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var3 = scripts\cp\cp_objectives::requestworldid(var0, 6);
  objective_setdescription(var3, &"CP_SO_EMBASSY/CLEAR_THREATS");
  objective_setlabel(var3, &"CP_SO_EMBASSY/CLEAR_THREATS");
  setomnvar("cp_objective_sub_1_index", 8);
  objective_position(var3, var2.origin + (200, 0, 150));
  objective_setplayintro(var3, 1);
  objective_setplayoutro(var3, 0);
  objective_state(var3, "current");
  objective_icon(var3, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_waitopen("exfil_unsafe");
  objective_state(var3, "empty");
}

function bonus_target_score(var0) {
  GscBinSkip1(0x45, 1, 7);
}

function ref_1283d() {
  level endon("defend_start");

  while(!scripts\engine\utility::flag("defend_start")) {
    scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_rear", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(16));
    var0 = getaiarray("axis");

    foreach(var2 in var0) {
      var2.goalradius = 800;
      var2 setgoalpos((3413, -146, -20));
    }

    while(getaiarray("axis").size > 1) {
      wait 0.1;
    }
  }
}

function min_player_health() {
  var0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var1 = 75;
  var2 = var0.origin + (0, 0, -30);
  level endon("transfer_complete");

  for(;;) {
    wait 1;
    var3 = getaiarray("axis");

    if(!isDefined(var3[0])) {
      continue;
    }

    var4 = sortbydistance(var3, var0.origin)[0];

    if(distance(var4.origin, var2) < var1) {
      scripts\engine\utility::flag_set("transfer_paused");
      var5 = getEnt("computer_on", "targetname");
      var5 hide();
      var6 = getEnt("computer_off", "targetname");
      var6 show();
      waitframe();
      var7 = var0 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_11a9a(&"CP_SO_EMBASSY/SERVER_PROMPT");
      var7 waittill("trigger", var8);
      var7 delete();
      waitframe();
      var5 = getEnt("computer_on", "targetname");
      var5 show();
      var6 = getEnt("computer_off", "targetname");
      var6 hide();
      scripts\engine\utility::flag_clear("transfer_paused");
      wait 2;
    }
  }
}

function bonusdeathplunder(var0) {
  var1 = scripts\engine\utility::getStruct("server_struct", "targetname");

  while(!scripts\engine\utility::flag("transfer_complete")) {
    var2 = [];
    var3 = getaiarray("axis");

    foreach(var5 in var3) {
      if(!bomb_carrier(var5)) {
        var2 = var5;
      }
    }

    var3 = scripts\engine\utility::array_remove_array(var3, var2);

    if(isDefined(var3[var0])) {
      var5 = sortbydistance(var3, var1.origin)[var0];
      set_vehicle_anims_tromeo(var5, var1);

      if(level.players.size == 1) {
        wait 12;
      } else if(level.players.size == 2) {
        wait 7;
      } else {
        wait 4;
      }
    }

    waitframe();
  }
}

function set_vehicle_anims_tromeo(var0) {
  self endon("death");
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_sh_romeo870_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  thread scripts\anim\shared::forceuseweapon(var1, "primary");
  self.ref_13af2 = 1;
  self.health = 175;
  var2 = sortbydistance(level.ref_13af5, self.origin)[0].origin;
  level.ref_13af3 = scripts\engine\utility::array_randomize(level.ref_13af3);
  var3 = open_this_door();
  self setgoalpos(var2);
  GscBinSkip4(0x35, 180);
}

function open_this_door() {
  var0 = level.ref_13af3[level.ref_13af4];
  level.ref_13af4++;

  if(level.ref_13af4 == level.ref_13af3.size) {
    level.ref_13af4 = 0;
  }

  return var0;
}

function ref_13af6() {
  level.ref_13af5 = [];
  var0 = spawnStruct();
  var0.origin = (184.872, 1001.06, 41);
  level.ref_13af5[level.ref_13af5.size] = var0;
  var1 = spawnStruct();
  var1.origin = (16.1177, -1808.52, 16.6421);
  level.ref_13af5[level.ref_13af5.size] = var1;
  var2 = spawnStruct();
  var2.origin = (439.422, 1205.44, 25.0132);
  level.ref_13af5[level.ref_13af5.size] = var2;
  level.ref_13af3 = [];
  level.ref_13af3[level.ref_13af3.size] = (-89.31, 82.03, 46.3515);
  level.ref_13af3[level.ref_13af3.size] = (141.984, 355.185, 40);
  level.ref_13af3[level.ref_13af3.size] = (-132.506, 721.46, 42);
  level.ref_13af3[level.ref_13af3.size] = (-674.321, 26.7897, 33.2541);
}

function bomb_vests_explode(var0) {
  self endon("death");
  self.ignoreall = 1;
  GscBinSkip4(0x35);
}

function little_bird_mg_cp_init() {
  self endon("goal");

  while(self.ignoreall) {
    var0 = sortbydistance(level.players, self.origin)[0];

    if(250 > distance(self.origin, var0.origin)) {
      self.ignoreall = 0;
    }

    wait 1;
  }
}

function vfx_htown_stab_blink_3() {
  for(;;) {
    wait 1;

    if(level.vfx_htown_stab_blink_2) {
      iprintln("aggro");
      continue;
    }

    iprintln("suppressed");
  }
}

function velnormals() {
  GscBinSkip1(0x45, 1, 7);
}

function subscriptions() {
  scripts\cp\laser_traps\cp_laser_traps::add_global_spawn_function("axis", &weapon_xp_iw8_sm_uzulu);
}

function weapon_xp_iw8_sm_uzulu() {
  self endon("entitydeleted");
  self waittill("death");
  level.jumpcomandsregistered += 1;
  level notify("axis_killed");
}

function isinrewardflow() {
  level endon("kill_killstreak_watcher");
  level.jumpcomandsregistered = 0;

  for(var0 = 0; var0 < 3; var0++) {
    while(level.jumpcomandsregistered < 10 * level.players.size) {
      wait 0.5;
    }

    level.jumpcomandsregistered = 0;
    scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_augolf(var0);
  }
}

function vo_use_computer() {
  level endon("stop_care_packages");
  childthread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_papa90(4);
  scripts\engine\utility::flag_wait("download_35_percent");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_augolf(1);
  scripts\engine\utility::flag_wait("download_75_percent");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_augolf(3);
}

function no_more_wire_to_cut() {
  self endon("death");
  self.ignoreall = 1;
  scripts\engine\utility::ref_143b9(30, "goal");
  self.ignoreall = 0;
}

function keep_requesting_spawners() {
  wait 10;
  ref_12dc7();
  scripts\engine\utility::flag_set("wave_2_start");

  while(scripts\engine\utility::flag("spawning_in_progress")) {
    wait 0.1;
  }

  wait 6;
  scripts\engine\utility::flag_set("spawning_in_progress");
  setsaveddvar("NQNQPRLRQM", 0.15);
  var0 = thread ref_135eb(level.ref_13de2, "truck_03");
  scripts\engine\utility::flag_clear("spawning_in_progress");
  wait 1;
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_left", 12);
  wait 1;

  while(getaiarray("axis").size > 12 && !scripts\engine\utility::flag("download_75_percent")) {
    bonus_targets((402, 1234, 48), 0, 800);
    wait 0.1;
  }

  GscBinSkip4(0x35);
}

function ref_12dc7() {
  while(getaiarray("axis").size > 35) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("spawning_in_progress");
  var0 = scripts\engine\utility::getStructArray("construction_spawners_lower", "targetname");
  var0[0].origin = (940, 2160, 25);
  var0[1].origin = (1124, 2160, 25);
  var0[2].origin = (960, 2160, 25);
  var1 = scripts\engine\utility::getStructArray("construction_spawners_lower", "targetname");

  foreach(var3 in var1) {
    var4 = var3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
  }

  bonus_targets((-278.627, 410.686, 152), 1, 700);
  var1 = scripts\engine\utility::getStructArray("construction_spawners_rpg", "targetname");

  foreach(var3 in var1) {
    var4 = var3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var4.ref_12dc3 = 1;
    var4.goalradius = 200;

    if(!isDefined(var4.target)) {
      var4 setgoalpos((-914, 2137, 394));
    }

    thread no_more_wire_to_cut();
  }

  var8 = scripts\engine\utility::getStructArray("construction_spawners_lmg", "targetname");

  foreach(var3 in var8) {
    var4 = var3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var4.ref_12dc3 = 1;
    var4.goalradius = 200;
    thread no_more_wire_to_cut();
  }

  var11 = (2648, 2623, 169);
  var12 = scripts\engine\utility::spawn_tag_origin((-818, 2119, 855), (0, 270, 0));
  ref_1356e(var11, var12, "enemy_cp_alq_desert_lmg");
  var12 = scripts\engine\utility::spawn_tag_origin((-1040, 1890, 545), (0, 270, 0));
  ref_1356e(var11, var12, "enemy_cp_alq_desert_lmg");
  var12 = scripts\engine\utility::spawn_tag_origin((-318, 1923, 225), (0, 270, 0));
  ref_1356e(var11, var12, "enemy_cp_alq_desert_lmg");

  if(level.players.size > 2) {
    var12 = scripts\engine\utility::spawn_tag_origin((18, 1865, 713), (0, 230, 0));
    ref_1356e(var11, var12, "enemy_cp_alq_desert_lmg", "prone");
  }

  scripts\engine\utility::flag_clear("spawning_in_progress");
}

function ref_1356e(var0, var1, var2, var3) {
  var4 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1352b(var2, var0, (0, 0, 0), undefined, 1);
  var4 allowedstances("prone");
  var4.og_fov = 1;
  wait 1;
  var4 forceteleport(var1.origin);
  var4.ignoresuppression = 1;

  if(isDefined(var3)) {
    var4 allowedstances(var3);
  } else {
    var4 allowedstances("stand", "crouch");
  }

  var4 linkTo(var1);
}

function ref_135eb(var0, var1) {
  var2 = getEnt("techo_spawner", "targetname");
  var3 = var2 scripts\common\utility::spawn_vehicle();
  scripts\engine\utility::delaythread(0.5, &ref_12364, var3);
  ref_13562(var3);
  var3 scripts\common\vehicle::attach_vehicle_and_gopath(var0);
  var2.count = 1;
  var3.targetname = var1;
  return var3;
}

function ref_13562(var0) {
  var1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134eb("enemy_cp_alq_desert_smg", var0, 0);
  var1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134eb("enemy_cp_alq_desert_shotgun", var0, 1);
  var1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134eb("enemy_cp_alq_desert_smg", var0, 2);
  var1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134eb("enemy_cp_alq_desert_shotgun", var0, 3);
  var1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134eb("enemy_cp_alq_desert_ar", var0, 4);
  var1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134eb("enemy_cp_alq_desert_ar", var0, 5);
}

function keep_trying_to_kill_off_ai() {
  scripts\engine\utility::flag_set("wave_3_start");
}

function ref_12364(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var0 endon("death");
  waitframe();
  var1 = playFXOnTag(scripts\engine\utility::getfx("truck_headlight"), var0, "tag_light_front_left");
  wait 7;
}

function keephudhiddentillfadein() {
  for(;;) {
    if(scripts\engine\utility::flag("transfer_complete")) {
      break;
    }

    scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ed("enemy_spawner_defend_left", 5);
    bonus_targets((-221, -588, 34), 0, 1000);

    while(getaiarray("axis").size > 3 && !scripts\engine\utility::flag("transfer_complete")) {
      wait 0.1;
    }
  }
}

function min_pt() {
  var0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  wait 0.15;
  var1 playSound("cp_file_transfer_start");
  var1 playLoopSound("cp_file_transfer_lp");
  var2 = 0;
  var3 = int(getdvarint("cp_so_downloadtime", 240));
  var4 = var3;
  setomnvar("cpu_hacking_progress", var2);
  setomnvar("cpu_hacking_speed", 20);
  setomnvar("cpu_hacking_time", var4);

  while(var2 < var3) {
    wait 1;
    var2 += 1;

    if(!scripts\engine\utility::flag("download_25_percent") && var2 / var3 > 0.25) {
      scripts\engine\utility::flag_set("download_25_percent");
    }

    if(!scripts\engine\utility::flag("download_35_percent") && var2 / var3 > 0.35) {
      scripts\engine\utility::flag_set("download_35_percent");
    }

    if(!scripts\engine\utility::flag("download_50_percent") && var2 / var3 > 0.5) {
      scripts\engine\utility::flag_set("download_50_percent");
    }

    if(!scripts\engine\utility::flag("download_75_percent") && var2 / var3 > 0.75) {
      scripts\engine\utility::flag_set("download_75_percent");
    }

    setomnvar("cpu_hacking_progress", var2 / var3);
    var4 -= 1;
    setomnvar("cpu_hacking_time", int(var4));

    if(scripts\engine\utility::flag("transfer_paused")) {
      var1 stoploopsound();
      var1 playSound("cp_file_transfer_stop");
      setomnvar("cpu_hacking_time", -1);
      scripts\engine\utility::flag_waitopen("transfer_paused");
      setomnvar("cpu_hacking_time", int(var4));
      var1 playSound("cp_file_transfer_start");
      var1 playLoopSound("cp_file_transfer_lp");
    }
  }

  setomnvar("cpu_hacking_progress", -1);
  scripts\engine\utility::flag_set("transfer_complete");
  level notify("stop_care_packages");
}

function starscores() {
  var0 = getEnt("flare_mortar", "targetname");
  var0.shell = "j_mortar_shell";
  var0 hidepart("j_mortar_shell", "misc_wm_mortar");
  var1 = scripts\engine\utility::spawn_tag_origin((-94, 299, 179.5), (0, 270, 0));
  var1 show();
  wait 0.15;
  scripts\engine\utility::flag_wait("illumination_flare_enabled");
  var2 = spawnStruct();
  var2.origin = var0 gettagorigin("j_shaft_top");
  playFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var1, "tag_origin");

  for(;;) {
    var3 = var2 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_11a9a(&"CP_SO_EMBASSY/LAUNCH_FLARE");
    var3 waittill("trigger", var4);
    var3 delete();
    illumination_flare(var0);
    wait 0.1;
  }
}

function openbunkerdoor() {
  var0 = scripts\engine\utility::spawn_tag_origin((-1879, -680, 100), (270, 181.41, 51.5176));
  var0 show();
  wait 0.15;
  playFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var0, "tag_origin");
  wait 1;
}

function illumination_flare(var0) {
  var1 = var0 gettagorigin("j_shaft_top");
  var2 = 2.25;
  var3 = undefined;
  var4 = undefined;
  var5 = level.flare_light.og_angles + (10, 60, 0);
  var3 = (800, -200, 800);
  level.flare_light.intensity = 50;
  var6 = spawn("script_model", var0.origin);
  var6 setModel("tag_origin");
  var7 = 0.15;
  wait var7;
  playFX(level._effect["vfx_mortar_fire"], var1, anglesToForward(var0.angles));
  var0 playSound("weap_mortar_flare_launch");
  var6 scripts\engine\utility::delaycall(0.1, &playsoundonmovingent, "weap_mortar_flare_whistle");
  thread movemortar(var6, var1, var3, var2, 400);
  wait var2;
  level.flare_light moveTo(var6.origin, 0.1);
  wait 0.1;
  scripts\engine\utility::flag_set("flares_out");
  thread flare_light();
  playFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_unlit"), var6, "tag_origin");
  waitframe();
  var6 playSound("weap_mortar_flare_burst");
  level.flare_light moveTo((1500, -200, var3[2] - 200), level.flare_lifetime);
  var6 moveTo((1500, -200, var3[2] - 200), level.flare_lifetime);
  thread flare_countdown();
  wait level.flare_lifetime;
  var6 delete();
  scripts\engine\utility::flag_clear("flares_out");
}

function player_is_just_guessing(var0) {
  wait 0.1;
  playfxontagforclients(scripts\engine\utility::getfx("vfx_mortar_launch_trail"), self, "tag_origin", level.players[0]);
}

function flare_mover(var0) {
  while(isDefined(self) && scripts\engine\utility::flag("flares_out")) {
    var1 = self.origin[0] + randomintrange(-5, 5);
    var2 = self.origin[1] + randomintrange(-5, 5);
    var3 = self.origin[2] - 15;
    self moveTo((var1, var2, var3), 1);
    wait 1;
  }
}

function flare_countdown() {
  level.flare_countdown = level.flare_lifetime;

  for(var0 = level.flare_lifetime; var0 > 0; var0--) {
    level.flare_countdown--;
    wait 1;
  }
}

function movemortar(var0, var1, var2, var3, var4) {
  setdvarifuninitialized("scr_mortar_gravity", "0 ");

  if(getdvarint("scr_mortar_gravity")) {
    var0.origin = var1;
    var5 = getdvarint("NPOQPMP");
    var6 = distance(var1, var2);
    var7 = var2 - var1;
    var8 = 0.5 * var5 * squared(var3) * -1;
    var9 = (var7[0] / var3, var7[1] / var3, (var7[2] - var8) / var3);
    var0 movegravity(var9, var3);
    var10 = gettime() + var3 * 1000;

    while(gettime() < var10) {
      anglemortar(var0);
      waitframe();
    }

    return;
  }

  var11 = 1200;

  if(isDefined(var4)) {
    var11 = var4;
  }

  var12 = 1 / var3 / 0.05;
  var13 = 0;

  while(var13 < 1) {
    var0.origin = scripts\engine\math::get_point_on_parabola(var1, var2, var11, var13);
    anglemortar(var0);
    var13 += var12;
    wait 0.05;
  }

  var0.origin = var2;
}

function anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

function flare_light() {
  waitframe();
  var0 = 100;
  var1 = 2;
  var2 = 0;
  var3 = level.flare_light getlightradius();

  if(isDefined(level.flare_light.intensity)) {
    var0 = level.flare_light.intensity;
  }

  level.flare_light setlightcolor((1, 0.95, 1.25));
  level.flare_light setlightintensity(var0);
  level.flare_light setlightradius(level.flare_light getlightradius() * 2);
  level.flare_light setlightfovrange(120, 40);
  wait level.flare_lifetime - var2;
  level.flare_light setlightradius(var3);
  level.flare_light setlightintensity(0);
}