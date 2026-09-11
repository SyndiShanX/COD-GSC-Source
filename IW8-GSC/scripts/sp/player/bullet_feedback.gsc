/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\bullet_feedback.gsc
*************************************************/

function bullet_feedback_init() {
  bullet_feedback_precache();
  thread init_player_suppression();
}

function bullet_feedback_precache() {
  precacheshader("fullscreen_whizby");
}

function init_player_suppression() {
  level.player.suppression = spawnStruct();
  level.player scripts\engine\utility::ent_flag_init("pause_suppression");
  level._effect["whizby_pist"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_pist.vfx");
  level._effect["whizby_ar"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_ar.vfx");
  level._effect["whizby_lmg"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_lmg.vfx");
  level._effect["whizby_shot"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_shot.vfx");
  level._effect["whizby_smg"] = loadfx("vfx/iw8/weap/_swoosh/vfx_swoosh_traject_01_smg.vfx");
  thread bulletwhizby_monitor();
}

function bullet_whizby_hud(var0, var1, var2) {
  var3 = scripts\engine\math::factor_value(0, 0.3, var2);
  var4 = 0.3;
  var5 = 1.75;
  var6 = 500;
  var0 = int(var0 * var6);
  var1 = int(var1 * var6);
  var7 = scripts\sp\hud_util::create_client_overlay_custom_size("fullscreen_whizby", 0, var0, var1, var4);
  var8 = 0.15;
  var7 scaleovertime(var8, int(2048 * var5), int(2048 * var5));
  var7 fadeovertime(var8 * 0.5);
  var7.alpha = var3;
  wait var8 * 0.5;
  var7 fadeovertime(var8 * 0.5);
  var7.alpha = 0;
  wait var8 * 0.5;
  var7 destroy();
}

function bulletwhizby_monitor() {
  self endon("death");
  var0 = spawnStruct();
  var0.amount = 0;
  var0.flinching = 0;
  var0.ticket = 0;

  for(;;) {
    self waittill("bulletwhizby", var1, var2, var3, var4);

    if(!shoulddobulletwhizby(var2, var1)) {
      continue;
    }

    if(!isDefined(var3) || !isDefined(var4)) {
      continue;
    }

    if(var2 <= 64) {
      var5 = level.player getEye();
      var6 = var3 + var4 * -100;
      var7 = vectorNormalize(var5 - var6);
      var8 = level.player getplayerangles();
      var9 = vectordot(anglesToForward(var8), var7);
      var7 = rotatevectorinverted(var7, var8);
      var7 = (var7[1], var7[2], var7[0]);
      var10 = 1 - scripts\engine\math::normalize_value(14, 64, var2);
      var11 = scripts\engine\math::factor_value(0.001, 0.1, var10);
      thread bullet_whizby_hud(var7[0], var7[1], var10 * (1 - abs(var9)));
      scripts\engine\utility::noself_delaycall(0.1, &earthquake, var11, 0.4, level.player.origin, 5000);
      var12 = get_whizby_fx_from_weapon(var1.weapon);
      playFX(level._effect[var12], var3, var4);
    }
  }
}

function shoulddobulletwhizby(var0, var1) {
  if(isDefined(self.nowhizby) && self.nowhizby) {
    return false;
  }

  if(!isDefined(var0)) {
    return false;
  }

  if(!isDefined(var1)) {
    return false;
  }

  if(!isai(var1)) {
    return false;
  }

  if(!isalive(var1)) {
    return false;
  }

  return true;
}

function get_whizby_fx_from_weapon(var0) {
  var1 = undefined;

  switch (weaponclass(var0)) {
    case "mg":
      var1 = "whizby_lmg";
      break;
    case "pistol":
      var1 = "whizby_pist";
      break;
    case "rifle":
      var1 = "whizby_ar";
      break;
    case "smg":
      var1 = "whizby_smg";
      break;
    case "sniper":
      var1 = "whizby_lmg";
      break;
    case "spread":
      var1 = "whizby_shot";
      break;
    default:
      var1 = "whizby_ar";
      break;
  }

  return var1;
}

function do_whizby_flinch(var0, var1) {
  var0 *= 0.3;
  var2 = self.ticket;

  if(self.ticket >= 100) {
    self.ticket = 0;
  } else {
    self.ticket++;
  }

  var3 = vectorNormalize(level.player getEye() - var1);
  var4 = level.player getEye();
  var5 = level.player getplayerangles();
  var3 = rotatevectorinverted(var3, var5);
  var3 = (var3[0] * -1, var3[1], var3[2] * -1);

  if(getdvarint("scr_suppression_debug")) {
    var6 = anglesToForward(var5) * var3[0] * 5;
    var7 = anglestoright(var5) * var3[1] * 5;
    var8 = anglestoup(var5) * var3[2] * 5;
  }

  self.flinching = 1;
  var9 = 0.96;
  var10 = 0.4;
  var11 = 0.7;
  var12 = 0.2;
  var13 = 0;
  var14 = 0;

  while(var14 < var0 * 0.95) {
    var13 = scripts\engine\math::lerp(var13, var0, var9);
    var14 = scripts\engine\math::lerp(var14, var13, var11);
    set_flinch_values(var14, var3, var2);
    wait 0.05;
  }

  while(var14 > 0.005) {
    var13 = scripts\engine\math::lerp(var13, 0, var10);
    var14 = scripts\engine\math::lerp(var14, var13, var12);
    set_flinch_values(var14, var3, var2);
    wait 0.05;
  }

  set_flinch_values(0, var3, var2);
  self.flinching = 0;
}

function set_flinch_values(var0, var1, var2) {
  var3 = "whizyby" + var2;

  if(var0 == 0) {
    if(isDefined(level.player.viewblender["viewPos"].channels)) {
      level.player.viewblender["viewPos"].channels = scripts\engine\sp\utility::array_remove_key_array(level.player.viewblender["viewPos"].channels, [var3]);
      level.player.viewblender["weapPos"].channels = scripts\engine\sp\utility::array_remove_key_array(level.player.viewblender["weapPos"].channels, [var3]);
      level.player.viewblender["weapAng"].channels = scripts\engine\sp\utility::array_remove_key_array(level.player.viewblender["weapAng"].channels, [var3]);
    }

    return;
  }

  self.amount = var0;
  var4 = var1 * var0;
  var4 = (var0 * -1, var4[1], var0 * -1);
  level.player.viewblender["viewPos"].channels[var3] = var0 * (0, -1.3, -2.4);
  level.player.viewblender["weapPos"].channels[var3] = var0 * (0, 0.15, 0.3);
  level.player.viewblender["weapAng"].channels[var3] = var0 * (0, 1.15, 1.3);
}

function update_suppression_value(var0) {
  var1 = 0.25;
  var2 = 0.05;
  var3 = scripts\engine\math::normalize_value(0, 64, var0);
  var4 = scripts\engine\math::factor_value(var1, var2, var3);
  var5 = self.suppression.amount + var4;
  self.suppression.amount = scripts\engine\utility::ter_op(var5 <= 1, var5, 1);
  self.suppression.lastwhizbytime = gettime();
}

function suppression_monitor() {
  self.suppression.amount = 0;
  self.suppression.lastwhizbytime = 0;
  self.suppression.lastgrunttime = 0;

  for(;;) {
    scripts\engine\utility::ent_flag_waitopen("pause_suppression");

    if(gettime() - self.suppression.lastwhizbytime > 1500) {
      var0 = self.suppression.amount - 0.025;
      self.suppression.amount = scripts\engine\utility::ter_op(var0 >= 0, var0, 0);
    }

    if(should_grunt()) {
      play_grunt();
    }

    wait 0.05;
  }
}

function should_grunt() {
  if(level.player.suppression.amount < 1) {
    return false;
  }

  if(level.player.health / 100 < level.player.gs.healthoverlaycutoff) {
    return false;
  }

  if(gettime() - level.player.suppression.lastgrunttime < 12000) {
    return false;
  }

  return true;
}

function play_grunt() {
  level.player.suppression.lastgrunttime = gettime();
  level.player playSound("plr_breath_offhand_throw");
}