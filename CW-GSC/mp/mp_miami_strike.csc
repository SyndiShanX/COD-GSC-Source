/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_miami_strike.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace mp_miami_strike;

function event_handler[level_init] main(eventstruct) {
  setsaveddvar(#"enable_global_wind", 1);
  setsaveddvar(#"wind_global_vector", "88 0 0");
  setsaveddvar(#"wind_global_low_altitude", 0);
  setsaveddvar(#"wind_global_hi_altitude", 10000);
  setsaveddvar(#"wind_global_low_strength_percent", 100);
  setsaveddvar(#"phys_ragdoll_buoyancy", 1);
  setsaveddvar(#"vt_enable", 0);
  setsaveddvar(#"hash_7112f4ec5fd42556", 0);
  clientfield::register("scriptmover", "neon_rob", 1, 1, "counter", &neon_rob, 0, 0);
  callback::on_gameplay_started(&on_gameplay_started);
  load::main();
  level thread function_22faec66();
  util::waitforclient(0);
}

function on_gameplay_started(localclientnum) {
  waitframe(1);
  util::function_8eb5d4b0(1200, 1.25);
  setDvar(#"phys_ragdoll_buoyancy", 1);
  level notify(#"hash_3eb74ffb77c6b4b6");
}

function neon_rob(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = function_5c10bd79(bwastimejump);

  if(!isDefined(player) || !player function_21c0fa55() || !isDefined(self)) {
    return;
  }

  if(is_true(self.var_f74923b)) {
    self.var_f74923b = 0;
    self stoprenderoverridebundle("rob_miami_neon");
    return;
  }

  self.var_f74923b = 1;
  self playrenderoverridebundle("rob_miami_neon");
}

function function_22faec66() {
  level endon(#"hash_3eb74ffb77c6b4b6");

  while(true) {
    level waittill(#"hash_1facd0d4f9a1afe9");

    foreach(player in getlocalplayers()) {
      player postfx::playpostfxbundle(#"hash_882b6546895dd5f");
    }

    level waittill(#"hash_747258e42dd5af85");

    foreach(player in getlocalplayers()) {
      player postfx::exitpostfxbundle(#"hash_882b6546895dd5f");
    }
  }
}