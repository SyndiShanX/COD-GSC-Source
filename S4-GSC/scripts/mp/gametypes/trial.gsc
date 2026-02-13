/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\trial.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  scripts\engine\utility::_id_5C11("strike_init_done");
  _id_F53D();
  _id_F549();
  _id_0A79::_id_80E0();
  _id_07DC::init();
  _id_07DC::_id_D854();

  if(_func_0127()) {
    scripts\mp\utility\game::_id_D4E0();
  } else {
    setdynamicdvar("#x3ced75240913bc3ea", 0);
    setdynamicdvar("#x39bbda22bdf02c2dd", 0);
  }

  if(issubstr(getDvar("#x376847958d67972ef"), "mp_t_")) {
    setDvar("#x31109f5b6dd29a6e6", 0);
  }

  setDvar("#x3ad78ae4b09274415", 1);
  setDvar("#x3329f2edf7f8433be", 0);
  setDvar("#x3d4e90ea01c7bc02a", 0);
  setDvar("#x334b1a553207e33a5", 0);
  var_0[0] = level.gametype;
  var_0[1] = "trial_variant_" + level._id_F516["variant"];
  var_0[2] = "trial_mission_" + level._id_F516["missionScript"];
  var_0[3] = "t_variant_" + level._id_F516["variant"];
  var_0[4] = "t_mission_" + level._id_F516["missionScript"];

  switch (level._id_F516["missionScript"]) {
    case "race":
    case "arm_course":
      var_0[5] = "arm";
      break;
    default:
      break;
  }

  level._id_15A5 = var_0;
  _id_07D6::main(var_0);
  scripts\mp\utility\game::_id_C2AA(level.gametype, 0, 0, 9);
  scripts\mp\utility\game::_id_C2C1(level.gametype, 0);
  scripts\mp\utility\game::_id_C2AD(level.gametype, 0);
  scripts\mp\utility\game::_id_C2A9(level.gametype, 1);
  scripts\mp\utility\game::_id_C2D0(level.gametype, 1);
  scripts\mp\utility\game::_id_C27E(level.gametype, 0);
  scripts\mp\utility\game::_id_C25D(level.gametype, 0);
  _id_D6E0();
  scripts\mp\gametypes\common::_id_FC39();
  _id_0797::_id_8251();
  level._id_EB9B = 0;
  level._id_EB9C = 0;
  level._id_4AE7 = 1;
  level.teambased = 1;
  level.challengesallowed = 0;
  level._id_6D4A = ::_id_6D4A;
  level.onplayerconnect = ::onplayerconnect;
  level._id_2DF4 = ::_id_1659;
  level._id_52F7 = ::_id_F584;

  if(level._id_CF58.size) {
    level._id_E72D = 0;

    while(!isDefined(level._id_EA70)) {
      waitframe();
    }

    foreach(var_3, var_2 in level._id_CF58)[[var_2]](1, "cs" + var_3);

    foreach(var_5 in level._id_40EA) {
      foreach(var_7 in var_5._id_A8FF) {
        if(isent(var_7) && isDefined(var_7._id_EA6A._id_CD69)) {
          var_8 = 0;

          foreach(var_10 in var_0) {
            if(var_7._id_EA6A._id_CD69 == var_10) {
              var_8 = 1;
            }
          }

          if(!var_8) {
            var_7 delete();
          }
        }
      }
    }
  }

  switch (level._id_F516["missionScript"]) {
    case "gun_nonlinear":
    case "gun":
      thread _id_0A84::init();
      break;
    case "clear":
      thread _id_0A7C::init();
      break;
    case "sniper":
      thread _id_0A88::_id_DF7A();
      break;
    case "jugg":
      thread _id_0A85::_id_8C05();
      break;
    case "lava":
      thread _id_0A7E::init();
      break;
    case "pitcher":
      thread _id_0A86::init();
      break;
    case "gunslinger":
      thread _id_0A7F::init();
      break;
    case "race":
      thread _id_0A87::_id_BF04();
      break;
    case "arm_course":
      thread _id_0A82::init();
      break;
    default:
      break;
  }

  _id_0A83::init();

  if(level._id_F516["compassMaterialOverride"] != "") {
    waitframe();
    _id_07C0::_id_D88B(level._id_F516["compassMaterialOverride"]);
  }
}

_id_F584(var_0, var_1) {
  level notify("exitLevel_called");

  if(isDefined(level._id_F525)) {
    [[level._id_F525]]();
  }

  if(_func_00BE("ui_trial_reward_tier") >= 1) {
    setomnvar("ui_trial_reward_received", 1);
    setomnvar("ui_trial_failed", 0);
    wait 0.1;
    level.player _meth_824E("RoundEndTeamHud");
    wait 3;
  }

  exitlevel(0);
}

_id_F53D() {
  var_0 = getdvarint("#x35f82034f2a516be3", 0);

  if(var_0 == 0) {
    var_1 = _func_0222("mp/trial_mission_table.csv", 2, getDvar("#x376847958d67972ef"), 0);

    if(var_1 != "") {
      var_0 = var_1;
    } else {
      return;
    }
  }

  level._id_F516["missionID"] = int(var_0);
  level._id_F516["zone"] = _func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 2);
  level._id_F516["missionScript"] = _func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 3);
  level._id_F516["variant"] = _func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 4);
  level._id_F516["team"] = _func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 5);
  level._id_F516["scoreType"] = _func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 6);
  level._id_F516["tier1"] = int(_func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 8));
  level._id_F516["tier2"] = int(_func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 9));
  level._id_F516["tier3"] = int(_func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 10));
  level._id_F516["attempts"] = int(_func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 11));
  level._id_F516["compassMaterialOverride"] = _func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 18);
  level._id_F516["playerDataId"] = int(_func_0222("mp/trial_mission_table.csv", 0, level._id_F516["missionID"], 20));

  if(level._id_F516["zone"] != getDvar("#x376847958d67972ef")) {}

  setomnvar("ui_trial_mission_score_is_time", level._id_F516["scoreType"] == "time");
  setomnvar("ui_trial_mission_id", level._id_F516["missionID"]);
  setomnvar("ui_trial_mission_player_data_id", level._id_F516["playerDataId"]);
  setomnvar("ui_trial_tier_1_requirement", level._id_F516["tier1"]);
  setomnvar("ui_trial_tier_2_requirement", level._id_F516["tier2"]);
  setomnvar("ui_trial_tier_3_requirement", level._id_F516["tier3"]);
}

_id_6D4A() {
  while(istrue(level._id_F54F)) {
    waitframe();
  }

  var_0 = "mp_trial_spawn";
  var_1 = _id_0817::_id_6D4E(var_0);
  var_2 = _id_0817::_id_6D4D(var_1);

  if(isDefined(level._id_F54E)) {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018F(level._id_F54E, 1);
    var_4 = spawnStruct();
    var_4._id_FE9B = 1;
    var_4._id_54E5 = "spawned_player";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(level._id_F54E, var_3[0], self, var_4);
    self._id_E309 = 1;
  }

  return var_2;
}

_id_1659() {
  return "gamemode";
}

onplayerconnect(var_0) {
  var_0 thread _id_07F2::_id_1176(level._id_F516["team"]);
  level._id_EF6A["allies"]["soundInfix"] = "uk";
  level._id_EF6A["axis"]["soundInfix"] = "ru";
  var_0 setclientomnvar("ui_skip_loadout", 1);
  var_0 setclientomnvar("ui_total_fade", 1);
  var_0.pers["class"] = "gamemode";
  var_0.pers["lastClass"] = "";
  var_0.class = var_0.pers["class"];
  var_0._id_8FAF = var_0.pers["lastClass"];

  if(isDefined(level._id_F53C)) {
    var_0.pers["gamemodeLoadout"] = level._id_F53C;
  } else {
    var_0.pers["gamemodeLoadout"] = level._id_F53A["axis"];
  }

  if(istrue(level._id_F537)) {
    var_0 thread _id_7E89();
  }

  thread _id_F582();
  level waittill("player_spawned");

  if(level.players.size > 1) {
    exitlevel(0);
  }

  wait 1;
  thread scripts\cp_mp\utility\game_utility::_id_58C7(var_0, 0, 0.5);

  if(game["trial"]["tries_remaining"] < level._id_F516["attempts"]) {
    var_0 _id_0A8D::_id_9137("trial_retry");
  } else if(getDvar("#x376847958d67972ef") == getDvar("#x3b50833b7f7b0066f", "")) {
    var_0 _id_0A8D::_id_9137("trial_intro_short");
  } else {
    var_0 _id_0A8D::_id_9137("trial_intro");
  }

  setDvar("#x3b50833b7f7b0066f", getDvar("#x376847958d67972ef"));
  thread _id_F547();
}

_id_D6E0() {
  level._id_F53A["axis"]["loadoutPrimary"] = "s4_me_fists";
  level._id_F53A["axis"]["loadoutPrimaryAttachment"] = "none";
  level._id_F53A["axis"]["loadoutPrimaryAttachment2"] = "none";
  level._id_F53A["axis"]["loadoutPrimaryCamo"] = "none";
  level._id_F53A["axis"]["loadoutPrimaryReticle"] = "none";
  level._id_F53A["axis"]["loadoutSecondary"] = "none";
  level._id_F53A["axis"]["loadoutSecondaryAttachment"] = "none";
  level._id_F53A["axis"]["loadoutSecondaryAttachment2"] = "none";
  level._id_F53A["axis"]["loadoutSecondaryCamo"] = "none";
  level._id_F53A["axis"]["loadoutSecondaryReticle"] = "none";
  level._id_F53A["axis"]["loadoutEquipment"] = "specialty_null";
  level._id_F53A["axis"]["loadoutOffhand"] = "none";
  level._id_F53A["axis"]["loadoutStreakType"] = "assault";
  level._id_F53A["axis"]["loadoutKillstreak1"] = "none";
  level._id_F53A["axis"]["loadoutKillstreak2"] = "none";
  level._id_F53A["axis"]["loadoutKillstreak3"] = "none";
  level._id_F53A["axis"]["loadoutPerks"] = [];
  level._id_F53A["axis"]["loadoutGesture"] = "playerData";
  var_0 = getent("trial_starting_weapon", "script_noteworthy");

  if(isDefined(var_0)) {
    var_1 = strtok(var_0._id_CE18, "+");
    var_2 = var_1[0];
    var_3 = scripts\engine\utility::array_remove(var_1, var_2);
    level._id_F53A["axis"]["loadoutPrimary"] = var_2;

    foreach(var_7, var_5 in var_3) {
      if(!var_7) {
        level._id_F53A["axis"]["loadoutPrimaryAttachment"] = var_5;
        continue;
      }

      var_6 = "loadoutPrimaryAttachment" + (var_7 + 1);
      level._id_F53A["axis"][var_6] = var_5;
    }
  }

  level._id_F53A["allies"] = level._id_F53A["axis"];
}

_id_7E89() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    self givemaxammo(self._id_0132);
  }
}

_id_F582() {
  level._id_F583 = getEntArray("trial_weapon", "targetname");

  while(!isDefined(level._id_10DB0)) {
    waitframe();
  }

  waitframe();

  foreach(var_1 in level._id_F583) {
    var_1 thread _id_10D1E();
  }
}

_id_10D1E() {
  level.player endon("death");
  var_0 = strtok(self._id_CE18, "+");
  var_1 = var_0[0];
  var_2 = scripts\engine\utility::array_remove(var_0, var_1);
  var_3 = scripts\cp_mp\utility\game_utility::isnightmap();

  if(scripts\engine\utility::array_contains(var_2, "akimbo")) {
    var_2 = scripts\engine\utility::array_remove(var_2, "akimbo");
  }

  var_4 = scripts\mp\utility\weapon::_id_10D5F(var_1);
  var_5 = makeweapon(var_4);
  var_6 = [];

  foreach(var_8 in var_2) {
    var_9 = scripts\mp\utility\weapon::_id_1DA9(var_8, var_4);

    if(var_5 _meth_8629(var_9)) {
      var_6[var_6.size] = var_8;
      continue;
    }
  }

  var_2 = var_6;
  var_11 = scripts\mp\class::buildweapon(var_1, var_2, "none", "none", -1, undefined, undefined, undefined, var_3);
  var_12 = getcompleteweaponname(var_11);

  while(!isDefined(level.player._id_034A[0])) {
    waitframe();
  }

  for(;;) {
    var_13 = 0;
    var_14 = 0;

    if(isDefined(level.player._id_034A[0])) {
      var_13 = var_12 == getcompleteweaponname(level.player._id_034A[0]);
    }

    if(isDefined(level.player._id_034A[1])) {
      var_14 = var_12 == getcompleteweaponname(level.player._id_034A[1]);
    }

    if(!isDefined(self._id_E2B1) && !var_13 && !var_14) {
      self._id_E2B1 = spawn("weapon_" + var_12, self.origin, 17);
      self._id_E2B1.angles = self.angles;
      var_15 = weaponmaxammo(var_11);

      if(isDefined(self._id_039B)) {
        if(self._id_039B == "outline") {
          scripts\mp\utility\outline::outlineenableforplayer(self._id_E2B1, level.player, "outline_trial_item", "level_script");
        } else if(self._id_039B == "osp") {
          scripts\mp\utility\outline::outlineenableforplayer(self._id_E2B1, level.player, "outlinefill_nodepth_cyan", "level_script");
          var_15 = 0;
        }
      }

      if(istrue(level._id_B539)) {
        var_15 = level._id_5378 - weaponclipsize(var_11);
      }

      self._id_E2B1 _meth_81F6(weaponclipsize(var_11), var_15);
    }

    level.player waittill("weapon_dropped", var_16, var_17);

    if(getcompleteweaponname(var_17) == var_12) {
      var_16 delete();
    }
  }
}

_id_F52E() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = _func_00BE("ui_trial_main_score");
  var_4 = _func_00BE("ui_trial_main_time");

  if(var_3 != -1) {
    var_0 = var_3 >= _func_00BE("ui_trial_tier_1_requirement");
    var_1 = var_3 >= _func_00BE("ui_trial_tier_2_requirement");
    var_2 = var_3 >= _func_00BE("ui_trial_tier_3_requirement");
  } else if(var_4 != -1) {
    var_0 = var_4 <= _func_00BE("ui_trial_tier_1_requirement");
    var_1 = var_4 <= _func_00BE("ui_trial_tier_2_requirement");
    var_2 = var_4 <= _func_00BE("ui_trial_tier_3_requirement");
  }

  if(istrue(level._id_F532)) {
    level._id_F532 = 0;
    var_5 = "trial_end_tier_0_alt";
  } else if(var_2)
    var_5 = "trial_end_tier_3";
  else if(var_1) {
    var_5 = "trial_end_tier_2";
  } else if(var_0) {
    var_5 = "trial_end_tier_1";
  } else {
    var_5 = "trial_end_tier_0";
  }

  level.player _id_0A8D::_id_9137(var_5);
  _id_0A8A::_id_F57E();

  if(!istrue(level._id_F548)) {
    level.player _id_0A8D::_id_9137("trial_retry");
  }
}

_id_F549() {
  if(!isDefined(game["trial"])) {
    game["trial"] = [];
  }

  if(!isDefined(game["trial"]["best_score"])) {
    game["trial"]["best_score"] = -1;
  }

  if(!isDefined(game["trial"]["best_time"])) {
    game["trial"]["best_time"] = -1;
  }

  if(!isDefined(game["trial"]["tries_remaining"])) {
    game["trial"]["tries_remaining"] = level._id_F516["attempts"];
  }

  setomnvar("ui_trial_best_score", int(game["trial"]["best_score"]));
  setomnvar("ui_trial_best_time", int(game["trial"]["best_time"]));
  setomnvar("ui_trial_tries_remaining", int(game["trial"]["tries_remaining"]));
}

_id_F547() {
  for(;;) {
    level.player waittill("luinotifyserver", var_0);

    if(var_0 == "trial_restart") {
      _id_0A8A::_id_F546();
    }
  }
}