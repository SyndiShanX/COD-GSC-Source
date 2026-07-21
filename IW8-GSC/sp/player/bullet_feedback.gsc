/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\bullet_feedback.gsc
***********************************************/

bullet_feedback_init() {
  bullet_feedback_precache();
  thread init_player_suppression();
}

bullet_feedback_precache() {
  precacheshader("fullscreen_whizby");
}

init_player_suppression() {
  level.player.suppression = spawnStruct();
  level.player scripts\engine\utility::ent_flag_init("pause_suppression");
  level._effect["whizby_pist"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_pist.vfx");
  level._effect["whizby_ar"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_ar.vfx");
  level._effect["whizby_lmg"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_lmg.vfx");
  level._effect["whizby_shot"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_shot.vfx");
  level._effect["whizby_smg"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_smg.vfx");
  level.player thread bulletwhizby_monitor();
}

bullet_whizby_hud(var_0, var_1, var_2) {
  var_3 = scripts\engine\math::factor_value(0, 0.3, var_2);
  var_4 = 0.3;
  var_5 = 1.75;
  var_6 = 500;
  var_0 = int(var_0 * var_6);
  var_1 = int(var_1 * var_6);
  var_7 = scripts\sp\hud_util::create_client_overlay_custom_size("fullscreen_whizby", 0, var_0, var_1, var_4);
  var_8 = 0.15;
  var_7 scaleovertime(var_8, int(2048 * var_5), int(2048 * var_5));
  var_7 fadeovertime(var_8 * 0.5);
  var_7.alpha = var_3;
  wait(var_8 * 0.5);
  var_7 fadeovertime(var_8 * 0.5);
  var_7.alpha = 0;
  wait(var_8 * 0.5);
  var_7 destroy();
}

bulletwhizby_monitor() {
  self endon("death");
  var_0 = spawnStruct();
  var_0.amount = 0;
  var_0.flinching = 0;
  var_0.ticket = 0;

  for(;;) {
    self waittill("bulletwhizby", var_1, var_2, var_3, var_4);

    if(!shoulddobulletwhizby(var_2, var_1)) {
      continue;
    }
    if(!isDefined(var_3) || !isDefined(var_4)) {
      continue;
    }
    if(var_2 <= 64) {
      var_5 = level.player getEye();
      var_6 = var_3 + var_4 * -100;
      var_7 = vectorNormalize(var_5 - var_6);
      var_8 = level.player getplayerangles();
      var_9 = vectordot(anglesToForward(var_8), var_7);
      var_7 = rotatevectorinverted(var_7, var_8);
      var_7 = (var_7[1], var_7[2], var_7[0]);
      var_10 = 1 - scripts\engine\math::normalize_value(14, 64, var_2);
      var_11 = scripts\engine\math::factor_value(0.001, 0.1, var_10);
      thread bullet_whizby_hud(var_7[0], var_7[1], var_10 * (1 - abs(var_9)));
      scripts\engine\utility::noself_delaycall(0.1, ::earthquake, var_11, 0.4, level.player.origin, 5000);
      var_12 = get_whizby_fx_from_weapon(var_1.weapon);
      playFX(level._effect[var_12], var_3, var_4);
    }
  }
}

shoulddobulletwhizby(var_0, var_1) {
  if(isDefined(self.nowhizby) && self.nowhizby)
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_1))
    return 0;

  if(!isai(var_1))
    return 0;

  if(!isalive(var_1))
    return 0;

  return 1;
}

get_whizby_fx_from_weapon(var_0) {
  var_1 = undefined;

  switch (weaponclass(var_0)) {
    case "mg":
      var_1 = "whizby_lmg";
      break;
    case "pistol":
      var_1 = "whizby_pist";
      break;
    case "rifle":
      var_1 = "whizby_ar";
      break;
    case "smg":
      var_1 = "whizby_smg";
      break;
    case "sniper":
      var_1 = "whizby_lmg";
      break;
    case "spread":
      var_1 = "whizby_shot";
      break;
    default:
      var_1 = "whizby_ar";
  }

  return var_1;
}

do_whizby_flinch(var_0, var_1) {
  var_0 = var_0 * 0.3;
  var_2 = self.ticket;

  if(self.ticket >= 100)
    self.ticket = 0;
  else
    self.ticket++;

  var_3 = vectorNormalize(level.player getEye() - var_1);
  var_4 = level.player getEye();
  var_5 = level.player getplayerangles();
  var_3 = rotatevectorinverted(var_3, var_5);
  var_3 = (var_3[0] * -1, var_3[1], var_3[2] * -1);

  if(getdvarint("scr_suppression_debug")) {
    var_6 = anglesToForward(var_5) * var_3[0] * 5;
    var_7 = anglestoright(var_5) * var_3[1] * 5;
    var_8 = anglestoup(var_5) * var_3[2] * 5;
  }

  self.flinching = 1;
  var_9 = 0.96;
  var_10 = 0.4;
  var_11 = 0.7;
  var_12 = 0.2;
  var_13 = 0;
  var_14 = 0;

  while(var_14 < var_0 * 0.95) {
    var_13 = scripts\engine\math::lerp(var_13, var_0, var_9);
    var_14 = scripts\engine\math::lerp(var_14, var_13, var_11);
    set_flinch_values(var_14, var_3, var_2);
    wait 0.05;
  }

  while(var_14 > 0.005) {
    var_13 = scripts\engine\math::lerp(var_13, 0, var_10);
    var_14 = scripts\engine\math::lerp(var_14, var_13, var_12);
    set_flinch_values(var_14, var_3, var_2);
    wait 0.05;
  }

  set_flinch_values(0, var_3, var_2);
  self.flinching = 0;
}

set_flinch_values(var_0, var_1, var_2) {
  var_3 = "whizyby" + var_2;

  if(var_0 == 0) {
    if(isDefined(level.player.viewblender["viewPos"].channels)) {
      level.player.viewblender["viewPos"].channels = scripts\engine\sp\utility::array_remove_key_array(level.player.viewblender["viewPos"].channels, [var_3]);
      level.player.viewblender["weapPos"].channels = scripts\engine\sp\utility::array_remove_key_array(level.player.viewblender["weapPos"].channels, [var_3]);
      level.player.viewblender["weapAng"].channels = scripts\engine\sp\utility::array_remove_key_array(level.player.viewblender["weapAng"].channels, [var_3]);
    }

    return;
  }

  self.amount = var_0;
  var_4 = var_1 * var_0;
  var_4 = (var_0 * -1, var_4[1], var_0 * -1);
  level.player.viewblender["viewPos"].channels[var_3] = var_0 * (0, -1.3, -2.4);
  level.player.viewblender["weapPos"].channels[var_3] = var_0 * (0, 0.15, 0.3);
  level.player.viewblender["weapAng"].channels[var_3] = var_0 * (0, 1.15, 1.3);
}

update_suppression_value(var_0) {
  var_1 = 0.25;
  var_2 = 0.05;
  var_3 = scripts\engine\math::normalize_value(0, 64, var_0);
  var_4 = scripts\engine\math::factor_value(var_1, var_2, var_3);
  var_5 = self.suppression.amount + var_4;
  self.suppression.amount = scripts\engine\utility::ter_op(var_5 <= 1, var_5, 1);
  self.suppression.lastwhizbytime = gettime();
}

suppression_monitor() {
  self.suppression.amount = 0;
  self.suppression.lastwhizbytime = 0;
  self.suppression.lastgrunttime = 0;

  for(;;) {
    scripts\engine\utility::ent_flag_waitopen("pause_suppression");

    if(gettime() - self.suppression.lastwhizbytime > 1500) {
      var_0 = self.suppression.amount - 0.025;
      self.suppression.amount = scripts\engine\utility::ter_op(var_0 >= 0, var_0, 0);
    }

    if(should_grunt())
      play_grunt();

    wait 0.05;
  }
}

should_grunt() {
  if(level.player.suppression.amount < 1)
    return 0;

  if(level.player.health / 100 < level.player.gs.healthoverlaycutoff)
    return 0;

  if(gettime() - level.player.suppression.lastgrunttime < 12000)
    return 0;

  return 1;
}

play_grunt() {
  level.player.suppression.lastgrunttime = gettime();
  level.player playSound("plr_breath_offhand_throw");
}