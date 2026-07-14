/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\stimshot_slowmo.gsc
****************************************************/

#using script_53f4e6352b0b2425;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\game\sp\equipment_wheel;
#using scripts\sp\damagefeedback;
#using scripts\sp\equipment\offhands;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#using scripts\sp\utility;
#namespace stimshot_slowmo;

function private autoexec function_eea75f1479f0a69a() {
  offhands::registerprecachefunc("\x15\x01\xf2\xde\xdf#\xd2 \xc8\xda\xbd\x99\x96G\xf4\x10\f\xa5g", &precache);
  utility_sp::post_load_precache(&precache_postload);
}

function private precache(offhand) {
  utility::add_fx("\x85\xf8\xf0\xc7\\!\xe0\xfd\x85|\x93\xdb?\x1f\x86\xdcIp\xd8\x03\xaf", "\x1ee\x0f\x9c\xd6\xb1\xfac\xe3c\x9f\xc7\xfc\xda|\xb2\x80\xdfP\x1c\xca\x19S\x98\xc2uLH]\xbd{\x9b<\xc6D\x02\x9c\x8e\x04!\x1d\x81W");
  utility::add_fx("'\x06\xfe\xae<\xad\xf0\xcb\xc7\fm\xa0\xdf\xdb0\x1ax\xb8\xf7H", "{N\xe7\x82\xa8I\xc0t\xdc\xf0H\xf8\x86\x97w\xccP\xdb.\xfc\x18V\xeb\xbbV^\xce\xe8\xcd\xc7\xdc\xd5\n\xc8\xfeM\xdel\x04\xf6\f\x98");
  equipment_wheel::function_e659a935c2da012("\x15\x01\xf2\xde\xdf#\xd2 \xc8\xda\xbd\x99\x96G\xf4\x10\f\xa5g", &function_1f66a9fd20859a59);
  offhands::function_96370f3451fa67a0(offhand, &function_1f66a9fd20859a59);
  level.var_97dcd493f88d82b3 = 15000;
  utility::registersharedfunc(#"equipment", #"hash_91193f6c47b8a37a", &function_dd2f4fa11a8f4867);
}

function private precache_postload() {
  var_1fbeea77f1449474 = getaiarray("?\xb1\xc0\x9a");

  foreach(guy in var_1fbeea77f1449474) {
    guy utility_sp::add_damage_function(&function_f533ba787e832d1f);
  }

  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &function_25d029a172dfd53d);
}

function private function_f533ba787e832d1f(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  player = level.player;

  if(isDefined(player.var_a4667a8c5ab0cfc1) && isDefined(attacker) && attacker == player && !isalive(self) && (damagefeedback::isheadshot(partname) || partname == #"j_helmet")) {
    player.var_a4667a8c5ab0cfc1++;

    if(player.var_a4667a8c5ab0cfc1 >= 5) {
      player thread utility_sp::player_giveachievement_wrapper("\xdf\xd1\x900\x8d\a\xbfjT\xb6\xfa\x01d\x97B\x02E");
    }
  }
}

function private function_25d029a172dfd53d() {
  if(isactor(self)) {
    utility_sp::add_damage_function(&function_f533ba787e832d1f);
  }
}

function function_d80d4b922583d7fc(newdurationms = 15000) {
  level.var_97dcd493f88d82b3 = newdurationms;
}

function function_77de32a0bf9ae5be() {
  assert(isPlayer(self));
  self notify("\xa1\x8c\x1f\xa41\xd2\"BA\x1fD\xd0\xf5\x16G\xc4\x83\xa4\x15`\xc01bF\xf4");
}

function private function_dd2f4fa11a8f4867(waittimeseconds, cancelnotify) {
  self notify("\x91\xd8Z\x85'\x8b$\xfc\xde\xa2\xa3\xdd\x80\x1a\xa4\xc0");
  self endon("\x91\xd8Z\x85'\x8b$\xfc\xde\xa2\xa3\xdd\x80\x1a\xa4\xc0");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(cancelnotify)) {
    player endon(cancelnotify);
  }

  elapsedtimeseconds = 0;

  while(elapsedtimeseconds < waittimeseconds) {
    waitframe();
    var_8fabb3376689c5f3 = player.var_651cf316057ad44d ?? 1;
    elapsedtimeseconds += level.framedurationseconds / var_8fabb3376689c5f3;
  }

  return true;
}

function function_1f66a9fd20859a59(stimweapon) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player val::set("b\x95\xc1\xf7E0\xc0\x06\x9c\xa2\xc7\xc5\xf3Q\x02", "y\x9e\xfa\xb1\x95.\x839", 0);
  player thread function_db8e98489244144();
  player thread function_d4f14c9ffa742396();
  player thread function_85fae2874a786d6();
  player thread function_ed59174d0a929a65();
  wait 0.6;
  totaldurationms = level.var_97dcd493f88d82b3 * (level.var_c30117a8c477dafd ?? 1);

  totaldurationms = getdvarfloat(@ "hash_2840d22d42f449d5", totaldurationms);

  var_34ebf7a36bdfdebd = 100;
  player thread stimshot_hud();
  player fullheal();
  var_672941a3c928491e = 0.3;
  slowmotimescale = var_672941a3c928491e;

  slowmotimescale = getdvarfloat(@ "hash_7a82f9934da45f9e", var_672941a3c928491e);

  player thread startslowmotion(slowmotimescale);
  player thread stimshot_fx();
  player.var_7e1fbc36c642e883 = [];
  player.var_a4667a8c5ab0cfc1 = 0;
  player childthread function_e5fb902da089ea55();
  player childthread function_d94a53b2efa21875();
  player childthread function_30d7d457cfd53cf9();
  player thread function_bcfa94ebf6dd861a(totaldurationms, var_34ebf7a36bdfdebd);
  endmsg = player utility::waittill_any_return("\xf5.\x80\x83\xfa\xd7\xbce,\x8cQ\xd5\x9e\xa0Z\x94F\xda!\x8dU>", "\xa1\x8c\x1f\xa41\xd2\"BA\x1fD\xd0\xf5\x16G\xc4\x83\xa4\x15`\xc01bF\xf4");

  if(endmsg == "\xa1\x8c\x1f\xa41\xd2\"BA\x1fD\xd0\xf5\x16G\xc4\x83\xa4\x15`\xc01bF\xf4") {
    var_34ebf7a36bdfdebd = 0;
  }

  player endslowmotion(slowmotimescale, var_34ebf7a36bdfdebd);
  player.var_7e1fbc36c642e883 = undefined;
  player.var_a4667a8c5ab0cfc1 = undefined;
  player notify("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD");
  player val::reset_all("b\x95\xc1\xf7E0\xc0\x06\x9c\xa2\xc7\xc5\xf3Q\x02");

  player debugactionstatusclear();
}

function private fullheal() {
  player = self;
  player player_sp::set_normalhealth(1);
  player player_sp::remove_damage_effects_instantly();
}

function private stimshot_hud() {
  self notify("\x1a\xccX\x91en\x0e\x1ac\xc9e\xc6ac\x19\x19");
  self endon("\x1a\xccX\x91en\x0e\x1ac\xc9e\xc6ac\x19\x19");
  player = self;

  if(!player hud_management::function_48c98ea9a4f0da89("\xf3\x9c~\x9b\xca\xced\x963II\xa1\x8au\xd6e{_\xfe\x8b\xa4C\xe4\x18\xd3LS\v\x11s\x99\xe5s\x9d\xf4")) {
    player hud_management::function_35924dfcb78711f4("\xf3\x9c~\x9b\xca\xced\x963II\xa1\x8au\xd6e{_\xfe\x8b\xa4C\xe4\x18\xd3LS\v\x11s\x99\xe5s\x9d\xf4", "\xa2\x11\xe8\x11sU\xa3\xf3'\xbf\xf3zW\b\x9b\xd1\xaei@\xa5J'Y\xcf\xeb\xf3\xb03\x9c\x80\xad");
    player hud_management::function_85d8a0ba2e35b6f2("\xf3\x9c~\x9b\xca\xced\x963II\xa1\x8au\xd6e{_\xfe\x8b\xa4C\xe4\x18\xd3LS\v\x11s\x99\xe5s\x9d\xf4", 0, 0, 1, 1);
  } else {
    player hud_management::function_d8d634ceece460("\xf3\x9c~\x9b\xca\xced\x963II\xa1\x8au\xd6e{_\xfe\x8b\xa4C\xe4\x18\xd3LS\v\x11s\x99\xe5s\x9d\xf4", "\x91\xca\xcc\v\xab\xd8:");
  }

  player utility::waittill_any("\x1e\xfd\xd1\xa2\a", "W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD", "\xf5.\x80\x83\xfa\xd7\xbce,\x8cQ\xd5\x9e\xa0Z\x94F\xda!\x8dU>", "\xa1\x8c\x1f\xa41\xd2\"BA\x1fD\xd0\xf5\x16G\xc4\x83\xa4\x15`\xc01bF\xf4");

  if(isDefined(player) && player hud_management::function_48c98ea9a4f0da89("\xf3\x9c~\x9b\xca\xced\x963II\xa1\x8au\xd6e{_\xfe\x8b\xa4C\xe4\x18\xd3LS\v\x11s\x99\xe5s\x9d\xf4")) {
    player hud_management::function_d8d634ceece460("\xf3\x9c~\x9b\xca\xced\x963II\xa1\x8au\xd6e{_\xfe\x8b\xa4C\xe4\x18\xd3LS\v\x11s\x99\xe5s\x9d\xf4", "\x19b\xc2y");
  }
}

function private function_db8e98489244144() {
  self notify("\xb74^\xcb\x90\xf3m\xdaSY\xbc\xc4\xbfz\xb5\xfd");
  self endon("\xb74^\xcb\x90\xf3m\xdaSY\xbc\xc4\xbfz\xb5\xfd");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD");
  stimshotoffhandslot = offhands::getweaponoffhandtype("\x15\x01\xf2\xde\xdf#\xd2 \xc8\xda\xbd\x99\x96G\xf4\x10\f\xa5g");
  var_d7839c03c66c95ad = stimshotoffhandslot == "\xa9\nC\xc9\v\xda\xbdS\xa8\xe9?t\x14\x1e" ? "K\x80\xde\x10\xf9l\xa7u\xe0\xb3\x18\xd5\xe8\xd2\x83e\xfa(\xdd\xe9\xfe\xc3\xf4" : "{\xe0U\x19:$\x9d\\RI\x9e\xb5\xea\x7fs\x81^t\x84\xba\x1ff.:";

  while(true) {
    currentoffhandweapon = player getcurrentoffhand(stimshotoffhandslot);

    if(currentoffhandweapon.basename == "\x15\x01\xf2\xde\xdf#\xd2 \xc8\xda\xbd\x99\x96G\xf4\x10\f\xa5g") {
      if(player val::get(var_d7839c03c66c95ad)) {
        player val::set("b\x95\xc1\xf7E0\xc0\x06\x9c\xa2\xc7\xc5\xf3Q\x02", var_d7839c03c66c95ad, 0);
      }
    } else if(!player val::get(var_d7839c03c66c95ad)) {
      player val::set("b\x95\xc1\xf7E0\xc0\x06\x9c\xa2\xc7\xc5\xf3Q\x02", var_d7839c03c66c95ad, 1);
    }

    waitframe();
  }
}

function private function_d4f14c9ffa742396() {
  self notify("\xcf\xa9S)Z\f\x95a\xa0Sc]\xbe\xe2*;");
  self endon("\xcf\xa9S)Z\f\x95a\xa0Sc]\xbe\xe2*;");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD");
  player waittill("Yj\xd3mH4\xc3\xb5\x80zq\xc6");
  player function_77de32a0bf9ae5be();
}

function private function_85fae2874a786d6() {
  self notify("\xd1ju\x87JB\x17\xff\xc0\xd5\xa1\xd2\xacw\xe3N");
  self endon("\xd1ju\x87JB\x17\xff\xc0\xd5\xa1\xd2\xacw\xe3N");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD");
  level waittill("\x95\b\x9b\xf5\xc6\xe9\xe2\x10\xbf\xae\xee\xc5>");
  player function_77de32a0bf9ae5be();
}

function private function_bcfa94ebf6dd861a(totaldurationms, var_34ebf7a36bdfdebd) {
  player = self;
  player endon("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD");
  frametimems = level.frameduration;
  var_21f8d29b04a9fb2d = 1.5;
  var_ec4b42be28e79434 = totaldurationms;

  while(var_ec4b42be28e79434 > 0) {
    timeelapsedms = frametimems;
    playervel = player getvelocity();
    ismoving = lengthsquared(playervel) > 0;

    if(ismoving) {
      timeelapsedms += int(frametimems * var_21f8d29b04a9fb2d);
    }

    if(player utility::ent_flag("\xe2\r\x8b\xf5J\xdaM\t\xf8~\xe5w\x86\x1b\xf9")) {
      player function_f09e98709e3fc40f("\xe2\r\x8b\xf5J\xdaM\t\xf8~\xe5w\x86\x1b\xf9", 1, -0.9);
    }

    currentframetimems = gettime();
    remainingactions = [];

    foreach(stringid, actiondata in player.var_7e1fbc36c642e883) {
      if(currentframetimems <= actiondata.endtimems) {
        timeelapsedms += int(frametimems * actiondata.var_207be84752024f73);
        remainingactions[stringid] = actiondata;
      }
    }

    player.var_7e1fbc36c642e883 = remainingactions;
    assert(timeelapsedms > 0);
    var_ec4b42be28e79434 -= timeelapsedms;
    player setclientomnvar("X\x19r\xca7Xc\xa5\xe6\xb2_s\x1d-\xb5\xf58'{\xd9Nes\xe6", var_ec4b42be28e79434 / totaldurationms);

    if(var_ec4b42be28e79434 <= var_34ebf7a36bdfdebd) {
      player notify("\xf5.\x80\x83\xfa\xd7\xbce,\x8cQ\xd5\x9e\xa0Z\x94F\xda!\x8dU>");
    }

    statusarray = [];

    if(ismoving) {
      statusarray[statusarray.size] = "<dev string:x24>" + var_21f8d29b04a9fb2d;
    }

    foreach(actiondata in player.var_7e1fbc36c642e883) {
      statusarray[statusarray.size] = stringid + "<dev string:x37>" + actiondata.var_207be84752024f73;
    }

    player debugactionstatus(statusarray);

    waitframe();
  }
}

function private startslowmotion(slowmotimescale) {
  self notify("\x84\xd5\xe1b2\xed\x9co\x99\xc4V\xa2\x1f\xbbW\xa9");
  self endon("\x84\xd5\xe1b2\xed\x9co\x99\xc4V\xa2\x1f\xbbW\xa9");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("\x99\\\xd0n\xaa\x1c\x1f\xe242-\xa6\x81\xac\x17\nx\x1f\xa1a\xffW");
  var_58370cd0398ed8c9 = 1;
  utility_sp::function_712369ee845f814c("b\x95\xc1\xf7E0\xc0\x06\x9c\xa2\xc7\xc5\xf3Q\x02", slowmotimescale, var_58370cd0398ed8c9);
  var_c562f052079cdf6 = 0.8;
  var_9e643ae3c1e49e7e = var_c562f052079cdf6 / slowmotimescale;
  player utility_sp::blend_movespeedscale(var_9e643ae3c1e49e7e, var_58370cd0398ed8c9, "b\x95\xc1\xf7E0\xc0\x06\x9c\xa2\xc7\xc5\xf3Q\x02");
  wait 0.8;
  player.var_651cf316057ad44d = slowmotimescale / var_c562f052079cdf6;
  player function_99da4e5afe59f75e(1);
  player setfiretimescaleon(int(player.var_651cf316057ad44d * 100));
  player player_recoilscaleon(int(player.var_651cf316057ad44d * 100));
}

function private endslowmotion(slowmotimescale, var_34ebf7a36bdfdebd) {
  player = self;
  player notify("\x99\\\xd0n\xaa\x1c\x1f\xe242-\xa6\x81\xac\x17\nx\x1f\xa1a\xffW");
  var_ed18a8fe77de79ce = 0.1;
  player function_99da4e5afe59f75e(0);
  player setfiretimescaleoff();
  player player_recoilscaleoff();
  player.var_651cf316057ad44d = undefined;

  if(var_34ebf7a36bdfdebd > 0) {
    wait var_34ebf7a36bdfdebd * 0.001;
  }

  player utility_sp::blend_movespeedscale(1, var_ed18a8fe77de79ce, "b\x95\xc1\xf7E0\xc0\x06\x9c\xa2\xc7\xc5\xf3Q\x02");
  utility_sp::function_2853d8d2bf2b2f5("b\x95\xc1\xf7E0\xc0\x06\x9c\xa2\xc7\xc5\xf3Q\x02", var_ed18a8fe77de79ce);
}

function private function_f09e98709e3fc40f(stringid, actiondurationms, var_636de3f391a5bb21) {
  player = self;
  assert(isDefined(player.var_7e1fbc36c642e883));

  if(!isDefined(player.var_7e1fbc36c642e883[stringid])) {
    player.var_7e1fbc36c642e883[stringid] = spawnStruct();
  }

  player.var_7e1fbc36c642e883[stringid].endtimems = gettime() + actiondurationms;
  player.var_7e1fbc36c642e883[stringid].var_207be84752024f73 = var_636de3f391a5bb21;
}

function private function_d94a53b2efa21875() {
  player = self;
  player endon("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD");

  while(true) {
    player waittill("9\xfca\xad\f^Rj.\xe6\xc6$", weaponobj);
    penaltydurationms = 100;
    penaltyrate = 1.5;
    weapclass = weaponclass(weaponobj);

    switch (weapclass) {
      case #"hash_8cdaf2e4ecfe5b51":
      case #"hash_900cb96c552c5e8e":
      case #"hash_fa24dff6bd60a12d":
        penaltyrate = 3;
        break;
      case #"hash_690c0d6a821b42e":
        penaltyrate = 4.5;
        break;
      default:
        break;
    }

    player function_f09e98709e3fc40f("W\x84:e\x88\xf5T\x16M9\x94", penaltydurationms, penaltyrate);
  }
}

function private function_30d7d457cfd53cf9() {
  player = self;
  player endon("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD");
  var_3443eb41d026cce9 = 200;
  var_46a2ef82f0ee207b = 4;

  while(true) {
    player waittill("\n7\x02\xab\\\x98\r\xca\xdc\xaa\xa9", weaponobj, var_dcd42da4dce0227d, targetent, var_f176ddc05c193aef);
    player function_f09e98709e3fc40f("mV\x8d+e", var_3443eb41d026cce9, var_46a2ef82f0ee207b);
  }
}

function private function_e5fb902da089ea55() {
  player = self;
  player endon("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD");
  var_b88fddfa158ec14d = 200;
  var_b8380256562a5b37 = 1;

  while(true) {
    player waittill("+\xdaq\x17\x8c\xac/\xc0\xa4(*\x81\xf9", weaponobj);
    player function_f09e98709e3fc40f("\x10\x89\xc9I\x96$\x8f", var_b88fddfa158ec14d, var_b8380256562a5b37);
  }
}

function private debugactionstatus(statusarray) {
  player = self;

  if(!getdvarint(@ "hash_67434e5fb875fd52", 0)) {
    return;
  }

  start_y = 30;
  start_x = 0;
  line_height = 12;
  statustextindex = 0;

  if(!isDefined(player.var_8092a43f1ded44de)) {
    player.var_8092a43f1ded44de = [];
  }

  foreach(textlabel in statusarray) {
    if(!isDefined(player.var_8092a43f1ded44de[statustextindex])) {
      textelem = player hud_util::createclientfontstring("<dev string:x44>", 1);
      textelem hud_util::setpoint("<dev string:x4f>", undefined, start_x, start_y - statustextindex * line_height);
      textelem.color = (1, 0.1, 0.1);
      player.var_8092a43f1ded44de[statustextindex] = textelem;
    } else {
      textelem = player.var_8092a43f1ded44de[statustextindex];
    }

    textelem setdevtext(textlabel);
    statustextindex++;
  }

  while(statustextindex < player.var_8092a43f1ded44de.size) {
    player.var_8092a43f1ded44de[statustextindex] setdevtext("<dev string:x60>");
    statustextindex++;
  }
}

function private debugactionstatusclear() {
  player = self;

  if(isDefined(player.var_8092a43f1ded44de)) {
    foreach(textelem in player.var_8092a43f1ded44de) {
      textelem hud_util::destroyelem();
    }

    player.var_8092a43f1ded44de = undefined;
  }
}

function private function_ed59174d0a929a65(time_left) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  player = self;
  soundsettimescalefactorfromtable("\xff\x91\xa3D\x0f\xd2\x99\xab\xbaJ\xfe\xa7\x1b\x1c\x97Y\xc8\x8f<\xbd\xf3\xc6\xf1\x89\x9d\xda");
  player setsoundsubmix("\xff\x91\xa3D\x0f\xd2\x99\xab\xbaJ\xfe\xa7\x1b\x1c\x97Y\xc8\x8f<\xbd\xf3\xc6\xf1\x89\x9d\xda", 1.5);
  player setclienttriggeraudiozone("\xff\x91\xa3D\x0f\xd2\x99\xab\xbaJ\xfe\xa7\x1b\x1c\x97Y\xc8\x8f<\xbd\xf3\xc6\xf1\x89\x9d\xda");
  snd::play("0\xcf\x15>Jh\r\xf1zG,\x8b=\x06\xe9\xb0\xbdiPr", player);
  snd::play([0.3, "\xa7\x92(\xf2,U\x87\xb6\xcb$\xbfB\xb1\xd0\x0e\xaa\xe2\xdf \x11'g~\x9f\xed", 0], player);
  drone = snd::play([0.3, "_\xf0\ni6[\x12\xd0\x1b\xea\xdfm\xb1c^\xe9\xdbr9\xb8\xff\xcf\xab\x8b\xc1b", 0.5], player);
  air = snd::emitter("3\xc8\xf0K\xb2LcnnV\x875C\xe0\x88B/S\xeb", player, [1, 1.5], 20, [-25, 25], 24);
  heart = snd::play([1, "\xab\xad0\xf3<#,\x0e\xac\xf9\x14\xbf\xee\x05\xd9o/\x8aE}^\xe3\x16&", 0.5], player);
  player utility::waittill_any("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD", "\x1e\xfd\xd1\xa2\a");
  snd::stop(drone, 0.5);
  snd::stop(air);
  snd::stop(heart, 0.5);
  snd::play("\xfd\x94\xa1\x0e\x1es` \x93\x19K\xacP\xe9\x14\x05,N\xf3\xba\x1ax\xecoy>", player);
  soundsettimescalefactorfromtable("!kk\t\xdb\xe5\x8c\xca\x94\rD\xb7\x13\x13");
  player clearsoundsubmix("\xff\x91\xa3D\x0f\xd2\x99\xab\xbaJ\xfe\xa7\x1b\x1c\x97Y\xc8\x8f<\xbd\xf3\xc6\xf1\x89\x9d\xda", 1.5);
  player clearclienttriggeraudiozone(1);
}

function private stimshot_fx() {
  player = self;
  player notify("\n\x0fG\xbe\xe8H\xf7\x01\xfa_>\x1b\xb2\x97T>8d\\\xffh=\x01\"\x06\xd0\xe7\r");
  enterfxlength = 1;
  playFXOnTag(utility::getfx("\x85\xf8\xf0\xc7\\!\xe0\xfd\x85|\x93\xdb?\x1f\x86\xdcIp\xd8\x03\xaf"), player, "\xc7\xae?f\x10\xbcr");
  pbgpostfxbundlestart(player, "y\x8f7\xf1\x81\x04l(?q\xdb\xc1y\xa6\xe3Q\x89^\xbc\x9aC\xaa\x99N\xc2\x17\xab\xb0");
  msg = player utility::waittill_any_timeout(enterfxlength, "W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD", "\x1e\xfd\xd1\xa2\a");

  if(msg != "\xb5B\xd7\x904}\x11") {
    return;
  }

  playFXOnTag(utility::getfx("'\x06\xfe\xae<\xad\xf0\xcb\xc7\fm\xa0\xdf\xdb0\x1ax\xb8\xf7H"), player, "\xc7\xae?f\x10\xbcr");
  pbgpostfxbundlestart(player, "\xbah\xd8_T@\xa0\xa6\xf7\x93\x1d\x13\xc0\xdfi\xf9;\xe0\x19\x95\xd3\x17");
  msg = player utility::waittill_any_return("W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD", "\x1e\xfd\xd1\xa2\a");
  var_3ca46abd237c714e = 0.3;
  assert(var_3ca46abd237c714e < enterfxlength);
  player thread function_9acd9ea0f4098a6(gettime() + int(var_3ca46abd237c714e * 1000));
  pbgpostfxbundleend(player, "\xbah\xd8_T@\xa0\xa6\xf7\x93\x1d\x13\xc0\xdfi\xf9;\xe0\x19\x95\xd3\x17");

  if(msg == "W\xfd&mr\x1a51\x93\x12\n~V\x0e7\x92& 5\nD") {
    pbgpostfxbundlestart(player, "\x81R\x15c)$\xb8jP~\xf1\xe8`\xc3\x82I\x01\xf8r\xf7\xb0\xd6\xb5ff\x86X");
  }
}

function private function_9acd9ea0f4098a6(endtime) {
  self notify("\xc1\x92\xf4\xb5\xfe\xce\xbe\x89\xf52\xe5\xe4\x1b\xaa\x92\xf7");
  self endon("\xc1\x92\xf4\xb5\xfe\xce\xbe\x89\xf52\xe5\xe4\x1b\xaa\x92\xf7");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("\n\x0fG\xbe\xe8H\xf7\x01\xfa_>\x1b\xb2\x97T>8d\\\xffh=\x01\"\x06\xd0\xe7\r");

  while(gettime() <= endtime) {
    stopFXOnTag(utility::getfx("'\x06\xfe\xae<\xad\xf0\xcb\xc7\fm\xa0\xdf\xdb0\x1ax\xb8\xf7H"), player, "\xc7\xae?f\x10\xbcr");
    wait 0.1;
  }
}