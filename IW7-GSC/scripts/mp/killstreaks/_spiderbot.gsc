/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_spiderbot.gsc
*************************************************/

init() {
  level._effect["spider_explode"] = loadfx("vfx\core\expl\grenadeexp_default");
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("spiderbot", ::func_1288A);
}

func_1288A(param_00) {
  var_01 = 0;
  if(!var_01) {
    return 0;
  }

  func_10DF3(param_00.streakname);
  thread func_13B56();
  thread func_13B57();
  thread func_13B55();
  return 1;
}

func_13B56() {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  self notifyonplayercommand("manual_explode", "+attack");
  self notifyonplayercommand("manual_explode", "+attack_akimbo_accessible");
  self waittill("manual_explode");
  self notify("detonate_spiderbot");
}

func_13B58() {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  self notifyonplayercommand("toggle_thermal", "+smoke");
  var_00 = 0;
  for(;;) {
    self waittill("toggle_thermal");
    if(!var_00) {
      self thermalvisionon();
      var_00 = 1;
      continue;
    }

    self thermalvisionoff();
    var_00 = 0;
  }
}

func_13B57() {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  self notifyonplayercommand("shoot_web", "+speed_throw");
  for(;;) {
    self waittill("shoot_web");
    if(!isDefined(self.wearing_rat_king_eye)) {
      self.wearing_rat_king_eye = 1;
      var_00 = anglesToForward(self getplayerangles());
      var_01 = self getEye() + var_00 * 20 + (0, 0, 20);
      var_02 = var_01 + var_00;
      var_03 = scripts\mp\utility::_magicbullet("iw7_webhook_mp", var_01, var_02, self);
      thread func_13BB0(var_03, var_01);
      thread func_13BB1(2, var_03);
    }
  }
}

func_13BAF() {
  self notifyonplayercommand("web_cut", "+gostand");
  self waittill("web_cut");
  if(isDefined(self.wearing_rat_king_eye)) {
    self.var_AD32 = undefined;
    self.wearing_rat_king_eye = undefined;
    self unlink();
  }
}

func_13BB0(param_00, param_01) {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  self endon("web_cut");
  param_00 waittill("explode", var_02);
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_03.var_1155F = func_7F05(var_02, 50, 1, 50);
  var_03.origin = var_02;
  var_04 = scripts\engine\utility::spawn_tag_origin();
  var_04.origin = param_01;
  var_04.angles = vectortoangles(var_02 - var_04.origin);
  self.var_AD32 = var_04;
  self playerlinktoblend(var_04, "tag_origin", 0.5);
  if(isDefined(var_03.var_1155F) && isplayer(var_03.var_1155F)) {
    var_03 linkto(var_03.var_1155F);
    thread func_13B79(var_03);
    var_05 = 0.5;
    while(distance2dsquared(var_04.origin, var_03.origin) > 400 || !isDefined(var_03.var_1155F)) {
      var_04 rotateto(vectortoangles(var_03.origin - var_04.origin), 0.3);
      var_04 moveto(var_03.origin, var_05);
      wait(var_05);
      var_05 = var_05 - 0.25;
      var_05 = max(0.05, var_05);
    }

    self notify("detonate_spiderbot");
    return;
  }

  var_04 moveto(var_03.origin, 0.5);
  var_04 thread func_13AD8(var_03.origin, self);
}

func_13B79(param_00) {
  param_00 endon("death");
  self endon("detonate_spiderbot");
  param_00.var_1155F scripts\engine\utility::waittill_any_3("phase_shift_power_activated", "rewind_activated", "powers_teleport_used", "powers_transponder_used", "orbital_deployment_action", "death", "disconnect");
  param_00.var_1155F = undefined;
}

func_13AD8(param_00, param_01) {
  param_01 endon("disconnect");
  param_01 endon("detonate_spiderbot");
  param_01 endon("web_cut");
  while(self.origin != param_00) {
    scripts\engine\utility::waitframe();
  }

  param_01 notify("detonate_spiderbot");
}

func_13BB1(param_00, param_01) {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  param_01 endon("explode");
  wait(param_00);
  self.wearing_rat_king_eye = undefined;
}

func_13B55() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("detonate_spiderbot", var_00);
  var_01 = self.origin;
  var_02 = 500;
  var_03 = 200;
  if(!isDefined(var_00)) {
    radiusdamage(var_01, 256, var_02, var_03, self, "MOD_EXPLOSIVE", "killstreak_spiderbot_mp");
  }

  playFX(scripts\engine\utility::getfx("spider_explode"), var_01);
  playsoundatpos(var_01, "frag_grenade_explode");
  playrumbleonposition("grenade_rumble", var_01);
  earthquake(0.5, 0.75, var_01, 800);
  foreach(var_05 in level.players) {
    if(var_05 scripts\mp\utility::isusingremote()) {
      continue;
    }

    if(distancesquared(var_01, var_05.origin) > 360000) {
      continue;
    }

    var_05 setclientomnvar("ui_hud_shake", 1);
  }

  func_1108D();
}

func_10DF3(param_00) {
  self setclientomnvar("ui_spiderbot_controls", 1);
  self thermalvisionon();
  self thermalvisionfofoverlayon();
  func_511C(0.05, "spiderbot_steps");
  scripts\engine\utility::allow_weapon(0);
  scripts\engine\utility::allow_usability(0);
  self setsuit("spiderbot_mp");
  self setModel("alien_minion");
  self allowslide(0);
  self allowdoublejump(0);
  self allowcrouch(0);
  self allowprone(0);
  self getnumownedagentsonteambytype(0);
  self allowdodge(1);
  self _meth_8454(8);
  self setscriptablepartstate("CompassIcon", "spiderbot");
  return 1;
}

func_1108D() {
  self setclientomnvar("ui_spiderbot_controls", 0);
  self thermalvisionoff();
  self thermalvisionfofoverlayoff();
  self stopsounds();
  scripts\engine\utility::allow_weapon(1);
  scripts\engine\utility::allow_usability(1);
  if(isDefined(self.wearing_rat_king_eye)) {
    self.var_AD32 = undefined;
    self.wearing_rat_king_eye = undefined;
    self unlink();
  }

  self setscriptablepartstate("CompassIcon", "defaulticon");
}

func_7F05(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_05 = undefined;
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_06 = param_01 * param_01;
  foreach(var_08 in level.players) {
    if(func_38C1(var_08, param_00, var_06, param_02, param_03)) {
      var_05 = var_08;
      break;
    }
  }

  return var_05;
}

func_38C1(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_00.origin;
  var_06 = distance2dsquared(param_01, var_05);
  return var_06 < param_02 && !param_03 || scripts\mp\weapons::func_13C7E(param_01, var_05, param_04, param_00);
}

func_511C(param_00, param_01) {
  self endon("death");
  wait(param_00);
  self playLoopSound(param_01);
}