/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\cinematic_replays\cinematic_replays.gsc
******************************************************/

listenforcinematicreplaydumpcmd() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.cinematic_replay_recording = 1;
  level.cinematicreplaystrings = [];
  level.cinematicreplaystringsconcat = [];
  level thread onplayerspawned();
  level thread recordplayerlogs();
  level thread dumplogsloop();
}

dumplogsloop() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 1;
    cinematicreplayrecording_scriptdata_dump();
    level.cinematicreplaystringsconcat = [];
  }
}

recordplayerlogs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  for(;;) {
    waitframe();
    logplayers(var_0);
    var_0++;
  }
}

cinematicreplay_scriptdata_openfilewrite() {}

cinematicreplayrecording_scriptdata_dump() {}

onplayerspawned() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.shotrecord = [];
    var_0.hitrecord = [];
    var_0 thread watchweaponusage();
  }
}

watchweaponusage(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_1);
    var_2 = spawnStruct();
    var_2.vpoint = self.origin;
    var_2.vdir = self getgunangles();
    self.shotrecord[self.shotrecord.size] = var_2;
  }
}

logplayers(var_0) {
  var_1 = level.players;
  var_2 = [];
  var_3 = gettime();
  var_4 = "_encstr_B40101";

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
      var_4 = var_4 + ("_encstr_96070311D2" + var_10 getentitynumber() + "_encstr_974C0246" + var_10.team + "_encstr_974C0246");
      var_11 = int(var_10.origin[0]) + "_encstr_964C0249" + int(var_10.origin[1]) + "_encstr_964C0249" + int(var_10.origin[2]);
      var_12 = int(var_10.angles[0]) + "_encstr_964C0249" + int(var_10.angles[1]) + "_encstr_964C0249" + int(var_10.angles[2]);
      var_2[var_2.size] = "_encstr_860703A120" + var_3 + "_encstr_974C0246" + var_10 getentitynumber() + "_encstr_974C0246" + var_11 + "_encstr_974C0246" + var_12 + "_encstr_974C0246";

      if(isDefined(var_10.hitrecord)) {
        foreach(var_14 in var_10.hitrecord) {
          var_15 = int(var_14.vpoint[0]) + "_encstr_964C0249" + int(var_14.vpoint[1]) + "_encstr_964C0249" + int(var_14.vpoint[2]);
          var_16 = int(var_14.vdir[0]) + "_encstr_964C0249" + int(var_14.vdir[1]) + "_encstr_964C0249" + int(var_14.vdir[2]);
          var_2[var_2.size - 1] = var_2[var_2.size - 1] + ("_encstr_87070358DF" + var_3 + "_encstr_974C0246" + var_10 getentitynumber() + "_encstr_974C0246" + var_14.victim getentitynumber() + "_encstr_974C0246" + var_15 + "_encstr_974C0246" + var_16 + "_encstr_974C0246" + var_14.kill + "_encstr_974C0246");
        }

        var_10.hitrecord = [];
      }

      if(isDefined(var_10.shotrecord)) {
        foreach(var_19 in var_10.shotrecord) {
          var_15 = int(var_19.vpoint[0]) + "_encstr_964C0249" + int(var_19.vpoint[1]) + "_encstr_964C0249" + int(var_19.vpoint[2]);
          var_16 = int(var_19.vdir[0]) + "_encstr_964C0249" + int(var_19.vdir[1]) + "_encstr_964C0249" + int(var_19.vdir[2]);
          var_2[var_2.size - 1] = var_2[var_2.size - 1] + ("_encstr_8C07032B39" + var_3 + "_encstr_974C0246" + var_10 getentitynumber() + "_encstr_974C0246" + var_15 + "_encstr_974C0246" + var_16 + "_encstr_974C0246");
        }

        var_10.shotrecord = [];
      }

      var_2[var_2.size - 1] = var_2[var_2.size - 1] + "_encstr_AD4C02A0";
      level.cinematicreplaystrings[level.cinematicreplaystrings.size] = var_2[var_2.size - 1];
    }
  }

  if(level.cinematicreplaystrings.size > 50) {
    var_21 = var_4;

    foreach(var_23 in level.cinematicreplaystrings)
    var_21 = var_21 + var_23;

    level.cinematicreplaystrings = [];
    level.cinematicreplaystringsconcat[level.cinematicreplaystringsconcat.size] = var_21;
  }
}