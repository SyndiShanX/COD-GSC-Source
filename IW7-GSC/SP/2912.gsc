/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2912.gsc
************************/

func_96DC() {
  precacheshader("hud_icon_grenade_incoming_frag_sp");
  precacheshader("hud_icon_grenade_incoming_seeker");
  precacheshader("hud_icon_grenadepointer");
  precacheshader("hud_burningcaricon");
  precacheshader("hud_icon_exploding_car_red");
  precacheshader("hud_destructibledeathicon");
  precacheshader("hud_burningbarrelicon");
  precacheshader("vfx_ui_player_blood_drip");
  precacheshader("vfx_ui_player_blood_splat1");
  precacheshader("vfx_ui_player_blood_splat2");
  precacheshader("vfx_ui_player_blood_splat_large");
  precacheshader("vfx_ui_player_death_overlay");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_03");
  precachestring( & "SCRIPT_GRENADE_DEATH");
  precachestring( & "SCRIPT_GRENADE_SUICIDE");
  precachestring( & "SCRIPT_EXPLODING_VEHICLE_DEATH");
  precachestring( & "SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
  precachestring( & "SCRIPT_EXPLODING_BARREL_DEATH");
  precachestring( & "SCRIPT_SEEKER_DEATH");
  precachestring( & "SCRIPT_SEEKER_DEATH_EASY");
  func_96D9();
  thread main();
}

func_96D9() {
  level.player.var_E6 = spawnStruct();
  level.player.var_E6.var_12AEA = ["stand", "running", "crouch", "prone", "explo", "wallrun", "boosting", "zerog", "jackal"];
  level.player.var_E6.var_E9 = [];
  level.player.var_E6.var_47 = [];
  foreach(var_01 in level.player.var_E6.var_12AEA) {
    level.player.var_E6.var_47[var_01] = [];
  }

  func_DEA9();
  setdvar("player_death_animated", 1);
  level.player scripts\sp\utility::func_65E0("finished_death_anim");
  var_03 = scripts\engine\utility::random(level.player.var_E6.var_47["stand"]);
  setdvarifuninitialized("player_death_last_anim", var_03);
}

func_DEA9() {
  func_DED1("fall_left", "ges_player_death_drop1", ["player_death_fall_left", "plr_death_flop"]);
  func_DED1("fall_back", "ges_player_death_01", ["player_death_fall_back", "plr_death_flop"], ::func_6B5B);
  func_DED1("stand_left_hand_grasping", "ges_player_death_02", ["player_death_stand_left", "plr_death_flop"]);
  func_DED1("explosive_up", "ges_player_death_frag_1", ["player_death_explosive_up", "plr_death_explosion"], ::func_69FD);
  func_DED1("crouch_fall_left", "ges_player_death_crouch_drop1", ["player_death_crouch_fall_left", "plr_death_flop"], ::func_69FD);
  func_DED1("zerog_back", "ges_player_death_zerog_01", ["player_death_zerog_back", "plr_death_generic"], undefined, 1);
  setdvar("ui_deadquote_v1", 0);
  setdvar("ui_deadquote_v2", 0);
  setdvar("ui_deadquote_v3", 0);
}

func_DED1(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05.name = param_00;
  var_05.var_7789 = param_01;
  var_05.var_10475 = param_02;
  var_05.type = func_792C(param_00);
  if(isDefined(param_04)) {
    var_05.var_1C4B = param_04;
  } else {
    var_05.var_1C4B = 0;
  }

  if(isDefined(param_03)) {
    var_05.var_74D6 = param_03;
  }

  level.player.var_E6.var_E9 = scripts\engine\utility::array_add_safe(level.player.var_E6.var_E9, var_05);
  level.player.var_E6.var_47[var_05.type] = scripts\engine\utility::array_add_safe(level.player.var_E6.var_47[var_05.type], var_05.var_7789);
  return var_05;
}

func_F55B(param_00) {
  level.player.var_E6.var_D838 = param_00;
}

main() {
  setdvarifuninitialized("player_did_helmet_death", 0);
  level.player thread func_D2FB();
  level.player waittill("death", var_00, var_01, var_02, var_03, var_04);
  level.player _meth_8329("deathsdoor", "deathsdoor", "reverb");
  level.player setsoundsubmix("deaths_door_sp");
  level.player shellshock("default_nosound", 3);
  level.player playSound("deaths_door_death");
  level.player thread func_10FD3();
  level.player allowmelee(0);
  if(scripts\sp\utility::func_93AB()) {
    level.player _meth_8591(1);
    updategamerprofile();
    scripts\sp\endmission::func_41ED();
  }

  if(scripts\sp\utility::func_93A6() && scripts\sp\specialist_MAYBE::func_2C8D()) {
    scripts\sp\analytics::func_D37D();
    finishplayerdeath(scripts\sp\utility::func_93AB());
    return;
  }

  level.player _meth_84FE();
  if(!scripts\sp\utility::func_93A6()) {
    setomnvar("ui_death_hint", 0);
  }

  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_player_dead", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("cg_drawcrosshair", 0);
  if(level.player scripts\sp\utility::func_7B93() < 2) {
    thread scripts\sp\gameskill::func_4766(5, 1);
  }

  level.player scripts\sp\utility::func_1C49(0);
  var_05 = level.player getstance();
  var_06 = undefined;
  var_07 = undefined;
  var_08 = level.player scripts\sp\utility::func_65DF("zero_gravity") && level.player scripts\sp\utility::func_65DB("zero_gravity");
  if(level.player getnormalizedmovement()[0] > 0.7) {
    var_06 = 1;
  }

  if(level.player iswallrunning()) {
    var_07 = 1;
    var_06 = undefined;
  }

  var_09 = func_12849(var_05, var_06, var_01, var_03, var_07, var_08);
  if(!var_09) {
    level.player thread func_ECC6();
    level.player takeallweapons();
  }

  if(!var_09 && isDefined(var_03) && !isDefined(level.player.var_5818) || !level.player.var_5818) {
    var_0A = level.player.origin - level.player getEye() + (0, 0, 35);
    var_0B = spawn("script_model", level.player.origin + (0, 0, var_0A[2]));
    var_0B.angles = (-10, level.player.angles[2], 30);
    var_0B linkto(var_03);
    level.player playerlinkto(var_0B);
  }

  if(!scripts\sp\utility::func_93A6()) {
    scripts\engine\utility::delaythread(0.05, ::func_F32D, undefined, var_00, var_01, var_02, var_04);
  } else {
    setomnvar("ui_death_hint", 0);
    level notify("do_death_hint");
    wait(2);
  }

  if(!var_09) {
    wait(1.7);
  } else {
    wait(0.45);
  }

  setomnvar("ui_player_dead", 0);
  setdvar("player_death_animated", 1);
  scripts\sp\analytics::func_D37D();
  finishplayerdeath(scripts\sp\utility::func_93AB());
}

func_10FD3() {
  if(isDefined(level.var_4E61)) {
    level.var_4E61 ghostattack(0, 2);
    wait(2);
    if(isDefined(level.var_4E61)) {
      level.var_4E61 stoploopsound("deaths_door_lp");
    }

    wait(0.05);
    if(isDefined(level.var_4E61)) {
      level.var_4E61 delete();
    }
  }
}

func_12849(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!func_CFF2()) {
    return 0;
  }

  if(isDefined(level.player.var_E6.var_D838)) {
    if(isstring(level.player.var_E6.var_D838)) {
      var_06 = func_792B(level.player.var_E6.var_D838);
    } else {
      var_06 = level.player.var_E6.var_D838;
    }
  } else {
    var_06 = func_CB1D(param_01, param_02, param_03, param_05, var_06);
  }

  if(!isDefined(var_06)) {
    return 0;
  }

  setdvar("player_death_last_anim", var_06.var_7789);
  var_08 = func_96DE(param_00, param_04, var_06.var_1C4B);
  if(var_08) {
    thread func_77B0(var_06, param_03);
    if(!isDefined(level.player.var_111B8) || !level.player.var_111B8) {
      level.player thread func_ECC6();
    }

    func_CCD7(var_06);
    return 1;
  }

  return 0;
}

func_CB1D(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  if(func_9BDA(param_02)) {
    return undefined;
  }

  if(isDefined(param_03)) {
    return undefined;
  }

  if(param_04) {
    var_05 = func_12854(level.player.var_E6.var_47["zerog"], param_00, param_01);
    if(isDefined(var_05)) {
      return var_05;
    }
  }

  if(isDefined(param_02) && func_4D03(param_02) && param_00 == "stand") {
    var_05 = func_12854(level.player.var_E6.var_47["explo"], param_00, param_01);
    if(isDefined(var_05)) {
      return var_05;
    }
  }

  if(isDefined(param_01) && param_00 == "stand") {
    var_05 = func_12854(level.player.var_E6.var_47["running"], param_00, param_01);
    if(isDefined(var_05)) {
      return var_05;
    }
  }

  if(param_00 == "stand") {
    var_05 = func_12854(level.player.var_E6.var_47["stand"], param_00, param_01);
    if(isDefined(var_05)) {
      return var_05;
    }
  }

  if(param_00 == "crouch") {
    var_05 = func_12854(level.player.var_E6.var_47["crouch"], param_00, param_01);
    if(isDefined(var_05)) {
      return var_05;
    }
  }

  if(param_00 == "prone") {
    var_05 = func_12854(level.player.var_E6.var_47["prone"], param_00, param_01);
    if(isDefined(var_05)) {
      return var_05;
    }
  }

  return undefined;
}

func_9BDA(param_00) {
  if(!isDefined(param_00)) {
    return 1;
  }

  if(param_00 == "MOD_SUICIDE" || param_00 == "MOD_TRIGGER_HURT") {
    return 1;
  }

  return 0;
}

func_12854(param_00, param_01, param_02, param_03) {
  param_00 = scripts\engine\utility::array_randomize(param_00);
  foreach(var_05 in param_00) {
    if(func_9B66(var_05, param_01, param_02)) {
      var_06 = func_792A(var_05);
      return var_06;
    }
  }

  return undefined;
}

func_11A18(param_00) {
  if(!isDefined(param_00)) {
    param_00 = getweaponmodel(level.player getcurrentprimaryweapon());
  }

  var_01 = spawn("script_model", level.player.origin + (0, -7, 20));
  var_01 setModel(param_00);
  if(!var_01 _meth_8418()) {
    var_01 delete();
    return;
  }

  var_01.angles = level.player.angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20));
  var_02 = anglesToForward(level.player.angles);
  var_02 = var_02 * randomfloatrange(600, 750);
  var_03 = var_02[0];
  var_04 = var_02[1];
  var_05 = randomfloatrange(400, 600);
  var_01 physicslaunchserver(var_01.origin, (var_03, var_04, var_05));
}

func_9B66(param_00, param_01, param_02) {
  return 1;
}

func_CCD7(param_00) {
  level.player.ignoreme = 1;
  var_01 = level.player getgestureanimlength(param_00.var_7789);
  if(isDefined(param_00.var_74D6)) {
    level thread[[param_00.var_74D6]]();
  }

  if(!scripts\sp\utility::func_93A6()) {
    if(isarray(param_00.var_10475)) {
      foreach(var_03 in param_00.var_10475) {
        level.player playSound(var_03);
      }
    } else {
      level.player playSound(param_00.var_10475);
    }
  }

  var_05 = level.player forceplaygestureviewmodel(param_00.var_7789, undefined, 0.15, undefined, 1, 1);
  if(var_05) {
    level.player thread func_F32B(param_00);
  }

  level.player scripts\engine\utility::waittill_notify_or_timeout("gesture_stopped", 3);
  level.player scripts\sp\utility::func_65E1("finished_death_anim");
}

func_F32B(param_00) {
  while(!isDefined(param_00.var_7789) || !isDefined(param_00.anchor)) {
    wait(0.05);
  }

  var_01 = param_00.var_7789;
  var_02 = param_00.anchor;
  var_03 = undefined;
  switch (var_01) {
    case "ges_player_death_frag_1":
    case "ges_player_death_01":
      var_03 = 2.8;
      break;

    case "ges_player_death_drop1":
      var_03 = 3.8;
      break;

    case "ges_player_death_crouch_drop1":
      var_03 = 7.8;
      break;

    case "ges_player_death_02":
      var_03 = 9.8;
      break;
  }

  if(!isDefined(var_03)) {
    return;
  }

  var_04 = func_79F3(anglesToForward(self.angles));
  var_05 = func_79F3(anglestoright(self.angles));
  var_06 = (var_04, self.angles[1], var_05);
  var_07 = self.origin + rotatevector((0, 0, var_03), var_06);
  var_08 = scripts\common\trace::ray_trace(var_07, var_07 - (0, 0, 4.5), [self]);
  if(var_08["hittype"] == "hittype_none") {
    self playerlinktoabsolute(var_02, "tag_origin");
    if(var_02 islinked()) {
      var_09 = anglestoaxis(var_06);
      var_09["forward"] = rotatevectorinverted(var_09["forward"], var_02.angles);
      var_09["right"] = rotatevectorinverted(var_09["right"], var_02.angles);
      var_09["up"] = rotatevectorinverted(var_09["up"], var_02.angles);
      var_06 = axistoangles(var_09["forward"], var_09["right"], var_09["up"]);
      var_02 rotatetolinked(var_06, 1, 0.5, 0.5);
      return;
    }

    var_03 rotateto(var_07, 1, 0.5, 0.5);
  }
}

func_79F3(param_00) {
  param_00 = vectornormalize(param_00);
  var_01 = (0, 0, 60);
  var_02 = 15 * param_00;
  var_03 = scripts\common\trace::ray_trace(self.origin + var_02 + var_01, self.origin + var_02 - var_01, [self]);
  var_04 = scripts\common\trace::ray_trace(self.origin - var_02 + var_01, self.origin - var_02 - var_01, [self]);
  if(var_03["hittype"] == "hittype_none") {
    var_05 = self.origin;
  } else {
    var_05 = var_04["position"];
  }

  if(var_04["hittype"] == "hittype_none") {
    var_06 = self.origin;
  } else {
    var_06 = var_05["position"];
  }

  var_07 = distance2d(var_05, var_06);
  if(var_07 > 0) {
    var_08 = atan(var_06[2] - var_05[2] / var_07);
    if(abs(var_08) > 45) {
      return 0;
    }

    return var_08;
  }

  return 0;
}

func_4ECC() {}

func_77B0(param_00, param_01) {
  if(isDefined(level.player.var_9DD2) && level.player.var_9DD2) {
    level.player lib_0E25::func_D293(0);
    level.player lib_0E49::func_D093();
  }

  if(isDefined(param_00.var_5965)) {
    return;
  }

  var_02 = 1.5;
  param_00.anchor = level.player scripts\engine\utility::spawn_tag_origin();
  if(isDefined(param_01)) {
    param_00.anchor linkto(param_01);
  }

  level.player playerlinkto(param_00.anchor, "tag_origin", 0, 20, 20, 20, 20);
  level.player lerpviewangleclamp(var_02, var_02 * 0.5, var_02 * 0.5, 0, 0, 0, 0);
}

func_AB8E(param_00) {
  var_01 = param_00 * 20;
  var_02 = 0.1;
  var_03 = var_02 / var_01;
  var_04 = 1;
  var_05 = var_04;
  for(var_06 = 0; var_06 < var_01; var_06++) {
    if(var_04 > var_02) {
      var_05 = var_05 - var_03;
    } else if(var_04 == var_02) {
      break;
    }

    level.player getrawbaseweaponname(var_05, var_05);
    var_04 = var_05;
    wait(0.05);
  }

  level.player getrawbaseweaponname(0, 0);
}

func_96DE(param_00, param_01, param_02) {
  if(!param_02 && !level.player isonground()) {
    thread func_BB02();
    level.player thread scripts\sp\utility::func_C12D("falling_timeout", 1);
    var_03 = level.player scripts\engine\utility::waittill_any_return("falling_timeout", "on_ground");
    if(var_03 == "falling_timeout") {
      return 0;
    }
  }

  level.var_7684 = ::empty_breathing_func;
  level.player freezecontrols(1);
  if(param_00 == "prone") {
    level.player allowstand(0);
    level.player allowcrouch(0);
  }

  if(param_00 == "crouch") {
    level.player allowstand(0);
    level.player allowprone(0);
  } else {
    level.player allowprone(0);
    level.player allowcrouch(0);
  }

  level.player getraidspawnpoint();
  level.player disableoffhandsecondaryweapons();
  level.player allowoffhandshieldweapons(0);
  level.player getquadrant();
  level.player allowjump(0);
  level.player allowfire(0);
  level.player freezecontrols(0);
  func_11493();
  return 1;
}

func_ECC6() {
  if(isDefined(level.player.var_E6.var_1025C)) {
    return;
  }

  if(scripts\sp\utility::func_93A6()) {
    return 0;
  }

  if(func_FF31()) {
    thread func_8DDF();
    return;
  }

  thread func_2BC7();
}

func_2BC7() {
  setdvar("player_did_helmet_death", 0);
  level.player.var_E6.var_91AF = [];
  var_00 = ["blood_splat1", "blood_splat2", "blood_drip", "blood_splat_large", "death_overlay"];
  foreach(var_02 in var_00) {
    level.player.var_E6.var_91AF[var_02] = func_48C9();
  }

  level.player.var_E6.var_91AF["death_overlay"] thread func_4E19();
  level.player.var_E6.var_91AF["blood_drip"] thread func_2BBF();
  level.player.var_E6.var_91AF["blood_splat_large"] thread func_A851();
  thread func_1033D();
}

func_FF31() {
  if(getdvarint("player_did_helmet_death")) {
    return 0;
  }

  if(isDefined(level.var_BFF4)) {
    return 0;
  }

  if(!isDefined(level.player.helmet) || scripts\sp\utility::func_93A6() && !::scripts\sp\specialist_MAYBE::func_2C95) {
    return 0;
  }

  if(isDefined(level.player.helmet) && isDefined(level.player.helmet.var_13487) && level.player.helmet.var_13487 == "up") {
    return 0;
  }

  if(!func_CFAE()) {
    return 0;
  }

  return 1;
}

func_CFAE() {
  var_00 = getaiarray("axis");
  foreach(var_02 in var_00) {
    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_02.origin, 0.173648)) {
      continue;
    }

    if(scripts\sp\detonategrenades::func_385C(level.player getEye(), var_02)) {
      return 1;
    }
  }

  return 0;
}

func_8DDF() {
  setdvar("player_did_helmet_death", 1);
  var_00 = randomfloatrange(-3, -1);
  var_01 = randomfloatrange(-1, 12);
  var_02 = randomfloatrange(-13, 20);
  var_03 = randomfloatrange(-3, 3);
  var_04 = randomint(100);
  if(var_04 <= 25) {
    var_01 = randomfloatrange(-4, 4);
    var_02 = 5;
    var_03 = 90;
  } else if(var_04 <= 50) {
    var_01 = randomfloatrange(-1, 5);
    var_02 = randomfloatrange(-13, 7);
    var_03 = 180;
  } else if(var_04 <= 270) {
    var_01 = randomfloatrange(-4, 4);
    var_02 = -5;
    var_03 = 270;
  }

  if(scripts\sp\utility::func_93A6()) {
    level.player.helmet = level.var_10964.helmet;
  }

  level.player.helmet _meth_83CB(level.player);
  level.player.helmet setModel("vm_hero_protagonist_helmet_glass_crack_03");
  level.player.helmet notsolid();
  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (var_00, 0, 0), (var_01, var_02, var_03), 1, "view_jostle");
}

func_1033D() {
  var_00 = randomintrange(10, 300);
  var_01 = randomintrange(300, 500);
  var_02 = [var_00, var_01];
  var_03 = randomintrange(10, 150);
  var_04 = randomintrange(150, 250);
  var_05 = [var_03, var_04];
  var_06 = scripts\engine\utility::random(var_02);
  var_07 = scripts\engine\utility::random(var_05);
  level.player.var_E6.var_91AF["blood_splat1"].x = var_06;
  level.player.var_E6.var_91AF["blood_splat1"].y = var_07;
  var_02 = scripts\engine\utility::array_remove(var_02, var_06);
  var_05 = scripts\engine\utility::array_remove(var_05, var_07);
  var_08 = 250;
  var_09 = 350;
  var_0A = 275;
  var_0B = 350;
  var_0C = 0.9;
  var_0D = 1;
  var_0E = randomintrange(var_08, var_09);
  var_0F = randomintrange(var_0A, var_0B);
  wait(0.7);
  level.player.var_E6.var_91AF["blood_splat1"] setshader("vfx_ui_player_blood_splat1", var_0E, var_0F);
  level.player.var_E6.var_91AF["blood_splat1"].alpha = randomfloatrange(var_0C, var_0D);
  level.player.var_E6.var_91AF["blood_splat2"].x = var_02[0];
  level.player.var_E6.var_91AF["blood_splat2"].y = var_05[0];
  wait(0.5);
  var_0E = randomintrange(var_08, var_09);
  var_0F = randomintrange(var_0A, var_0B);
  level.player.var_E6.var_91AF["blood_splat2"] setshader("vfx_ui_player_blood_splat2", var_0E, var_0F);
  level.player.var_E6.var_91AF["blood_splat2"].alpha = randomfloatrange(var_0C, var_0D);
}

func_A851() {
  var_00 = randomintrange(675, 690);
  var_01 = randomintrange(500, 575);
  self setshader("vfx_ui_player_blood_splat_large", var_00, var_01);
  self.x = randomintrange(-200, 200);
  self.y = randomintrange(150, 170);
  self.alpha = 1;
}

func_2BBF() {
  var_00 = randomintrange(500, 650);
  var_01 = randomintrange(150, 250);
  self setshader("vfx_ui_player_blood_drip", var_00, var_01);
  self.x = randomintrange(-90, 300);
  self.y = randomintrange(-100, -70);
  self.alpha = randomfloatrange(0.95, 1);
  self scaleovertime(60, var_01 + randomintrange(1, 3), var_00);
}

func_8DEB() {
  self.horzalign = "center";
  self.vertalign = "middle";
  self.alignx = "center";
  self.aligny = "middle";
  self setshader("vfx_ui_player_helmet_hole", 640, 640);
  self.x = randomintrange(-20, 20);
  self.y = randomintrange(-20, 20);
  self.alpha = 1;
}

func_4E19(param_00) {
  self setshader("vfx_ui_player_death_overlay", 640, 480);
  self.alpha = scripts\engine\utility::ter_op(isDefined(param_00), param_00, randomfloatrange(0.9, 1));
  self.sort = 10;
}

func_48C9() {
  var_00 = newclienthudelem(self);
  var_00.x = 0;
  var_00.y = 0;
  var_00.ispointonnavmesh3d = 1;
  var_00.alignx = "left";
  var_00.aligny = "top";
  var_00.sort = 1;
  var_00.foreground = 0;
  var_00.horzalign = "fullscreen";
  var_00.vertalign = "fullscreen";
  var_00.alpha = 0;
  var_00.isexplosivedamagemod = 1;
  return var_00;
}

func_11493() {
  var_00 = [];
  var_01 = level.player getcurrentweapon();
  var_00[var_00.size] = var_01;
  if(isDefined(var_01) && issubstr(var_01, "akimbofmg")) {
    while(level.player isswitchingweapon()) {
      wait(0.05);
    }
  }

  if(weaponinventorytype(var_01) == "altmode") {
    var_00[var_00.size] = adsbuttonpressed(var_01);
  } else {
    var_02 = weaponaltweaponname(var_01);
    if(var_02 != "none") {
      var_00[var_00.size] = var_02;
    }
  }

  foreach(var_04 in level.player getweaponslistall()) {
    if(!scripts\engine\utility::array_contains(var_00, var_04)) {
      level.player takeweapon(var_04);
    }
  }
}

adsbuttonpressed(param_00) {
  var_01 = getsubstr(param_00, 4);
  return var_01;
}

func_BB02() {
  while(!level.player isonground()) {
    wait(0.05);
  }

  level.player notify("on_ground");
}

func_D2FB() {
  self endon("death");
  self.var_A994 = 0;
  for(;;) {
    while(!self isthrowinggrenade()) {
      wait(0.05);
    }

    self.var_A994 = gettime();
    while(self isthrowinggrenade()) {
      wait(0.05);
    }
  }
}

func_131B8(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00.var_9F != "scriptable") {
    return 0;
  }

  if(!isDefined(param_00.var_ED) || param_00.var_ED != "vehicle") {
    return 0;
  }

  level notify("new_quote_string4");
  setomnvar("ui_death_hint", 3);
  return 1;
}

func_5346(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isDefined(param_00.var_ED)) {
    return 0;
  }

  level notify("new_quote_string");
  if(issubstr(param_00.var_ED, "vehicle")) {
    setomnvar("ui_death_hint", 3);
  } else {
    setomnvar("ui_death_hint", 4);
  }

  return 1;
}

func_69BB(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 func_9C9C()) {
    level notify("new_quote_string");
    setomnvar("ui_death_hint", 5);
    return 1;
  }

  return 0;
}

func_9C9C() {
  if(isDefined(self.var_336) && self.var_336 == "phys_barrel_destructible") {
    return 1;
  }

  if(isDefined(self.model) && issubstr(self.model, "barrel") && issubstr(self.model, "red")) {
    return 1;
  }

  return 0;
}

func_F322(param_00) {
  level.var_4C48 = param_00;
}

func_F32E() {
  if(isDefined(level.var_4C48)) {
    var_00 = level.var_4C48;
    var_01 = int(tablelookup("sp\death_hints.csv", 1, var_00, 0));
    if(var_01 > 0) {
      setomnvar("ui_death_hint", var_01);
      return;
    }

    func_F32F();
    return;
  }

  func_F32F();
}

func_F32F() {
  var_00 = 100;
  var_01 = undefined;
  var_02 = int(tablelookup("sp\death_hints.csv", 0, var_00, 0));
  while(isDefined(var_02) && var_02 > 0) {
    var_01 = var_02;
    var_02 = int(tablelookup("sp\death_hints.csv", 0, var_00, 0));
    var_00++;
  }

  for(;;) {
    var_03 = randomintrange(100, var_01);
    if(!func_4DF6(var_03)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  setdvar("ui_deadquote_v1", var_03);
  setdvar("ui_deadquote_v2", getdvarint("ui_deadquote_v1"));
  setdvar("ui_deadquote_v3", getdvarint("ui_deadquote_v2"));
  setomnvar("ui_death_hint", var_03);
}

func_F32D(param_00, param_01, param_02, param_03, param_04) {
  if(level.var_B8D0) {
    return;
  }

  setomnvar("ui_death_hint", 0);
  if(isDefined(level.var_4C48)) {
    param_00 = level.var_4C48;
  }

  if(isDefined(param_00)) {
    var_05 = int(tablelookup("sp\death_hints.csv", 1, param_00, 0));
    if(var_05 > 0) {
      setomnvar("ui_death_hint", var_05);
      return;
    }

    func_F32F();
    return;
  }

  if(param_02 == "MOD_GRENADE" || param_02 == "MOD_GRENADE_SPLASH" || param_02 == "MOD_SUICIDE" || param_02 == "MOD_EXPLOSIVE") {
    if(level.var_7683 >= 2) {
      if(!scripts\sp\gameskill::func_B327()) {
        func_F32F();
        return;
      }
    }

    switch (param_02) {
      case "MOD_SUICIDE":
        if(level.player.var_A994 - gettime() > 3500) {
          return;
        }

        setomnvar("ui_death_hint", 2);
        break;

      case "MOD_EXPLOSIVE":
        if(level.player func_5346(param_01)) {
          return;
        }

        if(level.player func_131B8(param_04)) {
          return;
        }

        if(level.player func_69BB(param_04, param_03)) {
          return;
        }

        func_F32F();
        break;

      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
        if(isDefined(param_03) && !isweapondetonationtimed(param_03)) {
          func_F32F();
          return;
        }

        if(isDefined(param_03) && issubstr(param_03, "seeker")) {
          if(level.var_7683 == 0) {
            setomnvar("ui_death_hint", 44);
          } else {
            setomnvar("ui_death_hint", 45);
          }

          break;
        }

        if(!isDefined(param_03)) {
          setomnvar("ui_death_hint", 52);
          break;
        }

        setomnvar("ui_death_hint", 1);
        break;

      default:
        func_F32F();
        break;
    }

    return;
  }

  func_F32F();
}

func_4DF6(param_00) {
  if(param_00 == getdvarint("ui_deadquote_v1")) {
    return 1;
  }

  if(param_00 == getdvarint("ui_deadquote_v2")) {
    return 1;
  }

  if(param_00 == getdvarint("ui_deadquote_v3")) {
    return 1;
  }

  return 0;
}

func_B02A(param_00) {
  var_01 = tablelookup("sp\deathQuoteTable.csv", 0, param_00, 1);
  if(tolower(var_01[0]) != tolower("@")) {
    var_01 = "@" + var_01;
  }

  return var_01;
}

func_F330(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 1.5;
  }

  wait(param_03);
  var_04 = newhudelem();
  var_04.x = 0;
  var_04.y = 40;
  var_04 setshader(param_00, param_01, param_02);
  var_04.alignx = "center";
  var_04.aligny = "middle";
  var_04.horzalign = "center";
  var_04.vertalign = "middle";
  var_04.foreground = 1;
  var_04.alpha = 0;
  var_04 fadeovertime(1);
  var_04.alpha = 1;
}

func_792C(param_00) {
  var_01 = 0;
  foreach(var_03 in level.player.var_E6.var_12AEA) {
    if(issubstr(param_00, var_03)) {
      return var_03;
    }
  }

  return "stand";
}

func_792B(param_00) {
  foreach(var_02 in level.player.var_E6.var_E9) {
    if(var_02.name == param_00) {
      return var_02;
    }
  }

  return undefined;
}

func_792A(param_00) {
  foreach(var_02 in level.player.var_E6.var_E9) {
    if(var_02.var_7789 == param_00) {
      return var_02;
    }
  }
}

func_4D03(param_00) {
  if(issubstr(param_00, "SPLASH")) {
    return 1;
  }

  if(issubstr(param_00, "GRENADE")) {
    return 1;
  }

  return 0;
}

empty_breathing_func(param_00) {}

func_CFF2() {
  return getdvarint("player_death_animated");
}

func_69FD() {
  wait(1);
  func_11A18();
}

func_6B5B() {
  func_11A18();
}