/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\nvg_player.gsc
***********************************************/

#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace nvg_player;

function main() {
  function_d357a2923790fad6();
  scripts\engine\utility::create_func_ref("lerp_savedDvar", &scripts\common\lighting::lerp_dvar);
  scripts\engine\utility::create_func_ref("LinkToPlayerView", &function_c3d429c05cfee6bf);
}

function function_d357a2923790fad6() {
  level._effect["player_nvg_light"] = loadfx("vfx/iw9/core/nvg/vfx_nvg_light_player.vfx");
  level._effect["player_nvg_light_ext"] = loadfx("vfx/iw8/core/nvg/vfx_nvg_light_player_ext.vfx");
}

function function_8d3da9226f5c8c0e() {
  return isDefined(level._effect["player_nvg_light"]);
}

function function_c3d429c05cfee6bf(player) {
  player endon("death");
  self endon("death");

  if(isDefined(level.var_ce78d0e4ea4e7d3b)) {
    posoffset = level.var_ce78d0e4ea4e7d3b;
  } else {
    posoffset = (1, 6, 0.1);
  }

  for(;;) {
    self.origin = player getEye() + rotatevector(posoffset, player getgunangles());
    self.angles = player getgunangles();
    end = self.origin + anglesToForward(self.angles) * 30;
    wait 0.05;
  }
}

function function_296ee731835b1e4b() {
  self endon("death");
  thread script_func("player_nvg_lightmodel_extras_watcher_entry");

  while(true) {
    waittill_either("night_vision_on", "night_vision_off");

    if(!self.nvg.toggleenabled) {
      continue;
    }

    if(self isnightvisionon()) {
      if(isDefined(self.nvg.on_func)) {
        self thread[[self.nvg.on_func]]();
      }

      function_2989c93c8324fbec();
    } else {
      if(isDefined(self.nvg.off_func)) {
        self thread[[self.nvg.off_func]]();
      }

      function_7f250a146a7d8806();
    }

    thread script_func("player_nvg_lightmodel_extras_watcher_trigger");
  }
}

function update_nvg_light() {
  if(isDefined(self.nvg.lightoverride)) {
    light = self.nvg.lightoverride;
  } else {
    light = "player_nvg_light";
  }

  if(self isnightvisionon()) {
    if(isDefined(self.nvg.currentlight) && self.nvg.currentlight != light) {
      killfxontag(level._effect[self.nvg.currentlight], self.nvg.light_model, "tag_origin");
      self.nvg.currentlight = undefined;
    }

    if(!isDefined(self.nvg.currentlight)) {
      playFXOnTag(level._effect[light], self.nvg.light_model, "tag_origin");
      self.nvg.currentlight = light;
    }

    return;
  }

  if(isDefined(self.nvg.currentlight)) {
    stopFXOnTag(level._effect[self.nvg.currentlight], self.nvg.light_model, "tag_origin");
    self.nvg.currentlight = undefined;
  }
}

function function_2989c93c8324fbec() {
  earthquake(0.1, 0.35, self.origin, 1000);
  self playRumbleOnEntity("damage_heavy");
  nvg_mb_on(0.05);
  nvg_flir_on();

  if(getdvarint(@ "hash_770dcc95c434a4a7", 0) == 1) {
    self.nvg.light_model = spawn("script_model", (0, 0, 0));
    self.nvg.light_model setModel("tag_origin");
    self.nvg.light_model thread script_func("LinkToPlayerView", self);

    if(isDefined(self.nvg.var_e29ac796d39377ea)) {
      self[[self.nvg.var_e29ac796d39377ea]]();
    } else {
      update_nvg_light();
    }
  }

  self enablephysicaldepthoffieldscripting(1);
  self setphysicaldepthoffield(22, 1800);
  self setdepthoffield(1, 200, 5000, 10000, 10, 0);
  self setviewmodeldepthoffield(4, 45, 6);
}

function function_7f250a146a7d8806() {
  earthquake(0.07, 0.25, self.origin, 1000);
  self playRumbleOnEntity("damage_light");

  if(isDefined(self.nvg.light_model)) {
    killfxontag(level._effect["player_nvg_light"], self.nvg.light_model, "tag_origin");
  }

  nvg_mb_off();
  nvg_flir_off();

  if(isDefined(self.nvg.var_81ada7ac82bf15f6)) {
    self[[self.nvg.var_81ada7ac82bf15f6]]();
  } else {
    update_nvg_light();
  }

  if(isDefined(self.nvg.light_model)) {
    self.nvg.light_model delete();
  }

  self setdepthoffield(1, 200, 5000, 10000, 3.9, 0);
  self setviewmodeldepthoffield(4, 30, 0);
  self disablephysicaldepthoffieldscripting();
}

function nvg_mb_on(time) {
  if(self.nvg.flir) {
    return;
  }

  if(isDefined(self.nvg.no_rblur) && self.nvg.no_rblur) {
    return;
  }

  thread script_func("lerp_savedDvar", @ "hash_83bbe73116f488d6", 10.5, time);
  thread script_func("lerp_savedDvar", @ "hash_ed28298c207316ae", 0.025, time);
  thread script_func("lerp_savedDvar", @ "hash_979b5474be3b9b47", 0.8, time);
  thread script_func("lerp_savedDvar", @ "hash_960ef00238357bbc", 0.006, time);
  self setlensprofiledistort("compact portable", 0, 0, 0.9, 0.93);
}

function nvg_mb_off() {
  time = 0.1;
  thread script_func("lerp_savedDvar", @ "hash_83bbe73116f488d6", 0, time);
  thread script_func("lerp_savedDvar", @ "hash_ed28298c207316ae", 0, time);
  thread script_func("lerp_savedDvar", @ "hash_979b5474be3b9b47", 0, time);
  thread script_func("lerp_savedDvar", @ "hash_960ef00238357bbc", 0, time);
  self setlensprofiledistort("none");
}

function nvg_flir_on() {
  if(!self.nvg.flir) {
    return;
  }

  if(!isDefined(self.nvg.ogsunintensity)) {
    suncolorandintensity = getmapsuncolorandintensity();
    self.nvg.ogsunintensity = suncolorandintensity[3];
  }

  if(isDefined(self.nvg.viewmodeloverride)) {
    self setviewmodel(self.nvg.viewmodeloverride);
  }

  thread script_func("nvg_flir_on");
  lerp_sunintensity(self.nvg.ogsunintensity, 0, 0.2);
}

function nvg_flir_off() {
  if(!self.nvg.flir) {
    return;
  }

  self setviewmodel(self.nvg.origviewmodel);
  thread script_func("nvg_flir_off");
  lerp_sunintensity(0, self.nvg.ogsunintensity, 0.2);
}

function lerp_sunintensity(current, target, time) {
  thread lerp_sunintensity_internal(current, target, time);
}

function lerp_sunintensity_internal(curr, intensity, time) {
  level notify("lerp_sunintensity");
  level endon("lerp_sunintensity");
  range = intensity - curr;
  interval = 0.05;
  count = int(time / interval);

  if(count > 0) {
    delta = range / count;

    while(count) {
      curr += delta;
      setsuncolorandintensity(curr);
      wait interval;
      count--;
    }
  }

  setsuncolorandintensity(intensity);
}

function function_c105076398ebbb59() {
  if(!iscp() && !issp()) {
    return;
  }

  assertex(isPlayer(self), "Tried to monitor NVG on a non-player!");
  noself_func("setsaveddvar", @ "hash_27d9b85248b3401c", 1);
  function_49d7693fc9faebff();
  noself_func("setsaveddvar", @ "hash_27d9b85248b3401c", 1);
}

function private function_49d7693fc9faebff() {
  self endon("death_or_disconnect");
  self endon("nvg_removed");
  self notify("watching_nvg_for_tactical_ads");
  self endon("watching_nvg_for_tactical_ads");

  if(iscp()) {
    var_8d100d16b384050b = 0;

    while(!var_8d100d16b384050b) {
      var_8d100d16b384050b = isDefined(self.pers) && istrue(self.pers["useNVG"]) || isDefined(level.var_1b908bf18691b097) && istrue(level.var_1b908bf18691b097.nvg);
      wait 1;
    }
  } else if(issp()) {
    while(!getomnvar("ui_nvg_equipped")) {
      wait 1;
    }
  }

  while(true) {
    if(self isnightvisionon()) {
      noself_func("setsaveddvar", @ "hash_27d9b85248b3401c", 0);
      function_25db5300b14bf3ee(1);
      waitframe();
      continue;
    }

    noself_func("setsaveddvar", @ "hash_27d9b85248b3401c", 1);
    currweapon = self getcurrentweapon();
    var_bd111b88a374ca7 = self function_f033d1a86348766a(currweapon);

    if(self playerads() != 0 && var_bd111b88a374ca7) {
      function_25db5300b14bf3ee(0);
    } else {
      function_25db5300b14bf3ee(1);
    }

    waitframe();
  }
}

function private function_25db5300b14bf3ee(enabled) {
  if(iscp()) {
    if(enabled) {
      scripts\common\values::reset("tacticalADS", "nvg");
    } else {
      scripts\common\values::set("tacticalADS", "nvg", 0);
    }

    return;
  }

  if(issp()) {
    if(enabled) {
      self setactionslot(2, "nightvision");
    } else {
      self setactionslot(2, "");
    }

    setomnvar("ui_nvg_equipped", enabled);
  }
}