/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_db93c4bbed6e456.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace namespace_5443b356;

function autoexec main() {
  clientfield::register("toplayer", "player_cam_blur", 1, 1, "int");
  clientfield::register("toplayer", "player_cam_bubbles", 1, 1, "int");
  clientfield::register("toplayer", "player_cam_fire", 1, 1, "int");
}

function apply_firstperson_player_cam(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  self endon(#"disconnect");

  while(self util::isusingremote()) {
    wait 0.1;
  }

  if(getdvarint(#"test_cam", 0) > 0) {
    value = getdvarint(#"test_cam", 0);

    if(value == 1) {
      vdir = "MOD_BULLET";
    } else if(value == 2) {
      vdir = "MOD_EXPLOSIVE";
    } else if(value == 3) {
      vdir = "MOD_BURNED";
    } else if(value == 4) {
      vdir = "MOD_DROWN";
    } else if(value == 5) {
      self thread firstperson_player_cam_fall(idamage, smeansofdeath, weapon, shitloc, psoffsettime, deathanimduration);
      return;
    }
  }

  if(vdir === "MOD_EXPLOSIVE" || vdir === "MOD_PROJECTILE" || vdir === "MOD_PROJECTILE_SPLASH" || vdir === "MOD_GRENADE" || vdir === "MOD_GRENADE_SPLASH") {
    self thread firstperson_player_cam_explosion(idamage, smeansofdeath, weapon, shitloc, psoffsettime, deathanimduration);
    return;
  }

  if(vdir === "MOD_BULLET" || vdir === "MOD_RIFLE_BULLET" || vdir === "MOD_PISTOL_BULLET") {
    self thread firstperson_player_cam_bullet(idamage, smeansofdeath, weapon, shitloc, psoffsettime, deathanimduration);
    return;
  }

  if(vdir === "MOD_BURNED") {
    self thread firstperson_player_cam_burned(idamage, smeansofdeath, weapon, shitloc, psoffsettime, deathanimduration);
    return;
  }

  if(vdir === "MOD_DROWN") {
    self thread firstperson_player_cam_bubbles(idamage, smeansofdeath, weapon, shitloc, psoffsettime, deathanimduration);
    return;
  }

  if(isDefined(smeansofdeath) && smeansofdeath.classname == "trigger_hurt" && isDefined(smeansofdeath.script_noteworthy) && smeansofdeath.script_noteworthy == "fall_death") {
    self thread firstperson_player_cam_fall(idamage, smeansofdeath, weapon, shitloc, psoffsettime, deathanimduration);
    return;
  }

  if(vdir === "MOD_MELEE" || vdir === "MOD_MELEE_WEAPON_BUTT") {
    self thread firstperson_player_cam_melee(idamage, smeansofdeath, weapon, shitloc, psoffsettime, deathanimduration);
    return;
  }

  self thread firstperson_player_cam_suicide(idamage, smeansofdeath, weapon, shitloc, undefined, deathanimduration);
}

function function_c6491fb8() {
  self endon(#"disconnect");
  self thread function_f73fe25f();
}

function function_6f822dd3() {
  self endon(#"disconnect");
  self thread util::screen_message_create_client("<dev string:x38>", undefined, undefined, 200, 10000);
  wait 3;
  self thread util::screen_message_delete_client();
}

function get_trace(old_position, new_position) {
  size = 10;
  height = size * 2;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  trace = physicstrace(old_position, new_position, mins, maxs, self);
  return trace;
}

function function_26d91402(old_position, new_position) {
  trace = get_trace(old_position, new_position);
  return trace[#"position"];
}

function is_valid_new_pos(old_position, new_position) {
  trace = get_trace(old_position, new_position);

  if(trace[#"fraction"] < 1) {
    return false;
  }

  return true;
}

function is_falling(position) {
  return is_valid_new_pos(position, position + (0, 0, -500));
}

function movecamera(vdir, tweentime, max_f_length, max_z_length, position_f_speed, position_z_speed, camerapitch, cameraroll, lookdir, var_a571008b, var_eea7b52e) {
  self endon(#"disconnect", #"cp_deathcam_ended");
  epsilon = getdvarint(#"movecamera_epsilon", 2);
  original_position = self getplayercamerapos();
  position = original_position;
  angles = self getplayerangles();
  angles = (0, absangleclamp360(angles[1]), absangleclamp360(angles[2]));
  forwarddir = anglesToForward(angles);
  vector = position + forwarddir;

  if(isDefined(vdir)) {
    vdir *= -1;
    target_angles = vectortoangles(vdir);
  } else {
    vdir = (forwarddir[0], forwarddir[1], forwarddir[2]);
    target_angles = vectortoangles(vdir);
    vdir = (forwarddir[0], forwarddir[1], -1);
    vdir = vectorNormalize(vdir);
  }

  if(isDefined(lookdir)) {
    target_angles = vectortoangles(lookdir);
  }

  if(!isDefined(camerapitch)) {
    camerapitch = absangleclamp360(target_angles[0]);
  }

  if(!isDefined(cameraroll)) {
    cameraroll = absangleclamp360(target_angles[2]);
  }

  target_angles = (camerapitch, absangleclamp360(target_angles[1]), cameraroll);
  angles = (absangleclamp360(target_angles[0]), absangleclamp360(target_angles[1]), angleclamp180(target_angles[2]));

  if(isDefined(max_f_length) && vdir[0] != 0) {
    b_position_f = 0;
  } else {
    max_f_length = 0;
    position_f_speed = 0;
    b_position_f = 1;
  }

  if(isDefined(max_z_length) && vdir[2] != 0) {
    b_position_z = 0;
  } else {
    max_z_length = 0;
    position_z_speed = 0;
    b_position_z = 1;
  }

  forwardvec = (vdir[0], vdir[1], 0);
  forwardvec = vectorNormalize(forwardvec);

  while(!(is_true(b_position_f) && is_true(b_position_z))) {
    if(!is_true(b_position_f)) {
      added_vect = vectorscale(forwardvec, position_f_speed);
      added_length = length(added_vect);
      diff_forward_pos = position - original_position;
      current_forward_length = length((diff_forward_pos[0], diff_forward_pos[1], 0));

      if(current_forward_length + added_length >= max_f_length) {
        added_length = max_f_length - current_forward_length;
        b_position_f = 1;
      }

      new_position = position - vectorscale(forwardvec, added_length);
      var_d2ca9e9b = position - vectorscale(forwardvec, added_length + epsilon);

      if(is_valid_new_pos(position, var_d2ca9e9b)) {
        position = new_position;
      } else {
        b_position_f = 1;
      }
    }

    if(!is_true(b_position_z)) {
      subtracted_height = position_z_speed;
      current_z_length = abs(original_position[2] - position[2]);

      if(current_z_length + subtracted_height >= max_z_length) {
        subtracted_height = max_z_length - current_z_length;
        b_position_z = 1;
      }

      new_position = (position[0], position[1], position[2] - subtracted_height);
      var_d2ca9e9b = (position[0], position[1], position[2] - subtracted_height - epsilon);

      if(is_valid_new_pos(position, var_d2ca9e9b)) {
        position = new_position;
        continue;
      }

      b_position_z = 1;
    }
  }

  if(!is_valid_new_pos(original_position, position)) {
    position = function_26d91402(original_position, position);
  }

  self cameraactivate(1);
  is_falling = is_falling(position);

  if(is_true(var_a571008b) || !is_true(is_falling)) {
    if(tweentime > 0) {
      self startcameratween(tweentime, 1);
      self camerasetposition(position, angles);
      wait tweentime;
    } else {
      thread function_992fb1fd(position, angles, var_eea7b52e);
    }
  }

  if(is_true(is_falling)) {
    player_speed = self getvelocity()[2];
    var_eb5d6347 = length(position - original_position);
    var_40fa243f = var_eb5d6347 * tweentime;
    player_speed = max(player_speed, var_40fa243f);
    move_max_falling_height = getdvarint(#"move_max_falling_height", -2000);
    move_min_falling_speed = getdvarint(#"move_min_falling_speed", 500);
    var_4cd4f3fd = function_26d91402(position, position + (0, 0, move_max_falling_height));
    var_3cd7b116 = length(var_4cd4f3fd - position);
    var_80600e54 = (-88, absangleclamp360(angles[1]), 0);
    var_74a88e20 = max(player_speed, move_min_falling_speed);
    var_8c8446ec = var_3cd7b116 / var_74a88e20;
    self camerasetposition(var_4cd4f3fd, var_80600e54);
    self startcameratween(var_8c8446ec, 1);
    wait var_8c8446ec;
    function_eea7b52e(var_4cd4f3fd);
  }
}

function function_eea7b52e(position) {
  dc_quake_scale = getdvarfloat(#"dc_quake_scale", 0.4);
  dc_quake_duration = getdvarfloat(#"dc_quake_duration", 0.1);
  dc_quake_radius = getdvarfloat(#"dc_quake_radius", 5);
  earthquake(dc_quake_scale, dc_quake_duration, position, dc_quake_radius);
}

function function_992fb1fd(position, angles, var_eea7b52e) {
  self endon(#"disconnect");
  dc_drop_length = getdvarfloat(#"dc_drop_length", 10);
  var_6328d523 = position + (0, 0, dc_drop_length);
  self camerasetposition(var_6328d523, angles);
  waitframe(1);
  dc_drop_quickly_tween_time = getdvarfloat(#"dc_drop_quickly_tween_time", 0.1);
  self camerasetposition(position, angles);
  self startcameratween(dc_drop_quickly_tween_time, 1);
  wait dc_drop_quickly_tween_time;

  if(is_true(var_eea7b52e)) {
    function_eea7b52e(position);
  }
}

function function_e9de215e() {
  dot = vectordot(self getvelocity(), anglestoright(self.angles));

  if(dot > 0) {
    return 1;
  }

  return -1;
}

function firstperson_player_cam_bullet(einflictor, attacker, idamage, weapon, vdir, shitloc) {
  self endon(#"disconnect");
  self clientfield::set_to_player("player_cam_blur", 1);
  position_z_speed = getdvarfloat(#"cam_bullet_position_z_speed", 20);
  position_f_speed = getdvarfloat(#"cam_bullet_position_f_speed", 20);
  max_z_length = getdvarfloat(#"cam_bullet_max_z_length", 50);
  max_f_length = getdvarfloat(#"cam_bullet_max_f_length", 50);
  end_wait = getdvarfloat(#"cam_bullet_end_wait", 2.75);
  sign = self function_e9de215e();
  thread movecamera(shitloc, 0, max_f_length, max_z_length, position_f_speed, position_z_speed, undefined, 60 * sign, undefined, undefined, 1);
  self playRumbleOnEntity("damage_heavy");
  wait end_wait;
  self notify(#"cp_deathcam_ended");
}

function firstperson_player_cam_melee(einflictor, attacker, idamage, weapon, vdir, shitloc) {
  self endon(#"disconnect");
  self clientfield::set_to_player("player_cam_blur", 1);
  position_z_speed = getdvarfloat(#"cam_bullet_position_z_speed", 20);
  position_f_speed = getdvarfloat(#"cam_bullet_position_f_speed", 20);
  max_z_length = getdvarfloat(#"cam_bullet_max_z_length", 50);
  max_f_length = getdvarfloat(#"cam_bullet_max_f_length", 50);
  end_wait = getdvarfloat(#"cam_bullet_end_wait", 2.75);
  sign = self function_e9de215e();
  self playRumbleOnEntity("damage_heavy");
  thread movecamera(shitloc, 0, max_f_length, max_z_length, position_f_speed, position_z_speed, undefined, 60 * sign);
  wait end_wait;
  self notify(#"cp_deathcam_ended");
}

function firstperson_player_cam_suicide(einflictor, attacker, idamage, weapon, vdir, shitloc) {
  self endon(#"disconnect");
  self clientfield::set_to_player("player_cam_blur", 1);
  sign = self function_e9de215e();
  position_z_speed = getdvarfloat(#"cam_bullet_position_z_speed", 8);
  position_f_speed = getdvarfloat(#"cam_bullet_position_f_speed", 10);
  max_z_length = getdvarfloat(#"cam_bullet_max_z_length", 50);
  max_f_length = getdvarfloat(#"cam_bullet_max_f_length", 50);
  end_wait = getdvarfloat(#"cam_bullet_end_wait", 2.75);
  thread movecamera(undefined, 0, max_f_length, max_z_length, position_f_speed, position_z_speed, undefined, 60 * sign, undefined, undefined, 1);
  self playRumbleOnEntity("damage_heavy");
  wait end_wait;
  self notify(#"cp_deathcam_ended");
}

function firstperson_player_cam_explosion(einflictor, attacker, idamage, weapon, vdir, shitloc) {
  self endon(#"disconnect");
  self clientfield::set_to_player("player_cam_blur", 1);
  position_z_speed = getdvarfloat(#"cam_explosion_position_z_speed", 8);
  position_f_speed = getdvarfloat(#"cam_explosion_position_f_speed", 10);
  max_z_length = getdvarfloat(#"cam_explosion_max_z_length", 50);
  max_f_length = getdvarfloat(#"cam_explosion_max_f_length", 100);
  shake_vector_max = getdvarfloat(#"cam_explosion_shake_vector_max", 1);
  lookdir = undefined;

  if(isDefined(vdir) && vdir != self) {
    var_dca1ac5c = (vdir getabsmins() + vdir getabsmaxs()) * 0.5;
    lookdir = var_dca1ac5c - self.origin;
    lookdir = vectorNormalize(lookdir);
  }

  second_fade_value = getdvarfloat(#"cam_explosion_fade_value", 0);
  first_fade_time = getdvarfloat(#"cam_explosion_first_fade_time", 0.4);
  second_fade_time = getdvarfloat(#"cam_explosion_second_fade_time", 0.4);
  first_wait = getdvarfloat(#"cam_explosion_first_wait", 0.8);
  second_wait = getdvarfloat(#"cam_explosion_second_wait", 2);
  sign = self function_e9de215e();
  thread movecamera(shitloc, 0, max_f_length, max_z_length, position_f_speed, position_z_speed, undefined, 60 * sign, lookdir, undefined, 1);
  self playRumbleOnEntity("damage_heavy");
  wait second_wait;
  self notify(#"cp_deathcam_ended");
}

function firstperson_player_cam_burned(einflictor, attacker, idamage, weapon, vdir, shitloc) {
  self endon(#"disconnect");
  self clientfield::set_to_player("player_cam_fire", 1);
  angles = self getplayerangles();
  forwarddir = anglesToForward(angles);
  max_z_length = getdvarfloat(#"cam_explosion_max_z_length", 50);
  position_z_speed = getdvarfloat(#"cam_explosion_position_z_speed", 10);
  sign = self function_e9de215e();
  thread movecamera(undefined, 0.2, 0, max_z_length, 0, position_z_speed, undefined, 50 * sign, forwarddir);
  wait 2;
  self.fade_to_white = 1;
  self thread lui::screen_fade(1, 1, 0, "white", 0);
  wait 1;
  self notify(#"cp_deathcam_ended");
}

function firstperson_player_cam_bubbles(einflictor, attacker, idamage, weapon, vdir, shitloc) {
  self endon(#"disconnect");
  self clientfield::set_to_player("player_cam_bubbles", 1);
  angles = self getplayerangles();
  forwarddir = anglesToForward(angles);
  max_z_length = getdvarfloat(#"cam_explosion_max_z_length", 50);
  position_z_speed = getdvarfloat(#"cam_explosion_position_z_speed", 10);
  thread movecamera(undefined, 3, 0, max_z_length, 0, position_z_speed, undefined, undefined, forwarddir);
  bubbles_wait = getdvarfloat(#"cam_bubbles_wait", 3);
  wait bubbles_wait;
  self clientfield::set_to_player("player_cam_bubbles", 0);
  self notify(#"cp_deathcam_ended");
}

function firstperson_player_cam_fall(einflictor, attacker, idamage, weapon, vdir, shitloc) {
  self endon(#"disconnect");
  position_z_speed = getdvarfloat(#"cam_fall_position_z_speed", 500);
  position_f_speed = getdvarfloat(#"cam_fall_position_f_speed", 0);
  max_z_length = getdvarfloat(#"cam_fall_max_z_length", 500);
  max_f_length = getdvarfloat(#"cam_fall_max_f_length", 0);
  end_wait = getdvarfloat(#"cam_fall_end_wait", 2);
  thread movecamera(undefined, 1, undefined, max_z_length, 0, position_z_speed, -88, 1, undefined, 1, 1);
  wait end_wait;
  self notify(#"cp_deathcam_ended");
}

function function_f73fe25f() {
  self endon(#"disconnect");
  waitframe(1);
  self notify(#"cp_deathcam_ended");
}