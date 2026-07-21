/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\melee.gsc
***********************************************/

ischargetoreadycomplete(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee) && isDefined(self.melee.breadycomplete);
}

playmeleeanim_chargetoready_distcheck(var_0) {
  self endon(var_0 + "_finished");
  var_1 = 4900;
  var_2 = scripts\asm\asm_bb::bb_getmeleetarget();

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distancesquared(self.origin, var_2.origin);

    if(var_3 <= var_1) {
      if(isDefined(self.melee))
        self.melee.breadycomplete = 1;

      break;
    }

    wait 0.05;
  }
}

donotetracks_vsplayer(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_1, var_3);

    if(!isarray(var_3))
      var_3 = [var_3];

    foreach(var_5 in var_3) {
      var_6 = handlenotetrack_vsplayer(var_0, var_1, var_5);

      if(istrue(var_6)) {
        return;
      }
      if(isDefined(var_2))
        self[[var_2]](var_5, var_1);
    }
  }
}

handlenotetrack_vsplayer(var_0, var_1, var_2) {
  switch (var_2) {
    case "end":
      return 1;
    case "stop":
      var_3 = scripts\asm\asm_bb::bb_getmeleetarget();

      if(!isDefined(var_3))
        return 1;

      if(!isalive(var_3))
        return 1;

      if(!isDefined(self.enemy) || self.enemy != var_3)
        return 1;

      var_4 = distancesquared(var_3.origin, self.origin);
      var_5 = 4096;

      if(isDefined(self.meleestopattackdistsq))
        var_5 = self.meleestopattackdistsq;

      if(var_4 > var_5)
        return 1;

      break;
    case "fire":
      var_3 = scripts\asm\asm_bb::bb_getmeleetarget();

      if(!isDefined(var_3))
        return 1;

      if(isalive(var_3)) {
        if(isPlayer(var_3)) {
          if(isDefined(self.meleeignorefinalzdiff))
            var_6 = distance2dsquared(var_3.origin, self.origin);
          else
            var_6 = distancesquared(var_3.origin, self.origin);

          var_7 = 4096;

          if(isDefined(self.meleebashmaxdistsq))
            var_7 = self.meleebashmaxdistsq;

          if(var_6 <= var_7) {
            var_8 = self.meleedamageoverride;
            var_9 = undefined;
            var_10 = undefined;
            var_11 = 20;
            var_12 = 0.45;
            var_13 = 0.35;
            var_14 = isDefined(var_3.offhandshield) && var_3.offhandshield.active;

            if(nullweapon(self.weapon))
              var_8 = self.unarmedmeleedamageoverride;

            if(var_14) {
              var_11 = 10;
              var_12 = 0.7;
              var_13 = 0.5;
              setsaveddvar("MSRSPQNQKP", 0.05);
            }

            var_15 = self melee(undefined, var_8, sqrt(var_7), var_9, var_10);

            if(isDefined(var_15)) {
              if(var_14 && (self.unittype == "soldier" || self.unittype == "juggernaut"))
                self playSound("ai_melee_vs_shield");

              var_3 player_impulse_from_origin(self.origin, var_11);
              earthquake(0.45, 0.35, var_3.origin, 1000);
              var_3 playRumbleOnEntity("damage_heavy");

              if(!var_14)
                var_3 viewkick(30, self.origin);
            } else {
              self.nextmeleechecktime = gettime() + randomintrange(3000, 5000);
              self.lastfailedmeleechargetarget = var_3;
            }

            if(var_14)
              setsaveddvar("MSRSPQNQKP", level.playermeleedamagemultiplier_dvar);
          } else {
            self.nextmeleechecktime = gettime() + randomintrange(3000, 5000);
            self.lastfailedmeleechargetarget = var_3;
          }
        } else
          self melee();
      }

      break;
    default:
      scripts\anim\notetracks.gsc::handlenotetrack(var_2, var_1);
  }
}

player_impulse_from_origin(var_0, var_1) {
  if(!self isonground())
    var_1 = var_1 * 0.1;

  var_2 = vectorNormalize(self.origin + (0, 0, 45) - var_0);
  var_3 = var_2 * var_1 * 10;
  self setvelocity(var_3);
}

melee_decide_winner() {
  var_0 = self.melee.target;

  if(isDefined(self.meleealwayswin)) {
    self.melee.winner = 1;
    var_0.melee.winner = 0;
    return;
  } else if(isDefined(var_0.meleealwayswin)) {
    self.melee.winner = 0;
    var_0.melee.winner = 1;
    return;
  }

  if(isDefined(self.magic_bullet_shield)) {
    self.melee.winner = 1;
    var_0.melee.winner = 0;
  } else if(isDefined(var_0.magic_bullet_shield)) {
    self.melee.winner = 0;
    var_0.melee.winner = 1;
  } else {
    self.melee.winner = scripts\engine\utility::cointoss();
    var_0.melee.winner = !self.melee.winner;
  }
}

melee_calcsyncdirection() {
  var_0 = self.melee.target;
  var_1 = self.origin - var_0.origin;
  var_2 = vectortoyaw(var_1);
  var_3 = angleclamp180(var_2 - var_0.angles[1]);

  if(-45 < var_3 && var_3 < 45)
    return "8";
  else if(var_3 > 135 || var_3 < -135)
    return "2";
  else if(var_3 > 45)
    return "4";

  return "6";
}

melee_shouldabortcharge(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee))
    return 1;

  if(isDefined(self.melee.babort))
    return 1;

  if(!isDefined(self.melee.target))
    return 1;

  if(!isalive(self.melee.target))
    return 1;

  if(istrue(self.melee.target.dontmelee))
    return 1;

  return 0;
}

melee_shouldabort(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.melee))
    return 1;

  if(isDefined(self.melee.babort)) {
    if(isDefined(self.melee.bwaituntilstop)) {
      if(self.melee.bwaituntilstop) {
        var_4 = scripts\asm\asm::asm_eventfired(var_0, "melee_stop");

        if(var_4)
          self.melee.bshouldstop = 1;

        return var_4;
      }
    } else if(isDefined(self.melee.stoptimes)) {
      var_5 = scripts\asm\asm::asm_eventfired(var_0, "melee_stop");

      if(!var_5) {
        self.melee.bwaituntilstop = 1;
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

melee_requestcharge(var_0, var_1, var_2) {
  self.melee.bcharge = 1;
  self.melee.meleeanim = var_0;
  self.melee.arrivaldistsq = var_1;
  self.melee.bcorner = var_2;
}

melee_chargerequested(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee.bcharge) && self.melee.bcharge;
}

melee_chargecomplete() {
  self.melee.bcharge = undefined;
}

melee_ischargecomplete(var_0, var_1, var_2, var_3) {
  if(self.melee.winner != var_3)
    return 0;

  return !melee_chargerequested();
}

candocovermelee_anim(var_0, var_1, var_2, var_3) {}

chooseanim_syncmelee(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.meleeanimalias);
}

evaluatesyncedmeleebyxanim(var_0, var_1) {
  var_2 = self.melee.target;
  var_3 = var_2.angles;
  var_4 = var_2.origin - self.origin;
  var_5 = vectortoyaw(var_4);
  var_6 = 30;
  var_7 = angleclamp180(var_5 - self.angles[1]);

  if(abs(var_7) > var_6)
    return 0;

  if(var_1) {
    var_3 = var_2.angles - (0, var_7 * 0.5, 0);
    var_8 = getstartorigin(var_2.origin, var_3, var_0);
  } else {
    var_3 = var_2.angles - (0, var_7, 0);
    var_8 = getstartorigin(var_2.origin, var_3, var_0);
  }

  var_9 = self.origin - var_8;
  var_10 = vectorNormalize(var_2.origin - var_8);
  var_11 = vectordot(var_10, var_9);

  if(var_11 > 12 || var_11 < -12)
    return 0;

  if(var_1) {
    self.melee.startangles = self.angles + (0, var_7 * 0.5, 0);
    self.melee.startpos = var_8;
    var_2.melee.startyaw = var_3[1];
  } else {
    self.melee.startpos = var_8;
    self.melee.startangles = getstartangles(var_2.origin, var_3, var_0);
    var_2.melee.startyaw = var_3[1];
  }

  var_2.melee.bvictimlinkstoattacker = 1;
  return 1;
}

evaluatesyncedmelee(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target;

  if(isPlayer(var_4))
    return 0;

  if(istrue(self.dontsyncmelee) || istrue(var_4.dontsyncmelee))
    return 0;

  if(weaponclass(self.weapon) == "pistol" || weaponclass(var_4.weapon) == "pistol")
    return 0;

  if(!isDefined(self.melee.winner) || !isDefined(var_4.melee.winner))
    melee_decide_winner();

  var_5 = var_3[0];

  if(self.melee.winner != var_5)
    return 0;

  var_6 = var_3[1];
  var_7 = melee_calcsyncdirection();
  var_8 = ["a"];

  if(var_7 == "8") {
    var_8 = ["a", "b", "c"];
    var_9 = 3;
    var_10 = randomint(var_9);
    var_11 = randomint(var_9);
    var_12 = var_8[var_10];
    var_8[var_10] = var_8[var_11];
    var_8[var_11] = var_12;
  }

  var_9 = var_8.size;

  for(var_13 = 0; var_13 < var_9; var_13++) {
    var_14 = var_7 + var_8[var_13];
    var_15 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_14);
    var_16 = scripts\asm\asm::asm_getxanim(var_2, var_15);

    if(evaluatesyncedmeleebyxanim(var_16, var_6)) {
      self.meleeanimalias = var_14;
      var_4.meleeanimalias = var_14;
      return 1;
    }
  }

  return 0;
}

candomeleeflip_angles(var_0, var_1, var_2, var_3) {}

candomeleeflip_anim(var_0, var_1, var_2, var_3) {}

candomeleewrestle_angles(var_0, var_1, var_2, var_3) {}

candomeleewrestle_anim(var_0, var_1, var_2, var_3) {}

candomeleebehind_angles(var_0, var_1, var_2, var_3) {}

candomeleebehind_anim(var_0, var_1, var_2, var_3) {}

candomeleeanim_internal(var_0) {
  var_1 = self.melee.target;
  var_2 = var_1.origin;
  var_3 = self.origin - var_2;
  var_4 = vectortoangles(var_3);
  var_5 = getstartorigin(var_2, var_4, var_0);
  self.melee.startpos = var_5;
  self.melee.startangles = getstartangles(var_2, var_4, var_0);
  var_1.melee.startyaw = var_4[1];
  return 1;
}

candomeleeanim(var_0) {}

melee_validatepoints(var_0, var_1, var_2) {}

waitforpartnerdelete(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 waittill("entitydeleted");
  self notify("melee_exit");
}

playmeleeanim_synced_waitforpartnerexit(var_0, var_1) {
  self endon(var_1 + "_finished");
  childthread waitforpartnerdelete(var_1, self.melee.partner);
  self waittill("melee_exit");
  self unlink();
  var_2 = scripts\asm\asm::asm_eventfired(var_0, "melee_interact");

  if(isDefined(self.melee.interacttimes) && !var_2)
    self.melee.survive = 1;
  else if(var_2 && !scripts\asm\asm::asm_eventfired(var_0, "melee_death")) {
    if(isDefined(self.melee.interactendtimes))
      self.melee.survive = !scripts\asm\asm::asm_eventfired(var_0, "drop");
    else
      self.melee.survive = 0;
  }

  if(!self.melee.winner) {
    if(istrue(self.melee.survive)) {
      self.melee.babort = 1;
      self.melee.bwaituntilstop = 0;
    } else if(scripts\asm\asm::asm_eventfired(var_0, "melee_no_recovery"))
      self.melee.ballowfinish = 1;
    else if(scripts\asm\asm::asm_eventfired(var_0, "melee_stop"))
      self kill();
    else if(isDefined(self.melee.stoptimes))
      self.melee.babort = 1;
    else
      self.melee.ballowfinish = 1;
  } else if(scripts\asm\asm::asm_eventfired(var_0, "fire"))
    self.melee.ballowfinish = 1;
  else if(!isDefined(self.melee.bnaturaldeath))
    self.melee.babort = 1;
}

melee_shouldlosersurvive(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee.survive);
}

melee_shouldstop(var_0, var_1, var_2, var_3) {
  return isDefined(self.melee.bshouldstop);
}

melee_waitfordroppedweapon(var_0) {
  self endon(var_0 + "_finished");
  self waittill("weapon_dropped", var_1);

  if(isDefined(var_1))
    self.melee.droppedweaponent = var_1;
}

melee_finalcleanup() {
  if(isDefined(self.melee) && !istrue(self.melee.bshouldstop))
    self.meleeanimalias = undefined;

  self.melee = undefined;
  self.meleestatename = undefined;
  self.syncedmeleetarget = undefined;
}

melee_handlenotetracks(var_0) {
  if(issubstr(var_0, "ps_")) {
    var_1 = getsubstr(var_0, 3);
    self playSound(var_1);
    return;
  }

  switch (var_0) {
    case "sync":
      if(!isDefined(self.melee.babort)) {
        if(isDefined(self.melee.target)) {
          if(isalive(self.melee.target))
            self linktoblendtotag(self.melee.target, "tag_sync", 1, 1);
        } else if(isDefined(self.melee.bvictimlinkstoattacker) && isDefined(self.melee.partner)) {
          if(isalive(self.melee.partner))
            self linktoblendtotag(self.melee.partner, "tag_sync", 1, 1);
        }
      }

      break;
    case "unsync":
      if(isDefined(self.melee.fnunlink))
        self[[self.melee.fnunlink]]();
      else
        self unlink();

      break;
    case "melee_interact":
      self.melee.surviveanimallowed = 1;
      break;
    case "melee_death":
      return var_0;
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

playmeleeanim_synced_survive(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  self.meleeanimalias = undefined;
  scripts\asm\asm::asm_donotetracks(var_0, var_1, ::melee_handlenotetracks);
}

playmeleeanim_synced_cleanup(var_0, var_1, var_2) {
  if(isDefined(self.melee) && isDefined(self.melee.partner))
    self.melee.partner notify("melee_exit");

  if(isalive(self) && isDefined(self.melee))
    melee_droppedweaponrestore();

  self unlink();

  if(self.unittype == "c6") {
    self.hackable = 1;
    self.ignoreme = 0;
  }

  melee_finalcleanup();
}

melee_droppedweaponrestore() {
  if(!nullweapon(self.weapon) && !nullweapon(self.lastweapon)) {
    return;
  }
  if(getqueuedspleveltransients(self.melee.weapon)) {
    return;
  }
  scripts\anim\shared.gsc::forceuseweapon(self.melee.weapon, self.melee.weaponslot);

  if(isDefined(self.melee.droppedweaponent)) {
    self.melee.droppedweaponent delete();
    self.melee.droppedweaponent = undefined;
  }
}

playmeleeanim_synced_victim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.melee.bstarted = 1;
  self animmode("zonly_physics");

  if(isDefined(self.melee.startyaw))
    self orientmode("face angle", self.melee.startyaw);
  else if(isDefined(self.melee.startangles))
    self orientmode("face angle", self.melee.startangles[1]);
  else
    self orientmode("face current");

  melee_synced_setup(var_1, 0);
  thread melee_waitfordroppedweapon(var_1);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  var_5 = getnotetracktimes(var_4, "melee_stop");

  if(var_5.size > 0)
    self.melee.stoptimes = var_5;

  var_6 = getnotetracktimes(var_4, "melee_interact");

  if(var_6.size > 0)
    self.melee.interacttimes = var_6;

  var_7 = getnotetracktimes(var_4, "drop");

  if(var_7.size > 0)
    self.melee.interactendtimes = var_7;

  thread playmeleeanim_synced_waitforpartnerexit(var_0, var_1);
  var_8 = scripts\asm\asm::asm_donotetracks(var_0, var_1, ::melee_handlenotetracks);

  if((var_8 == "melee_death" || !self.melee.winner) && !isDefined(self.melee.survive)) {
    self.a.nodeath = 0;

    if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee))
      self.melee.partner.melee.bnaturaldeath = 1;

    self kill();
  }
}

melee_synced_setup(var_0, var_1) {
  self.meleestatename = var_0;
  self.melee.inprogress = 1;
  self.melee.weapon = self.weapon;
  self.melee.weaponslot = scripts\anim\utility.gsc::getcurrentweaponslotname();
  self.melee.fnunlink = ::melee_unlink;

  if(var_1) {
    scripts\aitypes\melee::melee_setmeleetimer(self.unittype);
    self.syncedmeleetarget = self.melee.target;
  } else
    self.syncedmeleetarget = self.melee.partner;

  if(self.unittype == "c6") {
    self.hackable = 0;
    self.ignoreme = 1;
  }
}

melee_unlink() {
  self unlink();

  if(isDefined(self.melee.partner)) {
    self.melee.partner animmode("zonly_physics");
    self.melee.partner orientmode("face angle", self.melee.partner.angles[1]);
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

playmeleeanim_chargetoready(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  thread playmeleeanim_chargetoready_distcheck(var_1);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

playmeleeanim_vsplayer(var_0, var_1, var_2) {
  playmeleeattacksound();
  var_3 = scripts\asm\asm_bb::bb_getmeleetarget();

  if(!isDefined(var_3))
    self orientmode("face current");
  else if(var_3 == self.enemy)
    self orientmode("face enemy");
  else
    self orientmode("face point", var_3.origin);

  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");

  if(isDefined(var_2))
    self playSound(var_2);

  self aisetanim(var_1, var_4);
  self endon(var_1 + "_finished");
  donotetracks_vsplayer(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  scripts\asm\asm::asm_fireevent(var_0, "end");
}

playmeleeattacksound() {
  if(!isDefined(self.a.nextmeleeattacksound))
    self.a.nextmeleeattacksound = 0;

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleeattacksound) {
      scripts\anim\face.gsc::saygenericdialogue("meleeattack");
      self.a.nextmeleeattacksound = gettime() + 8000;
    }
  }
}

playmeleechargesound() {
  if(!isDefined(self.a.nextmeleechargesound))
    self.a.nextmeleechargesound = 0;

  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleechargesound) {
      scripts\anim\face.gsc::saygenericdialogue("meleecharge");
      self.a.nextmeleechargesound = gettime() + 8000;
    }
  }
}

playmeleechargeanim(var_0, var_1, var_2) {
  playmeleechargesound();
  thread scripts\asm\shared\utility::waitfordooropen(var_0, var_1, 1);
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, self.moveplaybackrate);
}

playmeleeanim_synced(var_0, var_1, var_2) {
  self.melee.bstarted = 1;
  var_3 = self.melee.target;
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_5 = scripts\asm\asm::asm_getxanim(var_1, var_4);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  melee_synced_setup(var_1, 1);
  var_6 = getnotetracktimes(var_5, "melee_stop");

  if(var_6.size > 0)
    self.melee.stoptimes = var_6;

  var_7 = getnotetracktimes(var_5, "melee_interact");

  if(var_7.size > 0)
    self.melee.interacttimes = var_7;

  thread melee_waitfordroppedweapon(var_1);
  var_3 scripts\asm\asm::asm_setstate(var_1 + "_victim");
  self animmode("zonly_physics");
  self orientmode("face angle", self.melee.startangles[1]);
  self aisetanim(var_1, var_4);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_5);
  thread playmeleeanim_synced_waitforpartnerexit(var_0, var_1);
  self endon(var_1 + "_finished");
  var_8 = scripts\asm\asm::asm_donotetracks(var_0, var_1, ::melee_handlenotetracks);

  if((var_8 == "melee_death" || !self.melee.winner) && !istrue(self.melee.survive)) {
    self.a.nodeath = 0;

    if(isDefined(self.melee.target) && isDefined(self.melee.target.melee))
      self.melee.target.melee.bnaturaldeath = 1;

    self kill();
  }
}