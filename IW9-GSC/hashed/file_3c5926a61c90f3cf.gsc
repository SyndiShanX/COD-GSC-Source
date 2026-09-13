/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3c5926a61c90f3cf.gsc
***********************************************/

main() {
  _id_3548AD60EA702547::main();
  _id_2A0DF8CB39CABE4A::main();
  _id_61977CBE175B8054::main();
  _id_7E5112BE1AF9ECA2::main();
  scripts\mp\load::main();
  scripts\common\create_script_utility::initialize_create_script();
  level thread _id_256597DF1182AF18::main();
  level thread _id_455A02BF3FE31AC4::main();

  switch (scripts\mp\utility\game::getgametype()) {
    case "bigctf":
      level thread _id_6B28D5685226880B::main();
      _id_39A8B103D9252A73::_id_60DB244685153D79();
      break;
    case "sd":
    case "rescue":
    case "cyber":
      level thread _id_1DA6FB8EF455D073::main();
      scripts\mp\spawnlogic::_id_9A3BEF3FFEF9C904(1);
      scripts\mp\utility\dialog::_id_7991789FBDEF687E();
      break;
  }

  scripts\cp_mp\utility\game_utility::registerlargemap();
  scripts\cp_mp\utility\game_utility::_id_9CFE515677727128();

  if(scripts\mp\utility\game::_id_A7CAA13EBE4C4BA5() || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (scripts\mp\utility\game::getgametype()) {
        case "gwtdm":
          setDvar("scr_localeID", 43);
          break;
        case "sd":
        case "rescue":
        case "cyber":
          setDvar("scr_localeID", 142);
          break;
        default:
          setDvar("scr_localeID", 42);
          break;
      }
    }

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  scripts\mp\compass::setupminimap("compass_map_mp_nogales_gw2");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("fd_helicopter_altitude_limiter", 6000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "mexico";
  level._id_56BCDC219D432F80["axis"] = 15;
  level._id_56BCDC219D432F80["allies"] = 15;

  switch (scripts\mp\utility\game::getgametype()) {
    case "arm":
      _id_E430C168F5F4143E();
      break;
  }

  thread _id_B2F8F087CEB71FEA();
  thread _id_5098D2AB9CBB0808();
  level._id_F0872E42DAF6D4D5 = getclosestpointonnavmesh((26776, 26967, -487));
  level.adjustshipmentspawns = 1;
  level thread adjustactivespawnlogic();
  level _id_274CD16D0AF35466();
}

_id_B2F8F087CEB71FEA() {
  _id_1E15CC204F179CEC = getEnt("mantle256", "targetname");
  _id_45428B56EF07EA91 = spawn("script_model", (27562, 25706, 1362));
  _id_45428B56EF07EA91.angles = (327.915, 241.484, 3.30087);
  _id_45428B56EF07EA91 clonebrushmodeltoscriptmodel(_id_1E15CC204F179CEC, 1);
  _id_1E15CF204F17A385 = getEnt("mantle256", "targetname");
  _id_AF5DF9A502E8811A = spawn("script_model", (26347, 26348, 1365));
  _id_AF5DF9A502E8811A.angles = (327.915, 242.784, 3.301);
  _id_AF5DF9A502E8811A clonebrushmodeltoscriptmodel(_id_1E15CF204F17A385, 1);
  _id_1E15CE204F17A152 = getEnt("mantle256", "targetname");
  _id_70F1AB88B4C446AF = spawn("script_model", (25772, 26546, 1362));
  _id_70F1AB88B4C446AF.angles = (327.915, 250.784, 3.30085);
  _id_70F1AB88B4C446AF clonebrushmodeltoscriptmodel(_id_1E15CE204F17A152, 1);
  _id_1E15C9204F179653 = getEnt("mantle256", "targetname");
  _id_9964A913AA94CF90 = spawn("script_model", (24840, 26842, 1364));
  _id_9964A913AA94CF90.angles = (327.915, 250.784, 3.30085);
  _id_9964A913AA94CF90 clonebrushmodeltoscriptmodel(_id_1E15C9204F179653, 1);
  _id_1E15C8204F179420 = getEnt("mantle64", "targetname");
  _id_CBC7EAFF04EB54D5 = spawn("script_model", (24883, 26972, 1278));
  _id_CBC7EAFF04EB54D5.angles = (327.915, 250.784, 3.30085);
  _id_CBC7EAFF04EB54D5 clonebrushmodeltoscriptmodel(_id_1E15C8204F179420, 1);
  _id_1E15CB204F179AB9 = getEnt("mantle256", "targetname");
  _id_51D3A9451C22C04E = spawn("script_model", (25347.6, 28147.4, 1364));
  _id_51D3A9451C22C04E.angles = (327.915, 73.9839, 3.30078);
  _id_51D3A9451C22C04E clonebrushmodeltoscriptmodel(_id_1E15CB204F179AB9, 1);
  _id_1E15CA204F179886 = getEnt("mantle64", "targetname");
  _id_10688B3021ACC893 = spawn("script_model", (25309.9, 28015.1, 1278));
  _id_10688B3021ACC893.angles = (327.915, 73.9839, 3.30078);
  _id_10688B3021ACC893 clonebrushmodeltoscriptmodel(_id_1E15CA204F179886, 1);
  _id_1E15D5204F17B0B7 = getEnt("mantle256", "targetname");
  _id_5514BA2EB35CC4D4 = spawn("script_model", (26284.6, 27883.4, 1364));
  _id_5514BA2EB35CC4D4.angles = (327.915, 74.5839, 3.30075);
  _id_5514BA2EB35CC4D4 clonebrushmodeltoscriptmodel(_id_1E15D5204F17B0B7, 1);
  _id_1E15D4204F17AE84 = getEnt("mantle256", "targetname");
  _id_86EAEC1A0D17D509 = spawn("script_model", (26868.6, 27627.4, 1362));
  _id_86EAEC1A0D17D509.angles = (327.915, 64.5837, 3.30068);
  _id_86EAEC1A0D17D509 clonebrushmodeltoscriptmodel(_id_1E15D4204F17AE84, 1);
  _id_418CC70DF0EDF7D4 = getEnt("mantle256", "targetname");
  _id_E455BDC55F617019 = spawn("script_model", (28164.6, 27001.4, 1364));
  _id_E455BDC55F617019.angles = (327.915, 64.5837, 3.30068);
  _id_E455BDC55F617019 clonebrushmodeltoscriptmodel(_id_418CC70DF0EDF7D4, 1);
  _id_418CC80DF0EDFA07 = getEnt("mantle64", "targetname");
  _id_968F4BE2024FAE24 = spawn("script_model", (28104.6, 26877.4, 1278));
  _id_968F4BE2024FAE24.angles = (327.915, 64.5837, 3.30068);
  _id_968F4BE2024FAE24 clonebrushmodeltoscriptmodel(_id_418CC80DF0EDFA07, 1);
  _id_418CC90DF0EDFC3A = getEnt("mantle64", "targetname");
  _id_0F78FDF72484F3B7 = spawn("script_model", (28226.6, 27129.4, 1432));
  _id_0F78FDF72484F3B7.angles = (0, 65.9998, 0);
  _id_0F78FDF72484F3B7 clonebrushmodeltoscriptmodel(_id_418CC90DF0EDFC3A, 1);
  _id_418CCA0DF0EDFE6D = getEnt("mantle64", "targetname");
  _id_CC832C08D0E12D82 = spawn("script_model", (26930.6, 27757.4, 1432));
  _id_CC832C08D0E12D82.angles = (0, 63.9998, 0);
  _id_CC832C08D0E12D82 clonebrushmodeltoscriptmodel(_id_418CCA0DF0EDFE6D, 1);
  _id_418CC30DF0EDEF08 = getEnt("mantle64", "targetname");
  _id_6ADB3D6D754520BD = spawn("script_model", (26324.6, 28023.4, 1434));
  _id_6ADB3D6D754520BD.angles = (0, 73.9997, 0);
  _id_6ADB3D6D754520BD clonebrushmodeltoscriptmodel(_id_418CC30DF0EDEF08, 1);
  _id_418CC40DF0EDF13B = getEnt("mantle64", "targetname");
  _id_3904FB821B89ED58 = spawn("script_model", (25386.6, 28285.4, 1432));
  _id_3904FB821B89ED58.angles = (0, 73.9997, 0);
  _id_3904FB821B89ED58 clonebrushmodeltoscriptmodel(_id_418CC40DF0EDF13B, 1);
  _id_418CC50DF0EDF36E = getEnt("mantle64", "targetname");
  _id_2D00DD93EF0A697B = spawn("script_model", (24790.6, 26707.4, 1432));
  _id_2D00DD93EF0A697B.angles = (0, 69.9996, 0);
  _id_2D00DD93EF0A697B clonebrushmodeltoscriptmodel(_id_418CC50DF0EDF36E, 1);
  _id_418CC60DF0EDF5A1 = getEnt("mantle64", "targetname");
  _id_51EE9BB0E58E1736 = spawn("script_model", (25724.6, 26411.4, 1432));
  _id_51EE9BB0E58E1736.angles = (0, 69.9996, 0);
  _id_51EE9BB0E58E1736 clonebrushmodeltoscriptmodel(_id_418CC60DF0EDF5A1, 1);
  _id_418CBF0DF0EDE63C = getEnt("mantle64", "targetname");
  _id_26425D0CE5845461 = spawn("script_model", (26280.6, 26221.4, 1432));
  _id_26425D0CE5845461.angles = (0, 61.9995, 0);
  _id_26425D0CE5845461 clonebrushmodeltoscriptmodel(_id_418CBF0DF0EDE63C, 1);
  _id_418CC00DF0EDE86F = getEnt("mantle64", "targetname");
  _id_519ACB1EE09FF80C = spawn("script_model", (27492.6, 25577.4, 1432));
  _id_519ACB1EE09FF80C.angles = (0, 61.9995, 0);
  _id_519ACB1EE09FF80C clonebrushmodeltoscriptmodel(_id_418CC00DF0EDE86F, 1);
  _id_9F1A1EF9646CCF2C = spawn("script_model", (29177, 24515.3, 1453.5));
  _id_9F1A1EF9646CCF2C setModel("hardware_plywood_bare_01");
  _id_9F1A1EF9646CCF2C.angles = (0.130077, 136.652, 1.88689);
  _id_ECE1B0DCC1810A81 = spawn("script_model", (26427, 19742, 1779.5));
  _id_ECE1B0DCC1810A81 setModel("hardware_plywood_bare_01_48_dirty");
  _id_ECE1B0DCC1810A81.angles = (271.8, 180, 80);
  _id_D4811F203263430A = spawn("script_model", (26568, 19707, 1780));
  _id_D4811F203263430A setModel("hardware_plywood_bare_01_48_dirty");
  _id_D4811F203263430A.angles = (274, 271.2, -100);
  _id_790B910BDFB3E61F = spawn("script_model", (26759, 19677, 1780));
  _id_790B910BDFB3E61F setModel("hardware_plywood_bare_01_48_dirty");
  _id_790B910BDFB3E61F.angles = (275.4, 269.248, -99.947);
  _id_A2978E96D6B8DFC0 = spawn("script_model", (26812, 19663, 1779));
  _id_A2978E96D6B8DFC0 setModel("hardware_plywood_bare_01_48_dirty");
  _id_A2978E96D6B8DFC0.angles = (86.166, 78.231, 88.452);
  _id_724D1084D62DD105 = spawn("script_model", (26924, 19739, 1779.5));
  _id_724D1084D62DD105 setModel("hardware_plywood_bare_01_48_dirty");
  _id_724D1084D62DD105.angles = (271.8, 0, 80);
  _id_59EC8EC847102CBE = spawn("script_model", (26429, 19738, 1779));
  _id_59EC8EC847102CBE setModel("hardware_plywood_bare_01_48_destr_s1_f2");
  _id_59EC8EC847102CBE.angles = (359.108, 78.333, -4.309);
  _id_3472B0AB4FF319C3 = spawn("script_model", (26922, 19745, 1779));
  _id_3472B0AB4FF319C3 setModel("hardware_plywood_bare_01_48_destr_s1_f2");
  _id_3472B0AB4FF319C3.angles = (359.108, 258.333, -4.309);
  _id_5D2D9FB1DE4A3144 = spawn("script_model", (26482, 19720, 1768));
  _id_5D2D9FB1DE4A3144 setModel("hardware_plywood_bare_01_48_destr_s1_f2");
  _id_5D2D9FB1DE4A3144.angles = (83.396, 340.186, 169.004);
  _id_AAF511953B5E2639 = spawn("script_model", (26491, 19719, 1785));
  _id_AAF511953B5E2639 setModel("hardware_plywood_bare_01_48_destr_s1_f2");
  _id_AAF511953B5E2639.angles = (359.894, 167.593, 178.362);
  _id_0A47C99B07128E93 = spawn("script_model", (26456, 19726, 1779));
  _id_0A47C99B07128E93 setModel("hardware_plywood_bare_01_48_destr_s1_f2");
  _id_0A47C99B07128E93.angles = (359.592, 171.267, 2.46);
  _id_4BB2E7B00188864E = spawn("script_model", (26475, 19737, 1761));
  _id_4BB2E7B00188864E setModel("decor_barrels_gameplay_water");
  _id_4BB2E7B00188864E.angles = (0, 0, 0);
  _id_C5A72969EA511AD5 = spawn("script_model", (26445, 19742, 1761));
  _id_C5A72969EA511AD5 setModel("decor_barrels_gameplay_water");
  _id_C5A72969EA511AD5.angles = (0, 301.4, 0);
  _id_9343E77E8FFA9590 = spawn("script_model", (26475, 19722, 1787));
  _id_9343E77E8FFA9590 setModel("hardware_plywood_bare_01_48_destr_s1_f2");
  _id_9343E77E8FFA9590.angles = (2.693, 175.113, -1.383);
  _id_4195B70DF0F7F352 = getEnt("mantle64", "targetname");
  _id_6AD0E9F39A2A0CAF = spawn("script_model", (26458, 19752, 1806));
  _id_6AD0E9F39A2A0CAF.angles = (0, 350, 0);
  _id_6AD0E9F39A2A0CAF clonebrushmodeltoscriptmodel(_id_4195B70DF0F7F352, 1);
  _id_4195B80DF0F7F585 = getEnt("mantle32", "targetname");
  _id_A93D380FE84E471A = spawn("script_model", (26486, 19736, 1806));
  _id_A93D380FE84E471A.angles = (0, 260, 0);
  _id_A93D380FE84E471A clonebrushmodeltoscriptmodel(_id_4195B80DF0F7F585, 1);
}

_id_5098D2AB9CBB0808() {
  _id_3F21C9C1D46DB091 = spawn("script_model", (28686, 20794, 1571));
  _id_3F21C9C1D46DB091 setModel("hardware_plywood_bare_01_48_dirty");
  _id_3F21C9C1D46DB091.angles = (0, 79.4001, -90);
  _id_8FC677E11DAE84FC = spawn("script_model", (28658, 20802, 1525.04));
  _id_8FC677E11DAE84FC setModel("decor_barrels_gameplay_water");
  _id_8FC677E11DAE84FC.angles = (0, 137.398, 0);
  _id_6B2D8A562C1B296B = spawn("script_model", (28613, 20802, 1525.04));
  _id_6B2D8A562C1B296B setModel("decor_barrels_gameplay_water");
  _id_6B2D8A562C1B296B.angles = (0, 0, 0);
  _id_4195BC0DF0F7FE51 = getEnt("mantle128", "targetname");
  _id_0A5248687BFEC0E6 = spawn("script_model", (28643, 20824, 1573));
  _id_0A5248687BFEC0E6.angles = (0, 349.4, 0);
  _id_0A5248687BFEC0E6 clonebrushmodeltoscriptmodel(_id_4195BC0DF0F7FE51, 1);
  _id_417FB50DF0DFBBB9 = getEnt("mantle128", "targetname");
  _id_C171115F2B3C4B4E = spawn("script_model", (28677, 20755, 1573));
  _id_C171115F2B3C4B4E.angles = (0, 259.4, 0);
  _id_C171115F2B3C4B4E clonebrushmodeltoscriptmodel(_id_417FB50DF0DFBBB9, 1);
  _id_417FB40DF0DFB986 = getEnt("mantle128", "targetname");
  _id_8005F34A30C65393 = spawn("script_model", (28587, 20772, 1573));
  _id_8005F34A30C65393.angles = (0, 259.4, 0);
  _id_8005F34A30C65393 clonebrushmodeltoscriptmodel(_id_417FB40DF0DFB986, 1);
  _id_0902112DB9AE5A90 = spawn("script_model", (26485, 19512, 1708));
  _id_0902112DB9AE5A90 setModel("hardware_plywood_bare_01_48_dirty");
  _id_0902112DB9AE5A90.angles = (86.04, 76.411, -93.651);
  _id_3B6553191404DFD5 = spawn("script_model", (26430, 19523, 1709));
  _id_3B6553191404DFD5 setModel("hardware_plywood_bare_01_48_dirty");
  _id_3B6553191404DFD5.angles = (83.815, 83.453, 93.625);
  _id_417FB90DF0DFC485 = getEnt("mantle128", "targetname");
  _id_1EFB61BF12020C1A = spawn("script_model", (26208, 19647, 1673));
  _id_1EFB61BF12020C1A.angles = (0, 259.7, 0);
  _id_1EFB61BF12020C1A clonebrushmodeltoscriptmodel(_id_417FB90DF0DFC485, 1);
  _id_417FB80DF0DFC252 = getEnt("mantle128", "targetname");
  _id_E08F13A2C3DDD1AF = spawn("script_model", (26265, 19637, 1673));
  _id_E08F13A2C3DDD1AF.angles = (0, 259.7, 0);
  _id_E08F13A2C3DDD1AF clonebrushmodeltoscriptmodel(_id_417FB80DF0DFC252, 1);
  _id_417FB70DF0DFC01F = getEnt("mantle64", "targetname");
  _id_0584A190476249FC = spawn("script_model", (26247, 19702, 1673));
  _id_0584A190476249FC.angles = (0, 169.7, 0);
  _id_0584A190476249FC clonebrushmodeltoscriptmodel(_id_417FB70DF0DFC01F, 1);
  _id_417FB60DF0DFBDEC = getEnt("mantle64", "targetname");
  _id_B4DFF370FE217591 = spawn("script_model", (26225, 19582, 1673));
  _id_B4DFF370FE217591.angles = (0, 169.7, 0);
  _id_B4DFF370FE217591 clonebrushmodeltoscriptmodel(_id_417FB60DF0DFBDEC, 1);
  _id_80107217A5B285E6 = spawn("script_model", (27650, 20112, 1809));
  _id_80107217A5B285E6 setModel("hardware_plywood_bare_01_48_dirty");
  _id_80107217A5B285E6.angles = (270, 0, -10);
  _id_E0EBB40555CEEE6B = spawn("script_model", (27537, 20142, 1809));
  _id_E0EBB40555CEEE6B setModel("hardware_plywood_bare_01_48_dirty");
  _id_E0EBB40555CEEE6B.angles = (90, 0, 10.2);
}

adjustactivespawnlogic() {
  wait 1;
  scripts\mp\spawnlogic::setactivespawnlogic("Shipment", "Crit_Default");
}

_id_274CD16D0AF35466() {
  level.modifiedspawnpoints["20987.301 19335.900"]["mp_tdm_spawn"]["remove"] = 1;
  level.modifiedspawnpoints["20987.301 19335.900"]["mp_tdm_spawn"]["removeradius"] = 128;
}

_id_E430C168F5F4143E() {
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("little_bird", (24388, 14352, 1752), (21727, 15171, 1792), (0, 83, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("atv", (23096, 16108, 1652), (23068, 17120, 1682), (0, 60, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_cougar", (24467, 16357, 1632), (24137, 15680, 1783), (0, 55, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("light_tank", (23346, 15957, 1624), (23375, 15858, 1747), (0, 106, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_apc_8x8", (24313, 16712, 1673), (26581, 16076, 1720), (0, 81, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_apc_8x8", (23610, 16812, 1669), (22098, 17281, 1720), (0, 85, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_utv", (24159, 15575, 1640), (25071, 16851, 1742), (0, 22, 0));
  _id_27C2DB69A21775A0::_id_8F3B4AC00DA24665("veh9_cougar", (23272, 17268, 1618));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_palfa", (26178, 39255, 1894), (26088, 39299, 1900), (0, 235, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_cougar", (26387, 37768, 1632), (27155, 38608, 1739), (0, 240, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("light_tank", (28548, 37253, 1624), (28487, 38106, 1740), (0, 277, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_apc_8x8", (26822, 38120, 1673), (26857, 39644, 1715), (0, 324, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("veh9_apc_8x8", (28641, 37855, 1673), (28791, 39599, 1822), (0, 200, 0));
  _id_27C2DB69A21775A0::_id_4925AD96CEF8DEF1("little_bird", (30277, 37863, 1865), (27786, 37747, 1950), (0, 224, 0));
  _id_27C2DB69A21775A0::_id_8F3B4AC00DA24665("little_bird", (20184, 25320, 2082));
  _id_27C2DB69A21775A0::_id_8F3B4AC00DA24665("light_tank", (26832, 37755, 1624));
  _id_27C2DB69A21775A0::_id_8F3B4AC00DA24665("atv", (28758, 37582, 1660));
  _id_27C2DB69A21775A0::_id_87328480BCCC7550([undefined, ["light_tank", (28249.1, 22837.8, 1683.42), (0, 80, 0), "axis"], undefined, ["light_tank", (29519.4, 33469.8, 1638), (0, 350, 0), "allies"], undefined]);
}