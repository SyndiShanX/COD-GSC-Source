/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3521.gsc
***************************************/

init() {
  level._effect["spider_explode"] = loadfx("vfx\core\expl\grenadeexp_default");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("spiderbot", ::func_1288A);
}

func_1288A(var_00) {
  var_01 = 0;

  if(!var_01)
    return 0;

  func_10DF3(var_0.streakname);
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
      var_03 = scripts\mp\utility\game::_magicbullet("iw7_webhook_mp", var_01, var_02, self);
      thread func_13BB0(var_03, var_01);
      thread func_13BB1(2, var_03);
    }
  }
}

func_13BAF() {
  self notifyonplayercommand("web_cut", "+gostand");
  self waittill("web_cut");

  if(isDefined(self.wearing_rat_king_eye)) {
    self.func_AD32 = undefined;
    self.wearing_rat_king_eye = undefined;
    self unlink();
  }
}

func_13BB0(var_00, var_01) {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  self endon("web_cut");
  var_00 waittill("explode", var_02);
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_3.func_1155F = func_7F05(var_02, 50, 1, 50);
  var_3.origin = var_02;
  var_04 = scripts\engine\utility::spawn_tag_origin();
  var_4.origin = var_01;
  var_4.angles = vectortoangles(var_02 - var_4.origin);
  self.func_AD32 = var_04;
  self getweaponweight(var_04, "tag_origin", 0.5);

  if(isDefined(var_3.func_1155F) && isplayer(var_3.func_1155F)) {
    var_03 linkto(var_3.func_1155F);
    thread func_13B79(var_03);

    for(var_05 = 0.5; distance2dsquared(var_4.origin, var_3.origin) > 400 || !isDefined(var_3.func_1155F); var_05 = max(0.05, var_05)) {
      var_04 rotateto(vectortoangles(var_3.origin - var_4.origin), 0.3);
      var_04 moveto(var_3.origin, var_05);
      wait(var_05);
      var_05 = var_05 - 0.25;
    }

    self notify("detonate_spiderbot");
  } else {
    var_04 moveto(var_3.origin, 0.5);
    var_04 thread func_13AD8(var_3.origin, self);
  }
}

func_13B79(var_00) {
  var_00 endon("death");
  self endon("detonate_spiderbot");
  var_0.func_1155F scripts\engine\utility::waittill_any("phase_shift_power_activated", "rewind_activated", "powers_teleport_used", "powers_transponder_used", "orbital_deployment_action", "death", "disconnect");
  var_0.func_1155F = undefined;
}

func_13AD8(var_00, var_01) {
  var_01 endon("disconnect");
  var_01 endon("detonate_spiderbot");
  var_01 endon("web_cut");

  while(self.origin != var_00)
    scripts\engine\utility::waitframe();

  var_01 notify("detonate_spiderbot");
}

func_13BB1(var_00, var_01) {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  var_01 endon("explode");
  wait(var_00);
  self.wearing_rat_king_eye = undefined;
}

func_13B55() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("detonate_spiderbot", var_00);
  var_01 = self.origin;
  var_02 = 500;
  var_03 = 200;

  if(!isDefined(var_00))
    radiusdamage(var_01, 256, var_02, var_03, self, "MOD_EXPLOSIVE", "killstreak_spiderbot_mp");

  playFX(scripts\engine\utility::getfx("spider_explode"), var_01);
  playLoopSound(var_01, "frag_grenade_explode");
  playrumbleonentity("grenade_rumble", var_01);
  earthquake(0.5, 0.75, var_01, 800);

  foreach(var_05 in level.players) {
    if(var_05 scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    if(distancesquared(var_01, var_5.origin) > 360000) {
      continue;
    }
    var_05 setclientomnvar("ui_hud_shake", 1);
  }

  func_1108D();
}

func_10DF3(var_00) {
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
  self getnumberoffrozenticksfromwave(0);
  self getnumownedactiveagents(0);
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
    self.func_AD32 = undefined;
    self.wearing_rat_king_eye = undefined;
    self unlink();
  }

  self setscriptablepartstate("CompassIcon", "defaulticon");
}

func_7F05(var_00, var_01, var_02, var_03) {
  var_04 = [];
  var_05 = undefined;

  if(!isDefined(var_02))
    var_02 = 0;

  if(!isDefined(var_03))
    var_03 = 0;

  var_06 = var_01 * var_01;

  foreach(var_08 in level.players) {
    if(func_38C1(var_08, var_00, var_06, var_02, var_03)) {
      var_05 = var_08;
      break;
    }
  }

  return var_05;
}

func_38C1(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_0.origin;
  var_06 = distance2dsquared(var_01, var_05);
  return var_06 < var_02 && (!var_03 || scripts\mp\weapons::func_13C7E(var_01, var_05, var_04, var_00));
}

func_511C(var_00, var_01) {
  self endon("death");
  wait(var_00);
  self playLoopSound(var_01);
}