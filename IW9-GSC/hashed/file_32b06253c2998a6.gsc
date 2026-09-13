/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_32b06253c2998a6.gsc
***********************************************/

_id_77B897F7716B8FF8(_id_0C85BA41ED96F4C4) {
  _id_A9984444514FF39A();
  wait 2;
  thread _id_A587D9FFFED95CCF(_id_0C85BA41ED96F4C4);
}

_id_A9984444514FF39A() {
  scripts\engine\utility::flag_init("ftue_player_walked");
  scripts\engine\utility::flag_init("ftue_player_sprinted");
  scripts\engine\utility::flag_init("ftue_player_tactial_sprinted");
  scripts\engine\utility::flag_init("ftue_player_auto_sprinted");
  scripts\engine\utility::flag_init("ftue_player_moved_camera");
  scripts\engine\utility::flag_init("ftue_player_moved_camera_and_walked");
  scripts\engine\utility::flag_init("ftue_player_gas_minimap");
  thread _id_6B1017606BBE1A47::_id_33749FEFAB503510(getdvarint("dvar_EE469D27E4289247", 2));
  thread _id_6B1017606BBE1A47::_id_348924356F8BAD24();
  thread _id_6B1017606BBE1A47::_id_D4A746782D28E9AD();
  thread _id_6B1017606BBE1A47::_id_4CF7B50740F57F7B();
  thread _id_6B1017606BBE1A47::_id_105BD25B72F6EA55(getdvarint("dvar_662138DA96C93838", 90));
  thread _id_6B1017606BBE1A47::_id_4F94F7B207E54B3F(getdvarint("dvar_23CD75BDE42DA8FA", 2), getdvarint("dvar_687F1B162DC45A02", 90));
}

_id_A587D9FFFED95CCF(_id_0C85BA41ED96F4C4) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("ftue_completed");
  _id_088C0DC3A363B9D3(getdvarint("dvar_D97115F3374E6F10", 2), ::_id_A68431A04C04726A, ::_id_F586B8896B2759B3);
  scripts\engine\utility::flag_wait("ftue_player_walked");
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  _id_916BA40EA734F75A(getdvarint("dvar_6ECD83EC95C61773", 2), ::_id_6B645084FAE7A31D, ::_id_008043B1F8506098);
  scripts\engine\utility::flag_wait("ftue_player_sprinted");
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  _id_09B8B2A6FD4A868B(getdvarint("dvar_C211B7F4A4014A19", 2), ::_id_87F2199E3E30690A, ::_id_BF9901CE62634B7B);
  scripts\engine\utility::flag_wait("ftue_player_tactial_sprinted");
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  _id_1FBDAD041CADE585(getdvarint("dvar_AC9065E141511F57", 2), ::_id_9190DE7599424864, ::_id_F4173CC2BD202AA5);
  scripts\engine\utility::flag_wait("ftue_player_auto_sprinted");
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  _id_44F78EE91DCBE658(getdvarint("dvar_25B38D4A50722D1A", 2), ::_id_D8ACF8FDE84000D7, ::_id_E8A74242053642AA);
  scripts\engine\utility::flag_wait("ftue_player_moved_camera");
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  _id_D5254A5DF1EAD52D(getdvarint("dvar_EE37365AE1BBDBB6", 2), ::_id_DDF68434578CBC75, ::_id_82852A9B4B43A5A8);
  scripts\engine\utility::flag_wait("ftue_player_moved_camera_and_walked");
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  _id_FA5E2CB288F43AFB(_id_0C85BA41ED96F4C4);
  scripts\engine\utility::flag_wait("ftue_player_fired");
  _id_52EED65F3AF6AF91::_id_7FD621B8BA80E652();
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("ftueCompletedTip", 5);
  self notify("ftue_completed");
}

_id_088C0DC3A363B9D3(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  thread _id_6B1017606BBE1A47::_id_7C4B6588A387E2D5(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109);
}

_id_A68431A04C04726A(player) {
  scripts\engine\utility::flag_set("ftue_player_walked");
}

_id_F586B8896B2759B3(player) {
  player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("walkTip", 5);
}

_id_916BA40EA734F75A(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  thread _id_6B1017606BBE1A47::_id_EE0F48A23C219539(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109);
}

_id_6B645084FAE7A31D(player) {
  scripts\engine\utility::flag_set("ftue_player_sprinted");
}

_id_008043B1F8506098(player) {
  player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("sprintTip", 5);
}

_id_09B8B2A6FD4A868B(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  thread _id_6B1017606BBE1A47::_id_4DFBC95B23A556F4(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109);
}

_id_BF9901CE62634B7B(player) {
  player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("tacticalSprintTip", 5);
}

_id_87F2199E3E30690A(player) {
  scripts\engine\utility::flag_set("ftue_player_tactial_sprinted");
}

_id_1FBDAD041CADE585(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  thread _id_6B1017606BBE1A47::_id_768AAA759077DF62(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109);
}

_id_F4173CC2BD202AA5(player) {
  player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("autoSprintTip", 5);
}

_id_9190DE7599424864(player) {
  scripts\engine\utility::flag_set("ftue_player_auto_sprinted");
}

_id_44F78EE91DCBE658(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  thread _id_6B1017606BBE1A47::_id_E58BB74EC5F54731(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109);
}

_id_E8A74242053642AA(player) {
  player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("moveCameraTip", 5);
}

_id_D8ACF8FDE84000D7(player) {
  scripts\engine\utility::flag_set("ftue_player_moved_camera");
}

_id_D5254A5DF1EAD52D(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  thread _id_6B1017606BBE1A47::_id_E7A33BFB4CBA7633(_id_2CA8D0A52885D908, _id_6E8B41E0A5648F49, _id_EECB169540A9F109);
}

_id_82852A9B4B43A5A8(player) {
  player _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("moveCameraAndWalkTip", 5);
}

_id_DDF68434578CBC75(player) {
  scripts\engine\utility::flag_set("ftue_player_moved_camera_and_walked");
}

_id_FA5E2CB288F43AFB(_id_0C85BA41ED96F4C4) {
  _id_52EED65F3AF6AF91::_id_9E0151BAA208FE9E("shootTargetsTip", 5);
  self._id_742950F0620086DB = _id_0C85BA41ED96F4C4.size;

  foreach(target in _id_0C85BA41ED96F4C4) {
    target _id_6B3A1552A79F4CFF(self, 0, ::_id_B8D2CFCA22B74498);
    target setCanDamage(1);
  }
}

_id_6B3A1552A79F4CFF(player, _id_A519A2A30C26B6DA, damagecallback) {
  _id_31A28435DF609F42 = &"FTUE_MOBILE/SHOOT_TEST";

  if(_id_A519A2A30C26B6DA)
    _id_31A28435DF609F42 = &"FTUE_MOBILE/SHOOT_ADS_TEST";

  _id_695A872D7D692EFA::_id_070E0DE6281199E7(self, _id_31A28435DF609F42, "icon_waypoint_objective_general", 5);
  _id_348E4E7E77FD824D::_id_1EFD3EF097BC71EF(player, _id_A519A2A30C26B6DA, damagecallback);
}

_id_B8D2CFCA22B74498(player) {
  if(!isDefined(player._id_289B15BD825735D0))
    player._id_289B15BD825735D0 = 0;

  _id_695A872D7D692EFA::_id_B30874D13004D4C5(self);
  player._id_289B15BD825735D0 = player._id_289B15BD825735D0 + 1;

  if(player._id_289B15BD825735D0 == player._id_742950F0620086DB)
    scripts\engine\utility::flag_set("ftue_player_fired");
}