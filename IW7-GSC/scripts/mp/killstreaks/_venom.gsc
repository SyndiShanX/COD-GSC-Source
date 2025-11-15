/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_venom.gsc
*********************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("venom", ::func_1288B, undefined, undefined, undefined, ::func_13C17);
  var_00 = ["passive_increased_debuff", "passive_decreased_damage", "passive_increased_speed", "passive_decreased_duration", "passive_quiet_vehicle", "passive_decreased_speed", "passive_heavy", "passive_increased_frost", "passive_speed_heavy", "passive_stealth_speed"];
  scripts\mp\killstreak_loot::func_DF07("venom", var_00);
  level._effect["venom_gas"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_gas_cloud");
  level._effect["venom_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_gas_trail");
  level._effect["venom_eyeglow"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_glint");
  level._effect["venom_kamikaze_boost"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_kamikaze_boost");
  level._effect["venom_kamikaze_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_kamikaze_trail");
  level.venoms = 0;
}

func_13C17(param_00) {
  var_01 = 0;
  if(isDefined(level.venoms) && level.venoms > 0) {
    if(level.venoms >= 6) {
      var_01 = 1;
    }
  }

  if(scripts\mp\utility::istrue(var_01)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_VENOM_MAX");
    return 0;
  }

  self setclientomnvar("ui_remote_control_sequence", 1);
}

func_1288B(param_00) {
  var_01 = scripts\mp\killstreaks\_killstreaks::func_D507(param_00);
  if(!var_01) {
    return 0;
  }

  var_02 = func_6C9B(80, 20, 10);
  if(!isDefined(var_02)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_NOT_ENOUGH_SPACE");
    thread scripts\mp\killstreaks\_killstreaks::func_11086();
    return 0;
  }

  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_weapon_switch(0);
  var_03 = "venom_drone_wm";
  var_04 = 30;
  var_05 = 10;
  var_06 = "veh_venom_mp";
  var_07 = "used_venom";
  var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(param_00.variantid);
  if(var_08 != "") {
    var_03 = var_03 + "_" + var_08;
    var_07 = var_07 + "_" + var_08;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_increased_frost")) {
    var_04 = var_04 - 10;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_speed_heavy")) {
    var_06 = "veh_venom_mp_fast";
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_stealth_speed")) {
    var_06 = "veh_venom_mp_slow";
  }

  var_09 = spawnvehicle(var_03, param_00.streakname, var_06, var_02, self.angles, self);
  var_09.team = self.team;
  var_09.triggerportableradarping = self;
  var_09.health = 99999;
  var_09.maxhealth = var_05;
  var_09.var_EDD7 = var_05;
  var_09.streakname = param_00.streakname;
  var_09.var_AC75 = var_04;
  var_09.spawnpos = var_02;
  var_09.nullownerdamagefunc = ::scripts\mp\killstreaks\_utility::func_C1D3;
  var_09.weapon_name = "venomproj_mp";
  var_09.streakinfo = param_00;
  var_09 _meth_8491("fly");
  var_09 _meth_849F(0);
  var_09 give_player_tickets(1);
  var_09 getrandomweaponfromcategory();
  var_09 setotherent(self);
  var_09 setentityowner(self);
  level.venoms++;
  var_09 setscriptablepartstate("body", "show", 0);
  var_09 setscriptablepartstate("dust", "active", 0);
  var_09 setscriptablepartstate("eye", "idle", 0);
  if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_stealth_speed")) {
    var_09 setscriptablepartstate("stealth", "active", 0);
    var_09 setscriptablepartstate("center_disc", "hide_fx", 0);
    var_09 setscriptablepartstate("side_discs", "hide_fx", 0);
    var_09 setscriptablepartstate("lights", "hide_fx", 0);
  } else {
    var_09 setscriptablepartstate("center_disc", "idle", 0);
    var_09 setscriptablepartstate("side_discs", "idle", 0);
    var_09 setscriptablepartstate("lights", "idle", 0);
  }

  self setplayerangles(var_09.angles);
  self remotecontrolvehicle(var_09);
  self _meth_8490("disable_mode_switching", 1);
  self _meth_8490("disable_juke", 0);
  self _meth_8490("disable_guns", 1);
  self _meth_8490("disable_boost", 1);
  thread func_F673();
  var_09 scripts\mp\killstreaks\_utility::func_1843(param_00.streakname, "Killstreak_Ground", var_09.triggerportableradarping, 1);
  var_09 scripts\mp\killstreaks\_utility::func_FAE4("venom_end");
  var_09 thread func_13285();
  var_09 thread func_1327E();
  var_09 thread func_1327D();
  var_09 thread func_1327B();
  var_09 thread func_13279();
  var_09 thread func_1327A();
  var_0A = var_09.var_AC75;
  if(scripts\mp\utility::isanymlgmatch()) {
    var_0A = int(var_0A / 2);
  }

  var_09 thread func_13281(var_0A);
  var_09 thread func_13283();
  var_09 thread func_1327C();
  var_09 thread venom_watchempdamage();
  scripts\mp\matchdata::logkillstreakevent(param_00.streakname, var_09.origin);
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  self.restoreangles = self.angles;
  thread func_5130(var_09, var_0A);
  level thread scripts\mp\utility::teamplayercardsplash(var_07, self);
  return 1;
}

func_5130(param_00, param_01) {
  self endon("disconnect");
  param_00 endon("venom_end");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  self setclientomnvar("ui_venom_controls", 1);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(param_01 * 1000));
  self setclientomnvar("ui_killstreak_health", param_00.var_EDD7 / 10);
  self thermalvisionfofoverlayon();
}

func_F673() {
  self endon("disconnect");
  level endon("game_ended");
  var_00 = 0;
  var_01 = self energy_getmax(var_00);
  var_02 = self energy_getrestorerate(var_00);
  var_03 = self energy_getresttimems(var_00);
  self energy_setmax(var_00, 140);
  self goalflag(var_00, 600);
  self goal_type(var_00, 500);
  thread func_E2DE(var_01, var_02, var_03);
}

func_E2DE(param_00, param_01, param_02) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("restore_old_values");
  var_03 = 0;
  self energy_setmax(var_03, param_00);
  self goalflag(var_03, 1000);
  self goal_type(var_03, 0);
  wait(0.5);
  self goalflag(var_03, param_01);
  self goal_type(var_03, param_02);
}

func_13285() {
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    self waittill("spaceship_thrusting", var_01);
    if(scripts\mp\utility::istrue(var_01)) {
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
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    self waittill("spaceship_juking", var_01, var_02);
    if(scripts\mp\utility::istrue(var_02)) {
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
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    var_00 waittill("energy_depleted", var_01);
    if(var_01 == 0) {
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_stealth_speed")) {
        self setscriptablepartstate("center_disc", "hide_fx", 0);
        continue;
      }

      self setscriptablepartstate("center_disc", "idle", 0);
    }
  }
}

func_1327B() {
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  for(;;) {
    if(var_00 attackbuttonpressed()) {
      var_01 = distancesquared(self.spawnpos, self.origin);
      if(var_01 >= 5760000) {
        var_00 scripts\mp\missions::func_D991("ch_venom_distance");
      }

      self notify("venom_end", self.origin);
    }

    scripts\engine\utility::waitframe();
  }
}

func_0118(param_00, param_01) {
  if(isDefined(param_00)) {
    self _meth_8593();
    self setscriptablepartstate("Explosion", "explode", 0);
  }
}

func_13279() {
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E);
    var_0A = scripts\mp\utility::func_13CA1(var_0A, var_0E);
    if(isDefined(var_02) && var_02.classname != "trigger_hurt") {
      if(isDefined(var_02.triggerportableradarping)) {
        var_02 = var_02.triggerportableradarping;
      }

      if(isDefined(var_02.team) && var_02.team == self.team && var_02 != self.triggerportableradarping) {
        continue;
      }
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_02)) {
      continue;
    }

    if(isDefined(var_0A)) {
      var_01 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(var_02, var_0A, var_05, var_01, self.maxhealth, 1, 1, 1);
    }

    self.var_EDD7 = self.var_EDD7 - var_01;
    if(self.var_EDD7 < 0) {
      self.var_EDD7 = 0;
    }

    var_00 setclientomnvar("ui_killstreak_health", self.var_EDD7 / 10);
    if(isplayer(var_02)) {
      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_02, var_0A, self, var_05);
      if(isDefined(var_0A) && var_0A == "concussion_grenade_mp") {
        if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_02))) {
          var_02 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
        }
      }

      var_02 scripts\mp\damagefeedback::updatedamagefeedback("");
      if(self.var_EDD7 <= 0) {
        var_02 notify("destroyed_killstreak", var_0A);
        var_0F = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
        var_10 = "callout_destroyed_" + self.streakname;
        if(var_0F != "") {
          var_10 = var_10 + "_" + var_0F;
        }

        scripts\mp\damage::onkillstreakkilled(self.streakname, var_02, var_0A, var_05, var_01, "destroyed_" + self.streakname, "venom_destroyed", var_10, 1);
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
  var_00 = self.triggerportableradarping;
  level endon("game_ended");
  self waittill("venom_end", var_01, var_02);
  scripts\mp\utility::printgameaction("killstreak ended - venom", var_00);
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }

  self setscriptablepartstate("body", "hide", 0);
  self setscriptablepartstate("center_disc", "hide_fx", 0);
  self setscriptablepartstate("side_discs", "hide_fx", 0);
  self setscriptablepartstate("eye", "hide_fx", 0);
  self setscriptablepartstate("lights", "hide_fx", 0);
  self setscriptablepartstate("stealth", "neutral", 0);
  thread func_0118(var_00, var_01);
  level.venoms--;
  if(level.venoms < 0) {
    level.venoms = 0;
  }

  if(isDefined(var_00)) {
    if(!scripts\mp\utility::istrue(var_02)) {
      var_00 scripts\mp\utility::freezecontrolswrapper(1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      var_00 scripts\mp\utility::freezecontrolswrapper(0);
    }

    var_00 setclientomnvar("ui_out_of_bounds_countdown", 0);
    var_00 remotecontrolvehicleoff();
    var_00 setclientomnvar("ui_venom_controls", 0);
    var_00 setclientomnvar("ui_killstreak_countdown", 0);
    var_00 setclientomnvar("ui_killstreak_health", 0);
    var_00 setclientomnvar("ui_killstreak_missile_warn", 0);
    var_00 setplayerangles(var_00.restoreangles);
    var_00 thermalvisionfofoverlayoff();
    var_00.restoreangles = undefined;
    var_00 thread scripts\mp\killstreaks\_killstreaks::func_11086();
    var_00 scripts\engine\utility::allow_usability(1);
    var_00 scripts\engine\utility::allow_weapon_switch(1);
    var_00 notify("restore_old_values");
  }

  self delete();
}

func_13281(param_00) {
  var_01 = self.triggerportableradarping;
  var_01 endon("disconnect");
  self endon("venom_end");
  self endon("host_migration_lifetime_update");
  level endon("game_ended");
  thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("venom_end", param_00, ::func_13281);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  var_01 scripts\mp\utility::playkillstreakdialogonplayer("venom_timeout", undefined, undefined, var_01.origin);
  self notify("venom_end", self.origin);
}

func_13283() {
  var_00 = self.triggerportableradarping;
  self endon("venom_end");
  level endon("game_ended");
  var_00 scripts\engine\utility::waittill_any_3("joined_team", "disconnect", "joined_spectators");
  self notify("venom_end", self.origin);
}

func_1327C() {
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
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
    self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
    scripts\mp\killstreaks\_utility::dodamagetokillstreak(100, var_00, var_00, self.team, var_02, var_04, var_03);
  }
}

func_13284() {
  var_00 = self.triggerportableradarping;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_01);
    thread func_13276(var_01);
  }
}

func_13275() {
  var_00 = self.triggerportableradarping;
  foreach(var_02 in level.players) {
    if(var_02.team == var_00.team && var_02 != var_00) {
      continue;
    }

    scripts\mp\killstreaks\_utility::func_20CF(var_02, "venom_end");
  }
}

func_13276(param_00) {
  var_01 = self.triggerportableradarping;
  var_01 endon("disconnect");
  self endon("venom_end");
  param_00 endon("disconnect");
  level endon("game_ended");
  for(;;) {
    param_00 waittill("removed_spawn_perks");
    if(param_00.team == var_01.team) {
      break;
    }

    scripts\mp\killstreaks\_utility::func_20CF(param_00, "venom_end");
  }
}

func_6C9B(param_00, param_01, param_02) {
  var_03 = anglesToForward(self.angles);
  var_04 = anglestoright(self.angles);
  var_05 = self getEye();
  var_06 = var_05 + (0, 0, param_01);
  var_07 = var_06 + param_00 * var_03;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  var_07 = var_06 - param_00 * var_03;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  var_07 = var_07 + param_00 * var_04;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  var_07 = var_06 - param_00 * var_04;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  var_07 = var_06;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  scripts\engine\utility::waitframe();
  var_07 = var_06 + 0.707 * param_00 * var_03 + var_04;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  var_07 = var_06 + 0.707 * param_00 * var_03 - var_04;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  var_07 = var_06 + 0.707 * param_00 * var_04 - var_03;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  var_07 = var_06 + 0.707 * param_00 * -1 * var_03 - var_04;
  if(func_3DCF(var_05, var_07, param_02)) {
    return var_07;
  }

  return undefined;
}

func_3DCF(param_00, param_01, param_02) {
  var_03 = 0;
  if(capsuletracepassed(param_01, param_02, param_02 * 2 + 0.01, undefined, 1, 1)) {
    var_04 = [self];
    var_05 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_06 = physics_raycast(param_00, param_01, var_05, var_04, 0, "physicsquery_closest");
    if(var_06.size == 0) {
      var_03 = 1;
    }
  }

  return var_03;
}

isvenom() {
  return isDefined(self.streakname) && self.streakname == "venom";
}

makedamageimmune(param_00) {
  if(!isDefined(self.entsimmune)) {
    self.entsimmune = [];
  }

  self.entsimmune[param_00 getentitynumber()] = param_00;
}

isdamageimmune(param_00) {
  if(!isvenom()) {
    return 0;
  }

  if(!isDefined(self.entsimmune)) {
    return 0;
  }

  return isDefined(self.entsimmune[param_00 getentitynumber()]);
}

venommodifieddamage(param_00, param_01, param_02, param_03, param_04) {
  if(isDefined(param_00) && isDefined(param_03) && isDefined(param_01)) {
    if(param_03 isvenom() && scripts\mp\killstreaks\_utility::func_A69F(param_03.streakinfo, "passive_decreased_damage")) {
      var_05 = distance2dsquared(param_01.origin, param_03.origin);
      if(var_05 >= 22500 && param_04 > 10) {
        param_04 = 0;
      }
    }

    if(param_03 isdamageimmune(param_01)) {
      param_04 = 0;
    }
  }

  return param_04;
}