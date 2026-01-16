/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ee_zombie_bathtub.gsc
***********************************************/

#include script_cb32d07c95e5628;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\wz_common\wz_ai_utils;

#namespace namespace_87f097c4;

autoexec __init__system__() {
  system::register(#"hash_7551e984c9a42af9", &__init__, undefined, undefined);
}

__init__() {
  level.var_6e0c26c7 = (isDefined(getgametypesetting(#"hash_30b11d064f146fcc")) ? getgametypesetting(#"hash_30b11d064f146fcc") : 0) || (isDefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0);

  if(level.var_6e0c26c7) {
    clientfield::register("world", "zombie_arm_blood_splash", 20000, 1, "counter");
    clientfield::register("world", "bathtub_fake_soul_sfx", 20000, 1, "counter");
    level.var_e91bcfae = 0;
    zombie_arm = getent("zombie_arm", "targetname");

    if(isDefined(zombie_arm)) {
      zombie_arm ghost();
    }

    level.var_afdd2ed7 = 0;
    callback::on_ai_killed(&on_ai_killed);
    callback::on_item_pickup(&on_player_item_pickup);
  }

  function_4ed420e3();

}

on_ai_killed(params) {
  if(isDefined(level.var_e91bcfae) && level.var_e91bcfae) {
    return;
  }

  if(isplayer(params.eattacker)) {
    attacker = params.eattacker;
    bathtub = struct::get(#"zombie_bathub", "targetname");

    if(isDefined(bathtub)) {
      distance = distance(bathtub.origin, attacker.origin);

      if(distance < 256) {
        level.var_afdd2ed7++;
        level clientfield::increment("bathtub_fake_soul_sfx", 1);
      }

      if(level.var_afdd2ed7 >= 3) {
        level thread function_613448ed(attacker, bathtub);
        callback::remove_callback(#"on_ai_killed", &on_ai_killed);
        level.var_afdd2ed7 = undefined;
      }
    }
  }
}

on_player_item_pickup(params) {
  if(!isDefined(params.item)) {
    return;
  }

  item = params.item;

  if(isplayer(self)) {
    if(isDefined(item.var_cd8fb96) && item.var_cd8fb96) {
      zombie_arm = getent("zombie_arm", "targetname");

      if(isDefined(zombie_arm)) {
        var_4805bfaa = (zombie_arm.origin[0], zombie_arm.origin[1], zombie_arm.origin[2] + -24);
        zombie_arm playSound(#"hash_134bc3c2ce6ed759");
        level thread function_ca44f5a5(zombie_arm, var_4805bfaa, 1);
        level clientfield::increment("zombie_arm_blood_splash", 1);
        callback::remove_callback(#"on_item_pickup", &on_player_item_pickup);
      }
    }
  }
}

function_613448ed(player, bathtub) {
  self notify("1db1954ce3ca6f10");
  self endon("1db1954ce3ca6f10");

  if(isDefined(level.var_e91bcfae) && level.var_e91bcfae) {
    return;
  }

  golden_spork = function_1deb2b38(bathtub);
  zombie_arm = getent("zombie_arm", "targetname");

  if(isDefined(zombie_arm) && isDefined(golden_spork)) {
    golden_spork.var_cd8fb96 = 1;
    var_4805bfaa = (zombie_arm.origin[0], zombie_arm.origin[1], zombie_arm.origin[2] + 24);
    golden_spork.origin = (zombie_arm.origin[0] + 2, zombie_arm.origin[1] + 1.5, zombie_arm.origin[2] + 15);
    golden_spork.angles = (0, -50, -90);
    var_45f173ec = (golden_spork.origin[0], golden_spork.origin[1], golden_spork.origin[2] + 24);
    zombie_arm show();
    zombie_arm playSound(#"hash_2b9e3e8f3a11bcdb");
    level clientfield::increment("zombie_arm_blood_splash", 1);
    level thread function_ca44f5a5(zombie_arm, var_4805bfaa);
    level thread function_b413daad(golden_spork, var_45f173ec);
  }
}

function_ca44f5a5(zombie_arm, target_pos, var_e77e9de = 0) {
  if(!isDefined(zombie_arm) || !isDefined(target_pos)) {
    return;
  }

  zombie_arm endon(#"death");
  zombie_arm moveto(target_pos, 2);

  if(var_e77e9de) {
    zombie_arm waittill(#"movedone");
    zombie_arm ghost();
  }
}

function_b413daad(golden_spork, target_pos) {
  golden_spork moveto(target_pos, 2);
}

function_1deb2b38(var_b721e8a9) {
  if(!isDefined(var_b721e8a9) || isDefined(level.var_e91bcfae) && level.var_e91bcfae) {
    return;
  }

  level.var_e91bcfae = 1;

  if(isDefined(var_b721e8a9)) {
    a_items = var_b721e8a9 namespace_65181344::function_fd87c780(#"zombie_bathtub_ee_list", 1);

    foreach(item in a_items) {
      if(isDefined(item)) {
        return item;
      }
    }
  }
}

function_4ed420e3() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }

  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  level thread function_7eabf705();
}

function_7eabf705() {
  self notify("<dev string:x89>");
  self endon("<dev string:x89>");
  level endon(#"game_ended");
  level endon(#"hash_671b150516dd9870");

  while(true) {
    if(getdvarint(#"hash_7e7b9e2edcf6d1ee", 0)) {
      players = getplayers();
      bathtub = struct::get(#"zombie_bathub", "<dev string:x9c>");
      function_613448ed(players[0], bathtub);
      level notify(#"hash_671b150516dd9870");
      break;
    }

    waitframe(1);
  }
}

