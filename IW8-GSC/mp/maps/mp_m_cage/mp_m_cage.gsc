/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_cage\mp_m_cage.gsc
***********************************************/

main() {
  _encstr_8BE031BF076B607395EEDF70785EC5CB82123FEB8FBEC111E9D750C17FFA20F7FA21566F21279997D37FA1D1A240BD2027920F::main();
  _encstr_BA6330EB26DB379261188EA2E83F0DCF33960F7DC7066F117790F23A2AF747BBE571D8D7D1AEAFA617987972A8F96D27E3EE::main();
  _encstr_8E0D2B9EFE03F3136CDF72683BDF481BCB6238299289B3BE23AF28D05EA5A32FA28186A72F820F4110FA206847::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_91C016E802AD19D1CF7BA0A141EBDE9B52A96B81BAC67F69", "_encstr_B176204FB849ABDA37ED877A403FF27D1320F787A1C0E1931709CA39B19F0A3999B8");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread lighting_setup_dvars();
  thread scripts\mp\animation_suite::animationsuite();
  thread _id_11D80();
  thread _id_121F4();
}

lighting_setup_dvars() {
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1500);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 4);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_AB840B539C2A6905C9C43D2815", 1);
  setDvar("_encstr_BEF80B3DEB91A709E3A5D7AF1D", 1);
  thread _id_14051();
}

_id_14051() {
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.25);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 2);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 0);
  setDvar("_encstr_B6B020078D09C06067CB8B1183672DB0520DB5FF206E23B82780E038DB175E4BB577", 1);
  setDvar("_encstr_838A290EED417740C56308B847F3D9A169130886041A3108A7A3E8E8A33D73F3E23F611798418391910730", 4);
}

_id_11E8D() {
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.25);
  setDvar("_encstr_994D0BE8B1B5B26797B05B5AD6", 2);
  setDvar("_encstr_B4F00B9C51C42D9CC43982265A", 2);
  setDvar("_encstr_9A400AEB2390F1FD098F0AC5", 1);
}

_id_11D80() {
  if(level.gametype == "_encstr_A9B606B0C956B916") {
    wait 1;
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_B4BA1AAD1CBEB0C9CAB9B0FAB9380BBB73D716C3D26EFA378E854E47");

    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (64, -528, 16)) < 10) {
        var_2.origin = (90, -528, 16);
        continue;
      }

      if(distance(var_2.origin, (-64, -528, 16)) < 10)
        var_2.origin = (-90, -528, 16);
    }

    var_4 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8D041C5B1C7D0BC9593785D7E6070BEE9BF585C663D22BDCFADCE82C39D1");

    foreach(var_2 in var_4) {
      if(distance(var_2.origin, (64, 528, 16)) < 10) {
        var_2.origin = (90, 528, 16);
        continue;
      }

      if(distance(var_2.origin, (-64, 528, 16)) < 10)
        var_2.origin = (-90, 528, 16);
    }
  }
}

_id_121F4() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3, 36, 12));
  var_0 setModel("_encstr_972D16B607AFB5FAC6C23BB2D76E43EDD131B1EDD85B5927");
  var_0.angles = (0, 0, 0);
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (63, -36, 12));
  var_1 setModel("_encstr_972D16B607AFB5FAC6C23BB2D76E43EDD131B1EDD85B5927");
  var_1.angles = (0, 0, 0);
}