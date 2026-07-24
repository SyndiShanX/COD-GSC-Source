/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2960.gsc
**************************************/

_id_7AA4() {
  var_0 = [];
  var_0["trigger_multiple_nobloodpool"] = ::_id_12777;
  var_0["trigger_multiple_flag_set"] = ::_id_1273F;
  var_0["trigger_multiple_flag_clear"] = ::_id_1273D;
  var_0["trigger_multiple_sun_off"] = ::_id_1279E;
  var_0["trigger_multiple_sun_on"] = ::_id_1279F;
  var_0["trigger_use_flag_set"] = ::_id_1273F;
  var_0["trigger_use_flag_clear"] = ::_id_1273D;
  var_0["trigger_multiple_flag_set_touching"] = ::_id_12744;
  var_0["trigger_multiple_flag_lookat"] = ::_id_12760;
  var_0["trigger_multiple_flag_looking"] = ::_id_12762;
  var_0["trigger_multiple_no_prone"] = ::_id_12776;
  var_0["trigger_multiple_no_crouch_or_prone"] = ::_id_12775;
  var_0["trigger_multiple_compass"] = ::_id_12769;
  var_0["trigger_multiple_fx_volume"] = ::_id_1276E;
  var_0["trigger_multiple_kleenex"] = ::_id_12770;
  var_0["trigger_multiple_light_sunshadow"] = ::scripts\sp\lights::_id_11203;
  var_0["trigger_multiple_jackal_boundary_autoturn"] = ::_id_12759;
  var_0["trigger_multiple_jackal_boundary_warning"] = ::_id_1275B;
  var_0["trigger_multiple_jackal_boundary_push"] = ::_id_1275A;
  var_0["trigger_multiple_jackal_speed_touching"] = ::_id_1275C;
  var_0["trigger_multiple_landingzone"] = ::_id_1275E;
  var_0["trigger_multiple_arbitrary_up"] = ::_id_12723;
  var_0["trigger_multiple_spacejump"] = ::_id_12794;

  if(!scripts\sp\starts::_id_9C4B()) {
    var_0["trigger_multiple_autosave"] = ::scripts\sp\autosave::_id_12724;
    var_0["trigger_multiple_spawn"] = _id_0B77::_id_12797;
    var_0["trigger_multiple_spawn_reinforcement"] = _id_0B77::_id_12798;
  }

  var_0["trigger_multiple_slide"] = ::_id_12792;
  var_0["trigger_multiple_depthoffield"] = ::_id_1276A;
  var_0["trigger_multiple_tessellationcutoff"] = ::_id_12772;
  var_0["trigger_damage_player_flag_set"] = ::_id_1272F;
  var_0["trigger_multiple_sunflare"] = ::_id_12771;
  var_0["trigger_multiple_glass_break"] = ::_id_1274B;
  var_0["trigger_radius_glass_break"] = ::_id_1274B;
  var_0["trigger_multiple_friendly_respawn"] = ::trigger_friendly_respawn;
  var_0["trigger_multiple_friendly_stop_respawn"] = ::trigger_friendly_stop_respawn;
  var_0["trigger_multiple_physics"] = ::_id_1277E;
  var_0["trigger_multiple_fx_watersheeting"] = ::_id_1276F;
  var_0["trigger_multiple_fakeactor_move"] = ::scripts\sp\fakeactor::_id_12735;
  var_0["trigger_multiple_fakeactor_node_disable"] = ::scripts\sp\fakeactor::_id_12736;
  var_0["trigger_multiple_fakeactor_node_enable"] = ::scripts\sp\fakeactor::_id_12738;
  var_0["trigger_multiple_fakeactor_node_disablegroup"] = ::scripts\sp\fakeactor::_id_12737;
  var_0["trigger_multiple_fakeactor_node_enablegroup"] = ::scripts\sp\fakeactor::_id_12739;
  var_0["trigger_multiple_fakeactor_node_passthrough"] = ::scripts\sp\fakeactor::_id_1273B;
  var_0["trigger_multiple_fakeactor_node_lock"] = ::scripts\sp\fakeactor::_id_1273A;
  var_0["trigger_multiple_geo_mover"] = ::scripts\sp\geo_mover::_id_12764;
  var_0["trigger_multiple_transient"] = ::_id_12773;
  var_0["trigger_multiple_fire"] = ::_id_1273C;
  var_0["trigger_radius_fire"] = ::_id_1273C;
  return var_0;
}

_id_1276F(var_0) {
  var_1 = 3;

  if(isDefined(var_0._id_ED75)) {
    var_1 = var_0._id_ED75;
  }

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      var_2 setwatersheeting(1, var_1);
      wait(var_1 * 0.2);
    }
  }
}

_id_7AA5() {
  var_0 = [];
  var_0["friendly_mgTurret"] = _id_0B77::_id_73D9;

  if(!scripts\sp\starts::_id_9C4B()) {
    var_0["camper_spawner"] = _id_0B77::camper_trigger_think;
    var_0["flood_spawner"] = _id_0B77::_id_6F5D;
    var_0["trigger_spawner"] = _id_0B77::_id_12797;
    var_0["trigger_autosave"] = ::scripts\sp\autosave::_id_12724;
    var_0["trigger_spawngroup"] = ::_id_1279A;
    var_0["trigger_vehicle_spline_spawn"] = ::_id_127AC;
    var_0["trigger_vehicle_spawn"] = _id_0B77::_id_12797;
    var_0["random_spawn"] = _id_0B77::_id_DC9B;
  }

  var_0["autosave_now"] = ::scripts\sp\autosave::_id_2671;
  var_0["trigger_autosave_tactical"] = ::scripts\sp\autosave::_id_12727;
  var_0["trigger_autosave_stealth"] = ::scripts\sp\autosave::_id_12726;
  var_0["trigger_unlock"] = ::_id_127A8;
  var_0["trigger_lookat"] = ::_id_12760;
  var_0["trigger_looking"] = ::_id_12762;
  var_0["trigger_cansee"] = ::_id_1272B;
  var_0["flag_set"] = ::_id_1273F;
  var_0["flag_set_player"] = ::_id_12741;
  var_0["flag_unset"] = ::_id_1273D;
  var_0["flag_clear"] = ::_id_1273D;
  var_0["friendly_respawn_trigger"] = ::trigger_friendly_respawn;
  var_0["radio_trigger"] = ::_id_12787;
  var_0["trigger_ignore"] = ::_id_12752;
  var_0["trigger_pacifist"] = ::_id_1277C;
  var_0["trigger_delete"] = ::_id_127A6;
  var_0["trigger_delete_on_touch"] = ::_id_12731;
  var_0["trigger_off"] = ::_id_127A6;
  var_0["trigger_outdoor"] = _id_0B77::_id_C75A;
  var_0["trigger_indoor"] = _id_0B77::_id_9409;
  var_0["trigger_hint"] = ::_id_1274E;
  var_0["trigger_grenade_at_player"] = ::_id_127A5;
  var_0["flag_on_cleared"] = ::_id_1273E;
  var_0["flag_set_touching"] = ::_id_12744;
  var_0["delete_link_chain"] = ::_id_12730;
  var_0["trigger_slide"] = ::_id_12792;
  var_0["trigger_dooropen"] = ::_id_12734;
  var_0["stealth_shadow"] = ::_id_1279C;
  var_0["geo_mover"] = ::scripts\sp\geo_mover::_id_12764;
  var_0["no_crouch_or_prone"] = ::_id_12775;
  var_0["no_prone"] = ::_id_12776;
  return var_0;
}

_id_9726() {
  scripts\sp\colors::init_colors();
  _id_0B0B::init_audio();
  scripts\sp\utility::_id_228A(getEntArray("trigger_multiple_softlanding", "classname"));
  var_0 = _id_7AA4();
  var_1 = _id_7AA5();

  foreach(var_5, var_3 in var_0) {
    var_4 = getEntArray(var_5, "classname");
    scripts\engine\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getEntArray("trigger_multiple", "classname");
  var_7 = getEntArray("trigger_radius", "classname");
  var_4 = scripts\sp\utility::_id_22A2(var_6, var_7);
  var_8 = getEntArray("trigger_disk", "classname");
  var_4 = scripts\sp\utility::_id_22A2(var_4, var_8);
  var_9 = getEntArray("trigger_once", "classname");
  var_4 = scripts\sp\utility::_id_22A2(var_4, var_9);

  if(!scripts\sp\starts::_id_9C4B()) {
    for(var_10 = 0; var_10 < var_4.size; var_10++) {
      if(var_4[var_10].spawnflags & 32) {
        thread _id_0B77::_id_12797(var_4[var_10]);
      }
    }
  }

  var_11 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage"];

  foreach(var_13 in var_11) {
    var_4 = getEntArray(var_13, "code_classname");

    foreach(var_15 in var_4) {
      if(isDefined(var_15.script_flag_true)) {
        level thread _id_1278F(var_15);
      }

      if(isDefined(var_15.script_flag_false)) {
        level thread _id_1278E(var_15);
      }

      if(isDefined(var_15._id_ED0E) || isDefined(var_15._id_ED0D)) {
        level thread scripts\sp\autosave::_id_268B(var_15);
      }

      if(isDefined(var_15._id_EE17)) {
        level thread scripts\sp\mgturret::_id_B6BE(var_15);
      }

      if(isDefined(var_15._id_EDF7)) {
        level thread _id_0B77::_id_A617(var_15);
      }

      if(isDefined(var_15._id_EDF5)) {
        level thread scripts\sp\vehicle_code::_id_A629(var_15);
      }

      if(isDefined(var_15.script_emptyspawner)) {
        level thread _id_0B77::_id_61BD(var_15);
      }

      if(isDefined(var_15.script_prefab_exploder)) {
        var_15.script_exploder = var_15.script_prefab_exploder;
      }

      if(isDefined(var_15.script_exploder)) {
        level thread exploder_load(var_15);
      }

      if(isDefined(var_15._id_EEEF)) {
        level thread _id_12780(var_15);
      }

      if(isDefined(var_15._id_ED18)) {
        level thread _id_12729(var_15);
      }

      if(isDefined(var_15._id_EEEE)) {
        var_15 thread _id_1274C();
      }

      if(isDefined(var_15._id_EE90)) {
        level thread _id_0B77::_id_DC8F(var_15);
      }

      if(isDefined(var_15.targetname)) {
        var_16 = var_15.targetname;

        if(isDefined(var_1[var_16])) {
          level thread[[var_1[var_16]]](var_15);
        }
      }
    }
  }
}

_id_1272E(var_0) {
  var_1 = 1;

  if(var_1) {
    var_0 delete();
  }
}

_id_4984() {}

_id_9CEA() {
  if(getDvar("createfx") != "") {
    return 1;
  }

  if(getdvarint("scr_art_tweak") > 0) {
    return 1;
  }

  if(isDefined(level._id_10CDA) && level._id_10CDA == "no_game") {
    return 1;
  }

  return 0;
}

_id_12773(var_0) {
  var_2 = undefined;
  var_3 = undefined;

  if(isDefined(var_0._id_EEE7)) {
    var_2 = strtok(var_0._id_EEE7, " ");
  }

  if(isDefined(var_0._id_EEE8)) {
    var_3 = strtok(var_0._id_EEE8, " ");
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
      scripts\sp\utility::_id_12651(var_3);
    }

    if(isDefined(var_2)) {
      scripts\sp\utility::_id_12643(var_2);
    }
  }
}

_id_1272F(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7D1E();

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_1, var_2);
  }
}

_id_1273D(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7D1E();

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger");
    var_0 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_clear(var_1);
  }
}

_id_1273E(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7D1E();

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger");
    wait 1;

    if(var_0 _id_733E()) {
      continue;
    }
    break;
  }

  scripts\engine\utility::flag_set(var_1);
}

_id_733E() {
  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 istouching(self)) {
      return 1;
    }

    wait 0.1;
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

_id_1273F(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7D1E();

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
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1.origin;
    var_1 delete();
  } else {
    var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_2 = var_1.origin;
  }

  for(;;) {
    var_0 waittill("trigger");
    level.respawn_threshold = var_2;
    scripts\engine\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

_id_1275E(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7D1E();

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  if(!isDefined(level._id_A842)) {
    level._id_A842 = [];
  }

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      level._id_A842 = scripts\engine\utility::array_add(level._id_A842, var_0);
    }

    while(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      if(!scripts\engine\utility::flag(var_1)) {
        thread _id_1275F(var_1);
      }

      wait 0.25;
    }

    level._id_A842 = scripts\engine\utility::array_remove(level._id_A842, var_0);
  }
}

_id_1275F(var_0) {
  scripts\engine\utility::flag_set(var_0);

  for(;;) {
    level._id_A842 = scripts\engine\utility::array_removeundefined(level._id_A842);

    if(level._id_A842.size == 0) {
      break;
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_clear(var_0);
}

_id_12794(var_0) {
  var_0 _meth_84C0(1);

  if(isDefined(var_0.target)) {
    var_1 = getEnt(var_0.target, "targetname");
    var_0 enablelinkTo();
    var_0 linkTo(var_1);
  }
}

_id_12723(var_0) {
  var_0 _meth_84C0(1);

  if(isDefined(var_0.target)) {
    var_1 = getEnt(var_0.target, "targetname");
    var_0 enablelinkTo();
    var_0 linkTo(var_1);
  }
}

_id_12744(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7D1E();

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
      wait 0.25;
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

_id_1274C() {
  thread _id_1274D();
  level endon("trigger_group_" + self._id_EEEE);
  self waittill("trigger");
  level notify("trigger_group_" + self._id_EEEE, self);
}

_id_1274D() {
  level waittill("trigger_group_" + self._id_EEEE, var_0);

  if(self != var_0) {
    self delete();
  }
}

_id_12777(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isalive(var_1)) {
      continue;
    }
    var_1._id_10264 = 1;
    var_1 thread _id_F611();
  }
}

_id_F611() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait 2;
  self._id_10264 = undefined;
}

_id_1277E(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_3 = getEntArray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    var_6 = spawnStruct();
    var_6.origin = var_5.origin;
    var_6.script_parameters = var_5.script_parameters;
    var_6.script_damage = var_5.script_damage;
    var_6.radius = var_5.radius;
    var_2[var_2.size] = var_6;
    var_5 delete();
  }

  var_0._id_C6EA = var_2[0].origin;
  var_0 waittill("trigger");
  var_0 scripts\sp\utility::script_delay();

  foreach(var_6 in var_2) {
    var_9 = var_6.radius;
    var_10 = var_6.script_parameters;
    var_11 = var_6.script_damage;

    if(!isDefined(var_9)) {
      var_9 = 350;
    }

    if(!isDefined(var_10)) {
      var_10 = 0.25;
    }

    setDvar("tempdvar", var_10);
    var_10 = getdvarfloat("tempdvar");

    if(isDefined(var_11)) {
      radiusdamage(var_6.origin, var_9, var_11, var_11 * 0.5);
    }

    physicsexplosionsphere(var_6.origin, var_9, var_9 * 0.5, var_10);
  }
}

_id_12780(var_0) {
  var_1 = var_0._id_EEEF;
  var_0 waittill("trigger");
  var_2 = getaiarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isalive(var_2[var_3])) {
      continue;
    }
    if(isDefined(var_2[var_3]._id_EEEF) && var_2[var_3]._id_EEEF == var_1) {
      var_2[var_3].goalradius = 800;
      var_2[var_3] setgoalentity(level.player);
      level thread _id_0B77::_id_50F5(var_2[var_3]);
    }
  }
}

_id_1278E(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  var_0 _id_1786(var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

_id_1278F(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  var_0 _id_1786(var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

_id_1786(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level.trigger_flags[var_2])) {
      level.trigger_flags[var_2] = [];
    }

    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

_id_1279A(var_0) {
  waittillframeend;
  var_1 = var_0._id_EEBA;

  if(!isDefined(level.spawn_group) || !isDefined(level._id_10727[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  var_2 = scripts\engine\utility::random(level._id_10727[var_1]);

  foreach(var_5, var_4 in var_2) {
    var_4 scripts\sp\utility::_id_10619();
  }
}

_id_1279E(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunenable") == 0) {
      continue;
    }
    setsaveddvar("sm_sunenable", 0);
  }
}

_id_1279F(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunenable") == 1) {
      continue;
    }
    setsaveddvar("sm_sunenable", 1);
  }
}

_id_127AC(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread scripts\sp\vehicle_code::_id_10809(70);
    wait 0.05;
  }
}

_id_7D1F() {
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

    var_2 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var_5 in var_2) {
      var_3[var_3.size] = var_5;
    }

    if(var_3.size == 1) {
      var_9 = var_3[0];
      var_1 = var_9.origin;

      if(isDefined(var_9.code_classname)) {
        var_9 delete();
      }
    }
  }

  var_10 = [];
  var_10["triggers"] = var_0;
  var_10["target_origin"] = var_1;
  return var_10;
}

_id_12760(var_0) {
  _id_12761(var_0, 1);
}

_id_12762(var_0) {
  _id_12761(var_0, 0);
}

_id_12761(var_0, var_1) {
  var_2 = 0.78;

  if(isDefined(var_0._id_ED6D)) {
    var_2 = var_0._id_ED6D;
  }

  var_3 = var_0 _id_7D1F();
  var_4 = var_3["triggers"];
  var_5 = var_3["target_origin"];
  var_6 = isDefined(var_0._id_ED9A) || isDefined(var_0.script_noteworthy);
  var_7 = undefined;

  if(var_6) {
    var_7 = var_0 scripts\sp\utility::_id_7D1E();

    if(!isDefined(level.flag[var_7])) {
      scripts\engine\utility::flag_init(var_7);
    }
  } else if(!var_4.size) {}

  if(var_1 && var_6) {
    level endon(var_7);
  }

  var_0 endon("death");
  var_8 = 1;

  if(isDefined(var_0._id_EE61)) {
    var_8 = var_0._id_EE61;
  }

  for(;;) {
    if(var_6) {
      scripts\engine\utility::flag_clear(var_7);
    }

    var_0 waittill("trigger", var_9);
    var_10 = [];

    while(var_9 istouching(var_0)) {
      if(var_8 && !sighttracepassed(var_9 getEye(), var_5, 0, undefined)) {
        if(var_6) {
          scripts\engine\utility::flag_clear(var_7);
        }

        wait 0.5;
        continue;
      }

      var_11 = vectorNormalize(var_5 - var_9.origin);
      var_12 = var_9 getplayerangles();
      var_13 = anglesToForward(var_12);
      var_14 = vectordot(var_13, var_11);

      if(var_14 >= var_2) {
        scripts\engine\utility::array_thread(var_4, scripts\sp\utility::_id_F225, "trigger");

        if(var_6) {
          scripts\engine\utility::flag_set(var_7, var_9);
        }

        if(var_1) {
          return;
        }
        wait 2;
      } else if(var_6)
        scripts\engine\utility::flag_clear(var_7);

      if(var_8) {
        wait 0.5;
        continue;
      }

      wait 0.05;
    }
  }
}

_id_1272B(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = var_0 _id_7D1F();
  var_1 = var_3["triggers"];
  var_2 = var_3["target_origin"];
  var_4 = isDefined(var_0._id_ED9A) || isDefined(var_0.script_noteworthy);
  var_5 = undefined;

  if(var_4) {
    var_5 = var_0 scripts\sp\utility::_id_7D1E();

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
      if(!var_8 _id_392A(var_2, var_7)) {
        if(var_4) {
          scripts\engine\utility::flag_clear(var_5);
        }

        wait 0.1;
        continue;
      }

      if(var_4) {
        scripts\engine\utility::flag_set(var_5);
      }

      scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_F225, "trigger");
      wait 0.5;
    }
  }
}

_id_392A(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(sighttracepassed(self getEye(), var_0 + var_1[var_2], 1, self)) {
      return 1;
    }
  }

  return 0;
}

_id_127A8(var_0) {
  var_1 = "not_set";

  if(isDefined(var_0.script_noteworthy)) {
    var_1 = var_0.script_noteworthy;
  }

  var_2 = getEntArray(var_0.target, "targetname");
  var_0 thread _id_127A9(var_0.target);

  for(;;) {
    scripts\engine\utility::array_thread(var_2, scripts\engine\utility::trigger_off);
    var_0 waittill("trigger");
    scripts\engine\utility::array_thread(var_2, scripts\engine\utility::trigger_on);
    _id_135AA(var_2, var_1);
    scripts\sp\utility::_id_22A4(var_2, "relock");
  }
}

_id_127A9(var_0) {
  self waittill("death");
  var_1 = getEntArray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\engine\utility::trigger_off);
}

_id_135AA(var_0, var_1) {
  level endon("unlocked_trigger_hit" + var_1);
  var_2 = spawnStruct();

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] thread _id_E1A0(var_2, var_1);
  }

  var_2 waittill("trigger");
  level notify("unlocked_trigger_hit" + var_1);
}

_id_E1A0(var_0, var_1) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + var_1);
  self waittill("trigger");
  var_0 notify("trigger");
}

_id_12729(var_0) {
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
    var_0 waittill("trigger", var_3);
  }

  var_4 = undefined;

  if(isDefined(var_1)) {
    if(var_3.team != level.player.team && level.player istouching(var_0)) {
      var_4 = level.player scripts\anim\battlechatter::_id_7E32("custom");
    } else if(var_3.team == level.player.team) {
      var_5 = "axis";

      if(level.player.team == "axis") {
        var_5 = "allies";
      }

      var_6 = scripts\anim\battlechatter::_id_8145("custom", var_5);
      var_6 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_6);

      foreach(var_8 in var_6) {
        if(var_8 istouching(var_0)) {
          var_4 = var_8;

          if(_id_28D5(var_8.origin)) {
            break;
          }
        }
      }
    }
  } else if(isPlayer(var_3))
    var_4 = var_3 scripts\anim\battlechatter::_id_7E32("custom");
  else {
    var_4 = var_3;
  }

  if(!isDefined(var_4)) {
    return;
  }
  if(_id_28D5()) {
    return;
  }
  var_10 = var_4 scripts\sp\utility::_id_4C39(var_0._id_ED18);

  if(!var_10) {
    level scripts\engine\utility::delaythread(0.25, ::_id_12729, var_0);
  } else {
    var_0 notify("custom_battlechatter_done");
  }
}

_id_28D5(var_0) {
  return distancesquared(var_0, level.player getorigin()) <= 262144;
}

_id_12734(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = [];
  var_2["left_door"] = -170;
  var_2["right_door"] = 170;

  foreach(var_4 in var_1) {
    var_5 = var_2[var_4.script_noteworthy];
    var_4 connectpaths();
    var_4 rotateYaw(var_5, 1, 0, 0.5);
  }
}

_id_1274B(var_0) {
  var_1 = getglassarray(var_0.target);

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  for(;;) {
    level waittill("glass_break", var_2);

    if(var_2 istouching(var_0)) {
      var_3 = var_2.origin;
      wait 0.05;
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

_id_12730(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0 _id_7C30();
  scripts\engine\utility::array_thread(var_1, ::_id_5169);
}

_id_7C30() {
  var_0 = [];

  if(!isDefined(self.script_linkto)) {
    return var_0;
  }

  var_1 = strtok(self.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = getEnt(var_3, "script_linkname");

    if(isDefined(var_4)) {
      var_0[var_0.size] = var_4;
    }
  }

  return var_0;
}

_id_5169() {
  var_0 = _id_7C30();
  scripts\engine\utility::array_thread(var_0, ::_id_5169);
  self delete();
}

_id_127A5(var_0) {
  var_0 endon("death");
  var_0 waittill("trigger");
  scripts\sp\utility::_id_11813();
}

_id_1274E(var_0) {
  if(!isDefined(level._id_56D9)) {
    level._id_56D9 = [];
  }

  waittillframeend;
  var_1 = var_0._id_EDDC;
  var_0 waittill("trigger", var_2);

  if(isDefined(level._id_56D9[var_1])) {
    return;
  }
  level._id_56D9[var_1] = 1;
  var_2 scripts\sp\utility::_id_56BA(var_1);
}

_id_12731(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

_id_127A6(var_0) {
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

_id_12752(var_0) {
  thread _id_1278D(var_0, scripts\sp\utility::_id_F416, scripts\sp\utility::_id_7A31);
}

_id_1277C(var_0) {
  thread _id_1278D(var_0, scripts\sp\utility::_id_F4B2, scripts\sp\utility::_id_7B61);
}

_id_1278D(var_0, var_1, var_2) {
  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isalive(var_3)) {
      continue;
    }
    if(var_3[[var_2]]()) {
      continue;
    }
    var_3 thread _id_11A40(var_0, var_1);
  }
}

_id_11A40(var_0, var_1) {
  self endon("death");
  self.ignoreme = 1;
  [[var_1]](1);
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(var_0)) {
    wait 1;
  }

  [[var_1]](0);
}

_id_12787(var_0) {
  var_0 waittill("trigger");
  scripts\sp\utility::_id_DBEF(var_0.script_noteworthy);
}

_id_12741(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7D1E();

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    var_0 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_1);
  }
}

_id_12771(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_0.script_noteworthy)) {
      var_1 _id_0B0A::_id_1121E(var_0.script_noteworthy, var_0.script_delay);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_1276A(var_0) {
  waittillframeend;

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0._id_ED68;
    var_3 = var_0._id_ED67;
    var_4 = var_0._id_ED66;
    var_5 = var_0._id_ED65;
    var_6 = var_0._id_ED64;
    var_7 = var_0._id_ED63;
    var_8 = var_0.script_delay;

    if(var_2 != level._id_5832["base"]["goal"]["nearStart"] || var_3 != level._id_5832["base"]["goal"]["nearEnd"] || var_4 != level._id_5832["base"]["goal"]["nearBlur"] || var_5 != level._id_5832["base"]["goal"]["farStart"] || var_6 != level._id_5832["base"]["goal"]["farEnd"] || var_7 != level._id_5832["base"]["goal"]["farBlur"]) {
      _id_0B0A::_id_5848(var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      wait(var_8);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_12772(var_0) {
  if(level._id_13E0F || level._id_DADB) {
    return;
  }
  waittillframeend;

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0._id_EEDF;
    var_3 = var_0._id_EEE0;
    var_4 = var_0.script_delay;

    if(var_2 != level._id_11714._id_4CA6 || var_3 != level._id_11714._id_4CA8) {
      var_2 = max(0, var_2);
      var_2 = min(10000, var_2);
      var_3 = max(0, var_3);
      var_3 = min(10000, var_3);
      _id_0B0A::_id_11716(var_2, var_3, var_4);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_12792(var_0) {
  setdvarifuninitialized("use_legacy_slide", 0);

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 thread _id_102ED(var_0);
  }
}

_id_102ED(var_0) {
  if(isDefined(self.vehicle)) {
    return;
  }
  if(scripts\sp\utility::_id_9F59() || self isjumping() || scripts\sp\utility::_id_9C11() || _id_0E4F::_id_9C7B()) {
    return;
  }
  if(isDefined(self._id_D323)) {
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
    thread scripts\sp\utility::_id_2A76();
  } else {
    thread scripts\sp\utility::_id_2A75(undefined, var_1);
  }

  for(;;) {
    if(!self istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(level._id_62F7)) {
    wait(level._id_62F7);
  }

  if(getdvarint("use_legacy_slide") > 0) {
    scripts\sp\utility::_id_638A();
  } else {
    scripts\sp\utility::_id_6389();
  }
}

_id_1276E(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0.fx = [];

  foreach(var_3 in level.createfxent) {
    _id_23C8(var_3, var_0, var_1);
  }

  var_1 delete();

  if(!isDefined(var_0.target)) {
    return;
  }
  var_5 = getEntArray(var_0.target, "targetname");
  var_0._id_75AD = 1;

  foreach(var_7 in var_5) {
    switch (var_7.classname) {
      case "trigger_multiple_fx_volume_on":
        var_7 thread _id_1276D(var_0);
        break;
      case "trigger_multiple_fx_volume_off":
        var_7 thread _id_1276C(var_0);
        break;
      default:
        break;
    }
  }
}

_id_1276D(var_0) {
  for(;;) {
    self waittill("trigger");

    if(!var_0._id_75AD) {
      scripts\engine\utility::array_thread(var_0.fx, scripts\sp\utility::_id_E2B0);
    }

    wait 1;
  }
}

_id_1276C(var_0) {
  for(;;) {
    self waittill("trigger");

    if(var_0._id_75AD) {
      scripts\engine\utility::array_thread(var_0.fx, scripts\engine\utility::pauseeffect);
    }

    wait 1;
  }
}

_id_23C8(var_0, var_1, var_2) {
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

_id_12769(var_0) {
  var_1 = var_0.script_parameters;

  if(!isDefined(level._id_B7AE)) {
    level._id_B7AE = "";
  }

  for(;;) {
    var_0 waittill("trigger");

    if(level._id_B7AE != var_1) {
      scripts\sp\compass::setupminimap(var_1);
    }
  }
}

_id_12775(var_0) {
  scripts\engine\utility::array_thread(level.players, ::_id_BFE5, var_0);
}

_id_BFE5(var_0) {
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
      wait 0.05;
    }

    var_1 allowprone(1);
    var_1 allowcrouch(1);
  }
}

_id_1275A(var_0) {
  if(!isDefined(level._id_A0E4)) {
    level._id_A0E4 = 0;
  }

  var_0._id_12751 = level._id_A0E4;
  level._id_A0E4++;
  var_0._id_C75B = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0._id_98F5 = scripts\engine\utility::getStruct(var_0._id_C75B.target, "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(level._id_D127) || var_1 != level._id_D127) {
      continue;
    }
    if(level.player scripts\sp\utility::_id_65DB("disable_jackal_map_boundary_push")) {
      continue;
    }
    var_0 thread[[level._id_A056.trigger_func._id_A0E2]]();

    while(isalive(var_1) && isDefined(var_0) && var_1 istouching(var_0) && isDefined(level._id_D127)) {
      wait 0.05;
    }

    var_0 thread[[level._id_A056.trigger_func._id_A0E3]]();
  }
}

_id_1275B(var_0) {
  var_1 = "trigger_jackal_boundary_warning";

  if(!isDefined(level._id_A392)) {
    level._id_A392 = [];
  }

  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);
  }

  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

  if(!isDefined(var_2)) {
    var_2 = getEnt(var_0.target, "targetname");
    var_3 = 1;
  } else
    var_3 = 0;

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!isDefined(level._id_D127) || var_4 != level._id_D127) {
      continue;
    }
    if(level.player scripts\sp\utility::_id_65DB("disable_jackal_map_boundary_warning")) {
      while(isalive(var_4) && isDefined(var_0) && var_4 istouching(var_0) && isDefined(level._id_D127) && level.player scripts\sp\utility::_id_65DB("disable_jackal_map_boundary_warning")) {
        wait 0.05;
      }
    }

    if(level.player scripts\sp\utility::_id_65DB("disable_jackal_map_boundary_warning")) {
      continue;
    }
    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);
      var_2 thread _id_A391(var_4, var_3, var_1);
      level._id_A392 = scripts\engine\utility::array_add(level._id_A392, var_0);
    }

    while(isalive(var_4) && isDefined(var_0) && var_4 istouching(var_0) && isDefined(level._id_D127)) {
      wait 0.05;
    }

    level._id_A392 = scripts\engine\utility::array_remove(level._id_A392, var_0);

    if(level._id_A392.size == 0) {
      scripts\engine\utility::flag_clear(var_1);
    }
  }
}

_id_A391(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3._id_138F0 = 0;
  var_4 = 0;

  if(var_1) {
    var_5 = getpartname(self.model, 0);
    var_3 linkTo(self, var_5, (0, 0, 0), (0, 0, 0));
  } else
    var_3.origin = self.origin;

  var_6 = 0;

  while(var_6 < 1) {
    if(scripts\engine\utility::flag(var_2) || scripts\engine\utility::flag("jackal_is_autoturning")) {
      var_6 = 0;
    } else {
      var_6++;
    }

    var_7 = vectorNormalize(self.origin - level._id_D127.origin);
    var_8 = anglesToForward(level._id_D127.angles);
    var_9 = vectordot(var_7, var_8);
    var_10 = vectorNormalize(level._id_D127.spaceship_vel);
    var_11 = vectordot(var_7, var_10);

    if(var_9 > 0.1 && var_11 > 0.1) {
      if(var_4) {
        var_4 = 0;
        var_3[[level._id_A056.trigger_func._id_A0E5]](var_4);
      }
    } else if(!var_4) {
      var_4 = 1;
      var_3[[level._id_A056.trigger_func._id_A0E5]](var_4);
    }

    wait 0.05;
  }

  var_3[[level._id_A056.trigger_func._id_A0E5]](0);
  var_3 delete();
}

_id_12759(var_0) {
  var_1 = "trigger_jackal_boundary_autoturn";
  var_2 = "jackal_is_autoturning";

  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);
  }

  if(!scripts\engine\utility::flag_exist(var_2)) {
    scripts\engine\utility::flag_init(var_2);
  }

  var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!isDefined(level._id_D127) || var_4 != level._id_D127 || scripts\engine\utility::flag(var_1)) {
      continue;
    }
    if(level.player scripts\sp\utility::_id_65DB("disable_jackal_map_boundary_autoturn")) {
      while(isalive(var_4) && isDefined(var_0) && var_4 istouching(var_0) && isDefined(level._id_D127) && level.player scripts\sp\utility::_id_65DB("disable_jackal_map_boundary_autoturn")) {
        wait 0.05;
      }
    }

    if(level.player scripts\sp\utility::_id_65DB("disable_jackal_map_boundary_autoturn")) {
      continue;
    }
    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);

      if(!scripts\engine\utility::flag(var_2)) {
        var_3 thread[[level._id_A056.trigger_func._id_A0E1]](var_0, var_4, var_1, var_2);
      }

      level._id_A056._id_2698 = scripts\engine\utility::array_add(level._id_A056._id_2698, var_0);
    }

    while(isalive(var_4) && isDefined(var_0) && var_4 istouching(var_0) && isDefined(level._id_D127)) {
      wait 0.05;
    }

    level._id_A056._id_2698 = scripts\engine\utility::array_remove(level._id_A056._id_2698, var_0);

    if(level._id_A056._id_2698.size == 0) {
      scripts\engine\utility::flag_clear(var_1);
    }
  }
}

_id_1275C(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(level._id_D127) || var_1 != level._id_D127) {
      continue;
    }
    var_0 _id_A2FF();

    while(isalive(var_1) && isDefined(var_0) && var_1 istouching(var_0) && isDefined(level._id_D127)) {
      wait 0.25;
    }

    var_0 _id_A300();
  }
}

_id_A2FF() {
  if(!isDefined(level._id_A056) || !isDefined(level._id_A056._id_10991)) {
    return;
  }
  level._id_A056._id_10991 = scripts\engine\utility::array_add(level._id_A056._id_10991, self);
  level._id_A056._id_10991 = scripts\engine\utility::array_sort_with_func(level._id_A056._id_10991, ::_id_9C91);
  level notify("notify_new_jackal_speed_zone");
}

_id_A300() {
  if(!isDefined(level._id_A056) || !isDefined(level._id_A056._id_10991)) {
    return;
  }
  level._id_A056._id_10991 = scripts\engine\utility::array_remove(level._id_A056._id_10991, self);
  level notify("notify_new_jackal_speed_zone");
}

_id_9C91(var_0, var_1) {
  return var_0._id_EE8C > var_1._id_EE8C;
}

_id_12776(var_0) {
  scripts\engine\utility::array_thread(level.players, ::_id_C00E, var_0);
}

_id_C00E(var_0) {
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
      wait 0.05;
    }

    var_1 allowprone(1);
  }
}

exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(!var_0 scripts\sp\utility::script_delay()) {
      wait 4;
    }

    level thread exploder_load(var_0);
    return;
  }

  if(!var_0 scripts\sp\utility::script_delay() && isDefined(var_0._id_ED85)) {
    wait(var_0._id_ED85);
  }

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

_id_12770(var_0) {
  if(getdvarint("kleenex") != 1) {
    return;
  }
  var_0 waittill("trigger");
  scripts\sp\utility::_id_A6F2();
}

_id_1279C(var_0) {
  var_0 endon("death");
  var_1 = "stealth_in_shadow";

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!var_2 scripts\sp\utility::_id_65DF(var_1)) {
      continue;
    }
    if(var_2 scripts\sp\utility::_id_65DB(var_1)) {
      continue;
    }
    var_2 thread _id_93A4(var_0, var_1);
  }
}

_id_93A4(var_0, var_1) {
  self endon("death");
  scripts\sp\utility::_id_65E1(var_1);

  while(isDefined(var_0) && self istouching(var_0)) {
    wait 0.05;
  }

  scripts\sp\utility::_id_65DD(var_1);
}

_id_1273C(var_0) {
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

    if(isPlayer(var_4)) {
      var_3 = var_1;

      if(var_0.classname == "trigger_radius_fire") {
        if(isDefined(var_0.script_radius)) {
          if(distance2dsquared(var_4.origin, var_0.origin) <= squared(var_0.script_radius)) {
            if(isDefined(var_0._id_EE51) && isnumber(var_0._id_EE51)) {
              var_2 = var_0._id_EE51;
            }

            var_3 = var_3 * var_2;
          }
        }
      } else if(isDefined(var_0.target)) {
        var_6 = scripts\engine\utility::getStruct(var_0.target, "targetname");
        var_5 = var_6.origin;

        if(isDefined(var_6.script_radius)) {
          if(distance2dsquared(var_4.origin, var_6.origin) <= squared(var_6.script_radius)) {
            if(isDefined(var_0._id_EE51) && isnumber(var_0._id_EE51)) {
              var_2 = var_0._id_EE51;
            }

            var_3 = var_3 * var_2;
          }
        }
      }
    }

    var_4 dodamage(var_3, var_5);

    if(var_3 < 6) {
      var_4 playRumbleOnEntity("damage_light");
    } else {
      var_4 playRumbleOnEntity("damage_heavy");
    }

    var_0 scripts\sp\utility::script_delay();
  }
}