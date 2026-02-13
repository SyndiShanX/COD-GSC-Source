/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\supers\dead_drop.gsc
*************************************************/

dead_drop_try_use() {
  if(isDefined(self._id_EA13) && self._id_EA13 == 0) {
    scripts\mp\hud_message::_id_DCA2("MP/DEAD_DROP_NO_POINTS_TO_STORE");
    return 0;
  }

  if(isDefined(self._id_EA13) && isDefined(self._id_CB4E) && self._id_EA13 <= self._id_CB4E) {
    scripts\mp\hud_message::_id_DCA2("MP/DEAD_DROP_POINTS_ALREADY_STORED");
    return 0;
  }

  _id_07C4::_id_7B6B("deaddrop");
  scripts\mp\killstreaks\killstreaks::_id_CB52();
  self.dead_drop_active = 1;
  thread dead_drop_monitor_respawn();
  thread dead_drop_monitor_team_change();
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "use_cipher");
  return 1;
}

dead_drop_monitor_team_change() {
  self endon("disconnect");
  self endon("dead_drop_restored");
  self waittill("joined_team");
  self.dead_drop_active = undefined;
}

dead_drop_monitor_respawn() {
  self endon("disconnect");
  self endon("joined_team");
  self waittill("spawned_player");
  self.dead_drop_active = undefined;
  scripts\mp\killstreaks\killstreaks::_id_96A9();
  self notify("dead_drop_restored");
}