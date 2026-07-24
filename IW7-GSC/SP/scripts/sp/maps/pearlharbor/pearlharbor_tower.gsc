/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_tower.gsc
*************************************************************/

_id_C9E4() {
  scripts\engine\utility::flag_init("stop_revolving_door_bullets");
  scripts\engine\utility::flag_init("tower_base_completed");
  scripts\engine\utility::flag_init("fail_hvt_asap");
  scripts\engine\utility::flag_init("move_hvt_guys_to_spots");
  scripts\engine\utility::flag_init("start_hvt_scripting");
  scripts\engine\utility::flag_init("fountain_enemies_dead");
  scripts\engine\utility::flag_init("tower_lockdown");
  scripts\engine\utility::flag_init("breach_started");
  scripts\engine\utility::flag_init("fountain_vo_done");
  scripts\engine\utility::flag_init("slow_motion");
  scripts\engine\utility::flag_init("ok_to_delete_hill_AI");
  scripts\engine\utility::flag_init("nextmission_preload_started");
  scripts\engine\utility::flag_init("tower_jackal_used");
  scripts\engine\utility::flag_init("hvt_pip_bink_done");
  scripts\engine\utility::flag_init("tower_objective_complete");
  scripts\sp\utility::_id_22CA("towerbase_spawner", ::_id_1064D);
  scripts\sp\utility::_id_22CA("towerbase_spawner_bot", ::_id_1064D);
  scripts\sp\utility::_id_22CA("hvt_foyer_corpse", ::_id_922F);
  precachestring(&"PHSTREETS_CORE_OVERHEAT");
  precachestring(&"PHSTREETS_KILLED_HVT");
  scripts\sp\utility::_id_16EB("killed_hvt", &"PHSTREETS_KILLED_HVT");
  precachemodel("door_double_govt_01_closed");
  precachemodel("door_double_govt_01_left");
  precachemodel("door_double_govt_01_right");
}

_id_11A66() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_tower_entrance");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("heavy_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_tower_entrance", var_0);
  thread _id_11A6A();

  foreach(var_2 in level.allies) {
    var_2 scripts\sp\utility::_id_61C7();
    var_2 scripts\sp\utility::_id_F3B5("g");
  }

  thread _id_1D29();
  scripts\engine\utility::flag_set("improved_towerbase_spawning_flag");
}

_id_11A65() {
  thread _id_935A();
  scripts\sp\utility::_id_15F5("pre_shatter_positions_trig");
  thread _id_F8E5();
  thread _id_132A0();
  thread _id_13BE9();
  thread _id_E4C0();
  var_0 = getEnt("lot_jackal_statue", "targetname");
  var_0 setModel("decor_aatis_tower_globe_01");
  var_1 = getaiarray("axis");
  var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_F3E6(0);

  thread _id_A33E();
  thread _id_9230();
  scripts\engine\utility::flag_wait("stop_revolving_door_bullets");
  var_1 = getaiarray("axis");
  var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

  while(var_1.size > 3 && !scripts\engine\utility::flag("hvt_intro_start_flag")) {
    var_1 = getaiarray("axis");
    var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

    if(scripts\engine\utility::flag("bugging_out") && scripts\engine\utility::flag("tower_jackal_used")) {
      var_5 = scripts\engine\utility::getStruct("special_lot_streak_node", "targetname");

      if(isDefined(level._id_10949) && level._id_10949 == var_5) {
        break;
      }
    }

    wait 1;
  }

  if(!scripts\engine\utility::flag("bugging_out") && isDefined(level._id_A351))
    level._id_A351 thread _id_0E40::bufferedweapons();

  scripts\engine\utility::flag_clear("special_jackal_streak_path");
  var_1 = getaiarray("axis");
  var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_B14F) && var_3._id_B14F)
      var_3 scripts\sp\utility::_id_1101B();

    var_3 _meth_81D0();
  }

  thread _id_0E40::_id_1100F();
  level.player scripts\sp\utility::_id_11425();
  scripts\engine\utility::flag_set("tower_base_completed");
  thread _id_D6B7();

  foreach(var_3 in level.allies)
  var_3 _meth_82EE(getnode("hvt_door_stackup_" + var_3._id_1FBB, "targetname"));

  var_10 = getaiarray("allies");
  var_10 = scripts\engine\utility::array_remove_array(var_10, level.allies);

  foreach(var_3 in var_10) {
    var_3 scripts\sp\utility::_id_414F();
    var_3 scripts\sp\utility::_id_F3B5("r");
  }

  scripts\engine\utility::flag_wait("finish_parking_lot");
}

_id_9230() {
  scripts\engine\utility::flag_wait("start_revolving_door_fire");
  scripts\sp\utility::_id_22CD("hvt_foyer_corpse");
}

_id_935A() {
  scripts\engine\utility::flag_wait("improved_towerbase_spawning_flag");
  var_0 = getaiarray("axis");
  var_1 = getspawnerarray();
  var_2 = [405, 402, 400, 404, 403, 410, 401, 408, 407, 409, 406];
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(isDefined(var_5._id_EDF7) && scripts\engine\utility::array_contains(var_2, var_5._id_EDF7)) {
      var_5.count = 0;
      var_5 delete();
      var_3++;
    }
  }

  var_3 = 0;

  foreach(var_8 in var_0) {
    var_9 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), var_8.origin);

    if(var_9 < 0.2) {
      var_8 _meth_81D0();
      var_3++;
      continue;
    }

    if(var_9 < 0.5 && scripts\engine\utility::cointoss()) {
      var_10 = anglestoleft(level.player.angles) * 128 + (0, 0, 90);
      magicbullet("iw7_ake", var_10, var_8 gettagorigin("tag_eye"));
      var_8 scripts\engine\utility::delaycall(randomfloatrange(0.1, 0.5), ::_meth_81D0);
      var_3++;
    }
  }

  wait 0.65;
  var_0 = getaiarray("axis");

  foreach(var_8 in var_0)
  var_8 thread _id_8F9B();

  var_14 = getspawnerarray("towerbase_spawner");
  var_15 = getspawnerarray("towerbase_spawner_bot");
  var_16 = scripts\sp\utility::_id_22A2(var_14, var_15);

  foreach(var_5 in var_16)
  var_8 = var_5 scripts\sp\utility::_id_10619(1);
}

_id_8F9B() {
  self endon("death");

  for(var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin); var_0 > 0.2; var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin))
    wait 0.1;

  var_1 = ["tag_eye", "j_spine4", "tag_inhand"];
  var_2 = randomintrange(4, 8);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = self gettagorigin(var_1[randomintrange(0, var_1.size)]);
    magicbullet("iw7_ake", var_4 + (128, 128, 16), var_4);
    wait(randomfloatrange(0.05, 0.2));
  }

  self _meth_81D0();
}

_id_A33E() {
  for(;;) {
    var_0 = scripts\engine\utility::getStruct("special_lot_streak_node", "targetname");

    if(isDefined(level._id_A351) && isDefined(level._id_10949) && level._id_10949 == var_0) {
      break;
    }

    wait 0.05;
  }

  thread _id_F5D1();
  _id_0E40::_id_F42A("parking_lot_fly_volume");
  thread _id_B837();
  _id_3A4A();
  thread _id_436B();
}

_id_1D29() {
  var_0 = getspawnerarray("towerbase_redshirt");

  foreach(var_2 in var_0)
  var_2.fixednode = 1;

  scripts\sp\utility::_id_6F54(var_0);
}

_id_D6B7() {
  wait 1;
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_clear");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_allclear");
  var_0 = _id_53C2();

  if(isDefined(var_0))
    var_0 scripts\sp\utility::_id_10347("phstreets_unm_sirmultiplesdfb");
  else
    scripts\sp\utility::_id_10350("phstreets_unm_sirmultiplesdfb");

  level.player scripts\sp\utility::_id_10350("phstreets_plr_rogersetupaperi");
  scripts\engine\utility::flag_set("fountain_vo_done");
}

_id_53C2() {
  var_0 = getaiarray("allies");
  var_0 = scripts\engine\utility::array_remove_array(var_0, level.allies);
  var_0 = sortbydistance(var_0, level.player.origin);
  return var_0[0];
}

_id_11A6D() {
  var_0 = scripts\engine\utility::getStruct("tower_doors_close", "targetname");
  scripts\engine\utility::flag_wait("start_hvt_scripting");
  var_1 = scripts\engine\utility::getStruct("hvt_breach_interact", "targetname");
  var_2 = 2250000;
  var_3 = getEnt("in_tower_trigger", "targetname");
  var_4 = scripts\engine\utility::array_add(level.allies, level.player);
  var_5 = 0;

  while(!var_5) {
    wait 0.1;
    var_5 = 1;

    foreach(var_7 in var_4) {
      if(!var_7 istouching(var_3))
        var_5 = 0;
    }
  }

  thread _id_11A5D();
  scripts\engine\utility::flag_set("tower_lockdown");
  var_9 = ["geneva_periph_lake_tr", "geneva_periph_south_tr", "phstreets_hill_tr", "phstreets_tower_ex_tr"];
  scripts\sp\utility::_id_12651(var_9);
  wait 1.0;
  thread _id_923B();
  scripts\engine\utility::flag_wait("breach_started");
  var_9 = ["phstreets_fountain_tr", "phstreets_tower_tr"];
  scripts\sp\utility::_id_12651(var_9);
}

tower_doors_spawn() {
  var_0 = scripts\engine\utility::getStruct("tower_doors_close", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel(var_0.script_noteworthy);
  scripts\engine\utility::flag_wait("phstreets_tower_tr_loaded");
  var_1 delete();
  thread _id_11A5E();
}

_id_11A5E() {
  var_0 = scripts\engine\utility::getStructArray("tower_doors_open", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_5978 = spawn("script_model", var_2.origin);
    var_2._id_5978.angles = var_2.angles;
    var_2._id_5978 setModel(var_2.script_noteworthy);
  }
}

_id_11A5D() {
  var_0 = scripts\engine\utility::getStructArray("tower_doors_open", "targetname");

  foreach(var_3, var_2 in var_0) {
    if(var_3 == 0) {
      var_2._id_5978 rotateYaw(150, 0.5, 0, 0.25);
      continue;
    }

    var_2._id_5978 rotateYaw(-145, 0.5, 0, 0.25);
  }

  var_4 = scripts\engine\utility::getStruct("tower_doors_close", "targetname");
  var_5 = var_4 scripts\engine\utility::get_target_ent();
  var_5 moveTo(var_4.origin, 0.01, 0, 0);
  wait 0.2;
  var_5 disconnectPaths();
  scripts\engine\utility::flag_set("ok_to_delete_hill_AI");
  scripts\engine\utility::flag_wait("breach_started");
  var_6 = scripts\engine\utility::getStruct("tower_inner_doors_close", "targetname");
  var_7 = spawn("script_model", var_6.origin);
  var_7.angles = var_6.angles;
  var_7 setModel(var_4.script_noteworthy);
  var_5 moveTo(var_6.origin, 0.01, 0, 0);
  wait 0.05;
  var_5 disconnectPaths();
}

_id_F5D1() {
  wait 1;
  level._id_A29E["cooldown"] = 15;
  level._id_A29E["FOV"] = undefined;
  level._id_A29E["max_enemies"] = undefined;
  level._id_A29E["accuracy"] = undefined;
  level._id_A29E["max_time_up"] = undefined;
  level._id_A29E["max_target_dist"] = undefined;
  level._id_A29E["min_target_dist"] = undefined;
  level._id_A29E["bDontFindMore"] = undefined;
  scripts\engine\utility::flag_set("jackal_cooldown_updated");
}

_id_3A4A() {
  var_0 = getEntArray("lot_script_car", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_DAF0();
}

_id_B837() {
  level endon("tower_base_completed");
  scripts\engine\utility::flag_wait("jackal_shooting");
  level endon("bugging_out");
  wait 3;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2) && var_2.unittype == "c6" && distance2d(level.player.origin, var_2.origin) >= 175) {
      level._id_A351 _id_0BDC::_id_B156(1, var_2, 0.05, 384);
      wait 0.5;
    }
  }
}

_id_DAF0() {
  self setCanDamage(1);
  var_0 = getEnt(self.target, "targetname");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_1FBB = var_3.script_noteworthy;
    var_3 scripts\sp\anim::_id_F64A();
    var_3.clip = var_3 scripts\engine\utility::get_target_ent();
    var_3.clip linkTo(var_3);
    var_3.clip connectpaths();
  }

  var_0 scripts\sp\anim::_id_1EC1(var_1, "crate_explode");

  for(;;) {
    self waittill("damage", var_5, var_5, var_5, var_5, var_5, var_5, var_5, var_5, var_5, var_6);

    if(isDefined(var_6) && var_6 == "magic_spaceship_20mm_bullet") {
      break;
    }
  }

  var_0 scripts\sp\anim::_id_1F2C(var_1, "crate_explode");

  foreach(var_3 in var_1)
  var_3.clip disconnectPaths();
}

_id_436B() {
  var_0 = getEnt("lot_jackal_statue", "targetname");
  var_0._id_1FBB = "lot_statue";
  var_0 setModel("decor_aatis_tower_globe_01");
  var_1 = getEnt("tower_statue_clip", "targetname");
  var_1 linkTo(var_0, "j_base");
  scripts\engine\utility::flag_wait("jackal_shooting");
  game["phstreets_"] = 1;
  wait 2;
  var_0 scripts\sp\anim::_id_F64A();
  thread _id_7340();
  level._id_A351 _id_0BDC::_id_B156(3, var_0, 0.05, 384);
  var_0 playSound("phstreets_tower_statue_topple");
  var_0 scripts\sp\anim::_id_1F35(var_0, "statue_collapse");
  createnavrepulsor("statue", 0, var_0, 384);
  var_1 disconnectPaths();
}

_id_7340() {
  wait 2.5;
  scripts\engine\utility::exploder(66);
}

_id_E4C0() {
  var_0 = getEntArray("revolving_door", "targetname");

  foreach(var_2 in var_0) {
    var_2.guid = var_2 scripts\engine\utility::get_target_ent();
    var_2._id_8985 = var_2.guid scripts\engine\utility::get_target_ent();
    var_2._id_8985 linkTo(var_2);
    var_0[var_0.size] = var_2;
    var_2.guid hide();
    var_2.guid linkTo(var_2);
  }

  scripts\engine\utility::flag_wait("start_revolving_door_fire");
  var_4 = scripts\engine\utility::getStructArray("revolving_door_shooter_0", "targetname");
  var_5 = scripts\engine\utility::getStruct("revolving_door_breaker_0", "targetname");
  var_6 = scripts\engine\utility::getStructArray("revolving_door_shooter_1", "targetname");
  var_7 = scripts\engine\utility::getStruct("revolving_door_breaker_1", "targetname");

  if(distance2d(var_0[0].origin, var_5.origin) < distance2d(var_0[1].origin, var_5.origin)) {
    var_5._id_5978 = var_0[0];
    var_7._id_5978 = var_0[1];
  } else {
    var_5._id_5978 = var_0[1];
    var_7._id_5978 = var_0[0];
  }

  thread _id_E4BE();
  var_5._id_5978 playSound("phstreets_hill_glass_door_expl");
  glassradiusdamage(var_5.origin, 160, 1000, 1000);
  var_5._id_5978.guid show();
  var_5._id_5978 rotateYaw(-45, 3, 0.25, 1.5);

  foreach(var_9 in var_4)
  var_9 thread _id_103FC();

  wait(randomfloatrange(1, 1.5));
  var_5._id_5978 playSound("phstreets_hill_glass_door_expl");
  glassradiusdamage(var_7.origin, 160, 1000, 1000);
  var_7._id_5978.guid show();
  var_7._id_5978 rotateYaw(-45, 3, 0.25, 1.5);
  var_7._id_5978 thread _id_D6C7();

  foreach(var_9 in var_6)
  var_9 thread _id_103FC();

  wait 0.4;

  foreach(var_9 in var_4)
  var_9 notify("stop_magic_firing");

  foreach(var_9 in var_6)
  var_9 notify("stop_magic_firing");

  scripts\engine\utility::flag_set("stop_revolving_door_bullets");
}

_id_D6C7() {
  self waittill("rotatedone");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_61C7();
    var_1 scripts\sp\utility::_id_F3B5("g");
  }

  scripts\sp\utility::_id_15F5("initial_base_color_trig");
  getEnt("tower_revolving_door_clipper_mc_clippington", "targetname") delete();
}

_id_E4BE() {
  for(var_0 = 0; var_0 < 13; var_0++)
    thread _id_E4BF("revolve_sparks_" + var_0);
}

_id_E4BF(var_0) {
  while(!scripts\engine\utility::flag("stop_revolving_door_bullets")) {
    wait(randomfloatrange(0.5, 2));
    scripts\engine\utility::exploder("exploder_num");
  }

  scripts\sp\utility::_id_5151(var_0);
}

_id_103FC() {
  self endon("stop_magic_firing");
  var_0 = 32;
  var_1 = 32;
  var_2 = 8;
  var_3 = self.origin + anglesToForward(self.angles) * 1000;

  for(;;) {
    var_4 = 1;

    if(scripts\engine\utility::cointoss())
      var_4 = -1;

    wait(randomfloatrange(0.1, 0.4));
    var_5 = var_3 + (var_0 * var_4, var_1 * var_4, var_2 * var_4);
    magicbullet("iw7_ar57", self.origin, var_5);
    bullettracer(self.origin, var_5, undefined, 1);
  }
}

_id_13BE9() {
  var_0 = getEntArray("parking_lot_flag", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_6E60();
}

#using_animtree("script_model");

_id_6E60() {
  self _meth_83D0(#animtree);
  self setanimknob(%sign_exterior_flag_tall_loop_01, 1, 0.2, randomfloatrange(0.3, 0.95));

  if(getdvarint("E3", 0)) {
    scripts\engine\utility::flag_wait("jackals_landed");
    self setanimknob(%sign_exterior_flag_tall_loop_02, 1, randomfloatrange(0.4, 1), randomfloatrange(0.6, 0.95));
  }
}

_id_11A6A() {
  wait 1;
  _id_0E40::_id_6209();
  level._id_10949 = scripts\engine\utility::getStruct("jackal_special_streak_node", "targetname");
  level.player scripts\sp\utility::_id_8294("iw7_jackal_support_designator");
}

_id_1064D() {
  self.fixednode = 1;
}

_id_11A63() {
  scripts\engine\utility::flag_set("fountain_vo_done");
  thread _id_11A64();
}

_id_11A64() {
  thread _id_F8E5();

  foreach(var_1 in level.allies)
  var_1 scripts\sp\utility::_id_1160F(getnode("hvt_door_stackup_" + var_1._id_1FBB, "targetname"));
}

_id_C9E0() {
  scripts\engine\utility::flag_init("jump_to_breach");
}

_id_9235() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("hvt_door_stackup");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  scripts\sp\utility::_id_22CD("hvt_foyer_corpse");
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("hvt_door_stackup", var_0);
  scripts\engine\utility::flag_set("fountain_vo_done");
}

_id_9234() {
  thread scripts\sp\utility::_id_266F();

  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  thread _id_9212();
  thread _id_11A6D();

  foreach(var_1 in level.allies) {
    var_1 _meth_82EE(getnode(var_1._id_1FBB + "_stack_node", "targetname"));
    var_1.disableplayeradsloscheck = 1;
  }

  thread scripts\sp\utility::_id_CF8B();
  thread scripts\sp\utility::_id_28D7("axis");
  thread scripts\sp\utility::_id_28D7("allies");
  scripts\engine\utility::flag_wait("fountain_vo_done");
  thread _id_9236();
  wait 6;
  _id_CF9C();
}

_id_922F() {
  var_0 = self.spawner;

  if(isDefined(self.weapon) && self.weapon != "none")
    scripts\sp\utility::_id_86E4();

  self notsolid();
  self._id_1FBB = "generic";
  self._id_6B14 = 1;
  _id_0A1E::_id_236C(self);
  thread scripts\sp\anim::_id_1EC2(self, var_0.animation, var_0.origin, var_0.angles);
}

_id_9236() {
  wait 0.5;
  level.allies["admiral"] thread scripts\sp\utility::_id_10346("phstreets_adm_ethanpatchintoa");
  wait 3;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_yessirstreaming");
  level.player thread scripts\sp\utility::play_sound_on_entity("predator_drone_static");
  scripts\sp\pip_util::_id_2ADF("pearl_hud_riah_pip");
  scripts\engine\utility::flag_set("hvt_pip_bink_done");

  if(scripts\engine\utility::flag("breach_started")) {
    return;
  }
  level endon("breach_started");
  thread _id_9260();
  level notify("hvt_start_alarms");
  wait 1.5;
  level.player scripts\sp\utility::_id_10347("phstreets_plr_wegottagonow");
  wait 3;
  level.allies["admiral"] scripts\sp\utility::_id_10347("phstreets_adm_getusintherelieu");
  wait 1;
  level.allies["salter"] scripts\sp\utility::_id_10347("phstreets_slt_letsmovereyes");
}

_id_9260() {
  level endon("breach_started");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  level._id_11A6C = var_0;
  level._id_11A6C.origin = (76820, 54000, -33180);
  wait 3;

  for(;;) {
    level._id_11A6C scripts\sp\utility::play_sound_on_entity("phstreets_cmp_pleaseexitthebu");
    level._id_11A6C scripts\sp\utility::play_sound_on_entity("phstreets_cmp_repeatpleaseexi");
    level._id_11A6C scripts\sp\utility::play_sound_on_entity("phstreets_cmp_thisareaisnowof");
    wait 5;
  }
}

_id_CF9C() {
  var_0 = scripts\engine\utility::getStruct("hvt_breach_interact", "targetname");
  var_0 _id_0E46::_id_48C4(undefined, undefined, &"PHSTREETS_BREACH", undefined, 800, undefined, 1);
  scripts\sp\utility::_id_B979(var_0, "stand");

  foreach(var_2 in level.allies)
  var_2 scripts\sp\utility::_id_1160F(getnode(var_2._id_1FBB + "_stack_node", "targetname"));

  if(isDefined(level._id_11A6C))
    level._id_11A6C delete();

  scripts\engine\utility::flag_set("breach_started");
}

_id_9232() {
  thread _id_9233();
}

_id_F8E5() {
  scripts\engine\utility::flag_wait("phstreets_hvt_tr_loaded");
  wait 1;
  var_0 = scripts\engine\utility::getStruct("hvt_breach_animNode", "targetname");
  var_1 = getEnt("hvt_breach_right_door", "targetname");
  var_2 = getEnt("hvt_breach_left_door", "targetname");
  var_3 = getEnt("hvt_breach_right_door_dest", "targetname");
  var_4 = getEnt("hvt_breach_left_door_dest", "targetname");
  var_1._id_1FBB = "left_door";
  var_2._id_1FBB = "right_door";
  var_3._id_1FBB = "left_door_dest";
  var_4._id_1FBB = "right_door_dest";
  var_5 = [var_1, var_2, var_3, var_4];
  var_1 scripts\sp\anim::_id_F64A();
  var_2 scripts\sp\anim::_id_F64A();
  var_3 scripts\sp\anim::_id_F64A();
  var_4 scripts\sp\anim::_id_F64A();
  var_3 hide();
  var_4 hide();
  var_3 notsolid();
  var_4 notsolid();
  var_0 scripts\sp\anim::_id_1EC1(var_5, "ph_hvt_breach");
}

_id_923E() {
  level endon("breach_started");
  level notify("hvt_start_alarms");
  wait 1.5;
  level.player scripts\sp\utility::_id_10347("phstreets_plr_wegottagonow");
  wait 3;
  level.allies["admiral"] scripts\sp\utility::_id_10347("phstreets_adm_getusintherelieu");
  wait 1;
  level.allies["salter"] scripts\sp\utility::_id_10347("phstreets_slt_letsmovereyes");
}

_id_9233() {
  thread _id_9212();

  foreach(var_1 in level.allies)
  var_1 scripts\sp\utility::_id_1160F(getnode(var_1._id_1FBB + "_stack_node", "targetname"));

  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_28D7("allies");
}

_id_921B() {
  scripts\engine\utility::flag_set("jump_to_breach");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("hvt_door_stackup");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("hvt_door_stackup", var_0);
  thread _id_11A5D();
}

_id_921A() {
  level.player endon("death");
  setsuncolorandintensity(0);
  level notify("hvt_start_alarms");
  thread scripts\sp\utility::_id_266F();
  thread _id_9217();
  scripts\engine\utility::flag_wait("slow_motion");
  thread _id_925E();
  thread _id_925F(0);
  _id_116DD();
}

_id_9217() {
  level endon("hvt_timeout");
  level endon("cancel_success");
  var_0 = scripts\engine\utility::getStruct("hvt_breach_animNode", "targetname");
  var_1 = scripts\engine\utility::getStruct("hvt_breach_animNodeRig", "targetname");
  var_2 = getEnt("hvt_breach_right_door", "targetname");
  var_3 = getEnt("hvt_breach_left_door", "targetname");
  var_4 = getEnt("hvt_breach_right_door_dest", "targetname");
  var_5 = getEnt("hvt_breach_left_door_dest", "targetname");
  var_6 = scripts\sp\utility::_id_10639("player_rig");
  var_7 = var_3 scripts\engine\utility::get_target_ent();
  var_8 = var_2 scripts\engine\utility::get_target_ent();
  var_8 linkTo(var_4);
  var_7 linkTo(var_5);
  var_6 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_6, "ph_hvt_breach");

  if(scripts\engine\utility::flag("jump_to_breach"))
    wait 2;

  thread _id_923B();
  thread _id_DB2E(var_6, 0.5, 0, 0, 0, 0, 0);
  var_9 = [var_2, var_3, var_4, var_5];
  thread _id_9250();
  thread _id_9226(var_9, var_7, var_8);
  _id_1073B();
  var_10 = [level._id_920F, level.allies["eth3n"], level.allies["salter"]];
  var_7 connectpaths();
  var_8 connectpaths();
  thread _id_0E26::_id_DFC1();
  thread _id_2F51();
  thread _id_1073E(var_0, 1);
  thread _id_EA92();
  thread _id_10BBE();
  var_1 thread _id_E507(var_6, 3.35);
  var_0 thread scripts\sp\anim::_id_1F2C(var_9, "ph_hvt_breach");
  var_0 thread scripts\sp\anim::_id_1F2C(var_10, "ph_hvt_breach");
  wait 0.35;
  level.player forceplaygestureviewmodel("ges_fall_back", undefined, 0.2);
  wait 0.15;
  level.player scripts\sp\utility::_id_10347("phstreets_plr_ethannow");
  level.allies["eth3n"] waittillmatch("single anim", "end");
  var_10 = [level._id_920F, level.allies["eth3n"]];
  var_0 thread scripts\sp\anim::_id_1EE7(var_10, "ph_hvt_breach_idle", "end_breach_idle");
}

_id_2F51() {
  wait 3.5;
  var_0 = getnode("salter_stack_node", "targetname");
  level.allies["admiral"] scripts\sp\utility::_id_54F7();
  level.allies["admiral"] scripts\sp\utility::_id_1160F(var_0);
  level.allies["admiral"].fixednode = 1;
  level.allies["admiral"].ignoreall = 0;
  level.allies["admiral"] scripts\sp\utility::_id_F417(1);
  level waittill("hvt_guards_dead");
  level.allies["admiral"].ignoreall = 1;
}

_id_923B() {
  if(scripts\engine\utility::flag("nextmission_preload_started")) {
    return;
  }
  scripts\engine\utility::flag_set("nextmission_preload_started");
  scripts\sp\utility::_id_BF97(undefined, undefined, 0);
}

_id_9250() {
  level.player setviewkickscale(0.15);
  level.player _id_0E42::giveperk("specialty_quickdraw");
  level.player _id_0E42::giveperk("specialty_quickswap");
  level.player scripts\sp\utility::_id_65E1("player_no_auto_blur");

  if(isDefined(level._id_CB9C) && level._id_CB9C.enable) {
    level notify("kill_pip");
    thread scripts\sp\pip_util::_id_CBA3();
    level.player thread scripts\sp\utility::play_sound_on_entity("predator_drone_static");
    level._id_920F stopsounds();
  }

  var_0 = level.player getcurrentweapon();
  var_1 = weaponclipsize(var_0);
  level.player setweaponammoclip(var_0, var_1);
  level waittill("fast_time");
  level.player _id_0E42::removeperk("specialty_quickdraw");
  level.player _id_0E42::removeperk("specialty_quickswap");
}

_id_9226(var_0, var_1, var_2) {
  level.allies["eth3n"] waittillmatch("single anim", "door_swap");
  var_1 delete();
  var_2 delete();
  thread _id_9210();
  playFXOnTag(scripts\engine\utility::getfx("hill_c6_bullet_impact"), level.allies["eth3n"], "j_head");
  playFXOnTag(level._effect["hvt_ethan_head_sparks"], level.allies["eth3n"], "j_head");
  playFXOnTag(level._effect["hvt_ethan_shoulder_sparks"], level.allies["eth3n"], "j_head");

  foreach(var_4 in var_0) {
    if(issubstr(var_4.targetname, "dest")) {
      var_4 show();
      playFXOnTag(level._effect["hvt_door_smash"], var_4, "tag_origin");
      continue;
    }

    var_4 delete();
  }
}

_id_EA92() {
  wait 1;
  var_0 = level.allies["salter"];
  var_0.fixednode = 1;
  var_0.dontmelee = 1;
  var_0 allowedstances("crouch");
  var_0.a._id_5605 = 1;
  var_1 = getaiarray("axis");
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(isDefined(var_5) && isDefined(var_5.script_noteworthy) && isalive(var_5) && var_5.script_noteworthy == "1")
      var_2 = var_5;
  }

  wait 3.25;

  if(isDefined(var_2) && isalive(var_2)) {
    if(isDefined(var_2._id_B14F))
      var_2 scripts\sp\utility::_id_1101B();

    magicbullet(var_0.weapon, var_0 gettagorigin("tag_flash"), var_2 getEye());
    playFXOnTag(level._id_7649["human_gib_head"], var_2, "j_head");
    var_2 _meth_81D0();
    var_0.accuracy = 0.7;
  }

  wait 0.25;
  var_0 _meth_83A1();
  var_0 setgoalpos(var_0.origin);
}

_id_E507(var_0, var_1) {
  thread scripts\sp\anim::_id_1F35(var_0, "ph_hvt_breach");
  wait 3;
  level.player scripts\sp\utility::_id_F526("normal");
  level.player thread _id_10311(0, 0.8);
  var_0 waittillmatch("single anim", "end");
  thread _id_DAE1(var_0);
  level notify("hvt_breach_player_control_on");
}

_id_10311(var_0, var_1) {
  var_2 = var_0;

  while(var_2 <= var_1) {
    level.player _meth_80D8(var_2, var_2);
    var_2 = var_2 + 0.02;
    wait 0.05;
  }

  level.player _meth_80D8(var_1, var_1);
}

_id_10BBE() {
  thread _id_FB9C();
  level.allies["eth3n"] waittillmatch("single anim", "slow_time");
  scripts\engine\utility::flag_set("slow_motion");
  earthquake(0.5, 0.25, level.player.origin, 500);
  level.player playRumbleOnEntity("damage_heavy");
  setslowmotion(1, 0.25, 0);
  level scripts\engine\utility::waittill_notify_or_timeout("hvt_guards_dead", 3);
  thread _id_FB9D();
  setslowmotion(0.25, 1, 3);
  level.player _meth_80A6();
}

_id_FB9C() {
  thread _id_FC15();
  wait 2.5;
  level.player _meth_82C0("phstreets_building_hvt_breach", 0.2);
  level._id_2F91 = spawn("script_origin", (0, 0, 0));
  level._id_2F91 playSound("scn_phstreets_hvt_breach");
}

_id_FB9D() {
  level.player playSound("scn_phstreets_hvt_breach_out");
  level.player _meth_82C0("phstreets_building_hvt_room", 1);
  wait 0.1;

  if(isDefined(level._id_2F91)) {
    level._id_2F91 stopsounds();
    wait 0.1;
    level._id_2F91 delete();
  }
}

_id_FC15() {
  soundsettimescalefactor("music_lr", 0);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("music_lsrs", 0);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.15);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_npc_main_3d", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_npc_mech_3d", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_npc_mid_3d", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_npc_dist_3d", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("weap_npc_lo_3d", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletflesh_lfe_unres_2d_lim", 0);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletflesh_npcnpc1_unres_3d_lim", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletflesh_npcnpc2_unres_3d_lim", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletimpact_unres_3d_lim", 0.2);
  scripts\engine\utility::waitframe();
  soundsettimescalefactor("bulletimpact_lo_unres_3d_lim", 0.2);
}

_id_9218() {
  thread _id_9219();
}

_id_9210() {
  level.allies["admiral"].ignoreme = 1;
  level.allies["eth3n"].ignoreme = 1;
  level.allies["salter"].ignoreme = 0;
  level.player.ignoreme = 0;
  level waittill("hvt_guards_dead");
  level.allies["salter"].ignoreall = 1;
}

_id_1073E(var_0, var_1) {
  level._id_4D4D = "bananas";
  var_2 = getspawnerarray("hvt_guard");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5 scripts\sp\utility::_id_10619(1);
    var_3[var_3.size] = var_6;
    var_6.fixednode = 1;
    var_6._id_EE05 = 0;
    var_6._id_1FBB = "hvt_guard";
    var_6.dontmelee = 1;
    var_6._id_2894 = 0;
    var_6.a.disablelongdeath = 1;
    var_6.health = 20;
    var_6 thread _id_B2D5(var_0, var_1);
  }

  if(!var_1) {
    level waittill("kill_pip");
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_3);
  } else {
    scripts\sp\utility::_id_13753(var_3);
    level notify("hvt_guards_dead");
  }

  level._id_4D4D = undefined;
}

_id_B2D5(var_0, var_1) {
  self endon("death");

  if(self.script_noteworthy == "3")
    self allowedstances("crouch");
  else if(self.script_noteworthy == "2")
    self.ignoreme = 1;
  else if(self.script_noteworthy == "1")
    self.ignoreme = 1;

  if(var_1) {
    if(isDefined(self.script_parameters) && self.script_parameters == "salter")
      self.favoriteenemy = level.allies["salter"];
    else
      self.favoriteenemy = level.player;

    var_0 thread scripts\sp\anim::_id_1F35(self, "ph_hvt_breach0" + self.script_noteworthy);
    thread _id_B2D6();
    level waittill("hvt_breach_player_control_on");
    wait 1;
    self._id_2894 = 1;
  } else
    var_0 thread scripts\sp\anim::_id_1EEA(self, "ph_hvt_pip_speech0" + self.script_noteworthy);
}

_id_B2D6() {
  self endon("death");

  if(self.script_noteworthy == "2")
    thread _id_6780();

  if(self.script_noteworthy == "4")
    self.a._id_5605 = 1;

  scripts\sp\utility::_id_B14F();
  self._id_11470 = 0;
  self._id_1146F = 0;
  var_0 = 0;
  var_1 = 0;

  switch (level.player scripts\sp\utility::_id_7B93()) {
    case 0:
      var_0 = 1;
      var_1 = 1;
      break;
    case 1:
      var_0 = randomintrange(2, 3);
      var_1 = 1;
      break;
    case 2:
      var_0 = randomintrange(3, 4);
      var_1 = 2;
      break;
    case 3:
      var_0 = randomintrange(4, 5);
      var_1 = 3;
      break;
  }

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isDefined(var_3) || var_3 != level.player) {
      continue;
    }
    var_10 = 0;

    if(var_9 == "j_head" || var_9 == "j_helmet")
      self._id_1146F++;

    self._id_11470++;

    if(self._id_11470 >= var_0 || self._id_1146F >= var_1) {
      if(isDefined(self._id_B14F))
        scripts\sp\utility::_id_1101B();

      self _meth_83A1();
      var_11 = 0;

      if(self._id_1146F >= var_1) {
        thread _id_0C60::_id_8E17();
        var_11 = 1;
        playFXOnTag(level._id_7649["human_gib_head"], self, "j_head");
      }

      if(!scripts\sp\utility::_id_93A6()) {
        var_10 = 1;
        level.player thread scripts\sp\damagefeedback::updatehitmarker("standard", 1, var_11, self);
      }

      scripts\anim\death::_id_58CB();
      self _meth_81D0();
    } else if(!scripts\sp\utility::_id_93A6())
      level.player thread scripts\sp\damagefeedback::updatehitmarker("standard", 0, 0, self);

    wait 0.05;
  }
}

_id_6780() {
  wait 4.2;

  if(isDefined(self) && isalive(self)) {
    thread _id_0C60::_id_8E17();
    playFXOnTag(level._id_7649["human_gib_head"], self, "j_head");
  }

  var_0 = scripts\engine\utility::getStructArray("monitor_structs", "targetname");

  foreach(var_2 in var_0) {
    radiusdamage(var_2.origin, 30, 1000, 1000);
    wait 0.25;
  }

  wait 0.35;

  if(isDefined(self) && isalive(self)) {
    self._id_10265 = 1;
    self _meth_83A1();
    scripts\sp\utility::_id_1101B();
    self dodamage(200, self gettagorigin("j_head"));
    self _meth_81D0();
  }
}

_id_A5F1(var_0) {
  level endon("hvt_guards_dead");
  var_1 = level.allies["salter"];

  while(var_0.size >= 1) {
    var_0 = scripts\sp\utility::_id_22B9(var_0);

    while(var_0.size == 1 && isDefined(var_0[0]) && isalive(var_0[0])) {
      var_2 = var_0[0];
      var_3 = spawn("script_origin", var_2 gettagorigin("j_head"));
      var_1 _meth_82DE(var_3);
      wait 0.5;

      if(isDefined(var_2._id_B14F))
        var_2 scripts\sp\utility::_id_1101B();

      magicbullet(var_1.weapon, var_1 gettagorigin("tag_flash"), var_2 getEye());
      var_2 _meth_81D0();
      break;
    }

    wait 0.05;
  }
}

_id_9212() {
  level waittill("hvt_start_alarms");
  var_0 = spawn("script_origin", level.player.origin);
  var_0 playLoopSound("emt_hvt_alarm_loop");
  scripts\engine\utility::exploder("1");
  var_1 = getEntArray("hvt_klaxon", "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4 scripts\engine\utility::spawn_tag_origin();
    var_5.origin = var_4.origin + anglestoup(var_4.angles) * 8;
    var_2[var_2.size] = var_5;

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "disable_on_breach")
      var_5._id_555C = 1;

    playFXOnTag(level._effect["vfx_hvt_alarm"], var_5, "tag_origin");
  }

  scripts\engine\utility::flag_wait("breach_started");

  foreach(var_5 in var_2) {
    if(isDefined(var_5._id_555C))
      var_5 delete();
  }

  level scripts\engine\utility::waittill_any("cancel_success", "hvt_timeout");
  var_0 scripts\sp\utility::_id_10460(0.5, 1);

  foreach(var_4 in var_1)
  var_4 delete();
}

_id_1073B() {
  level._id_920F = getspawner("hvt_actor", "targetname") scripts\sp\utility::_id_10619(1);
  level._id_920F.ignoreall = 1;
  level._id_920F.ignoreme = 1;
  level._id_920F.fixednode = 1;
  level._id_920F._id_1FBB = "hvt";
  level._id_920F scripts\sp\utility::_id_B14F();
  level._id_920F scripts\sp\utility::_id_86E4();
  level._id_920F thread _id_9237();
}

_id_116DD() {
  level endon("hvt_timeout");
  var_0 = scripts\engine\utility::getStruct("cable_pull_struct", "targetname");
  var_0 thread _id_925D();
  level waittill("hvt_guards_dead");
  level.player thread scripts\sp\utility::_id_F526("relaxed");
  var_0 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 200, 50, 1);
  var_0 waittill("trigger");
  level thread scripts\sp\utility::_id_BF98();
  level.player disableweapons();
  level.player _meth_818A();
  var_1 = scripts\engine\utility::getStruct("hvt_breach_animNode", "targetname");
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  var_3 = 0.4;
  thread _id_DB2E(var_2, var_3, 0, 0, 0, 0);
  level notify("cancel_success");
  setomnvar("ui_hvt_selfdestruct", 0);
  level.player _meth_80D8(0.1, 0.1);
  var_1 thread scripts\sp\anim::_id_1EC3(var_2, "ph_hvt_laptop");
  var_2 hide();
  wait(var_3);
  var_2 show();
  var_1 scripts\sp\anim::_id_1F35(var_2, "ph_hvt_laptop");
  _id_DAE1(var_2, undefined, undefined, 1);
  level.allies["eth3n"] stopsounds();
  level._id_920F stopsounds();
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "0");
  level.player freezecontrols(1);
  setomnvar("ui_hide_hud", 1);
  setmusicstate("capture_setdef_agent");
  level.player _meth_82C0("fade_to_black_minus_amb_and_music", 0.1);
  scripts\engine\utility::flag_set("tower_objective_complete");
  scripts\sp\utility::_id_BF95();
}

_id_925E() {
  level endon("cancel_success");
  scripts\engine\utility::flag_wait("hvt_pip_bink_done");
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingameloop("ph_hvt_timer");
  setomnvar("ui_hvt_selfdestruct", 1);
  var_0 = 12;
  setomnvar("ui_hvt_selfdestruct_timer", gettime() + int(var_0 * 1000));
  wait 12;
  level notify("hvt_timeout");
}

_id_925D() {
  level endon("cancel_success");
  wait 5;
  level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_sirtheterminal");
  wait 4.5;
  level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_ltnow");
}

_id_925F(var_0) {
  level endon("cancel_success");

  if(var_0)
    scripts\engine\utility::flag_wait("fail_hvt_asap");

  level waittill("hvt_timeout");
  thread _id_923F();
  thread _id_D0E7();
  level.allies["eth3n"] notify("end_breach_idle");
  level._id_920F notify("end_breach_idle");
  level._id_920F _meth_83A1();
  level._id_920F stopsounds();
  level._id_920F scripts\sp\utility::_id_1101B();
  level._id_920F _meth_81D0();
  playFX(level._effect["hvt_death"], level._id_920F.origin);

  foreach(var_2 in level.allies) {
    var_2 _meth_83A1();
    var_2 scripts\sp\utility::_id_1101B();
    var_2 _meth_81D0();
    var_2 playSound("detpack_explo_metal");
  }

  playworldsound("exp_helicopter_fuel_boom", level.player.origin);

  if(distance2dsquared(level.player.origin, level._id_920F.origin) >= squared(650)) {
    for(var_4 = 5; var_4 < 8; var_4++) {
      playFX(level._effect["vfx_ph_capship_un_engineexplosion"], level.player.origin + anglesToForward(level.player.angles) * 200);
      playworldsound("detpack_explo_metal", level.player.origin);
      wait(5 / var_4);
    }
  }
}

_id_923F() {
  var_0 = scripts\engine\utility::getStructArray("fx_explode_point", "targetname");

  foreach(var_2 in var_0) {
    playFX(level._effect["vfx_ph_capship_un_engineexplosion"], var_2.origin);
    playworldsound("exp_helicopter_fuel_boom", var_2.origin);
  }

  foreach(var_2 in var_0) {
    playFX(level._effect["vfx_ph_capship_un_engineexplosion"], var_2.origin);
    wait 0.2;
  }
}

_id_D0E7() {
  screenshake(level.player.origin, 20, 18, 15, 1, 0.5);
  level.player playRumbleOnEntity("grenade_rumble");
  wait 0.5;

  if(isalive(level.player)) {
    if(getdvarint("exec_review") != 1) {
      _id_0B60::_id_F322("PHSTREETS_BREACH_FAIL");
      level.player _meth_81D0();
      level.player _meth_8497(1);
    }
  }

  setslowmotion(1, 0.5, 0.25);
  wait 1;
  setslowmotion(0.5, 1, 0.25);
}

_id_9224() {
  level.player allowads(0);
  thread _id_0B0A::_id_583F(0, 3.745, 6, 0.753, 546.89, 3.05, 0.1);
  wait 0.3;
  setsaveddvar("scr_dof_enable", "0");
  level.player allowads(1);
  level waittill("speed_time_up");

  while(level.player scripts\sp\utility::_id_9D27())
    wait 0.05;

  setsaveddvar("scr_dof_enable", "1");
  thread _id_0B0A::_id_583D(1);
}

_id_9219() {}

_id_9237() {
  self._id_6BA1 = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_7 == "j_spineupper" && var_1 == level.player) {
      if(self._id_6BA1 == 2) {
        scripts\sp\utility::_id_56BA("killed_hvt");
        scripts\sp\utility::_id_B8D1();
      } else
        self._id_6BA1++;
    }

    wait 0.05;
  }
}

_id_9261() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("hvt_door_stackup");
  wait 0.1;
  _id_1073B();
  var_0 = scripts\engine\utility::getStruct("hvt_breach_animNode", "targetname");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_920F, "ph_hvt_pip_speech");
  _id_1073E(var_0, 0);
}

_id_DB2E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player _meth_84FE();
  level.player scripts\sp\utility::_id_F526("safe");

  if(isDefined(var_6)) {
    level.player allowprone(0);
    level.player allowcrouch(0);
    level.player allowstand(1);
  } else {
    level.player allowprone(0);
    level.player allowcrouch(0);
  }

  level.player _meth_823C(var_0, "tag_player", var_1, 0, 0);
  wait(var_1);
  level.player _meth_823B(var_0, "tag_player");
  var_0 show();
  setsaveddvar("r_dof_hq", 1);
}

_id_DAE1(var_0, var_1, var_2, var_3) {
  level.player _meth_84FD();

  if(isDefined(var_2)) {
    switch (var_2) {
      case "prone":
        level.player allowprone(1);
        level.player allowcrouch(0);
        level.player allowstand(0);
        break;
      default:
        break;
    }
  } else {
    level.player allowprone(1);
    level.player allowcrouch(1);
  }

  if(isDefined(var_3)) {
    return;
  }
  level.player unlink();
  var_0 delete();

  if(isDefined(var_1)) {
    _id_0E4B::_id_8DEA();
    wait(var_1);
    _id_0E4B::_id_8E0A();
  }

  setsaveddvar("r_dof_hq", 0);
}

_id_132A0() {
  level endon("tower_jackal_used");
  var_0 = getEntArray("special_case_volume", "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.target) && var_3.target == "special_lot_streak_node") {
      var_1 = var_3;
      break;
    }
  }

  for(;;) {
    scripts\engine\utility::flag_wait("jackal_shooting");
    var_5 = getaiarray("axis");
    var_5 = scripts\sp\utility::array_removedeadvehicles(var_5);

    foreach(var_7 in var_5)
    var_7 thread _id_132A1(var_1);

    scripts\engine\utility::flag_wait("bugging_out");
  }
}

_id_132A1(var_0) {
  level endon("tower_jackal_used");

  for(;;) {
    if(!isalive(self)) {
      return;
    }
    self waittill("damage", var_1, var_2);

    if(var_2 == level._id_A351 && self istouching(var_0))
      scripts\engine\utility::flag_set("tower_jackal_used");
  }
}