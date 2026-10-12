/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\playerhealth.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\supers\med_box;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace playerhealth;

function init_playerhealth() {
  if(!isDefined(level.var_be39d6b46044f344)) {
    level.var_be39d6b46044f344 = 40;
  }

  setdevdvarifuninitialized(@ "hash_9e41eb34980a2301", 0);
}

function manageplayerregen() {
  self.deathsdoor = 0;
  self.deathsdoorsfx = 0;
  self.var_632fcfdf269b9dc8 = -99999;
  self.hasdonepainbreathloopthislife = 0;
  self.healing = 0;
  self stoplocalsound("deaths_door_out");
  self stoplocalsound("deaths_door_in");
  thread scripts\common\damage_effects::function_a2b4e6088394bade();
  thread function_c12e5fda7dc648ce();
  thread function_fb3404dca14b5916();

  thread function_31a13be1530a809b();
}

function private function_c12e5fda7dc648ce() {
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll");

  while(true) {
    self waittill("damage", idamage, eattacker, vhitdir, vpoint, smeansofdeath);

    var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

    if(var_4552ad49778498ee) {
      if(isDefined(idamage)) {
        print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x21>" + idamage);
      }
    }

    thread naturalhealthregen(smeansofdeath);
  }
}

function private naturalhealthregen(smeansofdeath) {
  var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

  if(var_4552ad49778498ee) {
    print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x46>");
  }

  if(!isreallyalive(self)) {
    return;
  }

  if(istrue(level.healthregendisabled)) {
    return;
  }

  self.var_73b0186b9643675a = undefined;
  self.currentregendelay = undefined;
  self notify("naturalHealthRegen");
  self endon("naturalHealthRegen");
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll");
  level endon("game_ended");
  self.healing = 0;

  while(istrue(level.healthregendisabled) && isusingremote()) {
    waitframe();
  }

  function_19b9bb9cef6a2d3();
  waitforhealthregendelay();
  healovertime();
}

function private function_fb3404dca14b5916() {
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll");

  while(true) {
    self waittill("force_regeneration");
    self.forcedregeneration = 1;

    var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

    if(var_4552ad49778498ee) {
      print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x6c>");
    }

    thread healovertime();
  }
}

function private waitforhealthregendelay() {
  if(isDefined(self.var_908c151f034b37e8)) {
    if(!istrue(self.var_7d5dc55c0e7c065b)) {
      thread scripts\cp_mp\supers\med_box::function_44ec1c3e385bd14b();
    }
  }

  var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

  if(var_4552ad49778498ee) {
    print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x90>");
  }

  while(istrue(self.healthregendisabled) || !val::get("health_regen") || istrue(self.var_35116e057346139e)) {
    waitframe();
  }

  var_399288f08aaf56e5 = gettime();
  self.var_73b0186b9643675a = var_399288f08aaf56e5;
  self.currentregendelay = function_5c0987ada94437df();

  while(self.currentregendelay > 0) {
    self.currentregendelay = function_5c0987ada94437df(self.var_73b0186b9643675a);
    assert(self.var_73b0186b9643675a == var_399288f08aaf56e5);
    wait 0.05;
  }

  if(isDefined(level.gametype) && level.gametype == "dungeons") {
    while(utility::damageflag(2)) {
      waitframe();
    }
  }

  var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

  if(var_4552ad49778498ee) {
    print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:xbb>");
  }

  self.currentregendelay = undefined;
  self.var_73b0186b9643675a = undefined;
}

function private healovertime() {
  naturalheal = !istrue(self.adrenalinepoweractive) && !istrue(self.var_808d06ddfc93a4e4) && !istrue(self.bandageactive) && !istrue(self.laststandhealisactive);

  if(naturalheal && istrue(self.healing)) {
    return;
  }

  if(!_isalive()) {
    return;
  }

  var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

  if(var_4552ad49778498ee) {
    print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:xe4>");
  }

  self notify("healOverTimeThink");
  self endon("healOverTimeThink");
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll");
  self endon("damage");
  level endon("game_ended");
  var_7f86cf029bef696d = istrue(self.adrenalinepoweractive);
  starthealth = self.health;
  var_9cab7fb3eaa1ac48 = 0;
  var_2a0c127782c20593 = function_ffa24fdcb2f2f661(naturalheal);

  while(self.health / self.maxhealth < var_2a0c127782c20593) {
    if(!val::get("health_regen") || istrue(self.healthregendisabled) && naturalheal) {
      self.healing = 0;
      return;
    }

    self.healing = 1;
    function_326da60065b28039();
    var_9cab7fb3eaa1ac48 += gethealthperframe();
    self.health = int(min(self.maxhealth, var_9cab7fb3eaa1ac48 + self.health));
    function_25bcb1f5ecb2c04e();
    var_9cab7fb3eaa1ac48 %= 1;
    function_19b9bb9cef6a2d3();
    wait 0.05;
  }

  self.healing = 0;

  if(isDefined(self.var_908c151f034b37e8)) {
    thread scripts\cp_mp\supers\med_box::function_6ed51e2f80c93fa6();
  }

  if(isDefined(self.forcedregeneration)) {
    self.forcedregeneration = undefined;
  }

  if(self.health >= self.maxhealth) {
    onfullhealth(starthealth, naturalheal, var_7f86cf029bef696d);
    function_19b9bb9cef6a2d3();
  }
}

function private function_79429693a2f7755d(var_22b5b902570c2d6, var_33a536d1dbc55784) {
  assert(isDefined(var_22b5b902570c2d6));
  assert(isDefined(var_33a536d1dbc55784) && isfloat(var_33a536d1dbc55784));
  assert(isDefined(self) && isPlayer(self));

  if(!isDefined(self.var_278adeade4a9e3a5)) {
    self.var_278adeade4a9e3a5 = [];
  }

  if(array_contains_key(self.var_278adeade4a9e3a5, var_22b5b902570c2d6)) {
    return false;
  } else {
    self.var_278adeade4a9e3a5[var_22b5b902570c2d6] = var_33a536d1dbc55784;

    var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

    if(var_4552ad49778498ee) {
      print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x104>" + var_22b5b902570c2d6);
    }

    return true;
  }

  return false;
}

function function_5457f0107a845374(var_22b5b902570c2d6, var_33a536d1dbc55784, var_5b1d349f3d7879ee) {
  function_79429693a2f7755d(var_22b5b902570c2d6, var_33a536d1dbc55784);

  if(isDefined(var_5b1d349f3d7879ee)) {
    thread regenmodifiertimeoutthread(var_22b5b902570c2d6, var_5b1d349f3d7879ee);
  }
}

function private regenmodifiertimeoutthread(var_22b5b902570c2d6, var_3669ac207c224e12) {
  level endon("game_ended");
  self notify("regenModifierTimeoutThread_" + var_22b5b902570c2d6);
  self endon("regenModifierTimeoutThread_" + var_22b5b902570c2d6);
  waittill_any_timeout_1(var_3669ac207c224e12 / 1000, "death_or_disconnect");
  function_4f8b5efd1816f6c3(var_22b5b902570c2d6);
}

function function_4f8b5efd1816f6c3(var_22b5b902570c2d6) {
  assert(isDefined(var_22b5b902570c2d6));
  assert(isDefined(self) && isPlayer(self));

  if(!isDefined(self) || !isDefined(self.var_278adeade4a9e3a5)) {
    return false;
  }

  if(array_contains_key(self.var_278adeade4a9e3a5, var_22b5b902570c2d6)) {
    self.var_278adeade4a9e3a5 = array_remove_key(self.var_278adeade4a9e3a5, var_22b5b902570c2d6);

    var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

    if(var_4552ad49778498ee) {
      print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x132>" + var_22b5b902570c2d6);
    }

    return true;
  }

  return false;
}

function function_7e8e4a9f891d5806() {
  if(isDefined(self.var_73b0186b9643675a)) {
    return function_5c0987ada94437df(self.var_73b0186b9643675a);
  }

  return undefined;
}

function function_5c0987ada94437df(var_136d4cb8aa835cfb) {
  var_3d45dcb5c34b2867 = 5000;
  var_f17191554cd9309e = var_3d45dcb5c34b2867;

  if(!isDefined(self.regendelayspeed)) {
    self.regendelayspeed = 1;
  }

  if(isDefined(level.regendelayspeedfunc)) {
    self.regendelayspeed = [[level.regendelayspeedfunc]](self.regendelayspeed);

    var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

    if(var_4552ad49778498ee) {
      print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x15b>" + self.regendelayspeed);
    }
  }

  if(isDefined(self.var_908c151f034b37e8)) {
    var_3d45dcb5c34b2867 = ceil(var_f17191554cd9309e * self.var_908c151f034b37e8);
  } else {
    regenscalar = max(2 - function_71005b327450d873() - self.regendelayspeed, 0);

    if(isDefined(level.var_ddc10ba2983b0b0c) && player_hasperk("specialty_elasomer_pads")) {
      regenscalar *= level.var_ddc10ba2983b0b0c;
    }

    if(isDefined(self.var_93d588c5ef8b2dec)) {
      var_3d45dcb5c34b2867 = self.var_93d588c5ef8b2dec * 1000;
    } else if(isDefined(level.healthregendelay)) {
      var_3d45dcb5c34b2867 = ceil(level.healthregendelay * 1000 * regenscalar);
    } else if(isDefined(self.gs.healthregendelay)) {
      var_3d45dcb5c34b2867 = self.gs.healthregendelay * 1000;
    } else {
      var_3d45dcb5c34b2867 = ceil(5000 * regenscalar);
    }

    if(getdvarint(@ "scr_override_health_regen_delay_ms", -1) > 0) {
      regendelayoverride = getdvarint(@ "scr_override_health_regen_delay_ms", -1);
      var_3d45dcb5c34b2867 = ceil(regendelayoverride * regenscalar);
    }
  }

  if(isDefined(var_136d4cb8aa835cfb)) {
    timeoffset = gettime();
    timeoffset -= var_136d4cb8aa835cfb;
    var_3d45dcb5c34b2867 -= timeoffset;
  }

  var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

  if(var_4552ad49778498ee) {
    print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x19e>" + var_3d45dcb5c34b2867);
  }

  return max(var_3d45dcb5c34b2867, 0);
}

function private function_71005b327450d873() {
  assert(isDefined(self) && isPlayer(self));
  var_e9e9e13b20a550ab = 0;

  if(isDefined(self.var_278adeade4a9e3a5)) {
    foreach(mod in self.var_278adeade4a9e3a5) {
      var_e9e9e13b20a550ab += mod;
    }

    var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

    if(var_4552ad49778498ee) {
      print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x1be>" + var_e9e9e13b20a550ab);
    }
  }

  return var_e9e9e13b20a550ab;
}

function function_ffa24fdcb2f2f661(naturalheal) {
  if(naturalheal && isDefined(level.var_e148f7d0b42fe6da)) {
    return level.var_e148f7d0b42fe6da;
  }

  return 1;
}

function private function_326da60065b28039() {
  if(isDefined(self.var_eaa417c82fc6f913)) {
    self[[self.var_eaa417c82fc6f913]]();
  }

  if(isDefined(self.var_4aec8a632dc40e2c) && !isDefined(self.forcedregeneration) && self.health != self.maxhealth) {
    self[[self.var_4aec8a632dc40e2c]]();
  }
}

function gethealthperframe() {
  if(function_244067e915c0eabe()) {
    var_881fb15f4d296741 = level.playermaxhealth / 150;
  } else {
    var_881fb15f4d296741 = 1;
  }

  healthperframe = level.var_be39d6b46044f344 * 0.05 * var_881fb15f4d296741;

  if(getdvarint(@ "scr_override_health_regen_per_sec", 0) > 0) {
    var_fbb0e274527f2097 = getdvarint(@ "scr_override_health_regen_per_sec", 0);
    healthperframe = var_fbb0e274527f2097 * 0.05 * var_881fb15f4d296741;
  }

  if(issharedfuncdefined("player", "getGametypeHealthPerFrame")) {
    healthperframe = self[[getsharedfunc("player", "getGametypeHealthPerFrame")]]();
  } else if(player_hasperk("specialty_regenfaster") && isDefined(level.regenfasterhealthmod)) {
    healthperframe *= level.regenfasterhealthmod;
  }

  if(isDefined(level.regenhealthaddfunc)) {
    healthperframe = [[level.regenhealthaddfunc]](healthperframe);
  }

  callbackparams = {
    #var_7f2add2da3f0d3bf: 1
  };
  callback::callback(#"hash_6a8a551945faab9", callbackparams);
  healthperframe *= callbackparams.var_7f2add2da3f0d3bf;

  if(isDefined(level.var_57bb11871e940991)) {
    foreach(func in level.var_57bb11871e940991) {
      var_84ea1c2720d87124 = self[[func]](healthperframe);

      if(isDefined(var_84ea1c2720d87124)) {
        healthperframe *= var_84ea1c2720d87124;
      }
    }
  }

  var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

  if(var_4552ad49778498ee) {
    print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x1ef>" + healthperframe);
  }

  return healthperframe;
}

function private function_25bcb1f5ecb2c04e() {
  if(isDefined(self.var_50fbc0f48ccfe94e)) {
    self[[self.var_50fbc0f48ccfe94e]]();
  }
}

function private onfullhealth(starthealth, var_823ca369fafd4a36, var_7f86cf029bef696d) {
  amounthealed = self.health - starthealth;

  if(issharedfuncdefined("player", "onFullHealth")) {
    self[[getsharedfunc("player", "onFullHealth")]](starthealth, var_823ca369fafd4a36, var_7f86cf029bef696d);
  }

  if(var_7f86cf029bef696d) {
    scripts\cp_mp\challenges::onstim(amounthealed);
  }

  function_9ef4f53d298067a2();
  self notify("healed");
  level notify("healed", self);

  if(istrue(level.gamemodebundle.var_198508771f0592a9)) {
    if(!istrue(self.inlaststand)) {
      scripts\common\damage_effects::function_446043a04ae1bfe();
    }
  } else {
    thread scripts\common\damage_effects::removeoldattackersovertime();
  }

  if(!level.gameended && !isusingremote()) {
    self playlocalsound(ter_op(isfemale(), "Fem_breathing_better", "breathing_better"));
  }

  callsharedfunc("helmet", "updateProtectionState", self);

  var_4552ad49778498ee = getdvarint(@ "hash_9e41eb34980a2301", 0);

  if(var_4552ad49778498ee) {
    print(gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x228>" + amounthealed);
  }
}

function private function_9ef4f53d298067a2() {
  if(isDefined(self.var_71c054a8df6f6e2b)) {
    self[[self.var_71c054a8df6f6e2b]]();
  }
}

function function_19b9bb9cef6a2d3() {
  healthratio = self.health / self.maxhealth;

  if(healthratio > level.var_fdd1af3c4c6cbe86 && !istrue(self.inlaststand)) {
    scripts\common\damage_effects::onexitdeathsdoor(1);
  }

  if((healthratio <= level.var_562530bdb8e83b66 || istrue(self.inlaststand)) && !scripts\common\utility::isusingremote() && !istrue(self.ignoredeathsdoor)) {
    scripts\common\damage_effects::onenterdeathsdoor(undefined);
  }
}

function function_93cd34979e0adbdd(var_c79a45c6dcb67386) {
  assert(isDefined(var_c79a45c6dcb67386), "<dev string:x25a>");
  level.var_57bb11871e940991 = default_to(level.var_57bb11871e940991, []);
  level.var_57bb11871e940991 = array_add(level.var_57bb11871e940991, var_c79a45c6dcb67386);
}

function function_5f963b9b662284bc(var_c79a45c6dcb67386) {
  assert(isDefined(var_c79a45c6dcb67386), "<dev string:x25a>");
  level.var_57bb11871e940991 = default_to(level.var_57bb11871e940991, []);

  foreach(func in level.var_57bb11871e940991) {
    if(func == var_c79a45c6dcb67386) {
      level.var_57bb11871e940991 = array_remove(level.var_57bb11871e940991, var_c79a45c6dcb67386);
    }
  }
}

function function_31a13be1530a809b() {
  self endon("<dev string:x2b7>");
  self.debughealthhud = spawnStruct();
  self.debughealthhud.var_946b001669de27fb = [];
  self.debughealthhud.active = 0;

  while(isDefined(self)) {
    if(getdvarint(@ "player_debughealth") && !self.debughealthhud.active) {
      thread function_cdac508141881a7c();
      self.debughealthhud.active = 1;
    }

    if(!getdvarint(@ "player_debughealth") && self.debughealthhud.active) {
      self notify("<dev string:x2c5>");

      foreach(hudelm in self.debughealthhud.var_946b001669de27fb) {
        self.debughealthhud.var_946b001669de27fb = array_remove(self.debughealthhud.var_946b001669de27fb, hudelm);
        hudelm destroy();
      }

      self.debughealthhud.active = 0;
    }

    waitframe();
  }
}

function function_cdac508141881a7c() {
  self endon("<dev string:x2c5>");
  function_6840973f983f0bae("<dev string:x2e0>");
  function_6840973f983f0bae("<dev string:x2ea>");

  while(true) {
    waittillframeend();

    if(utility::damageflag(2)) {
      color = (1, 0, 0);
    } else {
      color = (0, 1, 0);
    }

    self.debughealthhud.var_946b001669de27fb["<dev string:x2e0>"] setvalue(self.health);
    self.debughealthhud.var_946b001669de27fb["<dev string:x2e0>"].color = color;

    if(isalive(self)) {
      if(utility::damageflag(2)) {
        if(utility::damageflag(1)) {
          deathshieldtime = getdeathsshieldduration();
          self.debughealthhud.var_946b001669de27fb["<dev string:x2ea>"] setdevtext("<dev string:x2f8>" + string(deathshieldtime) + "<dev string:x31c>");
          self.debughealthhud.var_946b001669de27fb["<dev string:x2ea>"].color = (0, 1, 0);
        } else {
          deathsdoortime = getdeathsdoorduration();
          self.debughealthhud.var_946b001669de27fb["<dev string:x2ea>"] setdevtext("<dev string:x328>" + string(deathsdoortime) + "<dev string:x31c>");
          self.debughealthhud.var_946b001669de27fb["<dev string:x2ea>"].color = (1, 0, 0);
        }
      } else {
        self.debughealthhud.var_946b001669de27fb["<dev string:x2ea>"] setdevtext("<dev string:x348>");
      }
    } else {
      self.debughealthhud.var_946b001669de27fb["<dev string:x2ea>"] setdevtext("<dev string:x348>");
    }

    waitframe();
  }
}

function function_6840973f983f0bae(id) {
  ybase = 10;
  rowspacing = 15;
  yoffset = self.debughealthhud.var_946b001669de27fb.size * rowspacing;
  hudelm = newclienthudelem(self);
  hudelm.sort = 10;
  hudelm.x = 85;
  hudelm.y = ybase + yoffset;
  hudelm.fontscale = 1;
  hudelm.alignx = "<dev string:x34c>";
  hudelm.aligny = "<dev string:x354>";
  hudelm.horzalign = "<dev string:x35b>";
  hudelm.vertalign = "<dev string:x35b>";
  hudelm.sort = 1;
  self.debughealthhud.var_946b001669de27fb[id] = hudelm;
}

function getdeathsdoorduration() {
  return self.gs.deathsdoorduration;
}

function getdeathsshieldduration() {
  return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}