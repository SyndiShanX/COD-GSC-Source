/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_40680f103165f1ab.gsc
*************************************************/

#using script_239a365a92ee4476;
#using script_30c3ef7ce3f2a3f3;
#using script_32d93a194074fa6a;
#using script_3d3a4f9a13038759;
#using script_49933f4f48d029a1;
#using script_530f3ea26428deba;
#using script_5693b37bfb748170;
#using script_5a37c8d34c31ea89;
#using script_5dfa1fb6b030bdcb;
#using script_6981400abfcd765c;
#using script_8cd9c937ed5832c;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#namespace ftue_mgl;

function init() {
  function_c5ebc1fd82f62050();

  if(function_94b952789d039abb()) {
    function_a6ca80cf4f22e262("ftuetiplist:ftuetips_list_mgl");
    function_e9bceeafa296cb55();
    function_34c0594d8a03efe4("MOBILE");
    function_8d0bcd24e525ca55();

    if(function_833ff7f6baa0d39b()) {
      function_b4775d8fc73bc544();
      thread function_c53f0344e549edd5();
      return;
    }

    thread namespace_91fad7208d9cd856::init(&namespace_be856862625a33f5::function_9fcc9920ba3dbe3, &namespace_b5e6108f786dfb5a::function_8b40ab90e906603c, &namespace_be856862625a33f5::function_b73181b6c636632f);
  }
}

function private function_833ff7f6baa0d39b() {
  if(getDvar(@ "hash_12e53040d5281856", "") == "scripted") {
    return true;
  }

  return false;
}

function private function_b4775d8fc73bc544() {
  level namespace_31c289156a6de223::function_d5724a0f0cd63d12();
  level namespace_7a940f32a2647673::function_1367788e05985a34();
  level namespace_de07b9ab09edf46a::function_7fa382ebd44ac411();
}

function private function_c53f0344e549edd5() {
  level endon("game_ended");

  while(!isDefined(function_81a6047c307f59f2())) {
    waitframe();
  }

  player = function_81a6047c307f59f2();

  if(!player function_83fc92d8ce12ec9e(2)) {
    player function_dec6429d4bf84464("MobileFTUEOrientationTutorialTooltip");
    player.var_56f36fd7cc3d8098 = 1;
    thread namespace_de07b9ab09edf46a::function_c53f0344e549edd5();
    player namespace_91fad7208d9cd856::function_a73346037eb9b85f();
    return;
  }

  println("<dev string:x1c>");
}

function private function_81a6047c307f59f2() {
  if(!isDefined(level.players)) {
    return undefined;
  }

  for(i = 0; i < level.players.size; i++) {
    var_dd559c1ce15ae3d5 = level.players[i];

    if(isDefined(var_dd559c1ce15ae3d5) && !isbot(var_dd559c1ce15ae3d5)) {
      return var_dd559c1ce15ae3d5;
    }
  }

  return undefined;
}

function private function_c5ebc1fd82f62050() {
  level.var_114256fded8103cd = "ftueCommonData";
}