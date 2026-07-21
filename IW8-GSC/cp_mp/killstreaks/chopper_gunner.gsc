/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\chopper_gunner.gsc
************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_88C5055208731B")]]();

  level._effect["_encstr_8BF619E928D08370FD58B73FC3F0586BC8D835239BAAB28F94CFFB"] = loadfx("_encstr_964F2F3BCCC397B477C1BE5BC1CBB64BD81BDC47272B58DAE5CE99C37D161C588D0D56FA590F381BB7CDD2DBDC71D93387");
  level._effect["_encstr_A6DD1F2A10A8E33A2BD56727A320C5FF4E6EF283987563F760EB6F3B89E84D3B7D"] = loadfx("_encstr_A15335A3F7080AC30B62374B5B561AF0A4CD8B7B9A7D208AA6B34D69CFDADF084324F19607B2A8B5CAC3A153B7C325D8173E79C0AB0E58");
  level.choppergunners = [];
  level.heli_pilot_mesh = scripts\cp_mp\utility\game_utility::getlocaleent("_encstr_8A8E10B1F7A2D391702CF06893C7C81D8B6B");

  if(isDefined(level.heli_pilot_mesh))
    level.heli_pilot_mesh hide();

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6521DCE9855F3301D509FB7FD88529DC3A197510352DA0F5EBFDEF75B6F37"] = "_encstr_9BC316EBB3684362B3E09912F08DDDAF63B0756E5CF157EF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B62D1DFFCB3DDB309D3AA797B72020EF08C036530D09B67FF758B192C8783D"] = "_encstr_B62D1DFFCB3DDB309D3AA797B72020EF08C036530D09B67FF758B192C8783D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A1E21C273C1FDBDBAA48E7A8B87025370EB949DBA8014B5861A75520B4C3"] = "_encstr_A1E21C273C1FDBDBAA48E7A8B87025370EB949DBA8014B5861A75520B4C3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A68A16C61AB70EE0ACE4EBD9ABB9CDB239F5CC8D0B9356CD"] = "_encstr_A68A16C61AB70EE0ACE4EBD9ABB9CDB239F5CC8D0B9356CD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88E11CB73370FB4BC822304803C0DD5B7307B811C49BA1BF88B94578A015"] = "_encstr_BE5A1B663815B2231FFD51C74B50F8F2D277FBC0E0E0037848BA98D103";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAD41AC6D0DB0E38B29CBED95DDC9B9539D7B656917D91C25B58EC56"] = "_encstr_88E81A81420863EB372669B8A74A726FB51143E521D0439091AA8F03";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81D51C6C0D7B380756C9FAD9AB37CD95397D432B589DCBAF4658AD16D995"] = "_encstr_BEE81ABF70D8483B8B7E998FE5B592E5C3610B2FC0508482A7199D83";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DF61F2250CF12CBA9C6A7975D106B9F5D512A1A18B18EFFE0245F9B7B780765AB"] = "_encstr_8DF61F2250CF12CBA9C6A7975D106B9F5D512A1A18B18EFFE0245F9B7B780765AB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3FC1EBB10B8A35041E218C2B32DCD5F6380A07FB243F3A8A854F7DDC3F925AF"] = "_encstr_A3FC1EBB10B8A35041E218C2B32DCD5F6380A07FB243F3A8A854F7DDC3F925AF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC9B202B6B10B0B7E1E23947F38ED81FA3B13C821351D8DD2D7987D5277093392ABB"] = "_encstr_AC9B202B6B10B0B7E1E23947F38ED81FA3B13C821351D8DD2D7987D5277093392ABB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BF1183FF058C8BB0BFE190F6535126543E19B87503015C24798"] = "_encstr_9BF1183FF058C8BB0BFE190F6535126543E19B87503015C24798";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B65F181BD0B73838ACE4D7EC5D9BCD2BE47D4E2B161DE80BD85B"] = "_encstr_B65F181BD0B73838ACE4D7EC5D9BCD2BE47D4E2B161DE80BD85B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAB2154FC99092E019C67970AB8873A5125E7EB8AFEA21"] = "_encstr_BAB2154FC99092E019C67970AB8873A5125E7EB8AFEA21";
  choppergunner_pilotanims();
  choppergunner_vehicleanims();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_95831CCD95E8EBEC9534D2C6C6CA7DD04B477DC8C2B52C3B957D8C858E16"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_95831CCD95E8EBEC9534D2C6C6CA7DD04B477DC8C2B52C3B957D8C858E16")]]("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", 12);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579", 1, "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", 30, "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", 1, "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", 11, "_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002", 1, "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", 80, "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", 1, "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", 18, "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_8266217315DC2FBDD0E250BB6B77CB94E1BD52EFF2FD097B611655683F5B531F2F4B79")]]("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", 1, "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_920321BFCF1B7448683419F0DFD8D09DF0470B236F523520340EA56802EFF85F0B9795")]]("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", 23, "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");

  level.incomingallchoppergunners = 0;
  level.incomingchoppergunners["_encstr_9A8507BA4040188D08"] = 0;
  level.incomingchoppergunners["_encstr_8E8405EA382B2A"] = 0;
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_AB0703DBB9", 6);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

choppergunner_pilotanims() {
  level.scr_animtree["_encstr_B427182736C93EF13507210D1D0787D3CBFE304B2F733363C24C"] = #animtree;
  level.scr_anim["_encstr_B427182736C93EF13507210D1D0787D3CBFE304B2F733363C24C"]["_encstr_82230C13E0D36FD34F43E2C3DA5A"] = % _encstr_87341C0AD37023FDE0039D72B71804970DE99207F3283F35603D9F5741B2;
  level.scr_animname["_encstr_B427182736C93EF13507210D1D0787D3CBFE304B2F733363C24C"]["_encstr_82230C13E0D36FD34F43E2C3DA5A"] = "_encstr_87341C0AD37023FDE0039D72B71804970DE99207F3283F35603D9F5741B2";
  level.scr_anim["_encstr_B427182736C93EF13507210D1D0787D3CBFE304B2F733363C24C"]["_encstr_BD870CC15AD8ED47AF1B390B6E1A"] = % _encstr_A59E1CD6387D071BC2CBB29CFA581AEDA32BC6C60DAFB1272C9B0DFAC026;
  level.scr_animname["_encstr_B427182736C93EF13507210D1D0787D3CBFE304B2F733363C24C"]["_encstr_BD870CC15AD8ED47AF1B390B6E1A"] = "_encstr_A59E1CD6387D071BC2CBB29CFA581AEDA32BC6C60DAFB1272C9B0DFAC026";
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

choppergunner_vehicleanims() {
  level.scr_animtree["_encstr_BE0E21EFF7C98E4327525BF1FA2F403D721B7B25AF83454849EEC0C9A9FBB879BAC3EB"] = #animtree;
  level.scr_anim["_encstr_BE0E21EFF7C98E4327525BF1FA2F403D721B7B25AF83454849EEC0C9A9FBB879BAC3EB"]["_encstr_82E00E6315846846EB5F9F9795DB184F"] = % _encstr_9A0F1520D7B91380E58B6F99FB4D9F0878E08A4041923A;
  level.scr_anim["_encstr_BE0E21EFF7C98E4327525BF1FA2F403D721B7B25AF83454849EEC0C9A9FBB879BAC3EB"]["_encstr_96BD0E0B92630BA0ADD51767EAD61843"] = % _encstr_863615938BB9FF103743C9E0FBB47126833727019FF79F;
}

weapongivenchoppergunner(var_0) {
  return 1;
}

tryusechoppergunner() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", self);
  return tryusechoppergunnerfromstruct(var_0);
}

tryusechoppergunnerfromstruct(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](self, "_encstr_ADC61D43329509426AB3D1F7CB039D30238109785DE8280DF377EBC58B1A5E");

  var_1 = getcompleteweaponname("_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, ::weapongivenchoppergunner);

  if(!istrue(var_2)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  var_3 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]() || level.fauxvehiclecount + var_3 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");

      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  level.incomingallchoppergunners++;
  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    var_4 = 2;

  if(level.choppergunners.size >= var_4 || level.choppergunners.size + level.incomingallchoppergunners > var_4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

    level.incomingallchoppergunners--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var_5 = 1;
    level.incomingchoppergunners[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.choppergunners) + level.incomingchoppergunners[self.team] > var_5) {
      level.incomingallchoppergunners--;
      level.incomingchoppergunners[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A3152858E3CCD0F11D5BE59DD9593624BF41FFADA66CC7139DA1391F3669780959C02249E7E1A841BDF1");

      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(level.gameended) {
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  var_6 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B")]]();

  var_7 = startchoppergunnerintro(self, var_0, var_6);
  level.incomingallchoppergunners--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
    level.incomingchoppergunners[self.team]--;

  if(!isDefined(var_7)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]]("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_972B14BA37B291FAC6D07B381CAC93EB9DBAB9CD5993", self);

  var_7 thread choppergunner_startremotecontrol(var_6);
  return 1;
}

startchoppergunnerintro(var_0, var_1, var_2) {
  var_0 disablephysicaldepthoffieldscripting();
  var_3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_4 = (0, 0, 0);

  if(isDefined(var_3))
    var_4 = (0, 0, var_3.origin[2] - 1000);
  else
    var_4 = (0, 0, 1500);

  var_6 = 9000;

  if(level.mapname == "_encstr_AC880C67503EA82A05DD62214CE7")
    var_6 = 7000;

  var_7 = var_0.origin - anglesToForward(var_0.angles) * var_6 + var_4;
  var_8 = var_0.origin + anglesToForward(var_0.angles) * 2000 + var_4;
  var_9 = var_0.angles;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_10 = randomint(level.heli_structs_entrances.size);
    var_11 = level.heli_structs_entrances[var_10];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_AA991133969B23A20BC97656E86AA3E4ABD847")) {
      var_12 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_AA991133969B23A20BC97656E86AA3E4ABD847")]](var_11.script_linkto, level.heli_structs_goals);

      if(isDefined(var_12)) {
        var_4 = (0, 0, var_12.origin[2] + 200);
        var_13 = var_11.origin * (1, 1, 0) + var_4;
        var_14 = var_12.origin * (1, 1, 0) + var_4;
        var_15 = vectorNormalize(var_14 - var_13);
        var_16 = 9000;

        if(level.mapname == "_encstr_A2200CDA13D6CBC897E1A0EBAA93")
          var_16 = 8000;

        var_7 = var_14 - var_15 * var_16;
        var_8 = var_14 + var_15 * 1000;
        var_9 = vectortoangles(var_15);
      } else {}
    }
  } else if(istrue(var_0.stopcirclesatgameend) && level.script == "_encstr_A2B70D6C0EFACDDBF50BB94BBCC243") {
    if(level.players.size > 1)
      var_17 = scripts\engine\utility::array_remove(level.players, var_0);
    else
      var_17 = level.players;

    var_18 = scripts\engine\utility::random(var_17);
    var_19 = (var_18.origin[0], var_18.origin[1], 1750);

    while(level._id_11F7E.size == 0)
      waitframe();

    var_20 = scripts\engine\utility::getclosest(var_19, level._id_11F7E);
    var_21 = (var_20.origin[0], var_20.origin[1], 1750);
    var_22 = vectorNormalize(var_19 - var_21);
    var_7 = var_21 - var_22 * 11000;
    var_8 = var_21 - var_22 * 1000;
    var_9 = vectortoangles(var_22);
  } else
    var_0 iprintlnbold("_encstr_B660336BB38B6B8938C7C6EAA9EA2B43704BA2A13440FB98865AB84B2B3FABFE9848F11075A1C68A70CF60339EAB78A1794E3D50CE");

  var_23 = "_encstr_AB7D1C5E9528C2C9C358CAF1F0237AA7E18BDFD43DF0B25BFF7023098829";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0))
    var_23 = "_encstr_8DCA216DE564BAD8C7FAE8B642EF06C97E70D7118DCD72B5E73203BE6AA7BE4819DD71";

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(istrue(var_0.stopcirclesatgameend) && level.script == "_encstr_A2B70D6C0EFACDDBF50BB94BBCC243")
    var_24 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_7, var_9, "_encstr_8FC6183B95D0F516E0C23643ACFAD8E0EB37B7F5C2E6A5CBB00D", var_23);
  else
    var_24 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_7, var_9, "_encstr_920D0E230D1131A9C3D85743C01E6D0B", var_23);

  if(!isDefined(var_24)) {
    return;
  }
  var_25 = 45;
  var_24.speed = 100;
  var_24.accel = 50;
  var_24.lifetime = var_25;
  var_24.team = var_0.team;
  var_24.owner = var_0;
  var_24.angles = var_9;
  var_24.streakinfo = var_1;
  var_24.streakname = var_1.streakname;
  var_24.flaresreservecount = 1;
  var_24.currentdamagestate = 0;
  var_24.pathstart = var_7;
  var_24.pathgoal = var_8;
  var_24.missilesleft = 8;
  var_24.animname = "_encstr_BE0E21EFF7C98E4327525BF1FA2F403D721B7B25AF83454849EEC0C9A9FBB879BAC3EB";
  var_24.stopcirclesatgameend = istrue(var_0.stopcirclesatgameend);
  var_24 setvehicleteam(var_24.team);
  var_24 thread goal_shotgun("_encstr_8D820B49520F0EC02DDE6367EC", var_1);
  var_24 thread goal_shotgun("_encstr_81170C244F9CBDE72C01BB99A298", var_1);
  var_24 thread goal_shotgun("_encstr_923011E397F3A22518DEF23AB1087CEAD53F1B", var_1);
  var_27 = 2000;

  if(istrue(level.istacops))
    var_27 = 1000;

  var_24.health = var_27;
  var_24.maxhealth = var_27;
  var_24 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B"))
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B")]](var_1.streakname, "_encstr_B4E519D17222DCCA58DA1BAD89D0A935DA1BD9ABF9CF873AE04563", undefined, "_encstr_AF60172348D1FFB5D891DFEB41E0BA730D83299A53389B6FD8", "_encstr_A99521D7711568B0D7BB1E61B217F5506DD1534127BE1088EB1351AB392F2D08C525C5");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD"))
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD")]](var_1.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8"))
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8")]](var_1.streakname, ::choppergunner_modifydamage);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF"))
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF")]](var_1.streakname, ::choppergunner_handledeathdamage);

  level.choppergunners[level.choppergunners.size] = var_24;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_1.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, 0, 1, 100);

  var_24 setmaxpitchroll(15, 15);
  var_24 vehicle_setspeed(var_24.speed, var_24.accel);
  var_24 sethoverparams(50, 5, 2.5);
  var_24 setturningability(1);
  var_24 setyawspeed(500, 100, 25, 0.5);
  var_24 setotherent(var_0);
  var_24 setCanDamage(1);
  var_24 setneargoalnotifydist(5000);
  var_24 scripts\cp_mp\emp_debuff::set_start_emp_callback(::choppergunner_empstarted);
  var_24 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::choppergunner_empcleared);
  var_24 setscriptablepartstate("_encstr_8D98102E456FC82FB9BD7107F969183AB9FB", "_encstr_AB0703DBB9", 0);
  var_24 setscriptablepartstate("_encstr_BD020FB1E05B47521BB89B41C8734F2BF3", "_encstr_AB0703DBB9", 0);
  var_24 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  var_28 = "_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0))
    var_28 = "_encstr_83D225ECBD7BDA5FBD7A90011254FDCEB728F865153353C1699340903B6FB98657C5685569E7C3";

  var_24.turret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_24 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"), "_encstr_A3DA1116382CC6D056BE8EAE27E42BA3AFB583");
  var_24.turret setModel(var_28);
  var_24.turret.owner = var_0;
  var_24.turret.team = var_0.team;
  var_24.turret.angles = var_24.angles;
  var_24.turret.streakinfo = var_1;
  var_24.turret linkTo(var_24, "_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_24.turret setturretteam(var_0.team);
  var_24.turret setturretmodechangewait(0);
  var_24.turret setmode("_encstr_849007B268BD03DFD8");
  var_24.turret setotherent(var_0);
  var_24.turret setdefaultdroppitch(45);
  var_24.mpod1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_24 gettagorigin("_encstr_91D60A58AF8759EF1D0B50B5"));
  var_24.mpod1 setModel("_encstr_BEFB14776F511728D16EB06919AC48D6DB9FF1978F4B");
  var_24.mpod1.angles = var_24.angles;
  var_24.mpod1.owner = var_24.owner;
  var_24.mpod1.team = var_24.team;
  var_24.mpod1 linkTo(var_24, "_encstr_91D60A58AF8759EF1D0B50B5");
  var_24.mpod1 setentityowner(var_0);
  var_24.mpod1 setotherent(var_0);
  var_24.mpod2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_24 gettagorigin("_encstr_8DD60AB403F81157751829C3"));
  var_24.mpod2 setModel("_encstr_BEFB14776F511728D16EB06919AC48D6DB9FF1978F4B");
  var_24.mpod2.angles = var_24.angles;
  var_24.mpod2.owner = var_24.owner;
  var_24.mpod2.team = var_24.team;
  var_24.mpod2 linkTo(var_24, "_encstr_8DD60AB403F81157751829C3");
  var_24.mpod2 setentityowner(var_0);
  var_24.mpod2 setotherent(var_0);
  var_24.turretfx = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_24.turret.origin);
  var_24.turretfx setModel("_encstr_BEFB14776F511728D16EB06919AC48D6DB9FF1978F4B");
  var_24.turretfx.angles = var_24.angles;
  var_24.turretfx linkTo(var_24.turret, "_encstr_8E010B996FB7B6B3C1D1183343");
  var_24.turretfx setotherent(var_0);
  var_24.pilot = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_24 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"));
  var_24.pilot setModel("_encstr_A9FE150189C5A0EDAFABE811C31F28B0DF14D79B3A6DB8");
  var_24.pilot.angles = var_24.angles;
  var_24.pilot linkTo(var_24, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_24.pilot.animname = "_encstr_B427182736C93EF13507210D1D0787D3CBFE304B2F733363C24C";
  var_24.pilot scripts\common\anim::setanimtree();
  level notify("_encstr_AA67171FA023D3325D0D1E15EE297A96E9E9AF93385B182A75", var_24);
  self notify("_encstr_862D14866BBF6318C1E0071F2058CEFA5D688B3A45C1");
  thread choppergunner_updateflyingspeed(var_24);

  if(!istrue(var_2)) {
    var_24 setvehgoalpos(var_24.pathgoal, 0);
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    self.restoreangles = self getplayerangles();
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_usability(0);
    scripts\common\utility::allow_shellshock(0);
    thread choppergunner_camerashake(var_24);
    self setclientomnvar("_encstr_A3F7189331A991D0D90E837ACF072AD3E7CD086F6FC80B676558", 1);
    self playerlinkweaponviewtodelta(var_24, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    var_24 playsoundtoplayer("_encstr_B6542308A33F308B9255FE05AA7AE378577F68D047D0092F3BFAFF37C29201E0DF2B8930FB", self);
  } else
    var_24 setvehgoalpos(var_24.pathgoal, 1);

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_1.streakname, 1);
  var_24 thread choppergunner_playdofintroeffects();
  var_24 thread scripts\common\anim::anim_single_solo(var_24, "_encstr_82E00E6315846846EB5F9F9795DB184F");
  var_24 thread scripts\common\anim::anim_single_solo(var_24.pilot, "_encstr_82230C13E0D36FD34F43E2C3DA5A", "_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_24 thread choppergunner_startfadetransition(3.75);
  var_29 = var_24 goal_ar(4.25);

  if(!istrue(var_29)) {
    return;
  }
  var_24 notify("_encstr_A91A1227B4E6288DCF9AA870934BCDE0B12DAFF3");
  return var_24;
}

goal_shotgun(var_0, var_1) {
  var_2 = self.owner;
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_950A13ACF0D2D1AF1B1AB783C1594EBED2E63A9CBD");
  self endon("_encstr_A91A1227B4E6288DCF9AA870934BCDE0B12DAFF3");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 waittill(var_0);

  if(var_0 == "_encstr_8D820B49520F0EC02DDE6367EC") {
    level.incomingallchoppergunners--;

    if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased)
      level.incomingchoppergunners[self.team]--;
  }

  if(isDefined(var_2)) {
    var_2 unlink();
    var_2 disablephysicaldepthoffieldscripting();
    var_2 scripts\common\utility::allow_fire(1);
    var_2 scripts\common\utility::allow_melee(1);
    var_2 scripts\common\utility::allow_weapon_switch(1);
    var_2 scripts\common\utility::allow_usability(1);
    var_2 scripts\common\utility::allow_shellshock(1);
    var_2 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_1.streakname, "_encstr_BA19049F4B2D");
    var_2 setclientomnvar("_encstr_A3F7189331A991D0D90E837ACF072AD3E7CD086F6FC80B676558", 0);
    var_2 painvisionon();
    var_2 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var_2 visionsetkillstreakforplayer("_encstr_B40101");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_2, 0);
  }

  thread choppergunner_explode();
  self notify("_encstr_950A13ACF0D2D1AF1B1AB783C1594EBED2E63A9CBD");
}

goal_ar(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_950A13ACF0D2D1AF1B1AB783C1594EBED2E63A9CBD");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  return 1;
}

choppergunner_playdofintroeffects() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_950A13ACF0D2D1AF1B1AB783C1594EBED2E63A9CBD");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner enablephysicaldepthoffieldscripting();
  self.owner setphysicaldepthoffield(4, 5000, 10, 10);
  wait 2;
  self.owner setphysicaldepthoffield(4, 20, 5, 10);
  wait 1.5;
  self.owner setphysicaldepthoffield(4, 1, 3, 10);
}

#using_animtree("_encstr_B40101");

choppergunner_playercameratransition(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = self getEye();
  var_6 = self.angles;

  if(isDefined(var_1))
    var_5 = var_1;

  if(isDefined(var_2))
    var_5 = var_2;

  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
  var_7 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_7.owner = self;
  var_7.angles = var_6;
  var_8 = undefined;
  var_9 = undefined;

  if(isDefined(var_0)) {
    var_8 = var_0.origin;
    var_9 = var_0.angles;
  }

  if(isDefined(var_3))
    var_8 = var_3;

  if(isDefined(var_4))
    var_9 = var_4;

  if(isDefined(var_0))
    choppergunner_startfadetransition();
  else
    thread choppergunner_startfadetransition();

  self playerlinkweaponviewtodelta(var_7, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
  self playerlinkedsetviewznear(0);
  self visionsetkillstreakforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.2);
  var_7 moveTo(var_8, 0.5);
  var_7 rotateTo(var_9, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self visionsetkillstreakforplayer("_encstr_B40101", 0.2);
  self unlink();
  self setplayerangles(var_9);

  if(isDefined(var_0)) {
    self playerlinkweaponviewtodelta(var_0, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
    var_0 vehicleplayanim(%_encstr_9A0F1520D7B91380E58B6F99FB4D9F0878E08A4041923A);
    var_0.pilot scriptmodelplayanim("_encstr_87341C0AD37023FDE0039D72B71804970DE99207F3283F35603D9F5741B2");
  }

  var_7 delete();
}

choppergunner_updateflyingspeed(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B4D10ADC950BE4EB76DE8536");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0.speed;
  var_2 = 0.25;

  for(;;) {
    var_1 = var_1 + var_2;
    var_0 vehicle_setspeed(var_1, var_0.accel);
    wait 0.05;
  }
}

choppergunner_camerashake(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self earthquakeforplayer(0.07, 0.1, var_0 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"), 700);
    wait 0.1;
  }
}

choppergunner_startremotecontrol(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

  var_1 = self.owner;
  var_1 disablephysicaldepthoffieldscripting();

  if(!istrue(var_0)) {
    var_1.usingchoppergunner = 1;
    var_1 scripts\common\utility::allow_fire(1);
    var_1 scripts\common\utility::allow_ads(1);
    var_1 unlink();
    var_1 remotecontrolvehicle(self);
    var_1 remotecontrolturret(self.turret);
    var_1 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_A37A196F13897ACB10E3FFC6F871F62253E7C7BFF3A523912168B2", "_encstr_AC190479FF92", self.lifetime, 0);
    choppergunner_updatetargetmarkergroups();
  }

  if(!isDefined(self.playersfx)) {
    self.playersfx = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
    self.playersfx linkTo(self);
  }

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, ::choppergunner_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, ::choppergunner_lockedonremovedcallback);
  self setCanDamage(1);
  thread choppergunner_handlethermalswitch(var_0);
  thread choppergunner_handlemissilefire(var_0);
  thread choppergunner_watchturretfire(var_0);
  thread choppergunner_watchgameendleave(var_0);
  thread goal_smg("_encstr_8D820B49520F0EC02DDE6367EC");
  thread goal_smg("_encstr_81170C244F9CBDE72C01BB99A298");
  thread goal_smg("_encstr_923011E397F3A22518DEF23AB1087CEAD53F1B");
  thread goal_smg("_encstr_835E111B0F57AAF772B2857B91972DCBC070DA");
  thread choppergunner_watchkills();
  thread choppergunner_handledestroyed(var_0);
  thread choppergunner_notifyonkillstreakover();

  if(!self.stopcirclesatgameend) {
    thread choppergunner_removetargetmarkergroupsonkillstreakover();
    thread choppergunner_watchearlyexit(var_0);
    thread choppergunner_watchlifetime(var_0);
    self.owner setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(self.lifetime * 1000));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4")]](::choppergunner_handlemissiledetection);

  if(!istrue(var_0)) {
    var_1 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "_encstr_AB0703DBB9");
    var_1 setclientomnvar("_encstr_A3F7189331A991D0D90E837ACF072AD3E7CD086F6FC80B676558", 0);
    var_1 setclientomnvar("_encstr_8F991313FBEF42287178CBE781E9FF7A418E1DCD5E", 1);
    var_1 setclientomnvar("_encstr_85AC1CF0D081B7D4BAAB277983AFCBFF5F6B9FDFE32F4DFFCB903E218045", self.missilesleft);
    var_1 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", self.health / self.maxhealth);
    self.playersfx playLoopSound("_encstr_91911D1BD14BFFDE0853FBC86349646FE168C3435B95BF9499BBFDCA7FB86A");
    var_1 setclienttriggeraudiozonepartialwithfade("_encstr_9B62128909E036534516B29A9829E72BD09B011B", 1.5, "_encstr_AB1904853B28", "_encstr_A9A80769FCC4081D93");
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(level.heli_pilot_mesh))
    level.heli_pilot_mesh show();
}

choppergunner_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_9BF1183FF058C8BB0BFE190F6535126543E19B87503015C24798");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

choppergunner_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

choppergunner_removetargetmarkergroupsonkillstreakover() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_B49E157ED43A29CBA573499077F6404B53B1E5702F72D9");
  choppergunner_updatetargetmarkergroups(1);
}

choppergunner_updatetargetmarkergroups(var_0) {
  if(self.stopcirclesatgameend) {
    return;
  }
  if(istrue(level.loadoutsecondaryaddblueprintattachments)) {
    return;
  }
  var_1 = isDefined(self.enemytargetmarkergroup);
  var_2 = !scripts\cp_mp\emp_debuff::is_empd() && !istrue(var_0);

  if(var_2 && !var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222")]]();
  } else if(!var_2 && var_1) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
    self.enemytargetmarkergroup = undefined;
    self.friendlytargetmarkergroup = undefined;
  }
}

choppergunner_notifyonkillstreakover() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A6("_encstr_BA2D081B2B58B32D37EC", "_encstr_AD75063D571AE108", "_encstr_860808CB78E2984063BA");
  self notify("_encstr_B49E157ED43A29CBA573499077F6404B53B1E5702F72D9");

  if(isDefined(self.owner))
    self.owner notify("_encstr_B49E157ED43A29CBA573499077F6404B53B1E5702F72D9");
}

choppergunner_watchendstrobefx(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_BA2D081B2B58B32D37EC");
  self delete();
}

choppergunner_startfadetransition(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_950A13ACF0D2D1AF1B1AB783C1594EBED2E63A9CBD");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  var_2 = 0.5;

  if(istrue(var_1))
    var_2 = 0;

  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 1, var_2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 0, var_2);
}

go_to_exit_spots(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = undefined;
  var_2 = self.origin;
  var_3 = 750;
  var_4 = 2000;
  var_5 = self.team;
  var_6 = self.lifetime;
  var_7 = self.owner;
  var_8 = 1;
  var_9 = self;
  var_10 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(isDefined(var_1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_A5921E820114982F5891A0D19BBD4369081BC8512F7E76FB1343031F58B17260")) {
    var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_A5921E820114982F5891A0D19BBD4369081BC8512F7E76FB1343031F58B17260")]](var_1);

    for(;;) {
      var_12 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 20000), self);

      if(var_12["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
        dlog_recordevent(var_11, var_12["_encstr_BD260953AA97E3F014279D"]);

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
    }
  }
}

choppergunner_handlethermalswitch(var_0) {
  if(!istrue(var_0)) {
    var_1 = self.owner;
    var_1 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
    choppergunner_handlethermalswitchinternal();

    if(isDefined(var_1))
      var_1 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
  }
}

choppergunner_handlethermalswitchinternal(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_2 = self.owner;
  var_0 = 0;
  var_1 = ["_encstr_AAF80E76A0D0D8A32D7DEF075F419A12", "_encstr_9966162345622836E29FAE98038AD0BEBDDF207C2BDBB320", "_encstr_BD821609DDA15860C7A70F3957BBB5E954F5D60145119822", "_encstr_A76C16331B9639AF19F51BBDC6F6C97D76C98546D256DC1D", "_encstr_96D416B7205303266E378FC849A508278F6B48C5874D702D"];
  self.currentvisionset = "_encstr_AAF80E76A0D0D8A32D7DEF075F419A12";
  var_2 visionsetkillstreakforplayer(self.currentvisionset);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_0 = 1;
    var_2 scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
    self.currentvisionset = var_1[var_0];
    var_2 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_9A4B1E2B8BB08BEAD9B8720A48B76367E878ABD911394B36E770EA82685F9D6B", "_encstr_AC190479FF92", self.lifetime, 0);
  }

  var_3 = 1;

  for(;;) {
    var_2 setclientomnvar("_encstr_B1C71B55998F982BE5C290B03B7FF350372C53C5FA2F8119013A783862", var_0);
    var_2 visionsetthermalforplayer(var_1[var_0]);
    var_2 waittill("_encstr_83DC143FAF8C707E6B3133B8FA6B2180652FBB8F2477");
    var_0++;

    if(var_0 == 1) {
      var_2 scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
      self.currentvisionset = var_1[var_0];
      var_2 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_9A4B1E2B8BB08BEAD9B8720A48B76367E878ABD911394B36E770EA82685F9D6B", "_encstr_AC190479FF92", self.lifetime, 0);
      continue;
    }

    if(var_0 > var_3) {
      var_0 = 0;
      var_2 scripts\cp_mp\utility\player_utility::setthermalvision(0);
      self.currentvisionset = "_encstr_AAF80E76A0D0D8A32D7DEF075F419A12";
      var_2 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_A37A196F13897ACB10E3FFC6F871F62253E7C7BFF3A523912168B2", "_encstr_AC190479FF92", self.lifetime, 0);
    }
  }
}

choppergunner_handlemissilefire(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.owner;
  var_1 notifyonplayercommand("_encstr_A2D20E628B1F32BC26B87F2F70D86C5A", "_encstr_9B0D065699E485D9");
  self.missilefireside = undefined;
  var_2 = 0;
  var_3 = 4;

  for(;;) {
    var_1 waittill("_encstr_A2D20E628B1F32BC26B87F2F70D86C5A", var_4);

    if(self.stopcirclesatgameend && self.missilesleft == 8)
      childthread go_to_node_callback();

    var_2++;
    self.streakinfo.shots_fired++;

    if(var_2 > var_3)
      var_2 = 1;

    self.owner earthquakeforplayer(0.25, 0.4, self.turret.origin, 150);
    self.owner playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
    var_5 = self.mpod1;

    if(!isDefined(self.missilefireside) || self.missilefireside == "_encstr_8253060E2B5FE330") {
      self.missilefireside = "_encstr_A5AD056A019C63";
      self.mpod1 thread choppergunner_firemissilefx(var_2);
      var_5 = self.mpod1;
    } else {
      self.missilefireside = "_encstr_8253060E2B5FE330";
      self.mpod2 thread choppergunner_firemissilefx(var_2);
      var_5 = self.mpod2;
    }

    var_6 = self.turret gettagorigin("_encstr_AFF30A1B0E6A69E0AA1B880B");
    var_7 = anglesToForward(self.turret gettagangles("_encstr_8E010B996FB7B6B3C1D1183343"));
    var_8 = var_5.origin * (1, 1, 0) + (0, 0, var_6[2]);
    var_9 = var_8 + var_7 * 100;
    var_10 = var_8 + var_7 * 1000;
    var_11 = self.owner getvieworigin();
    var_12 = anglesToForward(self.owner getplayerangles());
    var_13 = var_11 + var_12 * 50000;
    var_14 = [self, self.turret, var_5];
    var_15 = scripts\engine\trace::ray_trace(var_11, var_13, var_14, scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));
    var_16 = var_15["_encstr_BD260953AA97E3F014279D"];

    if(isDefined(var_4))
      var_16 = var_4;

    var_17 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_AC740FAA3BF169D025C6A373200C27E06B"), var_9, var_10, var_1);
    var_17 thread choppergunner_watchmissilestate(var_16);
    var_17 thread goal_default(self.owner, 2, 300, 300);
    var_17.streakinfo = self.streakinfo;
    self.missilesleft--;
    var_1 setclientomnvar("_encstr_85AC1CF0D081B7D4BAAB277983AFCBFF5F6B9FDFE32F4DFFCB903E218045", self.missilesleft);

    if(self.missilesleft == 0) {
      if(self.stopcirclesatgameend) {
        self waittill("_encstr_991E12DA5ACDDC5A1B956E7DE49533D2B1D85919");
        continue;
      }

      break;
    }
  }
}

go_to_node_callback() {
  self endon("_encstr_991E12DA5ACDDC5A1B956E7DE49533D2B1D85919");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(8.0);
  self.missilesleft = 8;
  self.owner setclientomnvar("_encstr_85AC1CF0D081B7D4BAAB277983AFCBFF5F6B9FDFE32F4DFFCB903E218045", self.missilesleft);
  self notify("_encstr_991E12DA5ACDDC5A1B956E7DE49533D2B1D85919");
}

choppergunner_watchturretfire(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self.turret waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_1);
    self.owner earthquakeforplayer(0.15, 0.1, self.turret.origin, 150);
    var_1.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    var_1 thread goal_default(self.owner, 0.5, 256, 200);
  }
}

choppergunner_firemissilefx(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setscriptablepartstate("_encstr_AD720E3C542BC3EE6D5F687047B4617F" + var_0, "_encstr_AB0703DBB9", 0);
  wait 1;
  self setscriptablepartstate("_encstr_AD720E3C542BC3EE6D5F687047B4617F" + var_0, "_encstr_BA19049F4B2D", 0);
}

choppergunner_watchmissilestate(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(isDefined(self))
    self missile_settargetpos(var_0);
}

choppergunner_watchlifetime(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.lifetime;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AF60172348D1FFB5D891DFEB41E0BA730D83299A53389B6FD8", 1);
  thread choppergunner_leave(var_0);
}

choppergunner_watchgameendleave(var_0) {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self._id_12AA4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
  thread choppergunner_leave(var_0);
}

goal_smg(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner waittill(var_0);
  thread choppergunner_returnplayer(0, 0);
  thread choppergunner_explode();
}

choppergunner_watchtargets() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B6521DCE9855F3301D509FB7FD88529DC3A197510352DA0F5EBFDEF75B6F37");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var_0 = [];

    foreach(var_2 in level.players) {
      if(self.owner worldpointinreticle_circle(var_2.origin, 80, 100)) {
        if(level.teambased && var_2.team == self.team) {
          continue;
        }
        if(var_2 == self.owner) {
          continue;
        }
        var_3 = [self, self.turret];

        if(!scripts\cp_mp\utility\killstreak_utility::streakcanseetarget(self.turret gettagorigin("_encstr_A14F0AE336178944BA076F41"), var_2 gettagorigin("_encstr_AADA07DBF19A4A81D7"), var_3)) {
          continue;
        }
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
          if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
            continue;
        }

        var_0 = choppergunner_getnearbytargets(var_2);
        break;
      }

      wait 0.05;
    }

    if(var_0.size > 0 && var_0.size < 2)
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B62D1DFFCB3DDB309D3AA797B72020EF08C036530D09B67FF758B192C8783D");
    else if(var_0.size >= 2)
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A1E21C273C1FDBDBAA48E7A8B87025370EB949DBA8014B5861A75520B4C3");

    wait(randomintrange(5, 15));
  }
}

choppergunner_getnearbytargets(var_0) {
  var_1 = scripts\common\utility::playersincylinder(var_0.origin, 300);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(level.teambased && var_4.team != var_0.team) {
      continue;
    }
    if(!level.teambased && var_4 == self.owner) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

choppergunner_watchkills() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self.owner waittill("_encstr_92FB1BA870FADEE4054823C2E74B9D214FEB3260C71EC5E1A19595F873", var_0, var_1);
    wait 1;

    if(isDefined(self.owner.recentkillcount)) {
      if(self.owner.recentkillcount >= 1 && var_1 == "_encstr_AC740FAA3BF169D025C6A373200C27E06B") {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AC9B202B6B10B0B7E1E23947F38ED81FA3B13C821351D8DD2D7987D5277093392ABB");
        continue;
      }

      if(self.owner.recentkillcount == 1) {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8DF61F2250CF12CBA9C6A7975D106B9F5D512A1A18B18EFFE0245F9B7B780765AB");
        continue;
      }

      if(self.owner.recentkillcount >= 2)
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A3FC1EBB10B8A35041E218C2B32DCD5F6380A07FB243F3A8A854F7DDC3F925AF");
    }
  }
}

choppergunner_leave(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self setmaxpitchroll(0, 0);
  self notify("_encstr_BA2D081B2B58B32D37EC");
  thread choppergunner_returnplayer(0, var_0);
  self vehicle_setspeed(50, 25);
  var_1 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_1 = var_1 + (0, 0, 1000);
  self setvehgoalpos(var_1, 1);
  self setneargoalnotifydist(100);
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  var_2 = choppergunner_getpathend();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(150, 50);
  self setvehgoalpos(var_2, 1);
  self waittill("_encstr_8B7205D9ED5958");
  self notify("_encstr_8772059DDEDCAC");
  thread choppergunner_delete(0);
}

choppergunner_getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

choppergunner_handledamage() {
  self setCanDamage(1);
}

choppergunner_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(isDefined(self.owner) && self.owner isusingchoppergunner()) {
    var_6 = "_encstr_8FA906CC80677438";

    if(isexplosivedamagemod(var_3)) {
      if(ceil(var_4 / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.turret.origin, 150);
        self.owner playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
        var_6 = "_encstr_B846067B175AA56A";
      } else {
        self.owner earthquakeforplayer(0.15, 0.15, self.turret.origin, 150);
        self.owner playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
      }
    }

    thread choppergunner_screeninterference(0.2, var_6);
  }

  self.currenthealth = self.health - var_4;

  if(self.currenthealth <= 1500 && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");

    if(isDefined(self.owner) && self.owner isusingchoppergunner())
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_88E11CB73370FB4BC822304803C0DD5B7307B811C49BA1BF88B94578A015");
  } else if(self.currenthealth <= 1000 && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");

    if(isDefined(self.owner) && self.owner isusingchoppergunner())
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AAD41AC6D0DB0E38B29CBED95DDC9B9539D7B656917D91C25B58EC56");
  } else if(self.currenthealth <= 500 && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");

    if(isDefined(self.owner) && self.owner isusingchoppergunner())
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_81D51C6C0D7B380756C9FAD9AB37CD95397D432B589DCBAF4658AD16D995");
  }

  self.owner setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", self.currenthealth / self.maxhealth);
  return 1;
}

choppergunner_handledeathdamage(var_0) {
  self.killedbyweapon = var_0.objweapon;
  return 1;
}

choppergunner_handledestroyed(var_0) {
  self endon("_encstr_8772059DDEDCAC");
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.owner) && self.owner isusingchoppergunner())
    thread choppergunner_returnplayer(1, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005")]](self.killedbyweapon))
      choppergunner_crash(150);
  }

  thread choppergunner_explode();
}

choppergunner_crash(var_0, var_1) {
  self endon("_encstr_860808CB78E2984063BA");
  self clearlookatent();
  self notify("_encstr_86BD0980BBC647A80FDE04");
  self playsoundonmovingent("_encstr_BAF916EC2B86F516C1B01B1A56BE95E183B1B78C59BED683");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_2 = choppergunner_findcrashposition(1250);

  if(!isDefined(var_2)) {
    return;
  }
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_BAB2154FC99092E019C67970AB8873A5125E7EB8AFEA21", 1);
  self setvehgoalpos(var_2, 0);
  thread choppergunner_spinout(var_0);
  thread scripts\common\anim::anim_single_solo(self, "_encstr_96BD0E0B92630BA0ADD51767EAD61843");
  scripts\common\anim::anim_single_solo(self.pilot, "_encstr_BD870CC15AD8ED47AF1B390B6E1A", "_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

choppergunner_spinout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.6);
    wait 0.5;
  }
}

choppergunner_findcrashposition(var_0) {
  var_1 = self.origin;
  var_2 = 1000;
  var_3 = undefined;
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoright(self.angles);
  var_6 = var_1 + var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 + var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_5 - var_4) - (0, 0, var_2);
  var_7 = scripts\engine\trace::ray_trace(var_1, var_6, self);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (-1 * var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  return var_3;
}

choppergunner_explode() {
  self notify("_encstr_860808CB78E2984063BA");

  if(isDefined(self.owner))
    self radiusdamage(self.origin, 1000, 200, 200, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A3DA1116382CC6D056BE8EAE27E42BA3AFB583");

  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_AB0703DBB9", 0);
  wait 0.35;
  thread choppergunner_delete(1);
}

choppergunner_delete(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_A23F21C22CB2A9031CAB7058E76099F55A57CDFF95CE7FA8FFBBE060FB5F533D22FFBE", self.owner);

  self.streakinfo.onspray = istrue(var_0);

  if(!istrue(self._id_12AA4))
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);

  self stoploopsound();

  if(isDefined(self.pilot))
    self.pilot delete();

  if(isDefined(self.turretfx))
    self.turretfx delete();

  if(isDefined(self.cockpitcamera))
    self.cockpitcamera delete();

  if(isDefined(self.firetarget))
    self.firetarget delete();

  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.mpod1)) {
    self.mpod1 setentityowner(undefined);
    self.mpod1 delete();
  }

  if(isDefined(self.mpod2)) {
    self.mpod2 setentityowner(undefined);
    self.mpod2 delete();
  }

  level.choppergunners = scripts\engine\utility::array_remove(level.choppergunners, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

choppergunner_returnplayer(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.turretfx setscriptablepartstate("_encstr_8F2E14B1C25B5927B0AF320BDAC2CEB2F53696B33447", "_encstr_BA19049F4B2D");
  self.turretfx setscriptablepartstate("_encstr_96B0156B4F82A135B68E31210FE0A74057859A2C11C32D", "_encstr_BA19049F4B2D");
  self.turretfx setscriptablepartstate("_encstr_B19C14D8C2DA5993C27D9158B50B7695AF43B2859D5E", "_encstr_BA19049F4B2D");

  if(isDefined(level.heli_pilot_mesh))
    level.heli_pilot_mesh hide();

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  choppergunner_lockedonremovedcallback();
  var_2 clearclienttriggeraudiozone(0.5);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  if(isDefined(var_2)) {
    if(!istrue(var_1)) {
      var_2 visionsetthermalforplayer("_encstr_B40101");
      var_2 scripts\cp_mp\utility\player_utility::setthermalvision(0);
      var_2 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "_encstr_BA19049F4B2D");
      var_2 setclientomnvar("_encstr_8F991313FBEF42287178CBE781E9FF7A418E1DCD5E", 0);
      var_2 remotecontrolvehicleoff();
      var_2 remotecontrolturretoff(self.turret);
      var_2 visionsetkillstreakforplayer("_encstr_B40101");
      var_2 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var_2 scripts\common\utility::allow_melee(1);
      var_2 scripts\common\utility::allow_weapon_switch(1);
      var_2 scripts\common\utility::allow_usability(1);
      var_2 scripts\common\utility::allow_ads(0);
      var_2 scripts\common\utility::allow_shellshock(1);

      if(istrue(var_0)) {
        var_2 setclientomnvar("_encstr_A3F7189331A991D0D90E837ACF072AD3E7CD086F6FC80B676558", 2);
        var_2 setplayerangles(self.angles);
        var_2 playerlinkweaponviewtodelta(self, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1);
        var_2 playerlinkedsetviewznear(0);
        var_2 playlocalsound("_encstr_915D1F7813C1CF309344960D32DF79B7B96A08909AA41B0E6B759705300F83715A");
        self waittill("_encstr_860808CB78E2984063BA");
        var_2 unlink();
      }

      level thread scripts\cp_mp\utility\killstreak_utility::_id_12CC6(var_2);
      var_2 setclientomnvar("_encstr_A3F7189331A991D0D90E837ACF072AD3E7CD086F6FC80B676558", 0);
      var_2 painvisionon();
      var_2 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
      var_2.usingchoppergunner = undefined;
    }
  }

  self.streakinfo notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
}

choppergunner_watchearlyexit(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B")]]("_encstr_BA2D081B2B58B32D37EC");

  self waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  thread choppergunner_leave(var_0);
}

choppergunner_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6")]](var_2);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB"))
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB")]](undefined, var_3);

      var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A68A16C61AB70EE0ACE4EBD9ABB9CDB239F5CC8D0B9356CD");
      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB"))
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0")]](var_0);

      self missile_settargetEnt(var_6);
      self notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      return;
    }

    waitframe();
  }
}

isusingchoppergunner() {
  return isDefined(self.usingchoppergunner);
}

choppergunner_screeninterference(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(isDefined(var_2)) {
    var_3 = choppergunner_getvisionsetformat(self.currentvisionset);
    var_4 = choppergunner_getvisionsetbystrength(var_3, var_1);

    if(var_3 == "_encstr_A17905D82AB415")
      var_2 visionsetthermalforplayer(var_4);
    else
      var_2 visionsetkillstreakforplayer(var_4);

    if(isDefined(var_0) && isDefined(self.currentvisionset)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

      if(var_3 == "_encstr_A17905D82AB415")
        var_2 visionsetthermalforplayer(self.currentvisionset);
      else
        var_2 visionsetkillstreakforplayer(self.currentvisionset);
    }
  }
}

choppergunner_getvisionsetformat(var_0) {
  return scripts\engine\utility::ter_op(issubstr(var_0, "_encstr_A17905D82AB415"), "_encstr_A17905D82AB415", "_encstr_A18E06C6F663DB9C");
}

choppergunner_getvisionsetbystrength(var_0, var_1) {
  var_2 = undefined;

  if(var_0 == "_encstr_A17905D82AB415")
    var_2 = var_0 + "_encstr_93D313B9F1475318081B608684385067E8C14370F7" + var_1 + "_encstr_81670806AA6F51E807BD";
  else
    var_2 = "_encstr_87DE0F3686BDC11CCA9CEBD8DEB1DE93AF" + var_1 + "_encstr_81670806AA6F51E807BD";

  return var_2;
}

choppergunner_empstarted(var_0) {
  thread scripts\cp_mp\emp_debuff::_id_1241A(self.owner, 5);
  choppergunner_updatetargetmarkergroups();
}

choppergunner_empcleared(var_0) {
  choppergunner_updatetargetmarkergroups();
}

goal_default(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_860808CB78E2984063BA", var_4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_4, var_2, var_3, var_0.team, var_1, var_0, 1);
}