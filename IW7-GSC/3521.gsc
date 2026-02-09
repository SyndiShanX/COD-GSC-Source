/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3521.gsc
**************************************/

init() {
  level._effect["spider_explode"] = loadfx("vfx\core\expl\grenadeexp_default");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("spiderbot", ::func_1288A);
}

func_1288A(var_0) {
  var_1 = 0;

  if(!var_1) {
    return 0;
  }

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
  var_0 = 0;

  for(;;) {
    self waittill("toggle_thermal");

    if(!var_0) {
      self thermalvisionon();
      var_0 = 1;
      continue;
    }

    self thermalvisionoff();
    var_0 = 0;
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
      var_0 = anglesToForward(self getplayerangles());
      var_1 = self getEye() + var_0 * 20 + (0, 0, 20);
      var_2 = var_1 + var_0;
      var_3 = scripts\mp\utility\game::_magicbullet("iw7_webhook_mp", var_1, var_2, self);
      thread func_13BB0(var_3, var_1);
      thread func_13BB1(2, var_3);
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

func_13BB0(var_0, var_1) {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  self endon("web_cut");
  var_0 waittill("explode", var_2);
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3.var_1155F = func_7F05(var_2, 50, 1, 50);
  var_3.origin = var_2;
  var_4 = scripts\engine\utility::spawn_tag_origin();
  var_4.origin = var_1;
  var_4.angles = vectortoangles(var_2 - var_4.origin);
  self.var_AD32 = var_4;
  self getweaponweight(var_4, "tag_origin", 0.5);

  if(isDefined(var_3.var_1155F) && isPlayer(var_3.var_1155F)) {
    var_3 linkto(var_3.var_1155F);
    thread func_13B79(var_3);

    for(var_5 = 0.5; distance2dsquared(var_4.origin, var_3.origin) > 400 || !isDefined(var_3.var_1155F); var_5 = max(0.05, var_5)) {
      var_4 rotateto(vectortoangles(var_3.origin - var_4.origin), 0.3);
      var_4 moveto(var_3.origin, var_5);
      wait(var_5);
      var_5 = var_5 - 0.25;
    }

    self notify("detonate_spiderbot");
  } else {
    var_4 moveto(var_3.origin, 0.5);
    var_4 thread func_13AD8(var_3.origin, self);
  }
}

func_13B79(var_0) {
  var_0 endon("death");
  self endon("detonate_spiderbot");
  var_0.var_1155F scripts\engine\utility::waittill_any("phase_shift_power_activated", "rewind_activated", "powers_teleport_used", "powers_transponder_used", "orbital_deployment_action", "death", "disconnect");
  var_0.var_1155F = undefined;
}

func_13AD8(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("detonate_spiderbot");
  var_1 endon("web_cut");

  while(self.origin != var_0) {
    scripts\engine\utility::waitframe();
  }

  var_1 notify("detonate_spiderbot");
}

func_13BB1(var_0, var_1) {
  self endon("disconnect");
  self endon("detonate_spiderbot");
  var_1 endon("explode");
  wait(var_0);
  self.wearing_rat_king_eye = undefined;
}

func_13B55() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("detonate_spiderbot", var_0);
  var_1 = self.origin;
  var_2 = 500;
  var_3 = 200;

  if(!isDefined(var_0)) {
    radiusdamage(var_1, 256, var_2, var_3, self, "MOD_EXPLOSIVE", "killstreak_spiderbot_mp");
  }

  playFX(scripts\engine\utility::getfx("spider_explode"), var_1);
  playLoopSound(var_1, "frag_grenade_explode");
  playrumbleonentity("grenade_rumble", var_1);
  earthquake(0.5, 0.75, var_1, 800);

  foreach(var_5 in level.players) {
    if(var_5 scripts\mp\utility\game::isusingremote()) {
      continue;
    }
    if(distancesquared(var_1, var_5.origin) > 360000) {
      continue;
    }
    var_5 setclientomnvar("ui_hud_shake", 1);
  }

  func_1108D();
}

func_10DF3(var_0) {
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
  self func_8454(8);
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

func_7F05(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = undefined;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_6 = var_1 * var_1;

  foreach(var_8 in level.players) {
    if(func_38C1(var_8, var_0, var_6, var_2, var_3)) {
      var_5 = var_8;
      break;
    }
  }

  return var_5;
}

func_38C1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.origin;
  var_6 = distance2dsquared(var_1, var_5);
  return var_6 < var_2 && (!var_3 || scripts\mp\weapons::func_13C7E(var_1, var_5, var_4, var_0));
}

func_511C(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self playLoopSound(var_1);
}