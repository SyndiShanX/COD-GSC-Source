/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3517.gsc
***************************************/

init() {
  level.func_12A9A = [];
  level.func_12A9A["mg_turret"] = "remote_mg_turret";
  scripts\mp\killstreaks\killstreaks::registerkillstreak("remote_mg_turret", ::func_128FC);
  level.func_12A8D = [];
  level.func_12A8D["mg_turret"] = spawnStruct();
  level.func_12A8D["mg_turret"].sentrymodeon = "manual";
  level.func_12A8D["mg_turret"].sentrymodeoff = "sentry_offline";
  level.func_12A8D["mg_turret"].timeout = 60.0;
  level.func_12A8D["mg_turret"].health = 999999;
  level.func_12A8D["mg_turret"].maxhealth = 1000;
  level.func_12A8D["mg_turret"].streakname = "remote_mg_turret";
  level.func_12A8D["mg_turret"].weaponinfo = "remote_turret_mp";
  level.func_12A8D["mg_turret"].modelbase = "mp_remote_turret";
  level.func_12A8D["mg_turret"].modelplacement = "mp_remote_turret_placement";
  level.func_12A8D["mg_turret"].modelplacementfailed = "mp_remote_turret_placement_failed";
  level.func_12A8D["mg_turret"].modeldestroyed = "mp_remote_turret";
  level.func_12A8D["mg_turret"].teamsplash = "used_remote_mg_turret";
  level.func_12A8D["mg_turret"].func_901A = &"KILLSTREAKS_ENTER_REMOTE_TURRET";
  level.func_12A8D["mg_turret"].func_901B = &"KILLSTREAKS_EARLY_EXIT";
  level.func_12A8D["mg_turret"].func_901F = &"KILLSTREAKS_DOUBLE_TAP_TO_CARRY";
  level.func_12A8D["mg_turret"].placestring = &"KILLSTREAKS_TURRET_PLACE";
  level.func_12A8D["mg_turret"].cannotplacestring = &"KILLSTREAKS_TURRET_CANNOT_PLACE";
  level.func_12A8D["mg_turret"].vodestroyed = "remote_sentry_destroyed";
  level.func_12A8D["mg_turret"].func_A84D = "killstreak_remote_turret_laptop_mp";
  level.func_12A8D["mg_turret"].remotedetonatethink = "killstreak_remote_turret_remote_mp";
  level._effect["sentry_explode_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level._effect["antenna_light_mp"] = loadfx("vfx\core\lights\light_detonator_blink");
}

func_128FC(var_00, var_01) {
  var_02 = func_128FF(var_00, "mg_turret");

  if(var_02) {
    scripts\mp\matchdata::logkillstreakevent(level.func_12A8D["mg_turret"].streakname, self.origin);
  }

  self.iscarrying = 0;
  return var_02;
}

func_1146D(var_00) {
  scripts\mp\utility\game::_takeweapon(level.func_12A8D[var_00].func_A84D);
  scripts\mp\utility\game::_takeweapon(level.func_12A8D[var_00].remotedetonatethink);
}

func_128FF(var_00, var_01) {
  if(scripts\mp\utility\game::isusingremote()) {
    return 0;
  }

  var_02 = func_4A2C(var_01, self);
  removeperks();
  func_F68B(var_02, 1);
  thread restoreperks();

  if(isDefined(var_02)) {
    return 1;
  } else {
    return 0;
  }
}

func_F68B(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  var_00 func_12A2C(self);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_turret", "+attack");
  self notifyonplayercommand("place_turret", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_turret", "+actionslot 4");

  if(!level.console) {
    self notifyonplayercommand("cancel_turret", "+actionslot 5");
    self notifyonplayercommand("cancel_turret", "+actionslot 6");
    self notifyonplayercommand("cancel_turret", "+actionslot 7");
  }

  for(;;) {
    var_02 = scripts\engine\utility::waittill_any_return("place_turret", "cancel_turret", "force_cancel_placement");

    if(var_02 == "cancel_turret" || var_02 == "force_cancel_placement") {
      if(var_02 == "cancel_turret" && !var_01) {
        continue;
      }
      if(level.console) {
        var_03 = scripts\mp\utility\game::getkillstreakweapon(level.func_12A8D[var_0.func_12A9A].streakname);

        if(isDefined(self.func_A6A1) && var_03 == scripts\mp\utility\game::getkillstreakweapon(self.pers["killstreaks"][self.func_A6A1].streakname) && !self getweaponlistitems().size) {
          scripts\mp\utility\game::_giveweapon(var_03, 0);
          scripts\mp\utility\game::_setactionslot(4, "weapon", var_03);
        }
      }

      var_00 func_12A2B();
      scripts\engine\utility::allow_weapon(1);
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    var_00 func_12A2E();
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeperks() {
  if(scripts\mp\utility\game::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility\game::removeperk("specialty_explosivebullets");
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\game::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  restoreperks();
}

removeweapons() {
  foreach(var_01 in self.weaponlist) {
    var_02 = strtok(var_01, "_");

    if(var_2[0] == "alt") {
      self.restoreweaponclipammo[var_01] = self getweaponammoclip(var_01);
      self.func_E2E9[var_01] = self getweaponammostock(var_01);
      continue;
    }

    self.restoreweaponclipammo[var_01] = self getweaponammoclip(var_01);
    self.func_E2E9[var_01] = self getweaponammostock(var_01);
  }

  self.func_13CD2 = [];

  foreach(var_01 in self.weaponlist) {
    var_02 = strtok(var_01, "_");

    if(var_2[0] == "alt") {
      continue;
    }
    self.func_13CD2[self.func_13CD2.size] = var_01;
    scripts\mp\utility\game::_takeweapon(var_01);
  }
}

restoreweapons() {
  if(!isDefined(self.restoreweaponclipammo) || !isDefined(self.func_E2E9) || !isDefined(self.func_13CD2)) {
    return;
  }
  var_00 = [];

  foreach(var_02 in self.func_13CD2) {
    var_03 = strtok(var_02, "_");

    if(var_3[0] == "alt") {
      var_0[var_0.size] = var_02;
      continue;
    }

    scripts\mp\utility\game::_giveweapon(var_02);

    if(isDefined(self.restoreweaponclipammo[var_02])) {
      self setweaponammoclip(var_02, self.restoreweaponclipammo[var_02]);
    }

    if(isDefined(self.func_E2E9[var_02])) {
      self setweaponammostock(var_02, self.func_E2E9[var_02]);
    }
  }

  foreach(var_06 in var_00) {
    if(isDefined(self.restoreweaponclipammo[var_06])) {
      self setweaponammoclip(var_06, self.restoreweaponclipammo[var_06]);
    }

    if(isDefined(self.func_E2E9[var_06])) {
      self setweaponammostock(var_06, self.func_E2E9[var_06]);
    }
  }

  self.restoreweaponclipammo = undefined;
  self.func_E2E9 = undefined;
}

func_13710() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  restoreweapons();
}

func_12A2E() {
  self setModel(level.func_12A8D[self.func_12A9A].modelbase);
  self setsentrycarrier(undefined);
  self setCanDamage(1);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
    scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self.owner);
  }

  self playSound("sentry_gun_plant");
  thread func_12A2A();
  self notify("placed");
}

func_12A2B() {
  self.carriedby getrigindexfromarchetyperef();

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  self delete();
}

func_12A2C(var_00) {
  self setModel(level.func_12A8D[self.func_12A9A].modelplacement);
  self setCanDamage(0);
  self setsentrycarrier(var_00);
  self setcontents(0);
  self.carriedby = var_00;
  var_0.iscarrying = 1;
  var_00 thread func_12F4F(self);
  thread func_12A16(var_00);
  thread func_12A17(var_00);
  thread func_12A15(var_00);
  thread func_12A18();
  self setdefaultdroppitch(-89.0);
  func_12A2D();
  self notify("carried");
}

func_12F4F(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("placed");
  var_00 endon("death");
  var_0.canbeplaced = 1;
  var_01 = -1;

  for(;;) {
    var_02 = self canplayerplacesentry();
    var_0.origin = var_2["origin"];
    var_0.angles = var_2["angles"];
    var_0.canbeplaced = self isonground() && var_2["result"] && abs(var_0.origin[2] - self.origin[2]) < 10;

    if(var_0.canbeplaced != var_01) {
      if(var_0.canbeplaced) {
        var_00 setModel(level.func_12A8D[var_0.func_12A9A].modelplacement);
        self forceusehinton(level.func_12A8D[var_0.func_12A9A].placestring);
      } else {
        var_00 setModel(level.func_12A8D[var_0.func_12A9A].modelplacementfailed);
        self forceusehinton(level.func_12A8D[var_0.func_12A9A].cannotplacestring);
      }
    }

    var_01 = var_0.canbeplaced;
    wait 0.05;
  }
}

func_12A16(var_00) {
  self endon("placed");
  self endon("death");
  var_00 waittill("death");

  if(self.canbeplaced) {
    func_12A2E();
  } else {
    self delete();
  }
}

func_12A17(var_00) {
  self endon("placed");
  self endon("death");
  var_00 waittill("disconnect");
  self delete();
}

func_12A15(var_00) {
  self endon("placed");
  self endon("death");
  var_00 scripts\engine\utility::waittill_any("joined_team", "joined_spectators");
  self delete();
}

func_12A18(var_00) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  self delete();
}

func_4A2C(var_00, var_01) {
  var_02 = spawnturret("misc_turret", var_1.origin, level.func_12A8D[var_00].weaponinfo);
  var_2.angles = var_1.angles;
  var_02 setModel(level.func_12A8D[var_00].modelbase);
  var_2.owner = var_01;
  var_2.health = level.func_12A8D[var_00].health;
  var_2.maxhealth = level.func_12A8D[var_00].maxhealth;
  var_2.damagetaken = 0;
  var_2.func_12A9A = var_00;
  var_2.stunned = 0;
  var_2.func_11199 = 5.0;
  var_02 setturretmodechangewait(1);
  var_02 func_12A2D();
  var_02 setsentryowner(var_01);
  var_02 setturretminimapvisible(1, var_00);
  var_02 setdefaultdroppitch(-89.0);
  var_02 thread func_129FC();
  var_2.func_4D49 = 1.0;
  var_02 thread func_12A03();
  var_02 thread func_12A50();
  return var_02;
}

func_12A2A() {
  self endon("death");
  self.owner endon("disconnect");
  self setdefaultdroppitch(0.0);
  self makeunusable();
  self getvalidlocation();

  if(!isDefined(self.owner)) {
    return;
  }
  var_00 = self.owner;

  if(isDefined(var_0.func_DF89)) {
    foreach(var_02 in var_0.func_DF89) {
      var_02 notify("death");
    }
  }

  var_0.func_DF89 = [];
  var_0.func_DF89[0] = self;
  var_0.using_remote_turret = 0;
  var_0.func_CB39 = 0;
  var_0.func_6617 = 1;

  if(isalive(var_00)) {
    var_00 scripts\mp\utility\game::setlowermessage("pickup_remote_turret", level.func_12A8D[self.func_12A9A].func_901F, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  }

  var_00 thread func_13AE5(self);

  if(level.teambased) {
    self.team = var_0.team;
    self setturretteam(var_0.team);
    scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 65));
  } else
    scripts\mp\entityheadicons::setplayerheadicon(self.owner, (0, 0, 65));

  self.ownertrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 32, 64);
  self.ownertrigger getrankxp();
  self.ownertrigger linkto(self);
  var_00 thread turret_handlepickup(self);
  thread func_13A1D();
  thread func_129FB();
  thread func_129FA();
  thread func_12A44();
  thread func_129CD();
}

func_10E08() {
  var_00 = self.owner;
  var_00 scripts\mp\utility\game::setusingremote(self.func_12A9A);
  var_00 scripts\mp\utility\game::freezecontrolswrapper(1);
  var_01 = var_00 scripts\mp\killstreaks\killstreaks::initridekillstreak();

  if(var_01 != "success") {
    if(var_01 != "disconnect") {
      var_00 scripts\mp\utility\game::clearusingremote();
    }

    return 0;
  }

  var_00 scripts\mp\utility\game::_giveweapon(level.func_12A8D[self.func_12A9A].remotedetonatethink);
  var_00 scripts\mp\utility\game::_switchtoweaponimmediate(level.func_12A8D[self.func_12A9A].remotedetonatethink);
  var_00 scripts\mp\utility\game::freezecontrolswrapper(0);
  var_00 thread waitsetthermal(1.0, self);

  if(isDefined(level.func_9181["thermal_mode"])) {
    level.func_9181["thermal_mode"] give_zap_perk("");
  }

  if(getdvarint("camera_thirdPerson")) {
    var_00 scripts\mp\utility\game::setthirdpersondof(0);
  }

  var_00 getwholescenedurationmax(self, "tag_player", 0, 180, 180, 50, 25, 0);
  var_00 _meth_8236(0);
  var_00 _meth_8235(1);
  var_00 remotecontrolturret(self);
  var_00 scripts\mp\utility\game::clearlowermessage("enter_remote_turret");
  var_00 scripts\mp\utility\game::clearlowermessage("pickup_remote_turret");
  var_00 scripts\mp\utility\game::setlowermessage("early_exit", level.func_12A8D[self.func_12A9A].func_901B, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

waitsetthermal(var_00, var_01) {
  self endon("disconnect");
  var_01 endon("death");
  wait(var_00);
  self visionsetthermalforplayer(game["thermal_vision"], 1.5);
  self thermalvisionon();
  self thermalvisionfofoverlayon();
}

func_1109C() {
  var_00 = self.owner;

  if(var_00 scripts\mp\utility\game::isusingremote()) {
    var_00 thermalvisionoff();
    var_00 thermalvisionfofoverlayoff();
    var_00 remotecontrolturretoff(self);
    var_00 unlink();
    var_00 scripts\mp\utility\game::_switchtoweapon(var_00 scripts\engine\utility::getlastweapon());
    var_00 scripts\mp\utility\game::clearusingremote();

    if(getdvarint("camera_thirdPerson")) {
      var_00 scripts\mp\utility\game::setthirdpersondof(1);
    }

    var_00 visionsetthermalforplayer(game["thermal_vision"], 0);
    var_01 = scripts\mp\utility\game::getkillstreakweapon(level.func_12A8D[self.func_12A9A].streakname);
    var_00 scripts\mp\killstreaks\killstreaks::func_1146C(var_01);
  }

  if(self.stunned) {
    var_00 stopshellshock();
  }

  var_00 scripts\mp\utility\game::clearlowermessage("early_exit");

  if(!isDefined(var_0.func_13108) || !var_0.func_13108) {
    var_00 scripts\mp\utility\game::setlowermessage("enter_remote_turret", level.func_12A8D[self.func_12A9A].func_901A, undefined, undefined, undefined, 1, 0.25, 1.5, 1);
  }

  self notify("exit");
}

func_13AE5(var_00) {
  self endon("disconnect");
  var_00 endon("death");
  self.func_13108 = 0;

  for(;;) {
    if(isalive(self)) {
      self waittill("death");
    }

    scripts\mp\utility\game::clearlowermessage("enter_remote_turret");
    scripts\mp\utility\game::clearlowermessage("pickup_remote_turret");

    if(self.using_remote_turret) {
      self.func_13108 = 1;
    } else {
      self.func_13108 = 0;
    }

    self waittill("spawned_player");

    if(!self.func_13108) {
      scripts\mp\utility\game::setlowermessage("enter_remote_turret", level.func_12A8D[var_0.func_12A9A].func_901A, undefined, undefined, undefined, 1, 0.25, 1.5, 1);
      continue;
    }

    var_00 notify("death");
  }
}

func_13A1D() {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  var_00 = self.owner;

  for(;;) {
    var_01 = var_00 getcurrentweapon();

    if(scripts\mp\utility\game::iskillstreakweapon(var_01) && var_01 != level.func_12A8D[self.func_12A9A].weaponinfo && var_01 != level.func_12A8D[self.func_12A9A].func_A84D && var_01 != level.func_12A8D[self.func_12A9A].remotedetonatethink && var_01 != "none" && (!var_00 scripts\mp\utility\game::isjuggernaut() || var_00 scripts\mp\utility\game::isusingremote())) {
      if(!isDefined(var_0.func_6617) || !var_0.func_6617) {
        var_0.func_6617 = 1;
        var_00 scripts\mp\utility\game::clearlowermessage("enter_remote_turret");
      }

      wait 0.05;
      continue;
    }

    if(var_00 istouching(self.ownertrigger)) {
      if(!isDefined(var_0.func_6617) || !var_0.func_6617) {
        var_0.func_6617 = 1;
        var_00 scripts\mp\utility\game::clearlowermessage("enter_remote_turret");
      }

      wait 0.05;
      continue;
    }

    if(isDefined(var_0.empgrenaded) && var_0.empgrenaded) {
      if(!isDefined(var_0.func_6617) || !var_0.func_6617) {
        var_0.func_6617 = 1;
        var_00 scripts\mp\utility\game::clearlowermessage("enter_remote_turret");
      }

      wait 0.05;
      continue;
    }

    if(var_00 getteamflagcount() && !var_0.using_remote_turret) {
      if(!isDefined(var_0.func_6617) || !var_0.func_6617) {
        var_0.func_6617 = 1;
        var_00 scripts\mp\utility\game::clearlowermessage("enter_remote_turret");
      }

      wait 0.05;
      continue;
    }

    if(isDefined(var_0.func_6617) && var_0.func_6617 && var_01 != "none") {
      var_00 scripts\mp\utility\game::setlowermessage("enter_remote_turret", level.func_12A8D[self.func_12A9A].func_901A, undefined, undefined, undefined, 1, 0.25, 1.5, 1);
      var_0.func_6617 = 0;
    }

    var_02 = 0;

    while(var_00 usebuttonpressed() && !var_00 fragbuttonpressed() && !var_00 scripts\mp\utility\game::_meth_85C7() && !var_00 secondaryoffhandbuttonpressed() && !var_00 isusingturret() && var_00 isonground() && !var_00 istouching(self.ownertrigger) && (!isDefined(var_0.empgrenaded) || !var_0.empgrenaded)) {
      if(isDefined(var_0.iscarrying) && var_0.iscarrying) {
        break;
      }
      if(isDefined(var_0.iscapturingcrate) && var_0.iscapturingcrate) {
        break;
      }
      if(!isalive(var_00)) {
        break;
      }
      if(!var_0.using_remote_turret && var_00 scripts\mp\utility\game::isusingremote()) {
        break;
      }
      if(var_00 getteamflagcount() && !var_0.using_remote_turret) {
        break;
      }
      var_02 = var_02 + 0.05;

      if(var_02 > 0.75) {
        var_0.using_remote_turret = !var_0.using_remote_turret;

        if(var_0.using_remote_turret) {
          var_00 removeweapons();
          var_00 func_1146D(self.func_12A9A);
          var_00 scripts\mp\utility\game::_giveweapon(level.func_12A8D[self.func_12A9A].func_A84D);
          var_00 scripts\mp\utility\game::_switchtoweaponimmediate(level.func_12A8D[self.func_12A9A].func_A84D);
          func_10E08();
          var_00 restoreweapons();
        } else {
          var_00 func_1146D(self.func_12A9A);
          func_1109C();
        }

        wait 2.0;
        break;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

turret_handlepickup(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("death");

  if(!isDefined(var_0.ownertrigger)) {
    return;
  }
  if(isDefined(self.pers["isBot"]) && self.pers["isBot"]) {
    return;
  }
  var_01 = 0;

  for(;;) {
    var_02 = self getcurrentweapon();

    if(scripts\mp\utility\game::iskillstreakweapon(var_02) && var_02 != "killstreak_remote_turret_mp" && var_02 != level.func_12A8D[var_0.func_12A9A].weaponinfo && var_02 != level.func_12A8D[var_0.func_12A9A].func_A84D && var_02 != level.func_12A8D[var_0.func_12A9A].remotedetonatethink && var_02 != "none" && (!scripts\mp\utility\game::isjuggernaut() || scripts\mp\utility\game::isusingremote())) {
      if(!isDefined(self.func_CB39) || !self.func_CB39) {
        self.func_CB39 = 1;
        scripts\mp\utility\game::clearlowermessage("pickup_remote_turret");
      }

      wait 0.05;
      continue;
    }

    if(!self istouching(var_0.ownertrigger)) {
      if(!isDefined(self.func_CB39) || !self.func_CB39) {
        self.func_CB39 = 1;
        scripts\mp\utility\game::clearlowermessage("pickup_remote_turret");
      }

      wait 0.05;
      continue;
    }

    if(scripts\mp\utility\game::isreallyalive(self) && self istouching(var_0.ownertrigger) && !isDefined(var_0.carriedby) && self isonground()) {
      if(isDefined(self.func_CB39) && self.func_CB39 && var_02 != "none") {
        scripts\mp\utility\game::setlowermessage("pickup_remote_turret", level.func_12A8D[var_0.func_12A9A].func_901F, undefined, undefined, undefined, undefined, undefined, undefined, 1);
        self.func_CB39 = 0;
      }

      if(self usebuttonpressed()) {
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }
        var_01 = 0;

        while(self usebuttonpressed()) {
          var_01 = var_01 + 0.05;
          wait 0.05;
        }

        if(var_01 >= 0.5) {
          continue;
        }
        var_01 = 0;

        while(!self usebuttonpressed() && var_01 < 0.5) {
          var_01 = var_01 + 0.05;
          wait 0.05;
        }

        if(var_01 >= 0.5) {
          continue;
        }
        if(!scripts\mp\utility\game::isreallyalive(self)) {
          continue;
        }
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }
        var_00 give_player_session_tokens(level.func_12A8D[var_0.func_12A9A].sentrymodeoff);
        thread func_F68B(var_00, 0);
        var_0.ownertrigger delete();
        self.func_DF89 = undefined;
        scripts\mp\utility\game::clearlowermessage("pickup_remote_turret");
        return;
      }
    }

    wait 0.05;
  }
}

func_129CD() {
  self endon("death");
  self endon("carried");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("antenna_light_mp"), self, "tag_fx");
    wait 1.0;
    stopFXOnTag(scripts\engine\utility::getfx("antenna_light_mp"), self, "tag_fx");
  }
}

func_12A2D() {
  self give_player_session_tokens(level.func_12A8D[self.func_12A9A].sentrymodeoff);

  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
  } else if(isDefined(self.owner)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }

  if(!isDefined(self.owner)) {
    return;
  }
  var_00 = self.owner;

  if(isDefined(var_0.using_remote_turret) && var_0.using_remote_turret) {
    var_00 thermalvisionoff();
    var_00 thermalvisionfofoverlayoff();
    var_00 remotecontrolturretoff(self);
    var_00 unlink();
    var_00 scripts\mp\utility\game::_switchtoweapon(var_00 scripts\engine\utility::getlastweapon());
    var_00 scripts\mp\utility\game::clearusingremote();

    if(getdvarint("camera_thirdPerson")) {
      var_00 scripts\mp\utility\game::setthirdpersondof(1);
    }

    var_00 scripts\mp\killstreaks\killstreaks::clearrideintro();
    var_00 visionsetthermalforplayer(game["thermal_vision"], 0);

    if(isDefined(var_0.disabledusability) && var_0.disabledusability) {
      var_00 scripts\engine\utility::allow_usability(1);
    }

    var_00 func_1146D(self.func_12A9A);
  }
}

func_129FC() {
  self endon("death");
  level endon("game_ended");
  self notify("turret_handleOwner");
  self endon("turret_handleOwner");
  self.owner scripts\engine\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  self notify("death");
}

func_12A44() {
  self endon("death");
  level endon("game_ended");
  var_00 = level.func_12A8D[self.func_12A9A].timeout;

  while(var_00) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby)) {
      var_00 = max(0, var_00 - 1.0);
    }
  }

  if(isDefined(self.owner)) {
    self.owner thread scripts\mp\utility\game::leaderdialogonplayer("sentry_gone");
  }

  self notify("death");
}

func_129FB() {
  self endon("carried");
  var_00 = self getentitynumber();
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self setModel(level.func_12A8D[self.func_12A9A].modeldestroyed);
  func_12A2D();
  self setdefaultdroppitch(40);
  self setsentryowner(undefined);
  self setturretminimapvisible(0);

  if(isDefined(self.ownertrigger)) {
    self.ownertrigger delete();
  }

  var_01 = self.owner;

  if(isDefined(var_01)) {
    var_1.using_remote_turret = 0;
    var_01 scripts\mp\utility\game::clearlowermessage("enter_remote_turret");
    var_01 scripts\mp\utility\game::clearlowermessage("early_exit");
    var_01 scripts\mp\utility\game::clearlowermessage("pickup_remote_turret");
    var_01 restoreperks();
    var_01 restoreweapons();

    if(var_01 getcurrentweapon() == "none") {
      var_01 scripts\mp\utility\game::_switchtoweapon(var_01 scripts\engine\utility::getlastweapon());
    }

    if(self.stunned) {
      var_01 stopshellshock();
    }
  }

  self playSound("sentry_explode");
  playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
  wait 1.5;
  self playSound("sentry_explode_smoke");

  for(var_02 = 8; var_02 > 0; var_02 = var_02 - 0.4) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    wait 0.4;
  }

  self notify("deleting");

  if(isDefined(self.func_11512)) {
    self.func_11512 delete();
  }

  self delete();
}

func_129FA() {
  self endon("death");
  self endon("carried");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(!scripts\mp\weapons::friendlyfirecheck(self.owner, var_01)) {
      continue;
    }
    if(isDefined(var_09)) {
      switch (var_09) {
        case "sensor_grenade_mp":
        case "flash_grenade_mp":
        case "concussion_grenade_mp":
          if(var_04 == "MOD_GRENADE_SPLASH" && self.owner.using_remote_turret) {
            self.stunned = 1;
            thread func_12A35();
          }
        case "smoke_grenadejugg_mp":
        case "smoke_grenade_mp":
          continue;
      }
    }

    if(!isDefined(self)) {
      return;
    }
    if(var_04 == "MOD_MELEE") {
      self.damagetaken = self.damagetaken + self.maxhealth;
    }

    if(isDefined(var_08) && var_08 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(var_08) && var_08 &level.idflags_no_team_protection) {
      self.wasdamagedfrombulletricochet = 1;
    }

    self.wasdamaged = 1;
    self.func_4D49 = 0.0;
    var_10 = var_00;

    if(isplayer(var_01)) {
      var_01 scripts\mp\damagefeedback::updatedamagefeedback("remote_turret");

      if(var_01 scripts\mp\utility\game::_hasperk("specialty_armorpiercing")) {
        var_10 = var_00 * level.armorpiercingmod;
      }
    }

    if(isDefined(var_1.owner) && isplayer(var_1.owner)) {
      var_1.owner scripts\mp\damagefeedback::updatedamagefeedback("remote_turret");
    }

    if(isDefined(var_09)) {
      switch (var_09) {
        case "remotemissile_projectile_mp":
        case "javelin_mp":
        case "remote_mortar_missile_mp":
        case "stinger_mp":
        case "ac130_40mm_mp":
        case "ac130_105mm_mp":
          self.largeprojectiledamage = 1;
          var_10 = self.maxhealth + 1;
          break;
        case "stealth_bomb_mp":
        case "artillery_mp":
          self.largeprojectiledamage = 0;
          var_10 = var_10 + var_00 * 4;
          break;
        case "emp_grenade_mp":
        case "bomb_site_mp":
          self.largeprojectiledamage = 0;
          var_10 = self.maxhealth + 1;
          break;
      }

      scripts\mp\killstreaks\killstreaks::killstreakhit(var_01, var_09, self, var_04);
    }

    self.damagetaken = self.damagetaken + var_10;

    if(self.damagetaken >= self.maxhealth) {
      if(isplayer(var_01) && (!isDefined(self.owner) || var_01 != self.owner)) {
        var_01 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_09, 100);
        var_01 notify("destroyed_killstreak");
      }

      if(isDefined(self.owner)) {
        self.owner thread scripts\mp\utility\game::leaderdialogonplayer(level.func_12A8D[self.func_12A9A].vodestroyed, undefined, undefined, self.origin);
      }

      self notify("death");
      return;
    }
  }
}

func_12A03() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0;

  for(;;) {
    if(self.func_4D49 < 1.0) {
      self.func_4D49 = self.func_4D49 + 0.1;
      var_00 = 1;
    } else if(var_00) {
      self.func_4D49 = 1.0;
      var_00 = 0;
    }

    wait 0.1;
  }
}

func_12A50() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0.1;
  var_01 = 1;
  var_02 = 1;

  for(;;) {
    if(var_02) {
      if(self.damagetaken > 0) {
        var_02 = 0;
        var_1++;
      }
    } else if(self.damagetaken >= self.maxhealth * (var_00 * var_01))
      var_1++;

    wait 0.05;
  }
}

func_12A35() {
  self notify("stunned");
  self endon("stunned");
  self endon("death");

  while(self.stunned) {
    self.owner shellshock("concussion_grenade_mp", self.func_11199);
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    var_00 = 0;

    while(var_00 < self.func_11199) {
      var_00 = var_00 + 0.05;
      wait 0.05;
    }

    self.stunned = 0;
  }
}