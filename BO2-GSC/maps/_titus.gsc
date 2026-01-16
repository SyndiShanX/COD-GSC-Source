/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_titus.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

autoexec init() {
  if(isassetloaded("weapon", "exptitus6_bullet_sp")) {
    precacheitem("exptitus6_bullet_sp");
    precacheitem("titus_explosive_dart_sp");
  }
}

magic_bullet_titus(v_end) {
  for(i = 0; i < 3; i++) {
    if(isDefined(self.titus)) {
      e_dart = magicbullet("exptitus6_bullet_sp", self.titus gettagorigin("tag_flash"), v_end + _titus_get_spread(40), self);
      self.titus playsoundontag("wpn_titus_fire_exp_npc", "tag_flash");
      e_dart thread _titus_reset_grenade_fuse();
      wait 0.032;
      continue;
    }

    e_dart = magicbullet("exptitus6_bullet_sp", self gettagorigin("tag_flash"), v_end + _titus_get_spread(40), self);
    self.titus playsoundontag("wpn_titus_fire_exp_npc", "tag_flash");
    e_dart thread _titus_reset_grenade_fuse();
    wait 0.032;
  }
}

_titus_fire_watcher() {
  self endon("death");

  while(true) {
    self waittill("weapon_fired", str_weapon);

    if(str_weapon == "exptitus6_sp")
      _titus_locate_target();
  }
}

_titus_locate_target() {
  fire_angles = self getplayerangles();
  fire_origin = self getplayercamerapos();
  a_targets = arraycombine(getaiarray("axis"), getvehiclearray("axis"), 0, 0);
  a_targets = get_array_of_closest(self.origin, a_targets, undefined, undefined, 1500);

  foreach(target in a_targets) {
    if(within_fov(fire_origin, fire_angles, target.origin, cos(30))) {
      if(isai(target)) {
        if(!isDefined(target.titusmarked)) {
          if(is_true(target.isbigdog)) {
            a_tags = [];
            a_tags[0] = "jnt_f_l_shoulder";
            a_tags[1] = "jnt_f_r_shoulder";
            a_tags[2] = "jnt_r_l_hip";
            a_tags[3] = "jnt_r_r_hip";
            a_tags[4] = "tag_body";
            str_tag = a_tags[randomint(a_tags.size)];
            b_trace_pass = bullettracepassed(fire_origin, target gettagorigin(str_tag), 1, self, target);

            if(b_trace_pass) {
              e_dart = magicbullet("exptitus6_bullet_sp", fire_origin, target gettagorigin(str_tag), self);
              e_dart thread _titus_reset_grenade_fuse(2, 4.5);
              target.titusmarked = 1;
              target thread _titus_marked();
              return;
            }
          } else {
            a_tags = [];
            a_tags[0] = "j_hip_le";
            a_tags[1] = "j_hip_ri";
            a_tags[2] = "j_spine4";
            a_tags[3] = "j_elbow_le";
            a_tags[4] = "j_elbow_ri";
            a_tags[5] = "j_clavicle_le";
            a_tags[6] = "j_clavicle_ri";
            str_tag = a_tags[randomint(a_tags.size)];
            b_trace_pass = bullettracepassed(fire_origin, target gettagorigin(str_tag), 1, self, target);

            if(b_trace_pass) {
              e_dart = magicbullet("exptitus6_bullet_sp", fire_origin, target gettagorigin(str_tag), self);
              e_dart thread _titus_reset_grenade_fuse(2, 4.5);
              target.titusmarked = 1;
              target thread _titus_marked();
              return;
            }
          }
        }
      } else if(target isvehicle() && !(target.vehicleclass == "plane")) {
        if(!isDefined(target.titusmarked)) {
          offsetpos = findboxcenter(target.mins, target.maxs);
          b_trace_pass = bullettracepassed(fire_origin, target.origin + offsetpos, 1, self, target);

          if(b_trace_pass) {
            offsetpos = offsetpos + _titus_get_spread(20);
            e_dart = magicbullet("exptitus6_bullet_sp", fire_origin, target.origin + offsetpos, self);
            e_dart thread _titus_reset_grenade_fuse(2, 4.5);
            target.titusmarked = 1;
            target thread _titus_marked();
            return;
          }
        }
      }
    }
  }

  vec = anglestoforward(fire_angles);
  trace_end = fire_origin + vec * 20000;
  trace = bullettrace(fire_origin, trace_end, 1, self);
  offsetpos = trace["position"] + _titus_get_spread(40);
  e_dart = magicbullet("exptitus6_bullet_sp", fire_origin, offsetpos, self);
  e_dart thread _titus_reset_grenade_fuse();
}

_titus_get_spread(n_spread) {
  n_x = randomintrange(n_spread * -1, n_spread);
  n_y = randomintrange(n_spread * -1, n_spread);
  n_z = randomintrange(n_spread * -1, n_spread);
  return (n_x, n_y, n_z);
}

_titus_marked() {
  self endon("death");
  self.titusmarked = 1;
  wait 1;
  self.titusmarked = undefined;
}

_titus_reset_grenade_fuse(n_fuse_min, n_fuse_max) {
  if(!isDefined(n_fuse_min))
    n_fuse_min = 2;

  if(!isDefined(n_fuse_max))
    n_fuse_max = 3;

  self waittill("death");
  a_grenades = getentarray("grenade", "classname");

  foreach(e_grenade in a_grenades) {
    if(e_grenade.model == "t6_wpn_projectile_titus" && !isDefined(e_grenade.fuse_reset)) {
      e_grenade.fuse_reset = 1;
      e_grenade resetmissiledetonationtime(randomfloatrange(n_fuse_min, n_fuse_max));
      return;
    }
  }
}