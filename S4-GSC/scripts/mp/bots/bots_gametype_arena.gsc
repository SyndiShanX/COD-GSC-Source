/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_arena.gsc
***************************************************/

main() {
  level._id_27F6 = 0;
  _id_D795();
  _id_D763();
}

_id_D795() {
  if(scripts\mp\gametypes\arena::_id_897F()) {
    level._id_279D["dropped_weapon_think"] = ::_id_1A62;
    level._id_279D["dropped_weapon_cancel"] = ::_id_1A9E;
  }

  level._id_279D["gametype_think"] = ::_id_26FF;
}

_id_D763() {
  if(!scripts\mp\gametypes\arena::_id_8950()) {
    level._id_2943 = 1;
  }

  while(!isDefined(level._id_1AA6)) {
    waitframe();
  }

  if(istrue(game["isLaunchChunk"])) {
    if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
      return;
    }
  }

  var_0 = scripts\engine\utility::ter_op(level._id_A90F == 1, 3, 1);
  scripts\mp\bots\bots_gametype_dom::_id_D770(var_0, 3);
}

_id_26FF() {
  self notify("bot_arena_think");
  self endon("bot_arena_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self.pers["bot_original_personality"])) {
    self.pers["bot_original_personality"] = self._id_B023;
  }

  wait 0.1;

  if(!scripts\mp\gametypes\arena::_id_8950()) {
    if(self _meth_8030("advancedPersonality") && self _meth_8030("strategyLevel") > 0) {
      scripts\mp\bots\bots_gametype_gun::_id_27E5(self getcurrentweapon().basename, self.pers["bot_original_personality"]);
    }
  }

  for(;;) {
    if(isDefined(level._id_1AA6) && level._id_1AA6._id_1041A == "any") {
      if(!scripts\mp\bots\bots_util::_id_2801()) {
        _id_09F9::_id_272A(level._id_1AA6.trigger.origin, level._id_1AA6._id_A578, level._id_1AA6.trigger);
      }
    } else
      self[[self._id_B025]]();

    wait 0.05;
  }
}

_id_1A62() {
  self notify("bot_think_seek_dropped_weapons");
  self endon("bot_think_seek_dropped_weapons");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = "s4_throwing_knife_mp";

  for(;;) {
    var_1 = 0;

    if(_id_1A5F() || scripts\mp\bots\bots_util::_id_27C7(0.33)) {
      if(self[[level._id_279D["should_pickup_weapons"]]]() && !scripts\mp\bots\bots_util::_id_280F()) {
        var_2 = getEntArray("dropped_weapon", "targetname");
        var_3 = scripts\engine\utility::_id_6369(self.origin, var_2);

        if(var_3.size > 0) {
          var_4 = var_3[0];
          level._id_5043 = var_4;
          _id_1A61(var_4);
        }
      }
    }

    if(!scripts\mp\bots\bots_util::_id_27F7() && !scripts\mp\bots\bots_util::_id_280F() && self _meth_8030("strategyLevel") > 0) {
      var_5 = self hasweapon(var_0);
      var_6 = var_5 && self _meth_8109(var_0) == 0;

      if(var_6) {
        if(isDefined(self._id_7098)) {
          wait 5.0;
          continue;
        }

        var_7 = getEntArray("dropped_knife", "targetname");
        var_8 = scripts\engine\utility::_id_6369(self.origin, var_7);

        foreach(var_10 in var_8) {
          if(!isDefined(var_10)) {
            continue;
          }
          if(!isDefined(var_10._id_2EE3)) {
            var_11 = scripts\mp\bots\bots_util::_id_289B("BotGetClosestNavigablePoint", scripts\mp\bots\bots_util::_id_6019, var_10.origin, 32, self);

            if(isDefined(var_10)) {
              var_10._id_39E6 = var_11;
              var_10._id_2EE3 = 1;
            } else
              continue;
          }

          if(isDefined(var_10._id_39E6)) {
            self._id_7098 = 1;
            _id_1A61(var_10);
          }
        }
      } else if(var_5)
        self._id_7098 = undefined;
    }

    wait(randomfloatrange(0.25, 0.75));
  }
}

_id_1A61(var_0) {
  if(_id_09F9::_id_27ED("seek_dropped_weapon", var_0) == 0) {
    if(istrue(level._id_DFBF)) {
      var_1 = self _meth_802D("lethal");
      var_2 = self _meth_802D("tactical");

      if(isDefined(var_1) && var_1.basename == "snowball_mp") {
        var_3 = scripts\mp\equipment::_id_69A4("primary");
        var_4 = scripts\mp\equipment::_id_6A0F(var_3);

        if(var_1.basename == "snowball_mp" && var_4 > 3) {
          return;
        }
      }

      if(isDefined(var_2) && var_2.basename == "pball_mp") {
        var_3 = scripts\mp\equipment::_id_69A4("secondary");
        var_4 = scripts\mp\equipment::_id_6A0F(var_3);

        if(var_2.basename == "pball_mp") {
          return;
        }
      }
    }

    var_5 = undefined;

    if(var_0._id_0481 == "dropped_weapon") {
      var_6 = 1;
      var_7 = self getweaponslistprimaries();

      foreach(var_9 in var_7) {
        if(var_0.model == getweaponmodel(var_9)) {
          var_6 = 0;
        }
      }

      if(var_6) {
        var_5 = ::_id_1A60;
      }
    }

    var_11 = spawnStruct();
    var_11._id_A860 = var_0;
    var_11._id_CD72 = 12;
    var_11._id_DA6E = level._id_279D["dropped_weapon_cancel"];
    var_11._id_0E86 = var_5;
    var_12 = undefined;
    var_13 = var_0.origin;

    if(isDefined(var_0._id_288D)) {
      var_13 = var_0._id_288D;
    }

    _id_09F9::_id_2862("seek_dropped_weapon", var_13, 100, var_11);
  }
}

_id_1A60(var_0) {
  self _meth_804E("use", 0.5);
  thread _id_FC18();
}

_id_FC18() {
  self notify("updateBotWeaponBehavior");
  self endon("updateBotWeaponBehavior");
  wait 2;

  if(self _meth_8030("advancedPersonality") && self _meth_8030("strategyLevel") > 0) {
    scripts\mp\bots\bots_gametype_gun::_id_27E5(self getcurrentweapon().basename, self.pers["bot_original_personality"]);
  }
}

_id_1A9E(var_0) {
  if(_id_1A5E() > 0) {
    var_1 = scripts\mp\utility\weapon::getweapongroup(self getcurrentweapon());

    if(isDefined(var_0._id_A860)) {
      var_2 = var_0._id_A860.classname;

      if(scripts\engine\utility::string_starts_with(var_2, "weapon_")) {
        var_2 = _func_00D6(var_2, 7);
      }

      var_3 = scripts\mp\utility\weapon::getweapongroup(var_2);

      if(!_id_2928(var_1, var_3)) {
        return 1;
      }
    }
  }

  if(!isDefined(var_0._id_A860)) {
    return 1;
  }

  if(var_0._id_A860._id_0481 == "dropped_weapon") {
    foreach(var_5 in self.weaponlist) {
      if(var_5.basename == "s4_me_fists_mp") {
        return 0;
      }
    }

    if(_id_1A5E() > 0) {
      return 1;
    }
  } else if(var_0._id_A860._id_0481 == "dropped_knife") {
    if(scripts\mp\bots\bots_util::_id_27F7()) {
      self._id_7098 = undefined;
      return 1;
    }
  }

  return 0;
}

_id_1A5E() {
  var_0 = 0;
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammoclip(var_3);
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  if(var_1.size == 1 && var_1[0].basename == "s4_me_fists_mp") {
    var_0 = 0;
  }

  return var_0;
}

_id_1A5F() {
  var_0 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_0 = self.weaponlist;
  } else {
    var_0 = self getweaponslistprimaries();
  }

  if(var_0.size == 1 && var_0[0].basename == "s4_me_fists_mp") {
    return 1;
  }

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2) > 0) {
      return 0;
    }

    if(self getweaponammostock(var_2) > 0) {
      return 0;
    }
  }

  return 1;
}

_id_28A3(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "weapon_other":
    case "weapon_projectile":
    case "weapon_explosive":
    case "weapon_grenade":
      break;
    case "weapon_pistol":
      var_1 = 1;
      break;
    case "weapon_dmr":
    case "weapon_sniper":
      var_1 = 2;
      break;
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_shotgun":
    case "weapon_smg":
      var_1 = 3;
      break;
  }

  return var_1;
}

_id_2928(var_0, var_1) {
  var_2 = _id_28A3(var_0);
  var_3 = _id_28A3(var_1);
  return var_3 > var_2;
}