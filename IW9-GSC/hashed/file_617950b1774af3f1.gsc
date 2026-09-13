/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_617950b1774af3f1.gsc
***********************************************/

init() {
  if(!isDefined(level.wztrain_info))
    level.wztrain_info = spawnStruct();

  setup_callbacks();
  level.wztrain_info.anim_spawnposition_override = (0, 0, 0);
  level.wztrain_info._id_4F0382615A2A1259 = "_hurt_trigger";
  level.wztrain_info._id_0DDC55FBCFA86D44 = "tram_assembly_loop";
  level.wztrain_info._id_FE47FF8E697AD1D2 = ["tram_west_to_east", "tram_east_to_west"];
  level.wztrain_info._id_89F6C79D27DC03D6 = getdvarfloat("dvar_12140BFEB0A869F3", 0.3);
  _id_54DD3D9BC29908A2 = getdvarint("dvar_F1494C879154DB8B", 0) == 1;

  if(_id_54DD3D9BC29908A2) {
    foreach(train in level.wztrain_info._id_FE47FF8E697AD1D2)
    thread _id_EE4013977155FC5F(train);
  }

  level thread _id_06AD4F9E2F4C6105::init(_id_54DD3D9BC29908A2);
  level thread _id_A1AF09D5EDF7774B();
}

setup_callbacks() {
  level.wztrain_info._id_0B330D787646FC2F = [];
  level.wztrain_info._id_0B330D787646FC2F[0] = ::_id_39B94E6D05E60061;

  if(getdvarint("dvar_D79391973E7C0E8A", 0) > 0)
    level.wztrain_info._id_0B330D787646FC2F[1] = ::_id_84F1A4CD01ACBDE7;

  level.wztrain_info._id_A086219602817DCA = ::_id_A086219602817DCA;
  level.wztrain_info._id_ECF7A389446FC63E = ::_id_ECF7A389446FC63E;
  level.wztrain_info._id_799BABD43D318D4B = ::_id_799BABD43D318D4B;
  level.wztrain_info._id_A474378E909E8412 = ::_id_A474378E909E8412;
  level.wztrain_info._id_0ED3CE45AE9F6B34 = ::_id_0ED3CE45AE9F6B34;
  level.wztrain_info._id_00E52CCB14A1AAE9 = ::_id_00E52CCB14A1AAE9;
  level.wztrain_info._id_2AFE24EE912AB8A1 = ::_id_2AFE24EE912AB8A1;
  level.wztrain_info._id_3079813E25479249 = ::_id_3079813E25479249;
  level.wztrain_info._id_80BF76189FA2ACFE = ::_id_80BF76189FA2ACFE;
  level.wztrain_info._id_3BAA47599DD64511 = ::_id_3BAA47599DD64511;
  level.wztrain_info._id_1256D82C90A0D4DC = ::_id_1256D82C90A0D4DC;
  level.wztrain_info._id_11498702BEAFAA13 = ::_id_11498702BEAFAA13;
}

_id_EE4013977155FC5F(train) {
  scripts\engine\utility::flag_wait("wztrain_array_set");
  pause_time = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_F4A0CE01AA2AD77D", train, "_position"), 0);
  _id_062573638A2257E1 = level.scr_anim[level.wztrain_info._id_B2A3F9ABCEE9D071[train].animname][level.wztrain_info._id_0DDC55FBCFA86D44];
  level.wztrain_info.animstruct[train] thread scripts\common\anim::anim_single_solo(level.wztrain_info._id_B2A3F9ABCEE9D071[train], level.wztrain_info._id_0DDC55FBCFA86D44);
  level.wztrain_info._id_B2A3F9ABCEE9D071[train] setanimrate(_id_062573638A2257E1, 0);
  scripts\common\anim::anim_set_time_solo(level.wztrain_info._id_B2A3F9ABCEE9D071[train], level.wztrain_info._id_0DDC55FBCFA86D44, pause_time);
  wait 1;
  _id_6981733D0D7F4088(train);
  _id_A474378E909E8412(train, 1, 1);
  _id_06AD4F9E2F4C6105::_id_09DD6A5882C62DD6(train);
}

_id_39B94E6D05E60061() {
  _id_C3608581A9D3C2D4 = getEnt("tram_front_car_collision", "script_noteworthy");
  _id_15CD83EDA5CA1BD4 = getEnt("tram_front_accordion_collision", "script_noteworthy");
  _id_C3608881A9D3C96D = getEnt("tram_middle_car_1_collision", "script_noteworthy");
  _id_15CD86EDA5CA226D = getEnt("tram_middle_accordion_collision", "script_noteworthy");
  _id_C3608781A9D3C73A = getEnt("tram_middle_car_2_collision", "script_noteworthy");
  _id_15CD85EDA5CA203A = getEnt("tram_end_accordion_collision", "script_noteworthy");
  _id_C3608281A9D3BC3B = getEnt("tram_end_car_collision", "script_noteworthy");
  _id_C3608781A9D3C73A._id_02E4045FFDF8A8F7 = 1;
  return [_id_C3608581A9D3C2D4, _id_15CD83EDA5CA1BD4, _id_C3608881A9D3C96D, _id_15CD86EDA5CA226D, _id_C3608781A9D3C73A, _id_15CD85EDA5CA203A, _id_C3608281A9D3BC3B];
}

_id_84F1A4CD01ACBDE7() {
  _id_247993D2AC594CC5 = level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]];
  _id_708235847FCBA1FC = _id_ECF7A389446FC63E(level.wztrain_info._id_FE47FF8E697AD1D2[0]);
  _id_7C87EF80F0DB4D00 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_247993D2AC594CC5.size; _id_AC0E594AC96AA3A8++) {
    _id_69E05CB1C9FCB738 = spawn("script_model", _id_247993D2AC594CC5[_id_AC0E594AC96AA3A8].origin);
    _id_69E05CB1C9FCB738.script_noteworthy = _id_247993D2AC594CC5[_id_AC0E594AC96AA3A8].script_noteworthy + "_02";
    _id_69E05CB1C9FCB738 clonebrushmodeltoscriptmodel(_id_247993D2AC594CC5[_id_AC0E594AC96AA3A8]);
    _id_7C87EF80F0DB4D00[_id_AC0E594AC96AA3A8] = _id_69E05CB1C9FCB738;
    _id_7C87EF80F0DB4D00[_id_AC0E594AC96AA3A8]._id_02E4045FFDF8A8F7 = istrue(_id_247993D2AC594CC5[_id_AC0E594AC96AA3A8]._id_02E4045FFDF8A8F7);
    _id_FB11DAA1115F23AE = getEnt(_id_708235847FCBA1FC[_id_AC0E594AC96AA3A8], "script_noteworthy");
    _id_045CBA258016071A = spawn("script_model", _id_FB11DAA1115F23AE.origin);
    _id_045CBA258016071A setModel(_id_FB11DAA1115F23AE.model);
    _id_045CBA258016071A.script_noteworthy = _id_708235847FCBA1FC[_id_AC0E594AC96AA3A8] + "_02";
    _id_D77AD174283443F4 = scripts\engine\utility::getStructArray(_id_247993D2AC594CC5[_id_AC0E594AC96AA3A8].script_noteworthy + "_loot", "script_noteworthy");

    foreach(loot in _id_D77AD174283443F4) {
      _id_0A009E3A5E9C1FD0 = spawnStruct();
      _id_0A009E3A5E9C1FD0.script_noteworthy = _id_69E05CB1C9FCB738.script_noteworthy + "_loot";
      _id_0A009E3A5E9C1FD0.targetname = loot.targetname;
      _id_0A009E3A5E9C1FD0.origin = loot.origin;
      _id_0A009E3A5E9C1FD0.angles = loot.angles;
      scripts\engine\utility::_id_1F6C1A9B7564DC61(_id_0A009E3A5E9C1FD0);
    }
  }

  return _id_7C87EF80F0DB4D00;
}

_id_A086219602817DCA(train) {
  if(!isDefined(level.wztrain_info._id_E43F441596208B11))
    level.wztrain_info._id_E43F441596208B11 = [];

  if(train == "tram_west_to_east") {
    level.wztrain_info._id_C7FA4156EDB887D7[train] = [];
    level.wztrain_info._id_C7FA4156EDB887D7[train]["Castle"] = (-12000, 830, 189);
    level.wztrain_info._id_C7FA4156EDB887D7[train]["Cemetery"] = (-7540, 866, 114);
    level.wztrain_info._id_C7FA4156EDB887D7[train]["Market"] = (-430, 855, 190);
    level.wztrain_info._id_C7FA4156EDB887D7[train]["Central Station"] = (13733, -1866, 191);
    level.wztrain_info._id_E43F441596208B11[train] = "Central Station";
  } else if(train == "tram_east_to_west") {
    level.wztrain_info._id_C7FA4156EDB887D7[train] = [];
    level.wztrain_info._id_C7FA4156EDB887D7[train]["Mall"] = (3450, 1531, 202);
    level.wztrain_info._id_C7FA4156EDB887D7[train]["Market"] = (-2159, 1413, 190);
    level.wztrain_info._id_C7FA4156EDB887D7[train]["Cemetery"] = (-4636, 1459, 178);
    level.wztrain_info._id_C7FA4156EDB887D7[train]["Castle"] = (-14875, 416, 174);
    level.wztrain_info._id_E43F441596208B11[train] = "Castle";
  }
}

_id_ECF7A389446FC63E(_id_2386E682A2AA4874) {
  _id_01003422AA3768B8 = [];
  _id_4DF5911367376FBA = [];
  _id_AEF7103BDD1DAC23 = level.wztrain_info._id_FE47FF8E697AD1D2[0];
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23] = [];
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_front_car_model";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_front_accordion_model";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_middle_car_1_model";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_middle_accordion_model";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_middle_car_2_model";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_end_accordion_model";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_end_car_model";
  _id_01003422AA3768B8 = scripts\engine\utility::array_combine(_id_01003422AA3768B8, _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23]);
  _id_AEF7103BDD1DAC23 = level.wztrain_info._id_FE47FF8E697AD1D2[1];
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23] = [];
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_front_car_model_02";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_front_accordion_model_02";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_middle_car_1_model_02";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_middle_accordion_model_02";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_middle_car_2_model_02";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_end_accordion_model_02";
  _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23][_id_4DF5911367376FBA[_id_AEF7103BDD1DAC23].size] = "tram_end_car_model_02";
  _id_01003422AA3768B8 = scripts\engine\utility::array_combine(_id_01003422AA3768B8, _id_4DF5911367376FBA[_id_AEF7103BDD1DAC23]);
  _id_748A5B6E1EB008F5 = _id_01003422AA3768B8;

  if(isDefined(_id_2386E682A2AA4874))
    _id_748A5B6E1EB008F5 = _id_4DF5911367376FBA[_id_2386E682A2AA4874];

  return _id_748A5B6E1EB008F5;
}

#using_animtree("script_model");

_id_799BABD43D318D4B() {
  level.scr_anim[level.wztrain_info._id_FE47FF8E697AD1D2[0]][level.wztrain_info._id_0DDC55FBCFA86D44] = % iw9_mp_delta_tramway_a;
  level.scr_animname[level.wztrain_info._id_FE47FF8E697AD1D2[0]][level.wztrain_info._id_0DDC55FBCFA86D44] = "iw9_mp_delta_tramway_a";
  level.scr_animtree[level.wztrain_info._id_FE47FF8E697AD1D2[0]] = #animtree;
  level.scr_anim[level.wztrain_info._id_FE47FF8E697AD1D2[1]][level.wztrain_info._id_0DDC55FBCFA86D44] = % iw9_mp_delta_tramway_b;
  level.scr_animname[level.wztrain_info._id_FE47FF8E697AD1D2[1]][level.wztrain_info._id_0DDC55FBCFA86D44] = "iw9_mp_delta_tramway_b";
  level.scr_animtree[level.wztrain_info._id_FE47FF8E697AD1D2[1]] = #animtree;
  level.scr_anim["accordion_front"]["gangway_loop"][0] = % iw9_mp_delta_tramway_gangway01;
  level.scr_animtree["accordion_front"] = #animtree;
  level.scr_anim["accordion_front_02"]["gangway_loop"][0] = % iw9_mp_delta_tramway_b_gangway01;
  level.scr_animtree["accordion_front_02"] = #animtree;
  level.scr_anim["accordion_middle"]["gangway_loop"][0] = % iw9_mp_delta_tramway_gangway02;
  level.scr_animtree["accordion_middle"] = #animtree;
  level.scr_anim["accordion_middle_02"]["gangway_loop"][0] = % iw9_mp_delta_tramway_b_gangway02;
  level.scr_animtree["accordion_middle_02"] = #animtree;
  level.scr_anim["accordion_end"]["gangway_loop"][0] = % iw9_mp_delta_tramway_gangway03;
  level.scr_animtree["accordion_end"] = #animtree;
  level.scr_anim["accordion_end_02"]["gangway_loop"][0] = % iw9_mp_delta_tramway_b_gangway03;
  level.scr_animtree["accordion_end_02"] = #animtree;
}

_id_A474378E909E8412(_id_949475D0823BC895, _id_07B60BC0EAB3FD1E, _id_801E1E61EBB9C5E3) {
  _id_776BAE99312943AE = level.wztrain_info._id_B2A3F9ABCEE9D071[_id_949475D0823BC895];
  _id_776BAE99312943AE._id_F5AB71E8BF7A604B = ::_id_17669CD4A286A10F;
  _id_E26F44ACAD48DDD1 = level.scr_anim[_id_949475D0823BC895][level.wztrain_info._id_0DDC55FBCFA86D44];
  index = "";

  if(_id_949475D0823BC895 == level.wztrain_info._id_FE47FF8E697AD1D2[1])
    index = "_02";

  actors = [];
  animname = "accordion_front" + index;
  actors[animname] = getEnt("tram_front_accordion_model" + index, "script_noteworthy");
  actors[animname].animname = "accordion_front" + index;
  animname = "accordion_middle" + index;
  actors[animname] = getEnt("tram_middle_accordion_model" + index, "script_noteworthy");
  actors[animname].animname = "accordion_middle" + index;
  animname = "accordion_end" + index;
  actors[animname] = getEnt("tram_end_accordion_model" + index, "script_noteworthy");
  actors[animname].animname = "accordion_end" + index;
  _id_00CDD725F8F73B94 = _id_5FD79768B8941CFB::_id_FFD9B2FE58C97F7C(_id_776BAE99312943AE, _id_E26F44ACAD48DDD1);

  foreach(actor in actors) {
    actor scriptmodelplayanim(level.scr_anim[actor.animname]["gangway_loop"][0], undefined, _id_00CDD725F8F73B94, _id_07B60BC0EAB3FD1E);

    if(istrue(_id_801E1E61EBB9C5E3))
      actor scriptmodelpauseanim(1);
  }
}

_id_0ED3CE45AE9F6B34() {
  array = [];
  array[array.size] = "engine_TAG_ORIGIN_ANIMATE";
  array[array.size] = "gangway_01_TAG_ORIGIN_ANIMATE";
  array[array.size] = "cargo_hopper_TAG_ORIGIN_ANIMATE";
  array[array.size] = "gangway_02_TAG_ORIGIN_ANIMATE";
  array[array.size] = "tank_car_TAG_ORIGIN_ANIMATE";
  array[array.size] = "gangway_03_TAG_ORIGIN_ANIMATE";
  array[array.size] = "flatbed_TAG_ORIGIN_ANIMATE";
  return array;
}

_id_00E52CCB14A1AAE9() {
  return "veh9_civ_lnd_tram_eu";
}

_id_2AFE24EE912AB8A1() {
  return;
}

_id_3079813E25479249() {
  return;
}

_id_80BF76189FA2ACFE(train) {
  level endon("game_ended");
  level endon("obj_stop_train");
  anim_ref = level.scr_anim[level.wztrain_info._id_B2A3F9ABCEE9D071[train].animname][level.wztrain_info._id_0DDC55FBCFA86D44];

  for(;;) {
    level.wztrain_info.animstruct[train] thread scripts\common\anim::anim_single_solo(level.wztrain_info._id_B2A3F9ABCEE9D071[train], level.wztrain_info._id_0DDC55FBCFA86D44);
    level.wztrain_info._id_B2A3F9ABCEE9D071[train] setanimrate(anim_ref, level.wztrain_info._id_89F6C79D27DC03D6);

    if(!isDefined(level.wztrain_info._id_B2A3F9ABCEE9D071[train]._id_1DD4C3DF0FA6B022)) {
      level.wztrain_info._id_B2A3F9ABCEE9D071[train]._id_1DD4C3DF0FA6B022 = 1;
      time = getdvarfloat(_func_2EF675C13CA1C4AF("dvar_F4A0CE01AA2AD77D", train, "_position"), -1);

      if(time < 0)
        time = randomfloat(1);

      scripts\common\anim::anim_set_time_solo(level.wztrain_info._id_B2A3F9ABCEE9D071[train], level.wztrain_info._id_0DDC55FBCFA86D44, time);
    } else
      _id_8F743DE4CEDFDC2D(train, level.wztrain_info._id_89F6C79D27DC03D6);

    level.wztrain_info.animstruct[train] waittill(level.wztrain_info._id_0DDC55FBCFA86D44);
    _id_06AD4F9E2F4C6105::_id_E7A82D389007737B(train);
    _id_690A5A90EB6C809D(train);
    level.wztrain_info.animstruct[train] scripts\common\anim::anim_first_frame_solo(level.wztrain_info._id_B2A3F9ABCEE9D071[train], level.wztrain_info._id_0DDC55FBCFA86D44);
    _id_6981733D0D7F4088(train);
    waitframe();
    _id_06AD4F9E2F4C6105::_id_09DD6A5882C62DD6(train);
  }
}

_id_6981733D0D7F4088(train) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.wztrain_info._id_C3604781A9D33A7A[train].size; _id_AC0E594AC96AA3A8++) {
    _id_25650BF958716989 = level.wztrain_info.train_tag_array[_id_AC0E594AC96AA3A8];
    _id_4351410D12107DF3 = level.wztrain_info._id_B2A3F9ABCEE9D071[train] gettagorigin(_id_25650BF958716989);
    _id_37B788B5F5E40BAD = level.wztrain_info._id_B2A3F9ABCEE9D071[train] gettagangles(_id_25650BF958716989);

    if(istrue(level.wztrain_info._id_C3604781A9D33A7A[train][_id_AC0E594AC96AA3A8]._id_02E4045FFDF8A8F7))
      _id_37B788B5F5E40BAD = _id_06AD4F9E2F4C6105::_id_82B691DA7415DE2A(_id_37B788B5F5E40BAD);

    level.wztrain_info._id_C3604781A9D33A7A[train][_id_AC0E594AC96AA3A8].linked_model.origin = _id_4351410D12107DF3;
    level.wztrain_info._id_C3604781A9D33A7A[train][_id_AC0E594AC96AA3A8].linked_model.angles = _id_37B788B5F5E40BAD;
  }
}

_id_690A5A90EB6C809D(train) {
  _id_5120AF97971712C5 = level.wztrain_info._id_C3604781A9D33A7A[train][int(ceil(level.wztrain_info._id_C3604781A9D33A7A[train].size / 2))];
  _id_283114182F6E0E32 = getlootscriptablearrayinradius(undefined, undefined, _id_5120AF97971712C5.origin, 1000);

  if(isDefined(_id_283114182F6E0E32) && _id_283114182F6E0E32.size > 0) {
    foreach(child in _id_283114182F6E0E32) {
      if(isDefined(child.type) && child.type == "br_loot_cache_lege" || child.type == "br_loot_cache") {
        child freescriptable();
        continue;
      }

      if(!_id_7E52B56769FA7774::_id_2AE5E94BD6518AB5(child, 0)) {
        continue;
      }
      if(child getscriptableisreserved() && !isDefined(child.brpickupscriptableid)) {
        continue;
      }
      _id_7E52B56769FA7774::loothide(child);
    }
  }

  _id_06AD4F9E2F4C6105::_id_280CD7C412F05970(train);
}

_id_0A2438D9B587E9FA(_id_A94520D0BAFAED58) {
  switch (_id_A94520D0BAFAED58) {
    case "Cemetery":
      return "dx_br_bds4_tram_trma_graveyardstation";
    case "Market":
      return "dx_br_bds4_tram_trma_marketstation";
    case "Central Station":
      return "dx_br_bds4_tram_trma_centralstation";
    case "Mall":
      return "dx_br_bds4_tram_trma_shoppingcenterstatio";
    case "Castle":
      return "dx_br_bds4_tram_trma_castlestation";
    default:
      return undefined;
  }
}

_id_547FE7AB872AA777(alias) {
  _id_E9258CDB0E26BCFD = lookupsoundlength(alias) / 1000;
  self playsoundonmovingent(alias);
  wait(_id_E9258CDB0E26BCFD);
}

_id_3BAA47599DD64511(train, _id_A94520D0BAFAED58) {
  _id_36A9D5D53C42E2A0 = level.wztrain_info._id_C3604781A9D33A7A[train][0].linked_model;
  _id_36A9D5D53C42E2A0 playsoundonmovingent("veh_tramway_brake");

  if(level.wztrain_info._id_E43F441596208B11[train] == _id_A94520D0BAFAED58)
    level.wztrain_info._id_C3604781A9D33A7A[train][4].linked_model playsoundonmovingent("dx_br_bds4_tram_trma_fnls");
  else {
    _id_9F68776D7ADAE9B4 = _id_0A2438D9B587E9FA(_id_A94520D0BAFAED58);

    if(isDefined(_id_9F68776D7ADAE9B4)) {
      level.wztrain_info._id_C3604781A9D33A7A[train][4].linked_model _id_547FE7AB872AA777("dx_br_bds4_tram_trma_dstn");
      level.wztrain_info._id_C3604781A9D33A7A[train][4].linked_model _id_547FE7AB872AA777(_id_9F68776D7ADAE9B4);
    }

    level.wztrain_info._id_C3604781A9D33A7A[train][4].linked_model playsoundonmovingent("dx_br_bds4_tram_trma_pprc");
  }
}

_id_1256D82C90A0D4DC(train) {
  _id_A2695E54DD6FEF68 = level.wztrain_info._id_C3604781A9D33A7A[train][0].linked_model;
  _id_A2695E54DD6FEF68 playsoundonmovingent("veh_tramway_bell");
  level.wztrain_info._id_C3604781A9D33A7A[train][4] playsoundonmovingent("dx_br_bds4_tram_trma_lvng");
}

_id_11498702BEAFAA13(array) {
  return [(900, 46, 180), [array[0]]];
}

_id_8ADDA3156F592F31(_id_949475D0823BC895) {
  _id_776BAE99312943AE = level.wztrain_info._id_B2A3F9ABCEE9D071[_id_949475D0823BC895];
  _id_E26F44ACAD48DDD1 = level.scr_anim[_id_949475D0823BC895][level.wztrain_info._id_0DDC55FBCFA86D44];
  _id_DFB7FF3BEF234B0E = _id_776BAE99312943AE getanimtime(_id_E26F44ACAD48DDD1);
  _id_00CDD725F8F73B94 = getanimlength(_id_E26F44ACAD48DDD1) * _id_DFB7FF3BEF234B0E;
  return _id_00CDD725F8F73B94;
}

_id_17669CD4A286A10F(_id_A93234E28B698E6E, _id_E26F44ACAD48DDD1, _id_CE38E1F73463A7E5) {
  _id_8F743DE4CEDFDC2D(_id_A93234E28B698E6E.animname, _id_CE38E1F73463A7E5);
}

_id_8F743DE4CEDFDC2D(_id_949475D0823BC895, _id_CE38E1F73463A7E5) {
  _id_776BAE99312943AE = level.wztrain_info._id_B2A3F9ABCEE9D071[_id_949475D0823BC895];
  _id_E26F44ACAD48DDD1 = level.scr_anim[_id_949475D0823BC895][level.wztrain_info._id_0DDC55FBCFA86D44];
  _id_00CDD725F8F73B94 = _id_5FD79768B8941CFB::_id_FFD9B2FE58C97F7C(_id_776BAE99312943AE, _id_E26F44ACAD48DDD1);
  index = "";

  if(_id_949475D0823BC895 == level.wztrain_info._id_FE47FF8E697AD1D2[1])
    index = "_02";

  _id_8D9469A081D7CE05 = [];
  _id_8D9469A081D7CE05[0] = getEnt("tram_front_accordion_model" + index, "script_noteworthy");
  _id_8D9469A081D7CE05[1] = getEnt("tram_middle_accordion_model" + index, "script_noteworthy");
  _id_8D9469A081D7CE05[2] = getEnt("tram_end_accordion_model" + index, "script_noteworthy");
  _id_CE38E1F73463A7E5 = _func_C5CF558181E12D1F(_id_CE38E1F73463A7E5, 0.001);

  foreach(_id_75E4DDE050887492 in _id_8D9469A081D7CE05) {
    if(isDefined(_id_75E4DDE050887492) && isDefined(_id_75E4DDE050887492.animname))
      _id_75E4DDE050887492 scriptmodelplayanim(level.scr_anim[_id_75E4DDE050887492.animname]["gangway_loop"][0], undefined, _id_00CDD725F8F73B94, _id_CE38E1F73463A7E5);
  }
}

_id_A1AF09D5EDF7774B() {
  level endon("game_ended");
  level waittill("pause_reset_delta_movingtrain");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");

  foreach(train, array in level.wztrain_info._id_B2A3F9ABCEE9D071) {
    _id_B2A3F9ABCEE9D071 = level.wztrain_info._id_B2A3F9ABCEE9D071[train];
    _id_85DE4B2384EA1FE3 = level.wztrain_info._id_0DDC55FBCFA86D44;
    scripts\common\anim::anim_set_time_solo(_id_B2A3F9ABCEE9D071, _id_85DE4B2384EA1FE3, 0);
    _id_E26F44ACAD48DDD1 = level.scr_anim[train][_id_85DE4B2384EA1FE3];

    if(isarray(_id_E26F44ACAD48DDD1))
      _id_E26F44ACAD48DDD1 = level.scr_anim[train][_id_85DE4B2384EA1FE3][0];

    _id_5FD79768B8941CFB::_id_EE6AC63A2F326FE8(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, 0);
  }

  thread _id_A679A3E1AFF658B8();
}

_id_A679A3E1AFF658B8() {
  level endon("game_ended");

  for(;;) {
    level waittill("resume_delta_movingtrain", _id_7F853C287B0B8AF8);

    foreach(train, array in level.wztrain_info._id_B2A3F9ABCEE9D071) {
      if(train != _id_7F853C287B0B8AF8) {
        continue;
      }
      _id_B2A3F9ABCEE9D071 = level.wztrain_info._id_B2A3F9ABCEE9D071[train];
      _id_85DE4B2384EA1FE3 = level.wztrain_info._id_0DDC55FBCFA86D44;
      _id_E26F44ACAD48DDD1 = level.scr_anim[train][_id_85DE4B2384EA1FE3];

      if(isarray(_id_E26F44ACAD48DDD1))
        _id_E26F44ACAD48DDD1 = level.scr_anim[train][_id_85DE4B2384EA1FE3][0];

      _id_5FD79768B8941CFB::_id_EE6AC63A2F326FE8(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, level.wztrain_info._id_D935705DBBE8C4B7[train]);
    }
  }
}