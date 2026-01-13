/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_remoteturret.gsc
****************************************************/

init() {
  level.var_12A9A = [];
  level.var_12A9A["mg_turret"] = "remote_mg_turret";
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("remote_mg_turret", ::func_128FC);
  level.var_12A8D = [];
  level.var_12A8D["mg_turret"] = spawnStruct();
  level.var_12A8D["mg_turret"].sentrymodeon = "manual";
  level.var_12A8D["mg_turret"].sentrymodeoff = "sentry_offline";
  level.var_12A8D["mg_turret"].timeout = 60;
  level.var_12A8D["mg_turret"].health = 999999;
  level.var_12A8D["mg_turret"].maxhealth = 1000;
  level.var_12A8D["mg_turret"].streakname = "remote_mg_turret";
  level.var_12A8D["mg_turret"].var_39B = "remote_turret_mp";
  level.var_12A8D["mg_turret"].modelbase = "mp_remote_turret";
  level.var_12A8D["mg_turret"].modelplacement = "mp_remote_turret_placement";
  level.var_12A8D["mg_turret"].modelplacementfailed = "mp_remote_turret_placement_failed";
  level.var_12A8D["mg_turret"].modeldestroyed = "mp_remote_turret";
  level.var_12A8D["mg_turret"].teamsplash = "used_remote_mg_turret";
  level.var_12A8D["mg_turret"].var_901A = &"KILLSTREAKS_ENTER_REMOTE_TURRET";
  level.var_12A8D["mg_turret"].var_901B = &"KILLSTREAKS_EARLY_EXIT";
  level.var_12A8D["mg_turret"].var_901F = &"KILLSTREAKS_DOUBLE_TAP_TO_CARRY";
  level.var_12A8D["mg_turret"].placestring = &"KILLSTREAKS_TURRET_PLACE";
  level.var_12A8D["mg_turret"].cannotplacestring = &"KILLSTREAKS_TURRET_CANNOT_PLACE";
  level.var_12A8D["mg_turret"].vodestroyed = "remote_sentry_destroyed";
  level.var_12A8D["mg_turret"].var_A84D = "killstreak_remote_turret_laptop_mp";
  level.var_12A8D["mg_turret"].remotedetonatethink = "killstreak_remote_turret_remote_mp";
  level._effect["sentry_explode_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx\core\mp\killstreaks\vfx_sg_damage_blacksmoke");
  level._effect["antenna_light_mp"] = loadfx("vfx\core\lights\light_detonator_blink");
}

func_128FC(var_0, var_1) {
  var_2 = func_128FF(var_0, "mg_turret");
  if(var_2) {
    scripts\mp\matchdata::logkillstreakevent(level.var_12A8D["mg_turret"].streakname, self.origin);
  }

  self.iscarrying = 0;
  return var_2;
}

func_1146D(var_0) {
  scripts\mp\utility::_takeweapon(level.var_12A8D[var_0].var_A84D);
  scripts\mp\utility::_takeweapon(level.var_12A8D[var_0].remotedetonatethink);
}

func_128FF(var_0, var_1) {
  if(scripts\mp\utility::isusingremote()) {
    return 0;
  }

  var_2 = func_4A2C(var_1, self);
  removeperks();
  func_F68B(var_2, 1);
  thread restoreperks();
  if(isDefined(var_2)) {
    return 1;
  }

  return 0;
}

func_F68B(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 func_12A2C(self);
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
    var_2 = scripts\engine\utility::waittill_any_return("place_turret", "cancel_turret", "force_cancel_placement");
    if(var_2 == "cancel_turret" || var_2 == "force_cancel_placement") {
      if(var_2 == "cancel_turret" && !var_1) {
        continue;
      }

      if(level.console) {
        var_3 = scripts\mp\utility::getkillstreakweapon(level.var_12A8D[var_0.var_12A9A].streakname);
        if(isDefined(self.var_A6A1) && var_3 == scripts\mp\utility::getkillstreakweapon(self.pers["killstreaks"][self.var_A6A1].streakname) && !self getweaponslistitems().size) {
          scripts\mp\utility::_giveweapon(var_3, 0);
          scripts\mp\utility::_setactionslot(4, "weapon", var_3);
        }
      }

      var_0 func_12A2B();
      scripts\engine\utility::allow_weapon(1);
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }

    var_0 func_12A2E();
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeperks() {
  if(scripts\mp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\mp\utility::removeperk("specialty_explosivebullets");
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  restoreperks();
}

removeweapons() {
  foreach(var_1 in self.weaponlist) {
    var_2 = strtok(var_1, "_");
    if(var_2[0] == "alt") {
      self.restoreweaponclipammo[var_1] = self getweaponammoclip(var_1);
      self.var_E2E9[var_1] = self getweaponammostock(var_1);
      continue;
    }

    self.restoreweaponclipammo[var_1] = self getweaponammoclip(var_1);
    self.var_E2E9[var_1] = self getweaponammostock(var_1);
  }

  self.var_13CD2 = [];
  foreach(var_1 in self.weaponlist) {
    var_2 = strtok(var_1, "_");
    if(var_2[0] == "alt") {
      continue;
    }

    self.var_13CD2[self.var_13CD2.size] = var_1;
    scripts\mp\utility::_takeweapon(var_1);
  }
}

restoreweapons() {
  if(!isDefined(self.restoreweaponclipammo) || !isDefined(self.var_E2E9) || !isDefined(self.var_13CD2)) {
    return;
  }

  var_0 = [];
  foreach(var_2 in self.var_13CD2) {
    var_3 = strtok(var_2, "_");
    if(var_3[0] == "alt") {
      var_0[var_0.size] = var_2;
      continue;
    }

    scripts\mp\utility::_giveweapon(var_2);
    if(isDefined(self.restoreweaponclipammo[var_2])) {
      self setweaponammoclip(var_2, self.restoreweaponclipammo[var_2]);
    }

    if(isDefined(self.var_E2E9[var_2])) {
      self setweaponammostock(var_2, self.var_E2E9[var_2]);
    }
  }

  foreach(var_6 in var_0) {
    if(isDefined(self.restoreweaponclipammo[var_6])) {
      self setweaponammoclip(var_6, self.restoreweaponclipammo[var_6]);
    }

    if(isDefined(self.var_E2E9[var_6])) {
      self setweaponammostock(var_6, self.var_E2E9[var_6]);
    }
  }

  self.restoreweaponclipammo = undefined;
  self.var_E2E9 = undefined;
}

func_13710() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  restoreweapons();
}

func_12A2E() {
  self setModel(level.var_12A8D[self.var_12A9A].modelbase);
  self setsentrycarrier(undefined);
  self setCanDamage(1);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
    scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self.triggerportableradarping);
  }

  self playSound("sentry_gun_plant");
  thread func_12A2A();
  self notify("placed");
}

func_12A2B() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self delete();
}

func_12A2C(var_0) {
  self setModel(level.var_12A8D[self.var_12A9A].modelplacement);
  self setCanDamage(0);
  self setsentrycarrier(var_0);
  self setcontents(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread func_12F4F(self);
  thread func_12A16(var_0);
  thread func_12A17(var_0);
  thread func_12A15(var_0);
  thread func_12A18();
  self setdefaultdroppitch(-89);
  func_12A2D();
  self notify("carried");
}

func_12F4F(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_0.canbeplaced = 1;
  var_1 = -1;
  for(;;) {
    var_2 = self canplayerplacesentry();
    var_0.origin = var_2["origin"];
    var_0.angles = var_2["angles"];
    var_0.canbeplaced = self isonground() && var_2["result"] && abs(var_0.origin[2] - self.origin[2]) < 10;
    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
        var_0 setModel(level.var_12A8D[var_0.var_12A9A].modelplacement);
        self forceusehinton(level.var_12A8D[var_0.var_12A9A].placestring);
      } else {
        var_0 setModel(level.var_12A8D[var_0.var_12A9A].modelplacementfailed);
        self forceusehinton(level.var_12A8D[var_0.var_12A9A].cannotplacestring);
      }
    }

    var_1 = var_0.canbeplaced;
    wait(0.05);
  }
}

func_12A16(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("death");
  if(self.canbeplaced) {
    func_12A2E();
    return;
  }

  self delete();
}

func_12A17(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

func_12A15(var_0) {
  self endon("placed");
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  self delete();
}

func_12A18(var_0) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  self delete();
}

func_4A2C(var_0, var_1) {
  var_2 = spawnturret("misc_turret", var_1.origin, level.var_12A8D[var_0].var_39B);
  var_2.angles = var_1.angles;
  var_2 setModel(level.var_12A8D[var_0].modelbase);
  var_2.triggerportableradarping = var_1;
  var_2.health = level.var_12A8D[var_0].health;
  var_2.maxhealth = level.var_12A8D[var_0].maxhealth;
  var_2.var_E1 = 0;
  var_2.var_12A9A = var_0;
  var_2.stunned = 0;
  var_2.var_11199 = 5;
  var_2 setturretmodechangewait(1);
  var_2 func_12A2D();
  var_2 setsentryowner(var_1);
  var_2 setturretminimapvisible(1, var_0);
  var_2 setdefaultdroppitch(-89);
  var_2 thread func_129FC();
  var_2.var_4D49 = 1;
  var_2 thread func_12A03();
  var_2 thread func_12A50();
  return var_2;
}

func_12A2A() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self setdefaultdroppitch(0);
  self makeunusable();
  self getvalidlocation();
  if(!isDefined(self.triggerportableradarping)) {
    return;
  }

  var_0 = self.triggerportableradarping;
  if(isDefined(var_0.var_DF89)) {
    foreach(var_2 in var_0.var_DF89) {
      var_2 notify("death");
    }
  }

  var_0.var_DF89 = [];
  var_0.var_DF89[0] = self;
  var_0.using_remote_turret = 0;
  var_0.var_CB39 = 0;
  var_0.var_6617 = 1;
  if(isalive(var_0)) {
    var_0 scripts\mp\utility::setlowermessage("pickup_remote_turret", level.var_12A8D[self.var_12A9A].var_901F, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  }

  var_0 thread func_13AE5(self);
  if(level.teambased) {
    self.team = var_0.team;
    self setturretteam(var_0.team);
    scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 65));
  } else {
    scripts\mp\entityheadicons::setplayerheadicon(self.triggerportableradarping, (0, 0, 65));
  }

  self.ownertrigger = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 32, 64);
  self.ownertrigger enablelinkto();
  self.ownertrigger linkto(self);
  var_0 thread turret_handlepickup(self);
  thread func_13A1D();
  thread func_129FB();
  thread func_129FA();
  thread func_12A44();
  thread func_129CD();
}

func_10E08() {
  var_0 = self.triggerportableradarping;
  var_0 scripts\mp\utility::setusingremote(self.var_12A9A);
  var_0 scripts\mp\utility::freezecontrolswrapper(1);
  var_1 = var_0 scripts\mp\killstreaks\_killstreaks::initridekillstreak();
  if(var_1 != "success") {
    if(var_1 != "disconnect") {
      var_0 scripts\mp\utility::clearusingremote();
    }

    return 0;
  }

  var_0 scripts\mp\utility::_giveweapon(level.var_12A8D[self.var_12A9A].remotedetonatethink);
  var_0 scripts\mp\utility::_switchtoweaponimmediate(level.var_12A8D[self.var_12A9A].remotedetonatethink);
  var_0 scripts\mp\utility::freezecontrolswrapper(0);
  var_0 thread waitsetthermal(1, self);
  if(isDefined(level.var_9181["thermal_mode"])) {
    level.var_9181["thermal_mode"] settext("");
  }

  if(getdvarint("camera_thirdPerson")) {
    var_0 scripts\mp\utility::setthirdpersondof(0);
  }

  var_0 playerlinkweaponviewtodelta(self, "tag_player", 0, 180, 180, 50, 25, 0);
  var_0 _meth_8236(0);
  var_0 _meth_8235(1);
  var_0 remotecontrolturret(self);
  var_0 scripts\mp\utility::clearlowermessage("enter_remote_turret");
  var_0 scripts\mp\utility::clearlowermessage("pickup_remote_turret");
  var_0 scripts\mp\utility::setlowermessage("early_exit", level.var_12A8D[self.var_12A9A].var_901B, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

waitsetthermal(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("death");
  wait(var_0);
  self visionsetthermalforplayer(game["thermal_vision"], 1.5);
  self thermalvisionon();
  self thermalvisionfofoverlayon();
}

func_1109C() {
  var_0 = self.triggerportableradarping;
  if(var_0 scripts\mp\utility::isusingremote()) {
    var_0 thermalvisionoff();
    var_0 thermalvisionfofoverlayoff();
    var_0 geysers_and_boatride(self);
    var_0 unlink();
    var_0 scripts\mp\utility::_switchtoweapon(var_0 scripts\engine\utility::getlastweapon());
    var_0 scripts\mp\utility::clearusingremote();
    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility::setthirdpersondof(1);
    }

    var_0 visionsetthermalforplayer(game["thermal_vision"], 0);
    var_1 = scripts\mp\utility::getkillstreakweapon(level.var_12A8D[self.var_12A9A].streakname);
    var_0 scripts\mp\killstreaks\_killstreaks::func_1146C(var_1);
  }

  if(self.stunned) {
    var_0 stopshellshock();
  }

  var_0 scripts\mp\utility::clearlowermessage("early_exit");
  if(!isDefined(var_0.var_13108) || !var_0.var_13108) {
    var_0 scripts\mp\utility::setlowermessage("enter_remote_turret", level.var_12A8D[self.var_12A9A].var_901A, undefined, undefined, undefined, 1, 0.25, 1.5, 1);
  }

  self notify("exit");
}

func_13AE5(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  self.var_13108 = 0;
  for(;;) {
    if(isalive(self)) {
      self waittill("death");
    }

    scripts\mp\utility::clearlowermessage("enter_remote_turret");
    scripts\mp\utility::clearlowermessage("pickup_remote_turret");
    if(self.using_remote_turret) {
      self.var_13108 = 1;
    } else {
      self.var_13108 = 0;
    }

    self waittill("spawned_player");
    if(!self.var_13108) {
      scripts\mp\utility::setlowermessage("enter_remote_turret", level.var_12A8D[var_0.var_12A9A].var_901A, undefined, undefined, undefined, 1, 0.25, 1.5, 1);
      continue;
    }

    var_0 notify("death");
  }
}

func_13A1D() {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  var_0 = self.triggerportableradarping;
  for(;;) {
    var_1 = var_0 getcurrentweapon();
    if(scripts\mp\utility::iskillstreakweapon(var_1) && var_1 != level.var_12A8D[self.var_12A9A].var_39B && var_1 != level.var_12A8D[self.var_12A9A].var_A84D && var_1 != level.var_12A8D[self.var_12A9A].remotedetonatethink && var_1 != "none" && !var_0 scripts\mp\utility::isjuggernaut() || var_0 scripts\mp\utility::isusingremote()) {
      if(!isDefined(var_0.var_6617) || !var_0.var_6617) {
        var_0.var_6617 = 1;
        var_0 scripts\mp\utility::clearlowermessage("enter_remote_turret");
      }

      wait(0.05);
      continue;
    }

    if(var_0 istouching(self.ownertrigger)) {
      if(!isDefined(var_0.var_6617) || !var_0.var_6617) {
        var_0.var_6617 = 1;
        var_0 scripts\mp\utility::clearlowermessage("enter_remote_turret");
      }

      wait(0.05);
      continue;
    }

    if(isDefined(var_0.empgrenaded) && var_0.empgrenaded) {
      if(!isDefined(var_0.var_6617) || !var_0.var_6617) {
        var_0.var_6617 = 1;
        var_0 scripts\mp\utility::clearlowermessage("enter_remote_turret");
      }

      wait(0.05);
      continue;
    }

    if(var_0 islinked() && !var_0.using_remote_turret) {
      if(!isDefined(var_0.var_6617) || !var_0.var_6617) {
        var_0.var_6617 = 1;
        var_0 scripts\mp\utility::clearlowermessage("enter_remote_turret");
      }

      wait(0.05);
      continue;
    }

    if(isDefined(var_0.var_6617) && var_0.var_6617 && var_1 != "none") {
      var_0 scripts\mp\utility::setlowermessage("enter_remote_turret", level.var_12A8D[self.var_12A9A].var_901A, undefined, undefined, undefined, 1, 0.25, 1.5, 1);
      var_0.var_6617 = 0;
    }

    var_2 = 0;
    while(var_0 usebuttonpressed() && !var_0 fragbuttonpressed() && !var_0 scripts\mp\utility::_meth_85C7() && !var_0 secondaryoffhandbuttonpressed() && !var_0 isusingturret() && var_0 isonground() && !var_0 istouching(self.ownertrigger) && !isDefined(var_0.empgrenaded) || !var_0.empgrenaded) {
      if(isDefined(var_0.iscarrying) && var_0.iscarrying) {
        break;
      }

      if(isDefined(var_0.iscapturingcrate) && var_0.iscapturingcrate) {
        break;
      }

      if(!isalive(var_0)) {
        break;
      }

      if(!var_0.using_remote_turret && var_0 scripts\mp\utility::isusingremote()) {
        break;
      }

      if(var_0 islinked() && !var_0.using_remote_turret) {
        break;
      }

      var_2 = var_2 + 0.05;
      if(var_2 > 0.75) {
        var_0.using_remote_turret = !var_0.using_remote_turret;
        if(var_0.using_remote_turret) {
          var_0 removeweapons();
          var_0 func_1146D(self.var_12A9A);
          var_0 scripts\mp\utility::_giveweapon(level.var_12A8D[self.var_12A9A].var_A84D);
          var_0 scripts\mp\utility::_switchtoweaponimmediate(level.var_12A8D[self.var_12A9A].var_A84D);
          func_10E08();
          var_0 restoreweapons();
        } else {
          var_0 func_1146D(self.var_12A9A);
          func_1109C();
        }

        wait(2);
        break;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

turret_handlepickup(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  if(!isDefined(var_0.ownertrigger)) {
    return;
  }

  if(isDefined(self.pers["isBot"]) && self.pers["isBot"]) {
    return;
  }

  var_1 = 0;
  for(;;) {
    var_2 = self getcurrentweapon();
    if(scripts\mp\utility::iskillstreakweapon(var_2) && var_2 != "killstreak_remote_turret_mp" && var_2 != level.var_12A8D[var_0.var_12A9A].var_39B && var_2 != level.var_12A8D[var_0.var_12A9A].var_A84D && var_2 != level.var_12A8D[var_0.var_12A9A].remotedetonatethink && var_2 != "none" && !scripts\mp\utility::isjuggernaut() || scripts\mp\utility::isusingremote()) {
      if(!isDefined(self.var_CB39) || !self.var_CB39) {
        self.var_CB39 = 1;
        scripts\mp\utility::clearlowermessage("pickup_remote_turret");
      }

      wait(0.05);
      continue;
    }

    if(!self istouching(var_0.ownertrigger)) {
      if(!isDefined(self.var_CB39) || !self.var_CB39) {
        self.var_CB39 = 1;
        scripts\mp\utility::clearlowermessage("pickup_remote_turret");
      }

      wait(0.05);
      continue;
    }

    if(scripts\mp\utility::isreallyalive(self) && self istouching(var_0.ownertrigger) && !isDefined(var_0.carriedby) && self isonground()) {
      if(isDefined(self.var_CB39) && self.var_CB39 && var_2 != "none") {
        scripts\mp\utility::setlowermessage("pickup_remote_turret", level.var_12A8D[var_0.var_12A9A].var_901F, undefined, undefined, undefined, undefined, undefined, undefined, 1);
        self.var_CB39 = 0;
      }

      if(self usebuttonpressed()) {
        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }

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

        if(!scripts\mp\utility::isreallyalive(self)) {
          continue;
        }

        if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
          continue;
        }

        var_0 give_player_session_tokens(level.var_12A8D[var_0.var_12A9A].sentrymodeoff);
        thread func_F68B(var_0, 0);
        var_0.ownertrigger delete();
        self.var_DF89 = undefined;
        scripts\mp\utility::clearlowermessage("pickup_remote_turret");
        return;
      }
    }

    wait(0.05);
  }
}

func_129CD() {
  self endon("death");
  self endon("carried");
  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("antenna_light_mp"), self, "tag_fx");
    wait(1);
    stopFXOnTag(scripts\engine\utility::getfx("antenna_light_mp"), self, "tag_fx");
  }
}

func_12A2D() {
  self give_player_session_tokens(level.var_12A8D[self.var_12A9A].sentrymodeoff);
  if(level.teambased) {
    scripts\mp\entityheadicons::setteamheadicon("none", (0, 0, 0));
  } else if(isDefined(self.triggerportableradarping)) {
    scripts\mp\entityheadicons::setplayerheadicon(undefined, (0, 0, 0));
  }

  if(!isDefined(self.triggerportableradarping)) {
    return;
  }

  var_0 = self.triggerportableradarping;
  if(isDefined(var_0.using_remote_turret) && var_0.using_remote_turret) {
    var_0 thermalvisionoff();
    var_0 thermalvisionfofoverlayoff();
    var_0 geysers_and_boatride(self);
    var_0 unlink();
    var_0 scripts\mp\utility::_switchtoweapon(var_0 scripts\engine\utility::getlastweapon());
    var_0 scripts\mp\utility::clearusingremote();
    if(getdvarint("camera_thirdPerson")) {
      var_0 scripts\mp\utility::setthirdpersondof(1);
    }

    var_0 scripts\mp\killstreaks\_killstreaks::clearrideintro();
    var_0 visionsetthermalforplayer(game["thermal_vision"], 0);
    if(isDefined(var_0.disabledusability) && var_0.disabledusability) {
      var_0 scripts\engine\utility::allow_usability(1);
    }

    var_0 func_1146D(self.var_12A9A);
  }
}

func_129FC() {
  self endon("death");
  level endon("game_ended");
  self notify("turret_handleOwner");
  self endon("turret_handleOwner");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  self notify("death");
}

func_12A44() {
  self endon("death");
  level endon("game_ended");
  var_0 = level.var_12A8D[self.var_12A9A].timeout;
  while(var_0) {
    wait(1);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(!isDefined(self.carriedby)) {
      var_0 = max(0, var_0 - 1);
    }
  }

  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer("sentry_gone");
  }

  self notify("death");
}

func_129FB() {
  self endon("carried");
  var_0 = self getentitynumber();
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  self setModel(level.var_12A8D[self.var_12A9A].modeldestroyed);
  func_12A2D();
  self setdefaultdroppitch(40);
  self setsentryowner(undefined);
  self setturretminimapvisible(0);
  if(isDefined(self.ownertrigger)) {
    self.ownertrigger delete();
  }

  var_1 = self.triggerportableradarping;
  if(isDefined(var_1)) {
    var_1.using_remote_turret = 0;
    var_1 scripts\mp\utility::clearlowermessage("enter_remote_turret");
    var_1 scripts\mp\utility::clearlowermessage("early_exit");
    var_1 scripts\mp\utility::clearlowermessage("pickup_remote_turret");
    var_1 restoreperks();
    var_1 restoreweapons();
    if(var_1 getcurrentweapon() == "none") {
      var_1 scripts\mp\utility::_switchtoweapon(var_1 scripts\engine\utility::getlastweapon());
    }

    if(self.stunned) {
      var_1 stopshellshock();
    }
  }

  self playSound("sentry_explode");
  playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
  wait(1.5);
  self playSound("sentry_explode_smoke");
  var_2 = 8;
  while(var_2 > 0) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    wait(0.4);
    var_2 = var_2 - 0.4;
  }

  self notify("deleting");
  if(isDefined(self.var_11512)) {
    self.var_11512 delete();
  }

  self delete();
}

func_129FA() {
  self endon("death");
  self endon("carried");
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(!scripts\mp\weapons::friendlyfirecheck(self.triggerportableradarping, var_1)) {
      continue;
    }

    if(isDefined(var_9)) {
      switch (var_9) {
        case "sensor_grenade_mp":
        case "flash_grenade_mp":
        case "concussion_grenade_mp":
          if(var_4 == "MOD_GRENADE_SPLASH" && self.triggerportableradarping.using_remote_turret) {
            self.stunned = 1;
            thread func_12A35();
          }

          break;

        case "smoke_grenadejugg_mp":
        case "smoke_grenade_mp":
          break;
      }
    }

    if(!isDefined(self)) {
      return;
    }

    if(var_4 == "MOD_MELEE") {
      self.var_E1 = self.var_E1 + self.maxhealth;
    }

    if(isDefined(var_8) && var_8 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(var_8) && var_8 &level.idflags_ricochet) {
      self.wasdamagedfrombulletricochet = 1;
    }

    self.wasdamaged = 1;
    self.var_4D49 = 0;
    var_0A = var_0;
    if(isplayer(var_1)) {
      var_1 scripts\mp\damagefeedback::updatedamagefeedback("remote_turret");
      if(var_1 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
        var_0A = var_0 * level.armorpiercingmod;
      }
    }

    if(isDefined(var_1.triggerportableradarping) && isplayer(var_1.triggerportableradarping)) {
      var_1.triggerportableradarping scripts\mp\damagefeedback::updatedamagefeedback("remote_turret");
    }

    if(isDefined(var_9)) {
      switch (var_9) {
        case "remotemissile_projectile_mp":
        case "javelin_mp":
        case "remote_mortar_missile_mp":
        case "stinger_mp":
        case "ac130_40mm_mp":
        case "ac130_105mm_mp":
          self.largeprojectiledamage = 1;
          var_0A = self.maxhealth + 1;
          break;

        case "stealth_bomb_mp":
        case "artillery_mp":
          self.largeprojectiledamage = 0;
          var_0A = var_0A + var_0 * 4;
          break;

        case "emp_grenade_mp":
        case "bomb_site_mp":
          self.largeprojectiledamage = 0;
          var_0A = self.maxhealth + 1;
          break;
      }

      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_1, var_9, self, var_4);
    }

    self.var_E1 = self.var_E1 + var_0A;
    if(self.var_E1 >= self.maxhealth) {
      if(isplayer(var_1) && !isDefined(self.triggerportableradarping) || var_1 != self.triggerportableradarping) {
        var_1 thread scripts\mp\utility::giveunifiedpoints("kill", var_9, 100);
        var_1 notify("destroyed_killstreak");
      }

      if(isDefined(self.triggerportableradarping)) {
        self.triggerportableradarping thread scripts\mp\utility::leaderdialogonplayer(level.var_12A8D[self.var_12A9A].vodestroyed, undefined, undefined, self.origin);
      }

      self notify("death");
      return;
    }
  }
}

func_12A03() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0;
  for(;;) {
    if(self.var_4D49 < 1) {
      self.var_4D49 = self.var_4D49 + 0.1;
      var_0 = 1;
    } else if(var_0) {
      self.var_4D49 = 1;
      var_0 = 0;
    }

    wait(0.1);
  }
}

func_12A50() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.1;
  var_1 = 1;
  var_2 = 1;
  for(;;) {
    if(var_2) {
      if(self.var_E1 > 0) {
        var_2 = 0;
        var_1++;
      }
    } else if(self.var_E1 >= self.maxhealth * var_0 * var_1) {
      var_1++;
    }

    wait(0.05);
  }
}

func_12A35() {
  self notify("stunned");
  self endon("stunned");
  self endon("death");
  while(self.stunned) {
    self.triggerportableradarping shellshock("concussion_grenade_mp", self.var_11199);
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    var_0 = 0;
    while(var_0 < self.var_11199) {
      var_0 = var_0 + 0.05;
      wait(0.05);
    }

    self.stunned = 0;
  }
}