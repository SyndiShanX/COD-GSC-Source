/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\throwing_weapon.gsc
*****************************************************/

isaxeweaponcommon(var_0) {
  if(isDefined(level._id_8774)) {
    return [[level._id_8774]](var_0);
  }

  return 0;
}

get_weapon_root_name_common(var_0) {
  if(isDefined(level.getweaponrootname)) {
    return [[level.getweaponrootname]](var_0);
  }

  return undefined;
}

_id_10B6D(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.weapon_name) && isDefined(var_1)) {
    self.weapon_name = var_1;
  }

  self waittill("missile_stuck", var_2, var_3);

  if(isDefined(var_2) && (isPlayer(var_2) || isagent(var_2))) {
    var_4 = var_3 == "tag_riot_shield";

    if(var_4) {
      if(isDefined(self.owner) && isDefined(level.ricochetaxe)) {
        var_5 = self.owner;
        self[[level.ricochetaxe]](self.weapon_name, var_5);
        return;
      }
    }
  }

  if(isDefined(level.outlineaxe)) {
    if(isDefined(level.gametype) && level.gametype == "gun" && var_0 != self.owner) {
      return;
    }
    [[level.outlineaxe]](self, var_0, "outline_nodepth_white", "level_script");
  }

  var_6 = 45;
  thread _id_10A95(var_6);
  thread _id_10B6E();
  thread watch_axe_cleanup(self.owner, self._id_10D0C);
  var_7 = self._id_10D0C;
  thread _id_10A96(var_0, var_7);
  thread _id_10A94(var_0, var_7);
}

watch_axe_cleanup(var_0, var_1) {
  if(!scripts\engine\utility::is_equal(level.gametype, "zombie")) {
    return;
  }
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = get_weapon_root_name_common(var_1);

  if(!isDefined(var_2)) {
    return;
  }
  self endon("death");
  var_0 endon("death_or_disconnect");

  for(;;) {
    var_0 waittill("thrown_weapon_cleanup", var_1);

    if(isDefined(var_1)) {
      var_3 = get_weapon_root_name_common(var_1);

      if(isDefined(var_3) && var_3 == var_2) {
        self delete();
        return;
      }
    }
  }
}

_id_10A95(var_0) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(level._id_7AB1)) {
    [[level._id_7AB1]](var_0);
  }

  self delete();
}

_id_10A94(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = spawn("trigger_radius", self.origin - (0, 0, 40), 0, 64, 64);
  var_2 _meth_80DB();
  var_2 linkto(self);
  self._id_8E32 = var_2;
  var_2 endon("death");

  for(;;) {
    var_2 waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0 _id_B66C(self)) {
      var_0 _id_B73C(var_1, 1);
      self delete();
      break;
    }
  }
}

_id_10A96(var_0, var_1) {
  if(isDefined(level.gametype) && level.gametype == "gun") {
    return;
  }
  if(level.gametype == "zombie") {
    return;
  }
  self endon("death");
  level endon("game_ended");
  var_2 = spawn("script_model", self.origin);
  var_2 linkto(self);
  self._id_FE91 = var_2;
  var_2 makeuseable();
  var_2 setcursorhint("HINT_NOICON");
  var_2 _meth_84D9("show");

  switch (var_1.basename) {
    case "s4_me_icepick_mp":
      var_2 sethintstring(&"WEAPON_THROWINGMELEE/PICKUP_ICEPICK");
      break;
    case "s4_me_axe_mp":
      var_2 sethintstring(&"WEAPON_THROWINGMELEE/PICKUP_AXE");
      break;
  }

  var_2 sethintdisplayfov(360);
  var_2 setusefov(360);
  var_2 _meth_84D4(64);
  var_2 setuserange(64);
  var_2 _meth_83A1(0);
  var_2 waittill("trigger", var_0);
  var_0 _id_B73C(var_1, 0);
  self delete();
}

_id_B66C(var_0) {
  if(isDefined(var_0.owner) && self != var_0.owner) {
    return 0;
  }

  var_1 = self getweaponslistprimaries();
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(isaxeweaponcommon(var_5) && self getweaponammoclip(var_5) == 0) {
      var_2 = 1;
      break;
    }

    if(issubstr(var_5.basename, "iw8_fists_mp")) {
      var_2 = 1;
      break;
    }

    if(!var_5._id_0245) {
      var_3++;
    }
  }

  if(var_3 < 2) {
    var_2 = 1;
  }

  return var_2;
}

_id_B73C(var_0, var_1) {
  var_2 = var_0 _meth_8628();
  var_3 = self getcurrentweapon();
  var_4 = self getweaponslistprimaries();

  if(self hasweapon(var_0)) {
    var_5 = self getweaponammoclip(var_0);

    if(!var_1 && var_5 > 0) {
      self dropitem(var_0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    } else if(!issubstr(var_3.basename, var_0.basename)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    }

    var_6 = self getweaponammoclip(var_3) == 0 && isaxeweaponcommon(var_3);
    var_7 = issubstr(var_3.basename, "iw8_fists_mp");

    if(!var_1 || var_7 || var_6) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_2);
    }

    self setweaponammoclip(var_2, 1);

    if(isDefined(level.displayhudmessage)) {
      self[[level.displayhudmessage]]("axe", var_0);
      self playsoundtoplayer("weap_pickup_knife", self, self);
    }

    return;
  }

  var_8 = undefined;
  var_9 = 0;

  foreach(var_11 in var_4) {
    if(var_11._id_0245) {
      continue;
    }
    if(issubstr(var_11.basename, "uplinkball")) {
      continue;
    }
    var_12 = self getweaponammoclip(var_11) == 0 && isaxeweaponcommon(var_11);

    if(!isDefined(var_8) && (_func_0347(var_11) || var_12)) {
      var_8 = var_11;
    }

    var_9++;
  }

  var_14 = undefined;

  if(isDefined(var_8)) {
    var_14 = var_8;
  } else if(var_9 >= 2) {
    var_14 = var_3;
  }

  var_15 = !var_1 || isDefined(var_14) && issubstr(var_3.basename, var_14.basename);

  if(isDefined(var_14)) {
    var_12 = self getweaponammoclip(var_14) == 0 && isaxeweaponcommon(var_14);
    var_16 = var_14.basename == "iw8_fists_mp";
    var_17 = _func_0274(var_14) && !var_12;

    if(var_17) {
      var_18 = self dropitem(var_14);

      if(isDefined(var_18)) {
        var_19 = getcompleteweaponname(var_14);

        if(isDefined(self._id_F33C[var_19])) {
          var_18.owner = self._id_F33C[var_19];
          self._id_F33C[var_19] = undefined;
        } else
          var_18.owner = self;

        var_18._id_0481 = "dropped_weapon";
        var_18.objweapon = var_14;

        if(isDefined(level._id_10C2F)) {
          var_18 thread[[level._id_10C2F]]();
        }

        var_18 thread deleteweaponpickupafterawhile();
      }
    } else if(!var_17 && !(var_16 && var_9 < 2) && !(var_12 && var_9 < 2))
      self takeweapon(var_14);
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
  self setweaponammoclip(var_2, 1);

  if(var_15) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_2);
  }

  if(isDefined(level.displayhudmessage)) {
    self[[level.displayhudmessage]]("axe");
    self playsoundtoplayer("weap_pickup_knife", self, self);
  }

  if(isDefined(level._id_5BFC)) {
    [[level._id_5BFC]](self, var_2);
  }
}

deleteweaponpickupafterawhile() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

_id_10B6E() {
  self waittill("death");

  if(isDefined(self._id_8E32)) {
    self._id_8E32 delete();
  }

  if(isDefined(self._id_FE91)) {
    self._id_FE91 delete();
  }
}

_id_108DD() {
  for(;;) {
    self waittill("grenade_fire", var_0, var_1, var_2, var_3);

    if(!_id_7180(var_0)) {
      continue;
    }
    if(isDefined(level._id_7168)) {
      self[[level._id_7168]](var_0, var_1, var_2, var_3);
    }

    self notify("grenade_throw");
    return var_0;
  }
}

_id_7180(var_0) {
  return !isDefined(var_0._id_A6BF) || !var_0._id_A6BF;
}