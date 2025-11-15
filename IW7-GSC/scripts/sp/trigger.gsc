/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\trigger.gsc
**********************************/

func_7AA4() {
  var_00 = [];
  var_00["trigger_multiple_nobloodpool"] = ::func_12777;
  var_00["trigger_multiple_flag_set"] = ::func_1273F;
  var_00["trigger_multiple_flag_clear"] = ::func_1273D;
  var_00["trigger_multiple_sun_off"] = ::func_1279E;
  var_00["trigger_multiple_sun_on"] = ::func_1279F;
  var_00["trigger_use_flag_set"] = ::func_1273F;
  var_00["trigger_use_flag_clear"] = ::func_1273D;
  var_00["trigger_multiple_flag_set_touching"] = ::func_12744;
  var_00["trigger_multiple_flag_lookat"] = ::func_12760;
  var_00["trigger_multiple_flag_looking"] = ::func_12762;
  var_00["trigger_multiple_no_prone"] = ::func_12776;
  var_00["trigger_multiple_no_crouch_or_prone"] = ::func_12775;
  var_00["trigger_multiple_compass"] = ::func_12769;
  var_00["trigger_multiple_fx_volume"] = ::func_1276E;
  var_00["trigger_multiple_kleenex"] = ::func_12770;
  var_00["trigger_multiple_light_sunshadow"] = ::scripts\sp\lights::func_11203;
  var_00["trigger_multiple_jackal_boundary_autoturn"] = ::func_12759;
  var_00["trigger_multiple_jackal_boundary_warning"] = ::func_1275B;
  var_00["trigger_multiple_jackal_boundary_push"] = ::func_1275A;
  var_00["trigger_multiple_jackal_speed_touching"] = ::func_1275C;
  var_00["trigger_multiple_landingzone"] = ::func_1275E;
  var_00["trigger_multiple_arbitrary_up"] = ::func_12723;
  var_00["trigger_multiple_spacejump"] = ::func_12794;
  if(!scripts\sp\starts::func_9C4B()) {
    var_00["trigger_multiple_autosave"] = ::scripts\sp\autosave::func_12724;
    var_00["trigger_multiple_spawn"] = ::lib_0B77::func_12797;
    var_00["trigger_multiple_spawn_reinforcement"] = ::lib_0B77::func_12798;
  }

  var_00["trigger_multiple_slide"] = ::func_12792;
  var_00["trigger_multiple_depthoffield"] = ::func_1276A;
  var_00["trigger_multiple_tessellationcutoff"] = ::func_12772;
  var_00["trigger_damage_player_flag_set"] = ::func_1272F;
  var_00["trigger_multiple_sunflare"] = ::func_12771;
  var_00["trigger_multiple_glass_break"] = ::func_1274B;
  var_00["trigger_radius_glass_break"] = ::func_1274B;
  var_00["trigger_multiple_friendly_respawn"] = ::trigger_friendly_respawn;
  var_00["trigger_multiple_friendly_stop_respawn"] = ::trigger_friendly_stop_respawn;
  var_00["trigger_multiple_physics"] = ::func_1277E;
  var_00["trigger_multiple_fx_watersheeting"] = ::func_1276F;
  var_00["trigger_multiple_fakeactor_move"] = ::scripts\sp\fakeactor::func_12735;
  var_00["trigger_multiple_fakeactor_node_disable"] = ::scripts\sp\fakeactor::func_12736;
  var_00["trigger_multiple_fakeactor_node_enable"] = ::scripts\sp\fakeactor::func_12738;
  var_00["trigger_multiple_fakeactor_node_disablegroup"] = ::scripts\sp\fakeactor::func_12737;
  var_00["trigger_multiple_fakeactor_node_enablegroup"] = ::scripts\sp\fakeactor::func_12739;
  var_00["trigger_multiple_fakeactor_node_passthrough"] = ::scripts\sp\fakeactor::func_1273B;
  var_00["trigger_multiple_fakeactor_node_lock"] = ::scripts\sp\fakeactor::func_1273A;
  var_00["trigger_multiple_geo_mover"] = ::scripts\sp\geo_mover::func_12764;
  var_00["trigger_multiple_transient"] = ::func_12773;
  var_00["trigger_multiple_fire"] = ::func_1273C;
  var_00["trigger_radius_fire"] = ::func_1273C;
  return var_00;
}

func_1276F(param_00) {
  var_01 = 3;
  if(isDefined(param_00.var_ED75)) {
    var_01 = param_00.var_ED75;
  }

  for(;;) {
    param_00 waittill("trigger", var_02);
    if(isplayer(var_02)) {
      var_02 setwatersheeting(1, var_01);
      wait(var_01 * 0.2);
    }
  }
}

func_7AA5() {
  var_00 = [];
  var_00["friendly_mgTurret"] = ::lib_0B77::func_73D9;
  if(!scripts\sp\starts::func_9C4B()) {
    var_00["camper_spawner"] = ::lib_0B77::camper_trigger_think;
    var_00["flood_spawner"] = ::lib_0B77::func_6F5D;
    var_00["trigger_spawner"] = ::lib_0B77::func_12797;
    var_00["trigger_autosave"] = ::scripts\sp\autosave::func_12724;
    var_00["trigger_spawngroup"] = ::func_1279A;
    var_00["trigger_vehicle_spline_spawn"] = ::func_127AC;
    var_00["trigger_vehicle_spawn"] = ::lib_0B77::func_12797;
    var_00["random_spawn"] = ::lib_0B77::func_DC9B;
  }

  var_00["autosave_now"] = ::scripts\sp\autosave::func_2671;
  var_00["trigger_autosave_tactical"] = ::scripts\sp\autosave::func_12727;
  var_00["trigger_autosave_stealth"] = ::scripts\sp\autosave::func_12726;
  var_00["trigger_unlock"] = ::func_127A8;
  var_00["trigger_lookat"] = ::func_12760;
  var_00["trigger_looking"] = ::func_12762;
  var_00["trigger_cansee"] = ::func_1272B;
  var_00["flag_set"] = ::func_1273F;
  var_00["flag_set_player"] = ::func_12741;
  var_00["flag_unset"] = ::func_1273D;
  var_00["flag_clear"] = ::func_1273D;
  var_00["friendly_respawn_trigger"] = ::trigger_friendly_respawn;
  var_00["radio_trigger"] = ::func_12787;
  var_00["trigger_ignore"] = ::func_12752;
  var_00["trigger_pacifist"] = ::func_1277C;
  var_00["trigger_delete"] = ::func_127A6;
  var_00["trigger_delete_on_touch"] = ::func_12731;
  var_00["trigger_off"] = ::func_127A6;
  var_00["trigger_outdoor"] = ::lib_0B77::func_C75A;
  var_00["trigger_indoor"] = ::lib_0B77::func_9409;
  var_00["trigger_hint"] = ::func_1274E;
  var_00["trigger_grenade_at_player"] = ::func_127A5;
  var_00["flag_on_cleared"] = ::func_1273E;
  var_00["flag_set_touching"] = ::func_12744;
  var_00["delete_link_chain"] = ::func_12730;
  var_00["trigger_slide"] = ::func_12792;
  var_00["trigger_dooropen"] = ::func_12734;
  var_00["stealth_shadow"] = ::func_1279C;
  var_00["geo_mover"] = ::scripts\sp\geo_mover::func_12764;
  var_00["no_crouch_or_prone"] = ::func_12775;
  var_00["no_prone"] = ::func_12776;
  return var_00;
}

func_9726() {
  scripts\sp\colors::init_colors();
  scripts\sp\audio::init_audio();
  scripts\sp\utility::func_228A(getEntArray("trigger_multiple_softlanding", "classname"));
  var_00 = func_7AA4();
  var_01 = func_7AA5();
  foreach(var_05, var_03 in var_00) {
    var_04 = getEntArray(var_05, "classname");
    scripts\engine\utility::array_levelthread(var_04, var_03);
  }

  var_06 = getEntArray("trigger_multiple", "classname");
  var_07 = getEntArray("trigger_radius", "classname");
  var_04 = scripts\sp\utility::func_22A2(var_06, var_07);
  var_08 = getEntArray("trigger_disk", "classname");
  var_04 = scripts\sp\utility::func_22A2(var_04, var_08);
  var_09 = getEntArray("trigger_once", "classname");
  var_04 = scripts\sp\utility::func_22A2(var_04, var_09);
  if(!scripts\sp\starts::func_9C4B()) {
    for(var_0A = 0; var_0A < var_04.size; var_0A++) {
      if(var_04[var_0A].spawnimpulsefield & 32) {
        thread lib_0B77::func_12797(var_04[var_0A]);
      }
    }
  }

  var_0B = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage"];
  foreach(var_0D in var_0B) {
    var_04 = getEntArray(var_0D, "code_classname");
    foreach(var_0F in var_04) {
      if(isDefined(var_0F.script_flag_true)) {
        level thread func_1278F(var_0F);
      }

      if(isDefined(var_0F.script_flag_false)) {
        level thread func_1278E(var_0F);
      }

      if(isDefined(var_0F.var_ED0E) || isDefined(var_0F.var_ED0D)) {
        level thread scripts\sp\autosave::func_268B(var_0F);
      }

      if(isDefined(var_0F.var_EE17)) {
        level thread scripts\sp\mgturret::func_B6BE(var_0F);
      }

      if(isDefined(var_0F.var_EDF7)) {
        level thread lib_0B77::func_A617(var_0F);
      }

      if(isDefined(var_0F.var_EDF5)) {
        level thread scripts\sp\vehicle_code::func_A629(var_0F);
      }

      if(isDefined(var_0F.script_emptyspawner)) {
        level thread lib_0B77::func_61BD(var_0F);
      }

      if(isDefined(var_0F.script_prefab_exploder)) {
        var_0F.script_exploder = var_0F.script_prefab_exploder;
      }

      if(isDefined(var_0F.script_exploder)) {
        level thread exploder_load(var_0F);
      }

      if(isDefined(var_0F.var_EEEF)) {
        level thread func_12780(var_0F);
      }

      if(isDefined(var_0F.var_ED18)) {
        level thread func_12729(var_0F);
      }

      if(isDefined(var_0F.var_EEEE)) {
        var_0F thread func_1274C();
      }

      if(isDefined(var_0F.var_EE90)) {
        level thread lib_0B77::func_DC8F(var_0F);
      }

      if(isDefined(var_0F.var_336)) {
        var_10 = var_0F.var_336;
        if(isDefined(var_01[var_10])) {
          level thread[[var_01[var_10]]](var_0F);
        }
      }
    }
  }
}

func_1272E(param_00) {
  var_01 = 1;
  if(var_01) {
    param_00 delete();
  }
}

func_4984() {}

func_9CEA() {
  if(getdvar("createfx") != "") {
    return 1;
  }

  if(getdvarint("scr_art_tweak") > 0) {
    return 1;
  }

  if(isDefined(level.var_10CDA) && level.var_10CDA == "no_game") {
    return 1;
  }

  return 0;
}

func_12773(param_00) {
  var_02 = undefined;
  var_03 = undefined;
  if(isDefined(param_00.var_EEE7)) {
    var_02 = strtok(param_00.var_EEE7, " ");
  }

  if(isDefined(param_00.var_EEE8)) {
    var_03 = strtok(param_00.var_EEE8, " ");
  }

  if(isDefined(var_02)) {
    foreach(var_05 in var_02) {
      if(!scripts\engine\utility::flag_exist(var_05 + "_loaded")) {
        scripts\engine\utility::flag_init(var_05 + "_loaded");
      }
    }
  }

  if(isDefined(var_03)) {
    foreach(var_05 in var_03) {
      if(!scripts\engine\utility::flag_exist(var_05 + "_loaded")) {
        scripts\engine\utility::flag_init(var_05 + "_loaded");
      }
    }
  }

  for(;;) {
    param_00 waittill("trigger");
    if(isDefined(var_03)) {
      scripts\sp\utility::func_12651(var_03);
    }

    if(isDefined(var_02)) {
      scripts\sp\utility::func_12643(var_02);
    }
  }
}

func_1272F(param_00) {
  var_01 = param_00 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_01])) {
    scripts\engine\utility::flag_init(var_01);
  }

  for(;;) {
    param_00 waittill("trigger", var_02);
    if(!isalive(var_02)) {
      continue;
    }

    if(!isplayer(var_02)) {
      continue;
    }

    param_00 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_01, var_02);
  }
}

func_1273D(param_00) {
  var_01 = param_00 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_01])) {
    scripts\engine\utility::flag_init(var_01);
  }

  for(;;) {
    param_00 waittill("trigger");
    param_00 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_clear(var_01);
  }
}

func_1273E(param_00) {
  var_01 = param_00 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_01])) {
    scripts\engine\utility::flag_init(var_01);
  }

  for(;;) {
    param_00 waittill("trigger");
    wait(1);
    if(param_00 func_733E()) {
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_set(var_01);
}

func_733E() {
  var_00 = getaiarray("bad_guys");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = var_00[var_01];
    if(!isalive(var_02)) {
      continue;
    }

    if(var_02 istouching(self)) {
      return 1;
    }

    wait(0.1);
  }

  var_00 = getaiarray("bad_guys");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = var_00[var_01];
    if(var_02 istouching(self)) {
      return 1;
    }
  }

  return 0;
}

func_1273F(param_00) {
  var_01 = param_00 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_01])) {
    scripts\engine\utility::flag_init(var_01);
  }

  for(;;) {
    param_00 waittill("trigger", var_02);
    param_00 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_01, var_02);
    if(!isDefined(param_00)) {
      break;
    }
  }
}

trigger_friendly_respawn(param_00) {
  param_00 endon("death");
  var_01 = getent(param_00.target, "targetname");
  var_02 = undefined;
  if(isDefined(var_01)) {
    var_02 = var_01.origin;
    var_01 delete();
  } else {
    var_01 = scripts\engine\utility::getstruct(param_00.target, "targetname");
    var_02 = var_01.origin;
  }

  for(;;) {
    param_00 waittill("trigger");
    level.respawn_threshold = var_02;
    scripts\engine\utility::flag_set("respawn_friendlies");
    wait(0.5);
  }
}

func_1275E(param_00) {
  var_01 = param_00 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_01])) {
    scripts\engine\utility::flag_init(var_01);
  }

  if(!isDefined(level.var_A842)) {
    level.var_A842 = [];
  }

  for(;;) {
    param_00 waittill("trigger", var_02);
    if(isalive(var_02) && isDefined(param_00) && var_02 istouching(param_00)) {
      level.var_A842 = scripts\engine\utility::array_add(level.var_A842, param_00);
    }

    while(isalive(var_02) && isDefined(param_00) && var_02 istouching(param_00)) {
      if(!scripts\engine\utility::flag(var_01)) {
        thread func_1275F(var_01);
      }

      wait(0.25);
    }

    level.var_A842 = scripts\engine\utility::array_remove(level.var_A842, param_00);
  }
}

func_1275F(param_00) {
  scripts\engine\utility::flag_set(param_00);
  for(;;) {
    level.var_A842 = scripts\engine\utility::array_removeundefined(level.var_A842);
    if(level.var_A842.size == 0) {
      break;
    }

    wait(0.25);
  }

  scripts\engine\utility::flag_clear(param_00);
}

func_12794(param_00) {
  param_00 _meth_84C0(1);
  if(isDefined(param_00.target)) {
    var_01 = getent(param_00.target, "targetname");
    param_00 enablelinkto();
    param_00 linkto(var_01);
  }
}

func_12723(param_00) {
  param_00 _meth_84C0(1);
  if(isDefined(param_00.target)) {
    var_01 = getent(param_00.target, "targetname");
    param_00 enablelinkto();
    param_00 linkto(var_01);
  }
}

func_12744(param_00) {
  var_01 = param_00 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_01])) {
    scripts\engine\utility::flag_init(var_01);
  }

  for(;;) {
    param_00 waittill("trigger", var_02);
    param_00 scripts\sp\utility::script_delay();
    if(isalive(var_02) && isDefined(param_00) && var_02 istouching(param_00)) {
      scripts\engine\utility::flag_set(var_01);
    }

    while(isalive(var_02) && isDefined(param_00) && var_02 istouching(param_00)) {
      wait(0.25);
    }

    scripts\engine\utility::flag_clear(var_01);
  }
}

trigger_friendly_stop_respawn(param_00) {
  for(;;) {
    param_00 waittill("trigger");
    scripts\engine\utility::flag_clear("respawn_friendlies");
  }
}

func_1274C() {
  thread func_1274D();
  level endon("trigger_group_" + self.var_EEEE);
  self waittill("trigger");
  level notify("trigger_group_" + self.var_EEEE, self);
}

func_1274D() {
  level waittill("trigger_group_" + self.var_EEEE, var_00);
  if(self != var_00) {
    self delete();
  }
}

func_12777(param_00) {
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isalive(var_01)) {
      continue;
    }

    var_01.var_10264 = 1;
    var_01 thread func_F611();
  }
}

func_F611() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait(2);
  self.var_10264 = undefined;
}

func_1277E(param_00) {
  var_01 = [];
  var_02 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  var_03 = getEntArray(param_00.target, "targetname");
  foreach(var_05 in var_03) {
    var_06 = spawnStruct();
    var_06.origin = var_05.origin;
    var_06.script_parameters = var_05.script_parameters;
    var_06.script_damage = var_05.script_damage;
    var_06.fgetarg = var_05.fgetarg;
    var_02[var_02.size] = var_06;
    var_05 delete();
  }

  param_00.var_C6EA = var_02[0].origin;
  param_00 waittill("trigger");
  param_00 scripts\sp\utility::script_delay();
  foreach(var_06 in var_02) {
    var_09 = var_06.fgetarg;
    var_0A = var_06.script_parameters;
    var_0B = var_06.script_damage;
    if(!isDefined(var_09)) {
      var_09 = 350;
    }

    if(!isDefined(var_0A)) {
      var_0A = 0.25;
    }

    setdvar("tempdvar", var_0A);
    var_0A = getdvarfloat("tempdvar");
    if(isDefined(var_0B)) {
      radiusdamage(var_06.origin, var_09, var_0B, var_0B * 0.5);
    }

    physicsexplosionsphere(var_06.origin, var_09, var_09 * 0.5, var_0A);
  }
}

func_12780(param_00) {
  var_01 = param_00.var_EEEF;
  param_00 waittill("trigger");
  var_02 = getaiarray();
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(!isalive(var_02[var_03])) {
      continue;
    }

    if(isDefined(var_02[var_03].var_EEEF) && var_02[var_03].var_EEEF == var_01) {
      var_02[var_03].objective_playermask_showto = 800;
      var_02[var_03] setgoalentity(level.player);
      level thread lib_0B77::func_50F5(var_02[var_03]);
    }
  }
}

func_1278E(param_00) {
  var_01 = scripts\engine\utility::create_flags_and_return_tokens(param_00.script_flag_false);
  param_00 func_1786(var_01);
  param_00 scripts\engine\utility::update_trigger_based_on_flags();
}

func_1278F(param_00) {
  var_01 = scripts\engine\utility::create_flags_and_return_tokens(param_00.script_flag_true);
  param_00 func_1786(var_01);
  param_00 scripts\engine\utility::update_trigger_based_on_flags();
}

func_1786(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    var_02 = param_00[var_01];
    if(!isDefined(level.trigger_flags[var_02])) {
      level.trigger_flags[var_02] = [];
    }

    level.trigger_flags[var_02][level.trigger_flags[var_02].size] = self;
  }
}

func_1279A(param_00) {
  waittillframeend;
  var_01 = param_00.var_EEBA;
  if(!isDefined(level.spawn_group) || !isDefined(level.var_10727[var_01])) {
    return;
  }

  param_00 waittill("trigger");
  var_02 = scripts\engine\utility::random(level.var_10727[var_01]);
  foreach(var_04 in var_02) {
    var_04 scripts\sp\utility::func_10619();
  }
}

func_1279E(param_00) {
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(getdvarint("sm_sunenable") == 0) {
      continue;
    }

    setsaveddvar("sm_sunenable", 0);
  }
}

func_1279F(param_00) {
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(getdvarint("sm_sunenable") == 1) {
      continue;
    }

    setsaveddvar("sm_sunenable", 1);
  }
}

func_127AC(param_00) {
  param_00 waittill("trigger");
  var_01 = getEntArray(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    var_03 thread scripts\sp\vehicle_code::func_10809(70);
    wait(0.05);
  }
}

func_7D1F() {
  var_00 = [];
  var_01 = undefined;
  if(isDefined(self.target)) {
    var_02 = getEntArray(self.target, "targetname");
    var_03 = [];
    foreach(var_05 in var_02) {
      if(var_05.classname == "script_origin") {
        var_03[var_03.size] = var_05;
      }

      if(issubstr(var_05.classname, "trigger")) {
        var_00[var_00.size] = var_05;
      }
    }

    var_02 = scripts\engine\utility::getstructarray(self.target, "targetname");
    foreach(var_05 in var_02) {
      var_03[var_03.size] = var_05;
    }

    if(var_03.size == 1) {
      var_09 = var_03[0];
      var_01 = var_09.origin;
      if(isDefined(var_09.var_9F)) {
        var_09 delete();
      }
    }
  }

  var_0A = [];
  var_0A["triggers"] = var_00;
  var_0A["target_origin"] = var_01;
  return var_0A;
}

func_12760(param_00) {
  func_12761(param_00, 1);
}

func_12762(param_00) {
  func_12761(param_00, 0);
}

func_12761(param_00, param_01) {
  var_02 = 0.78;
  if(isDefined(param_00.var_ED6D)) {
    var_02 = param_00.var_ED6D;
  }

  var_03 = param_00 func_7D1F();
  var_04 = var_03["triggers"];
  var_05 = var_03["target_origin"];
  var_06 = isDefined(param_00.var_ED9A) || isDefined(param_00.script_noteworthy);
  var_07 = undefined;
  if(var_06) {
    var_07 = param_00 scripts\sp\utility::func_7D1E();
    if(!isDefined(level.flag[var_07])) {
      scripts\engine\utility::flag_init(var_07);
    }
  } else if(!var_04.size) {}

  if(param_01 && var_06) {
    level endon(var_07);
  }

  param_00 endon("death");
  var_08 = 1;
  if(isDefined(param_00.var_EE61)) {
    var_08 = param_00.var_EE61;
  }

  for(;;) {
    if(var_06) {
      scripts\engine\utility::flag_clear(var_07);
    }

    param_00 waittill("trigger", var_09);
    var_0A = [];
    while(var_09 istouching(param_00)) {
      if(var_08 && !sighttracepassed(var_09 getEye(), var_05, 0, undefined)) {
        if(var_06) {
          scripts\engine\utility::flag_clear(var_07);
        }

        wait(0.5);
        continue;
      }

      var_0B = vectornormalize(var_05 - var_09.origin);
      var_0C = var_09 getplayerangles();
      var_0D = anglesToForward(var_0C);
      var_0E = vectordot(var_0D, var_0B);
      if(var_0E >= var_02) {
        scripts\engine\utility::array_thread(var_04, ::scripts\sp\utility::func_F225, "trigger");
        if(var_06) {
          scripts\engine\utility::flag_set(var_07, var_09);
        }

        if(param_01) {
          return;
        }

        wait(2);
      } else if(var_06) {
        scripts\engine\utility::flag_clear(var_07);
      }

      if(var_08) {
        wait(0.5);
        continue;
      }

      wait(0.05);
    }
  }
}

func_1272B(param_00) {
  var_01 = [];
  var_02 = undefined;
  var_03 = param_00 func_7D1F();
  var_01 = var_03["triggers"];
  var_02 = var_03["target_origin"];
  var_04 = isDefined(param_00.var_ED9A) || isDefined(param_00.script_noteworthy);
  var_05 = undefined;
  if(var_04) {
    var_05 = param_00 scripts\sp\utility::func_7D1E();
    if(!isDefined(level.flag[var_05])) {
      scripts\engine\utility::flag_init(var_05);
    }
  } else if(!var_01.size) {}

  param_00 endon("death");
  var_06 = 12;
  var_07 = [];
  var_07[var_07.size] = (0, 0, 0);
  var_07[var_07.size] = (var_06, 0, 0);
  var_07[var_07.size] = (var_06 * -1, 0, 0);
  var_07[var_07.size] = (0, var_06, 0);
  var_07[var_07.size] = (0, var_06 * -1, 0);
  var_07[var_07.size] = (0, 0, var_06);
  for(;;) {
    if(var_04) {
      scripts\engine\utility::flag_clear(var_05);
    }

    param_00 waittill("trigger", var_08);
    while(level.player istouching(param_00)) {
      if(!var_08 func_392A(var_02, var_07)) {
        if(var_04) {
          scripts\engine\utility::flag_clear(var_05);
        }

        wait(0.1);
        continue;
      }

      if(var_04) {
        scripts\engine\utility::flag_set(var_05);
      }

      scripts\engine\utility::array_thread(var_01, ::scripts\sp\utility::func_F225, "trigger");
      wait(0.5);
    }
  }
}

func_392A(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    if(sighttracepassed(self getEye(), param_00 + param_01[var_02], 1, self)) {
      return 1;
    }
  }

  return 0;
}

func_127A8(param_00) {
  var_01 = "not_set";
  if(isDefined(param_00.script_noteworthy)) {
    var_01 = param_00.script_noteworthy;
  }

  var_02 = getEntArray(param_00.target, "targetname");
  param_00 thread func_127A9(param_00.target);
  for(;;) {
    scripts\engine\utility::array_thread(var_02, ::scripts\engine\utility::trigger_off);
    param_00 waittill("trigger");
    scripts\engine\utility::array_thread(var_02, ::scripts\engine\utility::trigger_on);
    func_135AA(var_02, var_01);
    scripts\sp\utility::func_22A4(var_02, "relock");
  }
}

func_127A9(param_00) {
  self waittill("death");
  var_01 = getEntArray(param_00, "targetname");
  scripts\engine\utility::array_thread(var_01, ::scripts\engine\utility::trigger_off);
}

func_135AA(param_00, param_01) {
  level endon("unlocked_trigger_hit" + param_01);
  var_02 = spawnStruct();
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    param_00[var_03] thread func_E1A0(var_02, param_01);
  }

  var_02 waittill("trigger");
  level notify("unlocked_trigger_hit" + param_01);
}

func_E1A0(param_00, param_01) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + param_01);
  self waittill("trigger");
  param_00 notify("trigger");
}

func_12729(param_00) {
  var_01 = undefined;
  if(isDefined(param_00.target)) {
    var_02 = getEntArray(param_00.target, "targetname");
    if(issubstr(var_02[0].classname, "trigger")) {
      var_01 = var_02[0];
    }
  }

  if(isDefined(var_01)) {
    var_01 waittill("trigger", var_03);
  } else {
    var_01 waittill("trigger", var_03);
  }

  var_04 = undefined;
  if(isDefined(var_01)) {
    if(var_03.team != level.player.team && level.player istouching(param_00)) {
      var_04 = level.player scripts\anim\battlechatter::func_7E32("custom");
    } else if(var_03.team == level.player.team) {
      var_05 = "axis";
      if(level.player.team == "axis") {
        var_05 = "allies";
      }

      var_06 = scripts\anim\battlechatter::_meth_8145("custom", var_05);
      var_06 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_06);
      foreach(var_08 in var_06) {
        if(var_08 istouching(param_00)) {
          var_04 = var_08;
          if(func_28D5(var_08.origin)) {
            break;
          }
        }
      }
    }
  } else if(isplayer(var_03)) {
    var_04 = var_03 scripts\anim\battlechatter::func_7E32("custom");
  } else {
    var_04 = var_03;
  }

  if(!isDefined(var_04)) {
    return;
  }

  if(func_28D5()) {
    return;
  }

  var_0A = var_04 scripts\sp\utility::func_4C39(param_00.var_ED18);
  if(!var_0A) {
    level scripts\engine\utility::delaythread(0.25, ::func_12729, param_00);
    return;
  }

  param_00 notify("custom_battlechatter_done");
}

func_28D5(param_00) {
  return distancesquared(param_00, level.player getorigin()) <= 262144;
}

func_12734(param_00) {
  param_00 waittill("trigger");
  var_01 = getEntArray(param_00.target, "targetname");
  var_02 = [];
  var_02["left_door"] = -170;
  var_02["right_door"] = 170;
  foreach(var_04 in var_01) {
    var_05 = var_02[var_04.script_noteworthy];
    var_04 connectpaths();
    var_04 rotateyaw(var_05, 1, 0, 0.5);
  }
}

func_1274B(param_00) {
  var_01 = getglassarray(param_00.target);
  if(!isDefined(var_01) || var_01.size == 0) {
    return;
  }

  for(;;) {
    level waittill("glass_break", var_02);
    if(var_02 istouching(param_00)) {
      var_03 = var_02.origin;
      wait(0.05);
      var_04 = var_02.origin;
      var_05 = undefined;
      if(var_03 != var_04) {
        var_05 = var_04 - var_03;
      }

      if(isDefined(var_05)) {
        foreach(var_07 in var_01) {
          destroyglass(var_07, var_05);
        }

        break;
      } else {
        foreach(var_07 in var_01) {
          destroyglass(var_07);
        }

        break;
      }
    }
  }

  param_00 delete();
}

func_12730(param_00) {
  param_00 waittill("trigger");
  var_01 = param_00 func_7C30();
  scripts\engine\utility::array_thread(var_01, ::func_5169);
}

func_7C30() {
  var_00 = [];
  if(!isDefined(self.script_linkto)) {
    return var_00;
  }

  var_01 = strtok(self.script_linkto, " ");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    var_04 = getent(var_03, "script_linkname");
    if(isDefined(var_04)) {
      var_00[var_00.size] = var_04;
    }
  }

  return var_00;
}

func_5169() {
  var_00 = func_7C30();
  scripts\engine\utility::array_thread(var_00, ::func_5169);
  self delete();
}

func_127A5(param_00) {
  param_00 endon("death");
  param_00 waittill("trigger");
  scripts\sp\utility::func_11813();
}

func_1274E(param_00) {
  if(!isDefined(level.var_56D9)) {
    level.var_56D9 = [];
  }

  waittillframeend;
  var_01 = param_00.var_EDDC;
  param_00 waittill("trigger", var_02);
  if(isDefined(level.var_56D9[var_01])) {
    return;
  }

  level.var_56D9[var_01] = 1;
  var_02 scripts\sp\utility::func_56BA(var_01);
}

func_12731(param_00) {
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isDefined(var_01)) {
      var_01 delete();
    }
  }
}

func_127A6(param_00) {
  param_00 waittill("trigger");
  param_00 scripts\engine\utility::trigger_off();
  if(!isDefined(param_00.script_linkto)) {
    return;
  }

  var_01 = strtok(param_00.script_linkto, " ");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    scripts\engine\utility::array_thread(getEntArray(var_01[var_02], "script_linkname"), ::scripts\engine\utility::trigger_off);
  }
}

func_12752(param_00) {
  thread func_1278D(param_00, ::scripts\sp\utility::func_F416, ::scripts\sp\utility::func_7A31);
}

func_1277C(param_00) {
  thread func_1278D(param_00, ::scripts\sp\utility::func_F4B2, ::scripts\sp\utility::func_7B61);
}

func_1278D(param_00, param_01, param_02) {
  for(;;) {
    param_00 waittill("trigger", var_03);
    if(!isalive(var_03)) {
      continue;
    }

    if(var_03[[param_02]]()) {
      continue;
    }

    var_03 thread func_11A40(param_00, param_01);
  }
}

func_11A40(param_00, param_01) {
  self endon("death");
  self.ignoreme = 1;
  [
    [param_01]
  ](1);
  self.precacheshader = 1;
  wait(1);
  self.precacheshader = 0;
  while(self istouching(param_00)) {
    wait(1);
  }

  [
    [param_01]
  ](0);
}

func_12787(param_00) {
  param_00 waittill("trigger");
  scripts\sp\utility::func_DBEF(param_00.script_noteworthy);
}

func_12741(param_00) {
  var_01 = param_00 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_01])) {
    scripts\engine\utility::flag_init(var_01);
  }

  for(;;) {
    param_00 waittill("trigger", var_02);
    if(!isplayer(var_02)) {
      continue;
    }

    param_00 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_01);
  }
}

func_12771(param_00) {
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isDefined(param_00.script_noteworthy)) {
      var_01 scripts\sp\art::func_1121E(param_00.script_noteworthy, param_00.script_delay);
    }

    scripts\engine\utility::waitframe();
  }
}

func_1276A(param_00) {
  waittillframeend;
  for(;;) {
    param_00 waittill("trigger", var_01);
    var_02 = param_00.var_ED68;
    var_03 = param_00.var_ED67;
    var_04 = param_00.var_ED66;
    var_05 = param_00.var_ED65;
    var_06 = param_00.var_ED64;
    var_07 = param_00.var_ED63;
    var_08 = param_00.script_delay;
    if(var_02 != level.var_5832["base"]["goal"]["nearStart"] || var_03 != level.var_5832["base"]["goal"]["nearEnd"] || var_04 != level.var_5832["base"]["goal"]["nearBlur"] || var_05 != level.var_5832["base"]["goal"]["farStart"] || var_06 != level.var_5832["base"]["goal"]["farEnd"] || var_07 != level.var_5832["base"]["goal"]["farBlur"]) {
      scripts\sp\art::func_5848(var_02, var_03, var_04, var_05, var_06, var_07, var_08);
      wait(var_08);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_12772(param_00) {
  if(level.var_13E0F || level.var_DADB) {
    return;
  }

  waittillframeend;
  for(;;) {
    param_00 waittill("trigger", var_01);
    var_02 = param_00.var_EEDF;
    var_03 = param_00.var_EEE0;
    var_04 = param_00.script_delay;
    if(var_02 != level.var_11714.var_4CA6 || var_03 != level.var_11714.var_4CA8) {
      var_02 = max(0, var_02);
      var_02 = min(10000, var_02);
      var_03 = max(0, var_03);
      var_03 = min(10000, var_03);
      scripts\sp\art::func_11716(var_02, var_03, var_04);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_12792(param_00) {
  setdvarifuninitialized("use_legacy_slide", 0);
  for(;;) {
    param_00 waittill("trigger", var_01);
    var_01 thread func_102ED(param_00);
  }
}

func_102ED(param_00) {
  if(isDefined(self.vehicle)) {
    return;
  }

  if(scripts\sp\utility::func_9F59() || self isjumping() || scripts\sp\utility::func_9C11() || lib_0E4F::func_9C7B()) {
    return;
  }

  if(isDefined(self.var_D323)) {
    return;
  }

  self endon("death");
  if(soundexists("SCN_cliffhanger_player_hillslide")) {
    self playSound("SCN_cliffhanger_player_hillslide");
  }

  var_01 = undefined;
  if(isDefined(param_00.script_accel)) {
    var_01 = param_00.script_accel;
  }

  self endon("cancel_sliding");
  if(getdvarint("use_legacy_slide") > 0) {
    thread scripts\sp\utility::func_2A76();
  } else {
    thread scripts\sp\utility::func_2A75(undefined, var_01);
  }

  for(;;) {
    if(!self istouching(param_00)) {
      break;
    }

    wait(0.05);
  }

  if(isDefined(level.var_62F7)) {
    wait(level.var_62F7);
  }

  if(getdvarint("use_legacy_slide") > 0) {
    scripts\sp\utility::func_638A();
    return;
  }

  scripts\sp\utility::func_6389();
}

func_1276E(param_00) {
  var_01 = spawn("script_origin", (0, 0, 0));
  param_00.fx = [];
  foreach(var_03 in level.createfxent) {
    func_23C8(var_03, param_00, var_01);
  }

  var_01 delete();
  if(!isDefined(param_00.target)) {
    return;
  }

  var_05 = getEntArray(param_00.target, "targetname");
  param_00.var_75AD = 1;
  foreach(var_07 in var_05) {
    switch (var_07.classname) {
      case "trigger_multiple_fx_volume_on":
        var_07 thread func_1276D(param_00);
        break;

      case "trigger_multiple_fx_volume_off":
        var_07 thread func_1276C(param_00);
        break;

      default:
        break;
    }
  }
}

func_1276D(param_00) {
  for(;;) {
    self waittill("trigger");
    if(!param_00.var_75AD) {
      scripts\engine\utility::array_thread(param_00.fx, ::scripts\sp\utility::func_E2B0);
    }

    wait(1);
  }
}

func_1276C(param_00) {
  for(;;) {
    self waittill("trigger");
    if(param_00.var_75AD) {
      scripts\engine\utility::array_thread(param_00.fx, ::scripts\engine\utility::pauseeffect);
    }

    wait(1);
  }
}

func_23C8(param_00, param_01, param_02) {
  if(isDefined(param_00.v["soundalias"]) && param_00.v["soundalias"] != "nil") {
    if(!isDefined(param_00.v["stopable"]) || !param_00.v["stopable"]) {
      return;
    }
  }

  param_02.origin = param_00.v["origin"];
  if(param_02 istouching(param_01)) {
    param_01.fx[param_01.fx.size] = param_00;
  }
}

func_12769(param_00) {
  var_01 = param_00.script_parameters;
  if(!isDefined(level.var_B7AE)) {
    level.var_B7AE = "";
  }

  for(;;) {
    param_00 waittill("trigger");
    if(level.var_B7AE != var_01) {
      scripts\sp\compass::setupminimap(var_01);
    }
  }
}

func_12775(param_00) {
  scripts\engine\utility::array_thread(level.players, ::func_BFE5, param_00);
}

func_BFE5(param_00) {
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isDefined(var_01)) {
      continue;
    }

    if(var_01 != self) {
      continue;
    }

    while(var_01 istouching(param_00)) {
      var_01 allowprone(0);
      var_01 allowcrouch(0);
      wait(0.05);
    }

    var_01 allowprone(1);
    var_01 allowcrouch(1);
  }
}

func_1275A(param_00) {
  if(!isDefined(level.var_A0E4)) {
    level.var_A0E4 = 0;
  }

  param_00.var_12751 = level.var_A0E4;
  level.var_A0E4++;
  param_00.var_C75B = scripts\engine\utility::getstruct(param_00.target, "targetname");
  param_00.var_98F5 = scripts\engine\utility::getstruct(param_00.var_C75B.target, "targetname");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isDefined(level.var_D127) || var_01 != level.var_D127) {
      continue;
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_push")) {
      continue;
    }

    param_00 thread[[level.var_A056.trigger_func.var_A0E2]]();
    while(isalive(var_01) && isDefined(param_00) && var_01 istouching(param_00) && isDefined(level.var_D127)) {
      wait(0.05);
    }

    param_00 thread[[level.var_A056.trigger_func.var_A0E3]]();
  }
}

func_1275B(param_00) {
  var_01 = "trigger_jackal_boundary_warning";
  if(!isDefined(level.var_A392)) {
    level.var_A392 = [];
  }

  if(!scripts\engine\utility::flag_exist(var_01)) {
    scripts\engine\utility::flag_init(var_01);
  }

  var_02 = scripts\engine\utility::getstruct(param_00.target, "targetname");
  if(!isDefined(var_02)) {
    var_02 = getent(param_00.target, "targetname");
    var_03 = 1;
  } else {
    var_03 = 0;
  }

  for(;;) {
    param_00 waittill("trigger", var_04);
    if(!isDefined(level.var_D127) || var_04 != level.var_D127) {
      continue;
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning")) {
      while(isalive(var_04) && isDefined(param_00) && var_04 istouching(param_00) && isDefined(level.var_D127) && level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning")) {
        wait(0.05);
      }
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning")) {
      continue;
    }

    if(!scripts\engine\utility::flag(var_01)) {
      scripts\engine\utility::flag_set(var_01);
      var_02 thread func_A391(var_04, var_03, var_01);
      level.var_A392 = scripts\engine\utility::array_add(level.var_A392, param_00);
    }

    while(isalive(var_04) && isDefined(param_00) && var_04 istouching(param_00) && isDefined(level.var_D127)) {
      wait(0.05);
    }

    level.var_A392 = scripts\engine\utility::array_remove(level.var_A392, param_00);
    if(level.var_A392.size == 0) {
      scripts\engine\utility::flag_clear(var_01);
    }
  }
}

func_A391(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_03.var_138F0 = 0;
  var_04 = 0;
  if(param_01) {
    var_05 = getpartname(self.model, 0);
    var_03 linkto(self, var_05, (0, 0, 0), (0, 0, 0));
  } else {
    var_03.origin = self.origin;
  }

  var_06 = 0;
  while(var_06 < 1) {
    if(scripts\engine\utility::flag(param_02) || scripts\engine\utility::flag("jackal_is_autoturning")) {
      var_06 = 0;
    } else {
      var_06++;
    }

    var_07 = vectornormalize(self.origin - level.var_D127.origin);
    var_08 = anglesToForward(level.var_D127.angles);
    var_09 = vectordot(var_07, var_08);
    var_0A = vectornormalize(level.var_D127._func_2AC);
    var_0B = vectordot(var_07, var_0A);
    if(var_09 > 0.1 && var_0B > 0.1) {
      if(var_04) {
        var_04 = 0;
        var_03[[level.var_A056.trigger_func.var_A0E5]](var_04);
      }

      continue;
    }

    if(!var_04) {
      var_04 = 1;
      var_03[[level.var_A056.trigger_func.var_A0E5]](var_04);
    }

    wait(0.05);
  }

  var_03[[level.var_A056.trigger_func.var_A0E5]](0);
  var_03 delete();
}

func_12759(param_00) {
  var_01 = "trigger_jackal_boundary_autoturn";
  var_02 = "jackal_is_autoturning";
  if(!scripts\engine\utility::flag_exist(var_01)) {
    scripts\engine\utility::flag_init(var_01);
  }

  if(!scripts\engine\utility::flag_exist(var_02)) {
    scripts\engine\utility::flag_init(var_02);
  }

  var_03 = scripts\engine\utility::getstruct(param_00.target, "targetname");
  for(;;) {
    param_00 waittill("trigger", var_04);
    if(!isDefined(level.var_D127) || var_04 != level.var_D127 || scripts\engine\utility::flag(var_01)) {
      continue;
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn")) {
      while(isalive(var_04) && isDefined(param_00) && var_04 istouching(param_00) && isDefined(level.var_D127) && level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn")) {
        wait(0.05);
      }
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn")) {
      continue;
    }

    if(!scripts\engine\utility::flag(var_01)) {
      scripts\engine\utility::flag_set(var_01);
      if(!scripts\engine\utility::flag(var_02)) {
        var_03 thread[[level.var_A056.trigger_func.var_A0E1]](param_00, var_04, var_01, var_02);
      }

      level.var_A056.var_2698 = scripts\engine\utility::array_add(level.var_A056.var_2698, param_00);
    }

    while(isalive(var_04) && isDefined(param_00) && var_04 istouching(param_00) && isDefined(level.var_D127)) {
      wait(0.05);
    }

    level.var_A056.var_2698 = scripts\engine\utility::array_remove(level.var_A056.var_2698, param_00);
    if(level.var_A056.var_2698.size == 0) {
      scripts\engine\utility::flag_clear(var_01);
    }
  }
}

func_1275C(param_00) {
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isDefined(level.var_D127) || var_01 != level.var_D127) {
      continue;
    }

    param_00 func_A2FF();
    while(isalive(var_01) && isDefined(param_00) && var_01 istouching(param_00) && isDefined(level.var_D127)) {
      wait(0.25);
    }

    param_00 func_A300();
  }
}

func_A2FF() {
  if(!isDefined(level.var_A056) || !isDefined(level.var_A056.var_10991)) {
    return;
  }

  level.var_A056.var_10991 = scripts\engine\utility::array_add(level.var_A056.var_10991, self);
  level.var_A056.var_10991 = scripts\engine\utility::array_sort_with_func(level.var_A056.var_10991, ::func_9C91);
  level notify("notify_new_jackal_speed_zone");
}

func_A300() {
  if(!isDefined(level.var_A056) || !isDefined(level.var_A056.var_10991)) {
    return;
  }

  level.var_A056.var_10991 = scripts\engine\utility::array_remove(level.var_A056.var_10991, self);
  level notify("notify_new_jackal_speed_zone");
}

func_9C91(param_00, param_01) {
  return param_00.var_EE8C > param_01.var_EE8C;
}

func_12776(param_00) {
  scripts\engine\utility::array_thread(level.players, ::func_C00E, param_00);
}

func_C00E(param_00) {
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isDefined(var_01)) {
      continue;
    }

    if(var_01 != self) {
      continue;
    }

    while(var_01 istouching(param_00)) {
      var_01 allowprone(0);
      wait(0.05);
    }

    var_01 allowprone(1);
  }
}

exploder_load(param_00) {
  level endon("killexplodertridgers" + param_00.script_exploder);
  param_00 waittill("trigger");
  if(isDefined(param_00.script_chance) && randomfloat(1) > param_00.script_chance) {
    if(!param_00 scripts\sp\utility::script_delay()) {
      wait(4);
    }

    level thread exploder_load(param_00);
    return;
  }

  if(!param_00 scripts\sp\utility::script_delay() && isDefined(param_00.var_ED85)) {
    wait(param_00.var_ED85);
  }

  scripts\engine\utility::exploder(param_00.script_exploder);
  level notify("killexplodertridgers" + param_00.script_exploder);
}

func_12770(param_00) {
  if(getdvarint("kleenex") != 1) {
    return;
  }

  param_00 waittill("trigger");
  scripts\sp\utility::func_A6F2();
}

func_1279C(param_00) {
  param_00 endon("death");
  var_01 = "stealth_in_shadow";
  for(;;) {
    param_00 waittill("trigger", var_02);
    if(!var_02 scripts\sp\utility::func_65DF(var_01)) {
      continue;
    }

    if(var_02 scripts\sp\utility::func_65DB(var_01)) {
      continue;
    }

    var_02 thread func_93A4(param_00, var_01);
  }
}

func_93A4(param_00, param_01) {
  self endon("death");
  scripts\sp\utility::func_65E1(param_01);
  while(isDefined(param_00) && self istouching(param_00)) {
    wait(0.05);
  }

  scripts\sp\utility::func_65DD(param_01);
}

func_1273C(param_00) {
  param_00 endon("death");
  var_01 = 2;
  var_02 = 2;
  var_03 = 0;
  if(!isDefined(param_00.script_delay_min) && !isDefined(param_00.script_delay_max)) {
    param_00.script_delay_min = 0.3;
    param_00.script_delay_max = 0.9;
  }

  if(isDefined(param_00.script_damage)) {
    var_01 = param_00.script_damage;
  }

  for(;;) {
    param_00 waittill("trigger", var_04);
    var_05 = param_00.origin;
    if(isplayer(var_04)) {
      var_03 = var_01;
      if(param_00.classname == "trigger_radius_fire") {
        if(isDefined(param_00.script_radius)) {
          if(distance2dsquared(var_04.origin, param_00.origin) <= squared(param_00.script_radius)) {
            if(isDefined(param_00.var_EE51) && isnumber(param_00.var_EE51)) {
              var_02 = param_00.var_EE51;
            }

            var_03 = var_03 * var_02;
          }
        }
      } else if(isDefined(param_00.target)) {
        var_06 = scripts\engine\utility::getstruct(param_00.target, "targetname");
        var_05 = var_06.origin;
        if(isDefined(var_06.script_radius)) {
          if(distance2dsquared(var_04.origin, var_06.origin) <= squared(var_06.script_radius)) {
            if(isDefined(param_00.var_EE51) && isnumber(param_00.var_EE51)) {
              var_02 = param_00.var_EE51;
            }

            var_03 = var_03 * var_02;
          }
        }
      }
    }

    var_04 dodamage(var_03, var_05);
    if(var_03 < 6) {
      var_04 playrumbleonentity("damage_light");
    } else {
      var_04 playrumbleonentity("damage_heavy");
    }

    param_00 scripts\sp\utility::script_delay();
  }
}