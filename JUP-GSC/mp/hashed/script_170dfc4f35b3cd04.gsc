/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_170dfc4f35b3cd04.gsc
*************************************************/

#using script_2d20a34a5e04704d;
#using script_40d9a279bd1a1bf9;
#using script_57d78f3552757ec4;
#using script_5a3c73c4ef07ecec;
#using script_6e768becf8a66251;
#using script_b32b21ec1783af5;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace namespace_bca03e8d41cf9507;

function autoexec init() {
  level callback::add("ob_season_main", &main);
}

function main(params) {
  mapname = getmapname();

  switch (mapname) {
    case #"hash_2a217909d161fab9":
    case #"hash_2a217c09d161ff72":
    case #"hash_2a218509d1620d9d":
    case #"hash_9ae3f9a4f2372775":
      if(getdvarint(@ "hash_a84324a30ea28359", 0)) {
        namespace_c9c464b650c167ca::main();
        namespace_a29897b2574526c5::function_b30e7d622f569725();
      }

      if(getdvarint(@ "hash_2525b3dcd5ac602c", 1)) {
        thread function_866ec2626b84937a(mapname);
      }

      break;
  }

  level callback::remove("ob_season_main", &main);
}

function private function_866ec2626b84937a(mapname) {
  level endon("game_ended");
  namespace_2f386c52939edecf::main();
  namespace_8e9601710a5605ab::main();
  namespace_2518e41dd44c2ea7::main();
  level flag_wait("ob_infil_completed");
  waitframe();

  switch (mapname) {
    case #"hash_9ae3f9a4f2372775":
      level.var_46f34dd309687113["water"] = getentitylessscriptablearray("ob_glyph_puzzle_water", "script_noteworthy")[0];
      level.var_46f34dd309687113["land"] = getentitylessscriptablearray("ob_glyph_puzzle_land", "script_noteworthy")[0];
      level.var_46f34dd309687113["air"] = getentitylessscriptablearray("ob_glyph_puzzle_air", "script_noteworthy")[0];
      function_139b4b175d67e8ed("water");
      function_139b4b175d67e8ed("land");
      function_139b4b175d67e8ed("air");
      break;
    case #"hash_2a218509d1620d9d":
      level.var_46f34dd309687113["water"] = getentitylessscriptablearray("ob_glyph_puzzle_water", "script_noteworthy")[0];
      function_139b4b175d67e8ed("water");
      break;
    case #"hash_2a217909d161fab9":
      level.var_46f34dd309687113["air"] = getentitylessscriptablearray("ob_glyph_puzzle_air", "script_noteworthy")[0];
      function_139b4b175d67e8ed("air");
      break;
    case #"hash_2a217c09d161ff72":
      level.var_46f34dd309687113["land"] = getentitylessscriptablearray("ob_glyph_puzzle_land", "script_noteworthy")[0];
      function_139b4b175d67e8ed("land");
      break;
  }

  foreach(visual_scr in level.var_46f34dd309687113) {
    visual_scr setscriptablepartstate("glyph_part", "idle");
  }
}

function function_7eb73407060d7cb6(state) {
  obelisk = self;
  var_56b2e73c107aae45 = level.var_46f34dd309687113[obelisk.element];

  switch (state) {
    case 0:
      var_56b2e73c107aae45 setscriptablepartstate("glyph_part", "idle");
      break;
    case 1:
      var_56b2e73c107aae45 setscriptablepartstate("glyph_part", "on_purple");
      break;
    case 2:
      if(!obelisk.var_e00ac5b70d752deb) {
        var_56b2e73c107aae45 setscriptablepartstate("glyph_part", "on_red");
      } else {
        var_56b2e73c107aae45 setscriptablepartstate("glyph_part", "on_yellow");
      }

      break;
    case 3:
      if(!obelisk.var_e00ac5b70d752deb) {
        var_56b2e73c107aae45 setscriptablepartstate("glyph_part", "on_red");
      }

      break;
  }
}

function private function_139b4b175d67e8ed(element) {
  root = "spatial_" + element;
  var_96ae350eff4a278d = root + "_obelisk";
  rewardname = root + "_reward";
  var_ad4e22cbc6905735 = root + "_runes";
  var_49c63717e2a4434e = root + "_negotiator";
  var_1869de20987d284d = root + "_orb";
  var_544c18319a0541e1 = root + "_alignment";
  obelisk = getStruct(var_96ae350eff4a278d, "targetname");
  reward = getStruct(rewardname, "targetname");
  runes = getStructArray(var_ad4e22cbc6905735, "script_noteworthy");
  orb = getStruct(var_1869de20987d284d, "targetname");
  reward = getStruct(rewardname, "targetname");
  negotiator = getStruct(var_49c63717e2a4434e, "targetname");
  alignment = getStruct(var_544c18319a0541e1, "targetname");
  namespace_1ebb55028b525060::function_d99864f8b4032562(element, obelisk, runes, orb, negotiator, reward, &function_7eb73407060d7cb6, orb, alignment);
}