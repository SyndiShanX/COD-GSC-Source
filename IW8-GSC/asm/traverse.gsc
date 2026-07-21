/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\traverse.gsc
***********************************************/

playtraversearrivalanim(var_0, var_1, var_2) {
  self endon("dealth");
  self endon("terminate_ai_threads");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  scripts\asm\asm_bb::bb_requeststance("stand");
  var_5 = self getnegotiationstartnode();

  if(!isDefined(var_5) && isDefined(self.traversal_start_node))
    var_5 = self.traversal_start_node;

  if(isDefined(var_5.traverse_height_delta))
    var_5.traverse_height = var_5.origin[2] + var_5.traverse_height_delta;

  var_6 = self getnegotiationendnode();

  if(!isDefined(var_6) && isDefined(self.traversal_end_node))
    var_6 = self.traversal_end_node;

  if(!isDefined(var_6)) {}

  self.traversestartnode = var_5;
  self.traverseendnode = var_6;
  self animmode("noclip");
  self.traversestartz = self.origin[2];
  self orientmode("face angle", self.angles[1]);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  self.traversexanim = var_4;
  self.traverseanimroot = scripts\asm\asm::asm_getbodyknob();
  self aisetanim(var_1, var_3);
  self starttraversearrival(120);
  self.traversedeathindex = 0;
  self.traversedeathanim = undefined;
  self.useanimgoalweight = 1;
  var_7 = scripts\asm\asm::asm_donotetracks(var_0, var_1, ::handletraversearrivalwarpnotetracks);
  self animmode("gravity");

  if(self.delayeddeath) {
    scripts\asm\soldier\traverse::terminatetraverse(var_0, var_1);
    return;
  }
}

playtraverseanim_scaled(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  checktraverse(var_1);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  scripts\asm\asm_bb::bb_requeststance("stand");

  if(!animisleaf(var_4)) {
    var_5 = self getnegotiationendnode();

    if(!isDefined(var_5) && isDefined(self.traversal_end_node))
      var_5 = self.traversal_end_node;

    if(isDefined(var_5))
      self forceteleport(var_5.origin, self.angles);

    scripts\asm\soldier\traverse::terminatetraverse(var_0, var_1);
    return;
  }

  var_6 = getnotetracktimes(var_4, "code_move");

  if(var_6.size > 0) {
    thread scripts\asm\shared\utility::waitforcoverapproach(var_0, var_1);
    thread scripts\asm\shared\utility::waitforsharpturn(var_0, var_1);
  }

  var_7 = self getnegotiationstartnode();

  if(!isDefined(var_7) && isDefined(self.traversal_start_node))
    var_7 = self.traversal_start_node;

  if(isDefined(var_7.traverse_height_delta))
    var_7.traverse_height = var_7.origin[2] + var_7.traverse_height_delta;

  var_5 = self getnegotiationendnode();

  if(!isDefined(var_5) && isDefined(self.traversal_end_node))
    var_5 = self.traversal_end_node;

  if(!isDefined(var_5)) {}

  self.traversestartnode = var_7;
  self.traverseendnode = var_5;
  self animmode("noclip");
  self.traversestartz = self.origin[2];
  self orientmode("face angle", self.angles[1]);
  var_8 = shouldusewarpnotetracks(var_4);
  var_9 = shouldusewarparrival(var_4);

  if(var_8)
    var_10 = ::handletraversewarpnotetracks;
  else {
    var_10 = scripts\asm\soldier\traverse::handletraverselegacynotetracks;
    self orientmode("face angle", var_7.angles[1]);

    if(!animhasnotetrack(var_4, "traverse_align"))
      scripts\asm\soldier\traverse::handletraversealignment();
  }

  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  self.traversexanim = var_4;
  self.traverseanimroot = scripts\asm\asm::asm_getbodyknob();

  if(var_1 == "traverse_external") {
    self aisetanim(var_1, 0);
    self clearanim(scripts\asm\asm::asm_getinnerrootknob(), 0.2);
    self setflaggedanim(var_1, self.traversexanim);
  } else
    self aisetanim(var_1, var_3);

  if(var_9 && !isagent(self) && (!isDefined(self.traversearrival) || isDefined(self.traversearrival.doarrival) && !self.traversearrival.doarrival)) {
    var_11 = getnotetracktimes(var_4, "warp_arrival_end")[0];
    self setanimtime(var_4, var_11);
  }

  self.traversedeathindex = 0;
  self.traversedeathanim = undefined;
  self.useanimgoalweight = 1;
  var_12 = scripts\asm\asm::asm_donotetracks(var_0, var_1, var_10);

  if(var_12 == "code_move") {
    if(isDefined(self.pathgoalpos)) {
      self motionwarpcancel();
      self animmode("normal");
      self orientmode("face motion");
    }

    if(!scripts\asm\asm::asm_eventfired(var_0, "finish") && !scripts\asm\asm::asm_eventfired(var_0, "end"))
      scripts\asm\asm::asm_donotetracks(var_0, var_1, var_10);
  }

  self animmode("gravity");

  if(self.delayeddeath) {
    scripts\asm\soldier\traverse::terminatetraverse(var_0, var_1);
    return;
  }

  self.a.nodeath = 0;
  self.a.movement = "run";
  self.traverseanimroot = undefined;
  self.traversexanim = undefined;
  self.deathanim = undefined;
  self.traversestartnode = undefined;
  scripts\asm\soldier\traverse::terminatetraverse(var_0, var_1);
}

shouldusewarpnotetracks(var_0) {
  if(animhasnotetrack(var_0, "warp_up_start"))
    return 1;

  if(animhasnotetrack(var_0, "warp_across_start"))
    return 1;

  if(animhasnotetrack(var_0, "warp_down_start"))
    return 1;

  return 0;
}

shouldusewarparrival(var_0) {
  if(animhasnotetrack(var_0, "warp_arrival_start"))
    return 1;

  return 0;
}

setuptraversaltransitioncheck(var_0, var_1, var_2) {
  var_3 = self getnearbynegotiationinfo(120);

  if(!isDefined(var_3))
    return 0;

  var_4 = var_3["node"];
  var_5 = var_3["position"];
  var_6 = var_3["finish"];

  if(!isDefined(var_4) || !isDefined(var_4.animscript))
    return 0;

  self.traversal_start_node = var_4;
  self.traversal_end_pos = var_5;
  self.traversal_end_node = var_6;
  return 1;
}

shoulddotraversalarrival(var_0, var_1, var_2, var_3) {
  if(self.traversearrival.traversetype != var_3)
    return 0;

  if(!isDefined(self.traversalhasarrival))
    return 0;

  if(!self.traversalhasarrival)
    return 0;

  var_4 = distance2d(self.traversal_start_node.origin, self.origin);
  var_5 = anim.traversals.arrivaldata[self.traversearrival.traversetype][self.traversearrival.alias].translationdelta;
  var_6 = length2d(var_5);
  var_7 = var_4 - var_6;

  if(var_7 > 10)
    return 0;

  return 1;
}

shouldconsidertraversearrival(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.traversal_start_node))
    return 0;

  if(!supportstraversearrival(self.traversal_start_node.animscript))
    return 0;

  var_4 = distance2d(self.origin, self.traversal_start_node.origin);

  if(var_4 > 120)
    return 0;

  return 1;
}

shouldstarttraverse(var_0, var_1, var_2, var_3) {
  if(self.traversearrival.traversetype != var_3)
    return 0;

  if(!self maymovefrompointtopoint(self.origin, self.traversal_start_node.origin))
    return 0;

  var_4 = distance2d(self.traversal_start_node.origin, self.origin);

  if(var_4 < 4) {
    self.traversearrival.doarrival = 0;
    return 1;
  }

  var_5 = anim.traversals.arrivaldata[self.traversearrival.traversetype][self.traversearrival.alias].translationdelta;
  var_6 = length2d(var_5);
  var_7 = abs(var_4 - var_6);

  if(var_7 > 10)
    return 0;

  return 1;
}

shoulddotraditionaltraverse(var_0, var_1, var_2, var_3) {
  if(self.traversearrival.traversetype != var_3)
    return 0;

  return 1;
}

traverse_cleanup(var_0, var_1, var_2) {
  self motionwarpcancel();
  self finishtraverse();
  self.traversearrival = undefined;
}

calctraversetype(var_0, var_1, var_2) {
  if(isDefined(self.traversearrival) && self.traversearrival.node == self.traversal_start_node) {
    return;
  }
  self.traversearrival = spawnStruct();
  self.traversearrival.traversetype = self.traversal_start_node.animscript;
  self.traversearrival.node = self.traversal_start_node;
  var_3 = [];
  var_3["height"] = self.traversal_start_node.traverse_height_delta;
  var_3["drop_height"] = self.traversal_start_node.traverse_drop_height_delta;
  var_3["arrival_yaw"] = angleclamp180(self.traversal_start_node.angles[1] - self.angles[1]);
  var_3["speed"] = self aigettargetspeed();

  if(self.traversearrival.traversetype == "traverse_warp_across")
    var_3["length"] = length2d(self.traversal_start_node.across_delta);

  var_4 = scripts\anim\animselector.gsc::selectanim(self.traversearrival.traversetype, var_3);
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(self.traversearrival.traversetype, var_4);
  var_6 = scripts\asm\asm::asm_getxanim(self.traversearrival.traversetype, var_5);
  self.traversearrival.alias = var_4;
  var_7 = self.traversearrival.traversetype + "_arrival";
  self.traversalhasarrival = 0;
  var_8 = undefined;
  var_9 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_7, var_4);

  if(isDefined(var_9)) {
    var_8 = scripts\asm\asm::asm_getxanim(var_7, var_9);
    self.traversalhasarrival = 1;
    self.traversearrival.doarrival = 1;
  } else {}

  if(!isDefined(anim.traversals)) {
    anim.traversals = spawnStruct();
    anim.traversals.arrivaldata = [];
  }

  if(!isDefined(anim.traversals.arrivaldata[self.traversearrival.traversetype]))
    anim.traversals.arrivaldata[self.traversearrival.traversetype] = [];

  if(!isDefined(anim.traversals.arrivaldata[self.traversearrival.traversetype][var_4])) {
    var_10 = var_6;

    if(isDefined(var_8))
      var_10 = var_8;

    var_11 = getnotetracktimes(var_10, "warp_arrival_start")[0];
    var_12 = getnotetracktimes(var_10, "warp_arrival_end")[0];
    var_13 = getnotetracktimes(var_10, "finish")[0];
    var_14 = getmovedelta(var_10, 0, var_13);
    anim.traversals.arrivaldata[self.traversearrival.traversetype][var_4] = spawnStruct();
    anim.traversals.arrivaldata[self.traversearrival.traversetype][var_4].arrivalxanim = var_10;
    anim.traversals.arrivaldata[self.traversearrival.traversetype][var_4].translationdelta = var_14;
    anim.traversals.arrivaldata[self.traversearrival.traversetype][var_4].warpstart = var_11;
    anim.traversals.arrivaldata[self.traversearrival.traversetype][var_4].warpend = var_12;
  }
}

traversechooseanim(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self.traversearrival) && isDefined(self.traversearrival.traversetype) && isDefined(self.traversearrival.alias)) {
    var_1 = self.traversearrival.traversetype;
    var_3 = self.traversearrival.alias;
  } else {
    var_4 = setuptraversaltransitioncheck(var_0, var_1, var_2);
    calctraversetype(var_0, var_1, var_2);
    var_5 = distance2d(self.traversal_start_node.origin, self.origin);

    if(var_5 < 4)
      self.traversearrival.doarrival = 0;

    var_1 = self.traversearrival.traversetype;
    var_3 = self.traversearrival.alias;
  }

  return scripts\asm\asm::asm_chooseanim(var_0, var_1, var_3);
}

supportstraversearrival(var_0) {
  switch (var_0) {
    case "traverse_warp_external":
    case "traverse_warp_across":
    case "traverse_warp_over":
    case "traverse_warp_down":
    case "traverse_warp_up":
      return 1;
  }

  return 0;
}

handletraversearrivalwarpnotetracks(var_0) {
  if(var_0 == "warp_arrival_start")
    return handlewarparrivalnotetrack();
}

handletraversewarpnotetracks(var_0) {
  if(var_0 == "traverse_death")
    return scripts\asm\soldier\traverse::handletraversedeathnotetrack();
  else if(var_0 == "warp_arrival_start")
    return handlewarparrivalnotetrack();
  else if(var_0 == "warp_up_start")
    return handlewarpupnotetrack();
  else if(var_0 == "warp_across_start")
    return handlewarpacrossnotetrack();
  else if(var_0 == "warp_down_start")
    return handlewarpdownstartnotetrack();
  else if(var_0 == "warp_down_end")
    return handlewarpdownendnotetrack();
}

handlewarparrivalnotetrack() {
  self animmode("noclip");
  var_0 = self.traversestartnode.origin;
  var_1 = self.traversestartnode.angles;
  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var_0, var_1, "warp_arrival_start", "warp_arrival_end");
}

handlewarpupnotetrack() {
  self animmode("noclip");
  var_0 = self.traversestartnode.origin + self.traversestartnode.apex_delta;
  var_1 = self.traversestartnode.angles;

  if(animhasnotetrack(self.traversexanim, "warp_up_apex")) {
    var_2 = getnotetracktimes(self.traversexanim, "warp_up_start")[0];
    var_3 = getnotetracktimes(self.traversexanim, "warp_up_end")[0];
    var_4 = getanimlength(self.traversexanim);
    var_5 = int((var_3 - var_2) * var_4 * 1000);
    scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var_0, var_1, "warp_up_start", "warp_up_apex", var_5);
  } else
    scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var_0, var_1, "warp_up_start", "warp_up_end");
}

handlewarpacrossnotetrack() {
  self animmode("noclip");
  var_0 = self.traverseendnode;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.angles = self.traversestartnode.angles;
  }

  var_1 = self.traversestartnode.origin + self.traversestartnode.apex_delta + self.traversestartnode.across_delta;
  var_2 = var_0.angles;
  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var_1, var_2, "warp_across_start", "warp_across_end");
}

handlewarpdownstartnotetrack() {
  self animmode("noclip");
  var_0 = self.traverseendnode;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.angles = self.traversestartnode.angles;
    var_0.origin = self getnegotiationendpos();
  }

  var_1 = getnotetracktimes(self.traversexanim, "warp_down_start")[0];
  var_2 = getnotetracktimes(self.traversexanim, "warp_down_end")[0];
  var_3 = getmovedelta(self.traversexanim, var_1, var_2);
  var_3 = rotatevector(var_3, var_0.angles);
  var_4 = 512;
  var_5 = (self.origin[0] + var_3[0], self.origin[1] + var_3[1], self.origin[2]);
  var_6 = getgroundposition(var_5, 10, var_4, 12);
  var_7 = 0.05;

  if(abs((var_6[2] - self.origin[2]) / var_3[2]) < var_7)
    var_6 = var_0.origin;

  var_8 = self getpointafternegotiation();
  var_9 = var_0.angles;

  if(!isDefined(var_0.origin))
    var_0.origin = self.traversestartnode.end_node_origin;

  if(isDefined(var_8)) {
    var_10 = vectortoyaw(var_8 - var_0.origin);
    var_11 = clamp(angleclamp180(var_10 - self.angles[1]), -30.0, 30.0);
    var_10 = angleclamp180(self.angles[1] + var_11);
    var_9 = (0, var_10, 0);
  }

  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var_6, var_9, "warp_down_start", "warp_down_end");
}

handlewarpdownendnotetrack() {
  if(!isagent(self))
    self setanimrate(self.traversexanim, 1);

  self animmode("gravity");
}

checktraverse(var_0) {}