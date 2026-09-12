/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_brdov.gsc
******************************************************/

function init() {
  level.disable_heli_lights = spawnStruct();
  level.disable_heli_lights.ref_14291 = getdvarint("scr_brdov_version", 0);

  switch (level.disable_heli_lights.ref_14291) {
    case 3:
      strafe_speed();
      break;
    case 2:
      strafe_pass_target_dist();
      break;
    case 1:
      strafe_minigun_manager_delta();
      break;
    case 0:
    default:
      strafe_minigun_manager();
      break;
  }
}

function strafe_minigun_manager(var_0) {
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("infil");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("waitLoadoutDone");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::ref_12B11("getInfilPlayers", &remove_on_death);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onPlayerConnect", &onplayerconnect);
  scripts\mp\gametypes\br_gametypes::ref_12B11("prematchSpawnMaxLocations", &ref_12862);
  scripts\mp\gametypes\br_gametypes::ref_12B11("prematchSpawnNumTeamsPerLocation", &ref_12863);
  scripts\mp\gametypes\br_gametypes::ref_12B11("maySpawn", &mayspawn);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerWelcomeSplashes", &ref_126F1);
  scripts\mp\gametypes\br_gametypes::ref_12B11("initialPrespawnZOffset", &tier);
  scripts\mp\gametypes\br_gametypes::ref_12B11("disableLastManStandingDialog", &loadout_copyclassstruct);
  level.prematchperiodend = 0;
  level.br_infils_disabled = 1;
  level.ref_133E0 = 1;
  level.debug_safehouse_gunshop_start = 1;
  level.disablespawning = 1;

  if(!istrue(var_0)) {
    thread toggleconnectpaths();
    return;
  }
}

function toggleconnectpaths() {
  waittillframeend();
  var_0 = getdvarfloat("scr_brdov_prematch_spawn_radius", 1500);

  if(level.mapname == "mp_br_mechanics") {
    level.delete_script_object = [scripts\mp\gametypes\br::createspawnlocation((-6906, -4478, 66), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((4622, -301, 50), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((-2348, 1391, 58), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((-3787, 2022, 58), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((14913, 16178, 58), 0, var_0)];
    return;
  }

  level.delete_script_object = [scripts\mp\gametypes\br::createspawnlocation((28653, 2355, -688), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((26797, 20510, 1384), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((31359, 36450, 640), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((-22839, 49175, 2747), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((-22047, 15388, -6), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((21694, -16289, 1970), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((50956, -39269, 1412), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((46948, -10375, 125), 0, var_0), scripts\mp\gametypes\br::createspawnlocation((-5574, 8168, -269), 0, var_0)];
}

function ref_12862() {
  return false;
}

function ref_12863() {
  return true;
}

function remove_on_death() {
  return [];
}

function onplayerconnect(var_0) {
  var_0.br_infilstarted = 1;
  var_0.shouldhumanspawntags = 0;
  var_0.disable_hilltop_roof_traversal = gettime();
  var_0 setclientomnvar("ui_br_infiled", 1);
  thread onplayerspawn(var_0);
  var_0 setsoundsubmix("mp_br_event_dovp2_don4_infil", 0.5);
}

function onplayerspawn(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("br_spawned");
  var_0 setplayermusicstate(game["music"]["br_infil_intro"][0]);
  var_0 clearsoundsubmix("mp_br_event_dovp2_don4_infil", 3);

  if(getdvarint("scr_brdov_update_circle_on_first_spawn", 1)) {
    level notify("update_circle_hide");
  }

  waittillframeend();
  var_0 scripts\mp\gametypes\br_armor::searchcirclesize();
  var_0 scripts\mp\gametypes\br_weapons::br_ammo_give_type(var_0, "brloot_ammo_919", 30, 0);
}

function mayspawn() {
  return true;
}

function ref_126F1() {
  self endon("disconnect");
  self waittill("spawned_player");
  thread ref_126F2();

  while(!self isonground()) {
    waitframe();
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
}

function ref_126F2() {
  self endon("disconnect");
  wait getdvarfloat("scr_brdov_welcome_splash_delay", 5);
  scripts\mp\hud_message::showsplash("br_prematch_welcome_brdov");

  if(getdvarint("scr_brdov_update_circle_on_welcome", 1)) {
    level notify("update_circle_hide");
  }

  wait getdvarfloat("scr_brdov_welcome_vo_delay", 0.5);
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function tier() {
  return getdvarint("scr_brdov_prematch_spawn_z_offset", 2000);
}

function loadout_copyclassstruct(var_0) {
  if(!isDefined(var_0)) {
    return true;
  }

  var_1 = (gettime() - var_0.disable_hilltop_roof_traversal) / 1000;
  return var_1 < getdvarfloat("scr_brdov_disable_last_man_standing_time", 30);
}

function strafe_minigun_manager_delta() {
  thread togglecpplayerbc();
}

function togglecpplayerbc() {
  waittillframeend();
}

function strafe_pass_target_dist() {
  strafe_minigun_manager(1);
  scripts\mp\gametypes\br_gametypes::ref_12B11("preCalcSafeCircleCenters", &ref_12848);
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizePrematchSpawnOriginNextIdx");
  level.disable_heli_lights.ref_133C7 = getdvarint("scr_brdov2_skip_circles", 1);
  level.decoyassists = &decoy_ignoredbyenemy;
  thread togglelightbutton();
}

function togglelightbutton() {
  waittillframeend();
  var_0 = getdvarint("scr_brdov2_num_spawns", 10);
  var_1 = getdvarint("scr_brdov2_spawn_circle", 1);
  var_2 = level.br_level.default_class_chosen[var_1];
  var_3 = level.br_level.br_circleradii[var_1];
  var_2 = (var_2[0], var_2[1], 3000);
  var_4 = physics_createcontents(["physicscontents_playertrigger"]);
  var_5 = (0, 0, 0);
  var_6 = physics_raycast(var_2, var_2 + (var_3, 0, 0), var_4, undefined, 0, "physicsquery_all");
  var_5 += (var_3 * ammo_box_spawn(var_6), 0, 0);
  var_6 = physics_raycast(var_2, var_2 - (var_3, 0, 0), var_4, undefined, 0, "physicsquery_all");
  var_5 -= (var_3 * ammo_box_spawn(var_6), 0, 0);
  var_6 = physics_raycast(var_2, var_2 + (0, var_3, 0), var_4, undefined, 0, "physicsquery_all");
  var_5 += (0, var_3 * ammo_box_spawn(var_6), 0);
  var_6 = physics_raycast(var_2, var_2 - (0, var_3, 0), var_4, undefined, 0, "physicsquery_all");
  var_5 -= (0, var_3 * ammo_box_spawn(var_6), 0);
  var_5 /= 2;
  var_5 += var_2;
  level.delete_script_object = [];
  battletracks(var_5, var_2, var_3, var_0, 0);
  battletracks(var_5, var_2, var_3, var_0, 360 / var_0 / 2);
}

function battletracks(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getdvarfloat("scr_brdov2_spawn_circle_offset", 500);
  var_6 = physics_createcontents(["physicscontents_playertrigger"]);
  var_7 = [];

  for(var_8 = 0; var_8 < var_3; var_8++) {
    var_9 = var_8 * 360 / var_3 + var_4;
    var_10 = anglesToForward((0, var_9, 0));
    var_11 = var_0;
    var_12 = var_11 + 2 * var_10 * var_2;
    var_13 = scripts\mp\gametypes\br_public::woods_two_death_func(var_11, var_12, var_1, var_2);

    if(vectordot(var_10, var_13[0] - var_11) > 0) {
      var_12 = var_13[0];
    } else {
      var_12 = var_13[1];
    }

    var_14 = distance(var_11, var_12);
    var_15 = physics_raycast(var_11, var_12, var_6, undefined, 0, "physicsquery_all");
    var_16 = ammo_box_spawn(var_15);
    var_7 = var_11 + var_10 * (var_14 * var_16 - var_5);
  }

  var_7 = scripts\engine\utility::array_randomize(var_7);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_17 = vectortoangles(var_0 - var_7[var_8]);
    var_17 = (0, var_17[1], 0);
    var_18 = scripts\mp\gametypes\br::createspawnlocation(var_7[var_8], 0, 100);
    var_18.angles = var_17;
    level.delete_script_object[level.delete_script_object.size] = var_18;
  }
}

function ammo_box_spawn(var_0) {
  var_1 = 1;

  foreach(var_3 in var_0) {
    var_4 = var_3["entity"];

    if(isDefined(var_4) && isDefined(var_4.targetname) && var_4.targetname == "OutOfBounds") {
      var_1 = var_3["fraction"];
      break;
    }
  }

  return var_1;
}

function ref_12848() {
  for(var_0 = 0; var_0 < level.disable_heli_lights.ref_133C7; var_0++) {
    scripts\mp\gametypes\br_circle::last_vo_time(0);
    level.br_level.default_class_chosen = scripts\engine\utility::can_path_to_target(level.br_level.default_class_chosen, 0);
  }

  if(!isDefined(level.br_level.delay_start_infiltrate_objective)) {
    level.br_level.delay_start_infiltrate_objective = 0;
  }

  level.br_level.delay_start_infiltrate_objective -= level.disable_heli_lights.ref_133C7;
}

function decoy_ignoredbyenemy() {
  level.br_level.br_circleclosetimes = [270, 180, 140, 80, 70, 50, 50, 100];
  level.br_level.br_circledelaytimes = [220, 80, 70, 55, 55, 40, 30, 0];
  level.br_level.default_player_connect_black_screen = [220, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500];
  level.br_level.br_circleradii = [81600, 50000, 37000, 20000, 12300, 6000, 3000, 1500, 0];
}

function strafe_speed() {
  thread scripts\mp\gametypes\br_gametype_mini::init();
  scripts\mp\gametypes\br_gametypes::ref_12B11("overrideQuestSearchParams", &ref_12188);
}

function ref_12188(var_0) {
  return true;
}