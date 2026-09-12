/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_movingtrain.gsc
***************************************************/

function main() {
  level endon("game_ended");

  if(getdvarint("scr_wztrain_enable", 0) == 0) {
    last_stand_clear_pilot_picker();
    return;
  }

  if(!isDefined(level.ref_145F1)) {
    level.ref_145F1 = spawnStruct();
  }

  scripts\engine\utility::flag_init("wztrain_array_set");
  scripts\engine\utility::flag_init("wztrain_processed_track");
  scripts\engine\utility::flag_init("wztrain_spawn_started");
  scripts\engine\utility::flag_init("wztrain_anim_playing");
  scripts\engine\utility::flag_init("wztrain_icons_attached");
  var_0 = "";

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_13CD1)) {
    var_0 = level.disable_super_in_turret.ref_13CD1;
  } else {
    var_0 = getDvar("scr_wztrain_type", "");

    if(isDefined(level.disable_super_in_turret)) {
      level.disable_super_in_turret.ref_13CD1 = var_0;
    }
  }

  if(var_0 != "armored") {
    last_molotov_throw_time("armored");
    scripts\mp\utility\sound::besttime("vehicle_cargo_train");
  } else {
    last_molotov_throw_time("");
  }

  level.ref_145F1.cargo_truck_mg_create = record_finished_area(var_0);
  level.ref_145F1.type = var_0;

  if(istrue(level.ref_145F1.ks_airdropcrateusetime)) {
    return;
  }

  tr_findvehicle();
}

function last_stand_clear_pilot_picker() {
  last_molotov_throw_time("armored");
  last_molotov_throw_time("");
}

function tr_findvehicle(var_0) {
  if(!target_wavespawning_to_jammer5(level)) {
    return 0;
  }

  if(level.ref_145F1.type == "armored") {
    scripts\mp\gametypes\br_movingtrain_armored::init();
  }

  thread ref_1433B(level);
}

function record_finished_area(var_0) {
  var_1 = spawnStruct();

  if(var_0 == "armored") {
    var_1.num_players_by_truck = "armored_train_car_";
    var_1.num_nags = "armored_train_car_col_";
    var_1.num_nodes_random_search = "armored_train_car_col_slick_";
    var_1.modelname = "armored_train_car_model_";
    var_1.ref_119A4 = "armored_train_car_1";
    var_1.animname = "iw8_mp_verdansk_armored_train_long_290";
    var_1.stack_patch_thread_node = [8, 7, 6, 5, 4, 3, 2, 1];
    var_1.cargo_truck_mg_cp_create = "veh8_mil_lnd_br_armored_train_assembly_long";
    var_1.ref_136D6 = "x2_veh8_mil_lnd_br_train_locomotive";
    var_1.ref_136D5 = "x2_veh8_mil_lnd_br_train_assault";
  } else {
    var_1.num_players_by_truck = "train_car_";
    var_1.modelname = "train_car_model_";
    var_1.ref_11C72 = 1;
    var_1.ref_119A4 = "train_car_20";
    var_1.animname = "iw8_mp_verdansk_train_290";
    var_1.stack_patch_thread_node = [13, 14, 15, 16, 17, 18, 19, 20];
    var_1.cargo_truck_mg_cp_create = "veh8_mil_lnd_br_train_assembly";
  }

  return var_1;
}

function last_molotov_throw_time(var_0) {
  var_1 = record_finished_area(var_0);

  foreach(var_3 in var_1.stack_patch_thread_node) {
    var_4 = var_1.num_players_by_truck + var_3;
    var_5 = getEnt(var_4, "script_noteworthy");

    if(isDefined(var_5)) {
      var_5 delete();
    }

    if(isDefined(var_1.num_nags)) {
      var_5 = getEnt(var_1.num_nags + var_3, "script_noteworthy");

      if(isDefined(var_5)) {
        var_5 delete();
      }
    }

    if(isDefined(var_1.num_nodes_random_search)) {
      var_5 = getEnt(var_1.num_nodes_random_search + var_3, "script_noteworthy");

      if(isDefined(var_5)) {
        var_5 delete();
      }
    }

    var_5 = getEnt(var_4 + "_train_front_hurt", "script_noteworthy");

    if(isDefined(var_5)) {
      var_5 delete();
    }

    var_5 = getEnt(var_1.modelname + var_3, "script_noteworthy");

    if(isDefined(var_5)) {
      var_5 delete();
    }
  }
}

function ref_1433B(var_0) {
  if(!istrue(var_0) && tolower(getDvar("mapname")) != "mp_train_wz") {
    thread ref_13CC4(level);
    level scripts\engine\utility::ref_143A5("br_prematchEnded", "br_debug_beginEnvEvents");
  }

  if(getdvarint("scr_wztrain_enable", 0) == 0) {
    return;
  }

  thread ref_12432();
}

function ref_13CC0() {
  if(getdvarfloat("scr_wztrain_endattrainperc", 0) == 0) {
    return;
  }

  var_0 = getdvarfloat("scr_wztrain_endattrainperc", 0);

  if(var_0 != 1) {
    if(randomint(100) < var_0 * 100) {
      return;
    }
  }

  var_1 = scripts\engine\utility::array_combine(level.br_level.br_circleclosetimes, level.br_level.br_circledelaytimes);
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2 += var_1[var_3];
  }

  if(var_2 <= 0) {
    return;
  }

  var_2 = ref_13CC1(var_2);
  var_4 = level.ref_145F1.cargo_truck_mg_create.anime;
  var_5 = getanimlength(var_4);

  if(!isDefined(var_5) || var_5 <= 0) {
    return;
  }

  var_6 = var_2 / var_5;
  var_7 = var_6 - int(var_6);
  var_8 = getanglesforanimtime((-9661, -9119, -299.007), (0, 0, 0), var_4, var_7);
  level.ref_145F1.gulagisspawnpositionwithinsafecircle = spawnStruct();
  level.ref_145F1.gulagisspawnpositionwithinsafecircle.ref_14673 = var_5;
  level.ref_145F1.gulagisspawnpositionwithinsafecircle.waypoints_structs = var_6;
  level.ref_145F1.gulagisspawnpositionwithinsafecircle.waypoints_reached = var_7;
  level.ref_145F1.gulagisspawnpositionwithinsafecircle.ref_13BF7 = var_2;
  level.ref_145F1.gulagisspawnpositionwithinsafecircle.gulagfadefromblackspectatorsofplayer = var_8;
  setDvar("br_final_circle_override", var_8);
}

function ref_13CC1(var_0) {
  var_1 = 425;

  if(getdvarint("scr_wztrain_endattrainback", 425) != 425) {
    var_1 = getdvarint("scr_wztrain_endattrainback", 425);
  }

  if(getdvarint("scr_wztrain_endattrainrand", 75) > 0) {
    var_2 = getdvarint("scr_wztrain_endattrainrand", 75);
    var_1 += randomint(var_2);
  }

  var_3 = 10;
  var_4 = 0;

  while(var_4 < var_1 - var_3) {
    if(var_0 - var_3 > 0) {
      var_0 -= var_3;
    }

    var_4 += var_3;
  }

  return var_0;
}

function target_wavespawning_to_jammer5() {
  level.ref_145F1.ref_13C8D = [];

  if(isDefined(level.ref_145F1.ref_13215)) {
    foreach(var_1 in level.ref_145F1.ref_13215) {
      level.ref_145F1.ref_13C8D[level.ref_145F1.ref_13C8D.size] = var_1;
    }
  } else {
    level.ref_145F1.ref_13C8D = [];
    var_3 = level.ref_145F1.cargo_truck_mg_create.num_players_by_truck;

    foreach(var_5 in level.ref_145F1.cargo_truck_mg_create.stack_patch_thread_node) {
      var_6 = getEnt(var_3 + var_5, "script_noteworthy");
      level.ref_145F1.ref_13C8D[level.ref_145F1.ref_13C8D.size] = var_6;

      if(isDefined(level.ref_145F1.cargo_truck_mg_create.num_nags)) {
        var_7 = level.ref_145F1.cargo_truck_mg_create.num_nags;
        var_8 = getEnt(var_7 + var_5, "script_noteworthy");

        if(isDefined(var_8)) {
          var_6.num_hackers = var_8;
          var_8 linkTo(var_6);
        }

        var_9 = level.ref_145F1.cargo_truck_mg_create.num_nodes_random_search;

        if(isDefined(var_9)) {
          var_10 = getEnt(var_9, "script_noteworthy");

          if(isDefined(var_10)) {
            var_10 delete();
          }
        }
      }
    }
  }

  foreach(var_13 in level.ref_145F1.ref_13C8D) {
    if(!isent(var_13)) {
      return false;
    }
  }

  ref_13CC0();
  ref_13CB2();
  level.ref_145F1.ref_13C8D = scripts\engine\utility::array_reverse(level.ref_145F1.ref_13C8D);
  ref_13C8E();
  ref_13C8F();
  ref_13C91();
  ref_13CAA();

  if(getdvarint("scr_wztrain_immobilized", 0) == 0) {
    ref_13CAB();
    ref_13C92();
    thread ref_13CBF();
    thread ref_13CB8();
    thread setup_functions();
    thread ref_13CA5();
  } else {
    ref_13C9C();
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread ref_13588(level);
    thread ref_13C93();
    thread ref_13C90();
  }

  scripts\engine\utility::flag_set("wztrain_array_set");
  return true;
}

function ref_13C8E() {
  var_0 = level.ref_145F1.cargo_truck_mg_create.modelname;

  for(var_1 = 0; var_1 < level.ref_145F1.ref_13C8D.size; var_1++) {
    var_2 = strtok(level.ref_145F1.ref_13C8D[var_1].script_noteworthy, "_");
    var_3 = var_2[var_2.size - 1];
    var_4 = ref_13CA2(var_0 + var_3);

    if(isent(var_4)) {
      level.ref_145F1.ref_13C8D[var_1].wz_tease = var_4;
      level.ref_145F1.ref_13C8D[var_1].wz_tease validateloadoutownership();
      var_4.write_to_dlog_runtime_struct_data = level.ref_145F1.ref_13C8D[var_1];
    }
  }
}

function ref_13CA2(var_0) {
  var_1 = undefined;

  if(istrue(level.ref_145F1.cargo_truck_mg_create.ref_11C72)) {
    var_1 = getEnt(var_0, "script_noteworthy");
  } else {
    var_2 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

    if(isDefined(var_2)) {
      var_1 = spawn("script_model", var_2.origin);

      if(var_2.script_modelname == "veh8_mil_lnd_br_train_locomotive") {
        var_1 setModel(level.ref_145F1.cargo_truck_mg_create.ref_136D6);
      } else {
        var_1 setModel(level.ref_145F1.cargo_truck_mg_create.ref_136D5);
      }
    }
  }

  return var_1;
}

function ref_13C8F() {
  for(var_0 = 0; var_0 < level.ref_145F1.ref_13C8D.size; var_0++) {
    ref_13CA9(level.ref_145F1.ref_13C8D[var_0]);
    level.ref_145F1.ref_13C8D[var_0] unmarkkeyframedmover(1);
    level.ref_145F1.ref_13C8D[var_0] setoverridearchetype_code(1);
    level.ref_145F1.ref_13C8D[var_0] clearwristwatchtime(1);
    level.ref_145F1.ref_13C8D[var_0] linkTo(level.ref_145F1.ref_13C8D[var_0].wz_tease);
  }
}

function ref_13C91() {
  for(var_0 = 0; var_0 < level.ref_145F1.ref_13C8D.size; var_0++) {
    var_1 = ref_13CA0(var_0);

    if(getdvarint("scr_wztrain_anim_per_car", 0)) {
      var_2 = "tag_origin";
    } else {
      var_2 = level.ref_145F1.ref_13CBC[var_0];
    }

    var_3 = level.ref_145F1.animents[var_1] gettagorigin(var_2);
    var_4 = level.ref_145F1.ref_13CBD[var_0];
    level.ref_145F1.ref_13C8D[var_0].wz_tease unmarkkeyframedmover(1);
    level.ref_145F1.ref_13C8D[var_0].wz_tease setoverridearchetype_code(1);
    level.ref_145F1.ref_13C8D[var_0].wz_tease clearwristwatchtime(1);
    level.ref_145F1.ref_13C8D[var_0].wz_tease.origin = var_3;

    if(getdvarint("scr_wztrain_anim_uselink", 0) > 0) {
      if(getdvarint("scr_wztrain_anim_per_car", 0) > 0) {
        level.ref_145F1.ref_13C8D[var_0].wz_tease linkTo(level.ref_145F1.animents[var_1], "tag_origin", var_4, (0, 0, 0));
        continue;
      }

      level.ref_145F1.ref_13C8D[var_0].wz_tease linkTo(level.ref_145F1.animents[var_1], var_2, var_4, (0, 0, 0));
    }
  }
}

function ref_13CA9(var_0) {
  var_0.vehiclename = "cargo_train";
  var_0.wz_tease.vehiclename = "cargo_train";
  thread ref_13CBE();
  thread ref_13CBE();
}

function ref_13CBE() {
  level endon("game_ended");
  self endon("death");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

function ref_13CBA() {
  level notify("obj_stop_train");
}

function ref_13C93() {
  if(getdvarint("scr_wztrain_noammocrate", 0) > 0) {
    return;
  }

  var_0 = level.ref_145F1.ref_13C8D[1];
  var_1 = (20, 0, 5);
  var_2 = (0, 90, 0);
  var_3 = rotatevector(var_2, var_0.angles);
  var_4 = "military_ammo_restock_noent";
  var_5 = easepower(var_4, var_0.origin + var_1, var_3);
  thread ref_13CB3(var_5, var_0, var_1);
  var_0.brradialspawnorigin = var_5;
}

function ref_13CC4(var_0) {
  level endon("game_ended");
  waitframe();
  ref_13C9E();
  level waittill(var_0);
  ref_13C9F();
}

function ref_13C9F() {
  if(istrue(level.ref_145F1.monitor_game_end_on_front_truck_death)) {
    level.ref_145F1.monitor_game_end_on_front_truck_death = undefined;

    foreach(var_1 in level.ref_145F1.ref_13C8D) {
      if(isDefined(var_1.wz_tease)) {
        var_1.wz_tease show();
        var_1.wz_tease solid();
        var_1 solid();

        if(isDefined(var_1.ref_13CC3)) {
          var_1.ref_13CC3.spawner_debug_model = 1;
        }

        if(isDefined(var_1.brradialspawnorigin)) {
          var_1.brradialspawnorigin setscriptablepartstate("military_ammo_restock", "USEABLE_ON");
        }
      }
    }

    return;
  }
}

function ref_13C9E() {
  if(!istrue(level.ref_145F1.monitor_game_end_on_front_truck_death)) {
    level.ref_145F1.monitor_game_end_on_front_truck_death = 1;

    foreach(var_1 in level.ref_145F1.ref_13C8D) {
      if(isDefined(var_1.wz_tease)) {
        var_1.wz_tease hide();
        var_1.wz_tease notsolid();
        var_1 notsolid();

        if(isDefined(var_1.ref_13CC3)) {
          var_1.ref_13CC3.spawner_debug_model = 0;
        }

        if(isDefined(var_1.brradialspawnorigin)) {
          var_1.brradialspawnorigin setscriptablepartstate("military_ammo_restock", "USEABLE_OFF");
        }
      }
    }

    return;
  }
}

function ref_13CAB() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("cargo_train", 1);
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
  var_0.setup_techo_lmgs = &setup_hacks;
}

function setup_hacks(var_0, var_1) {
  var_2 = var_0.ent[0];

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = var_0.ent[1];
  var_4 = var_3 getentitynumber();

  if(isDefined(var_2.ref_14100) && isDefined(var_2.ref_14100.size) && var_2.ref_14100.size > 0) {
    if(isDefined(var_2.ref_14100[var_4])) {
      return 0;
    }
  }

  if(isDefined(var_3.velocity)) {
    var_0.velocity[1] = var_3.velocity;
  } else if(isDefined(var_3 getlinkedchildren())) {
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
  var_0.ref_14286 = [];
  var_0.ref_14286[0] = vectorNormalize(var_0.velocity[0]);
  var_0.ref_14286[1] = vectorNormalize(var_0.velocity[1]);
  var_18 = scripts\engine\math::anglebetweenvectorsunit(var_0.ref_14286[0], var_0.ref_14286[1]);
  var_11 = scripts\engine\math::remap(var_18, 0, 180, var_15, var_16);

  if(getdvarfloat("scr_wztrain_vehdmgmult", -1) != -1) {
    var_12 = getdvarfloat("scr_wztrain_vehdmgmult", -1);
  }

  var_19 = var_2.health;
  var_20 = 10;
  var_21 = var_20 * var_11 * var_10 * var_12;
  var_22 = var_21;
  var_23 = var_2.health;

  if(var_2.health > 5 && level.ref_145F1.type != "armored") {
    var_23 = var_2.health - 5;
  }

  if(var_21 > var_23) {
    var_21 = var_23;
  }

  var_2 dodamage(var_21, var_3.origin, var_3, var_3, "MOD_CRUSH");

  if(var_2.health < var_19) {
    thread ref_14112(level, var_2, var_3);
  }

  return var_22;
}

function ref_14112(var_0, var_1, var_2) {
  if(!isDefined(var_0.ref_14100)) {
    var_0.ref_14100 = [];
  }

  var_3 = var_1 getentitynumber();
  var_0.ref_14100[var_3] = var_1;
  wait var_2;

  if(isDefined(var_0) && isDefined(var_0.ref_14100)) {
    var_0.ref_14100[var_3] = undefined;
  }

  if(isDefined(var_0) && isDefined(var_0.ref_14100) && var_0.ref_14100.size == 0) {
    var_0.ref_14100 = undefined;
    return;
  }
}

function setup_functions() {
  level endon("game_ended");
  level endon("obj_stop_train");
  var_0 = level.ref_145F1.ref_13C8D[0];
  var_1 = var_0 getentitynumber();
  var_2 = 150;

  if(getdvarfloat("scr_wztrain_frontitemradius", 150) != 150) {
    var_2 = getdvarfloat("scr_wztrain_frontitemradius", 150);
  }

  var_3 = physics_createcontents(["physicscontents_item"]);
  var_4 = (var_2, var_2, 200);
  var_5 = [var_0, var_0.wz_tease];

  for(;;) {
    var_6 = var_0.origin + rotatevector((375, 0, -100), var_0.angles);
    var_7 = var_6 - var_4;
    var_8 = var_6 + var_4;
    var_9 = physics_aabbbroadphasequery(var_7, var_8, var_3, var_5);

    for(var_10 = 0; var_10 < var_9.size; var_10++) {
      var_11 = var_9[var_10];

      if(istrue(var_11.ref_11B0D)) {
        continue;
      }

      if(isDefined(var_11.ref_13CC6) && isDefined(var_11.ref_13CC6.size)) {
        if(var_11.ref_13CC6.size > 0) {
          if(isDefined(var_11.ref_13CC6[var_1])) {
            continue;
          }
        }
      }

      if(isDefined(var_11.equipmentref)) {
        if(var_11.equipmentref == "equip_tac_cover") {
          if(!var_11.collision istouching(var_0)) {
            continue;
          }

          var_11 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
          var_11.ref_11B0D = 1;
          continue;
        }
      }

      if(!var_11 istouching(var_0)) {
        continue;
      }

      if(isDefined(var_11.cratetype) && var_11.cratetype == "battle_royale_loadout") {
        ref_13CA4(var_11, var_0, var_6);
        continue;
      }

      if(scripts\mp\utility\entity::isturret(var_11)) {
        if(istrue(var_11.usedropspawn)) {
          continue;
        }

        var_11 notify("kill_turret", 1);
        var_11.ref_11B0D = 1;
        continue;
      }

      if(ref_13C98(var_11)) {
        if(isDefined(var_11.health) && var_11.health > 0) {
          var_11 dodamage(var_11.health + 100, var_0.origin);
          var_11.ref_11B0D = 1;
        }
      }
    }

    waitframe();
  }
}

function ref_13C98(var_0) {
  if(!isDefined(var_0.weapon_name)) {
    return false;
  }

  var_1 = 0;

  switch (var_0.weapon_name) {
    case "armor_box_mp":
    case "support_box_mp":
      var_1 = 1;
      break;
  }

  if(var_1) {
    return true;
  }

  return false;
}

function vehicle_collision_loadtablecell(var_0, var_1, var_2) {
  if(!isDefined(var_0.ref_13CC6)) {
    var_0.ref_13CC6 = [];
  }

  var_3 = var_1 getentitynumber();
  var_0.ref_13CC6[var_3] = var_1;
  wait var_2;

  if(isDefined(var_0) && isDefined(var_0.ref_13CC6)) {
    var_0.ref_13CC6[var_3] = undefined;
  }

  if(isDefined(var_0) && isDefined(var_0.ref_13CC6) && var_0.ref_13CC6.size == 0) {
    var_0.ref_13CC6 = undefined;
    return;
  }
}

function ref_13CA4(var_0, var_1, var_2) {
  if(!istrue(var_0.spawn_killstreak_package_on_ground)) {
    var_3 = var_1.velocity * 150;
    var_0 playSound("mp_care_package_high_impact");
    var_0 physicslaunchserver(var_2, var_3);
    var_0.spawn_killstreak_package_on_ground = 1;
    thread vehicle_collision_loadtablecell(level, var_0, var_1);
    return;
  }

  var_0 scripts\cp_mp\killstreaks\airdrop::destroycrate();
  var_0.ref_11B0D = 1;
}

function ref_13CA5() {
  level endon("game_ended");
  level endon("obj_stop_train");

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  var_0 = level.ref_145F1.ref_13C8D[0];
  var_1 = var_0 getentitynumber();
  var_2 = 150;

  if(getdvarfloat("scr_wztrain_frontitemradius", 150) != 150) {
    var_2 = getdvarfloat("scr_wztrain_frontitemradius", 150);
  }

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

        if(istrue(var_8.ref_11B0D)) {
          continue;
        }

        if(distance2dsquared(var_8.origin, var_6) > var_4) {
          continue;
        }

        if(distancesquared(var_8.origin, var_6) > var_4) {
          continue;
        }

        if(isDefined(var_8.weapon_name)) {
          if(var_8.weapon_name == "trophy_mp") {
            var_8 scripts\mp\equipment\trophy_system::sweeptrophy();
            var_8.ref_11B0D = 1;
            continue;
          }

          if(var_8.weapon_name == "claymore_mp") {
            var_8 scripts\mp\equipment\claymore::sweepclaymore();
            var_8.ref_11B0D = 1;
            continue;
          }

          if(var_8.weapon_name == "at_mine_mp") {
            var_8 scripts\mp\equipment\at_mine::at_mine_destroy();
            var_8.ref_11B0D = 1;
            continue;
          }

          if(var_8.weapon_name == "tac_insert_trigger") {
            var_8 scripts\mp\equipment\tac_insert::deletetacinsert();
            var_8.ref_11B0D = 1;
          }
        }
      }
    }

    waitframe();
  }
}

function ref_13CAA() {
  var_0 = 0;

  foreach(var_2 in level.ref_145F1.ref_13C8D) {
    var_3 = var_2.script_noteworthy;
    var_4 = var_3 + "_loot";
    var_5 = scripts\engine\utility::getStructArray(var_4, "targetname");
    var_0 += var_5.size;
  }

  level.ref_145F1.ref_13BFB = var_0;
  ref_13CAC(level.ref_145F1.ref_13C8D);

  if(isDefined(level.ref_145F1.ref_13C8D)) {
    level.ref_145F1.ref_13C8D[0].maphint_keypadscriptableused = (-95, -5, 200);
    level.ref_145F1.ref_13C8D[0].manageworldspawnedprojectiles = (0, 180, 0);
    level.ref_145F1.ref_13C8D[0].mapnamefilter = 3;
    level.ref_145F1.ref_13C8D[1].maphint_keypadscriptableused = (-135, -50, 49);
    level.ref_145F1.ref_13C8D[1].manageworldspawnedprojectiles = (0, 80, 0);
    level.ref_145F1.ref_13C8D[1].mapnamefilter = 0;
    level.ref_145F1.ref_13C8D[5].maphint_keypadscriptableused = (-80, -50, 49);
    level.ref_145F1.ref_13C8D[5].manageworldspawnedprojectiles = (0, 70, 0);
    level.ref_145F1.ref_13C8D[5].mapnamefilter = 0;
    level.ref_145F1.ref_13C8D[7].maphint_keypadscriptableused = (-150, 45, 49);
    level.ref_145F1.ref_13C8D[7].manageworldspawnedprojectiles = (0, 180, 0);
    level.ref_145F1.ref_13C8D[7].mapnamefilter = 0;
    return;
  }
}

function ref_12432() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("wztrain_spawn_started");
  thread ref_13CB1();
  thread ref_13CAD(level);
  level waittill("obj_stop_train");
  thread ref_13CAE();
}

function ref_13CAD(var_0) {
  level endon("game_ended");
  level endon("obj_stop_train");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_13CD1) && level.disable_super_in_turret.ref_13CD1 == "armored") {
    var_0 = 0;
  }

  wait var_0;
  var_1 = level.ref_145F1.ref_13C8D[1];
  var_2 = "";

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_13CD1)) {
    var_2 = level.disable_super_in_turret.ref_13CD1;
  }

  var_3 = level.ref_145F1.cargo_truck_mg_create.ref_119A4;

  foreach(var_1 in level.ref_145F1.ref_13C8D) {
    var_5 = (0, 0, 300);
    var_6 = (0, 0, 0);
    var_7 = rotatevector(var_6, var_1.angles);

    if(var_2 == "armored") {
      var_8 = "br_armortrain";
    } else {
      var_8 = "br_cargotrain";
    }

    if(isDefined(var_1.script_noteworthy) && var_2 == "armored" && var_1.script_noteworthy == var_3) {
      var_8 = "br_armortrain_engine";
    } else if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == var_3) {
      var_8 = "br_cargotrain_engine";
    }

    var_9 = easepower(var_8, var_1.origin + var_5, var_7);
    thread ref_13CB3(var_9, var_1, var_5);

    if(var_2 == "armored") {
      var_9 setscriptablepartstate("br_armortrain", "visible");
    } else {
      var_9 setscriptablepartstate("br_cargotrain", "visible");
    }

    var_9.init_weapon_placements = 1;
    var_1.deletesolospawnstruct = var_9;
  }

  scripts\engine\utility::flag_set("wztrain_icons_attached");
}

function ref_13CAE() {
  foreach(var_1 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_1.deletesolospawnstruct)) {
      if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_13CD1) && level.disable_super_in_turret.ref_13CD1 == "armored") {
        var_1.deletesolospawnstruct setscriptablepartstate("br_armortrain", "hidden");
        continue;
      }

      var_1.deletesolospawnstruct setscriptablepartstate("br_cargotrain", "hidden");
    }
  }
}

function ref_13CAC(var_0) {
  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;
    var_4 = var_3 + "_loot";
    var_5 = scripts\engine\utility::getStructArray(var_4, "targetname");
    var_2.ref_11A43 = [];

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = var_5[var_6].origin - var_2.origin;
      var_8 = rotatevectorinverted(var_7, var_2.angles);
      var_2.ref_11A43[var_6] = var_8;
    }
  }
}

function ref_13588(var_0) {
  if(getdvarint("scr_wztrain_cratespawn", 1) == 0) {
    return;
  }

  scripts\engine\utility::flag_wait("wztrain_array_set");
  var_1 = 4;
  var_2 = 0;
  var_3 = 0;

  if(getdvarint("scr_wztrain_legecrates", 0) > 0) {
    var_1 = getdvarint("scr_wztrain_legecrates", 0);
  }

  if(var_1 > level.ref_145F1.ref_13BFB) {
    var_1 = level.ref_145F1.ref_13BFB;
  }

  foreach(var_5 in var_0) {
    var_6 = var_5.script_noteworthy;
    var_7 = var_6 + "_loot";
    var_8 = scripts\engine\utility::getStructArray(var_7, "targetname");

    for(var_9 = 0; var_9 < var_8.size; var_9++) {
      var_10 = "br_loot_cache";

      if(var_3 > level.ref_145F1.ref_13BFB - var_1) {
        if(var_2 < var_1) {
          var_10 = "br_loot_cache_lege";
          var_2++;
        }
      } else if(var_2 < var_1 && scripts\engine\utility::cointoss()) {
        var_10 = "br_loot_cache_lege";
        var_2++;
      }

      var_11 = var_5.ref_11A43[var_9];
      var_12 = var_8[var_9].angles;
      var_13 = easepower(var_10, var_5.origin + var_11, var_12);
      scripts\mp\gametypes\br_pickups::ref_12B3A(var_13);
      thread ref_13CB3(var_13, var_5, var_11);
      var_13.init_weapon_placements = 1;

      if(var_13 getscriptablehaspart("body")) {
        var_13 setscriptablepartstate("body", "closed_nocol");
      }

      var_3++;
      waitframe();
    }
  }
}

function ref_13CB3(var_0, var_1, var_2) {
  level endon("game_ended");
  wait 1;
  self validatecollision(var_0, var_1, var_2);
}

function ref_13C92() {
  foreach(var_1 in level.ref_145F1.ref_13C8D) {
    var_2 = var_1.script_noteworthy;
    var_3 = var_2 + "_train_front_hurt";
    var_4 = getEnt(var_3, "script_noteworthy");

    if(isent(var_4)) {
      var_1.ref_13CC3 = var_4;
      var_1.ref_13CC3 enablelinkTo();
      var_1.ref_13CC3 linkTo(var_1);
      thread ref_13CA7(var_1.ref_13CC3);
    }
  }
}

function ref_13C9C() {
  foreach(var_1 in level.ref_145F1.ref_13C8D) {
    var_2 = var_1.script_noteworthy;
    var_3 = var_2 + "_train_front_hurt";
    var_4 = getEnt(var_3, "script_noteworthy");

    if(isDefined(var_4)) {
      var_4 delete();
    }
  }
}

function ref_13C90() {
  level endon("game_ended");
  level endon("obj_stop_train");
  var_0 = getdvarint("scr_wztrain_contractspawn", 0);

  if(var_0 == 0) {
    return;
  }

  var_1 = level.ref_145F1.ref_13C8D[3];

  if(!isDefined(var_1) || !isent(var_1)) {
    return;
  }

  var_2 = (-85, 0, -25);
  var_3 = (0, 0, 0);
  var_4 = rotatevector(var_3, var_1.angles);
  var_5 = "brloot_domination_tablet";
  var_6 = 45;
  var_7 = getdvarint("scr_wztrain_contractdelay", 60);

  if(var_7 != 60) {
    var_6 = var_7;
  }

  level.ref_145F1.mark_armor = 1;
  var_8 = getdvarint("scr_wztrain_domflare", 1);

  if(var_8 == 0) {
    level.ref_145F1.mark_armor = 0;
  }

  var_9 = getdvarint("scr_wztrain_domnocol", 1);

  if(var_9 == 1) {
    level.ref_145F1.maphint_debugthink = 1;
  }

  var_1.ref_13C9A = [];
  level.ref_145F1.hotfootlastposition = 0;
  level.ref_145F1.hotfootdisttraveledsq = 0;

  if(!isDefined(level.ref_145F1.funcs)) {
    level.ref_145F1.funcs = spawnStruct();
  }

  level.ref_145F1.funcs.c130airdrop_deleteatlifetime = &_calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_deleteatlifetime;
  level.ref_145F1.funcs.c130airdrop_createpath = &_calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_createpath;
  thread ref_13CA8();
  scripts\engine\utility::flag_wait("wztrain_icons_attached");

  for(;;) {
    while(istrue(level.ref_145F1.choosefinalkillcam)) {
      wait 5;
    }

    var_10 = easepower(var_5, var_1.origin + var_2, var_4);
    scripts\mp\gametypes\br_pickups::ref_12B3A(var_10);
    var_10 validatecollision(var_1, var_2, var_4);
    var_10.ref_11FF8 = 1;
    var_10.keepinmap = 1;
    var_10.trackriotshield_grenadepullbackforc4 = &_calloutmarkerping_handleluinotify_enemyrepinged::manageworldspawnedbolts;
    var_10.init_weapon_placements = 1;

    if(soundexists("br_pickup_generic_3d")) {
      playsoundatpos(var_1.origin + var_2, "br_pickup_generic_3d");
    }

    var_1.ref_13C9A[var_1.ref_13C9A.size] = var_10;
    level.ref_145F1.ref_13C99 = var_10;
    level.ref_145F1 waittill("train_dom_contract_complete", var_11);

    if(isDefined(var_11)) {
      level.ref_145F1.hotfootdisttraveledsq++;
    }

    if(isDefined(var_11) && isDefined(var_11.result) && var_11.result == "success") {
      level.ref_145F1.hotfootlastposition++;

      if(getdvarint("scr_wztrain_domloot", 1) > 0) {
        var_11.itemsdropped = 0;
        var_11.count = 0;
        var_11.origin = var_11.ref_12D2E;
        var_11.angles = var_11.ref_12D2B;
        var_11.intel_collected = 0;
        var_12 = var_11.intel_collected;
        var_13 = getdvarint("scr_wztrain_domloot_armor", 2);
        var_14 = getdvarint("scr_wztrain_domloot_ar", 1);
        var_15 = getdvarint("scr_wztrain_domloot_smg", 1);
        var_16 = getdvarint("scr_wztrain_domloot_sh", 1);
        var_17 = getdvarint("scr_wztrain_domloot_sn", 1);
        var_18 = getdvarint("scr_wztrain_domloot_la", 1);
        var_19 = [];

        for(var_20 = 0; var_20 < var_13; var_20++) {
          var_19 = "brloot_armor_plate";
        }

        for(var_20 = 0; var_20 < var_14; var_20++) {
          var_19 = "brloot_ammo_762";
        }

        for(var_20 = 0; var_20 < var_15; var_20++) {
          var_19 = "brloot_ammo_919";
        }

        for(var_20 = 0; var_20 < var_16; var_20++) {
          var_19 = "brloot_ammo_12g";
        }

        if(scripts\engine\utility::cointoss()) {
          for(var_20 = 0; var_20 < var_17; var_20++) {
            var_19 = "brloot_ammo_50cal";
          }
        } else {
          for(var_20 = 0; var_20 < var_18; var_20++) {
            var_19 = "brloot_ammo_rocket";
          }
        }

        var_21 = getdvarint("scr_wztrain_domloot_sp_num", 0);
        var_22 = getDvar("scr_wztrain_domloot_sp_name", "");

        if(var_21 > 0 && var_22 != "") {
          for(var_20 = 0; var_20 < var_21; var_20++) {
            var_19 = var_22;
          }
        }

        if(isDefined(var_19) && var_19.size > 0) {
          var_23 = var_11 scripts\mp\gametypes\br_lootcache::ref_11A02(var_19);
        }
      }
    }

    wait var_6;
  }
}

function ref_13CA8() {
  level endon("game_ended");
  level endon("obj_stop_train");

  for(;;) {
    if(_calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_createpath()) {
      level.ref_145F1.choosefinalkillcam = 1;

      if(isDefined(level.ref_145F1.ref_13C99)) {
        var_0 = level.ref_145F1.ref_13C99;
        var_1 = var_0 getscriptablepartstate("brloot_domination_tablet");

        if(var_1 == "visible") {
          var_0 scripts\mp\gametypes\br_pickups::lastgoodjobplayer();

          if(isDefined(level.ref_145F1.ref_13C99)) {
            level.ref_145F1.ref_13C99 = undefined;
          }

          level.ref_145F1 notify("train_dom_contract_complete");
        }
      }
    } else {
      level.ref_145F1.choosefinalkillcam = 0;
    }

    wait 5;
  }
}

function ref_13CA7(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = 1;

  if(getdvarfloat("scr_wztrain_playerdmgmult", -1) != -1) {
    var_1 = getdvarfloat("scr_wztrain_playerdmgmult", -1);
  }

  self.spawner_debug_model = 1;
  self.vehicle_collision_getignoreevent = 1;

  for(;;) {
    self waittill("trigger", var_2);

    if(!istrue(self.spawner_debug_model)) {
      continue;
    }

    if(isPlayer(var_2) && isalive(var_2) && (istrue(var_2.inlaststand) || var_2 istouching(var_0) || var_2 istouching(var_0.wz_tease))) {
      var_2 dodamage(var_2.health + 1000 * var_1, self.origin, var_2, self, "MOD_TRIGGER_HURT");
    }
  }
}

function ref_13CBF() {
  level endon("game_ended");

  if(level.ref_145F1.type == "armored") {
    return;
  }

  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  wait 0.1;

  if(getdvarint("scr_wztrain_delayfx", -1) != -1) {
    var_0 = level.ref_145F1.ref_13C8D[0].wz_tease;
    var_1 = scripts\engine\utility::getfx("vrx_br_train_engine");
    playFXOnTag(var_1, var_0, "tag_origin");
    var_2 = scripts\engine\utility::getfx("vrx_br_train_flatbed");

    for(var_3 = 1; var_3 < level.ref_145F1.ref_13C8D.size; var_3++) {
      var_4 = level.ref_145F1.ref_13C8D[var_3].wz_tease;
      playFXOnTag(var_2, var_4, "tag_origin");
    }

    return;
  }

  foreach(var_6 in level.ref_145F1.ref_13C8D) {
    if(var_6.wz_tease getscriptablehaspart("train_part")) {
      var_6.wz_tease setscriptablepartstate("train_part", "moving");
    }
  }
}

function ref_13CB8() {
  if(!isDefined(level.disable_super_in_turret) || !isDefined(level.disable_super_in_turret.ref_13CD1) || level.disable_super_in_turret.ref_13CD1 != "armored") {
    level endon("game_ended");
    scripts\engine\utility::flag_wait("wztrain_anim_playing");
    wait 0.1;

    for(var_0 = 0; var_0 < level.ref_145F1.ref_13C8D.size; var_0++) {
      if(soundexists("veh_cargotrain_lp_" + var_0)) {
        level.ref_145F1.ref_13C8D[var_0].wz_tease playLoopSound("veh_cargotrain_lp_" + var_0);
      }
    }

    return;
  }
}

function ref_13CA6(var_0) {
  var_1 = level.ref_145F1.ref_13C8D[0].wz_tease;
  var_1 playsoundonmovingent("veh_horn_cargotrain");
}

function ref_13CB1() {
  level endon("game_ended");
  var_0 = 20;

  if(getdvarint("scr_wztrain_introdelay", -1) != -1) {
    var_0 = getdvarint("scr_wztrain_introdelay", -1);
  }

  if(var_0 > 0) {
    wait var_0;
  }

  if(getdvarint("scr_wztrain_decho_spawn", 0)) {
    var_1 = getEnt("train_car_50", "script_noteworthy");

    if(isDefined(var_1)) {
      var_2 = spawnStruct();
      var_2.origin = var_1.origin + (0, 0, 58);
      var_2.spawntype = "DEVGUI";

      if(isDefined(var_1.angles)) {
        var_2.angles = var_1.angles;
      }

      var_3 = scripts\cp_mp\vehicles\jeep::jeep_create(var_2);
      wait 0.1;
      var_3 vehicle_turnengineoff();
      wait 1;
    }
  }

  scripts\engine\utility::flag_set("wztrain_anim_playing");
  var_4 = ref_13CA3();
  var_5 = level.ref_145F1.animstruct.origin;
  var_6 = level.ref_145F1.animstruct.angles;

  for(var_7 = 0; var_7 < var_4; var_7++) {
    level.ref_145F1.animents[var_7].updateplayerleaderboardstatsinternal = 1;
    level.ref_145F1.animents[var_7] notsolid();
    level.ref_145F1.animents[var_7] dontinterpolate();
    var_8 = level.ref_145F1.animents[var_7].bullet;
    level.ref_145F1.animstruct thread scripts\common\anim::anim_loop_solo(level.ref_145F1.animents[var_7], var_8);

    if(getdvarint("scr_wztrain_randomstart", 1) > 0) {
      thread ref_13CB5(level.ref_145F1.animstruct, level.ref_145F1.animents[var_7]);
      continue;
    }

    var_9 = getdvarfloat("scr_wztrain_ratio_start", -1);

    if(var_9 >= 0) {
      thread ref_13CB6(level.ref_145F1.animstruct, level.ref_145F1.animents[var_7], var_8);
    }
  }

  if(getdvarint("scr_wztrain_anim_uselink", 0) == 0) {
    for(;;) {
      for(var_7 = 0; var_7 < level.ref_145F1.ref_13C8D.size; var_7++) {
        var_10 = level.ref_145F1.ref_13CBD[var_7];
        var_11 = level.ref_145F1.ref_13CBC[var_7];
        var_12 = ref_13CA0(var_7);
        var_13 = level.ref_145F1.animents[var_12] gettagorigin(var_11);
        var_14 = level.ref_145F1.animents[var_12] gettagangles(var_11);
        var_15 = anglestoaxis(var_14);
        var_13 += var_15["forward"] * var_10[0];
        var_13 += var_15["right"] * var_10[1];
        var_13 += var_15["up"] * var_10[2];
        var_16 = 0.1;
        var_13 = vectorlerp(level.ref_145F1.ref_13C8D[var_7].wz_tease.origin, var_13, var_16);
        var_14 = scripts\engine\math::fake_slerp(level.ref_145F1.ref_13C8D[var_7].wz_tease.angles, var_14, var_16);
        level.ref_145F1.ref_13C8D[var_7].wz_tease.origin = var_13;
        level.ref_145F1.ref_13C8D[var_7].wz_tease.angles = var_14;
      }

      waitframe();
    }

    return;
  }
}

function ref_13CB2() {
  setdvarifuninitialized("scr_wztrain_anim_per_car", 0);
  level.ref_145F1.ref_13CBC = [];
  level.ref_145F1.ref_13CBC[level.ref_145F1.ref_13CBC.size] = "veh8_train_locomotive_joint_01";
  level.ref_145F1.ref_13CBC[level.ref_145F1.ref_13CBC.size] = "veh8_train_flatbed_joint_01";
  level.ref_145F1.ref_13CBC[level.ref_145F1.ref_13CBC.size] = "veh8_train_flatbed_joint_02";
  level.ref_145F1.ref_13CBC[level.ref_145F1.ref_13CBC.size] = "veh8_train_cart_joint_01";
  level.ref_145F1.ref_13CBC[level.ref_145F1.ref_13CBC.size] = "veh8_train_flatbed_joint_03";
  level.ref_145F1.ref_13CBC[level.ref_145F1.ref_13CBC.size] = "veh8_train_flatbed_joint_04";
  level.ref_145F1.ref_13CBC[level.ref_145F1.ref_13CBC.size] = "veh8_train_flatbed_joint_05";
  level.ref_145F1.ref_13CBC[level.ref_145F1.ref_13CBC.size] = "veh8_train_flatbed_joint_06";
  level.ref_145F1.ref_13CBD = [];
  level.ref_145F1.ref_13CBD[level.ref_145F1.ref_13CBD.size] = (0, 0, 0);
  level.ref_145F1.ref_13CBD[level.ref_145F1.ref_13CBD.size] = (0, 0, 0);
  level.ref_145F1.ref_13CBD[level.ref_145F1.ref_13CBD.size] = (0, 0, 0);
  level.ref_145F1.ref_13CBD[level.ref_145F1.ref_13CBD.size] = (0, 0, 0);
  level.ref_145F1.ref_13CBD[level.ref_145F1.ref_13CBD.size] = (0, 0, 0);
  level.ref_145F1.ref_13CBD[level.ref_145F1.ref_13CBD.size] = (0, 0, 0);
  level.ref_145F1.ref_13CBD[level.ref_145F1.ref_13CBD.size] = (0, 0, 0);
  level.ref_145F1.ref_13CBD[level.ref_145F1.ref_13CBD.size] = (0, 0, 0);
  waitframe();
  var_0 = (-9661, -9119, -299.007);
  var_1 = (0, 0, 0);

  if(isDefined(level.ref_145F1.bunker11vo)) {
    var_0 = level.ref_145F1.bunker11vo;
  }

  level.ref_145F1.animstruct = spawnStruct();
  level.ref_145F1.animstruct.origin = var_0;
  level.ref_145F1.animstruct.angles = var_1;
  level.ref_145F1.animents = [];
  var_2 = ref_13CA3();
  var_3 = level.ref_145F1.cargo_truck_mg_create.cargo_truck_mg_cp_create;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    level.ref_145F1.animents[var_4] = spawn("script_model", level.ref_145F1.animstruct.origin);

    if(getdvarint("scr_wztrain_anim_per_car", 0) > 0) {
      level.ref_145F1.animents[var_4] setModel("tag_origin");
    } else {
      level.ref_145F1.animents[var_4] setModel(var_3);
    }

    level.ref_145F1.animents[var_4].angles = level.ref_145F1.animstruct.angles;
    level.ref_145F1.animents[var_4].animname = "br_cargo_train_anim";
    level.ref_145F1.animents[var_4] useanimtree(level.scr_animtree["br_cargo_train_anim"]);
    level.ref_145F1.animents[var_4] unmarkkeyframedmover(1);
    level.ref_145F1.animents[var_4] setoverridearchetype_code(1);
    level.ref_145F1.animents[var_4] clearwristwatchtime(1);
    level.ref_145F1.animents[var_4] hideallparts();
    level.ref_145F1.animents[var_4].bullet = ref_13CA1(var_4 + 1);
  }
}

function ref_13CB5(var_0, var_1) {
  var_2 = level.scr_anim["br_cargo_train_anim"][var_1][0];

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = getanimlength(var_2);
  var_4 = randomfloatrange(0, var_3 - 10);

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }

  waittillframeend();
  var_0 setanimtime(var_2, var_4 / var_3);
}

function ref_13CB6(var_0, var_1, var_2) {
  var_3 = level.scr_anim["br_cargo_train_anim"][var_1][0];

  if(!isDefined(var_3)) {
    return;
  }

  waittillframeend();
  var_0 setanimtime(var_3, var_2);

  if(getdvarint("scr_wztrain_immobilized", 0) == 1) {
    var_0 setanimrate(var_3, 0);
    return;
  }
}

function ref_13CA3() {
  var_0 = 1;

  if(getdvarint("scr_wztrain_anim_per_car", 0)) {
    var_0 = 8;
  }

  return var_0;
}

function ref_13CA1(var_0) {
  var_1 = ref_13CA3();

  if(var_1 == 1) {
    if(getdvarint("scr_slower_wztrain", 0)) {
      var_2 = "full_anim";
    } else if(isDefined(level.ref_145F1.bullet)) {
      var_2 = level.ref_145F1.bullet;
    } else {
      var_2 = "full_anim_290";
    }
  } else if(isDefined(level.scr_anim["br_cargo_train_anim"]["iw8_mp_verdansk_train_cars_290_0" + var_2])) {
    var_2 = "iw8_mp_verdansk_train_cars_290_0" + var_2;
  } else {
    var_2 = "full_anim_290";
  }

  return var_2;
}

function ref_13CA0(var_0) {
  var_1 = ref_13CA3();

  if(var_1 == 1) {
    return 0;
  }

  return var_0;
}

function ref_13C94(var_0) {
  if(!isDefined(level.ref_145F1.animents[0])) {
    return;
  }

  if(!isDefined(level.ref_145F1.animents[0].burst_fire_turret)) {
    level.ref_145F1.animents[0].burst_fire_turret = 1;
  }

  var_1 = level.ref_145F1.animents[0].bullet;
  var_2 = level.scr_anim["br_cargo_train_anim"][var_1][0];
  thread ref_13C95(level.ref_145F1.animents[0], var_0);
}

function ref_13C95(var_0, var_1) {
  level notify("train_braking");
  level endon("train_braking");
  level endon("train_accelerating");
  var_2 = 0.1;
  var_3 = self.burst_fire_turret / var_0 * var_2;
  level.ref_145F1.ref_13C8D[0].wz_tease setscriptablepartstate("speed", "braking");

  while(self.burst_fire_turret > 0) {
    self.burst_fire_turret = max(self.burst_fire_turret - var_3, 0);
    self setanimrate(var_1, self.burst_fire_turret);
    wait var_2;
  }

  level.ref_145F1.ref_13C8D[0].wz_tease setscriptablepartstate("speed", "stopped");

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("onTrainBrakeComplete")) {
    scripts\mp\gametypes\br_gametypes::ref_12E05("onTrainBrakeComplete");
    return;
  }
}

function ref_13C8B(var_0, var_1) {
  if(!isDefined(level.ref_145F1.animents[0])) {
    return;
  }

  if(!isDefined(level.ref_145F1.animents[0].burst_fire_turret)) {
    level.ref_145F1.animents[0].burst_fire_turret = 1;
  }

  var_2 = level.ref_145F1.animents[0].bullet;
  var_3 = level.scr_anim["br_cargo_train_anim"][var_2][0];

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("onTrainAccelBegin")) {
    scripts\mp\gametypes\br_gametypes::ref_12E05("onTrainAccelBegin");
  }

  thread ref_13C8C(level.ref_145F1.animents[0], var_0, var_1);
}

function ref_13C8C(var_0, var_1, var_2) {
  level notify("train_accelerating");
  level endon("train_accelerating");
  level endon("train_braking");
  var_3 = 0.1;
  var_4 = var_1 * var_3;
  level.ref_145F1.ref_13C8D[0].wz_tease setscriptablepartstate("speed", "accel");

  while(self.burst_fire_turret < var_0) {
    self.burst_fire_turret = min(self.burst_fire_turret + var_1, var_0);
    self setanimrate(var_2, self.burst_fire_turret);
    wait var_3;
  }

  self setanimrate(var_2, var_0);
  level.ref_145F1.ref_13C8D[0].wz_tease setscriptablepartstate("speed", "moving");
}

function infil_lbravo_damage_monitor() {
  level endon("game_ended");

  for(;;) {
    wait 1;
  }
}

function any_player_nearby(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) < var_1) {
      return true;
    }
  }

  return false;
}

function ref_14428() {
  level endon("game_ended");

  if(getdvarint("scr_wztrain_warpto", 0) == 0) {
    return;
  }

  while(!isDefined(level.player) || !isalive(level.player)) {
    wait 0.1;
  }

  level.player endon("death_or_disconnect");
  wait 1;
  thread issidecriticaldamage();
  level.player waittill("skydive_deployparachute");
  wait 0.5;
  var_0 = level.ref_145F1.ref_13C8D[0].origin;
  level.player setOrigin(var_0 + (0, 0, 4096));
}

function issidecriticaldamage() {
  level endon("game_ended");
  level.player endon("disconnect");
  level.player notifyonplayercommand("dpad_left_press", "+actionslot 3");

  for(;;) {
    level.player waittill("dpad_left_press");
    var_0 = level.ref_145F1.ref_13C8D[1].origin;

    foreach(var_2 in level.players) {
      var_2 setOrigin(var_0 + (0, 0, 200));
    }

    waitframe();
  }
}

function isonlastkill(var_0, var_1) {}

function completesmokinggunquest() {
  level endon("game_ended");

  for(;;) {
    wait 1;

    foreach(var_1 in level.ref_145F1.ref_13C8D) {
      var_1.wz_tease hide();
    }

    wait 1;

    foreach(var_1 in level.ref_145F1.ref_13C8D) {
      var_1.wz_tease show();
    }
  }
}

function ref_13CB4(var_0) {
  foreach(var_2 in level.ref_145F1.ref_13C8D) {
    if(isDefined(var_2.ref_13CC3)) {
      var_2.ref_13CC3.spawner_debug_model = var_0;
    }
  }
}