/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_hc_pub_fight.gsc
******************************************************/

func_00F9() {
  lib_0557::func_4BC9("pub fought", "running through pub fight", "CONST_HC_ANALYTICS_PUB_FOUGHT");
  var_00 = func_52E6();
  var_00 thread func_77AA();
  common_scripts\utility::func_3C87("flag_nest_hc_ee_pub_kills_collected");
}

func_9276() {
  self endon("dark_wings_objective_finished");
  lib_0378::func_8D74("dark_wings_start", self);
  var_00 = 0.5;
  for(;;) {
    wait(var_00);
    if(!isDefined(self.var_AC2C) || !isDefined(self.var_AC2D)) {
      continue;
    }

    self.var_400F = float(self.var_AC2C) / float(self.var_AC2D);
    lib_0378::func_8D74("dark_wings_update", self.var_400F, var_00);
  }
}

func_93E4() {
  self waittill("dark_wings_objective_finished");
  lib_0378::func_8D74("dark_wings_stop");
}

func_77AA() {
  common_scripts\utility::func_3C87("nest_ee_hc_radio_available");
  self["record_player_tech"] setscriptablepartstate("tech_light", "off");
  common_scripts\utility::func_3C9F("nest_ee_hc_radio_available");
  self["record_player"] lib_0547::func_AC41(&"ZOMBIE_NEST_PLACE_HC_RECORD", undefined, self["record_player_trig_offset"].var_0116);
  var_00 = 0;
  self["record_player_tech"] setscriptablepartstate("tech_light", "green_on");
  while(!var_00) {
    self["record_player"] waittill("player_used", var_01);
    var_00 = common_scripts\utility::func_562E(level.var_4BD3);
  }

  self["record_player"] lib_0547::func_AC40();
  self["record_player"] thread func_86F6("on");
  self["record_player"] setscriptablepartstate("record", "on");
  self["record_player"] thread func_9276();
  self["record_player_tech"] setscriptablepartstate("tech_light", "red_on");
  self["record_player"] maps\mp\mp_zombie_nest_special_event_creator::func_170B(25, 400, 400, "pub fight zombie death", undefined, "tag_origin", undefined, undefined, ["raven_sword_zm", "raven_sword_cleave_zm"], undefined, undefined, 5);
  self["record_player_tech"] setscriptablepartstate("tech_light", "green_on");
  self["record_player"] notify("dark_wings_objective_finished");
  self["record_player"] thread func_7A4D(self["record_player_tech"]);
  common_scripts\utility::func_3C8F("flag_nest_hc_ee_pub_kills_collected");
  lib_0557::func_4BC8("pub fought");
}

func_7A4D(param_00) {
  self.var_A602 = maps\mp\mp_zombie_nest_ee_paintings::func_7A54();
  thread func_8C5F(param_00);
  common_scripts\utility::func_3C9F(lib_0557::func_7838("7 Voice paintings", "enter code pieces"));
  level.var_3581 = self.var_A602;
}

func_8C5F(param_00) {
  for(;;) {
    for(var_01 = 0; var_01 < self.var_A602.size; var_01++) {
      for(var_02 = 0; var_02 < self.var_A602[var_01] + 1; var_02++) {
        self method_8617("zmb_spinning_top_turn");
        param_00 setscriptablepartstate("tech_light", "green_on");
        wait(0.2);
        param_00 setscriptablepartstate("tech_light", "off");
        wait(0.2);
      }

      wait(1);
    }

    param_00 setscriptablepartstate("tech_light", "red_on");
    wait(0.75);
    param_00 setscriptablepartstate("tech_light", "off");
    wait(0.75);
  }
}

func_52E6() {
  var_00 = [];
  var_00["record_player_trig_offset"] = common_scripts\utility::func_46B5("zmb_phonograph_trig_offset", "script_noteworthy");
  var_01 = function_021F("zmb_phonograph_model", "targetname");
  var_00["record_player"] = var_01[0];
  var_02 = function_021F("hc_phonograph_tech_piece", "targetname");
  var_00["record_player_tech"] = var_02[0];
  var_00["record_player"] thread func_86F6("off");
  var_00["record_player"] setscriptablepartstate("record", "off");
  return var_00;
}

func_86F6(param_00) {
  switch (param_00) {
    case "off":
      self setscriptablepartstate("machine_main", "turn_off");
      wait(getanimlength(%zmb_phonograph_turn_off));
      self setscriptablepartstate("machine_main", "off");
      break;

    case "on":
      self setscriptablepartstate("machine_main", "turn_on");
      wait(getanimlength(%zmb_phonograph_turn_on));
      self setscriptablepartstate("machine_main", "on");
      break;

    default:
      break;
  }
}