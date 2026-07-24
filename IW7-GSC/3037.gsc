/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3037.gsc
**************************************/

_id_D1A2() {
  thread _id_A27A(1);
}

_id_A1F8(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "primary_default":
      var_1.class = "primary";
      var_1.weapon = "spaceship_30mm_projectile";
      var_1._id_13CDF = "spaceship_30mm_projectile";
      var_1._id_12B2A = 1;
      var_1._id_1151E = "jackal_30mm_hit_indicator";
      var_1._id_6CF8 = ::_id_A057;
      var_1._id_1106F = ::_id_A058;
      var_1._id_1136A = "jackal_wpn_mvmt_assault";
      var_1._id_134AE = "jackal_hud_gren_active";
      var_1._id_134C7 = 1.3;
      var_1._id_116B3 = 0.024;
      var_1._id_1167F = 1.0;
      var_1._id_1167D = 0.0095;
      var_1._id_1167E = 0.015;
      var_1._id_11680 = 0.009;
      var_1.loop_sound = 0;
      var_1._id_A5A6 = 0.0;
      var_1._id_A5A3 = -0.0;
      var_1._id_13C1D = ::_id_A395;
      var_1._id_13C08 = ::_id_A394;
      break;
    case "primary_upgrade_1":
      var_1.class = "primary";
      var_1.weapon = "spaceship_30mm_growler";
      var_1._id_13CDF = "spaceship_30mm_projectile";
      var_1._id_12B2A = 2;
      var_1._id_1151E = "jackal_30mm_hit_indicator";
      var_1._id_6CF8 = ::_id_A1F6;
      var_1._id_1106F = ::_id_A1F7;
      var_1._id_1136A = "jackal_wpn_mvmt_assault";
      var_1._id_134AE = "jackal_hud_dragonfly_active";
      var_1._id_134C7 = 1.3;
      var_1._id_116B3 = 0.03;
      var_1._id_1167F = 0.5;
      var_1._id_1167D = 0.016;
      var_1._id_1167E = 0.033;
      var_1._id_11680 = 0.02;
      var_1.loop_sound = 0;
      var_1._id_A5A6 = 0.35;
      var_1._id_A5A3 = -0.08;
      var_1._id_13C1D = ::_id_A39A;
      var_1._id_13C08 = ::_id_A399;
      var_1._id_105EF = 0.8;
      var_1._id_105EE = 3.0;
      var_1._id_105F0 = 1.6;
      var_1._id_5F0D = 1;
      break;
    case "primary_upgrade_2":
      var_1.class = "primary";
      var_1.weapon = "spaceship_30mm_slow";
      var_1._id_13CDF = "spaceship_30mm_projectile";
      var_1._id_12B2A = 3;
      var_1._id_1151E = "jackal_30mm_hit_indicator";
      var_1._id_6CF8 = ::_id_A268;
      var_1._id_1106F = ::_id_A269;
      var_1._id_1136A = "jackal_wpn_mvmt_assault";
      var_1._id_134AE = "jackal_hud_microlight_active";
      var_1._id_134C7 = 0.8;
      var_1._id_116B3 = 0.071;
      var_1._id_1167F = 1.0;
      var_1._id_1167D = 0.0095;
      var_1._id_1167E = 0.0135;
      var_1._id_11680 = 0.009;
      var_1.loop_sound = 0;
      var_1._id_A5A6 = 0.0;
      var_1._id_A5A3 = -0.0;
      var_1._id_13C1D = ::_id_A39E;
      var_1._id_13C08 = ::_id_A39D;
      var_1._id_105EF = 1.2;
      var_1._id_105EE = 0.9;
      var_1._id_105F0 = 1.0;
      break;
    case "secondary_default":
      var_1.class = "secondary";
      var_1.weapon = "spaceship_cannon_projectile";
      var_1._id_13CDF = "spaceship_cannon_projectile";
      var_1._id_12B2A = 4;
      var_1._id_1151E = "jackal_cannon_hit_indicator";
      var_1._id_6CF8 = ::_id_A05B;
      var_1._id_1106F = ::_id_A05C;
      var_1._id_1136A = "jackal_wpn_mvmt_strike";
      var_1._id_134AE = "jackal_hud_pathfinder_active";
      var_1._id_134C7 = 1.3;
      var_1._id_116B3 = 0.25;
      var_1._id_1167F = 2.0;
      var_1._id_1167D = 0.0049;
      var_1._id_1167E = 0.014;
      var_1._id_11680 = 0.003;
      var_1._id_A5A6 = 1.0;
      var_1._id_A5A3 = 0.0;
      var_1._id_13C1D = ::_id_A39C;
      var_1._id_13C08 = ::_id_A39B;
      var_1._id_105EE = 0.73;
      var_1._id_105F0 = 1.0;
      break;
    case "secondary_upgrade_1":
      var_1.class = "secondary";
      var_1.weapon = "spaceship_cleaver_projectile";
      var_1._id_13CDF = "spaceship_cannon_projectile";
      var_1._id_12B2A = 5;
      var_1._id_1151E = "jackal_cannon_hit_indicator";
      var_1._id_6CF8 = ::_id_A101;
      var_1._id_1106F = ::_id_A102;
      var_1._id_1136A = "jackal_wpn_mvmt_strike";
      var_1._id_134AE = "jackal_hud_cleaver_active";
      var_1._id_134C7 = 1.4;
      var_1._id_116B3 = 0.18;
      var_1._id_1167F = 1.0;
      var_1._id_1167D = 0.0052;
      var_1._id_1167E = 0.021;
      var_1._id_11680 = 0.008;
      var_1._id_A5A6 = 1.0;
      var_1._id_A5A3 = 0.0;
      var_1._id_13C1D = ::_id_A39C;
      var_1._id_13C08 = ::_id_A39B;
      var_1._id_105EF = 1.2;
      var_1._id_105EE = 1.0;
      var_1._id_105F0 = 1.0;
      break;
    case "secondary_upgrade_2":
      var_1.class = "secondary";
      var_1.weapon = "spaceship_anvil_projectile";
      var_1._id_13CDF = "spaceship_cannon_projectile";
      var_1._id_12B2A = 6;
      var_1._id_1151E = "jackal_cannon_hit_indicator";
      var_1._id_6CF8 = ::_id_A075;
      var_1._id_1106F = ::_id_A076;
      var_1._id_1136A = "jackal_wpn_mvmt_strike";
      var_1._id_134AE = "jackal_hud_anvil_active";
      var_1._id_134C7 = 1.0;
      var_1._id_116B3 = 0.12;
      var_1._id_1167F = 5.0;
      var_1._id_1167D = 0.004;
      var_1._id_1167E = 0.012;
      var_1._id_11680 = 0.003;
      var_1._id_A5A6 = 1.0;
      var_1._id_A5A3 = 0.0;
      var_1._id_13C1D = ::_id_A39C;
      var_1._id_13C08 = ::_id_A39B;
      var_1._id_5F0D = 1;
      var_1._id_105EF = 0.8;
      var_1._id_105EE = 0.73;
      var_1._id_105F0 = 1.8;
      break;
  }

  var_1._id_1167C = var_1._id_1167D;
  var_1._id_2841 = 0;
  var_1._id_2844 = 0;
  var_1._id_2842 = "ui_jackal_barrel_temp_" + var_1.class + "_L";
  var_1._id_2843 = "ui_jackal_barrel_temp_" + var_1.class + "_R";
  var_1._id_2847 = "ui_jackal_barrel_warn_" + var_1.class + "_L";
  var_1._id_2848 = "ui_jackal_barrel_warn_" + var_1.class + "_R";
  var_1._id_283B = "ui_jackal_barrel_overheat_" + var_1.class + "_L";
  var_1._id_283C = "ui_jackal_barrel_overheat_" + var_1.class + "_R";
  var_1._id_2846 = 0;
  var_1._id_2849 = 0;
  var_1._id_283A = 0;
  var_1._id_283D = 0;
  var_1._id_C7F8 = 0;
  var_1._id_A5A2 = 0.0;
  var_1._id_9DF4 = 0;
  return var_1;
}

_id_A057(var_0) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);

  if(!self.loop_sound) {
    level._id_D127._id_76F8 playLoopSound("jackal_gatling_fire_plr");
    self.loop_sound = 1;
  }

  earthquake(0.12, 0.76, level._id_D127.origin, 10000);
  wait 0.05;
  setomnvar("ui_jackal_firing", 0);
}

_id_A058() {
  level._id_D127._id_76F8 playSound("jackal_gatling_release_plr");
  self.loop_sound = 0;
  wait 0.05;

  if(isDefined(level._id_D127._id_76F8)) {
    level._id_D127._id_76F8 stoploopsound("jackal_gatling_fire_plr");
  }
}

_id_A268(var_0) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);

  if(var_0) {
    level._id_D127._id_6D2D playSound("jackal_microlite_space_left");
  } else {
    level._id_D127._id_6D2E playSound("jackal_microlite_space_right");
  }

  earthquake(0.16, 0.76, level._id_D127.origin, 10000);
  wait 0.1;
  setomnvar("ui_jackal_firing", 0);
}

_id_A269() {}

_id_A2CC(var_0) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  var_1 = level.player _meth_848A();

  if(isDefined(var_1) && isDefined(var_1[0]) && var_1[2] > 0.05) {
    var_2 = var_1[0];
  } else {
    var_2 = self._id_5F27;
  }

  playfxontagsbetweenclients(scripts\engine\utility::getfx("jackal_primary_energy"), level._id_D127, "tag_flash", var_2, "tag_origin");
  playfxontagsbetweenclients(scripts\engine\utility::getfx("jackal_primary_energy"), level._id_D127, "tag_flash_2", var_2, "tag_origin");
  var_3 = vectorNormalize(level._id_D127.origin - var_2.origin);
  var_4 = var_2.origin + 100 * var_3;
  var_2 dodamage(150, var_4, level._id_D127, undefined, "MOD_PROJECTILE", "spaceship_primary_energy_projectile");
  earthquake(0.09, 0.76, level._id_D127.origin, 10000);
  wait 0.05;
}

_id_A2CD() {}

_id_A059(var_0) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);
  var_1 = 30 * _id_7D75();
  var_2 = -5 * _id_7D5B();
  var_3 = 19 * _id_7D5B();
  var_4 = 13 * _id_7D5B();
  var_5 = 9 * _id_7D5B();

  if(var_0) {
    var_3 = var_3 * -1;
    var_5 = var_5 * -1;
  }

  var_6 = 0.15;

  if(var_1 > 0) {
    _id_0BDC::_id_A079(level._id_D127.origin + anglesToForward(level._id_D127.angles) * 500, var_1, 0.05, 3);
  }

  if(abs(var_2 + var_3) > 0) {
    _id_0BDC::_id_A07E((var_2, var_3, 0), 0.05, 0.5);
    _id_0BDC::_id_A07E((-0.5 * var_2, -0.5 * var_3, 0), 0.05, var_6 * 3.0);
  }

  if(abs(var_4 + var_5) > 0) {
    _id_0BDC::_id_A081((var_4, var_5, 0) * -1, 0.05, var_6);
  }

  earthquake(0.13, 0.76, level._id_D127.origin, 10000);
  wait 0.05;
  setomnvar("ui_jackal_firing", 0);
}

_id_A05A() {}

_id_A1F6(var_0) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);

  if(!self.loop_sound) {
    var_1 = 0.15;
    var_2 = 0.0;
    level._id_D127._id_76F8 _meth_8278(1, var_2);
    level._id_D127._id_76F8 _meth_8277(1, var_2);
    level._id_D127._id_76F8 playLoopSound("jackal_dragonfly_fire_plr");
    level._id_D127._id_76FA playLoopSound("jackal_dragonfly_mech_plr");
    level._id_D127._id_76F9 playSound("jackal_dragonfly_init_plr");
    self.loop_sound = 1;
    level._id_D127._id_76FA _meth_8278(1, var_1);
    level._id_D127._id_76FA _meth_8277(1, var_1);
  }

  var_3 = randomfloatrange(-5, 5) * _id_7D5B();
  var_4 = randomfloatrange(-5, 5) * _id_7D5B();
  var_5 = var_3 * 0.2;
  var_6 = var_4 * 0.2;
  var_7 = 0.15;

  if(abs(var_3 + var_4) > 0) {
    _id_0BDC::_id_A07E((var_3, var_4, 0), 0.05, 0.5);
    _id_0BDC::_id_A07E((-0.5 * var_3, -0.5 * var_4, 0), 0.05, var_7 * 3.0);
  }

  if(abs(var_5 + var_6) > 0) {
    _id_0BDC::_id_A081((var_5, var_6, 0) * -1, 0.05, var_7);
  }

  earthquake(0.15, 0.76, level._id_D127.origin, 10000);
  wait 0.05;
  setomnvar("ui_jackal_firing", 0);
}

_id_A1F7() {
  self._id_86A4 = undefined;
  level._id_D127._id_76F9 playSound("jackal_dragonfly_release_plr");
  thread _id_EBAA(level._id_D127._id_76F8, "jackal_dragonfly_fire_plr", 0.0);
  thread _id_EBAA(level._id_D127._id_76FA, "jackal_dragonfly_mech_plr", 0.2);
}

_id_EBAA(var_0, var_1, var_2) {
  var_0 endon("death");
  self endon("new_fire_func");
  var_0 _meth_8278(0, var_2);
  var_0 _meth_8277(0.8, var_2);
  wait(var_2);
  var_0 stoploopsound(var_1);
  self.loop_sound = 0;
}

_id_A05B(var_0) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);
  var_1 = 120 * _id_7D75();
  var_2 = -29 * _id_7D5B();
  var_3 = 2 * _id_7D5B();
  var_4 = 17 * _id_7D5B();
  var_5 = 13 * _id_7D5B();

  if(var_0) {
    var_3 = var_3 * -1;
    var_5 = var_5 * -1;
  }

  var_6 = 0.25;
  earthquake(0.23, 0.76, level._id_D127.origin, 10000);

  if(var_1 > 0) {
    _id_0BDC::_id_A079(level._id_D127.origin + anglesToForward(level._id_D127.angles) * 500, var_1, 0.05, 3);
  }

  if(abs(var_2 + var_3) > 0) {
    _id_0BDC::_id_A07E((var_2, var_3, 0), 0.05, 0.5);
    _id_0BDC::_id_A07E((-0.5 * var_2, -0.5 * var_3, 0), 0.05, var_6 * 3.0);
  }

  if(abs(var_4 + var_5) > 0) {
    _id_0BDC::_id_A081((var_4, var_5, 0) * -1, 0.05, var_6);
  }

  wait 0.1;
  setomnvar("ui_jackal_firing", 0);
}

_id_A05C() {}

_id_A101(var_0) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);
  var_1 = 120 * _id_7D75();
  var_2 = randomfloatrange(-11, 11) * _id_7D5B();
  var_3 = 3 * _id_7D5B();
  var_4 = -0.7 * var_2 * _id_7D5B();
  var_5 = 5 * _id_7D5B();

  if(var_0) {
    var_3 = var_3 * -1;
    var_5 = var_5 * -1;
  }

  var_6 = 0.25;
  earthquake(0.23, 0.76, level._id_D127.origin, 10000);

  if(var_1 > 0) {
    _id_0BDC::_id_A079(level._id_D127.origin + anglesToForward(level._id_D127.angles) * 500, var_1, 0.05, 3);
  }

  if(abs(var_2 + var_3) > 0) {
    _id_0BDC::_id_A07E((var_2, var_3, 0), 0.05, 0.5);
    _id_0BDC::_id_A07E((-0.5 * var_2, -0.5 * var_3, 0), 0.05, var_6 * 3.0);
  }

  if(abs(var_4 + var_5) > 0) {
    _id_0BDC::_id_A081((var_4, var_5, 0) * -1, 0.05, var_6);
  }

  wait 0.1;
  setomnvar("ui_jackal_firing", 0);
}

_id_A102() {}

_id_A075(var_0) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);
  var_1 = 240 * _id_7D75();
  var_2 = -65 * _id_7D5B();
  var_3 = 5 * _id_7D5B();
  var_4 = 52 * _id_7D5B();
  var_5 = 10 * _id_7D5B();

  if(randomint(2) > 1) {
    var_3 = var_3 * -1;
    var_5 = var_5 * -1;
  }

  var_6 = 0.25;
  earthquake(0.32, 0.76, level._id_D127.origin, 10000);

  if(var_1 > 0) {
    _id_0BDC::_id_A079(level._id_D127.origin + anglesToForward(level._id_D127.angles) * 500, var_1, 0.05, 3);
  }

  if(abs(var_2 + var_3) > 0) {
    _id_0BDC::_id_A07E((var_2, var_3, 0), 0.05, 0.5);
    _id_0BDC::_id_A07E((-0.5 * var_2, -0.5 * var_3, 0), 0.05, var_6 * 3.0);
  }

  if(abs(var_4 + var_5) > 0) {
    _id_0BDC::_id_A081((var_4, var_5, 0) * -1, 0.05, var_6);
  }

  wait 0.1;
  setomnvar("ui_jackal_firing", 0);
}

_id_A076() {}

_id_A39C() {}

_id_A39B() {}

_id_A395() {
  level._id_D127._id_76F8 = spawn("script_origin", level._id_D127.origin);
  level._id_D127._id_76F8 linkTo(level._id_D127, "tag_body", (0, 0, 0), (0, 0, 0));
}

_id_A394() {
  level._id_D127._id_76F8 delete();
}

_id_A39E() {
  level._id_D127._id_6D2D = spawn("script_origin", level._id_D127.origin);
  level._id_D127._id_6D2E = spawn("script_origin", level._id_D127.origin);
  level._id_D127._id_6D2D linkTo(level._id_D127, "tag_body", (0, 0, 0), (0, 0, 0));
  level._id_D127._id_6D2E linkTo(level._id_D127, "tag_body", (0, 0, 0), (0, 0, 0));
}

_id_A39D() {
  level._id_D127._id_6D2D delete();
  level._id_D127._id_6D2E delete();
}

_id_A39A() {
  level._id_D127._id_76F8 = spawn("script_origin", level._id_D127.origin);
  level._id_D127._id_76FA = spawn("script_origin", level._id_D127.origin);
  level._id_D127._id_76F9 = spawn("script_origin", level._id_D127.origin);
  level._id_D127._id_76F8 linkTo(level._id_D127, "tag_body", (0, 0, 0), (0, 0, 0));
  level._id_D127._id_76FA linkTo(level._id_D127, "tag_body", (0, 0, 0), (0, 0, 0));
  level._id_D127._id_76F9 linkTo(level._id_D127, "tag_body", (0, 0, 0), (0, 0, 0));
  level._id_D127._id_76FA _meth_8278(0, 0);
  level._id_D127._id_76FA _meth_8277(0.5, 0);
}

_id_A399() {
  level._id_D127._id_76F8 delete();
  level._id_D127._id_76FA delete();
  level._id_D127._id_76F9 delete();
}

_id_A398() {
  self._id_5F27 = scripts\engine\utility::spawn_tag_origin();
  self._id_5F27 _id_0BDC::_id_A25B(0, "tag_camera", (15000, 0, 0), (0, 0, 0), undefined, 1);
}

_id_A397() {
  self._id_5F27 delete();
}

_id_7D75() {
  return level._id_A056._id_BBB9["weapKick"]._id_3C66["weapKick"] * level._id_A056._id_EBAD * self._id_A5A2;
}

_id_7D5B() {
  return level._id_A056._id_BBB9["weapKick"]._id_3C66["weapKick"] * self._id_A5A2;
}

_id_6186(var_0, var_1) {
  self notify("emp_distortion");
  self endon("emp_distortion");
  level.player _meth_809A(1, 1);
  wait 0.05;

  for(var_2 = var_0; var_2 > 0; var_2 = var_2 - 0.05) {
    var_3 = var_2 / var_0 * var_1;
    level.player _meth_809A(var_3, 1);
    wait 0.05;
  }

  level.player _meth_809A(0, 1);
}

_id_7CAA(var_0) {
  return scripts\sp\hud_util::_id_48B7("overlay_static", var_0, level.player);
}

_id_10304() {
  var_0 = 0.72;
  thread _id_0BDC::_id_116A8("A drone flies in and gives the player some missiles.It's awesome!!", var_0);
  setslowmotion(1, 0.1, 0.5);
  wait(var_0);
  setslowmotion(0.1, 1, 0.5);
}

_id_A27A(var_0) {
  self endon("player_exit_jackal");
  _id_A2B4();
  _id_0BDC::_id_137DB();

  if(!isDefined(self.missiles)) {
    self.missiles = spawnStruct();
    self.missiles.active = 0;
    self.missiles._id_A928 = -999999;
    self.missiles._id_A8E8 = -9999999;
    level._id_D127 scripts\sp\utility::_id_65E0("player_jackal_missile");
  }

  _id_A27B();
  _id_A26A(var_0);
}

_id_A27B() {
  if(scripts\sp\utility::_id_D15B("weapons")) {
    self.missiles._id_B446 = 12;
  } else {
    self.missiles._id_B446 = 8;
  }

  self.missiles.count = self.missiles._id_B446;
  setomnvar("ui_jackal_missile_count", self.missiles.count);
  setomnvar("ui_jackal_missile_total", self.missiles._id_B446);
}

_id_A2B4() {
  self._id_B8AE = spawnStruct();
  self._id_B8AE._id_DCCA = 512;
  self._id_B8AE._id_B48B = 6000;
  self._id_B8AE._id_B758 = 200;
}

_id_A26A(var_0) {
  if(self.missiles.active != var_0) {
    self.missiles.active = var_0;
    setomnvar("ui_jackal_missile", var_0);

    if(var_0) {
      thread _id_A277();
    } else {
      self notify("jackal_missiles_off");
    }
  }
}

_id_A2D5() {
  var_0 = self.missiles._id_B446 - self.missiles.count;
  _id_A270(var_0);
  self notify("missiles_restocked");
}

_id_A277() {
  self endon("player_exit_jackal");
  self endon("jackal_missiles_off");
  var_0 = [-150, -75, 75, 150];
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    if(level.player fragButtonPressed() && !var_2 && !level.player scripts\sp\utility::_id_65DB("disable_jackal_missiles")) {
      if(self.missiles.count <= 0) {
        _id_A273();
      } else {
        level._id_D127 scripts\sp\utility::_id_65E1("player_jackal_missile");
        var_1 = _id_A275(var_0, var_1);
        level._id_D127 scripts\sp\utility::_id_65DD("player_jackal_missile");
      }
    }

    if(level.player fragButtonPressed()) {
      var_2 = 1;
    } else {
      var_2 = 0;
    }

    wait 0.05;
  }
}

_id_A275(var_0, var_1) {
  var_2 = 4;
  var_3 = undefined;
  var_4 = anglestoright(level._id_D127.angles);
  var_5 = anglestoup(level._id_D127.angles);
  var_6 = 1000;
  var_7 = (0, 0, 0);
  level.player playSound("jackal_missile_launch_space");

  while(var_2 > 0) {
    var_8 = undefined;

    if(var_2 == 4) {
      var_7 = var_6 * var_4;
    } else if(var_2 == 3) {
      var_7 = var_6 * var_5;
    } else if(var_2 == 2) {
      var_7 = var_6 * var_4 * -1;
    } else if(var_2 == 1) {
      var_7 = var_6 * var_5 * -1;
    }

    var_9 = level.player _meth_848A();

    if(isDefined(var_9) && isDefined(var_9[0])) {
      var_8 = var_9[0];

      if(!isDefined(var_3) || var_3 != var_9[0]) {
        var_8 scripts\sp\utility::_id_75C4("jackal_missile_tag", "tag_origin");
        thread _id_0BDC::_id_D527("missile_locked_2", var_8.origin, undefined, 2);
      }
    }

    _id_A274(var_8, var_0[var_1], var_7);
    var_1++;

    if(var_1 == var_0.size) {
      var_1 = 0;
    }

    var_2--;
    wait 0.1;
    var_3 = var_8;
  }

  _id_A270(-1);
  wait 0.5;
  return var_1;
}

_id_A274(var_0, var_1, var_2) {
  var_3 = 350;
  var_4 = -50;
  var_5 = self gettagorigin("j_mainroot_ship");
  var_6 = self gettagangles("j_mainroot_ship");
  var_7 = var_5 + anglesToForward(var_6) * var_3 + anglestoright(var_6) * var_1 + anglestoup(var_6) * var_4;
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.235, 0.9, level._id_D127.origin, 5000);

  if(isDefined(self._id_727D)) {
    var_0 = self._id_727D;
  }

  var_8 = scripts\engine\utility::spawn_tag_origin();
  var_8.origin = var_7;

  if(isDefined(var_0)) {
    var_9 = vectorNormalize(var_0.origin - var_5);
    var_8.angles = vectortoangles(var_9);
  } else
    var_8.angles = self.angles;

  if(isDefined(self._id_B83B)) {
    var_10 = self._id_B83B;
  } else {
    var_10 = "missile_flare_short";
  }

  if(isDefined(self._id_B803)) {
    var_11 = self._id_B803;
  } else {
    var_11 = undefined;
  }

  var_12 = 1000;

  if(isDefined(var_0)) {
    var_13 = 1;
  } else {
    var_13 = 0;
    var_0 = scripts\engine\utility::spawn_tag_origin();
    var_0._id_5F27 = 1;
    var_0.origin = _id_0BDC::_id_7B9B() + anglesToForward(_id_0BDC::_id_7B9F()) * randomintrange(35000, 65000);
  }

  var_14 = rotatevectorinverted(level._id_D127.spaceship_vel, level._id_D127.angles);
  var_14 = var_14[0] + 900;
  var_8._id_AA99 = "null";
  var_8 thread _id_0B76::_id_A332(var_0, 0, level._id_D127, var_10, var_12, var_2, undefined, var_11, var_14, undefined, 0.6);
  level._id_D127 notify("missile_fired", var_13);
}

_id_A148(var_0, var_1) {
  self endon("player_exit_jackal");
  var_0 _id_0BDC::_id_F2FF();
  var_2 = 10000;

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    var_0.origin = self.origin + anglesToForward(self.angles) * var_2;
    level.player waittill("on_player_update");
    var_2 = var_2 + var_1;
  }
}

_id_A276() {
  var_0 = level._id_D127 gettagorigin("tag_camera");
  var_1 = anglesToForward(level._id_D127 gettagangles("tag_camera"));
  var_2 = var_0 + var_1 * 500;
  var_3 = var_0 + var_1 * 50000;
  var_4 = bulletTrace(var_2, var_3, 0);
  return var_4;
}

_id_B838(var_0) {
  self endon("entitydeleted");
  var_1 = distance(self.origin, var_0.origin);
  var_2 = scripts\sp\math::_id_C097(5000, 12000, var_1);
  var_3 = scripts\sp\math::_id_6A8E(0, 0.5, var_2);
  wait(var_3);

  if(isDefined(var_0) && isvalidmissile(self) && isDefined(self)) {
    self missile_settargetEnt(var_0);
  }
}

_id_A273() {
  level.player playSound("jackal_ui_missile_empty");
  setomnvar("ui_jackal_missile_empty", gettime());
  wait 0.2;
}

_id_A270(var_0) {
  _id_0BDC::_id_82DD(var_0);

  if(self.missiles.count <= 0) {
    level._id_D127 notify("player_missiles_empty");
    self.missiles._id_A8E8 = gettime() + randomintrange(-5000, 5000);
  }

  thread _id_A271();
}

_id_A271() {
  self endon("jackal_missile_count_try_vo" + self.missiles.count);

  if(self.missiles.count < 5) {
    self notify("jackal_missile_count_try_vo" + (self.missiles.count + 1));
  }

  wait 1.5;

  if(self.missiles.count == 1) {
    _id_A26C("jackal_hud_1missileremaini");
  } else if(self.missiles.count == 15) {
    _id_A26C("jackal_hud_15missilesremai");
  } else if(self.missiles.count == 10) {
    _id_A26C("jackal_hud_10missilesremai");
  } else if(self.missiles.count == 5) {
    _id_A26C("jackal_hud_5missilesremain");
  } else if(self.missiles.count == 4) {
    _id_A26C("jackal_hud_4missilesremain");
  } else if(self.missiles.count == 3) {
    _id_A26C("jackal_hud_3missilesremain");
  } else if(self.missiles.count == 2) {
    _id_A26C("jackal_hud_2missilesremain");
  }
}

_id_A26C(var_0) {
  var_1 = gettime();

  if(var_1 - self.missiles._id_A928 < 5000) {
    return;
  }
  _id_0BDC::_id_A112(var_0, 2);
  self.missiles._id_A928 = var_1;
}