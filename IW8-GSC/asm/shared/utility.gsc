/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\shared\utility.gsc
***********************************************/

set_default_aim_limits(var_0) {
  if(isDefined(var_0))
    self setdefaultaimlimits(var_0);
  else
    self setdefaultaimlimits();

  if(scripts\engine\utility::actor_is3d()) {
    self.upaimlimit = -65;
    self.downaimlimit = 65;
    self.rightaimlimit = -56;
    self.leftaimlimit = 56;
  }
}

set_aim_and_turn_limits() {
  set_default_aim_limits();

  if(self.currentpose == "_encstr_A5AD069B231F0BAF" && !scripts\engine\utility::actor_is3d()) {
    self.upaimlimit = -45;
    self.downaimlimit = 80;

    if(self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
      self.upaimlimit = -80;
  } else if(self.currentpose == "_encstr_922406F1A6FD5E05") {
    self.rightaimlimit = -45;
    self.leftaimlimit = 45;
  }

  self.turnthreshold = self.defaultturnthreshold;
  self.pitchturnthreshold = self.defaultpitchturnthreshold;
}

chooseanimshoot(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = self._blackboard.shootstate + "_encstr_BA4C02DF" + var_3;

  if(isDefined(self._blackboard.shootstate) && scripts\asm\asm::asm_hasalias(var_1, var_4))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

choosedemeanoranimwithoverride(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, var_2)) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, var_2);

    if(isarray(var_4))
      return var_4[randomint(var_4.size)];

    return var_4;
  }

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_8B1608EC43B8D647A113");

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

choosedemeanoranimwithoverridevariants(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, var_2)) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, var_2);

    if(isarray(var_4))
      return var_4[randomint(var_4.size)];

    return var_4;
  }

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
    var_5 = [];
    var_5[0] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_881D164739B037B9FA47BD7DB7CD59BED00BE691D73957DC");
    var_5[1] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_B62C0DE7C8BF3E289F264BAFAB4320");
    var_5[2] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_928A16092BF2D070AFEB10EE136F5880BACF85A107AB25C0");
    var_5[3] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_B6980DD1EEF6F5860BDC32F593D5B9");
    return var_5;
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

chooseanim_exposedreload(var_0, var_1, var_2) {
  var_2 = "_encstr_B40101";

  if(isDefined(self.node) && self.node.type == "_encstr_AFFF0C6E8FE899DDE6174B068510") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("_encstr_8CB405F6CE569C"))
      var_2 = var_2 + "_encstr_ACA906975B800F68";
  }

  return chooseanim_weaponclassprepended(var_0, var_1, var_2);
}

chooseanim_weaponswitch(var_0, var_1, var_2) {
  if(weaponclass(self.weapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" && scripts\asm\asm::asm_hasalias(var_1, "_encstr_991509552DCA4F1F9D176F"))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_991509552DCA4F1F9D176F");

  var_3 = scripts\asm\asm_bb::bb_getrequestedweapon();

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3))
    var_3 = "_encstr_965306392D3336B2";

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

isspeedwithincqbrange(var_0, var_1) {
  if(!getanimspeedthreshold(var_0, "_encstr_8F7905C4AEC319") || !getanimspeedthreshold(var_0, "_encstr_B4190453BD3B"))
    return 0;

  return var_1 < getcoveranglelimits(var_0, "_encstr_8F7905C4AEC319", "_encstr_B4190453BD3B", 0.1);
}

isspeedwithinsprintrange(var_0, var_1) {
  return var_1 > getcoveranglelimits(var_0, "_encstr_B4190493D573", "_encstr_92100762872552A643", 0.1);
}

isspeedwithincombatrange(var_0, var_1) {
  if(getanimspeedthreshold(var_0, "_encstr_8F7905C4AEC319") && getanimspeedthreshold(var_0, "_encstr_B4190453BD3B") && var_1 < getcoveranglelimits(var_0, "_encstr_8F7905C4AEC319", "_encstr_B4190453BD3B", 0.9))
    return 0;

  if(getanimspeedthreshold(var_0, "_encstr_B4190493D573") && getanimspeedthreshold(var_0, "_encstr_92100762872552A643") && var_1 > getcoveranglelimits(var_0, "_encstr_B4190493D573", "_encstr_92100762872552A643", 0.1))
    return 0;

  return 1;
}

isspeedwithincombatrangeextended(var_0, var_1) {
  if(getanimspeedthreshold(var_0, "_encstr_8F7905C4AEC319") && getanimspeedthreshold(var_0, "_encstr_B4190453BD3B") && var_1 < getcoveranglelimits(var_0, "_encstr_8F7905C4AEC319", "_encstr_B4190453BD3B", 0.8))
    return 0;

  if(getanimspeedthreshold(var_0, "_encstr_B4190493D573") && getanimspeedthreshold(var_0, "_encstr_92100762872552A643") && var_1 > getcoveranglelimits(var_0, "_encstr_B4190493D573", "_encstr_92100762872552A643", 0.3))
    return 0;

  return 1;
}

movetypeisnotcasual(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();
  return var_4 != "_encstr_914B078DB09BAB0BB1" && var_4 != "_encstr_8AEE0B360BE6578563AFCEBACD";
}

getnodeforwardyawnodetypelookupoverride(var_0, var_1) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_A7760B6710A315533959DF17AD":
        if(var_1 == "_encstr_B13D076BED70539F23")
          return "_encstr_8267124310DE69AADAED119B9B5206A220A572E0";

        break;
      case "_encstr_86A30C90489C3F32B21DA9AF0178":
        if(var_1 == "_encstr_B13D076BED70539F23")
          return "_encstr_A777136710A315533956DC57A349AEFB8BA8377F40";

        break;
      case "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C":
      case "_encstr_854714E37F10FF63BFDD9B32636643E641DB764CE7F0":
        return "_encstr_87AB0D4BD7B857DB077503DA9B8EEB";
      case "_encstr_8AD80E1ABD376CCAB0C6086A3A2CB9C8":
        return "_encstr_AFFF0C6E8FE899DDE6174B068510";
    }
  }

  return undefined;
}

overridecovercrouchnodetype(var_0) {
  if(var_0.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB" && isDefined(self._blackboard.croucharrivaltype))
    return self._blackboard.croucharrivaltype;

  return var_0.type;
}

getnodeoffsetposeoverride(var_0, var_1, var_2) {
  var_3 = self.currentpose;

  if(isDefined(var_2))
    var_3 = var_2;
  else if(isnode(var_0) && !var_0 doesnodeallowstance(var_3))
    var_3 = var_0 gethighestnodestance();

  var_4 = getnodeforwardyawnodetypelookupoverride(var_1, var_3);
  return var_4;
}

getnodeyawfromoffsettable(var_0, var_1, var_2) {
  var_3 = self.currentpose;

  if(isDefined(var_2))
    var_3 = var_2;
  else if(isnode(var_1) && !var_1 doesnodeallowstance(var_3))
    var_3 = var_1 gethighestnodestance();

  var_4 = overridecovercrouchnodetype(var_1);
  var_5 = getnodeforwardyawnodetypelookupoverride(var_4, var_3);

  if(isDefined(var_5) && isDefined(var_0[var_5]))
    return var_0[var_5];

  if(isDefined(var_0[var_4]))
    return var_0[var_4];

  return undefined;
}

allowlmgarrival() {
  if(istrue(self.disablelmgmount))
    return 0;

  var_0 = weaponclass(self.weapon) == "_encstr_BE0703A54C";

  if(var_0) {
    if(!isDefined(self.node) || self.node isnodelmgmountable())
      return 1;

    return 0;
  }

  if(isDefined(self._blackboard.deployedlmgnode) && isDefined(self.node) && self.node == self._blackboard.deployedlmgnode && self.node isnodelmgmountable())
    return 1;

  return 0;
}

getnodeyawoffset(var_0, var_1, var_2) {
  if(isstruct(var_0) || !isDefined(var_0.type))
    return 0;

  if(istrue(self._blackboard.inlmgstate) || istrue(self.asm.usingaturret))
    return 0;

  var_3 = overridecovercrouchnodetype(var_0);
  var_4 = self getnodehideyaw(var_0, var_3, var_1, var_2);
  return var_4;
}

getnodeforwardyaw(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = getnodeyawoffset(var_0, var_1, var_2);
  return var_0.angles[1] + var_3;
}

getnodeforwardangles(var_0, var_1) {
  var_2 = getnodeyawoffset(var_0, var_1, 1);
  return combineangles(var_0.angles, (0, var_2, 0));
}

getnodeleanyaw(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = var_0.type;

  var_3 = getnodeoffsetposeoverride(var_0, var_1, var_2);

  if(isDefined(var_3))
    return self getnodeleanaimyawoffset(var_3);
  else
    return self getnodeleanaimyawoffset(var_1);
}

getnodeaimpitchoffset(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_2 == "_encstr_8E2508591EE07BE6B246")
    var_3 = anim.nodeexposedpitches[var_0];
  else if(var_2 == "_encstr_9BAD05B1560B9B" || var_2 == "_encstr_A93309814DDEC847482FAD")
    var_3 = anim.nodeleanpitches[var_0];
  else if(var_2 == "_encstr_A7A809DE67CA9CC6592C37")
    var_3 = anim.nodeoverleanpitches[var_0];

  if(isDefined(var_3)) {
    var_4 = getnodeyawfromoffsettable(var_3, var_1, undefined);

    if(isDefined(var_4))
      return var_4;
  }

  return 0;
}

getnodeaimyawoffset(var_0, var_1, var_2) {
  if(var_2 == "_encstr_9BAD05B1560B9B") {
    var_3 = overridecovercrouchnodetype(var_1);
    return self getnodeleanaimyaw(var_1, var_3);
  }

  return 0;
}

nodeiscoverstand3dtype(var_0) {
  if(var_0.type == "_encstr_A9700F9D2D8ED0C60647F9DB9B6A27DA14")
    return !nodeiscoverexposed3dtype(var_0);

  return 0;
}

nodeiscoverexposed3dtype(var_0) {
  if(var_0.type == "_encstr_A9700F9D2D8ED0C60647F9DB9B6A27DA14") {
    if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_8E2508591EE07BE6B246")
      return 1;
  }

  return 0;
}

getnodetypename(var_0) {
  if(isDefined(var_0)) {
    if(nodeiscoverexposed3dtype(var_0))
      return "_encstr_AC99110B77D818B649D5C36952935D5FE9D2F7";
    else
      return var_0.type;
  }

  return "_encstr_8C500ABA9B23CACC2D37AC8C";
}

choosestrongdamagedeath(var_0, var_1, var_2) {
  var_3 = undefined;

  if(abs(self.damageyaw) > 150) {
    if(scripts\engine\utility::damagelocationisany("_encstr_BDF80F4495E9F3C9C1387AF15011FA4F83", "_encstr_BACF0FC17D8FB0A0BB52111E2A5F6CE022", "_encstr_8B1D10834BA13813E7693FB7D86B8BE80920", "_encstr_A91A1025A967F88DCF6A0971613BC8C83F2A", "_encstr_95E80A8D59CCD1F533DBED3A", "_encstr_8ECF0B734B47E3AB67AD07909B"))
      var_3 = "_encstr_ABAD054DE5976B";
    else if(self.damagelocation == "_encstr_9B7A0CF35815C3971660B7CF306B")
      var_3 = "_encstr_9B7A0CF35815C3971660B7CF306B";
    else
      var_3 = "_encstr_8B1608EC43B8D647A113";
  } else if(self.damageyaw < 0)
    var_3 = "_encstr_8253060E2B5FE330";
  else
    var_3 = "_encstr_A5AD056A019C63";

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

isatcovernode() {
  return isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

setuseanimgoalweight(var_0, var_1) {
  self endon(var_0 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self.useanimgoalweight = 1;
  thread setuseanimgoalweight_wait(var_0);

  if(var_1 > 0)
    wait(var_1);

  self.useanimgoalweight = 0;
  self notify("_encstr_A714161FF0B8280987D53EEDCB53E0CF81D8974FA0117863");
}

setuseanimgoalweight_wait(var_0) {
  self notify("_encstr_A714161FF0B8280987D53EEDCB53E0CF81D8974FA0117863");
  self endon("_encstr_A714161FF0B8280987D53EEDCB53E0CF81D8974FA0117863");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  self waittill(var_0 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self.useanimgoalweight = 0;
}

shouldleaveanimScripted(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_isanimScripted())
    return 0;

  var_4 = var_3;

  if(var_4) {
    if(self.a.movement == "_encstr_B419059BD17BE0")
      return 0;

    if(!scripts\asm\asm_bb::bb_moverequested())
      return 0;
  } else if(scripts\asm\asm_bb::bb_moverequested() && self.a.movement != "_encstr_B419059BD17BE0")
    return 0;

  return 1;
}

scriptedcoverposerequestis(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(self.a.coverpose_request == var_4) {
    self.a.coverpose_request = undefined;
    return 1;
  }

  return 0;
}

scriptedcoverposerequestisDefined(var_0, var_1, var_2, var_3) {
  return isDefined(self.a.coverpose_request);
}

animscriptedaction(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self.a.movement = "_encstr_B4190493D573";
  self.gunposeoverride_internal = "_encstr_B2650840FBDB7F1188A1";
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_AFAB063620A0C612");
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

randomizepassthroughchildren(var_0, var_1, var_2, var_3) {
  var_4 = anim.asm[var_0].states[var_2];

  if(isDefined(var_4.transitions)) {
    if(var_4.transitions.size == 2) {
      if(scripts\engine\utility::cointoss()) {
        var_5 = var_4.transitions[0];
        var_4.transitions[0] = var_4.transitions[1];
        var_4.transitions[1] = var_5;
      }
    } else
      var_4.transitions = scripts\engine\utility::array_randomize(var_4.transitions);
  }

  return 1;
}

blockedbywall(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(isDefined(self._blackboard)) {
    var_1 = gettime();

    if(isDefined(self._blackboard.gunblockedbywalltime)) {
      if(var_1 - self._blackboard.gunblockedbywalltime < 300)
        return 1;

      self._blackboard.gunblockedbywalltime = undefined;
    }

    if(!var_0 && isDefined(self._blackboard.lastblockedbywallchecktime) && var_1 - self._blackboard.lastblockedbywallchecktime < 200)
      return 0;

    self._blackboard.lastblockedbywallchecktime = var_1;

    if(self isgunblockedbywall()) {
      self._blackboard.gunblockedbywalltime = var_1;

      if(isDefined(scripts\asm\asm_bb::bb_getcovernode()) && !isDefined(self._blackboard.initialcovergunblockedbywalltime) && scripts\asm\asm_bb::bb_getrequestedcoverstate() == "_encstr_8E2508591EE07BE6B246")
        self._blackboard.initialcovergunblockedbywalltime = self._blackboard.gunblockedbywalltime;

      return 1;
    } else
      self._blackboard.initialcovergunblockedbywalltime = undefined;
  }

  return 0;
}

nodeshouldfaceangles(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0.angles))
    return 1;

  if(isstruct(var_0))
    return 0;

  return isDefined(var_0.type) && var_0.type != "_encstr_8F0D0582C21D43" && !scripts\engine\utility::isnodeexposed3d(var_0);
}

choosecrouchorstand(var_0, var_1) {
  return int(var_1.origin[0] + var_1.origin[1] + var_1.origin[2] + var_0 getentitynumber()) % 2;
}

getwincost(var_0, var_1) {
  return int(abs(var_1[0] + var_1[1] + var_1[2] + var_0 getentitynumber())) % 2;
}

getarrivalnode() {
  if(istrue(self.leavecasualkiller))
    return undefined;

  if(isDefined(self.scriptedarrivalent) && !self btgoalvalid())
    return self.scriptedarrivalent;

  if(isDefined(self.node))
    return self.node;

  if(isDefined(self.prevnode) && isDefined(self.pathgoalpos) && distance2dsquared(self.prevnode.origin, self.pathgoalpos) < 36)
    return self.prevnode;

  if(isDefined(self.last_set_goalnode))
    return self.last_set_goalnode;

  return self.last_set_goalent;
}

isarrivaltypecivilian(var_0, var_1) {
  if(isDefined(self.asm.customdata.arrivalstate))
    return var_1 == "_encstr_BD34070D57B9A37BD6";

  if(scripts\asm\asm_bb::bb_smartobjectrequested())
    return var_1 == "_encstr_8E2508511EE07BE6B246";

  var_2 = getarrivalnode();

  if(isDefined(var_2) && isnode(var_2) && var_2 iscovermultinode()) {
    var_3 = scripts\engine\utility::getbestcovermultinodetype(var_2);

    if(isDefined(var_3))
      var_2 setcovermultinodetype(var_3);
  }

  if(!isDefined(var_2) || !isDefined(var_2.type) || var_2.type == "_encstr_91D8076ED193D5B11D" || self.combatmode == "_encstr_821109FAE81117DA568730")
    return var_1 == "_encstr_8E2508511EE07BE6B246";

  if(isDefined(var_2) && var_2.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB") {
    var_4 = getDvar("_encstr_B1A7199B1B4EF5B0A5D7D8DEB32B397D8D39F65D361AAF47E50E2B");

    if(var_4 != "_encstr_B40101")
      return var_1 == var_4;

    if(isDefined(self._blackboard.croucharrivaltype))
      return var_1 == self._blackboard.croucharrivaltype;
    else if(isDefined(var_2.covercrouchtype))
      return var_1 == var_2.covercrouchtype;
  }

  var_5 = scripts\asm\asm::asm_getdemeanor();
  var_6 = (!isnode(var_2) || var_2 doesnodeallowstance("_encstr_A5AD069B231F0BAF")) && self isstanceallowed("_encstr_A5AD069B231F0BAF");
  var_7 = (!isnode(var_2) || var_2 doesnodeallowstance("_encstr_B13D076BED70539F23")) && self isstanceallowed("_encstr_B13D076BED70539F23") && var_5 != "_encstr_914B078DB09BAB0BB1" && var_5 != "_encstr_8AEE0B360BE6578563AFCEBACD";

  switch (var_1) {
    case "_encstr_8E2508511EE07BE6B246":
      if(var_2.type != "_encstr_8F0D0582C21D43" && var_2.type != "_encstr_8E2508511EE07BE6B246")
        return 0;

      if(var_7 && choosecrouchorstand(self, var_2))
        return 0;

      return var_6;
    case "_encstr_AD5E0FA21E83DBE6AC2304D0E4DB5DD843":
      if(var_2.type != "_encstr_8F0D0582C21D43" && var_2.type != "_encstr_8E2508511EE07BE6B246")
        return 0;

      if(var_6 && !choosecrouchorstand(self, var_2))
        return 0;

      return var_7;
    case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
      return var_2.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB" || var_2.type == "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C" || var_2.type == "_encstr_854714E37F10FF63BFDD9B32636643E641DB764CE7F0" || var_2.type == "_encstr_AFFF0C6E8FE899DDE6174B068510" || var_2.type == "_encstr_8AD80E1ABD376CCAB0C6086A3A2CB9C8" || var_2.type == "_encstr_AF7A0CE15F5EDDE38968D2FF2050" || var_2.type == "_encstr_BEF40E1678B85E45B0A1720A43281BA1";
    case "_encstr_A7760B6710A315533959DF17AD":
      return var_2.type == "_encstr_A7760B6710A315533959DF17AD";
    case "_encstr_86A30C90489C3F32B21DA9AF0178":
      return var_2.type == "_encstr_86A30C90489C3F32B21DA9AF0178";
    case "_encstr_ABBA0FA2E107ED37594604537B674B373B":
      return var_2.type == "_encstr_ABBA0FA2E107ED37594604537B674B373B";
  }

  return var_1 == var_2.type;
}

isarrivaltype(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(isDefined(self.asm.customdata.arrivalstate))
    return var_4 == "_encstr_BD34070D57B9A37BD6";

  if(scripts\asm\asm_bb::bb_smartobjectrequested())
    return var_4 == "_encstr_8E2508511EE07BE6B246";

  var_5 = getarrivalnode();

  if(isDefined(var_5) && isnode(var_5) && var_5 iscovermultinode()) {
    var_6 = scripts\engine\utility::getbestcovermultinodetype(var_5);

    if(isDefined(var_6) && var_5.type != var_6 && var_4 == var_6)
      var_5 setcovermultinodetype(var_6);
  }

  if(!isDefined(var_5) || !isDefined(var_5.type) || var_5.type == "_encstr_91D8076ED193D5B11D" || self.combatmode == "_encstr_821109FAE81117DA568730") {
    if(scripts\engine\utility::actor_is3d())
      return var_4 == "_encstr_87820B3588934FE3ED137AEA7B";
    else
      return var_4 == "_encstr_8E2508511EE07BE6B246";
  }

  var_7 = allowlmgarrival();

  if(isDefined(var_5) && var_5.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB" && !var_7) {
    var_8 = getDvar("_encstr_B1A7199B1B4EF5B0A5D7D8DEB32B397D8D39F65D361AAF47E50E2B");

    if(var_8 != "_encstr_B40101")
      return var_4 == var_8;

    if(isDefined(self._blackboard.croucharrivaltype))
      return var_4 == self._blackboard.croucharrivaltype;
    else if(isDefined(var_5.covercrouchtype))
      return var_4 == var_5.covercrouchtype;
  }

  var_9 = scripts\asm\asm::asm_getdemeanor();
  var_10 = (!isnode(var_5) || var_5 doesnodeallowstance("_encstr_A5AD069B231F0BAF")) && self isstanceallowed("_encstr_A5AD069B231F0BAF");
  var_11 = (!isnode(var_5) || var_5 doesnodeallowstance("_encstr_B13D076BED70539F23")) && self isstanceallowed("_encstr_B13D076BED70539F23") && var_9 != "_encstr_914B078DB09BAB0BB1" && var_9 != "_encstr_8AEE0B360BE6578563AFCEBACD";

  if(var_0 == "_encstr_A5FC13A2490B382962229F039AEBD0A95B0A47160A") {
    switch (var_4) {
      case "_encstr_87820B3588934FE3ED137AEA7B":
        return scripts\engine\utility::isnodeexposed3d(var_5) && var_10;
      case "_encstr_BEC809853586D8CEFECE81":
        return var_5.type == "_encstr_BEC809853586D8CEFECE81";
      case "_encstr_A9700F9D2D8ED0C60647F9DB9B6A27DA14":
        return nodeiscoverstand3dtype(var_5);
      case "_encstr_AC99110B77D818B649D5C36952935D5FE9D2F7":
        return nodeiscoverexposed3dtype(var_5);
      case "_encstr_AF7A0CE15F5EDDE38968D2FF2050":
      case "_encstr_AD5E0FA21E83DBE6AC2304D0E4DB5DD843":
      case "_encstr_8E2508511EE07BE6B246":
      case "_encstr_8F0D0582C21D43":
      case "_encstr_A777136710A315533956DC57A349AEFB8BA8377F40":
      case "_encstr_86A30C90489C3F32B21DA9AF0178":
      case "_encstr_8267124310DE69AADAED119B9B5206A220A572E0":
      case "_encstr_A7760B6710A315533959DF17AD":
      case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
        break;
    }
  } else if(var_0 == "_encstr_88D40D4F5639F6BED94EB0CE2D3AF2") {
    switch (var_4) {
      case "_encstr_8E2508511EE07BE6B246":
        return (var_5.type == "_encstr_8F0D0582C21D43" || var_5.type == "_encstr_8E2508511EE07BE6B246") && var_10;
      case "_encstr_AD5E0FA21E83DBE6AC2304D0E4DB5DD843":
        return (var_5.type == "_encstr_8F0D0582C21D43" || var_5.type == "_encstr_8E2508511EE07BE6B246") && var_11;
      case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
        return var_5.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB" || var_5.type == "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C";
      case "_encstr_AFFF0C6E8FE899DDE6174B068510":
        return var_5.type == "_encstr_AFFF0C6E8FE899DDE6174B068510" || var_5.type == "_encstr_8AD80E1ABD376CCAB0C6086A3A2CB9C8";
      case "_encstr_AF7A0CE15F5EDDE38968D2FF2050":
      case "_encstr_A777136710A315533956DC57A349AEFB8BA8377F40":
      case "_encstr_86A30C90489C3F32B21DA9AF0178":
      case "_encstr_8267124310DE69AADAED119B9B5206A220A572E0":
      case "_encstr_A7760B6710A315533959DF17AD":
        break;
    }
  } else {
    switch (var_4) {
      case "_encstr_8E2508511EE07BE6B246":
        if(var_5.type != "_encstr_8F0D0582C21D43" && var_5.type != "_encstr_8E2508511EE07BE6B246")
          return 0;

        if(var_11 && choosecrouchorstand(self, var_5))
          return 0;

        return var_10;
      case "_encstr_AD5E0FA21E83DBE6AC2304D0E4DB5DD843":
        if(var_5.type != "_encstr_8F0D0582C21D43" && var_5.type != "_encstr_8E2508511EE07BE6B246")
          return 0;

        if(var_10 && !choosecrouchorstand(self, var_5))
          return 0;

        return var_11;
      case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
        return var_5.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB" || var_5.type == "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C" || var_5.type == "_encstr_854714E37F10FF63BFDD9B32636643E641DB764CE7F0";
      case "_encstr_AFFF0C6E8FE899DDE6174B068510":
        return var_5.type == "_encstr_AFFF0C6E8FE899DDE6174B068510" || var_5.type == "_encstr_8AD80E1ABD376CCAB0C6086A3A2CB9C8";
      case "_encstr_AF7A0CE15F5EDDE38968D2FF2050":
        return var_5.type == "_encstr_AF7A0CE15F5EDDE38968D2FF2050" || var_5.type == "_encstr_BEF40E1678B85E45B0A1720A43281BA1";
      case "_encstr_A7760B6710A315533959DF17AD":
        if(var_5.type != "_encstr_A7760B6710A315533959DF17AD")
          return 0;

        if(var_11 && choosecrouchorstand(self, var_5))
          return 0;

        return var_10;
      case "_encstr_8267124310DE69AADAED119B9B5206A220A572E0":
        if(var_5.type != "_encstr_A7760B6710A315533959DF17AD")
          return 0;

        if(var_10 && !choosecrouchorstand(self, var_5))
          return 0;

        return var_11;
      case "_encstr_86A30C90489C3F32B21DA9AF0178":
        if(var_5.type != "_encstr_86A30C90489C3F32B21DA9AF0178")
          return 0;

        if(var_11 && choosecrouchorstand(self, var_5))
          return 0;

        return var_10;
      case "_encstr_A777136710A315533956DC57A349AEFB8BA8377F40":
        if(var_5.type != "_encstr_86A30C90489C3F32B21DA9AF0178")
          return 0;

        if(var_10 && !choosecrouchorstand(self, var_5))
          return 0;

        return var_11;
      case "_encstr_ABB5114EE7130DEB6267E37B3F618B7288CDB7":
        return (var_5.type == "_encstr_87AB0D4BD7B857DB077503DA9B8EEB" || var_5.type == "_encstr_AF7A0CE15F5EDDE38968D2FF2050") && allowlmgarrival();
      case "_encstr_996710B7859390936287A5F01DFAB9DC217F":
        return var_5.type == "_encstr_AFFF0C6E8FE899DDE6174B068510" && allowlmgarrival();
      case "_encstr_ABBA0FA2E107ED37594604537B674B373B":
        return var_5.type == "_encstr_ABBA0FA2E107ED37594604537B674B373B";
    }
  }

  return var_4 == var_5.type;
}

playmoveloop(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  thread waitforcoverapproach(var_0, var_1);
  thread waitforsharpturn(var_0, var_1);
  thread waitfordooropen(var_0, var_1, 0);
  var_3 = 1.0;
  scripts\asm\asm::asm_updatefrantic();
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, var_3, 1);
  scripts\asm\asm::asm_updatefrantic();
}

playmoveloopcasual(var_0, var_1, var_2) {
  playmoveloop(var_0, var_1, var_2);
}

_id_1244E(var_0, var_1, var_2) {
  thread waitfordooropen(var_0, var_1, 1);
  playanim(var_0, var_1, var_2);
}

waitforcoverapproach(var_0, var_1) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");

  for(;;) {
    self.requestarrivalnotify = 1;
    self waittill("_encstr_A78D0F6CBDCE2B9CF5580E07C9F6168D0D", var_2);
    scripts\asm\asm::asm_fireevent(var_0, "_encstr_A78D0F6CBDCE2B9CF5580E07C9F6168D0D", var_2);
    self.a.approachdir = var_2;
  }
}

waitforsharpturn(var_0, var_1) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self waittill("_encstr_87A80D78CBA8146FA61032CAD98DDB", var_2, var_3, var_4, var_5, var_6);
  var_7 = [var_2, var_3, var_4, var_5, var_6];
  scripts\asm\asm::asm_fireevent(var_0, "_encstr_85E20B37342C4E83D71DD5E4B9", var_7);
  thread waitforsharpturn(var_0, var_1);
}

playmoveloopcasualcleanup(var_0, var_1, var_2) {}

calcdooropenspeed() {
  if(scripts\common\utility::iscp())
    return 0.8;

  var_0 = 0.75;
  var_1 = length(self.velocity);

  if(var_1 > 0)
    var_0 = 24 / var_1;

  if(var_0 < 0.15)
    var_0 = 0.15;
  else if(var_0 > 1)
    var_0 = 1;

  return var_0;
}

opendooratreasonabletime() {
  var_0 = self._blackboard.doortoopen;
  var_1 = self.fndooropen;

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  self._blackboard.door_opened = 1;
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_84540E6AEF233B59E3A9AB51A3B73F40");
  var_2 = self[[self.fngetdoorcenter]](var_0);
  var_3 = distance2dsquared(var_2, self.origin);
  var_4 = 4096;

  if(scripts\common\utility::iscp()) {
    var_5 = 0.8 * length(self.velocity);
    var_5 = var_5 * 0.9;
    var_4 = max(var_5 * var_5, var_4);
  }

  while(var_3 > var_4) {
    if(isDefined(self._blackboard.doortoopen) && var_0 != self._blackboard.doortoopen) {
      return;
    }
    var_3 = distance2dsquared(var_2, self.origin);
    waitframe();
  }

  var_6 = calcdooropenspeed();
  self notify("_encstr_93CC0DC7684F60BBB37216791A5FEE");
  self thread[[var_1]](var_0, var_6);
  return var_6;
}

opendooratreasonabletime_waitforabort(var_0) {
  self endon("_encstr_AC8D12DFE365782A0A08273052053A092DBF43B3");
  self waittill(var_0 + "_encstr_A3DB0AF5332DDCD237D0AC8C");

  if(!isalive(self)) {
    return;
  }
  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = undefined;
  self notify("_encstr_AC8D12DFE365782A0A08273052053A092DBF43B3");
}

closedoorifnecessary(var_0) {
  if(self[[self.fndoorneedstoclose]](var_0))
    self[[self.fndoorclose]](var_0);
}

waitfordooropen(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  waitframe();

  for(;;) {
    if(isDefined(self._blackboard.doortoopen)) {
      var_3 = 0;

      if(self[[self.fndooralreadyopen]](self._blackboard.doortoopen))
        var_3 = 1;

      if(!var_3 && !isent(self._blackboard.doortoopen)) {
        if(!isDefined(self getmodifierlocationonpath("_encstr_B16705D9AFE22E", 200)))
          var_3 = 1;
      }

      if(var_3) {
        self._blackboard.doortoopen = undefined;
        waitframe();
        continue;
      }

      if(!self.facemotion) {
        var_4 = self.lookaheaddir;
        var_4 = vectorNormalize((var_4[0], var_4[1], 0));
        var_5 = anglesToForward(self.angles);

        if(vectordot(var_4, var_5) < 0.966) {
          self.isopeningdoor = 1;
          var_6 = opendooratreasonabletime();

          if(isDefined(var_6)) {
            thread opendooratreasonabletime_waitforabort(var_1);
            wait(var_6);
          }

          self notify("_encstr_AC8D12DFE365782A0A08273052053A092DBF43B3");
          self._blackboard.doortoopen = undefined;
          self.isopeningdoor = undefined;
          continue;
        }
      }

      var_7 = self._blackboard.doortoopen;
      self._blackboard.door_opened = undefined;
      var_8 = 1;
      var_9 = 160;
      var_10 = 2;
      var_11 = length2d(self.velocity);

      if(!istrue(var_2)) {
        var_12 = var_1;
        var_13 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, "_encstr_A74C0222");

        if(!isDefined(var_13)) {
          var_11 = self aigettargetspeed();
          var_14 = getnextlowestspeedthresholdstring(self.basearchetype, var_11);

          if(isDefined(var_14)) {
            var_15 = var_14 + "_encstr_A74C0222";
            var_13 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, var_15);

            if(!isDefined(var_13)) {
              var_12 = "_encstr_8A900A9CA7C8F0994A2875C8";
              var_13 = scripts\asm\asm::asm_lookupanimfromaliasifexists("_encstr_8A900A9CA7C8F0994A2875C8", var_15);
            }
          }
        }

        if(!isDefined(var_13))
          var_13 = scripts\asm\asm::asm_lookupanimfromaliasifexists("_encstr_8A900A9CA7C8F0994A2875C8", "_encstr_A74C0222");

        if(isDefined(var_13)) {
          var_16 = scripts\asm\asm::asm_getxanim(var_12, var_13);
          var_17 = getnotetracktimes(var_16, "_encstr_99C80BC8B7ED39AF8EED578D34");
          var_18 = (var_17[0] * getanimlength(var_16) + 2 * level.framedurationseconds) * var_11;
          var_9 = var_18 + 24;
        }
      }

      var_19 = var_8 + var_9 + var_10;
      var_20 = self[[self.fngetdoorcenter]](var_7);
      var_21 = distance2d(var_20, self.origin);

      if(var_21 < var_19) {
        self.isopeningdoor = 1;
        thread closedoorifnecessary(var_7);

        if(istrue(var_2) || var_21 < var_19 - var_11 * 2 * level.framedurationseconds) {
          var_6 = opendooratreasonabletime();

          if(isDefined(var_6)) {
            thread opendooratreasonabletime_waitforabort(var_1);
            wait(var_6);
          }

          self notify("_encstr_AC8D12DFE365782A0A08273052053A092DBF43B3");
          self._blackboard.doortoopen = undefined;
          self.isopeningdoor = undefined;
        } else {
          self setupdooropen(var_7, var_19, getdooropenspeedlookup());
          thread handledooropennotetrack(var_0, var_1);
          thread handledooropenterminate(var_0, var_1);
          self waittill("_encstr_AC8D12DFE365782A0A08273052053A092DBF43B3");
        }
      }
    }

    waitframe();
  }
}

handledooropennotetrack(var_0, var_1) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  self endon("_encstr_AC8D12DFE365782A0A08273052053A092DBF43B3");

  for(;;) {
    self waittill("_encstr_8A900A9CA7C8F0994A2875C8", var_2);

    if(!isarray(var_2))
      var_2 = [var_2];

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_2[var_3] == "_encstr_8A900A9CA7C8F0994A2875C8") {
        if(isDefined(self.fndooropen) && isDefined(self._blackboard.doortoopen)) {
          self notify("_encstr_93CC0DC7684F60BBB37216791A5FEE");
          var_4 = calcdooropenspeed();
          self thread[[self.fndooropen]](self._blackboard.doortoopen, var_4);
          self._blackboard.door_opened = 1;
        }

        continue;
      }

      if(var_2[var_3] == "_encstr_961804BD954A") {
        self._blackboard.doortoopen = undefined;
        self.isopeningdoor = undefined;
        self cleardooropen();
        self notify("_encstr_AC8D12DFE365782A0A08273052053A092DBF43B3");
      }
    }

    waitframe();
  }
}

handledooropenterminate(var_0, var_1) {
  self endon("_encstr_AC8D12DFE365782A0A08273052053A092DBF43B3");
  self waittill(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(!istrue(self._blackboard.door_opened))
    thread opendooratreasonabletime();

  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = undefined;
  self cleardooropen();
}

getdooropenspeedlookup() {
  if(self.asm.archetype == "_encstr_BE3F0FF759B36011870AD8E6037FD8A80E")
    return "_encstr_BE3F0FF759B36011870AD8E6037FD8A80E";
  else if(self.unittype == "_encstr_83E8094727E333E8F9CE50")
    return "_encstr_83E8094727E333E8F9CE50";
  else if(self.asm.archetype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
    return "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  else
    return "_encstr_958C08CDDBD8325A959C";
}

playanim(var_0, var_1, var_2) {
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

playanimwithsound(var_0, var_1, var_2) {
  self playSound(var_2);
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

loopanim(var_0, var_1, var_2) {
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1.0);
}

chooseanimidle(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, "_encstr_A7C5056BD931D1")) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, "_encstr_A7C5056BD931D1");

    if(isarray(var_4))
      return var_4[randomint(var_4.size)];

    return var_4;
  }

  if(isDefined(self.node) && self.node.type == "_encstr_AFFF0C6E8FE899DDE6174B068510") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("_encstr_8CB405F6CE569C"))
      var_2 = var_2 + "_encstr_ACA906975B800F68";
  }

  return chooseanim_weaponclassprepended(var_0, var_1, var_2);
}

chooseanim_weaponclassprepended(var_0, var_1, var_2) {
  var_3 = weaponclass(self.weapon);
  var_4 = undefined;

  if(!isDefined(var_2))
    return scripts\asm\asm::asm_getrandomanim(var_0, var_1);
  else
    var_4 = var_2;

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3 + var_4))
    var_3 = "_encstr_965306392D3336B2";

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + var_4);
}

calcarrivaltype(var_0, var_1, var_2) {
  self._blackboard.runpassthroughtype = getarrivaltype();
}

getarrivaltype() {
  if(isDefined(self.asm.customdata.arrivalstate))
    return "_encstr_BD34070D57B9A37BD6";

  if(scripts\asm\asm_bb::bb_smartobjectrequested())
    return "_encstr_8E2508511EE07BE6B246";

  var_0 = getarrivalnode();

  if(!isDefined(var_0) || !isnode(var_0) || !isDefined(var_0.type) || var_0.type == "_encstr_91D8076ED193D5B11D" || self.combatmode == "_encstr_821109FAE81117DA568730") {
    var_1 = self setcorpsemodel();

    if(isDefined(var_1)) {
      var_2 = scripts\asm\asm::asm_getdemeanor();
      var_3 = self isstanceallowed("_encstr_B13D076BED70539F23") && var_2 == "_encstr_AA7C07466F9DA30713";

      if(var_3 && getwincost(self, var_1))
        return "_encstr_AD5E0FA21E83DBE6AC2304D0E4DB5DD843";

      return "_encstr_8E2508511EE07BE6B246";
    }

    if(scripts\asm\asm_bb::bb_getrequestedstance() == "_encstr_B13D076BED70539F23" || isfixednodeinbadplaceandshouldcrouch() && self isstanceallowed("_encstr_B13D076BED70539F23"))
      return "_encstr_AD5E0FA21E83DBE6AC2304D0E4DB5DD843";

    return "_encstr_8E2508511EE07BE6B246";
  }

  if(isDefined(self.enemy) && iscoverinvalidagainstenemy(var_0) || shouldinitiallyattackfromexposed(var_0)) {
    if(var_0 doesnodeallowstance("_encstr_A5AD069B231F0BAF") && self isstanceallowed("_encstr_A5AD069B231F0BAF"))
      return "_encstr_8E2508511EE07BE6B246";
    else if(var_0 doesnodeallowstance("_encstr_B13D076BED70539F23") && self isstanceallowed("_encstr_B13D076BED70539F23"))
      return "_encstr_AD5E0FA21E83DBE6AC2304D0E4DB5DD843";
    else
      return "_encstr_AF7A0CE15F5EDDE38968D2FF2050";
  }

  if(isnode(var_0) && var_0 iscovermultinode()) {
    var_4 = scripts\engine\utility::getbestcovermultinodetype(var_0);

    if(isDefined(var_4) && var_4 != var_0.type)
      var_0 setcovermultinodetype(var_4);
  }

  var_5 = var_0.type;
  var_6 = allowlmgarrival();

  if(var_6) {
    switch (var_5) {
      case "_encstr_AF7A0CE15F5EDDE38968D2FF2050":
      case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
        return "_encstr_ABB5114EE7130DEB6267E37B3F618B7288CDB7";
      case "_encstr_AFFF0C6E8FE899DDE6174B068510":
        return "_encstr_996710B7859390936287A5F01DFAB9DC217F";
    }
  }

  if(isDefined(self._blackboard.croucharrivaltype) && !var_6)
    return self._blackboard.croucharrivaltype;

  return self choosearrivaltype(var_0, var_5);
}

shouldstrafe(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && !self.facemotion && self.allowstrafe;
}

shouldabortstrafe(var_0, var_1, var_2, var_3) {
  if(!shouldstrafe(var_0, var_1, var_2, var_3))
    return 1;

  if(!scripts\asm\asm_bb::bb_movetyperequested("_encstr_AA7C07466F9DA30713"))
    return 1;

  if(scripts\asm\asm_bb::bb_meleechargerequested())
    return 1;

  return 0;
}

chooseanimmovetype(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3))
    return scripts\asm\asm::asm_chooseanim(var_0, var_1, var_2);

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

transition_isflashed(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::isflashed();
}

transition_isburning(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.isburning) && !istrue(self.damageshield);
}

isdeafened(var_0, var_1, var_2, var_3) {
  var_4 = self.damagetaken;

  if(isDefined(self.paindamage))
    var_4 = self.paindamage;

  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("_encstr_AAE30A689B7FB1F6A2E3B3AF")) && self.damagemod != "_encstr_8DED0A21C79B660BC7588981" && var_4 >= 75)
    return 1;

  return 0;
}

isspecialpain(var_0, var_1, var_2, var_3) {
  return 1;
}

shouldreacttolight(var_0, var_1, var_2, var_3) {
  if(isDefined(self.lightreaction_requesttime) && self.lightreaction_requesttime >= gettime() - 1000) {
    var_4 = getbasearchetype();

    if(isspeedwithincqbrange(var_4, self aigetdesiredspeed()))
      return 1;
  }

  return 0;
}

chooselightreactionanim(var_0, var_1, var_2) {
  var_3 = "_encstr_A5C407E1658D3339B3";

  if(!isDefined(self.lightreaction_lightorigin))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);

  if(isDefined(self.covernode)) {
    var_4 = anglestoright(self.covernode.angles);
    var_5 = anglesToForward(self.covernode.angles);
    var_6 = vectorNormalize(self.lightreaction_lightorigin - self.origin);
  } else {
    var_4 = anglestoright(self.angles);
    var_5 = anglesToForward(self.angles);
    var_6 = vectorNormalize(self.lightreaction_lightorigin - self.origin);
  }

  var_7 = vectordot(var_4, var_6) >= 0;
  var_8 = vectordot(var_5, var_6);

  if(var_8 >= 0.866)
    var_3 = "_encstr_A5C407E1658D3339B3";
  else if(var_7)
    var_3 = "_encstr_8253060E2B5FE330";
  else
    var_3 = "_encstr_A5AD056A019C63";

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

isshocked(var_0, var_1, var_2, var_3) {
  if(isDefined(self.damagemod) && self.damagemod == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 0;

  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("_encstr_8B1804DF2043")))
    return 1;

  if(self.unittype == "_encstr_9B07038DB1" || self.unittype == "_encstr_AF07035938") {
    if(scripts\common\utility::isdamageweapon(getcompleteweaponname("_encstr_AAE30A689B7FB1F6A2E3B3AF")) && scripts\common\utility::isweaponepic(self.damageweapon))
      return 1;
  }

  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("_encstr_850D0D636FC718B0B41D60F8408D60")) && self.damagemod != "_encstr_8DED0A21C79B660BC7588981" && self.health <= 0)
    return 1;

  return 0;
}

getdamagedirstring() {
  var_0 = -1 * self.damagedir;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);

  if(var_2 > 0.707)
    return "_encstr_AA5606FD1AF05085";
  else if(var_2 < -0.707)
    return "_encstr_B69B0589C236B6";
  else {
    var_3 = vectorcross(var_1, var_0);

    if(var_3[2] > 0)
      return "_encstr_A5AD056A019C63";
    else
      return "_encstr_8253060E2B5FE330";
  }
}

gethumandamagedirstring() {
  var_0 = -1 * self.damagedir;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);

  if(var_2 < -0.5)
    return 1;

  return 0;
}

playanimandusegoalweight(var_0, var_1, var_2) {
  childthread setuseanimgoalweight(var_1, 0.2);
  scripts\asm\asm::asm_playanimstate(var_0, var_1);
}

animscriptedaction_terminate(var_0, var_1, var_2) {
  self orientmode("_encstr_91440EF5D7AA1B467F70DAB9531A9ED1", self.angles);
  self.gunposeoverride_internal = undefined;

  if(isDefined(self.lookatatrnode)) {
    var_3 = scripts\asm\asm::asm_getheadlookknobifexists();

    if(isDefined(var_3)) {
      self clearanim(var_3, 0.2, self.lookatatrnode);
      self.lookatatrnode = undefined;
    }
  }
}

animsriptedactioncivilian_terminate(var_0, var_1, var_2) {
  if(isDefined(self.lookatatrnode)) {
    var_3 = scripts\asm\asm::asm_getheadlookknobifexists();

    if(isDefined(var_3)) {
      self clearanim(var_3, 0.2, self.lookatatrnode);
      self.lookatatrnode = undefined;
    }
  }
}

cleanupanimscriptedheadlook() {
  self.ht_on = undefined;
  scripts\common\utility::lookatentity();
}

animscriptedstartup(var_0, var_1, var_2) {
  self.ht_on = undefined;
  self stoplookat();
}

animscriptedcleanup(var_0, var_1, var_2) {
  cleanupanimscriptedheadlook();
}

animscriptedaction_cleanup(var_0, var_1, var_2) {
  cleanupanimscriptedheadlook();
}

disabledefaultfacialanims(var_0) {
  if(!isDefined(self.headknob))
    self.headknob = scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_81CC0586952C91"));

  if(!isDefined(var_0) || var_0) {
    setfacialstate("_encstr_B2DB092B5F87A3AF89D999");

    if(isai(self))
      self setfacialindex("_encstr_8BBA05185F8B99");
    else
      setfacialindexfornonai("_encstr_8BBA05185F8B99");
  } else
    clearfacialstate("_encstr_B2DB092B5F87A3AF89D999");
}

setfacialindexfornonai(var_0) {
  var_1 = [];
  var_1["_encstr_8BBA05185F8B99"] = 0;
  var_1["_encstr_A7C5056BD931D1"] = 1;
  var_1["_encstr_8719040B4BB5"] = 2;
  var_1["_encstr_B4190493D573"] = 3;
  var_1["_encstr_B60D055B0E3128"] = 4;
  var_1["_encstr_AD75063D571AE108"] = 5;
  var_1["_encstr_8EEF0529A1A5E0"] = 6;
  var_1["_encstr_8B6906A3BEB7A3A0"] = 7;
  var_1["_encstr_BD7606AB19E0971B"] = 8;
  var_1["_encstr_A7B707FBA17F1B8FF8"] = 9;
  var_1["_encstr_B4CD06C2B93BE42F"] = 10;
  var_1["_encstr_93330A0A51C6FF9FA053ECC8"] = 11;
  self setcustomnodegameparameter("_encstr_95FD090BCD4B5BA35ADA56", self getentitynumber());
  self setcustomnodegameparameterbyte("_encstr_88AB0C574E5EDA33E8CBA3AB2558", var_1[var_0]);
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_81CC0586952C91");

  if(var_0 == "_encstr_8BBA05185F8B99")
    self clearanim(scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", var_2), 0.2);
  else
    self setanim(scripts\asm\asm::asm_getxanim("_encstr_999306BA95FACD6B", var_2), 1, 0.2, 1);
}

setfacialstate(var_0) {
  self.facialstate = var_0;
}

clearfacialstate(var_0) {
  self.facialstate = "_encstr_8219049FF2FA";

  if(!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim)
    scripts\asm\asm::asm_restorefacialanim();
}

isfacialstateallowed(var_0) {
  if(!isai(self) && (!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim))
    return 0;

  if(!isDefined(self.facialstate))
    self.facialstate = "_encstr_8219049FF2FA";

  var_1 = [];
  var_1["_encstr_8219049FF2FA"] = 0;
  var_1["_encstr_92A9077D73BCC33072"] = 1;
  var_1["_encstr_B2DB092B5F87A3AF89D999"] = 2;

  if(var_1[var_0] >= var_1[self.facialstate])
    return 1;

  return 0;
}

getshootfrompos() {
  if(scripts\engine\utility::actor_is3d() || istrue(self.useeyetoshoot))
    return self getEye();
  else {
    if(isDefined(self.usemuzzlesideoffset) && self.usemuzzlesideoffset) {
      var_0 = self getmuzzlesideoffsetpos();

      if(isDefined(self.usemuzzleheightoffset))
        return var_0;

      return (var_0[0], var_0[1], self getEye()[2]);
    }

    if(isai(self))
      return self getapproxeyepos();
    else
      return (self.origin[0], self.origin[1], self getEye()[2]);
  }
}

decrementbulletsinclip() {
  if(self.bulletsinclip)
    self.bulletsinclip--;
}

grenadelauncherfirerate() {
  return randomfloatrange(5, 8);
}

shotgunfirerate() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_pump_action_shotgun())
    return 1.0;

  if(_encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::usingautomaticweapon())
    return _encstr_8B451CFBA1F677CA7807C791254855A69C99525388403BC42821CE9FF730::autoshootanimrate() * 0.7;

  return 0.4;
}

getsniperburstdelaytime() {
  if(isPlayer(self.enemy))
    return randomfloatrange(self.enemy.gs.min_sniper_burst_delay_time, self.enemy.gs.max_sniper_burst_delay_time);
  else
    return randomfloatrange(anim.min_sniper_burst_delay_time, anim.max_sniper_burst_delay_time);
}

melee_checktimer(var_0, var_1) {
  if(isDefined(self.meleeignoretimer) && self.meleeignoretimer)
    return 1;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1) {
    if(!isDefined(anim.meleechargeplayertimers))
      return 1;

    if(!isDefined(anim.meleechargeplayertimers[var_0]))
      return 1;

    return gettime() > anim.meleechargeplayertimers[var_0];
  } else {
    if(!isDefined(anim.meleechargetimers))
      return 1;

    if(!isDefined(anim.meleechargetimers[var_0]))
      return 1;

    return gettime() > anim.meleechargetimers[var_0];
  }
}

setup_run_n_gun() {
  self.maxrunngunangle = 180;
}

setupsoldierdefaults() {
  self.a = spawnStruct();
  self.a.laseron = 0;
  self.primaryweapon = self.weapon;
  self.currentpose = "_encstr_A5AD069B231F0BAF";
  self.a.movement = "_encstr_B419059BD17BE0";
  self.a.special = "_encstr_8BBA05185F8B99";
  self.a.gunhand = "_encstr_8BBA05185F8B99";
  self.dropweapon = 1;
  self.minexposedgrenadedist = 750;
  self.a.needstorechamber = 0;
  self.a.combatendtime = gettime();
  self.a.lastenemytime = gettime();
  self.a.suppressingenemy = 0;
  self.a.disablelongdeath = !self isbadguy();
  self.a.paintime = 0;
  self.a.lastshoottime = 0;
  self.a.lastgrenadethrowtime = 0;
  self.a.nextgrenadetrytime = 0;
  self.a.reacttobulletchance = 0.8;
  self._animactive = 0;
  self._lastanimtime = 0;
  self.baseaccuracy = 1;
  self.a.misstime = 0;
  self.a.nodeath = 0;
  self.a.misstime = 0;
  self.a.misstimedebounce = 0;
  self.a.disablepain = 0;
  self.accuracystationarymod = 1;
  self.battlechatter = spawnStruct();
  self.chatinitialized = 0;
  self.sightpostime = 0;
  self.sightposleft = 1;
  self.needrecalculategoodshootpos = 1;
  self.defaultturnthreshold = 55;
  setfacialstate("_encstr_8219049FF2FA");
  self.currentweaponpose = "_encstr_A313099AFD88E18280CFCE";
  self.lookandaimdownpathdist = 120;
  self.combattraverseenabled = 0;
  self.speedscalemult = 0.95 + randomfloat(0.15);

  if(!isDefined(self.script_forcegrenade))
    self.script_forcegrenade = 0;

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.suppressed = 0;
  self.suppressedtime = 0;

  if(self.team == "_encstr_9A8507BA4040188D08")
    self.suppressionthreshold = 0.5;
  else
    self.suppressionthreshold = 0.0;

  if(self.team == "_encstr_9A8507BA4040188D08")
    self.randomgrenaderange = 0;
  else
    self.randomgrenaderange = 256;

  self.ammocheatinterval = 8000;
  self.ammocheattime = 0;
  setup_run_n_gun();
}

getspeedmatchanimrate(var_0, var_1, var_2) {
  var_3 = length(self.velocity);

  if(var_3 < 1)
    return 1;

  var_4 = length(getmovedelta(var_0, var_1, var_2));

  if(var_4 < 1)
    return 1;

  var_5 = getanimlength(var_0) * (var_2 - var_1);
  var_6 = var_4 / var_5;
  return var_3 / var_6;
}

isentasoldier() {
  return self.unittype == "_encstr_958C08CDDBD8325A959C" || self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
}

isentnotabomber() {
  return self.asmname != "_encstr_8EF60E63FBE3D70440A312175B98CF6B" && self.asmname != "_encstr_BE4111D745743093B34A59E0D2735D7001AB59";
}

demeanorhasblendspace() {
  var_0 = scripts\asm\asm::asm_getdemeanor();
  return var_0 == "_encstr_AA7C07466F9DA30713";
}

isfixednodeinbadplaceandshouldcrouch() {
  if(self.fixednode && !isDefined(self.node) && isDefined(self.color_node) && self isnodeinbadplace(self.color_node) && self.color_node doesnodeallowstance("_encstr_B13D076BED70539F23"))
    return 1;

  return 0;
}

gethighestallowedstance() {
  var_0 = undefined;
  var_1 = 1;
  var_2 = 1;
  var_3 = 1;

  if(isDefined(self.node) && isatcovernode()) {
    var_1 = self.node doesnodeallowstance("_encstr_A5AD069B231F0BAF");
    var_2 = self.node doesnodeallowstance("_encstr_B13D076BED70539F23");
    var_3 = self.node doesnodeallowstance("_encstr_922406F1A6FD5E05");
  } else if(!scripts\asm\asm_bb::bb_moverequested() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
    var_4 = self isstanceallowed("_encstr_B13D076BED70539F23");

    if(var_4 && isfixednodeinbadplaceandshouldcrouch())
      return "_encstr_B13D076BED70539F23";

    var_5 = distancesquared(self.origin, self._blackboard.shootparams_pos);

    if(var_5 > 262144 && var_4 && !scripts\engine\utility::actor_is3d() && !_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm()) {
      var_4 = 1;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 16 && !self.node doesnodeallowstance("_encstr_B13D076BED70539F23"))
        var_4 = abs(angleclamp180(self.node.angles[1] - self.angles[1])) > 90;

      if(var_4) {
        if(sighttracepassed(self.origin + (0, 0, 32), self._blackboard.shootparams_pos, 0, undefined))
          return "_encstr_B13D076BED70539F23";
      }
    }
  }

  for(;;) {
    if(self isstanceallowed("_encstr_A5AD069B231F0BAF") && var_1)
      return "_encstr_A5AD069B231F0BAF";

    if(self isstanceallowed("_encstr_B13D076BED70539F23") && var_2)
      return "_encstr_B13D076BED70539F23";

    if(self isstanceallowed("_encstr_922406F1A6FD5E05") && var_3)
      return "_encstr_922406F1A6FD5E05";

    if(!var_1 || !var_2 || !var_3) {
      var_1 = 1;
      var_2 = 1;
      var_3 = 1;
      continue;
    }

    break;
  }

  return "_encstr_B13D076BED70539F23";
}

determinerequestedstance() {
  var_0 = gethighestallowedstance();
  var_1 = scripts\asm\asm_bb::bb_getrequestedstance();
  var_2 = [];
  var_2["_encstr_922406F1A6FD5E05"] = 0;
  var_2["_encstr_B13D076BED70539F23"] = 1;
  var_2["_encstr_A5AD069B231F0BAF"] = 2;
  var_3 = scripts\aitypes\bt_util::bt_getdemeanor();

  if(isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.origin) > 1)
    var_1 = "_encstr_A5AD069B231F0BAF";

  if(self._blackboard.bgrenadereturnthrow)
    var_1 = "_encstr_A5AD069B231F0BAF";

  if(!isDefined(var_0))
    var_0 = var_1;

  if(var_3 == "_encstr_914B078DB09BAB0BB1" || var_3 == "_encstr_8AEE0B360BE6578563AFCEBACD")
    var_1 = "_encstr_A5AD069B231F0BAF";
  else if(var_0 == "_encstr_922406F1A6FD5E05" && self.unittype == "_encstr_9B07038DB1")
    var_1 = "_encstr_B13D076BED70539F23";
  else if(var_2[var_0] < var_2[var_1])
    var_1 = var_0;
  else if(var_1 == "_encstr_922406F1A6FD5E05" && var_0 != var_1)
    var_1 = var_0;
  else if(var_1 == "_encstr_B13D076BED70539F23" && var_2[var_0] > var_2["_encstr_B13D076BED70539F23"]) {
    if(scripts\asm\asm_bb::bb_isinbadcrouchspot())
      var_1 = "_encstr_A5AD069B231F0BAF";
  }

  return var_1;
}

mapangleindextonumpad(var_0) {
  var_1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var_1[var_0];
}

toggle_poiauto(var_0, var_1, var_2, var_3, var_4) {
  if(var_0) {
    if(!isDefined(self.poiauto)) {
      poiauto_init(var_1, var_2, var_3, var_4);
      thread poiauto_think();
      scripts\common\ai::set_gunpose("_encstr_B2650840FBDB7F1188A1");
    }
  } else {
    self notify("_encstr_84D8107308EA1A5B6D706659873029C98008");
    self.poiauto = undefined;
    scripts\common\ai::set_gunpose("_encstr_B6DA0A585D47F6B52C1D961B");
    self stoplookat();
  }
}

set_poiauto_constraints(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.poiauto.og_yawmax))
    self.poiauto.og_yawmax = self.poiauto.yawmax;

  if(!isDefined(self.poiauto.og_yawmin))
    self.poiauto.og_yawmin = self.poiauto.yawmin;

  if(!isDefined(self.poiauto.og_pitchmin))
    self.poiauto.og_pitchmin = self.poiauto.pitchmin;

  if(!isDefined(self.poiauto.og_pitchmax))
    self.poiauto.og_pitchmax = self.poiauto.pitchmax;

  self.poiauto.yawmax = var_0;
  self.poiauto.yawmin = var_1;
  self.poiauto.pitchmin = var_2;
  self.poiauto.pitchmax = var_3;
}

reset_poiauto_constraints() {
  self.poiauto.yawmax = self.poiauto.og_yawmax;
  self.poiauto.yawmin = self.poiauto.og_yawmin;
  self.poiauto.pitchmin = self.poiauto.og_pitchmin;
  self.poiauto.pitchmax = self.poiauto.og_pitchmax;
}

toggle_poi(var_0, var_1) {
  self.currentpoi = undefined;
  self.nextpoi = undefined;
  self.doingpoi = var_0;
  self.disablelookdownpath = var_0;
  self.cqb_point_of_interest = undefined;

  if(!var_0) {
    level.poi_activeai = scripts\engine\utility::array_remove(level.poi_activeai, self);
    self.turnrate = scripts\engine\utility::ter_op(isDefined(self.poi_oldturnrate), self.poi_oldturnrate, self.turnrate);
    self.gunadditiveoverride = undefined;
    self.disablelookdownpath = undefined;
    self._blackboard.forcestrafe = 0;
    self.gunposeoverride = undefined;
    self stoplookat();
  } else {
    var_2 = self aigetdesiredspeed();
    var_3 = getbasearchetype();
    var_4 = getnearestspeedthresholdname(var_3, "_encstr_8F7905C4AEC319");
    self aisetdesiredspeed(min(var_2, var_4));

    if(!isDefined(level.poi_activeai))
      level.poi_activeai = [];

    level.poi_activeai[level.poi_activeai.size] = self;

    if(isDefined(level.fnfindcqbpointsofinterest) && !istrue(level.alreadyfindingpoi)) {
      level thread[[level.fnfindcqbpointsofinterest]]();
      level.alreadyfindingpoi = 1;
    }

    self.poi_oldturnrate = self.turnrate;
    self.turnrate = 0.25;
    self.leftaimlimit = 90;
    self.rightaimlimit = -90;
    self.poi_firstpoint = var_1;
    self.gunposeoverride = "_encstr_B2650840FBDB7F1188A1";
  }
}

shouldinitiallyattackfromexposed(var_0) {
  if(!isDefined(var_0))
    var_0 = self.node;

  if(isDefined(self._blackboard.shufflenode))
    return 0;

  if(isDefined(scripts\asm\asm_bb::bb_getcovernode()))
    return 0;

  if(isDefined(var_0) && (var_0.type == "_encstr_8AD80E1ABD376CCAB0C6086A3A2CB9C8" || var_0.type == "_encstr_9A520FAD2525079A4E3292270DBF5B7A9C")) {
    var_1 = vectorNormalize(var_0.origin - self.origin);
    var_2 = generateaxisanglesfromforwardvector(var_1, self.angles);
    var_3 = var_0.angles[1];
    var_4 = angleclamp180(var_3 - var_2[1]);
    var_5 = getangleindex(var_4, 22.5);

    if(var_5 == 0 || var_5 == 1 || var_5 == 7 || var_5 == 8) {
      self._blackboard.shouldinitiallyattackfromexposed = 1;
      return 1;
    }
  }

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 302500 && self.bulletsinclip > 0) {
    if(!isPlayer(self.enemy) && !isai(self.enemy))
      return 0;

    if(isDefined(self._blackboard.shouldinitiallyattackfromexposedtime) && self._blackboard.shouldinitiallyattackfromexposedtime > gettime())
      return self._blackboard.shouldinitiallyattackfromexposed;

    if(isai(self.enemy) && !isbot(self.enemy))
      var_6 = self.enemy getapproxeyepos();
    else
      var_6 = self.enemy getEye();

    var_7 = undefined;

    if(isDefined(var_0)) {
      var_7 = var_0.origin + (0, 0, 56);
      self._blackboard.shouldinitiallyattackfromexposed = sighttracepassed(var_7, var_6, 0, undefined);
    } else if(istrue(self.brjugg_watchstartnotify)) {
      var_8 = 0;

      if(isDefined(self.pathgoalpos)) {
        if(issentient(self.enemy))
          var_8 = enablegroundwarspawnlogic(self.pathgoalpos, self.enemy);
        else
          var_8 = enablegroundwarspawnlogic(self.pathgoalpos, self.enemy.origin);
      } else if(issentient(self.enemy))
        var_8 = self hastacvis(self.enemy);
      else
        var_8 = enablegroundwarspawnlogic(self.origin, self.enemy.origin);

      self._blackboard.shouldinitiallyattackfromexposed = var_8;
    } else
      return 0;

    self._blackboard.shouldinitiallyattackfromexposedtime = gettime() + 1000;
    return self._blackboard.shouldinitiallyattackfromexposed;
  }

  self._blackboard.shouldinitiallyattackfromexposed = 0;
  return 0;
}

cover_canattackfromexposed(var_0, var_1) {
  if(!isPlayer(self.enemy) && !isai(self.enemy))
    return 1;

  if(cover_canattackfromexposedcached())
    return cover_canattackfromexposedgetcache();

  if(!isDefined(var_1))
    var_1 = self.covernode;

  if(!isDefined(var_1))
    var_1 = self.node;

  if(!isDefined(var_1))
    return 0;

  var_2 = gethighestallowedstance();
  var_3 = 56;

  if(var_2 != "_encstr_A5AD069B231F0BAF")
    var_3 = 32;

  var_4 = var_1.origin + (0, 0, var_3);

  if(!isDefined(var_0)) {
    if(isai(self.enemy) && !isbot(self.enemy))
      var_0 = self.enemy getapproxeyepos();
    else
      var_0 = self.enemy getEye();
  }

  var_5 = 1000;
  self._blackboard.canattackfromexposed = sighttracepassed(var_4, var_0, 0, undefined);
  self._blackboard.canattackfromexposedtime = gettime() + var_5;
  return self._blackboard.canattackfromexposed;
}

cover_canattackfromexposedcached() {
  return isDefined(self._blackboard.canattackfromexposedtime) && self._blackboard.canattackfromexposedtime > gettime();
}

cover_canattackfromexposedgetcache() {
  return self._blackboard.canattackfromexposed;
}

iscoverinvalidagainstenemy(var_0) {
  if(!isDefined(var_0))
    var_1 = iscovervalid();
  else
    var_1 = iscovernodevalid(var_0);

  return !var_1 && !fixednodeshouldsticktocover(var_0) && cover_canattackfromexposed(undefined, var_0);
}

fixednodeshouldsticktocover(var_0) {
  if(!isDefined(var_0))
    var_0 = self.node;

  if(!self.fixednode)
    return 0;

  if(isDefined(self.enemy.node) && !nodesvisible(var_0, self.enemy.node))
    return 1;

  if(!self seerecently(self.enemy, 8))
    return 1;

  if(scripts\engine\utility::actor_is3d())
    return 1;

  if(distancesquared(var_0.origin, self.enemy.origin) > 4096.0) {
    if(!isDefined(self._blackboard.fixedshouldsticktocovertime) || self._blackboard.fixedshouldsticktocovertime < gettime()) {
      var_1 = (0, 0, 50);
      var_2 = vectorNormalize(self.enemy.origin - var_0.origin);
      var_3 = var_0.origin + var_1;
      var_4 = var_3 + var_2 * 64.0;
      self._blackboard.fixedshouldsticktocovertime = gettime() + 1050;
      self._blackboard.fixedshouldsticktocovercached = !scripts\engine\trace::_bullet_trace_passed(var_3, var_4, 0, self);
    }

    return self._blackboard.fixedshouldsticktocovercached;
  }

  return 0;
}

iscovernodevalid(var_0) {
  return istrue(self.ignorecovervalidity) || self iscovervalidagainstenemy(var_0);
}

iscovervalid() {
  return istrue(self.ignorecovervalidity) || self iscovervalidagainstenemy();
}

addoverridearchetypepriority(var_0) {
  level.archetypeoverridepriorities[var_0] = level.archetypeoverridepriorities.size;
}

setupoverridearchetypeprioritytable() {
  if(isDefined(level.archetypeoverridepriorities)) {
    return;
  }
  level.archetypeoverridepriorities = [];
  addoverridearchetypepriority("_encstr_A29B05E9400E5D");
  addoverridearchetypepriority("_encstr_8B1608EC43B8D647A113");
  addoverridearchetypepriority("_encstr_AC20072B9FA9487832");
  addoverridearchetypepriority("_encstr_ACF60EB7F743CD70EC51E0B885C49886");
  addoverridearchetypepriority("_encstr_9A50080BA7292FFA0DA2");
  addoverridearchetypepriority("_encstr_ACFD0B6A08AB2DBF015E092875");
}

setoverridearchetype(var_0, var_1, var_2) {
  setupoverridearchetypeprioritytable();
  var_3 = level.archetypeoverridepriorities[var_0];

  if(!isDefined(self.archetypeoverrides))
    setbasearchetype(self.asm.archetype);

  clearoverridearchetype(var_0, 1);
  var_4 = spawnStruct();
  var_4.archetypepriority = var_3;
  var_4.archetype = var_1;
  self.archetypeoverrides = scripts\engine\utility::array_add(self.archetypeoverrides, var_4);
  pickoverridearchetype(var_2);
}

clearoverridearchetype(var_0, var_1, var_2) {
  if(self.archetypeoverrides.size == 0) {
    return;
  }
  var_3 = level.archetypeoverridepriorities[var_0];
  var_4 = [];

  foreach(var_6 in self.archetypeoverrides) {
    if(var_6.archetypepriority != var_3)
      var_4[var_4.size] = var_6;
  }

  self.archetypeoverrides = var_4;

  if(!istrue(var_1))
    pickoverridearchetype(var_2);
}

pickoverridearchetype(var_0) {
  self.changearchetype = undefined;
  var_1 = undefined;

  foreach(var_3 in self.archetypeoverrides) {
    if(!isDefined(var_1) || var_3.archetypepriority > var_1.archetypepriority)
      var_1 = var_3;
  }

  if(self.asm.archetype == var_1.archetype) {
    return;
  }
  if(istrue(var_0)) {
    self.animationarchetype = var_1.archetype;
    self.asm.archetype = var_1.archetype;
    self setanimset(var_1.archetype);
  } else
    self.changearchetype = var_1.archetype;
}

findoverridearchetype(var_0) {
  var_1 = level.archetypeoverridepriorities[var_0];

  foreach(var_3 in self.archetypeoverrides) {
    if(var_3.archetypepriority == var_1)
      return var_3.archetype;
  }

  return undefined;
}

getbasearchetype() {
  if(!isDefined(self.archetypeoverrides))
    setbasearchetype(self.asm.archetype);

  return findoverridearchetype("_encstr_A29B05E9400E5D");
}

setbasearchetype(var_0) {
  if(!isDefined(self.archetypeoverrides)) {
    self.archetypeoverrides = [];
    setoverridearchetype("_encstr_8B1608EC43B8D647A113", self.asm.archetype);
  }

  setoverridearchetype("_encstr_A29B05E9400E5D", var_0);
  self.basearchetype = var_0;
}

poiauto_init(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 15;

  if(!isDefined(var_1))
    var_1 = 35;

  if(!isDefined(var_2))
    var_2 = -20;

  if(!isDefined(var_3))
    var_3 = 0;

  self.poiauto = spawnStruct();
  self.poiauto.yawmax = var_1;
  self.poiauto.yawmin = var_0;
  self.poiauto.pitchmin = var_2;
  self.poiauto.pitchmax = var_3;
}

poiauto_think() {
  self endon("_encstr_84D8107308EA1A5B6D706659873029C98008");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 500;
  var_1 = 0;
  var_2 = 0;
  var_3 = gettime() + 30000;

  if(!isDefined(self.poiauto))
    poiauto_init();

  for(;;) {
    var_4 = 0;

    if(var_3 <= gettime()) {
      self.poiauto_angles = (0, 0, 0);

      if(var_3 == var_1)
        var_4 = 1;
    }

    if(var_1 <= gettime()) {
      var_3 = gettime() + int(randomfloatrange(0.8, 1.8) * 1000);
      var_2 = gettime();
      poiauto_setnewaimangle(var_4);
      var_5 = var_0 - gettime();
      var_6 = var_3 - gettime();

      if(abs(var_6 - var_5) >= 550 && scripts\engine\utility::cointoss())
        var_1 = var_3;
      else if(var_5 > 3000)
        var_1 = gettime() + randomintrange(2000, 3000);
      else
        var_1 = gettime() + var_5 + 550 + randomintrange(1000, 2000);
    }

    waitframe();
  }
}

poiauto_relativeangletopos(var_0) {
  var_1 = anglesToForward(var_0);
  var_2 = rotatevector(var_1, self.angles);
  var_3 = self getapproxeyepos();
  var_4 = var_3 + var_2 * 128.0;
  return var_4;
}

poiauto_glancerandom() {
  var_0 = randomfloatrange(-45, 45);
  var_1 = randomfloatrange(-20, 20);
  var_2 = poiauto_relativeangletopos((var_1, var_0, 0));
  self.poiauto.glancing = 1;
  thread poiauto_glanceend();
  self glanceatpos(var_2);
}

poiauto_glanceend() {
  self notify("_encstr_BE491238ED4B0BD5A37BFA766358B9C6B2B2CD8C");
  self endon("_encstr_BE491238ED4B0BD5A37BFA766358B9C6B2B2CD8C");
  wait 0.55;
  self.poiauto.glancing = 0;
}

poiauto_isglancing() {
  return istrue(self.poiauto.glancing);
}

poiauto_setnewaimangle(var_0) {
  if(var_0) {
    var_1 = randomfloatrange(self.poiauto_angles[1] + 5, self.poiauto_angles[1] + 10);
    var_2 = randomfloatrange(5, 10);

    if(scripts\engine\utility::cointoss())
      var_2 = var_2 * -1;

    var_2 = self.poiauto_angles[0] + var_2;
  } else {
    var_3 = self.poiauto;
    var_1 = randomfloatrange(var_3.yawmin, var_3.yawmax);
    var_2 = randomfloatrange(var_3.pitchmin, var_3.pitchmax);
  }

  if(scripts\engine\utility::cointoss())
    var_1 = var_1 * -1;

  self.poiauto_nextangles = (var_2, var_1, 0);
  self.poiauto_nextaimtime = randomintrange(100, 300) + gettime();
}

preventrecentanimindex(var_0, var_1, var_2) {
  var_3 = self.asm.archetype;

  if(isDefined(self.animationarchetype))
    var_3 = self.animationarchetype;

  if(!isDefined(anim.recentindices))
    anim.recentindices = [];

  var_4 = gettime();
  var_5 = 1000;
  var_6 = 2;
  var_7 = 0;
  var_8 = 1;
  var_9 = var_3 + var_0;

  if(isDefined(anim.recentindices[var_9])) {
    var_10 = anim.recentindices[var_9][var_2];

    if(var_4 - var_10[var_7] <= var_5 && var_10[var_8] >= var_6) {
      var_11 = scripts\asm\asm::asm_getallanimindicesforalias(var_0, var_1);
      var_12 = var_11[0];
      var_13 = var_11[var_11.size - 1];

      for(var_14 = 1; var_14 < var_11.size; var_14++) {
        var_15 = scripts\engine\math::wrap(var_12, var_13 - 1, var_2 + var_14);

        if(anim.recentindices[var_9][var_15][var_8] < var_6) {
          var_2 = var_15;
          var_10 = anim.recentindices[var_9][var_2];
          break;
        }
      }
    }

    if(var_4 - var_10[var_7] > var_5) {
      var_10[var_7] = var_4;
      var_10[var_8] = 1;
    } else
      var_10[var_8] = var_10[var_8] + 1;

    anim.recentindices[var_9][var_2] = var_10;
  } else {
    anim.recentindices[var_9] = [];
    var_16 = scripts\asm\asm::asm_getallanimsforstate(var_0);

    for(var_14 = 0; var_14 < var_16.size; var_14++)
      anim.recentindices[var_9][var_14] = [0, 0];

    anim.recentindices[var_9][var_2][var_7] = var_4;
    anim.recentindices[var_9][var_2][var_8] = 1;
  }

  return var_2;
}

intro_addplayer(var_0, var_1, var_2, var_3) {
  if(isDefined(self.intro_heli_animate_player))
    return self[[self.intro_heli_animate_player]](var_0, var_1, var_2, var_3);

  return 0;
}