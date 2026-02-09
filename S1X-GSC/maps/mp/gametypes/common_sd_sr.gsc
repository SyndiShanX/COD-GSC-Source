/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\common_sd_sr.gsc
**********************************************/

onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_dropped_enemy_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_recovered_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_grabbed_sound"] = "mp_snd_bomb_pickup";
  game["bomb_planted_sound"] = "mp_obj_notify_pos_med";
  game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_med";
  game["bomb_disarm_sound"] = "mp_obj_notify_pos_lrg";
  game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_lrg";
}

updategametypedvars() {
  level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.multibomb = maps\mp\_utility::dvarintvalue("multibomb", 0, 0, 1);
  level.silentplant = maps\mp\_utility::dvarintvalue("silentplant", 0, 0, 1);
}

setspecialloadout() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level.sd_loadout[game["attackers"]] = maps\mp\_utility::getmatchrulesspecialclass(game["attackers"], 5);
  }
}

isplayeroutsideofanybombsite(var_0) {
  if(isDefined(level.bombzones)) {
    foreach(var_2 in level.bombzones) {
      if(distancesquared(self.origin, var_2.trigger.origin) < 4096) {
        return 0;
      }
    }
  }

  return 1;
}

onnormaldeath(var_0, var_1, var_2) {
  if(game["state"] == "postgame" && (var_0.team == game["defenders"] || !level.bombplanted)) {
    var_1.finalkill = 1;
  }

  if(var_0.isplanting || var_0.isdefusing) {
    var_1 thread maps\mp\_events::defendobjectiveevent(var_0, var_2);

    if(var_0.isplanting) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_interrupt");
    }

    if(var_0.isdefusing) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_protector");
    }
  }

  if(waselminatedbyenemy(var_0, var_1)) {
    var_3 = islastplayeralive(var_1);
    var_1 thread maps\mp\_events::eliminateplayerevent(var_3, var_0);
  }
}

waselminatedbyenemy(var_0, var_1) {
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
    var_0.objective = 1;
  } else {
    var_0.objective = 2;
  }

  if(isPlayer(var_0)) {
    var_0 thread maps\mp\_matchdata::loggameevent("pickup", var_0.origin);
    var_0 setclientomnvar("ui_carrying_bomb", 1);
  }

  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_escort");
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_escort");

  if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var_0.team])) {
    var_0.isrespawningwithbombcarrierclass = 1;
    var_0 thread applybombcarrierclass();
  }

  if(!level.bombdefused) {
    maps\mp\_utility::teamplayercardsplash("callout_bombtaken", var_0, var_0.team);
    maps\mp\_utility::leaderdialog("bomb_taken", var_0.pers["team"]);
  }

  maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);
  var_0 playlocalsound(game["bomb_grabbed_sound"]);
}

bombs() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  var_0 = getent("sd_bomb_pickup_trig", "targetname");

  if(!isDefined(var_0)) {
    common_scripts\utility::error("No sd_bomb_pickup_trig trigger found in map.");
    return;
  }

  var_1[0] = getent("sd_bomb", "targetname");

  if(!isDefined(var_1[0])) {
    common_scripts\utility::error("No sd_bomb script_model found in map.");
    return;
  }

  var_1[0] setModel("npc_search_dstry_bomb");

  if(!level.multibomb) {
    level.sdbomb = maps\mp\gametypes\_gameobjects::createcarryobject(game["attackers"], var_0, var_1, (0, 0, 32));
    level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("friendly");
    level.sdbomb maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_bomb");
    level.sdbomb maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_bomb");
    level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");

    if(game["attackers"] == "allies") {
      maps\mp\_utility::setmlgicons(level.sdbomb, "waypoint_bomb_green");
    } else {
      maps\mp\_utility::setmlgicons(level.sdbomb, "waypoint_bomb_red");
    }

    level.sdbomb.allowweapons = 1;
    level.sdbomb.onpickup = ::onpickup;
    level.sdbomb.ondrop = ::ondrop;
    level.sdbomb.canuseobject = ::canuse;
    level.sdbomb.goliaththink = ::goliathdropbomb;
  } else {
    var_0 delete();
    var_1[0] delete();
  }

  level.bombzones = [];
  var_2 = getEntArray("bombzone", "targetname");
  var_3 = getEntArray("bombzone_augmented", "targetname");

  if(maps\mp\_utility::isaugmentedgamemode()) {
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = var_3[var_4].script_label;

      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_2[var_6].script_label == var_5) {
          removebombzone(var_2[var_6]);
          break;
        }
      }
    }
  } else {
    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      removebombzone(var_3[var_7]);
    }
  }

  var_2 = common_scripts\utility::array_combine(var_2, var_3);

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_0 = var_2[var_7];
    var_1 = getEntArray(var_2[var_7].target, "targetname");
    playFXOnTag(common_scripts\utility::getfx("bomb_light_blinking"), var_1[0], "tag_fx_1");
    playFXOnTag(common_scripts\utility::getfx("bomb_light_blinking"), var_1[0], "tag_fx_2");
    var_8 = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"], var_0, var_1, (0, 0, 64));
    var_8 maps\mp\gametypes\_gameobjects::allowuse("enemy");
    var_8 maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
    var_8 maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");

    if(!level.multibomb) {
      var_8 maps\mp\gametypes\_gameobjects::setkeyobject(level.sdbomb);
    }

    var_9 = var_8 maps\mp\gametypes\_gameobjects::getlabel();
    var_8.label = var_9;
    var_8 maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_target" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_target" + var_9);
    var_8 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    maps\mp\_utility::setmlgicons(var_8, "waypoint_esports_snd_target" + var_9 + "_white");
    var_8.onbeginuse = ::onbeginuse;
    var_8.onenduse = ::onenduse;
    var_8.nousebar = 1;
    var_8.id = "bombZone";
    var_8.onuse = ::onuseplantobject;
    var_8.oncantuse = ::oncantuse;
    var_8.useweapon = "search_dstry_bomb_mp";

    for(var_10 = 0; var_10 < var_1.size; var_10++) {
      if(isDefined(var_1[var_10].script_exploder)) {
        var_8.exploderindex = var_1[var_10].script_exploder;
        var_1[var_10] thread setupkillcament(var_8);
        break;
      }
    }

    level.bombzones[level.bombzones.size] = var_8;
    var_8.bombdefusetrig = getent(var_1[0].target, "targetname");
    var_8.bombdefusetrig.origin = var_8.bombdefusetrig.origin + (0, 0, -10000);
    var_8.bombdefusetrig.label = var_9;
    var_8.bombdefusetrig usetriggertouchcheckstance(1);
  }

  for(var_7 = 0; var_7 < level.bombzones.size; var_7++) {
    var_11 = [];

    for(var_12 = 0; var_12 < level.bombzones.size; var_12++) {
      if(var_12 != var_7) {
        var_11[var_11.size] = level.bombzones[var_12];
      }
    }

    level.bombzones[var_7].otherbombzones = var_11;
  }

  setomnvar("ui_mlg_game_mode_status_1", 0);
}

removebombzone(var_0) {
  var_1 = getEntArray("script_brushmodel", "classname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_gameobjectname) || var_3.script_gameobjectname != "bombzone") {
      continue;
    }
    if(!isDefined(var_3.script_label)) {
      continue;
    }
    var_4 = issubstr(var_3.script_label, "augmented");

    if(maps\mp\_utility::isaugmentedgamemode() && var_4) {
      continue;
    }
    if(!maps\mp\_utility::isaugmentedgamemode() && !var_4) {
      continue;
    }
    if(issubstr(var_3.script_label, var_0.script_label) && issubstr(var_3.script_label, var_0.targetname)) {
      var_3 delete();
    }
  }

  var_6 = getEntArray(var_0.target, "targetname");

  foreach(var_8 in var_6) {
    if(isDefined(var_8.target)) {
      var_9 = getEntArray(var_8.target, "targetname");

      foreach(var_11 in var_9) {
        var_11 delete();
      }
    }

    var_8 delete();
  }

  var_0 delete();
}

onuseplantobject(var_0) {
  if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(var_0.pers["team"])) {
    level thread bombplanted(self, var_0);

    for(var_1 = 0; var_1 < level.bombzones.size; var_1++) {
      if(level.bombzones[var_1] == self) {
        var_2 = level.bombzones[var_1] maps\mp\gametypes\_gameobjects::getlabel();
        maps\mp\_utility::setmlgicons(level.bombzones[var_1], "waypoint_esports_snd_planted" + var_2);
        continue;
      }

      level.bombzones[var_1] maps\mp\gametypes\_gameobjects::disableobject();
      maps\mp\_utility::setmlgicons(level.bombzones[var_1], undefined);
    }

    var_0 playSound("mp_bomb_plant");
    var_0 notify("bomb_planted");
    var_0 thread maps\mp\_events::bombplantevent();
    maps\mp\_utility::leaderdialog("bomb_planted");
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_sound"], game["attackers"]);
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_enemy_sound"], game["defenders"]);

    if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var_0.team])) {
      var_0 thread removebombcarrierclass();
    }

    level.bombowner = var_0;
    var_0.bombplantedtime = gettime();
  }
}

play_looping_beep_on_player(var_0) {
  var_1 = common_scripts\utility::array_remove(level.players, var_0);

  if(var_1.size) {
    var_0 maps\mp\_utility::playloopsoundtoplayers("snd_bomb_button_press_lp", undefined, var_1);
  }
}

stop_looping_beep_on_player(var_0) {
  var_0 common_scripts\utility::stop_loop_sound_on_entity("snd_bomb_button_press_lp");
}

setupkillcament(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateyaw(-45, 0.05);
  wait 0.05;
  var_2 = self.origin + (0, 0, 5);
  var_3 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_4 = bulletTrace(var_2, var_3, 0, self);
  self.killcament = spawn("script_model", var_4["position"]);
  self.killcament setscriptmoverkillcam("explosive");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

onbeginuse(var_0) {
  var_0 allowmelee(0);

  if(maps\mp\gametypes\_gameobjects::isfriendlyteam(var_0.pers["team"])) {
    if(!level.silentplant) {
      var_0 maps\mp\_utility::notify_enemy_bots_bomb_used("defuse");
      var_0 playSound("mp_snd_bomb_disarming");
      level thread play_looping_beep_on_player(var_0);
    }

    var_0.isdefusing = 1;

    if(isDefined(level.sdbombmodel)) {
      level.sdbombmodel hide();
      stopFXOnTag(common_scripts\utility::getfx("bomb_light_planted"), level.sdbombmodel, "tag_flash");
    }
  } else {
    if(!level.silentplant) {
      var_0 maps\mp\_utility::notify_enemy_bots_bomb_used("plant");
      var_0 playSound("mp_snd_bomb_arming");
      level thread play_looping_beep_on_player(var_0);
    }

    var_0.isplanting = 1;

    if(level.multibomb) {
      for(var_1 = 0; var_1 < self.otherbombzones.size; var_1++) {
        self.otherbombzones[var_1] maps\mp\gametypes\_gameobjects::allowuse("none");
        self.otherbombzones[var_1] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
      }
    }
  }
}

light_after_delay() {
  wait 0.05;
  playFXOnTag(common_scripts\utility::getfx("bomb_light_planted"), level.sdbombmodel, "tag_flash");
}

onenduse(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 allowmelee(1);

  if(isalive(var_1)) {
    var_1.isdefusing = 0;
    var_1.isplanting = 0;
  }

  level thread stop_looping_beep_on_player(var_1);

  if(maps\mp\gametypes\_gameobjects::isfriendlyteam(var_1.pers["team"])) {
    if(isDefined(level.sdbombmodel) && !var_2) {
      level.sdbombmodel show();
      thread light_after_delay();
    }
  } else if(level.multibomb && !var_2) {
    for(var_3 = 0; var_3 < self.otherbombzones.size; var_3++) {
      self.otherbombzones[var_3] maps\mp\gametypes\_gameobjects::allowuse("enemy");
      self.otherbombzones[var_3] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    }
  }
}

bombplantedanim(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 playerlinkto(level.sdbombmodel);
  var_0 playerlinkedoffsetenable();

  while(var_0 getcurrentweapon() == self.useweapon) {
    waitframe();
  }

  var_0 unlink();
}

bombplanted(var_0, var_1) {
  level notify("bomb_planted", var_0);
  maps\mp\gametypes\_gamelogic::pausetimer();
  level.bombplanted = 1;
  var_1.objective = 0;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_carrying_bomb", 0);
  }

  var_0.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
  level.tickingobject = var_0.visuals[0];
  level.timelimitoverride = 1;
  level.defuseendtime = int(gettime() + level.bombtimer * 1000);
  setgameendtime(level.defuseendtime);
  setomnvar("ui_bomb_timer", 1);

  if(!level.multibomb) {
    level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
    level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
    maps\mp\_utility::setmlgicons(level.sdbomb, undefined);
    level.sdbomb maps\mp\gametypes\_gameobjects::setdropped();
    level.sdbombmodel = level.sdbomb.visuals[0];
  } else {
    level.sdbombmodel = spawn("script_model", var_1.origin);
    level.sdbombmodel.angles = var_1.angles;
    level.sdbombmodel setModel("npc_search_dstry_bomb");
  }

  level.sdbombmodel thread invalidatecarepackageandgoliathdrop();
  playFXOnTag(common_scripts\utility::getfx("bomb_light_planted"), level.sdbombmodel, "tag_flash");
  var_0 maps\mp\gametypes\_gameobjects::allowuse("none");
  var_0 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  var_2 = var_0 maps\mp\gametypes\_gameobjects::getlabel();
  var_0 thread bombplantedanim(var_1);
  var_3 = var_0.bombdefusetrig;
  var_3.origin = level.sdbombmodel.origin;
  var_4 = [];
  var_5 = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"], var_3, var_4, (0, 0, 32));
  var_5 maps\mp\gametypes\_gameobjects::allowuse("friendly");
  var_5 maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
  var_5 maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_5 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
  var_5 maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defuse" + var_2);
  var_5 maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_defend" + var_2);
  var_5 maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defuse" + var_2);
  var_5 maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_defend" + var_2);
  var_5.label = var_2;
  var_5.onbeginuse = ::onbeginuse;
  var_5.onenduse = ::onenduse;
  var_5.onuse = ::onusedefuseobject;
  var_5.nousebar = 1;
  var_5.id = "defuseObject";
  var_5.useweapon = "search_dstry_bomb_defuse_mp";

  if(var_2 == "_a" || var_2 == "_A") {
    setomnvar("ui_mlg_game_mode_status_1", 1);
  } else if(var_2 == "_b" || var_2 == "_B") {
    setomnvar("ui_mlg_game_mode_status_1", 2);
  }

  maps\mp\_utility::playsoundinspace("mp_snd_bomb_planted", level.sdbombmodel.origin + (0, 0, 1));
  bombtimerwait();
  setomnvar("ui_bomb_timer", 0);
  var_0.visuals[0] maps\mp\gametypes\_gamelogic::stoptickingsound();

  if(level.gameended || level.bombdefused) {
    return;
  }
  level.bombexploded = 1;
  setomnvar("ui_mlg_game_mode_status_1", 0);

  if(isDefined(level.sd_onbombtimerend)) {
    level thread[[level.sd_onbombtimerend]]();
  } else {
    var_6 = level.sdbombmodel.origin;
    var_6 = var_6 + (0, 0, 10);
    level.sdbombmodel hide();
    stopFXOnTag(common_scripts\utility::getfx("bomb_light_planted"), level.sdbombmodel, "tag_flash");

    if(isDefined(var_1)) {
      var_0.visuals[0] radiusdamage(var_6, 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
      var_1 thread maps\mp\_events::bombdetonateevent();
    } else {
      var_0.visuals[0] radiusdamage(var_6, 512, 300, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    var_7 = "bomb_explosion";

    if(isDefined(var_0.trigger.effect)) {
      var_7 = var_0.trigger.effect;
    }

    var_8 = randomfloat(360);
    var_9 = var_6 + (0, 0, 50);
    var_10 = spawnfx(level._effect[var_7], var_9 + (0, 0, 50), (0, 0, 1), (cos(var_8), sin(var_8), 0));
    triggerfx(var_10);
    physicsexplosionsphere(var_9, 200, 100, 3);
    playrumbleonposition("grenade_rumble", var_6);
    earthquake(0.75, 2.0, var_6, 2000);
    thread maps\mp\_utility::playsoundinspace("mp_snd_bomb_detonated", var_6);

    if(isDefined(var_0.exploderindex)) {
      common_scripts\_exploder::exploder(var_0.exploderindex);
    }
  }

  for(var_11 = 0; var_11 < level.bombzones.size; var_11++) {
    level.bombzones[var_11] maps\mp\gametypes\_gameobjects::disableobject();
  }

  var_5 maps\mp\gametypes\_gameobjects::disableobject();
  setgameendtime(0);
  wait 3;
  sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
}

invalidatecarepackageandgoliathdrop() {
  var_0 = self;
  var_1 = 64;
  var_2 = 64;
  var_3 = var_0.origin + (0, 0, -4);
  var_4 = spawn("trigger_radius", var_3, 0, var_1, var_2);
  var_4.targetname = "orbital_node_covered";
  var_4.script_noteworthy = "dont_move_me";

  if(!isDefined(level.orbital_util_covered_volumes)) {
    level.orbital_util_covered_volumes = [];
  }

  var_5 = 0;

  if(level.orbital_util_covered_volumes.size > 0) {
    foreach(var_7 in level.orbital_util_covered_volumes) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }
  }

  if(var_5 == 0) {
    level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_4;
  }

  if(!isDefined(level.goliath_bad_landing_volumes)) {
    level.goliath_bad_landing_volumes = [];
  }

  var_9 = 0;

  if(level.goliath_bad_landing_volumes.size > 0) {
    foreach(var_7 in level.goliath_bad_landing_volumes) {
      if(var_7 == var_4) {
        var_9 = 1;
        break;
      }
    }
  }

  if(var_9 == 0) {
    level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_4;
  }

  var_12 = getnodesinradiussorted(var_3, var_1, 0, var_2);

  if(var_12.size > 0) {
    foreach(var_14 in var_12) {
      nodesetremotemissilename(var_14, "none");
    }
  }

  common_scripts\utility::waittill_any("bomb_defused", "game_ended");
  level.goliath_bad_landing_volumes = common_scripts\utility::array_remove(level.goliath_bad_landing_volumes, var_4);
  level.goliath_bad_landing_volumes = common_scripts\utility::array_remove_duplicates(level.goliath_bad_landing_volumes);
  level.orbital_util_covered_volumes = common_scripts\utility::array_remove(level.orbital_util_covered_volumes, var_4);
  level.orbital_util_covered_volumes = common_scripts\utility::array_remove_duplicates(level.orbital_util_covered_volumes);
  var_4 delete();

  if(var_12.size > 0) {
    foreach(var_14 in var_12) {
      nodesetremotemissilename(var_14, "up");
    }
  }

  return;
}

bombtimerwait() {
  level endon("game_ended");
  level endon("bomb_defused");
  var_0 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime", var_0);
  level thread handlehostmigration(var_0);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

handlehostmigration(var_0) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb_timer_endtime", 0);
  var_1 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_1 > 0) {
    setomnvar("ui_bomb_timer_endtime", var_0 + var_1);
  }
}

ondrop(var_0) {
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_bomb");
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_bomb");
  maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_dropped_enemy_sound"], game["defenders"]);
}

canuse(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 maps\mp\_utility::isjuggernaut()) {
    return 0;
  }

  if(isDefined(var_0.enteringgoliath) && var_0.enteringgoliath == 1) {
    return 0;
  }

  return 1;
}

goliathdropbomb() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self waittill("goliath_equipped");

  if(isDefined(self.carryobject)) {
    self.isbombcarrier = 0;
    self setclientomnvar("ui_carrying_bomb", 0);
    self.carryobject thread maps\mp\gametypes\_gameobjects::setdropped();
  }
}

onusedefuseobject(var_0) {
  var_0 notify("bomb_defused");
  level thread bombdefused();
  maps\mp\gametypes\_gameobjects::disableobject();
  maps\mp\_utility::leaderdialog("bomb_defused_attackers", game["attackers"]);
  maps\mp\_utility::leaderdialog("bomb_defused_defenders", game["defenders"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_enemy_sound"], game["attackers"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_sound"], game["defenders"]);
  var_1 = "defuse";

  if(isDefined(level.bombowner) && maps\mp\_utility::isreallyalive(level.bombowner) && level.bombowner.bombplantedtime + 6000 + level.defusetime * 1000 > gettime()) {
    var_1 = "ninja_defuse";
  }

  if(islastplayeralive(var_0)) {
    var_1 = "last_man_defuse";
  }

  var_0 thread maps\mp\_events::bombdefuseevent(var_1);
}

islastplayeralive(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
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
  setomnvar("ui_bomb_timer", 0);
  setomnvar("ui_mlg_game_mode_status_1", 0);
  level notify("bomb_defused");
  wait 1.5;
  setgameendtime(0);
  sd_endgame(game["defenders"], game["end_reason"]["bomb_defused"]);
}

oncantuse(var_0) {
  var_0 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

sd_endgame(var_0, var_1) {
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
      maps\mp\gametypes\_damage::erasefinalkillcam();
    }
  }

  maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_0, 1);
  thread maps\mp\gametypes\_gamelogic::endgame(var_0, var_1);
}

checkallowspectating() {
  wait 0.05;
  var_0 = 0;

  if(!level.alivecount[game["attackers"]]) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!level.alivecount[game["defenders"]]) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0) {
    maps\mp\gametypes\_spectating::updatespectatesettings();
  }
}

ondeadevent(var_0) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }
  if(var_0 == "all") {
    if(level.bombplanted) {
      sd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    } else {
      sd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    }
  } else if(var_0 == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }
    level thread sd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["defenders"]) {
    level thread sd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
  }
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
  maps\mp\gametypes\_missions::lastmansd();
}

onreset() {}

applybombcarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  while(self ismantling()) {
    wait 0.05;
  }

  while(!self isonground()) {
    wait 0.05;
  }

  if(maps\mp\_utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait 0.05;
  }

  self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];
  self.gamemode_chosenclass = self.class;
  self.gamemode_carrierclass = 1;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastclass = "gamemode";
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, "gamemode");

  if(self.loadoutkeepcurrentkillstreaks) {
    maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
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
    wait 0.05;
  }

  while(self ismantling()) {
    wait 0.05;
  }

  while(!self isonground()) {
    wait 0.05;
  }

  if(maps\mp\_utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait 0.05;
  }

  self.pers["gamemodeLoadout"] = undefined;
  self notify("faux_spawn");
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, self.class);

  if(self.loadoutkeepcurrentkillstreaks) {
    maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
  }

  refillbattery();
}