/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\soldier\melee.gsc
***********************************************/

#using script_4449008f177af837;
#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\soldier\death;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace melee;

function ischargetoreadycomplete(asmname, statename, tostatename, params) {
  return self.in_melee && self.var_f2383297dd7b5e7e;
}

function playmeleeanim_chargetoready_distcheck(statename) {
  self endon(statename + "_finished");
  var_ea974c3c587825a6 = 4900;
  target = scripts\asm\asm_bb::bb_getmeleetarget();

  while(true) {
    if(!isDefined(target)) {
      break;
    }

    distsq = distancesquared(self.origin, target.origin);

    if(distsq <= var_ea974c3c587825a6) {
      if(self.in_melee) {
        self.var_f2383297dd7b5e7e = 1;
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
      target = scripts\asm\asm_bb::bb_getmeleetarget();

      if(isDefined(target)) {
        self function_f5fc845be4ca3be(target);
      }

      break;
    case #"hash_ed49946bfff8e78a":
      return 1;
    case #"hash_23d3b48a2fabf145":
      target = scripts\asm\asm_bb::bb_getmeleetarget();

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
      target = scripts\asm\asm_bb::bb_getmeleetarget();
      function_e157c0ce32f71cbe(target, 1, undefined, 0);
      break;
    default:
      scripts\anim\notetracks::handlenotetrack(note, statename);
      break;
  }
}

function function_e157c0ce32f71cbe(target, var_a7fa0e3c9034f2f4, meleedirection, ismeleeswipe) {
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
          setsaveddvar(@ "player_meleeDamageMultiplier", 0.05);
        }

        if(isDefined(self.meleepoweroverride)) {
          meleepower = self.meleepoweroverride;
        }

        overrideenemy = undefined;
        dist = sqrt(maxdistsq);

        if(istrue(ismeleeswipe)) {
          overrideenemy = target;
          dist = self.var_e6b3eb176dda8abc;
        }

        hitent = self melee(meleedirection, damageoverride, dist, width, height, istrue(ismeleeswipe), overrideenemy);

        if(isDefined(hitent)) {
          if(shieldactive && (self.unittype == "soldier" || self.unittype == "juggernaut")) {
            self playSound("ai_melee_vs_shield");
          }

          if(!istrue(self.var_70dd5ab41a229510)) {
            target player_impulse_from_origin(self.origin, meleepower);
          }

          target earthquakeforplayer(0.45, 0.35, target.origin, 1000);
          target playRumbleOnEntity("damage_heavy");

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

            if(isonscreen && isDefined(self.var_689bf433cb5c5322)) {
              kickpower = 30;
              target shellshock(self.var_689bf433cb5c5322, 1.25);
            }

            target thread meleeblur(blurpower, blurduration);
            target viewkick(kickpower, self.origin);
          }
        } else if(istrue(var_a7fa0e3c9034f2f4)) {
          self.nextmeleechecktime = gettime() + randomintrange(1500, 2500);
          self.lastfailedmeleechargetarget = target;
        }

        if(shieldactive) {
          setsaveddvar(@ "player_meleeDamageMultiplier", level.playermeleedamagemultiplier_dvar);
        }
      } else if(istrue(var_a7fa0e3c9034f2f4)) {
        self.nextmeleechecktime = gettime() + randomintrange(1500, 2500);
        self.lastfailedmeleechargetarget = target;
      }

      return;
    }

    self melee();
  }
}

function meleeblur(blurpower, blurduration) {
  self endon("death_or_disconnect");
  self notify("stop_melee_blur");
  self endon("stop_melee_blur");
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

  if(self.var_4ecd594ae357f55b) {
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

  if(self.var_4ecd594ae357f55b) {
    if(isDefined(self.var_9ea242cb88e6301e)) {
      if(self.var_9ea242cb88e6301e) {
        bstop = asm_eventfired(asmname, "melee_stop");

        if(bstop) {
          self.var_4c96a3a056b956e4 = 1;
        }

        return bstop;
      }
    } else if(self.var_6a4a5c698277c54d) {
      beventfired = asm_eventfired(asmname, "melee_stop");

      if(!beventfired) {
        self.var_9ea242cb88e6301e = 1;
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
  self.var_290be0985580a7a0 = getstartangles(targetpos, targetangles, meleeanim)[1];
  target.var_290be0985580a7a0 = targetangles[1];
  return true;
}

function candomeleeanim(tostatename) {}

function melee_validatepoints(startpos, targetpos, nodeangles) {}

function melee_shouldlosersurvive(asmname, statename, tostatename, params) {
  return self.var_d8a098b0872bb2cb;
}

function melee_shouldstop(asmname, statename, tostatename, params) {
  return self.var_4c96a3a056b956e4;
}

function playmeleeanim_chargetoready(asmname, statename, params) {
  self endon(statename + "_finished");
  readyanim = asm_getanim(asmname, statename);
  readyxanim = asm_getxanim(statename, readyanim);
  self aisetanim(statename, readyanim);
  asm_playfacialanim(asmname, statename, readyxanim);
  thread playmeleeanim_chargetoready_distcheck(statename);
  asm_donotetracks(asmname, statename);
}

function playmeleeanim_vsplayer(asmname, statename, params) {
  playmeleeattacksound();
  target = scripts\asm\asm_bb::bb_getmeleetarget();

  if(!isDefined(target)) {
    self orientmode("face current");
  } else if(target == self.enemy) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", target.origin);
  }

  meleeanim = asm_getanim(asmname, statename);
  asm_fireephemeralevent("melee_attack", "begin");

  if(isDefined(params)) {
    self playSound(params);
  }

  rate = 1;

  if(isDefined(self.var_2536e610f6ea9c94)) {
    rate = self.var_2536e610f6ea9c94;
  } else if(isDefined(self.unittype) && self.unittype == "juggernaut") {
    rate = 1.5;
  }

  self aisetanim(statename, meleeanim, rate);
  self endon(statename + "_finished");
  donotetracks_vsplayer(asmname, statename, asm_getnotehandler(asmname, statename));
  asm_fireevent(asmname, "end");
}

function playmeleeattacksound() {
  if(!isDefined(self.a.nextmeleeattacksound)) {
    self.a.nextmeleeattacksound = 0;
  }

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleeattacksound) {
      scripts\anim\face::saygenericdialogue("meleeattack");
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
      scripts\anim\face::saygenericdialogue("meleecharge");
      self.a.nextmeleechargesound = gettime() + 8000;
    }
  }
}

function playmeleechargeanim(asmname, statename, params) {
  playmeleechargesound();
  self.var_5185accfc2476d43 = 1;
  self.var_1f91d3da0786a2 = 1;
  function_fb56c9527636713f(asmname, statename, self.moveplaybackrate);
}

function on_execution_begin(asmname, statename, params) {
  if(!utility::issharedfuncdefined("player", "getExecutionPartner")) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(istrue(self.bhasriotshieldattached)) {
    scripts\asm\soldier\death::detachriotshield(1);
  }

  distfromcenter = 40;
  halfheight = 40;
  self function_4cd0eaf5381f92db(0);
  otherguy = callsharedfunc("player", "getExecutionPartner");

  if(isDefined(otherguy)) {
    assertex(isPlayer(otherguy), "<dev string:x37>");
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

function function_6cde2d3ae248271d(note, flagname) {
  if(!isDefined(self.var_e6b3eb176dda8abc)) {
    self.var_e6b3eb176dda8abc = 64;
  }

  if(!isDefined(self.var_f88c7e674f2b356e)) {
    self.var_f88c7e674f2b356e = 45;
  }

  players = scripts\common\utility::function_98a826b6b6d0d118(self.origin, self.var_e6b3eb176dda8abc, undefined, 100);
  fwd = anglesToForward(self.angles);

  foreach(player in players) {
    toplayer = player.origin - self.origin;

    if(abs(vectordot2(toplayer, fwd)) > cos(self.var_f88c7e674f2b356e)) {
      function_e157c0ce32f71cbe(player, 0, undefined, 1);
    }
  }
}