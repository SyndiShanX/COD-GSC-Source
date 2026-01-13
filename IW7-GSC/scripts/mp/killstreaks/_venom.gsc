/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_venom.gsc
*********************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("venom", ::func_1288B, undefined, undefined, undefined, ::func_13C17);
  var_0 = ["passive_increased_debuff", "passive_decreased_damage", "passive_increased_speed", "passive_decreased_duration", "passive_quiet_vehicle", "passive_decreased_speed", "passive_heavy", "passive_increased_frost", "passive_speed_heavy", "passive_stealth_speed"];
  scripts\mp\killstreak_loot::func_DF07("venom", var_0);
  level._effect["venom_gas"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_gas_cloud");
  level._effect["venom_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_gas_trail");
  level._effect["venom_eyeglow"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_glint");
  level._effect["venom_kamikaze_boost"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_kamikaze_boost");
  level._effect["venom_kamikaze_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_kamikaze_trail");
  level.venoms = 0;
}

func_13C17(var_0) {
  var_1 = 0;
  if(isDefined(level.venoms) && level.venoms > 0) {
    if(level.venoms >= 6) {
      var_1 = 1;
    }
  }

  if(scripts\mp\utility::istrue(var_1)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_VENOM_MAX");
    return 0;
  }

  self setclientomnvar("ui_remote_control_sequence", 1);
}

func_1288B(var_0) {
  var_1 = scripts\mp\killstreaks\_killstreaks::func_D507(var_0);
  if(!var_1) {
    return 0;
  }

  var_2 = func_6C9B(80, 20, 10);
  if(!isDefined(var_2)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_NOT_ENOUGH_SPACE");
    thread scripts\mp\killstreaks\_killstreaks::func_11086();
    return 0;
  }

  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_weapon_switch(0);
  var_3 = "venom_drone_wm";
  var_4 = 30;
  var_5 = 10;
  var_6 = "veh_venom_mp";
  var_7 = "used_venom";
  var_8 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.variantid);
  if(var_8 != "") {
    var_3 = var_3 + "_" + var_8;
    var_7 = var_7 + "_" + var_8;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(var_0, "passive_increased_frost")) {
    var_4 = var_4 - 10;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(var_0, "passive_speed_heavy")) {
    var_6 = "veh_venom_mp_fast";
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(var_0, "passive_stealth_speed")) {
    var_6 = "veh_venom_mp_slow";
  }

  var_9 = spawnvehicle(var_3, var_0.streakname, var_6, var_2, self.angles, self);
  var_9.team = self.team;
  var_9.triggerportableradarping = self;
  var_9.health = 99999;
  var_9.maxhealth = var_5;
  var_9.var_EDD7 = var_5;
  var_9.streakname = var_0.streakname;
  var_9.var_AC75 = var_4;
  var_9.spawnpos = var_2;
  var_9.nullownerdamagefunc = ::scripts\mp\killstreaks\_utility::func_C1D3;
  var_9.weapon_name = "venomproj_mp";
  var_9.streakinfo = var_0;
  var_9 _meth_8491("fly");
  var_9 _meth_849F(0);
  var_9 give_player_tickets(1);
  var_9 getrandomweaponfromcategory();
  var_9 setotherent(self);
  var_9 setentityowner(self);
  level.venoms++;
  var_9 setscriptablepartstate("body", "show", 0);
  var_9 setscriptablepartstate("dust", "active", 0);
  var_9 setscriptablepartstate("eye", "idle", 0);
  if(scripts\mp\killstreaks\_utility::func_A69F(var_0, "passive_stealth_speed")) {
    var_9 setscriptablepartstate("stealth", "active", 0);
    var_9 setscriptablepartstate("center_disc", "hide_fx", 0);
    var_9 setscriptablepartstate("side_discs", "hide_fx", 0);
    var_9 setscriptablepartstate("lights", "hide_fx", 0);
  } else {
    var_9 setscriptablepartstate("center_disc", "idle", 0);
    var_9 setscriptablepartstate("side_discs", "idle", 0);
    var_9 setscriptablepartstate("lights", "idle", 0);
  }

  self setplayerangles(var_9.angles);
  self remotecontrolvehicle(var_9);
  self _meth_8490("disable_mode_switching", 1);
  self _meth_8490("disable_juke", 0);
  self _meth_8490("disable_guns", 1);
  self _meth_8490("disable_boost", 1);
  thread func_F673();
  var_9 scripts\mp\killstreaks\_utility::func_1843(var_0.streakname, "Killstreak_Ground", var_9.triggerportableradarping, 1);
  var_9 scripts\mp\killstreaks\_utility::func_FAE4("venom_end");
  var_9 thread func_13285();
  var_9 thread func_1327E();
  var_9 thread func_1327D();
  var_9 thread func_1327B();
  var_9 thread func_13279();
  var_9 thread func_1327A();
  var_0A = var_9.var_AC75;
  if(scripts\mp\utility::isanymlgmatch()) {
    var_0A = int(var_0A / 2);
  }

  var_9 thread func_13281(var_0A);
  var_9 thread func_13283();
  var_9 thread func_1327C();
  var_9 thread venom_watchempdamage();
  scripts\mp\matchdata::logkillstreakevent(var_0.streakname, var_9.origin);
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  thread func_5130(var_9, var_0A);
  level thread scripts\mp\utility::teamplayercardsplash(var_7, self);
  return 1;
}

func_5130(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("venom_end");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  self setclientomnvar("ui_venom_controls", 1);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var_1 * 1000));
  self setclientomnvar("ui_killstreak_health", var_0.var_EDD7 / 10);
  self thermalvisionfofoverlayon();
}

func_F673() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = 0;
  var_1 = self energy_getmax(var_0);
  var_2 = self energy_getrestorerate(var_0);
  var_3 = self energy_getresttimems(var_0);
  self energy_setmax(var_0, 140);
  self goalflag(var_0, 600);
  self goal_type(var_0, 500);
  thread func_E2DE(var_1, var_2, var_3);
}

func_E2DE(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("restore_old_values");
  var_3 = 0;
  self energy_setmax(var_3, var_0);
  self goalflag(var_3, 1000);
  self goal_type(var_3, 0);
  wait(0.5);
  self goalflag(var_3, var_1);
  self goal_type(var_3, var_2);
}

func_13285() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    self waittill("spaceship_thrusting", var_1);
    if(scripts\mp\utility::istrue(var_1)) {
      self setscriptablepartstate("center_disc", "thrust", 0);
      continue;
    }

    if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_stealth_speed")) {
      self setscriptablepartstate("center_disc", "hide_fx", 0);
      continue;
    }

    self setscriptablepartstate("center_disc", "idle", 0);
  }
}

func_1327E() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    self waittill("spaceship_juking", var_1, var_2);
    if(scripts\mp\utility::istrue(var_2)) {
      self setscriptablepartstate("side_discs", "thrust", 0);
      continue;
    }

    if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_stealth_speed")) {
      self setscriptablepartstate("side_discs", "hide_fx", 0);
      continue;
    }

    self setscriptablepartstate("side_discs", "idle", 0);
  }
}

func_1327D() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    var_0 waittill("energy_depleted", var_1);
    if(var_1 == 0) {
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_stealth_speed")) {
        self setscriptablepartstate("center_disc", "hide_fx", 0);
        continue;
      }

      self setscriptablepartstate("center_disc", "idle", 0);
    }
  }
}

func_1327B() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  for(;;) {
    if(var_0 attackbuttonpressed()) {
      var_1 = distancesquared(self.spawnpos, self.origin);
      if(var_1 >= 5760000) {
        var_0 scripts\mp\missions::func_D991("ch_venom_distance");
      }

      self notify("venom_end", self.origin);
    }

    scripts\engine\utility::waitframe();
  }
}

func_0118(var_0, var_1) {
  if(isDefined(var_0)) {
    self _meth_8593();
    self setscriptablepartstate("Explosion", "explode", 0);
  }
}

func_13279() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E);
    var_0A = scripts\mp\utility::func_13CA1(var_0A, var_0E);
    if(isDefined(var_2) && var_2.classname != "trigger_hurt") {
      if(isDefined(var_2.triggerportableradarping)) {
        var_2 = var_2.triggerportableradarping;
      }

      if(isDefined(var_2.team) && var_2.team == self.team && var_2 != self.triggerportableradarping) {
        continue;
      }
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_2)) {
      continue;
    }

    if(isDefined(var_0A)) {
      var_1 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(var_2, var_0A, var_5, var_1, self.maxhealth, 1, 1, 1);
    }

    self.var_EDD7 = self.var_EDD7 - var_1;
    if(self.var_EDD7 < 0) {
      self.var_EDD7 = 0;
    }

    var_0 setclientomnvar("ui_killstreak_health", self.var_EDD7 / 10);
    if(isplayer(var_2)) {
      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_2, var_0A, self, var_5);
      if(isDefined(var_0A) && var_0A == "concussion_grenade_mp") {
        if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_2))) {
          var_2 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
        }
      }

      var_2 scripts\mp\damagefeedback::updatedamagefeedback("");
      if(self.var_EDD7 <= 0) {
        var_2 notify("destroyed_killstreak", var_0A);
        var_0F = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
        var_10 = "callout_destroyed_" + self.streakname;
        if(var_0F != "") {
          var_10 = var_10 + "_" + var_0F;
        }

        scripts\mp\damage::onkillstreakkilled(self.streakname, var_2, var_0A, var_5, var_1, "destroyed_" + self.streakname, "venom_destroyed", var_10, 1);
        self notify("venom_end", self.origin);
      }

      continue;
    }

    if(self.var_EDD7 <= 0) {
      self notify("venom_end", self.origin, 1);
    }
  }
}

func_1327A() {
  var_0 = self.triggerportableradarping;
  level endon("game_ended");
  self waittill("venom_end", var_1, var_2);
  scripts\mp\utility::printgameaction("killstreak ended - venom", var_0);
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }

  self setscriptablepartstate("body", "hide", 0);
  self setscriptablepartstate("center_disc", "hide_fx", 0);
  self setscriptablepartstate("side_discs", "hide_fx", 0);
  self setscriptablepartstate("eye", "hide_fx", 0);
  self setscriptablepartstate("lights", "hide_fx", 0);
  self setscriptablepartstate("stealth", "neutral", 0);
  thread func_0118(var_0, var_1);
  level.venoms--;
  if(level.venoms < 0) {
    level.venoms = 0;
  }

  if(isDefined(var_0)) {
    if(!scripts\mp\utility::istrue(var_2)) {
      var_0 scripts\mp\utility::freezecontrolswrapper(1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      var_0 scripts\mp\utility::freezecontrolswrapper(0);
    }

    var_0 setclientomnvar("ui_out_of_bounds_countdown", 0);
    var_0 remotecontrolvehicleoff();
    var_0 setclientomnvar("ui_venom_controls", 0);
    var_0 setclientomnvar("ui_killstreak_countdown", 0);
    var_0 setclientomnvar("ui_killstreak_health", 0);
    var_0 setclientomnvar("ui_killstreak_missile_warn", 0);
    var_0 setplayerangles(var_0.restoreangles);
    var_0 thermalvisionfofoverlayoff();
    var_0.restoreangles = undefined;
    var_0 thread scripts\mp\killstreaks\_killstreaks::func_11086();
    var_0 scripts\engine\utility::allow_usability(1);
    var_0 scripts\engine\utility::allow_weapon_switch(1);
    var_0 notify("restore_old_values");
  }

  self delete();
}

func_13281(var_0) {
  var_1 = self.triggerportableradarping;
  var_1 endon("disconnect");
  self endon("venom_end");
  self endon("host_migration_lifetime_update");
  level endon("game_ended");
  thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("venom_end", var_0, ::func_13281);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  var_1 scripts\mp\utility::playkillstreakdialogonplayer("venom_timeout", undefined, undefined, var_1.origin);
  self notify("venom_end", self.origin);
}

func_13283() {
  var_0 = self.triggerportableradarping;
  self endon("venom_end");
  level endon("game_ended");
  var_0 scripts\engine\utility::waittill_any_3("joined_team", "disconnect", "joined_spectators");
  self notify("venom_end", self.origin);
}

func_1327C() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  thread scripts\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit("venom_end");
  self waittill("killstreakExit");
  self notify("venom_end", self.origin);
}

venom_watchempdamage() {
  level endon("game_ended");
  self endon("venom_end");
  for(;;) {
    self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);
    scripts\mp\killstreaks\_utility::dodamagetokillstreak(100, var_0, var_0, self.team, var_2, var_4, var_3);
  }
}

func_13284() {
  var_0 = self.triggerportableradarping;
  var_0 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_1);
    thread func_13276(var_1);
  }
}

func_13275() {
  var_0 = self.triggerportableradarping;
  foreach(var_2 in level.players) {
    if(var_2.team == var_0.team && var_2 != var_0) {
      continue;
    }

    scripts\mp\killstreaks\_utility::func_20CF(var_2, "venom_end");
  }
}

func_13276(var_0) {
  var_1 = self.triggerportableradarping;
  var_1 endon("disconnect");
  self endon("venom_end");
  var_0 endon("disconnect");
  level endon("game_ended");
  for(;;) {
    var_0 waittill("removed_spawn_perks");
    if(var_0.team == var_1.team) {
      break;
    }

    scripts\mp\killstreaks\_utility::func_20CF(var_0, "venom_end");
  }
}

func_6C9B(var_0, var_1, var_2) {
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoright(self.angles);
  var_5 = self getEye();
  var_6 = var_5 + (0, 0, var_1);
  var_7 = var_6 + var_0 * var_3;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 - var_0 * var_3;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_7 + var_0 * var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 - var_0 * var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  scripts\engine\utility::waitframe();
  var_7 = var_6 + 0.707 * var_0 * var_3 + var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 + 0.707 * var_0 * var_3 - var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 + 0.707 * var_0 * var_4 - var_3;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 + 0.707 * var_0 * -1 * var_3 - var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  return undefined;
}

func_3DCF(var_0, var_1, var_2) {
  var_3 = 0;
  if(capsuletracepassed(var_1, var_2, var_2 * 2 + 0.01, undefined, 1, 1)) {
    var_4 = [self];
    var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_6 = physics_raycast(var_0, var_1, var_5, var_4, 0, "physicsquery_closest");
    if(var_6.size == 0) {
      var_3 = 1;
    }
  }

  return var_3;
}

isvenom() {
  return isDefined(self.streakname) && self.streakname == "venom";
}

makedamageimmune(var_0) {
  if(!isDefined(self.entsimmune)) {
    self.entsimmune = [];
  }

  self.entsimmune[var_0 getentitynumber()] = var_0;
}

isdamageimmune(var_0) {
  if(!isvenom()) {
    return 0;
  }

  if(!isDefined(self.entsimmune)) {
    return 0;
  }

  return isDefined(self.entsimmune[var_0 getentitynumber()]);
}

venommodifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_3) && isDefined(var_1)) {
    if(var_3 isvenom() && scripts\mp\killstreaks\_utility::func_A69F(var_3.streakinfo, "passive_decreased_damage")) {
      var_5 = distance2dsquared(var_1.origin, var_3.origin);
      if(var_5 >= 22500 && var_4 > 10) {
        var_4 = 0;
      }
    }

    if(var_3 isdamageimmune(var_1)) {
      var_4 = 0;
    }
  }

  return var_4;
}