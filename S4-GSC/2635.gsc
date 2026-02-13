/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2635.gsc
*************************************************/

_id_7819() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("radar_drone_recon", _id_09B5::_id_F789);
  scripts\mp\killstreaks\killstreaks::_id_C26A("radar_drone_escort", _id_09B5::_id_F789);
  scripts\mp\killstreaks\killstreaks::_id_C26A("radar_drone_overwatch", _id_09B7::_id_F78C);
  scripts\mp\killstreaks\killstreaks::_id_C26A("scrambler_drone_escort", _id_09B5::_id_F789);
  scripts\mp\killstreaks\killstreaks::_id_C26A("scrambler_drone_guard", _id_09B5::_id_F789);
  var_0 = getarraykeys(level._id_786E);

  foreach(var_2 in var_0) {
    var_3 = level._id_786E[var_2]._id_79C0;

    if(isDefined(var_3)) {
      _id_0AAF::_id_D42B(var_2, var_3);
      _id_0AAF::_id_D447("emp_grenade_mp", var_3, var_2);
    }
  }

  _id_0A97::_id_C28A(::_id_7851);
}

_id_7851(var_0) {}