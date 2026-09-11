/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58278.gsc
***********************************************/

function init() {
  level.ref_12838 = spawnStruct();
  level.ref_12838.area1_targets = [];
  level.ref_12838.applyquest = [];
  scripts\engine\scriptable::scriptable_addusedcallback(&scriptable_used);
  scripts\engine\scriptable::ref_12f57(&scriptable_used);
  thread ref_12832();
}

function ref_12832() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var0);
    thread ref_13f7e(var0, undefined, 0);
  }
}

function scriptable_used(var0, var1, var2, var3, var4) {
  if(isDefined(var0) && isDefined(var0.type)) {
    switch (var0.type) {
      case "brloot_rumble_powerup_killmonger":
        ref_12833(var3, "killmonger", var0);
        break;
      case "brloot_rumble_powerup_speed_boost":
        ref_12833(var3, "speed_boost", var0);
        break;
      case "brloot_rumble_powerup_double_points":
        ref_12833(var3, "double_points", var0);
        break;
      case "brloot_rumble_powerup_field_resupply":
        ref_12833(var3, "field_resupply", var0);
        break;
      case "brloot_plunder_cash_uncommon_1":
        if(!isDefined(var3.ref_12827) || !var3.ref_12827) {
          return;
        }

        var5 = 5;
        var3 scripts\mp\gametypes\br_plunder::ref_12627(int(var5));
        break;
    }

    return;
  }
}

function ref_12833(var0, var1) {
  thread ref_1393a(var0);
  scripts\cp\vehicles\little_bird_mg_cp::addedcollision();
  var1 freescriptable();
  thread ref_1282f();
}

function ref_12af4(var0) {
  level.ref_12838.area1_targets[var0.ref_138fd] = var0;
  level.ref_12838.applyquest[var0.ref_138fd] = [];
}

function race_monitor_out_of_vehicle(var0) {
  if(!cargo_truck_mg_cp_createfromstructs(var0)) {
    return;
  }

  return level.ref_12838.area1_targets[var0];
}

function ref_1393a(var0) {
  if(!cargo_truck_mg_cp_createfromstructs(var0)) {
    return 0;
  }

  var1 = 0;
  var2 = getdvarint("scr_brPowerups_allow_multiple_active_powerups", 1);

  if(isDefined(self.are_players_nearby_turret) && self.are_players_nearby_turret.size > 0) {
    foreach(var4 in self.are_players_nearby_turret) {
      if(var5 == var0) {
        var1 = 1;

        if(isDefined(var4.ref_12e2d.ref_12a35)) {
          var4[[var4.ref_12e2d.ref_12a35]]();
        }

        continue;
      }

      if(!var2) {
        if(isDefined(var4.ref_12e2d.isdisconnecting)) {
          var4[[var4.ref_12e2d.isdisconnecting]]();
        }
      }
    }
  }

  if(!var1) {
    assignvehiclestoteams(var0);
    return;
  }
}

function assignvehiclestoteams(var0) {
  var1 = init_internal(var0);
  level.ref_12838.applyquest[var0] = scripts\engine\utility::array_add(level.ref_12838.applyquest[var0], self);
  var2 = race_monitor_vehicle(var0);

  if(isDefined(var1.ref_12e2d.parachute_get_path)) {
    thread ref_13f7e(int(var1.ref_12e2d.parachute_get_path), var2, 1);
  }

  if(isDefined(var1.ref_12e2d.asm_playfacialanim_mp)) {
    var1 thread[[var1.ref_12e2d.asm_playfacialanim_mp]]();
  }

  if(isDefined(var1.ref_12e2d.parachute_get_path)) {
    thread ref_1449f();
    return;
  }

  waitframe();
  thread isempdamage();
}

function ref_1449f() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_powerup");
  self.player endon("disconnect");
  thread moveplayertotoppos();

  if(isDefined(self.ref_12e2d.ref_1449e)) {
    self thread[[self.ref_12e2d.ref_1449e]]();
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
  self.player scripts\engine\utility::ref_143a6("death", "joined_team", "joined_spectators");
  thread isempdamage();
}

function isempdamage() {
  self.player endon("disconnect");
  var0 = self.ref_12e2d.ref_138fd;
  ref_13f73(var0);
  var1 = race_monitor_vehicle(var0);

  if(isDefined(self.ref_12e2d.parachute_get_path)) {
    thread ref_13f7e(self.player, undefined, var1);
  }

  if(isDefined(self.ref_12e2d.isdeathshieldskippingenabled)) {
    self thread[[self.ref_12e2d.isdeathshieldskippingenabled]]();
  }

  self notify("stop_powerup");
}

function ref_13f73(var0) {
  if(!cargo_truck_mg_cp_createfromstructs(var0)) {
    return 0;
  }

  lbravo_actorthinkpath(self.player);

  if(scripts\engine\utility::array_contains(level.ref_12838.applyquest[var0], self.player)) {
    level.ref_12838.applyquest[var0] = scripts\engine\utility::array_remove(level.ref_12838.applyquest[var0], self.player);
    return;
  }
}

function init_internal(var0) {
  var1 = spawnStruct();
  var1.ref_12e2d = race_monitor_out_of_vehicle(var0);
  var1.player = self;
  var1.team = self.team;
  var1.ref_13ab1 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.origin = self.origin;
  var1.angles = self.angles;
  var1.squadleaderbeacon_isactive = [];
  var1.ref_1381c = gettime();

  if(isDefined(var1.ref_12e2d.parachute_get_path)) {
    var1.mp_layover_patch = gettime() + var1.ref_12e2d.parachute_get_path * 1000;
  }

  carriable_pickup_wait(var1, var1.player);
  return var1;
}

function carriable_pickup_wait(var0) {
  if(!isDefined(var0.are_players_nearby_turret)) {
    var0.are_players_nearby_turret = [];
  }

  var0.are_players_nearby_turret[self.ref_12e2d.ref_138fd] = self;
}

function lbravo_actorthinkpath(var0) {
  if(!isDefined(var0.are_players_nearby_turret) || !isDefined(var0.are_players_nearby_turret[self.ref_12e2d.ref_138fd])) {
    return;
  }

  var0.are_players_nearby_turret[self.ref_12e2d.ref_138fd] = undefined;
}

function ref_124dd(var0) {
  if(scripts\engine\utility::array_contains(level.ref_12838.applyquest[var0], self)) {
    return true;
  }

  return false;
}

function ref_1249c(var0) {
  if(!ref_124dd(var0)) {
    return;
  }

  if(!isDefined(self.are_players_nearby_turret)) {
    return;
  }

  return self.are_players_nearby_turret[var0];
}

function cargo_truck_mg_cp_createfromstructs(var0) {
  var1 = scripts\engine\utility::array_contains_key(level.ref_12838.area1_targets, var0);

  if(isDefined(level.ref_12838.area1_targets) && var1) {
    return 1;
  }

  return 0;
}

function ref_12426(var0, var1, var2) {
  var3 = scripts\engine\utility::ter_op(self.team == "axis", "allies", "axis");
  var4 = undefined;

  if(isDefined(var2)) {
    var4 = spawnStruct();
    var4.intvar = var2;
  }

  var5 = self.team;
  var5 = scripts\engine\utility::array_remove(var5, self);

  foreach(var7 in var5) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var7, var0, var4);
  }
}

function ref_12425(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = spawnStruct();
    var3.intvar = var2;
  }

  scripts\mp\gametypes\br_quest_util::displayplayersplash(var0, var1, var3);
}

function ref_13f7e(var0, var1, var2) {
  var3 = 0;

  if(isDefined(var0)) {
    if(isfloat(var0)) {
      var0 = int(var0);
    }

    var3 += var0 * 100;
  }

  if(isDefined(var1)) {
    var3 += var1 * 10;
  }

  if(isDefined(var2)) {
    var3 += var2;
  }

  self setclientomnvar("ui_br_bodycount_reward_data", var3);
}

function modify_juggernaut_damage(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 100;
  }

  var2 = randomintrange(1, 101);

  if(var1 < var2) {
    return;
  }

  var3 = ref_1233d();
  var4 = "brloot_rumble_powerup_" + var3;

  if(!isent(self) || self isscriptable()) {
    var5 = 35;
    var6 = 75;
    var6 += randomfloatrange(-10, 10);
    var7 = var5 + 55 + randomfloatrange(-5, 5);
    var8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var0, self.origin, self.angles, undefined, var6, var7);
  } else {
    var8 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var1, self.origin, self.angles, self);
  }

  scripts\mp\gametypes\br_pickups::spawnpickup(var8, var8, 1, 1);
}

function script_model_spawn_and_use_logic() {
  var0 = ref_1233d();
  var1 = "brloot_rumble_powerup_" + var0;
  thread ref_1393a(var0);
}

function ref_1233d() {
  var0 = [];

  foreach(var2 in level.ref_12838.area1_targets) {
    var0 = var3;
  }

  var0 = scripts\engine\utility::array_randomize(var0);
  return var0[0];
}

function ref_1282f() {
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
    thread ref_12ccb();
    return;
  }
}

function ref_12ccb() {
  self endon("death_or_disconnect");
  thread scripts\mp\equipment::givescavengerammo();
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

function race_monitor_vehicle(var0) {
  switch (var0) {
    case "double_points":
      return 1;
    case "killmonger":
      return 3;
    case "speed_boost":
      return 4;
  }
}