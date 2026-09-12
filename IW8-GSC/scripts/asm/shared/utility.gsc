/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shared\utility.gsc
***********************************************/

function set_default_aim_limits(var_0) {
  if(isDefined(var_0)) {
    self setdefaultaimlimits(var_0);
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

function chooseanimshoot(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = self._blackboard.shootstate + "_" + var_3;

  if(isDefined(self._blackboard.shootstate) && scripts\asm\asm::asm_hasalias(var_1, var_4)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
}

function choosedemeanoranimwithoverride(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, var_2)) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, var_2);

    if(isarray(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(!scripts\asm\asm::asm_hasalias(var_2, var_4)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_2, "default");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4);
}

function choosedemeanoranimwithoverridevariants(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, var_2)) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, var_2);

    if(isarray(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(!scripts\asm\asm::asm_hasalias(var_2, var_4)) {
    var_5 = [];
    GscBinSkip0(0x2e, 0, scripts\asm\asm::asm_lookupanimfromalias(var_2, "trans_to_one_hand_run"));
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_3, var_5);
}

function chooseanim_exposedreload(var_0, var_1, var_2) {
  var_2 = "";

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over")) {
      var_2 += "_high";
    }
  }

  return chooseanim_weaponclassprepended(var_0, var_1, var_2);
}

function chooseanim_weaponswitch(var_0, var_1, var_2) {
  if(weaponclass(self.weapon) == "rocketlauncher" && scripts\asm\asm::asm_hasalias(var_1, "drop_rpg")) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "drop_rpg");
  }

  var_3 = scripts\asm\asm_bb::bb_getrequestedweapon();

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
    var_3 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

function isspeedwithincqbrange(var_0, var_1) {
  if(!getanimspeedthreshold(var_0, "fast") || !getanimspeedthreshold(var_0, "jog")) {
    return false;
  }

  return var_1 < getcoveranglelimits(var_0, "fast", "jog", 0.1);
}

function isspeedwithinsprintrange(var_0, var_1) {
  return var_1 > getcoveranglelimits(var_0, "run", "sprint", 0.1);
}

function isspeedwithincombatrange(var_0, var_1) {
  if(getanimspeedthreshold(var_0, "fast") && getanimspeedthreshold(var_0, "jog") && var_1 < getcoveranglelimits(var_0, "fast", "jog", 0.9)) {
    return false;
  }

  if(getanimspeedthreshold(var_0, "run") && getanimspeedthreshold(var_0, "sprint") && var_1 > getcoveranglelimits(var_0, "run", "sprint", 0.1)) {
    return false;
  }

  return true;
}

function isspeedwithincombatrangeextended(var_0, var_1) {
  if(getanimspeedthreshold(var_0, "fast") && getanimspeedthreshold(var_0, "jog") && var_1 < getcoveranglelimits(var_0, "fast", "jog", 0.8)) {
    return false;
  }

  if(getanimspeedthreshold(var_0, "run") && getanimspeedthreshold(var_0, "sprint") && var_1 > getcoveranglelimits(var_0, "run", "sprint", 0.3)) {
    return false;
  }

  return true;
}

function movetypeisnotcasual(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getdemeanor();
  return var_4 != "casual" && var_4 != "casual_gun";
}

function getnodeforwardyawnodetypelookupoverride(var_0, var_1) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "Cover Left":
        if(var_1 == "crouch") {
          return "Cover Left Crouch";
        }

        break;
      case "Cover Right":
        if(var_1 == "crouch") {
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

function overridecovercrouchnodetype(var_0) {
  if(var_0.type == "Cover Crouch" && isDefined(self._blackboard.croucharrivaltype)) {
    return self._blackboard.croucharrivaltype;
  }

  return var_0.type;
}

function getnodeoffsetposeoverride(var_0, var_1, var_2) {
  var_3 = self.currentpose;

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(isnode(var_0) && !var_0 doesnodeallowstance(var_3)) {
    var_3 = var_0 gethighestnodestance();
  }

  var_4 = getnodeforwardyawnodetypelookupoverride(var_1, var_3);
  return var_4;
}

function getnodeyawfromoffsettable(var_0, var_1, var_2) {
  var_3 = self.currentpose;

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else if(isnode(var_1) && !var_1 doesnodeallowstance(var_3)) {
    var_3 = var_1 gethighestnodestance();
  }

  var_4 = overridecovercrouchnodetype(var_1);
  var_5 = getnodeforwardyawnodetypelookupoverride(var_4, var_3);

  if(isDefined(var_5) && isDefined(var_0[var_5])) {
    return var_0[var_5];
  }

  if(isDefined(var_0[var_4])) {
    return var_0[var_4];
  }

  return undefined;
}

function allowlmgarrival() {
  if(istrue(self.disablelmgmount)) {
    return false;
  }

  var_0 = weaponclass(self.weapon) == "mg";

  if(var_0) {
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

function getnodeyawoffset(var_0, var_1, var_2) {
  if(isstruct(var_0) || !isDefined(var_0.type)) {
    return 0;
  }

  if(istrue(self._blackboard.inlmgstate) || istrue(self.asm.usingaturret)) {
    return 0;
  }

  var_3 = overridecovercrouchnodetype(var_0);
  var_4 = self getnodehideyaw(var_0, var_3, var_1, var_2);
  return var_4;
}

function getnodeforwardyaw(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = getnodeyawoffset(var_0, var_1, var_2);
  return var_0.angles[1] + var_3;
}

function getnodeforwardangles(var_0, var_1) {
  var_2 = getnodeyawoffset(var_0, var_1, 1);
  return combineangles(var_0.angles, (0, var_2, 0));
}

function getnodeleanyaw(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = var_0.type;
  }

  var_3 = getnodeoffsetposeoverride(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    return self getnodeleanaimyawoffset(var_3);
  }

  return self getnodeleanaimyawoffset(var_1);
}

function getnodeaimpitchoffset(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_2 == "exposed") {
    var_3 = anim.nodeexposedpitches[var_0];
  } else if(var_2 == "lean" || var_2 == "leanover") {
    var_3 = anim.nodeleanpitches[var_0];
  } else if(var_2 == "overlean") {
    var_3 = anim.nodeoverleanpitches[var_0];
  }

  if(isDefined(var_3)) {
    var_4 = getnodeyawfromoffsettable(var_3, var_1, undefined);

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return 0;
}

function getnodeaimyawoffset(var_0, var_1, var_2) {
  if(var_2 == "lean") {
    var_3 = overridecovercrouchnodetype(var_1);
    return self getnodeleanaimyaw(var_1, var_3);
  }

  return 0;
}

function nodeiscoverstand3dtype(var_0) {
  if(var_0.type == "Cover Stand 3D") {
    return !nodeiscoverexposed3dtype(var_0);
  }

  return false;
}

function nodeiscoverexposed3dtype(var_0) {
  if(var_0.type == "Cover Stand 3D") {
    if(isDefined(var_0.script_parameters) && var_0.script_parameters == "exposed") {
      return true;
    }
  }

  return false;
}

function getnodetypename(var_0) {
  if(isDefined(var_0)) {
    if(nodeiscoverexposed3dtype(var_0)) {
      return "Cover Exposed 3D";
    } else {
      return var_0.type;
    }
  }

  return "undefined";
}

function choosestrongdamagedeath(var_0, var_1, var_2) {
  var_3 = undefined;

  if(abs(self.damageyaw) > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var_3 = "legs";
    } else if(self.damagelocation == "torso_lower") {
      var_3 = "torso_lower";
    } else {
      var_3 = "default";
    }
  } else if(self.damageyaw < 0) {
    var_3 = "right";
  } else {
    var_3 = "left";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

function isatcovernode() {
  return isDefined(scripts\asm\asm_bb::bb_getcovernode());
}

function setuseanimgoalweight(var_0, var_1) {
  self endon(var_0 + "_finished");
  self.useanimgoalweight = 1;
  thread setuseanimgoalweight_wait(var_0);

  if(var_1 > 0) {
    wait var_1;
  }

  self.useanimgoalweight = 0;
  self notify("StopUseAnimGoalWeight");
}

function setuseanimgoalweight_wait(var_0) {
  self notify("StopUseAnimGoalWeight");
  self endon("StopUseAnimGoalWeight");
  self endon("death");
  self endon("entitydeleted");
  self waittill(var_0 + "_finished");
  self.useanimgoalweight = 0;
}

function shouldleaveanimScripted(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_isanimScripted()) {
    return false;
  }

  var_4 = var_3;

  if(var_4) {
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

function scriptedcoverposerequestis(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(self.a.coverpose_request == var_4) {
    self.a.coverpose_request = undefined;
    return true;
  }

  return false;
}

function scriptedcoverposerequestisDefined(var_0, var_1, var_2, var_3) {
  return isDefined(self.a.coverpose_request);
}

function animscriptedaction(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.a.movement = "run";
  self.gunposeoverride_internal = "disable";
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

function randomizepassthroughchildren(var_0, var_1, var_2, var_3) {
  var_4 = anim.asm[var_0].states[var_2];

  if(isDefined(var_4.transitions)) {
    if(var_4.transitions.size == 2) {
      if(scripts\engine\utility::cointoss()) {
        var_5 = var_4.transitions[0];
        var_4.transitions[0] = var_4.transitions[1];
        var_4.transitions[1] = var_5;
      }
    } else {
      var_4.transitions = scripts\engine\utility::array_randomize(var_4.transitions);
    }
  }

  return true;
}

function blockedbywall(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isDefined(self._blackboard)) {
    var_1 = gettime();

    if(isDefined(self._blackboard.gunblockedbywalltime)) {
      if(var_1 - self._blackboard.gunblockedbywalltime < 300) {
        return true;
      }

      self._blackboard.gunblockedbywalltime = undefined;
    }

    if(!var_0 && isDefined(self._blackboard.lastblockedbywallchecktime) && var_1 - self._blackboard.lastblockedbywallchecktime < 200) {
      return false;
    }

    self._blackboard.lastblockedbywallchecktime = var_1;

    if(self isgunblockedbywall()) {
      self._blackboard.gunblockedbywalltime = var_1;

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

function nodeshouldfaceangles(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(var_0.angles)) {
    return true;
  }

  if(isstruct(var_0)) {
    return false;
  }

  return isDefined(var_0.type) && var_0.type != "Path" && !scripts\engine\utility::isnodeexposed3d(var_0);
}

function choosecrouchorstand(var_0, var_1) {
  return int(var_1.origin[0] + var_1.origin[1] + var_1.origin[2] + var_0 getentitynumber()) % 2;
}

function getwincost(var_0, var_1) {
  return int(abs(var_1[0] + var_1[1] + var_1[2] + var_0 getentitynumber())) % 2;
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

function isarrivaltypecivilian(var_0, var_1) {
  if(isDefined(self.asm.customdata.arrivalstate)) {
    return (var_1 == "Custom");
  }

  if(scripts\asm\asm_bb::bb_smartobjectrequested()) {
    return (var_1 == "Exposed");
  }

  var_2 = getarrivalnode();

  if(isDefined(var_2) && isnode(var_2) && var_2 iscovermultinode()) {
    var_3 = scripts\engine\utility::getbestcovermultinodetype(var_2);

    if(isDefined(var_3)) {
      var_2 setcovermultinodetype(var_3);
    }
  }

  if(!isDefined(var_2) || !isDefined(var_2.type) || var_2.type == "struct" || self.combatmode == "no_cover") {
    return (var_1 == "Exposed");
  }

  if(isDefined(var_2) && var_2.type == "Cover Crouch") {
    var_4 = getDvar("scr_ai_cover_crouch_type");

    if(var_4 != "") {
      return (var_1 == var_4);
    }

    if(isDefined(self._blackboard.croucharrivaltype)) {
      return (var_1 == self._blackboard.croucharrivaltype);
    } else if(isDefined(var_2.covercrouchtype)) {
      return (var_1 == var_2.covercrouchtype);
    }
  }

  var_5 = scripts\asm\asm::asm_getdemeanor();
  var_6 = (!isnode(var_2) || var_2 doesnodeallowstance("stand")) && self isstanceallowed("stand");
  var_7 = (!isnode(var_2) || var_2 doesnodeallowstance("crouch")) && self isstanceallowed("crouch") && var_5 != "casual" && var_5 != "casual_gun";

  switch (var_1) {
    case "Exposed":
      if(var_2.type != "Path" && var_2.type != "Exposed") {
        return 0;
      }

      if(var_7 && choosecrouchorstand(self, var_2)) {
        return 0;
      }

      return var_6;
    case "Exposed Crouch":
      if(var_2.type != "Path" && var_2.type != "Exposed") {
        return 0;
      }

      if(var_6 && !choosecrouchorstand(self, var_2)) {
        return 0;
      }

      return var_7;
    case "Cover Crouch":
      return (var_2.type == "Cover Crouch" || var_2.type == "Conceal Crouch" || var_2.type == "Cover Crouch Window" || var_2.type == "Cover Stand" || var_2.type == "Conceal Stand" || var_2.type == "Cover Prone" || var_2.type == "Conceal Prone");
    case "Cover Left":
      return (var_2.type == "Cover Left");
    case "Cover Right":
      return (var_2.type == "Cover Right");
    case "Exposed Moving":
      return (var_2.type == "Exposed Moving");
  }

  return var_1 == var_2.type;
}

function isarrivaltype(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(isDefined(self.asm.customdata.arrivalstate)) {
    return (var_4 == "Custom");
  }

  if(scripts\asm\asm_bb::bb_smartobjectrequested()) {
    return (var_4 == "Exposed");
  }

  var_5 = getarrivalnode();

  if(isDefined(var_5) && isnode(var_5) && var_5 iscovermultinode()) {
    var_6 = scripts\engine\utility::getbestcovermultinodetype(var_5);

    if(isDefined(var_6) && var_5.type != var_6 && var_4 == var_6) {
      var_5 setcovermultinodetype(var_6);
    }
  }

  if(!isDefined(var_5) || !isDefined(var_5.type) || var_5.type == "struct" || self.combatmode == "no_cover") {
    if(scripts\engine\utility::actor_is3d()) {
      return (var_4 == "Exposed 3D");
    } else {
      return (var_4 == "Exposed");
    }
  }

  var_7 = allowlmgarrival();

  if(isDefined(var_5) && var_5.type == "Cover Crouch" && !var_7) {
    var_8 = getDvar("scr_ai_cover_crouch_type");

    if(var_8 != "") {
      return (var_4 == var_8);
    }

    if(isDefined(self._blackboard.croucharrivaltype)) {
      return (var_4 == self._blackboard.croucharrivaltype);
    } else if(isDefined(var_5.covercrouchtype)) {
      return (var_4 == var_5.covercrouchtype);
    }
  }

  var_9 = scripts\asm\asm::asm_getdemeanor();
  var_10 = (!isnode(var_5) || var_5 doesnodeallowstance("stand")) && self isstanceallowed("stand");
  var_11 = (!isnode(var_5) || var_5 doesnodeallowstance("crouch")) && self isstanceallowed("crouch") && var_9 != "casual" && var_9 != "casual_gun";

  if(var_0 == "zero_gravity_space") {
    switch (var_4) {
      case "Exposed 3D":
        return (scripts\engine\utility::isnodeexposed3d(var_5) && var_10);
      case "Cover 3D":
        return (var_5.type == "Cover 3D");
      case "Cover Stand 3D":
        return nodeiscoverstand3dtype(var_5);
      case "Cover Exposed 3D":
        return nodeiscoverexposed3dtype(var_5);
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
  } else if(var_0 == "zero_gravity") {
    switch (var_4) {
      case "Exposed":
        return ((var_5.type == "Path" || var_5.type == "Exposed") && var_10);
      case "Exposed Crouch":
        return ((var_5.type == "Path" || var_5.type == "Exposed") && var_11);
      case "Cover Crouch":
        return (var_5.type == "Cover Crouch" || var_5.type == "Conceal Crouch");
      case "Cover Stand":
        return (var_5.type == "Cover Stand" || var_5.type == "Conceal Stand");
      case "Cover Prone":
      case "Cover Right Crouch":
      case "Cover Right":
      case "Cover Left Crouch":
      case "Cover Left":
        break;
    }
  } else {
    switch (var_4) {
      case "Exposed":
        if(var_5.type != "Path" && var_5.type != "Exposed") {
          return 0;
        }

        if(var_11 && choosecrouchorstand(self, var_5)) {
          return 0;
        }

        return var_10;
      case "Exposed Crouch":
        if(var_5.type != "Path" && var_5.type != "Exposed") {
          return 0;
        }

        if(var_10 && !choosecrouchorstand(self, var_5)) {
          return 0;
        }

        return var_11;
      case "Cover Crouch":
        return (var_5.type == "Cover Crouch" || var_5.type == "Conceal Crouch" || var_5.type == "Cover Crouch Window");
      case "Cover Stand":
        return (var_5.type == "Cover Stand" || var_5.type == "Conceal Stand");
      case "Cover Prone":
        return (var_5.type == "Cover Prone" || var_5.type == "Conceal Prone");
      case "Cover Left":
        if(var_5.type != "Cover Left") {
          return 0;
        }

        if(var_11 && choosecrouchorstand(self, var_5)) {
          return 0;
        }

        return var_10;
      case "Cover Left Crouch":
        if(var_5.type != "Cover Left") {
          return 0;
        }

        if(var_10 && !choosecrouchorstand(self, var_5)) {
          return 0;
        }

        return var_11;
      case "Cover Right":
        if(var_5.type != "Cover Right") {
          return 0;
        }

        if(var_11 && choosecrouchorstand(self, var_5)) {
          return 0;
        }

        return var_10;
      case "Cover Right Crouch":
        if(var_5.type != "Cover Right") {
          return 0;
        }

        if(var_10 && !choosecrouchorstand(self, var_5)) {
          return 0;
        }

        return var_11;
      case "Cover Crouch LMG":
        return ((var_5.type == "Cover Crouch" || var_5.type == "Cover Prone") && allowlmgarrival());
      case "Cover Stand LMG":
        return (var_5.type == "Cover Stand" && allowlmgarrival());
      case "Exposed Moving":
        return (var_5.type == "Exposed Moving");
    }
  }

  return var_4 == var_5.type;
}

function playmoveloop(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread waitforcoverapproach(var_0, var_1);
  thread waitforsharpturn(var_0, var_1);
  thread waitfordooropen(var_0, var_1, 0);
  var_3 = 1;
  scripts\asm\asm::asm_updatefrantic();
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, var_3, 1);
  scripts\asm\asm::asm_updatefrantic();
}

function playmoveloopcasual(var_0, var_1, var_2) {
  playmoveloop(var_0, var_1, var_2);
}

function ref_1244E(var_0, var_1, var_2) {
  thread waitfordooropen(var_0, var_1, 1);
  playanim(var_0, var_1, var_2);
}

function waitforcoverapproach(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    self.requestarrivalnotify = 1;
    self waittill("cover_approach", var_2);
    scripts\asm\asm::asm_fireevent(var_0, "cover_approach", var_2);
    self.a.approachdir = var_2;
  }
}

function waitforsharpturn(var_0, var_1) {
  self endon(var_1 + "_finished");
  self waittill("path_changed", var_2, var_3, var_4, var_5, var_6);
  var_7 = [var_2, var_3, var_4, var_5, var_6];
  scripts\asm\asm::asm_fireevent(var_0, "sharp_turn", var_7);
  thread waitforsharpturn(var_0, var_1);
}

function playmoveloopcasualcleanup(var_0, var_1, var_2) {}

function calcdooropenspeed() {
  if(scripts\common\utility::iscp()) {
    return 0.8;
  }

  var_0 = 0.75;
  var_1 = length(self.velocity);

  if(var_1 > 0) {
    var_0 = 24 / var_1;
  }

  if(var_0 < 0.15) {
    var_0 = 0.15;
  } else if(var_0 > 1) {
    var_0 = 1;
  }

  return var_0;
}

function opendooratreasonabletime() {
  var_0 = self._blackboard.doortoopen;
  var_1 = self.fndooropen;

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  self._blackboard.door_opened = 1;
  self endon("death");
  var_0 endon("death");
  self endon("path_has_door");
  var_2 = self[[self.fngetdoorcenter]](var_0);
  var_3 = distance2dsquared(var_2, self.origin);
  var_4 = 4096;

  if(scripts\common\utility::iscp()) {
    var_5 = 0.8 * length(self.velocity);
    var_5 *= 0.9;
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
  self notify("opening_door");
  self thread[[var_1]](var_0, var_6);
  return var_6;
}

function opendooratreasonabletime_waitforabort(var_0) {
  self endon("opening_door_done");
  self waittill(var_0 + "_finished");

  if(!isalive(self)) {
    return;
  }

  self._blackboard.doortoopen = undefined;
  self.isopeningdoor = undefined;
  self notify("opening_door_done");
}

function closedoorifnecessary(var_0) {
  if(self[[self.fndoorneedstoclose]](var_0)) {
    self[[self.fndoorclose]](var_0);
    return;
  }
}

function waitfordooropen(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  waitframe();

  for(;;) {
    if(isDefined(self._blackboard.doortoopen)) {
      var_3 = 0;

      if(self[[self.fndooralreadyopen]](self._blackboard.doortoopen)) {
        var_3 = 1;
      }

      if(!var_3 && !isent(self._blackboard.doortoopen)) {
        if(!isDefined(self getmodifierlocationonpath("door", 200))) {
          var_3 = 1;
        }
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
            wait var_6;
          }

          self notify("opening_door_done");
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
        var_13 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, "2");

        if(!isDefined(var_13)) {
          var_11 = self aigettargetspeed();
          var_14 = getnextlowestspeedthresholdstring(self.basearchetype, var_11);

          if(isDefined(var_14)) {
            var_15 = var_14 + "2";
            var_13 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, var_15);

            if(!isDefined(var_13)) {
              var_12 = "door_open";
              var_13 = scripts\asm\asm::asm_lookupanimfromaliasifexists("door_open", var_15);
            }
          }
        }

        if(!isDefined(var_13)) {
          var_13 = scripts\asm\asm::asm_lookupanimfromaliasifexists("door_open", "2");
        }

        if(isDefined(var_13)) {
          var_16 = scripts\asm\asm::asm_getxanim(var_12, var_13);
          var_17 = getnotetracktimes(var_16, "door_touch");
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
            wait var_6;
          }

          self notify("opening_door_done");
          self._blackboard.doortoopen = undefined;
          self.isopeningdoor = undefined;
        } else {
          self setupdooropen(var_7, var_19, getdooropenspeedlookup());
          thread handledooropennotetrack(var_0, var_1);
          thread handledooropenterminate(var_0, var_1);
          self waittill("opening_door_done");
        }
      }
    }

    waitframe();
  }
}

function handledooropennotetrack(var_0, var_1) {
  self endon(var_1 + "_finished");
  self endon("opening_door_done");

  for(;;) {
    self waittill("door_open", var_2);

    if(!isarray(var_2)) {
      var_2 = [var_2];
    }

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_2[var_3] == "door_open") {
        if(isDefined(self.fndooropen) && isDefined(self._blackboard.doortoopen)) {
          self notify("opening_door");
          var_4 = calcdooropenspeed();
          self thread[[self.fndooropen]](self._blackboard.doortoopen, var_4);
          self._blackboard.door_opened = 1;
        }

        continue;
      }

      if(var_2[var_3] == "end") {
        self._blackboard.doortoopen = undefined;
        self.isopeningdoor = undefined;
        self cleardooropen();
        self notify("opening_door_done");
      }
    }

    waitframe();
  }
}

function handledooropenterminate(var_0, var_1) {
  self endon("opening_door_done");
  self waittill(var_1 + "_finished");

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

function playanim(var_0, var_1, var_2) {
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

function playanimwithsound(var_0, var_1, var_2) {
  self playSound(var_2);
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

function loopanim(var_0, var_1, var_2) {
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1);
}

function chooseanimidle(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, "idle")) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, "idle");

    if(isarray(var_4)) {
      return var_4[randomint(var_4.size)];
    }

    return var_4;
  }

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over")) {
      var_3 += "_high";
    }
  }

  return chooseanim_weaponclassprepended(var_1, var_2, var_3);
}

function chooseanim_weaponclassprepended(var_0, var_1, var_2) {
  var_3 = weaponclass(self.weapon);
  var_4 = undefined;

  if(!isDefined(var_2)) {
    return scripts\asm\asm::asm_getrandomanim(var_0, var_1);
  } else {
    var_4 = var_2;
  }

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3 + var_4)) {
    var_3 = "rifle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3 + var_4);
}

function calcarrivaltype(var_0, var_1, var_2) {
  self._blackboard.runpassthroughtype = getarrivaltype();
}

function getarrivaltype() {
  if(isDefined(self.asm.customdata.arrivalstate)) {
    return "Custom";
  }

  if(scripts\asm\asm_bb::bb_smartobjectrequested()) {
    return "Exposed";
  }

  var_0 = getarrivalnode();

  if(!isDefined(var_0) || !isnode(var_0) || !isDefined(var_0.type) || var_0.type == "struct" || self.combatmode == "no_cover") {
    var_1 = self setcorpsemodel();

    if(isDefined(var_1)) {
      var_2 = scripts\asm\asm::asm_getdemeanor();
      var_3 = self isstanceallowed("crouch") && var_2 == "combat";

      if(var_3 && getwincost(self, var_1)) {
        return "Exposed Crouch";
      }

      return "Exposed";
    }

    if(scripts\asm\asm_bb::bb_getrequestedstance() == "crouch" || isfixednodeinbadplaceandshouldcrouch() && self isstanceallowed("crouch")) {
      return "Exposed Crouch";
    }

    return "Exposed";
  }

  if(isDefined(self.enemy) && iscoverinvalidagainstenemy(var_3) || shouldinitiallyattackfromexposed(var_3)) {
    if(var_3 doesnodeallowstance("stand") && self isstanceallowed("stand")) {
      return "Exposed";
    } else if(var_3 doesnodeallowstance("crouch") && self isstanceallowed("crouch")) {
      return "Exposed Crouch";
    } else {
      return "Cover Prone";
    }
  }

  if(isnode(var_3) && var_3 iscovermultinode()) {
    var_4 = scripts\engine\utility::getbestcovermultinodetype(var_3);

    if(isDefined(var_4) && var_4 != var_3.type) {
      var_3 setcovermultinodetype(var_4);
    }
  }

  var_5 = var_3.type;
  var_6 = allowlmgarrival();

  if(var_6) {
    switch (var_5) {
      case "Cover Prone":
      case "Cover Crouch":
        return "Cover Crouch LMG";
      case "Cover Stand":
        return "Cover Stand LMG";
    }
  }

  if(isDefined(self._blackboard.croucharrivaltype) && !var_6) {
    return self._blackboard.croucharrivaltype;
  }

  return self choosearrivaltype(var_3, var_5);
}

function shouldstrafe(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && !self.facemotion && self.allowstrafe;
}

function shouldabortstrafe(var_0, var_1, var_2, var_3) {
  if(!shouldstrafe(var_0, var_1, var_2, var_3)) {
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

function chooseanimmovetype(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
    return scripts\asm\asm::asm_chooseanim(var_0, var_1, var_2);
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

function transition_isflashed(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::isflashed();
}

function transition_isburning(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.isburning) && !istrue(self.damageshield);
}

function isdeafened(var_0, var_1, var_2, var_3) {
  var_4 = self.damagetaken;

  if(isDefined(self.paindamage)) {
    var_4 = self.paindamage;
  }

  if(scripts\common\utility::isdamageweapon(getcompleteweaponname("iw7_sonic")) && self.damagemod != "MOD_MELEE" && var_4 >= 75) {
    return true;
  }

  return false;
}

function isspecialpain(var_0, var_1, var_2, var_3) {
  return true;
}

function shouldreacttolight(var_0, var_1, var_2, var_3) {
  if(isDefined(self.lightreaction_requesttime) && self.lightreaction_requesttime >= gettime() - 1000) {
    var_4 = getbasearchetype();

    if(isspeedwithincqbrange(var_4, self aigetdesiredspeed())) {
      return true;
    }
  }

  return false;
}

function chooselightreactionanim(var_0, var_1, var_2) {
  var_3 = "center";

  if(!isDefined(self.lightreaction_lightorigin)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }

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

  if(var_8 >= 0.866) {
    var_6 = "center";
  } else if(var_7) {
    var_6 = "right";
  } else {
    var_6 = "left";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_4, var_6);
}

function isshocked(var_0, var_1, var_2, var_3) {
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
  var_0 = -1 * self.damagedir;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);

  if(var_2 > 0.707) {
    return "front";
  }

  if(var_2 < -0.707) {
    return "back";
  }

  var_3 = vectorcross(var_1, var_0);

  if(var_3[2] > 0) {
    return "left";
  }

  return "right";
}

function gethumandamagedirstring() {
  var_0 = -1 * self.damagedir;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);

  if(var_2 < -0.5) {
    return true;
  }

  return false;
}

function playanimandusegoalweight(var_0, var_1, var_2) {
  GscBinSkip4(0x35, var_1, 0.2);
}

function animscriptedaction_terminate(var_0, var_1, var_2) {
  self orientmode("face angle 3d", self.angles);
  self.gunposeoverride_internal = undefined;

  if(isDefined(self.lookatatrnode)) {
    var_3 = scripts\asm\asm::asm_getheadlookknobifexists();

    if(isDefined(var_3)) {
      self clearanim(var_3, 0.2, self.lookatatrnode);
      self.lookatatrnode = undefined;
      return;
    }

    return;
  }
}

function animsriptedactioncivilian_terminate(var_0, var_1, var_2) {
  if(isDefined(self.lookatatrnode)) {
    var_3 = scripts\asm\asm::asm_getheadlookknobifexists();

    if(isDefined(var_3)) {
      self clearanim(var_3, 0.2, self.lookatatrnode);
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

function animscriptedstartup(var_0, var_1, var_2) {
  self.ht_on = undefined;
  self stoplookat();
}

function animscriptedcleanup(var_0, var_1, var_2) {
  cleanupanimscriptedheadlook();
}

function animscriptedaction_cleanup(var_0, var_1, var_2) {
  cleanupanimscriptedheadlook();
}

function disabledefaultfacialanims(var_0) {
  if(!isDefined(self.headknob)) {
    self.headknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "head"));
  }

  if(!isDefined(var_0) || var_0) {
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

function setfacialindexfornonai(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, "none", 0);
}

function setfacialstate(var_0) {
  self.facialstate = var_0;
}

function clearfacialstate(var_0) {
  self.facialstate = "asm";

  if(!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim) {
    scripts\asm\asm::asm_restorefacialanim();
    return;
  }
}

function isfacialstateallowed(var_0) {
  if(!isai(self) && (!isDefined(self.fakeactor_face_anim) || !self.fakeactor_face_anim)) {
    return false;
  }

  if(!isDefined(self.facialstate)) {
    self.facialstate = "asm";
  }

  var_1 = [];
  GscBinSkip0(0x2e, "asm", 0);
}

function getshootfrompos() {
  if(scripts\engine\utility::actor_is3d() || istrue(self.useeyetoshoot)) {
    return self getEye();
  }

  if(isDefined(self.usemuzzlesideoffset) && self.usemuzzlesideoffset) {
    var_0 = self getmuzzlesideoffsetpos();

    if(isDefined(self.usemuzzleheightoffset)) {
      return var_0;
    }

    return (var_0[0], var_0[1], self getEye()[2]);
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

function melee_checktimer(var_0, var_1) {
  if(isDefined(self.meleeignoretimer) && self.meleeignoretimer) {
    return 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    if(!isDefined(anim.meleechargeplayertimers)) {
      return 1;
    }

    if(!isDefined(anim.meleechargeplayertimers[var_0])) {
      return 1;
    }

    return (gettime() > anim.meleechargeplayertimers[var_0]);
  }

  if(!isDefined(anim.meleechargetimers)) {
    return 1;
  }

  if(!isDefined(anim.meleechargetimers[var_0])) {
    return 1;
  }

  return gettime() > anim.meleechargetimers[var_0];
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

function getspeedmatchanimrate(var_0, var_1, var_2) {
  var_3 = length(self.velocity);

  if(var_3 < 1) {
    return 1;
  }

  var_4 = length(getmovedelta(var_0, var_1, var_2));

  if(var_4 < 1) {
    return 1;
  }

  var_5 = getanimlength(var_0) * (var_2 - var_1);
  var_6 = var_4 / var_5;
  return var_3 / var_6;
}

function isentasoldier() {
  return self.unittype == "soldier" || self.unittype == "juggernaut";
}

function isentnotabomber() {
  return self.asmname != "suicidebomber" && self.asmname != "suicidebomber_cp";
}

function demeanorhasblendspace() {
  var_0 = scripts\asm\asm::asm_getdemeanor();
  return var_0 == "combat";
}

function isfixednodeinbadplaceandshouldcrouch() {
  if(self.fixednode && !isDefined(self.node) && isDefined(self.color_node) && self isnodeinbadplace(self.color_node) && self.color_node doesnodeallowstance("crouch")) {
    return true;
  }

  return false;
}

function gethighestallowedstance() {
  var_0 = undefined;
  var_1 = 1;
  var_2 = 1;
  var_3 = 1;

  if(isDefined(self.node) && isatcovernode()) {
    var_1 = self.node doesnodeallowstance("stand");
    var_2 = self.node doesnodeallowstance("crouch");
    var_3 = self.node doesnodeallowstance("prone");
  } else if(!scripts\asm\asm_bb::bb_moverequested() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
    var_4 = self isstanceallowed("crouch");

    if(var_4 && isfixednodeinbadplaceandshouldcrouch()) {
      return "crouch";
    }

    var_5 = distancesquared(self.origin, self._blackboard.shootparams_pos);

    if(var_5 > 262144 && var_4 && !scripts\engine\utility::actor_is3d() && !scripts\anim\utility_common::isusingsidearm()) {
      var_4 = 1;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 16 && !self.node doesnodeallowstance("crouch")) {
        var_4 = abs(angleclamp180(self.node.angles[1] - self.angles[1])) > 90;
      }

      if(var_4) {
        if(sighttracepassed(self.origin + (0, 0, 32), self._blackboard.shootparams_pos, 0, undefined)) {
          return "crouch";
        }
      }
    }
  }

  for(;;) {
    if(self isstanceallowed("stand") && var_1) {
      return "stand";
    }

    if(self isstanceallowed("crouch") && var_2) {
      return "crouch";
    }

    if(self isstanceallowed("prone") && var_3) {
      return "prone";
    }

    if(!var_1 || !var_2 || !var_3) {
      var_1 = 1;
      var_2 = 1;
      var_3 = 1;
      continue;
    }

    break;
  }

  return "crouch";
}

function determinerequestedstance() {
  var_0 = gethighestallowedstance();
  var_1 = scripts\asm\asm_bb::bb_getrequestedstance();
  var_2 = [];
  GscBinSkip0(0x2e, "prone", 0);
}

function mapangleindextonumpad(var_0) {
  var_1 = [2, 3, 6, 9, 8, 7, 4, 1, 2];
  return var_1[var_0];
}

function toggle_poiauto(var_0, var_1, var_2, var_3, var_4) {
  if(var_0) {
    if(!isDefined(self.poiauto)) {
      poiauto_init(var_1, var_2, var_3, var_4);
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

function set_poiauto_constraints(var_0, var_1, var_2, var_3) {
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

  self.poiauto.yawmax = var_0;
  self.poiauto.yawmin = var_1;
  self.poiauto.pitchmin = var_2;
  self.poiauto.pitchmax = var_3;
}

function reset_poiauto_constraints() {
  self.poiauto.yawmax = self.poiauto.og_yawmax;
  self.poiauto.yawmin = self.poiauto.og_yawmin;
  self.poiauto.pitchmin = self.poiauto.og_pitchmin;
  self.poiauto.pitchmax = self.poiauto.og_pitchmax;
}

function toggle_poi(var_0, var_1) {
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
    return;
  }

  var_2 = self aigetdesiredspeed();
  var_3 = getbasearchetype();
  var_4 = getnearestspeedthresholdname(var_3, "fast");
  self aisetdesiredspeed(min(var_2, var_4));

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
  self.poi_firstpoint = var_1;
  self.gunposeoverride = "disable";
}

function shouldinitiallyattackfromexposed(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.node;
  }

  if(isDefined(self._blackboard.shufflenode)) {
    return 0;
  }

  if(isDefined(scripts\asm\asm_bb::bb_getcovernode())) {
    return 0;
  }

  if(isDefined(var_0) && (var_0.type == "Conceal Stand" || var_0.type == "Conceal Crouch")) {
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
    if(!isPlayer(self.enemy) && !isai(self.enemy)) {
      return 0;
    }

    if(isDefined(self._blackboard.shouldinitiallyattackfromexposedtime) && self._blackboard.shouldinitiallyattackfromexposedtime > gettime()) {
      return self._blackboard.shouldinitiallyattackfromexposed;
    }

    if(isai(self.enemy) && !isbot(self.enemy)) {
      var_6 = self.enemy getapproxeyepos();
    } else {
      var_6 = self.enemy getEye();
    }

    var_7 = undefined;

    if(isDefined(var_6)) {
      var_7 = var_6.origin + (0, 0, 56);
      self._blackboard.shouldinitiallyattackfromexposed = sighttracepassed(var_7, var_6, 0, undefined);
    } else if(istrue(self.brjugg_watchstartnotify)) {
      var_8 = 0;

      if(isDefined(self.pathgoalpos)) {
        if(issentient(self.enemy)) {
          var_8 = enablegroundwarspawnlogic(self.pathgoalpos, self.enemy);
        } else {
          var_8 = enablegroundwarspawnlogic(self.pathgoalpos, self.enemy.origin);
        }
      } else if(issentient(self.enemy)) {
        var_8 = self hastacvis(self.enemy);
      } else {
        var_8 = enablegroundwarspawnlogic(self.origin, self.enemy.origin);
      }

      self._blackboard.shouldinitiallyattackfromexposed = var_8;
    } else {
      return 0;
    }

    self._blackboard.shouldinitiallyattackfromexposedtime = gettime() + 1000;
    return self._blackboard.shouldinitiallyattackfromexposed;
  }

  self._blackboard.shouldinitiallyattackfromexposed = 0;
  return 0;
}

function cover_canattackfromexposed(var_0, var_1) {
  if(!isPlayer(self.enemy) && !isai(self.enemy)) {
    return 1;
  }

  if(cover_canattackfromexposedcached()) {
    return cover_canattackfromexposedgetcache();
  }

  if(!isDefined(var_1)) {
    var_1 = self.covernode;
  }

  if(!isDefined(var_1)) {
    var_1 = self.node;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = gethighestallowedstance();
  var_3 = 56;

  if(var_2 != "stand") {
    var_3 = 32;
  }

  var_4 = var_1.origin + (0, 0, var_3);

  if(!isDefined(var_0)) {
    if(isai(self.enemy) && !isbot(self.enemy)) {
      var_0 = self.enemy getapproxeyepos();
    } else {
      var_0 = self.enemy getEye();
    }
  }

  var_5 = 1000;
  self._blackboard.canattackfromexposed = sighttracepassed(var_4, var_0, 0, undefined);
  self._blackboard.canattackfromexposedtime = gettime() + var_5;
  return self._blackboard.canattackfromexposed;
}

function cover_canattackfromexposedcached() {
  return isDefined(self._blackboard.canattackfromexposedtime) && self._blackboard.canattackfromexposedtime > gettime();
}

function cover_canattackfromexposedgetcache() {
  return self._blackboard.canattackfromexposed;
}

function iscoverinvalidagainstenemy(var_0) {
  if(!isDefined(var_0)) {
    var_1 = iscovervalid();
  } else {
    var_1 = iscovernodevalid(var_1);
  }

  return !var_1 && !fixednodeshouldsticktocover(var_1) && cover_canattackfromexposed(undefined, var_1);
}

function fixednodeshouldsticktocover(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.node;
  }

  if(!self.fixednode) {
    return 0;
  }

  if(isDefined(self.enemy.node) && !nodesvisible(var_0, self.enemy.node)) {
    return 1;
  }

  if(!self seerecently(self.enemy, 8)) {
    return 1;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return 1;
  }

  if(distancesquared(var_0.origin, self.enemy.origin) > 4096) {
    if(!isDefined(self._blackboard.fixedshouldsticktocovertime) || self._blackboard.fixedshouldsticktocovertime < gettime()) {
      var_1 = (0, 0, 50);
      var_2 = vectorNormalize(self.enemy.origin - var_0.origin);
      var_3 = var_0.origin + var_1;
      var_4 = var_3 + var_2 * 64;
      self._blackboard.fixedshouldsticktocovertime = gettime() + 1050;
      self._blackboard.fixedshouldsticktocovercached = !scripts\engine\trace::_bullet_trace_passed(var_3, var_4, 0, self);
    }

    return self._blackboard.fixedshouldsticktocovercached;
  }

  return 0;
}

function iscovernodevalid(var_0) {
  return istrue(self.ignorecovervalidity) || self iscovervalidagainstenemy(var_0);
}

function iscovervalid() {
  return istrue(self.ignorecovervalidity) || self iscovervalidagainstenemy();
}

function addoverridearchetypepriority(var_0) {
  level.archetypeoverridepriorities[var_0] = level.archetypeoverridepriorities.size;
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

function setoverridearchetype(var_0, var_1, var_2) {
  setupoverridearchetypeprioritytable();
  var_3 = level.archetypeoverridepriorities[var_0];

  if(!isDefined(self.archetypeoverrides)) {
    setbasearchetype(self.asm.archetype);
  }

  clearoverridearchetype(var_0, 1);
  var_4 = spawnStruct();
  var_4.archetypepriority = var_3;
  var_4.archetype = var_1;
  self.archetypeoverrides = scripts\engine\utility::array_add(self.archetypeoverrides, var_4);
  pickoverridearchetype(var_2);
}

function clearoverridearchetype(var_0, var_1, var_2) {
  if(self.archetypeoverrides.size == 0) {
    return;
  }

  var_3 = level.archetypeoverridepriorities[var_0];
  var_4 = [];

  foreach(var_6 in self.archetypeoverrides) {
    if(var_6.archetypepriority != var_3) {
      var_4 = var_6;
    }
  }

  self.archetypeoverrides = var_4;

  if(!istrue(var_1)) {
    pickoverridearchetype(var_2);
    return;
  }
}

function pickoverridearchetype(var_0) {
  self.changearchetype = undefined;
  var_1 = undefined;

  foreach(var_3 in self.archetypeoverrides) {
    if(!isDefined(var_1) || var_3.archetypepriority > var_1.archetypepriority) {
      var_1 = var_3;
    }
  }

  if(self.asm.archetype == var_1.archetype) {
    return;
  }

  if(istrue(var_0)) {
    self.animationarchetype = var_1.archetype;
    self.asm.archetype = var_1.archetype;
    self setanimset(var_1.archetype);
    return;
  }

  self.changearchetype = var_1.archetype;
}

function findoverridearchetype(var_0) {
  var_1 = level.archetypeoverridepriorities[var_0];

  foreach(var_3 in self.archetypeoverrides) {
    if(var_3.archetypepriority == var_1) {
      return var_3.archetype;
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

function setbasearchetype(var_0) {
  if(!isDefined(self.archetypeoverrides)) {
    self.archetypeoverrides = [];
    setoverridearchetype("default", self.asm.archetype);
  }

  setoverridearchetype("base", var_0);
  self.basearchetype = var_0;
}

function poiauto_init(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 15;
  }

  if(!isDefined(var_1)) {
    var_1 = 35;
  }

  if(!isDefined(var_2)) {
    var_2 = -20;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self.poiauto = spawnStruct();
  self.poiauto.yawmax = var_1;
  self.poiauto.yawmin = var_0;
  self.poiauto.pitchmin = var_2;
  self.poiauto.pitchmax = var_3;
}

function poiauto_think() {
  self endon("poiauto_disable");
  self endon("death");
  var_0 = 500;
  var_1 = 0;
  var_2 = 0;
  var_3 = gettime() + 30000;
  jumpiftrue(isDefined(self.poiauto)) LOC_00000031;
  poiauto_init();

  for(;;) {
    var_4 = 0;

    if(var_3 <= gettime()) {
      self.poiauto_angles = (0, 0, 0);

      if(var_3 == var_1) {
        var_4 = 1;
      }
    }

    if(var_1 <= gettime()) {
      var_3 = gettime() + int(randomfloatrange(0.8, 1.8) * 1000);
      var_2 = gettime();
      poiauto_setnewaimangle(var_4);
      var_5 = var_0 - gettime();
      var_6 = var_3 - gettime();

      if(abs(var_6 - var_5) >= 550 && scripts\engine\utility::cointoss()) {
        var_1 = var_3;
      } else if(var_5 > 3000) {
        var_1 = gettime() + randomintrange(2000, 3000);
      } else {
        var_1 = gettime() + var_5 + 550 + randomintrange(1000, 2000);
      }
    }

    waitframe();
  }
}

function poiauto_relativeangletopos(var_0) {
  var_1 = anglesToForward(var_0);
  var_2 = rotatevector(var_1, self.angles);
  var_3 = self getapproxeyepos();
  var_4 = var_3 + var_2 * 128;
  return var_4;
}

function poiauto_glancerandom() {
  var_0 = randomfloatrange(-45, 45);
  var_1 = randomfloatrange(-20, 20);
  var_2 = poiauto_relativeangletopos((var_1, var_0, 0));
  self.poiauto.glancing = 1;
  thread poiauto_glanceend();
  self glanceatpos(var_2);
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

function poiauto_setnewaimangle(var_0) {
  jumpiffalse(var_0) LOC_00000046;
  var_1 = randomfloatrange(self.poiauto_angles[1] + 5, self.poiauto_angles[1] + 10);
  var_2 = randomfloatrange(5, 10);

  if(scripts\engine\utility::cointoss()) {
    var_2 *= -1;
  }

  var_2 = self.poiauto_angles[0] + var_2;
  goto LOC_00000079;
}

function preventrecentanimindex(var_0, var_1, var_2) {
  var_3 = self.asm.archetype;

  if(isDefined(self.animationarchetype)) {
    var_3 = self.animationarchetype;
  }

  if(!isDefined(anim.recentindices)) {
    anim.recentindices = [];
  }

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
      GscBinSkip0(0x2e, var_7, var_4);
    }

    GscBinSkip0(0x2e, var_8, var_10[var_8] + 1);
  }

  anim.recentindices[var_10] = [];
  var_16 = scripts\asm\asm::asm_getallanimsforstate(var_1);

  for(var_14 = 0; var_14 < var_16.size; var_14++) {
    anim.recentindices[var_10][var_14] = [0, 0];
  }

  anim.recentindices[var_10][var_3][var_8] = var_5;
  anim.recentindices[var_10][var_3][var_9] = 1;
  return var_3;
}

function intro_addplayer(var_0, var_1, var_2, var_3) {
  if(isDefined(self.intro_heli_animate_player)) {
    return self[[self.intro_heli_animate_player]](var_0, var_1, var_2, var_3);
  }

  return 0;
}