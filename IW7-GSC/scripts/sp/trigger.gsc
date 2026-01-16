/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\trigger.gsc
*********************************************/

func_7AA4() {
  var_0 = [];
  var_0["trigger_multiple_nobloodpool"] = ::func_12777;
  var_0["trigger_multiple_flag_set"] = ::func_1273F;
  var_0["trigger_multiple_flag_clear"] = ::func_1273D;
  var_0["trigger_multiple_sun_off"] = ::func_1279E;
  var_0["trigger_multiple_sun_on"] = ::func_1279F;
  var_0["trigger_use_flag_set"] = ::func_1273F;
  var_0["trigger_use_flag_clear"] = ::func_1273D;
  var_0["trigger_multiple_flag_set_touching"] = ::func_12744;
  var_0["trigger_multiple_flag_lookat"] = ::func_12760;
  var_0["trigger_multiple_flag_looking"] = ::func_12762;
  var_0["trigger_multiple_no_prone"] = ::func_12776;
  var_0["trigger_multiple_no_crouch_or_prone"] = ::func_12775;
  var_0["trigger_multiple_compass"] = ::func_12769;
  var_0["trigger_multiple_fx_volume"] = ::func_1276E;
  var_0["trigger_multiple_kleenex"] = ::func_12770;
  var_0["trigger_multiple_light_sunshadow"] = scripts\sp\lights::func_11203;
  var_0["trigger_multiple_jackal_boundary_autoturn"] = ::func_12759;
  var_0["trigger_multiple_jackal_boundary_warning"] = ::func_1275B;
  var_0["trigger_multiple_jackal_boundary_push"] = ::func_1275A;
  var_0["trigger_multiple_jackal_speed_touching"] = ::func_1275C;
  var_0["trigger_multiple_landingzone"] = ::func_1275E;
  var_0["trigger_multiple_arbitrary_up"] = ::func_12723;
  var_0["trigger_multiple_spacejump"] = ::func_12794;
  if(!scripts\sp\starts::func_9C4B()) {
    var_0["trigger_multiple_autosave"] = scripts\sp\autosave::func_12724;
    var_0["trigger_multiple_spawn"] = lib_0B77::func_12797;
    var_0["trigger_multiple_spawn_reinforcement"] = lib_0B77::func_12798;
  }

  var_0["trigger_multiple_slide"] = ::func_12792;
  var_0["trigger_multiple_depthoffield"] = ::func_1276A;
  var_0["trigger_multiple_tessellationcutoff"] = ::func_12772;
  var_0["trigger_damage_player_flag_set"] = ::func_1272F;
  var_0["trigger_multiple_sunflare"] = ::func_12771;
  var_0["trigger_multiple_glass_break"] = ::func_1274B;
  var_0["trigger_radius_glass_break"] = ::func_1274B;
  var_0["trigger_multiple_friendly_respawn"] = ::trigger_friendly_respawn;
  var_0["trigger_multiple_friendly_stop_respawn"] = ::trigger_friendly_stop_respawn;
  var_0["trigger_multiple_physics"] = ::func_1277E;
  var_0["trigger_multiple_fx_watersheeting"] = ::func_1276F;
  var_0["trigger_multiple_fakeactor_move"] = scripts\sp\fakeactor::func_12735;
  var_0["trigger_multiple_fakeactor_node_disable"] = scripts\sp\fakeactor::func_12736;
  var_0["trigger_multiple_fakeactor_node_enable"] = scripts\sp\fakeactor::func_12738;
  var_0["trigger_multiple_fakeactor_node_disablegroup"] = scripts\sp\fakeactor::func_12737;
  var_0["trigger_multiple_fakeactor_node_enablegroup"] = scripts\sp\fakeactor::func_12739;
  var_0["trigger_multiple_fakeactor_node_passthrough"] = scripts\sp\fakeactor::func_1273B;
  var_0["trigger_multiple_fakeactor_node_lock"] = scripts\sp\fakeactor::func_1273A;
  var_0["trigger_multiple_geo_mover"] = scripts\sp\geo_mover::func_12764;
  var_0["trigger_multiple_transient"] = ::func_12773;
  var_0["trigger_multiple_fire"] = ::func_1273C;
  var_0["trigger_radius_fire"] = ::func_1273C;
  return var_0;
}

func_1276F(var_0) {
  var_1 = 3;
  if(isDefined(var_0.var_ED75)) {
    var_1 = var_0.var_ED75;
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    if(isplayer(var_2)) {
      var_2 setwatersheeting(1, var_1);
      wait(var_1 * 0.2);
    }
  }
}

func_7AA5() {
  var_0 = [];
  var_0["friendly_mgTurret"] = lib_0B77::func_73D9;
  if(!scripts\sp\starts::func_9C4B()) {
    var_0["camper_spawner"] = lib_0B77::camper_trigger_think;
    var_0["flood_spawner"] = lib_0B77::func_6F5D;
    var_0["trigger_spawner"] = lib_0B77::func_12797;
    var_0["trigger_autosave"] = scripts\sp\autosave::func_12724;
    var_0["trigger_spawngroup"] = ::func_1279A;
    var_0["trigger_vehicle_spline_spawn"] = ::func_127AC;
    var_0["trigger_vehicle_spawn"] = lib_0B77::func_12797;
    var_0["random_spawn"] = lib_0B77::func_DC9B;
  }

  var_0["autosave_now"] = scripts\sp\autosave::func_2671;
  var_0["trigger_autosave_tactical"] = scripts\sp\autosave::func_12727;
  var_0["trigger_autosave_stealth"] = scripts\sp\autosave::func_12726;
  var_0["trigger_unlock"] = ::func_127A8;
  var_0["trigger_lookat"] = ::func_12760;
  var_0["trigger_looking"] = ::func_12762;
  var_0["trigger_cansee"] = ::func_1272B;
  var_0["flag_set"] = ::func_1273F;
  var_0["flag_set_player"] = ::func_12741;
  var_0["flag_unset"] = ::func_1273D;
  var_0["flag_clear"] = ::func_1273D;
  var_0["friendly_respawn_trigger"] = ::trigger_friendly_respawn;
  var_0["radio_trigger"] = ::func_12787;
  var_0["trigger_ignore"] = ::func_12752;
  var_0["trigger_pacifist"] = ::func_1277C;
  var_0["trigger_delete"] = ::func_127A6;
  var_0["trigger_delete_on_touch"] = ::func_12731;
  var_0["trigger_off"] = ::func_127A6;
  var_0["trigger_outdoor"] = lib_0B77::func_C75A;
  var_0["trigger_indoor"] = lib_0B77::func_9409;
  var_0["trigger_hint"] = ::func_1274E;
  var_0["trigger_grenade_at_player"] = ::func_127A5;
  var_0["flag_on_cleared"] = ::func_1273E;
  var_0["flag_set_touching"] = ::func_12744;
  var_0["delete_link_chain"] = ::func_12730;
  var_0["trigger_slide"] = ::func_12792;
  var_0["trigger_dooropen"] = ::func_12734;
  var_0["stealth_shadow"] = ::func_1279C;
  var_0["geo_mover"] = scripts\sp\geo_mover::func_12764;
  var_0["no_crouch_or_prone"] = ::func_12775;
  var_0["no_prone"] = ::func_12776;
  return var_0;
}

func_9726() {
  scripts\sp\colors::init_colors();
  scripts\sp\audio::init_audio();
  scripts\sp\utility::func_228A(getEntArray("trigger_multiple_softlanding", "classname"));
  var_0 = func_7AA4();
  var_1 = func_7AA5();
  foreach(var_5, var_3 in var_0) {
    var_4 = getEntArray(var_5, "classname");
    scripts\engine\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getEntArray("trigger_multiple", "classname");
  var_7 = getEntArray("trigger_radius", "classname");
  var_4 = scripts\sp\utility::func_22A2(var_6, var_7);
  var_8 = getEntArray("trigger_disk", "classname");
  var_4 = scripts\sp\utility::func_22A2(var_4, var_8);
  var_9 = getEntArray("trigger_once", "classname");
  var_4 = scripts\sp\utility::func_22A2(var_4, var_9);
  if(!scripts\sp\starts::func_9C4B()) {
    for(var_0A = 0; var_0A < var_4.size; var_0A++) {
      if(var_4[var_0A].spawnimpulsefield & 32) {
        thread lib_0B77::func_12797(var_4[var_0A]);
      }
    }
  }

  var_0B = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage"];
  foreach(var_0D in var_0B) {
    var_4 = getEntArray(var_0D, "code_classname");
    foreach(var_0F in var_4) {
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
        if(isDefined(var_1[var_10])) {
          level thread[[var_1[var_10]]](var_0F);
        }
      }
    }
  }
}

func_1272E(var_0) {
  var_1 = 1;
  if(var_1) {
    var_0 delete();
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

func_12773(var_0) {
  var_2 = undefined;
  var_3 = undefined;
  if(isDefined(var_0.var_EEE7)) {
    var_2 = strtok(var_0.var_EEE7, " ");
  }

  if(isDefined(var_0.var_EEE8)) {
    var_3 = strtok(var_0.var_EEE8, " ");
  }

  if(isDefined(var_2)) {
    foreach(var_5 in var_2) {
      if(!scripts\engine\utility::flag_exist(var_5 + "_loaded")) {
        scripts\engine\utility::flag_init(var_5 + "_loaded");
      }
    }
  }

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      if(!scripts\engine\utility::flag_exist(var_5 + "_loaded")) {
        scripts\engine\utility::flag_init(var_5 + "_loaded");
      }
    }
  }

  for(;;) {
    var_0 waittill("trigger");
    if(isDefined(var_3)) {
      scripts\sp\utility::func_12651(var_3);
    }

    if(isDefined(var_2)) {
      scripts\sp\utility::func_12643(var_2);
    }
  }
}

func_1272F(var_0) {
  var_1 = var_0 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    if(!isalive(var_2)) {
      continue;
    }

    if(!isplayer(var_2)) {
      continue;
    }

    var_0 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_1, var_2);
  }
}

func_1273D(var_0) {
  var_1 = var_0 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger");
    var_0 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_clear(var_1);
  }
}

func_1273E(var_0) {
  var_1 = var_0 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger");
    wait(1);
    if(var_0 func_733E()) {
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_set(var_1);
}

func_733E() {
  var_0 = getaiarray("bad_guys");
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    if(!isalive(var_2)) {
      continue;
    }

    if(var_2 istouching(self)) {
      return 1;
    }

    wait(0.1);
  }

  var_0 = getaiarray("bad_guys");
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    if(var_2 istouching(self)) {
      return 1;
    }
  }

  return 0;
}

func_1273F(var_0) {
  var_1 = var_0 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_1, var_2);
    if(!isDefined(var_0)) {
      break;
    }
  }
}

trigger_friendly_respawn(var_0) {
  var_0 endon("death");
  var_1 = getent(var_0.target, "targetname");
  var_2 = undefined;
  if(isDefined(var_1)) {
    var_2 = var_1.origin;
    var_1 delete();
  } else {
    var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_2 = var_1.origin;
  }

  for(;;) {
    var_0 waittill("trigger");
    level.respawn_threshold = var_2;
    scripts\engine\utility::flag_set("respawn_friendlies");
    wait(0.5);
  }
}

func_1275E(var_0) {
  var_1 = var_0 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  if(!isDefined(level.var_A842)) {
    level.var_A842 = [];
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    if(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      level.var_A842 = scripts\engine\utility::array_add(level.var_A842, var_0);
    }

    while(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      if(!scripts\engine\utility::flag(var_1)) {
        thread func_1275F(var_1);
      }

      wait(0.25);
    }

    level.var_A842 = scripts\engine\utility::array_remove(level.var_A842, var_0);
  }
}

func_1275F(var_0) {
  scripts\engine\utility::flag_set(var_0);
  for(;;) {
    level.var_A842 = scripts\engine\utility::array_removeundefined(level.var_A842);
    if(level.var_A842.size == 0) {
      break;
    }

    wait(0.25);
  }

  scripts\engine\utility::flag_clear(var_0);
}

func_12794(var_0) {
  var_0 func_84C0(1);
  if(isDefined(var_0.target)) {
    var_1 = getent(var_0.target, "targetname");
    var_0 enablelinkto();
    var_0 linkto(var_1);
  }
}

func_12723(var_0) {
  var_0 func_84C0(1);
  if(isDefined(var_0.target)) {
    var_1 = getent(var_0.target, "targetname");
    var_0 enablelinkto();
    var_0 linkto(var_1);
  }
}

func_12744(var_0) {
  var_1 = var_0 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 scripts\sp\utility::script_delay();
    if(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      scripts\engine\utility::flag_set(var_1);
    }

    while(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      wait(0.25);
    }

    scripts\engine\utility::flag_clear(var_1);
  }
}

trigger_friendly_stop_respawn(var_0) {
  for(;;) {
    var_0 waittill("trigger");
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
  level waittill("trigger_group_" + self.var_EEEE, var_0);
  if(self != var_0) {
    self delete();
  }
}

func_12777(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isalive(var_1)) {
      continue;
    }

    var_1.var_10264 = 1;
    var_1 thread func_F611();
  }
}

func_F611() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait(2);
  self.var_10264 = undefined;
}

func_1277E(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  var_3 = getEntArray(var_0.target, "targetname");
  foreach(var_5 in var_3) {
    var_6 = spawnStruct();
    var_6.origin = var_5.origin;
    var_6.script_parameters = var_5.script_parameters;
    var_6.script_damage = var_5.script_damage;
    var_6.fgetarg = var_5.fgetarg;
    var_2[var_2.size] = var_6;
    var_5 delete();
  }

  var_0.var_C6EA = var_2[0].origin;
  var_0 waittill("trigger");
  var_0 scripts\sp\utility::script_delay();
  foreach(var_6 in var_2) {
    var_9 = var_6.fgetarg;
    var_0A = var_6.script_parameters;
    var_0B = var_6.script_damage;
    if(!isDefined(var_9)) {
      var_9 = 350;
    }

    if(!isDefined(var_0A)) {
      var_0A = 0.25;
    }

    setdvar("tempdvar", var_0A);
    var_0A = getdvarfloat("tempdvar");
    if(isDefined(var_0B)) {
      radiusdamage(var_6.origin, var_9, var_0B, var_0B * 0.5);
    }

    physicsexplosionsphere(var_6.origin, var_9, var_9 * 0.5, var_0A);
  }
}

func_12780(var_0) {
  var_1 = var_0.var_EEEF;
  var_0 waittill("trigger");
  var_2 = getaiarray();
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isalive(var_2[var_3])) {
      continue;
    }

    if(isDefined(var_2[var_3].var_EEEF) && var_2[var_3].var_EEEF == var_1) {
      var_2[var_3].objective_playermask_showto = 800;
      var_2[var_3] setgoalentity(level.player);
      level thread lib_0B77::func_50F5(var_2[var_3]);
    }
  }
}

func_1278E(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  var_0 func_1786(var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

func_1278F(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  var_0 func_1786(var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

func_1786(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    if(!isDefined(level.trigger_flags[var_2])) {
      level.trigger_flags[var_2] = [];
    }

    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

func_1279A(var_0) {
  waittillframeend;
  var_1 = var_0.var_EEBA;
  if(!isDefined(level.spawn_group) || !isDefined(level.var_10727[var_1])) {
    return;
  }

  var_0 waittill("trigger");
  var_2 = scripts\engine\utility::random(level.var_10727[var_1]);
  foreach(var_4 in var_2) {
    var_4 scripts\sp\utility::func_10619();
  }
}

func_1279E(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(getdvarint("sm_sunenable") == 0) {
      continue;
    }

    setsaveddvar("sm_sunenable", 0);
  }
}

func_1279F(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(getdvarint("sm_sunenable") == 1) {
      continue;
    }

    setsaveddvar("sm_sunenable", 1);
  }
}

func_127AC(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    var_3 thread scripts\sp\vehicle_code::func_10809(70);
    wait(0.05);
  }
}

func_7D1F() {
  var_0 = [];
  var_1 = undefined;
  if(isDefined(self.target)) {
    var_2 = getEntArray(self.target, "targetname");
    var_3 = [];
    foreach(var_5 in var_2) {
      if(var_5.classname == "script_origin") {
        var_3[var_3.size] = var_5;
      }

      if(issubstr(var_5.classname, "trigger")) {
        var_0[var_0.size] = var_5;
      }
    }

    var_2 = scripts\engine\utility::getstructarray(self.target, "targetname");
    foreach(var_5 in var_2) {
      var_3[var_3.size] = var_5;
    }

    if(var_3.size == 1) {
      var_9 = var_3[0];
      var_1 = var_9.origin;
      if(isDefined(var_9.var_9F)) {
        var_9 delete();
      }
    }
  }

  var_0A = [];
  var_0A["triggers"] = var_0;
  var_0A["target_origin"] = var_1;
  return var_0A;
}

func_12760(var_0) {
  func_12761(var_0, 1);
}

func_12762(var_0) {
  func_12761(var_0, 0);
}

func_12761(var_0, var_1) {
  var_2 = 0.78;
  if(isDefined(var_0.var_ED6D)) {
    var_2 = var_0.var_ED6D;
  }

  var_3 = var_0 func_7D1F();
  var_4 = var_3["triggers"];
  var_5 = var_3["target_origin"];
  var_6 = isDefined(var_0.var_ED9A) || isDefined(var_0.script_noteworthy);
  var_7 = undefined;
  if(var_6) {
    var_7 = var_0 scripts\sp\utility::func_7D1E();
    if(!isDefined(level.flag[var_7])) {
      scripts\engine\utility::flag_init(var_7);
    }
  } else if(!var_4.size) {}

  if(var_1 && var_6) {
    level endon(var_7);
  }

  var_0 endon("death");
  var_8 = 1;
  if(isDefined(var_0.var_EE61)) {
    var_8 = var_0.var_EE61;
  }

  for(;;) {
    if(var_6) {
      scripts\engine\utility::flag_clear(var_7);
    }

    var_0 waittill("trigger", var_9);
    var_0A = [];
    while(var_9 istouching(var_0)) {
      if(var_8 && !sighttracepassed(var_9 getEye(), var_5, 0, undefined)) {
        if(var_6) {
          scripts\engine\utility::flag_clear(var_7);
        }

        wait(0.5);
        continue;
      }

      var_0B = vectornormalize(var_5 - var_9.origin);
      var_0C = var_9 getplayerangles();
      var_0D = anglesToForward(var_0C);
      var_0E = vectordot(var_0D, var_0B);
      if(var_0E >= var_2) {
        scripts\engine\utility::array_thread(var_4, scripts\sp\utility::func_F225, "trigger");
        if(var_6) {
          scripts\engine\utility::flag_set(var_7, var_9);
        }

        if(var_1) {
          return;
        }

        wait(2);
      } else if(var_6) {
        scripts\engine\utility::flag_clear(var_7);
      }

      if(var_8) {
        wait(0.5);
        continue;
      }

      wait(0.05);
    }
  }
}

func_1272B(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = var_0 func_7D1F();
  var_1 = var_3["triggers"];
  var_2 = var_3["target_origin"];
  var_4 = isDefined(var_0.var_ED9A) || isDefined(var_0.script_noteworthy);
  var_5 = undefined;
  if(var_4) {
    var_5 = var_0 scripts\sp\utility::func_7D1E();
    if(!isDefined(level.flag[var_5])) {
      scripts\engine\utility::flag_init(var_5);
    }
  } else if(!var_1.size) {}

  var_0 endon("death");
  var_6 = 12;
  var_7 = [];
  var_7[var_7.size] = (0, 0, 0);
  var_7[var_7.size] = (var_6, 0, 0);
  var_7[var_7.size] = (var_6 * -1, 0, 0);
  var_7[var_7.size] = (0, var_6, 0);
  var_7[var_7.size] = (0, var_6 * -1, 0);
  var_7[var_7.size] = (0, 0, var_6);
  for(;;) {
    if(var_4) {
      scripts\engine\utility::flag_clear(var_5);
    }

    var_0 waittill("trigger", var_8);
    while(level.player istouching(var_0)) {
      if(!var_8 func_392A(var_2, var_7)) {
        if(var_4) {
          scripts\engine\utility::flag_clear(var_5);
        }

        wait(0.1);
        continue;
      }

      if(var_4) {
        scripts\engine\utility::flag_set(var_5);
      }

      scripts\engine\utility::array_thread(var_1, scripts\sp\utility::func_F225, "trigger");
      wait(0.5);
    }
  }
}

func_392A(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(sighttracepassed(self getEye(), var_0 + var_1[var_2], 1, self)) {
      return 1;
    }
  }

  return 0;
}

func_127A8(var_0) {
  var_1 = "not_set";
  if(isDefined(var_0.script_noteworthy)) {
    var_1 = var_0.script_noteworthy;
  }

  var_2 = getEntArray(var_0.target, "targetname");
  var_0 thread func_127A9(var_0.target);
  for(;;) {
    scripts\engine\utility::array_thread(var_2, scripts\engine\utility::trigger_off);
    var_0 waittill("trigger");
    scripts\engine\utility::array_thread(var_2, scripts\engine\utility::trigger_on);
    func_135AA(var_2, var_1);
    scripts\sp\utility::func_22A4(var_2, "relock");
  }
}

func_127A9(var_0) {
  self waittill("death");
  var_1 = getEntArray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\engine\utility::trigger_off);
}

func_135AA(var_0, var_1) {
  level endon("unlocked_trigger_hit" + var_1);
  var_2 = spawnStruct();
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] thread func_E1A0(var_2, var_1);
  }

  var_2 waittill("trigger");
  level notify("unlocked_trigger_hit" + var_1);
}

func_E1A0(var_0, var_1) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + var_1);
  self waittill("trigger");
  var_0 notify("trigger");
}

func_12729(var_0) {
  var_1 = undefined;
  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");
    if(issubstr(var_2[0].classname, "trigger")) {
      var_1 = var_2[0];
    }
  }

  if(isDefined(var_1)) {
    var_1 waittill("trigger", var_3);
  } else {
    var_1 waittill("trigger", var_3);
  }

  var_4 = undefined;
  if(isDefined(var_1)) {
    if(var_3.team != level.player.team && level.player istouching(var_0)) {
      var_4 = level.player scripts\anim\battlechatter::func_7E32("custom");
    } else if(var_3.team == level.player.team) {
      var_5 = "axis";
      if(level.player.team == "axis") {
        var_5 = "allies";
      }

      var_6 = scripts\anim\battlechatter::func_8145("custom", var_5);
      var_6 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_6);
      foreach(var_8 in var_6) {
        if(var_8 istouching(var_0)) {
          var_4 = var_8;
          if(func_28D5(var_8.origin)) {
            break;
          }
        }
      }
    }
  } else if(isplayer(var_3)) {
    var_4 = var_3 scripts\anim\battlechatter::func_7E32("custom");
  } else {
    var_4 = var_3;
  }

  if(!isDefined(var_4)) {
    return;
  }

  if(func_28D5()) {
    return;
  }

  var_0A = var_4 scripts\sp\utility::func_4C39(var_0.var_ED18);
  if(!var_0A) {
    level scripts\engine\utility::delaythread(0.25, ::func_12729, var_0);
    return;
  }

  var_0 notify("custom_battlechatter_done");
}

func_28D5(var_0) {
  return distancesquared(var_0, level.player getorigin()) <= 262144;
}

func_12734(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = [];
  var_2["left_door"] = -170;
  var_2["right_door"] = 170;
  foreach(var_4 in var_1) {
    var_5 = var_2[var_4.script_noteworthy];
    var_4 connectpaths();
    var_4 rotateyaw(var_5, 1, 0, 0.5);
  }
}

func_1274B(var_0) {
  var_1 = getglassarray(var_0.target);
  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }

  for(;;) {
    level waittill("glass_break", var_2);
    if(var_2 istouching(var_0)) {
      var_3 = var_2.origin;
      wait(0.05);
      var_4 = var_2.origin;
      var_5 = undefined;
      if(var_3 != var_4) {
        var_5 = var_4 - var_3;
      }

      if(isDefined(var_5)) {
        foreach(var_7 in var_1) {
          destroyglass(var_7, var_5);
        }

        break;
      } else {
        foreach(var_7 in var_1) {
          destroyglass(var_7);
        }

        break;
      }
    }
  }

  var_0 delete();
}

func_12730(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0 func_7C30();
  scripts\engine\utility::array_thread(var_1, ::func_5169);
}

func_7C30() {
  var_0 = [];
  if(!isDefined(self.script_linkto)) {
    return var_0;
  }

  var_1 = strtok(self.script_linkto, " ");
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = getent(var_3, "script_linkname");
    if(isDefined(var_4)) {
      var_0[var_0.size] = var_4;
    }
  }

  return var_0;
}

func_5169() {
  var_0 = func_7C30();
  scripts\engine\utility::array_thread(var_0, ::func_5169);
  self delete();
}

func_127A5(var_0) {
  var_0 endon("death");
  var_0 waittill("trigger");
  scripts\sp\utility::func_11813();
}

func_1274E(var_0) {
  if(!isDefined(level.var_56D9)) {
    level.var_56D9 = [];
  }

  waittillframeend;
  var_1 = var_0.var_EDDC;
  var_0 waittill("trigger", var_2);
  if(isDefined(level.var_56D9[var_1])) {
    return;
  }

  level.var_56D9[var_1] = 1;
  var_2 scripts\sp\utility::func_56BA(var_1);
}

func_12731(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

func_127A6(var_0) {
  var_0 waittill("trigger");
  var_0 scripts\engine\utility::trigger_off();
  if(!isDefined(var_0.script_linkto)) {
    return;
  }

  var_1 = strtok(var_0.script_linkto, " ");
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    scripts\engine\utility::array_thread(getEntArray(var_1[var_2], "script_linkname"), scripts\engine\utility::trigger_off);
  }
}

func_12752(var_0) {
  thread func_1278D(var_0, scripts\sp\utility::func_F416, scripts\sp\utility::func_7A31);
}

func_1277C(var_0) {
  thread func_1278D(var_0, scripts\sp\utility::func_F4B2, scripts\sp\utility::func_7B61);
}

func_1278D(var_0, var_1, var_2) {
  for(;;) {
    var_0 waittill("trigger", var_3);
    if(!isalive(var_3)) {
      continue;
    }

    if(var_3[[var_2]]()) {
      continue;
    }

    var_3 thread func_11A40(var_0, var_1);
  }
}

func_11A40(var_0, var_1) {
  self endon("death");
  self.ignoreme = 1;
  [[var_1]](1);
  self.precacheshader = 1;
  wait(1);
  self.precacheshader = 0;
  while(self istouching(var_0)) {
    wait(1);
  }

  [[var_1]](0);
}

func_12787(var_0) {
  var_0 waittill("trigger");
  scripts\sp\utility::func_DBEF(var_0.script_noteworthy);
}

func_12741(var_0) {
  var_1 = var_0 scripts\sp\utility::func_7D1E();
  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    if(!isplayer(var_2)) {
      continue;
    }

    var_0 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_1);
  }
}

func_12771(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isDefined(var_0.script_noteworthy)) {
      var_1 scripts\sp\art::func_1121E(var_0.script_noteworthy, var_0.script_delay);
    }

    scripts\engine\utility::waitframe();
  }
}

func_1276A(var_0) {
  waittillframeend;
  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0.var_ED68;
    var_3 = var_0.var_ED67;
    var_4 = var_0.var_ED66;
    var_5 = var_0.var_ED65;
    var_6 = var_0.var_ED64;
    var_7 = var_0.var_ED63;
    var_8 = var_0.script_delay;
    if(var_2 != level.var_5832["base"]["goal"]["nearStart"] || var_3 != level.var_5832["base"]["goal"]["nearEnd"] || var_4 != level.var_5832["base"]["goal"]["nearBlur"] || var_5 != level.var_5832["base"]["goal"]["farStart"] || var_6 != level.var_5832["base"]["goal"]["farEnd"] || var_7 != level.var_5832["base"]["goal"]["farBlur"]) {
      scripts\sp\art::func_5848(var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      wait(var_8);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_12772(var_0) {
  if(level.var_13E0F || level.var_DADB) {
    return;
  }

  waittillframeend;
  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0.var_EEDF;
    var_3 = var_0.var_EEE0;
    var_4 = var_0.script_delay;
    if(var_2 != level.var_11714.var_4CA6 || var_3 != level.var_11714.var_4CA8) {
      var_2 = max(0, var_2);
      var_2 = min(10000, var_2);
      var_3 = max(0, var_3);
      var_3 = min(10000, var_3);
      scripts\sp\art::func_11716(var_2, var_3, var_4);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_12792(var_0) {
  setdvarifuninitialized("use_legacy_slide", 0);
  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 thread func_102ED(var_0);
  }
}

func_102ED(var_0) {
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

  var_1 = undefined;
  if(isDefined(var_0.script_accel)) {
    var_1 = var_0.script_accel;
  }

  self endon("cancel_sliding");
  if(getdvarint("use_legacy_slide") > 0) {
    thread scripts\sp\utility::func_2A76();
  } else {
    thread scripts\sp\utility::func_2A75(undefined, var_1);
  }

  for(;;) {
    if(!self istouching(var_0)) {
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

func_1276E(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0.fx = [];
  foreach(var_3 in level.createfxent) {
    func_23C8(var_3, var_0, var_1);
  }

  var_1 delete();
  if(!isDefined(var_0.target)) {
    return;
  }

  var_5 = getEntArray(var_0.target, "targetname");
  var_0.var_75AD = 1;
  foreach(var_7 in var_5) {
    switch (var_7.classname) {
      case "trigger_multiple_fx_volume_on":
        var_7 thread func_1276D(var_0);
        break;

      case "trigger_multiple_fx_volume_off":
        var_7 thread func_1276C(var_0);
        break;

      default:
        break;
    }
  }
}

func_1276D(var_0) {
  for(;;) {
    self waittill("trigger");
    if(!var_0.var_75AD) {
      scripts\engine\utility::array_thread(var_0.fx, scripts\sp\utility::func_E2B0);
    }

    wait(1);
  }
}

func_1276C(var_0) {
  for(;;) {
    self waittill("trigger");
    if(var_0.var_75AD) {
      scripts\engine\utility::array_thread(var_0.fx, scripts\engine\utility::pauseeffect);
    }

    wait(1);
  }
}

func_23C8(var_0, var_1, var_2) {
  if(isDefined(var_0.v["soundalias"]) && var_0.v["soundalias"] != "nil") {
    if(!isDefined(var_0.v["stopable"]) || !var_0.v["stopable"]) {
      return;
    }
  }

  var_2.origin = var_0.v["origin"];
  if(var_2 istouching(var_1)) {
    var_1.fx[var_1.fx.size] = var_0;
  }
}

func_12769(var_0) {
  var_1 = var_0.script_parameters;
  if(!isDefined(level.var_B7AE)) {
    level.var_B7AE = "";
  }

  for(;;) {
    var_0 waittill("trigger");
    if(level.var_B7AE != var_1) {
      scripts\sp\compass::setupminimap(var_1);
    }
  }
}

func_12775(var_0) {
  scripts\engine\utility::array_thread(level.players, ::func_BFE5, var_0);
}

func_BFE5(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1 != self) {
      continue;
    }

    while(var_1 istouching(var_0)) {
      var_1 allowprone(0);
      var_1 allowcrouch(0);
      wait(0.05);
    }

    var_1 allowprone(1);
    var_1 allowcrouch(1);
  }
}

func_1275A(var_0) {
  if(!isDefined(level.var_A0E4)) {
    level.var_A0E4 = 0;
  }

  var_0.var_12751 = level.var_A0E4;
  level.var_A0E4++;
  var_0.var_C75B = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_0.var_98F5 = scripts\engine\utility::getstruct(var_0.var_C75B.target, "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(level.var_D127) || var_1 != level.var_D127) {
      continue;
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_push")) {
      continue;
    }

    var_0 thread[[level.var_A056.trigger_func.var_A0E2]]();
    while(isalive(var_1) && isDefined(var_0) && var_1 istouching(var_0) && isDefined(level.var_D127)) {
      wait(0.05);
    }

    var_0 thread[[level.var_A056.trigger_func.var_A0E3]]();
  }
}

func_1275B(var_0) {
  var_1 = "trigger_jackal_boundary_warning";
  if(!isDefined(level.var_A392)) {
    level.var_A392 = [];
  }

  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);
  }

  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  if(!isDefined(var_2)) {
    var_2 = getent(var_0.target, "targetname");
    var_3 = 1;
  } else {
    var_3 = 0;
  }

  for(;;) {
    var_0 waittill("trigger", var_4);
    if(!isDefined(level.var_D127) || var_4 != level.var_D127) {
      continue;
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning")) {
      while(isalive(var_4) && isDefined(var_0) && var_4 istouching(var_0) && isDefined(level.var_D127) && level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning")) {
        wait(0.05);
      }
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning")) {
      continue;
    }

    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);
      var_2 thread func_A391(var_4, var_3, var_1);
      level.var_A392 = scripts\engine\utility::array_add(level.var_A392, var_0);
    }

    while(isalive(var_4) && isDefined(var_0) && var_4 istouching(var_0) && isDefined(level.var_D127)) {
      wait(0.05);
    }

    level.var_A392 = scripts\engine\utility::array_remove(level.var_A392, var_0);
    if(level.var_A392.size == 0) {
      scripts\engine\utility::flag_clear(var_1);
    }
  }
}

func_A391(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3.var_138F0 = 0;
  var_4 = 0;
  if(var_1) {
    var_5 = getpartname(self.model, 0);
    var_3 linkto(self, var_5, (0, 0, 0), (0, 0, 0));
  } else {
    var_3.origin = self.origin;
  }

  var_6 = 0;
  while(var_6 < 1) {
    if(scripts\engine\utility::flag(var_2) || scripts\engine\utility::flag("jackal_is_autoturning")) {
      var_6 = 0;
    } else {
      var_6++;
    }

    var_7 = vectornormalize(self.origin - level.var_D127.origin);
    var_8 = anglesToForward(level.var_D127.angles);
    var_9 = vectordot(var_7, var_8);
    var_0A = vectornormalize(level.var_D127.func_2AC);
    var_0B = vectordot(var_7, var_0A);
    if(var_9 > 0.1 && var_0B > 0.1) {
      if(var_4) {
        var_4 = 0;
        var_3[[level.var_A056.trigger_func.var_A0E5]](var_4);
      }

      continue;
    }

    if(!var_4) {
      var_4 = 1;
      var_3[[level.var_A056.trigger_func.var_A0E5]](var_4);
    }

    wait(0.05);
  }

  var_3[[level.var_A056.trigger_func.var_A0E5]](0);
  var_3 delete();
}

func_12759(var_0) {
  var_1 = "trigger_jackal_boundary_autoturn";
  var_2 = "jackal_is_autoturning";
  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);
  }

  if(!scripts\engine\utility::flag_exist(var_2)) {
    scripts\engine\utility::flag_init(var_2);
  }

  var_3 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  for(;;) {
    var_0 waittill("trigger", var_4);
    if(!isDefined(level.var_D127) || var_4 != level.var_D127 || scripts\engine\utility::flag(var_1)) {
      continue;
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn")) {
      while(isalive(var_4) && isDefined(var_0) && var_4 istouching(var_0) && isDefined(level.var_D127) && level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn")) {
        wait(0.05);
      }
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn")) {
      continue;
    }

    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);
      if(!scripts\engine\utility::flag(var_2)) {
        var_3 thread[[level.var_A056.trigger_func.var_A0E1]](var_0, var_4, var_1, var_2);
      }

      level.var_A056.var_2698 = scripts\engine\utility::array_add(level.var_A056.var_2698, var_0);
    }

    while(isalive(var_4) && isDefined(var_0) && var_4 istouching(var_0) && isDefined(level.var_D127)) {
      wait(0.05);
    }

    level.var_A056.var_2698 = scripts\engine\utility::array_remove(level.var_A056.var_2698, var_0);
    if(level.var_A056.var_2698.size == 0) {
      scripts\engine\utility::flag_clear(var_1);
    }
  }
}

func_1275C(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(level.var_D127) || var_1 != level.var_D127) {
      continue;
    }

    var_0 func_A2FF();
    while(isalive(var_1) && isDefined(var_0) && var_1 istouching(var_0) && isDefined(level.var_D127)) {
      wait(0.25);
    }

    var_0 func_A300();
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

func_9C91(var_0, var_1) {
  return var_0.var_EE8C > var_1.var_EE8C;
}

func_12776(var_0) {
  scripts\engine\utility::array_thread(level.players, ::func_C00E, var_0);
}

func_C00E(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1 != self) {
      continue;
    }

    while(var_1 istouching(var_0)) {
      var_1 allowprone(0);
      wait(0.05);
    }

    var_1 allowprone(1);
  }
}

exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");
  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(!var_0 scripts\sp\utility::script_delay()) {
      wait(4);
    }

    level thread exploder_load(var_0);
    return;
  }

  if(!var_0 scripts\sp\utility::script_delay() && isDefined(var_0.var_ED85)) {
    wait(var_0.var_ED85);
  }

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

func_12770(var_0) {
  if(getdvarint("kleenex") != 1) {
    return;
  }

  var_0 waittill("trigger");
  scripts\sp\utility::func_A6F2();
}

func_1279C(var_0) {
  var_0 endon("death");
  var_1 = "stealth_in_shadow";
  for(;;) {
    var_0 waittill("trigger", var_2);
    if(!var_2 scripts\sp\utility::func_65DF(var_1)) {
      continue;
    }

    if(var_2 scripts\sp\utility::func_65DB(var_1)) {
      continue;
    }

    var_2 thread func_93A4(var_0, var_1);
  }
}

func_93A4(var_0, var_1) {
  self endon("death");
  scripts\sp\utility::func_65E1(var_1);
  while(isDefined(var_0) && self istouching(var_0)) {
    wait(0.05);
  }

  scripts\sp\utility::func_65DD(var_1);
}

func_1273C(var_0) {
  var_0 endon("death");
  var_1 = 2;
  var_2 = 2;
  var_3 = 0;
  if(!isDefined(var_0.script_delay_min) && !isDefined(var_0.script_delay_max)) {
    var_0.script_delay_min = 0.3;
    var_0.script_delay_max = 0.9;
  }

  if(isDefined(var_0.script_damage)) {
    var_1 = var_0.script_damage;
  }

  for(;;) {
    var_0 waittill("trigger", var_4);
    var_5 = var_0.origin;
    if(isplayer(var_4)) {
      var_3 = var_1;
      if(var_0.classname == "trigger_radius_fire") {
        if(isDefined(var_0.script_radius)) {
          if(distance2dsquared(var_4.origin, var_0.origin) <= squared(var_0.script_radius)) {
            if(isDefined(var_0.var_EE51) && isnumber(var_0.var_EE51)) {
              var_2 = var_0.var_EE51;
            }

            var_3 = var_3 * var_2;
          }
        }
      } else if(isDefined(var_0.target)) {
        var_6 = scripts\engine\utility::getstruct(var_0.target, "targetname");
        var_5 = var_6.origin;
        if(isDefined(var_6.script_radius)) {
          if(distance2dsquared(var_4.origin, var_6.origin) <= squared(var_6.script_radius)) {
            if(isDefined(var_0.var_EE51) && isnumber(var_0.var_EE51)) {
              var_2 = var_0.var_EE51;
            }

            var_3 = var_3 * var_2;
          }
        }
      }
    }

    var_4 dodamage(var_3, var_5);
    if(var_3 < 6) {
      var_4 playrumbleonentity("damage_light");
    } else {
      var_4 playrumbleonentity("damage_heavy");
    }

    var_0 scripts\sp\utility::script_delay();
  }
}