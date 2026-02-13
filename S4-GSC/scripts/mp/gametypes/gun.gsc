/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\gun.gsc
*************************************************/

main() {
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0 = [];
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_D6E0();
  _id_FC7D();
  _id_D585();
  _func_01F5("ffa");
  level.teambased = 0;
  level._id_7D29 = 1;
  level._id_4AE7 = 1;
  level._id_15D8 = 0;
  level.gungameblueprints = 1;
  level.disabled_weapons = strtok(getDvar("#x3938c3afd3ff5bba0", "s4_ar_chotel15,s4_sm_salpha26,s4_mg_aalpha52,s4_ar_valpha1952"), ", ");
  thread _id_1086E();
  level._id_4E69 = 1;
  level._id_EB9B = 0;
  level._id_EB9C = 0;
  level._id_4A87 = 1;
  setomnvar("ui_killcam_copycat", 0);
  level._id_AB7F = ::_id_AB7F;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_9FE8 = ::_id_ABA4;
  level._id_6D4A = scripts\mp\gametypes\dm::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_ABC0 = ::_id_ABC0;
  level._id_AB75 = ::_id_AB75;
  level._id_2DF4 = ::_id_1659;
  level._id_A013 = ::_id_A013;
  game["dialog"]["gametype"] = "gametype_gungame";
  game["dialog"]["boost"] = "boost_gungame";
  game["dialog"]["offense_obj"] = "boost_gungame";
  game["dialog"]["defense_obj"] = "boost_gungame";
  game["dialog"]["lasttier_enemy"] = "lasttier_enemy";
  game["dialog"]["lasttier_friendly"] = "lasttier_friendly";
  level thread _id_CA16();
}

_id_1086E() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level._id_B7E2)) {
    _id_0804::_id_9A02("kdr");
  }
}

_id_1659() {
  return "gamemode";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0(1);
  setdynamicdvar("#x3e0595b5d45e8d8cd", getmatchrulesdata("gunData", "setback"));
  setdynamicdvar("#x389a7f6008559a50b", getmatchrulesdata("gunData", "setbackStreak"));
  setdynamicdvar("#x36a8f1aada7fae5da", getmatchrulesdata("gunData", "killsPerWeapon"));
  setdynamicdvar("#x3e17995c581a0262", getmatchrulesdata("gunData", "ladderIndex"));
  setdynamicdvar("#x3b1d01889ac60080a", 0);
}

_id_AB7F() {}

_id_ABAD() {
  setclientnamemode("auto_change");

  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/DM");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/DM");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/DM_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/DM_HINT");
  }

  _id_D586();
  _id_0817::_id_D461("FreeForAll", "Crit_Default");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_dm_spawn_start", 1);
  _id_0817::_id_1136("allies", "mp_dm_spawn");
  _id_0817::_id_1136("allies", "mp_dm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_dm_spawn");
  _id_0817::_id_1136("axis", "mp_dm_spawn_secondary", 1, 1);
  _id_0817::_id_C2B9("dm", "mp_dm_spawn");
  _id_0817::_id_C2B9("dm_fallback", "mp_dm_spawn_secondary");
  _id_0817::_id_0EE5();
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  level._id_BEF6 = 1;
  level._id_25A8 = 1;
  level._id_5AA7 = 0;
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_D48C = scripts\mp\utility\dvars::_id_509C("setback", 1, 0, 5);
  level._id_D48D = scripts\mp\utility\dvars::_id_509C("setbackStreak", 0, 0, 5);
  level._id_8DA3 = scripts\mp\utility\dvars::_id_509C("killsPerWeapon", 1, 1, 5);
  level._id_8E92 = scripts\mp\utility\dvars::_id_509C("ladderIndex", 1, 1, 4);
}

onplayerconnect(var_0) {
  var_0 thread _id_8CCE();
  var_0._id_7295 = 1;
  var_0.pers["class"] = "gamemode";
  var_0.pers["lastClass"] = "";
  var_0.class = var_0.pers["class"];
  var_0._id_8FAF = var_0.pers["lastClass"];
  var_0.pers["gamemodeLoadout"] = level._id_729A["axis"];
  var_0._id_72AD = 0;
  var_0._id_72AE = 0;
  var_0 thread _id_C193();
  var_0 thread _id_C196();
}

_id_8CCE() {
  self loadweaponsforplayer([level._id_7297[0], level._id_7297[1]], 1);
  var_0 = [];

  for(;;) {
    self waittill("update_loadweapons");
    var_0[0] = level._id_7297[int(max(0, self._id_72AD - level._id_D48C))];
    var_0[1] = level._id_7297[self._id_72AD];
    var_0[2] = level._id_7297[self._id_72AD + 1];
    self loadweaponsforplayer(var_0, 1);
  }
}

_id_ABA4() {
  self setclientomnvar("ui_match_status_hint_text", 0);
  thread _id_1084D();
  level notify("spawned_player");
}

_id_1084D() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");

  if(level.gameended && self._id_72AD == level._id_7297.size) {
    self._id_72AD = self._id_72AE;
  }

  scripts\mp\utility\perk::_id_6FC2("specialty_bling");
  thread _id_6FBE(1);
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended) {
    return;
  }
  if(var_3 == "MOD_FALLING" || isDefined(var_1) && isPlayer(var_1)) {
    var_10 = _id_080B::_id_8A09(var_4.basename);
    var_11 = scripts\mp\utility\weapon::_id_88F9(var_4.basename) || scripts\mp\utility\weapon::_id_8774(var_4.basename) || var_4.basename == "s4_knifestab_mp" || scripts\mp\utility\weapon::getweaponrootname(var_4) == "s4_me_knife";
    var_12 = isDefined(var_3) && var_3 == "MOD_EXECUTION";

    if(!isDefined(self._id_8E90)) {
      self._id_8E90 = 1;
    } else {
      self._id_8E90++;
    }

    if(var_3 == "MOD_FALLING" || var_1 == self || var_3 == "MOD_MELEE" && var_11 || self._id_8E90 == level._id_D48D || var_12) {
      self._id_8E90 = 0;
      self notify("update_loadweapons");
      self._id_72AE = self._id_72AD;
      self._id_72AD = int(max(0, self._id_72AD - level._id_D48C));

      if(self._id_72AE > self._id_72AD) {
        scripts\mp\gamescore::_id_6FCF("dropped_gun_rank", 1);
        thread scripts\mp\rank::_id_CC00("dropped_gun_rank");
        scripts\mp\hud_message::showsplash("dropped_gun_rank");
        scripts\mp\utility\stats::_id_7DAE("setbacks", 1);
        scripts\mp\persistence::_id_E770("round", "setbacks", self.pers["setbacks"]);

        if(isPlayer(self)) {
          scripts\mp\utility\stats::_id_D551(self.pers["setbacks"]);
        }
      }

      if(var_3 == "MOD_MELEE") {
        if(self._id_72AE) {
          var_1 thread _id_0A9F::_id_7003("dropped_enemy_gun_rank");
        }

        var_1 _id_FC9D();
        var_1 _id_07B1::_id_6FB9("mode_gun_melee");
        var_1 scripts\mp\utility\stats::_id_7DAE("stabs", 1);
        var_1 scripts\mp\persistence::_id_E770("round", "stabs", var_1.pers["stabs"]);

        if(isPlayer(var_1)) {
          var_1 scripts\mp\utility\stats::_id_D550(var_1.pers["stabs"]);
        }
      }

      if(var_1 == self) {
        return;
      }
    }

    if(var_1 != self && var_3 == "MOD_PISTOL_BULLET" || var_3 == "MOD_RIFLE_BULLET" || var_3 == "MOD_HEAD_SHOT" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH" || var_3 == "MOD_IMPACT" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_MELEE" && !var_11 || var_3 == "MOD_FIRE" || var_12) {
      var_13 = getweaponbasename(var_1._id_034C);

      if(!var_1 _id_31B7(var_4, var_13, var_12)) {
        return;
      }
      if(!isDefined(var_1._id_8E93)) {
        var_1._id_8E93 = 1;
      } else {
        var_1._id_8E93++;
      }

      if(var_1._id_8E93 != level._id_8DA3) {
        return;
      }
      var_1._id_8E93 = 0;
      var_1._id_8E90 = 0;
      var_1._id_72AE = var_1._id_72AD;
      var_1._id_72AD++;
      var_1 notify("update_loadweapons");
      var_1 scripts\mp\gamescore::_id_6FCF("gained_gun_rank", 1);
      var_1 thread _id_07BC::creategametypechallenegeevent("gungame_weaponadvance");

      if(var_1._id_72AD == level._id_7297.size - 2) {
        level._id_8CDC = 1;
      }

      if(var_1 _id_8962()) {
        var_14 = [];

        foreach(var_16 in level.players) {
          if(var_16 != var_1) {
            var_14[var_14.size] = var_16;
          }
        }

        _id_0A8D::_id_9139("lasttier_enemy", var_14);
        var_1 _id_0A8D::_id_9137("lasttier_friendly");
        level thread scripts\mp\hud_util::_id_EF8D("callout_top_gun_rank", var_1);
      }

      if(var_1._id_72AD < level._id_7297.size) {
        var_18 = scripts\mp\rank::getscoreinfovalue("gained_gun_rank");
        var_1 thread scripts\mp\rank::_id_CC13(var_18);
        var_1 scripts\mp\hud_message::showsplash("gained_gun_rank");
        var_1 thread scripts\mp\rank::_id_CC00("gained_gun_rank");
        var_1 playlocalsound("mp_dom_flag_captured");
        var_1 thread _id_6FBE(0);
      }

      if(isDefined(var_1._id_8FE6) && gettime() - var_1._id_8FE6 < 5000) {
        var_1 _id_07B1::_id_6FB9("mode_gun_quick_kill");
      }

      var_1._id_8FE6 = gettime();
    }
  }
}

_id_6FBE(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!var_0) {
    scripts\common\utility::_id_1593(0);
  }

  var_1 = _id_6B7F();
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);

  if(var_0) {
    self setspawnweapon(var_1);

    foreach(var_3 in self.weaponlist) {
      if(var_3 != var_1) {
        thread scripts\cp_mp\utility\inventory_utility::_id_EDDF(var_3);
      }
    }
  }

  self.pers["primaryWeapon"] = var_1.basename;
  self._id_034C = var_1.basename;
  self.primaryweaponobj = var_1;
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
  var_5 = scripts\mp\utility\weapon::_id_8774(var_1);

  if(var_5) {
    self setweaponammoclip(var_1, 1);
    thread _id_EDE0("s4_knifestab_mp", 0);
  } else if(self._id_72AD != level._id_7297.size - 1) {
    self _meth_819C(var_1);
    var_6 = makeweapon("s4_knifestab_mp");
    self giveweapon(var_6);
    self _meth_8514(var_6);
  }

  if(!var_0) {
    var_7 = self._id_8FC2;
    thread _id_EDE0(var_7, 1);
  }

  _id_6FC1(var_1.basename);
  scripts\mp\weapons::_id_FD69(var_1);
  self._id_72AE = self._id_72AD;

  if(!isDefined(self._id_8FE5)) {
    self._id_8FE5 = gettime();
  }

  var_8 = (gettime() - self._id_8FE5) / 1000;
  self._id_8FE5 = gettime();

  if(isDefined(self.pers["longestTimeSpentOnWeapon"]) && var_8 > self.pers["longestTimeSpentOnWeapon"]) {
    self.pers["longestTimeSpentOnWeapon"] = var_8;
  }
}

_id_EDE0(var_0, var_1) {
  self endon("death_or_disconnect");

  for(;;) {
    if(!scripts\cp_mp\utility\inventory_utility::_id_87E0(var_0)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  if(var_1) {
    scripts\common\utility::_id_1593(1);
  }
}

_id_6B7F(var_0) {
  var_1 = self._id_72AD;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  var_2 = level._id_7297[var_1];
  return var_2;
}

_id_ABC0() {
  var_0 = _id_6A9C();

  if(!isDefined(var_0) || !var_0.size) {
    thread scripts\mp\gamelogic::_id_52F7("tie", game["end_reason"]["time_limit_reached"]);
  } else if(var_0.size == 1) {
    thread scripts\mp\gamelogic::_id_52F7(var_0[0], game["end_reason"]["time_limit_reached"]);
  } else if(var_0[var_0.size - 1]._id_72AD > var_0[var_0.size - 2]._id_72AD) {
    thread scripts\mp\gamelogic::_id_52F7(var_0[var_0.size - 1], game["end_reason"]["time_limit_reached"]);
  } else {
    thread scripts\mp\gamelogic::_id_52F7("tie", game["end_reason"]["time_limit_reached"]);
  }
}

_id_6A9C() {
  var_0 = -1;
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3._id_72AD) && var_3._id_72AD >= var_0) {
      var_0 = var_3._id_72AD;
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_C193() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    var_0 = _func_027D(self._id_034C);
    var_1 = weaponclipsize(self._id_034C);
    var_2 = var_0 - var_1;
    self setweaponammostock(self._id_034C, var_2);
  }
}

_id_C196() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self) && self.team != "spectator" && isDefined(self._id_034C) && self _meth_8109(self._id_034C) == 0) {
      wait 2;
      self notify("reload");
      wait 1;
      continue;
    }

    waitframe();
  }
}

_id_D585() {
  level._id_7297 = [];
  level._id_D067 = [];
  var_0 = scripts\mp\utility\script::_id_EA63("s4_me_icepick_mp", "_mp");

  if(!getdvarint("#x37487890905bfcb18", 1)) {
    var_0 = "s4_me_knife";
  }

  switch (level._id_8E92) {
    case 1:
      level._id_7297[0] = "rand_pistol";
      level._id_7297[1] = "rand_shotgun";
      level._id_7297[2] = "rand_smg";
      level._id_7297[3] = "rand_assault";
      level._id_7297[4] = "rand_lmg";
      level._id_7297[5] = "rand_sniper";
      level._id_7297[6] = "rand_smg";
      level._id_7297[7] = "rand_assault";
      level._id_7297[8] = "rand_lmg";
      level._id_7297[9] = "rand_launcher";
      level._id_7297[10] = "rand_shotgun";
      level._id_7297[11] = "rand_smg";
      level._id_7297[12] = "rand_assault";
      level._id_7297[13] = "rand_smg";
      level._id_7297[14] = "rand_assault";
      level._id_7297[15] = "rand_sniper";
      level._id_7297[16] = "rand_pistol";
      level._id_7297[17] = var_0;
      break;
    case 2:
      level._id_7297[0] = "rand_pistol";
      level._id_7297[1] = "rand_shotgun";
      level._id_7297[2] = "rand_smg";
      level._id_7297[3] = "rand_assault";
      level._id_7297[4] = "rand_pistol";
      level._id_7297[5] = "rand_shotgun";
      level._id_7297[6] = "rand_smg";
      level._id_7297[7] = "rand_assault";
      level._id_7297[8] = "rand_pistol";
      level._id_7297[9] = "rand_shotgun";
      level._id_7297[10] = "rand_smg";
      level._id_7297[11] = "rand_assault";
      level._id_7297[12] = "rand_pistol";
      level._id_7297[13] = "rand_shotgun";
      level._id_7297[14] = "rand_smg";
      level._id_7297[15] = "rand_assault";
      level._id_7297[16] = "rand_pistol";
      level._id_7297[17] = var_0;
      break;
    case 3:
      level._id_7297[0] = "rand_pistol";
      level._id_7297[1] = "rand_assault";
      level._id_7297[2] = "rand_lmg";
      level._id_7297[3] = "rand_launcher";
      level._id_7297[4] = "rand_sniper";
      level._id_7297[5] = "rand_assault";
      level._id_7297[6] = "rand_lmg";
      level._id_7297[7] = "rand_launcher";
      level._id_7297[8] = "rand_sniper";
      level._id_7297[9] = "rand_assault";
      level._id_7297[10] = "rand_lmg";
      level._id_7297[11] = "rand_launcher";
      level._id_7297[12] = "rand_sniper";
      level._id_7297[13] = "rand_assault";
      level._id_7297[14] = "rand_sniper";
      level._id_7297[15] = "rand_assault";
      level._id_7297[16] = "rand_pistol";
      level._id_7297[17] = var_0;
      break;
    case 4:
      level._id_7297[0] = "rand_pistol_epic";
      level._id_7297[1] = "rand_shotgun";
      level._id_7297[2] = "rand_smg";
      level._id_7297[3] = "rand_assault";
      level._id_7297[4] = "rand_lmg";
      level._id_7297[5] = "rand_sniper";
      level._id_7297[6] = "rand_smg";
      level._id_7297[7] = "rand_assault";
      level._id_7297[8] = "rand_lmg";
      level._id_7297[9] = "rand_smg";
      level._id_7297[10] = "rand_shotgun";
      level._id_7297[11] = "rand_smg";
      level._id_7297[12] = "rand_assault";
      level._id_7297[13] = "rand_shotgun";
      level._id_7297[14] = "rand_assault";
      level._id_7297[15] = "rand_sniper";
      level._id_7297[16] = "rand_pistol_epic2";
      level._id_7297[17] = "rand_melee_end_epic";
      break;
  }

  var_1 = level._id_7297.size;
  setdynamicdvar("#x3b70814ad1db86f37", var_1);
  scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), var_1);
}

_id_D586() {
  level._id_D067 = [];
  _id_2D09();

  for(var_0 = 0; var_0 < level._id_7297.size; var_0++) {
    var_1 = level._id_7297[var_0];

    if(scripts\mp\utility\script::_id_8A68(var_1, "rand_")) {
      level._id_7297[var_0] = _id_6CD4(var_1);
      continue;
    }

    var_2 = scripts\mp\utility\weapon::getweaponrootname(level._id_7297[var_0]);
    level._id_D067[var_2] = 1;
    var_3 = var_2;
    var_4 = 0;
    var_3 = _id_7293(var_2, var_4, undefined, scripts\cp_mp\utility\game_utility::isnightmap());
    level._id_7297[var_0] = var_3;
  }

  level._id_D067 = undefined;
}

_id_6CBB() {
  return "archetype_assault";
}

_id_D6E0() {
  level._id_729A["axis"]["loadoutPrimary"] = "s4_pi_mike1911";
  level._id_729A["axis"]["loadoutPrimaryAttachment"] = "none";
  level._id_729A["axis"]["loadoutPrimaryAttachment2"] = "none";
  level._id_729A["axis"]["loadoutPrimaryCamo"] = "none";
  level._id_729A["axis"]["loadoutPrimaryReticle"] = "none";
  level._id_729A["axis"]["loadoutSecondary"] = "none";
  level._id_729A["axis"]["loadoutSecondaryAttachment"] = "none";
  level._id_729A["axis"]["loadoutSecondaryAttachment2"] = "none";
  level._id_729A["axis"]["loadoutSecondaryCamo"] = "none";
  level._id_729A["axis"]["loadoutSecondaryReticle"] = "none";
  level._id_729A["axis"]["loadoutEquipment"] = "specialty_null";
  level._id_729A["axis"]["loadoutOffhand"] = "none";
  level._id_729A["axis"]["loadoutStreakType"] = "assault";
  level._id_729A["axis"]["loadoutKillstreak1"] = "none";
  level._id_729A["axis"]["loadoutKillstreak2"] = "none";
  level._id_729A["axis"]["loadoutKillstreak3"] = "none";
  level._id_729A["axis"]["loadoutPerks"] = [];
  level._id_729A["axis"]["loadoutGesture"] = "playerData";
  level._id_729A["allies"] = level._id_729A["axis"];
}

_id_2D09() {
  level._id_10D69 = [];
  var_0 = level._id_8E92 == 4;
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("mp/gunGameWeapons.csv", var_1, 0);

    if(var_2 == "") {
      break;
    }

    if(!isDefined(level._id_10D69[var_2])) {
      level._id_10D69[var_2] = [];
    }

    var_3 = tablelookupbyrow("mp/gunGameWeapons.csv", var_1, 5);

    if(var_3 == "" || getdvarint(var_3, 0) == 1) {
      var_4 = [];
      var_4["weapon"] = tablelookupbyrow("mp/gunGameWeapons.csv", var_1, 1);
      var_4["min"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", var_1, 2));
      var_4["max"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", var_1, 3));
      var_4["perk"] = tablelookupbyrow("mp/gunGameWeapons.csv", var_1, 4);
      var_4["variant"] = tablelookupbyrow("mp/gunGameWeapons.csv", var_1, 6);

      if(!isDefined(level._id_10DB0[var_4["weapon"]]) || scripts\engine\utility::array_contains(level.disabled_weapons, var_4["weapon"])) {
        var_1++;
        continue;
      }

      if(var_4["variant"] != "") {
        var_5 = strtok(var_4["variant"], "+");
        var_5 = gun_remove_invalid_variants(var_5, var_4["weapon"]);

        if(var_5.size == 0 && var_2 != "rand_launcher") {
          level.disabled_weapons = scripts\engine\utility::array_add(level.disabled_weapons, var_4["weapon"]);
          var_1++;
          continue;
        }

        var_5 = scripts\engine\utility::array_randomize(var_5);
        var_4["variant"] = "";

        foreach(var_7 in var_5) {
          if(isDefined(level._id_10DAC[var_4["weapon"] + "|" + var_7])) {
            var_4["variant"] = var_7;
            break;
          }
        }
      } else if(istrue(level.gungameblueprints) && var_2 != "rand_launcher") {
        level.disabled_weapons = scripts\engine\utility::array_add(level.disabled_weapons, var_4["weapon"]);
        var_1++;
        continue;
      }

      var_4["allowed"] = int(tablelookupbyrow("mp/gunGameWeapons.csv", var_1, 7));

      if(level._id_8E92 == 4 && var_4["variant"] == "") {
        var_1++;
        continue;
      }

      level._id_10D69[var_2][level._id_10D69[var_2].size] = var_4;
    }

    var_1++;
  }
}

gun_remove_invalid_variants(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\mp\utility\weapon::_id_6E93(var_1);

  foreach(var_5 in var_0) {
    var_6 = _func_0222(var_3, 0, var_5, 1);

    if(is_weapon_disabled_by_visibility(var_6)) {
      continue;
    }
    if(variant_is_plateform_specific(var_6)) {
      continue;
    }
    var_2[var_2.size] = var_5;
  }

  return var_2;
}

variant_is_plateform_specific(var_0) {
  if(scripts\mp\utility\script::_id_EA63(var_0, "_sony") != var_0) {
    return 1;
  }

  if(scripts\mp\utility\script::_id_EA63(var_0, "_pc") != var_0) {
    return 1;
  }

  if(scripts\mp\utility\script::_id_EA63(var_0, "_ms") != var_0) {
    return 1;
  }

  return 0;
}

is_weapon_disabled_by_visibility(var_0) {
  var_1 = _func_0222("loot/weapon_ids.csv", 9, var_0, 10);
  var_2 = int(_func_0222("release_tags.csv", 0, var_1, 1));

  if(isDefined(var_2) && getdvarint("visibility_level") < var_2) {
    return 1;
  }

  return 0;
}

_id_6CD4(var_0) {
  var_1 = level._id_10D69[var_0];

  if(isDefined(var_1) && var_1.size > 0) {
    var_2 = "";
    var_3 = undefined;
    var_4 = 0;

    for(;;) {
      var_5 = randomintrange(0, var_1.size);
      var_3 = var_1[var_5];
      var_6 = scripts\mp\utility\weapon::getweaponrootname(var_3["weapon"]);
      var_7 = 1;

      if(level._id_8E92 == 4) {
        var_7 = var_3["allowed"];
      }

      if(!isDefined(level._id_D067[var_6]) && var_7 || var_4 > var_1.size) {
        level._id_D067[var_6] = 1;
        var_2 = var_3["weapon"];

        for(var_8 = 0; var_8 < level._id_10D69[var_0].size; var_8++) {
          if(level._id_10D69[var_0][var_8]["weapon"] == var_2) {
            level._id_10D69[var_0] = ::scripts\engine\utility::array_remove_index(level._id_10D69[var_0], var_8);
            break;
          }
        }

        break;
      }

      var_4++;
    }

    if(var_2 == var_6) {
      var_9 = randomintrange(var_3["min"], var_3["max"] + 1);

      if(level.gungameblueprints) {
        var_2 = makerandomblueprint(var_6, var_3["variant"]);
      } else {
        var_2 = _id_7293(var_6, var_9, var_3["variant"], scripts\cp_mp\utility\game_utility::isnightmap());
      }
    }

    return var_2;
  } else
    return "none";
}

makerandomblueprint(var_0, var_1) {
  var_2 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");
  var_3 = scripts\mp\class::buildweapon_blueprint(var_2, undefined, undefined, int(var_1), undefined, undefined, 0);
  return var_3;
}

_id_7293(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && var_2 != "") {
    var_4 = scripts\mp\class::buildweapon_blueprint(var_0, undefined, undefined, int(var_2), undefined, undefined, var_3);
  } else {
    var_4 = scripts\mp\class::buildweapon(var_0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_3);
  }

  if(!isDefined(var_1)) {
    var_1 = randomintrange(2, 5);
  }

  var_5 = _id_7291(var_4);

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = scripts\mp\weapons::getrandomgraverobberattachment(var_4, var_5);

    if(!isDefined(var_7)) {
      break;
    }

    var_8 = scripts\mp\weapons::addattachmenttoweapon(var_4, var_7);

    if(isDefined(var_8)) {
      var_4 = var_8;
    }
  }

  return var_4;
}

_id_7291(var_0) {
  var_1 = scripts\mp\utility\weapon::_id_68AC(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(_func_010D(var_4, "gl") || _func_010D(var_4, "ub") || _func_010D(var_4, "thermal") || var_4 == "hybrid3") {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_1D90(var_0, var_1, var_2, var_3) {
  var_4 = _func_0222(var_2, 0, var_0, 1);

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = _func_0222(var_2, 0, var_1[var_5], 1);

    if(var_0 == var_1[var_5] || scripts\mp\utility\weapon::_id_1DB2(var_0, var_1[var_5], var_3) != "" || var_4 == var_6) {
      return 0;
    }
  }

  return 1;
}

_id_6E2D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = [];
  var_7 = [];

  if(istrue(var_1) && var_4 != "") {
    var_6 = _func_0222(var_3, 0, int(var_4), 17);
    var_6 = strtok(var_6, "+");
    var_7 = _func_0222(var_3, 0, int(var_4), 18);
    var_7 = strtok(var_7, "+");

    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      var_6[var_8] = ::scripts\mp\utility\weapon::_id_1DA5(var_6[var_8]);
    }
  }

  foreach(var_10 in var_0) {
    var_11 = scripts\mp\utility\weapon::_id_68E5(var_10);

    if(var_7.size > 0 && scripts\engine\utility::array_contains(var_7, var_11)) {
      continue;
    }
    if(var_6.size > 0 && scripts\engine\utility::array_contains(var_6, var_10)) {
      continue;
    }
    if(!scripts\mp\utility\weapon::_id_1D9B(var_2, var_10)) {
      var_5[var_11] = undefined;
      continue;
    }

    switch (var_10) {
      case "xmags":
      case "silencer":
        break;
      default:
        if(!issubstr(var_10, "silencer")) {
          var_5[var_5.size] = var_10;
        }
    }
  }

  return var_5;
}

_id_6FC1(var_0) {
  scripts\mp\equipment::_id_EDBD("primary");
  scripts\mp\equipment::_id_EDBD("secondary");

  if(scripts\mp\utility\weapon::_id_88F9(var_0) || scripts\mp\utility\weapon::_id_8774(var_0) || scripts\mp\utility\weapon::getweaponrootname(var_0) == "s4_me_knife") {
    scripts\mp\utility\perk::_id_6FC2("specialty_scavenger");
    scripts\mp\utility\perk::_id_6FC2("specialty_pitcher");
    scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
    thread scripts\mp\equipment::incrementequipmentammo("equip_throwing_knife");
  }
}

_id_8AEF(var_0) {
  return var_0 == "s4_throwing_knife_mp";
}

_id_AB75(var_0, var_1, var_2, var_3) {
  var_1 scripts\mp\utility\stats::_id_7DAE("gamemodeScore", var_2);
  var_4 = var_1 scripts\mp\utility\stats::_id_6C29("gamemodeScore");
  var_1 scripts\mp\persistence::_id_E770("round", "gamemodeScore", var_4);
  var_5 = 0;

  if(var_0 == "gained_gun_rank") {
    var_5 = 1;
  } else if(var_0 == "dropped_gun_rank") {
    var_6 = level._id_D48C;
    var_5 = var_6 * -1;
  } else if(var_0 == "assist_ffa" || var_0 == "kill")
    var_1 scripts\mp\utility\script::_id_2C9F("earned_score_buffered", var_2);

  return var_5;
}

_id_FC9D() {
  if(!isDefined(self._id_8E35)) {
    self._id_A78E = 0;
    self._id_8E35 = 0;
  }

  self._id_A78E++;

  if(scripts\mp\utility\game::_id_6B5F() < 1) {
    return;
  }
  self._id_8E35 = self._id_A78E / scripts\mp\utility\game::_id_6B5F();
}

_id_A013(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && scripts\mp\utility\weapon::getweaponrootname(var_3) == "s4_me_knife") {
    if(isDefined(var_2) && isDefined(var_2._id_8E35) && var_2._id_8E35 >= 10) {
      return 0;
    }
  }

  return var_0;
}

_id_31B7(var_0, var_1, var_2) {
  if(var_0.basename == var_1) {
    return 1;
  }

  if(_id_8962()) {
    if(_id_8AEF(var_0.basename)) {
      return 1;
    }

    if(var_2) {
      return 1;
    }
  }

  return 0;
}

_id_8962() {
  return self._id_72AD == level._id_7297.size - 1;
}

_id_CA16() {
  while(!isDefined(level.players)) {
    waitframe();
  }

  for(;;) {
    wait(getdvarint("scr_gun_radar_ping_time", 7));

    foreach(var_1 in level.players) {
      if(!isDefined(var_1) || _func_0458(var_1)) {
        continue;
      }
      var_1._id_0358 = _func_00E0();
      var_1._id_024A = 0;
      var_1.hasradar = 1;
      var_1.radarshowenemydirection = 0;
      var_1.radarmode = "normal_radar";
      var_1 setclientomnvar("ui_hide_minimap", 0);
      var_1 setclientomnvar("ui_show_hardcore_minimap", 1);
      _func_0253(var_1);
      var_1 _meth_85C0(2);
    }
  }
}