/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_293299be863018bb.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\zm\zm_hms_util;
#include scripts\zm_common\zm_sq;

#namespace namespace_6f62781f;

init() {
  init_flags();
  init_quest();
}

init_flags() {
  level flag::init(#"hash_3e2d063d97c06905");
  level flag::init(#"hash_8987a45b2eda7c4");
  level flag::init(#"hash_743603caa0ee0976");
  level flag::init(#"hash_370781d7705e4e18");
  level flag::init(#"hash_3b152242499836c8");
}

init_quest() {
  level.var_51acdb19 = getent("dempsey_grenade", "targetname");
  level.var_a7a99ef1 = struct::get(#"dempsey_audio");
  level.var_cd51aa28 = 0;
  level.var_440b230b = 0;
  zm_sq::register(#"hash_63dc1e557f49595f", #"step_1", #"hash_4d540289d82df269", &function_4c20829a, &function_37518cc4);
  zm_sq::register(#"hash_63dc1e557f49595f", #"step_2", #"hash_4d53ff89d82ded50", &function_ec156b93, &function_44101788);
  zm_sq::register(#"hash_63dc1e557f49595f", #"step_3", #"hash_4d540089d82def03", &function_f2757dee, &function_cc61f0a3);
  zm_sq::register(#"hash_63dc1e557f49595f", #"step_4", #"hash_4d540589d82df782", &function_29f2b66e, &function_4cf57214);
  zm_sq::register(#"hash_63dc1e557f49595f", #"step_5", #"hash_4d540689d82df935", &function_b7f1e7df, &function_2c09c7d2);
  zm_sq::start(#"hash_63dc1e557f49595f");
}

function_4c20829a(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level flag::wait_till(#"hash_5df188993c013698");
    level.var_51acdb19 thread grenade_watcher();
    level flag::wait_till(#"hash_3e2d063d97c06905");
  }
}

function_37518cc4(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_cd51aa28 = 1;
    level flag::set(#"hash_3e2d063d97c06905");
    return;
  }

  level.var_cd51aa28 = 1;
  playsoundatposition(#"hash_259ff339b748935e", level.var_a7a99ef1.origin);
  level waittill(#"hash_4a19fd40add44b83");
}

function_ec156b93(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_51acdb19 thread grenade_watcher();
    level flag::wait_till(#"hash_8987a45b2eda7c4");
  }
}

function_44101788(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_cd51aa28 = 2;
    level flag::set(#"hash_8987a45b2eda7c4");
    return;
  }

  level.var_cd51aa28 = 2;
  playsoundatposition(#"hash_68bbb4ef1a9d22af", level.var_a7a99ef1.origin);
  level waittill(#"hash_4a19fd40add44b83");
}

function_f2757dee(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_51acdb19 thread grenade_watcher();
    level flag::wait_till(#"hash_743603caa0ee0976");
  }
}

function_cc61f0a3(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_cd51aa28 = 3;
    level flag::set(#"hash_743603caa0ee0976");
    return;
  }

  level.var_cd51aa28 = 3;
  playsoundatposition(#"hash_5c206c7dd64ec92c", level.var_a7a99ef1.origin);
  level waittill(#"hash_4a19fd40add44b83");
}

function_29f2b66e(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_51acdb19 thread grenade_watcher();
    level flag::wait_till(#"hash_370781d7705e4e18");
  }
}

function_4cf57214(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_cd51aa28 = 4;
    level flag::set(#"hash_370781d7705e4e18");
    return;
  }

  level.var_cd51aa28 = 4;
  playsoundatposition(#"hash_2c8959d200afc735", level.var_a7a99ef1.origin);
  level waittill(#"hash_4a19fd40add44b83");
}

function_b7f1e7df(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level.var_51acdb19 thread grenade_watcher();
    level flag::wait_till(#"hash_3b152242499836c8");
  }
}

function_2c09c7d2(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level.var_cd51aa28 = 5;
    level flag::set(#"hash_3b152242499836c8");
    return;
  }

  level.var_cd51aa28 = 5;
  zm_hms_util::function_e308175e(#"hash_3bd00f2e3293cc1a", level.var_a7a99ef1.origin);
  wait 1;
  zm_hms_util::function_e308175e(#"hash_63eaabff22eb9bab", level.var_a7a99ef1.origin);
}

grenade_watcher() {
  level endon(#"end_game");
  self endon(#"step_completed");

  while(true) {
    waitresult = self waittill(#"damage");

    if(waitresult.mod === "MOD_GRENADE_SPLASH" && level.var_440b230b < level.round_number) {
      switch (level.var_cd51aa28) {
        case 0:
          level flag::set(#"hash_3e2d063d97c06905");
          self notify(#"step_completed");
        case 1:
          level flag::set(#"hash_8987a45b2eda7c4");
          self notify(#"step_completed");
        case 2:
          level flag::set(#"hash_743603caa0ee0976");
          self notify(#"step_completed");
        case 3:
          level flag::set(#"hash_370781d7705e4e18");
          self notify(#"step_completed");
        case 4:
          level flag::set(#"hash_3b152242499836c8");
          self notify(#"step_completed");
          break;
      }

      level.var_440b230b = level.round_number;
    }

    waitframe(1);
  }
}