/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58308.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_AC1F058B9EABE0"] = ::_id_129A2;
}

_id_129A2() {
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  build_vehicle_drop_off_list();

  if(isDefined(level._id_13D5B))
    level._id_13D5A = level._id_13D5B;
  else
    level._id_13D5A = 3;

  level._id_13D90 = scripts\engine\utility::getStruct("_encstr_9A0F0ED1D5F23B8BEA0B7FAFF0F794EF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level._id_13D90))
    level._id_13D90 = scripts\engine\utility::getStruct("_encstr_85601483DA74FF6C39FDC5F0B03709D15F0F710FE3D5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level._id_13D90.script_noteworthy)) {
    switch (level._id_13D90.script_noteworthy) {
      case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
        level._id_13D5C = 1;
        level.check_for_early_impact = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", level._id_13D90);
        level.watchforbrsquadleadershift = 0.25;
        level.watchforcarrierdisconnect = 0.25;
        thread playerzombieprestream();
        break;
      case "_encstr_9A120A1D8536F5E4ED3BB293":
      default:
        level.check_for_early_impact = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8C190467402B", level._id_13D90);
        break;
    }
  } else
    level.check_for_early_impact = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8C190467402B", level._id_13D90);

  level._id_13E8E = getEntArray("_encstr_A32D07CFD14BAA94D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.get_weapon_in_power_slot = getEntArray("_encstr_A5C407E1658D3339B3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12DCE = getEntArray("_encstr_A11904E483B3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(level._id_12DCE.size > 0) {
    if(!isDefined(level._id_13D63))
      _id_13D62();

    foreach(var_1 in level._id_12DCE) {
      var_1 thread _id_119D9();
      var_1 thread _id_132B1();

      if(istrue(level._id_13D5C))
        var_1 thread _id_13D44();
    }
  }

  level._id_12ABF = getEntArray("_encstr_A66A0A507A73BB9EDBE9B53D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.module_wait_for_level_flag = getEntArray("_encstr_AB0D0919BCDCFA76858EB2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in level.module_wait_for_level_flag)
  var_4 thread module_wait_for_level_flag_set_and_clear();

  level.course_triggers = getEntArray("_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.in_world_scriptables_visible = getEntArray("_encstr_B48F108ADBE8F7AB3567B7D7B7683221A881", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] < level.trial["_encstr_A67009D77B23ABF02883D0"])
    level._id_13D69 = level.check_for_early_impact;

  scripts\engine\utility::getstructarray_delete("_encstr_BE7E0A0F2843CFA3792F7B35", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level scripts\engine\utility::flag_init("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level scripts\engine\utility::flag_init("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");
  level scripts\engine\utility::flag_init("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072");
  level scripts\engine\utility::flag_init("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");
  level scripts\engine\utility::flag_init("_encstr_87A016D240C0B19286070B1749387AEE89AB0F5C18387CAA");
  level scripts\engine\utility::flag_init("_encstr_AD7C0EC1764418985AF38BB5CF53C0FA");
  thread _id_13EEF();
  thread _id_13D48();

  if(issubstr(level.trial["_encstr_836105A5EFB2E5"], "_encstr_A11A04BE3BBB") && game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] == 3)
    wait 11;

  thread dialog_init();
  thread _id_1299F();
  thread player_is_faux_dead();
  thread player_monitor_death();
  thread _id_137EE();
  thread _id_12479();
  _id_142A9();
  var_6 = getEntArray("_encstr_B1A60BA3932C66B48DD8DBDC2B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_8 in var_6)
  var_8 notsolid();

  level._id_13D3B = [];
  _tablethide::waittill_player_isDefined();
  waitframe();
  level._id_13D91 = scripts\mp\utility\outline::outlineenableforplayer(level.check_for_early_impact, level.player, "_encstr_8294137D0BA3CC0AA05BF7539DDB7234B1103347A0", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  if(istrue(level._id_13D2F)) {
    var_10 = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_12 in var_10)
    var_12 scripts\engine\utility::trigger_off();
  }

  thread _id_1299D();

  foreach(var_15 in level._id_13D3B)
  var_15 thread make_use_prompt();

  setomnvar("_encstr_B49C19759439218BA93FD0511FFAC04B427BE37C6FD1F9109C57D8", level._id_13D3B.size);
  level.nosuspensemusic = 1;

  if(issubstr(level.trial["_encstr_836105A5EFB2E5"], "_encstr_A11A04BE3BBB") && game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] == 3) {
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_9B150C2306935224A618E3B3F898");
    wait 8;
  }
}

_id_13D48() {
  if(issubstr(level.trial["_encstr_836105A5EFB2E5"], "_encstr_A11A04BE3BBB") && game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] == 3) {
    while(!isalive(level.player))
      waitframe();

    wait 1;
    level.player freezecontrols(1);
    level.player freezelookcontrols(1);
    var_0 = newhudelem();
    var_0.x = 0;
    var_0.y = 0;
    var_0 setshader("_encstr_83AB065EE1391A7B", 640, 480);
    var_0.alignx = "_encstr_A5AD056A019C63";
    var_0.aligny = "_encstr_AC190479FF92";
    var_0.sort = 1;
    var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
    var_0.foreground = 1;
    var_0.alpha = 1;
    wait 22;
    var_0.alpha = 1;
    var_0 fadeovertime(4);
    var_0.alpha = 0;
    level.player freezecontrols(0);
    level.player freezelookcontrols(0);
  }
}

_id_137EE() {
  var_0 = getEnt("_encstr_8DD40E9329C85A1B64F94BE3ED43BB13", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _tablethide::waittill_player_isDefined();

  while(!isDefined(level.player.vehicle))
    waitframe();

  level scripts\engine\utility::flag_set("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");
  scripts\mp\utility\outline::outlinedisable(level._id_13D91, level.check_for_early_impact);
  _tablethide::_id_13D88();

  if(!istrue(level._id_13D5C)) {
    level.player allowmovement(0);
    level.player freezecontrols(1);
    wait 1.5;
  }

  level._id_13D4A = var_0.origin;
  level._id_13D49 = thread _id_13563();
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 3);
  level.player setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", -1);
  level scripts\engine\utility::flag_set("_encstr_AD7C0EC1764418985AF38BB5CF53C0FA");
  level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
  setmusicstate("_encstr_B40101");

  if(!istrue(level._id_13D5C)) {
    level.player allowmovement(1);
    level.player freezecontrols(0);
  }

  level scripts\engine\utility::flag_set("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");
  thread light_tank_addgunnerdamagemod();
  thread _id_14189();
  _tablethide::_id_13D89(0);
  hud_timer();
}

_id_1299F() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level.waitingtoplayreviveanimation = [];
  level._id_13D4A = (0, 0, 0);
  level._id_11F81 = (0, 0, 0);
  level scripts\engine\utility::flag_wait("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");
  var_0 = getEnt("_encstr_82CD1069B3AE1D730F60BDA64BEBD893D51B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.initlocs_test = var_0;
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");

  if(isDefined(level.initlocs_test.playerzombiegasthink)) {
    level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");
    stopFXOnTag(scripts\engine\utility::getfx("_encstr_A78F076CA54E1B1B56"), level.initlocs_test.playerzombiegasthink, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    level.initlocs_test.playerzombiegasthink delete();
  }

  if(isDefined(level._id_13D22))
    level._id_13D22--;

  var_1 = getEnt(level.initlocs_test.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13D4A = var_1.origin;
  level._id_11F81 = var_1.origin;

  if(isDefined(level._id_13D49))
    level._id_13D49 moveTo(level._id_13D4A, 0.5, 0.1, 0.3);

  var_2 = thread _id_135A8();
  level.player setclientomnvar("_encstr_BE1214AB4BEBCA323B56BED9B1DEDDEB8E93A5B0B1B9", 255);
  level.player scripts\engine\utility::delaycall(0.5, ::setclientomnvar, "_encstr_BE1214AB4BEBCA323B56BED9B1DEDDEB8E93A5B0B1B9", 0);

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A");

    if(isDefined(level._id_13D22))
      level._id_13D22--;

    level.getquestrewardbuildgroupref++;
    level._id_13B9A = 0;
    level._id_13B9C = 6;
    level.initlocs_test = var_1;

    if(isDefined(level.initlocs_test.playerzombiegasthink)) {
      stopFXOnTag(scripts\engine\utility::getfx("_encstr_A78F076CA54E1B1B56"), level.initlocs_test.playerzombiegasthink, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      level.initlocs_test.playerzombiegasthink delete();
    }

    if(isDefined(level.initlocs_test.script_noteworthy) && level.waiting_for_tactical_restock == level._id_13D5A) {
      if(level.initlocs_test.script_noteworthy == "_encstr_961804BD954A")
        var_1 = getEnt(level.initlocs_test.script_noteworthy, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    } else
      var_1 = getEnt(level.initlocs_test.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    level.player notify("_encstr_95C10E5685DBBF34E338AA1370D36D3B");
    level.player setclientomnvar("_encstr_BE1214AB4BEBCA323B56BED9B1DEDDEB8E93A5B0B1B9", 255);
    level.player scripts\engine\utility::delaycall(0.5, ::setclientomnvar, "_encstr_BE1214AB4BEBCA323B56BED9B1DEDDEB8E93A5B0B1B9", 0);

    if(level.initlocs_test.targetname == "_encstr_82CD1069B3AE1D730F60BDA64BEBD893D51B" || level.initlocs_test.targetname == "_encstr_961804BD954A" || level.initlocs_test.targetname == "_encstr_9A1904632C38" && level.waiting_for_tactical_restock < level._id_13D5A) {
      level._id_13D4E = gettime() - gettime() % 100 - level._id_137C9;
      level.waitingtoplayreviveanimation = scripts\engine\utility::array_add(level.waitingtoplayreviveanimation, level._id_13D4E);

      if(level.waiting_for_tactical_restock >= level._id_13D5A) {
        if(level._id_13D5A == 1)
          _tablethide::trial_ui_set_stat_and_bonus_time(level.waiting_for_tactical_restock, "_encstr_BEAD0578F06397" + level.waiting_for_tactical_restock + "_encstr_834F066823CA653D", level.waitingtoplayreviveanimation[level.waiting_for_tactical_restock - 1], 0);

        level.player.vehicle vehicle_turnengineoff();
        level scripts\engine\utility::flag_set("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
      } else {
        level._id_137C9 = gettime() - gettime() % 100;
        _tablethide::trial_ui_set_stat_and_bonus_time(level.waiting_for_tactical_restock, "_encstr_BEAD0578F06397" + level.waiting_for_tactical_restock + "_encstr_834F066823CA653D", level.waitingtoplayreviveanimation[level.waiting_for_tactical_restock - 1], 0);
        level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
        setmusicstate("_encstr_B40101");
        level.waiting_for_tactical_restock++;
        var_3 = "_encstr_87A80B7CED4056A3B890322BDE" + level.waiting_for_tactical_restock;
        _tablethide::_id_13D8D(level.waiting_for_tactical_restock, level._id_13D5A);
        _id_142A9();

        if(level.waiting_for_tactical_restock == level._id_13D5A) {
          var_3 = "_encstr_B16C1063333019B2C0B1E79BEF74AA5E2898";
          var_4 = ["_encstr_B8F60FFD9F2AADD94E74F8115D0F38D773", "_encstr_BE3A0D4E0B36B2FAED9BB2F563160E"];
          level.player scripts\mp\utility\dialog::leaderdialogonplayer(scripts\engine\utility::random(var_4));
        }

        if(level._id_13D4E <= (level.trial["_encstr_966C066BF011B2F7"] + level.dogtags.size / 2 * 1000) / level._id_13D5A)
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_93D40ED053B74F7E3860E0E1AF584F7B");
        else if(level._id_13D4E >= (level.trial["_encstr_816C069599555DA7"] + level.dogtags.size * 1000) / level._id_13D5A)
          level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_877F0DAECEA25B66EA075889DB015B");

        level.player thread scripts\mp\hud_message::showsplash(var_3);
        level.make_fly_struct = 0;
      }
    } else
      level.player playSound("_encstr_8E4F12B486903FAD0F30C21B696F23FF09E53B4B");

    level._id_13D4A = var_1.origin;
    level._id_11F81 = var_1.origin;
    level._id_13D49 moveTo(level._id_13D4A, 0.5, 0.1, 0.3);
    thread _id_135A8();
  }
}

player_is_faux_dead() {
  var_0 = getEntArray("_encstr_AA530B82BAD8AD50B013BBFBA7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0[0]) && var_0[0].model == "_encstr_86AD13B596B91BEBBBDA7DCC632C39ACB9D15A6CB5")
    var_1 = "_encstr_8107069A17B7B8F9";
  else
    var_1 = "_encstr_AD830C4514E87D324A4A54D78C2C";

  foreach(var_3 in var_0) {
    var_4 = var_3 gettagangles(var_1);
    var_5 = var_3 gettagorigin(var_1);
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
    var_6.angles = var_4;
    var_6 linkTo(var_3, var_1, (1, 0, 0), (90, 0, 0));
    var_6 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
    var_7.angles = var_4;
    var_7 linkTo(var_3, var_1, (0, 0, -1.75), (0, 180, 0));
    var_7 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    scripts\engine\utility::flag_init("_encstr_A2B50DEC2CA395D766638593B2E6FA" + var_3.script_noteworthy);
    thread pointinsquarewidth(var_3.script_noteworthy, var_6, var_7);
  }
}

pointinsquarewidth(var_0, var_1, var_2) {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  for(;;) {
    scripts\engine\utility::flag_wait("_encstr_A2B50DEC2CA395D766638593B2E6FA" + var_0);
    playFXOnTag(level._id_142A5, var_1, "_encstr_A2B40B8A283A7DD3254A1D4A27");
    playFXOnTag(level._id_14297, var_2, "_encstr_A2B40B8A283A7DD3254A1D4A27");

    while(scripts\engine\utility::flag("_encstr_A2B50DEC2CA395D766638593B2E6FA" + var_0))
      waitframe();

    stopFXOnTag(level._id_142A5, var_1, "_encstr_A2B40B8A283A7DD3254A1D4A27");
    stopFXOnTag(level._id_14297, var_2, "_encstr_A2B40B8A283A7DD3254A1D4A27");
  }
}

_id_12479() {
  level scripts\engine\utility::flag_wait("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  thread _tablethide::_id_13D8A(0);
  level.player allowmovement(0);
  level.player freezecontrols(1);
  level notify("_encstr_8F730B82D32028A1759BF7AFD5");

  if(!scripts\engine\utility::flag("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072")) {
    if(level._id_13D5A == 0) {}

    for(var_0 = 2; var_0 <= level._id_13D5A; var_0++)
      _tablethide::trial_ui_set_stat_and_bonus_time(var_0, "_encstr_BEAD0578F06397" + var_0 + "_encstr_834F066823CA653D", level.waitingtoplayreviveanimation[var_0 - 1], 0);

    if(level._id_13D3B.size > 0) {
      _tablethide::trial_ui_set_stat_and_bonus_time(level._id_13D5A + 1, "_encstr_B41F110BE071D4B267AF6E65F1098A8B7B2883", level.make_exhaust_affect_players, level._id_13B6A * -1);

      if(level.make_exhaust_affect_players == level._id_13D3B.size) {
        _tablethide::trial_ui_set_stat_and_bonus_time(level._id_13D5A + 2, "_encstr_A6BC1547897181B29F92435E417EE9687344B91EC9D0E1", 0, -5000);
        level.intel_use_logic = level.intel_use_logic - 5000;
      }
    }

    scripts\engine\utility::delaythread(3, _tablethide::trial_ui_set_subtime, level.intel_spawn_listener);
    _tablethide::trial_ui_set_main_time(level.intel_use_logic);

    if(level.intel_use_logic <= level.trial["_encstr_966C066BF011B2F7"])
      level.reward_tier = 3;
    else if(level.intel_use_logic <= level.trial["_encstr_876C06B1FF0A66F2"])
      level.reward_tier = 2;
    else if(level.intel_use_logic <= level.trial["_encstr_816C069599555DA7"])
      level.reward_tier = 1;
    else
      level.reward_tier = 0;

    var_1 = game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"];

    if(level.reward_tier > var_1) {
      game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"] = level.reward_tier;
      _tablethide::trial_ui_set_reward_tier(level.reward_tier);
    }

    var_2 = game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"];

    if(game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] <= 0 || level.intel_use_logic < game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"]) {
      game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] = level.intel_use_logic;
      hud_besttime_update();
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A95D0A98B26E8EBEC60B1C4C"] = level.waitingtoplayreviveanimation[0];

      if(isDefined(level.waitingtoplayreviveanimation[1]))
        game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A25D0A2062EAD1D6F329774E"] = level.waitingtoplayreviveanimation[1];

      if(isDefined(level.waitingtoplayreviveanimation[2]))
        game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B15D0AC26B38BBD79999BBF7"] = level.waitingtoplayreviveanimation[2];
    }

    if(level.reward_tier == 3) {
      var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"].size;
      var_4 = randomint(var_3);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"][var_4]);
    } else if(level.reward_tier == 2) {
      var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"].size;
      var_4 = randomint(var_3);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"][var_4]);
    } else if(level.reward_tier == 1) {
      var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"].size;
      var_4 = randomint(var_3);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"][var_4]);
    } else {
      var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
      var_4 = randomint(var_3);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_4]);
    }
  } else if(scripts\engine\utility::flag("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072")) {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    _tablethide::trial_ui_set_main_time(0);
    _tablethide::trial_ui_set_subtime(0);
    setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 1);

    if(level._id_13D3B.size > 0)
      _tablethide::trial_ui_set_stat_and_bonus_time(level._id_13D5A + 1, "_encstr_B41F110BE071D4B267AF6E65F1098A8B7B2883", 0, 0);

    level.player playSound("_encstr_937A12E84E2D85B1F5E699C3BE330B96B1AE9395");
    var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
    var_4 = randomint(var_3);
    level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_4]);
    level._id_13D6A = 1;
    var_5 = 1.25;
    hud_fade_to_black(var_5);
    wait(var_5);

    if(isDefined(level.check_for_early_impact))
      level.check_for_early_impact delete();
  }

  waitframe();
  _tablethide::trial_ui_open_results_screen();
  level._id_13D60 = 1;
  _tablethide::trial_ui_waittill_retry();
  var_6 = game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"];

  if(var_6 > 0)
    _tablethide::_id_13D5E();
}

player_monitor_death() {
  _tablethide::waittill_player_isDefined();
  level.player waittill("_encstr_AD75063D571AE108");
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  scripts\engine\utility::flag_set("_encstr_878413F87B04A3E8177041CFF107D317AF92D84072");
  scripts\engine\utility::flag_set("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
}

_id_13EEF() {
  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"]))
    game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"] = 0;

  if(isDefined(level._id_13D3A))
    var_0 = level._id_13D3A;
  else
    var_0 = "_encstr_8DF80D5268DF138FE9508B8057336B";

  level.waiting_for_tactical_restock = 1;
  level.make_exhaust_affect_players = 0;
  level.make_fly_struct = 0;
  level.dogtags = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level._id_13B6A = 0;
  level.getquestrewardbuildgroupref = 1;
  _tablethide::_id_13D8D(level.waiting_for_tactical_restock, level._id_13D5A);
  _tablethide::trial_ui_set_subtime(0);
  _tablethide::trial_ui_set_reward_tier_preview(3);
  thread check_for_at_set_final_wave();
  thread hud_besttime_update();
  thread hud_reward_tiers_tracking();
  thread spawn_speed();
  thread spawn_size();
}

hud_timer() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level.intel_spawn_listener = 0;
  level.intel_use_logic = 0;
  level._id_137C9 = gettime() - gettime() % 100;

  for(;;) {
    var_0 = gettime() - gettime() % 100;
    waitframe();

    while(!scripts\engine\utility::flag("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19")) {
      level.intel_spawn_listener = gettime() - gettime() % 100 - var_0;
      level.intel_use_logic = level.intel_spawn_listener - level._id_13B6A;

      if(level.intel_use_logic < 0)
        _tablethide::trial_ui_set_subtime(0);
      else
        _tablethide::trial_ui_set_subtime(level.intel_use_logic);

      waitframe();
    }
  }

  waitframe();
}

spawn_size() {
  for(var_0 = 1; var_0 <= level._id_13D5A; var_0++)
    _tablethide::trial_ui_set_stat_and_bonus_time(var_0, "_encstr_BEAD0578F06397" + var_0 + "_encstr_834F066823CA653D", 0, 0);

  if(level.dogtags.size > 0)
    _tablethide::trial_ui_set_stat_and_bonus_time(level._id_13D5A + 1, "_encstr_B41F110BE071D4B267AF6E65F1098A8B7B2883", level.make_exhaust_affect_players, level._id_13B6A * -1);
}

spawn_speed() {
  self endon("_encstr_8F730B82D32028A1759BF7AFD5");

  while(!isDefined(level.intel_use_logic))
    waitframe();

  for(;;) {
    if(level.intel_use_logic > level.trial["_encstr_966C066BF011B2F7"] - 5000 && level.intel_use_logic < level.trial["_encstr_966C066BF011B2F7"]) {
      level.player playSound("_encstr_BAF61CE8939616C67DB9331EF5CC85A563D539ACD7C6F6ABB94723BD7773");
      wait 1;
      continue;
    }

    if(level.intel_use_logic > level.trial["_encstr_876C06B1FF0A66F2"] - 5000 && level.intel_use_logic < level.trial["_encstr_876C06B1FF0A66F2"]) {
      level.player playSound("_encstr_BAF61CE8939616C67DB9331EF5CC85A563D539ACD7C6F6ABB94723BD7773");
      wait 1;
      continue;
    }

    if(level.intel_use_logic > level.trial["_encstr_816C069599555DA7"] - 5000 && level.intel_use_logic < level.trial["_encstr_816C069599555DA7"]) {
      level.player playSound("_encstr_BAF61CE8939616C67DB9331EF5CC85A563D539ACD7C6F6ABB94723BD7773");
      wait 1;
      continue;
    }

    waitframe();
  }
}

hud_reward_tiers_tracking() {
  self endon("_encstr_8F730B82D32028A1759BF7AFD5");
  self waittill("_encstr_ADA512A3E4B40BC6F52DDCAF1C39DB9D9C95E6E6");
  var_0 = 5;
  var_1 = [];
  var_1[0] = undefined;
  var_1[1] = level.trial["_encstr_816C069599555DA7"];
  var_1[2] = level.trial["_encstr_876C06B1FF0A66F2"];
  var_1[3] = level.trial["_encstr_966C066BF011B2F7"];
  level.reward_tier = 3;

  for(;;) {
    var_2 = level.reward_tier;

    if(level.intel_use_logic <= level.trial["_encstr_966C066BF011B2F7"]) {
      _tablethide::trial_ui_set_reward_tier_preview(3);
      level.reward_tier = 3;
    } else if(level.intel_use_logic <= level.trial["_encstr_876C06B1FF0A66F2"]) {
      _tablethide::trial_ui_set_reward_tier_preview(2);
      level.reward_tier = 2;
    } else if(level.intel_use_logic <= level.trial["_encstr_816C069599555DA7"]) {
      _tablethide::trial_ui_set_reward_tier_preview(1);
      level.reward_tier = 1;
    } else {
      _tablethide::trial_ui_set_reward_tier_preview(0);
      level.reward_tier = 0;
    }

    if(level.reward_tier < var_2)
      level.player playSound("_encstr_937A12E84E2D85B1F5E699C3BE330B96B1AE9395");

    waitframe();
  }
}

hud_besttime_update() {
  var_0 = game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"];
  var_1 = game["_encstr_8CA606F38878410D"]["_encstr_84AB0C93307354D1CD9DEB667E99"];
  _tablethide::trial_ui_set_best_time(var_0);
  _tablethide::trial_ui_set_reward_tier(var_1);
}

hud_fade_to_black(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 0;
  var_2.y = 0;
  var_2 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_2.alignx = "_encstr_A5AD056A019C63";
  var_2.aligny = "_encstr_AC190479FF92";
  var_2.sort = 1;
  var_2.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_2.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_2.foreground = 1;

  if(istrue(var_1)) {
    var_2.alpha = 1;
    var_2 fadeovertime(var_0);
    var_2.alpha = 0;
  } else {
    var_2.alpha = 0;
    var_2 fadeovertime(var_0);
    var_2.alpha = 1;
  }
}

_id_13563() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level._id_13D4A);
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level._id_14537 = deleteheadicon(var_0);
  setheadiconfriendlyimage(level._id_14537, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
  setheadiconzoffset(level._id_14537, 1);
  setheadiconsnaptoedges(level._id_14537, 0);
  setheadicondrawthroughgeo(level._id_14537, 1);
  setheadiconmaxdistance(level._id_14537, 0);
  addclienttoheadiconmask(level._id_14537, -50);
  return var_0;
}

_id_135A8() {
  if(!isDefined(level._id_1453A))
    level._id_1453A = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  objective_state(level._id_1453A, "_encstr_930B07BB1B6B3854FF");
  objective_position(level._id_1453A, level._id_11F81);
  objective_setplayintro(level._id_1453A, 0);
  objective_icon(level._id_1453A, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
  objective_setbackground(level._id_1453A, 1);
  objective_setfadedisabled(level._id_1453A, 0);
  objective_setshowoncompass(level._id_1453A, 1);
  objective_setminimapiconsize(level._id_1453A, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  objective_setshowdistance(level._id_1453A, 0);
  objective_ping(level._id_1453A);
  objective_setownerteam(level._id_1453A, level.player.team);
  level scripts\engine\utility::flag_wait("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  objective_delete(level._id_1453A);
}

dialog_init() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_A36D18DA0EBEE0B23A4EB7B3270B32F5270BD82BD75A37E89C7B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_95B61A3FCB1F503FD56A774FC69178C993E0F7722F1B48C808872F9A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_B2631808775E3BF18B434D7FBB3A9F9FC52936FD5E8A9B20D6A3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_962A15A3272DC2C6BECA9B46EB1D4B59397DC0F5C2B1E8"] = "_encstr_821C169932D9C98954D36830CB99615F225E82080F92A3D0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_B6931863C861301D7B837079AB074591C23187FB7F4260DD579B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_A3A3185B0E7D83B2A3C9ED9D9C0B46F5E4588DB2EB199BE8C2E4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_8314187DD8A0BBA51B4A183A9DD73CAFD0BE32223ED7CB034793";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_95B61A3FCB1F503FD56A774FC69178C993E0F7722F1B48C808872F9A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BEA50D33975CC6F973822EB3D1AB11"] = "_encstr_91F81BB6C17D83B24793BD3B4E0B19AFF64C35F5CDB03BBE0DEAE49CF2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E2C1D2B0BCF5F7F5040868D705B77696D8813C389A754AF49BA888F736043"] = "_encstr_AAD31DDAE0D70EB23A9CDED99CC2197D3958B1567D8DA1CAD8DA0EF6A5E61D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8F60FFD9F2AADD94E74F8115D0F38D773"] = "_encstr_9BE01B7979E1F38D34A52DD9EAC784F783F1B73109642CE00F51617F7B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE3A0D4E0B36B2FAED9BB2F563160E"] = "_encstr_96231A25473F83ED0393273F3899A4393D572E5FB8F7DA35EBD05B13";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAEC0DCE997751BF5B3B38E13233D5"] = "_encstr_9A61190517410BCB09E3A0E7F2BBE1B9A86E486D67B0EFB5CEDB38";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93D40ED053B74F7E3860E0E1AF584F7B"] = "_encstr_B87A18432B9F5F8ACBA667FF5BE72A7F9B6FBE5A066E377FEB64";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_877F0DAECEA25B66EA075889DB015B"] = "_encstr_851518429FA118595B9BE78F72EB49E97673FA3D391BE3189319";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8ABF11FB29A74BD858B890A5CCB97293B7FFB9"] = "_encstr_84B516DA83BEE0B2D19CBDCEE4B08CFA39858D56BE37853B";
  scripts\engine\utility::flag_wait("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_88940A6696D8FADCD185C93A");
}

light_tank_addgunnerdamagemod() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level._id_13B9A = 0;
  level._id_13B9C = 6;

  for(;;) {
    while(level._id_13B9A < level._id_13B9C) {
      wait 1;
      level._id_13B9A++;
    }

    if(isDefined(level.player.vehicle)) {
      if(randomint(100) < 30)
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8E2C1D2B0BCF5F7F5040868D705B77696D8813C389A754AF49BA888F736043");
      else
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8ABF11FB29A74BD858B890A5CCB97293B7FFB9");

      level._id_13B9C = level._id_13B9C + 3;
    }

    level._id_13B9A = 0;
    waitframe();
  }
}

_id_14189() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  for(;;) {
    thread _tablethide::_id_13D8A(0);

    while(isDefined(level.player.vehicle))
      waitframe();

    thread _tablethide::_id_13D8A(1);
    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_BAEC0DCE997751BF5B3B38E13233D5");

    while(!isDefined(level.player.vehicle))
      waitframe();
  }
}

molotov_can_cast_this_frame() {
  if(self.target == "_encstr_BD1805CB69C063")
    self hide();

  while(!isDefined(level.getquestrewardbuildgroupref))
    waitframe();

  for(;;) {
    if(level.getquestrewardbuildgroupref == float(self.script_noteworthy)) {
      switch (self.target) {
        case "_encstr_BD1805CB69C063":
          self show();
          break;
        case "_encstr_BECC055CF3811A":
          self hide();
          break;
        default:
          break;
      }

      return;
    }

    waitframe();
  }
}

check_for_at_set_final_wave() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  _tablethide::waittill_player_isDefined();

  for(;;) {
    var_0 = scripts\mp\utility\outline::outlineenableforplayer(level.check_for_early_impact, level.player, "_encstr_82A716507B33E9188325E8752AC741A151F388F0520E3151", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

    while(!isDefined(level.player.vehicle))
      waitframe();

    scripts\mp\utility\outline::outlinedisable(var_0, level.check_for_early_impact);

    while(isDefined(level.player.vehicle))
      waitframe();

    waitframe();
  }
}

_id_1299D() {
  foreach(var_1 in level.dogtags)
  var_1 thread _id_135BB(var_1, level.player);
}

_id_135BB(var_0, var_1) {
  var_2 = 14;
  var_3 = (0, 0, 0);
  var_4 = var_0.angles;

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_4 = var_0 getworldupreferenceangles();
    var_3 = anglestoup(var_4);

    if(var_3[2] < 0)
      var_2 = -14;
  }

  var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_5[0] setModel("_encstr_84CD1C70848CA8DDFA3B0BBF9BE2AC88599F3B8E2CFF5AAF321333D5BF6A");
  var_6 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(var_3[2] < 0)
      var_5[0].angles = var_4;
  }

  var_7 = "_encstr_9A19040BCDBC";
  var_8 = scripts\mp\gameobjects::createuseobject(level.player.team, var_6, var_5, (0, 0, 16));
  var_8.victim = var_0;
  var_8.victimteam = level.player.team;
  var_9 = var_0.script_parameters;
  var_10 = var_0.origin + (0, 0, var_2);
  var_8.trigger.origin = var_10;
  var_8.visuals[0].origin = var_10;
  var_8.visuals[0].waiting_to_connect = var_9;
  var_8.attacker = var_1;
  var_8.attackerteam = var_1.team;
  var_8.ownerteam = scripts\engine\utility::get_enemy_team(level.player.team);

  if(isDefined(var_8.objidnum)) {
    if(var_8.objidnum != -1) {
      var_11 = var_8.objidnum;
      scripts\mp\objidpoolmanager::update_objective_position(var_11, var_0.origin + (0, 0, 36));
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_11, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_8.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_8.objidnum, 0);
      var_8 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8D701AD8D9A3D7CD4C1A2C4F6BC02F0B49DF82890FABA35586805851", "_encstr_8ECD1123407BEFC751BD31889F2789592B50D7");
    }
  }

  var_8.visuals[0] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
  level._id_13D3B = scripts\engine\utility::array_add(level._id_13D3B, var_8);
  var_6 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_8 notify("_encstr_85DE0B77B48D8D23591B95E895");
  level.make_exhaust_affect_players++;
  level.make_fly_struct++;
  level.player thread scripts\mp\rank::scoreeventpopup("_encstr_8E810ED9B74298A8255B0378071E584D");
  level._id_13B6A = 1000 * level.make_exhaust_affect_players;
  _tablethide::trial_ui_set_stat_and_bonus_time(level._id_13D5A + 1, "_encstr_B41F110BE071D4B267AF6E65F1098A8B7B2883", level.make_exhaust_affect_players, level._id_13B6A * -1);
  level.player playSound("_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");
  var_8 thread scripts\mp\gameobjects::deleteuseobject();

  for(var_12 = 0; var_12 < var_8.visuals.size; var_12++)
    var_8.visuals[var_12] delete();
}

make_use_prompt() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  self endon("_encstr_85DE0B77B48D8D23591B95E895");
  var_0 = getEnt(self.victim.targetname, "_encstr_A16007A921A23B85E3");

  while(isDefined(self)) {
    scripts\mp\gameobjects::disableobject();
    self.visuals[0] hide();
    level scripts\engine\utility::flag_wait("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");

    if(int(self.visuals[0].waiting_to_connect) == 1 && var_0.targetname == "_encstr_82CD1069B3AE1D730F60BDA64BEBD893D51B" && level.getquestrewardbuildgroupref == 1) {
      scripts\mp\gameobjects::enableobject();
      self.visuals[0] show();
    }

    var_0 waittill("_encstr_8F5C086405E70FBA4B4A");

    if(int(self.visuals[0].waiting_to_connect) == level.waiting_for_tactical_restock && var_0.targetname == level.initlocs_test.targetname) {
      var_1 = distance(self.visuals[0].origin, level.player.origin);
      var_2 = var_1 / 10000;
      self.visuals[0] scripts\engine\utility::delaycall(var_2, ::show);
      scripts\engine\utility::delaythread(var_2, scripts\mp\gameobjects::enableobject);
      playsoundatpos(self.visuals[0].origin, "_encstr_A28719B5E0F55B5A36D86CDBDC995A39DAEB3A0BEC37BE91C9DB0E");
      waitframe();
      level.player waittill("_encstr_95C10E5685DBBF34E338AA1370D36D3B");
      waitframe();
    }
  }
}

module_wait_for_level_flag_set_and_clear() {
  var_0 = scripts\engine\utility::getclosest(self.origin, getEntArray("_encstr_A59105C2400CBF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), 250);
  var_1 = scripts\engine\utility::getclosest(self.origin, getEntArray("_encstr_9A9105DEE86032", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), 250);
  var_2 = scripts\engine\utility::getclosest(self.origin, level._id_12ABF, 100);

  if(isDefined(var_1))
    var_1 notsolid();

  var_3 = var_2.angles;
  var_2 hide();

  while(!isDefined(level.getquestrewardbuildgroupref))
    waitframe();

  var_4 = float(self.script_noteworthy);

  while(level.getquestrewardbuildgroupref < var_4)
    waitframe();

  self rotateTo(var_3, 2);
  wait 2;
  var_2 show();
  self hide();

  if(isDefined(var_0)) {
    var_0 notsolid();

    if(isDefined(var_1))
      var_1 solid();
  }
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D38;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A95D0A98B26E8EBEC60B1C4C"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A25D0A2062EAD1D6F329774E"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B15D0AC26B38BBD79999BBF7"] = 0;
  }
}

_id_13D38() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_AF8F13DB2C27D846120F49272BFA0E608FC3C05057");
  var_3 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A95D0A98B26E8EBEC60B1C4C"]);
  var_4 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A25D0A2062EAD1D6F329774E"]);
  var_5 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B15D0AC26B38BBD79999BBF7"]);
  level.player dlog_recordplayerevent("_encstr_AD2E1F91D8ED9DEBB2672BE61DEB8E27D2581BFA36F66BE01B953A95D74EC2C6CA", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_84EF055338A18F", var_2, "_encstr_96AD05C6B03889", var_3, "_encstr_AAAD058899A353", var_4, "_encstr_81AD0564B70BCE", var_5]);
}

_id_142A9() {
  foreach(var_1 in level.course_triggers)
  var_1 thread _id_13422();

  foreach(var_1 in level.in_world_scriptables_visible)
  var_1 thread onteamproximitysteppedfar();
}

_id_13422() {
  if(isDefined(level.course_triggers)) {
    foreach(var_1 in level.course_triggers)
    var_1 thread _id_13DAF();
  }
}

_id_13DAF() {
  level waittill("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");
  self waittill("_encstr_8F5C086405E70FBA4B4A");
  var_0 = scripts\engine\utility::getStructArray("_encstr_92FC151B0801E96F60921E830F08AAA1876F4B575F284A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::array_intersection(var_0, var_1);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_parameters))
      wait(float(var_4.script_parameters));

    magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_4.origin, (0, 0, -0.25), 0.05);
  }
}

onteamproximitysteppedfar() {
  if(isDefined(level.in_world_scriptables_visible)) {
    level.explosion = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");

    foreach(var_1 in level.in_world_scriptables_visible)
    var_1 thread _id_13DA4();
  }
}

_id_13DA4() {
  self waittill("_encstr_8F5C086405E70FBA4B4A");
  var_0 = getEntArray("_encstr_A27319A3395AEC9DAC9CF5B21E381B7BE65ABD73D7F639B476A59B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    playFXOnTag(level.explosion, var_2, "_encstr_A2B40B8A283A7DD3254A1D4A27");
    level.player playSound("_encstr_8432170BB7222E0F52839078BA21DB20D75B83713D17D161BA");
  }
}

playerzombieprestream() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  wait 2;
  level scripts\engine\utility::flag_wait("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");
  var_0 = getEnt("_encstr_82CD1069B3AE1D730F60BDA64BEBD893D51B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13D22 = 0;

  for(;;) {
    while(level._id_13D22 > 3)
      waitframe();

    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_1.angles = var_0.angles;
    var_1 rotateby((0, 90, 0), 0.1);
    wait 1;
    var_0.playerzombiegasthink = var_1;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_A78F076CA54E1B1B56"), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

    if(isDefined(var_0.script_noteworthy)) {
      if(var_0.script_noteworthy == "_encstr_961804BD954A" && level.waiting_for_tactical_restock == level._id_13D5A) {
        var_2 = getEnt(var_0.script_noteworthy, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
        var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        var_1.angles = var_2.angles;
        var_1 rotateby((90, 0, 0), 0.1);
        wait 1;
        playFXOnTag(scripts\engine\utility::getfx("_encstr_A78F076CA54E1B1B56"), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        break;
      }
    }

    waitframe();
    var_0 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level._id_13D22++;
  }
}

_id_119D9() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  self.choppersupport_watchleash = self.angles;
  self._id_132A7 = scripts\engine\utility::getclosest(self.origin, level._id_13E8E, 250);
  self.center = scripts\engine\utility::getclosest(self.origin, level.get_weapon_in_power_slot, 250);

  if(isDefined(self._id_132A7))
    self._id_132A7 linkTo(self);

  if(isDefined(self.center))
    self.center linkTo(self);

  for(;;) {
    if(isDefined(level.check_for_early_impact)) {
      if(distance(level.check_for_early_impact.origin, self.origin) < level._id_13D63._id_12DC8 * 2) {
        var_0 = level.check_for_early_impact.origin[0] - self.origin[0];
        var_1 = level.check_for_early_impact.origin[1] - self.origin[1];
        var_2 = level.check_for_early_impact.origin[2] - self.origin[2];
        var_3 = var_0 * var_0;
        var_4 = var_1 * var_1;
        var_5 = var_2 * var_2;
        var_6 = sqrt(var_3 + var_4);
        var_7 = var_0 / var_6;
        var_8 = acos(var_7);
        var_9 = sqrt(var_3 + var_5);
        var_10 = var_0 / var_9;
        var_11 = acos(var_10);

        if(var_11 > level._id_13D63._id_12380)
          var_11 = level._id_13D63._id_12380;

        if(var_1 < 0)
          self rotateTo((self.choppersupport_watchleash[0], -1 * var_8, self.choppersupport_watchleash[2]), 0.1);
        else
          self rotateTo((self.choppersupport_watchleash[0], var_8, self.choppersupport_watchleash[2]), 0.1);

        waitframe();
        self._id_11E57 = self.angles;

        if(var_2 > 0)
          self rotateTo((-1 * var_11, self._id_11E57[1], self._id_11E57[2]), 0.1);
      }
    }

    waitframe();
  }
}

_id_13D44() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");

  while(!isDefined(level.check_for_early_impact) || !isDefined(level.player))
    waitframe();

  for(;;) {
    self._id_14196 = 0;
    level.player waittill("_encstr_81D60C6E0D7BB747F599635893B2");
    self._id_14196 = 1;
    wait 4;
  }
}

_id_13D43() {
  self endon("_encstr_AD75063D571AE108");

  while(!isDefined(level.player))
    waitframe();

  level.player waittill("_encstr_81D60C6E0D7BB747F599635893B2");
  self detonate();
}

_id_132B1() {
  level endon("_encstr_8E8A10EBDD83225CD149C54D03609DAB6D19");
  level waittill("_encstr_81040C8E9CD2B01BFACD1D2C4E3A");

  if(!istrue(level._id_13D63.spawn_assault2_extras)) {
    self._id_13E70 = deleteheadicon(self);
    setheadiconfriendlyimage(self._id_13E70, level._id_13D63.showclosingmessage);
    setheadiconsnaptoedges(self._id_13E70, level._id_13D63.showdangercircle);
    addclienttoheadiconmask(self._id_13E70, level._id_13D63.showdiscountsplash);
  }

  if(istrue(level._id_13D63.laser)) {
    self laseron();
    self.laser_on = 1;
  }

  for(;;) {
    if(isDefined(level.check_for_early_impact)) {
      if(distance(level.check_for_early_impact.origin, self.origin) <= level._id_13D63._id_12DC8) {
        if(istrue(self._id_14196)) {
          wait 1;
          continue;
        }

        var_0 = magicbullet(level._id_13D63.fixupscriptableorigin, self gettagorigin(level._id_13D63._id_13A23) + level._id_13D63._id_132B9, level.check_for_early_impact.origin);

        if(istrue(level._id_13D5C))
          var_0 thread _id_13D43();

        self hidepart("_encstr_8FD20B6BE0AA87786007DBC1A8");
        wait(level._id_13D63.playanim_vehicleturret * 0.5);
        self showpart("_encstr_8FD20B6BE0AA87786007DBC1A8");
        wait(level._id_13D63.playanim_vehicleturret * 0.5);
      }
    }

    waitframe();
  }
}

_id_13D62(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  level._id_13D63 = spawnStruct();

  if(isDefined(var_0))
    level._id_13D63.playanim_vehicleturret = var_0;
  else
    level._id_13D63.playanim_vehicleturret = 2.5;

  if(isDefined(var_9))
    level._id_13D63._id_12380 = var_9;
  else
    level._id_13D63._id_12380 = 35;

  if(isDefined(var_2))
    level._id_13D63._id_12DC8 = var_2;
  else
    level._id_13D63._id_12DC8 = 2500;

  if(isDefined(var_6))
    level._id_13D63.spawn_assault2_extras = var_6;
  else
    level._id_13D63.spawn_assault2_extras = 0;

  if(isDefined(var_3))
    level._id_13D63.showdangercircle = var_3;
  else
    level._id_13D63.showdangercircle = 4500;

  if(isDefined(var_4))
    level._id_13D63.showdiscountsplash = var_4;
  else
    level._id_13D63.showdiscountsplash = 40;

  if(isDefined(var_5))
    level._id_13D63.showclosingmessage = var_5;
  else
    level._id_13D63.showclosingmessage = "_encstr_96321214C71FF589CDD31BCE79D3311565109703";

  if(isDefined(var_7))
    level._id_13D63._id_13A23 = var_7;
  else
    level._id_13D63._id_13A23 = "_encstr_AC510D9BF16C9F3AA0299D6ECF3882";

  if(isDefined(var_8))
    level._id_13D63._id_132B9 = var_8;
  else
    level._id_13D63._id_132B9 = (30, 0, 10);

  if(isDefined(var_1))
    level._id_13D63.fixupscriptableorigin = var_1;
  else
    level._id_13D63.fixupscriptableorigin = "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8";

  if(isDefined(var_10))
    level._id_13D63.laser = var_10;
  else
    level._id_13D63.laser = 1;
}