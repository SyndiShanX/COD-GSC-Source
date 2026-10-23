/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\common_sd_sr.gsc
******************************************************/

_id_4CB0(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "_a") {
    var_2 = var_2 | 1;
  } else {
    var_2 = var_2 | 2;
  }

  if(isDefined(var_1)) {
    if(var_1 == "ninja_defuse") {
      var_2 = var_2 | 4;
    } else if(var_1 == "last_man_defuse") {
      var_2 = var_2 | 8;
    }
  }

  return var_2;
}

_id_6B86() {
  game["bomb_dropped_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_dropped_enemy_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_recovered_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_grabbed_sound"] = "mp_snd_bomb_pickup";
  game["bomb_planted_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_disarm_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_sml";
}

updategametypedvars() {
  level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.multibomb = maps\mp\_utility::dvarintvalue("multibomb", 0, 0, 1);
  level.silentplant = maps\mp\_utility::dvarintvalue("silentplant", 0, 0, 1);
}

setspecialloadout() {
  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", game["attackers"], "defaultClass", 5, "class", "inUse")) {
    level.openpopupmenunomouse[game["attackers"]] = maps\mp\_utility::getmatchrulesspecialclass(game["attackers"], 5);
  }
}

isplayeroutsideofanybombsite(var_0) {
  if(isDefined(level.bombzones)) {
    foreach(var_2 in level.bombzones) {
      if(distancesquared(self.origin, var_2.trigger.origin) < 16384) {
        return 0;
      }
    }
  }

  if(isDefined(level.sdbomb)) {
    if(distancesquared(self.origin, level.sdbomb.trigger.origin) < 16384) {
      return 0;
    }
  }

  return 1;
}

onnormaldeath(var_0, var_1, var_2) {
  if(game["state"] == "postgame" && (var_0.team == game["defenders"] || !level.bombplanted)) {
    var_1.finalkill = 1;
  }

  if(waseliminatedbyenemy(var_0, var_1)) {
    var_3 = islastplayeralive(var_1);
    var_1 thread _id_047A::eliminateplayerevent(var_3, var_0);
  }
}

_id_254C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(isDefined(self.isbombcarrier) && self.isbombcarrier) {
    self.isbombcarrier = 0;

    if(self.team == game["attackers"]) {
      var_10 = 0;

      foreach(var_12 in level.players) {
        if(var_12 != self && var_12.team == self.team && isalive(var_12)) {
          var_10++;
        }
      }

      if(var_10 > 0) {
        maps\mp\_utility::leaderdialog("bomb_lost", self.team);
      }
    }
  }

  if(maps\mp\gametypes\_damage::isfriendlyfire(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  var_14 = self;

  if(var_14.isplanting || var_14.isdefusing) {
    var_1 thread _id_047A::defendobjectiveevent(var_14, var_9, var_4);
    var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);

    if(var_14.isplanting) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_interrupt");
    }

    if(var_14.isdefusing) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_protector");
      maps\mp\_utility::_id_863E(13, var_1.team, var_1 getentitynumber());
    }
  }
}

waseliminatedbyenemy(var_0, var_1) {
  if(maps\mp\gametypes\_damage::isfriendlyfire(var_0, var_1)) {
    return 0;
  }

  if(var_0 maps\mp\gametypes\_playerlogic::mayspawn()) {
    return 0;
  }

  return 1;
}

onpickup(var_0) {
  var_0.isbombcarrier = 1;

  if(var_0.team == "allies") {
    var_0._id_0112 = 1;
  } else {
    var_0._id_0112 = 2;
  }

  if(isPlayer(var_0)) {
    var_0 thread _id_0485::loggameevent("pickup", var_0.origin);
    var_0 setclientomnvar("ui_carrying_bomb", 1);
    var_0 thread maps\mp\gametypes\_hud_message::splashnotify("bomb_pickedup");
    maps\mp\_utility::_id_863E(15, var_0.team, var_0 getentitynumber());
  }

  _id_04D1::set2dicon("friendly", "waypoint_escort");
  _id_04D1::playsoundtoteam("friendly", "waypoint_escort", undefined, 1);

  if(isDefined(level.openpopupmenunomouse) && isDefined(level.openpopupmenunomouse[var_0.team])) {
    var_0.isrespawningwithbombcarrierclass = 1;
    var_0 thread _id_0F2F();
  }

  if(!level.bombdefused) {
    maps\mp\_utility::teamplayercardsplash("callout_bombtaken", var_0, var_0.team);
    maps\mp\_utility::leaderdialog("bomb_taken", var_0.pers["team"]);
  }

  maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);
  var_0 playlocalsound(game["bomb_grabbed_sound"]);
  var_0 _meth_8608(1);
}

bombs() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level._id_7069 = undefined;
  level.iconbomb = "waypoint_caster_bomb";
  level.icontarget = "waypoint_caster_target";
  level.icondefuse = "waypoint_caster_defuse";
  var_0 = _getEnt("sd_bomb_pickup_trig", "targetname");

  if(!isDefined(var_0)) {
    common_scripts\utility::error("No sd_bomb_pickup_trig trigger found in map.");
    return;
  }

  var_1[0] = _getEnt("sd_bomb", "targetname");

  if(!isDefined(var_1[0])) {
    common_scripts\utility::error("No sd_bomb script_model found in map.");
    return;
  }

  var_1[0] setModel("npc_gen_s_and_d_bomb");

  if(!level.multibomb) {
    level.sdbomb = _id_04D1::createcarryobject(game["attackers"], var_0, var_1, (0, 0, 32), 0, 0, 1);
    level.sdbomb _id_04D1::_id_0C1D("friendly");
    level.sdbomb _id_04D1::set2dicon("friendly", "waypoint_bomb");
    level.sdbomb _id_04D1::playsoundtoteam("friendly", "waypoint_bomb", undefined, 1);
    level.sdbomb _id_04D1::setvisibleteam("friendly");

    if(game["attackers"] == "axis") {
      maps\mp\_utility::_id_863F(level.sdbomb, level.iconbomb, 1, 1);
    } else {
      maps\mp\_utility::_id_863F(level.sdbomb, level.iconbomb, 2, 1);
    }

    level.sdbomb._id_0C33 = 1;
    level.sdbomb.onpickup = ::onpickup;
    level.sdbomb._id_6AEF = ::_id_6AEF;
    level.sdbomb.canuseobject = ::_id_1F79;
  } else {
    var_0 delete();
    var_1[0] delete();
  }

  level.bombzones = [];
  var_2 = getEntArray("bombzone", "targetname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_0 = var_2[var_3];
    var_1 = getEntArray(var_2[var_3].target, "targetname");
    var_4 = _id_04D1::createuseobject(game["defenders"], var_0, var_1, (0, 0, 64));
    var_4 _id_04D1::_id_0C30("enemy");
    var_4 _id_04D1::setusetime(level.planttime);
    var_4 _id_04D1::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");

    if(!level.multibomb) {
      var_4 _id_04D1::setkeyobject(level.sdbomb);
    }

    var_5 = var_4 _id_04D1::getlabel();
    var_4.label = var_5;
    var_4 _id_04D1::set2dicon("friendly", "waypoint_defend" + var_5);
    var_4 _id_04D1::playsoundtoteam("friendly", "waypoint_defend" + var_5, undefined, 1);
    var_4 _id_04D1::set2dicon("enemy", "waypoint_target" + var_5);
    var_4 _id_04D1::playsoundtoteam("enemy", "waypoint_target" + var_5, undefined, 1);
    var_4 _id_04D1::setvisibleteam("any");

    if(game["attackers"] == "axis") {
      maps\mp\_utility::_id_863F(var_4, level.icontarget + var_5, 2, 1);
    } else {
      maps\mp\_utility::_id_863F(var_4, level.icontarget + var_5, 1, 1);
    }

    var_4.onbeginuse = ::onbeginuse;
    var_4.onenduse = ::onenduse;
    var_4.nousebar = 1;
    var_4.id = "bombZone";
    var_4.onuse = ::onuseplantobject;
    var_4.oncantuse = ::oncantuse;
    var_4.useweapon = "search_dstry_bomb_mp";
    var_4.bombplanted = 0;

    for(var_6 = 0; var_6 < var_1.size; var_6++) {
      if(isDefined(var_1[var_6].setdepthoffield)) {
        var_4.exploderindex = var_1[var_6].setdepthoffield;
        var_1[var_6] thread setupkillcament(var_4);
        break;
      }
    }

    level.bombzones[level.bombzones.size] = var_4;
    var_4.bombdefusetrig = _getEnt(var_1[0].target, "targetname");
    var_4.bombdefusetrig.origin = var_4.bombdefusetrig.origin + (0, 0, -10000);
    var_4.bombdefusetrig.label = var_5;
    var_4.bombdefusetrig usetriggertouchcheckstance(1);
  }

  for(var_3 = 0; var_3 < level.bombzones.size; var_3++) {
    var_7 = [];

    for(var_8 = 0; var_8 < level.bombzones.size; var_8++) {
      if(var_8 != var_3) {
        var_7[var_7.size] = level.bombzones[var_8];
      }
    }

    level.bombzones[var_3].otherbombzones = var_7;
  }

  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
}

onuseplantobject(var_0) {
  if(!_id_04D1::isfriendlyteam(var_0.pers["team"])) {
    level thread bombplanted(self, var_0);

    if(isDefined(var_0.isbombcarrier) && var_0.isbombcarrier) {
      var_0.isbombcarrier = 0;
    }

    for(var_1 = 0; var_1 < level.bombzones.size; var_1++) {
      if(level.bombzones[var_1] == self) {
        var_2 = level.bombzones[var_1] _id_04D1::getlabel();

        if(game["attackers"] == "axis") {
          maps\mp\_utility::_id_863F(level.bombzones[var_1], level.icondefuse, 1, 1);
        } else {
          maps\mp\_utility::_id_863F(level.bombzones[var_1], level.icondefuse, 2, 1);
        }

        continue;
      }

      level.bombzones[var_1] _id_04D1::disableobject();
      maps\mp\_utility::_id_863F(level.bombzones[var_1], undefined, undefined, 1);
    }

    self.bombplanted = 1;
    var_0 notify("bomb_planted");
    var_3 = 2;

    if(self.label == "_a") {
      var_3 = 1;
    }

    maps\mp\_utility::_id_863E(3, var_0.team, var_0 getentitynumber(), var_3);
    var_4 = _id_4CB0(self.label);
    var_0 thread _id_047A::bombplantevent(var_4);
    maps\mp\_utility::leaderdialog("bomb_planted");
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_sound"], game["attackers"]);
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_enemy_sound"], game["defenders"]);

    if(isDefined(level.openpopupmenunomouse) && isDefined(level.openpopupmenunomouse[var_0.team])) {
      var_0 thread removebombcarrierclass();
    }

    level.bombowner = var_0;
    var_0.bombplantedtime = gettime();
  } else
    self.bombplanted = 0;
}

play_looping_beep_on_player(var_0) {
  var_1 = common_scripts\utility::_id_0F93(level.players, var_0);

  if(var_1.size) {
    var_0 maps\mp\_utility::playloopsoundtoplayers("snd_bomb_wheels_lp", undefined, var_1);
  }
}

stop_looping_beep_on_player(var_0) {
  var_0 common_scripts\utility::stop_loop_sound_on_entity("snd_bomb_wheels_lp");
}

setupkillcament(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateYaw(-45, 0.05);
  waitframe();
  var_2 = self.origin + (0, 0, 5);
  var_3 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 160);
  var_4 = bulletTrace(var_2, var_3, 0, self);
  self.killcament = spawn("script_model", var_4["position"]);
  self.killcament setscriptmoverkillcam("explosive");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

onbeginuse(var_0) {
  var_0 allowmelee(0);

  if(_id_04D1::isfriendlyteam(var_0.pers["team"])) {
    if(!level.silentplant && !var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
      var_0 maps\mp\_utility::notify_enemy_bots_bomb_used("defuse");
      level thread play_looping_beep_on_player(var_0);
    }

    var_0.isdefusing = 1;
    var_1 = _id_4CB0(self.label);
    var_0 thread _id_0485::loggameevent("bomb_defuse_start", var_0.origin, var_1);
    var_0 _meth_8608(1);
    maps\mp\_utility::_id_863E(4, var_0.team, var_0 getentitynumber());

    if(isDefined(level.freezecontrols)) {
      level.freezecontrols hide();
      _stopFXOnTag(common_scripts\utility::getfx("search_dstry_bomb_arming_light"), level.freezecontrols, "tag_fx");
    }
  } else {
    var_2 = 2;

    if(self.label == "_a") {
      var_2 = 1;
    }

    maps\mp\_utility::_id_863E(14, var_0.team, var_0 getentitynumber(), var_2);

    if(!level.silentplant && !var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
      var_0 maps\mp\_utility::notify_enemy_bots_bomb_used("plant");
      level thread play_looping_beep_on_player(var_0);
    }

    var_0.isplanting = 1;
    var_1 = _id_4CB0(self.label);
    var_0 thread _id_0485::loggameevent("bomb_plant_start", var_0.origin, var_1);

    if(level.multibomb) {
      for(var_3 = 0; var_3 < self.otherbombzones.size; var_3++) {
        self.otherbombzones[var_3] _id_04D1::_id_0C30("none");
        self.otherbombzones[var_3] _id_04D1::setvisibleteam("friendly");
      }
    }
  }

  _luinotifyevent(&"broadcaster_start_use_bomb", 1, var_0 getentitynumber());
}

onenduse(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 _meth_8608(0);
  var_1 allowmelee(1);

  if(isalive(var_1)) {
    var_1.isdefusing = 0;
    var_1.isplanting = 0;
  }

  level thread stop_looping_beep_on_player(var_1);

  if(_id_04D1::isfriendlyteam(var_1.pers["team"])) {
    if(isDefined(level.freezecontrols) && !var_2) {
      level.freezecontrols thread common_scripts\utility::_id_2CB7();
    }
  } else if(level.multibomb && !var_2) {
    for(var_3 = 0; var_3 < self.otherbombzones.size; var_3++) {
      self.otherbombzones[var_3] _id_04D1::_id_0C30("enemy");
      self.otherbombzones[var_3] _id_04D1::setvisibleteam("any");
    }
  }

  _luinotifyevent(&"broadcaster_start_use_bomb", 1, -1);
}

bombplantedanim(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 playerlinkTo(level.freezecontrols);

  while(var_0 getcurrentweapon() == self.useweapon) {
    waitframe();
  }

  var_0 unlink();
}

bombplanted(var_0, var_1) {
  level notify("bomb_planted", var_0);
  maps\mp\gametypes\_gamelogic::pausetimer();
  level.bombplanted = 1;
  level._id_7069 = var_0;
  var_1._id_0112 = 0;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_carrying_bomb", 0);
  }

  var_0.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
  level.tickingobject = var_0.visuals[0];
  level.timelimitoverride = 1;
  level.defuseendtime = int(gettime() + level.bombtimer * 1000);
  _setgameendtime(level.defuseendtime);

  if(!level.multibomb) {
    level.sdbomb _id_04D1::_id_0C1D("none");
    level.sdbomb _id_04D1::setvisibleteam("none");
    maps\mp\_utility::_id_863F(level.sdbomb, undefined, undefined, 1);
    level.sdbomb _id_04D1::setdropped(0.6);
    level.freezecontrols = level.sdbomb.visuals[0];
    var_1 _id_0468::_id_0A22("sdPlant");
  } else {
    level.freezecontrols = spawn("script_model", var_1.origin);
    level.freezecontrols.angles = var_1.angles;
    level.freezecontrols setModel("npc_gen_s_and_d_bomb");
  }

  level.bomboutlineactive = 1;
  var_2 = maps\mp\_utility::getteamindex(game["attackers"]);
  level.freezecontrols setmodelfromarray(level.players, var_2, 0);

  foreach(var_4 in level.broadcasters) {
    if(var_4.camera._id_A4A8 == "third_person") {
      level.freezecontrols hudoutlineenableforclient(var_4, var_2, 0);
      continue;
    }

    level.freezecontrols hudoutlinedisableforclient(var_4);
  }

  _playFXOnTag(common_scripts\utility::getfx("search_dstry_bomb_arming_light"), level.freezecontrols, "tag_fx");
  var_0 _id_04D1::_id_0C30("none");
  var_0 _id_04D1::setvisibleteam("none");
  var_6 = var_0 _id_04D1::getlabel();
  _setomnvar("ui_bomb" + var_6 + "_state", 1);
  var_7 = var_0.bombdefusetrig;
  var_7.origin = level.freezecontrols.origin;
  var_8 = [];
  var_9 = _id_04D1::createuseobject(game["defenders"], var_7, var_8, (0, 0, 32));
  var_9 _id_04D1::_id_0C30("friendly");
  var_9 _id_04D1::setusetime(level.defusetime);
  var_9 _id_04D1::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_9 _id_04D1::setvisibleteam("any");
  var_9 _id_04D1::set2dicon("friendly", "waypoint_defuse" + var_6);
  var_9 _id_04D1::set2dicon("enemy", "waypoint_defend" + var_6);
  var_9 _id_04D1::playsoundtoteam("friendly", "waypoint_defuse" + var_6, undefined, 1);
  var_9 _id_04D1::playsoundtoteam("enemy", "waypoint_defend" + var_6, undefined, 1);
  var_9.label = var_6;
  var_9.onbeginuse = ::onbeginuse;
  var_9.onenduse = ::onenduse;
  var_9.onuse = ::onusedefuseobject;
  var_9.nousebar = 1;
  var_9.id = "defuseObject";
  var_9.useweapon = "search_dstry_bomb_defuse_mp";

  if(var_6 == "_a" || var_6 == "_A") {
    _setomnvar("ui_broadcaster_game_mode_status_1", 1);
  } else if(var_6 == "_b" || var_6 == "_B") {
    _setomnvar("ui_broadcaster_game_mode_status_1", 2);
  }

  maps\mp\_utility::playsoundinspace("mp_snd_bomb_drop", level.freezecontrols.origin + (0, 0, 1));
  bombtimerwait(var_6);
  var_0.visuals[0] maps\mp\gametypes\_gamelogic::stoptickingsound();
  level.bomboutlineactive = 0;
  level.freezecontrols hudoutlinedisable();

  if(level.gameended || level.bombdefused) {
    return;
  }
  level.bombexploded = 1;
  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  _setomnvar("ui_bomb" + var_6 + "_state", 2);

  if(isDefined(level.closepopupmenu)) {
    level thread[[level.closepopupmenu]]();
  } else {
    var_10 = level.freezecontrols.origin;
    var_11 = var_10;
    var_10 = var_10 + (0, 0, 10);
    level.freezecontrols hide();
    _stopFXOnTag(common_scripts\utility::getfx("search_dstry_bomb_arming_light"), level.freezecontrols, "tag_fx");

    if(isDefined(var_1)) {
      var_0.visuals[0] radiusdamage(var_10, 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
      var_0.visuals[0] radiusdamage(var_0.visuals[0].origin + (0, 0, 75), 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
      var_12 = _id_4CB0(var_6);
      var_1 thread _id_047A::bombdetonateevent(var_12);
    } else {
      var_0.visuals[0] radiusdamage(var_10, 512, 300, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
      var_0.visuals[0] radiusdamage(var_0.visuals[0].origin + (0, 0, 75), 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    var_13 = "bomb_explosion";

    if(isDefined(var_0.trigger.effect)) {
      var_13 = var_0.trigger.effect;
    }

    var_14 = _randomfloat(360);
    var_15 = _spawnfx(level._effect[var_13], var_11, (0, 0, 1), (_cos(var_14), _sin(var_14), 0));
    _triggerfx(var_15);
    _physicsexplosionsphere(var_11, 200, 100, 3);
    _playrumbleonposition("grenade_rumble", var_10);
    _earthquake(0.75, 2.0, var_10, 2000);
    thread maps\mp\_utility::playsoundinspace("mp_snd_bomb_detonated", var_10);

    if(isDefined(var_0.exploderindex)) {
      common_scripts\_exploder::exploder(var_0.exploderindex);
    }
  }

  for(var_16 = 0; var_16 < level.bombzones.size; var_16++) {
    level.bombzones[var_16] _id_04D1::disableobject();
  }

  var_9 _id_04D1::disableobject();
  _setgameendtime(0);
  wait 3;

  if(common_scripts\utility::_id_562E(level._id_5677)) {
    level.sdbomb.trigger notify("obj_complete");
  } else {
    openpopupmenu(game["attackers"], game["end_reason"]["target_destroyed"]);
  }
}

bombtimerwait(var_0) {
  level endon("game_ended");
  level endon("bomb_defused");
  var_1 = int(level.bombtimer * 1000 + gettime());
  _setomnvar("ui_bomb" + var_0 + "_timer_endtime", var_1);
  level thread handlehostmigration(var_0, var_1);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

handlehostmigration(var_0, var_1) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  _setomnvar("ui_bomb" + var_0 + "_timer_endtime", 0);
  var_2 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_2 > 0) {
    _setomnvar("ui_bomb" + var_0 + "_timer_endtime", var_1 + var_2);
  }
}

_id_6AEF(var_0) {
  if(isDefined(var_0)) {
    var_0 _meth_8608(0);
  }

  _id_04D1::set2dicon("friendly", "waypoint_bomb");
  _id_04D1::playsoundtoteam("friendly", "waypoint_bomb", undefined, 1);
  maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_dropped_enemy_sound"], game["defenders"]);

  if(isDefined(var_0) && isDefined(var_0.isbombcarrier) && var_0.isbombcarrier) {
    var_0.isbombcarrier = 0;
  }
}

_id_1F79(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return 1;
}

onusedefuseobject(var_0) {
  var_0 notify("bomb_defused");
  level thread bombdefused();
  _id_04D1::disableobject();
  _setomnvar("ui_bomb" + self.label + "_state", 0);
  maps\mp\_utility::leaderdialog("bomb_defused_attackers", game["attackers"]);
  maps\mp\_utility::leaderdialog("bomb_defused_defenders", game["defenders"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_enemy_sound"], game["attackers"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_sound"], game["defenders"]);
  var_1 = "defuse";

  if(isDefined(level.bombowner) && maps\mp\_utility::isreallyalive(level.bombowner)) {
    var_1 = "ninja_defuse";
  }

  if(islastplayeralive(var_0) && isDefined(self) && isDefined(self.ownerteam) && _getteamplayersalive(maps\mp\_utility::getotherteam(self.ownerteam)) > 0) {
    var_1 = "last_man_defuse";
  }

  var_2 = _id_4CB0(self.label, var_1);
  var_0 thread _id_047A::bombdefuseevent(var_1, var_2);
}

islastplayeralive(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(var_2.team != var_0.team) {
      continue;
    }
    if(var_2 maps\mp\gametypes\_playerlogic::mayspawn()) {
      return 0;
    }

    if(maps\mp\_utility::isreallyalive(var_2)) {
      return 0;
    }
  }

  return 1;
}

bombdefused() {
  level.tickingobject maps\mp\gametypes\_gamelogic::stoptickingsound();
  level.bombdefused = 1;
  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  level notify("bomb_defused");
  wait 1.5;
  _setgameendtime(0);
  openpopupmenu(game["defenders"], game["end_reason"]["bomb_defused"]);
}

oncantuse(var_0) {
  var_0 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

ontimelimit() {
  openpopupmenu(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

openpopupmenu(var_0, var_1) {
  level.finalkillcam_winner = var_0;

  if(var_1 == game["end_reason"]["target_destroyed"] || var_1 == game["end_reason"]["bomb_defused"]) {
    var_2 = 1;

    foreach(var_4 in level.bombzones) {
      if(isDefined(level.finalkillcam_killcamentityindex[var_0]) && level.finalkillcam_killcamentityindex[var_0] == var_4.killcamentnum) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      _id_04CE::erasefinalkillcam();
    }
  }

  _id_04D2::giveteamscoreforobjective(var_0, 1, 1);
  thread maps\mp\gametypes\_gamelogic::endgame(var_0, var_1);
}

checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!level._id_0BC3[game["attackers"]]) {
    level.spectateoverride[game["attackers"]]._id_0C22 = 1;
    var_0 = 1;
  }

  if(!level._id_0BC3[game["defenders"]]) {
    level.spectateoverride[game["defenders"]]._id_0C22 = 1;
    var_0 = 1;
  }

  if(var_0) {
    _id_050F::updatespectatesettings();
  }
}

ondeadevent(var_0) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }
  if(var_0 == "all") {
    if(level.bombplanted) {
      openpopupmenu(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    } else {
      openpopupmenu(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    }
  } else if(var_0 == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }
    level thread openpopupmenu(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["defenders"])
    level thread openpopupmenu(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

ononeleftevent(var_0) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }
  var_1 = maps\mp\_utility::getlastlivingplayer(var_0);
  var_1 thread givelastonteamwarning();
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  var_0 = maps\mp\_utility::getotherteam(self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
  maps\mp\_utility::_id_863E(16, self.team, self getentitynumber());
  maps\mp\gametypes\_missions::lastmansd();
}

onreset() {}

_id_0F2F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level.openpopupmenunomouse[self.team];
  self.gamemode_chosenclass = self.class;
  self.gamemode_carrierclass = 1;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastclass = "gamemode";
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, "gamemode");

  if(self.loadoutkeepcurrentkillstreaks) {
    _id_051E::updatekillstreaks(1);
  }

  refillbattery();
}

refillbattery() {
  var_0 = self getweaponslistoffhands();

  foreach(var_2 in var_0) {
    self batteryfullrecharge(var_2);
  }
}

removebombcarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = undefined;
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, self.class);

  if(self.loadoutkeepcurrentkillstreaks) {
    _id_051E::updatekillstreaks(1);
  }

  refillbattery();
}