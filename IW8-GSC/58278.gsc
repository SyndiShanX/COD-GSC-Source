/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58278.gsc
***********************************************/

function init() {
  level.ref_12838 = spawnStruct();
  level.ref_12838.area1_targets = [];
  level.ref_12838.applyquest = [];
  scripts\engine\scriptable::scriptable_addusedcallback(&scriptable_used);
  scripts\engine\scriptable::ref_12F57(&scriptable_used);
  thread ref_12832();
}

function ref_12832() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);
    thread ref_13F7E(var_0, undefined, 0);
  }
}

function scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_0.type)) {
    switch (var_0.type) {
      case "brloot_rumble_powerup_killmonger":
        ref_12833(var_3, "killmonger", var_0);
        break;
      case "brloot_rumble_powerup_speed_boost":
        ref_12833(var_3, "speed_boost", var_0);
        break;
      case "brloot_rumble_powerup_double_points":
        ref_12833(var_3, "double_points", var_0);
        break;
      case "brloot_rumble_powerup_field_resupply":
        ref_12833(var_3, "field_resupply", var_0);
        break;
      case "brloot_plunder_cash_uncommon_1":
        if(!isDefined(var_3.ref_12827) || !var_3.ref_12827) {
          return;
        }

        var_5 = 5;
        var_3 scripts\mp\gametypes\br_plunder::ref_12627(int(var_5));
        break;
    }

    return;
  }
}

function ref_12833(var_0, var_1) {
  thread ref_1393A(var_0);
  scripts\cp\vehicles\little_bird_mg_cp::addedcollision();
  var_1 freescriptable();
  thread ref_1282F();
}

function ref_12AF4(var_0) {
  level.ref_12838.area1_targets[var_0.ref_138FD] = var_0;
  level.ref_12838.applyquest[var_0.ref_138FD] = [];
}

function race_monitor_out_of_vehicle(var_0) {
  if(!cargo_truck_mg_cp_createfromstructs(var_0)) {
    return;
  }

  return level.ref_12838.area1_targets[var_0];
}

function ref_1393A(var_0) {
  if(!cargo_truck_mg_cp_createfromstructs(var_0)) {
    return 0;
  }

  var_1 = 0;
  var_2 = getdvarint("scr_brPowerups_allow_multiple_active_powerups", 1);

  if(isDefined(self.are_players_nearby_turret) && self.are_players_nearby_turret.size > 0) {
    foreach(var_4 in self.are_players_nearby_turret) {
      if(var_5 == var_0) {
        var_1 = 1;

        if(isDefined(var_4.ref_12E2D.ref_12A35)) {
          var_4[[var_4.ref_12E2D.ref_12A35]]();
        }

        continue;
      }

      if(!var_2) {
        if(isDefined(var_4.ref_12E2D.isdisconnecting)) {
          var_4[[var_4.ref_12E2D.isdisconnecting]]();
        }
      }
    }
  }

  if(!var_1) {
    assignvehiclestoteams(var_0);
    return;
  }
}

function assignvehiclestoteams(var_0) {
  var_1 = init_internal(var_0);
  level.ref_12838.applyquest[var_0] = scripts\engine\utility::array_add(level.ref_12838.applyquest[var_0], self);
  var_2 = race_monitor_vehicle(var_0);

  if(isDefined(var_1.ref_12E2D.parachute_get_path)) {
    thread ref_13F7E(int(var_1.ref_12E2D.parachute_get_path), var_2, 1);
  }

  if(isDefined(var_1.ref_12E2D.asm_playfacialanim_mp)) {
    var_1 thread[[var_1.ref_12E2D.asm_playfacialanim_mp]]();
  }

  if(isDefined(var_1.ref_12E2D.parachute_get_path)) {
    thread ref_1449F();
    return;
  }

  waitframe();
  thread isempdamage();
}

function ref_1449F() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_powerup");
  self.player endon("disconnect");
  thread moveplayertotoppos();

  if(isDefined(self.ref_12E2D.ref_1449E)) {
    self thread[[self.ref_12E2D.ref_1449E]]();
  }

  while(gettime() < self.mp_layover_patch) {
    waitframe();
  }

  thread isempdamage();
}

function moveplayertotoppos() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_powerup");
  self.player endon("disconnect");
  self.player scripts\engine\utility::ref_143A6("death", "joined_team", "joined_spectators");
  thread isempdamage();
}

function isempdamage() {
  self.player endon("disconnect");
  var_0 = self.ref_12E2D.ref_138FD;
  ref_13F73(var_0);
  var_1 = race_monitor_vehicle(var_0);

  if(isDefined(self.ref_12E2D.parachute_get_path)) {
    thread ref_13F7E(self.player, undefined, var_1);
  }

  if(isDefined(self.ref_12E2D.isdeathshieldskippingenabled)) {
    self thread[[self.ref_12E2D.isdeathshieldskippingenabled]]();
  }

  self notify("stop_powerup");
}

function ref_13F73(var_0) {
  if(!cargo_truck_mg_cp_createfromstructs(var_0)) {
    return 0;
  }

  lbravo_actorthinkpath(self.player);

  if(scripts\engine\utility::array_contains(level.ref_12838.applyquest[var_0], self.player)) {
    level.ref_12838.applyquest[var_0] = scripts\engine\utility::array_remove(level.ref_12838.applyquest[var_0], self.player);
    return;
  }
}

function init_internal(var_0) {
  var_1 = spawnStruct();
  var_1.ref_12E2D = race_monitor_out_of_vehicle(var_0);
  var_1.player = self;
  var_1.team = self.team;
  var_1.ref_13AB1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1.squadleaderbeacon_isactive = [];
  var_1.ref_1381C = gettime();

  if(isDefined(var_1.ref_12E2D.parachute_get_path)) {
    var_1.mp_layover_patch = gettime() + var_1.ref_12E2D.parachute_get_path * 1000;
  }

  carriable_pickup_wait(var_1, var_1.player);
  return var_1;
}

function carriable_pickup_wait(var_0) {
  if(!isDefined(var_0.are_players_nearby_turret)) {
    var_0.are_players_nearby_turret = [];
  }

  var_0.are_players_nearby_turret[self.ref_12E2D.ref_138FD] = self;
}

function lbravo_actorthinkpath(var_0) {
  if(!isDefined(var_0.are_players_nearby_turret) || !isDefined(var_0.are_players_nearby_turret[self.ref_12E2D.ref_138FD])) {
    return;
  }

  var_0.are_players_nearby_turret[self.ref_12E2D.ref_138FD] = undefined;
}

function ref_124DD(var_0) {
  if(scripts\engine\utility::array_contains(level.ref_12838.applyquest[var_0], self)) {
    return true;
  }

  return false;
}

function ref_1249C(var_0) {
  if(!ref_124DD(var_0)) {
    return;
  }

  if(!isDefined(self.are_players_nearby_turret)) {
    return;
  }

  return self.are_players_nearby_turret[var_0];
}

function cargo_truck_mg_cp_createfromstructs(var_0) {
  var_1 = scripts\engine\utility::array_contains_key(level.ref_12838.area1_targets, var_0);

  if(isDefined(level.ref_12838.area1_targets) && var_1) {
    return 1;
  }

  return 0;
}

function ref_12426(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(self.team == "axis", "allies", "axis");
  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = spawnStruct();
    var_4.intvar = var_2;
  }

  var_5 = self.team;
  var_5 = scripts\engine\utility::array_remove(var_5, self);

  foreach(var_7 in var_5) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var_7, var_0, var_4);
  }
}

function ref_12425(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  scripts\mp\gametypes\br_quest_util::displayplayersplash(var_0, var_1, var_3);
}

function ref_13F7E(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0)) {
    if(isfloat(var_0)) {
      var_0 = int(var_0);
    }

    var_3 += var_0 * 100;
  }

  if(isDefined(var_1)) {
    var_3 += var_1 * 10;
  }

  if(isDefined(var_2)) {
    var_3 += var_2;
  }

  self setclientomnvar("ui_br_bodycount_reward_data", var_3);
}

function modify_juggernaut_damage(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 100;
  }

  var_2 = randomintrange(1, 101);

  if(var_1 < var_2) {
    return;
  }

  var_3 = ref_1233D();
  var_4 = "brloot_rumble_powerup_" + var_3;

  if(!isent(self) || self isscriptable()) {
    var_5 = 35;
    var_6 = 75;
    var_6 += randomfloatrange(-10, 10);
    var_7 = var_5 + 55 + randomfloatrange(-5, 5);
    var_8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_0, self.origin, self.angles, undefined, var_6, var_7);
  } else {
    var_8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  }

  scripts\mp\gametypes\br_pickups::spawnpickup(var_8, var_8, 1, 1);
}

function script_model_spawn_and_use_logic() {
  var_0 = ref_1233D();
  var_1 = "brloot_rumble_powerup_" + var_0;
  thread ref_1393A(var_0);
}

function ref_1233D() {
  var_0 = [];

  foreach(var_2 in level.ref_12838.area1_targets) {
    var_0 = var_3;
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);
  return var_0[0];
}

function ref_1282F() {
  if(level.disable_super_in_turret.name == "rumble") {
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
  }

  if(scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }

  if(level.disable_super_in_turret.name == "rumble") {
    self.health = self.maxhealth;
    scripts\mp\healthoverlay::onexitdeathsdoor(1);
    self.br_armorhealth = self.br_maxarmorhealth;
    self setclientomnvar("ui_br_armor_damage", 1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    thread ref_12CCB();
    return;
  }
}

function ref_12CCB() {
  self endon("death_or_disconnect");
  thread scripts\mp\equipment::givescavengerammo();
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

function race_monitor_vehicle(var_0) {
  switch (var_0) {
    case "double_points":
      return 1;
    case "killmonger":
      return 3;
    case "speed_boost":
      return 4;
  }
}