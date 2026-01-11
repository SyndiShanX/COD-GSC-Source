/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3037.gsc
***************************************/

func_D1A2() {
  thread func_A27A(1);
}

func_A1F8(var_00) {
  var_01 = spawnStruct();

  switch (var_00) {
    case "primary_default":
      var_1.class = "primary";
      var_1.weapon = "spaceship_30mm_projectile";
      var_1.func_13CDF = "spaceship_30mm_projectile";
      var_1.func_12B2A = 1;
      var_1.func_1151E = "jackal_30mm_hit_indicator";
      var_1.func_6CF8 = ::func_A057;
      var_1.func_1106F = ::func_A058;
      var_1.func_1136A = "jackal_wpn_mvmt_assault";
      var_1.func_134AE = "jackal_hud_gren_active";
      var_1.func_134C7 = 1.3;
      var_1.func_116B3 = 0.024;
      var_1.func_1167F = 1.0;
      var_1.func_1167D = 0.0095;
      var_1.func_1167E = 0.015;
      var_1.func_11680 = 0.009;
      var_1.loop_sound = 0;
      var_1.func_A5A6 = 0.0;
      var_1.func_A5A3 = -0.0;
      var_1.func_13C1D = ::func_A395;
      var_1.func_13C08 = ::func_A394;
      break;
    case "primary_upgrade_1":
      var_1.class = "primary";
      var_1.weapon = "spaceship_30mm_growler";
      var_1.func_13CDF = "spaceship_30mm_projectile";
      var_1.func_12B2A = 2;
      var_1.func_1151E = "jackal_30mm_hit_indicator";
      var_1.func_6CF8 = ::func_A1F6;
      var_1.func_1106F = ::func_A1F7;
      var_1.func_1136A = "jackal_wpn_mvmt_assault";
      var_1.func_134AE = "jackal_hud_dragonfly_active";
      var_1.func_134C7 = 1.3;
      var_1.func_116B3 = 0.03;
      var_1.func_1167F = 0.5;
      var_1.func_1167D = 0.016;
      var_1.func_1167E = 0.033;
      var_1.func_11680 = 0.02;
      var_1.loop_sound = 0;
      var_1.func_A5A6 = 0.35;
      var_1.func_A5A3 = -0.08;
      var_1.func_13C1D = ::func_A39A;
      var_1.func_13C08 = ::func_A399;
      var_1.func_105EF = 0.8;
      var_1.func_105EE = 3.0;
      var_1.func_105F0 = 1.6;
      var_1.func_5F0D = 1;
      break;
    case "primary_upgrade_2":
      var_1.class = "primary";
      var_1.weapon = "spaceship_30mm_slow";
      var_1.func_13CDF = "spaceship_30mm_projectile";
      var_1.func_12B2A = 3;
      var_1.func_1151E = "jackal_30mm_hit_indicator";
      var_1.func_6CF8 = ::func_A268;
      var_1.func_1106F = ::func_A269;
      var_1.func_1136A = "jackal_wpn_mvmt_assault";
      var_1.func_134AE = "jackal_hud_microlight_active";
      var_1.func_134C7 = 0.8;
      var_1.func_116B3 = 0.071;
      var_1.func_1167F = 1.0;
      var_1.func_1167D = 0.0095;
      var_1.func_1167E = 0.0135;
      var_1.func_11680 = 0.009;
      var_1.loop_sound = 0;
      var_1.func_A5A6 = 0.0;
      var_1.func_A5A3 = -0.0;
      var_1.func_13C1D = ::func_A39E;
      var_1.func_13C08 = ::func_A39D;
      var_1.func_105EF = 1.2;
      var_1.func_105EE = 0.9;
      var_1.func_105F0 = 1.0;
      break;
    case "secondary_default":
      var_1.class = "secondary";
      var_1.weapon = "spaceship_cannon_projectile";
      var_1.func_13CDF = "spaceship_cannon_projectile";
      var_1.func_12B2A = 4;
      var_1.func_1151E = "jackal_cannon_hit_indicator";
      var_1.func_6CF8 = ::func_A05B;
      var_1.func_1106F = ::func_A05C;
      var_1.func_1136A = "jackal_wpn_mvmt_strike";
      var_1.func_134AE = "jackal_hud_pathfinder_active";
      var_1.func_134C7 = 1.3;
      var_1.func_116B3 = 0.25;
      var_1.func_1167F = 2.0;
      var_1.func_1167D = 0.0049;
      var_1.func_1167E = 0.014;
      var_1.func_11680 = 0.003;
      var_1.func_A5A6 = 1.0;
      var_1.func_A5A3 = 0.0;
      var_1.func_13C1D = ::func_A39C;
      var_1.func_13C08 = ::func_A39B;
      var_1.func_105EE = 0.73;
      var_1.func_105F0 = 1.0;
      break;
    case "secondary_upgrade_1":
      var_1.class = "secondary";
      var_1.weapon = "spaceship_cleaver_projectile";
      var_1.func_13CDF = "spaceship_cannon_projectile";
      var_1.func_12B2A = 5;
      var_1.func_1151E = "jackal_cannon_hit_indicator";
      var_1.func_6CF8 = ::func_A101;
      var_1.func_1106F = ::func_A102;
      var_1.func_1136A = "jackal_wpn_mvmt_strike";
      var_1.func_134AE = "jackal_hud_cleaver_active";
      var_1.func_134C7 = 1.4;
      var_1.func_116B3 = 0.18;
      var_1.func_1167F = 1.0;
      var_1.func_1167D = 0.0052;
      var_1.func_1167E = 0.021;
      var_1.func_11680 = 0.008;
      var_1.func_A5A6 = 1.0;
      var_1.func_A5A3 = 0.0;
      var_1.func_13C1D = ::func_A39C;
      var_1.func_13C08 = ::func_A39B;
      var_1.func_105EF = 1.2;
      var_1.func_105EE = 1.0;
      var_1.func_105F0 = 1.0;
      break;
    case "secondary_upgrade_2":
      var_1.class = "secondary";
      var_1.weapon = "spaceship_anvil_projectile";
      var_1.func_13CDF = "spaceship_cannon_projectile";
      var_1.func_12B2A = 6;
      var_1.func_1151E = "jackal_cannon_hit_indicator";
      var_1.func_6CF8 = ::func_A075;
      var_1.func_1106F = ::func_A076;
      var_1.func_1136A = "jackal_wpn_mvmt_strike";
      var_1.func_134AE = "jackal_hud_anvil_active";
      var_1.func_134C7 = 1.0;
      var_1.func_116B3 = 0.12;
      var_1.func_1167F = 5.0;
      var_1.func_1167D = 0.004;
      var_1.func_1167E = 0.012;
      var_1.func_11680 = 0.003;
      var_1.func_A5A6 = 1.0;
      var_1.func_A5A3 = 0.0;
      var_1.func_13C1D = ::func_A39C;
      var_1.func_13C08 = ::func_A39B;
      var_1.func_5F0D = 1;
      var_1.func_105EF = 0.8;
      var_1.func_105EE = 0.73;
      var_1.func_105F0 = 1.8;
      break;
  }

  var_1.func_1167C = var_1.func_1167D;
  var_1.func_2841 = 0;
  var_1.func_2844 = 0;
  var_1.func_2842 = "ui_jackal_barrel_temp_" + var_1.class + "_L";
  var_1.func_2843 = "ui_jackal_barrel_temp_" + var_1.class + "_R";
  var_1.func_2847 = "ui_jackal_barrel_warn_" + var_1.class + "_L";
  var_1.func_2848 = "ui_jackal_barrel_warn_" + var_1.class + "_R";
  var_1.func_283B = "ui_jackal_barrel_overheat_" + var_1.class + "_L";
  var_1.func_283C = "ui_jackal_barrel_overheat_" + var_1.class + "_R";
  var_1.func_2846 = 0;
  var_1.func_2849 = 0;
  var_1.func_283A = 0;
  var_1.func_283D = 0;
  var_1.func_C7F8 = 0;
  var_1.func_A5A2 = 0.0;
  var_1.func_9DF4 = 0;
  return var_01;
}

func_A057(var_00) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);

  if(!self.loop_sound) {
    level.func_D127.func_76F8 playLoopSound("jackal_gatling_fire_plr");
    self.loop_sound = 1;
  }

  earthquake(0.12, 0.76, level.func_D127.origin, 10000);
  wait 0.05;
  setomnvar("ui_jackal_firing", 0);
}

func_A058() {
  level.func_D127.func_76F8 playSound("jackal_gatling_release_plr");
  self.loop_sound = 0;
  wait 0.05;

  if(isDefined(level.func_D127.func_76F8)) {
    level.func_D127.func_76F8 stoploopsound("jackal_gatling_fire_plr");
  }
}

func_A268(var_00) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);

  if(var_00) {
    level.func_D127.func_6D2D playSound("jackal_microlite_space_left");
  }
  else {
    level.func_D127.func_6D2E playSound("jackal_microlite_space_right");
  }

  earthquake(0.16, 0.76, level.func_D127.origin, 10000);
  wait 0.1;
  setomnvar("ui_jackal_firing", 0);
}

func_A269() {}

func_A2CC(var_00) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  var_01 = level.player _meth_848A();

  if(isDefined(var_01) && isDefined(var_1[0]) && var_1[2] > 0.05) {
    var_02 = var_1[0];
  }
  else {
    var_02 = self.func_5F27;
  }

  playfxontagsbetweenclients(scripts\engine\utility::getfx("jackal_primary_energy"), level.func_D127, "tag_flash", var_02, "tag_origin");
  playfxontagsbetweenclients(scripts\engine\utility::getfx("jackal_primary_energy"), level.func_D127, "tag_flash_2", var_02, "tag_origin");
  var_03 = vectornormalize(level.func_D127.origin - var_2.origin);
  var_04 = var_2.origin + 100 * var_03;
  var_02 getrandomarmkillstreak(150, var_04, level.func_D127, undefined, "MOD_PROJECTILE", "spaceship_primary_energy_projectile");
  earthquake(0.09, 0.76, level.func_D127.origin, 10000);
  wait 0.05;
}

func_A2CD() {}

func_A059(var_00) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);
  var_01 = 30 * func_7D75();
  var_02 = -5 * func_7D5B();
  var_03 = 19 * func_7D5B();
  var_04 = 13 * func_7D5B();
  var_05 = 9 * func_7D5B();

  if(var_00) {
    var_03 = var_03 * -1;
    var_05 = var_05 * -1;
  }

  var_06 = 0.15;

  if(var_01 > 0) {
    func_0BDC::func_A079(level.func_D127.origin + anglesToForward(level.func_D127.angles) * 500, var_01, 0.05, 3);
  }

  if(abs(var_02 + var_03) > 0) {
    func_0BDC::func_A07E((var_02, var_03, 0), 0.05, 0.5);
    func_0BDC::func_A07E((-0.5 * var_02, -0.5 * var_03, 0), 0.05, var_06 * 3.0);
  }

  if(abs(var_04 + var_05) > 0) {
    func_0BDC::func_A081((var_04, var_05, 0) * -1, 0.05, var_06);
  }

  earthquake(0.13, 0.76, level.func_D127.origin, 10000);
  wait 0.05;
  setomnvar("ui_jackal_firing", 0);
}

func_A05A() {}

func_A1F6(var_00) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);

  if(!self.loop_sound) {
    var_01 = 0.15;
    var_02 = 0.0;
    level.func_D127.func_76F8 ghostattack(1, var_02);
    level.func_D127.func_76F8 _meth_8277(1, var_02);
    level.func_D127.func_76F8 playLoopSound("jackal_dragonfly_fire_plr");
    level.func_D127.func_76FA playLoopSound("jackal_dragonfly_mech_plr");
    level.func_D127.func_76F9 playSound("jackal_dragonfly_init_plr");
    self.loop_sound = 1;
    level.func_D127.func_76FA ghostattack(1, var_01);
    level.func_D127.func_76FA _meth_8277(1, var_01);
  }

  var_03 = randomfloatrange(-5, 5) * func_7D5B();
  var_04 = randomfloatrange(-5, 5) * func_7D5B();
  var_05 = var_03 * 0.2;
  var_06 = var_04 * 0.2;
  var_07 = 0.15;

  if(abs(var_03 + var_04) > 0) {
    func_0BDC::func_A07E((var_03, var_04, 0), 0.05, 0.5);
    func_0BDC::func_A07E((-0.5 * var_03, -0.5 * var_04, 0), 0.05, var_07 * 3.0);
  }

  if(abs(var_05 + var_06) > 0) {
    func_0BDC::func_A081((var_05, var_06, 0) * -1, 0.05, var_07);
  }

  earthquake(0.15, 0.76, level.func_D127.origin, 10000);
  wait 0.05;
  setomnvar("ui_jackal_firing", 0);
}

func_A1F7() {
  self.func_86A4 = undefined;
  level.func_D127.func_76F9 playSound("jackal_dragonfly_release_plr");
  thread func_EBAA(level.func_D127.func_76F8, "jackal_dragonfly_fire_plr", 0.0);
  thread func_EBAA(level.func_D127.func_76FA, "jackal_dragonfly_mech_plr", 0.2);
}

func_EBAA(var_00, var_01, var_02) {
  var_00 endon("death");
  self endon("new_fire_func");
  var_00 ghostattack(0, var_02);
  var_00 _meth_8277(0.8, var_02);
  wait(var_02);
  var_00 stoploopsound(var_01);
  self.loop_sound = 0;
}

func_A05B(var_00) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);
  var_01 = 120 * func_7D75();
  var_02 = -29 * func_7D5B();
  var_03 = 2 * func_7D5B();
  var_04 = 17 * func_7D5B();
  var_05 = 13 * func_7D5B();

  if(var_00) {
    var_03 = var_03 * -1;
    var_05 = var_05 * -1;
  }

  var_06 = 0.25;
  earthquake(0.23, 0.76, level.func_D127.origin, 10000);

  if(var_01 > 0) {
    func_0BDC::func_A079(level.func_D127.origin + anglesToForward(level.func_D127.angles) * 500, var_01, 0.05, 3);
  }

  if(abs(var_02 + var_03) > 0) {
    func_0BDC::func_A07E((var_02, var_03, 0), 0.05, 0.5);
    func_0BDC::func_A07E((-0.5 * var_02, -0.5 * var_03, 0), 0.05, var_06 * 3.0);
  }

  if(abs(var_04 + var_05) > 0) {
    func_0BDC::func_A081((var_04, var_05, 0) * -1, 0.05, var_06);
  }

  wait 0.1;
  setomnvar("ui_jackal_firing", 0);
}

func_A05C() {}

func_A101(var_00) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);
  var_01 = 120 * func_7D75();
  var_02 = randomfloatrange(-11, 11) * func_7D5B();
  var_03 = 3 * func_7D5B();
  var_04 = -0.7 * var_02 * func_7D5B();
  var_05 = 5 * func_7D5B();

  if(var_00) {
    var_03 = var_03 * -1;
    var_05 = var_05 * -1;
  }

  var_06 = 0.25;
  earthquake(0.23, 0.76, level.func_D127.origin, 10000);

  if(var_01 > 0) {
    func_0BDC::func_A079(level.func_D127.origin + anglesToForward(level.func_D127.angles) * 500, var_01, 0.05, 3);
  }

  if(abs(var_02 + var_03) > 0) {
    func_0BDC::func_A07E((var_02, var_03, 0), 0.05, 0.5);
    func_0BDC::func_A07E((-0.5 * var_02, -0.5 * var_03, 0), 0.05, var_06 * 3.0);
  }

  if(abs(var_04 + var_05) > 0) {
    func_0BDC::func_A081((var_04, var_05, 0) * -1, 0.05, var_06);
  }

  wait 0.1;
  setomnvar("ui_jackal_firing", 0);
}

func_A102() {}

func_A075(var_00) {
  self notify("new_fire_func");
  self endon("new_fire_func");
  setomnvar("ui_jackal_firing", 1);
  var_01 = 240 * func_7D75();
  var_02 = -65 * func_7D5B();
  var_03 = 5 * func_7D5B();
  var_04 = 52 * func_7D5B();
  var_05 = 10 * func_7D5B();

  if(randomint(2) > 1) {
    var_03 = var_03 * -1;
    var_05 = var_05 * -1;
  }

  var_06 = 0.25;
  earthquake(0.32, 0.76, level.func_D127.origin, 10000);

  if(var_01 > 0) {
    func_0BDC::func_A079(level.func_D127.origin + anglesToForward(level.func_D127.angles) * 500, var_01, 0.05, 3);
  }

  if(abs(var_02 + var_03) > 0) {
    func_0BDC::func_A07E((var_02, var_03, 0), 0.05, 0.5);
    func_0BDC::func_A07E((-0.5 * var_02, -0.5 * var_03, 0), 0.05, var_06 * 3.0);
  }

  if(abs(var_04 + var_05) > 0) {
    func_0BDC::func_A081((var_04, var_05, 0) * -1, 0.05, var_06);
  }

  wait 0.1;
  setomnvar("ui_jackal_firing", 0);
}

func_A076() {}

func_A39C() {}

func_A39B() {}

func_A395() {
  level.func_D127.func_76F8 = spawn("script_origin", level.func_D127.origin);
  level.func_D127.func_76F8 linkto(level.func_D127, "tag_body", (0, 0, 0), (0, 0, 0));
}

func_A394() {
  level.func_D127.func_76F8 delete();
}

func_A39E() {
  level.func_D127.func_6D2D = spawn("script_origin", level.func_D127.origin);
  level.func_D127.func_6D2E = spawn("script_origin", level.func_D127.origin);
  level.func_D127.func_6D2D linkto(level.func_D127, "tag_body", (0, 0, 0), (0, 0, 0));
  level.func_D127.func_6D2E linkto(level.func_D127, "tag_body", (0, 0, 0), (0, 0, 0));
}

func_A39D() {
  level.func_D127.func_6D2D delete();
  level.func_D127.func_6D2E delete();
}

func_A39A() {
  level.func_D127.func_76F8 = spawn("script_origin", level.func_D127.origin);
  level.func_D127.func_76FA = spawn("script_origin", level.func_D127.origin);
  level.func_D127.func_76F9 = spawn("script_origin", level.func_D127.origin);
  level.func_D127.func_76F8 linkto(level.func_D127, "tag_body", (0, 0, 0), (0, 0, 0));
  level.func_D127.func_76FA linkto(level.func_D127, "tag_body", (0, 0, 0), (0, 0, 0));
  level.func_D127.func_76F9 linkto(level.func_D127, "tag_body", (0, 0, 0), (0, 0, 0));
  level.func_D127.func_76FA ghostattack(0, 0);
  level.func_D127.func_76FA _meth_8277(0.5, 0);
}

func_A399() {
  level.func_D127.func_76F8 delete();
  level.func_D127.func_76FA delete();
  level.func_D127.func_76F9 delete();
}

func_A398() {
  self.func_5F27 = scripts\engine\utility::spawn_tag_origin();
  self.func_5F27 func_0BDC::func_A25B(0, "tag_camera", (15000, 0, 0), (0, 0, 0), undefined, 1);
}

func_A397() {
  self.func_5F27 delete();
}

func_7D75() {
  return level.func_A056.func_BBB9["weapKick"].func_3C66["weapKick"] * level.func_A056.func_EBAD * self.func_A5A2;
}

func_7D5B() {
  return level.func_A056.func_BBB9["weapKick"].func_3C66["weapKick"] * self.func_A5A2;
}

func_6186(var_00, var_01) {
  self notify("emp_distortion");
  self endon("emp_distortion");
  level.player _meth_809A(1, 1);
  wait 0.05;

  for(var_02 = var_00; var_02 > 0; var_02 = var_02 - 0.05) {
    var_03 = var_02 / var_00 * var_01;
    level.player _meth_809A(var_03, 1);
    wait 0.05;
  }

  level.player _meth_809A(0, 1);
}

func_7CAA(var_00) {
  return scripts\sp\hud_util::func_48B7("overlay_static", var_00, level.player);
}

func_10304() {
  var_00 = 0.72;
  thread func_0BDC::func_116A8("A drone flies in and gives the player some missiles.It's awesome!!", var_00);
  setslowmotion(1, 0.1, 0.5);
  wait(var_00);
  setslowmotion(0.1, 1, 0.5);
}

func_A27A(var_00) {
  self endon("player_exit_jackal");
  func_A2B4();
  func_0BDC::func_137DB();

  if(!isDefined(self.missiles)) {
    self.missiles = spawnStruct();
    self.missiles.active = 0;
    self.missiles.func_A928 = -999999;
    self.missiles.func_A8E8 = -9999999;
    level.func_D127 scripts\sp\utility::func_65E0("player_jackal_missile");
  }

  func_A27B();
  func_A26A(var_00);
}

func_A27B() {
  if(scripts\sp\utility::func_D15B("weapons")) {
    self.missiles.func_B446 = 12;
  }
  else {
    self.missiles.func_B446 = 8;
  }

  self.missiles.count = self.missiles.func_B446;
  setomnvar("ui_jackal_missile_count", self.missiles.count);
  setomnvar("ui_jackal_missile_total", self.missiles.func_B446);
}

func_A2B4() {
  self.func_B8AE = spawnStruct();
  self.func_B8AE.func_DCCA = 512;
  self.func_B8AE.func_B48B = 6000;
  self.func_B8AE.func_B758 = 200;
}

func_A26A(var_00) {
  if(self.missiles.active != var_00) {
    self.missiles.active = var_00;
    setomnvar("ui_jackal_missile", var_00);

    if(var_00) {
      thread func_A277();
    }
    else {
      self notify("jackal_missiles_off");
    }
  }
}

func_A2D5() {
  var_00 = self.missiles.func_B446 - self.missiles.count;
  func_A270(var_00);
  self notify("missiles_restocked");
}

func_A277() {
  self endon("player_exit_jackal");
  self endon("jackal_missiles_off");
  var_00 = [-150, -75, 75, 150];
  var_01 = 0;
  var_02 = 0;

  for(;;) {
    if(level.player fragbuttonpressed() && !var_02 && !level.player scripts\sp\utility::func_65DB("disable_jackal_missiles")) {
      if(self.missiles.count <= 0) {
        func_A273();
      }
      else {
        level.func_D127 scripts\sp\utility::func_65E1("player_jackal_missile");
        var_01 = func_A275(var_00, var_01);
        level.func_D127 scripts\sp\utility::func_65DD("player_jackal_missile");
      }
    }

    if(level.player fragbuttonpressed()) {
      var_02 = 1;
    }
    else {
      var_02 = 0;
    }

    wait 0.05;
  }
}

func_A275(var_00, var_01) {
  var_02 = 4;
  var_03 = undefined;
  var_04 = anglestoright(level.func_D127.angles);
  var_05 = anglestoup(level.func_D127.angles);
  var_06 = 1000;
  var_07 = (0, 0, 0);
  level.player playSound("jackal_missile_launch_space");

  while(var_02 > 0) {
    var_08 = undefined;

    if(var_02 == 4) {
      var_07 = var_06 * var_04;
    }
    else if(var_02 == 3) {
      var_07 = var_06 * var_05;
    }
    else if(var_02 == 2) {
      var_07 = var_06 * var_04 * -1;
    }
    else if(var_02 == 1) {
      var_07 = var_06 * var_05 * -1;
    }

    var_09 = level.player _meth_848A();

    if(isDefined(var_09) && isDefined(var_9[0])) {
      var_08 = var_9[0];

      if(!isDefined(var_03) || var_03 != var_9[0]) {
        var_08 scripts\sp\utility::func_75C4("jackal_missile_tag", "tag_origin");
        thread func_0BDC::func_D527("missile_locked_2", var_8.origin, undefined, 2);
      }
    }

    func_A274(var_08, var_0[var_01], var_07);
    var_1++;

    if(var_01 == var_0.size) {
      var_01 = 0;
    }

    var_2--;
    wait 0.1;
    var_03 = var_08;
  }

  func_A270(-1);
  wait 0.5;
  return var_01;
}

func_A274(var_00, var_01, var_02) {
  var_03 = 350;
  var_04 = -50;
  var_05 = self gettagorigin("j_mainroot_ship");
  var_06 = self gettagangles("j_mainroot_ship");
  var_07 = var_05 + anglesToForward(var_06) * var_03 + anglestoright(var_06) * var_01 + anglestoup(var_06) * var_04;
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.235, 0.9, level.func_D127.origin, 5000);

  if(isDefined(self.func_727D)) {
    var_00 = self.func_727D;
  }

  var_08 = scripts\engine\utility::spawn_tag_origin();
  var_8.origin = var_07;

  if(isDefined(var_00)) {
    var_09 = vectornormalize(var_0.origin - var_05);
    var_8.angles = vectortoangles(var_09);
  } else
    var_8.angles = self.angles;

  if(isDefined(self.func_B83B)) {
    var_10 = self.func_B83B;
  }
  else {
    var_10 = "missile_flare_short";
  }

  if(isDefined(self.func_B803)) {
    var_11 = self.func_B803;
  }
  else {
    var_11 = undefined;
  }

  var_12 = 1000;

  if(isDefined(var_00)) {
    var_13 = 1;
  }
  else {
    var_13 = 0;
    var_00 = scripts\engine\utility::spawn_tag_origin();
    var_0.func_5F27 = 1;
    var_0.origin = func_0BDC::func_7B9B() + anglesToForward(func_0BDC::func_7B9F()) * randomintrange(35000, 65000);
  }

  var_14 = rotatevectorinverted(level.func_D127.spaceship_vel, level.func_D127.angles);
  var_14 = var_14[0] + 900;
  var_8.func_AA99 = "null";
  var_08 thread func_0B76::func_A332(var_00, 0, level.func_D127, var_10, var_12, var_02, undefined, var_11, var_14, undefined, 0.6);
  level.func_D127 notify("missile_fired", var_13);
}

func_A148(var_00, var_01) {
  self endon("player_exit_jackal");
  var_00 func_0BDC::func_F2FF();
  var_02 = 10000;

  for(;;) {
    if(!isDefined(var_00)) {
      break;
    }
    var_0.origin = self.origin + anglesToForward(self.angles) * var_02;
    level.player waittill("on_player_update");
    var_02 = var_02 + var_01;
  }
}

func_A276() {
  var_00 = level.func_D127 gettagorigin("tag_camera");
  var_01 = anglesToForward(level.func_D127 gettagangles("tag_camera"));
  var_02 = var_00 + var_01 * 500;
  var_03 = var_00 + var_01 * 50000;
  var_04 = bulletTrace(var_02, var_03, 0);
  return var_04;
}

func_B838(var_00) {
  self endon("entitydeleted");
  var_01 = distance(self.origin, var_0.origin);
  var_02 = scripts\sp\math::func_C097(5000, 12000, var_01);
  var_03 = scripts\sp\math::func_6A8E(0, 0.5, var_02);
  wait(var_03);

  if(isDefined(var_00) && isvalidmissile(self) && isDefined(self)) {
    self missile_settargetent(var_00);
  }
}

func_A273() {
  level.player playSound("jackal_ui_missile_empty");
  setomnvar("ui_jackal_missile_empty", gettime());
  wait 0.2;
}

func_A270(var_00) {
  func_0BDC::setentityowner(var_00);

  if(self.missiles.count <= 0) {
    level.func_D127 notify("player_missiles_empty");
    self.missiles.func_A8E8 = gettime() + randomintrange(-5000, 5000);
  }

  thread func_A271();
}

func_A271() {
  self endon("jackal_missile_count_try_vo" + self.missiles.count);

  if(self.missiles.count < 5) {
    self notify("jackal_missile_count_try_vo" + (self.missiles.count + 1));
  }

  wait 1.5;

  if(self.missiles.count == 1) {
    func_A26C("jackal_hud_1missileremaini");
  }
  else if(self.missiles.count == 15) {
    func_A26C("jackal_hud_15missilesremai");
  }
  else if(self.missiles.count == 10) {
    func_A26C("jackal_hud_10missilesremai");
  }
  else if(self.missiles.count == 5) {
    func_A26C("jackal_hud_5missilesremain");
  }
  else if(self.missiles.count == 4) {
    func_A26C("jackal_hud_4missilesremain");
  }
  else if(self.missiles.count == 3) {
    func_A26C("jackal_hud_3missilesremain");
  }
  else if(self.missiles.count == 2) {
    func_A26C("jackal_hud_2missilesremain");
  }
}

func_A26C(var_00) {
  var_01 = gettime();

  if(var_01 - self.missiles.func_A928 < 5000) {
    return;
  }
  func_0BDC::func_A112(var_00, 2);
  self.missiles.func_A928 = var_01;
}