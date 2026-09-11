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

  for(var0 = 0;; var0++) {
    waitframe();
    logplayers(var0);
  }
}

function cinematicreplay_scriptdata_openfilewrite() {}

function cinematicreplayrecording_scriptdata_dump() {}

function onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var0);
    var0.shotrecord = [];
    var0.hitrecord = [];
    thread watchweaponusage();
  }
}

function watchweaponusage(var0) {
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var1);
    var2 = spawnStruct();
    var2.vpoint = self.origin;
    var2.vdir = self getgunangles();
    self.shotrecord[self.shotrecord.size] = var2;
  }
}

function logplayers(var0) {
  var1 = level.players;
  var2 = [];
  var3 = gettime();
  var4 = "";

  if(var1.size == 0) {
    return;
  }

  var5 = int(4);
  var6 = int(ceil(var1.size / var5));
  var7 = int(var0 % var6);

  for(var8 = 0; var8 < var5; var8++) {
    var9 = var7 * var5 + var8;

    if(var9 >= var1.size) {
      break;
    }

    var10 = var1[var9];

    if(isDefined(var10) && scripts\mp\utility\player::isreallyalive(var10)) {
      var4 += "T " + var10 getentitynumber() + " " + var10.team + " ";
      var11 = int(var10.origin[0]) + "," + int(var10.origin[1]) + "," + int(var10.origin[2]);
      var12 = int(var10.angles[0]) + "," + int(var10.angles[1]) + "," + int(var10.angles[2]);
      var2 = "P " + var3 + " " + var10 getentitynumber() + " " + var11 + " " + var12 + " ";

      if(isDefined(var10.hitrecord)) {
        foreach(var14 in var10.hitrecord) {
          var15 = int(var14.vpoint[0]) + "," + int(var14.vpoint[1]) + "," + int(var14.vpoint[2]);
          var16 = int(var14.vdir[0]) + "," + int(var14.vdir[1]) + "," + int(var14.vdir[2]);
          var2 = var2[var2.size - 1] + "H " + var3 + " " + var10 getentitynumber() + " " + var14.victim getentitynumber() + " " + var15 + " " + var16 + " " + var14.kill + " ";
        }

        var10.hitrecord = [];
      }

      if(isDefined(var10.shotrecord)) {
        foreach(var19 in var10.shotrecord) {
          var15 = int(var19.vpoint[0]) + "," + int(var19.vpoint[1]) + "," + int(var19.vpoint[2]);
          var16 = int(var19.vdir[0]) + "," + int(var19.vdir[1]) + "," + int(var19.vdir[2]);
          var2 = var2[var2.size - 1] + "S " + var3 + " " + var10 getentitynumber() + " " + var15 + " " + var16 + " ";
        }

        var10.shotrecord = [];
      }

      var2 = var2[var2.size - 1] + "\n";
      level.cinematicreplaystrings[level.cinematicreplaystrings.size] = var2[var2.size - 1];
    }
  }

  if(level.cinematicreplaystrings.size > 50) {
    var21 = var4;

    foreach(var23 in level.cinematicreplaystrings) {
      var21 += var23;
    }

    level.cinematicreplaystrings = [];
    level.cinematicreplaystringsconcat[level.cinematicreplaystringsconcat.size] = var21;
    return;
  }
}