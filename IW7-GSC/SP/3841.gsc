/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3841.gsc
**************************************/

_id_FCE0() {
  scripts\engine\utility::flag_init("flag_breach_wall_exterior_door_closed");
  scripts\engine\utility::flag_init("flag_breach_wall_compression_done");
  thread _id_FCEF();
}

_id_FCEF() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("breach_wall_button", "targetname");
  var_2 = getEntArray("breach_enemy_spawner", "targetname");
  var_3 = getEntArray("breach_wall_explosionguy", "targetname");
  var_4 = getEntArray("breach_solid", "targetname");
  var_5 = getEntArray("breach_door_volume", "targetname");
  var_6 = getEntArray("breach_wall_pristine", "targetname");
  var_7 = getEntArray("breach_wall_destroyed", "targetname");
  var_8 = getnodearray("breach_ally_node", "targetname");
  var_9 = scripts\engine\utility::getStructArray("sa_beacon_fx_struct", "targetname");
  var_10 = scripts\engine\utility::getStructArray("sa_vent_fx_struct", "targetname");

  foreach(var_12 in var_1) {
    var_13 = var_12._id_EEAC;
    var_12._id_6513 = [];
    var_12._id_69E4 = [];
    var_12._id_C962 = [];
    var_12._id_59FC = [];
    var_12._id_D955 = [];
    var_12._id_52D5 = [];
    var_12._id_1D16 = [];
    var_12._id_611E = [];
    var_12._id_6122 = [];
    var_0[var_13] = var_12;
  }

  foreach(var_16 in var_2) {
    var_13 = var_16._id_EEAC;
    var_0[var_13]._id_6513 = scripts\engine\utility::array_add(var_0[var_13]._id_6513, var_16);
  }

  foreach(var_19 in var_3) {
    var_13 = var_19._id_EEAC;
    var_0[var_13]._id_69E4 = scripts\engine\utility::array_add(var_0[var_13]._id_69E4, var_19);
  }

  foreach(var_22 in var_4) {
    var_13 = var_22._id_EEAC;
    var_0[var_13]._id_C962 = scripts\engine\utility::array_add(var_0[var_13]._id_C962, var_22);
  }

  foreach(var_25 in var_5) {
    var_13 = var_25._id_EEAC;
    var_0[var_13]._id_59FC = scripts\engine\utility::array_add(var_0[var_13]._id_59FC, var_25);
  }

  foreach(var_28 in var_6) {
    var_13 = var_28._id_EEAC;
    var_0[var_13]._id_D955 = scripts\engine\utility::array_add(var_0[var_13]._id_D955, var_28);
  }

  foreach(var_31 in var_7) {
    var_31 hide();
    var_31 notsolid();
    var_13 = var_31._id_EEAC;
    var_0[var_13]._id_52D5 = scripts\engine\utility::array_add(var_0[var_13]._id_52D5, var_31);
  }

  foreach(var_34 in var_8) {
    var_13 = var_34._id_EEAC;
    var_0[var_13]._id_1D16 = scripts\engine\utility::array_add(var_0[var_13]._id_1D16, var_34);
  }

  foreach(var_37 in var_9) {
    var_13 = var_37._id_EEAC;

    if(isDefined(var_13))
      var_0[var_13]._id_611E = scripts\engine\utility::array_add(var_0[var_13]._id_611E, var_37);
  }

  foreach(var_40 in var_10) {
    var_13 = var_40._id_EEAC;

    if(isDefined(var_13))
      var_0[var_13]._id_6122 = scripts\engine\utility::array_add(var_0[var_13]._id_6122, var_40);
  }

  scripts\engine\utility::array_thread(var_0, ::_id_FCDD);
}

_id_FCDD() {
  var_0 = self;

  for(;;) {
    var_0 _id_0E46::_id_48C4(undefined, (0, 0, 0), 0, undefined, 1024);
    var_1 = var_0 scripts\engine\utility::waittill_any_return("trigger", "breach_off");

    if(var_1 == "trigger") {
      break;
    } else {
      var_0 _id_0E46::_id_DFE3();
      var_0 waittill("breach_on");
    }
  }

  level.player _meth_80D1();
  level.player thread scripts\sp\utility::_id_CFB8();
  level notify("sa_breach_start");
  var_2 = var_0.script_parameters;

  switch (var_2) {
    case "z_to_z":
      var_0 thread _id_1471();
      break;
    case "g_to_g":
      var_0 thread _id_1471();
      break;
  }

  level waittill("breach_wall_explosion");
  var_0 thread _id_13BB();
  var_3 = 5.0;

  switch (var_2) {
    case "z_to_z":
      var_0 thread _id_146E();
      var_0 thread _id_1474(var_3);
      var_0 thread _id_1475(var_3);
      var_0 scripts\engine\utility::delaythread(0.5, ::_id_146F);
    case "g_to_g":
      var_0 thread _id_13BA();
      break;
  }

  level waittill("breach_wall_done");
  level notify("breach_into_corridor_done");
}

_id_FCDF(var_0) {
  var_1 = scripts\engine\utility::getStructArray("breach_wall_button", "targetname");

  foreach(var_3 in var_1) {
    if(var_3._id_EEAC == var_0) {
      var_3 notify("breach_on");
      break;
    }
  }
}

_id_FCDE(var_0) {
  var_1 = scripts\engine\utility::getStructArray("breach_wall_button", "targetname");

  foreach(var_3 in var_1) {
    if(var_3._id_EEAC == var_0) {
      var_3 notify("breach_off");
      break;
    }
  }
}

_id_13BA() {
  level.player endon("death");
  var_0 = self;
  wait 0.5;

  foreach(var_2 in var_0._id_6513)
  var_3 = var_2 thread scripts\sp\utility::_id_10619(1);
}

_id_146E() {
  level.player endon("death");
  var_0 = self;
  var_1 = [];

  foreach(var_3 in var_0._id_6513) {
    var_4 = var_3 scripts\sp\utility::_id_10619(1);

    if(isDefined(var_4.target))
      var_4._id_1FEB = scripts\engine\utility::getStruct(var_3.target, "targetname");
    else
      var_4._id_1FEB = var_4;

    var_1[var_1.size] = var_4;
  }

  foreach(var_4 in var_1) {
    if(!isDefined(var_4.animation))
      var_4.animation = "harbor_floating_idle_03";

    var_4._id_1FEB thread scripts\sp\anim::_id_1ECC(var_4, var_4.animation);
    var_4 scripts\sp\utility::_id_F2A8(1);
  }

  scripts\engine\utility::flag_wait("flag_breach_wall_compression_done");
  var_1 = scripts\sp\utility::_id_22B9(var_1);

  foreach(var_4 in var_1) {
    var_4 notify("stop_loop");
    var_4 scripts\sp\utility::anim_stopanimScripted();
    var_4 _meth_80F1(getgroundposition(var_4.origin, 8, 100), var_4.angles, 100000);
    var_4 scripts\sp\utility::_id_F415(1);
  }

  wait 1.0;

  foreach(var_4 in var_1)
  var_4 scripts\sp\utility::_id_F415(0);
}

_id_1470() {
  level.player endon("death");
  var_0 = self;
  wait 3;
  var_1 = var_0._id_1D16[0];

  foreach(var_3 in level.allies) {
    var_3 scripts\sp\utility::_id_1160F(var_1);
    wait 0.5;
  }
}

_id_1471() {
  level.player endon("death");
  var_0 = self;
  var_1 = var_0 scripts\sp\utility::_id_7A97();
  var_2 = [];
  var_2[0] = _id_1183(var_1, "breach_wall_animstruct_01");

  for(var_3 = 0; isDefined(var_2[var_3].target); var_3 = var_3 + 1)
    var_2[var_3 + 1] = scripts\engine\utility::getStruct(var_2[var_3].target, "targetname");

  var_4 = _id_1183(var_1, "breach_wall_charge_01");
  var_5 = _id_1183(var_1, "breach_wall_charge_02");
  var_6 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player setworldupreference(var_6);
  level.player playerlinktodelta(var_6, "tag_origin", 1, 4, 4, 4, 4, 0);
  level.player disableweapons();
  var_6 _id_117D(var_2[0], 0.5, 0.1, 0.0);
  wait 0.2;
  var_7 = var_4 _id_140D();
  var_7 thread scripts\sp\utility::play_sound_on_entity("sa_hack_start");
  wait 0.4;

  for(var_8 = 1; var_8 < var_2.size; var_8++) {
    var_9 = 0.0;
    var_10 = 0.0;

    if(var_8 == var_2.size - 1)
      var_10 = 0.1;

    var_6 _id_117D(var_2[var_8], var_2[var_8].script_delay, var_9, var_10);
  }

  wait 1.0;
  level notify("breach_wall_explosion");
  var_7 delete();
  wait 1.2;
  scripts\engine\utility::waitframe();
  level.player._id_1F63 = scripts\sp\utility::_id_10639("player_rig", var_6.origin, var_6.angles);
  level.player._id_1F63 linkTo(var_6);
  level.player._id_1F63 hide();
  level.player playerlinktodelta(level.player._id_1F63, "tag_player", 0, 65, 65, 45, 35, 0);
  var_2 = [];
  var_2[0] = _id_1183(var_1, "breach_wall_floatin");

  for(var_3 = 0; isDefined(var_2[var_3].target); var_3 = var_3 + 1)
    var_2[var_3 + 1] = scripts\engine\utility::getStruct(var_2[var_3].target, "targetname");

  var_11 = 0.0;

  foreach(var_13 in var_2)
  var_11 = var_11 + var_13.script_delay;

  var_15 = var_2[0].script_delay + var_2[1].script_delay;
  var_16 = var_15 + 0.15;
  var_17 = var_11 - 0.4;
  level.player scripts\engine\utility::delaycall(var_15, ::enableweapons);
  scripts\engine\utility::delaythread(var_16, ::_id_1473);
  scripts\engine\utility::delaythread(var_17, ::_id_1472);

  for(var_8 = 0; var_8 < var_2.size; var_8++) {
    var_9 = 0.0;
    var_10 = 0.0;

    if(var_8 == 0)
      var_9 = 0.1;

    if(var_8 == var_2.size - 1)
      var_10 = 0.1;

    var_6 _id_117D(var_2[var_8], var_2[var_8].script_delay, var_9, var_10);
  }

  level.player unlink();
  level.player._id_1F63 delete();
  level.player setworldupreference(undefined);
  level.player _meth_80A1();
  level.player thread scripts\sp\utility::_id_CFAA();
  var_6 delete();
  level notify("breach_wall_done");
}

_id_1473() {
  level.player scripts\engine\utility::delaycall(0.5, ::_meth_82C2, "sa6_carrier_slowmo", "mix");
  level.player playSound("zerog_breach_slowmo_in");
  level.player scripts\engine\utility::delaythread(0.35, scripts\engine\utility::play_loop_sound_on_entity, "zerog_breach_slowmo_lp_lr");
  _id_0B0B::_id_F5A0();
  setslowmotion(1.0, 0.25, 1.0);
}

_id_1472() {
  level.player clearclienttriggeraudiozone(0.5);
  level.player playSound("zerog_breach_slowmo_out");
  level.player notify("stop soundzerog_breach_slowmo_lp_lr");
  setslowmotion(0.25, 1.0, 1.0);
  _id_0B0B::_id_F59F();
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "sa_ability_lifesupport_on_lr");
}

_id_13BB() {
  var_0 = self;
  level.player playSound("zerog_breach_explo");
  thread _id_1478();
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.angles = var_1.angles + (0, 0, 90);
  playFXOnTag(scripts\engine\utility::getfx("zerog_breach_explosion"), var_1, "tag_origin");
  var_1.angles = var_1.angles + (-90, 0, 0);
  playFXOnTag(scripts\engine\utility::getfx("breach_wind"), var_1, "tag_origin");
  var_1 scripts\engine\utility::delaythread(0.5, scripts\engine\utility::play_loop_sound_on_entity, "zerog_breach_wind_lp");

  foreach(var_3 in var_0._id_D955) {
    var_3 connectpaths();
    var_3 hide();
    var_3 notsolid();
  }

  foreach(var_6 in var_0._id_52D5) {
    var_6 show();
    var_6 solid();
  }

  scripts\engine\utility::delaythread(0.2, ::_id_1476, var_0._id_69E4);
  wait 1.2;
  scripts\engine\utility::delaythread(0.2, ::_id_1479);
  level waittill("breach_wall_done");
  var_1 delete();
}

_id_1475(var_0) {
  var_1 = self;
  var_2 = var_1 scripts\sp\utility::_id_7A97();
  var_3 = [];
  scripts\engine\utility::flag_wait("flag_breach_wall_exterior_door_closed");
  wait 0.5;

  foreach(var_5 in var_1._id_6122) {
    var_6 = var_5 _id_0F0A::_id_AC58("on");
    var_3 = scripts\engine\utility::array_add(var_3, var_6);
  }

  wait(var_0);
  scripts\engine\utility::array_thread(var_3, _id_0F0A::_id_AC58, "off");
  _id_0F35::_id_FB24(0, level.player);
  _id_0F35::_id_FB25(0, 0);
  _id_0F31::_id_E0C8();
  _id_0F31::_id_E0CE();
  _id_0F31::_id_E0CD();
  scripts\engine\utility::flag_set("flag_breach_wall_compression_done");
}

_id_117D(var_0, var_1, var_2, var_3) {
  self moveTo(var_0.origin, var_1, var_2, var_3);
  self rotateTo(var_0.angles, var_1, var_2, var_3);
  wait(var_1);
}

_id_140D() {
  var_0 = self;
  var_1 = scripts\sp\utility::_id_10639("mute_charge_01", var_0.origin, var_0.angles);
  return var_1;
}

_id_146F() {
  var_0 = self;
  var_1 = var_0 scripts\sp\utility::_id_7A97();
  var_2 = [];
  var_3 = undefined;

  foreach(var_3 in var_1) {
    if(var_3.script_noteworthy == "breach_wall_alarm_spot") {
      break;
    }
  }

  foreach(var_7 in var_0._id_611E) {
    var_7 _id_0F0A::_id_AC57("on");
    var_2 = scripts\engine\utility::array_add(var_2, var_7);
  }

  var_9 = var_3 scripts\engine\utility::spawn_tag_origin();
  var_9 thread scripts\engine\utility::play_loop_sound_on_entity("zerog_breach_alarm");
  scripts\engine\utility::flag_wait("flag_breach_wall_compression_done");
  wait 1.0;
  scripts\engine\utility::array_thread(var_2, _id_0F0A::_id_AC57, "off");
  var_9 thread scripts\engine\utility::stop_loop_sound_on_entity("zerog_breach_alarm");
  var_9 delete();
}

_id_1476(var_0) {
  var_1 = _id_1184(var_0, "breach_wall_explosionguy");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\sp\utility::_id_10619(1);
    var_4._id_BCDA = var_3 scripts\engine\utility::spawn_tag_origin();
    var_4._id_BCDA thread scripts\sp\anim::_id_1ECC(var_4, var_4.animation);
    var_4._id_BCDA.origin = var_4._id_BCDA.origin + (0, 0, 32);
    var_4 linkTo(var_4._id_BCDA, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_5 = 1.2;
    var_4._id_BCDA moveTo(scripts\engine\utility::getStruct(var_4.target, "targetname").origin, var_5);
    var_4 scripts\engine\utility::delaycall(var_5, ::_meth_81D0);
    var_4._id_BCDA scripts\engine\utility::delaycall(var_5, ::delete);
    wait 0.4;
  }
}

_id_1474(var_0) {
  wait(var_0);
  scripts\engine\utility::flag_set("flag_breach_wall_exterior_door_closed");
  level.player setsoundsubmix("sa_ship_interior");
}

_id_1477() {
  var_0 = self;
}

_id_1478() {
  level endon("stop_breach_wall_screen_shake");
  scripts\sp\utility::_id_16CC("zerog_breach_expl_shake", 0.2, 1, 2048);

  for(;;) {
    scripts\engine\utility::do_earthquake("zerog_breach_expl_shake", level.player.origin);
    wait 0.4;
  }
}

_id_1479() {
  level notify("stop_breach_wall_screen_shake");
}

_id_1185(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.targetname) && var_3.targetname == var_1)
      return var_3;
  }
}

_id_1186(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.targetname) && var_4.targetname == var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_1183(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == var_1)
      return var_3;
  }
}

_id_1184(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}