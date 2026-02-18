/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mule_kick.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_mule_kick;

function private autoexec __init__system__() {
  system::register(#"zm_perk_mule_kick", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!is_true(getgametypesetting(#"hash_616a22c5c1ebe5b8"))) {
    return;
  }

  function_27473e44();
}

function function_27473e44() {
  zm_perks::register_perk_clientfields(#"talent_mulekick", &client_field_func, &callback_func);
  zm_perks::register_perk_effects(#"talent_mulekick", "mulekick_light");
  zm_perks::register_perk_init_thread(#"talent_mulekick", &function_6a549f51);
  zm_perks::function_f3c80d73("zombie_perk_bottle_mulekick");
}

function function_6a549f51() {}

function client_field_func() {
  if(zm_utility::is_classic()) {
    clientfield::register("scriptmover", "mule_kick_machine_rob", 13000, 1, "int", &mule_kick_machine_rob, 0, 0);
    clientfield::register("scriptmover", "mule_kick_machine_rob_buy", 13000, 1, "counter", &mule_kick_machine_rob_buy, 0, 0);
  }
}

function callback_func() {}

function mule_kick_machine_rob(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(bwastimejump) {
    self playrenderoverridebundle(#"hash_7cb1e2c4664b70f9");
    wait 1;
    self function_f6e99a8d(#"hash_7cb1e2c4664b70f9");
    self playrenderoverridebundle(#"hash_58b55b59b9a623b0");
    return;
  }

  self function_f6e99a8d(#"hash_7cb1e2c4664b70f9");
  self function_f6e99a8d(#"hash_58b55b59b9a623b0");
}

function mule_kick_machine_rob_buy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_194b61fc();
}

function function_194b61fc() {
  self endon(#"death");
  self notify("20dad14a66fa696e");
  self endon("20dad14a66fa696e");
  self function_f6e99a8d(#"hash_58b55b59b9a623b0");
  self playrenderoverridebundle(#"hash_3dd4beb993077560");
  wait 9;
  self function_f6e99a8d(#"hash_3dd4beb993077560");
  self playrenderoverridebundle(#"hash_58b55b59b9a623b0");
}