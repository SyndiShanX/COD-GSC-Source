/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\townhoused\townhoused_inner.gsc
***************************************************/

backyard_intro() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  scripts\engine\utility::flag_init("skip_intro");
  scripts\engine\utility::flag_init("intro_anim_started");
  hidecinematicletterboxing(0, 0);
  setomnvar("ui_hide_hud", 1);
  level.player scripts\sp\player::focusdisable();
  level.player setclienttriggeraudiozone("th_intro_bink_only_dx", 0.01);
  level.player setcinematicmotionoverride("disabled");
  var_0 = getspawner("kyle", "targetname");
  var_1 = scripts\engine\sp\utility::dronespawn_bodyonly(var_0);
  var_1.animname = "kyle";
  var_1 give_kyle_weapon();
  level.kyle = var_1;
  hidecinematicletterboxing(0, 0);
  level.cutters = scripts\engine\sp\utility::spawn_anim_model("bolt_cutters");
  level.gatelock = scripts\engine\sp\utility::spawn_anim_model("gate_lock");
  var_2 = getEnt("intro_alley_gate", "targetname");
  var_2 scripts\engine\sp\utility::assign_animtree("door");
  var_3 = level.squads["bravo2"];
  var_3 = scripts\engine\utility::array_add(var_3, level.price);
  scripts\engine\utility::array_thread(var_3, scripts\engine\sp\utility::name_hide);
  level.player_rig.customnotetrackhandler = ::camera_handle_notetracks;
  var_4 = [level.player_rig, var_2, level.cutters];
  var_4 = scripts\engine\utility::array_add(var_4, var_1);
  var_5 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  level.player playerlinktoabsolute(level.player_rig, "tag_player");
  scripts\sp\maps\townhoused\townhoused_code.gsc::player_cam_enable(1);
  level.player modifybasefov(32, 0.05);
  level.player lerpfovscalefactor(0, 0);
  var_5 thread scripts\common\anim::anim_first_frame_solo(level.gatelock, "backyard_intro_cut_gate");
  scripts\engine\utility::array_call(var_3, ::invisiblenotsolid);
  scripts\engine\utility::array_call(var_4, ::hide);
  var_5 thread scripts\common\anim::anim_first_frame(var_3, "backyard_intro");
  var_5 thread scripts\common\anim::anim_first_frame(var_4, "backyard_intro");
  wait 0.2;
  scripts\engine\utility::flag_init("intro_sound_delay_done");
  var_6 = scripts\engine\utility::array_combine(var_3, var_4);
  thread skip_intro(var_6);
  level.player playSound("dx_vom_pri_backyard_alleyway_10");
  wait 0.5;
  level.player setclienttriggeraudiozone("th_backyard_intro_approach", 0.5);
  wait 1.5;
  scripts\engine\utility::flag_set("intro_sound_delay_done");

  if(!scripts\engine\utility::flag("skip_intro"))
    level.player_rig thread intro_end();

  var_5 thread scripts\common\anim::anim_single_solo(level.gatelock, "backyard_intro_cut_gate");
  scripts\engine\utility::array_call(var_3, ::visiblesolid);

  foreach(var_8 in var_4) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(var_8 == level.player_rig) {
      continue;
    }
    var_8 show();
  }

  if(!scripts\engine\utility::flag("skip_intro")) {
    scripts\engine\utility::flag_set("intro_anim_started");
    scripts\engine\utility::array_thread(var_3, ::backyard_intro_anim, var_5);
    var_4 = scripts\engine\utility::array_removeundefined(var_4);
    var_5 scripts\common\anim::anim_single(var_4, "backyard_intro");
  }

  scripts\sp\utility::userskip_stop();
  level notify("intro_done");

  if(!istrue(level.demo))
    scripts\engine\utility::array_thread(var_3, scripts\engine\sp\utility::name_show);

  level.player_rig.customnotetrackhandler = undefined;
  level.cutters delete();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

skip_intro(var_0) {
  var_1 = scripts\sp\utility::userskip_wait();

  if(!var_1) {
    return;
  }
  scripts\engine\utility::flag_set("skip_intro");
  scripts\sp\hud_util::fade_out(0);

  if(!scripts\engine\utility::flag("intro_anim_started")) {
    var_2 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");

    foreach(var_4 in var_0) {
      if(isai(var_4)) {
        var_4 thread backyard_intro_anim(var_2);
        continue;
      }

      var_2 thread scripts\common\anim::anim_single_solo(var_4, "backyard_intro");
    }

    waitframe();
  }

  var_6 = "backyard_intro";
  var_7 = 1.1;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!scripts\engine\utility::flag("intro_sound_delay_done")) {
      level.player setclienttriggeraudiozone("th_backyard_intro_approach", 0.5);

      if(isai(var_4))
        var_4 visiblesolid();
    }

    var_9 = getanimlength(var_4 scripts\engine\utility::getanim(var_6));
    var_10 = (var_9 - var_7) / var_9;
    var_4 setanimtime(var_4 scripts\engine\utility::getanim(var_6), var_10);
  }

  if(isDefined(level.gatelock))
    level.gatelock delete();

  scripts\engine\utility::delaythread(0.05, scripts\sp\hud_util::fade_in, 0.05);

  if(isDefined(level.kyle))
    level.kyle delete();

  intro_end(1);
}

backyard_intro_anim(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "backyard_intro");
  thread backyard_alley_move_solo();
}

give_kyle_weapon() {
  var_0 = scripts\sp\maps\townhoused\townhoused_code.gsc::get_player_weapons();

  foreach(var_2 in self.fake_weapon_models)
  self detach(var_2);

  var_4 = getweaponattachmentworldmodels(var_0[0]);

  foreach(var_2 in var_4)
  self attach(var_2);
}

camera_handle_notetracks(var_0, var_1, var_2) {
  var_3 = 32;
  var_4 = level.scr_anim[self.animname]["backyard_intro"];

  if(var_0 == "fovstart") {
    return;
  }
  if(var_0 == "fovlerp_begin") {
    var_5 = self getanimtime(var_4);
    var_6 = getnotetracktimes(var_4, "fovlerp_end");
    var_7 = getanimlength(var_4);
    var_8 = var_7 * (var_6[0] - var_5);
    level.player modifybasefov(65, var_8);
  } else if(var_0 == "swap_player") {
    level.cutters show();
    level.player_rig show();
    level.kyle delete();
    scripts\sp\maps\townhoused\townhoused_code.gsc::player_cam_enable(0);
  } else {}
}

intro_end(var_0) {
  level notify("stop_intro_end");
  level endon("stop_intro_end");
  var_1 = 1;

  if(!istrue(var_0)) {
    var_2 = getanimlength(scripts\engine\utility::getanim("backyard_intro"));
    var_3 = var_2 - var_1;
    level.player scripts\engine\utility::delaycall(var_3 - var_1, ::lerpfovscalefactor, 1, var_1);
    level thread intro_letterbox_removal(var_2);
    wait(var_3);
    scripts\sp\utility::userskip_stop();
  } else {
    level.player modifybasefov(65, 0.05);
    level.player lerpfovscalefactor(1, var_1);
    level thread intro_letterbox_removal(0);
  }

  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  level.player scripts\engine\sp\utility::set_player_demeanor("safe");
  thread restore_player_demeanor();
  level.player clearcinematicmotionoverride();
  setomnvar("ui_hide_hud", 0);
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("backyard");
  wait(var_1);
  level.player unlink();
  level.player_rig hide();
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  scripts\engine\utility::delaythread(2, scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective, "townhouse_entry");
  level.player scripts\engine\utility::delaythread(2, scripts\sp\player::focusenable);
}

intro_letterbox_removal(var_0) {
  var_1 = 2.5;

  if(var_0 > 0) {
    var_2 = var_0 - var_1;
    wait(var_2);
  }

  getrandomnodedestination(var_1);
}

player_intro_speed_lerp() {
  var_0 = 5.0;
  var_1 = 1;
  var_2 = var_1 / var_0;
  var_3 = length(level.player.intro_velocity);
  var_4 = anglesToForward(level.player.angles) * var_3;
  level.player.intro_velocity = undefined;

  for(var_5 = 0; var_5 < var_0; var_5++) {
    waitframe();
    var_1 = var_1 - var_2;
    var_1 = max(var_1, 0);
    level.player pushplayervector(var_4 * var_1);
  }

  level.player pushplayervector(var_4 * 0);
}

player_intro_speed() {
  level.player.intro_velocity = 0;
  var_0 = level.player_rig.origin;

  while(isDefined(level.player.intro_velocity)) {
    var_1 = level.player_rig.origin - var_0;
    level.player.intro_velocity = vectorNormalize(var_1) * (length(var_1) * 20);
    var_0 = level.player_rig.origin;
    waitframe();
  }
}

restore_player_demeanor() {
  thread backyard_player_safe_demeanor_thread();
  scripts\engine\utility::flag_wait("player_in_backyard");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

backyard_player_safe_demeanor_thread() {
  var_0 = 0;

  if(!isplatformps4()) {
    return;
  }
  while(!scripts\engine\utility::flag("player_in_backyard")) {
    var_1 = getdvarint("NSRPORKNPT") / getdvarint("OMQTQNOSRO");

    if(var_0 != var_1 && var_1 > 1.9)
      level.player allowsprint(0);
    else if(var_0 != var_1)
      level.player allowsprint(1);

    var_0 = var_1;
    waitframe();
  }

  level.player allowsprint(1);
}

postspawn_backyard_alley_extra() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::postpawn_friendly_shared();
  scripts\engine\utility::flag_wait("backyard_alley_extra_move");
  var_0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");

  if(self.animname == "bravo2_4")
    self.animloop_headlook = 1;

  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, "backyard_alley_move", undefined, "stop_loop_" + self.animname);
}

backyard_alley_move_solo() {
  if(!isDefined(level.backyard_ally_counter))
    level.backyard_ally_counter = 0;

  level.backyard_ally_counter++;
  var_0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  thread backyard_alley_move_thread();
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, "backyard_alley_move", undefined, "stop_backyard_alley_loop");
}

backyard_alley_move_thread() {
  self waittillmatch("single anim", "end");
  level.backyard_ally_counter--;

  if(level.backyard_ally_counter == 0)
    scripts\engine\utility::flag_set("backyard_alley_ready");
}

backyard_door_setup() {
  var_0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var_1 = getEnt("backyard_door", "targetname");
  var_1 add_linkedents();
}

backyard_door_open() {
  var_0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var_1 = getEnt("backyard_door", "targetname");
  var_1.linkedents[0] connectpaths();
  var_1 thread backyard_door_open_rotate();
  var_2 = scripts\engine\sp\utility::get_living_ai("bravo2_3", "animname");
  var_0 notify("stop_loop_bravo2_3");
  var_2.animloop_headlook = 1;
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(var_2, "backyard_open_gate", undefined, "stop_loop_bravo2_3");
}

backyard_door_open_rotate() {
  var_0 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var_0);
  wait 2.7;
  var_1 = 0.7;
  var_0 rotateYaw(-40, var_1, 0, var_1 * 0.5);
  var_2 = 0.5;
  var_0 scripts\engine\utility::delaycall(var_1 - 0.05, ::rotateyaw, -10, var_2, var_2 * 0.5, var_2 * 0.5);
}

backyard_move() {
  thread backyard_backup_move();
  var_0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var_0 notify("stop_backyard_alley_loop");
  var_1 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  level.backyard_move_counter = var_1.size - 1;
  scripts\engine\utility::array_thread(var_1, ::backyard_move_thread);
  scripts\engine\utility::flag_wait("backyard_basement_ready");
  scripts\engine\utility::flag_wait("player_near_kitchen");
  backdoor_freeze();
}

backyard_move_thread(var_0) {
  self endon("stop_backyard_move_thread");
  var_1 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var_2 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  thread backyard_move_rate_thread();
  var_1 scripts\common\anim::anim_single_solo(self, "backyard_move");
  self notify("stop_backyard_move_rate");
  var_3 = "stop_backyard_move_loop";

  if(self.animname == "bravo2_2") {
    var_0 = 1;
    var_1 thread scripts\sp\maps\townhoused\townhoused_code.gsc::lookat_random_animloop_ender(self, "stop_backyard_move_loop");
  } else if(self.animname == "bravo2_4") {
    var_3 = "stop_backyard_move_loop_bravo2_4";
    var_1 = var_2;
  } else {
    var_2 endon("stop_backyard_move_loop");
    var_1 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  }

  var_1 thread scripts\common\anim::anim_loop_solo(self, "backyard_move_idle", var_3);

  if(isDefined(var_0)) {
    return;
  }
  level.backyard_move_counter--;

  if(level.backyard_move_counter == 0)
    scripts\engine\utility::flag_set("backyard_basement_ready");
}

backyard_move_rate_thread() {
  self endon("stop_backyard_move_rate");
  var_0 = scripts\engine\utility::getanim("backyard_move");
  waitframe();
  scripts\engine\utility::flag_wait("player_near_kitchen");

  if(self getanimtime(var_0) < 0.75) {
    self setanimrate(var_0, 1.5);

    while(self getanimtime(var_0) < 0.95) {
      if(scripts\engine\utility::flag("player_deploying_kitchen_ladder")) {
        break;
      }

      waitframe();
    }

    if(!scripts\engine\utility::flag("player_deploying_kitchen_ladder"))
      self setanimrate(var_0, 1);
  }

  if(scripts\engine\utility::flag("player_deploying_kitchen_ladder"))
    self setanimrate(var_0, 8);
}

backdoor_freeze() {
  var_0 = scripts\engine\sp\utility::get_living_ai("bravo2_1", "animname");
  var_1 = [level.price, var_0];
  level.backyard_freeze_counter = var_1.size;
  scripts\engine\utility::array_thread(var_1, ::backdoor_freeze_thread);
  thread backdoor_entry(var_1);
}

backdoor_freeze_thread() {
  var_0 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  var_0 notify("stop_backyard_move_loop");
  var_0 endon("stop_basement_freeze_loop");
  thread backdoor_freeze_rate_thread();
  var_0 scripts\common\anim::anim_single_solo(self, "backdoor_freeze");
  self notify("stop_backdoor_freeze_rate");

  if(level.price == self)
    scripts\engine\utility::flag_set("basement_freeze_ready");

  if(self == level.price) {
    var_0 thread scripts\common\anim::anim_loop_solo(self, "backdoor_freeze_idle", "stop_basement_freeze_price_loop");
    thread backdoor_freeze_nag(var_0);
  } else
    var_0 thread scripts\common\anim::anim_loop_solo(self, "backdoor_freeze_idle", "stop_basement_freeze_loop");
}

backdoor_freeze_rate_thread() {
  self endon("stop_backdoor_freeze_rate");
  var_0 = scripts\engine\utility::getanim("backdoor_freeze");
  waitframe();
  scripts\engine\utility::flag_wait("player_deploying_kitchen_ladder");
  self setanimrate(var_0, 2);
}

backdoor_freeze_nag(var_0) {
  var_0 endon("stop_basement_freeze_loop");
  var_1 = [];
  var_1[var_1.size] = "dx_vom_pri_kitchen_window_30";
  var_1[var_1.size] = "dx_vom_pri_kitchen_window_40";
  var_1[var_1.size] = "dx_vom_pri_kitchen_window_50";
  scripts\sp\maps\townhoused\townhoused_code.gsc::nag_group_create("backdoor", var_1);
  wait(randomfloatrange(3, 5));

  for(;;) {
    var_0 notify("stop_basement_freeze_price_loop");
    var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::nag_anim(self, "backdoor_freeze_nag", "backdoor", 1, 0.6);
    var_0 thread scripts\common\anim::anim_loop_solo(self, "backdoor_freeze_idle", "stop_basement_freeze_price_loop");

    if(istrue(level.demo)) {
      return;
    }
    var_2 = randomfloatrange(5, 10);
    wait(var_2);
  }
}

backdoor_entry(var_0) {
  scripts\engine\utility::flag_wait("basement_freeze_ready");
  scripts\engine\utility::flag_wait("player_deploying_kitchen_ladder");
  var_1 = scripts\engine\sp\utility::get_living_ai("bravo2_4", "animname");
  var_0 = scripts\engine\utility::array_add(var_0, var_1);
  scripts\engine\utility::array_thread(var_0, ::backdoor_entry_thread);
}

backdoor_entry_thread() {
  scripts\engine\utility::flag_set("backdoor_enter");
  var_0 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  var_0 notify("stop_basement_freeze_loop");
  var_0 notify("stop_basement_freeze_price_loop");
  var_0 notify("stop_loop");
  var_0 notify("stop_backyard_move_loop");
  var_0 notify("stop_backyard_move_loop_bravo2_4");

  if(self == level.price)
    level thread basement_door_enter();

  if(self.animname != "bravo2_4")
    thread backdoor_enter_hurry(var_0);

  var_0 scripts\common\anim::anim_single_solo(self, "backdoor_enter");

  if(self.animname == "bravo2_4") {
    self notify("stop_backyard_move_thread");
    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 thread scripts\common\anim::anim_loop_solo(self, "backdoor_enter_idle", "stop_basement_lastguy_loop");
    thread backdoor_lastguy_nag();
  } else {
    self.goalradius = 48;
    var_1 = undefined;

    if(self.animname == "bravo2_1")
      var_1 = scripts\engine\utility::getStruct("basement_entry_bravo2_1", "targetname");
    else if(self == level.price)
      var_1 = scripts\engine\utility::getStruct("basement_entry_price", "targetname");

    if(isDefined(var_1))
      var_2 = var_1.origin;
    else
      var_2 = self.origin;

    self setgoalpos(var_2);
    self waittill("goal");
    backdoor_enter_done();
  }
}

backdoor_enter_done() {
  if(!isDefined(level.backdoor_enter_count))
    level.backdoor_enter_count = 0;

  level.backdoor_enter_count++;

  if(level.backdoor_enter_count == 2)
    scripts\engine\utility::flag_set("backdoor_enter_done");
}

backdoor_enter_hurry(var_0) {
  var_0 endon("backdoor_enter");
  var_1 = scripts\engine\utility::getanim("backdoor_enter");
  var_2 = getEnt("backdoor", "targetname");
  var_3 = var_2 scripts\engine\utility::getanim("backdoor_enter");
  var_4 = 0;

  for(;;) {
    if(!var_4 && level.player isonladder()) {
      var_4 = 1;
      self setanimrate(var_1, 2);
      var_2 setanimrate(var_3, 2);
    } else if(var_4) {
      var_4 = 0;
      self setanimrate(var_1, 1);
      var_2 setanimrate(var_3, 1);
    }

    waitframe();
  }
}

backdoor_lastguy_nag() {
  level endon("player_top_of_ladder");

  if(scripts\engine\utility::flag("player_top_of_ladder")) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "dx_vom_a12_kitchen_window_70";
  var_0[var_0.size] = "dx_vom_a12_kitchen_window_80";
  var_0[var_0.size] = "dx_vom_a12_kitchen_window_90";
  scripts\sp\maps\townhoused\townhoused_code.gsc::nag_group_create("backdoor_lastguy", var_0);
  wait(randomfloatrange(3, 5));
  var_1 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");

  for(;;) {
    var_1 notify("stop_basement_lastguy_loop");
    var_1 scripts\sp\maps\townhoused\townhoused_code.gsc::nag_anim(self, "backdoor_nag", "backdoor_lastguy", 1);
    var_1 thread scripts\common\anim::anim_loop_solo(self, "backdoor_enter_idle", "stop_basement_lastguy_loop");
    var_2 = randomfloatrange(5, 10);
    wait(var_2);
  }
}

basement_door_enter() {
  var_0 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  var_1 = getEnt("backdoor", "targetname");
  var_1.linkedents[0] = getEnt(var_1.target, "targetname");
  var_1.linkedents[0] linkTo(var_1);
  var_1 scripts\engine\sp\utility::assign_animtree("door");
  var_0 scripts\common\anim::anim_single_solo(var_1, "backdoor_enter");
}

backyard_backup_move() {
  scripts\engine\utility::flag_wait("player_in_mid_backyard");
  var_0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var_0 notify("stop_loop_bravo2_3");
  var_0 notify("stop_loop_bravo2_4");
  var_1 = scripts\engine\sp\utility::get_living_ai("bravo2_4", "animname");
  var_1 thread backyard_move_thread(1);
  var_2 = scripts\engine\sp\utility::get_living_ai("bravo2_3", "animname");
  scripts\engine\utility::flag_set("backyard_playerclip");
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(var_2, "backyard_move");
}

backyard_freeze_townhouse(var_0) {
  self endon("death");
  self.goalradius = 32;
  self waittill("goal");
  self.goalradius = 4;
  scripts\engine\utility::set_movement_speed(10);
  scripts\common\ai::set_gunpose("ads");
  var_1 = create_backyard_aimpath();
  scripts\sp\maps\townhoused\townhoused_code.gsc::enable_laser(1);
  var_2 = var_1[0][0];
  var_3 = create_aiment(var_2.origin);
  var_0.rightdir = anglestoright(var_0.angles);
  var_4 = 0;

  for(;;) {
    wait(randomfloatrange(2, 4));
    var_5 = var_1[var_4];
    var_5 = scripts\engine\utility::array_randomize(var_5);
    var_6 = 1;

    if(isDefined(self.script_count_min))
      var_6 = randomintrange(self.script_count_min, self.script_count_max);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      foreach(var_9 in var_5) {
        var_10 = 5;

        if(isDefined(self.radius))
          var_10 = self.radius;

        var_11 = var_9.origin + anglestoright(var_9.angles) * randomfloatrange(var_10 * -1, var_10);
        var_12 = randomfloatrange(0.5, 1);
        var_3 moveTo(var_11, var_12, var_12 * 0.5, var_12 * 0.5);
        var_3 waittill("movedone");

        if(randomint(100) > 30)
          backyard_free_move(var_0);

        wait(randomfloatrange(1, 2));
      }
    }

    if(randomint(100) > 30)
      backyard_free_move(var_0);

    var_4++;

    if(var_4 > var_1.size - 2)
      var_4 = 0;

    waitframe();
  }
}

backyard_fail_thread() {
  var_0 = getEnt("townhouse_damage_trigger", "targetname");
  var_0 thread backyard_fail_damage_thread();

  while(!scripts\engine\utility::flag("player_in_kitchen")) {
    if(scripts\engine\utility::flag("player_is_outside")) {
      var_1 = getEntArray("grenade", "classname");

      if(var_1.size > 0) {
        foreach(var_3 in var_1) {
          if(!isDefined(var_3.fail)) {
            var_3.fail = 1;
            var_3 thread backyard_fail_onexplode();
          }
        }
      }
    }

    waitframe();
  }

  var_0 delete();
}

backyard_fail_onexplode() {
  self waittill("explode");
  backyard_force_fail();
}

backyard_fail_damage_thread() {
  self endon("death");
  self waittill("trigger");
  backyard_force_fail();
}

backyard_force_fail() {
  var_0 = ["dx_vom_pri_backyard_misfire_10", "dx_vom_pri_backyard_misfire_20", "dx_vom_pri_backyard_misfire_30"];
  level.price thread scripts\engine\sp\utility::smart_dialogue(scripts\engine\utility::random(var_0));
  scripts\sp\player_death::set_custom_death_quote(13);
  scripts\sp\utility::missionfailedwrapper();
}

backyard_free_move(var_0) {
  var_1 = 0;
  var_2 = 10;

  for(;;) {
    var_3 = randomfloatrange(-30, 30);
    var_4 = var_0.origin + var_0.rightdir * var_3;
    var_5 = distancesquared(var_4, self.origin);

    if(var_5 > 10) {
      break;
    }

    var_1++;

    if(var_1 == 10) {
      var_1 = 0;
      waitframe();
    }
  }

  self setgoalpos(var_4);
}

create_backyard_aimpath() {
  var_0 = scripts\engine\utility::getStruct("townhouse_window_aimpath", "targetname");
  var_1[0] = [var_0];

  while(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");

    if(isDefined(var_0.script_linkto)) {
      var_2 = [var_0];
      var_3 = var_0 scripts\engine\utility::get_linked_structs();
      var_1[var_1.size] = scripts\engine\utility::array_combine(var_2, var_3);
      continue;
    }

    var_1[var_1.size] = [var_0];
  }

  return var_1;
}

ambient_garage_welding() {
  var_0 = getEnt("garage_welding_light", "targetname");
  var_0.og_intensity = var_0 getlightintensity();
  var_0 setlightintensity(0);
  var_1 = [];
  var_1[0] = add_welding_alias("emt_amb_weld_short", 0, -2.0);
  var_1[1] = add_welding_alias("emt_amb_weld_short_02", 0, -2.0);
  var_1[2] = add_welding_alias("emt_amb_weld_short_03", 0, -2.0);
  var_1[3] = add_welding_alias("emt_amb_weld_short_04", 0, -2.0);
  var_1[4] = add_welding_alias("emt_amb_weld_short_05", 0, -2.0);
  var_1[5] = add_welding_alias("emt_amb_weld_short_06", 0, -2.0);
  var_1[6] = add_welding_alias("emt_amb_weld_short_07", 0, -2.0);
  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_2 = getEnt("inside_townhouse", "targetname");
  wait 1;
  var_3 = 3;
  var_4 = 5;
  var_5 = 1;
  var_6 = 5;
  var_7 = 0.5;
  var_8 = 1;
  var_9 = -1;

  for(;;) {
    if(level.player istouching(var_2)) {
      wait 3;
      continue;
    }

    var_10 = randomintrange(var_5, var_6);

    for(var_11 = 0; var_11 < var_10; var_11++) {
      var_9++;

      if(var_9 == var_1.size) {
        var_1 = scripts\engine\utility::array_randomize(var_1);
        var_9 = 0;
      }

      var_12 = var_1[var_9];
      var_0 thread ambient_garage_welding_light(var_12);
      var_0 playSound(var_12.alias, "sounddone");
      var_0 waittill("sounddone");
      wait(randomfloatrange(var_7, var_8));
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

add_welding_alias(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.alias = var_0;
  var_3.flickerdelay = var_1;
  var_3.flickerendtime = var_2;
  return var_3;
}

ambient_garage_welding_light(var_0) {
  wait(var_0.flickerdelay);
  var_1 = randomfloatrange(0.8, 1.1);
  var_2 = gettime() + lookupsoundlength(var_0.alias) + var_0.flickerendtime * 1000;

  while(gettime() < var_2) {
    self setlightintensity(var_1 + randomfloatrange(-0.8, 0.5));
    wait(randomfloat(0.2));
  }

  self setlightintensity(0);
}

kitchen_sequence() {
  level thread kitchen_dialogue();
  scripts\engine\utility::flag_wait("player_deploying_kitchen_ladder");
  setglobalsoundcontext("climb", "ladder", 0.1);
  thread dining_dialogue_from_kitchen();
  thread lerp_playerspeed_fov_on_ladder();
  thread player_on_ladder_flag();
  var_0 = getEnt("top_backyard_ladder", "targetname");

  for(;;) {
    var_0 waittill("trigger");

    if(level.player isonladder() || istrue(level.player_on_ladder_hack)) {
      break;
    }
  }

  scripts\engine\utility::flag_set("player_top_of_ladder");
  thread kitchen_mantle_thread();
  thread kitchen_player_top_of_ladder_failsafe();
  scripts\engine\utility::flag_wait_either("backdoor_enter_done", "top_of_ladder_failsafe");
  thread kitchen_takedown();
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  interior_price_settings();
  level.price waittillmatch("single anim", "end");
  level.price setgoalpos(level.price.origin);
  thread scripts\engine\utility::flag_set_delayed("player_exiting_kitchen", 15);
  scripts\engine\utility::flag_wait("player_exiting_kitchen");
  var_1 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var_1 notify("stop_loop_price");
  level.price thread stairtrain1_setup();
}

kitchen_player_clip() {
  scripts\engine\utility::flag_wait("kitchen_takedown_fastforward");
  wait 2;
  var_0 = getEnt("kitchen_player_clip", "targetname");
  var_0 delete();
}

kitchen_player_top_of_ladder_failsafe() {
  level endon("backdoor_enter_done");
  var_0 = getEnt("top_backyard_ladder_failsafe", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("top_of_ladder_failsafe");
}

kitchen_player_deployed_ladder() {
  var_0 = get_ladder_struct("kitchen_ladder", "script_noteworthy");
  var_0.hint waittill("trigger");
  scripts\engine\utility::flag_set("player_deploying_kitchen_ladder");
}

kitchen_dialogue() {
  scripts\engine\utility::flag_wait("player_near_kitchen");
  level.player waittill("deploying_ladder");
}

player_on_ladder_flag() {
  while(!level.player isonladder())
    waitframe();

  scripts\engine\utility::flag_set("player_on_ladder");
  level.player playSound("thd_vm_tactical_ladder_mount_plr");
}

interior_price_settings() {
  level.price.ignoreme = 1;
  level.price.ignoreall = 1;
  level.price.script_forcegoal = 1;
  level.price.goalradius = 32;
  level.price.uprightcqbidle = 1;
}

kitchen_takedown() {
  var_0 = scripts\engine\utility::getStruct("price_bravo3_kitchen", "targetname");
  var_1 = scripts\sp\maps\townhoused\townhoused_code.gsc::get_closest_squad_guy("bravo2", var_0.origin);
  var_1 forceteleport(var_0.origin, var_0.angles);
  var_2 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var_1.animname = "bravo3";
  var_2 thread scripts\sp\anim::anim_reach_solo(var_1, "kitchen_takedown");
  var_3 = 0;
  var_4 = var_1.origin;
  var_5 = scripts\engine\sp\utility::spawn_targetname("hallway_girl", 1);
  var_5.team = "neutral";
  var_5 scripts\common\ai::gun_remove();
  var_5.allowdeath = 1;
  var_5.skipdeathanim = 1;
  var_5.deathfunction = ::kitchen_girl_death;
  var_5.ally = var_1;
  var_5.nofacialfiller = 1;
  var_5 scripts\engine\sp\utility::set_deathanim("kitchen_takedown_death_stand");
  var_1.kitchen_react = "kitchen_takedown_death_stand";
  level thread kitchen_girl_death_dialogue(var_5);
  thread kitchen_takedown_girl(var_5);
  level thread scripts\sp\maps\townhoused\townhoused_anim.gsc::stow_halligan(level.price);
  level.price scripts\anim\shared.gsc::placeweaponon(level.price.weapon, "right");
  thread kitchen_takedown_door();
  var_1 thread kitchen_bravo_death_react(var_2, var_5);
  var_1.animloop_headlook = 1;
  var_1 thread kitchen_bravo_combat_thread(var_2);
  var_2 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(var_1, "kitchen_takedown", undefined, "stop_kitchen_takedown_bravo");
  level.price thread dining_room_animrate_adjust(var_2, "kitchen_takedown");
  var_2 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(level.price, "kitchen_takedown", undefined, "stop_loop_price");
  var_1 setgoalpos(var_1.origin);
  scripts\engine\utility::flag_set("kitchen_done");
  setglobalsoundcontext("climb", "", 0.5);
}

kitchen_bravo_combat_thread(var_0) {
  waitframe();
  self waittill("killanimscript");

  for(;;) {
    self waittill("bulletwhizby", var_1);

    if(isDefined(var_1) && var_1 == level.player)
      continue;
    else
      break;
  }

  self.combatmode = "ambush";
  var_0 notify("stop_kitchen_takedown_bravo");
  var_2 = getnode("kitchen_covernode", "targetname");
  self setgoalnode(var_2);
  self.goalradius = 32;
  self.usingnode = 1;
  scripts\engine\utility::set_movement_speed(60);
  scripts\engine\sp\utility::anim_stopanimScripted();
}

kitchen_takedown_girl(var_0) {
  var_0 endon("death");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("cuffs");
  var_0.cuffs = var_1;
  var_2 = [var_1, var_0];
  var_3 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var_3 scripts\common\anim::anim_single(var_2, "kitchen_takedown");
  var_2 = scripts\engine\utility::array_removeundefined(var_2);
  var_3 thread scripts\common\anim::anim_loop(var_2, "kitchen_takedown_loop", "stop_kitchen_takedown_girl");
}

kitchen_takedown_door() {
  var_0 = scripts\sp\door::get_interactive_door("kitchen_girl_door");
  var_0.open_struct scripts\sp\door::remove_open_interact_hint();
  var_1 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var_1 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_door(var_0, "kitchen_takedown");
  var_0.open_completely = 1;
  scripts\engine\utility::flag_set("kitchen_girl_secured");
}

kitchen_bravo_death_react(var_0, var_1) {
  if(!isalive(var_1)) {
    return;
  }
  var_1 waittill("death");
  var_0 notify("stop_kitchen_takedown_girl");

  if(isDefined(self.no_react)) {
    return;
  }
  if(self.kitchen_react == "kitchen_takedown_death_stand") {
    var_0 notify("stop_kitchen_takedown_bravo");
    var_0 = self;

    if(isDefined(var_1.cuffs))
      var_1.cuffs delete();
  } else if(self.kitchen_react == "kitchen_takedown_death_hold") {
    if(isDefined(var_1.cuffs))
      var_1.cuffs delete();
  }

  if(istrue(self.usingnode)) {
    return;
  }
  if(self.kitchen_react == "kitchen_takedown_death_laying")
    var_0 scripts\common\anim::anim_single_solo(self, self.kitchen_react);
  else
    var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, self.kitchen_react);
}

kitchen_girl_death() {
  var_0 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");

  if(isDefined(self.deathanim))
    return 0;

  if(self.kitchen_death_anime == "kitchen_takedown_death_stand")
    var_0 = self;

  if(self.kitchen_death_anime == "kitchen_takedown_death_laying") {
    if(isDefined(self.cuffs))
      self.cuffs delete();
  }

  scripts\sp\maps\townhoused\townhoused_code.gsc::scripted_deathanim(self.kitchen_death_anime, var_0);
}

kitchen_girl_death_dialogue(var_0) {
  var_0 waittill("death", var_1);
  scripts\engine\utility::flag_set("kitchen_girl_secured");

  if(!isPlayer(var_1)) {
    return;
  }
  var_2 = scripts\engine\sp\utility::get_living_ai("bravo3", "animname");
  wait 0.2;
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_a11_kitchen_entry_40");
  wait 0.3;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_kitchen_entry_50");
}

get_ladder_struct(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0, var_1);

  foreach(var_4 in var_2) {
    if(var_4.targetname == "deployable_ladder")
      return var_4;
  }
}

lerp_playerspeed_fov_on_ladder() {
  var_0 = scripts\engine\utility::getStruct("ladder_lerp", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = 0;
  var_3 = 0.846154;
  var_4 = 0.666;
  var_5 = 1;
  var_6 = distance(var_0.origin, var_1.origin);
  var_7 = 0;

  for(;;) {
    var_8 = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
    var_9 = distance(var_8, var_0.origin);
    var_10 = var_9 / var_6;

    if(var_10 > var_7) {
      var_7 = var_10;
      var_11 = scripts\engine\math::factor_value(65, 55, var_10);
      level.player modifybasefov(var_11, 0.2);
    }

    if(level.player isonladder()) {
      if(!var_2) {
        thread scripts\engine\sp\utility::lerp_saveddvar("LOMLPPTKO", 20, 3);
        scripts\sp\maps\townhoused\townhoused_lighting.gsc::player_onkitchenladder();
        level.player scripts\engine\sp\utility::player_speed_set(40, 0.5);
        var_2 = 1;
      }

      level.player scripts\engine\sp\utility::blend_movespeedscale(1);
    } else {
      if(var_2) {
        setsaveddvar("LOMLPPTKO", 85);
        scripts\sp\maps\townhoused\townhoused_lighting.gsc::player_offkitchenladder();
        scripts\sp\player::player_movement_state("creep");
        var_2 = 0;
      }

      var_12 = scripts\engine\math::factor_value(var_5, var_4, var_10);
      level.player scripts\engine\sp\utility::blend_movespeedscale(var_12);
    }

    if(var_10 == 1) {
      break;
    }

    waitframe();
  }

  level.player modifybasefov(55, 0.2);
  scripts\sp\player::player_movement_state("creep");
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.666);
  setsaveddvar("LOMLPPTKO", 85);
}

kitchen_mantle_thread() {
  var_0 = getEnt("kitchen_mantle", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = "window_mantle";
  var_4 = getmovedelta(level.player_rig scripts\engine\utility::getanim(var_3), 0, 1);
  var_5 = cos(45);
  var_6 = anglesToForward(var_1.angles);
  var_7 = 1;

  for(;;) {
    var_0 waittill("trigger");

    while(level.player istouching(var_0)) {
      var_8 = anglesToForward(level.player.angles);
      var_9 = vectordot(var_6, var_8);
      var_10 = 1;

      if(var_9 < var_5)
        var_10 = 0;

      if(!istrue(level.player_on_ladder_hack) && var_10 && !is_player_moving_forward())
        var_10 = 0;

      if(var_10) {
        var_11 = spawnStruct();
        var_11.origin = pointonsegmentnearesttopoint(var_1.origin, var_2.origin, level.player.origin);
        var_11.angles = (0, level.player.angles[1], 0);
        var_11 scripts\common\anim::anim_first_frame_solo(level.player_rig, var_3);
        var_12 = level.player_rig gettagorigin("tag_player");
        var_13 = level.player_rig gettagangles("tag_player");
        level.player.groundrefent = scripts\engine\utility::spawn_tag_origin(var_12, var_13);
        level.player.groundrefent linkTo(level.player_rig, "tag_camera", (0, 0, 0), (0, 0, 0));
        level.player setstance("stand");
        level.player_rig hide();
        var_11.origin = var_11.origin - (0, 0, 60);
        var_11 thread scripts\common\anim::anim_single_solo(level.player_rig, var_3);
        level.player disableweapons();
        level.player lerpviewangleclamp(0, 0, 0, 180, 180, 180, 180, 1);
        level.player playerlinktoblend(level.player_rig, "tag_player", 0.4, 0.2, 0.2);
        wait 0.4;
        level.player_rig show();
        level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
        level.player lerpviewangleclamp(0.2, 0, 1, 20, 20, 20, 20);
        level.player springcamenabled(0, 5, 5);
        var_11 waittill(var_3);
        level.player_rig hide();
        level.player enableweapons();
        level.player springcamdisabled(0);
        level.player unlink();
        level.player playersetgroundreferenceent(undefined);
        level.player.groundrefent delete();
        var_11 = undefined;
      }

      wait 0.05;
    }
  }
}

is_player_moving_forward() {
  var_0 = level.player getnormalizedmovement();
  return var_0[0] > 0;
}

dining_dialogue_from_kitchen() {
  scripts\engine\utility::flag_wait("player_near_kitchen");
  var_0 = scripts\engine\utility::getStruct("dining_fakesound1", "targetname");
  var_1 = scripts\engine\utility::spawn_script_origin(var_0.origin);
  var_0 = scripts\engine\utility::getStruct("dining_fakesound2", "targetname");
  var_2 = scripts\engine\utility::spawn_script_origin(var_0.origin);
  level.player setsoundsubmix("sp_th_python_scream");
  scripts\engine\utility::flag_wait("player_top_of_ladder");
  var_2 playsound_wait("dx_vom_aq1_kitchen_aq_convo1_10");
  wait 0.8;
  var_1 playsound_wait("dx_vom_aqf1_kitchen_aq_convo1_20");
  var_2 playsound_wait("dx_vom_aq1_kitchen_aq_convo1_30");
  wait 3.2;
  scripts\engine\utility::flag_set("kitchen_intro_vo_done");
  var_1 delete();
  var_2 delete();
}

playsound_wait(var_0) {
  self playSound(var_0, "sounddone");
  self waittill("sounddone");
}

postspawn_dining_enemy() {
  if(!isDefined(level.dining_enemies))
    level.dining_enemies = [];

  thread dining_death_vo();
  thread dining_long_death_vo();
  level.dining_enemies = scripts\engine\utility::array_add(level.dining_enemies, self);
  scripts\sp\anim::anim_react_add_to_alertgroup("dining");
  self.headlook_enabled = 0;
  var_0 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  scripts\engine\sp\utility::disable_surprise();

  if(self.animname == "dining_enemy3") {
    var_1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["rec_akilo47", "mag_akilo47|1", "ironsdefault_akilo47"]);
    scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
    scripts\engine\utility::delaythread(0.1, scripts\sp\anim::primaryweapon_leave_behind, "tag_weapon_right", 1);
  } else {
    if(self.animname == "dining_enemy1")
      var_1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["rec_akilo47", "front_akilo47", "mag_akilo47|1", "ironsdefault_akilo47", "stockno_akilo47"]);
    else
      var_1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["rec_akilo47", "back_akilo47", "front_akilo47", "mag_akilo47", "ironsdefault_akilo47"]);

    scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
    scripts\engine\utility::delaythread(0.1, scripts\sp\anim::primaryweapon_leave_behind, "tag_weapon_right");
  }

  if(self.animname == "dining_enemy1") {
    dining_room_chair_init();
    self.disabledeathdirectionalorient = 1;
    self.anim_react_skip_stopanimscripted = 1;
    var_0 thread dining_react_flagwait(self, "dining", ::dining_enemy_react);
  } else if(self.animname == "dining_enemy2") {
    var_0 thread dining_react_flagwait(self, "dining", ::dining_enemy_react);
    self.disabledeathdirectionalorient = 1;
  } else {
    self attach(scripts\engine\sp\utility::getmodel("cellphone_on"), "tag_accessory_left");
    var_0 thread dining_react_flagwait(self, "dining", ::dining_enemy_react);
  }

  thread dining_death_counter(1);

  if(level.dining_enemies.size == 3) {
    level thread dining_dialogue();
    level thread dining_price_dialogue();
    level thread dining_room_foyer_trigger();
    var_2 = getEnt("dining_room_damage_trigger", "targetname");
    var_2 thread dining_trigger_damage_thread();
    var_2 = getEnt("outer_dining_room_damage_trigger", "targetname");
    var_2 thread dining_trigger_damage_thread(1);
  }
}

dining_room_chair_init() {
  var_0 = getEnt("dining_room_chair", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("chair");
  var_0 thread dining_room_chair_anim_end();
  var_0.clip = getEnt("dining_room_chair_clip", "targetname");
  var_0.clip linkTo(var_0);
  var_1 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var_1 thread scripts\common\anim::anim_first_frame_solo(var_0, "dining_react_high");
  self.animents = [var_0];
}

dining_room_chair_anim_end() {
  self waittillmatch("single anim", "end");

  if(self._lastanime == "dining_react_pain") {
    self.clip delete();
    return;
  }

  self.clip disconnectPaths();
}

dining_room_foyer_trigger() {
  scripts\engine\sp\utility::trigger_wait_targetname("dining_room_foyer");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("dining_enemies", "script_noteworthy");
  scripts\engine\sp\utility::array_notify(var_0, "react");
}

dining_room_door_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\engine\utility::flag_set("player_exiting_kitchen");
  self.fndamage = undefined;
  waitframe();
  var_10 = scripts\engine\sp\utility::get_living_ai_array("dining_enemies", "script_noteworthy");
  scripts\engine\sp\utility::array_notify(var_10, "react");
}

dining_dialogue() {
  if(scripts\engine\utility::flag("dining_room_react")) {
    return;
  }
  level endon("dining_room_react");
  scripts\engine\utility::flag_wait_all("player_in_kitchen", "kitchen_intro_vo_done");
  wait 0.85;
  var_0 = scripts\engine\sp\utility::get_living_ai("dining_enemy1", "animname");
  var_1 = scripts\engine\sp\utility::get_living_ai("dining_enemy2", "animname");
  var_2 = scripts\engine\sp\utility::get_living_ai("dining_enemy3", "animname");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq3_dining_room_aq_convo2_10");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_20");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq3_dining_room_aq_convo2_30");
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo2_40");
  var_1 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_50");
  var_3 = lookupsoundlength("dx_vom_aq1_dining_room_aq_convo2_50") / 1000;
  wait(max(var_3 - 0.8, 0));
  var_0 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq3_dining_room_aq_convo2_60");
  var_3 = lookupsoundlength("dx_vom_aq3_dining_room_aq_convo2_60") / 1000;
  wait(max(var_3 - 1, 0));
  thread scripts\engine\utility::flag_set_delayed("dining_room_drop_em_ready", 1);
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo2_70");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq3_dining_room_aq_convo2_80");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_100");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_110");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_120");
  wait 0.5;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_130");
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo2_140");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_150");
  wait 6;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_160");
  wait 4;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_170");
  wait 8;
  level thread dining_enemy2_investigate();
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_180");
  wait 1;
  scripts\engine\utility::flag_set("dining_room_dialogue_finished");
}

dining_enemy2_investigate() {
  var_0 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var_1 = scripts\engine\sp\utility::get_living_ai("dining_enemy2", "animname");
  var_1 notify("stop_anim_react");
  var_1 endon("death");

  if(var_1 scripts\engine\utility::ent_flag_exist("anim_reacted"))
    var_1 scripts\engine\utility::ent_flag_set("anim_reacted");

  var_1.a.movement = "stop";
  var_0 notify("stop_anim_loop_" + var_1.animname);
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\engine\sp\utility::place_weapon_on(var_1.sidearm, "right");
  var_1.dontattackme = 0;
  var_1.fnstealthgotonode = undefined;
  var_1.goalradius = 60;
  var_2 = scripts\engine\utility::getStruct("dining_enemy_search", "targetname");
  var_1 setgoalpos(var_2.origin);
  var_1 thread dining_enemy2_investigate_react();
  var_1 waittill("goal");
  var_1.dontattackme = 0;
  var_3 = scripts\engine\sp\utility::get_living_ai("bravo3", "animname");

  if(!var_1 cansee(level.player)) {
    if(isDefined(var_3)) {
      var_1 aieventlistenerevent("combat", var_3, var_3.origin);
      var_1 getenemyinfo(var_3);
    }
  }

  if(isDefined(var_3))
    var_3 notify("bulletwhizby");

  var_1.goalradius = 500;
  dining_delete_clip();
}

dining_enemy2_investigate_react() {
  self endon("death");
  self waittill("enemy");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aqreact_50");
}

dining_price_dialogue() {
  if(scripts\engine\utility::flag("dining_room_react")) {
    return;
  }
  var_0 = getEnt("dining_room_hallwayview", "targetname");
  scripts\engine\utility::flag_wait("dining_room_player_should_engage");

  if(scripts\engine\utility::flag("dining_room_react")) {
    return;
  }
  level endon("dining_room_react");
  var_1 = scripts\engine\utility::getStruct("dining_room_lookat_pos", "targetname");
  var_2 = [];
  var_2[var_2.size] = "dx_vom_pri_dining_room_entry_20";
  var_2[var_2.size] = "dx_vom_pri_dining_room_entry_40";
  var_2[var_2.size] = "dx_vom_pri_dining_room_entry_30";
  var_3 = scripts\engine\sp\utility::create_deck(var_2);
  var_2 = [];
  var_2[var_2.size] = "dx_vom_pri_dining_room_entry_50";
  var_2[var_2.size] = "dx_vom_pri_dining_room_entry_60";
  var_2[var_2.size] = "dx_vom_pri_dining_room_entry_70";
  var_4 = scripts\engine\sp\utility::create_deck(var_2);

  if(istrue(level.demo))
    scripts\engine\utility::flag_wait("dining_room_drop_em_ready");

  var_5 = 7;
  var_6 = 10;
  var_7 = 1.3;
  var_8 = undefined;
  var_9 = 0;
  var_10 = 0;

  for(;;) {
    var_11 = randomfloatrange(var_5, var_6);
    var_12 = gettime();
    var_13 = level.player scripts\engine\trace::can_see_origin(var_1.origin, 0);

    for(;;) {
      var_14 = gettime() + var_11 * 1000;

      while(gettime() < var_14) {
        var_13 = level.player scripts\engine\trace::can_see_origin(var_1.origin, 0);

        if(!var_10 && level.player scripts\engine\sp\utility::isads() && var_13) {
          var_10 = 1;
          wait 0.2;
          break;
        } else if(!level.player scripts\engine\sp\utility::isads() || !var_13)
          var_10 = 0;

        waitframe();
      }

      if(!isDefined(var_8) || scripts\engine\utility::time_has_passed(var_8, 3)) {
        break;
      }

      var_11 = var_11 - (gettime() - var_12) / 1000;

      if(var_11 < 0.05)
        var_11 = 0.05;
    }

    if(var_13) {
      if(!var_9) {
        scripts\sp\maps\townhoused\townhoused_code.gsc::nag_say(var_3 scripts\engine\sp\utility::deck_draw_specific("dx_vom_pri_dining_room_entry_20", 1), 1);
        var_9 = 1;

        if(istrue(level.demo))
          return;
      } else {
        if(!scripts\engine\utility::flag("dining_room_dialogue_finished")) {
          continue;
        }
        scripts\sp\maps\townhoused\townhoused_code.gsc::nag_say(var_3 scripts\engine\sp\utility::deck_draw(), 1);
      }
    } else {
      if(!scripts\engine\utility::flag("dining_room_dialogue_finished")) {
        continue;
      }
      scripts\sp\maps\townhoused\townhoused_code.gsc::nag_say(var_4 scripts\engine\sp\utility::deck_draw(), 1);
    }

    var_8 = gettime();
    var_5 = min(var_5 * var_7, 14);
    var_6 = min(var_6 * var_7, 18);
  }
}

dining_react_flagwait(var_0, var_1, var_2) {
  var_0 endon("death");
  scripts\common\anim::anim_first_frame_solo(var_0, var_1 + "_intro");

  if(level.start_point == "dining_room")
    level.scr_anim[var_0.animname][var_1 + "_intro"] = undefined;

  scripts\engine\utility::flag_wait("player_exiting_kitchen");
  thread scripts\sp\anim::anim_react(var_0, var_1, var_2);
}

dining_room_is_light_dead() {
  var_0 = isDefined(self.anim_react_event) && self.anim_react_event.typeorig == "light_killed";

  if(!var_0) {
    var_1 = getscriptablearray("dining_light", "targetname");
    var_2 = var_1[0] getscriptablepartstate("onoff");
    var_0 = var_2 == "death";
  }

  return var_0;
}

dining_light_death() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("dining_light", "targetname");
  var_1 = var_0[0];

  if(getdvarint("developer") > 0)
    scripts\engine\sp\utility::scripter_note("turning off other lights");

  var_1 waittill("death");
  level.player.lastenemybulletdamagetime = gettime();
  var_2 = getEntArray("102_dinning", "script_noteworthy");

  foreach(var_4 in var_2)
  var_4 setlightintensity(0);
}

dining_delete_clip() {
  var_0 = getEnt("dining_room_conceal_clip", "targetname");

  if(isDefined(var_0))
    var_0 delete();
}

dining_enemy_react(var_0) {
  if(self.health == 1)
    var_0 = "pain";

  if(var_0 == "death")
    return "death";

  self endon("death");
  self endon("stop_dining_enemy_react");
  self.nofacialfiller = 1;
  var_1 = dining_room_is_light_dead();

  if(var_1)
    thread dining_nolight_delay();
  else
    thread disable_player_sealth();

  if(self.animname == "dining_enemy1") {
    if(istrue(level.demo) && var_1) {
      self notify("stop_dining_enemy_react_special");
      self endon("stop_dining_enemy_react_special");

      if(var_0 != "pain" || var_0 != "death") {
        slow_react_enemy(var_0);
        var_0 = self.slow_react_type;
        slow_react_stop_animScripted();
      }
    } else {
      var_2 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
      var_2 notify("stop_anim_loop_" + self.animname);
    }
  }

  self notify("stop_anim_react_death");
  scripts\engine\utility::flag_set("dining_room_react");
  self stopsounds();
  dining_delete_clip();
  var_2 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var_3 = "dining_react_high";

  if(var_0 == "too_close" || is_footstep_react())
    var_3 = "dining_react";

  if(var_0 == "friend_reacted") {
    if(isDefined(self.anim_react_event)) {
      if(self.anim_react_event.typeorig == "bulletwhizby")
        var_3 = "dining_react_high";
    }
  } else if(var_0 == "friend_pained" || var_0 == "friend_died") {
    var_3 = "dining_react_high";
    var_4 = "dx_vom_aq3_dining_room_frontroom_10";
  }

  if(var_0 == "pain") {
    if(self.health == 1) {
      thread dining_react_death(var_2);
      return "skip_reaction";
    }

    self notify("stop_dining_enemy_damage");
    return var_0;
  } else
    thread dining_react_death(var_2, 1);

  thread dining_drop_phone();
  var_5 = var_3;

  if(var_1) {
    var_5 = "dining_react_nolight";
    self notify("stop_dining_enemy_damage");
  }

  self.animreactpain = 1;
  thread dinnig_enemy_react_then_pain();
  thread dining_react_dialogue(var_5);
  var_2 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var_2 scripts\sp\anim::anim_single_with_props([self], var_3);
  self notify("stop_dining_enemy_damage");

  if(var_3 == "dining_react_high" && !var_1) {
    if(self.animname == "dining_enemy3")
      thread dining_engage_enemy(64);
    else
      thread dining_engage_enemy();
  }

  return "skip_reaction";
}

dining_drop_phone() {
  self endon("entitydeleted");

  if(self.animname != "dining_enemy3") {
    return;
  }
  wait 0.3;
  var_0 = self gettagorigin("tag_accessory_left");
  var_1 = self gettagangles("tag_accessory_left");
  waitframe();
  var_2 = self gettagorigin("tag_accessory_left");
  self detach(scripts\engine\sp\utility::getmodel("cellphone_on"), "tag_accessory_left");
  var_3 = var_2 - var_0;
  var_4 = scripts\engine\sp\utility::spawn_anim_model("cellphone_on", var_0, var_1);
  var_4 physicslaunchserver(var_4.origin, var_3);
}

slow_react_enemy(var_0) {
  self.slow_react_type = "pain";
  self endon("damage");
  var_1 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var_1 notify("stop_anim_loop_" + self.animname);
  scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 thread scripts\common\anim::anim_single_solo(self, "dining_loop_once");
  var_2 = self.health;
  self.gunposeoverride_internal = "disable";
  var_3 = [];
  var_3[var_3.size] = scripts\engine\sp\utility::get_living_ai("dining_enemy2", "animname");
  var_3[var_3.size] = scripts\engine\sp\utility::get_living_ai("dining_enemy3", "animname");
  var_4 = var_3[0];

  if(!isalive(var_4))
    var_4 = var_3[1];

  if(!level.player isnightvisionon()) {
    if(isalive(var_4))
      self glanceatentity(var_4, 1200);

    wait 1.2;
    self glanceatentity(level.player, 800);
    wait 1.3;
  } else
    wait 0.5;

  self.slow_react_type = var_0;
}

slow_react_stop_animScripted() {
  scripts\engine\sp\utility::anim_stopanimScripted();
}

spot_player_dialogue() {
  self endon("death");
  var_0 = scripts\engine\utility::waittill_any_ents_return(self, "weapon_fired", level, "player_location_called") != "player_location_called";

  if(var_0) {
    thread callout_player_location();
    return;
  }

  level endon("location_callout_response");
  level waittill("finished_location_callout");
  wait(randomfloatrange(0, 0.15));
  thread respond_player_location_dialogue();
}

respond_player_location_dialogue() {
  level notify("location_callout_response");

  if(self.animname == "dining_enemy1")
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aqreact_10");
  else if(self.animname == "dining_enemy2")
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_dining_room_aqreact_20");
  else
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqreact_30");
}

callout_player_location() {
  if(!isDefined(self.lastenemysightpos)) {
    return;
  }
  var_0 = self.lastenemysightpos;
  level notify("player_location_called");
  self stopsounds();
  waitframe();

  if(self.animname == "dining_enemy1")
    var_1 = ["dx_vom_aq3_dining_room_frontroom_100", "dx_vom_aq3_dining_room_frontroom_110", "dx_vom_aq3_dining_room_frontroom_120"];
  else if(self.animname == "dining_enemy2")
    var_1 = ["dx_vom_aq2_dining_room_frontroom_130", "dx_vom_aq2_dining_room_frontroom_140", "dx_vom_aq2_dining_room_frontroom_150"];
  else
    var_1 = ["dx_vom_aqf1_dining_room_frontroom_160", "dx_vom_aqf1_dining_room_frontroom_170", "dx_vom_aqf1_dining_room_frontroom_180"];

  var_2 = getEnt("hallway_trigger", "targetname");
  var_3 = getEnt("kitchen_trigger", "targetname");
  var_4 = getEnt("front_door_trigger", "targetname");

  if(ispointinvolume(var_0, var_2))
    scripts\engine\sp\utility::smart_dialogue(var_1[0]);
  else if(ispointinvolume(var_0, var_3))
    scripts\engine\sp\utility::smart_dialogue(var_1[1]);
  else if(ispointinvolume(var_0, var_4))
    scripts\engine\sp\utility::smart_dialogue(var_1[2]);

  wait 0.35;
  level notify("finished_location_callout");
}

dining_react_dialogue(var_0) {
  self endon("death");
  level endon("player_location_called");
  thread spot_player_dialogue();

  if(var_0 == "dining_react_nolight") {
    if(self.animname == "dining_enemy1") {
      var_1 = ["dx_vom_aq2_dining_room_aqlight_20", 2.65, "dx_vom_aq2_dining_room_aqlight_60"];
      scripts\sp\maps\townhoused\townhoused_code.gsc::say_array(var_1);
    } else if(self.animname == "dining_enemy2") {
      var_1 = ["dx_vom_aq1_dining_room_aqlight_10", 1.5, "dx_vom_aq1_dining_room_aqlight_50", 2, "dx_vom_aq1_dining_room_aqlight_80"];
      scripts\sp\maps\townhoused\townhoused_code.gsc::say_array(var_1);
    } else if(self.animname == "dining_enemy3") {
      var_1 = ["dx_vom_aqf1_dining_room_aqlight_30", "dx_vom_aqf1_dining_room_aqlight_40", 1.35, "dx_vom_aqf1_dining_room_aqlight_70"];
      scripts\sp\maps\townhoused\townhoused_code.gsc::say_array(var_1);
    }
  } else {
    wait 0.1;

    if(self.animname == "dining_enemy1")
      scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_dining_room_aqreact_60");
    else if(self.animname == "dining_enemy2")
      scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aqreact_50");
    else if(self.animname == "dining_enemy3")
      scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqreact_40");
  }
}

dining_nolight_delay() {
  self endon("death");
  var_0 = undefined;

  if(isDefined(self.target)) {
    var_0 = getEnt(self.target, "targetname");
    self.target = undefined;
  }

  waitframe();

  if(self.animname == "dining_enemy1")
    thread dining_enemy1_react_lookat();

  self.og_maxsightdistsqrd = self.maxsightdistsqrd;
  var_1 = 170;
  self.maxsightdistsqrd = squared(var_1);
  level.player.ignoreme = 1;
  self clearenemy();
  self.dontevershoot = 1;
  thread dining_nolight_dist_thread();
  dining_nolight_wait_anim();
  var_2 = 0;

  if(self.animname == "dining_enemy3") {
    self.goalradius = 32;
    self setgoalpos(self.origin);
  } else if(isDefined(self.script_linkto)) {
    var_2 = 1;
    var_3 = scripts\engine\utility::get_linked_nodes();
    self.goalradius = 32;
    self setgoalnode(var_3[0]);
  }

  level.player.ignoreme = 0;
  var_4 = randomfloatrange(3, 5);
  self.stealth.scriptedinitialinvestigatedelay = var_4;
  dining_nolight_wait_time(var_4);
  self notify("stop_scaredlook");
  scripts\common\utility::lookatpos(undefined);
  self.maxsightdistsqrd = self.og_maxsightdistsqrd;
  self.dontevershoot = 0;

  if(isDefined(var_0))
    self setgoalvolumeauto(var_0);
}

dining_enemy1_react_lookat() {
  self setuplookatfornotetrack();
  scripts\common\utility::lookatentity(level.player, 1);
  wait 0.5;
  scripts\common\utility::lookatentity();
}

dining_nolight_scaredlook() {
  self endon("death");
  self endon("stop_scaredlook");
  var_0 = scripts\engine\utility::getStruct("dining_room_lookat_pos", "targetname");

  for(;;) {
    var_1 = randomfloatrange(5, 7);
    scripts\common\utility::lookatpos(var_0.origin);
    wait(var_1);
    scripts\common\utility::lookatpos(undefined);
    wait(randomfloatrange(0.3, 0.5));
  }
}

dining_nolight_enemy3_dialogue() {
  self endon("death");
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqlight_30");
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqlight_40");
}

dining_nolight_dist_thread() {
  self endon("death");
  level endon("stop_nolight_dist_thread");
  var_0 = squared(80);

  for(;;) {
    if(distancesquared(level.player.origin, self.origin) < var_0) {
      break;
    }

    waitframe();
  }

  level notify("stop_nolight_dist_thread");
  level.player.ignoreme = 0;
}

dining_nolight_wait_anim() {
  if(!istrue(level.demo)) {
    self endon("enemy");
    self endon("bulletwhizby");
  }

  self endon("damage");
  self waittillmatch("single anim", "end");
}

dining_nolight_wait_time(var_0) {
  if(!istrue(level.demo))
    self endon("bulletwhizby");

  self endon("damage");
  self endon("enemy");
  wait(var_0);
}

disable_player_sealth(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  level.player scripts\engine\utility::ent_flag_clear("stealth_enabled");
  level.player.maxvisibledist = 8192;
}

is_footstep_react() {
  if(!isDefined(self.anim_react_event))
    return 0;

  if(!isDefined(self.anim_react_event.typeorig))
    return 0;

  return self.anim_react_event.typeorig == "footstep";
}

dining_room_late_long_death() {
  if(!isalive(self)) {
    return;
  }
  if(istrue(level.demo) && self.animname == "dining_enemy3") {
    scripts\engine\sp\utility::set_deathanim("demo_death");
    return;
  }

  self endon("death");
  self notify("stop_dining_enemy_damage");
  self endon("stop_dining_room_late_long_death");

  if(self.health > 120)
    self.health = 200;

  self.allowdeath = 0;
  var_0 = scripts\engine\utility::getStruct(self.animname + "_late_long_death", "targetname");
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_long_death_relative(self, "dining_late_long_death", undefined, ::dining_longdeath_counter);
}

dinnig_enemy_react_then_pain() {
  self endon("death");
  self endon("stop_dining_enemy_damage");
  self waittill("damage");

  if(!isalive(self) || self.health == 1) {
    return;
  }
  self notify("react_pain");
  self stopanimScripted();

  if(self.currentpose == "crouch")
    scripts\asm\asm::asm_setstate("pain_crouch");
  else
    scripts\asm\asm::asm_setstate("pain_stand");

  if(self.a.weaponpos.size == 0 || !isDefined(self.a.weaponpos["right"]))
    scripts\anim\shared.gsc::forceuseweapon(self.sidearm, "secondary");
}

dining_death_vo() {
  if(self.animname == "dining_enemy3")
    scripts\sp\maps\townhoused\townhoused_code.gsc::do_sound_on_death("dx_vom_aqf1_dining_room_aqreact_71");
  else {
    if(self.animname == "dining_enemy2") {
      return;
    }
    if(self.animname == "dining_enemy1")
      scripts\sp\maps\townhoused\townhoused_code.gsc::do_sound_on_death("dx_vom_aq2_dining_room_aqreact_91");
    else {}
  }
}

dining_long_death_vo() {
  self endon("death");
  self waittill("longdeath");
  waitframe();

  if(self.animname == "dining_enemy3")
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqreact_70");
  else if(self.animname == "dining_enemy2")
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aqreact_80");
  else if(self.animname == "dining_enemy1")
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_dining_room_aqreact_90");
}

dining_trigger_damage_thread(var_0) {
  thread dining_trigger_damage_onnotify("damage");
  thread dining_trigger_damage_onnotify("flashbang");

  if(!isDefined(var_0))
    var_0 = 0;

  for(;;) {
    self waittill("trigger");

    if(!var_0 && !isDefined(self.triggertype)) {
      continue;
    }
    var_1 = scripts\engine\sp\utility::get_living_ai_array("dining_enemies", "script_noteworthy");

    if(var_0) {
      scripts\engine\utility::flag_set("player_exiting_kitchen");
      scripts\engine\sp\utility::array_notify(var_1, "react");
      continue;
    }

    if(self.triggertype == "frag") {
      foreach(var_3 in var_1) {
        if(distancesquared(var_3.origin, self.point) > 200 && randomint(100) < 70) {
          var_3 dodamage(var_3.health * 0.7, self.point, level.player);
          continue;
        }

        var_3 kill();
      }

      continue;
    }

    if(self.triggertype == "flash") {
      foreach(var_3 in var_1) {
        if(!istrue(var_3.flashbangimmunity))
          var_3 thread dining_enemy_flashbang();
      }
    }
  }
}

dining_enemy_flashbang() {
  self notify("stop_dining_enemy_react");
  self notify("stop_anim_react_death");
  self.skipdeathanim = undefined;
  scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\townhoused\townhoused_code.gsc::force_flash();
}

dining_trigger_damage_onnotify(var_0) {
  self endon("death");

  for(;;) {
    self waittill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_0 == "flashbang") {
      self.triggertype = "flash";
      self notify("trigger");
      continue;
    }

    if(isDefined(var_10) && var_10.basename == "frag") {
      self.triggertype = "frag";
      self.point = var_4;
      self notify("trigger");
      continue;
    }

    if(isDefined(var_10) && var_10.basename == "flash") {
      self.triggertype = "flash";
      self notify("trigger");
    }
  }
}

dining_engage_enemy(var_0) {
  self endon("death");
  self.target = undefined;
  self.goalradius = 32;

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_linked_nodes();
    self setgoalnode(var_1[0]);
  } else
    self setgoalpos(self.origin);

  self getenemyinfo(level.player);
  wait(randomfloat(2));

  if(isDefined(var_0))
    self.goalradius = var_0;
  else
    self.goalradius = 1000;
}

dining_react_death(var_0, var_1) {
  self endon("death");

  if(istrue(var_1)) {
    self endon("stop_death_react_thread");

    while(self.health > 1)
      waitframe();
  }

  if(self.damagelocation == "head" || self.damagelocation == "helmet")
    var_2 = "death";
  else
    var_2 = "long_death";

  self notify("stop_anim_react_death");

  if(var_2 == "long_death") {
    self notify("longdeath");
    var_3 = "dining_" + var_2;

    if(dining_longdeath_count_get() < 2 && isDefined(level.scr_anim[self.animname][var_3])) {
      var_4 = level.scr_anim[self.animname][var_3];

      if(!animhasnotetrack(var_4, "can_use_long_death_end")) {
        self.allowdeath = 1;
        var_5 = "dining_long_death_end";
        var_4 = level.scr_anim[self.animname][var_5];

        if(isDefined(var_4))
          scripts\engine\sp\utility::set_deathanim(var_5);
        else
          self.allowdeath = 1;
      }
    } else
      var_2 = "death";
  } else
    self.skipdeathanim = 1;

  if(var_2 == "long_death") {
    self actoraimassistoff();
    dining_longdeath_counter();
  } else
    dining_death_counter();

  var_0 scripts\sp\anim::anim_single_with_props([self], "dining_" + var_2);
  var_5 = "dining_" + var_2 + "_expire";

  if(var_2 == "long_death" && scripts\engine\utility::hasanim(var_5))
    var_0 scripts\sp\anim::anim_single_with_props([self], var_5);
}

dining_death_counter(var_0) {
  self notify("stop_dining_death_counter");
  self endon("stop_dining_death_counter");

  if(istrue(var_0))
    self waittill("death");

  if(!isDefined(level.dining_death_counter))
    level.dining_death_counter = 0;

  level.dining_death_counter++;

  if(level.dining_death_counter == 3)
    scripts\engine\utility::flag_set("dining_room_dead");
}

dining_longdeath_counter() {
  if(!isDefined(level.dining_longdeath_counter))
    level.dining_longdeath_counter = 0;

  level.dining_longdeath_counter++;
  dining_death_counter();

  if(dining_longdeath_count_get() == 3)
    return 0;
}

dining_longdeath_count_get() {
  if(!isDefined(level.dining_longdeath_counter))
    level.dining_longdeath_counter = 0;

  return level.dining_longdeath_counter;
}

dining_enemy3_grenade() {
  self endon("death");
  self waittill("grenade_bounce");
  self notify("stop_anim_react_death");
  self.allowdeath = 1;
  self.skipdeathanim = 1;
  scripts\common\anim::anim_single_solo(self, "dining_react_grenade");
  self.skipdeathanim = undefined;
}

dining_enemy3_react(var_0) {
  dining_delete_clip();
  self notify("stop_anim_react_death");
  self notify("stop_dining_enemy_damage");
  scripts\engine\sp\utility::clear_deathanim();

  if(var_0 == "pain")
    return var_0;

  var_1 = dining_room_is_light_dead();
  var_2 = scripts\engine\utility::getStruct("dining_animnode", "targetname");

  if(var_1) {
    self.allowdeath = 1;
    scripts\common\anim::anim_single_solo(self, "dining_react_high");
    return "skip_reaction";
  }

  if(isDefined(self.anim_react_event)) {
    if(self.anim_react_event.typeorig == "grenade danger") {
      thread scripts\common\anim::anim_single_solo(self, "dining_react_grenade");
      return "skip_reaction";
    }
  }

  thread dining_enemy3_react_goto_gun();
  return "skip_reaction";
}

dining_enemy3_react_goto_gun() {
  self endon("death");
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.allowdeath = 1;
  scripts\common\anim::anim_single_solo(self, "dining_react");
}

price_dining_room(var_0) {
  level.price endon("stop_dining_lookat");
  thread scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_dining_room_entry_10");
  var_1 = scripts\engine\utility::getStruct("dining_room_gesture", "targetname");
  level.price thread scripts\asm\gesture::ai_request_gesture("advance", var_1);
}

price_dining_room_end(var_0) {
  level.price notify("stop_dining_lookat");
  level.price.ignoreall = 1;
  level.price.dontevershoot = 0;
  level.price.favoriteenemy = undefined;
  level.price.aiment delete();
}

dining_room_animrate_adjust(var_0, var_1) {
  waitframe();
  scripts\engine\utility::flag_wait_either("dining_room_react", "player_exiting_kitchen");
  var_2 = var_1 + "_fastforward";

  if(scripts\engine\utility::flag_exist(var_2))
    scripts\engine\utility::flag_wait(var_2);

  level thread dining_room_teleport_price();
  self setanimrate(scripts\engine\utility::getanim(var_1), 1.6);
}

dining_room_teleport_price() {
  level endon("stop_dining_room_teleport");
  var_0 = scripts\engine\utility::getStruct("stairtrain1_animnode", "targetname");
  var_1 = level.price scripts\engine\utility::getanim("stairtrain1_arrive");
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var_4 = getEnt("dining_room_teleport_price_trigger", "targetname");
  var_5 = cos(80);
  var_6 = [level.player, level.price];

  for(;;) {
    waitframe();

    if(!level.player istouching(var_4)) {
      continue;
    }
    var_7 = 0;

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.price.origin + (0, 0, 60), var_5)) {
      if(cansee_bounds(level.price.origin))
        var_7 = 1;
    }

    var_8 = 0;

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2 + (0, 0, 60), var_5)) {
      if(cansee_bounds(var_2))
        var_8 = 1;
    }

    if(!var_7 && !var_8) {
      var_3 notify("stop_loop_price");
      level.price scripts\engine\sp\utility::anim_stopanimScripted();
      level.price.diningroom_skipanimreach = 1;
      level.price scripts\anim\notetracks_sp.gsc::notetrackvisorpricelower_instant();
      return;
    }
  }
}

cansee_bounds(var_0) {
  var_1 = vectortoangles(level.player.origin - var_0);
  var_2 = anglestoright(var_1);
  var_3 = 16;
  var_4 = 60;
  var_5 = 2;
  var_6 = 2;
  var_7 = var_4 / var_5;
  var_8 = var_3 / var_6;

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_9 + 1;
    var_11 = var_0 + var_2 * var_8 * var_10;

    if(cansee_vertical(var_11, var_5, var_7))
      return 1;
  }

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_9 + 1;
    var_11 = var_0 + var_2 * var_8 * var_10 * -1;

    if(cansee_vertical(var_11, var_5, var_7))
      return 1;
  }

  return 0;
}

cansee_vertical(var_0, var_1, var_2) {
  var_3 = (0, 0, 1);

  if(cansee_point(var_0))
    return 1;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_4 + 1;
    var_6 = var_0 + var_3 * var_2 * var_5;

    if(cansee_point(var_6))
      return 1;
  }

  return 0;
}

cansee_point(var_0) {
  var_1 = isDefined(level.player worldpointtoscreenpos(var_0, getdvarint("MRNKTKLLKP")));

  if(var_1) {} else {}

  return var_1;
}

stairtrain1_setup() {
  if(!isDefined(level.temp_stairtrain_count))
    level.temp_stairtrain_count = 0;

  var_0 = scripts\engine\utility::getStruct("stairtrain1_animnode", "targetname");

  if(self == level.price) {
    if(level.start_point != "stairtrain1") {
      if(!istrue(self.diningroom_skipanimreach))
        var_0 scripts\sp\anim::anim_reach_solo(self, "stairtrain1_arrive");

      level notify("stop_dining_room_teleport");
      level thread stairtrain1_price_player_race();
      var_0 scripts\common\anim::anim_single_solo(self, "stairtrain1_arrive");
    }

    scripts\engine\utility::flag_set("dining_room_price_in_position");
    var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, "stairtrain1_start", undefined, "stop_frontdoor_enter_loop");
  }

  scripts\engine\utility::flag_wait("stairtrain1_go");
  thread try_nvg_enable_hint();
  var_0 notify("stop_frontdoor_enter_loop");
  level.temp_stairtrain_count++;

  if(level.temp_stairtrain_count == 3) {
    level.temp_stairtrain_count = undefined;
    var_1 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
    var_2 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
    var_3 = [level.price, var_1, var_2];
    var_4 = undefined;

    foreach(var_6 in var_3) {
      if(isDefined(var_4))
        var_4 scripts\sp\stairtrain::set_prevguy(var_6);

      var_4 = var_6;
      var_6.animnode = var_0;
      var_6 scripts\engine\sp\utility::anim_stopanimScripted();
      var_6 thread scripts\asm\asm_sp::asm_animcustom(scripts\sp\maps\townhoused\townhoused_code.gsc::stairtrain1_animcustom);
    }

    scripts\engine\sp\utility::trigger_wait_targetname("player_base_stairtrain1");
    wait 2.35;
    scripts\engine\utility::flag_set("stairtrain1_started");
  }
}

stairtrain1_price_player_race() {
  level endon("stop_price_player_race");
  var_0 = scripts\engine\utility::getStruct("first_floor_hallway_path", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  waitframe();
  var_2 = level.price scripts\engine\utility::getanim("stairtrain1_arrive");
  var_3 = 0;

  for(;;) {
    var_4 = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
    var_5 = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.price.origin);
    var_6 = distancesquared(var_0.origin, var_4);
    var_7 = distancesquared(var_0.origin, var_5);

    if(var_6 > var_7 && !var_3) {
      var_3 = 1;
      level.price setanimrate(var_2, 2.5);
    } else if(var_6 < var_7 && var_3) {
      var_3 = 0;
      level.price setanimrate(var_2, 1);
    }

    waitframe();
  }
}

postspawn_bravo4() {
  scripts\engine\utility::set_movement_speed(120);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.script_pushable = 0;

  if(!scripts\sp\starts::is_after_start("dining_room"))
    self setCanDamage(0);

  scripts\sp\maps\townhoused\townhoused_code.gsc::postpawn_friendly_shared();
  level.squads["bravo4"] = scripts\engine\utility::array_add(level.squads["bravo4"], self);

  if(scripts\sp\starts::is_after_start("stairtrain1")) {
    if(self.animname == "bravo4_3") {
      wait 0.1;
      scripts\common\ai::stop_magic_bullet_shield();
      self delete();
    }

    return;
  }

  if(level.squads["bravo4"].size == 3)
    level thread bravo4_frontdoor_enter();
}

bravo4_frontdoor_enter() {
  var_0 = level.squads["bravo4"];
  var_1 = scripts\engine\utility::getStruct("stairtrain1_animnode", "targetname");
  var_1 scripts\common\anim::anim_first_frame(var_0, "frontdoor_start");
  scripts\engine\utility::flag_wait("player_in_dining_room");
  var_1 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop(var_0, "frontdoor_start", undefined, "stop_frontdoor_start_loop");
  scripts\engine\utility::flag_wait("dining_room_dead");
  scripts\engine\utility::flag_wait("player_said_dining_clear");
  var_2 = gettime();
  scripts\engine\utility::flag_wait("dining_room_price_in_position");
  wait(max(1 - (gettime() - var_2) * 0.001, 0));
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a31_stairtrain1_rally_10");
  var_1 notify("stop_frontdoor_start_loop");
  var_3 = getEnt("frontdoor", "targetname");
  var_3 scripts\engine\sp\utility::assign_animtree("door");
  var_1 thread scripts\common\anim::anim_single_solo(var_3, "frontdoor_enter");
  thread stair_player_clip();

  foreach(var_5 in var_0) {
    var_5 setCanDamage(1);

    if(var_5.animname == "bravo4_3") {
      var_1 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(var_5, "frontdoor_enter", undefined, "stop_frontdoor_enter_loop_bravo4_3");
      continue;
    }

    if(level.start_point != "stairtrain1")
      var_1 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(var_5, "frontdoor_enter", undefined, "stop_frontdoor_enter_loop");
  }

  if(level.start_point != "stairtrain1") {
    var_7 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
    var_7 waittillmatch("single anim", "end");
  }

  scripts\engine\utility::flag_set("delete_stair_player_pusher");

  foreach(var_5 in var_0) {
    if(var_5.animname == "bravo4_3") {
      continue;
    }
    if(var_5.animname == "bravo4_2")
      var_5 thread stairtrain1_ready_thread();

    var_5 thread stairtrain1_setup();
  }
}

stairtrain1_ready_thread() {
  self waittillmatch("single anim", "end");
  var_0 = squared(80);

  for(;;) {
    waitframe();

    if(distancesquared(self.origin, level.player.origin) < var_0) {
      break;
    }
  }

  scripts\engine\utility::flag_set("stairtrain1_go");
}

stair_player_clip() {
  wait 4;
  var_0 = getEnt("stair_player_pusher", "targetname");
  var_0 moveTo(var_0.og_origin, 4, 0, 4);
  scripts\engine\utility::flag_wait("delete_stair_player_pusher");
  var_0 delete();
}

bravo4_3_door_enter() {
  self waittillmatch("single anim", "end");
  self.script_pushable = 0;
  self.uprightcqbidle = 1;
  self.grenadeawareness = 0;
  self.goalradius = 16;
  self setgoalpos(self.origin);
  scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");
  scripts\common\ai::set_gunpose("gun_down");
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::lookat_random("front_door_random_lookats");
}

bravo_3_toggle_laser(var_0) {
  self endon("death");
  var_1 = cos(15);
  var_2 = 1;
  var_3 = 0;

  for(;;) {
    if(scripts\engine\utility::within_fov(self getEye(), self.angles, level.player getEye(), var_1)) {
      if(var_2) {
        scripts\sp\maps\townhoused\townhoused_code.gsc::enable_laser(0);
        scripts\common\ai::set_gunpose("gun_down");
        var_2 = 0;
      }
    } else if(var_2) {
      if(randomint(100) > 30) {
        var_3 = gettime() + randomintrange(2000, 5000);
        scripts\sp\maps\townhoused\townhoused_code.gsc::enable_laser(1);
        scripts\common\ai::set_gunpose("gun_down");
        var_2 = 0;
      }
    } else if(!var_2 && gettime() > var_3) {
      scripts\sp\maps\townhoused\townhoused_code.gsc::enable_laser(1);
      scripts\common\ai::set_gunpose("ads");
      var_2 = 1;
    }

    waitframe();
  }
}

create_aiment(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin_only_collision");
  var_1 notsolid();
  self.aiment = var_1;
  self.dontevershoot = 1;
  self setentitytarget(var_1);
  self.favoriteenemy = var_1;
  return var_1;
}

delete_aiment() {
  var_0 = self;

  if(isai(self))
    var_0 = self.aiment;

  var_0 delete();
}

second_floor_movement() {
  level.price thread second_floor_price();
  var_0 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var_0.end_pos = (273.801, 876.154, -305.97);
  var_0.end_angles = (0, 147.443, 0);
  var_0 thread second_floor_back_bedroom();
  var_1 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var_1.end_pos = (339.515, 930.924, -305.844);
  var_1.end_angles = (0, 98.5017, 0);
  var_1 thread second_floor_bathroom();
  scripts\engine\utility::flag_wait("2nd_floor_clear");
  var_2 = scripts\engine\utility::getStructArray("2ndfloor_animnodes", "script_noteworthy");

  foreach(var_4 in var_2) {
    var_4 notify("stop_second_floor_loop");
    var_4 notify("stop_loop");
  }

  var_6 = scripts\sp\door::get_interactive_door("secondfloor_door_two");
  var_6 scripts\sp\door::add_pushent(var_0);
  var_6 scripts\sp\door::add_pushent(var_1);
  var_0 thread second_floor_stairtrain_arrive();
  var_1 thread second_floor_stairtrain_arrive();
  var_7 = getEnt("2nd_floor_door_playerclip", "targetname");
  var_7 solid();
  var_7 = getEnt("2ndfloor_bathroom_playerclip", "targetname");
  var_7 delete();
  thread stairtrain2_player_near();
}

stairtrain2_player_near() {
  var_0 = getEnt("player_near_stairtrain2", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("player_near_stairtrain2");
}

second_floor_stairtrain_arrive() {
  var_0 = scripts\engine\utility::getStruct("stairtrain2_animnode", "targetname");

  if(self != level.price) {
    if(self.animname == "bravo4_2")
      scripts\engine\utility::flag_wait("bravo4_2_move_to_stairtrain2");
    else
      thread second_floor_bravo4_1_arrive_flag();

    if(distancesquared(self.origin, self.end_pos) > 100)
      self forceteleport(self.end_pos, self.end_angles);

    scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\sp\anim::anim_reach_solo(self, "stairtrain2_arrive");
    scripts\engine\utility::flag_wait("move_to_stairtrain2");
  }

  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, "stairtrain2_arrive", undefined, "stop_arrive_loop");
  scripts\engine\utility::flag_wait("2ndfloor_bathroom_enemy_dead");
  thread stairtrain2_setup();
}

second_floor_bravo4_1_arrive_flag() {
  var_0 = scripts\engine\utility::getStruct("stairtrain2_animnode", "targetname");
  var_1 = getstartorigin(var_0.origin, var_0.angles, scripts\engine\utility::getanim("stairtrain2_arrive"));

  while(distancesquared(self.origin, var_1) > 8100)
    waitframe();

  scripts\engine\utility::flag_set("bravo4_2_move_to_stairtrain2");
}

second_floor_price() {
  if(!scripts\engine\utility::ent_flag_exist("stairtrain_on"))
    scripts\engine\utility::ent_flag_init("stairtrain_on");

  if(scripts\engine\utility::ent_flag("stairtrain_on"))
    scripts\engine\utility::ent_flag_waitopen("stairtrain_on");

  interior_price_settings();

  if(getdvarint("scr_reveal") > 0)
    thread second_floor_reveal_stuff();

  var_0 = spawnStruct();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_single_then_loop_solo(self, "2ndfloor_arrive");
  self.goalradius = 32;
  self setgoalpos(self.origin);
  scripts\engine\utility::flag_wait("2nd_floor_move");

  if(getdvarint("scr_reveal") == 0)
    thread scripts\sp\maps\townhoused\townhoused_code.gsc::train_go("south");

  wait 0.25;
  thread targets_behind_door_callout();
  var_1 = scripts\engine\utility::getStruct("stairtrain2_animnode", "targetname");
  var_0 notify("stop_loop");
  var_1 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, "stairtrain2_pre_arrive", undefined, "stop_pre_arrive_loop_price");
  scripts\engine\utility::flag_wait("2nd_floor_clear");
  var_1 notify("stop_pre_arrive_loop_price");
  level.price thread second_floor_stairtrain_arrive();
}

second_floor_reveal_stuff() {
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::train_go("south");
  var_0 = undefined;

  foreach(var_2 in level.createfxent) {
    if(var_2.v["fxid"] == "vfx_streetlight_lensflare") {
      if(var_2.v["origin"][0] == 674.48) {
        var_0 = var_2;
        break;
      }
    }
  }

  wait 0.1;

  if(isDefined(var_0))
    var_0.looper delete();
}

targets_behind_door_callout() {
  level.hostage_enemy endon("death");
  level.hostage_enemy endon("enemy");
  wait 1;
  var_0 = gettime();

  while(isDefined(level.hostage_enemy) && !scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.hostage_enemy.origin, cos(15)) && !scripts\engine\utility::time_has_passed(var_0, 6))
    waitframe();

  if(!isDefined(level.hostage_enemy)) {
    return;
  }
  wait 0.3;
  thread scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_2nd_floor_bedroom2_10");
}

second_floor_back_bedroom() {
  if(!scripts\engine\utility::ent_flag_exist("stairtrain_on"))
    scripts\engine\utility::ent_flag_init("stairtrain_on");

  if(scripts\engine\utility::ent_flag("stairtrain_on"))
    scripts\engine\utility::ent_flag_waitopen("stairtrain_on");

  var_0 = scripts\engine\utility::getStruct("2ndfloor_bedroom_animnode", "targetname");
  var_1 = scripts\engine\sp\utility::get_living_ai("bedroom_enemy", "animname");

  if(getdvarint("scr_reveal") > 0)
    wait 3;

  var_2 = "2ndfloor_bedroom_enter";
  var_0 notify("stop_loop");
  var_3 = scripts\sp\door::get_interactive_door("2ndfloor_back_bedroom_door");
  var_3 scripts\sp\door::remove_open_ability();
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_door(var_3, var_2);
  level notify("stop_dog_sounds_front_door");

  if(getdvarint("scr_reveal") > 0)
    thread reveal_firing();

  var_1.allowdeath = 1;
  var_1.skipdeathanim = undefined;
  var_0 thread scripts\common\anim::anim_single_solo(var_1, var_2);
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, var_2, undefined, "stop_second_floor_loop");
}

reveal_firing() {
  wait 9.05;
  thread scripts\sp\maps\townhoused\townhoused_anim.gsc::second_floor_bedroom_reveal_fire(self);
  wait 0.3;
  thread scripts\sp\maps\townhoused\townhoused_anim.gsc::second_floor_bedroom_reveal_fire(self);
  wait 0.3;
  thread scripts\sp\maps\townhoused\townhoused_anim.gsc::second_floor_bedroom_reveal_fire(self);
}

back_bedroom_enemy() {
  var_0 = scripts\engine\utility::getStruct("2ndfloor_bedroom_animnode", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "2ndfloor_bedroom_enter");
}

second_floor_bathroom() {
  if(!scripts\engine\utility::ent_flag_exist("stairtrain_on"))
    scripts\engine\utility::ent_flag_init("stairtrain_on");

  if(scripts\engine\utility::ent_flag("stairtrain_on"))
    scripts\engine\utility::ent_flag_waitopen("stairtrain_on");

  var_0 = scripts\engine\utility::getStruct("2ndfloor_bathroom_animnode", "targetname");
  var_0 notify("stop_loop");
  var_1 = scripts\sp\door::get_interactive_door("2ndfloor_bathroom_door");
  var_1 scripts\sp\door::remove_open_ability();
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_door(var_1, "2ndfloor_bathroom_enter");
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, "2ndfloor_bathroom_enter");
}

postspawn_second_floor_enemy() {
  scripts\engine\sp\utility::disable_long_death();
  scripts\engine\sp\utility::disable_surprise();
  self.nofacialfiller = 1;

  if(self.animname == "bathroom_guy") {
    self.pathenemyfightdist = 10;
    thread bathroom_enemy();
    return;
  }

  if(self.animname == "bedroom_enemy") {
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.skipdeathanim = 1;
    thread back_bedroom_enemy();
    thread back_bedroom_enemy_death();
    return;
  }

  if(!isDefined(level.hostage_ai))
    level.hostage_ai = [];

  if(self.animname == "hostage_enemy") {
    level.hostage_enemy = self;
    scripts\engine\utility::ent_flag_init("engaging_enemy");
  } else if(self.animname == "hostage") {
    self.team = "neutral";
    level.hostage = self;
  }

  self.dontmelee = 1;
  level.hostage_ai[level.hostage_ai.size] = self;

  if(level.hostage_ai.size == 2)
    level thread hostage_sequence();
}

back_bedroom_enemy_death() {
  self waittill("death");
  level thread hostage_enemy_dialogue();
}

hostage_enemy_dialogue() {
  var_0 = level.hostage;
  var_1 = level.hostage_enemy;

  if(!isalive(var_1) || var_1 scripts\engine\utility::ent_flag("engaging_enemy")) {
    return;
  }
  var_1 endon("death");
  var_1 endon("engaging_enemy");
  wait 3;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_10");
  wait 1;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_20");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_2nd_floor_aq_convo4_30");
  wait 0.5;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_40");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_2nd_floor_aq_convo4_50");
  wait 1;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_25");
  wait 1;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_60");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_2nd_floor_aq_convo4_70");
}

hostage_sequence() {
  var_0 = scripts\engine\utility::getStruct("hostage_animnode", "targetname");
  var_1 = level.hostage;
  var_2 = level.hostage_enemy;
  var_1 thread scripts\sp\maps\townhoused\townhoused_code.gsc::do_sound_on_death("dx_vom_aqf2_2nd_floor_bedroom2_51");
  var_2 thread scripts\sp\maps\townhoused\townhoused_code.gsc::do_sound_on_death("dx_vom_aq5_2nd_floor_bedroom2_81");
  thread hostage_flank_react(var_0);

  foreach(var_4 in level.hostage_ai)
  level thread hostage_damage_thread(var_4, var_0);

  var_2 scripts\common\ai::gun_remove();
  var_2.weapon = isundefinedweapon();
  var_2 scripts\anim\shared.gsc::forceuseweapon(var_2.sidearm, "sidearm");
  var_2 scripts\anim\shared.gsc::placeweaponon(var_2.sidearm, "left");
  var_2 thread hostage_enemy_thread();
  var_0 thread scripts\common\anim::anim_loop(level.hostage_ai, "hostage_loop");
  var_1 thread hostage_detach_weapon();
}

hostage_detach_weapon() {
  wait 0.2;
  var_0 = self gettagorigin("tag_weapon_right");
  var_1 = self gettagangles("tag_weapon_right");
  var_2 = spawn("weapon_" + createheadicon(self.weapon), var_0, 2);
  waitframe();
  var_2.angles = var_1;
  self.gun_on_ground = var_2;
  self.og_sidearm = self.sidearm;
  self.sidearm = isundefinedweapon();
  scripts\common\ai::gun_remove();
}

hostage_damage_thread(var_0, var_1) {
  var_0 endon("stop_damage_thread");
  var_0.health = 10000;
  var_0.scripted_health = 150;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;

  while(var_0.scripted_health > 1) {
    var_0 waittill("damage", var_6, var_2, var_7, var_3, var_4, var_8, var_9, var_10, var_11, var_12);

    if(var_4 == "MOD_IMPACT") {
      continue;
    }
    var_0.scripted_health = var_0.scripted_health - var_6;

    if(var_0.scripted_health <= 0 && scripts\sp\maps\townhoused\townhoused_code.gsc::is_explosivedamage(var_4)) {
      var_1 notify("stop_loop");
      var_0.allowdeath = 1;
      var_0 kill(var_3, var_2, var_2, var_4);
      return;
    }

    if(scripts\sp\maps\townhoused\townhoused_code.gsc::is_flash_weapon(var_12)) {
      var_5 = 1;
      break;
    }
  }

  if(scripts\engine\utility::ent_flag_exist("engaging_enemy"))
    scripts\engine\utility::ent_flag_set("engaging_enemy");

  var_0 notify("stop_enemy_thread");
  var_0 notify("stop_anim_aim");

  if(var_5)
    var_0 thread hostage_flashbang_thread(var_1);
  else {
    var_0.health = 1;
    var_0.ignoreall = 1;
    var_0 scripts\sp\utility::context_melee_allow(0);
    level notify("stop_hostage_flank_react");

    foreach(var_14 in level.hostage_ai) {
      if(var_14 != var_0) {
        if(var_14.scripted_health > 0)
          var_14.health = var_14.scripted_health;

        var_14 notify("stop_enemy_thread");
        var_14 notify("stop_damage_thread");
      }

      var_14 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    var_1 notify("stop_loop");
    scripts\engine\utility::flag_set("2ndfloor_execute");
    var_16 = level.hostage;
    var_17 = level.hostage_enemy;

    if(var_0.animname == "hostage") {
      var_17 notify("stop_anim_aim");
      var_17 thread hostage_death_counter(1);
      var_16 hostage_death_counter();
      var_17.skipdeathanim = 1;
      var_17.allowdeath = 1;
      var_1 scripts\common\anim::anim_single(level.hostage_ai, "enemy_live");
      var_17.skipdeathanim = undefined;
    } else {
      var_16.skipdeathanim = 1;
      var_16.allowdeath = 1;
      var_16 stopsounds();
      var_17 stopsounds();
      var_17 actoraimassistoff();
      var_0.skipdeathanim = 1;
      var_16 thread hostage_death_counter(1);
      var_17 hostage_death_counter();

      if(istrue(level.demo))
        var_16 actoraimassistoff();

      if(var_0.damagelocation == "head" || var_0.damagelocation == "helmet") {
        var_0.skipdeathanim = undefined;
        var_0 scripts\engine\sp\utility::set_deathanim("hostage_headshot");
        var_0 kill(var_3, var_2, var_2, var_4);
        var_1 scripts\common\anim::anim_single_solo(var_16, "hostage_live");
        return;
      }

      var_17 thread hostage_enemy_ondeath();
      var_1 scripts\common\anim::anim_single(level.hostage_ai, "hostage_live");
    }
  }
}

hostage_flank_react(var_0) {
  level endon("stop_hostage_flank_react");
  scripts\engine\utility::flag_wait("hostage_flanked");
  var_0 notify("stop_loop");
  scripts\engine\utility::flag_set("2ndfloor_execute");

  foreach(var_2 in level.hostage_ai) {
    if(!isalive(var_2)) {
      continue;
    }
    var_2.health = var_2.scripted_health;
    var_2 notify("stop_enemy_thread");
    var_2 notify("stop_anim_aim");
    var_2 notify("stop_damage_thread");
    var_2 scripts\engine\sp\utility::anim_stopanimScripted();

    if(var_2.animname == "hostage" && var_2.weapon != var_2.og_sidearm) {
      var_2.team = "axis";
      var_3 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
      var_2 scripts\anim\shared.gsc::forceuseweapon(var_3, "primary");
      var_2 thread hostage_death_counter(1);
    }
  }
}

hostage_death_counter(var_0) {
  self notify("stop_hostage_death_counter");
  self endon("stop_hostage_death_counter");

  if(istrue(var_0))
    self waittill("death");

  if(!isDefined(level.hostage_death_counter))
    level.hostage_death_counter = 0;

  level.last_hostage_death_position = self.origin + (0, 0, 20);
  level.hostage_death_counter++;

  if(level.hostage_death_counter == 2)
    scripts\engine\utility::flag_set("hostage_guys_dead_or_longdeath");
}

hostage_enemy_ondeath() {
  scripts\engine\utility::delaythread(0.05, scripts\engine\sp\utility::smart_dialogue, "dx_vom_aq5_2nd_floor_bedroom2_82");
  self waittill("death");
  self setanimrate(scripts\engine\utility::getanim("hostage_live"), 0);
}

hostage_death_with_gun() {
  if(isDefined(self.scripted_longdeath))
    return 0;

  if(self.damagelocation == "head" || self.damagelocation == "helmet") {
    self.skipdeathanim = undefined;
    scripts\engine\sp\utility::set_deathanim("hostage_live_headshot");
  }

  return 0;
}

hostage_flashbang_thread(var_0) {
  var_0 notify("stop_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  self.health = int(max(self.scripted_health, 10));

  if(self.team != "axis") {
    self.team = "axis";
    self.sidearm = self.og_sidearm;
    self.primaryweapon = isundefinedweapon();
    scripts\anim\shared.gsc::forceuseweapon(self.sidearm, "secondary");
  }

  scripts\sp\maps\townhoused\townhoused_code.gsc::force_flash();
}

hostage_enemy_thread() {
  self endon("death");
  self endon("stop_enemy_thread");
  hostage_enemy_sight();
  scripts\engine\utility::ent_flag_set("engaging_enemy");
  self stopsounds();
  var_0 = scripts\engine\utility::getStruct("hostage_animnode", "targetname");
  var_0 notify("stop_loop");
  scripts\engine\utility::array_thread(level.hostage_ai, scripts\engine\sp\utility::anim_stopanimscripted);
  var_1["left"] = 30;
  var_1["right"] = -90;
  var_1["up"] = -15;
  var_1["down"] = 15;
  scripts\sp\maps\townhoused\townhoused_code.gsc::anim_aim("hostage_aim", var_0, var_1);
  var_0 thread scripts\common\anim::anim_loop_solo(level.hostage, "hostage_aim_loop");
}

hostage_enemy_sight() {
  var_0 = wait_see_player();
  level thread hostage_dialogue();
  level thread hostage_enemy_engage_dialogue();

  if(!istrue(var_0)) {
    return;
  }
  wait 0.25;
  self getenemyinfo(level.player);
}

wait_see_player() {
  self endon("enemy");
  var_0 = "tag_eye";

  for(;;) {
    if(sighttracepassed(self getEye(), level.player getEye(), 0, undefined)) {
      break;
    }

    waitframe();
  }

  return 1;
}

hostage_dialogue() {
  level endon("hostage_flanked");

  if(!isalive(level.hostage) || scripts\engine\utility::flag("2ndfloor_execute")) {
    return;
  }
  level.hostage endon("death");
  level endon("2ndfloor_execute");
  level.hostage thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_2nd_floor_bedroom2_60");
  level.hostage thread stop_sounds_on_damaged();
}

hostage_enemy_engage_dialogue() {
  level endon("hostage_flanked");

  if(!isalive(level.hostage_enemy) || scripts\engine\utility::flag("2ndfloor_execute")) {
    return;
  }
  level.hostage_enemy endon("death");
  level endon("2ndfloor_execute");
  level.hostage_enemy waittill("weapon_fired");
  level.hostage_enemy thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_bedroom2_80");
  level.hostage_enemy thread stop_sounds_on_damaged();
}

stop_sounds_on_damaged() {
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  self waittill("damage");
  self stopsounds();
}

bathroom_enemy() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("bathroom_enemy_animnode", "targetname");

  if(istrue(level.demo))
    self.health = 20;

  self.allowdeath = 1;
  self.animnode = var_0;
  self.deathfunction = ::bathroom_enemy_death_func;
  thread bathroom_enemy_death();
  thread bathroom_trigger_think();
  thread demo_bathroom_fakeblood();
  var_0 thread scripts\common\anim::anim_loop_solo(self, "bathroom_loop");
  scripts\engine\utility::flag_wait("2ndfloor_execute");
  thread bathroom_enemy_audio();

  while(!bathroom_enemy_react())
    waitframe();

  self stopsounds();
  wait 0.1;
  self notify("stop_bathroom_audio");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_2nd_floor_bedroom2_162");
  wait 0.3;
  thread bathroom_flash_think();
  var_0 notify("stop_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.baseaccuracy = 0;
  thread bathroom_nade_think();
  bathroom_enemy_react_anim(var_0);

  if(!istrue(self.scripted_flash))
    var_0 scripts\common\anim::anim_single_solo(self, "bathroom_crouch");

  if(istrue(level.demo)) {
    var_0 scripts\common\anim::anim_first_frame_solo(self, "bathroom_shoot");
    return;
  }

  self notify("getup");
  self.baseaccuracy = 0.2;
  self.skipdeathanim = undefined;
  self.deathfunction = undefined;

  if(istrue(self.threwbackgrenade) || istrue(self.scripted_flash))
    wait 3;

  scripts\engine\utility::flag_set("bathroom_guy_engage");
  self.deathfunction = undefined;
}

bathroom_trigger_think() {
  self endon("death");
  var_0 = getEnt("bathroom_damage_trigger", "targetname");
  var_0 thread bathroom_trigger_damage_ondamage();
  var_0 thread bathroom_trigger_damage_onflashbang();

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_0.triggertype)) {
      break;
    }
  }

  if(var_0.triggertype == "flash") {
    var_2 = scripts\engine\sp\utility::get_living_ai("bathroom_guy", "animname");

    if(isalive(var_2))
      var_2 notify("scripted_flash");
  }
}

bathroom_trigger_damage_ondamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "frag" && ispointinvolume(var_3, self))
      self.triggertype = "frag";
  }
}

bathroom_trigger_damage_onflashbang() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3);
    self.triggertype = "flash";
    self notify("trigger");
  }
}

bathroom_flash_think() {
  self endon("death");
  self endon("quick_getup");
  self endon("getup");
  self waittill("scripted_flash");
  scripts\engine\sp\utility::anim_stopanimScripted();
  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code.gsc::force_flash();
  self.scripted_flash = 1;
}

bathroom_nade_think() {
  self endon("death");
  self endon("quick_getup");
  self endon("getup");
  var_0 = 2025;
  var_1 = scripts\engine\utility::getStruct("bathroom_nade_throwback", "targetname");

  for(;;) {
    waitframe();
    var_2 = getEntArray("grenade", "classname");

    if(var_2.size == 0) {
      continue;
    }
    foreach(var_4 in var_2) {
      if(var_4.model == "offhand_wm_grenade_flash") {
        continue;
      }
      if(distancesquared(var_4.origin, self.origin) < var_0) {
        wait 0.5;

        if(distancesquared(var_4.origin, self.origin) < var_0) {
          var_5 = scripts\engine\utility::getStructArray(var_1.target, "targetname");
          var_6 = undefined;
          var_7 = undefined;

          foreach(var_9 in var_5) {
            if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "failsafe")
              var_6 = var_6;

            var_10 = scripts\engine\trace::ray_trace(var_1.origin, var_9.origin);

            if(var_10["fraction"] == 1) {
              var_7 = var_9;
              break;
            }
          }

          if(!isDefined(var_7)) {
            return;
          }
          var_12 = vectorNormalize(var_7.origin + (0, 0, 100) - var_1.origin);
          var_13 = var_12 * 300;
          var_14 = magicgrenademanual("frag", var_1.origin, var_13, 3, var_4);
          var_4 delete();
          thread nade_line(var_14);
          self.threwbackgrenade = 1;
          return;
        }
      }
    }
  }
}

nade_line(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;)
    waitframe();
}

bathroom_enemy_react_anim(var_0) {
  self endon("death");
  self endon("quick_getup");
  childthread bathroom_inner_trigger();
  var_0 scripts\common\anim::anim_single_solo(self, "bathroom_shoot");
}

bathroom_inner_trigger() {
  var_0 = getEnt("2nd_floor_bathroom_inner", "targetname");
  var_0 waittill("trigger");
  self notify("quick_getup");
}

demo_bathroom_fakeblood() {
  if(!istrue(level.demo)) {
    return;
  }
  self waittill("death");
  var_0 = self.origin + (0, 0, 30);
  var_1[0] = self.angles + (-125, 120, 0);
  var_1[1] = self.angles + (-120, 100, 0);
  var_1[2] = self.angles + (-87, 90, 0);
  var_1[3] = self.angles + (-115, 45, 0);
  var_1[4] = self.angles + (-95, 35, 0);
  var_1[5] = self.angles + (150, 0, 20);
  var_1[6] = self.angles + (130, 0, 0);
  var_1[7] = self.angles + (150, 70, 20);

  foreach(var_3 in var_1) {
    var_4 = anglesToForward(var_3);
    var_5 = anglestoup(var_3);
    playFX(scripts\engine\utility::getfx("blood_splat"), var_0, var_4, var_5);
  }
}

bathroom_enemy_death() {
  self waittill("death");
  scripts\engine\utility::flag_set("2ndfloor_bathroom_enemy_dead");
}

bathroom_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_1)) {
    return;
  }
  if(isai(var_1))
    playFX(scripts\engine\utility::getfx("door_shotgun_impact"), var_3, var_2);
}

bathroom_enemy_react() {
  if(self cansee(level.player))
    return 1;

  if(!isDefined(level.bathroom_door))
    return 1;

  if(level.bathroom_door.ajar)
    return 1;

  if(level.bathroom_door.open_completely)
    return 1;

  if(level.bathroom_door.bashed)
    return 1;

  if(level.bathroom_door.health < level.bathroom_door.start_health - 10)
    return 1;

  return 0;
}

bathroom_enemy_audio() {
  self endon("stop_bathroom_audio");
  self endon("death");
  self endon("stop_bathroom_breathing");
  thread bathroom_enemy_audio_close();

  for(;;) {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_2nd_floor_bedroom2_160");
    wait(randomfloatrange(0.1, 0.5));
  }
}

bathroom_enemy_audio_close() {
  self endon("stop_bathroom_audio");
  self endon("death");
  var_0 = squared(150);

  while(distancesquared(level.player.origin, self.origin) > var_0)
    waitframe();

  self notify("stop_bathroom_breathing");
  self stopsounds();
  self playSound("2nd_floor_shotgun_pump_behind_bathroom_door");
  self playSound("2nd_floor_shotgun_pump_behind_bathroom_door_2");
  thread sfx_random_mvmt_behind_door();
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_2nd_floor_bedroom2_161");
}

sfx_random_mvmt_behind_door() {
  self endon("stop_bathroom_audio");
  self endon("death");
  self.bathroom_sfx = spawn("script_origin", self.origin);
  self.bathroom_sfx linkTo(self);
  waitframe();
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_01");
  wait 0.5;
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_05_shells");
  wait 1.85;
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_02");
  wait 3.15;
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_03");
  wait 2.85;
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_04");
  wait 2.55;

  for(;;) {
    self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_random", "sounddone");
    self.bathroom_sfx waittill("sounddone");
    wait(randomfloatrange(2.0, 4.3));
  }
}

bathroom_enemy_death_func() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::scripted_deathanim("bathroom_death", self.animnode);

  if(isDefined(self.bathroom_sfx)) {
    self.bathroom_sfx stopsounds();
    self.bathroom_sfx delete();
  }
}

stairtrain2_setup() {
  if(!isDefined(level.temp_stairtrain_count))
    level.temp_stairtrain_count = 0;

  var_0 = scripts\engine\utility::getStruct("stairtrain2_animnode", "targetname");
  scripts\engine\utility::flag_wait("player_near_stairtrain2");
  level.temp_stairtrain_count++;

  if(level.temp_stairtrain_count == 3) {
    level.temp_stairtrain_count = undefined;
    var_1 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
    var_2 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
    var_3 = [level.price, var_1, var_2];
    var_0 notify("stop_first_frame");
    var_0 notify("stop_arrive_loop");
    var_4 = undefined;

    foreach(var_6 in var_3) {
      if(isDefined(var_4))
        var_4 scripts\sp\stairtrain::set_prevguy(var_6);

      var_4 = var_6;
      var_6.animnode = var_0;
      var_6 scripts\engine\sp\utility::anim_stopanimScripted();
      var_6 thread scripts\asm\asm_sp::asm_animcustom(scripts\sp\maps\townhoused\townhoused_code.gsc::stairtrain2_animcustom);
    }

    wait 1.3;
    level scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain2_rally_50");
  }
}

third_floor_movement() {
  var_0 = scripts\engine\utility::getStruct("buddy_down_animnode", "targetname");
  var_1 = scripts\sp\door::get_interactive_door("3rdfloor_price_door");
  var_1 scripts\sp\door::remove_open_ability();
  var_1 scripts\engine\sp\utility::assign_animtree("door");
  level.price thread post_stairtrain_anim(var_0, "buddy_down_intro", var_1);
  thread buddy_down_price_anim();
  var_2 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var_2 thread post_stairtrain_anim(var_0, "buddy_down_intro");
  var_3 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var_3 post_stairtrain_anim(var_0, "buddy_down_intro");
  thread buddy_down_damage_thread();
  scripts\engine\utility::flag_wait("player_near_buddy_down");
  var_4 = [var_2, var_3];

  foreach(var_6 in var_4)
  var_0 notify("stop_loop_" + var_6.animname);

  thread buddy_down_dialogue();
  scripts\engine\utility::flag_set("buddy_down");
  var_2 buddy_down_skip_setup();
  var_3 buddy_down_skip_setup();
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop(var_4, "buddy_down", undefined, "stop_buddy_down_loop");
  scripts\engine\utility::flag_wait("player_near_buddy_down_room");
  var_1 = scripts\sp\door::get_interactive_door("hiding_door");

  if(isDefined(var_1))
    var_1.ignore_grenades = undefined;

  scripts\engine\sp\utility::spawn_targetname("hiding_door_enemy");
  scripts\engine\utility::flag_wait("3rd_floor_enemies_dead");
  scripts\engine\utility::flag_wait("3rd_floor_clear");
  var_0 notify("stop_loop_" + level.price.animname);
  level.price scripts\engine\sp\utility::anim_stopanimScripted();

  if(scripts\engine\utility::flag("buddy_down_skip")) {
    buddy_down_skip_post_clear(var_0, var_4);
    level.price thread go_to_3rd_floor_stairtain("buddy_down_after");
  } else {
    var_0 notify("stop_buddy_down_loop");

    foreach(var_6 in var_4)
    var_6 scripts\engine\sp\utility::anim_stopanimScripted();

    level thread third_floor_buddy_down_drag(var_0, var_4);
    level.price thread go_to_3rd_floor_stairtain("buddy_down_after");
  }
}

third_floor_death_counter(var_0) {
  self notify("stop_third_floor_death_counter");
  self endon("stop_third_floor_death_counter");

  if(!isDefined(level.third_floor_death_counter))
    level.third_floor_death_counter = 0;

  if(istrue(var_0))
    self waittill("death");

  level.third_floor_death_counter++;

  if(level.third_floor_death_counter == 3)
    scripts\engine\utility::flag_set("3rd_floor_enemies_dead");
}

buddy_down_dialogue() {
  scripts\engine\utility::flag_wait_either("buddy_down_price_dialogue", "buddy_down_skip");

  if(!scripts\engine\utility::flag("buddy_down_skip")) {
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_3rd_floor_bedroom_20");
    wait 1;
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_3rd_floor_bedroom_30");
    wait 0.1;
    scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a31_3rd_floor_bedroom_40");
  } else
    scripts\engine\utility::flag_wait("player_in_buddy_down_room");

  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_3rd_floor_bedroom_50";
  var_0[var_0.size] = "dx_vom_pri_3rd_floor_bedroom_60";
  var_0[var_0.size] = "dx_vom_pri_3rd_floor_bedroom_70";
  level.price scripts\sp\maps\townhoused\townhoused_code.gsc::radio_nag(var_0, "player_in_buddy_down_room");
  var_1 = scripts\engine\sp\utility::get_living_ai("buddy_down_enemy", "script_noteworthy");
  var_2 = scripts\engine\sp\utility::get_living_ai("buddy_down_gunner", "script_noteworthy");
  var_3 = [var_1, var_2];

  if(var_3.size > 0) {
    var_4 = get_first_living_in_array(var_3);

    if(isalive(var_4) && var_4.health > 10) {
      var_4 waittill("weapon_fired");
      var_4 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_3rd_floor_bedroom_80");
      wait 2;
      var_4 = get_first_living_in_array(var_3);

      if(isalive(var_4) && var_4.health > 10) {
        var_4 waittill("weapon_fired");
        var_4 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_3rd_floor_bedroom_90");
      }
    }
  }
}

buddy_down_price_anim() {}

buddy_down_two_enemy_dead_thread(var_0) {
  while(any_alive(var_0))
    wait 0.1;
}

any_alive(var_0) {
  foreach(var_2 in var_0) {
    if(isalive(var_2))
      return 1;
  }

  return 0;
}

get_first_living_in_array(var_0) {
  foreach(var_2 in var_0) {
    if(isalive(var_2))
      return var_2;
  }
}

third_floor_buddy_down_drag(var_0, var_1) {
  var_2 = "buddy_down_drag";
  var_3 = getEnt("3rd_floor_door_playerclip", "targetname");
  var_3 solid();
  scripts\engine\sp\utility::array_spawn_targetname("bravo4_reinforcements", 1);
  var_4 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  var_4 thread go_to_3rd_floor_stairtain(var_2);
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop(var_1, var_2);
  var_1 = scripts\engine\utility::array_add(var_1, var_4);

  foreach(var_6 in var_1) {
    if(var_6.animname == "bravo4_1") {
      var_7 = scripts\sp\door::get_interactive_door("buddydown_door");
      var_7 scripts\sp\door::add_pushent(var_6);
    }
  }

  waitframe();
  var_9 = 1.7;

  foreach(var_6 in var_1) {
    var_11 = var_9 / getanimlength(var_6 scripts\engine\utility::getanim(var_2));
    var_6 setanimtime(var_6 scripts\engine\utility::getanim(var_2), var_11);
    var_6 setanimrate(var_6 scripts\engine\utility::getanim("buddy_down_drag"), 0);
  }

  third_floor_view_exit();

  foreach(var_6 in var_1)
  var_6 setanimrate(var_6 scripts\engine\utility::getanim("buddy_down_drag"), 1);
}

third_floor_view_exit() {
  var_0 = getEnt("3rdfloor_exit_failsafe", "targetname");
  var_0 endon("trigger");
  var_1 = scripts\engine\utility::getStruct("3rd_floor_view_exit", "targetname");

  for(;;) {
    var_2 = level.player getEye();

    if(scripts\engine\utility::within_fov(var_2, level.player getplayerangles(), var_1.origin, 0.939693) && sighttracepassed(var_2, var_1.origin, 0, level.player)) {
      break;
    }

    waitframe();
  }
}

buddy_down_skip_post_clear(var_0, var_1) {
  var_2 = "buddy_down_drag";
  scripts\engine\sp\utility::array_spawn_targetname("bravo4_reinforcements", 1);
  var_3 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  var_3 thread go_to_3rd_floor_stairtain(var_2);

  foreach(var_5 in var_1) {
    if(var_5.animname == "bravo4_1" || var_5.animname == "bravo4_2") {
      var_6 = scripts\engine\utility::getStruct("temp_" + var_5.animname + "_3rd_floor_teleport", "targetname");
      var_5.script_pushable = 0;
      var_7 = scripts\engine\utility::drop_to_ground(var_6.origin, 10, -100);
      var_5 forceteleport(var_7, var_6.angles);
      var_5 setgoalpos(var_7);
      var_5.uprightcqbidle = 1;
      var_5.goalradius = 4;
      var_5.fixednode = 0;
      var_5 scripts\common\ai::set_gunpose("gun_down");
      continue;
    }

    var_0 thread scripts\common\anim::anim_loop_solo(var_5, "buddy_down_drag_loop");
  }
}

buddy_down_damage_thread() {
  var_0 = getEnt("buddy_down_damage_trigger", "targetname");
  var_0 thread buddy_down_trigger_damage_ondamage();
  var_0 thread buddy_down_trigger_damage_onflashbang();

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_0.triggertype)) {
      break;
    }
  }

  var_2 = scripts\engine\sp\utility::get_living_ai("buddy_down_enemy", "script_noteworthy");
  var_3 = scripts\engine\sp\utility::get_living_ai("buddy_down_gunner", "script_noteworthy");

  if(var_0.triggertype == "frag") {
    if(isalive(var_2)) {
      if(var_2.damageshield)
        var_2.damageshield = 0;

      var_2 kill();
    }

    if(isalive(var_3)) {
      if(var_3.damageshield)
        var_3.damageshield = 0;

      var_3 kill();
    }
  } else if(var_0.triggertype == "flash") {
    if(isalive(var_2))
      var_2 scripts\sp\maps\townhoused\townhoused_code.gsc::force_flash();

    if(isalive(var_3))
      var_3 scripts\sp\maps\townhoused\townhoused_code.gsc::force_flash();
  }

  var_0 delete();
}

buddy_down_door_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\engine\utility::flag("buddy_down_skip")) {
    return;
  }
  if(scripts\engine\utility::flag("shoot_buddy_down")) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 == level.player)
    level thread buddy_down_player_engaging_early();
}

buddy_down_player_engaging_early() {
  if(scripts\engine\utility::flag("buddy_down_player_engaging_early")) {
    return;
  }
  scripts\engine\utility::flag_set("buddy_down_player_engaging_early");
  var_0 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_a11_stairtrain2_rally_60");
  wait 1;
  var_1 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_a12_stairtrain2_rally_70");
}

buddy_down_trigger_damage_ondamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "frag" && ispointinvolume(var_3, self)) {
      self.triggertype = "frag";
      var_10 = scripts\sp\door::get_interactive_door("buddydown_door");
      var_10 scripts\sp\door_scriptable::scriptable_damage_proc(200, var_1, var_2, level.player.origin, var_4);
    }
  }
}

buddy_down_trigger_damage_onflashbang() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3);
    self.triggertype = "flash";
    self notify("trigger");
  }
}

post_stairtrain_anim(var_0, var_1, var_2) {
  if(scripts\engine\utility::ent_flag_exist("stairtrain_on")) {
    if(scripts\engine\utility::ent_flag("stairtrain_on"))
      scripts\engine\utility::ent_flag_waitopen("stairtrain_on");
  }

  if(isDefined(var_2))
    var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_door(var_2, var_1);

  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, var_1, undefined, "stop_loop_" + self.animname);
}

go_to_3rd_floor_stairtain(var_0) {
  var_1 = scripts\engine\utility::getStruct("buddy_down_animnode", "targetname");

  if(scripts\engine\utility::flag("buddy_down_skip"))
    var_1 thread scripts\common\anim::anim_loop_solo(self, var_0 + "_loop", "stop_arrive_3rd_floor_stairtrain");
  else
    var_1 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, var_0, undefined, "stop_arrive_3rd_floor_stairtrain");

  scripts\engine\utility::flag_wait("player_near_stairtrain3");
  var_1 notify("stop_arrive_3rd_floor_stairtrain");
  thread stairtrain3_setup();
}

postspawn_bravo4_reinforcement() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::postpawn_friendly_shared();
  scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");

  if(self.animname == "bravo4_4") {
    self.ignoreall = 1;
    self.ignoreme = 1;

    if(level.start_point == "4th_floor")
      return;
  } else
    return;
}

postspawn_buddy_down_enemy() {
  thread third_floor_death_counter(1);
  scripts\engine\sp\utility::disable_surprise();
  self.grenadeawareness = 0;
  self.animname = "buddy_down_enemy";

  if(istrue(level.demo)) {
    scripts\sp\spawner::go_to_node(self.go_to_node);
    scripts\engine\sp\utility::set_generic_deathanim("demo_shotgun_death");
  }
}

postspawn_buddy_down_gunner() {
  self endon("death");
  self.nofacialfiller = 1;
  thread third_floor_death_counter(1);

  if(istrue(level.demo)) {
    scripts\anim\shared.gsc::forceuseweapon("iw8_ar_akilo47", "primary");
    self.sidearm = isundefinedweapon();
  }

  self.animname = "buddy_down_gunner";
  self.damageshield = 1;
  thread buddy_down_gunner_damage_thread();
  thread buddy_down_gunner_flashed_thread();
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::do_sound_on_death("dx_vom_aq2_3rd_floor_bedroom_91");
  self.grenadeawareness = 0;
  scripts\engine\sp\utility::disable_surprise();
  level endon("buddy_down_skip");
  level thread buddy_down_enemydead_interrupt(self);
  scripts\engine\utility::flag_wait("shoot_buddy_down_vo");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_3rd_floor_bedroom_10");
  scripts\engine\utility::flag_wait("shoot_buddy_down");
  level thread enemy_shoot_buddy_down_door(self);
}

buddy_down_enemydead_interrupt(var_0) {
  level endon("shoot_buddy_down");
  scripts\engine\utility::flag_wait("buddy_down_enemy_dead");

  if(isalive(var_0) && var_0.health > 1) {
    return;
  }
  scripts\engine\utility::flag_set("buddy_down_skip");
}

buddy_down_skip_setup() {
  self.blendtoai["flag"] = "buddy_down_skip";
  self.blendtoai["blendTime"] = 0.3;
  self.blendtoai["endfunc"] = ::buddy_down_skip_move;
  self.scriptedthread = ::blend_to_ai;
}

buddy_down_skip_move() {
  var_0 = scripts\engine\utility::getStruct("buddy_down_animnode", "targetname");
  var_0 notify("stop_buddy_down_loop");
  self setgoalpos(self.origin);
  wait 0.5;
  var_1 = getnode("3rdfloor_stairs_" + self.animname, "targetname");
  self.goalradius = 32;
  self setgoalnode(var_1);
}

#using_animtree("generic_human");

blend_to_ai() {
  var_0 = self.codescripted["anim"];
  var_1 = [%add_idle, %aim_graft_node, %gun_down_stand];
  var_2 = [%sdr_com_exposed_twitch01, %sdr_com_exposed_aim_4, %sdr_com_exposed_stand_gun_down];
  scripts\engine\utility::flag_wait(self.blendtoai["flag"]);
  var_3 = self.blendtoai["blendTime"];
  var_4 = scripts\asm\asm::asm_lookupanimfromalias("exposed_idle", "rifle_aim_5");
  var_5 = scripts\asm\asm::asm_getxanim("exposed_idle", var_4);
  self setflaggedanim("whatever", var_5, 1, var_3);
  self.gunposeoverride = "disable";

  foreach(var_7 in var_1)
  self setanimknob(var_7, 1, var_3);

  foreach(var_10 in var_2)
  self setanimlimited(var_10, 1, 0);

  self clearanim(%scripted, var_3);
  self setanimrate(var_0, 0);
  scripts\anim\notetracks_sp.gsc::notetrackvisorlower_instant();
  wait(var_3);

  if(isDefined(self.blendtoai["endfunc"]))
    self thread[[self.blendtoai["endfunc"]]]();

  self.uprightcqbidle = 1;
  scripts\engine\utility::set_movement_speed(20);
  scripts\engine\sp\utility::anim_stopanimScripted();
}

fake_animScripted() {
  self animmode("noclip");
  self setanim(self.fake_animation, 1, 1);
  self waittillmatch("fake_animscripted", "end");
}

buddy_down_gunner_damage_thread() {
  for(var_0 = self.health; var_0 > 0; var_0 = var_0 - var_1)
    self waittill("damage", var_1);

  if(!isalive(self)) {
    return;
  }
  self.damageshield = 0;
  self.health = 1;

  if(!buddy_down_gunner_death())
    self kill();
}

buddy_down_gunner_death() {
  var_0 = get_buddy_down_gunner_animnode();

  if(isDefined(self.flashed_animnode)) {
    self.flashed_animnode notify("stop_loop");
    var_0 = self.flashed_animnode;
  }

  if(isDefined(var_0)) {
    self.animname = "generic";
    var_1 = getstartangles(var_0.origin, var_0.angles, scripts\engine\utility::getanim("gunner_couch_death"));

    if(abs(self.angles[1] - var_1[1]) > 15)
      return 0;

    self.allowdeath = 1;
    self.skipdeathanim = 1;
    scripts\sp\maps\townhoused\townhoused_code.gsc::enable_death_clearscriptedanim();
    self notify("stop_fake_flash");
    thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_3rd_floor_bedroom_92");
    self actoraimassistoff();
    third_floor_death_counter();
    var_2 = getstartorigin(var_0.origin, var_0.angles, scripts\engine\utility::getanim("gunner_couch_death"));
    var_3 = var_0.origin - var_2;
    var_4 = scripts\engine\utility::spawn_script_origin(self.origin + var_3, var_0.angles);
    self linkTo(var_4);
    var_4 moveTo(var_0.origin, 1);
    var_4 scripts\common\anim::anim_single_solo(self, "gunner_couch_death");
    var_4 delete();

    if(isalive(self))
      self kill();

    return 1;
  }

  return 0;
}

get_buddy_down_gunner_animnode() {
  var_0 = 12;
  var_1 = scripts\engine\utility::getStruct("buddy_down_gunner_animnode", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = [var_1.origin, var_2.origin];
  var_4 = [];
  var_4[var_4.size] = var_3;
  var_5 = vectorNormalize(var_2.origin - var_1.origin);
  var_6 = var_1.origin + var_5 * var_0;
  var_7 = var_2.origin + var_5 * var_0;
  var_8 = scripts\engine\utility::flat_origin(var_6);
  var_9 = scripts\engine\utility::flat_origin(var_7);
  var_10 = scripts\engine\utility::flat_origin(self.origin);
  var_11 = vectorNormalize(var_8 - var_10);
  var_12 = vectordot(var_5, var_11);
  var_13 = vectorNormalize(var_9 - var_10);
  var_14 = vectordot(var_5, var_13);
  var_15 = var_1.origin + var_5 * (var_0 * -1);
  var_16 = var_2.origin + var_5 * (var_0 * -1);

  if(var_12 < 0 && var_14 > 0) {
    var_17 = spawnStruct();
    var_17.angles = var_1.angles + (0, -10, 0);
    var_17.origin = pointonsegmentnearesttopoint(var_15, var_16, self.origin);
    var_3 = [var_17.origin, self.origin];
    var_4[var_4.size] = var_3;
    return var_17;
  }

  return undefined;
}

buddy_down_gunner_flashed_thread() {
  self endon("death");
  self endon("stop_fake_flash");
  self waittill("flashed");
  var_0 = get_buddy_down_gunner_animnode();
  self.flashed_animnode = var_0;
  var_0 scripts\common\anim::anim_generic(self, "fake_flash");
  var_0 thread scripts\common\anim::anim_generic_loop(self, "fake_flash_idle");
  player_cansee_buddy_down_flashed();
  var_0 notify("stop_loop");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_enemy_wait_10");
  var_0 scripts\common\anim::anim_generic(self, "fake_flash_react");
}

player_cansee_buddy_down_flashed() {
  self endon("stop_animmode");
  var_0 = gettime() + 3000;

  while(gettime() < var_0) {
    waitframe();
    var_1 = self gettagorigin("tag_eye");
    var_2 = level.player getEye();

    if(scripts\engine\utility::within_fov(var_2, level.player getplayerangles(), var_1, 0.939693) && sighttracepassed(level.player getEye(), var_1, 0, level.player)) {
      break;
    }
  }
}

enemy_shoot_buddy_down_door(var_0) {
  level endon("buddy_down_grenade_explode");
  var_0 endon("death");
  var_1 = scripts\engine\utility::getStruct("enemy_buddy_shoot_door", "targetname");
  var_2 = spawn("script_origin", var_1.origin);
  var_0.dontevershoot = 1;
  var_0 setentitytarget(var_2);
  thread third_floor_frame_pulse(var_0);
  level.player setsoundsubmix("sp_th_buddy_down_npc_guns_down");
  var_0 thread sfx_buddy_down_fire_volley();
  thread sfx_buddy_down_debris();

  for(;;) {
    var_3 = var_0 gettagorigin("tag_flash");
    magicbullet(var_0.primaryweapon, var_3, var_1.origin, var_0);
    magicbullet(var_0.primaryweapon, var_3, var_1.origin, var_0);
    var_4 = vectorNormalize(var_1.origin - var_3);
    var_5 = var_1.origin + var_4 * 3;
    var_6 = var_3 + var_4 * 200;
    magicbullet(var_0.primaryweapon, var_5, var_6, var_0);
    wait(randomfloatrange(0.05, 0.15));

    if(!isDefined(var_1.target)) {
      break;
    }

    var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    var_2.origin = var_1.origin;
  }

  var_0 clearentitytarget();
  wait 1;
  var_0.dontevershoot = 0;
  var_1 = scripts\engine\utility::getStruct("enemy_buddy_shoot_door_post", "targetname");
  var_2.origin = var_1.origin;
  var_2 makeentitysentient("allies");
  var_2 setthreatbiasgroup("allies");
  var_0.favoriteenemy = var_2;
  wait 2;
  var_2 delete();
}

sfx_buddy_down_fire_volley() {
  self playSound("scn_buddy_down_npc_fire_lr");
}

sfx_buddy_down_debris() {
  thread scripts\engine\utility::play_sound_in_space("scn_buddy_down_npc_fire_door_lr", (174, 1037, -136));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("scn_buddy_down_door_debris", (215, 1010, -153));
}

third_floor_frame_pulse(var_0) {
  var_0 endon("death");
  wait 0.5;
  var_1 = getEnt("buddy_down_picture", "targetname");
  var_2 = anglesToForward(var_1.angles) * 1;
  var_1 physicslaunchserver(var_1.origin + (0, 0, randomfloatrange(-5, 5)), var_2);
  wait 0.25;
  var_1 = getEnt(var_1.target, "targetname");
  var_2 = anglesToForward(var_1.angles) * 1;
  var_1 physicslaunchserver(var_1.origin + (0, 0, randomfloatrange(-5, 5)), var_2);
}

postspawn_hiding_door_enemy() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("hiding_door_animnode", "targetname");
  self.animname = "generic";
  self.primaryweapon = isundefinedweapon();
  scripts\anim\shared.gsc::forceuseweapon(self.sidearm, "secondary");
  var_1 = scripts\sp\door::get_interactive_door("hiding_door");
  var_1 scripts\sp\door::remove_open_ability();
  var_1.tagent = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_1.tagent scripts\engine\sp\utility::assign_animtree("door");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "python_enter");
  var_0 scripts\common\anim::anim_first_frame_solo(var_1.tagent, "python_enter");
  wait 0.1;
  var_1.startyaw = var_1.angles[1];
  var_1 linkTo(var_1.tagent);
  var_1 thread hiding_door_model(self);
  thread hiding_door_enemy_dead_dialogue();
  python_enter(var_0, var_1);
}

python_enter(var_0, var_1) {
  self.nofacialfiller = 1;
  thread third_floor_death_counter(1);
  favela_door_trigger();
  thread audio_python_open_filter();
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_3rd_floor_bedroom_102");
  wait(randomfloatrange(0.05, 0.3));

  if(self.health == 150)
    self.health = self.health - 20;

  thread hiding_door_enemy_death_dialogue();
  self.diequietly = 1;
  var_1 thread hiding_door_anim_thread();
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_long_death(self, "python_enter", 1, ::python_longdeath_callback);
  var_0 scripts\common\anim::anim_single([self, var_1.tagent], "python_enter");
}

hiding_door_anim_thread() {
  self waittillmatch("single anim", "end");
  self notify("stop_open_door_on_death");

  if(isDefined(self.tagent))
    self.tagent delete();

  thread hiding_door_make_pushable();
}

python_longdeath_callback() {
  third_floor_death_counter();
  var_0 = 0;

  if(isDefined(self.damageweapon) && weaponclass(self.damageweapon) == "spread")
    var_1 = ["torso_upper", "head", "helmet", "neck", "left_arm_upper", "torso_lower"];
  else
    var_1 = ["torso_upper", "head", "helmet", "neck", "left_arm_upper"];

  foreach(var_3 in var_1) {
    if(self.damagelocation == var_3)
      return 1;
  }

  self.skipdeathanim = undefined;
  self.allowdeath = 1;
  self kill();
  var_5 = level.player;

  if(isDefined(self.lastattacker))
    var_5 = self.lastattacker;

  self dodamage(10, var_5.origin, var_5, var_5, self.damagemod, self.damageweapon);
  return 0;
}

hiding_door_enemy_death_dialogue() {
  self waittill("longdeath");
  self stopsounds();
  waitframe();
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_3rd_floor_bedroom_104");
  self waittill("death");
  self stopsounds();
}

audio_python_open_filter() {
  wait 0.8;
  level.player clearallsoundsubmixes(0.8);
}

favela_door_trigger() {
  level endon("buddy_down_favela_guy_too_close");
  level.player setsoundsubmix("sp_th_python_scream");
  scripts\engine\utility::flag_wait_or_timeout("buddy_down_favela_guy", 7);
  var_0 = scripts\engine\utility::getStruct("favela_door_lookat", "targetname");
  var_1 = cos(20);

  while(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1))
    waitframe();
}

favela_door(var_0, var_1) {
  var_2 = ["peak", "fire3"];
  var_3 = 0;
  favela_door_trigger();

  for(;;) {
    var_0 thread scripts\common\anim::anim_loop_solo(self, "faveladoor_idle");

    if(!var_3 == 0)
      wait 0.1;
    else
      wait(randomfloatrange(0.3, 4));

    var_4 = "peak";

    if(var_3 < 2) {
      var_4 = var_2[var_3];
      var_3++;
    } else if(randomint(100) > 40) {
      var_5 = randomintrange(1, 3);
      var_4 = "fire" + var_5;
    } else if(randomint(100) > 40)
      var_4 = "idle";

    var_0 notify("stop_loop");
    self stopanimScripted();

    if(var_4 != "idle") {
      var_0 scripts\common\anim::anim_single([self, var_1.tagent], "faveladoor_" + var_4);
      var_6 = 1;
    }

    waitframe();
  }
}

hiding_door_model(var_0) {
  self endon("stop_open_door_on_death");
  var_0 waittill("death");
  self unlink();

  if(isDefined(self.tagent))
    self.tagent delete();

  thread hide_door_rotate();
}

hide_door_rotate() {
  var_0 = angleclamp(self.startyaw + 115);
  var_1 = abs(var_0 - angleclamp(self.angles[1]));
  var_2 = var_1 / 60;
  var_3 = self.pivots["open_left"].origin - self.og_origin;
  var_4 = rotatevector(var_3, self.angles - self.true_start_angles);
  scripts\sp\maps\townhoused\townhoused_code.gsc::temp_scriptablerotateTo((0, var_0, 0), var_2, 0, var_2, var_3);
  thread hiding_door_make_pushable();
}

hiding_door_make_pushable() {
  if(isDefined(self.scripted_ispushable)) {
    return;
  }
  self.scripted_ispushable = 1;
  var_0 = self.pivots["open_left"].origin - self.og_origin;
  var_1 = rotatevector(var_0, self.angles - self.true_start_angles);
  self.pivot_ent = scripts\engine\utility::spawn_script_origin(self.origin + var_1, self.angles);
  self linkTo(self.pivot_ent);
  self.hinge_side = "open_left";
  self.forward = anglesToForward(self.pivot_ent.angles);
  thread scripts\sp\door_internal::monitor_door_push(0);
  scripts\sp\door_internal::waittill_second_interact_or_bash();
  scripts\sp\door::remove_open_ability();
}

hiding_door_enemy_dead_dialogue() {
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::do_sound_on_death("dx_vom_aq6_3rd_floor_bedroom_103");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_3rd_floor_bedroom_100");
  self waittill("death");
  scripts\engine\utility::flag_set("3rd_floor_bedroom_enemy_dead");
}

stairtrain3_setup() {
  if(!isDefined(level.temp_stairtrain_count))
    level.temp_stairtrain_count = 0;

  var_0 = scripts\engine\utility::getStruct("stairtrain3_animnode", "targetname");
  level.temp_stairtrain_count++;

  if(level.temp_stairtrain_count == 2) {
    level.temp_stairtrain_count = undefined;
    var_1 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
    var_2 = [level.price, var_1];
    var_0 notify("stop_first_frame");
    var_3 = undefined;

    foreach(var_5 in var_2) {
      if(isDefined(var_3))
        var_3 scripts\sp\stairtrain::set_prevguy(var_5);

      var_3 = var_5;
      var_5.animnode = var_0;
      var_5 scripts\engine\sp\utility::anim_stopanimScripted();
      var_5 thread scripts\asm\asm_sp::asm_animcustom(scripts\sp\maps\townhoused\townhoused_code.gsc::stairtrain3_animcustom);
    }

    wait 2.1;
    level scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain3_rally_90");
  }
}

fourth_floor_movement() {
  var_0 = scripts\engine\utility::getStruct("baby_mom_door_animnode", "targetname");
  level.price thread post_stairtrain_anim(var_0, "baby_mom_arrive");
  thread fourth_floor_price_anim();
  thread fourth_floor_price_movement();
  var_1 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  var_2 = scripts\sp\door::get_interactive_door("4thfloor_bathroom_door");
  var_2 scripts\engine\sp\utility::assign_animtree("door");
  var_0 = scripts\engine\utility::getStruct("4thfloor_bathroom_animnode", "targetname");
  var_1 post_stairtrain_anim(var_0, "baby_mom_arrive", var_2);
  scripts\engine\utility::flag_set("fourth_floor_bravo4_4_ready");
}

fourth_floor_price_anim() {
  level.price waittillmatch("single anim", "end");
  var_0 = scripts\engine\utility::getStruct("baby_mom_door_animnode", "targetname");
  var_0 notify("stop_loop_" + level.price.animname);

  if(!scripts\engine\utility::flag("baby_mom_go") && scripts\sp\maps\townhoused\townhoused_code.gsc::isscriptedalive(level.baby_mom))
    level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_4th_floor_bedroom_20");

  var_0 scripts\common\anim::anim_single_solo(level.price, "baby_mom_breakdown");
  var_1 = "baby_mom_breakdown_idle";
  var_2 = "baby_mom_breakdown_nag";
  var_3 = [];
  var_3[var_3.size] = "dx_vom_pri_4th_floor_bedroom_40";
  var_3[var_3.size] = "dx_vom_pri_4th_floor_bedroom_50";
  var_3[var_3.size] = "dx_vom_pri_4th_floor_bedroom_60";
  var_4 = 0;
  var_5 = 5000;
  var_6 = 9000;
  var_7 = gettime() + 1000;

  while(!scripts\engine\utility::flag("baby_mom_go")) {
    if(gettime() > var_7) {
      if(istrue(level.demo) && var_4 == 1) {
        var_7 = gettime() + 10000;
        continue;
      }

      scripts\engine\utility::delaythread(0.5, scripts\sp\maps\townhoused\townhoused_code.gsc::nag_say, var_3[var_4], 1, 0);
      var_4++;

      if(var_4 > var_3.size - 1) {
        var_4 = 0;
        var_3 = scripts\engine\utility::array_randomize(var_3);
      }

      var_0 scripts\common\anim::anim_single_solo(level.price, var_2);
      var_7 = gettime() + randomintrange(var_5, var_6);
      continue;
    }

    var_0 scripts\common\anim::anim_single_solo(level.price, var_1);
  }

  var_0 thread scripts\common\anim::anim_loop_solo(level.price, "baby_mom_breakdown_idle_as_loop", "stop_price_loop");
  scripts\engine\utility::flag_wait("bed_guy_go");
  var_0 notify("stop_price_loop");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
}

fourth_floor_door() {
  var_0 = scripts\sp\door::get_interactive_door("baby_room_door");
  var_0.fndamage = ::baby_door_ondamage;
  var_1 = angleclamp180(var_0.angles[1]);

  for(;;) {
    if(var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::door_angle_check(var_1, 20)) {
      break;
    }

    if(scripts\sp\maps\townhoused\townhoused_code.gsc::isscriptedalive(level.baby_mom)) {
      var_2 = level.baby_mom gettagorigin("tag_eye");

      if(sighttracepassed(level.player getEye(), var_2, 0, level.player)) {
        break;
      }
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("baby_mom_go");
  level.player clearallsoundsubmixes();
}

baby_door_ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_0 == 0) {
    return;
  }
  scripts\engine\utility::flag_set("baby_mom_go");
  self.fndamage = undefined;
}

fourth_floor_clear_nag() {
  var_0 = scripts\sp\door::get_interactive_door("baby_room_exit");

  if(var_0.ajar || var_0.bashed) {
    return;
  }
  var_0 endon("ajar");
  var_0 endon("bashed");

  if(scripts\sp\maps\townhoused\townhoused_code.gsc::isscriptedalive(level.baby_mom))
    scripts\engine\utility::waittill_any_ents(level.baby_mom, "death", level, "finished_baby_mom_vo");
  else
    wait 5;

  var_1 = ["dx_vom_pri_3rd_floor_bedroom_110", "dx_vom_pri_3rd_floor_bedroom_120", "dx_vom_pri_3rd_floor_bedroom_130"];
  level.price scripts\sp\maps\townhoused\townhoused_code.gsc::radio_nag(var_1, undefined, 12, 15);
}

baby_cry() {
  scripts\engine\utility::flag_wait("start_baby_cry");
  level.player setsoundsubmix("sp_th_baby_cry");
  var_0 = getEnt("baby", "targetname");
  var_0 playLoopSound("scn_townhouse_baby_cry_lp");
  var_0 endon("damage");
  var_1 = var_0.origin[2];
  var_2 = 84;
  var_3 = 0.05;
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    wait(var_3);
    var_6 = level.player.origin[2] - var_1;
    var_6 = scripts\engine\math::round_float(var_6, 4);

    if(var_6 < 0) {
      continue;
    }
    if(var_4 == var_6) {
      continue;
    }
    var_4 = var_6;
    var_7 = var_6 / var_2;
    var_7 = min(var_7, 1);

    if(var_5 == var_7) {
      continue;
    }
    var_5 = var_7;
    var_8 = scripts\engine\math::factor_value(1, 0.01, var_7);
    var_0 scalevolume(var_8, var_3);
  }
}

baby_cry_hard() {
  self endon("death");
  wait 1;
  level.babycry_hard_start = gettime();
  self playLoopSound("scn_townhouse_baby_cry_hard_lp");
}

baby_death() {
  self setCanDamage(1);
  self.health = 100;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isPlayer(var_1)) {
      if(var_9.basename == "flash" && distancesquared(var_3, self.origin) > 300) {
        continue;
      }
      break;
    }
  }

  if(isalive(self.mom))
    self.mom setCanDamage(0);

  self.health = 1;
  self stoploopsound();
  var_10 = getdvarint("townhoused_baby_deaths", 0);
  var_10++;
  setDvar("townhoused_baby_deaths", var_10);
  var_11 = 0;

  if(isalive(self.mom)) {
    var_11 = 1;
    self notify("damage", 100, level.player);
  }

  if(var_10 > 2) {
    scripts\sp\player_death::set_custom_death_quote(21);
    scripts\sp\analytics::analytics_obj_failed();
    level.missionfailed = 1;
    scripts\engine\utility::flag_set("missionfailed");
    thread scripts\sp\player_death::set_death_hint();
    level.player shellshock("default", 10);
    setblur(5, 1);
    setslowmotion(1, 0.5, 1);
    changelevel("", 0, 2);
  } else
    scripts\sp\player_death::set_custom_death_quote(7);

  scripts\sp\hud_util::fade_out(0);
  scripts\sp\utility::missionfailedwrapper();
}

postspawn_baby_mom() {
  self endon("death");
  self.allowdeath = 1;
  self.skipdeathanim = 1;
  self.team = "neutral";
  scripts\common\ai::gun_remove();
  self.nofacialfiller = 1;
  self.scriptedisalive = 1;
  scripts\engine\utility::ent_flag_init("can_fastforward");
  self.og_headmodel = self.headmodel;
  self detach(self.headmodel);
  self attach(scripts\engine\sp\utility::getmodel(self.animname + "_head"));
  level thread baby_mobile_stay_active();
  thread baby_mom_death_cleanup();
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::do_sound_on_death("dx_vom_aqf3_4th_floor_bedroom_98");
  level.baby_mom = self;
  var_0 = getEnt("baby", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("baby");
  self.baby = var_0;
  var_0.mom = self;
  var_0 thread baby_death();
  thread baby_mom_ondamage();
  var_1 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");
  var_1 scripts\common\anim::anim_first_frame([self, self.baby], "grab_baby");
  scripts\engine\utility::flag_wait("baby_mom_go");
  thread baby_mom_add_collision_head();
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::train_go("south");
  baby_mom_anim();
}

baby_mom_clear_damageshield() {
  self.damageshield = 0;
}

baby_mom_ondamage() {
  self endon("stop_ondamage");
  self.damageshield = 1;

  while(self.damageshield) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "flash") {
      if(self.health > 0)
        self.health = self.health + var_0;

      continue;
    }

    if(isDefined(var_4) && var_4 == "MOD_MELEE") {
      continue;
    }
    if(var_1 != level.player) {
      continue;
    }
    if(scripts\engine\utility::flag("baby_picked_up")) {
      baby_mom_playdeath();
      return;
    } else {
      self.damageshield = 0;
      self dodamage(var_0, var_1 getEye(), var_1, undefined, var_4, var_9);
    }
  }
}

baby_mom_playdeath() {
  self.scriptedisalive = 0;
  self notify("scripted_death");
  var_0 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");

  if(scripts\engine\utility::ent_flag("can_fastforward")) {
    var_1 = scripts\engine\utility::getanim("grab_baby");
    var_2 = self.baby scripts\engine\utility::getanim("grab_baby");
    var_3 = self getanimtime(var_1);
    var_4 = getnotetracktimes(var_1, "can_die");
    var_5 = var_4[0];

    if(var_3 < var_5) {
      self setanimrate(var_1, 2.5);
      self.baby setanimrate(var_2, 2.5);
      self waittillmatch("single anim", "can_die");
    }
  }

  self.baby scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 thread scripts\common\anim::anim_single_solo(self.baby, self.deathanime);
  self.skipdeathanim = 1;
  var_0 scripts\common\anim::anim_single_solo(self, self.deathanime);
  self.diequietly = 1;
  var_6 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");

  if(self.deathanime == "grab_baby_stand_death") {
    if(isDefined(var_6.momdeathreact_anime)) {
      if(var_6.momdeathreact_anime == "grab_baby_death_interrupt") {
        self.baby thread baby_idle_relative("grab_baby_stand_death_idle");
        self.diequietly = 1;
        scripts\sp\maps\townhoused\townhoused_anim.gsc::kill_me_no_anim(self);
        return;
      }
    }

    var_7 = "grab_baby_pickup_early";
    self.baby thread scripts\sp\maps\townhoused\townhoused_anim.gsc::baby_pickup_by_allyanim(var_0, var_7);
    var_0 thread scripts\common\anim::anim_single_solo(self, var_7);
    var_6 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
    var_3 = var_6 getanimtime(var_6 scripts\engine\utility::getanim(var_7));

    if(var_3 > 0) {
      waitframe();
      self setanimtime(scripts\engine\utility::getanim(var_7), var_3);
      var_8 = getanimlength(var_6 scripts\engine\utility::getanim(var_7)) * var_3;
      var_9 = var_8 / getanimlength(self.baby scripts\engine\utility::getanim(var_7));
      self.baby setanimtime(self.baby scripts\engine\utility::getanim(var_7), var_9);
    }
  }
}

baby_mom_add_collision_head() {
  self.linkedents = [];
  self.linkedents["head"] = scripts\sp\maps\townhoused\townhoused_code.gsc::quick_spawn_model("collision_head");
  self.linkedents["head"] linkTo(self, "j_head", (0, 0, 0), (0, 0, 0));
}

baby_mom_prior_dialog() {
  level endon("baby_mom_go");
  var_0 = scripts\engine\utility::getStruct("fake_bed_guy_vo", "targetname");
  var_1 = scripts\engine\utility::spawn_script_origin(var_0.origin);
  var_1.animname = "tempEnt_guy";
  var_0 = scripts\engine\utility::getStruct("fake_baby_mom_vo", "targetname");
  var_2 = scripts\engine\utility::spawn_script_origin(var_0.origin);
  var_2.animname = "tempEnt_girl";
  scripts\engine\utility::flag_wait("half_up_3f_stairs");
  var_2 thread stopsounds_on_notify("baby_mom_go");
  baby_mom_prior_dialog_internal(var_1, var_2);
  scripts\engine\utility::flag_wait("stairtrain3_done");
  wait 1;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_4th_floor_aq_convo5_50");
  var_2 playSound("dx_vom_aqf3_4th_floor_aq_convo5_60");
}

stopsounds_on_notify(var_0) {
  scripts\engine\utility::waittill_any_ents(self, var_0, level, var_0);
  self stopsounds();
}

baby_mom_prior_dialog_internal(var_0, var_1) {
  if(scripts\engine\utility::flag("stairtrain3_done")) {
    return;
  }
  level endon("stairtrain3_done");
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf3_4th_floor_aq_convo5_10");
  wait 0.5;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_4th_floor_aq_convo5_20");
  wait 0.2;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf3_4th_floor_aq_convo5_30");
  wait 0.6;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_4th_floor_aq_convo5_40");
}

baby_mom_death_cleanup() {
  scripts\engine\utility::waittill_either("death", "scripted_death");

  if(!scripts\engine\utility::flag("baby_picked_up"))
    self.baby thread baby_idle_relative();

  if(isDefined(self.linkedents)) {
    self.linkedents = scripts\engine\utility::array_removeundefined(self.linkedents);

    foreach(var_1 in self.linkedents)
    var_1 delete();
  }
}

baby_idle_relative(var_0) {
  self endon("death");
  self clearanim(scripts\engine\utility::getanim("root"), 0.2);
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(!isDefined(var_0))
    var_0 = "baby_idle";

  var_1 = scripts\engine\utility::getanim(var_0);
  var_2 = getanimlength(var_1);

  if(isDefined(level.babycry_hard_start)) {
    var_3 = 0;
    var_4 = (gettime() - level.babycry_hard_start) * 0.001;
    var_4 = var_4 % var_2;
    var_5 = var_4 / var_2;
    self setflaggedanim("baby_idle_anim", var_1, 0.1);
    self setanimtime(var_1, var_5);
  }

  thread baby_blend_idle(var_1);
}

baby_blend_idle(var_0) {
  var_1 = 40;
  var_2 = 0.05;
  var_3 = 0;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    waitframe();
    var_3 = var_4 * var_2;
    self setanim(var_0, var_3);
  }

  self setanim(var_0, 1);
}

print_notetrack() {
  for(;;)
    self waittill("baby_idle_anim", var_0);
}

baby_mobile_stay_active() {
  var_0 = getEnt("baby", "targetname");
  var_1 = var_0.origin + (0, 0, 30);

  for(;;) {
    wait 2;
    radiusdamage(var_1, 25, 1, 0, undefined, "MOD_RIFLE_BULLET", undefined, 1);
  }
}

baby_mom_anim() {
  self endon("death");
  self endon("scripted_death");
  var_0 = scripts\sp\maps\townhoused\townhoused_anim.gsc::baby_mom_anim_random();
  var_1 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");
  var_2 = undefined;

  if(var_0 == "grab_baby") {
    var_2 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
    var_2 scripts\engine\utility::ent_flag_waitopen("stairtrain_on");

    if(!scripts\engine\utility::flag("fourth_floor_bravo4_4_ready")) {
      waitframe();
      var_3 = scripts\sp\door::get_interactive_door("4thfloor_bathroom_door");
      var_4 = 5;
      var_3 setanimrate(var_3 scripts\engine\utility::getanim("baby_mom_arrive"), var_4);
      var_2 setanimrate(var_2 scripts\engine\utility::getanim("baby_mom_arrive"), var_4);
    }

    scripts\engine\utility::flag_wait("fourth_floor_bravo4_4_ready");
    var_5 = scripts\engine\utility::getStruct("4thfloor_bathroom_animnode", "targetname");
    var_5 notify("stop_loop_" + var_2.animname);
    var_2.linkedents["head"] = scripts\sp\maps\townhoused\townhoused_code.gsc::quick_spawn_model("collision_head");
    var_2.linkedents["head"] linkTo(var_2, "j_head", (0, 0, 0), (0, 0, 0));
    var_2 scripts\engine\sp\utility::anim_stopanimScripted();
    var_2.uprightcqbidle = 1;
    var_2 thread baby_mom_death_react(self);
    var_2 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
    var_6 = [var_2, self];
    level thread baby_mom_dialog(self, var_2);
  } else
    var_6 = [self];

  var_7 = scripts\sp\maps\townhoused\townhoused_anim.gsc::baby_mom_anim_get(var_0);
  scripts\engine\utility::flag_set("baby_mom_playerclip");
  var_8 = var_6;
  var_8 = scripts\engine\utility::array_add(var_6, self.baby);
  self.baby.state = "intro";
  var_1 thread scripts\common\anim::anim_single(var_8, var_7.startanime);
  var_9 = var_7.idleanime;
  var_10 = undefined;

  if(isDefined(var_7.fnanimbranch)) {
    self.team = "axis";

    if(![[var_7.fnanimbranch]]())
      var_10 = var_7.startanime_a;
    else {
      var_10 = var_7.startanime_b;
      var_9 = var_7.idleanime_b;
    }
  }

  var_1 waittill(var_7.startanime);
  scripts\engine\utility::ent_flag_clear("can_fastforward");

  if(isDefined(var_10))
    var_1 scripts\common\anim::anim_single(var_8, var_10);

  thread baby_mom_idle_react(var_1, var_7);
  self.baby.state = "idle";
  var_8 = [self, self.baby];
  var_1 thread scripts\common\anim::anim_loop(var_8, var_7.idleanime, "stop_baby_mom_idle");
  var_1 thread scripts\common\anim::anim_loop_solo(var_2, var_7.idleanime, "stop_loop_bravo4_4");
}

highlight_all_ents(var_0) {
  for(;;) {
    if(isDefined(var_0))
      var_1 = var_0;
    else
      var_1 = getEntArray();

    foreach(var_3 in var_1) {
      if(!isDefined(var_3) || !isDefined(var_3.targetname))
        continue;
    }

    waitframe();
  }
}

stop_sounds_on_death() {
  scripts\engine\utility::waittill_either("death", "scripted_death");
  waitframe();
  self stopsounds();
}

baby_mom_dialog(var_0, var_1) {
  level.player endon("death");
  var_0 endon("death");
  var_0 endon("scripted_death");
  var_0 thread stop_sounds_on_death();
  wait 0.6;
  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_4th_floor_bedroom_73");
  wait 4.6;
  var_1 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_a12_4th_floor_bedroom_72");
  wait 0.4;
  var_2 = getEnt("baby", "targetname");
  var_3 = distance2dsquared(level.player.origin, var_2.origin) < 30000;
  var_4 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, cos(15));

  if(var_3 && var_4)
    level.player thread scripts\engine\sp\utility::player_gesture_combat("ges_baby_handsup", var_2);

  wait 1.4;
  var_5 = scripts\sp\door::get_interactive_door("baby_room_exit");

  if(var_5.ajar || var_5.bashed) {
    level notify("finished_baby_mom_vo");
    return;
  }

  var_5 endon("ajar");
  var_5 endon("bashed");
  thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_4th_floor_bedroom_80");
  wait 0.8;
  var_6 = gettime();

  while(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, cos(15)) && !scripts\engine\utility::time_has_passed(var_6, 2))
    waitframe();

  wait 0.5;
  thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_4th_floor_bedroom_90");
  level notify("finished_baby_mom_vo");
}

baby_mom_idle_react(var_0, var_1) {
  self endon("death");
  self endon("scripted_death");
  var_2 = [];
  var_2[var_2.size] = "dx_vom_aqf3_4th_floor_bedroom_94";
  var_2[var_2.size] = "dx_vom_aqf3_4th_floor_bedroom_95";
  var_2[var_2.size] = "dx_vom_aqf3_4th_floor_bedroom_96";
  var_2 = scripts\engine\sp\utility::create_deck(var_2);
  scripts\engine\utility::array_delete(self.linkedents);
  var_3 = [self, self.baby];
  wait 0.1;
  var_4 = 0;
  var_5 = squared(200);

  for(;;) {
    waitframe();

    if(gettime() < var_4) {
      continue;
    }
    if(distancesquared(level.player.origin, self.origin) > var_5) {
      continue;
    }
    if(!level.player scripts\engine\sp\utility::isads()) {
      continue;
    }
    var_6 = level.player getEye();
    var_7 = anglesToForward(level.player getplayerangles());
    var_8 = var_6 + var_7 * 250;
    var_9 = scripts\engine\trace::ray_trace(var_6, var_8);

    if(isDefined(var_9["entity"]) && var_9["entity"] == self) {
      thread scripts\engine\sp\utility::smart_dialogue(var_2 scripts\engine\sp\utility::deck_draw());
      var_0 notify("stop_baby_mom_idle");
      var_0 scripts\common\anim::anim_single(var_3, var_1.idlereactanime);
      var_4 = gettime() + 5000;
      var_0 thread scripts\common\anim::anim_loop(var_3, var_1.idleanime, "stop_baby_mom_idle");
    }
  }
}

baby_mom_death_react(var_0) {
  self.mom = var_0;
  var_0 scripts\engine\utility::waittill_either("death", "scripted_death");
  var_0.baby setlookattext("", &"");
  var_0.baby thread baby_cry_hard();
  level thread baby_mom_death_dialogue();

  if(!isDefined(self.momdeathreact_anime)) {
    return;
  }
  var_1 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");
  var_1 notify("stop_baby_mom_idle");
  var_1 notify("stop_loop_bravo4_4");
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(self.momdeathreact_anime == "grab_baby_death_interrupt") {
    var_2 = spawnStruct();
    var_2.origin = self.origin;
    var_2.angles = self.angles + (0, 30, 0);
    var_2 scripts\common\anim::anim_single_solo(self, self.momdeathreact_anime);
    scripts\common\anim::anim_loop_solo(self, "grab_baby_stand_death_idle");
  } else if(self.momdeathreact_anime == "grab_baby_stand_death") {
    var_1 scripts\common\anim::anim_single_solo(self, self.momdeathreact_anime);
    scripts\common\anim::anim_loop_solo(self, "grab_baby_stand_death_idle");
  } else
    var_1 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(self, self.momdeathreact_anime);

  self setgoalpos(self.origin);
}

baby_mom_death_dialogue() {
  wait 0.6;
  level scripts\engine\sp\utility::smart_radio_dialogue_interrupt("dx_vom_a12_4th_floor_bedroom_91");
  wait 0.2;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_4th_floor_bedroom_92");
}

postspawn_bed_guy() {
  self endon("death");
  var_0 = scripts\sp\utility::make_weapon("iw8_sm_mpapa7");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  level thread bed_guy_sight_thread(self);
  self.nofacialfiller = 1;
  self.allowdeath = 1;
  self.animname = "bed_guy";
  var_1 = scripts\engine\utility::getStruct("bed_guy_animnode", "targetname");
  var_1 thread scripts\common\anim::anim_loop_solo(self, "corner_idle");
  scripts\engine\utility::flag_wait("bed_guy_go");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_4th_floor_bedroom_97");
  var_1 notify("stop_loop");
  var_2 = "hide_under_bed";
  var_1 scripts\common\anim::anim_single_solo(self, var_2);
  self.useeyetoshoot = 1;
  var_3["left"] = 25;
  var_3["right"] = -60;
  var_3["up"] = -12;
  var_3["down"] = 24;
  level thread bed_guy_target(self);

  if(istrue(level.demo))
    thread demo_trigger_damage();

  thread bed_guy_flash();
  scripts\sp\maps\townhoused\townhoused_code.gsc::anim_aim("under_bed_aim", undefined, var_3);
  self.allowdeath = 1;
  self.deathanimmode = "noclip";
  self.deathanim = scripts\engine\utility::getanim("hide_under_bed_death");
  self.ignoreme = 0;
  level.price.favoriteenemy = self;
}

bed_guy_flash() {
  self endon("death");
  var_0 = scripts\engine\utility::getanim("under_bed_flash_knob");
  var_1 = scripts\engine\utility::getanim("under_bed_flash");

  for(;;) {
    self waittill("flashbang");
    self.scriptedflashed = 1;
    self aisetanimlimited(var_0, 1, 0.2);
    self setflaggedanimknoblimitedrestart("flash_anim", var_1, 1, 0.2);
    self waittillmatch("flash_anim", "end");
    self.scriptedflashed = 0;
    self aisetanimlimited(var_0, 0, 0.2);
  }
}

demo_trigger_damage() {
  self endon("death");
  var_0 = getEnt("bedguy_damage_trigger", "targetname");

  for(var_1 = 0; var_1 < 2; var_1++)
    var_0 waittill("damage");

  self kill();
}

testing_weapon_collision(var_0) {
  setDvar("scr_drop_bedguy_weapon", 0);

  for(;;) {
    if(getdvarint("scr_drop_bedguy_weapon") > 0) {
      setDvar("scr_drop_bedguy_weapon", 0);
      var_1 = level.player getplayerangles();
      var_2 = anglesToForward(var_1);
      var_3 = level.player getEye() + var_2 * 30;
      var_4 = spawn("weapon_" + createheadicon(var_0), var_3);
      var_4.angles = var_1;
    }

    waitframe();
  }
}

bed_guy_target(var_0) {
  var_0 endon("death");

  if(istrue(level.demo)) {
    var_0.dontevershoot = 1;
    var_0 scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::disable_dontevershoot);
  }

  var_1 = 32;
  var_2 = 10;
  var_3 = spawn("script_origin", level.player.origin);
  var_3 makeentitysentient("allies");
  var_0.favoriteenemy = var_3;
  var_3.health = 100;

  while(isalive(var_0)) {
    var_4 = vectorNormalize(scripts\engine\utility::flat_origin(var_0 getEye()) - scripts\engine\utility::flat_origin(level.player.origin));
    var_3.origin = level.player.origin + var_4 * var_1 + (0, 0, var_2);
    waitframe();
  }

  var_3 delete();
}

fourth_floor_price_movement() {
  scripts\engine\utility::flag_wait("bed_guy_go");
  var_0 = scripts\engine\utility::getStruct("baby_mom_door_animnode", "targetname");
  var_0 notify("stop_loop_" + level.price.animname);
  level.price thread fourth_floor_price_open_door();
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 = getnode("price_4th_floor", "targetname");
  level.price scripts\sp\maps\townhoused\townhoused_code.gsc::scripted_movement(var_1, 1);
  level.price notify("stop_fourth_floor_price_open_door");
  var_2 = scripts\engine\sp\utility::get_living_ai("bed_guy", "animname");

  if(isalive(var_2)) {
    level.price.ignoreall = 0;
    level.price.dontevershoot = 0;
    var_3 = var_2 gettagorigin("tag_eye");
    var_4 = vectorNormalize(level.price getEye() - var_3);
    var_3 = var_3 + var_4 * 30 + (0, 0, -5);
    var_5 = spawn("script_origin", var_3);
    var_5 makeentitysentient("axis");
    level.price.favoriteenemy = var_5;
    var_2 waittill("death");
    wait 0.2;
    var_5 delete();
    level.price.dontevershoot = 1;
  }
}

fourth_floor_price_open_door() {
  level.price endon("stop_fourth_floor_price_open_door");
  var_0 = scripts\sp\door::get_interactive_door("baby_room_exit");
  var_0 scripts\sp\door::add_pushent(self);

  for(;;) {
    if(isDefined(self._blackboard.doortoopen) && self._blackboard.doortoopen.targetname == "baby_room_exit") {
      var_0 = self._blackboard.doortoopen;
      self._blackboard.doortoopen = undefined;
      scripts\sp\maps\townhoused\townhoused_code.gsc::ai_try_open_door(var_0);
      return;
    }

    waitframe();
  }
}

bed_guy_sight_thread(var_0) {
  var_0 endon("death");

  for(;;) {
    waitframe();
    var_1 = var_0 gettagorigin("tag_eye");
    var_2 = level.player getEye();

    if(scripts\engine\utility::within_fov(var_2, level.player getplayerangles(), var_1, 0.939693) && sighttracepassed(level.player getEye(), var_1, 0, level.player)) {
      break;
    }
  }

  scripts\engine\utility::flag_set("bed_guy_go");
}

attic_room() {
  thread attic_door_triggered();
  thread setup_ending();
  attic_price_stairtrain();
  scripts\engine\sp\utility::autosave_by_name("attic");
  var_0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  scripts\engine\sp\utility::spawn_script_noteworthy("attic_enemy", 1);
  level.attic_enemy thread attic_enemy_death_vo();
  thread attic_open_door();
  var_0 notify("stop_attic_arrival_loop");
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(level.price, "attic_door_open", undefined, "stop_attic_door_open_loop");
  level.attic_enemy scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf4_attic_standoff_02");
  var_1 = ["dx_vom_pri_attic_breach_20", "dx_vom_pri_attic_breach_30", "dx_vom_pri_attic_breach_40"];
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::nag(var_1, "saw_attic_enemy", 12, 15);
  level.attic_enemy.anim_smartdialog_func = ::attic_enemy_smartdialog;
  level.attic_enemy thread scripts\sp\maps\townhoused\townhoused_code.gsc::flash_react_thread(["woman_flashbang_friendly_3", "woman_flashbang_friendly_4"]);
  level thread attic_trigger_damage_thread();
  var_0 thread scripts\common\anim::anim_loop_solo(level.attic_enemy, "start_idle", "stop_attic_loop");
  level.attic_enemy.allowdeath = 1;
  attic_player_sees_enemy();
  level notify("saw_attic_enemy");
  setmusicstate("mx_townhouse_suicide_os");
  var_0 notify("stop_attic_door_open_loop");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();

  if(istrue(level.price.halliganinhand))
    scripts\sp\maps\townhoused\townhoused_anim.gsc::stow_halligan(level.price);

  level.price scripts\anim\shared.gsc::placeweaponon(level.price.weapon, "right");
  level.price scripts\engine\utility::ent_flag_init("attic_enter_anim_done");
  var_0 thread attic_enemy_anim();
  var_0 thread attic_price_anim();
  level waittill("start_enemy_death");
  level.price scripts\engine\utility::ent_flag_wait("attic_enter_anim_done");

  if(!istrue(level.finished_attic_clear_vo))
    level waittill("finished_attic_clear_vo");

  var_0 notify("stop_attic_entry_loop");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(level.price, "attic_enemy_death", undefined, "stop_attic_price");
  thread attic_death_dialogue();

  if(!level.player scripts\engine\utility::ent_flag("no_gold_achievement"))
    scripts\sp\utility::giveachievement_wrapper("goldenpath");

  var_2 = &"TOWNHOUSED/HINT_PICKUP";
  var_3 = 45;
  var_4 = 100;
  var_5 = 60;
  var_6 = 1;
  level.clacker scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var_2, var_3, var_4, var_5, var_6);
  level.clacker thread clacker_unusable_thread();
  level.clacker waittill("trigger");
  level.player lerpfovscalefactor(0, 1);
  scripts\engine\utility::flag_set("player_picked_up_clacker");
  level.price scripts\engine\sp\utility::name_hide();
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::price_ending_cinematic();
  level.player disableweapons();
  level.player allowmelee(0);
  level.player allowfire(0);
  level.player allowads(0);
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(level.player isnightvisionon())
    level.player scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::allow_nvg, 0);
  else
    level.player scripts\engine\sp\utility::allow_nvg(0);

  level.clacker linkTo(level.player_rig, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  level.player_rig.customnotetrackhandler = ::attic_fov_notetrack;
  var_0 thread scripts\common\anim::anim_single_solo(level.player_rig, "ending");
  thread ending_bink_init();
  var_7 = "tag_accessory_right";
  level.price.laptop = scripts\engine\sp\utility::spawn_anim_model("laptop", level.price gettagorigin(var_7), level.price gettagangles(var_7));
  level.price.laptop linkTo(level.price, var_7, (0, 0, 0), (0, 0, 0));
  level thread attic_bink_start();
  var_0 notify("stop_attic_price");
  var_0 thread scripts\common\anim::anim_single_solo(level.price, "ending");
  var_8 = distance2d(level.player.origin, level.clacker.origin);
  var_9 = var_5 / 1;
  var_10 = var_8 / var_9;
  level.player playerlinktoblend(level.player_rig, "tag_player", var_10, 0.2, 0.2);
  thread lerp_attic_player_viewangle(var_10);
  wait(var_10);
  level.player_rig show();
  level.price waittillmatch("single anim", "end");
  var_0 thread scripts\common\anim::anim_last_frame_solo(level.price, "ending");
}

attic_trigger_damage_thread() {
  var_0 = getEnt("attic_damage_trigger", "targetname");
  var_0 thread trigger_damage_ondamage();

  for(;;) {
    var_0 waittill("trigger");

    if(isDefined(var_0.triggertype)) {
      if(var_0.triggertype == "frag") {
        if(isalive(level.attic_enemy))
          level.attic_enemy kill(var_0.damagepos, var_0.damageattacker, var_0.damageattacker, var_0.damagemod);
      }

      self.damagepos = undefined;
      self.damagemod = undefined;
      self.damageattacker = undefined;
      self.triggertype = undefined;
    }
  }
}

trigger_damage_ondamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9.basename == "frag" && ispointinvolume(var_3, self)) {
      self.damagepos = var_3;
      self.damagemod = var_4;
      self.damageattacker = var_1;
      self.triggertype = "frag";
      self notify("trigger");
    }
  }
}

lerp_attic_player_viewangle(var_0) {
  wait(var_0 + 1);
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(2, 0, 0, 10, 20, 20, 10);
}

clacker_unusable_thread() {
  self endon("trigger");
  var_0 = 1;
  var_1 = self.origin;
  var_2 = self.origin[2] - 40;

  for(;;) {
    var_3 = 0;

    if(level.player isgestureplaying())
      var_3++;

    if(!isalive(level.player))
      var_3++;

    if(level.player.origin[2] < var_2)
      var_3++;

    if(var_3 == 0 && scripts\sp\maps\townhoused\townhoused_code.gsc::is_grenade_near_cursor_hint())
      var_3++;

    if(var_0 && var_3) {
      self.cursor_hint_ent makeunusable();
      var_0 = 0;
    } else if(!var_0 && !var_3) {
      self.cursor_hint_ent makeusable();
      var_0 = 1;
    }

    waitframe();
  }
}

attic_death_dialogue() {
  level endon("player_picked_up_clacker");

  if(scripts\engine\utility::flag("player_picked_up_clacker")) {
    return;
  }
  wait 2;
  wait 2.8;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a31_attic_secure_20");
  wait 0.2;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a21_attic_secure_30");
  wait 2.3;
  var_0 = ["dx_vom_pri_attic_secure_50", "dx_vom_pri_attic_secure_60", "dx_vom_pri_attic_secure_70"];
  level.price scripts\engine\utility::delaythread(5, scripts\sp\maps\townhoused\townhoused_code.gsc::nag, var_0, "player_picked_up_clacker", 12, 15);
}

attic_bink_start() {
  var_0 = level.price scripts\engine\utility::getanim("ending");
  var_1 = getanimlength(var_0);
  var_1 = var_1 - 4;
  wait(var_1);
  level.player setclienttriggeraudiozone("fade_to_black", 1.6);
  pausecinematicingame(0);
  wait 1.4;
  setsaveddvar("MMRNLMPPLT", "1");
  scripts\engine\utility::flag_set("end_scene_done");
}

ending_bink_init() {
  var_0 = scripts\sp\endmission::getlevelindex(level.script);
  scripts\sp\endmission::setfadetime(var_0, 0);
  var_1 = var_0 + 1;
  var_2 = scripts\sp\endmission::getlevelbink(var_1);
  level.endmission_bink_skip = 1;
  setsaveddvar("LNSNKKLPLL", "0");
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame(var_2, 1, 1, 1, 0, 0, 1);
}

attic_fov_notetrack(var_0, var_1, var_2) {}

setup_ending() {
  var_0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "ending");
  waitframe();
  var_1 = level.player_rig gettagorigin("tag_accessory_right");
  var_2 = level.player_rig gettagangles("tag_accessory_right");
  level.clacker = scripts\engine\sp\utility::spawn_anim_model("clacker", var_1, var_2);
}

attic_price_anim() {
  var_0 = scripts\sp\door::get_interactive_door("attic_door");
  level.price scripts\engine\utility::delaythread(1.2, scripts\sp\maps\townhoused\townhoused_code.gsc::force_open_door, var_0);
  scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(level.price, "attic_entry", undefined, "stop_attic_entry_loop");
  level.price scripts\engine\utility::ent_flag_set("attic_enter_anim_done");
}

attic_enemy_smartdialog(var_0) {
  if(istrue(self.scriptedflashed)) {
    return;
  }
  scripts\engine\sp\utility::smart_dialogue(var_0);
}

attic_enemy_anim() {
  if(isalive(level.attic_enemy)) {
    thread attic_enemy_early_death();
    scripts\common\anim::anim_single_solo(level.attic_enemy, "attic_entry");
  }

  if(!isalive(level.attic_enemy) && !level.price scripts\engine\utility::ent_flag("attic_enter_anim_done")) {
    var_0 = level.price scripts\engine\utility::getanim("attic_entry");

    if(level.price getanimtime(var_0) < 0.9)
      level.price setanimrate(var_0, 2);

    level.price waittillmatch("single anim", "end");
  }

  level notify("start_enemy_death");
  setmusicstate("");

  if(isalive(level.attic_enemy) && !isDefined(level.attic_enemy.early_death)) {
    level.attic_enemy.deathfunction = undefined;
    level.attic_enemy actoraimassistoff();
    scripts\common\anim::anim_single_solo(level.attic_enemy, "attic_enemy_death");
  }
}

attic_enemy_death_vo() {
  var_0 = spawnStruct();
  wait_attic_enemy_death(var_0);
  wait 0.8;
  scripts\sp\maps\townhoused\townhoused_code.gsc::wait_weapon_fire_cooldown(0.4, 2);

  if(scripts\engine\utility::is_equal(var_0.attacker, level.player))
    level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_attic_standoff_40");
  else
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_standoff_50");

  level.finished_attic_clear_vo = 1;
  level notify("finished_attic_clear_vo");
}

wait_attic_enemy_death(var_0) {
  level endon("start_enemy_death");

  while(self.health > 0) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_0.attacker) || var_0.attacker != level.player)
      var_0.attacker = var_2;
  }
}

attic_enemy_early_death() {
  var_0 = level.attic_enemy;
  var_0 endon("death");
  var_0 endon("stop_early_death");
  level endon("start_enemy_death");
  var_1 = scripts\engine\utility::getStruct("attic_animnode", "targetname");

  while(var_0.health > 1)
    var_0 waittill("damage");

  var_0 stopsounds();
  setmusicstate("");

  if(var_0.damagelocation == "head" || var_0.damagelocation == "helmet") {
    var_0 scripts\engine\sp\utility::set_deathanim("attic_enemy_headshot_death");
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 kill(var_0.origin, level.player, level.player, var_0.damagemod);
    return;
  }

  var_0 scripts\engine\utility::delaythread(0.05, scripts\engine\sp\utility::smart_dialogue, "dx_vom_aqf4_attic_standoff_42");
  var_0.early_death = 1;
  var_2 = "attic_enemy_early_long_death";
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::delay_allowdeath(0.4);
  var_0.skipdeathanim = 1;
  var_0 actoraimassistoff();
  var_0 scripts\common\anim::anim_single_solo(var_0, "attic_enemy_early_long_death");
}

attic_door_triggered() {
  var_0 = scripts\sp\door::get_interactive_door("attic_door");
  var_0 waittill("trigger");
  var_0 notify("stop_open_ability");
  scripts\engine\utility::flag_set("attic_door_used");
  wait 0.4;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_attic_breach_02");
  wait 0.3;

  if(istrue(level.price_at_attic_door)) {
    return;
  }
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_attic_breach_04");
}

attic_price_stairtrain() {
  var_0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  var_0 scripts\sp\anim::anim_reach_solo(level.price, "attic_stairtrain_arrival");
  var_0 scripts\common\anim::anim_single_solo(level.price, "attic_stairtrain_arrival");
  level.stairtrain_rearguy = level.price;
  level.price.animnode = var_0;
  level.price scripts\asm\asm_sp::asm_animcustom(scripts\sp\maps\townhoused\townhoused_code.gsc::stairtrain_attic_animcustom);
  waitframe();

  if(level.price scripts\engine\utility::ent_flag("stairtrain_on"))
    level.price scripts\engine\utility::ent_flag_waitopen("stairtrain_on");

  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(level.price, "attic_door_arrive", undefined, "stop_attic_arrival_loop");
  level.price_at_attic_door = 1;
  var_1 = ["dx_vom_pri_attic_breach_20", "dx_vom_pri_attic_breach_30", "dx_vom_pri_attic_breach_40"];
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::nag(var_1, "attic_door_used", 12, 15);
  scripts\engine\utility::flag_wait("attic_door_used");
}

attic_player_sees_enemy() {
  var_0 = ["tag_eye", "j_ankle_ri", "j_mainroot"];

  for(;;) {
    if(!isalive(level.attic_enemy)) {
      break;
    }

    var_1 = 0;

    foreach(var_3 in var_0) {
      var_4 = level.attic_enemy gettagorigin(var_3);

      if(sighttracepassed(level.player getEye(), var_4, 0, level.player))
        return;
    }

    waitframe();
  }
}

get_shelfs() {
  var_0 = getEntArray("attic_shelf", "targetname");

  foreach(var_2 in var_0) {
    var_2 notsolid();
    var_2 scripts\engine\sp\utility::assign_animtree(var_2.script_animname);
    var_2 add_linkedents();

    foreach(var_4 in var_2.linkedents)
    var_4 thread shelf_movement();
  }

  return var_0;
}

shelf_movement() {
  wait 0.5;
  var_0 = self.origin;
  var_1 = squared(2);

  for(;;) {
    var_2 = distancesquared(var_0, self.origin);

    if(var_2 > var_1) {
      var_3 = sqrt(var_2);
      var_4 = vectorNormalize(var_0 - self.origin) * var_3;
      self unlink();
      self physicslaunchclient(self.origin, var_4);
      break;
    }

    var_0 = self.origin;
    waitframe();
  }
}

add_linkedents() {
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(self.linkedents))
      self.linkedents = [];

    self.linkedents[self.linkedents.size] = var_2;
    var_2 linkTo(self);

    if(isDefined(var_2.target))
      var_2 add_linkedents();
  }
}

kill_everyone_ending() {
  wait 0.1;
  level.price scripts\common\ai::stop_magic_bullet_shield();
  level.price kill();
  wait 0.05;
  level.player kill();
  level waittill("never_ending");
}

attic_open_door() {
  var_0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  var_1 = scripts\sp\door::get_interactive_door("attic_door");
  thread prime_attic_door_states(var_1.origin + (0, 0, 200));
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_door(var_1, "attic_door_open", undefined, 1);
  var_1 scripts\sp\door_internal::set_pivot_point(1);
  var_1 thread scripts\sp\door_internal::monitor_door_push(0);
  var_1 scripts\sp\door_internal::waittill_second_interact_or_bash();
  var_1 scripts\sp\door::remove_open_ability();
  thread remove_prime_ents();
}

temp_attic_dialogue() {
  wait 0.3;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_interior_40");
  wait 1;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_interior_50");
  wait 4;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_interior_60");
  wait 4;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_interior_90");
}

prime_attic_door_states(var_0) {
  level.primedents = [];
  level.primedents[level.primedents.size] = scripts\sp\maps\townhoused\townhoused_code.gsc::quick_spawn_model("attic_door_damaged", var_0);
  level.primedents[level.primedents.size] = scripts\sp\maps\townhoused\townhoused_code.gsc::quick_spawn_model("attic_door_damaged2", var_0);
}

remove_prime_ents() {
  scripts\engine\utility::array_delete(level.primedents);
}

try_nvg_enable_hint() {
  if(!level.player scripts\sp\nvg\nvg_player::is_nvg_on())
    scripts\sp\nvg\nvg_player::nvg_on_hint(8);
}

hint_nvg_enable_check() {
  return level.player scripts\sp\nvg\nvg_player::is_nvg_on();
}

hint_nvg_disable_check() {
  return !level.player scripts\sp\nvg\nvg_player::is_nvg_on();
}

postspawn_attic_enemy() {
  var_0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "attic_entry");
  self.og_headmodel = self.headmodel;
  self detach(self.headmodel);
  self attach(scripts\engine\sp\utility::getmodel(self.animname + "_head"));
  self.team = "neutral";
  self.health = 80;
  scripts\sp\utility::context_melee_allow(0);
  scripts\common\ai::gun_remove();
  self.nofacialfiller = 1;
  level.attic_enemy = self;
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::golden_enemydamage();
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::golden_enemydeath();
}

nvg_death_hint() {
  scripts\engine\utility::flag_init("player_used_nvgs");
  level.player.nvg.on_func = ::player_nvgon;
  var_0 = "townhouse_nvgs_used";
  level.player waittill("death");

  if(isDefined(level.custom_death_quote)) {
    return;
  }
  if(getdvarint(var_0) > 0) {
    return;
  }
  if(scripts\engine\utility::flag("player_used_nvgs")) {
    setDvar(var_0, 1);
    scripts\sp\player_death::set_custom_death_quote(15);
  }
}

player_nvgon() {
  scripts\engine\utility::flag_set("player_used_nvgs");
}