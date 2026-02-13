/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br.gsc
*************************************************/

main() {
  level._id_A542 = 1;
  level._id_3985 = 1;
  level._id_4AE7 = 1;
  level._id_1B5B = 1;
  level._id_434D = 1;
  level._id_A6CA = 0;
  level._id_37FA = 2;
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_0);
  scripts\mp\gametypes\br_gametypes::init();

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C26C(100);
    scripts\mp\utility\game::_id_C26F(30);
    scripts\mp\utility\game::_id_C272(60);
    scripts\mp\utility\game::_id_C26D(0);
    scripts\mp\utility\game::_id_C271(10);
    scripts\mp\utility\game::_id_C270(5);
    scripts\mp\utility\game::_id_C274("s4_gunless");
    scripts\mp\utility\game::_id_C26E(0.5);
    scripts\mp\utility\game::_id_C273(1.0);
    setDvar("#x31109f5b6dd29a6e6", 1);
    setDvar("#x3d673c1857107248f", 0);
    setDvar("#x3543c96a88cbe1ae9", 0);
    setDvar("#x3a655b1483ef12ca4", 0);
    setDvar("#x3912b1d08466a956b", 5);
    setDvar("#x3e58114ebbd8e0e32", 1);
    setdvarifuninitialized("#x35b9c2e5794f6d63a", 0);
    setdvarifuninitialized("#x37a5078a3608358c2", getdvarint("#x35b9c2e5794f6d63a", 0));
    setdvarifuninitialized("#x39fcadfd30a990181", 2);
    setdvarifuninitialized("#x37ca5a72b0ebcab85", 1);
    setdvarifuninitialized("#x35d47c1e220ab843a", 1.0);
    setdvarifuninitialized("#x3df37778aa2425d1c", 0);
    setdvarifuninitialized("#x320e31573a1848058", 1);
  }

  _id_4636();
  _id_FC7D();
  _id_0797::_id_8251();
  _id_BBA7();
  level.teambased = 0;
  level._id_AD4C = 0.5;
  level._id_AB75 = ::_id_AB75;
  level._id_AB7F = ::_id_AB7F;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_A00B = ::_id_2BF1;
  level._id_AB61 = ::_id_AB61;
  level._id_AB3F = ::_id_AB3F;
  level._id_AAA3 = ::_id_AAA3;
  level._id_AB47 = ::_id_AB47;
  level._id_AB70 = ::_id_AB70;
  level._id_ABB3 = ::_id_ABB3;
  level._id_7C8B = ::_id_7C8B;
  level._id_A91D = ::_id_A91D;
  level._id_ABC0 = ::_id_ABC0;
  level._id_AB6B = ::_id_AB6B;
  level._id_BC70 = ::_id_2C38;
  level._id_AE3B = _id_0797::_id_EDDD;
  level._id_9FEC = scripts\mp\gametypes\br_public::_id_9FEC;
  level._id_15B6 = 0;

  if(!istrue(level._id_29F6)) {
    level._id_AE38 = ::_id_A3C7;
  } else {
    level._id_AE38 = ::_id_9669;
  }

  level._id_9FEE = scripts\mp\gametypes\br_respawn::_id_B7AF;
  level._id_9FE7 = scripts\mp\gametypes\br_respawn::_id_B7A1;
  level._id_9FE6 = ::_id_B6A6;
  level._id_52F7 = ::_id_2BAA;
  level._id_9094 = ::_id_2B44;
  level._id_BBC1 = ::_id_2C37;
  level._id_9FF5 = ::_id_2C44;
  level._id_9FC9 = ::_id_2BD5;
  level._id_9FEF = ::_id_E286;
  level._id_ABB4 = ::_id_ABB4;
  level._id_AB94 = ::_id_AB94;
  level._id_AB3E = ::_id_AB3E;
  level._id_AAF9 = ::_id_AAF9;
  level._id_ABDB = ::_id_ABDB;
  level._id_9FEB = ::_id_2C34;
  level._id_9FE5 = ::_id_2BED;
  level._id_AB60 = ::_id_AB60;
  level._id_B6E9 = ::_id_B6E9;
  level._id_FC75 = ::_id_2AC6;
  level._id_350A = ::_id_2A19;
  level._id_350B = ::_id_2A1A;
  level._id_1031F = scripts\mp\gametypes\br_public::_id_2A81;
  level._id_ED2C = scripts\mp\utility\dvars::_id_509A("tacticalTimeMod", 2.5, 0.5, 5);
  level._id_10DE = scripts\engine\utility::_id_10699;
  level._id_4DAE = 1;
  level._id_4A87 = 1;
  level._id_4ABE = 1;
  level._id_907A = 1;

  if(istrue(getdvarint("#x3d09ee2eaa93c91ef", 0))) {
    level._id_2AA4 = 1;
    level._id_15CA = 1;
    level._id_C145 = 0;
    level.ignorescoring = 1;
    level._id_4AFF = 1;
    level._id_4AEC = 1;
    level._id_BB9E = ::_id_2C35;
    level._id_AA74 = ::_id_2BFE;
    level.challengesdisabled = 1;
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_numLives"), 0);
  }

  level._id_2AA5 = [];
  level._id_2AA6 = [];
  setomnvar("scriptable_loot_hide", 1);
  setomnvar("ui_killcam_copycat", 0);
  level._id_2DF4 = ::_id_B067;
  _func_01EA("ui_skip_loadout", 0);
  level._id_1D2C = 1;
  game["dialog"]["gametype"] = "gametype_survival";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "hint_killall";
  game["dialog"]["defense_obj"] = "hint_ffa";
  game["dialog"]["obj_extraction"] = "objective_extraction";
  game["dialog"]["prematch_enter"] = "gamestate_prematch_enter";
  game["dialog"]["prematch_end"] = "gamestate_prematch_end";
  game["dialog"]["deploy_squad_leader"] = "gamestate_deploy_squad_leader";
  game["dialog"]["first_circle"] = "gamestate_circle_first";
  game["dialog"]["new_circle"] = "gamestate_circle_new";
  game["dialog"]["circle_closing"] = "gamestate_circle_red_close";
  game["dialog"]["final_circle"] = "gamestate_circle_red_final";
  game["dialog"]["last_man_standing"] = "gamestate_last_man_standing";
  game["dialog"]["match_start"] = "gametype_battleroyale";
  game["dialog"]["primary_objective"] = "objective_battleroyale";
  game["dialog"]["supply_drop_incoming"] = "gamestate_supply_drop";
  game["dialog"]["team_loss"] = "gamestate_lose";
  game["dialog"]["team_victory"] = "gamestate_win";
  game["dialog"]["top_5"] = "gamestate_top_5";
  game["dialog"]["top_10"] = "gamestate_top_10";
  game["dialog"]["top_25"] = "gamestate_top_25";
  game["dialog"]["top_50"] = "gamestate_top_50";
  game["dialog"]["top_5_lose"] = "gametype_top_5_lose";
  game["dialog"]["top_10_lose"] = "gametype_top_10_lose";
  game["dialog"]["top_25_lose"] = "gametype_top_25_lose";
  game["dialog"]["finish_calls"] = "game_end_prompt_finish_calls";
  level._id_4A90 = 1;
  level._id_4A91 = ::_id_2B50;
  level._id_E6D6 = [];
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_smk_signal_red"] = loadfx("vfx/iw8_cp/prop/vfx_smk_signal_red");
  level._effect["vfx_br_ac130_clouds"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_ac130_clouds");
  level._effect["vfx_br_ac130_cloud_break"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_break");
  level._effect["vfx_br_infil_cloud_cover"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_cover");
  level._effect["vfx_br_infil_cloud_anim"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_anim");
  level._id_2946 = 1;
  level._id_EF88 = getdvarint("#x3fb633b613cfaed9e", 1) > 0;
  level._id_98D0 = getdvarint("#x39f117d8c9d946098", 0);
  setDvar("#x3c80aa624ac7318ab", 560);
  setDvar("#x366d61d90ed3d6119", 561);
  setDvar("#x35c1ba2123ed16e6a", 560);
  setDvar("#x346347e6aa0d17b2c", 561);
  level._id_9FF1 = ::_id_AE28;
  level._id_AAED = ::_id_AAED;

  if(!isDefined(level._id_DDC4)) {
    level._id_DDC4 = getdvarint("#x360ca39392f5325dd", 0);
  }

  level._id_2A34 = getdvarint("#x315c2989d30b04ca", 0);

  if(level._id_2A34) {
    level._id_4AB9 = 1;
  }

  level._id_2A60 = getdvarint("#x3d2c5723a1e90c36a", 0) || scripts\mp\gametypes\br_gametypes::_id_8853("infil");
  level._id_2A1D = getdvarint("#x378fee964ffcd43a5", 0);
  level._id_2A3F = getdvarint("#x3ac9e147b1e6f17b1", 4);
  level._id_C93E = 0.5;
  level._id_BA5A = 9;
  level._id_B717 = getdvarint("#x3479ab28f2a947c0b");
  level._id_2A83 = getdvarint("#x3f50e0636c4c79b57", -1);
  _id_2BD4();
  scripts\mp\gametypes\br_analytics::_id_2AF4();
  scripts\mp\gametypes\br_vehicles::_id_2C46();
  scripts\mp\gametypes\br_infils::main();
  scripts\mp\gametypes\br_armor::main();
  scripts\mp\gametypes\br_ending::_id_2A40();
  _id_81EB();
  _id_5488();
  level thread _id_18F8();
  setdvarifuninitialized("#x37cbb0fd1da5c320a", 1);
  scripts\mp\gametypes\br_alt_mode_inflation::init();
}

_id_5488() {
  for(var_0 = 1; var_0 < 10; var_0++) {
    _id_0BB7("script_noteworthy", "locale_" + var_0);
  }

  _id_0BB7("script_noteworthy", "locale_99");
}

_id_0BB7(var_0, var_1) {
  var_2 = getEntArray(var_1, var_0);
  scripts\engine\utility::_id_1B98(var_2, ::delete);
}

_id_829B(var_0) {
  var_1 = _func_0225("mp/classtable_br.csv") - 1;
  var_2["loadoutArchetype"] = "archetype_assault";
  var_2["loadoutPrimary"] = _func_0222("mp/classtable_br.csv", 0, "loadoutPrimary", var_0 + 1);
  var_2["loadoutPrimaryAttachment"] = _func_0222("mp/classtable_br.csv", 0, "loadoutPrimaryAttachment1", var_0 + 1);
  var_2["loadoutPrimaryAttachment2"] = _func_0222("mp/classtable_br.csv", 0, "loadoutPrimaryAttachment2", var_0 + 1);
  var_2["loadoutPrimaryAttachment3"] = _func_0222("mp/classtable_br.csv", 0, "loadoutPrimaryAttachment3", var_0 + 1);
  var_2["loadoutPrimaryAttachment4"] = _func_0222("mp/classtable_br.csv", 0, "loadoutPrimaryAttachment4", var_0 + 1);
  var_2["loadoutPrimaryAttachment5"] = _func_0222("mp/classtable_br.csv", 0, "loadoutPrimaryAttachment5", var_0 + 1);
  var_2["loadoutPrimaryCamo"] = _func_0222("mp/classtable_br.csv", 0, "loadoutPrimaryCamo", var_0 + 1);
  var_2["loadoutPrimaryReticle"] = _func_0222("mp/classtable_br.csv", 0, "loadoutPrimaryReticle", var_0 + 1);
  var_2["loadoutSecondary"] = _func_0222("mp/classtable_br.csv", 0, "loadoutSecondary", var_0 + 1);
  var_2["loadoutSecondaryAttachment"] = _func_0222("mp/classtable_br.csv", 0, "loadoutSecondaryAttachment1", var_0 + 1);
  var_2["loadoutSecondaryAttachment2"] = _func_0222("mp/classtable_br.csv", 0, "loadoutSecondaryAttachment2", var_0 + 1);
  var_2["loadoutSecondaryAttachment3"] = _func_0222("mp/classtable_br.csv", 0, "loadoutSecondaryAttachment3", var_0 + 1);
  var_2["loadoutSecondaryAttachment4"] = _func_0222("mp/classtable_br.csv", 0, "loadoutSecondaryAttachment4", var_0 + 1);
  var_2["loadoutSecondaryAttachment5"] = _func_0222("mp/classtable_br.csv", 0, "loadoutSecondaryAttachment5", var_0 + 1);
  var_2["loadoutSecondaryCamo"] = _func_0222("mp/classtable_br.csv", 0, "loadoutSecondaryCamo", var_0 + 1);
  var_2["loadoutSecondaryReticle"] = _func_0222("mp/classtable_br.csv", 0, "loadoutSecondaryReticle", var_0 + 1);
  var_2["loadoutMeleeSlot"] = "none";
  var_2["loadoutEquipmentPrimary"] = _func_0222("mp/classtable_br.csv", 0, "loadoutEquipmentPrimary", var_0 + 1);
  var_2["loadoutEquipmentSecondary"] = _func_0222("mp/classtable_br.csv", 0, "loadoutEquipmentSecondary", var_0 + 1);
  var_2["loadoutStreakType"] = "assault";
  var_2["loadoutKillstreak1"] = "none";
  var_2["loadoutKillstreak2"] = "none";
  var_2["loadoutKillstreak3"] = "none";
  var_2["loadoutSuper"] = "super_br_extract";
  var_2["loadoutPerks"] = [_func_0222("mp/classtable_br.csv", 0, "loadoutPerk1", var_0 + 1), _func_0222("mp/classtable_br.csv", 0, "loadoutPerk2", var_0 + 1), _func_0222("mp/classtable_br.csv", 0, "loadoutPerk3", var_0 + 1), _func_0222("mp/classtable_br.csv", 0, "loadoutExtraPerk1", var_0 + 1), _func_0222("mp/classtable_br.csv", 0, "loadoutExtraPerk2", var_0 + 1), _func_0222("mp/classtable_br.csv", 0, "loadoutExtraPerk3", var_0 + 1)];
  var_2["loadoutGesture"] = "playerData";
  return var_2;
}

_id_6FF2(var_0, var_1) {
  if(!isDefined(level._id_2ABE)) {
    level._id_2ABE = _id_829B(var_0);
  }

  self.pers["gamemodeLoadout"] = level._id_2ABE;
  self.class = "gamemode";
  self._id_BC6C = undefined;
  var_2 = scripts\mp\class::_id_962A();
  var_2 = scripts\mp\class::_id_963A(var_2, "gamemode");
  scripts\mp\class::_id_BB99(var_2, 1, 1);
  self takeallweapons();
  scripts\mp\class::_id_6FB1(self.team, "gamemode", var_1, var_1);
  self _meth_819C(var_2._id_968A);
  self _meth_819C(var_2._id_9699);
  _id_6FAF(self);
  scripts\mp\gametypes\br_weapons::_id_29FF();
  scripts\mp\gametypes\br_weapons::_id_2A4C();
  scripts\mp\gametypes\br_weapons::_id_2A0C(self);
  self notify("ammo_update");
}

_id_A3C7() {
  var_0 = scripts\mp\gametypes\br_gulag::_id_728E();

  if(!var_0 && istrue(level._id_2AA8) && !istrue(self._id_7262)) {
    if(_id_2B53()) {
      var_1 = 0;

      if(istrue(self._id_75B6)) {
        return;
      }
      var_2 = isDefined(self._id_75B6) && !self._id_75B6;

      if(var_2) {
        var_1 = 1;
      }

      var_3 = _id_2BBA();
      _id_6FF2(var_3, var_1);

      if(var_2) {
        self._id_75B6 = 1;
      }
    } else if(_id_2B55())
      _id_6FB6();
    else if(_id_2B52()) {
      var_4 = _id_2BB7();
      var_5 = _id_2BB6();
      _id_6FB5(var_4, var_5);
    }
  }

  thread _id_2A36();
}

_id_9669() {
  var_0 = self.class;

  if(istrue(self._id_81EF) && !istrue(level._id_6FB3)) {
    self.pers["gamemodeLoadout"] = level._id_2AAC;
    var_0 = "gamemode";
  }

  var_1 = scripts\mp\class::_id_BB98(var_0, 1);
  thread scripts\mp\class::_id_EC08();

  if(var_0 != "gamemode") {
    scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_me_fists_mp");
  }

  self._id_F2E8 = 0;

  if(!istrue(self._id_BBA8)) {
    if(istrue(level._id_6FB3)) {
      _id_2BBC();
    }
  }

  self._id_BBA8 = 1;

  if(!istrue(self._id_81EF)) {
    if(istrue(level._id_2AA8)) {
      if(istrue(level._id_6FB3)) {
        _id_2BBC();
      }

      self._id_81EF = 1;
    }
  }

  thread _id_2A36();
}

_id_2BBC() {
  if(istrue(level._id_15D8)) {
    var_0 = scripts\mp\supers::getcurrentsuper();

    if(isDefined(var_0)) {
      scripts\mp\supers::_id_6FF9(scripts\mp\supers::_id_6DA3());
      return;
    }
  } else
    scripts\mp\gametypes\br_pickups::_id_5EA7(self._id_9660);
}

_id_2C31(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(istrue(var_0._id_7262)) {
    return 0;
  }

  if(!isDefined(var_0.team)) {
    return 0;
  }

  if(isDefined(var_1) && var_1.team != var_0.team) {
    return 0;
  }

  if(isDefined(var_1) && var_1 == var_0) {
    return 0;
  }

  return 1;
}

_id_2C32(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_2ABC) || !isDefined(var_0._id_EF83)) {
    return;
  }
  var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_0.team, 1);
  var_2 = "outline_nodepth_brplayer" + var_0._id_2ABC;
  var_3 = getdvarint("#x3df57a22559e5c418", 1024);
  var_4 = _func_0219(var_3);
  var_5 = _id_2C31(var_0);

  foreach(var_7 in var_1) {
    var_8 = var_7 getentitynumber();
    var_9 = var_5 && _id_2C31(var_7, var_0);

    if(var_9) {
      var_10 = distancesquared(var_0.origin, var_7.origin);

      if(var_10 > var_4) {
        var_9 = 0;
      }
    }

    if(!var_9) {
      if(isDefined(var_0._id_EF83[var_8])) {
        scripts\mp\utility\outline::outlinedisable(var_0._id_EF83[var_8], var_0);
        var_0._id_EF83[var_8] = undefined;
      }

      continue;
    }

    if(!isDefined(var_0._id_EF83[var_8])) {
      var_0._id_EF83[var_8] = ::scripts\mp\utility\outline::outlineenableforplayer(var_0, var_7, var_2, "level_script");
    }
  }
}

_id_2C33(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    level waittill("update_circle_hide");
    _id_2C32(var_0);
  }
}

_id_2C30(var_0) {
  var_0 endon("disconnect");

  if(!isDefined(var_0._id_2ABC)) {
    return;
  }
  if(!istrue(level._id_2A60)) {
    var_0 waittill("infil_jump_done");
  }

  var_0._id_EF83 = [];
  var_0 thread _id_2C33(var_0);

  for(;;) {
    _id_2C32(var_0);
    wait 1;
  }
}

_id_81EB() {
  if(!isDefined(level._id_F8D5)) {
    thread scripts\mp\tweakables::init();
  }
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x33d9f1e01a8cfbccf", getmatchrulesdata("brData", "brLoadouts"));
  setdynamicdvar("#x32d0b4bbcba2efa0d", getmatchrulesdata("brData", "crateDropTimer"));
  setdynamicdvar("#x33c1f4c21565de163", getmatchrulesdata("brData", "infilC130"));
  setdynamicdvar("#x389822c1bcfea6f12", getmatchrulesdata("brData", "gulag"));
  setdynamicdvar("#x33dd921c0adbfe660", getmatchrulesdata("brData", "circleDamageMultiplier"));
  setdynamicdvar("#x387090b0da1c093aa", getmatchrulesdata("brData", "startingWeapon"));
  setdynamicdvar("#x38e9bb45982db7dad", 1);
  scripts\mp\utility\game::_id_C2A9("br", 1);
  setdynamicdvar("#x31cee81a5b9c2f0f3", 1);
  scripts\mp\utility\game::_id_C2D0("br", 1);
  setdynamicdvar("#x3a692dbc74e97e47a", 0);
  scripts\mp\utility\game::_id_C26D(0);
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_A77C = scripts\mp\utility\dvars::_id_509C("numEndGame", 4, 0, 20);
  level._id_2BE5 = scripts\mp\utility\dvars::_id_509C("brLoadouts", 0, 0, 5);
  level._id_3E89 = scripts\mp\utility\dvars::_id_509C("crateDropTimer", 60, 0, 300);
  level._id_7086 = scripts\mp\utility\dvars::_id_509A("goalEnableTimer", 60, 0, 300);
  level._id_7089 = scripts\mp\utility\dvars::_id_509A("goalMoveTimer", 0, 0, 300);
  level._id_BF10 = scripts\mp\utility\dvars::_id_509A("radarEndGame", 1, 0, 1);
  level._id_7E66 = scripts\mp\utility\dvars::_id_509A("infilC130", 1, 0, 1);
  level._id_FE76 = scripts\mp\utility\dvars::_id_509A("gulag", 1, 0, 1);
  level._id_3728 = scripts\mp\utility\dvars::_id_509A("circleDamageMultiplier", 1, 0.5, 4);
  level._id_E6DA = scripts\mp\utility\dvars::_id_509C("startingWeapon", 0, 0, 8);
  level._id_F27E = 30;
}

_id_B067() {
  var_0 = "";

  if(!istrue(level._id_2AA8) && istrue(level._id_2AA4)) {
    var_0 = _id_B074();
  } else {
    self.pers["gamemodeLoadout"] = level._id_2A75["default"];
    var_0 = "gamemode";
  }

  self.pers["class"] = var_0;
  return var_0;
}

_id_B074() {
  var_0 = "";

  if(getdvarint("#x3b3c4ca39067993be", 1)) {
    if(!isDefined(level._id_BBB0)) {
      level._id_BBB0 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      level._id_BBB0 = scripts\engine\utility::array_randomize(level._id_BBB0);
    }

    if(!isDefined(self._id_BBA9) || self._id_BBA9 >= 9) {
      self._id_BBA9 = 0;
    } else {
      self._id_BBA9++;
    }

    self.pers["gamemodeLoadout"] = level._id_BBAA[level._id_BBB0[self._id_BBA9]];
    var_0 = "gamemode";
  } else
    var_0 = "default" + (randomint(10) + 1);

  return var_0;
}

_id_BBA7() {
  var_0 = _func_0225("mp/classtable_br_prematch.csv") - 1;
  level._id_BBAA = [];
  var_1 = 0;

  if(getdvarint("#x3b3c4ca39067993be", 1)) {
    var_1 = int(randomint(var_0 - 1) * 0.1) * 10;
    var_0 = var_1 + 10;
  }

  for(var_2 = var_1; var_2 < var_0; var_2++) {
    level._id_BBAA[level._id_BBAA.size] = _id_4034(var_2);
  }
}

_id_4034(var_0) {
  var_1["loadoutArchetype"] = "archetype_assault";
  var_1["loadoutPrimary"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPrimary", var_0 + 1);
  var_1["loadoutPrimaryAttachment"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPrimaryAttachment1", var_0 + 1);
  var_1["loadoutPrimaryAttachment2"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPrimaryAttachment2", var_0 + 1);
  var_1["loadoutPrimaryAttachment3"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPrimaryAttachment3", var_0 + 1);
  var_1["loadoutPrimaryAttachment4"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPrimaryAttachment4", var_0 + 1);
  var_1["loadoutPrimaryAttachment5"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPrimaryAttachment5", var_0 + 1);
  var_1["loadoutPrimaryCamo"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPrimaryCamo", var_0 + 1);
  var_1["loadoutPrimaryReticle"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPrimaryReticle", var_0 + 1);
  var_1["loadoutSecondary"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutSecondary", var_0 + 1);
  var_1["loadoutSecondaryAttachment"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutSecondaryAttachment1", var_0 + 1);
  var_1["loadoutSecondaryAttachment2"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutSecondaryAttachment2", var_0 + 1);
  var_1["loadoutSecondaryAttachment3"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutSecondaryAttachment3", var_0 + 1);
  var_1["loadoutSecondaryAttachment4"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutSecondaryAttachment4", var_0 + 1);
  var_1["loadoutSecondaryAttachment5"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutSecondaryAttachment5", var_0 + 1);
  var_1["loadoutSecondaryCamo"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutSecondaryCamo", var_0 + 1);
  var_1["loadoutSecondaryReticle"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutSecondaryReticle", var_0 + 1);
  var_1["loadoutMeleeSlot"] = "none";
  var_1["loadoutEquipmentPrimary"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutEquipmentPrimary", var_0 + 1);
  var_1["loadoutEquipmentSecondary"] = _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutEquipmentSecondary", var_0 + 1);
  var_1["loadoutStreakType"] = "assault";
  var_1["loadoutKillstreak1"] = "none";
  var_1["loadoutKillstreak2"] = "none";
  var_1["loadoutKillstreak3"] = "none";
  var_1["loadoutSuper"] = "super_br_extract";
  var_1["loadoutPerks"] = [_func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPerk1", var_0 + 1), _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPerk2", var_0 + 1), _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutPerk3", var_0 + 1), _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutExtraPerk1", var_0 + 1), _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutExtraPerk2", var_0 + 1), _func_0222("mp/classtable_br_prematch.csv", 0, "loadoutExtraPerk3", var_0 + 1)];
  var_1["loadoutGesture"] = "playerData";
  var_1["tableColumn"] = var_0;
  return var_1;
}

_id_4636() {
  level._id_2A75["default"]["loadoutArchetype"] = "archetype_assault";
  level._id_2A75["default"]["loadoutPrimary"] = "none";
  level._id_2A75["default"]["loadoutPrimaryAttachment"] = "none";
  level._id_2A75["default"]["loadoutPrimaryAttachment2"] = "none";
  level._id_2A75["default"]["loadoutPrimaryCamo"] = "none";
  level._id_2A75["default"]["loadoutPrimaryReticle"] = "none";
  level._id_2A75["default"]["loadoutSecondary"] = "none";
  level._id_2A75["default"]["loadoutSecondaryAttachment"] = "none";
  level._id_2A75["default"]["loadoutSecondaryAttachment2"] = "none";
  level._id_2A75["default"]["loadoutSecondaryCamo"] = "none";
  level._id_2A75["default"]["loadoutSecondaryReticle"] = "none";
  level._id_2A75["default"]["loadoutMeleeSlot"] = "s4_me_fists_mp";
  level._id_2A75["default"]["loadoutEquipmentPrimary"] = "none";
  level._id_2A75["default"]["loadoutEquipmentSecondary"] = "none";
  level._id_2A75["default"]["loadoutStreakType"] = "assault";
  level._id_2A75["default"]["loadoutKillstreak1"] = "none";
  level._id_2A75["default"]["loadoutKillstreak2"] = "none";
  level._id_2A75["default"]["loadoutKillstreak3"] = "none";
  level._id_2A75["default"]["loadoutSuper"] = "super_br_extract";
  level._id_2A75["default"]["loadoutPerks"] = ["specialty_null"];
  level._id_2A75["default"]["loadoutGesture"] = "playerData";
  level._id_2A75["allies"] = level._id_2A75["default"];
  level._id_2A75["axis"] = level._id_2A75["default"];
  level._id_2AAC = level._id_2A75["default"];
  level._id_2AAC["loadoutSecondary"] = "s4_pi_mike1911";
}

_id_AB7F() {
  level._effect["vfx_gas_ring_player"] = loadfx("vfx/iw8_cp/br_ring/vfx_gas_ring_player.vfx");
  level._effect["vfx_gas_ring_puffy"] = loadfx("vfx/iw8_cp/br_ring/vfx_gas_ring_puffy.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_gas_mask_break"] = loadfx("vfx/iw8_br/gameplay/vfx_br_gasmask_dest.vfx");
}

_id_ABAD() {
  level._id_25A8 = 1;
  level._id_4276 = "brlaststand";
  scripts\mp\playeractions::_id_C23B(level._id_4276, ["usability", "weapon_switch", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "crouch", "prone", "melee"]);
  level._id_7116 = 3;
  level._id_7EB0 = level._id_7116;
  level._id_BBAE = 0;

  if(!level._id_15D8) {
    level._id_D6FE = ::_id_D6FF;
  }

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

  _id_8294();

  if(!_id_98CF()) {
    scripts\mp\gametypes\br_circle::_id_8160();
  }

  scripts\mp\gametypes\br_weapons::_id_29FC();
  scripts\mp\gametypes\br_pickups::_id_2A96();
  scripts\mp\gametypes\br_pickups::_id_825A();
  scripts\mp\gametypes\br_functional_poi::init();
  scripts\mp\gametypes\br_callouts::init();

  if(!_id_98CF()) {
    scripts\mp\gametypes\br_quest_util::_id_807D();
  }

  _id_07B9::_id_2F97();
  scripts\mp\gametypes\br_lootcache::_id_2BE7();
  scripts\mp\gametypes\br_events::_id_2BB3();
  level._id_2A95._id_3E9B = [];
  level._id_2A95._id_ACAD = [];
  scripts\mp\gametypes\br_gulag::_id_81A7();
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", ::_id_1000B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br", "superSlotCleanUp", scripts\mp\gametypes\br_pickups::_id_EB46);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerCrateForCleanup", ::_id_1399);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "brLoadoutCrateFirstActivation", ::_id_136F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeWeaponFromCrate", ::_id_1383);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeItemFromCrate", ::_id_1381);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeItemsFromCrate", ::_id_1382);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "br_giveDropBagLoadout", ::_id_1377);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "brOnLoadoutCrateDestroyed", ::_id_1378);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gasmask", "breakGasMaskBR", scripts\mp\gametypes\br_pickups::_id_2B97);
  _id_821A();
  level thread _id_AB82();
  thread _id_F81A();
  level thread _id_10BEA();
  level thread scripts\mp\gametypes\br_vehicles::_id_2C47();
  level thread _id_FCFC();
  _id_0A9A::_id_C287(::_id_2B57);
  _id_0A8E::_id_C285(::_id_AB63);
  _id_0A9A::_id_C287(::_id_7444);

  if(_id_2B55()) {
    thread scripts\mp\gametypes\br_rewards::_id_8186();
    thread _id_387F();
  }
}

_id_1000B(var_0, var_1) {
  return 1;
}

_id_3894() {
  var_0 = getEntArray("grenade", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2.weapon_name) && var_2.weapon_name == "s4_molotov_mp") {
      thread _id_0A11::_id_A043(var_2);
    }
  }
}

_id_AB81() {
  level waittill("prematch_fade_done");

  if(!istrue(level._id_DDC3)) {
    level thread _id_C600(2.1);
    level thread _id_078A::_id_2FA5(1);
    level thread scripts\mp\gametypes\br_vehicles::_id_2C45();
  }

  level thread scripts\mp\gametypes\br_functional_poi::_id_AB80();

  if(!istrue(level._id_DDC3)) {
    _id_3894();
    scripts\mp\gametypes\br_vehicles::_id_51C9();

    if(!istrue(level._id_2A60)) {
      foreach(var_1 in level.players) {
        var_1 scripts\mp\gametypes\br_infils::_id_D66D();
        var_1 thread scripts\mp\gametypes\br_pickups::_id_C631();

        if(istrue(var_1._id_75B4)) {
          if(istrue(var_1._id_FF04)) {
            var_1 _id_0789::_id_1C24();
          }

          var_1 thread scripts\mp\weapons::_id_4785();
        }
      }
    }

    foreach(var_1 in level.players) {
      if(isDefined(var_1._id_2D8D)) {
        var_1 _id_0A11::_id_A046();
      }

      var_1 _id_07E5::_id_8B85();
    }

    level notify("prematch_cleanup");
  }

  level._id_4A90 = 0;

  foreach(var_7, var_6 in level._id_2AA5) {
    var_6 setscriptablepartstate(level._id_2AA6[var_7], "visible");
  }

  level._id_2AA5 = undefined;
  level._id_2AA6 = undefined;

  if(!scripts\mp\gametypes\br_public::_id_8ACA() && _id_2B54()) {
    scripts\mp\gametypes\br_infils::_id_3806();
  }

  if(!istrue(level._id_2A1D)) {
    level thread scripts\mp\gametypes\br_circle::_id_CA29(1);
  }
}

_id_AB82() {
  level thread _id_AB81();
  var_0 = undefined;

  if(!istrue(level._id_2A60) && !scripts\mp\gametypes\br_public::_id_8ACA()) {
    var_0 = scripts\mp\gametypes\br_c130::_id_4061();
  }

  if(!istrue(level._id_DDC3)) {
    foreach(var_2 in level._id_EF89) {
      _func_01F6(var_2, 1);
      _func_01F7(var_2, 1);
    }
  }

  level waittill("prematch_started");

  if(_id_98CF()) {
    scripts\mp\gametypes\br_circle::_id_8160();
    scripts\mp\gametypes\br_quest_util::_id_807D();
  }

  if(!istrue(level._id_DDC3)) {
    foreach(var_2 in level._id_EF89) {
      _func_01F6(var_2, 0);
      _func_01F7(var_2, 0);
    }
  }

  var_6 = 0;

  if(!istrue(level._id_2A60)) {
    if(!istrue(level._id_7E66) && !istrue(level._id_7E69)) {
      level._id_7E66 = 1;
    }

    if(istrue(level._id_7E69)) {
      if(_id_2B55() && !_id_2B0F()) {
        scripts\mp\gametypes\br_rewards::_id_BB77(1);
      }

      scripts\mp\gametypes\br_infils::_id_E370("player");
      waitframe();

      foreach(var_8 in level.players) {
        var_8 _meth_8655();
        var_8 notify("infil_jump_done");

        if(!var_8._id_2BEC) {
          var_8 thread scripts\mp\gametypes\br_infils::_id_F03C();
          continue;
        }

        var_8 thread _id_D0BB();
      }
    }

    setdvarifuninitialized("#x3ccd9cd9549003136", 0);

    if(istrue(level._id_7E66) && !istrue(level._id_7E69)) {
      if(!getdvarint("#x3ccd9cd9549003136", 0)) {
        scripts\mp\gametypes\br_infils::_id_24A4(var_0, "player");
      } else {
        scripts\mp\gametypes\br_infils::_id_24A4(var_0, "script_model");

        if(isDefined(level._id_7E79) && isDefined(level._id_7E79._id_F4AB)) {
          var_6 = level._id_7E79._id_F4AB;
        }
      }

      level thread scripts\mp\gametypes\br_c130::_id_10975();
    }
  } else {
    level notify("prematch_fade_done");
    waitframe();
    level._id_15CA = 0;
    scripts\mp\gametypes\br_infils::_id_107FA();

    foreach(var_8 in level.players) {
      var_8._id_B928 = undefined;
    }
  }

  level thread _id_743B();

  if(!scripts\mp\gametypes\br_gametypes::_id_8853("teamSpectate")) {
    level thread scripts\mp\gametypes\br_spectate::_id_E3E0();
  }

  level._id_2AA8 = 1;
  level notify("infils_ready");
}

_id_743B() {
  level endon("game_ended");

  if(_id_2B55() && _id_2B0F()) {
    if(!scripts\mp\gametypes\br_public::_id_8AB8() && !scripts\mp\gametypes\br_public::_id_878D()) {
      var_0 = _id_2BB8();
      scripts\mp\gametypes\br_rewards::_id_46AE(var_0);

      if(scripts\mp\gametypes\br_gametypes::_id_8854("dropBagLoop")) {
        for(;;) {
          scripts\mp\gametypes\br_rewards::_id_46AE(var_0);
        }
      }
    }
  }

  level._id_500F = undefined;
}

_id_C600(var_0) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  _id_2B4D(200);
}

_id_7444(var_0, var_1) {
  if(isDefined(var_0) && var_0 == "exit_squad_eliminated") {
    self setclientomnvar("ui_br_squad_eliminated_active", 0);
  }
}

_id_FCFC() {
  level endon("game_ended");
  level._id_2F7C._id_2FCF = getEntArray("location_volume", "targetname");

  if(!level._id_2F7C._id_2FCF.size) {
    return;
  }
  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(!isPlayer(var_2) || !isalive(var_2)) {
        continue;
      }
      if(isDefined(var_2._id_2A31) && var_2 istouching(var_2._id_2A31)) {
        continue;
      }
      var_3 = 0;

      foreach(var_5 in level._id_2F7C._id_2FCF) {
        if(var_2 istouching(var_5)) {
          var_3 = 1;
          var_2._id_2A31 = var_5;
          var_2 _id_07BA::_id_D65C(var_5._id_039B);
          break;
        }
      }

      if(!var_3) {
        var_2._id_2A31 = undefined;
        var_2 _id_07BA::_id_D65C("none");
      }

      var_0 = (var_0 + 1) % 2;

      if(var_0 == 0) {
        waitframe();
      }
    }

    waitframe();
  }
}

_id_6E2C() {
  return 0;
}

_id_10BEA() {
  level waittill("prematch_fade_done");
  level notify("br_prematchEnded");
  var_0 = scripts\mp\utility\game::_id_6B13();

  if(!level.teambased) {
    level._id_F37B = var_0.size;
  }

  var_1 = 0;

  foreach(var_3 in level._id_EF89) {
    if(scripts\mp\utility\teams::_id_6DCA(var_3, "aliveCount") > 0) {
      var_1++;
    }
  }

  level._id_E6D8 = max(1, var_1);
  level._id_BBA4 = gettime();
  level._id_C145 = 1;
  level.ignorescoring = 0;
  level._id_4AFF = 0;
  level._id_4AEC = 0;
  level._id_BB9E = undefined;
  level.challengesdisabled = 0;
  _id_2B4C();

  foreach(var_6 in level.players) {
    var_6 _id_C60C();
  }

  if(!scripts\mp\gametypes\br_gametypes::_id_8854("allowLateJoiners")) {
    level._id_15BE = 0;
    _func_01E7(1, 1);
    _func_01E6(1, 1);
  }

  brmatchstarted();
  setomnvar("scriptable_loot_hide", 0);

  foreach(var_6 in level.players) {
    var_6 setclientdvar("#x32add9cc9e0c920a1", 1);

    if(isalive(var_6)) {
      var_6.health = var_6.maxhealth;
      var_6 _id_07BC::_id_E68C("alive_not_downed");
    }
  }

  scripts\mp\gametypes\br_analytics::_id_2B01(var_0.size);
  level _id_D656();
}

_id_F81A() {
  wait 1;
  setomnvar("ui_match_timer_hidden", 1);
}

_id_8294() {
  _id_0817::_id_D461("FreeForAll", "Crit_Default");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_8275() {
  if(!scripts\mp\gametypes\br_public::_id_878D()) {
    level._id_E6D6 = _id_0817::_id_6D4E("mp_dm_spawn_start");

    if(level._id_E6D6.size == 0) {
      level._id_E6D6 = _id_0817::_id_6D4E("mp_tdm_spawn_allies_start");
    }

    level._id_BBB2 = _id_6C86();
  }
}

_id_44FC() {
  for(;;) {
    foreach(var_1 in level._id_BBB2) {
      [var_3, var_4] = _id_6C87(var_1);

      if(var_3 > 0) {}
    }

    waitframe();
  }
}

_id_FE58() {
  var_0 = getdvarint("#x33b36102d7de7a194", 0) != 0;
  return !istrue(level._id_2AA8) && !istrue(level._id_DDC4) && !var_0 && !istrue(level._id_7E6A);
}

_id_6D4A(var_0) {
  if(isDefined(self._id_BBED)) {
    var_1 = self._id_BBED;
    self._id_BBED = undefined;
    return var_1;
  }

  if(isDefined(self._id_81F4)) {
    var_1 = self._id_81F4;
    return var_1;
  }

  if(!isDefined(level._id_BBB2)) {
    _id_8275();
  }

  if(istrue(var_0) || _id_FE58()) {
    var_2 = (0, randomintrange(0, 360), 0);
    var_3 = _id_6C88();
    [var_5, var_6] = _id_6C87(var_3);
    var_7 = randomfloatrange(var_5, var_6);

    if(getdvarint("#x3f70ba763f20b46a3", 0) == 1) {
      var_8 = vectortoangles(var_3.origin);
      var_2 = (0, var_8[1], 0) * -1;
      var_7 = var_6;
    }

    var_9 = anglesToForward(var_2) * -1;
    var_10 = var_9 * var_7;
    var_11 = var_3.origin + var_10;

    if(isDefined(self._id_D6DA)) {
      var_12 = scripts\mp\gametypes\br_infils::_id_6ABB();
      var_11 = self._id_D6DA._id_B7D1 + (0, 0, var_12);
      var_2 = self._id_D6DA._id_B7CB;
      _id_0A18::_id_E343(0, 1);
    }

    var_1 = spawnStruct();
    var_1.origin = var_11;
    var_1.angles = var_2;
    var_1.index = -1;
    return var_1;
  }

  var_13 = level._id_E6D6;
  var_1 = _id_0817::_id_6D4C(var_13);
  return var_1;
}

_id_4051(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3._id_9F36 = var_1;
  var_3._id_0359 = var_2;
  return var_3;
}

_id_6C86() {
  var_0 = 0;
  var_1 = scripts\engine\utility::getstructarray("br_prematch_insertion_point", "targetname");

  if(isDefined(level._id_2AA7)) {
    var_0 = 1;
    var_1 = level._id_2AA7;
  } else if(!var_1.size) {
    var_0 = 1;
    var_1 = getEntArray("vehicle_volume", "script_noteworthy");
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_0359)) {
      var_3._id_0359 = 5000;
    }

    if(!isDefined(var_3._id_9F36)) {
      var_3._id_9F36 = 500;
    }
  }

  var_5 = getdvarint("#x3324232f9982c640e", 5);

  if(var_5 > 0 && var_5 < var_1.size) {
    var_1 = scripts\engine\utility::_id_1BD4(scripts\engine\utility::array_randomize(var_1), 0, var_5);
  }

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3.origin = _id_6BCA(var_3.origin);
      continue;
    }

    var_7 = _id_6BCA(var_3.origin)[2];

    if(var_3.origin[2] < var_7) {
      var_3.origin = (var_3.origin[0], var_3.origin[1], var_7);
    }
  }

  return var_1;
}

_id_6BCA(var_0, var_1) {
  var_2 = scripts\engine\trace::_id_3EF6(1);
  var_3 = (0, 0, 5000);
  var_4 = var_0 + var_3;
  var_5 = var_0 - var_3;
  var_6 = scripts\engine\trace::ray_trace(var_4, var_5, undefined, var_2);
  var_7 = var_0;

  if(var_6["hittype"] != "hittype_none") {
    var_7 = var_6["position"];
  }

  if(!isDefined(var_1)) {
    var_8 = scripts\mp\gametypes\br_infils::_id_6ABB();
    var_1 = (0, 0, var_8);
  }

  return var_7 + var_1;
}

_id_6A20() {
  var_0 = int(150 / level.maxteamsize);
  return var_0;
}

_id_6C88() {
  if(!isDefined(level._id_BBB3)) {
    level._id_BBB3 = [];
    level._id_BBB1 = randomint(level._id_BBB2.size);
    level._id_BBB4 = [];

    for(var_0 = 0; var_0 < level._id_BBB2.size; var_0++) {
      level._id_BBB4[var_0] = 0;
    }
  }

  if(!isDefined(level._id_BBB3[self.sessionteam])) {
    level._id_BBB3[self.sessionteam] = level._id_BBB2[level._id_BBB1];
    level._id_BBB4[level._id_BBB1]++;
    var_1 = _id_6A20();
    var_2 = int(var_1 / level._id_BBB2.size);

    if(level._id_BBB4[level._id_BBB1] >= var_2) {
      level._id_BBB1 = (level._id_BBB1 + 1) % level._id_BBB2.size;
    }
  }

  var_3 = level._id_BBB3[self.sessionteam];
  var_4 = getdvarint("#x327d39a46e9adfe7", -1);

  if(var_4 >= 0 && var_4 < level._id_BBB2.size) {
    var_3 = level._id_BBB2[var_4];
  }

  return var_3;
}

onplayerconnect(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0._id_F90E = undefined;
  var_0._id_F90F = undefined;
  var_0._id_A417 = undefined;
  var_0._id_2A5E = undefined;
  var_0.equipment = [];
  var_0._id_2A64 = 1;
  var_0 thread scripts\mp\gametypes\br_weapons::_id_2A02();
  var_0 _id_078A::_id_2F99();

  if(scripts\mp\gametypes\br_gametypes::_id_8792("playerWelcomeSplashes")) {
    var_0 thread scripts\mp\gametypes\br_gametypes::_id_CA24("playerWelcomeSplashes");
  } else {
    var_0 thread _id_B821();
  }

  var_0 _id_C60C();

  if(!istrue(level._id_BBB5)) {
    var_0.radarmode = "slow_radar";
    level waittill("prematch_started");
    wait 1.4;
  }

  if(!isDefined(var_0._id_E9FF)) {
    waittillframeend;
  }

  if(isDefined(var_0)) {
    if(!scripts\mp\gametypes\br_public::_id_8805() && !scripts\mp\gametypes\br_public::_id_8AB8() && !scripts\mp\gametypes\br_public::_id_878D()) {
      var_0 scripts\mp\gametypes\br_weapons::_id_29FF();
      var_0 scripts\mp\gametypes\br_pickups::_id_C631();
      var_0 scripts\cp_mp\utility\game_utility::_id_E6DE();
    }

    if(!scripts\mp\gametypes\br_public::_id_8AB8() && !scripts\mp\gametypes\br_public::_id_8805() && scripts\mp\utility\game::_id_6D9E() != "dmz") {
      var_0 thread _id_A153();
    }

    var_0.radarmode = "normal_radar";
    scripts\mp\gametypes\br_quest_util::onplayerconnect(var_0);
    _id_81DB(var_0);
    scripts\mp\gametypes\br_gametypes::_id_CA24("onPlayerConnect", var_0);
  }
}

_id_B821() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome");

  if(!istrue(level._id_2A60)) {
    self waittill("br_jump");

    while(!self isonground()) {
      waitframe();
    }
  } else
    level waittill("prematch_done");

  scripts\mp\gametypes\br_analytics::_id_2AFB(self);
  wait 1;
  scripts\mp\gametypes\br_public::_id_2BDD("primary_objective", self, 0);
}

_id_ABA4() {
  self notify("br_spawned");
  var_0 = istrue(self._id_7262);
  scripts\mp\gametypes\br_pickups::_id_825B(var_0);
  scripts\mp\gametypes\br_functional_poi::_id_825B();
  scripts\mp\gametypes\br_armor::_id_813B();

  if(!scripts\mp\gametypes\br_gametypes::_id_8853("teamSpectate")) {
    scripts\mp\gametypes\br_spectate::_id_825B();
  }

  self._id_AA39 = undefined;
  self._id_A459 = undefined;
  self._id_7647 = 0;
  self._id_2A6D = gettime();
  self._id_A417 = undefined;
  self._id_72C3 = undefined;
  self._id_2B56 = undefined;
  thread _id_1084D();
  level._id_EB1C = 0;
  level._id_EB3C = 1;
  self._id_2A86 = [0, 0, 0, 0, 0];
  self._id_2A85 = 0;

  if(level._id_AE25) {
    self _meth_876C();
  } else {
    self _meth_876D();
  }

  if(level._id_AE26) {
    self _meth_876A();
  } else {
    self _meth_876B();
  }

  if(getdvarint("#x35b85211dba09a1df", 0) > 0) {
    level thread _id_2C30(self);
  }

  scripts\mp\gametypes\br_public::_id_D65F(0);
  scripts\mp\gametypes\br_public::_id_D659(0);
  _id_FD3E(self, self, 0, 1);
  level thread _id_FCF5();
}

_id_1091E(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3);
  var_1 notify("returned", var_2, var_3, var_0);
}

_id_108BB(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death")) {
    self endon("death");
  }

  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_1091E(var_0, var_3);
  }

  if(isDefined(var_1)) {
    childthread _id_1091E(var_1, var_3);
  }

  if(isDefined(var_2)) {
    childthread _id_1091E(var_2, var_3);
  }

  var_3 waittill("returned", var_4, var_5, var_6);
  var_3 notify("die");
  var_7 = spawnStruct();
  var_7._id_96CF = var_4;
  var_7.angles = var_5;
  var_7._id_EA52 = var_6;
  return var_7;
}

_id_F3D1(var_0) {
  var_1 = var_0 + (0, 0, 10000);
  var_2 = var_0 - (0, 0, 10000);
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_id_102BD();
  var_4 = level._id_0F4C;
  var_5 = scripts\engine\utility::array_combine(var_3, var_4);
  var_6 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 0, 0, 0, 0);
  return scripts\engine\trace::ray_trace(var_1, var_2, var_5, var_6, 0, 1);
}

_id_6FD5() {
  self endon("death_or_disconnect");

  if(!istrue(level._id_2AA4)) {
    return;
  }
  waitframe();

  if(!level._id_15D8 && !istrue(level._id_6FB3)) {
    scripts\mp\gametypes\br_pickups::_id_C649();
    scripts\mp\gametypes\br_pickups::_id_5EA7("super_ammo_drop", 0);
  }
}

_id_6FB5(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  if(!isDefined(var_1)) {
    var_1 = 20;
  }

  var_2 = self;
  var_3 = var_2 scripts\mp\class::_id_962E(var_2.class);

  if(!isDefined(var_3)) {
    return;
  }
  var_2._id_BC6C = undefined;
  var_2 scripts\mp\class::_id_961E();
  var_2 scripts\mp\class::_id_9653(var_3);
  _id_6FAF(var_2);
  var_4 = 0;

  if(isDefined(var_3._id_9699) && !isnullweapon(var_3._id_9699)) {
    scripts\mp\gametypes\br_weapons::_id_2A47(var_2, var_3._id_9699, var_3._id_9697, var_3._id_9692, var_0, var_1);
    var_4++;
  }

  if(isDefined(var_3._id_968A) && !isnullweapon(var_3._id_968A)) {
    scripts\mp\gametypes\br_weapons::_id_2A47(var_2, var_3._id_968A, var_3._id_9688, var_3._id_9683, var_0, var_1);
    var_4++;
  }

  if(var_4 > 1) {
    var_2 takeweapon("s4_me_fists_mp");
  }

  var_5 = [];

  if(isDefined(var_3._id_966A)) {
    var_5[var_5.size] = var_3._id_966A;
  }

  if(isDefined(var_3._id_966B)) {
    var_5[var_5.size] = var_3._id_966B;
  }

  foreach(var_7 in var_5) {
    if(isDefined(level._id_2A95._id_2A43[var_7])) {
      var_8 = level._id_2A95._id_2A43[var_7];
      scripts\mp\gametypes\br_pickups::_id_2A46(var_2, var_8, 1);
    }
  }
}

_id_6FB6() {
  var_0 = self;
  var_0._id_BC6C = undefined;
  var_0 scripts\mp\class::_id_961E();
  _id_6FAF(var_0);
}

_id_BBA2() {
  self endon("disconnect");

  while(self.sessionstate != "playing") {
    waitframe();
  }

  thread _id_0797::_id_E6AD(2, 0, undefined, undefined, 1, 0);
}

_id_6C87(var_0) {
  var_1 = var_0._id_0359;
  var_2 = var_0._id_9F36;
  var_3 = getdvarint("#x31c4761401165d880", -1);

  if(var_3 >= 0) {
    var_1 = var_3;
  }

  var_3 = getdvarint("#x31b2a95bca9138e2e", -1);

  if(var_3 >= 0) {
    var_2 = var_3;
  }

  if(var_2 >= var_1) {
    var_1 = var_2 + 1;
  }

  return [var_2, var_1];
}

_id_6FAF(var_0) {
  if(!level.teambased) {
    return;
  }
  var_1 = level.maxteamsize == 1;

  if(var_1) {
    return;
  }
  if(!_id_87BE(var_0)) {
    return;
  }
  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    return;
  }
  var_0 scripts\mp\utility\perk::_id_6FC2("specialty_pistoldeath");
}

_id_1084D() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("giveLoadout");

  if(scripts\mp\gametypes\br_public::_id_8AB8() || scripts\mp\gametypes\br_public::_id_8805()) {
    return;
  }
  if(scripts\mp\gametypes\br_public::_id_878D()) {
    scripts\mp\gametypes\br_armor::_id_6FF3();
    return;
  }

  if(!istrue(level._id_2AA8)) {
    thread _id_6FD5();
    scripts\mp\gametypes\br_armor::_id_6FF3();

    if(!istrue(self._id_BBAF)) {
      self._id_BBAF = 1;
      scripts\engine\utility::delaythread(1.0, scripts\mp\gametypes\br_public::_id_2BDD, "prematch_enter", self);
      var_0 = game["music"]["br_lobby_intro"].size - 1;
      var_1 = randomint(var_0);
      self setplayermusicstate(game["music"]["br_lobby_intro"][var_1]);
    }

    var_2 = getdvarint("#x33b36102d7de7a194", 0) != 0;

    if(istrue(level._id_7E69) && !var_2) {
      level waittill("begin_infil_map_selection");
      scripts\mp\gametypes\br_weapons::_id_29FF();
      scripts\mp\gametypes\br_pickups::_id_C631();
    }

    level waittill("infils_ready");

    if(level._id_15D8) {
      scripts\mp\supers::_id_3987(0);
    }
  }

  scripts\mp\gametypes\br_weapons::_id_29FF();
  var_3 = istrue(self._id_7262) || scripts\mp\gametypes\br_public::_id_8AB8();
  scripts\mp\gametypes\br_pickups::_id_C631(var_3);

  if(!var_3) {
    scripts\mp\gametypes\br_armor::_id_6FF3();
  }

  _id_6FAF(self);

  if(istrue(self._id_8A01)) {
    return;
  }
  if(istrue(self._id_7262)) {
    return;
  }
  if(!istrue(level._id_2A60)) {
    thread scripts\mp\gametypes\br_infils::_id_D66D();
  }
}

_id_AB75(var_0, var_1, var_2, var_3) {
  return var_2;
}

_id_2BF1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_1 scripts\mp\gametypes\br_public::_id_8990() && istrue(var_1._id_7263) && getdvarint("#x32c7c44b00ff05e8b", 1)) {
    return var_3;
  }

  if(!isDefined(var_10)) {
    var_10 = var_3;
  }

  if(var_3 > 0) {
    if(istrue(var_1._id_82E8)) {
      var_1 notify("try_armor_repair_cancel");
    }

    var_11 = scripts\mp\utility\weapon::_id_6E6A(var_5);
    var_12 = weaponclass(var_11);

    if(var_4 == "MOD_FALLING") {
      if(getdvarint("#x33a7a1f13d25f9546", 0)) {
        var_3 = 0;
      } else {
        var_3 = self.maxhealth + self._id_2A7D;
      }
    } else if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::_id_8AF5())
      var_3 = scripts\common\utility::_id_C94D(var_3 * ((self.maxhealth + self._id_2A7D) / level._id_B717));
    else if(var_4 == "MOD_MELEE") {
      var_3 = int(var_10);
    } else if(scripts\mp\utility\weapon::_id_88F6(var_5)) {
      if(istrue(var_1.inlaststand) && scripts\mp\utility\killstreak::_id_6AE7(var_5) == "precision_airstrike") {
        if(isDefined(var_1._id_2B56)) {
          var_13 = gettime() - var_1._id_2B56 < 5000;

          if(var_13) {
            var_3 = 0;
          }
        }
      }
    } else if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_FIRE") {
      if(getdvarint("#x33a7a1f13d25f9546", 0)) {
        var_3 = 0;
        var_1 thread _id_29F7(var_0);
      }

      if(var_11 == "claymore_mp" || var_11 == "claymore_radial_mp") {
        var_3 = int(var_3 * 1.5);
      }
    } else if(scripts\mp\utility\weapon::_id_8A9F(var_5))
      var_3 = 200;
    else if(getdvarint("#x395344732688f8bdc", 0) && var_4 != "MOD_TRIGGER_HURT") {
      var_3 = _id_2B49(var_9, var_12, var_11, var_8, var_3);
    } else if(getdvarint("#x3327640295dff50ec", istrue(level._id_37FA)) && var_4 != "MOD_TRIGGER_HURT") {
      var_3 = _id_2B48(var_9, var_12, var_11, var_8, var_10, var_3, var_5);
    }

    if(_id_2BBD(var_1)) {
      if(var_11 != "rock_mp") {
        var_3 = 0;
        var_2 thread _id_07C4::_id_FC47("standard", 0, 0, "standard", 0);
      } else
        var_3 = 1;

      if(var_1.health - var_3 <= 0) {
        var_3 = 0;
      }
    }
  }

  return var_3;
}

_id_29F7(var_0) {
  var_1 = (self.origin[0], self.origin[1], self.origin[2] + 36);

  if(self isonground()) {
    var_2 = (self.origin[0], self.origin[1], self.origin[2] + 20);
    self setorigin(var_2);
  }

  var_3 = var_1 - var_0.origin;
  var_3 = vectornormalize(var_3);
  var_4 = getdvarfloat("#x3364da11e5eaa161d", 1300);
  var_5 = undefined;

  if(var_3[2] > -0.3) {
    var_5 = getdvarfloat("#x38741af1dddffa195", 600);
  }

  var_6 = distance2d(var_0.origin, self.origin) - 20;
  var_7 = clamp(var_6, 0, 80) / 100 * 0.5;
  var_8 = 1;
  var_9 = var_8 - var_7;
  var_3 = var_3 * var_4 * var_9;

  if(isDefined(var_5)) {
    var_10 = var_8 - var_7 * 0.5;
    var_5 = var_5 * var_10;
    var_3 = (var_3[0], var_3[1], max(var_5, var_3[2]));
  }

  self setvelocity(var_3);
}

_id_2B49(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && var_0 &level._id_7CA1) {
    var_5 = 1;
  } else {
    var_5 = 0;
  }

  if(!var_5) {
    switch (var_1) {
      case "pistol":
        break;
      case "sniper":
        break;
      default:
        break;
    }
  }

  return var_4;
}

_id_2B48(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_0) && var_0 &level._id_7CA1) {
    var_7 = 1;
  } else {
    var_7 = 0;
  }

  if(!var_7) {
    switch (var_1) {
      case "pistol":
      case "mg":
      case "rifle":
        var_8 = var_5 / var_4;
        var_5 = _id_2B4A(var_4, var_6, level._id_37FA);
        var_5 = int(var_8 * var_5);
        break;
      case "sniper":
        if(var_3 == "head" || var_3 == "helmet") {
          var_5 = 250;
        } else {
          var_8 = var_5 / var_4;
          var_5 = _id_2B4A(var_4, var_6, level._id_37FA);
          var_5 = int(var_8 * var_5);
        }

        break;
      case "smg":
        var_8 = var_5 / var_4;
        var_5 = _id_2B4A(var_4, var_6, 3);
        var_5 = int(var_8 * var_5);
        break;
      case "spread":
        if(level._id_2A83 >= 0) {
          var_8 = var_5 / var_4;
          var_5 = min(var_5, level._id_2A83);
          var_5 = int(var_8 * var_5);
        }
      default:
        break;
    }
  }

  return var_5;
}

_id_2BBD(var_0) {
  return istrue(var_0._id_7262) && !istrue(var_0._id_7263);
}

_id_2B4A(var_0, var_1, var_2) {
  var_3 = 0;

  if(var_2 == 4) {
    var_3 = var_1 _meth_877F();
  } else if(var_2 == 3) {
    var_3 = var_1 _meth_877E();
  } else if(var_2 == 2) {
    var_3 = var_1 _meth_877D();
  }

  if(var_3 <= 0) {
    var_3 = var_1._id_02B1;
  }

  if(var_2 == 1 || var_3 <= 0) {
    var_3 = var_1._id_0299;
  }

  if(var_0 < var_3) {
    return int(var_3);
  } else {
    return var_0;
  }
}

_id_AB61(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_1) && var_1 != var_2 && isPlayer(var_1)) {
    if(var_3 >= var_7) {
      var_3 = var_7;
    }

    if(var_3 > 0) {
      var_14 = scripts\mp\utility\weapon::_id_6E6A(var_6);

      if(var_14 == "rock_mp" && isalive(var_2)) {
        var_2 playlocalsound("br_gulag_rock_player_impact");
      }
    }

    var_1 scripts\mp\gametypes\br_public::_id_FC1A("damageDealt", var_1.pers["damage"]);
  }

  if(isDefined(var_6) && scripts\mp\utility\weapon::_id_88F6(var_6)) {
    var_15 = var_3 >= var_7 && scripts\mp\utility\killstreak::_id_6AE7(var_6) == "precision_airstrike";
    var_16 = istrue(var_2.inlaststand);

    if(var_15 && var_16) {
      var_2._id_2B56 = gettime();
    }
  }
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!istrue(level._id_2AA8)) {
    return;
  }
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);

  if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    return;
  }
  var_6 = scripts\mp\utility\game::_id_6B13();

  if(isDefined(level._id_A77C)) {
    if(var_6.size <= level._id_A77C) {
      level thread _id_E6A6(1);
    }
  }

  var_7 = 0;

  foreach(var_9 in level.players) {
    if(isDefined(var_9._id_038F) && var_9._id_038F > var_7) {
      var_7 = var_9._id_038F;
    }
  }

  if(!level.teambased) {
    var_0._id_038F = level._id_F37B - var_6.size;

    foreach(var_9 in var_6) {
      var_9._id_038F = var_0._id_038F + 1;
    }
  }
}

_id_68A2(var_0) {
  var_1 = 0;

  if(istrue(var_0)) {
    foreach(var_3 in level._id_EF89) {
      var_1 = var_1 + scripts\mp\utility\teams::_id_6DCA(var_3, "aliveCount");
    }
  } else {
    foreach(var_3 in level._id_EF89) {
      var_6 = scripts\mp\utility\teams::_id_6DCA(var_3, "aliveCount");

      if(var_6) {
        var_7 = scripts\mp\utility\teams::_id_6DCA(var_3, "alivePlayers");

        foreach(var_9 in var_7) {
          if(isDefined(var_9) && !istrue(var_9._id_7262)) {
            var_1 = var_1 + 1;
          }
        }
      }
    }
  }

  return var_1;
}

_id_4E66(var_0, var_1) {
  if(istrue(level._id_FE76) && var_0 scripts\mp\gametypes\br_public::_id_8990()) {
    return;
  }
  foreach(var_3 in level._id_EF6A[var_0.team]["alivePlayers"]) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 != var_0) {
      var_3 thread scripts\mp\hud_message::showsplash("br_teammate_dead", undefined, var_0);
    }
  }
}

_id_DD10() {
  if(istrue(level._id_FE76) && !istrue(level._id_7262._id_DD08)) {
    var_0 = _id_68A2(0);

    if(var_0 <= getdvarint("#x3822a8f4b39d4b224", -1)) {
      scripts\mp\gametypes\br_gulag::_id_DD0F("player_count", var_0);
    }
  }
}

_id_AB63(var_0) {
  if(!scripts\mp\gametypes\br_gametypes::_id_8853("teamSpectate")) {
    scripts\mp\gametypes\br_spectate::_id_9E8F(var_0, undefined, 0);
  }

  if(istrue(level._id_2AA8)) {
    _id_DD10();
    scripts\mp\gametypes\br_gulag::_id_AB63(var_0);

    if(isDefined(var_0) && istrue(var_0.inlaststand) && scripts\mp\utility\game::_id_6D9E() != "dmz") {
      var_0 scripts\mp\gametypes\br_pickups::_id_5041();

      if(isDefined(var_0._id_9060)) {
        var_0._id_9060 _id_07C3::_id_B6DC();
      }
    }
  }

  var_1 = scripts\mp\utility\teams::_id_6A01(var_0.team);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(scripts\mp\utility\teams::_id_6DCA(var_4, "aliveCount")) {
      var_2[var_2.size] = var_4;
    }
  }

  var_6 = var_2.size + 1;
  scripts\mp\gametypes\br_analytics::_id_2AEA(var_0, int(scripts\mp\utility\player::isreallyalive(var_0)));

  if(isDefined(var_0)) {
    if(_id_07D1::_id_60BE("prematch_done")) {
      [var_8, var_9, var_10] = _id_2EDF(var_6);

      if(var_8 > 0) {
        var_0 _id_6F86(var_8, undefined, "disconnect");
        var_0._id_9BA8 = var_9;
        var_0._id_B16D = var_10;
      }

      var_0 _id_D655(var_6);
      var_0 _id_6FB7(var_6);
      var_0 _id_E902();
      scripts\mp\gamelogic::_id_0CEF(var_0, var_6);
      scripts\mp\gamelogic::_id_BD74(var_0);
    }

    var_0 thread _id_7421(var_6);
  }

  level thread _id_FCF5();
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(istrue(level._id_2AA8)) {
    if(var_3 == "MOD_EXECUTION") {
      self._id_10A11 = 1;
    } else {
      self._id_10A11 = 0;
    }

    scripts\mp\gametypes\br_pickups::_id_5041(var_1);
    _id_4E66(self, var_1);
    _id_DD10();
  }

  scripts\mp\gametypes\br_weapons::_id_29FF();
  scripts\mp\gametypes\br_pickups::_id_C631();
  _id_AB75("kill", var_1, 0, self);

  if(isDefined(self._id_9084)) {
    scripts\mp\utility\outline::outlinedisable(self._id_9084, self);
    self._id_9084 = undefined;
  }

  if(!istrue(level._id_2AA8)) {
    scripts\mp\gametypes\br_plunder::_id_B751(var_3);
    return;
  }

  thread scripts\mp\gametypes\br_quest_util::_id_AB70(var_1, self);
  thread scripts\mp\gametypes\br_respawn::_id_B693(var_1, var_4);

  if(scripts\mp\gametypes\br_gametypes::_id_8792("onPlayerKilled")) {
    var_10 = _id_09BF::_id_ADCA(var_1, self, var_2, var_4, var_3, var_0, undefined, var_5);
    thread scripts\mp\gametypes\br_gametypes::_id_CA24("onPlayerKilled", var_10);
  }

  scripts\mp\gametypes\br_public::_id_D65F(0);
  scripts\mp\gametypes\br_public::_id_D659(0);
  _id_FD3E(self, self, 0, 1);

  if(istrue(self.inlaststand)) {
    if(isPlayer(var_1)) {
      var_1 _id_7DEC();
    }
  }

  if(!istrue(level._id_FE76)) {
    _id_9B84(self);
  }

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    if(isbot(self) && isPlayer(var_1) && !istrue(var_1 scripts\mp\gametypes\br_public::_id_8990())) {
      var_1 notify("killed_enemy");
    }
  }

  level thread _id_FCF5();
}

_id_9B84(var_0) {
  var_0._id_2A63 = 1;
  level notify("br_player_eliminated");
  var_0 _id_FCF8();
  var_0 scripts\mp\gamelogic::_id_FCFA();
}

_id_F997(var_0) {
  var_0._id_2A63 = 0;
  var_0 _id_0A99::_id_D5EA(0);
  var_0 _id_FCF8();
}

_id_FCF8() {
  var_0 = self;
  var_1 = 0;
  var_2 = scripts\mp\utility\teams::_id_6DCA(var_0.team, "players");

  foreach(var_4 in var_2) {
    if(istrue(var_4._id_2A63)) {
      var_1 = var_1 | 1 << var_4._id_2ABC - 1;
    }
  }

  foreach(var_4 in var_2) {
    var_4 setclientomnvar("ui_br_eliminated", var_1);
  }
}

_id_7DEC() {
  var_0 = self;

  if(!isDefined(var_0._id_2A2A)) {
    var_0._id_2A2A = 0;
  }

  var_0._id_2A2A++;
  var_0 scripts\mp\gametypes\br_public::_id_FC1A("cleanups", var_0._id_2A2A);
}

_id_C24E(var_0) {
  level._id_2A95._id_3E9B[level._id_2A95._id_3E9B.size] = var_0;
}

_id_2BE3(var_0) {}

_id_99F5(var_0) {
  var_1 = self._id_4350;

  if(var_1.type == "personal") {
    _id_99FF(var_0);
    return;
  }

  if(var_1.type == "weapon") {
    var_2 = randomintrange(2, 4);
    var_3 = 6 - var_2;
  } else {
    var_2 = randomintrange(1, 2);
    var_3 = 6 - var_2;
  }

  var_4 = 0;

  for(var_5 = 0; var_5 < var_2 && var_4 < level._id_2A95._id_2A3A.size; var_5++) {
    if(isDefined(_id_9A11(var_4))) {
      var_4++;
    }
  }

  for(var_5 = 0; var_5 < var_3 && var_4 < level._id_2A95._id_2A3A.size; var_5++) {
    if(isDefined(_id_99F3(var_4))) {
      var_4++;
    }
  }
}

_id_9A11(var_0) {
  var_1 = scripts\engine\utility::random(level._id_2A95._id_2A2F);
  var_2 = scripts\mp\gametypes\br_pickups::_id_6A5E(var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\engine\utility::_id_5000(self.origin + level._id_2A95._id_2A3A[var_0], 50, -200, (0, 0, 1)) + (0, 0, 24);
  var_4 = scripts\mp\gametypes\br_weapons::_id_4053(var_3, (0, 0, 90), var_2);

  if(isDefined(var_4)) {
    var_4._id_8B06 = 1;
  }

  return var_4;
}

_id_99F3(var_0) {
  var_1 = scripts\engine\utility::_id_5000(self.origin + level._id_2A95._id_2A3A[var_0], 50, -200, (0, 0, 1)) + (0, 0, 12);
  var_2 = scripts\engine\utility::random(level._id_2A95._id_2A30);
  var_3 = var_2;
  var_4 = scripts\mp\gametypes\br_pickups::_id_E336(var_3, var_1, (0, 0, 90), 1);
  return var_4;
}

_id_99FF(var_0) {
  var_1 = self._id_4350;
  var_2 = scripts\engine\utility::_id_5000(self.origin + (0, 0, 6), 50, -200, (0, 0, 1)) + (0, 0, 24);
  var_3 = scripts\mp\gametypes\br_weapons::_id_4054(var_2, var_1._id_B02B);

  if(isDefined(var_3)) {
    var_3._id_8B06 = 1;
    var_0 loadweaponsforplayer([var_1._id_B02B]);
  }

  return var_3;
}

_id_7C8B(var_0, var_1) {}

_id_A91D(var_0) {
  _id_07F9::_id_A8A2(var_0);
}

_id_821A() {
  level._id_2AD3 = [];
  level._id_2AD4 = 0;

  foreach(var_2, var_1 in level._id_2AD3) {
    level._id_2AD4 = level._id_2AD4 + var_1;
  }

  level._id_1D9E = [];
  level._id_2327 = [];
  level._id_1DBC = [];
  level._id_1DBC["holo"] = 1;
  level._id_1DBC["silencer"] = 2;
  level._id_1DBC["gl"] = 2;
}

_id_10DAA(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_4 = var_3.origin[2] - 24;
    var_5 = var_3.origin[2] + 90 - 24;

    if(scripts\engine\utility::_id_4B8C(var_3.origin, var_0.origin) < 147456 && var_0.origin[2] >= var_4 && var_0.origin[2] <= var_5) {
      return 0;
    }
  }

  return 1;
}

_id_E6A6(var_0) {
  if(istrue(level._id_2A34)) {
    return;
  }
  scripts\mp\gamelogic::pausetimer();
  level._id_F23D = gettime();
  level._id_F21A = 1;
}

_id_4501(var_0) {
  if(isDefined(level._id_372C)) {
    _id_484E(level._id_372C);
  }

  level notify("runDebugVFXCircleTest");
  waitframe();

  switch (var_0) {
    case 1:
      level thread _id_CA2F(1000, 0, 15, 2000);
      break;
    case 2:
      level thread _id_CA2F(2500, 1000, 20, 2000);
      break;
    case 3:
      level thread _id_CA2F(4500, 2500, 25, 2000);
      break;
    case 4:
      level thread _id_CA2F(7000, 4500, 40, 2000);
      break;
    case 5:
      level thread _id_CA2F(10500, 7000, 70, 2000);
      break;
    case 6:
      level thread _id_CA2F(15000, 10500, 80, 2000);
      break;
    case 7:
      level thread _id_CA2F(20000, 15000, 80, 2000);
      break;
    case 8:
      level thread _id_CA2F(50000, 20000, 80, 2000);
      break;
  }
}

_id_71EA(var_0) {
  var_1 = scripts\engine\trace::_id_3EE5(0, 1, 0, 0, 1, 1);
  var_2 = var_0 + (0, 0, 10000);
  var_3 = var_2 + (0, 0, -20000);
  var_4 = _func_02C1(var_2, var_3, var_1, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_4) && var_4.size > 0) {
    return var_4[0]["position"];
  }

  return (0, 0, 0);
}

_id_44EA() {
  for(;;) {
    waitframe();

    if(!isDefined(level._id_372A) || !isDefined(level._id_372B)) {
      continue;
    }
    var_0 = distance2d(self.origin, level._id_372A) < level._id_372B;

    if(istrue(self._id_44C0)) {
      if(!var_0 && level._id_44C1 == 0) {
        playFXOnTag(level._effect["vfx_gas_ring_player"], self, "tag_eye");
        level._id_44C1 = 1;
        self._id_44C0 = 0;
      }

      continue;
    }

    if(var_0 && !self._id_44C0) {
      self._id_44C0 = 1;
      stopFXOnTag(level._effect["vfx_gas_ring_player"], self, "tag_eye");
      level._id_44C1 = 0;
    }
  }
}

_id_CA2F(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("runDebugVFXCircleTest");

  if(!istrue(level._id_44C1)) {
    level.players[0] thread _id_44EA();
  }

  var_4 = 5;
  var_5 = level.players[0] _id_71EA(level.players[0].origin);
  level._id_372C = _id_E2C3(var_5, var_0, var_3);
  level._id_372A = var_5;
  wait 0.1;
  _id_E3A1(level._id_372C);
  var_6 = var_2;

  while(var_2 > 0) {
    var_7 = var_2 / var_6;
    var_8 = var_1 + (var_0 - var_1) * var_7;

    if(var_4 < 0) {
      _id_484E(level._id_372C);

      if(var_8 <= 0) {
        return;
      }
      level._id_372B = var_8;
      var_4 = 5;
      level._id_372C = _id_E2C3(var_5, var_8, var_3);
      wait 0.1;
      _id_E3A1(level._id_372C);
    } else
      _id_FC56(var_5, var_8, level._id_372C);

    var_2 = var_2 - level._id_5F3A;
    var_4 = var_4 - level._id_5F3A;
    waitframe();
  }
}

_id_484E(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1])) {
      stopFXOnTag(level._effect["vfx_gas_ring_puffy"], var_0[var_1], "tag_origin");
      var_0[var_1] delete();
    }
  }
}

_id_FC56(var_0, var_1, var_2) {
  var_3 = var_2.size;
  var_4 = 6.2831 * var_1;
  var_5 = 360 / var_3;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_5 * var_6;
    var_8 = sin(var_7) * var_1;
    var_9 = cos(var_7) * var_1;
    var_10 = _id_71EA(var_0 + (var_9, var_8, 0));
    var_2[var_6].origin = var_10;
    var_2[var_6].angles = (0, var_7 + 180, 0);
  }
}

_id_E2C3(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 6.2831 * var_1;
  var_5 = var_4 / var_2;

  if(var_5 < 200) {
    iprintlnbold("Using " + int(var_5) + " emitters");
  } else {
    iprintlnbold("Can't use " + int(var_5) + " emitters, using 200 instead");
  }

  var_5 = min(var_5, 200);
  var_6 = 360 / var_5;

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_8 = var_6 * var_7;
    var_9 = sin(var_8) * var_1;
    var_10 = cos(var_8) * var_1;
    var_11 = _id_71EA(var_0 + (var_10, var_9, 0));
    var_3[var_7] = spawn("script_model", var_11);
    var_3[var_7] setModel("tag_origin");
    var_3[var_7].origin = var_11;
    var_3[var_7].angles = (0, var_8 + 180, 0);
  }

  return var_3;
}

_id_E3A1(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    playFXOnTag(level._effect["vfx_gas_ring_puffy"], var_0[var_1], "tag_origin");
  }
}

_id_44D2() {
  var_0 = scripts\mp\utility\game::_id_6B13();

  foreach(var_2 in var_0) {
    var_2._id_2A85 = var_2._id_2A85 + 5;
  }
}

_id_ABC0() {
  if(isDefined(level._id_A77C)) {
    level thread _id_E6A6(1);
  }

  level._id_A77C = undefined;
}

_id_AB6B(var_0) {
  if(level.teambased) {
    var_1 = [];

    for(var_2 = 1; var_2 < level.maxteamsize + 1; var_2++) {
      var_1[var_1.size] = var_2;
    }

    var_3 = scripts\mp\utility\teams::_id_6DCA(var_0.team, "players");
    var_4 = 1;

    foreach(var_6 in var_3) {
      if(istrue(var_6._id_8793)) {
        var_4 = 0;
      }

      if(isDefined(var_6._id_2ABC)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_6._id_2ABC);
      }
    }

    if(var_1.size == 0) {
      return;
    }
    var_8 = var_1[0];
    var_0 _id_D65B(var_4);
    var_0 _id_D671(var_8);
    return;
  }
}

_id_AAA3(var_0) {
  if(istrue(level._id_2A34) || scripts\mp\utility\game::_id_6D9E() == "dmz") {
    return;
  }
  if(isDefined(var_0) && var_0 != "all") {
    thread _id_ABAC(var_0);
    scripts\mp\gamelogic::_id_457D(var_0);
  }
}

_id_ABAC(var_0) {
  var_1 = scripts\mp\utility\teams::_id_6A01(var_0);
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_6 = scripts\mp\utility\teams::_id_6DCA(var_5, "aliveCount");

    if(var_6) {
      var_2[var_2.size] = var_5;
      var_3 = var_3 + var_6;
    }
  }

  var_8 = var_2.size + 1;
  _func_0427(var_0, var_8);
  scripts\mp\gametypes\br_analytics::_id_2B0B(var_0, var_8);
  [var_10, var_11, var_12] = _id_2EDF(var_8);
  var_13 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");

  foreach(var_15 in var_13) {
    if(isDefined(var_15)) {
      var_15 _id_6F86(var_10, undefined, "squadEliminated");
      var_15._id_9BA8 = var_11;
      var_15._id_B16D = var_12;
    }
  }

  wait 1.5;

  if(var_3 < 5) {
    scripts\mp\gametypes\br_public::_id_2BDC("top_5_lose", 0, var_13, 1);
  } else if(var_3 < 10) {
    scripts\mp\gametypes\br_public::_id_2BDC("top_10_lose", 0, var_13, 1);
  } else if(var_3 < 25) {
    scripts\mp\gametypes\br_public::_id_2BDC("top_25_lose", 0, var_13, 1);
  }

  scripts\mp\gametypes\br_public::_id_2BDC("team_loss", 0, var_13, 1);

  foreach(var_15 in var_13) {
    if(isDefined(var_15)) {
      var_15 thread _id_7421(var_8);
      var_15 _id_D655(var_8);
      var_15 _id_6FB7(var_8);
      var_15 _id_E902();
      scripts\mp\gamelogic::_id_0CEF(var_15, var_8);
      scripts\mp\gamelogic::_id_BD74(var_15);
    }
  }

  _id_D45B(var_0);
}

_id_7421(var_0) {
  var_1 = self;
  var_1 endon("disconnnect");
  var_2 = gettime();
  var_1 setclientomnvar("ui_br_player_position", var_0);

  if(!istrue(var_1._id_2ABB)) {
    var_1 waittill("br_spectatorInitialized");
  }

  var_1 setclientomnvar("ui_br_squad_eliminated_active", 1);
  var_1 setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
  var_1 setclientomnvar("ui_round_end_reason", game["end_reason"]["br_eliminated"]);
  var_1 _id_0A99::_id_D5EA(0);
  var_1 notify("br_team_fully_eliminated");
}

_id_D655(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || istrue(var_1._id_B176)) {
    return;
  }
  var_1._id_B176 = 1;
  var_1._id_EF8C = var_0;

  if(var_0 <= 25) {
    var_1 scripts\mp\utility\stats::_id_7DAE("topTwentyFive", 1);

    if(var_0 <= 10) {
      var_1 scripts\mp\utility\stats::_id_7DAE("topTen", 1);

      if(var_0 <= 5) {
        var_1 scripts\mp\utility\stats::_id_7DAE("topFive", 1);

        if(var_0 == 1) {
          var_1 scripts\mp\utility\stats::_id_7DAE("wins", 1);
        }
      }
    }

    var_1 scripts\mp\gamelogic::_id_FCFA();
  }
}

_id_2EDF(var_0) {
  if(!_id_07D1::_id_60BE("prematch_done")) {
    return 0;
  }

  var_1 = getdvarfloat("#x39eb5fddd8d6c6418", 0.0039);

  if(!isDefined(level._id_E703) || !isDefined(var_0) || !isDefined(level._id_10FD7) || (level._id_E703 <= 0 || var_0 <= 0 || level._id_10FD7 <= 0)) {
    return 0;
  }

  var_2 = gettime() - level._id_E703;
  var_3 = int(var_1 * var_2 + 0.5);
  var_4 = level._id_10FD7 * (level._id_10FDB - var_0 + 1);
  var_5 = var_3 + var_4;
  return [var_5, var_3, var_4];
}

_id_6FB7(var_0) {
  if(!game["timePassed"]) {
    return;
  }
  if(isDefined(self._id_2C2E) && self._id_2C2E == 0) {
    return;
  }
  if(!isDefined(level._id_E6D8) || level._id_E6D8 < var_0) {
    return;
  }
  _id_07BC::_id_AB38(var_0, level._id_E6D8);
  self._id_2C2E = 0;
}

_id_C60C() {
  _id_07BC::_id_C60B("driving");
  _id_07BC::_id_C60B("alive_in_gas");
  _id_07BC::_id_C60B("alive_not_downed");
}

_id_E902() {
  _id_07BC::_id_E901("driving");
  _id_07BC::_id_E901("alive_in_gas");
  _id_07BC::_id_E901("alive_not_downed");
}

_id_6F86(var_0, var_1, var_2) {
  if(!isDefined(self) || isbot(self) || _func_03DA(self)) {
    return;
  }
  if(!game["timePassed"]) {
    return;
  }
  if(!(scripts\mp\utility\game::matchmakinggame() || getdvarint("#x378c3667dfc793afa"))) {
    return;
  }
  if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    return;
  }
  if(isDefined(self._id_2B3E) && self._id_2B3E == 0) {
    return;
  }
  var_3 = 0;
  var_4 = 0;

  if(!isDefined(var_2)) {
    var_2 = "undefined";
  }

  switch (var_2) {
    case "disconnect":
      var_3 = 1;
      var_4 = 1;
      break;
    case "squadEliminated":
      var_3 = 1;
      var_4 = 1;
      break;
    case "endGame":
    case "winner":
      var_3 = 1;
      var_4 = 1;
      break;
    case "undefined":
    default:
      var_3 = 0;
      var_4 = 1;
      break;
  }

  scripts\mp\rank::giverankxp("br_timeXPBonus", var_0, var_1, var_3, var_4);
  scripts\mp\gametypes\br_analytics::_id_2AE3(var_0, var_2);
  self._id_2B3E = 0;
}

_id_D656() {
  var_0 = 545000;
  var_1 = var_0;
  var_2 = max(1, level.maxteamsize);
  var_3 = 0;

  foreach(var_5 in level._id_EF89) {
    if(scripts\mp\utility\teams::_id_6DCA(var_5, "teamCount")) {
      var_3++;
    }
  }

  var_3 = max(1, var_3);
  var_7 = 200;
  var_8 = 25;
  var_9 = int(var_3 * (var_3 + 1) / 2);
  var_9 = max(var_9, 1);
  var_10 = int(var_1 / (var_9 * var_2) + 0.9);
  var_10 = int(clamp(var_10, var_8, var_7));
  var_11 = getdvarint("#x3f4f035ad4017c4ee", var_10);
  level._id_10FD7 = var_11;
  level._id_10FDB = var_3;
  level._id_E703 = gettime();
}

_id_700A(var_0) {
  var_1 = getdvarfloat("#x374a365fde3fe0ab2", 0.002);
  var_2 = self._id_9021;
  var_3 = int(var_0 * var_1);
  _id_6F88("", var_3, var_2, 1, 0);
}

_id_6F88(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || scripts\mp\utility\weapon::_id_88F6(var_2) || scripts\mp\utility\weapon::_id_8AFA(var_2)) {
    return;
  }
  if(isDefined(self.owner) && !isbot(self)) {
    self.owner _id_6F88(var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }
  if(!isDefined(var_1) || var_1 <= 0) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!var_3) {
    _id_0A9F::_id_4B7E(var_1, var_0);
  }

  if(!level.playerxpenabled) {
    return;
  }
  thread _id_107D5(var_0, var_1, var_2, var_4);
}

_id_107D5(var_0, var_1, var_2, var_3) {
  self endon("disconnect");

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!var_3) {
    waitframe();
    scripts\mp\utility\script::_id_1096C();
  }

  var_4 = 0;

  if(!isDefined(var_2) || !_id_0826::_id_10DD2(var_2.basename)) {
    return;
  }
  var_4 = var_1;
  var_4 = var_4 * _id_0826::_id_6E87();
  var_4 = int(var_4);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var_2) && (scripts\mp\utility\weapon::_id_879A(var_2) || scripts\mp\utility\weapon::_id_879C(var_2))) {
      if(!scripts\mp\utility\weapon::_id_897E(var_2) || scripts\mp\utility\game::getgametype() == "br") {
        var_5 = spawnStruct();
        var_5._id_04FE = scripts\mp\utility\weapon::getweaponrootname(var_2);
        var_5.statname = "xp_earned";
        var_5.incvalue = var_4;
        var_5._id_04CC = -1;
        _id_06E2::_id_4C2A("callback_update_weapon_stats", var_5);
      }
    }
  }
}

_id_2EF4(var_0) {
  var_1 = 100;

  if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    var_2 = 0.5;
  } else {
    var_2 = 20;
  }

  var_3 = var_1 + int(var_0 * var_2);
  return var_3;
}

_id_C63A() {
  self endon("disconnect");
  var_0 = gettime();

  if(!istrue(self._id_2ABB)) {
    self waittill("br_spectatorInitialized");
  }

  var_1 = 3;
  var_2 = (gettime() - var_0) / 1000;

  if(var_2 < var_1) {
    wait(var_1 - var_2);
  }

  self setclientomnvar("post_game_state", 0);
}

_id_AB47(var_0) {
  if(istrue(level._id_2A34)) {
    return;
  }
  if(level.teambased) {
    var_1 = scripts\mp\utility\game::_id_6AF7(var_0);

    if(isDefined(var_1)) {
      var_1 scripts\engine\utility::delaythread(0.5, scripts\mp\gametypes\br_public::_id_2BDC, "last_man_standing", 0, [var_1]);
      return;
    }
  } else {
    level._id_902C = scripts\mp\utility\game::_id_6AF7();
    level thread scripts\mp\gamelogic::_id_52F7(level._id_902C, game["end_reason"]["enemies_eliminated"]);
  }
}

_id_ABB3(var_0) {
  if(!level.teambased) {
    var_1 = scripts\mp\utility\game::_id_6B13();
    var_0._id_038F = level._id_F37B - var_1.size;

    foreach(var_3 in var_1) {
      var_3._id_038F = var_0._id_038F + 1;
    }
  }
}

_id_A402() {
  if(isDefined(level._id_5E90)) {
    return scripts\mp\gametypes\br_public::_id_878D() && level._id_5E90;
  }

  return 0;
}

_id_2BAA(var_0, var_1) {
  if(level.gameended) {
    return;
  }
  level._id_60BD = gettime();
  level.gameended = 1;
  level notify("game_ended");

  if(scripts\mp\gametypes\br_public::_id_8805()) {
    if(var_1 == 25) {
      level._id_2A3F = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("DMZTut", "empty")) {
        var_2 = scripts\cp_mp\utility\script_utility::getsharedfunc("DMZTut", "empty");
        level._id_2A3C = var_2;
      }
    } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("DMZTut", "endGameVO"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("DMZTut", "endGameVO")]]();
  }

  scripts\mp\gametypes\br_gulag::_id_DD0F("end_game", 0, 1);

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    level._id_60C6 = 1;
  }

  scripts\mp\gametypes\br_vehicles::_id_51C9();

  if(_id_A402()) {
    scripts\mp\gamelogic::_id_52FD(var_0, var_1, game["end_reason"]["br_eliminated"]);
    return;
  }

  _func_01EA("ui_br_transition_type", 0);
  var_3 = undefined;

  if(isDefined(var_0) && var_0 != "tie") {
    _id_10E5D();
    var_3 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
    var_4 = 1;

    if(scripts\mp\gametypes\br_public::_id_8805() && scripts\engine\utility::is_equal(var_1, 25)) {
      var_4 = 0;
    }

    if(var_4) {
      scripts\mp\gametypes\br_public::_id_2BDC("team_victory", 0, var_3);
    }

    [var_6, var_7, var_8] = _id_2EDF(1);

    foreach(var_10 in var_3) {
      if(!isDefined(var_10)) {
        continue;
      }
      if(istrue(var_10.inlaststand)) {
        if(var_10 _id_07E8::_id_5B1D("self_revive_on_kill_success", var_10)) {
          var_10 _id_07E8::_id_AB8D(1);
        }
      }

      if(istrue(var_10._id_82E8)) {
        var_10 thread _id_0A00::_id_1B2F();
      }

      var_10 scripts\mp\gametypes\br_gulag::_id_7267();
      var_10._id_E355 = 1;
      var_10 setclientomnvar("ui_br_player_position", 1);
      var_10 _id_6F86(var_6, undefined, "winner");
      var_10._id_9BA8 = var_7;
      var_10._id_B16D = var_8;
      scripts\mp\gametypes\br_analytics::_id_2AF7(var_10, "player_win");
      var_10 _id_D655(1);
      var_10 _id_6FB7(1);
      var_10 _id_E902();
      scripts\mp\gamelogic::_id_0CEF(var_10, 0);
      var_10 scripts\mp\gamelogic::_id_FCFA();
      scripts\mp\gamelogic::_id_BD74(var_10);

      if(var_10 _meth_8685()) {
        var_10 setclientomnvar("nVidiaHighlights_events", 24);
      }

      if(scripts\mp\gametypes\br_public::_id_878D() && !isbot(var_10)) {
        var_10 thread[[level._id_52A2]]();
      }
    }

    _id_D45B(var_0);
  } else {
    var_12 = [];

    foreach(var_14 in level._id_EF89) {
      if(scripts\mp\utility\teams::_id_6DCA(var_14, "aliveCount")) {
        var_12[var_12.size] = var_14;
      }
    }

    var_16 = var_12.size;
    [var_6, var_7, var_8] = _id_2EDF(var_16);

    foreach(var_10 in level.players) {
      if(!isDefined(var_10)) {
        continue;
      }
      if(isbot(var_10) || _func_03DA(var_10)) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_10)) {
        continue;
      }
      var_10 _id_6F86(var_6, undefined, "endGame");
      var_10 _id_6FB7(var_16);
      var_10 _id_E902();
      var_10._id_E355 = 1;
      var_10 setclientomnvar("ui_br_player_position", 1);
    }

    foreach(var_14 in var_12) {
      _id_D45B(var_14);
    }
  }

  var_22 = undefined;

  if(isDefined(var_3)) {
    var_22 = scripts\mp\gametypes\br_ending::_id_63BB(var_3);
  }

  var_23 = scripts\mp\gametypes\br_quest_util::_id_6E30(level.players, level._id_BEAF._id_45B2);
  scripts\mp\gametypes\br_analytics::_id_2AEF(var_23);
  level thread scripts\mp\gametypes\br_analytics::_id_2AF0();
  wait 1.5;

  if(isDefined(level._id_2A3C)) {
    level thread[[level._id_2A3C]](var_0);
  } else {
    level thread _id_7440(var_0);

    if(isDefined(level._id_2A3F)) {
      wait(level._id_2A3F);
    }
  }

  if(scripts\mp\gametypes\br_public::_id_8805()) {
    if(isDefined(level._id_4BD9)) {
      level thread[[level._id_4BD9]](var_0, var_1, game["end_reason"]["br_eliminated"]);
      return;
    }
  }

  if(isDefined(var_3) && isDefined(var_22)) {
    scripts\mp\gametypes\br_ending::_id_B21F(var_3, var_22);
  }

  scripts\mp\gamelogic::_id_52FD(var_0, var_1, game["end_reason"]["br_eliminated"]);
}

_id_10E5D(var_0) {}

_id_7440(var_0) {
  var_1 = [];

  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  }

  var_2 = scripts\mp\gamelogic::_id_692B();

  if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    foreach(var_4 in var_1) {
      var_4 setclientomnvar("post_game_state", var_2);
      var_4 setclientomnvar("ui_br_end_game_splash_type", 1);
    }
  }
}

_id_2B57(var_0, var_1) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "dpad_slot_down":
        if(scripts\mp\gametypes\br_public::_id_8805() && var_1 == 0) {
          if(isDefined(level._id_4BD8)) {
            self thread[[level._id_4BD8]](var_0, var_1);
          }

          break;
        }

        thread scripts\mp\gametypes\br_pickups::_id_BEEB(var_1);
        break;
      case "dpad_slot_up":
        scripts\mp\gametypes\br_pickups::_id_FE86(var_1);
        break;
      case "dpad_perk_buy":
        scripts\mp\gametypes\br_perks::_id_2DE4(var_1);
        break;
      case "dpad_mayday":
        thread _id_078A::_id_2FAB();
        break;
      case "try_use_heal_slot":
        var_2 = var_1;
        scripts\mp\gametypes\br_pickups::_id_B80C(var_2);
        break;
      case "br_drop_all":
        if(scripts\mp\gametypes\br_public::_id_8805() && var_1 == 0) {
          if(isDefined(level._id_4BD8)) {
            self thread[[level._id_4BD8]](var_0, var_1);
          }

          break;
        }

        scripts\mp\gametypes\br_pickups::_id_BEE4(var_1);
        break;
      default:
        break;
    }
  }
}

_id_6516(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return int(var_0);
}

_id_AE28() {
  if(_id_2B55() && !_id_2B0F() && !istrue(self._id_500E) && !istrue(level._id_BB76)) {
    if(scripts\mp\gametypes\br_public::_id_898B()) {
      thread scripts\mp\gametypes\br_rewards::_id_E29D();

      foreach(var_1 in level._id_EF6A[self.team]["players"]) {
        var_1._id_500E = 1;
      }
    }
  }

  if(_id_07D1::_id_60BE("prematch_done")) {
    thread scripts\mp\gametypes\br_armory_kiosk::_id_DC99(5);
  }
}

_id_E30E(var_0, var_1) {
  scripts\mp\playerlogic::_id_D6DD();
  scripts\mp\utility\player::_freezecontrols(1);
  scripts\mp\utility\player::_id_FD26("intermission");
  scripts\mp\utility\player::_id_394E();
  self._id_5FA4 = undefined;
  self spawn(var_0, var_1);
  scripts\mp\utility\player::_id_BD21("playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + var_0);
  scripts\mp\utility\player::_id_D52A();
  scripts\mp\utility\player::_freezecontrols(1);
}

_id_2C38(var_0) {
  if(!isDefined(self._id_BBED) || self _meth_878F()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  thread _id_2C39();

  if(!isDefined(self._id_81F4)) {
    var_1 = self._id_BBED.origin;
    var_2 = scripts\mp\gametypes\br_public::_id_B7E5(var_1);
    var_3 = getdvarint("#x33a3102ef5917fa11", 9000);
    scripts\mp\gametypes\br_public::_id_B7E6(var_2, var_3, 1);
    self setclientomnvar("ui_br_transition_type", 4);
    wait 0.5;
    _id_E30E(var_2, self._id_BBED.angles);
    _id_081A::_id_D512();
    self freezecontrols(1);
  } else
    self._id_81F4 = undefined;

  scripts\mp\gametypes\br_public::_id_B817();
  self freezecontrols(0);
}

_id_2C39() {
  self endon("disconnect");
  self waittill("brWaitAndSpawnClientComplete");
  self _meth_8283();
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

_id_2C35() {
  self._id_0267++;
}

_id_2BFE(var_0) {
  if(!_id_07D1::_id_60BE("prematch_done")) {
    self.pers["damage"] = self.pers["damage"] + var_0;
  }
}

_id_2B4C() {
  foreach(var_1 in level.players) {
    var_1._id_0267 = 0;
    var_1.pers["kills"] = 0;
    var_1._id_038F = 0;
    var_1.pers["score"] = 0;
    var_1._id_2BEE = 0;
    var_1.pers["contracts"] = 0;
    var_1 scripts\mp\gametypes\br_public::_id_FC1A("missionsCompleted", 0);
    var_1.pers["damage"] = 0;
    var_1 scripts\mp\gametypes\br_public::_id_FC1A("damageDealt", 0);
  }
}

_id_2B4D(var_0) {
  level endon("game_ended");
  var_1 = _func_03C0(undefined, undefined, undefined, undefined, "door");
  var_2 = 0;
  var_3 = isDefined(var_0) && isint(var_0);

  foreach(var_5 in var_1) {
    if(!var_5 _meth_8728()) {
      var_5 _meth_873D();

      if(var_3) {
        var_2++;

        if(var_2 >= var_0) {
          var_2 = 0;
          waitframe();
        }
      }
    }
  }
}

_id_B798() {
  self endon("death_or_disconnect");
  self endon("last_stand_start");
  self endon("halo_kick_c130");
  level endon("game_ended");
  level endon("end_spawn_selection");
  self setclientomnvar("ui_options_menu", 2);
  var_0 = "custom1";
  self.pers["class"] = var_0;
  self.class = var_0;
  scripts\mp\class::_id_BB98(var_0);

  for(;;) {
    self waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "exit_loadout_bag") {
      return 0;
    } else if(var_1 != "class_select") {
      continue;
    }
    var_3 = 0;

    if(var_2 >= 0) {
      var_4 = _id_07F2::_id_6960(var_2);
      self.pers["class"] = var_4;
      self.class = var_4;
      scripts\mp\class::_id_BB98(var_4);
      var_3 = 1;
    }

    self setclientomnvar("ui_options_menu", 0);
    return var_3;
  }
}

_id_B79A() {
  var_0 = self;
  var_0._id_8A5D = undefined;
  var_0._id_2A61 = 0;
  var_0 endon("disconnect");
  scripts\mp\gametypes\br_vehicles::_id_51C9();
  var_1 = 1.0;
  var_2 = scripts\mp\gametypes\br_infils::_id_6D58();
  var_3 = getdvarint("#x35e9ad9b1ee4858e1", 25);
  var_4 = var_2 + 0.5 + var_3;
  var_0 thread scripts\mp\gametypes\br_infils::_id_7E62(var_1, var_4, 1);
  wait(var_1);
  var_0 freezecontrols(1);
  var_0 thread _id_A11D();

  if(_id_2B54()) {
    var_0 _id_B798();
  }

  var_0 _id_B799();
  var_0 setclientomnvar("ui_options_menu", 0);
  var_0 freezecontrols(0);
}

_id_B7E1() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 freezecontrols(1);

  if(_id_2B54()) {
    var_0 _id_B798();
  }

  var_0 setclientomnvar("ui_options_menu", 0);
  var_0 freezecontrols(0);
}

_id_B799() {
  var_0 = self;
  var_0 _meth_8026(0, 0, 0, 0, 4);

  while(!_id_07D1::_id_60BE("end_spawn_selection")) {
    var_1 = _id_108BB("confirm_location_alt", "cancel_location");

    if(!isDefined(var_1) || var_1._id_EA52 == "cancel_location") {
      continue;
    }
    waittillframeend;
    scripts\mp\gametypes\br_infils::_id_745D(var_1);
    waitframe();
  }

  var_0 _meth_80E7();
}

_id_A11D() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 thread _id_9549();
  var_1 = 0;

  while(!_id_07D1::_id_60BE("end_spawn_selection")) {
    var_2 = var_0 scripts\engine\utility::_id_1088C(var_0, "attempt_jumpmaster_claim", var_0, "squad_jumpmaster_claimed", level, "end_spawn_selection");

    if(var_2 == "attempt_jumpmaster_claim") {
      if(!var_1) {
        var_0 scripts\mp\gametypes\br_public::_id_FC1A("jumpMasterState", 2);
        var_0._id_8A5D = 1;
        var_0 _id_0A99::_id_D5EA(48);
        var_3 = scripts\mp\utility\teams::_id_6A59(var_0.team, 0);

        foreach(var_5 in var_3) {
          if(var_5 != var_0) {
            var_5._id_8A5D = 0;
            var_5 scripts\mp\gametypes\br_public::_id_FC1A("jumpMasterState", 0);
            var_5 notify("squad_jumpmaster_claimed");
            var_5 _id_0A99::_id_D5EA(49);
          }
        }
      } else {
        var_0 scripts\mp\gametypes\br_public::_id_FC1A("jumpMasterState", 1);
        var_0 _id_0A99::_id_D5EA(53);
      }

      continue;
    }

    if(var_2 == "squad_jumpmaster_claimed") {
      var_1 = 1;
    }
  }
}

_id_9549() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("listenClaimJumpMaster");
  var_0 endon("listenClaimJumpMaster");
  level endon("end_spawn_selection");

  for(;;) {
    var_0 waittill("luinotifyserver", var_1);

    if(var_1 == "attempt_jumpmaster_claim") {
      var_0 notify("attempt_jumpmaster_claim");
    }
  }
}

_id_D0BB() {
  var_0 = self;
  var_0._id_2A61 = 1;
  var_0 setclientomnvar("ui_br_infil_started", 1);
  var_0 setclientomnvar("ui_br_infiled", 1);
  var_0 playershow(1);
  var_0 _meth_81FA();
}

_id_2A36() {
  self endon("disconnect");
  self setclientomnvar("ui_br_display_perk_info", 1);
  wait 0.1;
  self setclientomnvar("ui_br_display_perk_info", 0);
}

_id_2A4F(var_0, var_1) {
  var_0._id_6DF0 = 1;
  var_2 = undefined;

  if(isDefined(var_0._id_BB9A)) {
    var_2 = var_0._id_BB9A;
    var_0._id_BB9A = undefined;
  } else {
    var_2 = var_0 scripts\mp\class::_id_962A();
    var_2 = var_0 scripts\mp\class::_id_963A(var_2, var_0.class);
  }

  var_0._id_3808 = var_2;
  var_3 = istrue(var_0.inlaststand);
  var_4 = _id_2A2B(var_0, var_1);
  var_0._id_BC6C = undefined;
  var_0 scripts\mp\class::_id_961E();
  var_0 scripts\mp\class::_id_9653(var_2);
  _id_6FAF(var_0);

  if(isDefined(var_0._id_3808._id_9699)) {
    scripts\mp\gametypes\br_weapons::_id_2A47(var_0, var_0._id_3808._id_9699, var_0._id_3808._id_9697, var_0._id_3808._id_9692);
  }

  if(isDefined(var_0._id_3808._id_968A)) {
    scripts\mp\gametypes\br_weapons::_id_2A47(var_0, var_0._id_3808._id_968A, var_0._id_3808._id_9688, var_0._id_3808._id_9683);
  }

  var_5 = [];

  if(isDefined(var_0._id_3808._id_966A)) {
    var_5[var_5.size] = var_0._id_3808._id_966A;
  }

  if(isDefined(var_0._id_3808._id_966B)) {
    var_5[var_5.size] = var_0._id_3808._id_966B;
  }

  foreach(var_7 in var_5) {
    if(isDefined(level._id_2A95._id_2A43[var_7])) {
      var_8 = level._id_2A95._id_2A43[var_7];
      scripts\mp\gametypes\br_pickups::_id_2A46(var_0, var_8, 1);

      if(isDefined(var_4._id_5591) && var_4._id_5591.type == var_8) {
        scripts\mp\gametypes\br_pickups::_id_989B(var_4._id_5591, undefined, "visible", var_0, 1);
      } else if(isDefined(var_4._id_5592) && var_4._id_5592.type == var_8) {
        scripts\mp\gametypes\br_pickups::_id_989B(var_4._id_5592, undefined, "visible", var_0, 1);
      }
    }
  }

  var_0._id_6DF0 = 0;
  var_0 notify("giveLoadout");
  var_0 thread _id_2A36();

  if(var_3) {
    var_10 = var_0 getcurrentprimaryweapon();

    if(!isweapon(var_10)) {
      var_10 = makeweapon(var_10);
    }

    self._id_9083 = var_10;
    var_11 = var_0 _id_2B44();

    if(!isweapon(var_11)) {
      var_11 = makeweapon(var_11);
    }

    var_0 _id_07E8::_id_6FB0(var_11);

    if(!var_0 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
      var_0 scripts\mp\utility\perk::_id_6FC2("specialty_pistoldeath");
    }
  }
}

_id_2A2B(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_5027 = 0;
  var_2._id_10DC0 = [];
  var_2._id_5591 = undefined;
  var_2._id_5592 = undefined;

  foreach(var_4 in var_0._id_019F) {
    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_4.basename);

    if(var_5 != "s4_me_fists" && var_5 != "iw8_knifestab") {
      if(isweapon(var_4) && var_4._id_0241 == "primary") {
        if(istrue(var_1)) {
          [var_7, var_8, var_9] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_2._id_5027, var_0.origin, var_0.angles, var_0);
          var_10 = scripts\mp\gametypes\br_weapons::_id_3FC1(var_4, var_7, var_8, 0, 1, var_9);

          if(isDefined(var_10)) {
            var_10._id_011A = var_0 getweaponammoclip(var_4);
            var_2._id_5027++;
            var_2._id_10DC0[var_2._id_10DC0.size] = var_10;
          }
        }

        var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);
      }
    }
  }

  if(isDefined(var_0.equipment["primary"])) {
    if(istrue(var_1)) {
      var_12 = var_0 scripts\mp\equipment::_id_6A15("primary");
      var_13 = scripts\engine\utility::_id_1BAB(level._id_2A95._id_2A42, var_0.equipment["primary"]);

      if(isDefined(var_13) && var_12 > 0) {
        [var_7, var_8, var_9] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_2._id_5027, var_0.origin, var_0.angles, var_0);
        var_10 = scripts\mp\gametypes\br_pickups::_id_E336(var_13, var_7, var_8, var_12, 1, var_9);

        if(isDefined(var_10)) {
          var_2._id_5027++;
          var_2._id_5591 = var_10;
        }
      }
    }

    var_0 scripts\mp\equipment::_id_EDBD("primary");
  }

  if(isDefined(var_0.equipment["secondary"])) {
    if(istrue(var_1)) {
      var_12 = var_0 scripts\mp\equipment::_id_6A15("secondary");
      var_13 = scripts\engine\utility::_id_1BAB(level._id_2A95._id_2A42, var_0.equipment["secondary"]);

      if(isDefined(var_13) && var_12 > 0) {
        [var_7, var_8, var_9] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_2._id_5027, var_0.origin, var_0.angles, var_0);
        var_10 = scripts\mp\gametypes\br_pickups::_id_E336(var_13, var_7, var_8, var_12, 1, var_9);

        if(isDefined(var_10)) {
          var_2._id_5027++;
          var_2._id_5592 = var_10;
        }
      }
    }

    var_0 scripts\mp\equipment::_id_EDBD("secondary");
  }

  var_0 giveweapon(makeweapon("s4_me_fists_mp"));
  return var_2;
}

_id_2AB2() {
  self endon("disconnect");
  self freezecontrols(1);
  self setclientomnvar("ui_open_loadout_bag", 1);
  var_0 = _id_B798();
  self setclientomnvar("ui_options_menu", 0);
  self setclientomnvar("ui_open_loadout_bag", 0);
  self freezecontrols(0);
  return var_0;
}

_id_2A4E(var_0) {
  var_1 = var_0 _id_2AB2();

  if(istrue(var_1)) {
    scripts\cp_mp\killstreaks\airdrop::_id_2BE4(var_0);
  } else {
    return;
  }

  _id_2A4F(var_0, 1);
  var_2 = scripts\engine\utility::ter_op(_func_010D(var_0.class, "custom"), 1, 0);
  var_0 _id_07BC::_id_AB27(var_2);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::_id_2AEE(var_0, self.origin, self);
    scripts\mp\gametypes\br_analytics::_id_2AF7(var_0, "dropbag_used");
  }
}

_id_2C21(var_0) {
  level notify("dropbag_kill_callout_" + self.origin);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::_id_2AED(self.team, self.origin);
  }
}

_id_387F() {
  if(!getdvarint("#x3636347a4c8744c76", 0)) {
    return;
  }
  level waittill("br_circle_started");

  while(level._id_2A95._id_3E9B.size > 0) {
    var_0 = [];

    foreach(var_2 in level._id_2A95._id_3E9B) {
      if(isDefined(var_2) && (!isDefined(var_2._id_4143) || var_2._id_4143 == 0)) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::_id_4843();
        continue;
      }

      var_0[var_0.size] = var_2;
    }

    level._id_2A95._id_3E9B = var_0;
    var_0 = undefined;
    wait 1.0;
  }
}

_id_2B44() {
  var_0 = self;
  var_1 = var_0 scripts\mp\gametypes\br_public::_id_B6B7();

  if(!isDefined(var_1)) {
    var_1 = "s4_gunless";
  }

  return var_1;
}

_id_B6A6(var_0) {
  scripts\mp\gametypes\br_gulag::_id_B6A6(var_0);
}

_id_8AE6(var_0) {
  var_1 = var_0.attacker;

  if(!isDefined(var_1)) {
    return 0;
  }

  if(istrue(var_0._id_1D2B)) {
    return 0;
  }

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    return 0;
  }

  return 1;
}

_id_2C44(var_0) {
  if(!_id_8AE6(var_0)) {
    var_0._id_4D02 = 0;
  }

  if(!var_0._id_4D02) {
    var_0._id_103C2 _meth_8283();
  }

  if(!scripts\mp\gametypes\br_gametypes::_id_8853("teamSpectate")) {
    scripts\mp\gametypes\br_spectate::_id_9E8F(var_0._id_103C2, var_0.attacker, 1);
  }
}

_id_87BE(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(istrue(var_0._id_7262)) {
    return 0;
  }

  if(istrue(var_0.inlaststand)) {
    return 0;
  }

  return 1;
}

_id_6DC8(var_0) {
  var_1 = [];
  var_2 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");

  foreach(var_4 in var_2) {
    if(_id_87BE(var_4)) {
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

_id_AB10(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_public::_id_B6B7();

  if(_id_87BE(var_1) && !isDefined(var_2)) {
    var_3 = _id_6DC8(var_1.team);

    if(var_3.size < 2 && !istrue(level._id_907A)) {
      if(var_1 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
        var_1 scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
      }
    }

    var_1 scripts\mp\gametypes\br_armor::_id_2B95();
  }
}

_id_2C37(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1) && var_1 != var_2 && var_3 >= var_2.health) {
    _id_AB10(var_1, var_2);
  }
}

_id_2BB9(var_0) {
  switch (var_0) {
    case "nothing":
      return 0;
    case "noammo":
      return 1;
    case "limitedammo":
      return 2;
    case "standardammo":
      return 3;
    case "dropbag":
      return 4;
    case "dropbagtime":
      return 5;
    case "pistolarmordropbagtime":
      return 6;
    case "pistolarmor":
      return 7;
    case "altmodegoldengun":
      return 8;
    default:
      return 0;
  }
}

_id_2BD4() {
  var_0 = "pistolarmordropbagtime";
  var_1 = getDvar("#x3ad56e0d30902a57a", var_0);
  var_2 = _id_2BB9(var_1);
  level._id_2A74 = var_2;
}

_id_2B54() {
  return isDefined(level._id_2A74) && (level._id_2A74 == 1 || level._id_2A74 == 2 || level._id_2A74 == 3);
}

_id_2B55() {
  return isDefined(level._id_2A74) && (level._id_2A74 == 4 || level._id_2A74 == 5 || level._id_2A74 == 6);
}

_id_2B0F() {
  return isDefined(level._id_2A74) && (level._id_2A74 == 5 || level._id_2A74 == 6);
}

_id_2BB8() {
  var_0 = [];

  if(!isDefined(level._id_2A73)) {
    var_0[var_0.size] = 1;
    return var_0;
  }

  var_1 = scripts\mp\gametypes\br_gametypes::_id_692C("dropBagDelay");

  if(isDefined(var_1)) {
    var_0[var_0.size] = var_1;
    return var_0;
  }

  var_2 = -15;
  var_3 = scripts\mp\gametypes\br_circle::_id_6959(0);
  var_4 = max(0, var_3 + var_2);
  var_5 = getdvarfloat("#x314a6c6ac9b67d89b", var_4);
  var_0[var_0.size] = var_5;

  if(getdvarint("#x3115fd14bd986bb1d", 0) && !scripts\mp\gametypes\br_gametypes::_id_8854("dropBagLoop")) {
    var_6 = 15;
    var_7 = scripts\mp\gametypes\br_gulag::_id_6DEC();
    var_8 = max(0, var_7 + var_6);
    var_9 = getdvarfloat("#x3749ed723d3cdd1eb", var_8);
    var_0[var_0.size] = var_9;
  }

  return var_0;
}

_id_2B53() {
  return isDefined(level._id_2A74) && (level._id_2A74 == 6 || level._id_2A74 == 7 || level._id_2A74 == 8);
}

_id_2BBA() {
  switch (level._id_2A74) {
    case 8:
    case 7:
    case 6:
      return 0;
    default:
  }
}

_id_2B52() {
  return isDefined(level._id_2A74) && (level._id_2A74 == 1 || level._id_2A74 == 2 || level._id_2A74 == 3);
}

_id_2BB7() {
  if(isDefined(level._id_2A74)) {
    if(level._id_2A74 == 2) {
      return 0.5;
    } else if(level._id_2A74 == 3) {
      return 1.0;
    }
  }

  return 0.0;
}

_id_2BB6() {
  if(isDefined(level._id_2A74)) {
    if(level._id_2A74 == 2) {
      return 20;
    }
  }

  return;
}

_id_2C3B() {
  foreach(var_1 in level.players) {
    if(isPlayer(var_1) && var_1 scripts\mp\utility\player::_id_88C7()) {
      var_1 notify("abort_killcam");
      var_1._id_315D = 1;
    }
  }
}

_id_2BBE(var_0) {
  var_1 = getdvarint("#x31d1df4fa84452957", 30);

  if(var_1 > var_0) {
    var_1 = var_0;
  }

  wait(var_0 - var_1);
  level._id_15CA = 0;
  wait(var_1 / 2.0);
  _id_2C3B();
  wait(var_1 / 2.0);
}

_id_E286(var_0) {
  self endon("disconnect");

  if(scripts\mp\gametypes\br_public::_id_8B00(self)) {
    self notify("attempted_spawn");
    scripts\mp\gametypes\br_gulag::_id_54D8(self);
    self._id_10849 = 0;
  } else if(scripts\mp\gametypes\br_public::_id_8A02(self) || istrue(scripts\mp\gametypes\br_gametypes::_id_CA24("spawnHandled", self))) {
    self notify("attempted_spawn");
    self._id_10849 = 0;
  } else if(!scripts\mp\playerlogic::_id_9CCD()) {
    waitframe();
    self notify("attempted_spawn");

    if(istrue(level._id_DEC7)) {
      if(isDefined(level._id_2BDB)) {
        self thread[[level._id_2BDB]]();
      }

      return;
    }
  } else {
    if(istrue(var_0)) {
      level._id_DEC7 = 0;
    }

    if(istrue(level._id_DEC7)) {
      if(isDefined(level._id_2BDB)) {
        self thread[[level._id_2BDB]]();
      }

      return;
    }

    if(!istrue(level._id_29F6)) {
      self.class = _id_B067();
    }

    var_1 = getdvarint("#x3371d4bef16dd2e28", 1);
    var_2 = var_1 && _id_FE58() && !isbot(self);

    if(var_1 > 1) {
      var_2 = var_2 && !istrue(self._id_75B4);
    }

    if(var_2) {
      self._id_BBED = _id_6D4A(var_2);
    }

    scripts\mp\playerlogic::_id_107DC(var_0);
    self freezecontrols(1);

    if(_id_FE58()) {
      thread _id_BBA2();
    }

    waitframe();
    self _meth_86B2(0);
    self _meth_86B3(0);
    var_3 = !self _meth_878F();

    if(var_3) {
      while(isalive(self) && isDefined(self.weaponlist) && !self _meth_851A(self.weaponlist)) {
        waitframe();
      }
    }

    self notify("brWaitAndSpawnClientComplete");
    self._id_10849 = 0;
    self freezecontrols(0);
  }
}

_id_B6A3() {
  if(_id_0790::_id_755D()) {
    self._id_CB4A = self._id_5705;
    _id_0790::_id_0B9E();
    self _meth_86C4();
  }
}

_id_B6A4() {
  if(isDefined(self._id_CB4A)) {
    _id_0790::_id_0C12(self._id_CB4A);
    self _meth_86C5();
    self._id_CB4A = undefined;
  }
}

_id_10AF5() {
  level endon("game_ended");
  self notify("br_squad_leader_shift");
  self endon("br_squad_leader_shift");
  var_0 = self;
  var_1 = var_0.team;

  for(;;) {
    var_2 = "";

    if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
      var_2 = var_0 scripts\engine\utility::_id_1089F("disconnect", "br_pass_squad_leader");
    } else {
      var_2 = var_0 scripts\engine\utility::_id_108A1("death", "disconnect", "remove_from_alive_count", "br_pass_squad_leader");
    }

    if(var_2 == "br_pass_squad_leader") {
      if(!_id_EF75(var_1)) {
        var_0 playlocalsound("br_pickup_deny");
        continue;
      }
    }

    if(var_2 != "disconnect") {
      if(!_id_07D1::_id_60BE("prematch_done")) {
        continue;
      }
      if(!istrue(var_0._id_2A61)) {
        continue;
      }
    }

    if(var_0 _id_0E00(var_1)) {
      return;
    }
  }
}

_id_D671(var_0) {
  var_1 = self;
  var_1._id_2ABC = var_0;
  var_2 = var_1._id_01F1 & 65528;
  var_2 = var_2 | var_0;
  var_1._id_01F1 = var_2;
}

_id_D65B(var_0) {
  var_1 = self;

  if(var_0 == var_1 scripts\mp\gametypes\br_public::_id_898B()) {
    return;
  }
  var_1._id_8793 = var_0;

  if(var_0) {
    var_1._id_01F1 = var_1._id_01F1 | 256;
    var_1 thread _id_10AF5();
  } else
    var_1._id_01F1 = var_1._id_01F1 &~256;
}

_id_0E00(var_0) {
  var_1 = self;

  if(!isDefined(var_0)) {
    var_0 = var_1.team;
  }

  if(isDefined(var_1) && !var_1 scripts\mp\gametypes\br_public::_id_898B()) {
    return 0;
  }

  if(isDefined(var_1)) {
    var_1._id_7592 = 1;
  }

  var_2 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  var_3 = 0;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    var_7 = _id_B66A(var_6);

    if(var_7 > var_3) {
      var_3 = var_7;
      var_4 = var_6;
    }
  }

  var_9 = 0;

  if(isDefined(var_4)) {
    if(isDefined(var_1)) {
      var_1 _id_D65B(0);
    }

    var_4 _id_D65B(1);
    var_9 = 1;
    level scripts\mp\gametypes\br_public::_id_2BDD("deploy_squad_leader", var_4, 1, 0);
  }

  _id_FD3C(var_0);
  return var_9;
}

_id_EF75(var_0) {
  var_1 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4) || var_4 scripts\mp\gametypes\br_public::_id_898B()) {
      continue;
    }
    if(!isalive(var_4)) {
      continue;
    }
    if(var_4 _meth_81D3() || var_4 _meth_8605()) {
      continue;
    }
    if(var_4 scripts\mp\gametypes\br_public::_id_8990()) {
      continue;
    }
    if(!istrue(var_4._id_7592)) {
      var_2 = 1;
      break;
    }
  }

  return var_2;
}

_id_FD3C(var_0) {
  var_1 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  var_2 = _id_EF75(var_0);

  foreach(var_4 in var_1) {
    var_4 setclientomnvar("ui_br_squad_leader_can_pass", var_2);
  }
}

_id_B66A(var_0) {
  if(!isDefined(var_0) || var_0 scripts\mp\gametypes\br_public::_id_898B() || var_0 _meth_81D3() || var_0 _meth_8605() || !isalive(var_0)) {
    return 0;
  }

  if(var_0 scripts\mp\gametypes\br_public::_id_8990()) {
    return 1;
  }

  if(istrue(var_0.inlaststand)) {
    return 2;
  }

  if(istrue(var_0._id_7592)) {
    return 3;
  }

  return 4;
}

_id_EFAD(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\utility\teams::_id_6DCA(var_2, "players");

  foreach(var_6 in var_4) {
    if(!istrue(var_6._id_7262)) {
      var_6 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
    }
  }
}

_id_D6FF(var_0) {
  self._id_8A77 = var_0;

  if(!var_0) {
    _id_534D();
  } else {
    var_1 = scripts\mp\supers::getcurrentsuper();

    if(isDefined(var_1)) {
      var_2 = var_1._id_E76B._id_04F6;
      var_3 = self getweaponammoclip(var_2);
      self._id_4AEF = var_3;
    }

    self notify("super_disable_start");
    thread scripts\mp\supers::_id_10C0B();
  }
}

_id_534D() {
  var_0 = "super_delay_mp";
  var_1 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_1)) {
    var_2 = var_1._id_E76B._id_04F6;
    var_3 = 0;

    if(isDefined(self._id_4AEF)) {
      var_3 = self._id_4AEF;
      self._id_4AEF = undefined;
    }

    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    self setweaponammoclip(var_2, var_3);
    self _meth_84E9(var_2);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
  }

  self notify("super_disable_end");
}

_id_ABB4(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = scripts\mp\gametypes\br_weapons::_id_2A07(var_3);

    if(var_3._id_0245 && scripts\mp\utility\weapon::_id_1DA5(var_3._id_04B7) == "ubshtgn") {
      var_5 = weaponclipsize(var_3);
      var_6 = int(var_5);
      var_0 setweaponammoclip(var_3, var_6);
      continue;
    } else if(!isDefined(var_4)) {
      continue;
    }
    var_7 = int(level._id_29FD[var_4] / level._id_29FA[var_4]);
    var_0 scripts\mp\gametypes\br_weapons::_id_2A4D(var_3, var_7);
  }

  if(isDefined(var_0.equipment["primary"])) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_0.equipment["primary"], 2);
  }

  if(isDefined(var_0.equipment["secondary"])) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_0.equipment["secondary"], 2);
  }

  var_0 _id_07C4::_id_7B6B("ammobox");
  _id_0A17::_id_EB82(var_0);
  thread _id_0A17::_id_EB7E();
  return 1;
}

_id_1399(var_0) {
  _id_C24E(var_0);
}

_id_136F(var_0) {
  _id_2BE3(var_0);
}

_id_1383() {
  _id_9A11();
}

_id_1381() {
  _id_99F3();
}

_id_1382(var_0) {
  _id_99F5(var_0);
}

_id_1377(var_0) {
  _id_2A4E(var_0);
}

_id_1378(var_0) {
  _id_2C21(var_0);
}

_id_AB94(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();
  var_0 scripts\mp\gametypes\br_weapons::_id_2A4D(var_1);
}

_id_AB3E(var_0, var_1) {
  var_0 scripts\mp\gametypes\br_pickups::_id_7446(var_1, "primary");
}

_id_AAF9(var_0, var_1) {
  switch (var_0) {
    case "rock_mp":
      thread scripts\mp\gametypes\br_gulag::_id_C898(var_1);
      break;
    default:
      break;
  }
}

_id_ABDB(var_0) {
  scripts\mp\gametypes\br_weapons::_id_EDDC(var_0);
}

_id_B7B0() {
  if(scripts\mp\gametypes\br_gametypes::_id_8792("playerShouldRespawn")) {
    return scripts\mp\gametypes\br_gametypes::_id_CA24("playerShouldRespawn");
  }

  if(!istrue(level._id_2AA8)) {
    return 1;
  }

  if(scripts\mp\gametypes\br_public::_id_8B00(self)) {
    return 1;
  }

  if(scripts\mp\gametypes\br_public::_id_8A02(self)) {
    return 1;
  }

  return 0;
}

_id_2C34(var_0, var_1) {
  if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    if(getdvarint("#x365a8c680db84cc2d", 1) == 1) {
      if(istrue(isDefined(self._id_2E0E))) {
        return 1;
      }

      if(!_id_07D1::_id_60BE("prematch_done")) {
        return 0;
      }

      if(istrue(var_0._id_103C2._id_75A4) || istrue(level._id_FE28)) {
        if(scripts\mp\gametypes\br_public::_id_8805()) {
          if(isbot(var_0._id_103C2)) {
            return 1;
          }
        }

        var_0._id_103C2 thread scripts\mp\gametypes\br_gametype_dmz::_id_B768();
        var_2 = scripts\mp\utility\teams::_id_6DCA(var_0._id_103C2.team, "teamCount");

        if(var_2 > 1) {
          var_0._id_103C2 thread scripts\mp\gametypes\br_spectate::_id_E37D(var_0, var_1, 1);
        }

        return 1;
      }
    } else {
      if(!_id_07D1::_id_60BE("prematch_done")) {
        return 0;
      }

      if(istrue(var_0._id_103C2._id_75A4) || istrue(level._id_FE28)) {
        if(scripts\mp\gametypes\br_public::_id_8805()) {
          if(isbot(var_0._id_103C2)) {
            return 1;
          }
        } else if(!scripts\mp\gametypes\br_public::_id_8805())
          var_0._id_103C2 thread scripts\mp\playerlogic::_id_C673(var_0._id_103C2.origin + (0, 0, 60), var_0._id_103C2.angles);

        var_0._id_103C2 thread scripts\mp\gametypes\br_gametype_dmz::_id_B768();
        return 1;
      }
    }
  } else if(istrue(self._id_7E92)) {
    self._id_7E92 = 0;
    var_0._id_103C2 thread scripts\mp\gametypes\br_gametype_dmz::_id_B768();
    var_0._id_103C2 thread scripts\mp\gametypes\br_spectate::_id_E37D(var_0, var_1, 1);
    return 1;
  } else if(!_id_B7B0()) {
    if(!_id_0A8B::_id_B7AF(0)) {
      var_0._id_103C2 thread scripts\mp\gametypes\br_spectate::_id_E37D(var_0, var_1);
    }

    return 1;
  }

  return 0;
}

_id_2BED(var_0) {
  var_1 = var_0 scripts\mp\gametypes\br_gulag::_id_F748();

  if(_id_07D1::_id_60BE("prematch_done") && !var_1) {
    _id_9B84(var_0);
  }

  return !var_1;
}

_id_F99F() {}

_id_A153() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = gettime();

  for(;;) {
    self waittill("weapon_change");
    var_1 = gettime();

    if(var_1 - var_0 < 3000) {
      self._id_90C7 = var_1;
      return;
    }

    var_2 = var_1 - var_0;
    thread _id_700A(var_2);
    var_0 = var_1;
  }
}

_id_10DD2(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  return _id_10D9D(var_1);
}

_id_10D9D(var_0) {
  if(!isDefined(level._id_10DC3._id_9CBF[var_0])) {
    return 0;
  }

  var_1 = level._id_10DC3._id_9CBF[var_0] > 0;
  return var_1;
}

_id_18F8() {
  if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    return;
  }
  level endon("game_ended");
  level waittill("prematch_started");
  level _id_B7C1(50);
  level _id_B7C1(25);
  level _id_B7C1(10);
  level _id_B7C1(5);
}

_id_B7C1(var_0) {
  level endon("game_ended");
  var_1 = _id_692E();

  while(var_1.size > var_0) {
    level waittill("br_player_eliminated");
    var_1 = _id_692E();

    if(var_1.size <= var_0) {
      var_2 = !istrue(level._id_FE76) || istrue(level._id_7262._id_DD08);

      if(var_2) {
        scripts\mp\gametypes\br_public::_id_2BDC("top_" + var_0, 0, undefined, 1);
      }

      break;
    }
  }
}

_id_692E() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(istrue(var_2._id_2A63)) {
      continue;
    }
    if(level.codcasterenabled) {
      if(var_2 _meth_81D3()) {
        continue;
      }
    }

    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_C5FF(var_0) {
  var_1 = var_0 scripts\mp\persistence::_id_E761("round", "timePlayed", 0);
  var_0.pers["afkResetTime"] = var_1;
  var_0.pers["distTrackingPassed"] = undefined;
  var_0.pers["totalDistTraveledAFK"] = undefined;
  var_0 thread scripts\mp\playerlogic::_id_F378(var_0.origin);
}

_id_AAED(var_0) {
  _id_C5FF(var_0);
  var_0._id_2BF2 = undefined;
  var_0 _id_07B9::_id_2FAF();
}

_id_3AE2(var_0, var_1) {
  level notify("commandWatcher_" + var_0);
  level endon("commandWatcher_" + var_0);
  setDvar(var_0, "");

  for(;;) {
    waitframe();
    var_2 = getDvar(var_0);

    if(var_2 == "") {
      continue;
    }
    setDvar(var_0, "");
    var_3 = strtok(var_2, " ");

    if(!isDefined(var_3) || var_3.size < 1) {
      continue;
    }
    var_4 = var_3[0];
    var_5 = scripts\engine\utility::_id_1BD4(var_3, 1);
    [[var_1]](var_4, var_5);
  }
}

_id_7429(var_0, var_1) {
  if(!isDefined(level._id_742B)) {
    return;
  }
  foreach(var_3 in level._id_742B)[[var_3]](var_0, var_1);
}

_id_C25E(var_0) {
  if(!isDefined(level._id_742B)) {
    level._id_742B = [];
  }

  level._id_742B[level._id_742B.size] = var_0;
}

_id_742A(var_0, var_1) {
  switch (var_0) {
    case "st":
      thread scripts\mp\gametypes\br_spectate::_id_48EE(var_1);
      break;
    default:
      break;
  }
}

_id_FD3E(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0._id_2ABC)) {
    if(!isDefined(level._id_2ABD)) {
      level._id_2ABD = [];
    }

    var_4 = _id_6516(level._id_2ABD[var_0.team]);

    if(!isalive(var_0)) {
      var_3 = 1;
      var_2 = 0;
    }

    var_5 = var_0 == var_1;
    var_6 = var_0._id_2ABC;
    var_7 = int(_func_0037(clamp(var_2, 0, 1) * 128));
    var_8 = var_7;

    if(istrue(var_3)) {
      var_0 scripts\mp\gametypes\br_public::_id_D670(0);
    } else if(var_5) {
      var_0 scripts\mp\gametypes\br_public::_id_D670(1);
    }

    var_9 = var_6 * 8;
    var_10 = (var_8 & 255) << var_9;
    var_11 = ~(255 << var_9);
    var_12 = var_4 &var_11;
    var_13 = var_12 + var_10;
    level._id_2ABD[var_0.team] = var_13;
    var_14 = scripts\mp\utility\teams::_id_6DCA(var_0.team, "players");

    if(isDefined(var_14) && var_14.size > 0) {
      foreach(var_16 in var_14) {
        var_16 setclientomnvar("ui_br_squad_revive_status", var_13);
      }
    }
  }
}

_id_2EE1(var_0) {
  var_1 = [0, 0, 0, 0];

  if(isDefined(var_0) && isDefined(var_0._id_2BEF)) {
    var_2 = 0;

    foreach(var_7, var_4 in var_0._id_2BEF) {
      var_5 = scripts\mp\gametypes\br_quest_util::_id_6CA6(var_7);
      var_6 = int(clamp(var_4, 0, 15)) << 4;
      var_1[var_2] = var_6 + var_5;
      var_2++;

      if(var_2 >= 4) {
        break;
      }
    }
  }

  var_8 = [];
  var_8[0] = (var_1[0] << 8) + var_1[1];
  var_8[1] = (var_1[2] << 8) + var_1[3];
  var_8[2] = _id_6516(var_0._id_2A2C);
  var_9 = int(clamp(_id_6516(var_0._id_2ABC) - 1, 0, 3));
  var_8[3] = var_9 << 14;
  var_8[3] = var_8[3] + _id_6516(var_0.pers["damage"]);
  return var_8;
}

_id_AB60() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "spectator" || self.sessionteam == "none" || isDefined(self._id_81F4) || self _meth_878F()) {
    return 0;
  }

  if(scripts\mp\gametypes\br_public::_id_878D() && !isbot(self)) {
    self setclientomnvar("ui_br_extended_load_screen", 1);
    return 0;
  }

  if(!_id_FE58()) {
    return 1;
  }

  var_0 = _id_6D4A();
  self._id_81F4 = var_0;
  self setclientomnvar("ui_br_extended_load_screen", 1);
  var_1 = scripts\mp\gametypes\br_public::_id_B7E5(var_0.origin);
  _id_E30E(var_1, var_0.angles);
  var_2 = getdvarint("#x36c8912e3dc56a1c0", 15000);
  scripts\mp\gametypes\br_public::_id_B7E6(var_1, var_2, 1, 1);
  return 0;
}

_id_B6E9() {
  return self.sessionstate == "intermission" && isDefined(self._id_81F4);
}

_id_FCF5() {
  level notify("updatePlayerAndTeamCountUI");
  level endon("updatePlayerAndTeamCountUI");
  waittillframeend;
  var_0 = level.players.size;
  var_1 = 0;
  var_2 = [];

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = level.players[var_3];

    if(!istrue(var_4._id_2A63)) {
      var_1++;
      var_2[var_4.team] = 1;
    }
  }

  var_6 = (var_2.size << 8) + var_1;
  setomnvar("ui_br_match_stats", var_6);
}

_id_2AC6() {
  var_0 = 0;
  level._id_EFB3 = [];
  var_1 = 0;

  foreach(var_3 in level._id_EF89) {
    var_4 = scripts\mp\utility\teams::_id_6DCA(var_3, "teamCount");

    if(var_4) {
      var_0 = var_0 + var_4;
      var_1++;
      level._id_EFB3[level._id_EFB3.size] = var_3;

      if(var_1 > 1) {
        break;
      }
    }
  }

  if(scripts\mp\utility\game::matchmakinggame() && !level._id_7EB0 && (!isDefined(level._id_4AB9) || !level._id_4AB9)) {
    if(level.teambased) {
      if(level._id_EFB3.size == 1 && game["state"] == "playing") {
        thread scripts\mp\gamelogic::_id_AAF2(level._id_EFB3[0]);
        return;
      }

      if(level._id_EFB3.size > 1) {
        level._id_5EFD = undefined;
        level notify("abort_forfeit");
      }
    } else {
      if(var_0 == 1 && level._id_9C91 > 1) {
        thread scripts\mp\gamelogic::_id_AAF2();
        return;
      }

      if(var_0 > 1) {
        level._id_5EFD = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(level._id_EFB3.size == 1 && istrue(level._id_2A34)) {
    return;
  }
  if(!scripts\mp\utility\game::_id_6A65() && (!isDefined(level._id_4AE8) || !level._id_4AE8)) {
    return;
  }
  if(!scripts\mp\utility\game::_id_60C5()) {
    return;
  }
  if(level._id_7EB0 && !isDefined(level._id_AD53)) {
    return;
  }
  _id_2A19();
  _id_2A1A();

  if(level.teambased) {
    var_6 = [];
    var_7 = 0;
    var_8 = 0;
    var_9 = [];
    var_10 = [];

    foreach(var_12 in level._id_EF89) {
      var_6[var_12] = 0;

      if(!istrue(level._id_4AE8)) {
        foreach(var_14 in scripts\mp\utility\teams::_id_6DCA(var_12, "players")) {
          if(!istrue(var_14._id_75B4) || var_14.team == "spectator" || var_14.team == "follower" || var_14.team == "free") {
            continue;
          }
          if(var_14.pers["lives"]) {
            var_6[var_12] = var_6[var_12] + var_14.pers["lives"];
            var_7 = 1;
          }
        }
      }

      var_16 = scripts\mp\utility\teams::_id_6DCA(var_12, "aliveCount");

      if(!var_8 && var_16 > 0) {
        var_8 = 1;
      }

      if(scripts\mp\utility\teams::_id_6DCA(var_12, "hasSpawned") && var_16 <= 0 && !var_6[var_12] && !scripts\mp\utility\teams::_id_6DCA(var_12, "deathEvent")) {
        var_9[var_9.size] = var_12;
        continue;
      }

      if(var_16 == 2 && !scripts\mp\utility\teams::_id_6DCA(var_12, "twoLeft")) {
        if(scripts\mp\utility\game::_id_6D9E() != "dmz") {
          var_17 = scripts\mp\utility\teams::_id_6DCA(var_12, "alivePlayers");
          var_18 = scripts\engine\utility::random(var_17);
          level thread scripts\mp\battlechatter_mp::_id_F759(var_18, "inform_last_two");
        }

        scripts\mp\utility\teams::_id_D70F(var_12, "twoLeft", 1);
        continue;
      }

      if(var_16 == 1) {
        if(gettime() > scripts\mp\utility\teams::_id_6DCA(var_12, "oneLeftTime") + 5000 && !scripts\mp\utility\teams::_id_6DCA(var_12, "oneLeft")) {
          var_19 = 0;
          var_17 = scripts\mp\utility\teams::_id_6DCA(var_12, "players");

          foreach(var_14 in var_17) {
            if(!isalive(var_14)) {
              var_19 = var_19 + var_14.pers["lives"];
            }
          }

          if(var_19 == 0) {
            scripts\mp\utility\teams::_id_D70F(var_12, "oneLeftTime", gettime());
            scripts\mp\utility\teams::_id_D70F(var_12, "oneLeft", 1);

            if(var_17.size > 1) {
              [[level._id_AB47]](var_12);
            }
          }
        }

        continue;
      }

      scripts\mp\utility\teams::_id_D70F(var_12, "oneLeft", 0);
    }

    if(!var_8 && !var_7) {
      if(istrue(level._id_BA49) && level.gameended) {
        level notify("exfil_continue_game_end");
      }

      if(istrue(level._id_A737)) {
        return;
      }
      return [[level._id_AAA3]]("all");
    }

    if(istrue(level._id_BA49) && level.gameended) {
      level notify("exfil_continue_game_end");
    }

    if(!istrue(level._id_DDB6) && !istrue(level._id_A737)) {
      foreach(var_12 in var_9) {
        if(level._id_A2FC) {
          scripts\mp\utility\teams::_id_D70F(var_12, "deathEvent", 1);
          [[level._id_AAA3]](var_12);
          continue;
        }

        return [[level._id_AAA3]](var_12);
      }
    }
  } else {
    var_6 = 0;

    foreach(var_14 in level.players) {
      if(var_14.team == "spectator" || var_14.team == "follower") {
        continue;
      }
      var_6 = var_6 + var_14.pers["lives"];
    }

    var_27 = 0;

    foreach(var_12 in level._id_EF89) {
      var_27 = var_27 + scripts\mp\utility\teams::_id_6DCA(var_12, "aliveCount");
    }

    if(!var_27 && !var_6) {
      if(istrue(level._id_A737)) {
        return;
      }
      return [[level._id_AAA3]]("all");
    }

    var_30 = scripts\mp\utility\game::_id_6C7B();

    if(var_30.size == 1) {
      return [[level._id_AB47]]("all");
    }
  }
}

_id_98CF() {
  return istrue(level._id_98D0) && getdvarint("#x3180a34a47beb474e", 1);
}

_id_2A6E(var_0) {
  var_1 = istrue(var_0) && scripts\mp\gametypes\br_gulag::_id_3516();
  return istrue(self.inlaststand) && !istrue(self._id_75AF) && !var_1;
}

_id_2A5D() {
  var_0 = [];
  var_1 = [];
  var_2 = isDefined(level._id_7262) && !istrue(level._id_7262._id_DD08);

  if(level.teambased) {
    foreach(var_4 in level._id_EF89) {
      var_5 = 0;

      foreach(var_7 in level._id_EF6A[var_4]["alivePlayers"]) {
        if(var_7 _id_2A6E(var_2)) {
          continue;
        }
        var_5 = 1;
        break;
      }

      if(var_5) {
        foreach(var_7 in level._id_EF6A[var_4]["alivePlayers"]) {
          if(var_7 _id_2A6E(var_2)) {
            continue;
          }
          var_0[var_0.size] = var_7;
        }

        continue;
      }

      foreach(var_7 in level._id_EF6A[var_4]["alivePlayers"]) {
        if(var_7 _id_2A6E(var_2)) {
          var_1[var_1.size] = var_7;
        }
      }
    }
  } else {
    foreach(var_7 in level.players) {
      if(var_7 _id_2A6E(var_2)) {
        var_1[var_1.size] = var_7;
        continue;
      }

      if(isalive(var_7)) {
        var_0[var_0.size] = var_7;
      }
    }
  }

  if(!scripts\mp\gametypes\br_public::_id_8AB8()) {
    scripts\mp\gametypes\br_public::_id_2BDC("finish_calls", 0, var_0);

    foreach(var_7 in var_0) {
      var_7 setclientomnvar("ui_br_end_game_splash_type", 19);
      var_7 playsoundtoplayer("br_finish_them_splash", var_7);
    }

    foreach(var_7 in var_1) {
      var_7 _meth_81B0("outline_nodepth_red");
    }
  }
}

_id_2A19() {
  if(!getdvarint("#x33ed61c75792fd102", 0)) {
    return;
  }
  if(istrue(level._id_9062)) {
    return;
  }
  if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    return;
  }
  var_0 = isDefined(level._id_7262) && !istrue(level._id_7262._id_DD08);
  var_1 = 0;
  var_2 = 0;

  if(level.teambased) {
    foreach(var_4 in level._id_EF89) {
      var_5 = 0;

      foreach(var_7 in level._id_EF6A[var_4]["alivePlayers"]) {
        if(var_7 _id_2A6E(var_0)) {
          var_2 = 1;
          continue;
        }

        var_5 = 1;
        break;
      }

      if(var_5) {
        var_1++;

        if(var_1 > 1) {
          return;
        }
      }
    }
  } else {
    foreach(var_7 in level.players) {
      if(!isalive(var_7)) {
        continue;
      }
      if(var_7 _id_2A6E(var_0)) {
        var_2 = 1;
        continue;
      }

      var_1++;

      if(var_1 > 1) {
        return;
      }
    }
  }

  if(var_1 == 0 || !var_2) {
    return;
  }
  level._id_9062 = 1;
  _id_2A5D();
}

_id_2A1A(var_0) {
  if(!getdvarint("#x313058454ec56bf25", 1)) {
    return 0;
  }

  if(scripts\mp\utility\game::_id_6D9E() == "dmz" || istrue(scripts\mp\gametypes\br_public::_id_878D())) {
    return 0;
  }

  var_1 = isDefined(level._id_7262) && !istrue(level._id_7262._id_DD08);
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in level._id_EF89) {
    var_6 = 1;
    var_2 = [];

    foreach(var_8 in level._id_EF6A[var_5]["alivePlayers"]) {
      var_9 = istrue(var_1) && var_8 scripts\mp\gametypes\br_public::_id_8991();

      if(var_9) {
        continue;
      }
      var_10 = istrue(var_8.inlaststand) || isDefined(var_0) && var_0 == var_8;

      if(var_10 && !istrue(var_8._id_75AF)) {
        var_2[var_2.size] = var_8;
        continue;
      }

      var_6 = 0;
      break;
    }

    if(var_6 && var_2.size > 0) {
      var_12 = [];

      foreach(var_8 in var_2) {
        if(isDefined(self._id_9060) && !scripts\engine\utility::array_contains(var_12, self._id_9060)) {
          self._id_9060._id_10E62 = self._id_9096;
          var_12[var_12.size] = self._id_9060;
        }

        if(isDefined(var_0) && var_0 == var_8) {
          var_3 = 1;
        }

        var_8 notify("squad_wipe_death");
        var_8 _id_0A8B::_id_0D8A();
      }

      foreach(var_16 in var_12) {
        var_16 thread _id_07CE::_id_8D83("team_wiped", 0);
        var_16 thread _id_0A9F::_id_7003("team_wiped", var_16._id_10E62);
        var_16._id_10E62 = undefined;
      }
    }
  }

  return var_3;
}

_id_2B50(var_0) {
  if(_id_2BBD(var_0)) {
    return 0;
  }

  return 1;
}

_id_81DB(var_0) {
  if(var_0 scripts\mp\utility\game::rankingenabled() && var_0 _meth_85AD()) {
    var_0 setplayerdata(level.progressiongroup, "aarValue", 0, 0);
    var_0 setplayerdata(level.progressiongroup, "aarValue", 1, 0);
    var_0 setplayerdata(level.progressiongroup, "aarValue", 2, 0);
    var_0 setplayerdata(level.progressiongroup, "aarValue", 3, 0);
    var_0 setplayerdata(level.progressiongroup, "aarValue", 4, 0);
    var_0 setplayerdata(level.progressiongroup, "aarValue", 5, 0);
    var_1 = var_0 getplayerdata("common", "mpProgression", "playerLevel", "xp");
    var_0 setplayerdata(level.progressiongroup, "aarValue", 6, var_1);
    var_0 setplayerdata(level.progressiongroup, "aarValue", 7, var_1);
  }
}

_id_D45B(var_0) {
  var_1 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");

  foreach(var_3 in var_1) {
    if(!var_3 scripts\mp\utility\game::rankingenabled() || !var_3 _meth_85AD()) {
      continue;
    }
    var_4 = var_3.pers["combatXP"];

    if(!isDefined(var_4)) {
      var_4 = 0;
    }

    var_3 setplayerdata(level.progressiongroup, "aarValue", 0, var_4);
    var_5 = var_3.pers["missionXP"];

    if(!isDefined(var_5)) {
      var_5 = 0;
    }

    var_3 setplayerdata(level.progressiongroup, "aarValue", 1, var_5);
    var_6 = var_3.pers["lootingXP"];

    if(!isDefined(var_6)) {
      var_6 = 0;
    }

    var_3 setplayerdata(level.progressiongroup, "aarValue", 2, var_6);
    var_7 = 0;

    if(isDefined(var_3._id_9BA8)) {
      var_7 = int(var_3._id_9BA8);
    }

    var_3 setplayerdata(level.progressiongroup, "aarValue", 4, var_7);
    var_8 = 0;

    if(isDefined(var_3._id_B16D)) {
      var_8 = int(var_3._id_B16D);
    }

    var_3 setplayerdata(level.progressiongroup, "aarValue", 5, var_8);
    var_9 = var_3 getplayerdata(level.progressiongroup, "aarValue", 6);
    var_10 = var_9 + var_3.pers["summary"]["xp"];
    var_3 setplayerdata(level.progressiongroup, "aarValue", 7, var_10);
  }
}

_id_2BD5(var_0, var_1) {
  if(isDefined(self.vehicle)) {
    var_2 = var_0.streakname;

    if(var_2 == "manual_turret") {
      return 0;
    }
  }

  return 1;
}