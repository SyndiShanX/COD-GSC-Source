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

  if(!isDefined(level.ref_145f1)) {
    level.ref_145f1 = spawnStruct();
  }

  scripts\engine\utility::flag_init("wztrain_array_set");
  scripts\engine\utility::flag_init("wztrain_processed_track");
  scripts\engine\utility::flag_init("wztrain_spawn_started");
  scripts\engine\utility::flag_init("wztrain_anim_playing");
  scripts\engine\utility::flag_init("wztrain_icons_attached");
  var0 = "";

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_13cd1)) {
    var0 = level.disable_super_in_turret.ref_13cd1;
  } else {
    var0 = getDvar("scr_wztrain_type", "");

    if(isDefined(level.disable_super_in_turret)) {
      level.disable_super_in_turret.ref_13cd1 = var0;
    }
  }

  if(var0 != "armored") {
    last_molotov_throw_time("armored");
    scripts\mp\utility\sound::besttime("vehicle_cargo_train");
  } else {
    last_molotov_throw_time("");
  }

  level.ref_145f1.cargo_truck_mg_create = record_finished_area(var0);
  level.ref_145f1.type = var0;

  if(istrue(level.ref_145f1.ks_airdropcrateusetime)) {
    return;
  }

  tr_findvehicle();
}

function last_stand_clear_pilot_picker() {
  last_molotov_throw_time("armored");
  last_molotov_throw_time("");
}

function tr_findvehicle(var0) {
  if(!target_wavespawning_to_jammer5(level)) {
    return 0;
  }

  if(level.ref_145f1.type == "armored") {
    scripts\mp\gametypes\br_movingtrain_armored::init();
  }

  thread ref_1433b(level);
}

function record_finished_area(var0) {
  var1 = spawnStruct();

  if(var0 == "armored") {
    var1.num_players_by_truck = "armored_train_car_";
    var1.num_nags = "armored_train_car_col_";
    var1.num_nodes_random_search = "armored_train_car_col_slick_";
    var1.modelname = "armored_train_car_model_";
    var1.ref_119a4 = "armored_train_car_1";
    var1.animname = "iw8_mp_verdansk_armored_train_long_290";
    var1.stack_patch_thread_node = [8, 7, 6, 5, 4, 3, 2, 1];
    var1.cargo_truck_mg_cp_create = "veh8_mil_lnd_br_armored_train_assembly_long";
    var1.ref_136d6 = "x2_veh8_mil_lnd_br_train_locomotive";
    var1.ref_136d5 = "x2_veh8_mil_lnd_br_train_assault";
  } else {
    var1.num_players_by_truck = "train_car_";
    var1.modelname = "train_car_model_";
    var1.ref_11c72 = 1;
    var1.ref_119a4 = "train_car_20";
    var1.animname = "iw8_mp_verdansk_train_290";
    var1.stack_patch_thread_node = [13, 14, 15, 16, 17, 18, 19, 20];
    var1.cargo_truck_mg_cp_create = "veh8_mil_lnd_br_train_assembly";
  }

  return var1;
}

function last_molotov_throw_time(var0) {
  var1 = record_finished_area(var0);

  foreach(var3 in var1.stack_patch_thread_node) {
    var4 = var1.num_players_by_truck + var3;
    var5 = getEnt(var4, "script_noteworthy");

    if(isDefined(var5)) {
      var5 delete();
    }

    if(isDefined(var1.num_nags)) {
      var5 = getEnt(var1.num_nags + var3, "script_noteworthy");

      if(isDefined(var5)) {
        var5 delete();
      }
    }

    if(isDefined(var1.num_nodes_random_search)) {
      var5 = getEnt(var1.num_nodes_random_search + var3, "script_noteworthy");

      if(isDefined(var5)) {
        var5 delete();
      }
    }

    var5 = getEnt(var4 + "_train_front_hurt", "script_noteworthy");

    if(isDefined(var5)) {
      var5 delete();
    }

    var5 = getEnt(var1.modelname + var3, "script_noteworthy");

    if(isDefined(var5)) {
      var5 delete();
    }
  }
}

function ref_1433b(var0) {
  if(!istrue(var0) && tolower(getDvar("mapname")) != "mp_train_wz") {
    thread ref_13cc4(level);
    level scripts\engine\utility::ref_143a5("br_prematchEnded", "br_debug_beginEnvEvents");
  }

  if(getdvarint("scr_wztrain_enable", 0) == 0) {
    return;
  }

  thread ref_12432();
}

function ref_13cc0() {
  if(getdvarfloat("scr_wztrain_endattrainperc", 0) == 0) {
    return;
  }

  var0 = getdvarfloat("scr_wztrain_endattrainperc", 0);

  if(var0 != 1) {
    if(randomint(100) < var0 * 100) {
      return;
    }
  }

  var1 = scripts\engine\utility::array_combine(level.br_level.br_circleclosetimes, level.br_level.br_circledelaytimes);
  var2 = 0;

  for(var3 = 0; var3 < var1.size; var3++) {
    var2 += var1[var3];
  }

  if(var2 <= 0) {
    return;
  }

  var2 = ref_13cc1(var2);
  var4 = level.ref_145f1.cargo_truck_mg_create.anime;
  var5 = getanimlength(var4);

  if(!isDefined(var5) || var5 <= 0) {
    return;
  }

  var6 = var2 / var5;
  var7 = var6 - int(var6);
  var8 = getanglesforanimtime((-9661, -9119, -299.007), (0, 0, 0), var4, var7);
  level.ref_145f1.gulagisspawnpositionwithinsafecircle = spawnStruct();
  level.ref_145f1.gulagisspawnpositionwithinsafecircle.ref_14673 = var5;
  level.ref_145f1.gulagisspawnpositionwithinsafecircle.waypoints_structs = var6;
  level.ref_145f1.gulagisspawnpositionwithinsafecircle.waypoints_reached = var7;
  level.ref_145f1.gulagisspawnpositionwithinsafecircle.ref_13bf7 = var2;
  level.ref_145f1.gulagisspawnpositionwithinsafecircle.gulagfadefromblackspectatorsofplayer = var8;
  setDvar("br_final_circle_override", var8);
}

function ref_13cc1(var0) {
  var1 = 425;

  if(getdvarint("scr_wztrain_endattrainback", 425) != 425) {
    var1 = getdvarint("scr_wztrain_endattrainback", 425);
  }

  if(getdvarint("scr_wztrain_endattrainrand", 75) > 0) {
    var2 = getdvarint("scr_wztrain_endattrainrand", 75);
    var1 += randomint(var2);
  }

  var3 = 10;
  var4 = 0;

  while(var4 < var1 - var3) {
    if(var0 - var3 > 0) {
      var0 -= var3;
    }

    var4 += var3;
  }

  return var0;
}

function target_wavespawning_to_jammer5() {
  level.ref_145f1.ref_13c8d = [];

  if(isDefined(level.ref_145f1.ref_13215)) {
    foreach(var1 in level.ref_145f1.ref_13215) {
      level.ref_145f1.ref_13c8d[level.ref_145f1.ref_13c8d.size] = var1;
    }
  } else {
    level.ref_145f1.ref_13c8d = [];
    var3 = level.ref_145f1.cargo_truck_mg_create.num_players_by_truck;

    foreach(var5 in level.ref_145f1.cargo_truck_mg_create.stack_patch_thread_node) {
      var6 = getEnt(var3 + var5, "script_noteworthy");
      level.ref_145f1.ref_13c8d[level.ref_145f1.ref_13c8d.size] = var6;

      if(isDefined(level.ref_145f1.cargo_truck_mg_create.num_nags)) {
        var7 = level.ref_145f1.cargo_truck_mg_create.num_nags;
        var8 = getEnt(var7 + var5, "script_noteworthy");

        if(isDefined(var8)) {
          var6.num_hackers = var8;
          var8 linkTo(var6);
        }

        var9 = level.ref_145f1.cargo_truck_mg_create.num_nodes_random_search;

        if(isDefined(var9)) {
          var10 = getEnt(var9, "script_noteworthy");

          if(isDefined(var10)) {
            var10 delete();
          }
        }
      }
    }
  }

  foreach(var13 in level.ref_145f1.ref_13c8d) {
    if(!isent(var13)) {
      return false;
    }
  }

  ref_13cc0();
  ref_13cb2();
  level.ref_145f1.ref_13c8d = scripts\engine\utility::array_reverse(level.ref_145f1.ref_13c8d);
  ref_13c8e();
  ref_13c8f();
  ref_13c91();
  ref_13caa();

  if(getdvarint("scr_wztrain_immobilized", 0) == 0) {
    ref_13cab();
    ref_13c92();
    thread ref_13cbf();
    thread ref_13cb8();
    thread setup_functions();
    thread ref_13ca5();
  } else {
    ref_13c9c();
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    thread ref_13588(level);
    thread ref_13c93();
    thread ref_13c90();
  }

  scripts\engine\utility::flag_set("wztrain_array_set");
  return true;
}

function ref_13c8e() {
  var0 = level.ref_145f1.cargo_truck_mg_create.modelname;

  for(var1 = 0; var1 < level.ref_145f1.ref_13c8d.size; var1++) {
    var2 = strtok(level.ref_145f1.ref_13c8d[var1].script_noteworthy, "_");
    var3 = var2[var2.size - 1];
    var4 = ref_13ca2(var0 + var3);

    if(isent(var4)) {
      level.ref_145f1.ref_13c8d[var1].wz_tease = var4;
      level.ref_145f1.ref_13c8d[var1].wz_tease validateloadoutownership();
      var4.write_to_dlog_runtime_struct_data = level.ref_145f1.ref_13c8d[var1];
    }
  }
}

function ref_13ca2(var0) {
  var1 = undefined;

  if(istrue(level.ref_145f1.cargo_truck_mg_create.ref_11c72)) {
    var1 = getEnt(var0, "script_noteworthy");
  } else {
    var2 = scripts\engine\utility::getStruct(var0, "script_noteworthy");

    if(isDefined(var2)) {
      var1 = spawn("script_model", var2.origin);

      if(var2.script_modelname == "veh8_mil_lnd_br_train_locomotive") {
        var1 setModel(level.ref_145f1.cargo_truck_mg_create.ref_136d6);
      } else {
        var1 setModel(level.ref_145f1.cargo_truck_mg_create.ref_136d5);
      }
    }
  }

  return var1;
}

function ref_13c8f() {
  for(var0 = 0; var0 < level.ref_145f1.ref_13c8d.size; var0++) {
    ref_13ca9(level.ref_145f1.ref_13c8d[var0]);
    level.ref_145f1.ref_13c8d[var0] unmarkkeyframedmover(1);
    level.ref_145f1.ref_13c8d[var0] setoverridearchetype_code(1);
    level.ref_145f1.ref_13c8d[var0] clearwristwatchtime(1);
    level.ref_145f1.ref_13c8d[var0] linkTo(level.ref_145f1.ref_13c8d[var0].wz_tease);
  }
}

function ref_13c91() {
  for(var0 = 0; var0 < level.ref_145f1.ref_13c8d.size; var0++) {
    var1 = ref_13ca0(var0);

    if(getdvarint("scr_wztrain_anim_per_car", 0)) {
      var2 = "tag_origin";
    } else {
      var2 = level.ref_145f1.ref_13cbc[var0];
    }

    var3 = level.ref_145f1.animents[var1] gettagorigin(var2);
    var4 = level.ref_145f1.ref_13cbd[var0];
    level.ref_145f1.ref_13c8d[var0].wz_tease unmarkkeyframedmover(1);
    level.ref_145f1.ref_13c8d[var0].wz_tease setoverridearchetype_code(1);
    level.ref_145f1.ref_13c8d[var0].wz_tease clearwristwatchtime(1);
    level.ref_145f1.ref_13c8d[var0].wz_tease.origin = var3;

    if(getdvarint("scr_wztrain_anim_uselink", 0) > 0) {
      if(getdvarint("scr_wztrain_anim_per_car", 0) > 0) {
        level.ref_145f1.ref_13c8d[var0].wz_tease linkTo(level.ref_145f1.animents[var1], "tag_origin", var4, (0, 0, 0));
        continue;
      }

      level.ref_145f1.ref_13c8d[var0].wz_tease linkTo(level.ref_145f1.animents[var1], var2, var4, (0, 0, 0));
    }
  }
}

function ref_13ca9(var0) {
  var0.vehiclename = "cargo_train";
  var0.wz_tease.vehiclename = "cargo_train";
  thread ref_13cbe();
  thread ref_13cbe();
}

function ref_13cbe() {
  level endon("game_ended");
  self endon("death");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

function ref_13cba() {
  level notify("obj_stop_train");
}

function ref_13c93() {
  if(getdvarint("scr_wztrain_noammocrate", 0) > 0) {
    return;
  }

  var0 = level.ref_145f1.ref_13c8d[1];
  var1 = (20, 0, 5);
  var2 = (0, 90, 0);
  var3 = rotatevector(var2, var0.angles);
  var4 = "military_ammo_restock_noent";
  var5 = easepower(var4, var0.origin + var1, var3);
  thread ref_13cb3(var5, var0, var1);
  var0.brradialspawnorigin = var5;
}

function ref_13cc4(var0) {
  level endon("game_ended");
  waitframe();
  ref_13c9e();
  level waittill(var0);
  ref_13c9f();
}

function ref_13c9f() {
  if(istrue(level.ref_145f1.monitor_game_end_on_front_truck_death)) {
    level.ref_145f1.monitor_game_end_on_front_truck_death = undefined;

    foreach(var1 in level.ref_145f1.ref_13c8d) {
      if(isDefined(var1.wz_tease)) {
        var1.wz_tease show();
        var1.wz_tease solid();
        var1 solid();

        if(isDefined(var1.ref_13cc3)) {
          var1.ref_13cc3.spawner_debug_model = 1;
        }

        if(isDefined(var1.brradialspawnorigin)) {
          var1.brradialspawnorigin setscriptablepartstate("military_ammo_restock", "USEABLE_ON");
        }
      }
    }

    return;
  }
}

function ref_13c9e() {
  if(!istrue(level.ref_145f1.monitor_game_end_on_front_truck_death)) {
    level.ref_145f1.monitor_game_end_on_front_truck_death = 1;

    foreach(var1 in level.ref_145f1.ref_13c8d) {
      if(isDefined(var1.wz_tease)) {
        var1.wz_tease hide();
        var1.wz_tease notsolid();
        var1 notsolid();

        if(isDefined(var1.ref_13cc3)) {
          var1.ref_13cc3.spawner_debug_model = 0;
        }

        if(isDefined(var1.brradialspawnorigin)) {
          var1.brradialspawnorigin setscriptablepartstate("military_ammo_restock", "USEABLE_OFF");
        }
      }
    }

    return;
  }
}

function ref_13cab() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("cargo_train", 1);
  var0.challengeevaluator = 1;
  var0.keycardlocs_chosen = 1;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 8;
  var0.isallowedweapon = 25;
  var0.isakimbo = 100;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 1;
  var0.setup_techo_lmgs = &setup_hacks;
}

function setup_hacks(var0, var1) {
  var2 = var0.ent[0];

  if(!isDefined(var2)) {
    return;
  }

  var3 = var0.ent[1];
  var4 = var3 getentitynumber();

  if(isDefined(var2.ref_14100) && isDefined(var2.ref_14100.size) && var2.ref_14100.size > 0) {
    if(isDefined(var2.ref_14100[var4])) {
      return 0;
    }
  }

  if(isDefined(var3.velocity)) {
    var0.velocity[1] = var3.velocity;
  } else if(isDefined(var3 getlinkedchildren())) {
    var5 = undefined;
    var6 = var3 getlinkedchildren();

    foreach(var8 in var6) {
      if(isDefined(var8.velocity)) {
        var5 = var8.velocity;
        var0.velocity[1] = var5;
        break;
      }
    }
  }

  var10 = 1;
  var11 = 1;
  var12 = 1;
  var13 = 1;
  var14 = 20;
  var15 = 0.5;
  var16 = 30;
  var17 = length(var0.velocity[0]);
  var10 = scripts\engine\math::remap(var17, 0, 600, var13, var14);
  var0.ref_14286 = [];
  var0.ref_14286[0] = vectorNormalize(var0.velocity[0]);
  var0.ref_14286[1] = vectorNormalize(var0.velocity[1]);
  var18 = scripts\engine\math::anglebetweenvectorsunit(var0.ref_14286[0], var0.ref_14286[1]);
  var11 = scripts\engine\math::remap(var18, 0, 180, var15, var16);

  if(getdvarfloat("scr_wztrain_vehdmgmult", -1) != -1) {
    var12 = getdvarfloat("scr_wztrain_vehdmgmult", -1);
  }

  var19 = var2.health;
  var20 = 10;
  var21 = var20 * var11 * var10 * var12;
  var22 = var21;
  var23 = var2.health;

  if(var2.health > 5 && level.ref_145f1.type != "armored") {
    var23 = var2.health - 5;
  }

  if(var21 > var23) {
    var21 = var23;
  }

  var2 dodamage(var21, var3.origin, var3, var3, "MOD_CRUSH");

  if(var2.health < var19) {
    thread ref_14112(level, var2, var3);
  }

  return var22;
}

function ref_14112(var0, var1, var2) {
  if(!isDefined(var0.ref_14100)) {
    var0.ref_14100 = [];
  }

  var3 = var1 getentitynumber();
  var0.ref_14100[var3] = var1;
  wait var2;

  if(isDefined(var0) && isDefined(var0.ref_14100)) {
    var0.ref_14100[var3] = undefined;
  }

  if(isDefined(var0) && isDefined(var0.ref_14100) && var0.ref_14100.size == 0) {
    var0.ref_14100 = undefined;
    return;
  }
}

function setup_functions() {
  level endon("game_ended");
  level endon("obj_stop_train");
  var0 = level.ref_145f1.ref_13c8d[0];
  var1 = var0 getentitynumber();
  var2 = 150;

  if(getdvarfloat("scr_wztrain_frontitemradius", 150) != 150) {
    var2 = getdvarfloat("scr_wztrain_frontitemradius", 150);
  }

  var3 = physics_createcontents(["physicscontents_item"]);
  var4 = (var2, var2, 200);
  var5 = [var0, var0.wz_tease];

  for(;;) {
    var6 = var0.origin + rotatevector((375, 0, -100), var0.angles);
    var7 = var6 - var4;
    var8 = var6 + var4;
    var9 = physics_aabbbroadphasequery(var7, var8, var3, var5);

    for(var10 = 0; var10 < var9.size; var10++) {
      var11 = var9[var10];

      if(istrue(var11.ref_11b0d)) {
        continue;
      }

      if(isDefined(var11.ref_13cc6) && isDefined(var11.ref_13cc6.size)) {
        if(var11.ref_13cc6.size > 0) {
          if(isDefined(var11.ref_13cc6[var1])) {
            continue;
          }
        }
      }

      if(isDefined(var11.equipmentref)) {
        if(var11.equipmentref == "equip_tac_cover") {
          if(!var11.collision istouching(var0)) {
            continue;
          }

          var11 scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
          var11.ref_11b0d = 1;
          continue;
        }
      }

      if(!var11 istouching(var0)) {
        continue;
      }

      if(isDefined(var11.cratetype) && var11.cratetype == "battle_royale_loadout") {
        ref_13ca4(var11, var0, var6);
        continue;
      }

      if(scripts\mp\utility\entity::isturret(var11)) {
        if(istrue(var11.usedropspawn)) {
          continue;
        }

        var11 notify("kill_turret", 1);
        var11.ref_11b0d = 1;
        continue;
      }

      if(ref_13c98(var11)) {
        if(isDefined(var11.health) && var11.health > 0) {
          var11 dodamage(var11.health + 100, var0.origin);
          var11.ref_11b0d = 1;
        }
      }
    }

    waitframe();
  }
}

function ref_13c98(var0) {
  if(!isDefined(var0.weapon_name)) {
    return false;
  }

  var1 = 0;

  switch (var0.weapon_name) {
    case "armor_box_mp":
    case "support_box_mp":
      var1 = 1;
      break;
  }

  if(var1) {
    return true;
  }

  return false;
}

function vehicle_collision_loadtablecell(var0, var1, var2) {
  if(!isDefined(var0.ref_13cc6)) {
    var0.ref_13cc6 = [];
  }

  var3 = var1 getentitynumber();
  var0.ref_13cc6[var3] = var1;
  wait var2;

  if(isDefined(var0) && isDefined(var0.ref_13cc6)) {
    var0.ref_13cc6[var3] = undefined;
  }

  if(isDefined(var0) && isDefined(var0.ref_13cc6) && var0.ref_13cc6.size == 0) {
    var0.ref_13cc6 = undefined;
    return;
  }
}

function ref_13ca4(var0, var1, var2) {
  if(!istrue(var0.spawn_killstreak_package_on_ground)) {
    var3 = var1.velocity * 150;
    var0 playSound("mp_care_package_high_impact");
    var0 physicslaunchserver(var2, var3);
    var0.spawn_killstreak_package_on_ground = 1;
    thread vehicle_collision_loadtablecell(level, var0, var1);
    return;
  }

  var0 scripts\cp_mp\killstreaks\airdrop::destroycrate();
  var0.ref_11b0d = 1;
}

function ref_13ca5() {
  level endon("game_ended");
  level endon("obj_stop_train");

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  var0 = level.ref_145f1.ref_13c8d[0];
  var1 = var0 getentitynumber();
  var2 = 150;

  if(getdvarfloat("scr_wztrain_frontitemradius", 150) != 150) {
    var2 = getdvarfloat("scr_wztrain_frontitemradius", 150);
  }

  var3 = var2 - 25;
  var4 = var3 * var3;

  for(;;) {
    var5 = level.mines;

    if(var5.size > 0) {
      var6 = var0.origin + rotatevector((375, 0, -100), var0.angles);

      foreach(var8 in var5) {
        if(!isDefined(var8)) {
          continue;
        }

        if(istrue(var8.ref_11b0d)) {
          continue;
        }

        if(distance2dsquared(var8.origin, var6) > var4) {
          continue;
        }

        if(distancesquared(var8.origin, var6) > var4) {
          continue;
        }

        if(isDefined(var8.weapon_name)) {
          if(var8.weapon_name == "trophy_mp") {
            var8 scripts\mp\equipment\trophy_system::sweeptrophy();
            var8.ref_11b0d = 1;
            continue;
          }

          if(var8.weapon_name == "claymore_mp") {
            var8 scripts\mp\equipment\claymore::sweepclaymore();
            var8.ref_11b0d = 1;
            continue;
          }

          if(var8.weapon_name == "at_mine_mp") {
            var8 scripts\mp\equipment\at_mine::at_mine_destroy();
            var8.ref_11b0d = 1;
            continue;
          }

          if(var8.weapon_name == "tac_insert_trigger") {
            var8 scripts\mp\equipment\tac_insert::deletetacinsert();
            var8.ref_11b0d = 1;
          }
        }
      }
    }

    waitframe();
  }
}

function ref_13caa() {
  var0 = 0;

  foreach(var2 in level.ref_145f1.ref_13c8d) {
    var3 = var2.script_noteworthy;
    var4 = var3 + "_loot";
    var5 = scripts\engine\utility::getStructArray(var4, "targetname");
    var0 += var5.size;
  }

  level.ref_145f1.ref_13bfb = var0;
  ref_13cac(level.ref_145f1.ref_13c8d);

  if(isDefined(level.ref_145f1.ref_13c8d)) {
    level.ref_145f1.ref_13c8d[0].maphint_keypadscriptableused = (-95, -5, 200);
    level.ref_145f1.ref_13c8d[0].manageworldspawnedprojectiles = (0, 180, 0);
    level.ref_145f1.ref_13c8d[0].mapnamefilter = 3;
    level.ref_145f1.ref_13c8d[1].maphint_keypadscriptableused = (-135, -50, 49);
    level.ref_145f1.ref_13c8d[1].manageworldspawnedprojectiles = (0, 80, 0);
    level.ref_145f1.ref_13c8d[1].mapnamefilter = 0;
    level.ref_145f1.ref_13c8d[5].maphint_keypadscriptableused = (-80, -50, 49);
    level.ref_145f1.ref_13c8d[5].manageworldspawnedprojectiles = (0, 70, 0);
    level.ref_145f1.ref_13c8d[5].mapnamefilter = 0;
    level.ref_145f1.ref_13c8d[7].maphint_keypadscriptableused = (-150, 45, 49);
    level.ref_145f1.ref_13c8d[7].manageworldspawnedprojectiles = (0, 180, 0);
    level.ref_145f1.ref_13c8d[7].mapnamefilter = 0;
    return;
  }
}

function ref_12432() {
  level endon("game_ended");
  scripts\engine\utility::flag_set("wztrain_spawn_started");
  thread ref_13cb1();
  thread ref_13cad(level);
  level waittill("obj_stop_train");
  thread ref_13cae();
}

function ref_13cad(var0) {
  level endon("game_ended");
  level endon("obj_stop_train");
  scripts\engine\utility::flag_wait("wztrain_anim_playing");

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_13cd1) && level.disable_super_in_turret.ref_13cd1 == "armored") {
    var0 = 0;
  }

  wait var0;
  var1 = level.ref_145f1.ref_13c8d[1];
  var2 = "";

  if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_13cd1)) {
    var2 = level.disable_super_in_turret.ref_13cd1;
  }

  var3 = level.ref_145f1.cargo_truck_mg_create.ref_119a4;

  foreach(var1 in level.ref_145f1.ref_13c8d) {
    var5 = (0, 0, 300);
    var6 = (0, 0, 0);
    var7 = rotatevector(var6, var1.angles);

    if(var2 == "armored") {
      var8 = "br_armortrain";
    } else {
      var8 = "br_cargotrain";
    }

    if(isDefined(var1.script_noteworthy) && var2 == "armored" && var1.script_noteworthy == var3) {
      var8 = "br_armortrain_engine";
    } else if(isDefined(var1.script_noteworthy) && var1.script_noteworthy == var3) {
      var8 = "br_cargotrain_engine";
    }

    var9 = easepower(var8, var1.origin + var5, var7);
    thread ref_13cb3(var9, var1, var5);

    if(var2 == "armored") {
      var9 setscriptablepartstate("br_armortrain", "visible");
    } else {
      var9 setscriptablepartstate("br_cargotrain", "visible");
    }

    var9.init_weapon_placements = 1;
    var1.deletesolospawnstruct = var9;
  }

  scripts\engine\utility::flag_set("wztrain_icons_attached");
}

function ref_13cae() {
  foreach(var1 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var1.deletesolospawnstruct)) {
      if(isDefined(level.disable_super_in_turret) && isDefined(level.disable_super_in_turret.ref_13cd1) && level.disable_super_in_turret.ref_13cd1 == "armored") {
        var1.deletesolospawnstruct setscriptablepartstate("br_armortrain", "hidden");
        continue;
      }

      var1.deletesolospawnstruct setscriptablepartstate("br_cargotrain", "hidden");
    }
  }
}

function ref_13cac(var0) {
  foreach(var2 in var0) {
    var3 = var2.script_noteworthy;
    var4 = var3 + "_loot";
    var5 = scripts\engine\utility::getStructArray(var4, "targetname");
    var2.ref_11a43 = [];

    for(var6 = 0; var6 < var5.size; var6++) {
      var7 = var5[var6].origin - var2.origin;
      var8 = rotatevectorinverted(var7, var2.angles);
      var2.ref_11a43[var6] = var8;
    }
  }
}

function ref_13588(var0) {
  if(getdvarint("scr_wztrain_cratespawn", 1) == 0) {
    return;
  }

  scripts\engine\utility::flag_wait("wztrain_array_set");
  var1 = 4;
  var2 = 0;
  var3 = 0;

  if(getdvarint("scr_wztrain_legecrates", 0) > 0) {
    var1 = getdvarint("scr_wztrain_legecrates", 0);
  }

  if(var1 > level.ref_145f1.ref_13bfb) {
    var1 = level.ref_145f1.ref_13bfb;
  }

  foreach(var5 in var0) {
    var6 = var5.script_noteworthy;
    var7 = var6 + "_loot";
    var8 = scripts\engine\utility::getStructArray(var7, "targetname");

    for(var9 = 0; var9 < var8.size; var9++) {
      var10 = "br_loot_cache";

      if(var3 > level.ref_145f1.ref_13bfb - var1) {
        if(var2 < var1) {
          var10 = "br_loot_cache_lege";
          var2++;
        }
      } else if(var2 < var1 && scripts\engine\utility::cointoss()) {
        var10 = "br_loot_cache_lege";
        var2++;
      }

      var11 = var5.ref_11a43[var9];
      var12 = var8[var9].angles;
      var13 = easepower(var10, var5.origin + var11, var12);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var13);
      thread ref_13cb3(var13, var5, var11);
      var13.init_weapon_placements = 1;

      if(var13 getscriptablehaspart("body")) {
        var13 setscriptablepartstate("body", "closed_nocol");
      }

      var3++;
      waitframe();
    }
  }
}

function ref_13cb3(var0, var1, var2) {
  level endon("game_ended");
  wait 1;
  self validatecollision(var0, var1, var2);
}

function ref_13c92() {
  foreach(var1 in level.ref_145f1.ref_13c8d) {
    var2 = var1.script_noteworthy;
    var3 = var2 + "_train_front_hurt";
    var4 = getEnt(var3, "script_noteworthy");

    if(isent(var4)) {
      var1.ref_13cc3 = var4;
      var1.ref_13cc3 enablelinkTo();
      var1.ref_13cc3 linkTo(var1);
      thread ref_13ca7(var1.ref_13cc3);
    }
  }
}

function ref_13c9c() {
  foreach(var1 in level.ref_145f1.ref_13c8d) {
    var2 = var1.script_noteworthy;
    var3 = var2 + "_train_front_hurt";
    var4 = getEnt(var3, "script_noteworthy");

    if(isDefined(var4)) {
      var4 delete();
    }
  }
}

function ref_13c90() {
  level endon("game_ended");
  level endon("obj_stop_train");
  var0 = getdvarint("scr_wztrain_contractspawn", 0);

  if(var0 == 0) {
    return;
  }

  var1 = level.ref_145f1.ref_13c8d[3];

  if(!isDefined(var1) || !isent(var1)) {
    return;
  }

  var2 = (-85, 0, -25);
  var3 = (0, 0, 0);
  var4 = rotatevector(var3, var1.angles);
  var5 = "brloot_domination_tablet";
  var6 = 45;
  var7 = getdvarint("scr_wztrain_contractdelay", 60);

  if(var7 != 60) {
    var6 = var7;
  }

  level.ref_145f1.mark_armor = 1;
  var8 = getdvarint("scr_wztrain_domflare", 1);

  if(var8 == 0) {
    level.ref_145f1.mark_armor = 0;
  }

  var9 = getdvarint("scr_wztrain_domnocol", 1);

  if(var9 == 1) {
    level.ref_145f1.maphint_debugthink = 1;
  }

  var1.ref_13c9a = [];
  level.ref_145f1.hotfootlastposition = 0;
  level.ref_145f1.hotfootdisttraveledsq = 0;

  if(!isDefined(level.ref_145f1.funcs)) {
    level.ref_145f1.funcs = spawnStruct();
  }

  level.ref_145f1.funcs.c130airdrop_deleteatlifetime = &_calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_deleteatlifetime;
  level.ref_145f1.funcs.c130airdrop_createpath = &_calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_createpath;
  thread ref_13ca8();
  scripts\engine\utility::flag_wait("wztrain_icons_attached");

  for(;;) {
    while(istrue(level.ref_145f1.choosefinalkillcam)) {
      wait 5;
    }

    var10 = easepower(var5, var1.origin + var2, var4);
    scripts\mp\gametypes\br_pickups::ref_12b3a(var10);
    var10 validatecollision(var1, var2, var4);
    var10.ref_11ff8 = 1;
    var10.keepinmap = 1;
    var10.trackriotshield_grenadepullbackforc4 = &_calloutmarkerping_handleluinotify_enemyrepinged::manageworldspawnedbolts;
    var10.init_weapon_placements = 1;

    if(soundexists("br_pickup_generic_3d")) {
      playsoundatpos(var1.origin + var2, "br_pickup_generic_3d");
    }

    var1.ref_13c9a[var1.ref_13c9a.size] = var10;
    level.ref_145f1.ref_13c99 = var10;
    level.ref_145f1 waittill("train_dom_contract_complete", var11);

    if(isDefined(var11)) {
      level.ref_145f1.hotfootdisttraveledsq++;
    }

    if(isDefined(var11) && isDefined(var11.result) && var11.result == "success") {
      level.ref_145f1.hotfootlastposition++;

      if(getdvarint("scr_wztrain_domloot", 1) > 0) {
        var11.itemsdropped = 0;
        var11.count = 0;
        var11.origin = var11.ref_12d2e;
        var11.angles = var11.ref_12d2b;
        var11.intel_collected = 0;
        var12 = var11.intel_collected;
        var13 = getdvarint("scr_wztrain_domloot_armor", 2);
        var14 = getdvarint("scr_wztrain_domloot_ar", 1);
        var15 = getdvarint("scr_wztrain_domloot_smg", 1);
        var16 = getdvarint("scr_wztrain_domloot_sh", 1);
        var17 = getdvarint("scr_wztrain_domloot_sn", 1);
        var18 = getdvarint("scr_wztrain_domloot_la", 1);
        var19 = [];

        for(var20 = 0; var20 < var13; var20++) {
          var19 = "brloot_armor_plate";
        }

        for(var20 = 0; var20 < var14; var20++) {
          var19 = "brloot_ammo_762";
        }

        for(var20 = 0; var20 < var15; var20++) {
          var19 = "brloot_ammo_919";
        }

        for(var20 = 0; var20 < var16; var20++) {
          var19 = "brloot_ammo_12g";
        }

        if(scripts\engine\utility::cointoss()) {
          for(var20 = 0; var20 < var17; var20++) {
            var19 = "brloot_ammo_50cal";
          }
        } else {
          for(var20 = 0; var20 < var18; var20++) {
            var19 = "brloot_ammo_rocket";
          }
        }

        var21 = getdvarint("scr_wztrain_domloot_sp_num", 0);
        var22 = getDvar("scr_wztrain_domloot_sp_name", "");

        if(var21 > 0 && var22 != "") {
          for(var20 = 0; var20 < var21; var20++) {
            var19 = var22;
          }
        }

        if(isDefined(var19) && var19.size > 0) {
          var23 = var11 scripts\mp\gametypes\br_lootcache::ref_11a02(var19);
        }
      }
    }

    wait var6;
  }
}

function ref_13ca8() {
  level endon("game_ended");
  level endon("obj_stop_train");

  for(;;) {
    if(_calloutmarkerping_handleluinotify_enemyrepinged::c130airdrop_createpath()) {
      level.ref_145f1.choosefinalkillcam = 1;

      if(isDefined(level.ref_145f1.ref_13c99)) {
        var0 = level.ref_145f1.ref_13c99;
        var1 = var0 getscriptablepartstate("brloot_domination_tablet");

        if(var1 == "visible") {
          var0 scripts\mp\gametypes\br_pickups::lastgoodjobplayer();

          if(isDefined(level.ref_145f1.ref_13c99)) {
            level.ref_145f1.ref_13c99 = undefined;
          }

          level.ref_145f1 notify("train_dom_contract_complete");
        }
      }
    } else {
      level.ref_145f1.choosefinalkillcam = 0;
    }

    wait 5;
  }
}

function ref_13ca7(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = 1;

  if(getdvarfloat("scr_wztrain_playerdmgmult", -1) != -1) {
    var1 = getdvarfloat("scr_wztrain_playerdmgmult", -1);
  }

  self.spawner_debug_model = 1;
  self.vehicle_collision_getignoreevent = 1;

  for(;;) {
    self waittill("trigger", var2);

    if(!istrue(self.spawner_debug_model)) {
      continue;
    }

    if(isPlayer(var2) && isalive(var2) && (istrue(var2.inlaststand) || var2 istouching(var0) || var2 istouching(var0.wz_tease))) {
      var2 dodamage(var2.health + 1000 * var1, self.origin, var2, self, "MOD_TRIGGER_HURT");
    }
  }
}

function ref_13cbf() {
  level endon("game_ended");

  if(level.ref_145f1.type == "armored") {
    return;
  }

  scripts\engine\utility::flag_wait("wztrain_anim_playing");
  wait 0.1;

  if(getdvarint("scr_wztrain_delayfx", -1) != -1) {
    var0 = level.ref_145f1.ref_13c8d[0].wz_tease;
    var1 = scripts\engine\utility::getfx("vrx_br_train_engine");
    playFXOnTag(var1, var0, "tag_origin");
    var2 = scripts\engine\utility::getfx("vrx_br_train_flatbed");

    for(var3 = 1; var3 < level.ref_145f1.ref_13c8d.size; var3++) {
      var4 = level.ref_145f1.ref_13c8d[var3].wz_tease;
      playFXOnTag(var2, var4, "tag_origin");
    }

    return;
  }

  foreach(var6 in level.ref_145f1.ref_13c8d) {
    if(var6.wz_tease getscriptablehaspart("train_part")) {
      var6.wz_tease setscriptablepartstate("train_part", "moving");
    }
  }
}

function ref_13cb8() {
  if(!isDefined(level.disable_super_in_turret) || !isDefined(level.disable_super_in_turret.ref_13cd1) || level.disable_super_in_turret.ref_13cd1 != "armored") {
    level endon("game_ended");
    scripts\engine\utility::flag_wait("wztrain_anim_playing");
    wait 0.1;

    for(var0 = 0; var0 < level.ref_145f1.ref_13c8d.size; var0++) {
      if(soundexists("veh_cargotrain_lp_" + var0)) {
        level.ref_145f1.ref_13c8d[var0].wz_tease playLoopSound("veh_cargotrain_lp_" + var0);
      }
    }

    return;
  }
}

function ref_13ca6(var0) {
  var1 = level.ref_145f1.ref_13c8d[0].wz_tease;
  var1 playsoundonmovingent("veh_horn_cargotrain");
}

function ref_13cb1() {
  level endon("game_ended");
  var0 = 20;

  if(getdvarint("scr_wztrain_introdelay", -1) != -1) {
    var0 = getdvarint("scr_wztrain_introdelay", -1);
  }

  if(var0 > 0) {
    wait var0;
  }

  if(getdvarint("scr_wztrain_decho_spawn", 0)) {
    var1 = getEnt("train_car_50", "script_noteworthy");

    if(isDefined(var1)) {
      var2 = spawnStruct();
      var2.origin = var1.origin + (0, 0, 58);
      var2.spawntype = "DEVGUI";

      if(isDefined(var1.angles)) {
        var2.angles = var1.angles;
      }

      var3 = scripts\cp_mp\vehicles\jeep::jeep_create(var2);
      wait 0.1;
      var3 vehicle_turnengineoff();
      wait 1;
    }
  }

  scripts\engine\utility::flag_set("wztrain_anim_playing");
  var4 = ref_13ca3();
  var5 = level.ref_145f1.animstruct.origin;
  var6 = level.ref_145f1.animstruct.angles;

  for(var7 = 0; var7 < var4; var7++) {
    level.ref_145f1.animents[var7].updateplayerleaderboardstatsinternal = 1;
    level.ref_145f1.animents[var7] notsolid();
    level.ref_145f1.animents[var7] dontinterpolate();
    var8 = level.ref_145f1.animents[var7].bullet;
    level.ref_145f1.animstruct thread scripts\common\anim::anim_loop_solo(level.ref_145f1.animents[var7], var8);

    if(getdvarint("scr_wztrain_randomstart", 1) > 0) {
      thread ref_13cb5(level.ref_145f1.animstruct, level.ref_145f1.animents[var7]);
      continue;
    }

    var9 = getdvarfloat("scr_wztrain_ratio_start", -1);

    if(var9 >= 0) {
      thread ref_13cb6(level.ref_145f1.animstruct, level.ref_145f1.animents[var7], var8);
    }
  }

  if(getdvarint("scr_wztrain_anim_uselink", 0) == 0) {
    for(;;) {
      for(var7 = 0; var7 < level.ref_145f1.ref_13c8d.size; var7++) {
        var10 = level.ref_145f1.ref_13cbd[var7];
        var11 = level.ref_145f1.ref_13cbc[var7];
        var12 = ref_13ca0(var7);
        var13 = level.ref_145f1.animents[var12] gettagorigin(var11);
        var14 = level.ref_145f1.animents[var12] gettagangles(var11);
        var15 = anglestoaxis(var14);
        var13 += var15["forward"] * var10[0];
        var13 += var15["right"] * var10[1];
        var13 += var15["up"] * var10[2];
        var16 = 0.1;
        var13 = vectorlerp(level.ref_145f1.ref_13c8d[var7].wz_tease.origin, var13, var16);
        var14 = scripts\engine\math::fake_slerp(level.ref_145f1.ref_13c8d[var7].wz_tease.angles, var14, var16);
        level.ref_145f1.ref_13c8d[var7].wz_tease.origin = var13;
        level.ref_145f1.ref_13c8d[var7].wz_tease.angles = var14;
      }

      waitframe();
    }

    return;
  }
}

function ref_13cb2() {
  setdvarifuninitialized("scr_wztrain_anim_per_car", 0);
  level.ref_145f1.ref_13cbc = [];
  level.ref_145f1.ref_13cbc[level.ref_145f1.ref_13cbc.size] = "veh8_train_locomotive_joint_01";
  level.ref_145f1.ref_13cbc[level.ref_145f1.ref_13cbc.size] = "veh8_train_flatbed_joint_01";
  level.ref_145f1.ref_13cbc[level.ref_145f1.ref_13cbc.size] = "veh8_train_flatbed_joint_02";
  level.ref_145f1.ref_13cbc[level.ref_145f1.ref_13cbc.size] = "veh8_train_cart_joint_01";
  level.ref_145f1.ref_13cbc[level.ref_145f1.ref_13cbc.size] = "veh8_train_flatbed_joint_03";
  level.ref_145f1.ref_13cbc[level.ref_145f1.ref_13cbc.size] = "veh8_train_flatbed_joint_04";
  level.ref_145f1.ref_13cbc[level.ref_145f1.ref_13cbc.size] = "veh8_train_flatbed_joint_05";
  level.ref_145f1.ref_13cbc[level.ref_145f1.ref_13cbc.size] = "veh8_train_flatbed_joint_06";
  level.ref_145f1.ref_13cbd = [];
  level.ref_145f1.ref_13cbd[level.ref_145f1.ref_13cbd.size] = (0, 0, 0);
  level.ref_145f1.ref_13cbd[level.ref_145f1.ref_13cbd.size] = (0, 0, 0);
  level.ref_145f1.ref_13cbd[level.ref_145f1.ref_13cbd.size] = (0, 0, 0);
  level.ref_145f1.ref_13cbd[level.ref_145f1.ref_13cbd.size] = (0, 0, 0);
  level.ref_145f1.ref_13cbd[level.ref_145f1.ref_13cbd.size] = (0, 0, 0);
  level.ref_145f1.ref_13cbd[level.ref_145f1.ref_13cbd.size] = (0, 0, 0);
  level.ref_145f1.ref_13cbd[level.ref_145f1.ref_13cbd.size] = (0, 0, 0);
  level.ref_145f1.ref_13cbd[level.ref_145f1.ref_13cbd.size] = (0, 0, 0);
  waitframe();
  var0 = (-9661, -9119, -299.007);
  var1 = (0, 0, 0);

  if(isDefined(level.ref_145f1.bunker11vo)) {
    var0 = level.ref_145f1.bunker11vo;
  }

  level.ref_145f1.animstruct = spawnStruct();
  level.ref_145f1.animstruct.origin = var0;
  level.ref_145f1.animstruct.angles = var1;
  level.ref_145f1.animents = [];
  var2 = ref_13ca3();
  var3 = level.ref_145f1.cargo_truck_mg_create.cargo_truck_mg_cp_create;

  for(var4 = 0; var4 < var2; var4++) {
    level.ref_145f1.animents[var4] = spawn("script_model", level.ref_145f1.animstruct.origin);

    if(getdvarint("scr_wztrain_anim_per_car", 0) > 0) {
      level.ref_145f1.animents[var4] setModel("tag_origin");
    } else {
      level.ref_145f1.animents[var4] setModel(var3);
    }

    level.ref_145f1.animents[var4].angles = level.ref_145f1.animstruct.angles;
    level.ref_145f1.animents[var4].animname = "br_cargo_train_anim";
    level.ref_145f1.animents[var4] useanimtree(level.scr_animtree["br_cargo_train_anim"]);
    level.ref_145f1.animents[var4] unmarkkeyframedmover(1);
    level.ref_145f1.animents[var4] setoverridearchetype_code(1);
    level.ref_145f1.animents[var4] clearwristwatchtime(1);
    level.ref_145f1.animents[var4] hideallparts();
    level.ref_145f1.animents[var4].bullet = ref_13ca1(var4 + 1);
  }
}

function ref_13cb5(var0, var1) {
  var2 = level.scr_anim["br_cargo_train_anim"][var1][0];

  if(!isDefined(var2)) {
    return;
  }

  var3 = getanimlength(var2);
  var4 = randomfloatrange(0, var3 - 10);

  if(!isDefined(var3) || !isDefined(var4)) {
    return;
  }

  waittillframeend();
  var0 setanimtime(var2, var4 / var3);
}

function ref_13cb6(var0, var1, var2) {
  var3 = level.scr_anim["br_cargo_train_anim"][var1][0];

  if(!isDefined(var3)) {
    return;
  }

  waittillframeend();
  var0 setanimtime(var3, var2);

  if(getdvarint("scr_wztrain_immobilized", 0) == 1) {
    var0 setanimrate(var3, 0);
    return;
  }
}

function ref_13ca3() {
  var0 = 1;

  if(getdvarint("scr_wztrain_anim_per_car", 0)) {
    var0 = 8;
  }

  return var0;
}

function ref_13ca1(var0) {
  var1 = ref_13ca3();

  if(var1 == 1) {
    if(getdvarint("scr_slower_wztrain", 0)) {
      var2 = "full_anim";
    } else if(isDefined(level.ref_145f1.bullet)) {
      var2 = level.ref_145f1.bullet;
    } else {
      var2 = "full_anim_290";
    }
  } else if(isDefined(level.scr_anim["br_cargo_train_anim"]["iw8_mp_verdansk_train_cars_290_0" + var2])) {
    var2 = "iw8_mp_verdansk_train_cars_290_0" + var2;
  } else {
    var2 = "full_anim_290";
  }

  return var2;
}

function ref_13ca0(var0) {
  var1 = ref_13ca3();

  if(var1 == 1) {
    return 0;
  }

  return var0;
}

function ref_13c94(var0) {
  if(!isDefined(level.ref_145f1.animents[0])) {
    return;
  }

  if(!isDefined(level.ref_145f1.animents[0].burst_fire_turret)) {
    level.ref_145f1.animents[0].burst_fire_turret = 1;
  }

  var1 = level.ref_145f1.animents[0].bullet;
  var2 = level.scr_anim["br_cargo_train_anim"][var1][0];
  thread ref_13c95(level.ref_145f1.animents[0], var0);
}

function ref_13c95(var0, var1) {
  level notify("train_braking");
  level endon("train_braking");
  level endon("train_accelerating");
  var2 = 0.1;
  var3 = self.burst_fire_turret / var0 * var2;
  level.ref_145f1.ref_13c8d[0].wz_tease setscriptablepartstate("speed", "braking");

  while(self.burst_fire_turret > 0) {
    self.burst_fire_turret = max(self.burst_fire_turret - var3, 0);
    self setanimrate(var1, self.burst_fire_turret);
    wait var2;
  }

  level.ref_145f1.ref_13c8d[0].wz_tease setscriptablepartstate("speed", "stopped");

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("onTrainBrakeComplete")) {
    scripts\mp\gametypes\br_gametypes::ref_12e05("onTrainBrakeComplete");
    return;
  }
}

function ref_13c8b(var0, var1) {
  if(!isDefined(level.ref_145f1.animents[0])) {
    return;
  }

  if(!isDefined(level.ref_145f1.animents[0].burst_fire_turret)) {
    level.ref_145f1.animents[0].burst_fire_turret = 1;
  }

  var2 = level.ref_145f1.animents[0].bullet;
  var3 = level.scr_anim["br_cargo_train_anim"][var2][0];

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("onTrainAccelBegin")) {
    scripts\mp\gametypes\br_gametypes::ref_12e05("onTrainAccelBegin");
  }

  thread ref_13c8c(level.ref_145f1.animents[0], var0, var1);
}

function ref_13c8c(var0, var1, var2) {
  level notify("train_accelerating");
  level endon("train_accelerating");
  level endon("train_braking");
  var3 = 0.1;
  var4 = var1 * var3;
  level.ref_145f1.ref_13c8d[0].wz_tease setscriptablepartstate("speed", "accel");

  while(self.burst_fire_turret < var0) {
    self.burst_fire_turret = min(self.burst_fire_turret + var1, var0);
    self setanimrate(var2, self.burst_fire_turret);
    wait var3;
  }

  self setanimrate(var2, var0);
  level.ref_145f1.ref_13c8d[0].wz_tease setscriptablepartstate("speed", "moving");
}

function infil_lbravo_damage_monitor() {
  level endon("game_ended");

  for(;;) {
    wait 1;
  }
}

function any_player_nearby(var0, var1) {
  foreach(var3 in level.players) {
    if(distancesquared(var3.origin, var0) < var1) {
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
  var0 = level.ref_145f1.ref_13c8d[0].origin;
  level.player setOrigin(var0 + (0, 0, 4096));
}

function issidecriticaldamage() {
  level endon("game_ended");
  level.player endon("disconnect");
  level.player notifyonplayercommand("dpad_left_press", "+actionslot 3");

  for(;;) {
    level.player waittill("dpad_left_press");
    var0 = level.ref_145f1.ref_13c8d[1].origin;

    foreach(var2 in level.players) {
      var2 setOrigin(var0 + (0, 0, 200));
    }

    waitframe();
  }
}

function isonlastkill(var0, var1) {}

function completesmokinggunquest() {
  level endon("game_ended");

  for(;;) {
    wait 1;

    foreach(var1 in level.ref_145f1.ref_13c8d) {
      var1.wz_tease hide();
    }

    wait 1;

    foreach(var1 in level.ref_145f1.ref_13c8d) {
      var1.wz_tease show();
    }
  }
}

function ref_13cb4(var0) {
  foreach(var2 in level.ref_145f1.ref_13c8d) {
    if(isDefined(var2.ref_13cc3)) {
      var2.ref_13cc3.spawner_debug_model = var0;
    }
  }
}