/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_hc_pub_fight.gsc
**************************************************************/

main() {
  _id_0557::_id_4BC9("pub fought", "running through pub fight", "CONST_HC_ANALYTICS_PUB_FOUGHT");
  var_0 = _id_52E6();
  var_0 thread _id_77AA();
  common_scripts\utility::flag_init("flag_nest_hc_ee_pub_kills_collected");
}

_id_9276() {
  self endon("dark_wings_objective_finished");
  _id_0378::_id_8D74("dark_wings_start", self);
  var_0 = 0.5;

  for(;;) {
    wait(var_0);

    if(!isDefined(self._id_AC2C) || !isDefined(self._id_AC2D)) {
      continue;
    }
    self._id_400F = _func_0AD(self._id_AC2C) / _func_0AD(self._id_AC2D);
    _id_0378::_id_8D74("dark_wings_update", self._id_400F, var_0);
  }
}

_id_93E4() {
  self waittill("dark_wings_objective_finished");
  _id_0378::_id_8D74("dark_wings_stop");
}

_id_77AA() {
  common_scripts\utility::flag_init("nest_ee_hc_radio_available");
  self["record_player_tech"] _meth_83FA("tech_light", "off");
  common_scripts\utility::_id_3C9F("nest_ee_hc_radio_available");
  self["record_player"] _id_0547::_id_AC41(&"ZOMBIE_NEST_PLACE_HC_RECORD", undefined, self["record_player_trig_offset"].origin);
  var_0 = 0;
  self["record_player_tech"] _meth_83FA("tech_light", "green_on");

  while(!var_0) {
    self["record_player"] waittill("player_used", var_1);
    var_0 = common_scripts\utility::_id_562E(level._id_4BD3);
  }

  self["record_player"] _id_0547::_id_AC40();
  self["record_player"] thread _id_86F6("on");
  self["record_player"] _meth_83FA("record", "on");
  self["record_player"] thread _id_9276();
  self["record_player_tech"] _meth_83FA("tech_light", "red_on");
  self["record_player"] maps\mp\mp_zombie_nest_special_event_creator::_id_170B(25, 400, 400, "pub fight zombie death", undefined, "tag_origin", undefined, undefined, ["raven_sword_zm", "raven_sword_cleave_zm"], undefined, undefined, 5);
  self["record_player_tech"] _meth_83FA("tech_light", "green_on");
  self["record_player"] notify("dark_wings_objective_finished");
  self["record_player"] thread _id_7A4D(self["record_player_tech"]);
  common_scripts\utility::flag_set("flag_nest_hc_ee_pub_kills_collected");
  _id_0557::_id_4BC8("pub fought");
}

_id_7A4D(var_0) {
  self._id_A602 = maps\mp\mp_zombie_nest_ee_paintings::_id_7A54();
  thread _id_8C5F(var_0);
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("7 Voice paintings", "enter code pieces"));
  level._id_3581 = self._id_A602;
}

_id_8C5F(var_0) {
  for(;;) {
    for(var_1 = 0; var_1 < self._id_A602.size; var_1++) {
      for(var_2 = 0; var_2 < self._id_A602[var_1] + 1; var_2++) {
        self playSound("zmb_spinning_top_turn");
        var_0 _meth_83FA("tech_light", "green_on");
        wait 0.2;
        var_0 _meth_83FA("tech_light", "off");
        wait 0.2;
      }

      wait 1;
    }

    var_0 _meth_83FA("tech_light", "red_on");
    wait 0.75;
    var_0 _meth_83FA("tech_light", "off");
    wait 0.75;
  }
}

_id_52E6() {
  var_0 = [];
  var_0["record_player_trig_offset"] = common_scripts\utility::_id_46B5("zmb_phonograph_trig_offset", "script_noteworthy");
  var_1 = _func_21F("zmb_phonograph_model", "targetname");
  var_0["record_player"] = var_1[0];
  var_2 = _func_21F("hc_phonograph_tech_piece", "targetname");
  var_0["record_player_tech"] = var_2[0];
  var_0["record_player"] thread _id_86F6("off");
  var_0["record_player"] _meth_83FA("record", "off");
  return var_0;
}

#using_animtree("destructibles");

_id_86F6(var_0) {
  switch (var_0) {
    case "off":
      self _meth_83FA("machine_main", "turn_off");
      wait(_func_065(%zmb_phonograph_turn_off));
      self _meth_83FA("machine_main", "off");
      break;
    case "on":
      self _meth_83FA("machine_main", "turn_on");
      wait(_func_065(%zmb_phonograph_turn_on));
      self _meth_83FA("machine_main", "on");
      break;
    default:
      break;
  }
}