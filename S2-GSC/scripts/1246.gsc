/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1246.gsc
**************************************/

init() {
  level._id_9A9B = spawnStruct();
  level._id_9A9B._id_3F48 = loadfx("vfx/unique/hub_top_player_loop");
  level._id_9A9B._id_3F52 = loadfx("vfx/unique/hub_top_player_spawn");
  level._id_9A9B._id_5022 = ["headicon_1st_place", "headicon_2nd_place", "headicon_3rd_place"];
  thread onplayerconnect();
  thread _id_A17F();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_9A99();
  }
}

_id_9A99() {
  self endon("disconnect");
  level endon("game_ended");
  wait 60;
  self._id_56D6 = 1;
}

_id_A17F() {
  level endon("game_ended");

  for(;;) {
    wait 30;
    _id_A17E();
  }
}

_id_A17E() {
  level endon("game_ended");
  level._id_9A9B._id_7420 = common_scripts\utility::_id_0FA5(level.players, ::_id_255A);
  _id_A17D();
}

_id_A17D() {
  for(var_0 = 0; var_0 < 3; var_0++) {
    if(!isDefined(level._id_9A9B._id_7420[var_0])) {
      break;
    }

    var_1 = level._id_9A9B._id_7420[var_0];

    if(isDefined(var_1._id_9A9A)) {
      if(var_1._id_9A9C == var_0 + 1) {
        continue;
      }
      var_1._id_9A9A destroy();
    }

    var_2 = newhudelem();
    var_2 setshader(level._id_9A9B._id_5022[var_0]);
    var_2.x = var_1.origin[0];
    var_2.y = var_1.origin[1];
    var_2._id_01D9 = var_1.origin[2] + 90;
    var_2 setwaypoint(1, 0, 0);
    var_2 settargetEnt(var_1);
    var_2._id_6E74 = level._id_A012;
    var_2._id_6E74 maps\mp\gametypes\_hud_util::_id_09A6(var_2);
    var_2.name = "topPlayerElem";
    var_1._id_9A9A = var_2;
    var_1._id_9A9C = var_0 + 1;

    if(var_0 == 0) {
      foreach(var_4 in level.players) {
        var_4 iprintln(var_1.name + " is the new top player with a K/D of " + var_1._id_1FF4);
      }
    }
  }

  for(var_0 = 3; var_0 < level.players.size; var_0++) {
    if(isDefined(level._id_9A9B._id_7420[var_0]._id_9A9A)) {
      level._id_9A9B._id_7420[var_0]._id_9A9A destroy();
      level._id_9A9B._id_7420[var_0]._id_9A9C = -1;
    }
  }
}

_id_255A(var_0, var_1) {
  return !isDefined(var_1) || !isDefined(var_1._id_56D6) || isDefined(var_0) && var_0._id_1FF4 > var_1._id_1FF4 && isDefined(var_0._id_56D6);
}

_id_1E53() {
  var_0 = self getplayerdata(common_scripts\utility::_id_46AE(), "kills");
  var_1 = self getplayerdata(common_scripts\utility::_id_46AE(), "deaths");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1 == 0) {
    var_1 = 1;
  }

  self._id_1FF4 = var_0 / var_1;
}