/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\radio_tower.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace radio_tower;

function private autoexec __init__system__() {
  system::register(#"radio_tower", undefined, undefined, &function_13dad5c9339829d7);
}

function private function_13dad5c9339829d7() {
  level thread function_a2551378bc08f089();
}

function function_bfe75e4a1ee58ef(instance, player) {
  if(isDefined(level.squaddata)) {
    playerteam = player.team;
    playersquadindex = player.sessionsquadid;
    squadmembers = level.squaddata[playerteam][playersquadindex].players;

    foreach(squadmember in squadmembers) {
      function_2baca72ada73fba3(squadmember.origin, squadmember, instance.indexnum, getdvarint(@ "hash_b0049102bfc4b5db", 12000), 0);
    }

    return;
  }

  function_2baca72ada73fba3(player.origin, player, instance.indexnum, getdvarint(@ "hash_b0049102bfc4b5db", 12000), 0);
}

function function_a2551378bc08f089() {
  thread function_e1ac401f0f3bf679();
  waitframe();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x2f>", @ "hash_1d2ba00bff4b4bf8");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x51>", @ "hash_367a9748af80f8d2");
  scripts\common\devgui::function_fe953f000498048f();
}

function private function_e1ac401f0f3bf679() {
  level endon("<dev string:x65>");

  while(true) {
    if(getdvarint(@ "hash_1d2ba00bff4b4bf8", 0)) {
      setDvar(@ "hash_1d2ba00bff4b4bf8", 0);

      foreach(player in level.players) {
        function_2baca72ada73fba3(player.origin, player, getdvarint(@ "hash_b0049102bfc4b5db", 12000), getdvarint(@ "hash_7cdae490e2d8b495", 60000));
      }
    }

    waitframe();
  }
}

# /