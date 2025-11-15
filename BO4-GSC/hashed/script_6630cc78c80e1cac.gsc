/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_6630cc78c80e1cac.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_vo;

#namespace namespace_a35b0e2;

autoexec __init__system__() {
  system::register(#"hash_4fac8791c22b4bd7", &init, undefined, undefined);
}

init() {
  level.var_143be9f3 = 0;
  level.var_4850c7c6 = 0;
  level.var_db90b274 = 2;
  level.var_cf5d426a = array("oscar_prelim_1", "oscar_prelim_2", "oscar_prelim_3", "oscar_prelim_4", "oscar_prelim_5");
  level.var_41770f71 = [];

  foreach(var_4f61dc22 in level.var_cf5d426a) {
    function_7a7d15c8(var_4f61dc22);
  }

  level.var_d5fff1a7 = getent("jfk_room_oscar_left_0", "targetname");
  level.var_a83c1620 = getent("jfk_room_oscar_left_1", "targetname");
  level.var_3830a0d3 = getent("jfk_room_oscar_right_0", "targetname");
  level.var_2a66053e = getent("jfk_room_oscar_right_1", "targetname");
  level.var_a83c1620 hide();
  level.var_2a66053e hide();
  level.var_3830a0d3.angles += (20, 0, 0);
  level flag::init(#"hash_7b1fd4fc459e497c");
  zm_sq::register(#"hash_6039fc2dd130edf5", #"step_1", #"hash_5873576264199a27", &function_4ac6cf37, &function_cb27a665);
  zm_sq::start(#"hash_6039fc2dd130edf5");
  zm_sq::register(#"hash_6039fc2dd130edf5", #"step_2", #"hash_5873586264199bda", &function_955fffb1, &function_fabb1fba);
  zm_sq::start(#"hash_6039fc2dd130edf5");
}

function_4ac6cf37(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    function_2d023c13();

    while(level.var_4850c7c6 < level.var_143be9f3) {
      waitframe(1);
    }

    playsoundatposition(#"hash_4ff9e8e25196f463", (0, 0, 0));

    iprintlnbold("<dev string:x38>");

  }
}

function_cb27a665(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    foreach(var_637c224f in level.var_41770f71) {
      var_637c224f.e_trigger delete();
    }
  }
}

function_7a7d15c8(var_4f61dc22) {
  level.var_143be9f3++;
  var_637c224f = getent(var_4f61dc22, "targetname");
  array::add(level.var_41770f71, var_637c224f);
  var_637c224f.angles += (20, 0, 0);
  var_637c224f.e_trigger = getent(var_4f61dc22 + "_trigger", "targetname");
}

function_2d023c13() {
  foreach(var_637c224f in level.var_41770f71) {
    var_637c224f.e_trigger thread function_d10bef80();
  }
}

function_d10bef80() {
  self endon(#"death");
  var_b45fe0b3 = 0;

  while(!var_b45fe0b3) {
    waitresult = self waittill(#"damage");

    if(waitresult.weapon == getweapon(#"bowie_knife_story_1")) {
      var_637c224f = getent(self.target, "targetname");
      var_637c224f rotateto(var_637c224f.angles - (20, 0, 0), 0.15);
      var_b45fe0b3 = 1;
      level.var_4850c7c6++;
    }
  }
}

function_955fffb1(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    var_52020ab3 = struct::get("jfk_room_oscar_left_trigger");
    var_52020ab3.var_47323b73 = var_52020ab3 zm_unitrigger::create("", 64, &function_715c9476, 1, 0);
    var_2d8940a6 = struct::get("jfk_room_oscar_right_trigger");
    var_2d8940a6.var_47323b73 = var_2d8940a6 zm_unitrigger::create("", 64, &function_63f29ee9, 1, 0);
    level.var_a83c1620 hide();
    level.var_2a66053e hide();
    level flag::wait_till(#"hash_7b1fd4fc459e497c");
  }
}

function_fabb1fba(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level flag::set(#"hash_7b1fd4fc459e497c");
  }

  var_52020ab3 = struct::get("jfk_room_oscar_left_trigger");

  if(isDefined(var_52020ab3.var_47323b73)) {
    zm_unitrigger::unregister_unitrigger(var_52020ab3.var_47323b73);
  }

  var_2d8940a6 = struct::get("jfk_room_oscar_right_trigger");

  if(isDefined(var_2d8940a6.var_47323b73)) {
    zm_unitrigger::unregister_unitrigger(var_2d8940a6.var_47323b73);
  }
}

function_715c9476() {
  waitresult = self waittill(#"trigger");
  level.var_db90b274--;
  self playSound(#"hash_5104efdd2ef71e39");

  iprintlnbold("<dev string:x62>");

    level thread function_bd81f4e2(waitresult.activator);
}

function_63f29ee9() {
  var_c4cb303c = getent("jfk_room_oscar_right_0", "targetname");
  var_c4cb303c rotateto(var_c4cb303c.angles - (20, 0, 0), 0.15);
  waitresult = self waittill(#"trigger");
  level.var_db90b274--;
  self playSound(#"hash_5104efdd2ef71e39");

  iprintlnbold("<dev string:x80>");

    level thread function_bd81f4e2(waitresult.activator);
}

function_bd81f4e2(user) {
  if(level.var_db90b274 <= 0) {
    level.var_a83c1620 show();
    level.var_2a66053e show();
    wait 0.1;
    level.var_d5fff1a7 hide();
    level.var_3830a0d3 hide();
    playsoundatposition(#"hash_4b169927b4789180", (0, 0, 0));

    iprintlnbold("<dev string:x9f>");

      if(user zm_characters::is_character(array(#"hash_1aa57ef704f24fa5", #"hash_36bc80636f0fdac4"))) {
        user thread zm_vo::vo_say("vox_mcnamara_log_repair_plr_6_0");
      }

    level flag::set(#"hash_7b1fd4fc459e497c");
  }
}