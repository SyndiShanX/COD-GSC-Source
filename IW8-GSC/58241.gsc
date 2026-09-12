/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58241.gsc
***********************************************/

function ref_14114() {
  var_0 = spawnStruct();
  level.vehicle.collision = var_0;
  var_0.vehicledata = [];
  ref_14115();
  ref_14108();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_collision", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_collision", "init")]]();
  }

  thread ref_1411A();
}

function ref_1411A() {
  level endon("game_ended");
  var_0 = ref_1410E();

  for(;;) {
    var_0.eventdata = [];
    var_0.eventid = 0;
    waitframe();
  }
}

function ref_1411B(var_0) {
  level endon("game_ended");

  if(!isDefined(ref_1410F(var_0.vehiclename, 0, 1))) {
    return;
  }

  var_0 notify("vehicle_collision_updateInstance");
  var_0 endon("vehicle_collision_updateInstance");
  var_0 vehphys_enablecollisioncallback(1);

  while(isDefined(var_0)) {
    var_0 waittill("collision", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    ref_14117(var_0, var_8, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_9);
  }
}

function ref_1411C(var_0) {
  var_0 notify("vehicle_collision_updateInstance");
}

function ref_1410E() {
  return level.vehicle.collision;
}

function ref_1410F(var_0, var_1, var_2) {
  var_3 = ref_1410E();
  var_4 = var_3.vehicledata[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3.vehicledata[var_0] = var_4;
      var_4.ref = var_0;
      var_4.ref_12B1E = undefined;
      var_4.setup_techo_lmgs = undefined;
      var_4.challengeevaluator = 1;
      var_4.keycardlocs_chosen = 1;
      var_4.is_using_stealth_debug = 0;
      var_4.is_valid_station_name = 0;
      var_4.is_two_hit_melee_weapon = 0;
      var_4.isakimbomeleeweapon = 5;
      var_4.isallowedweapon = 20;
      var_4.isakimbo = 40;
      var_4.ref_133C5 = 0;
      var_4.ref_133C6 = 0;
      var_4.ref_133C4 = 0;
    } else if(istrue(var_2)) {}
  }

  return var_4;
}

function ref_1410C(var_0, var_1) {
  var_2 = ref_1410E();
  var_3 = ref_1410F(var_0.vehiclename, 0, 1);

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_0 getentitynumber();
  var_5 = "none";

  if(isDefined(var_1) && var_1 != var_0 && (!isDefined(var_1.classname) || var_1.classname != "worldspawn")) {
    var_5 = var_1 getentitynumber();
  }

  if(!isDefined(var_2.eventdata[var_4])) {
    var_2.eventdata[var_4] = [];
  }

  var_6 = isDefined(var_1) && var_1 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(ref_1410F(var_1.vehiclename, 0, 1));
  var_7 = undefined;

  if(isDefined(var_2.eventdata[var_4][var_5])) {
    if(isstring(var_5) && var_5 == "none") {}

    var_7 = var_2.eventdata[var_4][var_5];
  } else if(var_6) {
    if(!isDefined(var_2.eventdata[var_5])) {
      var_2.eventdata[var_5] = [];
    }

    if(isDefined(var_2.eventdata[var_5][var_4])) {
      var_7 = var_2.eventdata[var_5][var_4];
    }
  }

  if(!isDefined(var_7)) {
    var_7 = spawnStruct();
    var_2.eventdata[var_4][var_5] = var_7;

    if(var_6) {
      var_2.eventdata[var_5][var_4] = var_7;
    }

    var_7.id = var_2.eventid;
    var_2.eventid++;
    var_7.time = gettime();
    var_7.ent = [];
    var_7.cop_car_initomnvars = [];
    var_7.body1 = [];
    var_7.player_has_primary_weapons_max_ammo = [];
    var_7.player_has_primary_weapons_max_stock_ammo = [];
    var_7.position = [];
    var_7.normal = [];
    var_7.ref_11EBB = [];
    var_7.ref_121E2 = [];
    var_7.angles = [];
    var_7.velocity = [];
  }

  return var_7;
}

function ref_14117(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_1) || var_1 == var_0 || isDefined(var_1.classname) && var_1.classname == "worldspawn") {
    var_1 = undefined;
  }

  var_10 = ref_1410C(var_0, var_1);

  if(!isDefined(var_10)) {
    return;
  }

  level notify("vehicle_collision_registerEvent_" + var_10.id);
  var_11 = undefined;

  foreach(var_11, var_13 in var_10.ent) {
    if(var_13 == var_0) {
      break;
    }
  }

  if(!isDefined(var_11)) {
    var_11 = var_10.ent.size;
  }

  var_10.ent[var_11] = var_0;
  var_10.cop_car_initomnvars[var_11] = var_2;
  var_10.body1[var_11] = var_3;
  var_10.player_has_primary_weapons_max_ammo[var_11] = var_4;
  var_10.player_has_primary_weapons_max_stock_ammo[var_11] = var_5;
  var_10.position[var_11] = var_6;
  var_10.normal[var_11] = var_7;
  var_10.ref_11EBB[var_11] = var_8;
  var_10.ref_121E2[var_11] = var_9;
  var_10.angles[var_11] = var_0.angles;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
    var_10.velocity[var_11] = var_0 vehicle_getvelocity();
  } else {
    var_10.velocity[var_11] = (0, 0, 0);
  }

  if(var_10.ent.size == 1) {
    var_10.ent[1] = var_1;
  }

  var_14 = ref_1410F(var_0.vehiclename);

  if(isDefined(var_14.ref_12B1E)) {
    [[var_14.ref_12B1E]](var_10, var_11);
  }

  thread ref_14118(var_10);
}

function ref_14118(var_0) {
  level endon("game_ended");
  level endon("vehicle_collision_registerEvent_" + var_0.id);
  waittillframeend();
  thread ref_14110(var_0);
}

function ref_14110(var_0) {
  ref_14111(var_0);

  foreach(var_2 in var_0.ent) {
    if(!isDefined(var_2.vehiclename)) {
      continue;
    }

    var_3 = ref_1410F(var_2.vehiclename, 0, 1);

    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_3.setup_techo_lmgs)) {
      [[var_3.setup_techo_lmgs]](var_0, var_4);
    }
  }
}

function ref_14111(var_0) {
  var_1 = ref_1410E();

  if(var_1.ref_11E02) {
    return;
  }

  if(var_0.ent.size < 2 || var_0.velocity.size < 2) {
    return;
  }

  var_2 = var_0.ent.size;
  var_0.armorbox_usedcallback = [];

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_0.armorbox_usedcallback[var_3] = vectordot(var_0.velocity[var_3], var_0.normal[var_3]);
  }

  var_0.ref_12B4D = int(abs(var_0.armorbox_usedcallback[0] - var_0.armorbox_usedcallback[1]));

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_0.armorbox_usedcallback[var_3] = int(abs(var_0.armorbox_usedcallback[var_3]));
  }

  var_0.unset_relic_nuketimer = [];
  ref_1410D(var_0, 0, 1);
  ref_1410D(var_0, 1, 0);
  ref_1410A(var_0, 0, 1);
  ref_1410A(var_0, 1, 0);
  ref_1410B(var_0, 0, 1);
  ref_1410B(var_0, 1, 0);
  ref_14119(var_0, 0, 1);
  ref_14119(var_0, 1, 0);
}

function ref_1410A(var_0, var_1, var_2, var_3) {
  if(var_0.stack_patch_thread_root[var_1]) {
    return;
  }

  if(!isDefined(var_0.is_trials_level)) {
    var_0.is_trials_level = [];
  }

  var_4 = ref_1410E();
  var_5 = var_0.ent[var_1].vehiclename;
  var_6 = var_0.ent[var_2].vehiclename;
  var_7 = ref_1410F(var_5, 0, 1);
  var_8 = ref_1410F(var_6, 0, 1);
  var_9 = istrue(var_0.unset_relic_nuketimer[var_1]);
  var_10 = istrue(var_0.unset_relic_nuketimer[var_2]);
  var_11 = var_0.armorbox_usedcallback[var_1];
  var_12 = var_0.armorbox_usedcallback[var_2];
  var_13 = undefined;

  if(var_9 && var_4.spawn_para_and_heli_logic && var_4.spawn_new_ents >= 0) {
    var_13 = var_4.spawn_new_ents;
  } else if(var_10 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_1 >= 0) {
    var_13 = var_4.spawn_module_lmg_1;
  } else {
    var_13 = var_8.challengeevaluator;

    if(isDefined(var_4.challengeevaluator[var_5]) && isDefined(var_4.challengeevaluator[var_5][var_6])) {
      var_13 = var_4.challengeevaluator[var_5][var_6];
    }
  }

  var_14 = undefined;

  if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_c >= 0) {
    var_14 = var_4.spawn_module_p3_form_c;
  } else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_soldiers_01 >= 0) {
    var_14 = var_4.spawn_overwatch_soldiers_01;
  } else {
    var_14 = var_7.keycardlocs_chosen;

    if(isDefined(var_4.keycardlocs_chosen[var_5]) && isDefined(var_4.keycardlocs_chosen[var_5][var_6])) {
      var_14 = var_4.keycardlocs_chosen[var_5][var_6];
    }
  }

  var_15 = var_0.ent[var_1];
  var_16 = var_0.ent[var_2];

  if(isDefined(var_16.ref_11E06)) {
    var_13 *= var_16.ref_11E06;
  }

  if(isDefined(var_15.ref_11E07)) {
    var_14 *= var_15.ref_11E07;
  }

  var_0.is_trials_level[var_1] = var_12 / (var_11 + var_12) * var_0.ref_12B4D * var_13 * var_14;
}

function ref_1410B(var_0, var_1, var_2) {
  if(var_0.stack_patch_thread_root[var_1]) {
    return;
  }

  var_3 = var_0.is_trials_level[var_1];

  if(!isDefined(var_0.isairlockdoor)) {
    var_0.isairlockdoor = [];
    var_0.ref_133C1 = [];
  }

  if(var_3 > 0) {
    var_4 = ref_1410E();
    var_5 = var_0.ent[var_1].vehiclename;
    var_6 = var_0.ent[var_2].vehiclename;
    var_7 = ref_1410F(var_5, 0, 1);
    var_8 = ref_1410F(var_6, 0, 1);
    var_9 = istrue(var_0.unset_relic_nuketimer[var_1]);
    var_10 = istrue(var_0.unset_relic_nuketimer[var_2]);
    var_11 = undefined;

    if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_2 >= 0) {
      var_11 = var_4.spawn_module_lmg_2;
    } else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_obit_model >= 0) {
      var_11 = var_4.spawn_obit_model;
    } else {
      var_11 = var_7.is_two_hit_melee_weapon;

      if(isDefined(var_4.is_two_hit_melee_weapon[var_6]) && isDefined(var_4.is_two_hit_melee_weapon[var_6][var_5])) {
        var_11 = var_4.is_two_hit_melee_weapon[var_6][var_5];
      }
    }

    if(var_11 > 0 && var_3 >= var_11) {
      var_0.isairlockdoor[var_1] = 0;

      if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_5 >= 0) {
        var_0.isairlockdoor[var_1] = var_4.spawn_module_lmg_5;
      } else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_origin >= 0) {
        var_0.isairlockdoor[var_1] = var_4.spawn_origin;
      } else {
        var_0.isairlockdoor[var_1] = var_7.isakimbo;

        if(isDefined(var_4.isakimbo[var_6]) && isDefined(var_4.isakimbo[var_6][var_5])) {
          var_0.isairlockdoor[var_1] = var_4.isakimbo[var_6][var_5];
        }
      }

      if(var_0.isairlockdoor[var_1] > 0) {
        if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_soldiers1 >= 0) {
          var_0.ref_133C1[var_1] = var_4.spawn_module_soldiers1 > 0;
          return;
        }

        if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_paratrooper_ac130 >= 0) {
          var_0.ref_133C1[var_1] = var_4.spawn_paratrooper_ac130 > 0;
          return;
        }

        var_0.ref_133C1[var_1] = var_7.ref_133C4;

        if(isDefined(var_4.ref_133C4[var_6]) && isDefined(var_4.ref_133C4[var_6][var_5])) {
          var_0.ref_133C1[var_1] = var_4.ref_133C4[var_6][var_5];
        }

        return;
      }
    }

    var_11 = undefined;

    if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_4 >= 0) {
      var_11 = var_4.spawn_module_lmg_4;
    } else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_objective >= 0) {
      var_11 = var_4.spawn_objective;
    } else {
      var_11 = var_7.is_valid_station_name;

      if(isDefined(var_4.is_valid_station_name[var_6]) && isDefined(var_4.is_valid_station_name[var_6][var_5])) {
        var_11 = var_4.is_valid_station_name[var_6][var_5];
      }
    }

    if(var_11 > 0 && var_3 >= var_11) {
      var_0.isairlockdoor[var_1] = 0;

      if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_b >= 0) {
        var_0.isairlockdoor[var_1] = var_4.spawn_module_p3_form_b;
      } else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_final_tank >= 0) {
        var_0.isairlockdoor[var_1] = var_4.spawn_overwatch_final_tank;
      } else {
        var_0.isairlockdoor[var_1] = var_7.isallowedweapon;

        if(isDefined(var_4.isallowedweapon[var_6]) && isDefined(var_4.isallowedweapon[var_6][var_5])) {
          var_12 = var_4.isallowedweapon[var_6][var_5];
        }
      }

      if(var_0.isairlockdoor[var_1] > 0) {
        if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_new_digits >= 0) {
          var_0.ref_133C1[var_1] = var_4.spawn_new_digits > 0;
          return;
        }

        if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_pavelow_boss >= 0) {
          var_0.ref_133C1[var_1] = var_4.spawn_pavelow_boss > 0;
          return;
        }

        var_0.ref_133C1[var_1] = var_7.ref_133C6;

        if(isDefined(var_4.ref_133C6[var_6]) && isDefined(var_4.ref_133C6[var_6][var_5])) {
          var_0.ref_133C1[var_1] = var_4.ref_133C6[var_6][var_5];
        }

        return;
      }
    }

    var_11 = undefined;

    if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_3 >= 0) {
      var_11 = var_4.spawn_module_lmg_3;
    } else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_obit_struct >= 0) {
      var_11 = var_4.spawn_obit_struct;
    } else {
      var_11 = var_7.is_using_stealth_debug;

      if(isDefined(var_4.is_using_stealth_debug[var_6]) && isDefined(var_4.is_using_stealth_debug[var_6][var_5])) {
        var_11 = var_4.is_using_stealth_debug[var_6][var_5];
      }

      if(var_11 > 0 && var_3 >= var_11) {
        var_0.isairlockdoor[var_1] = 0;

        if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_a >= 0) {
          var_0.isairlockdoor[var_1] = var_4.spawn_module_p3_form_a;
        } else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_extra_atvs >= 0) {
          var_0.isairlockdoor[var_1] = var_4.spawn_overwatch_extra_atvs;
        } else {
          var_0.isairlockdoor[var_1] = var_7.isakimbomeleeweapon;

          if(isDefined(var_4.isakimbomeleeweapon[var_6]) && isDefined(var_4.isakimbomeleeweapon[var_6][var_5])) {
            var_13 = var_4.isakimbomeleeweapon[var_6][var_5];
          }
        }

        if(var_0.isairlockdoor[var_1] > 0) {
          if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_trickle >= 0) {
            var_0.ref_133C1[var_1] = var_4.spawn_module_trickle > 0;
            return;
          }

          if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_parking_guys >= 0) {
            var_0.ref_133C1[var_1] = var_4.spawn_parking_guys > 0;
            return;
          }

          var_0.ref_133C1[var_1] = var_7.ref_133C5;

          if(isDefined(var_4.ref_133C5[var_6]) && isDefined(var_4.ref_133C5[var_6][var_5])) {
            var_0.ref_133C5[var_1] = var_4.ref_133C5[var_6][var_5];
          }

          return;
        }
      }
    }
  }

  var_0.isairlockdoor[var_1] = 0;
  var_0.ref_133C1[var_1] = 0;
}

function ref_14119(var_0, var_1, var_2) {
  if(var_0.stack_patch_thread_root[var_1]) {
    return;
  }

  if(var_0.isairlockdoor[var_1] <= 0) {
    return;
  }

  var_3 = var_0.ent[var_1];
  var_4 = var_0.ent[var_2];

  if(getdvarint("PNPLTTTNN", 0) && var_3 method_87dc()) {
    return;
  }

  var_5 = var_3.maxhealth * var_0.isairlockdoor[var_1] / 100;
  var_6 = var_0.ent[var_1].health;

  if(var_0.ref_133C1[var_1]) {
    var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);
  }

  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 dodamage(var_5, var_0.position[var_1], undefined, var_4, "MOD_CRUSH", var_4.objweapon);
  }

  if(isDefined(var_3)) {
    if(var_0.ref_133C1[var_1]) {
      var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
    }

    if(var_3.health < var_6) {
      thread ref_14113(var_3, var_4, 1.5);
      return;
    }

    return;
  }
}

function ref_14113(var_0, var_1, var_2) {
  if(!isDefined(var_0.ref_14100)) {
    var_0.ref_14100 = [];
  }

  var_3 = var_1 getentitynumber();
  var_0.ref_14100[var_3] = var_1;
  wait var_2;

  if(isDefined(var_0) && isDefined(var_0.ref_14100)) {
    var_0.ref_14100[var_3] = undefined;

    if(var_0.ref_14100.size == 0) {
      var_0.ref_14100 = undefined;
      return;
    }

    return;
  }
}

function ref_1410D(var_0, var_1, var_2) {
  if(!isDefined(var_0.stack_patch_thread_root)) {
    var_0.stack_patch_thread_root = [];
  }

  if(var_0.ref_12B4D < 100) {
    var_0.stack_patch_thread_root[var_1] = 1;
    return;
  }

  var_3 = var_0.ent[var_1];

  if(isDefined(var_3.ref_14100) && isDefined(var_0.ent[var_2]) && isDefined(var_3.ref_14100[var_0.ent[var_2] getentitynumber()])) {
    var_0.stack_patch_thread_root[var_1] = 1;
    return;
  }

  var_0.stack_patch_thread_root[var_1] = 0;
}

function ref_14108() {
  ref_14109();
}

function ref_14109() {
  var_0 = ref_1410E();
  var_0.ref_11E02 = getdvarint("scr_vehColDisableMulti", 0) > 0;
  var_0.ref_11E01 = getdvarint("scr_vehColDebugMulti", 0) > 0;
  var_0.spawn_module_p3_form_d = getdvarint("scr_vehColHost", 0) > 0;
  var_0.spawn_module_lmg_1 = getdvarfloat("scr_vehColHost_attackFactorMod", -1);
  var_0.spawn_module_p3_form_c = getdvarfloat("scr_vehColHost_defenseFactorMod", -1);
  var_0.spawn_module_lmg_3 = getdvarint("scr_vehColHost_damageFactorLow", -1);
  var_0.spawn_module_lmg_4 = getdvarint("scr_vehColHost_damageFactorMedium", -1);
  var_0.spawn_module_lmg_2 = getdvarint("scr_vehColHost_damageFactorHigh", -1);
  var_0.spawn_module_p3_form_a = getdvarint("scr_vehColHost_damagePercentLow", -1);
  var_0.spawn_module_p3_form_b = getdvarint("scr_vehColHost_damagePercentMedium", -1);
  var_0.spawn_module_lmg_5 = getdvarint("scr_vehColHost_damagePercentHigh", -1);
  var_0.spawn_module_trickle = getdvarint("scr_vehColHost_skipBurnDownLow", -1);
  var_0.spawn_new_digits = getdvarint("scr_vehColHost_skipBurnDownMedium", -1);
  var_0.spawn_module_soldiers1 = getdvarint("scr_vehColHost_skipBurnDownHigh", -1);
  var_0.spawn_para_and_heli_logic = getdvarint("scr_vehColHostVictim", 0) > 0;
  var_0.spawn_new_ents = getdvarfloat("scr_vehColHostVictim_attackFactorMod", -1);
  var_0.spawn_overwatch_soldiers_01 = getdvarfloat("scr_vehColHostVictim_defenseFactorMod", -1);
  var_0.spawn_obit_struct = getdvarint("scr_vehColHostVictim_damageFactorLow", -1);
  var_0.spawn_objective = getdvarint("scr_vehColHostVictim_damageFactorMedium", -1);
  var_0.spawn_obit_model = getdvarint("scr_vehColHostVictim_damageFactorHigh", -1);
  var_0.spawn_overwatch_extra_atvs = getdvarint("scr_vehColHostVictim_damagePercentLow", -1);
  var_0.spawn_overwatch_final_tank = getdvarint("scr_vehColHostVictim_damagePercentMedium", -1);
  var_0.spawn_origin = getdvarint("scr_vehColHostVictim_damagePercentHigh", -1);
  var_0.spawn_parking_guys = getdvarint("scr_vehColHostVictim_skipBurnDownLow", -1);
  var_0.spawn_pavelow_boss = getdvarint("scr_vehColHostVictim_skipBurnDownMedium", -1);
  var_0.spawn_paratrooper_ac130 = getdvarint("scr_vehColHostVictim_skipBurnDownHigh", -1);
}

function ref_14115() {
  var_0 = ref_1410E();
  var_1 = spawnStruct();
  var_0.challengeevaluator = [];
  var_0.keycardlocs_chosen = [];
  var_0.is_using_stealth_debug = [];
  var_0.is_valid_station_name = [];
  var_0.is_two_hit_melee_weapon = [];
  var_0.isakimbomeleeweapon = [];
  var_0.isallowedweapon = [];
  var_0.isakimbo = [];
  var_0.ref_133C5 = [];
  var_0.ref_133C6 = [];
  var_0.ref_133C4 = [];
  var_2 = [];
  var_3 = [];
  GscBinSkip0(0x2e, "attackFactorMod", []);
}

function ref_14116(var_0, var_1, var_2, var_3) {
  var_4 = ref_1410E();

  if(var_2 == "attackFactorMod") {
    var_5 = float(var_0);

    if(!isDefined(var_4.challengeevaluator[var_1])) {
      var_4.challengeevaluator[var_1] = [];
    }

    var_4.challengeevaluator[var_1][var_3] = var_5;
    return;
  }

  if(var_2 == "defenseFactorMod") {
    var_5 = float(var_0);

    if(!isDefined(var_4.keycardlocs_chosen[var_1])) {
      var_4.keycardlocs_chosen[var_1] = [];
    }

    var_4.keycardlocs_chosen[var_1][var_3] = var_5;
    return;
  }

  if(var_2 == "damageFactorLow") {
    var_5 = int(var_0);

    if(!isDefined(var_4.is_using_stealth_debug[var_1])) {
      var_4.is_using_stealth_debug[var_1] = [];
    }

    var_4.is_using_stealth_debug[var_1][var_3] = var_5;
    return;
  }

  if(var_2 == "damageFactorMedium") {
    var_5 = int(var_0);

    if(!isDefined(var_4.is_valid_station_name[var_1])) {
      var_4.is_valid_station_name[var_1] = [];
    }

    var_4.is_valid_station_name[var_1][var_3] = var_5;
    return;
  }

  if(var_2 == "damageFactorHigh") {
    var_5 = int(var_0);

    if(!isDefined(var_4.is_two_hit_melee_weapon[var_1])) {
      var_4.is_two_hit_melee_weapon[var_1] = [];
    }

    var_4.is_two_hit_melee_weapon[var_1][var_3] = var_5;
    return;
  }

  if(var_2 == "damagePercentLow") {
    var_5 = int(var_0);

    if(!isDefined(var_4.isakimbomeleeweapon[var_1])) {
      var_4.isakimbomeleeweapon[var_1] = [];
    }

    var_4.isakimbomeleeweapon[var_1][var_3] = var_5;
    return;
  }

  if(var_2 == "damagePercentMedium") {
    var_5 = int(var_0);

    if(!isDefined(var_4.isallowedweapon[var_1])) {
      var_4.isallowedweapon[var_1] = [];
    }

    var_4.isallowedweapon[var_1][var_3] = var_5;
    return;
  }

  if(var_2 == "damagePercentHigh") {
    var_5 = int(var_0);

    if(!isDefined(var_4.isakimbo[var_1])) {
      var_4.isakimbo[var_1] = [];
    }

    var_4.isakimbo[var_1][var_3] = var_5;
    return;
  }

  if(var_2 == "skipBurnDownLow") {
    var_5 = int(var_0);

    if(!isDefined(var_4.ref_133C5[var_1])) {
      var_4.ref_133C5[var_1] = [];
    }

    var_4.ref_133C5[var_1][var_3] = var_5 > 0;
    return;
  }

  if(var_2 == "skipBurnDownMedium") {
    var_5 = int(var_0);

    if(!isDefined(var_4.ref_133C6[var_1])) {
      var_4.ref_133C6[var_1] = [];
    }

    var_4.ref_133C6[var_1][var_3] = var_5 > 0;
    return;
  }

  if(var_2 == "skipBurnDownHigh") {
    var_5 = int(var_0);

    if(!isDefined(var_4.ref_133C4[var_1])) {
      var_4.ref_133C4[var_1] = [];
    }

    var_4.ref_133C4[var_1][var_3] = var_5 > 0;
    return;
  }
}