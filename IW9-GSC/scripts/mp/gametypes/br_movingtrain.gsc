/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_movingtrain.gsc
***************************************************/

init(_id_54DD3D9BC29908A2) {
  level endon("game_ended");

  if(!isDefined(level.wztrain_info))
    level.wztrain_info = spawnStruct();

  scripts\engine\utility::flag_init("wztrain_array_set");
  scripts\engine\utility::flag_init("wztrain_processed_track");
  scripts\engine\utility::flag_init("wztrain_spawn_started");
  scripts\engine\utility::flag_init("wztrain_anim_playing");

  if(!level init_train_arrays(_id_54DD3D9BC29908A2))
    return 0;

  level thread wait_for_sequence_start(_id_54DD3D9BC29908A2);
}

wait_for_sequence_start(_id_54DD3D9BC29908A2) {
  if(tolower(getDvar("mapname")) != "mp_train_wz") {
    level thread traincar_wait_until_shown("br_prematchEnded");
    level waittill("br_prematchEnded");

    if(istrue(level._id_DF809D7B09E1A9C8)) {
      _id_48814951E916AF89::_id_AF3034A7C69D7EDB(_id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC("merc"));
      wait 1;
    }
  }

  if(getdvarint("scr_wztrain_enable", 0) == 0 || istrue(_id_54DD3D9BC29908A2)) {
    return;
  }
  level thread play_train_sequence();
}

#using_animtree("script_model");

train_wzcircle_override() {
  if(getdvarfloat("dvar_B1243DEBDEB65967", 0.0) == 0.0) {
    return;
  }
  _id_AF1BFAD61D056875 = getdvarfloat("dvar_B1243DEBDEB65967", 0.0);

  if(_id_AF1BFAD61D056875 != 1.0) {
    if(randomint(100) < _id_AF1BFAD61D056875 * 100)
      return;
  }

  _id_7C21D374DADB257F = scripts\engine\utility::array_combine(level.br_level.br_circleclosetimes, level.br_level.br_circledelaytimes);
  totalroundtime = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7C21D374DADB257F.size; _id_AC0E594AC96AA3A8++)
    totalroundtime = totalroundtime + _id_7C21D374DADB257F[_id_AC0E594AC96AA3A8];

  if(totalroundtime <= 0) {
    return;
  }
  totalroundtime = train_wzcircle_time_subtractfrom(totalroundtime);
  xanim = scripts\engine\utility::ter_op(istrue(level._id_DF809D7B09E1A9C8), %iw9_mp_helltrain_saba_ccw, %iw9_mp_train_saba_a_cw);
  xanimlength = getanimlength(xanim);

  if(!isDefined(xanimlength) || xanimlength <= 0) {
    return;
  }
  lengthmod = totalroundtime / xanimlength;
  lengthdelta = lengthmod - int(lengthmod);
  circleposattime = getoriginforanimtime((0, 0, 13), (0, 0, 0), xanim, lengthdelta);
  level.wztrain_info.circletimestruct = spawnStruct();
  level.wztrain_info.circletimestruct.xanimlength = xanimlength;
  level.wztrain_info.circletimestruct.lengthmod = lengthmod;
  level.wztrain_info.circletimestruct.lengthdelta = lengthdelta;
  level.wztrain_info.circletimestruct.totalroundtime = totalroundtime;
  level.wztrain_info.circletimestruct.circleposattime = circleposattime;
  setDvar("br_final_circle_override", circleposattime);
}

train_wzcircle_time_subtractfrom(totalroundtime) {
  _id_95035071E6650A79 = 425;

  if(getdvarint("dvar_B2E704499FEADF68", 425) != 425)
    _id_95035071E6650A79 = getdvarint("dvar_B2E704499FEADF68", 425);

  if(getdvarint("dvar_B35EDEC538A597B0", 75) > 0) {
    input = getdvarint("dvar_B35EDEC538A597B0", 75);
    _id_95035071E6650A79 = _id_95035071E6650A79 + randomint(input);
  }

  _id_7952B28329CD5C22 = 10;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_95035071E6650A79 - _id_7952B28329CD5C22; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + _id_7952B28329CD5C22) {
    if(totalroundtime - _id_7952B28329CD5C22 > 0)
      totalroundtime = totalroundtime - _id_7952B28329CD5C22;
  }

  return totalroundtime;
}

init_train_arrays(_id_54DD3D9BC29908A2) {
  level.wztrain_info.train_array = [];
  level.wztrain_info._id_C3604781A9D33A7A = [];
  level.wztrain_info._id_1A30B87276ED28E5 = [];
  level.wztrain_info._id_738F809BAC14AE04 = 0;

  if(isDefined(level.wztrain_info._id_0B330D787646FC2F)) {
    foreach(index, _id_E24D0C27A1EB7109 in level.wztrain_info._id_0B330D787646FC2F) {
      train_array = [[_id_E24D0C27A1EB7109]]();
      level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[index]] = train_array;
      level.wztrain_info.train_array = scripts\engine\utility::array_combine(level.wztrain_info.train_array, train_array);
    }

    level.wztrain_info._id_738F809BAC14AE04 = level.wztrain_info._id_0B330D787646FC2F.size > 1;
  } else {
    level.wztrain_info._id_FE47FF8E697AD1D2 = ["cargo_train"];

    if(isDefined(getEnt("train_car_0", "script_noteworthy"))) {
      level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]] = [getEnt("train_car_0", "script_noteworthy"), getEnt("train_car_1", "script_noteworthy"), getEnt("train_car_2", "script_noteworthy"), getEnt("train_car_3", "script_noteworthy"), getEnt("train_car_4", "script_noteworthy"), getEnt("train_car_5", "script_noteworthy"), getEnt("train_car_6", "script_noteworthy"), getEnt("train_car_7", "script_noteworthy")];

      if(istrue(level._id_DF809D7B09E1A9C8)) {
        _id_2240FFA1B0F295B6 = [getEnt("train_car_8", "script_noteworthy"), getEnt("train_car_9", "script_noteworthy"), getEnt("train_car_10", "script_noteworthy"), getEnt("train_car_11", "script_noteworthy"), getEnt("train_car_12", "script_noteworthy")];
        level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]] = scripts\engine\utility::array_combine(level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]], _id_2240FFA1B0F295B6);
      }
    } else
      level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]] = [getEnt("train_car_18", "script_noteworthy"), getEnt("train_car_17", "script_noteworthy"), getEnt("train_car_16", "script_noteworthy"), getEnt("train_car_15", "script_noteworthy"), getEnt("train_car_14", "script_noteworthy"), getEnt("train_car_13", "script_noteworthy"), getEnt("train_car_12", "script_noteworthy"), getEnt("train_car_11", "script_noteworthy")];

    level.wztrain_info._id_738F809BAC14AE04 = isDefined(getEnt("train_car_20", "script_noteworthy"));

    if(level.wztrain_info._id_738F809BAC14AE04) {
      level.wztrain_info._id_FE47FF8E697AD1D2 = scripts\engine\utility::array_add(level.wztrain_info._id_FE47FF8E697AD1D2, "br_passenger_train");
      level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[1]] = [getEnt("train_car_20", "script_noteworthy"), getEnt("train_car_21", "script_noteworthy"), getEnt("train_car_22", "script_noteworthy"), getEnt("train_car_23", "script_noteworthy"), getEnt("train_car_24", "script_noteworthy"), getEnt("train_car_25", "script_noteworthy"), getEnt("train_car_26", "script_noteworthy"), getEnt("train_car_27", "script_noteworthy")];
      level.wztrain_info.train_array = [];

      foreach(_id_61A1A37391FB592E in level.wztrain_info._id_FE47FF8E697AD1D2) {
        foreach(traincar in level.wztrain_info._id_C3604781A9D33A7A[_id_61A1A37391FB592E])
        level.wztrain_info.train_array[level.wztrain_info.train_array.size] = traincar;
      }
    } else
      level.wztrain_info.train_array = level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]];
  }

  foreach(traincar in level.wztrain_info.train_array) {
    if(!isent(traincar))
      return 0;
  }

  train_wzcircle_override();
  train_play_anim_init();
  train_initcollision(_id_54DD3D9BC29908A2);
  train_attach_player_hurts();
  train_associate_models_with_brushes();
  train_attach_brushes_to_models();
  train_attach_models_to_assembly();
  _id_B91FF337122B31FE();

  if(isDefined(level.wztrain_info._id_2AFE24EE912AB8A1))
    [[level.wztrain_info._id_2AFE24EE912AB8A1]]();

  train_init_lootcrates_on_train();

  if(isDefined(level.wztrain_info._id_3079813E25479249))
    level thread[[level.wztrain_info._id_3079813E25479249]]();
  else
    level thread train_vfx_init();

  level thread train_sfx_init();
  level thread _id_85A3956C7630EA05();
  level thread train_handle_collide_mines();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    foreach(_id_949475D0823BC895 in level.wztrain_info._id_FE47FF8E697AD1D2)
    level thread _id_280CD7C412F05970(_id_949475D0823BC895);
  }

  scripts\engine\utility::flag_set("wztrain_array_set");
  return 1;
}

train_associate_models_with_brushes() {
  _id_59EF9FF0D44B7D97 = "train_car_model_";

  if(isDefined(level.wztrain_info._id_ECF7A389446FC63E))
    _id_59EF9FF0D44B7D97 = [[level.wztrain_info._id_ECF7A389446FC63E]]();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.wztrain_info.train_array.size; _id_AC0E594AC96AA3A8++) {
    _id_95F7D242A34853EF = undefined;

    if(isarray(_id_59EF9FF0D44B7D97))
      _id_95F7D242A34853EF = getEnt(_id_59EF9FF0D44B7D97[_id_AC0E594AC96AA3A8], "script_noteworthy");
    else {
      _id_C6273BA32A3BFB6E = strtok(level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].script_noteworthy, "_");
      _id_1E136F70344DC06F = _id_C6273BA32A3BFB6E[_id_C6273BA32A3BFB6E.size - 1];
      _id_95F7D242A34853EF = getEnt(_id_59EF9FF0D44B7D97 + _id_1E136F70344DC06F, "script_noteworthy");
    }

    if(isent(_id_95F7D242A34853EF)) {
      level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model = _id_95F7D242A34853EF;
      level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model markkeyframedmover();
      _id_95F7D242A34853EF.linked_brush = level.wztrain_info.train_array[_id_AC0E594AC96AA3A8];
    }
  }
}

train_attach_brushes_to_models() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.wztrain_info.train_array.size; _id_AC0E594AC96AA3A8++) {
    train_init_as_vehicle(level.wztrain_info.train_array[_id_AC0E594AC96AA3A8]);
    level.wztrain_info.train_array[_id_AC0E594AC96AA3A8] forcenetfieldhighlod(1);
    level.wztrain_info.train_array[_id_AC0E594AC96AA3A8] setmoveroptimized(1);
    level.wztrain_info.train_array[_id_AC0E594AC96AA3A8] setmoverantilagged(1);
    level.wztrain_info.train_array[_id_AC0E594AC96AA3A8] linkTo(level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model);
  }
}

train_attach_models_to_assembly() {
  foreach(train, array in level.wztrain_info._id_C3604781A9D33A7A) {
    _id_B2A3F9ABCEE9D071 = level.wztrain_info._id_B2A3F9ABCEE9D071[train];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
      traincar = array[_id_AC0E594AC96AA3A8];
      _id_DB9A56EDADC7D853 = level.wztrain_info.train_tag_array[_id_AC0E594AC96AA3A8];
      tagorigin = _id_B2A3F9ABCEE9D071 gettagorigin(_id_DB9A56EDADC7D853);
      tagoffset = level.wztrain_info.train_tagoffset_array[_id_AC0E594AC96AA3A8];
      traincar.linked_model forcenetfieldhighlod(1);
      traincar.linked_model setmoveroptimized(1);
      traincar.linked_model setmoverantilagged(1);
      traincar.linked_model.origin = tagorigin;

      if(getdvarint("dvar_F524D127E4BA82C4", 0) > 0)
        traincar.linked_model linkTo(_id_B2A3F9ABCEE9D071, _id_DB9A56EDADC7D853, tagoffset, (0, 0, 0));
    }
  }
}

train_init_as_vehicle(vehicle) {
  vehicle.vehiclename = "cargo_train";
  vehicle.linked_model.vehiclename = "cargo_train";
  vehicle thread _id_5FD79768B8941CFB::_id_E549E7BB5A16C3BC();
  vehicle.linked_model thread _id_5FD79768B8941CFB::_id_E549E7BB5A16C3BC();
}

train_stop() {
  level notify("obj_stop_train");
}

train_attach_useable_ammorestocklocation() {
  if(getdvarint("dvar_E619C4C384B28BB7", 0) > 0) {
    return;
  }
  traincar = level.wztrain_info.train_array[1];
  offset = (20, 0, 5);
  angle = (0, 90, 0);
  angles = rotatevector(angle, traincar.angles);
  type = "military_ammo_restock_train";
  scriptable = spawnscriptable(type, traincar.origin + offset, angles);
  scriptable thread train_scriptable_attach_delay(traincar, offset, angles);
  traincar.ammo_restock = scriptable;
}

traincar_wait_until_shown(_id_76EC7C10F1C9089C) {
  level endon("game_ended");
  waitframe();
  train_elements_disable();
  level waittill(_id_76EC7C10F1C9089C);
  train_elements_enable();
}

_id_A4B4D45FDCC959D8(_id_2E07296097D308E6) {
  traincar = self;

  if(isDefined(traincar._id_F285D73B82CA4C5C)) {
    foreach(traincar_hurt in traincar._id_F285D73B82CA4C5C)
    traincar_hurt.hurt_enabled = _id_2E07296097D308E6;
  }
}

train_elements_enable() {
  foreach(train in level.wztrain_info._id_B2A3F9ABCEE9D071)
  _id_09DD6A5882C62DD6(train.animname);

  wait 2;

  if(istrue(level._id_DF809D7B09E1A9C8)) {
    level thread _id_4515669B8DD8F946();
    level thread _id_184A361D377CB782();
  }
}

_id_09DD6A5882C62DD6(_id_2386E682A2AA4874) {
  if(scripts\engine\utility::array_contains(level.wztrain_info._id_1A30B87276ED28E5, _id_2386E682A2AA4874)) {
    level.wztrain_info._id_1A30B87276ED28E5 = scripts\engine\utility::array_remove(level.wztrain_info._id_1A30B87276ED28E5, _id_2386E682A2AA4874);

    foreach(traincar in level.wztrain_info.train_array) {
      if(isDefined(traincar.linked_model)) {
        traincar.linked_model show();
        traincar.linked_model solid();
        traincar solid();
        traincar _id_A4B4D45FDCC959D8(1);

        if(isDefined(traincar.ammo_restock))
          traincar.ammo_restock thread _id_5A1EBF95DE1AD6C9();
      }
    }
  }
}

_id_5A1EBF95DE1AD6C9() {
  wait 3;
  self setscriptablepartstate("military_ammo_restock", "useable_on_no_collision");
}

train_elements_disable() {
  foreach(train in level.wztrain_info._id_B2A3F9ABCEE9D071)
  _id_E7A82D389007737B(train.animname);
}

_id_E7A82D389007737B(_id_2386E682A2AA4874) {
  if(!scripts\engine\utility::array_contains(level.wztrain_info._id_1A30B87276ED28E5, _id_2386E682A2AA4874)) {
    train = level.wztrain_info._id_C3604781A9D33A7A[_id_2386E682A2AA4874];
    level.wztrain_info._id_1A30B87276ED28E5 = scripts\engine\utility::array_add(level.wztrain_info._id_1A30B87276ED28E5, _id_2386E682A2AA4874);

    foreach(traincar in train) {
      if(isDefined(traincar.linked_model)) {
        traincar.linked_model hide();
        traincar.linked_model notsolid();
        traincar notsolid();
        traincar _id_A4B4D45FDCC959D8(0);

        if(isDefined(traincar.ammo_restock))
          traincar.ammo_restock setscriptablepartstate("military_ammo_restock", "useable_on_no_icon");

        if(traincar.linked_model isscriptable())
          level notify("forced_kill_callout_" + traincar.linked_model.script_noteworthy);
      }
    }
  }
}

train_initcollision(_id_54DD3D9BC29908A2) {
  if(istrue(_id_54DD3D9BC29908A2)) {
    return;
  }
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_getleveldataforvehicle("cargo_train", 1);
  _id_E2818AD39A3341B4.handleeventcallback = ::handle_train_veh_collision;
  _id_E2818AD39A3341B4.class = "immovable";
}

handle_train_veh_collision(_id_C975FCDFFCE9C9A6, _id_C975FBDFFCE9C773) {
  _id_3CBF5EC3E372F1F2 = _id_5FD79768B8941CFB::_id_84114ACFF04CFCCB(_id_C975FCDFFCE9C9A6, _id_C975FBDFFCE9C773, "cargo_train", 1);

  if(isDefined(_id_3CBF5EC3E372F1F2)) {
    if(_id_3CBF5EC3E372F1F2.vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown() || _id_3CBF5EC3E372F1F2.isvehicledestroyed)
      _id_6A8EC730B2BFA844::_id_719E931249C15652(_id_3CBF5EC3E372F1F2.vehicle);
  }
}

train_handle_collide_mines() {
  level endon("game_ended");
  level endon("obj_stop_train");

  if(!isDefined(level.mines))
    level.mines = [];

  _id_513DD84D5F0143D5 = [];

  foreach(train_array in level.wztrain_info._id_C3604781A9D33A7A)
  _id_513DD84D5F0143D5[_id_513DD84D5F0143D5.size] = train_array[0];

  _id_F8266AB10167447F = 150;

  if(getdvarfloat("dvar_731567D6C424394D", 150) != 150)
    _id_F8266AB10167447F = getdvarfloat("dvar_731567D6C424394D", 150);

  maxdist = _id_F8266AB10167447F - 25;
  _id_CDC5DD6C28C9709D = maxdist * maxdist;

  for(;;) {
    _id_4EABE431328AB40F = level.mines;

    if(_id_4EABE431328AB40F.size > 0) {
      foreach(_id_E6AB92DF6605E9A4 in _id_513DD84D5F0143D5) {
        _id_863C619037F3AC74 = _id_E6AB92DF6605E9A4.origin + rotatevector((375, 0, -100), _id_E6AB92DF6605E9A4.angles);

        foreach(mine in _id_4EABE431328AB40F) {
          if(!isDefined(mine)) {
            continue;
          }
          if(istrue(mine.markedfordelete)) {
            continue;
          }
          if(distance2dsquared(mine.origin, _id_863C619037F3AC74) > _id_CDC5DD6C28C9709D) {
            continue;
          }
          if(distancesquared(mine.origin, _id_863C619037F3AC74) > _id_CDC5DD6C28C9709D) {
            continue;
          }
          if(isDefined(mine.weapon_name)) {
            if(mine.weapon_name == "trophy_mp") {
              mine scripts\mp\equipment\trophy_system::sweeptrophy();
              mine.markedfordelete = 1;
              continue;
            }

            if(mine.weapon_name == "claymore_mp") {
              mine scripts\mp\equipment\claymore::sweepclaymore();
              mine.markedfordelete = 1;
              continue;
            }

            if(mine.weapon_name == "at_mine_mp") {
              mine scripts\mp\equipment\at_mine::at_mine_destroy();
              mine.markedfordelete = 1;
              continue;
            }

            if(mine.weapon_name == "tac_insert_trigger") {
              mine scripts\mp\equipment\tac_insert::deletetacinsert();
              mine.markedfordelete = 1;
              continue;
            }

            if(mine.weapon_name == "deployed_decoy_mp") {
              mine _id_1CF2ED809496BF4E::_id_183A7478C53FD2F2();
              mine.markedfordelete = 1;
            }
          }
        }
      }
    }

    waitframe();
  }
}

train_init_lootcrates_on_train() {
  _id_251E39F07F8BCB3F = 0;

  foreach(traincar in level.wztrain_info.train_array) {
    noteworthy = traincar.script_noteworthy;
    _id_5ADDB9EEB741AF64 = noteworthy + "_loot";
    _id_8258D7E66268B63C = scripts\engine\utility::getStructArray(_id_5ADDB9EEB741AF64, "script_noteworthy");
    _id_251E39F07F8BCB3F = _id_251E39F07F8BCB3F + _id_8258D7E66268B63C.size;
  }

  level.wztrain_info.totaltrainlootcrates = _id_251E39F07F8BCB3F;
  train_lootcrates_save_offsets(level.wztrain_info.train_array);
}

play_train_sequence() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("wztrain_spawn_started");

  foreach(train, array in level.wztrain_info._id_C3604781A9D33A7A)
  level thread train_play_anim(train, array);

  level thread _id_E079D6A3354CECBE();
}

_id_E079D6A3354CECBE() {
  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  wait 2;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.wztrain_info.train_array.size; _id_AC0E594AC96AA3A8++) {
    _id_AF111E529B798902 = level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model;

    if(isDefined(_id_AF111E529B798902) && _id_AF111E529B798902 isscriptable() && _id_AF111E529B798902 getscriptablehaspart("icon") && _id_AF111E529B798902 getscriptableparthasstate("icon", "visible"))
      _id_AF111E529B798902 setscriptablepartstate("icon", "visible");
  }

  if(istrue(level._id_DF809D7B09E1A9C8))
    level thread _id_6ADBC1DB84BD62E8(level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]][1]);
}

train_lootcrates_save_offsets(train_array) {
  foreach(traincar in train_array) {
    noteworthy = traincar.script_noteworthy;
    _id_5ADDB9EEB741AF64 = noteworthy + "_loot";
    _id_8258D7E66268B63C = scripts\engine\utility::getStructArray(_id_5ADDB9EEB741AF64, "script_noteworthy");

    if(_id_8258D7E66268B63C.size > 0) {
      traincar._id_A381B6D2C46A74B8 = [];

      foreach(_id_1BE58AA13BA9F7DA in _id_8258D7E66268B63C) {
        _id_C35E1C74AEFB4992 = _id_1BE58AA13BA9F7DA.origin - traincar.origin;
        _id_1BE58AA13BA9F7DA.offset = rotatevectorinverted(_id_C35E1C74AEFB4992, traincar.angles);
        traincar._id_A381B6D2C46A74B8[traincar._id_A381B6D2C46A74B8.size] = _id_1BE58AA13BA9F7DA;

        if(isDefined(_id_1BE58AA13BA9F7DA.targetname) && _id_1BE58AA13BA9F7DA.targetname == "dmz_tripwire")
          _id_1BE58AA13BA9F7DA.array = scripts\engine\utility::getStructArray(_id_1BE58AA13BA9F7DA.target, "targetname");
      }
    }
  }
}

_id_280CD7C412F05970(train) {
  if(getdvarint("dvar_A7A1F773905E7717", 1) == 0) {
    return;
  }
  scripts\engine\utility::flag_wait("wztrain_array_set");
  train_array = level.wztrain_info._id_C3604781A9D33A7A[train];
  _id_4483132E24522A93 = 4;
  _id_344BD4A74AA0D27F = 0;
  _id_1DCB906AD3A2524C = 0;
  _id_5A3583111BDD438D = 0;
  _id_579AD36578449A54 = randomint(3) + 1;

  if(getdvarint("dvar_30A292C132A583BA", -1) >= 0)
    _id_4483132E24522A93 = getdvarint("dvar_30A292C132A583BA");

  if(_id_4483132E24522A93 > level.wztrain_info.totaltrainlootcrates)
    _id_4483132E24522A93 = level.wztrain_info.totaltrainlootcrates;

  _id_8BA6B6CCE91CEFCA = getdvarint("dvar_C618B08DF642B05A", 1);

  foreach(traincar in train_array) {
    if(!isDefined(traincar._id_A381B6D2C46A74B8)) {
      continue;
    }
    _id_B48F99D24F1A9085 = [];
    _id_9B5C6F076CA61B42 = 0;

    foreach(struct in scripts\engine\utility::array_randomize(traincar._id_A381B6D2C46A74B8)) {
      type = scripts\engine\utility::_id_53C4C53197386572(struct.script_label, struct.targetname);

      if(isDefined(type) && type == "br_loot_cache") {
        if(_id_1DCB906AD3A2524C > level.wztrain_info.totaltrainlootcrates - _id_4483132E24522A93) {
          if(_id_344BD4A74AA0D27F < _id_4483132E24522A93) {
            type = "br_loot_cache_lege";
            _id_344BD4A74AA0D27F++;
          }
        } else if(_id_344BD4A74AA0D27F < _id_4483132E24522A93 && scripts\engine\utility::cointoss()) {
          type = "br_loot_cache_lege";
          _id_344BD4A74AA0D27F++;
        }
      } else if(!isDefined(type)) {
        continue;
      }
      if(istripwire(type) && getdvarint("dvar_37F28F8851EACC2F", 1) != 1) {
        continue;
      }
      if(istrap(type)) {
        if(_id_9B5C6F076CA61B42 >= _id_8BA6B6CCE91CEFCA)
          continue;
        else
          _id_9B5C6F076CA61B42 = _id_9B5C6F076CA61B42 + 1;
      }

      if(type == "dmz_tripwire_frag" && distancesquared(struct.offset, (80.75, -2.75, 7.25)) < 1)
        struct.offset = (80.75, -15, 7.25);
      else if(type == "dmz_tripwire_wall_pin") {
        foreach(_id_B1FCB60302CFC360 in [(-285.75, 34, -48.25), (-285, -42.25, -47), (-285.75, 34, -42.25), (-285, -42.25, -41), (-290, -42.25, -47), (-290.75, 34, -48.25)]) {
          if(distancesquared(struct.offset, _id_B1FCB60302CFC360) < 1) {
            struct.angles = (0, 0, -1 * struct.angles[2]);
            break;
          }
        }
      }

      if(_id_015731B0001F5F3C(type) || _id_0DACF28437AD9A90(train, struct)) {
        level thread _id_44BC5DF521157B97(train, traincar, struct);
        continue;
      }

      scriptable = spawnscriptable(type, traincar.origin + struct.offset, struct.angles);
      scriptable thread train_scriptable_attach_delay(traincar, struct.offset, struct.angles);
      initialstate = undefined;

      if(scriptable getscriptableisloot())
        initialstate = _func_6F817B71C98D6307(_func_40FD49171FAD19D3(type));

      _id_C45009692B29CC64 = isDefined(initialstate) && initialstate == "enum_5DAB1D36DF0BE973";

      if(!_id_C45009692B29CC64 && scriptable getscriptablehaspart("body") && scriptable getscriptableparthasstate("body", "closed_usable_no_collision"))
        scriptable setscriptablepartstate("body", "closed_usable_no_collision");
      else if(type == "dmz_crate_wood" && _id_C45009692B29CC64)
        scriptable setscriptablepartstate("body", "closed_unusable_no_collision");
      else if(isDefined(initialstate) && scriptable getscriptablehaspart("body") && scriptable getscriptableparthasstate("body", initialstate))
        scriptable setscriptablepartstate("body", initialstate);

      if(type == "military_ammo_restock_noent") {
        scriptable setscriptablepartstate("military_ammo_restock", "useable_on_no_icon");
        traincar.ammo_restock = scriptable;
      } else if(type == "dmz_crate_wood_train") {
        prompt = scriptable _id_57D3850A12CF1D8F::_id_C4D29F8F054E326B(scriptable.origin + (0, 0, 25), "hell_train", "closed_locked", "closed_usable_no_collision");
        prompt thread train_scriptable_attach_delay(traincar, struct.offset + (0, 0, 25), struct.angles);
      } else if(istrue(level._id_DF809D7B09E1A9C8) && _id_5A3583111BDD438D < 6 && train == "cargo_train" && traincar.script_noteworthy != "train_car_1" && !_id_C45009692B29CC64 && scriptable getscriptablehaspart("body")) {
        if(_id_579AD36578449A54 > 0)
          _id_579AD36578449A54 = _id_579AD36578449A54 - 1;
        else {
          items = getscriptablelootcachecontents(scriptable);

          if(isDefined(items)) {
            scriptable._id_2E1A29FB688816D4 = scripts\engine\utility::random(["loot_key_hell_train", "loot_key_hell_train_used", "loot_key_hell_train_worn"]);
            _id_579AD36578449A54 = randomint(3) + 1;
            _id_5A3583111BDD438D = _id_5A3583111BDD438D + 1;
          }
        }
      } else if(istripwire(type)) {
        struct.scriptable = scriptable;

        if(type == "dmz_tripwire") {
          _id_B48F99D24F1A9085[_id_B48F99D24F1A9085.size] = struct;

          if(_id_9B5C6F076CA61B42 >= _id_8BA6B6CCE91CEFCA)
            struct._id_92E4DA462F736A2F = 1;
          else
            _id_9B5C6F076CA61B42 = _id_9B5C6F076CA61B42 + 1;
        }
      }

      _id_1DCB906AD3A2524C++;
      waitframe();
    }

    if(!isDefined(level._id_E9A6FC11B0AA7EB2)) {
      continue;
    }
    foreach(struct in _id_B48F99D24F1A9085) {
      struct.scriptable.array = [];

      foreach(linked in struct.array)
      struct.scriptable.array[struct.scriptable.array.size] = linked.scriptable;

      if(istrue(struct._id_92E4DA462F736A2F)) {
        [[level._id_D9D80893720B39DF]](struct.scriptable);
        continue;
      }

      _id_801C53C0ED06495B = [[level._id_E9A6FC11B0AA7EB2]](struct.scriptable);

      if(isDefined(_id_801C53C0ED06495B.trigger)) {
        _id_801C53C0ED06495B.trigger enablelinkTo();
        _id_801C53C0ED06495B.trigger linkTo(traincar);
      }

      if(isDefined(_id_801C53C0ED06495B.navobstacleid))
        destroynavobstacle(_id_801C53C0ED06495B.navobstacleid);
    }
  }

  scripts\engine\utility::flag_set("wztrain_scriptables_spawned");
}

_id_015731B0001F5F3C(type) {
  return type == "weapon_vm_mg_sentry_turret_train" || type == "offhand_2h_wm_decoy_mine_dummy01_v0_train" || type == "offhand_2h_wm_decoy_mine_dummy02_v0_train" || type == "offhand_2h_wm_claymore_v0_train" || type == "lm_offhand_wm_at_mine_train" || type == "dmz_train_safe" || type == "palfa_fuel_spawn" || type == "train_exit_portal";
}

_id_0DACF28437AD9A90(train, _id_1BE58AA13BA9F7DA) {
  return _id_1BE58AA13BA9F7DA.targetname == "military_ammo_restock_noent" && train == "cargo_train" && scripts\mp\utility\game::getsubgametype() == "dmz" && _id_1BE58AA13BA9F7DA.script_noteworthy != "train_car_3_loot";
}

istripwire(type) {
  return type == "dmz_tripwire" || type == "dmz_tripwire_frag" || type == "dmz_tripwire_wall_pin";
}

istrap(type) {
  return type == "lm_offhand_wm_at_mine_train" || type == "offhand_2h_wm_claymore_v0_train";
}

_id_44BC5DF521157B97(train, traincar, _id_1BE58AA13BA9F7DA) {
  type = _id_1BE58AA13BA9F7DA.targetname;

  switch (type) {
    case "military_ammo_restock_noent":
      _id_B002D10BD710CC12(_id_1BE58AA13BA9F7DA.offset, traincar);
      break;
    case "weapon_vm_mg_sentry_turret_train":
      if(getdvarint("dvar_5B231ECB6D8644AF", 1) != 1) {
        return;
      }
      struct = spawnStruct();
      struct.origin = traincar.origin + _id_1BE58AA13BA9F7DA.offset;
      struct.angles = _id_1BE58AA13BA9F7DA.angles;
      turret = _id_60E3273DF6B5F7D1::_id_F33B0AFADF9107EB(struct, undefined, 1);
      turret linkTo(traincar);
      break;
    case "lm_offhand_wm_at_mine_train":
      if(getdvarint("dvar_C0748D2FDC8234FE", 1) != 1) {
        return;
      }
      scripts\engine\utility::flag_wait("aiBudget_init");

      if(!isDefined(level._id_4CDD253DC5F7CD32) || !scripts\engine\utility::array_contains(level._id_4CDD253DC5F7CD32, "reinforcements")) {
        return;
      }
      _id_282B1925C4AF6F1F = spawnStruct();
      _id_282B1925C4AF6F1F.origin = traincar.origin + _id_1BE58AA13BA9F7DA.offset;
      _id_282B1925C4AF6F1F.angles = _id_1BE58AA13BA9F7DA.angles;
      _id_282B1925C4AF6F1F.ref = "equip_at_mine";
      _id_1FA444CDC9DBF364::_id_FD5966A3A1FDF6B8(_id_282B1925C4AF6F1F, undefined, traincar);
      break;
    case "offhand_2h_wm_claymore_v0_train":
      if(getdvarint("dvar_736FEAEB01DE7CB1", 1) != 1) {
        return;
      }
      scripts\engine\utility::flag_wait("aiBudget_init");

      if(!isDefined(level._id_4CDD253DC5F7CD32) || !scripts\engine\utility::array_contains(level._id_4CDD253DC5F7CD32, "reinforcements")) {
        return;
      }
      _id_282B1925C4AF6F1F = spawnStruct();
      _id_282B1925C4AF6F1F.origin = traincar.origin + _id_1BE58AA13BA9F7DA.offset;
      _id_282B1925C4AF6F1F.angles = _id_1BE58AA13BA9F7DA.angles;
      _id_282B1925C4AF6F1F.ref = "equip_claymore";
      grenade = _id_1FA444CDC9DBF364::_id_FD5966A3A1FDF6B8(_id_282B1925C4AF6F1F);
      grenade linkTo(traincar);
      break;
    case "offhand_2h_wm_decoy_mine_dummy02_v0_train":
    case "offhand_2h_wm_decoy_mine_dummy01_v0_train":
      if(getdvarint("dvar_196CDE8B910EC533", 1) != 1) {
        return;
      }
      scripts\engine\utility::flag_wait("aiBudget_init");

      if(!isDefined(level._id_4CDD253DC5F7CD32) || !scripts\engine\utility::array_contains(level._id_4CDD253DC5F7CD32, "reinforcements")) {
        return;
      }
      struct = spawnStruct();
      struct.origin = _id_1BE58AA13BA9F7DA.offset;
      struct.angles = _id_1BE58AA13BA9F7DA.angles;
      struct.owner = _id_48814951E916AF89::_id_AF3034A7C69D7EDB(_id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC("merc"));
      _id_820C08BC4A68289F = spawnStruct();
      _id_820C08BC4A68289F.iscomplete = 1;

      if(type == "offhand_2h_wm_decoy_mine_dummy01_v0_train") {
        _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 = 1;
        _id_820C08BC4A68289F._id_E9B7D63908996C9E = 0;
        _id_820C08BC4A68289F._id_E4CBF98C9AAD2678 = 2;
      } else {
        _id_820C08BC4A68289F._id_D1FD51D0F7BEFD26 = 0;
        _id_820C08BC4A68289F._id_E9B7D63908996C9E = 1;
        _id_820C08BC4A68289F._id_E4CBF98C9AAD2678 = 1;
      }

      struct._id_820C08BC4A68289F = _id_820C08BC4A68289F;
      struct.base = spawnscriptable("equip_deployed_decoy_train", traincar.origin + _id_1BE58AA13BA9F7DA.offset, _id_1BE58AA13BA9F7DA.angles);
      struct.base thread train_scriptable_attach_delay(traincar, _id_1BE58AA13BA9F7DA.offset, _id_1BE58AA13BA9F7DA.angles);
      trigger = spawn("trigger_radius", struct.base.origin, 0, 120, 100);
      trigger enablelinkTo();
      trigger linkTo(traincar);

      for(;;) {
        trigger waittill("trigger", ent);

        if(isPlayer(ent)) {
          break;
        }
      }

      trigger delete();
      wait(randomfloatrange(0, 0.1));
      struct.base setscriptablepartstate("explode", "active", 0);
      struct.origin = rotatevector(struct.origin, traincar.angles) + traincar.origin;
      dummy = struct _id_1CF2ED809496BF4E::_id_8958B19A2ECC8D46();
      dummy._id_9AADBD8D704D2FAB = struct._id_9AADBD8D704D2FAB;
      dummy.angles = combineangles(traincar.angles, struct.angles);
      dummy linkTo(traincar);
      dummy thread _id_1CF2ED809496BF4E::_id_2AE474EB2C763DCA(dummy._id_9AADBD8D704D2FAB);
      break;
    case "dmz_train_safe":
      scriptable = spawnscriptable("dmz_hell_train_safe", traincar.origin + _id_1BE58AA13BA9F7DA.offset, _id_1BE58AA13BA9F7DA.angles);
      scriptable thread train_scriptable_attach_delay(traincar, _id_1BE58AA13BA9F7DA.offset, _id_1BE58AA13BA9F7DA.angles);
      level._id_A39ACAF08D876A31 = traincar;
      scriptable._id_46A3A8565AC0C17C = 4;
      scriptable.contents = _id_552B8E4EA5FF7DF1::_id_EC87B214CD429E96(getscriptcachecontents("hell_train_safe"));
      scriptable._id_534E0CF170A981B7 = ::_id_338EB83CECFB0E0F;
      break;
    case "palfa_fuel_spawn":
      _id_1BE58AA13BA9F7DA.traincar = traincar;
      _id_1BE58AA13BA9F7DA.origin = _id_1BE58AA13BA9F7DA.offset;
      level._id_C5B14273ADC323E2 = _id_1BE58AA13BA9F7DA;
      break;
    case "train_exit_portal":
      if(getdvarint("dvar_5C1339108B783763", 1) != 1) {
        return;
      }
      level._id_48CCF7A2BA790A53 = spawnscriptable("train_exit_portal", traincar.origin + _id_1BE58AA13BA9F7DA.offset + (0, 0, 30), (0, 90, 0));
      level._id_48CCF7A2BA790A53 thread train_scriptable_attach_delay(traincar, _id_1BE58AA13BA9F7DA.offset + (0, 0, 30), (0, 90, 0));

      if(getdvarint("dvar_7097C42A68A06D81", 0) == 1)
        level._id_48CCF7A2BA790A53 setscriptablepartstate("train_exit_portal", "open");
      else
        scripts\cp_mp\utility\script_utility::registersharedfunc(39124, "pickedUp", ::_id_693DD78CF889F547);

      scripts\engine\scriptable::scriptable_addusedcallbackbypart("train_exit_portal", ::_id_B587A630BCEEE5AD);
      break;
  }
}

train_scriptable_attach_delay(traincar, offset, angles) {
  level endon("game_ended");
  wait 1;
  scripts\common\utility::_id_6E506F39F121EA8A(traincar, offset, angles);
}

train_attach_player_hurts() {
  foreach(_id_AC0E594AC96AA3A8, traincar in level.wztrain_info.train_array) {
    noteworthy = traincar.script_noteworthy;
    _id_7FD853E2F4FDE5CA = noteworthy + "_train_front_hurt";

    if(isDefined(level.wztrain_info._id_4F0382615A2A1259))
      _id_7FD853E2F4FDE5CA = noteworthy + level.wztrain_info._id_4F0382615A2A1259;

    _id_F285D73B82CA4C5C = getEntArray(_id_7FD853E2F4FDE5CA, "script_noteworthy");
    traincar._id_F285D73B82CA4C5C = [];

    foreach(traincar_hurt in _id_F285D73B82CA4C5C) {
      if(isent(traincar_hurt)) {
        if(level.wztrain_info._id_738F809BAC14AE04)
          _id_834C12B34EA6616F = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 < 8, level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]][0], level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[1]][0]);
        else
          _id_834C12B34EA6616F = level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]][0];

        traincar._id_F285D73B82CA4C5C = scripts\engine\utility::array_add(traincar._id_F285D73B82CA4C5C, traincar_hurt);
        traincar_hurt enablelinkTo();
        traincar_hurt linkTo(traincar);
        traincar_hurt thread train_hurt_damage_watcher(traincar, _id_834C12B34EA6616F);
      }
    }
  }
}

train_hurt_damage_watcher(traincar, _id_834C12B34EA6616F) {
  level endon("game_ended");
  self endon("death");
  modifier = 1;

  if(getdvarfloat("dvar_BAEAA14065BE0BF2", -1) != -1)
    modifier = getdvarfloat("dvar_BAEAA14065BE0BF2", -1);

  self.hurt_enabled = 1;
  self.iswztrain = 1;
  self._id_9C675043198097A3 = ::_id_51DA224C93D325F3;
  self._id_834C12B34EA6616F = _id_834C12B34EA6616F;

  for(;;) {
    self waittill("trigger", _id_1D9FB21B4F3023F3);

    if(!istrue(self.hurt_enabled)) {
      continue;
    }
    if((isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)) && isalive(_id_1D9FB21B4F3023F3) && length(_id_834C12B34EA6616F.velocity) > 10 && (istrue(_id_1D9FB21B4F3023F3.inlaststand) || isagent(_id_1D9FB21B4F3023F3) || _id_1D9FB21B4F3023F3 istouching(traincar) || _id_1D9FB21B4F3023F3 istouching(traincar.linked_model) || traincar _id_28E551F1C8B6BF8D(_id_1D9FB21B4F3023F3))) {
      if(isDefined(self.script_label) && self.script_label == "hanging_only" && !_id_1D9FB21B4F3023F3 _meth_415FE9EECA7B2E2B()) {
        continue;
      }
      _id_1D9FB21B4F3023F3 dodamage(_id_1D9FB21B4F3023F3.health + 1000 * modifier, self.origin, self, self, "MOD_TRIGGER_HURT");
    }
  }
}

_id_28E551F1C8B6BF8D(_id_1D9FB21B4F3023F3) {
  _id_EA3B9640A6AD3C8E = _func_D559A384B9C4E7D9(_id_1D9FB21B4F3023F3.origin, self.origin, self.angles);
  return _id_EA3B9640A6AD3C8E[0] < 385 && abs(_id_EA3B9640A6AD3C8E[1]) < 95;
}

train_vfx_init() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  wait 0.1;

  foreach(traincar in level.wztrain_info.train_array) {
    if(traincar.linked_model getscriptablehaspart("train_part"))
      traincar.linked_model setscriptablepartstate("train_part", "moving");
  }
}

train_sfx_init() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  wait 0.1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.wztrain_info.train_array.size; _id_AC0E594AC96AA3A8++) {
    if(soundexists("veh_cargotrain_lp_" + _id_AC0E594AC96AA3A8))
      level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model playLoopSound("veh_cargotrain_lp_" + _id_AC0E594AC96AA3A8);

    if(_id_AC0E594AC96AA3A8 == level.wztrain_info.train_array.size - 1) {
      if(level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model getscriptablehaspart("train_rear_sfx"))
        level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model setscriptablepartstate("train_rear_sfx", "moving");
    }
  }
}

_id_85A3956C7630EA05() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("wztrain_array_set");
  wait 0.1;
}

_id_6BC539BE97B1FD75(_id_AC8B785B6B3DD536, _id_AC8B775B6B3DD303) {
  _id_5418BE00D083EAA2 = getEnt("br_passenger_train_prob_1", "script_noteworthy");
  _id_5418BD00D083E86F = getEnt("br_passenger_train_prob_2", "script_noteworthy");

  if(!isDefined(_id_5418BE00D083EAA2) || !isDefined(_id_5418BD00D083E86F)) {
    return;
  }
  _id_5418BE00D083EAA2.origin = _id_AC8B785B6B3DD536.origin;
  _id_5418BE00D083EAA2.angles = _id_AC8B785B6B3DD536.angles;
  _id_5418BE00D083EAA2 linkTo(_id_AC8B785B6B3DD536);
  _id_5418BD00D083E86F.origin = _id_AC8B775B6B3DD303.origin;
  _id_5418BD00D083E86F.angles = _id_AC8B775B6B3DD303.angles;
  _id_5418BD00D083E86F linkTo(_id_AC8B775B6B3DD303);
}

_id_7AF6D73425ACFFCA(train) {
  _id_69383545ADA0CC16 = level.wztrain_info._id_C3604781A9D33A7A["cargo_train"][0].linked_model;

  if(istrue(level._id_DF809D7B09E1A9C8))
    _id_69383545ADA0CC16 playsoundonmovingent("veh_horn_hell_train");
  else
    _id_69383545ADA0CC16 playsoundonmovingent("veh_horn_cargotrain");
}

_id_692FC55669413D6E(train) {
  _id_69383545ADA0CC16 = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][0].linked_model;
  _id_69383545ADA0CC16 playsoundonmovingent("veh_horn_passtrain");
}

_id_75B6817440FB2F13(train) {
  _id_69383545ADA0CC16 = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][0].linked_model;
  _id_69383545ADA0CC16 playsoundonmovingent("veh_passtrain_engine_stop");
  _id_917CAFBF6EEBF7C0 = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][2].linked_model;
  _id_917CAFBF6EEBF7C0 playsoundonmovingent("veh_passtrain_car1_stop");
  _id_071BB78D27F1FB46 = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][4].linked_model;
  _id_071BB78D27F1FB46 playsoundonmovingent("veh_passtrain_car2_stop");
  _id_01437B0CC477207C = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][6].linked_model;
  _id_01437B0CC477207C playsoundonmovingent("veh_passtrain_car1_stop");
  wait 2;
  _id_69383545ADA0CC16 playLoopSound("veh_passtrain_engine_idle_lp");
}

_id_86A923AAAAF82059(train) {
  _id_69383545ADA0CC16 = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][0].linked_model;
  _id_69383545ADA0CC16 playsoundonmovingent("veh_passtrain_engine_start");
  _id_917CAFBF6EEBF7C0 = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][2].linked_model;
  _id_917CAFBF6EEBF7C0 playsoundonmovingent("veh_passtrain_car1_start");
  _id_071BB78D27F1FB46 = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][4].linked_model;
  _id_071BB78D27F1FB46 playsoundonmovingent("veh_passtrain_car2_start");
  _id_01437B0CC477207C = level.wztrain_info._id_C3604781A9D33A7A["br_passenger_train"][6].linked_model;
  _id_01437B0CC477207C playsoundonmovingent("veh_passtrain_car1_start");
  wait 2;
  _id_69383545ADA0CC16 stoploopsound("veh_passtrain_engine_idle_lp");
}

_id_82196A101881992B(train) {
  soundent = spawn("script_origin", (-4669, 21728, 78));
  soundent playSound("veh_train_pass_overhead");
  scripts\engine\utility::exploder("tunnel_train");
  wait 31;
  soundent delete();
}

train_play_anim(train, array) {
  level endon("game_ended");
  _id_B4CD8F650ACE4580 = getdvarint("dvar_6B1F502CC55903CC", 0);

  if(_id_B4CD8F650ACE4580 > 0)
    wait(_id_B4CD8F650ACE4580);

  level.wztrain_info._id_4D221D6017330C71[train] = 0.25;
  level.wztrain_info._id_D935705DBBE8C4B7[train] = scripts\engine\utility::ter_op(train == "br_passenger_train", 0.35, 0.5);
  _id_902FCFFD5545E0F0 = getdvarfloat("dvar_940D6B55A5DBCF45", 5);
  level.wztrain_info._id_3033F7CB13BE4DC7[train] = squared(getdvarfloat("dvar_74B035E736B98642", 4000));
  level.wztrain_info._id_1017FF8C77611217[train] = squared(getdvarfloat("dvar_B2D8F4192A5928EA", 1800));
  _id_0DE7F7608BB03095 = train != "br_passenger_train";
  _id_0DE7F7608BB03095 = getdvarint("dvar_4EC068E522FADC85", _id_0DE7F7608BB03095);
  level.wztrain_info._id_4D221D6017330C71[train] = getdvarfloat("dvar_2763C64CC1B357F5", level.wztrain_info._id_4D221D6017330C71[train]);
  level.wztrain_info._id_D935705DBBE8C4B7[train] = getdvarfloat("dvar_12140BFEB0A869F3", level.wztrain_info._id_D935705DBBE8C4B7[train]);
  level.wztrain_info._id_4D221D6017330C71[train] = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", train, "_minRate"), level.wztrain_info._id_4D221D6017330C71[train]);
  level.wztrain_info._id_D935705DBBE8C4B7[train] = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", train, "_maxRate"), level.wztrain_info._id_D935705DBBE8C4B7[train]);
  _id_60278BCB8AC1212B = (level.wztrain_info._id_D935705DBBE8C4B7[train] - level.wztrain_info._id_4D221D6017330C71[train]) / _id_902FCFFD5545E0F0;
  _id_B3E01B11D76E1DB6 = level.wztrain_info._id_D935705DBBE8C4B7[train];
  _id_B2A3F9ABCEE9D071 = level.wztrain_info._id_B2A3F9ABCEE9D071[train];
  animstruct = level.wztrain_info.animstruct[train];
  _id_C458EDAC96D58B16 = animstruct.origin;
  _id_8C94765CA587F86C = animstruct.angles;
  _id_B2A3F9ABCEE9D071.isplayinganim = 1;
  _id_B2A3F9ABCEE9D071 notsolid();
  _id_B2A3F9ABCEE9D071 dontinterpolate();
  _id_85DE4B2384EA1FE3 = _id_B2A3F9ABCEE9D071.anim_override;

  if(isDefined(level.wztrain_info._id_80BF76189FA2ACFE))
    level thread[[level.wztrain_info._id_80BF76189FA2ACFE]](train);
  else
    animstruct thread scripts\common\anim::anim_loop_solo(_id_B2A3F9ABCEE9D071, _id_85DE4B2384EA1FE3);

  if(isDefined(level.wztrain_info._id_A474378E909E8412))
    [[level.wztrain_info._id_A474378E909E8412]](train, _id_B3E01B11D76E1DB6);

  _id_E26F44ACAD48DDD1 = level.scr_anim[train][_id_85DE4B2384EA1FE3];

  if(isarray(_id_E26F44ACAD48DDD1))
    _id_E26F44ACAD48DDD1 = level.scr_anim[train][_id_85DE4B2384EA1FE3][0];

  rate = 1.0;
  _id_D99757891D1ED279 = 1;
  _id_B2A3F9ABCEE9D071 setanimrate(_id_E26F44ACAD48DDD1, _id_B3E01B11D76E1DB6);
  dist = undefined;
  _id_2B899277239790CD = undefined;
  level.wztrain_info._id_C7FA4156EDB887D7[train] = [];
  level.wztrain_info._id_B7325FD9B510C3AE[train] = [];

  if(isDefined(level.wztrain_info._id_A086219602817DCA))
    [[level.wztrain_info._id_A086219602817DCA]](train);
  else if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702() || scripts\cp_mp\utility\game_utility::_id_DA8C49606D8AA048() || level.mapname == "mp_br_mechanics" || level.mapname == "mp_saba_st_dev") {
    level.wztrain_info._id_C7FA4156EDB887D7[train]["al_mazrah_city_station"] = (14270, 17197, 560.113);
    level.wztrain_info._id_C7FA4156EDB887D7[train]["ahkdar_station"] = (11421, -30213, 1032);
    level.wztrain_info._id_C7FA4156EDB887D7[train]["hafid_port"] = (-40724, -19572.6, 254.025);

    if(train == "cargo_train") {
      level.wztrain_info._id_C7FA4156EDB887D7[train]["oilfield"] = (-26700, 25058, -254.101);
      level.wztrain_info._id_B7325FD9B510C3AE[train]["al_mazrah_city_station"] = "ahkdar_station";
      level.wztrain_info._id_B7325FD9B510C3AE[train]["ahkdar_station"] = "hafid_port";
      level.wztrain_info._id_B7325FD9B510C3AE[train]["hafid_port"] = "oilfield";
      level.wztrain_info._id_B7325FD9B510C3AE[train]["oilfield"] = "al_mazrah_city_station";
    } else {
      level.wztrain_info._id_B7325FD9B510C3AE[train]["al_mazrah_city_station"] = "hafid_port";
      level.wztrain_info._id_B7325FD9B510C3AE[train]["hafid_port"] = "ahkdar_station";
      level.wztrain_info._id_B7325FD9B510C3AE[train]["ahkdar_station"] = "al_mazrah_city_station";
    }
  }

  [dist, _id_2B899277239790CD] = _id_10587AAF16F21C55(_id_B2A3F9ABCEE9D071.origin, level.wztrain_info._id_C7FA4156EDB887D7[train]);

  foreach(traincar in array) {
    if(traincar.linked_model isscriptable() && traincar.linked_model getscriptablehaspart("nearby_station"))
      traincar.linked_model setscriptablepartstate("nearby_station", _id_2B899277239790CD);
  }

  scripts\engine\utility::flag_set("wztrain_anim_playing");
  _id_8EE1CE7ECCBE27E2 = 0;
  _id_D39503B81E23651D = gettime();
  _id_A2ECE17A4D653D0A = [];
  _id_46D4BFF0EFAA1A0E = (1400, 180, 180);
  _id_AA6594CB5CAB804B = [array[1], array[5]];

  if(isDefined(level.wztrain_info._id_11498702BEAFAA13))
    [_id_46D4BFF0EFAA1A0E, _id_AA6594CB5CAB804B] = [[level.wztrain_info._id_11498702BEAFAA13]](array);

  if(getdvarint("dvar_F524D127E4BA82C4", 0) == 0) {
    for(;;) {
      if(gettime() > _id_D39503B81E23651D) {
        _id_D39503B81E23651D = gettime() + 2000;

        foreach(_id_9794CF618646A8BD in _id_A2ECE17A4D653D0A)
        destroynavobstacle(_id_9794CF618646A8BD);

        _id_A2ECE17A4D653D0A = [];

        foreach(traincar in _id_AA6594CB5CAB804B)
        _id_A2ECE17A4D653D0A[_id_A2ECE17A4D653D0A.size] = createnavobstaclebybounds(traincar.origin, _id_46D4BFF0EFAA1A0E, traincar.angles);
      }

      if(isDefined(level.wztrain_info._id_C7FA4156EDB887D7[train]) && level.wztrain_info._id_C7FA4156EDB887D7[train].size > 0 && _id_0DE7F7608BB03095) {
        [dist, _id_B3E01B11D76E1DB6, _id_D99757891D1ED279] = _id_3EBE5A3DE48D68B9(dist, _id_B3E01B11D76E1DB6, _id_D99757891D1ED279, train);

        if(!scripts\engine\utility::array_contains(level.wztrain_info._id_1A30B87276ED28E5, train))
          rate = _id_5FD79768B8941CFB::_id_DBF72252B51C25AF(_id_B2A3F9ABCEE9D071, _id_E26F44ACAD48DDD1, _id_D99757891D1ED279, _id_60278BCB8AC1212B, rate, _id_B3E01B11D76E1DB6);
      }

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        _id_DB9A56EDADC7D853 = level.wztrain_info.train_tag_array[_id_AC0E594AC96AA3A8];
        targetorigin = _id_B2A3F9ABCEE9D071 gettagorigin(_id_DB9A56EDADC7D853);
        targetangles = _id_B2A3F9ABCEE9D071 gettagangles(_id_DB9A56EDADC7D853);

        if(istrue(array[_id_AC0E594AC96AA3A8]._id_02E4045FFDF8A8F7))
          targetangles = _id_82B691DA7415DE2A(targetangles);

        tagoffset = level.wztrain_info.train_tagoffset_array[_id_AC0E594AC96AA3A8];

        if(tagoffset != (0, 0, 0)) {
          _id_35FD13041DDE93E8 = anglestoaxis(targetangles);
          targetorigin = targetorigin + _id_35FD13041DDE93E8["forward"] * tagoffset[0];
          targetorigin = targetorigin + _id_35FD13041DDE93E8["right"] * tagoffset[1];
          targetorigin = targetorigin + _id_35FD13041DDE93E8["up"] * tagoffset[2];
        }

        fraction = 0.1;
        targetorigin = vectorlerp(array[_id_AC0E594AC96AA3A8].linked_model.origin, targetorigin, fraction);
        array[_id_AC0E594AC96AA3A8].linked_model.origin = targetorigin;
        targetangles = anglelerpquatfrac(array[_id_AC0E594AC96AA3A8].linked_model.angles, targetangles, fraction);
        array[_id_AC0E594AC96AA3A8].linked_model.angles = targetangles;
      }

      waitframe();
      waittillframeend;
    }
  }
}

_id_3EBE5A3DE48D68B9(dist, _id_B3E01B11D76E1DB6, _id_D99757891D1ED279, train) {
  [_id_5C1EE5AB8012EA11, _id_2B899277239790CD] = _id_10587AAF16F21C55(level.wztrain_info._id_B2A3F9ABCEE9D071[train].origin, level.wztrain_info._id_C7FA4156EDB887D7[train]);

  if(isDefined(_id_5C1EE5AB8012EA11)) {
    _id_82FE246E16D020C3 = _id_5C1EE5AB8012EA11 < dist;
    dist = _id_5C1EE5AB8012EA11;

    if(_id_82FE246E16D020C3 && _id_D99757891D1ED279 == 1 && dist < level.wztrain_info._id_3033F7CB13BE4DC7[train]) {
      _id_D99757891D1ED279 = -1;
      _id_B3E01B11D76E1DB6 = level.wztrain_info._id_4D221D6017330C71[train];

      if(isDefined(level.wztrain_info._id_3BAA47599DD64511))
        thread[[level.wztrain_info._id_3BAA47599DD64511]](train, _id_2B899277239790CD);
    } else if(!_id_82FE246E16D020C3 && _id_D99757891D1ED279 == -1 && dist > level.wztrain_info._id_1017FF8C77611217[train]) {
      _id_D99757891D1ED279 = 1;
      _id_B3E01B11D76E1DB6 = level.wztrain_info._id_D935705DBBE8C4B7[train];

      if(isDefined(level.wztrain_info._id_1256D82C90A0D4DC))
        thread[[level.wztrain_info._id_1256D82C90A0D4DC]](train);

      foreach(traincar in level.wztrain_info._id_C3604781A9D33A7A[train]) {
        if(traincar.linked_model isscriptable() && traincar.linked_model getscriptablehaspart("nearby_station"))
          traincar.linked_model setscriptablepartstate("nearby_station", level.wztrain_info._id_B7325FD9B510C3AE[train][_id_2B899277239790CD]);
      }
    }
  }

  return [dist, _id_B3E01B11D76E1DB6, _id_D99757891D1ED279];
}

_id_82B691DA7415DE2A(targetangles) {
  return targetangles + (-2 * targetangles[0], 180, 0);
}

_id_10587AAF16F21C55(_id_341D52E9B9415E77, _id_9BCDCBA2FB68DCAA) {
  _id_636C8575D7A7768B = undefined;
  _id_2C08D7B219E35393 = undefined;
  _id_819EDACDACB810E4 = undefined;
  _id_E86632D645C137D0 = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    _id_819EDACDACB810E4 = _id_2695A20D4011076D::getdangercircleorigin();
    _id_E86632D645C137D0 = _id_2695A20D4011076D::getdangercircleradius();
  }

  foreach(_id_343B2D4BFAAF4F1E, _id_D54DDF1A95EDD0C7 in _id_9BCDCBA2FB68DCAA) {
    if(getdvarint("dvar_E614A3B36E6D3FCA", 0) > 0) {
      if(isDefined(_id_819EDACDACB810E4) && _id_2695A20D4011076D::_id_024C5A8D31AE262F(_id_D54DDF1A95EDD0C7, _id_819EDACDACB810E4, _id_E86632D645C137D0))
        continue;
    }

    dist = distance2dsquared(_id_D54DDF1A95EDD0C7, _id_341D52E9B9415E77);

    if(!isDefined(_id_636C8575D7A7768B) || dist < _id_636C8575D7A7768B) {
      _id_636C8575D7A7768B = dist;
      _id_2C08D7B219E35393 = _id_343B2D4BFAAF4F1E;
    }
  }

  return [_id_636C8575D7A7768B, _id_2C08D7B219E35393];
}

_id_B91FF337122B31FE() {
  foreach(traincar in level.wztrain_info.train_array)
  traincar scripts\engine\flags::assign_unique_id();
}

train_play_anim_init() {
  level.scr_animtree["cargo_train"] = #animtree;
  level.scr_animtree["br_passenger_train"] = #animtree;

  if(isDefined(level.wztrain_info._id_799BABD43D318D4B))
    [[level.wztrain_info._id_799BABD43D318D4B]]();
  else {
    if(istrue(level._id_DF809D7B09E1A9C8)) {
      level.scr_anim["cargo_train"]["full_anim_290"][0] = % iw9_mp_helltrain_saba_ccw;
      level.scr_animname["cargo_train"]["full_anim_290"][0] = "iw9_mp_helltrain_saba_ccw";
    } else {
      level.scr_anim["cargo_train"]["full_anim_290"][0] = % iw9_mp_train_saba_a_cw;
      level.scr_animname["cargo_train"]["full_anim_290"][0] = "iw9_mp_train_saba_a_cw";
    }

    level.scr_anim["br_passenger_train"]["full_anim_290"][0] = % iw9_mp_train_saba_b_ccw;
    level.scr_animname["br_passenger_train"]["full_anim_290"][0] = "iw9_mp_train_saba_b_ccw";
  }

  scripts\common\anim::addnotetrack_customfunction("cargo_train", "br_train_horn", ::_id_7AF6D73425ACFFCA);
  scripts\common\anim::addnotetrack_customfunction("br_passenger_train", "br_pass_train_horn", ::_id_692FC55669413D6E);
  scripts\common\anim::addnotetrack_customfunction("br_passenger_train", "br_pass_train_start", ::_id_86A923AAAAF82059);
  scripts\common\anim::addnotetrack_customfunction("br_passenger_train", "br_pass_train_stop", ::_id_75B6817440FB2F13);
  scripts\common\anim::addnotetrack_customfunction("br_passenger_train", "br_pass_train_tnnl", ::_id_82196A101881992B);
  level.wztrain_info.train_tag_array = [];

  if(isDefined(level.wztrain_info._id_0ED3CE45AE9F6B34))
    level.wztrain_info.train_tag_array = [[level.wztrain_info._id_0ED3CE45AE9F6B34]]();
  else if(istrue(level._id_DF809D7B09E1A9C8)) {
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "engine_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "passenger_01_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "passenger_02_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "passenger_03_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "passenger_04_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "passenger_05_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "flatbed_01_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "boxcar_01_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "boxcar_02_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "flatbed_02_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "flatbed_03_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "flatbed_04_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "flatbed_05_tag_origin_animate";
  } else {
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "engine_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "saba01_train1_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "saba01_train2_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "saba01_train3_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "saba01_train4_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "saba01_train5_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "saba01_train6_tag_origin_animate";
    level.wztrain_info.train_tag_array[level.wztrain_info.train_tag_array.size] = "saba01_train7_tag_origin_animate";
  }

  level.wztrain_info.train_tagoffset_array = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.wztrain_info.train_tag_array.size; _id_AC0E594AC96AA3A8++)
    level.wztrain_info.train_tagoffset_array[_id_AC0E594AC96AA3A8] = (0, 0, 0);

  waitframe();
  spawnposition = (0, 0, 13);
  spawnangles = (0, 0, 0);

  if(isDefined(level.wztrain_info.anim_spawnposition_override))
    spawnposition = level.wztrain_info.anim_spawnposition_override;

  level.wztrain_info.animstruct = [];
  level.wztrain_info._id_B2A3F9ABCEE9D071 = [];

  foreach(train, array in level.wztrain_info._id_C3604781A9D33A7A) {
    animstruct = spawnStruct();
    level.wztrain_info.animstruct[train] = animstruct;
    animstruct.origin = spawnposition;
    animstruct.angles = spawnangles;
    _id_B2A3F9ABCEE9D071 = spawn("script_model", animstruct.origin);
    level.wztrain_info._id_B2A3F9ABCEE9D071[train] = _id_B2A3F9ABCEE9D071;

    if(isDefined(level.wztrain_info._id_00E52CCB14A1AAE9))
      _id_B2A3F9ABCEE9D071 setModel([[level.wztrain_info._id_00E52CCB14A1AAE9]]());
    else if(istrue(level._id_DF809D7B09E1A9C8))
      _id_B2A3F9ABCEE9D071 setModel("veh9_ind_lnd_hell_train_assembly");
    else
      _id_B2A3F9ABCEE9D071 setModel("veh9_civ_lnd_train_assembly");

    _id_B2A3F9ABCEE9D071.angles = animstruct.angles;
    _id_B2A3F9ABCEE9D071.animname = train;
    _id_B2A3F9ABCEE9D071 useanimtree(level.scr_animtree[train]);
    _id_B2A3F9ABCEE9D071 forcenetfieldhighlod(1);
    _id_B2A3F9ABCEE9D071 setmoveroptimized(1);
    _id_B2A3F9ABCEE9D071 setmoverantilagged(1);
    _id_B2A3F9ABCEE9D071.anim_override = scripts\engine\utility::_id_53C4C53197386572(level.wztrain_info._id_0DDC55FBCFA86D44, "full_anim_290");
  }
}

_id_51DA224C93D325F3(einflictor) {
  self playSound("train_veh_impact_body");

  if(isDefined(einflictor) && isDefined(einflictor._id_834C12B34EA6616F)) {
    if(isDefined(einflictor._id_834C12B34EA6616F.script_noteworthy) && einflictor._id_834C12B34EA6616F.script_noteworthy == "train_car_20")
      einflictor._id_834C12B34EA6616F playsoundonmovingent("veh_horn_passtrain");
    else if(istrue(level._id_DF809D7B09E1A9C8))
      einflictor._id_834C12B34EA6616F playsoundonmovingent("veh_horn_hell_train");
    else
      einflictor._id_834C12B34EA6616F playsoundonmovingent("veh_horn_cargotrain");
  }
}

crate_follow_text() {
  level endon("game_ended");

  for(;;)
    wait 1;
}

any_player_nearby(origin, _id_A9B6B677F6D0A010) {
  foreach(player in level.players) {
    if(distancesquared(player.origin, origin) < _id_A9B6B677F6D0A010)
      return 1;
  }

  return 0;
}

warp_player_debug() {
  level endon("game_ended");

  if(getdvarint("dvar_DD6E65EC80098E72", 0) == 0) {
    return;
  }
  while(!isDefined(level.player) || !isalive(level.player))
    wait 0.1;

  level.player endon("death_or_disconnect");
  wait 1;
  level thread debug_warpplayer_monitor();
  level.player waittill("skydive_deployparachute");
  wait 0.5;
  _id_D5685B7BAEE6505E = level.wztrain_info.train_array[0].origin;
  level.player setOrigin(_id_D5685B7BAEE6505E + (0, 0, 4096));
}

debug_warpplayer_monitor() {
  level endon("game_ended");
  level.player endon("disconnect");
  level.player notifyonplayercommand("dpad_left_press", "+actionslot 3");

  for(;;) {
    level.player waittill("dpad_left_press");
    _id_D5685B7BAEE6505E = level.wztrain_info.train_array[1].origin;

    foreach(player in level.players)
    player setOrigin(_id_D5685B7BAEE6505E + (0, 0, 200));

    waitframe();
  }
}

debug_display_veh_hit(eventdata, damage) {}

blink_train_test() {
  level endon("game_ended");

  for(;;) {
    wait 1;

    foreach(traincar in level.wztrain_info.train_array)
    traincar.linked_model hide();

    wait 1;

    foreach(traincar in level.wztrain_info.train_array)
    traincar.linked_model show();
  }
}

_id_B002D10BD710CC12(offset, traincar) {
  if(!istrue(level._id_70B4BB4CD9143462))
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("train_safe", ::_id_7C5EEFD0CBCE6520);

  level._id_70B4BB4CD9143462 = 1;
  offset = offset + (0, 0, 43);
  _id_32605DB102447D94 = spawn("script_model", traincar.linked_model.origin + offset);
  _id_32605DB102447D94 setModel("dmz_train_safe");
  _id_32605DB102447D94.angles = (0, 0, 0);
  _id_32605DB102447D94 linkTo(traincar.linked_model);
  _id_32605DB102447D94._id_BF8E5F003146AF44 = traincar.linked_model;
  _id_32605DB102447D94._id_085E53E70C7110DA = [];
  scriptable = _id_32605DB102447D94 getlinkedscriptableinstance();
  scriptable._id_BF8E5F003146AF44 = traincar.linked_model;
  scriptable._id_CEB543956C7203E7 = ::_id_9618CC73546D253D;
  _id_32605DB102447D94 setscriptablepartstate("train_safe", "usable_not_open");

  if(_id_3AACF02225CA0DA5::_id_94B502046C767CD1() == "train") {
    _id_32605DB102447D94 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Boss_Focus_SM_Dmz", self.origin, 3000);
    _id_32605DB102447D94 scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
    _id_32605DB102447D94.mapcircle linkTo(_id_32605DB102447D94);
    _id_32605DB102447D94 thread _id_8A7BB55ABDEE8269();
  }
}

_id_9618CC73546D253D(_id_69E96A4CAA72D794, player) {
  if(!isDefined(_id_69E96A4CAA72D794) || !isDefined(player)) {
    return;
  }
  _id_69E96A4CAA72D794 setscriptablepartstate("train_safe", "open_usable");
}

_id_7C5EEFD0CBCE6520(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(state == "usable_not_open") {
    instance setscriptablepartstate(part, "unusable");
    instance._id_B14A331BA425C286 = 0;
    instance thread _id_662CBAC61C1AE7E2::_id_24765A7AABF0093E(player);
    instance.entity _id_662CBAC61C1AE7E2::_id_7F10E8E120314F4B(player, part);

    if(istrue(instance.entity._id_B14A331BA425C286)) {
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_train_safe_defend_started", level.players);
      _id_6F6FF85C52FAB8FF(instance.entity, "drill", player);
      wait 1;
      instance.entity thread _id_04B2E6BD87A657B6();
    } else
      instance setscriptablepartstate(part, "usable_not_open");
  } else if(state == "open_usable") {
    if(instance getscriptableparthasstate(part, "unusable"))
      instance setscriptablepartstate(part, "unusable");

    if(!isDefined(instance.contents)) {
      items = getscriptcachecontents("train_safe");

      if(_id_3AACF02225CA0DA5::_id_94B502046C767CD1() == "train")
        _id_3AACF02225CA0DA5::_id_F9EC88C3D71324CD();
      else
        items = scripts\engine\utility::array_remove(items, "brloot_weaponcase");

      items[items.size] = "brloot_aq_train_manifest";
      items = scripts\engine\utility::array_randomize(items);
      instance._id_46A3A8565AC0C17C = 4;
      instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 1, player, instance.contents);
    } else
      instance _id_552B8E4EA5FF7DF1::lootcachespawncontents(undefined, 1, player, instance.contents);
  } else if(state == "usable_drilling") {
    instance.entity.paused = 0;
    _id_6F6FF85C52FAB8FF(instance.entity, "drill", player);
    instance setscriptablepartstate("train_safe", "unusable_drilling");
  }
}

_id_04B2E6BD87A657B6() {
  thread _id_DE90BD6BD487DBA7();
  thread _id_D0C5BF4C2D924D87();
  thread _id_07515098C2D459B5();

  if(0)
    thread _id_3950F666F426E1A4();
}

_id_DE90BD6BD487DBA7() {
  self endon("captured");
  self.curorigin = self.origin;
  self.offset3d = (0, 0, 70);
  scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  _id_DB3EC7BAD51739CA = self.objidnum;
  self._id_DB3EC7BAD51739CA = _id_DB3EC7BAD51739CA;
  objective_setpings(_id_DB3EC7BAD51739CA, 1);
  objective_setzoffset(_id_DB3EC7BAD51739CA, 70);
  objective_icon(_id_DB3EC7BAD51739CA, "ui_map_icon_safe");
  objective_setbackground(_id_DB3EC7BAD51739CA, 1);
  objective_state(_id_DB3EC7BAD51739CA, "current");
  scripts\mp\objidpoolmanager::update_objective_onentity(_id_DB3EC7BAD51739CA, self);
  objective_setownerteam(_id_DB3EC7BAD51739CA, undefined);
  objective_setprogressteam(_id_DB3EC7BAD51739CA, undefined);
  scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(_id_DB3EC7BAD51739CA, 16);
  scripts\mp\objidpoolmanager::objective_set_play_intro(_id_DB3EC7BAD51739CA, 1);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_DB3EC7BAD51739CA);
  scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  _id_75F558A60D4866EA = self.objidnum;
  self._id_75F558A60D4866EA = _id_75F558A60D4866EA;
  scripts\mp\objidpoolmanager::update_objective_icon(_id_75F558A60D4866EA, "ui_map_icon_safe");
  scripts\mp\objidpoolmanager::update_objective_setbackground(_id_75F558A60D4866EA, 1);
  scripts\mp\objidpoolmanager::objective_pin_global(_id_75F558A60D4866EA, 1);
  scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(_id_75F558A60D4866EA, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(_id_75F558A60D4866EA, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(_id_75F558A60D4866EA);
  scripts\mp\objidpoolmanager::update_objective_onentity(_id_75F558A60D4866EA, self);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(_id_75F558A60D4866EA, 70);
  scripts\mp\objidpoolmanager::update_objective_state(_id_75F558A60D4866EA, "invisible");
  objective_setshowprogress(_id_75F558A60D4866EA, 1);
  self._id_78122E18403A8DC4 = [];
  self._id_7F678C2DC78B1EAB = 0;
  _id_D83AA4B44EFF7B60 = gettime();
  _id_47FD265041DEA4AB = 0;

  for(;;) {
    _id_C8DADD43AEFDC396 = [];

    foreach(player in level.players) {
      if(isDefined(player.origin) && distancesquared(self.origin, player.origin) < 640000) {
        _id_61A1A37391FB592E = player scripts\cp_mp\utility\train_utility::_id_31156831AFC882AD();

        if(isDefined(_id_61A1A37391FB592E) && _id_61A1A37391FB592E == "cargo_train")
          _id_C8DADD43AEFDC396[_id_C8DADD43AEFDC396.size] = player;
      }
    }

    if(_id_C8DADD43AEFDC396.size > 0)
      _id_D83AA4B44EFF7B60 = gettime();

    _id_BA2E680C7043AB1F = gettime() - _id_D83AA4B44EFF7B60 > 20000;

    if(self._id_7F678C2DC78B1EAB && !_id_BA2E680C7043AB1F && istrue(self._id_2847F8D00AEE9DC7) && isDefined(self.heli))
      self.heli notify("newpath");

    self._id_7F678C2DC78B1EAB = _id_BA2E680C7043AB1F;
    _id_0E34E332590AC462 = scripts\engine\utility::array_difference(_id_C8DADD43AEFDC396, self._id_78122E18403A8DC4);
    _id_EA6B4EEEAEA5CDC3 = scripts\engine\utility::array_difference(self._id_78122E18403A8DC4, _id_C8DADD43AEFDC396);

    if(istrue(self.paused) != _id_47FD265041DEA4AB) {
      foreach(player in self._id_78122E18403A8DC4) {
        if(isDefined(player)) {
          scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(_id_75F558A60D4866EA, player);
          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_75F558A60D4866EA, player);
        }
      }

      self._id_78122E18403A8DC4 = [];
      _id_47FD265041DEA4AB = istrue(self.paused);
      waitframe();
      continue;
    }

    _id_47FD265041DEA4AB = istrue(self.paused);
    _id_9DE1C91D7176D1BB = scripts\engine\utility::ter_op(_id_47FD265041DEA4AB, &"MP_DMZ_MISSIONS/SAFE_PAUSED", &"MP_DMZ_MISSIONS/OPENING_SAFE");

    foreach(player in _id_0E34E332590AC462) {
      if(isDefined(player)) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_75F558A60D4866EA, player);
        scripts\mp\objidpoolmanager::_id_CE702E5925E31FC9(_id_75F558A60D4866EA, player, 2, 2, _id_9DE1C91D7176D1BB);
      }
    }

    foreach(player in _id_EA6B4EEEAEA5CDC3) {
      if(isDefined(player)) {
        scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(_id_75F558A60D4866EA, player);
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_75F558A60D4866EA, player);
      }
    }

    self._id_78122E18403A8DC4 = _id_C8DADD43AEFDC396;
    _id_4B6B489DAE052A24 = [];

    foreach(player in _id_C8DADD43AEFDC396) {
      if(!isDefined(player.team)) {
        continue;
      }
      if(!isDefined(_id_4B6B489DAE052A24[player.team]))
        _id_4B6B489DAE052A24[player.team] = 0;

      _id_4B6B489DAE052A24[player.team] = _id_4B6B489DAE052A24[player.team] + 1;
    }

    max = 0;
    _id_2E0BDB36F81A37E4 = "team_hundred_ninety_five";

    foreach(team, count in _id_4B6B489DAE052A24) {
      if(count > max) {
        _id_2E0BDB36F81A37E4 = team;
        max = count;
        continue;
      }

      if(count == max)
        _id_2E0BDB36F81A37E4 = "team_hundred_ninety_five";
    }

    objective_setownerteam(_id_75F558A60D4866EA, _id_2E0BDB36F81A37E4);
    objective_setprogressteam(_id_75F558A60D4866EA, _id_2E0BDB36F81A37E4);
    objective_setownerteam(_id_DB3EC7BAD51739CA, _id_2E0BDB36F81A37E4);
    objective_setprogressteam(_id_DB3EC7BAD51739CA, _id_2E0BDB36F81A37E4);
    objective_setpulsate(_id_DB3EC7BAD51739CA, 1);
    wait 1;
  }
}

_id_8A7BB55ABDEE8269() {
  level waittill("interuptWeaponCaseShow");
  self.objidnum = self._id_DB3EC7BAD51739CA;
  scripts\mp\gameobjects::releaseid();
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}

_id_D0C5BF4C2D924D87() {
  objid = self._id_75F558A60D4866EA;
  self.progress = 0;
  capturetime = getdvarint("dvar_6C7F918CF6EEC58C", 180);

  while(self.progress < 1) {
    if(self._id_78122E18403A8DC4.size > 0 && !istrue(self.paused)) {
      _id_BFBD5393EF742E6E = clamp(self.progress + level.framedurationseconds / capturetime, 0, 1);

      if(_id_BFBD5393EF742E6E > 0.33 && self.progress < 0.33 || _id_BFBD5393EF742E6E > 0.67 && self.progress < 0.67) {
        self.paused = 1;
        _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_train_safe_paused", self._id_78122E18403A8DC4);
        self setscriptablepartstate("train_safe", "usable_drilling");
      }

      self.progress = _id_BFBD5393EF742E6E;
      scripts\mp\objidpoolmanager::objective_set_progress(objid, self.progress);
    } else if(!istrue(self.paused)) {
      min = 0;

      if(self.progress > 0.67)
        min = 0.671;
      else if(self.progress > 0.33)
        min = 0.331;

      self.progress = clamp(self.progress - level.framedurationseconds / 180, min, 1);
      scripts\mp\objidpoolmanager::objective_set_progress(objid, self.progress);
    }

    waitframe();
  }

  _id_E188C0417CE5BA50();
}

_id_07515098C2D459B5() {
  self endon("captured");
  spawndata = spawnStruct();
  spawndata.origin = _id_9FD3CCDA7AE6B51E();
  spawndata._id_F16652E1462A3739 = 1;
  spawndata.team = "team_hundred_ninety_five";
  heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata);
  self.heli = heli;
  heli._id_6DF468049C1F41DC = 1;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(heli);
  _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.origin);
  origin = scripts\engine\utility::ter_op(isDefined(level._id_F0872E42DAF6D4D5), level._id_F0872E42DAF6D4D5, spawndata.origin);
  riders = [];

  for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    aitype = _id_48814951E916AF89::_id_D5BC07EABF352ABB(undefined, _id_B205D90302DA2F07, undefined, scripts\engine\utility::random(["sniper", "ar", "lmg"]), 3);
    rider = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, (0, 0, 0), "absolute", "reinforcements", "train_safe", undefined, undefined, undefined, "bossArea", 1, undefined, 0);

    if(!isDefined(rider)) {
      continue;
    }
    riders[_id_AC0E594AC96AA3A8] = rider;
    rider thread _id_6DA65222586132F5(heli);
    _id_48814951E916AF89::_id_C9B9FE3F7F739586(rider);
  }

  _id_2BC0B0102F9B7751::_id_7045FB761A4998E3(heli);
  heli scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders, 1, 1);
  thread _id_89F2A5C485A151DB(heli);
  heli waittill("death");
  wait 10;

  while(istrue(self._id_7F678C2DC78B1EAB))
    wait 3;

  _id_07515098C2D459B5();
}

_id_3950F666F426E1A4() {
  for(;;) {
    foreach(offset in [(1500, 600, 600), (2400, -430, 450), (2400, 430, 450), (1200, -600, 500), (500, 0, 400)]) {}

    waitframe();
  }
}

_id_6DA65222586132F5(heli) {
  heli endon("death");
  self waittill("death", _id_6181DE250AFA5BB6, meansofdeath);
  heli dodamage(int(heli.maxhealth / 7), _id_6181DE250AFA5BB6.origin, _id_6181DE250AFA5BB6, _id_6181DE250AFA5BB6, meansofdeath);
}

_id_9FD3CCDA7AE6B51E() {
  return self._id_BF8E5F003146AF44.origin + rotatevector((-1000, 0, 5000), self._id_BF8E5F003146AF44.angles);
}

_id_8F1AEFE1E8750F84(heli) {
  goal = scripts\engine\utility::random([(1500, 600, 600), (2400, -430, 450), (2400, 430, 450), (1200, -600, 500), (500, 0, 400)]);
  goalstruct = spawnStruct();
  goalstruct.origin = self._id_BF8E5F003146AF44.origin + rotatevector(goal, self._id_BF8E5F003146AF44.angles);
  goalstruct.speed = 60;
  goalstruct.radius = 150;
  trace = scripts\engine\trace::sphere_trace(heli.origin, goalstruct.origin, 200, undefined, scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0));

  if(trace["fraction"] < 1.0)
    goalstruct.origin = goalstruct.origin + (0, 0, 1500);

  return goalstruct;
}

_id_BDE42941FC546C67() {
  goalstruct = spawnStruct();
  goalstruct.origin = self._id_BF8E5F003146AF44.origin + rotatevector((-1000, 0, 7000), self._id_BF8E5F003146AF44.angles);
  goalstruct.speed = 60;
  goalstruct.radius = 200;
  return goalstruct;
}

_id_89F2A5C485A151DB(heli) {
  heli endon("death");

  for(;;) {
    self._id_2847F8D00AEE9DC7 = 0;

    if(istrue(self._id_6DFAEE5EE2B3FA4B) || istrue(self._id_7F678C2DC78B1EAB)) {
      self._id_2847F8D00AEE9DC7 = 1;
      heli scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_BDE42941FC546C67());

      if(istrue(self._id_6DFAEE5EE2B3FA4B) || istrue(self._id_7F678C2DC78B1EAB)) {
        heli thread scripts\cp_mp\vehicles\vehicle::vehicle_death(heli);
        return;
      }
    } else
      heli scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_8F1AEFE1E8750F84(heli));
  }
}

_id_E188C0417CE5BA50() {
  self notify("captured");
  self._id_6DFAEE5EE2B3FA4B = 1;
  _id_1B8524F934EDD790 = [];

  foreach(player in self._id_78122E18403A8DC4) {
    scripts\mp\objidpoolmanager::objective_unpin_player(self._id_75F558A60D4866EA, player);
    scripts\mp\objidpoolmanager::_id_26259BD38697B5AD(self._id_75F558A60D4866EA, player);
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self._id_75F558A60D4866EA, player);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self._id_DB3EC7BAD51739CA, player);

    if(!isDefined(player._id_35B94C88CC1CEA97))
      player._id_35B94C88CC1CEA97 = 0;

    player._id_35B94C88CC1CEA97++;
    player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_C02C8C802F07C908");

    if(isDefined(player) && isDefined(player.team) && !isDefined(_id_1B8524F934EDD790[player.team]))
      _id_1B8524F934EDD790[player.team] = 1;
  }

  foreach(team, value in _id_1B8524F934EDD790)
  _id_6A8EC730B2BFA844::_id_A9F8FA06A358585B(team, "train_safe", 1, undefined, 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_train_safe_defend_unlocked", self._id_78122E18403A8DC4);
  _id_6F6FF85C52FAB8FF(self, "open", self._id_78122E18403A8DC4);
  self.objidnum = self._id_75F558A60D4866EA;
  scripts\mp\gameobjects::releaseid();

  if(_id_3AACF02225CA0DA5::_id_94B502046C767CD1() != "train") {
    self.objidnum = self._id_DB3EC7BAD51739CA;
    scripts\mp\gameobjects::releaseid();
  }

  self setscriptablepartstate("train_safe", "opening");
}

_id_82563367AA26CD19(array) {
  _id_BFC65A378A6D8EFE = [];

  foreach(_id_80EF668C09FFB70F in array) {
    _id_B30B086EBFEB7F53 = scripts\mp\utility\player::isreallyalive(_id_80EF668C09FFB70F);

    if(!_id_B30B086EBFEB7F53) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = _id_80EF668C09FFB70F;
  }

  return _id_BFC65A378A6D8EFE;
}

_id_1533FFC339E9487F(radius) {
  _id_32605DB102447D94 = self;
  level endon("game_ended");
  _id_32605DB102447D94 endon("captured");
  _id_32605DB102447D94 notify("stop_watching_music_players");
  _id_32605DB102447D94 endon("stop_watching_music_players");

  while(istrue(self._id_6DFAEE5EE2B3FA4B) == 0) {
    foreach(entnum, player in _id_32605DB102447D94._id_085E53E70C7110DA) {
      if(!isDefined(player))
        _id_32605DB102447D94._id_085E53E70C7110DA[entnum] = undefined;
    }

    _id_EB6088E47E4F1402 = _id_7AB5B649FA408138::_id_D6FE092BC83DA45B(_id_32605DB102447D94.origin, radius);
    _id_CAD5DF321A29FDDA = scripts\engine\utility::array_difference(_id_32605DB102447D94._id_085E53E70C7110DA, _id_EB6088E47E4F1402);
    _id_E45DFEF528956315 = _id_82563367AA26CD19(_id_EB6088E47E4F1402);
    _id_3C67775AFD800950 = scripts\engine\utility::array_difference(_id_EB6088E47E4F1402, _id_E45DFEF528956315);
    _id_496EB519D6161ECA = scripts\engine\utility::array_combine(_id_CAD5DF321A29FDDA, _id_3C67775AFD800950);

    if(isarray(_id_496EB519D6161ECA) && _id_496EB519D6161ECA.size > 0) {
      _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565(_id_496EB519D6161ECA, "", 0.5);

      foreach(player in _id_496EB519D6161ECA) {
        _id_C53E78332A6C514F = player getentitynumber();
        _id_32605DB102447D94._id_085E53E70C7110DA[_id_C53E78332A6C514F] = undefined;
      }
    }

    _id_0D8E566314371B23 = randomintrange(2, 20);
    waittime = _id_0D8E566314371B23 * 0.05;
    _id_32605DB102447D94 scripts\engine\utility::waittill_any_timeout_1(waittime, "captured");
  }
}

_id_6F6FF85C52FAB8FF(_id_32605DB102447D94, statename, _id_A663B5760127728D) {
  _id_20ABC022843B0C15 = isPlayer(_id_A663B5760127728D);
  _id_36816541C60BEDAD = isarray(_id_A663B5760127728D);
  _id_113CD49F1CD74678 = getdvarint("dvar_1DCF60C7D07DEE2E", 4725);

  switch (statename) {
    default:
      break;
    case "drill":
      if(istrue(_id_20ABC022843B0C15)) {
        player = _id_A663B5760127728D;
        _id_A6AB8D0FDA441DC2 = _id_7AB5B649FA408138::_id_D6FE092BC83DA45B(player, _id_113CD49F1CD74678, _id_A663B5760127728D.team);

        if(isarray(_id_A6AB8D0FDA441DC2) && _id_A6AB8D0FDA441DC2.size > 0) {
          _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565(_id_A6AB8D0FDA441DC2, "dmz_train_safe_drill", 0.5, "dmz_train_safe_drill_classic");

          foreach(player in _id_A6AB8D0FDA441DC2) {
            _id_C53E78332A6C514F = player getentitynumber();
            _id_32605DB102447D94._id_085E53E70C7110DA[_id_C53E78332A6C514F] = player;
          }
        }
      }

      break;
    case "away":
      if(istrue(_id_20ABC022843B0C15)) {
        player = _id_A663B5760127728D;
        _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565([player], "", 0.5);
        _id_C53E78332A6C514F = player getentitynumber();
        _id_32605DB102447D94._id_085E53E70C7110DA[_id_C53E78332A6C514F] = undefined;
      } else if(istrue(_id_36816541C60BEDAD) && isarray(_id_A663B5760127728D) && _id_A663B5760127728D.size > 0) {
        players = _id_A663B5760127728D;
        _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565(players, "", 0.5);

        foreach(player in players) {
          _id_C53E78332A6C514F = player getentitynumber();
          _id_32605DB102447D94._id_085E53E70C7110DA[_id_C53E78332A6C514F] = undefined;
        }
      }

      break;
    case "open":
      if(isarray(_id_32605DB102447D94._id_085E53E70C7110DA) && _id_32605DB102447D94._id_085E53E70C7110DA.size > 0) {
        _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565(_id_32605DB102447D94._id_085E53E70C7110DA, "", 1.5);
        _id_32605DB102447D94._id_085E53E70C7110DA = [];
      }

      break;
  }

  _id_32605DB102447D94 thread _id_1533FFC339E9487F(_id_113CD49F1CD74678);
}

_id_4515669B8DD8F946() {
  _id_DF809D7B09E1A9C8 = level.wztrain_info._id_C3604781A9D33A7A["cargo_train"];
  level._id_F8EB970B9ACAD105 = [_id_DF809D7B09E1A9C8[1], _id_DF809D7B09E1A9C8[2], _id_DF809D7B09E1A9C8[3], _id_DF809D7B09E1A9C8[4], _id_DF809D7B09E1A9C8[5], _id_DF809D7B09E1A9C8[7], _id_DF809D7B09E1A9C8[8]];
  _id_8B4440160CE15042 = _id_DF809D7B09E1A9C8[4];

  for(;;) {
    foreach(player in scripts\common\utility::playersnear(_id_8B4440160CE15042.origin, 2800)) {
      if(!isDefined(player) || istrue(player._id_7B816F26709FFEEA) || isbot(player)) {
        continue;
      }
      if(!_id_79BA1D512250932E(player)) {
        continue;
      }
      player thread _id_9D0F691BE23427A8();
    }

    wait 1;
  }
}

_id_9D0F691BE23427A8() {
  self endon("disconnect");
  self._id_7B816F26709FFEEA = 1;
  scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("mp_saba_ghosttrain", 0.5);
  self setclienttriggeraudiozone("mp_hell_train_int", 1);

  while(_id_79BA1D512250932E(self))
    wait 0.5;

  scripts\cp_mp\utility\game_utility::_visionunsetnakedforplayer("mp_saba_ghosttrain");
  self clearclienttriggeraudiozone(1);
  wait 0.5;
  self._id_7B816F26709FFEEA = undefined;
}

_id_09E9837276F3F8FC(_id_1CFCCAC3E5778BBB, _id_368224341BEF5415) {
  if(isDefined(level._id_DF809D7B09E1A9C8)) {
    level._id_2E5CD59D250CB94C = level.wztrain_info._id_C3604781A9D33A7A[level.wztrain_info._id_FE47FF8E697AD1D2[0]][4].origin;

    if(isDefined(_id_1CFCCAC3E5778BBB) && isvector(_id_1CFCCAC3E5778BBB)) {
      if(isDefined(level._id_2E5CD59D250CB94C) && isvector(level._id_2E5CD59D250CB94C) && isDefined(_id_368224341BEF5415) && isnumber(_id_368224341BEF5415)) {
        _id_679B408B71133D48 = distance2d(_id_1CFCCAC3E5778BBB, level._id_2E5CD59D250CB94C);
        return _id_679B408B71133D48 < _id_368224341BEF5415;
      }
    }
  }

  return 0;
}

_id_184A361D377CB782() {
  level endon("game_ended");

  for(;;) {
    _id_E572AC8867AA15B9 = getdvarfloat("dvar_C12CC2F1997E5819", 9000);

    foreach(player in level.players) {
      if(_id_09E9837276F3F8FC(player.origin, _id_E572AC8867AA15B9)) {
        if(!istrue(player._id_9EE128B4D3B92AD6)) {
          _id_171F90B9C4C76D44 = undefined;

          if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
            _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(player.origin, 1);

          _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("ghost_train_near", [player], _id_171F90B9C4C76D44);
          player._id_9EE128B4D3B92AD6 = 1;
        }

        continue;
      }

      player._id_9EE128B4D3B92AD6 = 0;
    }

    waitframe();
  }
}

_id_6ADBC1DB84BD62E8(traincar) {
  traincar.curorigin = traincar.origin;
  traincar.offset3d = (0, 0, 0);
  traincar scripts\mp\gameobjects::requestid(1, 1, undefined, 1);
  traincar.objid = traincar.objidnum;
  scripts\mp\objidpoolmanager::update_objective_icon(traincar.objid, "hud_icon_minimap_haunting_ghost_train");
  scripts\mp\objidpoolmanager::update_objective_setbackground(traincar.objid, 1);
  scripts\mp\objidpoolmanager::update_objective_state(traincar.objid, "active");
  scripts\mp\objidpoolmanager::update_objective_setzoffset(traincar.objid, 15);
  scripts\mp\objidpoolmanager::update_objective_position(traincar.objid, traincar.origin + (0, 0, 15));
  scripts\mp\objidpoolmanager::_id_D7E3C4A08682C1B9(traincar.objid, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(traincar.objid, 0);
  scripts\mp\objidpoolmanager::_id_2946E9EB07ACB3F1(traincar.objid, &"MP_BR_INGAME/GHOST_TRAIN_CAR_OBJECTIVE");
  scripts\mp\objidpoolmanager::update_objective_onentity(traincar.objid, traincar);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.wztrain_info.train_array.size; _id_AC0E594AC96AA3A8++) {
    _id_AF111E529B798902 = level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model;

    if(isDefined(_id_AF111E529B798902))
      _id_AF111E529B798902 scripts\common\utility::_id_3677F2BE30FDD581("icon", scripts\engine\utility::ter_op(traincar.linked_model == _id_AF111E529B798902, "invisible", "hidden_at_max_zoom"));
  }

  level waittill("ghost_train_complete");
  traincar scripts\mp\gameobjects::releaseid();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.wztrain_info.train_array.size; _id_AC0E594AC96AA3A8++) {
    _id_AF111E529B798902 = level.wztrain_info.train_array[_id_AC0E594AC96AA3A8].linked_model;

    if(isDefined(_id_AF111E529B798902))
      _id_AF111E529B798902 scripts\common\utility::_id_3677F2BE30FDD581("icon", "visible");
  }
}

_id_79BA1D512250932E(player) {
  if(!isDefined(player))
    return 0;

  if(istrue(player.iszombie))
    return 0;

  mover = player getmovingplatformparent();

  if(!isDefined(mover) || !scripts\engine\utility::array_contains(level._id_F8EB970B9ACAD105, mover))
    return 0;

  _id_9E7FFECCEBAE7D90 = rotatevectorinverted(player.origin - mover.origin, mover.angles);

  if(_id_9E7FFECCEBAE7D90[2] > 20)
    return 0;

  return 1;
}

_id_338EB83CECFB0E0F(instance, player) {
  startlocation = instance.origin;
  _id_7E44076D428E631D = startlocation + rotatevector((0, 1, 67), level._id_A39ACAF08D876A31.angles);
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_7E44076D428E631D, level._id_A39ACAF08D876A31.angles, calcscriptablepayloadgravityarc(startlocation, _id_7E44076D428E631D), level._id_A39ACAF08D876A31);
  _id_E50BD9B2590E6F87 = _id_7E52B56769FA7774::spawnpickup("brloot_personal_trainheart", _id_CB4FAD49263E20C4, 1);
  _id_E50BD9B2590E6F87 setscriptablepartstate(_id_E50BD9B2590E6F87 _meth_EC5F4851431F3382(), "dropped_to_hovering");
}

_id_693DD78CF889F547(scriptable, player) {
  if(istrue(level._id_47DC4447BDA487FE)) {
    return;
  }
  level._id_47DC4447BDA487FE = 1;
  level._id_48CCF7A2BA790A53 setscriptablepartstate("train_exit_portal", "open");
  level notify("ghost_train_complete");
  scripts\cp_mp\challenges::_id_8359CADD253F9604(player, "haunting_train_loot", 1, 1);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("splash_haunting_ghost_train_objective_complete", level.players);
}

_id_B587A630BCEEE5AD(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player endon("disconnect");
  player.plotarmor = 1;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.25);
  player playsoundonmovingent("iw9_train_portal_use");
  player setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2.0);
  player clearclienttriggeraudiozone(2.0);
  player _id_3B64EB40368C1450::set("train_teleport", "fire");
  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  waitframe();
  playFX(scripts\engine\utility::getfx("vfx_hween_butcher_teleport"), player.origin + (0, 0, 45));
  player setOrigin(player.origin + (0, 0, 4000));
  player skydive_beginfreefall();
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.5);
  player clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 1.0);
  player clearclienttriggeraudiozone(2.0);
  playFX(scripts\engine\utility::getfx("vfx_hween_butcher_teleport"), player.origin + (0, 0, 45));
  waitframe();
  player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("train_teleport");
  wait 0.6;
  player.plotarmor = 0;
}