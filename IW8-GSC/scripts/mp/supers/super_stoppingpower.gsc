/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_stoppingpower.gsc
*****************************************************/

function ref_138e7() {
  level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty(&ref_138ed, level);
  level.ref_120ae _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty(&ref_138ee, level);
}

function stoppingpower_beginuse() {
  var0 = self.lastweaponobj;
  var1 = isundefinedweapon();

  if(!scripts\mp\weapons::isnormallastweapon(var0) || scripts\mp\utility\weapon::ismeleeonly(var0) || scripts\mp\utility\weapon::isgamemodeweapon(var0) || scripts\mp\utility\weapon::issinglehitweapon(var0.basename) || !ref_138ea(var0) || ref_138e8(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPPORT_BOX_INCOMPAT");
    }

    return false;
  }

  var2 = stoppingpower_cancelreload();

  if(!istrue(var2)) {
    return false;
  }

  if(self isalternatemode(var0)) {
    var1 = var0;
    var0 = var0 getnoaltweapon();
  } else {
    var1 = var0 getaltweapon();
  }

  var3 = [];
  var4 = 0;
  var5 = 0;

  if(!nullweapon(var1)) {
    var3 = var1;
  }

  var3 = var0;

  foreach(var7 in var3) {
    var8 = scripts\mp\utility\weapon::turnexfiltoside(var7);

    if(isnullweapon(var7, var0, 0)) {
      var9 = scripts\mp\weapons::getammooverride(var7);
      var10 = var9 * 1;

      if(var8) {
        var10 *= 2;
      }

      thread stoppingpower_givehcr(self, var7, var10);

      if(true) {
        if(var8) {
          var9 = self getweaponammoclip(var7, "left") + self getweaponammoclip(var7, "right");
          var4 = self getweaponammostock(var7);
          var11 = var9 + var4;
          var12 = int(min(ref_138e4(var7, var11), var11 + var10));
          self setweaponammostock(var7, var12);
          self setweaponammoclip(var7, 0, "left");
          self setweaponammoclip(var7, 0, "right");
        } else {
          var10 = self getweaponammoclip(var8);
          var5 = self getweaponammostock(var8);
          var11 = var10 + var5;
          var13 = ref_138e4(var8, var11);
          var14 = var11 + var11;
          var6 = int(var14 - var13);
          var15 = int(min(var13, var14));

          if(var8.basename == "iw8_lm_dblmg_mp") {
            self setweaponammoclip(var8, var10 + var11);
          } else {
            self setweaponammoclip(var8, 0);

            if(scripts\mp\utility\game::getgametype() == "br") {
              var16 = var15 - var5;
              scripts\mp\gametypes\br_weapons::delay_camera_normal(var8, var16);
            } else {
              self setweaponammostock(var8, var15);
            }
          }
        }
      }
    }
  }

  var7 = undefined;
  var9 = undefined;
  thread ref_138f0(var1, var5, var6);
  return true;
}

function ref_138e4(var0, var1) {
  var2 = var0.maxammo;

  if(var1 > var2) {
    var2 = var1;
  }

  return var2;
}

function ref_138ea(var0) {
  if(!self isalternatemode(var0)) {
    return 1;
  }

  var1 = var0.underbarrel;
  return scripts\mp\weapons::turretoverridefunc(var1);
}

function ref_138e8(var0) {
  switch (var0.basename) {
    case "iw8_lm_dblmg_mp":
    case "iw8_me_t9ballisticknife_mp":
    case "iw8_sm_t9nailgun_mp":
    case "iw8_fists_mp":
      return true;
  }

  return false;
}

function ref_138f0(var0, var1, var2) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    if(self getcurrentprimaryweapon() != var0) {
      break;
    }

    var3 = self getweaponammoclip(var0);

    if(var3 > 0) {
      thread scripts\mp\hud_message::showsplash("stopping_power_loaded");

      if(var2 > 0) {
        self setweaponammostock(var0, var1 + var2);
      }

      break;
    }

    waitframe();
  }

  if(!scripts\mp\supers::issuperinuse()) {
    waitframe();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
    return;
  }
}

function stoppingpower_givehcr(var0, var1, var2) {
  var3 = init_relic_steelballs(var0, var1, var2);
  ref_138e6(var0, var3);
}

function init_relic_steelballs(var0, var1, var2) {
  var3 = spawnStruct();
  var3.player = var0;
  var3.objweapon = var1;
  var3.rounds = var2;
  var3.gavehcr = 0;
  var3.kills = 0;
  return var3;
}

function ref_138e6(var0, var1) {
  if(!isDefined(var0.hcrdata)) {
    var0.hcrdata = [];
  }

  var2 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var1.objweapon);
  var3 = var0.hcrdata[var2];

  if(isDefined(var3)) {
    thread stoppingpower_removehcr();
  }

  var0.hcrdata[var2] = var1;
  thread stoppingpower_clearhcrondeath();
  thread ref_138e2();
  thread ref_138e3();
  thread stoppingpower_givefastreload();
  thread stoppingpower_breaksprint();
  thread stoppingpower_watchhcrweaponchange();
  thread stoppingpower_watchhcrweaponfire();
}

function ref_138ed(var0, var1, var2) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  var3 = ref_138e5(var1, var2);

  if(isDefined(var3)) {
    var4 = init_relic_steelballs(var3.player, var3.objweapon, var3.rounds);
    var0.hcrdata = var4;
    thread stoppingpower_removehcr();
    return;
  }
}

function ref_138ee(var0, var1, var2) {
  var3 = var0.hcrdata;

  if(!isDefined(var3)) {
    return;
  }

  if(!isDefined(var3.player) || !var3.player hasweapon(var3.objweapon)) {
    return;
  }

  var3.player = var1;
  ref_138e6(var1, var3);
}

function ref_138e5(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  if(!isDefined(self.hcrdata)) {
    return undefined;
  }

  var1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var0);
  return self.hcrdata[var1];
}

function stoppingpower_cancelreload() {
  self endon("death_or_disconnect");
  self cancelreload();
  wait 0.05;
  return true;
}

function stoppingpower_watchhcrweaponchange() {
  self endon("stoppingPower_removeHCR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    if(ref_138e9(self.player getcurrentweapon())) {
      if(!self.gavehcr) {
        self.player scripts\mp\utility\perk::giveperk("specialty_bulletdamage");
        self.gavehcr = 1;
      }
    } else if(self.gavehcr) {
      self.player scripts\mp\utility\perk::removeperk("specialty_bulletdamage");
      self.gavehcr = 0;
    }

    self.player waittill("weapon_change");
  }

  thread stoppingpower_removehcr();
}

function stoppingpower_watchhcrweaponfire() {
  self endon("stoppingPower_removeHCR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    self.player waittill("weapon_fired", var0);

    if(ref_138e9(var0)) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  thread ref_138ef(self.player);
  thread stoppingpower_removehcr();
}

function ref_138ef(var0) {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }

  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);

  if(var1 != "iw8_sn_crossbow") {
    return;
  }

  self.waittill_unload_complete = 1;
  scripts\engine\utility::ref_143c0(2, "weapon_fired", "weapon_change");
  self.waittill_unload_complete = undefined;
}

function stoppingpower_removehcr() {
  self notify("stoppingPower_removeHCR");

  if(isDefined(self.player)) {
    if(self.gavehcr) {
      self.player scripts\mp\utility\perk::removeperk("specialty_bulletdamage");
    }

    ref_138e1();
    return;
  }
}

function ref_138eb() {
  self notify("stoppingPower_removeHCR");

  if(isDefined(self.player)) {
    ref_138e1();
    return;
  }
}

function ref_138e1() {
  if(isDefined(self.player.hcrdata)) {
    var0 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(self.objweapon);
    var1 = self.player.hcrdata[var0];

    if(var1 == self) {
      self.player.hcrdata[var0] = undefined;
    }

    self.player scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_support_box", self.kills);
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.player, level.superglobals.staticsuperdata["super_support_box"].id, self.kills, 0);
    return;
  }
}

function ref_138ec(var0) {
  if(isDefined(var0)) {
    var1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var0);
    var2 = self.hcrdata[var1];

    if(isDefined(var2)) {
      scripts\mp\utility\stats::incpersstat("stoppingPowerKills", 1);
      scripts\mp\supers::combatrecordsuperkill("super_support_box");
      scripts\cp\vehicles\vehicle_compass_cp::ref_12094();
      var2.kills++;
      return;
    }

    return;
  }
}

function ref_138e9(var0) {
  var1 = self.player getammotype(self.objweapon);
  var2 = self.player getammotype(var0);
  var3 = var1 == var2;
  return isnullweapon(var0, self.objweapon, 1) && var3;
}

function stoppingpower_clearhcrondeath() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  self.player waittill("death");
  thread stoppingpower_removehcr();
}

function ref_138e2() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  level waittill("game_ended");
  thread stoppingpower_removehcr();
}

function ref_138e3() {
  self.player endon("disconnect");
  self endon("stoppingPower_removeHCR");
  self.player waittill("all_perks_cleared");
  thread ref_138eb();
}

function stoppingpower_givefastreload() {
  self.player endon("death_or_disconnect");
  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  self.player scripts\engine\utility::ref_143a6("weapon_fired", "weapon_change", "stoppingPower_removeHCR");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastreload");
}

function stoppingpower_breaksprint() {
  self endon("death_or_disconnect");
  scripts\common\utility::allow_sprint(0);
  wait 0.4;
  scripts\common\utility::allow_sprint(1);
}