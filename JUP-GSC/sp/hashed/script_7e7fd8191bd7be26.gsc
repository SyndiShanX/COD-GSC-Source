/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7e7fd8191bd7be26.gsc
*************************************************/

#using scripts\common\ai;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#namespace namespace_51941b5526d40882;

function function_21bd6a8c4766ad5a(guy, useinplace, var_9b57bd8d7f3d4e6a) {
  if(!isDefined(guy) || !isalive(guy)) {
    printerror("Armor plate guy passed in undefined or dead!?");
    return undefined;
  }

  id = undefined;

  if(istrue(useinplace)) {
    id = guy function_5b3b464cc2cb45f4();
  } else {
    guy endon("death");
    guy scripts\mp\ai_behavior::function_8dad0c97c82fb52f(guy);

    if(!isDefined(var_9b57bd8d7f3d4e6a)) {
      var_9b57bd8d7f3d4e6a = 5;
    }

    guy thread function_7640cb412c9e964c(self, var_9b57bd8d7f3d4e6a);
    self waittill("guy_reached_cover");
    id = guy function_5b3b464cc2cb45f4();
  }

  return id;
}

function function_63c85ab9240382f7(dyingguy, helper) {
  if(!isDefined(dyingguy) || !isalive(dyingguy)) {
    printerror("Dying guy passed in undefined or dead!?");
    return undefined;
  }

  if(dyingguy scripts\engine\utility::doinglongdeath()) {
    return dyingguy getinteractionid();
  }

  var_f4cd424dd91129f3 = dyingguy.var_d5e499e7fe2c490b;
  skippingcrawl = 0;
  skippingintro = 0;

  if(isDefined(helper)) {
    var_b4312e532eae7720 = function_96e4999ac9cb2936();

    if(!isDefined(var_b4312e532eae7720)) {
      printerror("AI Code Bhvr bundle not found!");
      return undefined;
    }

    interactionname = var_b4312e532eae7720.airevival;
    interactionid = spawninteraction(interactionname, dyingguy.origin, dyingguy.angles);

    if(isDefined(interactionid)) {
      function_c0456e000364a1d7(dyingguy);
      dyingguy.var_d5e499e7fe2c490b = 0;
      dyingguy scripts\common\ai::function_b9307a16e291255e(skippingcrawl, skippingintro);
      timeout = gettime() + 1000;

      while(istrue(dyingguy.longdeathstarting) && timeout > gettime()) {
        waitframe();
      }

      dyingguy.var_d5e499e7fe2c490b = 1;
      dyingguy function_76b3cfb91ef40b3b(interactionid, "dying_guy");
      helper function_76b3cfb91ef40b3b(interactionid);
      dyingguy thread function_4c0173cde37dfa4a(var_f4cd424dd91129f3);
      dyingguy thread function_51084cecd9163520(interactionid);
    } else {
      printerror("cannot spawn revival interaction");
    }

    return interactionid;
  }

  dyingguy.var_d5e499e7fe2c490b = 1;
  dyingguy scripts\common\ai::function_b9307a16e291255e(skippingcrawl, skippingintro);
  timeout = gettime() + 2000;

  while(!isDefined(dyingguy getinteractionid()) && timeout > gettime()) {
    waitframe();
  }

  intid = dyingguy getinteractionid();

  if(isDefined(intid)) {
    dyingguy thread function_4c0173cde37dfa4a(var_f4cd424dd91129f3);
  } else {
    dyingguy.var_d5e499e7fe2c490b = var_f4cd424dd91129f3;
  }

  return intid;
}

function private function_5b3b464cc2cb45f4() {
  var_b4312e532eae7720 = function_96e4999ac9cb2936();

  if(!isDefined(var_b4312e532eae7720)) {
    printerror("Undefined Bundle");
    return undefined;
  }

  interactionname = var_b4312e532eae7720.var_640697c654911b1b;
  interactionid = spawninteraction(interactionname, self.origin, self.angles);

  if(isDefined(interactionid)) {
    self function_76b3cfb91ef40b3b(interactionid);
    thread function_d1957c81b78fce90(interactionid);
  } else {
    printerror("cannot spawn armor plate interaction");
  }

  return interactionid;
}

function private function_d1957c81b78fce90(id) {
  self waittill("endusearmorplate");
  despawninteraction(id);
}

function private function_51084cecd9163520(id) {
  self waittill("end_revival");
  despawninteraction(id);
}

function private function_4c0173cde37dfa4a(var_f4cd424dd91129f3) {
  self waittill("cap_exit_completed");
  self.var_d5e499e7fe2c490b = var_f4cd424dd91129f3;
}

function private function_7640cb412c9e964c(levelscr, timeout) {
  self endon("death");
  scripts\engine\utility::waittill_any_timeout_1(timeout, "goal");

  while(istrue(self.arriving)) {
    waitframe();
  }

  levelscr notify("guy_reached_cover");
}

function private function_c0456e000364a1d7(guy) {
  if(!isDefined(guy.revive_bleedouttime)) {
    guy.revive_bleedouttime = 5000;
  }
}

function private function_96e4999ac9cb2936() {
  return getscriptbundle(%"hash_808ddc26c257759");
}

function private printerror(msg) {
  if(getDvar(@ "hash_cd2a202ccf770735")) {
    println(msg);
  }
}