/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\cinematic_replays\cinematic_replays.gsc
**************************************************************/

function listenforcinematicreplaydumpcmd() {
  level endon("game_ended");
  level.cinematic_replay_recording = 1;
  level.cinematicreplaystrings = [];
  level.cinematicreplaystringsconcat = [];
  thread onplayerspawned();
  thread recordplayerlogs();
  thread dumplogsloop();
}

function dumplogsloop() {
  level endon("game_ended");

  for(;;) {
    wait 1;
    cinematicreplayrecording_scriptdata_dump();
    level.cinematicreplaystringsconcat = [];
  }
}

function recordplayerlogs() {
  level endon("game_ended");

  for(var_0 = 0;; var_0++) {
    waitframe();
    logplayers(var_0);
  }
}

function cinematicreplay_scriptdata_openfilewrite() {}

function cinematicreplayrecording_scriptdata_dump() {}

function onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0.shotrecord = [];
    var_0.hitrecord = [];
    thread watchweaponusage();
  }
}

function watchweaponusage(var_0) {
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_1);
    var_2 = spawnStruct();
    var_2.vpoint = self.origin;
    var_2.vdir = self getgunangles();
    self.shotrecord[self.shotrecord.size] = var_2;
  }
}

function logplayers(var_0) {
  var_1 = level.players;
  var_2 = [];
  var_3 = gettime();
  var_4 = "";

  if(var_1.size == 0) {
    return;
  }

  var_5 = int(4);
  var_6 = int(ceil(var_1.size / var_5));
  var_7 = int(var_0 % var_6);

  for(var_8 = 0; var_8 < var_5; var_8++) {
    var_9 = var_7 * var_5 + var_8;

    if(var_9 >= var_1.size) {
      break;
    }

    var_10 = var_1[var_9];

    if(isDefined(var_10) && scripts\mp\utility\player::isreallyalive(var_10)) {
      var_4 += "T " + var_10 getentitynumber() + " " + var_10.team + " ";
      var_11 = int(var_10.origin[0]) + "," + int(var_10.origin[1]) + "," + int(var_10.origin[2]);
      var_12 = int(var_10.angles[0]) + "," + int(var_10.angles[1]) + "," + int(var_10.angles[2]);
      var_2 = "P " + var_3 + " " + var_10 getentitynumber() + " " + var_11 + " " + var_12 + " ";

      if(isDefined(var_10.hitrecord)) {
        foreach(var_14 in var_10.hitrecord) {
          var_15 = int(var_14.vpoint[0]) + "," + int(var_14.vpoint[1]) + "," + int(var_14.vpoint[2]);
          var_16 = int(var_14.vdir[0]) + "," + int(var_14.vdir[1]) + "," + int(var_14.vdir[2]);
          var_2 = var_2[var_2.size - 1] + "H " + var_3 + " " + var_10 getentitynumber() + " " + var_14.victim getentitynumber() + " " + var_15 + " " + var_16 + " " + var_14.kill + " ";
        }

        var_10.hitrecord = [];
      }

      if(isDefined(var_10.shotrecord)) {
        foreach(var_19 in var_10.shotrecord) {
          var_15 = int(var_19.vpoint[0]) + "," + int(var_19.vpoint[1]) + "," + int(var_19.vpoint[2]);
          var_16 = int(var_19.vdir[0]) + "," + int(var_19.vdir[1]) + "," + int(var_19.vdir[2]);
          var_2 = var_2[var_2.size - 1] + "S " + var_3 + " " + var_10 getentitynumber() + " " + var_15 + " " + var_16 + " ";
        }

        var_10.shotrecord = [];
      }

      var_2 = var_2[var_2.size - 1] + "\n";
      level.cinematicreplaystrings[level.cinematicreplaystrings.size] = var_2[var_2.size - 1];
    }
  }

  if(level.cinematicreplaystrings.size > 50) {
    var_21 = var_4;

    foreach(var_23 in level.cinematicreplaystrings) {
      var_21 += var_23;
    }

    level.cinematicreplaystrings = [];
    level.cinematicreplaystringsconcat[level.cinematicreplaystringsconcat.size] = var_21;
    return;
  }
}