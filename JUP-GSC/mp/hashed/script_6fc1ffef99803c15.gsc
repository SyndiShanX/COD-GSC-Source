/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6fc1ffef99803c15.gsc
*************************************************/

#using script_38a8681fd881232e;
#using script_468934889d71b78;
#using script_5247c3a9848fc6f4;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#namespace mp_shoothouse2;

function main() {
  namespace_8c05f97002876eb4::main();
  namespace_d3522a399fd463ac::main();
  namespace_dacdd6f9fa23cd1a::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_shoothouse2");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  if(getdvarint(@ "hash_5f60d5026cd2c8b0") == 1) {
    function_6e3dcc779590b309();
  }
}

function function_6e3dcc779590b309() {
  var_1d9cf0af3b759b90 = [];
  var_f16e4f894777c13f = -122;
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-1529, 616, 172.025);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 0, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-670.5, 716, 220);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 90, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-1500, 1131.5, 176.26);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 90, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-1468, 2330.5, 155.438);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 90, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-649.5, 3053.5, 160.506);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 90, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-363, 2308, 313.007);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 180, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-803, 2096, 170.585);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 90, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-966, 1462, 257.75);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 0, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-403.5, 1386.5, 226.07);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 180, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-581.5, 658, 171.616);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 0, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-763.5, 3014, 209.598);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 90, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-1033, 2292, 266);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 90, 0);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size] = spawnStruct();
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].script_noteworthy = "jackolantern";
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].origin = (-710, 2001, 170.936);
  var_1d9cf0af3b759b90[var_1d9cf0af3b759b90.size - 1].angles = (0, 90, 0);

  foreach(struct in var_1d9cf0af3b759b90) {
    struct.origin = (struct.origin[0], struct.origin[1], struct.origin[2] + var_f16e4f894777c13f);
    addstruct(struct);
  }

  level.var_1d9cf0af3b759b90 = var_1d9cf0af3b759b90;
}

function function_476e26432f5d3edd() {
  var_8b1c18e78b52638 = getStructArray("jackolantern", "script_noteworthy");
  var_140e4695f31a730d = 1024;

  foreach(var_ac64400b9ee8389b in var_8b1c18e78b52638) {
    if(distance2dsquared(var_ac64400b9ee8389b.origin, (-252.5, 189, 55.2987)) <= var_140e4695f31a730d) {
      deletestruct_ref(var_ac64400b9ee8389b);
    }
  }
}