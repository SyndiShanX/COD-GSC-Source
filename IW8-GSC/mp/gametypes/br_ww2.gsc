/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_ww2.gsc
***********************************************/

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

_id_145EE() {
  level.defend_wave_4 = getdvarint("_encstr_BAEA154E9B3316C59AF9386832B6E1E95B0FD94EF56BDB", 0);
  level.defenderflag_bflagstart = getdvarint("_encstr_A7011F03FE7D57A323A9AAB080836A0D2D1126EACA45F6BF09BE0F8A44293BE87B", 0);
  level.defenderflag = getdvarint("_encstr_A5CE123B8E2AA16E4317BBA507AAA188F6A5E1B0", 0);
  level.delete_smoke_fx = getdvarint("_encstr_87BC23F347105103B67EBBB260857F95C937956ADBB827E7D5B0D35989684F8E298F05FE59", 3);
  level.delete_subway_car = getdvarint("_encstr_BDC1256EB19CBE2693F5392C7323EDB590DEAD4C0BC923DA95DCE87DD2E6D1954EEC0B63A92DCD", 45);
  level.delete_structs_on_self_death = getdvarint("_encstr_99C125224EE5F16A43E9D3A758B92F9ADDD02D1E274DFABD4988C35708900CC255F4B6158993F3", 60);
  level.delete_starting_boxes = getdvarint("_encstr_A34021DEBE43DF112A2FD8488354C8C3282559EE969B6138E5D3F0C1AF692077F3CB40", 1);
  level.delete_trapfunc = getdvarint("_encstr_BE1023DFB71B90503A991B71FD147B31B01F6B0557C3C56045ADC38EA2EC18F8A9AFF383A3", 4);
  level.delete_track = getdvarint("_encstr_BABB23E68D9CFA4C27FA9C853723DEDA847BAD4C58C932B5CA73A3F56E3AAB37A40BB9B3AC", 500);
  level._id_13B46 = getdvarfloat("_encstr_B1062C4A267D69D4A838273F6026B5F2015092461D93031B96087B0B9098751BF7D71A7D7D354A6F5B18272FD853", 500);

  if(level.defend_wave_4) {
    level.scr_animtree["_encstr_87440B6AA23FD88937DF636A43"] = #animtree;
    level.scr_anim["_encstr_87440B6AA23FD88937DF636A43"]["_encstr_B4B70E28CA6585E9830F6F6909CBD16F"] = % _encstr_856921BBF009010F8268B5CB1F4E13555B603273B9F5C5C7996FBA810C96EF5DF7A0AA;
    level.scr_animname["_encstr_87440B6AA23FD88937DF636A43"]["_encstr_B4B70E28CA6585E9830F6F6909CBD16F"] = "_encstr_856921BBF009010F8268B5CB1F4E13555B603273B9F5C5C7996FBA810C96EF5DF7A0AA";
  }

  level thread _id_12800();
}

_id_12800() {
  if(level.defend_wave_4) {
    level thread _encstr_AC5329EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6FE3500FA333A39A19809D93FDA0278B::dropcircle();

    if(level.defenderflag)
      level thread _encstr_AC5329EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6FE3500FA333A39A19809D93FDA0278B::drones_spawning();
  }

  if(level.defenderflag_bflagstart)
    level thread update_ai_array();

  if(level.defenderflag_bflagstart && level.defend_wave_4) {
    level thread scripts\mp\utility\sound::besttime("_encstr_AC2F1331E47DBBBB64F589B7AD89B039C85B59CD8E");
    level thread _id_145EF();
  }
}

update_ai_array() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_123A7 = 1;

  while(!isDefined(level.infilstruct)) {
    return;
  }
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
  level thread _encstr_AC5329EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6FE3500FA333A39A19809D93FDA0278B::dropbrselfrevivetoken(3, 2363, 45, 60);
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
  waitframe();
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
  waitframe();
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
  level._id_123A7 = 0;
}

_id_145EF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 500));
  var_0 setModel("_encstr_A123081957C36850B6C8");
  waitframe();
  var_0 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_AFF710C25BED5F06B857838CC3A84F5F371B");
  level.weapon_xp_iw8_la_rpapa7 = var_0;
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 500));
  var_0 setModel("_encstr_A123081957C36850B6C8");
  waitframe();
  var_0 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A29B05E9400E5D");
  level.weapon_xp_iw8_lm_kilo121 = var_0;
}