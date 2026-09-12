/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\classes\cp_class_progression.gsc
*******************************************************/

function class_progression_init() {
  while(!isDefined(level.players)) {
    wait 0.1;
  }
}

function get_player_class(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_1 = var_0 scripts\cp\utility::getplayerdataloadoutgroup();
  var_2 = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "cpFieldUpgrade");
}

function give_player_class(var_0) {
  self notify("giving_class");
  scripts\cp\perks\cp_perks::init_each_perk();
  var_1 = scripts\cp\utility::getplayerdataloadoutgroup();
  var_2 = scripts\cp\cp_loadout::cac_getloadoutselectedidx();
  var_3 = "none";

  if(!scripts\cp\utility::tryingtoleave()) {
    self setviewkickscale(0.5);

    for(var_4 = 0; var_4 < 3; var_4++) {
      var_5 = var_4;

      if(isDefined(var_0)) {
        var_6 = scripts\cp\cp_loadout::table_getperk(level.classtablename, var_0, var_4);
      } else {
        var_6 = self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_2, "loadoutPerks", var_5);
      }

      if(isDefined(var_6)) {
        scripts\cp\utility::giveperk(var_6);
      }
    }
  }

  scripts\cp\coop_super::script_end();
  init_player_sessiondata();
}

function give_assault_class() {
  self.class = "assault";
  scripts\cp\utility::giveperk("specialty_fastreload");
}

function ref_12BC2() {
  scripts\cp\utility::takeperk("specialty_fastreload");
}

function give_crusader_class() {
  self.class = "crusader";
}

function ref_12BC8() {}

function wait_and_give_perk(var_0, var_1) {
  wait var_1;
  scripts\cp\utility::giveperk(var_0);
}

function give_tank_class() {
  self.class = "tank";
  screenent();
}

function screenent() {
  var_0 = self getcurrentweapon();

  if(scripts\cp\cp_weapon::is_launcher(var_0) && !scripts\cp\cp_weapon::is_killstreak_weapon(var_0)) {
    var_0 = scripts\cp\cp_weapon::add_launcher_xmags(var_0);
    return;
  }
}

function ref_12BF8() {
  var_0 = self getcurrentweapon();

  if(scripts\cp\cp_weapon::is_launcher(var_0) && !scripts\cp\cp_weapon::is_killstreak_weapon(var_0)) {
    var_1 = self getweaponammoclip(var_0);
    var_2 = self getweaponammostock(var_0);
    var_0 = scripts\cp\cp_weapon::ref_12BDA(var_0);
    self setweaponammoclip(var_0, var_1);
    self setweaponammostock(var_0, var_2);
    return;
  }
}

function give_medic_class() {
  self.class = "medic";
}

function ref_12BDE() {}

function give_hunter_class() {
  self.class = "hunter";
  scripts\cp\perks\cp_perks::reduce_recoil();
}

function ref_12BD5() {
  scripts\cp\perks\cp_perks::ref_12BEE();
}

function give_engineer_class() {
  self.class = "engineer";
}

function ref_12BCA() {}

function give_default_class() {
  var_0 = scripts\engine\utility::random(["medic", "tank", "crusader", "assault", "hunter", "engineer"]);

  switch (var_0) {
    case "medic":
      give_medic_class();
      break;
    case "tank":
      give_tank_class();
      break;
    case "crusader":
      give_crusader_class();
      break;
    case "assault":
      give_assault_class();
      break;
    case "hunter":
      give_hunter_class();
    case "engineer":
      give_engineer_class();
      break;
  }
}

function init_player_sessiondata() {
  var_0 = self;
  var_0 setplayerdata("cp", "CPSession", "skill_level", 1, 0);
  var_0 setplayerdata("cp", "CPSession", "skill_level", 2, 0);
  var_0 setplayerdata("cp", "CPSession", "skill_level", 3, 0);
  var_0 setplayerdata("cp", "CPSession", "skill_level", 4, 0);
  var_0 setplayerdata("cp", "CPSession", "skill_points", 0);
}

function randomize_player_sessiondata() {
  foreach(var_1 in level.players) {
    var_1 setplayerdata("cp", "CPSession", "skill_level", 1, randomint(5));
    var_1 setplayerdata("cp", "CPSession", "skill_level", 2, randomint(5));
    var_1 setplayerdata("cp", "CPSession", "skill_level", 3, randomint(5));
    var_1 setplayerdata("cp", "CPSession", "skill_level", 4, randomint(5));
  }
}

function give_skill_points(var_0) {
  var_1 = self getplayerdata("cp", "CPSession", "skill_points");
  self setplayerdata("cp", "CPSession", "skill_points", var_1 + var_0);
}

function take_skill_points(var_0) {
  var_1 = self getplayerdata("cp", "CPSession", "skill_points");
  self setplayerdata("cp", "CPSession", "skill_points", var_1 - var_0);
}

function giveskillpointsthruluinotify(var_0) {
  var_1 = self getplayerdata("cp", "CPSession", "skill_level", var_0);
  var_2 = self.skill_names[var_0 - 1];
  add_skill_point_to_skill(var_2, 1);
}

function set_class_playerdata(var_0) {
  switch (var_0) {
    case "assault":
      var_1 = 1;
      break;
    case "tank":
      var_1 = 2;
      break;
    case "medic":
      var_1 = 3;
      break;
    case "hunter":
      var_1 = 4;
      break;
    default:
      var_1 = 0;
      break;
  }
}

function reload_on_kill() {}

function add_skill_point_to_skill(var_0, var_1) {}

function debug_give_class(var_0) {
  give_player_class(var_0);
}

function return_wbk_version_of_weapon(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");

  if(!istrue(var_0.weaponkitinitialized)) {
    var_0 waittill("player_weapon_build_kit_initialized");
  }

  if(isDefined(var_0.weapon_build_models[var_1])) {
    return asmdevgetallstates(var_0.weapon_build_models[var_1]);
  }

  return var_2;
}