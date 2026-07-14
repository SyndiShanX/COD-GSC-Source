/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\shock_cluster_bomb.gsc
*******************************************************/

#using script_16ea1b94f0f381b3;
#using script_53f4e6352b0b2425;
#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\equipment\shock_common;
#using scripts\sp\hud_util;
#using scripts\sp\player\cursor_hint;
#namespace shock_cluster_bomb;

function autoexec function_f28a079d772ed706() {
  offhands::registerprecachefunc("ZgUw\x1fT\xcf\x02JYOi\xc0\xf7\xfe\x8a\x03>Rr\xa8\x05", &precache);
}

function private precache(offhand) {
  shock_common::function_55d3e12aa448c6e5(offhand);
  utility::add_fx("\x19\xe8\x82\x1b87\xdc\x02\xcc\xc5\x98\xe3\xd5\xe7\xb9@\v|z", "\xf4\x8d\xbda\x89\x0f\xc4\x0e\x93\x95v5\xd8U\xfes5/\xb9\x10\x92\xde!\xab\x8f\xd1D\xfcE]\xba\xfc\x1f");
  utility::add_fx("\xa0\x9a\xba\a\xd7\x01{\xa6KF\xbe\x85Wp\xf8\x91N1\xe4X", "\x06*\xfaHJ\t<KM\x8e\xca\xfb\xdc\xc5\xa3:^1\xe6\x95\x9eX\xd3oWo\xc0\x01\xc9\x8e\xde\xcc\xbeq\xb1\xc5B\"\xfe");

  if(!isDefined(level.var_b960ffbfe7572d3e)) {
    level.var_b960ffbfe7572d3e = trace::create_contents(0, 1, 1, 0, 1, 1);
  }

  offhands::registeroffhandfirefunc(offhand, &function_2150114678c7159);
  offhands::function_165e4499ef04c19(offhand, (0, 0, 13));
  offhands::overrideweaponoffhandtype("ZgUw\x1fT\xcf\x02JYOi\xc0\xf7\xfe\x8a\x03>Rr\xa8\x05", 0);
  level.player thread function_d49597c8dc521d5e(offhand);
}

function private function_d49597c8dc521d5e(offhand) {
  self notify("\xcb\xc1\xb3;;\xc5\xef\xd7\xb6\xe8\xb4u\t+\x14\x87");
  self endon("\xcb\xc1\xb3;;\xc5\xef\xd7\xb6\xe8\xb4u\t+\x14\x87");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    player waittill("\x04\x05\x86\xdb\xa3\xa0)\xc5\xf8\x89\xc0\x9fk\x94I4", grenadeweapon);

    if(isDefined(grenadeweapon) && grenadeweapon.basename == offhand) {
      player thread function_74fda66353c12acd();
      player thread function_f557f6c415ddc10a();
      player thread function_cda6132b43b6e7fa();
    }
  }
}

function private function_53fecbe49bdf1d05() {
  helper_prompts = [];
  helper_prompts["\xa4\xc5\xab1\xdb\\\xd6g9e\f\x8aG\xdc\xefq*\xdc"] = &"hash_8360aa48c3a0b34";
  return helper_prompts;
}

function private function_cda6132b43b6e7fa() {
  self notify("\x02\xb5\xb2qE\xdb\x14znu\x9b}\xb3}\xfa*");
  self endon("\x02\xb5\xb2qE\xdb\x14znu\x9b}\xb3}\xfa*");
  player = self;
  player utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "\xb4\xb3\xe7\x88\xe6\xdb\x0e\x9b\xe7\xa0\xbc\x9ao_\x8c\xd5nZ", function_53fecbe49bdf1d05());
  player utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xdc\fQ\a&L\xfbM\xfe\xefI\xe3\xbat\x05\x03=\f\xb5\xbb\x84\xd0", "\xfc\x9dg\x1aj}u\x11\x19\xf9\"\x87\xa1\x98\b\xf9JQ\b\x82`\xf3");
  player utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "\xb4\xb3\xe7\x88\xe6\xdb\x0e\x9b\xe7\xa0\xbc\x9ao_\x8c\xd5nZ");
}

function private function_74fda66353c12acd() {
  self notify("\x81\xe8\x1c~1h\x0e=;\xa7\xe01\xd6~b");
  self endon("\x81\xe8\x1c~1h\x0e=;\xa7\xe01\xd6~b");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  var_65ceecdbba29186b = 1;
  player function_61c03ad7abc59d12(0);
  var_b8ad02d4f5e230d8 = utility::getsharedfunc(#"equipment", #"hash_91193f6c47b8a37a");
  waitsuccess = 0;

  if(isDefined(var_b8ad02d4f5e230d8)) {
    waitsuccess = istrue(player[[var_b8ad02d4f5e230d8]](var_65ceecdbba29186b, "\xdc\fQ\a&L\xfbM\xfe\xefI\xe3\xbat\x05\x03=\f\xb5\xbb\x84\xd0"));
  } else {
    msg = player utility::waittill_notify_or_timeout_return("\xdc\fQ\a&L\xfbM\xfe\xefI\xe3\xbat\x05\x03=\f\xb5\xbb\x84\xd0", var_65ceecdbba29186b);
    waitsuccess = isDefined(msg) && msg == "\xb5B\xd7\x904}\x11";
  }

  if(waitsuccess) {
    player function_61c03ad7abc59d12(1);
    player snd::play("\x95\xc5p\xd77\x86\xdb6[\xf5\x98\xf6\xda\xc4\xfa\xd8CargV");
    player notify("\xfc\x9dg\x1aj}u\x11\x19\xf9\"\x87\xa1\x98\b\xf9JQ\b\x82`\xf3");
  }
}

function private function_f557f6c415ddc10a() {
  self notify("4\t$-\x9c\x82\xc9\x81{\xea\xd4\xab\xf6\xaa]\xfc");
  self endon("4\t$-\x9c\x82\xc9\x81{\xea\xd4\xab\xf6\xaa]\xfc");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player endon("\xdc\fQ\a&L\xfbM\xfe\xefI\xe3\xbat\x05\x03=\f\xb5\xbb\x84\xd0");

  while(!player function_767880e3abc6db5() && player val::get("54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w") && player val::get("{\xe0U\x19:$\x9d\\RI\x9e\xb5\xea\x7fs\x81^t\x84\xba\x1ff.:")) {
    waitframe();
  }

  player notify("\xdc\fQ\a&L\xfbM\xfe\xefI\xe3\xbat\x05\x03=\f\xb5\xbb\x84\xd0");
}

function private function_61c03ad7abc59d12(chargestate) {
  player = self;
  player.var_a57aaf5efd57852b = chargestate;

  if(chargestate == 0) {
    player setscriptablepartstate("\x90\xe6\xce\xee6\x1f\xd1B\xb7[\xdb", "\xcd\r\xde\xd8\xb5h\r\vNg\xca\xa6\x1d\x85\xec\x95\x98");
  } else if(chargestate == 1) {
    player setscriptablepartstate("\x90\xe6\xce\xee6\x1f\xd1B\xb7[\xdb", "[#\xf1\x90\xa6\xce|\x15\xb1\x8d\x19\xd4m\x98\xf8\xcc\xea");
  }

  player thread function_6c4b3fdb2be422bf();
}

function private function_6c4b3fdb2be422bf() {
  self notify("\xca\rq\xb4`\xadqY\xf9\x02\x18r\xd2\xc7\xd9");
  self endon("\xca\rq\xb4`\xadqY\xf9\x02\x18r\xd2\xc7\xd9");
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  player waittill("\xdc\fQ\a&L\xfbM\xfe\xefI\xe3\xbat\x05\x03=\f\xb5\xbb\x84\xd0");
  player setscriptablepartstate("\x90\xe6\xce\xee6\x1f\xd1B\xb7[\xdb", "\xf8\x88m");

  if(isDefined(player.var_5abad8c453c1e886)) {
    player.var_5abad8c453c1e886 hud_util::destroyelem();
  }
}

function private function_2150114678c7159(projectile, weapon) {
  player = self;

  if(!isDefined(projectile)) {
    return;
  }

  var_51fb0b2e6fc43331 = player.var_a57aaf5efd57852b ?? 0;
  player notify("\xdc\fQ\a&L\xfbM\xfe\xefI\xe3\xbat\x05\x03=\f\xb5\xbb\x84\xd0");
  arrayshockradius = [60, 120];
  shockradius = arrayshockradius[var_51fb0b2e6fc43331];
  projectile thread function_7b70bbc190c0abab(shockradius, weapon);
  projectile thread proximitydetonationwatcher(shockradius, weapon);
  projectile thread function_46ed3abc4aef2765(shockradius);
}

function private function_7b70bbc190c0abab(impactshockradius, weapon) {
  bombprojectile = self;
  player = level.player;
  enemyteam = utility::get_enemy_team(player.team);
  bombprojectile endon("\x1e\xfd\xd1\xa2\a");
  bombprojectile endon("\xed\xef\x93\xd0>");

  while(true) {
    bombprojectile waittill("\a\x9c\xde\xd4\x95\xb1\xa3\xd2\xc6\xac\xeb\x96\xb5\a\x85\x8d:\xfa,Z", aitarget);

    if(isDefined(aitarget) && isDefined(aitarget.team) && aitarget.team == enemyteam) {
      proximitydetonationcenter = bombprojectile getproximitydetonationcenter();
      targetsinrange = player getenemiesinradius(bombprojectile, impactshockradius, proximitydetonationcenter);

      if(!arraycontains(targetsinrange, aitarget)) {
        targetsinrange[targetsinrange.size] = aitarget;
      }

      player thread detonatebomb(bombprojectile, targetsinrange, weapon);
    }
  }
}

function private proximitydetonationwatcher(triggerradius, weapon) {
  bombprojectile = self;
  player = level.player;
  bombprojectile endon("\x1e\xfd\xd1\xa2\a");
  prime_delay = 0.1;
  wait prime_delay;
  var_def1b74a09a4afc1 = 0.1;
  prevproximitydetonationcenter = undefined;

  while(true) {
    proximitydetonationcenter = bombprojectile getproximitydetonationcenter();
    triggercenter = proximitydetonationcenter;

    if(!bombprojectile utility::ent_flag("\xed\xef\x93\xd0>")) {
      projforward = anglesToForward(bombprojectile.angles);
      triggercenter = proximitydetonationcenter - projforward * triggerradius;
    }

    var_5590f2afc8775f2e = player getenemiesinradius(bombprojectile, triggerradius, triggercenter, prevproximitydetonationcenter);
    prevproximitydetonationcenter = triggercenter;

    if(var_5590f2afc8775f2e.size) {
      var_3ef1d622f5b49918 = player getenemiesinradius(bombprojectile, triggerradius, proximitydetonationcenter, prevproximitydetonationcenter);

      foreach(triggerguy in var_5590f2afc8775f2e) {
        if(!arraycontains(var_3ef1d622f5b49918, triggerguy)) {
          var_3ef1d622f5b49918[var_3ef1d622f5b49918.size] = triggerguy;
        }
      }

      player thread detonatebomb(bombprojectile, var_3ef1d622f5b49918, weapon);
      return;
    }

    wait var_def1b74a09a4afc1;
  }
}

function private getproximitydetonationcenter() {
  bombprojectile = self;
  proximitydetonationcenter = bombprojectile.origin;

  if(bombprojectile utility::ent_flag("\xed\xef\x93\xd0>")) {
    bombprojectileup = anglestoup(bombprojectile.angles);
    proximitydetonationcenter = bombprojectile.origin + bombprojectileup * 5;
  }

  return proximitydetonationcenter;
}

function private getenemiesinradius(bombprojectile, testradius, testorigin, prevorigin) {
  player = self;
  enemyteam = utility::get_enemy_team(player.team);
  var_9a72c8ebf4462ced = 5;

  if(!isDefined(prevorigin)) {
    prevorigin = testorigin;
  }

  var_7fb9843e60cf87f9 = testorigin - prevorigin;
  distbetweenorigins = length(var_7fb9843e60cf87f9);
  var_602c41aceb2f51b5 = distbetweenorigins > var_9a72c8ebf4462ced;

  if(var_602c41aceb2f51b5) {
    queryresults = physics_spherecast(prevorigin, testorigin, testradius, physics_createcontents(["H\xe6\xe2\xa0\xf8\x8d\xd1\x84\xe4\xb8-\x99X\x884=\xd4\xe0$\xb8\xb9\xa5\xe9\xb7\f\xc9%\xca\xd8\xe4"]), [player], "\x03\xd8}k\x14\xbfh\xcb\xf3\xc4\xa3\x94@p\x84\xb0");

    if(getdvarint(@ "hash_c7e2712e62a91973", 0) > 0) {
      cylinder(prevorigin, testorigin, testradius, (1, 1, 0), 1, 200);
    }
  } else {
    queryresults = physics_querypoint(testorigin, testradius, physics_createcontents(["H\xe6\xe2\xa0\xf8\x8d\xd1\x84\xe4\xb8-\x99X\x884=\xd4\xe0$\xb8\xb9\xa5\xe9\xb7\f\xc9%\xca\xd8\xe4"]), [player], "\x03\xd8}k\x14\xbfh\xcb\xf3\xc4\xa3\x94@p\x84\xb0");

    if(getdvarint(@ "hash_c7e2712e62a91973", 0) > 0) {
      sphere(testorigin, testradius, (1, 1, 0), 1, 200);
    }
  }

  enemies = [];

  foreach(queryhit in queryresults) {
    enttarget = queryhit["\x1f\xa8\x10WP\xa9"];
    hitposition = queryhit["\xc1\xbd\xdci\xe8i{7"];

    if(!(isDefined(enttarget) && isDefined(hitposition))) {
      continue;
    }

    if(!isai(enttarget) || !isalive(enttarget)) {
      continue;
    }

    if(!isDefined(enttarget.team) || enttarget.team != enemyteam) {
      continue;
    }

    targettraceend = hitposition;
    targettracestart = testorigin;

    if(var_602c41aceb2f51b5) {
      vectotarget = targettraceend - prevorigin;
      vectotargetlength = length(vectotarget);

      if(vectotargetlength == 0) {
        targettracestart = prevorigin;
      } else {
        dirtotarget = vectorNormalize(vectotarget);
        dirtocurrentorigin = vectorNormalize(var_7fb9843e60cf87f9);
        projectionscalar = vectotargetlength * vectordot(dirtotarget, dirtocurrentorigin);
        targettracestart = prevorigin + projectionscalar * dirtocurrentorigin;
      }
    }

    trace = trace::ray_trace(targettracestart, targettraceend, [bombprojectile, enttarget], level.var_b960ffbfe7572d3e);

    if(trace["\xda\x16\x81\aw}^i"] < 1) {
      if(getdvarint(@ "hash_c7e2712e62a91973", 0) > 0) {
        line(targettracestart, targettraceend, (1, 0, 0), 1, 1, 200);
        sphere(targettraceend, 3, (1, 1, 0), 1, 200);
      }

      continue;
    } else {
      if(getdvarint(@ "hash_c7e2712e62a91973", 0) > 0) {
        line(targettracestart, targettraceend, (0, 1, 0), 1, 1, 200);
        sphere(targettraceend, 3, (1, 1, 0), 1, 200);
      }
    }

    enemies[enemies.size] = enttarget;
  }

  return enemies;
}

function private detonatebomb(bombprojectile, targetsinrange, weapon) {
  player = self;
  startingorigin = bombprojectile.origin;
  bombprojectile cursor_hint::remove_cursor_hint();
  bombprojectile delete();
  playFX(level.g_effect["\x1fJ\v\x19\xb6\xc6\xb4\xdb\xd8W\x18\xe0\xb0*"], startingorigin);
  snd::play("jS\xf8M\xe0bEx|-\x03\x01\xcc\xba\x1fr\xec!y\xdc", startingorigin);
  shock_damage = 25;

  foreach(badguy in targetsinrange) {
    if(!badguy unshockable()) {
      shockdurationms = 7000 + randomintrange(0, 2000);
      shockdurationms = int(shockdurationms * (badguy.var_45c4efbf45a53bd ?? 1));
      shockdurationms = int(shockdurationms * (level.var_45c4efbf45a53bd ?? 1));
      shockendtimems = gettime() + shockdurationms;
      startdelay = 0;

      if(targetsinrange.size > 1) {
        startdelay = randomfloatrange(0, 0.25 * targetsinrange.size);
      }

      badguy thread shock_common::scheduleshock(startdelay, shockendtimems, 1);
      badguy thread ai_shocked(shockdurationms / 1000);
      badguy dodamage(shock_damage, startingorigin, player, undefined, "*\xe5\x06\xc5\xf7\x98c\xcd\xb7\x16\xbc\xf9F\aVG\xfa\xa9", weapon, undefined, undefined, 65536);
    }
  }
}

function private ai_shocked(shockduration) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.prevdontmeleeme = self.dontmeleeme;
  self.dontmeleeme = 1;
  wait shockduration;
  self.dontmeleeme = self.prevdontmeleeme;
}

function private function_46ed3abc4aef2765(shockradius) {
  bombprojectile = self;
  bombprojectile endon("\x1e\xfd\xd1\xa2\a");
  var_3f76273815a36358 = 10;
  msg = bombprojectile utility::waittill_notify_or_timeout_return("d\xd9b~\xf2\x9f\x15\x93T\xd1\x04\x1a\x18", var_3f76273815a36358);

  if(msg == "\xb5B\xd7\x904}\x11") {
    bombprojectile delete();
    return;
  }

  bombprojectile utility::ent_flag_set("\xed\xef\x93\xd0>");
  function_fee23b27af1b8a6(bombprojectile);

  if(shockradius > 60) {
    activefx = utility::getfx("\xa0\x9a\xba\a\xd7\x01{\xa6KF\xbe\x85Wp\xf8\x91N1\xe4X");
  } else {
    activefx = utility::getfx("\x19\xe8\x82\x1b87\xdc\x02\xcc\xc5\x98\xe3\xd5\xe7\xb9@\v|z");
  }

  playFXOnTag(activefx, bombprojectile, "I\x01^\x89\x9f\xca");
  level.player thread offhands::function_1ddd67f9826838b(bombprojectile, makeweapon("ZgUw\x1fT\xcf\x02JYOi\xc0\xf7\xfe\x8a\x03>Rr\xa8\x05"), &"hash_6318519d2b571427", "G\xd5\x83\xf7AL-\x06=}\n\x15\\\x89\x05\x01F\x9e\xf5\x1bs");
  bombprojectile thread namespace_bc7cdace2d7445a5::minedamagemonitorsharedfunc();
  bombprojectile thread function_9f459ab9c70bb81a(shockradius);
}

function private function_9f459ab9c70bb81a(shockradius) {
  bombprojectile = self;
  player = level.player;
  bombprojectile endon("\x1e\xfd\xd1\xa2\a");
  bombprojectile waittill("\xf4\xae\x96_d\xc2\x95\xc6\x0e\xc0Q\x80\x8f\xe0\xcfej", attacker);
  proximitydetonationcenter = bombprojectile getproximitydetonationcenter();
  targetsinrange = player getenemiesinradius(bombprojectile, shockradius, proximitydetonationcenter);
  player thread detonatebomb(bombprojectile, targetsinrange);
}

function private unshockable() {
  return istrue(self.magic_bullet_shield) || !istrue(self.takedamage) || utility::ent_flag("\xeb\x80_:\xaf\xa9\x90WS\x80A");
}

function private function_fee23b27af1b8a6(bombprojectile) {
  if(!isDefined(level.var_df35c3ccbf067866)) {
    level.var_df35c3ccbf067866 = [];
  }

  level.var_df35c3ccbf067866 = utility::array_removeundefined(level.var_df35c3ccbf067866);
  level.var_df35c3ccbf067866[level.var_df35c3ccbf067866.size] = bombprojectile;
  var_8c2521031e99b5b = 6;
  var_4f226bc3eaddc0c5 = level.var_df35c3ccbf067866.size - var_8c2521031e99b5b;
  activetraps = [];

  for(trapindex = 0; trapindex < level.var_df35c3ccbf067866.size; trapindex++) {
    if(trapindex < var_4f226bc3eaddc0c5) {
      level.var_df35c3ccbf067866[trapindex] delete();
      continue;
    }

    activetraps[activetraps.size] = level.var_df35c3ccbf067866[trapindex];
  }

  level.var_df35c3ccbf067866 = activetraps;
}