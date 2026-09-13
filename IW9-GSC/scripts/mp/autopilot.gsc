/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\autopilot.gsc
***********************************************/

initialize(_id_FA2678AE217F88A4, _id_2B06AB98D2DCE887, _id_9E3EE86E997516C5) {
  level._id_F162A4362B2B7718 = spawnStruct();
  level._id_F162A4362B2B7718._id_0C214B782DB6525F = ::_id_958101C7BE2FA2EC;
  level._id_F162A4362B2B7718._id_00205CB63B80DA5B = ::_id_062646271AF2F0AA;
  level._id_F162A4362B2B7718._id_F189CA4555AA689E = _id_FA2678AE217F88A4;
  level._id_F162A4362B2B7718._id_A0E6FCDAB1A67082 = _id_2B06AB98D2DCE887;
  level._id_F162A4362B2B7718._id_4FA0FD09A5FFFE94 = _id_9E3EE86E997516C5;
}

_id_958101C7BE2FA2EC() {
  self notify("enter_autopilot");
  self _meth_D6570CE791FA1B08(1);

  if(isDefined(level._id_F162A4362B2B7718._id_A0E6FCDAB1A67082))
    self[[level._id_F162A4362B2B7718._id_A0E6FCDAB1A67082]]();

  scripts\mp\bots\bots::bot_restart_think_threads();
  thread _id_F36B607DF9A92496();
}

_id_F36B607DF9A92496() {
  self endon("enter_autopilot");
  self endon("exit_autopilot");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_ents(self, "death", level, "game_ended");
  self _meth_70C55D1C5A628350();
}

_id_062646271AF2F0AA() {
  self notify("exit_autopilot");
  self notify("bot_think_watch_aerial_killstreak");

  if(isDefined(level._id_F162A4362B2B7718._id_4FA0FD09A5FFFE94))
    self[[level._id_F162A4362B2B7718._id_4FA0FD09A5FFFE94]]();

  self _meth_D6570CE791FA1B08(0);
}