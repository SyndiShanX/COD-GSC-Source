/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\health_management.gsc
***************************************************/

#using scripts\common\gameskill;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\gameskill;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#namespace health_management;

function private autoexec __init__system__() {
  system::register(#"health_management", undefined, undefined, &post_main);
}

function private post_main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  val::register("\xf2\x11\xc6x9_\x9cS6\xad\x9a\x15\xbdS\x1a\xf7\xc7a|z<\xe9\x98", 0, 1, "\x127\xca\x8d3", &function_ab4d57573d77d4bb, "~\xa9\xccdcE");
  var_c6c33488b4c7eefe = 0;

  var_c6c33488b4c7eefe = getdvarint(@ "hash_4973737e949d817c", 0);

  if(!var_c6c33488b4c7eefe) {
    return;
  }

  precachestring(&"game/damage_regen");
  setomnvar("\xd5\xd2\xd7gY\xe8t\xf6\xc6\xdbv+\xe4}:ex\xe8", "B/\xab[E?l\x13\x03\xdf\x7f\xac\xd5|\x14\x1c\x84");
  assert(isDefined(level.player));
  player = level.player;
  player initsettings();
  basehealthscaler = 2.25;

  basehealthscaler = getdvarfloat(@ "hash_ffedcdd1d2b7e5e", basehealthscaler);

  player function_1f9f4d9374facd2(basehealthscaler);
  player val::set("#\x13\xdc\xb6\xf6T\x81\xd5\xbe\xd0\xe8/670l\xf5<\x1c\x95\xf2\x87C3\xf6", "\x1a\x9c\xb3\x11\xb5\xe0[6\xd6{8\x84", 0);
  assert(isDefined(player.damage_functions));
  player utility_sp::add_damage_function(&function_2472a8790b480213);
  player thread combateventsmonitor();
  player thread combatstatusmonitor();
  player thread function_f3cde12f8a2b9215();
  player.var_34a1298708ca48f0 = player function_c51daea687cde0d6();
  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &function_c2e85c456ac6ee6d);

  level thread function_4dc3cc17d44b098d();
}

function registerally(allyactor) {
  player = self;
  assert(isPlayer(self));

  if(!isDefined(player.healthmanagement)) {
    return;
  }

  assert(!arraycontains(player.healthmanagement.combatallies, allyactor));
  player.healthmanagement.combatallies = utility::array_add(player.healthmanagement.combatallies, allyactor);
  allyactor thread allycombateventsmonitor();
}

function unregisterally(allyactor) {
  player = self;
  assert(isPlayer(self));

  if(!isDefined(player.healthmanagement)) {
    return;
  }

  player.healthmanagement.combatallies = arrayremove(player.healthmanagement.combatallies, allyactor);
  allyactor notify("\xa7\x11\xd0!%U\n\x86\xd4\x04\xa9\xf0\x9b\xb88\xba\xf2\xe9c\xc1`G\xf4\x9e");
}

function function_1f9f4d9374facd2(basehealthmultiplier, refillhealth = 1) {
  player = self;
  assert(isPlayer(player));
  var_81f4048b7b1ac215 = 0.65;
  player.gs.basehealthdamagemultiplier = 1 / basehealthmultiplier;
  player.gs.basehealthexplosivedamagemultiplier = 1 / basehealthmultiplier * var_81f4048b7b1ac215;
  player player_sp::updatedamagemultiplier();
  player setclientomnvar("\x9b$\x7f\x81\x8e\xeb\xb8\x99/\xdd)\xda\x10Qk\xc2GK\xfe|+J\xd8I\xbd\xf6l", basehealthmultiplier);

  if(istrue(refillhealth)) {
    player.health = player.maxhealth;
  }
}

function private initsettings() {
  player = self;
  gameskill::setdifficultysetting("\x0ec\x85\xbce9}\x859\xb6\xed\x9cD,m\xc2v\xb2T{\te\xc2\xd8\xa3CRaG-{\xd4Z\xb9", undefined, 0);
  gameskill::setdifficultysetting("\xb5\xcf\x13\xb7\xcf\xe9\x80\xf2:\x06,\n\xfb\x03n\xb1\xb3,^5\xa4\xad\x15\xb5\xa7I\xe1.\xf6!\x8e\xfa\xf2\xcb", undefined, 0);
  gameskill::setdifficultysetting("\xb0\x1dg|\x02\x89\xc2_\xbe\xc3'\x9c\x8fc\xbc\x87Y\x96\xcc\xe5\xc2Ru", undefined, 0.1);
  gameskill::setdifficultysetting("\x8b\x81\xef\xfaa\xe9\x1e\x8e\xfeR\xa2Sa\x17\x0e\xd8\xf8\xc3\xf3\\6\xa2\x94\xbe", undefined, 0.03);
  assert(!isDefined(player.healthmanagement));
  player.healthmanagement = spawnStruct();
  player.healthmanagement.var_11b956a2a1d48903 = 1;
  player.healthmanagement.var_e413ed8e01f12a36 = 0;
  player.healthmanagement.combatstatus = "\xd7\to\xefiB\xc5\x10\x87\xb8& 4\xd9";
  player.healthmanagement.var_da83926f1a32e801 = 0;
  player.healthmanagement.combatallies = [];
  player.healthmanagement.var_e5941df78a2b5517 = 0;
  player.healthmanagement.adrenalinehealth = 0;
  player.healthmanagement.adrenalinehealthmax = 0;
  player.healthmanagement.adrenalinekillcount = 0;

  player.healthmanagement.var_55eb56eca0dee245 = 0;
  player.healthmanagement.var_c4e2fb1b422743c8 = [];

  player gameskill::apply_difficulty_settings(1);
}

function private function_ef70174b4fd2fd49() {
  player = self;
  regencap = player gameskill::get_difficultysetting("\xb0\x1dg|\x02\x89\xc2_\xbe\xc3'\x9c\x8fc\xbc\x87Y\x96\xcc\xe5\xc2Ru");

  regencap = getdvarfloat(@ "hash_c9a7b9552057e616", regencap);

  return regencap;
}

function private function_c51daea687cde0d6() {
  player = self;
  var_7bfa0c810d0ab266 = 0.3;
  regencap = var_7bfa0c810d0ab266;

  regencap = getdvarfloat(@ "hash_2c546465375c9f06", regencap);

  return regencap;
}

function private function_dcb5ecdbf8681418(enemy) {
  player = self;
  regenrate = player gameskill::get_difficultysetting("\x8b\x81\xef\xfaa\xe9\x1e\x8e\xfeR\xa2Sa\x17\x0e\xd8\xf8\xc3\xf3\\6\xa2\x94\xbe");

  regenrate = getdvarfloat(@ "hash_cb5f564fbe10120b", regenrate);

  return regenrate;
}

function private getaggrocount() {
  player = self;
  aggrocount = player.sentientattackercount;

  foreach(guy in player.healthmanagement.combatallies) {
    aggrocount += guy.sentientattackercount;
  }

  return aggrocount;
}

function private combateventsmonitor() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    combatevent = player utility::waittill_any_return("9\xfca\xad\f^Rj.\xe6\xc6$", "\xe0\x99\xc7\xf1\a3\x81c\xa5\xe17G", "\fU`\xc0y\x95", "2\x85k\x16ved\xebb\x852v\xd5^", "\xbcf\x89\x15\\\xcdq\xc2\x01\xe8\x9a\xaf$\xeb\xa7Z\x8a", "\xa6L\"m\x9eX\xe6]\xd5\xb7gDb\x06\xcd\x95\x04", "z5N%\x94L]\xc7\xc9\xab\xb3");
    player.healthmanagement.var_da83926f1a32e801 = 1;

    debugeventdata = spawnStruct();
    debugeventdata.msg = combatevent;
    debugeventdata.timestamp = gettime();
    player.healthmanagement.var_c4e2fb1b422743c8 = utility::array_add(player.healthmanagement.var_c4e2fb1b422743c8, debugeventdata);
    max_events = 20;

    if(player.healthmanagement.var_c4e2fb1b422743c8.size > max_events) {
      player.healthmanagement.var_c4e2fb1b422743c8 = utility::array_remove_index(player.healthmanagement.var_c4e2fb1b422743c8, 0, 0);
    }
  }
}

function private allycombateventsmonitor() {
  ally = self;
  ally notify("\r\xbf\xde\v\xd5r\x14C\x9cry2#i\xda\xa8\xf6\x0f\xc3\x11\xac\xea\x16\xb4\xa7\x9f0c\xd8oJ54");
  ally endon("\r\xbf\xde\v\xd5r\x14C\x9cry2#i\xda\xa8\xf6\x0f\xc3\x11\xac\xea\x16\xb4\xa7\x9f0c\xd8oJ54");
  ally endon("\xa7\x11\xd0!%U\n\x86\xd4\x04\xa9\xf0\x9b\xb88\xba\xf2\xe9c\xc1`G\xf4\x9e");
  player = level.player;

  while(true) {
    allycombatevent = ally utility::waittill_any_return("O\xd8dI\xcd\x8bx\xdc", "\xe0\x99\xc7\xf1\a3\x81c\xa5\xe17G", "\fU`\xc0y\x95", "\x1e\xfd\xd1\xa2\a");

    debugactive = getdvarint(@ "player_debughealth") > 0;

    if(debugactive) {
      print3d(ally getEye(), allycombatevent, (0.9, 0.9, 0), 1, 0.5, 40, 1);
    }

    switch (allycombatevent) {
      case #"hash_718f4c8bdaf008f8":
        player notify("\xbcf\x89\x15\\\xcdq\xc2\x01\xe8\x9a\xaf$\xeb\xa7Z\x8a");
        break;
      case #"hash_3989359e2b52d1ba":
        player notify("\xa6L\"m\x9eX\xe6]\xd5\xb7gDb\x06\xcd\x95\x04");
        break;
      case #"hash_1cc8a923a608c2a0":
        player notify("z5N%\x94L]\xc7\xc9\xab\xb3");
        break;
      case #"hash_e8bc3da4af287c2d":
        player unregisterally(ally);
        break;
      default:
        assertmsg("<dev string:x24>");
        break;
    }
  }
}

function private combatstatusmonitor() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  wasincombat = 0;
  player thread healthregencontrol(wasincombat);

  while(true) {
    incombat = player.healthmanagement.var_da83926f1a32e801 || player getaggrocount() > 0;
    player.healthmanagement.var_da83926f1a32e801 = 0;

    if(incombat != wasincombat) {
      player thread healthregencontrol(incombat);
      wasincombat = incombat;
    }

    waitframe();
  }
}

function private healthregencontrol(isincombat) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player notify(">E\xdd\xb3!?+&\xc7kJ\xd4\x01d\xf2\xcc\bjs\xd1\x1a\xca\xfc'\x81\x98S\x10");
  player endon(">E\xdd\xb3!?+&\xc7kJ\xd4\x01d\xf2\xcc\bjs\xd1\x1a\xca\xfc'\x81\x98S\x10");

  if(isincombat) {
    player.healthmanagement.combatstatus = "\x1c(\xa4\xfd\xa1\xeb\x147H";
    player.healthmanagement.var_11b956a2a1d48903 = player function_ef70174b4fd2fd49();
    return;
  }

  player.healthmanagement.combatstatus = "L\xea\xfcY\xee\xf4\xddc\xd2^\b\xc3\xab=\xa6\x8a\xfe~& 0\x88";
  var_9da07df531aeea48 = 7;
  wait var_9da07df531aeea48;
  player.healthmanagement.combatstatus = "\xd7\to\xefiB\xc5\x10\x87\xb8& 4\xd9";
  player.healthmanagement.var_11b956a2a1d48903 = player function_c51daea687cde0d6();
  player.var_34a1298708ca48f0 = player.healthmanagement.var_11b956a2a1d48903;
  player.healthmanagement.var_e413ed8e01f12a36 = 1;
  player thread regeneratehealthtocap(1);
}

function private function_2472a8790b480213(damage, attacker, direction, point, type, overkilldamage, inflictor) {
  player = self;

  if(player.healthmanagement.adrenalinehealth > 0) {
    damageabsorbed = min(damage, player.healthmanagement.adrenalinehealth);
    var_ea394603e3b33ece = clamp(player.health + damageabsorbed, 0, player.maxhealth);
    player player_sp::set_normalhealth(var_ea394603e3b33ece / player.maxhealth);
    player.healthmanagement.adrenalinehealth = max(0, player.healthmanagement.adrenalinehealth - damage);
  }

  if(player.healthmanagement.var_e413ed8e01f12a36) {
    return;
  }

  player thread regeneratehealthtocap();
}

function private regeneratehealthtocap(ignoredelay) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player notify("\x17\xfb+\x99X\x96\vB\xc8\xd9\xf0\x80\xb1=\xd8\x14\x06\xb9c\xb1(\xe6\x1bF\xc5\x89\x84\x03\x01;\x9a");
  player endon("\x17\xfb+\x99X\x96\vB\xc8\xd9\xf0\x80\xb1=\xd8\x14\x06\xb9c\xb1(\xe6\x1bF\xc5\x89\x84\x03\x01;\x9a");

  if(!istrue(ignoredelay)) {
    regendelay = player player_sp::gethealthregendelay();
    wait regendelay;
  }

  while(player utility::damageflag(2) || player utility::damageflag(32)) {
    waitframe();
  }

  healthcap = int(player.maxhealth * player.healthmanagement.var_11b956a2a1d48903 + 0.5);
  finalhealth = player.health;

  while(player.health < healthcap) {
    var_907b0bc7700fc654 = player player_sp::gethealthregenpersecond();
    frameregen = var_907b0bc7700fc654 * 0.05;
    finalhealth = clamp(finalhealth + frameregen, 0, healthcap);
    player player_sp::set_normalhealth(finalhealth / player.maxhealth);
    waitframe();
  }

  player.healthmanagement.var_e413ed8e01f12a36 = 0;
}

function private function_c2e85c456ac6ee6d() {
  badguy = self;

  if(isDefined(badguy.damage_functions)) {
    badguy utility_sp::add_damage_function(&function_489e440645bedb8f);
  }
}

function private function_ab4d57573d77d4bb(enabled) {
  badguy = self;

  if(enabled) {
    var_ef5ce36a7e210c20 = 1080;

    var_ef5ce36a7e210c20 = getdvarint(@ "hash_3361e5b0c9175530", var_ef5ce36a7e210c20);

    badguy.var_ef5ce36a7e210c20 = var_ef5ce36a7e210c20;
    return;
  }

  badguy.var_ef5ce36a7e210c20 = undefined;
}

function private function_489e440645bedb8f(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  if(isPlayer(attacker) && isalive(attacker)) {
    player = attacker;
    victim = self;
    clampeddamage = damage;

    if(isDefined(victim.var_ef5ce36a7e210c20) && victim.var_ef5ce36a7e210c20 > 0) {
      clampeddamage = victim.var_ef5ce36a7e210c20;
    } else if(!isalive(victim)) {
      clampeddamage = max(damage, victim.maxhealth);
    }

    prevhealth = player function_e70d31d24ba8f6c3();
    regenrate = player function_dcb5ecdbf8681418(self);
    healamount = int(clampeddamage * regenrate + 0.5);
    healamount = int(max(healamount, 1));

    if(getdvarint(@ "player_debughealth") > 0) {
      println("<dev string:x44>" + clampeddamage + "<dev string:x5e>" + regenrate + "<dev string:x6a>" + healamount + "<dev string:x76>");
    }

    player function_c3831f4b877dd4a1(healamount);
    newhealth = player function_e70d31d24ba8f6c3();
    player thread killdamageeffects();
    player notify("2\x85k\x16ved\xebb\x852v\xd5^");

    if(newhealth > prevhealth) {
      realhealamount = newhealth - prevhealth;
      player.healthmanagement.var_e5941df78a2b5517 += realhealamount;
      player notify("nY\xbb\xeb4e\x166GC\xd7\x9ce\xd9e\xe6");

      if(getdvarint(@ "player_debughealth") > 0) {
        player notify("<dev string:x7b>", realhealamount);
      }
    }

    if(getdvarint(@ "hash_2c67b2a9f1893db3", 0)) {
      if(!isalive(victim) || victim.delayeddeath) {
        player thread healthmanagementenemykillcounter();
      }
    }
  }
}

function private healthmanagementenemykillcounter() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player notify("\x1bU\xb7\xb8\xd1$\x90@ J\xbf\xbb\xd0\x1f\xf6\x9d\x15\xa6O@\xf3\xc4\xba 8@UC\b3e&");
  player endon("\x1bU\xb7\xb8\xd1$\x90@ J\xbf\xbb\xd0\x1f\xf6\x9d\x15\xa6O@\xf3\xc4\xba 8@UC\b3e&");
  var_3a671ad35597acc6 = 5;
  var_35e3676ff7db7269 = 5;
  var_a627d62eebd8368d = 1;
  ad_duration = 20;

  if(player.healthmanagement.adrenalinehealthmax > 0) {
    player.healthmanagement.adrenalinekillcount = 0;
    return;
  }

  player.healthmanagement.adrenalinekillcount++;

  if(player.healthmanagement.adrenalinekillcount >= var_35e3676ff7db7269) {
    player.healthmanagement.adrenalinekillcount = 0;
    player.healthmanagement.adrenalinehealthmax = int(player.maxhealth / player.gs.basehealthdamagemultiplier * var_a627d62eebd8368d);
    player function_c3831f4b877dd4a1(player.healthmanagement.adrenalinehealthmax);

    if(getdvarint(@ "player_debughealth") > 0) {
      player notify("<dev string:x7b>", player.healthmanagement.adrenalinehealthmax);
    }

    player thread healthmanagementadrenalinewaitforexpire(ad_duration);
    return;
  }

  wait var_3a671ad35597acc6;
  player.healthmanagement.adrenalinekillcount = 0;
}

function private healthmanagementadrenalinewaitforexpire(waittime) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player notify("\x9e\xd3\xe2W\x8d\x1dT\x12\xb5\x1eH\x17n\x01\x01\x9d\x9d\xa36\xdfyG\xf0\xb9c\x99\xbf9k\xd4\xc9\x82dS\x02\x04\xd7&\xf8");
  player endon("\x9e\xd3\xe2W\x8d\x1dT\x12\xb5\x1eH\x17n\x01\x01\x9d\x9d\xa36\xdfyG\xf0\xb9c\x99\xbf9k\xd4\xc9\x82dS\x02\x04\xd7&\xf8");

  player.healthmanagement.var_55eb56eca0dee245 = gettime() + int(waittime * 1000);

  wait waittime;
  player.healthmanagement.adrenalinehealth = 0;
  player.healthmanagement.adrenalinehealthmax = 0;
  player.healthmanagement.adrenalinekillcount = 0;

  player.healthmanagement.var_55eb56eca0dee245 = 0;
}

function private function_e70d31d24ba8f6c3() {
  player = self;
  return player.health + player.healthmanagement.adrenalinehealth;
}

function private function_c3831f4b877dd4a1(hpamount) {
  player = self;
  var_896f7a96d74ed453 = player.maxhealth + player.healthmanagement.adrenalinehealthmax;
  newhealth = clamp(player function_e70d31d24ba8f6c3() + hpamount, 0, var_896f7a96d74ed453);
  normalhealth = clamp(newhealth / player.maxhealth, 0, 1);
  player player_sp::set_normalhealth(normalhealth);

  if(player.healthmanagement.adrenalinehealthmax > 0) {
    player.healthmanagement.adrenalinehealth = max(0, newhealth - player.health);
  }
}

function private killdamageeffects() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player notify("IW\xa767\xa6\xb0\xad\x7f\x04\xac\x1a\xdcLQ\xf9w\xe1\xb6w`\xbd\xdeG\x15VO");
  player endon("IW\xa767\xa6\xb0\xad\x7f\x04\xac\x1a\xdcLQ\xf9w\xe1\xb6w`\xbd\xdeG\x15VO");
  wait 0.2;

  if(player utility::damageflag(2) || player utility::damageflag(32)) {
    return;
  }

  player player_sp::remove_damage_effects_instantly();
}

function private function_f3cde12f8a2b9215() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  var_eb9b801eefee999a = 0.2;

  while(true) {
    if(player.healthmanagement.var_e5941df78a2b5517 > 0) {
      player setclientomnvar("\xc1D\xee|\xb4FMm\xbe\x1d\xaeL\xfabi)\x0f!\xb5G,-", int(player.healthmanagement.var_e5941df78a2b5517 / player.gs.basehealthdamagemultiplier));
      player.healthmanagement.var_e5941df78a2b5517 = 0;
      wait var_eb9b801eefee999a;
      player setclientomnvar("\xc1D\xee|\xb4FMm\xbe\x1d\xaeL\xfabi)\x0f!\xb5G,-", 0);
      continue;
    }

    player waittill("nY\xbb\xeb4e\x166GC\xd7\x9ce\xd9e\xe6");
  }
}

function private function_4dc3cc17d44b098d() {
  player = level.player;
  player endon("<dev string:x92>");
  prevdebugactive = undefined;

  while(true) {
    waitframe();
    debugactive = getdvarint(@ "player_debughealth") > 0;

    if(!isDefined(prevdebugactive) || prevdebugactive != debugactive) {
      prevdebugactive = debugactive;

      if(debugactive) {
        level.player thread function_3f019e87a764facc();
        continue;
      }

      level.player function_ab7104ac518afca();
    }
  }
}

function private function_3f019e87a764facc() {
  player = self;
  player endon("<dev string:x92>");
  assert(!isDefined(player.var_bf38ec2c64f4b629));
  player.var_bf38ec2c64f4b629 = spawnStruct();
  player.var_bf38ec2c64f4b629.hudelems = [];
  hplabel = player function_239c69f816e0676f("<dev string:x9b>");
  regencaplabel = player function_239c69f816e0676f("<dev string:xa3>");
  regenratelabel = player function_239c69f816e0676f("<dev string:xb2>");
  var_e7b36037d1716ae1 = player function_239c69f816e0676f("<dev string:xcd>");
  var_2f2a0c9df53950d1 = player function_239c69f816e0676f("<dev string:xea>");
  var_529ae71c1c09a5a5 = player function_239c69f816e0676f("<dev string:x112>");
  var_2051f56829cdd14d = player function_239c69f816e0676f("<dev string:x129>");
  var_48f801727c44844f = player function_239c69f816e0676f("<dev string:x144>");
  adkillcount = player function_239c69f816e0676f("<dev string:x163>");
  combatstatuslabel = player function_239c69f816e0676f("<dev string:x186>", 1);
  combatstatuslabel.fontscale = 2;
  combatstatuslabel hud_util::setpoint("<dev string:x197>", undefined, 0, 85);
  combateventslabel = player function_239c69f816e0676f("<dev string:x1a5>", 1);
  combateventslabel hud_util::setpoint("<dev string:x197>", undefined, 0, 106);
  combateventslabel.color = (0.9, 0, 0);
  player thread function_9b7342e32e0c63df();

  while(true) {
    hplabel setvalue(player.health);
    regencaplabel setvalue(player.healthmanagement.var_11b956a2a1d48903);
    regenratelabel setvalue(player function_dcb5ecdbf8681418());
    var_e7b36037d1716ae1 setvalue(player.sentientattackercount);
    teamattackercount = 0;

    foreach(guy in player.healthmanagement.combatallies) {
      teamattackercount += guy.sentientattackercount;
    }

    var_2f2a0c9df53950d1 setvalue(teamattackercount);

    if(getdvarint(@ "hash_ad969b52c470fddb", 0) > 0) {
      enemies = getaiarray("<dev string:x1a9>");

      foreach(guy in enemies) {
        if(isDefined(guy.enemy)) {
          if(isPlayer(guy.enemy)) {
            linecolor = (0.9, 0, 0);
            line(guy getEye(), guy.enemy.origin, linecolor, 1, 0, 1);
            continue;
          }

          if(arraycontains(player.healthmanagement.combatallies, guy.enemy)) {
            linecolor = (0.9, 0.9, 0);
            line(guy getEye(), guy.enemy getEye(), linecolor, 1, 0, 1);
          }
        }
      }
    }

    switch (player.healthmanagement.combatstatus) {
      case #"hash_2963a1e0d3a9fe3":
        combatstatuslabel.label = "<dev string:x1c2>";
        combatstatuslabel.color = (0.9, 0, 0);
        break;
      case #"hash_f4eb035a90dbc19a":
        combatstatuslabel.label = "<dev string:x1e8>";
        combatstatuslabel.color = (0.9, 0, 0);
        break;
      case #"hash_1b7e2afb6e5e2f86":
        combatstatuslabel.label = "<dev string:x215>";
        combatstatuslabel.color = (0, 0.9, 0);
        break;
      default:
        combatstatuslabel.label = "<dev string:x226>";
        combatstatuslabel.color = (0.3, 0.3, 0.3);
        break;
    }

    var_497619b482868344 = [];
    currenttime = gettime();

    for(i = 0; i < player.healthmanagement.var_c4e2fb1b422743c8.size; i++) {
      debugeventdata = player.healthmanagement.var_c4e2fb1b422743c8[i];

      if(currenttime - debugeventdata.timestamp <= 1000) {
        var_497619b482868344[var_497619b482868344.size] = debugeventdata;
      }
    }

    player.healthmanagement.var_c4e2fb1b422743c8 = var_497619b482868344;
    var_41967021e27b36c4 = player.healthmanagement.var_c4e2fb1b422743c8.size;
    var_f29595876ec3cf56 = 5;

    if(var_41967021e27b36c4 > 0) {
      eventsstring = "<dev string:x1a5>";

      for(i = 0; i < var_41967021e27b36c4; i++) {
        if(i > 0) {
          eventsstring += "<dev string:x23b>";
        }

        eventsstring += player.healthmanagement.var_c4e2fb1b422743c8[i].msg;

        if(i == var_f29595876ec3cf56 - 1) {
          if(var_41967021e27b36c4 > var_f29595876ec3cf56) {
            eventsstring += "<dev string:x242>";
          }

          break;
        }
      }

      combateventslabel.label = eventsstring;
    } else {
      totalattackers = player getaggrocount();

      if(totalattackers > 0) {
        combateventslabel.label = "<dev string:x249>" + totalattackers;
      } else {
        combateventslabel.label = "<dev string:x1a5>";
      }
    }

    var_529ae71c1c09a5a5 setvalue(player.healthmanagement.adrenalinehealth);
    var_2051f56829cdd14d setvalue(player.healthmanagement.adrenalinehealthmax);
    adkillcount setvalue(player.healthmanagement.adrenalinekillcount);

    if(player.healthmanagement.var_55eb56eca0dee245 > 0) {
      remainingms = player.healthmanagement.var_55eb56eca0dee245 - gettime();
      var_48f801727c44844f setvalue(remainingms * 0.001);
    } else {
      var_48f801727c44844f setvalue(0);
    }

    waitframe();
  }
}

function private function_239c69f816e0676f(labeltext, var_831f2e1c114f1659) {
  player = self;
  font_scale = 1;
  top = 120;
  left = 12;
  line_height = 12;

  if(!isDefined(player.var_bf38ec2c64f4b629.currentlinecount)) {
    player.var_bf38ec2c64f4b629.currentlinecount = 0;
  }

  newlabel = hud_util::createclientfontstring("<dev string:x258>", font_scale);
  newlabel.label = labeltext;
  player.var_bf38ec2c64f4b629.hudelems = utility::array_add(player.var_bf38ec2c64f4b629.hudelems, newlabel);

  if(!istrue(var_831f2e1c114f1659)) {
    newlabel hud_util::setpoint("<dev string:x263>", undefined, left, top + player.var_bf38ec2c64f4b629.currentlinecount * line_height);
    player.var_bf38ec2c64f4b629.currentlinecount++;
  }

  return newlabel;
}

function private function_ab7104ac518afca() {
  player = self;

  if(!isDefined(player.var_bf38ec2c64f4b629)) {
    return;
  }

  player notify("<dev string:x26f>");

  foreach(elem in player.var_bf38ec2c64f4b629.hudelems) {
    elem hud_util::destroyelem();
  }

  player.var_bf38ec2c64f4b629 = undefined;
}

function private function_9b7342e32e0c63df() {
  player = self;
  player endon("<dev string:x92>");
  player endon("<dev string:x26f>");
  var_4897424c699111d3 = 8;
  assert(isDefined(player.var_bf38ec2c64f4b629));
  floatingtextpool = [];

  for(i = 0; i < var_4897424c699111d3; i++) {
    floatingtext = hud_util::createclientfontstring("<dev string:x258>", 1.2);
    floatingtext.color = (0, 0.8, 0);
    floatingtext.alpha = 0;
    floatingtext.label = "<dev string:x28c>";
    floatingtextpool[i] = floatingtext;
    player.var_bf38ec2c64f4b629.hudelems = utility::array_add(player.var_bf38ec2c64f4b629.hudelems, floatingtext);
  }

  for(var_7031599c78984935 = 0; true; var_7031599c78984935 = (var_7031599c78984935 + 1) % var_4897424c699111d3) {
    player waittill("<dev string:x7b>", number);
    floatingtextpool[var_7031599c78984935] thread activatefloatingtext(number);
  }
}

function private activatefloatingtext(number) {
  element = self;
  element endon("<dev string:x92>");
  element notify("<dev string:x291>");
  element endon("<dev string:x291>");
  randoffsetx = randomfloatrange(5, 40);
  randoffsety = randomfloatrange(5, 15) * -1;
  element hud_util::setpoint("<dev string:x2ab>", undefined, randoffsetx, randoffsety);
  element setvalue(number);
  element.alpha = 1;
  waitframe();
  floatingtime = 1;
  element hud_util::setpoint("<dev string:x2ab>", undefined, randoffsetx, randoffsety - 80, floatingtime);
  element fadeovertime(floatingtime);
  element.alpha = 0;
}

# /