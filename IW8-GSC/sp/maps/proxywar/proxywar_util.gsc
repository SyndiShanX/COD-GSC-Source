/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar_util.gsc
***********************************************/

waittill_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  while(!call_func_with_params(var_0, var_2, var_3, var_4, var_5)) {
    if(isDefined(var_1)) {
      wait(var_1);
      continue;
    }

    waitframe();
  }
}

waittill_func_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("timer_expired");
  level thread scripts\engine\sp\utility::notify_delay("timer_expired", var_0);
  waittill_func(var_1, var_2, var_3, var_4, var_5, var_6);
}

call_func_with_params(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4))
    return [[var_0]](var_1, var_2, var_3, var_4);
  else if(isDefined(var_3))
    return [[var_0]](var_1, var_2, var_3);
  else if(isDefined(var_2))
    return [[var_0]](var_1, var_2);
  else if(isDefined(var_1))
    return [[var_0]](var_1);
  else
    return [[var_0]]();
}

spawn_third_person_alex() {
  var_0 = getspawner("body_double", "script_animname");
  var_0.count = 1;
  var_1 = var_0 scripts\engine\sp\utility::spawn_ai(1);
  var_1 scripts\engine\sp\utility::name_hide();
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1 scripts\common\ai::magic_bullet_shield(1);
  var_1 scripts\common\ai::gun_remove();
  return var_1;
}

setup_ally_team(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    var_3 thread scripts\common\ai::magic_bullet_shield(1);
    var_3 setthreatbiasgroup("allies");
    var_3.animname = var_3.script_noteworthy;
    var_3.targetname = var_3.script_noteworthy;
    var_3.attackeraccuracy = 0;
    var_3.ignoreme = 1;
    var_3.dontevershoot = 1;
    var_3.disablepistol = 1;
    var_3.disableplayeradsloscheck = 1;
    var_3 scripts\anim\shared.gsc::forceuseweapon(var_1[0], "primary");
    var_3 thread setup_ally_flashlight();
  }
}

setup_ally_flashlight() {
  self endon("death");
  waitframe();
  self.flashlightfxoverridetag = "tag_light";
  self.flashlightfxoverride = "vfx_proxywar_npc_flashlight";
}

spawn_alpha_team(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  level.alpha1 = scripts\engine\sp\utility::spawn_script_noteworthy("alpha1", 1);
  level.alpha_team = [level.alpha1];
  level.alpha1 halligan_stow();

  if(var_0) {
    level.alpha2 = scripts\engine\sp\utility::spawn_script_noteworthy("alpha2", 1);
    level.alpha2 halligan_stow();
    level.alpha_team = [level.alpha1, level.alpha2];
  }

  var_1 = [scripts\sp\utility::make_weapon("iw8_ar_mike4", ["reflex_west01", "silencer04", "taclight"])];
  setup_ally_team(level.alpha_team, var_1);
}

spawn_bravo_team() {
  level.bravo1 = scripts\engine\sp\utility::spawn_script_noteworthy("bravo1", 1);
  level.bravo2 = scripts\engine\sp\utility::spawn_script_noteworthy("bravo2", 1);
  level.bravo3 = scripts\engine\sp\utility::spawn_script_noteworthy("bravo3", 1);
  level.bravo_team = [level.bravo1, level.bravo2, level.bravo3];
  var_0 = [scripts\sp\utility::make_weapon("iw8_ar_mike4", ["reflex_west01", "silencer04", "taclight"])];
  setup_ally_team(level.bravo_team, var_0);
}

spawn_recon_team() {
  level.recon1 = scripts\engine\sp\utility::spawn_script_noteworthy("recon1", 1);
  level.recon2 = scripts\engine\sp\utility::spawn_script_noteworthy("recon2", 1);
  level.recon3 = scripts\engine\sp\utility::spawn_script_noteworthy("recon3", 1);
  level.recon4 = scripts\engine\sp\utility::spawn_script_noteworthy("recon4", 1);
  level.recon_team = [level.recon1, level.recon2, level.recon3, level.recon4];
  var_0 = [scripts\sp\utility::make_weapon("iw8_ar_mike4", ["reflex_west01", "silencer04"]), scripts\sp\utility::make_weapon("iw8_sn_mike14", ["silencerdmr04", "snprscope_mike14"]), scripts\sp\utility::make_weapon("iw8_sn_alpha50"), scripts\sp\utility::make_weapon("iw8_lm_kilo121")];
  setup_ally_team(level.recon_team, var_0);
}

spawn_ally_teams(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  spawn_alpha_team(var_0);
  spawn_bravo_team();
  level.alpha_and_bravo_team = scripts\engine\utility::array_combine(level.alpha_team, level.bravo_team);
}

remove_ally(var_0) {
  if(scripts\engine\utility::array_contains(level.alpha_and_bravo_team, var_0))
    level.alpha_and_bravo_team = scripts\engine\utility::array_remove(level.alpha_and_bravo_team, var_0);

  if(scripts\engine\utility::array_contains(level.alpha_team, var_0))
    level.alpha_team = scripts\engine\utility::array_remove(level.alpha_team, var_0);

  if(scripts\engine\utility::array_contains(level.bravo_team, var_0))
    level.bravo_team = scripts\engine\utility::array_remove(level.bravo_team, var_0);
}

ally_track_and_kill(var_0, var_1) {
  if(isalive(var_0) || isai(var_0) && var_0 scripts\engine\utility::doinglongdeath()) {
    self.favoriteenemy = var_0;
    self.ignoreall = 0;
    self.dontmelee = 1;
    self.tracking_enemy = 1;
    scripts\engine\utility::waittill_any_ents(level, var_1, var_0, "death");
    wait(randomfloatrange(0.1, 0.4));
    self.dontevershoot = 0;
    shoot_and_kill(var_0);
    self.ignoreall = 1;
    self.dontevershoot = 1;
    self.dontmelee = undefined;
    self.favoriteenemy = undefined;
    self.tracking_enemy = 0;
  }
}

ally_track_and_kill_noteworthy(var_0, var_1) {
  var_2 = getEnt(var_0, "script_noteworthy");
  ally_track_and_kill(var_2, var_1);
}

ally_tracking_enemy() {
  return istrue(self.tracking_enemy);
}

shoot_and_kill(var_0) {
  if(isalive(var_0) || isai(var_0) && var_0 scripts\engine\utility::doinglongdeath()) {
    magicbullet(self.weapon, self gettagorigin("tag_flash"), var_0 getEye(), self);
    var_0 kill();
  }
}

within_distance(var_0, var_1, var_2) {
  return distancesquared(var_0, var_1) < squared(var_2);
}

within_distance2d(var_0, var_1, var_2) {
  return distance2dsquared(var_0, var_1) < squared(var_2);
}

notify_within_distance(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_4);

  while(!within_distance(var_0.origin, var_1.origin, var_2))
    waitframe();

  level notify(var_3);
}

within_player_fov(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = cos(getdvarfloat("MRNKTKLLKP"));

  return scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0, var_2);
}

within_player_fov_2d(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = cos(getdvarfloat("MRNKTKLLKP"));

  return scripts\engine\math::within_fov_2d(level.player getEye(), level.player getplayerangles(), var_0, var_2);
}

get_closest_in_front(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(scripts\engine\utility::within_fov(var_4.origin, var_4.angles, var_1, 0)) {
      var_4.test_dist = distance2d(var_1, var_4.origin);

      if(!isDefined(var_2) || var_2.test_dist > var_4.test_dist)
        var_2 = var_4;
    }
  }

  return var_2;
}

setup_scripted_door(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::getStructArray(var_0, "targetname"));
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_1) {
    switch (var_9.script_noteworthy) {
      case "clip":
        var_3 = var_9;
        break;
      case "open":
        var_4 = var_9;
        break;
      case "open_ccw":
        var_5 = var_9;
        break;
      case "closed":
        var_6 = var_9;
        break;
      case "door":
        var_2 = var_9;
        break;
      case "parent":
        var_7 = var_9;
        break;
    }
  }

  var_2.clip = var_3;
  var_2.clip linkTo(var_2);

  if(!isDefined(var_4)) {
    var_4 = spawnStruct();
    var_4.origin = var_2.origin;
    var_4.angles = var_2.angles;
  }

  var_2.open = var_4;

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
    var_5.origin = var_2.origin;
    var_5.angles = var_2.angles;
  }

  var_2.openccw = var_5;

  if(!isDefined(var_6)) {
    var_6 = spawnStruct();
    var_6.origin = var_2.origin;
    var_6.angles = var_2.angles;
  }

  var_2.closed = var_6;

  if(isDefined(var_7))
    var_7 linkTo(var_2);

  return var_2;
}

open_scripted_door(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self.open;

  if(isDefined(var_4) && var_4)
    var_5 = self.openccw;

  internal_move_scripted_door(var_5.origin, var_5.angles, var_0, var_1, var_2, var_3);
}

close_scripted_door(var_0, var_1, var_2, var_3) {
  internal_move_scripted_door(self.closed.origin, self.closed.angles, var_0, var_1, var_2, var_3);
}

internal_move_scripted_door(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.clip connectpaths();
  self moveTo(var_0, var_2, var_3, var_4);
  self rotateTo(var_1, var_2, var_3, var_4);
  wait(var_2);

  if(istrue(var_5))
    self.clip disconnectPaths();
}

move_to_point_with_angles(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3))
    wait(var_3);

  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  self moveTo(var_1, var_0, var_4, var_5);

  if(isDefined(var_2))
    self rotateTo(var_2, var_0, var_4, var_5);

  wait(var_0);
}

stub_move(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var_4);

  if(isai(self)) {
    self.prev_anim_name = self.animname;
    self.animname = "stub_char";
    var_4 thread scripts\common\anim::anim_loop_solo(self, "stub_idle", "stop_stub_anim_loop");
  }

  var_4 move_to_point_with_angles(var_0, var_1, var_2, var_3);
  self unlink();

  if(isai(self)) {
    var_4 notify("stop_stub_anim_loop");
    self stopanimScripted();
    self.animname = self.prev_anim_name;
  }

  var_4 delete();
}

stub_move_to_struct(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = "targetname";

  var_4 = scripts\engine\utility::getStruct(var_1, var_2);
  stub_move(var_0, var_4.origin, var_4.angles, var_3);
}

stub_path_simple(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var_3);
  var_4 = 1;
  var_5 = [];
  var_6 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_5 = scripts\engine\utility::array_add(var_5, var_6);
  var_7 = var_6;
  var_8 = 1;

  while(var_8) {
    if(isDefined(var_7.target)) {
      var_9 = scripts\engine\utility::getStruct(var_7.target, "targetname");
      var_5 = scripts\engine\utility::array_add(var_5, var_9);
      var_4++;
      var_7 = var_9;
      continue;
    }

    var_8 = 0;
  }

  var_10 = var_0 / var_4;

  if(isDefined(var_2))
    wait(var_2);

  foreach(var_12 in var_5)
  var_3 move_to_point_with_angles(var_10, var_12.origin, var_12.angles, 1);

  self unlink();
  var_3 delete();
  self notify("stub_path_complete");
}

stub_path_array(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3[0], "targetname");
    var_5 = var_3[1];
    var_6 = var_3[2];
    var_7 = var_3[3];
    self moveTo(var_4.origin, var_5, var_6, var_7);
    self rotateTo(var_4.angles, var_5, var_6, var_7);
    wait(var_5);
  }

  if(isDefined(var_1))
    level notify(var_1);
}

go_to_targetname(var_0) {
  var_1 = getnode(var_0, "targetname");

  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1.radius))
    var_1.radius = 55;

  scripts\sp\spawner::go_to_node(var_1);
}

go_to_node_targetname(var_0) {
  scripts\sp\spawner::go_to_node(getnode(var_0, "targetname"));
}

go_to_struct_targetname(var_0) {
  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct(var_0, "targetname"));
}

gasmask_on(var_0) {
  level endon("removed_gasmask");

  if(!isDefined(var_0))
    var_0 = 0;

  level.player scripts\sp\utility::allow_cg_drawcrosshair(0, "gasmask");
  level.player scripts\common\utility::allow_sprint(0, "gasmask");
  level.player scripts\common\utility::allow_melee(0, "gasmask");
  visor_anim(var_0);
  level.player scripts\common\utility::allow_sprint(1, "gasmask");
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1, "gasmask");
  level.player scripts\common\utility::allow_melee(1, "gasmask");
  level.player childthread mask_death_function();
  level.player childthread mask_fail_function();
}

visor_anim(var_0) {
  var_1 = 0.001;

  if(istrue(var_0)) {
    level.player scripts\engine\utility::delaycall(0.5, ::setentitysoundcontext, "gender", "gasmask_male");
    visor_overlay(1, var_1, 10, 45);
    return;
  } else
    var_1 = 0.12;

  while(level.player.flashlightinuse)
    waitframe();

  scripts\engine\utility::flag_set("player_occupied");
  scripts\engine\utility::delaythread(2.5, ::visor_overlay, 1, var_1, 10, 45);
  var_2 = mask_init();
  var_3 = var_2 scripts\engine\utility::getanim("player_mask_on");
  level.player thread scripts\engine\sp\utility::player_gesture_force("pxw_vm_gasmask_ges");
  var_2 thread scripts\common\anim::anim_single_solo(var_2, "player_mask_on");
  scripts\engine\utility::flag_wait("player_mask_on");
  level.player setentitysoundcontext("gender", "gasmask_male");
  var_2 delete();
  scripts\engine\utility::flag_clear("player_occupied");
}

visor_overlay(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.gas_mask_overlay)) {
    level.gas_mask_overlay = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_delta2", 0);
    level.gas_mask_overlay.sort = -1;
  }

  level.gas_mask_overlay fadeovertime(var_1);
  level.gas_mask_overlay.alpha = var_0;
  level.player setdepthoffield(1, 200, 5000, 10000, 10, 0);
  level.player setviewmodeldepthoffield(4, 45, 6);
}

mask_init() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("player_gasmask", (0, 0, 0));
  var_0 hide();
  var_0 notsolid();
  var_0 dontinterpolate();
  var_0 linktoplayerview(level.player, "j_wrist_le", (0, 0, 0), (0, 0, 0), 1, "none");
  var_0 scripts\common\anim::anim_first_frame_solo(var_0, "player_mask_on");
  var_0 scripts\engine\utility::delaycall(0.3, ::show);
  return var_0;
}

mask_death_function() {
  level endon("mission_fail");
  level endon("friendlyfire_mission_fail");
  scripts\engine\utility::waittill_any("death", "mission_fail", "friendlyfire_mission_fail");
  remove_mask_overlay();
}

mask_fail_function() {
  level.player endon("death");
  level scripts\engine\utility::waittill_any("mission_fail", "friendlyfire_mission_fail");
  remove_mask_overlay();
}

remove_mask_overlay() {
  if(isDefined(level.gas_mask_overlay)) {
    level.gas_mask_overlay fadeovertime(0.5);
    level.gas_mask_overlay.alpha = 0;
    wait 0.5;
    level.gas_mask_overlay destroy();
  }
}

lerp_player_speed_scale(var_0, var_1) {
  if(!isDefined(level.player.speed_scale))
    level.player.speed_scale = 1;

  var_2 = level.player.speed_scale;
  var_3 = (var_0 - var_2) / var_1 * 0.05;

  while(var_2 != var_0) {
    var_2 = var_2 + var_3;
    level.player setmovespeedscale(var_2);
    level.player.speed_scale = var_2;
    waitframe();
  }
}

demeanor_hack() {
  self clearentitytarget();
  scripts\common\utility::lookatentity(self.aim_target);
  wait 20.0;
  scripts\common\utility::demeanor_override("combat");
  iprintlnbold("combat");
  wait 10.0;
  scripts\common\utility::demeanor_override("casual");
  iprintlnbold("casual");
  wait 10.0;
  scripts\common\utility::demeanor_override("casual_gun");
  iprintlnbold("casual_gun");
  wait 10.0;
  scripts\common\utility::demeanor_override("alert");
  iprintlnbold("alert");
  wait 10.0;
  scripts\common\utility::demeanor_override("cqb");
  iprintlnbold("cqb");
  wait 10.0;
  scripts\common\utility::demeanor_override("sprint");
  iprintlnbold("sprint");
  wait 10.0;
  scripts\common\utility::demeanor_override("frantic");
  iprintlnbold("frantic");
}

can_flashlight_ai_see_player(var_0) {
  if(!isDefined(self) || !isalive(self))
    return 0;

  var_1 = distance2d(level.player.origin, self.origin);
  var_2 = var_1 < 100;

  if(!var_0 || level.player getstance() == "stand")
    var_3 = var_1 < 800;
  else if(level.player getstance() == "crouch")
    var_3 = var_1 < 400;
  else
    var_3 = var_1 < 200;

  var_3 = var_3 &scripts\engine\utility::within_fov(self.origin, self.angles, level.player.origin, cos(60));
  var_3 = var_3 &scripts\engine\trace::ray_trace_passed(self gettagorigin("tag_flash"), level.player getEye(), [self, level.player], scripts\engine\trace::create_ainosight_contents());
  return var_2 || var_3;
}

player_shining_light_at(var_0, var_1) {
  if(!isalive(var_0))
    return 0;

  if(!isDefined(var_1))
    var_1 = 1000;

  var_2 = level.player.flashlighton;
  var_2 = var_2 &within_player_fov(var_0 getEye());
  var_2 = var_2 &within_distance(level.player.origin, var_0.origin, var_1);
  return var_2;
}

proxywar_timeout(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "timeout";

  self endon("death");
  self endon("kill_checks");

  if(var_0 > 0)
    wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  self notify(var_1);
}

enable_ally_vision() {
  self.ignoreme = 0;
  self.ignoreall = 0;
}

enable_ally_firing() {
  self.dontevershoot = 0;
  self.disablepistol = 0;
}

enable_allies_firing() {
  foreach(var_1 in level.alpha_and_bravo_team) {
    var_1 enable_ally_vision();
    var_1 enable_ally_firing();
  }
}

disable_ally_vision() {
  self.ignoreme = 1;
  self.ignoreall = 1;
}

disable_ally_firing() {
  self.dontevershoot = 1;
  self.disablepistol = 1;
}

disable_allies_firing() {
  foreach(var_1 in level.alpha_and_bravo_team) {
    var_1 disable_ally_vision();
    var_1 disable_ally_firing();
  }
}

allies_to_cqb() {
  foreach(var_1 in level.alpha_team)
  var_1 scripts\common\utility::demeanor_override("cqb");

  foreach(var_1 in level.bravo_team)
  var_1 scripts\common\utility::demeanor_override("cqb");
}

allies_to_combat() {
  foreach(var_1 in level.alpha_team)
  var_1 scripts\common\utility::demeanor_override("combat");

  foreach(var_1 in level.bravo_team)
  var_1 scripts\common\utility::demeanor_override("combat");
}

clear_allies_demeanor_override() {
  foreach(var_1 in level.alpha_team)
  var_1 scripts\common\utility::clear_demeanor_override();

  foreach(var_1 in level.bravo_team)
  var_1 scripts\common\utility::clear_demeanor_override();
}

flag_wait_either_or_timeout(var_0, var_1, var_2) {
  var_3 = var_2 * 1000;
  var_4 = gettime();

  for(;;) {
    if(scripts\engine\utility::flag(var_0) || scripts\engine\utility::flag(var_1)) {
      break;
    }

    if(gettime() >= var_4 + var_3) {
      break;
    }

    var_5 = var_3 - (gettime() - var_4);
    var_6 = var_5 / 1000;
    wait_for_either_flag_or_time_elapses(var_0, var_1, var_6);
  }
}

wait_for_either_flag_or_time_elapses(var_0, var_1, var_2) {
  level endon(var_0);
  level endon(var_1);
  wait(var_2);
}

dialogue(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

  if(isDefined(var_2) && isDefined(var_3)) {
    if(!isarray(var_2))
      var_2 = [var_2];

    if(!isarray(var_3))
      var_3 = [var_3];

    foreach(var_7 in var_2) {
      foreach(var_9 in var_3)
      var_7 endon(var_9);
    }
  }

  if(isDefined(var_1) && var_1)
    wait(var_1);

  if(soundexists(var_0)) {
    if(isPlayer(self))
      scripts\engine\sp\utility::smart_player_dialogue(var_0);
    else if(istrue(var_4))
      scripts\engine\sp\utility::smart_radio_dialogue(var_0);
    else
      scripts\engine\sp\utility::smart_dialogue(var_0);

    self notify("dialogue_finished");
  } else {
    var_12 = "";

    if(isPlayer(self)) {
      var_12 = "Alex";
      var_13 = "^2";
    } else if(isDefined(var_5)) {
      var_13 = "^3";
      var_12 = var_5;
    } else {
      var_12 = self.name;

      if(scripts\engine\utility::is_equal(self.team, "axis"))
        var_13 = "^1";
      else if(scripts\engine\utility::is_equal(self.team, "allies"))
        var_13 = "^2";
      else
        var_13 = "^3";
    }

    if(istrue(var_4))
      var_14 = var_13 + var_12 + " Over Radio" + ": " + "^7" + var_0;
    else
      var_14 = var_13 + var_12 + ": " + "^7" + var_0;

    thread dialogue_proc(var_14, var_1);
  }
}

dialogue_proc(var_0, var_1) {
  level notify("new_dialogue");
  var_2 = 0.3;
  var_3 = 3.0;
  var_4 = 2.0;
  var_5 = 1.2;
  var_6 = int(5.9 * var_5);
  var_7 = int(24 * var_5);
  var_8 = 300;
  var_9 = newhudelem();
  var_10 = newhudelem();
  var_11 = 350;
  var_12 = int(max(var_0.size * var_6, var_11));
  var_13 = [var_9, var_10];
  scripts\engine\utility::array_thread(var_13, ::dialog_new_line_monitor);

  foreach(var_15 in var_13) {
    var_15.alignx = "center";
    var_15.aligny = "middle";
    var_15.x = 320;
    var_15.y = var_8;
    var_15.sort = 5;
  }

  var_9.alpha = 0.5;
  var_9 setshader("black", var_12, var_7);
  var_10 settext(var_0);
  var_10.fontscale = var_5;
  wait(var_3);

  foreach(var_15 in var_13) {
    var_15 fadeovertime(var_4);
    var_15.alpha = 0;
  }

  wait(var_4);

  foreach(var_15 in var_13)
  var_15 destroy();
}

dialog_new_line_monitor() {
  self endon("death");

  for(;;) {
    level waittill("new_dialogue");
    self moveovertime(0.35);
    self.y = self.y + 30;
    waitframe();
  }
}

move_to_arrive_then_idle(var_0, var_1, var_2, var_3) {
  level endon("kill_all_anim_instructions");
  level endon("end_move_and_idle");
  self endon("end_move_and_idle");

  if(!isDefined(var_3))
    var_3 = "end_move_and_idle";

  var_0 scripts\sp\anim::anim_reach_solo(self, var_1);
  var_0 scripts\common\anim::anim_single_solo(self, var_1);

  if(isDefined(var_0.arrivalcount))
    var_0.arrivalcount++;
  else
    var_0.arrivalcount = 1;

  var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, var_3);
}

play_group_single_anim_into_idle_anim(var_0, var_1, var_2, var_3, var_4) {
  level endon("kill_all_anim_instructions");

  if(!isDefined(var_4))
    var_4 = 0;

  foreach(var_6 in self)
  var_6 thread play_single_anim_into_idle_anim(var_0, var_1, var_2, var_3, var_4);
}

play_single_anim_into_idle_anim(var_0, var_1, var_2, var_3, var_4) {
  level endon("kill_all_anim_instructions");
  self endon("kill_self_anim_instructions");

  if(!isDefined(var_4))
    var_4 = 0;

  if(var_4)
    var_0 scripts\sp\anim::anim_reach_solo(self, var_1);

  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, var_3);

  if(isDefined(var_0.arrivalcount))
    var_0.arrivalcount++;
  else
    var_0.arrivalcount = 1;
}

get_struct_with_sight_to_player(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\engine\sp\utility::can_trace_to_player(var_2.origin))
      return var_2;
  }

  return undefined;
}

alarm_sound() {
  level endon("end_alarm");

  if(!scripts\engine\utility::flag("started_alarm")) {
    scripts\engine\utility::flag_set("started_alarm");
    var_0 = scripts\engine\utility::getStruct("alleyway_alarm_sound", "targetname");
    var_1 = scripts\engine\utility::spawn_script_origin(var_0.origin, var_0.angles);

    for(var_2 = 0; var_2 < 15; var_2++) {
      var_1 scripts\engine\utility::playsoundonentity("alarm_buzzer");
      wait 3;
    }
  }
}

hint_crouch() {
  if(!level.player_crouched) {
    var_0 = getkeybinding("+stance");

    if(level.player usinggamepad() || var_0["count"] || !(level.player getlocalplayerprofiledata("crouchType") == 2))
      thread scripts\engine\sp\utility::display_hint("tut_crouch_hint", 15);
    else
      thread scripts\engine\sp\utility::display_hint("tut_crouch_hint_hold", 15);
  }
}

hint_mount() {
  if(level.player scripts\sp\utility::get_mount_activation_mode() != "disabled") {
    var_0 = 25.0;
    thread hint_mount_fx(var_0);
    var_1 = level.player scripts\sp\utility::get_mount_activation_mode();

    if(var_1 == "mount_binding")
      thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_binding_toggle", var_0);
    else if(var_1 == "mount_binding_hold")
      thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_binding", var_0);
    else if(level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledGamepad") || !level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledKeyboard")) {
      switch (var_1) {
        case "double_ads":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_double_toggle", var_0);
          break;
        case "ads":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_hold_toggle", var_0);
          break;
        case "ads_sprint":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_sprint_toggle", var_0);
          break;
        case "ads_activate":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_activate_toggle", var_0);
          break;
        default:
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_toggle", var_0);
          break;
      }
    } else {
      switch (var_1) {
        case "double_ads":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_double", var_0);
          break;
        case "ads":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_hold", var_0);
          break;
        case "ads_sprint":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_sprint", var_0);
          break;
        case "ads_activate":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_activate", var_0);
          break;
        default:
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint", var_0);
          break;
      }
    }
  }
}

hint_mount_fx(var_0) {
  var_1 = spawnStruct();
  var_1.door = scripts\engine\utility::getStruct("mount_hint", "targetname");
  var_1.door.angles = (0, 90, 0);
  var_1.traincar = scripts\engine\utility::getStruct("mount_hint_traincar", "targetname");
  var_1.traincar.angles = (0, 90, 0);
  var_2 = undefined;
  var_3 = gettime();
  var_4 = 0;

  while(!scripts\engine\utility::time_has_passed(var_3, var_0) && level.player playermount() < 0.5) {
    if(!var_4 && scripts\engine\utility::flag("player_inside_intro_room")) {
      if(isDefined(var_2))
        var_2 delete();

      var_2 = spawnfx(scripts\engine\utility::getfx("vfx_mount_hint_line"), var_1.door.origin, anglesToForward(var_1.door.angles));
      triggerfx(var_2);
      var_4 = 1;
    } else if(var_4 && !scripts\engine\utility::flag("player_inside_intro_room")) {
      if(isDefined(var_2))
        var_2 delete();

      var_2 = spawnfx(scripts\engine\utility::getfx("vfx_mount_hint_line"), var_1.traincar.origin, anglesToForward(var_1.traincar.angles));
      triggerfx(var_2);
      var_4 = 0;
    }

    waitframe();
  }

  if(isDefined(var_2))
    var_2 delete();
}

hint_alt_fire_swap(var_0) {
  var_1 = level.player getcurrentweapon();
  var_2 = getweaponbasename(var_1);
  var_3 = gettime();

  while(!scripts\engine\utility::time_has_passed(var_3, var_0) && var_2 != "iw8_ar_mike4")
    waitframe();

  if(var_1.isalternate && var_2 == "iw8_ar_mike4")
    thread scripts\engine\sp\utility::display_hint_forced("tut_alt_fire_hint_press", 15.0);
}

hint_grenade_throw() {
  while(isDefined(level.railyard_lmg) && !within_player_fov(level.railyard_lmg.og_origin))
    waitframe();

  if(!level.player_threw_grenade) {
    thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_rc_mg_grenade_hint();
    thread scripts\engine\sp\utility::display_hint("tut_grenade_hint", 15.0);
  }
}

hint_weapon_swap() {
  wait 0.5;

  if(!level.player_swapped_weapon)
    thread scripts\engine\sp\utility::display_hint("tut_swap_weapon_hint", 15);
}

set_flag_on_death(var_0) {
  if(isalive(self))
    self waittill("death");

  scripts\engine\utility::flag_set(var_0);
}

set_flag_on_death_or_damage(var_0) {
  if(isalive(self))
    scripts\engine\utility::waittill_any("death", "damage");

  scripts\engine\utility::flag_set(var_0);
}

ally_go_to_and_wait(var_0, var_1, var_2) {
  if(!scripts\engine\utility::flag(var_2)) {
    thread go_to_targetname(var_0);
    var_3 = scripts\engine\utility::waittill_any_ents_return(self, "reached_path_end", level, var_2);

    if(var_3 == "reached_path_end") {
      wait 1.0;
      scripts\engine\utility::flag_wait(var_1);
      wait(randomfloatrange(0.0, 0.5));
    }
  }
}

anim_door(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_2 scripts\engine\sp\utility::assign_animtree("door");
  var_2 scripts\common\anim::anim_first_frame_solo(var_2, var_1);
  var_0.temp_animator = var_2;
  var_0 linkTo(var_2);

  if(isDefined(self.open_struct) && isDefined(self.open_struct.openinteract)) {
    var_0 scripts\sp\door::remove_open_prompts();
    var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
  }

  scripts\common\anim::anim_single_solo(var_2, var_1);
  var_0 scripts\sp\door::updatenavobstacle();
  var_0 scripts\sp\door::clear_navobstacle();
  var_0.open_completely = 1;
  var_2 delete();
}

anim_last_frame_door(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_2 scripts\engine\sp\utility::assign_animtree("door");
  var_2 scripts\common\anim::anim_first_frame_solo(var_2, var_1);
  var_0.temp_animator = var_2;
  var_0 linkTo(var_2);

  if(isDefined(self.open_struct) && isDefined(self.open_struct.openinteract)) {
    var_0 scripts\sp\door::remove_open_prompts();
    var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
  }

  scripts\common\anim::anim_last_frame_solo(var_2, var_1);
  var_0 scripts\sp\door::updatenavobstacle();
  var_0 scripts\sp\door::clear_navobstacle();
  var_0.open_completely = 1;
  var_2 delete();
}

stop_changing_scene_speed_while_offscreen(var_0, var_1) {
  self notify("stop_offscreen_anim_speed_changing");

  foreach(var_3 in var_0)
  var_3 setanimrate(var_3 scripts\engine\utility::getanim(var_1), 1.0);
}

change_scene_speed_while_offscreen(var_0, var_1, var_2, var_3) {
  self endon("stop_offscreen_anim_speed_changing");
  var_1 endon(var_2);
  var_4 = undefined;
  var_5 = undefined;

  for(;;) {
    foreach(var_7 in var_0) {
      if(isai(var_7))
        var_4 = within_player_fov(var_7.origin) && level.player scripts\engine\utility::can_trace_to_ai(level.player getEye(), var_7);
      else
        var_4 = level.player scripts\engine\trace::can_see_origin(var_7.origin);

      if(var_4) {
        break;
      }
    }

    if(!isDefined(var_5))
      var_5 = !var_4;

    if(var_4 && !var_5) {
      foreach(var_7 in var_0)
      var_7 setanimrate(var_7 scripts\engine\utility::getanim(var_2), 1.0);
    } else if(!var_4 && var_5) {
      foreach(var_7 in var_0)
      var_7 setanimrate(var_7 scripts\engine\utility::getanim(var_2), var_3);
    }

    var_5 = var_4;
    waitframe();
  }
}

slow_scene_speed_while_offscreen(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0.2;

  change_scene_speed_while_offscreen(var_0, var_1, var_2, var_3);
}

quicken_scene_speed_while_offscreen(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1.2;

  change_scene_speed_while_offscreen(var_0, var_1, var_2, var_3);
}

lerp_fov_over_distance_trigger() {
  var_0 = strtok(self.script_parameters, " ");
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = scripts\engine\utility::getStruct(var_3, "targetname");

  var_5 = float(var_1[0].script_parameters);
  var_6 = float(var_1[1].script_parameters);
  var_7 = distance(var_1[0].origin, var_1[1].origin);

  for(;;) {
    if(!level.player istouching(self))
      self waittill("trigger");

    while(level.player istouching(self)) {
      var_8 = pointonsegmentnearesttopoint(var_1[0].origin, var_1[1].origin, level.player.origin);
      var_9 = scripts\engine\math::normalize_value(0, var_7, distance(var_1[0].origin, var_8));
      var_10 = scripts\engine\math::factor_value(var_5, var_6, var_9);
      level.player modifybasefov(var_10, 0.05);

      if(level.player adsButtonPressed())
        wait 0.3;
      else
        level.player modifybasefov(var_10, 0.05);

      waitframe();
    }
  }
}

change_ai_speed_while_offscreen(var_0, var_1) {
  self endon("stop_offscreen_movement_speed_changing");
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    var_2 = within_player_fov(self.origin) && level.player scripts\engine\utility::can_trace_to_ai(level.player getEye(), self);

    if(!isDefined(var_3))
      var_3 = !var_2;

    if(var_2 && !var_3)
      scripts\engine\utility::set_movement_speed(var_0);
    else if(!var_2 && var_3)
      scripts\engine\utility::set_movement_speed(var_1);

    var_3 = var_2;
    waitframe();
  }
}

stop_changing_ai_speed_while_offscreen() {
  self notify("stop_offscreen_movement_speed_changing");
  scripts\common\utility::clear_movement_speed();
}

notify_if_teleport_clear(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_3);

  if(!isDefined(var_4))
    var_4 = (0, 0, 0);

  var_5 = 0;

  while(!var_5) {
    var_5 = !level.player scripts\engine\trace::can_see_origin(var_0 getEye(), 0) && !level.player scripts\engine\trace::can_see_origin(var_1.origin + var_4);
    var_5 = var_5 && !within_distance2d(level.player.origin, var_0.origin, 200) && !within_distance2d(level.player.origin, var_1.origin + var_4, 200);
    var_5 = var_5 && scripts\engine\math::within_fov_2d(var_1.origin, var_1.angles, level.player.origin, 0);
    waitframe();
  }

  level notify(var_2);
}

teleport_if_clear(var_0, var_1, var_2, var_3) {
  level endon(var_2);

  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  var_4 = cos(getdvarfloat("MRNKTKLLKP") + 10);
  var_5 = 0;

  while(!var_5) {
    if(!within_distance2d(level.player.origin, self.origin, 200) && !within_distance2d(level.player.origin, var_0.origin + var_3, 200) && !level.player within_player_fov_2d(self getEye(), var_4) && !level.player within_player_fov_2d(var_0.origin + var_3, var_4) && scripts\engine\math::within_fov_2d(var_0.origin, var_0.angles, level.player.origin, 0))
      var_5 = 1;

    waitframe();
  }

  self forceteleport(var_0.origin, var_0.angles, 90000000);
}

set_wind(var_0, var_1, var_2, var_3, var_4) {
  setsaveddvar("MRNRKKOPLN", var_0);
  setsaveddvar("OLSKLTPPMR", var_1);
  setsaveddvar("MQPQKNPQOK", var_2);
  setsaveddvar("LQLSPQOPKM", var_3);
  setsaveddvar("NQTLPTNSSO", var_4);
}

ramp_wind(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", var_1, var_0);
  scripts\engine\sp\utility::lerp_saveddvar("OLSKLTPPMR", var_2, var_0);
  scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", var_3, var_0);
  scripts\engine\sp\utility::lerp_saveddvar("LQLSPQOPKM", var_4, var_0);
  scripts\engine\sp\utility::lerp_saveddvar("NQTLPTNSSO", var_5, var_0);
}

give_spotter_scope() {
  level.player.binoculars = scripts\sp\utility::make_weapon("iw8_spotter_scope", ["spotterscope_nvg"]);
  level.player giveweapon(level.player.binoculars);
  level.player childthread scripts\engine\sp\utility::actionslotoverride(1, "hud_icon_equipment_spotter_scope", undefined, ::toggle_spotterscope);
  visionsetnight("nvg_proxywar_spotter", 0);
  level thread monitor_spotterscope_equipped();
}

monitor_spotterscope_equipped() {
  for(;;) {
    level.player waittill("weapon_change");

    if(level.player getcurrentweapon().basename == "iw8_spotter_scope") {
      level thread monitor_spotterscope_nvg();

      if(!scripts\engine\utility::flag("allow_target_marking")) {
        scripts\engine\utility::flag_set("disabled_firing");
        level.player scripts\common\utility::allow_fire(0, "spotter");
      }

      scripts\engine\utility::flag_set("equipped_spotter_scope");
      continue;
    }

    if(!scripts\engine\utility::flag("allow_target_marking")) {
      if(scripts\engine\utility::flag("disabled_firing")) {
        level.player scripts\common\utility::allow_fire(1, "spotter");
        scripts\engine\utility::flag_clear("disabled_firing");
      }
    }

    level notify("nvg_off");

    if(scripts\engine\utility::flag("nvg_on"))
      scripts\engine\utility::flag_clear("nvg_on");

    scripts\engine\utility::flag_clear("equipped_spotter_scope");
  }
}

monitor_spotterscope_nvg() {
  level endon("nvg_off");

  for(;;) {
    while(level.player playerads() < 1)
      waitframe();

    scripts\engine\utility::flag_set("nvg_on");

    while(level.player playerads() == 1)
      waitframe();

    scripts\engine\utility::flag_clear("nvg_on");
  }
}

toggle_spotterscope() {
  if(scripts\common\utility::is_weapon_switch_allowed()) {
    if(level.player getcurrentweapon().basename != "iw8_spotter_scope") {
      level.player.lastusedweapon = level.player getcurrentprimaryweapon();
      level.player.lastusedweaponisalt = level.player isalternatemode(level.player.lastusedweapon);
      level.player switchtoweapon(level.player.binoculars);
    } else {
      var_0 = level.player.lastusedweapon getaltweapon();

      if(level.player.lastusedweaponisalt && !nullweapon(var_0))
        level.player switchtoweapon(var_0);
      else
        level.player switchtoweapon(level.player.lastusedweapon);
    }
  }
}

nightvision_override(var_0, var_1, var_2) {
  self setweaponhudiconoverride("actionslot" + var_0, var_1);

  if(isDefined(var_2))
    thread nightvision_override_callback(var_0, var_2);
}

nightvision_override_callback(var_0, var_1) {
  self endon("death");
  self endon("removeActionslot" + var_0);
  self notifyonplayercommand("flashlight", "nightvision");

  for(;;) {
    self waittill("flashlight");
    self thread[[var_1]]();
  }
}

give_flashlight() {
  level endon("kill_flashlight");
  level.player.flashlight = spawn("script_model", (0, 0, 0));
  level.player.flashlight setModel("tag_origin");
  level.player.flashlighton = 0;
  level.player.flashlightinuse = 0;
  level.player.flashlight linktoplayerview(level.player, "tag_cambone", (0, 0, 0), (0, 0, 0), 1);
  level.player childthread scripts\engine\sp\utility::actionslotoverride(2, "hud_icon_equipment_flashlight", undefined, ::toggle_flashlight, 1);
  level.player childthread nightvision_override(2, "hud_icon_equipment_flashlight", ::toggle_flashlight);
}

toggle_flashlight() {
  level endon("kill_flashlight");

  if(!level.player.flashlightinuse && !level.player islinked() && !scripts\engine\utility::flag("player_occupied") && scripts\common\utility::is_weapon_switch_allowed() && scripts\common\utility::is_weapon_pickup_allowed() && !level.player isswitchingweapon() && !nullweapon(level.player getcurrentweapon())) {
    if(level.player.flashlighton) {
      level.player scripts\sp\utility::allow_weapon_first_raise_anims(0, "flashlight");
      level.player scripts\common\utility::allow_weapon_switch(0, "flashlight");
      level.player scripts\common\utility::allow_weapon_pickup(0, "flashlight");
      level.player.flashlightinuse = 1;
      level.player thread scripts\engine\sp\utility::player_gesture_force("iw8_vm_ges_helmet_light_sp");
      wait 0.5;
      killfxontag(scripts\engine\utility::getfx("vfx_flashlight_player"), level.player.flashlight, "tag_origin");
      level.player playSound("pw_helmet_flashlight_off");
      wait 1.1;
      level.player.flashlighton = 0;
      level.player.flashlightinuse = 0;
      level.player scripts\sp\utility::allow_weapon_first_raise_anims(1, "flashlight");
      level.player scripts\common\utility::allow_weapon_switch(1, "flashlight");
      level.player scripts\common\utility::allow_weapon_pickup(1, "flashlight");
    } else {
      level.player scripts\sp\utility::allow_weapon_first_raise_anims(0, "flashlight");
      level.player scripts\common\utility::allow_weapon_switch(0, "flashlight");
      level.player scripts\common\utility::allow_weapon_pickup(0, "flashlight");
      level.player.flashlightinuse = 1;
      level.player thread scripts\engine\sp\utility::player_gesture_force("iw8_vm_ges_helmet_light_sp");
      wait 0.5;
      playFXOnTag(scripts\engine\utility::getfx("vfx_flashlight_player"), level.player.flashlight, "tag_origin");
      level.player playSound("pw_helmet_flashlight_on");
      wait 1.1;
      level.player.flashlighton = 1;
      level.player.flashlightinuse = 0;
      level.player scripts\sp\utility::allow_weapon_first_raise_anims(1, "flashlight");
      level.player scripts\common\utility::allow_weapon_switch(1, "flashlight");
      level.player scripts\common\utility::allow_weapon_pickup(1, "flashlight");
    }
  }
}

kill_flashlight() {
  level notify("kill_flashlight");

  if(level.player.flashlighton) {
    level.player thread scripts\engine\sp\utility::player_gesture_force("iw8_vm_ges_helmet_light_sp");
    wait 0.75;
    killfxontag(scripts\engine\utility::getfx("vfx_flashlight_player"), level.player.flashlight, "tag_origin");
  }
}

within_bounds(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_2 - var_0;

  if(isDefined(var_4)) {
    var_4 = vectorNormalize(var_4);
    var_6 = vectordot(var_5, var_4) * var_4;
    var_5 = var_5 - var_6;
  }

  var_7 = acos(vectordot(vectorNormalize(var_5), vectorNormalize(var_1)));
  return var_7 <= var_3;
}

magic_gun_create_weapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  setdvarifuninitialized("scr_magic_gun_draw_debug", 0);
  var_6 = scripts\engine\sp\utility::spawn_anim_weapon(var_0, var_1, var_2);
  var_6.weapon = level.scr_weapon[var_0][0];
  var_6.curr_target = scripts\engine\utility::spawn_script_origin();
  var_6.intended_target = var_6 localtoworldcoords((100, 0, 0));
  var_6.tracking_speed = var_3;
  var_6.og_origin = var_6.origin;
  var_6.og_angles = var_6.angles;
  var_6.max_angle_horiz = var_4;
  var_6.max_angle_vert = var_5;
  var_6 thread internal_magic_gun_track_target();
  return var_6;
}

internal_magic_gun_track_target() {
  self endon("kill_magic_gun");

  for(;;) {
    var_0 = self.intended_target - self.curr_target.origin;
    var_1 = self.tracking_speed * 0.05;

    if(length(var_0) < var_1) {
      if(self.curr_target.origin != self.intended_target) {
        var_2 = within_bounds(self.og_origin, anglesToForward(self.og_angles), self.intended_target, self.max_angle_horiz, anglestoup(self.og_angles));
        var_3 = within_bounds(self.og_origin, anglesToForward(self.og_angles), self.intended_target, self.max_angle_vert, anglestoleft(self.og_angles));

        if(var_2 && var_3) {
          self.curr_target.origin = self.intended_target;
          self.angles = vectortoangles(vectorNormalize(self.curr_target.origin - self.origin));
        }

        self notify("reached_target");
      }
    } else {
      var_0 = vectorNormalize(var_0);
      var_4 = self.curr_target.origin + var_0 * var_1;
      var_2 = within_bounds(self.og_origin, anglesToForward(self.og_angles), var_4, self.max_angle_horiz, anglestoup(self.og_angles));
      var_3 = within_bounds(self.og_origin, anglesToForward(self.og_angles), var_4, self.max_angle_vert, anglestoleft(self.og_angles));

      if(var_2 && var_3) {
        self.curr_target.origin = var_4;
        self.angles = vectortoangles(vectorNormalize(self.curr_target.origin - self.origin));
      } else
        self notify("reached_target");
    }

    if(getdvarint("scr_magic_gun_draw_debug", 0)) {
      self.curr_target scripts\engine\utility::draw_ent_axis();
      scripts\engine\utility::draw_angles((0, 0, 0), self.intended_target);
      scripts\engine\utility::draw_ent_axis();
    }

    waitframe();
  }
}

magic_gun_set_target(var_0, var_1) {
  self endon("kill_magic_gun");
  self notify("target_updated");
  self endon("target_updated");
  self.intended_target = var_0;

  if(istrue(var_1))
    self waittill("reached_target");
  else
    self.curr_target.origin = var_0;
}

magic_gun_clear_target() {
  magic_gun_set_target(self.og_origin + anglesToForward(self.og_angles) * 100);
}

magic_gun_set_tracking_speed(var_0) {
  self.tracking_speed = var_0;
}

magic_gun_fire(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("stop_firing");
  self endon("kill_magic_gun");

  if(!isDefined(var_7))
    var_7 = 1.0;

  if(randomint(100) > 50)
    var_8 = -1.0;
  else
    var_8 = 1.0;

  if(randomint(100) > 50)
    var_9 = 1.0;
  else
    var_9 = -1.0;

  var_10 = 50 * var_7;
  var_11 = 25 * var_7;
  var_12 = 50 * var_7;
  var_13 = 25 * var_7;

  if(var_2 == 0) {
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
  } else {
    var_14 = var_10 / var_2;
    var_15 = var_12 / var_2;
  }

  var_16 = 0;
  var_17 = randomfloatrange(var_0, var_1);

  while(var_16 < var_17) {
    var_18 = randomfloatrange(var_11, var_10) * var_8;
    var_19 = randomfloatrange(var_13, var_12) * var_9;
    var_20 = (0, var_18, var_19);
    var_21 = rotatevector(var_20, self gettagangles("tag_flash"));
    magicbullet(self.weapon, self gettagorigin("tag_flash"), self.curr_target.origin + var_21);
    var_16++;
    var_10 = clamp(var_10 - var_14, 1, var_10);
    var_11 = clamp(var_11 - var_14, 0, var_10);
    var_12 = clamp(var_12 - var_15, 1, var_12);
    var_13 = clamp(var_13 - var_15, 0, var_12);

    if(randomint(100) > 50)
      var_8 = -1.0;
    else
      var_8 = 1.0;

    if(randomint(100) > 50)
      var_9 = 1.0;
    else
      var_9 = -1.0;

    wait(randomfloatrange(var_3, var_4));
  }

  wait(randomfloatrange(var_5, var_6));
}

magic_gun_stop_firing() {
  self notify("stop_firing");
}

magic_gun_delete() {
  self notify("kill_magic_gun");
  self delete();
}

internal_mg_forward(var_0) {
  return var_0.origin - self.origin;
}

internal_mg_left_vector(var_0) {
  return vectorNormalize(vectorcross((0, 0, 1), var_0));
}

magic_gun_search_around_ent(var_0, var_1) {
  self endon("kill_magic_gun");
  self notify("stop_search");
  self endon("stop_search");

  if(randomint(100) > 50)
    var_2 = 1.0;
  else
    var_2 = -1.0;

  for(;;) {
    var_3 = internal_mg_forward(var_0);
    var_4 = internal_mg_left_vector(var_3) * var_2 * var_1;
    var_2 = var_2 * -1.0;
    magic_gun_set_target(self.origin + var_3 + var_4, 1);
    var_3 = internal_mg_forward(var_0);
    magic_gun_set_target(self.origin + var_3, 1);
    var_3 = internal_mg_forward(var_0);
    var_4 = internal_mg_left_vector(var_3) * var_2 * var_1;
    var_2 = var_2 * -1.0;
    magic_gun_set_target(self.origin + var_3 + var_4, 1);
    var_3 = internal_mg_forward(var_0);
    magic_gun_set_target(self.origin + var_3, 1);
    waitframe();
  }
}

magic_gun_stop_search_around() {
  self notify("stop_search");
}

magic_gun_track_ent(var_0, var_1, var_2) {
  self endon("kill_magic_gun");
  self notify("stop_tracking");
  self endon("stop_tracking");

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_1))
    var_1 = "tag_origin";

  for(;;) {
    if(var_2)
      var_3 = var_0 getEye();
    else
      var_3 = var_0 gettagorigin(var_1);

    thread magic_gun_set_target(var_3, 1);
    waitframe();
  }
}

magic_gun_stop_tracking() {
  self notify("stop_tracking");
}

die_when_offscreen_and_distant() {
  self endon("death");

  while(within_player_fov(self.origin) || within_distance2d(self.origin, level.player.origin, 600))
    wait 0.1;

  self.diequietly = 1;
  scripts\engine\sp\utility::die();
}

anim_single_solo_end_notify(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\common\anim::anim_single_solo(var_1, var_2, var_3, var_4, var_5);
  var_1 notify(var_0);
}

halligan_stow() {
  if(isDefined(self.halligan_stowed) && !self.halligan_stowed)
    self detach(scripts\engine\sp\utility::getmodel("halligan"), "tag_accessory_right");

  self attach(scripts\engine\sp\utility::getmodel("halligan"), "tag_stowed_back");
  self.halligan_stowed = 1;
}

halligan_draw() {
  if(istrue(self.halligan_stowed))
    self detach(scripts\engine\sp\utility::getmodel("halligan"), "tag_stowed_back");

  self attach(scripts\engine\sp\utility::getmodel("halligan"), "tag_accessory_right");
  self.halligan_stowed = 0;
}

set_ignoreme_after_time(var_0, var_1) {
  self endon("death");
  wait(var_1);
  self.ignoreme = var_0;
}

increase_attacker_accuracy(var_0) {
  self endon("death");
  var_1 = 1.0 - self.attackeraccuracy;
  var_2 = var_1 / var_0;

  while(self.attackeraccuracy < 1.0) {
    self.attackeraccuracy = self.attackeraccuracy + var_2 * 0.05;
    waitframe();
  }

  self.attackeraccuracy = 1.0;
}

delete_on_ent_notify(var_0, var_1) {
  var_0 waittill(var_1);
  self delete();
}

cursor_hint_unusable_think() {
  self endon("trigger");
  self endon("hint_destroyed");
  var_0 = 1;

  for(;;) {
    var_1 = scripts\engine\sp\utility::get_player_demeanor() == "normal" && level.player isgestureplaying() || !isalive(level.player) || level.player ismeleeing();

    if(var_0 && var_1) {
      self.cursor_hint_ent makeunusable();
      var_0 = 0;
    } else if(!var_0 && !var_1) {
      self.cursor_hint_ent makeusable();
      var_0 = 1;
    }

    waitframe();
  }
}

set_ally_movement_pre_breach(var_0) {
  if(var_0 && scripts\engine\math::is_point_in_front(level.player.origin)) {
    var_1 = int(scripts\engine\math::remap(distance2d(level.player.origin, self.origin), 300, 400, 0, 140));
    var_1 = clamp(var_1, 0, 140);
  } else
    var_1 = 0;

  if(scripts\engine\utility::array_contains(level.alpha_team, self))
    scripts\engine\utility::set_movement_speed(randomintrange(90, 110) + var_1);
  else
    scripts\engine\utility::set_movement_speed(randomintrange(60, 80) + var_1);
}

set_ally_movement_courtyard() {
  if(isDefined(level.courtyarddefendgroup) && level.courtyarddefendgroup.size <= 0) {
    if(scripts\engine\math::is_point_in_front(level.player.origin)) {
      var_0 = int(scripts\engine\math::remap(distance2d(level.player.origin, self.origin), 200, 400, 0, 140));
      var_0 = clamp(var_0, 0, 140);
    } else
      var_0 = 0;

    if(self.script_noteworthy == "bravo3" || self.script_noteworthy == "bravo1")
      scripts\engine\utility::set_movement_speed(randomintrange(60, 80) + var_0);
    else
      scripts\engine\utility::set_movement_speed(randomintrange(90, 110) + var_0);
  }
}