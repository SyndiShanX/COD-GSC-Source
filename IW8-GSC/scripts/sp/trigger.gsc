/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\trigger.gsc
***********************************************/

function get_load_trigger_classes() {
  var0 = [];
  GscBinSkip0(0x2e, "trigger_multiple_nobloodpool", &trigger_nobloodpool);
}

function trigger_multiple_fx_watersheeting(var0) {
  var1 = 3;
  jumpiffalse(isDefined(var0.script_duration)) LOC_0000001a;
  var1 = var0.script_duration;

  for(;;) {
    var0 waittill("trigger", var2);

    if(isPlayer(var2)) {
      var2 setwatersheeting(1, var1);
      wait var1 * 0.2;
    }
  }
}

function get_load_trigger_funcs() {
  var0 = [];
  GscBinSkip0(0x2e, "friendly_mgTurret", &scripts\sp\spawner::friendly_mgturret);
}

function init_script_triggers() {
  scripts\sp\colors::init_colors();
  scripts\sp\audio::init_audio();
  scripts\engine\utility::array_delete(getEntArray("trigger_multiple_softlanding", "classname"));
  var0 = get_load_trigger_classes();
  var1 = get_load_trigger_funcs();

  foreach(var3 in var0) {
    var4 = getEntArray(var5, "classname");
    scripts\engine\utility::array_levelthread(var4, var3);
  }

  var6 = getEntArray("trigger_multiple", "classname");
  var7 = getEntArray("trigger_radius", "classname");
  var4 = scripts\engine\sp\utility::array_merge(var6, var7);
  var8 = getEntArray("trigger_disk", "classname");
  var4 = scripts\engine\sp\utility::array_merge(var4, var8);
  var9 = getEntArray("trigger_once", "classname");
  var4 = scripts\engine\sp\utility::array_merge(var4, var9);

  if(!scripts\sp\starts::is_no_game_start()) {
    for(var10 = 0; var10 < var4.size; var10++) {
      if(var4[var10].spawnflags & 32) {
        thread scripts\sp\spawner::trigger_spawner(var4[var10]);
      }
    }
  }

  var11 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage"];

  foreach(var13 in var11) {
    var4 = getEntArray(var13, "code_classname");

    foreach(var15 in var4) {
      if(isDefined(var15.script_flag_true)) {
        thread trigger_script_flag_true(level);
      }

      if(isDefined(var15.script_flag_false)) {
        thread trigger_script_flag_false(level);
      }

      if(isDefined(var15.script_autosavename) || isDefined(var15.script_autosave)) {
        level thread scripts\sp\autosave::autosave_think(var15);
      }

      if(isDefined(var15.script_mgturretauto)) {
        level thread scripts\sp\mgturret::mgturret_auto(var15);
      }

      if(isDefined(var15.script_killspawner)) {
        level thread scripts\sp\spawner::kill_spawner(var15);
      }

      if(isDefined(var15.script_kill_vehicle_spawner)) {
        level thread scripts\common\vehicle_code::vehicle_triggerkillspawner(var15);
      }

      if(isDefined(var15.script_emptyspawner)) {
        level thread scripts\sp\spawner::empty_spawner(var15);
      }

      if(isDefined(var15.script_prefab_exploder)) {
        var15.script_exploder = var15.script_prefab_exploder;
      }

      if(isDefined(var15.script_exploder)) {
        thread exploder_load(level);
      }

      if(isDefined(var15.script_triggered_playerseek)) {
        thread trigger_playerseek(level);
      }

      if(isDefined(var15.script_bctrigger)) {
        thread trigger_battlechatter(level);
      }

      if(isDefined(var15.script_trigger_group)) {
        thread trigger_group();
      }

      if(isDefined(var15.script_random_killspawner)) {
        level thread scripts\sp\spawner::random_killspawner(var15);
      }

      if(isDefined(var15.targetname)) {
        var16 = var15.targetname;

        if(isDefined(var1[var16])) {
          level thread[[var1[var16]]](var15);
        }
      }
    }
  }
}

function trigger_createart_transient(var0) {
  var1 = 1;

  if(var1) {
    var0 delete();
    return;
  }
}

function createart_transient_thread() {}

function is_transient_createart_enabled() {
  if(getDvar("LSTTOTKPNP") != "") {
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

function trigger_multiple_transient(var0) {
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = 0;

  if(isDefined(var0.script_transient)) {
    var2 = strtok(var0.script_transient, " ");
  }

  if(isDefined(var0.script_transient_unload)) {
    var3 = strtok(var0.script_transient_unload, " ");
  }

  if(isDefined(var0.script_transient_set)) {
    var4 = var0.script_transient_set;
  }

  if(isDefined(var0.script_transient_unload_set)) {
    var5 = 1;
  }

  var6 = [];
  var6 = scripts\engine\utility::array_combine(var2, var3);

  if(isDefined(var0.script_transient_set)) {
    var7 = gettransientsetnames(var0.script_transient_set);
    var6 = scripts\engine\utility::array_combine(var6, var7);
  }

  foreach(var9 in var6) {
    if(!scripts\engine\utility::flag_exist(var9 + "_loaded")) {
      scripts\engine\utility::flag_init(var9 + "_loaded");
    }
  }

  for(;;) {
    var0 waittill("trigger");

    if(isDefined(var3)) {
      scripts\engine\sp\utility::transient_unload_array(var3);
    }

    if(isDefined(var2)) {
      scripts\engine\sp\utility::transient_load_array(var2);
    }

    if(isDefined(var4)) {
      switchtransientset(var4);
    }

    if(istrue(var5)) {
      switchtransientset("none");
    }
  }
}

function trigger_damage_player_flag_set(var0) {
  var1 = var0 scripts\engine\sp\utility::get_trigger_flag();
  jumpiftrue(isDefined(level.flag[var1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var1);

  for(;;) {
    var0 waittill("trigger", var2);

    if(!isalive(var2)) {
      continue;
    }

    if(!isPlayer(var2)) {
      continue;
    }

    var0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var1, var2);
  }
}

function trigger_flag_clear(var0) {
  var1 = var0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var1])) {
    scripts\engine\utility::flag_init(var1);
  }

  for(;;) {
    var0 waittill("trigger");
    var0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_clear(var1);
  }
}

function trigger_flag_on_cleared(var0) {
  var1 = var0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var1])) {
    scripts\engine\utility::flag_init(var1);
  }

  for(;;) {
    var0 waittill("trigger");
    wait 1;

    if(found_toucher(var0)) {
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_set(var1);
}

function found_toucher() {
  var0 = getaiarray("bad_guys");

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(!isalive(var2)) {
      continue;
    }

    if(var2 istouching(self)) {
      return true;
    }

    wait 0.1;
  }

  var0 = getaiarray("bad_guys");

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(var2 istouching(self)) {
      return true;
    }
  }

  return false;
}

function trigger_flag_set(var0) {
  var1 = var0 scripts\engine\sp\utility::get_trigger_flag();
  jumpiftrue(isDefined(level.flag[var1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var1);

  for(;;) {
    var0 waittill("trigger", var2);
    var0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var1, var2);

    if(!isDefined(var0)) {
      break;
    }
  }
}

function trigger_friendly_respawn(var0) {
  var0 endon("death");
  var1 = getEnt(var0.target, "targetname");
  var2 = undefined;

  if(isDefined(var1)) {
    var2 = var1.origin;
    var1 delete();
  } else {
    var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
    var2 = var1.origin;
  }

  for(;;) {
    var0 waittill("trigger");
    level.respawn_spawner_org = var2;
    scripts\engine\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

function trigger_landingzone(var0) {
  var1 = var0 scripts\engine\sp\utility::get_trigger_flag();

  if(!isDefined(level.flag[var1])) {
    scripts\engine\utility::flag_init(var1);
  }

  jumpiftrue(isDefined(level.landingzones_active)) LOC_0000002c;
  level.landingzones_active = [];

  for(;;) {
    var0 waittill("trigger", var2);

    if(isalive(var2) && isDefined(var0) && var2 istouching(var0)) {
      level.landingzones_active = scripts\engine\utility::array_add(level.landingzones_active, var0);
    }

    while(isalive(var2) && isDefined(var0) && var2 istouching(var0)) {
      if(!scripts\engine\utility::flag(var1)) {
        thread trigger_landingzone_active(var1);
      }

      wait 0.25;
    }

    level.landingzones_active = scripts\engine\utility::array_remove(level.landingzones_active, var0);
  }
}

function trigger_landingzone_active(var0) {
  scripts\engine\utility::flag_set(var0);

  for(;;) {
    level.landingzones_active = scripts\engine\utility::array_removeundefined(level.landingzones_active);

    if(level.landingzones_active.size == 0) {
      break;
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_clear(var0);
}

function trigger_arbitrary_up(var0) {
  var0 setworlduptrigger(1);

  if(isDefined(var0.target)) {
    var1 = getEnt(var0.target, "targetname");
    var0 enablelinkTo();
    var0 linkTo(var1);
    return;
  }
}

function trigger_flag_set_touching(var0) {
  var1 = var0 scripts\engine\sp\utility::get_trigger_flag();
  jumpiftrue(isDefined(level.flag[var1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var1);

  for(;;) {
    var0 waittill("trigger", var2);
    var0 scripts\engine\utility::script_delay();

    if(isalive(var2) && isDefined(var0) && var2 istouching(var0)) {
      scripts\engine\utility::flag_set(var1);
    }

    while(isalive(var2) && isDefined(var0) && var2 istouching(var0)) {
      wait 0.25;
    }

    scripts\engine\utility::flag_clear(var1);
  }
}

function trigger_friendly_stop_respawn(var0) {
  for(;;) {
    var0 waittill("trigger");
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
  level waittill("trigger_group_" + self.script_trigger_group, var0);

  if(self != var0) {
    self delete();
    return;
  }
}

function trigger_nobloodpool(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(!isalive(var1)) {
      continue;
    }

    var1.skipbloodpool = 1;
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

function trigger_physics(var0) {
  var1 = [];
  var2 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var3 = getEntArray(var0.target, "targetname");

  foreach(var5 in var3) {
    var6 = spawnStruct();
    var6.origin = var5.origin;
    var6.script_parameters = var5.script_parameters;
    var6.script_damage = var5.script_damage;
    var6.radius = var5.radius;
    var2 = var6;
    var5 delete();
  }

  var0.org = var2[0].origin;
  var0 waittill("trigger");
  var0 scripts\engine\utility::script_delay();

  foreach(var6 in var2) {
    var9 = var6.radius;
    var10 = var6.script_parameters;
    var11 = var6.script_damage;

    if(!isDefined(var9)) {
      var9 = 350;
    }

    if(!isDefined(var10)) {
      var10 = 0.25;
    }

    setDvar("tempdvar", var10);
    var10 = getdvarfloat("tempdvar");

    if(isDefined(var11)) {
      radiusdamage(var6.origin, var9, var11, var11 * 0.5);
    }

    physicsexplosionsphere(var6.origin, var9, var9 * 0.5, var10);
  }
}

function trigger_playerseek(var0) {
  var1 = var0.script_triggered_playerseek;
  var0 waittill("trigger");
  var2 = getaiarray();

  for(var3 = 0; var3 < var2.size; var3++) {
    if(!isalive(var2[var3])) {
      continue;
    }

    if(isDefined(var2[var3].script_triggered_playerseek) && var2[var3].script_triggered_playerseek == var1) {
      var2[var3].goalradius = 800;
      var2[var3] setgoalentity(level.player);
      level thread scripts\sp\spawner::delayed_player_seek_think(var2[var3]);
    }
  }
}

function trigger_script_flag_false(var0) {
  var1 = scripts\engine\utility::create_flags_and_return_tokens(var0.script_flag_false);
  add_tokens_to_trigger_flags(var0, var1);
  var0 scripts\engine\utility::update_trigger_based_on_flags();
}

function trigger_script_flag_true(var0) {
  var1 = scripts\engine\utility::create_flags_and_return_tokens(var0.script_flag_true);
  add_tokens_to_trigger_flags(var0, var1);
  var0 scripts\engine\utility::update_trigger_based_on_flags();
}

function add_tokens_to_trigger_flags(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(!isDefined(level.trigger_flags[var2])) {
      level.trigger_flags[var2] = [];
    }

    level.trigger_flags[var2][level.trigger_flags[var2].size] = self;
  }
}

function trigger_spawngroup(var0) {
  waittillframeend();
  var1 = var0.script_spawngroup;

  if(!isDefined(level.spawn_group) || !isDefined(level.spawn_groups[var1])) {
    return;
  }

  var0 waittill("trigger");
  var2 = scripts\engine\utility::random(level.spawn_groups[var1]);

  foreach(var4 in var2) {
    var4 scripts\engine\sp\utility::spawn_ai();
  }
}

function trigger_sun_off(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(getdvarint("MQRQQONQSL") == 0) {
      continue;
    }

    setsaveddvar("MQRQQONQSL", 0);
  }
}

function trigger_sun_on(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(getdvarint("MQRQQONQSL") == 1) {
      continue;
    }

    setsaveddvar("MQRQQONQSL", 1);
  }
}

function trigger_vehicle_spline_spawn(var0) {
  var0 waittill("trigger");
  var1 = getEntArray(var0.target, "targetname");

  foreach(var3 in var1) {
    var3 thread scripts\common\vehicle_code::spawn_vehicle_and_attach_to_spline_path(70);
    wait 0.05;
  }
}

function get_trigger_targs() {
  var0 = [];
  var1 = undefined;

  if(isDefined(self.target)) {
    var2 = getEntArray(self.target, "targetname");
    var3 = [];

    foreach(var5 in var2) {
      if(var5.classname == "script_origin") {
        var3 = var5;
      }

      if(issubstr(var5.classname, "trigger")) {
        var0 = var5;
      }
    }

    var2 = scripts\engine\utility::getStructArray(self.target, "targetname");

    foreach(var5 in var2) {
      var3 = var5;
    }

    if(var3.size == 1) {
      var9 = var3[0];
      var1 = var9.origin;

      if(isDefined(var9.code_classname)) {
        var9 delete();
      }
    }
  }

  var10 = [];
  GscBinSkip0(0x2e, "triggers", var0);
}

function trigger_lookat(var0) {
  trigger_lookat_think(var0, 1);
}

function trigger_looking(var0) {
  trigger_lookat_think(var0, 0);
}

function trigger_lookat_think(var0, var1) {
  var2 = 0.78;

  if(isDefined(var0.script_dot)) {
    var2 = var0.script_dot;
  }

  var3 = get_trigger_targs(var0);
  var4 = var3["triggers"];
  var5 = var3["target_origin"];
  var6 = isDefined(var0.script_flag) || isDefined(var0.script_noteworthy);
  var7 = undefined;

  if(var6) {
    var7 = var0 scripts\engine\sp\utility::get_trigger_flag();

    if(!isDefined(level.flag[var7])) {
      scripts\engine\utility::flag_init(var7);
    }
  } else if(var4.size) {}

  if(var1 && var6) {
    level endon(var7);
  }

  var0 endon("death");
  var8 = 1;
  jumpiffalse(isDefined(var0.script_nosight)) LOC_000000a5;
  var8 = var0.script_nosight;

  for(;;) {
    if(var6) {
      scripts\engine\utility::flag_clear(var7);
    }

    var0 waittill("trigger", var9);
    var10 = [];

    while(var9 istouching(var0)) {
      if(var8 && !sighttracepassed(var9 getEye(), var5, 0, undefined)) {
        if(var6) {
          scripts\engine\utility::flag_clear(var7);
        }

        wait 0.5;
        continue;
      }

      var11 = vectorNormalize(var5 - var9.origin);
      var12 = var9 getplayerangles();
      var13 = anglesToForward(var12);
      var14 = vectordot(var13, var11);

      if(var14 >= var2) {
        scripts\engine\utility::array_thread(var4, &scripts\engine\utility::send_notify, "trigger");

        if(var6) {
          scripts\engine\utility::flag_set(var7, var9);
        }

        if(var1) {
          return;
        }

        wait 2;
      } else if(var6) {
        scripts\engine\utility::flag_clear(var7);
      }

      if(var8) {
        wait 0.5;
        continue;
      }

      wait 0.05;
    }
  }
}

function trigger_cansee(var0) {
  var1 = [];
  var2 = undefined;
  var3 = get_trigger_targs(var0);
  var1 = var3["triggers"];
  var2 = var3["target_origin"];
  var4 = isDefined(var0.script_flag) || isDefined(var0.script_noteworthy);
  var5 = undefined;

  if(var4) {
    var5 = var0 scripts\engine\sp\utility::get_trigger_flag();

    if(!isDefined(level.flag[var5])) {
      scripts\engine\utility::flag_init(var5);
    }
  } else if(var1.size) {}

  var0 endon("death");
  var6 = 12;
  var7 = [];
  GscBinSkip0(0x2e, var7.size, (0, 0, 0));
}

function cantraceto(var0, var1) {
  for(var2 = 0; var2 < var1.size; var2++) {
    if(sighttracepassed(self getEye(), var0 + var1[var2], 1, self)) {
      return true;
    }
  }

  return false;
}

function trigger_unlock(var0) {
  var1 = "not_set";

  if(isDefined(var0.script_noteworthy)) {
    var1 = var0.script_noteworthy;
  }

  var2 = getEntArray(var0.target, "targetname");
  thread trigger_unlock_death(var0);

  for(;;) {
    scripts\engine\utility::array_thread(var2, &scripts\engine\utility::trigger_off);
    var0 waittill("trigger");
    scripts\engine\utility::array_thread(var2, &scripts\engine\utility::trigger_on);
    wait_for_an_unlocked_trigger(var2, var1);
    scripts\engine\sp\utility::array_notify(var2, "relock");
  }
}

function trigger_unlock_death(var0) {
  self waittill("death");
  var1 = getEntArray(var0, "targetname");
  scripts\engine\utility::array_thread(var1, &scripts\engine\utility::trigger_off);
}

function wait_for_an_unlocked_trigger(var0, var1) {
  level endon("unlocked_trigger_hit" + var1);
  var2 = spawnStruct();

  for(var3 = 0; var3 < var0.size; var3++) {
    thread report_trigger(var0[var3], var2);
  }

  var2 waittill("trigger");
  level notify("unlocked_trigger_hit" + var1);
}

function report_trigger(var0, var1) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + var1);
  self waittill("trigger");
  var0 notify("trigger");
}

function trigger_battlechatter(var0) {
  var1 = undefined;

  if(isDefined(var0.target)) {
    var2 = getEntArray(var0.target, "targetname");

    if(issubstr(var2[0].classname, "trigger")) {
      var1 = var2[0];
    }
  }

  jumpiffalse(isDefined(var1)) LOC_00000053;
  var1 waittill("trigger", var3);
  goto LOC_0000005f;
}

function battlechatter_dist_check(var0) {
  return distancesquared(var0, level.player getorigin()) <= 262144;
}

function trigger_dooropen(var0) {
  var0 waittill("trigger");
  var1 = getEntArray(var0.target, "targetname");
  var2 = [];
  GscBinSkip0(0x2e, "left_door", -170);
}

function trigger_glass_break(var0) {
  var1 = getglassarray(var0.target);
  jumpiffalse(!isDefined(var1) || var1.size == 0) LOC_0000001d;
  return;
}

function trigger_delete_link_chain(var0) {
  var0 waittill("trigger");
  var1 = get_script_linkto_targets(var0);
  scripts\engine\utility::array_thread(var1, &delete_links_then_self);
}

function get_script_linkto_targets() {
  var0 = [];

  if(!isDefined(self.script_linkto)) {
    return var0;
  }

  var1 = strtok(self.script_linkto, " ");

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];
    var4 = getEnt(var3, "script_linkname");

    if(isDefined(var4)) {
      var0 = var4;
    }
  }

  return var0;
}

function delete_links_then_self() {
  var0 = get_script_linkto_targets();
  scripts\engine\utility::array_thread(var0, &delete_links_then_self);
  self delete();
}

function trigger_throw_grenade_at_player(var0) {
  var0 endon("death");
  var0 waittill("trigger");
  scripts\sp\utility::throwgrenadeatplayerasap();
}

function trigger_hint(var0) {
  if(!isDefined(level.displayed_hints)) {
    level.displayed_hints = [];
  }

  waittillframeend();
  var1 = var0.script_hint;
  var0 waittill("trigger", var2);

  if(isDefined(level.displayed_hints[var1])) {
    return;
  }

  level.displayed_hints[var1] = 1;
  var2 scripts\engine\sp\utility::display_hint(var1);
}

function trigger_delete_on_touch(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(isDefined(var1)) {
      var1 delete();
    }
  }
}

function trigger_turns_off(var0) {
  var0 waittill("trigger");
  var0 scripts\engine\utility::trigger_off();

  if(!isDefined(var0.script_linkto)) {
    return;
  }

  var1 = strtok(var0.script_linkto, " ");

  for(var2 = 0; var2 < var1.size; var2++) {
    scripts\engine\utility::array_thread(getEntArray(var1[var2], "script_linkname"), &scripts\engine\utility::trigger_off);
  }
}

function trigger_ignore(var0) {
  thread trigger_runs_function_on_touch(var0, &scripts\engine\sp\utility::set_ignoreme, &scripts\engine\sp\utility::get_ignoreme);
}

function trigger_pacifist(var0) {
  thread trigger_runs_function_on_touch(var0, &scripts\engine\sp\utility::set_pacifist, &scripts\engine\sp\utility::get_pacifist);
}

function trigger_runs_function_on_touch(var0, var1, var2) {
  for(;;) {
    var0 waittill("trigger", var3);

    if(!isalive(var3)) {
      continue;
    }

    if(var3[[var2]]()) {
      continue;
    }

    thread touched_trigger_runs_func(var3, var0);
  }
}

function touched_trigger_runs_func(var0, var1) {
  self endon("death");
  self.ignoreme = 1;
  [[var1]](1);
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while(self istouching(var0)) {
    wait 1;
  }

  [[var1]](0);
}

function trigger_radio(var0) {
  var0 waittill("trigger");
  scripts\engine\sp\utility::radio_dialogue(var0.script_noteworthy);
}

function trigger_flag_set_player(var0) {
  var1 = var0 scripts\engine\sp\utility::get_trigger_flag();
  jumpiftrue(isDefined(level.flag[var1])) LOC_0000001d;
  scripts\engine\utility::flag_init(var1);

  for(;;) {
    var0 waittill("trigger", var2);

    if(!isPlayer(var2)) {
      continue;
    }

    var0 scripts\engine\utility::script_delay();
    scripts\engine\utility::flag_set(var1);
  }
}

function trigger_multiple_sunflare(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(isDefined(var0.script_noteworthy)) {
      var1 scripts\sp\art::sunflare_changes(var0.script_noteworthy, var0.script_delay);
    }

    waitframe();
  }
}

function trigger_multiple_depthoffield(var0) {
  waittillframeend();

  for(;;) {
    var0 waittill("trigger", var1);
    var2 = var0.script_dof_near_start;
    var3 = var0.script_dof_near_end;
    var4 = var0.script_dof_near_blur;
    var5 = var0.script_dof_far_start;
    var6 = var0.script_dof_far_end;
    var7 = var0.script_dof_far_blur;
    var8 = var0.script_delay;

    if(var2 != level.dof["base"]["goal"]["nearStart"] || var3 != level.dof["base"]["goal"]["nearEnd"] || var4 != level.dof["base"]["goal"]["nearBlur"] || var5 != level.dof["base"]["goal"]["farStart"] || var6 != level.dof["base"]["goal"]["farEnd"] || var7 != level.dof["base"]["goal"]["farBlur"]) {
      scripts\sp\art::dof_set_base(var2, var3, var4, var5, var6, var7, var8);
      wait var8;
      continue;
    }

    waitframe();
  }
}

function trigger_multiple_tessellationcutoff(var0) {
  waittillframeend();

  for(;;) {
    var0 waittill("trigger", var1);
    var2 = var0.script_tess_distance;
    var3 = var0.script_tess_falloff;
    var4 = var0.script_delay;

    if(var2 != level.tess.cutoff_distance_goal || var3 != level.tess.cutoff_falloff_goal) {
      var2 = max(0, var2);
      var2 = min(10000, var2);
      var3 = max(0, var3);
      var3 = min(10000, var3);
      scripts\sp\art::tess_set_goal(var2, var3, var4);
      continue;
    }

    waitframe();
  }
}

function trigger_slide(var0) {
  setdvarifuninitialized("use_legacy_slide", 0);

  for(;;) {
    var0 waittill("trigger", var1);
    thread slidetriggerplayerthink(var1);
  }
}

function slidetriggerplayerthink(var0) {
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

  var1 = undefined;

  if(isDefined(var0.script_accel)) {
    var1 = var0.script_accel;
  }

  self endon("cancel_sliding");

  if(getdvarint("use_legacy_slide") > 0) {
    thread scripts\engine\sp\utility::beginslidinglegacy();
  } else {
    thread scripts\engine\sp\utility::beginsliding(undefined, var1);
  }

  for(;;) {
    if(!self istouching(var0)) {
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

function trigger_multiple_fx_volume(var0) {
  var1 = spawn("script_origin", (0, 0, 0));
  var0.fx = [];

  foreach(var3 in level.createfxent) {
    assign_fx_to_trigger(var3, var0, var1);
  }

  var1 delete();

  if(!isDefined(var0.target)) {
    return;
  }

  var5 = getEntArray(var0.target, "targetname");
  var0.fx_on = 1;

  foreach(var7 in var5) {
    switch (var7.classname) {
      case "trigger_multiple_fx_volume_on":
        thread trigger_multiple_fx_trigger_on_think(var7);
        break;
      case "trigger_multiple_fx_volume_off":
        thread trigger_multiple_fx_trigger_off_think(var7);
        break;
      default:
        break;
    }
  }
}

function trigger_multiple_fx_trigger_on_think(var0) {
  for(;;) {
    self waittill("trigger");

    if(!var0.fx_on) {
      scripts\engine\utility::array_thread(var0.fx, &scripts\engine\sp\utility::restarteffect);
    }

    wait 1;
  }
}

function trigger_multiple_fx_trigger_off_think(var0) {
  for(;;) {
    self waittill("trigger");

    if(var0.fx_on) {
      scripts\engine\utility::array_thread(var0.fx, &scripts\engine\utility::pauseeffect);
    }

    wait 1;
  }
}

function assign_fx_to_trigger(var0, var1, var2) {
  if(isDefined(var0.v["soundalias"]) && var0.v["soundalias"] != "nil") {
    if(!isDefined(var0.v["stopable"]) || !var0.v["stopable"]) {
      return;
    }
  }

  var2.origin = var0.v["origin"];

  if(var2 istouching(var1)) {
    var1.fx[var1.fx.size] = var0;
    return;
  }
}

function trigger_multiple_compass(var0) {
  var1 = var0.script_parameters;

  if(!isDefined(level.minimap_image)) {
    level.minimap_image = "";
  }

  for(;;) {
    var0 waittill("trigger");

    if(level.minimap_image != var1) {
      scripts\sp\compass::setupminimap(var1);
    }
  }
}

function trigger_no_crouch_or_prone(var0) {
  scripts\engine\utility::array_thread(level.players, &no_crouch_or_prone_think_for_player, var0);
}

function no_crouch_or_prone_think_for_player(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(!isDefined(var1)) {
      continue;
    }

    if(var1 != self) {
      continue;
    }

    while(var1 istouching(var0)) {
      var1 allowprone(0);
      var1 allowcrouch(0);
      wait 0.05;
    }

    var1 allowprone(1);
    var1 allowcrouch(1);
  }
}

function trigger_no_prone(var0) {
  scripts\engine\utility::array_thread(level.players, &no_prone_for_player, var0);
}

function no_prone_for_player(var0) {
  for(;;) {
    var0 waittill("trigger", var1);

    if(!isDefined(var1)) {
      continue;
    }

    if(var1 != self) {
      continue;
    }

    while(var1 istouching(var0)) {
      var1 allowprone(0);
      wait 0.05;
    }

    var1 allowprone(1);
  }
}

function exploder_load(var0) {
  level endon("killexplodertridgers" + var0.script_exploder);
  var0 waittill("trigger");

  if(isDefined(var0.script_chance) && randomfloat(1) > var0.script_chance) {
    if(!var0 scripts\engine\utility::script_delay()) {
      wait 4;
    }

    thread exploder_load(level);
    return;
  }

  if(!var0 scripts\engine\utility::script_delay() && isDefined(var0.script_exploder_delay)) {
    wait var0.script_exploder_delay;
  }

  scripts\engine\utility::exploder(var0.script_exploder);
  level notify("killexplodertridgers" + var0.script_exploder);
}

function trigger_multiple_kleenex(var0) {
  if(getdvarint("kleenex") != 1) {
    return;
  }

  var0 waittill("trigger");
  scripts\engine\sp\utility::kleenex_popup();
}

function trigger_stealth_shadow(var0) {
  var0 endon("death");
  var1 = "stealth_in_shadow";

  if(!isDefined(level.trigger_stealth_shadow)) {
    level.trigger_stealth_shadow = [];
  }

  level.trigger_stealth_shadow[level.trigger_stealth_shadow.size] = var0;

  for(;;) {
    var0 waittill("trigger", var2);

    if(!var2 scripts\engine\utility::ent_flag_exist(var1)) {
      continue;
    }

    if(var2 scripts\engine\utility::ent_flag(var1)) {
      continue;
    }

    thread in_shadow_thread(var2, var0);
  }
}

function in_shadow_thread(var0, var1) {
  self endon("death");
  scripts\engine\utility::ent_flag_set(var1);

  while(isDefined(var0) && self istouching(var0)) {
    wait 0.05;
  }

  scripts\engine\utility::ent_flag_clear(var1);
}

function trigger_fire(var0) {
  var0 endon("death");

  if(isDefined(var0.trigger_fire_endon)) {
    var0 endon(var0.trigger_fire_endon);
  }

  var1 = 1;
  var2 = 5;
  var3 = 0;

  if(!isDefined(var0.script_delay_min) && !isDefined(var0.script_delay_max)) {
    var0.script_delay_min = 0.05;
    var0.script_delay_max = 0.05;
  }

  if(var0.script_delay_min == var0.script_delay_max) {
    var0.script_delay = var0.script_delay_min;
  }

  jumpiffalse(isDefined(var0.script_damage)) LOC_00000090;
  var1 = var0.script_damage;

  for(;;) {
    var0 waittill("trigger", var4);
    var5 = var0.origin;

    if(isPlayer(var4)) {
      var3 = var1;

      if(var0.classname == "trigger_radius_fire") {
        if(isDefined(var0.script_radius)) {
          if(distance2dsquared(var4.origin, var0.origin) <= squared(var0.script_radius)) {
            if(isDefined(var0.script_multiplier) && isnumber(var0.script_multiplier)) {
              var2 = var0.script_multiplier;
            }

            var3 *= var2;
          }
        }
      } else if(isDefined(var0.target)) {
        var6 = scripts\engine\utility::getStruct(var0.target, "targetname");
        var5 = var6.origin;

        if(isDefined(var6.script_radius)) {
          if(distance2dsquared(var4.origin, var6.origin) <= squared(var6.script_radius)) {
            if(isDefined(var0.script_multiplier) && isnumber(var0.script_multiplier)) {
              var2 = var0.script_multiplier;
            }

            var3 *= var2;
          }
        }
      }
    }

    if(istrue(var4.damageshield)) {
      continue;
    }

    var4 scripts\sp\utility::do_damage(var3, var5, undefined, undefined, "MOD_FIRE");

    if(var3 < 6) {
      var4 playRumbleOnEntity("damage_light");
    } else {
      var4 playRumbleOnEntity("damage_heavy");
    }

    var0 scripts\engine\utility::script_delay();
  }
}

function trigger_multiple_fx(var0) {
  if(var0.classname == "trigger_multiple_fx_on") {
    var1 = &scripts\common\fx::struct_fx_inactive;
    var2 = &scripts\common\fx::play_struct_fx;
    goto LOC_00000030;
  }

  var1 = &scripts\common\fx::struct_fx_active;
  var2 = &scripts\common\fx::stop_struct_fx;

  for(;;) {
    var2 waittill("trigger");

    foreach(var4 in level.struct_fx) {
      if([[var1]](var4) && scripts\engine\utility::is_equal(var4.script_fxgroup, var2.script_fxgroup)) {
        [[var2]](var4);
      }
    }
  }
}

function trigger_outofbounds(var0) {
  var0.failtrigger = getEnt(var0.target, "targetname");
  var0 endon("death");
  var0 waittill("trigger");
  GscBinSkip4(0x6e, var0.failtrigger);
}

function outofbounds_failthread() {
  self endon("death");
  self endon("stop_failthread");
  self waittill("trigger");
  setomnvar("ui_out_of_bounds_countdown", 0);
  scripts\sp\player_death::set_custom_death_quote(29);
  scripts\sp\utility::missionfailedwrapper();
}