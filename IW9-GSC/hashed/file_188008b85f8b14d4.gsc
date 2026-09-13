/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_188008b85f8b14d4.gsc
***********************************************/

_id_0ED4C2D913D203BF(players, _id_1022173EA86A7090, _id_334D3B08AEF373D4) {
  if(!isarray(players))
    players = [players];

  foreach(player in players)
  _id_2A728F0062B4E436(player, _id_1022173EA86A7090, _id_334D3B08AEF373D4);
}

_id_2A728F0062B4E436(player, _id_1022173EA86A7090, _id_334D3B08AEF373D4) {
  switch (_id_1022173EA86A7090) {
    case "bounty_placed_enemy":
      _id_1022173EA86A7090 = 1;
      break;
    case "bounty_placed_friendly":
      _id_1022173EA86A7090 = 2;
      break;
    case "bounty_placed_self":
      _id_1022173EA86A7090 = 3;
      break;
    case "bounty_completed":
      _id_1022173EA86A7090 = 4;
      break;
    case "plea_grace_time":
      _id_1022173EA86A7090 = 5;
      break;
    default:
      _id_1022173EA86A7090 = 0;
      break;
  }

  if(_id_1022173EA86A7090 > 0) {
    player setclientomnvar("ui_upper_notification_type", _id_1022173EA86A7090);
    dangernotifyresetforplayer(player, _id_334D3B08AEF373D4);
  }
}

dangernotifyresetforplayer(player, _id_334D3B08AEF373D4) {
  playerid = player getxuid();

  if(!isDefined(_id_334D3B08AEF373D4))
    _id_334D3B08AEF373D4 = 4;

  level notify("upper_notification_start_" + playerid);
  level thread watchdangerresetaction(player, playerid, "death_or_disconnect");
  level thread watchdangerresetaction(player, playerid, undefined, _id_334D3B08AEF373D4);
}

watchdangerresetaction(player, playerid, action, timeout) {
  level endon("upper_notification_start_" + playerid);
  level endon("upper_notification_finished_" + playerid);
  level endon("game_ended");

  if(isDefined(action))
    player waittill(action);
  else if(isDefined(timeout))
    wait(timeout);

  if(isDefined(player))
    player setclientomnvar("ui_upper_notification_type", 0);

  level notify("upper_notification_finished_" + playerid);
}