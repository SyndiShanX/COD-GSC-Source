/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_594757b74170a035.gsc
***********************************************/

init() {
  level endon("game_ended");
  level._id_31EA373821CE8634 = [];
  level._id_31EA373821CE8634["boat_animated"] = getEnt("boat_animated", "script_noteworthy");
  level._id_31EA373821CE8634["boat_animated_console"] = getEnt("boat_animated_console", "script_noteworthy");
  level._id_31EA373821CE8634["boat_animated_fenders"] = getEnt("boat_animated_fenders", "script_noteworthy");
  level._id_31EA373821CE8634["boat_animated_col"] = getEnt("boat_animated_col", "targetname");
  level._id_31EA373821CE8634["boat_animated_loot_col"] = getEnt("boat_animated_loot_col", "targetname");
  level._id_31EA373821CE8634["boat_animated_buystation_col"] = getEnt("boat_animated_buystation_col", "targetname");
  level._id_31EA373821CE8634["boat_animated_workbench_col"] = getEnt("boat_animated_workbench_col", "targetname");
  level._id_A903A2E4256B025D = getdvarint("dvar_E1E143AC9F83FB0C", 0);
  scripts\cp_mp\utility\killstreak_utility::_id_6DB9B45F6855DEE1(::_id_0DE8D613DBD1BD92);
  scripts\cp_mp\utility\killstreak_utility::_id_2C70BFB1B580E8E0(::_id_0DE8D613DBD1BD92);
  _id_C0F29915001DBFBE = getdvarint("dvar_83DDCD166D021BBD", 0);

  if(_id_C0F29915001DBFBE <= 0)
    _id_D5500E7D96A6FE61(1);
  else {
    _id_3FBA6C7D8937FCA7();
    _id_9FFBEAF2D3787FAE(_id_C0F29915001DBFBE);
  }
}

_id_3FBA6C7D8937FCA7() {
  if(istrue(level._id_A903A2E4256B025D)) {
    return;
  }
  level._effect["vfx_boat_water_default"] = loadfx("vfx/iw9/level/mp_delta/taxiboat/vfx_delta_taxiboat_splashes.vfx");
  level._effect["vfx_boat_water_boost"] = loadfx("vfx/iw9/level/mp_delta/taxiboat/vfx_delta_taxiboat_splashes_boost.vfx");
}

_id_9FFBEAF2D3787FAE(_id_C0F29915001DBFBE) {
  level._id_3E263A5470FDF974 = getdvarint("dvar_BB3F48E6A5A39562", 2);
  level._id_C58480DAC131285E = [];

  if(istrue(level._id_A903A2E4256B025D) && _id_C0F29915001DBFBE > 1) {}

  _id_70760C7ED467976A();

  for(_id_A3D48AC920938BAD = 0; _id_A3D48AC920938BAD < _id_C0F29915001DBFBE; _id_A3D48AC920938BAD++) {
    if(getdvarint(_func_2EF675C13CA1C4AF("dvar_4C06FD2960D66C7D", _id_A3D48AC920938BAD), 1) == 0) {
      continue;
    }
    level._id_C58480DAC131285E[level._id_C58480DAC131285E.size] = _id_7DE6CD57148AC2EA(_id_A3D48AC920938BAD);

    if(istrue(level._id_A903A2E4256B025D) && level._id_C58480DAC131285E.size == 1) {
      break;
    }
  }

  _id_D5500E7D96A6FE61(0);
  level waittill("prematch_fade_done");

  foreach(_id_E169BA5510F51826 in level._id_C58480DAC131285E) {
    foreach(part in _id_E169BA5510F51826._id_53F547A05DF1E899._id_3FA5EA8F1C170E8B)
    part show();

    thread _id_F60C356AF6B5EE00(_id_E169BA5510F51826);
    thread _id_B05F62DB07829769(_id_E169BA5510F51826);
    thread _id_BD246D1AC3257EBC(_id_E169BA5510F51826);

    if(istrue(level._id_A903A2E4256B025D))
      thread _id_EDA1AACC2FEE7DFB(_id_E169BA5510F51826, "static");
    else
      thread _id_EDA1AACC2FEE7DFB(_id_E169BA5510F51826, "visible");

    waitframe();
    _id_4F7BBF77BE111E3E(_id_E169BA5510F51826, 0);
  }
}

_id_7DE6CD57148AC2EA(_id_A3D48AC920938BAD) {
  _id_E2E4A2412ACAFDA7 = spawnStruct();
  _id_E2E4A2412ACAFDA7.index = _id_A3D48AC920938BAD;
  _id_E2E4A2412ACAFDA7._id_159EC9A052E1EFDA = level._id_31EA373821CE8634["boat_animated"];
  _id_E2E4A2412ACAFDA7.console = level._id_31EA373821CE8634["boat_animated_console"];
  _id_E2E4A2412ACAFDA7._id_D86F09EDC60D473A = level._id_31EA373821CE8634["boat_animated_fenders"];
  _id_E2E4A2412ACAFDA7._id_0FF2A1EDCD931BA3 = _id_E2E4A2412ACAFDA7._id_159EC9A052E1EFDA.origin;
  _id_E2E4A2412ACAFDA7.parentangles = _id_E2E4A2412ACAFDA7._id_159EC9A052E1EFDA.angles;
  _id_E2E4A2412ACAFDA7.spawnorigin = (0, 0, 0);
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899 = _id_B2DA5FBAFB7A556D(_id_E2E4A2412ACAFDA7, _id_E2E4A2412ACAFDA7._id_159EC9A052E1EFDA.model, _id_E2E4A2412ACAFDA7.spawnorigin, 1);
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_3FA5EA8F1C170E8B = [];
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_C07ED7A11BAAC844 = [];
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_229AB5AFB5B2CF09 = _id_B2DA5FBAFB7A556D(_id_E2E4A2412ACAFDA7, _id_E2E4A2412ACAFDA7._id_159EC9A052E1EFDA.model, _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899 gettagorigin("tag_origin"), 1, 1, "tag_origin");
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_B1F0888771250843 = _id_B2DA5FBAFB7A556D(_id_E2E4A2412ACAFDA7, _id_E2E4A2412ACAFDA7.console.model, _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899 gettagorigin("tag_console"), 1, 1, "tag_console");
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_BA3E499B0A42B2B7 = _id_B2DA5FBAFB7A556D(_id_E2E4A2412ACAFDA7, _id_E2E4A2412ACAFDA7._id_D86F09EDC60D473A.model, _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899 gettagorigin("tag_origin"), 1, 1, "tag_origin");
  _id_E2E4A2412ACAFDA7._id_D0515D2D282753F8 = _id_3E6DB35974F33D54(_id_E2E4A2412ACAFDA7, level._id_31EA373821CE8634["boat_animated_col"]);
  _id_E2E4A2412ACAFDA7._id_59B93F169AC7B532 = _id_3E6DB35974F33D54(_id_E2E4A2412ACAFDA7, level._id_31EA373821CE8634["boat_animated_loot_col"]);
  _id_E2E4A2412ACAFDA7._id_E38A35F2EFDE2619 = _id_3E6DB35974F33D54(_id_E2E4A2412ACAFDA7, level._id_31EA373821CE8634["boat_animated_buystation_col"]);

  if(_id_67CC94C07AB18D3A::_id_19598C1EA1487B84())
    _id_E2E4A2412ACAFDA7._id_191A37FBC538CB73 = _id_3E6DB35974F33D54(_id_E2E4A2412ACAFDA7, level._id_31EA373821CE8634["boat_animated_workbench_col"]);

  _id_3AF2E5238171EA5F(_id_E2E4A2412ACAFDA7);
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899.animname = "boat";
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899 useanimtree(level.scr_animtree["boat"]);
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_BA3E499B0A42B2B7.animname = "boat";
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_BA3E499B0A42B2B7 useanimtree(level.scr_animtree["boat"]);

  if(getdvarint("dvar_438944D373BB61B3", 1) == 1 && !istrue(level._id_A903A2E4256B025D)) {
    _id_37786C9125A59671 = _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_229AB5AFB5B2CF09 gettagorigin("tag_button");
    prompt = spawn("script_model", _id_37786C9125A59671);
    prompt setModel("tag_origin");
    prompt makeusable();
    prompt.usable = 1;
    prompt setHintString(&"MP_BR_INGAME/BOOST_BOAT");
    prompt setCursorHint("HINT_BUTTON");
    prompt sethintdisplayrange(150);
    prompt sethintdisplayfov(90);
    prompt setuserange(75);
    prompt setusefov(90);
    prompt sethintonobstruction("hide");
    prompt setuseholdduration("duration_short");
    prompt linkTo(_id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_229AB5AFB5B2CF09);
    _id_E2E4A2412ACAFDA7.prompt = prompt;
    thread _id_4DB5659EC39E2883(_id_E2E4A2412ACAFDA7);
  }

  _id_E2E4A2412ACAFDA7._id_A679C918818FA808 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("boat_animated_loot", "script_noteworthy"));
  _id_E2E4A2412ACAFDA7._id_FD5B04DE8603C8A6 = ::_id_FD5B04DE8603C8A6;
  _id_E2E4A2412ACAFDA7._id_1C778D8B7CF24458 = [];
  _id_E2E4A2412ACAFDA7 thread _id_541CFCD5F1D53312();
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_229AB5AFB5B2CF09.vehiclename = "taxi_boat";
  _id_E2E4A2412ACAFDA7._id_53F547A05DF1E899._id_229AB5AFB5B2CF09 thread _id_5FD79768B8941CFB::_id_E549E7BB5A16C3BC();
  return _id_E2E4A2412ACAFDA7;
}

_id_541CFCD5F1D53312() {
  level waittill("spawning_POIs");
  thread _id_5FD79768B8941CFB::_id_B585808F22E26AA6(self, self._id_53F547A05DF1E899._id_229AB5AFB5B2CF09);
}

_id_B2DA5FBAFB7A556D(_id_E169BA5510F51826, modelpart, spawnorigin, _id_9B7A43A490A25FC4, _id_FA3DDA935AEFC158, _id_64F8415371D5D6FF) {
  model = spawn("script_model", spawnorigin);
  model setModel(modelpart);
  model forcenetfieldhighlod(1);
  model hide();

  if(istrue(_id_9B7A43A490A25FC4)) {
    model setmoveroptimized(1);
    model setmoverantilagged(1);
    model markkeyframedmover();
  }

  if(istrue(_id_FA3DDA935AEFC158)) {
    _id_E169BA5510F51826._id_53F547A05DF1E899._id_3FA5EA8F1C170E8B = scripts\engine\utility::array_add(_id_E169BA5510F51826._id_53F547A05DF1E899._id_3FA5EA8F1C170E8B, model);
    _id_E169BA5510F51826._id_53F547A05DF1E899._id_C07ED7A11BAAC844 = scripts\engine\utility::array_add(_id_E169BA5510F51826._id_53F547A05DF1E899._id_C07ED7A11BAAC844, _id_64F8415371D5D6FF);
  }

  model._id_E6E657A1FA139548 = 1;
  return model;
}

#using_animtree("script_model");

_id_3AF2E5238171EA5F(_id_E169BA5510F51826) {
  _id_A3D48AC920938BAD = _id_E169BA5510F51826.index;
  level.scr_animtree["boat"] = #animtree;
  _id_729D012D77756A17 = [%iw9_mp_boat_delta_0];
  _id_ABDAD3B441F4430A = [%iw9_mp_boat_delta_0_propeller];

  if(isDefined(_id_729D012D77756A17[_id_A3D48AC920938BAD])) {
    level.scr_anim["boat"]["iw9_mp_boat_delta_" + _id_A3D48AC920938BAD][0] = _id_729D012D77756A17[_id_A3D48AC920938BAD];
    level.scr_anim["boat"]["iw9_mp_boat_delta_" + _id_A3D48AC920938BAD + "_propeller"][0] = _id_ABDAD3B441F4430A[_id_A3D48AC920938BAD];
  } else
    return;

  _id_E169BA5510F51826._id_E8269983E7C48724 = "iw9_mp_boat_delta_" + _id_A3D48AC920938BAD;
  _id_E169BA5510F51826._id_53F547A05DF1E899._id_2A0CDFB9D7318ABD = "iw9_mp_boat_delta_" + _id_A3D48AC920938BAD + "_propeller";
  level.scr_animname["boat"]["iw9_mp_boat_delta_" + _id_A3D48AC920938BAD][0] = _id_E169BA5510F51826._id_E8269983E7C48724;
  level.scr_animname["boat"]["iw9_mp_boat_delta_" + _id_A3D48AC920938BAD + "_propeller"][0] = _id_E169BA5510F51826._id_53F547A05DF1E899._id_2A0CDFB9D7318ABD;
}

_id_3E6DB35974F33D54(_id_E169BA5510F51826, _id_93E03E05AA0D3D35) {
  if(isDefined(_id_93E03E05AA0D3D35)) {
    _id_482392C9BAE29B00 = _id_93E03E05AA0D3D35.origin - _id_E169BA5510F51826._id_0FF2A1EDCD931BA3;
    col = spawn("script_model", _id_E169BA5510F51826.spawnorigin + _id_482392C9BAE29B00);
    col clonebrushmodeltoscriptmodel(_id_93E03E05AA0D3D35, 1);
    col linkTo(_id_E169BA5510F51826._id_53F547A05DF1E899._id_229AB5AFB5B2CF09);
    col._id_E6E657A1FA139548 = 1;
    return col;
  }
}

_id_F60C356AF6B5EE00(_id_E169BA5510F51826) {
  level endon("game_ended");
  animnode = spawn("script_origin", (0, 0, 0));
  animnode thread scripts\common\anim::anim_loop_solo(_id_E169BA5510F51826._id_53F547A05DF1E899, _id_E169BA5510F51826._id_E8269983E7C48724);
  _id_EB5B1F36E255152D = scripts\engine\utility::ter_op(istrue(level._id_A903A2E4256B025D), 0.205, randomfloat(1.0));
  _id_E169BA5510F51826._id_53F547A05DF1E899 setanimtime(_id_E169BA5510F51826._id_53F547A05DF1E899 scripts\engine\utility::getanim(_id_E169BA5510F51826._id_E8269983E7C48724)[0], _id_EB5B1F36E255152D);
  _id_07B60BC0EAB3FD1E = scripts\engine\utility::ter_op(istrue(level._id_A903A2E4256B025D), 0, 1);
  _id_E169BA5510F51826._id_53F547A05DF1E899 setanimrate(_id_E169BA5510F51826._id_53F547A05DF1E899 scripts\engine\utility::getanim(_id_E169BA5510F51826._id_E8269983E7C48724)[0], _id_07B60BC0EAB3FD1E);
  thread _id_A60AB6023ECDFB05(_id_E169BA5510F51826);
}

_id_B05F62DB07829769(_id_E169BA5510F51826) {
  if(istrue(level._id_A903A2E4256B025D)) {
    return;
  }
  _id_E169BA5510F51826._id_53F547A05DF1E899._id_F5AB71E8BF7A604B = ::_id_E767A0C958CCE019;
  _id_E26F44ACAD48DDD1 = _id_E169BA5510F51826._id_53F547A05DF1E899 scripts\engine\utility::getanim(_id_E169BA5510F51826._id_E8269983E7C48724)[0];
  _id_00CDD725F8F73B94 = _id_5FD79768B8941CFB::_id_FFD9B2FE58C97F7C(_id_E169BA5510F51826._id_53F547A05DF1E899, _id_E26F44ACAD48DDD1);
  _id_E169BA5510F51826._id_53F547A05DF1E899._id_BA3E499B0A42B2B7 scriptmodelplayanim(_id_E169BA5510F51826._id_53F547A05DF1E899._id_2A0CDFB9D7318ABD, undefined, _id_00CDD725F8F73B94, 1);
}

_id_E767A0C958CCE019(_id_A93234E28B698E6E, _id_E26F44ACAD48DDD1, _id_CE38E1F73463A7E5) {
  _id_1A8845119460CC78(_id_A93234E28B698E6E, _id_E26F44ACAD48DDD1, _id_CE38E1F73463A7E5);
}

_id_1A8845119460CC78(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_CE38E1F73463A7E5) {
  _id_00CDD725F8F73B94 = _id_5FD79768B8941CFB::_id_FFD9B2FE58C97F7C(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1);
  _id_CE38E1F73463A7E5 = _func_C5CF558181E12D1F(_id_CE38E1F73463A7E5, 0.001);
  _id_B2A3F9ABCEE9D071._id_BA3E499B0A42B2B7 scriptmodelplayanim(_id_B2A3F9ABCEE9D071._id_2A0CDFB9D7318ABD, undefined, _id_00CDD725F8F73B94, _id_CE38E1F73463A7E5);
}

_id_BD246D1AC3257EBC(_id_E169BA5510F51826) {
  for(;;) {
    _id_B2A3F9ABCEE9D071 = _id_E169BA5510F51826._id_53F547A05DF1E899;
    _id_5A5D30ECD18129C0 = _id_E169BA5510F51826._id_53F547A05DF1E899._id_3FA5EA8F1C170E8B;
    _id_C07ED7A11BAAC844 = _id_E169BA5510F51826._id_53F547A05DF1E899._id_C07ED7A11BAAC844;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5A5D30ECD18129C0.size; _id_AC0E594AC96AA3A8++) {
      _id_DB9A56EDADC7D853 = _id_C07ED7A11BAAC844[_id_AC0E594AC96AA3A8];
      targetorigin = _id_B2A3F9ABCEE9D071 gettagorigin(_id_DB9A56EDADC7D853);
      targetangles = _id_B2A3F9ABCEE9D071 gettagangles(_id_DB9A56EDADC7D853);
      fraction = 0.1;
      targetorigin = vectorlerp(_id_5A5D30ECD18129C0[_id_AC0E594AC96AA3A8].origin, targetorigin, fraction);
      _id_5A5D30ECD18129C0[_id_AC0E594AC96AA3A8].origin = targetorigin;
      targetangles = anglelerpquatfrac(_id_5A5D30ECD18129C0[_id_AC0E594AC96AA3A8].angles, targetangles, fraction);
      _id_5A5D30ECD18129C0[_id_AC0E594AC96AA3A8].angles = targetangles;
    }

    waitframe();
    waittillframeend;
  }
}

_id_D5500E7D96A6FE61(_id_8490FED4D87AA38A) {
  foreach(ent in level._id_31EA373821CE8634) {
    if(isDefined(ent))
      ent delete();
  }

  level._id_31EA373821CE8634 = undefined;

  if(istrue(_id_8490FED4D87AA38A)) {
    _id_99A7072704CE3FC5 = getEnt("trigger_multiple_boat", "targetname");

    if(isDefined(_id_99A7072704CE3FC5))
      _id_99A7072704CE3FC5 delete();
  }
}

_id_4DB5659EC39E2883(_id_E169BA5510F51826) {
  level waittill("prematch_fade_done");

  for(;;) {
    if(istrue(_id_E169BA5510F51826.prompt.usable)) {
      _id_E169BA5510F51826.prompt waittill("trigger", player);
      thread _id_9BCE4F55A77F4FA3(_id_E169BA5510F51826);
    }

    waitframe();
  }
}

_id_9BCE4F55A77F4FA3(_id_E169BA5510F51826, _id_F41C1CB3E9DE42E6) {
  _id_E169BA5510F51826._id_AB00B2E3F4985E60 = 1;
  _id_B2A3F9ABCEE9D071 = _id_E169BA5510F51826._id_53F547A05DF1E899;
  _id_E26F44ACAD48DDD1 = _id_E169BA5510F51826._id_53F547A05DF1E899 scripts\engine\utility::getanim(_id_E169BA5510F51826._id_E8269983E7C48724)[0];
  _id_FE1033CAE51778CC = 1;
  _id_E169BA5510F51826.prompt _id_3EB41D01460B6207(0);

  if(istrue(_id_F41C1CB3E9DE42E6))
    wait 3;

  thread _id_9F29E250AFDAF06F(_id_E169BA5510F51826);
  thread _id_EDA1AACC2FEE7DFB(_id_E169BA5510F51826, "boost");
  _id_FE1033CAE51778CC = _id_5FD79768B8941CFB::_id_702EE23ACA4D2485(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_FE1033CAE51778CC, 0.4, 2);
  wait 3;
  _id_4F7BBF77BE111E3E(_id_E169BA5510F51826, 1);
  _id_FE1033CAE51778CC = _id_5FD79768B8941CFB::_id_702EE23ACA4D2485(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_FE1033CAE51778CC, 2.4, 3);
  wait 9;
  _id_CE27F2C93F299F99 = _id_CE27F2C93F299F99(_id_E169BA5510F51826._id_53F547A05DF1E899._id_229AB5AFB5B2CF09.origin);

  if(_id_CE27F2C93F299F99)
    _id_E169BA5510F51826._id_53F547A05DF1E899._id_229AB5AFB5B2CF09 waittill("boat_out_of_gas");

  if(_id_CE27F2C93F299F99 || istrue(_id_F41C1CB3E9DE42E6))
    wait 3;

  _id_4F7BBF77BE111E3E(_id_E169BA5510F51826, 0);
  thread _id_EDA1AACC2FEE7DFB(_id_E169BA5510F51826, "visible");
  _id_FE1033CAE51778CC = _id_5FD79768B8941CFB::_id_702EE23ACA4D2485(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_FE1033CAE51778CC, 1, 3);
  wait 10;
  _id_E169BA5510F51826.prompt _id_3EB41D01460B6207(1);
  _id_E169BA5510F51826._id_AB00B2E3F4985E60 = undefined;
}

_id_3EB41D01460B6207(usable) {
  if(istrue(usable)) {
    self _meth_DFB78B3E724AD620(1);
    self.usable = 1;
  } else {
    self _meth_DFB78B3E724AD620(0);
    self.usable = 0;
  }
}

_id_EDA1AACC2FEE7DFB(_id_E169BA5510F51826, state) {
  level endon("game_ended");
  _id_BCACBE8A5C421344 = _id_E169BA5510F51826._id_53F547A05DF1E899._id_229AB5AFB5B2CF09;

  if(isDefined(_id_BCACBE8A5C421344) && _id_BCACBE8A5C421344 isscriptable() && _id_BCACBE8A5C421344 getscriptablehaspart("boat_part") && _id_BCACBE8A5C421344 getscriptableparthasstate("boat_part", state))
    _id_BCACBE8A5C421344 setscriptablepartstate("boat_part", state);
}

_id_4F7BBF77BE111E3E(_id_E169BA5510F51826, _id_52C729C79C6ACC55) {
  if(istrue(level._id_A903A2E4256B025D)) {
    return;
  }
  effect = scripts\engine\utility::ter_op(istrue(_id_52C729C79C6ACC55), "vfx_boat_water_boost", "vfx_boat_water_default");
  _id_8C44BF99399EDF9A = level._effect[effect];

  if(isDefined(_id_E169BA5510F51826._id_96BD7246660BEEEF))
    stopFXOnTag(_id_E169BA5510F51826._id_96BD7246660BEEEF, _id_E169BA5510F51826._id_53F547A05DF1E899._id_229AB5AFB5B2CF09, "tag_origin");

  playFXOnTag(_id_8C44BF99399EDF9A, _id_E169BA5510F51826._id_53F547A05DF1E899._id_229AB5AFB5B2CF09, "tag_origin");
  _id_E169BA5510F51826._id_96BD7246660BEEEF = _id_8C44BF99399EDF9A;
}

_id_9F29E250AFDAF06F(_id_E169BA5510F51826) {
  level endon("game_ended");
  _id_E169BA5510F51826._id_53F547A05DF1E899._id_B1F0888771250843 playsoundonmovingent("veh_taxiboat_push_button");
}

_id_FD5B04DE8603C8A6(_id_9B9F1075DB564ACD, loot, type) {
  _id_0774C9CA5D1D6221 = getdvarint("dvar_4838B7C39021124C");
  _id_FA94BD52C9E57FAA = getdvarint("dvar_28839B0F1BEAB8B2", -1);
  _id_E9B6D69CA3AE473D = scripts\engine\utility::ter_op(_id_FA94BD52C9E57FAA >= 0, _id_FA94BD52C9E57FAA, _id_0774C9CA5D1D6221);

  if(_id_9B9F1075DB564ACD._id_1C778D8B7CF24458.size < _id_E9B6D69CA3AE473D)
    type = "br_loot_cache_lege";

  scriptable = _id_5FD79768B8941CFB::_id_E3F46AD7BAC518E8(loot, type);
  _id_9B9F1075DB564ACD._id_1C778D8B7CF24458[_id_9B9F1075DB564ACD._id_1C778D8B7CF24458.size] = scriptable;
  return scriptable;
}

_id_CE27F2C93F299F99(_id_4968ED8F80B09A79) {
  return _id_1174ABEDBEFE9ADA::_id_076EF3C8B8171D2D(_id_4968ED8F80B09A79) && (isDefined(level.br_circle) || isDefined(level._id_33A2175A9A4306BC));
}

_id_A60AB6023ECDFB05(_id_E169BA5510F51826) {
  level endon("game_ended");

  if(istrue(level._id_A903A2E4256B025D)) {
    return;
  }
  for(;;) {
    if(_id_CE27F2C93F299F99(_id_E169BA5510F51826._id_53F547A05DF1E899._id_229AB5AFB5B2CF09.origin)) {
      _id_E169BA5510F51826._id_5B68AD9D6ABD399E = 1;

      if(!istrue(_id_E169BA5510F51826._id_AB00B2E3F4985E60))
        thread _id_9BCE4F55A77F4FA3(_id_E169BA5510F51826, 1);
    } else if(istrue(_id_E169BA5510F51826._id_5B68AD9D6ABD399E)) {
      _id_E169BA5510F51826._id_53F547A05DF1E899._id_229AB5AFB5B2CF09 notify("boat_out_of_gas");
      _id_E169BA5510F51826._id_5B68AD9D6ABD399E = undefined;
    }

    wait 2;
  }
}

_id_0DE8D613DBD1BD92(movingplatforment) {
  if(!isDefined(movingplatforment))
    return 0;

  if(isDefined(level._id_C58480DAC131285E)) {
    foreach(_id_E169BA5510F51826 in level._id_C58480DAC131285E) {
      foreach(_id_6B005C97ABEDDA3A in _id_E169BA5510F51826._id_53F547A05DF1E899._id_3FA5EA8F1C170E8B) {
        if(_id_6B005C97ABEDDA3A == movingplatforment)
          return 1;
      }

      if(_id_E169BA5510F51826._id_D0515D2D282753F8 == movingplatforment)
        return 1;
    }
  }

  return 0;
}

_id_70760C7ED467976A() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_getleveldataforvehicle("taxi_boat", 1);
  _id_E2818AD39A3341B4.handleeventcallback = ::_id_A42948A64BCDF0A9;
  _id_E2818AD39A3341B4.class = "immovable";
}

_id_A42948A64BCDF0A9(_id_C975FCDFFCE9C9A6, _id_C975FBDFFCE9C773) {
  _id_5FD79768B8941CFB::_id_84114ACFF04CFCCB(_id_C975FCDFFCE9C9A6, _id_C975FBDFFCE9C773, "taxi_boat", 2, 75);
}