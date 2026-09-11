/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\traverse.gsc
***********************************************/

function playtraversearrivalanim(var0, var1, var2) {
  self endon("dealth");
  self endon("terminate_ai_threads");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  scripts\asm\asm_bb::bb_requeststance("stand");
  var5 = self getnegotiationstartnode();

  if(!isDefined(var5) && isDefined(self.traversal_start_node)) {
    var5 = self.traversal_start_node;
  }

  if(isDefined(var5.traverse_height_delta)) {
    var5.traverse_height = var5.origin[2] + var5.traverse_height_delta;
  }

  var6 = self getnegotiationendnode();

  if(!isDefined(var6) && isDefined(self.traversal_end_node)) {
    var6 = self.traversal_end_node;
  }

  if(isDefined(var6)) {}

  self.traversestartnode = var5;
  self.traverseendnode = var6;
  self animmode("noclip");
  self.traversestartz = self.origin[2];
  self orientmode("face angle", self.angles[1]);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  self.traversexanim = var4;
  self.traverseanimroot = scripts\asm\asm::asm_getbodyknob();
  self aisetanim(var1, var3);
  self starttraversearrival(120);
  self.traversedeathindex = 0;
  self.traversedeathanim = undefined;
  self.useanimgoalweight = 1;
  var7 = scripts\asm\asm::asm_donotetracks(var0, var1, &handletraversearrivalwarpnotetracks);
  self animmode("gravity");

  if(self.delayeddeath) {
    scripts\asm\soldier\traverse::terminatetraverse(var0, var1);
    return;
  }
}

function playtraverseanim_scaled(var0, var1, var2) {
  self endon("death");
  self endon("terminate_ai_threads");
  checktraverse(var1);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  scripts\asm\asm_bb::bb_requeststance("stand");

  if(!animisleaf(var4)) {
    var5 = self getnegotiationendnode();

    if(!isDefined(var5) && isDefined(self.traversal_end_node)) {
      var5 = self.traversal_end_node;
    }

    if(isDefined(var5)) {
      self forceteleport(var5.origin, self.angles);
    }

    scripts\asm\soldier\traverse::terminatetraverse(var0, var1);
    return;
  }

  var6 = getnotetracktimes(var5, "code_move");

  if(var6.size > 0) {
    thread scripts\asm\shared\utility::waitforcoverapproach(var1, var2);
    thread scripts\asm\shared\utility::waitforsharpturn(var1, var2);
  }

  var7 = self getnegotiationstartnode();

  if(!isDefined(var7) && isDefined(self.traversal_start_node)) {
    var7 = self.traversal_start_node;
  }

  if(isDefined(var7.traverse_height_delta)) {
    var7.traverse_height = var7.origin[2] + var7.traverse_height_delta;
  }

  var5 = self getnegotiationendnode();

  if(!isDefined(var5) && isDefined(self.traversal_end_node)) {
    var5 = self.traversal_end_node;
  }

  if(isDefined(var5)) {}

  self.traversestartnode = var7;
  self.traverseendnode = var5;
  self animmode("noclip");
  self.traversestartz = self.origin[2];
  self orientmode("face angle", self.angles[1]);
  var8 = shouldusewarpnotetracks(var5);
  var9 = shouldusewarparrival(var5);

  if(var8) {
    var10 = &handletraversewarpnotetracks;
  } else {
    var10 = &scripts\asm\soldier\traverse::handletraverselegacynotetracks;
    self orientmode("face angle", var5.angles[1]);

    if(!animhasnotetrack(var6, "traverse_align")) {
      scripts\asm\soldier\traverse::handletraversealignment();
    }
  }

  scripts\asm\asm::asm_playfacialanim(var2, var3, var6);
  self.traversexanim = var6;
  self.traverseanimroot = scripts\asm\asm::asm_getbodyknob();

  if(var3 == "traverse_external") {
    self aisetanim(var3, 0);
    self clearanim(scripts\asm\asm::asm_getinnerrootknob(), 0.2);
    self setflaggedanim(var3, self.traversexanim);
  } else {
    self aisetanim(var3, var5);
  }

  if(var10 && !isagent(self) && (!isDefined(self.traversearrival) || isDefined(self.traversearrival.doarrival) && !self.traversearrival.doarrival)) {
    var11 = getnotetracktimes(var6, "warp_arrival_end")[0];
    self setanimtime(var6, var11);
  }

  self.traversedeathindex = 0;
  self.traversedeathanim = undefined;
  self.useanimgoalweight = 1;
  var12 = scripts\asm\asm::asm_donotetracks(var2, var3, var10);

  if(var12 == "code_move") {
    if(isDefined(self.pathgoalpos)) {
      self motionwarpcancel();
      self animmode("normal");
      self orientmode("face motion");
    }

    if(!scripts\asm\asm::asm_eventfired(var2, "finish") && !scripts\asm\asm::asm_eventfired(var2, "end")) {
      scripts\asm\asm::asm_donotetracks(var2, var3, var10);
    }
  }

  self animmode("gravity");

  if(self.delayeddeath) {
    scripts\asm\soldier\traverse::terminatetraverse(var2, var3);
    return;
  }

  self.a.nodeath = 0;
  self.a.movement = "run";
  self.traverseanimroot = undefined;
  self.traversexanim = undefined;
  self.deathanim = undefined;
  self.traversestartnode = undefined;
  scripts\asm\soldier\traverse::terminatetraverse(var2, var3);
}

function shouldusewarpnotetracks(var0) {
  if(animhasnotetrack(var0, "warp_up_start")) {
    return true;
  }

  if(animhasnotetrack(var0, "warp_across_start")) {
    return true;
  }

  if(animhasnotetrack(var0, "warp_down_start")) {
    return true;
  }

  return false;
}

function shouldusewarparrival(var0) {
  if(animhasnotetrack(var0, "warp_arrival_start")) {
    return true;
  }

  return false;
}

function setuptraversaltransitioncheck(var0, var1, var2) {
  var3 = self getnearbynegotiationinfo(120);

  if(!isDefined(var3)) {
    return false;
  }

  var4 = var3["node"];
  var5 = var3["position"];
  var6 = var3["finish"];

  if(!isDefined(var4) || !isDefined(var4.animscript)) {
    return false;
  }

  self.traversal_start_node = var4;
  self.traversal_end_pos = var5;
  self.traversal_end_node = var6;
  return true;
}

function shoulddotraversalarrival(var0, var1, var2, var3) {
  if(self.traversearrival.traversetype != var3) {
    return false;
  }

  if(!isDefined(self.traversalhasarrival)) {
    return false;
  }

  if(!self.traversalhasarrival) {
    return false;
  }

  var4 = distance2d(self.traversal_start_node.origin, self.origin);
  var5 = anim.traversals.arrivaldata[self.traversearrival.traversetype][self.traversearrival.alias].translationdelta;
  var6 = length2d(var5);
  var7 = var4 - var6;

  if(var7 > 10) {
    return false;
  }

  return true;
}

function shouldconsidertraversearrival(var0, var1, var2, var3) {
  if(!isDefined(self.traversal_start_node)) {
    return false;
  }

  if(!supportstraversearrival(self.traversal_start_node.animscript)) {
    return false;
  }

  var4 = distance2d(self.origin, self.traversal_start_node.origin);

  if(var4 > 120) {
    return false;
  }

  return true;
}

function shouldstarttraverse(var0, var1, var2, var3) {
  if(self.traversearrival.traversetype != var3) {
    return false;
  }

  if(!self maymovefrompointtopoint(self.origin, self.traversal_start_node.origin)) {
    return false;
  }

  var4 = distance2d(self.traversal_start_node.origin, self.origin);

  if(var4 < 4) {
    self.traversearrival.doarrival = 0;
    return true;
  }

  var5 = anim.traversals.arrivaldata[self.traversearrival.traversetype][self.traversearrival.alias].translationdelta;
  var6 = length2d(var5);
  var7 = abs(var4 - var6);

  if(var7 > 10) {
    return false;
  }

  return true;
}

function shoulddotraditionaltraverse(var0, var1, var2, var3) {
  if(self.traversearrival.traversetype != var3) {
    return false;
  }

  return true;
}

function traverse_cleanup(var0, var1, var2) {
  self motionwarpcancel();
  self finishtraverse();
  self.traversearrival = undefined;
}

function calctraversetype(var0, var1, var2) {
  if(isDefined(self.traversearrival) && self.traversearrival.node == self.traversal_start_node) {
    return;
  }

  self.traversearrival = spawnStruct();
  self.traversearrival.traversetype = self.traversal_start_node.animscript;
  self.traversearrival.node = self.traversal_start_node;
  var3 = [];
  GscBinSkip0(0x2e, "height", self.traversal_start_node.traverse_height_delta);
}

function traversechooseanim(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(self.traversearrival) && isDefined(self.traversearrival.traversetype) && isDefined(self.traversearrival.alias)) {
    var1 = self.traversearrival.traversetype;
    var3 = self.traversearrival.alias;
  } else {
    var4 = setuptraversaltransitioncheck(var0, var1, var2);
    calctraversetype(var0, var1, var2);
    var5 = distance2d(self.traversal_start_node.origin, self.origin);

    if(var5 < 4) {
      self.traversearrival.doarrival = 0;
    }

    var1 = self.traversearrival.traversetype;
    var3 = self.traversearrival.alias;
  }

  return scripts\asm\asm::asm_chooseanim(var0, var1, var3);
}

function supportstraversearrival(var0) {
  switch (var0) {
    case "traverse_warp_external":
    case "traverse_warp_across":
    case "traverse_warp_over":
    case "traverse_warp_down":
    case "traverse_warp_up":
      return true;
  }

  return false;
}

function handletraversearrivalwarpnotetracks(var0) {
  if(var0 == "warp_arrival_start") {
    return handlewarparrivalnotetrack();
  }
}

function handletraversewarpnotetracks(var0) {
  if(var0 == "traverse_death") {
    return scripts\asm\soldier\traverse::handletraversedeathnotetrack();
  }

  if(var0 == "warp_arrival_start") {
    return handlewarparrivalnotetrack();
  }

  if(var0 == "warp_up_start") {
    return handlewarpupnotetrack();
  }

  if(var0 == "warp_across_start") {
    return handlewarpacrossnotetrack();
  }

  if(var0 == "warp_down_start") {
    return handlewarpdownstartnotetrack();
  }

  if(var0 == "warp_down_end") {
    return handlewarpdownendnotetrack();
  }
}

function handlewarparrivalnotetrack() {
  self animmode("noclip");
  var0 = self.traversestartnode.origin;
  var1 = self.traversestartnode.angles;
  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var0, var1, "warp_arrival_start", "warp_arrival_end");
}

function handlewarpupnotetrack() {
  self animmode("noclip");
  var0 = self.traversestartnode.origin + self.traversestartnode.apex_delta;
  var1 = self.traversestartnode.angles;

  if(animhasnotetrack(self.traversexanim, "warp_up_apex")) {
    var2 = getnotetracktimes(self.traversexanim, "warp_up_start")[0];
    var3 = getnotetracktimes(self.traversexanim, "warp_up_end")[0];
    var4 = getanimlength(self.traversexanim);
    var5 = int((var3 - var2) * var4 * 1000);
    scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var0, var1, "warp_up_start", "warp_up_apex", var5);
    return;
  }

  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var0, var1, "warp_up_start", "warp_up_end");
}

function handlewarpacrossnotetrack() {
  self animmode("noclip");
  var0 = self.traverseendnode;

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.angles = self.traversestartnode.angles;
  }

  var1 = self.traversestartnode.origin + self.traversestartnode.apex_delta + self.traversestartnode.across_delta;
  var2 = var0.angles;
  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var1, var2, "warp_across_start", "warp_across_end");
}

function handlewarpdownstartnotetrack() {
  self animmode("noclip");
  var0 = self.traverseendnode;

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.angles = self.traversestartnode.angles;
    var0.origin = self getnegotiationendpos();
  }

  var1 = getnotetracktimes(self.traversexanim, "warp_down_start")[0];
  var2 = getnotetracktimes(self.traversexanim, "warp_down_end")[0];
  var3 = getmovedelta(self.traversexanim, var1, var2);
  var3 = rotatevector(var3, var0.angles);
  var4 = 512;
  var5 = (self.origin[0] + var3[0], self.origin[1] + var3[1], self.origin[2]);
  var6 = getgroundposition(var5, 10, var4, 12);
  var7 = 0.05;

  if(abs((var6[2] - self.origin[2]) / var3[2]) < var7) {
    var6 = var0.origin;
  }

  var8 = self getpointafternegotiation();
  var9 = var0.angles;

  if(!isDefined(var0.origin)) {
    var0.origin = self.traversestartnode.end_node_origin;
  }

  if(isDefined(var8)) {
    var10 = vectortoyaw(var8 - var0.origin);
    var11 = clamp(angleclamp180(var10 - self.angles[1]), -30, 30);
    var10 = angleclamp180(self.angles[1] + var11);
    var9 = (0, var10, 0);
  }

  scripts\engine\utility::motionwarpwithnotetracks(self.traversexanim, var6, var9, "warp_down_start", "warp_down_end");
}

function handlewarpdownendnotetrack() {
  if(!isagent(self)) {
    self setanimrate(self.traversexanim, 1);
  }

  self animmode("gravity");
}

function checktraverse(var0) {}