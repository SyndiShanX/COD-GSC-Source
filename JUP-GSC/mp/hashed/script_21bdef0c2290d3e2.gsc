/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_21bdef0c2290d3e2.gsc
*************************************************/

#using script_1fb4294da3259ab0;
#using script_20857c2ea652800b;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace namespace_5b41b2b7b50f7b5a;

function private function_b3802ac8327a6687(var_ca3f9f388971b729) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!ent_flag_exist("companion_spawn")) {
    ent_flag_init("companion_spawn");
  }

  while(ent_flag("companion_spawn")) {
    waitframe();
  }

  ent_flag_set("companion_spawn");

  if(!isPlayer(self) || !isalive(self) || istrue(self.inlaststand)) {
    return;
  }

  if(isDefined(self.var_c5668dcaf32afbc3)) {
    self.var_c5668dcaf32afbc3 kill();
    self.var_c5668dcaf32afbc3 = undefined;
    wait 1;
  }

  if(!istrue(level.skipprematch) && flags::gameflagexists("prematch_done")) {
    flags::gameflagwait("prematch_done");
  }

  if(level flag_exist("ob_infil_completed")) {
    level flag_wait("ob_infil_completed");
  }

  switch (var_ca3f9f388971b729) {
    case 3:
      function_f3bb4f4911a1beb2("ob_disciple_bottle", "spawn_disciple_pet");
      break;
    case 1:
      spawn_hellhound_pet();
      break;
    case 2:
      function_df47984aec8fdb53();
      break;
    case 0:
    default:
      break;
  }

  ent_flag_clear("companion_spawn");
}

function function_8b9945c368da84a2() {
  thread function_b3802ac8327a6687(1);
}

function function_f6ada322b58319b0() {
  thread function_b3802ac8327a6687(2);
}

function function_502a3a9e49f2a036() {
  thread function_b3802ac8327a6687(3);
}

function function_8d9f9441a6e46f2f() {
  return isDefined(self.companion_type) && self.companion_type != 0;
}

function function_9aea241ac7d66cd3() {
  if(isDefined(self.companion_type)) {
    return self.companion_type;
  }

  return 0;
}

function function_d5e1cdc9b72396a8() {
  if(isDefined(self.companion_type)) {
    return (self.companion_type == 1);
  }

  return false;
}

function function_29aefcbd36a1ac40() {
  if(isDefined(self.companion_type)) {
    return (self.companion_type == 2);
  }

  return false;
}

function function_6e0380da29582926() {
  if(isDefined(self.companion_type)) {
    return (self.companion_type == 3);
  }

  return false;
}

function function_115ba5b3dc835cee() {
  self.companion_type = 2;
}

function function_19c4400bfbd67af1() {
  var_7f3a02c2fa4778d9 = 0;

  if(istrue(self.var_f20036ce01c27a4d)) {
    if(function_29aefcbd36a1ac40()) {
      var_7f3a02c2fa4778d9 = 1;
    }

    self.var_f20036ce01c27a4d = 0;
  } else if(istrue(self.var_8a13c2b607afaae7)) {
    var_7f3a02c2fa4778d9 = 1;
  }

  return var_7f3a02c2fa4778d9;
}