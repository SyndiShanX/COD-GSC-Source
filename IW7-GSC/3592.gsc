/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3592.gsc
*********************************************/

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

transponder_place(var_0) {
  if(checkvalidplacementstate()) {
    transponder_throw(var_0);
    return;
  }

  thread placementfailed(var_0);
}

transponder_use(var_0) {
  self.var_9F2F = scripts\mp\powerloot::func_D779("power_transponder", "passive_ripper");
  self.var_9FB0 = scripts\mp\powerloot::func_D779("power_transponder", "passive_spot_enemies");
  transponder_throw(var_0);
}

transponder_throw(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("remove_transponder");
  var_1 = "power_transponder";
  self setclientomnvar("ui_transponder_range_finder", 0);
  self setclientomnvar("ui_show_transponder_outofrange", 0);
  if(!scripts\mp\utility::isreallyalive(self)) {
    var_0 delete();
    return;
  }

  var_0 thread scripts\mp\weapons::ondetonateexplosive();
  thread watchtransponderdetonation(var_0);
  var_0 setotherent(self);
  var_0.activated = 0;
  scripts\mp\weapons::ontacticalequipmentplanted(var_0, "power_transponder");
  thread transponderrangefinder(var_0);
  var_0 thread transponderactivate();
  var_0 thread scripts\mp\weapons::func_3343();
  var_0 thread transponderdamage();
  var_0 thread scripts\mp\weapons::func_66B4(1);
  var_0 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  level thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
}

watchtransponderdetonation(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("transponder_alt_detonate");
  self endon("transponder_detonated");
  var_0 waittill("activated");
  for(;;) {
    self setclientomnvar("ui_show_transponder_outofrange", 0);
    self waittillmatch("transponder_mp", "detonate");
    var_1 = scripts\mp\powerloot::func_7FC5("power_transponder", 1801);
    if(isDefined(var_0) && var_0.activated && length2d(var_0.origin - self.origin) <= var_1) {
      transponder_teleportplayer(var_0);
      transponderdetonateallcharges();
      continue;
    }

    if(isDefined(var_0)) {
      self setclientomnvar("ui_show_transponder_outofrange", 1);
      scripts\engine\utility::waitframe();
    }

    continue;
  }
}

transponderdamage() {
  var_0 = self.triggerportableradarping;
  var_0 waittill("transponder_update");
  var_0 setclientomnvar("ui_transponder_range_finder", 0);
}

transponderdetonateallcharges() {
  foreach(var_1 in self.plantedtacticalequip) {
    if(isDefined(var_1) && var_1.weapon_name == "transponder_mp") {
      var_1 scripts\mp\weapons::deleteexplosive();
      scripts\engine\utility::array_remove(self.plantedtacticalequip, var_1);
    }
  }

  self notify("transponder_update", 0);
  waittillframeend;
  self notify("transponder_detonated");
}

watchtransponderaltdetonation(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("transponder_detonated");
  var_0 waittill("activated");
  for(;;) {
    self waittill("transponder_alt_detonate");
    var_1 = self getcurrentweapon();
    if(var_1 != "transponder_mp") {
      if(isDefined(var_0) && var_0.activated) {
        transponder_teleportplayer(var_0);
        transponderdetonateallcharges();
        continue;
      }

      continue;
    }
  }
}

watchtransponderaltdetonate(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("transponder_detonated");
  level endon("game_ended");
  var_0 waittill("activated");
  var_1 = 0;
  for(;;) {
    if(self usebuttonpressed()) {
      var_1 = 0;
      while(self usebuttonpressed()) {
        var_1 = var_1 + 0.05;
        wait(0.05);
      }

      if(var_1 >= 0.5) {
        continue;
      }

      var_1 = 0;
      while(!self usebuttonpressed() && var_1 < 0.5) {
        var_1 = var_1 + 0.05;
        wait(0.05);
      }

      if(var_1 >= 0.5) {
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
  self waittill("missile_stuck", var_0);
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
  scripts\mp\weapons::explosivehandlemovers(var_0);
}

transponder_teleportplayer(var_0) {
  self notify("transponder_teleportPlayer");
  var_1 = undefined;
  var_2 = getclosestpointonnavmesh(var_0.origin);
  var_1 = getclosestnodeinsight(var_2);
  if(isDefined(var_1)) {
    thread activationeffects(self.origin, var_0.origin);
    self playlocalsound("ghost_use_transponder");
    self setorigin(var_1.origin + (0, 0, 20));
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

activationeffects(var_0, var_1) {
  wait(0.1);
  var_2 = "direction_indicator_far";
  var_3 = length2d(var_0 - var_1);
  if(var_3 < 1024) {
    var_2 = "direction_indicator_close";
  } else if(var_3 < 2048) {
    var_2 = "direction_indicator_mid";
  }

  playFX(scripts\engine\utility::getfx(var_2), var_0, (0, 0, 1), anglesToForward(vectortoangles(var_1 - var_0)));
  playFX(scripts\engine\utility::getfx("transponder_activate"), var_1);
}

runtranspondersickness() {
  self endon("disconnect");
  scripts\mp\killstreaks\_emp_common::func_20C3();
  self shellshock("flashbang_mp", 1.2);
  scripts\engine\utility::waittill_any_timeout_1(1.2, "death");
  scripts\mp\killstreaks\_emp_common::func_E0F3();
}

transponderrangefinder(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  thread transponderwatchfordisuse(var_0);
  while(isDefined(var_0)) {
    var_1 = distance2d(self.origin, var_0.origin);
    self setclientomnvar("ui_transponder_range_finder", int(var_1));
    wait(0.1);
  }
}

transponderwatchfordisuse(var_0) {
  var_0 waittill("deleted_equipment");
  self setclientomnvar("ui_transponder_range_finder", 0);
}

checkvalidposition() {
  var_0 = getclosestpointonnavmesh(self.origin);
  var_1 = self.triggerportableradarping scripts\mp\powerloot::func_7FC5("power_transponder", 256);
  if(distance(self.origin, var_0) > var_1) {
    return 0;
  }

  var_2 = getclosestnodeinsight(var_0);
  return isDefined(var_2);
}

checkvalidplacementstate() {
  return !self iswallrunning() && !self isonladder() && self isonground();
}

placementfailed(var_0) {
  self iprintlnbold("TRANSPONDER LOST COMMUNICATION");
  self notify("powers_transponder_used", 0);
  self.activated = 0;
  transponderdetonateallcharges();
  self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_897B(var_0) {
  var_0 endon("death");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self iprintlnbold("Transponder Hacked!");
  wait(2);
  self notify("transponder_alt_detonate");
}

func_5616(var_0) {
  scripts\mp\powers::func_D727("power_transponder");
  thread func_5617(var_0);
}

func_5617(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("remove_transponder");
  var_0 waittill("death");
  scripts\mp\powers::func_D72D("power_transponder");
}

func_12694() {
  self endon("death");
  self endon("disconnect");
  var_0 = 0;
  var_1 = 0.8;
  var_2 = 0;
  var_3 = 650;
  self.var_E561 = 0;
  foreach(var_5 in level.participants) {
    if(!scripts\mp\utility::isreallyalive(var_5)) {
      continue;
    }

    if(!scripts\mp\utility::isenemy(var_5)) {
      continue;
    }

    if(var_5 scripts\mp\utility::_hasperk("specialty_noplayertarget") || var_5 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_6 = var_5.origin - self.origin;
    if(1 && vectordot(anglesToForward(self.angles), var_6) < 0) {
      continue;
    }

    var_7 = var_3 * var_3;
    if(length2dsquared(var_6) > var_7) {
      continue;
    }

    var_0++;
    thread func_12695(var_5, distance2d(self.origin, var_5.origin) / var_3, var_1);
    var_2 = 1;
  }
}

func_12695(var_0, var_1, var_2) {
  wait(var_2 * var_1);
  var_3 = scripts\mp\utility::outlineenableforplayer(var_0, "orange", self, 0, 0, "level_script");
  var_0 scripts\mp\hud_message::showmiscmessage("spotted");
  var_4 = 3;
  func_13AA0(var_3, var_0, var_4);
}

func_13AA0(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(var_2, "leave");
  if(isDefined(var_1)) {
    scripts\mp\utility::outlinedisable(var_0, var_1);
  }
}

func_12691() {
  level._effect["reaper_fisheye"] = loadfx("vfx\code\screen\vfx_scrnfx_reaper_fisheye");
  self.var_12697 = ["specialty_fastermelee", "specialty_extendedmelee", "specialty_stun_resistance", "specialty_detectexplosive"];
  foreach(var_1 in self.var_12697) {
    scripts\mp\utility::giveperk(var_1);
  }

  var_3 = self.maxhealth;
  self setsuit("reaper_mp");
  self.maxhealth = 170;
  self.health = self.maxhealth;
  level._effect["reaper_swipe_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_swipe_trail");
  self.var_B62A = spawn("script_model", self.origin);
  self.var_B62A setModel("tag_origin");
  thread func_13ACC();
  thread func_AD77(var_3);
}

func_AD77(var_0) {
  scripts\engine\utility::waittill_any_timeout_1(5, "death");
  thread func_E164(var_0);
}

func_13ACC(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeRipper");
  level endon("game_ended");
  var_1 = (0, 0, 4);
  for(;;) {
    self waittill("melee_fired");
    var_2 = self.origin + var_1;
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoright(self.angles);
    var_5 = func_36DB(var_0);
    var_5 = var_5 + var_1;
    var_6 = var_2 + var_4 * 64;
    var_7 = var_2 - var_4 * 32;
    var_8 = rotatevector(var_4, (0, 45, 0));
    var_9 = var_2 + var_8 * 64;
    var_0A = rotatevector(var_4, (0, 135, 0));
    var_0B = var_2 + var_0A * 32;
    self.var_B62A.origin = var_6;
    wait(0.05);
    playFXOnTag(level._effect["reaper_swipe_trail"], self.var_B62A, "tag_origin");
    wait(0.075);
    self.var_B62A.origin = var_9;
    wait(0.075);
    self.var_B62A.origin = var_5;
    thread func_20D9(var_5);
    wait(0.075);
    self.var_B62A.origin = var_0B;
    wait(0.075);
    self.var_B62A.origin = var_7;
    wait(0.05);
    stopFXOnTag(level._effect["reaper_swipe_trail"], self.var_B62A, "tag_origin");
  }
}

func_40B3() {
  if(isDefined(self.var_C7FF)) {
    self.var_C7FF delete();
  }
}

func_E164(var_0) {
  self notify("removeRipper");
  self.var_9F2E = 0;
  self.var_9FB0 = 0;
  self.var_E561 = 0;
  foreach(var_2 in self.var_12697) {
    scripts\mp\utility::removeperk(var_2);
  }

  self.var_12697 = undefined;
  self setsuit("scout_mp");
  self.maxhealth = var_0;
  self setclientomnvar("ui_odin", -1);
  func_40B3();
}

func_20D9(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("removeRipper");
  var_1 = distance2d(self.origin, var_0) / 2;
  self radiusdamage(self.origin + (0, 0, 36), var_1, 250, 135, self, "MOD_MELEE", "iw7_reaperblade_mp");
}

func_36DB(var_0) {
  self endon("removeRipper");
  var_1 = (0, 0, 0);
  var_2 = self.origin + var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoright(self.angles);
  var_5 = self getvelocity();
  var_6 = vectordot(var_5, self.angles);
  var_7 = length(var_5);
  if(var_7 < 64) {
    var_7 = 92;
  }

  if(var_7 > 64 && var_7 < 128) {
    var_7 = 128;
  }

  if(var_7 > 350) {
    var_7 = 700;
  }

  if(var_7 > 200) {
    var_7 = 328;
  }

  if(var_7 > 128) {
    var_7 = 256;
  }

  if(var_6 < 1) {
    var_7 = 64;
  }

  if(isDefined(var_0)) {
    var_7 = var_0;
  }

  return var_2 + var_3 * var_7;
}