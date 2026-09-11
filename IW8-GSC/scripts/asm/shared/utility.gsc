/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shared\utility.gsc
***********************************************/

function set_default_aim_limits(var0) {
  if(isDefined(var0)) {
    self setdefaultaimlimits(var0);
  } else {
    self setdefaultaimlimits();
  }

  if(scripts\engine\utility::actor_is3d()) {
    self.upaimlimit = -65;
    self.downaimlimit = 65;
    self.rightaimlimit = -56;
    self.leftaimlimit = 56;
    return;
  }
}

function set_aim_and_turn_limits() {
  set_default_aim_limits();

  if(self.currentpose == "stand" && !scripts\engine\utility::actor_is3d()) {
    self.upaimlimit = -45;
    self.downaimlimit = 80;

    if(self.unittype == "juggernaut") {
      self.upaimlimit = -80;
    }
  } else if(self.currentpose == "prone") {
    self.rightaimlimit = -45;
    self.leftaimlimit = 45;
  }

  self.turnthreshold = self.defaultturnthreshold;
  self.pitchturnthreshold = self.defaultpitchturnthreshold;
}

function chooseanimshoot(var0, var1, var2) {
  var3 = var2;
  var4 = self._blackboard.shootstate + "_" + var3;

  if(isDefined(self._blackboard.shootstate) && scripts\asm\asm::asm_hasalias(var1, var4)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, var4);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var2);
}

function choosedemeanoranimwithoverride(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var3, var2)) {
    var4 = scripts\asm\asm::asm_getdemeanoranimoverride(var3, var2);

    if(isarray(var4)) {
      return var4[randomint(var4.size)];
    }

    return var4;
  }

  if(!scripts\asm\asm::asm_hasalias(var2, var4)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var2, "default");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var2, var4);
}

function choosedemeanoranimwithoverridevariants(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var3, var2)) {
    var4 = scripts\asm\asm::asm_getdemeanoranimoverride(var3, var2);

    if(isarray(var4)) {
      return var4[randomint(var4.size)];
    }

    return var4;
  }

  if(!scripts\asm\asm::asm_hasalias(var2, var4)) {
    var5 = [];
    GscBinSkip0(0x2e, 0, scripts\asm\asm::asm_lookupanimfromalias(var2, "trans_to_one_hand_run"));
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var3, var5);
}

function chooseanim_exposedreload(var0, var1, var2) {
  var2 = "";

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over")) {
      var2 += "_high";
    }
  }

  return chooseanim_weaponclassprepended(var0, var1, var2);
}

function chooseanim_weaponswitch(var0, var1, var2) {
  if(weaponclass(self.weapon) == "rocketlauncher" && scripts\asm\asm::asm_hasalias(var1, "drop_rpg")) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "drop_rpg");
  }

  var3 = scripts\asm\asm_bb::bb_getrequestedweapon();

  if(!scripts\asm\asm::asm_hasalias(var1, var3)) {
    var3 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function isspeedwithincqbrange(var0, var1) {
  if(!getanimspeedthreshold(var0, "fast") || !getanimspeedthreshold(var0, "jog")) {
    return false;
  }

  return var1 < getcoveranglelimits(var0, "fast", "jog", 0.1);
}

function isspeedwithinsprintrange(var0, var1) {
  return var1 > getcoveranglelimits(var0, "run", "sprint", 0.1);
}

function isspeedwithincombatrange(var0, var1) {
  if(getanimspeedthreshold(var0, "fast") && getanimspeedthreshold(var0, "jog") && var1 < getcoveranglelimits(var0, "fast", "jog", 0.9)) {
    return false;
  }

  if(getanimspeedthreshold(var0, "run") && getanimspeedthreshold(var0, "sprint") && var1 > getcoveranglelimits(var0, "run", "sprint", 0.1)) {
    return false;
  }

  return true;
}

function isspeedwithincombatrangeextended(var0, var1) {
  if(getanimspeedthreshold(var0, "fast") && getanimspeedthreshold(var0, "jog") && var1 < getcoveranglelimits(var0, "fast", "jog", 0.8)) {
    return false;
  }

  if(getanimspeedthreshold(var0, "run") && getanimspeedthreshold(var0, "sprint") && var1 > getcoveranglelimits(var0, "run", "sprint", 0.3)) {
    return false;
  }

  return true;
}

function movetypeisnotcasual(var0, var1, var2, var3) {
  var4 = scripts\asm\asm::asm_getdemeanor();
  return var4 != "casual" && var4 != "casual_gun";
}

function getnodeforwardyawnodetypelookupoverride(var0, var1) {
  if(isDefined(var0)) {
    switch (var0) {
      case "Cover Left":
        if(var1 == "crouch") {
          return "Cover Left Crouch";
        }

        break;
      case "Cover Right":
        if(var1 == "crouch") {
          return "Cover Right Crouch";
        }

        break;
      case "Conceal Crouch":
      case "Cover Crouch Window":
        return "Cover Crouch";
      case "Conceal Stand":
        return "Cover Stand";
    }
  }

  return undefined;
}

function overridecovercrouchnodetype(var0) {
  if(var0.type == "Cover Crouch" && isDefined(self._blackboard.croucharrivaltype)) {
    return self._blackboard.croucharrivaltype;
  }

  return var0.type;
}

function getnodeoffsetposeoverride(var0, var1, var2) {
  var3 = self.currentpose;

  if(isDefined(var2)) {
    var3 = var2;
  } else if(isnode(var0) && !var0 doesnodeallowstance(var3)) {
    var3 = var0 gethighestnodestance();
  }

  var4 = getnodeforwardyawnodetypelookupoverride(var1, var3);
  return var4;
}

function getnodeyawfromoffsettable(var0, var1, var2) {
  var3 = self.currentpose;

  if(isDefined(var2)) {
    var3 = var2;
  } else if(isnode(var1) && !var1 doesnodeallowstance(var3)) {
    var3 = var1 gethighestnodestance();
  }

  var4 = overridecovercrouchnodetype(var1);
  var5 = getnodeforwardyawnodetypelookupoverride(var4, var3);

  if(isDefined(var5) && isDefined(var0[var5])) {
    return var0[var5];
  }

  if(isDefined(var0[var4])) {
    return var0[var4];
  }

  return undefined;
}

function allowlmgarrival() {
  if(istrue(self.disablelmgmount)) {
    return false;
  }

  var0 = weaponclass(self.weapon) == "mg";

  if(var0) {
    if(!isDefined(self.node) || self.node isnodelmgmountable()) {
      return true;
    }

    return false;
  }

  if(isDefined(self._blackboard.deployedlmgnode) && isDefined(self.node) && self.node == self._blackboard.deployedlmgnode && self.node isnodelmgmountable()) {
    return true;
  }

  return false;
}

function getnodeyawoffset(var0, var1, var2) {
  if(isstruct(var0) || !isDefined(var0.type)) {
    return 0;
  }

  if(istrue(self._blackboard.inlmgstate) || istrue(self.asm.usingaturret)) {
    return 0;
  }

  var3 = overridecovercrouchnodetype(var0);
  var4 = self getnodehideyaw(var0, var3, var1, var2);
  return var4;
}

function getnodeforwardyaw(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = getnodeyawoffset(var0, var1, var2);
  return var0.angles[1] + var3;
}

function getnodeforwardangles(var0, var1) {
  var2 = getnodeyawoffset(var0, var1, 1);
  return combineangles(var0.angles, (0, var2, 0));
}

function getnodeleanyaw(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = var0.type;
  }

  var3 = getnodeoffsetposeoverride(var0, var1, var2);

  if(isDefined(var3)) {
    return self getnodeleanaimyawoffset(var3);
  }

  return self getnodeleanaimyawoffset(var1);
}

function getnodeaimpitchoffset(var0, var1, var2) {
  var3 = undefined;

  if(var2 == "exposed") {
    var3 = anim.nodeexposedpitches[var0];
  } else if(var2 == "lean" || var2 == "leanover") {
    var3 = anim.nodeleanpitches[var0];
  } else if(var2 == "overlean") {
    var3 = anim.nodeoverleanpitches[var0];
  }

  if(isDefined(var3)) {
    var4 = getnodeyawfromoffsettable(var3, var1, undefined);

    if(isDefined(var4)) {
      return var4;
    }
  }

  return 0;
}

function getnodeaimyawoffset(var0, var1, var2) {
  if(var2 == "lean") {
    var3 = overridecovercrouchnodetype(var1);
    return self getnodeleanaimyaw(var1, var3);
  }

  return 0;
}

function nodeiscoverstand3dtype(var0) {
  if(var0.type == "Cover Stand 3D") {
    return !nodeiscoverexposed3dtype(var0);
  }

  return false;
}

function nodeiscoverexposed3dtype(var0) {
  if(var0.type == "Cover Stand 3D") {
    if(isDefined(var0.script_parameters) && var0.script_parameters == "exposed") {
      return true;
    }
  }

  return false;
}

function getnodetypename(var0) {
  if(isDefined(var0)) {
    if(nodeiscoverexposed3dtype(var0)) {
      return "Cover Exposed 3D";
    } else {
      return var0.type;
    }
  }

  return "undefined";
}

function choosestrongdamagedeath(var0, var1, var2) {
  var3 = undefined;

  if(abs(self.damageyaw) > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var3 = "legs";
    } else if(self.damagelocation == "torso_lower") {
      var3 = "torso_lower";
    } else {
      var3 = "default";
    }
  } else if(self.damageyaw < 0) {
    var3 = "right";
  } else {
    var3 = "left";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function isatcovernode() {
  return isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

function setuseanimgoalweight(var0, var1) {
  self endon(var0 + "_finished");
  self.useanimgoalweight = 1;
  thread setuseanimgoalweight_wait(var0);

  if(var1 > 0) {
    wait var1;
  }

  self.useanimgoalweight = 0;
  self notify("StopUseAnimGoalWeight");
}

function setuseanimgoalweight_wait(var0) {
  self notify("StopUseAnimGoalWeight");
  self endon("StopUseAnimGoalWeight");
  self endon("death");
  self endon("entitydeleted");
  self waittill(var0 + "_finished");
  self.useanimgoalweight = 0;
}

function shouldleaveanimScripted(var0, var1, var2, var3) {
  if(scripts\asm\asm_bb::bb_isanimScripted()) {
    return false;
  }

  var4 = var3;

  if(var4) {
    if(self.a.movement == "stop") {
      return false;
    }

    if(!scripts\asm\asm_bb::bb_moverequested()) {
      return false;
    }
  } else if(scripts\asm\asm_bb::bb_moverequested() && self.a.movement != "stop") {
    return false;
  }

  return true;
}

function scriptedcoverposerequestis(var0, var1, var2, var3) {
  var4 = var3;

  if(self.a.coverpose_request == var4) {
    self.a.coverpose_request = undefined;
    return true;
  }

  return false;
}

function scriptedcoverposerequestisDefined(var0, var1, var2, var3) {
  return isDefined(self.a.coverpose_request);
}

function animscriptedaction(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.a.movement = "run";
  self.gunposeoverride_internal = "disable";
  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
}

function randomizepassthroughchildren(var0, var1, var2, var3) {
  var4 = anim.asm[var0].states[var2];

  if(isDefined(var4.transitions)) {
    if(var4.transitions.size == 2) {
      if(scripts\engine\utility::cointoss()) {
        var5 = var4.transitions[0];
        var4.transitions[0] = var4.transitions[1];
        var4.transitions[1] = var5;
      }
    } else {
      var4.transitions = scripts\engine\utility::array_randomize(var4.transitions);
    }
  }

  return true;
}

function blockedbywall(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(isDefined(self._blackboard)) {
    var1 = gettime();

    if(isDefined(self._blackboard.gunblockedbywalltime)) {
      if(var1 - self._blackboard.gunblockedbywalltime < 300) {
        return true;
      }

      self._blackboard.gunblockedbywalltime = undefined;
    }

    if(!var0 && isDefined(self._blackboard.lastblockedbywallchecktime) && var1 - self._blackboard.lastblockedbywallchecktime < 200) {
      return false;
    }

    self._blackboard.lastblockedbywallchecktime = var1;

    if(self isgunblockedbywall()) {
      self._blackboard.gunblockedbywalltime = var1;

      if(isDefined(scripts\asm\asm_bb::bb_getcovernode()) && !isDefined(self._blackboard.initialcovergunblockedbywalltime) && scripts\asm\asm_bb::bb_getrequestedcoverstate() == "exposed") {
        self._blackboard.initialcovergunblockedbywalltime = self._blackboard.gunblockedbywalltime;
      }

      return true;
    } else {
      self._blackboard.initialcovergunblockedbywalltime = undefined;
    }
  }

  return false;
}

function nodeshouldfaceangles(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(var0.angles)) {
    return true;
  }

  if(isstruct(var0)) {
    return false;
  }

  return isDefined(var0.type) && var0.type != "Path" && !scripts\engine\utility::isnodeexposed3d(var0);
}

function choosecrouchorstand(var0, var1) {
  return int(var1.origin[0] + var1.origin[1] + var1.origin[2] + var0 getentitynumber()) % 2;
}

function getwincost(var0, var1) {
  return int(abs(var1[0] + var1[1] + var1[2] + var0 getentitynumber())) % 2;
}

function getarrivalnode() {
  if(istrue(self.leavecasualkiller)) {
    return undefined;
  }

  if(isDefined(self.scriptedarrivalent) && !self btgoalvalid()) {
    return self.scriptedarrivalent;
  }

  if(isDefined(self.node)) {
    return self.node;
  }

  if(isDefined(self.prevnode) && isDefined(self.pathgoalpos) && distance2dsquared(self.prevnode.origin, self.pathgoalpos) < 36) {
    return self.prevnode;
  }

  if(isDefined(self.last_set_goalnode)) {
    return self.last_set_goalnode;
  }

  return self.last_set_goalent;
}

function isarrivaltypecivilian(var0, var1) {
  if(isDefined(self.asm.customdata.arrivalstate)) {
    return (var1 == "Custom");
  }

  if(scripts\asm\asm_bb::bb_smartobjectrequested()) {
    return (var1 == "Exposed");
  }

  var2 = getarrivalnode();

  if(isDefined(var2) && isnode(var2) && var2 iscovermultinode()) {
    var3 = scripts\engine\utility::getbestcovermultinodetype(var2);

    if(isDefined(var3)) {
      var2 setcovermultinodetype(var3);
    }
  }

  if(!isDefined(var2) || !isDefined(var2.type) || var2.type == "struct" || self.combatmode == "no_cover") {
    return (var1 == "Exposed");
  }

  if(isDefined(var2) && var2.type == "Cover Crouch") {
    var4 = getDvar("scr_ai_cover_crouch_type");

    if(var4 != "") {
      return (var1 == var4);
    }

    if(isDefined(self._blackboard.croucharrivaltype)) {
      return (var1 == self._blackboard.croucharrivaltype);
    } else if(isDefined(var2.covercrouchtype)) {
      return (var1 == var2.covercrouchtype);
    }
  }

  var5 = scripts\asm\asm::asm_getdemeanor();
  var6 = (!isnode(var2) || var2 doesnodeallowstance("stand")) && self isstanceallowed("stand");
  var7 = (!isnode(var2) || var2 doesnodeallowstance("crouch")) && self isstanceallowed("crouch") && var5 != "casual" && var5 != "casual_gun";

  switch (var1) {
    case "Exposed":
      if(var2.type != "Path" && var2.type != "Exposed") {
        return 0;
      }

      if(var7 && choosecrouchorstand(self, var2)) {
        return 0;
      }

      return var6;
    case "Exposed Crouch":
      if(var2.type != "Path" && var2.type != "Exposed") {
        return 0;
      }

      if(var6 && !choosecrouchorstand(self, var2)) {
        return 0;
      }

      return var7;
    case "Cover Crouch":
      return (var2.type == "Cover Crouch" || var2.type == "Conceal Crouch" || var2.type == "Cover Crouch Window" || var2.type == "Cover Stand" || var2.type == "Conceal Stand" || var2.type == "Cover Prone" || var2.type == "Conceal Prone");
    case "Cover Left":
      return (var2.type == "Cover Left");
    case "Cover Right":
      return (var2.type == "Cover Right");
    case "Exposed Moving":
      return (var2.type == "Exposed Moving");
  }

  return var1 == var2.type;
}

function isarrivaltype(var0, var1, var2, var3) {
  var4 = var3;

  if(isDefined(self.asm.customdata.arrivalstate)) {
    return (var4 == "Custom");
  }

  if(scripts\asm\asm_bb::bb_smartobjectrequested()) {
    return (var4 == "Exposed");
  }

  var5 = getarrivalnode();

  if(isDefined(var5) && isnode(var5) && var5 iscovermultinode()) {
    var6 = scripts\engine\utility::getbestcovermultinodetype(var5);

    if(isDefined(var6) && var5.type != var6 && var4 == var6) {
      var5 setcovermultinodetype(var6);
    }
  }

  if(!isDefined(var5) || !isDefined(var5.type) || var5.type == "struct" || self.combatmode == "no_cover") {
    if(scripts\engine\utility::actor_is3d()) {
      return (var4 == "Exposed 3D");
    } else {
      return (var4 == "Exposed");
    }
  }

  var7 = allowlmgarrival();

  if(isDefined(var5) && var5.type == "Cover Crouch" && !var7) {
    var8 = getDvar("scr_ai_cover_crouch_type");

    if(var8 != "") {
      return (var4 == var8);
    }

    if(isDefined(self._blackboard.croucharrivaltype)) {
      return (var4 == self._blackboard.croucharrivaltype);
    } else if(isDefined(var5.covercrouchtype)) {
      return (var4 == var5.covercrouchtype);
    }
  }

  var9 = scripts\asm\asm::asm_getdemeanor();
  var10 = (!isnode(var5) || var5 doesnodeallowstance("stand")) && self isstanceallowed("stand");
  var11 = (!isnode(var5) || var5 doesnodeallowstance("crouch")) && self isstanceallowed("crouch") && var9 != "casual" && var9 != "casual_gun";

  if(var0 == "zero_gravity_space") {
    switch (var4) {
      case "Exposed 3D":
        return (scripts\engine\utility::isnodeexposed3d(var5) && var10);
      case "Cover 3D":
        return (var5.type == "Cover 3D");
      case "Cover Stand 3D":
        return nodeiscoverstand3dtype(var5);
      case "Cover Exposed 3D":
        return nodeiscoverexposed3dtype(var5);
      case "Cover Prone":
      case "Exposed Crouch":
      case "Exposed":
      case "Path":
      case "Cover Right Crouch":
      case "Cover Right":
      case "Cover Left Crouch":
      case "Cover Left":
      case "Cover Crouch":
        break;
    }
  } else if(var0 == "zero_gravity") {
    switch (var4) {
      case "Exposed":
        return ((var5.type == "Path" || var5.type == "Exposed") && var10);
      case "Exposed Crouch":
        return ((var5.type == "Path" || var5.type == "Exposed") && var11);
      case "Cover Crouch":
        return (var5.type == "Cover Crouch" || var5.type == "Conceal Crouch");
      case "Cover Stand":
        return (var5.type == "Cover Stand" || var5.type == "Conceal Stand");
      case "Cover Prone":
      case "Cover Right Crouch":
      case "Cover Right":
      case "Cover Left Crouch":
      case "Cover Left":
        break;
    }
  } else {
    switch (var4) {
      case "Exposed":
        if(var5.type != "Path" && var5.type != "Exposed") {
          return 0;
        }

        if(var11 && choosecrouchorstand(self, var5)) {
          return 0;
        }

        return var10;
      case "Exposed Crouch":
        if(var5.type != "Path" && var5.type != "Exposed") {
          return 0;
        }

        if(var10 && !choosecrouchorstand(self, var5)) {
          return 0;
        }

        return var11;
      case "Cover Crouch":
        return (var5.type == "Cover Crouch" || var5.type == "Conceal Crouch" || var5.type == "Cover Crouch Window");
      case "Cover Stand":
        return (var5.type == "Cover Stand" || var5.type == "Conceal Stand");
      case "Cover Prone":
        return (var5.type == "Cover Prone" || var5.type == "Conceal Prone");
      case "Cover Left":
        if(var5.type != "Cover Left") {
          return 0;
        }

        if(var11 && choosecrouchorstand(self, var5)) {
          return 0;
        }

        return var10;
      case "Cover Left Crouch":
        if(var5.type != "Cover Left") {
          return 0;
        }

        if(var10 && !choosecrouchorstand(self, var5)) {
          return 0;
        }

        return var11;
      case "Cover Right":
        if(var5.type != "Cover Right") {
          return 0;
        }

        if(var11 && choosecrouchorstand(self, var5)) {
          return 0;
        }

        return var10;
      case "Cover Right Crouch":
        if(var5.type != "Cover Right") {
          return 0;
        }

        if(var10 && !choosecrouchorstand(self, var5)) {
          return 0;
        }

        return var11;
      case "Cover Crouch LMG":
        return ((var5.type == "Cover Crouch" || var5.type == "Cover Prone") && allowlmgarrival());
      case "Cover Stand LMG":
        return (var5.type == "Cover Stand" && allowlmgarrival());
      case "Exposed Moving":
        return (var5.type == "Exposed Moving");
    }
  }

  return var4 == var5.type;
}

function playmoveloop(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread waitforcoverapproach(var0, var1);
  thread waitforsharpturn(var0, var1);
  thread waitfordooropen(var0, var1, 0);
  var3 = 1;
  scripts\asm\asm::asm_updatefrantic();
  scripts\asm\asm::asm_loopanimstate(var0, var1, var3, 1);
  scripts\asm\asm::asm_updatefrantic();
}

function playmoveloopcasual(var0, var1, var2) {
  playmoveloop(var0, var1, var2);
}

function ref_1244e(var0, var1, var2) {
  thread waitfordooropen(var0, var1, 1);
  playanim(var0, var1, var2);
}

function waitforcoverapproach(var0, var1) {
  self endon(var1 + "_finished");

  for(;;) {
    self.requestarrivalnotify = 1;
    self waittill("cover_approach", var2);
    scripts\asm\asm::asm_fireevent(var0, "cover_approach", var2);
    self.a.approachdir = var2;
  }
}

function waitforsharpturn(var0, var1) {
  self endon(var1 + "_finished");
  self waittill("path_changed", var2, var3, var4, var5, var6);
  var7 = [var2, var3, var4, var5, var6];
  scripts\asm\asm::asm_fireevent(var0, "sharp_turn", var7);
  thread waitforsharpturn(var0, var1);
}

function playmoveloopcasualcleanup(var0, var1, var2) {}

function calcdooropenspeed() {
  if(scripts\common\utility::iscp()) {
    return 0.8;
  }

  var0 = 0.75;
  var1 = length(self.velocity);

  if(var1 > 0) {
    var0 = 24 / var1;
  }

  if(var0 < 0.15) {
    var0 = 0.15;
  } else if(var0 > 1) {
    var0 = 1;
  }

  return var0;
}

function opendooratreasonabletime() {
  var0 = self._blackboard.doortoopen;
  var1 = self.fndooropen;

  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  self._blackboard.door_opened = 1;
  self endon("death");
  var0 endon("death");
  self endon("path_has_door");
  var2 = self[[self.fngetdoorcenter]](var0);
  var3 = distance2dsquared(var2, self.origin);
  var4 = 4096;

  if(scripts\common\utility::iscp()) {
    var5 = 0.8 * length(self.velocity);
    var5 *= 0.9;
    var4 = max(var5 * var5, var4);
  }

  while(var3 > var4) {
    if(isDefined(self._blackboard.doortoopen) && var0 != self._blackboard.doortoopen) {
      return;
    }

    var3 = distance2dsquared(var2, self.origin);
    waitframe();
  }

  var6 = calcdooropenspeed();
  self notify("opening_door");
  self thread[[var1]](var0, var6);
  return var6;
}

function opendooratreasonabletime_waitforabort(var0) {
  self endon("opening_door_done");
  self waittill(var0 + "_finished");

  if(!isalive(self)) {
    return;
  }

  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = undefined;
  self notify("opening_door_done");
}

function closedoorifnecessary(var0) {
  if(self[[self.fndoorneedstoclose]](var0)) {
    self[[self.fndoorclose]](var0);
    return;
  }
}

function waitfordooropen(var0, var1, var2) {
  self endon(var1 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  waitframe();

  for(;;) {
    if(isDefined(self._blackboard.doortoopen)) {
      var3 = 0;

      if(self[[self.fndooralreadyopen]](self._blackboard.doortoopen)) {
        var3 = 1;
      }

      if(!var3 && !isent(self._blackboard.doortoopen)) {
        if(!isDefined(self getmodifierlocationonpath("door", 200))) {
          var3 = 1;
        }
      }

      if(var3) {
        self._blackboard.doortoopen = undefined;
        waitframe();
        continue;
      }

      if(!self.facemotion) {
        var4 = self.lookaheaddir;
        var4 = vectorNormalize((var4[0], var4[1], 0));
        var5 = anglesToForward(self.angles);

        if(vectordot(var4, var5) < 0.966) {
          self.isopeningdoor = 1;
          var6 = opendooratreasonabletime();

          if(isDefined(var6)) {
            thread opendooratreasonabletime_waitforabort(var1);
            wait var6;
          }

          self notify("opening_door_done");
          self._blackboard.doortoopen = undefined;
          self.isopeningdoor = undefined;
          continue;
        }
      }

      var7 = self._blackboard.doortoopen;
      self._blackboard.door_opened = undefined;
      var8 = 1;
      var9 = 160;
      var10 = 2;
      var11 = length2d(self.velocity);

      if(!istrue(var2)) {
        var12 = var1;
        var13 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, "2");

        if(!isDefined(var13)) {
          var11 = self aigettargetspeed();
          var14 = getnextlowestspeedthresholdstring(self.basearchetype, var11);

          if(isDefined(var14)) {
            var15 = var14 + "2";
            var13 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, var15);

            if(!isDefined(var13)) {
              var12 = "door_open";
              var13 = scripts\asm\asm::asm_lookupanimfromaliasifexists("door_open", var15);
            }
          }
        }

        if(!isDefined(var13)) {
          var13 = scripts\asm\asm::asm_lookupanimfromaliasifexists("door_open", "2");
        }

        if(isDefined(var13)) {
          var16 = scripts\asm\asm::asm_getxanim(var12, var13);
          var17 = getnotetracktimes(var16, "door_touch");
          var18 = (var17[0] * getanimlength(var16) + 2 * level.framedurationseconds) * var11;
          var9 = var18 + 24;
        }
      }

      var19 = var8 + var9 + var10;
      var20 = self[[self.fngetdoorcenter]](var7);
      var21 = distance2d(var20, self.origin);

      if(var21 < var19) {
        self.isopeningdoor = 1;
        thread closedoorifnecessary(var7);

        if(istrue(var2) || var21 < var19 - var11 * 2 * level.framedurationseconds) {
          var6 = opendooratreasonabletime();

          if(isDefined(var6)) {
            thread opendooratreasonabletime_waitforabort(var1);
            wait var6;
          }

          self notify("opening_door_done");
          self._blackboard.doortoopen = undefined;
          self.isopeningdoor = undefined;
        } else {
          self setupdooropen(var7, var19, getdooropenspeedlookup());
          thread handledooropennotetrack(var0, var1);
          thread handledooropenterminate(var0, var1);
          self waittill("opening_door_done");
        }
      }
    }

    waitframe();
  }
}

function handledooropennotetrack(var0, var1) {
  self endon(var1 + "_finished");
  self endon("opening_door_done");

  for(;;) {
    self waittill("door_open", var2);

    if(!isarray(var2)) {
      var2 = [var2];
    }

    for(var3 = 0; var3 < var2.size; var3++) {
      if(var2[var3] == "door_open") {
        if(isDefined(self.fndooropen) && isDefined(self._blackboard.doortoopen)) {
          self notify("opening_door");
          var4 = calcdooropenspeed();
          self thread[[self.fndooropen]](self._blackboard.doortoopen, var4);
          self._blackboard.door_opened = 1;
        }

        continue;
      }

      if(var2[var3] == "end") {
        self._blackboard.doortoopen = undefined;
        self.isopeningdoor = undefined;
        self cleardooropen();
        self notify("opening_door_done");
      }
    }

    waitframe();
  }
}

function handledooropenterminate(var0, var1) {
  self endon("opening_door_done");
  self waittill(var1 + "_finished");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(!istrue(self._blackboard.door_opened)) {
    thread opendooratreasonabletime();
  }

  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = undefined;
  self cleardooropen();
}

function getdooropenspeedlookup() {
  if(self.asm.archetype == "civilian_panic") {
    return "civilian_panic";
  }

  if(self.unittype == "civilian") {
    return "civilian";
  }

  if(self.asm.archetype == "juggernaut") {
    return "juggernaut";
  }

  return "soldier";
}

function playanim(var0, var1, var2) {
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function playanimwithsound(var0, var1, var2) {
  self playSound(var2);
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function loopanim(var0, var1, var2) {
  scripts\asm\asm::asm_loopanimstate(var0, var1, 1);
}

function chooseanimidle(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var3, "idle")) {
    var4 = scripts\asm\asm::asm_getdemeanoranimoverride(var3, "idle");

    if(isarray(var4)) {
      return var4[randomint(var4.size)];
    }

    return var4;
  }

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over")) {
      var3 += "_high";
    }
  }

  return chooseanim_weaponclassprepended(var1, var2, var3);
}

function chooseanim_weaponclassprepended(var0, var1, var2) {
  var3 = weaponclass(self.weapon);
  var4 = undefined;

  if(!isDefined(var2)) {
    return scripts\asm\asm::asm_getrandomanim(var0, var1);
  } else {
    var4 = var2;
  }

  if(!scripts\asm\asm::asm_hasalias(var1, var3 + var4)) {
    var3 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3 + var4);
}

function calcarrivaltype(var0, var1, var2) {
  self._blackboard.runpassthroughtype = getarrivaltype();
}

function getarrivaltype() {
  if(isDefined(self.asm.customdata.arrivalstate)) {
    return "Custom";
  }

  if(scripts\asm\asm_bb::bb_smartobjectrequested()) {
    return "Exposed";
  }

  var0 = getarrivalnode();

  if(!isDefined(var0) || !isnode(var0) || !isDefined(var0.type) || var0.type == "struct" || self.combatmode == "no_cover") {
    var1 = self setcorpsemodel();

    if(isDefined(var1)) {
      var2 = scripts\asm\asm::asm_getdemeanor();
      var3 = self isstanceallowed("crouch") && var2 == "combat";

      if(var3 && getwincost(self, var1)) {
        return "Exposed Crouch";
      }

      return "Exposed";
    }

    if(scripts\asm\asm_bb::bb_getrequestedstance() == "crouch" || isfixednodeinbadplaceandshouldcrouch() && self isstanceallowed("crouch")) {
      return "Exposed Crouch";
    }

    return "Exposed";
  }

  if(isDefined(self.enemy) && iscoverinvalidagainstenemy(var3) || shouldinitiallyattackfromexposed(var3)) {
    if(var3 doesnodeallowstance("stand") && self isstanceallowed("stand")) {
      return "Exposed";
    } else if(var3 doesnodeallowstance("crouch") && self isstanceallowed("crouch")) {
      return "Exposed Crouch";
    } else {
      return "Cover Prone";
    }
  }

  if(isnode(var3) && var3 iscovermultinode()) {
    var4 = scripts\engine\utility::getbestcovermultinodetype(var3);

    if(isDefined(var4) && var4 != var3.type) {
      var3 setcovermultinodetype(var4);
    }
  }

  var5 = var3.type;
  var6 = allowlmgarrival();

  if(var6) {
    switch (var5) {
      case "Cover Prone":
      case "Cover Crouch":
        return "Cover Crouch LMG";
      case "Cover Stand":
        return "Cover Stand LMG";
    }
  }

  if(isDefined(self._blackboard.croucharrivaltype) && !var6) {
    return self._blackboard.croucharrivaltype;
  }

  return self choosearrivaltype(var3, var5);
}

function shouldstrafe(var0, var1, var2, var3) {
  return scripts\asm\asm_bb::bb_moverequested() && !self.facemotion && self.allowstrafe;
}

function shouldabortstrafe(var0, var1, var2, var3) {
  if(!shouldstrafe(var0, var1, var2, var3)) {
    return true;
  }

  if(!scripts\asm\asm_bb::bb_movetyperequested("combat")) {
    return true;
  }

  if(scripts\asm\asm_bb::bb_meleechargerequested()) {
    return true;
  }

  return false;
}

function chooseanimmovetype(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getdemeanor();

  if(!scripts\asm\asm::asm_hasalias(var1, var3)) {
    return scripts\asm\asm::asm_chooseanim(var0, var1, var2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
}

function transition_isflashed(var0, var1, var2, var3) {
  return scripts\engine\utility::isflashed();
}

function transition_isburning(var0, var1, var2, var3) {
  return isDefined(self._blackboard.isburning) && !istrue(self.damageshield);
}

function isdeafened(var0, var1, var2, var3) {
  var4 = self.damagetaken;

  if(isDefined(self.paindamage)) {
    var4 = self.paindamage;
  }

  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_sonic")) && self.damagemod != "MOD_MELEE" && var4 >= 75) {
    return true;
  }

  return false;
}

function isspecialpain(var0, var1, var2, var3) {
  return true;
}

function shouldreacttolight(var0, var1, var2, var3) {
  if(isDefined(self.lightreaction_requesttime) && self.lightreaction_requesttime >= gettime() - 1000) {
    var4 = getbasearchetype();

    if(isspeedwithincqbrange(var4, self aigetdesiredspeed())) {
      return true;
    }
  }

  return false;
}

function chooselightreactionanim(var0, var1, var2) {
  var3 = "center";

  if(!isDefined(self.lightreaction_lightorigin)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  }

  if(isDefined(self.covernode)) {
    var4 = anglestoright(self.covernode.angles);
    var5 = anglesToForward(self.covernode.angles);
    var6 = vectorNormalize(self.lightreaction_lightorigin - self.origin);
  } else {
    var4 = anglestoright(self.angles);
    var5 = anglesToForward(self.angles);
    var6 = vectorNormalize(self.lightreaction_lightorigin - self.origin);
  }

  var7 = vectordot(var4, var6) >= 0;
  var8 = vectordot(var5, var6);

  if(var8 >= 0.866) {
    var6 = "center";
  } else if(var7) {
    var6 = "right";
  } else {
    var6 = "left";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var4, var6);
}

function isshocked(var0, var1, var2, var3) {
  if(isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT") {
    return false;
  }

  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("emp"))) {
    return true;
  }

  if(self.unittype == "c6" || self.unittype == "c8") {
    if(scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_sonic")) && scripts\common\utility::isweaponepic(self.damageweapon)) {
      return true;
    }
  }

  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_atomizer")) && self.damagemod != "MOD_MELEE" && self.health <= 0) {
    return true;
  }

  return false;
}

function getdamagedirstring() {
  var0 = -1 * self.damagedir;
  var1 = anglesToForward(self.angles);
  var2 = vectordot(var1, var0);

  if(var2 > 0.707) {
    return "front";
  }

  if(var2 < -0.707) {
    return "back";
  }

  var3 = vectorcross(var1, var0);

  if(var3[2] > 0) {
    return "left";
  }

  return "right";
}

function gethumandamagedirstring() {
  var0 = -1 * self.damagedir;
  var1 = anglesToForward(self.angles);
  var2 = vectordot(var1, var0);

  if(var2 < -0.5) {
    return true;
  }

  return false;
}

function playanimandusegoalweight(var0, var1, var2) {
  GscBinSkip4(0x35, var1, 0.2);
}

function animscriptedaction_terminate(var0, var1, var2) {
  self orientmode("face angle 3d", self.angles);
  self.gunposeoverride_internal = undefined;

  if(isDefined(self.lookatatrnode)) {
    var3 = scripts\asm\asm::asm_getheadlookknobifexists();

    if(isDefined(var3)) {
      self clearanim(var3, 0.2, self.lookatatrnode);
      self.lookatatrnode = undefined;
      return;
    }

    return;
  }
}

function animsriptedactioncivilian_terminate(var0, var1, var2) {
  if(isDefined(self.lookatatrnode)) {
    var3 = scripts\asm\asm::asm_getheadlookknobifexists();

    if(isDefined(var3)) {
      self clearanim(var3, 0.2, self.lookatatrnode);
      self.lookatatrnode = undefined;
      return;
    }

    return;
  }
}

function cleanupanimscriptedheadlook() {
  self.ht_on = undefined;
  scripts\common\utility::lookatentity();
}

function animscriptedstartup(var0, var1, var2) {
  self.ht_on = undefined;
  self stoplookat();
}

function animscriptedcleanup(var0, var1, var2) {
  cleanupanimscriptedheadlook();
}

function animscriptedaction_cleanup(var0, var1, var2) {
  cleanupanimscriptedheadlook();
}

function disabledefaultfacialanims(var0) {
  if(!isDefined(self.headknob)) {
    self.headknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "head"));
  }

  if(!isDefined(var0) || var0) {
    setfacialstate("vignette");

    if(isai(self)) {
      self setfacialindex("none");
      return;
    }

    setfacialindexfornonai("none");
    return;
  }

  clearfacialstate("vignette");
}

function setfacialindexfornonai(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "none", 0);
}

function setfacialstate(var0) {
  self.facialstate = var0;
}

function clearfacialstate(var0) {
  self.facialstate = "asm";

  if(!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim) {
    scripts\asm\asm::asm_restorefacialanim();
    return;
  }
}

function isfacialstateallowed(var0) {
  if(!isai(self) && (!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim)) {
    return false;
  }

  if(!isDefined(self.facialstate)) {
    self.facialstate = "asm";
  }

  var1 = [];
  GscBinSkip0(0x2e, "asm", 0);
}

function getshootfrompos() {
  if(scripts\engine\utility::actor_is3d() || istrue(self.useeyetoshoot)) {
    return self getEye();
  }

  if(isDefined(self.usemuzzlesideoffset) && self.usemuzzlesideoffset) {
    var0 = self getmuzzlesideoffsetpos();

    if(isDefined(self.usemuzzleheightoffset)) {
      return var0;
    }

    return (var0[0], var0[1], self getEye()[2]);
  }

  if(isai(self)) {
    return self getapproxeyepos();
  }

  return (self.origin[0], self.origin[1], self getEye()[2]);
}

function decrementbulletsinclip() {
  if(self.bulletsinclip) {
    self.bulletsinclip--;
    return;
  }
}

function grenadelauncherfirerate() {
  return randomfloatrange(5, 8);
}

function shotgunfirerate() {
  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return 1;
  }

  if(scripts\anim\weaponlist::usingautomaticweapon()) {
    return (scripts\anim\weaponlist::autoshootanimrate() * 0.7);
  }

  return 0.4;
}

function getsniperburstdelaytime() {
  if(isPlayer(self.enemy)) {
    return randomfloatrange(self.enemy.gs.min_sniper_burst_delay_time, self.enemy.gs.max_sniper_burst_delay_time);
  }

  return randomfloatrange(anim.min_sniper_burst_delay_time, anim.max_sniper_burst_delay_time);
}

function melee_checktimer(var0, var1) {
  if(isDefined(self.meleeignoretimer) && self.meleeignoretimer) {
    return 1;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(var1) {
    if(!isDefined(anim.meleechargeplayertimers)) {
      return 1;
    }

    if(!isDefined(anim.meleechargeplayertimers[var0])) {
      return 1;
    }

    return (gettime() > anim.meleechargeplayertimers[var0]);
  }

  if(!isDefined(anim.meleechargetimers)) {
    return 1;
  }

  if(!isDefined(anim.meleechargetimers[var0])) {
    return 1;
  }

  return gettime() > anim.meleechargetimers[var0];
}

function setup_run_n_gun() {
  self.maxrunngunangle = 180;
}

function setupsoldierdefaults() {
  self.a = spawnStruct();
  self.a.laseron = 0;
  self.primaryweapon = self.weapon;
  self.currentpose = "stand";
  self.a.movement = "stop";
  self.a.special = "none";
  self.a.gunhand = "none";
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
  setfacialstate("asm");
  self.currentweaponpose = "gun_down";
  self.lookandaimdownpathdist = 120;
  self.combattraverseenabled = 0;
  self.speedscalemult = 0.95 + randomfloat(0.15);

  if(!isDefined(self.script_forcegrenade)) {
    self.script_forcegrenade = 0;
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.suppressed = 0;
  self.suppressedtime = 0;

  if(self.team == "allies") {
    self.suppressionthreshold = 0.5;
  } else {
    self.suppressionthreshold = 0;
  }

  if(self.team == "allies") {
    self.randomgrenaderange = 0;
  } else {
    self.randomgrenaderange = 256;
  }

  self.ammocheatinterval = 8000;
  self.ammocheattime = 0;
  setup_run_n_gun();
}

function getspeedmatchanimrate(var0, var1, var2) {
  var3 = length(self.velocity);

  if(var3 < 1) {
    return 1;
  }

  var4 = length(getmovedelta(var0, var1, var2));

  if(var4 < 1) {
    return 1;
  }

  var5 = getanimlength(var0) * (var2 - var1);
  var6 = var4 / var5;
  return var3 / var6;
}

function isentasoldier() {
  return self.unittype == "soldier" || self.unittype == "juggernaut";
}

function isentnotabomber() {
  return self.asmname != "suicidebomber" && self.asmname != "suicidebomber_cp";
}

function demeanorhasblendspace() {
  var0 = scripts\asm\asm::asm_getdemeanor();
  return var0 == "combat";
}

function isfixednodeinbadplaceandshouldcrouch() {
  if(self.fixednode && !isDefined(self.node) && isDefined(self.color_node) && self isnodeinbadplace(self.color_node) && self.color_node doesnodeallowstance("crouch")) {
    return true;
  }

  return false;
}

function gethighestallowedstance() {
  var0 = undefined;
  var1 = 1;
  var2 = 1;
  var3 = 1;

  if(isDefined(self.node) && isatcovernode()) {
    var1 = self.node doesnodeallowstance("stand");
    var2 = self.node doesnodeallowstance("crouch");
    var3 = self.node doesnodeallowstance("prone");
  } else if(!scripts\asm\asm_bb::bb_moverequested() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
    var4 = self isstanceallowed("crouch");

    if(var4 && isfixednodeinbadplaceandshouldcrouch()) {
      return "crouch";
    }

    var5 = distancesquared(self.origin, self._blackboard.shootparams_pos);

    if(var5 > 262144 && var4 && !scripts\engine\utility::actor_is3d() && !scripts\anim\utility_common::isusingsidearm()) {
      var4 = 1;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 16 && !self.node doesnodeallowstance("crouch")) {
        var4 = abs(angleclamp180(self.node.angles[1] - self.angles[1])) > 90;
      }

      if(var4) {
        if(sighttracepassed(self.origin + (0, 0, 32), self._blackboard.shootparams_pos, 0, undefined)) {
          return "crouch";
        }
      }
    }
  }

  for(;;) {
    if(self isstanceallowed("stand") && var1) {
      return "stand";
    }

    if(self isstanceallowed("crouch") && var2) {
      return "crouch";
    }

    if(self isstanceallowed("prone") && var3) {
      return "prone";
    }

    if(!var1 || !var2 || !var3) {
      var1 = 1;
      var2 = 1;
      var3 = 1;
      continue;
    }

    break;
  }

  return "crouch";
}

function determinerequestedstance() {
  var0 = gethighestallowedstance();
  var1 = scripts\asm\asm_bb::bb_getrequestedstance();
  var2 = [];
  GscBinSkip0(0x2e, "prone", 0);
}

function mapangleindextonumpad(var0) {
  var1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var1[var0];
}

function toggle_poiauto(var0, var1, var2, var3, var4) {
  if(var0) {
    if(!isDefined(self.poiauto)) {
      poiauto_init(var1, var2, var3, var4);
      thread poiauto_think();
      scripts\common\ai::set_gunpose("disable");
      return;
    }

    return;
  }

  self notify("poiauto_disable");
  self.poiauto = undefined;
  scripts\common\ai::set_gunpose("automatic");
  self stoplookat();
}

function set_poiauto_constraints(var0, var1, var2, var3) {
  if(!isDefined(self.poiauto.og_yawmax)) {
    self.poiauto.og_yawmax = self.poiauto.yawmax;
  }

  if(!isDefined(self.poiauto.og_yawmin)) {
    self.poiauto.og_yawmin = self.poiauto.yawmin;
  }

  if(!isDefined(self.poiauto.og_pitchmin)) {
    self.poiauto.og_pitchmin = self.poiauto.pitchmin;
  }

  if(!isDefined(self.poiauto.og_pitchmax)) {
    self.poiauto.og_pitchmax = self.poiauto.pitchmax;
  }

  self.poiauto.yawmax = var0;
  self.poiauto.yawmin = var1;
  self.poiauto.pitchmin = var2;
  self.poiauto.pitchmax = var3;
}

function reset_poiauto_constraints() {
  self.poiauto.yawmax = self.poiauto.og_yawmax;
  self.poiauto.yawmin = self.poiauto.og_yawmin;
  self.poiauto.pitchmin = self.poiauto.og_pitchmin;
  self.poiauto.pitchmax = self.poiauto.og_pitchmax;
}

function toggle_poi(var0, var1) {
  self.currentpoi = undefined;
  self.nextpoi = undefined;
  self.doingpoi = var0;
  self.disablelookdownpath = var0;
  self.cqb_point_of_interest = undefined;

  if(!var0) {
    level.poi_activeai = scripts\engine\utility::array_remove(level.poi_activeai, self);
    self.turnrate = scripts\engine\utility::ter_op(isDefined(self.poi_oldturnrate), self.poi_oldturnrate, self.turnrate);
    self.gunadditiveoverride = undefined;
    self.disablelookdownpath = undefined;
    self._blackboard.forcestrafe = 0;
    self.gunposeoverride = undefined;
    self stoplookat();
    return;
  }

  var2 = self aigetdesiredspeed();
  var3 = getbasearchetype();
  var4 = getnearestspeedthresholdname(var3, "fast");
  self aisetdesiredspeed(min(var2, var4));

  if(!isDefined(level.poi_activeai)) {
    level.poi_activeai = [];
  }

  level.poi_activeai[level.poi_activeai.size] = self;

  if(isDefined(level.fnfindcqbpointsofinterest) && !istrue(level.alreadyfindingpoi)) {
    level thread[[level.fnfindcqbpointsofinterest]]();
    level.alreadyfindingpoi = 1;
  }

  self.poi_oldturnrate = self.turnrate;
  self.turnrate = 0.25;
  self.leftaimlimit = 90;
  self.rightaimlimit = -90;
  self.poi_firstpoint = var1;
  self.gunposeoverride = "disable";
}

function shouldinitiallyattackfromexposed(var0) {
  if(!isDefined(var0)) {
    var0 = self.node;
  }

  if(isDefined(self._blackboard.shufflenode)) {
    return 0;
  }

  if(isDefined(scripts\asm\asm_bb::bb_getcovernode())) {
    return 0;
  }

  if(isDefined(var0) && (var0.type == "Conceal Stand" || var0.type == "Conceal Crouch")) {
    var1 = vectorNormalize(var0.origin - self.origin);
    var2 = generateaxisanglesfromforwardvector(var1, self.angles);
    var3 = var0.angles[1];
    var4 = angleclamp180(var3 - var2[1]);
    var5 = getangleindex(var4, 22.5);

    if(var5 == 0 || var5 == 1 || var5 == 7 || var5 == 8) {
      self._blackboard.shouldinitiallyattackfromexposed = 1;
      return 1;
    }
  }

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 302500 && self.bulletsinclip > 0) {
    if(!isPlayer(self.enemy) && !isai(self.enemy)) {
      return 0;
    }

    if(isDefined(self._blackboard.shouldinitiallyattackfromexposedtime) && self._blackboard.shouldinitiallyattackfromexposedtime > gettime()) {
      return self._blackboard.shouldinitiallyattackfromexposed;
    }

    if(isai(self.enemy) && !isbot(self.enemy)) {
      var6 = self.enemy getapproxeyepos();
    } else {
      var6 = self.enemy getEye();
    }

    var7 = undefined;

    if(isDefined(var6)) {
      var7 = var6.origin + (0, 0, 56);
      self._blackboard.shouldinitiallyattackfromexposed = sighttracepassed(var7, var6, 0, undefined);
    } else if(istrue(self.brjugg_watchstartnotify)) {
      var8 = 0;

      if(isDefined(self.pathgoalpos)) {
        if(issentient(self.enemy)) {
          var8 = enablegroundwarspawnlogic(self.pathgoalpos, self.enemy);
        } else {
          var8 = enablegroundwarspawnlogic(self.pathgoalpos, self.enemy.origin);
        }
      } else if(issentient(self.enemy)) {
        var8 = self hastacvis(self.enemy);
      } else {
        var8 = enablegroundwarspawnlogic(self.origin, self.enemy.origin);
      }

      self._blackboard.shouldinitiallyattackfromexposed = var8;
    } else {
      return 0;
    }

    self._blackboard.shouldinitiallyattackfromexposedtime = gettime() + 1000;
    return self._blackboard.shouldinitiallyattackfromexposed;
  }

  self._blackboard.shouldinitiallyattackfromexposed = 0;
  return 0;
}

function cover_canattackfromexposed(var0, var1) {
  if(!isPlayer(self.enemy) && !isai(self.enemy)) {
    return 1;
  }

  if(cover_canattackfromexposedcached()) {
    return cover_canattackfromexposedgetcache();
  }

  if(!isDefined(var1)) {
    var1 = self.covernode;
  }

  if(!isDefined(var1)) {
    var1 = self.node;
  }

  if(!isDefined(var1)) {
    return 0;
  }

  var2 = gethighestallowedstance();
  var3 = 56;

  if(var2 != "stand") {
    var3 = 32;
  }

  var4 = var1.origin + (0, 0, var3);

  if(!isDefined(var0)) {
    if(isai(self.enemy) && !isbot(self.enemy)) {
      var0 = self.enemy getapproxeyepos();
    } else {
      var0 = self.enemy getEye();
    }
  }

  var5 = 1000;
  self._blackboard.canattackfromexposed = sighttracepassed(var4, var0, 0, undefined);
  self._blackboard.canattackfromexposedtime = gettime() + var5;
  return self._blackboard.canattackfromexposed;
}

function cover_canattackfromexposedcached() {
  return isDefined(self._blackboard.canattackfromexposedtime) && self._blackboard.canattackfromexposedtime > gettime();
}

function cover_canattackfromexposedgetcache() {
  return self._blackboard.canattackfromexposed;
}

function iscoverinvalidagainstenemy(var0) {
  if(!isDefined(var0)) {
    var1 = iscovervalid();
  } else {
    var1 = iscovernodevalid(var1);
  }

  return !var1 && !fixednodeshouldsticktocover(var1) && cover_canattackfromexposed(undefined, var1);
}

function fixednodeshouldsticktocover(var0) {
  if(!isDefined(var0)) {
    var0 = self.node;
  }

  if(!self.fixednode) {
    return 0;
  }

  if(isDefined(self.enemy.node) && !nodesvisible(var0, self.enemy.node)) {
    return 1;
  }

  if(!self seerecently(self.enemy, 8)) {
    return 1;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return 1;
  }

  if(distancesquared(var0.origin, self.enemy.origin) > 4096) {
    if(!isDefined(self._blackboard.fixedshouldsticktocovertime) || self._blackboard.fixedshouldsticktocovertime < gettime()) {
      var1 = (0, 0, 50);
      var2 = vectorNormalize(self.enemy.origin - var0.origin);
      var3 = var0.origin + var1;
      var4 = var3 + var2 * 64;
      self._blackboard.fixedshouldsticktocovertime = gettime() + 1050;
      self._blackboard.fixedshouldsticktocovercached = !scripts\engine\trace::_bullet_trace_passed(var3, var4, 0, self);
    }

    return self._blackboard.fixedshouldsticktocovercached;
  }

  return 0;
}

function iscovernodevalid(var0) {
  return istrue(self.ignorecovervalidity) || self iscovervalidagainstenemy(var0);
}

function iscovervalid() {
  return istrue(self.ignorecovervalidity) || self iscovervalidagainstenemy();
}

function addoverridearchetypepriority(var0) {
  level.archetypeoverridepriorities[var0] = level.archetypeoverridepriorities.size;
}

function setupoverridearchetypeprioritytable() {
  if(isDefined(level.archetypeoverridepriorities)) {
    return;
  }

  level.archetypeoverridepriorities = [];
  addoverridearchetypepriority("base");
  addoverridearchetypepriority("default");
  addoverridearchetypepriority("weapon");
  addoverridearchetypepriority("casual_killer");
  addoverridearchetypepriority("vehicle");
  addoverridearchetypepriority("animscript");
}

function setoverridearchetype(var0, var1, var2) {
  setupoverridearchetypeprioritytable();
  var3 = level.archetypeoverridepriorities[var0];

  if(!isDefined(self.archetypeoverrides)) {
    setbasearchetype(self.asm.archetype);
  }

  clearoverridearchetype(var0, 1);
  var4 = spawnStruct();
  var4.archetypepriority = var3;
  var4.archetype = var1;
  self.archetypeoverrides = scripts\engine\utility::array_add(self.archetypeoverrides, var4);
  pickoverridearchetype(var2);
}

function clearoverridearchetype(var0, var1, var2) {
  if(self.archetypeoverrides.size == 0) {
    return;
  }

  var3 = level.archetypeoverridepriorities[var0];
  var4 = [];

  foreach(var6 in self.archetypeoverrides) {
    if(var6.archetypepriority != var3) {
      var4 = var6;
    }
  }

  self.archetypeoverrides = var4;

  if(!istrue(var1)) {
    pickoverridearchetype(var2);
    return;
  }
}

function pickoverridearchetype(var0) {
  self.changearchetype = undefined;
  var1 = undefined;

  foreach(var3 in self.archetypeoverrides) {
    if(!isDefined(var1) || var3.archetypepriority > var1.archetypepriority) {
      var1 = var3;
    }
  }

  if(self.asm.archetype == var1.archetype) {
    return;
  }

  if(istrue(var0)) {
    self.animationarchetype = var1.archetype;
    self.asm.archetype = var1.archetype;
    self setanimset(var1.archetype);
    return;
  }

  self.changearchetype = var1.archetype;
}

function findoverridearchetype(var0) {
  var1 = level.archetypeoverridepriorities[var0];

  foreach(var3 in self.archetypeoverrides) {
    if(var3.archetypepriority == var1) {
      return var3.archetype;
    }
  }

  return undefined;
}

function getbasearchetype() {
  if(!isDefined(self.archetypeoverrides)) {
    setbasearchetype(self.asm.archetype);
  }

  return findoverridearchetype("base");
}

function setbasearchetype(var0) {
  if(!isDefined(self.archetypeoverrides)) {
    self.archetypeoverrides = [];
    setoverridearchetype("default", self.asm.archetype);
  }

  setoverridearchetype("base", var0);
  self.basearchetype = var0;
}

function poiauto_init(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = 15;
  }

  if(!isDefined(var1)) {
    var1 = 35;
  }

  if(!isDefined(var2)) {
    var2 = -20;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  self.poiauto = spawnStruct();
  self.poiauto.yawmax = var1;
  self.poiauto.yawmin = var0;
  self.poiauto.pitchmin = var2;
  self.poiauto.pitchmax = var3;
}

function poiauto_think() {
  self endon("poiauto_disable");
  self endon("death");
  var0 = 500;
  var1 = 0;
  var2 = 0;
  var3 = gettime() + 30000;
  jumpiftrue(isDefined(self.poiauto)) LOC_00000031;
  poiauto_init();

  for(;;) {
    var4 = 0;

    if(var3 <= gettime()) {
      self.poiauto_angles = (0, 0, 0);

      if(var3 == var1) {
        var4 = 1;
      }
    }

    if(var1 <= gettime()) {
      var3 = gettime() + int(randomfloatrange(0.8, 1.8) * 1000);
      var2 = gettime();
      poiauto_setnewaimangle(var4);
      var5 = var0 - gettime();
      var6 = var3 - gettime();

      if(abs(var6 - var5) >= 550 && scripts\engine\utility::cointoss()) {
        var1 = var3;
      } else if(var5 > 3000) {
        var1 = gettime() + randomintrange(2000, 3000);
      } else {
        var1 = gettime() + var5 + 550 + randomintrange(1000, 2000);
      }
    }

    waitframe();
  }
}

function poiauto_relativeangletopos(var0) {
  var1 = anglesToForward(var0);
  var2 = rotatevector(var1, self.angles);
  var3 = self getapproxeyepos();
  var4 = var3 + var2 * 128;
  return var4;
}

function poiauto_glancerandom() {
  var0 = randomfloatrange(-45, 45);
  var1 = randomfloatrange(-20, 20);
  var2 = poiauto_relativeangletopos((var1, var0, 0));
  self.poiauto.glancing = 1;
  thread poiauto_glanceend();
  self glanceatpos(var2);
}

function poiauto_glanceend() {
  self notify("poiauto_glanceend");
  self endon("poiauto_glanceend");
  wait 0.55;
  self.poiauto.glancing = 0;
}

function poiauto_isglancing() {
  return istrue(self.poiauto.glancing);
}

function poiauto_setnewaimangle(var0) {
  jumpiffalse(var0) LOC_00000046;
  var1 = randomfloatrange(self.poiauto_angles[1] + 5, self.poiauto_angles[1] + 10);
  var2 = randomfloatrange(5, 10);

  if(scripts\engine\utility::cointoss()) {
    var2 *= -1;
  }

  var2 = self.poiauto_angles[0] + var2;
  goto LOC_00000079;
}

function preventrecentanimindex(var0, var1, var2) {
  var3 = self.asm.archetype;

  if(isDefined(self.animationarchetype)) {
    var3 = self.animationarchetype;
  }

  if(!isDefined(anim.recentindices)) {
    anim.recentindices = [];
  }

  var4 = gettime();
  var5 = 1000;
  var6 = 2;
  var7 = 0;
  var8 = 1;
  var9 = var3 + var0;

  if(isDefined(anim.recentindices[var9])) {
    var10 = anim.recentindices[var9][var2];

    if(var4 - var10[var7] <= var5 && var10[var8] >= var6) {
      var11 = scripts\asm\asm::asm_getallanimindicesforalias(var0, var1);
      var12 = var11[0];
      var13 = var11[var11.size - 1];

      for(var14 = 1; var14 < var11.size; var14++) {
        var15 = scripts\engine\math::wrap(var12, var13 - 1, var2 + var14);

        if(anim.recentindices[var9][var15][var8] < var6) {
          var2 = var15;
          var10 = anim.recentindices[var9][var2];
          break;
        }
      }
    }

    if(var4 - var10[var7] > var5) {
      GscBinSkip0(0x2e, var7, var4);
    }

    GscBinSkip0(0x2e, var8, var10[var8] + 1);
  }

  anim.recentindices[var10] = [];
  var16 = scripts\asm\asm::asm_getallanimsforstate(var1);

  for(var14 = 0; var14 < var16.size; var14++) {
    anim.recentindices[var10][var14] = [0, 0];
  }

  anim.recentindices[var10][var3][var8] = var5;
  anim.recentindices[var10][var3][var9] = 1;
  return var3;
}

function intro_addplayer(var0, var1, var2, var3) {
  if(isDefined(self.intro_heli_animate_player)) {
    return self[[self.intro_heli_animate_player]](var0, var1, var2, var3);
  }

  return 0;
}