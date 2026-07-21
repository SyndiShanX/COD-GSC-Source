/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\cp_dwn_twn_door_cut.gsc
******************************************************/

door_cut_precache() {
  level._effect["_encstr_8A260BB958DDEB6E38854EB6CD"] = loadfx("_encstr_8E24329D99F079D2BB83F51BC1BC36599DACB15E1B83D7C439BEB95E936D79ECCC1EBE6C07AFCDB077BEDC83B093B5E6B83B663C");
}

main(var_0) {
  cutout_door_main();
  wait_for_door_cut();
  level thread break_door();
}

cutout_door_main() {
  init_cutout_anims();
  level.door_cut_interactions = [];
  level.vault_door_broken = 0;
  var_0 = scripts\engine\utility::getStructArray("_encstr_81E51B3632CDA14321432F155057EF635C97D34D53EA42A7AB49AB0A8E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = create_cut_interactions(var_2);

    if(isDefined(var_3))
      level.door_cut_interactions[level.door_cut_interactions.size] = var_3;
  }

  foreach(var_6 in level.door_cut_interactions) {
    if(isDefined(var_6))
      var_6 makeusable();
  }

  var_8 = getEnt("_encstr_9B9715B60368DD1B6039CAA3415893D560CD672B812062", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 disconnectPaths();
}

break_door() {
  var_0 = getEnt("_encstr_9B9715B60368DD1B6039CAA3415893D560CD672B812062", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_B1DA10D3CBBDC2740119B6FB7129AC4A1845", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 rotateby((90, 0, 0), 0.45);
  wait 0.4;
  var_1 playSound("_encstr_A1C712E633C15A2218FF5F87D33DAAAFD0F9DDAD");
  var_0 connectpaths();
  var_0 notsolid();
  level thread bank_alarm_sfx();
  level.vault_door_broken = 1;
}

bank_alarm_sfx() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (5040, 854, 41));
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (3940, 1853, 180));
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (5404, 809, 42));
  var_3 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (3742, 870, 184));
  var_4 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (5452, 213, 435));
  wait 0.05;
  var_0 playLoopSound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
  var_1 playLoopSound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
  var_2 playLoopSound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
  var_3 playLoopSound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
  var_4 playLoopSound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
  scripts\engine\utility::flag_wait("_encstr_8896112DE6B41DFA4EF67B33F51BDED631163A");

  if(isDefined(var_0)) {
    var_0 stoploopsound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
    var_0 delete();
  }

  if(isDefined(var_1)) {
    var_1 stoploopsound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
    var_1 delete();
  }

  if(isDefined(var_2)) {
    var_2 stoploopsound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
    var_2 delete();
  }

  if(isDefined(var_3)) {
    var_3 stoploopsound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
    var_3 delete();
  }

  if(isDefined(var_4)) {
    var_4 stoploopsound("_encstr_884817B25BE8BE858D859CDAFA2685DCADAF2656D8B1FAD807");
    var_4 delete();
  }
}

wait_for_door_cut(var_0) {
  level endon("_encstr_8F2612888057470CE84860A7B8C34179539B397B");
  level.waiting_for_door_cut = 1;
  level._id_140F6 = 0;

  for(;;) {
    level waittill("_encstr_A15B098459EB91FF9E1BF0");
    level._id_140F6++;

    if(level._id_140F6 >= level.door_cut_interactions.size) {
      level notify("_encstr_8EF6146379EC978920AB061D3F98CF3798569BEB41CD");
      scripts\engine\utility::flag_set("_encstr_8EF6146379EC978920AB061D3F98CF3798569BEB41CD");

      foreach(var_2 in level.players)
      var_2 notify("_encstr_8B1509EC6DF092EF2EB1D3");

      break;
    }
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_cutout_anims() {
  level.scr_animtree["_encstr_88570E91B0D11B970A89093410A3606B"] = #animtree;
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"] = % _encstr_BEDA2FFA15CDD9533BC1E3F7C8D309024B2046F3850FB38CE6308BF76BA9FFFA3FCDC12AEDA15AAF4BA84F9BE081A152D5;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"] = "_encstr_BEDA2FFA15CDD9533BC1E3F7C8D309024B2046F3850FB38CE6308BF76BA9FFFA3FCDC12AEDA15AAF4BA84F9BE081A152D5";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"] = "_encstr_8FCC0CC1BA8DC6B7D5D17DB958BB";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"] = % _encstr_966D2F7798F39FF22960CC055E19EA6FB9D9BF97F0880DCB1F86D5BC49DBC1340328D70B40835123BB2311F22183FBFD8B;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"] = "_encstr_966D2F7798F39FF22960CC055E19EA6FB9D9BF97F0880DCB1F86D5BC49DBC1340328D70B40835123BB2311F22183FBFD8B";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"] = "_encstr_86A70CA30B9D2F73B84B9FBB1360";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A9D506FF076BA7C2"] = % _encstr_85C0293B129BE0505A1FE9EF5B0318B46F19B163FB172D20B93A99FB7DAE218D6FC38E63D1C3E9B0C815AD;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A9D506FF076BA7C2"] = "_encstr_85C0293B129BE0505A1FE9EF5B0318B46F19B163FB172D20B93A99FB7DAE218D6FC38E63D1C3E9B0C815AD";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A9D506FF076BA7C2"] = "_encstr_ACBD0DF049519F2F9591520BF0F772";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_BAD506B18B0B7842"] = % _encstr_B4222957B8D3FF9249AFAC657E39CA8F59F99FF790A82D2B3FA6B59C693BE15423C8F76231E37C22ABCD3A;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_BAD506B18B0B7842"] = "_encstr_B4222957B8D3FF9249AFAC657E39CA8F59F99FF790A82D2B3FA6B59C693BE15423C8F76231E37C22ABCD3A";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_BAD506B18B0B7842"] = "_encstr_91BD0D38D858E5B227D7B1D51DBE64";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_B1D506B157477D99"] = % _encstr_A9F0296E914EEB6C83BED0BDCD8E2CCECA7DB1BA47F6EA1DAF89B1B4B5B0F523B9E8BE66BEE0C62CF2ACC9;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_B1D506B157477D99"] = "_encstr_A9F0296E914EEB6C83BED0BDCD8E2CCECA7DB1BA47F6EA1DAF89B1B4B5B0F523B9E8BE66BEE0C62CF2ACC9";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_B1D506B157477D99"] = "_encstr_8FBD0D0B80BFF74F889F4B45D1B982";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A5D5066CEAE8BED0"] = % _encstr_9391299EF0130F4830D6089013A5F7FFB5B0DF1DA14743EBE7F9C1C4899337F88B6B5F7B2F6B982F5B5F22;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A5D5066CEAE8BED0"] = "_encstr_9391299EF0130F4830D6089013A5F7FFB5B0DF1DA14743EBE7F9C1C4899337F88B6B5F7B2F6B982F5B5F22";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A5D5066CEAE8BED0"] = "_encstr_82BD0DEBFD89205DD387C7E3C3E93D";
  level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"] = % _encstr_B6C52C927DB5A13B5399CBCFE00BF1EA6318DA8C562F5B50DE58D3DFF881ACB2E725A285C36B82B70350DF67809B;
  level.scr_animname["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"] = "_encstr_B6C52C927DB5A13B5399CBCFE00BF1EA6318DA8C562F5B50DE58D3DFF881ACB2E725A285C36B82B70350DF67809B";
  level.scr_eventanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"] = "_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51";
  level.scr_viewmodelanim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_AD6513C88473F1CACF1B4B29BBB1610AFBC8DC9B51"] = "_encstr_87FD2810727179407FCC0F74B5A7EB2326BAB0A8C9D6B9583FC1857D9BD353E70822B049D3EDDB12F7FA";
  level.scr_animtree["_encstr_BD1904CB7BBB"] = #animtree;
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_8E9908980388F54F4D73"] = % _encstr_87732CCDC8E4EB6CE0FAA1DBCD3A58B359D7B1EAA3B7AE47FA89632DB6C2EB32E61DAF83BAC663F6AE3AD79B16EE;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_8E9908980388F54F4D73"] = "_encstr_87732CCDC8E4EB6CE0FAA1DBCD3A58B359D7B1EAA3B7AE47FA89632DB6C2EB32E61DAF83BAC663F6AE3AD79B16EE";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_A64E08D94D2B3894AFB3"] = % _encstr_99ED2C1383632FE673D0A9C2A019A0E8A1D75FE7E3E04F7B20FD0C4B29C91154EBCCC7E8A585D76FB3B01760467B;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_A64E08D94D2B3894AFB3"] = "_encstr_99ED2C1383632FE673D0A9C2A019A0E8A1D75FE7E3E04F7B20FD0C4B29C91154EBCCC7E8A585D76FB3B01760467B";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_A9D506FF076BA7C2"] = % _encstr_A566268F7D7E3E136F20D0B8AACB689C1B0FD6F37B521BF1417AA5E35AFA0F33D63B51891F63D1C3;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_A9D506FF076BA7C2"] = "_encstr_A566268F7D7E3E136F20D0B8AACB689C1B0FD6F37B521BF1417AA5E35AFA0F33D63B51891F63D1C3";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_BAD506B18B0B7842"] = % _encstr_92A0261F44A32148CBE7E01A6350C71115D9CF2B432F556BD1FBC5C7AAD14FD5C0382177B74B0EB3;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_BAD506B18B0B7842"] = "_encstr_92A0261F44A32148CBE7E01A6350C71115D9CF2B432F556BD1FBC5C7AAD14FD5C0382177B74B0EB3";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_B1D506B157477D99"] = % _encstr_85752676D7EB77A9B0C7F0D06FECA14F22B1E6FD2BD2FB73B75BD8E83F11BEF12BE37026494B9BDB;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_B1D506B157477D99"] = "_encstr_85752676D7EB77A9B0C7F0D06FECA14F22B1E6FD2BD2FB73B75BD8E83F11BEF12BE37026494B9BDB";
  level.scr_anim["_encstr_BD1904CB7BBB"]["_encstr_A5D5066CEAE8BED0"] = % _encstr_935D269B1927D76C1CFA34ED6E1D85CE95AFB1AB1DDBABE8BE31D84BB5B0FA466E1DD743EB6EC277;
  level.scr_animname["_encstr_BD1904CB7BBB"]["_encstr_A5D5066CEAE8BED0"] = "_encstr_935D269B1927D76C1CFA34ED6E1D85CE95AFB1AB1DDBABE8BE31D84BB5B0FA466E1DD743EB6EC277";
}

cut_vault_gate(var_0, var_1) {
  var_0._id_140AE = 1;
  var_2 = getcompleteweaponname("_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6");
  var_0 scripts\cp\utility::_giveweapon(var_2, undefined, undefined, 1);
  var_3 = var_0 scripts\cp\cp_weapons::switchtoweaponreliable(var_2, 0);
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_weapon_pickup(0);
  objective_pinforclient(level.cut_progress_objective, var_0);
  var_4 = getstartorigin(self.origin, self.angles, level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_1]);
  var_5 = getstartangles(self.origin, self.angles, level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_1]);
  var_0 setOrigin(var_4, 1);
  var_0 setplayerangles(var_5);
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0 cameraset("_encstr_ADF219108F65A9E5EA215E5D02931710EF1F9390D714A65DD1D6CF");
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_6 setModel("_encstr_B4091F2377E74127FBCF9A5DE3B2F485E9120E90A0AB75B0E39958E1DAF1B6E06B");
  var_6.angles = self.angles;
  var_6.animname = "_encstr_BD1904CB7BBB";
  var_6 hide();
  var_0 forceusehinton(&"_encstr_A6A61F6828FA12A4FA9A2B2596AF3D09298A1A8AA46551A99734AA15EB8452E48A");
  var_6 useanimtree(level.scr_animtree["_encstr_BD1904CB7BBB"]);
  var_0 thread scripts\cp\cp_destruction::create_player_rig(var_0, "_encstr_88570E91B0D11B970A89093410A3606B");
  var_3 = wait_for_section_cut(var_0, var_6, var_1);
  var_0 cameradefault();
  var_0 forceusehintoff();
  objective_unpinforclient(level.cut_progress_objective, var_0);
  wait 1;
  var_6 delete();
  scripts\cp\cp_destruction::remove_player_rig(var_0);
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 scripts\common\utility::allow_weapon_pickup(1);
  var_0 scripts\cp\cp_weapons::_takeweapon(var_2);
  var_0 scripts\cp\cp_weapons::forcevalidweapon();
  var_0 setstance("_encstr_A5AD069B231F0BAF");
  var_0._id_140AE = undefined;

  if(istrue(var_3))
    return 1;

  return 0;
}

wait_for_section_cut(var_0, var_1, var_2) {
  while(var_0 useButtonPressed()) {
    var_3 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"]);
    var_4 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_2]);
    var_5 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"]);

    if(getdvarfloat("_encstr_AA780F4E7782570F174BAE11D39892D30A") > 0)
      var_4 = getdvarfloat("_encstr_AA780F4E7782570F174BAE11D39892D30A");

    thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_8E9908980388F54F4D73");
    thread scripts\common\anim::anim_single_solo(var_1, "_encstr_8E9908980388F54F4D73");
    wait 0.25;
    var_0.x1circletime hide();
    var_1 show();
    wait 0.25;
    var_1 playLoopSound("_encstr_BDE50BF38A47380892E15D9370");
    wait(var_3 - 0.6);
    var_6 = var_4 - 0.25;
    thread do_cut_anims(var_0, var_1, var_2);
    var_0 forceusehintoff();
    var_7 = cut_objective_progress(var_0, var_6);
    var_1 stoploopsound();
    playsoundatpos(var_1.origin, "_encstr_846C106E85DDBEE60E5ACD570E7D6E3AB738");

    if(!isDefined(var_7) || !var_7)
      var_0 notify("_encstr_83F70B36AEA3D7CC8596362B8C");

    if(!scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_A64E08D94D2B3894AFB3");
      thread scripts\common\anim::anim_single_solo(var_1, "_encstr_A64E08D94D2B3894AFB3");
      wait 1;
    }

    var_1 hide();
    var_0.x1circletime show();
    return var_7;
  }
}

cut_objective_progress(var_0, var_1) {
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.cut_progress))
    self.cut_progress = 0;

  if(!isDefined(level.total_cut_progress))
    level.total_cut_progress = 0;

  while(self.cut_progress <= var_1 && var_0 useButtonPressed()) {
    objective_setprogress(level.cut_progress_objective, level.total_cut_progress / (var_1 * 2));
    wait 0.05;
    self.cut_progress = self.cut_progress + 0.05;
    level.total_cut_progress = level.total_cut_progress + 0.05;
  }

  return self.cut_progress >= var_1;
}

do_cut_anims(var_0, var_1, var_2) {
  var_0 endon("_encstr_83F70B36AEA3D7CC8596362B8C");
  var_3 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_8E9908980388F54F4D73"]);
  var_4 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"][var_2]);

  if(getdvarfloat("_encstr_AA780F4E7782570F174BAE11D39892D30A") > 0)
    var_4 = getdvarfloat("_encstr_AA780F4E7782570F174BAE11D39892D30A");

  var_5 = getanimlength(level.scr_anim["_encstr_88570E91B0D11B970A89093410A3606B"]["_encstr_A64E08D94D2B3894AFB3"]);
  thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, var_2);
  thread scripts\common\anim::anim_single_solo(var_1, var_2);
  wait 0.5;
  var_1 setscriptablepartstate("_encstr_84AC07D798315292CF", "_encstr_AB0703DBB9");
  wait(var_4 - 0.6);
}

magic_grenade_chance() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!randomint(100) > 80) {
    return;
  }
  wait(randomintrange(3, 8));
  magicgrenademanual("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", self.origin + (0, 0, 90), (0, 0, -50), 5);
}

create_cut_interactions(var_0) {
  var_1 = anglesToForward((0, var_0.angles[1], 0));
  var_2 = anglestoleft((0, var_0.angles[1], 0));
  var_3 = var_0.origin;
  var_4 = var_3 + (0, 0, 40) + var_2 * 10 + var_1 * -5;

  foreach(var_6 in level.door_cut_interactions) {
    if(var_6.origin == var_4)
      return undefined;
  }

  var_8 = scripts\engine\utility::getStructArray("_encstr_B2E81198AF5DA8C9E9CEB53D29022511A35710", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = var_8[0];

  if(isDefined(var_0.target)) {
    var_8 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_9 = var_8[0];
  }

  var_10 = create_cut_interaction(var_4, &"_encstr_860124F779164221B7A6408A828FC80A1C497FD3D96FFDF9BF565B3390F9E0DC446997373904", "_encstr_BAD506B18B0B7842", var_9);
  return var_10;
}

create_cut_interaction(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  waitframe();
  var_4 setHintString(var_1);
  var_4 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(65);
  var_4 setuserange(72);
  var_4 setusefov(65);
  var_4 sethintonobstruction("_encstr_BD1805CB69C063");
  var_4 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_4 thread use_think(var_2, var_3);
  return var_4;
}

use_think(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::flag_wait("_encstr_A7271216C6E8B4CE168E56BE8CBDDB27EB36AE47");

  for(;;) {
    self makeusable();
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(var_2)) {
      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(!istrue(var_2.shoot_vehicle)) {
        var_2 scripts\cp\utility::setlowermessage("_encstr_82A9084471E83D63FFA7", &"_encstr_95901FBD0FD8F997A8489CA3B6BFB7239010DB99CBC92B2FA6A4EF6B99BF774849", 5);
        continue;
      }

      level notify("_encstr_BABE18E6D158938EF51B5DD1AF9BE0C2EE73EBADDB91BAB1CA9B");
      self makeunusable();

      if(!var_1 cut_vault_gate(var_2, var_0)) {
        wait 1;
        continue;
      }
    }

    level notify("_encstr_A15B098459EB91FF9E1BF0");

    if(isDefined(level.door_cut_interactions)) {
      foreach(var_4 in level.door_cut_interactions) {
        if(isDefined(var_4))
          var_4 makeusable();
      }
    }

    self delete();
  }
}