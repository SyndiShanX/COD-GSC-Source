/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_sidequests.gsc
***************************************************/

init() {
  if(!isDefined(level._sidequest_icons_base_x)) {
    level._sidequest_icons_base_x = 110;
  }

  if(!isDefined(level._sidequest_icons_base_y)) {
    level._sidequest_icons_base_y = -10;
  }

  if(!isDefined(level._sidequest_counter_base_x)) {
    level._sidequest_counter_base_x = 40;
  }

  if(!isDefined(level._sidequest_counter_base_y)) {
    level._sidequest_counter_base_y = -15;
  }

  if(!isDefined(level._zombie_sidequests)) {
    level._zombie_sidequests = [];
  }
}

sidequest_uses_teleportation(var_0) {
  level._zombie_sidequests[var_0].uses_teleportation = 1;
}

declare_sidequest_icon(var_0, var_1, var_2) {
  var_3 = level._zombie_sidequests[var_0];
  var_3.icons[var_1] = var_2;
}

create_icon(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.foreground = 1;
  var_3.sort = 2;
  var_3.hidewheninmenu = 0;
  var_3.alignx = "left";
  var_3.aligny = "bottom";
  var_3.horzalign = "left";
  var_3.vertalign = "bottom";
  var_3.x = var_1;
  var_3.y = var_2;
  var_3.alpha = 1;
  var_3 setshader(var_0, 32, 32);
  return var_3;
}

create_counter_hud(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.foreground = 1;
  var_2.sort = 2;
  var_2.hidewheninmenu = 0;
  var_2.alignx = "left";
  var_2.aligny = "bottom";
  var_2.horzalign = "left";
  var_2.vertalign = "bottom";
  var_2.font = "small";
  var_2.fontscale = 1.5;
  var_2.x = level._sidequest_counter_base_x;
  var_2.y = level._sidequest_counter_base_y;
  var_2.alpha = 1;
  var_2 settext(var_0);
  var_2 setvalue(var_1);
  return var_2;
}

create_text_hud(var_0) {
  var_1 = newclienthudelem(self);
  var_1.foreground = 1;
  var_1.sort = 2;
  var_1.hidewheninmenu = 0;
  var_1.alignx = "left";
  var_1.aligny = "bottom";
  var_1.horzalign = "left";
  var_1.vertalign = "bottom";
  var_1.font = "small";
  var_1.fontscale = 1.5;
  var_1.x = level._sidequest_counter_base_x;
  var_1.y = level._sidequest_counter_base_y;
  var_1.alpha = 1;
  var_1 settext(var_0);
  return var_1;
}

add_sidequest_icon(var_0, var_1) {
  if(!isDefined(self.sidequest_icons)) {
    self.sidequest_icons = [];
  }

  if(isDefined(self.sidequest_icons[var_1])) {
    return;
  }
  var_2 = level._zombie_sidequests[var_0];
  var_3 = level._sidequest_icons_base_x;

  if(isDefined(level._zombiemode_sidequest_icon_offset)) {
    var_3 = var_3 + level._zombiemode_sidequest_icon_offset;
  }

  var_4 = level._sidequest_icons_base_y;
  self.sidequest_icons[var_1] = create_icon(var_2.icons[var_1], var_3 + self.sidequest_icons.size * 34, var_4);
}

remove_sidequest_icon(var_0, var_1) {
  if(!isDefined(self.sidequest_icons)) {
    return;
  }
  if(!isDefined(self.sidequest_icons[var_1])) {
    return;
  }
  var_2 = self.sidequest_icons[var_1];
  var_3 = [];
  var_4 = getarraykeys(self.sidequest_icons);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] != var_1) {
      var_3[var_4[var_5]] = self.sidequest_icons[var_4[var_5]];
    }
  }

  self.sidequest_icons = var_3;
  var_2 destroy();
  var_4 = getarraykeys(self.sidequest_icons);
  var_6 = level._sidequest_icons_base_x;

  if(isDefined(level._zombiemode_sidequest_icon_offset)) {
    var_6 = var_6 + level._zombiemode_sidequest_icon_offset;
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    self.sidequest_icons[var_4[var_5]].x = var_6 + var_5 * 34;
  }
}

declare_sidequest(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level._zombie_sidequests)) {
    init();
  }

  var_7 = spawnStruct();
  var_7.name = var_0;
  var_7.stages = [];
  var_7.last_completed_stage = -1;
  var_7.active_stage = -1;
  var_7.sidequest_complete = 0;
  var_7.init_func = var_1;
  var_7.logic_func = var_2;
  var_7.complete_func = var_3;
  var_7.generic_stage_start_func = var_4;
  var_7.generic_stage_end_func = var_5;
  var_7.assets = [];
  var_7.uses_teleportation = 0;
  var_7.active_assets = [];
  var_7.icons = [];
  var_7.num_reps = 0;
  level._zombie_sidequests[var_0] = var_7;
}

declare_sidequest_stage(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6.stage_number = level._zombie_sidequests[var_0].stages.size;
  var_6.assets = [];
  var_6.active_assets = [];
  var_6.logic_func = var_3;
  var_6.init_func = var_2;
  var_6.exit_func = var_4;
  var_6.completed = 0;
  var_6.time_limit = 0;
  level._zombie_sidequests[var_0].stages[var_1] = var_6;
}

set_stage_time_limit(var_0, var_1, var_2, var_3) {
  level._zombie_sidequests[var_0].stages[var_1].time_limit = var_2;
  level._zombie_sidequests[var_0].stages[var_1].time_limit_func = var_3;
}

declare_stage_asset_from_struct(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::getstructarray(var_2, "targetname");

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = spawnStruct();
    var_7.type = "struct";
    var_7.struct = var_5[var_6];
    var_7.thread_func = var_3;
    var_7.trigger_thread_func = var_4;
    level._zombie_sidequests[var_0].stages[var_1].assets[level._zombie_sidequests[var_0].stages[var_1].assets.size] = var_7;
  }
}

declare_stage_asset(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_2, "targetname");

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = spawnStruct();
    var_7.type = "entity";
    var_7.ent = var_5[var_6];
    var_7.thread_func = var_3;
    var_7.trigger_thread_func = var_4;
    level._zombie_sidequests[var_0].stages[var_1].assets[level._zombie_sidequests[var_0].stages[var_1].assets.size] = var_7;
  }
}

declare_sidequest_asset(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_1, "targetname");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = spawnStruct();
    var_6.type = "entity";
    var_6.ent = var_4[var_5];
    var_6.thread_func = var_2;
    var_6.trigger_thread_func = var_3;
    var_6.ent.thread_func = var_2;
    var_6.ent.trigger_thread_func = var_3;
    level._zombie_sidequests[var_0].assets[level._zombie_sidequests[var_0].assets.size] = var_6;
  }
}

declare_sidequest_asset_from_struct(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstructarray(var_1, "targetname");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = spawnStruct();
    var_6.type = "struct";
    var_6.struct = var_4[var_5];
    var_6.thread_func = var_2;
    var_6.trigger_thread_func = var_3;
    level._zombie_sidequests[var_0].assets[level._zombie_sidequests[var_0].assets.size] = var_6;
  }
}

build_asset_from_struct(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);

  if(isDefined(var_0.model)) {
    var_2 setModel(var_0.model);
  }

  if(isDefined(var_0.angles)) {
    var_2.angles = var_0.angles;
  }

  var_2.script_noteworthy = var_0.script_noteworthy;
  var_2.type = "struct";
  var_2.radius = var_0.radius;
  var_2.thread_func = var_1.thread_func;
  var_2.trigger_thread_func = var_1.trigger_thread_func;
  var_2.script_vector = var_1.script_vector;
  var_0.trigger_thread_func = var_1.trigger_thread_func;
  var_0.script_vector = var_1.script_vector;
  var_2.target = var_0.target;
  var_2.script_float = var_0.script_float;
  var_2.script_int = var_0.script_int;
  var_2.script_trigger_spawnflags = var_0.script_trigger_spawnflags;
  var_2.targetname = var_0.targetname;
  return var_2;
}

delete_stage_assets() {
  for(var_0 = 0; var_0 < self.active_assets.size; var_0++) {
    var_1 = self.active_assets[var_0];

    switch (var_1.type) {
      case "struct":
        if(isDefined(var_1.trigger)) {
          var_1.trigger delete();
          var_1.trigger = undefined;
        }

        var_1 delete();
        break;
      case "entity":
        if(isDefined(var_1.trigger)) {
          var_1.trigger delete();
          var_1.trigger = undefined;
        }

        break;
    }
  }

  var_2 = [];

  for(var_0 = 0; var_0 < self.active_assets.size; var_0++) {
    if(isDefined(self.active_assets[var_0])) {
      var_2[var_2.size] = self.active_assets[var_0];
    }
  }

  self.active_assets = var_2;
}

build_assets() {
  for(var_0 = 0; var_0 < self.assets.size; var_0++) {
    var_1 = undefined;

    switch (self.assets[var_0].type) {
      case "struct":
        var_1 = self.assets[var_0].struct;
        self.active_assets[self.active_assets.size] = build_asset_from_struct(var_1, self.assets[var_0]);
        break;
      case "entity":
        for(var_2 = 0; var_2 < self.active_assets.size; var_2++) {
          if(self.active_assets[var_2] == self.assets[var_0].ent) {
            var_1 = self.active_assets[var_2];
            break;
          }
        }

        var_1 = self.assets[var_0].ent;
        var_1.type = "entity";
        self.active_assets[self.active_assets.size] = var_1;
        break;
      default:
        break;
    }

    if(isDefined(var_1.script_noteworthy) && (self.assets[var_0].type == "entity" && !isDefined(var_1.trigger)) || isDefined(var_1.script_noteworthy)) {
      var_3 = 15;
      var_4 = 72;

      if(isDefined(var_1.radius)) {
        var_3 = var_1.radius;
      }

      if(isDefined(var_1.height)) {
        var_4 = var_1.height;
      }

      var_5 = 0;

      if(isDefined(var_1.script_trigger_spawnflags)) {
        var_5 = var_1.script_trigger_spawnflags;
      }

      var_6 = (0, 0, 0);

      if(isDefined(var_1.script_vector)) {
        var_6 = var_1.script_vector;
      }

      switch (var_1.script_noteworthy) {
        case "trigger_radius_use":
          var_7 = spawn("trigger_radius_use", var_1.origin + var_6, var_5, var_3, var_4);
          var_7 setcursorhint("HINT_NOICON");

          if(isDefined(var_1.radius)) {
            var_7.radius = var_1.radius;
          }

          var_7.owner_ent = self.active_assets[self.active_assets.size - 1];

          if(isDefined(var_1.trigger_thread_func)) {
            var_7 thread[[var_1.trigger_thread_func]]();
          } else {
            var_7 thread use_trigger_thread();
          }

          self.active_assets[self.active_assets.size - 1].trigger = var_7;
          break;
        case "trigger_radius_damage":
          var_8 = spawn("trigger_damage", var_1.origin + var_6, var_5, var_3, var_4);

          if(isDefined(var_1.radius)) {
            var_8.radius = var_1.radius;
          }

          var_8.owner_ent = self.active_assets[self.active_assets.size - 1];

          if(isDefined(var_1.trigger_thread_func)) {
            var_8 thread[[var_1.trigger_thread_func]]();
          } else {
            var_8 thread damage_trigger_thread();
          }

          self.active_assets[self.active_assets.size - 1].trigger = var_8;
          break;
        case "trigger_radius":
          var_9 = spawn("trigger_radius", var_1.origin + var_6, var_5, var_3, var_4);

          if(isDefined(var_1.radius)) {
            var_9.radius = var_1.radius;
          }

          var_9.owner_ent = self.active_assets[self.active_assets.size - 1];

          if(isDefined(var_1.trigger_thread_func)) {
            var_9 thread[[var_1.trigger_thread_func]]();
          } else {
            var_9 thread radius_trigger_thread();
          }

          self.active_assets[self.active_assets.size - 1].trigger = var_9;
          break;
      }
    }

    if(isDefined(self.assets[var_0].thread_func) && !isDefined(self.active_assets[self.active_assets.size - 1].dont_rethread)) {
      self.active_assets[self.active_assets.size - 1] thread[[self.assets[var_0].thread_func]]();
    }

    if(var_0 % 2 == 0) {
      maps\mp\zombies\_util::waitnetworkframe();
    }
  }
}

damage_trigger_thread() {
  self endon("death");

  for(;;) {
    self waittill("damage");
    self.owner_ent notify("triggered");
  }
}

radius_trigger_thread() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isplayer(var_0)) {
      continue;
    }
    self.owner_ent notify("triggered");

    while(var_0 istouching(self)) {
      wait 0.05;
    }

    self.owner_ent notify("untriggered");
  }
}

thread_on_assets(var_0, var_1) {
  for(var_2 = 0; var_2 < self.active_assets.size; var_2++) {
    if(self.active_assets[var_2].targetname == var_0) {
      self.active_assets[var_2] thread[[var_1]]();
    }
  }
}

stage_logic_func_wrapper(var_0, var_1) {
  if(isDefined(var_1.logic_func)) {
    level endon(var_0.name + "_" + var_1.name + "_over");
    var_1[[var_1.logic_func]]();
  }
}

sidequest_start(var_0) {
  var_1 = level._zombie_sidequests[var_0];
  var_1 build_assets();

  if(isDefined(var_1.init_func)) {
    var_1[[var_1.init_func]]();
  }

  if(isDefined(var_1.logic_func)) {
    var_1 thread[[var_1.logic_func]]();
  }
}

stage_start(var_0, var_1) {
  if(isstring(var_0)) {
    var_0 = level._zombie_sidequests[var_0];
  }

  if(isstring(var_1)) {
    var_1 = var_0.stages[var_1];
  }

  var_1 build_assets();
  var_0.active_stage = var_1.stage_number;
  level notify(var_0.name + "_" + var_1.name + "_started");
  var_1.completed = 0;

  if(isDefined(var_0.generic_stage_start_func)) {
    var_1[[var_0.generic_stage_start_func]]();
  }

  if(isDefined(var_1.init_func)) {
    var_1[[var_1.init_func]]();
  }

  level thread stage_logic_func_wrapper(var_0, var_1);

  if(var_1.time_limit > 0) {
    var_1 thread time_limited_stage(var_0);
  }

  if(isDefined(var_1.title)) {
    var_1 thread display_stage_title(var_0.uses_teleportation);
  }
}

display_stage_title(var_0) {
  if(var_0) {
    level waittill("teleport_done");
    wait 2.0;
  }

  var_1 = newhudelem();
  var_1.location = 0;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.foreground = 1;
  var_1.fontscale = 1.6;
  var_1.sort = 20;
  var_1.x = 320;
  var_1.y = 300;
  var_1.og_scale = 1;
  var_1.color = (128, 0, 0);
  var_1.alpha = 0;
  var_1.fontstyle3d = "shadowedmore";
  var_1 settext(self.title);
  var_1 fadeovertime(0.5);
  var_1.alpha = 1;
  wait 5.0;
  var_1 fadeovertime(1.0);
  var_1.alpha = 0;
  wait 1.0;
  var_1 destroy();
}

time_limited_stage(var_0) {
  level endon(var_0.name + "_" + self.name + "_over");
  level endon("suspend_timer");
  level endon("end_game");
  var_1 = undefined;

  if(isDefined(self.time_limit_func)) {
    var_1 = [[self.time_limit_func]]() * 0.25;
  } else {
    var_1 = self.time_limit * 0.25;
  }

  wait(var_1);
  level notify("timed_stage_75_percent");
  wait(var_1);
  level notify("timed_stage_50_percent");
  wait(var_1);
  level notify("timed_stage_25_percent");
  wait(var_1 - 10);
  level notify("timed_stage_10_seconds_to_go");
  wait 10;
  stage_failed(var_0, self);
}

sidequest_println(var_0) {}

sidequest_iprintlnbold(var_0) {}

sidequest_complete(var_0) {
  return level._zombie_sidequests[var_0].sidequest_complete;
}

stage_completed(var_0, var_1) {
  var_2 = level._zombie_sidequests[var_0];
  var_3 = var_2.stages[var_1];
  level thread stage_completed_internal(var_2, var_3);
}

stage_completed_internal(var_0, var_1) {
  level notify(var_0.name + "_" + var_1.name + "_over");
  level notify(var_0.name + "_" + var_1.name + "_completed");

  if(isDefined(var_0.generic_stage_end_func)) {
    var_1[[var_0.generic_stage_end_func]]();
  }

  if(isDefined(var_1.exit_func)) {
    var_1[[var_1.exit_func]](1);
  }

  var_1.completed = 1;
  var_0.last_completed_stage = var_0.active_stage;
  var_0.active_stage = -1;
  var_1 delete_stage_assets();
  var_2 = 1;
  var_3 = getarraykeys(var_0.stages);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_0.stages[var_3[var_4]].completed == 0) {
      var_2 = 0;
      break;
    }
  }

  if(var_2 == 1) {
    if(isDefined(var_0.complete_func)) {
      var_0 thread[[var_0.complete_func]]();
    }

    level notify("sidequest_" + var_0.name + "_complete");
    var_0.sidequest_completed = 1;
  }
}

stage_failed_internal(var_0, var_1) {
  level notify(var_0.name + "_" + var_1.name + "_over");
  level notify(var_0.name + "_" + var_1.name + "_failed");

  if(isDefined(var_0.generic_stage_end_func)) {
    var_1[[var_0.generic_stage_end_func]]();
  }

  if(isDefined(var_1.exit_func)) {
    var_1[[var_1.exit_func]](0);
  }

  var_0.active_stage = -1;
  var_1 delete_stage_assets();
}

stage_failed(var_0, var_1) {
  if(isstring(var_0)) {
    var_0 = level._zombie_sidequests[var_0];
  }

  if(isstring(var_1)) {
    var_1 = var_0.stages[var_1];
  }

  level thread stage_failed_internal(var_0, var_1);
}

get_sidequest_stage(var_0, var_1) {
  var_2 = undefined;
  var_3 = getarraykeys(var_0.stages);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_0.stages[var_3[var_4]].stage_number == var_1) {
      var_2 = var_0.stages[var_3[var_4]];
      break;
    }
  }

  return var_2;
}

get_damage_trigger(var_0, var_1, var_2) {
  var_3 = spawn("trigger_damage", var_1, 0, var_0, 72);
  var_3 thread dam_trigger_thread(var_2);
  return var_3;
}

dam_trigger_thread(var_0) {
  self endon("death");
  var_1 = "NONE";

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    for(var_7 = 0; var_7 < var_0.size; var_7++) {
      if(var_6 == var_0[var_7]) {
        self notify("triggered");
      }
    }
  }
}

use_trigger_thread() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    self.owner_ent notify("triggered", var_0);
    wait 0.1;
  }
}

sidequest_stage_active(var_0, var_1) {
  var_2 = level._zombie_sidequests[var_0];
  var_3 = var_2.stages[var_1];

  if(var_2.active_stage == var_3.stage_number) {
    return 1;
  } else {
    return 0;
  }
}

sidequest_start_next_stage(var_0) {
  var_1 = level._zombie_sidequests[var_0];

  if(var_1.sidequest_complete == 1) {
    return;
  }
  var_2 = var_1.last_completed_stage;

  if(var_2 == -1) {
    var_2 = 0;
  } else {
    var_2++;
  }

  var_3 = get_sidequest_stage(var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  stage_start(var_1, var_3);
  return var_3;
}

is_facing(var_0) {
  var_1 = self getangles();
  var_2 = anglesToForward(var_1);
  var_3 = (var_2[0], var_2[1], 0);
  var_4 = vectornormalize(var_3);
  var_5 = var_0.origin - self.origin;
  var_6 = (var_5[0], var_5[1], 0);
  var_7 = vectornormalize(var_6);
  var_8 = vectordot(var_4, var_7);
  return var_8 > 0.9;
}

is_facing_3d(var_0) {
  var_1 = self getangles();
  var_2 = anglesToForward(var_1);
  var_3 = vectornormalize(var_2);
  var_4 = var_0.origin - self getEye();
  var_5 = vectornormalize(var_4);
  var_6 = vectordot(var_3, var_5);
  return var_6 > 0.9;
}

fake_use(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3)) {
    level endon(var_3);
  }

  waittillframeend;

  if(!isDefined(var_4)) {
    var_4 = 64;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = var_4 * var_4;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      if(distancesquared(self.origin, level.players[var_7].origin) < var_6 && (!var_5 && level.players[var_7] is_facing(self) || var_5 && level.players[var_7] is_facing_3d(self))) {
        if(level.players[var_7] usebuttonpressed()) {
          var_8 = 1;

          if(isDefined(var_1) && isDefined(var_2)) {
            var_8 = level.players[var_7][
              }
              [var_1]
          ](var_2);
          else if(isDefined(var_1)) {
            var_8 = level.players[var_7][
              }
              [var_1]
          ]();

          if(var_8) {
            self notify(var_0, level.players[var_7]);
            return level.players[var_7];
          }
        }
      }
    }

    wait 0.1;
  }
}

register_sidequest(var_0, var_1) {}

is_sidequest_previously_completed(var_0) {
  return maps\mp\zombies\_util::is_true(level.zombie_sidequest_previously_completed[var_0]);
}

set_sidequest_completed(var_0) {}