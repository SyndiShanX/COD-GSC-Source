/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn_2\gen\cp_dwn_twn_2_sound.gsc
*******************************************************************/

function main() {
  var0 = scripts\common\createfx::createloopsound();
  var0 scripts\common\createfx::set_origin_and_angles((-39141, 82515.6, -537.756), (270, 0, 0));
  var0.v["soundalias"] = "emt_stresstest_bird_loop";
  var0 = scripts\common\createfx::createloopsound();
  var0 scripts\common\createfx::set_origin_and_angles((50061.2, 82720.6, 2553.11), (270, 0, 0));
  var0.v["soundalias"] = "emt_stresstest_bird_loop";
  var0 = scripts\common\createfx::createloopsound();
  var0 scripts\common\createfx::set_origin_and_angles((51381.4, 82642.8, -768.054), (270, 0, 0));
  var0.v["soundalias"] = "emt_stresstest_bird_loop";
  var0 = scripts\common\createfx::createloopsound();
  var0 scripts\common\createfx::set_origin_and_angles((38481.3, 4845.4, 947.094), (270, 0, 0));
  var0.v["soundalias"] = "emt_stresstest_bird_loop";
  var0 = scripts\common\createfx::createloopsound();
  var0 scripts\common\createfx::set_origin_and_angles((-45219, -26543.6, 3680), (270, 0, 0));
  var0.v["soundalias"] = "emt_stresstest_bird_loop";
  var0 = scripts\common\createfx::createintervalsound();
  var0 scripts\common\createfx::set_origin_and_angles((-39181.4, 82587.7, -538.641), (270, 0, 0));
  var0.v["delay_min"] = 20;
  var0.v["delay_max"] = 30;
  var0.v["soundalias"] = "emt_stresstest_bird_singleshots";
  var0 = scripts\common\createfx::createintervalsound();
  var0 scripts\common\createfx::set_origin_and_angles((51402.3, 82638.3, -768.724), (270, 0, 0));
  var0.v["delay_min"] = 20;
  var0.v["delay_max"] = 30;
  var0.v["soundalias"] = "emt_stresstest_bird_singleshots";
  var0 = scripts\common\createfx::createintervalsound();
  var0 scripts\common\createfx::set_origin_and_angles((38442, 4884.66, 947.094), (270, 0, 0));
  var0.v["delay_min"] = 20;
  var0.v["delay_max"] = 30;
  var0.v["soundalias"] = "emt_stresstest_bird_singleshots";
  var0 = scripts\common\createfx::createintervalsound();
  var0 scripts\common\createfx::set_origin_and_angles((-45174.7, -26503.6, 3680), (270, 0, 0));
  var0.v["delay_min"] = 20;
  var0.v["delay_max"] = 30;
  var0.v["soundalias"] = "emt_stresstest_bird_singleshots";
  var0 = scripts\common\createfx::createreactiveent();
  var0 scripts\common\createfx::set_origin_and_angles((-39214.4, 82648.9, -539.662), (270, 0, 0));
  var0.v["soundalias"] = "rex_stresstest_metal_pipes";
  var0.v["reactive_radius"] = 350;
  var0 = scripts\common\createfx::createreactiveent();
  var0 scripts\common\createfx::set_origin_and_angles((51408.6, 82621.8, -767.568), (270, 0, 0));
  var0.v["soundalias"] = "rex_stresstest_metal_pipes";
  var0.v["reactive_radius"] = 350;
  var0 = scripts\common\createfx::createreactiveent();
  var0 scripts\common\createfx::set_origin_and_angles((38440.7, 4804.31, 947.094), (270, 0, 0));
  var0.v["soundalias"] = "rex_stresstest_metal_pipes";
  var0.v["reactive_radius"] = 350;
  var0 = scripts\common\createfx::createreactiveent();
  var0 scripts\common\createfx::set_origin_and_angles((-45259.2, -26504.6, 3680), (270, 0, 0));
  var0.v["soundalias"] = "rex_stresstest_metal_pipes";
  var0.v["reactive_radius"] = 350;
}