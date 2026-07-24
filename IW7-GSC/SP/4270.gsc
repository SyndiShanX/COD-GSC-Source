/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4270.gsc
**************************************/

_id_A0AB() {
  precachemodel("veh_mil_air_un_retribution_ftl_a");
  precachemodel("veh_mil_air_un_retribution_ftl_a_r");
  precachemodel("veh_mil_air_un_retribution_ftl_b");
  precachemodel("veh_mil_air_un_retribution_ftl_b_r");
  precachemodel("ship_exterior_un_cannon_b_rig");
}

_id_9637() {
  scripts\engine\utility::flag_init("intro_start");
  scripts\engine\utility::flag_init("intro_hold_on_black_done");
  scripts\engine\utility::flag_init("intro_done");
  scripts\engine\utility::flag_init("jackal_objectives_can_display");
  scripts\engine\utility::flag_init("jackal_assault_vo_playing");
  scripts\engine\utility::flag_init("jackal_assault_vo_playing_important");
  level._id_A3AB = 0;
  level._id_A3AA = 0;
  level._id_A3A9 = 0;
  setomnvar("ui_jackal_objective_bits", 0);
  var_0 = getEntArray("ja_lights", "targetname");
  _id_0BDC::_id_16FF(var_0);
  give_player_default_weapon();
  thread _id_10B0::_id_114F5();
  thread _id_F2D3(_id_10AF::_id_A042);
}

give_player_default_weapon() {
  precacheitem("iw7_gunless");
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
}

_id_F2D3(var_0) {
  level notify("jackal_assault_new_autosave_func");
  level endon("jackal_assault_new_autosave_func");
  level.player endon("death");
  childthread[[var_0]]();
}

_id_9638() {
  _id_0B53::_id_B908("veh_mil_air_ca_destroyer", "sp/model_damage_tables/veh_mil_air_ca_destroyer_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_destroyer_fx.csv");
}

_id_A043(var_0) {
  thread _id_10AF::_id_A047();

  if(!isDefined(var_0)) {
    level._effect["vfx_sunflare"] = loadfx("vfx/iw7/levels/pearl_harbor/vfx_ph_launch_sunfx.vfx");
    playFXOnTag(scripts\engine\utility::getfx("vfx_sunflare"), level._id_111D0, "tag_origin");
  } else
    playFXOnTag(scripts\engine\utility::getfx(var_0), level._id_111D0, "tag_origin");
}

_id_104D0(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  var_4 = undefined;
  var_5 = [];

  foreach(var_8, var_7 in var_3) {
    var_5[var_8] = spawnfx(scripts\engine\utility::getfx(var_1), var_7.origin, anglesToForward(var_7.angles), anglestoup(var_7.angles));
    wait 0.05;
    triggerfx(var_5[var_8]);
  }

  if(isDefined(var_2)) {
    scripts\engine\utility::flag_wait(var_2);

    foreach(var_10 in var_5) {
      var_10 delete();
    }
  }
}

_id_D7C9() {
  setomnvar("ui_hide_hud", 1);
  level.player._id_A04E = scripts\sp\hud_util::_id_48B7("black", 1);
}

_id_57C4(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_clear("intro_start");
  scripts\engine\utility::flag_clear("intro_done");
  scripts\engine\utility::flag_clear("jackal_objectives_can_display");
  setomnvar("ui_hide_hud", 1);
  _id_0BDC::_id_A226(1);
  _id_0BDC::_id_A153(1);
  _id_0BDC::_id_A14A(1);
  _id_0BDC::_id_A15B(1);
  _id_0BDC::_id_A151(1);
  _id_0BDC::_id_A155(1);
  _id_0BDC::_id_A156(1);
  _id_0BDC::_id_A162(1);
  var_4 = 1.0;
  var_5 = 2.0;
  level.player freezecontrols(1);

  while(iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  level.player freezecontrols(0);
  scripts\engine\utility::flag_set("intro_start");

  if(isDefined(var_3)) {
    wait(var_3);
  }

  scripts\engine\utility::flag_set("intro_hold_on_black_done");
  scripts\engine\utility::delaythread(var_4, _id_10AF::_id_10A42, level.player._id_A04E, var_5);
  var_6 = getcsplineidarray(var_0);
  var_7 = getEnt("player_mover_jackal", "targetname");
  var_8 = var_7 scripts\sp\utility::_id_10808();
  var_8 hide();
  var_8 notsolid();
  var_8 _meth_8456((0, 0, 1));
  var_8 scripts\engine\utility::delaythread(0.05, _id_0BDC::_id_19AB, var_1);
  var_8 thread _id_0BDC::_id_A1EF(var_6[randomint(var_6.size)]);
  var_8 _id_0BDC::_id_6B4C("none");
  var_8 scripts\engine\utility::delaythread(0.15, _id_0BDC::_id_A167);
  var_8 scripts\engine\utility::delaythread(0.15, _id_0BDC::_id_105DA);
  _id_0BDC::_id_107A2();
  level._id_D299 thread _id_0BDC::_id_D2A7();
  level._id_D299 thread _id_0BDC::_id_D2A0(var_8, (2400, 0, 0));
  _id_0BDC::_id_D164(level._id_D299._id_BCDA, 0.0);
  level._id_D299 thread _id_0BDC::_id_D29B(1, 0);
  var_8 setneargoalnotifydist(256);

  if(isDefined(var_2)) {
    var_9 = 0.75;
    wait(var_2 - var_9);
    _id_0BDC::_id_A153(0);
    _id_0BDC::_id_A14A(0);
    _id_0BDC::_id_A15B(0);
    _id_0BDC::_id_A151(0);
    _id_0BDC::_id_A155(0);
    _id_0BDC::_id_A156(0);
    _id_0BDC::_id_A162(0);
    wait(var_9);
  } else {
    var_8 waittill("end_spline");
    _id_0BDC::_id_A153(0);
    _id_0BDC::_id_A14A(0);
    _id_0BDC::_id_A15B(0);
    _id_0BDC::_id_A151(0);
    _id_0BDC::_id_A155(0);
    _id_0BDC::_id_A156(0);
    _id_0BDC::_id_A162(0);
  }

  var_10 = 1.0;
  thread _id_0BDC::_id_D190(var_10);
  _id_0BDC::_id_A228();
  thread scripts\engine\utility::flag_set_delayed("jackal_objectives_can_display", 0.25);
  wait(var_10);
  var_8 delete();
  scripts\engine\utility::flag_set("intro_done");
  _id_0BDC::_id_A1A9(0);
  _id_0BD6::_id_621A();
  thread intro_preload_autosave();
}

intro_preload_autosave() {
  scripts\sp\utility::_id_266F(0);
  wait 2;

  if(!getdvarint("ja_skip_preload")) {
    level thread scripts\sp\utility::_id_BF97();
  }
}

_id_5796() {
  _id_0BDC::_id_A226();
  var_0 = 1.0;
  var_1 = 2.0;
  var_2 = scripts\sp\hud_util::_id_48B7("black", 1);
  scripts\engine\utility::delaythread(var_0, _id_10AF::_id_10A42, var_2, var_1);
  _id_0BDC::_id_A0BE(1);
  var_3 = 3.0;
  scripts\engine\utility::delaythread(var_3 - 1.0, _id_0BDC::_id_A228);
  scripts\engine\utility::flag_set_delayed("jackal_objectives_can_display", var_3 - 0.75);
  wait(var_3);
  _id_0BDC::_id_A0BE(0);
  level thread scripts\sp\utility::_id_BF97();
}

_id_579D(var_0, var_1, var_2, var_3) {
  var_4 = "returnToRet";
  level._id_A3A8[var_4] = spawnStruct();
  level._id_A3A8[var_4]._id_C288 = level._id_A3AA;
  level._id_A3AA++;
  objective_add(scripts\sp\utility::_id_C264(level._id_A3A8[var_4]._id_C288), "invisible");
  thread _id_56B3(var_4, "jackal_objective_return_to_ret", 0, &"JACKAL_OBJECTIVE_RETURN_TO_RET_MENU");
  _id_10AF::_id_A7BD(var_4, var_0, var_1, var_2, var_3);
  level waittill("never");
}

_id_56B3(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  level._id_A3A8[var_0]._id_C27F = level._id_A3A9;
  level._id_A3A9++;
  var_4 = level._id_A3A8[var_0]._id_C288;
  objective_add(scripts\sp\utility::_id_C264(var_4), "invisible");
  _func_2E9(scripts\sp\utility::_id_C264(var_4), 1);

  if(isDefined(var_3)) {
    objective_string_nomessage(scripts\sp\utility::_id_C264(var_4), var_3);
    objective_additionalcurrent(scripts\sp\utility::_id_C264(var_4));
  }

  if(scripts\engine\utility::flag_exist("jackal_objectives_can_display")) {
    while(!scripts\engine\utility::flag("jackal_objectives_can_display")) {
      wait 0.05;
    }
  }

  if(isDefined(var_2) && var_2) {
    _id_0B76::_id_16FE(level._id_A3A8[var_0]._id_C27F, var_1, level._id_A3A8[var_0]._id_A683);
    thread _id_10AF::_id_56B4(var_0);
  } else
    _id_0B76::_id_16FE(level._id_A3A8[var_0]._id_C27F, var_1);
}

_id_8E7F(var_0) {
  _id_0B76::_id_8E93(level._id_A3A8[var_0]._id_C27F);
}

_id_F396(var_0, var_1) {
  level.player endon("death");

  while(!scripts\engine\utility::flag("jackal_objectives_can_display")) {
    wait 0.05;
  }

  _id_0B76::_id_F433(level._id_A3A8[var_0]._id_C27F, var_1);
}

_id_C2A0(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 1200);
  }

  if(!isDefined(var_2)) {
    var_2 = " ";
  }

  objective_setpointertextoverride(scripts\sp\utility::_id_C264(level._id_A3A8[var_0]._id_C288), var_2);

  if(isDefined(level._id_A3A8[var_0]._id_FE2D)) {
    for(var_3 = 0; var_3 < level._id_A3A8[var_0]._id_FE2D.size; var_3++) {
      if(var_3 >= 8) {
        break;
      }

      objective_additionalentity(scripts\sp\utility::_id_C264(level._id_A3A8[var_0]._id_C288), var_3, level._id_A3A8[var_0]._id_FE2D[var_3], var_1);
      level._id_A3A8[var_0]._id_FE2D[var_3] thread _id_C29F(var_0, var_3);
    }
  }
}

_id_C29F(var_0, var_1) {
  self waittill("death");
  objective_additionalposition(scripts\sp\utility::_id_C264(level._id_A3A8[var_0]._id_C288), var_1, (0, 0, 0));
}

_id_57AC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.player endon("death");
  level.player endon(var_0 + "force_event_complete");
  _id_10AF::_id_96A4(var_0, var_4);

  if(isDefined(var_6)) {
    thread _id_CE80(var_6);
  }

  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_4469 = 0;
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0].kills = 0;
  level._id_A3A8[var_0]._id_A683 = var_4;
  level._id_A3A8[var_0]._id_4B24 = var_2;
  level._id_A3A8[var_0]._id_B496 = var_2;
  level._id_A3A8[var_0]._id_B776 = var_3;
  level._id_A3A8[var_0]._id_10879 = var_1;
  level._id_A3A8[var_0]._id_A671 = var_5;
  level._id_A3A8[var_0]._id_C288 = _id_10AF::_id_F9ED();
  level._id_A3A8[var_0]._id_1354E = _id_10B0::_id_1350D;
  level._id_A3A8[var_0]._id_1354F = _id_10B0::_id_1350D;

  if(isDefined(var_7)) {
    level._id_A3A8[var_0]._id_13522 = var_7;
  }

  var_8 = 1;

  if(scripts\engine\utility::flag("intro_done")) {
    var_8 = 0;
  }

  level._id_A3A8[var_0] thread _id_10AF::_id_B2E1(var_0, var_8);
  scripts\engine\utility::flag_set(var_0 + "start");

  for(var_9 = var_4; var_9 > 0; var_9--) {
    while(level._id_A3A8[var_0]._id_A683 - level._id_A3A8[var_0].kills >= var_9) {
      wait 0.05;
    }

    if(var_9 > 1) {
      scripts\engine\utility::flag_set(var_0 + (var_9 - 1) + "_left");
    }

    level notify("player_killed_enemy");
    level notify("player_killed_enemyskelter");
  }

  _id_10AF::_id_4478(var_0, "skelter");
}

_id_57AA(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("death");
  level.player endon(var_0 + "force_event_complete");
  var_5 = getEntArray(var_1, "targetname");

  if(!isDefined(var_2)) {
    var_2 = var_5.size;

    foreach(var_7 in var_5) {
      if(isDefined(var_7._id_EEC4)) {
        var_8 = getEntArray(var_7._id_EEC4, "targetname");
        var_2 = var_2 + var_8.size;
      }
    }
  }

  if(isDefined(var_3)) {
    thread _id_CE80(var_3);
  }

  _id_10AF::_id_96A4(var_0, var_2);
  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_4469 = 0;
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0]._id_10879 = var_1;
  level._id_A3A8[var_0]._id_A683 = var_2;
  level._id_A3A8[var_0]._id_C224 = var_2;
  level._id_A3A8[var_0]._id_10854 = 0;
  level._id_A3A8[var_0]._id_C288 = _id_10AF::_id_F9ED();
  level._id_A3A8[var_0]._id_1354E = _id_10B0::_id_1350D;
  level._id_A3A8[var_0]._id_1354F = _id_10B0::_id_1350D;

  if(isDefined(var_4)) {
    level._id_A3A8[var_0]._id_13522 = var_4;
  }

  var_10 = 0;
  level._id_A3A8[var_0]._id_FE2D = [];

  foreach(var_7 in var_5) {
    var_7 scripts\sp\utility::_id_1747(_id_10AF::_id_1022E, var_0);
    var_7 thread scripts\sp\utility::_id_10808();
    var_10 = var_10 + 1;

    if(isDefined(var_7._id_EEC4)) {
      var_8 = getEntArray(var_7._id_EEC4, "targetname");
      var_10 = var_10 + var_8.size;
    }

    if(var_10 >= var_2) {
      break;
    }
  }

  while(level._id_A3A8[var_0]._id_10854 < var_2) {
    wait 0.05;
  }

  _id_10AF::_id_11AAC(var_0, "skelter");
}

_id_57AB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  level.player endon("death");
  level.player endon(var_0 + "force_event_complete");
  var_11 = getEntArray(var_1, "targetname");

  if(!isDefined(var_3)) {
    var_3 = var_11.size;

    foreach(var_13 in var_11) {
      if(isDefined(var_13._id_EEC4)) {
        var_14 = getEntArray(var_13._id_EEC4, "targetname");
        var_3 = var_3 + var_14.size;
      }
    }
  }

  if(isDefined(var_9)) {
    thread _id_CE80(var_9);
  }

  _id_10AF::_id_96A4(var_0, var_7);
  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_4469 = 0;
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0].kills = 0;
  level._id_A3A8[var_0]._id_A683 = var_7;
  level._id_A3A8[var_0]._id_4B24 = var_5;
  level._id_A3A8[var_0]._id_B496 = var_5;
  level._id_A3A8[var_0]._id_B776 = var_6;
  level._id_A3A8[var_0]._id_10879 = var_2;
  level._id_A3A8[var_0]._id_A671 = var_8;
  level._id_A3A8[var_0]._id_10854 = 0;
  level._id_A3A8[var_0]._id_C288 = _id_10AF::_id_F9ED();
  level._id_A3A8[var_0]._id_1354E = _id_10B0::_id_1350D;
  level._id_A3A8[var_0]._id_1354E = _id_10B0::_id_1350D;
  level._id_A3A8[var_0]._id_1354F = _id_10B0::_id_1350D;

  if(isDefined(var_10)) {
    level._id_A3A8[var_0]._id_13522 = var_10;
  }

  var_16 = 0;
  level._id_A3A8[var_0]._id_FE2D = [];

  foreach(var_13 in var_11) {
    var_13 scripts\sp\utility::_id_1747(_id_10AF::_id_1022D, var_0);
    var_13 thread scripts\sp\utility::_id_10808();
    var_16 = var_16 + 1;

    if(isDefined(var_13._id_EEC4)) {
      var_14 = getEntArray(var_13._id_EEC4, "targetname");
      var_16 = var_16 + var_14.size;
    }

    if(var_16 >= var_3) {
      break;
    }
  }

  while(level._id_A3A8[var_0]._id_10854 < var_3) {
    wait 0.05;
  }

  wait(var_4);
  level._id_A3A8[var_0]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE2D);
  scripts\sp\utility::_id_22A4(level._id_A3A8[var_0]._id_FE2D, "constant_start");
  level._id_A3A8[var_0] thread _id_10AF::_id_B2E1(var_0, 0);
  scripts\engine\utility::flag_set(var_0 + "start");

  for(var_19 = var_7; var_19 > 0; var_19--) {
    while(level._id_A3A8[var_0]._id_A683 - level._id_A3A8[var_0].kills >= var_19) {
      wait 0.05;
    }

    if(var_19 > 1) {
      scripts\engine\utility::flag_set(var_0 + (var_19 - 1) + "_left");
    }

    level notify("player_killed_enemy");
    level notify("player_killed_enemyskelter");
  }

  for(;;) {
    level._id_A3A8[var_0]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8[var_0]._id_FE2D);

    if(level._id_A3A8[var_0]._id_FE2D.size == 0) {
      break;
    }

    wait 0.1;
  }

  _id_10AF::_id_4478(var_0, "skelter");
}

_id_57A7(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("death");
  level.player endon(var_0 + "force_event_complete");
  var_5 = getEntArray(var_1, "targetname");

  if(!isDefined(var_2)) {
    var_2 = var_5.size;
  }

  if(isDefined(var_3)) {
    thread _id_CE80(var_3);
  }

  _id_10AF::_id_96A4(var_0, var_2);
  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_4469 = 0;
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0]._id_10879 = var_1;
  level._id_A3A8[var_0]._id_A683 = var_2;
  level._id_A3A8[var_0]._id_C224 = var_2;
  level._id_A3A8[var_0]._id_C288 = _id_10AF::_id_F9ED();
  level._id_A3A8[var_0]._id_1354E = _id_10B0::_id_134B1;
  level._id_A3A8[var_0]._id_1354F = _id_10B0::_id_134B0;

  if(isDefined(var_4)) {
    level._id_A3A8[var_0]._id_13522 = var_4;
  }

  level._id_A3A8[var_0]._id_FE2D = [];

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_5[var_6] scripts\sp\utility::_id_10808();
    var_7 thread _id_10AF::_id_A123(1);
    level._id_A3A8[var_0]._id_FE2D[level._id_A3A8[var_0]._id_FE2D.size] = var_7;
  }

  _id_10AF::_id_11AAC(var_0, "ace");
}

_id_1700(var_0, var_1) {
  foreach(var_3 in var_0) {
    _id_10AF::_id_67E7(var_3, var_1, 0, 1);
  }
}

_id_57A8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.player endon("death");
  level.player endon(var_0 + "force_event_complete");
  var_8 = getEntArray(var_1, "targetname");

  if(!isDefined(var_2)) {
    var_2 = var_8.size;
  }

  if(isDefined(var_3)) {
    thread _id_CE80(var_3);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  _id_10AF::_id_96A4(var_0, var_2);
  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_4469 = 0;
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0]._id_10879 = var_1;
  level._id_A3A8[var_0]._id_A683 = var_2;
  level._id_A3A8[var_0]._id_C224 = var_2;
  level._id_A3A8[var_0]._id_C288 = _id_10AF::_id_F9ED();
  level._id_A3A8[var_0]._id_1354E = _id_10B0::_id_134C9;
  level._id_A3A8[var_0]._id_1354F = _id_10B0::_id_134C8;

  if(isDefined(var_4)) {
    level._id_A3A8[var_0]._id_13522 = var_4;
  }

  level._id_A3A8[var_0]._id_FE2D = [];
  var_9 = 0.0;

  for(var_10 = 0; var_10 < var_2; var_10++) {
    if(var_5) {
      var_11 = var_8[var_10] _id_0BB8::_id_398F(var_9, var_7);
      var_11 thread _id_10AF::_id_F031(1);
      var_11._id_B904 = "veh_mil_air_ca_destroyer";
      var_11 thread _id_0B53::_id_B909();
      var_9 = var_9 + randomfloatrange(0.25, 0.6);
    } else {
      var_11 = var_8[var_10] scripts\sp\utility::_id_10808();
      var_11 thread _id_10AF::_id_F031();
      var_11._id_B904 = "veh_mil_air_ca_destroyer";
      var_11 thread _id_0B53::_id_B909();
    }

    level._id_A3A8[var_0]._id_FE2D[level._id_A3A8[var_0]._id_FE2D.size] = var_11;
  }

  _id_10AF::_id_11AAC(var_0, "destroyer");
}

_id_57A9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("death");
  level.player endon(var_0 + "force_event_complete");
  var_7 = getEntArray(var_1, "targetname");

  if(!isDefined(var_2)) {
    var_2 = var_7.size;
  }

  if(isDefined(var_3)) {
    thread _id_CE80(var_3);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  _id_10AF::_id_96A4(var_0, var_2);
  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_4469 = 0;
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0]._id_10879 = var_1;
  level._id_A3A8[var_0]._id_A683 = var_2;
  level._id_A3A8[var_0]._id_C224 = var_2;
  level._id_A3A8[var_0]._id_C288 = _id_10AF::_id_F9ED();
  level._id_A3A8[var_0]._id_1354E = _id_10B0::_id_134F0;
  level._id_A3A8[var_0]._id_1354F = _id_10B0::_id_134EF;

  if(isDefined(var_4)) {
    level._id_A3A8[var_0]._id_13522 = var_4;
  }

  level._id_A3A8[var_0]._id_FE2D = [];
  var_8 = 0.0;

  for(var_9 = 0; var_9 < var_2; var_9++) {
    if(var_5) {
      var_10 = var_7[var_9] _id_0BB1::_id_B870(var_8);
      var_10 thread _id_10AF::_id_F04C(1);
      var_8 = var_8 + randomfloatrange(0.25, 0.6);
    } else {
      var_10 = var_7[var_9] scripts\sp\utility::_id_10808();
      var_10 thread _id_10AF::_id_F04C();
    }

    level._id_A3A8[var_0]._id_FE2D[level._id_A3A8[var_0]._id_FE2D.size] = var_10;
  }

  _id_10AF::_id_11AAC(var_0, "missileboat");
}

_id_577D(var_0) {
  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_4469 = 0;
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0]._id_C288 = _id_10AF::_id_F9ED();
  scripts\engine\utility::flag_init(var_0 + "start");
  scripts\engine\utility::flag_set(var_0 + "start");
  scripts\engine\utility::flag_init(var_0 + "complete");
  scripts\engine\utility::flag_init(var_0 + "complete_vo_finished");
}

_id_7265(var_0) {
  level.player notify(var_0 + "force_event_complete");
  _id_10AF::_id_4478(var_0);
}

_id_5769(var_0, var_1, var_2) {
  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0]._id_B479 = var_2;
  level._id_A3A8[var_0]._id_10879 = var_1;
  level._id_A3A8[var_0] thread _id_10AF::_id_B2C6(var_0);
}

_id_5768(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_1, "targetname");

  if(!isDefined(var_2)) {
    var_2 = var_4.size;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  level._id_A3A8[var_0] = spawnStruct();
  level._id_A3A8[var_0]._id_68B1 = var_0;
  level._id_A3A8[var_0]._id_10879 = var_1;
  level._id_A3A8[var_0].jackals = spawnStruct();
  level._id_A3A8[var_0].jackals._id_FE2D = [];

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_6 = var_4[var_5] scripts\sp\utility::_id_10808();

    if(isDefined(var_6._id_EDB8) && var_6._id_EDB8 == "Salter") {
      var_6 _id_0BDC::_id_1998();
    }

    if(var_3) {
      var_6 thread _id_10AF::_id_A2A3(1);
    } else {
      var_6 thread _id_10AF::_id_A123(1);
    }

    level._id_A3A8[var_0].jackals._id_FE2D[level._id_A3A8[var_0].jackals._id_FE2D.size] = var_6;
  }
}

_id_B67B(var_0, var_1, var_2) {}

_id_52F4(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_0, "targetname");
  _id_52F3(var_4.origin, var_4.angles, var_1, var_2, var_3);
}

_id_52F3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = distance(self._id_BCDA.origin, var_0);
  var_6 = acos(vectordot(anglesToForward(self.angles), anglesToForward(var_1)));
  var_7 = var_6 * 144.0;

  if(var_7 > var_5) {
    var_5 = var_7;
  }

  var_8 = var_5 / var_2;
  var_9 = 0;
  var_10 = 0;

  if(isDefined(var_3) && var_3) {
    var_9 = var_8 * 0.25;
  }

  if(isDefined(var_4) && var_4) {
    var_10 = var_8 * 0.25;
  }

  self._id_BCDA moveTo(var_0, var_8, var_9, var_10);
  self._id_BCDA rotateTo(var_1, var_8, var_9, var_10);
  wait(var_8);
  self notify("fly_to_complete");
}

_id_530B(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  self._id_BCDA.origin = var_1.origin;
  self._id_BCDA.angles = var_1.angles;
}

_id_A1EE(var_0) {
  thread _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_0), 420);
  self waittill("end_spline");
  _id_10AF::_id_A123(0);
}

_id_A1F1(var_0) {
  thread _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_0), 420);
  self waittill("end_spline");
  _id_10AF::_id_A2A3(0);
}

_id_E3B6(var_0) {
  _id_0B51::_id_B8CA();
  var_1 = getEnt("retribution", "targetname");
  var_1._id_EEF9 = "missile_cluster_turret_un missile_tube_un cannon_small_un,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  level._id_E35D = var_1 scripts\sp\utility::_id_10808();
  level._id_E35D linkTo(level._id_FD6E._id_E35D, "tag_origin", (0, 0, 0), (0, 0, 0));
  level._id_E35D notsolid();
  level._id_FD6E._id_E35D hide();
  level._id_E35D _id_0BDC::_id_105DB("capitalship", "JACKAL_RETRIBUTION", "none", "none", 0);
  var_2 = 200;
  var_3 = 17500;
  var_4 = 0.25;
  var_5 = 0.75;
  var_6 = 13000;
  var_7 = 3000;
  var_8 = 1000;
  level._id_E35D _id_0BA9::_id_39D6(var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(var_0) && var_0) {
    level._id_E35D _id_E36F();
  }
}

_id_E3A7(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_5 = distance(level._id_FD6E._id_E35D.origin, var_4.origin);
  var_6 = var_5 / var_1;
  var_7 = 0;
  var_8 = 0;

  if(isDefined(var_2) && var_2) {
    var_7 = var_6 * 0.25;
  }

  if(isDefined(var_3) && var_3) {
    var_8 = var_6 * 0.25;
  }

  level._id_FD6E._id_E35D moveTo(var_4.origin, var_6, var_7, var_8);
  level._id_FD6E._id_E35D rotateTo(var_4.angles, var_6, var_7, var_8);
  wait(var_6);
}

_id_E3FA(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  level._id_FD6E._id_E35D.origin = var_1.origin;
  level._id_FD6E._id_E35D.angles = var_1.angles;
}

_id_E36F() {
  while(!isDefined(level._id_F033)) {
    wait 0.05;
  }

  while(!level._id_F033.size) {
    wait 0.05;
  }

  thread _id_0BB6::_id_39F0();
  _id_0BB6::_id_3966(1, 1, level._id_F033[0], level._id_F033[1], level._id_F033[2], level._id_F033[3]);
  _id_0BB6::_id_398A(1);
}

_id_E3F9() {
  level._id_E35D _id_0BB6::_id_398A(0);
}

_id_E3DD(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  thread _id_10AF::_id_E3DF(var_0);
  thread _id_10AF::_id_E3DE(var_0);
  var_3 = "missile_tube_un";
  level._id_39DD[var_3]._id_10241._id_6CF8 = _id_10AF::_id_6D0A;
  level._id_E35D thread _id_0BB6::_id_3983(var_0);
  level._id_E35D thread _id_0BB6::_id_3983(var_0);
  level._id_E35D thread _id_0BB6::_id_3983(var_0);
  level scripts\engine\utility::waittill_any("retribution_kill_destroyer_hit", "retribution_kill_destroyer_timeout");
  level._id_39DD[var_3]._id_10241._id_6CF8 = _id_0BB6::_id_6D0E;

  if(isDefined(var_0) && isalive(var_0)) {
    var_0 _id_10AF::_id_52EF(var_1, var_2);
  }
}

_id_E382(var_0) {
  level endon("stop_retribution_circling");
  thread _id_10AF::_id_E383();
  var_1 = scripts\engine\utility::getStruct("ret_pivot", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_3 = scripts\engine\utility::spawn_tag_origin(level._id_FD6E._id_E35D.origin, level._id_FD6E._id_E35D.angles);
  level._id_FD6E._id_E35D._id_E720 = 0.08;
  var_2.angles = (var_2.angles[0], level._id_FD6E._id_E35D.angles[1], var_2.angles[2]);
  var_3 linkTo(var_2);

  for(;;) {
    var_2.angles = (var_2.angles[0], var_2.angles[1] + level._id_FD6E._id_E35D._id_E720, var_2.angles[2]);
    level._id_FD6E._id_E35D.origin = var_3.origin;
    level._id_FD6E._id_E35D.angles = var_3.angles;
    wait 0.05;
  }
}

_id_E3F8() {
  level notify("stop_retribution_circling");
}

_id_BC18(var_0) {
  var_1 = level._id_D127 scripts\engine\utility::spawn_tag_origin();
  _id_0BDC::_id_D164(var_1, 0.0);
  _id_0BDC::_id_A151(1);
  _id_0BDC::_id_A15B(1);
  thread _id_BC19(var_0);
  thread _id_BC1A(var_0);
  thread _id_BC17(var_0);

  for(;;) {
    var_2 = level.player getnormalizedmovement();
    var_3 = anglestoright(var_0.angles);
    var_4 = anglesToForward(var_0.angles);
    var_5 = 300;
    var_0.origin = var_0.origin + var_2[1] * var_3 * var_5;
    var_0.origin = var_0.origin + var_2[0] * var_4 * var_5;
    wait 0.05;
  }
}

_id_BC19(var_0) {
  for(;;) {
    var_1 = 0;

    if(level.player buttonPressed("BUTTON_LSHLDR")) {
      var_1 = -100;
    } else if(level.player buttonPressed("BUTTON_RSHLDR")) {
      var_1 = 100;
    }

    var_2 = anglestoup(var_0.angles);
    var_0.origin = var_0.origin + var_2 * var_1;
    wait 0.05;
  }
}

_id_BC1A(var_0) {
  for(;;) {
    var_1 = 0;

    if(level.player buttonPressed("BUTTON_LTRIG")) {
      var_1 = -2;
    } else if(level.player buttonPressed("BUTTON_RTRIG")) {
      var_1 = 2;
    }

    var_0 addyaw(var_1);
    wait 0.05;
  }
}

_id_BC17(var_0) {
  for(;;) {
    var_1 = level.player _meth_814B();
    var_2 = 0;
    var_3 = 0;
    var_4 = 2;
    var_0 addroll(var_4 * var_1[1]);
    var_0 addpitch(var_4 * var_1[0]);
    wait 0.05;
  }
}

_id_6C7B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 15000;
  }

  if(!isDefined(var_3)) {
    var_3 = 25000;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.9;
  }

  var_5 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_5 = scripts\engine\utility::array_randomize(var_5);
  var_6 = _id_79DA();
  var_2 = var_2 * var_6;
  var_3 = var_3 * var_6;
  var_7 = var_2 * var_2;
  var_8 = var_3 * var_3;
  var_9 = var_2;
  var_10 = var_3 * 2.0;
  var_11 = var_9 * var_9;
  var_12 = var_10 * var_10;
  var_13 = 0.7;
  var_14 = [];
  var_15 = [];

  foreach(var_17 in var_5) {
    if(isDefined(var_17.used) && var_17.used) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_17);
    }

    var_18 = distancesquared(level._id_D127.origin, var_17.origin);

    if(var_17 _id_0BDC::_id_9C1B(var_4) && (var_18 > var_7 && var_18 < var_8)) {
      var_14[var_14.size] = var_17;

      if(var_14.size >= var_1) {
        break;
      }
    } else if(var_17 _id_0BDC::_id_9C1B(var_13))
      var_15[var_15.size] = var_17;
  }

  if(var_14.size >= var_1) {
    return var_14;
  }

  foreach(var_21 in var_15) {
    var_14[var_14.size] = var_21;

    if(var_14.size >= var_1) {
      return var_14;
    }
  }

  foreach(var_17 in var_5) {
    var_14[var_14.size] = var_17;

    if(var_14.size >= var_1) {
      return var_14;
    }
  }

  return var_14;
}

_id_79DA() {
  var_0 = level._id_D127.spaceship_vel;
  var_1 = vectorNormalize(var_0);
  var_2 = anglesToForward(level._id_D127.angles);
  var_3 = vectorNormalize(var_2);
  var_4 = length(var_0) * vectordot(var_1, var_3);
  var_5 = 1.0;
  var_6 = 2.0;
  var_7 = clamp(var_4 / 720.0 * (var_6 - var_5) + var_5, var_5, var_6);
  return var_7;
}

_id_CE80(var_0, var_1, var_2) {
  _id_10B0::_id_CE83(var_0, var_1, var_2);
}

_id_CE87(var_0, var_1, var_2) {
  _id_10B0::_id_CE88(var_0, var_1, var_2);
}

_id_CE84(var_0) {
  _id_10B0::_id_CE85(var_0);
}

_id_CE81(var_0) {
  _id_10B0::_id_CE82(var_0);
}

_id_1350F() {
  _id_10B0::_id_13510();
}

_id_134D1() {
  _id_10B0::_id_134D2();
}

_id_1C44() {
  level._id_A3A7 = 1;
}