/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_26014bceab6bef13.gsc
*****************************************************/

#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\game\sp\hints;
#namespace namespace_8cea2e561c6f4042;

function autoexec init() {
  val::group_register("l<\xb0fGuE&\xedf\r\x1d\x80", ["`\x16\xae\xa2\xe4t\x187\xe7", "\x05\xb1\x1c\x86\x11\xc7", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", "mV\x8d+e", "\xe9\x88\xd9\xfd[Lrr\x8f\xf3\x1a\xb9\xaes?B", "Qp\xf2\x02h\x0e\x87b\x8b0\x87\xe9*\xc0\xa0)"]);
  utility::registersharedfunc(#"weapons", #"watchforplacementfirestate", &watchforplacementfirestate);
}

function gettargetmarker(streakinfo, ignoreplayercommand, var_8a339e3661343061, var_146556f1365b6d7a, ignoreenemyai) {
  assert(isPlayer(self), "<dev string:x24>");

  if(!isalive(self)) {
    return;
  }

  val::group_set("l<\xb0fGuE&\xedf\r\x1d\x80", 0);
  self enableequipdeployvfx(1);
  weapon = makeweaponfromstring(streakinfo.weaponname);
  markerinfo = undefined;
  thread watchforinvalidweapon(weapon, streakinfo);
  thread watchforammouse(weapon, streakinfo);
  thread watchforempapply(weapon, streakinfo);
  thread function_eb531f7d0aae2bb3(streakinfo);
  thread watchforlaststand(streakinfo);
  thread function_4956a657bd71f408(streakinfo);
  thread function_c4fc0d25e0edf6b7(streakinfo);
  thread function_404b2bde1ce6d93c(streakinfo);

  if(!istrue(ignoreplayercommand)) {
    if(!isai(self)) {
      self notifyonplayercommand("'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC", "cc'\x93{\x1d.X\xdf");
      self notifyonplayercommand("'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC", "\xfa\xfd\xaf\x10\x1f\xce=\x14\xca");
      self notifyonplayercommand("'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC", "F\x8c\xae\xa5bx*'\xed#y\x9cn");

      if(!self isconsoleplayer()) {
        self notifyonplayercommand("'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC", "\xde\x84\xf5\xf3\x02!Oe\x82N()\xed");
        self notifyonplayercommand("'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC", ")\x10\x1c\xe9\xbe\xaa\xc7\xf5\xc6\x84\x01\xcf.");
        self notifyonplayercommand("'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC", "\xdc\xb9 \xd0\x8fC(C\xbah[\rm");
      }
    }
  }

  while(true) {
    markerinfo = waittill_succeed_fail_end("YqWi\x0e\xd7\x19\x95\x83c\xbd\x97}\xe6\xd5\xc6l\x95V\xc8+F", "\a\x10\xf4^\tI\x1a\xd7zWa\t\x88\xbfP\x7f\x15\xb0?", "'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC", "\x9aQ]e\xbf\xfa\xde\x19\x16\x1b\xd3I\x1e\xa4\xb3\xc26\xfc\x94", "_\xa6\xbd6\xd8\x88\x9a\xd1\x05\x0fK\xff\a\xb3+3G");

    if(markerinfo.string == "\x9aQ]e\xbf\xfa\xde\x19\x16\x1b\xd3I\x1e\xa4\xb3\xc26\xfc\x94") {
      break;
    }

    if(markerinfo.string == "'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC") {
      if(!istrue(ignoreplayercommand)) {
        break;
      } else {
        hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", &"killstreaks/cannot_switch", 3);
      }

      continue;
    }

    if(markerinfo.string == "\a\x10\xf4^\tI\x1a\xd7zWa\t\x88\xbfP\x7f\x15\xb0?") {
      hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", &"killstreaks/cannot_be_placed", 3);
      continue;
    }

    if(isDefined(markerinfo) && markerinfo.string == "YqWi\x0e\xd7\x19\x95\x83c\xbd\x97}\xe6\xd5\xc6l\x95V\xc8+F") {
      var_8e6eaee67fbc2fd4 = function_2065fe03d9fdb393(markerinfo, ignoreenemyai);

      if(isDefined(var_8e6eaee67fbc2fd4)) {
        hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", var_8e6eaee67fbc2fd4, 3);
        continue;
      } else if(!self isonground() || self isonladder()) {
        hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", &"killstreaks/cannot_be_placed_air", 3);
        continue;
      } else if(isDefined(level.var_32930936890bf783)) {
        canplant = self[[level.var_32930936890bf783]](markerinfo.location);

        if(!canplant) {
          hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", &"killstreaks/cannot_be_placed", 3);
          continue;
        }
      } else if(isDefined(var_8a339e3661343061) && self[[var_8a339e3661343061]](markerinfo)) {
        continue;
      }
    }

    break;
  }

  if(isDefined(markerinfo.location) && isDefined(markerinfo.angles)) {
    starttrace = markerinfo.location + (0, 0, 80);
    endtrace = markerinfo.location + (0, 0, -1000);
    contentsplacement = ["Y\xa2\x89;`\x02\xd59\xb8t\xe8q\x92)\x89\xb8\x7f\x8a\n\xd0\xd0t", "\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "\xa3?\a\nru\xf2\xe6\x96\xb7\xd0\xcc\x97]4\x12n\xd3\xd3)\xcb\xae.", "vr\xdd]2\xa6 2\v\x0e\xb3Cd\xf9\x8e\x90\x84\xd7r\xde^;CE\x82\xb3", "\x96)?\xdbyq7\xde\x80 \x99\xfc\x9e-\xfe\xa7\xcd\r\x13\xba"];
    contentsoverride = physics_createcontents(contentsplacement);
    platformtrace = trace::sphere_trace(starttrace, endtrace, 20, undefined, contentsoverride);
    moving_platform = platformtrace["\x1f\xa8\x10WP\xa9"];

    if(isDefined(moving_platform) && !isDefined(moving_platform.helperdronetype)) {
      markerinfo.moving_platform = moving_platform;
      var_316bca081bc941b4 = markerinfo.location - moving_platform.origin;
      var_598a614308795009 = vectordot(var_316bca081bc941b4, anglesToForward(moving_platform.angles));
      var_7c961cdb1e933bf2 = -1 * vectordot(var_316bca081bc941b4, anglestoright(moving_platform.angles));
      var_38fee00bd7a7633f = vectordot(var_316bca081bc941b4, anglestoup(moving_platform.angles));
      markerinfo.moving_platform_offset = (var_598a614308795009, var_7c961cdb1e933bf2, var_38fee00bd7a7633f);
      markerinfo.moving_platform_angles_offset = combineangles(invertangles(moving_platform.angles), markerinfo.angles);
    } else if(getdvarint(@ "hash_50998d037e0d13b9", 0)) {
      if(platformtrace[")\x9a\x94]\xee}s"] != "\x90\x17\x030\x83m\x0f}D\x02f\xd9" && isDefined(platformtrace["\xc1\xbd\xdci\xe8i{7"])) {
        anchorzoffset = (0, 0, 0);

        if(distancesquared(markerinfo.location, platformtrace["\xc1\xbd\xdci\xe8i{7"]) >= 100) {
          anchorzoffset = (0, 0, 10);
        }

        markerinfo.location = (markerinfo.location[0], markerinfo.location[1], platformtrace["\xc1\xbd\xdci\xe8i{7"][2]) - anchorzoffset;
      }
    }
  }

  if(isalive(self)) {
    streakinfo notify("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
    val::reset_all("\x80\x04\x1c\xd0j\x06\x83cA\x92@\xcevs");
  }

  self enableequipdeployvfx(0);
  thread utility::delaythread(var_146556f1365b6d7a ?? 0.05, &val::group_reset, "l<\xb0fGuE&\xedf\r\x1d\x80");
  return markerinfo;
}

function isplacementplayerobstructed(marker) {
  placementobstructed = 0;
  placementposition = marker.location;

  if(!trace::sphere_trace_passed(placementposition + (0, 0, 100), placementposition, 20, undefined, trace::create_character_contents())) {
    placementobstructed = 1;
  }

  return placementobstructed;
}

function function_2065fe03d9fdb393(marker, ignoreenemyai) {
  var_86ccdca4c80279e9 = undefined;
  placementposition = marker.location;
  trace = trace::sphere_trace(placementposition + (0, 0, 100), placementposition, 20, undefined, trace::create_character_contents());

  if(!isDefined(trace) || trace[")\x9a\x94]\xee}s"] == "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
    return undefined;
  }

  if(!isDefined(trace["\x1f\xa8\x10WP\xa9"].team)) {
    var_86ccdca4c80279e9 = &"hash_379777224dfe9365";
  } else if(trace["\x1f\xa8\x10WP\xa9"].team == "O\x15\x1b\xad\x9ff") {
    var_86ccdca4c80279e9 = &"hash_49e759856e9a8368";
  } else if(trace["\x1f\xa8\x10WP\xa9"].team == "?\xb1\xc0\x9a" || trace["\x1f\xa8\x10WP\xa9"].team == "\x8c\x1b\xab)\xd1") {
    if(ignoreenemyai && isactor(trace["\x1f\xa8\x10WP\xa9"]) && !trace["\x1f\xa8\x10WP\xa9"].var_910fd5734b4d6abb) {
      var_86ccdca4c80279e9 = undefined;
    } else {
      var_86ccdca4c80279e9 = &"hash_3ef62dd61cc48de6";
    }
  } else {
    var_86ccdca4c80279e9 = &"hash_379777224dfe9365";
  }

  return var_86ccdca4c80279e9;
}

function watchforinvalidweapon(weapon, streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    if(self getcurrentweapon() != weapon) {
      self notify("'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC");
      break;
    }

    waitframe();
  }
}

function watchforammouse(weapon, streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  totalclipammo = self getweaponammoclip(weapon);

  while(true) {
    self waittill("9\xfca\xad\f^Rj.\xe6\xc6$", objweapon);

    if(objweapon == weapon) {
      self setweaponammoclip(objweapon, totalclipammo);
    }
  }
}

function watchforempapply(weapon, streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self waittill("\x8c\xff\x13q\x86vS\xf0ik\xe2");
  self notify("'\xb8@\b{T[\xb2\xe6{\x94\x1f\xc8\x02dC");
}

function function_eb531f7d0aae2bb3(streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    if(self isswimming()) {
      hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", &"killstreaks/placement_canceled_water", 3);
      self notify("\x9aQ]e\xbf\xfa\xde\x19\x16\x1b\xd3I\x1e\xa4\xb3\xc26\xfc\x94");
      break;
    }

    waitframe();
  }
}

function watchforlaststand(streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self waittill("J\"(\x13\x1cZ\x1c=tgEU\xf4@y\xa5");
  hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", &"killstreaks/placement_canceled", 3);
  self notify("\x9aQ]e\xbf\xfa\xde\x19\x16\x1b\xd3I\x1e\xa4\xb3\xc26\xfc\x94");
}

function function_4956a657bd71f408(streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self waittill("@B#\xb9}\x1e\x1e\xfb^\x96\xe7Mf\xdb\xfeD\xa0\xdc\x06\x9f\xb9\xf4\xca\xc5n");
  self notify("\x9aQ]e\xbf\xfa\xde\x19\x16\x1b\xd3I\x1e\xa4\xb3\xc26\xfc\x94");
}

function function_c4fc0d25e0edf6b7(streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  while(true) {
    if(self isparachuting()) {
      hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", &"killstreaks/placement_canceled", 3);
      self notify("\x9aQ]e\xbf\xfa\xde\x19\x16\x1b\xd3I\x1e\xa4\xb3\xc26\xfc\x94");
      break;
    }

    waitframe();
  }
}

function function_404b2bde1ce6d93c(streakinfo) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self waittill("\xfbF/\xe1\xaaZ?\xce\xd2/Y\xd2!\xd7@}");
  hints::function_5a014227dcf6b296("l<\xb0fGuE&\xedf\r\x1d\x80", &"killstreaks/placement_canceled", 3);
  self notify("\x9aQ]e\xbf\xfa\xde\x19\x16\x1b\xd3I\x1e\xa4\xb3\xc26\xfc\x94");
}

function watchforplacementfirestate(streakinfo, endonnotify) {
  self endon(endonnotify);
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(self function_d96f778cf6464a85()) {
    val::set("\x80\x04\x1c\xd0j\x06\x83cA\x92@\xcevs", "\xcciN\xca", 1);
  } else {
    val::set("\x80\x04\x1c\xd0j\x06\x83cA\x92@\xcevs", "\xcciN\xca", 0);
  }

  thread watchforplacementfirestateend(streakinfo, endonnotify);

  while(true) {
    self waittill("]zH\b\xa9[1M;p\x94k\xbf\r\x97\xfb\v\x7fA6p\xba\xd5p\xc7\xca", placementstate_unused);
    childthread function_d091f84b39b9d395();
  }
}

function private function_d091f84b39b9d395() {
  self notify("\xb1\xe8t\xd4sJ\x8e\xfc\xd0i\xf3^V\x1a\x1cj");
  self endon("\xb1\xe8t\xd4sJ\x8e\xfc\xd0i\xf3^V\x1a\x1cj");
  framestocheck = 2;

  for(i = 0; i < framestocheck; i++) {
    if(self function_d96f778cf6464a85()) {
      val::set("\x80\x04\x1c\xd0j\x06\x83cA\x92@\xcevs", "\xcciN\xca", 1);
    } else {
      val::set("\x80\x04\x1c\xd0j\x06\x83cA\x92@\xcevs", "\xcciN\xca", 0);
    }

    waitframe();
  }
}

function watchforplacementfirestateend(streakinfo, endonnotify) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  streakinfo endon("~\xca\xe2G\xb6\xe7T\xf23\xeb9\xad\xcd\x15\xfa\xe2%T\x17\x8f\bxs\xe6\xde\xf6\xa7 \xa7\xa5|%\x1d6:[X\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self waittill(endonnotify);
  val::reset_all("\x80\x04\x1c\xd0j\x06\x83cA\x92@\xcevs");
}

function waittill_succeed_fail_end(confirmstring, failstring, endstring, cancelstring, classswitchstring) {
  ent = spawnStruct();

  if(isDefined(confirmstring)) {
    childthread waittill_return(confirmstring, ent);
  }

  if(isDefined(failstring)) {
    childthread waittill_return(failstring, ent);
  }

  if(isDefined(endstring)) {
    childthread waittill_return(endstring, ent);
  }

  if(isDefined(cancelstring)) {
    childthread waittill_return(cancelstring, ent);
  }

  if(isDefined(classswitchstring)) {
    childthread waittill_return(classswitchstring, ent);
  }

  childthread waittill_return("\x1e\xfd\xd1\xa2\a", ent);
  ent waittill("s>H\xe6\xfb\xe6Gn", vfxoffset, weaponname, location, angle, string);
  ent notify("&\xc7\xee");
  returninfo = spawnStruct();
  returninfo.weapon = weaponname;
  returninfo.location = location;
  returninfo.angles = angle;
  returninfo.string = string;
  returninfo.fxoffset = vfxoffset;
  return returninfo;
}

function waittill_return(confirmstring, ent) {
  if(confirmstring != "\x1e\xfd\xd1\xa2\a") {
    self endon("\x1e\xfd\xd1\xa2\a");
  }

  ent endon("&\xc7\xee");
  self waittill(confirmstring, vfxoffset, weapon, location, angle);
  ent notify("s>H\xe6\xfb\xe6Gn", vfxoffset, weapon, location, angle, confirmstring);
}