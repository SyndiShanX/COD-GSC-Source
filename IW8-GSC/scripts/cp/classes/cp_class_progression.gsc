/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\classes\cp_class_progression.gsc
*******************************************************/

function class_progression_init() {
  while(!isDefined(level.players)) {
    wait 0.1;
  }
}

function get_player_class(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  var1 = var0 scripts\cp\utility::getplayerdataloadoutgroup();
  var2 = var0 getplayerdata(level.loadoutsgroup, "squadMembers", "cpFieldUpgrade");
}

function give_player_class(var0) {
  self notify("giving_class");
  scripts\cp\perks\cp_perks::init_each_perk();
  var1 = scripts\cp\utility::getplayerdataloadoutgroup();
  var2 = scripts\cp\cp_loadout::cac_getloadoutselectedidx();
  var3 = "none";

  if(!scripts\cp\utility::tryingtoleave()) {
    self setviewkickscale(0.5);

    for(var4 = 0; var4 < 3; var4++) {
      var5 = var4;

      if(isDefined(var0)) {
        var6 = scripts\cp\cp_loadout::table_getperk(level.classtablename, var0, var4);
      } else {
        var6 = self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var2, "loadoutPerks", var5);
      }

      if(isDefined(var6)) {
        scripts\cp\utility::giveperk(var6);
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

function ref_12bc2() {
  scripts\cp\utility::takeperk("specialty_fastreload");
}

function give_crusader_class() {
  self.class = "crusader";
}

function ref_12bc8() {}

function wait_and_give_perk(var0, var1) {
  wait var1;
  scripts\cp\utility::giveperk(var0);
}

function give_tank_class() {
  self.class = "tank";
  screenent();
}

function screenent() {
  var0 = self getcurrentweapon();

  if(scripts\cp\cp_weapon::is_launcher(var0) && !scripts\cp\cp_weapon::is_killstreak_weapon(var0)) {
    var0 = scripts\cp\cp_weapon::add_launcher_xmags(var0);
    return;
  }
}

function ref_12bf8() {
  var0 = self getcurrentweapon();

  if(scripts\cp\cp_weapon::is_launcher(var0) && !scripts\cp\cp_weapon::is_killstreak_weapon(var0)) {
    var1 = self getweaponammoclip(var0);
    var2 = self getweaponammostock(var0);
    var0 = scripts\cp\cp_weapon::ref_12bda(var0);
    self setweaponammoclip(var0, var1);
    self setweaponammostock(var0, var2);
    return;
  }
}

function give_medic_class() {
  self.class = "medic";
}

function ref_12bde() {}

function give_hunter_class() {
  self.class = "hunter";
  scripts\cp\perks\cp_perks::reduce_recoil();
}

function ref_12bd5() {
  scripts\cp\perks\cp_perks::ref_12bee();
}

function give_engineer_class() {
  self.class = "engineer";
}

function ref_12bca() {}

function give_default_class() {
  var0 = scripts\engine\utility::random(["medic", "tank", "crusader", "assault", "hunter", "engineer"]);

  switch (var0) {
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
  var0 = self;
  var0 setplayerdata("cp", "CPSession", "skill_level", 1, 0);
  var0 setplayerdata("cp", "CPSession", "skill_level", 2, 0);
  var0 setplayerdata("cp", "CPSession", "skill_level", 3, 0);
  var0 setplayerdata("cp", "CPSession", "skill_level", 4, 0);
  var0 setplayerdata("cp", "CPSession", "skill_points", 0);
}

function randomize_player_sessiondata() {
  foreach(var1 in level.players) {
    var1 setplayerdata("cp", "CPSession", "skill_level", 1, randomint(5));
    var1 setplayerdata("cp", "CPSession", "skill_level", 2, randomint(5));
    var1 setplayerdata("cp", "CPSession", "skill_level", 3, randomint(5));
    var1 setplayerdata("cp", "CPSession", "skill_level", 4, randomint(5));
  }
}

function give_skill_points(var0) {
  var1 = self getplayerdata("cp", "CPSession", "skill_points");
  self setplayerdata("cp", "CPSession", "skill_points", var1 + var0);
}

function take_skill_points(var0) {
  var1 = self getplayerdata("cp", "CPSession", "skill_points");
  self setplayerdata("cp", "CPSession", "skill_points", var1 - var0);
}

function giveskillpointsthruluinotify(var0) {
  var1 = self getplayerdata("cp", "CPSession", "skill_level", var0);
  var2 = self.skill_names[var0 - 1];
  add_skill_point_to_skill(var2, 1);
}

function set_class_playerdata(var0) {
  switch (var0) {
    case "assault":
      var1 = 1;
      break;
    case "tank":
      var1 = 2;
      break;
    case "medic":
      var1 = 3;
      break;
    case "hunter":
      var1 = 4;
      break;
    default:
      var1 = 0;
      break;
  }
}

function reload_on_kill() {}

function add_skill_point_to_skill(var0, var1) {}

function debug_give_class(var0) {
  give_player_class(var0);
}

function return_wbk_version_of_weapon(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("disconnect");

  if(!istrue(var0.weaponkitinitialized)) {
    var0 waittill("player_weapon_build_kit_initialized");
  }

  if(isDefined(var0.weapon_build_models[var1])) {
    return asmdevgetallstates(var0.weapon_build_models[var1]);
  }

  return var2;
}