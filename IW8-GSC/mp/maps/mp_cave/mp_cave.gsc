/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_cave\mp_cave.gsc
***********************************************/

main() {
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  _encstr_97362D6ED8932DE04737CB6B38E5B62CE0CDE5D607FAD8B09D2B5EB538EBD82C6759FA1CE4566C58C61A568B3B9B1B::main();
  _encstr_8D2A2C7378B633E37C1FBE9741AF11273BC6D62DDFF8E7BF50AF8F64EF15176F2709F977F55FEF71C3FDD09F1BCF::main();
  _encstr_815227635FC37B9B6CAF8065FF36C790A08EE508DB599A21D4D14FAFD3680EC3138836DE70522C5307::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("_encstr_978E11CA98E7F1AB31AE755749FB97061370E2");
  level thread scripts\engine\scriptable_door::system_init();
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (376, -1568, -112), 0, 128, 300);
  var_0.targetname = "_encstr_8A720C48B3AB7729A26778B853CB";
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_8C5E14B1DEDA38586EDCD7D6B083FAB6C1AF6C859D95", "_encstr_8B511E36DE4636C2B94756E4AF6CED5BE02CB9B97D5B581CEB6B1C7D1BB0CEB2");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 500);
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_A5530B74088B11C93DE60105DE", 1024);
  setDvar("_encstr_84B70B9C7AA6A2262D934DA29E", 45);
  setDvar("_encstr_87F50B71398D854C077F1F1906", 2);
  setDvar("_encstr_95060BA9A2A045A57214A87A2D", 5);
  setDvar("_encstr_A7F10BDB5966F39BFA13DB52CD", 2);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_837707192BE62BE4E8";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_837707192BE62BE4E8";
  thread scripts\mp\motiondetectors::init();
  level thread managegate();
  thread destructibletrucksetup("_encstr_959C14E3BBD62B1AC8314B14095855612EE37747B95F", "_encstr_A6FA12E3FA0BA2773C3F71155870C4F23D902F0E", "_encstr_86781A65B5AE057EBBA0430C7EBA6173824D314FDACB20F7321F5A2B", "_encstr_8D301E8C2BB9D127EA6C3AB4318D2B514E5D8DB606267D5691B356E6F591B91D", 51);
  thread destructibletrucksetup("_encstr_BA9C1491B2DCE84E57D8A3A5898D95A2C957C65B6064", "_encstr_8AFA12C572D769DF1C421023EA6C8F408B1B6F9E", "_encstr_87211AFF550FAB825BE0D3AF13904D71A5F586B467F551DD41D86FDF", "_encstr_A66B1E483AB2993BAFE3BD3BFA1301115A83F8A8079A9791C30FCD2EEF5B8BE9", 52);
  thread matchfxexploder();
  thread _id_11F11();
  thread _id_12F8E();
  thread player_fired_gun_monitor();
}

player_fired_gun_monitor() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1592, 561, 176));
  var_0 setModel("_encstr_B49422906A478648B55BC9FD65DE585B5F322EBB621748308122CDC39C07E8080F996B0B");
  var_0.angles = (85.3, 326, -11);
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1034, 844, 92));
  var_1 setModel("_encstr_B49422906A478648B55BC9FD65DE585B5F322EBB621748308122CDC39C07E8080F996B0B");
  var_1.angles = (0, 275, -90);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3715, 1658.5, 262));
  var_2 setModel("_encstr_B49422906A478648B55BC9FD65DE585B5F322EBB621748308122CDC39C07E8080F996B0B");
  var_2.angles = (272, 145, -90);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1061, 917.5, 112));
  var_3 setModel("_encstr_A3C722DA7166F3BB60951DDF69F0C077B7289211B9B7D377B93941D7C51A0163BB630BFB");
  var_3.angles = (270, 0, 0);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (842, 332, 60));
  var_4 setModel("_encstr_B49422906A478648B55BC9FD65DE585B5F322EBB621748308122CDC39C07E8080F996B0B");
  var_4.angles = (270, 0, 0);
  var_5 = getEnt("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1768, 2128, 80));
  var_6.angles = (0, 255, 0);
  var_6 clonebrushmodeltoscriptmodel(var_5);
}

matchfxexploder() {
  level waittill("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
  scripts\engine\utility::exploder(77);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

managegate() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  level.scr_animtree["_encstr_A3460A8C2193E9F7550268C0"] = #animtree;
  level.scr_anim["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_88950636C6DE9B59"] = % _encstr_8DC9195BF0A9D84EF7FAA87242830DC9FF79E1338401D89927B3C1;
  level.scr_animname["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_88950636C6DE9B59"] = "_encstr_8DC9195BF0A9D84EF7FAA87242830DC9FF79E133A401D89927B3C1";
  level.scr_anim["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_ADB405071B8AE8"] = % _encstr_BD0A18933891E006BFA2E00A0ADB35013781390BDC49F04FF7AA;
  level.scr_animname["_encstr_A3460A8C2193E9F7550268C0"]["_encstr_ADB405071B8AE8"] = "_encstr_BD0A18933891E006BFA2E00A0ADB35013781390BFC49F04FF7AA";
  level.scr_animtree["_encstr_AAA60B178003F5617D2B7FB48D"] = #animtree;
  level.scr_anim["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_88950636C6DE9B59"] = % _encstr_8AEE19D683BE47C90BB4DCBC2C9C23BEB385472B4E7DC6637B6EAC;
  level.scr_animname["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_88950636C6DE9B59"] = "_encstr_8AEE19D683BE47C90BB4DCBC2C9C23BEB385472B4A7DC6637B6EAC";
  level.scr_anim["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_ADB405071B8AE8"] = % _encstr_81F518D749E1FC635E9418C1DB6DA2B9A7B26350503F07E3D9B8;
  level.scr_animname["_encstr_AAA60B178003F5617D2B7FB48D"]["_encstr_ADB405071B8AE8"] = "_encstr_81F518D749E1FC635E9418C1DB6DA2B9A7B26350513F07E3D9B8";
  var_0 = getEnt("_encstr_AA3B1041F518748398B1B2BA1BF0DB2FB079", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_ADC31109BD503CDBC0F98A72C3386BF48019AC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_9AE61160934E08F9E90FB8B062012FD0B167C0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.animname = "_encstr_A3460A8C2193E9F7550268C0";
  var_0 scripts\common\anim::setanimtree();
  var_1.animname = "_encstr_AAA60B178003F5617D2B7FB48D";
  var_1 scripts\common\anim::setanimtree();
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "_encstr_ADB405071B8AE8");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "_encstr_ADB405071B8AE8");
  var_2 hide();
  level waittill("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "_encstr_88950636C6DE9B59");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "_encstr_88950636C6DE9B59");
  var_3[0] = "_encstr_84850667C1A57264";
  var_3[1] = "_encstr_B61007BECA31606B23";
  var_4 = randomint(2);

  if(var_4 > 1)
    var_4 = 1;

  var_0 playSound("_encstr_AB2615ED4796B32BAD18327BA98766E389B86B9450BB57" + var_3[var_4]);

  if(var_3[var_4] == "_encstr_84850667C1A57264")
    var_1 playSound("_encstr_B1931B5BC17D275DB9B9CA9CD77685D159AF36B1DBCD95AF27A5CE1AE8");
  else
    var_1 playSound("_encstr_93401ABAE8D7FAB79060353A90D9AF03DBF9C222A827F7E708DD3E34");

  wait 1.0;
  var_2 show();
}

destructibletrucksetup(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;
  var_5 = getscriptablearray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = getEnt(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = getEnt(var_3, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = getEntArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 hide();
  scripts\engine\utility::exploder(var_4);

  if(isDefined(var_5) && isDefined(var_5[0])) {
    var_9 = var_5[0];
    var_10 = 1;

    while(var_10) {
      var_9 waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_11, var_12);

      switch (var_11) {
        case "_encstr_99220EEC59A15AD81B95EB91CA853AD0":
        case "_encstr_866307EDCD995AC9AC":
        case "_encstr_86390885FB5A76782D42":
          trucklightsoff(var_8);
          var_10 = 0;
          scripts\engine\utility::kill_exploder(var_4);
          var_7 show();
          var_6 hide();
          return;
        case "_encstr_AF790FF05D41D931214052FCA0E06102C6":
          trucklightsoff(var_8);
          var_10 = 0;
          scripts\engine\utility::kill_exploder(var_4);
          var_7 show();
          var_6 hide();
          return;
      }
    }
  }
}

trucklightsoff(var_0) {
  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

_id_11F11() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_86010A2F605164F1D5B5CC47");
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-106, 364, 216));
  var_0 makeusable();
  var_0 thread players_in_laststand();
}

players_in_laststand() {
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
  var_0 playerhide();
  var_0 vehiclepinonminimap(0);
  var_0 allowmovement(0);
  var_0 allowfire(0);
  var_0 disableoffhandprimaryweapons(0);
  var_0 disableoffhandsecondaryweapons(0);
  var_0 disableweapons(0);
  var_0 disableweaponswitch(0);
  var_0 setcamerathirdperson(1);
  var_0 allowcrouch(0);
  var_0 allowmelee(0);
  var_0 allowjump(0);
  var_0 allowprone(0);
  var_0 scripts\common\utility::allow_killstreaks(0);
  var_0 scripts\common\utility::allow_supers(0);
  var_0._id_12E54 = 1;
  var_0 scripts\mp\hud_message::showerrormessage("_encstr_BD88143514BE29E4A30AA62AEBD39C98AC97D40A1951");
}

_id_12F8E() {
  var_0 = [];
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (-548, 2268, 100), (0, 330, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (655, 2395, 149), (0, 315, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (576, 1152, 176), (0, 315, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (177, 1394, 108), (0, 15, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1847, 1074, 112), (0, 225, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1555, -52, 92), (0, 135, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1292, 1024, 129), (0, 270, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (1554, -223, 97), (0, 195, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (84, -484, 93), (0, 90, 0));
  var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", (16, -932, 33), (0, 15, 0));

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}