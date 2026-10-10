/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4449008f177af837.gsc
*************************************************/

#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\common\anim;
#using scripts\engine\utility;
#namespace namespace_15a6b98dc3353454;

function evaluatesyncedmeleebyxanim(meleexanim, var_63cac41d4942d388) {
  target = self.meleetarget;
  targetangles = target.angles;
  metotarget = target.origin - self.origin;
  var_51da48562495c03a = vectortoyaw(metotarget);
  var_5e7f52c1693e8f30 = 30;
  yawdelta = angleclamp180(var_51da48562495c03a - self.angles[1]);

  if(abs(yawdelta) > var_5e7f52c1693e8f30) {
    return false;
  }

  if(var_63cac41d4942d388) {
    targetangles = target.angles - (0, yawdelta * 0.5, 0);
    startpos = getstartorigin(target.origin, targetangles, meleexanim);
  } else {
    targetangles = target.angles - (0, yawdelta, 0);
    startpos = getstartorigin(target.origin, targetangles, meleexanim);
  }

  var_6786a467900943c4 = self.origin - startpos;
  var_e0e7d3c1e330d5d4 = vectorNormalize(target.origin - startpos);
  dot = vectordot(var_e0e7d3c1e330d5d4, var_6786a467900943c4);

  if(dot > 12 || dot < -12) {
    return false;
  }

  if(var_63cac41d4942d388) {
    self.var_290be0985580a7a0 = self.angles[1] + yawdelta * 0.5;
    target.var_290be0985580a7a0 = targetangles[1];
  } else {
    self.var_290be0985580a7a0 = getstartangles(target.origin, targetangles, meleexanim)[1];
    target.var_290be0985580a7a0 = targetangles[1];
  }

  target.var_3a185a212fdfebca = 1;
  return true;
}

function function_732d599999bac851(meleexanim, zombiemeleexanim) {
  soldieranimlength = getanimlength(meleexanim);
  zombieanimlength = getanimlength(zombiemeleexanim);
  var_eaa98b7065ecbf95 = getnotetracktimes(zombiemeleexanim, "sync");
  var_a535f2be6d0c1a53 = var_eaa98b7065ecbf95[0] * zombieanimlength / soldieranimlength;
  soldiermovedelta = getmovedelta(meleexanim);
  var_31e9b15b38d2a9ed = self localtoworldcoords(soldiermovedelta);
  var_5a674586a93c8a08 = scripts\common\anim::function_d2e8597ff01310ed(meleexanim, "tag_sync", 0, self.origin, self.angles);
  var_8fcc6747b3d1ffc3 = scripts\common\anim::function_d2e8597ff01310ed(meleexanim, "tag_sync", var_a535f2be6d0c1a53, self.origin, self.angles);
  zombiemovedelta = getmovedelta(zombiemeleexanim);
  endpos = coordtransform(soldiermovedelta, var_5a674586a93c8a08["origin"], var_5a674586a93c8a08["angles"]);
  target = self.meleetarget;
  dist = distance(target.origin, var_8fcc6747b3d1ffc3["origin"]);

  if(dist > 60) {
    return false;
  }

  if(!ispointonnavmesh(var_31e9b15b38d2a9ed) || !ispointonnavmesh(var_8fcc6747b3d1ffc3["origin"])) {
    return false;
  }

  navtraceresult = navtrace(var_5a674586a93c8a08["origin"], self.origin, target, 0);

  if(navtraceresult) {
    return false;
  }

  navtraceresult = navtrace(self.origin, var_31e9b15b38d2a9ed, self, 0);

  if(navtraceresult) {
    return false;
  }

  target.var_3a185a212fdfebca = 1;
  return true;
}

function evaluatesyncedmelee(asmname, statename, tostatename, params) {
  if(isDefined(level.var_134c418fea89d2ad)) {
    return [[level.var_134c418fea89d2ad]](self, asmname, statename, tostatename, params);
  }

  assert(self.in_melee);
  assert(isDefined(self.meleetarget));
  target = self.meleetarget;

  if(isPlayer(target)) {
    return 0;
  }

  if(istrue(self.dontsyncmelee) || istrue(target.dontsyncmelee)) {
    return 0;
  }

  if(!isDefined(target.weapon)) {
    return 0;
  }

  if(!target asmhasstate(target.asmname, tostatename + "_victim")) {
    return 0;
  }

  if(target.type != "zombie") {
    if(weaponclass(self.weapon) == "pistol" || weaponclass(target.weapon) == "pistol") {
      return 0;
    }
  }

  if(getdvarint(@ "hash_4fa81bfc988a90e6", 0) == 1) {
    if(target.type == "zombie") {
      target.meleealwayswin = 1;
    }
  }

  if(!isDefined(self.var_74666f91f95a6ef8) || !isDefined(target.var_74666f91f95a6ef8)) {
    melee_decide_winner();
  }

  bwinner = params[0];

  if(self.var_74666f91f95a6ef8 != bwinner) {
    return 0;
  }

  var_63cac41d4942d388 = params[1];
  syncdir = melee_calcsyncdirection();
  variations = ["a"];

  if(target.type == "zombie" || syncdir == "8") {
    variations = ["a", "b", "c"];
    numvars = 3;
    var_8a8ae42021841e0c = randomint(numvars);
    var_8a8ae720218424a5 = randomint(numvars);
    temp = variations[var_8a8ae42021841e0c];
    variations[var_8a8ae42021841e0c] = variations[var_8a8ae720218424a5];
    variations[var_8a8ae720218424a5] = temp;
  }

  numvars = variations.size;

  for(ivar = 0; ivar < numvars; ivar++) {
    aliasname = syncdir + variations[ivar];
    meleeanim = asm_lookupanimfromalias(tostatename, aliasname);
    meleexanim = asm_getxanim(tostatename, meleeanim);

    if(target.type == "zombie") {
      var_b6ec8037545199f8 = tostatename + "_victim";
      zombiemeleeanim = target asm_lookupanimfromalias(var_b6ec8037545199f8, aliasname);
      zombiemeleexanim = target asm_getxanim(var_b6ec8037545199f8, zombiemeleeanim);

      if(function_732d599999bac851(meleexanim, zombiemeleexanim)) {
        self.meleeanimalias = aliasname;
        target.meleeanimalias = aliasname;
        target.var_57ec55bda59c3915 = self;
        return 1;
      }

      continue;
    }

    if(evaluatesyncedmeleebyxanim(meleexanim, var_63cac41d4942d388)) {
      self.meleeanimalias = aliasname;
      target.meleeanimalias = aliasname;
      target.var_57ec55bda59c3915 = self;
      return 1;
    }
  }

  return 0;
}

function melee_setmeleetimer(unittype, factor) {
  if(!isDefined(anim)) {
    return;
  }

  if(!isDefined(anim.meleechargeintervals)) {
    return;
  }

  if(!isDefined(unittype)) {
    return;
  }

  if(!isDefined(factor)) {
    factor = 1;
  }

  if(isPlayer(self.meleetarget) && isDefined(anim.meleechargeplayerintervals[self.unittype])) {
    anim.meleechargeplayertimers[self.unittype] = gettime() + anim.meleechargeplayerintervals[self.unittype] * factor;
    return;
  }

  if(isDefined(anim.meleechargeintervals[self.unittype])) {
    anim.meleechargetimers[self.unittype] = gettime() + anim.meleechargeintervals[self.unittype] * factor;
  }
}

function melee_calcsyncdirection() {
  assert(self.in_melee);
  target = self.meleetarget;
  assert(isDefined(target));
  var_79b0b08b6461b1ff = self.origin - target.origin;
  var_f38131fb9a95561a = vectortoyaw(var_79b0b08b6461b1ff);
  anglediff = angleclamp180(var_f38131fb9a95561a - target.angles[1]);

  if(-45 < anglediff && anglediff < 45) {
    return "8";
  } else if(anglediff > 135 || anglediff < -135) {
    return "2";
  } else if(anglediff > 45) {
    return "4";
  }

  return "6";
}

function melee_waitfordroppedweapon(statename) {
  self endon(statename + "_finished");
  self waittill("weapon_dropped", droppedweapon);

  if(isDefined(droppedweapon)) {
    assert(self.in_melee);
    self.var_aca4dbbe78d6d478 = droppedweapon;
  }
}

function melee_synced_setup(statename, battacker) {
  self.meleestatename = statename;
  self.var_8da037cbe81e4f8f = 1;
  self.meleeweapon = self.weapon;
  self.meleeweaponslot = scripts\anim\utility::getcurrentweaponslotname();
  self.var_a54042b7b10263be = 1;

  if(battacker) {
    melee_setmeleetimer(self.unittype);
    self.syncedmeleetarget = self.meleetarget;
  } else {
    self.syncedmeleetarget = self.meleepartner;
  }

  if(self.unittype == "c6") {
    self.hackable = 0;
    self.ignoreme = 1;
  }
}

function melee_unlink() {
  self unlink();

  if(isDefined(self.meleepartner) && isalive(self.meleepartner)) {
    self.meleepartner animmode("zonly_physics");
    self.meleepartner orientmode("face angle", self.meleepartner.angles[1]);
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

function chooseanim_syncmelee(asmname, statename, params) {
  assert(isDefined(self.meleeanimalias));
  return asm_lookupanimfromalias(statename, self.meleeanimalias);
}

function melee_decide_winner() {
  assert(self.in_melee);
  assert(isDefined(self.meleetarget));
  target = self.meleetarget;
  assert(target.in_melee);

  if(self.meleealwayswin) {
    assert(!isDefined(target.magic_bullet_shield));
    self.var_74666f91f95a6ef8 = 1;
    target.var_74666f91f95a6ef8 = 0;
    return;
  } else if(target.meleealwayswin) {
    assert(!isDefined(self.magic_bullet_shield));
    self.var_74666f91f95a6ef8 = 0;
    target.var_74666f91f95a6ef8 = 1;
    return;
  }

  if(isDefined(self.magic_bullet_shield)) {
    assert(!isDefined(target.magic_bullet_shield));
    self.var_74666f91f95a6ef8 = 1;
    target.var_74666f91f95a6ef8 = 0;
    return;
  }

  if(isDefined(target.magic_bullet_shield)) {
    self.var_74666f91f95a6ef8 = 0;
    target.var_74666f91f95a6ef8 = 1;
    return;
  }

  self.var_74666f91f95a6ef8 = scripts\engine\utility::cointoss();
  target.var_74666f91f95a6ef8 = !self.var_74666f91f95a6ef8;
}

function function_41377dafffee3185(asmname, statename, params) {
  self kill(self.origin + anglesToForward(self.angles));
}

function playmeleeanim_synced(asmname, statename, params) {
  assert(self.in_melee);
  assert(isDefined(self.meleetarget));
  self.bmeleestarted = 1;
  target = self.meleetarget;
  meleeanim = asm_getanim(asmname, statename);
  meleexanim = asm_getxanim(statename, meleeanim);
  asm_fireephemeralevent("melee_attack", "begin");
  melee_synced_setup(statename, 1);
  stoptimes = getnotetracktimes(meleexanim, "melee_stop");

  if(stoptimes.size > 0) {
    self.var_6a4a5c698277c54d = 1;
  }

  interacttimes = getnotetracktimes(meleexanim, "melee_interact");

  if(interacttimes.size > 0) {
    self.var_541e0eb7644f137f = 1;
  }

  if(self.type != "zombie") {
    thread melee_waitfordroppedweapon(statename);
  }

  if(isDefined(target function_92435c7a6ae85c3c())) {
    target leaveinteraction();
  }

  target asm_setstate(statename + "_victim");

  if(target.type == "zombie") {
    self.var_c5959a333d8edf27 = 1;
  }

  self animmode("zonly_physics");

  if(isDefined(self.var_290be0985580a7a0)) {
    self orientmode("face angle", self.var_290be0985580a7a0);
  }

  self aisetanim(statename, meleeanim);
  asm_playfacialanim(asmname, statename, meleexanim);
  thread playmeleeanim_synced_waitforpartnerexit(asmname, statename);
  self endon(statename + "_finished");
  lastnotetrack = asm_donotetracks(asmname, statename, &melee_handlenotetracks);

  if((lastnotetrack == "melee_death" || !self.var_74666f91f95a6ef8) && !self.var_d8a098b0872bb2cb) {
    self.a.nodeath = 0;

    if(isDefined(self.meleetarget) && self.meleetarget.in_melee) {
      self.meleetarget.var_42c47bf5f8a7fdf6 = 1;
    }

    if(target.type == "zombie") {
      self kill(self.origin + anglesToForward(self.angles));
      return;
    }

    self kill();
  }
}

function playmeleeanim_synced_survive(asmname, statename, params) {
  assert(!self.in_melee);
  surviveanim = asm_getanim(asmname, statename);
  survivexanim = asm_getxanim(statename, surviveanim);
  self aisetanim(statename, surviveanim);
  asm_playfacialanim(asmname, statename, survivexanim);
  self.meleeanimalias = undefined;
  asm_donotetracks(asmname, statename, &melee_handlenotetracks);
}

function playmeleeanim_synced_cleanup(asmname, statename, params) {
  assert(self.in_melee);

  if(self.in_melee) {
    if(isDefined(self.var_57ec55bda59c3915)) {
      self.var_57ec55bda59c3915 notify("melee_exit");
      self.var_57ec55bda59c3915 = undefined;
    } else if(isDefined(self.meleepartner)) {
      self.meleepartner notify("melee_exit");
    }
  }

  self.var_c5959a333d8edf27 = 0;

  if(isalive(self) && self.in_melee && self.type != "zombie") {
    melee_droppedweaponrestore();
  }

  self unlink();

  if(self.unittype == "c6") {
    self.hackable = 1;
    self.ignoreme = 0;
  }

  self function_bdcb37a9431e654(0);
}

function playmeleeanim_synced_victim(asmname, statename, params) {
  self endon(statename + "_finished");
  assert(self.in_melee);
  self.bmeleestarted = 1;
  self animmode("nogravity");

  if(isDefined(self.var_290be0985580a7a0)) {
    self orientmode("face angle", self.var_290be0985580a7a0);
  } else {
    self orientmode("face current");
  }

  melee_synced_setup(statename, 0);

  if(self.type != "zombie") {
    thread melee_waitfordroppedweapon(statename);
  }

  victimanim = asm_getanim(asmname, statename);
  victimxanim = asm_getxanim(statename, victimanim);
  self aisetanim(statename, victimanim);
  asm_playfacialanim(asmname, statename, victimxanim);
  stoptimes = getnotetracktimes(victimxanim, "melee_stop");

  if(stoptimes.size > 0) {
    self.var_6a4a5c698277c54d = 1;
  }

  interacttimes = getnotetracktimes(victimxanim, "melee_interact");

  if(interacttimes.size > 0) {
    self.var_541e0eb7644f137f = 1;
  }

  interactendtimes = getnotetracktimes(victimxanim, "drop");

  if(interactendtimes.size > 0) {
    self.var_b3c40d9762123312 = 1;
  }

  thread playmeleeanim_synced_waitforpartnerexit(asmname, statename);
  lastnotetrack = asm_donotetracks(asmname, statename, &melee_handlenotetracks);

  if((lastnotetrack == "melee_death" || !self.var_74666f91f95a6ef8) && !self.var_d8a098b0872bb2cb) {
    self.a.nodeath = 0;

    if(isDefined(self.meleepartner) && self.meleepartner.in_melee) {
      self.meleepartner.var_42c47bf5f8a7fdf6 = 1;
    }

    self kill();
  }
}

function waitforpartnerdelete(statename, partner) {
  if(!isDefined(partner)) {
    return;
  }

  partner waittill("entitydeleted");
  self notify("melee_exit");
}

function playmeleeanim_synced_waitforpartnerexit(asmname, statename) {
  self endon(statename + "_finished");

  if(isDefined(self.var_57ec55bda59c3915)) {
    childthread waitforpartnerdelete(statename, self.var_57ec55bda59c3915);
  } else {
    childthread waitforpartnerdelete(statename, self.meleepartner);
  }

  self waittill("melee_exit");
  self unlink();
  var_f20f49840827acf1 = asm_eventfired(asmname, "melee_interact");

  if(self.var_541e0eb7644f137f && !var_f20f49840827acf1) {
    self.var_d8a098b0872bb2cb = 1;
  } else if(var_f20f49840827acf1 && !asm_eventfired(asmname, "melee_death")) {
    if(self.var_b3c40d9762123312) {
      self.var_d8a098b0872bb2cb = !asm_eventfired(asmname, "drop");
    } else {
      self.var_d8a098b0872bb2cb = 0;
    }
  }

  if(!self.var_74666f91f95a6ef8) {
    if(self.var_d8a098b0872bb2cb) {
      if(asm_eventfired(asmname, "death_ragdoll_delayed")) {
        function_41377dafffee3185();
      } else {
        self.var_4ecd594ae357f55b = 1;
        self.var_9ea242cb88e6301e = 0;
      }
    } else if(asm_eventfired(asmname, "melee_no_recovery")) {
      self.var_9aedaf1da799bd67 = 1;
    } else if(asm_eventfired(asmname, "melee_stop")) {
      self kill();
    } else if(self.var_6a4a5c698277c54d) {
      self.var_4ecd594ae357f55b = 1;
    } else {
      self.var_9aedaf1da799bd67 = 1;
    }

    return;
  }

  if(asm_eventfired(asmname, "fire")) {
    self.var_9aedaf1da799bd67 = 1;
    return;
  }

  if(!self.var_42c47bf5f8a7fdf6) {
    self.var_4ecd594ae357f55b = 1;
  }
}

function function_4f145058cbb5099e(final_alias, append_code) {
  append = "";

  switch (append_code) {
    case #"hash_a13dd2b8b51545eb":
      append = "_cloth";

      if(istrue(self.armored)) {
        append = "_gear";
      }

      break;
    case #"hash_4f7f2f56f62275dc":
      append = "_dirt";
      my_surface = self.lastgroundtype;

      if(isDefined(my_surface)) {
        switch (my_surface) {
          case #"hash_cacc49f5cefe9c2":
          case #"hash_fb5a4fd62140d3d":
          case #"hash_1b9205edae40e596":
          case #"hash_1d3c8b96a9c71b54":
          case #"hash_3931479c445fb9b9":
          case #"hash_4d63389017f81514":
          case #"hash_4f863c6e34468e29":
          case #"hash_51929a2eb8e4f743":
          case #"hash_519950fd846289c6":
          case #"hash_57b9e7028fd773ba":
          case #"hash_590687995d01030e":
          case #"hash_5dab8ddea3468324":
          case #"hash_67e845c97d1f9eda":
          case #"hash_7fe735e403d9fe08":
          case #"hash_84a41da455643bc9":
          case #"hash_886109ae17c9aa73":
          case #"hash_8c9d4c67dcde81f2":
          case #"hash_8dede5336d28890d":
          case #"hash_8f53c9965f23a6cd":
          case #"hash_91afe7576024a903":
          case #"hash_d70d4c17673f4162":
          case #"hash_df0e712b7aee0b97":
          case #"hash_f4d3c7f04f8ef31d":
          case #"hash_f5afef0d74babaca":
          case #"hash_f9100fc94321f813":
            append = "_wood";
            break;
        }
      }

      break;
  }

  final_alias += append;

  if(soundexists(final_alias)) {
    self playSound(final_alias);
  }
}

function melee_handlenotetracks(note) {
  prefix = getsubstr(note, 0, 3);
  used_prefix = 0;

  switch (prefix) {
    case #"hash_8966586c51e34031":
      used_prefix = 1;
      alias = getsubstr(note, 3);
      self playSound(alias);
      break;
    case #"hash_6d20b46c4370528e":
      used_prefix = 1;
      var_31fbb83644449c1c = getsubstr(note, 3);
      params = strtok(var_31fbb83644449c1c, ",");

      if(params.size >= 2) {
        function_4f145058cbb5099e(params[0], params[1]);
      }

      break;
  }

  if(used_prefix) {
    return;
  }

  switch (note) {
    case #"hash_49d2de8a43d395fa":
      if(!self.var_4ecd594ae357f55b) {
        if(isDefined(self.meleetarget)) {
          if(isalive(self.meleetarget)) {
            self linktoblendtotag(self.meleetarget, "tag_sync", 1, 1);
          }
        } else if(self.var_3a185a212fdfebca && isDefined(self.var_57ec55bda59c3915)) {
          if(isalive(self.var_57ec55bda59c3915)) {
            self linktoblendtotag(self.var_57ec55bda59c3915, "tag_sync", 1, 1);
          }
        }
      }

      break;
    case #"hash_a74d3b6faa5ac811":
      if(self.var_a54042b7b10263be) {
        melee_unlink();
      } else {
        self unlink();
      }

      break;
    case #"hash_9b60ee8bd4984ddf":
      scripts\anim\shared::dropallaiweapons();

      if(isDefined(level.var_14fad57c290ee19a) && isDefined(level.var_170ca38d1fed8147)) {
        self.alreadydroppedweapon = 1;
        weapon = self[[level.var_14fad57c290ee19a]]();
        [[level.var_170ca38d1fed8147]](weapon, self.origin);
      }

      break;
    case #"hash_b11f0ef79e138572":
      break;
    case #"hash_9a4dd9ac49e5d8ae":
      return note;
    case #"hash_fd45bbe21f535106":
      self attach("weapon_vm_me_soscar_knife", "TAG_INHAND", 1);
      break;
    case #"hash_78af604e22ccf1d4":
      self detach("weapon_vm_me_soscar_knife", "TAG_INHAND", 1);
      break;
    case #"hash_23b3ca8a2f927c01":
      self playSound("melee_knife_hit_body");
      playFXOnTag(level._effect["melee_knife_ai"], self, "TAG_KNIFE_FX");
      break;
    case #"hash_9ccf1d54a8f2ba84":
      break;
  }
}

function melee_droppedweaponrestore() {
  assert(isDefined(self));
  assert(self.in_melee);

  if(!isnullweapon(self.weapon) && !isnullweapon(self.lastweapon)) {
    return;
  }

  if(isundefinedweapon(self.meleeweapon)) {
    return;
  }

  scripts\anim\shared::forceuseweapon(self.meleeweapon, self.meleeweaponslot);

  if(isDefined(self.var_aca4dbbe78d6d478)) {
    self.var_aca4dbbe78d6d478 delete();
    self.var_aca4dbbe78d6d478 = undefined;
  }
}