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
  setsaveddvar("fx_lights_intensity_scale", 1);
  scripts\engine\utility::flag_clear("spawning_in_progress");
  thread keephudhiddentillfadein();
  scripts\engine\utility::flag_wait("transfer_complete");
  ref_1233F();
  scripts\engine\utility::flag_wait("data_retrieved");
  has_target_player_with_battle_stations();
  wait 3;
  bonus_targets((-221, -588, 34), 0, 600);
  setsaveddvar("fx_lights_intensity_scale", 1);
  scripts\cp\maps\cp_so_embassy\cp_so_embassy::ref_12F4B();
}

function createhudtimer() {}

function ref_13D20() {
  var_0 = getEnt("glass_triggers", "targetname");
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

function ref_1233F() {
  var_0 = spawn("script_model", (-427, 393, 58));
  var_0 setModel("me_hardware_harddrive_01");
  var_1 = var_0 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_11A9A(undefined, (0, 0, 4));
  thread iscaliberattachment(var_1);
  thread ref_12CDD(var_1);
  var_2 = getEnt("computer_on", "targetname");
  var_3 = getEnt("computer_off", "targetname");
  var_3 show();
  var_2 hide();
}

function iscacsecondaryweapongroup(var_0) {
  scripts\engine\utility::flag_set("data_retrieved");
}

function iscaliberattachment(var_0) {
  self waittill("trigger", var_1);
  var_0 delete();
  self delete();
  scripts\engine\utility::flag_set("data_retrieved");
}

function method_for_calling_reinforcement() {
  var_0 = 0;

  if(level.players.size > 1) {
    var_0 = randomintrange(0, level.players.size - 1);
  }

  wait 5;
  level.players[var_0].team = "axis";
}

function play_nags_from_array() {
  createhudelem(level.createhistorydestination[1]);
  createhudelem(level.createhistorydestination[4]);
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_left", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(10));
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_right", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(2));
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!bomb_carrier(var_2)) {
      continue;
    }

    var_2.goalradius = 500;
    var_2 setgoalpos((1860.9, 963.5, 44));
    var_2 scripts\engine\utility::set_movement_speed(280);
  }

  wait 10;
  createhudelem(level.createhistorydestination[4]);
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!bomb_carrier(var_2)) {
      continue;
    }

    var_2.goalradius = 700;
    var_2 setgoalpos(level.oncrateactivate);
    var_2 scripts\engine\utility::set_movement_speed(280);
  }
}

function brevent2() {
  level endon("transfer_complete");
  GscBinSkip4(0x35);
}

function ref_11BDA() {
  scripts\engine\utility::flag_wait("download_50_percent");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_beta("incendiary_launcher", 1, 4);

  if(level.players.size > 3) {
    scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_beta("sentry", 1, 7);
    return;
  }
}

function ref_11CE3() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [(60.2156, -1296.45, 16), (0, 0, 0)]);
}

function set_vehicle_anims_techo(var_0, var_1) {
  self endon("death");
  var_0 endon("death_or_disconnect");
  self.og_fov = 1;

  if(distance2dsquared(self.origin, (-813.331, -420.376, 16.0002)) > 6250000) {
    var_2 = var_1[randomintrange(4, 8)];
    self forceteleport(var_2[0], var_2[1]);
  }

  var_3 = sortbydistance(level.ref_13AF5, self.origin)[0].origin;
  level.ref_13AF3 = scripts\engine\utility::array_randomize(level.ref_13AF3);
  var_4 = open_this_door();
  self setgoalpos(var_3);
  self.goalradius = 150;
  self.goalheight = 40;
  self waittill("goal");
  self setgoalpos(var_4);
  self waittill("goal");
  self setgoalpos(var_0.origin);

  if(var_0 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::getdefaultstreamhinttimeoutms()) {
    self getenemyinfo(var_0);
    self setgoalentity(var_0);
  }

  self.goalradius = 200;
  self.goalheight = 30;
  self.goalradius = 200;
  self.goalheight = 30;
}

function ref_12BCC(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!bomb_carrier(var_3)) {
      var_1 = var_3;
    }
  }

  var_5 = scripts\engine\utility::array_remove_array(var_0, var_1);
  return var_5;
}

function keep_firing_minigun() {
  GscBinSkip1(0x45, 1, 10);
}

function ally_vo() {
  var_0 = getaiarray("allies");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var_1 playSound("dx_vom_us1_groundfloor_combat_160");
  }

  scripts\engine\utility::flag_wait("wave_1_start");
  wait 6;
  var_0 = getaiarray("allies");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var_1 playSound("dx_vom_us2_defend_grounds_100");
  }

  wait 10;
  var_0 = getaiarray("allies");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var_1 playSound("dx_vom_us1_defend_combat1_50");
  }

  scripts\engine\utility::flag_wait("wave_2_start");
  wait 2;
  var_0 = getaiarray("allies");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var_1 playSound("dx_vom_us1_alley_combat_30");
  }

  scripts\engine\utility::flag_wait("wave_3_start");
  wait 2;
  var_0 = getaiarray("allies");

  if(isDefined(var_0[0])) {
    var_1 = sortbydistance(getaiarray("allies"), level.player.origin)[0];
    var_1 playSound("dx_vom_us1_street_approach_170");
    return;
  }
}

function ref_13554() {
  level endon("download_50_percent");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_rear", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(10));
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_left", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(6));
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_right", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(8));
}

function ref_13555() {
  level endon("download_50_percent");
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_right", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(5));
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_left", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(6));
  scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_rear", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(4));
}

function blockingcover(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1000;
  }

  var_2 = gettime();
  var_3 = var_2 + var_1 * 1000;

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  GscBinSkip1(0x45, 1, 18);
}

function bonus_targets(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 800;
  }

  var_3 = getaiarray("axis");

  foreach(var_5 in var_3) {
    if(!bomb_carrier(var_5)) {
      continue;
    }

    var_5.grenadeammo = 2;
    var_5.grenadeweapon = getcompleteweaponname("molotov");
    var_5.goalradius = var_2;
    var_5 setgoalpos(var_0);

    if(istrue(var_1)) {
      GscBinSkip4(0x6e, var_5);
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

function createhudelem(var_0) {
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1352B("enemy_cp_alq_desert_bomber", var_0, (0, 0, 0), 1, 1);
  var_1 endon("death");
  var_1.create_head_icon_for_crate = 1;
  var_1.attackeraccuracy = 0.01;
  var_2 = level.players;
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::getdefaultstreamhinttimeoutms()) {
      var_3 = var_5;
    }
  }

  var_1 scripts\engine\utility::set_movement_speed(300);
  var_2 = scripts\engine\utility::array_remove_array(var_2, var_3);
  var_5 = scripts\engine\utility::random(var_2);

  if(isDefined(var_5)) {
    var_1 setgoalpos(var_5.origin);
    var_1 getenemyinfo(var_5);
    var_1 setgoalentity(var_5);
  }

  GscBinSkip4(0x6e, var_1);
}

function create_nav_obstacle_for_wheelson() {
  self waittill("detonated");
  var_0 = self magicgrenade(self.origin + (0, 0, 60), self.origin, 0.05, 0);
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

function bomb_carrier(var_0) {
  if(!isalive(var_0)) {
    return 0;
  }

  if(isDefined(var_0.create_head_icon_for_crate)) {
    return 0;
  }

  if(isDefined(var_0.ref_13AF2)) {
    return 0;
  }

  if(isDefined(var_0.ref_12DC3)) {
    return 0;
  }

  if(isDefined(var_0.og_fov)) {
    return 0;
  }

  return 1;
}

function objective_manager() {
  var_0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var_1 = "transfer_data";
  var_2 = scripts\cp\cp_objectives::requestworldid(var_1, 1);
  objective_setlabel(var_2, "Transfer Data");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_position(var_2, var_0.origin + (0, 0, 12));
  objective_state(var_2, "current");
  objective_icon(var_2, "icon_electrical_box");
}

function his_playerdisconnect() {
  var_0 = "assualt_compound";
  var_1 = spawnStruct();
  var_1.origin = (-319.79, -51.821, 100);
  var_2 = scripts\cp\cp_objectives::requestworldid(var_0, 2);
  objective_setdescription(var_2, &"CP_SO_EMBASSY/SECURE_COMPOUND");
  objective_setlabel(var_2, &"CP_SO_EMBASSY/SECURE_COMPOUND");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_position(var_2, var_1.origin);
  objective_state(var_2, "current");
  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_1_index", 2);
  objective_icon(var_2, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("compound_cleared");
  objective_state(var_2, "done");
}

function hitbytrain() {
  var_0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var_1 = "transfer_data";
  var_2 = scripts\cp\cp_objectives::requestworldid(var_1, 1);
  objective_setlabel(var_2, &"CP_SO_EMBASSY/TERMINAL");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_position(var_2, var_0.origin + (0, 0, 12));
  objective_state(var_2, "current");
  setomnvar("cp_objective_sub_1_index", 3);
  objective_icon(var_2, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("transfer_started");
  thread ref_12D8D();
  objective_state(var_2, "empty");

  for(;;) {
    scripts\engine\utility::flag_wait("transfer_paused");
    objective_state(var_2, "current");
    setomnvar("cp_objective_sub_1_index", 4);
    objective_setlabel(var_2, &"CP_SO_EMBASSY/RESUME_TRANSFER");
    scripts\engine\utility::flag_waitopen("transfer_paused");
    objective_state(var_2, "empty");
    setomnvar("cp_objective_sub_1_index", 6);
  }
}

function ref_12CDD(var_0) {
  scripts\engine\utility::flag_wait("transfer_complete");
  var_1 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var_2 = "retrieve_data";
  var_3 = scripts\cp\cp_objectives::requestworldid(var_2, 4);
  objective_setlabel(var_3, &"CP_SO_EMBASSY/RETRIEVE_DATA");
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 0);
  objective_position(var_3, var_0.origin + (0, 0, 12));
  objective_state(var_3, "current");
  setomnvar("cp_objective_sub_1_index", 5);
  objective_icon(var_3, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("data_retrieved");
  objective_state(var_3, "empty");
  setomnvar("cp_objective_sub_1_index", 8);
}

function ref_12D8D() {
  wait 3;
  var_0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var_1 = "defend_compound";
  var_2 = scripts\cp\cp_objectives::requestworldid(var_1, 2);
  objective_setlabel(var_2, &"CP_SO_EMBASSY/DEFEND_COMPOUND");
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 0);
  objective_position(var_2, var_0.origin + (200, 0, 150));
  objective_state(var_2, "current");
  setomnvar("cp_objective_sub_1_index", 6);
  objective_icon(var_2, "icon_waypoint_objective_general");
  thread ref_12BE3("transfer_complete", var_2);
  level endon("transfer_complete");

  while(!scripts\engine\utility::flag("transfer_complete")) {
    scripts\engine\utility::flag_wait("transfer_paused");
    objective_state(var_2, "empty");
    scripts\engine\utility::flag_waitopen("transfer_paused");
    objective_state(var_2, "current");
  }
}

function ref_12BE3(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_0);
  objective_state(var_1, "empty");
}

function omnvars() {
  scripts\engine\utility::flag_wait("transfer_complete");
  wait 1;
  var_0 = "assualt_compound";
  var_1 = spawnStruct();
  var_2 = scripts\engine\utility::getStruct("exfil_heli_nodes_09", "targetname");
  var_1.origin = (1147.58, -75.013, -8);
  level.oncrateactivate = var_1.origin;
  var_3 = scripts\cp\cp_objectives::requestworldid(var_0, 3);
  objective_setdescription(var_3, &"CP_SO_EMBASSY/EXTRACTION_POINT");
  objective_setlabel(var_3, &"CP_SO_EMBASSY/EXTRACTION_POINT");
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 0);
  objective_position(var_3, var_1.origin);
  objective_state(var_3, "current");
  setomnvar("cp_objective_sub_1_index", 7);
  objective_icon(var_3, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_wait("exfil_unsafe");
  objective_state(var_3, "empty");
  scripts\engine\utility::flag_waitopen("exfil_unsafe");
  scripts\engine\utility::flag_set("regroup_on_exfil");
  objective_setdescription(var_3, &"CP_SO_EMBASSY/EXTRACTION_POINT");
  objective_setlabel(var_3, &"CP_SO_EMBASSY/EXTRACTION_POINT");
  objective_state(var_3, "current");
  setomnvar("cp_objective_sub_1_index", 7);
}

function old_getspawnpoint_func() {
  scripts\engine\utility::flag_wait("exfil_unsafe");
  wait 1;
  var_0 = "clear_exfil_threats";
  var_1 = spawnStruct();
  var_1.origin = (1860.9, 963.5, 600);
  var_2 = scripts\cp\cp_objectives::requestworldid(var_0, 6);
  objective_setdescription(var_2, &"CP_SO_EMBASSY/CLEAR_THREATS");
  objective_state(var_2, "current");
  setomnvar("cp_objective_sub_1_index", 8);
  scripts\engine\utility::flag_waitopen("exfil_unsafe");
  objective_state(var_2, "empty");
}

function hatch_model_linkto_train() {
  scripts\engine\utility::flag_set("exfil_unsafe");
  wait 1;
  var_0 = "clear_compound";
  var_1 = spawnStruct();
  var_1.origin = (1860.9, 963.5, 600);
  var_2 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var_3 = scripts\cp\cp_objectives::requestworldid(var_0, 6);
  objective_setdescription(var_3, &"CP_SO_EMBASSY/CLEAR_THREATS");
  objective_setlabel(var_3, &"CP_SO_EMBASSY/CLEAR_THREATS");
  setomnvar("cp_objective_sub_1_index", 8);
  objective_position(var_3, var_2.origin + (200, 0, 150));
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 0);
  objective_state(var_3, "current");
  objective_icon(var_3, "icon_waypoint_objective_general");
  scripts\engine\utility::flag_waitopen("exfil_unsafe");
  objective_state(var_3, "empty");
}

function bonus_target_score(var_0) {
  GscBinSkip1(0x45, 1, 7);
}

function ref_1283D() {
  level endon("defend_start");

  while(!scripts\engine\utility::flag("defend_start")) {
    scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_rear", scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::propchange(16));
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      var_2.goalradius = 800;
      var_2 setgoalpos((3413, -146, -20));
    }

    while(getaiarray("axis").size > 1) {
      wait 0.1;
    }
  }
}

function min_player_health() {
  var_0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var_1 = 75;
  var_2 = var_0.origin + (0, 0, -30);
  level endon("transfer_complete");

  for(;;) {
    wait 1;
    var_3 = getaiarray("axis");

    if(!isDefined(var_3[0])) {
      continue;
    }

    var_4 = sortbydistance(var_3, var_0.origin)[0];

    if(distance(var_4.origin, var_2) < var_1) {
      scripts\engine\utility::flag_set("transfer_paused");
      var_5 = getEnt("computer_on", "targetname");
      var_5 hide();
      var_6 = getEnt("computer_off", "targetname");
      var_6 show();
      waitframe();
      var_7 = var_0 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_11A9A(&"CP_SO_EMBASSY/SERVER_PROMPT");
      var_7 waittill("trigger", var_8);
      var_7 delete();
      waitframe();
      var_5 = getEnt("computer_on", "targetname");
      var_5 show();
      var_6 = getEnt("computer_off", "targetname");
      var_6 hide();
      scripts\engine\utility::flag_clear("transfer_paused");
      wait 2;
    }
  }
}

function bonusdeathplunder(var_0) {
  var_1 = scripts\engine\utility::getStruct("server_struct", "targetname");

  while(!scripts\engine\utility::flag("transfer_complete")) {
    var_2 = [];
    var_3 = getaiarray("axis");

    foreach(var_5 in var_3) {
      if(!bomb_carrier(var_5)) {
        var_2 = var_5;
      }
    }

    var_3 = scripts\engine\utility::array_remove_array(var_3, var_2);

    if(isDefined(var_3[var_0])) {
      var_5 = sortbydistance(var_3, var_1.origin)[var_0];
      set_vehicle_anims_tromeo(var_5, var_1);

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

function set_vehicle_anims_tromeo(var_0) {
  self endon("death");
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_sh_romeo870_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  thread scripts\anim\shared::forceuseweapon(var_1, "primary");
  self.ref_13AF2 = 1;
  self.health = 175;
  var_2 = sortbydistance(level.ref_13AF5, self.origin)[0].origin;
  level.ref_13AF3 = scripts\engine\utility::array_randomize(level.ref_13AF3);
  var_3 = open_this_door();
  self setgoalpos(var_2);
  GscBinSkip4(0x35, 180);
}

function open_this_door() {
  var_0 = level.ref_13AF3[level.ref_13AF4];
  level.ref_13AF4++;

  if(level.ref_13AF4 == level.ref_13AF3.size) {
    level.ref_13AF4 = 0;
  }

  return var_0;
}

function ref_13AF6() {
  level.ref_13AF5 = [];
  var_0 = spawnStruct();
  var_0.origin = (184.872, 1001.06, 41);
  level.ref_13AF5[level.ref_13AF5.size] = var_0;
  var_1 = spawnStruct();
  var_1.origin = (16.1177, -1808.52, 16.6421);
  level.ref_13AF5[level.ref_13AF5.size] = var_1;
  var_2 = spawnStruct();
  var_2.origin = (439.422, 1205.44, 25.0132);
  level.ref_13AF5[level.ref_13AF5.size] = var_2;
  level.ref_13AF3 = [];
  level.ref_13AF3[level.ref_13AF3.size] = (-89.31, 82.03, 46.3515);
  level.ref_13AF3[level.ref_13AF3.size] = (141.984, 355.185, 40);
  level.ref_13AF3[level.ref_13AF3.size] = (-132.506, 721.46, 42);
  level.ref_13AF3[level.ref_13AF3.size] = (-674.321, 26.7897, 33.2541);
}

function bomb_vests_explode(var_0) {
  self endon("death");
  self.ignoreall = 1;
  GscBinSkip4(0x35);
}

function little_bird_mg_cp_init() {
  self endon("goal");

  while(self.ignoreall) {
    var_0 = sortbydistance(level.players, self.origin)[0];

    if(250 > distance(self.origin, var_0.origin)) {
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

  for(var_0 = 0; var_0 < 3; var_0++) {
    while(level.jumpcomandsregistered < 10 * level.players.size) {
      wait 0.5;
    }

    level.jumpcomandsregistered = 0;
    scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::weapon_xp_iw8_sm_augolf(var_0);
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
  scripts\engine\utility::ref_143B9(30, "goal");
  self.ignoreall = 0;
}

function keep_requesting_spawners() {
  wait 10;
  ref_12DC7();
  scripts\engine\utility::flag_set("wave_2_start");

  while(scripts\engine\utility::flag("spawning_in_progress")) {
    wait 0.1;
  }

  wait 6;
  scripts\engine\utility::flag_set("spawning_in_progress");
  setsaveddvar("fx_lights_intensity_scale", 0.15);
  var_0 = thread ref_135EB(level.ref_13DE2, "truck_03");
  scripts\engine\utility::flag_clear("spawning_in_progress");
  wait 1;
  thread scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_left", 12);
  wait 1;

  while(getaiarray("axis").size > 12 && !scripts\engine\utility::flag("download_75_percent")) {
    bonus_targets((402, 1234, 48), 0, 800);
    wait 0.1;
  }

  GscBinSkip4(0x35);
}

function ref_12DC7() {
  while(getaiarray("axis").size > 35) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("spawning_in_progress");
  var_0 = scripts\engine\utility::getStructArray("construction_spawners_lower", "targetname");
  var_0[0].origin = (940, 2160, 25);
  var_0[1].origin = (1124, 2160, 25);
  var_0[2].origin = (960, 2160, 25);
  var_1 = scripts\engine\utility::getStructArray("construction_spawners_lower", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
  }

  bonus_targets((-278.627, 410.686, 152), 1, 700);
  var_1 = scripts\engine\utility::getStructArray("construction_spawners_rpg", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4.ref_12DC3 = 1;
    var_4.goalradius = 200;

    if(!isDefined(var_4.target)) {
      var_4 setgoalpos((-914, 2137, 394));
    }

    thread no_more_wire_to_cut();
  }

  var_8 = scripts\engine\utility::getStructArray("construction_spawners_lmg", "targetname");

  foreach(var_3 in var_8) {
    var_4 = var_3 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
    var_4.ref_12DC3 = 1;
    var_4.goalradius = 200;
    thread no_more_wire_to_cut();
  }

  var_11 = (2648, 2623, 169);
  var_12 = scripts\engine\utility::spawn_tag_origin((-818, 2119, 855), (0, 270, 0));
  ref_1356E(var_11, var_12, "enemy_cp_alq_desert_lmg");
  var_12 = scripts\engine\utility::spawn_tag_origin((-1040, 1890, 545), (0, 270, 0));
  ref_1356E(var_11, var_12, "enemy_cp_alq_desert_lmg");
  var_12 = scripts\engine\utility::spawn_tag_origin((-318, 1923, 225), (0, 270, 0));
  ref_1356E(var_11, var_12, "enemy_cp_alq_desert_lmg");

  if(level.players.size > 2) {
    var_12 = scripts\engine\utility::spawn_tag_origin((18, 1865, 713), (0, 230, 0));
    ref_1356E(var_11, var_12, "enemy_cp_alq_desert_lmg", "prone");
  }

  scripts\engine\utility::flag_clear("spawning_in_progress");
}

function ref_1356E(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_1352B(var_2, var_0, (0, 0, 0), undefined, 1);
  var_4 allowedstances("prone");
  var_4.og_fov = 1;
  wait 1;
  var_4 forceteleport(var_1.origin);
  var_4.ignoresuppression = 1;

  if(isDefined(var_3)) {
    var_4 allowedstances(var_3);
  } else {
    var_4 allowedstances("stand", "crouch");
  }

  var_4 linkTo(var_1);
}

function ref_135EB(var_0, var_1) {
  var_2 = getEnt("techo_spawner", "targetname");
  var_3 = var_2 scripts\common\utility::spawn_vehicle();
  scripts\engine\utility::delaythread(0.5, &ref_12364, var_3);
  ref_13562(var_3);
  var_3 scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
  var_2.count = 1;
  var_3.targetname = var_1;
  return var_3;
}

function ref_13562(var_0) {
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134EB("enemy_cp_alq_desert_smg", var_0, 0);
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134EB("enemy_cp_alq_desert_shotgun", var_0, 1);
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134EB("enemy_cp_alq_desert_smg", var_0, 2);
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134EB("enemy_cp_alq_desert_shotgun", var_0, 3);
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134EB("enemy_cp_alq_desert_ar", var_0, 4);
  var_1 = scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134EB("enemy_cp_alq_desert_ar", var_0, 5);
}

function keep_trying_to_kill_off_ai() {
  scripts\engine\utility::flag_set("wave_3_start");
}

function ref_12364(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 endon("death");
  waitframe();
  var_1 = playFXOnTag(scripts\engine\utility::getfx("truck_headlight"), var_0, "tag_light_front_left");
  wait 7;
}

function keephudhiddentillfadein() {
  for(;;) {
    if(scripts\engine\utility::flag("transfer_complete")) {
      break;
    }

    scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_134ED("enemy_spawner_defend_left", 5);
    bonus_targets((-221, -588, 34), 0, 1000);

    while(getaiarray("axis").size > 3 && !scripts\engine\utility::flag("transfer_complete")) {
      wait 0.1;
    }
  }
}

function min_pt() {
  var_0 = scripts\engine\utility::getStruct("server_struct", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  wait 0.15;
  var_1 playSound("cp_file_transfer_start");
  var_1 playLoopSound("cp_file_transfer_lp");
  var_2 = 0;
  var_3 = int(getdvarint("cp_so_downloadtime", 240));
  var_4 = var_3;
  setomnvar("cpu_hacking_progress", var_2);
  setomnvar("cpu_hacking_speed", 20);
  setomnvar("cpu_hacking_time", var_4);

  while(var_2 < var_3) {
    wait 1;
    var_2 += 1;

    if(!scripts\engine\utility::flag("download_25_percent") && var_2 / var_3 > 0.25) {
      scripts\engine\utility::flag_set("download_25_percent");
    }

    if(!scripts\engine\utility::flag("download_35_percent") && var_2 / var_3 > 0.35) {
      scripts\engine\utility::flag_set("download_35_percent");
    }

    if(!scripts\engine\utility::flag("download_50_percent") && var_2 / var_3 > 0.5) {
      scripts\engine\utility::flag_set("download_50_percent");
    }

    if(!scripts\engine\utility::flag("download_75_percent") && var_2 / var_3 > 0.75) {
      scripts\engine\utility::flag_set("download_75_percent");
    }

    setomnvar("cpu_hacking_progress", var_2 / var_3);
    var_4 -= 1;
    setomnvar("cpu_hacking_time", int(var_4));

    if(scripts\engine\utility::flag("transfer_paused")) {
      var_1 stoploopsound();
      var_1 playSound("cp_file_transfer_stop");
      setomnvar("cpu_hacking_time", -1);
      scripts\engine\utility::flag_waitopen("transfer_paused");
      setomnvar("cpu_hacking_time", int(var_4));
      var_1 playSound("cp_file_transfer_start");
      var_1 playLoopSound("cp_file_transfer_lp");
    }
  }

  setomnvar("cpu_hacking_progress", -1);
  scripts\engine\utility::flag_set("transfer_complete");
  level notify("stop_care_packages");
}

function starscores() {
  var_0 = getEnt("flare_mortar", "targetname");
  var_0.shell = "j_mortar_shell";
  var_0 hidepart("j_mortar_shell", "misc_wm_mortar");
  var_1 = scripts\engine\utility::spawn_tag_origin((-94, 299, 179.5), (0, 270, 0));
  var_1 show();
  wait 0.15;
  scripts\engine\utility::flag_wait("illumination_flare_enabled");
  var_2 = spawnStruct();
  var_2.origin = var_0 gettagorigin("j_shaft_top");
  playFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var_1, "tag_origin");

  for(;;) {
    var_3 = var_2 scripts\cp\maps\cp_so_embassy\cp_so_embassy_util::ref_11A9A(&"CP_SO_EMBASSY/LAUNCH_FLARE");
    var_3 waittill("trigger", var_4);
    var_3 delete();
    illumination_flare(var_0);
    wait 0.1;
  }
}

function openbunkerdoor() {
  var_0 = scripts\engine\utility::spawn_tag_origin((-1879, -680, 100), (270, 181.41, 51.5176));
  var_0 show();
  wait 0.15;
  playFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var_0, "tag_origin");
  wait 1;
}

function illumination_flare(var_0) {
  var_1 = var_0 gettagorigin("j_shaft_top");
  var_2 = 2.25;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = level.flare_light.og_angles + (10, 60, 0);
  var_3 = (800, -200, 800);
  level.flare_light.intensity = 50;
  var_6 = spawn("script_model", var_0.origin);
  var_6 setModel("tag_origin");
  var_7 = 0.15;
  wait var_7;
  playFX(level._effect["vfx_mortar_fire"], var_1, anglesToForward(var_0.angles));
  var_0 playSound("weap_mortar_flare_launch");
  var_6 scripts\engine\utility::delaycall(0.1, &playsoundonmovingent, "weap_mortar_flare_whistle");
  thread movemortar(var_6, var_1, var_3, var_2, 400);
  wait var_2;
  level.flare_light moveTo(var_6.origin, 0.1);
  wait 0.1;
  scripts\engine\utility::flag_set("flares_out");
  thread flare_light();
  playFXOnTag(scripts\engine\utility::getfx("vfx_illumination_flare_unlit"), var_6, "tag_origin");
  waitframe();
  var_6 playSound("weap_mortar_flare_burst");
  level.flare_light moveTo((1500, -200, var_3[2] - 200), level.flare_lifetime);
  var_6 moveTo((1500, -200, var_3[2] - 200), level.flare_lifetime);
  thread flare_countdown();
  wait level.flare_lifetime;
  var_6 delete();
  scripts\engine\utility::flag_clear("flares_out");
}

function player_is_just_guessing(var_0) {
  wait 0.1;
  playfxontagforclients(scripts\engine\utility::getfx("vfx_mortar_launch_trail"), self, "tag_origin", level.players[0]);
}

function flare_mover(var_0) {
  while(isDefined(self) && scripts\engine\utility::flag("flares_out")) {
    var_1 = self.origin[0] + randomintrange(-5, 5);
    var_2 = self.origin[1] + randomintrange(-5, 5);
    var_3 = self.origin[2] - 15;
    self moveTo((var_1, var_2, var_3), 1);
    wait 1;
  }
}

function flare_countdown() {
  level.flare_countdown = level.flare_lifetime;

  for(var_0 = level.flare_lifetime; var_0 > 0; var_0--) {
    level.flare_countdown--;
    wait 1;
  }
}

function movemortar(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("scr_mortar_gravity", "0 ");

  if(getdvarint("scr_mortar_gravity")) {
    var_0.origin = var_1;
    var_5 = getdvarint("bg_gravity");
    var_6 = distance(var_1, var_2);
    var_7 = var_2 - var_1;
    var_8 = 0.5 * var_5 * squared(var_3) * -1;
    var_9 = (var_7[0] / var_3, var_7[1] / var_3, (var_7[2] - var_8) / var_3);
    var_0 movegravity(var_9, var_3);
    var_10 = gettime() + var_3 * 1000;

    while(gettime() < var_10) {
      anglemortar(var_0);
      waitframe();
    }

    return;
  }

  var_11 = 1200;

  if(isDefined(var_4)) {
    var_11 = var_4;
  }

  var_12 = 1 / var_3 / 0.05;
  var_13 = 0;

  while(var_13 < 1) {
    var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_11, var_13);
    anglemortar(var_0);
    var_13 += var_12;
    wait 0.05;
  }

  var_0.origin = var_2;
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
  var_0 = 100;
  var_1 = 2;
  var_2 = 0;
  var_3 = level.flare_light getlightradius();

  if(isDefined(level.flare_light.intensity)) {
    var_0 = level.flare_light.intensity;
  }

  level.flare_light setlightcolor((1, 0.95, 1.25));
  level.flare_light setlightintensity(var_0);
  level.flare_light setlightradius(level.flare_light getlightradius() * 2);
  level.flare_light setlightfovrange(120, 40);
  wait level.flare_lifetime - var_2;
  level.flare_light setlightradius(var_3);
  level.flare_light setlightintensity(0);
}