/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\asm_sp.gsc
**************************************/

#using scripts\anim\notetracks_sp;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\sp\utility;
#using scripts\asm\shared\utility;
#using scripts\asm\track;
#using scripts\engine\scriptable_door;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\door;
#using scripts\sp\door_ai;
#using scripts\sp\door_internal;
#using scripts\sp\utility;
#namespace asm_sp;

function asm_init(baseasmname, archetypename) {
  if(archetypename == "\x0f\xce\x99\x01\xfd\xb5h8\xc59\xac" || archetypename == "^\xa7\xb8\x9c4" || archetypename == "\xd3\xe0,\xe0x\x14\xad\xe3\xcf|Bw(?") {
    asm_bb::bb_setshort(1);
  }

  self.asmname = baseasmname;
  first_init = 0;

  if(!isDefined(self.asm)) {
    first_init = 1;
    self.asm = spawnStruct();
    self.asm.animoverrides = [];
    self.fnasm_init = &asm_init;
    self.fnasm_setupaim = &asm_setupaim_sp;
    self.fnasm_playfacialanim = &asm_playfacialanim_sp;
    self.fnasm_handlenotetrack = &notetracks_sp::handlenotetrack;
    self.fnasm_playadditiveanimloopstate = &asm_playadditiveanimloopstate_sp;
    self.fnasm_clearfingerposes = &asm_clearfingerposes;
    self.fnplaceweaponon = &shared::placeweaponon;
    self.fndooropen = &open_door;
    self.fndoorclose = &close_door;
    self.fndoorneedstoclose = &door_needs_to_close;
    self.fngetdoorcenter = &get_door_center;
    self.fndooralreadyopen = &is_door_already_open;
    self.var_fd7b4b86b4ce3b9c = &door_ai::function_edcd03574c63e911;
    self function_9a0cdedbc1da3449(&utility::tryopendoor);
  }

  assert(isDefined(archetypename) || isDefined(self.animsetname));

  if(isDefined(archetypename)) {
    if(first_init) {
      self function_56319d2d3877745a(archetypename);
    } else {
      self setanimset(archetypename);
    }
  }

  if(isDefined(anim.var_704ba8a6f0cea758) && isDefined(anim.var_704ba8a6f0cea758[baseasmname])) {
    if(!utility::function_4ef4e39bb2fe6c86(self.animsetname) && archetypename != "<dev string:x24>") {
      level.var_46441cab89b4da1b = 1;
      self[[anim.var_704ba8a6f0cea758[baseasmname]]]();
      utility::function_b54e27609c0d254(baseasmname, archetypename);

      if(getdvarint(@ "hash_eea71d1ace9f4212", 0) == 1) {
        assert(level.var_46441cab89b4da1b, "<dev string:x32>" + baseasmname + "<dev string:x5d>");
      }

      level.var_46441cab89b4da1b = undefined;
    }
  }

  if(getdvarint(@ "hash_826655be6deb410f", 0) == 1) {
    function_77012f7f6ce5e131(baseasmname, archetypename);
  }

  asm::function_9a95fb4c56166ea4(self.asmname);
}

function function_ed85ed7dad46d8b() {
  level.fnanimatedprop_setup = &animatedprop_setup;
  level.fnanimatedprop_startanim = &animatedprop_startanim;
  level.fnanimatedprop_setanim = &animatedprop_setanim;
}

function updatepainvars(damagedsubpart) {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    var_1cdb2e34c0414008 = 1500;

    if(!isDefined(self.a.lastpaintime)) {
      self.a.lastpaintime = 0;
    }

    if(!isDefined(self.damageshieldcounter) || gettime() - self.a.lastpaintime > var_1cdb2e34c0414008) {
      self.damageshieldcounter = randomintrange(2, 3);
    }

    if(isDefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512)) {
      self.damageshieldcounter = 0;
    }

    if(self.damageshieldcounter > 0) {
      self.damageshieldcounter--;
    }
  }

  if(isDefined(damagedsubpart)) {
    self.damagedsubpart = damagedsubpart;
    return;
  }

  self.damagedsubpart = undefined;
}

function shouldplaypainanim() {
  if(isDefined(self.fnshouldplaypainanim)) {
    return self[[self.fnshouldplaypainanim]]();
  }

  return shouldplaypainanimdefault();
}

function shouldplaypainanimdefault() {
  var_b355d6259f5318fd = 4096;

  if(self.a.disablepain) {
    return false;
  }

  if(isDefined(self.pathgoalpos) && self pathdisttogoal() < var_b355d6259f5318fd) {
    return false;
  }

  return true;
}

function paininternal() {
  if(true) {
    updatepainvars();

    if(!shouldplaypainanim()) {
      if(isDefined(self.script) && self.script == "\x80\xb5\xc7J") {
        self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
      }

      return;
    }

    bdidpain = 0;
    result = self asmevalpaintransition(self.asmname);

    if(isDefined(result) && result) {
      bdidpain = 1;
    }

    if(self.type == "\x9b\x11\"\xd6\xfb;") {
      return;
    }

    if(!bdidpain && self.script == "\x80\xb5\xc7J") {
      self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
    }
  }

  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self waittill("T\xe9 ,Z\x0e\xfb\xbf\xcb\xd3\xb6\xf2\x8e\xc0\x93");
}

function subparthandler() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("b\xf7PR\xf8L\xaf8\xf4\xdd\x97\x1f\xe8\xcb7\x1dUG\x02\xba");
  assertmsg("<dev string:x7c>");
}

function asm_animhasfacialoverride(a_anim) {
  if(!animisleaf(a_anim)) {
    return 0;
  }

  return animhasnotetrack(a_anim, "\n\x03\xe9x-\xf8\x82\xb6\x98\x10<^F\xca\x85");
}

function asm_playfacialanim_sp(asmname, statename, animname) {
  if(asmname != self.asmname) {
    return;
  }

  facialstate = self asmgetfacialstate();

  if(isDefined(facialstate)) {
    asm_playfacialaniminternal(animname, facialstate);
    return;
  }

  asm::asm_clearfacialanim();
  self.asm.facial_state = "";
}

function asm_playfacialaniminternal(a_anim, a_state) {
  if(getDvar(@ "hash_688ea70593f4db5e", "<dev string:xbf>") == "<dev string:xc4>") {
    asm::asm_clearfacialanim();
    return;
  }

  if(!utility::isfacialstateallowed("\xfa\x94\xf1")) {
    return;
  }

  if(isDefined(a_anim) && asm_animhasfacialoverride(a_anim)) {
    asm::asm_clearfacialanim();
    return;
  }

  headknob = asm::asm_lookupanimfromaliasifexists("?\xd3b\x8e/", "\x83\xe2\x11D");

  if(!isDefined(headknob)) {
    return;
  }

  if(!isDefined(self.asm.facial_state)) {
    self.asm.facial_state = "";
  }

  utility::setfacialstate("\xfa\x94\xf1");

  if(isai(self)) {
    self setfacialindex(a_state);
    return;
  }

  if(istrue(self.var_22bbe270fbb36c94)) {
    utility::function_ffcc9a389593ff8c(a_state);
    return;
  }

  utility::setfacialindexfornonai(a_state);
}

function asm_playfacialanimfromnotetrack(facial_state) {
  archetype = utility::function_bc2028f16daab4cc();

  if(!utility::isfacialstateallowed("\xfa\x94\xf1") && facial_state != "\x1e\xfd\xd1\xa2\a") {
    return;
  }

  if(isDefined(archetype) && archetype != "") {
    utility::setfacialstate("\xfa\x94\xf1");

    if(isai(self)) {
      self setfacialindex(facial_state);
      return;
    }

    if(isDefined(self.var_22bbe270fbb36c94)) {
      utility::function_ffcc9a389593ff8c(facial_state);
      return;
    }

    utility::setfacialindexfornonai(facial_state);
  }
}

function asm_playfacialanimsingleframedeath(guy) {
  if(isai(self)) {
    self setfacialindex("\x1e\xfd\xd1\xa2\a");
    return;
  }

  utility::setfacialindexfornonai("\x1e\xfd\xd1\xa2\a");
}

function asm_initfingerposes() {
  self endon("\x1e\xfd\xd1\xa2\a");
  var_56c87687cf9fda06 = 0;
  var_1a361698f8f353d5 = 0;
  animid = asm::asm_lookupanimfromalias("?\xd3b\x8e/", "\xb8\xe6\xb5s\xe8\xa3f\xcd\xf9\xfa");
  inner_root = asm::asm_getxanim("?\xd3b\x8e/", animid);
  var_b58f995549d72b76 = 0;
  var_ef538aed1cf57b78 = 0;

  while(true) {
    weights = self getanimikweights(inner_root);
    var_30e6b44f90337210 = weights[0] - var_56c87687cf9fda06;
    var_153c035b478d4a4c = (var_30e6b44f90337210 > 0.001) - (var_30e6b44f90337210 < -0.001);

    if(var_153c035b478d4a4c != var_b58f995549d72b76) {
      if(var_153c035b478d4a4c > 0) {
        var_56c87687cf9fda06 = weights[0];
        var_b58f995549d72b76 = var_153c035b478d4a4c;
        wait 0.1;
        asm_ikfingeranim("=\xff0b");
        continue;
      }

      if(var_153c035b478d4a4c < 0) {
        var_56c87687cf9fda06 = weights[0];
        var_b58f995549d72b76 = var_153c035b478d4a4c;
        asm_clearikfingeranim("=\xff0b");
        continue;
      }
    }

    var_56c87687cf9fda06 = weights[0];
    var_b58f995549d72b76 = var_153c035b478d4a4c;
    diff_ikr = weights[1] - var_1a361698f8f353d5;
    state_ikr = (diff_ikr > 0.001) - (diff_ikr < -0.001);

    if(state_ikr != var_ef538aed1cf57b78) {
      if(state_ikr > 0) {
        var_1a361698f8f353d5 = weights[1];
        var_ef538aed1cf57b78 = state_ikr;
        wait 0.1;
        asm_ikfingeranim("o0\xee\xc1\x8c");
        continue;
      }

      if(state_ikr < 0) {
        var_1a361698f8f353d5 = weights[1];
        var_ef538aed1cf57b78 = state_ikr;
        asm_clearikfingeranim("o0\xee\xc1\x8c");
        continue;
      }
    }

    var_1a361698f8f353d5 = weights[1];
    var_ef538aed1cf57b78 = state_ikr;
    wait 0.05;
  }
}

function asm_clearfingerposes() {
  asm_clearikfingeranim("=\xff0b");
  asm_clearikfingeranim("o0\xee\xc1\x8c");
}

function asm_ikfingeranim(side) {
  currentweapon = utility::getaicurrentweapon();
  assert(isDefined(currentweapon));

  if(isnullweapon(currentweapon)) {
    asm_clearikfingeranim(side);
  }

  asm_playikfingeranim(side);
}

function asm_playikfingeranim(side) {
  currentweapon = utility::getaicurrentweapon();

  if(isnullweapon(currentweapon)) {
    return;
  }

  fingerstate = "\xbc\xa33\xbe\x18\x92\xc7\xb4F\x05\xd3l\xce\x9b\xf8\r";
  var_39b570b67b6d5dd5 = "f\xfa\x8d\x9f\x10\xabV\xf9\x9b\xd5\x81c";
  fingeralias = getweaponbasename(currentweapon);

  if(side == "=\xff0b") {
    fingerstate = "\x14\xf0q\x0eD\x82~\xaa\x94\xffdc\xfa\xee\xb4%";
    var_39b570b67b6d5dd5 = "\xbb\xf7R\x13\xeb|\x1d*\x96/\x1a~";
    weaponattachments = getweaponattachments(currentweapon);

    if(isDefined(weaponattachments)) {
      foreach(atch in weaponattachments) {
        attachprefix = getsubstr(atch, 0, 7);

        if(attachprefix == "\x80\x11\xd9\x99d\x92\xa9") {
          fingeralias = "\xa5\xbb\x9c\xeb\xba\x89\xaf\xd6K\xd6V";
        }

        if(attachprefix == "C\xd6\x1f\xa2\xf8wU") {
          fingeralias = "\x99\xab\xb1$\x1d\xed\\\v+o\x85";
        }

        if(attachprefix == "\xb3U\xa2\\\x1fE\xeb") {
          fingeralias = " ZC\xc1*>lW\xda\xad%";
        }

        if(attachprefix == "\xbbil\xce;D\x14") {
          fingeralias = "U5\xf0\xed\xdc'V\xf0\xd9T\x81";
        }
      }
    }
  }

  if(!asm_hasstatesp(self.animsetname, fingerstate)) {
    println("<dev string:xc9>" + self.animsetname + "<dev string:xe7>" + fingerstate);
    return;
  }

  if(!isDefined(fingeralias) || !asm::asm_hasalias(fingerstate, fingeralias)) {
    if(!isDefined(fingeralias)) {
      fingeralias = "\xad\x1c\x1be\x1a\xe6\xe4\xc8\xca";
    }

    println("<dev string:x100>" + fingerstate + "<dev string:x136>" + fingeralias + "<dev string:x141>" + getcompleteweaponname(currentweapon));
    return;
  }

  fingeranim = asm::asm_getxanim(fingerstate, asm::asm_lookupanimfromalias(fingerstate, fingeralias));
  fingerknob = asm::asm_getxanim("?\xd3b\x8e/", asm::asm_lookupanimfromalias("?\xd3b\x8e/", var_39b570b67b6d5dd5));
  self setanim(fingerknob, 1, 0.3, 1);
  self setanim(fingeranim, 1, 0.3, 1);
}

function asm_clearikfingeranim(side) {
  var_39b570b67b6d5dd5 = "\xbb\xf7R\x13\xeb|\x1d*\x96/\x1a~";

  if(side == "o0\xee\xc1\x8c") {
    var_39b570b67b6d5dd5 = "f\xfa\x8d\x9f\x10\xabV\xf9\x9b\xd5\x81c";
  }

  if(!asm::asm_hasalias("?\xd3b\x8e/", var_39b570b67b6d5dd5)) {
    println("<dev string:xc9>" + self.animsetname + "<dev string:x14d>" + var_39b570b67b6d5dd5);
    return;
  }

  fingerknob = asm::asm_getxanim("?\xd3b\x8e/", asm::asm_lookupanimfromalias("?\xd3b\x8e/", var_39b570b67b6d5dd5));
  self clearanim(fingerknob, 0.3, 1);
}

function asm_playvisorraise(suffix) {
  if(isDefined(suffix)) {
    isinstant = 1;
  } else {
    isinstant = 0;
    suffix = "";
  }

  asm_trynvgmodelswap();
  asm_clearvisoranim();
  var_14fb6f0614ca0ed1 = asm::asm_getxanim("h\xb5\xf7v\x10", asm::asm_lookupanimfromalias("h\xb5\xf7v\x10", "T(\x1df8\xe2\x87i2\x12%\rq\xf4\x88" + suffix));

  if(self.visor_down == 0) {
    if(isinstant) {
      return;
    } else {
      self setanim(var_14fb6f0614ca0ed1, 1, 0, 1);
    }

    return;
  }

  var_4fd8eb4954b6955c = asm::asm_getxanim("h\xb5\xf7v\x10", asm::asm_lookupanimfromalias("h\xb5\xf7v\x10", "Q\xea!\xc2\x14\xe2\x1b\x1b\x19\x13\xf3\x1e\x1a\xaa\xf0\x85\x8c" + suffix));
  self setanim(var_4fd8eb4954b6955c, 1, 0, 1);

  if(!isinstant) {
    wait getanimlength(var_4fd8eb4954b6955c) - 0.1;
  }
}

function asm_trynvgmodelswap() {
  if(!isDefined(self.nvgmodel_on)) {
    return;
  }

  currmodel = self.headmodel;

  if(isDefined(self.hatmodel)) {
    currmodel = self.hatmodel;
  }

  if(self.visor_down == 0 && currmodel == self.nvgmodel_on) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = self.nvgmodel_off;
      self attach(self.hatmodel);
    } else {
      self detach(self.headmodel);
      self.headmodel = self.nvgmodel_off;
      self attach(self.headmodel);
    }

    return;
  }

  if(currmodel == self.nvgmodel_off) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
      self.hatmodel = self.nvgmodel_on;
      self attach(self.hatmodel);
      return;
    }

    self detach(self.headmodel);
    self.headmodel = self.nvgmodel_on;
    self attach(self.headmodel);
  }
}

function asm_clearvisoranim() {
  asm_trynvgmodelswap();
  visorknob = undefined;
  visorid = asm::asm_lookupanimfromaliasifexists("?\xd3b\x8e/", "h\xb5\xf7v\x10");

  if(isDefined(visorid)) {
    visorknob = asm::asm_getxanim("?\xd3b\x8e/", visorid);
  } else {
    visorid = asm::function_a93b827a13e312a3("?\xd3b\x8e/", "h\xb5\xf7v\x10");

    if(isDefined(visorid)) {
      visorknob = asm::function_c02c1628f728ba52("?\xd3b\x8e/", visorid);
    }
  }

  if(isDefined(visorknob)) {
    self clearanim(visorknob, 0);
  }
}

function asm_hasstatesp(archetype, statename) {
  if(archetypeassetloaded(archetype)) {
    return archetypehasstate(archetype, statename);
  }

  assertmsg("<dev string:x166>" + archetype);
  return 0;
}

function asm_playadditiveanimloopstate_sp(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  prevanim = asm::asm_getbodyknob();
  blimited = 0;
  blendtime = 0.2;

  while(true) {
    animname = asm::asm_getxanim(statename, asm::asm_getanim(asmname, statename));

    if(prevanim != animname) {
      if(blimited) {
        self setflaggedanimknoblimitedrestart(statename, animname, 1, blendtime, 1);
      } else {
        self setflaggedanimknobrestart(statename, animname, 1, blendtime, 1);
      }

      prevanim = animname;
    }

    thread asm_playadditiveanimloopstate_helper(statename, animname, blimited);
    asm::asm_playfacialanim(asmname, statename, animname);
    asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
    self notify(statename + "nOb\x86F\xed\x14\x9d\xa7`o\xdb\xe5*i");
  }
}

function asm_playadditiveanimloopstate_helper(statename, additiveanim, blimited) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self endon(statename + "nOb\x86F\xed\x14\x9d\xa7`o\xdb\xe5*i");

  while(isDefined(additiveanim)) {
    wait 0.2;

    if(blimited) {
      self setflaggedanimlimited(statename, additiveanim, 1, 0, 1);
      continue;
    }

    self setflaggedanim(statename, additiveanim, 1, 0, 1);
  }
}

function asm_setaimlimits(limits) {
  if(isDefined(limits["=\xff0b"])) {
    self.leftaimlimit = limits["=\xff0b"];
  } else if(utility::actor_is3d()) {
    self.leftaimlimit = 56;
  } else {
    self.leftaimlimit = 45;
  }

  if(isDefined(limits["o0\xee\xc1\x8c"])) {
    self.rightaimlimit = limits["o0\xee\xc1\x8c"];
  } else if(utility::actor_is3d()) {
    self.rightaimlimit = -56;
  } else {
    self.rightaimlimit = -45;
  }

  if(isDefined(limits["\xf3\xf2"])) {
    self.upaimlimit = limits["\xf3\xf2"];
  } else if(utility::actor_is3d()) {
    self.upaimlimit = -89;
  } else {
    self.upaimlimit = -89;
  }

  if(isDefined(limits["\x7f5\xe8e"])) {
    self.downaimlimit = limits["\x7f5\xe8e"];
    return;
  }

  if(utility::actor_is3d()) {
    self.downaimlimit = 65;
    return;
  }

  self.downaimlimit = 45;
}

function asm_getaimlimitset(asmname, statename) {
  if(!isDefined(level.aimlimitstatemappings[asmname])) {
    return "\x91\xca\xcc\v\xab\xd8:";
  }

  if(!isDefined(level.aimlimitstatemappings[asmname][statename])) {
    return "\x91\xca\xcc\v\xab\xd8:";
  }

  return level.aimlimitstatemappings[asmname][statename];
}

function asm_setstateaimlimits(asmname, statename) {
  if(isDefined(self.ignoreaimsets) && self.ignoreaimsets) {
    return;
  }

  aimlimitset = asm_getaimlimitset(asmname, statename);

  if(getdvarint(@ "hash_763dbbbe8c504d96", 0) == 1) {
    print3d(self.origin + (-32, 0, 56), aimlimitset, (0, 1, 0), 1, 1, 20);
  }

  if(!isDefined(level.combataimlimits[asmname])) {
    asm_setaimlimits([]);
    return;
  }

  isfrantic = asm::asm_isfrantic();

  if(isfrantic && isDefined(level.franticaimlimits[asmname][aimlimitset])) {
    asm_setaimlimits(level.franticaimlimits[asmname][aimlimitset]);
    return;
  } else if(isDefined(level.combataimlimits[asmname][aimlimitset])) {
    asm_setaimlimits(level.combataimlimits[asmname][aimlimitset]);
    return;
  }

  asm_setaimlimits([]);
}

function asm_setupaim_sp(asmname, statename, blendtime, use_5) {
  if(self asmcurrentstatehasaimset(asmname)) {
    return;
  }

  if(istrue(self.runngun)) {
    return;
  }

  weapclass = weaponclass(self.weapon);

  if(weapclass == "\r+x5") {
    return;
  }

  if(asm::asm_hasalias(statename, "\xba\xe8\xe5fB")) {
    return;
  }

  if(!asm::asm_hasalias(statename, weapclass + "\xd0\xde\b\xd8,\xca")) {
    weapclass = "\x93\xa536Y";
    assert(asm::asm_hasalias(statename, weapclass + "<dev string:x1a1>") || asm::asm_hasalias(statename, "<dev string:x1ab>"), "<dev string:x1b4>" + statename + "<dev string:x1be>");
  }

  asm_setstateaimlimits(asmname, statename);
  bfrantic = asm::asm_isfrantic();
  arcname = self.animsetname;
  aim_5 = undefined;

  if(!isDefined(use_5) || use_5) {
    var_ccb1ec6bcc5c4f41 = weapclass + "_\x16Z\xd6}\xa9";
    var_d621cd2a12cba7c7 = asm::asm_lookupanimfromaliasifexists(statename, var_ccb1ec6bcc5c4f41);

    if(isDefined(var_d621cd2a12cba7c7)) {
      aim_5 = asm::asm_getxanim(statename, var_d621cd2a12cba7c7);
    }
  }

  self setanimknoblimited(asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, weapclass + "\xd0\xde\b\xd8,\xca", bfrantic)), 1, blendtime);
  self setanimknoblimited(asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, weapclass + "\x9c\x8a\xf7\xd7\x9e\xfa", bfrantic)), 1, blendtime);
  self setanimknoblimited(asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, weapclass + "\x9a\xf6\nl\x90H", bfrantic)), 1, blendtime);
  self setanimknoblimited(asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, weapclass + "\x9e|\x02\xd8?\x8e", bfrantic)), 1, blendtime);

  if(isDefined(aim_5)) {
    self setanimlimited(aim_5, 1, blendtime);
  }

  aim_root = asm::asm_lookupanimfromaliasifexists(statename, "'PO\x82\x98\xbb\xbd\x11");

  if(isDefined(aim_root)) {
    self setanim(asm::asm_getxanim(statename, aim_root), 1, blendtime);
  } else {
    aim_root = asm::asm_lookupanimfromaliasifexists("?\xd3b\x8e/", "'PO\x82\x98\xbb\xbd\x11");

    if(isDefined(aim_root)) {
      self setanim(asm::asm_getxanim("?\xd3b\x8e/", aim_root), 1, blendtime);
    }
  }

  var_271afa61aad2449c = asm::asm_hasalias(statename, "b\xd9|ur\x9bE\r\xd1\x19");

  if(var_271afa61aad2449c) {
    self notify("\x8e\xa4P\x85\xb3cj\xa7\x83|\xd6\xe7\xb1\xeef\xb6\xf0\x8a]");
    self.asm.track.aim_2 = asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, "b\xd9|ur\x9bE\r\xd1\x19", bfrantic));
    self.asm.track.aim_4 = asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, "\x96|\xb11\xe3\x06}a\x15|", bfrantic));
    self.asm.track.aim_6 = asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, "Y;\xa8\f\xb5\xae\xa8\x85=l", bfrantic));
    self.asm.track.aim_8 = asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, "Y;\xa8\f\xb5\xae\xa8\x85=\x1c", bfrantic));

    if(isDefined(aim_5)) {
      self.asm.track.aim_5 = asm::asm_getxanim(statename, archetypegetrandomalias(arcname, statename, "\xf2\x9f\xa10\xcca\x8d\xa6\xd1\xee", bfrantic));
    }

    thread asm_cleanupaimknobsonterminate(statename);
  }

  track::trackloop_restoreaim();
}

function asm_cleanupaimknobswithdelay(statename, delaytime) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x8e\xa4P\x85\xb3cj\xa7\x83|\xd6\xe7\xb1\xeef\xb6\xf0\x8a]");
  utility::waittill_any_timeout(delaytime, statename + "\x1b\xe0K\x01;P\xfdf\x98");
  asm_cleanupaimknobs();
}

function asm_cleanupaimknobsonterminate(statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x8e\xa4P\x85\xb3cj\xa7\x83|\xd6\xe7\xb1\xeef\xb6\xf0\x8a]");
  self waittill(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  asm_cleanupaimknobs();
}

function asm_cleanupaimknobs() {
  if(!isDefined(self.asm.track)) {
    return;
  }

  self.asm.track.aim_2 = undefined;
  self.asm.track.aim_4 = undefined;
  self.asm.track.aim_6 = undefined;
  self.asm.track.aim_8 = undefined;
  self.asm.track.aim_5 = undefined;
}

function asm_animScripted(notifyname, startpos, startangles, anime, vignettemode, rootanim, blendtime) {
  asmname = self.asmname;
  self asmsetstate(asmname, "\x13\xf2\xf7\xd7\\p\xa8j\xed\xb7\xbe\x9b");
}

function asm_stopanimScripted() {
  self stopanimScripted();
}

function asm_animcustom(run_animscript, end_animscript) {
  self leaveinteraction();
  asm_bb::bb_setanimScripted();
  self.asm.animcustomender = end_animscript;
  self animcustom(run_animscript, &asm_animcustom_endanimscript);
  asmname = self.asmname;
  self asmsetstate(asmname, "\x13\xf2\xf7\xd7\\p\xa8j\xed\xb7\xbe\x9b");
}

function asm_animcustom_endanimscript() {
  asm_bb::bb_clearanimScripted();

  if(!isDefined(self.asm.animcustomender)) {
    return;
  }

  self[[self.asm.animcustomender]]();
  self.asm.animcustomender = undefined;
}

function asm_stopanimcustom() {
  self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
}

function open_door(door, t) {
  if(scriptable_door::isscriptabledoor(door)) {
    return scriptable_door::function_e7573bb908d5abee(door, t);
  }

  if(istrue(door.bashed)) {
    return;
  }

  door utility_sp::door_force_open_fully(self, t);
}

function door_needs_to_close(door) {
  if(scriptable_door::isscriptabledoor(door)) {
    return asm::function_93baa7c8f9cc2d82(door);
  }

  if(!istrue(door.ajar)) {
    return 0;
  }

  doornormal = anglestoleft(door.true_start_angles);
  doorangles = door door_sp::get_door_angles();

  if(angleclamp180(doorangles[1] - door.true_start_angles[1]) < 0) {
    doornormal = -1 * doornormal;
  }

  doorcenter = door door_internal::get_door_bottom_center();
  doortome = self.origin - doorcenter;
  doordir = anglesToForward(doorangles);
  return vectordot(doornormal, doordir) * vectordot(doornormal, doortome) > 0;
}

function close_door(door) {
  if(scriptable_door::isscriptabledoor(door)) {
    return scriptable_door::function_98d331f978f64cfc(door);
  }

  self endon("\xe2$\xb4W\x14\xdc\xb3HF\xd7o\a");
  door door_sp::door_close(self, 0.5, 0.1, 0.4);
}

function get_door_center(door) {
  if(scriptable_door::isscriptabledoor(door)) {
    return asm::function_57cfa3d83fb31469(door);
  }

  return door door_internal::get_door_bottom_center();
}

function is_door_already_open(door) {
  if(scriptable_door::isscriptabledoor(door)) {
    return scriptable_door::function_d1da7e6857609614(door);
  }

  if(istrue(door.open_completely)) {
    return 1;
  }

  if(door door_internal::door_is_open_at_least(60)) {
    return 1;
  }

  return 0;
}

function animatedprop_setup(propname, var, origin, angles) {
  self.animated_prop = utility_sp::spawn_anim_model(propname, origin, angles);
  chairanim = level.scr_anim[propname][var];
  self.animated_prop setanimrestart(chairanim, 1, 0, 0);
}

function animatedprop_startanim(propname, params) {
  assert(isDefined(self.animated_prop));
  assert(isDefined(params));
  propanim = level.scr_anim[propname][params];
  assert(self.animated_prop getanimweight(propanim) > 0, "<dev string:x1e9>");
  self.animated_prop setanimrate(propanim, 1);
}

function animatedprop_setanim(propname, params) {
  assert(isDefined(self.animated_prop));
  assert(isDefined(params));
  propanim = level.scr_anim[propname][params];
  self.animated_prop setanimknob(propanim, 1, 0.2, 1);
}

function function_4fefcd300ad83b26(asmname, statename, params) {
  asm_animcustom(&function_e6a1cd30ed18886, undefined);
}

function function_e6a1cd30ed18886() {
  self endon("<dev string:x222>");
  self endon("<dev string:x22b>");
  shootparams = spawnStruct();
  self.shootposoverride = level.player.origin;
  self bb_newshootparams(level.player.origin, undefined, 0);
  asm_bb::bb_claimshootparams(0);

  while(true) {
    myshootpos = level.player.origin;
    asm_bb::bb_updateshootparams_pos(myshootpos);
    wait 0.05;
  }
}

function function_77012f7f6ce5e131(asmname, archetypename) {
  allstates = asmdevgetallstates(asmname);

  foreach(statename in allstates) {
    var_22d58af5dca5c8c5 = 0;
    aliases = archetypegetaliases(archetypename, statename);

    if(isDefined(aliases)) {
      foreach(alias in aliases) {
        anims = animsetgetallanimindicesforalias(archetypename, statename, alias);

        foreach(animidx in anims) {
          xanim = asm::asm_getxanim(statename, animidx);

          if(!animhasnotetrack(xanim, "<dev string:x243>")) {
            continue;
          }

          if(!animhasnotetrack(xanim, "<dev string:x24d>")) {
            errormsg = "<dev string:x256>" + archetypename + "<dev string:x289>" + statename + "<dev string:x296>" + alias + "<dev string:x2a3>" + xanim + "<dev string:x2af>";
            assertmsg(errormsg);
            continue;
          }

          ontimes = getnotetracktimes(xanim, "<dev string:x24d>");
          offtimes = getnotetracktimes(xanim, "<dev string:x243>");
          lastontime = 0;
          lastofftime = -1;

          if(ontimes.size > 0) {
            lastontime = ontimes[ontimes.size - 1];
          }

          if(offtimes.size > 0) {
            lastofftime = offtimes[offtimes.size - 1];
          }

          if(lastofftime >= lastontime) {
            errormsg = "<dev string:x2b4>" + archetypename + "<dev string:x289>" + statename + "<dev string:x296>" + alias + "<dev string:x2a3>" + xanim + "<dev string:x2af>";
            assertmsg(errormsg);
          }
        }
      }
    }
  }
}

# /