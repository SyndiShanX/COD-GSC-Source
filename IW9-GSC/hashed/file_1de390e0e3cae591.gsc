/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1de390e0e3cae591.gsc
***********************************************/

main() {
  _id_1A564CC8C5096A80::main();
  _id_5775866BA1F32D52::main();
  _id_4FED0442C774E668::main();
  scripts\mp\load::main();
  level._id_057B13482577DD10 = _func_F159C10D5CF8F0B4("dcover_invalid_noent", "targetname");
  thread _id_B2F8F087CEB71FEA();
  level.modifiedspawnpoints["-432 1432"]["mp_dom_spawn"]["remove"] = 1;
  level.modifiedspawnpoints["-448 1680"]["mp_dom_spawn"]["remove"] = 1;
  level.modifiedspawnpoints["-960 1352"]["mp_dom_spawn"]["remove"] = 1;
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_davos");
  setDvar("r_umbraMinObjectContribution", 8);
  _id_8431FDE12E056D7F = getdvarint("scr_thirdperson", 0) == 1;
  setDvar("scr_game_infilSkip", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  _id_5775866BA1F32D52::_id_43B109B5469486D0();
  _id_5775866BA1F32D52::_id_D908148377A7163D();
  level thread onplayerconnect();

  if(getdvarint("dvar_8610CCD25560C117") == 0)
    thread play_movie("mp_davos_screens");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread stayfrosty();
    player thread staytoasty();
  }
}

stayfrosty() {
  self endon("disconnect");
  level endon("game_ended");
  self.isoutside = 1;
  tag = "TAG_EYE";

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive() && self.isoutside)
      playFXOnTag(level._effect["vfx_davos_players_cold_breath"], self, tag);

    wait(2.5 + randomfloat(3));
  }
}

staytoasty() {
  self endon("disconnect");
  level endon("game_ended");
  _id_41E702607B65AC56 = getEnt("indoorTrigger", "targetname");

  if(isDefined(_id_41E702607B65AC56)) {
    for(;;) {
      if(_id_41E702607B65AC56 istouching(self))
        self.isoutside = 0;
      else
        self.isoutside = 1;

      wait 1;
    }
  }
}

play_movie(bink) {
  level thread _id_20A03E300905ECD6();

  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  for(;;) {
    _func_CE942237D1ECA7D8(bink);
    wait 30;
  }
}

_id_20A03E300905ECD6() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_D49693F5DC5FFFD8 = 1;
  scriptables = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "screen");

  foreach(scriptable in scriptables) {
    scriptable setscriptablepartstate("screen", "bink" + _id_D49693F5DC5FFFD8);
    _id_D49693F5DC5FFFD8++;

    if(_id_D49693F5DC5FFFD8 > 4)
      _id_D49693F5DC5FFFD8 = 1;
  }
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (-704, -1381, 288));
  _id_45428B56EF07EA91 setModel("lighting_modern_floor_lamp_02");
  _id_45428B56EF07EA91.angles = (0, 0, 0);
  _id_AF5DF9A502E8811A = spawn("script_model", (-704, -1048, 288));
  _id_AF5DF9A502E8811A setModel("lighting_modern_floor_lamp_02");
  _id_AF5DF9A502E8811A.angles = (0, 0, 0);
  _id_70F1AB88B4C446AF = spawn("script_model", (-524, -1381, 288));
  _id_70F1AB88B4C446AF setModel("lighting_modern_floor_lamp_02");
  _id_70F1AB88B4C446AF.angles = (0, 0, 0);
  _id_9964A913AA94CF90 = spawn("script_model", (-520, -1048, 288));
  _id_9964A913AA94CF90 setModel("lighting_modern_floor_lamp_02");
  _id_9964A913AA94CF90.angles = (0, 0, 0);
  _id_CBC7EAFF04EB54D5 = spawn("script_model", (-454, -1399, 288));
  _id_CBC7EAFF04EB54D5 setModel("lighting_modern_floor_lamp_02");
  _id_CBC7EAFF04EB54D5.angles = (0, 0, 0);
  _id_51D3A9451C22C04E = spawn("script_model", (-318, -1397, 288));
  _id_51D3A9451C22C04E setModel("lighting_modern_floor_lamp_02");
  _id_51D3A9451C22C04E.angles = (0, 0, 0);
  _id_10688B3021ACC893 = spawn("script_model", (8, -1048, 288));
  _id_10688B3021ACC893 setModel("lighting_modern_floor_lamp_02");
  _id_10688B3021ACC893.angles = (0, 0, 0);
  _id_5514BA2EB35CC4D4 = spawn("script_model", (246, -1080, 288));
  _id_5514BA2EB35CC4D4 setModel("lighting_modern_floor_lamp_02");
  _id_5514BA2EB35CC4D4.angles = (0, 0, 0);
  _id_86EAEC1A0D17D509 = spawn("script_model", (-737, -1360, 399));
  _id_86EAEC1A0D17D509 setModel("berlin_hotel_lights_wall2_on");
  _id_86EAEC1A0D17D509.angles = (0, 0, 0);
  _id_E455BDC55F617019 = spawn("script_model", (-737, -1072, 399));
  _id_E455BDC55F617019 setModel("berlin_hotel_lights_wall2_on");
  _id_E455BDC55F617019.angles = (0, 180, 0);
  _id_968F4BE2024FAE24 = spawn("script_model", (-489, -1360, 399));
  _id_968F4BE2024FAE24 setModel("berlin_hotel_lights_wall2_on");
  _id_968F4BE2024FAE24.angles = (0, 0, 0);
  _id_0F78FDF72484F3B7 = spawn("script_model", (-489, -1072, 399));
  _id_0F78FDF72484F3B7 setModel("berlin_hotel_lights_wall2_on");
  _id_0F78FDF72484F3B7.angles = (0, 180, 0);
  _id_CC832C08D0E12D82 = spawn("script_model", (-281, -1360, 399));
  _id_CC832C08D0E12D82 setModel("berlin_hotel_lights_wall2_on");
  _id_CC832C08D0E12D82.angles = (0, 0, 0);
  _id_6ADB3D6D754520BD = spawn("script_model", (-25, -1072, 399));
  _id_6ADB3D6D754520BD setModel("berlin_hotel_lights_wall2_on");
  _id_6ADB3D6D754520BD.angles = (0, 180, 0);
  _id_3904FB821B89ED58 = spawn("script_model", (231, -1072, 399));
  _id_3904FB821B89ED58 setModel("berlin_hotel_lights_wall2_on");
  _id_3904FB821B89ED58.angles = (0, 180, 0);
  _id_2D00DD93EF0A697B = spawn("script_model", (-390, -1282, 488));
  _id_2D00DD93EF0A697B setModel("electrical_wires_jumbled_spline_128");
  _id_2D00DD93EF0A697B.angles = (0, 0, 90);
  _id_51EE9BB0E58E1736 = spawn("script_model", (-385, -1217, 488));
  _id_51EE9BB0E58E1736 setModel("electrical_wires_jumbled_spline_128");
  _id_51EE9BB0E58E1736.angles = (0, 0, 90);
  _id_26425D0CE5845461 = spawn("script_model", (-322, -1282, 488));
  _id_26425D0CE5845461 setModel("electrical_wires_jumbled_spline_128");
  _id_26425D0CE5845461.angles = (0, 0, 90);
  _id_519ACB1EE09FF80C = spawn("script_model", (-366, -1241, 484));
  _id_519ACB1EE09FF80C setModel("electrical_wires_jumbled_spline_128");
  _id_519ACB1EE09FF80C.angles = (0, 0, 90);
  _id_9F1A1EF9646CCF2C = spawn("script_model", (-327, -1217, 488));
  _id_9F1A1EF9646CCF2C setModel("electrical_wires_jumbled_spline_128");
  _id_9F1A1EF9646CCF2C.angles = (0, 0, 90);
  _id_ECE1B0DCC1810A81 = spawn("script_model", (-366, -1159, 484));
  _id_ECE1B0DCC1810A81 setModel("electrical_wires_jumbled_spline_128");
  _id_ECE1B0DCC1810A81.angles = (0, 0, 90);
  _id_D4811F203263430A = spawn("script_model", (-282, -1250, 488));
  _id_D4811F203263430A setModel("electrical_wires_jumbled_spline_128");
  _id_D4811F203263430A.angles = (0, 0, 90);
  _id_790B910BDFB3E61F = spawn("script_model", (-282, -1250, 488));
  _id_790B910BDFB3E61F setModel("electrical_wires_jumbled_spline_128");
  _id_790B910BDFB3E61F.angles = (0, 0, 90);
  _id_A2978E96D6B8DFC0 = spawn("script_model", (-274, -1241, 484));
  _id_A2978E96D6B8DFC0 setModel("electrical_wires_jumbled_spline_128");
  _id_A2978E96D6B8DFC0.angles = (0, 0, 90);
  _id_724D1084D62DD105 = spawn("script_model", (-277, -1185, 488));
  _id_724D1084D62DD105 setModel("electrical_wires_jumbled_spline_128");
  _id_724D1084D62DD105.angles = (0, 0, 90);
  _id_59EC8EC847102CBE = spawn("script_model", (-274, -1159, 484));
  _id_59EC8EC847102CBE setModel("electrical_wires_jumbled_spline_128");
  _id_59EC8EC847102CBE.angles = (0, 0, 90);
  _id_3472B0AB4FF319C3 = spawn("script_model", (-214, -1250, 488));
  _id_3472B0AB4FF319C3 setModel("electrical_wires_jumbled_spline_128");
  _id_3472B0AB4FF319C3.angles = (0, 0, 90);
  _id_5D2D9FB1DE4A3144 = spawn("script_model", (-219, -1185, 488));
  _id_5D2D9FB1DE4A3144 setModel("electrical_wires_jumbled_spline_128");
  _id_5D2D9FB1DE4A3144.angles = (0, 0, 90);
  _id_AAF511953B5E2639 = spawn("script_model", (-356, -1252, 484));
  _id_AAF511953B5E2639 setModel("lighting_modern_ceiling_cylinder_light_02_on");
  _id_AAF511953B5E2639.angles = (0, 0, 0);
  _id_0A47C99B07128E93 = spawn("script_model", (-248, -1220, 484));
  _id_0A47C99B07128E93 setModel("lighting_modern_ceiling_cylinder_light_02_on");
  _id_0A47C99B07128E93.angles = (0, 0, 0);
  _id_0A47C99B07128E93 = spawn("script_model", (-320, -1200, 480));
  _id_0A47C99B07128E93 setModel("lighting_modern_ceiling_cylinder_light_01_on");
  _id_0A47C99B07128E93.angles = (0, 0, 0);
  _id_B11198451EC20C03 = getEnt("hardpoint_vis_04", "target");

  if(isDefined(_id_B11198451EC20C03))
    _id_B11198451EC20C03.origin = _id_B11198451EC20C03.origin + (0, 0, 56);
}