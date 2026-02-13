/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1980.gsc
*************************************************/

init() {
  if(!challengesenabled()) {
    return;
  }
  scripts\engine\utility::_id_3F1B("createGameTypeChallenegeEvent", ::creategametypechallenegeevent);
  scripts\engine\utility::_id_3F1B("createKillstreakChallengeEvent", ::createkillstreakchallengeevent);
  scripts\engine\utility::_id_3F1B("createMiscEventChallengeEvent", ::createmisceventchallengeevent);
}

challengesenabled() {
  return level.challengesallowed;
}

challengesenabledforplayer() {
  if(!challengesenabled()) {
    return 0;
  }

  if(!isPlayer(self) || isai(self)) {
    return 0;
  }

  if(istrue(level.challengesdisabled)) {
    return 0;
  }

  if(istrue(level._id_4AEC)) {
    return 0;
  }

  return 1;
}

_id_33B9() {}

_id_FF5F(var_0) {}

_id_C60B(var_0) {}

_id_E68C(var_0) {}

_id_E901(var_0) {}

_id_34E0(var_0, var_1) {}

_id_F3F8() {}

_id_AB70(var_0, var_1, var_2, var_3, var_4) {
  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  var_5 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0)) {
      var_1 = var_0;
    } else {
      return;
    }
  }

  if(!scripts\mp\utility\player::_id_886C(var_1.team, var_5)) {
    if(isDefined(var_3._id_AE61)) {
      var_3 = var_3._id_AE61;
    }

    var_6 = _id_10D85(var_3, var_1);
    _id_4006(var_1, var_6, var_5, var_4, var_3, var_2, var_0);

    if(isDefined(var_3) && scripts\mp\utility\weapon::_id_88F6(var_3)) {
      level thread createkillstreakchallengeevent(var_1, var_0, var_5, var_3, "killed_with_killstreak");
    }
  }
}

_id_10316(var_0, var_1, var_2, var_3) {}

_id_555B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

_id_8DD8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

_id_AAA4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer()) {
    return;
  }
}

_id_AB6E(var_0) {
  var_1 = self;

  if(!var_1 challengesenabledforplayer()) {
    return;
  }
  if(!scripts\mp\utility\player::_id_886C(var_1.team, var_0)) {
    var_2 = "";

    if(isDefined(var_1.primaryweaponobj)) {
      var_2 = scripts\mp\utility\weapon::_id_69D8(var_1.primaryweaponobj.basename);
    }

    var_3 = "";

    if(isDefined(var_1.secondaryweaponobj)) {
      var_3 = scripts\mp\utility\weapon::_id_69D8(var_1.secondaryweaponobj.basename);
    }

    var_4 = [var_2, var_3];
    var_5 = [0, 0];
    var_6 = var_1 _id_6BD5();
    var_1 reportchallengeuserevent_iw8("assist", var_5, var_4, var_6);
  }
}

_id_AB16(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_7 = var_0;
  var_8 = var_1;
  var_9 = var_2;
  var_10 = var_3;
  var_11 = var_4;
  var_12 = var_5;
  var_13 = var_6;
  var_14 = _id_6BD5();
  self reportchallengeuserevent_iw8("killstreak_end", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
}

_id_AAE7(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_2 = var_0;
  var_3 = var_1;
  var_4 = _id_6BD5();
  self reportchallengeuserevent_iw8("field_end", var_2, var_3, var_4);
}

_id_AA81(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = scripts\mp\utility\game::getgametype();

  if(!isDefined(var_3)) {
    var_3 = getDvar("#x315af23e89f368200");
  }

  var_4 = scripts\cp_mp\utility\game_utility::_id_6956(var_3);
  var_5 = _id_6BD5();
  self reportchallengeuserevent_iw8("capture", var_4, var_1, var_2, var_5);
}

_id_AAAC(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = scripts\mp\utility\game::getgametype();

  if(!isDefined(var_3)) {
    var_3 = getDvar("#x315af23e89f368200");
  }

  var_4 = scripts\cp_mp\utility\game_utility::_id_6956(var_3);
  var_5 = _id_6BD5();
  self reportchallengeuserevent_iw8("defuse", var_4, var_1, var_2, var_5);
}

_id_AB57(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = scripts\mp\utility\game::getgametype();

  if(!isDefined(var_3)) {
    var_3 = getDvar("#x315af23e89f368200");
  }

  var_4 = scripts\cp_mp\utility\game_utility::_id_6956(var_3);
  var_5 = _id_6BD5();
  self reportchallengeuserevent_iw8("defuse", var_4, var_1, var_2, var_5);
}

_id_ABB0(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("stun", var_0);
}

_id_ABAE(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("stim", var_0);
}

_id_AAFB(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = "";
  var_2 = 1;

  if(isDefined(self._id_3808) && isDefined(self._id_3808._id_967F)) {
    foreach(var_4 in self._id_3808._id_967F) {
      if(!var_2) {
        var_1 = var_1 + "|";
      }

      var_1 = var_1 + var_4;
      var_2 = 0;
    }
  }

  self reportchallengeuserevent_iw8("hack", var_0, var_1);
}

_id_6DF5(var_0, var_1) {
  var_2 = "";

  if(!isDefined(level._id_96CD)) {
    return var_2;
  }

  var_3 = 0;

  foreach(var_5 in level._id_96CD) {
    if(var_0 istouching(var_5) || isDefined(var_1) && var_1 istouching(var_5)) {
      if(isDefined(var_5._id_96CC)) {
        if(var_3) {
          var_2 = var_2 + "|";
        }

        var_2 = var_2 + var_5._id_96CC;
        var_3 = 1;
      }
    }
  }

  return var_2;
}

_id_6DF6(var_0) {
  if(!isDefined(level._id_96CD)) {
    return -1;
  }

  foreach(var_2 in level._id_96CD) {
    if(var_0 istouching(var_2)) {
      var_3 = isDefined(var_2._id_E44A) && var_2._id_E44A > -1;
      var_4 = isDefined(var_0._id_E449) && var_0._id_E449 & 1 << var_2._id_E44A;

      if(var_3 && !var_4) {
        if(!isDefined(var_0._id_E449)) {
          var_0._id_E449 = 0;
        }

        var_0._id_E449 = var_0._id_E449 | 1 << var_2._id_E44A;
        return var_2._id_E44A;
      }
    }
  }

  return -1;
}

_id_AA8F(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("contract_start", _id_6DF5(self, undefined), _id_6DF5(var_1, undefined), _id_6BD5(), var_0);
}

_id_AA8E(var_0, var_1, var_2) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("contract_end", var_0, var_1, isalive(self), var_2, _id_6BD5());
}

_id_AA7D() {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("pickup", 0, 0, 1, _id_6BD5());
}

_id_AB1C(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("buy_item", var_0, var_1, _id_6BD5());
}

_id_AB51(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  if(var_0 == "weapon") {
    var_1 = 1;
  } else if(var_0 == "plunder") {
    var_2 = 1;
  }

  self reportchallengeuserevent_iw8("pickup", var_1, var_2, 0, _id_6BD5());
}

_id_AA88(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("collect_item", var_0, _id_6BD5());
}

_id_ABD1(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("use_item", var_0, _id_6BD5());
}

_id_AB27(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("loadout", var_0, _id_6BD5());
}

_id_AB53(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("ping", var_0, _id_6BD5());
}

_id_AB1F(var_0, var_1) {
  if(var_0 == var_1) {
    if(var_0 challengesenabledforplayer()) {
      var_0 reportchallengeuserevent_iw8("revive", 1, 1, var_0 _id_6BD5());
    }
  } else {
    if(var_0 challengesenabledforplayer()) {
      var_0 reportchallengeuserevent_iw8("revive", 1, 0, var_0 _id_6BD5());
    }

    if(var_1 challengesenabledforplayer()) {
      var_1 reportchallengeuserevent_iw8("revive", 0, 1, var_0 _id_6BD5());
    }
  }
}

_id_AAFA(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  self reportchallengeuserevent_iw8("gulag_end_match", var_0, _id_6BD5());
}

_id_AB38(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(var_0 <= 0 || var_1 <= 0 || var_0 > var_1) {
    return;
  }
  var_2 = int(100.0 - var_0 / var_1 * 100.0);
  self reportchallengeuserevent_iw8("match_placement", var_2, var_0, _id_6BD5());
  _func_0435();
}

_id_ABAB() {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_0 = _id_6DF6(self);

  if(var_0 != -1) {
    self reportchallengeuserevent_iw8("spray", var_0, _id_6BD5());
  }
}

_id_10D85(var_0, var_1) {
  var_2 = undefined;

  switch (var_0.basename) {
    case "bradley_tow_proj_ks_mp":
    case "lighttank_tur_mp":
    case "lighttank_tur_ks_mp":
    case "tur_gun_lighttank_ks_mp":
    case "s4_tur_mg_gun_tank_mp":
    case "tur_gun_lighttank_mp":
    case "s4_tank_tur_mp":
    case "bradley_tow_proj_mp":
      var_2 = "iav_weapon_mp";
      break;
    case "little_bird_mp":
      var_2 = "little_bird_mp";
      break;
    case "tur_apc_rus_mp":
      var_2 = "tur_apc_rus_mp";
      break;
    default:
      var_2 = undefined;
      break;
  }

  if(!isDefined(var_2)) {
    var_2 = scripts\mp\equipment::_id_6A14(var_0);

    if(!isDefined(var_2)) {
      var_2 = scripts\mp\utility\weapon::_id_69D8(var_0.basename);
    }
  }

  var_3 = "";

  if(isDefined(var_1.secondaryweaponobj)) {
    if(var_0 == var_1.primaryweaponobj) {
      var_3 = scripts\mp\utility\weapon::_id_69D8(var_1.secondaryweaponobj.basename);
    } else if(var_0 == var_1.secondaryweaponobj) {
      var_3 = scripts\mp\utility\weapon::_id_69D8(var_1.primaryweaponobj.basename);
    }
  }

  var_4 = [var_2, var_3];
  return var_4;
}

setaebit(var_0, var_1) {
  var_2 = 0;

  if(var_1 > 30 || _func_0121(var_0)) {
    var_2 = _func_0436(var_0 + "", var_1);
  } else {
    var_2 = var_0 + (1 << var_1);
  }

  return var_2;
}

comparepersvalue(var_0, var_1, var_2) {
  waitframe();
  var_3 = var_0.pers[var_1];
  var_4 = scripts\engine\utility::ter_op(var_3 == var_2, 1, 0);
  return var_4;
}

createftuechallengeevent() {
  self reportchallengeuserevent("144115188075856028", [252, "MP"]);
}

createmisceventchallengeevent(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_2 = 0;
  var_3 = 0;
  var_4 = getloadoutperkids(self);

  switch (var_0) {
    case "superSprintDistance":
      if(isDefined(var_1)) {
        var_2 = var_1;
      }

      break;
    case "weaponPickup":
      var_3 = setaebit(var_3, 0);
      break;
    case "ammoScavenge":
      var_3 = setaebit(var_3, 1);
      break;
    case "gestureUsed":
      var_3 = setaebit(var_3, 3);
      break;
    case "sprayUsed":
      var_3 = setaebit(var_3, 2);
      break;
    default:
      break;
  }

  self reportchallengeuserevent("144115188075856050", [2, var_3, 1, var_2, 252, "MP", 17, var_4[0], 18, var_4[1], 19, var_4[2]]);
}

createchampionhillchallengeevent(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = getaegametype();
  var_2 = getoperatorlootid();
  var_3 = 0;

  if(scripts\mp\utility\game::getgametype() == "arena_evo" && var_0 <= 3) {
    var_3 = setaebit(var_3, 16);
  }

  self reportchallengeuserevent("144115188075855880", [2, var_3, 252, "MP", 251, var_1, 1, var_2]);
}

creategametypechallenegeevent(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_1 = getaegametype();
  var_2 = 0;
  var_3 = 0;

  switch (var_0) {
    case "destroyWall":
      var_3 = setaebit(var_3, 5);
      incplayerpers("destroyWall", 1);

      if(self.pers["destroyWall"] == 3) {
        var_3 = setaebit(var_3, 8);
      }

      break;
    case "conf_confirm":
      var_3 = setaebit(var_3, 3);
      var_2 = 1;
      break;
    case "dom_cap":
      var_3 = setaebit(var_3, 0);
      var_2 = 1;
      break;
    case "base_cap":
      var_2 = 1;
      break;
    case "bomb_success":
      var_3 = setaebit(var_3, 1);
      var_2 = 1;
      break;
    case "zone_cap":
      var_2 = 1;
      break;
    case "bomb_defused":
      var_3 = setaebit(var_3, 2);
      var_2 = 1;
      break;
    case "elim_krampus":
      var_3 = setaebit(var_3, 6);
      break;
    case "kill_elf":
      var_3 = setaebit(var_3, 7);
      break;
    case "destruction_armsRace":
      var_3 = setaebit(var_3, 9);
      break;
    case "conf_denied":
      var_3 = setaebit(var_3, 12);
      break;
    case "control_capture":
      var_3 = setaebit(var_3, 13);
      break;
    case "gungame_weaponadvance":
      var_3 = setaebit(var_3, 14);
      break;
    default:
      break;
  }

  if(var_0 == "disabled_vehicle" && level.mapname == "mp_ar_alps") {
    var_3 = setaebit(var_3, 15);
  }

  if(var_0 == "disabled_vehicle") {
    var_3 = setaebit(var_3, 16);
  }

  if(isDefined(self.lifecycle_modifiers) && isDefined(self.lifecycle_modifiers["tac_insert_spawn"]) && self.lifecycle_modifiers["tac_insert_spawn"] && var_2) {
    var_3 = setaebit(var_3, 11);
    self.lifecycle_modifiers["tac_insert_spawn"] = 0;
  }

  if(var_0 == "koth_1min" && scripts\mp\utility\game::getgametype() == "koth") {
    var_3 = setaebit(var_3, 4);
  }

  if(var_0 == "patrol_1min" && scripts\mp\utility\game::getgametype() == "patrol") {
    var_3 = setaebit(var_3, 10);
  }

  self reportchallengeuserevent("144115188075855894", [252, "MP", 251, var_1, 1, var_3]);
}

createeliminationchallengeevent(var_0, var_1, var_2, var_3) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_4 = getaegametype();
  var_5 = _id_5AF4(var_0);
  var_6 = getweaponattachmentids(var_3);
  var_7 = var_0 getweaponlootid(var_3);
  var_8 = var_0 getoperatorlootid();
  var_9 = getweaponclassenum(var_3);
  var_10 = scripts\engine\utility::_id_1BAB(var_6, "");
  var_11 = 0;

  if(var_1._id_041A == 1) {
    var_11 = setaebit(var_11, 4);
  }

  if(isDefined(var_0._id_9FFB) && isDefined(var_0._id_9FFB["victim_stunned"]) && var_0._id_9FFB["victim_stunned"]) {
    var_11 = setaebit(var_11, 5);
  }

  if(isDefined(var_0._id_9FFB) && isDefined(var_0._id_9FFB["weapon_pickup_kill"]) && var_0._id_9FFB["weapon_pickup_kill"]) {
    var_11 = setaebit(var_11, 3);
  }

  if(!isDefined(var_10)) {
    var_11 = setaebit(var_11, 2);
  }

  if(isobjectivemode()) {
    var_11 = setaebit(var_11, 0);
  }

  if(isDefined(level._id_74C4) && istrue(level._id_74C4)) {
    var_11 = setaebit(var_11, 1);
  }

  if(isDefined(var_0._id_9FFB) && isDefined(var_0._id_9FFB["weapon_change_kill"]) && var_0._id_9FFB["weapon_change_kill"]) {
    var_11 = setaebit(var_11, 6);
  }

  var_0 reportchallengeuserevent("144115188075856010", [252, "MP", 1, var_7, 12, var_8, 251, var_4, 16, var_9, 14, var_11]);
}

createkillstreakchallengeevent(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_6 = getaegametype();

  if(isint(var_3) && var_3 == 0) {
    var_3 = var_0 getcurrentweapon();
  }

  var_7 = var_0 getweaponlootid(var_3);
  var_8 = var_0 getoperatorlootid();
  var_9 = getweaponclassenum(var_3);
  var_10 = 0;

  if(isDefined(var_4)) {
    if(issubstr(var_4, "killed_with_killstreak")) {
      var_10 = setaebit(var_10, 3);
      var_0 incplayerpers("killed_with_killstreak", 1);

      if(var_0.pers["killed_with_killstreak"] == 5) {
        var_10 = setaebit(var_10, 9);
      }

      if(isDefined(var_0._id_88DF) && var_0._id_88DF) {
        var_10 = setaebit(var_10, 8);
      }

      if(isDefined(var_2._id_88DF) && var_2._id_88DF && scripts\mp\utility\weapon::_id_88F6(var_3)) {
        var_10 = setaebit(var_10, 12);
      }

      if(isDefined(var_1.streakinfo.streakname) && var_1.streakinfo.streakname == "white_phosphorus") {
        var_10 = setaebit(var_10, 14);
      }
    } else if(var_4 == "killstreak_destroyed") {
      var_10 = setaebit(var_10, 1);

      if(isDefined(var_2._id_873F) && istrue(var_2._id_873F)) {
        var_10 = setaebit(var_10, 4);

        if(isDefined(var_2.streakname) && var_2.streakname == "uav") {
          var_10 = setaebit(var_10, 13);
        }
      }

      if(var_5 == "attack_dog" || var_5 == "guard_dog") {
        var_10 = setaebit(var_10, 6);
      } else {
        var_11 = game["killstreakTable"]._id_EC74[var_5];
        var_12 = scripts\engine\utility::ter_op(isDefined(var_11), var_11["type"], "");

        if(isDefined(var_12) && var_12 == "LETHAL") {
          var_10 = setaebit(var_10, 6);
        }
      }

      if(isDefined(var_3) && scripts\mp\utility\weapon::_id_88F6(var_3)) {
        var_10 = setaebit(var_10, 12);
      }

      if(isDefined(var_0.pers["destroyedKillstreaks"]) && var_0.pers["destroyedKillstreaks"] == 3) {
        var_10 = setaebit(var_10, 5);
      }

      if(var_9 == 3) {
        var_0 incplayerpers("lmgDestroyKillstreaks", 1);

        if(var_0.pers["lmgDestroyKillstreaks"] == 3) {
          var_10 = setaebit(var_10, 10);
        }
      }
    } else if(var_4 == "open_carepackage")
      var_10 = setaebit(var_10, 7);
  }

  if(isDefined(var_4) && isDefined(var_5) && var_4 == "killstreak_calledIn") {
    switch (var_5) {
      case "guard_dog":
        var_10 = setaebit(var_10, 11);
        break;
      case "attack_dogs":
        var_10 = setaebit(var_10, 15);
        break;
    }
  }

  var_0 reportchallengeuserevent("144115188075855891", [252, "MP", 12, var_8, 1, var_7, 251, var_6, 16, var_9, 3, var_10]);
}

createplayeronkillstreakchallengeevent(var_0, var_1, var_2, var_3, var_4) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_5 = getaegametype();
  var_6 = var_0 getweaponlootid(var_3);
  var_7 = var_0 getoperatorlootid();

  if(var_4 == 1) {
    var_0.killstreak_modifiers = [];
    var_0.killstreak_modifiers["two1s1k"] = 0;

    if(isDefined(var_0._id_9FFB["oneshotkill"])) {
      var_0.killstreak_modifiers["two1s1k"] = 1;
    }

    return;
  }

  var_8 = 0;

  if(isDefined(var_0._id_9FFB["oneshotkill"])) {
    var_0.killstreak_modifiers["two1s1k"]++;
  }

  if(scripts\engine\utility::is_equal(var_0.killstreak_modifiers["two1s1k"], 2)) {
    var_8 = setaebit(var_8, 0);
  }

  var_0 reportchallengeuserevent("144115188075855891", [252, "MP", 12, var_7, 1, var_6, 251, var_5, 2, var_4, 3, var_8]);
}

createequipmentchallengeevent(var_0, var_1, var_2) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_3 = getloadoutperkids(var_0);
  var_4 = 0;

  if(isDefined(var_1)) {
    var_4 = var_0 getweaponlootid(var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = "";
  }

  var_5 = 0;

  if(var_2 == "destroy_equipment") {
    var_5 = setaebit(var_5, 0);
  }

  if(var_2 == "throphy_protection_successful") {
    var_5 = setaebit(var_5, 1);
  }

  var_0 reportchallengeuserevent("144115188075856012", [21, var_5, 1, var_4, 252, "MP", 17, var_3[0], 18, var_3[1], 19, var_3[2]]);
}

createfieldupgradechallengeevent(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_2 = 0;
  var_3 = getloadoutperkids(self);

  if(isDefined(var_0) && var_0 == "destroy") {
    var_2 = setaebit(var_2, 1);
  }

  if(isDefined(var_0) && var_0 == "activate") {
    var_2 = setaebit(var_2, 0);
    incplayerpers("deployFU", 1);

    if(self.pers["deployFU"] == 5) {
      var_2 = setaebit(var_2, 2);
    }
  }

  if(isDefined(var_0) && var_0 == "use_resupplyBox") {
    var_2 = setaebit(var_2, 3);
  }

  var_4 = 0;

  if(isDefined(var_1)) {
    var_4 = getweaponlootid(var_1);
  }

  self reportchallengeuserevent("144115188075856012", [20, var_2, 1, var_4, 252, "MP", 17, var_3[0], 18, var_3[1], 19, var_3[2]]);
}

createendgamechallengeevent(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, "tie");
  var_1 = 0;
  var_2 = self.pers["team"];

  if(isPlayer(var_0)) {
    if(isDefined(level._id_902C)) {
      var_1 = 1;
    } else {
      for(var_3 = 0; var_3 < min(level._id_B16C["all"].size, 3); var_3++) {
        if(level._id_B16C["all"][var_3] == self) {
          var_1 = 1;
          break;
        }
      }
    }
  } else if(_func_0121(var_0)) {
    if(var_2 == var_0) {
      var_1 = 1;
    }
  }

  var_4 = getaegametype();
  var_5 = getoperatorlootid();
  var_6 = 0;
  var_7 = self.pers["assists"] + self.pers["kills"];
  var_8 = var_7 / max(self.pers["deaths"], 1);

  if(var_7 >= 30) {
    var_6 = setaebit(var_6, 6);
  }

  if(var_7 >= 20) {
    var_6 = setaebit(var_6, 35);
  }

  if(var_7 >= 15 && var_8 >= 2.0) {
    var_6 = setaebit(var_6, 10);
  }

  if(var_8 >= 1.0) {
    var_6 = setaebit(var_6, 26);
  }

  if(isDefined(self.pers["streakTypesUsed"]) && self.pers["streakTypesUsed"].size >= 3) {
    var_6 = setaebit(var_6, 7);
  }

  if(isDefined(level._id_0E59["mostEliminations"]._id_10E5A[0]) && scripts\engine\utility::array_contains(level._id_0E59["mostEliminations"]._id_10E5A, self) && level.teambased) {
    var_6 = setaebit(var_6, 3);
  }

  if(isDefined(level._id_0E59["highestEDRatio"]._id_10E5A[0]) && scripts\engine\utility::array_contains(level._id_0E59["highestEDRatio"]._id_10E5A, self) && level.teambased) {
    var_6 = setaebit(var_6, 4);
  }

  if(isDefined(level.potgwinner) && level.potgwinner == self) {
    var_6 = setaebit(var_6, 0);
  }

  if(isDefined(level.kdr_info) && level.kdr_info[var_2][0]._id_B760 == self) {
    var_6 = setaebit(var_6, 5);
  }

  if(isDefined(level.kdr_info) && (isDefined(level.kdr_info[var_2][1]) && level.kdr_info[var_2][1]._id_B760 == self || level.kdr_info[var_2][0]._id_B760 == self)) {
    var_6 = setaebit(var_6, 8);
  }

  if(isDefined(self.pers["ads_smg_kills"]) && self.pers["ads_smg_kills"] >= 10) {
    self.endgame_modifiers["10_ads_smg_kills"] = 1;
  }

  var_9 = 0;

  if(isDefined(self.pers["killsPerWeapon"]) && self.pers["killsPerWeapon"].size > 0) {
    foreach(var_11 in self.pers["killsPerWeapon"]) {
      if(!issubstr(var_11.basename, "s4_pi")) {
        var_9 = 1;
      }
    }
  }

  if(!var_9 && var_7 > 0) {
    var_6 = setaebit(var_6, 27);
  }

  if(isDefined(self.endgame_modifiers)) {
    foreach(var_15, var_14 in self.endgame_modifiers) {
      switch (var_15) {
        case "vote":
          var_6 = setaebit(var_6, 1);
          break;
        case "voted_mvp":
          var_6 = setaebit(var_6, 2);
          break;
        case "5_melee_weapon_kills":
          var_6 = setaebit(var_6, 14);
          break;
        case "10_ads_smg_kills":
          var_6 = setaebit(var_6, 15);
          break;
        case "5_headshot_ar_kills":
          var_6 = setaebit(var_6, 17);
          break;
        case "10_hipfirekill":
          var_6 = setaebit(var_6, 23);
          break;
        case "10_sn_1shot_kills":
          var_6 = setaebit(var_6, 18);
          break;
        case "5_firekills":
          var_6 = setaebit(var_6, 19);
          break;
        case "3_throwingKnifeKills":
          var_6 = setaebit(var_6, 22);
          break;
        case "5_stunnedkills":
          var_6 = setaebit(var_6, 24);
          break;
        case "3_slidekills":
          var_6 = setaebit(var_6, 28);
          break;
        case "5_nosebreaker_kills":
          var_6 = setaebit(var_6, 31);
          break;
        case "5_closerangekill":
          var_6 = setaebit(var_6, 32);
          break;
        case "3_bulletpen_kills_lmg":
          var_6 = setaebit(var_6, 34);
          break;
        case "10_closerangekill":
          var_6 = setaebit(var_6, 21);
          break;
        case "10_movingkill":
          var_6 = setaebit(var_6, 20);
          break;
        case "3_headshot_cleankills":
          var_6 = setaebit(var_6, 37);
          break;
        case "5_ads_acog":
          var_6 = setaebit(var_6, 38);
          break;
        case "5_closerange_lmg":
          var_6 = setaebit(var_6, 39);
          break;
        case "5_moving_hipfire_kill":
          var_6 = setaebit(var_6, 40);
          break;
      }
    }
  }

  if(isDefined(self.pers["oneshotkills"]) && self.pers["oneshotkills"] >= 10) {
    var_6 = setaebit(var_6, 29);
  }

  if(scripts\mp\utility\game::getgametype() == "conf" && isDefined(self.pers["confirmed"]) && self.pers["confirmed"] >= 10) {
    var_6 = setaebit(var_6, 12);
  }

  if(scripts\mp\utility\game::getgametype() == "arena_evo" && var_7 >= 15) {
    var_6 = setaebit(var_6, 11);
  }

  if(level.mapname == "mp_shipmas_s4" || level.mapname == "mp_shipment_s4") {
    var_6 = setaebit(var_6, 13);
  }

  if(_func_0478(self)) {
    var_6 = setaebit(var_6, 9);
  }

  if(!isDefined(self.pers["lethalDeaths"])) {
    var_6 = setaebit(var_6, 25);
  }

  if(isDefined(self.pers["hipfire_multikill"]) && self.pers["hipfire_multikill"] >= 3) {
    var_6 = setaebit(var_6, 33);
  }

  var_16 = 30000;

  if(level.mapname == "mp_shipment_s4") {
    if(isDefined(self.pers["longestTimeAlive"]) && isDefined(self.pers["longestTimeAlive"] >= var_16) || self.pers["deaths"] == 0 && gettime() > var_16) {
      var_6 = setaebit(var_6, 30);
    }
  }

  var_17 = scripts\mp\rank::_id_6C89();
  var_18 = getdvarint("#x31f918455340def2f", 0);

  if(var_18 >= 5 && var_17 >= 1) {
    if(var_1 == 1) {
      var_19 = getoperatorbit(var_5);
      var_20 = self getplayerdata(level.progressiongroup, "playerStats", "operatorsWon");

      if(!isDefined(var_20)) {
        var_20 = 0;
      }

      if(!isbitset(var_20, var_19)) {
        var_6 = setaebit(var_6, 36);
        var_21 = setoperatorbit(var_20, var_19);
        self setplayerdata(level.progressiongroup, "playerStats", "operatorsWon", var_21);
      }
    }
  }

  self reportchallengeuserevent("144115188075855880", [2, var_6, 252, "MP", 251, var_4, 1, var_5, 3, var_1]);
}

_id_4006(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_7 = var_0 _id_6BD5();
  var_8 = getaegametype();
  var_9 = getloadoutperkids(var_0);
  var_10 = getweaponattachmentids(var_4);
  var_11 = var_0 getweaponlootid(var_4);
  var_12 = scripts\mp\utility\weapon::_id_6A18(var_4.basename);

  if(isDefined(var_6) && istrue(var_6._id_8835) && scripts\mp\equipment::_id_8836(var_6._id_5562)) {
    var_11 = _func_0222("loot/equipment_ids.csv", 1, var_6._id_5562, 0);
  }

  var_13 = var_0 getoperatorlootid();
  var_14 = 0;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;
  var_19 = 0;
  var_20 = 0;
  var_21 = 0;
  var_22 = 0;
  var_23 = 0;
  var_24 = 0;
  var_25 = 0;
  var_26 = 0;
  var_27 = 0;
  var_28 = 0;

  foreach(var_41, var_30 in var_3) {
    switch (var_41) {
      case "headshot":
        var_14 = setaebit(var_14, 0);

        if(comparepersvalue(var_0, "headshots", 7)) {
          var_14 = setaebit(var_14, 19);
        }

        var_18 = 1;
        break;
      case "prone_kill":
        var_14 = setaebit(var_14, 8);
        break;
      case "crouch_kill":
        var_14 = setaebit(var_14, 7);
        break;
      case "mounted":
        var_14 = setaebit(var_14, 6);
        break;
      case "ads":
        var_31 = 0;
        var_32 = undefined;
        var_33 = undefined;
        var_34 = undefined;
        var_17 = 1;
        var_35 = scripts\mp\utility\weapon::_id_69D8(var_4.basename);
        var_36 = _func_0222("mp/statstable.csv", 5, var_35, 4);

        foreach(var_38 in var_10) {
          var_39 = _func_0222("loot/" + var_36 + "_attachment_ids.csv", 0, var_38, 1);
          var_32 = _func_0222("mp/attachmenttable.csv", 5, var_39, 2);

          if(var_32 == "optic") {
            var_33 = var_39;
            var_31 = 1;
            break;
          }
        }

        if(var_31) {
          var_34 = _func_0222("mp/reticlecategorytable.csv", 1, var_33, 2);
        }

        if(isDefined(var_34) && var_31) {
          switch (var_34) {
            case "reflex":
              var_16 = 1;
              break;
            case "lens":
              var_16 = 5;
              break;
            case "holo":
              var_16 = 2;
              break;
            case "acog":
              var_16 = 3;
              break;
            case "hybrid":
              var_16 = 6;
              break;
            case "scope":
              var_16 = 4;
              break;
          }
        }

        var_14 = setaebit(var_14, 2);
        break;
      case "hipfire":
        var_14 = setaebit(var_14, 3);
        var_23 = 1;
        break;
      case "longshot":
        var_14 = setaebit(var_14, 4);
        break;
      case "bulletpen":
        var_14 = setaebit(var_14, 5);
        var_27 = 1;
        break;
      case "weapon_change_kill":
        var_14 = setaebit(var_14, 14);
        break;
      case "secondary_weapon":
        var_14 = setaebit(var_14, 27);
        break;
      case "victimInsmoke":
        var_14 = setaebit(var_14, 22);
        break;
      case "victim_stunned":
        var_14 = setaebit(var_14, 21);
        var_15 = setaebit(var_15, 5);
        var_24 = 1;
        break;
      case "weapon_pickup_kill":
        var_15 = setaebit(var_15, 3);
        break;
      case "oneshotkill":
        var_14 = setaebit(var_14, 20);

        if(!isDefined(var_0.pers["oneshotkills"])) {
          var_0.pers["oneshotkills"] = 1;
        } else {
          var_0.pers["oneshotkills"]++;
        }

        if(var_0.pers["oneshotkills"] == 6) {
          var_14 = setaebit(var_14, 18);
        }

        var_19 = 1;
        break;
      case "quickscope":
        var_14 = setaebit(var_14, 13);
        break;
      case "low_health_kill":
        var_14 = setaebit(var_14, 26);
        break;
      case "item_impact":
        var_14 = setaebit(var_14, 28);
        break;
      case "attacker_moving":
        var_14 = setaebit(var_14, 10);
        var_21 = 1;
        break;
      case "enemyHasUAV":
        var_14 = setaebit(var_14, 25);
        break;
      case "backfire":
        var_14 = setaebit(var_14, 15);
        break;
      case "holdbreath":
        var_14 = setaebit(var_14, 30);
        break;
      case "blindfire":
        var_14 = setaebit(var_14, 1);
        break;
      case "recentstim":
        var_14 = setaebit(var_14, 23);
        break;
      case "execution":
        var_14 = setaebit(var_14, 17);
        break;
      case "backstab":
        var_14 = setaebit(var_14, 31);
        break;
      case "slidekill":
        var_14 = setaebit(var_14, 32);
        var_25 = 1;
        break;
      case "closeRange":
      case "pointblank":
        var_14 = setaebit(var_14, 9);
        var_22 = 1;
        break;
      case "reload_kill":
        var_14 = setaebit(var_14, 24);
        break;
      case "ballTurretGunner_kill":
        var_14 = setaebit(var_14, 45);
        break;
      case "akimbo_kill":
        var_14 = setaebit(var_14, 47);
        break;
      case "decoy_active":
        var_14 = setaebit(var_14, 46);
        break;
      case "sprinting":
        var_14 = setaebit(var_14, 48);
        break;
      case "favorite_weapon_kill":
        var_14 = setaebit(var_14, 50);
        break;
      case "offensive_kill":
        var_14 = setaebit(var_14, 51);
        break;
      case "defensive_kill":
        var_14 = setaebit(var_14, 52);
        break;
      case "gunbutt":
        var_14 = setaebit(var_14, 54);
        var_26 = 1;
        break;
      case "defender":
        var_14 = setaebit(var_14, 52);
        break;
      case "assault":
        var_14 = setaebit(var_14, 51);
        break;
      case "savior":
        var_14 = setaebit(var_14, 60);
        break;
      case "popcorn":
        var_14 = setaebit(var_14, 61);
        break;
      default:
        break;
    }
  }

  if(isDefined(var_4) && isweaponattachmentnameequipped(var_4, "gunperk_gungho")) {
    var_14 = setaebit(var_14, 49);
  }

  if(isusingoperatorfavoriteweapon(var_4, var_7)) {
    var_14 = setaebit(var_14, 50);
  }

  var_42 = 0;

  if(isDefined(var_2._id_42F6) && var_2._id_42F6.size != 0) {
    foreach(var_41, var_30 in var_2._id_42F6) {
      if(var_41 == var_0.guid) {
        var_42 = 1;
        break;
      }
    }
  }

  if(!var_42 && (isPlayer(var_2) || isbot(var_2))) {
    var_14 = setaebit(var_14, 11);
    var_28 = 1;
  }

  if(isDefined(var_2._id_041A) && var_2._id_041A == 1) {
    var_14 = setaebit(var_14, 12);
  }

  switch (var_5) {
    case "MOD_MELEE":
      if(issubstr(var_4.basename, "dog_bite")) {
        break;
      }

      var_14 = setaebit(var_14, 16);
      break;
    case "MOD_BURNED":
      var_14 = setaebit(var_14, 29);
      var_20 = 1;
      break;
    case "MOD_BURNED_OVER_TIME":
      var_14 = setaebit(var_14, 29);
      var_20 = 1;
      break;
    case "MOD_FIRE":
      var_14 = setaebit(var_14, 29);
      var_20 = 1;
      break;
    default:
      break;
  }

  var_44 = getweaponclassenum(var_4);

  if(var_44 == 8) {
    if(var_0.pers["meleeKills"] == 5) {
      var_0.endgame_modifiers["5_melee_weapon_kills"] = 1;
    }
  } else if(var_44 == 2 && var_17) {
    if(!isDefined(var_0.pers["ads_smg_kills"])) {
      var_0.pers["ads_smg_kills"] = 1;
    } else {
      var_0.pers["ads_smg_kills"]++;
    }
  } else if(var_44 == 1 && var_18 == 1) {
    if(!isDefined(var_0.pers["headshot_ar_kills"])) {
      var_0.pers["headshot_ar_kills"] = 1;
    } else {
      var_0.pers["headshot_ar_kills"]++;
    }

    if(var_0.pers["headshot_ar_kills"] == 5) {
      var_0.endgame_modifiers["5_headshot_ar_kills"] = 1;
    }
  } else if(var_44 == 4 && var_19 == 1) {
    if(!isDefined(var_0.pers["sn_1shot_kills"])) {
      var_0.pers["sn_1shot_kills"] = 1;
    } else {
      var_0.pers["sn_1shot_kills"]++;
    }

    if(var_0.pers["sn_1shot_kills"] == 10) {
      var_0.endgame_modifiers["10_sn_1shot_kills"] = 1;
    }
  }

  if(var_20 == 1) {
    if(!isDefined(var_0.pers["firekill"])) {
      var_0.pers["firekill"] = 1;
    } else {
      var_0.pers["firekill"]++;
    }

    if(var_0.pers["firekill"] == 5) {
      var_0.endgame_modifiers["5_firekills"] = 1;
    }
  }

  if(var_21 == 1) {
    if(!isDefined(var_0.pers["movingkill"])) {
      var_0.pers["movingkill"] = 1;
    } else {
      var_0.pers["movingkill"]++;
    }

    if(var_0.pers["movingkill"] == 10) {
      var_0.endgame_modifiers["10_movingkill"] = 1;
    }
  }

  if(var_23 == 1) {
    if(!isDefined(var_0.pers["hipfirekill"])) {
      var_0.pers["hipfirekill"] = 1;
    } else {
      var_0.pers["hipfirekill"]++;
    }

    if(var_0.pers["hipfirekill"] == 10) {
      var_0.endgame_modifiers["10_hipfirekill"] = 1;
    }
  }

  if(var_22 == 1) {
    if(!isDefined(var_0.pers["closerangekill"])) {
      var_0.pers["closerangekill"] = 1;
    } else {
      var_0.pers["closerangekill"]++;
    }

    if(var_0.pers["closerangekill"] == 5) {
      var_0.endgame_modifiers["5_closerangekill"] = 1;
    }

    if(var_0.pers["closerangekill"] == 10) {
      var_0.endgame_modifiers["10_closerangekill"] = 1;
    }
  }

  if(isDefined(var_4.basename) && var_4.basename == "s4_throwing_knife_mp") {
    if(!isDefined(var_0.pers["throwingKnifeKills"])) {
      var_0.pers["throwingKnifeKills"] = 1;
    } else {
      var_0.pers["throwingKnifeKills"]++;
    }

    if(var_0.pers["throwingKnifeKills"] == 3) {
      var_0.endgame_modifiers["3_throwingKnifeKills"] = 1;
    }
  }

  if(var_24 == 1) {
    if(!isDefined(var_0.pers["kill_stunned_enemy"])) {
      var_0.pers["kill_stunned_enemy"] = 1;
    } else {
      var_0.pers["kill_stunned_enemy"]++;
    }

    if(var_0.pers["kill_stunned_enemy"] == 5) {
      var_0.endgame_modifiers["5_stunnedkills"] = 1;
    }
  }

  if(var_25) {
    if(!isDefined(var_0.pers["slideKills"])) {
      var_0.pers["slideKills"] = 1;
    } else {
      var_0.pers["slideKills"]++;
    }

    if(var_0.pers["slideKills"] == 3) {
      var_0.endgame_modifiers["3_slidekills"] = 1;
    }
  }

  if(var_26) {
    if(!isDefined(var_0.pers["nosebreaker_kills"])) {
      var_0.pers["nosebreaker_kills"] = 1;
    } else {
      var_0.pers["nosebreaker_kills"]++;
    }

    if(var_0.pers["nosebreaker_kills"] == 5) {
      var_0.endgame_modifiers["5_nosebreaker_kills"] = 1;
    }
  }

  if(var_27 && var_44 == 3) {
    if(!isDefined(var_0.pers["bulletpen_kills_lmg"])) {
      var_0.pers["bulletpen_kills_lmg"] = 1;
    } else {
      var_0.pers["bulletpen_kills_lmg"]++;
    }

    if(var_0.pers["bulletpen_kills_lmg"] == 3) {
      var_0.endgame_modifiers["3_bulletpen_kills_lmg"] = 1;
    }
  }

  if(var_18 && var_28) {
    if(!isDefined(var_0.pers["headshot_cleankill"])) {
      var_0.pers["headshot_cleankill"] = 1;
    } else {
      var_0.pers["headshot_cleankill"]++;
    }

    if(var_0.pers["headshot_cleankill"] == 3) {
      var_0.endgame_modifiers["3_headshot_cleankills"] = 1;
    }
  }

  if(var_17 && var_16 == 3) {
    if(!isDefined(var_0.pers["ads_acog"])) {
      var_0.pers["ads_acog"] = 1;
    } else {
      var_0.pers["ads_acog"]++;
    }

    if(var_0.pers["ads_acog"] == 5) {
      var_0.endgame_modifiers["5_ads_acog"] = 1;
    }
  }

  if(var_22 && var_44 == 3) {
    if(!isDefined(var_0.pers["closerange_lmg"])) {
      var_0.pers["closerange_lmg"] = 1;
    } else {
      var_0.pers["closerange_lmg"]++;
    }

    if(var_0.pers["closerange_lmg"] == 5) {
      var_0.endgame_modifiers["5_closerange_lmg"] = 1;
    }
  }

  if(var_21 && var_23) {
    if(!isDefined(var_0.pers["moving_hipfire_kill"])) {
      var_0.pers["moving_hipfire_kill"] = 1;
    } else {
      var_0.pers["moving_hipfire_kill"]++;
    }

    if(var_0.pers["moving_hipfire_kill"] == 10) {
      var_0.endgame_modifiers["5_moving_hipfire_kill"] = 1;
    }
  }

  var_45 = 1;

  foreach(var_47 in var_10) {
    if(var_47 == "") {
      var_45 = 0;
      break;
    }
  }

  if(var_45) {
    var_15 = setaebit(var_15, 2);
  }

  if(isobjectivemode()) {
    var_15 = setaebit(var_15, 0);
  }

  if(isDefined(level._id_74C4) && istrue(level._id_74C4)) {
    var_15 = setaebit(var_15, 1);
  }

  if(isDefined(var_2.pers["fieldMicActive"]) && var_2.pers["fieldMicActive"]) {
    var_14 = setaebit(var_14, 36);
  }

  if(scripts\engine\utility::is_equal(var_12, "lethal")) {
    var_14 = setaebit(var_14, 62);
    var_0 incplayerpers("lethalKills", 1);

    if(var_0.pers["lethalKills"] == 5) {
      var_14 = setaebit(var_14, 44);
    }
  }

  var_49 = var_2._id_441F - var_2._id_904F;

  if(isDefined(var_2.pers["longestTimeAlive"]) && var_49 > var_2.pers["longestTimeAlive"]) {
    var_2.pers["longestTimeAlive"] = var_49;
  } else if(!isDefined(var_2.pers["longestTimeAlive"])) {
    var_2.pers["longestTimeAlive"] = var_49;
  }

  if(isDefined(var_6._id_5562) && var_6._id_5562 == "equip_equipmentResupplyBox" && var_5 == "MOD_EXPLOSIVE") {
    var_14 = setaebit(var_14, 55);
  }

  if(isDefined(var_0._id_EB09) && isDefined(var_0._id_EB09._id_E76B) && isDefined(var_0._id_EB09._id_E76B._id_C189) && var_0._id_EB09._id_E76B._id_C189 == "super_deadsilence" && var_0._id_EB09._id_88D4) {
    var_14 = setaebit(var_14, 56);
  }

  var_0 reportchallengeuserevent("144115188075855884", [252, "MP", 12, var_13, 1, var_11, 251, var_8, 2, var_10[0], 3, var_10[1], 4, var_10[2], 5, var_10[3], 6, var_10[4], 7, var_10[5], 8, var_10[6], 9, var_10[7], 10, var_10[8], 11, var_10[9], 16, var_44, 15, var_16, 13, var_14, 14, var_15, 17, var_9[0], 18, var_9[1], 19, var_9[2]]);
}

createmultikillchallengeevent(var_0, var_1, var_2, var_3, var_4) {
  if(!var_0 challengesenabledforplayer()) {
    return;
  }
  var_5 = getaegametype();
  var_6 = var_0 getweaponlootid(var_2);
  var_7 = var_0 getoperatorlootid();
  var_8 = getweaponclassenum(var_2);
  var_9 = 0;

  if(isDefined(var_4) && isDefined(var_4.streakname) && var_4.streakname == "glide_bomb") {
    var_9 = var_9 | 16;
  }

  if(!isDefined(self.multikill_modifiers)) {
    self.multikill_modifiers = [];
  }

  if(isDefined(self.multikill_modifiers["mounted"]) && self.multikill_modifiers["mounted"]) {
    var_9 = var_9 | 1;
  }

  if(isDefined(var_0._id_9FFB["collateral"]) && var_0._id_9FFB["collateral"]) {
    var_9 = var_9 | 2;
  }

  if(isDefined(self.multikill_modifiers["mounted"]) && self.multikill_modifiers["mounted"]) {
    var_9 = var_9 | 1;
  }

  var_10 = var_3;
  var_11 = undefined;
  var_12 = 0;

  switch (var_2.basename) {
    case "s4_sticky_eng_n74_mp":
    case "s4_frag_gbr_n82_mp":
    case "s4_frag_ger_m24_mp":
    case "s4_frag_usa_mk2_mp":
      var_11 = "grenade";
      var_12 = 1;
      break;
  }

  if(var_12) {
    if(!isDefined(var_0.pers["grenadeMultikillOnce"])) {
      var_9 = setaebit(var_9, 2);
      var_0.pers["grenadeMultikillOnce"] = 1;
    }
  }

  if(var_8 == 1) {
    var_0 incplayerpers("ar_multikills", 1);

    if(var_0.pers["ar_multikills"] == 5) {
      var_9 = setaebit(var_9, 3);
    }
  }

  if(var_8 == 8) {
    if(!isDefined(var_0.pers["meleeMultikillOnce"])) {
      var_9 = setaebit(var_9, 5);
      var_0.pers["meleeMultikillOnce"] = 1;
    }
  }

  if(isDefined(self.multikill_modifiers["hipfire"]) && self.multikill_modifiers["hipfire"]) {
    var_0 incplayerpers("hipfire_multikill", 1);
  }

  var_0 reportchallengeuserevent("144115188075855889", [252, "MP", 12, var_7, 1, var_6, 251, var_5, 2, var_10, 3, var_9, 16, var_8]);
}

isobjectivemode() {
  var_0 = scripts\mp\utility\game::getgametype();

  if(!isDefined(var_0)) {
    var_0 = getDvar("#x315af23e89f368200");
  }

  if(var_0 == "war" || var_0 == "ffa" || var_0 == "gun") {
    return 0;
  }

  return 1;
}

isusingoperatorfavoriteweapon(var_0, var_1) {
  var_2 = _func_0222("operators.csv", 1, var_1[0], 28);

  if(isDefined(var_0.basename) && issubstr(var_0.basename, var_2)) {
    return 1;
  }

  return 0;
}

isweaponattachmentnameequipped(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < 10; var_3++) {
    var_2[var_3] = "";
  }

  if(isDefined(var_0) && isDefined(var_0._id_0070)) {
    var_3 = 0;
    var_4 = scripts\mp\utility\weapon::_id_69D8(var_0.basename);
    var_5 = _func_0222("mp/statstable.csv", 5, var_4, 4);

    foreach(var_7 in var_0._id_0070) {
      var_8 = scripts\mp\utility\weapon::_id_1DA5(var_7);

      if(var_8 == var_1) {
        return 1;
      }
    }
  }

  return 0;
}

isbitset(var_0, var_1) {
  return (var_0 & 1 << var_1) != 0;
}

setoperatorbit(var_0, var_1) {
  return var_0 + (1 << var_1);
}

getoperatorbit(var_0) {
  var_1 = [33574469, 33574470, 33574472, 33574474, 33574475, 33574476, 33574477, 33574479, 33574480, 33574481, 33574482, 33574483, 33574488, 33574489, 33574490, 33574491, 33574492, 33574493, 33574495, 33574496, 33574497, 33574498, 33574499, 33574500, 33574501, 33574502, 33574503, 33574504, 33574505, 33574506, 33574507];
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4 == var_0) {
      return var_2;
    }

    var_2++;
  }
}

getweaponattachmentids(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_1[var_2] = "";
  }

  if(isDefined(var_0) && isDefined(var_0._id_0070)) {
    var_2 = 0;
    var_3 = scripts\mp\utility\weapon::_id_69D8(var_0.basename);
    var_4 = _func_0222("mp/statstable.csv", 5, var_3, 4);

    foreach(var_6 in var_0._id_0070) {
      var_7 = scripts\engine\utility::ter_op(var_6 == "gunperk_akimbo_smg", var_6, scripts\mp\utility\weapon::_id_1DA5(var_6));
      var_8 = _func_0222("mp/attachmenttable.csv", 5, var_7, 11);

      if(scripts\mp\utility\weapon::_id_1D9B(var_0, var_7) || var_8 != "") {
        var_1[var_2] = _func_0222("loot/" + var_4 + "_attachment_ids.csv", 1, var_7, 0);
        var_2++;
      }

      if(isDefined(level.activeattachmentoverrides) && isDefined(level.activeattachmentoverrides[var_6]) && scripts\mp\utility\weapon::_id_1D9B(var_0, level.activeattachmentoverrides[var_6])) {
        var_1[var_2] = _func_0222("loot/" + var_4 + "_attachment_ids.csv", 1, level.activeattachmentoverrides[var_6], 0);
        var_2++;
      }
    }
  }

  return var_1;
}

getweaponclassenum(var_0) {
  var_1 = weaponclass(var_0.basename);
  var_2 = 0;

  if(issubstr(var_0.basename, "_me_")) {
    var_1 = "melee";
  }

  switch (var_1) {
    case "rifle":
      var_2 = 1;
      break;
    case "mg":
      var_2 = 3;
      break;
    case "melee":
      var_2 = 8;
      break;
    case "pistol":
      var_2 = 7;
      break;
    case "spread":
      var_2 = 6;
      break;
    case "smg":
      var_2 = 2;
      break;
    case "sniper":
      if(issubstr(var_0.basename, "m1golf") || issubstr(var_0.basename, "gecho43") || issubstr(var_0.basename, "svictor40") || issubstr(var_0.basename, "malpha1916")) {
        var_2 = 5;
      } else {
        var_2 = 4;
      }

      break;
    default:
      break;
  }

  return var_2;
}

getloadoutperkids(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = [];

  if(isDefined(var_0._id_3808) && isDefined(var_0._id_3808._id_967F) && var_0._id_3808._id_967F.size > 0) {
    for(var_2 = 0; var_2 < var_0._id_3808._id_967F.size; var_2++) {
      switch (var_0._id_3808._id_967F[var_2]) {
        case "specialty_armory":
          var_1[var_2] = 21;
          break;
        case "specialty_coolheaded":
          var_1[var_2] = 22;
          break;
        case "specialty_dauntless":
          var_1[var_2] = 23;
          break;
        case "specialty_vanguard":
          var_1[var_2] = 24;
          break;
        case "specialty_scout":
          var_1[var_2] = 25;
          break;
        case "specialty_low_profile":
          var_1[var_2] = 26;
          break;
        case "specialty_serpentine":
          var_1[var_2] = 27;
          break;
        case "specialty_tac_mask":
          var_1[var_2] = 28;
          break;
        case "specialty_tactical_recon":
          var_1[var_2] = 1;
          break;
        case "specialty_code_breaker":
          var_1[var_2] = 2;
          break;
        case "specialty_surveillance":
          var_1[var_2] = 3;
          break;
        case "specialty_intuition":
          var_1[var_2] = 4;
          break;
        case "specialty_piercing_vision":
          var_1[var_2] = 5;
          break;
        case "specialty_asdic":
          var_1[var_2] = 6;
          break;
        case "specialty_huntmaster":
          var_1[var_2] = 7;
          break;
        case "specialty_van_demolition":
          var_1[var_2] = 11;
          break;
        case "specialty_hustle":
          var_1[var_2] = 12;
          break;
        case "specialty_van_lightweight":
          var_1[var_2] = 13;
          break;
        case "specialty_mechanic":
          var_1[var_2] = 14;
          break;
        case "specialty_munitions_2":
          var_1[var_2] = 15;
          break;
        case "specialty_scavenger_plus":
          var_1[var_2] = 16;
          break;
        case "specialty_tactician":
          var_1[var_2] = 17;
          break;
        case "specialty_null":
          var_1[var_2] = 30;
          break;
        default:
          var_1[var_2] = 30;
          break;
      }
    }
  } else
    var_1 = [30, 30, 30];

  return var_1;
}

getaegametype() {
  var_0 = scripts\mp\utility\game::getgametype();

  if(!isDefined(var_0)) {
    var_0 = getDvar("#x315af23e89f368200");
  }

  var_1 = 0;

  switch (var_0) {
    case "kspoint":
      var_1 = 57;
      break;
    case "koth":
      var_1 = 18;
      break;
    case "arena_evo":
      var_1 = 48;
      break;
    case "base":
      var_1 = 49;
      break;
    case "conf":
      var_1 = 9;
      break;
    case "control":
      var_1 = 51;
      break;
    case "dm":
      var_1 = 5;
      break;
    case "dom":
      var_1 = 8;
      break;
    case "patrol":
      var_1 = 52;
      break;
    case "sd":
      var_1 = 7;
      break;
    case "tdm":
      var_1 = 6;
      break;
    case "zombie":
      var_1 = 55;
      break;
    default:
      break;
  }

  return var_1;
}

getweaponlootid(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    var_2 = scripts\mp\utility\weapon::_id_69D8(var_0.basename);
    var_3 = _func_0222("mp/statstable.csv", 5, var_2, 4);
    var_4 = var_3 + "_variant_0";
    var_1 = int(_func_0222("loot/weapon_ids.csv", 9, var_4, 0));
  }

  return var_1;
}

getoperatorlootid() {
  var_0 = 0;
  var_1 = "";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupCurrentOperator")]](self.team);
  }

  if(var_1 != "") {
    var_0 = int(_func_0222("loot/operator_ids.csv", 1, var_1, 0));
  }

  return var_0;
}

_id_5AF0(var_0) {
  var_1 = "";
  var_2 = 1;

  if(!scripts\mp\utility\weapon::_id_8799(var_0)) {
    var_1 = "no_attachments";
  }

  if(isDefined(var_0._id_0070)) {
    var_3 = 0;

    foreach(var_5 in var_0._id_0070) {
      var_6 = scripts\mp\utility\weapon::_id_1DA5(var_5);

      if(var_6 == "scope") {
        var_3 = 1;
      }

      if(scripts\mp\utility\weapon::_id_1D9B(var_0, var_6)) {
        if(!var_2) {
          var_1 = var_1 + "|";
        }

        var_6 = scripts\mp\utility\weapon::_id_C323(var_6);
        var_1 = var_1 + var_6;
        var_2 = 0;
      }
    }

    if(var_3) {
      if(!var_2) {
        var_1 = var_1 + "|";
      }

      var_1 = var_1 + "default_sniper_scope";
    }
  }

  return var_1;
}

_id_5AF4(var_0) {
  var_1 = "";
  var_2 = 1;

  if(isDefined(var_0._id_3808) && isDefined(var_0._id_3808._id_967F)) {
    foreach(var_4 in var_0._id_3808._id_967F) {
      if(!var_2) {
        var_1 = var_1 + "|";
      }

      var_1 = var_1 + var_4;
      var_2 = 0;
    }
  }

  return var_1;
}

_id_5AE9(var_0) {
  var_1 = 0;

  if(isPlayer(var_0)) {
    var_1 = var_1 | 1;
  }

  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_0.streakinfo)) {
    var_1 = var_1 | 2;
    var_6 = var_0.streakinfo.streakname;
    var_5 = _id_88F3(var_6);

    switch (var_6) {
      case "sentry_gun":
      case "bradley":
      case "manual_turret":
      case "pac_sentry":
      case "juggernaut":
        var_2 = 1;
        break;
      case "hover_jet":
      case "cruise_predator":
      case "toma_strike":
      case "precision_airstrike":
      case "chopper_gunner":
      case "ball_turret_gunner":
      case "white_phosphorus":
      case "chopper_support":
      case "nuke":
        var_3 = 1;
        break;
      case "scrambler_drone_guard":
      case "uav":
      case "directional_uav":
      case "radar_drone_overwatch":
        var_3 = 1;
        var_4 = 1;
        break;
      case "airdrop":
      case "airdrop_multiple":
        var_4 = 1;
        break;
    }

    if(var_2) {
      var_1 = var_1 | 8;
    }

    if(var_3) {
      var_1 = var_1 | 4;
    }

    if(var_4) {
      var_1 = var_1 | 16;
    }
  }

  if(isDefined(var_0._id_1031E) || var_5) {
    var_1 = var_1 | 32;

    if(!var_2 && isDefined(var_0._id_1031E) && !istrue(var_0 scripts\cp_mp\vehicles\vehicle::_id_102EE())) {
      var_1 = var_1 | 8;
    }
  }

  if(isDefined(var_0._id_5562)) {
    var_1 = var_1 | 64;
  }

  if(isagent(var_0)) {
    var_1 = _id_C771(var_1, var_0);
  }

  return var_1;
}

_id_C771(var_0, var_1) {
  if(!isDefined(var_1._id_13F1)) {
    return var_0;
  }

  switch (var_1._id_13F1) {
    case "soldier":
      var_0 = var_0 | 512;
      break;
    case "juggernaut":
      var_0 = var_0 | 128;
      break;
    case "suicidebomber":
      var_0 = var_0 | 1024;
      break;
    case "riotshield":
      var_0 = var_0 | 256;
      break;
    default:
      var_0 = var_0 | 512;
      break;
  }

  return var_0;
}

_id_AB7C(var_0, var_1) {}

_id_ABB1(var_0) {}

_id_ABA0() {}

_id_FD4D(var_0, var_1) {}

_id_FD49(var_0, var_1, var_2) {}

_id_C670(var_0) {}

_id_F619() {}

_id_9ED6(var_0, var_1, var_2) {}

_id_C939() {}

_id_C93C(var_0) {}

_id_B688(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_BD85(var_0, var_1) {}

_id_8DCC(var_0, var_1, var_2, var_3, var_4) {}

_id_88F3(var_0) {
  switch (var_0) {
    case "sentry_gun":
    case "manual_turret":
    case "cruise_predator":
    case "juggernaut":
      return 0;
  }

  return 1;
}

_id_BD6E(var_0, var_1) {}

_id_FE4D(var_0) {}

_id_6BD5() {
  var_0 = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
    var_0[0] = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupCurrentOperator")]](self.team);
  } else {
    var_0[0] = "";
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupOtherOperator")) {
    var_0[1] = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupOtherOperator")]](self.team);
  } else {
    var_0[1] = "";
  }

  return var_0;
}

incplayerpers(var_0, var_1) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = var_1;
  } else {
    self.pers[var_0] = self.pers[var_0] + var_1;
  }
}