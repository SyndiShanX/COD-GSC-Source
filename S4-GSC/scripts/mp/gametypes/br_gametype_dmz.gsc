/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_dmz.gsc
****************************************************/

init() {
  scripts\mp\gametypes\br_gametypes::_id_4AB8("circle");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("gulag");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("dropbag");

  if(getdvarint("#x365a8c680db84cc2d", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::_id_4AB8("teamSpectate");
  }

  scripts\mp\gametypes\br_gametypes::_id_5254("allowLateJoiners");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("oneLife");

  if(getdvarint("#x3ea65802162fb4c75", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::_id_4AB8("kiosk");
  }

  if(getdvarint("#x3d886559feea4479f", 1) == 1) {
    scripts\mp\gametypes\br_gametypes::_id_5254("tabletReplace");
  }

  scripts\mp\gametypes\br_gametypes::_id_C243("playerDropPlunderOnDeath", ::_id_B69D);
  scripts\mp\gametypes\br_gametypes::_id_C243("playerShouldRespawn", ::_id_B7B0);
  scripts\mp\gametypes\br_gametypes::_id_C243("playerWelcomeSplashes", ::_id_B821);
  scripts\mp\gametypes\br_gametypes::_id_C243("spawnHandled", ::_id_E2F8);
  level._id_EF92 = getdvarint("#x34f26c1b12350e1ee", 0);

  if(level._id_EF92) {}

  level._id_0F54 = [];
  level._id_0F54["uktl"] = "dx_bra_uktl_respawning_enemy_in_area";
  level._id_0F54["rutl"] = "dx_bra_rutl_respawning_enemy_in_area";
  level._id_2BB5._id_9C6E = getdvarint("#x359df15ea9a12254b", 5);
  level._id_2BB5._id_A77F = 0;
  level._id_2BB5._id_5BDE = "tie";
  level._id_2AA4 = 0;
  level._id_29F6 = 1;
  level._id_F34B = [];
  level._id_9891 = [];
  level._id_57AB = [];
  level._id_2F5E = 0;
  level._id_2F5F = 0;
  level._id_2F60 = 0;
  var_0 = getdvarint("#x33e7e139077ed8dd3", 1000);

  if(var_0 > 0) {
    var_0 = var_0 * 10;
    var_0 = var_0 * 100;
    setDvar("#x3c4de77d791be66e7", var_0);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), var_0);
  }

  setDvar("#x3845ad3b379bbe824", 3);
  setDvar("#x3ad56e0d30902a57a", "nothing");
  setdvarifuninitialized("#x3c13c19d58157cb9f", 10000);
  setomnvar("ui_br_circle_state", 4);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  setdvarifuninitialized("#x3caa1c1db64166782", 1);
  level._id_6FB3 = getdvarint("#x3160bfddeecb35686", 1);
  level._id_8304 = getdvarint("#x334db12d8b1a391c0", 1);
  level._id_2955 = getdvarint("#x3afe7e8c48cd71729", 50);
  level._id_F347 = getdvarint("#x3cb212007aad084e5", 5);
  level._id_FE8D = getdvarint("#x39772de20ebf70f9d", 1);
  level._id_9E96 = getdvarint("#x375f66bac8a7c75d0", 10);
  level._id_9E95 = getdvarint("#x353315804d7c9675b", 30);
  level._id_9E93 = getdvarint("#x35399bcdf3971e78a", 50);
  level._id_9E94 = getdvarint("#x35f58693a0e6f3131", 75);
  level._id_13A4 = getdvarint("#x390825cf4290997e9", 750);
  level._id_7910 = getdvarint("#x32c3f7380c0b4ba30", 10);
  level._id_7907 = getdvarint("#x318310ee752ef8f32", 0);
  level._id_DCD5 = getdvarint("#x3ea10cefeba263a4e", 1);
  level._id_CFF1 = getdvarint("#x33a6fab711d8ac0b", 60);
  level._id_4AD9 = getdvarint("#x38b7271de0325b518", 0);
  level._id_9887 = getdvarint("#x38be1b8fcabfa0c93", 3);
  level._id_9C86 = getdvarint("#x38be1b8fcabfa0c93", 3);
  level._id_9889 = getdvarint("#x3722cadd0aa5c378", 5000);
  level._id_9890 = getdvarint("#x348fc5116af6dce8a", 1) == 1;
  level._id_988A = getdvarint("#x34b6b337ebf0d210e", 1);
  level._id_988C = getdvarint("#x31884be124e735127", 2000);
  level._id_988D = getdvarint("#x3d4c252ee98f6b3e7", 5000);
  level._id_988E = getdvarint("#x34c702f773395a486", 5000);
  level._id_988F = getdvarint("#x36afad5b938b35bc4", 1000);
  level._id_57A8 = getdvarint("#x32959e86d1298f900", 0) == 1;
  level._id_988B = getdvarint("#x32e3084d689c8130d", 2);
  level._id_B969 = getdvarfloat("#x3ed4405ca9794b354", 0.3);
  level._id_B96B = getdvarfloat("#x3248250b2e6b779a2", 0.5);
  level._id_B96C = getdvarfloat("#x313aca633695c722f", 0.75);
  level._id_B96A = getdvarfloat("#x3eda15c94cfcfca52", 0.9);
  level._id_FE28 = getdvarint("#x347ebf41e53e2f629", 1);
  level._id_1F51 = getdvarint("#x31fd9ccd7b5f7c3da", 20);
  level._id_F2E9 = getdvarint("#x3913d9e3cf207db2e", level._id_1F51);
  level._id_7DE9 = getdvarint("#x356204ec280ca515", 0);
  level._id_7DEA = getdvarfloat("#x3c8307959fef80d40", 15);
  level._id_C6A2 = getdvarint("#x34d63cd87307efbbd", 5000);
  level._id_C6C4 = getdvarint("#x32078afb1450a70a", 0);
  level._id_AE2C = getdvarfloat("#x32408c54d9930f791", 0.5);
  level._id_26A2 = getdvarint("#x35b4a7ecffb9e3efc", 200);
  level._id_26A3 = getdvarint("#x3c8f4043508838062", 250);
  level._id_9C98 = getdvarint("#x3f4b85e13b08d6bd8", 10000);
  level._id_9F33 = getdvarint("#x349df2c8ca40c1102", 200);
  level._id_AF90 = getdvarint("#x31f06a98f78355c9", 50);
  level._id_B963 = getdvarint("#x3f114c2fcad1cfcb6", 750);
  level._id_9C97 = getdvarint("#x3e28496853ce8d65f", 2000);
  level._id_5703 = getdvarfloat("#x3abeea52d577ca97c", 1);
  level._id_1F1E = getdvarint("#x3e46f48907222bbab", 0);
  level._id_BEA4 = getdvarint("#x38ec2a88becc474b0", 5000);
  level._id_BEA3 = getdvarint("#x38e9f9e8bec9e16fa", 10000);
  level._id_BEA0 = getdvarint("#x3ad34b9e19e3948bf", 2500);
  level._id_BE9F = getdvarint("#x3ad11c7e19e131fd1", 7500);
  level._id_BEA8 = getdvarint("#x37d04e8c78ae159e7", 5000);
  level._id_BEA7 = getdvarint("#x37d27d6c78b077a09", 8000);
  level._id_EC8B = getdvarfloat("#x342f48a3f5b4fa1ff", 1.5);
  level._id_DDCC = getdvarint("#x3412227d9d5b671a1", 0);
  level._id_DDAD = getdvarint("#x36f74fda621014023", 1);
  level._id_5E79 = getdvarint("#x3604cb49aafa3a26", 1);
  level._id_15B8 = getdvarint("#x3f4c3f6790969a4bb", 1);
  level._id_EF8E = getdvarint("#x381a5fedf86357dcb", 0) == 1;
  level._id_EF8F = getdvarint("#x3fcac076e78a825e", 0) == 1;
  level._id_EF91 = getdvarint("#x360f2e7dfe04a0a87", 0) == 1;
  level._id_EF90 = getdvarint("#x35f447690166872a4", 180);
  level._id_DCD7 = getdvarint("#x3887d1fe658912d8", 1) == 1;
  level._id_DCCB = getdvarint("#x3ed955f3a7ab377af", 0);
  level._id_F235 = getdvarint("#x3eeedccfd9f7475f1", 0);
  level._id_A248 = getdvarint("#x3ba64fa46b97d6c44", 0) == 1;
  level._id_5840 = int(getdvarint("#x3832a6a159a9e14e3", 999) * 100);
  level._id_5841 = getdvarint("#x32c96d1ea8e42789e", 1);
  level._id_21D7 = getdvarint("#x34f341d90f5bb23e0", 1);
  level._id_B961 = getdvarint("#x3496d21a7e400ed7b", 1);
  level._id_9BF1 = getdvarint("#x393fdcbdac42b0757", 120);
  level._id_78E7 = getdvarint("#x3ad25d670c361a4e9", 1);
  level._id_D869 = scripts\engine\utility::ter_op(getDvar("#x323906ee9566aeee9") == "mp_br_mechanics", 0, getdvarint("#x3430add6ed71c10fc", 1));
  level._id_CC17 = getdvarint("#x3ba79df4b08016f04", 0);
  level._id_4B00 = getdvarint("#x31f623fa075307a54", 0);
  level._id_4C6D = getdvarint("#x37ec6ea33798d4057", 30);
  level._id_D46A = level._id_4C6D > 0;
  level._id_AD71 = getdvarint("#x3a53b9cbd37763b6c", 1);
  level._id_21D1 = getdvarint("#x334fefd37112498be", 0);
  level._id_9AB5 = getdvarint("#x3e4a8287d0af0c4de", 0);
  level._id_9FF0 = ::_id_B7CD;
  level._id_5326 = getdvarint("#x3b00d5a464940566d", 1);
  level._id_AD72 = getdvarfloat("#x3cda9eabc7f2ac1ed", 2);
  setomnvar("ui_br_overtime_cash_multiplier", level._id_AD72);
  level._id_4AD3 = getdvarint("#x354c70ca8d5de294a", 0);
  level._id_4BD6 = getdvarint("#x38172128f6aac4b0a", 0) == 1;
  level._id_4BDA = getdvarint("#x33e7e139077ed8dd3", 1000) * 1000;
  level._id_4BD4 = getdvarint("#x31d612510c03263f1", 300);
  level._id_4BD7 = getdvarint("#x37fa4ccb862b7363e", 40);
  level._id_4BD5 = getdvarint("#x38e228328b0182c02", 20);
  level._id_9F34 = getdvarint("#x3d93517109281a1bb", 7);
  level._id_9C99 = getdvarint("#x3d83317231334cf9", 7);
  level._id_AE35 = getdvarint("#x32c60ca3b27ed8a0b", 45000);
  level._id_AE33 = getdvarint("#x3346fe71c953e907a", 20000);
  level._id_AE34 = getdvarint("#x3e812f4848b040921", 2000);
  level._id_AE32 = getdvarint("#x3eb193811898e02fc", 3000);
  level._id_2B51 = 1;
  thread scripts\mp\gametypes\br_lootchopper::init();
  thread scripts\mp\gametypes\br_c130airdrop::init();
  thread _id_8274();
  thread _id_8181();
}

_id_8274() {
  waittillframeend;
  level._id_F902["uav"]._id_F224 = 60;
  _id_07D1::_id_60C0("collect_done", 0);
  _id_07D1::_id_60C0("helipad_wait_done", 0);
  _id_07D1::_id_60C0("placement_updates_allowed", 0);
  _id_07D1::_id_60C0("activate_cash_lzs", 0);
  _id_07D1::_id_60C0("activate_cash_drops", 0);
  _id_07D1::_id_60C0("activate_cash_helis", 0);
  level._id_9FE5 = ::_id_2BED;
  level._id_2BF0 = ::_id_9F9C;
  level._id_AB47 = ::_id_AB47;
  level._id_AB70 = ::_id_AB70;
  level._id_AB7D = ::_id_AB7D;
  level._id_ABC0 = ::_id_ABC0;
  _id_0AA3::_id_C28D(::_id_B713);
  _id_0A8E::_id_C285(::_id_AB63);
  thread _id_D88D();
  thread scripts\mp\gametypes\br_lootchopper::_id_9876();
  thread scripts\mp\gametypes\br_c130airdrop::_id_2E29();
  level._id_9888 = [];
  level._id_57AA = [];

  for(var_0 = 0; var_0 < level._id_9887; var_0++) {
    if(level._id_988B > 0 && var_0 == 0) {
      var_1 = 1;
      var_2 = 5;
    } else {
      var_1 = 1;
      var_2 = 4;
    }

    var_3 = spawnStruct();
    var_3._id_02D0 = "";
    var_3 scripts\mp\gametypes\br_quest_util::_id_4038(var_1, var_2);
    var_3 scripts\mp\gametypes\br_quest_util::_id_D5EE(level._id_9889);
    level._id_9888[var_0] = var_3;
    var_3 = spawnStruct();
    var_3._id_02D0 = "";
    var_3 scripts\mp\gametypes\br_quest_util::_id_4038(var_1, var_2, 2);
    var_3 scripts\mp\gametypes\br_quest_util::_id_D5EE(level._id_9889);
    level._id_57AA[var_0] = var_3;
  }

  if(!istrue(level._id_FE8D)) {
    level thread _id_B177();
  }

  thread _id_107DE();
  thread _id_107DD();
  level thread scripts\mp\gametypes\br_analytics::_id_815D();
  _id_3880();

  if(level._id_EF92) {
    if(getdvarfloat("#x3640c280f1754d9bd", 15.0) > 0.0) {
      level thread _id_FCB5();
    }
  }

  if(level._id_DCD7 && level._id_DCCB) {
    level thread _id_3FEC();
  }

  if(level._id_F235 > 0) {
    _id_07D1::_id_60C2("prematch_done");

    if(level._id_9BF1 > 0) {
      wait(level._id_9BF1);
    }

    level thread _id_E70D();
  }

  if(istrue(level._id_9AB5)) {
    level thread _id_818F();
  }

  level._id_FF5E = [];
  level._id_FF5E[0] = "assassination";
  level._id_FF5E[1] = "domination";
  level._id_FF5E[2] = "scavenger";
  level thread _id_553A();

  if(istrue(level._id_5326)) {
    level thread _id_818B();
  }

  var_4 = getdvarint("#x3bc0b0a4e8f050c4c", -1);

  if(var_4 > 0) {
    level._id_2A73._id_2E1E = var_4;
  }

  level thread _id_33D8();

  if(level._id_4C6D && level._id_AD71) {
    level thread _id_33E9();
  }
}

_id_33D8() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::_id_8805()) {
    return;
  }
  level endon("end_circlestate_timer");
  _id_07D1::_id_60C2("prematch_done");
  var_0 = getdvarint("#x33167a73f66075eca");
  setomnvar("ui_br_circle_state", 5);
  setomnvar("ui_hardpoint_timer", gettime() + int(var_0 * 1000));
  wait(int(max(var_0 - 300, 0)));
  setomnvar("ui_br_circle_state", 6);
}

_id_33E9() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  var_0 = getdvarint("#x33167a73f66075eca");
  var_1 = int(max(var_0 - level._id_4C6D, 0));

  if(var_1 <= 0) {
    return;
  }
  wait(var_1);
  level notify("end_circlestate_timer");
  level thread _id_F62E(undefined, undefined, 1);
}

_id_107DD() {
  level endon("game_ended");

  if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    level thread _id_10BCA(level._id_AE33);
    _id_07D1::_id_60C2("prematch_done");
    level notify("cancel_watch_parachuters_overhead");
    waitframe();
    level thread _id_10BCA(level._id_AE35);
  }
}

_id_107DE() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  thread _id_B96F();
}

_id_3880() {
  scripts\cp_mp\utility\game_utility::_id_C4E8("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::_id_C4E9("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::_id_C4E9("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::_id_C4E9("me_electrical_box_street_01", 1);
}

_id_AB63(var_0) {
  if(isDefined(var_0) && _id_07D1::_id_60BE("prematch_done")) {
    var_0 scripts\mp\gametypes\br_pickups::_id_5041();

    if(isDefined(level._id_4BD3)) {
      if(level._id_EF6A[var_0.team]["players"].size == 0) {
        level._id_4BD3--;
      }
    } else
      _id_2EF0();
  }
}

_id_AB47(var_0) {}

_id_B821(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome_dmz");

  if(!istrue(level._id_2A60)) {
    self waittill("joining_Infil");
  } else {
    _id_07D1::_id_60C2("prematch_done");
  }

  wait 1;
  level thread _id_2EF0();

  if(_func_0205("dx_bra_uktl_bm_tut_earn_cash")) {
    level scripts\mp\gametypes\br_public::_id_2BDD("bm_tut_earn_cash", self);
  }

  scripts\mp\hud_message::showsplash("br_gametype_dmz_welcome");

  if(istrue(self._id_8793)) {
    level scripts\mp\gametypes\br_public::_id_2BDD("deploy_squad_leader", self, 1, 0, 4.5);
  }

  if(istrue(level._id_1F1E) && istrue(level._id_2AA8)) {
    _id_1F1F(self);
  }
}

_id_E2F8(var_0) {
  return istrue(var_0._id_2A61) && _id_07D1::_id_60BE("prematch_done");
}

_id_69F6() {}

_id_F434() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  if(scripts\mp\gametypes\br_public::_id_8805()) {
    return;
  }
  for(;;) {
    wait 1;
    var_3 = scripts\mp\gamelogic::_id_6DE8() / 1000;

    if(istrue(level._id_25BB)) {
      break;
    }

    if(var_3 <= 600 && !var_0) {
      var_0 = 1;
      setomnvar("ui_br_circle_state", 1);

      foreach(var_5 in level.players) {
        var_5 _id_0A99::_id_D5EA(69, undefined, 10);
      }

      continue;
    }

    if(var_3 <= 300 && !var_1) {
      var_1 = 1;
      setomnvar("ui_br_circle_state", 2);

      foreach(var_5 in level.players) {
        var_5 _id_0A99::_id_D5EA(70, undefined, 10);
      }

      continue;
    }

    if(var_3 <= 0 && !var_2) {
      var_2 = 1;

      if(level._id_EF92) {
        return;
      }
      setomnvar("ui_nuke_countdown_active", 0);
      level._id_9DDC = 1;
      var_9 = _id_5ADD();

      if(isPlayer(var_9)) {
        var_9 _id_0A56::_id_F795();
        wait 10;
        var_10 = _id_5B08();
        level thread scripts\mp\gamelogic::_id_52F7(var_10, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
      } else {
        var_10 = _id_5B08();
        level thread scripts\mp\gamelogic::_id_52F7(var_10, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
      }
    }
  }
}

_id_2EF0() {
  level._id_4BD3 = 0;

  foreach(var_1 in level._id_EF6A) {
    if(var_1["players"].size > 0) {
      level._id_4BD3++;
    }
  }
}

_id_5ADD() {
  var_0 = getarraykeys(level._id_EF6A);

  foreach(var_2 in var_0) {
    if(level._id_EF6A[var_2]["alivePlayers"].size > 0) {
      return level._id_EF6A[var_2]["alivePlayers"][0];
    }
  }

  return undefined;
}

_id_5B08() {
  var_0 = getarraykeys(level._id_EF6A);

  foreach(var_2 in var_0) {
    if(level._id_EF6A[var_2]["players"].size == 0) {
      return var_2;
    }
  }

  return "tie";
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\gametypes\br::_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(scripts\mp\gametypes\br_public::_id_8805()) {
    return;
  }
  var_10 = getdvarint("#x370e8812461daa542", 7500);

  if(isDefined(level._id_E423) && level._id_E423 + var_10 > gettime()) {
    scripts\mp\hud_message::showsplash("bm_vips_marked");
  }

  if(isDefined(level._id_E422) && level._id_E422 + var_10 > gettime()) {
    scripts\mp\hud_message::showsplash("bm_extract_heli_start");
  }

  if(isDefined(level._id_E420) && level._id_E420 + var_10 > gettime()) {
    scripts\mp\hud_message::showsplash("br_c130airdrop_incoming");
  }

  if(isDefined(level._id_E421) && level._id_E421 + var_10 > gettime()) {
    scripts\mp\hud_message::showsplash("br_lootchopper_incoming");
  }
}

_id_2BED(var_0) {
  return 1;
}

_id_B768() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }
  if(getdvarint("#x365a8c680db84cc2d", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  var_0 = scripts\mp\utility\teams::_id_6DCA(self.team, "teamCount");

  if(!istrue(self._id_E4B5) || var_0 == 1) {
    var_1 = 1.0;
    wait(var_1);
  }

  if(istrue(self._id_75A4) && isDefined(level._id_F2E9)) {
    var_2 = level._id_F2E9;
  } else if(level._id_7DE9 > 0.0) {
    var_2 = clamp(self.pers["deaths"] * level._id_7DE9, 0.0, level._id_7DEA);
  } else if(isDefined(level._id_1F51)) {
    var_2 = level._id_1F51;
  } else {
    var_2 = getdvarint("#x3f52fcc2efe82bfa5", 20);
  }

  var_3 = getdvarfloat("#x3cc3497a79c434580", 10.0);

  if(var_2 < var_3) {
    var_2 = var_3;
  }

  if(level._id_C6C4 != 0) {
    var_2 = 0;
  }

  var_4 = getdvarfloat("#x3e0f2d0f762f511dd", 5.0);
  scripts\engine\utility::_id_5473("playerRespawn_intermission_spawned");
  self._id_83CD = undefined;
  self._id_83CE = undefined;

  if(istrue(self._id_E4B5) || var_0 == 1) {
    var_5 = scripts\mp\gametypes\br_gulag::_id_B6CA();
    var_6 = scripts\mp\gametypes\br_gulag::_id_B75C(var_5);
    thread _id_58C8(0.0, var_0 > 1);
    wait(var_4);
  } else if(!scripts\mp\gametypes\br_public::_id_8805()) {
    _id_0A99::_id_D5EA(9, int(gettime() + var_2 * 1000));
    var_7 = var_2 - var_3;
    var_8 = var_2 - var_7;
    var_9 = var_2 - getdvarfloat("#x35883f5ac811825bd", 6.0);
    thread _id_58C8(var_9);
    var_10 = scripts\engine\utility::_id_108F7("squad_wipe_death", var_7);

    if(var_10 == "squad_wipe_death") {
      var_5 = scripts\mp\gametypes\br_gulag::_id_B6CA();
      var_6 = scripts\mp\gametypes\br_gulag::_id_B75C(var_5);
      thread _id_58C8(0.0, 1);
      wait(var_4);
    } else {
      thread _id_FD08();
      var_10 = scripts\engine\utility::_id_108F7("squad_wipe_death", var_8);

      if(var_10 == "squad_wipe_death") {
        var_5 = scripts\mp\gametypes\br_gulag::_id_B6CA();
        var_6 = scripts\mp\gametypes\br_gulag::_id_B75C(var_5);
        thread _id_58C8(0.0, 1);
        wait(var_4);
      }
    }
  }

  self notify("stop_updatePrestreamRespawn");
  var_5 = scripts\mp\gametypes\br_gulag::_id_B6CA();
  var_6 = scripts\mp\gametypes\br_gulag::_id_B75C(var_5);

  if(istrue(self._id_E4B5)) {
    self._id_E4B5 = 0;

    if(!scripts\mp\gametypes\br_public::_id_8805()) {
      scripts\mp\hud_message::showsplash("bm_your_squad_wiped");
    }
  }

  if(_id_8A92(self.team)) {
    return;
  }
  if(istrue(self._id_75A4)) {
    thread scripts\mp\gametypes\br_gulag::_id_F631(4);
    self._id_F2E8 = 1;
    scripts\mp\gametypes\br_pickups::_id_C514();
  }

  if(_id_8A92(self.team)) {
    return;
  }
  if(getdvarint("#x36dc712d351157361", 1) == 0) {
    scripts\mp\gametypes\br_public::_id_B817();
  }

  scripts\engine\utility::_id_5470("playerRespawn_intermission_spawned");
  self._id_83CD = undefined;
  self._id_83CE = undefined;
  _id_0A99::_id_D5EA(0);
  scripts\mp\playerlogic::_id_E337(undefined, 0);
  _id_0790::_id_0B9E();
  scripts\mp\gametypes\br_pickups::_id_825B();

  if(scripts\mp\gametypes\br_public::_id_8805() && isDefined(level._id_B59F)) {
    var_5 = scripts\engine\utility::getstruct(level._id_B59F, "targetname");
  }

  scripts\mp\gametypes\br_gulag::_id_728C(1, undefined, var_5, 1, var_6, 1);
  scripts\mp\gametypes\br::_id_F997(self);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "player_respawn");
}

_id_B7B0(var_0) {
  return 1;
}

_id_FD08() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::_id_546E("playerRespawn_intermission_spawned")) {
      var_0 = scripts\mp\gametypes\br_gulag::_id_B6CA();
      var_1 = gettime();

      if(distance2dsquared(self._id_83CD, var_0.origin) > 25000000) {
        self._id_83CD = var_0.origin;
        self._id_83CE = var_1;
        self setorigin(var_0.origin);
        scripts\mp\gametypes\br_public::_id_B67D();
      }

      if(var_1 - self._id_83CE >= getdvarfloat("#x3c3ccd97980bd5f34", 2.0) * 1000) {
        var_0 = scripts\mp\gametypes\br_gulag::_id_B6CA(1);
        var_2 = scripts\mp\gametypes\br_gulag::_id_B75C(var_0);
      }
    } else {
      var_0 = scripts\mp\gametypes\br_gulag::_id_B6CA();
      var_2 = scripts\mp\gametypes\br_gulag::_id_B75C(var_0);
    }

    wait 1.0;
  }
}

_id_58C8(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  var_2 = 1.0;
  thread scripts\mp\gametypes\br_gulag::_id_58BC(var_2);
  wait(var_2 - 0.25);

  if(istrue(var_1)) {
    self setclientomnvar("ui_br_transition_type", 6);
  } else {
    self setclientomnvar("ui_br_transition_type", 2);
  }

  wait 0.25;

  if(getdvarint("#x3f80581773c233c4e", 1) == 1) {
    scripts\mp\gametypes\br_public::_id_B67D();
    var_3 = scripts\mp\gametypes\br_gulag::_id_B6CA();
    scripts\mp\gametypes\br_spectate::_id_B67C();
    scripts\mp\gametypes\br::_id_E30E(var_3.origin, var_3.angles);
    _id_081A::_id_D512();
    self._id_83CD = var_3.origin;
    self._id_83CE = gettime();
    scripts\engine\utility::_id_5474("playerRespawn_intermission_spawned");
  }
}

_id_D88D() {
  level._id_2BB5._id_5842 = _id_6A28();
  thread _id_99F0();
}

_id_6A28() {
  var_0 = 2500;
  var_1 = level._id_2A73._id_2A7A;
  var_2 = (0, randomfloatrange(0, 360), 0);
  var_3 = anglesToForward(var_2);
  var_4 = level._id_2A73._id_2A25[0] * 2;
  var_5 = var_1 + var_3 * var_4;
  var_5 = scripts\mp\gametypes\br_c130::_id_DEAF(var_1, var_5);
  var_6 = getent("airstrikeheight", "targetname");
  var_7 = (var_5[0], var_5[1], var_6.origin[2]);
  var_8 = _id_F3CB(var_7);
  var_5 = var_8 + (0, 0, var_0);
  return var_5;
}

_id_99F0() {
  var_0 = _id_07F9::_id_C57D(1);
  level._id_2BB5._id_A8DA = var_0;

  if(var_0 != -1) {
    _id_07F9::_id_A867(var_0, "current", level._id_2BB5._id_5842, "icon_waypoint_koth");
    _id_07F9::_id_FB98(var_0, 0);
    _id_07F9::_id_A89F(var_0);
  }
}

_id_D88E() {
  _id_07D1::_id_60C2("prematch_done");
  var_0 = _id_69B3();
  var_1 = scripts\mp\gametypes\br_quest_util::_id_6CA6("gt_extract_1");

  foreach(var_3 in level.players) {
    var_3 scripts\mp\gametypes\br_quest_util::_id_D68B(var_1);
    var_3 scripts\mp\gametypes\br_quest_util::_id_F920(var_0);
  }
}

_id_69B3() {
  var_0 = getdvarint("#x3670487661c5d4084", 5000);
  var_1 = getdvarint("#x3696c9bd3f5c507db", 2000);
  var_2 = getdvarint("#x3330633b82d578bd", 200);

  if(var_1 > 0) {
    var_0 = int(max(var_1, var_0 - level._id_2BB5._id_A77F * var_2));
  }

  return var_0;
}

_id_DCA6(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];

  foreach(var_3 in var_1) {
    _id_07F9::_id_A89D(level._id_2BB5._id_A8DA, var_3);
  }
}

_id_78F9(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];

  foreach(var_3 in var_1) {
    _id_07F9::_id_A89E(level._id_2BB5._id_A8DA, var_3);
  }
}

_id_4E84() {
  level._id_2BB5._id_A77F++;
  level._id_2BB5._id_7B66 _meth_83A3(level._id_2BB5._id_A77F);
  level._id_2BB5._id_7B66 thread _id_7B61();
  level._id_2BB5._id_7B65 thread _id_7B61();
  var_0 = _id_698A();
  level._id_2BB5._id_7B5F _meth_83A3(var_0 * 100);

  foreach(var_3, var_2 in level._id_EF6A) {
    if(isDefined(var_2["teamCount"]) && var_2["teamCount"] > 0) {
      _id_FD59(var_3);
    }
  }

  var_4 = _id_69B3();

  foreach(var_6 in level.players) {
    if(!_id_8A92(var_6.team)) {
      var_6 thread scripts\mp\hud_message::showsplash("br_gametype_extract_extracted");
      var_6 scripts\mp\gametypes\br_quest_util::_id_F920(var_4);
    }
  }
}

_id_D70E(var_0) {
  level._id_EF6A[var_0]["extracted"] = 1;
}

_id_8A92(var_0) {
  return istrue(level._id_EF6A[var_0]["extracted"]);
}

_id_2BAA() {
  wait 1.5;
  _id_7440();
  scripts\mp\gamelogic::_id_52FD(level._id_2BB5._id_5BDE, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

_id_7440() {
  foreach(var_1 in level.players) {
    if(!_id_8A92(var_1.team)) {
      var_1 setclientomnvar("post_game_state", 2);
    }
  }
}

_id_D8BB() {
  level endon("game_ended");
  var_0 = 120;
  _id_07D1::_id_60C2("prematch_done");

  if(!istrue(level._id_2A60)) {
    level waittill("br_ready_to_jump");
  }

  waitframe();
  var_1 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_COLLECT_PLUNDER", undefined, "CENTER", "CENTER", 0, -170);
  var_1.alpha = 1;
  var_2 = scripts\mp\hud_util::_id_404A("default", 1.5);
  var_2 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  var_3 = getdvarint("#x3967585697dd1a039", 180);

  if(var_3 > 0) {
    setomnvar("ui_hardpoint_timer", gettime() + int(var_3 * 1000));
    var_2 _meth_8391(var_3);
    wait(var_3);
  }

  _id_07D1::_id_60C1("collect_done");
  var_4 = getdvarint("#x3c4f6c08326d3e472", 180);

  if(var_4 > 0) {
    var_1.label = &"MP_BR_INGAME/EXTRACT_HELIPADS_ACTIVE";
    var_1 thread _id_7B61();
    setomnvar("ui_hardpoint_timer", gettime() + int(var_4 * 1000));
    var_2 _meth_8391(var_4);
    wait(var_4);
  }

  _id_07D1::_id_60C1("helipad_wait_done");
  var_5 = getdvarint("#x31e23d084874cbce6", 840);
  var_1.label = &"MP_BR_INGAME/EXTRACT_HELIPAD";
  var_1 thread _id_7B61();
  setomnvar("ui_hardpoint_timer", gettime() + int(var_5 * 1000));
  var_2 _meth_8391(var_5);
  var_6 = max(var_5 - var_0, 0);
  wait(var_6);
  var_7 = max(var_5 - var_6, 0);
  var_2.color = (1, 0, 0);
  var_2 thread _id_7B61();
  thread _id_39B3(var_7);
  wait(var_7);
  var_2 destroy();
  thread _id_2BAA();
}

_id_39B3(var_0) {
  level endon("game_ended");
  _func_01EA("ui_final_moments_notify", gettime() + var_0 * 1000);

  while(var_0 > 0) {
    var_1 = 0;
    var_2 = scripts\mp\gamelogic::_id_6966(var_0);

    if(var_0 > 60 && var_0 % 10 == 0 || var_0 <= 60 && var_0 > 30 && var_0 % 2 == 0 || var_0 <= 30) {
      var_1 = 1;
    }

    if(var_1) {
      foreach(var_4 in level.players) {
        var_4 playlocalsound(var_2);
      }
    }

    var_0 = var_0 - 1;
    wait 1;
  }
}

_id_D8B9() {
  var_0 = 155;
  var_1 = 15;
  var_2 = -3;
  var_3 = 3;

  if(level._id_EF92) {
    var_4 = _id_6E98();
    var_5 = &"MP_BR_INGAME/WIN_COST_TEXT";
    var_6 = var_4;
  } else {
    var_4 = _id_698A();
    var_5 = &"MP_BR_INGAME/EXTRACT_COST_TEXT";
    var_6 = var_4 * 100;
  }

  level._id_2BB5._id_7B60 = _id_3FF3(var_5, undefined, "LEFT", "CENTER", var_3, var_0, undefined, undefined, 1);
  level._id_2BB5._id_7B5F = _id_3FF3(&"MP_BR_INGAME/EXTRACT_COST_MILLION", undefined, "LEFT", "CENTER", 65 + var_3, var_0, undefined, undefined, 1);
  level._id_2BB5._id_7B91 = _id_3FF3(&"MP_BR_INGAME/YOUR_TEAM_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", 5 + var_2, var_0, undefined, undefined, 1);
  var_7 = 0;
  level._id_2BB5._id_913B = _id_3FF3(&"MP_BR_INGAME/LEADER_PLUNDER_TEXT", var_7, "CENTER", "CENTER", 0, var_0 + var_1, undefined, undefined, 1);

  foreach(var_9 in level._id_EF89) {
    var_10 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_PLUNDER", 0, "RIGHT", "CENTER", 70 + var_2, var_0, undefined, var_9, 1);
    var_11 = _id_3FF3(&"MP_BR_INGAME/ST_PLACE", undefined, "RIGHT", "CENTER", -65 + var_2, var_0, undefined, var_9, 1);
    var_11 _meth_83A3(1);
    var_10._id_B16C = var_11;
    _id_D717(var_9, var_10);
  }

  _id_07D1::_id_60C2("prematch_done");

  if(!istrue(level._id_2A60)) {
    level waittill("br_ready_to_jump");
  }

  level._id_2BB5._id_7B60.alpha = 1;
  level._id_2BB5._id_7B5F.alpha = 1;
  level._id_2BB5._id_7B91.alpha = 1;
  level._id_2BB5._id_913B.alpha = 1;

  foreach(var_9 in level._id_EF89) {
    var_10 = _id_6DD6(var_9);
    var_10.alpha = 1;
    var_10._id_B16C.alpha = 1;
  }
}

_id_D717(var_0, var_1) {
  level._id_EF6A[var_0]["hudPlunder"] = var_1;
  var_1._id_B956 = 0;
  var_1._id_B95C = 0;
}

_id_6DD6(var_0) {
  return level._id_EF6A[var_0]["hudPlunder"];
}

_id_3FF3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_8)) {
    var_8 = 1.5;
  }

  if(isDefined(var_7)) {
    var_10 = newteamhudelem(var_7);
  } else if(isDefined(var_9)) {
    var_10 = newclienthudelem(var_9);
  } else {
    var_10 = newhudelem();
  }

  var_10.elemtype = "font";
  var_10.font = "default";
  var_10.fontscale = var_8;
  var_10._id_22B8 = var_8;
  var_10.x = 0;
  var_10.y = 0;
  var_10.width = 0;
  var_10.height = int(level.fontheight * var_8);
  var_10.xoffset = 0;
  var_10.yoffset = 0;
  var_10.children = [];
  var_10 scripts\mp\hud_util::setparent(level.uiparent);
  var_10.hidden = 0;
  var_10.alpha = 0;
  var_10 scripts\mp\hud_util::setpoint(var_2, var_3, var_4, var_5);

  if(isDefined(var_0)) {
    var_10.label = var_0;
  }

  if(isDefined(var_1)) {
    var_10 _meth_83A3(var_1);
  }

  if(isDefined(var_6)) {
    var_10.color = var_6;
  }

  return var_10;
}

_id_6DD5(var_0) {
  var_1 = 0;

  if(!level._id_CC17) {
    var_1 = var_1 + level._id_EF6A[var_0]["plunderTeamTotal"];
    var_1 = var_1 + level._id_EF6A[var_0]["plunderInDeposit"];
  }

  var_1 = var_1 + level._id_EF6A[var_0]["plunderBanked"];
  return var_1;
}

_id_6DC6(var_0) {
  return level._id_EF6A[var_0]["plunderTeamTotal"];
}

_id_68F9(var_0) {
  return level._id_EF6A[var_0]["plunderBanked"];
}

_id_E038(var_0, var_1) {
  return var_0 > var_1;
}

_id_735B(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  self setclientomnvar(var_0, var_2);
}

_id_7372(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  setomnvar(var_0, var_2);
}

_id_B96F() {
  level endon("game_ended");
  var_0 = 0;
  var_1 = [];
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = level._id_7907 != 0;
  level._id_E423 = undefined;
  level._id_E422 = undefined;
  level._id_E420 = undefined;
  level._id_E421 = undefined;

  for(;;) {
    waittillframeend;
    var_9 = level._id_2F5E && level._id_2F5F && level._id_2F60;
    var_10 = _id_6E98();
    var_0 = var_0 + level._id_5F3A;

    if(istrue(level._id_FE8D)) {
      var_11 = _id_07D1::_id_60BE("placement_updates_allowed");
    } else {
      var_11 = var_0 > level._id_CFF1;
    }

    var_12 = level._id_DCD5 && var_11;
    var_13 = scripts\mp\gamescore::_id_6DD9();
    var_14 = level._id_EF92;
    var_15 = undefined;
    var_16 = undefined;
    var_17 = undefined;
    var_18 = [];
    var_19 = [];
    var_20 = [];
    var_21 = "none";
    var_22 = "none";
    var_23 = -1;
    var_24 = -1;

    foreach(var_26 in level._id_EF89) {
      var_27 = _id_6DD5(var_26);
      var_28 = _id_68F9(var_26);
      var_29 = _id_FD5A(var_27, var_26, level._id_2BB5._id_5BDE);
      var_30 = _id_6C8A(var_26);
      var_31 = var_13[var_26];

      if(var_27 > var_23) {
        if(var_23 > var_24) {
          var_24 = var_23;
          var_22 = var_21;
        }

        var_23 = var_27;
        var_21 = var_26;
      } else if(var_21 != "none") {
        if(var_27 > var_24) {
          var_24 = var_27;
          var_22 = var_26;
        }
      }

      var_32 = (var_27 - var_28) * 100;
      var_33 = var_27 * 100;
      var_34 = var_33 - var_32;

      if(var_32 < 0) {
        var_32 = 0;
      }

      if(var_33 >= var_10 * 0.9) {
        var_15 = var_26;
      } else if(var_33 >= var_10 * 0.75) {
        var_16 = var_26;
      } else if(var_33 >= var_10 * 0.5) {
        var_17 = var_26;
      }

      var_35 = scripts\mp\utility\teams::_id_6A59(var_26, 0);

      foreach(var_37 in var_35) {
        var_31 = var_13[var_37.team];

        if(!var_6) {
          var_31 = 155;
        }

        var_37 setclientomnvar("ui_br_team_placement", var_31);
        var_37 setclientomnvar("ui_br_player_position", var_31);
        var_37 _id_735B("ui_br_team_cash_banked", int(var_34 * 0.01));
        var_37 _id_735B("ui_br_team_cash_pockets", int(var_32 * 0.01));
        var_19[var_37.guid] = var_37._id_B956;
        var_20[var_37.guid] = var_37;
      }

      if(var_12) {
        if(var_31 == 1) {
          if(var_31 < var_30 || var_30 == -1) {
            var_18[var_18.size] = var_26;
          }
        } else if(var_31 <= 5) {
          if(var_30 > 5) {
            _id_DCE8(var_26, "bm_top_5");
          }
        } else if(var_31 <= 10) {
          if(var_30 > 10) {
            _id_DCE8(var_26, "bm_top_10");
          }
        }
      }

      if(var_33 >= var_10) {
        _id_1F22(var_26);

        if(var_14 && level._id_4C6D > 0 && !level._id_4B00) {
          level thread _id_F62E(var_26, level._id_EF6A[var_26]["plunderBanked"] * 1000 >= var_10);
          continue;
        }

        if(var_14 && level._id_4C6D > 0 && level._id_4B00) {
          level._id_81FB = var_26;
          continue;
        }

        if(level._id_EF8E && !istrue(level._id_5718)) {
          level._id_5718 = 1;
          level thread _id_E681(var_26);
          continue;
        }

        if(!level._id_EF8E && var_14 && !level._id_4B00) {
          level thread _id_700B(var_26);
        }
      }
    }

    var_40 = [];
    var_41 = [];

    if(level._id_988B == 1) {
      var_40 = _func_0426(game["teamPlacements"], "up");
    } else if(level._id_988B == 2) {
      var_40[0] = var_21;
      var_41 = _func_0426(var_19, "down");
    } else
      var_41 = _func_0426(var_19, "down");

    level._id_2BB5._id_5BDE = var_21;

    if(var_21 == "none") {
      var_1 = [];
      waitframe();
      continue;
    }

    if(var_22 != "none") {
      _id_7372("ui_br_cash_second", int(var_24));
    }

    _id_7372("ui_br_cash_leader", int(var_23));

    if(!var_8 && var_23 * 100 >= var_10 * level._id_7907 * 0.01) {
      setomnvar("ui_br_leader_hash_percentage_hit", 1);
      var_8 = 1;
    }

    if(!istrue(var_7) && istrue(level._id_FE8D)) {
      if(!var_2 && var_23 * 100 >= var_10 * level._id_9E96 * 0.01) {
        var_2 = 1;
        level._id_E423 = gettime();
        _id_07D1::_id_60C1("placement_updates_allowed");

        if(!scripts\mp\gametypes\br_public::_id_8805()) {
          _id_DCE6("bm_vips_marked");
        }
      }

      if(!var_3 && (level._id_CC17 || var_23 * 100 >= var_10 * level._id_9E95 * 0.01)) {
        var_3 = 1;
        level._id_E422 = gettime();
        _id_07D1::_id_60C1("activate_cash_lzs");

        if(!scripts\mp\gametypes\br_public::_id_8805()) {
          scripts\mp\gametypes\br_public::_id_2BDC("extract_enabled", 0, undefined, undefined, undefined, "bm");
        }
      }

      if(!var_4 && var_23 * 100 >= var_10 * level._id_9E93 * 0.01) {
        var_4 = 1;
        level._id_E420 = gettime();
        level._id_2A73._id_2E1E = 3044;
        _id_07D1::_id_60C1("activate_cash_drops");
      }

      if(!var_5 && (istrue(level._id_25BB) || var_23 * 100 >= var_10 * level._id_9E94 * 0.01)) {
        var_5 = 1;
        level._id_E421 = gettime();
        _id_07D1::_id_60C1("activate_cash_helis");

        if(!scripts\mp\gametypes\br_public::_id_8805()) {
          scripts\mp\gametypes\br_public::_id_2BDC("event_chopper", 0, undefined, undefined, undefined, "bm");
        }
      }

      if(!var_6 && var_23 * 100 >= var_10 * level._id_7910 * 0.01) {
        var_6 = 1;
      }

      if(var_2 && var_3 && var_4 && var_5) {
        var_7 = 1;
      }
    }

    if(!var_12 || var_23 == 0) {
      waitframe();
      continue;
    }

    if(level._id_988B > 0) {
      if(level._id_4BD6 || istrue(level._id_B97A)) {
        _id_FCB4(var_19, var_41, var_20, var_40);
        level._id_B97A = 0;
      }
    } else if(level._id_4BD6 || istrue(level._id_B97A)) {
      _id_FCB4(var_19, var_41, var_20);
      level._id_B97A = 0;
    }

    foreach(var_26 in var_18) {
      if(istrue(level._id_F34B[var_26])) {
        if(!scripts\mp\gametypes\br_public::_id_8805()) {
          _id_DCE8(var_26, "bm_top_team_regained");
        }

        continue;
      }

      if(!scripts\mp\gametypes\br_public::_id_8805()) {
        _id_DCE8(var_26, "bm_top_team");
      }

      level._id_F34B[var_26] = 1;
    }

    if(var_18.size > 0) {
      foreach(var_26 in var_1) {
        if(!scripts\engine\utility::array_contains(var_18, var_26)) {
          _id_DCE8(level._id_F34A, "bm_top_team_lost");
        }
      }
    }

    var_1 = var_18;
    level._id_F34A = var_21;
    level._id_BC3E = var_13;

    if(!var_9) {
      if(!level._id_2F60 && isDefined(var_15)) {
        level._id_2F60 = 1;

        if(!scripts\mp\gametypes\br_public::_id_8805()) {
          if(!level._id_4AD9) {
            _id_DCE7(var_15, "bm_first_to_90_them");
            _id_DCE8(var_15, "bm_first_to_90_us");
            level thread scripts\mp\gametypes\br_public::_id_2BDE("gamestate_90_perc_first", var_15, 1, undefined, "bm");

            foreach(var_47 in level._id_EF89) {
              if(var_47 != var_15) {
                level thread scripts\mp\gametypes\br_public::_id_2BDE("gamestate_90_perc_enemy", var_47, 1, undefined, "bm");
              }
            }
          }
        }
      } else if(!level._id_2F5F && isDefined(var_16)) {
        level._id_2F5F = 1;

        if(!scripts\mp\gametypes\br_public::_id_8805()) {
          if(!level._id_4AD9) {
            _id_DCE7(var_16, "bm_first_to_75_them");
            _id_DCE8(var_16, "bm_first_to_75_us");
            level thread scripts\mp\gametypes\br_public::_id_2BDE("gamestate_75_perc_first", var_16, 1, undefined, "bm");

            foreach(var_47 in level._id_EF89) {
              if(var_47 != var_16) {
                level thread scripts\mp\gametypes\br_public::_id_2BDE("gamestate_75_perc_enemy", var_47, 1, undefined, "bm");
              }
            }
          }
        }
      } else if(!level._id_2F5E && isDefined(var_17)) {
        level._id_2F5E = 1;

        if(!scripts\mp\gametypes\br_public::_id_8805()) {
          if(!level._id_4AD9) {
            _id_DCE7(var_17, "bm_first_to_50_them");
            _id_DCE8(var_17, "bm_first_to_50_us");
            level thread scripts\mp\gametypes\br_public::_id_2BDE("gamestate_50_perc_first", var_17, 1, undefined, "bm");

            foreach(var_47 in level._id_EF89) {
              if(var_47 != var_17) {
                level thread scripts\mp\gametypes\br_public::_id_2BDE("gamestate_50_perc_enemy", var_47, 1, undefined, "bm");
              }
            }
          }
        }
      }
    }

    waitframe();
  }
}

_id_1F22(var_0) {
  if(!isDefined(level._id_1F21)) {
    level._id_1F21 = [];
  }

  if(scripts\engine\utility::array_contains(level._id_1F21, var_0)) {
    return;
  }
  var_1 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  var_2 = scripts\mp\gametypes\br_plunder::_id_4031();
  var_2._id_B350 = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_B956) && var_4._id_B956 > 0) {
      var_4 scripts\mp\gametypes\br_plunder::_id_B746(var_4._id_B956, undefined, var_2);
    }
  }

  level._id_1F21[level._id_1F21.size] = var_0;
}

_id_AD72() {
  level thread scripts\mp\gametypes\br_plunder::_id_BD62(level._id_AD72);
}

_id_B177() {
  _id_07D1::_id_60C2("prematch_done");

  if(isDefined(level._id_CFF1)) {
    wait(level._id_CFF1);
  }

  _id_07D1::_id_60C1("placement_updates_allowed");
}

_id_6C8A(var_0) {
  if(isDefined(level._id_BC3E)) {
    return level._id_BC3E[var_0];
  }

  return -1;
}

_id_DCE6(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\mp\hud_message::showsplash(var_0);
  }
}

_id_DCE8(var_0, var_1) {
  foreach(var_3 in level._id_EF6A[var_0]["players"]) {
    var_3 scripts\mp\hud_message::showsplash(var_1);
  }
}

_id_DCE7(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3) && var_3.team != var_0) {
      var_3 scripts\mp\hud_message::showsplash(var_1);
    }
  }
}

_id_F62C(var_0) {
  scripts\mp\gamelogic::resumetimer();
  level._id_E72D = gettime();
  level._id_4B0D = 0;
  level._id_F25E = 0;
  var_1 = getdvarfloat("#x398ec96c159c0faa4", 10);
  var_2 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_timelimit");
  level._id_10AD4[var_2]._id_04CB = var_1;
  level._id_AD6A[var_2] = var_1;
}

_id_FD59(var_0) {
  var_1 = _id_6DD6(var_0);
  var_2 = _id_6DD5(var_0);
  var_3 = _id_698A();

  if(var_2 >= var_3 && var_1.color != (0, 1, 0)) {
    var_1.color = (0, 1, 0);
    var_4 = level._id_EF6A[var_0]["players"];

    foreach(var_6 in var_4) {
      var_6 playlocalsound("br_plunder_atm_deposit_gtr");
    }
  }
}

_id_4CF6(var_0, var_1) {
  var_2 = level._id_EF6A[var_1]["players"];

  foreach(var_4 in var_2) {
    if(var_0 > 0) {
      if(isDefined(var_4._id_7B90)) {
        var_5 = gettime() - var_4._id_7B90;

        if(var_5 <= 6000) {
          break;
        }
      }

      var_4._id_7B90 = gettime();

      if(isalive(var_4)) {
        var_4 playlocalsound("br_plunder_atm_use");
      }

      continue;
    }

    var_4._id_7B90 = undefined;
    var_4 _meth_83EF("br_plunder_atm_use");
  }
}

_id_700B(var_0) {
  if(istrue(level._id_F61C)) {
    return;
  }
  if(!istrue(level._id_F61C)) {
    level thread _id_BD0B();
  }

  level._id_F61C = 1;
  level thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["dmz_plunder_win"], game["end_reason"]["dmz_plunder_loss"], 0, 1);
}

_id_B69D(var_0, var_1) {
  if(isDefined(self._id_2E0E)) {
    return 1;
  }

  if(istrue(level.gameended)) {
    return 1;
  }

  if(istrue(self._id_8801)) {
    var_2 = self._id_B956;
    var_3 = self._id_B956;
    var_4 = 0;
  } else {
    if(isDefined(level._id_9F33) && self._id_B956 < level._id_9F33) {
      var_4 = 0;
      var_2 = self._id_B956;
      var_3 = self._id_B956;
    } else {
      var_4 = int(self._id_B956 * ((100 - level._id_AF90) * 0.01));
      var_2 = self._id_B956 - var_4;
      var_3 = var_2;
    }

    if(istrue(level._id_25BB)) {
      if(var_2 <= level._id_26A3 && (!isDefined(var_1) || var_1 != self)) {
        var_2 = level._id_26A3;
      }
    } else if(var_2 <= level._id_26A2 && (!isDefined(var_1) || var_1 != self))
      var_2 = level._id_26A2;

    if(isDefined(level._id_9C98)) {
      if(var_2 >= level._id_9C98) {
        var_2 = level._id_9C98;
        var_3 = var_2;
        var_4 = self._id_B956 - level._id_9C98;
      }
    }
  }

  self._id_B95B = var_4;

  if(var_3 > 0) {
    scripts\mp\gametypes\br_plunder::_id_B74C(var_3);
  }

  if(var_2 >= level._id_B963) {
    playFX(scripts\engine\utility::getfx("money"), self.origin + (0, 0, 32));
  }

  var_5 = var_2;

  if(istrue(self._id_10A11)) {
    var_5 = int(var_2 * level._id_5703);
  }

  var_6 = var_5;

  if(istrue(level._id_25BB) && (!isDefined(var_1) || self != var_1)) {
    var_6 = int(var_5 * level._id_AD72);

    if(isDefined(level._id_9C97) && var_6 > level._id_9C97) {
      var_6 = level._id_9C97;
    }
  }

  if(scripts\mp\gametypes\br_public::_id_8805() && istrue(self._id_3307)) {
    var_6 = int(var_6 + self._id_3307);
  }

  var_7 = _id_5052(var_6, var_0);

  foreach(var_9 in var_7) {
    var_9._id_9898 = "combat";
  }

  if(scripts\mp\gametypes\br_public::_id_8805()) {
    level notify("victim_death_drop", self, var_1, var_7);
  }

  if(isDefined(var_1) && self == var_1 || !level.killcam) {
    self setclientomnvar("ui_br_plunder_dropped", var_3);
  } else {
    self._id_BA50 = var_3;
  }

  scripts\mp\gametypes\br_analytics::_id_F3F7(self, "combat", var_3 * -1);

  if(isDefined(level._id_9891) && scripts\engine\utility::array_contains(level._id_9891, self)) {
    playFX(scripts\engine\utility::getfx("money"), self.origin + (0, 0, 64));
  }

  return 1;
}

_id_AB7D() {
  if(isDefined(self._id_BA50)) {
    self setclientomnvar("ui_br_plunder_dropped", int(self._id_BA50));
    self._id_BA50 = undefined;
  }
}

_id_5052(var_0, var_1) {
  if(!istrue(level._id_2A9C)) {
    return;
  }
  var_2 = [];
  var_3 = [];
  var_4 = 0;

  for(var_5 = level._id_2A9B._id_BE99.size - 1; var_5 >= 0; var_5--) {
    var_3[var_5] = int(var_0 / level._id_2A9B._id_BE99[var_5]);
    var_4 = var_4 + var_3[var_5];

    if(var_0 <= 0) {
      break;
    } else
      var_0 = var_0 - var_3[var_5] * level._id_2A9B._id_BE99[var_5];
  }

  for(var_6 = level._id_2A9B._id_BE99.size - 1; var_6 >= 0; var_6--) {
    if(!isDefined(var_3[var_6])) {
      continue;
    }
    for(var_7 = 0; var_7 < var_3[var_6]; var_7++) {
      [var_9, var_10, var_11] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_1 + var_2.size, self.origin, self.angles, self);
      var_12 = scripts\mp\gametypes\br_pickups::_id_E336(level._id_2A9B._id_A3D1[var_6], var_9, var_10, level._id_2A9B._id_BE99[var_6], 1, var_11);
      scripts\mp\gametypes\br_plunder::_id_A003(level._id_2A9B._id_A3D1[var_6], 1);

      if(isDefined(var_12)) {
        var_2[var_2.size] = var_12;

        if(scripts\mp\gametypes\br_plunder::_id_82D6()) {
          level._id_2A9D[level._id_2A9D.size] = var_12;
        }
      }
    }
  }

  level._id_2A9B._id_B936 = level._id_2A9B._id_B936 + var_4;
  level._id_2A9B._id_B952 = level._id_2A9B._id_B952 + var_0;
  level thread scripts\mp\gametypes\br_plunder::_id_5053(self.origin, var_2.size);
  return var_2;
}

_id_698A() {
  if(level._id_4BD7 > 0) {
    var_0 = int(max(level._id_4BD7, level._id_4BD4 - level._id_2BB5._id_A77F * level._id_4BD5));
  }

  return level._id_4BD4;
}

_id_6E98() {
  return level._id_4BDA;
}

_id_B7F2(var_0) {
  if(self._id_B956 < var_0) {
    var_0 = self._id_B956;
  }

  if(!isDefined(self._id_B962)) {
    self._id_B962 = 0;
  }

  self._id_B962 = self._id_B962 + var_0;
  scripts\mp\gametypes\br_plunder::_id_B7A3(self._id_B956 - var_0);
  return var_0;
}

_id_EF67(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];

  foreach(var_3 in var_1) {
    var_3._id_B962 = 0;
  }
}

_id_EF9B(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_B962)) {
      var_3 scripts\mp\gametypes\br_plunder::_id_B756(var_3._id_B962);
      var_3._id_B962 = 0;
      var_3 iprintlnbold("Extraction refunded, chopper shot down.");
    }
  }
}

_id_7B61() {
  self endon("death");

  if(istrue(self._id_BE2A)) {
    return;
  }
  var_0 = 0.5;
  var_1 = 4;
  self._id_BE2A = 1;
  var_2 = self.fontscale;
  self changefontscaleovertime(var_0);
  self.fontscale = var_1;
  wait(var_0);
  self changefontscaleovertime(var_0);
  self.fontscale = var_2;
  self._id_BE2A = undefined;
}

_id_5030(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("military_skyhook_backpack");
  var_2 = var_0.origin;
  var_3 = (var_2[0], var_2[1], -12000);
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_0, var_4);
  var_6 = var_5["position"];
  var_7 = var_2[2] - var_6[2];

  if(var_7 > 0) {
    var_8 = _func_0218(2 * var_7 / 800);
    var_1 moveto(var_6, var_8, var_8, 0);
    wait(var_8);
  }

  var_1.origin = var_6;
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_6);
  var_1 _id_3E87();
  var_1 delete();
}

_id_3E87() {
  var_0 = _id_698A();
  scripts\mp\gametypes\br_plunder::_id_5052(var_0, 0);
}

_id_2EEA(var_0, var_1, var_2) {
  var_3 = var_0 * 0.0000157828;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + _func_0218(var_5 * var_5 - 4 * var_4 * var_6)) / (2 * var_4);
  var_7 = var_7 * 3600;
  var_7 = var_7 + 1.5;
  return var_7;
}

_id_2EE9(var_0) {
  var_1 = _id_2EEA(30000, 100, 125);
  var_2 = _id_2EEA(var_0, 25.0, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

_id_77E3(var_0, var_1) {
  var_2 = gettime() + int(var_1 * 1000);
  var_3 = level._id_EF6A[self.team]["alivePlayers"];

  foreach(var_5 in var_3) {
    var_5 setclientomnvar("ui_br_plunder_extract_state", var_0);
    var_5 setclientomnvar("ui_br_plunder_extract_end_time", var_2);
  }
}

_id_7768() {
  if(!isDefined(self._id_B929)) {
    return;
  }
  level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_success", self.team, 1);
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in self._id_B929) {
    var_0 = var_0 + var_3._id_B956;

    if(var_3.player.team != self.team) {
      var_1 = 1;
    }
  }

  scripts\mp\gametypes\br_analytics::_id_2B03(self._id_B929.size, var_0, "little_bird", var_1, self._id_533D);
  level._id_2A9B._id_582A = level._id_2A9B._id_582A + var_0;
  level._id_2A9B._id_5829++;
  scripts\mp\gametypes\br_plunder::_id_550C();
}

_id_77E8() {
  if(isDefined(self._id_FDB2)) {
    level._id_2A35 = scripts\engine\utility::array_remove(level._id_2A35, self._id_FDB2);
    self._id_FDB2 = undefined;
  }
}

_id_776B(var_0) {
  self._id_FDB2 endon("death");
  scripts\engine\utility::_id_108C5("leaving", "death");
  _id_77E8();
}

_id_7797(var_0) {
  self._id_103BE = spawn("script_model", var_0);
  self._id_103BE setModel("scr_smoke_grenade");
  self._id_103BE.angles = (0, 90, 90);
  self._id_103BE playLoopSound("smoke_carepackage_smoke_lp");
  self._id_103BE setscriptablepartstate("smoke", "on");
}

_id_776C(var_0) {
  if(isDefined(self._id_103BE)) {
    self._id_103BE stoploopsound();
    self._id_103BE delete();
  }

  if(istrue(var_0) && isDefined(self._id_DD67)) {
    self._id_DD67 setscriptablepartstate(self._id_DD67.type, self._id_DD67._id_0F60);
  }
}

_id_77A0() {
  self endon("death");

  if(!isDefined(self._id_103BE)) {
    return;
  }
  wait 5;
  self._id_103BE endon("death");
  self._id_103BE setscriptablepartstate("smoke", "dissipate");
  self._id_103BE playSound("smoke_canister_tail_dissipate");
  wait 1;
  self._id_103BE stoploopsound();
  wait 4.5;
  self._id_103BE delete();
}

_id_E2FA(var_0, var_1, var_2, var_3) {
  var_4 = vectortoangles(var_2 - var_1);
  var_5 = 99;
  var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(var_0, var_1, var_4, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x");

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = var_2 * (1, 1, 0);
  var_6._id_42E9 = ::_id_2F40;
  var_6.speed = 50;
  var_6.accel = 99999;
  var_6.health = 1000;
  var_6.maxhealth = var_6.health;
  var_6.team = var_0.team;
  var_6.owner = var_0;
  var_6._id_461E = var_2;
  var_6._id_936C = 0;
  var_6._id_5C8A = var_5;
  var_6._id_AEDC = var_2;
  var_6._id_AEDB = var_3;
  var_6._id_533D = var_7;
  var_6._id_7092 = var_4[1];
  var_6._id_1031E = "magma_plunder_chopper";
  var_6 setCanDamage(1);
  var_6 setmaxpitchroll(10, 25);
  var_6 vehicle_setspeed(var_6.speed, var_6.accel);
  var_6 sethoverparams(50, 100, 50);
  var_6 setturningability(0.05);
  var_6 setyawspeed(45, 25, 25, 0.5);
  var_6 setotherent(var_0);
  _id_E361(var_6);
  var_6 thread _id_0A44::_id_5C7F(undefined, undefined);
  var_6 thread _id_7625();
  var_6 thread _id_7435();
  var_6 thread _id_779B();
  return var_6;
}

_id_E361(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("br_plunder_extraction_delivery_rope");
  var_1 linkto(var_0, "side_door_l_jnt", (11, 20, 42), (0, 180, 0));
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("br_plunder_extraction_delivery_bag");
  var_2 linkto(var_1, "dyn_rope_end", (0, 0, 0), (0, 0, 0));
  var_0._id_C918 = var_1;
  var_0._id_3E6D = var_2;
}

_id_779B() {
  self endon("heli_gone");
  self endon("swapped");
  var_0 = self.owner;
  var_1 = self.team;
  self waittill("death", var_2, var_3, var_4, var_5);
  _id_EF9B(var_1);
  _id_776A();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_8EE2) && !istrue(self._id_87F9)) {
    self vehicle_setspeed(25, 5);
    thread _id_7795(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  _id_77B3(var_2);
}

_id_776A() {
  if(isDefined(self._id_C918)) {
    self._id_C918 delete();
  }

  if(isDefined(self._id_3E6D)) {
    self._id_3E6D delete();
  }
}

_id_77B3(var_0) {
  var_1 = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(var_1, 256, 140, 70, var_0, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "veh_chopper_support_crash");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("grenade_rumble", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread scripts\mp\gametypes\br::_id_EFAD("br_gametype_extract_heli_shot_down", self.owner, self.owner.team);
  _id_776C(1);
  _id_7798();
}

_id_7798() {
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_7795(var_0) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self _meth_838A(self.angles[1] + var_0 * 2.5);
}

_id_7435() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::_id_9ACB(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      _id_2F40(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
      _id_776C(1);
    }
  }
}

_id_2F40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level._id_5FA5 && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::_id_8DD6(var_1, var_5, self, var_4, var_2);
  var_1 _id_07C4::_id_FC47("");

  if(self.health - var_2 <= 900 && (!isDefined(self._id_DE57) || !self._id_DE57)) {
    self._id_DE57 = 1;
  }

  self _meth_842C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_77C2() {
  self endon("death");
  self notify("leaving");
  self._id_916C = 1;
  self setvehgoalpos(self._id_AEDC, 1);
  self _meth_838A(self._id_7092);
  _id_77E3(3, self._id_5D49);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self._id_AEDB, 1);
  self _meth_838A(self._id_7092);
  self waittill("goal");
  self stoploopsound();
  _id_7768();
  _id_77E3(0, 0);
  self notify("heli_gone");
  _id_7798();
}

_id_779A(var_0, var_1) {
  self endon("death");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self _meth_838A(self._id_7092);
  self vehicle_setspeed(25.0, 31.25);
  thread _id_779C();
  thread _id_779D();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

_id_54EE() {
  return isalive(self) && (scripts\common\vehicle::_id_8AF5() || isDefined(self.classname) && self.classname == "script_vehicle");
}

_id_779C() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && var_0 _id_54EE()) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

_id_779D() {
  self endon("leaving");
  self endon("death");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = _func_0098("script_vehicle", "classname", self.origin, getdvarfloat("#x34b8346a089ba183b", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::_id_3F87();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc7036459ed3de1", var_2) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc6f86459ed25b0", var_3) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("#x3ebc7076459ed46ad", var_4) + (0, 0, getdvarfloat("#x3ebc7016459ed397b", var_1));
    var_9 = scripts\engine\trace::_id_E409(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["entity"];

    if(isDefined(var_10) && var_10 _id_54EE()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

_id_F3C9(var_0) {
  var_1 = 125;
  var_2 = _id_F3CB(var_0, 100, [self]);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

_id_F3CB(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::_id_3F94();
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_6 = scripts\engine\trace::_id_E409(var_0, var_4, var_1, var_2, var_5);
  } else {
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);
  }

  return var_6["position"];
}

_id_77EA() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread _id_77C2();
}

_id_818F() {
  var_0 = [];

  switch (level.mapname) {
    case "mp_br_mechanics":
      var_0[var_0.size] = (1500, 1500, 0);
      var_0[var_0.size] = (2500, 1500, 0);
      var_0[var_0.size] = (3500, 1500, 0);
      var_0[var_0.size] = (4500, 1500, 0);
      break;
    case "mp_donetsk":
      var_0[var_0.size] = (-33750, -36000, 155);
      var_0[var_0.size] = (-41550, -7950, 515);
      var_0[var_0.size] = (-37500, 15350, 1130);
      var_0[var_0.size] = (-31950, 52015, 2265);
      var_0[var_0.size] = (-18510, 64815, 1940);
      var_0[var_0.size] = (15565, 60050, 2680);
      var_0[var_0.size] = (44400, 39255, -50);
      var_0[var_0.size] = (59780, 13800, 555);
      var_0[var_0.size] = (61200, -8445, 30);
      var_0[var_0.size] = (59325, -38390, -210);
      var_0[var_0.size] = (8660, -36630, -640);
      break;
    case "mp_mb_tut":
      break;
  }

  level._id_5836 = var_0;
  level._id_581B = [];
  level thread _id_A10C();
}

_id_3FCB(var_0) {}

_id_A10C() {
  _id_07D1::_id_60C2("prematch_done");

  foreach(var_1 in level._id_5836) {
    var_2 = _id_07F9::_id_C57D(1);

    if(var_2 != -1) {
      _id_07F9::_id_A867(var_2, "active", var_1, "icon_waypoint_flag");
      _id_07F9::_id_FB98(var_2, 0);
      _id_07F9::_id_A89F(var_2);
      _id_07F9::_id_A8A2(var_2);
    }

    level thread _id_E2E4(var_1);
  }

  for(;;) {
    foreach(var_1 in level._id_5836) {
      var_5 = scripts\mp\utility\player::_id_6C5F(var_1, 300);

      foreach(var_7 in var_5) {
        if(!scripts\engine\utility::array_contains(level._id_581B, var_7) && !istrue(var_7._id_5833)) {
          var_7 _id_57F8(var_1);
        }
      }
    }

    foreach(var_7 in level._id_581B) {
      if(distancesquared(var_7.origin, var_7._id_5835) > 90000) {
        var_7 _id_57F6();
        continue;
      }

      var_7._id_583B = var_7._id_583B - level._id_5F3A;

      if(var_7._id_583B <= 0.0) {
        var_7 _id_57F7();
      }
    }

    waitframe();
  }
}

_id_E2E4(var_0) {
  var_1 = scripts\engine\utility::_id_5000(var_0, 50, -200, (0, 0, 1));
  var_2 = spawn("script_model", var_1 + (0, 0, 3));
  var_2 setModel("scr_smoke_grenade");
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_red"), var_2, "tag_fx");
  var_2 playLoopSound("mp_flare_burn_lp");
}

_id_57F8(var_0) {
  self iprintlnbold("Extraction Start!");
  level._id_581B = scripts\engine\utility::array_add(level._id_581B, self);
  self._id_5835 = var_0;
  self._id_583B = 10;
  thread _id_DCA7();
}

_id_DCA7() {
  self endon("death_or_disconnect");
  self endon("extactionCancel");

  while(self._id_583B > 0) {
    self iprintlnbold("Extracting in " + scripts\engine\math::_id_C933(self._id_583B, 1));
    waitframe();
  }
}

_id_57F6() {
  self notify("extactionCancel");
  self iprintlnbold("Extraction Canceled!");
  level._id_581B = scripts\engine\utility::array_remove(level._id_581B, self);
  self._id_5835 = undefined;
  self._id_583B = undefined;
}

_id_57F7() {
  self iprintlnbold("Extraction Complete!");
  level._id_581B = scripts\engine\utility::array_remove(level._id_581B, self);
  self._id_5833 = 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_EXTRACTED");
}

_id_1F1F(var_0) {
  if(!isDefined(level._id_BEAF._id_EFA9) || scripts\engine\utility::array_contains(level._id_BEAF._id_EFA9, var_0.team)) {
    return;
  }
  var_1 = [];

  foreach(var_3 in level._id_FF5E) {
    var_1 = scripts\engine\utility::array_combine(var_1, _func_03C2("brloot_" + var_3 + "_tablet"));
  }

  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_10, var_8 in var_1) {
    var_9 = scripts\engine\utility::_id_4B8C(var_0.origin, var_8.origin);

    if(var_9 <= 16777216 && var_9 >= 16384) {
      var_0 scripts\mp\gametypes\br_quest_util::_id_EDD4(var_8);
      return;
    }

    if(!isDefined(var_5) || var_9 < var_6) {
      var_5 = var_8;
      var_6 = var_9;
    }
  }

  if(isDefined(var_5)) {
    var_0 scripts\mp\gametypes\br_quest_util::_id_EDD4(var_5);
  }
}

_id_9F9C(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(var_4 == "circle_peek") {
      continue;
    }
    var_1[var_4] = var_3;
  }

  return var_1;
}

_id_7483(var_0) {
  var_1 = [];

  if(isDefined(var_0) && var_0 != "tie") {
    var_1 = scripts\mp\utility\teams::_id_6DCA(var_0, "players");
  }

  var_2 = scripts\mp\gamelogic::_id_692B();

  foreach(var_4 in level.players) {
    if(var_1.size > 0 && scripts\engine\utility::array_contains(var_1, var_4)) {
      var_4 setclientomnvar("post_game_state", var_2);
      var_4 setclientomnvar("ui_br_end_game_splash_type", 11);
      continue;
    }

    var_4 setclientomnvar("post_game_state", var_2);
    var_4 setclientomnvar("ui_br_end_game_splash_type", 12);
  }
}

_id_FD5A(var_0, var_1, var_2) {
  var_3 = scripts\mp\gamescore::_id_0C0F(var_1);
  var_4 = var_0 - var_3;

  if(var_4 != 0) {
    var_5 = scripts\engine\utility::ter_op(scripts\mp\gametypes\br_public::_id_8805(), 1, undefined);
    level thread scripts\mp\gamescore::_id_7001(var_1, var_4, 0, undefined, var_5, var_2);
  }

  return var_4;
}

_id_FCB5() {
  level notify("restartLootLeaders");
  level endon("restartLootLeaders");
  level endon("game_ended");
  var_0 = getdvarfloat("#x3640c280f1754d9bd", 15.0);
  var_1 = getdvarfloat("#x343fe171b799e857c", 5.0);
  var_2 = getdvarint("#x3ead508ebaef724db", 800);
  var_3 = getdvarint("#x3cad194851628413e", 200);
  var_4 = var_0 - var_1;
  _id_07D1::_id_60C2("placement_updates_allowed");

  for(;;) {
    level._id_B97A = 1;
    scripts\engine\utility::_id_108F5("bmo_overtime_start", var_4);

    if(var_1 > 0) {
      foreach(var_6 in level._id_9888) {
        var_6._id_9AAD _meth_872D(2);
      }

      scripts\engine\utility::_id_108F5("bmo_overtime_start", var_1);

      foreach(var_6 in level._id_9888) {
        var_6._id_9AAD _meth_872D(0);
      }
    }
  }
}

_id_FC2E(var_0, var_1, var_2) {
  var_3 = gettime();
  var_2 = var_2 * 1000;
  var_4 = int(var_3 + var_2);
  var_5 = abs(var_0 - var_1);

  for(;;) {
    var_3 = gettime();
    var_6 = clamp(1.0 - (var_4 - var_3) / var_2, 0.0, 1.0);
    var_7 = scripts\engine\utility::ter_op(var_0 < var_1, var_5 * var_6 + var_0, var_0 - var_5 * var_6);
    setDvar("#x3884a85e52bd6f1a5", var_7);

    if(var_6 == 1.0) {
      break;
    }

    waitframe();
  }
}

_id_FCB4(var_0, var_1, var_2, var_3) {
  level._id_9892 = level._id_9891;
  level._id_9891 = [];

  if(level._id_9890) {
    if(istrue(level._id_25BB)) {
      level._id_9887 = _id_11A2();

      foreach(var_5 in level._id_9888) {
        var_5._id_9AAD hide();
      }
    }
  }

  if(level._id_988B == 1) {
    for(var_7 = 0; var_7 < level._id_9887; var_7++) {
      var_8 = _id_6B23(var_7, var_0, var_3);

      if(isDefined(var_8)) {
        level._id_9891[level._id_9891.size] = var_2[var_8];

        if(istrue(level._id_57A8)) {
          if(isDefined(var_2[var_8]._id_57A9)) {
            _id_C503(var_2[var_8]._id_57A9);
          }
        }
      }
    }
  } else if(level._id_988B == 2) {
    var_8 = _id_6B23(0, var_0, var_3);

    if(isDefined(var_8)) {
      level._id_9891[0] = var_2[var_8];

      if(istrue(level._id_57A8)) {
        if(isDefined(var_2[var_8]._id_57A9)) {
          _id_C503(var_2[var_8]._id_57A9);
        }
      }
    }

    foreach(var_10 in var_1) {
      var_11 = var_2[var_10];
      var_12 = var_0[var_10];

      if(var_12 == 0) {
        break;
      }

      if(scripts\engine\utility::array_contains(level._id_9891, var_11)) {
        continue;
      }
      level._id_9891[level._id_9891.size] = var_11;

      if(istrue(level._id_57A8)) {
        if(isDefined(var_11._id_57A9)) {
          _id_C503(var_11._id_57A9);
        }
      }

      if(level._id_9891.size == level._id_9887) {
        break;
      }
    }
  } else {
    foreach(var_11 in var_1) {
      var_12 = var_0[var_11];

      if(var_12 == 0) {
        break;
      }

      level._id_9891[level._id_9891.size] = var_2[var_11];

      if(istrue(level._id_57A8)) {
        if(isDefined(var_2[var_11]._id_57A9)) {
          _id_C503(var_2[var_11]._id_57A9);
        }
      }

      if(level._id_9891.size == level._id_9887) {
        break;
      }
    }
  }

  foreach(var_11 in level._id_9892) {
    if(isDefined(var_11) && !scripts\engine\utility::array_contains(level._id_9891, var_11)) {
      _id_C504(var_11);
    }
  }

  for(var_7 = 0; var_7 < level._id_9887; var_7++) {
    var_18 = level._id_9888[var_7];

    if(isDefined(level._id_9891[var_7])) {
      var_18._id_EEF3 = level._id_9891[var_7];
      var_18._id_EEF3._id_9886 = var_18;
      var_19 = (var_18._id_EEF3.origin[0], var_18._id_EEF3.origin[1], level._id_9889);

      if(!scripts\mp\gametypes\br_public::_id_8805()) {
        var_19 = var_19 + scripts\engine\math::_id_BFF0() * randomfloatrange(100, 1000);
      }

      var_18 scripts\mp\gametypes\br_quest_util::_id_A249(var_19);

      if(istrue(level._id_988A)) {
        _id_FCB3(var_18);
      }

      var_20 = scripts\engine\utility::array_contains(level._id_9891, var_18._id_EEF3) && !scripts\engine\utility::array_contains(level._id_9892, var_18._id_EEF3);
      var_21 = scripts\mp\utility\teams::_id_69FD(var_18._id_EEF3.team, 0);

      foreach(var_11 in var_21) {
        var_18 scripts\mp\gametypes\br_quest_util::_id_DCDA(var_11);
      }

      var_24 = scripts\mp\utility\teams::_id_6A59(var_18._id_EEF3.team, 0);

      foreach(var_11 in var_24) {
        var_18 scripts\mp\gametypes\br_quest_util::_id_7913(var_11);
      }

      if(var_20) {
        _id_1110(var_18);
      }

      continue;
    }

    var_18._id_EEF3 = undefined;

    foreach(var_11 in level.players) {
      var_18 scripts\mp\gametypes\br_quest_util::_id_7913(var_11);
    }
  }
}

_id_6B23(var_0, var_1, var_2) {
  var_3 = var_2[var_0];
  var_4 = 0;
  var_5 = 0;

  if(level._id_EF6A[var_3]["players"].size == 0) {
    return undefined;
  }

  var_6 = level._id_EF6A[var_3]["players"][0].guid;

  foreach(var_8 in level._id_EF6A[var_3]["players"]) {
    var_4 = var_1[var_8.guid];

    if(var_4 > var_5) {
      var_5 = var_4;
      var_6 = var_8.guid;
    }
  }

  return var_6;
}

_id_1110(var_0) {
  var_1 = var_0._id_EEF3;

  if(scripts\mp\utility\player::isreallyalive(var_1)) {
    if(!scripts\mp\gametypes\br_public::_id_8805()) {
      var_1 scripts\mp\hud_message::showsplash("bm_player_marked");
    }

    var_1 _id_3304();

    if(istrue(level._id_57A8)) {
      var_1 thread _id_10B3A(var_0);
    }
  }
}

_id_C504(var_0) {
  if(isDefined(var_0._id_1D7D)) {
    var_0 _id_3305();
  }

  if(isDefined(var_0._id_9886)) {
    foreach(var_2 in level.players) {
      var_0._id_9886 scripts\mp\gametypes\br_quest_util::_id_7913(var_2);
    }

    var_4 = var_0._id_9886._id_3730;

    if(istrue(level._id_57A8)) {
      _id_110F(var_0, var_4);
    }

    var_0._id_9886._id_EEF3 = undefined;
    var_0._id_9886 = undefined;
  }

  level._id_9891 = scripts\engine\utility::array_remove(level._id_9891, var_0);
}

_id_10B3A(var_0) {
  self endon("disconnect");
  self waittill("death");
  var_1 = self._id_9886._id_3730;
  _id_C504(self);
  _id_110F(self, var_1);
}

_id_110F(var_0, var_1) {
  if(scripts\engine\utility::array_contains(level._id_57AB, var_0)) {
    return;
  }
  level._id_57AB = scripts\engine\utility::array_add(level._id_57AB, var_0);
  var_2 = undefined;

  foreach(var_4 in level._id_57AA) {
    if(!isDefined(var_4._id_EEF3)) {
      var_2 = var_4;
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_6 = undefined;

    foreach(var_4 in level._id_57AA) {
      if(!isDefined(var_6) || var_4._id_90B8 < var_6) {
        var_6 = var_4._id_90B8;
        var_2 = var_4;
      }
    }

    var_2._id_EEF3 notify("stop_update");
  }

  var_2._id_EEF3 = var_0;
  var_2._id_90B8 = gettime();
  var_0._id_57A9 = var_2;

  if(isDefined(var_1)) {
    var_2 scripts\mp\gametypes\br_quest_util::_id_A249(var_1);
  } else {
    var_9 = (var_2._id_EEF3.origin[0], var_2._id_EEF3.origin[1], level._id_9889);
    var_9 = var_9 + scripts\engine\math::_id_BFF0() * randomfloatrange(100, 1000);
    var_2 scripts\mp\gametypes\br_quest_util::_id_A249(var_9);
  }

  if(istrue(level._id_988A)) {
    _id_FCB3(var_2);
  }

  var_10 = scripts\mp\utility\teams::_id_69FD(var_2._id_EEF3.team, 0);

  foreach(var_4 in var_10) {
    var_2 scripts\mp\gametypes\br_quest_util::_id_DCDA(var_4);
  }

  var_13 = scripts\mp\utility\teams::_id_6A59(var_2._id_EEF3.team, 0);

  foreach(var_4 in var_13) {
    var_2 scripts\mp\gametypes\br_quest_util::_id_7913(var_4);
  }

  thread _id_FC5F(var_2);
}

_id_FC5F(var_0) {
  var_0._id_EEF3 endon("stop_update");
  wait 5.0;
  _id_C503(var_0);
}

_id_C503(var_0) {
  var_1 = var_0._id_EEF3;
  level._id_57AB = scripts\engine\utility::array_remove(level._id_57AB, var_0._id_EEF3);
  var_0._id_EEF3._id_57A9 = undefined;
  var_0._id_EEF3 = undefined;

  foreach(var_3 in level.players) {
    var_0 scripts\mp\gametypes\br_quest_util::_id_7913(var_3);
  }

  var_1 notify("stop_update");
}

_id_3304() {
  self attach("accessory_money_bag_large_closed_player", "tag_stowed_back3", 1);
  self._id_1D7D = "accessory_money_bag_large_closed_player";

  if(self tagexists("j_bag_left")) {
    playFXOnTag(level._effect["vfx_br_cashLeaderBag"], self, "j_bag_left");
  }

  thread _id_3303();
}

_id_3305() {
  if(isDefined(self) && isDefined(self._id_1D7D)) {
    if(self tagexists("j_bag_left")) {
      stopFXOnTag(level._effect["vfx_br_cashLeaderBag"], self, "j_bag_left");
    }

    self detach(self._id_1D7D, "tag_stowed_back3");
    self._id_1D7D = undefined;
  }

  self notify("killthread_bagModelSwap");
}

_id_3303() {
  self notify("cashleader_trackDeath");
  self endon("cashleader_trackDeath");
  self endon("killthread_bagModelSwap");
  self waittill("death");
  _id_3305();
}

_id_ADCC(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(isDefined(self._id_B956)) {
    var_2 = var_2 + self._id_B956;
  }

  if(isDefined(self._id_B955)) {
    var_2 = var_2 + self._id_B955;
  }

  var_2 = int(var_2 / 10);

  if(var_2 > 4095) {
    var_2 = 4095;
  }

  var_1 = var_2;
  var_3 = 0;

  if(isDefined(self._id_9F9B)) {
    var_3 = var_3 + self._id_9F9B;
  }

  if(var_3 > 15) {
    var_3 = 15;
  }

  var_1 = var_1 + (var_3 << 12);
  scripts\mp\utility\stats::_id_D550(var_1);
}

_id_ADC9() {
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self._id_B956)) {
    var_1 = var_1 + self._id_B956;
  }

  if(isDefined(self._id_B955)) {
    var_1 = var_1 + self._id_B955;
  }

  var_1 = int(var_1 / 10);

  if(var_1 > 4095) {
    var_1 = 4095;
  }

  var_0 = var_1;
  var_2 = 0;

  if(isDefined(self._id_9F9B)) {
    var_2 = var_2 + self._id_9F9B;
  }

  if(var_2 > 15) {
    var_2 = 15;
  }

  var_0 = var_0 + (var_2 << 12);
  return var_0;
}

_id_B713() {
  self endon("disconnect");

  if(isDefined(level._id_9891) && scripts\engine\utility::array_contains(level._id_9891, self)) {
    scripts\mp\hud_message::showsplash("bm_player_marked");
    _id_3304();
  }
}

_id_FCB3(var_0) {
  if(isDefined(var_0._id_EEF3._id_B956)) {
    var_1 = var_0._id_EEF3._id_B956;
  } else {
    var_1 = 0;
  }

  var_1 = clamp(var_1, level._id_988F, level._id_988D);
  var_2 = level._id_988D - level._id_988F;
  var_3 = (var_1 - level._id_988F) / var_2;
  var_4 = level._id_988E - level._id_988C;
  var_5 = level._id_988E - var_3 * var_4;
  var_0 scripts\mp\gametypes\br_quest_util::_id_D5EE(var_5);
}

_id_11A2(var_0) {
  var_1 = 0;
  var_0 = scripts\mp\gamescore::_id_6DD9();
  var_2 = _id_6E98();

  for(var_3 = 1; var_3 < level._id_9C86 + 1; var_3++) {
    foreach(var_5 in level._id_EF89) {
      if(var_0[var_5] != var_3) {
        continue;
      }
      var_6 = _id_6DD5(var_5) * 100;

      if(var_6 >= var_2 || var_0[var_5] == 1) {
        var_1++;
      }
    }
  }

  if(var_1 > level._id_9C86) {
    var_1 = level._id_9C86;
  }

  return var_1;
}

_id_4B7B(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 20;
  var_1 = var_1 * 100;
  var_5 = var_0._id_B956 * 100;
  var_6 = var_5 + var_1;
  var_7 = var_6;
  var_8 = var_5;
  var_9 = var_8 - var_6;
  var_10 = scripts\engine\utility::_id_DD3F(var_9);
  var_11 = var_9 / 2.0;
  var_12 = int(var_11 * 2 * level._id_5F3A);

  if(var_12 == 0) {
    return;
  }
  var_13 = _id_3FF3(&"MP_BR_INGAME/PLUNDER_DEATH_LOSS", var_1, "RIGHT", "CENTER", var_2 + 46, var_3, undefined, undefined, 1.25, var_0);
  var_13.alpha = 1;
  var_14 = _id_3FF3(&"MP_BR_INGAME/YOUR_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", var_2, var_3 + var_4, undefined, undefined, 1.25, var_0);
  var_14.alpha = 1;
  var_15 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_PLUNDER", var_6, "LEFT", "CENTER", var_2 + 45, var_3 + var_4, undefined, undefined, 1.25, var_0);
  var_15.alpha = 1;
  wait 1.0;

  while(var_7 != var_8) {
    var_7 = var_7 + var_12;

    if(var_10 > 0 && var_7 > var_8 || var_10 < 0 && var_7 < var_8) {
      var_7 = var_8;
    }

    var_15 _meth_83A3(var_7);
    wait(level._id_5F3A);
  }

  wait 3.0;
  var_13 destroy();
  var_14 destroy();
  var_15 destroy();
}

_id_0C07(var_0, var_1, var_2) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }
  var_3 = [];
  var_4 = [];

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_4 = int(min(var_1, var_0.size));
  }

  if(level._id_D869) {
    var_5 = 0;

    if(level._id_11A1 > 0 && istrue(var_2)) {
      var_6 = 0;

      for(var_7 = 0; var_7 < var_4; var_7++) {
        if(var_6 > level._id_ADD2.size - 1) {
          var_6 = 0;
        }

        var_8 = level._id_ADD2[var_6];

        foreach(var_10 in var_0) {
          if(_id_B9BB(var_10.origin, var_8, level._id_B9BC)) {
            var_3[var_3.size] = var_10;
            var_0 = scripts\engine\utility::array_remove(var_0, var_10);
            break;
          }
        }

        var_6++;
      }
    } else {
      foreach(var_10 in var_0) {
        var_5 = 0;

        foreach(var_14 in level._id_BE95) {
          var_15 = scripts\engine\utility::_id_4B8C(var_14, var_10.origin);

          if(var_5 == 0 || var_15 < var_5) {
            var_5 = var_15;
            var_10._id_39F4 = var_14;
          }
        }
      }

      var_6 = 0;

      for(var_7 = 0; var_7 < var_4; var_7++) {
        if(var_6 > level._id_BE95.size - 1) {
          var_6 = 0;
        }

        var_8 = level._id_BE95[var_6];

        foreach(var_10 in var_0) {
          if(isDefined(var_10._id_39F4) && var_10._id_39F4 == var_8) {
            var_3[var_3.size] = var_10;
            var_0 = scripts\engine\utility::array_remove(var_0, var_10);
            break;
          }
        }

        var_6++;
      }
    }
  } else if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_4 = int(min(var_1, var_0.size));

    for(var_7 = 0; var_7 < var_4; var_7++) {
      var_3[var_3.size] = var_0[var_7];
    }
  }

  if(istrue(level._id_78E7)) {
    foreach(var_21 in var_0) {
      if(!scripts\engine\utility::array_contains(var_3, var_21)) {
        var_21 setscriptablepartstate(var_21.type, "hidden");
      }
    }
  }

  return var_3;
}

_id_B9BB(var_0, var_1, var_2) {
  var_3 = var_1[0] - var_2;
  var_4 = var_1[0] + var_2;
  var_5 = var_1[1] - var_2;
  var_6 = var_1[1] + var_2;
  return var_0[0] >= var_3 && var_0[0] <= var_4 && var_0[1] >= var_5 && var_0[1] <= var_6;
}

_id_0C0B(var_0, var_1) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }
  var_2 = undefined;

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!scripts\engine\utility::array_contains(level._id_2AA1, var_0[var_3])) {
        var_2 = var_0[var_3];
        break;
      }
    }
  }

  return var_2;
}

_id_5AFA(var_0) {
  var_1 = _id_0C0B(scripts\mp\gametypes\br_plunder::_id_68A6(), level._id_9C99);
  var_1._id_4A88 = undefined;
  var_1._id_779F = undefined;
  var_2 = scripts\engine\utility::ter_op(level._id_DCD7 && !level._id_DCCB, var_1._id_0F3E, var_1._id_0F60);
  var_1 setscriptablepartstate(var_1.type, var_2);

  if(level._id_DCD7 && level._id_DCCB) {
    _id_07F9::_id_C799(var_0._id_96C9._id_A8DA);
    var_0._id_96C9._id_A8DA = -1;
    var_3 = spawnStruct();
    var_3 _id_403A("ui_mp_br_mapmenu_icon_atm", "current", var_1.origin + (0, 0, 200));
    var_1._id_96C9 = var_3;
  }

  level._id_2AA1 = scripts\engine\utility::array_remove(level._id_2AA1, var_0);
  level._id_2AA1 = scripts\engine\utility::array_add(level._id_2AA1, var_1);
}

_id_E70D() {
  _id_07D1::_id_60C2("prematch_done");
  waitframe();

  foreach(var_1 in level._id_2AA1) {
    var_1._id_4A88 = undefined;
    var_2 = scripts\engine\utility::ter_op(level._id_DCD7 && !level._id_DCCB, var_1._id_0F3E, var_1._id_0F60);
    var_1 setscriptablepartstate(var_1.type, var_2);
    var_1 thread _id_CA6D();

    if(level._id_DCD7 && level._id_DCCB) {
      var_1._id_96C9 thread _id_F236();
    }
  }

  level thread _id_CA38();
}

_id_CA6D() {
  wait(level._id_F235);
  self._id_4A88 = 1;
  self._id_779F = 1;
  self setscriptablepartstate(self.type, self._id_4AAB);
}

_id_CA38() {
  wait(level._id_F235 + 1);
  level._id_2AA1 = _id_0C07(scripts\mp\gametypes\br_plunder::_id_68A6(), level._id_9C99);

  if(level._id_DCD7 && level._id_DCCB) {
    level thread _id_3FEC();
  }

  level thread _id_E70D();
}

_id_3FEC() {
  _id_07D1::_id_60C2("prematch_done");

  foreach(var_1 in level._id_2AA1) {
    var_2 = spawnStruct();
    var_2 _id_403A("ui_mp_br_mapmenu_icon_atm", "current", var_1.origin + (0, 0, 200));
    var_1._id_96C9 = var_2;
  }
}

_id_F236() {
  var_0 = level._id_F235;
  var_1 = level._id_5F3A;
  var_2 = var_1 * 1000;
  var_3 = var_0 * 1000;
  var_4 = var_3 - var_2;
  var_5 = gettime() + var_3;

  while(gettime() < var_5) {
    var_6 = var_4 / var_3;
    _id_07F9::_id_A8C4(self._id_A8DA, 1);
    _id_07F9::_id_A8B4(self._id_A8DA, var_6);
    var_4 = max(var_4 - var_2, 1);
    waitframe();
  }

  _id_07F9::_id_C799(self._id_A8DA);
  self._id_A8DA = -1;
}

_id_403A(var_0, var_1, var_2) {
  self._id_A8DA = _id_07F9::_id_C57D(1);

  if(self._id_A8DA != -1) {
    _id_07F9::_id_A867(self._id_A8DA, var_1, (0, 0, 0), var_0);
    _id_07F9::_id_FB98(self._id_A8DA, 1);
    _func_018C(self._id_A8DA);
    _id_07F9::_id_A8B1(self._id_A8DA, 1);

    if(isDefined(var_2)) {
      _id_A24B(var_2);
    }
  } else {}
}

_id_A24B(var_0) {
  _id_07F9::_id_FB97(self._id_A8DA, var_0);
}

_id_DCDC(var_0) {
  _func_0185(self._id_A8DA, var_0);
}

_id_DCDB(var_0) {
  _func_0188(var_0);
}

_id_7914(var_0) {
  _func_0189(self._id_A8DA, var_0);
}

_id_4789() {
  _id_07F9::_id_A89F(self._id_A8DA);
  _id_07F9::_id_C799(self._id_A8DA);
}

_id_E681(var_0) {
  level _id_D547();
  level thread _id_DCA5(var_0);

  if(level._id_EF91) {
    level thread _id_E73C(var_0);
  }

  if(level._id_EF8F) {
    level thread _id_C4ED();
  }

  level thread _id_E6A8();
  level thread _id_A717(var_0);
}

_id_D547() {
  scripts\mp\gamelogic::resumetimer();
  level._id_E72D = gettime();
  level._id_4B0D = 0;
  level._id_F25E = 0;
  var_0 = getdvarfloat("#x35f447690166872a4", 180);
  var_1 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_timelimit");
  level._id_10AD4[var_1]._id_04CB = var_0;
  level._id_AD6A[var_1] = var_0;
}

_id_DCA5(var_0) {
  foreach(var_2 in level._id_EF89) {
    scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_requested", var_2);
  }

  foreach(var_5 in level.players) {
    var_5 thread scripts\mp\hud_message::showsplash("callout_bmo_exfil_winners");
    var_5 _id_0A99::_id_D5EA(71, undefined, 20);
  }
}

_id_E73C(var_0) {
  level.radarmode[var_0] = "normal_radar";
  level._id_0F66[var_0] = 1;
  level._id_0F37[var_0] = 0;
  _id_09BD::_id_0CF1(var_0, 4);
}

_id_C4ED() {
  level._id_9887 = 1;

  if(getdvarint("#x38172128f6aac4b0a", 0) == 1) {
    if(getdvarfloat("#x3640c280f1754d9bd", 15.0) > 0.0) {
      level thread _id_FCB5();
    }
  }
}

_id_E6A8() {
  foreach(var_1 in level._id_2AA1) {
    var_1 setscriptablepartstate(var_1.type, "inuse");
    var_2 = getgroundposition(var_1.origin, 1) + (0, 0, 2);
    var_3 = level.players[0];

    for(var_4 = 0; var_4 < 200; var_4++) {
      var_3 = _id_5ADD();

      if(isPlayer(var_3)) {
        break;
      }
    }

    var_2 = getgroundposition(var_1.origin, 1) + (0, 0, 2);
    var_5 = var_3 _id_B7CE(var_2, var_1);

    if(isDefined(var_5)) {
      var_5._id_DD67 = var_1;
      var_1._id_766D = var_5;
      var_5 _id_7797(var_2);
      var_5 thread _id_583E();
    }
  }
}

_id_B7CE(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, 2500);
  var_4 = _id_5AE4(var_3, var_1);
  var_5 = (0, var_4, 0);

  if(getdvarint("#x35f8536dae74161e4", 1) == 1) {
    var_6 = -100;
    var_7 = 60;
    var_8 = anglesToForward(var_5);
    var_9 = anglestoright(var_5);
    var_2 = var_2 + var_8 * var_6 + var_9 * var_7;
  }

  var_10 = var_3 + -1 * anglesToForward(var_5) * 30000;
  var_11 = var_3 + anglesToForward(var_5) * 30000;
  var_12 = _id_E2FA(self, var_10, var_3, var_11);
  return var_12;
}

_id_583E() {
  self endon("death");
  self endon("leaving");
  self setvehgoalpos(self._id_AEDC, 1);
  self _meth_838A(self._id_7092);
  var_0 = _id_F3CA(self._id_AEDC);
  var_1 = self._id_AEDC[2] - var_0;
  self._id_5D49 = _id_2EE9(var_1);
  _id_77E3(1, self._id_5D49);
  self waittill("goal");

  foreach(var_3 in level.players) {
    var_3 _id_0A99::_id_D5EA(72, undefined, 20);
  }

  thread _id_77EA();
  thread _id_77A0();
  _id_779A(self._id_533D, var_0);

  foreach(var_6 in level._id_EF89) {
    level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_chopper_arrive", var_6, 1);
  }

  _id_77C4();
  _id_776C();

  foreach(var_6 in level._id_EF89) {
    level thread scripts\mp\gametypes\br_public::_id_2BDE("plunder_extract_chopper_leave", var_6, 1);
  }

  thread _id_77C2();
}

_id_77C4() {
  self._id_87F9 = 1;
  self._id_FDB2 = self._id_3E6D;
  var_0 = self._id_FDB2;
  var_0 makeuseable();
  var_0 setcursorhint("HINT_NOICON");
  var_0 setuseholdduration("duration_medium");
  var_0 sethintrequiresholding(1);
  var_0 setuserange(230);
  var_0 sethintstring(&"MP/BR_USE_EXFIL_CHOPPER");
  var_1 = level._id_2A35.size;
  level._id_2A35[var_1] = var_0;

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
  }

  thread _id_776B();
  thread _id_77B2(var_0);
  _id_77E3(2, 300);
  wait 300;
  self._id_87F9 = 0;
  _id_77E8();
}

_id_77B2(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 scripts\mp\hud_message::showsplash("callout_exfil_success");
    var_1 playerhide();
    var_1 _meth_8736(0);
    var_1 allowmovement(0);
    var_1 allowfire(0);
    var_1 disableoffhandprimaryweapons(0);
    var_1 disableoffhandsecondaryweapons(0);
    var_1 disableweapons(0);
    var_1 disableweaponswitch(0);
    var_1 setcamerathirdperson(1);
    var_1 allowcrouch(0);
    var_1 allowmelee(0);
    var_1 allowjump(0);
    var_1 allowprone(0);
    var_1 scripts\common\utility::_id_154F(0);
    var_1 scripts\common\utility::_id_1587(0);
    var_1._id_CACF = 1;
    var_0 disableplayeruse(var_1);
  }
}

_id_7625() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    self.health = 99999;
  }
}

_id_F3CA(var_0) {
  var_1 = 256;
  var_2 = _id_F3CB(var_0, 100, [self]);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

_id_5AE4(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1._id_5CF6)) {
    return var_1._id_5CF6;
  }

  var_2 = 10;
  var_3 = scripts\engine\trace::_id_3F94();

  for(var_4 = 0; var_4 < 360; var_4 = var_4 + var_2) {
    var_5 = (0, var_4, 0);
    var_6 = var_0 + -1 * anglesToForward(var_5) * 30000;
    var_7 = var_0 + anglesToForward(var_5) * 30000;
    var_8 = scripts\engine\trace::_id_E409(var_0, var_7, 100, undefined, var_3, 1);

    if(var_8["fraction"] == 1) {
      if(isDefined(var_1)) {
        var_1._id_5CF6 = var_4;
      }

      return var_4;
    }

    if(var_4 % 3 == 0) {
      waitframe();
    }
  }

  var_4 = randomfloat(360);

  if(isDefined(var_1)) {
    var_1._id_5CF6 = var_4;
  }

  return var_4;
}

_id_A717(var_0) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_nuke_timer_type", 1);
  setomnvar("ui_nuke_timer_time", level._id_EF90);
  setomnvar("ui_nuke_countdown_active", 1);
  var_1 = gettime();
  var_2 = level._id_EF90 * 1000 + var_1;
  setomnvar("ui_nuke_end_milliseconds", level._id_EF90 * 1000 + var_1);

  for(;;) {
    waitframe();

    if(gettime() > var_2) {
      break;
    }
  }

  level thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["dmz_plunder_win"], game["end_reason"]["dmz_plunder_loss"], 0, 1);
  setomnvar("ui_nuke_countdown_active", 0);
}

_id_F62E(var_0, var_1, var_2) {
  if(istrue(level._id_25BB)) {
    if(istrue(level._id_21D1) && istrue(var_1)) {
      level thread _id_25BA();
    }

    return;
  }

  level._id_25BB = 1;
  level notify("cancel_announcer_dialog");
  level thread _id_AD72();
  var_3 = scripts\engine\utility::ter_op(level._id_AD72 >= 1, "bm_overtime_double_cash_num", "bm_overtime_double_cash_perc");

  if(isDefined(var_0) && (level._id_4B00 || !level._id_4AD3)) {
    level._id_81FB = var_0;
    _id_DCE7(var_0, "bm_overtime_start_them");
    _id_DCE8(var_0, "bm_overtime_start_us");
    level thread scripts\mp\gametypes\br_public::_id_2BDE("bm_gamestate_overtime", var_0);

    foreach(var_5 in level._id_EF89) {
      if(var_5 != var_0) {
        level thread scripts\mp\gametypes\br_public::_id_2BDE("bm_gamestate_overtime_enemy", var_5);
      }
    }
  } else
    level._id_81FB = _id_6ABF();

  if(!isDefined(var_2)) {
    scripts\mp\gamelogic::resumetimer();
    level._id_E72D = gettime();
    level._id_4B0D = 0;
    level._id_F25E = 0;
    var_7 = scripts\engine\utility::ter_op(level._id_4AD3 || istrue(var_2), 7, 12);
    var_8 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_timelimit");
    level._id_10AD4[var_8]._id_04CB = var_7;
    level._id_AD6A[var_8] = var_7;

    if(!level._id_4AD3) {
      wait 5;
    }

    _id_DCE6(var_3);
    wait 5;
    level._id_ABC2 = level._id_4C6D;
    level._id_4203 = 0.0;
    level._id_31B5 = 1;
    level notify("bmo_overtime_start");
  } else {
    level._id_ABC2 = level._id_4C6D;
    level._id_4203 = 0.0;
    level._id_31B5 = 1;
    level notify("bmo_overtime_start");
    level._id_5EAB = 1;
    level._id_5EB6 = 1;
    _id_DCE6(var_3);
    wait 5;
  }

  level._id_5EAB = undefined;
  _id_07D1::_id_60C2("overtime_started");
  setomnvar("ui_br_circle_state", 7);

  if(!isDefined(var_2)) {
    var_9 = gettime() + int(level._id_4C6D * 1000);
    setomnvar("ui_hardpoint_timer", var_9);
  }

  wait(int(max(level._id_4C6D - 60, 0)));
  setomnvar("ui_br_circle_state", 8);
}

_id_6ABF() {
  var_0 = "";

  foreach(var_2 in level._id_EF89) {
    var_3 = game["teamPlacements"][var_2];

    if(var_3 == 1) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

_id_ABC0() {
  if(level._id_EF92 && level._id_4C6D > 0 && !istrue(level._id_25BB)) {
    if(!isDefined(level._id_81FB)) {
      level._id_81FB = _id_6ABF();
    }

    level thread _id_F62E(level._id_81FB, level._id_EF6A[level._id_81FB]["plunderBanked"] * 1000 >= _id_6E98());
    level waittill("bmo_overtime_start");

    while(level._id_4203 < level._id_ABC2) {
      wait(level._id_5F3A);
    }
  }

  level thread _id_25BA();
}

_id_25BA() {
  if(istrue(level.gameended)) {
    return;
  }
  level thread _id_7420();
  level thread scripts\mp\gamelogic::_id_52F7(level._id_2BB5._id_5BDE, game["end_reason"]["dmz_plunder_win"], game["end_reason"]["dmz_plunder_loss"], 0, 1);
}

_id_7420() {
  var_0 = scripts\mp\gamelogic::_id_692B();

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("post_game_state", var_0);
  }
}

_id_B7CD() {
  if(!istrue(self._id_3C69)) {
    scripts\mp\utility\player::_freezecontrols(1);
  }

  var_0 = spawnStruct();
  var_1 = self getspectatingplayer();

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;

  if(!var_1 isonground()) {
    var_2 = scripts\engine\trace::_id_3EF6(1);
    var_0.origin = scripts\engine\utility::_id_5000(var_0.origin, 0, -20000, undefined, var_2);
  }

  var_0.origin = var_0.origin + (0, 0, 100);

  if(!isDefined(level._id_5325)) {
    level._id_5325 = 1;
    level thread _id_F60F();
  }

  return 1;
}

_id_553A() {
  level waittill("give_match_bonus");
  waitframe();
  var_0 = getdvarfloat("#x3db55339097706eca", 1.0);
  var_1 = getdvarfloat("#x3f4481b0ddcf0449e", 1.0);
  var_2 = getdvarint("#x37843668f1eeff80c", 10000);
  var_3 = getdvarint("#x3bfe23d92331b3c64", 7500);
  var_4 = getdvarint("#x3b5231b87260ecd1c", 5000);

  foreach(var_6 in level._id_EF89) {
    var_7 = _id_6DD5(var_6) * 100;
    var_8 = var_7 >= _id_6E98();
    var_9 = game["teamPlacements"][var_6];
    var_10 = 0;

    if(var_8) {
      var_10 = var_3;
    } else if(var_9 <= 10) {
      var_10 = var_4;
    }

    var_11 = scripts\mp\utility\teams::_id_6DCA(var_6, "players");

    foreach(var_13 in var_11) {
      var_13 scripts\mp\gametypes\br::_id_E902();
      var_13 scripts\mp\gametypes\br::_id_6FB7(var_9);

      if(!var_13 scripts\mp\utility\game::rankingenabled() || !var_13 _meth_85AD()) {
        continue;
      }
      var_13 scripts\mp\utility\stats::_id_7DAE("cash", int(var_7 / 10000));
      var_14 = var_13.pers["combatXP"];

      if(!isDefined(var_14)) {
        var_14 = 0;
      }

      var_13 setplayerdata(level.progressiongroup, "aarValue", 0, var_14);
      var_15 = var_13.pers["missionXP"];

      if(!isDefined(var_15)) {
        var_15 = 0;
      }

      var_13 setplayerdata(level.progressiongroup, "aarValue", 1, var_15);
      var_16 = var_13.pers["lootingXP"];

      if(!isDefined(var_16)) {
        var_16 = 0;
      }

      var_13 setplayerdata(level.progressiongroup, "aarValue", 2, var_16);
      var_17 = 0;

      if(isDefined(var_13._id_B956)) {
        var_17 = int(var_13._id_B956 * var_0);
      }

      var_18 = 0;

      if(isDefined(var_13._id_B955)) {
        var_18 = int(var_13._id_B955 * var_1);
      }

      var_19 = var_17 + var_18;

      if(var_19 > 0) {
        var_13 scripts\mp\rank::giverankxp("cash_conversion_bonus", var_19, undefined, 1, 1);
      }

      var_13 setplayerdata(level.progressiongroup, "aarValue", 3, var_19);
      var_20 = 0;

      if(isDefined(var_13._id_9BA8)) {
        var_20 = int(var_13._id_9BA8);
      }

      var_13 setplayerdata(level.progressiongroup, "aarValue", 4, var_20);

      if(var_10 > 0) {
        var_13 scripts\mp\rank::giverankxp("placement_bonus", var_10, undefined, 1, 1);
      }

      var_13 setplayerdata(level.progressiongroup, "aarValue", 5, var_10);
      var_21 = var_13 getplayerdata(level.progressiongroup, "aarValue", 6);
      var_22 = var_21 + var_13.pers["summary"]["xp"];
      var_13 setplayerdata(level.progressiongroup, "aarValue", 7, var_22);
    }
  }
}

_id_818B() {
  var_0 = [];
  level._id_52E7 = [];
  level._id_52E5 = [];

  if(level.mapname == "mp_br_mechanics") {
    level._id_52E7[0] = (8682, -1036, 427);
    level._id_52E5[0] = (14, 163, 0);
    level._id_52E7[1] = (-1139, -3425, 1116);
    level._id_52E5[1] = (33, 75, 0);
    level._id_52E7[2] = (-5567, -4786, 1116);
    level._id_52E5[2] = (37, 192, 0);
  } else {
    level._id_52E7[0] = (-36548, -31983, 2400);
    level._id_52E5[0] = (12, 72, 0);
    level._id_52E7[1] = (-17592, -36440, 1379);
    level._id_52E5[1] = (17, 90, 0);
    level._id_52E7[2] = (-3520, -34298, 1217);
    level._id_52E5[2] = (11, 110, 0);
    level._id_52E7[3] = (-9577, -25957, 360);
    level._id_52E5[3] = (357, 82, 0);
    level._id_52E7[4] = (23022, -26926, 1359);
    level._id_52E5[4] = (16, 101, 0);
    level._id_52E7[5] = (31261, -29753, 1359);
    level._id_52E5[5] = (27, 52, 0);
    level._id_52E7[6] = (44843, -41261, 3220);
    level._id_52E5[6] = (16, 52, 0);
    level._id_52E7[7] = (44229, -15403, 1331);
    level._id_52E5[7] = (13, 72, 0);
    level._id_52E7[8] = (44491, 3484, 1638);
    level._id_52E5[8] = (23, 11, 0);
    level._id_52E7[9] = (16047, -3206, 2613);
    level._id_52E5[9] = (27, 309, 0);
    level._id_52E7[10] = (5668, -5905, 1614);
    level._id_52E5[10] = (23, 304, 0);
    level._id_52E7[11] = (-13412, -20443, 1033);
    level._id_52E5[11] = (11, 109, 0);
    level._id_52E7[12] = (-30369, -7811, 1680);
    level._id_52E5[12] = (31, 339, 0);
    level._id_52E7[13] = (-26278, 4081, 142);
    level._id_52E5[13] = (6, 110, 0);
    level._id_52E7[14] = (-16429, 6021, 847);
    level._id_52E5[14] = (21, 57, 0);
    level._id_52E7[15] = (-7525, 11672, 1082);
    level._id_52E5[15] = (14, 46, 0);
    level._id_52E7[16] = (8356, 15296, 2021);
    level._id_52E5[16] = (12, 38, 0);
    level._id_52E7[17] = (26010, 29975, 2716);
    level._id_52E5[17] = (13, 68, 0);
    level._id_52E7[18] = (12043, 30910, 3081);
    level._id_52E5[18] = (21, 88, 0);
    level._id_52E7[19] = (7127, 52592, 2100);
    level._id_52E5[19] = (28, 241, 0);
    level._id_52E7[20] = (-6693, 56481, 4026);
    level._id_52E5[20] = (16, 246, 0);
    level._id_52E7[21] = (-21394, 37175, 757);
    level._id_52E5[21] = (2, 124, 0);
    level._id_52E7[22] = (-26151, 25577, 271);
    level._id_52E5[22] = (357, 10, 0);
  }

  if(0) {
    _id_52E6();
  }
}

_id_F60F() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    var_2 thread _id_B887(var_2, _id_690B(var_2));
    var_0++;

    if(var_0 == 5) {
      waitframe();
      var_0 = 0;
    }
  }
}

_id_52E6() {
  for(;;) {
    var_0 = getdvarint("#x34e7184849af35d0c", -1);

    if(var_0 > -1) {
      _id_B887(level.players[0], _id_690B(level.players[0]));
      setDvar("#x34e7184849af35d0c", -1);
    }

    waitframe();
  }
}

_id_690B(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_6, var_4 in level._id_52E7) {
    var_5 = distance2dsquared(var_0.origin, var_4);

    if(var_5 <= 9000000) {
      return var_6;
    }

    if(!isDefined(var_2) || var_2 > var_5) {
      var_2 = var_5;
      var_1 = var_6;
    }
  }

  return var_1;
}

_id_B887(var_0, var_1) {
  var_2 = level._id_52E7[var_1];
  var_3 = level._id_52E5[var_1];
  var_4 = var_2 + anglestoright(var_3) * 1000;
  var_5 = var_3;
  var_6 = spawn("script_model", var_2);
  var_6 setModel("tag_origin");
  var_6.angles = var_3;
  var_0 cameralinkto(var_6, "tag_origin");
  var_6 moveto(var_4, 60);
  var_6 rotateto(var_5, 60);

  if(0) {
    wait 5;
    var_0 _meth_8060();
  }
}

_id_BD0B() {
  wait 1;
  var_0 = _id_6E98();
  var_1 = _func_0426(game["teamPlacements"], "up");

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    if(isDefined(level._id_EF6A[var_1[var_2]]["plunderTeamTotal"])) {
      var_3 = _id_6DD5(var_1[var_2]) * 100;
    }
  }
}

_id_8181() {
  wait 1;
  game["dialog"]["gametype"] = "gametype_bmo_plunder";
  game["dialog"]["match_start"] = "gametype_bmo_plunder";
  game["dialog"]["boost_short"] = "boost_bmo_short";
  game["dialog"]["offense_obj"] = "boost_bmo";
  game["dialog"]["defense_obj"] = "boost_bmo";
  game["dialog"]["contract_hold_area"] = "bm_contract_hold_area";
  game["dialog"]["contract_loot_chests"] = "bm_contract_loot_chests";
  game["dialog"]["contract_kill_target"] = "bm_contract_kill_target";
  game["dialog"]["event_chopper"] = "bm_event_chopper";
  game["dialog"]["event_airdrop"] = "bm_event_airdrop";
  game["dialog"]["extract_enabled"] = "bm_extract_enabled";
  game["dialog"]["gamestate_25_perc"] = "bm_gamestate_25_perc";
  game["dialog"]["gamestate_50_perc"] = "bm_gamestate_50_perc";
  game["dialog"]["gamestate_75_perc"] = "bm_gamestate_75_perc";
  game["dialog"]["gamestate_90_perc"] = "bm_gamestate_90_perc";
  game["dialog"]["gamestate_25_perc_enemy"] = "bm_gamestate_25_perc_enemy";
  game["dialog"]["gamestate_50_perc_enemy"] = "bm_gamestate_50_perc_enemy";
  game["dialog"]["gamestate_75_perc_enemy"] = "bm_gamestate_75_perc_enemy";
  game["dialog"]["gamestate_90_perc_enemy"] = "bm_gamestate_90_perc_enemy";
  game["dialog"]["gamestate_25_perc_first"] = "bm_gamestate_25_perc_first";
  game["dialog"]["gamestate_50_perc_first"] = "bm_gamestate_50_perc_first";
  game["dialog"]["gamestate_75_perc_first"] = "bm_gamestate_75_perc_first";
  game["dialog"]["gamestate_90_perc_first"] = "bm_gamestate_90_perc_first";
  game["dialog"]["lead_lost"] = "bm_gamestate_lead_lost";
  game["dialog"]["lead_taken"] = "bm_gamestate_lead_taken";
  game["dialog"]["mission_failure"] = "bm_gamestate_lost";
  game["dialog"]["mission_success"] = "bm_gamestate_win";
  game["dialog"]["gamestate_top_3"] = "bm_gamestate_top_3";
  game["dialog"]["gamestate_top_5"] = "bm_gamestate_top_5";
  game["dialog"]["gamestate_top_10"] = "bm_gamestate_top_10";
  game["dialog"]["bm_gamestate_overtime"] = "bm_gamestate_overtime_million_cash_deposited";
  game["dialog"]["bm_gamestate_overtime_enemy"] = "bm_tut_get_cash";
  game["dialog"]["bm_tut_get_cash"] = "bm_tut_get_cash";
  game["dialog"]["bm_tut_earn_cash"] = "bm_tut_earn_cash";
  game["dialog"]["bm_tut_loot_cash"] = "bm_tut_loot_cash";
  game["dialog"]["event_bank"] = "event_bank";
  game["dialog"]["exfil_arrived"] = "exfil_arrived";
  game["dialog"]["exfil_failed"] = "exfil_failed";
  game["dialog"]["exfil_inbound"] = "exfil_inbound";
  game["dialog"]["exfil_leaving"] = "exfil_leaving";
  game["dialog"]["exfil_start_generic"] = "exfil_start_generic";
  game["dialog"]["exfil_start_win"] = "exfil_start_win";
  game["dialog"]["exfil_start_win_lz"] = "exfil_start_win_lz";
  game["dialog"]["exfil_success_full"] = "exfil_success_full";
  game["dialog"]["exfil_success_partial"] = "exfil_success_partial";
}

_id_10BCA(var_0) {
  level endon("game_ended");
  level endon("cancel_watch_parachuters_overhead");

  for(;;) {
    foreach(var_15, var_2 in level._id_0F53) {
      if(!isDefined(var_2) || !scripts\mp\utility\player::isreallyalive(var_2) || !(var_2 _meth_86B8() || var_2 _meth_86B7())) {
        level._id_0F53[var_15] = undefined;
        continue;
      }

      var_3 = scripts\common\utility::_id_B7B6(var_2.origin, level._id_AE34, undefined, level._id_AE32);
      var_4 = var_2.team;

      foreach(var_6 in var_3) {
        var_7 = var_4 == var_6.team;

        if(var_7) {
          continue;
        }
        var_8 = !scripts\mp\utility\player::isreallyalive(var_6) || istrue(var_6.inlaststand);

        if(var_8) {
          continue;
        }
        var_9 = var_6 _meth_86B8() || var_6 _meth_86B7();

        if(var_9) {
          continue;
        }
        var_10 = gettime();
        var_11 = isDefined(var_6._id_7655) && var_10 - var_6._id_7655 < var_0;

        if(var_11) {
          continue;
        }
        var_6._id_7655 = var_10;
        var_12 = scripts\mp\gametypes\br_public::_id_2BBB(var_6);
        var_13 = game["voice"][var_12];
        var_6 _meth_8287(level._id_0F54[var_13], "respawning_enemy_in_area", 2);
      }

      waitframe();
    }

    waitframe();
  }
}