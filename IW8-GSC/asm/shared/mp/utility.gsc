/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\shared\mp\utility.gsc
***********************************************/

dotraversal() {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  var_0 = self getnegotiationstartnode();
  var_1 = var_0.animscript;
  self notify("_encstr_9AC60F8143AFEE3F8348A9AE5A27975B88", var_1, var_0);
  self waittill("_encstr_B6E10D83823F3883D6AF25A7E3A669");
}

chooseanimwithoverride(var_0, var_1, var_2) {
  return 0;
}

loopanimfortime(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  var_3 = "_encstr_AC260941F74D10201F62F1";
  var_4 = 2;

  if(isarray(var_2)) {
    if(var_2.size > 0)
      var_4 = var_2[0];

    if(var_2.size > 1)
      var_3 = var_2[1];
  } else
    var_4 = var_2;

  thread scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1);
  wait(var_4);
  scripts\asm\asm::asm_fireevent(var_0, var_3);
}

waitforcoverapproach_mp(var_0, var_1) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");

  if(self islegacyagent()) {
    self requeststopsoonnotify();
    self waittill("_encstr_8F0F0A9BE8DB83EBB9F6BD9B");
    self.approachdir = self.lookaheaddir;
    scripts\asm\asm::asm_fireevent(var_0, "_encstr_A78D0F6CBDCE2B9CF5580E07C9F6168D0D", self.approachdir);
  }
}

waitforpathchange(var_0, var_1) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self waittill("_encstr_B2F3098BDEFCC820A30F49");
  var_2 = self.origin + self.lookaheaddir * self.lookaheaddist;
  var_3 = [0, var_2, 1, self.origin, self.lookaheaddist];
  scripts\asm\asm::asm_fireevent(var_0, "_encstr_85E20B37342C4E83D71DD5E4B9", var_3);
  thread waitforpathchange(var_0, var_1);
}

waitforsharpturn_mp(var_0, var_1, var_2) {}

playmoveloop_mp(var_0, var_1, var_2) {
  thread waitforcoverapproach_mp(var_0, var_1);

  if(self islegacyagent())
    thread waitforsharpturn_mp(var_0, var_1);
  else
    thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);

  thread waitforpathchange(var_0, var_1);
  var_3 = 1.0;

  if(isDefined(self.asm.moveplaybackrate))
    var_3 = self.asm.moveplaybackrate;
  else if(isDefined(self.moveplaybackrate))
    var_3 = self.moveplaybackrate;

  scripts\asm\asm::asm_loopanimstate(var_0, var_1, var_3);
}

isfacingenemy(var_0) {
  if(!isDefined(var_0))
    var_0 = 0.5;

  var_1 = anglesToForward(self.angles);
  var_2 = vectorNormalize(self.enemy.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 < var_0)
    return 0;

  return 1;
}

isweaponfacingenemy() {
  if(isaimedataimtarget())
    return 1;

  return 0;
}

wantstocrouch() {
  if(scripts\asm\asm_bb::bb_getrequestedstance() == "_encstr_B13D076BED70539F23")
    return 1;

  return 0;
}

getshootpos(var_0) {
  if(!istrue(self._blackboard.shootparams_valid))
    return undefined;
  else if(isDefined(self._blackboard.shootparams_ent))
    return self._blackboard.shootparams_ent getshootatpos();
  else if(isDefined(self._blackboard.shootparams_pos))
    return self._blackboard.shootparams_pos;
  else if(isDefined(self.enemy))
    return self.enemy getshootatpos();

  return undefined;
}

isaimedataimtarget() {
  if(!isDefined(self._blackboard.shootparams_pos) && !isDefined(self._blackboard.shootparams_ent))
    return 1;

  var_0 = self getmuzzleangle();
  var_1 = scripts\asm\shared\utility::getshootfrompos();
  var_2 = getshootpos(var_1);

  if(!isDefined(var_2))
    return 0;

  var_3 = vectortoangles(var_2 - var_1);
  var_4 = scripts\engine\utility::absangleclamp180(var_0[1] - var_3[1]);

  if(var_4 > anim.aimyawdifffartolerance) {
    if(distancesquared(self getEye(), var_2) > anim.aimyawdiffclosedistsq || var_4 > anim.aimyawdiffclosetolerance) {}
  }

  var_5 = getaimpitchdifftolerance();
  return scripts\engine\utility::absangleclamp180(var_0[0] - var_3[0]) <= var_5;
}

getaimpitchdifftolerance() {
  if(isDefined(self.aimpitchdifftolerance))
    return self.aimpitchdifftolerance;
  else
    return anim.aimpitchdifftolerance;
}

delayslowmotion(var_0, var_1, var_2, var_3) {}

delaymodifybasefov(var_0, var_1, var_2) {}

animscriptmp(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5))
    thread animscriptmp_watchcancel(var_5);

  if(istrue(var_3))
    thread animscriptmp_loop_internal(var_0, var_1, var_2, var_4);
  else
    thread animscriptmp_single_internal(var_0, var_1, var_2, var_4);
}

cancelanimscriptmp() {
  if(!scripts\asm\asm_bb::bb_isanimScripted())
    return 0;

  cancelanimscriptmp_internal();
  self notify("_encstr_882B131A589B8DCA1B05372D5BDC6C4E5AC1D16A05");
}

animscriptmp_watchcancel(var_0) {
  self endon("_encstr_AB8E165088F3FF9248BD0918991192EF3E406ACB505DD34F");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_882B131A589B8DCA1B05372D5BDC6C4E5AC1D16A05");
  self waittill(var_0);
  cancelanimscriptmp();
}

animscriptmp_single_internal(var_0, var_1, var_2, var_3) {
  animscriptmp_internal(var_0, var_1, var_2, var_3);

  if(isDefined(self) && isalive(self)) {
    cancelanimscriptmp_internal();
    self notify("_encstr_AB8E165088F3FF9248BD0918991192EF3E406ACB505DD34F");
  }
}

animscriptmp_loop_internal(var_0, var_1, var_2, var_3) {
  self endon("_encstr_882B131A589B8DCA1B05372D5BDC6C4E5AC1D16A05");
  self endon("_encstr_AD75063D571AE108");

  for(;;)
    animscriptmp_internal(var_0, var_1, var_2, var_3);
}

animscriptmp_internal(var_0, var_1, var_2, var_3) {
  self endon("_encstr_882B131A589B8DCA1B05372D5BDC6C4E5AC1D16A05");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_3))
    var_3 = 1;

  scripts\asm\shared\utility::setoverridearchetype("_encstr_ACFD0B6A08AB2DBF015E092875", var_0, 1);
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_4 = archetypegetrandomalias(var_0, var_1, var_2, scripts\asm\asm::asm_isfrantic());
  self aisetanim(var_1, var_4, var_3);
  self aisetanimrate(var_1, var_4, var_3);
  var_5 = animsetgetallanimindicesforalias(var_0, var_1, var_4);
  var_6 = getanimlength(var_5);
  self.scripted_mode = 1;
  self.ignoreall = 1;
  wait(var_6 / var_3);
}

cancelanimscriptmp_internal() {
  scripts\asm\asm_bb::bb_clearanimScripted();
  scripts\asm\shared\utility::clearoverridearchetype("_encstr_ACFD0B6A08AB2DBF015E092875", 0, 0);
  self.scripted_mode = 0;
  self.ignoreall = 0;
}

burndowntime(var_0, var_1, var_2) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();

  if(!isDefined(var_2))
    var_2 = "_encstr_84610D49100897C2DF809A03583BFF";

  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_0);
  self aisetanim(var_2, var_3);

  if(!isDefined(var_1))
    var_1 = 0;

  if(!var_1) {
    var_4 = scripts\asm\asm::asm_getxanim(var_2, var_3);
    var_5 = getanimlength(var_4);
    wait(var_5);
  }
}

burningdown(var_0, var_1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_3 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = getanimlength(var_3);

  if(var_1 < var_4)
    wait(var_4 - var_1);
}

bunkerinteriorkeypads(var_0) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_1 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  var_2 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_1);
  var_3 = getanimlength(var_2);

  if(var_3 < 0.05)
    var_3 = 0.05;

  for(;;) {
    self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_1);
    wait(var_3);
  }
}

bunkermusicstarted(var_0, var_1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  var_3 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = getanimlength(var_3);

  if(var_1 < var_4)
    var_4 = var_4 - var_1;

  if(var_4 < 0.05)
    var_4 = 0.05;

  for(;;) {
    self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
    wait(var_4);
  }
}

bunkernum(var_0, var_1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  var_3 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = getanimlength(var_3);

  if(var_4 < 0.05)
    var_4 = 0.05;

  for(var_5 = var_1; var_5 >= 0; var_5 = var_5 - var_4) {
    self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
    wait(var_4);
  }
}

bunkeropened(var_0, var_1) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  var_3 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_4 = getanimlength(var_3);

  if(var_4 < 0.05)
    var_4 = 0.05;

  while(var_1 > 0) {
    self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_2);
    wait(var_4);
    var_1--;
  }
}

bunkervaults(var_0, var_1, var_2) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_3 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  var_4 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);

  if(isDefined(var_2)) {
    var_5 = var_1 gettagorigin(var_2);
    var_6 = var_1 gettagangles(var_2);
  } else {
    var_5 = var_1.origin;
    var_6 = var_1.angles;
  }

  var_7 = getstartorigin(var_5, var_6, var_4);
  var_8 = getstartangles(var_5, var_6, var_4);
  self dontinterpolate();
  self forceteleport(var_7, var_8, 9999999, 0);

  for(;;) {
    self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);
    var_9 = getanimlength(var_4);
    wait(var_9);
  }
}

burningpartlogic(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = "_encstr_84610D49100897C2DF809A03583BFF";

  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_4, var_0);
  var_6 = scripts\asm\asm::asm_getxanim(var_4, var_5);

  if(isDefined(var_2)) {
    var_7 = var_1 gettagorigin(var_2);
    var_8 = var_1 gettagangles(var_2);
  } else {
    var_7 = var_1.origin;
    var_8 = var_1.angles;
  }

  var_9 = getstartorigin(var_7, var_8, var_6);
  var_10 = getstartangles(var_7, var_8, var_6);
  self dontinterpolate();
  self forceteleport(var_9, var_10, 9999999, 0);
  self aisetanim(var_4, var_5);

  if(!isDefined(var_3))
    var_3 = 0;

  if(!var_3) {
    var_11 = getanimlength(var_6);
    wait(var_11);
  }
}

burnfxstates(var_0, var_1, var_2, var_3) {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  var_4 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_0);
  var_5 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_4);
  var_6 = getmovedelta(var_5);
  var_7 = getangledelta3d(var_5);
  var_8 = combineangles(var_2, invertangles(var_7));
  var_9 = var_1 - rotatevector(var_6, var_8);
  self dontinterpolate();
  self forceteleport(var_9, var_8, 9999999, 0);
  self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_4);

  if(!isDefined(var_3))
    var_3 = 0;

  if(!var_3) {
    var_10 = getanimlength(var_5);
    wait(var_10);
  }
}

bunkercounteruav() {
  scripts\asm\asm_bb::bb_clearanimScripted();
}