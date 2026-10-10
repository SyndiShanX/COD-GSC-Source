/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6231da148afb3247.gsc
*************************************************/

#using scripts\common\values;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace warrior_beatupthecar;

function function_1622b20751666c1d() {
  level.var_6298f362ec23d83.var_840ddb112ace54f3 = [];
  level.modeallowmeleevehicledamage = &modeallowmeleevehicledamage;
  level.var_67d87fafb9aebc8e = getStructArray("warrior_car", "targetname");
  thread onplayerspawned();
  thread function_492b4dec632917ec("warrior_beatupthecar");
}

function function_8c0bfe15c3fac89() {
  level.modeallowmeleevehicledamage = undefined;

  foreach(player in level.players) {
    player val::group_reset("beatupthecar");
  }
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    var_2c7733b0cc742f21 = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("jup_jp23_me_shotel_mp");
    player giveweapon(var_2c7733b0cc742f21);
    player setspawnweapon(var_2c7733b0cc742f21);
    player val::set("beatupthecar", "vehicle_use", 0);
    player function_f560b74b0bdcaed6();
  }
}

function function_f560b74b0bdcaed6() {
  if(!istrue(level.var_6298f362ec23d83.var_840ddb112ace54f3[self.team])) {
    spawndata = spawnStruct();

    if(level.var_67d87fafb9aebc8e.size == 3) {
      if(isDefined(self) && isalive(self)) {
        cars = sortbydistance(level.var_67d87fafb9aebc8e, self.origin);
        spawndata.origin = cars[0].origin + (0, 0, 16);
        spawndata.angles = cars[0].angles;
      }
    } else {
      assertmsg("<dev string:x1c>");
    }

    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_suv_1996", spawndata);
    vehicle thread function_f644d0ca00a39fac(self.team);
    vehicle thread function_790fe4a541aaf2e9(self.team);
    level.var_6298f362ec23d83.var_840ddb112ace54f3[self.team] = 1;
  }
}

function function_f644d0ca00a39fac(team) {
  level endon("game_ended");
  level endon("round_end_finished");
  var_c217f255028505d5 = 3.5;

  while(true) {
    self waittill("damage", damage, attacker);

    if(isDefined(attacker) && isDefined(team) && isPlayer(attacker) && attacker.team == team) {
      time = gettime();

      if(!isDefined(attacker.var_fed459309698115d) || (time - attacker.var_fed459309698115d) / 1000 >= var_c217f255028505d5) {
        attacker.var_fed459309698115d = time;
        attacker thread scripts\mp\utility\points::doscoreevent(#"hash_9dc9fc0c7f353a");
      }
    }
  }
}

function function_790fe4a541aaf2e9(team) {
  level endon("warrior_beatupthecar_complete");
  self waittill("death");
  thread scripts\mp\gamelogic::endgame(team, game["end_reason"]["objective_completed"]);
  level notify("warrior_beatupthecar_complete");
}

function function_1d85758902f3471(winner, endreasontext, nukedetonated) {
  setscore = 0;

  if(winner != "tie") {
    scripts\mp\gamescore::giveteamscoreforobjective(winner, 1, 1);
    setscore = 1;
  }

  return setscore;
}

function private modeallowmeleevehicledamage(data) {
  return true;
}

function function_aa09fe28d9f1adc0() {
  if(self.origin[0] == 128 && self.origin[1] == -576 || self.origin[0] == 60 && self.origin[1] == -576) {
    return (0, 200, 0);
  }

  if(self.origin[0] == -980 && self.origin[1] == 196 || self.origin[0] == -980 && self.origin[1] == 264) {
    return (200, 0, 0);
  }

  if(self.origin[0] == 996 && self.origin[1] == 300 || self.origin[0] == 996 && self.origin[1] == 232) {
    return (-200, 0, 0);
  }
}