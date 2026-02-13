/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1918.gsc
*************************************************/

init() {
  setDvar("#x3fac8f39da5737155", 1);
  setDvar("#x3f93ae5bcf5c3c0c0", 1);

  if(!isDefined(level.players)) {
    level.players = [];
  }

  _id_17E2();
  _id_7B3A();
  _id_8DB5();
  _id_5554();
  _id_B4F9();
  _id_100E0();
  _id_60AC();
  _id_518C();
  _id_F657();
  _id_10DCA();
  _id_42C7();
  _id_54FB();
  _id_E056();
  _id_5C80();
  _id_D9CD();
  _id_ACBB();
  _id_60B4();
  _id_C022();
  _id_EB3E();
  _id_60E3();
}

_id_17E2() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("anim", "player_solo", _id_0706::_id_17FD);
}

_id_7B3A() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showErrorMessage", scripts\cp\cp_hud_message::_id_DCA2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "teamPlayerCardSplash", scripts\cp\cp_hud_util::_id_EF8D);
}

_id_8DB5() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "addToActiveKillstreakList", scripts\cp\utility::_id_1155);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "isKillstreakWeapon", scripts\cp\utility::_id_88F6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "allowRideKillstreakPlayerExit", scripts\cp\utility::_id_15CF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "getSelectMapPoint", _id_073F::_id_6D1F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "startMapSelectSequence", _id_073F::_id_E6E4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakMakeVehicle", scripts\cp\utility::_id_8DB7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPreModDamageCallback", scripts\cp\utility::_id_8DC1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetPostModDamageCallback", scripts\cp\utility::_id_8DC0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakSetDeathCallback", scripts\cp\utility::_id_8DBF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("killstreak", "killstreakHit", scripts\cp\utility::_id_8DD6);
}

_id_5554() {}

_id_B4F9() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "_isAlive", scripts\cp\utility\player_utility_cp::_isalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setUsingRemote", scripts\cp\utility\player::_id_D8D4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "clearUsingRemote", scripts\cp\utility\player::_id_3990);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isEnemy", scripts\cp\utility\player::isenemy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isUsingRemote", scripts\cp\utility::_id_8ACE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "freezeControls", scripts\cp\utility::_freezecontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "printGameAction", scripts\cp\utility::_id_BD15);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "isPlayerADS", scripts\cp\utility::_id_8989);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "setThirdPersonDOF", scripts\cp\utility::setthirdpersondof);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "hideMiniMap", scripts\cp\utility\player::_id_7908);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "showMiniMap", scripts\cp\utility\player::_id_DCC4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("player", "getPlayersInRadius", scripts\cp\utility::_id_6C5F);
}

_id_100E0() {}

_id_7A3E() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waitLongDurationWithPause", _id_0733::waitlongdurationwithhostmigrationpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hostmigration", "waittillNotifyOrTimeoutPause", _id_0733::_id_108F6);
}

_id_60AC() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isKillStreakDenied", scripts\cp\utility::_id_873C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "isAirDenied", scripts\cp\utility::_id_873C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getEnemyTeams", scripts\cp\utility::_id_6A01);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getGameType", scripts\cp\utility::getgametype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjectiveEngineer", scripts\cp\utility::_id_8DB0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "createObjective", scripts\cp\utility::_id_8DAF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "requestObjectiveID", scripts\cp\utility::_id_A5B0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "returnObjectiveID", scripts\cp\utility::_id_A5B1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "getFriendlyPlayers", _id_0750::_id_6A59);
  scripts\cp_mp\utility\script_utility::registersharedfunc("game", "trySayLocalSound", _id_0750::_id_F759);
}

_id_518C() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "init", _id_077B::_id_5181);
}

_id_F657() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tripwire", "init", _id_0784::init);
}

_id_54FB() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("entity", "delayEntDelete", scripts\cp\utility::_id_46C7);
}

_id_10DCA() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("weapons", "_launchGrenade", scripts\cp\utility::_id_0C48);
}

_id_42C7() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "updateDamageFeedback", _id_071B::_id_FC47);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "onKillstreakKilled", scripts\cp\utility::_id_AB18);
  scripts\cp_mp\utility\script_utility::registersharedfunc("damage", "hudIconType", _id_071B::_id_7B6B);
}

_id_E056() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "trySayLocalSound", _id_0750::_id_F759);
  scripts\cp_mp\utility\script_utility::registersharedfunc("sound", "playKillstreakDeployDialog", _id_0750::_id_B86D);
}

_id_5C80() {}

_id_D9CD() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "artillery_earthQuake", _id_09C8::_id_D9C8);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "flashInterruptDelayFunc", _id_09C8::_id_D9CF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("shellshock", "concussionInterruptDelayFunc", _id_09C8::_id_D9CF);
}

_id_2947() {}

_id_ACBB() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineDisable", scripts\cp\cp_outline_utility::outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForPlayer", scripts\cp\cp_outline_utility::outlineenableforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("outline", "outlineEnableForTeam", scripts\cp\cp_outline_utility::_id_ACD2);
}

_id_60B4() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "init", scripts\cp\utility\game_utility_cp::_id_60B3);
}

_id_C022() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "getScoreInfoValue", _id_0756::getscoreinfovalue);
  scripts\cp_mp\utility\script_utility::registersharedfunc("rank", "giveRankXP", _id_0756::giverankxp);
}

_id_EB3E() {}

_id_60E3() {}