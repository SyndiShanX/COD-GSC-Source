/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_ext_combat.gsc
****************************************************************/

_id_3B93() {
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_3B42();
  var_0 = getEntArray("ordnance_anim_prop_clips", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_13E74() {
  level._id_13E74 = 1;
  scripts\sp\maps\heistspace\heistspace_util::_id_10733(undefined, undefined, undefined, 1);
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_F5AF("jumpto_zero_g_combat", [level.player, level._id_EA2C]);
  level._id_EA2C.team = "allies";
  level._id_EA2C.ignoreall = 0;
  level._id_EA2C.ignoreme = 0;
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_zero_g_combat");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_13E81();
  thread _id_13E9D();
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_BC27("jackal_crash_begin");
  level._id_C47C = scripts\engine\utility::getStruct("om_ordnance_hall_animnode", "targetname");
  var_0 = scripts\sp\maps\heistspace\heistspace_interior::_id_C6E6();

  foreach(var_2 in var_0) {
    level._id_C47C scripts\sp\anim::_id_1EE0(var_2, "check_ordnance_exit");
  }
}

_id_13E72() {
  scripts\engine\utility::flag_set("zero_g_combat_begin");
  setglobalsoundcontext("atmosphere", "space");
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(1);
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_52F1();
  thread _id_13E8E();
  thread _id_13EC8();
  level._id_C0B7 = 1;
  level._id_EA2C._id_B3E9 = 1;
  level._id_13EC1 solid();
  level._id_13EC1 disconnectPaths();
  thread _id_13E7F();
  thread _id_13E73();
  level._id_13EDD = "player_entering_jackal";
  scripts\engine\utility::flag_set("zerog_rotate");
  thread _id_0F36::_id_1398B("player_entering_jackal");
  thread _id_0F36::_id_8970("player_entering_jackal");
  scripts\engine\utility::flag_wait("zero_g_combat_end");
  scripts\sp\utility::_id_2669("heistspace_zerog_done");
  var_0 = getEntArray("zerog_speed_adjustment", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_13E8E() {
  _id_0F35::_id_FB26(1);
  scripts\engine\utility::flag_wait("player_near_ordnance_exit");
  _id_0F35::_id_FB27();
}

_id_13EC8() {
  scripts\engine\utility::flag_wait("start_player_zerog_drift");
  level.player _meth_8251((-2, 0, 0), 1);
  scripts\engine\utility::flag_wait("player_entering_jackal");
  level.player _meth_8251((0, 0, 0), 1);
}

_id_13E9D() {
  thread _id_13EA9();
  thread _id_13ECE();
  thread _id_13EA4();
}

_id_13EA9() {
  if(!isDefined(level._id_13E74)) {
    wait 7;
  }

  var_0 = scripts\engine\utility::getStructArray("zerog_dyn_models", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel(var_2.script_noteworthy);
    var_3 dontcastshadows();
    var_3 thread _id_CB00("player_entering_jackal");
  }
}

_id_CB00(var_0) {
  var_1 = self.origin;
  wait 0.05;
  var_2 = scripts\engine\utility::flatten_vector(var_1);
  var_3 = var_2 + (100, 0, 0);
  var_4 = vectorNormalize(var_3 - var_2);
  wait 0.5;
  var_5 = var_4 * randomintrange(4, 8);
  var_6 = self.origin - (self.origin + (6, 0, 0));
  var_6 = var_6 * randomintrange(4, 8);
  self physicslaunchserver(self.origin + (-150, 0, 0), var_6);
  scripts\engine\utility::flag_wait(var_0);
  wait 5;

  if(isDefined(self)) {
    self delete();
  }
}

_id_DC9F(var_0, var_1) {
  return (randomintrange(var_0, var_1), randomintrange(var_0, var_1), randomintrange(var_0, var_1));
}

_id_13ECE() {
  var_0 = getEntArray("zerog_rotating_debris", "script_noteworthy");
  thread _id_13ECF(var_0);

  foreach(var_2 in var_0) {
    var_2.script_index = randomfloatrange(0.1, 0.5);
    var_2 dontcastshadows();

    if(isDefined(var_2.target)) {
      var_3 = getEnt(var_2.target, "targetname");
      var_3 linkTo(var_2);
    }
  }

  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\heistspace\heistspace_util::_id_E70E);
  var_5 = getEnt("zerog_rotating_drift_debris_volume", "targetname");

  foreach(var_2 in var_0) {
    if(var_2 istouching(var_5)) {
      var_2 thread _id_BC62(var_5);
    }
  }

  _id_0BDC::_id_137CF();

  foreach(var_2 in var_0) {
    var_2 notify("debris_done");
  }
}

_id_BC62(var_0) {
  level endon("player_entering_jackal");
  wait 5;
  var_1 = getEnt("zerog_rotating_drift_debris_volume2", "targetname");

  if(self istouching(var_1)) {
    scripts\engine\utility::flag_wait("player_near_ordnance_exit");
  }

  self moveTo(self.origin + (-20000, 0, 0), 500);

  while(self istouching(var_0)) {
    wait 0.1;
  }

  if(isDefined(self.target)) {
    var_2 = getEnt(self.target, "targetname");

    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_13ECF(var_0) {
  if(!isDefined(var_0)) {
    var_0 = getEntArray("zerog_rotating_debris", "script_noteworthy");
  } else {
    _id_0BDC::_id_137CF();
    wait 6;
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {
      var_3 = getEnt(var_2.target, "targetname");

      if(isDefined(var_3)) {
        var_3 delete();
      }
    }

    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_13EA4() {
  if(!isDefined(level._id_E36D)) {
    wait 2;
  }

  level._id_4E8E = [];
  level._id_4E8E[0] = "debris_exterior_damaged_metal_panel_05_piece_01";
  level._id_4E8E[1] = "debris_exterior_damaged_metal_panel_05_piece_02";
  level._id_4E8E[2] = "debris_exterior_damaged_metal_panel_05_piece_03";
  var_0 = 10;
  level._id_4E7B = 0;
  level._id_A8A6 = -1;
  level._id_A8A7 = -1;
  var_1 = scripts\engine\utility::getStructArray("zerog_drift_debris_scripted_start", "targetname");

  foreach(var_3 in var_1) {
    thread _id_BCA2(var_3, var_3.script_noteworthy);
  }

  var_5 = scripts\engine\utility::getStructArray("zerog_drift_debris_start", "targetname");
  thread _id_13EA3(var_5, var_0);
  scripts\engine\utility::flag_wait("stop_zerog_drift_debris");
  level notify("stop_zerog_drift_debris_notify");
  var_6 = scripts\engine\utility::getStructArray("zerog_drift_debris_scripted_start2", "targetname");
  thread _id_13EA3(var_6, var_0);
  scripts\engine\utility::flag_wait("player_entering_jackal");
  level notify("stop_zerog_drift_debris_notify");
}

_id_13EA3(var_0, var_1) {
  level endon("stop_zerog_drift_debris_notify");

  for(;;) {
    if(level._id_4E7B < var_1) {
      thread _id_13EA2(var_0);
    }

    wait(randomfloatrange(6, 10));
  }
}

_id_13EA2(var_0) {
  var_1 = randomint(var_0.size);

  if(var_1 == level._id_A8A7) {
    var_1++;

    if(var_1 >= var_0.size) {
      var_1 = 0;
    }
  }

  var_2 = var_0[var_1];
  var_3 = randomint(level._id_4E8E.size);

  if(var_3 == level._id_A8A7) {
    var_3++;

    if(var_3 >= level._id_4E8E.size) {
      var_3 = 0;
    }
  }

  var_4 = level._id_4E8E[var_3];
  thread _id_BCA2(var_2, var_4);
  level._id_A8A6 = var_3;
  level._id_A8A7 = var_1;
}

_id_BCA2(var_0, var_1) {
  level._id_4E7B++;
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_1);
  var_2 dontcastshadows();
  var_3 = randomfloatrange(20, 25);
  var_2 rotatevelocity(scripts\engine\utility::randomvectorrange(-20, 20), var_3);
  var_4 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 moveTo(var_4.origin, var_3);
  wait(var_3);
  var_2 delete();
  level._id_4E7B--;
}

_id_13E7F() {
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\engine\utility::flag_wait("zero_g_combat_enemies_dead");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_1034D("heistspace_plr_wherearemybirds");

  if(!isDefined(level.player._id_134F8)) {
    level.player._id_134F8 = level.player scripts\engine\utility::spawn_tag_origin();
  }

  level.player._id_134F8._id_1FBB = "ethan";
  level.player._id_134F8 linkTo(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.player._id_134F8 scripts\sp\utility::_id_10346("heistspace_eth_momentsawaysir");

  if(isDefined(level.player._id_134F8)) {
    level.player._id_134F8 unlink();
    level.player._id_134F8 delete();
  }

  scripts\engine\utility::flag_set("zero_g_combat_end");
}

_id_13E73() {
  level._id_13EAA = [];
  level.player._id_11400["tagging_fade_min"] = 500.0;
  level.player._id_11400["tagging_fade_max"] = 3000.0;
  level._id_4BD0 = getEnt("zerog_enemies_volume0", "targetname");
  scripts\sp\utility::_id_22CA("zerog_enemies_start", ::_id_13EAA);
  var_0 = scripts\sp\utility::_id_22CD("zerog_enemies_start", 1);
  scripts\sp\utility::_id_22C9("zerog_dropship1_spawners", ::_id_13EAA);
  thread _id_13EAD();
  thread _id_6E41(level._id_13EAA, 1, "retreat_to_zerog_enemies_volume1_enemy_death");
  scripts\engine\utility::flag_wait_any("retreat_to_zerog_enemies_volume1", "retreat_to_zerog_enemies_volume1_enemy_death", "spawn_zerog_dropship1");
  var_1 = scripts\sp\vehicle::_id_1080D("zerog_dropship1");
  var_1.ignoreme = 1;
  var_1.ignoreall = 1;
  var_1 scripts\sp\vehicle::_id_8441();
  var_1 thread _id_5ED3();
  thread _id_6E41(level._id_13EAA, 1, "retreat_to_zerog_enemies_volume2_enemy_death");

  if(!scripts\engine\utility::flag("spawn_zerog_dropship1")) {
    scripts\engine\utility::flag_wait_any("retreat_to_zerog_enemies_volume2", "retreat_to_zerog_enemies_volume2_enemy_death", "spawn_zerog_dropship1");
  } else {
    scripts\engine\utility::flag_wait_any("retreat_to_zerog_enemies_volume2", "retreat_to_zerog_enemies_volume2_enemy_death");
  }

  scripts\engine\utility::flag_set("ready_to_unload");
  scripts\sp\utility::_id_2679();
  level notify("zerog_enemies_wave_2");
  scripts\engine\utility::flag_wait_any("retreat_to_zerog_enemies_volume3", "retreat_to_zerog_enemies_volume3_enemy_death");

  if(scripts\engine\utility::flag("retreat_to_zerog_enemies_volume3_enemy_death")) {
    scripts\engine\utility::flag_set("retreat_to_zerog_enemies_volume1");
    scripts\engine\utility::flag_set("retreat_to_zerog_enemies_volume2");
    wait 0.1;
    scripts\engine\utility::flag_set("retreat_to_zerog_enemies_volume3");
  }
}

_id_13EAD() {
  while(level._id_13EAA.size > 2) {
    wait 0.1;
    level._id_13EAA = scripts\sp\utility::array_removedeadvehicles(level._id_13EAA);
  }

  foreach(var_1 in level._id_13EAA) {
    var_1 thread _id_137BF(undefined, 1);
  }

  scripts\sp\utility::_id_13754(level._id_13EAA);
  scripts\engine\utility::flag_set("zero_g_combat_enemies_dead");
}

_id_6E41(var_0, var_1, var_2) {
  level endon("death");
  scripts\sp\utility::_id_13754(var_0, var_1);
  scripts\engine\utility::flag_set(var_2);
}

_id_5DBF() {
  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 moveTo(self.origin + (-5000, 0, 0), 30, 6);
  self waittill("unloaded");
  self unlink();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_5ED3() {
  self waittill("unloading");
  level notify("dropship_unloading");
  thread _id_5DBF();
}

_id_13EAA() {
  self endon("death");
  level._id_13EAA = scripts\engine\utility::add_to_array(level._id_13EAA, self);

  if(isDefined(self.script_noteworthy) && (self.script_noteworthy == "zerog_dropship1_spawners" || self.script_noteworthy == "zerog_dropship2_spawners")) {
    level waittill("dropship_unloading");

    if(level._id_4BD0.script_index > self.script_index) {
      thread _id_E358(level._id_4BD0);
    }
  }

  if(isDefined(self.target) && self.target == "zerog_scripted_kill_volume") {
    thread _id_13EB0();
  }

  thread _id_13EAB();
}

_id_13EB0() {
  if(!isDefined(level._id_13EB0)) {
    level._id_13EB0 = [];
  }

  level._id_13EB0 = scripts\engine\utility::add_to_array(level._id_13EB0, self);
  self.accuracy = 0.1;
  self._id_2894 = 0.1;
  self.health = 50;
}

_id_E096() {
  self endon("death");
  self waittill("grapple_kill");
  _id_0F25::_id_113E2(0);
}

_id_13EAB() {
  self endon("death");

  if(!scripts\engine\utility::flag("retreat_to_zerog_enemies_volume1")) {
    scripts\engine\utility::flag_wait("retreat_to_zerog_enemies_volume1");
    level._id_4BD0 = getEnt("zerog_enemies_volume1", "targetname");

    if(level._id_4BD0.script_index > self.script_index) {
      thread _id_E358(level._id_4BD0);
    }
  }

  if(!scripts\engine\utility::flag("retreat_to_zerog_enemies_volume2")) {
    scripts\engine\utility::flag_wait("retreat_to_zerog_enemies_volume2");
    level._id_4BD0 = getEnt("zerog_enemies_volume2", "targetname");

    if(level._id_4BD0.script_index > self.script_index) {
      thread _id_E358(level._id_4BD0);
    }
  }

  if(!scripts\engine\utility::flag("retreat_to_zerog_enemies_volume3")) {
    scripts\engine\utility::flag_wait("retreat_to_zerog_enemies_volume3");
    level._id_4BD0 = getEnt("zerog_enemies_volume3", "targetname");

    if(level._id_4BD0.script_index > self.script_index) {
      thread _id_E358(level._id_4BD0);
    }
  }
}

_id_E358(var_0) {
  self endon("death");
  self notify("retreating");
  self endon("retreating");
  self cleargoalvolume();
  self clearpath();
  self.goalradius = 16;
  self.ignoreall = 1;
  self _meth_82F1(var_0);
  self waittill("goal");
  self.ignoreall = 0;
}

_id_137BF(var_0, var_1) {
  self endon("death");
  self endon("deleted");
  var_2 = 0;

  while(!var_2) {
    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, cos(45))) {
      var_2 = 1;
    }

    wait 0.05;
  }

  if(isDefined(var_0)) {
    scripts\engine\utility::flag_set(var_0);
  }

  if(isDefined(self._id_84AF)) {
    return;
  }
  if(isDefined(var_1)) {
    self _meth_81D0();
  }
}

_id_13942() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_3B87() {
  level._id_D6E5 = 1;
  var_0 = getEnt("retribution", "targetname");
  var_0._id_EEF9 = "missile_cluster_turret_un cannon_small_un,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  scripts\sp\utility::_id_22CA("retribution", ::_id_E3F5);
  level._id_E35D = scripts\sp\vehicle::_id_1080C("retribution");
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_3B40();
  level._id_D6F2 = 1;
  scripts\engine\utility::flag_set("player_entering_jackal");
  level._id_C476 = getEnt("olympus_mons_hull", "targetname");
  level._id_C476 movez(8192, 0.05);
  level._id_C413 solid();
  thread _id_13ECF();
}

_id_E36D() {
  level._id_E36D = 1;
  scripts\sp\maps\heistspace\heistspace_util::_id_10733(undefined, undefined, undefined, 1);
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_F5AF("jumpto_ret_arrives", [level.player, level._id_EA2C]);
  thread scripts\sp\maps\heistspace\heistspace_util::_id_13E81();
  level._id_C0B7 = 1;
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_retribution_arrives");
  level._id_13EC1 solid();
  level._id_13EC1 disconnectPaths();
  scripts\engine\utility::flag_set("start_zerog_drift");
  thread _id_13ECF();
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_BC27("jackal_crash_begin");
}

_id_E369() {
  setsaveddvar("grapple_max_distance", 1500);
  visionsetalternate(7, 0.5);
  setglobalsoundcontext("atmosphere", "space");
  thread _id_E36B();
  thread _id_A416();
  thread _id_E36E();
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(1);
  scripts\engine\utility::flag_wait("retribution_arrives_end");
  scripts\sp\utility::_id_2669("retribution_arrives_end");
}

_id_E36B() {
  level._id_EA2C scripts\sp\utility::_id_54F7();
  level._id_EA2C.ignoreall = 1;
  level._id_EA2C.ignoreme = 1;
  var_0 = getnode("zerog_combat_over_salter_node", "targetname");
  level._id_EA2C _meth_82EE(var_0);
  level._id_EA2C scripts\engine\utility::delaythread(0.2, _id_0F34::_id_13E86);
  level waittill("salter_jackal_stopped");
  var_0 = getnode("jackal_salter_node", "targetname");
  level._id_EA2C _meth_82EE(var_0);
  scripts\engine\utility::flag_wait("player_entering_jackal");
  level._id_C476 = getEnt("olympus_mons_hull", "targetname");
  level._id_C476 movez(8192, 0.05);
  wait 2;

  if(isDefined(level._id_EA2C)) {
    level._id_EA2C scripts\sp\utility::_id_1101B();
    level._id_EA2C delete();
  }
}

#using_animtree("jackal");

_id_A416() {
  level._id_D127 = _id_0BDC::_id_1079F("player_jackal");
  level._id_D127.ignoreall = 1;
  level._id_D127.ignoreme = 1;
  level._id_D127 scripts\sp\vehicle::_id_8441();
  level._id_D127 _id_0BDC::_id_F48D("zero_g");
  level._id_D127 _id_0BDC::_id_F5BD("instant");
  level._id_D127 _id_0BDC::_id_A19F();
  level._id_D127 _id_0BDC::_id_A07D();
  level._id_D127 _id_0BDC::_id_104A6(0);
  thread _id_D16D();
  thread _id_E36C();
  level._id_D127 thread _id_A37D();
  var_0 = level._id_D127 _id_0BDC::_id_A372("player_jackal_fly_in_spline");
  level._id_D127 _id_0BDC::_id_A1EF(var_0, 180, 50);
  level._id_D127 _id_0BDC::_id_19AB(25);
  level._id_D127 notify("jackal_starting_jackal_go_to_struct");
  level._id_D127 _id_0BDC::_id_A1F4("player_jackal_arrival_position", 1, 25, 1);
  scripts\engine\utility::flag_set("player_jackal_stopped");
  level._id_D127 setanimknob(%jackal_vehicle_space_assault_to_mount, 1.0, 2.0);
  thread _id_D14B();
  thread _id_84AC("player_grapple_to_jackal");
  level._id_D127 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "trigger");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "player_grapple_to_jackal");
  scripts\sp\utility::_id_57D6();

  if(scripts\engine\utility::flag("player_grapple_to_jackal")) {
    scripts\engine\utility::flag_waitopen("player_grapple_to_jackal");
    level._id_D127._id_99F5._id_BBE7 = "right";
    level._id_D127 _id_0BDC::_id_F48D("zero_g");
    level._id_D127 thread _id_0BDB::_id_F51F();
    level.player scripts\engine\utility::delaycall(4, ::setsoundsubmix, "jackal_dogfight");
  }

  level._id_D127 _id_0C20::_id_A3B7("none", 0);
  level._id_D127 _id_0BDC::_id_A167();
  level._id_C413 solid();
  scripts\engine\utility::flag_set("player_entering_jackal");
  clearallcorpses();
  level notify("zerog_ammo_cleanup");
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C7(1);
  level._id_D127 thread scripts\sp\maps\heistspace\heistspace_fx::_id_132F6();
  level._id_D127.ignoreall = 1;
  level._id_D127.ignoreme = 1;
  level._id_D127 scripts\sp\vehicle::_id_8441();
  level.player.ignoreme = 1;
  scripts\engine\utility::waitframe();
  thread _id_E3A9();
  wait 3;
  level notify("start_retribution_arrives_vo");
  level._id_D127 waittill("mount_anims_complete");
  _id_0BDC::_id_A15C(1);
  _id_0BDC::_id_A153(1);
  _id_0BDC::_id_A155(1);
  _id_0BDC::_id_A156(1);
  _id_0BDC::_id_A14A(1);
  _id_0BDC::_id_A078((-40, 0, 0), 15);
  var_1 = scripts\engine\utility::getStruct("retribution_lookat", "targetname");
  _id_0BDC::_id_D165(var_1, 1.0, 0.0, 3.0);
  thread scripts\sp\maps\heistspace\heistspace_audio::_id_E3AB();
  wait 0.5;
  scripts\engine\utility::flag_set("retribution_ftl_in");
  wait 1.5;
  _id_0BDC::_id_D165((0, 0, 0), 0, 1.0, 0);
  _id_0BDC::_id_A15C(0);
  _id_0BDC::_id_A153(0);
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A156(0);
  _id_0BDC::_id_A14A(0);

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
    _id_0BD9::_id_FA4F();
  }

  scripts\engine\utility::flag_set("retribution_arrives_end");
  var_2 = scripts\sp\utility::_id_7DB7();

  foreach(var_4 in var_2) {
    if(isDefined(var_4)) {
      var_4 delete();
    }
  }
}

_id_A37D() {
  thread _id_A37E();
  self waittill("jackal_starting_jackal_go_to_struct");
  wait 0.5;
  self notify("end_jackal_touch_watch");
}

_id_A37E() {
  self endon("end_jackal_touch_watch");

  for(;;) {
    self waittill("touch", var_0);

    if(var_0 == level.player) {
      level.player _meth_81D0();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_D16D() {
  wait 1;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_D127, "tag_player", (60, 0, 35), (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("obj_player_jackal"), "current", "", var_0.origin);
  objective_onentity(scripts\sp\utility::_id_C264("obj_player_jackal"), var_0);

  while(distance(level.player.origin, var_0.origin) > 500) {
    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_player_jackal"));

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_D14B() {
  level endon("player_entering_jackal");
  level endon("player_grapple_to_jackal");
  wait 1;

  for(;;) {
    while(distance(level.player.origin, level._id_D127.origin) > 300) {
      scripts\engine\utility::waitframe();
    }

    level.player _meth_8502();
    level._id_D127 _id_0BDC::_id_104A6(1);

    while(distance(level.player.origin, level._id_D127.origin) < 300) {
      scripts\engine\utility::waitframe();
    }

    level.player _meth_8501(level._id_84B5);
    level._id_D127 _id_0BDC::_id_104A6(0);
  }
}

_id_84AC(var_0) {
  level._id_84B5 = scripts\engine\utility::spawn_tag_origin(level._id_D127.origin);
  level._id_84B5 linkTo(level._id_D127, "tag_body", (230, -48, 30), (0, 0, 0));
  level.player _meth_8501(level._id_84B5);

  for(;;) {
    level.player waittill("spacejump_takeoff", var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_0)) {
      if(isDefined(var_5) && var_5 == level._id_84B5) {
        scripts\engine\utility::flag_set(var_0);
        var_6 = level.player scripts\engine\utility::waittill_any_return("spacejump_land", "spacegrapple_cancel");
        scripts\engine\utility::flag_clear(var_0);

        if(var_6 == "spacejump_land") {
          if(var_5 == level._id_84B5) {
            level.player _meth_8502();

            if(isDefined(level._id_84B5)) {
              level._id_84B5 delete();
            }

            return;
          }
        }
      }

      continue;
    }

    level.player _meth_8502();
  }

  if(isDefined(level._id_84B5)) {
    level._id_84B5 delete();
  }
}

_id_E36C() {
  wait 1;
  level._id_EA99 = scripts\sp\vehicle::_id_1080C("salter_jackal");
  level._id_EA99.ignoreall = 1;
  level._id_EA99.ignoreme = 1;
  level._id_EA99 scripts\sp\vehicle::_id_8441();
  level._id_A056._id_1630 = scripts\engine\utility::array_remove(level._id_A056._id_1630, level._id_EA99);

  if(issentient(level._id_EA99)) {
    level._id_EA99 _id_0BDC::_id_19A0(1);
  }

  level._id_EA99 thread _id_A37D();
  var_0 = level._id_EA99 _id_0BDC::_id_A372("salter_jackal_fly_in_spline");
  level._id_EA99 thread _id_0BDC::_id_A1EF(var_0, 180, 50);
  level._id_EA99 waittill("salter_jackal_adjust_speed");
  level._id_EA99 _id_0BDC::_id_19B0("hover");
  level._id_EA99 waittill("end_spline");
  level._id_EA99 notify("jackal_starting_jackal_go_to_struct");
  level._id_EA99 _id_0BDC::_id_19AB(25);
  level._id_EA99 _id_0BDC::_id_A1F4("salter_jackal_arrival_position", 1, 50);
  level notify("salter_jackal_stopped");
  level._id_EA99 setanimknob(%jackal_vehicle_space_assault_to_mount, 1.0, 2.0);
  scripts\engine\utility::flag_wait("player_entering_jackal");

  while(!isDefined(level._id_D127)) {
    wait 0.05;
  }

  level._id_D127 waittill("mount_anims_complete");
  level._id_EA99 clearanim(%jackal_vehicle_space_assault_to_mount, 0.0);
  level._id_EA99 _id_0BDC::_id_A1F4("salter_retribution_arrives_struct", 1, 50);
}

_id_E3A9() {
  wait 1;
  var_0 = getEnt("retribution_sd_target", "targetname");
  var_0._id_EEF9 = "none";
  var_1 = scripts\sp\vehicle::_id_1080C("retribution_sd_target");
  scripts\engine\utility::waitframe();
  wait 0.2;
  var_1.delete_on_death = 1;
  var_1 _id_0BB8::_id_39CD("heavy");
  var_1 _id_0BB8::_id_39D0("heavy");
  var_1 _id_0BB8::_id_39CE("high");
  var_1._id_CB55 = _id_4E65();
  scripts\engine\utility::flag_wait("retribution_ftl_in");
  var_2 = getEnt("retribution", "targetname");
  var_2._id_EEF9 = "cannon_large_un missile_tube_un";
  var_2._id_ED7C = "off off";
  scripts\sp\utility::_id_22CA("retribution", ::_id_E3F5);
  level._id_E35D = _id_0BB8::_id_398E("retribution", "idle", "heavy", "high");
  wait 0.5;
  level._id_E35D._id_B824 = 800;
  level._id_E35D._id_B825 = 1000;
  level._id_E35D._id_B823 = 1000;
  level._id_E35D _id_0BB6::_id_3983(var_1);
  level._id_E35D._id_12FBA = 1;
  var_3 = 0;

  while(var_3 < 2) {
    var_1 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(var_8 == "MOD_EXPLOSIVE" && isDefined(var_13) && var_13 == "spaceship_homing_missile") {
      var_3 = var_3 + 1;
    }

    wait 0.05;
  }

  level._id_3979["script_vehicle_capitalship_destroyer_ca"]._id_7582 = level._effect["destroyer_explode_jackal_combat"];
  level._id_1024A = 1;
  var_14 = var_1 _id_0BA9::_id_39AA(undefined, 1);
  var_14 thread _id_4E64();
}

_id_4E65() {
  var_0 = [];

  if(!scripts\engine\utility::flag("max_destroyer_kill_count_reached")) {
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_01_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_02_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_03_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_07_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_09_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_10_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_11_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_12_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_13_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_14_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_15_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_18_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_20_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_27_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_29_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_33_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_34_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_35_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_37_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_38_mat_rdc";
  } else {
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_01_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_02_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_03_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_07_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_09_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_10_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_11_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_12_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_13_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_14_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_15_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_20_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_27_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_29_mat_rdc";
    var_0[var_0.size] = "veh_mil_air_ca_destroyer_dst_piece_big_37_mat_rdc";
  }

  return var_0;
}

_id_4E64() {
  scripts\engine\utility::flag_wait("jackal_crash_begin");

  if(isDefined(self)) {
    _id_0BA9::_id_3978();
    _id_0BA9::_id_39AB();
  }
}

_id_E3F5() {
  self endon("death");
  thread _id_0BB8::_id_397F(1, 1);
  _id_0BB8::_id_39AE();
  var_0 = getEntArray("retribution_shipcrib", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 linkTo(self, "tag_origin");
  }

  if(!isDefined(level._id_A121)) {
    return;
  }
  wait 5;
  self._id_12FBA = 1;
  thread _id_0BB6::_id_39F0();
  thread _id_E395("current_kill_objective_one", "vfx_hspace_ret_damage_trail_defend_stg1");
  thread _id_E395("current_kill_objective_two", "vfx_hspace_ret_damage_trail_defend_stg2");
  thread _id_E395("max_ace_kill_count_reached", "vfx_hspace_ret_damage_trail_defend_stg3");
  scripts\engine\utility::flag_wait("jackal_crash_begin");
  thread _id_0BB6::_id_39F1();
}

_id_E395(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_0);

  for(;;) {
    if(!_id_0B76::_id_9C19(self)) {
      break;
    }

    wait 0.1;
  }

  playFXOnTag(scripts\engine\utility::getfx(var_1), self, "tag_origin");
  thread _id_E396(var_1);
}

_id_E396(var_0) {
  scripts\engine\utility::flag_wait("jackal_crash_begin");
  killfxontag(scripts\engine\utility::getfx(var_0), self, "tag_origin");
}

_id_E3A2() {
  self endon("death");
  level endon("jackal_crash_begin");

  if(!isDefined(level._id_A121)) {
    return;
  }
  if(!isDefined(level._id_D6E5)) {
    wait 15;
  }

  self._id_12FBA = 1;

  for(;;) {
    var_0 = scripts\engine\utility::random(level._id_A121);

    if(isDefined(var_0)) {
      _id_0BB6::_id_3983(var_0);
    }

    wait(randomfloatrange(8, 10));
  }
}

_id_E36E() {
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_iseeem");
  scripts\sp\utility::_id_1034D("heistspace_plr_raidertomainine");
  thread scripts\sp\utility::_id_10350("heistspace_nav_solidactualbead");
  thread _id_E36A();
  level waittill("start_retribution_arrives_vo");
  scripts\sp\utility::_id_1034D("heistspace_plr_gatorgoforjumpd");
  scripts\sp\utility::_id_10350("h2_gtr_jump_now");
  wait 0.5;
  scripts\sp\utility::_id_10350("heistspace_nav_roger321");
  scripts\engine\utility::flag_wait("retribution_ftl_in");
  wait 2;
  scripts\sp\utility::_id_10350("heistspace_slt_retributionisin");
  scripts\sp\utility::_id_1034D("heistspace_plr_fangsoutsalt");
  scripts\sp\utility::_id_10350("heistspace_slt_rightwithyousli");
  scripts\sp\utility::_id_1034D("heistspace_plr_checkmetal1well");
  scripts\sp\utility::_id_10350("heistspace_eth_ayesir1");

  if(isDefined(level.player._id_134F8)) {
    level.player._id_134F8 unlink();
    level.player._id_134F8 delete();
  }

  scripts\engine\utility::flag_set("retribution_arrives_vo_over");
}

_id_E36A() {
  level endon("player_entering_jackal");
  scripts\engine\utility::flag_wait("player_jackal_stopped");
  wait 10;
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_reyesletswingup");
  wait 15;
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_getonthestickre");
}

_id_3B53() {
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_3B30();
}

_id_506F() {
  scripts\sp\utility::_id_F5AF("jumpto_defend_mons", [level.player]);
  level._id_D127 = _id_0BDC::_id_1079F("player_jackal", "jumpto_defend_mons");
  thread _id_0BDC::_id_10CD1(level._id_D127, undefined, "hover");
  level._id_D127 thread scripts\sp\maps\heistspace\heistspace_fx::_id_132F6();
  wait 0.1;
  var_0 = scripts\engine\utility::getStruct("retribution_lookat", "targetname");
  _id_0BDC::_id_D165(var_0, 1.0, 0.0, 0.0);
  level._id_D127.ignoreall = 1;
  level._id_D127.ignoreme = 1;
  level._id_D127 scripts\sp\vehicle::_id_8441();
  level.player.ignoreme = 1;
  level._id_C0B7 = 1;
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_defend_mons");
  level._id_EA99 = scripts\sp\vehicle::_id_1080C("salter_jackal");
  level._id_EA99 scripts\sp\vehicle::_id_8441();
  level._id_EA99 _id_0BDC::_id_19AB(25);
  var_1 = scripts\engine\utility::getStruct("salter_jackal_arrival_position", "targetname");
  level._id_EA99 vehicle_teleport(var_1.origin, var_1.angles);
  level._id_EA99 _id_0BDC::_id_A1F4("salter_retribution_arrives_struct", 1, 50);
  var_2 = scripts\sp\vehicle::_id_1080C("retribution_sd_target");
  wait 0.2;
  var_2.delete_on_death = 1;
  var_2._id_CB55 = _id_4E65();
  var_3 = var_2 _id_0BA9::_id_39AC();
  var_3 thread _id_4E64();
  scripts\engine\utility::delaythread(2, _id_0BDC::_id_D165, (0, 0, 0), 0.0, 1.0, 0);
  _id_0BDC::_id_A078((-40, 0, 0), 15);
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_BC27("jackal_crash_begin");
}

_id_5068() {
  scripts\engine\utility::flag_set("defend_mons_begin");
  visionsetalternate(7, 0.5);
  thread hs_jackal_music();
  setglobalsoundcontext("atmosphere", "space");
  thread _id_506C();
  thread _id_5070();
  thread _id_506D();
  _id_0BDC::_id_A321(0.5);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C7(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(1);
  scripts\engine\utility::waitframe();
  level._id_E35D _id_0BB8::_id_39CD("heavy");
  level._id_E35D _id_0BB8::_id_39D0("idle");
  wait 5;
  level._id_D127.ignoreall = 0;
  level._id_D127.ignoreme = 0;
  level._id_D127 scripts\sp\vehicle::_id_8440();
  level.player.ignoreme = 0;
  level._id_C0B7 = 0;
  _id_0BDC::_id_A1A9(0);
  _id_0BD6::_id_621A();
  scripts\engine\utility::flag_wait_all("defend_mons_vo_complete", "defend_mons_end");
  _id_0BDC::_id_A1AB("missile_drone");
  scripts\sp\utility::_id_2669("defend_mons_end");
}

hs_jackal_music() {
  setmusicstate("");
  wait 0.5;
  setmusicstate("mx_196_heistspace_jackyl");
}

_id_5070() {
  if(!isDefined(level._id_D6E5)) {
    scripts\engine\utility::flag_wait("retribution_arrives_vo_over");
  }

  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  wait 9;
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  level._id_5070 = 1;
  wait 1;
  scripts\sp\utility::_id_1034D("heist_plr_retributionhang");
  scripts\sp\utility::_id_10350("heist_gbs_goforhangarcapt");
  scripts\sp\utility::_id_1034D("heist_plr_bosswereshorton");
  scripts\sp\utility::_id_10350("heist_gbs_icanflyforyousi");
  scripts\sp\utility::_id_10350("heist_gbs_airbornein30");
  scripts\sp\utility::_id_1034D("heist_plr_fairwindslt");
  scripts\sp\utility::_id_10350("heistspace_gbs_thankyoucaptain");
  level._id_5070 = undefined;
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  thread _id_5069();
  var_0 = 1;

  while(level._id_4B96 < var_0) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("current_kill_objective_one");
  level._id_5070 = 1;
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  wait 1;
  scripts\sp\utility::_id_10350("heistspace_eth_hullintegrityis");
  scripts\sp\utility::_id_1034D("heistspace_plr_holdcourseandpr");
  scripts\sp\utility::_id_1034D("heistspace_plr_gatorstatusrepo");
  scripts\sp\utility::_id_10350("heistspace_nav_shesholdingtoge");
  level._id_5070 = undefined;
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  var_0 = 2;

  while(level._id_4B96 < var_0) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("current_kill_objective_two");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  level._id_5070 = 1;
  wait 1;
  scripts\sp\utility::_id_10350("heistspace_gbs_captainbandistonmysix");
  scripts\sp\utility::_id_1034D("heistspace_plr_gibson");
  scripts\sp\utility::_id_10350("heistspace_gbs_ivebeenhitimgoingdown");
  scripts\sp\utility::_id_1034D("heistspace_plr_bossboss");
  level._id_5070 = undefined;
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  var_0 = 3;

  while(level._id_4B96 < var_0) {
    wait 0.1;
  }

  level._id_5070 = 1;
  wait 1;
  scripts\sp\utility::_id_10350("heistspace_nav_captainivelostm");
  scripts\sp\utility::_id_1034D("heistspace_plr_copyprepretfore");
  scripts\sp\utility::_id_10350("heistspace_eth_olympushullinte");
  scripts\sp\utility::_id_1034D("heistspace_plr_affirmwereclose");
  level._id_5070 = undefined;
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\engine\utility::flag_set("defend_mons_vo_complete");
}

_id_5069() {
  level endon("defend_mons_end");
  var_0 = [];
  var_0[var_0.size] = "heistspace_eth_missilesinbound";
  var_0[var_0.size] = "heistspace_eth_multiplebandits";
  var_0[var_0.size] = "heistspace_nav_werelitat310two";
  var_0[var_0.size] = "heistspace_eth_directhitwevelo";
  var_0[var_0.size] = "heistspace_nav_splashsplashche";
  var_0[var_0.size] = "heistspace_eth_wecanttakeanoth";
  var_0[var_0.size] = "heistspace_slt_igottone";
  var_0[var_0.size] = "heistspace_plr_olympuswatchsix";
  var_0[var_0.size] = "heistspace_eth_trackingincomin";
  var_0[var_0.size] = "heistspace_slt_fox3fromtwo";
  var_0[var_0.size] = "heistspace_nav_threatshighrefe";
  var_0[var_0.size] = "heistspace_slt_retsgettinsmack";
  var_0[var_0.size] = "heistspace_nav_shotsout";
  var_0[var_0.size] = "heistspace_plr_fox2fromone";
  var_0[var_0.size] = "heistspace_eth_threatslockedon";
  var_0[var_0.size] = "heistspace_plr_shitdonotdeviat";
  var_0[var_0.size] = "heistspace_eth_portthrustershi";

  while(var_0.size > 0) {
    wait(randomintrange(10, 15));

    if(!isDefined(level._id_5070)) {
      var_1 = scripts\engine\utility::random(var_0);

      if(issubstr(var_1, "plr")) {
        scripts\sp\utility::_id_1034D(var_1);
      } else {
        scripts\sp\utility::_id_10350(var_1);
      }

      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
    }
  }
}

_id_506D() {
  if(!isDefined(level._id_D6E5)) {
    scripts\engine\utility::flag_wait("retribution_ftl_in");
  }

  wait 0.2;
  level._id_EA99.ignoreall = 1;
  level._id_EA99.ignoreme = 1;
  wait 3.0;
  level._id_EA99 _id_0BDC::_id_19AB(250);
  var_0 = getcsplineid("salter_jackal_takeoff_spline_test");
  level._id_EA99 thread _id_0BDC::_id_A1EF(var_0);
  level._id_EA99 _id_0BDC::_id_19B0("fly");
  wait 1;
  level._id_EA99 _id_0BDC::_id_19AB();
  level._id_EA99 _id_0BDC::_id_19AE("shoot_at_will");
  level._id_EA99 waittill("end_spline");
  level._id_EA99 _id_0BDC::_id_19AB();
  level._id_A056._id_1630 = scripts\engine\utility::array_add(level._id_A056._id_1630, level._id_EA99);
  level._id_EA99 _id_0BDC::_id_19A0(0);
  level._id_EA99.ignoreall = 0;
  level._id_EA99.ignoreme = 0;
  level._id_EA99 thread _id_5888();
}

_id_3B88() {
  scripts\engine\utility::flag_set("yard_obj_defend_mons_done");
}

_id_EAA2() {
  level._id_EAA2 = 1;
  scripts\sp\utility::_id_F5AF("jumpto_salter_jackal_hit", [level.player]);
  level._id_D127 = _id_0BDC::_id_1079F("player_jackal", "jumpto_salter_jackal_hit");
  thread _id_0BDC::_id_10CD1(level._id_D127, undefined, "hover");
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_salter_jackal_crash");
  level._id_D127 thread scripts\sp\maps\heistspace\heistspace_fx::_id_132F6();
  scripts\engine\utility::flag_set("defend_mons_begin");
  var_0 = getEnt("salter_jackal", "targetname");
  var_0._id_1084E = 2;
  level._id_EA99 = scripts\sp\vehicle::_id_1080C("salter_jackal");
  level._id_EA99 scripts\sp\vehicle::_id_8441();
  var_1 = scripts\sp\vehicle::_id_1080C("retribution_sd_target");
  wait 0.2;
  var_1.delete_on_death = 1;
  var_1._id_CB55 = _id_4E65();
  var_2 = var_1 _id_0BA9::_id_39AC();
  var_2 thread _id_4E64();
  _id_0BDC::_id_A078((-40, 0, 0), 5);
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_BC27("jackal_crash_begin");
}

_id_EA9F() {
  scripts\engine\utility::flag_set("salter_jackal_hit_begin");
  visionsetalternate(7, 0.5);
  setglobalsoundcontext("atmosphere", "space");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  thread _id_EA9C();
  thread _id_D15C();
  thread _id_EAA3();
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C7(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(1);
  wait 1;
  _id_0BDC::_id_A1AB("enemy_lockon");
  _id_0BDC::_id_A321(0);
  scripts\engine\utility::flag_wait("salter_jackal_hit_end");
  _id_0BDC::_id_A1A9(1);

  while(!istransientloaded("heistspace_crash_tr")) {
    wait 0.05;
    waitforalltransients();
  }
}

_id_EA9C() {
  if(isDefined(level._id_EAA2)) {
    wait 1;
  }

  var_0 = scripts\engine\utility::getStruct("salter_chase_start_struct", "targetname");

  for(;;) {
    if(!_id_0B76::_id_9C19(level._id_EA99)) {
      if(!_id_0B76::_id_9C19(var_0)) {
        break;
      }
    }

    wait 0.1;
  }

  if(isDefined(level._id_EA99)) {
    level._id_EA99 delete();
  }

  level._id_EA99 = scripts\sp\vehicle::_id_1080C("salter_jackal");
  scripts\engine\utility::waitframe();
  level._id_A056._id_1630 = scripts\engine\utility::array_remove(level._id_A056._id_1630, level._id_EA99);
  var_0 = scripts\engine\utility::getStruct("salter_chase_start_struct", "targetname");
  level._id_EA99 vehicle_teleport(var_0.origin, var_0.angles);
  level._id_EA99._id_843F = 1;
  level._id_EA99 _id_0BDC::_id_19AB(400);
  level._id_EA99 thread _id_B05B();
  level._id_EA99.ignoreme = 1;
  level._id_EA99.ignoreall = 1;
  level._id_EA99 _id_0BDC::_id_19A2();
  wait 1;
  level._id_63E7 = scripts\sp\vehicle::_id_1080C("enemy_chase_jackal");
  scripts\engine\utility::waitframe();
  level._id_63E7._id_843F = 1;
  level._id_63E7 _id_0BDC::_id_19AB(400);
  level._id_63E7 thread _id_B05B();
  level._id_63E7.ignoreme = 1;
  level._id_63E7.ignoreall = 1;
  level._id_63E7 _id_0BDC::_id_19A2();
  level._id_63E7 _id_0BDC::_id_1994(level._id_EA99, (-3000, 0, 0), 200, 0.1, 9000, 1.0);
  level._id_63E7 _id_0BDC::_id_19B5(level._id_EA99);
  level._id_63E7 thread _id_0BD1::_id_6892();
  level._id_63E7 thread _id_0BD1::_id_688D();
  level._id_63E7 thread _id_0BD1::_id_688B();
  level._id_EA99 thread _id_0BD1::_id_688A();
  scripts\engine\utility::flag_set("saltar_jackal_hit");
  level thread scripts\sp\utility::_id_12641("heistspace_crash_tr");
  scripts\engine\utility::flag_wait("salter_jackal_hit_vo_complete");
  level._id_63E7 _id_0BDC::_id_A36D();
}

_id_B05B() {
  self endon("death");

  for(;;) {
    var_0 = getcsplineid("end_crash_path");
    thread _id_0BDC::_id_A342(var_0);
    self waittill("end_spline");
    _id_0BDC::_id_19A2();
  }
}

_id_AA72(var_0) {
  level endon("player_jackal_hit");
  var_1 = 1100;
  var_2 = 400;
  var_3 = -1000;
  var_4 = -3500;

  for(;;) {
    var_5 = var_0.origin + anglesToForward(var_0.angles) * var_3;
    var_6 = var_0.origin + anglesToForward(var_0.angles) * var_4;
    var_7 = pointonsegmentnearesttopoint(var_5, var_6, self.origin);
    var_8 = distance(var_5, var_7);
    var_9 = scripts\sp\math::_id_C097(0, abs(var_3 - var_4), var_8);
    var_10 = scripts\sp\math::_id_6A8E(var_2, var_1, var_9);
    _id_0BDC::_id_19AB(var_10);
    wait 0.05;
  }
}

_id_D15C() {
  scripts\engine\utility::flag_wait("salter_jackal_hit_vo_complete");
  var_0 = scripts\engine\utility::getStruct("mons_ret_crash_moveto", "targetname");
  var_1 = 8000;
  thread _id_13951();

  for(;;) {
    level._id_56E8 = distance(var_0.origin, level._id_D127.origin);

    if(level._id_56E8 < var_1) {
      if(!scripts\engine\utility::flag("supply_drone_incoming")) {
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("player_jackal_hit");
  objective_delete(scripts\sp\utility::_id_C264("obj_player_jackal_hit"));
  _id_0BDC::_id_A2D7(0);
  level._id_C0B7 = 1;
  level._id_D127.ignoreall = 1;
  level._id_D127.ignoreme = 1;
  level._id_D127 _id_0BDC::_id_A19D();
  level.player _meth_80D1();
  level._id_D127 scripts\engine\utility::delaythread(0.05, _id_0BDC::_id_A10D, "incoming_missile");
  wait 0.75;
  level._id_D127 dodamage(15000, level._id_D127.origin, undefined, undefined, "MOD_EXPLOSIVE");
  wait 0.75;
  level._id_D127 dodamage(15000, level._id_D127.origin, undefined, undefined, "MOD_EXPLOSIVE");
  earthquake(0.5, 1, level.player.origin, 120);
  level._id_D127 playRumbleOnEntity("light_2s");
  level.player.health = level.player.maxhealth;
  scripts\engine\utility::flag_set("salter_jackal_hit_end");
}

_id_13951() {
  level endon("player_jackal_hit");

  for(;;) {
    level._id_D127 waittill("drone_dropzone_marked");
    scripts\engine\utility::flag_set("supply_drone_incoming");
    level._id_D127 waittill("missiles_restocked");
    wait 1;
    scripts\engine\utility::flag_clear("supply_drone_incoming");
    scripts\engine\utility::waitframe();
  }
}

_id_EAA3() {
  scripts\engine\utility::flag_wait("saltar_jackal_hit");
  scripts\sp\utility::_id_10350("heistspace_slt_gettinthrashed");
  scripts\engine\utility::flag_set("yard_obj_defend_mons_done");
  scripts\engine\utility::flag_set("salter_jackal_hit_vo_complete");
  scripts\sp\utility::_id_1034D("heistspace_plr_standbysaltimhe");
  setmusicstate("");
  thread _id_EAA0();
  thread _id_EAA1();
  scripts\engine\utility::flag_wait("player_jackal_hit");
  scripts\sp\utility::_id_10350("heistspace_slt_reyeswatchyours");
}

_id_EAA0() {
  if(scripts\engine\utility::flag("player_jackal_hit")) {
    return;
  }
  level endon("player_jackal_hit");
  var_0 = scripts\engine\utility::getStruct("mons_ret_crash_moveto", "targetname");
  var_1 = 12000;

  for(;;) {
    if(_id_0B76::_id_9C19(level._id_EA99)) {
      var_1 = 12000;

      if(distance(var_0.origin, level._id_D127.origin) > var_1) {
        if(!isDefined(level._id_EAA9)) {
          level._id_EAA9 = 1;
          scripts\sp\utility::_id_1034D("heistspace_plr_saltimvisual");
          level._id_EAA9 = undefined;
          break;
        }
      }
    }

    wait 0.1;
  }
}

_id_EAA1() {
  level endon("player_jackal_hit");
  var_0 = [];
  var_0[var_0.size] = "ja_mining_slt_throttleupicant";
  var_0[var_0.size] = "ja_mining_slt_hesonmysix";
  var_0[var_0.size] = "ja_mining_slt_thisguysgood";
  var_0[var_0.size] = "mn_jck_slt_needmywingmanouthere";
  var_0[var_0.size] = "heistspace_eth_captainbanditsa";

  while(var_0.size > 0) {
    wait(randomintrange(10, 15));

    if(!isDefined(level._id_EAA9)) {
      var_1 = scripts\engine\utility::random(var_0);
      level._id_EAA9 = 1;
      scripts\sp\utility::_id_10350(var_1);
      level._id_EAA9 = undefined;
      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
    }
  }
}

_id_104BD() {
  if(isDefined(level._id_39DD)) {
    level._id_39DD = undefined;
  }

  var_0 = getEnt("missile_scriptable_holding_clip", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }

  thread _id_104CC();

  if(isDefined(level._id_A132)) {
    return;
  }
  thread _id_13E8D();
  thread _id_A121();
  level._id_39DD["cannon_flak_ca"]._id_4D1E.fx._id_BDFF = "capital_turret_flak_cheap_moving";
  level._id_39DD["cannon_flak_ca"]._id_4D1E.fx._id_11A7B = "capital_turret_flak_cheap_moving";
  scripts\engine\utility::flag_wait("defend_mons_begin");
  thread _id_588A();
}

_id_104CC() {
  scripts\engine\utility::waitframe();

  if(!isDefined(level._id_D6F2)) {
    scripts\engine\utility::flag_wait("player_near_ordnance_exit");
  }

  level._id_C413 _id_0BB8::_id_39CD("heavy");
  level._id_C413 _id_0BB8::_id_39D0("off");
  level._id_C413 _id_0BB8::_id_39CE("off");

  if(!isDefined(level._id_D6E5)) {
    scripts\engine\utility::flag_wait("player_entering_jackal");
    wait 1;
  }

  level._id_C413 thread _id_0BA9::_id_39C9();
}

_id_A121() {
  level._id_A121 = [];
  var_0 = getEnt("jackal_combat_destroyer_1", "targetname");
  var_0._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx";
  level._id_A11D = scripts\sp\vehicle::_id_1080C("jackal_combat_destroyer_1");
  scripts\engine\utility::waitframe();
  level._id_A11D thread _id_A120();
  level._id_A121 = scripts\engine\utility::add_to_array(level._id_A121, level._id_A11D);
  var_1 = getEnt("jackal_combat_destroyer_2", "targetname");
  var_1._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx";
  level._id_A11E = scripts\sp\vehicle::_id_1080C("jackal_combat_destroyer_2");
  scripts\engine\utility::waitframe();
  level._id_A11E thread _id_A120();
  level._id_A121 = scripts\engine\utility::add_to_array(level._id_A121, level._id_A11E);

  if(!isDefined(level._id_D6E5)) {
    scripts\engine\utility::flag_wait("player_entering_jackal");
    wait 4;
  }

  var_2 = getEnt("jackal_combat_destroyer_3", "targetname");
  var_2._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx";
  level._id_A11F = scripts\sp\vehicle::_id_1080C("jackal_combat_destroyer_3");
  scripts\engine\utility::waitframe();
  level._id_A11F thread _id_A120();
  level._id_A121 = scripts\engine\utility::add_to_array(level._id_A121, level._id_A11F);
}

_id_A120() {
  wait 1;
  self._id_CB55 = _id_4E65();
  _id_0BB8::_id_39CD("heavy");
  _id_0BB8::_id_39D0("off");
  _id_0BB8::_id_39CE("high");
  self._id_B904 = "veh_mil_air_ca_destroyer";
  thread _id_0B53::_id_B909();

  if(!isDefined(level._id_D6F2)) {
    if(self == level._id_A11D || self == level._id_A11E) {
      _id_0BB6::_id_39E1();
      self._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,1,1,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7 cannon_flak_ca,1,1,amb_turret_r_1,amb_turret_r_2,amb_turret_r_3 cannon_phalanx";
      self._id_12FBA = 1;
      _id_0BB6::_id_39E8();

      if(self == level._id_A11D) {
        self._id_9033 = scripts\engine\utility::getStructArray("olympus_mons_back_hit_pos", "targetname");
      }

      if(self == level._id_A11E) {
        self._id_9033 = scripts\engine\utility::getStructArray("olympus_mons_front_hit_pos", "targetname");
      }

      scripts\engine\utility::waitframe();
      thread _id_3988(6, 8);
      thread _id_0BB6::_id_398A(1);
      thread _id_0BB6::_id_39F0();
      scripts\engine\utility::flag_wait("player_entering_jackal");
      thread _id_0BB6::_id_398A(0);
      thread _id_0BB6::_id_39F1();
      level notify("end_capitalship_fire_on_mons");
    }
  }

  if(self == level._id_A11E) {
    self._id_EEF9 = "cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx";
    _id_0BAD::_id_F030(0, 1, self._id_EEF9);
    var_0 = ["ship_exterior_ca_turret_missile_b_01_dst", "ship_exterior_ca_turret_missile_b_02_dst", "ship_exterior_ca_turret_missile_b_03_dst", "ship_exterior_ca_turret_missile_b_04_dst"];
    var_1 = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_l_3", "amb_missile_l_4", "amb_missile_l_5", "amb_missile_l_6", "amb_missile_l_7", "amb_missile_l_8", "amb_missile_l_9", "amb_missile_l_10", "amb_missile_l_11", "amb_missile_l_12", "amb_missile_r_1", "amb_missile_r_2", "amb_missile_r_3", "amb_missile_r_4", "amb_missile_r_5", "amb_missile_r_6", "amb_missile_r_7", "amb_missile_r_8", "amb_missile_r_9", "amb_missile_r_10", "amb_missile_r_11", "amb_missile_r_12"];
    self._id_4DE9 = [];

    foreach(var_3 in var_1) {
      var_4 = spawn("script_model", self gettagorigin(var_3));
      var_4.angles = self gettagangles(var_3);
      var_5 = scripts\engine\utility::random(var_0);
      var_4 setModel(var_5);
      self._id_4DE9 = scripts\engine\utility::add_to_array(self._id_4DE9, var_4);
      scripts\engine\utility::noself_delaycall(randomfloatrange(0.1, 1.0), ::playfxontag, scripts\engine\utility::getfx("capital_turret_smolder_smt"), var_4, "tag_origin");
    }
  } else
    _id_0BAD::_id_F030(0, 1);

  self._id_12FBA = 1;

  if(!isDefined(level._id_D6F2)) {
    scripts\engine\utility::flag_wait("defend_mons_begin");
  }

  if(self != level._id_A11E) {
    if(self == level._id_A11D) {
      self._id_9033 = [level._id_C413];
    } else {
      self._id_9033 = [level._id_C413, level._id_E35D];
    }

    thread _id_3988(12, 16);
  }

  thread _id_13759();
  thread scripts\sp\maps\heistspace\heistspace_util::_id_FD3C();
  scripts\engine\utility::flag_wait("player_jackal_hit");

  if(isDefined(self)) {
    _id_0BA9::_id_3985(0);
    self notify("predeath");
  }

  scripts\engine\utility::flag_wait("salter_jackal_hit_end");

  if(isDefined(self)) {
    _id_0BA9::_id_397B();
  }
}

_id_3988(var_0, var_1) {
  self endon("death");
  level endon("end_capitalship_fire_on_mons");

  if(!isDefined(self._id_9033)) {
    return;
  }
  for(;;) {
    var_2 = scripts\engine\utility::random(self._id_9033);
    var_3 = self._id_8B51["cap_hardpoint_missile_barrage"];

    if(_id_0BA9::_id_396A(var_2, self._id_9278)) {
      thread _id_0BB6::_id_39A0(var_2, var_3, 3);
    }

    wait(randomfloatrange(var_0, var_1));
  }
}

_id_13E8D() {
  scripts\engine\utility::waitframe();

  if(isDefined(level._id_D6F2)) {
    return;
  }
  scripts\sp\utility::_id_22CA("zerog_ambient_enemy_jackal", ::_id_13E8C, "patrol", "zerog_ambient_jackal_paths");
  level._id_26EB = spawnStruct();
  level._id_26EB thread scripts\sp\maps\heistspace\heistspace_util::_id_B2DA("zerog_ambient_enemy_jackal", 10, -1, undefined, undefined, undefined, "zerog_ambient_jackals_done", 1);

  foreach(var_1 in level._id_26EB._id_FE2D) {
    if(isDefined(var_1)) {
      var_1 _id_0BDC::_id_19AB();
    }
  }

  level waittill("player_entering_jackal");
  level notify("zerog_ambient_jackals_done");
  scripts\engine\utility::waitframe();

  foreach(var_1 in level._id_26EB._id_FE2D) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

_id_13E8C(var_0, var_1) {
  self endon("death");

  if(isDefined(var_0) && isDefined(var_1)) {
    _id_0BDC::_id_19B3(var_0, var_1);
    _id_0BDC::_id_19B4(var_0);
    _id_0BDC::_id_1990(1);
  }

  _id_0BDC::_id_19AE("shoot_at_will");
  thread _id_A333();
}

_id_588A() {
  if(!isDefined(level._id_26EB)) {
    level._id_26EB = spawnStruct();
  }

  if(!isDefined(level._id_1D0A)) {
    level._id_1D0A = spawnStruct();
  }

  level._id_26EB._id_FE2D = [];
  level._id_1D0A._id_FE2D = [];
  level._id_26EB._id_E87D = 0;
  level._id_1D0A._id_E87D = 0;
  level._id_B74A = 2;
  var_0 = undefined;

  if(!isDefined(level._id_EAA2)) {
    thread _id_588D();
    wait 2;
    scripts\sp\utility::_id_22CA("dogfight_enemy_jackal_ace", ::_id_5888);
    var_0 = scripts\sp\vehicle::_id_1080E("dogfight_enemy_jackal_ace");
  }

  scripts\sp\utility::_id_22CA("dogfight_enemy_jackal", ::_id_5888);
  level._id_26EB thread scripts\sp\maps\heistspace\heistspace_util::_id_B2DA("dogfight_enemy_jackal", 8, -1, undefined, undefined, undefined, "jackal_dogfight_done");
  level notify("enemy_jackals_spawned_in");

  if(!isDefined(level._id_EAA2)) {
    level scripts\engine\utility::waittill_notify_or_timeout("release_ally_jackals", 12.5);
  }

  scripts\sp\utility::_id_22CA("dogfight_ally_jackal", ::_id_5888);
  level._id_1D0A thread scripts\sp\maps\heistspace\heistspace_util::_id_B2DA("dogfight_ally_jackal", 3, -1, undefined, 1, undefined, "jackal_dogfight_done");
  wait 3;

  if(isDefined(var_0)) {
    scripts\engine\utility::array_thread(var_0, _id_0BDC::_id_A36D);
  }

  level._id_A1A4 = [];
  level._id_A1A1 = [];
  level._id_A1A0 = [];
  level._id_A1DE = [];

  foreach(var_2 in level._id_A056._id_1630) {
    if(var_2.classname == "script_vehicle_jackal_enemy_semiace") {
      level._id_A1A4 = scripts\engine\utility::add_to_array(level._id_A1A4, var_2);
    }

    if(var_2.classname == "script_vehicle_jackal_enemy_ace") {
      level._id_A1A1 = scripts\engine\utility::add_to_array(level._id_A1A1, var_2);
    }

    if(var_2.classname == "script_vehicle_jackal_enemy") {
      level._id_A1A0 = scripts\engine\utility::add_to_array(level._id_A1A0, var_2);
    }

    if(var_2.classname == "script_vehicle_jackal_friendly") {
      level._id_A1DE = scripts\engine\utility::add_to_array(level._id_A1DE, var_2);
    }
  }

  scripts\engine\utility::flag_wait("jackal_crash_begin");
  level notify("jackal_dogfight_done");
  scripts\engine\utility::waitframe();

  foreach(var_2 in level._id_26EB._id_FE2D) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }

  foreach(var_2 in level._id_1D0A._id_FE2D) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }

  wait 2;
  level._id_A056._id_1630 = scripts\engine\utility::array_remove(level._id_A056._id_1630, level._id_EA99);

  foreach(var_2 in level._id_A056._id_1630) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }

  if(isDefined(level._id_EA99)) {
    level._id_EA99 delete();
  }
}

_id_506C() {
  level._id_4B8A = 0;
  level._id_4B37 = 0;
  level._id_4B64 = 0;
  level._id_4B96 = 0;
  level._id_B443 = 3;
  level._id_B418 = 3;
  level._id_B42C = 3;
  level._id_B448 = level._id_B443 + level._id_B418 + level._id_B42C;
  level._id_10D0E = 0;
  level waittill("enemy_jackals_spawned_in");
  wait 2;
  _id_0B76::_id_16FE(0, "jackal_objective_aces", 3);
  thread _id_506B(0, "max_ace_kill_count_reached");
  scripts\engine\utility::flag_wait("max_ace_kill_count_reached");
  _id_0B76::_id_16FE(1, "jackal_objective_skelters");
  _id_0B76::_id_16FE(2, "jackal_objective_destroyers", 3);
  _id_0B76::_id_F432(2, level._id_4B64);
  thread _id_506B(2, "max_destroyer_kill_count_reached");
  scripts\engine\utility::flag_wait("start_salter_chase_moment");
  wait 5;
  scripts\engine\utility::flag_set("defend_mons_end");
  scripts\engine\utility::flag_wait("salter_jackal_hit_vo_complete");
  _id_0B76::_id_8E93(0);
  _id_0B76::_id_8E93(1);
  _id_0B76::_id_8E93(2);
}

_id_506B(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_1);
  _id_0B76::_id_4474(var_0);
}

_id_506A() {
  level endon("start_salter_chase_moment");
  scripts\engine\utility::flag_wait_all("max_ace_kill_count_reached", "max_jackal_kill_count_reached", "max_destroyer_kill_count_reached");
  scripts\engine\utility::flag_set("max_objective_kill_count_reached");
}

_id_588D() {
  if(!isDefined(level._id_D6E5)) {
    scripts\engine\utility::flag_wait("retribution_ftl_in");
  }

  wait 2.0;
  scripts\sp\utility::_id_22CA("salter_dogfight_leadin_jackal", ::_id_588E, "salter_dogfight_leadin_jackal");
  var_0 = scripts\sp\vehicle::_id_1080C("salter_dogfight_leadin_jackal");
  level._id_26EB._id_FE2D = scripts\engine\utility::array_add(level._id_26EB._id_FE2D, var_0);
  level._id_26EB._id_E87D++;
  scripts\sp\utility::_id_22CA("player_dogfight_leadin_jackal", ::_id_588E, "player_dogfight_leadin_jackal");
  var_1 = scripts\sp\vehicle::_id_1080C("player_dogfight_leadin_jackal");
  level._id_26EB._id_FE2D = scripts\engine\utility::array_add(level._id_26EB._id_FE2D, var_1);
  level._id_26EB._id_E87D++;
  wait 1.5;
  var_1 thread _id_0BDC::_id_A36D();
}

_id_588E(var_0) {
  self endon("death");
  thread _id_5888();

  if(!isDefined(level._id_EAA2)) {
    self.ignoreall = 1;
    self.ignoreme = 1;
    _id_0BDC::_id_19AB(450);
    _id_0BDC::_id_19A0(1);
    wait 5;
    _id_0BDC::_id_19AB();

    if(isDefined(var_0) && var_0 == "player_dogfight_leadin_jackal") {
      scripts\sp\vehicle::_id_8441();
      scripts\engine\utility::delaythread(7, scripts\sp\vehicle::_id_8440);
      self waittill("release_ally_jackals");
      level notify("release_ally_jackals");
      _id_0BDC::_id_19AE("shoot_forever");
      scripts\engine\utility::waittill_notify_or_timeout("jackal_stop_shooting", 5);
      _id_0BDC::_id_19AE("shoot_at_will");
    }

    self waittill("end_spline");
    self.ignoreall = 0;
    self.ignoreme = 0;
    _id_0BDC::_id_19A0(0);
  }
}

_id_5888() {
  self endon("death");

  if(!isDefined(level._id_5882)) {
    level._id_5882 = 0;
  }

  level._id_5882++;

  if(isDefined(self.team) && self.team == "ally") {
    scripts\sp\vehicle::_id_8441();
  } else {
    thread _id_13759();
    thread _id_A333();
  }

  if(isDefined(self.target)) {
    var_0 = scripts\sp\utility::_id_7C9A(self.target);
    thread _id_0BDC::_id_A1EF(var_0);
    self waittill("end_spline");
  }

  _id_0BDC::_id_19B3("patrol", "dogfight_path");
  _id_0BDC::_id_19B3("escape", "dogfight_path");
  _id_0BDC::_id_1990(1);
  _id_0BDC::_id_19AE("shoot_at_will");
  wait 1;
  _id_0BDC::_id_19AB();
}

_id_A333() {
  self endon("death");

  for(;;) {
    if(isDefined(self.team) && self.team == "axis") {
      self waittill("axis_start_shooting");
      _id_0BDC::_id_19AE("shoot_forever");

      if(scripts\engine\utility::cointoss()) {
        thread _id_A332();
      }

      _id_0BDC::_id_19B5(level._id_C413);
      self waittill("axis_stop_shooting");
      _id_0BDC::_id_19AE("shoot_at_will");
      _id_0BDC::_id_198A();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_A332() {
  self endon("death");
  self endon("axis_stop_shooting");
  var_0 = "tag_flash_right";
  thread _id_0B76::_id_1992(var_0, level._id_C413);
  var_0 = "tag_flash_left";
  thread _id_0B76::_id_1992(var_0, level._id_C413);
  wait(randomintrange(2, 5));
  var_0 = "tag_flash_right";
  thread _id_0B76::_id_1992(var_0, level._id_C413);
  var_0 = "tag_flash_left";
  thread _id_0B76::_id_1992(var_0, level._id_C413);
}

_id_13759() {
  self waittill("death", var_0, var_1, var_2);
  var_3 = self.classname;

  if(isDefined(self._id_4DE9)) {
    foreach(var_5 in self._id_4DE9) {
      if(isDefined(var_5)) {
        killfxontag(scripts\engine\utility::getfx("capital_turret_smolder_smt"), var_5, "tag_origin");
        var_5 delete();
      }
    }
  }

  if(isDefined(level._id_EAA2)) {
    return;
  }
  if(isDefined(var_3)) {
    if(var_3 == "script_vehicle_jackal_enemy_ace") {
      if(!scripts\engine\utility::flag("max_ace_kill_count_reached")) {
        level._id_4B37++;
        level._id_4B96++;
        _id_0B76::_id_F432(0, level._id_4B37);

        if(level._id_4B37 >= level._id_B418) {
          scripts\engine\utility::flag_set("max_ace_kill_count_reached");
        }

        thread _id_506E();
      }
    }

    if(var_3 == "script_vehicle_jackal_enemy" || var_3 == "script_vehicle_jackal_enemy_semiace") {
      if(isDefined(var_0) && (var_0 == level.player || var_0 == level._id_D127)) {
        if(!scripts\engine\utility::flag("max_jackal_kill_count_reached")) {
          level._id_4B8A++;
          level._id_4B96++;
          _id_0B76::_id_F432(1, level._id_4B8A);

          if(level._id_4B8A >= level._id_B443) {
            scripts\engine\utility::flag_set("max_jackal_kill_count_reached");
          }

          thread _id_506E();
        }
      }
    }

    if(var_3 == "script_vehicle_capitalship_destroyer_ca") {
      if(!scripts\engine\utility::flag("max_destroyer_kill_count_reached")) {
        level._id_4B64++;
        level._id_4B96++;
        _id_0B76::_id_F432(2, level._id_4B64);

        if(level._id_4B64 >= level._id_B42C) {
          scripts\engine\utility::flag_set("max_destroyer_kill_count_reached");
          level._id_A121 = scripts\engine\utility::array_remove(level._id_A121, self);

          foreach(var_8 in level._id_A121) {
            if(isDefined(var_8)) {
              self._id_CB55 = _id_4E65();
            }
          }
        }
      }

      foreach(var_11 in level._id_A056._id_1630) {
        if(isDefined(var_11)) {
          if(distancesquared(self.origin, var_11.origin) < 36000000) {
            if(isDefined(var_11.team) && var_11.team == "axis") {
              if(var_11.classname == "script_vehicle_jackal_enemy" || var_11.classname == "script_vehicle_jackal_enemy_semiace") {
                var_11 _meth_81D0();
              }
            }
          }
        }
      }

      scripts\sp\utility::_id_2669("defend_mons");
    }

    if(scripts\engine\utility::flag("max_ace_kill_count_reached")) {
      if(isDefined(var_3) && var_3 == "script_vehicle_capitalship_destroyer_ca" || isDefined(var_0) && (var_0 == level.player || var_0 == level._id_D127)) {
        level._id_10D0E++;
        scripts\engine\utility::waitframe();

        if(level._id_10D0E >= 2) {
          if(!scripts\engine\utility::flag("start_salter_chase_moment")) {
            scripts\engine\utility::flag_set("start_salter_chase_moment");
          }
        }
      }
    }
  }
}

_id_506E() {
  level endon("player_jackal_hit");

  if(!isDefined(level._id_A5C9)) {
    level._id_A5C9 = 0;
  }

  level._id_A5C9++;

  if(level._id_A5C9 >= 2) {
    scripts\sp\utility::_id_2669("defend_mons");
    level._id_A5C9 = undefined;
  }
}