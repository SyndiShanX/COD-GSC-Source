/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58311.gsc
***********************************************/

_id_13D4C() {
  var_0 = getDvar("_encstr_A9330B9167D26C016997EB79D7");

  if(var_0 == "_encstr_A34C02BB")
    return 1;

  return 0;
}

_id_13D42() {
  if(_id_13D4C())
    return "_encstr_85AB2130F39DCB12EA9F5B2FF2E3C3F574E9BFFFEF5F43CF75907B27F88511E8274F1C";

  return "_encstr_A1931BD58F5063327BA85A61E053AAA770F82E6F252173FD1BCA92BBC0";
}

trial_ui_set_main_score(var_0) {
  if(istrue(level._id_13D2E)) {
    return;
  }
  setomnvar("_encstr_AAAE14C3FA175DF0043989F72D6E60286F339908F357", int(var_0));
}

trial_ui_set_main_time(var_0) {
  if(istrue(level._id_13D2E)) {
    return;
  }
  var_0 = var_0 - var_0 % 100;
  setomnvar("_encstr_BE2813DD7B51B37B03910239786F4F6DF9F9495D8B", int(var_0));
}

trial_ui_set_subscore(var_0) {
  if(istrue(level._id_13D2E)) {
    return;
  }
  setomnvar("_encstr_ABEB121308FF23F3189F447FAEA38B2A2FA0EBEA", int(var_0));
}

trial_ui_set_subtime(var_0) {
  if(istrue(level._id_13D2E)) {
    return;
  }
  var_0 = var_0 - var_0 % 100;
  setomnvar("_encstr_8D361135D47961CBE9FF1091AF2D01A9A27DA5", int(var_0));
}

trial_ui_set_secondary_timer(var_0) {
  setomnvar("_encstr_86AC18D596AFA34EB4C2B1BE9BACB1ED3791584EBCEBE896B5B2", int(var_0));
}

trial_ui_freeze_secondary_timer(var_0) {
  setomnvar("_encstr_AC491F4FD076D4837B1FAD697E1BEA87382097EBF8AE2CFA5B25795FE627B35580", var_0);
}

trial_ui_hide_secondary_timer() {
  setomnvar("_encstr_86AC18D596AFA34EB4C2B1BE9BACB1ED3791584EBCEBE896B5B2", int(-1));
}

trial_ui_set_best_score(var_0) {
  if(istrue(level._id_13D2E)) {
    return;
  }
  game["_encstr_8CA606F38878410D"]["_encstr_9B230BB64D9BDD493B975FDB03"] = var_0;
  setomnvar("_encstr_965E14EA96AFA3E45A5836AF899537D1AF9BD8BDE42B", int(var_0));
}

trial_ui_set_best_time(var_0) {
  if(istrue(level._id_13D2E)) {
    return;
  }
  var_0 = var_0 - var_0 % 100;
  game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] = var_0;
  setomnvar("_encstr_AF8F13DB2C27D846120F49272BFA0E608FC3C05057", int(var_0));
}

trial_ui_set_objective_progress(var_0, var_1) {
  setomnvar("_encstr_A17E1CAD3B01343303F8FBE1F7D968AF03BD2783D180602A32FAB30153BF", var_0);
  setomnvar("_encstr_B49C19759439218BA93FD0511FFAC04B427BE37C6FD1F9109C57D8", var_1);
}

trial_ui_set_wave(var_0, var_1) {
  setomnvar("_encstr_A79317D5D2FAE8272DC2C6FABB0B3BCA7D38C9DB764EB2E637", var_0);
  setomnvar("_encstr_8A8614D351E190168F3290FE7B87CCC009A41F59C195", var_1);
}

_id_13D8D(var_0, var_1) {
  setomnvar("_encstr_BDFB165D93CEF382CB18CAF19833FAA7C386DFC7B6D1A78A", var_0);
  setomnvar("_encstr_9AB513BA96BED1C9D20B8DBE635807BED1B7A3C236", var_1);
}

trial_ui_set_objective_icon_index(var_0) {
  setomnvar("_encstr_BD8C1E836B5FA39AC0F84B7F70594A7AFF7D0CFBC5370AD328A88FAF50B13DF3", var_0);
}

trial_ui_set_reward_tier(var_0) {
  if(istrue(level._id_13D2E)) {
    return;
  }
  setomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A", int(var_0));
}

trial_ui_set_reward_tier_preview(var_0) {
  if(istrue(level._id_13D2E)) {
    return;
  }
  setomnvar("_encstr_A68F1DEA5AAF8EE42DC28DD79395EEB03946EB8E4B2B277D38C9CACE96CABB", var_0);
}

_id_13D88() {
  if(getDvar("_encstr_A9330B9167D26C016997EB79D7") == "_encstr_A34C02BB")
    game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] = 2;
  else
    game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"]--;

  setomnvar("_encstr_836119BBF7A16DC8093EE09E63FAD82D9BC72D135FEABB5051D589", game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"]);
}

trial_ui_set_tries_remaining(var_0) {
  game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] = var_0;
  setomnvar("_encstr_836119BBF7A16DC8093EE09E63FAD82D9BC72D135FEABB5051D589", var_0);
}

trial_ui_set_stat_and_bonus_score(var_0, var_1, var_2, var_3) {
  if(getomnvar("_encstr_AAD214EAD2D78E39B458D8D7DCE858D1B9D739F6DDCD") < var_0)
    setomnvar("_encstr_AAD214EAD2D78E39B458D8D7DCE858D1B9D739F6DDCD", int(var_0));

  var_4 = tablelookup("_encstr_BA98183377AA3433F1D080BFEFD88B13F102AB9E027F5D860FF8", 1, var_1, 0);
  setomnvar("_encstr_B83B13D748EE7C2BC3A705F196D152243391B33720" + int(var_0) + "_encstr_B2A40CDFC6F3FF6BCF20821A78B9", int(var_4));
  setomnvar("_encstr_B83B13D748EE7C2BC3A705F196D152243391B33720" + int(var_0) + "_encstr_AA6706D73023D1F3", int(var_2));
  setomnvar("_encstr_B83B13D748EE7C2BC3A705F196D152243391B33720" + int(var_0) + "_encstr_BD370DB16A958DFB973FDEDE174B21", int(var_3));
}

trial_ui_set_stat_and_bonus_time(var_0, var_1, var_2, var_3) {
  if(getomnvar("_encstr_AAD214EAD2D78E39B458D8D7DCE858D1B9D739F6DDCD") < var_0)
    setomnvar("_encstr_AAD214EAD2D78E39B458D8D7DCE858D1B9D739F6DDCD", int(var_0));

  var_4 = tablelookup("_encstr_BA98183377AA3433F1D080BFEFD88B13F102AB9E027F5D860FF8", 1, var_1, 0);
  var_3 = var_3 - var_3 % 100;
  setomnvar("_encstr_B83B13D748EE7C2BC3A705F196D152243391B33720" + int(var_0) + "_encstr_B2A40CDFC6F3FF6BCF20821A78B9", int(var_4));
  setomnvar("_encstr_B83B13D748EE7C2BC3A705F196D152243391B33720" + int(var_0) + "_encstr_AA6706D73023D1F3", int(var_2));
  setomnvar("_encstr_B83B13D748EE7C2BC3A705F196D152243391B33720" + int(var_0) + "_encstr_A77D0C7998571D5713D80401E9F9", int(var_3));
}

_id_13D89(var_0) {
  setomnvar("_encstr_9B32181D730749EE82C78876F305B553AB51A94327A6EB219B05", var_0);
}

intro_techos_deposit_fullcar(var_0, var_1) {
  if(var_0 == "_encstr_84300E8EA97BA8771622B0602AAFE9A1")
    level notify("_encstr_84300E8EA97BA8771622B0602AAFE9A1");
}

trial_ui_open_results_screen() {
  level.unset_stay_at_spawn_flag_on_entering_combat = 1;
  level.player playSound("_encstr_85B41495B298A171E6F302930821ADA81840A7CBBBC3");
  scripts\engine\utility::delaythread(lookupsoundlength("_encstr_85B41495B298A171E6F302930821ADA81840A7CBBBC3") / 1000, _encstr_B4F71FAB1EBA80F79317BF33330EB4184D77B36242151897EB0B0B33BBC68CC01B::trial_end_score_dialogue);
  wait 0.5;
  level.player freezecontrols(1);
  wait 0.5;

  if(getDvar("_encstr_A9330B9167D26C016997EB79D7") != "_encstr_A34C02BB") {
    level.player openmenu("_encstr_A6F11007BA9F70606F56F981454E60DB27A2");
    wait 3;
  } else {
    level.player openmenu("_encstr_81CD1325BDAEB991A8CD9115394BB08DA83BCAE6D1");
    wait 3;
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::intro_techos_deposit_fullcar);
    level.player openmenu("_encstr_ADE414D9DB5933BCF8BBFD6DDB9DB347336D6A9FAA80");
    level waittill("_encstr_84300E8EA97BA8771622B0602AAFE9A1");
  }

  level notify("_encstr_93EF1C7B3880D17207869F126D39AB8BEE88AFFB68F906894F9FE74D5DC1");
  level.player openmenu("_encstr_AFE30DA8934B2CD8A459E6ABC6A3CD");
  level.player freezecontrols(0);
  level.unset_stay_at_spawn_flag_on_entering_combat = 0;
}

_id_13D8B(var_0) {
  setomnvar("_encstr_970813AEB4FA6C7BAD98F6BEC4C293D7C6DB5B98B7", int(var_0));
}

_id_13D8C(var_0) {
  setomnvar("_encstr_AB471633C4FFB8107A3B677F43C2E6119C5B5B092B212058", int(var_0));
}

trial_ui_waittill_retry() {
  for(;;) {
    level.player waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0);

    if(var_0 == "_encstr_AAC30CB5E0384E6BD74B5D8BBBF8")
      return;
  }
}

_id_13D8A(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 5000;

  if(var_0) {
    level.player endon("_encstr_8CC50B7B37D7EC590D4BD81B59");
    var_2 = gettime() + var_1;
    level.player setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", int(3));
    level.player setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", int(var_2));

    while(gettime() < var_2)
      waitframe();

    level.player kill();
  } else {
    level.player notify("_encstr_8CC50B7B37D7EC590D4BD81B59");
    level.player setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", int(0));
    level.player setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", int(0));
  }
}

_id_13D4B(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = getDvar("_encstr_91240B81C16559B74B5925B070");

  if(var_3 && var_1)
    level.player playlocalsound("_encstr_8C6C0E55704FEF130843A03F39E9234B");
  else if(isDefined(var_0))
    playsoundatpos(var_0.origin, var_4);
  else
    self playSound(var_4);

  _id_13D8E("_encstr_A5AE098ADB583E0AF7A5AB", var_1, 0, var_2);
}

_id_13D8E(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_5 = _id_13D47(var_0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var_5 <= self.lasthitmarkerpriority && !var_1) {
    return;
  }
  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var_5;

  if(isDefined(var_4) && !istrue(var_1)) {
    self setclientomnvar("_encstr_923E15B9113560D4F7A999E112AB1E28CE63473BBB1DC0", var_4);
    self setclientomnvar("_encstr_84E21C0A61F9D78F70DF0E15B3A0161F16D831428940B3C9409714115D60", gettime());
  }

  self setclientomnvar("_encstr_92E710499EA5C07C82A72D2367BA361843F4", var_0);
  self setclientomnvar("_encstr_8CD4175A10C34E8FA1A8669D5D69539607E85172F89904D31A", gettime());

  if(var_1)
    self setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 1);
  else
    self setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 0);

  if(var_2)
    self setclientomnvar("_encstr_A70B19D1794D18BC9FF13159BA73E6C066DB1F41E53678FE93EA8B", 1);
  else
    self setclientomnvar("_encstr_A70B19D1794D18BC9FF13159BA73E6C066DB1F41E53678FE93EA8B", 0);

  if(var_3)
    self setclientomnvar("_encstr_927C1ACB9BE1423760AEA76F81237A1A4E279F6B1F989BE478721FB2", 1);
  else
    self setclientomnvar("_encstr_927C1ACB9BE1423760AEA76F81237A1A4E279F6B1F989BE478721FB2", 0);
}

_id_13D47(var_0) {
  if(!isDefined(level.hitmarkerpriorities[var_0]))
    return 0;

  return level.hitmarkerpriorities[var_0];
}

waittill_player_isDefined() {
  while(!isDefined(level.player))
    waitframe();
}

_id_13D5E() {
  if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_AC1F058B9EABE0") {
    level._id_13D6A = 1;
    level.player kill();
  }

  level.player freezecontrols(1);
  level.player setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", 1);
  wait 0.5;
  map_restart(1);
}

recentc4vehiclekillcount() {
  if(level.totaltime <= level.trial["_encstr_966C066BF011B2F7"])
    var_0 = 3;
  else if(level.totaltime <= level.trial["_encstr_876C06B1FF0A66F2"])
    var_0 = 2;
  else if(level.totaltime <= level.trial["_encstr_816C069599555DA7"])
    var_0 = 1;
  else
    var_0 = 0;

  return var_0;
}