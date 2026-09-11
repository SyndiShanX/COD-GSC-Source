/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58241.gsc
***********************************************/

function ref_14114() {
  var0 = spawnStruct();
  level.vehicle.collision = var0;
  var0.vehicledata = [];
  ref_14115();
  ref_14108();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_collision", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_collision", "init")]]();
  }

  thread ref_1411a();
}

function ref_1411a() {
  level endon("game_ended");
  var0 = ref_1410e();

  for(;;) {
    var0.eventdata = [];
    var0.eventid = 0;
    waitframe();
  }
}

function ref_1411b(var0) {
  level endon("game_ended");

  if(!isDefined(ref_1410f(var0.vehiclename, 0, 1))) {
    return;
  }

  var0 notify("vehicle_collision_updateInstance");
  var0 endon("vehicle_collision_updateInstance");
  var0 vehphys_enablecollisioncallback(1);

  while(isDefined(var0)) {
    var0 waittill("collision", var1, var2, var3, var4, var5, var6, var7, var8, var9);
    ref_14117(var0, var8, var1, var2, var3, var4, var5, var6, var7, var9);
  }
}

function ref_1411c(var0) {
  var0 notify("vehicle_collision_updateInstance");
}

function ref_1410e() {
  return level.vehicle.collision;
}

function ref_1410f(var0, var1, var2) {
  var3 = ref_1410e();
  var4 = var3.vehicledata[var0];

  if(!isDefined(var4)) {
    if(istrue(var1)) {
      var4 = spawnStruct();
      var3.vehicledata[var0] = var4;
      var4.ref = var0;
      var4.ref_12b1e = undefined;
      var4.setup_techo_lmgs = undefined;
      var4.challengeevaluator = 1;
      var4.keycardlocs_chosen = 1;
      var4.is_using_stealth_debug = 0;
      var4.is_valid_station_name = 0;
      var4.is_two_hit_melee_weapon = 0;
      var4.isakimbomeleeweapon = 5;
      var4.isallowedweapon = 20;
      var4.isakimbo = 40;
      var4.ref_133c5 = 0;
      var4.ref_133c6 = 0;
      var4.ref_133c4 = 0;
    } else if(istrue(var2)) {}
  }

  return var4;
}

function ref_1410c(var0, var1) {
  var2 = ref_1410e();
  var3 = ref_1410f(var0.vehiclename, 0, 1);

  if(!isDefined(var3)) {
    return;
  }

  var4 = var0 getentitynumber();
  var5 = "none";

  if(isDefined(var1) && var1 != var0 && (!isDefined(var1.classname) || var1.classname != "worldspawn")) {
    var5 = var1 getentitynumber();
  }

  if(!isDefined(var2.eventdata[var4])) {
    var2.eventdata[var4] = [];
  }

  var6 = isDefined(var1) && var1 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(ref_1410f(var1.vehiclename, 0, 1));
  var7 = undefined;

  if(isDefined(var2.eventdata[var4][var5])) {
    if(isstring(var5) && var5 == "none") {}

    var7 = var2.eventdata[var4][var5];
  } else if(var6) {
    if(!isDefined(var2.eventdata[var5])) {
      var2.eventdata[var5] = [];
    }

    if(isDefined(var2.eventdata[var5][var4])) {
      var7 = var2.eventdata[var5][var4];
    }
  }

  if(!isDefined(var7)) {
    var7 = spawnStruct();
    var2.eventdata[var4][var5] = var7;

    if(var6) {
      var2.eventdata[var5][var4] = var7;
    }

    var7.id = var2.eventid;
    var2.eventid++;
    var7.time = gettime();
    var7.ent = [];
    var7.cop_car_initomnvars = [];
    var7.body1 = [];
    var7.player_has_primary_weapons_max_ammo = [];
    var7.player_has_primary_weapons_max_stock_ammo = [];
    var7.position = [];
    var7.normal = [];
    var7.ref_11ebb = [];
    var7.ref_121e2 = [];
    var7.angles = [];
    var7.velocity = [];
  }

  return var7;
}

function ref_14117(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var1) || var1 == var0 || isDefined(var1.classname) && var1.classname == "worldspawn") {
    var1 = undefined;
  }

  var10 = ref_1410c(var0, var1);

  if(!isDefined(var10)) {
    return;
  }

  level notify("vehicle_collision_registerEvent_" + var10.id);
  var11 = undefined;

  foreach(var11, var13 in var10.ent) {
    if(var13 == var0) {
      break;
    }
  }

  if(!isDefined(var11)) {
    var11 = var10.ent.size;
  }

  var10.ent[var11] = var0;
  var10.cop_car_initomnvars[var11] = var2;
  var10.body1[var11] = var3;
  var10.player_has_primary_weapons_max_ammo[var11] = var4;
  var10.player_has_primary_weapons_max_stock_ammo[var11] = var5;
  var10.position[var11] = var6;
  var10.normal[var11] = var7;
  var10.ref_11ebb[var11] = var8;
  var10.ref_121e2[var11] = var9;
  var10.angles[var11] = var0.angles;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
    var10.velocity[var11] = var0 vehicle_getvelocity();
  } else {
    var10.velocity[var11] = (0, 0, 0);
  }

  if(var10.ent.size == 1) {
    var10.ent[1] = var1;
  }

  var14 = ref_1410f(var0.vehiclename);

  if(isDefined(var14.ref_12b1e)) {
    [[var14.ref_12b1e]](var10, var11);
  }

  thread ref_14118(var10);
}

function ref_14118(var0) {
  level endon("game_ended");
  level endon("vehicle_collision_registerEvent_" + var0.id);
  waittillframeend();
  thread ref_14110(var0);
}

function ref_14110(var0) {
  ref_14111(var0);

  foreach(var2 in var0.ent) {
    if(!isDefined(var2.vehiclename)) {
      continue;
    }

    var3 = ref_1410f(var2.vehiclename, 0, 1);

    if(!isDefined(var3)) {
      continue;
    }

    if(isDefined(var3.setup_techo_lmgs)) {
      [[var3.setup_techo_lmgs]](var0, var4);
    }
  }
}

function ref_14111(var0) {
  var1 = ref_1410e();

  if(var1.ref_11e02) {
    return;
  }

  if(var0.ent.size < 2 || var0.velocity.size < 2) {
    return;
  }

  var2 = var0.ent.size;
  var0.armorbox_usedcallback = [];

  for(var3 = 0; var3 < var2; var3++) {
    var0.armorbox_usedcallback[var3] = vectordot(var0.velocity[var3], var0.normal[var3]);
  }

  var0.ref_12b4d = int(abs(var0.armorbox_usedcallback[0] - var0.armorbox_usedcallback[1]));

  for(var3 = 0; var3 < var2; var3++) {
    var0.armorbox_usedcallback[var3] = int(abs(var0.armorbox_usedcallback[var3]));
  }

  var0.unset_relic_nuketimer = [];
  ref_1410d(var0, 0, 1);
  ref_1410d(var0, 1, 0);
  ref_1410a(var0, 0, 1);
  ref_1410a(var0, 1, 0);
  ref_1410b(var0, 0, 1);
  ref_1410b(var0, 1, 0);
  ref_14119(var0, 0, 1);
  ref_14119(var0, 1, 0);
}

function ref_1410a(var0, var1, var2, var3) {
  if(var0.stack_patch_thread_root[var1]) {
    return;
  }

  if(!isDefined(var0.is_trials_level)) {
    var0.is_trials_level = [];
  }

  var4 = ref_1410e();
  var5 = var0.ent[var1].vehiclename;
  var6 = var0.ent[var2].vehiclename;
  var7 = ref_1410f(var5, 0, 1);
  var8 = ref_1410f(var6, 0, 1);
  var9 = istrue(var0.unset_relic_nuketimer[var1]);
  var10 = istrue(var0.unset_relic_nuketimer[var2]);
  var11 = var0.armorbox_usedcallback[var1];
  var12 = var0.armorbox_usedcallback[var2];
  var13 = undefined;

  if(var9 && var4.spawn_para_and_heli_logic && var4.spawn_new_ents >= 0) {
    var13 = var4.spawn_new_ents;
  } else if(var10 && var4.spawn_module_p3_form_d && var4.spawn_module_lmg_1 >= 0) {
    var13 = var4.spawn_module_lmg_1;
  } else {
    var13 = var8.challengeevaluator;

    if(isDefined(var4.challengeevaluator[var5]) && isDefined(var4.challengeevaluator[var5][var6])) {
      var13 = var4.challengeevaluator[var5][var6];
    }
  }

  var14 = undefined;

  if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_p3_form_c >= 0) {
    var14 = var4.spawn_module_p3_form_c;
  } else if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_overwatch_soldiers_01 >= 0) {
    var14 = var4.spawn_overwatch_soldiers_01;
  } else {
    var14 = var7.keycardlocs_chosen;

    if(isDefined(var4.keycardlocs_chosen[var5]) && isDefined(var4.keycardlocs_chosen[var5][var6])) {
      var14 = var4.keycardlocs_chosen[var5][var6];
    }
  }

  var15 = var0.ent[var1];
  var16 = var0.ent[var2];

  if(isDefined(var16.ref_11e06)) {
    var13 *= var16.ref_11e06;
  }

  if(isDefined(var15.ref_11e07)) {
    var14 *= var15.ref_11e07;
  }

  var0.is_trials_level[var1] = var12 / (var11 + var12) * var0.ref_12b4d * var13 * var14;
}

function ref_1410b(var0, var1, var2) {
  if(var0.stack_patch_thread_root[var1]) {
    return;
  }

  var3 = var0.is_trials_level[var1];

  if(!isDefined(var0.isairlockdoor)) {
    var0.isairlockdoor = [];
    var0.ref_133c1 = [];
  }

  if(var3 > 0) {
    var4 = ref_1410e();
    var5 = var0.ent[var1].vehiclename;
    var6 = var0.ent[var2].vehiclename;
    var7 = ref_1410f(var5, 0, 1);
    var8 = ref_1410f(var6, 0, 1);
    var9 = istrue(var0.unset_relic_nuketimer[var1]);
    var10 = istrue(var0.unset_relic_nuketimer[var2]);
    var11 = undefined;

    if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_lmg_2 >= 0) {
      var11 = var4.spawn_module_lmg_2;
    } else if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_obit_model >= 0) {
      var11 = var4.spawn_obit_model;
    } else {
      var11 = var7.is_two_hit_melee_weapon;

      if(isDefined(var4.is_two_hit_melee_weapon[var6]) && isDefined(var4.is_two_hit_melee_weapon[var6][var5])) {
        var11 = var4.is_two_hit_melee_weapon[var6][var5];
      }
    }

    if(var11 > 0 && var3 >= var11) {
      var0.isairlockdoor[var1] = 0;

      if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_lmg_5 >= 0) {
        var0.isairlockdoor[var1] = var4.spawn_module_lmg_5;
      } else if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_origin >= 0) {
        var0.isairlockdoor[var1] = var4.spawn_origin;
      } else {
        var0.isairlockdoor[var1] = var7.isakimbo;

        if(isDefined(var4.isakimbo[var6]) && isDefined(var4.isakimbo[var6][var5])) {
          var0.isairlockdoor[var1] = var4.isakimbo[var6][var5];
        }
      }

      if(var0.isairlockdoor[var1] > 0) {
        if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_soldiers1 >= 0) {
          var0.ref_133c1[var1] = var4.spawn_module_soldiers1 > 0;
          return;
        }

        if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_paratrooper_ac130 >= 0) {
          var0.ref_133c1[var1] = var4.spawn_paratrooper_ac130 > 0;
          return;
        }

        var0.ref_133c1[var1] = var7.ref_133c4;

        if(isDefined(var4.ref_133c4[var6]) && isDefined(var4.ref_133c4[var6][var5])) {
          var0.ref_133c1[var1] = var4.ref_133c4[var6][var5];
        }

        return;
      }
    }

    var11 = undefined;

    if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_lmg_4 >= 0) {
      var11 = var4.spawn_module_lmg_4;
    } else if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_objective >= 0) {
      var11 = var4.spawn_objective;
    } else {
      var11 = var7.is_valid_station_name;

      if(isDefined(var4.is_valid_station_name[var6]) && isDefined(var4.is_valid_station_name[var6][var5])) {
        var11 = var4.is_valid_station_name[var6][var5];
      }
    }

    if(var11 > 0 && var3 >= var11) {
      var0.isairlockdoor[var1] = 0;

      if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_p3_form_b >= 0) {
        var0.isairlockdoor[var1] = var4.spawn_module_p3_form_b;
      } else if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_overwatch_final_tank >= 0) {
        var0.isairlockdoor[var1] = var4.spawn_overwatch_final_tank;
      } else {
        var0.isairlockdoor[var1] = var7.isallowedweapon;

        if(isDefined(var4.isallowedweapon[var6]) && isDefined(var4.isallowedweapon[var6][var5])) {
          var12 = var4.isallowedweapon[var6][var5];
        }
      }

      if(var0.isairlockdoor[var1] > 0) {
        if(var9 && var4.spawn_module_p3_form_d && var4.spawn_new_digits >= 0) {
          var0.ref_133c1[var1] = var4.spawn_new_digits > 0;
          return;
        }

        if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_pavelow_boss >= 0) {
          var0.ref_133c1[var1] = var4.spawn_pavelow_boss > 0;
          return;
        }

        var0.ref_133c1[var1] = var7.ref_133c6;

        if(isDefined(var4.ref_133c6[var6]) && isDefined(var4.ref_133c6[var6][var5])) {
          var0.ref_133c1[var1] = var4.ref_133c6[var6][var5];
        }

        return;
      }
    }

    var11 = undefined;

    if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_lmg_3 >= 0) {
      var11 = var4.spawn_module_lmg_3;
    } else if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_obit_struct >= 0) {
      var11 = var4.spawn_obit_struct;
    } else {
      var11 = var7.is_using_stealth_debug;

      if(isDefined(var4.is_using_stealth_debug[var6]) && isDefined(var4.is_using_stealth_debug[var6][var5])) {
        var11 = var4.is_using_stealth_debug[var6][var5];
      }

      if(var11 > 0 && var3 >= var11) {
        var0.isairlockdoor[var1] = 0;

        if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_p3_form_a >= 0) {
          var0.isairlockdoor[var1] = var4.spawn_module_p3_form_a;
        } else if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_overwatch_extra_atvs >= 0) {
          var0.isairlockdoor[var1] = var4.spawn_overwatch_extra_atvs;
        } else {
          var0.isairlockdoor[var1] = var7.isakimbomeleeweapon;

          if(isDefined(var4.isakimbomeleeweapon[var6]) && isDefined(var4.isakimbomeleeweapon[var6][var5])) {
            var13 = var4.isakimbomeleeweapon[var6][var5];
          }
        }

        if(var0.isairlockdoor[var1] > 0) {
          if(var9 && var4.spawn_module_p3_form_d && var4.spawn_module_trickle >= 0) {
            var0.ref_133c1[var1] = var4.spawn_module_trickle > 0;
            return;
          }

          if(var10 && var4.spawn_para_and_heli_logic && var4.spawn_parking_guys >= 0) {
            var0.ref_133c1[var1] = var4.spawn_parking_guys > 0;
            return;
          }

          var0.ref_133c1[var1] = var7.ref_133c5;

          if(isDefined(var4.ref_133c5[var6]) && isDefined(var4.ref_133c5[var6][var5])) {
            var0.ref_133c5[var1] = var4.ref_133c5[var6][var5];
          }

          return;
        }
      }
    }
  }

  var0.isairlockdoor[var1] = 0;
  var0.ref_133c1[var1] = 0;
}

function ref_14119(var0, var1, var2) {
  if(var0.stack_patch_thread_root[var1]) {
    return;
  }

  if(var0.isairlockdoor[var1] <= 0) {
    return;
  }

  var3 = var0.ent[var1];
  var4 = var0.ent[var2];

  if(getdvarint("PNPLTTTNN", 0) && var3 method_87dc()) {
    return;
  }

  var5 = var3.maxhealth * var0.isairlockdoor[var1] / 100;
  var6 = var0.ent[var1].health;

  if(var0.ref_133c1[var1]) {
    var3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);
  }

  if(isDefined(var3) && isDefined(var4)) {
    var3 dodamage(var5, var0.position[var1], undefined, var4, "MOD_CRUSH", var4.objweapon);
  }

  if(isDefined(var3)) {
    if(var0.ref_133c1[var1]) {
      var3 scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
    }

    if(var3.health < var6) {
      thread ref_14113(var3, var4, 1.5);
      return;
    }

    return;
  }
}

function ref_14113(var0, var1, var2) {
  if(!isDefined(var0.ref_14100)) {
    var0.ref_14100 = [];
  }

  var3 = var1 getentitynumber();
  var0.ref_14100[var3] = var1;
  wait var2;

  if(isDefined(var0) && isDefined(var0.ref_14100)) {
    var0.ref_14100[var3] = undefined;

    if(var0.ref_14100.size == 0) {
      var0.ref_14100 = undefined;
      return;
    }

    return;
  }
}

function ref_1410d(var0, var1, var2) {
  if(!isDefined(var0.stack_patch_thread_root)) {
    var0.stack_patch_thread_root = [];
  }

  if(var0.ref_12b4d < 100) {
    var0.stack_patch_thread_root[var1] = 1;
    return;
  }

  var3 = var0.ent[var1];

  if(isDefined(var3.ref_14100) && isDefined(var0.ent[var2]) && isDefined(var3.ref_14100[var0.ent[var2] getentitynumber()])) {
    var0.stack_patch_thread_root[var1] = 1;
    return;
  }

  var0.stack_patch_thread_root[var1] = 0;
}

function ref_14108() {
  ref_14109();
}

function ref_14109() {
  var0 = ref_1410e();
  var0.ref_11e02 = getdvarint("scr_vehColDisableMulti", 0) > 0;
  var0.ref_11e01 = getdvarint("scr_vehColDebugMulti", 0) > 0;
  var0.spawn_module_p3_form_d = getdvarint("scr_vehColHost", 0) > 0;
  var0.spawn_module_lmg_1 = getdvarfloat("scr_vehColHost_attackFactorMod", -1);
  var0.spawn_module_p3_form_c = getdvarfloat("scr_vehColHost_defenseFactorMod", -1);
  var0.spawn_module_lmg_3 = getdvarint("scr_vehColHost_damageFactorLow", -1);
  var0.spawn_module_lmg_4 = getdvarint("scr_vehColHost_damageFactorMedium", -1);
  var0.spawn_module_lmg_2 = getdvarint("scr_vehColHost_damageFactorHigh", -1);
  var0.spawn_module_p3_form_a = getdvarint("scr_vehColHost_damagePercentLow", -1);
  var0.spawn_module_p3_form_b = getdvarint("scr_vehColHost_damagePercentMedium", -1);
  var0.spawn_module_lmg_5 = getdvarint("scr_vehColHost_damagePercentHigh", -1);
  var0.spawn_module_trickle = getdvarint("scr_vehColHost_skipBurnDownLow", -1);
  var0.spawn_new_digits = getdvarint("scr_vehColHost_skipBurnDownMedium", -1);
  var0.spawn_module_soldiers1 = getdvarint("scr_vehColHost_skipBurnDownHigh", -1);
  var0.spawn_para_and_heli_logic = getdvarint("scr_vehColHostVictim", 0) > 0;
  var0.spawn_new_ents = getdvarfloat("scr_vehColHostVictim_attackFactorMod", -1);
  var0.spawn_overwatch_soldiers_01 = getdvarfloat("scr_vehColHostVictim_defenseFactorMod", -1);
  var0.spawn_obit_struct = getdvarint("scr_vehColHostVictim_damageFactorLow", -1);
  var0.spawn_objective = getdvarint("scr_vehColHostVictim_damageFactorMedium", -1);
  var0.spawn_obit_model = getdvarint("scr_vehColHostVictim_damageFactorHigh", -1);
  var0.spawn_overwatch_extra_atvs = getdvarint("scr_vehColHostVictim_damagePercentLow", -1);
  var0.spawn_overwatch_final_tank = getdvarint("scr_vehColHostVictim_damagePercentMedium", -1);
  var0.spawn_origin = getdvarint("scr_vehColHostVictim_damagePercentHigh", -1);
  var0.spawn_parking_guys = getdvarint("scr_vehColHostVictim_skipBurnDownLow", -1);
  var0.spawn_pavelow_boss = getdvarint("scr_vehColHostVictim_skipBurnDownMedium", -1);
  var0.spawn_paratrooper_ac130 = getdvarint("scr_vehColHostVictim_skipBurnDownHigh", -1);
}

function ref_14115() {
  var0 = ref_1410e();
  var1 = spawnStruct();
  var0.challengeevaluator = [];
  var0.keycardlocs_chosen = [];
  var0.is_using_stealth_debug = [];
  var0.is_valid_station_name = [];
  var0.is_two_hit_melee_weapon = [];
  var0.isakimbomeleeweapon = [];
  var0.isallowedweapon = [];
  var0.isakimbo = [];
  var0.ref_133c5 = [];
  var0.ref_133c6 = [];
  var0.ref_133c4 = [];
  var2 = [];
  var3 = [];
  GscBinSkip0(0x2e, "attackFactorMod", []);
}

function ref_14116(var0, var1, var2, var3) {
  var4 = ref_1410e();

  if(var2 == "attackFactorMod") {
    var5 = float(var0);

    if(!isDefined(var4.challengeevaluator[var1])) {
      var4.challengeevaluator[var1] = [];
    }

    var4.challengeevaluator[var1][var3] = var5;
    return;
  }

  if(var2 == "defenseFactorMod") {
    var5 = float(var0);

    if(!isDefined(var4.keycardlocs_chosen[var1])) {
      var4.keycardlocs_chosen[var1] = [];
    }

    var4.keycardlocs_chosen[var1][var3] = var5;
    return;
  }

  if(var2 == "damageFactorLow") {
    var5 = int(var0);

    if(!isDefined(var4.is_using_stealth_debug[var1])) {
      var4.is_using_stealth_debug[var1] = [];
    }

    var4.is_using_stealth_debug[var1][var3] = var5;
    return;
  }

  if(var2 == "damageFactorMedium") {
    var5 = int(var0);

    if(!isDefined(var4.is_valid_station_name[var1])) {
      var4.is_valid_station_name[var1] = [];
    }

    var4.is_valid_station_name[var1][var3] = var5;
    return;
  }

  if(var2 == "damageFactorHigh") {
    var5 = int(var0);

    if(!isDefined(var4.is_two_hit_melee_weapon[var1])) {
      var4.is_two_hit_melee_weapon[var1] = [];
    }

    var4.is_two_hit_melee_weapon[var1][var3] = var5;
    return;
  }

  if(var2 == "damagePercentLow") {
    var5 = int(var0);

    if(!isDefined(var4.isakimbomeleeweapon[var1])) {
      var4.isakimbomeleeweapon[var1] = [];
    }

    var4.isakimbomeleeweapon[var1][var3] = var5;
    return;
  }

  if(var2 == "damagePercentMedium") {
    var5 = int(var0);

    if(!isDefined(var4.isallowedweapon[var1])) {
      var4.isallowedweapon[var1] = [];
    }

    var4.isallowedweapon[var1][var3] = var5;
    return;
  }

  if(var2 == "damagePercentHigh") {
    var5 = int(var0);

    if(!isDefined(var4.isakimbo[var1])) {
      var4.isakimbo[var1] = [];
    }

    var4.isakimbo[var1][var3] = var5;
    return;
  }

  if(var2 == "skipBurnDownLow") {
    var5 = int(var0);

    if(!isDefined(var4.ref_133c5[var1])) {
      var4.ref_133c5[var1] = [];
    }

    var4.ref_133c5[var1][var3] = var5 > 0;
    return;
  }

  if(var2 == "skipBurnDownMedium") {
    var5 = int(var0);

    if(!isDefined(var4.ref_133c6[var1])) {
      var4.ref_133c6[var1] = [];
    }

    var4.ref_133c6[var1][var3] = var5 > 0;
    return;
  }

  if(var2 == "skipBurnDownHigh") {
    var5 = int(var0);

    if(!isDefined(var4.ref_133c4[var1])) {
      var4.ref_133c4[var1] = [];
    }

    var4.ref_133c4[var1][var3] = var5 > 0;
    return;
  }
}