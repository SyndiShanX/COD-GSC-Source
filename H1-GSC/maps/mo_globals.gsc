/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mo_globals.gsc
********************************/

main(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  level.level_name = var_0;

  switch (var_0) {
    case "descent":
      level.strings["hint_detpack"] = & "DESCENT_HINTSTR_DETPACK";
      precachestring(level.strings["hint_detpack"]);
      break;
  }

  friendly_main();
  ai_generic_main();
  misc_main();
  interactive_main();
}

ai_generic_main() {
  var_0 = getspawnerarray();
  common_scripts\utility::array_thread(var_0, ::ai_special_parameters);
}

ai_special_parameters() {
  if(isdefined(self.target) && isdefined(self.script_forcecolor))
    thread ai_nodebeforecolor_think();

  if(!isdefined(self.script_parameters)) {
    return;
  }
  var_0 = strtok(self.script_parameters, ":;, ");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(tolower(var_0[var_1]) == "ignoreme") {
      var_1++;

      if(int(var_0[var_1]) == 0) {
        self.stopignorenotifyent = var_0[var_1];
        var_1++;
        self.stopignorenotifymsg = var_0[var_1];
        thread ai_ignoreme_think();
      } else {
        self.stopignoretime = int(var_0[var_1]);
        thread ai_ignoreme_think();
      }

      continue;
    }

    if(tolower(var_0[var_1]) == "setforcegoal") {
      var_1++;

      if(int(var_0[var_1]) == 0) {
        self.stopforcegoalnotifyent = var_0[var_1];
        var_1++;
        self.stopforcegoalnotifymsg = var_0[var_1];
        thread ai_setforcegoal_think();
      } else {
        self.stopforcegoaltime = int(var_0[var_1]);
        thread ai_setforcegoal_think();
      }

      continue;
    }

    if(tolower(var_0[var_1]) == "setforcecolor") {
      var_1++;
      self.setforcecolorvalue = var_0[var_1];
      var_1++;

      if(int(var_0[var_1]) == 0) {
        self.setforcecolornotifyent = var_0[var_1];
        var_1++;
        self.setforcecolornotifymsg = var_0[var_1];
        thread ai_setforcecolor_think();
      } else {
        self.setforcecolortime = int(var_0[var_1]);
        thread ai_setforcecolor_think();
      }

      continue;
    }

    if(tolower(var_0[var_1]) == "magicbulletshield") {
      var_1++;

      if(int(var_0[var_1]) == 0) {
        self.stopbulletshieldnotifyent = var_0[var_1];
        var_1++;
        self.stopbulletshieldnotifymsg = var_0[var_1];
        thread ai_magicbulletshield_think();
      } else {
        self.stopbulletshieldtime = int(var_0[var_1]);
        thread ai_magicbulletshield_think();
      }

      continue;
    }

    if(tolower(var_0[var_1]) == "floodspawner") {
      var_1++;
      self.floodspawncount = int(var_0[var_1]);
      thread ai_floodspawn_think();
      continue;
    }

    if(tolower(var_0[var_1]) == "forcespawn") {
      self.forcespawn = 1;
      continue;
    }

    if(tolower(var_0[var_1]) == "nobackup")
      self.no_check_wave = 1;
  }
}

ai_nodebeforecolor_think() {
  var_0 = getnode(self.target, "targetname");

  if(!isdefined(var_0)) {
    return;
  }
  self endon("death");

  for (;;) {
    self waittill("spawned", var_1);

    if(maps\_utility::spawn_failed(var_1)) {
      continue;
    }
    break;
  }

  wait 0.05;
  var_1 setgoalnode(var_0);

  if(isdefined(var_0.radius))
    var_1.goalradius = var_0.radius;
}

ai_floodspawn_think() {
  self endon("death");

  for (;;) {
    self waittill("spawned", var_0);

    if(maps\_utility::spawn_failed(var_0)) {
      continue;
    }
    self.floodspawncount--;
    break;
  }

  while (self.floodspawncount > 0) {
    var_0 waittill("death");
    self.count = 1;

    if(isdefined(var_0)) {
      if(!maps\_utility::script_wait())
        wait(randomfloatrange(5, 9));
    }

    for (;;) {
      if(isdefined(self.forcespawn))
        var_0 = self stalingradspawn();
      else
        var_0 = self dospawn();

      if(!maps\_utility::spawn_failed(var_0)) {
        self.floodspawncount--;
        break;
      }

      wait 1;
    }
  }

  waittillframeend;
  self delete();
}

ai_magicbulletshield_think() {
  self endon("death");

  for (;;) {
    self waittill("spawned", var_0);

    if(maps\_utility::spawn_failed(var_0)) {
      continue;
    }
    if(isdefined(self.stopbulletshieldtime))
      var_0.stopbulletshieldtime = self.stopbulletshieldtime;
    else if(isdefined(self.stopbulletshieldnotifymsg)) {
      var_0.stopbulletshieldnotifyent = self.stopbulletshieldnotifyent;
      var_0.stopbulletshieldnotifymsg = self.stopbulletshieldnotifymsg;
    } else {

    }

    var_0 thread ai_magicbulletshield_think2();
  }
}

ai_magicbulletshield_think2() {
  self endon("death");
  self endon("internal_stop_magic_bullet_shield");
  thread maps\_utility::magic_bullet_shield();

  if(isdefined(self.stopforcegoaltime))
    wait(self.stopforcegoaltime);
  else if(isdefined(self.stopforcegoalnotifymsg)) {
    if(tolower(self.stopforcegoalnotifyent) == "self")
      self waittill(self.stopforcegoalnotifymsg);
    else if(tolower(self.stopforcegoalnotifyent) == "level")
      level waittill(self.stopforcegoalnotifymsg);
    else {

    }
  } else
    return;

  maps\_utility::stop_magic_bullet_shield();
}

ai_setforcecolor_think() {
  self endon("death");

  for (;;) {
    self waittill("spawned", var_0);

    if(maps\_utility::spawn_failed(var_0)) {
      continue;
    }
    var_0.setforcecolorvalue = self.setforcecolorvalue;

    if(isdefined(self.setforcecolortime))
      var_0.setforcecolortime = self.setforcecolortime;
    else if(isdefined(self.setforcecolornotifymsg)) {
      var_0.setforcecolornotifyent = self.setforcecolornotifyent;
      var_0.setforcecolornotifymsg = self.setforcecolornotifymsg;
    } else {

    }

    var_0 thread ai_setforcecolor_think2();
  }
}

ai_setforcecolor_think2() {
  self endon("death");

  if(isdefined(self.setforcecolortime))
    wait(self.setforcecolortime);
  else if(isdefined(self.setforcecolornotifymsg)) {
    if(tolower(self.setforcecolornotifyent) == "self")
      self waittill(self.setforcecolornotifymsg);
    else if(tolower(self.setforcecolornotifyent) == "level")
      level waittill(self.setforcecolornotifymsg);
    else {

    }
  }

  maps\_utility::set_force_color(self.setforcecolorvalue);
}

ai_setforcegoal_think() {
  self endon("death");

  for (;;) {
    self waittill("spawned", var_0);

    if(maps\_utility::spawn_failed(var_0)) {
      continue;
    }
    if(isdefined(self.stopforcegoaltime))
      var_0.stopforcegoaltime = self.stopforcegoaltime;
    else if(isdefined(self.stopforcegoalnotifymsg)) {
      var_0.stopforcegoalnotifyent = self.stopforcegoalnotifyent;
      var_0.stopforcegoalnotifymsg = self.stopforcegoalnotifymsg;
    } else {

    }

    var_0 thread ai_setforcegoal_think2();
  }
}

ai_setforcegoal_think2() {
  self endon("death");
  maps\_utility::set_forcegoal();

  if(isdefined(self.stopforcegoaltime))
    wait(self.stopforcegoaltime);
  else if(isdefined(self.stopforcegoalnotifymsg)) {
    if(tolower(self.stopforcegoalnotifyent) == "self")
      self waittill(self.stopforcegoalnotifymsg);
    else if(tolower(self.stopforcegoalnotifyent) == "level")
      level waittill(self.stopforcegoalnotifymsg);
    else {

    }
  }

  maps\_utility::unset_forcegoal();
}

ai_ignoreme_think() {
  self endon("death");

  for (;;) {
    self waittill("spawned", var_0);

    if(maps\_utility::spawn_failed(var_0)) {
      continue;
    }
    if(isdefined(self.stopignoretime))
      var_0.stopignoretime = self.stopignoretime;
    else if(isdefined(self.stopignorenotifymsg)) {
      var_0.stopignorenotifyent = self.stopignorenotifyent;
      var_0.stopignorenotifymsg = self.stopignorenotifymsg;
    } else {

    }

    var_0 thread ai_ignoreme_think2();
  }
}

ai_ignoreme_think2() {
  self endon("death");
  self.ignoreme = 1;

  if(isdefined(self.stopignoretime))
    wait(self.stopignoretime);
  else if(isdefined(self.stopignorenotifymsg)) {
    if(tolower(self.stopignorenotifyent) == "self")
      self waittill(self.stopignorenotifymsg);
    else if(tolower(self.stopignorenotifyent) == "level")
      level waittill(self.stopignorenotifymsg);
    else {

    }
  }

  self.ignoreme = 0;
}

friendly_main() {
  level.friendly_globals = spawnstruct();
  level.friendly_globals.max_num = 4;
  level.friendly_globals.wav_num = 2;
  level.friendly_globals.cur_num = 0;
  level.friendly_globals.force_this_color = [];
  var_0 = getentarray("friendly_spawner", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::friendly_trigger_think);
  thread friendly_logic();
}

friendly_logic() {
  for (;;) {
    level waittill("friendly_globals_check_wave");
    var_0 = level.friendly_globals.max_num - level.friendly_globals.cur_num;

    if(var_0 < level.friendly_globals.wav_num && !(isdefined(level.fastrope_globals.heli_inflight) && level.fastrope_globals.heli_inflight == 1)) {
      continue;
    }
    for (var_1 = 0; var_1 < var_0; var_1++) {
      var_2 = level.friendly_globals.curr_trigger friendly_cycle_spawner();
      var_2 thread friendly_spawner_think();
    }
  }
}

friendly_cycle_spawner() {
  var_0 = self.spawner_index;

  for (;;) {
    self.spawner_index++;

    if(self.spawner_array.size == self.spawner_index)
      self.spawner_index = 0;

    if(!level.friendly_globals.force_this_color.size) {
      break;
    }

    if(self.spawner_array[self.spawner_index] maps\_utility::check_force_color(level.friendly_globals.force_this_color[level.friendly_globals.force_this_color.size - 1])) {
      level.friendly_globals.force_this_color = common_scripts\utility::array_remove(level.friendly_globals.force_this_color, level.friendly_globals.force_this_color[level.friendly_globals.force_this_color.size - 1]);
      break;
    }

    if(var_0 == self.spawner_index) {
      self.spawner_index++;

      if(self.spawner_array.size == self.spawner_index)
        self.spawner_index = 0;

      break;
    }
  }

  return self.spawner_array[self.spawner_index];
}

friendly_spawner_think() {
  self endon("death");
  self.count = 1;
  var_0 = self dospawn();

  if(maps\_utility::spawn_failed(var_0)) {
    return;
  }
  level.friendly_globals.cur_num++;

  if(isdefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "repel_friendlies") {
      var_1 = common_scripts\utility::getstruct(self.targetname, "target");
      var_0 thread friendly_repel_spawner_think(var_1);
    }
  }

  thread friendly_spawner_death(var_0);
  return var_0;
}

friendly_spawner_death(var_0) {
  self endon("death");
  var_0 common_scripts\utility::waittill_any("death", "get_off_friendly_logic");

  if(isdefined(self.force_this_color))
    level.friendly_globals.force_this_color[level.friendly_globals.force_this_color.size] = self.force_this_color;

  level.friendly_globals.cur_num--;

  if(isdefined(self.no_check_wave)) {
    return;
  }
  level notify("friendly_globals_check_wave");
}

#using_animtree("generic_human");

friendly_repel_animload() {
  if(isdefined(level.global_repel_anims_loaded)) {
    return;
  }
  level.scr_anim["repel_friendly"]["rappel"] = % rappel;
  level.scr_anim["repel_friendly"]["aim"][0] = % stand_aim_straight;
  level.global_repel_anims_loaded = 1;
}

friendly_repel_spawner_think(var_0) {
  self endon("death");
  self.animname = "repel_friendly";
  thread maps\_anim::anim_loop_solo(self, "aim", undefined, "stop_aim");
  wait(randomfloat(1));
  self notify("stop_aim");
  var_0 thread maps\_anim::anim_single_solo(self, "rappel");
}

friendly_force_spawner_think(var_0) {
  for (;;) {
    var_0 waittill("trigger");
    thread friendly_spawner_think();
  }
}

friendly_trigger_think() {
  self.spawner_array = getentarray(self.targetname, "target");
  self.spawner_index = 0;

  for (var_0 = 0; var_0 < self.spawner_array.size; var_0++) {
    if(isdefined(self.spawner_array[var_0].script_parameters)) {
      var_1 = strtok(self.spawner_array[var_0].script_parameters, ":;, ");

      for (var_2 = 0; var_2 < var_1.size; var_2++) {
        if(tolower(var_1[var_2]) == "force_friendlies")
          self.spawner_array[var_0] thread friendly_force_spawner_think(self);

        if(tolower(var_1[var_2]) == "force_this_color") {
          var_2++;
          self.spawner_array[var_0].force_this_color = var_1[var_2];
        }
      }
    }

    if(isdefined(self.spawner_array[var_0].script_noteworthy) && self.spawner_array[var_0].script_noteworthy == "repel_friendlies")
      friendly_repel_animload();
  }

  self.max_num = self.spawner_array.size;
  self.wav_num = 0;

  if(isdefined(self.script_parameters)) {
    var_1 = strtok(self.script_parameters, ", ");

    switch (var_1.size) {
      case 2:
        self.max_num = int(var_1[1]);
      case 1:
        self.wav_num = int(var_1[0]);
    }
  }

  for (;;) {
    self waittill("trigger");

    if(isdefined(level.friendly_globals.curr_trigger))
      level.friendly_globals.curr_trigger common_scripts\utility::trigger_on();

    level.friendly_globals.curr_trigger = self;

    if(self.max_num > 0)
      level.friendly_globals.max_num = self.max_num;

    if(self.wav_num > 0)
      level.friendly_globals.wav_num = self.wav_num;

    level notify("friendly_globals_check_wave");
    common_scripts\utility::trigger_off();
  }
}

interactive_main() {
  var_0 = getentarray("crate_breakable", "targetname");
  var_0 thread interactive_precachefx();
  common_scripts\utility::array_thread(var_0, ::interactive_cratethink);
  var_1 = getentarray("interactive_cardboard_box", "targetname");
  var_1 thread interactive_precachefx();
  common_scripts\utility::array_thread(var_1, ::interactive_cardboardboxthink);
  var_2 = getentarray("wall_breakable", "targetname");
  var_2 thread interactive_precachefx();
  common_scripts\utility::array_thread(var_2, ::interactive_wallthink);
  var_3 = getentarray("fence_shootable", "targetname");
  var_3 thread interactive_precachefx();
  common_scripts\utility::array_thread(var_3, ::interactive_fencethink);
}

interactive_precachefx() {
  if(!self.size) {
    return;
  }
  if(self[0].targetname == "crate_breakable") {
    level._effect["exp_crate1"] = loadfx("props\crateExp_dust");
    level._effect["exp_crate2"] = loadfx("props\crateExp_ammo");
    return;
  }

  if(self[0].targetname == "wall_breakable") {
    level._effect["exp_wall"] = loadfx("props\wallExp_concrete");
    return;
  }

  if(self[0].targetname == "fence_shootable") {
    level._effect["fence"] = loadfx("impacts\small_metalhit_1");
    return;
  }
}

interactive_fencethink() {
  self setcandamage(1);

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3);
    var_4 = undefined;
    var_5 = var_3 + maps\_utility::vector_multiply(var_2, 1);
    var_6 = var_3 + maps\_utility::vector_multiply(var_2, 1024);
    magicbullet("mp5", var_5, var_6);
    playfx(level._effect["fence"], var_3, maps\_utility::vector_multiply(var_2, -1));
  }
}

interactive_wallthink() {
  self setcandamage(1);
  var_0 = undefined;
  var_1 = undefined;

  if(isdefined(self.target)) {
    var_1 = getent(self.target, "targetname");

    if(isdefined(var_1.script_noteworthy) && var_1.script_noteworthy == "doorframe") {
      var_2 = self getorigin();
      var_3 = undefined;

      if(distance(var_2, var_1.origin) < var_1.radius)
        var_3 = var_1.origin;
      else {
        var_0 = anglestoforward(var_1.angles);
        var_4 = maps\_utility::vector_multiply(var_0, 88);
        var_3 = var_1.origin + var_4;
      }

      var_0 = anglestoup(var_1.angles);
      var_4 = maps\_utility::vector_multiply(var_0, 64);
      var_5 = var_3 + var_4;
      var_4 = maps\_utility::vector_multiply(var_0, -64);
      var_6 = var_3 + var_4;
      var_0 = vectorfromlinetopoint(var_5, var_6, var_2);
    }

    if(isdefined(var_1.script_noteworthy) && var_1.script_noteworthy == "windowframe") {
      var_2 = self getorigin();
      var_3 = undefined;

      if(distance(var_2, var_1.origin) < var_1.radius)
        var_3 = var_1.origin;
      else {
        var_0 = anglestoforward(var_1.angles);
        var_4 = maps\_utility::vector_multiply(var_0, 72);
        var_3 = var_1.origin + var_4;
      }

      var_0 = anglestoup(var_1.angles);
      var_4 = maps\_utility::vector_multiply(var_0, 64);
      var_5 = var_3 + var_4;
      var_4 = maps\_utility::vector_multiply(var_0, -64);
      var_6 = var_3 + var_4;
      var_0 = vectorfromlinetopoint(var_5, var_6, var_2);
    } else {
      var_5 = var_1.origin;
      var_0 = anglestoforward(var_1.angles);
      var_0 = maps\_utility::vector_multiply(var_0, 128);
      var_6 = var_5 + var_0;
      var_2 = self getorigin();
      var_0 = vectorfromlinetopoint(var_5, var_6, var_2);
    }
  }

  wait 0.1;

  if(isdefined(var_1))
    var_1 delete();

  self waittill("damage", var_7, var_8, var_9, var_2);
  self delete();

  if(isdefined(var_0))
    playfx(level._effect["exp_wall"], var_2, var_0);
  else
    playfx(level._effect["exp_wall"], var_2);

  thread common_scripts\utility::play_sound_in_space("stone_wall_impact_med", var_2);
}

interactive_cardboardboxthink() {
  self setcandamage(1);
  var_0 = (0, 0, 1);
  var_1 = 5;

  for (;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(var_6 == "MOD_MELEE" || var_6 == "MOD_IMPACT") {
      continue;
    }
    var_7 = anglestoright(vectortoangles(var_4));
    var_0 = maps\_utility::vector_multiply(var_0, randomfloatrange(400, 600));
    var_8 = var_4;
    var_8 = maps\_utility::vector_multiply(var_8, 1.5);
    var_8 = var_8 + var_0;
    var_9 = maps\_utility::vector_multiply(var_5 - self.origin, 0.25);
    self physicslaunchclient(self.origin + var_9, var_8);
    break;
  }
}

interactive_cratethink() {
  self setcandamage(1);

  if(isdefined(self.target)) {
    self.debri = getent(self.target, "targetname");
    self.debri hide();
  }

  self waittill("damage", var_0, var_1);

  if(isdefined(self.debri))
    self.debri show();

  var_2 = randomint(5);

  if(var_2 > 0)
    playfx(level._effect["exp_crate1"], self.origin);
  else
    playfx(level._effect["exp_crate2"], self.origin);

  thread common_scripts\utility::play_sound_in_space("wood_crate_break_med", self.origin);
  var_3 = getentarray("crate_breakable", "targetname");

  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];
    var_6 = abs(self.origin[0] - var_5.origin[0]);
    var_7 = abs(self.origin[1] - var_5.origin[1]);

    if(var_6 <= 20 && var_7 <= 20) {
      var_8 = self.origin[2] - var_5.origin[2];

      if(var_8 <= 0)
        var_5 notify("damage", var_0, var_1);
    }
  }

  self delete();
}

misc_main() {
  var_0 = getentarray("autosave", "targetname");
  common_scripts\utility::array_thread(var_0, ::auto_save_think);
  var_1 = getentarray("wall_breach_check", "targetname");

  if(var_1.size) {
    precacheshader("hudStopwatch");
    precacheshader("hudStopwatchNeedle");
    precacheshader("objective");
  }

  common_scripts\utility::array_thread(var_1, ::wall_breach_think);
  level.scr_anim["player_link"]["loop"][0] = % bh_fastrope_loop;
  level.scr_anim["player_link"]["land"] = % bh_fastrope_land;
}

auto_save_think() {
  self waittill("trigger");

  if(isdefined(self.script_noteworthy))
    maps\_utility::autosave_by_name(self.script_noteworthy);
  else
    maps\_utility::autosave_by_name("default");
}

wall_breach_think() {
  var_0 = spawnstruct();
  var_0.on = self;
  var_0.off = getent(var_0.on.target, "targetname");
  var_0.obj_glow = getentarray(var_0.off.target, "targetname");
  var_0.obj_mdl = getentarray(var_0.obj_glow[0].target, "targetname");
  var_0.use_trig = getentarray(var_0.obj_mdl[0].target, "targetname");
  var_0.whole = getent(var_0.use_trig[0].target, "targetname");
  var_0.broken = getent(var_0.whole.target, "targetname");

  if(isdefined(var_0.broken.target))
    var_0.chain = getent(var_0.broken.target, "targetname");

  var_0.obj_glow[0] hide();
  var_0.obj_glow[1] hide();
  var_0.obj_mdl[0] hide();
  var_0.obj_mdl[1] hide();
  var_0.broken hide();
  var_0.whole disconnectpaths();
  var_0.use_trig[0].time = 4;
  var_0.use_trig[0] sethintstring(level.strings["hint_detpack"]);
  var_0.use_trig[1] sethintstring(level.strings["hint_detpack"]);
  var_0 endon("used");
  var_0 thread wall_breach_think2();

  for (;;) {
    var_0.on waittill("trigger");
    var_0 notify("on");
    var_0.obj_glow[0] show();
    var_0.obj_glow[1] show();
    var_0.off waittill("trigger");
    var_0 notify("off");
    var_0.obj_glow[0] hide();
    var_0.obj_glow[1] hide();
  }
}

wall_breach_think2() {
  maps\_utility::array_wait(self.use_trig, "trigger", 0);
  self notify("used");
  self.use_trig[0] common_scripts\utility::trigger_off();
  self.use_trig[1] common_scripts\utility::trigger_off();
  self.obj_glow[0] delete();
  self.obj_glow[1] delete();
  self.obj_mdl[0] show();
  self.obj_mdl[1] show();

  if(isdefined(self.use_trig[0].jumptorandomtype) || isdefined(self.use_trig[1].jumptorandomtype)) {
    self.whole delete();
    self.broken show();

    if(self.broken.spawnflags & 1)
      self.broken disconnectpaths();

    return;
  }

  self.obj_mdl[0] playloopsound("bomb_tick");
  var_0 = maps\_utility::get_stop_watch(60, self.use_trig[0].time);
  wait(self.use_trig[0].time * 0.5);
  thread common_scripts\utility::play_sound_in_space(level.level_name + "_ge1_fireinhole", self.on getorigin());
  wait(self.use_trig[0].time * 0.5);
  self.obj_mdl[0] stoploopsound("bomb_tick");
  var_0 destroy();
  playfx(level._effect["exp_breach"], self.obj_mdl[0].origin);
  thread common_scripts\utility::play_sound_in_space("detpack_explo_concrete", self.obj_mdl[0].origin);
  self.use_trig[0] delete();
  self.use_trig[1] delete();
  self.whole delete();
  self.obj_mdl[0] delete();
  self.obj_mdl[1] delete();
  self.broken show();

  if(self.broken.spawnflags & 1)
    self.broken disconnectpaths();

  self.on delete();
  self.off delete();

  if(!isdefined(self.chain)) {
    return;
  }
  wait 0.5;
  self.chain notify("trigger");
}