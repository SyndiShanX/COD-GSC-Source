/**************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_orbital_gravity_entangler.gsc
**************************************************************************/

init() {
  var_0 = common_scripts\utility::_id_46B5("orbital_gravity_entangler", "targetname");
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_0.radius = distance(var_0.origin, var_1.origin);
  var_2 = var_0 common_scripts\utility::_id_8FFC();
  var_2 _meth_805B();
  var_2 thread rotate_me();
  var_3 = var_0 common_scripts\utility::_id_8FFC();
  var_3 _meth_805B();
  var_3 thread rotate_me(1);
  level.oribital_rotator_1 = var_2;
  level.oribital_rotator_2 = var_3;
  add_entangler_fx();
  var_0.rotator = var_2;
  level thread maps\mp\_utility::_id_6F74(::watch_for_grenades_and_projectiles, var_0);
  level thread maps\mp\_utility::_id_6F74(::watchplayerjump);
  level.grenades_in_orbit = [];
  level thread watch_for_entanglements();
  level.zmb_all_side_ee_colors = [];
  level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "white";
  level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "yellow";
  level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "red";
  level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "blue";
  level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "green";
  level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "magenta";
  level.zmb_all_side_ee_colors[level.zmb_all_side_ee_colors.size] = "cyan";
}

get_color_for_grenade(var_0) {
  foreach(var_2 in level.zmb_all_side_ee_colors) {
    if(issubstr(var_0, var_2))
      return var_2;
  }

  return "";
}

watch_for_grab() {
  var_0 = self;
  var_0.grenadecolorsheld = [];

  for(;;) {
    waitframe();

    if(!var_0 _meth_8341()) {
      continue;
    }
    level.grenades_in_orbit = common_scripts\utility::_id_0FA0(level.grenades_in_orbit);
    var_1 = common_scripts\utility::_id_40B0(var_0.origin, level.grenades_in_orbit);
    var_1 = common_scripts\utility::_id_0FA0(var_1);

    if(var_1.size == 0) {
      continue;
    }
    if(!isDefined(var_1[0])) {
      continue;
    }
    if(_func_0E1(var_0.origin, var_1[0].origin) > 70) {
      continue;
    }
    _id_0586::_id_478A(var_0);
    var_0.grenadecolorsheld = common_scripts\utility::_id_0F6F(var_0.grenadecolorsheld, var_1[0]._id_3F74);
    var_1[0] remove_fake_projectile();
  }
}

watch_for_entanglements() {
  for(;;) {
    var_0 = [];
    level.grenades_in_orbit = common_scripts\utility::_id_0FA0(level.grenades_in_orbit);

    foreach(var_2 in level.grenades_in_orbit) {
      if(!isDefined(var_2)) {
        continue;
      }
      foreach(var_4 in level.grenades_in_orbit) {
        if(!isDefined(var_4)) {
          continue;
        }
        if(var_4 != var_2 && _func_0E1(var_4.origin, var_2.origin) < 60) {
          level.grenades_in_orbit = common_scripts\utility::_id_0F93(level.grenades_in_orbit, var_4);
          var_5 = get_hyper_color(var_2._id_3F74, var_4._id_3F74);

          if(isDefined(var_5))
            var_2 set_fx(var_5);
          else {
            var_2 _meth_8561(var_2._id_A9E0, var_2._id_0117, var_2);
            var_2 remove_fake_projectile();
          }

          var_4 remove_fake_projectile();
          break;
        }
      }
    }

    waitframe();
  }
}

watchplayerjump() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;)
    var_0 waittill("jumped");
}

rotate_me(var_0) {
  self endon("entitydeleted");

  for(;;) {
    var_1 = 1;

    if(common_scripts\utility::_id_562E(var_0))
      var_1 = -1;

    if(_func_279(self)) {
      return;
    }
    self _meth_82BA(var_1 * 180, 1);
    wait 1;
  }
}

remove_grenade_color() {
  var_0 = self;
  var_1 = var_0.grenadecolorsheld[0];

  if(var_0.grenadecolorsheld.size > 1)
    var_0.grenadecolorsheld = common_scripts\utility::_id_0FA3(var_0.grenadecolorsheld, 1);
  else
    var_0.grenadecolorsheld = [];

  return var_1;
}

watch_for_grenades_and_projectiles(var_0) {
  var_1 = self;
  var_2 = 1200;
  var_1 endon("disconnect");
  var_3 = var_0.radius;
  var_4 = var_0.origin;
  childthread watch_for_grab();
  var_5 = ["frag_grenade_zm", "c4_zm", "semtex_zm", "throwingknife_zm"];
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_survive_rush"));

  for(;;) {
    self waittill("grenade_fire", var_6, var_7);

    if(!common_scripts\utility::_id_0F79(var_5, var_7)) {
      continue;
    }
    if(_func_0AE(self.origin[2] - var_4[2]) > 60 || _func_0E1(var_6.origin, var_4) > var_3) {
      if(var_1.grenadecolorsheld.size > 0) {
        var_8 = var_6 spawn_a_fake_grenade(var_1, var_7);

        if(_func_279(var_8)) {
          continue;
        }
        var_8 set_fx(var_1 remove_grenade_color());
        var_8 thread move_no_gravity(var_1, var_2);
      }

      continue;
    }

    var_9 = get_is_facing_against_circle(var_1, var_4);
    var_8 = var_6 spawn_a_fake_grenade(var_1, var_7);

    if(!isDefined(var_8)) {
      continue;
    }
    if(var_9)
      var_8 linktosynchronizedparent(level.oribital_rotator_1);
    else
      var_8 linktosynchronizedparent(level.oribital_rotator_2);

    if(!isDefined(var_8)) {
      continue;
    }
    var_8._id_A9E0 = var_7;
    var_8._id_0117 = self;
    level.grenades_in_orbit = common_scripts\utility::_id_0F6F(level.grenades_in_orbit, var_8);
    var_8 thread handle_detonation(self, var_7);
  }
}

move_no_gravity(var_0, var_1) {
  var_2 = self;
  var_2 endon("entitydeleted");
  var_3 = var_0 getEye() + 10000 * vectorNormalize(anglesToForward(var_0 _meth_8566()));
  var_4 = var_0 getEye() + 32 * vectorNormalize(anglesToForward(var_0 _meth_8566()));
  var_5 = bulletTrace(var_4, var_3, 0);
  var_6 = var_5["position"];

  if(!isDefined(var_6))
    var_6 = var_3;

  var_7 = distance(var_0 getEye(), var_6) / var_1;
  var_2 _meth_82B1(var_6, var_7);
  wait(var_7);
  var_2.forcedetonate = 1;
}

spawn_a_fake_grenade(var_0, var_1) {
  if(!isDefined(level.zmb_gravity_grenades))
    level.zmb_gravity_grenades = [];

  var_2 = self;
  var_3 = var_2 common_scripts\utility::_id_8FFC();
  var_3 _meth_805B();
  var_3.angles = (30, 0, 15);
  var_4 = getzombielethalmodel(var_1);
  var_3 setModel(var_4);
  var_3 childthread seek_enemy_targets(var_0, var_1);
  var_3 childthread rotate_me();
  var_2 thread delay_delete();
  level.zmb_gravity_grenades = get_all_magical_grenades();
  level.zmb_gravity_grenades[level.zmb_gravity_grenades.size] = var_3;
  return var_3;
}

get_all_magical_grenades() {
  if(!isDefined(level.zmb_gravity_grenades))
    return [];

  var_0 = [];

  foreach(var_2 in level.zmb_gravity_grenades) {
    if(!_func_279(var_2))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

get_is_facing_against_circle(var_0, var_1) {
  var_2 = get_player_angle_flat();
  var_3 = (var_0.origin[0], var_0.origin[1], var_1[2]);
  var_4 = get_circle_angle_compare(var_3, var_1);
  var_5 = var_2 - var_4;
  var_6 = int(var_5 < -200 || var_5 <= 90 && var_5 >= 0);
  return !var_6;
}

get_player_angle_flat() {
  var_0 = common_scripts\utility::_id_3D5C(self _meth_8566());
  var_0 = var_0[1];
  return int(var_0);
}

get_circle_angle_compare(var_0, var_1) {
  var_2 = var_1[0] - var_0[0];
  var_3 = var_1[1] - var_0[1];
  var_4 = _func_1E3(var_3, var_2);
  return int(var_4);
}

handle_detonation(var_0, var_1) {
  self endon("entitydeleted");
  self.lethallevel = 0;
  set_fx("proj_trail_white");

  if(var_0.grenadecolorsheld.size > 0) {
    var_2 = var_0 remove_grenade_color();
    set_fx(var_2);
    return;
  }

  wait_frames(50);

  if(_func_279(self)) {
    return;
  }
  self.lethallevel++;
  set_fx("proj_trail_yellow");
  wait_frames(100);

  if(_func_279(self)) {
    return;
  }
  self.lethallevel++;
  set_fx("proj_trail_red");
  wait_frames(150);

  if(_func_279(self)) {
    return;
  }
  self.lethallevel++;
  set_fx("proj_trail_blue");
}

get_hyper_color(var_0, var_1) {
  var_2 = [var_0, var_1];

  if(_id_4B29("blue", var_2) && _id_4B29("yellow", var_2))
    return "proj_trail_green";

  if(_id_4B29("blue", var_2) && _id_4B29("red", var_2))
    return "proj_trail_magenta";

  if(_id_4B29("blue", var_2) && _id_4B29("green", var_2))
    return "proj_trail_cyan";
}

_id_4B29(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(issubstr(var_3, var_0))
      return 1;
  }

  return 0;
}

wait_frames(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++)
    waitframe();
}

set_fx(var_0) {
  if(isDefined(self.fx))
    self.fx delete();

  self._id_3F74 = var_0;
  self.fx = _func_2A8(common_scripts\utility::_id_44F5(var_0), self, "tag_fx");
  self.ee_color = get_color_for_grenade(var_0);
  _func_14C(self.fx);
}

seek_enemy_targets(var_0, var_1) {
  self endon("entitydeleted");
  var_2 = 0;
  var_3 = 800;

  while(!common_scripts\utility::_id_562E(self.forcedetonate) && var_3 > 0 && !var_2) {
    if(_func_279(self)) {
      return;
    }
    var_4 = _id_0547::_id_408F();

    foreach(var_6 in var_4) {
      if(distance(self.origin, var_6.origin) < 96) {
        var_2 = 1;
        break;
      }
    }

    var_3--;

    if(!var_2)
      waitframe();
  }

  if(_func_279(self)) {
    return;
  }
  if(_id_0547::_id_5565(var_1, "throwingknife_zm")) {
    if(!isDefined(self.lethallevel))
      self.lethallevel = 0;

    if(self.lethallevel == 0) {
      var_6 = common_scripts\utility::_id_4461(self.origin, _id_0547::_id_408F());

      if(isDefined(var_6) && distance(self.origin, var_6.origin) < 96) {
        var_6 _meth_8059(var_6.health + 1, self.origin, var_0, self, "MOD_MELEE", var_1);
        remove_fake_projectile();
        return;
      }
    } else
      var_1 = "frag_grenade_zm";
  }

  self _meth_8561(var_1, var_0, self);
  remove_fake_projectile();
}

remove_fake_projectile() {
  if(isDefined(self.fx))
    self.fx delete();

  self delete();
}

delay_delete() {
  self endon("entitydeleted");
  self _meth_8511();
  waitframe();
  self delete();
}

add_entangler_fx() {
  common_scripts\utility::_id_092C("proj_trail_white", "vfx/map/mp_zombie_descent/side_ee/proj_trail_white");
  common_scripts\utility::_id_092C("proj_trail_yellow", "vfx/map/mp_zombie_descent/side_ee/proj_trail_yellow");
  common_scripts\utility::_id_092C("proj_trail_red", "vfx/map/mp_zombie_descent/side_ee/proj_trail_red");
  common_scripts\utility::_id_092C("proj_trail_blue", "vfx/map/mp_zombie_descent/side_ee/proj_trail_blue");
  common_scripts\utility::_id_092C("proj_trail_green", "vfx/map/mp_zombie_descent/side_ee/proj_trail_green");
  common_scripts\utility::_id_092C("proj_trail_green_os", "vfx/map/mp_zombie_descent/side_ee/proj_trail_green_os");
  common_scripts\utility::_id_092C("proj_trail_magenta", "vfx/map/mp_zombie_descent/side_ee/proj_trail_magenta");
  common_scripts\utility::_id_092C("proj_trail_cyan", "vfx/map/mp_zombie_descent/side_ee/proj_trail_cyan");
  common_scripts\utility::_id_092C("zmb_ber_gun_cone_glow_pap", "vfx/map/mp_zombie_dig02/dlc_zmb_gun_cone_glow_pap");
}

getzombielethalmodel(var_0) {
  var_1 = "npc_usa_frag";

  switch (var_0) {
    case "frag_grenade_zm":
      var_1 = "npc_usa_frag";
      break;
    case "c4_zm":
      var_1 = "gen_satchel_charge";
      break;
    case "semtex_zm":
      var_1 = "npc_eng_n74_mk1_sticky";
      break;
    case "bouncingbetty_zm":
      var_1 = "npc_usa_frag";
      break;
    case "thermite_zm":
      var_1 = "npc_usa_frag";
      break;
    case "throwingknife_zm":
      var_1 = "projectile_usa_phantom_throwing_knife";
      break;
    case "thermite_flames_mp":
      var_1 = "npc_usa_frag";
      break;
    case "killstreak_carepackage_grenade_mp":
      var_1 = "npc_usa_frag";
      break;
    case "alt+wunderbuss_zm":
      var_1 = "npc_usa_frag";
      break;
    case "frag_grenade_funderbuss_zm":
      var_1 = "npc_usa_frag";
      break;
  }

  return var_1;
}