/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\stealth\social.gsc
*****************************************/

#using scripts\common\values;
#using scripts\engine\utility;
#namespace social;

function init() {
  utility::flag_init("\x82\x15\x14V.[\xf3\xa78\xbd\xe8\xb4\xb9o\xe7p0\xbe");
  level.var_7827c6737df9caca = &playersetsocial;
  val::register("\xa4\xdb\xfb\xd4\xd4\xc0\x0e\xfb\xa7\x18\xea\x12o\xee\x89\xf5~z", 0, 1, "\x127\xca\x8d3", &function_2590f6dd10a9cb8d, "~\xa9\xccdcE");
}

function private function_2590f6dd10a9cb8d(restricted = 1) {
  player = self;

  if(istrue(restricted)) {
    player val::set(" Dk8I\x13\xd6bn\xee\x80X\x96x]#\xc0\tm0", "\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9", 1);
    utility::flag_set("\x82\x15\x14V.[\xf3\xa78\xbd\xe8\xb4\xb9o\xe7p0\xbe");

    if(isDefined(level.compass_messaging.var_f510c4f96dfe543b)) {
      player thread[[level.compass_messaging.var_f510c4f96dfe543b]]("\xb7y'\x10\x80\x11{8\xcb\x90\x1f\xd5k\xb3\xf7");
    }

    return;
  }

  if(isDefined(level.compass_messaging.var_4d085ec06e095698)) {
    player thread[[level.compass_messaging.var_4d085ec06e095698]]("\xb7y'\x10\x80\x11{8\xcb\x90\x1f\xd5k\xb3\xf7");
  }

  player val::reset_all(" Dk8I\x13\xd6bn\xee\x80X\x96x]#\xc0\tm0");
  utility::flag_clear("\x82\x15\x14V.[\xf3\xa78\xbd\xe8\xb4\xb9o\xe7p0\xbe");
}

function private function_aaca935095c2d6eb() {
  var_db4bd6e2aa4f9724 = getEntArray("\\\v\xec\x9a\x94cYo\x9a\xa9\xe2\v\xc7\x83~^\xe3", #targetname);

  foreach(trigger in var_db4bd6e2aa4f9724) {
    childthread playersocialtrespasstriggermon(trigger);
  }
}

function private playersocialtrespasstriggermon(trigger) {
  player = self;
  trigger endon("\x1e\xfd\xd1\xa2\a");
  valkey = "4d\xbf\xf5\x8b\x18\xff<,\x8e8;<5 q^|\xac\xf9\xc0.r\x9f\xe2\r\x03\xbd\x9d\x06\xf7" + trigger getentitynumber();
  trigger notify(valkey);
  trigger endon(valkey);

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", triggeredplayer);

    if(triggeredplayer != player) {
      continue;
    }

    player notify(" Dk8I\x13\xd6bn\xee\x80X\x96x]#\xc0\tm0", trigger);
    player val::set(valkey, "\xa4\xdb\xfb\xd4\xd4\xc0\x0e\xfb\xa7\x18\xea\x12o\xee\x89\xf5~z", 1);

    while(player istouching(trigger)) {
      waitframe();
    }

    player val::reset_all(valkey);
  }
}

function playersetsocial(enabled, var_55e513fe88b639c7, var_4e456e9de39636e0, enemygroup) {
  assert(isPlayer(self));

  if(enabled == self.var_f5c244e0b6685419 && !(isDefined(var_4e456e9de39636e0) && isDefined(var_55e513fe88b639c7) && isDefined(enemygroup))) {
    return;
  }

  if(istrue(enabled)) {
    if(!isDefined(var_55e513fe88b639c7)) {
      var_55e513fe88b639c7 = "K_p\x84a\x01";
    }

    if(!isDefined(var_4e456e9de39636e0)) {
      var_4e456e9de39636e0 = "+H\xb3\x9d\x12\xf1\x14\x1f\x16\xa6\xed\xfe7\xf7";
    }

    if(!isDefined(enemygroup)) {
      enemygroup = "?\xb1\xc0\x9a";
    }

    createthreatbiasgroup(var_55e513fe88b639c7);
    createthreatbiasgroup(var_4e456e9de39636e0);
    createthreatbiasgroup(enemygroup);
    setignoremegroup(var_4e456e9de39636e0, enemygroup);
    self.socialnormal = var_55e513fe88b639c7;
    self.socialignored = var_4e456e9de39636e0;
    thread function_42b22bf2879a98b5();
  } else {
    thread function_4412e3e978b2d111();
  }

  self.var_f5c244e0b6685419 = enabled;
}

function function_42b22bf2879a98b5() {
  assert(isPlayer(self));

  if(!utility::ent_flag_exist("\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9")) {
    utility::ent_flag_init("\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9");
  }

  thread playersocialthread();
}

function function_4412e3e978b2d111() {
  assert(isPlayer(self));
  self notify("\xc8|\xd5a<\x9a\xf1\n6\x15N\x9b\x06\x81o\x10\xf7\xe1");
  val::reset_all("\x91\x8a-u\xcd\xa3\xeeda\xec[X\xd8\xae\xa63\xc9cs\xe0p5 \fP");
  val::reset_all(" Dk8I\x13\xd6bn\xee\x80X\x96x]#\xc0\tm0");

  if(isDefined(self.socialnormal)) {
    self setthreatbiasgroup(self.socialnormal);
  }

  self.socialnormal = undefined;
  self.socialignored = undefined;
}

function private playersocialthread() {
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self notify("\xc8|\xd5a<\x9a\xf1\n6\x15N\x9b\x06\x81o\x10\xf7\xe1");
  self endon("\xc8|\xd5a<\x9a\xf1\n6\x15N\x9b\x06\x81o\x10\xf7\xe1");

  if(!istrue(level.stealth.var_43e59037374c630a)) {
    childthread function_b7690ace1e5c124e();
  }

  childthread function_aaca935095c2d6eb();

  while(true) {
    if(!utility::ent_flag("\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9")) {
      self setthreatbiasgroup(self.socialignored);
    }

    utility::ent_flag_wait("\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9");
    severity = val::get("\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9");
    var_efd2921022ba380b = 1;

    if(severity >= 2) {
      var_efd2921022ba380b = 0;
    }

    self setthreatbiasgroup(self.socialnormal);
    utility::function_18e9f1084badc1c7("\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9");

    while(function_d04b7ed3ce995a49(self) > var_efd2921022ba380b || level utility::flag("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed")) {
      wait 1;
    }
  }
}

function private function_b7690ace1e5c124e() {
  assert(isPlayer(self));

  while(true) {
    revealed = 0;
    weapon = self getcurrentweapon();

    if((weapon.classname ?? ")\xb8\xb6\xfe") != ")\xb8\xb6\xfe" && weapon.classname != "\r+x5") {
      revealed = 1;
    }

    if(revealed) {
      val::set("\x91\x8a-u\xcd\xa3\xeeda\xec[X\xd8\xae\xa63\xc9cs\xe0p5 \fP", "\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9", 1);
    } else {
      val::reset_all("\x91\x8a-u\xcd\xa3\xeeda\xec[X\xd8\xae\xa63\xc9cs\xe0p5 \fP");
    }

    waitframe();
  }
}