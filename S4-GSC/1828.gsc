/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1828.gsc
*************************************************/

main() {
  _id_CDBE();
}

_id_D82A(var_0) {
  var_1 = getent(var_0.target, "targetname");
  var_1 scripts\cp\utility::_id_D5A6("j_handle", "HINT_BUTTON", "icon_electrical_box", &"CP_STRIKE/TURN_ON_ALARM", 25, "duration_short", "hide", 128, 120, 70, 45);
  var_2 = spawnStruct();
  var_1._id_CBD0 = var_0;
  var_1 scripts\engine\utility::_id_5473("switch_on");

  if(isDefined(var_1)) {
    var_1 thread _id_EC26();
  }

  return var_1;
}

_id_EC26() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    self makeunusable();
    var_1 = _id_0788::_id_182C(var_0, "player_rig", 1);
    var_2 = _id_0788::_id_182C(self, "fusebox_prop");

    if(!scripts\engine\utility::_id_546E("switch_on")) {
      var_2 _id_0788::_id_182E(1, "interact_on", 1);
      var_3 = self._id_CBD0 _id_0788::_id_182B([var_2], "interact_on");

      if(var_3) {
        scripts\engine\utility::_id_5474("switch_on");
        self sethintstring(&"CP_STRIKE/TURN_OFF_ALARM");
      }
    } else {
      var_2 _id_0788::_id_182E(1, "interact", 1);
      var_3 = self._id_CBD0 _id_0788::_id_182B([var_2], "interact");

      if(var_3) {
        scripts\engine\utility::_id_5470("switch_on");
        self sethintstring(&"CP_STRIKE/TURN_ON_ALARM");
      }
    }

    self notify("interact", var_0);
    self makeuseable();
    var_1 = undefined;
    var_2 = undefined;
  }
}

#using_animtree("script_model");

_id_CDBE() {
  level._id_CC34["player_rig"] = #animtree;
  level._id_CC31["player_rig"]["interact"] = % wm_eq_fusebox_plr;
  level._id_CC32["player_rig"]["interact"] = "wm_eq_fusebox_plr";
  level._id_CC3B["player_rig"]["interact"] = "wm_eq_fusebox_plr";
  level._id_CC31["player_rig"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level._id_CC32["player_rig"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level._id_CC3B["player_rig"]["interact_on"] = "wm_eq_fusebox_turn_on_plr";
  level._id_CC34["fusebox_prop"] = #animtree;
  level._id_CC31["fusebox_prop"]["interact"] = % wm_eq_fusebox_prop;
  level._id_CC32["fusebox_prop"]["interact"] = "wm_eq_fusebox_prop";
  level._id_CC31["fusebox_prop"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
  level._id_CC32["fusebox_prop"]["interact_on"] = "wm_eq_fusebox_turn_on_prop";
}