/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\melee.gsc
***********************************************/

function ischargetoreadycomplete(var0, var1, var2, var3) {
  return isDefined(self.melee) && isDefined(self.melee.breadycomplete);
}

function playmeleeanim_chargetoready_distcheck(var0) {
  self endon(var0 + "_finished");
  var1 = 4900;
  var2 = scripts\asm\asm_bb::bb_getmeleetarget();

  for(;;) {
    if(!isDefined(var2)) {
      break;
    }

    var3 = distancesquared(self.origin, var2.origin);

    if(var3 <= var1) {
      if(isDefined(self.melee)) {
        self.melee.breadycomplete = 1;
      }

      break;
    }

    wait 0.05;
  }
}

function donotetracks_vsplayer(var0, var1, var2) {
  for(;;) {
    self waittill(var1, var3);

    if(!isarray(var3)) {
      var3 = [var3];
    }

    foreach(var5 in var3) {
      var6 = handlenotetrack_vsplayer(var0, var1, var5);

      if(istrue(var6)) {
        return;
      }

      if(isDefined(var2)) {
        self[[var2]](var5, var1);
      }
    }
  }
}

function handlenotetrack_vsplayer(var0, var1, var2) {
  switch (var2) {
    case "end":
      return 1;
    case "stop":
      var3 = scripts\asm\asm_bb::bb_getmeleetarget();

      if(!isDefined(var3)) {
        return 1;
      }

      if(!isalive(var3)) {
        return 1;
      }

      if(!isDefined(self.enemy) || self.enemy != var3) {
        return 1;
      }

      var4 = distancesquared(var3.origin, self.origin);
      var5 = 4096;

      if(isDefined(self.meleestopattackdistsq)) {
        var5 = self.meleestopattackdistsq;
      }

      if(var4 > var5) {
        return 1;
      }

      break;
    case "fire":
      var3 = scripts\asm\asm_bb::bb_getmeleetarget();

      if(!isDefined(var3)) {
        return 1;
      }

      if(isalive(var3)) {
        if(isPlayer(var3)) {
          if(isDefined(self.meleeignorefinalzdiff)) {
            var6 = distance2dsquared(var3.origin, self.origin);
          } else {
            var6 = distancesquared(var6.origin, self.origin);
          }

          var7 = 4096;

          if(isDefined(self.meleebashmaxdistsq)) {
            var7 = self.meleebashmaxdistsq;
          }

          if(var6 <= var7) {
            var8 = self.meleedamageoverride;
            var9 = undefined;
            var10 = undefined;
            var11 = 20;
            var12 = 0.45;
            var13 = 0.35;
            var14 = isDefined(var6.offhandshield) && var6.offhandshield.active;

            if(nullweapon(self.weapon)) {
              var8 = self.unarmedmeleedamageoverride;
            }

            if(var14) {
              var11 = 10;
              var12 = 0.7;
              var13 = 0.5;
              setsaveddvar("MSRSPQNQKP", 0.05);
            }

            var15 = self melee(undefined, var8, sqrt(var7), var9, var10);

            if(isDefined(var15)) {
              if(var14 && (self.unittype == "soldier" || self.unittype == "juggernaut")) {
                self playSound("ai_melee_vs_shield");
              }

              player_impulse_from_origin(var6, self.origin, var11);
              earthquake(0.45, 0.35, var6.origin, 1000);
              var6 playRumbleOnEntity("damage_heavy");

              if(!var14) {
                var6 viewkick(30, self.origin);
              }
            } else {
              self.nextmeleechecktime = gettime() + randomintrange(3000, 5000);
              self.lastfailedmeleechargetarget = var6;
            }

            if(var14) {
              setsaveddvar("MSRSPQNQKP", level.playermeleedamagemultiplier_dvar);
            }
          } else {
            self.nextmeleechecktime = gettime() + randomintrange(3000, 5000);
            self.lastfailedmeleechargetarget = var6;
          }
        } else {
          self melee();
        }
      }

      break;
    default:
      scripts\anim\notetracks::handlenotetrack(var3, var2);
      break;
  }
}

function player_impulse_from_origin(var0, var1) {
  if(!self isonground()) {
    var1 *= 0.1;
  }

  var2 = vectorNormalize(self.origin + (0, 0, 45) - var0);
  var3 = var2 * var1 * 10;
  self setvelocity(var3);
}

function melee_decide_winner() {
  var0 = self.melee.target;

  if(isDefined(self.meleealwayswin)) {
    self.melee.winner = 1;
    var0.melee.winner = 0;
    return;
  } else if(isDefined(var0.meleealwayswin)) {
    self.melee.winner = 0;
    var0.melee.winner = 1;
    return;
  }

  if(isDefined(self.magic_bullet_shield)) {
    self.melee.winner = 1;
    var0.melee.winner = 0;
    return;
  }

  if(isDefined(var0.magic_bullet_shield)) {
    self.melee.winner = 0;
    var0.melee.winner = 1;
    return;
  }

  self.melee.winner = scripts\engine\utility::cointoss();
  var0.melee.winner = !self.melee.winner;
}

function melee_calcsyncdirection() {
  var0 = self.melee.target;
  var1 = self.origin - var0.origin;
  var2 = vectortoyaw(var1);
  var3 = angleclamp180(var2 - var0.angles[1]);

  if(-45 < var3 && var3 < 45) {
    return "8";
  } else if(var3 > 135 || var3 < -135) {
    return "2";
  } else if(var3 > 45) {
    return "4";
  }

  return "6";
}

function melee_shouldabortcharge(var0, var1, var2, var3) {
  if(!isDefined(self.melee)) {
    return true;
  }

  if(isDefined(self.melee.babort)) {
    return true;
  }

  if(!isDefined(self.melee.target)) {
    return true;
  }

  if(!isalive(self.melee.target)) {
    return true;
  }

  if(istrue(self.melee.target.dontmelee)) {
    return true;
  }

  return false;
}

function melee_shouldabort(var0, var1, var2, var3) {
  if(!isDefined(self.melee)) {
    return 1;
  }

  if(isDefined(self.melee.babort)) {
    if(isDefined(self.melee.bwaituntilstop)) {
      if(self.melee.bwaituntilstop) {
        var4 = scripts\asm\asm::asm_eventfired(var0, "melee_stop");

        if(var4) {
          self.melee.bshouldstop = 1;
        }

        return var4;
      }
    } else if(isDefined(self.melee.stoptimes)) {
      var5 = scripts\asm\asm::asm_eventfired(var1, "melee_stop");

      if(!var5) {
        self.melee.bwaituntilstop = 1;
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

function melee_requestcharge(var0, var1, var2) {
  self.melee.bcharge = 1;
  self.melee.meleeanim = var0;
  self.melee.arrivaldistsq = var1;
  self.melee.bcorner = var2;
}

function melee_chargerequested(var0, var1, var2, var3) {
  return isDefined(self.melee.bcharge) && self.melee.bcharge;
}

function melee_chargecomplete() {
  self.melee.bcharge = undefined;
}

function melee_ischargecomplete(var0, var1, var2, var3) {
  if(self.melee.winner != var3) {
    return false;
  }

  return !melee_chargerequested();
}

function candocovermelee_anim(var0, var1, var2, var3) {}

function chooseanim_syncmelee(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, self.meleeanimalias);
}

function evaluatesyncedmeleebyxanim(var0, var1) {
  var2 = self.melee.target;
  var3 = var2.angles;
  var4 = var2.origin - self.origin;
  var5 = vectortoyaw(var4);
  var6 = 30;
  var7 = angleclamp180(var5 - self.angles[1]);

  if(abs(var7) > var6) {
    return false;
  }

  if(var1) {
    var3 = var2.angles - (0, var7 * 0.5, 0);
    var8 = getstartorigin(var2.origin, var3, var0);
  } else {
    var4 = var3.angles - (0, var8, 0);
    var8 = getstartorigin(var3.origin, var4, var1);
  }

  var9 = self.origin - var8;
  var10 = vectorNormalize(var3.origin - var8);
  var11 = vectordot(var10, var9);

  if(var11 > 12 || var11 < -12) {
    return false;
  }

  if(var2) {
    self.melee.startangles = self.angles + (0, var8 * 0.5, 0);
    self.melee.startpos = var8;
    var3.melee.startyaw = var4[1];
  } else {
    self.melee.startpos = var8;
    self.melee.startangles = getstartangles(var3.origin, var4, var1);
    var3.melee.startyaw = var4[1];
  }

  var3.melee.bvictimlinkstoattacker = 1;
  return true;
}

function evaluatesyncedmelee(var0, var1, var2, var3) {
  var4 = self.melee.target;

  if(isPlayer(var4)) {
    return false;
  }

  if(istrue(self.dontsyncmelee) || istrue(var4.dontsyncmelee)) {
    return false;
  }

  if(weaponclass(self.weapon) == "pistol" || weaponclass(var4.weapon) == "pistol") {
    return false;
  }

  if(!isDefined(self.melee.winner) || !isDefined(var4.melee.winner)) {
    melee_decide_winner();
  }

  var5 = var3[0];

  if(self.melee.winner != var5) {
    return false;
  }

  var6 = var3[1];
  var7 = melee_calcsyncdirection();
  var8 = ["a"];

  if(var7 == "8") {
    var8 = ["a", "b", "c"];
    var9 = 3;
    var10 = randomint(var9);
    var11 = randomint(var9);
    var12 = var8[var10];
    var8 = var8[var11];
    var8 = var12;
  }

  var9 = var8.size;

  for(var13 = 0; var13 < var9; var13++) {
    var14 = var7 + var8[var13];
    var15 = scripts\asm\asm::asm_lookupanimfromalias(var2, var14);
    var16 = scripts\asm\asm::asm_getxanim(var2, var15);

    if(evaluatesyncedmeleebyxanim(var16, var6)) {
      self.meleeanimalias = var14;
      var4.meleeanimalias = var14;
      return true;
    }
  }

  return false;
}

function candomeleeflip_angles(var0, var1, var2, var3) {}

function candomeleeflip_anim(var0, var1, var2, var3) {}

function candomeleewrestle_angles(var0, var1, var2, var3) {}

function candomeleewrestle_anim(var0, var1, var2, var3) {}

function candomeleebehind_angles(var0, var1, var2, var3) {}

function candomeleebehind_anim(var0, var1, var2, var3) {}

function candomeleeanim_internal(var0) {
  var1 = self.melee.target;
  var2 = var1.origin;
  var3 = self.origin - var2;
  var4 = vectortoangles(var3);
  var5 = getstartorigin(var2, var4, var0);
  self.melee.startpos = var5;
  self.melee.startangles = getstartangles(var2, var4, var0);
  var1.melee.startyaw = var4[1];
  return true;
}

function candomeleeanim(var0) {}

function melee_validatepoints(var0, var1, var2) {}

function waitforpartnerdelete(var0, var1) {
  if(!isDefined(var1)) {
    return;
  }

  var1 waittill("entitydeleted");
  self notify("melee_exit");
}

function playmeleeanim_synced_waitforpartnerexit(var0, var1) {
  self endon(var1 + "_finished");
  GscBinSkip4(0x35, var1, self.melee.partner);
}

function melee_shouldlosersurvive(var0, var1, var2, var3) {
  return isDefined(self.melee.survive);
}

function melee_shouldstop(var0, var1, var2, var3) {
  return isDefined(self.melee.bshouldstop);
}

function melee_waitfordroppedweapon(var0) {
  self endon(var0 + "_finished");
  self waittill("weapon_dropped", var1);

  if(isDefined(var1)) {
    self.melee.droppedweaponent = var1;
    return;
  }
}

function melee_finalcleanup() {
  if(isDefined(self.melee) && !istrue(self.melee.bshouldstop)) {
    self.meleeanimalias = undefined;
  }

  self.melee = undefined;
  self.meleestatename = undefined;
  self.syncedmeleetarget = undefined;
}

function melee_handlenotetracks(var0) {
  if(issubstr(var0, "ps_")) {
    var1 = getsubstr(var0, 3);
    self playSound(var1);
    return;
  }

  switch (var1) {
    case "sync":
      if(!isDefined(self.melee.babort)) {
        if(isDefined(self.melee.target)) {
          if(isalive(self.melee.target)) {
            self linktoblendtotag(self.melee.target, "tag_sync", 1, 1);
          }
        } else if(isDefined(self.melee.bvictimlinkstoattacker) && isDefined(self.melee.partner)) {
          if(isalive(self.melee.partner)) {
            self linktoblendtotag(self.melee.partner, "tag_sync", 1, 1);
          }
        }
      }

      break;
    case "unsync":
      if(isDefined(self.melee.fnunlink)) {
        self[[self.melee.fnunlink]]();
      } else {
        self unlink();
      }

      break;
    case "melee_interact":
      self.melee.surviveanimallowed = 1;
      break;
    case "melee_death":
      return var1;
    case "attach_knife":
      self attach("weapon_vm_me_soscar_knife", "TAG_INHAND", 1);
      self.melee.hasknife = 1;
      break;
    case "detach_knife":
      self detach("weapon_vm_me_soscar_knife", "TAG_INHAND", 1);
      self.melee.hasknife = undefined;
      break;
    case "stab":
      self playSound("melee_knife_hit_body");
      playFXOnTag(level._effect["melee_knife_ai"], self, "TAG_KNIFE_FX");
      break;
    case "melee_stop":
      break;
  }
}

function playmeleeanim_synced_survive(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  self.meleeanimalias = undefined;
  scripts\asm\asm::asm_donotetracks(var0, var1, &melee_handlenotetracks);
}

function playmeleeanim_synced_cleanup(var0, var1, var2) {
  if(isDefined(self.melee) && isDefined(self.melee.partner)) {
    self.melee.partner notify("melee_exit");
  }

  if(isalive(self) && isDefined(self.melee)) {
    melee_droppedweaponrestore();
  }

  self unlink();

  if(self.unittype == "c6") {
    self.hackable = 1;
    self.ignoreme = 0;
  }

  melee_finalcleanup();
}

function melee_droppedweaponrestore() {
  if(!nullweapon(self.weapon) && !nullweapon(self.lastweapon)) {
    return;
  }

  if(getqueuedspleveltransients(self.melee.weapon)) {
    return;
  }

  scripts\anim\shared::forceuseweapon(self.melee.weapon, self.melee.weaponslot);

  if(isDefined(self.melee.droppedweaponent)) {
    self.melee.droppedweaponent delete();
    self.melee.droppedweaponent = undefined;
    return;
  }
}

function playmeleeanim_synced_victim(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.melee.bstarted = 1;
  self animmode("zonly_physics");

  if(isDefined(self.melee.startyaw)) {
    self orientmode("face angle", self.melee.startyaw);
  } else if(isDefined(self.melee.startangles)) {
    self orientmode("face angle", self.melee.startangles[1]);
  } else {
    self orientmode("face current");
  }

  melee_synced_setup(var1, 0);
  thread melee_waitfordroppedweapon(var1);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  var5 = getnotetracktimes(var4, "melee_stop");

  if(var5.size > 0) {
    self.melee.stoptimes = var5;
  }

  var6 = getnotetracktimes(var4, "melee_interact");

  if(var6.size > 0) {
    self.melee.interacttimes = var6;
  }

  var7 = getnotetracktimes(var4, "drop");

  if(var7.size > 0) {
    self.melee.interactendtimes = var7;
  }

  thread playmeleeanim_synced_waitforpartnerexit(var0, var1);
  var8 = scripts\asm\asm::asm_donotetracks(var0, var1, &melee_handlenotetracks);

  if((var8 == "melee_death" || !self.melee.winner) && !isDefined(self.melee.survive)) {
    self.a.nodeath = 0;

    if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee)) {
      self.melee.partner.melee.bnaturaldeath = 1;
    }

    self kill();
    return;
  }
}

function melee_synced_setup(var0, var1) {
  self.meleestatename = var0;
  self.melee.inprogress = 1;
  self.melee.weapon = self.weapon;
  self.melee.weaponslot = scripts\anim\utility::getcurrentweaponslotname();
  self.melee.fnunlink = &melee_unlink;

  if(var1) {
    scripts\aitypes\melee::melee_setmeleetimer(self.unittype);
    self.syncedmeleetarget = self.melee.target;
  } else {
    self.syncedmeleetarget = self.melee.partner;
  }

  if(self.unittype == "c6") {
    self.hackable = 0;
    self.ignoreme = 1;
    return;
  }
}

function melee_unlink() {
  self unlink();

  if(isDefined(self.melee.partner)) {
    self.melee.partner animmode("zonly_physics");
    self.melee.partner orientmode("face angle", self.melee.partner.angles[1]);
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

function playmeleeanim_chargetoready(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  thread playmeleeanim_chargetoready_distcheck(var1);
  scripts\asm\asm::asm_donotetracks(var0, var1);
}

function playmeleeanim_vsplayer(var0, var1, var2) {
  playmeleeattacksound();
  var3 = scripts\asm\asm_bb::bb_getmeleetarget();

  if(!isDefined(var3)) {
    self orientmode("face current");
  } else if(var3 == self.enemy) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", var3.origin);
  }

  var4 = scripts\asm\asm::asm_getanim(var0, var1);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");

  if(isDefined(var2)) {
    self playSound(var2);
  }

  self aisetanim(var1, var4);
  self endon(var1 + "_finished");
  donotetracks_vsplayer(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  scripts\asm\asm::asm_fireevent(var0, "end");
}

function playmeleeattacksound() {
  if(!isDefined(self.a.nextmeleeattacksound)) {
    self.a.nextmeleeattacksound = 0;
  }

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleeattacksound) {
      scripts\anim\face::saygenericdialogue("meleeattack");
      self.a.nextmeleeattacksound = gettime() + 8000;
      return;
    }

    return;
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
      return;
    }

    return;
  }
}

function playmeleechargeanim(var0, var1, var2) {
  playmeleechargesound();
  thread scripts\asm\shared\utility::waitfordooropen(var0, var1, 1);
  scripts\asm\asm::asm_loopanimstate(var0, var1, self.moveplaybackrate);
}

function playmeleeanim_synced(var0, var1, var2) {
  self.melee.bstarted = 1;
  var3 = self.melee.target;
  var4 = scripts\asm\asm::asm_getanim(var0, var1);
  var5 = scripts\asm\asm::asm_getxanim(var1, var4);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  melee_synced_setup(var1, 1);
  var6 = getnotetracktimes(var5, "melee_stop");

  if(var6.size > 0) {
    self.melee.stoptimes = var6;
  }

  var7 = getnotetracktimes(var5, "melee_interact");

  if(var7.size > 0) {
    self.melee.interacttimes = var7;
  }

  thread melee_waitfordroppedweapon(var1);
  var3 scripts\asm\asm::asm_setstate(var1 + "_victim");
  self animmode("zonly_physics");
  self orientmode("face angle", self.melee.startangles[1]);
  self aisetanim(var1, var4);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var5);
  thread playmeleeanim_synced_waitforpartnerexit(var0, var1);
  self endon(var1 + "_finished");
  var8 = scripts\asm\asm::asm_donotetracks(var0, var1, &melee_handlenotetracks);

  if((var8 == "melee_death" || !self.melee.winner) && !istrue(self.melee.survive)) {
    self.a.nodeath = 0;

    if(isDefined(self.melee.target) && isDefined(self.melee.target.melee)) {
      self.melee.target.melee.bnaturaldeath = 1;
    }

    self kill();
    return;
  }
}