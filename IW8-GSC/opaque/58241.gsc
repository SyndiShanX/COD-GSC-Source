/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58241.gsc
***********************************************/

_id_14114() {
  var_0 = spawnStruct();
  level.vehicle.collision = var_0;
  var_0.vehicledata = [];
  _id_14115();
  _id_14108();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_87F212A84A04F3499B55988E27E3D0BBAA12E8D0", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_87F212A84A04F3499B55988E27E3D0BBAA12E8D0", "_encstr_88C5055208731B")]]();

  thread _id_1411A();
}

_id_1411A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = _id_1410E();

  for(;;) {
    var_0.eventdata = [];
    var_0.eventid = 0;
    waitframe();
  }
}

_id_1411B(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(_id_1410F(var_0.vehiclename, 0, 1))) {
    return;
  }
  var_0 notify("_encstr_85BA210B40B93CEFD0E50F2B88B89B44F7480202292BB20BA9553D091063238E65802A");
  var_0 endon("_encstr_85BA210B40B93CEFD0E50F2B88B89B44F7480202292BB20BA9553D091063238E65802A");
  var_0 vehphys_enablecollisioncallback(1);

  while(isDefined(var_0)) {
    var_0 waittill("_encstr_93510A16C71B20636A2AB8B8", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    _id_14117(var_0, var_8, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_9);
  }
}

_id_1411C(var_0) {
  var_0 notify("_encstr_85BA210B40B93CEFD0E50F2B88B89B44F7480202292BB20BA9553D091063238E65802A");
}

_id_1410E() {
  return level.vehicle.collision;
}

_id_1410F(var_0, var_1, var_2) {
  var_3 = _id_1410E();
  var_4 = var_3.vehicledata[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3.vehicledata[var_0] = var_4;
      var_4.ref = var_0;
      var_4._id_12B1E = undefined;
      var_4.setup_techo_lmgs = undefined;
      var_4.challengeevaluator = 1;
      var_4.keycardlocs_chosen = 1;
      var_4.is_using_stealth_debug = 0;
      var_4.is_valid_station_name = 0;
      var_4.is_two_hit_melee_weapon = 0;
      var_4.isakimbomeleeweapon = 5;
      var_4.isallowedweapon = 20;
      var_4.isakimbo = 40;
      var_4._id_133C5 = 0;
      var_4._id_133C6 = 0;
      var_4._id_133C4 = 0;
    } else if(!istrue(var_2)) {}
  }

  return var_4;
}

_id_1410C(var_0, var_1) {
  var_2 = _id_1410E();
  var_3 = _id_1410F(var_0.vehiclename, 0, 1);

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_0 getentitynumber();
  var_5 = "_encstr_8BBA05185F8B99";

  if(isDefined(var_1) && var_1 != var_0 && (!isDefined(var_1.classname) || var_1.classname != "_encstr_BD4E0B7B104D6AD4DB384717A0"))
    var_5 = var_1 getentitynumber();

  if(!isDefined(var_2.eventdata[var_4]))
    var_2.eventdata[var_4] = [];

  var_6 = isDefined(var_1) && var_1 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(_id_1410F(var_1.vehiclename, 0, 1));
  var_7 = undefined;

  if(isDefined(var_2.eventdata[var_4][var_5])) {
    if(isstring(var_5) && var_5 == "_encstr_8BBA05185F8B99") {}

    var_7 = var_2.eventdata[var_4][var_5];
  } else if(var_6) {
    if(!isDefined(var_2.eventdata[var_5]))
      var_2.eventdata[var_5] = [];

    if(isDefined(var_2.eventdata[var_5][var_4]))
      var_7 = var_2.eventdata[var_5][var_4];
  }

  if(!isDefined(var_7)) {
    var_7 = spawnStruct();
    var_2.eventdata[var_4][var_5] = var_7;

    if(var_6)
      var_2.eventdata[var_5][var_4] = var_7;

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
    var_7._id_11EBB = [];
    var_7._id_121E2 = [];
    var_7.angles = [];
    var_7.velocity = [];
  }

  return var_7;
}

_id_14117(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_1) || var_1 == var_0 || isDefined(var_1.classname) && var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0")
    var_1 = undefined;

  var_10 = _id_1410C(var_0, var_1);

  if(!isDefined(var_10)) {
    return;
  }
  level notify("_encstr_9B0D21EC59D0A5D8B1B2F5B1BD63C6B4372DDBDCFA9CACB32DDC1D2BC92ACECADC1DEB" + var_10.id);
  var_11 = undefined;

  foreach(var_11, var_13 in var_10.ent) {
    if(var_13 == var_0) {
      break;
    }
  }

  if(!isDefined(var_11))
    var_11 = var_10.ent.size;

  var_10.ent[var_11] = var_0;
  var_10.cop_car_initomnvars[var_11] = var_2;
  var_10.body1[var_11] = var_3;
  var_10.player_has_primary_weapons_max_ammo[var_11] = var_4;
  var_10.player_has_primary_weapons_max_stock_ammo[var_11] = var_5;
  var_10.position[var_11] = var_6;
  var_10.normal[var_11] = var_7;
  var_10._id_11EBB[var_11] = var_8;
  var_10._id_121E2[var_11] = var_9;
  var_10.angles[var_11] = var_0.angles;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle())
    var_10.velocity[var_11] = var_0 vehicle_getvelocity();
  else
    var_10.velocity[var_11] = (0, 0, 0);

  if(var_10.ent.size == 1)
    var_10.ent[1] = var_1;

  var_14 = _id_1410F(var_0.vehiclename);

  if(isDefined(var_14._id_12B1E))
    [[var_14._id_12B1E]](var_10, var_11);

  thread _id_14118(var_10);
}

_id_14118(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9B0D21EC59D0A5D8B1B2F5B1BD63C6B4372DDBDCFA9CACB32DDC1D2BC92ACECADC1DEB" + var_0.id);
  waittillframeend;
  thread _id_14110(var_0);
}

_id_14110(var_0) {
  _id_14111(var_0);

  foreach(var_4, var_2 in var_0.ent) {
    if(!isDefined(var_2.vehiclename)) {
      continue;
    }
    var_3 = _id_1410F(var_2.vehiclename, 0, 1);

    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3.setup_techo_lmgs))
      [[var_3.setup_techo_lmgs]](var_0, var_4);
  }
}

_id_14111(var_0) {
  var_1 = _id_1410E();

  if(var_1._id_11E02) {
    return;
  }
  if(var_0.ent.size < 2 || var_0.velocity.size < 2) {
    return;
  }
  var_2 = var_0.ent.size;
  var_0.armorbox_usedcallback = [];

  for(var_3 = 0; var_3 < var_2; var_3++)
    var_0.armorbox_usedcallback[var_3] = vectordot(var_0.velocity[var_3], var_0.normal[var_3]);

  var_0._id_12B4D = int(abs(var_0.armorbox_usedcallback[0] - var_0.armorbox_usedcallback[1]));

  for(var_3 = 0; var_3 < var_2; var_3++)
    var_0.armorbox_usedcallback[var_3] = int(abs(var_0.armorbox_usedcallback[var_3]));

  var_0.unset_relic_nuketimer = [];
  _id_1410D(var_0, 0, 1);
  _id_1410D(var_0, 1, 0);
  _id_1410A(var_0, 0, 1);
  _id_1410A(var_0, 1, 0);
  _id_1410B(var_0, 0, 1);
  _id_1410B(var_0, 1, 0);
  _id_14119(var_0, 0, 1);
  _id_14119(var_0, 1, 0);
}

_id_1410A(var_0, var_1, var_2, var_3) {
  if(var_0.stack_patch_thread_root[var_1]) {
    return;
  }
  if(!isDefined(var_0.is_trials_level))
    var_0.is_trials_level = [];

  var_4 = _id_1410E();
  var_5 = var_0.ent[var_1].vehiclename;
  var_6 = var_0.ent[var_2].vehiclename;
  var_7 = _id_1410F(var_5, 0, 1);
  var_8 = _id_1410F(var_6, 0, 1);
  var_9 = istrue(var_0.unset_relic_nuketimer[var_1]);
  var_10 = istrue(var_0.unset_relic_nuketimer[var_2]);
  var_11 = var_0.armorbox_usedcallback[var_1];
  var_12 = var_0.armorbox_usedcallback[var_2];
  var_13 = undefined;

  if(var_9 && var_4.spawn_para_and_heli_logic && var_4.spawn_new_ents >= 0)
    var_13 = var_4.spawn_new_ents;
  else if(var_10 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_1 >= 0)
    var_13 = var_4.spawn_module_lmg_1;
  else {
    var_13 = var_8.challengeevaluator;

    if(isDefined(var_4.challengeevaluator[var_5]) && isDefined(var_4.challengeevaluator[var_5][var_6]))
      var_13 = var_4.challengeevaluator[var_5][var_6];
  }

  var_14 = undefined;

  if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_c >= 0)
    var_14 = var_4.spawn_module_p3_form_c;
  else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_soldiers_01 >= 0)
    var_14 = var_4.spawn_overwatch_soldiers_01;
  else {
    var_14 = var_7.keycardlocs_chosen;

    if(isDefined(var_4.keycardlocs_chosen[var_5]) && isDefined(var_4.keycardlocs_chosen[var_5][var_6]))
      var_14 = var_4.keycardlocs_chosen[var_5][var_6];
  }

  var_15 = var_0.ent[var_1];
  var_16 = var_0.ent[var_2];

  if(isDefined(var_16._id_11E06))
    var_13 = var_13 * var_16._id_11E06;

  if(isDefined(var_15._id_11E07))
    var_14 = var_14 * var_15._id_11E07;

  var_0.is_trials_level[var_1] = var_12 / (var_11 + var_12) * var_0._id_12B4D * var_13 * var_14;
}

_id_1410B(var_0, var_1, var_2) {
  if(var_0.stack_patch_thread_root[var_1]) {
    return;
  }
  var_3 = var_0.is_trials_level[var_1];

  if(!isDefined(var_0.isairlockdoor)) {
    var_0.isairlockdoor = [];
    var_0._id_133C1 = [];
  }

  if(var_3 > 0) {
    var_4 = _id_1410E();
    var_5 = var_0.ent[var_1].vehiclename;
    var_6 = var_0.ent[var_2].vehiclename;
    var_7 = _id_1410F(var_5, 0, 1);
    var_8 = _id_1410F(var_6, 0, 1);
    var_9 = istrue(var_0.unset_relic_nuketimer[var_1]);
    var_10 = istrue(var_0.unset_relic_nuketimer[var_2]);
    var_11 = undefined;

    if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_2 >= 0)
      var_11 = var_4.spawn_module_lmg_2;
    else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_obit_model >= 0)
      var_11 = var_4.spawn_obit_model;
    else {
      var_11 = var_7.is_two_hit_melee_weapon;

      if(isDefined(var_4.is_two_hit_melee_weapon[var_6]) && isDefined(var_4.is_two_hit_melee_weapon[var_6][var_5]))
        var_11 = var_4.is_two_hit_melee_weapon[var_6][var_5];
    }

    if(var_11 > 0 && var_3 >= var_11) {
      var_0.isairlockdoor[var_1] = 0;

      if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_5 >= 0)
        var_0.isairlockdoor[var_1] = var_4.spawn_module_lmg_5;
      else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_origin >= 0)
        var_0.isairlockdoor[var_1] = var_4.spawn_origin;
      else {
        var_0.isairlockdoor[var_1] = var_7.isakimbo;

        if(isDefined(var_4.isakimbo[var_6]) && isDefined(var_4.isakimbo[var_6][var_5]))
          var_0.isairlockdoor[var_1] = var_4.isakimbo[var_6][var_5];
      }

      if(var_0.isairlockdoor[var_1] > 0) {
        if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_soldiers1 >= 0)
          var_0._id_133C1[var_1] = var_4.spawn_module_soldiers1 > 0;
        else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_paratrooper_ac130 >= 0)
          var_0._id_133C1[var_1] = var_4.spawn_paratrooper_ac130 > 0;
        else {
          var_0._id_133C1[var_1] = var_7._id_133C4;

          if(isDefined(var_4._id_133C4[var_6]) && isDefined(var_4._id_133C4[var_6][var_5]))
            var_0._id_133C1[var_1] = var_4._id_133C4[var_6][var_5];
        }

        return;
      }
    }

    var_11 = undefined;

    if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_4 >= 0)
      var_11 = var_4.spawn_module_lmg_4;
    else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_objective >= 0)
      var_11 = var_4.spawn_objective;
    else {
      var_11 = var_7.is_valid_station_name;

      if(isDefined(var_4.is_valid_station_name[var_6]) && isDefined(var_4.is_valid_station_name[var_6][var_5]))
        var_11 = var_4.is_valid_station_name[var_6][var_5];
    }

    if(var_11 > 0 && var_3 >= var_11) {
      var_0.isairlockdoor[var_1] = 0;

      if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_b >= 0)
        var_0.isairlockdoor[var_1] = var_4.spawn_module_p3_form_b;
      else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_final_tank >= 0)
        var_0.isairlockdoor[var_1] = var_4.spawn_overwatch_final_tank;
      else {
        var_0.isairlockdoor[var_1] = var_7.isallowedweapon;

        if(isDefined(var_4.isallowedweapon[var_6]) && isDefined(var_4.isallowedweapon[var_6][var_5]))
          var_12 = var_4.isallowedweapon[var_6][var_5];
      }

      if(var_0.isairlockdoor[var_1] > 0) {
        if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_new_digits >= 0)
          var_0._id_133C1[var_1] = var_4.spawn_new_digits > 0;
        else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_pavelow_boss >= 0)
          var_0._id_133C1[var_1] = var_4.spawn_pavelow_boss > 0;
        else {
          var_0._id_133C1[var_1] = var_7._id_133C6;

          if(isDefined(var_4._id_133C6[var_6]) && isDefined(var_4._id_133C6[var_6][var_5]))
            var_0._id_133C1[var_1] = var_4._id_133C6[var_6][var_5];
        }

        return;
      }
    }

    var_11 = undefined;

    if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_3 >= 0)
      var_11 = var_4.spawn_module_lmg_3;
    else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_obit_struct >= 0)
      var_11 = var_4.spawn_obit_struct;
    else {
      var_11 = var_7.is_using_stealth_debug;

      if(isDefined(var_4.is_using_stealth_debug[var_6]) && isDefined(var_4.is_using_stealth_debug[var_6][var_5]))
        var_11 = var_4.is_using_stealth_debug[var_6][var_5];

      if(var_11 > 0 && var_3 >= var_11) {
        var_0.isairlockdoor[var_1] = 0;

        if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_a >= 0)
          var_0.isairlockdoor[var_1] = var_4.spawn_module_p3_form_a;
        else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_extra_atvs >= 0)
          var_0.isairlockdoor[var_1] = var_4.spawn_overwatch_extra_atvs;
        else {
          var_0.isairlockdoor[var_1] = var_7.isakimbomeleeweapon;

          if(isDefined(var_4.isakimbomeleeweapon[var_6]) && isDefined(var_4.isakimbomeleeweapon[var_6][var_5]))
            var_13 = var_4.isakimbomeleeweapon[var_6][var_5];
        }

        if(var_0.isairlockdoor[var_1] > 0) {
          if(var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_trickle >= 0)
            var_0._id_133C1[var_1] = var_4.spawn_module_trickle > 0;
          else if(var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_parking_guys >= 0)
            var_0._id_133C1[var_1] = var_4.spawn_parking_guys > 0;
          else {
            var_0._id_133C1[var_1] = var_7._id_133C5;

            if(isDefined(var_4._id_133C5[var_6]) && isDefined(var_4._id_133C5[var_6][var_5]))
              var_0._id_133C5[var_1] = var_4._id_133C5[var_6][var_5];
          }

          return;
        }
      }
    }
  }

  var_0.isairlockdoor[var_1] = 0;
  var_0._id_133C1[var_1] = 0;
}

_id_14119(var_0, var_1, var_2) {
  if(var_0.stack_patch_thread_root[var_1]) {
    return;
  }
  if(var_0.isairlockdoor[var_1] <= 0) {
    return;
  }
  var_3 = var_0.ent[var_1];
  var_4 = var_0.ent[var_2];

  if(getdvarint("_encstr_BE120A82720A982AA2459C93", 0) && var_3 _meth_87DC()) {
    return;
  }
  var_5 = var_3.maxhealth * var_0.isairlockdoor[var_1] / 100;
  var_6 = var_0.ent[var_1].health;

  if(var_0._id_133C1[var_1])
    var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);

  if(isDefined(var_3) && isDefined(var_4))
    var_3 dodamage(var_5, var_0.position[var_1], undefined, var_4, "_encstr_8D4E0A501FCB898912CB3FA3", var_4.objweapon);

  if(isDefined(var_3)) {
    if(var_0._id_133C1[var_1])
      var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);

    if(var_3.health < var_6)
      thread _id_14113(var_3, var_4, 1.5);
  }
}

_id_14113(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_14100))
    var_0._id_14100 = [];

  var_3 = var_1 getentitynumber();
  var_0._id_14100[var_3] = var_1;
  wait(var_2);

  if(isDefined(var_0) && isDefined(var_0._id_14100)) {
    var_0._id_14100[var_3] = undefined;

    if(var_0._id_14100.size == 0)
      var_0._id_14100 = undefined;
  }
}

_id_1410D(var_0, var_1, var_2) {
  if(!isDefined(var_0.stack_patch_thread_root))
    var_0.stack_patch_thread_root = [];

  if(var_0._id_12B4D < 100) {
    var_0.stack_patch_thread_root[var_1] = 1;
    return;
  }

  var_3 = var_0.ent[var_1];

  if(isDefined(var_3._id_14100) && isDefined(var_0.ent[var_2]) && isDefined(var_3._id_14100[var_0.ent[var_2] getentitynumber()])) {
    var_0.stack_patch_thread_root[var_1] = 1;
    return;
  }

  var_0.stack_patch_thread_root[var_1] = 0;
}

_id_14108() {
  _id_14109();
}

_id_14109() {
  var_0 = _id_1410E();
  var_0._id_11E02 = getdvarint("_encstr_A712179F481B073BAB53BEAD490102D381A87B4F81537C63EB", 0) > 0;
  var_0._id_11E01 = getdvarint("_encstr_8649156FEB1A7944EFF205889A43F52873478BEB9CC380", 0) > 0;
  var_0.spawn_module_p3_form_d = getdvarint("_encstr_B6BF0F239622A96C0AC3EFAFCB84389BDC", 0) > 0;
  var_0.spawn_module_lmg_1 = getdvarfloat("_encstr_99C11F224EE5F17EA150179F483C2F7BB1C82E9BAD6B8ABB2DF09FFB3813356279", -1);
  var_0.spawn_module_p3_form_c = getdvarfloat("_encstr_974D2073297E37D378892307A9395D5FA546FA9A115DBBCA2BCD391361D822EF4099", -1);
  var_0.spawn_module_lmg_3 = getdvarint("_encstr_913F1F23FE0337DB8B7834DA4089D5CF7B48BCA901890F27E5580A637015C50773", -1);
  var_0.spawn_module_lmg_4 = getdvarint("_encstr_B1C62256933B1E15A7821168DA34EF539B0755C7E51F410B47FA18B8C2D2F32933A96549", -1);
  var_0.spawn_module_lmg_2 = getdvarint("_encstr_84692082CF8BCF9BD571FEC7EAB18707D329BF31187BE4018DEFCBED4572837B1714", -1);
  var_0.spawn_module_p3_form_a = getdvarint("_encstr_B83E204A025BA840B52B96E743A43FD3BD11A17FF070687B79751D1BA9D0A1BC70F0", -1);
  var_0.spawn_module_p3_form_b = getdvarint("_encstr_878F23272FDE1196F0D81E1D30F1C7ABB53FE3E78B8F5A7D81414A6609F8048085D15F0F63", -1);
  var_0.spawn_module_lmg_5 = getdvarint("_encstr_97A22137B127FAB3958668B736217BE63AF591585BB09DCA822B391B959BE824A57643", -1);
  var_0.spawn_module_trickle = getdvarint("_encstr_8D761FA3DFF2894402B33E60F8C9D5EF6C598BD8D170F6EBEEF88D28FF10892273", -1);
  var_0.spawn_new_digits = getdvarint("_encstr_9BA822CD3693D7D9CA340DB78D42DE37A37D6E6D2DE0245D39B9117B77DC9ACA32D2AEB6", -1);
  var_0.spawn_module_soldiers1 = getdvarint("_encstr_B15520AFC76BE0E03D440D806DC8F02EE3CF270747F326B042DDD59853C6816B8ABB", -1);
  var_0.spawn_para_and_heli_logic = getdvarint("_encstr_9B64159B2F78392B45F030FA983B97EAE0FD091369D8FD", 0) > 0;
  var_0.spawn_new_ents = getdvarfloat("_encstr_8E12256B32CB5048AF986F3FB4DCB80E7BF9A0112BFFF1C9467C191BA37CB9DFDF73F8BBD40FBD", -1);
  var_0.spawn_overwatch_soldiers_01 = getdvarfloat("_encstr_BE16269B1B4EBE3B2B8686DBB190DB6E8EB2A5B1D1B4B5D74656992B9B6E593258368E7B27A6DE91", -1);
  var_0.spawn_obit_struct = getdvarint("_encstr_A9F1256E8D4EEBCE2BD086BDB109EDE6E859B4B14796DAD73285B5B09DB2640BB1E8DEE498DE77", -1);
  var_0.spawn_objective = getdvarint("_encstr_854E282646BB275BF52B997BC320B0B703A393A61B623B26DC27E078C725EDCBDAD318B63D1AE128950F", -1);
  var_0.spawn_obit_model = getdvarint("_encstr_B6B426CD3693BE3B59D01ADB8D42ED9B3ACAD2C647B4D6BE91B05B2CCE2B23B06CE8DE9309D2CED0", -1);
  var_0.spawn_overwatch_extra_atvs = getdvarint("_encstr_8B79260642633F3D4BF3E38863D8EFBB14ED0B97A0DBAD4FBF69E847696DC1D542EB830BF3C5C80F", -1);
  var_0.spawn_overwatch_final_tank = getdvarint("_encstr_BE8F29A226EB30E5F243834D05241873D36BF2E7501AA586C23888112F1A5A5F5B2AA840D8E943721840EB", -1);
  var_0.spawn_origin = getdvarint("_encstr_A11427E66C39BECEB2A11ABD63247BDCD1CA4BC6D14BD6F5190BB6853B5628569CD895373A122D3B34", -1);
  var_0.spawn_parking_guys = getdvarint("_encstr_AA43252B71265FBB2BE17B2F911185A74D4F02923B736F3998CF5938E5D00A0BEDED7BCAC4D84F", -1);
  var_0.spawn_pavelow_boss = getdvarint("_encstr_9BA428F8EF12B6B50254E6882DA8FF7B7CA3A0C01BD1082F4BBCFB0F8E530DCDF42FC8200775611BF325", -1);
  var_0.spawn_paratrooper_ac130 = getdvarint("_encstr_B66C266EC64EBED9AC0D0DB7B184BD6E3A95B4D81D96B5F56E5B960E12AB9CE644DE77B984A5D90D", -1);
}

_id_14115() {
  var_0 = _id_1410E();
  var_1 = spawnStruct();
  var_0.challengeevaluator = [];
  var_0.keycardlocs_chosen = [];
  var_0.is_using_stealth_debug = [];
  var_0.is_valid_station_name = [];
  var_0.is_two_hit_melee_weapon = [];
  var_0.isakimbomeleeweapon = [];
  var_0.isallowedweapon = [];
  var_0.isakimbo = [];
  var_0._id_133C5 = [];
  var_0._id_133C6 = [];
  var_0._id_133C4 = [];
  var_2 = [];
  var_3 = [];
  var_3["_encstr_AA5810F39B28280ECFC8F210AB80BB498FA9"] = [];
  var_3["_encstr_965D11C856332BDCDC5923B08DD1F6C9A67B19"] = [];
  var_3["_encstr_BAC1107FE66B494752EFC11A138542804017"] = [];
  var_3["_encstr_8DBC13C82CD6C2EC5632B01B1DF6C9A656195AEAB6"] = [];
  var_3["_encstr_A56211C8856B58CE56641636D1DE9309A5EC43"] = [];
  var_3["_encstr_BD0111BC677857170341EA93B06B0D5BF4D817"] = [];
  var_3["_encstr_8A8514F1596D389CBF21B15B3A97C0488DB50963D5D5"] = [];
  var_3["_encstr_8431128DA177E90797D1F070DAAFDD833B418473"] = [];
  var_3["_encstr_8C0110E65BD23809EA39B922B7EE7313DBEE"] = [];
  var_3["_encstr_AF7113F632DA91DE68A54D7890F308F3815D1BA312"] = [];
  var_3["_encstr_B1FF117BCC71983E73E3EDB1FF3B602119A780"] = [];
  var_4 = tablelookupgetnumcols("_encstr_BE692091B7AFD9A8D77661107080F917668FB4B8619AAC87CD8CF65EFB69981E3065");

  for(var_5 = 1; var_5 < var_4; var_5++) {
    var_6 = tablelookupbyrow("_encstr_BE692091B7AFD9A8D77661107080F917668FB4B8619AAC87CD8CF65EFB69981E3065", 0, var_5);

    if(isDefined(var_6) && var_6 != "_encstr_B40101") {
      if(getsubstr(var_6, 0, 1) != "_encstr_8E4C028A")
        var_2[var_6] = var_5;
    }
  }

  var_7 = undefined;
  var_8 = 0;
  var_9 = tablelookupgetnumrows("_encstr_BE692091B7AFD9A8D77661107080F917668FB4B8619AAC87CD8CF65EFB69981E3065");

  for(var_8 = 0; var_8 < var_9; var_8++) {
    var_10 = tablelookupbyrow("_encstr_BE692091B7AFD9A8D77661107080F917668FB4B8619AAC87CD8CF65EFB69981E3065", var_8, 1);

    if(isDefined(var_10) && var_10 != "_encstr_B40101") {
      if(getsubstr(var_10, 0, 1) == "_encstr_8E4C028A") {
        var_7 = getsubstr(var_10, 1, var_10.size);
        continue;
      }

      if(isDefined(var_3[var_7]))
        var_3[var_7][var_10] = var_8;
    }
  }

  foreach(var_7, var_12 in var_3) {
    foreach(var_10, var_14 in var_12) {
      foreach(var_6, var_16 in var_2) {
        var_17 = tablelookup("_encstr_BE692091B7AFD9A8D77661107080F917668FB4B8619AAC87CD8CF65EFB69981E3065", 0, var_14, var_16);

        if(isDefined(var_17) && var_17 != "_encstr_B40101")
          _id_14116(var_17, var_10, var_7, var_6);
      }
    }
  }
}

_id_14116(var_0, var_1, var_2, var_3) {
  var_4 = _id_1410E();

  if(var_2 == "_encstr_AA5810F39B28280ECFC8F210AB80BB498FA9") {
    var_5 = float(var_0);

    if(!isDefined(var_4.challengeevaluator[var_1]))
      var_4.challengeevaluator[var_1] = [];

    var_4.challengeevaluator[var_1][var_3] = var_5;
  } else if(var_2 == "_encstr_965D11C856332BDCDC5923B08DD1F6C9A67B19") {
    var_5 = float(var_0);

    if(!isDefined(var_4.keycardlocs_chosen[var_1]))
      var_4.keycardlocs_chosen[var_1] = [];

    var_4.keycardlocs_chosen[var_1][var_3] = var_5;
  } else if(var_2 == "_encstr_BAC1107FE66B494752EFC11A138542804017") {
    var_5 = int(var_0);

    if(!isDefined(var_4.is_using_stealth_debug[var_1]))
      var_4.is_using_stealth_debug[var_1] = [];

    var_4.is_using_stealth_debug[var_1][var_3] = var_5;
  } else if(var_2 == "_encstr_8DBC13C82CD6C2EC5632B01B1DF6C9A656195AEAB6") {
    var_5 = int(var_0);

    if(!isDefined(var_4.is_valid_station_name[var_1]))
      var_4.is_valid_station_name[var_1] = [];

    var_4.is_valid_station_name[var_1][var_3] = var_5;
  } else if(var_2 == "_encstr_A56211C8856B58CE56641636D1DE9309A5EC43") {
    var_5 = int(var_0);

    if(!isDefined(var_4.is_two_hit_melee_weapon[var_1]))
      var_4.is_two_hit_melee_weapon[var_1] = [];

    var_4.is_two_hit_melee_weapon[var_1][var_3] = var_5;
  } else if(var_2 == "_encstr_BD0111BC677857170341EA93B06B0D5BF4D817") {
    var_5 = int(var_0);

    if(!isDefined(var_4.isakimbomeleeweapon[var_1]))
      var_4.isakimbomeleeweapon[var_1] = [];

    var_4.isakimbomeleeweapon[var_1][var_3] = var_5;
  } else if(var_2 == "_encstr_8A8514F1596D389CBF21B15B3A97C0488DB50963D5D5") {
    var_5 = int(var_0);

    if(!isDefined(var_4.isallowedweapon[var_1]))
      var_4.isallowedweapon[var_1] = [];

    var_4.isallowedweapon[var_1][var_3] = var_5;
  } else if(var_2 == "_encstr_8431128DA177E90797D1F070DAAFDD833B418473") {
    var_5 = int(var_0);

    if(!isDefined(var_4.isakimbo[var_1]))
      var_4.isakimbo[var_1] = [];

    var_4.isakimbo[var_1][var_3] = var_5;
  } else if(var_2 == "_encstr_8C0110E65BD23809EA39B922B7EE7313DBEE") {
    var_5 = int(var_0);

    if(!isDefined(var_4._id_133C5[var_1]))
      var_4._id_133C5[var_1] = [];

    var_4._id_133C5[var_1][var_3] = var_5 > 0;
  } else if(var_2 == "_encstr_AF7113F632DA91DE68A54D7890F308F3815D1BA312") {
    var_5 = int(var_0);

    if(!isDefined(var_4._id_133C6[var_1]))
      var_4._id_133C6[var_1] = [];

    var_4._id_133C6[var_1][var_3] = var_5 > 0;
  } else if(var_2 == "_encstr_B1FF117BCC71983E73E3EDB1FF3B602119A780") {
    var_5 = int(var_0);

    if(!isDefined(var_4._id_133C4[var_1]))
      var_4._id_133C4[var_1] = [];

    var_4._id_133C4[var_1][var_3] = var_5 > 0;
  }
}