/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_ar_alps\mp_ar_alps.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_ar_alps\mp_ar_alps_precache::main();
  scripts\mp\maps\mp_ar_alps\gen\mp_ar_alps_art::main();
  scripts\mp\maps\mp_ar_alps\mp_ar_alps_fx::main();
  scripts\mp\maps\mp_ar_alps\mp_ar_alps_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_ar_alps");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 1;
  level._id_8EE1 = 1;
  var_0 = scripts\mp\utility\game::getgametype();

  if(var_0 == "arm" || var_0 == "base") {
    _func_0403(400, 1200);

    if(!isDefined(level._id_96CC)) {
      setDvar("#x32a031d1e6464bda2", 17);
    }
  }

  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  level._id_8D0B = getEntArray("kill_border_trigger", "targetname");
  thread fixcollision();
  thread addpostlaunchmesh();
  thread fixbasecaptureexclusion();
}

fixcollision() {
  var_0 = getent("clip256x256x8", "targetname");
  var_1 = spawn("script_model", (-6270, -5497, 1622));
  var_1.angles = (0, 270, 34.0486);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip256x256x8", "targetname");
  var_3 = spawn("script_model", (-6351, -5255, 1624));
  var_3.angles = (0, 0, 34.0486);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("clip128x128x128", "targetname");
  var_5 = spawn("script_model", (-746.317, -7125.42, 2989.23));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip64x64x64", "targetname");
  var_7 = spawn("script_model", (-906.837, -7119.53, 3034.36));
  var_7.angles = (0, 334.3, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip64x64x64", "targetname");
  var_9 = spawn("script_model", (-832.708, -7123.42, 3034.36));
  var_9.angles = (0, 334.3, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip32x32x32", "targetname");
  var_11 = spawn("script_model", (-864.988, -7115.03, 3084.21));
  var_11.angles = (0, 345.3, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("clip32x32x32", "targetname");
  var_13 = spawn("script_model", (-833.888, -7122.83, 3084.21));
  var_13.angles = (0, 345.3, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = _func_0098("spawn_room_collision", "targetname", (473, -6646, 3054.6), 25, 1)[0];
  var_15 = spawn("script_model", (4232, -1667, 2730));
  var_15.angles = (90, 117.998, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = _func_0098("spawn_room_collision", "targetname", (473, -6646, 3054.6), 25, 1)[0];
  var_17 = spawn("script_model", (4273, -1745, 2730));
  var_17.angles = (90, 117.998, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = _func_0098("spawn_room_collision", "targetname", (473, -6646, 3054.6), 25, 1)[0];
  var_19 = spawn("script_model", (4320, -1826, 2730));
  var_19.angles = (90, 117.998, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
}

addpostlaunchmesh() {
  var_0 = spawn("script_model", (-783.153, -7124.91, 3098.3));
  var_0 setModel("s4_ger_crate_supply_01");
  var_0.angles = (0, 355.2, 0);
  var_1 = spawn("script_model", (-780.174, -7152.33, 3098.3));
  var_1 setModel("s4_ger_crate_supply_01");
  var_1.angles = (0, 184.999, 0);
  var_2 = spawn("script_model", (-853.631, -7120.28, 3098.3));
  var_2 setModel("s4_ger_crate_supply_01");
  var_2.angles = (0, 165.7, 0);
  var_3 = spawn("script_model", (-819.895, -7149.94, 3059));
  var_3 setModel("s4_barrel_wood_large_01");
  var_3.angles = (0, 0, 0);
  var_4 = spawn("script_model", (-833.246, -7123.46, 3059));
  var_4 setModel("s4_barrel_wood_large_01");
  var_4.angles = (0, 0, 0);
  var_5 = spawn("script_model", (-861.753, -7123.48, 3059));
  var_5 setModel("s4_barrel_wood_large_01");
  var_5.angles = (0, 0, 0);
  var_6 = spawn("script_model", (-889.893, -7109.78, 3059));
  var_6 setModel("s4_barrel_wood_large_01");
  var_6.angles = (0, 0, 0);
  var_7 = spawn("script_model", (-911.733, -7096.44, 3059));
  var_7 setModel("s4_barrel_wood_large_01");
  var_7.angles = (0, 0, 0);
  var_8 = spawn("script_model", (-811.885, -7147.87, 3097.2));
  var_8 setModel("s4_rus_sandbag_04");
  var_8.angles = (0, 286, 0);
  var_9 = spawn("script_model", (-826.885, -7146.92, 3094.42));
  var_9 setModel("s4_rus_sandbag_05");
  var_9.angles = (0, 257.699, 0);
}

fixbasecaptureexclusion() {}

getpatchablevolbytargetnameandnoteworthy(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(isDefined(var_5._id_039B) && var_5._id_039B == var_1) {
      var_3 = var_5;
      break;
    }
  }

  return var_3;
}