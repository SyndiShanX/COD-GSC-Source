/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_v2_nuke.gsc
****************************************************/

init() {
  level._id_5A61["v2_rocket"] = ::_id_9E3D;
  level._id_5A7D["v2_rocket_mp"] = "v2_rocket";
  level._effect["nuke_flash"] = loadfx("vfx/explosion/v2_explosion_mp_rnr");
  setdvarifuninitialized("scr_nukeTimer", 10);
  level._id_6866 = getdvarint("scr_nukeTimer");
  level._id_685E = spawnStruct();
}

_id_9E3D(var_0) {
  if(isDefined(level._id_685D)) {
    self iprintlnbold(&"KILLSTREAKS_NUKE_ALREADY_INBOUND");
    return 0;
  }

  if(isDefined(level.nukecoolingdown)) {
    self iprintlnbold(&"KILLSTREAKS_NUKE_COOLDOWN");
    return 0;
  }

  if(maps\mp\_utility::isusingremote())
    return 0;

  thread _id_3252();

  if(level.gametype != "infect")
    maps\mp\gametypes\_missions::processchallenge("ch_streak_v2rocket");

  _id_0485::_id_5E9A("v2_rocket", self.origin);
  return 1;
}

_id_2CEE(var_0, var_1) {
  level endon("nuke_cancelled");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread[[var_1]]();
}

wait_for_nuke_user_disconnect() {
  level endon("game_ended");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  self waittill("disconnect");
  level notify("nuke_cancelled");
}

wait_for_nuke_cancelled() {
  level endon("game_ended");
  level endon("nuke_death");
  level waittill("nuke_cancelled");
  _setomnvar("ui_bomb_a_state", 0);
  level._id_685D = undefined;
  level.nukecoolingdown = undefined;
  level._id_685E.player = undefined;
  level._id_685E.team = undefined;
}

_id_3252() {
  level endon("nuke_cancelled");
  thread wait_for_nuke_user_disconnect();
  level thread wait_for_nuke_cancelled();
  level._id_685E.player = self;
  level._id_685E.team = self.pers["team"];
  level._id_685D = 1;
  level.nukecoolingdown = 1;
  _setomnvar("ui_bomb_a_state", 4);

  if(!level.teambased && !level.hardcoremode)
    self iprintlnbold(&"MP_FRIENDLY_TACTICAL_NUKE");

  level thread _id_2CEE(level._id_6866, ::_id_6861);
  level thread _id_2CEE(level._id_6866, ::_id_6860);
  level thread _id_2CEE(level._id_6866 - 0.47, ::_id_685C);
  level thread _id_2CEE(level._id_6866 - 0.1, ::_id_6867);
  level thread _id_2CEE(level._id_6866 + 0.5, ::_id_6858);
  level thread _id_2CEE(level._id_6866 + 0.6, ::_id_685A);
  level thread _id_A0D6();

  if(!isDefined(level._id_6852)) {
    level._id_6852 = spawn("script_origin", (0, 0, 0));
    level._id_6852 hide();
  }

  if(!isDefined(level._id_6856)) {
    level._id_6856 = spawn("script_origin", (0, 0, 1));
    level._id_6856 hide();
  }

  _id_0378::_id_8D74("aud_v2_incoming");

  for(var_0 = level._id_6866; var_0 > 0; var_0--) {
    _id_0380::_id_6840("mp_s2_obj_timer_tick_1s", undefined);
    wait 1.0;
  }
}

_id_6861() {
  level endon("nuke_cancelled");
  _id_0378::_id_8D74("aud_v2_explosion");
}

_id_685C() {
  level endon("nuke_cancelled");

  foreach(var_1 in level.players) {
    var_2 = anglesToForward(var_1.angles);
    var_2 = (var_2[0], var_2[1], 0);
    var_2 = vectorNormalize(var_2);
    var_3 = 5000;
    var_4 = spawn("script_model", var_1.origin + var_2 * var_3);
    var_4 setModel("tag_origin");
    var_5 = vectortoangles(var_1.origin - var_4.origin);
    var_4.angles = (270, var_5[1] + 90, 0);
    var_4 hide();
    var_4 showtoplayer(var_1);
    var_4 thread _id_685B(var_1);
    var_4 thread wait_destroy_nuke_fx();
  }
}

wait_destroy_nuke_fx() {
  level endon("game_ended");
  level common_scripts\utility::waittill_notify_or_timeout("nuke_cancelled", 20);
  self delete();
  level.nukecoolingdown = undefined;
}

_id_685B(var_0) {
  level endon("nuke_cancelled");
  var_0 endon("disconnect");
  waitframe();
  _playfxontagforclients(level._effect["nuke_flash"], self, "tag_origin", var_0);
}

_id_6860() {
  level endon("nuke_cancelled");
  _setomnvar("ui_bomb_a_state", 0);
  _setslowmotion(1.0, 0.25, 0.5);
  level waittill("nuke_death");
  _setslowmotion(0.25, 1, 2.0);
}

_id_6867() {
  level endon("nuke_cancelled");
  var_0 = "dna_bomb";

  if(isDefined(level._id_3092))
    var_0 = level._id_3092;

  level._id_6868 = 1;

  foreach(var_2 in level.players) {
    var_2 setclienttriggervisionset(var_0, 0.5);
    var_2 thread applyv2flash(1.6, 0.75);
  }

  level waittill("nuke_death");
  wait 3.0;

  foreach(var_2 in level.players)
  var_2 setclienttriggervisionset("", 10);

  level._id_6868 = undefined;
}

_id_6858() {
  level endon("nuke_cancelled");
  level notify("nuke_death");
  maps\mp\gametypes\_hostmigration::_id_A782();
  _ambientstop(1);
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(level.teambased) {
      if(isDefined(level._id_685E.team) && var_2.team == level._id_685E.team)
        continue;
    } else if(isDefined(level._id_685E.player) && var_2 == level._id_685E.player) {
      continue;
    }
    var_2.nuked = 1;

    if(isalive(var_2)) {
      var_2 thread maps\mp\gametypes\_damage::_id_3BAC(level._id_685E.player, level._id_685E.player, 999999, 0, "MOD_EXPLOSIVE", "v2_rocket_mp", var_2.origin, var_2.origin, "none", 0, 0);

      if(isDefined(var_2._id_5738) && var_2._id_5738 == 1)
        var_2 dodamage(1, var_2.origin, level._id_685E.player, level._id_685E.player, "MOD_EXPLOSIVE", "v2_rocket_mp");

      var_0 = var_0 + 0.05;
    }
  }

  level thread _id_6853();
  level._id_685D = undefined;
}

_id_685A() {
  level endon("nuke_cancelled");

  foreach(var_1 in level.players) {
    _earthquake(0.6, 5, var_1.origin, 1000, var_1);
    var_1 playrumbleonentity("damage_heavy");
  }
}

_id_6853() {
  level endon("game_ended");
  level notify("nuke_EMPJam");
  level endon("nuke_EMPJam");
  level thread _id_6855(level._id_685E.player);
  level notify("nuke_emp_update");

  foreach(var_1 in level.players) {
    if(level.teambased && var_1.team == level._id_685E.team) {
      continue;
    }
    var_1.nuked = undefined;
  }

  level notify("nuke_emp_update");
  level notify("nuke_emp_ended");
}

_id_6855(var_0) {
  level endon("game_ended");
  var_1 = [];

  if(level.teambased)
    var_1 = level._id_9FDA[maps\mp\_utility::getotherteam(var_0.team)];
  else
    var_1 = level._id_9FDA;

  foreach(var_3 in var_1) {
    if(level.teambased && isDefined(var_3.team) && var_3.team != var_0.team || !level.teambased && isDefined(var_3._id_0117) && var_3._id_0117 != var_0)
      var_3 dodamage(99999, var_3.origin, var_0, var_0, "MOD_EXPLOSIVE", "v2_rocket_mp");
  }

  var_5 = level._id_7043;

  foreach(var_7 in var_5) {
    if(level.teambased && isDefined(var_7.team) && var_7.team != var_0.team || !level.teambased && isDefined(var_7._id_0117) && var_7._id_0117 != var_0)
      var_7 dodamage(99999, var_7.origin, var_0, var_0, "MOD_EXPLOSIVE", "v2_rocket_mp");
  }

  var_9 = level._id_6E71;

  foreach(var_11 in level._id_6E71) {
    if(isDefined(var_11) && isDefined(var_11._id_0117)) {
      if(level.teambased) {
        if(isDefined(var_11._id_0117.team) && var_11._id_0117.team != var_0.team)
          var_11 dodamage(var_11.health + 500000, var_11.origin, var_0, var_0, "MOD_EXPLOSIVE", "v2_rocket_mp");

        continue;
      }

      if(var_11._id_0117 != var_0)
        var_11 dodamage(var_11.health + 500000, var_11.origin, var_0, var_0, "MOD_EXPLOSIVE", "v2_rocket_mp");
    }
  }
}

_id_A0D6() {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var_0 = level._id_6866 * 1000 + gettime();
  _setomnvar("ui_nuke_end_milliseconds", var_0);
  level waittill("host_migration_begin");
  var_1 = maps\mp\gametypes\_hostmigration::_id_A782();

  if(var_1 > 0)
    _setomnvar("ui_nuke_end_milliseconds", var_0 + var_1);
}

_id_3D58(var_0) {
  self endon("stop_monitoring_flash");
  self notify("flash_rumble_loop");
  self endon("flash_rumble_loop");
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    waitframe();
  }
}

applyv2flash(var_0, var_1) {
  if(!isDefined(self._id_3D46) || var_0 > self._id_3D46)
    self._id_3D46 = var_0;

  if(!isDefined(self._id_3D57) || var_1 > self._id_3D57)
    self._id_3D57 = var_1;

  waitframe();

  if(isDefined(self._id_3D46)) {
    self shellshock("flashbang_mp", self._id_3D46);
    self._id_3D48 = gettime() + self._id_3D46 * 1000;
    thread maps\mp\_utility::_id_5D22("flashed", 0.05, 0.1, 0.55);
  }

  if(isDefined(self._id_3D57))
    thread _id_3D58(self._id_3D57);

  self._id_3D46 = undefined;
  self._id_3D57 = undefined;
}