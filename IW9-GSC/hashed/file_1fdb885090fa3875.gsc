/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1fdb885090fa3875.gsc
***********************************************/

_id_3AA305CAB5BF65C5() {
  if(!isDefined(level._id_A482AE70A62B5FB7))
    level._id_A482AE70A62B5FB7 = spawnStruct();

  if(!isDefined(level._id_39BC47CBD32AD77E))
    level._id_39BC47CBD32AD77E = spawnStruct();
}

_id_66E614363F4AAB26() {
  level notify("set_lua_render_stage");
  level endon("set_lua_render_stage");
  level endon("game_ended");

  while(!isDefined(level.seq3_computer_interaction))
    wait 0.1;

  _id_FC2201E3C98AE6F0 = level.seq3_computer_interaction;

  for(;;) {
    setomnvar("ui_raid_lua_render_stage", 2);
    level.seq3_computer_interaction waittill("on_exit");
    setomnvar("ui_raid_lua_render_stage", 0);
    wait 0.1;
  }
}

code_generation_init(_id_C7AD0829E4DCED81) {
  level._id_B54CC012D53DB80F = [];
  level.seq3_sequences_correct = 0;
  level.f14_current_inputseq = "";
  level.f14_current_inputamt = 0;
  level decide_new_code(_id_C7AD0829E4DCED81);
}

decide_new_code(_id_C7AD0829E4DCED81) {
  level.seq3_numbers_array = [];

  if(isDefined(game["numspuzzle_cypher"]) && isarray(game["numspuzzle_cypher"]))
    level.seq3_numbers_array = game["numspuzzle_cypher"];
  else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C7AD0829E4DCED81; _id_AC0E594AC96AA3A8++)
      level.seq3_numbers_array[level.seq3_numbers_array.size] = _id_AE67FCE07AB72D9B(level.seq3_numbers_array.size);
  }

  level.seq3_tvnums_str = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.seq3_numbers_array.size; _id_AC0E594AC96AA3A8++) {
    level.seq3_tvnums_str = level.seq3_tvnums_str + level.seq3_numbers_array[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 < level.seq3_numbers_array.size - 1)
      level.seq3_tvnums_str = level.seq3_tvnums_str + " ";
  }
}

_id_AE67FCE07AB72D9B(index) {
  number = randomintrange(0, 10);

  if(istrue(level._id_DF2F5CF1D779EA0C) && !isDefined(level._id_652FAE1F578FF1ED)) {
    if(index == 0 && number == 6) {
      number = randomintrange(0, 6);
      level._id_652FAE1F578FF1ED = 1;
    } else if(index == 1 && number == 2) {
      number = randomintrange(3, 10);
      level._id_652FAE1F578FF1ED = 1;
    } else if(index == 2 && number == 7) {
      number = randomintrange(0, 7);
      level._id_652FAE1F578FF1ED = 1;
    }
  }

  return number;
}

spawn_new_digits(_id_0E5D9616E3B68467, _id_0E2DC2B491C83D4A) {
  level endon("seq3_puzzle_complete");
  level endon("seq3_tier_increase");
  _id_03B56DBD6CCA0199 = [];
  _id_15E00FD56DB9BEA7 = [];
  _id_C318DA7ECE29EFDA = scripts\engine\utility::getStruct(_id_0E2DC2B491C83D4A, "targetname");
  _id_E1C41CA2B9D728D7 = scripts\engine\utility::getStructArray(_id_C318DA7ECE29EFDA.target, "targetname");
  _id_F79F62C206945457 = 2;
  level spawn_fake_digit_pool();
  level generate_cypher();
  _id_2F05FDC372F83530 = undefined;
  _id_DC1BDEF4CBDB2B41 = undefined;
  _id_DC1BDEF4CBDB2B41 = _id_0E5D9616E3B68467 * 3;
  _id_2F05FDC372F83530 = _id_DC1BDEF4CBDB2B41 - 3;
  _id_D6CADDEE028D7399 = 0;

  foreach(_id_E3AADCD86DCBFCFF in _id_E1C41CA2B9D728D7) {
    _id_73919C2FB20446BE = scripts\engine\utility::getStructArray(_id_E3AADCD86DCBFCFF.target, "targetname");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F79F62C206945457; _id_AC0E594AC96AA3A8++) {
      _id_730B1048F3DC7F78 = scripts\engine\utility::random(_id_73919C2FB20446BE);
      _id_15E00FD56DB9BEA7[_id_15E00FD56DB9BEA7.size] = _id_730B1048F3DC7F78;
      _id_73919C2FB20446BE = scripts\engine\utility::array_remove(_id_73919C2FB20446BE, _id_730B1048F3DC7F78);
      _id_03B56DBD6CCA0199 = scripts\engine\utility::array_remove(_id_03B56DBD6CCA0199, _id_730B1048F3DC7F78);
    }
  }

  _id_16073F4AF775B3E3 = [];

  for(_id_AC0E594AC96AA3A8 = _id_2F05FDC372F83530; _id_AC0E594AC96AA3A8 < _id_DC1BDEF4CBDB2B41; _id_AC0E594AC96AA3A8++)
    _id_16073F4AF775B3E3[_id_16073F4AF775B3E3.size] = level.seq3_numbers_array[_id_AC0E594AC96AA3A8];

  _id_16073F4AF775B3E3 = scripts\engine\utility::array_reverse(_id_16073F4AF775B3E3);
  _id_EA94F939F9A18AAA = _id_16073F4AF775B3E3;
  level._id_9266C4815583ABBC = [];
  level._id_B9129C33BC8EF723 = [];
  level._id_604FC16B1C2315EC = [];
  _id_C31C30C7D7765F29 = [];
  _id_3CB1B4AC0A7A45A2 = _id_A789DC462527EC03();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++)
    _id_C31C30C7D7765F29[_id_C31C30C7D7765F29.size] = _id_15E00FD56DB9BEA7[_id_3CB1B4AC0A7A45A2[_id_AC0E594AC96AA3A8]];

  level._id_D7C04050937720E2 = _id_C31C30C7D7765F29;

  for(_id_AC0E594AC96AA3A8 = _id_2F05FDC372F83530; _id_AC0E594AC96AA3A8 < _id_DC1BDEF4CBDB2B41; _id_AC0E594AC96AA3A8++) {
    script_reuse = undefined;
    _id_F9E405B02AEA71E6 = _id_C31C30C7D7765F29[_id_C31C30C7D7765F29.size - 1];
    _id_C31C30C7D7765F29 = scripts\engine\utility::_id_57091B2D67654A14(_id_C31C30C7D7765F29, _id_F9E405B02AEA71E6);

    foreach(_id_678415361620B657 in _id_C31C30C7D7765F29) {
      if(_id_F9E405B02AEA71E6 == _id_678415361620B657)
        script_reuse = 1;
    }

    if(!isDefined(_id_F9E405B02AEA71E6)) {
      waitframe();
      continue;
    }

    if(getdvarint("dvar_E5FF339404A00266", 1))
      _id_611943380115EBDA = _id_16073F4AF775B3E3[_id_D6CADDEE028D7399];
    else
      _id_611943380115EBDA = get_random_notnegative(_id_16073F4AF775B3E3);

    _id_F3929FB814473B4F = scripts\engine\utility::array_find(_id_16073F4AF775B3E3, _id_611943380115EBDA);
    _id_16073F4AF775B3E3[_id_F3929FB814473B4F] = -1;

    if(!isDefined(_id_F9E405B02AEA71E6))
      iprintln("tank to use undefined!");

    check_digit_models_to_create(_id_F9E405B02AEA71E6, _id_F3929FB814473B4F, _id_611943380115EBDA, _id_D6CADDEE028D7399, script_reuse);
    _id_D6CADDEE028D7399++;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_15E00FD56DB9BEA7.size; _id_AC0E594AC96AA3A8++)
    level thread _id_D881CBE296B54766(_id_15E00FD56DB9BEA7[_id_AC0E594AC96AA3A8]);

  level thread _id_1F4EB1E3F6335E63();
}

check_digit_models_to_create(_id_A7FCF939FD52A718, _id_F3929FB814473B4F, _id_BAA48B33AD7255C4, _id_D6CADDEE028D7399, script_reuse) {
  _id_3D938A1343D65FED = scripts\engine\utility::getStructArray(_id_A7FCF939FD52A718.target, "targetname");
  _id_B9E5326D8602D248 = undefined;
  _id_F11CF939BBEE5B63 = undefined;
  _id_5E8239601DB6B8D7 = spawnStruct();
  _id_5E8239601DB6B8D7.letters = "";
  _id_5E8239601DB6B8D7.numbers = "";

  foreach(_id_1107A5CB5EE7F76F in _id_3D938A1343D65FED) {
    _id_BAB1A3C4EBA33C1B = 0;
    _id_3ADB83F41DBBBE7A = int(_id_1107A5CB5EE7F76F.script_noteworthy) - 1;

    if(_id_3ADB83F41DBBBE7A == _id_F3929FB814473B4F) {
      _id_BAB1A3C4EBA33C1B = 1;
      _id_F11CF939BBEE5B63 = 1;
      level._id_9266C4815583ABBC[level._id_9266C4815583ABBC.size] = _id_1107A5CB5EE7F76F;
    }

    create_digit_models(_id_BAB1A3C4EBA33C1B, _id_BAA48B33AD7255C4, _id_1107A5CB5EE7F76F, _id_D6CADDEE028D7399, _id_5E8239601DB6B8D7, script_reuse, _id_F3929FB814473B4F);
  }

  if(!isDefined(level._id_1A1B1DCA4866334F))
    level._id_1A1B1DCA4866334F = 0;

  _id_A7FCF939FD52A718.omvar_code = undefined;

  if(_id_5E8239601DB6B8D7.numbers == "" || _id_5E8239601DB6B8D7.letters == "") {}

  _id_6F221C71485DB31A = 0;
  _id_D9C655EE55B97371 = _id_014F751C2EB27256(_id_5E8239601DB6B8D7.numbers);

  foreach(_id_B5517D24E9DC9A49 in _id_D9C655EE55B97371) {
    if(_id_B5517D24E9DC9A49 == "x") {
      _id_6F221C71485DB31A = 1;
      break;
    }
  }

  if(_id_6F221C71485DB31A) {
    _id_6A40A854E6BD4624 = undefined;
    _id_13C5849E329C894D = undefined;
    _id_C9EA2FC0AD1913F6 = undefined;

    if(isDefined(level._id_B9129C33BC8EF723[_id_A7FCF939FD52A718.target])) {
      _id_6A40A854E6BD4624 = level._id_B9129C33BC8EF723[_id_A7FCF939FD52A718.target];
      _id_13C5849E329C894D = level._id_8E8B6ECFD4AA7E42[_id_A7FCF939FD52A718.target];
      _id_C9EA2FC0AD1913F6 = level._id_5D456ADD07AFC92D[_id_A7FCF939FD52A718.target];
    }

    if(!isDefined(_id_6A40A854E6BD4624)) {
      return;
    }
    _id_390FB0FBAD2ED55D = _id_014F751C2EB27256(_id_5E8239601DB6B8D7.numbers);
    _id_40094CAB5FEB2F18 = _id_014F751C2EB27256(_id_5E8239601DB6B8D7.letters);
    _id_DE9D082EE935BC60 = _id_014F751C2EB27256(_id_13C5849E329C894D);
    _id_212BDC71FB362D49 = _id_014F751C2EB27256(_id_C9EA2FC0AD1913F6);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_390FB0FBAD2ED55D.size; _id_AC0E594AC96AA3A8++) {
      if(_id_390FB0FBAD2ED55D[_id_AC0E594AC96AA3A8] == "x")
        _id_390FB0FBAD2ED55D[_id_AC0E594AC96AA3A8] = _id_DE9D082EE935BC60[_id_AC0E594AC96AA3A8];
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_40094CAB5FEB2F18.size; _id_AC0E594AC96AA3A8++) {
      if(_id_40094CAB5FEB2F18[_id_AC0E594AC96AA3A8] == "x") {
        _id_40094CAB5FEB2F18[_id_AC0E594AC96AA3A8] = _id_212BDC71FB362D49[_id_AC0E594AC96AA3A8];
        _id_40094CAB5FEB2F18[_id_AC0E594AC96AA3A8 + 1] = _id_212BDC71FB362D49[_id_AC0E594AC96AA3A8 + 1];
      }
    }

    _id_A7FCF939FD52A718._id_390FB0FBAD2ED55D = _id_390FB0FBAD2ED55D;
    _id_A7FCF939FD52A718._id_40094CAB5FEB2F18 = _id_40094CAB5FEB2F18;
    _id_113DBAF87B003DE8 = _id_D10DDF04E1E01FFA(_id_390FB0FBAD2ED55D);
    _id_CD992DA55C342583 = _id_D10DDF04E1E01FFA(_id_40094CAB5FEB2F18);
    _id_A7FCF939FD52A718.omvar_code = int(_id_CD992DA55C342583 + _id_113DBAF87B003DE8);
  } else {
    _id_A7FCF939FD52A718.omvar_code = int(_id_5E8239601DB6B8D7.letters + _id_5E8239601DB6B8D7.numbers);
    level._id_B9129C33BC8EF723[_id_A7FCF939FD52A718.target] = _id_A7FCF939FD52A718.omvar_code;
    level._id_8E8B6ECFD4AA7E42[_id_A7FCF939FD52A718.target] = _id_5E8239601DB6B8D7.numbers;
    level._id_5D456ADD07AFC92D[_id_A7FCF939FD52A718.target] = _id_5E8239601DB6B8D7.letters;
    _id_A7FCF939FD52A718._id_390FB0FBAD2ED55D = _id_5E8239601DB6B8D7.numbers;
    _id_A7FCF939FD52A718._id_40094CAB5FEB2F18 = _id_5E8239601DB6B8D7.letters;
  }

  if(isDefined(_id_A7FCF939FD52A718.omvar_code))
    level._id_604FC16B1C2315EC[_id_A7FCF939FD52A718.target] = _id_A7FCF939FD52A718.omvar_code;

  level._id_1A1B1DCA4866334F = gettime();

  if(!isDefined(_id_F11CF939BBEE5B63))
    announcement("Dev Error: Digit undefined..?");
}

_id_1F4EB1E3F6335E63() {
  level notify("nums_display_tv_omnvars");
  level endon("nums_display_tv_omnvars");
  level endon("nums_wipe_tv_omnvars");
  level endon("game_ended");
  _id_499E551F45E15B10 = 111111111;

  for(;;) {
    foreach(target, omvar_code in level._id_604FC16B1C2315EC) {
      switch (target) {
        case "maze_tutorialpuzzle_tv_numbers7":
        case "f14_tv_numbers7":
          setomnvar("ui_raid_number_screen_a", omvar_code);
          break;
        case "f14_tv_numbers9":
        case "maze_tutorialpuzzle_tv_numbers9":
          setomnvar("ui_raid_number_screen_b", omvar_code);
          break;
        case "f14_tv_numbers6":
        case "maze_tutorialpuzzle_tv_numbers6":
          setomnvar("ui_raid_number_screen_c", omvar_code);
          break;
      }
    }

    wait 3;
    setomnvar("ui_raid_number_screen_a", _id_499E551F45E15B10);
    setomnvar("ui_raid_number_screen_b", _id_499E551F45E15B10);
    setomnvar("ui_raid_number_screen_c", _id_499E551F45E15B10);
    wait 0.05;
  }
}

_id_014F751C2EB27256(string) {
  _id_B969D7C313C1E5C0 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < string.size; _id_AC0E594AC96AA3A8++)
    _id_B969D7C313C1E5C0[_id_B969D7C313C1E5C0.size] = string[_id_AC0E594AC96AA3A8];

  return _id_B969D7C313C1E5C0;
}

_id_D10DDF04E1E01FFA(array) {
  str = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++)
    str = str + array[_id_AC0E594AC96AA3A8];

  return str;
}

create_digit_models(_id_BAB1A3C4EBA33C1B, _id_BAA48B33AD7255C4, _id_1107A5CB5EE7F76F, _id_D6CADDEE028D7399, _id_5E8239601DB6B8D7, script_reuse, _id_F3929FB814473B4F) {
  if(_id_BAB1A3C4EBA33C1B) {
    spawn_real_number(_id_1107A5CB5EE7F76F, _id_BAA48B33AD7255C4, _id_5E8239601DB6B8D7);
    spawn_real_letter(_id_1107A5CB5EE7F76F, _id_D6CADDEE028D7399, _id_5E8239601DB6B8D7);
    _id_1107A5CB5EE7F76F.script_index = 1;
  } else {
    if(isDefined(scripts\engine\utility::array_find(level._id_9266C4815583ABBC, _id_1107A5CB5EE7F76F))) {
      _id_5E8239601DB6B8D7.numbers = _id_5E8239601DB6B8D7.numbers + "x";
      _id_5E8239601DB6B8D7.letters = _id_5E8239601DB6B8D7.letters + "xx";
      return;
    }

    spawn_fake_number(_id_1107A5CB5EE7F76F, _id_5E8239601DB6B8D7);
    spawn_fake_letter(_id_1107A5CB5EE7F76F, _id_5E8239601DB6B8D7);
  }
}

spawn_real_number(_id_1107A5CB5EE7F76F, _id_BAA48B33AD7255C4, _id_5E8239601DB6B8D7) {
  _id_5E8239601DB6B8D7.numbers = _id_5E8239601DB6B8D7.numbers + _id_BAA48B33AD7255C4;
}

spawn_real_letter(_id_1107A5CB5EE7F76F, _id_D6CADDEE028D7399, _id_5E8239601DB6B8D7) {
  _id_D3EDD8AF8F2EC6DF = level.genuine_cypher_pieces[_id_D6CADDEE028D7399].id;
  _id_C6C9DF6F590356B9 = get_russian_code_from_id(_id_D3EDD8AF8F2EC6DF);
  _id_5E8239601DB6B8D7.letters = _id_5E8239601DB6B8D7.letters + _id_C6C9DF6F590356B9;
}

spawn_fake_number(_id_1107A5CB5EE7F76F, _id_5E8239601DB6B8D7) {
  _id_90D2C8713D266243 = get_fake_digit_from_pool();
  _id_5E8239601DB6B8D7.numbers = _id_5E8239601DB6B8D7.numbers + _id_90D2C8713D266243;
}

spawn_fake_letter(_id_1107A5CB5EE7F76F, _id_5E8239601DB6B8D7) {
  _id_66D580A6CAB94132 = get_random_leftover_letter();
  _id_C6C9DF6F590356B9 = get_russian_code_from_id(_id_66D580A6CAB94132);
  _id_5E8239601DB6B8D7.letters = _id_5E8239601DB6B8D7.letters + _id_C6C9DF6F590356B9;
}

spawn_fake_digit_pool() {
  level.fake_digit_pool = ["0", "0", "1", "1", "2", "2", "3", "3", "4", "4", "5", "5", "6", "6", "7", "7", "8", "8", "9", "9"];
}

get_fake_digit_from_pool() {
  num = scripts\engine\utility::random(level.fake_digit_pool);
  level.fake_digit_pool = scripts\engine\utility::array_remove(level.fake_digit_pool, num);
  return num;
}

get_random_notnegative(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(index, value in array) {
    if(value >= 0)
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = value;
  }

  if(!_id_BFC65A378A6D8EFE.size)
    return undefined;

  return _id_BFC65A378A6D8EFE[randomint(_id_BFC65A378A6D8EFE.size)];
}

_id_A789DC462527EC03() {
  _id_F516275B0AE78AA3 = [];
  _id_F516275B0AE78AA3[0] = [0, 0, 1];
  _id_F516275B0AE78AA3[1] = [0, 1, 1];
  _id_F516275B0AE78AA3[2] = [0, 1, 0];
  _id_F516275B0AE78AA3[3] = [1, 0, 1];
  _id_F516275B0AE78AA3[4] = [1, 0, 0];
  _id_F516275B0AE78AA3[5] = [1, 1, 0];

  if(isDefined(level._id_0A9B35B13E2039A8))
    _id_F516275B0AE78AA3 = scripts\engine\utility::array_remove_index(_id_F516275B0AE78AA3, level._id_0A9B35B13E2039A8);

  _id_BA5E28746B76CCED = scripts\engine\utility::random(_id_F516275B0AE78AA3);
  level._id_0A9B35B13E2039A8 = _id_87774657326D4811(_id_F516275B0AE78AA3, _id_BA5E28746B76CCED);
  return _id_BA5E28746B76CCED;
}

_id_87774657326D4811(array, item) {
  foreach(_id_FE8F7703F6313ED4, test in array) {
    if(scripts\cp\utility::array_compare(test, item))
      return _id_FE8F7703F6313ED4;
  }

  return undefined;
}

_id_D881CBE296B54766(_id_A7FCF939FD52A718) {
  level notify("play_tvscreen_phonetics_loop_" + _id_A7FCF939FD52A718.target);
  level endon("play_tvscreen_phonetics_loop_" + _id_A7FCF939FD52A718.target);
  level endon("stop_tvscreen_phonetics_loop");
  letters = _id_A7FCF939FD52A718._id_40094CAB5FEB2F18;
  numbers = _id_A7FCF939FD52A718._id_390FB0FBAD2ED55D;

  for(;;) {
    level thread scripts\cp\utility::playsoundatpos_safe(_id_A7FCF939FD52A718.origin, "cp_raid_number_screen");
    wait 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < letters.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
      _id_A6C471744E0FBCA7 = letters[_id_AC0E594AC96AA3A8] + letters[_id_AC0E594AC96AA3A8 + 1];

      if(_id_A6C471744E0FBCA7 == "xx") {
        continue;
      }
      _id_B701EE6ED1EC9567 = _id_14E9092ECC420654(_id_A6C471744E0FBCA7);
      _id_D593084420B73526 = _id_C9D8C4DBC036BEAC(_id_B701EE6ED1EC9567);
      level thread scripts\cp\utility::playsoundatpos_safe(_id_A7FCF939FD52A718.origin, _id_D593084420B73526);
      wait 1.25;
    }

    wait 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numbers.size; _id_AC0E594AC96AA3A8++) {
      if(numbers[_id_AC0E594AC96AA3A8] == "x") {
        continue;
      }
      _id_08F46AD208419BE2 = _id_F3A7EE5F80D15B7B(numbers[_id_AC0E594AC96AA3A8]);
      level thread scripts\cp\utility::playsoundatpos_safe(_id_A7FCF939FD52A718.origin, _id_08F46AD208419BE2);
      wait 1.25;
    }

    wait 8;
  }
}

generate_cypher() {
  level _id_2F6B872D8EDCD891();
  level.current_cypher_pieces = [];
  level.genuine_cypher_pieces = [];
  level.cypher_current_string = "";
  amount = 5;

  if(isDefined(level._id_39BC47CBD32AD77E) && isDefined(level._id_39BC47CBD32AD77E._id_585A623B71645E3E))
    amount = level._id_39BC47CBD32AD77E._id_585A623B71645E3E;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++)
    level.current_cypher_pieces[level.current_cypher_pieces.size] = create_cypher_piece(_id_AC0E594AC96AA3A8);

  if(getdvarint("dvar_0E7124A2537D4D77", 0) > 0)
    level.current_cypher_pieces = scripts\engine\utility::array_randomize(level.current_cypher_pieces);
  else {
    _id_7865BF3E1654317A = [];
    _id_3F2AF98A990AF049 = [];

    if(amount == 5)
      _id_3F2AF98A990AF049 = [999, 998, 997, 996, 995];
    else if(amount == 4)
      _id_3F2AF98A990AF049 = [999, 998, 997, 996];
    else if(amount == 3)
      _id_3F2AF98A990AF049 = [999, 998, 997];

    if(amount > 3) {
      _id_5D842394FD6D6D53 = level.current_cypher_pieces[3];
      _id_0358C345A854F7ED = get_random_notnegative(_id_3F2AF98A990AF049);
      _id_377CEF04394B7B74 = scripts\engine\utility::array_find(_id_3F2AF98A990AF049, _id_0358C345A854F7ED);
      _id_3F2AF98A990AF049[_id_377CEF04394B7B74] = -1;
      _id_7865BF3E1654317A[_id_377CEF04394B7B74] = _id_5D842394FD6D6D53;
    }

    if(amount > 4) {
      _id_5D842494FD6D6F86 = level.current_cypher_pieces[4];
      _id_0358C045A854F154 = get_random_notnegative(_id_3F2AF98A990AF049);
      _id_377CF204394B820D = scripts\engine\utility::array_find(_id_3F2AF98A990AF049, _id_0358C045A854F154);
      _id_3F2AF98A990AF049[_id_377CF204394B820D] = -1;
      _id_7865BF3E1654317A[_id_377CF204394B820D] = _id_5D842494FD6D6F86;
    }

    _id_DEC730F8C089DD98 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3F2AF98A990AF049.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(_id_7865BF3E1654317A[_id_AC0E594AC96AA3A8])) {
        _id_7865BF3E1654317A[_id_AC0E594AC96AA3A8] = level.current_cypher_pieces[_id_DEC730F8C089DD98];
        _id_DEC730F8C089DD98++;
      }
    }

    level.current_cypher_pieces = _id_7865BF3E1654317A;
  }

  level._id_4EDA56F01BD0A60C = level.cypher_id_pool;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.current_cypher_pieces.size; _id_AC0E594AC96AA3A8++) {
    if(level.current_cypher_pieces[_id_AC0E594AC96AA3A8].key_position > 0)
      level.genuine_cypher_pieces[level.genuine_cypher_pieces.size] = level.current_cypher_pieces[_id_AC0E594AC96AA3A8];
  }

  if(getdvarint("dvar_E5FF339404A00266", 1))
    level.current_cypher_pieces = scripts\engine\utility::array_reverse(level.current_cypher_pieces);

  level thread display_cypher_updated();
}

_id_2F6B872D8EDCD891() {
  level.cypher_id_pool = [];

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8() || istrue(level._id_39BC47CBD32AD77E._id_D70191A61212EAD1))
    level.cypher_id_pool = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  else
    level.cypher_id_pool = ["a", "b", "c", "e", "f", "g", "i", "j", "k", "l", "o", "p", "q", "r", "s", "t", "w", "y", "z"];

  level.cypher_id_pool = scripts\engine\utility::array_randomize(level.cypher_id_pool);
}

_id_CFFCFA6B87EBBDF1() {
  level.cypher_id_pool = level._id_4EDA56F01BD0A60C;
}

create_cypher_piece(_id_23D7464725761BD0) {
  _id_2AFACC2AEBEB1673 = spawnStruct();
  _id_2AFACC2AEBEB1673.id = get_next_cypher_id_from_pool();

  if(_id_23D7464725761BD0 <= 2)
    _id_2AFACC2AEBEB1673.key_position = _id_23D7464725761BD0 + 1;
  else
    _id_2AFACC2AEBEB1673.key_position = 0;

  _id_2AFACC2AEBEB1673.times_used = 0;
  _id_2AFACC2AEBEB1673.times_in_a = 0;
  _id_2AFACC2AEBEB1673.times_in_b = 0;
  _id_2AFACC2AEBEB1673.times_in_c = 0;
  _id_2AFACC2AEBEB1673.tv_model = "";
  _id_2AFACC2AEBEB1673.verbal_string = _id_C9D8C4DBC036BEAC(_id_2AFACC2AEBEB1673.id);
  _id_2AFACC2AEBEB1673.russianletter = get_russian_code_from_id(_id_2AFACC2AEBEB1673.id);
  _id_2AFACC2AEBEB1673.verbal_clip = "";
  return _id_2AFACC2AEBEB1673;
}

get_next_cypher_id_from_pool() {
  id = level.cypher_id_pool[level.cypher_id_pool.size - 1];
  level.cypher_id_pool = scripts\engine\utility::array_remove(level.cypher_id_pool, id);
  return id;
}

get_russian_code_from_id(input) {
  id = undefined;

  switch (input) {
    case "a":
      id = 11;
      break;
    case "b":
      id = 12;
      break;
    case "c":
      id = 13;
      break;
    case "d":
      id = 14;
      break;
    case "e":
      id = 15;
      break;
    case "f":
      id = 16;
      break;
    case "g":
      id = 17;
      break;
    case "h":
      id = 18;
      break;
    case "i":
      id = 19;
      break;
    case "j":
      id = 20;
      break;
    case "k":
      id = 21;
      break;
    case "l":
      id = 22;
      break;
    case "m":
      id = 23;
      break;
    case "n":
      id = 24;
      break;
    case "o":
      id = 25;
      break;
    case "p":
      id = 26;
      break;
    case "q":
      id = 27;
      break;
    case "r":
      id = 28;
      break;
    case "s":
      id = 29;
      break;
    case "t":
      id = 30;
      break;
    case "u":
      id = 31;
      break;
    case "v":
      id = 32;
      break;
    case "w":
      id = 33;
      break;
    case "x":
      id = 34;
      break;
    case "y":
      id = 35;
      break;
    case "z":
      id = 36;
      break;
  }

  return id;
}

_id_14E9092ECC420654(input) {
  id = undefined;
  input = int(input);

  switch (input) {
    case 11:
      id = "a";
      break;
    case 12:
      id = "b";
      break;
    case 13:
      id = "c";
      break;
    case 14:
      id = "d";
      break;
    case 15:
      id = "e";
      break;
    case 16:
      id = "f";
      break;
    case 17:
      id = "g";
      break;
    case 18:
      id = "h";
      break;
    case 19:
      id = "i";
      break;
    case 20:
      id = "j";
      break;
    case 21:
      id = "k";
      break;
    case 22:
      id = "l";
      break;
    case 23:
      id = "m";
      break;
    case 24:
      id = "n";
      break;
    case 25:
      id = "o";
      break;
    case 26:
      id = "p";
      break;
    case 27:
      id = "q";
      break;
    case 28:
      id = "r";
      break;
    case 29:
      id = "s";
      break;
    case 30:
      id = "t";
      break;
    case 31:
      id = "u";
      break;
    case 32:
      id = "v";
      break;
    case 33:
      id = "w";
      break;
    case 34:
      id = "x";
      break;
    case 35:
      id = "y";
      break;
    case 36:
      id = "z";
      break;
  }

  return id;
}

_id_C9D8C4DBC036BEAC(input) {
  alias = undefined;

  switch (input) {
    case "a":
      alias = "dx_cp_cpr1_intr_rupa_anna";
      break;
    case "b":
      alias = "dx_cp_cpr1_intr_rupa_boris";
      break;
    case "c":
      alias = "dx_cp_cpr1_intr_rupa_vasily";
      break;
    case "d":
      alias = "dx_cp_cpr1_intr_rupa_gregory";
      break;
    case "e":
      alias = "dx_cp_cpr1_intr_rupa_dimitri";
      break;
    case "f":
      alias = "dx_cp_cpr1_intr_rupa_yelena";
      break;
    case "g":
      alias = "dx_cp_cpr1_intr_rupa_shenya";
      break;
    case "h":
      alias = "dx_cp_cpr1_intr_rupa_zinaida";
      break;
    case "i":
      alias = "dx_cp_cpr1_intr_rupa_ivan";
      break;
    case "j":
      alias = "dx_cp_cpr1_intr_rupa_konstantin";
      break;
    case "k":
      alias = "dx_cp_cpr1_intr_rupa_mikhail";
      break;
    case "l":
      alias = "dx_cp_cpr1_intr_rupa_nikolai";
      break;
    case "m":
      alias = "dx_cp_cpr1_intr_rupa_oleksiv";
      break;
    case "n":
      alias = "dx_cp_cpr1_intr_rupa_pavel";
      break;
    case "o":
      alias = "dx_cp_cpr1_intr_rupa_roman";
      break;
    case "p":
      alias = "dx_cp_cpr1_intr_rupa_semyon";
      break;
    case "q":
      alias = "dx_cp_cpr1_intr_rupa_tatyana";
      break;
    case "r":
      alias = "dx_cp_cpr1_intr_rupa_ulyana";
      break;
    case "s":
      alias = "dx_cp_cpr1_intr_rupa_fyodor";
      break;
    case "t":
      alias = "dx_cp_cpr1_intr_rupa_khariton";
      break;
    case "u":
      alias = "dx_cp_cpr1_intr_rupa_saplya";
      break;
    case "v":
      alias = "dx_cp_cpr1_intr_rupa_chelovyek";
      break;
    case "w":
      alias = "dx_cp_cpr1_intr_rupa_shura";
      break;
    case "x":
      alias = "dx_cp_cpr1_intr_rupa_echo";
      break;
    case "y":
      alias = "dx_cp_cpr1_intr_rupa_yuri";
      break;
    case "z":
      alias = "dx_cp_cpr1_intr_rupa_yakov";
      break;
  }

  return alias;
}

get_random_leftover_letter() {
  _id_783809DA65285CB1 = scripts\engine\utility::random(level.cypher_id_pool);
  level.cypher_id_pool = scripts\engine\utility::array_remove(level.cypher_id_pool, _id_783809DA65285CB1);
  return _id_783809DA65285CB1;
}

display_current_cypher_to_player(player) {
  if(isDefined(level.cypher_current_string) && isalive(player))
    player iprintlnbold("^3" + level.cypher_current_string);
}

_id_B31193550E9AF2FA() {
  if(!isDefined(level.seq3_cypher_tagorigin)) {
    struct = scripts\engine\utility::getStruct("cypher_location", "targetname");
    level.seq3_cypher_tagorigin = scripts\engine\utility::spawn_tag_origin(struct.origin, struct.angles);
    level.seq3_cypher_tagorigin show();
  }
}

display_cypher_updated() {
  level thread clear_cypher_icon();
  level notify("update_cypher_display");
  level endon("update_cypher_display");
  level endon("game_ended");
  level endon("exit_sequence_early");
  _id_B31193550E9AF2FA();
  level.seq3_cypher_tagorigin playSound("cp_raid_cypher_new_code");
  level.seq3_cypher_tagorigin thread _id_DA9AD0759AB668C8();
  _id_EC0B0A23B0E932A9 = level.current_cypher_pieces[0].russianletter;
  _id_EC0B0723B0E92C10 = level.current_cypher_pieces[1].russianletter;
  _id_EC0B0823B0E92E43 = level.current_cypher_pieces[2].russianletter;
  _id_B2367CC4BAFF8AF4 = int("" + _id_EC0B0A23B0E932A9 + _id_EC0B0723B0E92C10 + _id_EC0B0823B0E92E43);
  _id_EC0B0D23B0E93942 = 37;

  if(level.current_cypher_pieces.size > 3 && isDefined(level.current_cypher_pieces[3]))
    _id_EC0B0D23B0E93942 = level.current_cypher_pieces[3].russianletter;

  _id_EC0B0E23B0E93B75 = 37;

  if(level.current_cypher_pieces.size > 4 && isDefined(level.current_cypher_pieces[4]))
    _id_EC0B0E23B0E93B75 = level.current_cypher_pieces[4].russianletter;

  _id_B2367FC4BAFF918D = int("" + _id_EC0B0D23B0E93942 + _id_EC0B0E23B0E93B75);
  level.seq3_russian_cypher_str = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.current_cypher_pieces.size; _id_AC0E594AC96AA3A8++) {
    level.seq3_russian_cypher_str = level.seq3_russian_cypher_str + level.current_cypher_pieces[_id_AC0E594AC96AA3A8].id;
    level.seq3_russian_cypher_str = level.seq3_russian_cypher_str + " ";
  }

  setomnvar("ui_raid_number_russian_chars_1_3", _id_B2367CC4BAFF8AF4);
  setomnvar("ui_raid_number_russian_chars_4_5", _id_B2367FC4BAFF918D);
}

clear_cypher_icon() {
  level notify("nums_wipe_tv_omnvars");
  setomnvar("ui_raid_number_russian_chars_1_3", 0);
  setomnvar("ui_raid_number_russian_chars_4_5", 0);
  setomnvar("ui_raid_number_screen_a", 0);
  setomnvar("ui_raid_number_screen_b", 0);
  setomnvar("ui_raid_number_screen_c", 0);

  if(isDefined(level.cypher_iconid)) {
    deleteheadicon(level.cypher_iconid);
    level.cypher_iconid = undefined;
  }
}

_id_CCCB426B669C407C(_id_027B0DBDC7C692C9) {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  level endon("maze_numstutorial_complete");
  org = spawn("script_origin", (0, 0, 0));
  org.origin = _id_027B0DBDC7C692C9;
  org thread _id_AF874855B6AC35F1("cp_raid_cypher_radio_lp");

  for(;;) {
    org playSound("cp_raid_cypher_radio_start");
    org thread _id_234D4370263F3103(1.5, "cp_raid_cypher_radio_lp");
    level waittill("radio_power_off");
    org playSound("cp_raid_cypher_radio_end");
    org stoploopsound("cp_raid_cypher_radio_lp");
    level waittill("radio_power_on");
  }
}

_id_A0B2561CEDE911A2(_id_648F53CBD8BE4D47) {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  level endon("maze_numstutorial_complete");

  if(isDefined(level._id_BABA3A84DFB95860)) {
    return;
  }
  level._id_BABA3A84DFB95860 = spawn("script_origin", _id_648F53CBD8BE4D47);
  level._id_BABA3A84DFB95860 thread _id_AF874855B6AC35F1("cp_raid_cypher_computer_lp");

  for(;;) {
    level._id_BABA3A84DFB95860 playSound("cp_raid_cypher_computer_start");
    level._id_BABA3A84DFB95860 thread _id_234D4370263F3103(1.5, "cp_raid_cypher_computer_lp");
    level waittill("computer_power_off");
    level._id_BABA3A84DFB95860 playSound("cp_raid_cypher_computer_end");
    level._id_BABA3A84DFB95860 stoploopsound("cp_raid_cypher_computer_lp");
    level waittill("computer_power_on");
  }
}

_id_234D4370263F3103(delay, alias) {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  level endon("maze_numstutorial_complete");
  wait(delay);
  self playLoopSound(alias);
}

_id_AF874855B6AC35F1(_id_FD3E298BC7247BCC) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_return_2("maze_numstutorial_complete", "seq3_puzzle_complete");
  self stoploopsound(_id_FD3E298BC7247BCC);
  wait 1;
  self delete();
}

clear_three_room_screens() {
  level notify("nums_wipe_tv_omnvars");
  setomnvar("ui_raid_number_screen_a", 0);
  setomnvar("ui_raid_number_screen_b", 0);
  setomnvar("ui_raid_number_screen_c", 0);
}

_id_A0A4C2E3F11EADF1() {
  game["numspuzzle_cypher"] = level.seq3_numbers_array;
}

_id_508A84E5FBB679A7() {
  game["numspuzzle_cypher"] = "new-required";
}

_id_DA9AD0759AB668C8() {
  level notify("play_cypher_phonetics_loop");
  level notify("radio_power_on");
  level endon("play_cypher_phonetics_loop");
  level endon("stop_cypher_phonetics_loop");
  wait 2;

  for(;;) {
    level thread scripts\cp\utility::playsoundatpos_safe(self.origin, "cp_raid_cypher_radio_static");
    wait 0.5;
    _id_C3461E57ACD7E583();
    wait 4.5;
  }
}

_id_C3461E57ACD7E583() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.current_cypher_pieces.size; _id_AC0E594AC96AA3A8++) {
    alias = level.current_cypher_pieces[_id_AC0E594AC96AA3A8].verbal_string;
    level thread scripts\cp\utility::playsoundatpos_safe(self.origin, alias);
    wait 1.25;
  }
}

computer_event_listener() {
  level endon("game_ended");

  for(;;) {
    self waittill("computer_event", value, player);
    player playlocalsound("cp_computer_fail");
    continue;
  }
}

computer_listener_all(_id_88A5B6AAD8A3BF4C) {
  level endon("game_ended");
  level notify("numspuzzle_computer_listener");
  level endon("numspuzzle_computer_listener");
  level thread _id_66E614363F4AAB26();
  level.seq3_computer_interaction = scripts\cp\cp_computerscreen::create_computer_interaction(_id_88A5B6AAD8A3BF4C.origin, int(1));
  level.seq3_computer_interaction thread computer_event_listener();
  _id_71332A5B74214116::registerinteraction("f14_puzzle_keypad", undefined, ::_id_E315F805784E6484);
  level._id_C32C64CB22CDC120 = ::_id_F0AEC4F2D52486D7;
  level._id_8517E78200ECC66E = ::_id_6C52AB1DA7514DF3;

  for(;;) {
    level waittill("manifest_computer_used", player);
    computer_player_listener(player);
  }
}

_id_E315F805784E6484(_id_DF071553D0996FF9, player) {}

_id_F0AEC4F2D52486D7(player) {
  if(player _id_C90E8F2F3873C2D5())
    player._id_2D0FE75B4FBAA60D = 1;
  else
    player._id_2D0FE75B4FBAA60D = 0;
}

_id_6C52AB1DA7514DF3(player, computer) {
  computer notify("on_exit");
  _id_F16DA76CA2A21D99 = level.seq3_tier * 3;

  if(level.f14_current_inputamt >= _id_F16DA76CA2A21D99) {
    return;
  }
  keypad_input_clear();
}

computer_player_listener(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("exit_computer");
  _id_F85F022CF90CAE89 = scripts\engine\utility::getStructArray("f14_puzzle_keypad", "script_noteworthy");
  _id_12A2A021A66D1E63 = scripts\engine\utility::getclosest(player.origin, _id_F85F022CF90CAE89);

  for(;;) {
    player waittill("luinotifyserver", _id_7148C1A6F25491F8, index);

    if(isDefined(_id_7148C1A6F25491F8) && _id_7148C1A6F25491F8 == "number_pad_digit") {
      if(index != 12)
        index = clamp(index, 0, 9);

      _id_08F46AD208419BE2 = player _id_60342A2B2780D5B6(index);
      level thread _id_53B55CBB59C7C9F5(_id_12A2A021A66D1E63, _id_08F46AD208419BE2, index, player);
      index = "" + index;
      level.f14_keypadnumstr = index;
      keypad_activate_func(_id_12A2A021A66D1E63, player);
    }
  }
}

_id_53B55CBB59C7C9F5(_id_12A2A021A66D1E63, _id_08F46AD208419BE2, index, player) {
  if(!isDefined(_id_12A2A021A66D1E63)) {
    return;
  }
  _id_3F745D640F7A4532 = "cp_raid_codemachine_enter_digit";

  if(index == 12)
    _id_3F745D640F7A4532 = "cp_raid_codemachine_clear_digit";

  level thread scripts\cp\utility::playsoundatpos_safe(_id_12A2A021A66D1E63.origin, _id_3F745D640F7A4532);

  if(isDefined(_id_08F46AD208419BE2))
    player thread _id_669C0F6CB0B7F0CD::_id_FA472D0EABDC4A2F(_id_08F46AD208419BE2);
}

keypad_activate_func(_id_DF071553D0996FF9, player) {
  if(istrue(level.seq3_puzzle_complete)) {
    return;
  }
  if(!isDefined(level.f14_current_inputseq)) {
    level.f14_current_inputseq = "";
    level.f14_current_inputamt = 0;
    level.seq3_sequences_correct = 0;
    level._id_B54CC012D53DB80F = [];
  }

  if(keypad_input_greaterthan_limit())
    keypad_input_clear();

  if(isDefined(level.f14_keypadnumstr)) {
    if(level.f14_keypadnumstr == "clear" || level.f14_keypadnumstr == "12")
      keypad_input_clear();
    else {
      if(level.f14_current_inputseq != "")
        level.f14_current_inputseq = level.f14_current_inputseq + " " + level.f14_keypadnumstr;
      else
        level.f14_current_inputseq = level.f14_keypadnumstr;

      level.f14_current_inputamt++;
      level thread update_keypad_currentdisplay_models();
    }
  }

  keypad_check_levelinput(_id_DF071553D0996FF9, player);
}

_id_289C6A12ED0C6964() {
  _id_827F5E76975DC473 = 6 * (level.seq3_tier - 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_827F5E76975DC473; _id_AC0E594AC96AA3A8++)
    level.f14_current_inputseq = level.f14_current_inputseq + level.seq3_tvnums_str[_id_AC0E594AC96AA3A8];

  level thread update_keypad_currentdisplay_models();
  level.f14_current_inputamt = (level.seq3_tier - 1) * 3;
  wait 2.05;

  for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    if(level.seq3_tier >= _id_AC0E594AC96AA3A8)
      level thread set_tier_lights(_id_AC0E594AC96AA3A8, level.seq3_reset_switch);

    wait 0.05;
  }
}

keypad_check_levelinput(_id_DF071553D0996FF9, player) {
  if(getdvarint("dvar_DB60DF8EE2A2C313", 0) == 1) {
    if(isDefined(level._id_A482AE70A62B5FB7.puzzle_mark_complete))
      level thread[[level._id_A482AE70A62B5FB7.puzzle_mark_complete]]();

    level notify("seq3_stop_countdown");
    level notify("stop_cypher_phonetics_loop");
    level notify("stop_tvscreen_phonetics_loop");
  } else {
    if(level.f14_current_inputamt % 3 != 0) {
      return;
    }
    if(level.f14_current_inputamt == 0) {
      return;
    }
    _id_2EC461C4969E5625 = level.seq3_tier * 3;

    if(_id_2EC461C4969E5625 > 9)
      _id_2EC461C4969E5625 = 9;

    if(level.f14_current_inputamt < _id_2EC461C4969E5625) {
      return;
    }
    _id_A8F15F1553E174E8 = 0;

    if(keypad_confirm_code_correct()) {
      level.seq3_sequences_correct = min(level.seq3_tier, 4);

      if(isDefined(level._id_A482AE70A62B5FB7.increase_sequence_tier))
        [[level._id_A482AE70A62B5FB7.increase_sequence_tier]](_id_DF071553D0996FF9);

      if(level.seq3_sequences_correct == level._id_39BC47CBD32AD77E._id_0E7D8F530D432967) {
        if(isDefined(level._id_A482AE70A62B5FB7.puzzle_mark_complete))
          level thread[[level._id_A482AE70A62B5FB7.puzzle_mark_complete]]();

        level thread _id_8EA4107D13F5295F(_id_DF071553D0996FF9, 0);
        level notify("seq3_stop_countdown");
        level notify("stop_cypher_phonetics_loop");
        level notify("stop_tvscreen_phonetics_loop");
        return;
      }

      level notify("exit_sequence_early");
      level notify("seq3_delete_digits");
      level thread clear_cypher_icon();
      level thread computer_force_player_to_exit(0.1);
      player thread _id_229AB9D30E9B608D(_id_DF071553D0996FF9);
      level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_NUMSPUZZLE/CODE_VALID");
      level thread _id_8EA4107D13F5295F(_id_DF071553D0996FF9, 1);
      player thread _id_669C0F6CB0B7F0CD::_id_1AD056E2EAF1F51E();
      return;
      return;
    }

    if(isDefined(level.f14_3pastcodes)) {
      foreach(_id_6D1D79C44CEA96E7 in level.f14_3pastcodes) {
        if(level.f14_current_inputseq == _id_6D1D79C44CEA96E7) {
          foreach(player in level.players)
          player iprintlnbold("^6" + level.f14_current_inputseq + " - Code Expired");

          return;
        }
      }
    }

    level thread _id_DCB862B9422DDAF0(player, _id_DF071553D0996FF9);
    keypad_increase_failnum(_id_DF071553D0996FF9);
    level thread computer_force_player_to_exit(0.1);
  }
}

_id_8EA4107D13F5295F(_id_DF071553D0996FF9, _id_F2F1FDCAA1E202A4) {
  wait 0.5;
  level thread scripts\cp\utility::playsoundatpos_safe(_id_DF071553D0996FF9.origin, "cp_raid_codemachine_good_code");

  if(_id_F2F1FDCAA1E202A4 == 1) {
    wait 0.3;
    level thread scripts\cp\utility::playsoundatpos_safe(_id_DF071553D0996FF9.origin, "dx_cp_cpr1_intr_cmpv_codeaccepted_01");
  }
}

_id_DCB862B9422DDAF0(player, _id_DF071553D0996FF9) {
  wait 0.75;

  if(istrue(level._id_579EC85106ECF399)) {
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_NUMSPUZZLE/INTEL_DOOR_OPENED", undefined, 10);
    level thread _id_8EA4107D13F5295F(_id_DF071553D0996FF9, 1);
    level._id_579EC85106ECF399 = undefined;
    return;
  }

  level thread scripts\cp\utility::playsoundatpos_safe(_id_DF071553D0996FF9.origin, "cp_raid_codemachine_invalid_input");
  wait 0.25;
  level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_RAID1_NUMSPUZZLE/CODE_INVALID");
  level thread scripts\cp\utility::playsoundatpos_safe(_id_DF071553D0996FF9.origin, "dx_cp_cpr1_intr_cmpv_invalidcode_01");

  if(isDefined(player))
    player thread _id_669C0F6CB0B7F0CD::_id_84B9148AF8CA5D53();
}

keypad_input_clear() {
  _id_37067FA25C4F3681 = [];

  if(isDefined(level.f14_current_inputseq) && level.f14_current_inputseq != "") {
    _id_37067FA25C4F3681 = strtok(level.f14_current_inputseq, " ");
    _id_37067FA25C4F3681 = scripts\engine\utility::array_slice(_id_37067FA25C4F3681, 0, (level.seq3_tier - 1) * 3);
  }

  level.f14_current_inputseq = "";

  if(_id_37067FA25C4F3681.size > 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_37067FA25C4F3681.size - 1; _id_AC0E594AC96AA3A8++) {
      level.f14_current_inputseq = level.f14_current_inputseq + _id_37067FA25C4F3681[_id_AC0E594AC96AA3A8];
      level.f14_current_inputseq = level.f14_current_inputseq + " ";
    }

    level.f14_current_inputseq = level.f14_current_inputseq + _id_37067FA25C4F3681[_id_37067FA25C4F3681.size - 1];
  }

  clear_keypad_currentdisplay_models(level.seq3_tier);
}

keypad_input_greaterthan_limit() {
  if(level.f14_current_inputamt >= 9)
    return 1;

  _id_F16DA76CA2A21D99 = level.seq3_tier * 3;

  if(level.f14_current_inputamt >= _id_F16DA76CA2A21D99)
    return 1;

  return 0;
}

keypad_confirm_code_correct() {
  _id_37067FA25C4F3681 = strtok(level.f14_current_inputseq, " ");
  _id_11019BDA5662ACAF = strtok(level.seq3_tvnums_str, " ");
  level thread _id_8B6ECE0B9420856A();

  if(_id_37067FA25C4F3681.size == 0 || _id_11019BDA5662ACAF.size == 0)
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_37067FA25C4F3681.size; _id_AC0E594AC96AA3A8++) {
    if(_id_37067FA25C4F3681[_id_AC0E594AC96AA3A8] != _id_11019BDA5662ACAF[_id_AC0E594AC96AA3A8])
      return 0;
  }

  return 1;
}

_id_8B6ECE0B9420856A() {
  if(!istrue(level._id_DF2F5CF1D779EA0C)) {
    return;
  }
  _id_37067FA25C4F3681 = strtok(level.f14_current_inputseq, " ");

  if(_id_37067FA25C4F3681.size < 3) {
    return;
  }
  if(_id_37067FA25C4F3681[0] == "6" && _id_37067FA25C4F3681[1] == "2" && _id_37067FA25C4F3681[2] == "7") {
    if(!scripts\engine\utility::flag("seq3_keypad_intel_activated")) {
      scripts\engine\utility::flag_set("seq3_keypad_intel_activated");
      level._id_579EC85106ECF399 = 1;
    }
  }
}

computer_force_player_to_exit(delay) {
  if(isDefined(delay))
    wait(delay);

  foreach(player in level.players)
  player notify("exit_computer");
}

_id_229AB9D30E9B608D(_id_DF071553D0996FF9) {
  if(getdvarint("dvar_9C4CF285CF08A711", 1) == 0) {
    return;
  }
  level._id_B54CC012D53DB80F[level._id_B54CC012D53DB80F.size] = self;
  thread _id_90292DAF09DCB155(_id_DF071553D0996FF9);

  if(level._id_B54CC012D53DB80F.size == level.players.size)
    level._id_B54CC012D53DB80F = scripts\engine\utility::array_remove_index(level._id_B54CC012D53DB80F, 0);
}

_id_90292DAF09DCB155(_id_DF071553D0996FF9) {
  level endon("game_ended");
  self endon("disconnect");
  wait 1;
  level thread scripts\cp\utility::playsoundatpos_safe(_id_DF071553D0996FF9.origin, "cp_raid_codemachine_upload_fingerprint");
  wait 4.5;
  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID1_NUMSPUZZLE/DUPLICATE_KEYPAD_ALERT");
  level thread scripts\cp\utility::playsoundatpos_safe(_id_DF071553D0996FF9.origin, "dx_cp_cpr1_intr_cmpv_fingerprintsaved_01");
}

_id_C90E8F2F3873C2D5() {
  if(getdvarint("dvar_9C4CF285CF08A711", 1) == 0)
    return 0;

  if(isDefined(scripts\engine\utility::array_find(level._id_B54CC012D53DB80F, self))) {
    thread scripts\cp\cp_hud_message::tutorialprint(&"CP_RAID1_NUMSPUZZLE/DUPLICATE_KEYPAD_PLAYER");

    if(!isDefined(level._id_5E77AFDB8E2FC8D2)) {
      level._id_5E77AFDB8E2FC8D2 = gettime();
      thread _id_37FA6783EF17ED78();
      thread _id_669C0F6CB0B7F0CD::_id_63765016FA13A8E0();
    }

    threshold = 5;

    if(scripts\engine\utility::time_has_passed(level._id_5E77AFDB8E2FC8D2, threshold)) {
      thread _id_37FA6783EF17ED78();
      thread _id_669C0F6CB0B7F0CD::_id_63765016FA13A8E0();
      level._id_5E77AFDB8E2FC8D2 = gettime();
    }

    return 1;
  }

  return 0;
}

_id_37FA6783EF17ED78() {
  level endon("game_ended");
  level endon("seq3_puzzle_complete");
  level endon("maze_numstutorial_complete");
  level thread scripts\cp\utility::playsoundatpos_safe(level.seq3_computer_interaction.origin, "cp_raid_codemachine_invalid_input");
  wait 0.25;
  level thread scripts\cp\utility::playsoundatpos_safe(level.seq3_computer_interaction.origin, "dx_cp_cpr1_intr_cmpv_newfingerprintrequir_01");
}

keypad_increase_failnum(_id_DF071553D0996FF9) {
  if(!isDefined(level.seq3_puzzle_attempts))
    level.seq3_puzzle_attempts = 0;
  else
    level.seq3_puzzle_attempts++;

  if(!isDefined(_id_DF071553D0996FF9))
    _id_DF071553D0996FF9 = scripts\engine\utility::getStruct("f14_puzzle_keypad", "script_noteworthy");

  scripts\cp\cp_analytics::_id_B6283AC45A607764("Raid: Numbers Sequence: " + level.seq3_tier, "Failed keypad input " + level.seq3_puzzle_attempts + " times");
  level notify("seq3_fail_input");
  setomnvar("ui_raid_number_retries", 3 - level.seq3_puzzle_attempts - 1);

  if(level.seq3_puzzle_attempts >= 2) {
    level thread keypad_disable_for_time(_id_DF071553D0996FF9, level._id_39BC47CBD32AD77E._id_1EDCD0185B996C10);
    level.seq3_puzzle_attempts = undefined;
  }
}

keypad_disable_for_time(_id_12A2A021A66D1E63, _id_A5D1DF55FE16B5E1) {
  level endon("game_ended");
  _id_71332A5B74214116::removefrominteractionslistbynoteworthy("f14_puzzle_keypad");
  level.seq3_reset_switch makeusable();
  level.seq3_reset_switch _meth_DFB78B3E724AD620(0);
  clear_cypher_icon();

  if(isDefined(level._id_A482AE70A62B5FB7._id_BD1B0809D148CE9C))
    [[level._id_A482AE70A62B5FB7._id_BD1B0809D148CE9C]](_id_A5D1DF55FE16B5E1);

  level notify("exit_sequence_early");
  level notify("seq3_delete_digits");
  level notify("seq3_puzzle_lockdown");
  level notify("stop_cypher_phonetics_loop");
  level notify("stop_tvscreen_phonetics_loop");
  level notify("computer_power_off");
  level notify("radio_power_off");
  level thread computer_force_player_to_exit(0.1);
  level thread flashing_lives_screens();
  level thread _id_07B806E48422784B();
  level thread _id_669C0F6CB0B7F0CD::_id_6F8B5DAC34599048();
  level.seq3_computer_interaction.disable_playeruse = 1;
  level.seq3_computer_interaction _meth_DFB78B3E724AD620(0);
  level thread _id_18AF78602B67B70C::_id_6AE8E5D7C480EF7D();
  _id_5DC0950948D51A87 = spawn("script_model", _id_12A2A021A66D1E63.origin + (0, 0, 22));
  _id_5DC0950948D51A87 setModel("tag_origin");
  _id_5DC0950948D51A87.angles = _id_12A2A021A66D1E63.angles;
  wait(_id_A5D1DF55FE16B5E1);
  level.seq3_reset_switch _meth_DFB78B3E724AD620(1);

  if(isDefined(level._id_A482AE70A62B5FB7._id_A3B356F2158A1EB3))
    [[level._id_A482AE70A62B5FB7._id_A3B356F2158A1EB3]]();

  level thread _id_18AF78602B67B70C::_id_6AE8E5D7C480EF7D();
  level waittill("seq3_reset_trigger");
  level.seq3_computer_interaction.disable_playeruse = 0;
  level.seq3_computer_interaction _meth_DFB78B3E724AD620(1);

  if(isDefined(level._id_A482AE70A62B5FB7._id_37DE616924E20CB0))
    [[level._id_A482AE70A62B5FB7._id_37DE616924E20CB0]]();

  wait 0.05;
  _id_71332A5B74214116::addtointeractionslistbynoteworthy("f14_puzzle_keypad");

  if(isent(_id_5DC0950948D51A87))
    _id_5DC0950948D51A87 delete();

  level.seq3_puzzle_attempts = undefined;
}

flashing_lives_screens() {
  level endon("game_ended");
  level endon("seq3_reset_trigger");

  for(;;) {
    setomnvar("ui_raid_number_retries", 3);
    wait 1;
    setomnvar("ui_raid_number_retries", 0);
    wait 1;
  }
}

_id_07B806E48422784B() {
  level endon("game_ended");
  level endon("seq3_reset_trigger");

  for(;;) {
    _id_61A5276782C907B2 = level.seq3_tier * 3;

    if(_id_61A5276782C907B2 > 9)
      _id_61A5276782C907B2 = 9;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_61A5276782C907B2; _id_AC0E594AC96AA3A8++)
      level thread change_keypad_display_digit(_id_AC0E594AC96AA3A8, -1);

    wait 1;
    level thread update_keypad_currentdisplay_models();
    wait 1;
  }
}

_id_60342A2B2780D5B6(number) {
  number = int(number);
  aliases = undefined;

  switch (number) {
    case 0:
      aliases = ["dx_cp_cpr1_intr_pric_zero", "dx_cp_cpr1_intr_fara_zero", "dx_cp_cpr1_intr_gazz_zero"];
      break;
    case 1:
      aliases = ["dx_cp_cpr1_intr_pric_one", "dx_cp_cpr1_intr_fara_one", "dx_cp_cpr1_intr_gazz_one"];
      break;
    case 2:
      aliases = ["dx_cp_cpr1_intr_pric_two", "dx_cp_cpr1_intr_fara_two", "dx_cp_cpr1_intr_gazz_two"];
      break;
    case 3:
      aliases = ["dx_cp_cpr1_intr_pric_three", "dx_cp_cpr1_intr_fara_three", "dx_cp_cpr1_intr_gazz_three"];
      break;
    case 4:
      aliases = ["dx_cp_cpr1_intr_pric_four", "dx_cp_cpr1_intr_fara_four", "dx_cp_cpr1_intr_gazz_four"];
      break;
    case 5:
      aliases = ["dx_cp_cpr1_intr_pric_five", "dx_cp_cpr1_intr_fara_five", "dx_cp_cpr1_intr_gazz_five"];
      break;
    case 6:
      aliases = ["dx_cp_cpr1_intr_pric_six", "dx_cp_cpr1_intr_fara_six", "dx_cp_cpr1_intr_gazz_six"];
      break;
    case 7:
      aliases = ["dx_cp_cpr1_intr_pric_seven", "dx_cp_cpr1_intr_fara_seven", "dx_cp_cpr1_intr_gazz_seven"];
      break;
    case 8:
      aliases = ["dx_cp_cpr1_intr_pric_eight", "dx_cp_cpr1_intr_fara_eight", "dx_cp_cpr1_intr_gazz_eight"];
      break;
    case 9:
      aliases = ["dx_cp_cpr1_intr_pric_nine", "dx_cp_cpr1_intr_fara_nine", "dx_cp_cpr1_intr_gazz_nine"];
      break;
    case 12:
      break;
  }

  if(!isDefined(aliases))
    return undefined;

  return _id_669C0F6CB0B7F0CD::_id_C810DB5F583495B1(self, aliases);
}

_id_F3A7EE5F80D15B7B(number) {
  number = int(number);
  alias = undefined;

  switch (number) {
    case 0:
      alias = "dx_cp_cpr1_intr_cmpv_zero_01";
      break;
    case 1:
      alias = "dx_cp_cpr1_intr_cmpv_one_01";
      break;
    case 2:
      alias = "dx_cp_cpr1_intr_cmpv_two_01";
      break;
    case 3:
      alias = "dx_cp_cpr1_intr_cmpv_three_01";
      break;
    case 4:
      alias = "dx_cp_cpr1_intr_cmpv_four_01";
      break;
    case 5:
      alias = "dx_cp_cpr1_intr_cmpv_five_01";
      break;
    case 6:
      alias = "dx_cp_cpr1_intr_cmpv_six_01";
      break;
    case 7:
      alias = "dx_cp_cpr1_intr_cmpv_seven_01";
      break;
    case 8:
      alias = "dx_cp_cpr1_intr_cmpv_eight_01";
      break;
    case 9:
      alias = "dx_cp_cpr1_intr_cmpv_nine_01";
      break;
    case 12:
      break;
  }

  return alias;
}

init_keypad_display_digits(_id_EF5F42DC3BAE2A88) {
  wait 2;
  _id_FBF0806DC15ED786 = associate_digit_display_model("seq3_puzzle_digits_01", _id_EF5F42DC3BAE2A88);
  _id_FBF07F6DC15ED553 = associate_digit_display_model("seq3_puzzle_digits_02", _id_EF5F42DC3BAE2A88);
  _id_FBF07E6DC15ED320 = associate_digit_display_model("seq3_puzzle_digits_03", _id_EF5F42DC3BAE2A88);
  _id_FBF0856DC15EE285 = associate_digit_display_model("seq3_puzzle_digits_04", _id_EF5F42DC3BAE2A88);
  _id_FBF0846DC15EE052 = associate_digit_display_model("seq3_puzzle_digits_05", _id_EF5F42DC3BAE2A88);
  _id_FBF0836DC15EDE1F = associate_digit_display_model("seq3_puzzle_digits_06", _id_EF5F42DC3BAE2A88);
  _id_FBF0826DC15EDBEC = associate_digit_display_model("seq3_puzzle_digits_07", _id_EF5F42DC3BAE2A88);
  _id_FBF0896DC15EEB51 = associate_digit_display_model("seq3_puzzle_digits_08", _id_EF5F42DC3BAE2A88);
  _id_FBF0886DC15EE91E = associate_digit_display_model("seq3_puzzle_digits_09", _id_EF5F42DC3BAE2A88);
  _id_70C2276043946542 = associate_digit_display_model("seq3_puzzle_digits_10", _id_EF5F42DC3BAE2A88);
  _id_70C2286043946775 = associate_digit_display_model("seq3_puzzle_digits_11", _id_EF5F42DC3BAE2A88);
  _id_70C22560439460DC = associate_digit_display_model("seq3_puzzle_digits_12", _id_EF5F42DC3BAE2A88);
  level.seq3_digits_display_array = [_id_FBF0806DC15ED786, _id_FBF07F6DC15ED553, _id_FBF07E6DC15ED320, _id_FBF0856DC15EE285, _id_FBF0846DC15EE052, _id_FBF0836DC15EDE1F, _id_FBF0826DC15EDBEC, _id_FBF0896DC15EEB51, _id_FBF0886DC15EE91E, _id_70C2276043946542, _id_70C2286043946775, _id_70C22560439460DC];
  level thread clear_keypad_currentdisplay_models();
}

associate_digit_display_model(targetname, _id_EF5F42DC3BAE2A88) {
  _id_5936FEB0DE2C53C5 = getEntArray(targetname, "targetname");
  _id_3C6005D6EF920A54 = scripts\engine\utility::getclosest(_id_EF5F42DC3BAE2A88.origin, _id_5936FEB0DE2C53C5);

  if(!isent(_id_3C6005D6EF920A54)) {
    _id_D9FFBEADC818E0AC = scripts\engine\utility::getStructArray(targetname, "targetname");
    _id_D3EF549F74C2A8D7 = scripts\engine\utility::getclosest(_id_EF5F42DC3BAE2A88.origin, _id_D9FFBEADC818E0AC);
    _id_3C6005D6EF920A54 = spawn("script_model", _id_D3EF549F74C2A8D7.origin);
    _id_3C6005D6EF920A54 setModel("electronics_elevator_security_lock_console_a_digits");
    _id_3C6005D6EF920A54.angles = _id_D3EF549F74C2A8D7.angles;
    _id_3C6005D6EF920A54.targetname = targetname;
  }

  return _id_3C6005D6EF920A54;
}

change_keypad_display_digit(slot, num) {
  _id_A166868464F52912 = level.seq3_digits_display_array[slot];
  _id_A166868464F52912 hideallparts();

  if(num >= 0) {
    waitframe();
    _id_A166868464F52912 showpart("joint_console_a_digit_" + num);
  }
}

update_keypad_currentdisplay_models() {
  _id_57777340B22C8238 = strtok(level.f14_current_inputseq, " ");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_57777340B22C8238.size; _id_AC0E594AC96AA3A8++)
    level thread change_keypad_display_digit(_id_AC0E594AC96AA3A8, int(_id_57777340B22C8238[_id_AC0E594AC96AA3A8]));
}

clear_keypad_currentdisplay_models(_id_09553DCAB653D1F1) {
  if(isDefined(_id_09553DCAB653D1F1)) {
    stop = undefined;

    switch (_id_09553DCAB653D1F1) {
      case 1:
      case 0:
        stop = 0;
        break;
      case 2:
        stop = 3;
        break;
      case 3:
        stop = 6;
        break;
      case 4:
        stop = 9;
        break;
    }

    if(isDefined(level.seq3_digits_display_array)) {
      for(_id_AC0E594AC96AA3A8 = level.seq3_digits_display_array.size - 1; _id_AC0E594AC96AA3A8 >= stop; _id_AC0E594AC96AA3A8--)
        level.seq3_digits_display_array[_id_AC0E594AC96AA3A8] hideallparts();
    }

    if(stop == 0)
      level thread clear_tier_lights_all();

    level.f14_current_inputamt = stop;
  } else {
    level.f14_current_inputamt = 0;

    if(isDefined(level.seq3_digits_display_array)) {
      foreach(_id_A166868464F52912 in level.seq3_digits_display_array)
      _id_A166868464F52912 hideallparts();
    }

    level thread clear_tier_lights_all();
  }
}

clear_tier_lights_all() {
  wait 0.5;
  clear_tier_lights("seq3_keypad_greenlight_01");
  wait 0.5;
  clear_tier_lights("seq3_keypad_greenlight_02");
  wait 0.5;
  clear_tier_lights("seq3_keypad_greenlight_03");
  wait 0.5;
  clear_tier_lights("seq3_keypad_greenlight_04");
}

clear_tier_lights(targetname) {
  level thread _id_B31193550E9AF2FA();
  models = getEntArray(targetname, "targetname");
  model = scripts\engine\utility::getclosest(level.seq3_cypher_tagorigin.origin, models);

  if(isDefined(model))
    model setModel("electronics_elevator_security_lock_console_a_green_light_off");
}

set_tier_lights(_id_C7E1E33B74F784D7, _id_DF071553D0996FF9) {
  _id_6275D82766D57226 = undefined;

  switch (_id_C7E1E33B74F784D7) {
    case 2:
      _id_6275D82766D57226 = "seq3_keypad_greenlight_01";
      break;
    case 3:
      _id_6275D82766D57226 = "seq3_keypad_greenlight_02";
      break;
    case 4:
      _id_6275D82766D57226 = "seq3_keypad_greenlight_03";
      break;
    case 5:
      _id_6275D82766D57226 = "seq3_keypad_greenlight_04";
      break;
  }

  if(isDefined(_id_6275D82766D57226)) {
    models = getEntArray(_id_6275D82766D57226, "targetname");
    model = scripts\engine\utility::getclosest(_id_DF071553D0996FF9.origin, models);

    if(isDefined(model))
      model setModel("electronics_elevator_security_lock_console_a_green_light_on");
  }
}

_id_68FAB4C03C76B7C8() {
  if(isDefined(level.seq3_tier)) {
    _id_62734860AB2C3054 = level.seq3_tier;
    stop = undefined;

    switch (_id_62734860AB2C3054) {
      case 1:
      case 0:
        stop = 0;
        break;
      case 2:
        stop = 3;
        break;
      case 3:
        stop = 6;
        break;
      case 4:
        stop = 9;
        break;
    }

    level.f14_current_inputamt = stop;
  }
}

_id_B0CE90035E6B64D0(player) {
  _id_FAD95C97F69CC3D2();
  player playSound("cp_raid_foley_cypherpuzzle_intro");
  console = scripts\engine\utility::getclosest(player.origin, getEntArray("usable_reset_console", "script_noteworthy"));
  scenenode = spawnStruct();
  scenenode.origin = console.origin;
  scenenode.angles = vectortoangles(anglestoright(console.angles));
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_reset_console", 1, 1);
  _id_CF3F507FDBDD8367 = scripts\cp_mp\anim_scene::anim_scene_create_actor(console, "reset_console_prop", 0);
  scenenode thread scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_CF3F507FDBDD8367], "reset");
  scenenode endon("anim_scene_interrupted");
  player endon("disconnect");
  level endon("game_ended");
  wait 1.4;
  player earthquakeforplayer(0.34, 0.5, player.origin, 500);
  wait 0.4;
}

#using_animtree("script_model");

_id_FAD95C97F69CC3D2() {
  level.scr_animtree["plyr_reset_console"] = #animtree;
  level.scr_anim["plyr_reset_console"]["reset"] = % cp_raid_reset_console;
  level.scr_animname["plyr_reset_console"]["reset"] = "cp_raid_reset_console";
  level.scr_eventanim["plyr_reset_console"]["reset"] = "cp_raid_reset_console";
  level.scr_animtree["reset_console_prop"] = #animtree;
  level.scr_anim["reset_console_prop"]["reset"] = % cp_raid_reset_console_button;
  level.scr_animname["reset_console_prop"]["reset"] = "cp_raid_reset_console_button";
}

_id_C990007D659769D7(player) {
  _id_A7B50C0C8400A211();
  console = scripts\engine\utility::getclosest(player.origin, getEntArray("seq3_command_console_model", "targetname"));
  scenenode = spawnStruct();
  scenenode.origin = console.origin;
  scenenode.angles = console.angles + (0, 180, 0);
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "plyr_activation", 1, 1);
  _id_CF3F507FDBDD8367 = scripts\cp_mp\anim_scene::anim_scene_create_actor(console, "activation_prop", 0);
  console playSound("cp_raid_computer_terminal_power_on_cpu_fan");
  player thread _id_3ADDF0A42D40BF31();
  scenenode scripts\cp_mp\anim_scene::anim_scene([actorplayer, _id_CF3F507FDBDD8367], "activate");
  console scriptmodelclearanim();
}

_id_3ADDF0A42D40BF31() {
  wait 0.13;
  self playSound("cp_raid_computer_terminal_power_on");
}

_id_A7B50C0C8400A211() {
  level.scr_animtree["plyr_activation_table"] = #animtree;
  level.scr_anim["plyr_activation"]["activate"] = % cp_raid_activation_table;
  level.scr_animname["plyr_activation"]["activate"] = "cp_raid_activation_table";
  level.scr_eventanim["plyr_activation"]["activate"] = "cp_raid_activation_table";
  level.scr_animtree["activation_prop"] = #animtree;
  level.scr_anim["activation_prop"]["activate"] = % cp_raid_activation_table_button;
  level.scr_animname["activation_prop"]["activate"] = "cp_raid_activation_table_button";
}

_id_2DC4824671CC6BFA() {
  level endon("game_ended");
  wait 1;
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Raid Numbers Puzzle / Display Code\" \"set scr_numspuzzle_display 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread scripts\cp\cp_debug::_id_EEF8FED381E4DEEC("dvar_D96F59AD562653C7", ::_id_DE5DAC98CC570087);
}

_id_DE5DAC98CC570087() {
  level notify("new_nums_debug_display");
  level endon("new_nums_debug_display");

  if(isDefined(level.seq3_tvnums_str)) {
    if(level.seq3_tvnums_str == "")
      announcement("^1Code is empty string!");
    else {
      if(isDefined(level._id_FFCE363B6AEAACC8))
        level._id_FFCE363B6AEAACC8 destroy();

      level._id_FFCE363B6AEAACC8 = newhudelem();
      level._id_FFCE363B6AEAACC8.x = 400;
      level._id_FFCE363B6AEAACC8.y = 125;
      level._id_FFCE363B6AEAACC8.color = (1, 0, 0.9);
      level._id_FFCE363B6AEAACC8.alpha = 1.0;
      level._id_FFCE363B6AEAACC8.hidden = 0;
      level._id_FFCE363B6AEAACC8._id_9E76FE13C19DA9A3 = 0;
      level._id_FFCE363B6AEAACC8._id_95EF0E28E73E593C = 0;
      level._id_FFCE363B6AEAACC8.fontscale = 1.0;
      max = 15;
      level._id_FFCE363B6AEAACC8 thread scripts\engine\utility::delaycall(max + 1, ::destroy);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < max; _id_AC0E594AC96AA3A8++)
        wait 1;
    }
  } else
    announcement("^1Code Doesn't exist!");
}