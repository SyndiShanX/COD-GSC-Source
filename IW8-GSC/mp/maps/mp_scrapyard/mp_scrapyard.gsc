/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_scrapyard\mp_scrapyard.gsc
*************************************************/

main() {
  _encstr_8392376BDF8844E31D43C6EA4BD8EF3EF067BFCD51390A67C6392BD3714E0365A009575B8FF8D6736BD1030A9EA703AF3893E3D82B629FB71E::main();
  _encstr_95A936DCD8C9D20EA3375EB50E79ADB0839BBCB61CF5371BC985C1CBB09391E59DAC9B5E6B387D9B6C9C1638F2B09C32EB164E1DC5B36E1B::main();
  _encstr_A5AB319BC19617AA1827E7BD399AB57F3F7BD6E24BF8A7A6936BB0A133983FFEE973698BB1C6A75AA053CA84B7334032048B22::main();
  _encstr_9351371ECB638051AB8BBAA0D31533D9C3638899302F0BBF12B23818FA9AE9D8EF08380EBB3331A1389A20F8F1358B691394BB08171A39EFE6::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::_id_12B18();
  setDvar("_encstr_A7341BF848750358B597CF3FC543279965B24AEF507891A0884BC32748", 1);
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_B1D519B1F6D6C1B06E37FADA8507D7DA0ED7E6D8392C0E97B04E91", "_encstr_A2C223660809F2A9A3704F2B11996FDAF997EA9AF8B36AE04ED0139798714A429133F652DD");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level thread player_exfil_struct();
  thread scripts\mp\animation_suite::animationsuite();
  level.chopper_gunner_assignedtargetmarkers_onnewai = getnodesinradius((-26944, -10944, -19), 100, 0, 100);
}

player_exfil_struct() {
  var_0 = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-25082, -12290, 220));
  var_1.angles = (270, 192, -177);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26720, -10806, 180));
  var_3.angles = (0, 15, 90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
}