/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\melee.gsc
*****************************************/

#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\soldier\death;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace melee;

function ischargetoreadycomplete(asmname, statename, tostatename, params) {
  return self.in_melee && self.var_7c81a42baf39aa23;
}

function playmeleeanim_chargetoready_distcheck(statename) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  var_7bfb6b578eb2be43 = 4900;
  target = asm_bb::bb_getmeleetarget();

  while(true) {
    if(!isDefined(target)) {
      break;
    }

    distsq = distancesquared(self.origin, target.origin);

    if(distsq <= var_7bfb6b578eb2be43) {
      if(self.in_melee) {
        self.var_7c81a42baf39aa23 = 1;
      }

      break;
    }

    wait 0.05;
  }
}

function donotetracks_vsplayer(asmname, statename, optionalhandler) {
  while(true) {
    self waittill(statename, notes);

    if(!isarray(notes)) {
      notes = [notes];
    }

    foreach(note in notes) {
      breturn = handlenotetrack_vsplayer(asmname, statename, note);

      if(istrue(breturn)) {
        return;
      }

      if(isDefined(optionalhandler)) {
        self[[optionalhandler]](note, statename);
      }
    }
  }
}

function handlenotetrack_vsplayer(asmname, statename, note) {
  switch (note) {
    case #"hash_da2c994ab2c9478c":
      target = asm_bb::bb_getmeleetarget();

      if(isDefined(target)) {
        self function_d01921ded1f8d9b(target);
      }

      break;
    case #"hash_ed49946bfff8e78a":
      return 1;
    case #"hash_23d3b48a2fabf145":
      target = asm_bb::bb_getmeleetarget();

      if(!isDefined(target)) {
        return 1;
      }

      if(!isalive(target)) {
        return 1;
      }

      if(!isDefined(self.enemy) || self.enemy != target) {
        return 1;
      }

      disttotargetsq = distancesquared(target.origin, self.origin);
      stopattackdistsq = 4096;

      if(isDefined(self.meleestopattackdistsq)) {
        stopattackdistsq = self.meleestopattackdistsq;
      }

      if(disttotargetsq > stopattackdistsq) {
        return 1;
      }

      break;
    case #"hash_ceb098150f024a39":
      target = asm_bb::bb_getmeleetarget();
      function_28ddc73e385a30d7(target, 1, undefined, 0);
      break;
    default:
      notetracks::handlenotetrack(note, statename);
      break;
  }
}

function function_28ddc73e385a30d7(target, var_98cdc32c4ad83fd, meleedirection, ismeleeswipe) {
  if(!isDefined(target)) {
    return 1;
  }

  if(isalive(target)) {
    if(isPlayer(target)) {
      if(self.meleeignorefinalzdiff) {
        distsq = distance2dsquared(target.origin, self.origin);
      } else {
        distsq = distancesquared(target.origin, self.origin);
      }

      maxdistsq = 4096;

      if(isDefined(self.meleebashmaxdistsq)) {
        maxdistsq = self.meleebashmaxdistsq;
      }

      if(istrue(ismeleeswipe) || distsq <= maxdistsq) {
        damageoverride = self.meleedamageoverride;
        width = undefined;
        height = undefined;
        meleepower = 30;
        earthquakepower = 0.45;
        earthquakeduration = 0.35;
        shieldactive = isDefined(target.offhandshield) && target.offhandshield.active;

        if(isnullweapon(self.weapon)) {
          damageoverride = self.unarmedmeleedamageoverride;
        }

        if(shieldactive) {
          meleepower = 10;
          earthquakepower = 0.7;
          earthquakeduration = 0.5;
          setsaveddvar(@ "player_meleedamagemultiplier", 0.05);
        }

        if(isDefined(self.meleepoweroverride)) {
          meleepower = self.meleepoweroverride;
        }

        overrideenemy = undefined;
        dist = sqrt(maxdistsq);

        if(istrue(ismeleeswipe)) {
          overrideenemy = target;
          dist = self.var_a8e78137b02d0971;
        }

        hitent = self melee(meleedirection, damageoverride, dist, width, height, istrue(ismeleeswipe), overrideenemy);

        if(isDefined(hitent)) {
          if(shieldactive && (self.unittype == "\xb9\xdb6d-\xb2\xc9" || self.unittype == "\xab\xbf\xbe\xe2\xcdvJ\x14/c")) {
            self playSound("\xa6\xd7\x0f\xf3\xc4\x19\x82Y\xd7)\x01\xef|4\x1bB\x8a\x8b");
          }

          if(target val::get("\xcd\x1a+l\x1bnh\xf6\x1bk")) {
            if(!istrue(self.var_bf1d0e43e156793d)) {
              target player_impulse_from_origin(self.origin, meleepower);
            }

            target earthquakeforplayer(0.45, 0.35, target.origin, 1000);
            target playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");

            if(!shieldactive) {
              isonscreen = 0;
              pointstocheck = [self.origin, self getapproxeyepos(), (self.origin + self getapproxeyepos()) / 2];

              foreach(point in pointstocheck) {
                if(isDefined(target worldpointtoscreenpos(point, 55))) {
                  isonscreen = 1;
                  break;
                }
              }

              kickpower = 127;
              blurpower = 0.5;
              blurduration = 0.25;

              if(isonscreen && isDefined(self.var_ecdd7d080efdc2ef)) {
                kickpower = 30;
                target shellshock(self.var_ecdd7d080efdc2ef, 1.25);
              }

              target thread meleeblur(blurpower, blurduration);
              target viewkick(kickpower, self.origin);
            }
          }
        } else if(istrue(var_98cdc32c4ad83fd)) {
          self.nextmeleechecktime = gettime() + randomintrange(1500, 2500);
          self.lastfailedmeleechargetarget = target;
        }

        if(shieldactive) {
          setsaveddvar(@ "player_meleedamagemultiplier", level.playermeleedamagemultiplier_dvar);
        }
      } else if(istrue(var_98cdc32c4ad83fd)) {
        self.nextmeleechecktime = gettime() + randomintrange(1500, 2500);
        self.lastfailedmeleechargetarget = target;
      }

      return;
    }

    self melee();
  }
}

function meleeblur(blurpower, blurduration) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self notify("_\xd5\v\x82z\r{w\xcbf\x10a\xd2\x06\x9f");
  self endon("_\xd5\v\x82z\r{w\xcbf\x10a\xd2\x06\x9f");
  self setblurforplayer(blurpower, blurduration);
  wait blurduration;
  self setblurforplayer(0, blurduration);
}

function player_impulse_from_origin(origin, magnitude) {
  if(!self isonground()) {
    magnitude *= 0.1;
  }

  dir = vectorNormalize(self.origin + (0, 0, 45) - origin);
  vel = dir * magnitude * 10;
  self setvelocity(vel);
}

function melee_shouldabortcharge(asmname, statename, tostatename, params) {
  if(!self.in_melee) {
    return true;
  }

  if(self.var_a10ebedcfbd0300a) {
    return true;
  }

  if(!isDefined(self.meleetarget)) {
    return true;
  }

  if(!isalive(self.meleetarget)) {
    return true;
  }

  if(istrue(self.meleetarget.dontmelee)) {
    return true;
  }

  return false;
}

function melee_shouldabort(asmname, statename, tostatename, params) {
  if(!self.in_melee) {
    return 1;
  }

  if(self.var_a10ebedcfbd0300a) {
    if(isDefined(self.var_eca6f629351cc18f)) {
      if(self.var_eca6f629351cc18f) {
        bstop = asm::asm_eventfired(asmname, "\xb6ec\x95\xac\xd77Go8");

        if(bstop) {
          self.var_419523012df2f3ad = 1;
        }

        return bstop;
      }
    } else if(self.var_876e10ea898f9830) {
      beventfired = asm::asm_eventfired(asmname, "\xb6ec\x95\xac\xd77Go8");

      if(!beventfired) {
        self.var_eca6f629351cc18f = 1;
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

function candocovermelee_anim(asmname, statename, tostatename, params) {}

function candomeleeflip_angles(asmname, statename, tostatename, params) {}

function candomeleeflip_anim(asmname, statename, tostatename, params) {}

function candomeleewrestle_angles(asmname, statename, tostatename, params) {}

function candomeleewrestle_anim(asmname, statename, tostatename, params) {}

function candomeleebehind_angles(asmname, statename, tostatename, params) {}

function candomeleebehind_anim(asmname, statename, tostatename, params) {}

function candomeleeanim_internal(meleeanim) {
  target = self.meleetarget;
  targetpos = target.origin;
  targettome = self.origin - targetpos;
  targetangles = vectortoangles(targettome);
  startpos = getstartorigin(targetpos, targetangles, meleeanim);
  self.var_ca7d2f6087c466f5 = getstartangles(targetpos, targetangles, meleeanim)[1];
  target.var_ca7d2f6087c466f5 = targetangles[1];
  return true;
}

function candomeleeanim(tostatename) {}

function melee_validatepoints(startpos, targetpos, nodeangles) {}

function melee_shouldlosersurvive(asmname, statename, tostatename, params) {
  return self.var_2debd41d8e7e5bfe;
}

function melee_shouldstop(asmname, statename, tostatename, params) {
  return self.var_419523012df2f3ad;
}

function playmeleeanim_chargetoready(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  readyanim = asm::asm_getanim(asmname, statename);
  readyxanim = asm::asm_getxanim(statename, readyanim);
  self aisetanim(statename, readyanim);
  asm::asm_playfacialanim(asmname, statename, readyxanim);
  thread playmeleeanim_chargetoready_distcheck(statename);
  asm::asm_donotetracks(asmname, statename);
}

function playmeleeanim_vsplayer(asmname, statename, params) {
  playmeleeattacksound();
  target = asm_bb::bb_getmeleetarget();

  if(!isDefined(target)) {
    self orientmode("\x99\xc2l\xb2\x806\xbaNN\x95\xb9\xa3");
  } else if(target == self.enemy) {
    self orientmode("A\x14N5f\xcd6t\x04\xe6");
  } else {
    self orientmode("\xfc\x9f\\\x9e\x16\xbc\xbe\xca\xed\x12", target.origin);
  }

  meleeanim = asm::asm_getanim(asmname, statename);
  asm::asm_fireephemeralevent("\xc3\xd8\x90\x94.;\xa3YY\xa3B2", "\x98\xcav-7");

  if(isDefined(params)) {
    self playSound(params);
  }

  rate = 1;

  if(isDefined(self.var_33cb88c61183d5f5)) {
    rate = self.var_33cb88c61183d5f5;
  } else if(isDefined(self.unittype) && self.unittype == "\xab\xbf\xbe\xe2\xcdvJ\x14/c") {
    rate = 1.5;
  }

  self aisetanim(statename, meleeanim, rate);
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  donotetracks_vsplayer(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  asm::asm_fireevent(asmname, "8\xdb\x90");
}

function playmeleeattacksound() {
  if(!isDefined(self.a.nextmeleeattacksound)) {
    self.a.nextmeleeattacksound = 0;
  }

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleeattacksound) {
      face::saygenericdialogue("\xab\xd3\x8ahT\x85;\x94H\xb3/");
      self.a.nextmeleeattacksound = gettime() + 8000;
    }
  }
}

function playmeleechargesound() {
  if(!isDefined(self.a.nextmeleechargesound)) {
    self.a.nextmeleechargesound = 0;
  }

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleechargesound) {
      face::saygenericdialogue("\x14\xb3\x86\x11\x7fcE'\x03\\\xad");
      self.a.nextmeleechargesound = gettime() + 8000;
    }
  }
}

function playmeleechargeanim(asmname, statename, params) {
  playmeleechargesound();
  self.var_998e131a705c01a2 = 1;
  self.var_526b6d7c80f6bbb3 = 1;
  asm::function_1be97a4513bb86d2(asmname, statename, self.moveplaybackrate);
}

function on_execution_begin(asmname, statename, params) {
  if(!utility::issharedfuncdefined(#"player", #"getexecutionpartner")) {
    assertmsg("<dev string:x24>");
    return;
  }

  if(istrue(self.bhasriotshieldattached)) {
    death::detachriotshield(1);
  }

  distfromcenter = 40;
  halfheight = 40;
  self function_76460814d82df4ee(0);
  otherguy = utility::callsharedfunc(#"player", #"getexecutionpartner");

  if(isDefined(otherguy)) {
    assert(isPlayer(otherguy), "<dev string:x3f>");
    pos = (self.origin + otherguy.origin) * 0.5;
    level thread execution_obstacle(pos, distfromcenter, halfheight);
  }
}

function execution_obstacle(pos, distfromcenter, halfheight) {
  zeroangles = (0, 0, 0);
  obstacleid = createnavbadplacebyshape(pos, zeroangles, 6, distfromcenter, halfheight);
  wait 3;
  destroynavobstacle(obstacleid);
}

function function_152fe99883f33558(note, flagname) {
  if(!isDefined(self.var_a8e78137b02d0971)) {
    self.var_a8e78137b02d0971 = 64;
  }

  if(!isDefined(self.var_e52486c1cb7deb83)) {
    self.var_e52486c1cb7deb83 = 45;
  }

  players = utility::function_a2db22f22e3ae349(self.origin, self.var_a8e78137b02d0971, undefined, 100);
  fwd = anglesToForward(self.angles);

  foreach(player in players) {
    toplayer = player.origin - self.origin;

    if(abs(vectordot2(toplayer, fwd)) > cos(self.var_e52486c1cb7deb83)) {
      function_28ddc73e385a30d7(player, 0, undefined, 1);
    }
  }
}