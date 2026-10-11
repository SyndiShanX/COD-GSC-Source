/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\disguise.gsc
************************************************/

#using script_67015c88c47ec4f8;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vision_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\hud_message;
#using scripts\mp\pmc_missions;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#namespace disguise;

function function_83599506981c29cd() {
  level.var_8c0f3022529be75e = spawnStruct();
  function_38cf81cf267278dc();

  if(level.mapname == "mp_br_mechanics" && getdvarint(@ "hash_8fa9d384348cb11b", 0)) {
    concealprefab = getEnt("player_conceal", "targetname");
    concealclip = spawn("script_model", (0, 0, 0));
    concealclip.angles = (0, 0, 0);
    concealclip clonebrushmodeltoscriptmodel(concealprefab);
    concealclip dontinterpolate();
    level.var_8c0f3022529be75e.concealclip = concealclip;
  }
}

function function_38cf81cf267278dc() {
  if(!isDefined(level.var_8c0f3022529be75e)) {
    return;
  }

  level.var_8c0f3022529be75e.disguises = [];
  function_4981209c2c509828("alqatala", "body_dmz_disguised_al_qatala_iw9_1_1", "head_dmz_disguised_al_qatala_iw9_1_1", "mp_vm_opforce_al_qatala_elite_ar_1_1", "vestlight", "milhvygr");
  function_4981209c2c509828("shadowcompany", "body_dmz_disguised_shadow_company_iw9_1_1", "head_dmz_disguised_shadow_company_iw9_1_1", "mp_vm_opforce_shadow_company_elite_1_1", "nylon", "millghtgr");
  function_4981209c2c509828("konnig", "body_dmz_disguised_unidentified_iw9_1_1", "head_dmz_disguised_unidentified_iw9_1_1", "mp_vm_dmz_disguised_unidentified_iw9_1_1", "nylon", "millghtgr");

  if(issharedfuncdefined("disguise", "disguiseRegisterCustom")) {
    callsharedfunc("disguise", "disguiseRegisterCustom");
  }
}

function function_eb1fe3a0083b03df(factionname) {
  assertex(isDefined(level.var_8c0f3022529be75e.disguises[factionname]), "<dev string:x1c>");
  return level.var_8c0f3022529be75e.disguises[factionname];
}

function function_291a4b6e765bfcc6(factionname) {
  assertex(isDefined(level.var_8c0f3022529be75e.disguises[factionname]), "<dev string:x1c>");
  return level.var_8c0f3022529be75e.disguises[factionname].head;
}

function function_4d2ad5e5595384f0(factionname) {
  assertex(isDefined(level.var_8c0f3022529be75e.disguises[factionname]), "<dev string:x1c>");
  return level.var_8c0f3022529be75e.disguises[factionname].body;
}

function function_aba28cc8c36eeaf7(factionname) {
  assertex(isDefined(level.var_8c0f3022529be75e.disguises[factionname]), "<dev string:x1c>");
  return level.var_8c0f3022529be75e.disguises[factionname].arms;
}

function function_4981209c2c509828(key, body, head, vmarms, cloth, gear) {
  outfitstruct = spawnStruct();
  outfitstruct.body = body;
  outfitstruct.head = head;
  outfitstruct.arms = vmarms;
  outfitstruct.cloth = cloth;
  outfitstruct.gear = gear;
  level.var_8c0f3022529be75e.disguises[key] = outfitstruct;
}

function function_310843b56a04e24c() {
  subarea = scripts\mp\ai_mp_controller::subarea_findfromorigin(self.origin);
  nationality = scripts\mp\ai_mp_controller::function_f851a2f41cffa860();

  if(isDefined(subarea) && isDefined(subarea.nationalityoverride)) {
    nationality = subarea.nationalityoverride;
  }

  return function_eb1fe3a0083b03df(function_466e5ad92c500882(nationality));
}

function function_466e5ad92c500882(nationality) {
  assertex(isDefined(nationality), "<dev string:x6d>");

  if(issharedfuncdefined("disguise", "disguiseNationalityOverride")) {
    return callsharedfunc("disguise", "disguiseNationalityOverride");
  }

  switch (nationality) {
    case #"hash_916b14e9c168191":
    case #"hash_19b89634f50eeda4":
      return "shadowcompany";
    case #"hash_fa18d1f6bd5790c7":
      return "alqatala";
    case #"hash_fa53bdf6bd853c80":
      return "konnig";
    default:
      return "alqatala";
  }
}

function function_67d03e329e13f612(itemslotindex, quantity) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self.operatorcustomization)) {
    return;
  }

  function_7e30d4841d0abe41(1);
  self.disguised = 1;
  function_a1650ef824a7be56(1);
  function_a8cb3b8e739c633e(itemslotindex, quantity);
  self playSound("fly_dmz_disguise_on");
  scripts\mp\pmc_missions::function_2d3c14faa38e2146(self);

  if(!istrue(self.var_859654e0445a36d9)) {
    self forceplaygestureviewmodel("iw9_vm_ges_disguise_on");
  }

  var_a78681b284f9ae0a = getdvarfloat(@ "hash_62171a84e10129ab", 0.35);
  childthread function_9292cbe2dec7d826(var_a78681b284f9ae0a, 1);
  childthread function_b02057aaa6d29ba1(1, var_a78681b284f9ae0a);
  thread function_d8d7a08a9fd9a9f();

  if(issharedfuncdefined("disguise", "disguiseOnUsed")) {
    callsharedfunc("disguise", "disguiseOnUsed");
  }

  scripts\engine\utility::delaythread(var_a78681b284f9ae0a, &function_7e30d4841d0abe41, 0);
}

function function_a8cb3b8e739c633e(itemslotindex, quantity) {
  if(!isDefined(quantity)) {
    quantity = 108;
  }

  dstruct = spawnStruct();
  dstruct.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(self);
  dstruct.head = self.operatorcustomization.head;
  dstruct.body = self.operatorcustomization.body;
  dstruct.health = quantity;
  dstruct.maxhealth = 108;
  dstruct.backpackslot = itemslotindex;
  self.var_454034054e53bd79 = dstruct;
}

function function_9ee717001acd63a0(newindex) {
  var_8c0f3022529be75e = function_3275d6441a8e838a();

  if(!isDefined(var_8c0f3022529be75e)) {
    return 0;
  }

  var_8c0f3022529be75e.backpackslot = newindex;
}

function function_8e1f9b3b6c83372d(index) {
  if(!istrue(self.disguised)) {
    return false;
  }

  var_8c0f3022529be75e = function_3275d6441a8e838a();

  if(!isDefined(var_8c0f3022529be75e)) {
    return false;
  }

  if(var_8c0f3022529be75e.backpackslot == index) {
    return true;
  }

  return false;
}

function function_81475bb5a5a5c48f() {
  self.var_454034054e53bd79 = undefined;
}

function function_3275d6441a8e838a() {
  assertex(isDefined(self.var_454034054e53bd79), "<dev string:xa6>");
  return self.var_454034054e53bd79;
}

function function_7e30d4841d0abe41(istransitioning) {
  self.var_74642c7f377a42c5 = istransitioning;

  if(istransitioning) {
    array = ["offhand_weapons"];
    scripts\common\values::set_array("disguise", array, 0);
    return;
  }

  scripts\common\values::reset_all("disguise");
}

function function_65a78266ead29817() {
  return istrue(self.var_74642c7f377a42c5);
}

function function_c2afddb38bd47f6f(itemslotindex, quantity) {
  if(istrue(self.var_ef8c89617046f3b7) || !function_43207ffc5e843003()) {
    scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return;
  }

  if(function_65a78266ead29817()) {
    return;
  }

  function_67d03e329e13f612(itemslotindex, quantity);
}

function function_9292cbe2dec7d826(delay, ison) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait delay;

  if(ison) {
    function_8dd1c5e3042447b8(1);
    function_890834271f0a6fc5();
    var_d2f434df04eb7ede = function_310843b56a04e24c();
    self function_ecdccfda4326de02();
    self setcustomization(var_d2f434df04eb7ede.body, var_d2f434df04eb7ede.head);
    self setclothtype(var_d2f434df04eb7ede.cloth);
    self setgeartype(var_d2f434df04eb7ede.gear);
    thread namespace_e0526929a9f43046::function_8bfea85875208730();
    delaythread(1, &function_8dd1c5e3042447b8, 0);
    return;
  }

  scripts\cp_mp\execution::_giveexecution(self.var_454034054e53bd79.executionref);
  self setscriptablepartstate("disguise", "off", 0);
  self setcustomization(self.operatorcustomization.body, self.operatorcustomization.head);
  var_8f23fe410ad2500e = scripts\cp_mp\operator::function_2dc6ef8b84dfec64(self.operatorcustomization.skinref);

  if(isDefined(var_8f23fe410ad2500e)) {
    self.operatorcustomization.reactiveoperator = var_8f23fe410ad2500e;
    self function_602b3de054f2a81(self.operatorcustomization.reactiveoperator);
  }

  function_81475bb5a5a5c48f();
}

function function_8dd1c5e3042447b8(ison) {
  state = ter_op(ison, "on", "off");
  self setscriptablepartstate("disguise", state, 0);
}

function function_d3b190ee881c5ca7() {
  if(!istrue(self.disguised)) {
    return 0;
  }

  return 1;
}

function function_3ede6b66136c0f93(var_8a127de2ec4f8b49) {
  self endon("disconnect");
  level endon("game_ended");

  if(!istrue(self.disguised) || function_65a78266ead29817()) {
    return;
  }

  function_da46be98ff60908d(var_8a127de2ec4f8b49);
}

function function_da46be98ff60908d(var_575bccb498ed7f9e) {
  level endon("game_ended");
  self endon("death");

  if(!istrue(self.disguised)) {
    return;
  }

  function_7e30d4841d0abe41(1);

  if(issharedfuncdefined("disguise", "should_finish_execution_first")) {
    if(callsharedfunc("disguise", "should_finish_execution_first")) {
      while(isPlayer(self) && self isinexecutionattack()) {
        waitframe();
      }
    }
  }

  function_a1650ef824a7be56(0);
  self playSound("fly_dmz_disguise_off");
  currentweapon = self getcurrentweapon();

  if(!scripts\cp_mp\utility\player_utility::isinvehicle() && !istrue(self.var_859654e0445a36d9) && isDefined(currentweapon) && !isnullweapon(currentweapon)) {
    self forceplaygestureviewmodel("iw9_vm_ges_disguise_off");
  }

  takeoffdelay = getdvarfloat(@ "hash_307d1884bcaef28f", 0.45);
  childthread function_9292cbe2dec7d826(takeoffdelay, 0);
  childthread function_b02057aaa6d29ba1(0, takeoffdelay);
  self.disguised = undefined;

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.clothtype) && self.operatorcustomization.clothtype != "") {
    self setclothtype(self.operatorcustomization.clothtype);
  } else {
    self setclothtype("vestlight");
  }

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.geartype) && self.operatorcustomization.geartype != "") {
    self setgeartype(self.operatorcustomization.geartype);
  } else {
    self setgeartype("millghtgr");
  }

  self setclientomnvar("ui_dmz_disguise_sixth_sense_glow", 0);
  scripts\engine\utility::delaythread(takeoffdelay, &function_7e30d4841d0abe41, 0);

  if(issharedfuncdefined("disguise", "disguiseOff")) {
    callsharedfunc("disguise", "disguiseOff");
  }

  self notify("disguise_ended");
}

function function_b02057aaa6d29ba1(ison, delay) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait delay;
  self setclientomnvar("ui_dmz_disguise_state", ison);

  if(issharedfuncdefined("disguise", "getCustomDisguiseVisionSet")) {
    var_6b46ba0029c65f1 = callsharedfunc("disguise", "getCustomDisguiseVisionSet");
  }

  if(isDefined(var_6b46ba0029c65f1)) {
    if(ison) {
      vision_utility::function_27a921508cb04613(var_6b46ba0029c65f1);
      return;
    }

    vision_utility::function_9a92ae402e209ecc(var_6b46ba0029c65f1);
  }
}

function function_a1650ef824a7be56(var_74fa01bd3626f0b7) {
  if(isDefined(level.var_8c0f3022529be75e.concealclip)) {
    if(var_74fa01bd3626f0b7) {
      var_54a491b5dd59f575 = level.var_8c0f3022529be75e.concealclip;
      var_54a491b5dd59f575.origin = self.origin;
      var_54a491b5dd59f575.angles = self.angles;
      var_54a491b5dd59f575.owner = self;
      var_54a491b5dd59f575 linkTo(self);
      self.var_c8395b9bae721f6b.concealclip = var_54a491b5dd59f575;
    } else {
      self.var_c8395b9bae721f6b.concealclip unlink();
      self.var_c8395b9bae721f6b.concealclip.origin = (0, 0, 0);
      self.var_c8395b9bae721f6b.concealclip.owner = undefined;
      self.var_c8395b9bae721f6b.concealclip = undefined;
    }

    return;
  }

  function_ed9b1ddd2ec82dab(self, var_74fa01bd3626f0b7);
}

function function_d8d7a08a9fd9a9f() {
  self endon("death_or_disconnect");
  self endon("disguise_ended");

  if(getdvarint(@ "hash_8303972c0cfbece0", 1) != 1) {
    return;
  }

  while(true) {
    function_d293a200fe5d81c1();
    waitframe();
  }
}

function function_bc96cf8a43c99435() {
  origin = self.origin;
  radius = getdvarfloat(@ "hash_1ef2c1fad9dad02f", 1000);
  var_674daafffc0aacf3 = undefined;

  if(function_a794fcf9545f2062()) {
    var_674daafffc0aacf3 = getentitiesinradiusfrompartitiongrid(origin, radius, createentitytypemask(["etype_ai"]), undefined, undefined);
  } else {
    var_674daafffc0aacf3 = getaiarrayinradius(origin, radius);
  }

  return var_674daafffc0aacf3;
}

function function_d293a200fe5d81c1() {
  contents = scripts\engine\trace::create_default_contents(1);
  debug = getdvarint(@ "hash_c6b2b86fd34e0636", 0) == 1;
  process = 0;
  sightmask = 0;
  tootherplayer = undefined;
  var_746071ab06f38fd = undefined;
  time = getsystemtimeinmicroseconds();

  if(!isDefined(self)) {
    return 0;
  }

  if(!istrue(self.disguised)) {
    return 0;
  }

  var_674daafffc0aacf3 = function_bc96cf8a43c99435();
  var_24f9b94a171cca52 = scripts\mp\utility\player::getstancecenter();

  foreach(agent in var_674daafffc0aacf3) {
    if(process >= 25) {
      process = 0;
      waitframe();
    }

    if(!function_7e44e1aadd3ddf3a(agent)) {
      continue;
    }

    process++;
    agentpos = agent.origin;
    threatlevel = agent getthreatsight(self);

    if(threatlevel < 0.25) {
      continue;
    }

    sightmask |= function_8cd5129459f5cd9c(agent);
  }

  function_443abc2e017f4e40(sightmask);

  if(sightmask != 0) {
    if(!isDefined(self.var_db46ac7f2e05d19d) || (gettime() - self.var_db46ac7f2e05d19d) / 1000 >= 4) {
      self playlocalsound("iw9_mp_disguise_alert");
      self.var_db46ac7f2e05d19d = gettime();
    }
  }
}

function function_7e44e1aadd3ddf3a(agent) {
  if(!isDefined(self)) {
    return;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(!isDefined(agent)) {
    return 0;
  }

  if(!isalive(agent)) {
    return 0;
  }

  if(scripts\common\utility::isusingremote()) {
    return 0;
  }

  return 1;
}

function function_8cd5129459f5cd9c(agent) {
  forward = vectorNormalize(anglesToForward(self getplayerangles()));
  toenemy = vectorNormalize(agent.origin - self.origin);
  dot = vectordot(forward, toenemy);

  if(dot >= 0.92388) {
    return 2;
  }

  if(dot >= 0.707107) {
    return ter_op(utility::isleft2d(self.origin, forward, agent.origin), 4, 1);
  }

  if(dot >= 0.5) {
    return ter_op(utility::isleft2d(self.origin, forward, agent.origin), 128, 64);
  }

  if(dot >= -0.707107) {
    return ter_op(utility::isleft2d(self.origin, forward, agent.origin), 32, 8);
  }

  return 16;
}

function function_443abc2e017f4e40(sightmask) {
  self setclientomnvar("ui_dmz_disguise_sixth_sense_glow", sightmask);
}

function function_890834271f0a6fc5() {
  var_cb11f01bf67d6e03 = ["000", "001", "022", "023"];
  randomidx = var_cb11f01bf67d6e03[randomint(var_cb11f01bf67d6e03.size)];
  execref = "execution_" + randomidx;
  scripts\cp_mp\execution::_giveexecution(execref);
}