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
  precachestring(&"SCRIPT_GRENADE_DEATH");
  precachestring(&"SCRIPT_GRENADE_SUICIDE");
  precachestring(&"SCRIPT_EXPLODING_VEHICLE_DEATH");
  precachestring(&"SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH");
  precachestring(&"SCRIPT_EXPLODING_BARREL_DEATH");
  precachestring(&"SCRIPT_SEEKER_DEATH");
  precachestring(&"SCRIPT_SEEKER_DEATH_EASY");
  func_96D9();
  thread main();
}

func_96D9() {
  level.player.var_E6 = spawnStruct();
  level.player.var_E6.var_12AEA = ["stand", "running", "crouch", "prone", "explo", "wallrun", "boosting", "zerog", "jackal"];
  level.player.var_E6.var_E9 = [];
  level.player.var_E6.var_47 = [];
  foreach(var_1 in level.player.var_E6.var_12AEA) {
    level.player.var_E6.var_47[var_1] = [];
  }

  func_DEA9();
  setdvar("player_death_animated", 1);
  level.player scripts\sp\utility::func_65E0("finished_death_anim");
  var_3 = scripts\engine\utility::random(level.player.var_E6.var_47["stand"]);
  setdvarifuninitialized("player_death_last_anim", var_3);
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

func_DED1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.name = var_0;
  var_5.var_7789 = var_1;
  var_5.var_10475 = var_2;
  var_5.type = func_792C(var_0);
  if(isDefined(var_4)) {
    var_5.var_1C4B = var_4;
  } else {
    var_5.var_1C4B = 0;
  }

  if(isDefined(var_3)) {
    var_5.var_74D6 = var_3;
  }

  level.player.var_E6.var_E9 = scripts\engine\utility::array_add_safe(level.player.var_E6.var_E9, var_5);
  level.player.var_E6.var_47[var_5.type] = ::scripts\engine\utility::array_add_safe(level.player.var_E6.var_47[var_5.type], var_5.var_7789);
  return var_5;
}

func_F55B(var_0) {
  level.player.var_E6.var_D838 = var_0;
}

main() {
  setdvarifuninitialized("player_did_helmet_death", 0);
  level.player thread func_D2FB();
  level.player waittill("death", var_0, var_1, var_2, var_3, var_4);
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
  var_5 = level.player getstance();
  var_6 = undefined;
  var_7 = undefined;
  var_8 = level.player scripts\sp\utility::func_65DF("zero_gravity") && level.player scripts\sp\utility::func_65DB("zero_gravity");
  if(level.player getnormalizedmovement()[0] > 0.7) {
    var_6 = 1;
  }

  if(level.player iswallrunning()) {
    var_7 = 1;
    var_6 = undefined;
  }

  var_9 = func_12849(var_5, var_6, var_1, var_3, var_7, var_8);
  if(!var_9) {
    level.player thread func_ECC6();
    level.player takeallweapons();
  }

  if(!var_9 && isDefined(var_3) && !isDefined(level.player.var_5818) || !level.player.var_5818) {
    var_0A = level.player.origin - level.player getEye() + (0, 0, 35);
    var_0B = spawn("script_model", level.player.origin + (0, 0, var_0A[2]));
    var_0B.angles = (-10, level.player.angles[2], 30);
    var_0B linkto(var_3);
    level.player playerlinkto(var_0B);
  }

  if(!scripts\sp\utility::func_93A6()) {
    scripts\engine\utility::delaythread(0.05, ::func_F32D, undefined, var_0, var_1, var_2, var_4);
  } else {
    setomnvar("ui_death_hint", 0);
    level notify("do_death_hint");
    wait(2);
  }

  if(!var_9) {
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

func_12849(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!func_CFF2()) {
    return 0;
  }

  if(isDefined(level.player.var_E6.var_D838)) {
    if(isstring(level.player.var_E6.var_D838)) {
      var_6 = func_792B(level.player.var_E6.var_D838);
    } else {
      var_6 = level.player.var_E6.var_D838;
    }
  } else {
    var_6 = func_CB1D(var_1, var_2, var_3, var_5, var_6);
  }

  if(!isDefined(var_6)) {
    return 0;
  }

  setdvar("player_death_last_anim", var_6.var_7789);
  var_8 = func_96DE(var_0, var_4, var_6.var_1C4B);
  if(var_8) {
    thread func_77B0(var_6, var_3);
    if(!isDefined(level.player.var_111B8) || !level.player.var_111B8) {
      level.player thread func_ECC6();
    }

    func_CCD7(var_6);
    return 1;
  }

  return 0;
}

func_CB1D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  if(func_9BDA(var_2)) {
    return undefined;
  }

  if(isDefined(var_3)) {
    return undefined;
  }

  if(var_4) {
    var_5 = func_12854(level.player.var_E6.var_47["zerog"], var_0, var_1);
    if(isDefined(var_5)) {
      return var_5;
    }
  }

  if(isDefined(var_2) && func_4D03(var_2) && var_0 == "stand") {
    var_5 = func_12854(level.player.var_E6.var_47["explo"], var_0, var_1);
    if(isDefined(var_5)) {
      return var_5;
    }
  }

  if(isDefined(var_1) && var_0 == "stand") {
    var_5 = func_12854(level.player.var_E6.var_47["running"], var_0, var_1);
    if(isDefined(var_5)) {
      return var_5;
    }
  }

  if(var_0 == "stand") {
    var_5 = func_12854(level.player.var_E6.var_47["stand"], var_0, var_1);
    if(isDefined(var_5)) {
      return var_5;
    }
  }

  if(var_0 == "crouch") {
    var_5 = func_12854(level.player.var_E6.var_47["crouch"], var_0, var_1);
    if(isDefined(var_5)) {
      return var_5;
    }
  }

  if(var_0 == "prone") {
    var_5 = func_12854(level.player.var_E6.var_47["prone"], var_0, var_1);
    if(isDefined(var_5)) {
      return var_5;
    }
  }

  return undefined;
}

func_9BDA(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(var_0 == "MOD_SUICIDE" || var_0 == "MOD_TRIGGER_HURT") {
    return 1;
  }

  return 0;
}

func_12854(var_0, var_1, var_2, var_3) {
  var_0 = scripts\engine\utility::array_randomize(var_0);
  foreach(var_5 in var_0) {
    if(func_9B66(var_5, var_1, var_2)) {
      var_6 = func_792A(var_5);
      return var_6;
    }
  }

  return undefined;
}

func_11A18(var_0) {
  if(!isDefined(var_0)) {
    var_0 = getweaponmodel(level.player getcurrentprimaryweapon());
  }

  var_1 = spawn("script_model", level.player.origin + (0, -7, 20));
  var_1 setModel(var_0);
  if(!var_1 _meth_8418()) {
    var_1 delete();
    return;
  }

  var_1.angles = level.player.angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20));
  var_2 = anglesToForward(level.player.angles);
  var_2 = var_2 * randomfloatrange(600, 750);
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = randomfloatrange(400, 600);
  var_1 physicslaunchserver(var_1.origin, (var_3, var_4, var_5));
}

func_9B66(var_0, var_1, var_2) {
  return 1;
}

func_CCD7(var_0) {
  level.player.ignoreme = 1;
  var_1 = level.player getgestureanimlength(var_0.var_7789);
  if(isDefined(var_0.var_74D6)) {
    level thread[[var_0.var_74D6]]();
  }

  if(!scripts\sp\utility::func_93A6()) {
    if(isarray(var_0.var_10475)) {
      foreach(var_3 in var_0.var_10475) {
        level.player playSound(var_3);
      }
    } else {
      level.player playSound(var_0.var_10475);
    }
  }

  var_5 = level.player forceplaygestureviewmodel(var_0.var_7789, undefined, 0.15, undefined, 1, 1);
  if(var_5) {
    level.player thread func_F32B(var_0);
  }

  level.player scripts\engine\utility::waittill_notify_or_timeout("gesture_stopped", 3);
  level.player scripts\sp\utility::func_65E1("finished_death_anim");
}

func_F32B(var_0) {
  while(!isDefined(var_0.var_7789) || !isDefined(var_0.anchor)) {
    wait(0.05);
  }

  var_1 = var_0.var_7789;
  var_2 = var_0.anchor;
  var_3 = undefined;
  switch (var_1) {
    case "ges_player_death_frag_1":
    case "ges_player_death_01":
      var_3 = 2.8;
      break;

    case "ges_player_death_drop1":
      var_3 = 3.8;
      break;

    case "ges_player_death_crouch_drop1":
      var_3 = 7.8;
      break;

    case "ges_player_death_02":
      var_3 = 9.8;
      break;
  }

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = func_79F3(anglesToForward(self.angles));
  var_5 = func_79F3(anglestoright(self.angles));
  var_6 = (var_4, self.angles[1], var_5);
  var_7 = self.origin + rotatevector((0, 0, var_3), var_6);
  var_8 = scripts\common\trace::ray_trace(var_7, var_7 - (0, 0, 4.5), [self]);
  if(var_8["hittype"] == "hittype_none") {
    self playerlinktoabsolute(var_2, "tag_origin");
    if(var_2 islinked()) {
      var_9 = anglestoaxis(var_6);
      var_9["forward"] = rotatevectorinverted(var_9["forward"], var_2.angles);
      var_9["right"] = rotatevectorinverted(var_9["right"], var_2.angles);
      var_9["up"] = rotatevectorinverted(var_9["up"], var_2.angles);
      var_6 = axistoangles(var_9["forward"], var_9["right"], var_9["up"]);
      var_2 rotatetolinked(var_6, 1, 0.5, 0.5);
      return;
    }

    var_3 rotateto(var_7, 1, 0.5, 0.5);
  }
}

func_79F3(var_0) {
  var_0 = vectornormalize(var_0);
  var_1 = (0, 0, 60);
  var_2 = 15 * var_0;
  var_3 = scripts\common\trace::ray_trace(self.origin + var_2 + var_1, self.origin + var_2 - var_1, [self]);
  var_4 = scripts\common\trace::ray_trace(self.origin - var_2 + var_1, self.origin - var_2 - var_1, [self]);
  if(var_3["hittype"] == "hittype_none") {
    var_5 = self.origin;
  } else {
    var_5 = var_4["position"];
  }

  if(var_4["hittype"] == "hittype_none") {
    var_6 = self.origin;
  } else {
    var_6 = var_5["position"];
  }

  var_7 = distance2d(var_5, var_6);
  if(var_7 > 0) {
    var_8 = atan(var_6[2] - var_5[2] / var_7);
    if(abs(var_8) > 45) {
      return 0;
    }

    return var_8;
  }

  return 0;
}

func_4ECC() {}

func_77B0(var_0, var_1) {
  if(isDefined(level.player.var_9DD2) && level.player.var_9DD2) {
    level.player lib_0E25::func_D293(0);
    level.player lib_0E49::func_D093();
  }

  if(isDefined(var_0.var_5965)) {
    return;
  }

  var_2 = 1.5;
  var_0.anchor = level.player scripts\engine\utility::spawn_tag_origin();
  if(isDefined(var_1)) {
    var_0.anchor linkto(var_1);
  }

  level.player playerlinkto(var_0.anchor, "tag_origin", 0, 20, 20, 20, 20);
  level.player lerpviewangleclamp(var_2, var_2 * 0.5, var_2 * 0.5, 0, 0, 0, 0);
}

func_AB8E(var_0) {
  var_1 = var_0 * 20;
  var_2 = 0.1;
  var_3 = var_2 / var_1;
  var_4 = 1;
  var_5 = var_4;
  for(var_6 = 0; var_6 < var_1; var_6++) {
    if(var_4 > var_2) {
      var_5 = var_5 - var_3;
    } else if(var_4 == var_2) {
      break;
    }

    level.player getrawbaseweaponname(var_5, var_5);
    var_4 = var_5;
    wait(0.05);
  }

  level.player getrawbaseweaponname(0, 0);
}

func_96DE(var_0, var_1, var_2) {
  if(!var_2 && !level.player isonground()) {
    thread func_BB02();
    level.player thread scripts\sp\utility::func_C12D("falling_timeout", 1);
    var_3 = level.player scripts\engine\utility::waittill_any_return("falling_timeout", "on_ground");
    if(var_3 == "falling_timeout") {
      return 0;
    }
  }

  level.var_7684 = ::empty_breathing_func;
  level.player freezecontrols(1);
  if(var_0 == "prone") {
    level.player allowstand(0);
    level.player allowcrouch(0);
  }

  if(var_0 == "crouch") {
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
  var_0 = ["blood_splat1", "blood_splat2", "blood_drip", "blood_splat_large", "death_overlay"];
  foreach(var_2 in var_0) {
    level.player.var_E6.var_91AF[var_2] = func_48C9();
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
  var_0 = getaiarray("axis");
  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_2.origin, 0.173648)) {
      continue;
    }

    if(scripts\sp\detonategrenades::func_385C(level.player getEye(), var_2)) {
      return 1;
    }
  }

  return 0;
}

func_8DDF() {
  setdvar("player_did_helmet_death", 1);
  var_0 = randomfloatrange(-3, -1);
  var_1 = randomfloatrange(-1, 12);
  var_2 = randomfloatrange(-13, 20);
  var_3 = randomfloatrange(-3, 3);
  var_4 = randomint(100);
  if(var_4 <= 25) {
    var_1 = randomfloatrange(-4, 4);
    var_2 = 5;
    var_3 = 90;
  } else if(var_4 <= 50) {
    var_1 = randomfloatrange(-1, 5);
    var_2 = randomfloatrange(-13, 7);
    var_3 = 180;
  } else if(var_4 <= 270) {
    var_1 = randomfloatrange(-4, 4);
    var_2 = -5;
    var_3 = 270;
  }

  if(scripts\sp\utility::func_93A6()) {
    level.player.helmet = level.var_10964.helmet;
  }

  level.player.helmet _meth_83CB(level.player);
  level.player.helmet setModel("vm_hero_protagonist_helmet_glass_crack_03");
  level.player.helmet notsolid();
  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (var_0, 0, 0), (var_1, var_2, var_3), 1, "view_jostle");
}

func_1033D() {
  var_0 = randomintrange(10, 300);
  var_1 = randomintrange(300, 500);
  var_2 = [var_0, var_1];
  var_3 = randomintrange(10, 150);
  var_4 = randomintrange(150, 250);
  var_5 = [var_3, var_4];
  var_6 = scripts\engine\utility::random(var_2);
  var_7 = scripts\engine\utility::random(var_5);
  level.player.var_E6.var_91AF["blood_splat1"].x = var_6;
  level.player.var_E6.var_91AF["blood_splat1"].y = var_7;
  var_2 = scripts\engine\utility::array_remove(var_2, var_6);
  var_5 = scripts\engine\utility::array_remove(var_5, var_7);
  var_8 = 250;
  var_9 = 350;
  var_0A = 275;
  var_0B = 350;
  var_0C = 0.9;
  var_0D = 1;
  var_0E = randomintrange(var_8, var_9);
  var_0F = randomintrange(var_0A, var_0B);
  wait(0.7);
  level.player.var_E6.var_91AF["blood_splat1"] setshader("vfx_ui_player_blood_splat1", var_0E, var_0F);
  level.player.var_E6.var_91AF["blood_splat1"].alpha = randomfloatrange(var_0C, var_0D);
  level.player.var_E6.var_91AF["blood_splat2"].x = var_2[0];
  level.player.var_E6.var_91AF["blood_splat2"].y = var_5[0];
  wait(0.5);
  var_0E = randomintrange(var_8, var_9);
  var_0F = randomintrange(var_0A, var_0B);
  level.player.var_E6.var_91AF["blood_splat2"] setshader("vfx_ui_player_blood_splat2", var_0E, var_0F);
  level.player.var_E6.var_91AF["blood_splat2"].alpha = randomfloatrange(var_0C, var_0D);
}

func_A851() {
  var_0 = randomintrange(675, 690);
  var_1 = randomintrange(500, 575);
  self setshader("vfx_ui_player_blood_splat_large", var_0, var_1);
  self.x = randomintrange(-200, 200);
  self.y = randomintrange(150, 170);
  self.alpha = 1;
}

func_2BBF() {
  var_0 = randomintrange(500, 650);
  var_1 = randomintrange(150, 250);
  self setshader("vfx_ui_player_blood_drip", var_0, var_1);
  self.x = randomintrange(-90, 300);
  self.y = randomintrange(-100, -70);
  self.alpha = randomfloatrange(0.95, 1);
  self scaleovertime(60, var_1 + randomintrange(1, 3), var_0);
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

func_4E19(var_0) {
  self setshader("vfx_ui_player_death_overlay", 640, 480);
  self.alpha = scripts\engine\utility::ter_op(isDefined(var_0), var_0, randomfloatrange(0.9, 1));
  self.sort = 10;
}

func_48C9() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.ispointonnavmesh3d = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.isexplosivedamagemod = 1;
  return var_0;
}

func_11493() {
  var_0 = [];
  var_1 = level.player getcurrentweapon();
  var_0[var_0.size] = var_1;
  if(isDefined(var_1) && issubstr(var_1, "akimbofmg")) {
    while(level.player isswitchingweapon()) {
      wait(0.05);
    }
  }

  if(weaponinventorytype(var_1) == "altmode") {
    var_0[var_0.size] = adsbuttonpressed(var_1);
  } else {
    var_2 = weaponaltweaponname(var_1);
    if(var_2 != "none") {
      var_0[var_0.size] = var_2;
    }
  }

  foreach(var_4 in level.player getweaponslistall()) {
    if(!scripts\engine\utility::array_contains(var_0, var_4)) {
      level.player takeweapon(var_4);
    }
  }
}

adsbuttonpressed(var_0) {
  var_1 = getsubstr(var_0, 4);
  return var_1;
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

func_131B8(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0.var_9F != "scriptable") {
    return 0;
  }

  if(!isDefined(var_0.var_ED) || var_0.var_ED != "vehicle") {
    return 0;
  }

  level notify("new_quote_string4");
  setomnvar("ui_death_hint", 3);
  return 1;
}

func_5346(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.var_ED)) {
    return 0;
  }

  level notify("new_quote_string");
  if(issubstr(var_0.var_ED, "vehicle")) {
    setomnvar("ui_death_hint", 3);
  } else {
    setomnvar("ui_death_hint", 4);
  }

  return 1;
}

func_69BB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 func_9C9C()) {
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

func_F322(var_0) {
  level.var_4C48 = var_0;
}

func_F32E() {
  if(isDefined(level.var_4C48)) {
    var_0 = level.var_4C48;
    var_1 = int(tablelookup("sp\death_hints.csv", 1, var_0, 0));
    if(var_1 > 0) {
      setomnvar("ui_death_hint", var_1);
      return;
    }

    func_F32F();
    return;
  }

  func_F32F();
}

func_F32F() {
  var_0 = 100;
  var_1 = undefined;
  var_2 = int(tablelookup("sp\death_hints.csv", 0, var_0, 0));
  while(isDefined(var_2) && var_2 > 0) {
    var_1 = var_2;
    var_2 = int(tablelookup("sp\death_hints.csv", 0, var_0, 0));
    var_0++;
  }

  for(;;) {
    var_3 = randomintrange(100, var_1);
    if(!func_4DF6(var_3)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  setdvar("ui_deadquote_v1", var_3);
  setdvar("ui_deadquote_v2", getdvarint("ui_deadquote_v1"));
  setdvar("ui_deadquote_v3", getdvarint("ui_deadquote_v2"));
  setomnvar("ui_death_hint", var_3);
}

func_F32D(var_0, var_1, var_2, var_3, var_4) {
  if(level.var_B8D0) {
    return;
  }

  setomnvar("ui_death_hint", 0);
  if(isDefined(level.var_4C48)) {
    var_0 = level.var_4C48;
  }

  if(isDefined(var_0)) {
    var_5 = int(tablelookup("sp\death_hints.csv", 1, var_0, 0));
    if(var_5 > 0) {
      setomnvar("ui_death_hint", var_5);
      return;
    }

    func_F32F();
    return;
  }

  if(var_2 == "MOD_GRENADE" || var_2 == "MOD_GRENADE_SPLASH" || var_2 == "MOD_SUICIDE" || var_2 == "MOD_EXPLOSIVE") {
    if(level.var_7683 >= 2) {
      if(!scripts\sp\gameskill::func_B327()) {
        func_F32F();
        return;
      }
    }

    switch (var_2) {
      case "MOD_SUICIDE":
        if(level.player.var_A994 - gettime() > 3500) {
          return;
        }

        setomnvar("ui_death_hint", 2);
        break;

      case "MOD_EXPLOSIVE":
        if(level.player func_5346(var_1)) {
          return;
        }

        if(level.player func_131B8(var_4)) {
          return;
        }

        if(level.player func_69BB(var_4, var_3)) {
          return;
        }

        func_F32F();
        break;

      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
        if(isDefined(var_3) && !isweapondetonationtimed(var_3)) {
          func_F32F();
          return;
        }

        if(isDefined(var_3) && issubstr(var_3, "seeker")) {
          if(level.var_7683 == 0) {
            setomnvar("ui_death_hint", 44);
          } else {
            setomnvar("ui_death_hint", 45);
          }

          break;
        }

        if(!isDefined(var_3)) {
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

func_4DF6(var_0) {
  if(var_0 == getdvarint("ui_deadquote_v1")) {
    return 1;
  }

  if(var_0 == getdvarint("ui_deadquote_v2")) {
    return 1;
  }

  if(var_0 == getdvarint("ui_deadquote_v3")) {
    return 1;
  }

  return 0;
}

func_B02A(var_0) {
  var_1 = tablelookup("sp\deathQuoteTable.csv", 0, var_0, 1);
  if(tolower(var_1[0]) != tolower("@")) {
    var_1 = "@" + var_1;
  }

  return var_1;
}

func_F330(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1.5;
  }

  wait(var_3);
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 40;
  var_4 setshader(var_0, var_1, var_2);
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.foreground = 1;
  var_4.alpha = 0;
  var_4 fadeovertime(1);
  var_4.alpha = 1;
}

func_792C(var_0) {
  var_1 = 0;
  foreach(var_3 in level.player.var_E6.var_12AEA) {
    if(issubstr(var_0, var_3)) {
      return var_3;
    }
  }

  return "stand";
}

func_792B(var_0) {
  foreach(var_2 in level.player.var_E6.var_E9) {
    if(var_2.name == var_0) {
      return var_2;
    }
  }

  return undefined;
}

func_792A(var_0) {
  foreach(var_2 in level.player.var_E6.var_E9) {
    if(var_2.var_7789 == var_0) {
      return var_2;
    }
  }
}

func_4D03(var_0) {
  if(issubstr(var_0, "SPLASH")) {
    return 1;
  }

  if(issubstr(var_0, "GRENADE")) {
    return 1;
  }

  return 0;
}

empty_breathing_func(var_0) {}

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