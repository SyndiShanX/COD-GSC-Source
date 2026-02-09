/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_util.gsc
*****************************************************/

train_build(var_0, var_1) {
  var_2 = spawnStruct();
  var_2 maps\_utility::ent_flag_init("train_teleporting");
  var_2.names = var_0;
  var_2.cars = [];
  var_2.note = var_1;
  var_2.path_array = [];
  var_2.force_mantle_trigs = [];

  foreach(var_4 in var_0) {
    var_5 = getEntArray(var_4, "script_noteworthy");
    var_6 = spawnStruct();
    var_6.body_ext = [];
    var_6.body_int = [];
    var_6.anim_models = [];
    var_6.trigs = [];
    var_6.overlaydelay = 0;
    var_6.overlayweight = 1;

    foreach(var_8 in var_5) {
      if(!isDefined(var_8.script_parameters)) {
        continue;
      }
      var_8._essential_part = 1;

      if(var_8.script_parameters == "body") {
        var_8 maps\_utility::assign_animtree(var_4 + "_body");
        var_8 hide();
        var_6.body = var_8;
        var_6.anim_models["body"] = var_8;
        continue;
      }

      if(issubstr(var_8.script_parameters, "body_ext")) {
        if(issubstr(var_8.script_parameters, "anim")) {
          var_8 maps\_utility::assign_animtree(var_4 + var_8.targetname);
          var_6.anim_models[var_8.targetname] = var_8;
        }

        if(isDefined(var_8.targetname))
          var_6.body_ext[var_8.targetname] = var_8;
        else
          var_6.body_ext[var_6.body_int.size] = var_8;

        continue;
      }

      if(issubstr(var_8.script_parameters, "body_int")) {
        if(issubstr(var_8.script_parameters, "anim")) {
          var_8 maps\_utility::assign_animtree(var_4 + var_8.targetname);
          var_6.anim_models[var_8.targetname] = var_8;
        }

        if(isDefined(var_8.targetname))
          var_6.body_int[var_8.targetname] = var_8;
        else
          var_6.body_int[var_6.body_int.size] = var_8;

        var_8._essential_part = undefined;
        continue;
      }

      if(var_8.script_parameters == "sus_f") {
        var_8 maps\_utility::assign_animtree(var_4 + "_sus_f");
        var_6.sus_f = var_8;
        var_6.body_ext["sus_f"] = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_f_disk") {
        var_6.sus_fd = var_8;
        var_6.body_ext["sus_fd"] = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_f_left") {
        var_6.sus_fl = var_8;
        var_6.body_ext["sus_fl"] = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_f_right") {
        var_6.sus_fr = var_8;
        var_6.body_ext["sus_fr"] = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_f_link") {
        var_6.sus_flink = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_b") {
        var_8 maps\_utility::assign_animtree(var_4 + "_sus_b");
        var_6.sus_b = var_8;
        var_6.body_ext["sus_b"] = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_b_disk") {
        var_6.sus_bd = var_8;
        var_6.body_ext["sus_bd"] = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_b_left") {
        var_6.sus_bl = var_8;
        var_6.body_ext["sus_bl"] = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_b_right") {
        var_6.sus_br = var_8;
        var_6.body_ext["sus_br"] = var_8;
        continue;
      }

      if(var_8.script_parameters == "sus_b_link") {
        var_6.sus_blink = var_8;
        continue;
      }

      var_8._essential_part = undefined;
    }

    if(isDefined(var_6.sus_fd))
      var_6.sus_fd linkto(var_6.sus_f, "j_mainroot");

    if(isDefined(var_6.sus_fl))
      var_6.sus_fl linkto(var_6.sus_f, "j_elbow_le");

    if(isDefined(var_6.sus_fr))
      var_6.sus_fr linkto(var_6.sus_f, "j_elbow_ri");

    if(isDefined(var_6.sus_flink))
      var_6.sus_flink linkto(var_6.sus_f, "j_mainroot");

    if(isDefined(var_6.sus_bd))
      var_6.sus_bd linkto(var_6.sus_b, "j_mainroot");

    if(isDefined(var_6.sus_bl))
      var_6.sus_bl linkto(var_6.sus_b, "j_elbow_le");

    if(isDefined(var_6.sus_br))
      var_6.sus_br linkto(var_6.sus_b, "j_elbow_ri");

    if(isDefined(var_6.sus_blink))
      var_6.sus_blink linkto(var_6.sus_b, "j_mainroot");

    var_6.ref_start = common_scripts\utility::spawn_tag_origin();
    var_6.ref_start.origin = var_6.body gettagorigin("j_spineupper");
    var_6.ref_start.angles = var_6.body gettagangles("j_spineupper");
    var_6.ref_end = common_scripts\utility::spawn_tag_origin();
    var_6.ref_end linkto(var_6.body, "j_spineupper", (0, 0, 0), (0, 0, 0));
    var_5 = common_scripts\utility::array_remove(var_5, var_6.body);
    var_6.other_linked_parts = [];
    var_6.other_linked_parts_count = 0;

    foreach(var_8 in var_5) {
      if(var_8 islinked() || isDefined(var_8.script_parameters) && issubstr(var_8.script_parameters, "dont_link")) {
        continue;
      }
      if(issubstr(var_8.classname, "trigger_")) {
        var_8 enablelinkto();

        if(isDefined(var_8.script_flag) && var_8.script_flag == "flag_force_mantle")
          var_2.force_mantle_trigs[var_2.force_mantle_trigs.size] = var_8;
        else
          var_6.trigs[var_6.trigs.size] = var_8;
      }

      if(isDefined(var_8.script_parameters) && issubstr(var_8.script_parameters, "weapon")) {
        var_11 = spawn(var_8.script_parameters, var_8.origin);
        var_11.angles = var_8.angles;

        if(isDefined(var_8.script_index))
          var_11 itemweaponsetammo(randomintrange(10, 30), var_8.script_index);
      }

      if(issubstr(var_8.classname, "actor_")) {
        var_8.car = var_6;
        var_8 maps\_utility::add_spawn_function(::teleport_ai_instant);
        continue;
      }

      if(issubstr(var_8.classname, "script_vehicle_")) {
        continue;
      }
      if(issubstr(var_8.classname, "_volume"))
        var_8 enablelinkto();

      var_8 linkto(var_6.body, "j_spineupper");

      if(!isDefined(var_8._essential_part) && !issubstr(var_8.classname, "trigger_")) {
        if(!isDefined(var_6.other_linked_parts[var_8.classname]))
          var_6.other_linked_parts[var_8.classname] = [];

        var_6.other_linked_parts[var_8.classname] = common_scripts\utility::array_add(var_6.other_linked_parts[var_8.classname], var_8);
        var_6.other_linked_parts_count++;
      }
    }

    var_6.sus_flink = undefined;
    var_6.sus_blink = undefined;
    var_2.cars[var_4] = var_6;
  }

  var_2.other_linked_parts_count = 0;

  foreach(var_6 in var_2.cars)
  var_2.other_linked_parts_count = var_2.other_linked_parts_count + var_6.other_linked_parts_count;

  common_scripts\utility::array_call(var_2.force_mantle_trigs, ::setmovingplatformtrigger);
  return var_2;
}

train_queue_path_anims(var_0, var_1, var_2, var_3, var_4, var_5) {
  train_queue_path_anim(var_0[0], var_1, var_2, var_3, var_4, var_5);

  for(var_6 = 1; var_6 < var_0.size; var_6++)
    thread train_queue_path_anim(var_0[var_6], var_1, var_2);
}

train_queue_path_anim(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.loop_array = undefined;

  if(!isDefined(var_3))
    var_3 = "none";

  var_6 = spawnStruct();
  var_6.anime = var_0;
  var_6.start = common_scripts\utility::getstruct(var_1, "targetname");
  var_6.end = common_scripts\utility::getstruct(var_2, "targetname");
  var_6.a_rel = var_5;

  if(var_3 == "none")
    self.path_array[self.path_array.size] = var_6;
  else if(var_3 == "next")
    self.path_array = maps\_utility::array_merge([var_6], self.path_array);
  else if(var_3 == "clear")
    self.path_array = [var_6];

  if(isDefined(self.need_end_org) || isDefined(self.path) && !istrue(self.path.a_rel) && (var_3 == "next" || var_3 == "clear")) {
    self.path.end_org = var_6.start common_scripts\utility::spawn_tag_origin();
    self.need_end_org = undefined;
  }

  if(istrue(var_4))
    level notify(self.note);
}

train_queue_path_anim_loop(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 1;

  var_6 = [];

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    if(var_7 == 0)
      train_queue_path_anim(var_0[var_7], var_1, var_2, var_3, var_4, var_5);
    else
      train_queue_path_anim(var_0[var_7], var_1, var_2);

    var_6[var_7] = self.path_array[self.path_array.size - 1];
  }

  self.loop_array = var_6;
}

train_path() {
  self notify("end_train_path");
  self endon("end_train_path");

  if(isDefined(level.debug_no_move) && istrue(level.debug_no_move)) {
    return;
  }
  self.path = self.path_array[0];
  self.path_array = maps\_utility::array_remove_index(self.path_array, 0);
  self.path.anim_org = self.path.start common_scripts\utility::spawn_tag_origin();

  foreach(var_1 in self.cars) {
    self.path.anim_org thread maps\_anim::anim_single_solo(var_1.body, self.path.anime);
    var_1.sus_f thread maps\_anim::anim_single_solo(var_1.sus_f, self.path.anime);
    var_1.sus_b thread maps\_anim::anim_single_solo(var_1.sus_b, self.path.anime);
    var_1.sus_f setanim(level.scr_anim[var_1.sus_f.animname]["wheels"]);
    var_1.sus_b setanim(level.scr_anim[var_1.sus_b.animname]["wheels"]);
    var_1 thread train_wheel_anims();
  }

  wait 0.15;

  for(;;) {
    level waittill(self.note);

    while(maps\_utility::ent_flag("train_teleporting"))
      wait 0.05;

    train_get_next_path();

    foreach(var_1 in self.cars) {
      self.path.anim_org maps\_utility::anim_stopanimscripted();
      var_1.body maps\_utility::anim_stopanimscripted();
      var_1.sus_f maps\_utility::anim_stopanimscripted();
      var_1.sus_b maps\_utility::anim_stopanimscripted();
      self.path.anim_org thread maps\_anim::anim_single_solo(var_1.body, self.path.anime);
      var_1.sus_f thread maps\_anim::anim_single_solo(var_1.sus_f, self.path.anime);
      var_1.sus_b thread maps\_anim::anim_single_solo(var_1.sus_b, self.path.anime);
      var_1 notify("train_start_new_anims");
    }

    level notify("notify_restart_overlay_anims");
    thread train_teleport();
    level common_scripts\utility::waittill_notify_or_timeout(self.note, 0.15);
  }
}

train_get_next_path() {
  self endon("end_train_path");

  if(self.path_array.size < 1) {
    if(isDefined(self.loop_array)) {
      self.path_array = self.loop_array;
      self.need_end_org = undefined;
    } else {
      self.need_end_org = undefined;

      if(isDefined(self.path.start_org))
        self.path.start_org delete();

      if(isDefined(self.path.end_org))
        self.path.end_org delete();

      self notify("end_train_path");
    }
  }

  var_0 = self.path_array[0].start;

  if(istrue(self.path_array[0].a_rel) || self.path.start.origin != self.path_array[0].start.origin && !isDefined(self.path_array[0].a_rel)) {
    self.path_array[0].a_rel = 1;
    var_0 = self.path.end;
  }

  self.path.anim_org delete();

  if(isDefined(self.path.start_org))
    self.path.start_org delete();

  if(isDefined(self.path.end_org))
    self.path.end_org delete();

  self.path = self.path_array[0];
  self.path_array = maps\_utility::array_remove_index(self.path_array, 0);
  self.path.anim_org = var_0 common_scripts\utility::spawn_tag_origin();

  if(istrue(self.path.a_rel)) {
    self.path.start_org = self.path.anim_org common_scripts\utility::spawn_tag_origin();
    self.path.end_org = self.path.start common_scripts\utility::spawn_tag_origin();
  } else if(self.path_array.size > 0) {
    self.path.start_org = self.path.end common_scripts\utility::spawn_tag_origin();
    self.path.end_org = self.path_array[0].start common_scripts\utility::spawn_tag_origin();
  } else {
    self.path.start_org = self.path.end common_scripts\utility::spawn_tag_origin();
    self.need_end_org = 1;
  }
}

train_new_sus_path_anims(var_0, var_1) {
  if(isDefined(level.debug_no_move) && istrue(level.debug_no_move)) {
    return;
  }
  maps\skyway_anim::update_train_path_anims(var_1);
  self.cars[var_0].sus_f maps\_utility::anim_stopanimscripted();
  self.cars[var_0].sus_b maps\_utility::anim_stopanimscripted();
  self.cars[var_0].sus_f thread maps\_anim::anim_single_solo(self.cars[var_0].sus_f, self.path.anime);
  self.cars[var_0].sus_b thread maps\_anim::anim_single_solo(self.cars[var_0].sus_b, self.path.anime);
  var_2 = self.cars[var_0].body getanimtime(level.scr_anim[self.cars[var_0].body.animname][self.path.anime]);
  self.cars[var_0].sus_f setanimtime(level.scr_anim[self.cars[var_0].sus_f.animname][self.path.anime], var_2);
  self.cars[var_0].sus_b setanimtime(level.scr_anim[self.cars[var_0].sus_b.animname][self.path.anime], var_2);
  self.cars[var_0] notify("train_start_new_anims");
  level notify("notify_restart_overlay_anims");
  var_3 = self.cars[var_0].sus_f getanimtime(level.scr_anim[self.cars[var_0].sus_f.animname]["wheels"]);
  self.cars[var_0].sus_f setanimtime(level.scr_anim[self.cars[var_0].sus_f.animname]["wheels"], var_3);
}

train_teleport() {
  self notify("end_train_teleport");
  self endon("end_train_teleport");
  self waittill("train_teleport_ready");
  maps\_utility::ent_flag_set("train_teleporting");

  foreach(var_1 in self.cars) {
    if(!isDefined(var_1.body)) {
      continue;
    }
    var_1.body linkto(self.path.anim_org);
  }

  wait 0.05;
  self.path.anim_org teleportentityrelative(self.path.start_org, self.path.end_org);
  teleportscene();

  foreach(var_1 in self.cars) {
    if(!isDefined(var_1.body)) {
      continue;
    }
    var_1.body unlink();
  }

  if(self.path_array.size > 0)
    self.path_array[0].a_rel = undefined;

  maps\_utility::ent_flag_clear("train_teleporting");
  self notify("train_teleporting_done");
  self notify(self.path.start.targetname);
}

train_setup_teleport_triggers(var_0) {
  var_1 = getEntArray("player_train_trig_teleport", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::train_tele_trig_proc, var_0);
}

train_tele_trig_proc(var_0) {
  self endon("death");
  self endon("stop_train_tele_trig");
  level endon("stop_train_tele_trigs");

  for(;;) {
    self waittill("trigger");
    var_0 notify("train_teleport_ready");

    while(var_0 maps\_utility::ent_flag("train_teleporting"))
      wait 0.05;
  }
}

player_sway() {
  level.player_default_sway_weight = 0.11;
  level.player_sway_weight = level.player_default_sway_weight;
  level.player_wind_weight = 0.0;
  level.player_ground_ref_mover = maps\_utility::spawn_anim_model("player_rig");
  level.player_ground_ref_mover.origin = level.player.origin;
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = level.player_ground_ref_mover gettagorigin("tag_player");
  var_0.angles = level.player_ground_ref_mover gettagangles("tag_player");
  var_0 linkto(level.player_ground_ref_mover, "tag_player");
  level.player playersetgroundreferenceent(var_0);
  wait 0.5;

  for(;;) {
    level.player_ground_ref_mover setanim(level.scr_anim["player_rig"]["player_sway_static"], level.player_sway_weight);
    level.player_ground_ref_mover setanim(level.scr_anim["player_rig"]["player_wind_static"], level.player_wind_weight);
    var_1 = level.player_sway_weight + level.player_wind_weight;

    if(var_1 > 1)
      var_1 = 1;

    level.player_ground_ref_mover setanim(level.scr_anim["player_rig"]["player_nosway_static"], 1 - var_1);
    wait(level.timestep);
  }
}

player_view_roll_with_traincar(var_0, var_1) {
  if(common_scripts\utility::flag("flag_player_view_rotating")) {
    return;
  }
  common_scripts\utility::flag_set("flag_player_view_rotating");
  var_2 = maps\_utility::spawn_anim_model("view_roll");
  var_2.origin = level.player_ground_ref_mover.origin;
  var_2.angles = level._train.cars[level.player.car].body.angles;
  level.player_ground_ref_mover linkto(var_2, "origin_animate_jnt");
  var_2 setanimrestart(level.scr_anim["view_roll"]["nosway"], 1 - var_1);
  var_2 setanimrestart(level.scr_anim["view_roll"][var_0], var_1);
  wait(getanimlength(level.scr_anim["view_roll"][var_0]));
  level.player_ground_ref_mover unlink();
  common_scripts\utility::flag_clear("flag_player_view_rotating");
  var_2 delete();
}

player_sway_blendto(var_0, var_1, var_2) {
  level endon("notify_change_player_sway");

  if(var_0 == 0)
    var_0 = 0.05;

  if(!isDefined(var_1))
    var_1 = level.player_default_sway_weight;

  var_3 = level.player_sway_weight;
  var_4 = var_1 - level.player_sway_weight;

  for(var_5 = var_4 * (level.timestep / var_0); var_0 > 0; var_0 = var_0 - level.timestep) {
    var_3 = var_3 + var_5;

    if(var_3 > 1)
      var_3 = 1;

    if(var_3 < 0)
      var_3 = 0;

    level.player_sway_weight = var_3;
    wait(level.timestep);
  }

  level.player_sway_weight = var_1;
  level notify("notify_sway_blend_complete");
}

player_wind_blendto(var_0, var_1, var_2) {
  level endon("notify_change_player_wind");

  if(var_0 == 0)
    var_0 = 0.05;

  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = level.player_wind_weight;
  var_4 = var_1 - level.player_wind_weight;

  for(var_5 = var_4 * (level.timestep / var_0); var_0 > 0; var_0 = var_0 - level.timestep) {
    var_3 = var_3 + var_5;

    if(var_3 > 1)
      var_3 = 1;

    if(var_3 < 0)
      var_3 = 0;

    level.player_wind_weight = var_3;
    wait(level.timestep);
  }

  level.player_wind_weight = var_1;
  level notify("notify_wind_blend_complete");
}

player_sway_bump(var_0, var_1, var_2, var_3) {
  level notify("notify_change_player_sway");
  level endon("notify_change_player_sway");
  thread player_sway_blendto(var_0, var_3);
  level waittill("notify_sway_blend_complete");
  wait(var_1);
  thread player_sway_blendto(var_2);
}

player_wind_bump(var_0, var_1, var_2, var_3) {
  level notify("notify_change_player_wind");
  level endon("notify_change_player_wind");
  thread player_wind_blendto(var_0, var_3);
  level waittill("notify_wind_blend_complete");
  wait(var_1);
  thread player_wind_blendto(var_2);
}

player_const_quake() {
  level.player_quake_weight = 0.0001;

  for(;;) {
    if(!common_scripts\utility::flag("flag_quake") && level.player_quake_weight > 0.001)
      earthquake(level.player_quake_weight, 0.1, level.player.origin, 5000);

    wait 0.05;
  }
}

player_const_quake_blendto(var_0, var_1) {
  level notify("notify_change_player_quake");
  level endon("notify_change_player_quake");

  if(var_1 == 0)
    var_1 = 0.05;

  if(!isDefined(var_0))
    var_0 = 0.0;

  if(var_0 <= 0)
    var_0 = 0.0001;

  var_2 = level.player_sway_weight;
  var_3 = var_0 - level.player_sway_weight;

  for(var_4 = var_3 * (level.timestep / var_1); var_1 > 0; var_1 = var_1 - level.timestep) {
    var_2 = var_2 + var_4;

    if(var_2 > 1)
      var_2 = 1;

    if(var_2 < 0)
      var_2 = 0;

    level.player_quake_weight = var_2;
    wait(level.timestep);
  }

  level.player_quake_weight = var_0;
}

player_rumble() {
  level.player_rumble_ent = maps\_utility::get_rumble_ent();
  level.player_rumble_ent maps\_utility::rumble_ramp_to(0, 0.1);
  level.player_rumble_amb_ent = maps\_utility::get_rumble_ent();
  level.player_rumble_amb_ent maps\_utility::rumble_ramp_to(0, 0.1);
  level.player_rumble_rog_ent = maps\_utility::get_rumble_ent();
  level.player_rumble_rog_ent maps\_utility::rumble_ramp_to(0, 0.1);
}

player_rumble_bump(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    level notify(var_6);
    level endon(var_6);
  }

  var_0 thread maps\_utility::rumble_ramp_to(var_1, var_3);
  wait(var_3 + var_4);
  var_0 thread maps\_utility::rumble_ramp_to(var_2, var_5);
}

player_train_rythme_rumble_quake() {
  level.player_do_rythme_rumble = 1;

  for(;;) {
    if(level.player_do_rythme_rumble == 1) {
      earthquake(0.17, 0.2, level.player.origin, 5000);
      level.player playrumbleonentity("damage_light");
    }

    wait 0.1;

    if(level.player_do_rythme_rumble == 1) {
      earthquake(0.12, 0.2, level.player.origin, 5000);
      level.player playrumbleonentity("damage_light");
    }

    wait 0.8;
  }
}

train_wheel_anims() {
  self endon("death");
  self endon("stop_wheel_anims");

  for(;;) {
    self waittill("train_start_new_anims");
    var_0 = self.sus_f getanimtime(level.scr_anim[self.sus_f.animname]["wheels"]);
    self.sus_f setanim(level.scr_anim[self.sus_f.animname]["wheels"]);
    self.sus_b setanim(level.scr_anim[self.sus_b.animname]["wheels"]);
    self.sus_f setanimtime(level.scr_anim[self.sus_f.animname]["wheels"], var_0);
    self.sus_b setanimtime(level.scr_anim[self.sus_b.animname]["wheels"], var_0);
  }
}

blend_link_over_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("stop_blended_links");
  self endon("stop_blended_links");

  if(!isDefined(var_3))
    var_3 = 0;

  var_6 = var_2 * var_3;

  if(!isDefined(var_4))
    var_4 = getpartname(var_0.model, 0);

  if(!isDefined(var_5))
    var_5 = getpartname(var_1.model, 0);

  while(var_6 < var_2) {
    var_7 = var_6 / var_2;
    var_8 = var_0 gettagangles(var_4);
    var_9 = var_1 gettagangles(var_5);
    var_10 = anglestoaxis(var_8);
    var_11 = anglestoaxis(var_9);
    var_12 = var_11["forward"] * var_7 + var_10["forward"] * (1 - var_7);
    var_13 = var_11["right"] * var_7 + var_10["right"] * (1 - var_7);
    var_14 = var_11["up"] * var_7 + var_10["up"] * (1 - var_7);
    var_15 = axistoangles(var_12, var_13, var_14);
    var_16 = var_0 gettagorigin(var_4);
    var_17 = var_1 gettagorigin(var_5);
    var_18 = var_17 * var_7 + var_16 * (1 - var_7);

    if(var_7 < 0.5)
      self linkto(var_0, var_4, rotatevectorinverted(var_18 - var_16, var_8), var_15 - var_8);
    else
      self linkto(var_1, var_5, rotatevectorinverted(var_18 - var_17, var_9), var_15 - var_9);

    wait 0.05;
    var_6 = var_6 + 0.05;
  }

  self linkto(var_1, var_5, (0, 0, 0), (0, 0, 0));
}

blended_link(var_0, var_1, var_2, var_3, var_4) {
  self endon("stop_blended_links");
  self endon("death");

  if(!isDefined(var_3))
    var_3 = getpartname(var_0.model, 0);

  if(!isDefined(var_4))
    var_4 = getpartname(var_1.model, 0);

  if(isDefined(var_2) && var_2)
    self linkto(var_0, var_3, (0, 0, 0), (0, 0, 0));

  for(;;) {
    var_5 = var_0 gettagangles(var_3);
    var_6 = var_1 gettagangles(var_4);
    var_7 = anglestoaxis(var_5);
    var_8 = anglestoaxis(var_6);
    var_9 = 0.5 * (var_7["forward"] + var_8["forward"]);
    var_10 = 0.5 * (var_7["right"] + var_8["right"]);
    var_11 = 0.5 * (var_7["up"] + var_8["up"]);
    var_12 = axistoangles(var_9, var_10, var_11);
    var_13 = var_0 gettagorigin(var_3);
    var_14 = var_1 gettagorigin(var_4);
    var_15 = 0.5 * (var_14 + var_13);
    self linkto(var_0, var_3, rotatevectorinverted(var_15 - var_13, var_5), var_12 - var_5);
    wait 0.05;
  }
}

vision_hit_transition(var_0, var_1, var_2, var_3, var_4) {
  level notify("notify_vision_set_transition");
  level endon("notify_vision_set_transition");
  maps\_utility::vision_set_fog_changes(var_0, var_2);
  wait(var_3);
  maps\_utility::vision_set_fog_changes(var_1, var_4);
}

sun_hit_transition(var_0, var_1, var_2, var_3) {
  var_4 = getmapsunlight();
  var_5 = (var_4[0] * var_0, var_4[1] * var_0, var_4[2] * var_0);
  maps\_utility::sun_light_fade(var_4, var_5, var_1);
  wait(var_2);
  maps\_utility::sun_light_fade(var_5, var_4, var_1);
}

train_overlay(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in self.cars) {
    if(isDefined(var_3))
      var_7 = var_3;
    else
      var_7 = var_6.overlayweight;

    var_6 thread train_overlay_solo(var_0, var_1, var_2, var_7, var_4, var_6.overlaydelay);
    var_6.overlaydelay = 0;
    var_6.overlayweight = 1;
  }
}

sat_acc_overlay(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    wait(var_3);

  foreach(var_5 in self.accessory)
  var_5 thread sat_acc_overlay_solo(var_0, var_1, var_2);
}

sat_acc_overlay_solo(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 1.0;

  if(!isDefined(var_2))
    var_2 = 0.2;

  self setanimknobrestart(level.scr_anim[self.animname][var_0], 1, var_2);
  self setanim(level.scr_anim[self.animname]["overlay"], var_1, var_2);
}

train_overlay_solo(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1))
    var_1 = "nothing";

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 1.0;

  if(!isDefined(var_4))
    var_4 = 0.2;

  if(!isDefined(var_6))
    var_6 = 0;

  if(!isDefined(self.absolute))
    self.absolute = 0;

  if(self.absolute == 1 && var_6 == 0) {
    return;
  }
  if(var_1 == "waitforpreviousanim")
    self waittill("notify_train_overlay_complete");

  if(var_6 == 1)
    self.absolute = 1;

  self notify("notify_end_train_overlay");
  self endon("notify_end_train_overlay");
  self endon("notify_train_overlay_complete");

  if(isDefined(var_5))
    wait(var_5);

  self.body setanimknobrestart(level.scr_anim[self.body.animname][var_0], 1, var_4);
  self.sus_f setanimknobrestart(level.scr_anim[self.sus_f.animname][var_0], 1, var_4);
  self.sus_b setanimknobrestart(level.scr_anim[self.sus_b.animname][var_0], 1, var_4);
  self.body setanim(level.scr_anim[self.body.animname]["overlay"], var_3, var_4);
  self.sus_f setanim(level.scr_anim[self.sus_f.animname]["overlay"], var_3, var_4);
  self.sus_b setanim(level.scr_anim[self.sus_b.animname]["overlay"], var_3, var_4);

  if(!var_2)
    thread train_overlay_cleanup(var_0, var_6);

  for(;;) {
    level waittill("notify_restart_overlay_anims");
    thread train_overlay_auto_restart(var_0, var_3);
    wait(level.timestep);
    thread train_overlay_auto_restart(var_0, var_3);
  }
}

train_overlay_cleanup(var_0, var_1) {
  self endon("notify_end_train_overlay");
  self endon("notify_train_overlay_complete");
  wait(getanimlength(level.scr_anim[self.body.animname][var_0]));

  if(var_1 == 1)
    self.absolute = 0;

  self notify("notify_train_overlay_complete");
}

train_overlay_auto_restart(var_0, var_1) {
  var_2 = self.body getanimtime(level.scr_anim[self.body.animname][var_0]);
  self.body setanim(level.scr_anim[self.body.animname][var_0], 1, 0);
  self.sus_f setanim(level.scr_anim[self.sus_f.animname][var_0], 1, 0);
  self.sus_b setanim(level.scr_anim[self.sus_b.animname][var_0], 1, 0);
  self.body setanim(level.scr_anim[self.body.animname]["overlay"], var_1, 0);
  self.sus_f setanim(level.scr_anim[self.sus_f.animname]["overlay"], var_1, 0);
  self.sus_b setanim(level.scr_anim[self.sus_b.animname]["overlay"], var_1, 0);
  self.body setanimtime(level.scr_anim[self.body.animname][var_0], var_2);
  self.sus_f setanimtime(level.scr_anim[self.sus_f.animname][var_0], var_2);
  self.sus_b setanimtime(level.scr_anim[self.sus_b.animname][var_0], var_2);
}

play_anim_and_idle(var_0, var_1, var_2, var_3, var_4, var_5) {
  maps\_anim::anim_single_solo(var_0, var_1, var_5, 0.2);

  if(!common_scripts\utility::flag(var_3))
    maps\_anim::anim_loop_solo(var_0, var_2, var_4, var_5);
}

rooftop_jumpcheck(var_0, var_1) {
  level endon("rooftop_jumpfail");
  var_2 = 0;

  while(!common_scripts\utility::flag(var_1)) {
    var_2 = level.player jumpbuttonpressed();
    wait 0.05;
  }

  maps\_utility::delaythread(var_0, ::rooftop_jumpfail);

  for(;;) {
    if(level.player jumpbuttonpressed()) {
      if(!var_2 && common_scripts\utility::flag(var_1))
        return;
      else if(!var_2)
        var_2 = 1;
    } else
      var_2 = 0;

    wait 0.05;
  }
}

rooftop_jumpfail() {
  wait 100;
}

cleanup_roofjump_on_notify(var_0) {
  level waittill("notify_player_end_vignette");
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player showviewmodel();
  level.player unlink();
  var_0 delete();
}

train_quake(var_0, var_1, var_2, var_3, var_4) {
  level notify("train_quake");
  var_3 = max(var_1 * 3000, var_3);
  thread train_quake_proc(var_0, var_1, var_2, var_3, var_4);
}

train_quake_proc(var_0, var_1, var_2, var_3, var_4) {
  level endon("train_quake");

  if(isDefined(var_4))
    wait(var_4);

  if(var_0 > level.player_quake_weight) {
    common_scripts\utility::flag_set("flag_quake");
    earthquake(var_0, var_1, var_2, var_3);
    thread train_quake_tele_check(var_0, var_1, var_2, var_3);
    var_5 = (var_0 - level.player_quake_weight) / var_0;
    wait(var_1 * var_5);
    common_scripts\utility::flag_clear("flag_quake");
  }

  level notify("train_quake");
}

train_quake_tele_check(var_0, var_1, var_2, var_3) {
  level endon("train_quake");
  var_4 = var_1;

  while(var_1 > 0) {
    var_5 = level._train common_scripts\utility::waittill_notify_or_timeout_return("train_teleporting_done", 0.05);
    var_4 = var_4 - 0.05;

    if(!isDefined(var_5) || var_5 != "timeout") {
      var_0 = var_0 * (var_4 / var_1);
      thread train_quake(var_0, var_4, var_2, var_3);
    }
  }
}

delay_multi_fx(var_0, var_1, var_2, var_3, var_4) {
  if(!isarray(var_1))
    var_1 = [var_1];

  if(!isDefined(var_2))
    var_2 = [];
  else if(!isarray(var_2))
    var_2 = [var_2];

  if(!isDefined(var_3))
    var_3 = [];
  else if(!isarray(var_3))
    var_3 = [var_3];

  if(!isDefined(var_4))
    var_4 = "tag_origin";

  thread delay_multi_fx_proc(var_0, var_1, var_2, var_3, var_4);
}

delay_multi_fx_proc(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 > 0)
    wait(var_0);

  foreach(var_6 in var_1) {
    foreach(var_8 in var_3)
    stopFXOnTag(common_scripts\utility::getfx(var_8), var_6, var_4);

    foreach(var_8 in var_2)
    playFXOnTag(common_scripts\utility::getfx(var_8), var_6, var_4);
  }
}

test_func_on_button() {
  if(1) {
    return;
  }
  for(;;) {
    if(level.player buttonpressed("DPAD_DOWN")) {
      var_0 = getent("sea_floor_animated", "targetname");
      var_1 = 0;

      for(;;) {
        if(var_1 == 0) {
          var_0 hide();
          var_1 = 1;
        } else {
          var_0 show();
          var_1 = 0;
        }

        wait(level.timestep);
      }

      wait 1;
    }

    if(level.player buttonpressed("DPAD_UP")) {
      for(;;) {
        iprintln(level.player_sway_weight);
        iprintln(level.player_wind_weight);
        wait(level.timestep);
      }
    }

    if(level.player buttonpressed("DPAD_LEFT"))
      common_scripts\utility::flag_set("flag_breach_final_tracks");

    if(level.player buttonpressed("DPAD_RIGHT")) {}

    wait(level.timestep);
  }
}

jet_flyover(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = maps\_utility::spawn_anim_model("sw_jet");
  var_6.origin = var_0.origin;
  var_6.angles = var_0.angles;
  var_6 thread teleport_ent_generic();
  var_7 = common_scripts\utility::spawn_tag_origin();
  var_8 = common_scripts\utility::spawn_tag_origin();
  var_7 linkto(var_6, "tag_jet_1", (0, 0, 0), (9, 0, 0));
  var_8 linkto(var_6, "tag_jet_1", (0, 0, 0), (0, 0, 0));
  var_7 playLoopSound("sw_jet_flyby_mid_loop");
  var_8 playLoopSound("sw_jet_flyby_close_loop");

  if(isDefined(var_2))
    playFXOnTag(common_scripts\utility::getfx(var_2), var_6, "tag_jet_1");

  if(isDefined(var_2))
    playFXOnTag(common_scripts\utility::getfx(var_3), var_6, "tag_jet_2");

  if(isDefined(var_2))
    playFXOnTag(common_scripts\utility::getfx(var_4), var_6, "tag_jet_3");

  if(var_5) {
    var_9 = maps\_utility::spawn_anim_model("sw_mig");
    var_10 = maps\_utility::spawn_anim_model("sw_mig");
    var_11 = maps\_utility::spawn_anim_model("sw_mig");
    var_9 linkto(var_6, "tag_jet_1", (0, 0, 0), (0, 0, 90));
    var_10 linkto(var_6, "tag_jet_2", (0, 0, 0), (0, 0, 90));
    var_11 linkto(var_6, "tag_jet_3", (0, 0, 0), (0, 0, 90));
  }

  var_6 setanim(level.scr_anim["sw_jet"][var_1]);
  wait(getanimlength(level.scr_anim["sw_jet"][var_1]));
  var_6 delete();
  var_7 delete();
  var_8 delete();
}

ambient_airbursts() {
  level waittill("flag_hangar_door_open");
  wait 1;
  thread ambient_canyon_big_airbursts_and_rogs(1);
  thread ambient_canyon_airbursts_far();
  level waittill("flag_tunnel_1_start");
  common_scripts\utility::flag_set("flag_in_tunnel");
  thread ambient_canyon_airbursts_periph();
  level waittill("flag_tunnel_1_end");
  common_scripts\utility::flag_clear("flag_in_tunnel");
  level waittill("flag_helo_tunnel");
  common_scripts\utility::flag_set("flag_in_tunnel");
  wait 3;
  common_scripts\utility::flag_set("flag_stop_ambient_airbursts");
}

ambient_airbursts_startpoint() {
  wait 2;
  thread ambient_canyon_big_airbursts_and_rogs();
  thread ambient_canyon_airbursts_far();
  thread ambient_canyon_airbursts_periph();
  level waittill("flag_helo_tunnel");
  common_scripts\utility::flag_set("flag_in_tunnel");
  wait 3;
  common_scripts\utility::flag_set("flag_stop_ambient_airbursts");
}

ambient_canyon_big_airbursts_and_rogs(var_0) {
  if(isDefined(var_0))
    wait 6;

  thread ambient_rog_strike_intro_timer(10);
  level endon("notify_stop_ambient_rogs");
  var_1 = 3.0;
  var_2 = 8.5;
  var_3 = ["tag_rog_strike_1", "tag_rog_strike_2", "tag_rog_strike_3", "tag_rog_strike_4"];

  for(;;) {
    while(common_scripts\utility::flag("flag_pause_ambient_train_shakes"))
      wait(level.timestep);

    if(common_scripts\utility::flag("flag_queue_ambient_rog")) {
      thread ambient_rog_strike_timer();
      thread ambient_rog_strike(var_3);
      wait(randomfloatrange(9, 11.5));
      common_scripts\utility::flag_clear("flag_queue_ambient_rog");
    }

    ambient_canyon_airburst_close_shake();
    wait(randomfloatrange(var_1, var_2));
  }
}

ambient_rog_strike_intro_timer(var_0) {
  wait(var_0);
  common_scripts\utility::flag_set("flag_pause_ambient_train_shakes");
  thread ambient_rog_strike_timer();
  thread ambient_rog_strike_intro();
  wait 9;

  if(!issubstr(level.start_point, "sat2"))
    common_scripts\utility::flag_clear("flag_pause_ambient_train_shakes");
}

ambient_rog_strike_timer() {
  var_0 = 13;
  var_1 = 19;
  wait(randomfloatrange(var_0, var_1));
  common_scripts\utility::flag_set("flag_queue_ambient_rog");
}

ambient_rog_strike(var_0) {
  var_1 = level._train.cars["train_loco"].body;
  var_2 = common_scripts\utility::random(var_0);
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3 thread teleport_ent_generic();
  var_3.origin = var_1 gettagorigin(var_2);
  var_3.angles = var_1 gettagangles(var_2);

  if(!common_scripts\utility::flag("flag_helo_tunnel"))
    playFXOnTag(common_scripts\utility::getfx("rog_maintrail_01"), var_3, "tag_origin");

  var_3 thread maps\skyway_audio::sfx_rog_canyon_impact("tag_origin");
  wait 2.3;
  var_4 = 1.5;
  wait(var_4);

  if(!common_scripts\utility::flag("flag_helo_tunnel"))
    playFXOnTag(common_scripts\utility::getfx("vfx_rog_impact_canyon_temp_01"), var_3, "tag_origin");

  if(!common_scripts\utility::flag("flag_helo_tunnel"))
    thread rog_flash(0.3, 0.3, 1.5);

  thread train_quake(0.2, 2.2, level.player.origin, 2000);
  var_5 = 0.6;
  var_6 = 0.3;
  var_7 = "roghit";
  wait 1.0;
  thread player_rumble_bump(level.player_rumble_rog_ent, 0.5, 0.0, 0.3, 0.0, 6.0, "notify_rog_rumble");
  thread maps\skyway_audio::sfx_impact_train(level._train.cars[level.player.car].overlaydelay, level._train.cars[level.player.car].overlayweight, undefined, 1);
  level._train.cars["train_sat_1"] thread sat_acc_overlay(var_7, var_5, var_6, level._train.cars["train_sat_1"].overlaydelay);
  level._train.cars["train_sat_2"] thread sat_acc_overlay(var_7, var_5, var_6, level._train.cars["train_sat_2"].overlaydelay);
  level._train train_overlay(var_7, undefined, undefined, var_5, var_6);
  thread player_wind_bump(0.2, 0.0, 3.0, 0.9);
  wait 0.2;
  thread train_quake(0.3, 0.8, level.player.origin, 2000);
  wait 15;
  var_3 delete();
}

ambient_rog_strike_intro() {
  var_0 = getent("model_rog_hit_ref_4", "targetname");
  playFXOnTag(common_scripts\utility::getfx("rog_maintrail_01"), var_0, "tag_explode_base");
  var_0 thread maps\skyway_audio::sfx_rog_sat_impact("tag_explode");
  wait 2.3;
  var_1 = 1.5;
  wait(var_1);
  playFXOnTag(common_scripts\utility::getfx("vfx_rog_impact_temp_01"), var_0, "tag_shockwave");
  thread rog_flash(0.3, 0.3, 1.5);
  thread train_quake(0.2, 2.2, level.player.origin, 2000);
  var_2 = 0.6;
  var_3 = 0.3;
  var_4 = "roghit";
  wait 1.0;
  thread player_rumble_bump(level.player_rumble_rog_ent, 0.5, 0.0, 0.3, 0.0, 6.0, "notify_rog_rumble");
  thread maps\skyway_audio::sfx_impact_train(level._train.cars[level.player.car].overlaydelay, level._train.cars[level.player.car].overlayweight, undefined, 1);
  level._train.cars["train_sat_1"] thread sat_acc_overlay(var_4, var_2, var_3, level._train.cars["train_sat_1"].overlaydelay);
  level._train.cars["train_sat_2"] thread sat_acc_overlay(var_4, var_2, var_3, level._train.cars["train_sat_2"].overlaydelay);
  level._train train_overlay(var_4, undefined, undefined, var_2, var_3);
  thread player_wind_bump(0.2, 0.0, 3.0, 0.9);
  wait 0.2;
  thread train_quake(0.3, 0.8, level.player.origin, 2000);
  wait 15;
  var_0 delete();
}

ambient_canyon_airburst_close_shake() {
  if(common_scripts\utility::flag("flag_stop_ambient_airbursts")) {
    return;
  }
  var_0 = ["tag_air_burst_1", "tag_air_burst_2", "tag_air_burst_3", "tag_air_burst_4", "tag_air_burst_5", "tag_air_burst_6"];
  var_1 = determine_closest_cars(level.player.car);
  var_2 = common_scripts\utility::random(var_0);
  var_3 = common_scripts\utility::random(var_1);
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = level._train.cars[var_3].body gettagorigin(var_2);

  if(!common_scripts\utility::flag("flag_in_tunnel"))
    playFXOnTag(common_scripts\utility::getfx("air_burst_low"), var_4, "tag_origin");

  var_4 thread ambient_canyon_airburst_fx_teleport_and_delete();
  var_4 thread maps\_utility::play_sound_on_entity("sw_aa_airburst");
  var_4 thread maps\_utility::play_sound_on_entity("sw_aa_airburst_close");
  thread impact_train(var_4.origin, undefined, 0.3, undefined, 0.0);
}

determine_closest_cars(var_0) {
  var_1 = ["train_sat_1", "train_sat_2", "train_rt0", "train_rt1", "train_rt2", "train_rt3", "train_loco"];

  switch (var_0) {
    case "train_hangar":
      var_1 = ["train_hangar", "train_sat_1", "train_sat_2"];
      return var_1;
    case "train_sat_1":
      var_1 = ["train_sat_1", "train_sat_2", "train_rt0"];
      return var_1;
    case "train_sat_2":
      var_1 = ["train_sat_2", "train_rt0", "train_rt1"];
      return var_1;
    case "train_rt0":
      var_1 = ["train_rt0", "train_rt1", "train_rt2"];
      return var_1;
    case "train_rt1":
      var_1 = ["train_rt1", "train_rt2", "train_rt3"];
      return var_1;
    case "train_rt2":
      var_1 = ["train_rt2", "train_rt3", "train_loco"];
      return var_1;
    case "train_rt3":
      var_1 = ["train_rt3", "train_loco"];
      return var_1;
    case "train_loco":
      var_1 = ["train_rt3", "train_loco"];
      return var_1;
    default:
      iprintlnbold("FAILED TO DETERMINE CAR");
      return var_1;
  }
}

ambient_canyon_airbursts_far() {
  level endon("flag_stop_ambient_airbursts");
  var_0 = 0.2;
  var_1 = 1.9;
  var_2 = ["tag_air_burst_high_1", "tag_air_burst_high_2", "tag_air_burst_high_3", "tag_air_burst_high_4", "tag_air_burst_high_5", "tag_air_burst_high_6"];
  var_3 = ["train_sat_1", "train_sat_2", "train_rt0", "train_rt1", "train_rt2", "train_rt2", "train_rt3", "train_rt3", "train_rt3", "train_loco", "train_loco", "train_loco"];

  for(;;) {
    var_4 = common_scripts\utility::random(var_2);
    var_5 = common_scripts\utility::random(var_3);
    var_6 = common_scripts\utility::spawn_tag_origin();
    var_6.origin = level._train.cars[var_5].body gettagorigin(var_4);

    if(!common_scripts\utility::flag("flag_in_tunnel"))
      playFXOnTag(common_scripts\utility::getfx("air_flak"), var_6, "tag_origin");

    var_6 thread ambient_canyon_airburst_fx_teleport_and_delete();
    var_6 thread maps\_utility::play_sound_on_entity("sw_aa_airburst");
    thread ambient_airbursts_player_effcts(var_6);
    wait(randomfloatrange(var_0, var_1));
  }
}

ambient_canyon_airbursts_periph() {
  level endon("flag_stop_ambient_airbursts");
  var_0 = level._train.cars["train_loco"].body;
  var_1 = 2;

  for(;;) {
    var_2 = common_scripts\utility::spawn_tag_origin();
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
    var_2 rotatepitch(-90, 0.01);
    wait(level.timestep);
    playFXOnTag(common_scripts\utility::getfx("vfx_airburst_runner_01_attach"), var_2, "tag_origin");
    var_2 thread teleport_ent_generic();
    var_2 thread ambient_airburst_periph_cleanup(var_1);
    wait(var_1);
  }
}

ambient_airburst_periph_cleanup(var_0) {
  wait(var_0);
  stopFXOnTag(common_scripts\utility::getfx("vfx_airburst_runner_01_attach"), self, "tag_origin");
  wait 5;
  self delete();
}

ambient_canyon_airburst_fx_teleport_and_delete() {
  thread teleport_ent_generic();
  wait 10;
  self delete();
}

hero_train_impact(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  common_scripts\utility::flag_set("flag_pause_ambient_train_shakes");
  var_9 = 1.8;
  var_10 = common_scripts\utility::spawn_tag_origin();
  var_10.origin = var_0 gettagorigin("tag_missile_source");
  var_10.angles = var_0 gettagangles("tag_missile_source");
  var_10 thread teleport_ent_generic();
  var_11 = common_scripts\utility::spawn_tag_origin();
  var_11 linkto(var_0, var_1, (0, 0, 0), (0, 0, 0));
  var_12 = common_scripts\utility::spawn_tag_origin();
  var_12 thread teleport_ent_generic();
  var_12 thread blend_link_over_time(var_10, var_11, var_9);
  playFXOnTag(common_scripts\utility::getfx("sathit_missile_trail"), var_12, "tag_origin");
  var_11 thread maps\_utility::play_sound_on_entity("sw_missile_incoming");
  level thread maps\_utility::notify_delay("hero_train_impact_near", var_9 - 1.0);
  level thread maps\_utility::notify_delay("hero_train_impact_ready", var_9 - 0.1);
  wait(var_9);
  level notify("hero_train_impact_hit");

  if(isDefined(var_7))
    level notify("hero_train_impact_hit" + var_7);

  var_11 unlink();
  var_11 thread teleport_ent_generic();
  playFXOnTag(common_scripts\utility::getfx(var_2), var_11, "tag_origin");
  thread impact_train(var_11.origin, 1, var_4, var_5, 1, var_6);
  wait 0.2;

  foreach(var_14 in var_3)
  var_11 thread maps\_utility::play_sound_on_entity(var_14);

  wait 7;

  if(isDefined(var_8) && var_8)
    common_scripts\utility::flag_set("flag_pause_ambient_train_shakes");
  else
    common_scripts\utility::flag_clear("flag_pause_ambient_train_shakes");

  wait 20;
  var_12 delete();
  var_10 delete();
  var_11 delete();
}

impact_train(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.3;

  if(!isDefined(var_2))
    var_2 = 0.7;

  if(!isDefined(var_5))
    var_5 = 1;

  var_7 = level._train train_factor_explosion_time_offset_weight_dir(var_0, var_4, var_1);

  if(var_7 == "R") {
    var_8 = "sathit_R";
    var_9 = "roll_R";
  } else {
    var_8 = "sathit_L";
    var_9 = "roll_L";
  }

  thread train_impact_player_effcts(level._train.cars[level.player.car].overlaydelay, var_9, level._train.cars[level.player.car].overlayweight, var_2, var_3, var_0);

  if(!var_5) {
    return;
  }
  thread maps\skyway_audio::sfx_impact_train(level._train.cars[level.player.car].overlaydelay, level._train.cars[level.player.car].overlayweight, var_7);
  level._train.cars["train_sat_1"] thread sat_acc_overlay(var_8, level._train.cars["train_sat_1"].overlayweight, var_6, level._train.cars["train_sat_1"].overlaydelay);
  level._train.cars["train_sat_2"] thread sat_acc_overlay(var_8, level._train.cars["train_sat_2"].overlayweight, var_6, level._train.cars["train_sat_2"].overlaydelay);
  level._train train_overlay(var_8, undefined, undefined, undefined, var_6);
}

train_impact_player_effcts(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = 0;

  var_6 = 0.35;
  var_7 = 0.07;
  var_8 = 0.6;
  var_9 = 0.1;
  var_10 = 1.0;
  var_11 = 0.3;
  var_12 = factor_value_min_max(var_9, var_8, var_2);
  var_13 = factor_value_min_max(var_7, var_6, var_2);
  var_14 = factor_value_min_max(var_11, var_10, var_2);
  wait(var_0);
  var_15 = var_2 * var_3;

  if(var_3 > 0)
    thread player_view_roll_with_traincar(var_1, var_15);

  thread player_rumble_bump(level.player_rumble_ent, var_14, 0.0, 0.2, 0.0, 0.4);
  thread train_quake(var_13, 1.2, level.player.origin, 128);
  thread player_sway_bump(var_12, 0.1, 1.5, 1.4);

  if(var_4) {
    level.player shellshock("default_nosound", 2);
    level.player thread maps\skyway_fx::shockwave_dirt_hit(1, 0.1, 4);
    radiusdamage(var_5, 3000, 40, 10);
  }
}

ambient_airbursts_player_effcts(var_0) {
  var_1 = 0.19;
  var_2 = 0.05;
  var_3 = 0.2;
  var_4 = 0.05;
  var_5 = distance(var_0.origin, level.player.origin);
  var_6 = 4000;
  var_7 = 18000;
  var_8 = normalize_value(var_6, var_7, var_5);
  var_9 = factor_value_min_max(var_2, var_1, var_8);
  var_10 = factor_value_min_max(var_4, var_3, var_8);
  thread player_rumble_bump(level.player_rumble_amb_ent, var_10, 0.0, 0.2, 0.0, 0.4);
  thread train_quake(var_9, 1.2, level.player.origin, 128);
}

train_factor_explosion_time_offset_weight_dir(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_3 = 100000;
  var_4 = 11000;
  var_5 = 1500;
  var_6 = 7;
  var_7 = 0.38;
  var_8 = 0.18;
  var_9 = "";
  var_10 = var_3;
  var_11 = 0;

  foreach(var_13 in self.cars) {
    var_14 = distance(var_0, var_13.body.origin);
    var_15 = anglestoright(var_13.body.angles);
    var_16 = var_0 - var_13.body.origin;
    var_17 = vectordot(var_15, var_16);
    var_18 = normalize_value(0, var_3, var_14);
    var_13.overlaydelay = factor_value_min_max(0, var_6, var_18);
    var_19 = normalize_value(var_5, var_4, var_14);

    if(isDefined(var_2))
      var_13.overlayweight = var_2;
    else
      var_13.overlayweight = factor_value_min_max(var_7, var_8, var_19);

    if(var_14 < var_10) {
      var_10 = var_14;
      var_11 = var_13.overlaydelay;

      if(var_17 > 0) {
        var_9 = "R";
        continue;
      }

      var_9 = "L";
    }
  }

  foreach(var_13 in self.cars)
  var_13.overlaydelay = var_13.overlaydelay - var_11 * (1 - var_1);

  return var_9;
}

rt_helo_fx_setup(var_0) {
  self.fx_org_tail = common_scripts\utility::spawn_tag_origin();
  self.fx_org_engine = common_scripts\utility::spawn_tag_origin();
  self.fx_org_belly = common_scripts\utility::spawn_tag_origin();
  self.fx_org_belly2 = common_scripts\utility::spawn_tag_origin();
  self.fx_org_tail thread maps\skyway_fx::fx_origin_link_with_train_angles(self, var_0.body, "TAG_tail_damage_fx");
  self.fx_org_engine thread maps\skyway_fx::fx_origin_link_with_train_angles(self, var_0.body, "TAG_engine_damage_fx");
  self.fx_org_belly thread maps\skyway_fx::fx_origin_link_with_train_angles(self, var_0.body, "TAG_belly_damage_fx");
  self.fx_org_belly2 thread maps\skyway_fx::fx_origin_link_with_train_angles(self, var_0.body, "TAG_belly_2_damage_fx");
  self.fx_glass_front = rt_spawn_and_link_helo_glass("rt_helo_glass_front", "glass_front");
  self.fx_glass_front_b = rt_spawn_and_link_helo_glass("rt_helo_glass_front_b", "glass_front_b");
  self.fx_glass_mid_1 = rt_spawn_and_link_helo_glass("rt_helo_glass_mid_1", "glass_mid_1");
  self.fx_glass_mid_2 = rt_spawn_and_link_helo_glass("rt_helo_glass_mid_2", "glass_mid_2");
  self.fx_glass_back = rt_spawn_and_link_helo_glass("rt_helo_glass_back", "glass_back");
  self retargetscriptmodellighting(var_0.body);
  self.fx_glass_front retargetscriptmodellighting(var_0.body);
  self.fx_glass_front_b retargetscriptmodellighting(var_0.body);
  self.fx_glass_mid_1 retargetscriptmodellighting(var_0.body);
  self.fx_glass_mid_2 retargetscriptmodellighting(var_0.body);
  self.fx_glass_back retargetscriptmodellighting(var_0.body);
}

rt_helo_crashed_fx_setup(var_0) {
  self.crashed.fx_org_tail_rotor = common_scripts\utility::spawn_tag_origin();
  self.crashed.fx_org_tail_break = common_scripts\utility::spawn_tag_origin();
  self.crashed.fx_org_body = common_scripts\utility::spawn_tag_origin();
  self.crashed.fx_org_tail_rotor thread maps\skyway_fx::fx_origin_link_with_train_angles(self.crashed, var_0.body, "j_tail_rotor_rear");
  self.crashed.fx_org_tail_break thread maps\skyway_fx::fx_origin_link_with_train_angles(self.crashed, var_0.body, "j_tail_003");
  self.crashed.fx_org_body thread maps\skyway_fx::fx_origin_link_with_train_angles(self.crashed, var_0.body, "TAG_DEATHFX");
}

rt_spawn_and_link_helo_glass(var_0, var_1) {
  var_2 = maps\_utility::spawn_anim_model(var_0);
  var_2 linkto(self, "body_animate_jnt", (0, 0, 0), (0, 0, 0));

  if(isDefined(var_1))
    thread rt_helo_break_glass(var_2, var_1);

  return var_2;
}

rt_helo_break_glass(var_0, var_1) {
  self endon("death");
  var_0 setCanDamage(1);

  if(!isDefined(self.ally_glass_kill))
    self.ally_glass_kill = 0;

  for(;;) {
    var_0 waittill("damage", var_2, var_3);

    if(isPlayer(var_3)) {
      break;
    }

    if(self.ally_glass_kill < 2 && var_1 != "glass_front") {
      self.ally_glass_kill = self.ally_glass_kill + 1;
      break;
    }
  }

  rt_helo_damage_fx(var_1);
}

rt_helo_damage_fx(var_0) {
  switch (var_0) {
    case "belly_damage":
      playFXOnTag(common_scripts\utility::getfx("rt_helo_belly_damage"), self.fx_org_belly, "tag_origin");
      break;
    case "belly_crit":
      break;
    case "belly_death":
      stopFXOnTag(common_scripts\utility::getfx("rt_helo_belly_damage"), self.fx_org_belly, "tag_origin");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_belly_death"), self.fx_org_belly, "tag_origin");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_belly_death2"), self.fx_org_belly2, "tag_origin");
      break;
    case "engine_damage":
      playFXOnTag(common_scripts\utility::getfx("rt_helo_engine_damage"), self.fx_org_engine, "tag_origin");
      break;
    case "engine_crit":
      break;
    case "engine_death":
      stopFXOnTag(common_scripts\utility::getfx("rt_helo_engine_damage"), self.fx_org_engine, "tag_origin");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_engine_death"), self.fx_org_engine, "tag_origin");
      break;
    case "tail_damage":
      playFXOnTag(common_scripts\utility::getfx("rt_helo_tail_damage"), self.fx_org_tail, "tag_origin");
      break;
    case "tail_crit":
      break;
    case "tail_death":
      stopFXOnTag(common_scripts\utility::getfx("rt_helo_tail_damage"), self.fx_org_tail, "tag_origin");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_tail_death"), self.fx_org_tail, "tag_origin");
      self setanimknob(level.scr_anim["rt_helo_small"]["blades_top"]);
      break;
    case "glass_front":
      var_1 = self.fx_glass_front;
      self.fx_glass_front = rt_spawn_and_link_helo_glass("rt_helo_broken_glass_front");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_glass_front"), self.fx_glass_front, "tag_break");
      var_1 delete();
      break;
    case "glass_front_b":
      var_1 = self.fx_glass_front_b;
      self.fx_glass_front_b = rt_spawn_and_link_helo_glass("rt_helo_broken_glass_front_b");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_glass_front_b"), self.fx_glass_front_b, "tag_break");
      var_1 delete();
      break;
    case "glass_back":
      var_1 = self.fx_glass_back;
      self.fx_glass_back = rt_spawn_and_link_helo_glass("rt_helo_broken_glass_back");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_glass_back"), self.fx_glass_back, "tag_break");
      var_1 delete();
      break;
    case "glass_mid_1":
      var_1 = self.fx_glass_mid_1;
      self.fx_glass_mid_1 = rt_spawn_and_link_helo_glass("rt_helo_broken_glass_mid_1");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_glass_mid_1"), self.fx_glass_mid_1, "tag_break");
      var_1 delete();
      break;
    case "glass_mid_2":
      var_1 = self.fx_glass_mid_2;
      self.fx_glass_mid_2 = rt_spawn_and_link_helo_glass("rt_helo_broken_glass_mid_2");
      playFXOnTag(common_scripts\utility::getfx("rt_helo_glass_mid_2"), self.fx_glass_mid_2, "tag_break");
      var_1 delete();
      break;
  }
}

rt_helo_cleanup() {
  stopFXOnTag(common_scripts\utility::getfx("rt_helo_belly_damage"), self.fx_org_belly, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("rt_helo_belly_death"), self.fx_org_belly, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("rt_helo_belly_death2"), self.fx_org_belly2, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("rt_helo_engine_damage"), self.fx_org_engine, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("rt_helo_engine_death"), self.fx_org_engine, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("rt_helo_tail_damage"), self.fx_org_tail, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("rt_helo_tail_death"), self.fx_org_tail, "tag_origin");
  self.org.link1 delete();
  self.org.link2 delete();
  self.fx_org_tail delete();
  self.fx_org_engine delete();
  self.fx_org_belly delete();
  self.fx_org_belly2 delete();
  self.fx_glass_front delete();
  self.fx_glass_front_b delete();
  self.fx_glass_mid_1 delete();
  self.fx_glass_mid_2 delete();
  self.fx_glass_back delete();

  foreach(var_1 in self.riders) {
    if(isDefined(var_1) && isalive(var_1))
      var_1 delete();
  }
}

rt_helo_bullethits() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isPlayer(var_1)) {
      var_12 = rotatevectorinverted(var_3 - var_10, var_11);

      if(var_12[0] < 0)
        thread helo_bullethit_fx(var_12);
    }

    wait(level.timestep);
  }
}

helo_bullethit_fx(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(self, "tag_origin", var_0, (0, 0, 0));
  wait 0.05;
  playFXOnTag(common_scripts\utility::getfx("sw_helo_bullet_hit"), var_1, "tag_origin");
  wait 3;
  var_1 delete();
}

spawn_allies(var_0) {
  var_1 = 1;

  if(level.start_point == "end_beach")
    var_0 = "spawner_allies_swim";

  var_2 = getEntArray(var_0, "script_noteworthy");

  foreach(var_4 in var_2)
  var_4 maps\_utility::add_spawn_function(::spawnfunc_ally);

  if(isDefined(level._ally)) {
    level._ally maps\_utility::stop_magic_bullet_shield();
    level._ally delete();
  }

  level._allies = spawn_allies_group(var_2);
  level._ally = level._allies[0];
  maps\_utility::delaythread(0.05, maps\_utility::set_team_bcvoice, "allies", "taskforce");
}

spawn_allies_group(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(issubstr(var_3.targetname, "ally_01")) {
      var_3.script_friendname = "Hesh";
      var_4 = var_3 maps\_utility::spawn_ai();
      var_4.animname = "ally1";
      var_4.v.invincible = 1;
      var_1[0] = var_4;
      continue;
    }

    if(issubstr(var_3.targetname, "ally_02")) {
      var_3.script_friendname = "Merrick";
      var_4 = var_3 maps\_utility::spawn_ai();
      var_4.animname = "ally2";
      var_1[1] = var_4;
      continue;
    }
  }

  return var_1;
}

spawnfunc_ally() {
  maps\_utility::set_archetype("no_helmet");
  maps\_utility::magic_bullet_shield();
  thread maps\skyway_util_ai::ally_killer_tracker_proc();
  self.hero = 1;
}

spawn_boss(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level._boss)) {
      var_1 = level._boss;
      var_1 maps\_utility::stop_magic_bullet_shield();
      var_1 hide();
      var_1 common_scripts\utility::delaycall(0.05, ::delete);
      level._boss = undefined;
    }
  } else
    var_0 = "actor_boss";

  var_2 = getent(var_0, "targetname") maps\_utility::spawn_ai(1);
  var_2.animname = "boss";
  var_2 maps\_utility::magic_bullet_shield();
  level._boss = var_2;
}

delay_retreat(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_2))
    thread opfor_retreat(var_0, var_2, var_3, var_4, var_5, var_6);

  common_scripts\utility::flag_wait_or_timeout(var_3, var_1);

  if(common_scripts\utility::flag(var_3) && !isDefined(level.opfor_retreat)) {
    thread retreat_proc(var_3, var_4, var_5);
    return;
  }

  thread retreat_proc(var_3, var_4, var_5, var_6);
  level.opfor_retreat = undefined;
}

opfor_retreat(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_2);

  if(var_1 >= 0) {
    while(maps\_utility::get_ai_group_sentient_count(var_0) > var_1)
      wait 0.1;
  } else {
    for(var_6 = var_1; var_6 < 0; var_6++) {
      level waittill("ai_killed", var_7);

      if(!isDefined(var_7.script_aigroup) || var_7.script_aigroup != var_0)
        var_6--;
    }
  }

  level.opfor_retreat = 1;
  common_scripts\utility::flag_set(var_2);
}

retreat_proc(var_0, var_1, var_2, var_3) {
  if(!common_scripts\utility::flag(var_0))
    common_scripts\utility::flag_set(var_0);

  if(isDefined(var_1) && !isarray(var_1))
    var_1 = [var_1];

  if(isDefined(var_1)) {
    var_4 = [];

    foreach(var_6 in var_1) {
      var_6 = getent(var_6, "targetname");

      if(isDefined(var_6))
        var_4[var_4.size] = var_6;
    }

    if(var_4.size > 0)
      var_1 = var_4;
    else
      var_1 = undefined;
  }

  if(isDefined(var_1)) {
    var_1[0] notify("trigger");
    wait 0.05;

    if(isDefined(var_2) && var_2) {
      foreach(var_6 in var_1) {
        if(isDefined(var_6))
          var_6 delete();
      }
    }
  }

  if(isDefined(var_3) && !isarray(var_3))
    var_3 = [var_3];

  if(isDefined(var_3)) {
    foreach(var_11 in var_3)
    level notify(var_11);
  }
}

kt_time(var_0) {
  if(!isDefined(level.killer_tracker))
    return var_0;

  if(level.killer_tracker > 2)
    return var_0 * clamp(level.killer_tracker - 1, 1, 5);

  return var_0;
}

real_reload() {
  self endon("death");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    var_1 = self getcurrentweaponclipammo();
    thread real_reload_proc(var_0, var_1);
  }
}

real_reload_proc(var_0, var_1) {
  self endon("death");
  self endon("weapon_fire");
  self endon("weapon_change");
  self endon("weapon_dropped");
  self waittill("reload");

  if(var_0 == self getcurrentweapon() && var_1 != self getcurrentweaponclipammo()) {
    var_2 = self getweaponammostock(var_0);
    self setweaponammostock(var_0, var_2 - var_1);
  }
}

istrue(var_0) {
  if(isDefined(var_0) && var_0)
    return 1;

  return 0;
}

player_start(var_0) {
  var_1 = var_0;

  if(isstring(var_0))
    var_1 = getent(var_0, "targetname");

  level.player setorigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
}

teleport_ai_instant() {
  self endon("death");
  self teleportentityrelative(self, self.spawner);
  self teleportentityrelative(self.car.ref_start, self.car.ref_end);
}

teleport_ent_generic(var_0) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = level._train;

  for(;;) {
    var_0 waittill("train_teleport_ready");
    wait 0.05;

    if(!self islinked())
      self teleportentityrelative(var_0.path.start_org, var_0.path.end_org);

    wait 0.05;
  }
}

get_local_coords(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = self.origin;

  if(!isDefined(var_2))
    var_2 = self.angles;

  if(isDefined(var_3) && var_3)
    var_0 = common_scripts\utility::drop_to_ground(var_0, 100, -100);

  return rotatevectorinverted(var_0 - var_1, var_2);
}

flag_wait_badplace_brush(var_0, var_1, var_2, var_3, var_4) {
  if(!isarray(var_0))
    var_0 = [var_0, 0];

  if(!isarray(var_3))
    var_3 = [var_3];

  common_scripts\utility::flag_wait(var_0[0]);

  if(var_0.size > 2)
    common_scripts\utility::flag_wait_or_timeout(var_0[2], var_0[1]);
  else
    wait(var_0[1]);

  foreach(var_7, var_6 in var_3)
  badplace_brush_moving(var_1 + var_7, var_2, var_6, "axis", var_4);
}

badplace_brush_moving(var_0, var_1, var_2, var_3, var_4) {
  var_2 endon("death");

  if(isDefined(var_4) && !isarray(var_4))
    var_4 = [var_4, 0];

  var_2.angles = var_2.angles * (0, 1, 0);
  badplace_brush(var_0, var_1, var_2, var_3);
  var_2 thread badplace_brush_flatten_angles();

  if(isDefined(var_4[0])) {
    common_scripts\utility::flag_wait(var_4[0]);
    wait(var_4[1]);
    var_2 delete();
  }
}

badplace_brush_flatten_angles() {
  self endon("death");

  for(;;) {
    wait 0.05;
    self.angles = self.angles * (0, 1, 0);
  }
}

normalize_value(var_0, var_1, var_2) {
  if(var_2 > var_1)
    return 1.0;
  else if(var_2 < var_0)
    return 0.0;

  return (var_2 - var_0) / (var_1 - var_0);
}

factor_value_min_max(var_0, var_1, var_2) {
  return var_1 * var_2 + var_0 * (1 - var_2);
}

fall_check() {
  return !level.player.b_falling;
}

temp_dialogue_line(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level.dialogue_huds))
    level.dialogue_huds = [];

  var_3 = 0;

  for(;;) {
    if(!isDefined(level.dialogue_huds[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(!isDefined(var_2))
    var_2 = 1;

  var_2 = max(1, var_2);
  level.dialogue_huds[var_3] = 1;
  var_5 = maps\_hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait(var_2);
  var_6 = 10.0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 0;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 0.25;
  var_5 destroy();
  level.dialogue_huds[var_3] = undefined;
}

debug_show_pos(var_0) {
  self notify("stop_debug_show_pos");
  self endon("stop_debug_show_pos");
  self endon("death");

  if(!isDefined(var_0))
    var_0 = (1, 1, 1);

  for(;;)
    wait 0.05;
}

notifyanimcomplete(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0.0;

  var_4 = getanimlength(level.scr_anim[var_0.animname][var_1]);
  var_4 = var_4 - var_3;

  if(var_4 < 0)
    var_4 = 0;

  wait(var_4);
  level notify(var_2);
}

show_train_geo(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = [];

  var_2 = getarraykeys(level._train.cars);
  var_3 = level._train.cars;
  level._train.hidden_parts = 0;

  foreach(var_5 in var_2) {
    var_6 = var_3[var_5];
    var_7 = getarraykeys(var_6.other_linked_parts);

    if(isDefined(common_scripts\utility::array_find(var_0, var_5))) {
      var_6.sus_f show_if_defined();
      var_6.sus_b show_if_defined();

      foreach(var_9 in var_6.other_linked_parts)
      common_scripts\utility::array_thread(var_9, ::show_if_defined);

      continue;
    }

    if(var_1.size == 0) {
      var_6.sus_f hide_if_defined();
      var_6.sus_b hide_if_defined();
      level._train.hidden_parts = 2;
      var_1 = var_7;
    } else {
      var_6.sus_f show_if_defined();
      var_6.sus_b show_if_defined();
    }

    foreach(var_12 in var_7) {
      var_9 = var_6.other_linked_parts[var_12];

      if(isDefined(common_scripts\utility::array_find(var_1, var_12))) {
        common_scripts\utility::array_thread(var_9, ::hide_if_defined);
        level._train.hidden_parts = level._train.hidden_parts + var_9.size;
        continue;
      }

      common_scripts\utility::array_thread(var_9, ::show_if_defined);
    }
  }
}

show_if_defined() {
  if(!isDefined(self) || isDefined(self.noshow) && self.noshow) {
    return;
  }
  self show();
}

hide_if_defined() {
  if(!isDefined(self) || isDefined(self.nohide) && self.nohide) {
    return;
  }
  self hide();
}

hidenoshow() {
  self hide();
  setnoshow(1);
}

shownoshow() {
  self show();
  setnoshow(0);
}

setnoshow(var_0) {
  self.noshow = var_0;
}

setnohide(var_0) {
  self.nohide = var_0;
}

create_view_particle_source() {
  if(!isDefined(self._source)) {
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = self getEye();
    var_1 = var_0 common_scripts\utility::spawn_tag_origin();
    var_1 linkto(self);
    self._source = var_0;
    self._source_base = var_1;
    thread start_current_car_watcher();

    if(self == level.player)
      level.view_particle_source = var_0;
  }
}

start_current_car_watcher() {
  self endon("death");
  self endon("stop_current_car_watcher");
  self.car = "none";
  self.b_falling = 0;

  for(;;) {
    var_0 = self getmovingplatformparent();

    if(isDefined(var_0) && isDefined(var_0.script_noteworthy) && issubstr(var_0.script_noteworthy, "train")) {
      var_1 = var_0.script_noteworthy;

      if(self.car != var_1)
        self.car = var_1;

      if(self.b_falling)
        self.b_falling = 0;
    } else if(!self.b_falling)
      self.b_falling = 1;

    if(isDefined(self._source) && self.car != "none") {
      self._source.origin = self._source_base.origin;
      self._source.angles = level._train.cars[self.car].body.angles;
    }

    wait 0.05;
  }
}

stop_current_car_watcher() {
  self notify("stop_current_car_watcher");

  if(isDefined(self._source))
    self._source delete();
}

getcurrenttraincar() {
  for(var_0 = 0; var_0 < 3; var_0++) {
    var_1 = self getmovingplatformparent();

    if(isDefined(var_1) && isDefined(var_1.script_noteworthy) && issubstr(var_1.script_noteworthy, "train"))
      return var_1.script_noteworthy;

    wait 0.05;
  }

  return undefined;
}

linktotrain(var_0) {
  self linkto(level._train.cars[var_0].body, "j_spineupper");
}

trig_watcher(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    level endon(var_3);

  var_4 = "flag_" + var_0;

  if(!common_scripts\utility::flag_exist(var_4))
    common_scripts\utility::flag_init(var_4);

  for(;;) {
    maps\_utility::trigger_wait_targetname(var_0);

    if(isDefined(var_1) && !common_scripts\utility::flag(var_4))
      thread[[var_1]]();

    common_scripts\utility::flag_set(var_4);
    level notify(var_4 + "set");
    thread trig_watcher_off(var_4, var_2);
  }
}

trig_watcher_off(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level endon(var_2);

  level endon(var_0 + "set");
  wait 0.1;
  common_scripts\utility::flag_clear(var_0);

  if(isDefined(var_1))
    thread[[var_1]]();
}

dialogue_nag(var_0, var_1, var_2) {
  if(isDefined(var_1))
    level endon(var_1);

  var_3 = 0;

  if(self == level)
    var_3 = 1;

  foreach(var_5 in var_0) {
    wait(randomfloatrange(5, 8));

    if(var_3) {
      thread maps\_utility::smart_radio_dialogue(var_5);
      continue;
    }

    thread maps\_utility::smart_dialogue(var_5);
  }

  if(isDefined(var_2)) {
    thread[[var_2]]();
    return;
  }

  var_7 = var_0;

  for(;;) {
    if(var_7.size == 0)
      var_7 = var_0;

    wait 13;
    var_5 = common_scripts\utility::random(var_7);
    var_7 = common_scripts\utility::array_remove(var_7, var_5);

    if(var_3) {
      thread maps\_utility::smart_radio_dialogue(var_5);
      continue;
    }

    thread maps\_utility::smart_dialogue(var_5);
  }
}

spawn_tag_origin_from_tag(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self gettagorigin(var_0);
  var_2.angles = self gettagangles(var_0);

  if(isDefined(var_1))
    var_2 linkto(var_1);

  return var_2;
}

death_watcher() {
  common_scripts\utility::flag_wait_either("flag_kill_plane", "flag_death_crush");
  level.player enableinvulnerability();
  var_0 = &"SKYWAY_FAIL_KILL_PLANE";
  var_1 = level.player.origin;
  wait 0.05;
  var_2 = level.player.origin;
  var_3 = (var_2 - var_1) * 20;
  var_3 = var_3 - (0, 0, 128);
  level.player thread maps\skyway_audio::skyway_death_fall_sfx();
  setup_player_for_animated_sequence(0, 0);
  var_4 = level.player_rig;
  var_5 = level.player_mover;
  var_4 thread maps\_anim::anim_single_solo(var_4, "death_fall");
  level.player playerlinktoblend(var_4, "tag_player", 0.5);
  level.player hideviewmodel();
  var_5 movegravity(var_3, 8);
  var_6 = 0;
  var_7 = 0;
  var_8 = 2;
  var_9 = 0;

  for(var_10 = 0; var_10 < var_8 + 1; var_10 = var_10 + 0.05) {
    var_3 = var_3 * 2;
    var_11 = (0, 0, -128);
    var_12 = anglesToForward(level.player_mover.angles) * 128;
    var_13["fall_direction"] = bulletTrace(level.player.origin, level.player.origin + var_3, 0);
    var_13["down"] = bulletTrace(level.player.origin, level.player.origin + var_11, 0);
    var_13["forward"] = bulletTrace(level.player.origin, level.player.origin + var_12, 0);

    foreach(var_17, var_15 in var_13) {
      if(var_15["surfacetype"] != "none") {
        var_16 = var_15["entity"];

        if(isDefined(var_16)) {
          if(isDefined(var_16.script_noteworthy) && isDefined(level._train.cars[var_16.script_noteworthy])) {
            continue;
          }
          if(isDefined(var_16.targetname) && issubstr(var_16.targetname, "sat"))
            continue;
        }

        var_6 = 1;
        break;
      }

      if(common_scripts\utility::flag("flag_death_crush") && !var_7) {
        level.player dodamage(1000, level.player.origin);
        earthquake(1.0, 0.6, level.player.origin, 128);
        thread blur(0.5, 20, 0, 1);
        var_7 = 1;
      }
    }

    if((var_6 || var_10 >= var_8) && !var_9) {
      setDvar("ui_deadquote", var_0);
      maps\_utility::missionfailedwrapper();
      var_9 = 1;
    }

    if(var_6) {
      var_4 hide();
      var_4 unlink();
      level.player dodamage(1000, level.player.origin);
      earthquake(1.0, 0.6, level.player.origin, 128);
      return;
    }

    var_1 = level.player_mover.origin;
    wait 0.05;
    var_2 = level.player_mover.origin;
    var_3 = var_2 - var_1;
  }
}

blur(var_0, var_1, var_2, var_3) {
  setblur(var_1, 0);
  wait(var_0);
  setblur(var_2, var_3);
}

setup_player_for_animated_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0) {
    if(!isDefined(var_1))
      var_1 = 60;
  }

  if(!isDefined(var_8))
    var_8 = 1;

  if(!isDefined(var_2))
    var_2 = level.player.origin;

  if(!isDefined(var_3))
    var_3 = level.player.angles;

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_6))
    var_6 = "player_rig";

  var_9 = maps\_utility::spawn_anim_model(var_6, var_2);
  level.player_rig = var_9;
  var_9.angles = var_3;
  var_9.animname = var_6;

  if(isDefined(var_7))
    var_10 = maps\_utility::spawn_anim_model(var_7);
  else
    var_10 = common_scripts\utility::spawn_tag_origin();

  level.player_mover = var_10;
  var_10.origin = var_2;
  var_10.angles = var_3;
  var_9 linkto(var_10);

  if(var_0) {
    if(isarray(var_1))
      level.player playerlinktodelta(var_9, "tag_player", var_8, var_1[0], var_1[1], var_1[2], var_1[3], 1);
    else
      level.player playerlinktodelta(var_9, "tag_player", var_8, var_1, var_1, var_1, var_1, 1);
  }

  if(var_4)
    thread player_animated_sequence_restrictions(var_5);
}

player_animated_sequence_restrictions(var_0) {
  if(isDefined(var_0) && var_0)
    level.player waittill("notify_player_animated_sequence_restrictions");

  level.player.disablereload = 1;
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player disableweaponswitch();
  level.player allowcrouch(0);
  level.player allowjump(0);
  level.player allowmelee(0);
  level.player allowprone(0);
  level.player allowsprint(0);
}

player_animated_sequence_cleanup() {
  if(!isDefined(level.player.early_weapon_enabled) || !level.player.early_weapon_enabled) {
    level.player.early_weapon_enabled = undefined;
    level.player.disablereload = 0;
    level.player enableweapons();
    level.player enableoffhandweapons();
    level.player enableweaponswitch();
  }

  level.player allowcrouch(1);
  level.player allowjump(1);
  level.player allowmelee(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player unlink();

  if(isDefined(level.player_mover))
    level.player_mover delete();

  if(isDefined(level.player_rig))
    level.player_rig delete();
}

check_anim_time(var_0, var_1, var_2) {
  var_3 = self getanimtime(level.scr_anim[var_0][var_1]);

  if(var_3 >= var_2)
    return 1;

  return 0;
}

dynamic_sun_sample_size() {
  var_0 = 1.0;
  var_1 = 0.3;
  var_2 = 0.25;

  for(;;) {
    var_3 = level.player getplayerangles();
    var_4 = combineangles((0, -90, 0), var_3);
    var_4 = anglesToForward(var_4);
    var_5 = vectordot(vectornormalize(var_4), (0, 0, -1));
    var_5 = clamp(var_5, 0, 1);
    var_6 = var_1 - var_0;
    var_2 = var_6 * var_5 + var_0;
    setsaveddvar("sm_sunSampleSizeNear", var_2);
    wait 0.05;
  }
}

set_motionblur_values(var_0, var_1, var_2, var_3, var_4) {
  if(maps\_utility::is_gen4()) {
    var_5 = getdvarfloat("r_mbCameraRotationInfluence");
    var_6 = getdvarfloat("r_mbCameraTranslationInfluence");
    var_7 = getdvarfloat("r_mbModelVelocityScalar");
    var_8 = getdvarfloat("r_mbStaticVelocityScalar");
    var_9 = 0;
    var_10 = var_4 / level.timestep;

    while(var_9 < var_4) {
      if(isDefined(var_0)) {
        if(var_5 != var_0) {
          var_11 = clamp(getdvarfloat("r_mbCameraRotationInfluence") + (var_0 - var_5) / var_10, 0, 1);
          setsaveddvar("r_mbCameraRotationInfluence", var_11);
        }
      } else {}

      if(isDefined(var_1)) {
        if(var_6 != var_1) {
          var_12 = clamp(getdvarfloat("r_mbCameraTranslationInfluence") + (var_1 - var_6) / var_10, 0, 1);
          setsaveddvar("r_mbCameraTranslationInfluence", var_12);
        }
      } else {}

      if(isDefined(var_2)) {
        if(var_7 != var_2) {
          var_13 = clamp(getdvarfloat("r_mbModelVelocityScalar") + (var_2 - var_7) / var_10, 0, 1000);
          setsaveddvar("r_mbModelVelocityScalar", var_13);
        }
      } else {}

      if(isDefined(var_3)) {
        if(var_8 != var_3) {
          var_14 = clamp(getdvarfloat("r_mbStaticVelocityScalar") + (var_3 - var_8) / var_10, 0, 1000);
          setsaveddvar("r_mbStaticVelocityScalar", var_14);
        }
      } else {}

      var_9 = var_9 + level.timestep;
      wait(level.timestep);
    }
  }
}

flag_watcher(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    level endon(var_3);

  if(!common_scripts\utility::flag_exist(var_0))
    common_scripts\utility::flag_init(var_0);

  var_4 = 0;

  for(;;) {
    if(common_scripts\utility::flag(var_0) && !var_4) {
      if(isDefined(var_1))
        self thread[[var_1]]();

      var_4 = 1;
    } else if(!common_scripts\utility::flag(var_0) && var_4) {
      if(isDefined(var_2))
        self thread[[var_2]]();

      var_4 = 0;
    }

    wait 0.05;
  }
}

wind_watcher() {
  level endon("stop_wind_watcher");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(common_scripts\utility::flag("wind_3"))
      var_0 = 3;
    else if(common_scripts\utility::flag("wind_2"))
      var_0 = 2;
    else if(common_scripts\utility::flag("wind_1"))
      var_0 = 1;
    else
      var_0 = 0;

    common_scripts\utility::flag_clear("wind_3");
    common_scripts\utility::flag_clear("wind_2");
    common_scripts\utility::flag_clear("wind_1");

    if(var_0 != var_1)
      wind_funcs(var_0);

    var_1 = var_0;
    wait 0.05;
  }
}

stop_wind_watcher() {
  level notify("stop_wind");
  level notify("stop_wind_watcher");
}

wind_funcs(var_0) {
  level notify("stop_wind");

  switch (var_0) {
    case 3:
      thread maps\skyway_fx::fx_like_dust_in_the_wind_03();
      break;
    case 2:
      thread maps\skyway_fx::fx_like_dust_in_the_wind_02();
      break;
    case 1:
      thread maps\skyway_fx::fx_like_dust_in_the_wind_01();
      break;
    case 0:
  }
}

setup_door(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isstring(var_0))
    var_3 = getent(var_0, "targetname");
  else
    var_3 = var_0;

  if(var_3.classname != "script_model" && var_3.classname != "script_brushmodel") {}

  var_4 = undefined;

  if(isDefined(var_3.target)) {
    var_5 = getEntArray(var_3.target, "targetname");

    foreach(var_7 in var_5) {
      if(var_7.classname == "script_brushmodel") {
        var_4 = var_7;
        continue;
      }

      if(var_7.classname == "script_origin") {
        if(!isDefined(var_2)) {
          var_3.hinge = var_7;
          var_3.hinge.tag_name = var_2;
          var_3 linkto(var_3.hinge);
        }
      }
    }
  }

  if(isDefined(var_2)) {
    var_3.hinge = common_scripts\utility::spawn_tag_origin();
    var_3.hinge.origin = var_3 gettagorigin(var_2);
    var_3.hinge.angles = var_3 gettagangles(var_2);

    if(!isDefined(var_1))
      var_3 linkto(var_3.hinge);
  }

  if(isDefined(var_4)) {
    var_3.col_brush = var_4;

    if(isDefined(var_2))
      var_3.col_brush linkto(var_3, var_2);
    else
      var_3.col_brush linkto(var_3);
  } else if(var_3.classname == "script_brushmodel")
    var_3.col_brush = var_3;

  var_3.original_angles = var_3.angles;
  var_3.original_origin = var_3.origin;

  if(isDefined(var_1))
    var_3 maps\_utility::assign_animtree(var_1);

  return var_3;
}

waittill_look_yaw(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = vectortoyaw(var_1 - var_0);

  for(;;) {
    var_5 = level.player.angles[1];

    if(var_3) {
      if(angleclamp180(var_5 - var_4) < var_2)
        return;
    } else if(angleclamp180(var_5 - var_4) > var_2) {
      return;
    }
    wait 0.05;
  }
}

waittill_looking(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("notify_force_rorke");
  var_6 = undefined;

  if(isDefined(var_4))
    var_6 = var_4;

  if(isDefined(var_5) && !common_scripts\utility::flag_exist(var_5))
    common_scripts\utility::flag_init(var_5);

  var_7 = 0.5;

  if(isDefined(var_2))
    var_7 = var_2;

  var_8 = 1;

  if(isDefined(var_3) && !var_3)
    var_8 = 0;

  var_9 = undefined;

  if(isDefined(var_1))
    var_0 = var_0 gettagorigin(var_1);
  else
    var_0 = var_0.origin;

  for(;;) {
    if(level.player maps\_utility::player_looking_at(var_0, var_7, 1))
      var_9 = 1;
    else
      var_9 = 0;

    if(var_9 && var_8) {
      break;
    }

    if(!var_9 && !var_8) {
      break;
    }

    wait 0.05;

    if(isDefined(var_6)) {
      var_6 = var_6 - 0.05;

      if(var_6 <= 0) {
        break;
      }
    }
  }

  if(isDefined(var_5))
    common_scripts\utility::flag_set(var_5);
}

smooth_player_link(var_0, var_1) {
  level.player playerlinktoblend(var_0, "tag_player", var_1);
  wait(var_1);
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  var_0 show();
}

vision_watcher(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.flag[var_0]))
    common_scripts\utility::flag_init(var_0);

  if(!isDefined(level._vision_sets_active))
    level._vision_sets_active = 0;

  thread vision_watcher_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

vision_watcher_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_7))
    level endon(var_7);

  var_8 = 0;

  for(;;) {
    if(common_scripts\utility::flag(var_0) && !var_8) {
      maps\_utility::vision_set_fog_changes(var_1, var_2);

      if(isDefined(var_5))
        thread[[var_5]]();

      var_8 = 1;
      level._vision_sets_active++;
    } else if(!common_scripts\utility::flag(var_0) && var_8) {
      if(level._vision_sets_active == 1)
        maps\_utility::vision_set_fog_changes(var_3, var_4);

      if(isDefined(var_6))
        thread[[var_6]]();

      var_8 = 0;
      level._vision_sets_active--;
    }

    wait 0.05;
  }
}

waittill_notify_flag_set(var_0, var_1) {
  if(!common_scripts\utility::flag_exist(var_1))
    common_scripts\utility::flag_init(var_1);

  self waittill(var_0);
  common_scripts\utility::flag_set(var_1);
}

waittill_nt(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && !common_scripts\utility::flag_exist(var_3))
    common_scripts\utility::flag_init(var_3);

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = getnotetracktimes(var_0, var_1)[0];
  var_5 = var_4 * getanimlength(var_0) + var_2;
  wait(var_5);

  if(isDefined(var_3))
    common_scripts\utility::flag_set(var_3);
}

waittill_notify_func(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3))
    self[[var_1]](var_2, var_3);
  else if(isDefined(var_2))
    self[[var_1]](var_2);
  else
    self[[var_1]]();
}

black_overlay(var_0) {
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 0;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.foreground = 1;
  var_1.sort = -999;
  var_1 setshader("black", 650, 490);
  var_1.alpha = 1;
  wait(var_0);
  var_1.alpha = 0;
  var_1 destroy();
  var_1 = undefined;
}

skyway_introscreen(var_0, var_1) {
  level.chyron = spawnStruct();
  level.chyron.huds = [];
  level.chyron.strips = [];
  level.chyron.last_strips = [];
  level.chyron.artifacts = [];
  level.chyron.text_x = 20;
  level.chyron.text_y = -82;
  level.chyron.text_incoming = 0;
  level.chyron.strips_disabled = 0;
  level.chyron.sound_org = spawn("script_origin", level.player.origin);
  level.chyron.sound_org linkto(level.player);
  level.chyron.no_bg = 0;
  maps\_introscreen::chyron_sound(0, "ui_chyron_on");
  thread maps\_introscreen::strips(0);
  var_2 = 0.4;
  thread maps\_introscreen::quick_cursor(0, var_2);
  wait(var_2);
  maps\_introscreen::sub_line(level.introscreen.lines[1], 0);
  wait 0.5;
  var_3 = maps\_introscreen::sub_line(level.introscreen.lines[2], 1, "default", 1, 1);
  wait 0.5;
  var_3 = maps\_introscreen::sub_line(level.introscreen.lines[3], 2, "default", 1, 1);
  var_3.color = (0.68, 0.744, 0.736);
  wait 1;
  level.chyron.strips_disabled = 1;
  wait 2;
  level.chyron.strips_disabled = 0;
  wait 1;
  maps\_introscreen::chyron_sound(0, "ui_chyron_off");
  maps\_introscreen::faze_out(0, 1);
  level notify("stop_chyron");
  level.chyron.sound_org delete();
  level.chyron = undefined;
}

skyway_introscreen_15_mins(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
    var_2 = 1;
  }

  if(isDefined(var_1)) {
    var_0 = 1;
    maps\_hud_util::start_overlay();
    level.player freezecontrols(1);
    level.player common_scripts\utility::delaycall(var_1, ::freezecontrols, 0);
    maps\_utility::delaythread(var_1, ::skyway_introscreen_fade_in);
  }

  level.chyron = spawnStruct();
  level.chyron.huds = [];
  level.chyron.strips = [];
  level.chyron.last_strips = [];
  level.chyron.artifacts = [];
  level.chyron.text_x = -170;
  level.chyron.text_y = -50;
  level.chyron.text_incoming = 0;
  level.chyron.strips_disabled = 0;
  level.chyron.sound_org = spawn("script_origin", level.player.origin);
  level.chyron.sound_org linkto(level.player);
  wait 1;
  maps\_introscreen::chyron_sound(0, "ui_chyron_on");
  var_3 = 0.4;
  thread cursor(0, var_3);
  wait(var_3);
  maps\_introscreen::chyron_sound(0, "ui_chyron_firstline");
  big_message(&"SKYWAY_INTROSCREEN_TIMEBEFORE", 3.5);
  maps\_introscreen::chyron_sound(0, "ui_chyron_off");
  maps\_introscreen::faze_out(0, var_0);
  level notify("stop_chyron");
  level.chyron.sound_org delete();
  level.chyron = undefined;
}

skyway_introscreen_fade_in() {
  var_0 = level.player maps\_hud_util::get_overlay("black");
  var_0.alpha = 0;
  level.player freezecontrols(0);
}

cursor(var_0, var_1) {
  wait 0.5;
  var_2 = newhudelem();
  var_2.x = level.chyron.text_x;
  var_2.y = level.chyron.text_y;
  var_2.vertalign = "middle";
  var_2.fontscale = 3;
  var_2.horzalign = "center";
  var_2.aligny = "middle";
  var_2.sort = 1;
  var_2.foreground = 1;
  var_2.hidewheninmenu = 1;
  var_2.alpha = 0.8;
  var_2 setshader("white", 1, 35);
  var_2.color = (0.85, 0.93, 0.92);
  var_2 moveovertime(var_1);
  var_2 fadeovertime(var_1 * 0.5);
  var_2.alpha = 0;
  var_2.x = var_2.x + 300;
  wait 0.4;
  var_2 destroy();
}

big_message(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = level.chyron.text_x;
  var_2.y = level.chyron.text_y;
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  var_2.aligny = "middle";
  var_2.sort = 3;
  var_2.foreground = 1;
  var_2 settext(var_0);
  var_2.text = var_0;
  var_2.alpha = 0;
  var_2.hidewheninmenu = 1;
  var_2.fontscale = 2.4;
  var_2.color = (0.85, 0.93, 0.92);
  var_2.font = "default";
  level.chyron.huds[level.chyron.huds.size] = var_2;
  level.chyron.text_incoming_x = var_2.x;
  level.chyron.text_incoming_y = var_2.y;
  level.chyron.text_incoming = 1;
  wait 0.5;
  var_3 = dupe_hud(var_0);
  var_3 maps\_utility::delaythread(1, ::location_dupes_thread, var_1 - 1);
  var_2.glowalpha = 0.05;
  var_2.glowcolor = var_2.color;
  var_4 = 0.3;
  var_2 moveovertime(var_4);
  var_2 fadeovertime(var_4 * 3);
  var_2.y = var_2.y + 10;
  var_5 = 0.5;
  var_5 = var_5 - var_4;
  wait(var_4);
  var_2 thread maps\_introscreen::quick_pulse(0);
  var_2 setpulsefx(30, 50000, 700);

  if(randomint(100) > 10)
    var_2 maps\_utility::delaythread(2, maps\_introscreen::offset_thread, -7, 7, 3, -5, 5, 3);

  level.chyron.text_incoming = 0;
  wait(var_1);
}

dupe_hud(var_0) {
  var_1 = newhudelem();
  var_1.x = level.chyron.text_x;
  var_1.y = level.chyron.text_y;
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.aligny = "middle";
  var_1.sort = 3;
  var_1.foreground = 1;
  var_1 settext(var_0);
  var_1.text = var_0;
  var_1.alpha = 0;
  var_1.hidewheninmenu = 1;
  var_1.fontscale = 2.4;
  var_1.color = (0.85, 0.93, 0.92);
  var_1.font = "default";
  level.chyron.huds[level.chyron.huds.size] = var_1;
  return var_1;
}

location_dupes_thread(var_0) {
  var_1 = self.x;
  var_2 = self.y;
  self.x = self.x + randomintrange(-30, -10);
  self.y = self.y + randomintrange(10, 20);
  var_3 = 0.15;
  self moveovertime(var_3);
  self.x = var_1;
  self.y = var_2;
  self fadeovertime(var_3);
  self.alpha = 0.1;
  wait(var_3);
  self moveovertime(var_0);
  self.x = self.x + randomintrange(15, 20);
  self.y = self.y + randomintrange(-4, 4);
  wait(var_0);
  var_3 = 0.05;
  self moveovertime(var_3);
  self.x = var_1;
  self.y = var_2;
  wait(var_3);
  self fadeovertime(var_3);
  self.alpha = 0;
}

player_random_blur(var_0, var_1, var_2) {
  level endon(var_0);
  thread player_random_blur_cleanup(var_0);

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 2;

  var_3 = 0.0;

  for(;;) {
    wait(level.timestep);

    if(randomint(100) > 10) {
      continue;
    }
    var_4 = randomint(4) + var_2;
    var_5 = randomfloatrange(1, 2);
    var_5 = var_5 + var_3;
    var_6 = randomfloatrange(1, 2);
    setblur(var_4 * 1.2, var_5);
    wait(var_5);
    setblur(0, var_6);
    var_7 = randomfloatrange(2.0, 3.0);
    wait(var_7);
    var_3 = var_3 + var_1;
  }
}

player_random_blur_cleanup(var_0) {
  level waittill(var_0);
  var_1 = randomfloatrange(1, 2);
  setblur(0, var_1);
}

waittill_trigger_activate_looking_at(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0.5;

  if(isDefined(var_3))
    var_7 = var_3;

  var_8 = 64;

  if(isDefined(var_2))
    var_8 = var_2;

  var_9 = var_0;

  if(isDefined(var_4)) {
    var_9 = var_0 common_scripts\utility::spawn_tag_origin();
    var_9 linkto(var_0, var_4, (0, 0, 0), (0, 0, 0));
  }

  if(!isDefined(var_5))
    var_5 = 5;

  var_10 = var_1;

  if(!common_scripts\utility::flag_exist(var_10))
    common_scripts\utility::flag_init(var_10);

  var_11 = 0;
  var_12 = 0;

  for(;;) {
    if(level.player ismeleeing() || level.player isthrowinggrenade() || !level.player isonground() || level.player getstance() == "prone") {
      common_scripts\utility::flag_clear(var_10);
      var_12 = 0;
      level.player enableweaponpickup();
    } else if(level.player maps\_utility::player_looking_at(var_9.origin, var_7, 1)) {
      if(isDefined(var_6)) {
        if(common_scripts\utility::flag(var_6)) {
          if(!common_scripts\utility::flag(var_10))
            var_11 = 1;
        } else {
          common_scripts\utility::flag_clear(var_10);
          var_12 = 0;
          level.player enableweaponpickup();
        }
      } else if(distance(level.player getEye(), var_9.origin) <= var_8) {
        if(!common_scripts\utility::flag(var_10))
          var_11 = 1;
      } else {
        common_scripts\utility::flag_clear(var_10);
        var_12 = 0;
        level.player enableweaponpickup();
      }
    } else {
      common_scripts\utility::flag_clear(var_10);
      var_12 = 0;
      level.player enableweaponpickup();
    }

    if(level.player usebuttonpressed())
      var_12++;

    if(common_scripts\utility::flag(var_10) && var_12 >= var_5) {
      break;
    }

    if(var_11) {
      common_scripts\utility::flag_set(var_10);
      maps\_utility::display_hint_timeout(var_1);
      var_11 = 0;
      level.player disableweaponpickup();
    }

    wait 0.05;
  }

  level.player enableweaponpickup();
  common_scripts\utility::flag_clear(var_10);

  if(isDefined(var_4))
    var_9 delete();
}

set_twitch(var_0) {
  if(var_0)
    self.a.bdisablemovetwitch = 0;
  else
    self.a.bdisablemovetwitch = 1;
}

flag_wait_func(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait(var_0);

  if(isDefined(var_2))
    self[[var_1]](var_2);
  else
    self[[var_1]]();
}

waittill_func(var_0, var_1, var_2) {
  self waittill(var_0);

  if(isDefined(var_2))
    self[[var_1]](var_2);
  else
    self[[var_1]]();
}

spawnfunc_death_override() {
  if(isDefined(self._death_override)) {
    return;
  }
  self endon("death");

  if(!isDefined(level._death_anims))
    level._death_anims = [];

  self._death_override = 0;

  for(;;) {
    if(isDefined(self.node) && isDefined(self.node.script_nodestate) && check_angles(self.angles, self.node.angles)) {
      if(!self._death_override) {
        if(isDefined(self.animname))
          self.animname_old = self.animname;

        self._old_health = self.health;
        self.health = 1;
        self.animname = "generic";
        var_0 = strtok(self.node.script_nodestate, " ");
        var_0 = common_scripts\utility::array_randomize(var_0);
        var_1 = undefined;

        foreach(var_3 in var_0) {
          var_4 = maps\_utility::getanim(var_3);

          if(!isDefined(common_scripts\utility::array_find(level._death_anims, var_4))) {
            level._death_anims = common_scripts\utility::array_add(level._death_anims, var_4);
            var_1 = var_3;
            break;
          }
        }

        if(!isDefined(var_1)) {
          if(var_0.size > 1) {
            for(var_6 = 1; var_6 < var_0.size; var_6++)
              level._death_anims = common_scripts\utility::array_remove(level._death_anims, maps\_utility::getanim(var_0[var_6]));
          }

          var_1 = var_0[0];
        }

        var_7 = 0;
        var_8 = ["sw_op_crouch_rail_front", "sw_op_crouch_rail_left", "sw_op_crouch_rail_right", "sw_op_stand_rail_back", "sw_op_stand_rail_front", "sw_op_stand_rail_left", "sw_op_stand_rail_right"];

        if(isDefined(common_scripts\utility::array_find(var_8, var_1)))
          var_7 = 1;

        if(var_7)
          thread death_freefall();

        maps\_utility::set_deathanim(var_1);
        self._death_override = 1;
      }
    } else if(self._death_override) {
      if(isDefined(self.animname_old)) {
        self.animname = self.animname_old;
        self.animname_old = undefined;
      }

      level._death_anims = common_scripts\utility::array_remove(level._death_anims, self.deathanim);
      maps\_utility::clear_deathanim();
      self notify("stop_death_freefall");
      self._death_override = 0;
      self.health = self._old_health;
      self._old_health = undefined;
    }

    wait 0.05;
  }
}

death_freefall() {
  self endon("stop_death_freefall");
  self waittill("death");
  wait(getanimlength(self.deathanim));
  self forcedeathfall(1);
}

check_angles(var_0, var_1, var_2) {
  if(distancesquared(self.origin, self.node.origin) > 1024)
    return 0;

  if(!isDefined(var_2))
    var_2 = 8;

  var_0 = angleclamp(var_0[1]);
  var_1 = angleclamp(var_1[1]);

  if(abs(int(var_0) - int(var_1)) <= var_2)
    return 1;
  else
    return 0;
}

rog_flash(var_0, var_1, var_2) {
  var_3 = level.lvl_visionset;
  var_4 = "skyway_rogstrike";

  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = 0.5;

  if(!isDefined(var_2))
    var_2 = 1;

  var_5 = var_0 / (var_1 / 0.05);
  var_6 = 0;
  maps\_utility::vision_set_fog_changes(var_4, var_1);
  wait(var_1);
  maps\_utility::vision_set_fog_changes(var_3, var_2);
}

ammo_hack(var_0) {
  while(!isDefined(var_0) || var_0.size == 0) {
    var_0 = self getweaponslistall();
    wait 0.05;
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    self givestartammo(var_0[var_1]);

  self setoffhandprimaryclass("other");
}

skyway_hide_hud() {
  level.skyway_hud = 1;
  level.skyway_hud_ammocounterhide = getdvarint("ammoCounterHide");
  level.skyway_hud_actionslotshide = getdvarint("actionSlotsHide");
  level.skyway_hud_showstance = getdvarint("hud_showStance");
  level.skyway_hud_compass = getdvarint("compass");
  level.skyway_hud_g_friendlynamedist = getdvarint("g_friendlyNameDist");
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("compass", 0);
  setsaveddvar("g_friendlyNameDist", 0);
}

skyway_show_previous_hud() {
  if(!isDefined(level.skyway_hud)) {
    return;
  }
  setsaveddvar("ammoCounterHide", level.skyway_hud_ammocounterhide);
  setsaveddvar("actionSlotsHide", level.skyway_hud_actionslotshide);
  setsaveddvar("hud_showStance", level.skyway_hud_showstance);
  setsaveddvar("compass", level.skyway_hud_compass);
  setsaveddvar("g_friendlyNameDist", level.skyway_hud_g_friendlynamedist);
  level.skyway_hud = undefined;
  level.skyway_hud_ammocounterhide = undefined;
  level.skyway_hud_actionslotshide = undefined;
  level.skyway_hud_showstance = undefined;
  level.skyway_hud_compass = undefined;
  level.skyway_hud_g_friendlynamedist = undefined;
}

anim_reach_sw(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = getstartorigin(self.origin, self.angles, var_0 maps\_utility::getanim(var_1));
  var_2.angles = getstartorigin(self.origin, self.angles, var_0 maps\_utility::getanim(var_1));
  var_2 linktotrain(self.script_noteworthy);
  var_0 maps\_utility::disable_ai_color();
  var_0.oldgoalradius = var_0.goalradius;
  var_0.goalradius = 64;
  var_0 setgoalentity(var_2);
  var_0 waittill("goal");
  var_0.goalradius = var_0.oldgoalradius;
  var_0 maps\_utility::enable_ai_color();
  maps\_anim::anim_reach_solo(var_0, var_1);
}

start_point_is_after(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_0 = tolower(var_0);
  var_4 = getarraykeys(level.start_arrays);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] == var_0)
      var_2 = var_5;

    if(var_4[var_5] == level.start_point)
      var_3 = var_5;
  }

  if(isDefined(var_1) && var_1) {
    if(var_3 >= var_2)
      return 1;
  } else if(var_3 > var_2)
    return 1;

  return 0;
}

start_nt_rumbles() {
  self endon("stop_nt_rumbles");
  self endon("death");

  for(;;) {
    level waittill("rumble_medium");
    level.player playrumbleonentity("damage_heavy");
  }
}

stop_nt_rumbles() {
  self notify("stop_nt_rumbles");
}