/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\supers\super_stoppingpower.gsc
***********************************************/

_id_138E7() {
  level._id_120AD _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty(::_id_138ED, level);
  level._id_120AE _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty(::_id_138EE, level);
}

stoppingpower_beginuse() {
  var_0 = self.lastweaponobj;
  var_1 = isundefinedweapon();

  if(!scripts\mp\weapons::isnormallastweapon(var_0) || scripts\mp\utility\weapon::ismeleeonly(var_0) || scripts\mp\utility\weapon::isgamemodeweapon(var_0) || scripts\mp\utility\weapon::issinglehitweapon(var_0.basename) || !_id_138EA(var_0) || _id_138E8(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8C9E182193BFABA1BAA9A93599813A6FB979CC017624F3E9A00D");

    return 0;
  }

  var_2 = stoppingpower_cancelreload();

  if(!istrue(var_2))
    return 0;

  if(self isalternatemode(var_0)) {
    var_1 = var_0;
    var_0 = var_0 getnoaltweapon();
  } else
    var_1 = var_0 getaltweapon();

  var_3 = [];
  var_4 = 0;
  var_5 = 0;

  if(!nullweapon(var_1))
    var_3[var_3.size] = var_1;

  var_3[var_3.size] = var_0;

  foreach(var_7 in var_3) {
    var_8 = scripts\mp\utility\weapon::turnexfiltoside(var_7);

    if(isnullweapon(var_7, var_0, 0)) {
      var_9 = scripts\mp\weapons::getammooverride(var_7);
      var_10 = var_9 * 1;

      if(var_8)
        var_10 = var_10 * 2;

      thread stoppingpower_givehcr(self, var_7, var_10);

      if(1) {
        if(var_8) {
          var_9 = self getweaponammoclip(var_7, "_encstr_A5AD056A019C63") + self getweaponammoclip(var_7, "_encstr_8253060E2B5FE330");
          var_4 = self getweaponammostock(var_7);
          var_11 = var_9 + var_4;
          var_12 = int(min(_id_138E4(var_7, var_11), var_11 + var_10));
          self setweaponammostock(var_7, var_12);
          self setweaponammoclip(var_7, 0, "_encstr_A5AD056A019C63");
          self setweaponammoclip(var_7, 0, "_encstr_8253060E2B5FE330");
        } else {
          var_9 = self getweaponammoclip(var_7);
          var_4 = self getweaponammostock(var_7);
          var_11 = var_9 + var_4;
          var_13 = _id_138E4(var_7, var_11);
          var_14 = var_11 + var_10;
          var_5 = int(var_14 - var_13);
          var_15 = int(min(var_13, var_14));

          if(var_7.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
            self setweaponammoclip(var_7, var_9 + var_10);
          else {
            self setweaponammoclip(var_7, 0);

            if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
              var_16 = var_15 - var_4;
              _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_camera_normal(var_7, var_16);
            } else
              self setweaponammostock(var_7, var_15);
          }
        }
      }
    }
  }

  thread _id_138F0(var_0, var_4, var_5);
  return 1;
}

_id_138E4(var_0, var_1) {
  var_2 = var_0.maxammo;

  if(var_1 > var_2)
    var_2 = var_1;

  return var_2;
}

_id_138EA(var_0) {
  if(!self isalternatemode(var_0))
    return 1;

  var_1 = var_0.underbarrel;
  return scripts\mp\weapons::turretoverridefunc(var_1);
}

_id_138E8(var_0) {
  switch (var_0.basename) {
    case "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB":
    case "_encstr_A3BF1B2DF308C9816A3FA123D3725918E14A2B981EB3984B72BFFF83B3":
    case "_encstr_A30914AF1FA248DA40A925CB767AA382FFC7EB889ABF":
    case "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C":
      return 1;
  }

  return 0;
}

_id_138F0(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    if(self getcurrentprimaryweapon() != var_0) {
      break;
    }

    var_3 = self getweaponammoclip(var_0);

    if(var_3 > 0) {
      thread scripts\mp\hud_message::showsplash("_encstr_81CE1637D1EDC1C12DCD9DD7387BBBAC4EAFD8F685192B23");

      if(var_2 > 0)
        self setweaponammostock(var_0, var_1 + var_2);

      break;
    }

    waitframe();
  }

  if(!scripts\mp\supers::issuperinuse())
    waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]]();
}

stoppingpower_givehcr(var_0, var_1, var_2) {
  var_3 = init_relic_steelballs(var_0, var_1, var_2);
  _id_138E6(var_0, var_3);
}

init_relic_steelballs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.player = var_0;
  var_3.objweapon = var_1;
  var_3.rounds = var_2;
  var_3.gavehcr = 0;
  var_3.kills = 0;
  return var_3;
}

_id_138E6(var_0, var_1) {
  if(!isDefined(var_0.hcrdata))
    var_0.hcrdata = [];

  var_2 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_1.objweapon);
  var_3 = var_0.hcrdata[var_2];

  if(isDefined(var_3))
    var_3 thread stoppingpower_removehcr();

  var_0.hcrdata[var_2] = var_1;
  var_1 thread stoppingpower_clearhcrondeath();
  var_1 thread _id_138E2();
  var_1 thread _id_138E3();
  var_1 thread stoppingpower_givefastreload();
  var_0 thread stoppingpower_breaksprint();
  var_1 thread stoppingpower_watchhcrweaponchange();
  var_1 thread stoppingpower_watchhcrweaponfire();
}

_id_138ED(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_3 = var_1 _id_138E5(var_2);

  if(isDefined(var_3)) {
    var_4 = init_relic_steelballs(var_3.player, var_3.objweapon, var_3.rounds);
    var_0.hcrdata = var_4;
    var_3 thread stoppingpower_removehcr();
  }
}

_id_138EE(var_0, var_1, var_2) {
  var_3 = var_0.hcrdata;

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_3.player) || !var_3.player hasweapon(var_3.objweapon)) {
    return;
  }
  var_3.player = var_1;
  _id_138E6(var_1, var_3);
}

_id_138E5(var_0) {
  if(!isDefined(var_0))
    return undefined;

  if(!isDefined(self.hcrdata))
    return undefined;

  var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_0);
  return self.hcrdata[var_1];
}

stoppingpower_cancelreload() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self cancelreload();
  wait 0.05;
  return 1;
}

stoppingpower_watchhcrweaponchange() {
  self endon("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(self.player hasweapon(self.objweapon)) {
    if(_id_138E9(self.player getcurrentweapon())) {
      if(!self.gavehcr) {
        self.player scripts\mp\utility\perk::giveperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
        self.gavehcr = 1;
      }
    } else if(self.gavehcr) {
      self.player scripts\mp\utility\perk::removeperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");
      self.gavehcr = 0;
    }

    self.player waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }

  thread stoppingpower_removehcr();
}

stoppingpower_watchhcrweaponfire() {
  self endon("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(self.player hasweapon(self.objweapon)) {
    self.player waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_0);

    if(_id_138E9(var_0)) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  self.player thread _id_138EF(self.objweapon);
  thread stoppingpower_removehcr();
}

_id_138EF(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self)) {
    return;
  }
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(var_1 != "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD") {
    return;
  }
  self.waittill_unload_complete = 1;
  scripts\engine\utility::_id_143C0(2, "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self.waittill_unload_complete = undefined;
}

stoppingpower_removehcr() {
  self notify("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");

  if(isDefined(self.player)) {
    if(self.gavehcr)
      self.player scripts\mp\utility\perk::removeperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913");

    _id_138E1();
  }
}

_id_138EB() {
  self notify("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");

  if(isDefined(self.player))
    _id_138E1();
}

_id_138E1() {
  if(isDefined(self.player.hcrdata)) {
    var_0 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(self.objweapon);
    var_1 = self.player.hcrdata[var_0];

    if(var_1 == self)
      self.player.hcrdata[var_0] = undefined;

    self.player scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_9101121BEF3B3B8271C87DD0BB50736B81DB9801", self.kills);
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.player, level.superglobals.staticsuperdata["_encstr_9101121BEF3B3B8271C87DD0BB50736B81DB9801"].id, self.kills, 0);
  }
}

_id_138EC(var_0) {
  if(isDefined(var_0)) {
    var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_0);
    var_2 = self.hcrdata[var_1];

    if(isDefined(var_2)) {
      scripts\mp\utility\stats::incpersstat("_encstr_AACD13E6D1DE831C4B9BEC14EDDD2B936996C6B1CD", 1);
      scripts\mp\supers::combatrecordsuperkill("_encstr_9101121BEF3B3B8271C87DD0BB50736B81DB9801");
      scripts\cp\vehicles\vehicle_compass_cp::_id_12094();
      var_2.kills++;
    }
  }
}

_id_138E9(var_0) {
  var_1 = self.player getammotype(self.objweapon);
  var_2 = self.player getammotype(var_0);
  var_3 = var_1 == var_2;
  return isnullweapon(var_0, self.objweapon, 1) && var_3;
}

stoppingpower_clearhcrondeath() {
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  self.player waittill("_encstr_AD75063D571AE108");
  thread stoppingpower_removehcr();
}

_id_138E2() {
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread stoppingpower_removehcr();
}

_id_138E3() {
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  self.player waittill("_encstr_ADB9121B6B1A70608D729893D1737895228B9BA9");
  thread _id_138EB();
}

stoppingpower_givefastreload() {
  self.player endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.player scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  self.player scripts\engine\utility::_id_143A6("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_925B180390EF32EB08287F40B013677A6758EA7AE0652F43251E");
  self.player scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
}

stoppingpower_breaksprint() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\common\utility::allow_sprint(0);
  wait 0.4;
  scripts\common\utility::allow_sprint(1);
}