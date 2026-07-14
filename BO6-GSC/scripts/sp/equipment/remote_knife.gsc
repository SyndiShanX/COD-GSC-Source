/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\remote_knife.gsc
*************************************************/

#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace remote_knife;

function private autoexec function_8f96fb6a976ffef() {
  offhands::registerprecachefunc("\xf1\x13U\xd1\x15\x87\b\xea\xea_\xfe\xc7X\x1c\xcf\x9b", &precache);

  setDvar(@ "hash_599290dd243b234c", 0);
  setdevdvarifuninitialized(@ "hash_eac9b2acc066ff2", 0);

  utility_sp::post_load_precache(&precache_postload);
  level thread function_941bcef3060b143c();
}

function private precache(offhand) {
  utility::add_fx("2\x9a6\xde\xc4\x1cO\xb42|\x02\xe3\xcb{(\xec\xb6\x9e", "\xcc\"\x84\xa1N\xc9\xa0 -\xb5\x1f\xab\xc9S\xacP{x\xe3\b\xb5\x85(\v\x0e,/;\x101\x04\xdeN\xeaf\xe6\xb4_\x90\xb4");
  utility::add_fx("\xf4\xff\xc9\xfd1\xfe\xfbC\x1e\xfda\x93?\x15\x97&\x9c", "\x04n\xc7\xf9&\xbfW\n\xab\x82zK\xb4\x7f\x9f2\"\xf9\xf3\xa4'Z\xae\x9bW\xf7\\\x05U\xb0+\xe5\x10\x18\nF|[>");
  utility::add_fx("\xce$t N\x98{:E4\x9d\xab\xc9Wl\x10\x1bf\xe3\xf8\xb6\xd5\xab\v", "R\x9a\xf1\xf1\xb7\x1f\x1f\xac7\xd3\n\x93\x1d\x8dCJ(\xc0I\x8dq\xd4X\x15\xf1X\xa5f\xe3\xe8\xf1i\x81\xaa\xe3\xdd\xad\xd9\xb3\x0f\xc2js");
  offhands::registeroffhandfirefunc(offhand, &function_6a40ebdae1888ed0);
  assert(isDefined(level.player));
  level.player thread remoteknifecooked(offhand);
}

function private precache_postload() {
  var_1fbeea77f1449474 = getaiarray("?\xb1\xc0\x9a");

  foreach(guy in var_1fbeea77f1449474) {
    guy utility_sp::add_damage_function(&function_14d35effc8833f37);
  }

  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &function_fdbf819e6d861a5);
}

function private function_941bcef3060b143c() {
  utility::flag_wait("\x9b2\xab\x88yvw\xcb");
  utility_sp::add_extra_autosave_check("\x9ce\xd6o\x8eY\xd7\xadsK\x99V", &function_b8e6ed4ad846781, "0\x93Q\xd6\xfc2'\xcdZ\x10\x8e\x10\x1b\x16\xd8P\xca \xe6\x1c\x8a\xe0xm\x88=\xbb\x86\x02O\x9c");
}

function function_b8e6ed4ad846781() {
  return !isDefined(level.player.var_55b12bbbeabeda4);
}

function private function_fdbf819e6d861a5() {
  if(isactor(self)) {
    utility_sp::add_damage_function(&function_14d35effc8833f37);
  }
}

function private function_14d35effc8833f37(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon) {
  player = level.player;

  if(isDefined(player.var_e26d23a0b8f36e43)) {
    if(!isalive(self) && isDefined(objweapon) && (objweapon.basename === "S\x1bw\x15\xa2\xdb\xad\x93\xb8\xca\xa1\xd1\x9f\xc5<\xca\x92\x1fE5\f\xca\xa0\x15\xfd,\xc8" || objweapon.basename === "\v\xe5\xef\xc1\xbfW\xf1\xc6\a\x1c\xbe m\xf2\xcf_1\xdf\xb8\xee\xd8\xaa\x7f#\x0f\xbf\x02\xae\x0f\x85\xb9\xbd>y\xd1")) {
      player.var_55b12bbbeabeda4++;
    }

    player.var_e26d23a0b8f36e43[player.var_e26d23a0b8f36e43.size] = self;
  }
}

function function_31e83fe6ce792d02(killtrigger) {
  if(!isDefined(level.player.var_3ebc800f6823d658)) {
    level.player.var_3ebc800f6823d658 = [];
  }

  level.player.var_3ebc800f6823d658[level.player.var_3ebc800f6823d658.size] = killtrigger;
}

function private function_6a40ebdae1888ed0(dummyprojectile, weapon) {
  self notify("\xeb\xa1\x9b\x98\x17^\xb2\x11\x19\xef\xb6O@\xa6UM");
  self endon("\xeb\xa1\x9b\x98\x17^\xb2\x11\x19\xef\xb6O@\xa6UM");
  level endon("3Gd5^\x0e\x85_h\xea\x8e@\xa7AV9\xd6\rN1C\xca\xe7h{\xef\xccq");

  if(!isDefined(dummyprojectile)) {
    return;
  }

  var_b813977bf24505e0 = utility::ent_flag("\x98\xa6\xf9\xcct]p-\xa8)\xa20\xde/\x18dEJ\xfd@");
  utility::ent_flag_clear("\x98\xa6\xf9\xcct]p-\xa8)\xa20\xde/\x18dEJ\xfd@");
  self notify("f\a\x97W\xdb5A9zj\"G\x11\xb4\xa1ie\fw\xb9\xe40qN;\xfb\xb3");

  if(var_b813977bf24505e0) {
    thread controlremoteknifeprojectile(dummyprojectile);
    return;
  }

  lookatdir = anglesToForward(self getplayerangles());
  knifespawnpos = dummyprojectile.origin + lookatdir * 20;
  knifevelocity = dummyprojectile getmissilevelocity();
  dummyprojectile delete();
  knife = magicgrenademanual(makeweapon(istrue(level.var_d4ffe2f2ca5b7ee) ? "\x16\x17\x82\x14\xaaS+\x02\x12\x0e\xe8\xaf[\xcf\xb9\xe9\v\xfd\x19x\xe2\xcd\x02u\x7f1T\x0eE\x84o\x8d\x81\xb5\x9e\xfa_" : "\xa4\x7fn\x90\x16\x7f\xefi\x84O\xe7`U\f6\xd8\xe4r\x12\xa0p\x03\x8b\x9ehh\x1bF\xbc"), knifespawnpos, knifevelocity, 2, self);
  knife thread function_37a2c8fcf3409972();
  knife hide();
  waitframe();

  if(isDefined(knife)) {
    knife show();
  }

  knife thread function_eaf6312a4099fd0a(self);
}

function private function_37a2c8fcf3409972() {
  self notify("\xaa\xd6lm\xfc\x9fc\xbe.M\xfa\x83V3%!");
  self endon("\xaa\xd6lm\xfc\x9fc\xbe.M\xfa\x83V3%!");
  knife = self;
  knife endon("\x1e\xfd\xd1\xa2\a");
  knife waittill("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18");
  knife makeunusable();
}

function private function_eaf6312a4099fd0a(player) {
  self notify("\xf0$ \xd8\xe7Q3;\xc5\xda\xfdG\x13\x99\f\\");
  self endon("\xf0$ \xd8\xe7Q3;\xc5\xda\xfdG\x13\x99\f\\");
  knife = self;
  knife endon("\x1e\xfd\xd1\xa2\a");
  player endon("\x1e\xfd\xd1\xa2\a");
  knife setCanDamage(1);
  knife.health = 2147483647;
  knife.maxhealth = 2147483647;
  knife waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
  knife detonate();
}

function private function_16b80c81a10384b0(missile) {
  player = self;
  pivotent = missile utility::spawn_tag_origin();
  pivotent linkTo(missile, "\xec\xbfK|\au\xcd\xc2\x19<", (0, 0, 0), (0, 0, 0));
  player thread function_659308c952ae9bbf(missile, pivotent);
  fakeknife = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", missile.origin);
  fakeknife setModel("\xb40\x1f\xfe\x87\x02\x98\x028\xec\xf2'\xcb\xdf/:\x01\a\xc9\xb7\x8e\f\xda \r)\bD=d\x18i\x05\xb4*\xf7\xf1\a\xf4\xa1\xd3\xe9\x13J\xc9");
  fakeknife linkTo(pivotent, "\xec\xbfK|\au\xcd\xc2\x19<", (0, 0, 0), (0, 0, 0));
  fakeknife hide(1);
  var_d3cb28ae6620a699 = 1900;
  var_90603eec34444679 = 3.6;
  var_2e8b312bd5fc86de = var_d3cb28ae6620a699 * var_90603eec34444679;
  fakeknife rotatebylinked((var_2e8b312bd5fc86de, 0, 0), var_90603eec34444679, 0.2, 0);
  waitframe();

  if(isDefined(missile) && isalive(player)) {
    fakeknife show();
    playFXOnTag(utility::getfx("\xce$t N\x98{:E4\x9d\xab\xc9Wl\x10\x1bf\xe3\xf8\xb6\xd5\xab\v"), fakeknife, "I\x01^\x89\x9f\xca");
    utility::waittill_any_ents(missile, "\x1e\xfd\xd1\xa2\a", player, "\x1e\xfd\xd1\xa2\a");
    killfxontag(utility::getfx("\xce$t N\x98{:E4\x9d\xab\xc9Wl\x10\x1bf\xe3\xf8\xb6\xd5\xab\v"), fakeknife, "I\x01^\x89\x9f\xca");
    waitframe();
  }

  fakeknife delete();
  pivotent delete();
}

function private function_659308c952ae9bbf(missile, pivotent) {
  player = self;
  pivotent endon("\x1e\xfd\xd1\xa2\a");
  var_c8f6f5757470844c = 15;

  while(isDefined(missile) && isalive(player)) {
    cammovementvec = player getnormalizedcameramovement();
    targetangle = cammovementvec[1] * var_c8f6f5757470844c;
    pivotent setlinkedangles((0, targetangle * -1, 0));
    waitframe();
  }
}

function private function_a39bdd7cc890ad31(missile) {
  player = self;
  missile endon("\x1e\xfd\xd1\xa2\a");
  missile endon("\xbf\x8ef\xfa\x1f\xbd\xa44-\xfbH\r\x1fBQ~\x84F\xdc");
  var_e557c80b2ca95d1c = 8;
  player.var_40a5e69bb5af1ae6 = undefined;
  prevorigin = missile.origin;

  while(true) {
    waitframe();

    if(isDefined(level.outofboundstriggers)) {
      foreach(oobtrigger in level.outofboundstriggers) {
        if(isDefined(oobtrigger.failtrigger) && missile istouching(oobtrigger.failtrigger)) {
          player notify("\\\xbd^!\x88\xaa\x1e\x82\"\x82\x1f$0\xb7\x1a\x8e\xac|4m\x14\x17rs\xc3\xf6\xdf:\x0er\xab\xfc\xdb");
          return;
        }
      }
    }

    if(isDefined(level.player.var_3ebc800f6823d658)) {
      foreach(killtrigger in level.player.var_3ebc800f6823d658) {
        if(isDefined(killtrigger) && missile istouching(killtrigger)) {
          player notify("\\\xbd^!\x88\xaa\x1e\x82\"\x82\x1f$0\xb7\x1a\x8e\xac|4m\x14\x17rs\xc3\xf6\xdf:\x0er\xab\xfc\xdb");
          return;
        }
      }
    }

    currentvel = missile.origin - prevorigin;

    if(length(currentvel) > 0) {
      prevorigin = missile.origin;
      player.var_40a5e69bb5af1ae6 = vectorNormalize(currentvel);
      enemytraceresult = trace::sphere_trace(prevorigin, missile.origin, var_e557c80b2ca95d1c, player);
      hitent = enemytraceresult["\x1f\xa8\x10WP\xa9"];

      if(isactor(hitent) && hitent.team == "?\xb1\xc0\x9a") {
        player notify("\\\xbd^!\x88\xaa\x1e\x82\"\x82\x1f$0\xb7\x1a\x8e\xac|4m\x14\x17rs\xc3\xf6\xdf:\x0er\xab\xfc\xdb");
      }
    }
  }
}

function private function_7031082a99d2c6fa(missile) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  missile endon("\x1e\xfd\xd1\xa2\a");
  beep_duration = 1.2;
  beep_sound = "\x9e\x7fY'u\x98B\xdfYzoy\n|\x06;\xbb\xf8\x06\xcd\xaf~\xab\xe0";
  beepdelay = 3.5 - beep_duration;
  wait beepdelay;
  missile thread utility_sp::play_sound_on_tag(beep_sound, "\xec\xbfK|\au\xcd\xc2\x19<", 1);
}

function private function_798e49deca2bf815() {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  utility_sp::function_712369ee845f814c("4\xb6\xe3\x8f2N\xcbTm\xb6uF\xff:1Q(W\x99o", 1, 0);
  wait 0.1;
  utility_sp::function_2853d8d2bf2b2f5("4\xb6\xe3\x8f2N\xcbTm\xb6uF\xff:1Q(W\x99o", 0, 0);
  setglobalsoundcontext("\x89\xd3\x83\xb7", "\x91\xca\xcc\v\xab\xd8:");
  soundsettimescalefactorfromtable("!kk\t\xdb\xe5\x8c\xca\x94\rD\xb7\x13\x13");
}

function private function_45c198c7b9a549b2(missile) {
  player = self;

  if(!isalive(player)) {
    return;
  }

  lastvel = player.var_40a5e69bb5af1ae6;
  lastpos = player.var_c0e935c49d7c94bf;

  if(isDefined(lastvel) && isDefined(lastpos)) {
    player thread function_798e49deca2bf815();
    var_6e6f4d9e2434efc6 = 256;
    var_a57933aacf05230a = 0.65;
    var_160b6b14faac9c5a = 0.55;
    var_72d462aae12f44f3 = 0;
    var_2a49a24e705ab0b8 = 0.5;
    var_6494aa30461869e9 = 0.5;
    var_c08aa0db3527b47f = lastpos;
    var_35d4cdc06e391dd2 = lastpos - lastvel * var_6e6f4d9e2434efc6;
    var_9226de5afa145083 = trace::ray_trace(var_c08aa0db3527b47f, var_35d4cdc06e391dd2);
    var_7bee40b2be93a73b = var_9226de5afa145083["\xc1\xbd\xdci\xe8i{7"];
    var_70d1d33c151dd5a6 = var_7bee40b2be93a73b;

    if(var_9226de5afa145083["\xda\x16\x81\aw}^i"] > var_a57933aacf05230a) {
      var_70d1d33c151dd5a6 = var_c08aa0db3527b47f + (var_35d4cdc06e391dd2 - var_c08aa0db3527b47f) * var_a57933aacf05230a;
    }

    totarget = var_c08aa0db3527b47f - var_70d1d33c151dd5a6;

    if(length(totarget) == 0) {
      totarget = var_c08aa0db3527b47f - player getEye();
    }

    totarget = vectorNormalize(totarget);
    var_33a183c66ad91efc = vectortoangles(totarget);
    knifekillcament = utility::function_94c66bbed3da2a18(var_70d1d33c151dd5a6, var_33a183c66ad91efc);
    knifekillcament moveTo(var_7bee40b2be93a73b, var_160b6b14faac9c5a, var_72d462aae12f44f3, var_2a49a24e705ab0b8);
    player screenshakeonentity(6, 12, 6, 0.5, 0, 0.4, 0, 5, 5, 5);
    player cameraunlink();
    player cameralinkTo(knifekillcament, "\xec\xbfK|\au\xcd\xc2\x19<", 1);
    player val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", " \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[", 1);
    var_6a51b59e3a2f4718 = 0.15;
    wait var_6a51b59e3a2f4718;
    shouldskipkillcam = player function_5e72370a779b2442(totarget, var_9226de5afa145083, var_a57933aacf05230a, lastpos);

    if(!shouldskipkillcam) {
      player utility::waittill_notify_or_timeout("\x1e\xfd\xd1\xa2\a", var_6494aa30461869e9 - var_6a51b59e3a2f4718);
    }

    knifekillcament delete();
  }
}

function private function_5e72370a779b2442(camdir, var_9226de5afa145083, minfraction, lastpos) {
  player = self;
  closetargets = [];
  var_41d96923ac2bea27 = 32400;

  foreach(potentialtarget in player.var_e26d23a0b8f36e43) {
    if(!isDefined(potentialtarget)) {
      continue;
    }

    if(distancesquared(potentialtarget getcentroid(), lastpos) < var_41d96923ac2bea27) {
      closetargets[closetargets.size] = potentialtarget;
    }
  }

  if(closetargets.size < 1) {
    return true;
  }

  if(var_9226de5afa145083["\xda\x16\x81\aw}^i"] <= minfraction) {
    var_fc37b0631e867a35 = 0;

    foreach(guy in closetargets) {
      dirtoguy = vectorNormalize(guy getcentroid() - lastpos);

      if(vectordot(camdir, dirtoguy) > cos(55)) {
        var_fc37b0631e867a35 = 1;
        break;
      }
    }

    if(!var_fc37b0631e867a35) {
      return true;
    }
  }

  var_796398e6852a7061 = 640000;

  if(distancesquared(player getEye(), lastpos) < var_796398e6852a7061) {
    if(sighttracepassed(player getEye(), lastpos, 0, player)) {
      return true;
    }
  }

  return false;
}

function private function_9b9a292a9abc3104() {
  player = self;
  helper_prompts = [];
  var_636753d4b4cd3d2c = !player getlocalplayerprofiledata("\xcbXuC\x14 S2\xff\xc71");

  if(var_636753d4b4cd3d2c) {
    helper_prompts["\x99\x93\x8bF\xdf\xb7\xb0\xd5\xc2\xbd\x94jW/\x88\x04\x90\xc9"] = &"hash_2c55152a4f9279e9";
  } else {
    isusingcontroller = player usinggamepad();

    if(isusingcontroller) {
      config = getsticksconfig();
      southpaw = issubstr(config, "x\xeffu\x14\a\xe2'");
      legacy = issubstr(config, "\x8f\x99&\x97\x88\xc3");

      if(!southpaw && !legacy) {
        helper_prompts["\x99\x93\x8bF\xdf\xb7\xb0\xd5\xc2\xbd\x94jW/\x88\x04\x90\xc9"] = &"hash_189c53f5cc109021";
      } else if(southpaw && !legacy) {
        helper_prompts["\x99\x93\x8bF\xdf\xb7\xb0\xd5\xc2\xbd\x94jW/\x88\x04\x90\xc9"] = &"hash_181d2e58a6cba865";
      } else {
        helper_prompts["\x99\x93\x8bF\xdf\xb7\xb0\xd5\xc2\xbd\x94jW/\x88\x04\x90\xc9"] = &"hash_34ad3bfb783cc021";
      }
    } else {
      helper_prompts["\x99\x93\x8bF\xdf\xb7\xb0\xd5\xc2\xbd\x94jW/\x88\x04\x90\xc9"] = &"hash_189c53f5cc109021";
    }
  }

  helper_prompts["\xf1X\x80\x11{\xc3\x98z{R.\x9a\xd1\xec\xbd\x9e\xaa\x7f\x98\xa1*"] = &"hash_2ce392532a549038";
  return helper_prompts;
}

function private function_d3e4d3409755b90(missile) {
  self notify("\xff\xae5\x06\xb4@\xef\xd0D\x1eG\xe4*\xe5\xf1\xf6");
  self endon("\xff\xae5\x06\xb4@\xef\xd0D\x1eG\xe4*\xe5\xf1\xf6");
  player = self;
  var_5a920340dccee677 = undefined;

  while(isDefined(missile) && isalive(player)) {
    hintarray = player function_9b9a292a9abc3104();

    if(!isDefined(var_5a920340dccee677) || hintarray["\x99\x93\x8bF\xdf\xb7\xb0\xd5\xc2\xbd\x94jW/\x88\x04\x90\xc9"] != var_5a920340dccee677) {
      player utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "\x9ce\xd6o\x8eY\xd7\xadsK\x99V", hintarray);
      var_5a920340dccee677 = hintarray["\x99\x93\x8bF\xdf\xb7\xb0\xd5\xc2\xbd\x94jW/\x88\x04\x90\xc9"];
    }

    waitframe();
  }

  player utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\x9ce\xd6o\x8eY\xd7\xadsK\x99V");
}

function private function_53fecbe49bdf1d05() {
  helper_prompts = [];
  helper_prompts["\xf1X\x80\x11{\xc3\x98z{R.\x9a\xd1\xec\xbd\x9e\xaa\x7f\x98\xa1*"] = &"hash_2e82147bc3f955dc";
  return helper_prompts;
}

function private controlremoteknifeprojectile(projectile) {
  level notify("3Gd5^\x0e\x85_h\xea\x8e@\xa7AV9\xd6\rN1C\xca\xe7h{\xef\xccq");

  if(!isDefined(projectile)) {
    return;
  }

  if(getdvarint(@ "hash_599290dd243b234c", 0)) {
    projectile thread function_5a98ad14710389fc(1, 0);
  }

  projectileorigin = projectile.origin;
  projectilevelocity = projectile getmissilevelocity();
  projectile delete();
  var_e3541e91b1bd65e7 = getDvar(@ "hash_5cced6d09490966e");
  var_b267942104efe2d6 = getDvar(@ "hash_c0e5dbbcbe1af47f");
  setsaveddvar(@ "hash_5cced6d09490966e", "\xbe\xa2\tn\x86[");
  setsaveddvar(@ "hash_c0e5dbbcbe1af47f", "\xe65\x06@\xb9j\x81");
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "\xe4\xf1G", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "mV\x8d+e", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "\xa8Jl\x84\xb3b\x95o", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
  val::set("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L", "\x8b\x13\xa9\x82!5Q\xc9\xe8L\xfc1 P\x7f\xa6]\x0f\xb3\x11", 0);
  missile = magicbullet(makeweapon(istrue(level.var_d4ffe2f2ca5b7ee) ? "\v\xe5\xef\xc1\xbfW\xf1\xc6\a\x1c\xbe m\xf2\xcf_1\xdf\xb8\xee\xd8\xaa\x7f#\x0f\xbf\x02\xae\x0f\x85\xb9\xbd>y\xd1" : "S\x1bw\x15\xa2\xdb\xad\x93\xb8\xca\xa1\xd1\x9f\xc5<\xca\x92\x1fE5\f\xca\xa0\x15\xfd,\xc8"), projectileorigin, projectileorigin + projectilevelocity, self);

  if(isDefined(missile) && isDefined(self)) {
    missile setotherent(self);
  }

  if(getdvarint(@ "hash_599290dd243b234c", 0)) {
    color = (1, 0.4, 0.72);
    line(self getcentroid(), projectileorigin, color, 1, 0, 1000);
    sphere(projectileorigin, 10, color, 0, 1000);
  }

  oldplayerangles = self getplayerangles();
  self cameralinkTo(missile, "<\xd7\x93\xbf-\xe8NE\x19\xcd", 1);
  self controlslinkTo(missile);
  self allowfire(0);
  self.var_e26d23a0b8f36e43 = [];
  self.var_55b12bbbeabeda4 = 0;
  var_58370cd0398ed8c9 = 0.5;
  utility_sp::function_712369ee845f814c("\x9ce\xd6o\x8eY\xd7\xadsK\x99V", 0.3, var_58370cd0398ed8c9);
  setglobalsoundcontext("\x89\xd3\x83\xb7", "8\xcaP8\x8c");
  soundsettimescalefactorfromtable("\xe6\x1c\xd7\x8e\x89\f\xeb+\xb88\xbe\xe4\xb2\xd6\xb7:\x95\xfa\xd6\x9bZfY\xbe7\xb1\xbd\xbbk{");
  thread utility_sp::play_sound_on_tag("\x8c\xa3\xe6\xeb\xc1\xff\xcd\xa3^\xb7M\x82P\xff\xa2\xc8\x1b\x95\xbb\x02\x85V}>\x85\x18\xac\x80\x94");
  thread function_c980e7cf8f29915f(missile, var_58370cd0398ed8c9);
  thread function_16b80c81a10384b0(missile);
  thread function_a39bdd7cc890ad31(missile);
  thread function_7031082a99d2c6fa(missile);
  thread function_d3e4d3409755b90(missile);
  waituntilremoteknifefinished(missile);
  function_45c198c7b9a549b2(missile);
  function_31cb625f85a314ec();
  var_ed18a8fe77de79ce = 0.1;
  utility_sp::function_2853d8d2bf2b2f5("\x9ce\xd6o\x8eY\xd7\xadsK\x99V", var_ed18a8fe77de79ce);
  self cameraunlink();
  self controlsunlink();
  self allowfire(1);
  self setplayerangles(oldplayerangles);
  val::reset_all("A\xf1\xb5G\xd3Z\xb23\x99\xc5\xfca5\x01\xe5\xad\x02`L");
  setsaveddvar(@ "hash_5cced6d09490966e", var_e3541e91b1bd65e7);
  setsaveddvar(@ "hash_c0e5dbbcbe1af47f", var_b267942104efe2d6);
  self.var_e26d23a0b8f36e43 = undefined;
  self.var_55b12bbbeabeda4 = undefined;
}

function private function_31cb625f85a314ec() {
  player = self;

  if(player.var_55b12bbbeabeda4 >= 2 && isDefined(player.var_c0e935c49d7c94bf)) {
    achievementmindist = 1968;

    if(distancesquared(player.origin, player.var_c0e935c49d7c94bf) >= achievementmindist * achievementmindist) {
      player thread utility_sp::player_giveachievement_wrapper("\xf7\xe3\x96=\xbb\xd5wvQ\xdf\xd2\xc9\xbeu\x8blj\xb9\xc3");
    }
  }
}

function private function_c980e7cf8f29915f(missile, transitionintime) {
  player = self;
  fxent = missile utility::function_94c66bbed3da2a18();
  fxent linkTo(missile, "\xec\xbfK|\au\xcd\xc2\x19<");
  playFXOnTag(utility::getfx("2\x9a6\xde\xc4\x1cO\xb42|\x02\xe3\xcb{(\xec\xb6\x9e"), fxent, "\xec\xbfK|\au\xcd\xc2\x19<");
  playFXOnTag(utility::getfx("\xf4\xff\xc9\xfd1\xfe\xfbC\x1e\xfda\x93?\x15\x97&\x9c"), fxent, "\xec\xbfK|\au\xcd\xc2\x19<");
  pbgpostfxbundlestart(player, "\xb0\x15jh?\xaf\x1et\x82\xc59\xf2\xcd\x1a-\xb5?s\xd48i[K\xe9");
  utility::waittill_any_ents(player, "\x1e\xfd\xd1\xa2\a", missile, "\x1e\xfd\xd1\xa2\a", missile, "\xbf\x8ef\xfa\x1f\xbd\xa44-\xfbH\r\x1fBQ~\x84F\xdc");
  pbgpostfxbundleend(player, "\xb0\x15jh?\xaf\x1et\x82\xc59\xf2\xcd\x1a-\xb5?s\xd48i[K\xe9");
  pbgpostfxbundlestart(player, " \x14, \x06\x16O!_2\x90\x1fu\xb5\xf1y{,\xdd\xb4kG\xb5\x14\xe8\xa4\xb5\xf8`");
  killfxontag(utility::getfx("\xf4\xff\xc9\xfd1\xfe\xfbC\x1e\xfda\x93?\x15\x97&\x9c"), fxent, "\xec\xbfK|\au\xcd\xc2\x19<");
  waitframe();
  fxent delete();
  wait 0.1;
  pbgpostfxbundleend(player, " \x14, \x06\x16O!_2\x90\x1fu\xb5\xf1y{,\xdd\xb4kG\xb5\x14\xe8\xa4\xb5\xf8`");
}

function private function_5a98ad14710389fc(remote_control, draw_origin) {
  self endon("<dev string:x24>");
  last_position = self.origin;
  waitframe();

  while(isDefined(self)) {
    if(draw_origin) {
      var_bc9936a6fc783653 = self gettagangles("<dev string:x35>");
      var_ec3ed207aa16b31e = anglestoaxis(var_bc9936a6fc783653);
      line(self.origin, self.origin + var_ec3ed207aa16b31e["<dev string:x43>"] * 10, (1, 0, 0), 1, 0, 1000);
      line(self.origin, self.origin + var_ec3ed207aa16b31e["<dev string:x4e>"] * 10, (0, 1, 0), 1, 0, 1000);
      line(self.origin, self.origin + var_ec3ed207aa16b31e["<dev string:x57>"] * 10, (0, 0, 1), 1, 0, 1000);
    }

    color = remote_control ? (1, 1, 0) : (1, 0.6, 0);
    line(last_position, self.origin, color, 1, 0, 1000);
    sphere(last_position, 1, color, 0, 1000);
    last_position = self.origin;
    waitframe();
  }
}

function private waituntilremoteknifefinished(knife_ent) {
  level notify("N\xe85\xf0\x12\xef~\xe3I\x83\xa3\x01\xda\xa2\xf5\x02\x8c\xb6\t\x98\x91\n\x05\x85\x12\x94p\x9b");
  level endon("N\xe85\xf0\x12\xef~\xe3I\x83\xa3\x01\xda\xa2\xf5\x02\x8c\xb6\t\x98\x91\n\x05\x85\x12\x94p\x9b");
  self endon("\x1e\xfd\xd1\xa2\a");
  self notifyonplayercommand("\x1f\x83\xbc\x97\xff\x060\xb8\xdb\xa1\x87\xde\xd7:\xa5\x901\x85\xbd", "\x9cK\xa0pRY\xa6C$");
  self notifyonplayercommand("\x1f\x83\xbc\x97\xff\x060\xb8\xdb\xa1\x87\xde\xd7:\xa5\x901\x85\xbd", "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
  self.var_c0e935c49d7c94bf = undefined;
  msg = knife_ent utility::waittill_any_ents_or_timeout_return(3.5, self, "\x1f\x83\xbc\x97\xff\x060\xb8\xdb\xa1\x87\xde\xd7:\xa5\x901\x85\xbd", self, "\\\xbd^!\x88\xaa\x1e\x82\"\x82\x1f$0\xb7\x1a\x8e\xac|4m\x14\x17rs\xc3\xf6\xdf:\x0er\xab\xfc\xdb");
  self notifyonplayercommandremove("\x1f\x83\xbc\x97\xff\x060\xb8\xdb\xa1\x87\xde\xd7:\xa5\x901\x85\xbd", "\x9cK\xa0pRY\xa6C$");
  self notifyonplayercommandremove("\x1f\x83\xbc\x97\xff\x060\xb8\xdb\xa1\x87\xde\xd7:\xa5\x901\x85\xbd", "\x1b\xe8=\xd7,d\x1b\xef\x9e<");

  if(isDefined(knife_ent)) {
    self.var_c0e935c49d7c94bf = knife_ent.origin;
    knife_ent notify("\xbf\x8ef\xfa\x1f\xbd\xa44-\xfbH\r\x1fBQ~\x84F\xdc");

    if(isDefined(msg) && (msg == "\\\xbd^!\x88\xaa\x1e\x82\"\x82\x1f$0\xb7\x1a\x8e\xac|4m\x14\x17rs\xc3\xf6\xdf:\x0er\xab\xfc\xdb" || msg == "\x1f\x83\xbc\x97\xff\x060\xb8\xdb\xa1\x87\xde\xd7:\xa5\x901\x85\xbd" || msg == "\xb5B\xd7\x904}\x11")) {
      knife_ent detonate();
    }
  }
}

function private remoteknifecooked(offhand) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  level notify("\x9cV\xd6o\x8e\xb2i\xb9\xa5\xcc\xacC\xf6{\xda\xb2\x19");
  level endon("\x9cV\xd6o\x8e\xb2i\xb9\xa5\xcc\xacC\xf6{\xda\xb2\x19");

  while(true) {
    self waittill("\x04\x05\x86\xdb\xa3\xa0)\xc5\xf8\x89\xc0\x9fk\x94I4", grenadeweapon);

    if(isDefined(grenadeweapon) && grenadeweapon.basename == offhand) {
      thread holdprogressmonitor();
      thread function_cda6132b43b6e7fa();
    }
  }
}

function private function_cda6132b43b6e7fa() {
  self notify("\xfc\xc0\xcd\xe4\x8b\x82\xd2U\xc6\xb1J\x8e\x9b\xc6\xa9!");
  self endon("\xfc\xc0\xcd\xe4\x8b\x82\xd2U\xc6\xb1J\x8e\x9b\xc6\xa9!");
  player = self;
  player utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "\x9ce\xd6o\x8eY\xd7\xadsK\x99V", function_53fecbe49bdf1d05());
  player utility::waittill_any("\x1e\xfd\xd1\xa2\a", "f\a\x97W\xdb5A9zj\"G\x11\xb4\xa1ie\fw\xb9\xe40qN;\xfb\xb3", "\x98\xa6\xf9\xcct]p-\xa8)\xa20\xde/\x18dEJ\xfd@");
  player utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\x9ce\xd6o\x8eY\xd7\xadsK\x99V");
}

function private holdprogressmonitor() {
  self notify("\x0e\xdb\x8ab))8\r\x06\x16\x1d\x86\xe1o\xd6p");
  self endon("\x0e\xdb\x8ab))8\r\x06\x16\x1d\x86\xe1o\xd6p");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player utility::ent_flag_clear("\x98\xa6\xf9\xcct]p-\xa8)\xa20\xde/\x18dEJ\xfd@");
  player thread function_d0bdc14bb53d6e79();
  player thread holdprogresscleanup();
  assert(-1);
  var_7b086284095d88aa = 0.4;
  greenlightwait = 0.8;
  waitsuccessful = player function_8f46d4f68b9500e5(var_7b086284095d88aa, "f\a\x97W\xdb5A9zj\"G\x11\xb4\xa1ie\fw\xb9\xe40qN;\xfb\xb3");

  if(istrue(waitsuccessful)) {
    player setscriptablepartstate("\x90\xe6\xce\xee6\x1f\xd1B\xb7[\xdb", "\x17\xfdS\x11\x05\x9b\x18\xa5\x1d\xccO\x1cGWO\x7f\v\x12jk\xa8\x93\x06");
  } else {
    return;
  }

  waitsuccessful = player function_8f46d4f68b9500e5(greenlightwait, "f\a\x97W\xdb5A9zj\"G\x11\xb4\xa1ie\fw\xb9\xe40qN;\xfb\xb3");

  if(istrue(waitsuccessful)) {
    player utility::ent_flag_set("\x98\xa6\xf9\xcct]p-\xa8)\xa20\xde/\x18dEJ\xfd@");
    player setscriptablepartstate("\x90\xe6\xce\xee6\x1f\xd1B\xb7[\xdb", "`\xd0\xdd*\x9f-%\xf2\x02H\x9a,\x8f\xbfn\xcbQDW\xe9`");
    thread utility_sp::play_sound_on_tag("4\xfah\xd0m\xcf3}`4f\xa4F O\xf4\x0e\xce|p\xf7\x114uj");
  }
}

function private function_8f46d4f68b9500e5(waittime, cancelnotify) {
  player = self;
  var_b8ad02d4f5e230d8 = utility::getsharedfunc(#"equipment", #"hash_91193f6c47b8a37a");

  if(isDefined(var_b8ad02d4f5e230d8)) {
    return istrue(player[[var_b8ad02d4f5e230d8]](waittime, cancelnotify));
  }

  msg = player utility::waittill_notify_or_timeout_return(cancelnotify, waittime);
  return isDefined(msg) && msg == "\xb5B\xd7\x904}\x11";
}

function private function_d0bdc14bb53d6e79() {
  self notify("6\xe9Y\x91\xb9\x17M\xdco\x13\xd9\x1f\x11\xb1\x18C");
  self endon("6\xe9Y\x91\xb9\x17M\xdco\x13\xd9\x1f\x11\xb1\x18C");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("f\a\x97W\xdb5A9zj\"G\x11\xb4\xa1ie\fw\xb9\xe40qN;\xfb\xb3");

  while(!player function_767880e3abc6db5() && player val::get("54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w") && player val::get("K\x80\xde\x10\xf9l\xa7u\xe0\xb3\x18\xd5\xe8\xd2\x83e\xfa(\xdd\xe9\xfe\xc3\xf4")) {
    waitframe();
  }

  player notify("f\a\x97W\xdb5A9zj\"G\x11\xb4\xa1ie\fw\xb9\xe40qN;\xfb\xb3");
}

function private holdprogresscleanup() {
  self notify("FZ\xbd\xc2U9h{\x05\xe0\xf8\r\x90\xc0\xc8");
  self endon("FZ\xbd\xc2U9h{\x05\xe0\xf8\r\x90\xc0\xc8");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player waittill("f\a\x97W\xdb5A9zj\"G\x11\xb4\xa1ie\fw\xb9\xe40qN;\xfb\xb3");
  player setscriptablepartstate("\x90\xe6\xce\xee6\x1f\xd1B\xb7[\xdb", "\xf8\x88m");
}