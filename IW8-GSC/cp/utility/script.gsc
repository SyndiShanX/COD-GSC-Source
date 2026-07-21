/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\script.gsc
***********************************************/

init() {
  level.capsulepass = scripts\engine\utility::getStructArray("_encstr_A36D12C26EC6CA3732EBB9B7C67BAF26563B5A73", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.lastweaponfiretimestart = scripts\engine\utility::getStructArray("_encstr_A9A5133D75DF79D38562D1A8CA5D8FB6E31D3423C6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(level.initpostmain))
    level.initpostmain = 0;

  if(!isDefined(level._id_13BEB))
    level._id_13BEB = 0;

  foreach(var_1 in level.capsulepass)
  scripts\cp_mp\auto_ascender::markupascenderstruct(var_1, 1);

  foreach(var_4 in level.lastweaponfiretimestart)
  scripts\cp_mp\auto_ascender::markupascenderstruct(var_4, 0);

  foreach(var_1 in level.capsulepass) {
    foreach(var_4 in level.lastweaponfiretimestart) {
      if(!isDefined(var_4._id_134CB) && distance2dsquared(var_1.origin, var_4.origin) < 10) {
        var_1._id_134CB = var_4;
        var_4._id_134CB = var_1;
        level._id_13BEB--;
        break;
      }
    }
  }

  initanimtree();
  scripts\engine\scriptable::_id_12F5B("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", ::canstartusingbomb);
}

stunshoulddetonate(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius("_encstr_A6650B9F2D096F4B48E82B275B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_4 in var_2) {
    if(var_4 getscriptablehaspart("_encstr_965B0EC237B12BDC195939AFCDBDC6BD") && var_4 getscriptableparthasstate("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_A6650B9F2D096F4B48E82B275B"))
      var_4 setscriptablepartstate("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_A6650B9F2D096F4B48E82B275B");
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

initanimtree() {
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822"] = % _encstr_BDC921543599A34B3FDFC850D756A1EB33D145DBCB315B93D7EF70E0577F3867BB8546;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822"] = "_encstr_BDC921543599A34B3FDFC850D756A1EB33D145DBCB315B93D7EF70E0577F3867BB8546";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822"] = "_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2"] = % _encstr_88101F9BBDC03DCB09B7B31ECD4B5CAF8D89D09B78FFBDF0E1C8B8B8470698E12E;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2"] = "_encstr_88101F9BBDC03DCB09B7B31ECD4B5CAF8D89D09B78FFBDF0E1C8B8B8470698E12E";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2"] = "_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4"] = % _encstr_9760220EA381274728A1A3AA09982B9F405F9578F9D96B8BF099DAE356606B97D1A904FA;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4"] = "_encstr_9760220EA381274728A1A3AA09982B9F405F9578F9D96B8BF099DAE356606B97D1A904FA";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4"] = "_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6"] = % _encstr_951723D47D01C54F7FBE471E97F347972E116B180B411D8D40724FB47FCDE9C215BFEFE9A3;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6"] = "_encstr_951723D47D01C54F7FBE471E97F347972E116B180B411D8D40724FB47FCDE9C215BFEFE9A3";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6"] = "_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A"] = % _encstr_B87B2175FA9FD5CB792F7BFBB9602A0B9B973F8B63F01B7FAB7ED994A0728F59839982;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A"] = "_encstr_B87B2175FA9FD5CB792F7BFBB9602A0B9B973F8B63F01B7FAB7ED994A0728F59839982";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A"] = "_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A"] = % _encstr_810C24FBF027CF576637F31BDDA8CB17A5C97293A04FC7775BA8D717E5B35FDD25F8598B08AD;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A"] = "_encstr_810C24FBF027CF576637F31BDDA8CB17A5C97293A04FC7775BA8D717E5B35FDD25F8598B08AD";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A"] = "_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_8AC01909FA4B2B1872AFA5F7C7DB5D89E455736069B3E8C03AB7E1"] = % _encstr_AC5123BB707077BA11338B63C36007BF0EAE02E3FB280B757805AF6BE3488EE7B946CB2A43;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_8AC01909FA4B2B1872AFA5F7C7DB5D89E455736069B3E8C03AB7E1"] = "_encstr_AC5123BB707077BA11338B63C36007BF0EAE02E3FB280B757805AF6BE3488EE7B946CB2A43";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_8AC01909FA4B2B1872AFA5F7C7DB5D89E455736069B3E8C03AB7E1"] = "_encstr_8AC01909FA4B2B1872AFA5F7C7DB5D89E455736069B3E8C03AB7E1";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_963F173B8B2ED8D87BB2933E9A238D51C3E03FB701D52095A3"] = % _encstr_924E21ECD6F5592E7D856E3656E62395E4AFCA87D1D7AB07BEB1B0B91BACB1D707C64E;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_963F173B8B2ED8D87BB2933E9A238D51C3E03FB701D52095A3"] = "_encstr_924E21ECD6F5592E7D856E3656E62395E4AFCA87D1D7AB07BEB1B0B91BACB1D707C64E";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_963F173B8B2ED8D87BB2933E9A238D51C3E03FB701D52095A3"] = "_encstr_963F173B8B2ED8D87BB2933E9A238D51C3E03FB701D52095A3";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822"] = % _encstr_87E62667DAFA955CAFC2E6C6CAE6192BC9BE2BE1E87DBA1CEBCE9547FAB773D716DC362BDC915693;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822"] = "_encstr_87E62667DAFA955CAFC2E6C6CAE6192BC9BE2BE1E87DBA1CEBCE9547FAB773D716DC362BDC915693";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822"] = "_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2"] = % _encstr_8AA72433A55F28BFF997FFE7BFD20D602AB1D98A8BF710F7114BCFF783A9C708D39720817722;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2"] = "_encstr_8AA72433A55F28BFF997FFE7BFD20D602AB1D98A8BF710F7114BCFF783A9C708D39720817722";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2"] = "_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4"] = % _encstr_84C92783885F871F3E7FBBA3056033CF6D813ADBE8877BD31654B5CC3068F3D78F18C3E2984D77DF6B;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4"] = "_encstr_84C92783885F871F3E7FBBA3056033CF6D813ADBE8877BD31654B5CC3068F3D78F18C3E2984D77DF6B";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4"] = "_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6"] = % _encstr_818D283BB5EB9517EB58371BB2E6C8ACE4AFAC1EA37D23DEBBE6AF9D95A3AFBDE6FAC2B9C62BB94659E4;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6"] = "_encstr_818D283BB5EB9517EB58371BB2E6C8ACE4AFAC1EA37D23DEBBE6AF9D95A3AFBDE6FAC2B9C62BB94659E4";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6"] = "_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A"] = % _encstr_AFA226AB10EF11481136FBBF5FE641688BFF97B303C1BD55EB28C9FCF7107811D86790AAE0A4FFDA;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A"] = "_encstr_AFA226AB10EF11481136FBBF5FE641688BFF97B303C1BD55EB28C9FCF7107811D86790AAE0A4FFDA";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A"] = "_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A"] = % _encstr_8DCE29DC8597411321EA98104285E1998B0FED53F4EF2967130201287A5BDF9003DE78476BB7F15DBF9A60;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A"] = "_encstr_8DCE29DC8597411321EA98104285E1998B0FED53F4EF2967130201287A5BDF9003DE78476BB7F15DBF9A60";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A"] = "_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_8110168A9B5FCF2B0135F227DD6A8B99ABB0D182704F037F"] = % _encstr_8A98264CC7D190D3E799CB29AD7E01E76A78B293E8B16F883FAFAFE548C5359F3613392DAE1D7F6E;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_8110168A9B5FCF2B0135F227DD6A8B99ABB0D182704F037F"] = "_encstr_8A98264CC7D190D3E799CB29AD7E01E76A78B293E8B16F883FAFAFE548C5359F3613392DAE1D7F6E";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_8110168A9B5FCF2B0135F227DD6A8B99ABB0D182704F037F"] = "_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_8D011858DC8D2BB919B2C9D7CA87A3BE5D077DC67BDE83D7BB5B"] = % _encstr_96712467D056A5D3777F0A06552DBA6D5BD9A7A3F08E0D8B1F81153DC7A7222301A0135BC043;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_8D011858DC8D2BB919B2C9D7CA87A3BE5D077DC67BDE83D7BB5B"] = "_encstr_96712467D056A5D3777F0A06552DBA6D5BD9A7A3F08E0D8B1F81153DC7A7222301A0135BC043";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_8D011858DC8D2BB919B2C9D7CA87A3BE5D077DC67BDE83D7BB5B"] = "_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_A63C1711E22368700AC7BDDFFFF34571EDBA5E288B9C01B4F2"] = % _encstr_AD7B27C3756F188FC9C7AF97CF825D50FA4109BADB8740C7E1B78BB10F7A94F0BFA6735107EE8075CB;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_A63C1711E22368700AC7BDDFFFF34571EDBA5E288B9C01B4F2"] = "_encstr_AD7B27C3756F188FC9C7AF97CF825D50FA4109BADB8740C7E1B78BB10F7A94F0BFA6735107EE8075CB";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_A63C1711E22368700AC7BDDFFFF34571EDBA5E288B9C01B4F2"] = "_encstr_8DAD144EBB2285085B6D8EE11BC083377BA386D8BDF4";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_ADF818B65637A2967128C36F302A44C981E0BBED284B4A9F3B80"] = % _encstr_A5D228EEDABECAC5F51637C695E6465993FA59E1E87DC8DEBB73BE7656477DDEB9FA589BC659E6465939;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_ADF818B65637A2967128C36F302A44C981E0BBED284B4A9F3B80"] = "_encstr_A5D228EEDABECAC5F51637C695E6465993FA59E1E87DC8DEBB73BE7656477DDEB9FA589BC659E6465939";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_ADF818B65637A2967128C36F302A44C981E0BBED284B4A9F3B80"] = "_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_BD621AD1CB774580F78D0567B5D818AF33626BB891E388500A5F070B"] = % _encstr_8D2C2677082035C35757CFAF6B2D95371BD0FF38DDF8E9B85883FFE1C75548A7AFCBF975C55BD562;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_BD621AD1CB774580F78D0567B5D818AF33626BB891E388500A5F070B"] = "_encstr_8D2C2677082035C35757CFAF6B2D95371BD0FF38DDF8E9B85883FFE1C75548A7AFCBF975C55BD562";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_BD621AD1CB774580F78D0567B5D818AF33626BB891E388500A5F070B"] = "_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_885F19C2B9B159DCC85939BECAE1E8FA19EDDDCDD7B7578EEBEE5B"] = % _encstr_B452290B7829B5DB6803773F63A8D2EDE8860750B3D17CF25405BF375B4DA92F10C9319ECB9805DA253B03;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_885F19C2B9B159DCC85939BECAE1E8FA19EDDDCDD7B7578EEBEE5B"] = "_encstr_B452290B7829B5DB6803773F63A8D2EDE8860750B3D17CF25405BF375B4DA92F10C9319ECB9805DA253B03";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_885F19C2B9B159DCC85939BECAE1E8FA19EDDDCDD7B7578EEBEE5B"] = "_encstr_A503160B37C62BB9912B4EF52BE11D7D32DEBBCD7DBDAB3A";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_910C1CF343F62B10B34A5BE6521BD519CFA75775C75E7868C76290EE9B67"] = % _encstr_AB5328EE5BFA598BBEC2373659B919CA4EBE95E1A3BE8CF6BBE67D1BB0E63659D8BEB0DCB1AC3791CA27;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_910C1CF343F62B10B34A5BE6521BD519CFA75775C75E7868C76290EE9B67"] = "_encstr_AB5328EE5BFA598BBEC2373659B919CA4EBE95E1A3BE8CF6BBE67D1BB0E63659D8BEB0DCB1AC3791CA27";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_910C1CF343F62B10B34A5BE6521BD519CFA75775C75E7868C76290EE9B67"] = "_encstr_8AC01909FA4B2B1872AFA5F7C7DB5D89E455736069B3E8C03AB7E1";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_BE731A2613601D925DA3AB279B7B7B6F881BD12EC9A0A3FAA13FB7E7"] = % _encstr_A50126BBD6BE2BC57D0B6E362BB9199539BE2B0FD17DAB38AF6C5837C6B21BF585E66C56DCC82BE4;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_BE731A2613601D925DA3AB279B7B7B6F881BD12EC9A0A3FAA13FB7E7"] = "_encstr_A50126BBD6BE2BC57D0B6E362BB9199539BE2B0FD17DAB38AF6C5837C6B21BF585E66C56DCC82BE4";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_BE731A2613601D925DA3AB279B7B7B6F881BD12EC9A0A3FAA13FB7E7"] = "_encstr_963F173B8B2ED8D87BB2933E9A238D51C3E03FB701D52095A3";
}

_id_13096() {
  iprintlnbold("_encstr_834A1B51CDE82BE42B1910A31AAC40079CA5731D103357CDD88EB4BDE6");
  var_0 = getentitylessscriptablearrayinradius("_encstr_A6650B9F2D096F4B48E82B275B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    if(var_2 getscriptablehaspart("_encstr_965B0EC237B12BDC195939AFCDBDC6BD") && var_2 getscriptableparthasstate("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_A6650B9F2D096F4B48E82B275B"))
      var_2 setscriptablepartstate("_encstr_965B0EC237B12BDC195939AFCDBDC6BD", "_encstr_A6650B9F2D096F4B48E82B275B");
  }
}

canstartusingbomb(var_0, var_1, var_2, var_3, var_4) {
  level._id_12F78 = var_0;
  level notify("_encstr_A5B1104C79E035B9FE87F397C925026A9841");

  if(var_2 != "_encstr_BA19049F4B2D") {
    if(istrue(var_3.usingascender)) {
      return;
    }
    thread ascenderuse(var_0, var_3);
  }
}

endascenderanim(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  var_0 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  if(var_1)
    var_5 = "_encstr_914A1085B91B2B73919539BE56C3A3FA5D83";
  else
    var_5 = "_encstr_B6A4120BE63659DC91CAE4D7B21EA3EB46B7BBCD";

  if(var_4)
    var_5 = var_5 + "_encstr_95880867BB8EA07E5F02";
  else
    var_5 = var_5 + "_encstr_B643052F60A5B0";

  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_5);
  scripts\common\anim::anim_single_solo(var_3, var_5 + "_encstr_B81A04AFEE6B");
}

_id_136F0(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  wait 1.75;
  self rotateTo(var_0, 1.0, 0.1, 0.1);
}

startascenderanim(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  var_0 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0 thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_8BB007E03658CBCAE4", var_0.origin, var_0.angles);
  var_2.animname = "_encstr_9690073295D94B8D59";
  var_2 scripts\common\anim::setanimtree();
  var_3.animname = "_encstr_9690073295D94B8D59";
  var_3 scripts\common\anim::setanimtree();
  var_5 = (1, 0, 0);

  if(var_1) {
    var_6 = "_encstr_B2AE149D158949D9E69E950B62470AD639E5A1076BD5";
    var_7 = "_encstr_BD2613716BD7E520572DA5875538B8A0D7F30EF822";
    var_5 = rotatevector((-40.9464, 0, 0), self.angles);
  } else {
    var_6 = "_encstr_97D7133BD5B7E0899EC96D81C71DC290BFB35BFF19";
    var_7 = "_encstr_88181516B9B1B2372356C97DB20F1DBEC87B77B9D7B4E6";
    var_5 = rotatevector((-42.2388, 0, 0), self.angles);
  }

  var_0.player_rig moveTo(self.origin + var_5, 0.4, 0.1, 0.1);
  var_8 = vectorNormalize(var_5 * -1);
  var_9 = scripts\cp_mp\auto_ascender::vectortoanglessafe(var_8, (0, 0, 1));
  var_0.player_rig rotateTo(var_9, 0.4, 0.1, 0.1);

  if(var_4 > 0)
    thread _id_136F0(self.angles + (0, var_4 * -1, 0));

  var_10 = gettime();
  var_0 scripts\mp\utility\infilexfil::givegunless();
  var_11 = gettime();
  var_12 = 0.4 - (var_11 - var_10) / 1000.0;
  var_13 = max(0, var_12);
  wait(var_13);
  var_3 show();
  var_3 hidefromplayer(var_0);
  var_2 show();
  var_2 showonlytoplayer(var_0);
  var_0.player_rig linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2 linkTo(var_0.player_rig, var_6, (0, 0, 0), (0, 0, 0));
  var_3 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_0.player_rig showonlytoplayer(var_0);
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_7);
  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_7);
  thread scripts\common\anim::anim_single_solo(var_3, var_7 + "_encstr_B81A04AFEE6B");
  var_14 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"][var_7]);
  wait(var_14);
}

loopwaitanim(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A6BD1847B7F65012B3B25BD1C3780868BF44F81DC101E1E79D7D");
  self endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  if(var_3)
    var_4 = "_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2";
  else
    var_4 = "_encstr_A6F017617BC7F530275DD5974508A85063123B084113387B7A";

  var_5 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"][var_4]);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    var_0 thread scripts\mp\anim::anim_player_solo(self, self.player_rig, var_4);
    var_0 scripts\common\anim::anim_single_solo(var_2, var_4 + "_encstr_B81A04AFEE6B");

    if(!isDefined(var_5) || var_5 == 0) {
      break;
    }

    wait(var_5);
  }
}

ascenderuse(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");

  if(!scripts\cp_mp\auto_ascender::get_any_player_has_respawn(var_0, var_1)) {
    return;
  }
  var_2 = level.ascendstructs[var_0.target];

  if(!isDefined(var_2)) {
    return;
  }
  var_1.shouldskiplaststand = 1;
  var_2.waittill_player_opens_tac_map = gettime();
  var_2.ascender[var_1.guid] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.ascender[var_1.guid] setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.initpostmain++;
  var_2.scriptable = var_0;

  if(var_1 getstance() != "_encstr_A5AD069B231F0BAF")
    var_1 setstance("_encstr_A5AD069B231F0BAF");

  var_1 scripts\common\utility::allow_execution_victim(0);
  var_1 scripts\common\utility::allow_melee(0);
  var_1 scripts\common\utility::allow_ads(0);
  var_1 scripts\common\utility::allow_fire(0);

  if(istrue(var_1.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
      var_3 = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

      if(istrue(var_3))
        var_1 disableweaponswitch();
    }
  } else {
    var_1 disableoffhandweapons();
    var_1 scripts\common\utility::allow_killstreaks(0);
    var_1 disableweaponswitch();
  }

  var_2.ascender[var_1.guid] scripts\cp_mp\ent_manager::registerspawncount(2);
  var_2.inuse = 1;
  var_1.usingascender = 1;
  var_1 scripts\common\utility::allow_usability(0);
  var_4 = anglesToForward(var_2.angles);
  var_5 = anglesToForward(var_1.angles);
  var_6 = vectordot(var_5, var_4);
  var_7 = 0;

  if(var_6 < 0.5) {
    var_8 = vectorcross(var_5, var_4);

    if(var_8[2] < 0)
      var_7 = 120;
    else
      var_7 = 240;
  }

  var_9 = (0, var_7, 0);
  var_10 = var_2.ascendstructend;
  var_11 = var_2.ascendstructout;
  var_2.ascender[var_1.guid] dontinterpolate();
  var_2.ascender[var_1.guid].origin = var_2.origin;
  var_2.ascender[var_1.guid].angles = var_2.angles + var_9;
  var_12 = "_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE";
  var_13 = "_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB") {
    var_12 = "_encstr_A13B15AF9A177AB7201DBE7703362D2329BF6BB85EB097";
    var_13 = "_encstr_87AF15D8226A7F561FA56067936759DD174AB8C17A4417";
  }

  var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_14 setModel(var_12);
  var_14 hide();
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_15 setModel(var_13);
  var_15 hide();
  var_1.cansticktoent = var_2;
  var_1.cansnapcamera = var_14;
  var_1.cansolospawn = var_15;
  var_1 thread scripts\cp_mp\auto_ascender::ascenddeathlistener(var_2);
  var_2.ascender[var_1.guid] startascenderanim(var_1, var_2.dir, var_14, var_15, var_7);
  var_2.ascender[var_1.guid] playLoopSound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_1 thread loopwaitanim(var_2.ascender[var_1.guid], var_14, var_15, var_2.dir);
  var_16 = distance(var_10.origin, var_2.origin);

  if(!var_2.dir) {
    if(scripts\common\utility::iscp())
      var_17 = getdvarfloat("_encstr_A74D1763D780C18BAD4B1A62F075C7C2919FF8FD6398196FCF", scripts\cp_mp\auto_ascender::registerhandlecommand());
    else
      var_17 = getdvarfloat("_encstr_957614FBA25B20A8DFF3BFBB0647787E471B13A1AA7B", scripts\cp_mp\auto_ascender::registerfalldamagedvars());
  } else
    var_17 = getdvarfloat("_encstr_8A0F13B7504B39DB539A1A156D4A33A93B03BFF20B", scripts\cp_mp\auto_ascender::registered_checkpoints());

  var_18 = var_16 / var_17;
  var_19 = scripts\cp_mp\auto_ascender::registered_checkpoint_funcs() * var_18;
  var_20 = scripts\cp_mp\auto_ascender::registereventcallback() * var_18;
  var_2.ascender[var_1.guid] moveTo(var_10.origin, var_18, var_19, var_20);
  var_21 = 0;

  if(var_1.currentweapon.basename != "_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6")
    var_1 scripts\mp\utility\infilexfil::givegunless();

  if(getdvarint("_encstr_928C1D076FC348E0832E51C8177DB0802AFB81B7A7C82B28AB0538C07F23F8", 1) > 0)
    var_21 = var_1 _id_144CF(var_2, var_18, var_14, var_15);
  else
    wait(var_18);

  if(isDefined(var_2.ascender[var_1.guid]))
    var_2.ascender[var_1.guid] stoploopsound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");

  var_1 notify("_encstr_A6BD1847B7F65012B3B25BD1C3780868BF44F81DC101E1E79D7D");
  var_2.ascender[var_1.guid] endascenderanim(var_1, var_2.dir, var_14, var_15, var_21);

  if(var_21)
    wait(getdvarfloat("_encstr_8E07248E5BF3D6839A7A782822379D6E03C9160EBF5B38C3C6732118AACF6D433F650DF3051F", 0.2));

  var_2 scripts\cp_mp\auto_ascender::cleanupascenduse(var_1);
  var_1 notify("_encstr_B2AC15AECFCF8B1389672368C0C71F78A012D8A3425977");
}

_id_144CF(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 forceusehinton(&"_encstr_A2CB196A145E4A8A621514D4A2F50AAA153DF582D4A15493111592");
  var_5 = gettime();
  var_6 = getdvarfloat("_encstr_B6791EDC6C277D16DCB1597323B2E4BE8C2DE66CB7739B566C4724AECC33AC4E", 0.4);
  var_7 = 0;

  for(;;) {
    var_8 = (gettime() - var_5) * 0.001;
    var_9 = var_1 - var_8;

    if(var_8 >= var_1) {
      var_4 forceusehintoff();
      return 0;
    }

    if(var_8 > var_6 && var_9 > var_6) {
      if(var_7)
        var_7 = var_4 useButtonPressed();
      else if(var_4 useButtonPressed() || var_4 jumpbuttonPressed()) {
        var_4 forceusehintoff();
        return 1;
      }
    } else
      var_7 = var_4 useButtonPressed();

    waitframe();
  }

  return 0;
}

updatespecificfobindanger(var_0) {
  foreach(var_2 in level.capsulepass) {
    if(distance2dsquared(var_2.origin, var_0) < scripts\cp_mp\auto_ascender::registerhint()) {
      if(isDefined(var_2._id_134CB)) {
        if(abs(var_0[2] - var_2.origin[2]) < scripts\cp_mp\auto_ascender::registerheadlessinfil() || abs(var_0[2] - var_2._id_134CB.origin[2]) < scripts\cp_mp\auto_ascender::registerheadlessinfil())
          return 1;
      }
    }
  }

  return 0;
}