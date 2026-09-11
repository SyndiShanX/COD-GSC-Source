/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\proxywar\proxywar_util.gsc
******************************************************/

function waittill_func(var0, var1, var2, var3, var4, var5) {
  while(!call_func_with_params(var0, var2, var3, var4, var5)) {
    if(isDefined(var1)) {
      wait var1;
      continue;
    }

    waitframe();
  }
}

function waittill_func_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  level endon("timer_expired");
  level thread scripts\engine\sp\utility::notify_delay("timer_expired", var0);
  waittill_func(var1, var2, var3, var4, var5, var6);
}

function call_func_with_params(var0, var1, var2, var3, var4) {
  if(isDefined(var4)) {
    return [[var0]](var1, var2, var3, var4);
  }

  if(isDefined(var3)) {
    return [[var0]](var1, var2, var3);
  }

  if(isDefined(var2)) {
    return [[var0]](var1, var2);
  }

  if(isDefined(var1)) {
    return [[var0]](var1);
  }

  return [[var0]]();
}

function spawn_third_person_alex() {
  var0 = getspawner("body_double", "script_animname");
  var0.count = 1;
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1 scripts\engine\sp\utility::name_hide();
  var1.ignoreall = 1;
  var1.ignoreme = 1;
  var1 scripts\common\ai::magic_bullet_shield(1);
  var1 scripts\common\ai::gun_remove();
  return var1;
}

function setup_ally_team(var0, var1) {
  foreach(var3 in var0) {
    var3 thread scripts\common\ai::magic_bullet_shield(1);
    var3 setthreatbiasgroup("allies");
    var3.animname = var3.script_noteworthy;
    var3.targetname = var3.script_noteworthy;
    var3.attackeraccuracy = 0;
    var3.ignoreme = 1;
    var3.dontevershoot = 1;
    var3.disablepistol = 1;
    var3.disableplayeradsloscheck = 1;
    var3 scripts\anim\shared::forceuseweapon(var1[0], "primary");
    thread setup_ally_flashlight();
  }
}

function setup_ally_flashlight() {
  self endon("death");
  waitframe();
  self.flashlightfxoverridetag = "tag_light";
  self.flashlightfxoverride = "vfx_proxywar_npc_flashlight";
}

function spawn_alpha_team(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  level.alpha1 = scripts\engine\sp\utility::spawn_script_noteworthy("alpha1", 1);
  level.alpha_team = [level.alpha1];
  halligan_stow(level.alpha1);

  if(var0) {
    level.alpha2 = scripts\engine\sp\utility::spawn_script_noteworthy("alpha2", 1);
    halligan_stow(level.alpha2);
    level.alpha_team = [level.alpha1, level.alpha2];
  }

  var1 = [scripts\sp\utility::make_weapon("iw8_ar_mike4", ["reflex_west01", "silencer04", "taclight"])];
  setup_ally_team(level.alpha_team, var1);
}

function spawn_bravo_team() {
  level.bravo1 = scripts\engine\sp\utility::spawn_script_noteworthy("bravo1", 1);
  level.bravo2 = scripts\engine\sp\utility::spawn_script_noteworthy("bravo2", 1);
  level.bravo3 = scripts\engine\sp\utility::spawn_script_noteworthy("bravo3", 1);
  level.bravo_team = [level.bravo1, level.bravo2, level.bravo3];
  var0 = [scripts\sp\utility::make_weapon("iw8_ar_mike4", ["reflex_west01", "silencer04", "taclight"])];
  setup_ally_team(level.bravo_team, var0);
}

function spawn_recon_team() {
  level.recon1 = scripts\engine\sp\utility::spawn_script_noteworthy("recon1", 1);
  level.recon2 = scripts\engine\sp\utility::spawn_script_noteworthy("recon2", 1);
  level.recon3 = scripts\engine\sp\utility::spawn_script_noteworthy("recon3", 1);
  level.recon4 = scripts\engine\sp\utility::spawn_script_noteworthy("recon4", 1);
  level.recon_team = [level.recon1, level.recon2, level.recon3, level.recon4];
  var0 = [scripts\sp\utility::make_weapon("iw8_ar_mike4", ["reflex_west01", "silencer04"]), scripts\sp\utility::make_weapon("iw8_sn_mike14", ["silencerdmr04", "snprscope_mike14"]), scripts\sp\utility::make_weapon("iw8_sn_alpha50"), scripts\sp\utility::make_weapon("iw8_lm_kilo121")];
  setup_ally_team(level.recon_team, var0);
}

function spawn_ally_teams(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  spawn_alpha_team(var0);
  spawn_bravo_team();
  level.alpha_and_bravo_team = scripts\engine\utility::array_combine(level.alpha_team, level.bravo_team);
}

function remove_ally(var0) {
  if(scripts\engine\utility::array_contains(level.alpha_and_bravo_team, var0)) {
    level.alpha_and_bravo_team = scripts\engine\utility::array_remove(level.alpha_and_bravo_team, var0);
  }

  if(scripts\engine\utility::array_contains(level.alpha_team, var0)) {
    level.alpha_team = scripts\engine\utility::array_remove(level.alpha_team, var0);
  }

  if(scripts\engine\utility::array_contains(level.bravo_team, var0)) {
    level.bravo_team = scripts\engine\utility::array_remove(level.bravo_team, var0);
    return;
  }
}

function ally_track_and_kill(var0, var1) {
  if(isalive(var0) || isai(var0) && var0 scripts\engine\utility::doinglongdeath()) {
    self.favoriteenemy = var0;
    self.ignoreall = 0;
    self.dontmelee = 1;
    self.tracking_enemy = 1;
    scripts\engine\utility::waittill_any_ents(level, var1, var0, "death");
    wait randomfloatrange(0.1, 0.4);
    self.dontevershoot = 0;
    shoot_and_kill(var0);
    self.ignoreall = 1;
    self.dontevershoot = 1;
    self.dontmelee = undefined;
    self.favoriteenemy = undefined;
    self.tracking_enemy = 0;
    return;
  }
}

function ally_track_and_kill_noteworthy(var0, var1) {
  var2 = getEnt(var0, "script_noteworthy");
  ally_track_and_kill(var2, var1);
}

function ally_tracking_enemy() {
  return istrue(self.tracking_enemy);
}

function shoot_and_kill(var0) {
  if(isalive(var0) || isai(var0) && var0 scripts\engine\utility::doinglongdeath()) {
    magicbullet(self.weapon, self gettagorigin("tag_flash"), var0 getEye(), self);
    var0 kill();
    return;
  }
}

function within_distance(var0, var1, var2) {
  return distancesquared(var0, var1) < squared(var2);
}

function within_distance2d(var0, var1, var2) {
  return distance2dsquared(var0, var1) < squared(var2);
}

function notify_within_distance(var0, var1, var2, var3, var4) {
  level endon(var4);

  while(!within_distance(var0.origin, var1.origin, var2)) {
    waitframe();
  }

  level notify(var3);
}

function within_player_fov(var0, var1) {
  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = cos(getdvarfloat("MRNKTKLLKP"));
  }

  return scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var1, var2);
}

function within_player_fov_2d(var0, var1) {
  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = cos(getdvarfloat("MRNKTKLLKP"));
  }

  return scripts\engine\math::within_fov_2d(level.player getEye(), level.player getplayerangles(), var1, var2);
}

function get_closest_in_front(var0, var1) {
  var2 = undefined;

  foreach(var4 in var0) {
    if(scripts\engine\utility::within_fov(var4.origin, var4.angles, var1, 0)) {
      var4.test_dist = distance2d(var1, var4.origin);

      if(!isDefined(var2) || var2.test_dist > var4.test_dist) {
        var2 = var4;
      }
    }
  }

  return var2;
}

function setup_scripted_door(var0) {
  var1 = getEntArray(var0, "targetname");
  var1 = scripts\engine\utility::array_combine(var1, scripts\engine\utility::getStructArray(var0, "targetname"));
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;

  foreach(var9 in var1) {
    switch (var9.script_noteworthy) {
      case "clip":
        var3 = var9;
        break;
      case "open":
        var4 = var9;
        break;
      case "open_ccw":
        var5 = var9;
        break;
      case "closed":
        var6 = var9;
        break;
      case "door":
        var2 = var9;
        break;
      case "parent":
        var7 = var9;
        break;
    }
  }

  var2.clip = var3;
  var2.clip linkTo(var2);

  if(!isDefined(var4)) {
    var4 = spawnStruct();
    var4.origin = var2.origin;
    var4.angles = var2.angles;
  }

  var2.open = var4;

  if(!isDefined(var5)) {
    var5 = spawnStruct();
    var5.origin = var2.origin;
    var5.angles = var2.angles;
  }

  var2.openccw = var5;

  if(!isDefined(var6)) {
    var6 = spawnStruct();
    var6.origin = var2.origin;
    var6.angles = var2.angles;
  }

  var2.closed = var6;

  if(isDefined(var7)) {
    var7 linkTo(var2);
  }

  return var2;
}

function open_scripted_door(var0, var1, var2, var3, var4) {
  var5 = self.open;

  if(isDefined(var4) && var4) {
    var5 = self.openccw;
  }

  internal_move_scripted_door(var5.origin, var5.angles, var0, var1, var2, var3);
}

function close_scripted_door(var0, var1, var2, var3) {
  internal_move_scripted_door(self.closed.origin, self.closed.angles, var0, var1, var2, var3);
}

function internal_move_scripted_door(var0, var1, var2, var3, var4, var5) {
  self.clip connectpaths();
  self moveTo(var0, var2, var3, var4);
  self rotateTo(var1, var2, var3, var4);
  wait var2;

  if(istrue(var5)) {
    self.clip disconnectPaths();
    return;
  }
}

function move_to_point_with_angles(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var3)) {
    wait var3;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  self moveTo(var1, var0, var4, var5);

  if(isDefined(var2)) {
    self rotateTo(var2, var0, var4, var5);
  }

  wait var0;
}

function stub_move(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var4);

  if(isai(self)) {
    self.prev_anim_name = self.animname;
    self.animname = "stub_char";
    var4 thread scripts\common\anim::anim_loop_solo(self, "stub_idle", "stop_stub_anim_loop");
  }

  move_to_point_with_angles(var4, var0, var1, var2, var3);
  self unlink();

  if(isai(self)) {
    var4 notify("stop_stub_anim_loop");
    self stopanimScripted();
    self.animname = self.prev_anim_name;
  }

  var4 delete();
}

function stub_move_to_struct(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = "targetname";
  }

  var4 = scripts\engine\utility::getStruct(var1, var2);
  stub_move(var0, var4.origin, var4.angles, var3);
}

function stub_path_simple(var0, var1, var2) {
  var3 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var3);
  var4 = 1;
  var5 = [];
  var6 = scripts\engine\utility::getStruct(var1, "targetname");
  var5 = scripts\engine\utility::array_add(var5, var6);
  var7 = var6;

  for(var8 = 1; var8; var8 = 0) {
    if(isDefined(var7.target)) {
      var9 = scripts\engine\utility::getStruct(var7.target, "targetname");
      var5 = scripts\engine\utility::array_add(var5, var9);
      var4++;
      var7 = var9;
      continue;
    }
  }

  var10 = var0 / var4;

  if(isDefined(var2)) {
    wait var2;
  }

  foreach(var12 in var5) {
    move_to_point_with_angles(var3, var10, var12.origin, var12.angles, 1);
  }

  self unlink();
  var3 delete();
  self notify("stub_path_complete");
}

function stub_path_array(var0, var1) {
  foreach(var3 in var0) {
    var4 = scripts\engine\utility::getStruct(var3[0], "targetname");
    var5 = var3[1];
    var6 = var3[2];
    var7 = var3[3];
    self moveTo(var4.origin, var5, var6, var7);
    self rotateTo(var4.angles, var5, var6, var7);
    wait var5;
  }

  if(isDefined(var1)) {
    level notify(var1);
    return;
  }
}

function go_to_targetname(var0) {
  var1 = getnode(var0, "targetname");

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStruct(var0, "targetname");
  }

  if(!isDefined(var1.radius)) {
    var1.radius = 55;
  }

  scripts\sp\spawner::go_to_node(var1);
}

function go_to_node_targetname(var0) {
  scripts\sp\spawner::go_to_node(getnode(var0, "targetname"));
}

function go_to_struct_targetname(var0) {
  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct(var0, "targetname"));
}

function gasmask_on(var0) {
  level endon("removed_gasmask");

  if(!isDefined(var0)) {
    var0 = 0;
  }

  level.player scripts\sp\utility::allow_cg_drawcrosshair(0, "gasmask");
  level.player scripts\common\utility::allow_sprint(0, "gasmask");
  level.player scripts\common\utility::allow_melee(0, "gasmask");
  visor_anim(var0);
  level.player scripts\common\utility::allow_sprint(1, "gasmask");
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1, "gasmask");
  level.player scripts\common\utility::allow_melee(1, "gasmask");
  GscBinSkip4(0x6e, level.player);
}

function visor_anim(var0) {
  var1 = 0.001;

  if(istrue(var0)) {
    level.player scripts\engine\utility::delaycall(0.5, &setentitysoundcontext, "gender", "gasmask_male");
    visor_overlay(1, var1, 10, 45);
    return;
  } else {
    var1 = 0.12;
  }

  while(level.player.flashlightinuse) {
    waitframe();
  }

  scripts\engine\utility::flag_set("player_occupied");
  scripts\engine\utility::delaythread(2.5, &visor_overlay, 1, var1, 10, 45);
  var2 = mask_init();
  var3 = var2 scripts\engine\utility::getanim("player_mask_on");
  level.player thread scripts\engine\sp\utility::player_gesture_force("pxw_vm_gasmask_ges");
  var2 thread scripts\common\anim::anim_single_solo(var2, "player_mask_on");
  scripts\engine\utility::flag_wait("player_mask_on");
  level.player setentitysoundcontext("gender", "gasmask_male");
  var2 delete();
  scripts\engine\utility::flag_clear("player_occupied");
}

function visor_overlay(var0, var1, var2, var3) {
  if(!isDefined(level.gas_mask_overlay)) {
    level.gas_mask_overlay = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_delta2", 0);
    level.gas_mask_overlay.sort = -1;
  }

  level.gas_mask_overlay fadeovertime(var1);
  level.gas_mask_overlay.alpha = var0;
  level.player setdepthoffield(1, 200, 5000, 10000, 10, 0);
  level.player setviewmodeldepthoffield(4, 45, 6);
}

function mask_init() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("player_gasmask", (0, 0, 0));
  var0 hide();
  var0 notsolid();
  var0 dontinterpolate();
  var0 linktoplayerview(level.player, "j_wrist_le", (0, 0, 0), (0, 0, 0), 1, "none");
  var0 scripts\common\anim::anim_first_frame_solo(var0, "player_mask_on");
  var0 scripts\engine\utility::delaycall(0.3, &show);
  return var0;
}

function mask_death_function() {
  level endon("mission_fail");
  level endon("friendlyfire_mission_fail");
  scripts\engine\utility::waittill_any("death", "mission_fail", "friendlyfire_mission_fail");
  remove_mask_overlay();
}

function mask_fail_function() {
  level.player endon("death");
  level scripts\engine\utility::waittill_any("mission_fail", "friendlyfire_mission_fail");
  remove_mask_overlay();
}

function remove_mask_overlay() {
  if(isDefined(level.gas_mask_overlay)) {
    level.gas_mask_overlay fadeovertime(0.5);
    level.gas_mask_overlay.alpha = 0;
    wait 0.5;
    level.gas_mask_overlay destroy();
    return;
  }
}

function lerp_player_speed_scale(var0, var1) {
  if(!isDefined(level.player.speed_scale)) {
    level.player.speed_scale = 1;
  }

  var2 = level.player.speed_scale;
  var3 = (var0 - var2) / var1 * 0.05;

  while(var2 != var0) {
    var2 += var3;
    level.player setmovespeedscale(var2);
    level.player.speed_scale = var2;
    waitframe();
  }
}

function demeanor_hack() {
  self clearentitytarget();
  scripts\common\utility::lookatentity(self.aim_target);
  wait 20;
  scripts\common\utility::demeanor_override("combat");
  iprintlnbold("combat");
  wait 10;
  scripts\common\utility::demeanor_override("casual");
  iprintlnbold("casual");
  wait 10;
  scripts\common\utility::demeanor_override("casual_gun");
  iprintlnbold("casual_gun");
  wait 10;
  scripts\common\utility::demeanor_override("alert");
  iprintlnbold("alert");
  wait 10;
  scripts\common\utility::demeanor_override("cqb");
  iprintlnbold("cqb");
  wait 10;
  scripts\common\utility::demeanor_override("sprint");
  iprintlnbold("sprint");
  wait 10;
  scripts\common\utility::demeanor_override("frantic");
  iprintlnbold("frantic");
}

function can_flashlight_ai_see_player(var0) {
  if(!isDefined(self) || !isalive(self)) {
    return false;
  }

  var1 = distance2d(level.player.origin, self.origin);
  var2 = var1 < 100;

  if(!var0 || level.player getstance() == "stand") {
    var3 = var1 < 800;
  } else if(level.player getstance() == "crouch") {
    var3 = var2 < 400;
  } else {
    var3 = var3 < 200;
  }

  var3 &= scripts\engine\utility::within_fov(self.origin, self.angles, level.player.origin, cos(60));
  var3 &= scripts\engine\trace::ray_trace_passed(self gettagorigin("tag_flash"), level.player getEye(), [self, level.player], scripts\engine\trace::create_ainosight_contents());
  return var3 || var3;
}

function player_shining_light_at(var0, var1) {
  if(!isalive(var0)) {
    return 0;
  }

  if(!isDefined(var1)) {
    var1 = 1000;
  }

  var2 = level.player.flashlighton;
  var2 &= within_player_fov(var0 getEye());
  var2 &= within_distance(level.player.origin, var0.origin, var1);
  return var2;
}

function proxywar_timeout(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "timeout";
  }

  self endon("death");
  self endon("kill_checks");

  if(var0 > 0) {
    wait var0;
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(var1);
}

function enable_ally_vision() {
  self.ignoreme = 0;
  self.ignoreall = 0;
}

function enable_ally_firing() {
  self.dontevershoot = 0;
  self.disablepistol = 0;
}

function enable_allies_firing() {
  foreach(var1 in level.alpha_and_bravo_team) {
    enable_ally_vision(var1);
    enable_ally_firing(var1);
  }
}

function disable_ally_vision() {
  self.ignoreme = 1;
  self.ignoreall = 1;
}

function disable_ally_firing() {
  self.dontevershoot = 1;
  self.disablepistol = 1;
}

function disable_allies_firing() {
  foreach(var1 in level.alpha_and_bravo_team) {
    disable_ally_vision(var1);
    disable_ally_firing(var1);
  }
}

function allies_to_cqb() {
  foreach(var1 in level.alpha_team) {
    var1 scripts\common\utility::demeanor_override("cqb");
  }

  foreach(var1 in level.bravo_team) {
    var1 scripts\common\utility::demeanor_override("cqb");
  }
}

function allies_to_combat() {
  foreach(var1 in level.alpha_team) {
    var1 scripts\common\utility::demeanor_override("combat");
  }

  foreach(var1 in level.bravo_team) {
    var1 scripts\common\utility::demeanor_override("combat");
  }
}

function clear_allies_demeanor_override() {
  foreach(var1 in level.alpha_team) {
    var1 scripts\common\utility::clear_demeanor_override();
  }

  foreach(var1 in level.bravo_team) {
    var1 scripts\common\utility::clear_demeanor_override();
  }
}

function flag_wait_either_or_timeout(var0, var1, var2) {
  var3 = var2 * 1000;
  var4 = gettime();

  for(;;) {
    if(scripts\engine\utility::flag(var0) || scripts\engine\utility::flag(var1)) {
      break;
    }

    if(gettime() >= var4 + var3) {
      break;
    }

    var5 = var3 - gettime() - var4;
    var6 = var5 / 1000;
    wait_for_either_flag_or_time_elapses(var0, var1, var6);
  }
}

function wait_for_either_flag_or_time_elapses(var0, var1, var2) {
  level endon(var0);
  level endon(var1);
  wait var2;
}

function dialogue(var0, var1, var2, var3, var4, var5) {
  self endon("death");

  if(isDefined(var2) && isDefined(var3)) {
    if(!isarray(var2)) {
      var2 = [var2];
    }

    if(!isarray(var3)) {
      var3 = [var3];
    }

    foreach(var7 in var2) {
      foreach(var9 in var3) {
        var7 endon(var9);
      }
    }
  }

  if(isDefined(var1) && var1) {
    wait var1;
  }

  if(soundexists(var0)) {
    if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue(var0);
    } else if(istrue(var4)) {
      scripts\engine\sp\utility::smart_radio_dialogue(var0);
    } else {
      scripts\engine\sp\utility::smart_dialogue(var0);
    }

    self notify("dialogue_finished");
    return;
  }

  var12 = "";

  if(isPlayer(self)) {
    var12 = "Alex";
    var13 = "^2";
  } else if(isDefined(var12)) {
    var13 = "^3";
    var13 = var12;
  } else {
    var13 = self.name;

    if(scripts\engine\utility::is_equal(self.team, "axis")) {
      var13 = "^1";
    } else if(scripts\engine\utility::is_equal(self.team, "allies")) {
      var13 = "^2";
    } else {
      var13 = "^3";
    }
  }

  if(istrue(var13)) {
    var14 = var13 + var13 + " Over Radio" + ": " + "^7" + var4;
  } else {
    var14 = var14 + var13 + ": " + "^7" + var5;
  }

  thread dialogue_proc(var14, var12);
}

function dialogue_proc(var0, var1) {
  level notify("new_dialogue");
  var2 = 0.3;
  var3 = 3;
  var4 = 2;
  var5 = 1.2;
  var6 = int(5.9 * var5);
  var7 = int(24 * var5);
  var8 = 300;
  var9 = newhudelem();
  var10 = newhudelem();
  var11 = 350;
  var12 = int(max(var0.size * var6, var11));
  var13 = [var9, var10];
  scripts\engine\utility::array_thread(var13, &dialog_new_line_monitor);

  foreach(var15 in var13) {
    var15.alignx = "center";
    var15.aligny = "middle";
    var15.x = 320;
    var15.y = var8;
    var15.sort = 5;
  }

  var9.alpha = 0.5;
  var9 setshader("black", var12, var7);
  var10 settext(var0);
  var10.fontscale = var5;
  wait var3;

  foreach(var15 in var13) {
    var15 fadeovertime(var4);
    var15.alpha = 0;
  }

  wait var4;

  foreach(var15 in var13) {
    var15 destroy();
  }
}

function dialog_new_line_monitor() {
  self endon("death");

  for(;;) {
    level waittill("new_dialogue");
    self moveovertime(0.35);
    self.y += 30;
    waitframe();
  }
}

function move_to_arrive_then_idle(var0, var1, var2, var3) {
  level endon("kill_all_anim_instructions");
  level endon("end_move_and_idle");
  self endon("end_move_and_idle");

  if(!isDefined(var3)) {
    var3 = "end_move_and_idle";
  }

  var0 scripts\sp\anim::anim_reach_solo(self, var1);
  var0 scripts\common\anim::anim_single_solo(self, var1);

  if(isDefined(var0.arrivalcount)) {
    var0.arrivalcount++;
  } else {
    var0.arrivalcount = 1;
  }

  var0 thread scripts\common\anim::anim_loop_solo(self, var2, var3);
}

function play_group_single_anim_into_idle_anim(var0, var1, var2, var3, var4) {
  level endon("kill_all_anim_instructions");

  if(!isDefined(var4)) {
    var4 = 0;
  }

  foreach(var6 in self) {
    thread play_single_anim_into_idle_anim(var6, var0, var1, var2, var3);
  }
}

function play_single_anim_into_idle_anim(var0, var1, var2, var3, var4) {
  level endon("kill_all_anim_instructions");
  self endon("kill_self_anim_instructions");

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(var4) {
    var0 scripts\sp\anim::anim_reach_solo(self, var1);
  }

  var0 scripts\common\anim::anim_single_solo(self, var1);
  var0 thread scripts\common\anim::anim_loop_solo(self, var2, var3);

  if(isDefined(var0.arrivalcount)) {
    var0.arrivalcount++;
    return;
  }

  var0.arrivalcount = 1;
}

function get_struct_with_sight_to_player(var0) {
  foreach(var2 in var0) {
    if(scripts\engine\sp\utility::can_trace_to_player(var2.origin)) {
      return var2;
    }
  }

  return undefined;
}

function alarm_sound() {
  level endon("end_alarm");

  if(!scripts\engine\utility::flag("started_alarm")) {
    scripts\engine\utility::flag_set("started_alarm");
    var0 = scripts\engine\utility::getStruct("alleyway_alarm_sound", "targetname");
    var1 = scripts\engine\utility::spawn_script_origin(var0.origin, var0.angles);

    for(var2 = 0; var2 < 15; var2++) {
      var1 scripts\engine\utility::playsoundonentity("alarm_buzzer");
      wait 3;
    }

    return;
  }
}

function hint_crouch() {
  if(!level.player_crouched) {
    var0 = getkeybinding("+stance");

    if(level.player usinggamepad() || var0["count"] || !(level.player getlocalplayerprofiledata("crouchType") == 2)) {
      thread scripts\engine\sp\utility::display_hint("tut_crouch_hint", 15);
      return;
    }

    thread scripts\engine\sp\utility::display_hint("tut_crouch_hint_hold", 15);
    return;
  }
}

function hint_mount() {
  if(level.player scripts\sp\utility::get_mount_activation_mode() != "disabled") {
    var0 = 25;
    thread hint_mount_fx(var0);
    var1 = level.player scripts\sp\utility::get_mount_activation_mode();

    if(var1 == "mount_binding") {
      thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_binding_toggle", var0);
      return;
    }

    if(var1 == "mount_binding_hold") {
      thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_binding", var0);
      return;
    }

    if(level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledGamepad") || !level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledKeyboard")) {
      switch (var1) {
        case "double_ads":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_double_toggle", var0);
          break;
        case "ads":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_hold_toggle", var0);
          break;
        case "ads_sprint":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_sprint_toggle", var0);
          break;
        case "ads_activate":
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_activate_toggle", var0);
          break;
        default:
          thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_toggle", var0);
          break;
      }

      return;
    }

    switch (var1) {
      case "double_ads":
        thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_double", var0);
        break;
      case "ads":
        thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_hold", var0);
        break;
      case "ads_sprint":
        thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_sprint", var0);
        break;
      case "ads_activate":
        thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint_activate", var0);
        break;
      default:
        thread scripts\engine\sp\utility::display_hint_forced("tut_mount_hint", var0);
        break;
    }

    return;
  }
}

function hint_mount_fx(var0) {
  var1 = spawnStruct();
  var1.door = scripts\engine\utility::getStruct("mount_hint", "targetname");
  var1.door.angles = (0, 90, 0);
  var1.traincar = scripts\engine\utility::getStruct("mount_hint_traincar", "targetname");
  var1.traincar.angles = (0, 90, 0);
  var2 = undefined;
  var3 = gettime();
  var4 = 0;

  while(!scripts\engine\utility::time_has_passed(var3, var0) && level.player playermount() < 0.5) {
    if(!var4 && scripts\engine\utility::flag("player_inside_intro_room")) {
      if(isDefined(var2)) {
        var2 delete();
      }

      var2 = spawnfx(scripts\engine\utility::getfx("vfx_mount_hint_line"), var1.door.origin, anglesToForward(var1.door.angles));
      triggerfx(var2);
      var4 = 1;
    } else if(var4 && !scripts\engine\utility::flag("player_inside_intro_room")) {
      if(isDefined(var2)) {
        var2 delete();
      }

      var2 = spawnfx(scripts\engine\utility::getfx("vfx_mount_hint_line"), var1.traincar.origin, anglesToForward(var1.traincar.angles));
      triggerfx(var2);
      var4 = 0;
    }

    waitframe();
  }

  if(isDefined(var2)) {
    var2 delete();
    return;
  }
}

function hint_alt_fire_swap(var0) {
  var1 = level.player getcurrentweapon();
  var2 = getweaponbasename(var1);
  var3 = gettime();

  while(!scripts\engine\utility::time_has_passed(var3, var0) && var2 != "iw8_ar_mike4") {
    waitframe();
  }

  if(var1.isalternate && var2 == "iw8_ar_mike4") {
    thread scripts\engine\sp\utility::display_hint_forced("tut_alt_fire_hint_press", 15);
    return;
  }
}

function hint_grenade_throw() {
  while(isDefined(level.railyard_lmg) && !within_player_fov(level.railyard_lmg.og_origin)) {
    waitframe();
  }

  if(!level.player_threw_grenade) {
    thread scripts\sp\maps\proxywar\proxywar_vo::vo_rc_mg_grenade_hint();
    thread scripts\engine\sp\utility::display_hint("tut_grenade_hint", 15);
    return;
  }
}

function hint_weapon_swap() {
  wait 0.5;

  if(!level.player_swapped_weapon) {
    thread scripts\engine\sp\utility::display_hint("tut_swap_weapon_hint", 15);
    return;
  }
}

function set_flag_on_death(var0) {
  if(isalive(self)) {
    self waittill("death");
  }

  scripts\engine\utility::flag_set(var0);
}

function set_flag_on_death_or_damage(var0) {
  if(isalive(self)) {
    scripts\engine\utility::waittill_any("death", "damage");
  }

  scripts\engine\utility::flag_set(var0);
}

function ally_go_to_and_wait(var0, var1, var2) {
  if(!scripts\engine\utility::flag(var2)) {
    thread go_to_targetname(var0);
    var3 = scripts\engine\utility::waittill_any_ents_return(self, "reached_path_end", level, var2);

    if(var3 == "reached_path_end") {
      wait 1;
      scripts\engine\utility::flag_wait(var1);
      wait randomfloatrange(0, 0.5);
      return;
    }

    return;
  }
}

function anim_door(var0, var1) {
  var2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var2 scripts\engine\sp\utility::assign_animtree("door");
  var2 scripts\common\anim::anim_first_frame_solo(var2, var1);
  var0.temp_animator = var2;
  var0 linkTo(var2);

  if(isDefined(self.open_struct) && isDefined(self.open_struct.openinteract)) {
    var0 scripts\sp\door::remove_open_prompts();
    var0 scripts\game\sp\door::remove_door_snake_cam_ability();
  }

  scripts\common\anim::anim_single_solo(var2, var1);
  var0 scripts\sp\door::updatenavobstacle();
  var0 scripts\sp\door::clear_navobstacle();
  var0.open_completely = 1;
  var2 delete();
}

function anim_last_frame_door(var0, var1) {
  var2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var2 scripts\engine\sp\utility::assign_animtree("door");
  var2 scripts\common\anim::anim_first_frame_solo(var2, var1);
  var0.temp_animator = var2;
  var0 linkTo(var2);

  if(isDefined(self.open_struct) && isDefined(self.open_struct.openinteract)) {
    var0 scripts\sp\door::remove_open_prompts();
    var0 scripts\game\sp\door::remove_door_snake_cam_ability();
  }

  scripts\common\anim::anim_last_frame_solo(var2, var1);
  var0 scripts\sp\door::updatenavobstacle();
  var0 scripts\sp\door::clear_navobstacle();
  var0.open_completely = 1;
  var2 delete();
}

function stop_changing_scene_speed_while_offscreen(var0, var1) {
  self notify("stop_offscreen_anim_speed_changing");

  foreach(var3 in var0) {
    var3 setanimrate(var3 scripts\engine\utility::getanim(var1), 1);
  }
}

function change_scene_speed_while_offscreen(var0, var1, var2, var3) {
  self endon("stop_offscreen_anim_speed_changing");
  var1 endon(var2);
  var4 = undefined;
  var5 = undefined;

  for(;;) {
    foreach(var7 in var0) {
      if(isai(var7)) {
        var4 = within_player_fov(var7.origin) && level.player scripts\engine\utility::can_trace_to_ai(level.player getEye(), var7);
      } else {
        var4 = level.player scripts\engine\trace::can_see_origin(var7.origin);
      }

      if(var4) {
        break;
      }
    }

    if(!isDefined(var5)) {
      var5 = !var4;
    }

    if(var4 && !var5) {
      foreach(var7 in var0) {
        var7 setanimrate(var7 scripts\engine\utility::getanim(var2), 1);
      }
    } else if(!var4 && var5) {
      foreach(var7 in var0) {
        var7 setanimrate(var7 scripts\engine\utility::getanim(var2), var3);
      }
    }

    var5 = var4;
    waitframe();
  }
}

function slow_scene_speed_while_offscreen(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 0.2;
  }

  change_scene_speed_while_offscreen(var0, var1, var2, var3);
}

function quicken_scene_speed_while_offscreen(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 1.2;
  }

  change_scene_speed_while_offscreen(var0, var1, var2, var3);
}

function lerp_fov_over_distance_trigger() {
  var0 = strtok(self.script_parameters, " ");
  var1 = [];

  foreach(var3 in var0) {
    var1 = scripts\engine\utility::getStruct(var3, "targetname");
  }

  var5 = float(var1[0].script_parameters);
  var6 = float(var1[1].script_parameters);
  var7 = distance(var1[0].origin, var1[1].origin);

  for(;;) {
    if(!level.player istouching(self)) {
      self waittill("trigger");
    }

    while(level.player istouching(self)) {
      var8 = pointonsegmentnearesttopoint(var1[0].origin, var1[1].origin, level.player.origin);
      var9 = scripts\engine\math::normalize_value(0, var7, distance(var1[0].origin, var8));
      var10 = scripts\engine\math::factor_value(var5, var6, var9);
      level.player modifybasefov(var10, 0.05);

      if(level.player adsButtonPressed()) {
        wait 0.3;
      } else {
        level.player modifybasefov(var10, 0.05);
      }

      waitframe();
    }
  }
}

function change_ai_speed_while_offscreen(var0, var1) {
  self endon("stop_offscreen_movement_speed_changing");
  var2 = undefined;
  var3 = undefined;

  for(;;) {
    var2 = within_player_fov(self.origin) && level.player scripts\engine\utility::can_trace_to_ai(level.player getEye(), self);

    if(!isDefined(var3)) {
      var3 = !var2;
    }

    if(var2 && !var3) {
      scripts\engine\utility::set_movement_speed(var0);
    } else if(!var2 && var3) {
      scripts\engine\utility::set_movement_speed(var1);
    }

    var3 = var2;
    waitframe();
  }
}

function stop_changing_ai_speed_while_offscreen() {
  self notify("stop_offscreen_movement_speed_changing");
  scripts\common\utility::clear_movement_speed();
}

function notify_if_teleport_clear(var0, var1, var2, var3, var4) {
  level endon(var3);

  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  var5 = 0;

  while(!var5) {
    var5 = !level.player scripts\engine\trace::can_see_origin(var0 getEye(), 0) && !level.player scripts\engine\trace::can_see_origin(var1.origin + var4);
    var5 = var5 && !within_distance2d(level.player.origin, var0.origin, 200) && !within_distance2d(level.player.origin, var1.origin + var4, 200);
    var5 = var5 && scripts\engine\math::within_fov_2d(var1.origin, var1.angles, level.player.origin, 0);
    waitframe();
  }

  level notify(var2);
}

function teleport_if_clear(var0, var1, var2, var3) {
  level endon(var2);

  if(!isDefined(var3)) {
    var3 = (0, 0, 0);
  }

  var4 = cos(getdvarfloat("MRNKTKLLKP") + 10);
  var5 = 0;

  while(!var5) {
    if(!within_distance2d(level.player.origin, self.origin, 200) && !within_distance2d(level.player.origin, var0.origin + var3, 200) && !within_player_fov_2d(level.player, self getEye(), var4) && !within_player_fov_2d(level.player, var0.origin + var3, var4) && scripts\engine\math::within_fov_2d(var0.origin, var0.angles, level.player.origin, 0)) {
      var5 = 1;
    }

    waitframe();
  }

  self forceteleport(var0.origin, var0.angles, 90000000);
}

function set_wind(var0, var1, var2, var3, var4) {
  setsaveddvar("MRNRKKOPLN", var0);
  setsaveddvar("OLSKLTPPMR", var1);
  setsaveddvar("MQPQKNPQOK", var2);
  setsaveddvar("LQLSPQOPKM", var3);
  setsaveddvar("NQTLPTNSSO", var4);
}

function ramp_wind(var0, var1, var2, var3, var4, var5) {
  scripts\engine\sp\utility::lerp_saveddvar("MRNRKKOPLN", var1, var0);
  scripts\engine\sp\utility::lerp_saveddvar("OLSKLTPPMR", var2, var0);
  scripts\engine\sp\utility::lerp_saveddvar("MQPQKNPQOK", var3, var0);
  scripts\engine\sp\utility::lerp_saveddvar("LQLSPQOPKM", var4, var0);
  scripts\engine\sp\utility::lerp_saveddvar("NQTLPTNSSO", var5, var0);
}

function give_spotter_scope() {
  level.player.binoculars = scripts\sp\utility::make_weapon("iw8_spotter_scope", ["spotterscope_nvg"]);
  level.player giveweapon(level.player.binoculars);
  level.player childthread scripts\engine\sp\utility::actionslotoverride(1, "hud_icon_equipment_spotter_scope", undefined, &toggle_spotterscope);
  visionsetnight("nvg_proxywar_spotter", 0);
  thread monitor_spotterscope_equipped();
}

function monitor_spotterscope_equipped() {
  for(;;) {
    level.player waittill("weapon_change");

    if(level.player getcurrentweapon().basename == "iw8_spotter_scope") {
      thread monitor_spotterscope_nvg();

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

    if(scripts\engine\utility::flag("nvg_on")) {
      scripts\engine\utility::flag_clear("nvg_on");
    }

    scripts\engine\utility::flag_clear("equipped_spotter_scope");
  }
}

function monitor_spotterscope_nvg() {
  level endon("nvg_off");

  for(;;) {
    while(level.player playerads() < 1) {
      waitframe();
    }

    scripts\engine\utility::flag_set("nvg_on");

    while(level.player playerads() == 1) {
      waitframe();
    }

    scripts\engine\utility::flag_clear("nvg_on");
  }
}

function toggle_spotterscope() {
  if(scripts\common\utility::is_weapon_switch_allowed()) {
    if(level.player getcurrentweapon().basename != "iw8_spotter_scope") {
      level.player.lastusedweapon = level.player getcurrentprimaryweapon();
      level.player.lastusedweaponisalt = level.player isalternatemode(level.player.lastusedweapon);
      level.player switchtoweapon(level.player.binoculars);
      return;
    }

    var0 = level.player.lastusedweapon getaltweapon();

    if(level.player.lastusedweaponisalt && !nullweapon(var0)) {
      level.player switchtoweapon(var0);
      return;
    }

    level.player switchtoweapon(level.player.lastusedweapon);
    return;
  }
}

function nightvision_override(var0, var1, var2) {
  self setweaponhudiconoverride("actionslot" + var0, var1);

  if(isDefined(var2)) {
    thread nightvision_override_callback(var0, var2);
    return;
  }
}

function nightvision_override_callback(var0, var1) {
  self endon("death");
  self endon("removeActionslot" + var0);
  self notifyonplayercommand("flashlight", "nightvision");

  for(;;) {
    self waittill("flashlight");
    self thread[[var1]]();
  }
}

function give_flashlight() {
  level endon("kill_flashlight");
  level.player.flashlight = spawn("script_model", (0, 0, 0));
  level.player.flashlight setModel("tag_origin");
  level.player.flashlighton = 0;
  level.player.flashlightinuse = 0;
  level.player.flashlight linktoplayerview(level.player, "tag_cambone", (0, 0, 0), (0, 0, 0), 1);
  level.player childthread scripts\engine\sp\utility::actionslotoverride(2, "hud_icon_equipment_flashlight", undefined, &toggle_flashlight, 1);
  GscBinSkip4(0x6e, level.player, 2, "hud_icon_equipment_flashlight", &toggle_flashlight);
}

function toggle_flashlight() {
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
      return;
    }

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
    return;
  }
}

function kill_flashlight() {
  level notify("kill_flashlight");

  if(level.player.flashlighton) {
    level.player thread scripts\engine\sp\utility::player_gesture_force("iw8_vm_ges_helmet_light_sp");
    wait 0.75;
    killfxontag(scripts\engine\utility::getfx("vfx_flashlight_player"), level.player.flashlight, "tag_origin");
    return;
  }
}

function within_bounds(var0, var1, var2, var3, var4) {
  var5 = var2 - var0;

  if(isDefined(var4)) {
    var4 = vectorNormalize(var4);
    var6 = vectordot(var5, var4) * var4;
    var5 -= var6;
  }

  var7 = acos(vectordot(vectorNormalize(var5), vectorNormalize(var1)));
  return var7 <= var3;
}

function magic_gun_create_weapon(var0, var1, var2, var3, var4, var5) {
  setdvarifuninitialized("scr_magic_gun_draw_debug", 0);
  var6 = scripts\engine\sp\utility::spawn_anim_weapon(var0, var1, var2);
  var6.weapon = level.scr_weapon[var0][0];
  var6.curr_target = scripts\engine\utility::spawn_script_origin();
  var6.intended_target = var6 localtoworldcoords((100, 0, 0));
  var6.tracking_speed = var3;
  var6.og_origin = var6.origin;
  var6.og_angles = var6.angles;
  var6.max_angle_horiz = var4;
  var6.max_angle_vert = var5;
  thread internal_magic_gun_track_target();
  return var6;
}

function internal_magic_gun_track_target() {
  self endon("kill_magic_gun");

  for(;;) {
    var0 = self.intended_target - self.curr_target.origin;
    var1 = self.tracking_speed * 0.05;

    if(length(var0) < var1) {
      if(self.curr_target.origin != self.intended_target) {
        var2 = within_bounds(self.og_origin, anglesToForward(self.og_angles), self.intended_target, self.max_angle_horiz, anglestoup(self.og_angles));
        var3 = within_bounds(self.og_origin, anglesToForward(self.og_angles), self.intended_target, self.max_angle_vert, anglestoleft(self.og_angles));

        if(var2 && var3) {
          self.curr_target.origin = self.intended_target;
          self.angles = vectortoangles(vectorNormalize(self.curr_target.origin - self.origin));
        }

        self notify("reached_target");
      }
    } else {
      var0 = vectorNormalize(var0);
      var4 = self.curr_target.origin + var0 * var1;
      var2 = within_bounds(self.og_origin, anglesToForward(self.og_angles), var4, self.max_angle_horiz, anglestoup(self.og_angles));
      var3 = within_bounds(self.og_origin, anglesToForward(self.og_angles), var4, self.max_angle_vert, anglestoleft(self.og_angles));

      if(var2 && var3) {
        self.curr_target.origin = var4;
        self.angles = vectortoangles(vectorNormalize(self.curr_target.origin - self.origin));
      } else {
        self notify("reached_target");
      }
    }

    if(getdvarint("scr_magic_gun_draw_debug", 0)) {
      self.curr_target scripts\engine\utility::draw_ent_axis();
      scripts\engine\utility::draw_angles((0, 0, 0), self.intended_target);
      scripts\engine\utility::draw_ent_axis();
    }

    waitframe();
  }
}

function magic_gun_set_target(var0, var1) {
  self endon("kill_magic_gun");
  self notify("target_updated");
  self endon("target_updated");
  self.intended_target = var0;

  if(istrue(var1)) {
    self waittill("reached_target");
    return;
  }

  self.curr_target.origin = var0;
}

function magic_gun_clear_target() {
  magic_gun_set_target(self.og_origin + anglesToForward(self.og_angles) * 100);
}

function magic_gun_set_tracking_speed(var0) {
  self.tracking_speed = var0;
}

function magic_gun_fire(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("stop_firing");
  self endon("kill_magic_gun");

  if(!isDefined(var7)) {
    var7 = 1;
  }

  if(randomint(100) > 50) {
    var8 = -1;
  } else {
    var8 = 1;
  }

  if(randomint(100) > 50) {
    var9 = 1;
  } else {
    var9 = -1;
  }

  var10 = 50 * var8;
  var11 = 25 * var8;
  var12 = 50 * var8;
  var13 = 25 * var8;

  if(var4 == 0) {
    var10 = 0;
    var11 = 0;
    var12 = 0;
    var13 = 0;
    var14 = 0;
    var15 = 0;
  } else {
    var14 = var12 / var6;
    var15 = var14 / var6;
  }

  var16 = 0;
  var17 = randomfloatrange(var4, var5);

  while(var16 < var17) {
    var18 = randomfloatrange(var13, var12) * var10;
    var19 = randomfloatrange(var15, var14) * var11;
    var20 = (0, var18, var19);
    var21 = rotatevector(var20, self gettagangles("tag_flash"));
    magicbullet(self.weapon, self gettagorigin("tag_flash"), self.curr_target.origin + var21);
    var16++;
    var12 = clamp(var12 - var14, 1, var12);
    var13 = clamp(var13 - var14, 0, var12);
    var14 = clamp(var14 - var15, 1, var14);
    var15 = clamp(var15 - var15, 0, var14);

    if(randomint(100) > 50) {
      var10 = -1;
    } else {
      var10 = 1;
    }

    if(randomint(100) > 50) {
      var11 = 1;
    } else {
      var11 = -1;
    }

    wait randomfloatrange(var7, var8);
  }

  wait randomfloatrange(var8, var9);
}

function magic_gun_stop_firing() {
  self notify("stop_firing");
}

function magic_gun_delete() {
  self notify("kill_magic_gun");
  self delete();
}

function internal_mg_forward(var0) {
  return var0.origin - self.origin;
}

function internal_mg_left_vector(var0) {
  return vectorNormalize(vectorcross((0, 0, 1), var0));
}

function magic_gun_search_around_ent(var0, var1) {
  self endon("kill_magic_gun");
  self notify("stop_search");
  self endon("stop_search");

  if(randomint(100) > 50) {
    var2 = 1;
    goto LOC_00000038;
  }

  var2 = -1;

  for(;;) {
    var3 = internal_mg_forward(var1);
    var4 = internal_mg_left_vector(var3) * var2 * var2;
    var2 *= -1;
    magic_gun_set_target(self.origin + var3 + var4, 1);
    var3 = internal_mg_forward(var1);
    magic_gun_set_target(self.origin + var3, 1);
    var3 = internal_mg_forward(var1);
    var4 = internal_mg_left_vector(var3) * var2 * var2;
    var2 *= -1;
    magic_gun_set_target(self.origin + var3 + var4, 1);
    var3 = internal_mg_forward(var1);
    magic_gun_set_target(self.origin + var3, 1);
    waitframe();
  }
}

function magic_gun_stop_search_around() {
  self notify("stop_search");
}

function magic_gun_track_ent(var0, var1, var2) {
  self endon("kill_magic_gun");
  self notify("stop_tracking");
  self endon("stop_tracking");

  if(!isDefined(var2)) {
    var2 = 0;
  }

  jumpiftrue(isDefined(var1)) LOC_0000002e;
  var1 = "tag_origin";

  for(;;) {
    if(var2) {
      var3 = var0 getEye();
    } else {
      var3 = var0 gettagorigin(var1);
    }

    thread magic_gun_set_target(var3, 1);
    waitframe();
  }
}

function magic_gun_stop_tracking() {
  self notify("stop_tracking");
}

function die_when_offscreen_and_distant() {
  self endon("death");

  while(within_player_fov(self.origin) || within_distance2d(self.origin, level.player.origin, 600)) {
    wait 0.1;
  }

  self.diequietly = 1;
  scripts\engine\sp\utility::die();
}

function anim_single_solo_end_notify(var0, var1, var2, var3, var4, var5) {
  scripts\common\anim::anim_single_solo(var1, var2, var3, var4, var5);
  var1 notify(var0);
}

function halligan_stow() {
  if(isDefined(self.halligan_stowed) && !self.halligan_stowed) {
    self detach(scripts\engine\sp\utility::getmodel("halligan"), "tag_accessory_right");
  }

  self attach(scripts\engine\sp\utility::getmodel("halligan"), "tag_stowed_back");
  self.halligan_stowed = 1;
}

function halligan_draw() {
  if(istrue(self.halligan_stowed)) {
    self detach(scripts\engine\sp\utility::getmodel("halligan"), "tag_stowed_back");
  }

  self attach(scripts\engine\sp\utility::getmodel("halligan"), "tag_accessory_right");
  self.halligan_stowed = 0;
}

function set_ignoreme_after_time(var0, var1) {
  self endon("death");
  wait var1;
  self.ignoreme = var0;
}

function increase_attacker_accuracy(var0) {
  self endon("death");
  var1 = 1 - self.attackeraccuracy;
  var2 = var1 / var0;

  while(self.attackeraccuracy < 1) {
    self.attackeraccuracy += var2 * 0.05;
    waitframe();
  }

  self.attackeraccuracy = 1;
}

function delete_on_ent_notify(var0, var1) {
  var0 waittill(var1);
  self delete();
}

function cursor_hint_unusable_think() {
  self endon("trigger");
  self endon("hint_destroyed");
  var0 = 1;

  for(;;) {
    var1 = scripts\engine\sp\utility::get_player_demeanor() == "normal" && level.player isgestureplaying() || !isalive(level.player) || level.player ismeleeing();

    if(var0 && var1) {
      self.cursor_hint_ent makeunusable();
      var0 = 0;
    } else if(!var0 && !var1) {
      self.cursor_hint_ent makeusable();
      var0 = 1;
    }

    waitframe();
  }
}

function set_ally_movement_pre_breach(var0) {
  if(var0 && scripts\engine\math::is_point_in_front(level.player.origin)) {
    var1 = int(scripts\engine\math::remap(distance2d(level.player.origin, self.origin), 300, 400, 0, 140));
    var1 = clamp(var1, 0, 140);
  } else {
    var1 = 0;
  }

  if(scripts\engine\utility::array_contains(level.alpha_team, self)) {
    scripts\engine\utility::set_movement_speed(randomintrange(90, 110) + var1);
    return;
  }

  scripts\engine\utility::set_movement_speed(randomintrange(60, 80) + var1);
}

function set_ally_movement_courtyard() {
  if(isDefined(level.courtyarddefendgroup) && level.courtyarddefendgroup.size <= 0) {
    if(scripts\engine\math::is_point_in_front(level.player.origin)) {
      var0 = int(scripts\engine\math::remap(distance2d(level.player.origin, self.origin), 200, 400, 0, 140));
      var0 = clamp(var0, 0, 140);
    } else {
      var0 = 0;
    }

    if(self.script_noteworthy == "bravo3" || self.script_noteworthy == "bravo1") {
      scripts\engine\utility::set_movement_speed(randomintrange(60, 80) + var0);
      return;
    }

    scripts\engine\utility::set_movement_speed(randomintrange(90, 110) + var0);
    return;
  }
}