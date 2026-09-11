/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\callback_group.gsc
****************************************************/

function init() {
  level.ref_12312 = spawnStruct();
  level.ref_12312.ref_12308 = [(-289, -1790, 58), (-2055, -2255, 73), (152, 3486, 110)];
  level.ref_12312.petconsts = [];
  level.ref_12312.ref_12311 = [];
  level.ref_12312.ref_126a3 = [];
  level.ref_12312.players = [];
  level.ref_12312.modular_spawning_vehicles = [(1902, -2401, 58)];
  level.ref_12312.modsforvehicle = [3, 2, 1];
  level.ref_12312.module_call_counter = [];
  var_0 = [];

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow("mp/petWatchGoTable.csv", var_1, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_2 = int(var_2);
    var_3 = spawnStruct();
    var_3.rarity = int(tablelookupbyrow("mp/petWatchGoTable.csv", var_1, 2));
    var_3.ref_11e79 = int(tablelookupbyrow("mp/petWatchGoTable.csv", var_1, 3));
    var_3.ref_14679 = int(tablelookupbyrow("mp/petWatchGoTable.csv", var_1, 4));
    var_3.getcargotruckspawns = int(tablelookupbyrow("mp/petWatchGoTable.csv", var_1, 5));
    var_3.showsplashtoall = int(tablelookupbyrow("mp/petWatchGoTable.csv", var_1, 8));
    var_3.change_goal_radius_weapons_free_internal = int(tablelookupbyrow("mp/petWatchGoTable.csv", var_1, 8));
    level.ref_12312.petconsts[var_2] = var_3;

    for(var_4 = 0; var_4 < var_3.rarity; var_4++) {
      var_0 = var_2;
    }
  }

  var_5 = 3;

  for(var_1 = 0; var_1 < var_5; var_1++) {
    var_6 = level.ref_12312.ref_12308[var_1];
    var_7 = randomintrange(0, var_0.size);
    var_8 = var_0[var_7];
    level.ref_12312.ref_12311[var_1] = var_8;
    level.ref_12312.ref_126a3[var_1] = [];
  }

  thread select_patrol_eight_spawners();
}

function initpet(var_0) {
  if(!isDefined(self.ref_12313)) {
    self.ref_12313 = spawnStruct();
    self.ref_12313.nuke_core_tug_of_war = [];
    self.ref_12313.ref_1230f = [1, 2, 3];
    self.ref_12313.insidecuavbunker = 0;
    self.ref_12313.ref_12310 = self.ref_12313.ref_1230f[self.ref_12313.insidecuavbunker];
    level.ref_12312.players[level.ref_12312.players.size] = self;
  }

  thread select_stadium_two_spawners();
  self setclientomnvar("ui_pet_watch_bonus_earned_0", self.ref_12313.ref_12310);
  self setscriptablepartstate("watchVFXPlayer", "goWatchOn");
}

function select_patrol_eight_spawners() {
  level endon("game_ended");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    var_2 = level.ref_12312.ref_12308[var_0];
    var_3 = level.ref_12312.ref_12311[var_0];

    if(var_3 > 0) {
      var_4 = scripts\common\utility::playersnear(var_2, 1500);

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_6 = var_4[var_5];

        if(isDefined(var_6) && isalive(var_6) && isDefined(var_6.ref_12313)) {
          var_1 = level.ref_12312.ref_126a3[var_0].size;
          level.ref_12312.ref_126a3[var_0][var_1] = var_6;
          ref_12605(var_6, var_3, var_0, var_2);
        }
      }
    }

    var_0++;

    if(var_0 >= level.ref_12312.ref_12308.size) {
      var_0 = 0;
    }

    var_7 = level.ref_12312.players[var_1];

    if(isDefined(var_7) && isalive(var_7)) {
      if(var_7.ref_12313.nuke_core_tug_of_war.size == 0) {
        var_5 = 0;

        while(var_5 < level.ref_12312.players.size) {
          var_10 = level.ref_12312.players[var_5];

          if(var_7 != var_10 && isalive(var_10) && isDefined(var_10.ref_12313)) {
            var_9 = distancesquared(var_7.origin, var_10.origin);

            if(var_9 < 1000000) {
              nuke_killplayer(var_7, var_10);
              break;
            }
          }

          var_7++;
        }
      } else {
        for(var_5 = 0; var_5 < var_7.ref_12313.nuke_core_tug_of_war.size; var_5++) {
          var_11 = var_7.ref_12313.nuke_core_tug_of_war[var_5];
          var_9 = distancesquared(var_7.origin, var_11.origin);

          if(var_9 > 4000000) {
            lock_player_stance(var_7, var_11);
            break;
          }
        }
      }
    }

    var_1++;

    if(var_1 >= level.ref_12312.players.size) {
      var_1 = 0;
    }

    waitframe();
  }
}

function onplayerkilled(var_0) {
  for(var_1 = 0; var_1 < self.ref_12313.nuke_core_tug_of_war.size; var_1++) {
    var_2 = self.ref_12313.nuke_core_tug_of_war[var_1];
    ref_12f13(var_2, self);
  }

  self.ref_12313.nuke_core_tug_of_war = [];
}

function ref_12f13(var_0) {
  self.ref_12313.nuke_core_tug_of_war = scripts\engine\utility::array_remove(self.ref_12313.nuke_core_tug_of_war, var_0);
  self iprintlnbold(" OPPONENT DIED ");
  self setclientomnvar("ui_pet_watch_action", 16);
  var_0 setclientomnvar("ui_pet_watch_action", 17);
}

function lock_player_stance(var_0) {
  self.ref_12313.nuke_core_tug_of_war = scripts\engine\utility::array_remove(self.ref_12313.nuke_core_tug_of_war, var_0);

  if(self.ref_12313.nuke_core_tug_of_war.size > 0) {
    for(var_1 = 0; var_1 < self.ref_12313.nuke_core_tug_of_war.size; var_1++) {
      var_2 = self.ref_12313.nuke_core_tug_of_war[var_1];

      if(isDefined(var_2) && isalive(var_2)) {
        nuke_killplayer(var_2);
        return;
      }
    }
  }

  self setclientomnvar("ui_pet_watch_bonus_earned_1", 1);
}

function nuke_killplayer(var_0) {
  self.ref_12313.nuke_core_tug_of_war[self.ref_12313.nuke_core_tug_of_war.size] = var_0;
  self iprintlnbold("ENGAGE WITH ENEMY ");
  self setclientomnvar("ui_pet_watch_bonus_earned_0", var_0.ref_12313.ref_12310 + 100);
  self setclientomnvar("ui_pet_watch_bonus_earned_1", 2);
}

function nuke_hostmigration_waittillhostmigrationdone(var_0) {
  var_1 = level.ref_12312.modular_spawning_vehicles[var_0];
  var_2 = level.ref_12312.modsforvehicle[var_0];
  var_3 = level.ref_12312.module_call_counter[var_0];
  self.ref_12313.nuke_core_tug_of_war[self.ref_12313.nuke_core_tug_of_war.size] = var_3;
  self iprintlnbold("ENGAGE WITH DUMMY ");
  self setclientomnvar("ui_pet_watch_bonus_earned_0", var_2 + 100);
  self setclientomnvar("ui_pet_watch_bonus_earned_1", 2);
}

function ref_144e1() {
  if(self.ref_12313.nuke_core_tug_of_war.size > 0) {
    self.ref_12313.insidecuavbunker++;

    if(self.ref_12313.insidecuavbunker >= self.ref_12313.ref_1230f.size) {
      self.ref_12313.insidecuavbunker = 0;
    }

    self.ref_12313.ref_12310 = self.ref_12313.ref_1230f[self.ref_12313.insidecuavbunker];
    level.ref_12312.players[level.ref_12312.players.size] = self;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", self.ref_12313.ref_12310);
    return;
  }

  if(isDefined(self.ref_12313.wam_pointer)) {
    var_0 = level.ref_12312.ref_12311[self.ref_12313.wam_pointer];

    if(var_0 > 0) {
      lower_door_coll(self.ref_12313.wam_pointer);
      return;
    }

    return;
  }
}

function lower_door_coll(var_0) {
  var_1 = level.ref_12312.ref_12311[var_0];
  level.ref_12312.ref_12311[var_0] = 0;
  self setclientomnvar("ui_pet_watch_action", var_1);
}

function ref_12605(var_0, var_1, var_2) {
  var_3 = int(distance(self.origin, var_2)) * 100;
  var_4 = int(min(var_3, 900000));
  var_5 = vectorNormalize(var_2 - self.origin);
  var_6 = vectortoangles(var_5);
  var_7 = var_6[1] - self.angles[1];

  if(var_7 < 0) {
    var_7 += 360;
  } else if(var_7 > 360) {
    var_7 -= 360;
  }

  self.ref_12313.wam_pointer = var_1;
  var_8 = int(var_7 / 10) + var_4;
  self setclientomnvar("ui_pet_watch_state", var_8);
}

function level_create_timer() {}

function select_stadium_two_spawners() {
  self endon("disconnect");
  self notify("goPetChallengeWatcher()");
  self endon("goPetChallengeWatcher()");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "petwatch_go_charm") {
      switch (var_1) {}

      continue;
    }

    if(var_0 == "petwatch_turbo_state") {}
  }
}