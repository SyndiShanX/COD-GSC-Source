/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\cp\ac130.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_35ae72be7b4fec10;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#using scripts\killstreaks\ac130_shared;
#namespace namespace_8bcd067b;

function private autoexec __init__system__() {
  system::register(#"ac130", &preinit, undefined, &function_3675de8b, #"killstreaks");
}

function private preinit() {
  profilestart();
  level.var_f987766c = &spawnac130;
  level.var_36cf2603 = 3;
  ac130_shared::preinit("killstreak_ac130_cp");
  profilestop();
}

function private function_3675de8b() {
  ac130_shared::function_3675de8b();
}

function private spawnac130(killstreaktype) {
  player = self;
  player endon(#"disconnect");
  level endon(#"game_ended");
  assert(!isDefined(level.ac130));
  var_b0b764aa = ac130_shared::spawnac130(killstreaktype);

  if(is_true(level.var_43da6545)) {
    player setvehicledrivableduration(0);
  }

  if(var_b0b764aa == 1) {
    player thread function_a4b36d9a();
  }

  return var_b0b764aa;
}

function private function_a4b36d9a() {
  player = self;
  self notify("485efef24bc199cf");
  self endon("485efef24bc199cf");
  player thread util::function_658a8750(1);
  namespace_61e6d095::function_28027c42(#"ac130", [#"hash_72cc4740fa4d3da3"]);
  namespace_c8e236da::removelist();
  namespace_c8e236da::function_ebf737f8(#"hash_c7d583ff53f896");
  namespace_c8e236da::function_ebf737f8(#"hash_6fca5ea0f3afc2a7");
  namespace_c8e236da::function_ebf737f8(#"hash_5c839d11282c4b14");

  if(level.var_dab73f4a !== 1) {
    namespace_c8e236da::function_ebf737f8(#"hash_43348d9c60568d3a");
  }

  util::waittill_any_ents(level, "game_ended", player, "disconnect", player, "death", player, "gunner_left");
  namespace_c8e236da::removelist();
  namespace_61e6d095::function_4279fd02(#"ac130");
}

function function_1c110d7a(var_c3fb6cc9, var_d836f7aa, var_a6a9d503 = undefined) {
  var_14db8d05 = (var_c3fb6cc9[0], var_c3fb6cc9[1], var_d836f7aa);
  traceresult = groundtrace(var_14db8d05, var_14db8d05 + (0, 0, var_d836f7aa * -1), 0, undefined);
  var_dd58c5bb = traceresult[#"position"];
  ac130_shared::function_672f2acd(var_14db8d05, var_dd58c5bb, var_a6a9d503);
}

function function_11d723b6() {
  player = self;

  if(isDefined(level.ac130) && isDefined(level.ac130.owner) && player == level.ac130.owner) {
    ac130_shared::function_8721028e(player, 0, 0);
  }
}

function function_2fc9f8f9() {
  self notify("<dev string:x38>");
  self endon("<dev string:x38>");

  while(true) {
    waitframe(1);

    if(isDefined(level.var_89350618)) {
      line(level.var_89350618.origin + (0, 0, -12000), level.var_89350618.origin, (1, 1, 0), 1, 0, 1);
    }

    if(isDefined(level.var_e2a77deb)) {
      linesphere(level.var_e2a77deb, 64, (0, 1, 0), 1, 0, 10, 1);
    }
  }
}