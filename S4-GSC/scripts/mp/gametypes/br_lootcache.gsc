/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lootcache.gsc
*************************************************/

_id_2BE7() {
  _id_07A1::_id_CECC("body", ::_id_986A);
}

_id_31DF(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(scripts\mp\gametypes\br_public::_id_8805()) {
    if(isDefined(level._id_5E3D) && isDefined(level._id_5E3D[var_0])) {
      return 0;
    }
  }

  if(var_0 == "brloot_respawn_token" && scripts\mp\gametypes\br_pickups::_id_C6C7()) {
    return 0;
  }

  return 1;
}

_id_9899(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(var_4)) {
    if(var_1 % 2 > 0) {
      var_6 = 75;
    } else {
      var_6 = 115;
    }

    var_6 = var_6 + randomfloatrange(-10, 10);
    var_7 = 35 + var_1 / 2 * 25 + randomfloatrange(-5, 5);
    [var_9, var_10, var_11] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_1, var_2, var_3, undefined, var_6, var_7);
  } else
    [var_9, var_10, var_11] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_1, var_2, var_3);

  var_13 = level._id_2A95._id_3DAB[var_0];
  var_14 = scripts\mp\gametypes\br_pickups::_id_6A5E(var_0);

  if(isDefined(var_14)) {
    var_13 = scripts\mp\gametypes\br_weapons::_id_2A4B(var_14);
  }

  var_15 = scripts\mp\gametypes\br_pickups::_id_E336(var_0, var_9, var_10, var_13, 1, var_11);
  var_16 = level._id_2A95._id_2A65[var_0];

  if(var_5) {
    playsoundatpos(var_9, "br_legendary_loot_drop");
  }

  return var_15;
}

_id_9869(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(_id_31DF(var_4)) {
      var_5 = level._id_2A95._id_2A65[var_4];

      if(isDefined(var_5) && var_5 == 4 && var_2 == 0) {
        var_1[var_1.size] = _id_9899(var_4, self._id_8B39, self.origin, self.angles, 1, 1);
        self._id_8B39++;
        var_2 = 1;
      } else {
        var_1[var_1.size] = _id_9899(var_4, self._id_8B39, self.origin, self.angles, 1, 0);
        self._id_8B39++;
      }
    }
  }

  return var_1;
}

_id_986A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_2 == "closed" && !isDefined(var_0._id_019B)) {
    var_0 setscriptablepartstate(var_1, "opening");
    var_0._id_8B39 = 0;
    var_6 = [];
    var_7 = _func_0408(var_0);

    if(isDefined(var_7) && var_3 scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance")) {
      var_7 = _id_9880(var_7, var_3);
    }

    if(isDefined(var_7)) {
      if(getDvar("#x3f59526763711edc4", "") == "dmz") {
        if(_id_07D1::_id_60BE("placement_updates_allowed")) {
          var_8 = game["teamPlacements"][var_3.team];

          if(!isDefined(level._id_4BD3)) {
            scripts\mp\gametypes\br_gametype_dmz::_id_2EF0();
          }

          var_9 = 100 - 100 * var_8 / level._id_4BD3;

          if(isDefined(level._id_2955) && var_9 < level._id_2955) {
            var_7 = _id_987E(var_0, var_7);
          } else if(isDefined(level._id_F347) && var_9 > level._id_F347) {
            var_7 = _id_987F(var_0, var_7);
          }
        }
      }

      var_6 = var_0 _id_9869(var_7);
    } else {
      var_10 = undefined;

      if(getdvarint("#x36c2d211bbccee799", 0)) {
        var_10 = "mp/loot_set_cache_contents_base_cash.csv";
      } else if(getdvarint("#x395344732688f8bdc", 0)) {
        var_10 = "mp/loot_set_cache_contents_base_gg.csv";
      }

      var_6[var_6.size] = var_0 _id_35A1(2, 1, "weapon", var_10);
      var_6[var_6.size] = var_0 _id_35A1(0, 1, "ammo", var_10);
      var_6[var_6.size] = var_0 _id_35A1(0, 1, undefined, var_10);
      var_6[var_6.size] = var_0 _id_35A1(0, 1, undefined, var_10);
    }

    var_11 = "cache";

    switch (var_0.type) {
      case "br_loot_cache_lege":
        var_11 = "cache_legendary";
        break;
      case "br_scavenger_quest_cache":
        var_11 = "cache_scavenger";
        break;
    }

    foreach(var_13 in var_6) {
      var_13._id_9898 = var_11;
    }

    scripts\mp\gametypes\br_plunder::_id_A003("br_loot_cache", -1);
    var_3 thread _id_0A9F::_id_7003("br_cacheOpen");
    var_3 _id_07BC::_id_AA7D();

    if(!isDefined(var_3._id_9868)) {
      var_3._id_9868 = 1;
    } else {
      var_3._id_9868++;
    }

    var_3 scripts\mp\utility\stats::_id_D551(var_3._id_9868);
    level notify("lootcache_opened_kill_callout" + var_0.origin);
  }
}

_id_987E(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(issubstr(var_4, "brloot_plunder")) {
      if(var_0.type == "br_loot_cache_lege") {
        if(var_4 != "brloot_plunder_cash_legendary_1" && scripts\engine\utility::cointoss()) {
          var_4 = "brloot_plunder_cash_legendary_1";
        }
      } else if(var_4 != "brloot_plunder_cash_epic_2" && scripts\engine\utility::cointoss())
        var_4 = "brloot_plunder_cash_epic_2";
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_987F(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(issubstr(var_4, "brloot_plunder")) {
      if(var_0.type == "br_loot_cache_lege") {
        if((var_4 == "brloot_plunder_cash_epic_2" || var_4 == "brloot_plunder_cash_legendary_1") && scripts\engine\utility::cointoss()) {
          var_4 = "brloot_plunder_cash_epic_1";
        }
      } else if((var_4 == "brloot_plunder_cash_epic_2" || var_4 == "brloot_plunder_cash_epic_1") && scripts\engine\utility::cointoss())
        var_4 = "brloot_plunder_cash_rare_2";
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_35A1(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 0;

  if(!isDefined(var_2)) {
    var_2 = "";
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_6 = "mp/loot_set_cache_contents_base.csv";

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  for(var_7 = 0; var_7 < var_1; var_7++) {
    var_8 = _func_0409(var_2, var_0, 0, var_6);

    if(_id_31DF(var_8)) {
      var_9 = level._id_2A95._id_2A65[var_8];

      if(isDefined(var_9) && var_9 == 4 && var_5 == 0) {
        var_4[var_4.size] = _id_9899(var_8, self._id_8B39, self.origin, self.angles, undefined, 1);
        self._id_8B39++;
        var_5 = 1;
      } else {
        var_4[var_4.size] = _id_9899(var_8, self._id_8B39, self.origin, self.angles, undefined, 0);
        self._id_8B39++;
      }
    }
  }

  return var_4;
}

_id_9880(var_0, var_1) {
  if(!isDefined(var_1._id_2BD7)) {
    var_1._id_2BD7 = 10;
  }

  var_2 = 0;

  foreach(var_5, var_4 in var_0) {
    if(issubstr(var_4, "killstreak")) {
      var_2 = 1;
      break;
    }
  }

  if(!var_2) {
    var_6 = var_1._id_8D6F * 0;

    if(randomint(100) < var_1._id_2BD7 + var_6) {
      var_0[var_0.size] = ::scripts\engine\utility::random(level._id_2A95._id_2A6A);
      var_1._id_2BD7 = 10;
    } else
      var_1._id_2BD7 = var_1._id_2BD7 + (var_6 + 15);
  }

  return var_0;
}