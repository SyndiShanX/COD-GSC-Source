/********************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\common_bomb_gameobject.gsc
********************************************************/

onprecachegametype() {
  game["bomb_grabbed_sound"] = "mp_suitcase_pickup";
  game["bomb_dropped_sound"] = "h1_mp_war_objective_lost";
  game["bomb_dropped_enemy_sound"] = "h1_mp_war_objective_taken";
  game["bomb_recovered_sound"] = "h1_mp_war_objective_taken";
  game["bomb_planted_sound"] = "mp_obj_notify_pos_med";
  game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_med";
  game["bomb_disarm_sound"] = "mp_obj_notify_pos_lrg";
  game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_lrg";
}

loadbombfx() {
  level._effect["bomb_explosion"] = loadfx("vfx\explosion\mp_gametype_bomb");
}

getcarrybombvisuals(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isdefined(var_1)) {
    var_1 setmodel("wpn_h1_briefcase_bomb_npc");
    return [var_1];
  }

  return undefined;
}

createbombcarryobject(var_0, var_1, var_2, var_3) {
  var_4 = maps\mp\gametypes\_gameobjects::createcarryobject(var_0, var_2, var_3, (0, 0, 32));
  var_4 maps\mp\gametypes\_gameobjects::allowcarry(var_1);
  var_4 maps\mp\gametypes\_gameobjects::setvisibleteam(var_1);

  if(var_1 == "friendly" || var_1 == "any") {
    var_4 maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_bomb");
    var_4 maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_bomb");
  }

  if(var_1 == "enemy" || var_1 == "any") {
    var_4 maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_bomb");
    var_4 maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_bomb");
  }

  var_4.allowweapons = 1;
  var_4.canuseobject = ::canusebomb;

  foreach(var_6 in var_3)
  var_6 notsolid();

  return var_4;
}

canusebomb(var_0) {
  if(!isdefined(var_0))
    return 0;

  if(var_0 maps\mp\_utility::isjuggernaut())
    return 0;

  return 1;
}

oncarrybombpickup(var_0, var_1) {
  level notify("bomb_picked_up");
  var_0.isbombcarrier = 1;

  if(isplayer(var_0)) {
    var_0 thread maps\mp\_matchdata::loggameevent("pickup", var_0.origin);
    var_0 setclientomnvar("ui_carrying_bomb", 1);
  }

  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_escort");
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_escort");

  if(isdefined(var_1))
    maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"], var_1);
  else
    maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"]);

  var_0 playlocalsound(game["bomb_grabbed_sound"]);
}

oncarrybombdrop(var_0, var_1) {
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_bomb");
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_bomb");
  maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"], var_0);
}

createbombzoneobject(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getentarray(var_3.target, "targetname");
  var_7 = maps\mp\gametypes\_gameobjects::createuseobject(var_0, var_3, var_6, (0, 0, 64));
  var_7.label = var_7 maps\mp\gametypes\_gameobjects::getlabel();
  var_7 resetbombzone(var_4, var_1, var_2, var_5);
  var_7.nousebar = 1;
  var_7.id = "bombZone";

  for (var_8 = 0; var_8 < var_6.size; var_8++) {
    if(isdefined(var_6[var_8].script_exploder)) {
      var_7.exploderindex = var_6[var_8].script_exploder;
      var_6[var_8] thread setupkillcament(var_7);
      break;
    }
  }

  return var_7;
}

resetbombzone(var_0, var_1, var_2, var_3) {
  maps\mp\gametypes\_gameobjects::allowuse(var_1);
  maps\mp\gametypes\_gameobjects::setvisibleteam(var_2);
  maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
  maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
  maps\mp\gametypes\_gameobjects::setkeyobject(var_0);
  var_4 = "waypoint_defend";
  var_5 = "waypoint_target";

  if(var_1 == "any") {
    var_4 = "waypoint_target";
    var_5 = "waypoint_target";
  }

  if(var_3) {
    var_4 = var_4 + self.label;
    var_5 = var_5 + self.label;
  }

  maps\mp\gametypes\_gameobjects::set2dicon("friendly", var_4);
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", var_4);
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", var_5);
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", var_5);
  self.useweapon = "briefcase_bomb_mp";
  self.cantuseweapon = "briefcase_bomb_defuse_mp";
  self.bombplantedon = 0;
}

setupkillcament(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateyaw(-45, 0.05);
  wait 0.05;
  var_2 = self.origin + (0, 0, 5);
  var_3 = self.origin + anglestoforward(var_1.angles) * 100 + (0, 0, 128);
  var_4 = bullettrace(var_2, var_3, 0, self);
  self.killcament = spawn("script_model", var_4["position"]);
  self.killcament setscriptmoverkillcam("explosive");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

setupzonefordefusing(var_0) {
  var_1 = "waypoint_defuse";
  var_2 = "waypoint_defend";

  if(var_0) {
    var_1 = var_1 + self.label;
    var_2 = var_2 + self.label;
  }

  maps\mp\gametypes\_gameobjects::allowuse("friendly");
  maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
  maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  maps\mp\gametypes\_gameobjects::setkeyobject(undefined);
  maps\mp\gametypes\_gameobjects::set2dicon("friendly", var_1);
  maps\mp\gametypes\_gameobjects::set3dicon("friendly", var_1);
  maps\mp\gametypes\_gameobjects::set2dicon("enemy", var_2);
  maps\mp\gametypes\_gameobjects::set3dicon("enemy", var_2);
  maps\mp\gametypes\_gameobjects::setvisibleteam("any");
  self.useweapon = "briefcase_bomb_defuse_mp";
  self.cantuseweapon = "briefcase_bomb_mp";
}

onbeginplantbomb(var_0) {
  var_0 allowmelee(0);

  if(!level.silentplant) {
    var_0 maps\mp\_utility::notify_enemy_bots_bomb_used("plant");
    var_0 playsound("mp_snd_bomb_arming");
    level thread play_looping_beep_on_player(var_0);
  }

  var_0.isplanting = 1;
}

onbegindefusebomb(var_0, var_1) {
  var_0 allowmelee(0);

  if(!level.silentplant) {
    var_0 maps\mp\_utility::notify_enemy_bots_bomb_used("defuse");
    var_0 playsound("mp_snd_bomb_disarming");
    level thread play_looping_beep_on_player(var_0);
  }

  var_0.isdefusing = 1;

  if(isdefined(var_1)) {
    var_1 hide();
    self.hiddenmodel = var_1;
  }
}

play_looping_beep_on_player(var_0) {
  var_1 = common_scripts\utility::array_remove(level.players, var_0);

  if(var_1.size)
    var_0 maps\mp\_utility::playloopsoundtoplayers("snd_bomb_button_press_lp", undefined, var_1);
}

stop_looping_beep_on_player(var_0) {
  var_0 common_scripts\utility::stop_loop_sound_on_entity("snd_bomb_button_press_lp");
}

onendusebomb(var_0, var_1) {
  if(!isdefined(var_0)) {
    return;
  }
  var_0 allowmelee(1);

  if(isalive(var_0)) {
    var_0.isdefusing = 0;
    var_0.isplanting = 0;
  }

  level thread stop_looping_beep_on_player(var_0);
  var_0 stopsound("weap_suitcase_raise_plr");

  if(var_1 && isdefined(self.hiddenmodel)) {
    self.hiddenmodel show();
    self.hiddenmodel = undefined;
  }
}

onplayerplantbomb(var_0, var_1, var_2) {
  self notify("bomb_planted");
  thread maps\mp\_events::bombplantevent();
  self.bombplantedtime = gettime();

  if(isplayer(self) && var_0) {
    self.isbombcarrier = 0;
    self setclientomnvar("ui_carrying_bomb", 0);
  }

  self playsound("mp_bomb_plant");
  maps\mp\_utility::playsoundonplayers(game["bomb_planted_sound"], var_1);
  maps\mp\_utility::playsoundonplayers(game["bomb_planted_enemy_sound"], var_2);
  maps\mp\_utility::leaderdialog("bomb_planted");
  level.bombowner = self;
}

onbombplanted(var_0) {
  level notify("bomb_planted", self);
  self.bombplantedon = 1;
  level.timelimitoverride = 1;
  maps\mp\gametypes\_gamelogic::pausetimer();
  level.timepausestart = gettime();
  maps\mp\_utility::playsoundinspace("mp_snd_bomb_planted", var_0);
  self.tickingobject = self.visuals[0];
  self.tickingobject thread playtickingsound();
}

playtickingsound() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  var_0 = level.bombtimer;

  for (;;) {
    self playsound("ui_mp_suitcasebomb_timer");

    if(var_0 > 10) {
      var_0 = var_0 - 1;
      wait 1;
    } else if(var_0 > 4) {
      var_0 = var_0 - 0.5;
      wait 0.5;
    } else if(var_0 > 1) {
      var_0 = var_0 - 0.4;
      wait 0.4;
    } else {
      var_0 = var_0 - 0.3;
      wait 0.3;
    }

    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }
}

stoptickingsound() {
  self notify("stop_ticking");
}

onplayerdefusebomb(var_0, var_1, var_2) {
  self notify("bomb_defused");
  thread maps\mp\_events::bombdefuseevent(var_0);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_sound"], var_1);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_enemy_sound"], var_2);
  maps\mp\_utility::leaderdialog("bomb_defused");
  level.bombowner = undefined;
}

onbombexploded(var_0, var_1, var_2) {
  if(isdefined(var_2)) {
    self.visuals[0] radiusdamage(var_0, 512, var_1, 20, var_2, "MOD_EXPLOSIVE", "bomb_site_mp");
    var_2 thread maps\mp\_events::bombdetonateevent();
  } else
    self.visuals[0] radiusdamage(var_0, 512, var_1, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

  var_3 = "bomb_explosion";

  if(isdefined(self.trigger.effect))
    var_3 = self.trigger.effect;

  var_4 = randomfloat(360);
  var_5 = var_0 + (0, 0, 50);
  var_6 = spawnfx(level._effect[var_3], var_5 + (0, 0, 50), (0, 0, 1), (cos(var_4), sin(var_4), 0));
  triggerfx(var_6);
  physicsexplosionsphere(var_5, 200, 100, 3);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.75, 2.0, var_0, 2000);
  thread maps\mp\_utility::playsoundinspace("h1_briefcase_exp_mid", var_0);

  if(isdefined(self.exploderindex))
    common_scripts\_exploder::exploder(self.exploderindex);
}