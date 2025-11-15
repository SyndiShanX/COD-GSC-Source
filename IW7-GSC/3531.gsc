/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3531.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("venom", ::func_1288B, undefined, undefined, undefined, ::func_13C17);
  var_00 = ["passive_increased_debuff", "passive_decreased_damage", "passive_increased_speed", "passive_decreased_duration", "passive_quiet_vehicle", "passive_decreased_speed", "passive_heavy", "passive_increased_frost", "passive_speed_heavy", "passive_stealth_speed"];
  scripts\mp\killstreak_loot::func_DF07("venom", var_00);
  level._effect["venom_gas"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_gas_cloud");
  level._effect["venom_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_gas_trail");
  level._effect["venom_eyeglow"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_glint");
  level._effect["venom_kamikaze_boost"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_kamikaze_boost");
  level._effect["venom_kamikaze_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_kamikaze_trail");
  level.venoms = 0;
}

func_13C17(var_00) {
  var_01 = 0;

  if(isDefined(level.venoms) && level.venoms > 0) {
    if(level.venoms >= 6)
      var_01 = 1;
  }

  if(scripts\mp\utility\game::istrue(var_01)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_VENOM_MAX");
    return 0;
  }

  self setclientomnvar("ui_remote_control_sequence", 1);
}

func_1288B(var_00) {
  var_01 = scripts\mp\killstreaks\killstreaks::func_D507(var_00);

  if(!var_01)
    return 0;

  var_02 = func_6C9B(80, 20, 10);

  if(!isDefined(var_02)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_NOT_ENOUGH_SPACE");
    thread scripts\mp\killstreaks\killstreaks::func_11086();
    return 0;
  }

  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_weapon_switch(0);
  var_03 = "venom_drone_wm";
  var_04 = 30;
  var_05 = 10;
  var_06 = "veh_venom_mp";
  var_07 = "used_venom";
  var_08 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.variantid);

  if(var_08 != "") {
    var_03 = var_03 + "_" + var_08;
    var_07 = var_07 + "_" + var_08;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_increased_frost"))
    var_04 = var_04 - 10;

  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_speed_heavy"))
    var_06 = "veh_venom_mp_fast";

  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_stealth_speed"))
    var_06 = "veh_venom_mp_slow";

  var_09 = spawnvehicle(var_03, var_0.streakname, var_06, var_02, self.angles, self);
  var_9.team = self.team;
  var_9.owner = self;
  var_9.health = 99999;
  var_9.maxhealth = var_05;
  var_9.func_EDD7 = var_05;
  var_9.streakname = var_0.streakname;
  var_9.func_AC75 = var_04;
  var_9.spawnpos = var_02;
  var_9.nullownerdamagefunc = scripts\mp\killstreaks\utility::func_C1D3;
  var_9.weapon_name = "venomproj_mp";
  var_9.streakinfo = var_00;
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

  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_stealth_speed")) {
    var_09 setscriptablepartstate("stealth", "active", 0);
    var_09 setscriptablepartstate("center_disc", "hide_fx", 0);
    var_09 setscriptablepartstate("side_discs", "hide_fx", 0);
    var_09 setscriptablepartstate("lights", "hide_fx", 0);
  } else {
    var_09 setscriptablepartstate("center_disc", "idle", 0);
    var_09 setscriptablepartstate("side_discs", "idle", 0);
    var_09 setscriptablepartstate("lights", "idle", 0);
  }

  self setplayerangles(var_9.angles);
  self remotecontrolvehicle(var_09);
  self _meth_8490("disable_mode_switching", 1);
  self _meth_8490("disable_juke", 0);
  self _meth_8490("disable_guns", 1);
  self _meth_8490("disable_boost", 1);
  thread func_F673();
  var_09 scripts\mp\killstreaks\utility::func_1843(var_0.streakname, "Killstreak_Ground", var_9.owner, 1);
  var_09 scripts\mp\killstreaks\utility::func_FAE4("venom_end");
  var_09 thread func_13285();
  var_09 thread func_1327E();
  var_09 thread func_1327D();
  var_09 thread func_1327B();
  var_09 thread func_13279();
  var_09 thread func_1327A();
  var_10 = var_9.func_AC75;

  if(scripts\mp\utility\game::isanymlgmatch())
    var_10 = int(var_10 / 2);

  var_09 thread func_13281(var_10);
  var_09 thread func_13283();
  var_09 thread func_1327C();
  var_09 thread venom_watchempdamage();
  scripts\mp\matchdata::logkillstreakevent(var_0.streakname, var_9.origin);

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(0);

  self.restoreangles = self.angles;
  thread func_5130(var_09, var_10);
  level thread scripts\mp\utility\game::teamplayercardsplash(var_07, self);
  return 1;
}

func_5130(var_00, var_01) {
  self endon("disconnect");
  var_00 endon("venom_end");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  self setclientomnvar("ui_venom_controls", 1);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var_01 * 1000));
  self setclientomnvar("ui_killstreak_health", var_0.func_EDD7 / 10);
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

func_E2DE(var_00, var_01, var_02) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("restore_old_values");
  var_03 = 0;
  self energy_setmax(var_03, var_00);
  self goalflag(var_03, 1000);
  self goal_type(var_03, 0);
  wait 0.5;
  self goalflag(var_03, var_01);
  self goal_type(var_03, var_02);
}

func_13285() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");

  for(;;) {
    self waittill("spaceship_thrusting", var_01);

    if(scripts\mp\utility\game::istrue(var_01)) {
      self setscriptablepartstate("center_disc", "thrust", 0);
      continue;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_stealth_speed")) {
      self setscriptablepartstate("center_disc", "hide_fx", 0);
      continue;
    }

    self setscriptablepartstate("center_disc", "idle", 0);
  }
}

func_1327E() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");

  for(;;) {
    self waittill("spaceship_juking", var_01, var_02);

    if(scripts\mp\utility\game::istrue(var_02)) {
      self setscriptablepartstate("side_discs", "thrust", 0);
      continue;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_stealth_speed")) {
      self setscriptablepartstate("side_discs", "hide_fx", 0);
      continue;
    }

    self setscriptablepartstate("side_discs", "idle", 0);
  }
}

func_1327D() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");

  for(;;) {
    var_00 waittill("energy_depleted", var_01);

    if(var_01 == 0) {
      if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_stealth_speed")) {
        self setscriptablepartstate("center_disc", "hide_fx", 0);
        continue;
      }

      self setscriptablepartstate("center_disc", "idle", 0);
    }
  }
}

func_1327B() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);

  for(;;) {
    if(var_00 attackbuttonpressed()) {
      var_01 = distancesquared(self.spawnpos, self.origin);

      if(var_01 >= 5760000)
        var_00 scripts\mp\missions::func_D991("ch_venom_distance");

      self notify("venom_end", self.origin);
    }

    scripts\engine\utility::waitframe();
  }
}

func_0118(var_00, var_01) {
  if(isDefined(var_00)) {
    self _meth_8593();
    self setscriptablepartstate("Explosion", "explode", 0);
  }
}

func_13279() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14);
    var_10 = scripts\mp\utility\game::func_13CA1(var_10, var_14);

    if(isDefined(var_02) && var_2.classname != "trigger_hurt") {
      if(isDefined(var_2.owner))
        var_02 = var_2.owner;

      if(isDefined(var_2.team) && var_2.team == self.team && var_02 != self.owner)
        continue;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_02)) {
      continue;
    }
    if(isDefined(var_10))
      var_01 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_02, var_10, var_05, var_01, self.maxhealth, 1, 1, 1);

    self.func_EDD7 = self.func_EDD7 - var_01;

    if(self.func_EDD7 < 0)
      self.func_EDD7 = 0;

    var_00 setclientomnvar("ui_killstreak_health", self.func_EDD7 / 10);

    if(isplayer(var_02)) {
      scripts\mp\killstreaks\killstreaks::killstreakhit(var_02, var_10, self, var_05);

      if(isDefined(var_10) && var_10 == "concussion_grenade_mp") {
        if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_02)))
          var_02 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
      }

      var_02 scripts\mp\damagefeedback::updatedamagefeedback("");

      if(self.func_EDD7 <= 0) {
        var_02 notify("destroyed_killstreak", var_10);
        var_15 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
        var_16 = "callout_destroyed_" + self.streakname;

        if(var_15 != "")
          var_16 = var_16 + "_" + var_15;

        scripts\mp\damage::onkillstreakkilled(self.streakname, var_02, var_10, var_05, var_01, "destroyed_" + self.streakname, "venom_destroyed", var_16, 1);
        self notify("venom_end", self.origin);
      }

      continue;
    }

    if(self.func_EDD7 <= 0)
      self notify("venom_end", self.origin, 1);
  }
}

func_1327A() {
  var_00 = self.owner;
  level endon("game_ended");
  self waittill("venom_end", var_01, var_02);
  scripts\mp\utility\game::printgameaction("killstreak ended - venom", var_00);

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(1);

  self setscriptablepartstate("body", "hide", 0);
  self setscriptablepartstate("center_disc", "hide_fx", 0);
  self setscriptablepartstate("side_discs", "hide_fx", 0);
  self setscriptablepartstate("eye", "hide_fx", 0);
  self setscriptablepartstate("lights", "hide_fx", 0);
  self setscriptablepartstate("stealth", "neutral", 0);
  thread func_0118(var_00, var_01);
  level.venoms--;

  if(level.venoms < 0)
    level.venoms = 0;

  if(isDefined(var_00)) {
    if(!scripts\mp\utility\game::istrue(var_02)) {
      var_00 scripts\mp\utility\game::freezecontrolswrapper(1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
      var_00 scripts\mp\utility\game::freezecontrolswrapper(0);
    }

    var_00 setclientomnvar("ui_out_of_bounds_countdown", 0);
    var_00 remotecontrolvehicleoff();
    var_00 setclientomnvar("ui_venom_controls", 0);
    var_00 setclientomnvar("ui_killstreak_countdown", 0);
    var_00 setclientomnvar("ui_killstreak_health", 0);
    var_00 setclientomnvar("ui_killstreak_missile_warn", 0);
    var_00 setplayerangles(var_0.restoreangles);
    var_00 thermalvisionfofoverlayoff();
    var_0.restoreangles = undefined;
    var_00 thread scripts\mp\killstreaks\killstreaks::func_11086();
    var_00 scripts\engine\utility::allow_usability(1);
    var_00 scripts\engine\utility::allow_weapon_switch(1);
    var_00 notify("restore_old_values");
  }

  self delete();
}

func_13281(var_00) {
  var_01 = self.owner;
  var_01 endon("disconnect");
  self endon("venom_end");
  self endon("host_migration_lifetime_update");
  level endon("game_ended");
  thread scripts\mp\killstreaks\utility::watchhostmigrationlifetime("venom_end", var_00, ::func_13281);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  var_01 scripts\mp\utility\game::playkillstreakdialogonplayer("venom_timeout", undefined, undefined, var_1.origin);
  self notify("venom_end", self.origin);
}

func_13283() {
  var_00 = self.owner;
  self endon("venom_end");
  level endon("game_ended");
  var_00 scripts\engine\utility::waittill_any("joined_team", "disconnect", "joined_spectators");
  self notify("venom_end", self.origin);
}

func_1327C() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");
  thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit("venom_end");
  self waittill("killstreakExit");
  self notify("venom_end", self.origin);
}

venom_watchempdamage() {
  level endon("game_ended");
  self endon("venom_end");

  for(;;) {
    self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
    scripts\mp\killstreaks\utility::dodamagetokillstreak(100, var_00, var_00, self.team, var_02, var_04, var_03);
  }
}

func_13284() {
  var_00 = self.owner;
  var_00 endon("disconnect");
  self endon("venom_end");
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_01);
    thread func_13276(var_01);
  }
}

func_13275() {
  var_00 = self.owner;

  foreach(var_02 in level.players) {
    if(var_2.team == var_0.team && var_02 != var_00) {
      continue;
    }
    scripts\mp\killstreaks\utility::func_20CF(var_02, "venom_end");
  }
}

func_13276(var_00) {
  var_01 = self.owner;
  var_01 endon("disconnect");
  self endon("venom_end");
  var_00 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_00 waittill("removed_spawn_perks");

    if(var_0.team == var_1.team) {
      break;
    }
    scripts\mp\killstreaks\utility::func_20CF(var_00, "venom_end");
  }
}

func_6C9B(var_00, var_01, var_02) {
  var_03 = anglesToForward(self.angles);
  var_04 = anglestoright(self.angles);
  var_05 = self getEye();
  var_06 = var_05 + (0, 0, var_01);
  var_07 = var_06 + var_00 * var_03;

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  var_07 = var_06 - var_00 * var_03;

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  var_07 = var_07 + var_00 * var_04;

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  var_07 = var_06 - var_00 * var_04;

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  var_07 = var_06;

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  scripts\engine\utility::waitframe();
  var_07 = var_06 + 0.707 * var_00 * (var_03 + var_04);

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  var_07 = var_06 + 0.707 * var_00 * (var_03 - var_04);

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  var_07 = var_06 + 0.707 * var_00 * (var_04 - var_03);

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  var_07 = var_06 + 0.707 * var_00 * (-1 * var_03 - var_04);

  if(func_3DCF(var_05, var_07, var_02))
    return var_07;

  return undefined;
}

func_3DCF(var_00, var_01, var_02) {
  var_03 = 0;

  if(capsuletracepassed(var_01, var_02, var_02 * 2 + 0.01, undefined, 1, 1)) {
    var_04 = [self];
    var_05 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_06 = physics_raycast(var_00, var_01, var_05, var_04, 0, "physicsquery_closest");

    if(var_6.size == 0)
      var_03 = 1;
  }

  return var_03;
}

isvenom() {
  return isDefined(self.streakname) && self.streakname == "venom";
}

makedamageimmune(var_00) {
  if(!isDefined(self.entsimmune))
    self.entsimmune = [];

  self.entsimmune[var_00 getentitynumber()] = var_00;
}

isdamageimmune(var_00) {
  if(!isvenom())
    return 0;

  if(!isDefined(self.entsimmune))
    return 0;

  return isDefined(self.entsimmune[var_00 getentitynumber()]);
}

venommodifieddamage(var_00, var_01, var_02, var_03, var_04) {
  if(isDefined(var_00) && isDefined(var_03) && isDefined(var_01)) {
    if(var_03 isvenom() && scripts\mp\killstreaks\utility::func_A69F(var_3.streakinfo, "passive_decreased_damage")) {
      var_05 = distance2dsquared(var_1.origin, var_3.origin);

      if(var_05 >= 22500 && var_04 > 10)
        var_04 = 0;
    }

    if(var_03 isdamageimmune(var_01))
      var_04 = 0;
  }

  return var_04;
}