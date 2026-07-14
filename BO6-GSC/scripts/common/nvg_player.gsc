/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\nvg_player.gsc
*****************************************/

#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace nvg_player;

function main() {
  function_47ace643225173db();
  utility::create_func_ref("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", &lighting::lerp_dvar);
  utility::create_func_ref("\xec)4\xe5\xdf\xe7\xba\b\x1a\xb9\xb5\x9ftF\x9fx", &function_c8eec1f787088d0a);
}

function function_47ace643225173db() {
  level._effect["\xfed\xdd\xa6\x03\x9e\xfb\nO\xeb\xd2h1\xe0\x82\xcf"] = loadfxasset("d\xe2\xcc\x144\xefi\xb7G \xbb\ad\x94\xe2\xbf\xe0\x88\x82\xb40\x03\xc8\a\x7f\x107\x03\xd0");
  level._effect["\x81\x05\x87\xee\x1enpC\x8b\\8\x10\x1aG*\x81bQ<\xf4"] = loadfxasset("\xf2\x8f`\xf9\x14<\x94\xc8\x87~\x88\xa7\x0fY\x0e\x97\xa0_I\xc1\xc55\xbf\xe1\a>\xa2h\xa8$\xf7uS");
}

function function_31f5c1c2b4d6054f() {
  return isDefined(level._effect["\xfed\xdd\xa6\x03\x9e\xfb\nO\xeb\xd2h1\xe0\x82\xcf"]);
}

function function_c8eec1f787088d0a(player) {
  player endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(level.nvgposoffset)) {
    posoffset = level.nvgposoffset;
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

function player_nvg_lightmodel_extras_watcher() {
  self endon("\x1e\xfd\xd1\xa2\a");
  thread utility::script_func("\a\x8dX\xbc\x95\xc9\xaf7v;\xaf6Z\x9d\x86:m\xb7d\x95c\xd7V\x0ft\x9c\x85\x9b\xebw\x85\xd1\xd8CYr_\xb2s\xe8\xc9\x97");

  while(true) {
    utility::waittill_any("\xdcZv\x86\xd1\xafg\xd27i\xbdn\xaf\xb7\xdc", "\x97pI\xee0\xce\\\xb2\x96r\x18s\xf1l\x8du");

    if(!self.nvg.toggleenabled) {
      continue;
    }

    if(self isnightvisionon()) {
      if(isDefined(self.nvg.on_func)) {
        self thread[[self.nvg.on_func]]();
      }

      function_59689cc478d4d32d();
    } else {
      if(isDefined(self.nvg.off_func)) {
        self thread[[self.nvg.off_func]]();
      }

      function_4dd4da1a6c91f3b();
    }

    thread utility::script_func("\x96\x8d\x13\xf2q\x02\x14[\xaa\xd7\x9cP\xf0p\xcd\xae\xac\x951qP\x8c\xc5\xb7\xee}\x93s6\x98\xe5\xae\xb0\x8d\x11\x9f6\x01{\xd5\x88\xd3\x89\xd3");
  }
}

function update_nvg_light() {
  if(isDefined(self.nvg.lightoverride)) {
    light = self.nvg.lightoverride;
  } else {
    light = "\xfed\xdd\xa6\x03\x9e\xfb\nO\xeb\xd2h1\xe0\x82\xcf";
  }

  if(self isnightvisionon()) {
    if(isDefined(self.nvg.currentlight) && self.nvg.currentlight != light) {
      killfxontag(level._effect[self.nvg.currentlight], self.nvg.light_model, "\xec\xbfK|\au\xcd\xc2\x19<");
      self.nvg.currentlight = undefined;
    }

    if(!isDefined(self.nvg.currentlight)) {
      playFXOnTag(level._effect[light], self.nvg.light_model, "\xec\xbfK|\au\xcd\xc2\x19<");
      self.nvg.currentlight = light;
    }

    return;
  }

  if(isDefined(self.nvg.currentlight)) {
    stopFXOnTag(level._effect[self.nvg.currentlight], self.nvg.light_model, "\xec\xbfK|\au\xcd\xc2\x19<");
    self.nvg.currentlight = undefined;
  }
}

function function_59689cc478d4d32d() {
  earthquake(0.1, 0.35, self.origin, 1000);
  self playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
  nvg_mb_on(0.05);
  nvg_flir_on();

  if(getdvarint(@ "hash_770dcc95c434a4a7", 0) == 1) {
    self.nvg.light_model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", (0, 0, 0));
    self.nvg.light_model setModel("\xec\xbfK|\au\xcd\xc2\x19<");
    self.nvg.light_model thread utility::script_func("\xec)4\xe5\xdf\xe7\xba\b\x1a\xb9\xb5\x9ftF\x9fx", self);

    if(isDefined(self.nvg.var_5fae182406d9b233)) {
      self[[self.nvg.var_5fae182406d9b233]]();
    } else {
      update_nvg_light();
    }
  }

  self enablephysicaldepthoffieldscripting(1);
  self setphysicaldepthoffield(22, 1800);
  self setdepthoffield(1, 200, 5000, 10000, 10, 0);
  self setviewmodeldepthoffield(4, 45, 6);
}

function function_4dd4da1a6c91f3b() {
  earthquake(0.07, 0.25, self.origin, 1000);
  self playRumbleOnEntity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");

  if(isDefined(self.nvg.light_model)) {
    killfxontag(level._effect["\xfed\xdd\xa6\x03\x9e\xfb\nO\xeb\xd2h1\xe0\x82\xcf"], self.nvg.light_model, "\xec\xbfK|\au\xcd\xc2\x19<");
  }

  nvg_mb_off();
  nvg_flir_off();

  if(isDefined(self.nvg.var_4a45089a983baa07)) {
    self[[self.nvg.var_4a45089a983baa07]]();
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

  thread utility::script_func("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", @ "r_mbradialoverridechromaticaberration", 10.5, time);
  thread utility::script_func("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", @ "r_mbradialoverridedistortion", 0.025, time);
  thread utility::script_func("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", @ "r_mbradialoverrideradius", 0.8, time);
  thread utility::script_func("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", @ "r_mbradialoverridestrength", 0.006, time);
  self setlensprofiledistort("\xd5\x91\xb0a\xff^\x10\aBz\x99\xdb*\r\xdd\xcd", 0, 0, 0.9, 0.93);
}

function nvg_mb_off() {
  time = 0.1;
  thread utility::script_func("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", @ "r_mbradialoverridechromaticaberration", 0, time);
  thread utility::script_func("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", @ "r_mbradialoverridedistortion", 0, time);
  thread utility::script_func("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", @ "r_mbradialoverrideradius", 0, time);
  thread utility::script_func("\xa8\x11\xc3\xabG\xedL(t8\x0e\xf7\x901", @ "r_mbradialoverridestrength", 0, time);
  self setlensprofiledistort("\r+x5");
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

  thread utility::script_func("\x9c\x11\xb0L\f_\xd0m\x04\x10\x1b");
  lerp_sunintensity(self.nvg.ogsunintensity, 0, 0.2);
}

function nvg_flir_off() {
  if(!self.nvg.flir) {
    return;
  }

  self setviewmodel(self.nvg.origviewmodel);
  thread utility::script_func("Vg{\x94rc#\xf4\xf3\xa7l\x88");
  lerp_sunintensity(0, self.nvg.ogsunintensity, 0.2);
}

function lerp_sunintensity(current, target, time) {
  thread lerp_sunintensity_internal(current, target, time);
}

function lerp_sunintensity_internal(curr, intensity, time) {
  level notify("\xc9\x873/\xe1S{\xe0\x18\xa5<xh[\xdfak");
  level endon("\xc9\x873/\xe1S{\xe0\x18\xa5<xh[\xdfak");
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

function function_de81faf9c0a58a2c() {
  if(!utility::issp()) {
    return;
  }

  assert(isPlayer(self), "<dev string:x24>");
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "bg_tactical_ads_enabled", 1);
  function_7149f7a746b0cd52();
  utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "bg_tactical_ads_enabled", 1);
}

function private function_7149f7a746b0cd52() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("3\xe3'{D\xce\xd3\xff\\\a\xa7");
  self notify("\x9b\xaf\xd7*\xf24\x1a\xf6V\xb7\xd4\x8c\x0f|\xd4{G[\xf2=s\xa4N\x90\n\xb5\xee\xbde");
  self endon("\x9b\xaf\xd7*\xf24\x1a\xf6V\xb7\xd4\x8c\x0f|\xd4{G[\xf2=s\xa4N\x90\n\xb5\xee\xbde");

  if(utility::issp()) {
    while(!getomnvar("7z\xb0\x05\x18\xcaSJp^\xcf[\n\xcd|")) {
      wait 1;
    }
  }

  while(true) {
    if(self isnightvisionon()) {
      utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "bg_tactical_ads_enabled", 0);
      function_1ecfa8334c3623af(1);
      waitframe();
      continue;
    }

    utility::noself_func("(+\xc4\xf5\x06V`\xd8\xb5\v\x84S", @ "bg_tactical_ads_enabled", 1);
    currweapon = self getcurrentweapon();
    var_641ff2150957a126 = self function_342178406699055f(currweapon);

    if(self playerads() != 0 && var_641ff2150957a126) {
      function_1ecfa8334c3623af(0);
    } else {
      function_1ecfa8334c3623af(1);
    }

    waitframe();
  }
}

function private function_1ecfa8334c3623af(enabled) {
  if(utility::issp()) {
    if(enabled) {
      self setactionslot(2, "\x11\xac !5B5kw\xb5b");
    } else {
      self setactionslot(2, "");
    }

    setomnvar("7z\xb0\x05\x18\xcaSJp^\xcf[\n\xcd|", enabled);
  }
}