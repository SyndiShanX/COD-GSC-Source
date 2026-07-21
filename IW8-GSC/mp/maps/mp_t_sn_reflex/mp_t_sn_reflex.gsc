/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_t_sn_reflex\mp_t_sn_reflex.gsc
*****************************************************/

main() {
  _startragdollwithvehiclefeature::keypad_check_levelinput();
  level._id_13D50 = 1;
  _encstr_91623B0BD64BDC3B4C6F7E650202E95F4A27B847B016436E18C3812A9D45599D08AFC811A09B87B3A2B1E0AAE8230B38B74B0B02C8A15603185A7FBE3F::main();
  _encstr_A7863ACDD8C99607479B79B638E55B2C07375EB6E0AFA3BEDC9BBE39AC33D8561E973B95B95ED638EB1DFA6E73F5392BCCD8951E7DB0C93AC59DCDD8::main();
  _encstr_A6E03537D8E4B4C147B9F2B5E05EAD851CDCBCB507BE1DBECDB97D93B2CC1B951E975B83AFE8BE6ECDEB395699D8CAC37DCC1E5C3B6E6C::main();
  _encstr_872F3B0B52ABEBD84B23179B48E548A7CBCB0870CBC79D69A206EFDD459F887D5366D85BC1C340503DDFBDFB6EC598BB27EAD0211ABB837017B6AFCF93::main();
  scripts\mp\load::main();
  setDvar("_encstr_A7341BF848750358B597CF3FC543279965B24AEF507891A0884BC32748", 1);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1987, 830.5, 55));
  var_0 setModel("_encstr_8FC824B6BDEA47F5C6C247BB2C63DABE6E573807DE27D1FA314E2CD8B2AFA589590BB6EB93C6");
  var_0.angles = (270, 0, 0);
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1987, 830.5, 151));
  var_1 setModel("_encstr_8FC824B6BDEA47F5C6C247BB2C63DABE6E573807DE27D1FA314E2CD8B2AFA589590BB6EB93C6");
  var_1.angles = (270, 0, 0);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1970.5, 1401.5, -17.5));
  var_2 setModel("_encstr_883C10B8FA66B3E983614E4310B63BF98827");
  var_2.angles = (270, 0, 0);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1776, 822, 73));
  var_3.angles = (0, 0, 90);
  var_4 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 clonebrushmodeltoscriptmodel(var_4);
  thread clearsplashqueue();
}

clearsplashqueue() {
  for(;;) {
    level waittill("_encstr_A94C0B770B9DB27D2B37C85691", var_0);

    if(var_0 == 2)
      open_big_doors();
  }
}

open_big_doors() {
  if(istrue(level.big_doors_are_open)) {
    return;
  }
  level.big_doors_are_open = 1;
  level.big_door_l = getentitylessscriptablearrayinradius("_encstr_9B100BC45ACE7D19BDB727AFB1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.big_door_r = getentitylessscriptablearrayinradius("_encstr_8B100B4C5A3BFA327BF627EBC9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.big_door_l[0] setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_87C207DAF6D92BBE63");
  level.big_door_r[0] setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_83C207AD7BB32BEB4E");
  scripts\engine\utility::exploder("_encstr_8A900A9CA7C8F0994A2875C8");
}