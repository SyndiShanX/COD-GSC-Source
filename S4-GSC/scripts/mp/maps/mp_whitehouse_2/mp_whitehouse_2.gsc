/***************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_whitehouse_2\mp_whitehouse_2.gsc
***************************************************************/

main() {
  scripts\mp\maps\mp_whitehouse_2\mp_whitehouse_2_precache::main();
  scripts\mp\maps\mp_whitehouse_2\gen\mp_whitehouse_2_art::main();
  scripts\mp\maps\mp_whitehouse_2\mp_whitehouse_2_fx::main();
  scripts\mp\maps\mp_whitehouse_2\mp_whitehouse_2_lighting::main();
  _id_07EC::main();
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  _id_07C0::_id_D88B("compass_map_mp_whitehouse_2");
  thread refresh_shadow_cache();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (-581.128, 1685.52, 160.125), (0, 0, 0), 0, (0, 1.06808, 0));
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("5", (-277.084, 1190, 294.164), (0, 0, 0), 1);
  level fixpostlaunchspawns();
}

fixpostlaunchspawns() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "ctf":
      break;
    case "control":
      break;
    case "sd":
      break;
    case "dm":
    case "gun":
      break;
    case "dom":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (4, 847, 178), (0, 90, 0));
      break;
    case "war":
    case "conf":
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (4, 847, 178), (0, 90, 0));
      break;
    case "patrol":
    case "koth":
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}

refresh_shadow_cache() {
  wait 0.2;
  setDvar("#x33a57ea4edb37c077", 0);
  wait 0.05;
  setDvar("#x3d16c9a360648a055", 3);
  wait 0.05;
  setDvar("#x343854ca9eae76167", 1);
  wait 0.05;
  setDvar("#x38c9b7b77ce9b9a", 1.33);
  wait 0.05;
  setDvar("#x32ee39981452e9751", 8);
}