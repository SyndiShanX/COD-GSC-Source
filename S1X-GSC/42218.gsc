/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42218.gsc
**************************************/

init() {
  level.destructiblespawnedentslimit = 50;
  level.destructiblespawnedents = [];
  level.currentcaralarms = 0;
  level.commonstarttime = gettime();

  if(isDefined(level.currentgen) && level.currentgen) {
    level.destructiblespawnedentslimit = 25;
  }

  if(!isDefined(level.fast_destructible_explode)) {
    level.fast_destructible_explode = 0;
  }

  if(!isDefined(level.func)) {
    level.func = [];
  }

  var_0 = 1;

  if(var_0) {
    find_destructibles();
  }

  var_1 = getEntArray("delete_on_load", "targetname");

  foreach(var_3 in var_1) {
    var_3 delete();
  }

  init_destroyed_count();
  init_destructible_frame_queue();
}

debgugprintdestructiblelist() {}

find_destructibles() {
  if(!isDefined(level.destructible_functions)) {
    level.destructible_functions = [];
  }

  var_0 = [];

  foreach(var_2 in level.struct) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "destructible_dot") {
      var_0[var_0.size] = var_2;
    }
  }

  var_4 = getEntArray("destructible_vehicle", "targetname");

  foreach(var_6 in var_4) {
    var_6 thread setup_destructibles_thread(var_0);
  }

  var_8 = getEntArray("destructible_toy", "targetname");

  foreach(var_10 in var_8) {
    var_10 thread setup_destructibles_thread(var_0);
  }

  debgugprintdestructiblelist();
}

setup_destructibles_thread(var_0) {
  setup_destructibles();
  setup_destructible_dots(var_0);
}

setup_destructible_dots(var_0) {
  var_1 = self.destructibleinfo;

  foreach(var_3 in var_0) {
    if(isDefined(level.destructible_type[var_1].destructible_dots)) {
      return;
    }
    if(isDefined(var_3.script_parameters) && issubstr(var_3.script_parameters, "destructible_type") && issubstr(var_3.script_parameters, self.destructible_type)) {
      if(distancesquared(self.origin, var_3.origin) < 1) {
        var_4 = getEntArray(var_3.target, "targetname");
        level.destructible_type[var_1].destructible_dots = [];

        foreach(var_6 in var_4) {
          var_7 = var_6.script_index;

          if(!isDefined(level.destructible_type[var_1].destructible_dots[var_7])) {
            level.destructible_type[var_1].destructible_dots[var_7] = [];
          }

          var_8 = level.destructible_type[var_1].destructible_dots[var_7].size;
          level.destructible_type[var_1].destructible_dots[var_7][var_8]["classname"] = var_6.classname;
          level.destructible_type[var_1].destructible_dots[var_7][var_8]["origin"] = var_6.origin;
          var_9 = common_scripts\utility::ter_op(isDefined(var_6.spawnflags), var_6.spawnflags, 0);
          level.destructible_type[var_1].destructible_dots[var_7][var_8]["spawnflags"] = var_9;

          switch (var_6.classname) {
            case "trigger_radius":
              level.destructible_type[var_1].destructible_dots[var_7][var_8]["radius"] = var_6.height;
              level.destructible_type[var_1].destructible_dots[var_7][var_8]["height"] = var_6.height;
              break;
            default:
          }

          var_6 delete();
        }

        break;
      }
    }
  }
}

destructible_getinfoindex(var_0) {
  if(!isDefined(level.destructible_type)) {
    return -1;
  }

  if(level.destructible_type.size == 0) {
    return -1;
  }

  for(var_1 = 0; var_1 < level.destructible_type.size; var_1++) {
    if(var_0 == level.destructible_type[var_1].v["type"]) {
      return var_1;
    }
  }

  return -1;
}

dest_cover(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = "test/concrete_cover_dest_test";
  }

  if(!isDefined(var_3)) {
    var_3 = 150;
  }

  destructible_create(var_0, "tag_origin", 1, undefined, 32, "no_melee");

  if(isDefined(var_4)) {
    destructible_state(undefined, var_4, undefined, undefined, 32, "no_melee");
  }

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = "fx_joint_" + var_6;
    destructible_part(var_7, undefined, var_3, undefined, undefined, "no_melee", 1);
    destructible_fx(var_7, var_2);

    if(isDefined(var_5)) {
      destructible_sound(var_5);
    }

    destructible_state(undefined);
  }
}

destructible_gettype(var_0) {
  var_1 = destructible_getinfoindex(var_0);

  if(var_1 >= 0) {
    return var_1;
  }

  if(issubstr(var_0, "dest_cover")) {
    dest_cover(self.destructible_type, self.script_dest_cover_numchunks, self.script_dest_cover_chunkfx, self.script_dest_cover_chunkhealth, self.script_dest_cover_dmg_model, self.script_dest_cover_chunksnd);
    var_1 = destructible_getinfoindex(var_0);
    return var_1;
  }

  if(!isDefined(level.destructible_functions[var_0])) {
    return -1;
  }

  [[level.destructible_functions[var_0]]]();
  var_1 = destructible_getinfoindex(var_0);
  return var_1;
}

setup_destructibles() {
  var_0 = undefined;
  self.modeldummyon = 0;
  add_damage_owner_recorder();
  self.destructibleinfo = destructible_gettype(self.destructible_type);

  if(self.destructibleinfo < 0) {
    return;
  }
  precache_destructibles();
  add_destructible_fx();

  if(isDefined(level.destructible_transient) && isDefined(level.destructible_transient[self.destructible_type])) {
    common_scripts\utility::flag_wait(level.destructible_transient[self.destructible_type] + "_loaded");
  }

  if(isDefined(level.destructible_type[self.destructibleinfo].attachedmodels)) {
    foreach(var_3 in level.destructible_type[self.destructibleinfo].attachedmodels) {
      if(isDefined(var_3.tag)) {
        self attach(var_3.model, var_3.tag);
      } else {
        self attach(var_3.model);
      }

      if(self.modeldummyon) {
        if(isDefined(var_3.tag)) {
          self.modeldummy attach(var_3.model, var_3.tag);
          continue;
        }

        self.modeldummy attach(var_3.model);
      }
    }
  }

  if(isDefined(level.destructible_type[self.destructibleinfo].parts)) {
    self.destructible_parts = [];

    for(var_5 = 0; var_5 < level.destructible_type[self.destructibleinfo].parts.size; var_5++) {
      self.destructible_parts[var_5] = spawnStruct();
      self.destructible_parts[var_5].v["currentState"] = 0;

      if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_5][0].v["health"])) {
        self.destructible_parts[var_5].v["health"] = level.destructible_type[self.destructibleinfo].parts[var_5][0].v["health"];
      }

      if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_5][0].v["random_dynamic_attachment_1"])) {
        var_6 = randomint(level.destructible_type[self.destructibleinfo].parts[var_5][0].v["random_dynamic_attachment_1"].size);
        var_7 = level.destructible_type[self.destructibleinfo].parts[var_5][0].v["random_dynamic_attachment_tag"][var_6];
        var_8 = level.destructible_type[self.destructibleinfo].parts[var_5][0].v["random_dynamic_attachment_1"][var_6];
        var_9 = level.destructible_type[self.destructibleinfo].parts[var_5][0].v["random_dynamic_attachment_2"][var_6];
        var_10 = level.destructible_type[self.destructibleinfo].parts[var_5][0].v["clipToRemove"][var_6];
        thread do_random_dynamic_attachment(var_7, var_8, var_9, var_10);
      }

      if(var_5 == 0) {
        continue;
      }
      var_11 = level.destructible_type[self.destructibleinfo].parts[var_5][0].v["modelName"];
      var_12 = level.destructible_type[self.destructibleinfo].parts[var_5][0].v["tagName"];

      for(var_13 = 1; isDefined(level.destructible_type[self.destructibleinfo].parts[var_5][var_13]); var_13++) {
        var_14 = level.destructible_type[self.destructibleinfo].parts[var_5][var_13].v["tagName"];
        var_15 = level.destructible_type[self.destructibleinfo].parts[var_5][var_13].v["modelName"];

        if(isDefined(var_14) && var_14 != var_12) {
          hideapart(var_14);

          if(self.modeldummyon) {
            self.modeldummy hideapart(var_14);
          }
        }
      }
    }
  }

  if(isDefined(self.target)) {
    thread destructible_handles_collision_brushes();
  }

  if(self.code_classname != "script_vehicle") {
    self setCanDamage(1);
  }

  if(common_scripts\utility::issp()) {
    thread connecttraverses();
  }

  thread destructible_think();

  if(issubstr(self.destructible_type, "dest_cover")) {
    thread destructiblecoverwatcher();
  }

  thread destructible_fx_spawnimmediate();
}

destructible_create(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.destructible_type)) {
    level.destructible_type = [];
  }

  var_6 = level.destructible_type.size;
  level.destructible_type[var_6] = spawnStruct();
  level.destructible_type[var_6].v["type"] = var_0;
  level.destructible_type[var_6].parts = [];
  level.destructible_type[var_6].parts[0][0] = spawnStruct();
  level.destructible_type[var_6].parts[0][0].v["modelName"] = self.model;
  level.destructible_type[var_6].parts[0][0].v["tagName"] = var_1;
  level.destructible_type[var_6].parts[0][0].v["health"] = var_2;
  level.destructible_type[var_6].parts[0][0].v["validAttackers"] = var_3;
  level.destructible_type[var_6].parts[0][0].v["validDamageZone"] = var_4;
  level.destructible_type[var_6].parts[0][0].v["validDamageCause"] = var_5;
  level.destructible_type[var_6].parts[0][0].v["godModeAllowed"] = 1;
  level.destructible_type[var_6].parts[0][0].v["rotateTo"] = self.angles;
  level.destructible_type[var_6].parts[0][0].v["vehicle_exclude_anim"] = 0;
}

destructible_part(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level.destructible_type.size - 1;
  var_11 = level.destructible_type[var_10].parts.size;
  var_12 = 0;
  destructible_info(var_11, var_12, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, undefined, var_9);
}

destructible_state(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = level.destructible_type.size - 1;
  var_9 = level.destructible_type[var_8].parts.size - 1;
  var_10 = level.destructible_type[var_8].parts[var_9].size;

  if(!isDefined(var_0) && var_9 == 0) {
    var_0 = level.destructible_type[var_8].parts[var_9][0].v["tagName"];
  }

  destructible_info(var_9, var_10, var_0, var_1, var_2, var_3, var_4, var_5, undefined, undefined, var_6, var_7);
}

destructible_fx_spawn_immediate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  destructible_fx(var_0, var_1, var_2, var_3, var_4, var_5, 1, var_6);
}

destructible_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
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

  var_8 = level.destructible_type.size - 1;
  var_9 = level.destructible_type[var_8].parts.size - 1;
  var_10 = level.destructible_type[var_8].parts[var_9].size - 1;
  var_11 = 0;

  if(isDefined(level.destructible_type[var_8].parts[var_9][var_10].v["fx_filename"])) {
    if(isDefined(level.destructible_type[var_8].parts[var_9][var_10].v["fx_filename"][var_4])) {
      var_11 = level.destructible_type[var_8].parts[var_9][var_10].v["fx_filename"][var_4].size;
    }
  }

  if(isDefined(var_3)) {
    level.destructible_type[var_8].parts[var_9][var_10].v["fx_valid_damagetype"][var_4][var_11] = var_3;
  }

  level.destructible_type[var_8].parts[var_9][var_10].v["fx_filename"][var_4][var_11] = var_1;
  level.destructible_type[var_8].parts[var_9][var_10].v["fx_tag"][var_4][var_11] = var_0;
  level.destructible_type[var_8].parts[var_9][var_10].v["fx_useTagAngles"][var_4][var_11] = var_2;
  level.destructible_type[var_8].parts[var_9][var_10].v["fx_cost"][var_4][var_11] = var_5;
  level.destructible_type[var_8].parts[var_9][var_10].v["spawn_immediate"][var_4][var_11] = var_6;
  level.destructible_type[var_8].parts[var_9][var_10].v["state_change_kill"][var_4][var_11] = var_7;
}

destructible_createdot_predefined(var_0) {
  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;

  if(!isDefined(level.destructible_type[var_1].parts[var_2][var_3].v["dot"])) {
    level.destructible_type[var_1].parts[var_2][var_3].v["dot"] = [];
  }

  var_4 = level.destructible_type[var_1].parts[var_2][var_3].v["dot"].size;
  var_5 = createdot();
  var_5.type = "predefined";
  var_5.index = var_0;
  level.destructible_type[var_1].parts[var_2][var_3].v["dot"][var_4] = var_5;
}

destructible_createdot_radius(var_0, var_1, var_2, var_3) {
  var_4 = level.destructible_type.size - 1;
  var_5 = level.destructible_type[var_4].parts.size - 1;
  var_6 = level.destructible_type[var_4].parts[var_5].size - 1;

  if(!isDefined(level.destructible_type[var_4].parts[var_5][var_6].v["dot"])) {
    level.destructible_type[var_4].parts[var_5][var_6].v["dot"] = [];
  }

  var_7 = level.destructible_type[var_4].parts[var_5][var_6].v["dot"].size;
  var_8 = createdot_radius((0, 0, 0), var_1, var_2, var_3);
  var_8.tag = var_0;
  level.destructible_type[var_4].parts[var_5][var_6].v["dot"][var_7] = var_8;
}

destructible_setdot_ontick(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = level.destructible_type.size - 1;
  var_9 = level.destructible_type[var_8].parts.size - 1;
  var_10 = level.destructible_type[var_8].parts[var_9].size - 1;
  var_11 = level.destructible_type[var_8].parts[var_9][var_10].v["dot"].size - 1;
  var_12 = level.destructible_type[var_8].parts[var_9][var_10].v["dot"][var_11];
  var_12 setdot_ontick(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  initdot(var_6);
}

destructible_setdot_ontickfunc(var_0, var_1, var_2) {
  var_3 = level.destructible_type.size - 1;
  var_4 = level.destructible_type[var_3].parts.size - 1;
  var_5 = level.destructible_type[var_3].parts[var_4].size - 1;
  var_6 = level.destructible_type[var_3].parts[var_4][var_5].v["dot"].size - 1;
  var_7 = level.destructible_type[var_3].parts[var_4][var_5].v["dot"][var_6];
  var_8 = var_7.ticks.size;
  var_7.ticks[var_8].onenterfunc = var_0;
  var_7.ticks[var_8].onexitfunc = var_1;
  var_7.ticks[var_8].ondeathfunc = var_2;
}

destructible_builddot_ontick(var_0, var_1) {
  var_2 = level.destructible_type.size - 1;
  var_3 = level.destructible_type[var_2].parts.size - 1;
  var_4 = level.destructible_type[var_2].parts[var_3].size - 1;
  var_5 = level.destructible_type[var_2].parts[var_3][var_4].v["dot"].size - 1;
  var_6 = level.destructible_type[var_2].parts[var_3][var_4].v["dot"][var_5];
  var_6 builddot_ontick(var_0, var_1);
}

destructible_builddot_startloop(var_0) {
  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
  var_4 = level.destructible_type[var_1].parts[var_2][var_3].v["dot"].size - 1;
  var_5 = level.destructible_type[var_1].parts[var_2][var_3].v["dot"][var_4];
  var_5 builddot_startloop(var_0);
}

destructible_builddot_damage(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.destructible_type.size - 1;
  var_7 = level.destructible_type[var_6].parts.size - 1;
  var_8 = level.destructible_type[var_6].parts[var_7].size - 1;
  var_9 = level.destructible_type[var_6].parts[var_7][var_8].v["dot"].size - 1;
  var_10 = level.destructible_type[var_6].parts[var_7][var_8].v["dot"][var_9];
  var_10 builddot_damage(var_0, var_1, var_2, var_3, var_4, var_5);
}

destructible_builddot_wait(var_0) {
  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
  var_4 = level.destructible_type[var_1].parts[var_2][var_3].v["dot"].size - 1;
  var_5 = level.destructible_type[var_1].parts[var_2][var_3].v["dot"][var_4];
  var_5 builddot_wait(var_0);
}

destructible_loopfx(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = level.destructible_type.size - 1;
  var_5 = level.destructible_type[var_4].parts.size - 1;
  var_6 = level.destructible_type[var_4].parts[var_5].size - 1;
  var_7 = 0;

  if(isDefined(level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_filename"])) {
    var_7 = level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_filename"].size;
  }

  level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_filename"][var_7] = var_1;
  level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_tag"][var_7] = var_0;
  level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_rate"][var_7] = var_2;
  level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_cost"][var_7] = var_3;
}

destructible_healthdrain(var_0, var_1, var_2, var_3) {
  var_4 = level.destructible_type.size - 1;
  var_5 = level.destructible_type[var_4].parts.size - 1;
  var_6 = level.destructible_type[var_4].parts[var_5].size - 1;
  level.destructible_type[var_4].parts[var_5][var_6].v["healthdrain_amount"] = var_0;
  level.destructible_type[var_4].parts[var_5][var_6].v["healthdrain_interval"] = var_1;
  level.destructible_type[var_4].parts[var_5][var_6].v["badplace_radius"] = var_2;
  level.destructible_type[var_4].parts[var_5][var_6].v["badplace_team"] = var_3;
}

destructible_sound(var_0, var_1, var_2) {
  var_3 = level.destructible_type.size - 1;
  var_4 = level.destructible_type[var_3].parts.size - 1;
  var_5 = level.destructible_type[var_3].parts[var_4].size - 1;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(level.destructible_type[var_3].parts[var_4][var_5].v["sound"])) {
    level.destructible_type[var_3].parts[var_4][var_5].v["sound"] = [];
    level.destructible_type[var_3].parts[var_4][var_5].v["soundCause"] = [];
  }

  if(!isDefined(level.destructible_type[var_3].parts[var_4][var_5].v["sound"][var_2])) {
    level.destructible_type[var_3].parts[var_4][var_5].v["sound"][var_2] = [];
    level.destructible_type[var_3].parts[var_4][var_5].v["soundCause"][var_2] = [];
  }

  var_6 = level.destructible_type[var_3].parts[var_4][var_5].v["sound"][var_2].size;
  level.destructible_type[var_3].parts[var_4][var_5].v["sound"][var_2][var_6] = var_0;
  level.destructible_type[var_3].parts[var_4][var_5].v["soundCause"][var_2][var_6] = var_1;
}

destructible_loopsound(var_0, var_1) {
  var_2 = level.destructible_type.size - 1;
  var_3 = level.destructible_type[var_2].parts.size - 1;
  var_4 = level.destructible_type[var_2].parts[var_3].size - 1;

  if(!isDefined(level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"])) {
    level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"] = [];
    level.destructible_type[var_2].parts[var_3][var_4].v["loopsoundCause"] = [];
  }

  var_5 = level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"].size;
  level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"][var_5] = var_0;
  level.destructible_type[var_2].parts[var_3][var_4].v["loopsoundCause"][var_5] = var_1;
}

destructible_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_9 = [];
  var_9["anim"] = var_0;
  var_9["animTree"] = var_1;
  var_9["animType"] = var_2;
  var_9["vehicle_exclude_anim"] = var_3;
  var_9["groupNum"] = var_4;
  var_9["mpAnim"] = var_5;
  var_9["maxStartDelay"] = var_6;
  var_9["animRateMin"] = var_7;
  var_9["animRateMax"] = var_8;
  add_array_to_destructible("animation", var_9);
}

destructible_spotlight(var_0) {
  var_1 = [];
  var_1["spotlight_tag"] = var_0;
  var_1["spotlight_fx"] = "spotlight_fx";
  var_1["spotlight_brightness"] = 0.85;
  var_1["randomly_flip"] = 1;
  add_keypairs_to_destructible(var_1);
}

add_key_to_destructible(var_0, var_1) {
  var_2 = [];
  var_2[var_0] = var_1;
  add_keypairs_to_destructible(var_2);
}

add_keypairs_to_destructible(var_0) {
  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;

  foreach(var_6, var_5 in var_0) {
    level.destructible_type[var_1].parts[var_2][var_3].v[var_6] = var_5;
  }
}

add_array_to_destructible(var_0, var_1) {
  var_2 = level.destructible_type.size - 1;
  var_3 = level.destructible_type[var_2].parts.size - 1;
  var_4 = level.destructible_type[var_2].parts[var_3].size - 1;
  var_5 = level.destructible_type[var_2].parts[var_3][var_4].v;

  if(!isDefined(var_5[var_0])) {
    var_5[var_0] = [];
  }

  var_5[var_0][var_5[var_0].size] = var_1;
  level.destructible_type[var_2].parts[var_3][var_4].v = var_5;
}

destructible_car_alarm() {
  var_0 = level.destructible_type.size - 1;
  var_1 = level.destructible_type[var_0].parts.size - 1;
  var_2 = level.destructible_type[var_0].parts[var_1].size - 1;
  level.destructible_type[var_0].parts[var_1][var_2].v["triggerCarAlarm"] = 1;
}

destructible_lights_out(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 256;
  }

  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
  level.destructible_type[var_1].parts[var_2][var_3].v["break_nearby_lights"] = var_0;
}

random_dynamic_attachment(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = "";
  }

  var_4 = level.destructible_type.size - 1;
  var_5 = level.destructible_type[var_4].parts.size - 1;
  var_6 = 0;

  if(!isDefined(level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_1"])) {
    level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_1"] = [];
    level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_2"] = [];
    level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_tag"] = [];
  }

  var_7 = level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_1"].size;
  level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_1"][var_7] = var_1;
  level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_2"][var_7] = var_2;
  level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_tag"][var_7] = var_0;
  level.destructible_type[var_4].parts[var_5][var_6].v["clipToRemove"][var_7] = var_3;
}

destructible_physics(var_0, var_1) {
  var_2 = level.destructible_type.size - 1;
  var_3 = level.destructible_type[var_2].parts.size - 1;
  var_4 = level.destructible_type[var_2].parts[var_3].size - 1;

  if(!isDefined(level.destructible_type[var_2].parts[var_3][var_4].v["physics"])) {
    level.destructible_type[var_2].parts[var_3][var_4].v["physics"] = [];
    level.destructible_type[var_2].parts[var_3][var_4].v["physics_tagName"] = [];
    level.destructible_type[var_2].parts[var_3][var_4].v["physics_velocity"] = [];
  }

  var_5 = level.destructible_type[var_2].parts[var_3][var_4].v["physics"].size;
  level.destructible_type[var_2].parts[var_3][var_4].v["physics"][var_5] = 1;
  level.destructible_type[var_2].parts[var_3][var_4].v["physics_tagName"][var_5] = var_0;
  level.destructible_type[var_2].parts[var_3][var_4].v["physics_velocity"][var_5] = var_1;
}

destructible_splash_damage_scaler(var_0) {
  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
  level.destructible_type[var_1].parts[var_2][var_3].v["splash_damage_scaler"] = var_0;
}

destructible_explode(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = level.destructible_type.size - 1;
  var_15 = level.destructible_type[var_14].parts.size - 1;
  var_16 = level.destructible_type[var_14].parts[var_15].size - 1;

  if(common_scripts\utility::issp()) {
    level.destructible_type[var_14].parts[var_15][var_16].v["explode_range"] = var_2;
  } else {
    level.destructible_type[var_14].parts[var_15][var_16].v["explode_range"] = var_3;
  }

  level.destructible_type[var_14].parts[var_15][var_16].v["explode"] = 1;
  level.destructible_type[var_14].parts[var_15][var_16].v["explode_force_min"] = var_0;
  level.destructible_type[var_14].parts[var_15][var_16].v["explode_force_max"] = var_1;
  level.destructible_type[var_14].parts[var_15][var_16].v["explode_mindamage"] = var_4;
  level.destructible_type[var_14].parts[var_15][var_16].v["explode_maxdamage"] = var_5;
  level.destructible_type[var_14].parts[var_15][var_16].v["continueDamage"] = var_6;
  level.destructible_type[var_14].parts[var_15][var_16].v["originOffset"] = var_7;
  level.destructible_type[var_14].parts[var_15][var_16].v["earthQuakeScale"] = var_8;
  level.destructible_type[var_14].parts[var_15][var_16].v["earthQuakeRadius"] = var_9;
  level.destructible_type[var_14].parts[var_15][var_16].v["originOffset3d"] = var_10;
  level.destructible_type[var_14].parts[var_15][var_16].v["delaytime"] = var_11;
  level.destructible_type[var_14].parts[var_15][var_16].v["explode_angularImpulse_min"] = var_12;
  level.destructible_type[var_14].parts[var_15][var_16].v["explode_angularImpulse_max"] = var_13;
}

destructible_function(var_0) {
  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
  level.destructible_type[var_1].parts[var_2][var_3].v["function"] = var_0;
}

destructible_notify(var_0) {
  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
  level.destructible_type[var_1].parts[var_2][var_3].v["functionNotify"] = var_0;
}

destructible_damage_threshold(var_0) {
  var_1 = level.destructible_type.size - 1;
  var_2 = level.destructible_type[var_1].parts.size - 1;
  var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
  level.destructible_type[var_1].parts[var_2][var_3].v["damage_threshold"] = var_0;
}

destructible_attachmodel(var_0, var_1) {
  var_1 = tolower(var_1);
  var_2 = level.destructible_type.size - 1;

  if(!isDefined(level.destructible_type[var_2].attachedmodels)) {
    level.destructible_type[var_2].attachedmodels = [];
  }

  var_3 = spawnStruct();
  var_3.model = var_1;
  var_3.tag = var_0;
  level.destructible_type[var_2].attachedmodels[level.destructible_type[var_2].attachedmodels.size] = var_3;
}

destructible_info(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_3)) {
    var_3 = tolower(var_3);
  }

  var_13 = level.destructible_type.size - 1;
  level.destructible_type[var_13].parts[var_0][var_1] = spawnStruct();
  level.destructible_type[var_13].parts[var_0][var_1].v["modelName"] = var_3;
  level.destructible_type[var_13].parts[var_0][var_1].v["tagName"] = var_2;
  level.destructible_type[var_13].parts[var_0][var_1].v["health"] = var_4;
  level.destructible_type[var_13].parts[var_0][var_1].v["validAttackers"] = var_5;
  level.destructible_type[var_13].parts[var_0][var_1].v["validDamageZone"] = var_6;
  level.destructible_type[var_13].parts[var_0][var_1].v["validDamageCause"] = var_7;
  level.destructible_type[var_13].parts[var_0][var_1].v["alsoDamageParent"] = var_8;
  level.destructible_type[var_13].parts[var_0][var_1].v["physicsOnExplosion"] = var_9;
  level.destructible_type[var_13].parts[var_0][var_1].v["grenadeImpactDeath"] = var_10;
  level.destructible_type[var_13].parts[var_0][var_1].v["godModeAllowed"] = 0;
  level.destructible_type[var_13].parts[var_0][var_1].v["splashRotation"] = var_11;
  level.destructible_type[var_13].parts[var_0][var_1].v["receiveDamageFromParent"] = var_12;
}

precache_destructibles() {
  if(!isDefined(level.destructible_type[self.destructibleinfo].parts)) {
    return;
  }
  if(isDefined(level.destructible_type[self.destructibleinfo].attachedmodels)) {
    foreach(var_1 in level.destructible_type[self.destructibleinfo].attachedmodels) {
      precachemodel(var_1.model);
    }
  }

  for(var_3 = 0; var_3 < level.destructible_type[self.destructibleinfo].parts.size; var_3++) {
    for(var_4 = 0; var_4 < level.destructible_type[self.destructibleinfo].parts[var_3].size; var_4++) {
      if(level.destructible_type[self.destructibleinfo].parts[var_3].size <= var_4) {
        continue;
      }
      if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["modelName"])) {
        precachemodel(level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["modelName"]);
      }

      if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["animation"])) {
        var_5 = level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["animation"];

        foreach(var_7 in var_5) {
          if(isDefined(var_7["mpAnim"])) {
            common_scripts\utility::noself_func("precacheMpAnim", var_7["mpAnim"]);
          }
        }
      }

      if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["random_dynamic_attachment_1"])) {
        foreach(var_10 in level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["random_dynamic_attachment_1"]) {
          if(isDefined(var_10) && var_10 != "") {
            precachemodel(var_10);
            precachemodel(var_10 + "_destroy");
          }
        }

        foreach(var_10 in level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["random_dynamic_attachment_2"]) {
          if(isDefined(var_10) && var_10 != "") {
            precachemodel(var_10);
            precachemodel(var_10 + "_destroy");
          }
        }
      }
    }
  }
}

add_destructible_fx() {
  if(!isDefined(level.destructible_type[self.destructibleinfo].parts)) {
    return;
  }
  for(var_0 = 0; var_0 < level.destructible_type[self.destructibleinfo].parts.size; var_0++) {
    for(var_1 = 0; var_1 < level.destructible_type[self.destructibleinfo].parts[var_0].size; var_1++) {
      if(level.destructible_type[self.destructibleinfo].parts[var_0].size <= var_1) {
        continue;
      }
      var_2 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1];

      if(isDefined(var_2.v["fx_filename"])) {
        for(var_3 = 0; var_3 < var_2.v["fx_filename"].size; var_3++) {
          var_4 = var_2.v["fx_filename"][var_3];
          var_5 = var_2.v["fx_tag"][var_3];

          if(isDefined(var_4)) {
            if(isDefined(var_2.v["fx"]) && isDefined(var_2.v["fx"][var_3]) && var_2.v["fx"][var_3].size == var_4.size) {
              continue;
            }
            for(var_6 = 0; var_6 < var_4.size; var_6++) {
              var_7 = var_4[var_6];
              var_8 = var_5[var_6];
              level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["fx"][var_3][var_6] = loadfx(var_7, var_8);
            }
          }
        }
      }

      var_9 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["loopfx_filename"];
      var_10 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["loopfx_tag"];

      if(isDefined(var_9)) {
        if(isDefined(var_2.v["loopfx"]) && var_2.v["loopfx"].size == var_9.size) {
          continue;
        }
        for(var_6 = 0; var_6 < var_9.size; var_6++) {
          var_11 = var_9[var_6];
          var_12 = var_10[var_6];
          level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["loopfx"][var_6] = loadfx(var_11, var_12);
        }
      }
    }
  }
}

candamagedestructible(var_0) {
  foreach(var_2 in self.destructibles) {
    if(var_2 == var_0) {
      return 1;
    }
  }

  return 0;
}

destructible_think() {
  var_0 = 0;
  var_1 = self.model;
  var_2 = undefined;
  var_3 = self.origin;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = self.model;
  destructible_update_part(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  self endon("stop_taking_damage");

  for(;;) {
    var_0 = undefined;
    var_5 = undefined;
    var_4 = undefined;
    var_3 = undefined;
    var_8 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_9 = undefined;
    var_10 = undefined;
    self waittill("damage", var_0, var_5, var_4, var_3, var_8, var_1, var_2, var_9, var_10);

    if(!isDefined(var_0)) {
      continue;
    }
    if(isDefined(var_5) && isDefined(var_5.type) && var_5.type == "soft_landing" && !var_5 candamagedestructible(self)) {
      continue;
    }
    if(common_scripts\utility::issp()) {
      var_0 = var_0 * 0.5;
    } else {
      var_0 = var_0 * 1.0;
    }

    if(var_0 <= 0) {
      continue;
    }
    if(common_scripts\utility::issp()) {
      if(isDefined(var_5) && isPlayer(var_5)) {
        self.damageowner = var_5;
      }
    } else if(isDefined(var_5) && isPlayer(var_5)) {
      self.damageowner = var_5;
    } else if(isDefined(var_5) && isDefined(var_5.gunner) && isPlayer(var_5.gunner)) {
      self.damageowner = var_5.gunner;
    }

    var_8 = getdamagetype(var_8);

    if(is_shotgun_damage(var_5, var_8)) {
      if(common_scripts\utility::issp()) {
        var_0 = var_0 * 8.0;
      } else {
        var_0 = var_0 * 4.0;
      }
    }

    if(!isDefined(var_1) || var_1 == "") {
      var_1 = self.model;
    }

    if(isDefined(var_2) && var_2 == "") {
      if(isDefined(var_9) && var_9 != "" && var_9 != "tag_body" && var_9 != "body_animate_jnt") {
        var_2 = var_9;
      } else {
        var_2 = undefined;
      }

      var_11 = level.destructible_type[self.destructibleinfo].parts[0][0].v["tagName"];

      if(isDefined(var_11) && isDefined(var_9) && var_11 == var_9) {
        var_2 = undefined;
      }
    }

    if(var_8 == "splash" || var_8 == "energy") {
      if(isDefined(level.destructible_type[self.destructibleinfo].parts[0][0].v["splash_damage_scaler"])) {
        var_0 = var_0 * level.destructible_type[self.destructibleinfo].parts[0][0].v["splash_damage_scaler"];
      } else if(common_scripts\utility::issp()) {
        var_0 = var_0 * 9.0;
      } else {
        var_0 = var_0 * 13.0;
      }

      if(var_7 == self.model && isDefined(self.script_dest_cover_dmg_model)) {
        self setModel(self.script_dest_cover_dmg_model);
      }

      destructible_splash_damage(int(var_0), var_3, var_4, var_5, var_8);
      continue;
    }

    thread destructible_update_part(int(var_0), var_1, var_2, var_3, var_4, var_5, var_8);
  }
}

is_shotgun_damage(var_0, var_1) {
  if(var_1 != "bullet") {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = undefined;

  if(isPlayer(var_0)) {
    var_2 = var_0 getcurrentweapon();
  } else if(isDefined(level.enable_ai_shotgun_destructible_damage) && level.enable_ai_shotgun_destructible_damage) {
    if(isDefined(var_0.weapon)) {
      var_2 = var_0.weapon;
    }
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  var_3 = weaponclass(var_2);

  if(isDefined(var_3) && var_3 == "spread") {
    return 1;
  }

  return 0;
}

getpartandstateindex(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.v = [];
  var_3 = -1;
  var_4 = -1;

  if(tolower(var_0) == tolower(self.model) && !isDefined(var_1)) {
    var_0 = self.model;
    var_1 = undefined;
    var_3 = 0;
    var_4 = 0;
  }

  for(var_5 = 0; var_5 < level.destructible_type[self.destructibleinfo].parts.size; var_5++) {
    var_4 = self.destructible_parts[var_5].v["currentState"];

    if(level.destructible_type[self.destructibleinfo].parts[var_5].size <= var_4) {
      continue;
    }
    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_5][var_4].v["tagName"])) {
      var_6 = level.destructible_type[self.destructibleinfo].parts[var_5][var_4].v["tagName"];

      if(tolower(var_6) == tolower(var_1)) {
        var_3 = var_5;
        break;
      }
    }
  }

  var_2.v["stateIndex"] = var_4;
  var_2.v["partIndex"] = var_3;
  return var_2;
}

destructible_update_part(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(self.destructible_parts)) {
    return;
  }
  if(self.destructible_parts.size == 0) {
    return;
  }
  if(level.fast_destructible_explode) {
    self endon("destroyed");
  }

  var_8 = getpartandstateindex(var_1, var_2);
  var_9 = var_8.v["stateIndex"];
  var_10 = var_8.v["partIndex"];

  if(var_10 < 0) {
    return;
  }
  var_11 = var_9;
  var_12 = 0;
  var_13 = 0;

  for(;;) {
    var_9 = self.destructible_parts[var_10].v["currentState"];

    if(!isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_9])) {
      break;
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][0].v["alsoDamageParent"])) {
      if(getdamagetype(var_6) != "splash") {
        var_14 = level.destructible_type[self.destructibleinfo].parts[var_10][0].v["alsoDamageParent"];
        var_15 = int(var_0 * var_14);
        thread notifydamageafterframe(var_15, var_5, var_4, var_3, var_6, "", "");
      }
    }

    if(var_10 == 0 && getdamagetype(var_6) != "splash") {
      for(var_16 = 0; var_16 < level.destructible_type[self.destructibleinfo].parts.size; var_16++) {
        var_17 = level.destructible_type[self.destructibleinfo].parts[var_16];

        if(!isDefined(var_17[0].v["receiveDamageFromParent"])) {
          continue;
        }
        var_18 = 0;

        if(isDefined(self.destructible_parts[var_16].v["currentState"])) {
          var_18 = self.destructible_parts[var_16].v["currentState"];
        }

        if(!isDefined(var_17[var_18])) {
          continue;
        }
        if(!isDefined(var_17[var_18].v["tagName"])) {
          continue;
        }
        var_19 = var_17[var_18].v["tagName"];
        var_14 = var_17[0].v["receiveDamageFromParent"];
        var_20 = int(var_0 * var_14);
        thread notifydamageafterframe(var_20, var_5, var_4, var_3, var_6, "", var_19);
      }
    }

    if(!isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_9].v["health"])) {
      break;
    }

    if(!isDefined(self.destructible_parts[var_10].v["health"])) {
      break;
    }

    if(var_12) {
      self.destructible_parts[var_10].v["health"] = level.destructible_type[self.destructibleinfo].parts[var_10][var_9].v["health"];
    }

    var_12 = 0;

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_9].v["grenadeImpactDeath"]) && var_6 == "impact") {
      var_0 = 100000000;
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_9].v["damage_threshold"]) && level.destructible_type[self.destructibleinfo].parts[var_10][var_9].v["damage_threshold"] > var_0) {
      var_0 = 0;
    }

    var_21 = self.destructible_parts[var_10].v["health"];
    var_22 = isattackervalid(var_10, var_9, var_5);

    if(var_22) {
      var_23 = isvaliddamagecause(var_10, var_9, var_6);

      if(var_23) {
        if(isDefined(var_5)) {
          if(isPlayer(var_5)) {
            self.player_damage = self.player_damage + var_0;
          } else if(var_5 != self) {
            self.non_player_damage = self.non_player_damage + var_0;
          }
        }

        if(isDefined(var_6)) {
          if(var_6 == "melee" || var_6 == "impact") {
            var_0 = 100000;
          }
        }

        self.destructible_parts[var_10].v["health"] = self.destructible_parts[var_10].v["health"] - var_0;
      }
    }

    if(self.destructible_parts[var_10].v["health"] > 0) {
      return;
    }
    if(isDefined(var_7)) {
      var_7.v["fxcost"] = get_part_fx_cost_for_action_state(var_10, self.destructible_parts[var_10].v["currentState"]);
      add_destructible_to_frame_queue(self, var_7, var_0);

      if(!isDefined(self.waiting_for_queue)) {
        self.waiting_for_queue = 1;
      } else {
        self.waiting_for_queue++;
      }

      self waittill("queue_processed", var_24);
      self.waiting_for_queue--;

      if(self.waiting_for_queue == 0) {
        self.waiting_for_queue = undefined;
      }

      if(!var_24) {
        self.destructible_parts[var_10].v["health"] = var_21;
        return;
      }
    }

    var_0 = int(abs(self.destructible_parts[var_10].v["health"]));

    if(var_0 < 0) {
      return;
    }
    self.destructible_parts[var_10].v["currentState"]++;
    var_9 = self.destructible_parts[var_10].v["currentState"];
    var_25 = var_9 - 1;
    var_26 = undefined;

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25])) {
      var_26 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v;
    }

    var_27 = undefined;

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_9])) {
      var_27 = level.destructible_type[self.destructibleinfo].parts[var_10][var_9].v;
    }

    if(!isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25])) {
      return;
    }
    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode"])) {
      self.exploding = 1;
    }

    if(isDefined(self.loopingsoundstopnotifies) && isDefined(self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)])) {
      for(var_16 = 0; var_16 < self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)].size; var_16++) {
        self notify(self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)][var_16]);

        if(common_scripts\utility::issp() && self.modeldummyon) {
          self.modeldummy notify(self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)][var_16]);
        }
      }

      self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)] = undefined;
    }

    if(isDefined(var_26["break_nearby_lights"])) {
      destructible_get_my_breakable_light(var_26["break_nearby_lights"]);
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_9])) {
      if(var_10 == 0) {
        var_28 = var_27["modelName"];

        if(isDefined(var_28) && var_28 != self.model) {
          self setModel(var_28);

          if(common_scripts\utility::issp() && self.modeldummyon) {
            self.modeldummy setModel(var_28);
          }

          destructible_splash_rotatation(var_27);
        }
      } else {
        hideapart(var_2);

        if(common_scripts\utility::issp() && self.modeldummyon) {
          self.modeldummy hideapart(var_2);
        }

        var_2 = var_27["tagName"];

        if(isDefined(var_2)) {
          showapart(var_2);

          if(common_scripts\utility::issp() && self.modeldummyon) {
            self.modeldummy showapart(var_2);
          }
        }
      }
    }

    var_29 = get_dummy();

    if(isDefined(self.exploding)) {
      clear_anims(var_29);
    }

    var_30 = destructible_animation_think(var_26, var_29, var_6, var_10);
    var_30 = destructible_fx_think(var_26, var_29, var_6, var_10, var_30);
    self notify("FX_State_Change_Kill" + var_10);
    var_30 = destructible_sound_think(var_26, var_29, var_6, var_30);

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["loopfx"])) {
      var_31 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["loopfx_filename"].size;

      if(var_31 > 0) {
        self notify("FX_State_Change" + var_10);
      }

      for(var_32 = 0; var_32 < var_31; var_32++) {
        var_33 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["loopfx"][var_32];
        var_34 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["loopfx_tag"][var_32];
        var_35 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["loopfx_rate"][var_32];
        thread loopfx_ontag(var_33, var_34, var_35, var_10);
      }
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["loopsound"])) {
      for(var_16 = 0; var_16 < level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["loopsound"].size; var_16++) {
        var_36 = isvalidsoundcause("loopsoundCause", var_26, var_16, var_6);

        if(var_36) {
          var_37 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["loopsound"][var_16];
          var_38 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["tagName"];
          thread play_loop_sound_on_destructible(var_37, var_38);

          if(!isDefined(self.loopingsoundstopnotifies)) {
            self.loopingsoundstopnotifies = [];
          }

          if(!isDefined(self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)])) {
            self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)] = [];
          }

          var_39 = self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)].size;
          self.loopingsoundstopnotifies[common_scripts\utility::tostring(var_10)][var_39] = "stop sound" + var_37;
        }
      }
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["triggerCarAlarm"])) {
      thread do_car_alarm();
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["break_nearby_lights"])) {
      thread break_nearest_light();
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["healthdrain_amount"])) {
      self notify("Health_Drain_State_Change" + var_10);
      var_40 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["healthdrain_amount"];
      var_41 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["healthdrain_interval"];
      var_42 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["modelName"];
      var_43 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["tagName"];
      var_44 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["badplace_radius"];
      var_45 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["badplace_team"];

      if(var_40 > 0) {
        thread health_drain(var_40, var_41, var_10, var_42, var_43, var_44, var_45);
      }
    }

    var_46 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["dot"];

    if(isDefined(var_46)) {
      foreach(var_48 in var_46) {
        var_49 = var_48.index;

        if(var_48.type == "predefined" && isDefined(var_49)) {
          var_50 = [];

          foreach(var_52 in level.destructible_type[self.destructibleinfo].destructible_dots[var_49]) {
            var_53 = var_52["classname"];
            var_54 = undefined;

            switch (var_53) {
              case "trigger_radius":
                var_55 = var_52["origin"];
                var_56 = var_52["spawnflags"];
                var_57 = var_52["radius"];
                var_58 = var_52["height"];
                var_54 = createdot_radius(self.origin + var_55, var_56, var_57, var_58);
                var_54.ticks = var_48.ticks;
                var_50[var_50.size] = var_54;
                break;
              default:
            }
          }

          level thread startdot_group(var_50);
          continue;
        }

        if(isDefined(var_48)) {
          if(isDefined(var_48.tag)) {
            var_48 setdot_origin(self gettagorigin(var_48.tag));
          }

          level thread startdot_group([var_48]);
        }
      }

      var_46 = undefined;
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode"])) {
      var_13 = 1;
      var_61 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode_force_min"];
      var_62 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode_force_max"];
      var_63 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode_angularImpulse_min"];
      var_64 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode_angularImpulse_max"];
      var_65 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode_range"];
      var_66 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode_mindamage"];
      var_67 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["explode_maxdamage"];
      var_68 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["continueDamage"];
      var_69 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["originOffset"];
      var_70 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["earthQuakeScale"];
      var_71 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["earthQuakeRadius"];
      var_72 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["originOffset3d"];
      var_73 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["delaytime"];

      if(isDefined(var_5) && var_5 != self) {
        self.attacker = var_5;

        if(self.code_classname == "script_vehicle") {
          self.damage_type = var_6;
        }
      }

      thread explode(var_10, var_61, var_62, var_65, var_66, var_67, var_68, var_69, var_70, var_71, var_5, var_72, var_73, var_63, var_64);
    }

    var_74 = undefined;

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["physics"])) {
      for(var_16 = 0; var_16 < level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["physics"].size; var_16++) {
        var_74 = undefined;
        var_75 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["physics_tagName"][var_16];
        var_76 = level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["physics_velocity"][var_16];
        var_77 = undefined;

        if(isDefined(var_76)) {
          var_78 = undefined;

          if(isDefined(var_75)) {
            var_78 = self gettagangles(var_75);
          } else if(isDefined(var_2)) {
            var_78 = self gettagangles(var_2);
          }

          var_74 = undefined;

          if(isDefined(var_75)) {
            var_74 = self gettagorigin(var_75);
          } else if(isDefined(var_2)) {
            var_74 = self gettagorigin(var_2);
          }

          var_79 = var_76[0] - 5 + randomfloat(10);
          var_80 = var_76[1] - 5 + randomfloat(10);
          var_81 = var_76[2] - 5 + randomfloat(10);
          var_82 = anglesToForward(var_78) * var_79 * randomfloatrange(80, 110);
          var_83 = anglestoright(var_78) * var_80 * randomfloatrange(80, 110);
          var_84 = anglestoup(var_78) * var_81 * randomfloatrange(80, 110);
          var_77 = var_82 + var_83 + var_84;
        } else {
          var_77 = var_3;
          var_85 = (0, 0, 0);

          if(isDefined(var_5)) {
            var_85 = var_5.origin;
            var_77 = vectornormalize(var_3 - var_85);
            var_77 = var_77 * 200;
          }
        }

        if(isDefined(var_75)) {
          var_86 = undefined;

          for(var_87 = 0; var_87 < level.destructible_type[self.destructibleinfo].parts.size; var_87++) {
            if(!isDefined(level.destructible_type[self.destructibleinfo].parts[var_87][0].v["tagName"])) {
              continue;
            }
            if(level.destructible_type[self.destructibleinfo].parts[var_87][0].v["tagName"] != var_75) {
              continue;
            }
            var_86 = var_87;
            break;
          }

          if(isDefined(var_74)) {
            thread physics_launch(var_86, 0, var_74, var_77);
          } else {
            thread physics_launch(var_86, 0, var_3, var_77);
          }

          continue;
        }

        if(isDefined(var_74)) {
          thread physics_launch(var_10, var_25, var_74, var_77);
        } else {
          thread physics_launch(var_10, var_25, var_3, var_77);
        }

        return;
      }
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v) && isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["functionNotify"])) {
      self notify(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["functionNotify"]);
    }

    if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["function"])) {
      self thread[[level.destructible_type[self.destructibleinfo].parts[var_10][var_25].v["function"]]]();
    }

    var_12 = 1;
  }
}

destructible_splash_rotatation(var_0) {
  var_1 = var_0["splashRotation"];
  var_2 = var_0["rotateTo"];

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!var_1) {
    return;
  }
  self.angles = (self.angles[0], var_2[1], self.angles[2]);
}

damage_not(var_0) {
  var_1 = strtok(var_0, " ");
  var_2 = strtok("splash melee bullet splash impact unknown", " ");
  var_3 = "";

  foreach(var_6, var_5 in var_1) {
    var_2 = common_scripts\utility::array_remove(var_2, var_5);
  }

  foreach(var_8 in var_2) {
    var_3 = var_3 + (var_8 + " ");
  }

  return var_3;
}

destructible_splash_damage(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 <= 0) {
    return;
  }
  if(isDefined(self.exploded)) {
    return;
  }
  if(!isDefined(level.destructible_type[self.destructibleinfo].parts)) {
    return;
  }
  var_5 = getallactiveparts(var_2);

  if(var_5.size <= 0) {
    return;
  }
  var_5 = setdistanceonparts(var_5, var_1);
  var_6 = getlowestpartdistance(var_5);

  foreach(var_8 in var_5) {
    var_9 = var_8.v["distance"] * 1.4;
    var_10 = var_0 - (var_9 - var_6);

    if(var_10 <= 0) {
      continue;
    }
    if(isDefined(self.exploded)) {
      continue;
    }
    thread destructible_update_part(var_10, var_8.v["modelName"], var_8.v["tagName"], var_1, var_2, var_3, var_4, var_8);
  }
}

getallactiveparts(var_0) {
  var_1 = [];

  if(!isDefined(level.destructible_type[self.destructibleinfo].parts)) {
    return var_1;
  }

  for(var_2 = 0; var_2 < level.destructible_type[self.destructibleinfo].parts.size; var_2++) {
    var_3 = var_2;
    var_4 = self.destructible_parts[var_3].v["currentState"];

    for(var_5 = 0; var_5 < level.destructible_type[self.destructibleinfo].parts[var_3].size; var_5++) {
      var_6 = level.destructible_type[self.destructibleinfo].parts[var_3][var_5].v["splashRotation"];

      if(isDefined(var_6) && var_6) {
        var_7 = vectortoangles(var_0);
        var_8 = var_7[1] - 90;
        level.destructible_type[self.destructibleinfo].parts[var_3][var_5].v["rotateTo"] = (0, var_8, 0);
      }
    }

    if(!isDefined(level.destructible_type[self.destructibleinfo].parts[var_3][var_4])) {
      continue;
    }
    var_9 = level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["tagName"];

    if(!isDefined(var_9)) {
      var_9 = "";
    }

    if(var_9 == "") {
      continue;
    }
    var_10 = level.destructible_type[self.destructibleinfo].parts[var_3][var_4].v["modelName"];

    if(!isDefined(var_10)) {
      var_10 = "";
    }

    var_11 = var_1.size;
    var_1[var_11] = spawnStruct();
    var_1[var_11].v["modelName"] = var_10;
    var_1[var_11].v["tagName"] = var_9;
  }

  return var_1;
}

setdistanceonparts(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = distance(var_1, self gettagorigin(var_0[var_2].v["tagName"]));
    var_0[var_2].v["distance"] = var_3;
  }

  return var_0;
}

getlowestpartdistance(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_4 = var_3.v["distance"];

    if(!isDefined(var_1)) {
      var_1 = var_4;
    }

    if(var_4 < var_1) {
      var_1 = var_4;
    }
  }

  return var_1;
}

isvalidsoundcause(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = var_1[var_0][var_4][var_2];
  } else {
    var_5 = var_1[var_0][var_2];
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  if(var_5 == var_3) {
    return 1;
  }

  return 0;
}

isattackervalid(var_0, var_1, var_2) {
  if(isDefined(self.forceexploding)) {
    return 1;
  }

  if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["explode"])) {
    if(isDefined(self.dontallowexplode)) {
      return 0;
    }
  }

  if(!isDefined(var_2)) {
    return 1;
  }

  if(var_2 == self) {
    return 1;
  }

  var_3 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["validAttackers"];

  if(!isDefined(var_3)) {
    return 1;
  }

  if(var_3 == "no_player") {
    if(!isPlayer(var_2)) {
      return 1;
    }

    if(!isDefined(var_2.damageisfromplayer)) {
      return 1;
    }

    if(var_2.damageisfromplayer == 0) {
      return 1;
    }
  } else if(var_3 == "player_only") {
    if(isPlayer(var_2)) {
      return 1;
    }

    if(isDefined(var_2.damageisfromplayer) && var_2.damageisfromplayer) {
      return 1;
    }
  } else if(var_3 == "no_ai" && isDefined(level.isaifunc)) {
    if(![[level.isaifunc]](var_2)) {
      return 1;
    }
  } else if(var_3 == "ai_only" && isDefined(level.isaifunc)) {
    if([[level.isaifunc]](var_2)) {
      return 1;
    }
  } else {}

  return 0;
}

isvaliddamagecause(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return 1;
  }

  var_3 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["godModeAllowed"];

  if(var_3 && (isDefined(self.godmode) && self.godmode || isDefined(self.script_bulletshield) && self.script_bulletshield && var_2 == "bullet")) {
    return 0;
  }

  var_4 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["validDamageCause"];

  if(!isDefined(var_4)) {
    return 1;
  }

  if(var_4 == "splash" && var_2 != "splash") {
    return 0;
  }

  if(var_4 == "no_splash" && var_2 == "splash") {
    return 0;
  }

  if(var_4 == "no_melee" && var_2 == "melee" || var_2 == "impact") {
    return 0;
  }

  if(var_4 == "bullet" && var_2 != "bullet") {
    return 0;
  }

  return 1;
}

getdamagetype(var_0) {
  if(!isDefined(var_0)) {
    return "unknown";
  }

  var_0 = tolower(var_0);

  switch (var_0) {
    case "mod_crush":
    case "mod_melee_alt":
    case "mod_melee":
    case "melee":
      return "melee";
    case "mod_rifle_bullet":
    case "mod_pistol_bullet":
    case "bullet":
      return "bullet";
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
    case "splash":
      return "splash";
    case "mod_impact":
      return "impact";
    case "mod_energy":
      return "energy";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}

damage_mirror(var_0, var_1, var_2) {
  self notify("stop_damage_mirror");
  self endon("stop_damage_mirror");
  var_0 endon("stop_taking_damage");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7);
    var_0 notify("damage", var_3, var_4, var_5, var_6, var_7, var_1, var_2);
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
  }
}

add_damage_owner_recorder() {
  self.player_damage = 0;
  self.non_player_damage = 0;
  self.car_damage_owner_recorder = 1;
}

loopfx_ontag(var_0, var_1, var_2, var_3) {
  self endon("FX_State_Change" + var_3);
  self endon("delete_destructible");
  level endon("putout_fires");

  while(isDefined(self)) {
    var_4 = get_dummy();
    playFXOnTag(var_0, var_4, var_1);
    wait(var_2);
  }
}

health_drain(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("Health_Drain_State_Change" + var_2);
  level endon("putout_fires");
  self endon("destroyed");

  if(isDefined(var_5) && isDefined(level.destructible_badplace_radius_multiplier)) {
    var_5 = var_5 * level.destructible_badplace_radius_multiplier;
  }

  if(isDefined(var_0) && isDefined(level.destructible_health_drain_amount_multiplier)) {
    var_0 = var_0 * level.destructible_health_drain_amount_multiplier;
  }

  wait(var_1);
  self.healthdrain = 1;
  var_7 = undefined;

  if(isDefined(level.disable_destructible_bad_places) && level.disable_destructible_bad_places) {
    var_5 = undefined;
  }

  if(isDefined(var_5) && isDefined(level.badplace_cylinder_func)) {
    var_7 = "" + gettime();

    if(!isDefined(self.disablebadplace)) {
      if(isDefined(self.script_radius)) {
        var_5 = self.script_radius;
      }

      if(common_scripts\utility::issp() && isDefined(var_6)) {
        if(var_6 == "both") {
          call[[level.badplace_cylinder_func]](var_7, 0, self.origin, var_5, 128, "allies", "bad_guys");
        } else {
          call[[level.badplace_cylinder_func]](var_7, 0, self.origin, var_5, 128, var_6);
        }

        thread badplace_remove(var_7);
      } else {
        call[[level.badplace_cylinder_func]](var_7, 0, self.origin, var_5, 128);
        thread badplace_remove(var_7);
      }
    }
  }

  while(isDefined(self) && self.destructible_parts[var_2].v["health"] > 0) {
    self notify("damage", var_0, self, (0, 0, 0), (0, 0, 0), "MOD_UNKNOWN", var_3, var_4);
    wait(var_1);
  }

  self notify("remove_badplace");
}

badplace_remove(var_0) {
  common_scripts\utility::waittill_any("destroyed", "remove_badplace");
  call[[level.badplace_delete_func]](var_0);
}

physics_launch(var_0, var_1, var_2, var_3) {
  var_4 = physics_object_create(var_0, var_1);
  var_4 physicslaunchclient(var_2, var_3);
}

physics_launch_with_impulse(var_0, var_1, var_2, var_3) {
  var_4 = physics_object_create(var_0, var_1);
  var_4 physicslaunchclientwithimpulse(var_2, var_3);
}

physics_object_create(var_0, var_1) {
  var_2 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["modelName"];
  var_3 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v["tagName"];
  hideapart(var_3);

  if(level.destructiblespawnedents.size >= level.destructiblespawnedentslimit) {
    physics_object_remove(level.destructiblespawnedents[0]);
  }

  var_4 = spawn("script_model", self gettagorigin(var_3));
  var_4.angles = self gettagangles(var_3);
  var_4 setModel(var_2);
  level.destructiblespawnedents[level.destructiblespawnedents.size] = var_4;
  return var_4;
}

physics_object_remove(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level.destructiblespawnedents.size; var_2++) {
    if(level.destructiblespawnedents[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.destructiblespawnedents[var_2];
  }

  level.destructiblespawnedents = var_1;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

explode(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(var_3) && isDefined(level.destructible_explosion_radius_multiplier)) {
    var_3 = var_3 * level.destructible_explosion_radius_multiplier;
  }

  if(!isDefined(var_7)) {
    var_7 = 80;
  }

  if(!isDefined(var_11)) {
    var_11 = (0, 0, 0);
  }

  if(!isDefined(var_6) || isDefined(var_6) && !var_6) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
  }

  if(!isDefined(var_12)) {
    var_12 = 0;
  }

  self notify("exploded", var_10);
  level notify("destructible_exploded", self, var_10);

  if(self.code_classname == "script_vehicle") {
    self notify("death", var_10, self.damage_type);
  }

  if(common_scripts\utility::issp()) {
    thread disconnecttraverses();
  }

  if(!level.fast_destructible_explode) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  var_15 = self.destructible_parts[var_0].v["currentState"];
  var_16 = undefined;

  if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_0][var_15])) {
    var_16 = level.destructible_type[self.destructibleinfo].parts[var_0][var_15].v["tagName"];
  }

  if(isDefined(var_16)) {
    var_17 = self gettagorigin(var_16);
  } else {
    var_17 = self.origin;
  }

  self notify("damage", var_5, self, (0, 0, 0), var_17, "MOD_EXPLOSIVE", "", "");
  self notify("stop_car_alarm");
  waittillframeend;

  if(isDefined(level.destructible_type[self.destructibleinfo].parts)) {
    for(var_18 = level.destructible_type[self.destructibleinfo].parts.size - 1; var_18 >= 0; var_18--) {
      if(var_18 == var_0) {
        continue;
      }
      var_19 = self.destructible_parts[var_18].v["currentState"];

      if(var_19 >= level.destructible_type[self.destructibleinfo].parts[var_18].size) {
        var_19 = level.destructible_type[self.destructibleinfo].parts[var_18].size - 1;
      }

      var_20 = level.destructible_type[self.destructibleinfo].parts[var_18][var_19].v["modelName"];
      var_16 = level.destructible_type[self.destructibleinfo].parts[var_18][var_19].v["tagName"];

      if(!isDefined(var_20)) {
        continue;
      }
      if(!isDefined(var_16)) {
        continue;
      }
      var_21 = 0;

      if(isDefined(self.destructible_parts[var_18].v["health"])) {
        var_21 = self.destructible_parts[var_18].v["health"];
      }

      var_22 = 0;

      if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_18][var_19].v["health"])) {
        var_22 = level.destructible_type[self.destructibleinfo].parts[var_18][var_19].v["health"];
      }

      if(var_22 > 0 && var_21 <= 0) {
        continue;
      }
      if(isDefined(level.destructible_type[self.destructibleinfo].parts[var_18][0].v["physicsOnExplosion"])) {
        if(level.destructible_type[self.destructibleinfo].parts[var_18][0].v["physicsOnExplosion"] > 0) {
          var_23 = level.destructible_type[self.destructibleinfo].parts[var_18][0].v["physicsOnExplosion"];
          var_24 = self gettagorigin(var_16);
          var_25 = vectornormalize(var_24 - var_17);
          var_25 = var_25 * (randomfloatrange(var_1, var_2) * var_23);

          if(isDefined(var_13) && isDefined(var_14)) {
            var_26 = common_scripts\utility::randomvectorrange(var_13, var_14);
            thread physics_launch_with_impulse(var_18, var_19, var_25, var_26);
          } else {
            thread physics_launch(var_18, var_19, var_24, var_25);
          }

          continue;
        }
      }
    }
  }

  var_27 = !isDefined(var_6) || isDefined(var_6) && !var_6;

  if(var_27) {
    self notify("stop_taking_damage");
  }

  if(!level.fast_destructible_explode) {
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  var_28 = var_17 + (0, 0, var_7) + var_11;
  var_29 = getsubstr(level.destructible_type[self.destructibleinfo].v["type"], 0, 7) == "vehicle";

  if(var_29) {
    anim.lastcarexplosiontime = gettime();
    anim.lastcarexplosiondamagelocation = var_28;
    anim.lastcarexplosionlocation = var_17;
    anim.lastcarexplosionrange = var_3;
  }

  level thread set_disable_friendlyfire_value_delayed(1);

  if(var_12 > 0) {
    wait(var_12);
  }

  if(isDefined(level.destructible_protection_func)) {
    thread[[level.destructible_protection_func]]();
  }

  if(common_scripts\utility::issp()) {
    if(level.gameskill == 0 && !player_touching_post_clip()) {
      self radiusdamage(var_28, var_3, var_5, var_4, self, "MOD_RIFLE_BULLET");
    } else {
      self radiusdamage(var_28, var_3, var_5, var_4, self);
    }

    if(isDefined(self.damageowner) && var_29) {
      self.damageowner notify("destroyed_car");
      level notify("player_destroyed_car", self.damageowner, var_28);
    }
  } else {
    var_30 = "destructible_toy";

    if(var_29) {
      var_30 = "destructible_car";
    }

    if(!isDefined(self.damageowner)) {
      self radiusdamage(var_28, var_3, var_5, var_4, self, "MOD_EXPLOSIVE", var_30);
    } else {
      self radiusdamage(var_28, var_3, var_5, var_4, self.damageowner, "MOD_EXPLOSIVE", var_30);

      if(var_29) {
        self.damageowner notify("destroyed_car");
        level notify("player_destroyed_car", self.damageowner, var_28);
      }
    }
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    earthquake(var_8, 2.0, var_28, var_9);
  }

  level thread set_disable_friendlyfire_value_delayed(0, 0.05);
  var_31 = 0.01;
  var_32 = var_3 * var_31;
  var_3 = var_3 * 0.99;
  physicsexplosionsphere(var_17, var_3, 0, var_32);

  if(var_27) {
    self setCanDamage(0);
    thread cleanupvars();
  }

  self notify("destroyed");
}

cleanupvars() {
  wait 0.05;

  while(isDefined(self) && isDefined(self.waiting_for_queue)) {
    self waittill("queue_processed");
    wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  self.animsapplied = undefined;
  self.attacker = undefined;
  self.car_damage_owner_recorder = undefined;
  self.caralarm = undefined;
  self.damageowner = undefined;
  self.destructible_parts = undefined;
  self.destructible_type = undefined;
  self.destructibleinfo = undefined;
  self.healthdrain = undefined;
  self.non_player_damage = undefined;
  self.player_damage = undefined;

  if(!isDefined(level.destructible_cleans_up_more)) {
    return;
  }
  self.script_noflip = undefined;
  self.exploding = undefined;
  self.loopingsoundstopnotifies = undefined;
  self.car_alarm_org = undefined;
}

set_disable_friendlyfire_value_delayed(var_0, var_1) {
  level notify("set_disable_friendlyfire_value_delayed");
  level endon("set_disable_friendlyfire_value_delayed");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  level.friendlyfiredisabledfordestructible = var_0;
}

connecttraverses() {
  var_0 = get_traverse_disconnect_brush();

  if(!isDefined(var_0)) {
    return;
  }
  var_0 call[[level.connectpathsfunction]]();
  var_0.origin = var_0.origin - (0, 0, 10000);
}

disconnecttraverses() {
  var_0 = get_traverse_disconnect_brush();

  if(!isDefined(var_0)) {
    return;
  }
  var_0.origin = var_0.origin + (0, 0, 10000);
  var_0 call[[level.disconnectpathsfunction]]();
  var_0.origin = var_0.origin - (0, 0, 10000);
}

get_traverse_disconnect_brush() {
  if(!isDefined(self.target)) {
    return undefined;
  }

  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(isspawner(var_2)) {
      continue;
    }
    if(isDefined(var_2.script_destruct_collision)) {
      continue;
    }
    if(var_2.code_classname == "light") {
      continue;
    }
    if(!var_2.spawnflags & 1) {
      continue;
    }
    return var_2;
  }
}

hideapart(var_0) {
  self hidepart(var_0);
}

showapart(var_0) {
  self showpart(var_0);
}

disable_explosion() {
  self.dontallowexplode = 1;
}

force_explosion() {
  self.dontallowexplode = undefined;
  self.forceexploding = 1;
  self notify("damage", 100000, self, self.origin, self.origin, "MOD_EXPLOSIVE", "", "");
}

get_dummy() {
  if(!common_scripts\utility::issp()) {
    return self;
  }

  if(self.modeldummyon) {
    var_0 = self.modeldummy;
  } else {
    var_0 = self;
  }

  return var_0;
}

play_loop_sound_on_destructible(var_0, var_1) {
  var_2 = get_dummy();
  var_3 = spawn("script_origin", (0, 0, 0));

  if(isDefined(var_1)) {
    var_3.origin = var_2 gettagorigin(var_1);
  } else {
    var_3.origin = var_2.origin;
  }

  var_3 playLoopSound(var_0);
  var_2 thread force_stop_sound(var_0);
  var_2 waittill("stop sound" + var_0);

  if(!isDefined(var_3)) {
    return;
  }
  var_3 stoploopsound(var_0);
  var_3 delete();
}

force_stop_sound(var_0) {
  self endon("stop sound" + var_0);
  level waittill("putout_fires");
  self notify("stop sound" + var_0);
}

notifydamageafterframe(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  waittillframeend;

  if(isDefined(self.exploded)) {
    return;
  }
  if(common_scripts\utility::issp()) {
    var_0 = var_0 / 0.5;
  } else {
    var_0 = var_0 / 1.0;
  }

  self notify("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

play_sound(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = spawn("script_origin", self gettagorigin(var_1));
    var_2 hide();
    var_2 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  } else {
    var_2 = spawn("script_origin", (0, 0, 0));
    var_2 hide();
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linkto(self);
  }

  var_2 playSound(var_0);
  wait 5.0;

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

do_car_alarm() {
  if(isDefined(self.caralarm)) {
    return;
  }
  self.caralarm = 1;

  if(!should_do_car_alarm()) {
    return;
  }
  self.car_alarm_org = spawn("script_model", self.origin);
  self.car_alarm_org hide();
  self.car_alarm_org playLoopSound("car_alarm");
  level.currentcaralarms++;
  thread car_alarm_timeout();
  self waittill("stop_car_alarm");
  level.lastcaralarmtime = gettime();
  level.currentcaralarms--;
  self.car_alarm_org stoploopsound("car_alarm");
  self.car_alarm_org delete();
}

car_alarm_timeout() {
  self endon("stop_car_alarm");
  wait 25;

  if(!isDefined(self)) {
    return;
  }
  thread play_sound("car_alarm_off");
  self notify("stop_car_alarm");
}

should_do_car_alarm() {
  if(level.currentcaralarms >= 2) {
    return 0;
  }

  var_0 = undefined;

  if(!isDefined(level.lastcaralarmtime)) {
    if(common_scripts\utility::cointoss()) {
      return 1;
    }

    var_0 = gettime() - level.commonstarttime;
  } else {
    var_0 = gettime() - level.lastcaralarmtime;
  }

  if(level.currentcaralarms == 0 && var_0 >= 120) {
    return 1;
  }

  if(randomint(100) <= 33) {
    return 1;
  }

  return 0;
}

do_random_dynamic_attachment(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(common_scripts\utility::issp()) {
    self attach(var_1, var_0, 0);

    if(isDefined(var_2) && var_2 != "") {
      self attach(var_2, var_0, 0);
    }
  } else {
    var_4[0] = spawn("script_model", self gettagorigin(var_0));
    var_4[0].angles = self gettagangles(var_0);
    var_4[0] setModel(var_1);
    var_4[0] linkto(self, var_0);

    if(isDefined(var_2) && var_2 != "") {
      var_4[1] = spawn("script_model", self gettagorigin(var_0));
      var_4[1].angles = self gettagangles(var_0);
      var_4[1] setModel(var_2);
      var_4[1] linkto(self, var_0);
    }
  }

  if(isDefined(var_3)) {
    var_5 = self gettagorigin(var_0);
    var_6 = get_closest_with_targetname(var_5, var_3);

    if(isDefined(var_6)) {
      var_6 delete();
    }
  }

  self waittill("exploded");

  if(common_scripts\utility::issp()) {
    self detach(var_1, var_0);
    self attach(var_1 + "_destroy", var_0, 0);

    if(isDefined(var_2) && var_2 != "") {
      self detach(var_2, var_0);
      self attach(var_2 + "_destroy", var_0, 0);
    }
  } else {
    var_4[0] setModel(var_1 + "_destroy");

    if(isDefined(var_2) && var_2 != "") {
      var_4[1] setModel(var_2 + "_destroy");
    }
  }
}

get_closest_with_targetname(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = getEntArray(var_1, "targetname");

  foreach(var_6 in var_4) {
    var_7 = distancesquared(var_0, var_6.origin);

    if(!isDefined(var_2) || var_7 < var_2) {
      var_2 = var_7;
      var_3 = var_6;
    }
  }

  return var_3;
}

player_touching_post_clip() {
  var_0 = undefined;

  if(!isDefined(self.target)) {
    return 0;
  }

  var_1 = getEntArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_destruct_collision) && var_3.script_destruct_collision == "post") {
      var_0 = var_3;
      break;
    }
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  var_5 = get_player_touching(var_0);

  if(isDefined(var_5)) {
    return 1;
  }

  return 0;
}

get_player_touching(var_0) {
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }
    if(var_0 istouching(var_2)) {
      return var_2;
    }
  }

  return undefined;
}

is_so() {
  return getDvar("specialops") == "1";
}

destructible_handles_collision_brushes() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = [];
  var_1["pre"] = ::collision_brush_pre_explosion;
  var_1["post"] = ::collision_brush_post_explosion;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.script_destruct_collision)) {
      continue;
    }
    self thread[[var_1[var_3.script_destruct_collision]]](var_3);
  }
}

collision_brush_pre_explosion(var_0) {
  waittillframeend;

  if(common_scripts\utility::issp() && var_0.spawnflags & 1) {
    var_0 call[[level.disconnectpathsfunction]]();
  }

  self waittill("exploded");

  if(common_scripts\utility::issp() && var_0.spawnflags & 1) {
    var_0 call[[level.connectpathsfunction]]();
  }

  var_0 delete();
}

collision_brush_post_explosion(var_0) {
  var_0 notsolid();

  if(common_scripts\utility::issp() && var_0.spawnflags & 1) {
    var_0 call[[level.connectpathsfunction]]();
  }

  self waittill("exploded");
  waittillframeend;

  if(common_scripts\utility::issp()) {
    if(var_0.spawnflags & 1) {
      var_0 call[[level.disconnectpathsfunction]]();
    }

    if(is_so()) {
      var_1 = get_player_touching(var_0);

      if(isDefined(var_1)) {
        self thread[[level.func_destructible_crush_player]](var_1);
      }
    } else {}
  }

  var_0 solid();
}

debug_player_in_post_clip(var_0) {}

destructible_get_my_breakable_light(var_0) {
  var_1 = getEntArray("light_destructible", "targetname");

  if(common_scripts\utility::issp()) {
    var_2 = getEntArray("light_destructible", "script_noteworthy");
    var_1 = common_scripts\utility::array_combine(var_1, var_2);
  }

  if(!var_1.size) {
    return;
  }
  var_3 = var_0 * var_0;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = distancesquared(self.origin, var_6.origin);

    if(var_7 < var_3) {
      var_4 = var_6;
      var_3 = var_7;
    }
  }

  if(!isDefined(var_4)) {
    return;
  }
  self.breakable_light = var_4;
}

break_nearest_light(var_0) {
  if(!isDefined(self.breakable_light)) {
    return;
  }
  self.breakable_light setlightintensity(0);
}

debug_radiusdamage_circle(var_0, var_1, var_2, var_3) {
  var_4 = 16;
  var_5 = 360 / var_4;
  var_6 = [];

  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_8 = var_5 * var_7;
    var_9 = cos(var_8) * var_1;
    var_10 = sin(var_8) * var_1;
    var_11 = var_0[0] + var_9;
    var_12 = var_0[1] + var_10;
    var_13 = var_0[2];
    var_6[var_6.size] = (var_11, var_12, var_13);
  }

  thread debug_circle_drawlines(var_6, 5.0, (1, 0, 0), var_0);
  var_6 = [];

  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_8 = var_5 * var_7;
    var_9 = cos(var_8) * var_1;
    var_10 = sin(var_8) * var_1;
    var_11 = var_0[0];
    var_12 = var_0[1] + var_9;
    var_13 = var_0[2] + var_10;
    var_6[var_6.size] = (var_11, var_12, var_13);
  }

  thread debug_circle_drawlines(var_6, 5.0, (1, 0, 0), var_0);
  var_6 = [];

  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_8 = var_5 * var_7;
    var_9 = cos(var_8) * var_1;
    var_10 = sin(var_8) * var_1;
    var_11 = var_0[0] + var_10;
    var_12 = var_0[1];
    var_13 = var_0[2] + var_9;
    var_6[var_6.size] = (var_11, var_12, var_13);
  }

  thread debug_circle_drawlines(var_6, 5.0, (1, 0, 0), var_0);
}

debug_circle_drawlines(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_4 + 1 >= var_0.size) {
      var_6 = var_0[0];
    } else {
      var_6 = var_0[var_4 + 1];
    }

    thread debug_line(var_5, var_6, var_1, var_2);
    thread debug_line(var_3, var_5, var_1, var_2);
  }
}

debug_line(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (1, 1, 1);
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    wait 0.05;
  }
}

spotlight_tag_origin_cleanup(var_0) {
  var_0 endon("death");
  level waittill("new_destructible_spotlight");
  var_0 delete();
}

spotlight_fizzles_out(var_0, var_1, var_2, var_3, var_4) {
  level endon("new_destructible_spotlight");
  thread spotlight_tag_origin_cleanup(var_4);
  var_5 = var_0["spotlight_brightness"];
  wait(randomfloatrange(2, 5));
  destructible_fx_think(var_0, var_1, var_2, var_3);
  level.destructible_spotlight delete();
  var_4 delete();
}

destructible_spotlight_think(var_0, var_1, var_2, var_3) {
  if(!common_scripts\utility::issp()) {
    return;
  }
  if(!isDefined(self.breakable_light)) {
    return;
  }
  var_1 common_scripts\utility::self_func("startignoringspotLight");

  if(!isDefined(level.destructible_spotlight)) {
    level.destructible_spotlight = common_scripts\utility::spawn_tag_origin();
    var_4 = common_scripts\utility::getfx(var_0["spotlight_fx"]);
    playFXOnTag(var_4, level.destructible_spotlight, "tag_origin");
  }

  level notify("new_destructible_spotlight");
  level.destructible_spotlight unlink();
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5 linkto(self, var_0["spotlight_tag"], (0, 0, 0), (0, 0, 0));
  level.destructible_spotlight.origin = self.breakable_light.origin;
  level.destructible_spotlight.angles = self.breakable_light.angles;
  level.destructible_spotlight thread spotlight_fizzles_out(var_0, var_1, var_2, var_3, var_5);
  wait 0.05;

  if(isDefined(var_5)) {
    level.destructible_spotlight linkto(var_5);
  }
}

is_valid_damagetype(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1["fx_valid_damagetype"])) {
    var_4 = var_1["fx_valid_damagetype"][var_3][var_2];
  }

  if(!isDefined(var_4)) {
    return 1;
  }

  return issubstr(var_4, var_0);
}

destructible_sound_think(var_0, var_1, var_2, var_3) {
  if(isDefined(self.exploded)) {
    return undefined;
  }

  if(!isDefined(var_0["sound"])) {
    return undefined;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_0["sound"][var_3])) {
    return undefined;
  }

  for(var_4 = 0; var_4 < var_0["sound"][var_3].size; var_4++) {
    var_5 = isvalidsoundcause("soundCause", var_0, var_4, var_2, var_3);

    if(!var_5) {
      continue;
    }
    var_6 = var_0["sound"][var_3][var_4];
    var_7 = var_0["tagName"];
    var_1 thread play_sound(var_6, var_7);
  }

  return var_3;
}

destructible_fx_kill_state_wait(var_0) {
  var_1 = level.destructible_type[self.destructibleinfo].parts[0].size - 1;
  self endon("FX_State_Change_Kill" + var_0);

  for(;;) {
    var_2 = -1;

    if(isDefined(self.destructible_parts[0].v["currentState"])) {
      var_2 = self.destructible_parts[0].v["currentState"];
    }

    if(var_2 == var_1) {
      return 0;
    }

    waitframe();
  }
}

destructible_fx_spawn_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  waittillframeend;

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_2)) {
    if(var_4) {
      playFXOnTag(var_1, var_0, var_2);
      wait 0.05;

      if(var_5 == 1 || var_5 == 2) {
        destructible_fx_kill_state_wait(var_3);

        if(var_5 == 1) {
          stopFXOnTag(var_1, var_0, var_2);
        } else {
          killfxontag(var_1, var_0, var_2);
        }
      }
    } else {
      var_8 = var_0 gettagorigin(var_2);
      var_9 = (0, 0, 100);

      if(var_5 == 1 || var_5 == 2) {
        var_7 = spawnfx(var_1, var_8, var_9);
        var_6 = triggerfx(var_7, 0.01);
      } else {
        var_6 = playFX(var_1, var_8, var_9);
      }

      wait 0.05;

      if(var_5 == 1 || var_5 == 2) {
        destructible_fx_kill_state_wait(var_3);

        if(var_5 == 1) {
          var_7 delete();
        } else if(var_5 == 2) {
          setfxkillondelete(var_7, 1);
          wait 0.05;
          var_7 delete();
        }
      }
    }
  } else {
    var_8 = var_0.origin;
    var_9 = (0, 0, 100);

    if(var_5 == 1 || var_5 == 2) {
      var_7 = spawnfx(var_1, var_8, var_9);
      var_6 = triggerfx(var_7, 0.01);
    } else {
      var_6 = playFX(var_1, var_8, var_9);
    }

    wait 0.05;

    if(var_5 == 1 || var_5 == 2) {
      destructible_fx_kill_state_wait(var_3);

      if(var_5 == 1) {
        var_7 delete();
      } else if(var_5 == 2) {
        setfxkillondelete(var_7, 1);
        wait 0.05;
        var_7 delete();
      }
    }
  }
}

destructible_fx_spawnimmediate() {
  if(!isDefined(level.destructible_type[self.destructibleinfo].parts)) {
    return;
  }
  var_0 = get_dummy();

  for(var_1 = 0; var_1 < level.destructible_type[self.destructibleinfo].parts.size; var_1++) {
    for(var_2 = 0; var_2 < level.destructible_type[self.destructibleinfo].parts[var_1].size; var_2++) {
      var_3 = level.destructible_type[self.destructibleinfo].parts[var_1][var_2];

      if(isDefined(var_3.v["fx_filename"])) {
        for(var_4 = 0; var_4 < var_3.v["fx_filename"].size; var_4++) {
          var_5 = var_3.v["fx_filename"][var_4];
          var_6 = var_3.v["fx_tag"][var_4];
          var_7 = var_3.v["spawn_immediate"][var_4];

          if(isDefined(var_5) && isDefined(var_7)) {
            for(var_8 = 0; var_8 < var_5.size; var_8++) {
              if(var_7[var_8] == 1) {
                var_9 = var_3.v["state_change_kill"][var_4][var_8];
                var_10 = level.destructible_type[self.destructibleinfo].parts[var_1][var_2].v["fx"][var_4][var_8];
                var_11 = var_6[var_8];
                var_12 = var_5[var_8];
                var_13 = level.destructible_type[self.destructibleinfo].parts[var_1][var_2].v["fx_useTagAngles"][var_4][var_8];
                thread destructible_fx_spawn_think(var_0, var_10, var_11, var_1, var_13, var_9);
              }
            }
          }
        }
      }
    }
  }
}

destructible_fx_think(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0["fx"])) {
    return undefined;
  }

  if(!isDefined(var_4)) {
    var_4 = randomint(var_0["fx_filename"].size);
  }

  if(!isDefined(var_0["fx"][var_4])) {
    var_4 = randomint(var_0["fx_filename"].size);
  }

  var_5 = var_0["fx_filename"][var_4].size;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    if(!is_valid_damagetype(var_2, var_0, var_6, var_4)) {
      continue;
    }
    if(var_0["spawn_immediate"][var_4][var_6] == 1) {
      continue;
    }
    var_7 = var_0["fx"][var_4][var_6];
    var_8 = var_0["state_change_kill"][var_4][var_6];

    if(isDefined(var_0["fx_tag"][var_4][var_6])) {
      var_9 = var_0["fx_tag"][var_4][var_6];
      self notify("FX_State_Change" + var_3);

      if(var_0["fx_useTagAngles"][var_4][var_6]) {
        thread destructible_fx_spawn_think(var_1, var_7, var_9, var_3, 1, var_8);
      } else {
        thread destructible_fx_spawn_think(var_1, var_7, var_9, var_3, 0, var_8);
      }

      continue;
    }

    thread destructible_fx_spawn_think(var_1, var_7, undefined, var_3, 0, var_8);
  }

  return var_4;
}

destructible_animation_think(var_0, var_1, var_2, var_3) {
  if(isDefined(self.exploded)) {
    return undefined;
  }

  if(!isDefined(var_0["animation"])) {
    return undefined;
  }

  if(isDefined(self.no_destructible_animation)) {
    return undefined;
  }

  if(isDefined(var_0["randomly_flip"]) && !isDefined(self.script_noflip)) {
    if(common_scripts\utility::cointoss()) {
      self.angles = self.angles + (0, 180, 0);
    }
  }

  if(isDefined(var_0["spotlight_tag"])) {
    thread destructible_spotlight_think(var_0, var_1, var_2, var_3);
    wait 0.05;
  }

  var_4 = common_scripts\utility::random(var_0["animation"]);
  var_5 = var_4["anim"];
  var_6 = var_4["animTree"];
  var_7 = var_4["groupNum"];
  var_8 = var_4["mpAnim"];
  var_9 = var_4["maxStartDelay"];
  var_10 = var_4["animRateMin"];
  var_11 = var_4["animRateMax"];

  if(!isDefined(var_10)) {
    var_10 = 1.0;
  }

  if(!isDefined(var_11)) {
    var_11 = 1.0;
  }

  if(var_10 == var_11) {
    var_12 = var_10;
  } else {
    var_12 = randomfloatrange(var_10, var_11);
  }

  var_13 = var_4["vehicle_exclude_anim"];

  if(self.code_classname == "script_vehicle" && var_13) {
    return undefined;
  }

  var_1 common_scripts\utility::self_func("useanimtree", var_6);
  var_14 = var_4["animType"];

  if(!isDefined(self.animsapplied)) {
    self.animsapplied = [];
  }

  self.animsapplied[self.animsapplied.size] = var_5;

  if(isDefined(self.exploding)) {
    clear_anims(var_1);
  }

  if(isDefined(var_9) && var_9 > 0) {
    wait(randomfloat(var_9));
  }

  if(!common_scripts\utility::issp()) {
    if(isDefined(var_8)) {
      common_scripts\utility::self_func("scriptModelPlayAnim", var_8);
    }

    return var_7;
  }

  if(var_14 == "setanim") {
    var_1 common_scripts\utility::self_func("setanim", var_5, 1.0, 1.0, var_12);
    return var_7;
  }

  if(var_14 == "setanimknob") {
    var_1 common_scripts\utility::self_func("setanimknob", var_5, 1.0, 0, var_12);
    return var_7;
  }

  return undefined;
}

clear_anims(var_0) {
  if(isDefined(self.animsapplied)) {
    foreach(var_2 in self.animsapplied) {
      if(common_scripts\utility::issp()) {
        var_0 common_scripts\utility::self_func("clearanim", var_2, 0);
        continue;
      }

      var_0 common_scripts\utility::self_func("scriptModelClearAnim");
    }
  }
}

init_destroyed_count() {
  level.destroyedcount = 0;
  level.destroyedcounttimeout = 0.5;

  if(common_scripts\utility::issp()) {
    level.maxdestructions = 20;
  } else {
    level.maxdestructions = 2;
  }
}

add_to_destroyed_count() {
  level.destroyedcount++;
  wait(level.destroyedcounttimeout);
  level.destroyedcount--;
}

get_destroyed_count() {
  return level.destroyedcount;
}

get_max_destroyed_count() {
  return level.maxdestructions;
}

init_destructible_frame_queue() {
  level.destructibleframequeue = [];
}

add_destructible_to_frame_queue(var_0, var_1, var_2) {
  var_3 = self getentitynumber();

  if(!isDefined(level.destructibleframequeue[var_3])) {
    level.destructibleframequeue[var_3] = spawnStruct();
    level.destructibleframequeue[var_3].entnum = var_3;
    level.destructibleframequeue[var_3].destructible = var_0;
    level.destructibleframequeue[var_3].totaldamage = 0;
    level.destructibleframequeue[var_3].neardistance = 9999999;
    level.destructibleframequeue[var_3].fxcost = 0;
  }

  level.destructibleframequeue[var_3].fxcost = level.destructibleframequeue[var_3].fxcost + var_1.v["fxcost"];
  level.destructibleframequeue[var_3].totaldamage = level.destructibleframequeue[var_3].totaldamage + var_2;

  if(var_1.v["distance"] < level.destructibleframequeue[var_3].neardistance) {
    level.destructibleframequeue[var_3].neardistance = var_1.v["distance"];
  }

  thread handle_destructible_frame_queue();
}

handle_destructible_frame_queue() {
  level notify("handle_destructible_frame_queue");
  level endon("handle_destructible_frame_queue");
  wait 0.05;
  var_0 = level.destructibleframequeue;
  level.destructibleframequeue = [];
  var_1 = sort_destructible_frame_queue(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(get_destroyed_count() < get_max_destroyed_count()) {
      if(var_1[var_2].fxcost) {
        thread add_to_destroyed_count();
      }

      var_1[var_2].destructible notify("queue_processed", 1);
      continue;
    }

    var_1[var_2].destructible notify("queue_processed", 0);
  }
}

sort_destructible_frame_queue(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_1.size] = var_3;
  }

  for(var_5 = 1; var_5 < var_1.size; var_5++) {
    var_6 = var_1[var_5];

    for(var_7 = var_5 - 1; var_7 >= 0 && get_better_destructible(var_6, var_1[var_7]) == var_6; var_7--) {
      var_1[var_7 + 1] = var_1[var_7];
    }

    var_1[var_7 + 1] = var_6;
  }

  return var_1;
}

get_better_destructible(var_0, var_1) {
  if(var_0.totaldamage > var_1.totaldamage) {
    return var_0;
  } else {
    return var_1;
  }
}

get_part_fx_cost_for_action_state(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(level.destructible_type[self.destructibleinfo].parts[var_0][var_1])) {
    return var_2;
  }

  var_3 = level.destructible_type[self.destructibleinfo].parts[var_0][var_1].v;

  if(isDefined(var_3["fx"])) {
    foreach(var_5 in var_3["fx_cost"]) {
      foreach(var_7 in var_5) {
        var_2 = var_2 + var_7;
      }
    }
  }

  return var_2;
}

initdot(var_0) {
  if(!common_scripts\utility::flag_exist("FLAG_DOT_init")) {
    common_scripts\utility::flag_init("FLAG_DOT_init");
    common_scripts\utility::flag_set("FLAG_DOT_init");
  }

  var_0 = tolower(var_0);

  switch (var_0) {
    case "poison":
      if(!common_scripts\utility::flag_exist("FLAG_DOT_poison_init")) {
        common_scripts\utility::flag_init("FLAG_DOT_poison_init");
        common_scripts\utility::flag_set("FLAG_DOT_poison_init");
      }

      break;
    default:
  }
}

createdot() {
  var_0 = spawnStruct();
  var_0.ticks = [];
  return var_0;
}

createdot_radius(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "trigger_radius";
  var_4.origin = var_0;
  var_4.spawnflags = var_1;
  var_4.radius = var_2;
  var_4.minradius = var_2;
  var_4.maxradius = var_2;
  var_4.height = var_3;
  var_4.ticks = [];
  return var_4;
}

setdot_origin(var_0) {
  self.origin = var_0;
}

setdot_radius(var_0, var_1) {
  if(isDefined(self.classname) && self.classname != "trigger_radius") {}

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  self.minradius = var_0;
  self.maxradius = var_1;
}

setdot_height(var_0, var_1) {
  if(isDefined(self.classname) && issubstr(self.classname, "trigger")) {
    return;
  }
}

setdot_ontick(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_0)) {} else {
    var_0 = 0;
  }

  var_6 = tolower(var_6);
  var_7 = tolower(var_7);
  var_8 = self.ticks.size;
  self.ticks[var_8] = spawnStruct();
  self.ticks[var_8].enable = 0;
  self.ticks[var_8].delay = var_0;
  self.ticks[var_8].interval = var_1;
  self.ticks[var_8].duration = var_2;
  self.ticks[var_8].mindamage = var_3;
  self.ticks[var_8].maxdamage = var_4;

  switch (var_5) {
    case 1:
    case 0:
      break;
    default:
  }

  self.ticks[var_8].falloff = var_5;
  self.ticks[var_8].starttime = 0;

  switch (var_6) {
    case "normal":
      break;
    case "poison":
      switch (var_7) {
        case "player":
          self.ticks[var_8].type = var_6;
          self.ticks[var_8].affected = var_7;
          self.ticks[var_8].onenterfunc = ::onenterdot_poisondamageplayer;
          self.ticks[var_8].onexitfunc = ::onexitdot_poisondamageplayer;
          self.ticks[var_8].ondeathfunc = ::ondeathdot_poisondamageplayer;
          break;
        default:
      }

      break;
    default:
  }
}

builddot_ontick(var_0, var_1) {
  var_1 = tolower(var_1);
  var_2 = self.ticks.size;
  self.ticks[var_2] = spawnStruct();
  self.ticks[var_2].duration = var_0;
  self.ticks[var_2].delay = 0;
  self.ticks[var_2].onenterfunc = ::onenterdot_buildfunc;
  self.ticks[var_2].onexitfunc = ::onexitdot_buildfunc;
  self.ticks[var_2].ondeathfunc = ::ondeathdot_buildfunc;

  switch (var_1) {
    case "player":
      self.ticks[var_2].affected = var_1;
      break;
    default:
  }
}

builddot_startloop(var_0) {
  var_1 = self.ticks.size - 1;

  if(!isDefined(self.ticks[var_1].statements)) {
    self.ticks[var_1].statements = [];
  }

  var_2 = self.ticks[var_1].statements.size;
  self.ticks[var_1].statements = [];
  self.ticks[var_1].statements["vars"] = [];
  self.ticks[var_1].statements["vars"]["count"] = var_0;
}

builddot_damage(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self.ticks.size - 1;

  if(!isDefined(self.ticks[var_6].statements["actions"])) {
    self.ticks[var_6].statements["actions"] = [];
  }

  var_7 = self.ticks[var_6].statements["actions"].size;
  self.ticks[var_6].statements["actions"][var_7] = [];
  self.ticks[var_6].statements["actions"][var_7]["vars"] = [var_0, var_1, var_2, var_3, var_4, var_5];
  self.ticks[var_6].statements["actions"][var_7]["func"] = ::dobuilddot_damage;
}

builddot_wait(var_0) {
  var_1 = self.ticks.size - 1;

  if(!isDefined(self.ticks[var_1].statements["actions"])) {
    self.ticks[var_1].statements["actions"] = [];
  }

  var_2 = self.ticks[var_1].statements["actions"].size;
  self.ticks[var_1].statements["actions"][var_2] = [];
  self.ticks[var_1].statements["actions"][var_2]["vars"] = [var_0];
  self.ticks[var_1].statements["actions"][var_2]["func"] = ::dobuilddot_wait;
}

onenterdot_buildfunc(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_1 endon("death");
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_2);
  var_2 = undefined;
  var_3 = var_1.ticks[var_0].statements;

  if(!isDefined(var_3) || !isDefined(var_3["vars"]) || !isDefined(var_3["vars"]["count"]) || !isDefined(var_3["actions"])) {
    return;
  }
  var_4 = var_3["vars"]["count"];
  var_5 = var_3["actions"];
  var_3 = undefined;

  for(var_6 = 1; var_6 <= var_4 || var_4 == 0; var_6--) {
    foreach(var_8 in var_5) {
      var_9 = var_8["vars"];
      var_10 = var_8["func"];
      self[[var_10]](var_0, var_1, var_9);
    }
  }
}

onexitdot_buildfunc(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = self getentitynumber();
  var_1 notify("LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3);
}

ondeathdot_buildfunc(var_0, var_1) {}

dobuilddot_damage(var_0, var_1, var_2) {
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_2[2];
  var_6 = var_2[3];
  var_7 = var_2[4];
  var_8 = var_2[5];
  self thread[[level.callbackplayerdamage]](var_1, var_1, var_4, var_6, var_7, var_8, var_1.origin, (0, 0, 0) - var_1.origin, "none", 0);
}

dobuilddot_wait(var_0, var_1, var_2) {
  var_3 = var_1 getentitynumber();
  var_4 = self getentitynumber();
  var_1 endon("death");
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_3);
  var_1 notify("LISTEN_kill_tick_" + var_0 + "_" + var_3 + "_" + var_4);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_3);
  var_3 = undefined;
  var_4 = undefined;
  wait(var_2[0]);
}

startdot_group(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = undefined;

    switch (var_3.type) {
      case "trigger_radius":
        var_4 = spawn("trigger_radius", var_3.origin, var_3.spawnflags, var_3.radius, var_3.height);
        var_4.minradius = var_3.minradius;
        var_4.maxradius = var_3.maxradius;
        var_4.ticks = var_3.ticks;
        var_1[var_1.size] = var_4;
        break;
      default:
    }

    if(isDefined(var_3.parent)) {
      var_4 linkto(var_3.parent);
      var_3.parent.dot = var_4;
    }

    var_5 = var_4.ticks;

    foreach(var_7 in var_5) {
      var_7.starttime = gettime();
    }

    foreach(var_7 in var_5) {
      if(!var_7.delay) {
        var_7.enable = 1;
      }
    }

    foreach(var_7 in var_5) {
      if(issubstr(var_7.affected, "player")) {
        var_4.onplayer = 1;
        break;
      }
    }
  }

  foreach(var_4 in var_1) {
    var_4.dot_group = [];

    foreach(var_16 in var_1) {
      if(var_4 == var_16) {
        continue;
      }
      var_4.dot_group[var_4.dot_group.size] = var_16;
    }
  }

  foreach(var_4 in var_1) {
    if(var_4.onplayer) {
      var_4 thread startdot_player();
    }
  }

  foreach(var_4 in var_1) {
    var_4 thread monitordot();
  }
}

startdot_player() {
  thread triggertouchthink(::onenterdot_player, ::onexitdot_player);
}

monitordot() {
  var_0 = gettime();

  while(isDefined(self)) {
    foreach(var_4, var_2 in self.ticks) {
      if(isDefined(var_2) && gettime() - var_0 >= var_2.duration * 1000) {
        var_3 = self getentitynumber();
        self notify("LISTEN_kill_tick_" + var_4 + "_" + var_3);
        self.ticks[var_4] = undefined;
      }
    }

    if(!self.ticks.size) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    foreach(var_2 in self.ticks) {
      self[[var_2.ondeathfunc]]();
    }

    self notify("death");
    self delete();
  }
}

onenterdot_player(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("LISTEN_enter_dot_" + var_1);

  foreach(var_4, var_3 in var_0.ticks) {
    if(!var_3.enable) {
      thread dodot_delayfunc(var_4, var_0, var_3.delay, var_3.onenterfunc);
    }
  }

  foreach(var_4, var_3 in var_0.ticks) {
    if(var_3.enable && var_3.affected == "player") {
      self thread[[var_3.onenterfunc]](var_4, var_0);
    }
  }
}

onexitdot_player(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("LISTEN_exit_dot_" + var_1);

  foreach(var_4, var_3 in var_0.ticks) {
    if(var_3.enable && var_3.affected == "player") {
      self thread[[var_3.onexitfunc]](var_4, var_0);
    }
  }
}

dodot_delayfunc(var_0, var_1, var_2, var_3) {
  var_4 = var_1 getentitynumber();
  var_5 = self getentitynumber();
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_4 + "_" + var_5);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self notify("LISTEN_exit_dot_" + var_4);
  var_4 = undefined;
  var_5 = undefined;
  wait(var_2);
  self thread[[var_3]](var_0, var_1);
}

onenterdot_poisondamageplayer(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = self getentitynumber();
  var_1 endon("death");
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2);
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_2);

  if(!isDefined(self.onenterdot_poisondamagecount)) {
    self.onenterdot_poisondamagecount = [];
  }

  if(!isDefined(self.onenterdot_poisondamagecount[var_0])) {
    self.onenterdot_poisondamagecount[var_0] = [];
  }

  self.onenterdot_poisondamagecount[var_0][var_2] = 0;
  var_4 = common_scripts\utility::ter_op(common_scripts\utility::issp(), 1.5, 1);

  while(isDefined(var_1) && isDefined(var_1.ticks[var_0])) {
    self.onenterdot_poisondamagecount[var_0][var_2]++;

    switch (self.onenterdot_poisondamagecount[var_0][var_2]) {
      case 1:
        self viewkick(1, self.origin);
        break;
      case 3:
        self shellshock("mp_radiation_low", 4);
        dodot_poisondamage(var_1, var_4 * 2);
        break;
      case 4:
        self shellshock("mp_radiation_med", 5);
        thread dodot_poisonblackout(var_0, var_1);
        dodot_poisondamage(var_1, var_4 * 2);
        break;
      case 6:
        self shellshock("mp_radiation_high", 5);
        dodot_poisondamage(var_1, var_4 * 2);
        break;
      case 8:
        self shellshock("mp_radiation_high", 5);
        dodot_poisondamage(var_1, var_4 * 500);
        break;
    }

    wait(var_1.ticks[var_0].interval);
  }
}

onexitdot_poisondamageplayer(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = self getentitynumber();
  var_4 = self.onenterdot_poisondamageoverlay;

  if(isDefined(var_4)) {
    foreach(var_7, var_6 in var_4) {
      if(isDefined(var_4[var_7]) && isDefined(var_4[var_7][var_2])) {
        var_4[var_7][var_2] thread dodot_fadeoutblackout(0.1, 0);
      }
    }
  }

  var_1 notify("LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3);
}

ondeathdot_poisondamageplayer() {
  var_0 = self getentitynumber();

  foreach(var_2 in level.players) {
    var_3 = var_2.onenterdot_poisondamageoverlay;

    if(isDefined(var_3)) {
      foreach(var_6, var_5 in var_3) {
        if(isDefined(var_3[var_6]) && isDefined(var_3[var_6][var_0])) {
          var_3[var_6][var_0] thread dodot_fadeoutblackoutanddestroy();
        }
      }
    }
  }
}

dodot_poisondamage(var_0, var_1) {
  if(common_scripts\utility::issp()) {
    return;
  }
  self thread[[level.callbackplayerdamage]](var_0, var_0, var_1, 0, "MOD_SUICIDE", "claymore_mp", var_0.origin, (0, 0, 0) - var_0.origin, "none", 0);
  return;
}

dodot_poisonblackout(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = self getentitynumber();
  var_1 endon("death");
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2);
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_2);

  if(!isDefined(self.onenterdot_poisondamageoverlay)) {
    self.onenterdot_poisondamageoverlay = [];
  }

  if(!isDefined(self.onenterdot_poisondamageoverlay[var_0])) {
    self.onenterdot_poisondamageoverlay[var_0] = [];
  }

  if(!isDefined(self.onenterdot_poisondamageoverlay[var_0][var_2])) {
    var_4 = newclienthudelem(self);
    var_4.x = 0;
    var_4.y = 0;
    var_4.alignx = "left";
    var_4.aligny = "top";
    var_4.horzalign = "fullscreen";
    var_4.vertalign = "fullscreen";
    var_4.alpha = 0;
    var_4 setshader("black", 640, 480);
    self.onenterdot_poisondamageoverlay[var_0][var_2] = var_4;
  }

  var_4 = self.onenterdot_poisondamageoverlay[var_0][var_2];
  var_5 = 1;
  var_6 = 2;
  var_7 = 0.25;
  var_8 = 1;
  var_9 = 5;
  var_10 = 100;
  var_11 = 0;

  for(;;) {
    while(self.onenterdot_poisondamagecount[var_0][var_2] > 1) {
      var_12 = var_10 - var_9;
      var_11 = (self.onenterdot_poisondamagecount[var_0][var_2] - var_9) / var_12;

      if(var_11 < 0) {
        var_11 = 0;
      } else if(var_11 > 1) {
        var_11 = 1;
      }

      var_13 = var_6 - var_5;
      var_14 = var_5 + var_13 * (1 - var_11);
      var_15 = var_8 - var_7;
      var_16 = var_7 + var_15 * var_11;
      var_17 = var_11 * 0.5;

      if(var_11 == 1) {
        break;
      }

      var_18 = var_14 / 2;
      var_4 dodot_fadeinblackout(var_18, var_16);
      var_4 dodot_fadeoutblackout(var_18, var_17);
      wait(var_11 * 0.5);
    }

    if(var_11 == 1) {
      break;
    }

    if(var_4.alpha != 0) {
      var_4 dodot_fadeoutblackout(1, 0);
    }

    wait 0.05;
  }

  var_4 dodot_fadeinblackout(2, 0);
}

dodot_fadeinblackout(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  var_1 = undefined;
  wait(var_0);
}

dodot_fadeoutblackout(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  var_1 = undefined;
  wait(var_0);
}

dodot_fadeoutblackoutanddestroy(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  var_1 = undefined;
  wait(var_0);
  self destroy();
}

triggertouchthink(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self.entnum = self getentitynumber();

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2) && !isDefined(var_2.finished_spawning)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(!isDefined(var_2.touchtriggers[self.entnum])) {
      var_2 thread playertouchtriggerthink(self, var_0, var_1);
    }
  }
}

playertouchtriggerthink(var_0, var_1, var_2) {
  var_0 endon("death");

  if(!isPlayer(self)) {
    self endon("death");
  }

  if(!common_scripts\utility::issp()) {
    var_3 = self.guid;
  } else {
    var_3 = "player" + gettime();
  }

  var_0.touchlist[var_3] = self;

  if(isDefined(var_0.movetracker)) {
    self.movetrackers++;
  }

  var_0 notify("trigger_enter", self);
  self notify("trigger_enter", var_0);
  var_4 = 1;

  foreach(var_6 in var_0.dot_group) {
    foreach(var_8 in self.touchtriggers) {
      if(var_6 == var_8) {
        var_4 = 0;
      }
    }
  }

  if(var_4 && isDefined(var_1)) {
    self thread[[var_1]](var_0);
  }

  self.touchtriggers[var_0.entnum] = var_0;

  while(isalive(self) && (common_scripts\utility::issp() || !level.gameended)) {
    var_11 = 1;

    if(self istouching(var_0)) {
      wait 0.05;
    } else {
      if(!var_0.dot_group.size) {
        var_11 = 0;
      }

      foreach(var_6 in var_0.dot_group) {
        if(self istouching(var_6)) {
          wait 0.05;
          break;
        } else {
          var_11 = 0;
        }
      }
    }

    if(!var_11) {
      break;
    }
  }

  if(isDefined(self)) {
    self.touchtriggers[var_0.entnum] = undefined;

    if(isDefined(var_0.movetracker)) {
      self.movetrackers--;
    }

    self notify("trigger_leave", var_0);

    if(var_4 && isDefined(var_2)) {
      self thread[[var_2]](var_0);
    }
  }

  if(!common_scripts\utility::issp() && level.gameended) {
    return;
  }
  var_0.touchlist[var_3] = undefined;
  var_0 notify("trigger_leave", self);

  if(!anythingtouchingtrigger(var_0)) {
    var_0 notify("trigger_empty");
  }
}

anythingtouchingtrigger(var_0) {
  return var_0.touchlist.size;
}

get_precached_anim(var_0) {
  return level._destructible_preanims[var_0];
}

get_precached_animtree(var_0) {
  return level._destructible_preanimtree[var_0];
}

destructiblecoverwatcher() {
  if(!isDefined(level.player)) {
    return;
  }
  if(!isDefined(self.script_dest_cover_dmg_dist)) {
    self.script_dest_cover_dmg_dist = 20000;
  }

  while(isDefined(self)) {
    if(isDefined(self.destructible_parts)) {
      var_0 = 0;

      for(var_1 = 1; var_1 < self.destructible_parts.size; var_1++) {
        if(self.destructible_parts[var_1].v["currentState"] == 1) {
          var_0++;
        }
      }

      if(var_0 == self.destructible_parts.size - 1) {
        break;
      }
    }

    var_2 = distancesquared(level.player.origin, self.origin);

    if(var_2 > self.script_dest_cover_dmg_dist * self.script_dest_cover_dmg_dist) {
      self setCanDamage(0);
    } else {
      self setCanDamage(1);
    }

    wait 0.05;
  }
}