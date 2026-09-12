/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\trigger.gsc
***********************************************/

function get_load_trigger_classes() {
  var_0 = [];
  GscBinSkip0(0x2e, "trigger_multiple_nobloodpool", &trigger_nobloodpool);
}

function trigger_multiple_fx_watersheeting(var_0) {
  var_1 = 3;
  jumpiffalse(isDefined(var_0.script_duration)) LOC_0000001a;
  var_1 = var_0.script_duration;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      var_2 setwatersheeting(1, var_1);
      wait var_1 * 0.2;
    }
  }
}

function get_load_trigger_funcs() {
  var_0 = [];
  GscBinSkip0(0x2e, "friendly_mgTurret", &scripts\sp\spawner::friendly_mgturret);
}

function init_script_triggers() {
  scripts\sp\colors::init_colors();
  scripts\sp\audio::init_audio();
  scripts\engine\utility::array_delete(getEntArray("trigger_multiple_softlanding", "classname"));
  var_0 = get_load_trigger_classes();
  var_1 = get_load_trigger_funcs();

  foreach(var_3 in var_0) {
    var_4 = getEntArray(var_5, "classname");
    scripts\engine\utility::array_levelthread(var_4, var_3);
  }

  var_6 = getEntArray("trigger_multiple", "classname");
  var_7 = getEntArray("trigger_radius", "classname");
  var_4 = scripts\engine\sp\utility::array_merge(var_6, var_7);
  var_8 = getEntArray("trigger_disk", "classname");
  var_4 = scripts\engine\sp\utility::array_merge(var_4, var_8);
  var_9 = getEntArray("trigger_once", "classname");
  var_4 = scripts\engine\sp\utility::array_merge(var_4, var_9);

  if(!scripts\sp\starts::is_no_game_start()) {
    for(var_10 = 0; var_10 < var_4.size; var_10++) {
      if(var_4[var_10].spawnflags & 32) {
        thread scripts\sp\spawner::trigger_spawner(var_4[var_10]);
      }
    }
  }

  var_11 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage"];

  foreach(var_13 in var_11) {
    var_4 = getEntArray(var_13, "code_classname");

    foreach(var_15 in var_4) {
      if(isDefined(var_15.script_flag_true)) {
        thread trigger_script_flag_true(level);
      }

      if(isDefined(var_15.script_flag_false)) {
        thread trigger_script_flag_false(level);
      }

      if(isDefined(var_15.script_autosavename) || isDefined(var_15.script_autosave)) {
        level thread scripts\sp\autosave::autosave_think(var_15);
      }

      if(isDefined(var_15.script_mgturretauto)) {
        level thread scripts\sp\mgturret::mgturret_auto(var_15);
      }

      if(isDefined(var_15.script_killspawner)) {
        level thread scripts\sp\spawner::kill_spawner(var_15);
      }

      if(isDefined(var_15.script_kill_vehicle_spawner)) {
        level thread scripts\common\vehicle_code::vehicle_triggerkillspawner(var_15);
      }

      if(isDefined(var_15.script_emptyspawner)) {
        level thread scripts\sp\spawner::empty_spawner(var_15);
      }

      if(isDefined(var_15.script_prefab_exploder)) {
        var_15.script_exploder = var_15.script_prefab_exploder;
      }

      if(isDefined(var_15.script_exploder)) {
        thread exploder_load(level);
      }

      if(isDefined(var_15.script_triggered_playerseek)) {
        thread trigger_playerseek(level);
      }

      if(isDefined(var_15.script_bctrigger)) {
        thread trigger_battlechatter(level);
      }

      if(isDefined(var_15.script_trigger_group)) {
        thread trigger_group();
      }

      if(isDefined(var_15.script_random_killspawner)) {
        level thread scripts\sp\spawner::random_killspawner(var_15);
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

function trigger_createart_transient(var_0) {
  var_1 = 1;

  if(var_1) {
    var_0 delete();
    return;
  }
}

function createart_transient_thread() {}

function is_transient_createart_enabled() {
  if(getDvar("createfx") != "") {
    return true;
  }

  if(getdvarint("scr_art_tweak") > 0) {
    return true;
  }

  if(isDefined(level.start_point) && level.start_point == "no_game") {
    return true;
  }

  return false;
}

function trigger_multiple_transient(var_0) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;

  if(isDefined(var_0.script_transient)) {
    var_2 = strtok(var_0.script_transient, " ");
  }

  if(isDefined(var_0.script_transient_unload)) {
    var_3 = strtok(var_0.script_transient_unload, " ");
  }

  if(isDefined(var_0.script_transient_set)) {
    var_4 = var_0.script_transient_set;
  }

  if(isDefined(var_0.script_transient_unload_set)) {
    var_5 = 1;
  }

  var_6 = [];
  var_6 = scripts\engine\utility::array_combine(var_2, var_3);

  if(isDefined(var_0.script_transient_set)) {
    var_7 = gettransientsetnames(var_0.script_transient_set);
    var_6 = scripts\engine\utility::array_combine(var_6, var_7);
  }

  foreach(var_9 in var_6) {
    if(!scripts\engine\utility::flag_exist(var_9 + "_loaded")) {
      scripts\engine\utility::flag_init(var_9 + "_loaded");
    }
  }

  for(;;) {
    var_0 waittill("trigger");

    if(isDefined(var_3)) {
      scripts\engine\sp\utility::transient_unload_array(var_3);
    }

    if(isDefined(var_2)) {
      scripts\engine\sp\utility::transient_load_array(var_2);
    }

    if(isDefined(var_4)) {
      switchtransientset(var_4);
    }

    if(istrue(var_5)) {
      switchtransientset("none");
    }
  }
}

function trigger_damage_player_flag_set(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();
  jumpiftrue(isDefined(level.flag[var_1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isalive(var_2)) {
      continue;
    }

    if(!isPlayer(var_2)) {
      continue;
    }

    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var_1, var_2);
  }
}

function trigger_flag_clear(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger");
    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_clear(var_1);
  }
}

function trigger_flag_on_cleared(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  for(;;) {
    var_0 waittill("trigger");
    wait 1;

    if(found_toucher(var_0)) {
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_set(var_1);
}

function found_toucher() {
  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isalive(var_2)) {
      continue;
    }

    if(var_2 istouching(self)) {
      return true;
    }

    wait 0.1;
  }

  var_0 = getaiarray("bad_guys");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 istouching(self)) {
      return true;
    }
  }

  return false;
}

function trigger_flag_set(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();
  jumpiftrue(isDefined(level.flag[var_1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var_1, var_2);

    if(!isDefined(var_0)) {
      break;
    }
  }
}

function trigger_friendly_respawn(var_0) {
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
    level.respawn_spawner_org = var_2;
    scripts\engine\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

function trigger_landingzone(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var_1])) {
    scripts\engine\utility::flag_init(var_1);
  }

  jumpiftrue(isDefined(level.landingzones_active)) LOC_0000002c;
  level.landingzones_active = [];

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      level.landingzones_active = scripts\engine\utility::array_add(level.landingzones_active, var_0);
    }

    while(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      if(!scripts\engine\utility::flag(var_1)) {
        thread trigger_landingzone_active(var_1);
      }

      wait 0.25;
    }

    level.landingzones_active = scripts\engine\utility::array_remove(level.landingzones_active, var_0);
  }
}

function trigger_landingzone_active(var_0) {
  scripts\engine\utility::flag_set(var_0);

  for(;;) {
    level.landingzones_active = scripts\engine\utility::array_removeundefined(level.landingzones_active);

    if(level.landingzones_active.size == 0) {
      break;
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_clear(var_0);
}

function trigger_arbitrary_up(var_0) {
  var_0 setworlduptrigger(1);

  if(isDefined(var_0.target)) {
    var_1 = getEnt(var_0.target, "targetname");
    var_0 enablelinkTo();
    var_0 linkTo(var_1);
    return;
  }
}

function trigger_flag_set_touching(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();
  jumpiftrue(isDefined(level.flag[var_1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 scripts\engine\utility::script_delay();

    if(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      scripts\engine\utility::flag_set(var_1);
    }

    while(isalive(var_2) && isDefined(var_0) && var_2 istouching(var_0)) {
      wait 0.25;
    }

    scripts\engine\utility::flag_clear(var_1);
  }
}

function trigger_friendly_stop_respawn(var_0) {
  for(;;) {
    var_0 waittill("trigger");
    scripts\engine\utility::flag_clear("respawn_friendlies");
  }
}

function trigger_group() {
  thread trigger_group_remove();
  level endon("trigger_group_" + self.script_trigger_group);
  self waittill("trigger");
  level notify("trigger_group_" + self.script_trigger_group, self);
}

function trigger_group_remove() {
  level waittill("trigger_group_" + self.script_trigger_group, var_0);

  if(self != var_0) {
    self delete();
    return;
  }
}

function trigger_nobloodpool(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isalive(var_1)) {
      continue;
    }

    var_1.skipbloodpool = 1;
    thread set_wait_then_clear_skipbloodpool();
  }
}

function set_wait_then_clear_skipbloodpool() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait 2;
  self.skipbloodpool = undefined;
}

function trigger_physics(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_3 = getEntArray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    var_6 = spawnStruct();
    var_6.origin = var_5.origin;
    var_6.script_parameters = var_5.script_parameters;
    var_6.script_damage = var_5.script_damage;
    var_6.radius = var_5.radius;
    var_2 = var_6;
    var_5 delete();
  }

  var_0.org = var_2[0].origin;
  var_0 waittill("trigger");
  var_0 scripts\engine\utility::script_delay();

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

function trigger_playerseek(var_0) {
  var_1 = var_0.script_triggered_playerseek;
  var_0 waittill("trigger");
  var_2 = getaiarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isalive(var_2[var_3])) {
      continue;
    }

    if(isDefined(var_2[var_3].script_triggered_playerseek) && var_2[var_3].script_triggered_playerseek == var_1) {
      var_2[var_3].goalradius = 800;
      var_2[var_3] setgoalentity(level.player);
      level thread scripts\sp\spawner::delayed_player_seek_think(var_2[var_3]);
    }
  }
}

function trigger_script_flag_false(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  add_tokens_to_trigger_flags(var_0, var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

function trigger_script_flag_true(var_0) {
  var_1 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  add_tokens_to_trigger_flags(var_0, var_1);
  var_0 scripts\engine\utility::update_trigger_based_on_flags();
}

function add_tokens_to_trigger_flags(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(level.trigger_flags[var_2])) {
      level.trigger_flags[var_2] = [];
    }

    level.trigger_flags[var_2][level.trigger_flags[var_2].size] = self;
  }
}

function trigger_spawngroup(var_0) {
  waittillframeend();
  var_1 = var_0.script_spawngroup;

  if(!isDefined(level.spawn_group) || !isDefined(level.spawn_groups[var_1])) {
    return;
  }

  var_0 waittill("trigger");
  var_2 = scripts\engine\utility::random(level.spawn_groups[var_1]);

  foreach(var_4 in var_2) {
    var_4 scripts\engine\sp\utility::spawn_ai();
  }
}

function trigger_sun_off(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunEnable") == 0) {
      continue;
    }

    setsaveddvar("sm_sunEnable", 0);
  }
}

function trigger_sun_on(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(getdvarint("sm_sunEnable") == 1) {
      continue;
    }

    setsaveddvar("sm_sunEnable", 1);
  }
}

function trigger_vehicle_spline_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread scripts\common\vehicle_code::spawn_vehicle_and_attach_to_spline_path(70);
    wait 0.05;
  }
}

function get_trigger_targs() {
  var_0 = [];
  var_1 = undefined;

  if(isDefined(self.target)) {
    var_2 = getEntArray(self.target, "targetname");
    var_3 = [];

    foreach(var_5 in var_2) {
      if(var_5.classname == "script_origin") {
        var_3 = var_5;
      }

      if(issubstr(var_5.classname, "trigger")) {
        var_0 = var_5;
      }
    }

    var_2 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var_5 in var_2) {
      var_3 = var_5;
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
  GscBinSkip0(0x2e, "triggers", var_0);
}

function trigger_lookat(var_0) {
  trigger_lookat_think(var_0, 1);
}

function trigger_looking(var_0) {
  trigger_lookat_think(var_0, 0);
}

function trigger_lookat_think(var_0, var_1) {
  var_2 = 0.78;

  if(isDefined(var_0.script_dot)) {
    var_2 = var_0.script_dot;
  }

  var_3 = get_trigger_targs(var_0);
  var_4 = var_3["triggers"];
  var_5 = var_3["target_origin"];
  var_6 = isDefined(var_0.script_flag) || isDefined(var_0.script_noteworthy);
  var_7 = undefined;

  if(var_6) {
    var_7 = var_0 scripts\engine\sp\utility::get_trigger_flag();

    if(!isDefined(level.flag[var_7])) {
      scripts\engine\utility::flag_init(var_7);
    }
  } else if(var_4.size) {}

  if(var_1 && var_6) {
    level endon(var_7);
  }

  var_0 endon("death");
  var_8 = 1;
  jumpiffalse(isDefined(var_0.script_nosight)) LOC_000000a5;
  var_8 = var_0.script_nosight;

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
        scripts\engine\utility::array_thread(var_4, &scripts\engine\utility::send_notify, "trigger");

        if(var_6) {
          scripts\engine\utility::flag_set(var_7, var_9);
        }

        if(var_1) {
          return;
        }

        wait 2;
      } else if(var_6) {
        scripts\engine\utility::flag_clear(var_7);
      }

      if(var_8) {
        wait 0.5;
        continue;
      }

      wait 0.05;
    }
  }
}

function trigger_cansee(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = get_trigger_targs(var_0);
  var_1 = var_3["triggers"];
  var_2 = var_3["target_origin"];
  var_4 = isDefined(var_0.script_flag) || isDefined(var_0.script_noteworthy);
  var_5 = undefined;

  if(var_4) {
    var_5 = var_0 scripts\engine\sp\utility::get_trigger_flag();

    if(!isDefined(level.flag[var_5])) {
      scripts\engine\utility::flag_init(var_5);
    }
  } else if(var_1.size) {}

  var_0 endon("death");
  var_6 = 12;
  var_7 = [];
  GscBinSkip0(0x2e, var_7.size, (0, 0, 0));
}

function cantraceto(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(sighttracepassed(self getEye(), var_0 + var_1[var_2], 1, self)) {
      return true;
    }
  }

  return false;
}

function trigger_unlock(var_0) {
  var_1 = "not_set";

  if(isDefined(var_0.script_noteworthy)) {
    var_1 = var_0.script_noteworthy;
  }

  var_2 = getEntArray(var_0.target, "targetname");
  thread trigger_unlock_death(var_0);

  for(;;) {
    scripts\engine\utility::array_thread(var_2, &scripts\engine\utility::trigger_off);
    var_0 waittill("trigger");
    scripts\engine\utility::array_thread(var_2, &scripts\engine\utility::trigger_on);
    wait_for_an_unlocked_trigger(var_2, var_1);
    scripts\engine\sp\utility::array_notify(var_2, "relock");
  }
}

function trigger_unlock_death(var_0) {
  self waittill("death");
  var_1 = getEntArray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_1, &scripts\engine\utility::trigger_off);
}

function wait_for_an_unlocked_trigger(var_0, var_1) {
  level endon("unlocked_trigger_hit" + var_1);
  var_2 = spawnStruct();

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    thread report_trigger(var_0[var_3], var_2);
  }

  var_2 waittill("trigger");
  level notify("unlocked_trigger_hit" + var_1);
}

function report_trigger(var_0, var_1) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + var_1);
  self waittill("trigger");
  var_0 notify("trigger");
}

function trigger_battlechatter(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");

    if(issubstr(var_2[0].classname, "trigger")) {
      var_1 = var_2[0];
    }
  }

  jumpiffalse(isDefined(var_1)) LOC_00000053;
  var_1 waittill("trigger", var_3);
  goto LOC_0000005f;
}

function battlechatter_dist_check(var_0) {
  return distancesquared(var_0, level.player getorigin()) <= 262144;
}

function trigger_dooropen(var_0) {
  var_0 waittill("trigger");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = [];
  GscBinSkip0(0x2e, "left_door", -170);
}

function trigger_glass_break(var_0) {
  var_1 = getglassarray(var_0.target);
  jumpiffalse(!isDefined(var_1) || var_1.size == 0) LOC_0000001d;
  return;
}

function trigger_delete_link_chain(var_0) {
  var_0 waittill("trigger");
  var_1 = get_script_linkto_targets(var_0);
  scripts\engine\utility::array_thread(var_1, &delete_links_then_self);
}

function get_script_linkto_targets() {
  var_0 = [];

  if(!isDefined(self.script_linkto)) {
    return var_0;
  }

  var_1 = strtok(self.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = getEnt(var_3, "script_linkname");

    if(isDefined(var_4)) {
      var_0 = var_4;
    }
  }

  return var_0;
}

function delete_links_then_self() {
  var_0 = get_script_linkto_targets();
  scripts\engine\utility::array_thread(var_0, &delete_links_then_self);
  self delete();
}

function trigger_throw_grenade_at_player(var_0) {
  var_0 endon("death");
  var_0 waittill("trigger");
  scripts\sp\utility::throwgrenadeatplayerasap();
}

function trigger_hint(var_0) {
  if(!isDefined(level.displayed_hints)) {
    level.displayed_hints = [];
  }

  waittillframeend();
  var_1 = var_0.script_hint;
  var_0 waittill("trigger", var_2);

  if(isDefined(level.displayed_hints[var_1])) {
    return;
  }

  level.displayed_hints[var_1] = 1;
  var_2 scripts\engine\sp\utility::display_hint(var_1);
}

function trigger_delete_on_touch(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

function trigger_turns_off(var_0) {
  var_0 waittill("trigger");
  var_0 scripts\engine\utility::trigger_off();

  if(!isDefined(var_0.script_linkto)) {
    return;
  }

  var_1 = strtok(var_0.script_linkto, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    scripts\engine\utility::array_thread(getEntArray(var_1[var_2], "script_linkname"), &scripts\engine\utility::trigger_off);
  }
}

function trigger_ignore(var_0) {
  thread trigger_runs_function_on_touch(var_0, &scripts\engine\sp\utility::set_ignoreme, &scripts\engine\sp\utility::get_ignoreme);
}

function trigger_pacifist(var_0) {
  thread trigger_runs_function_on_touch(var_0, &scripts\engine\sp\utility::set_pacifist, &scripts\engine\sp\utility::get_pacifist);
}

function trigger_runs_function_on_touch(var_0, var_1, var_2) {
  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isalive(var_3)) {
      continue;
    }

    if(var_3[[var_2]]()) {
      continue;
    }

    thread touched_trigger_runs_func(var_3, var_0);
  }
}

function touched_trigger_runs_func(var_0, var_1) {
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

function trigger_radio(var_0) {
  var_0 waittill("trigger");
  scripts\engine\sp\utility::radio_dialogue(var_0.script_noteworthy);
}

function trigger_flag_set_player(var_0) {
  var_1 = var_0 scripts\engine\sp\utility::get_trigger_flag();
  jumpiftrue(isDefined(level.flag[var_1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var_1);

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }

    var_0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var_1);
  }
}

function trigger_multiple_sunflare(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_0.script_noteworthy)) {
      var_1 scripts\sp\art::sunflare_changes(var_0.script_noteworthy, var_0.script_delay);
    }

    waitframe();
  }
}

function trigger_multiple_depthoffield(var_0) {
  waittillframeend();

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0.script_dof_near_start;
    var_3 = var_0.script_dof_near_end;
    var_4 = var_0.script_dof_near_blur;
    var_5 = var_0.script_dof_far_start;
    var_6 = var_0.script_dof_far_end;
    var_7 = var_0.script_dof_far_blur;
    var_8 = var_0.script_delay;

    if(var_2 != level.dof["base"]["goal"]["nearStart"] || var_3 != level.dof["base"]["goal"]["nearEnd"] || var_4 != level.dof["base"]["goal"]["nearBlur"] || var_5 != level.dof["base"]["goal"]["farStart"] || var_6 != level.dof["base"]["goal"]["farEnd"] || var_7 != level.dof["base"]["goal"]["farBlur"]) {
      scripts\sp\art::dof_set_base(var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      wait var_8;
      continue;
    }

    waitframe();
  }
}

function trigger_multiple_tessellationcutoff(var_0) {
  waittillframeend();

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_2 = var_0.script_tess_distance;
    var_3 = var_0.script_tess_falloff;
    var_4 = var_0.script_delay;

    if(var_2 != level.tess.cutoff_distance_goal || var_3 != level.tess.cutoff_falloff_goal) {
      var_2 = max(0, var_2);
      var_2 = min(10000, var_2);
      var_3 = max(0, var_3);
      var_3 = min(10000, var_3);
      scripts\sp\art::tess_set_goal(var_2, var_3, var_4);
      continue;
    }

    waitframe();
  }
}

function trigger_slide(var_0) {
  setdvarifuninitialized("use_legacy_slide", 0);

  for(;;) {
    var_0 waittill("trigger", var_1);
    thread slidetriggerplayerthink(var_1);
  }
}

function slidetriggerplayerthink(var_0) {
  if(isDefined(self.vehicle)) {
    return;
  }

  if(scripts\engine\sp\utility::issliding() || self isjumping()) {
    return;
  }

  if(isDefined(self.player_view)) {
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
    thread scripts\engine\sp\utility::beginslidinglegacy();
  } else {
    thread scripts\engine\sp\utility::beginsliding(undefined, var_1);
  }

  for(;;) {
    if(!self istouching(var_0)) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(level.end_slide_delay)) {
    wait level.end_slide_delay;
  }

  if(getdvarint("use_legacy_slide") > 0) {
    scripts\engine\sp\utility::endslidinglegacy();
    return;
  }

  scripts\engine\sp\utility::endsliding();
}

function trigger_multiple_fx_volume(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_0.fx = [];

  foreach(var_3 in level.createfxent) {
    assign_fx_to_trigger(var_3, var_0, var_1);
  }

  var_1 delete();

  if(!isDefined(var_0.target)) {
    return;
  }

  var_5 = getEntArray(var_0.target, "targetname");
  var_0.fx_on = 1;

  foreach(var_7 in var_5) {
    switch (var_7.classname) {
      case "trigger_multiple_fx_volume_on":
        thread trigger_multiple_fx_trigger_on_think(var_7);
        break;
      case "trigger_multiple_fx_volume_off":
        thread trigger_multiple_fx_trigger_off_think(var_7);
        break;
      default:
        break;
    }
  }
}

function trigger_multiple_fx_trigger_on_think(var_0) {
  for(;;) {
    self waittill("trigger");

    if(!var_0.fx_on) {
      scripts\engine\utility::array_thread(var_0.fx, &scripts\engine\sp\utility::restarteffect);
    }

    wait 1;
  }
}

function trigger_multiple_fx_trigger_off_think(var_0) {
  for(;;) {
    self waittill("trigger");

    if(var_0.fx_on) {
      scripts\engine\utility::array_thread(var_0.fx, &scripts\engine\utility::pauseeffect);
    }

    wait 1;
  }
}

function assign_fx_to_trigger(var_0, var_1, var_2) {
  if(isDefined(var_0.v["soundalias"]) && var_0.v["soundalias"] != "nil") {
    if(!isDefined(var_0.v["stopable"]) || !var_0.v["stopable"]) {
      return;
    }
  }

  var_2.origin = var_0.v["origin"];

  if(var_2 istouching(var_1)) {
    var_1.fx[var_1.fx.size] = var_0;
    return;
  }
}

function trigger_multiple_compass(var_0) {
  var_1 = var_0.script_parameters;

  if(!isDefined(level.minimap_image)) {
    level.minimap_image = "";
  }

  for(;;) {
    var_0 waittill("trigger");

    if(level.minimap_image != var_1) {
      scripts\sp\compass::setupminimap(var_1);
    }
  }
}

function trigger_no_crouch_or_prone(var_0) {
  scripts\engine\utility::array_thread(level.players, &no_crouch_or_prone_think_for_player, var_0);
}

function no_crouch_or_prone_think_for_player(var_0) {
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

function trigger_no_prone(var_0) {
  scripts\engine\utility::array_thread(level.players, &no_prone_for_player, var_0);
}

function no_prone_for_player(var_0) {
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

function exploder_load(var_0) {
  level endon("killexplodertridgers" + var_0.script_exploder);
  var_0 waittill("trigger");

  if(isDefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(!var_0 scripts\engine\utility::script_delay()) {
      wait 4;
    }

    thread exploder_load(level);
    return;
  }

  if(!var_0 scripts\engine\utility::script_delay() && isDefined(var_0.script_exploder_delay)) {
    wait var_0.script_exploder_delay;
  }

  scripts\engine\utility::exploder(var_0.script_exploder);
  level notify("killexplodertridgers" + var_0.script_exploder);
}

function trigger_multiple_kleenex(var_0) {
  if(getdvarint("kleenex") != 1) {
    return;
  }

  var_0 waittill("trigger");
  scripts\engine\sp\utility::kleenex_popup();
}

function trigger_stealth_shadow(var_0) {
  var_0 endon("death");
  var_1 = "stealth_in_shadow";

  if(!isDefined(level.trigger_stealth_shadow)) {
    level.trigger_stealth_shadow = [];
  }

  level.trigger_stealth_shadow[level.trigger_stealth_shadow.size] = var_0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!var_2 scripts\engine\utility::ent_flag_exist(var_1)) {
      continue;
    }

    if(var_2 scripts\engine\utility::ent_flag(var_1)) {
      continue;
    }

    thread in_shadow_thread(var_2, var_0);
  }
}

function in_shadow_thread(var_0, var_1) {
  self endon("death");
  scripts\engine\utility::ent_flag_set(var_1);

  while(isDefined(var_0) && self istouching(var_0)) {
    wait 0.05;
  }

  scripts\engine\utility::ent_flag_clear(var_1);
}

function trigger_fire(var_0) {
  var_0 endon("death");

  if(isDefined(var_0.trigger_fire_endon)) {
    var_0 endon(var_0.trigger_fire_endon);
  }

  var_1 = 1;
  var_2 = 5;
  var_3 = 0;

  if(!isDefined(var_0.script_delay_min) && !isDefined(var_0.script_delay_max)) {
    var_0.script_delay_min = 0.05;
    var_0.script_delay_max = 0.05;
  }

  if(var_0.script_delay_min == var_0.script_delay_max) {
    var_0.script_delay = var_0.script_delay_min;
  }

  jumpiffalse(isDefined(var_0.script_damage)) LOC_00000090;
  var_1 = var_0.script_damage;

  for(;;) {
    var_0 waittill("trigger", var_4);
    var_5 = var_0.origin;

    if(isPlayer(var_4)) {
      var_3 = var_1;

      if(var_0.classname == "trigger_radius_fire") {
        if(isDefined(var_0.script_radius)) {
          if(distance2dsquared(var_4.origin, var_0.origin) <= squared(var_0.script_radius)) {
            if(isDefined(var_0.script_multiplier) && isnumber(var_0.script_multiplier)) {
              var_2 = var_0.script_multiplier;
            }

            var_3 *= var_2;
          }
        }
      } else if(isDefined(var_0.target)) {
        var_6 = scripts\engine\utility::getStruct(var_0.target, "targetname");
        var_5 = var_6.origin;

        if(isDefined(var_6.script_radius)) {
          if(distance2dsquared(var_4.origin, var_6.origin) <= squared(var_6.script_radius)) {
            if(isDefined(var_0.script_multiplier) && isnumber(var_0.script_multiplier)) {
              var_2 = var_0.script_multiplier;
            }

            var_3 *= var_2;
          }
        }
      }
    }

    if(istrue(var_4.damageshield)) {
      continue;
    }

    var_4 scripts\sp\utility::do_damage(var_3, var_5, undefined, undefined, "MOD_FIRE");

    if(var_3 < 6) {
      var_4 playRumbleOnEntity("damage_light");
    } else {
      var_4 playRumbleOnEntity("damage_heavy");
    }

    var_0 scripts\engine\utility::script_delay();
  }
}

function trigger_multiple_fx(var_0) {
  if(var_0.classname == "trigger_multiple_fx_on") {
    var_1 = &scripts\common\fx::struct_fx_inactive;
    var_2 = &scripts\common\fx::play_struct_fx;
    goto LOC_00000030;
  }

  var_1 = &scripts\common\fx::struct_fx_active;
  var_2 = &scripts\common\fx::stop_struct_fx;

  for(;;) {
    var_2 waittill("trigger");

    foreach(var_4 in level.struct_fx) {
      if([[var_1]](var_4) && scripts\engine\utility::is_equal(var_4.script_fxgroup, var_2.script_fxgroup)) {
        [[var_2]](var_4);
      }
    }
  }
}

function trigger_outofbounds(var_0) {
  var_0.failtrigger = getEnt(var_0.target, "targetname");
  var_0 endon("death");
  var_0 waittill("trigger");
  GscBinSkip4(0x6e, var_0.failtrigger);
}

function outofbounds_failthread() {
  self endon("death");
  self endon("stop_failthread");
  self waittill("trigger");
  setomnvar("ui_out_of_bounds_countdown", 0);
  scripts\sp\player_death::set_custom_death_quote(29);
  scripts\sp\utility::missionfailedwrapper();
}