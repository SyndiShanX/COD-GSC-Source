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
  var0 = [];

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow("mp/petWatchGoTable.csv", var1, 1);

    if(!isDefined(var2) || var2 == "") {
      break;
    }

    var2 = int(var2);
    var3 = spawnStruct();
    var3.rarity = int(tablelookupbyrow("mp/petWatchGoTable.csv", var1, 2));
    var3.ref_11e79 = int(tablelookupbyrow("mp/petWatchGoTable.csv", var1, 3));
    var3.ref_14679 = int(tablelookupbyrow("mp/petWatchGoTable.csv", var1, 4));
    var3.getcargotruckspawns = int(tablelookupbyrow("mp/petWatchGoTable.csv", var1, 5));
    var3.showsplashtoall = int(tablelookupbyrow("mp/petWatchGoTable.csv", var1, 8));
    var3.change_goal_radius_weapons_free_internal = int(tablelookupbyrow("mp/petWatchGoTable.csv", var1, 8));
    level.ref_12312.petconsts[var2] = var3;

    for(var4 = 0; var4 < var3.rarity; var4++) {
      var0 = var2;
    }
  }

  var5 = 3;

  for(var1 = 0; var1 < var5; var1++) {
    var6 = level.ref_12312.ref_12308[var1];
    var7 = randomintrange(0, var0.size);
    var8 = var0[var7];
    level.ref_12312.ref_12311[var1] = var8;
    level.ref_12312.ref_126a3[var1] = [];
  }

  thread select_patrol_eight_spawners();
}

function initpet(var0) {
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
  var0 = 0;
  var1 = 0;

  for(;;) {
    var2 = level.ref_12312.ref_12308[var0];
    var3 = level.ref_12312.ref_12311[var0];

    if(var3 > 0) {
      var4 = scripts\common\utility::playersnear(var2, 1500);

      for(var5 = 0; var5 < var4.size; var5++) {
        var6 = var4[var5];

        if(isDefined(var6) && isalive(var6) && isDefined(var6.ref_12313)) {
          var1 = level.ref_12312.ref_126a3[var0].size;
          level.ref_12312.ref_126a3[var0][var1] = var6;
          ref_12605(var6, var3, var0, var2);
        }
      }
    }

    var0++;

    if(var0 >= level.ref_12312.ref_12308.size) {
      var0 = 0;
    }

    var7 = level.ref_12312.players[var1];

    if(isDefined(var7) && isalive(var7)) {
      if(var7.ref_12313.nuke_core_tug_of_war.size == 0) {
        var5 = 0;

        while(var5 < level.ref_12312.players.size) {
          var10 = level.ref_12312.players[var5];

          if(var7 != var10 && isalive(var10) && isDefined(var10.ref_12313)) {
            var9 = distancesquared(var7.origin, var10.origin);

            if(var9 < 1000000) {
              nuke_killplayer(var7, var10);
              break;
            }
          }

          var7++;
        }
      } else {
        for(var5 = 0; var5 < var7.ref_12313.nuke_core_tug_of_war.size; var5++) {
          var11 = var7.ref_12313.nuke_core_tug_of_war[var5];
          var9 = distancesquared(var7.origin, var11.origin);

          if(var9 > 4000000) {
            lock_player_stance(var7, var11);
            break;
          }
        }
      }
    }

    var1++;

    if(var1 >= level.ref_12312.players.size) {
      var1 = 0;
    }

    waitframe();
  }
}

function onplayerkilled(var0) {
  for(var1 = 0; var1 < self.ref_12313.nuke_core_tug_of_war.size; var1++) {
    var2 = self.ref_12313.nuke_core_tug_of_war[var1];
    ref_12f13(var2, self);
  }

  self.ref_12313.nuke_core_tug_of_war = [];
}

function ref_12f13(var0) {
  self.ref_12313.nuke_core_tug_of_war = scripts\engine\utility::array_remove(self.ref_12313.nuke_core_tug_of_war, var0);
  self iprintlnbold(" OPPONENT DIED ");
  self setclientomnvar("ui_pet_watch_action", 16);
  var0 setclientomnvar("ui_pet_watch_action", 17);
}

function lock_player_stance(var0) {
  self.ref_12313.nuke_core_tug_of_war = scripts\engine\utility::array_remove(self.ref_12313.nuke_core_tug_of_war, var0);

  if(self.ref_12313.nuke_core_tug_of_war.size > 0) {
    for(var1 = 0; var1 < self.ref_12313.nuke_core_tug_of_war.size; var1++) {
      var2 = self.ref_12313.nuke_core_tug_of_war[var1];

      if(isDefined(var2) && isalive(var2)) {
        nuke_killplayer(var2);
        return;
      }
    }
  }

  self setclientomnvar("ui_pet_watch_bonus_earned_1", 1);
}

function nuke_killplayer(var0) {
  self.ref_12313.nuke_core_tug_of_war[self.ref_12313.nuke_core_tug_of_war.size] = var0;
  self iprintlnbold("ENGAGE WITH ENEMY ");
  self setclientomnvar("ui_pet_watch_bonus_earned_0", var0.ref_12313.ref_12310 + 100);
  self setclientomnvar("ui_pet_watch_bonus_earned_1", 2);
}

function nuke_hostmigration_waittillhostmigrationdone(var0) {
  var1 = level.ref_12312.modular_spawning_vehicles[var0];
  var2 = level.ref_12312.modsforvehicle[var0];
  var3 = level.ref_12312.module_call_counter[var0];
  self.ref_12313.nuke_core_tug_of_war[self.ref_12313.nuke_core_tug_of_war.size] = var3;
  self iprintlnbold("ENGAGE WITH DUMMY ");
  self setclientomnvar("ui_pet_watch_bonus_earned_0", var2 + 100);
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
    var0 = level.ref_12312.ref_12311[self.ref_12313.wam_pointer];

    if(var0 > 0) {
      lower_door_coll(self.ref_12313.wam_pointer);
      return;
    }

    return;
  }
}

function lower_door_coll(var0) {
  var1 = level.ref_12312.ref_12311[var0];
  level.ref_12312.ref_12311[var0] = 0;
  self setclientomnvar("ui_pet_watch_action", var1);
}

function ref_12605(var0, var1, var2) {
  var3 = int(distance(self.origin, var2)) * 100;
  var4 = int(min(var3, 900000));
  var5 = vectorNormalize(var2 - self.origin);
  var6 = vectortoangles(var5);
  var7 = var6[1] - self.angles[1];

  if(var7 < 0) {
    var7 += 360;
  } else if(var7 > 360) {
    var7 -= 360;
  }

  self.ref_12313.wam_pointer = var1;
  var8 = int(var7 / 10) + var4;
  self setclientomnvar("ui_pet_watch_state", var8);
}

function level_create_timer() {}

function select_stadium_two_spawners() {
  self endon("disconnect");
  self notify("goPetChallengeWatcher()");
  self endon("goPetChallengeWatcher()");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "petwatch_go_charm") {
      switch (var1) {}

      continue;
    }

    if(var0 == "petwatch_turbo_state") {}
  }
}