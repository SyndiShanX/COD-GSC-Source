/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1749.gsc
*************************************************/

init() {
  if(!isDefined(level._id_3C41)) {
    level._id_3C41 = spawnStruct();
  }

  _id_0CB2();
  _id_7F33();
}

_id_0CB2() {
  level _id_000F::_id_990C("menu_interaction_complete", ::_id_0C6F);
}

_id_7F33() {
  level thread _id_3C42();
}

_id_3C42() {
  self endon("disconnect");

  while(!isDefined(level._id_0F3A)) {
    waitframe();
  }

  level._id_0F3A thread _id_3C43();
}

_id_3C43() {
  self endon("disconnect");
  var_0 = self;
  level._id_0F3A scripts\engine\utility::_id_5476("menu_interaction_complete");
  level._id_0F3A scripts\engine\utility::_id_5470("menu_interaction_complete", 1);
  var_0 _id_079F::_id_CF63("ContextMenu");
  level._id_0F3A = undefined;
  _id_7F33();
}

_id_DC2C(var_0, var_1) {
  var_2 = self;
  var_3 = spawnStruct();
  var_3._id_AE3F = var_0;
  var_3._id_E747 = var_1;
  var_2 _id_079F::_id_CF62("ContextMenu", "scripted_widget_ftue_context_menu", var_3);
  var_2 _id_079F::scripted_widget_set_position("ContextMenu", 0, 0, 1, 1);

  if(var_2 scripts\engine\utility::_id_5472("menu_interaction_complete")) {
    var_2 scripts\engine\utility::_id_5470("menu_interaction_complete", 1);
  }

  level._id_0F3A = var_2;
}

_id_0C6F(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  level._id_0F3A scripts\engine\utility::_id_5474("menu_interaction_complete");
}