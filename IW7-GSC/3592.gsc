/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3592.gsc
************************/

init() {
  level._effect["transponder"] = loadfx("vfx\iw7\_requests\mp\vfx_smokewall");
  level._effect["transponder_activate"] = loadfx("vfx\iw7\_requests\mp\vfx_transponder_activate");
  level._effect["direction_indicator_close"] = loadfx("vfx\iw7\_requests\mp\vfx_transponder_direction_indicator_close");
  level._effect["direction_indicator_mid"] = loadfx("vfx\iw7\_requests\mp\vfx_transponder_direction_indicator_mid");
  level._effect["direction_indicator_far"] = loadfx("vfx\iw7\_requests\mp\vfx_transponder_direction_indicator_far");
  self.var_E561 = 0;
  self.var_9F2F = 0;
  self.var_9FB0 = 0;
  scripts\mp\powerloot::func_DF06("power_transponder", ["passive_increased_range", "passive_spot_enemies", "passive_ripper"]);
}

func_F5D3() {}

removetransponder() {
  self notify("remove_transponder");
}

transponder_place(param_00) {
  if(checkvalidplacementstate()) {
    transponder_throw(param_00);
    return;
  }

  thread placementfailed(param_00);
}

transponder_use(param_00) {
  self.var_9F2F = scripts\mp\powerloot::func_D779("power_transponder", "passive_ripper");
  self.var_9FB0 = scripts\mp\powerloot::func_D779("power_transponder", "passive_spot_enemies");
  transponder_throw(param_00);
}

transponder_throw(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("remove_transponder");
  var_01 = "power_transponder";
  self setclientomnvar("ui_transponder_range_finder", 0);
  self setclientomnvar("ui_show_transponder_outofrange", 0);
  if(!scripts\mp\utility::isreallyalive(self)) {
    param_00 delete();
    return;
  }

  param_00 thread scripts\mp\weapons::ondetonateexplosive();
  thread watchtransponderdetonation(param_00);
  param_00 setotherent(self);
  param_00.activated = 0;
  scripts\mp\weapons::ontacticalequipmentplanted(param_00, "power_transponder");
  thread transponderrangefinder(param_00);
  param_00 thread transponderactivate();
  param_00 thread scripts\mp\weapons::func_3343();
  param_00 thread transponderdamage();
  param_00 thread scripts\mp\weapons::func_66B4(1);
  param_00 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  level thread scripts\mp\weapons::monitordisownedequipment(self, param_00);
}

watchtransponderdetonation(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("transponder_alt_detonate");
  self endon("transponder_detonated");
  param_00 waittill("activated");
  for(;;) {
    self setclientomnvar("ui_show_transponder_outofrange", 0);
    self waittillmatch("transponder_mp", "detonate");
    var_01 = scripts\mp\powerloot::func_7FC5("power_transponder", 1801);
    if(isDefined(param_00) && param_00.activated && length2d(param_00.origin - self.origin) <= var_01) {
      transponder_teleportplayer(param_00);
      transponderdetonateallcharges();
      continue;
    }

    if(isDefined(param_00)) {
      self setclientomnvar("ui_show_transponder_outofrange", 1);
      scripts\engine\utility::waitframe();
    }

    continue;
  }
}

transponderdamage() {
  var_00 = self.triggerportableradarping;
  var_00 waittill("transponder_update");
  var_00 setclientomnvar("ui_transponder_range_finder", 0);
}

transponderdetonateallcharges() {
  foreach(var_01 in self.plantedtacticalequip) {
    if(isDefined(var_01) && var_01.weapon_name == "transponder_mp") {
      var_01 scripts\mp\weapons::deleteexplosive();
      scripts\engine\utility::array_remove(self.plantedtacticalequip, var_01);
    }
  }

  self notify("transponder_update", 0);
  waittillframeend;
  self notify("transponder_detonated");
}

watchtransponderaltdetonation(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("transponder_detonated");
  param_00 waittill("activated");
  for(;;) {
    self waittill("transponder_alt_detonate");
    var_01 = self getcurrentweapon();
    if(var_01 != "transponder_mp") {
      if(isDefined(param_00) && param_00.activated) {
        transponder_teleportplayer(param_00);
        transponderdetonateallcharges();
        continue;
      }

      continue;
    }
  }
}

watchtransponderaltdetonate(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("transponder_detonated");
  level endon("game_ended");
  param_00 waittill("activated");
  var_01 = 0;
  for(;;) {
    if(self usebuttonpressed()) {
      var_01 = 0;
      while(self usebuttonpressed()) {
        var_01 = var_01 + 0.05;
        wait(0.05);
      }

      if(var_01 >= 0.5) {
        continue;
      }

      var_01 = 0;
      while(!self usebuttonpressed() && var_01 < 0.5) {
        var_01 = var_01 + 0.05;
        wait(0.05);
      }

      if(var_01 >= 0.5) {
        continue;
      }

      if(!self.plantedtacticalequip.size) {
        return;
      }

      if(self ismantling()) {
        self cancelmantle();
      }

      if(isDefined(self.var_9FF6)) {
        scripts\mp\archetypes\archsniper::func_639B();
      }

      self notify("transponder_alt_detonate");
    }

    wait(0.05);
  }
}

transponderactivate() {
  self waittill("missile_stuck", var_00);
  wait(0.05);
  if(!checkvalidposition()) {
    self.triggerportableradarping placementfailed(self);
    return;
  }

  self.triggerportableradarping notify("powers_transponder_used", 1);
  self notify("activated");
  self.activated = 1;
  self.triggerportableradarping func_5616(self);
  scripts\mp\weapons::makeexplosiveusable();
  scripts\mp\weapons::explosivehandlemovers(var_00);
}

transponder_teleportplayer(param_00) {
  self notify("transponder_teleportPlayer");
  var_01 = undefined;
  var_02 = getclosestpointonnavmesh(param_00.origin);
  var_01 = getclosestnodeinsight(var_02);
  if(isDefined(var_01)) {
    thread activationeffects(self.origin, param_00.origin);
    self playlocalsound("ghost_use_transponder");
    self setorigin(var_01.origin + (0, 0, 20));
    if(self.var_9FB0) {
      thread func_12694();
    }

    if(self.var_9F2F) {
      thread func_12691();
      return;
    }

    return;
  }

  iprintlnbold("Transponder lost connection");
  self.triggerportableradarping transponderdetonateallcharges();
}

activationeffects(param_00, param_01) {
  wait(0.1);
  var_02 = "direction_indicator_far";
  var_03 = length2d(param_00 - param_01);
  if(var_03 < 1024) {
    var_02 = "direction_indicator_close";
  } else if(var_03 < 2048) {
    var_02 = "direction_indicator_mid";
  }

  playFX(scripts\engine\utility::getfx(var_02), param_00, (0, 0, 1), anglesToForward(vectortoangles(param_01 - param_00)));
  playFX(scripts\engine\utility::getfx("transponder_activate"), param_01);
}

runtranspondersickness() {
  self endon("disconnect");
  scripts\mp\killstreaks\_emp_common::func_20C3();
  self shellshock("flashbang_mp", 1.2);
  scripts\engine\utility::waittill_any_timeout_1(1.2, "death");
  scripts\mp\killstreaks\_emp_common::func_E0F3();
}

transponderrangefinder(param_00) {
  param_00 endon("death");
  self endon("disconnect");
  thread transponderwatchfordisuse(param_00);
  while(isDefined(param_00)) {
    var_01 = distance2d(self.origin, param_00.origin);
    self setclientomnvar("ui_transponder_range_finder", int(var_01));
    wait(0.1);
  }
}

transponderwatchfordisuse(param_00) {
  param_00 waittill("deleted_equipment");
  self setclientomnvar("ui_transponder_range_finder", 0);
}

checkvalidposition() {
  var_00 = getclosestpointonnavmesh(self.origin);
  var_01 = self.triggerportableradarping scripts\mp\powerloot::func_7FC5("power_transponder", 256);
  if(distance(self.origin, var_00) > var_01) {
    return 0;
  }

  var_02 = getclosestnodeinsight(var_00);
  return isDefined(var_02);
}

checkvalidplacementstate() {
  return !self iswallrunning() && !self isonladder() && self isonground();
}

placementfailed(param_00) {
  self iprintlnbold("TRANSPONDER LOST COMMUNICATION");
  self notify("powers_transponder_used", 0);
  self.activated = 0;
  transponderdetonateallcharges();
  self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

func_897B(param_00) {
  param_00 endon("death");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self iprintlnbold("Transponder Hacked!");
  wait(2);
  self notify("transponder_alt_detonate");
}

func_5616(param_00) {
  scripts\mp\powers::func_D727("power_transponder");
  thread func_5617(param_00);
}

func_5617(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("remove_transponder");
  param_00 waittill("death");
  scripts\mp\powers::func_D72D("power_transponder");
}

func_12694() {
  self endon("death");
  self endon("disconnect");
  var_00 = 0;
  var_01 = 0.8;
  var_02 = 0;
  var_03 = 650;
  self.var_E561 = 0;
  foreach(var_05 in level.participants) {
    if(!scripts\mp\utility::isreallyalive(var_05)) {
      continue;
    }

    if(!scripts\mp\utility::isenemy(var_05)) {
      continue;
    }

    if(var_05 scripts\mp\utility::_hasperk("specialty_noplayertarget") || var_05 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_06 = var_05.origin - self.origin;
    if(1 && vectordot(anglesToForward(self.angles), var_06) < 0) {
      continue;
    }

    var_07 = var_03 * var_03;
    if(length2dsquared(var_06) > var_07) {
      continue;
    }

    var_00++;
    thread func_12695(var_05, distance2d(self.origin, var_05.origin) / var_03, var_01);
    var_02 = 1;
  }
}

func_12695(param_00, param_01, param_02) {
  wait(param_02 * param_01);
  var_03 = scripts\mp\utility::outlineenableforplayer(param_00, "orange", self, 0, 0, "level_script");
  param_00 scripts\mp\hud_message::showmiscmessage("spotted");
  var_04 = 3;
  func_13AA0(var_03, param_00, var_04);
}

func_13AA0(param_00, param_01, param_02) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(param_02, "leave");
  if(isDefined(param_01)) {
    scripts\mp\utility::outlinedisable(param_00, param_01);
  }
}

func_12691() {
  level._effect["reaper_fisheye"] = loadfx("vfx\code\screen\vfx_scrnfx_reaper_fisheye");
  self.var_12697 = ["specialty_fastermelee", "specialty_extendedmelee", "specialty_stun_resistance", "specialty_detectexplosive"];
  foreach(var_01 in self.var_12697) {
    scripts\mp\utility::giveperk(var_01);
  }

  var_03 = self.maxhealth;
  self setsuit("reaper_mp");
  self.maxhealth = 170;
  self.health = self.maxhealth;
  level._effect["reaper_swipe_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_swipe_trail");
  self.var_B62A = spawn("script_model", self.origin);
  self.var_B62A setModel("tag_origin");
  thread func_13ACC();
  thread func_AD77(var_03);
}

func_AD77(param_00) {
  scripts\engine\utility::waittill_any_timeout_1(5, "death");
  thread func_E164(param_00);
}

func_13ACC(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("removeRipper");
  level endon("game_ended");
  var_01 = (0, 0, 4);
  for(;;) {
    self waittill("melee_fired");
    var_02 = self.origin + var_01;
    var_03 = anglesToForward(self.angles);
    var_04 = anglestoright(self.angles);
    var_05 = func_36DB(param_00);
    var_05 = var_05 + var_01;
    var_06 = var_02 + var_04 * 64;
    var_07 = var_02 - var_04 * 32;
    var_08 = rotatevector(var_04, (0, 45, 0));
    var_09 = var_02 + var_08 * 64;
    var_0A = rotatevector(var_04, (0, 135, 0));
    var_0B = var_02 + var_0A * 32;
    self.var_B62A.origin = var_06;
    wait(0.05);
    playFXOnTag(level._effect["reaper_swipe_trail"], self.var_B62A, "tag_origin");
    wait(0.075);
    self.var_B62A.origin = var_09;
    wait(0.075);
    self.var_B62A.origin = var_05;
    thread func_20D9(var_05);
    wait(0.075);
    self.var_B62A.origin = var_0B;
    wait(0.075);
    self.var_B62A.origin = var_07;
    wait(0.05);
    stopFXOnTag(level._effect["reaper_swipe_trail"], self.var_B62A, "tag_origin");
  }
}

func_40B3() {
  if(isDefined(self.var_C7FF)) {
    self.var_C7FF delete();
  }
}

func_E164(param_00) {
  self notify("removeRipper");
  self.var_9F2E = 0;
  self.var_9FB0 = 0;
  self.var_E561 = 0;
  foreach(var_02 in self.var_12697) {
    scripts\mp\utility::removeperk(var_02);
  }

  self.var_12697 = undefined;
  self setsuit("scout_mp");
  self.maxhealth = param_00;
  self setclientomnvar("ui_odin", -1);
  func_40B3();
}

func_20D9(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("removeRipper");
  var_01 = distance2d(self.origin, param_00) / 2;
  self radiusdamage(self.origin + (0, 0, 36), var_01, 250, 135, self, "MOD_MELEE", "iw7_reaperblade_mp");
}

func_36DB(param_00) {
  self endon("removeRipper");
  var_01 = (0, 0, 0);
  var_02 = self.origin + var_01;
  var_03 = anglesToForward(self.angles);
  var_04 = anglestoright(self.angles);
  var_05 = self getvelocity();
  var_06 = vectordot(var_05, self.angles);
  var_07 = length(var_05);
  if(var_07 < 64) {
    var_07 = 92;
  }

  if(var_07 > 64 && var_07 < 128) {
    var_07 = 128;
  }

  if(var_07 > 350) {
    var_07 = 700;
  }

  if(var_07 > 200) {
    var_07 = 328;
  }

  if(var_07 > 128) {
    var_07 = 256;
  }

  if(var_06 < 1) {
    var_07 = 64;
  }

  if(isDefined(param_00)) {
    var_07 = param_00;
  }

  return var_02 + var_03 * var_07;
}