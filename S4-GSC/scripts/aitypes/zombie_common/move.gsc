/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_common\move.gsc
**************************************************/

start_move_away(var_0) {
  level.aimoveawayfromposition = var_0;
  level.aimoveawaytopositions = _func_02AA(var_0, 960, 64);

  if(isDefined(level.aimoveawaytopositions)) {
    level.aimoveawaytopositions = scripts\engine\utility::_id_E026(level.aimoveawaytopositions, var_0);
    level.aimoveawaytopositions = scripts\engine\utility::_id_1BD2(level.aimoveawaytopositions);
  }

  _id_06CB::_id_AA65(::_player_spawned);
}

stop_move_away() {
  _id_06CB::_id_C41D(::_player_spawned);
  level.aimoveawayfromposition = undefined;
  level.aimoveawaytopositions = undefined;
}

shouldmoveaway(var_0) {
  return scripts\engine\utility::ter_op(isDefined(level.aimoveawayfromposition), anim._id_EACB, anim._id_58E3);
}

moveawayinit(var_0) {
  var_1 = spawnStruct();
  var_1.moveawaypos = _select_move_away_position();
  self._id_2C5E._id_82FD[var_0] = var_1;
}

moveaway(var_0) {
  var_1 = self._id_2C5E._id_82FD[var_0];

  if(!isDefined(var_1.moveawaypos)) {
    return anim._id_58E3;
  }

  self _meth_84BC(0, var_1.moveawaypos);
  return anim._id_CA5F;
}

moveawayterminate(var_0) {
  self._id_2C5E._id_82FD[var_0] = undefined;
}

_id_7CA9(var_0) {
  self _meth_8474();
  return anim._id_EACB;
}

checkfordoortoopen(var_0) {
  var_1 = scripts\aitypes\zombie_common\ai_util::get_door_in_path();
  _id_08F1::setdoortoopen(var_1);
  return scripts\engine\utility::ter_op(isDefined(var_1), anim._id_EACB, anim._id_58E3);
}

_select_move_away_position() {
  if(isDefined(level.aimoveawaytopositions)) {
    var_0 = self.origin - level.aimoveawayfromposition;

    foreach(var_2 in level.aimoveawaytopositions) {
      var_3 = vectordot(var_0, var_2 - level.aimoveawayfromposition) > 0;

      if(var_3) {
        level.aimoveawaytopositions = scripts\engine\utility::array_remove(level.aimoveawaytopositions, var_2);
        return var_2;
      }
    }

    foreach(var_2 in level.aimoveawaytopositions) {
      var_6 = distancesquared(var_2, self.origin);
      var_7 = distancesquared(var_2, level.aimoveawayfromposition);

      if(var_6 < var_7) {
        level.aimoveawaytopositions = scripts\engine\utility::array_remove(level.aimoveawaytopositions, var_2);
        return var_2;
      }
    }
  }

  return self.origin;
}

_player_spawned() {
  stop_move_away();
}