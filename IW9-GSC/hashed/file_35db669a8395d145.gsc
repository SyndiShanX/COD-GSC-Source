/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_35db669a8395d145.gsc
***********************************************/

main() {
  _id_3108637A5197CB40::main();
  _id_5B8E9AA1AA9EB4BE::main();
  _id_456C69A565B02D44::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_penthouse");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread play_movie("mp_penthouse_tv_static_guide_on");
  thread _id_B2F8F087CEB71FEA();
}

play_movie(bink) {
  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  for(;;) {
    _func_CE942237D1ECA7D8(bink);
    wait 3;
  }
}

_id_B2F8F087CEB71FEA() {
  if(scripts\mp\utility\game::getgametype() == "arena" && _id_3686609F08F20087::ispickuploadouts()) {
    level._id_2D0D358424732272 = [];
    level._id_2D0D358424732272[0] = spawnStruct();
    level._id_2D0D358424732272[0].script_label = "1";
    level._id_2D0D358424732272[0].origin = (-96, 864, 66);
    level._id_2D0D358424732272[0].angles = (0, 180, -90);
    level._id_2D0D358424732272[1] = spawnStruct();
    level._id_2D0D358424732272[1].script_label = "1";
    level._id_2D0D358424732272[1].origin = (220, 864, 66);
    level._id_2D0D358424732272[1].angles = (0, 180, -90);
    level._id_2D0D358424732272[2] = spawnStruct();
    level._id_2D0D358424732272[2].script_label = "1";
    level._id_2D0D358424732272[2].origin = (224, -768, 66);
    level._id_2D0D358424732272[2].angles = (0, 0, -90);
    level._id_2D0D358424732272[3] = spawnStruct();
    level._id_2D0D358424732272[3].script_label = "1";
    level._id_2D0D358424732272[3].origin = (-92, -768, 66);
    level._id_2D0D358424732272[3].angles = (0, 0, -90);
    level._id_2D0D358424732272[4] = spawnStruct();
    level._id_2D0D358424732272[4].script_label = "2";
    level._id_2D0D358424732272[4].origin = (282, -560, 67);
    level._id_2D0D358424732272[4].angles = (0, 270, -90);
    level._id_2D0D358424732272[5] = spawnStruct();
    level._id_2D0D358424732272[5].script_label = "2";
    level._id_2D0D358424732272[5].origin = (-224, 608, 66);
    level._id_2D0D358424732272[5].angles = (0, 90, -90);
    level._id_2D0D358424732272[6] = spawnStruct();
    level._id_2D0D358424732272[6].script_label = "2";
    level._id_2D0D358424732272[6].origin = (-400, 56, 66);
    level._id_2D0D358424732272[6].angles = (0, 90, -90);
    level._id_2D0D358424732272[7] = spawnStruct();
    level._id_2D0D358424732272[7].script_label = "2";
    level._id_2D0D358424732272[7].origin = (608, 32, 66);
    level._id_2D0D358424732272[7].angles = (0, 270, -90);
    level._id_2D0D358424732272[8] = spawnStruct();
    level._id_2D0D358424732272[8].script_label = "3";
    level._id_2D0D358424732272[8].origin = (512, 480, 66);
    level._id_2D0D358424732272[8].angles = (0, 270, -90);
    level._id_2D0D358424732272[9] = spawnStruct();
    level._id_2D0D358424732272[9].script_label = "3";
    level._id_2D0D358424732272[9].origin = (512, -480, 66);
    level._id_2D0D358424732272[9].angles = (0, 270, -90);
    level._id_2D0D358424732272[10] = spawnStruct();
    level._id_2D0D358424732272[10].script_label = "3";
    level._id_2D0D358424732272[10].origin = (-173, 48, 91);
    level._id_2D0D358424732272[10].angles = (0, 270, -90);
    level._id_2D0D358424732272[11] = spawnStruct();
    level._id_2D0D358424732272[11].script_label = "4";
    level._id_2D0D358424732272[11].origin = (-520, -608, 66);
    level._id_2D0D358424732272[11].angles = (0, 180, -90);
    level._id_2D0D358424732272[12] = spawnStruct();
    level._id_2D0D358424732272[12].script_label = "4";
    level._id_2D0D358424732272[12].origin = (-504, 704, 66);
    level._id_2D0D358424732272[12].angles = (0, 0, -90);
    level._id_2D0D358424732272[13] = spawnStruct();
    level._id_2D0D358424732272[13].script_label = "4";
    level._id_2D0D358424732272[13].origin = (260, 548, 64);
    level._id_2D0D358424732272[13].angles = (0, 180, -90);
    level._id_2D0D358424732272[14] = spawnStruct();
    level._id_2D0D358424732272[14].script_label = "4";
    level._id_2D0D358424732272[14].origin = (-104, -512, 64);
    level._id_2D0D358424732272[14].angles = (0, 0, -90);
    level._id_2D0D358424732272[15] = spawnStruct();
    level._id_2D0D358424732272[15].script_label = "5";
    level._id_2D0D358424732272[15].origin = (-568, 1016, 70);
    level._id_2D0D358424732272[15].angles = (0, 180, -90);
    level._id_2D0D358424732272[16] = spawnStruct();
    level._id_2D0D358424732272[16].script_label = "5";
    level._id_2D0D358424732272[16].origin = (-500, -960, 65);
    level._id_2D0D358424732272[16].angles = (0, 0, -90);
    level._id_2D0D358424732272[17] = spawnStruct();
    level._id_2D0D358424732272[17].script_label = "5";
    level._id_2D0D358424732272[17].origin = (308, 0, 66);
    level._id_2D0D358424732272[17].angles = (0, 0, -90);
    level._id_2D0D358424732272[18] = spawnStruct();
    level._id_2D0D358424732272[18].script_label = "6";
    level._id_2D0D358424732272[18].origin = (-156, -128, 66);
    level._id_2D0D358424732272[18].angles = (0, 90, -90);
    level._id_2D0D358424732272[19] = spawnStruct();
    level._id_2D0D358424732272[19].script_label = "6";
    level._id_2D0D358424732272[19].origin = (-192, 256, 66);
    level._id_2D0D358424732272[19].angles = (0, 270, -90);
    level._id_2D0D358424732272[20] = spawnStruct();
    level._id_2D0D358424732272[20].script_label = "6";
    level._id_2D0D358424732272[20].origin = (432, -720, 66);
    level._id_2D0D358424732272[20].angles = (0, 90, -90);
    level._id_2D0D358424732272[21] = spawnStruct();
    level._id_2D0D358424732272[21].script_label = "6";
    level._id_2D0D358424732272[21].origin = (432, 784, 66);
    level._id_2D0D358424732272[21].angles = (0, 90, -90);
    level._id_2D0D358424732272[22] = spawnStruct();
    level._id_2D0D358424732272[22].script_label = "7";
    level._id_2D0D358424732272[22].origin = (736, -128, 66);
    level._id_2D0D358424732272[22].angles = (0, 90, -90);
    level._id_2D0D358424732272[23] = spawnStruct();
    level._id_2D0D358424732272[23].script_label = "7";
    level._id_2D0D358424732272[23].origin = (736, 192, 66);
    level._id_2D0D358424732272[23].angles = (0, 90, -90);
    level._id_2D0D358424732272[24] = spawnStruct();
    level._id_2D0D358424732272[24].script_label = "7";
    level._id_2D0D358424732272[24].origin = (-384, 896, 70);
    level._id_2D0D358424732272[24].angles = (0, 90, -90);
    level._id_2D0D358424732272[25] = spawnStruct();
    level._id_2D0D358424732272[25].script_label = "7";
    level._id_2D0D358424732272[25].origin = (-384, -848, 68.5);
    level._id_2D0D358424732272[25].angles = (0, 90, -90);
    level._id_2D0D358424732272[26] = spawnStruct();
    level._id_2D0D358424732272[26].script_label = "8";
    level._id_2D0D358424732272[26].origin = (180, 0, 66);
    level._id_2D0D358424732272[26].angles = (0, 90, -90);
    level._id_2D0D358424732272[27] = spawnStruct();
    level._id_2D0D358424732272[27].script_label = "8";
    level._id_2D0D358424732272[27].origin = (68, 600, 66);
    level._id_2D0D358424732272[27].angles = (0, 90, -90);
    level._id_2D0D358424732272[28] = spawnStruct();
    level._id_2D0D358424732272[28].script_label = "8";
    level._id_2D0D358424732272[28].origin = (68, -492, 66);
    level._id_2D0D358424732272[28].angles = (0, 90, -90);
  }
}