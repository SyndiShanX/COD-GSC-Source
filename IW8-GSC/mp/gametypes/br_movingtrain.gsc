/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_movingtrain.gsc
***********************************************/

main() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarint("_encstr_BA2713CDB19CF5EE9E3A9C16A5CDFAAC372C136359", 0) == 0) {
    last_stand_clear_pilot_picker();
    return;
  }

  if(!isDefined(level._id_145F1))
    level._id_145F1 = spawnStruct();

  scripts\engine\utility::flag_init("_encstr_84A3126310E493270A1B177373E37F10B72AA99B");
  scripts\engine\utility::flag_init("_encstr_84CE1833409470577A4B47E1C3E2AE2B4B9AF9E9A1FC081FF277");
  scripts\engine\utility::flag_init("_encstr_931916C36A631BF1787AC0278A78D7E51FB6537703C3E203");
  scripts\engine\utility::flag_init("_encstr_955B15437A0DF36608950F39BD202DFFB710BA2BE0E86F");
  scripts\engine\utility::flag_init("_encstr_A9ED17D3BAEBB329D935A7E3CBDF78A6E6E1242BEB07BB9D19");
  var_0 = "_encstr_B40101";

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret._id_13CD1))
    var_0 = level.disable_super_in_turret._id_13CD1;
  else {
    var_0 = getDvar("_encstr_882E119BD89C7DEE9ED1392C5A9BEB8E5EC195", "_encstr_B40101");

    if(isDefined(level.disable_super_in_turret))
      level.disable_super_in_turret._id_13CD1 = var_0;
  }

  if(var_0 != "_encstr_842408C29CB6DB392B32") {
    last_molotov_throw_time("_encstr_842408C29CB6DB392B32");
    scripts\mp\utility\sound::besttime("_encstr_B6CB14ECACD0B48DD856FA36C24E9DBDD7A339C25AE6");
  } else
    last_molotov_throw_time("_encstr_B40101");

  level._id_145F1.cargo_truck_mg_create = record_finished_area(var_0);
  level._id_145F1.type = var_0;

  if(istrue(level._id_145F1.ks_airdropcrateusetime)) {
    return;
  }
  tr_findvehicle();
}

last_stand_clear_pilot_picker() {
  last_molotov_throw_time("_encstr_842408C29CB6DB392B32");
  last_molotov_throw_time("_encstr_B40101");
}

tr_findvehicle(var_0) {
  if(!level target_wavespawning_to_jammer5())
    return 0;

  if(level._id_145F1.type == "_encstr_842408C29CB6DB392B32")
    _encstr_ACD6305B966B8702F188FED278AF3F5F600DC4D9B7D1A79D85B8E12A9825F42B996D4A794318CFD68D28EAD3E069FDD7735E::init();

  level thread _id_1433B(var_0);
}

record_finished_area(var_0) {
  var_1 = spawnStruct();

  if(var_0 == "_encstr_842408C29CB6DB392B32") {
    var_1.num_players_by_truck = "_encstr_96A513F2AB515772D8315F7CF5107C8B90214A4B96";
    var_1.num_nags = "_encstr_A99617D71ADF80952F3A7928B3C67B78BFB36FD65F9FC8E199";
    var_1.num_nodes_random_search = "_encstr_853B1D2B233A58609DE7EE838A416037B1DFA395FFA210D88F3A7038F62399";
    var_1.modelname = "_encstr_994A193AB8F3FDEBB1254F7CC6D94F456FD8A283695BB5CBE91947";
    var_1._id_119A4 = "_encstr_836514939B82E0C8057F86FBE2E9D8A859370B3D97EF";
    var_1.animname = "_encstr_8418272DBB1CD76B38AFD9B2392316DCDCD6F5589C6BDE2756327D8EC90BD29BAFD8F6DC9DFA46C90C";
    var_1.stack_patch_thread_node = [8, 7, 6, 5, 4, 3, 2, 1];
    var_1.cargo_truck_mg_cp_create = "_encstr_9A612CC39DF82ABF3B52B897ECA5E1B928AAA9694A709FA2CFDA71349D41140B218E03175505CEB3D349C06750F2";
    var_1._id_136D6 = "_encstr_8ED024D3DA37ECEF50116791DC218E6935486788453F141E2F04685050471B90F3E8D3936CFF";
    var_1._id_136D5 = "_encstr_9BE621DBCAE7CBC7405B1F559BA86715DDD011F2500F834359EB266FA7932F9E43E82B";
  } else {
    var_1.num_players_by_truck = "_encstr_BA9F0BD13958D2CDF5D80BC97D";
    var_1.modelname = "_encstr_9A50114B623B2F2AC1C297E357BDFA0ADF6169";
    var_1._id_11C72 = 1;
    var_1._id_119A4 = "_encstr_8E650D2B109FB36877E2FF8B516277";
    var_1.animname = "_encstr_97EC1AA5BB70FA5B38AFEC9593465837DCADFAE8E416B49BD7C89C81";
    var_1.stack_patch_thread_node = [13, 14, 15, 16, 17, 18, 19, 20];
    var_1.cargo_truck_mg_cp_create = "_encstr_97DB1FC3EDB1E737C038CBFFE858C4597DFE01FBCECB8A5EAE50BF478810BA32E3";
  }

  return var_1;
}

last_molotov_throw_time(var_0) {
  var_1 = record_finished_area(var_0);

  foreach(var_3 in var_1.stack_patch_thread_node) {
    var_4 = var_1.num_players_by_truck + var_3;
    var_5 = getEnt(var_4, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(isDefined(var_5))
      var_5 delete();

    if(isDefined(var_1.num_nags)) {
      var_5 = getEnt(var_1.num_nags + var_3, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

      if(isDefined(var_5))
        var_5 delete();
    }

    if(isDefined(var_1.num_nodes_random_search)) {
      var_5 = getEnt(var_1.num_nodes_random_search + var_3, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

      if(isDefined(var_5))
        var_5 delete();
    }

    var_5 = getEnt(var_4 + "_encstr_9760122791E82627B066F2BB48986B11900B8274", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(isDefined(var_5))
      var_5 delete();

    var_5 = getEnt(var_1.modelname + var_3, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(isDefined(var_5))
      var_5 delete();
  }
}

_id_1433B(var_0) {
  if(!istrue(var_0) && tolower(getDvar("_encstr_9570084B1793A090CDFF")) != "_encstr_97560C7283D73C8376E032EF941A") {
    level thread _id_13CC4("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623");
    level scripts\engine\utility::_id_143A5("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623", "_encstr_928718AAC32003CF884BCFEF7DE8177FD05DE2738D0CDFC5D06F");
  }

  if(getdvarint("_encstr_BA2713CDB19CF5EE9E3A9C16A5CDFAAC372C136359", 0) == 0) {
    return;
  }
  level thread _id_12432();
}

_id_13CC0() {
  if(getdvarfloat("_encstr_A3641B67E3E281CC9B2B2B71C2F39018BD7CCB119C4AC81B2383C11B0A", 0.0) == 0.0) {
    return;
  }
  var_0 = getdvarfloat("_encstr_A3641B67E3E281CC9B2B2B71C2F39018BD7CCB119C4AC81B2383C11B0A", 0.0);

  if(var_0 != 1.0) {
    if(randomint(100) < var_0 * 100)
      return;
  }

  var_1 = scripts\engine\utility::array_combine(level.br_level.br_circleclosetimes, level.br_level.br_circledelaytimes);
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_2 = var_2 + var_1[var_3];

  if(var_2 <= 0) {
    return;
  }
  var_2 = _id_13CC1(var_2);
  var_4 = level._id_145F1.cargo_truck_mg_create.anime;
  var_5 = getanimlength(var_4);

  if(!isDefined(var_5) || var_5 <= 0) {
    return;
  }
  var_6 = var_2 / var_5;
  var_7 = var_6 - int(var_6);
  var_8 = getanglesforanimtime((-9661, -9119, -299.007), (0, 0, 0), var_4, var_7);
  level._id_145F1.gulagisspawnpositionwithinsafecircle = spawnStruct();
  level._id_145F1.gulagisspawnpositionwithinsafecircle._id_14673 = var_5;
  level._id_145F1.gulagisspawnpositionwithinsafecircle.waypoints_structs = var_6;
  level._id_145F1.gulagisspawnpositionwithinsafecircle.waypoints_reached = var_7;
  level._id_145F1.gulagisspawnpositionwithinsafecircle._id_13BF7 = var_2;
  level._id_145F1.gulagisspawnpositionwithinsafecircle.gulagfadefromblackspectatorsofplayer = var_8;
  setDvar("_encstr_8E141949237FCCB06D91315FBB9450061BCA66900BCF7EA0446C3B", var_8);
}

_id_13CC1(var_0) {
  var_1 = 425;

  if(getdvarint("_encstr_86F91BCD8D27D7BBE9A39385B49BBE2BE6460BE8E8C958A573310B8DB6", 425) != 425)
    var_1 = getdvarint("_encstr_86F91BCD8D27D7BBE9A39385B49BBE2BE6460BE8E8C958A573310B8DB6", 425);

  if(getdvarint("_encstr_BD711B7B21762F8B88891A11ABF0590F9039D2936BCE8F4440AD011659", 75) > 0) {
    var_2 = getdvarint("_encstr_BD711B7B21762F8B88891A11ABF0590F9039D2936BCE8F4440AD011659", 75);
    var_1 = var_1 + randomint(var_2);
  }

  var_3 = 10;

  for(var_4 = 0; var_4 < var_1 - var_3; var_4 = var_4 + var_3) {
    if(var_0 - var_3 > 0)
      var_0 = var_0 - var_3;
  }

  return var_0;
}

target_wavespawning_to_jammer5() {
  level._id_145F1._id_13C8D = [];

  if(isDefined(level._id_145F1._id_13215)) {
    foreach(var_1 in level._id_145F1._id_13215)
    level._id_145F1._id_13C8D[level._id_145F1._id_13C8D.size] = var_1;
  } else {
    level._id_145F1._id_13C8D = [];
    var_3 = level._id_145F1.cargo_truck_mg_create.num_players_by_truck;

    foreach(var_5 in level._id_145F1.cargo_truck_mg_create.stack_patch_thread_node) {
      var_6 = getEnt(var_3 + var_5, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
      level._id_145F1._id_13C8D[level._id_145F1._id_13C8D.size] = var_6;

      if(isDefined(level._id_145F1.cargo_truck_mg_create.num_nags)) {
        var_7 = level._id_145F1.cargo_truck_mg_create.num_nags;
        var_8 = getEnt(var_7 + var_5, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

        if(isDefined(var_8)) {
          var_6.num_hackers = var_8;
          var_8 linkTo(var_6);
        }

        var_9 = level._id_145F1.cargo_truck_mg_create.num_nodes_random_search;

        if(isDefined(var_9)) {
          var_10 = getEnt(var_9, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

          if(isDefined(var_10))
            var_10 delete();
        }
      }
    }
  }

  foreach(var_13 in level._id_145F1._id_13C8D) {
    if(!isent(var_13))
      return 0;
  }

  _id_13CC0();
  _id_13CB2();
  level._id_145F1._id_13C8D = scripts\engine\utility::array_reverse(level._id_145F1._id_13C8D);
  _id_13C8E();
  _id_13C8F();
  _id_13C91();
  _id_13CAA();

  if(getdvarint("_encstr_887818CDB1E47DBB3DA34E1696B9BEA56BD6ED13B4B14B3D56C8", 0) == 0) {
    _id_13CAB();
    _id_13C92();
    level thread _id_13CBF();
    level thread _id_13CB8();
    level thread setup_functions();
    level thread _id_13CA5();
  } else
    _id_13C9C();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    level thread _id_13588(level._id_145F1._id_13C8D);
    level thread _id_13C93();
    level thread _id_13C90();
  }

  scripts\engine\utility::flag_set("_encstr_84A3126310E493270A1B177373E37F10B72AA99B");
  return 1;
}

_id_13C8E() {
  var_0 = level._id_145F1.cargo_truck_mg_create.modelname;

  for(var_1 = 0; var_1 < level._id_145F1._id_13C8D.size; var_1++) {
    var_2 = strtok(level._id_145F1._id_13C8D[var_1].script_noteworthy, "_encstr_BA4C02DF");
    var_3 = var_2[var_2.size - 1];
    var_4 = _id_13CA2(var_0 + var_3);

    if(isent(var_4)) {
      level._id_145F1._id_13C8D[var_1].wz_tease = var_4;
      level._id_145F1._id_13C8D[var_1].wz_tease validateloadoutownership();
      var_4.write_to_dlog_runtime_struct_data = level._id_145F1._id_13C8D[var_1];
    }
  }
}

_id_13CA2(var_0) {
  var_1 = undefined;

  if(istrue(level._id_145F1.cargo_truck_mg_create._id_11C72))
    var_1 = getEnt(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  else {
    var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(isDefined(var_2)) {
      var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);

      if(var_2.script_modelname == "_encstr_A15A210C5D9B3AFF1DDA30A1A2F5B16E1BD2AF85A267D8D5C9F230788ACD6F434F7E95")
        var_1 setModel(level._id_145F1.cargo_truck_mg_create._id_136D6);
      else
        var_1 setModel(level._id_145F1.cargo_truck_mg_create._id_136D5);
    }
  }

  return var_1;
}

_id_13C8F() {
  for(var_0 = 0; var_0 < level._id_145F1._id_13C8D.size; var_0++) {
    _id_13CA9(level._id_145F1._id_13C8D[var_0]);
    level._id_145F1._id_13C8D[var_0] unmarkkeyframedmover(1);
    level._id_145F1._id_13C8D[var_0] setoverridearchetype_code(1);
    level._id_145F1._id_13C8D[var_0] clearwristwatchtime(1);
    level._id_145F1._id_13C8D[var_0] linkTo(level._id_145F1._id_13C8D[var_0].wz_tease);
  }
}

_id_13C91() {
  for(var_0 = 0; var_0 < level._id_145F1._id_13C8D.size; var_0++) {
    var_1 = _id_13CA0(var_0);

    if(getdvarint("_encstr_8BA21933AAA3CF2F90C3C259E7138F8B38FBB297F7738247CBB1AB", 0))
      var_2 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
    else
      var_2 = level._id_145F1._id_13CBC[var_0];

    var_3 = level._id_145F1.animents[var_1] gettagorigin(var_2);
    var_4 = level._id_145F1._id_13CBD[var_0];
    level._id_145F1._id_13C8D[var_0].wz_tease unmarkkeyframedmover(1);
    level._id_145F1._id_13C8D[var_0].wz_tease setoverridearchetype_code(1);
    level._id_145F1._id_13C8D[var_0].wz_tease clearwristwatchtime(1);
    level._id_145F1._id_13C8D[var_0].wz_tease.origin = var_3;

    if(getdvarint("_encstr_B6F5199BDEE36F8BB0D896CA88A0A61AABFF08A705E35D418AF353", 0) > 0) {
      if(getdvarint("_encstr_8BA21933AAA3CF2F90C3C259E7138F8B38FBB297F7738247CBB1AB", 0) > 0) {
        level._id_145F1._id_13C8D[var_0].wz_tease linkTo(level._id_145F1.animents[var_1], "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_4, (0, 0, 0));
        continue;
      }

      level._id_145F1._id_13C8D[var_0].wz_tease linkTo(level._id_145F1.animents[var_1], var_2, var_4, (0, 0, 0));
    }
  }
}

_id_13CA9(var_0) {
  var_0.vehiclename = "_encstr_85120CA217730F18915BDD97B4F5";
  var_0.wz_tease.vehiclename = "_encstr_85120CA217730F18915BDD97B4F5";
  var_0 thread _id_13CBE();
  var_0.wz_tease thread _id_13CBE();
}

_id_13CBE() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

_id_13CBA() {
  level notify("_encstr_AD440FB730582FBEABE799B98B9EA1FBC0");
}

_id_13C93() {
  if(getdvarint("_encstr_B6C918E66CE4AFDDF4479316D2CD7DB9DB0BB6DADB364EB0472B", 0) > 0) {
    return;
  }
  var_0 = level._id_145F1._id_13C8D[1];
  var_1 = (20, 0, 5);
  var_2 = (0, 90, 0);
  var_3 = rotatevector(var_2, var_0.angles);
  var_4 = "_encstr_A9D41CC7776891E85EBA389F017A6167BF724B1FF3CFCFFF878E5A12BD21";
  var_5 = easepower(var_4, var_0.origin + var_1, var_3);
  var_5 thread _id_13CB3(var_0, var_1, var_3);
  var_0.brradialspawnorigin = var_5;
}

_id_13CC4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  waitframe();
  _id_13C9E();
  level waittill(var_0);
  _id_13C9F();
}

_id_13C9F() {
  if(istrue(level._id_145F1.monitor_game_end_on_front_truck_death)) {
    level._id_145F1.monitor_game_end_on_front_truck_death = undefined;

    foreach(var_1 in level._id_145F1._id_13C8D) {
      if(isDefined(var_1.wz_tease)) {
        var_1.wz_tease show();
        var_1.wz_tease solid();
        var_1 solid();

        if(isDefined(var_1._id_13CC3))
          var_1._id_13CC3.spawner_debug_model = 1;

        if(isDefined(var_1.brradialspawnorigin))
          var_1.brradialspawnorigin setscriptablepartstate("_encstr_83FC16A06FA4E829AA2A1308C64253902FAB78D8E34F612F", "_encstr_B2300BA557D9A6F3D9ADF9E0D4");
      }
    }
  }
}

_id_13C9E() {
  if(!istrue(level._id_145F1.monitor_game_end_on_front_truck_death)) {
    level._id_145F1.monitor_game_end_on_front_truck_death = 1;

    foreach(var_1 in level._id_145F1._id_13C8D) {
      if(isDefined(var_1.wz_tease)) {
        var_1.wz_tease hide();
        var_1.wz_tease notsolid();
        var_1 notsolid();

        if(isDefined(var_1._id_13CC3))
          var_1._id_13CC3.spawner_debug_model = 0;

        if(isDefined(var_1.brradialspawnorigin))
          var_1.brradialspawnorigin setscriptablepartstate("_encstr_83FC16A06FA4E829AA2A1308C64253902FAB78D8E34F612F", "_encstr_85EA0C2DDF512E8BA12561686D8C");
      }
    }
  }
}

_id_13CAB() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_85120CA217730F18915BDD97B4F5", 1);
  var_0.challengeevaluator = 1;
  var_0.keycardlocs_chosen = 1;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 8;
  var_0.isallowedweapon = 25;
  var_0.isakimbo = 100;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 1;
  var_0.setup_techo_lmgs = ::setup_hacks;
}

setup_hacks(var_0, var_1) {
  var_2 = var_0.ent[0];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_0.ent[1];
  var_4 = var_3 getentitynumber();

  if(isDefined(var_2._id_14100) && isDefined(var_2._id_14100.size) && var_2._id_14100.size > 0) {
    if(isDefined(var_2._id_14100[var_4]))
      return 0;
  }

  if(isDefined(var_3.velocity))
    var_0.velocity[1] = var_3.velocity;
  else if(isDefined(var_3 getlinkedchildren())) {
    var_5 = undefined;
    var_6 = var_3 getlinkedchildren();

    foreach(var_8 in var_6) {
      if(isDefined(var_8.velocity)) {
        var_5 = var_8.velocity;
        var_0.velocity[1] = var_5;
        break;
      }
    }
  }

  var_10 = 1;
  var_11 = 1;
  var_12 = 1;
  var_13 = 1;
  var_14 = 20;
  var_15 = 0.5;
  var_16 = 30;
  var_17 = length(var_0.velocity[0]);
  var_10 = scripts\engine\math::remap(var_17, 0, 600, var_13, var_14);
  var_0._id_14286 = [];
  var_0._id_14286[0] = vectorNormalize(var_0.velocity[0]);
  var_0._id_14286[1] = vectorNormalize(var_0.velocity[1]);
  var_18 = scripts\engine\math::anglebetweenvectorsunit(var_0._id_14286[0], var_0._id_14286[1]);
  var_11 = scripts\engine\math::remap(var_18, 0, 180, var_15, var_16);

  if(getdvarfloat("_encstr_A65817E6D84EFAEED38EE485D2CDAFB3AC8623DAECB657638E", -1) != -1)
    var_12 = getdvarfloat("_encstr_A65817E6D84EFAEED38EE485D2CDAFB3AC8623DAECB657638E", -1);

  var_19 = var_2.health;
  var_20 = 10;
  var_21 = var_20 * var_11 * var_10 * var_12;
  var_22 = var_21;
  var_23 = var_2.health;

  if(var_2.health > 5 && level._id_145F1.type != "_encstr_842408C29CB6DB392B32")
    var_23 = var_2.health - 5;

  if(var_21 > var_23)
    var_21 = var_23;

  var_2 dodamage(var_21, var_3.origin, var_3, var_3, "_encstr_8D4E0A501FCB898912CB3FA3");

  if(var_2.health < var_19)
    level thread _id_14112(var_2, var_3, 1);

  return var_22;
}

_id_14112(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_14100))
    var_0._id_14100 = [];

  var_3 = var_1 getentitynumber();
  var_0._id_14100[var_3] = var_1;
  wait(var_2);

  if(isDefined(var_0) && isDefined(var_0._id_14100))
    var_0._id_14100[var_3] = undefined;

  if(isDefined(var_0) && isDefined(var_0._id_14100) && var_0._id_14100.size == 0)
    var_0._id_14100 = undefined;
}

setup_functions() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AD440FB730582FBEABE799B98B9EA1FBC0");
  var_0 = level._id_145F1._id_13C8D[0];
  var_1 = var_0 getentitynumber();
  var_2 = 150;

  if(getdvarfloat("_encstr_BA201CFA49B07F6B2AF9C3872BD811BE58503583A0D80D8206EB835F0B7E", 150) != 150)
    var_2 = getdvarfloat("_encstr_BA201CFA49B07F6B2AF9C3872BD811BE58503583A0D80D8206EB835F0B7E", 150);

  var_3 = physics_createcontents(["_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_4 = (var_2, var_2, 200);
  var_5 = [var_0, var_0.wz_tease];

  for(;;) {
    var_6 = var_0.origin + rotatevector((375, 0, -100), var_0.angles);
    var_7 = var_6 - var_4;
    var_8 = var_6 + var_4;
    var_9 = physics_aabbbroadphasequery(var_7, var_8, var_3, var_5);

    for(var_10 = 0; var_10 < var_9.size; var_10++) {
      var_11 = var_9[var_10];

      if(istrue(var_11._id_11B0D)) {
        continue;
      }
      if(isDefined(var_11._id_13CC6) && isDefined(var_11._id_13CC6.size)) {
        if(var_11._id_13CC6.size > 0) {
          if(isDefined(var_11._id_13CC6[var_1]))
            continue;
        }
      }

      if(isDefined(var_11.equipmentref)) {
        if(var_11.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506") {
          if(!var_11.collision istouching(var_0)) {
            continue;
          }
          var_11 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
          var_11._id_11B0D = 1;
          continue;
        }
      }

      if(!var_11 istouching(var_0)) {
        continue;
      }
      if(isDefined(var_11.cratetype) && var_11.cratetype == "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D") {
        _id_13CA4(var_11, var_0, var_6);
        continue;
      }

      if(scripts\mp\utility\entity::isturret(var_11)) {
        if(istrue(var_11.usedropspawn)) {
          continue;
        }
        var_11 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 1);
        var_11._id_11B0D = 1;
        continue;
      }

      if(_id_13C98(var_11)) {
        if(isDefined(var_11.health) && var_11.health > 0) {
          var_11 dodamage(var_11.health + 100, var_0.origin);
          var_11._id_11B0D = 1;
        }
      }
    }

    waitframe();
  }
}

_id_13C98(var_0) {
  if(!isDefined(var_0.weapon_name))
    return 0;

  var_1 = 0;

  switch (var_0.weapon_name) {
    case "_encstr_81BE0DD71ADF8095A15AF84861C549":
    case "_encstr_92BC0F408BC20108238458CE67F3F6F32A":
      var_1 = 1;
      break;
  }

  if(var_1)
    return 1;

  return 0;
}

vehicle_collision_loadtablecell(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_13CC6))
    var_0._id_13CC6 = [];

  var_3 = var_1 getentitynumber();
  var_0._id_13CC6[var_3] = var_1;
  wait(var_2);

  if(isDefined(var_0) && isDefined(var_0._id_13CC6))
    var_0._id_13CC6[var_3] = undefined;

  if(isDefined(var_0) && isDefined(var_0._id_13CC6) && var_0._id_13CC6.size == 0)
    var_0._id_13CC6 = undefined;
}

_id_13CA4(var_0, var_1, var_2) {
  if(!istrue(var_0.spawn_killstreak_package_on_ground)) {
    var_3 = var_1.velocity * 150;
    var_0 playSound("_encstr_BEEB1CF5796146279E0141BBE97E77BEC8CB4F48E3784C17CB38ABD2B1CD");
    var_0 physicslaunchserver(var_2, var_3);
    var_0.spawn_killstreak_package_on_ground = 1;
    level thread vehicle_collision_loadtablecell(var_0, var_1, 1);
  } else {
    var_0 scripts\cp_mp\killstreaks\airdrop::destroycrate();
    var_0._id_11B0D = 1;
  }
}

_id_13CA5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AD440FB730582FBEABE799B98B9EA1FBC0");

  if(!isDefined(level.mines))
    level.mines = [];

  var_0 = level._id_145F1._id_13C8D[0];
  var_1 = var_0 getentitynumber();
  var_2 = 150;

  if(getdvarfloat("_encstr_BA201CFA49B07F6B2AF9C3872BD811BE58503583A0D80D8206EB835F0B7E", 150) != 150)
    var_2 = getdvarfloat("_encstr_BA201CFA49B07F6B2AF9C3872BD811BE58503583A0D80D8206EB835F0B7E", 150);

  var_3 = var_2 - 25;
  var_4 = var_3 * var_3;

  for(;;) {
    var_5 = level.mines;

    if(var_5.size > 0) {
      var_6 = var_0.origin + rotatevector((375, 0, -100), var_0.angles);

      foreach(var_8 in var_5) {
        if(!isDefined(var_8)) {
          continue;
        }
        if(istrue(var_8._id_11B0D)) {
          continue;
        }
        if(distance2dsquared(var_8.origin, var_6) > var_4) {
          continue;
        }
        if(distancesquared(var_8.origin, var_6) > var_4) {
          continue;
        }
        if(isDefined(var_8.weapon_name)) {
          if(var_8.weapon_name == "_encstr_92EA0A290B32FF88A90170EB") {
            var_8 scripts\mp\equipment\trophy_system::sweeptrophy();
            var_8._id_11B0D = 1;
            continue;
          }

          if(var_8.weapon_name == "_encstr_ACC40CC1F8A321601715CFBFE0EA") {
            var_8 scripts\mp\equipment\claymore::sweepclaymore();
            var_8._id_11B0D = 1;
            continue;
          }

          if(var_8.weapon_name == "_encstr_81430B218B3F7018458997D78A") {
            var_8 scripts\mp\equipment\at_mine::at_mine_destroy();
            var_8._id_11B0D = 1;
            continue;
          }

          if(var_8.weapon_name == "_encstr_86EE1373632E69F1E0E3DFE2FB911473F3F7B78FED") {
            var_8 scripts\mp\equipment\tac_insert::deletetacinsert();
            var_8._id_11B0D = 1;
          }
        }
      }
    }

    waitframe();
  }
}

_id_13CAA() {
  var_0 = 0;

  foreach(var_2 in level._id_145F1._id_13C8D) {
    var_3 = var_2.script_noteworthy;
    var_4 = var_3 + "_encstr_B88506D1A8909733";
    var_5 = scripts\engine\utility::getStructArray(var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_0 = var_0 + var_5.size;
  }

  level._id_145F1._id_13BFB = var_0;
  _id_13CAC(level._id_145F1._id_13C8D);

  if(isDefined(level._id_145F1._id_13C8D)) {
    level._id_145F1._id_13C8D[0].maphint_keypadscriptableused = (-95, -5, 200);
    level._id_145F1._id_13C8D[0].manageworldspawnedprojectiles = (0, 180, 0);
    level._id_145F1._id_13C8D[0].mapnamefilter = 3;
    level._id_145F1._id_13C8D[1].maphint_keypadscriptableused = (-135, -50, 49);
    level._id_145F1._id_13C8D[1].manageworldspawnedprojectiles = (0, 80, 0);
    level._id_145F1._id_13C8D[1].mapnamefilter = 0;
    level._id_145F1._id_13C8D[5].maphint_keypadscriptableused = (-80, -50, 49);
    level._id_145F1._id_13C8D[5].manageworldspawnedprojectiles = (0, 70, 0);
    level._id_145F1._id_13C8D[5].mapnamefilter = 0;
    level._id_145F1._id_13C8D[7].maphint_keypadscriptableused = (-150, 45, 49);
    level._id_145F1._id_13C8D[7].manageworldspawnedprojectiles = (0, 180, 0);
    level._id_145F1._id_13C8D[7].mapnamefilter = 0;
  }
}

_id_12432() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_set("_encstr_931916C36A631BF1787AC0278A78D7E51FB6537703C3E203");
  level thread _id_13CB1();
  level thread _id_13CAD(3);
  level waittill("_encstr_AD440FB730582FBEABE799B98B9EA1FBC0");
  level thread _id_13CAE();
}

_id_13CAD(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AD440FB730582FBEABE799B98B9EA1FBC0");
  scripts\engine\utility::flag_wait("_encstr_955B15437A0DF36608950F39BD202DFFB710BA2BE0E86F");

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret._id_13CD1) && level.disable_super_in_turret._id_13CD1 == "_encstr_842408C29CB6DB392B32")
    var_0 = 0;

  wait(var_0);
  var_1 = level._id_145F1._id_13C8D[1];
  var_2 = "_encstr_B40101";

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret._id_13CD1))
    var_2 = level.disable_super_in_turret._id_13CD1;

  var_3 = level._id_145F1.cargo_truck_mg_create._id_119A4;

  foreach(var_1 in level._id_145F1._id_13C8D) {
    var_5 = (0, 0, 300);
    var_6 = (0, 0, 0);
    var_7 = rotatevector(var_6, var_1.angles);

    if(var_2 == "_encstr_842408C29CB6DB392B32")
      var_8 = "_encstr_BDD60E89937D0BE4B57BC947C90B2DB9";
    else
      var_8 = "_encstr_82BC0EA97AB7F05FD367DFE1DB0A9340";

    if(isDefined(var_1.script_noteworthy) && var_2 == "_encstr_842408C29CB6DB392B32" && var_1.script_noteworthy == var_3)
      var_8 = "_encstr_B23615422BC8EFF218A7F2FC7590FC0B10613A9AD038B7";
    else if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == var_3)
      var_8 = "_encstr_8E5615586B9997799307D0550A07A04571E2B0E8726DC3";

    var_9 = easepower(var_8, var_1.origin + var_5, var_7);
    var_9 thread _id_13CB3(var_1, var_5, var_7);

    if(var_2 == "_encstr_842408C29CB6DB392B32")
      var_9 setscriptablepartstate("_encstr_BDD60E89937D0BE4B57BC947C90B2DB9", "_encstr_BE8B08E323FB2BCD6268");
    else
      var_9 setscriptablepartstate("_encstr_82BC0EA97AB7F05FD367DFE1DB0A9340", "_encstr_BE8B08E323FB2BCD6268");

    var_9.init_weapon_placements = 1;
    var_1.deletesolospawnstruct = var_9;
  }

  scripts\engine\utility::flag_set("_encstr_A9ED17D3BAEBB329D935A7E3CBDF78A6E6E1242BEB07BB9D19");
}

_id_13CAE() {
  foreach(var_1 in level._id_145F1._id_13C8D) {
    if(isDefined(var_1.deletesolospawnstruct)) {
      if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret._id_13CD1) && level.disable_super_in_turret._id_13CD1 == "_encstr_842408C29CB6DB392B32") {
        var_1.deletesolospawnstruct setscriptablepartstate("_encstr_BDD60E89937D0BE4B57BC947C90B2DB9", "_encstr_95DF070DD22319CA9B");
        continue;
      }

      var_1.deletesolospawnstruct setscriptablepartstate("_encstr_82BC0EA97AB7F05FD367DFE1DB0A9340", "_encstr_95DF070DD22319CA9B");
    }
  }
}

_id_13CAC(var_0) {
  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;
    var_4 = var_3 + "_encstr_B88506D1A8909733";
    var_5 = scripts\engine\utility::getStructArray(var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2._id_11A43 = [];

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = var_5[var_6].origin - var_2.origin;
      var_8 = rotatevectorinverted(var_7, var_2.angles);
      var_2._id_11A43[var_6] = var_8;
    }
  }
}

_id_13588(var_0) {
  if(getdvarint("_encstr_B8E6171A762D39A79A782B6FB8305722C59F2317E69192EF60", 1) == 0) {
    return;
  }
  scripts\engine\utility::flag_wait("_encstr_84A3126310E493270A1B177373E37F10B72AA99B");
  var_1 = 4;
  var_2 = 0;
  var_3 = 0;

  if(getdvarint("_encstr_996B177786D34133B0C9A6F0135A56D835FF3D7626DFB32088", 0) > 0)
    var_1 = getdvarint("_encstr_996B177786D34133B0C9A6F0135A56D835FF3D7626DFB32088", 0);

  if(var_1 > level._id_145F1._id_13BFB)
    var_1 = level._id_145F1._id_13BFB;

  foreach(var_5 in var_0) {
    var_6 = var_5.script_noteworthy;
    var_7 = var_6 + "_encstr_B88506D1A8909733";
    var_8 = scripts\engine\utility::getStructArray(var_7, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    for(var_9 = 0; var_9 < var_8.size; var_9++) {
      var_10 = "_encstr_B4D90E9636AFD277F08057BF3029380A";

      if(var_3 > level._id_145F1._id_13BFB - var_1) {
        if(var_2 < var_1) {
          var_10 = "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D";
          var_2++;
        }
      } else if(var_2 < var_1 && scripts\engine\utility::cointoss()) {
        var_10 = "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D";
        var_2++;
      }

      var_11 = var_5._id_11A43[var_9];
      var_12 = var_8[var_9].angles;
      var_13 = easepower(var_10, var_5.origin + var_11, var_12);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_13);
      var_13 thread _id_13CB3(var_5, var_11, var_12);
      var_13.init_weapon_placements = 1;

      if(var_13 getscriptablehaspart("_encstr_AD9B0589ED9197"))
        var_13 setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_ACAE0DEFDB15AF50C5B1A047569F6D");

      var_3++;
      waitframe();
    }
  }
}

_id_13CB3(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  self validatecollision(var_0, var_1, var_2);
}

_id_13C92() {
  foreach(var_1 in level._id_145F1._id_13C8D) {
    var_2 = var_1.script_noteworthy;
    var_3 = var_2 + "_encstr_9760122791E82627B066F2BB48986B11900B8274";
    var_4 = getEnt(var_3, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(isent(var_4)) {
      var_1._id_13CC3 = var_4;
      var_1._id_13CC3 enablelinkTo();
      var_1._id_13CC3 linkTo(var_1);
      var_1._id_13CC3 thread _id_13CA7(var_1);
    }
  }
}

_id_13C9C() {
  foreach(var_1 in level._id_145F1._id_13C8D) {
    var_2 = var_1.script_noteworthy;
    var_3 = var_2 + "_encstr_9760122791E82627B066F2BB48986B11900B8274";
    var_4 = getEnt(var_3, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(isDefined(var_4))
      var_4 delete();
  }
}

_id_13C90() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AD440FB730582FBEABE799B98B9EA1FBC0");
  var_0 = getdvarint("_encstr_92EB1A274FE36870AACB93C9B496F9BEEA93D1ADDF5A4508D8E63B20", 0);

  if(var_0 == 0) {
    return;
  }
  var_1 = level._id_145F1._id_13C8D[3];

  if(!isDefined(var_1) || !isent(var_1)) {
    return;
  }
  var_2 = (-85, 0, -25);
  var_3 = (0, 0, 0);
  var_4 = rotatevector(var_3, var_1.angles);
  var_5 = "_encstr_BE1E194A0E91B877C347FD581559B387ADBB77AD4E8CDFA55822FB";
  var_6 = 45;
  var_7 = getdvarint("_encstr_BAD91AC84FDB673F4B8373865BFB97F36802189A4962AB0B50014A6B", 60);

  if(var_7 != 60)
    var_6 = var_7;

  level._id_145F1.mark_armor = 1;
  var_8 = getdvarint("_encstr_A5471582D0A28140D0CBED2BC47349D0A755A320D85DC2", 1);

  if(var_8 == 0)
    level._id_145F1.mark_armor = 0;

  var_9 = getdvarint("_encstr_8A9E15575FAE61E7580BE22E4010070A88EB9BAFC7581A", 1);

  if(var_9 == 1)
    level._id_145F1.maphint_debugthink = 1;

  var_1._id_13C9A = [];
  level._id_145F1.hotfootlastposition = 0;
  level._id_145F1.hotfootdisttraveledsq = 0;

  if(!isDefined(level._id_145F1.funcs))
    level._id_145F1.funcs = spawnStruct();

  level._id_145F1.funcs.c130airdrop_deleteatlifetime = _calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_deleteatlifetime;
  level._id_145F1.funcs.c130airdrop_createpath = _calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_createpath;
  level thread _id_13CA8();
  scripts\engine\utility::flag_wait("_encstr_A9ED17D3BAEBB329D935A7E3CBDF78A6E6E1242BEB07BB9D19");

  for(;;) {
    while(istrue(level._id_145F1.choosefinalkillcam))
      wait 5;

    var_10 = easepower(var_5, var_1.origin + var_2, var_4);
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_10);
    var_10 validatecollision(var_1, var_2, var_4);
    var_10._id_11FF8 = 1;
    var_10.keepinmap = 1;
    var_10.trackriotshield_grenadepullbackforc4 = _calloutmarkerping_handleluinotify_enemyrepinged::manageworldspawnedbolts;
    var_10.init_weapon_placements = 1;

    if(soundexists("_encstr_93EA15233846C0227F0A9BD2782FBA96A98087BFB9330C"))
      playsoundatpos(var_1.origin + var_2, "_encstr_93EA15233846C0227F0A9BD2782FBA96A98087BFB9330C");

    var_1._id_13C9A[var_1._id_13C9A.size] = var_10;
    level._id_145F1._id_13C99 = var_10;
    level._id_145F1 waittill("_encstr_BE851CF43AB8B3A8AF09400FA60BE0E821F8F97F4B710FFF970BE1D88350", var_11);

    if(isDefined(var_11))
      level._id_145F1.hotfootdisttraveledsq++;

    if(isDefined(var_11) && isDefined(var_11.result) && var_11.result == "_encstr_88E30897BDF1B71F7823") {
      level._id_145F1.hotfootlastposition++;

      if(getdvarint("_encstr_956014DCB14EEBDDA78E270BB437BE46DEB6D8F6DB1D", 1) > 0) {
        var_11.itemsdropped = 0;
        var_11.count = 0;
        var_11.origin = var_11._id_12D2E;
        var_11.angles = var_11._id_12D2B;
        var_11.intel_collected = 0;
        var_12 = var_11.intel_collected;
        var_13 = getdvarint("_encstr_B60B1A9BBAD061CBC8BD45AE5FD51FB39F5A85608D3BD1374E93D7D8", 2);
        var_14 = getdvarint("_encstr_A30617C74FF048DBF81B26E7718AB802FDA7E390BABDAE2E13", 1);
        var_15 = getdvarint("_encstr_ADF51890877AEEEF5BEBD65784327731DF17F0F8CF14A6DFF2D7", 1);
        var_16 = getdvarint("_encstr_BE0617224EE5F17F42B0D3A760F81F0A87D16D5D204149A3E8", 1);
        var_17 = getdvarint("_encstr_880617D6B64BD78B1A8BC040E756C6E9E25DC1500D830FF3E6", 1);
        var_18 = getdvarint("_encstr_AF06175BEE4AC184E39BB59BC78AD8A0FFC52050159409310A", 1);
        var_19 = [];

        for(var_20 = 0; var_20 < var_13; var_20++)
          var_19[var_19.size] = "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69";

        for(var_20 = 0; var_20 < var_14; var_20++)
          var_19[var_19.size] = "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";

        for(var_20 = 0; var_20 < var_15; var_20++)
          var_19[var_19.size] = "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";

        for(var_20 = 0; var_20 < var_16; var_20++)
          var_19[var_19.size] = "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18";

        if(scripts\engine\utility::cointoss()) {
          for(var_20 = 0; var_20 < var_17; var_20++)
            var_19[var_19.size] = "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6";
        } else {
          for(var_20 = 0; var_20 < var_18; var_20++)
            var_19[var_19.size] = "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014";
        }

        var_21 = getdvarint("_encstr_9A911BDA69905F8BCA1923670BF831DCD03095A580F8170327B74B0F1B", 0);
        var_22 = getDvar("_encstr_958E1CCDD8E4AFDDE91DE42C4B377D91BD6B1BDBF647F5DC07FAB985DA95", "_encstr_B40101");

        if(var_21 > 0 && var_22 != "_encstr_B40101") {
          for(var_20 = 0; var_20 < var_21; var_20++)
            var_19[var_19.size] = var_22;
        }

        if(isDefined(var_19) && var_19.size > 0)
          var_23 = var_11 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A02(var_19);
      }
    }

    wait(var_6);
  }
}

_id_13CA8() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AD440FB730582FBEABE799B98B9EA1FBC0");

  for(;;) {
    if(_calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_createpath()) {
      level._id_145F1.choosefinalkillcam = 1;

      if(isDefined(level._id_145F1._id_13C99)) {
        var_0 = level._id_145F1._id_13C99;
        var_1 = var_0 getscriptablepartstate("_encstr_BE1E194A0E91B877C347FD581559B387ADBB77AD4E8CDFA55822FB");

        if(var_1 == "_encstr_BE8B08E323FB2BCD6268") {
          var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::lastgoodjobplayer();

          if(isDefined(level._id_145F1._id_13C99))
            level._id_145F1._id_13C99 = undefined;

          level._id_145F1 notify("_encstr_BE851CF43AB8B3A8AF09400FA60BE0E821F8F97F4B710FFF970BE1D88350");
        }
      }
    } else
      level._id_145F1.choosefinalkillcam = 0;

    wait 5;
  }
}

_id_13CA7(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 1;

  if(getdvarfloat("_encstr_9AE01A97DED517402B2D8B58EB9011AB554FCF8A8A11127CE525C9A3", -1) != -1)
    var_1 = getdvarfloat("_encstr_9AE01A97DED517402B2D8B58EB9011AB554FCF8A8A11127CE525C9A3", -1);

  self.spawner_debug_model = 1;
  self.vehicle_collision_getignoreevent = 1;

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!istrue(self.spawner_debug_model)) {
      continue;
    }
    if(isPlayer(var_2) && isalive(var_2) && (istrue(var_2.inlaststand) || var_2 istouching(var_0) || var_2 istouching(var_0.wz_tease)))
      var_2 dodamage(var_2.health + 1000 * var_1, self.origin, var_2, self, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
  }
}

_id_13CBF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(level._id_145F1.type == "_encstr_842408C29CB6DB392B32") {
    return;
  }
  scripts\engine\utility::flag_wait("_encstr_955B15437A0DF36608950F39BD202DFFB710BA2BE0E86F");
  wait 0.1;

  if(getdvarint("_encstr_ACB51443213059EF60BB5A426A382FF9DDDB997BEC03", -1) != -1) {
    var_0 = level._id_145F1._id_13C8D[0].wz_tease;
    var_1 = scripts\engine\utility::getfx("_encstr_813F14B52A48A97E83B1B37B3A8720F1A79E2F03AEF7");
    playFXOnTag(var_1, var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_2 = scripts\engine\utility::getfx("_encstr_937A15EC4E0F7D8927BE1D93C24B73F5998D0BD11395C8");

    for(var_3 = 1; var_3 < level._id_145F1._id_13C8D.size; var_3++) {
      var_4 = level._id_145F1._id_13C8D[var_3].wz_tease;
      playFXOnTag(var_2, var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    }
  } else {
    foreach(var_6 in level._id_145F1._id_13C8D) {
      if(var_6.wz_tease getscriptablehaspart("_encstr_A52E0BD30866FC1ED8EFD9A303"))
        var_6.wz_tease setscriptablepartstate("_encstr_A52E0BD30866FC1ED8EFD9A303", "_encstr_ACC107AD988D31CD07");
    }
  }
}

_id_13CB8() {
  if(!isDefined(level.disable_super_in_turret) || !isDefined(level.disable_super_in_turret._id_13CD1) || level.disable_super_in_turret._id_13CD1 != "_encstr_842408C29CB6DB392B32") {
    level endon("_encstr_9B1D0BC7932875276230426AA1");
    scripts\engine\utility::flag_wait("_encstr_955B15437A0DF36608950F39BD202DFFB710BA2BE0E86F");
    wait 0.1;

    for(var_0 = 0; var_0 < level._id_145F1._id_13C8D.size; var_0++) {
      if(soundexists("_encstr_96B613CE2B0DBEC60B9CB3B71DE40BD2E6D7D8387D" + var_0))
        level._id_145F1._id_13C8D[var_0].wz_tease playLoopSound("_encstr_96B613CE2B0DBEC60B9CB3B71DE40BD2E6D7D8387D" + var_0);
    }
  }
}

_id_13CA6(var_0) {
  var_1 = level._id_145F1._id_13C8D[0].wz_tease;
  var_1 playsoundonmovingent("_encstr_A28914D9CA86FA1AB7E4CDD7C6589CB3DE8E390B2DE6");
}

_id_13CB1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 20;

  if(getdvarint("_encstr_8D3C1786E61B87DB4AFBB010B766162302CBFEB7BFC2594121", -1) != -1)
    var_0 = getdvarint("_encstr_8D3C1786E61B87DB4AFBB010B766162302CBFEB7BFC2594121", -1);

  if(var_0 > 0)
    wait(var_0);

  if(getdvarint("_encstr_A9BA1833693E77D3C0F15249E34891C3ED01FA7A7616038E50DD", 0)) {
    var_1 = getEnt("_encstr_96650DDC9E89070527889AA3811B6A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(isDefined(var_1)) {
      var_2 = spawnStruct();
      var_2.origin = var_1.origin + (0, 0, 58);
      var_2.spawntype = "_encstr_A390072B07566805D8";

      if(isDefined(var_1.angles))
        var_2.angles = var_1.angles;

      var_3 = scripts\cp_mp\vehicles\jeep::jeep_create(var_2);
      wait 0.1;
      var_3 vehicle_turnengineoff();
      wait 1;
    }
  }

  scripts\engine\utility::flag_set("_encstr_955B15437A0DF36608950F39BD202DFFB710BA2BE0E86F");
  var_4 = _id_13CA3();
  var_5 = level._id_145F1.animstruct.origin;
  var_6 = level._id_145F1.animstruct.angles;

  for(var_7 = 0; var_7 < var_4; var_7++) {
    level._id_145F1.animents[var_7].updateplayerleaderboardstatsinternal = 1;
    level._id_145F1.animents[var_7] notsolid();
    level._id_145F1.animents[var_7] dontinterpolate();
    var_8 = level._id_145F1.animents[var_7].bullet;
    level._id_145F1.animstruct thread scripts\common\anim::anim_loop_solo(level._id_145F1.animents[var_7], var_8);

    if(getdvarint("_encstr_86711858C62A10273B8B108731C85F2EB708C11F072320E16A2B", 1) > 0) {
      level._id_145F1.animstruct thread _id_13CB5(level._id_145F1.animents[var_7], var_8);
      continue;
    }

    var_9 = getdvarfloat("_encstr_837A189327703137D27BDB1220205FB230A13107C7108337FE53", -1);

    if(var_9 >= 0)
      level._id_145F1.animstruct thread _id_13CB6(level._id_145F1.animents[var_7], var_8, var_9);
  }

  if(getdvarint("_encstr_B6F5199BDEE36F8BB0D896CA88A0A61AABFF08A705E35D418AF353", 0) == 0) {
    for(;;) {
      for(var_7 = 0; var_7 < level._id_145F1._id_13C8D.size; var_7++) {
        var_10 = level._id_145F1._id_13CBD[var_7];
        var_11 = level._id_145F1._id_13CBC[var_7];
        var_12 = _id_13CA0(var_7);
        var_13 = level._id_145F1.animents[var_12] gettagorigin(var_11);
        var_14 = level._id_145F1.animents[var_12] gettagangles(var_11);
        var_15 = anglestoaxis(var_14);
        var_13 = var_13 + var_15["_encstr_B42E085325A82CB3F221"] * var_10[0];
        var_13 = var_13 + var_15["_encstr_8253060E2B5FE330"] * var_10[1];
        var_13 = var_13 + var_15["_encstr_87070365F7"] * var_10[2];
        var_16 = 0.1;
        var_13 = vectorlerp(level._id_145F1._id_13C8D[var_7].wz_tease.origin, var_13, var_16);
        var_14 = scripts\engine\math::fake_slerp(level._id_145F1._id_13C8D[var_7].wz_tease.angles, var_14, var_16);
        level._id_145F1._id_13C8D[var_7].wz_tease.origin = var_13;
        level._id_145F1._id_13C8D[var_7].wz_tease.angles = var_14;
      }

      waitframe();
    }
  }
}

_id_13CB2() {
  setdvarifuninitialized("_encstr_8BA21933AAA3CF2F90C3C259E7138F8B38FBB297F7738247CBB1AB", 0);
  level._id_145F1._id_13CBC = [];
  level._id_145F1._id_13CBC[level._id_145F1._id_13CBC.size] = "_encstr_88F41F67954370BED13985969BFA8DDBB1DB5B7BE8A5CE56F5A6B7A5DCA37D814C";
  level._id_145F1._id_13CBC[level._id_145F1._id_13CBC.size] = "_encstr_8AF51CB3AC0D707D3A4EB04BE67DCC630B1D135619F535DBA537A3FA18C4";
  level._id_145F1._id_13CBC[level._id_145F1._id_13CBC.size] = "_encstr_85F51CA4C71AE97EE4438830CB379189522B16A51F013520D11B28899A72";
  level._id_145F1._id_13CBC[level._id_145F1._id_13CBC.size] = "_encstr_87991995EFFA6379FC12B9B03DEFA077F3334FD5AFB237E83F7AAB";
  level._id_145F1._id_13CBC[level._id_145F1._id_13CBC.size] = "_encstr_ADF51CB89F6002BFBB6A5F5345210530D17380A8E33F4DE7B295CD70CA9F";
  level._id_145F1._id_13CBC[level._id_145F1._id_13CBC.size] = "_encstr_97F51CB3E2ACC95613BA7F638E9739D9565B38100A89A5683FDEFD70C8C2";
  level._id_145F1._id_13CBC[level._id_145F1._id_13CBC.size] = "_encstr_AAF51CB390030A99C47288C318468154E73BB8B903197A7F18AB83C19ADD";
  level._id_145F1._id_13CBC[level._id_145F1._id_13CBC.size] = "_encstr_81F51CBB632CB0D71B529FD1C5378275A1E3A150E03F131258B85B7F0FE2";
  level._id_145F1._id_13CBD = [];
  level._id_145F1._id_13CBD[level._id_145F1._id_13CBD.size] = (0, 0, 0);
  level._id_145F1._id_13CBD[level._id_145F1._id_13CBD.size] = (0, 0, 0);
  level._id_145F1._id_13CBD[level._id_145F1._id_13CBD.size] = (0, 0, 0);
  level._id_145F1._id_13CBD[level._id_145F1._id_13CBD.size] = (0, 0, 0);
  level._id_145F1._id_13CBD[level._id_145F1._id_13CBD.size] = (0, 0, 0);
  level._id_145F1._id_13CBD[level._id_145F1._id_13CBD.size] = (0, 0, 0);
  level._id_145F1._id_13CBD[level._id_145F1._id_13CBD.size] = (0, 0, 0);
  level._id_145F1._id_13CBD[level._id_145F1._id_13CBD.size] = (0, 0, 0);
  waitframe();
  var_0 = (-9661, -9119, -299.007);
  var_1 = (0, 0, 0);

  if(isDefined(level._id_145F1.bunker11vo))
    var_0 = level._id_145F1.bunker11vo;

  level._id_145F1.animstruct = spawnStruct();
  level._id_145F1.animstruct.origin = var_0;
  level._id_145F1.animstruct.angles = var_1;
  level._id_145F1.animents = [];
  var_2 = _id_13CA3();
  var_3 = level._id_145F1.cargo_truck_mg_create.cargo_truck_mg_cp_create;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    level._id_145F1.animents[var_4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level._id_145F1.animstruct.origin);

    if(getdvarint("_encstr_8BA21933AAA3CF2F90C3C259E7138F8B38FBB297F7738247CBB1AB", 0) > 0)
      level._id_145F1.animents[var_4] setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    else
      level._id_145F1.animents[var_4] setModel(var_3);

    level._id_145F1.animents[var_4].angles = level._id_145F1.animstruct.angles;
    level._id_145F1.animents[var_4].animname = "_encstr_85D414AA1351BEC0654F2F67E31DDB1F883757E8EBD1";
    level._id_145F1.animents[var_4] useanimtree(level.scr_animtree["_encstr_85D414AA1351BEC0654F2F67E31DDB1F883757E8EBD1"]);
    level._id_145F1.animents[var_4] unmarkkeyframedmover(1);
    level._id_145F1.animents[var_4] setoverridearchetype_code(1);
    level._id_145F1.animents[var_4] clearwristwatchtime(1);
    level._id_145F1.animents[var_4] hideallparts();
    level._id_145F1.animents[var_4].bullet = _id_13CA1(var_4 + 1);
  }
}

_id_13CB5(var_0, var_1) {
  var_2 = level.scr_anim["_encstr_85D414AA1351BEC0654F2F67E31DDB1F883757E8EBD1"][var_1][0];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = getanimlength(var_2);
  var_4 = randomfloatrange(0, var_3 - 10);

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  waittillframeend;
  var_0 setanimtime(var_2, var_4 / var_3);
}

_id_13CB6(var_0, var_1, var_2) {
  var_3 = level.scr_anim["_encstr_85D414AA1351BEC0654F2F67E31DDB1F883757E8EBD1"][var_1][0];

  if(!isDefined(var_3)) {
    return;
  }
  waittillframeend;
  var_0 setanimtime(var_3, var_2);

  if(getdvarint("_encstr_887818CDB1E47DBB3DA34E1696B9BEA56BD6ED13B4B14B3D56C8", 0) == 1)
    var_0 setanimrate(var_3, 0);
}

_id_13CA3() {
  var_0 = 1;

  if(getdvarint("_encstr_8BA21933AAA3CF2F90C3C259E7138F8B38FBB297F7738247CBB1AB", 0))
    var_0 = 8;

  return var_0;
}

_id_13CA1(var_0) {
  var_1 = _id_13CA3();

  if(var_1 == 1) {
    if(getdvarint("_encstr_8630130328D5F9E7A8A86F753E162F783158AA3AE8", 0))
      var_2 = "_encstr_8AA50A31A36C60A81AABCBFB";
    else if(isDefined(level._id_145F1.bullet))
      var_2 = level._id_145F1.bullet;
    else
      var_2 = "_encstr_88670EC87375611701C393C51152436A";
  } else if(isDefined(level.scr_anim["_encstr_85D414AA1351BEC0654F2F67E31DDB1F883757E8EBD1"]["_encstr_86F621A5DD83D76BC1FAB3953919C27337B6FAE8E4855AB9FAB10BC937BE914E06AF81" + var_0]))
    var_2 = "_encstr_86F621A5DD83D76BC1FAB3953919C27337B6FAE8E4855AB9FAB10BC937BE914E06AF81" + var_0;
  else
    var_2 = "_encstr_88670EC87375611701C393C51152436A";

  return var_2;
}

_id_13CA0(var_0) {
  var_1 = _id_13CA3();

  if(var_1 == 1)
    return 0;
  else
    return var_0;
}

_id_13C94(var_0) {
  if(!isDefined(level._id_145F1.animents[0])) {
    return;
  }
  if(!isDefined(level._id_145F1.animents[0].burst_fire_turret))
    level._id_145F1.animents[0].burst_fire_turret = 1;

  var_1 = level._id_145F1.animents[0].bullet;
  var_2 = level.scr_anim["_encstr_85D414AA1351BEC0654F2F67E31DDB1F883757E8EBD1"][var_1][0];
  level._id_145F1.animents[0] thread _id_13C95(var_0, var_2);
}

_id_13C95(var_0, var_1) {
  level notify("_encstr_ABE90E9893C62AD517222BE14C9B06DA");
  level endon("_encstr_ABE90E9893C62AD517222BE14C9B06DA");
  level endon("_encstr_B28413DB9B0694C5675EEE27BBD9BBA338D88ACD21");
  var_2 = 0.1;
  var_3 = self.burst_fire_turret / var_0 * var_2;
  level._id_145F1._id_13C8D[0].wz_tease setscriptablepartstate("_encstr_928A060723B255C8", "_encstr_A5B508D956FB12D3F27F");

  while(self.burst_fire_turret > 0) {
    self.burst_fire_turret = max(self.burst_fire_turret - var_3, 0);
    self setanimrate(var_1, self.burst_fire_turret);
    wait(var_2);
  }

  level._id_145F1._id_13C8D[0].wz_tease setscriptablepartstate("_encstr_928A060723B255C8", "_encstr_8F79084EEB0211E38D73");

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_AAFF1542C019322F88A8DAE23710E7B687203BEA30E1AF"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AAFF1542C019322F88A8DAE23710E7B687203BEA30E1AF");
}

_id_13C8B(var_0, var_1) {
  if(!isDefined(level._id_145F1.animents[0])) {
    return;
  }
  if(!isDefined(level._id_145F1.animents[0].burst_fire_turret))
    level._id_145F1.animents[0].burst_fire_turret = 1;

  var_2 = level._id_145F1.animents[0].bullet;
  var_3 = level.scr_anim["_encstr_85D414AA1351BEC0654F2F67E31DDB1F883757E8EBD1"][var_2][0];

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_979F12E5F0994A229BF52797D7B53AB2C8399C2D"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_979F12E5F0994A229BF52797D7B53AB2C8399C2D");

  level._id_145F1.animents[0] thread _id_13C8C(var_0, var_1, var_3);
}

_id_13C8C(var_0, var_1, var_2) {
  level notify("_encstr_B28413DB9B0694C5675EEE27BBD9BBA338D88ACD21");
  level endon("_encstr_B28413DB9B0694C5675EEE27BBD9BBA338D88ACD21");
  level endon("_encstr_ABE90E9893C62AD517222BE14C9B06DA");
  var_3 = 0.1;
  var_4 = var_1 * var_3;
  level._id_145F1._id_13C8D[0].wz_tease setscriptablepartstate("_encstr_928A060723B255C8", "_encstr_8A39067FE09165C2");

  while(self.burst_fire_turret < var_0) {
    self.burst_fire_turret = min(self.burst_fire_turret + var_1, var_0);
    self setanimrate(var_2, self.burst_fire_turret);
    wait(var_3);
  }

  self setanimrate(var_2, var_0);
  level._id_145F1._id_13C8D[0].wz_tease setscriptablepartstate("_encstr_928A060723B255C8", "_encstr_ACC107AD988D31CD07");
}

infil_lbravo_damage_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;)
    wait 1;
}

any_player_nearby(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) < var_1)
      return 1;
  }

  return 0;
}

_id_14428() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarint("_encstr_A53F13F3A9FEB713D33192892388D1CFAF633B0BB0", 0) == 0) {
    return;
  }
  while(!isDefined(level.player) || !isalive(level.player))
    wait 0.1;

  level.player endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 1;
  level thread issidecriticaldamage();
  level.player waittill("_encstr_8D0118DCDAE523A59DB27D19CA0763DE5E0785270BC6435DA359");
  wait 0.5;
  var_0 = level._id_145F1._id_13C8D[0].origin;
  level.player setOrigin(var_0 + (0, 0, 4096));
}

issidecriticaldamage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level.player notifyonplayercommand("_encstr_914310F1938A19B1F911CA89275B9BD34776", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");

  for(;;) {
    level.player waittill("_encstr_914310F1938A19B1F911CA89275B9BD34776");
    var_0 = level._id_145F1._id_13C8D[1].origin;

    foreach(var_2 in level.players)
    var_2 setOrigin(var_0 + (0, 0, 200));

    waitframe();
  }
}

isonlastkill(var_0, var_1) {}

completesmokinggunquest() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 1;

    foreach(var_1 in level._id_145F1._id_13C8D)
    var_1.wz_tease hide();

    wait 1;

    foreach(var_1 in level._id_145F1._id_13C8D)
    var_1.wz_tease show();
  }
}

_id_13CB4(var_0) {
  foreach(var_2 in level._id_145F1._id_13C8D) {
    if(isDefined(var_2._id_13CC3))
      var_2._id_13CC3.spawner_debug_model = var_0;
  }
}