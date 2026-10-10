/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_hud_util.gsc
***********************************************/

#using scripts\cp\cp_hud_message;
#using scripts\cp\laststand;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\game_utility;
#namespace cp_hud_util;

function mt_getprogress(refstring) {
  return self getplayerdata("cp", "meritProgress", refstring);
}

function mt_getstate(refstring) {
  return self getplayerdata("cp", "meritState", refstring);
}

function mt_setprogress(refstring, value) {
  if(refstring == "mt_highest_round") {
    currentstate = mt_getstate("mt_highest_round");
    currenttarget = mt_gettarget("mt_highest_round", currentstate);

    if(level.wave_num >= currenttarget) {
      return self setplayerdata("cp", "meritProgress", refstring, currenttarget);
    }

    return;
  }

  return self setplayerdata("cp", "meritProgress", refstring, value);
}

function mt_setstate(refstring, value) {
  return self setplayerdata("cp", "meritState", refstring, value);
}

function mt_gettarget(refstring, state) {
  return int(tablelookup("cp/allMeritsTable.csv", 0, refstring, 10 + state * 3));
}

function player_damage_blood() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

function zom_player_health_overlay_watcher() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  low_health = 0;
  health_changed = 1;

  while(true) {
    if(self.health <= 45 && low_health == 0) {
      if(!self issplitscreenplayer()) {
        self setclienttriggeraudiozonepartialwithfade("painvision", 0.02, "mix", "reverb", "filter");
        self stoplocalsound("deaths_door_out");
        self playlocalsound("deaths_door_in");
      }

      low_health = 1;
    }

    if(low_health && health_changed) {
      if(scripts\cp\laststand::player_in_laststand(self)) {}

      health_changed = 0;
    }

    if(low_health && self.health > 45) {
      self clearclienttriggeraudiozone(0.3);
      self playlocalsound("deaths_door_out");
      self stoplocalsound("deaths_door_in");
      low_health = 0;
      health_changed = 1;
    }

    wait 0.05;
  }
}

function teamplayercardsplash(splash, owner, team, optionalnumber, var_b7abc0284e13ca7a) {
  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    return;
  }

  var_b7abc0284e13ca7a = istrue(var_b7abc0284e13ca7a);

  foreach(player in level.players) {
    if(!isPlayer(player)) {
      continue;
    }

    if(isDefined(team) && player.team != team) {
      continue;
    }

    if(var_b7abc0284e13ca7a && isPlayer(owner) && player == owner) {
      continue;
    }

    player thread scripts\cp\cp_hud_message::showsplash(splash, optionalnumber, owner);
  }
}

function add_hint_string(name, string, optionalfunc) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  assertex(isDefined(name), "Set a name for the hint string. This should be the same as the script_hint on the trigger_hint.");
  assertex(isDefined(string), "Set a string for the hint string. This is the string you want to appear when the trigger is hit.");
  assertex(!isDefined(level.trigger_hint_string[name]), "Tried to redefine hint " + name);
  level.trigger_hint_string[name] = string;
  precachestring(string);

  if(isDefined(optionalfunc)) {
    level.trigger_hint_func[name] = optionalfunc;
  }
}

function fade_over_time(target_alpha, fade_time) {
  assertex(isDefined(target_alpha), "fade_over_time must be passed a target_alpha.");

  if(isDefined(fade_time) && fade_time > 0) {
    self fadeovertime(fade_time);
  }

  self.alpha = target_alpha;

  if(isDefined(fade_time) && fade_time > 0) {
    wait fade_time;
  }
}

function fade_in(time, shader) {
  if(level.missionfailed) {
    return;
  }

  if(!isDefined(time)) {
    time = 0.3;
  }

  overlay = get_optional_overlay(shader);

  if(time > 0) {
    overlay fadeovertime(time);
  }

  overlay.alpha = 0;

  if(time > 0) {
    wait time;
  }
}

function get_optional_overlay(shader) {
  if(!isDefined(shader)) {
    shader = "black";
  }

  return get_overlay(shader);
}

function get_overlay(shader) {
  if(isPlayer(self)) {
    guy = self;
  } else {
    guy = level.player;
  }

  if(!isDefined(guy.overlay)) {
    guy.overlay = [];
  }

  if(!isDefined(guy.overlay[shader])) {
    guy.overlay[shader] = create_client_overlay(shader, 0, guy);
  }

  guy.overlay[shader].sort = 0;
  guy.overlay[shader].foreground = 1;
  return guy.overlay[shader];
}

function fade_out(time, shader) {
  if(!isDefined(time)) {
    time = 0.3;
  }

  overlay = get_optional_overlay(shader);

  if(time > 0) {
    overlay fadeovertime(time);
  }

  overlay.alpha = 1;

  if(time > 0) {
    wait time;
  }
}