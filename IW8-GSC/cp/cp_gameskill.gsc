/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_gameskill.gsc
***********************************************/

init_gameskill() {
  setskill();
}

set_gameskill() {
  level.gameskill = getdvarint("_encstr_B1C81256933B1E3FE2F128587ABFE3519F345DCB", 1);
  setomnvar("_encstr_A62514B138BEC84B99CCB46CEA36E897AFD82BB395C6", level.gameskill);
}

get_gameskill() {
  return level.gameskill;
}

setskill(var_0) {
  if(!istrue(var_0)) {
    if(isDefined(level.gameskill)) {
      return;
    }
    level.difficultytype[0] = "_encstr_A260053D1AE31B";
    level.difficultytype[1] = "_encstr_820E07FAE8780B3A4C";
    level.difficultytype[2] = "_encstr_A7D409342C272359DC59C8";
    level.difficultytype[3] = "_encstr_BAAF081BD348D7E299C8";
    level.difficultystring["_encstr_A260053D1AE31B"] = &"_encstr_8F600F81A8ED4BAFE799F1F9B7E7D5AF40";
    level.difficultystring["_encstr_820E07FAE8780B3A4C"] = &"_encstr_91E2115C2551E8D737079C7C5964FFEDC71F5C";
    level.difficultystring["_encstr_A7D409342C272359DC59C8"] = &"_encstr_A90113EF67B0C5F13B24F40C59D0A986F8DF4563EB";
    level.difficultystring["_encstr_BAAF081BD348D7E299C8"] = &"_encstr_83671207CD5D1B1E4C63C45BB83423C1EF01534D";
  }

  anim.run_accuracy = 0.5;
  anim.walk_accuracy = 0.8;
  level.mg42badplace_mintime = 8;
  level.mg42badplace_maxtime = 16;
  level.difficultysettings["_encstr_BE1116D98B2A83683A9F1BF1FD115835B027570B83724120"]["_encstr_A260053D1AE31B"] = 40000;
  level.difficultysettings["_encstr_BE1116D98B2A83683A9F1BF1FD115835B027570B83724120"]["_encstr_820E07FAE8780B3A4C"] = 35000;
  level.difficultysettings["_encstr_BE1116D98B2A83683A9F1BF1FD115835B027570B83724120"]["_encstr_A7D409342C272359DC59C8"] = 25000;
  level.difficultysettings["_encstr_BE1116D98B2A83683A9F1BF1FD115835B027570B83724120"]["_encstr_BAAF081BD348D7E299C8"] = 25000;
  level.difficultysettings["_encstr_937917E08D2CE595278E9C2BDC0B2356492C739D2B51D2D6B2"]["_encstr_A260053D1AE31B"] = 20000;
  level.difficultysettings["_encstr_937917E08D2CE595278E9C2BDC0B2356492C739D2B51D2D6B2"]["_encstr_820E07FAE8780B3A4C"] = 15000;
  level.difficultysettings["_encstr_937917E08D2CE595278E9C2BDC0B2356492C739D2B51D2D6B2"]["_encstr_A7D409342C272359DC59C8"] = 10000;
  level.difficultysettings["_encstr_937917E08D2CE595278E9C2BDC0B2356492C739D2B51D2D6B2"]["_encstr_BAAF081BD348D7E299C8"] = 10000;
  level.difficultysettings["_encstr_9B0918C163855E2B3988DBD5C4B1CA749359B98532CA155AADCA"]["_encstr_A260053D1AE31B"] = 3600000;
  level.difficultysettings["_encstr_9B0918C163855E2B3988DBD5C4B1CA749359B98532CA155AADCA"]["_encstr_820E07FAE8780B3A4C"] = 150000;
  level.difficultysettings["_encstr_9B0918C163855E2B3988DBD5C4B1CA749359B98532CA155AADCA"]["_encstr_A7D409342C272359DC59C8"] = 90000;
  level.difficultysettings["_encstr_9B0918C163855E2B3988DBD5C4B1CA749359B98532CA155AADCA"]["_encstr_BAAF081BD348D7E299C8"] = 45000;
  level.difficultysettings["_encstr_8EA718295277AEF8CFCF47651DF56865DF0BC631CA4B5068E7CC"]["_encstr_A260053D1AE31B"] = 0;
  level.difficultysettings["_encstr_8EA718295277AEF8CFCF47651DF56865DF0BC631CA4B5068E7CC"]["_encstr_820E07FAE8780B3A4C"] = 1;
  level.difficultysettings["_encstr_8EA718295277AEF8CFCF47651DF56865DF0BC631CA4B5068E7CC"]["_encstr_A7D409342C272359DC59C8"] = 1;
  level.difficultysettings["_encstr_8EA718295277AEF8CFCF47651DF56865DF0BC631CA4B5068E7CC"]["_encstr_BAAF081BD348D7E299C8"] = 1;
  level.difficultysettings["_encstr_84320B85A80B690BD3F290E8DB"]["_encstr_A260053D1AE31B"] = 100;
  level.difficultysettings["_encstr_84320B85A80B690BD3F290E8DB"]["_encstr_820E07FAE8780B3A4C"] = 150;
  level.difficultysettings["_encstr_84320B85A80B690BD3F290E8DB"]["_encstr_A7D409342C272359DC59C8"] = 200;
  level.difficultysettings["_encstr_84320B85A80B690BD3F290E8DB"]["_encstr_BAAF081BD348D7E299C8"] = 400;
  level.difficultysettings["_encstr_8CD1144CB0E6B2D759CD59D6CBFA0BC6D85DC9588D97"]["_encstr_A260053D1AE31B"] = 0.9;
  level.difficultysettings["_encstr_8CD1144CB0E6B2D759CD59D6CBFA0BC6D85DC9588D97"]["_encstr_820E07FAE8780B3A4C"] = 1.0;
  level.difficultysettings["_encstr_8CD1144CB0E6B2D759CD59D6CBFA0BC6D85DC9588D97"]["_encstr_A7D409342C272359DC59C8"] = 1.15;
  level.difficultysettings["_encstr_8CD1144CB0E6B2D759CD59D6CBFA0BC6D85DC9588D97"]["_encstr_BAAF081BD348D7E299C8"] = 1.5;
  level.difficultysettings["_encstr_9201129BD76AE5F009B65AF5DCE3380E8247092B"]["_encstr_A260053D1AE31B"] = 1.0;
  level.difficultysettings["_encstr_9201129BD76AE5F009B65AF5DCE3380E8247092B"]["_encstr_820E07FAE8780B3A4C"] = 1.0;
  level.difficultysettings["_encstr_9201129BD76AE5F009B65AF5DCE3380E8247092B"]["_encstr_A7D409342C272359DC59C8"] = 0.8;
  level.difficultysettings["_encstr_9201129BD76AE5F009B65AF5DCE3380E8247092B"]["_encstr_BAAF081BD348D7E299C8"] = 0.5;
  level.difficultysettings["_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2"]["_encstr_A260053D1AE31B"] = 3.0;
  level.difficultysettings["_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2"]["_encstr_820E07FAE8780B3A4C"] = 2.0;
  level.difficultysettings["_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2"]["_encstr_A7D409342C272359DC59C8"] = 1.5;
  level.difficultysettings["_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2"]["_encstr_BAAF081BD348D7E299C8"] = 0.75;
  level.difficultysettings["_encstr_A2A216EE36FF53ABFA99687B621353EB2FA56066938798E3"]["_encstr_A260053D1AE31B"] = 1.3;
  level.difficultysettings["_encstr_A2A216EE36FF53ABFA99687B621353EB2FA56066938798E3"]["_encstr_820E07FAE8780B3A4C"] = 1.1;
  level.difficultysettings["_encstr_A2A216EE36FF53ABFA99687B621353EB2FA56066938798E3"]["_encstr_A7D409342C272359DC59C8"] = 0.9;
  level.difficultysettings["_encstr_A2A216EE36FF53ABFA99687B621353EB2FA56066938798E3"]["_encstr_BAAF081BD348D7E299C8"] = 0.45;
  level.difficultysettings["_encstr_8394146BC55002B71E05020AEB6DFFFF4027F3C169E8"]["_encstr_A260053D1AE31B"] = 1.0;
  level.difficultysettings["_encstr_8394146BC55002B71E05020AEB6DFFFF4027F3C169E8"]["_encstr_820E07FAE8780B3A4C"] = 1.6;
  level.difficultysettings["_encstr_8394146BC55002B71E05020AEB6DFFFF4027F3C169E8"]["_encstr_A7D409342C272359DC59C8"] = 1.6;
  level.difficultysettings["_encstr_8394146BC55002B71E05020AEB6DFFFF4027F3C169E8"]["_encstr_BAAF081BD348D7E299C8"] = 2.5;
  level.difficultysettings["_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59"]["_encstr_A260053D1AE31B"] = 4.0;
  level.difficultysettings["_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59"]["_encstr_820E07FAE8780B3A4C"] = 3.0;
  level.difficultysettings["_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59"]["_encstr_A7D409342C272359DC59C8"] = 2.0;
  level.difficultysettings["_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59"]["_encstr_BAAF081BD348D7E299C8"] = 1.1;
  level.difficultysettings["_encstr_99F70A0E16A59BFA1D95E647"]["_encstr_A260053D1AE31B"] = scripts\common\gameskill::always_pain;
  level.difficultysettings["_encstr_99F70A0E16A59BFA1D95E647"]["_encstr_820E07FAE8780B3A4C"] = scripts\common\gameskill::always_pain;
  level.difficultysettings["_encstr_99F70A0E16A59BFA1D95E647"]["_encstr_A7D409342C272359DC59C8"] = scripts\common\gameskill::pain_protection;
  level.difficultysettings["_encstr_99F70A0E16A59BFA1D95E647"]["_encstr_BAAF081BD348D7E299C8"] = scripts\common\gameskill::pain_protection;
  level.difficultysettings["_encstr_879611A3DF4BC621E1D539F57DDE20FDC25B19"]["_encstr_A260053D1AE31B"] = 1.0;
  level.difficultysettings["_encstr_879611A3DF4BC621E1D539F57DDE20FDC25B19"]["_encstr_820E07FAE8780B3A4C"] = 0.05;
  level.difficultysettings["_encstr_879611A3DF4BC621E1D539F57DDE20FDC25B19"]["_encstr_A7D409342C272359DC59C8"] = 0.03;
  level.difficultysettings["_encstr_879611A3DF4BC621E1D539F57DDE20FDC25B19"]["_encstr_BAAF081BD348D7E299C8"] = 0.02;
  level.difficultysettings["_encstr_9B9517AD2D379BA2A5D6CA11A5CDA32CCDB1ACC80B368EDB27"]["_encstr_A260053D1AE31B"] = 0.0008;
  level.difficultysettings["_encstr_9B9517AD2D379BA2A5D6CA11A5CDA32CCDB1ACC80B368EDB27"]["_encstr_820E07FAE8780B3A4C"] = 0.0001;
  level.difficultysettings["_encstr_9B9517AD2D379BA2A5D6CA11A5CDA32CCDB1ACC80B368EDB27"]["_encstr_A7D409342C272359DC59C8"] = 0.00005;
  level.difficultysettings["_encstr_9B9517AD2D379BA2A5D6CA11A5CDA32CCDB1ACC80B368EDB27"]["_encstr_BAAF081BD348D7E299C8"] = 0.00003;
  level.difficultysettings["_encstr_8B48180E36162F569CF5B5858732C616CD862185CD9DA8A5D656"]["_encstr_A260053D1AE31B"] = 6;
  level.difficultysettings["_encstr_8B48180E36162F569CF5B5858732C616CD862185CD9DA8A5D656"]["_encstr_820E07FAE8780B3A4C"] = 8;
  level.difficultysettings["_encstr_8B48180E36162F569CF5B5858732C616CD862185CD9DA8A5D656"]["_encstr_A7D409342C272359DC59C8"] = 9;
  level.difficultysettings["_encstr_8B48180E36162F569CF5B5858732C616CD862185CD9DA8A5D656"]["_encstr_BAAF081BD348D7E299C8"] = 10;
  level.difficultysettings["_encstr_8621168BB525B06387D8BAF59720B27D33D53327E91CA838"]["_encstr_A260053D1AE31B"] = 0.35;
  level.difficultysettings["_encstr_8621168BB525B06387D8BAF59720B27D33D53327E91CA838"]["_encstr_820E07FAE8780B3A4C"] = 0.3;
  level.difficultysettings["_encstr_8621168BB525B06387D8BAF59720B27D33D53327E91CA838"]["_encstr_A7D409342C272359DC59C8"] = 0.2;
  level.difficultysettings["_encstr_8621168BB525B06387D8BAF59720B27D33D53327E91CA838"]["_encstr_BAAF081BD348D7E299C8"] = 0.2;
  level.difficultysettings["_encstr_8321166F15FC93AC1998F5FF76E8E638DFBBD7DFFBB91A80"]["_encstr_A260053D1AE31B"] = 0.35;
  level.difficultysettings["_encstr_8321166F15FC93AC1998F5FF76E8E638DFBBD7DFFBB91A80"]["_encstr_820E07FAE8780B3A4C"] = 0.3;
  level.difficultysettings["_encstr_8321166F15FC93AC1998F5FF76E8E638DFBBD7DFFBB91A80"]["_encstr_A7D409342C272359DC59C8"] = 0.2;
  level.difficultysettings["_encstr_8321166F15FC93AC1998F5FF76E8E638DFBBD7DFFBB91A80"]["_encstr_BAAF081BD348D7E299C8"] = 0.2;
  level.difficultysettings["_encstr_8CC1134B379DEA1B8A4B5B59D7DBB944B0AD859D56"]["_encstr_A260053D1AE31B"] = 0.35;
  level.difficultysettings["_encstr_8CC1134B379DEA1B8A4B5B59D7DBB944B0AD859D56"]["_encstr_820E07FAE8780B3A4C"] = 0.3;
  level.difficultysettings["_encstr_8CC1134B379DEA1B8A4B5B59D7DBB944B0AD859D56"]["_encstr_A7D409342C272359DC59C8"] = 0.2;
  level.difficultysettings["_encstr_8CC1134B379DEA1B8A4B5B59D7DBB944B0AD859D56"]["_encstr_BAAF081BD348D7E299C8"] = 0.2;
  level.difficultysettings["_encstr_BDEA1E5438FD437497689FA7C1C9354A8143528C13730A847DA0EBBFF040E742"]["_encstr_A260053D1AE31B"] = 2.0;
  level.difficultysettings["_encstr_BDEA1E5438FD437497689FA7C1C9354A8143528C13730A847DA0EBBFF040E742"]["_encstr_820E07FAE8780B3A4C"] = 1.0;
  level.difficultysettings["_encstr_BDEA1E5438FD437497689FA7C1C9354A8143528C13730A847DA0EBBFF040E742"]["_encstr_A7D409342C272359DC59C8"] = 0.5;
  level.difficultysettings["_encstr_BDEA1E5438FD437497689FA7C1C9354A8143528C13730A847DA0EBBFF040E742"]["_encstr_BAAF081BD348D7E299C8"] = 0.25;
  level.difficultysettings["_encstr_8A5E1A602579B1F08A078120CE2D04307898E7261D9D0A5B7D707296"]["_encstr_A260053D1AE31B"] = 4.0;
  level.difficultysettings["_encstr_8A5E1A602579B1F08A078120CE2D04307898E7261D9D0A5B7D707296"]["_encstr_820E07FAE8780B3A4C"] = 4.0;
  level.difficultysettings["_encstr_8A5E1A602579B1F08A078120CE2D04307898E7261D9D0A5B7D707296"]["_encstr_A7D409342C272359DC59C8"] = 4.0;
  level.difficultysettings["_encstr_8A5E1A602579B1F08A078120CE2D04307898E7261D9D0A5B7D707296"]["_encstr_BAAF081BD348D7E299C8"] = 4.0;
  level.difficultysettings["_encstr_83911B68C11040B71EC6B26A69798B7CE14BF7C56DE18F5B4F3AF8D290"]["_encstr_A260053D1AE31B"] = 2.1;
  level.difficultysettings["_encstr_83911B68C11040B71EC6B26A69798B7CE14BF7C56DE18F5B4F3AF8D290"]["_encstr_820E07FAE8780B3A4C"] = 1.85;
  level.difficultysettings["_encstr_83911B68C11040B71EC6B26A69798B7CE14BF7C56DE18F5B4F3AF8D290"]["_encstr_A7D409342C272359DC59C8"] = 2.7;
  level.difficultysettings["_encstr_83911B68C11040B71EC6B26A69798B7CE14BF7C56DE18F5B4F3AF8D290"]["_encstr_BAAF081BD348D7E299C8"] = 3.25;
  level.difficultysettings["_encstr_8E911BA7E46FB061A361C17B364A4BDB55CADCE9BAF33763B7B31F3929"]["_encstr_A260053D1AE31B"] = 4.35;
  level.difficultysettings["_encstr_8E911BA7E46FB061A361C17B364A4BDB55CADCE9BAF33763B7B31F3929"]["_encstr_820E07FAE8780B3A4C"] = 5.0;
  level.difficultysettings["_encstr_8E911BA7E46FB061A361C17B364A4BDB55CADCE9BAF33763B7B31F3929"]["_encstr_A7D409342C272359DC59C8"] = 6.0;
  level.difficultysettings["_encstr_8E911BA7E46FB061A361C17B364A4BDB55CADCE9BAF33763B7B31F3929"]["_encstr_BAAF081BD348D7E299C8"] = 7.05;
  level.difficultysettings["_encstr_81B2186B058770373AF9F81528439819ADE93F65D5396B191B03"]["_encstr_A260053D1AE31B"] = 2.5;
  level.difficultysettings["_encstr_81B2186B058770373AF9F81528439819ADE93F65D5396B191B03"]["_encstr_820E07FAE8780B3A4C"] = 3.0;
  level.difficultysettings["_encstr_81B2186B058770373AF9F81528439819ADE93F65D5396B191B03"]["_encstr_A7D409342C272359DC59C8"] = 4.0;
  level.difficultysettings["_encstr_81B2186B058770373AF9F81528439819ADE93F65D5396B191B03"]["_encstr_BAAF081BD348D7E299C8"] = 5.05;
  level.difficultysettings["_encstr_91DD1A0EB10BE5B29CEB0D2B0B8DD1D092599D59CD29854795D44BDC"]["_encstr_A260053D1AE31B"] = 1.25;
  level.difficultysettings["_encstr_91DD1A0EB10BE5B29CEB0D2B0B8DD1D092599D59CD29854795D44BDC"]["_encstr_820E07FAE8780B3A4C"] = 0.65;
  level.difficultysettings["_encstr_91DD1A0EB10BE5B29CEB0D2B0B8DD1D092599D59CD29854795D44BDC"]["_encstr_A7D409342C272359DC59C8"] = 0.25;
  level.difficultysettings["_encstr_91DD1A0EB10BE5B29CEB0D2B0B8DD1D092599D59CD29854795D44BDC"]["_encstr_BAAF081BD348D7E299C8"] = 0.05;
  level.difficultysettings["_encstr_86DD1A388DC2972B27BEA1B285D83A1A92CACECA3794C2A32BD40B3C"]["_encstr_A260053D1AE31B"] = 18.85;
  level.difficultysettings["_encstr_86DD1A388DC2972B27BEA1B285D83A1A92CACECA3794C2A32BD40B3C"]["_encstr_820E07FAE8780B3A4C"] = 14.65;
  level.difficultysettings["_encstr_86DD1A388DC2972B27BEA1B285D83A1A92CACECA3794C2A32BD40B3C"]["_encstr_A7D409342C272359DC59C8"] = 10.55;
  level.difficultysettings["_encstr_86DD1A388DC2972B27BEA1B285D83A1A92CACECA3794C2A32BD40B3C"]["_encstr_BAAF081BD348D7E299C8"] = 9.2;
  level.difficultysettings["_encstr_A30A17CB73685B5FB8A92BE579AA2DC2B287CF95AAAE696BF1"]["_encstr_A260053D1AE31B"] = 40;
  level.difficultysettings["_encstr_A30A17CB73685B5FB8A92BE579AA2DC2B287CF95AAAE696BF1"]["_encstr_820E07FAE8780B3A4C"] = 40;
  level.difficultysettings["_encstr_A30A17CB73685B5FB8A92BE579AA2DC2B287CF95AAAE696BF1"]["_encstr_A7D409342C272359DC59C8"] = 40;
  level.difficultysettings["_encstr_A30A17CB73685B5FB8A92BE579AA2DC2B287CF95AAAE696BF1"]["_encstr_BAAF081BD348D7E299C8"] = 40;
  level.difficultysettings["_encstr_A69C0E68C1C9E9D7C36F433F7F19E374"]["_encstr_A260053D1AE31B"] = 355;
  level.difficultysettings["_encstr_A69C0E68C1C9E9D7C36F433F7F19E374"]["_encstr_820E07FAE8780B3A4C"] = 180;
  level.difficultysettings["_encstr_A69C0E68C1C9E9D7C36F433F7F19E374"]["_encstr_A7D409342C272359DC59C8"] = 140;
  level.difficultysettings["_encstr_A69C0E68C1C9E9D7C36F433F7F19E374"]["_encstr_BAAF081BD348D7E299C8"] = 80;
  level.difficultysettings["_encstr_84F51C33B84AD37A53B92D0B61691FB2F60FAA24D3109E82F77B6DC0EBE0"]["_encstr_A260053D1AE31B"] = 70;
  level.difficultysettings["_encstr_84F51C33B84AD37A53B92D0B61691FB2F60FAA24D3109E82F77B6DC0EBE0"]["_encstr_820E07FAE8780B3A4C"] = 30;
  level.difficultysettings["_encstr_84F51C33B84AD37A53B92D0B61691FB2F60FAA24D3109E82F77B6DC0EBE0"]["_encstr_A7D409342C272359DC59C8"] = 0;
  level.difficultysettings["_encstr_84F51C33B84AD37A53B92D0B61691FB2F60FAA24D3109E82F77B6DC0EBE0"]["_encstr_BAAF081BD348D7E299C8"] = 0;
  level.lastplayersighted = 0;
  level.playermeleedamagemultiplier_dvar = 0.8;
  init_mgturretsettings();
  updategameskill();
  updatealldifficulty();
}

updatealldifficulty() {
  setglobaldifficulty();

  foreach(var_1 in level.players)
  var_1 setdifficulty();
}

init_mgturretsettings() {
  level.mgturretsettings["_encstr_A260053D1AE31B"]["_encstr_B4B81020CAA5ADE98337E5680BE7F75BCDF2"] = 2.5;
  level.mgturretsettings["_encstr_A260053D1AE31B"]["_encstr_B24210A33BAF5B02884FC3D11FB8C3475951"] = 3.0;
  level.mgturretsettings["_encstr_A260053D1AE31B"]["_encstr_82DD09CFCB90B55651A6EB"] = 0.38;
  level.mgturretsettings["_encstr_A260053D1AE31B"]["_encstr_B6F309895C67D3CA48709D"] = 2;
  level.mgturretsettings["_encstr_A260053D1AE31B"]["_encstr_A5DC0D071B58975993A9C19395588C"] = 0.5;
  level.mgturretsettings["_encstr_AB5E07609A5B7368E5"]["_encstr_B4B81020CAA5ADE98337E5680BE7F75BCDF2"] = 1.5;
  level.mgturretsettings["_encstr_AB5E07609A5B7368E5"]["_encstr_B24210A33BAF5B02884FC3D11FB8C3475951"] = 3.0;
  level.mgturretsettings["_encstr_AB5E07609A5B7368E5"]["_encstr_82DD09CFCB90B55651A6EB"] = 0.38;
  level.mgturretsettings["_encstr_AB5E07609A5B7368E5"]["_encstr_B6F309895C67D3CA48709D"] = 2;
  level.mgturretsettings["_encstr_AB5E07609A5B7368E5"]["_encstr_A5DC0D071B58975993A9C19395588C"] = 0.5;
  level.mgturretsettings["_encstr_83CC051A163991"]["_encstr_B4B81020CAA5ADE98337E5680BE7F75BCDF2"] = 0.8;
  level.mgturretsettings["_encstr_83CC051A163991"]["_encstr_B24210A33BAF5B02884FC3D11FB8C3475951"] = 3.0;
  level.mgturretsettings["_encstr_83CC051A163991"]["_encstr_82DD09CFCB90B55651A6EB"] = 0.38;
  level.mgturretsettings["_encstr_83CC051A163991"]["_encstr_B6F309895C67D3CA48709D"] = 2;
  level.mgturretsettings["_encstr_83CC051A163991"]["_encstr_A5DC0D071B58975993A9C19395588C"] = 0.5;
  level.mgturretsettings["_encstr_BAAF081BD348D7E299C8"]["_encstr_B4B81020CAA5ADE98337E5680BE7F75BCDF2"] = 0.8;
  level.mgturretsettings["_encstr_BAAF081BD348D7E299C8"]["_encstr_B24210A33BAF5B02884FC3D11FB8C3475951"] = 3.0;
  level.mgturretsettings["_encstr_BAAF081BD348D7E299C8"]["_encstr_82DD09CFCB90B55651A6EB"] = 0.38;
  level.mgturretsettings["_encstr_BAAF081BD348D7E299C8"]["_encstr_B6F309895C67D3CA48709D"] = 2;
  level.mgturretsettings["_encstr_BAAF081BD348D7E299C8"]["_encstr_A5DC0D071B58975993A9C19395588C"] = 0.5;
  level.mgturretsettings["_encstr_820703B86B"]["_encstr_B4B81020CAA5ADE98337E5680BE7F75BCDF2"] = 0.4;
  level.mgturretsettings["_encstr_820703B86B"]["_encstr_B24210A33BAF5B02884FC3D11FB8C3475951"] = 3.0;
  level.mgturretsettings["_encstr_820703B86B"]["_encstr_82DD09CFCB90B55651A6EB"] = 0.38;
  level.mgturretsettings["_encstr_820703B86B"]["_encstr_B6F309895C67D3CA48709D"] = 2;
  level.mgturretsettings["_encstr_820703B86B"]["_encstr_A5DC0D071B58975993A9C19395588C"] = 0.5;
}

setdifficulty() {
  set_difficulty_from_locked_settings();
}

setglobaldifficulty() {
  var_0 = scripts\common\gameskill::get_skill_from_index(level.gameskill);
  anim.pain_test = scripts\common\gameskill::get_difficultysetting_global("_encstr_99F70A0E16A59BFA1D95E647");
  anim.min_sniper_burst_delay_time = scripts\common\gameskill::get_difficultysetting_global("_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2");
  anim.max_sniper_burst_delay_time = scripts\common\gameskill::get_difficultysetting_global("_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59");
  setsaveddvar("_encstr_B1A30B6A82A9F4A6311354A682", scripts\common\gameskill::get_difficultysetting_global("_encstr_9201129BD76AE5F009B65AF5DCE3380E8247092B"));
}

updategameskill() {
  if(isDefined(level.forcedgameskill))
    level.gameskill = level.forcedgameskill;
  else
    set_gameskill();

  setglobaldifficulty();
  return level.gameskill;
}

apply_difficulty_settings(var_0) {
  self.gs = spawnStruct();
  self.gs.diedrecentlycooldown = scripts\common\gameskill::get_difficultysetting_frac("_encstr_84F51C33B84AD37A53B92D0B61691FB2F60FAA24D3109E82F77B6DC0EBE0", var_0);
  self.gs.maxflashbangtime = scripts\common\gameskill::get_difficultysetting_frac("_encstr_8B48180E36162F569CF5B5858732C616CD862185CD9DA8A5D656", var_0);
  self.gs.invultime_ondamagemin = scripts\common\gameskill::get_difficultysetting_frac("_encstr_8621168BB525B06387D8BAF59720B27D33D53327E91CA838", var_0);
  self.gs.invultime_ondamagemax = scripts\common\gameskill::get_difficultysetting_frac("_encstr_8321166F15FC93AC1998F5FF76E8E638DFBBD7DFFBB91A80", var_0);
  self.gs.invultime_deathshieldduration = scripts\common\gameskill::get_difficultysetting_frac("_encstr_BDEA1E5438FD437497689FA7C1C9354A8143528C13730A847DA0EBBFF040E742", var_0);
  self.gs.invultime_ondamage = scripts\common\gameskill::get_difficultysetting_frac("_encstr_8CC1134B379DEA1B8A4B5B59D7DBB944B0AD859D56", var_0);
  self.gs.deathsdoorduration = scripts\common\gameskill::get_difficultysetting_frac("_encstr_8A5E1A602579B1F08A078120CE2D04307898E7261D9D0A5B7D707296", var_0);
  self.gs.scripteddamagemultiplier = 1;
  self.gs.scripteddeathshielddurationscale = 2;
  self.gs.healthregendelaymin = scripts\common\gameskill::get_difficultysetting_frac("_encstr_83911B68C11040B71EC6B26A69798B7CE14BF7C56DE18F5B4F3AF8D290", var_0);
  self.gs.healthregendelaymax = scripts\common\gameskill::get_difficultysetting_frac("_encstr_8E911BA7E46FB061A361C17B364A4BDB55CADCE9BAF33763B7B31F3929", var_0);
  self.gs.healthregendelay = scripts\common\gameskill::get_difficultysetting_frac("_encstr_81B2186B058770373AF9F81528439819ADE93F65D5396B191B03", var_0);
  self.gs.healthregenratemin = scripts\common\gameskill::get_difficultysetting_frac("_encstr_91DD1A0EB10BE5B29CEB0D2B0B8DD1D092599D59CD29854795D44BDC", var_0);
  self.gs.healthregenratemax = scripts\common\gameskill::get_difficultysetting_frac("_encstr_86DD1A388DC2972B27BEA1B285D83A1A92CACECA3794C2A32BD40B3C", var_0);
  self.gs.healthregendelay = scripts\common\gameskill::get_difficultysetting_frac("_encstr_81B2186B058770373AF9F81528439819ADE93F65D5396B191B03", var_0);
  self.gs.healthregenrate = scripts\common\gameskill::get_difficultysetting_frac("_encstr_A30A17CB73685B5FB8A92BE579AA2DC2B287CF95AAAE696BF1", var_0);
  self.gs.player_attacker_accuracy = scripts\common\gameskill::get_difficultysetting_frac("_encstr_8CD1144CB0E6B2D759CD59D6CBFA0BC6D85DC9588D97", var_0);
  update_player_attacker_accuracy();
  self.gs.playergrenadebasetime = int(scripts\common\gameskill::get_difficultysetting_frac("_encstr_BE1116D98B2A83683A9F1BF1FD115835B027570B83724120", var_0));
  self.gs.playergrenaderangetime = int(scripts\common\gameskill::get_difficultysetting_frac("_encstr_937917E08D2CE595278E9C2BDC0B2356492C739D2B51D2D6B2", var_0));
  self.gs.playerdoublegrenadetime = int(scripts\common\gameskill::get_difficultysetting_frac("_encstr_9B0918C163855E2B3988DBD5C4B1CA749359B98532CA155AADCA", var_0));
  self.gs.min_sniper_burst_delay_time = scripts\common\gameskill::get_difficultysetting_frac("_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2", var_0);
  self.gs.max_sniper_burst_delay_time = scripts\common\gameskill::get_difficultysetting_frac("_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59", var_0);
  self.gs.damagemultiplierhealth = self.maxhealth / scripts\common\gameskill::get_difficultysetting_frac("_encstr_A69C0E68C1C9E9D7C36F433F7F19E374", var_0);

  if(scripts\common\utility::playerarmorenabled()) {
    self.gs.armorratiohealthregenthreshold = scripts\common\gameskill::get_difficultysetting_frac("_encstr_AFF1265B4D0AE0F51B3EF81308C8ABDE09E1100FD9FB288058BC16227167C87544864D231BD73283", var_0);
    self.gs.armordamagetohealthratiomin = scripts\common\gameskill::get_difficultysetting_frac("_encstr_A67523670CE74AA3F28170105A4D45253FA567549D5BF0A11F4A1028222A1B7BB75FE9DBFE", var_0);
    self.gs.armordamagetohealthratiomax = scripts\common\gameskill::get_difficultysetting_frac("_encstr_A175231398A7FF47B097514A9B30CA73DFD09AEA01956FF4D0D3443489E1D67B7308D0324A", var_0);
    self.gs.damagemultiplierarmor = self.armor.maxamount / scripts\common\gameskill::get_difficultysetting_frac("_encstr_A93B0D7BC346A81A3B3F8F5BA90718", var_0);
    self.damagemultiplier = self.gs.damagemultiplierarmor;
  } else
    self.damagemultiplier = self.gs.damagemultiplierhealth;

  self.threatbias = int(scripts\common\gameskill::get_difficultysetting_frac("_encstr_84320B85A80B690BD3F290E8DB", var_0));
}

set_difficulty_from_locked_settings() {
  apply_difficulty_settings(1);
  scripts\common\gameskill::apply_difficulty_settings_shared(1);
}

resetskill() {
  waittillframeend;
  setskill(1);
}

wave_difficulty_update(var_0) {
  if(getdvarint("_encstr_9B571DE6B139F5DD58D9957DC8B466CC5A1BBA8D1DF2FABDEC9593C9D28CAC", -1) != -1)
    var_0 = getdvarint("_encstr_9B571DE6B139F5DD58D9957DC8B466CC5A1BBA8D1DF2FABDEC9593C9D28CAC", -1);

  var_1 = level.difficultytype[var_0];

  foreach(var_3 in level.players) {
    var_3.gs.player_attacker_accuracy = level.difficultysettings["_encstr_8CD1144CB0E6B2D759CD59D6CBFA0BC6D85DC9588D97"][var_1];
    var_3.attackeraccuracy = var_3.gs.player_attacker_accuracy;
    var_3.gs.playergrenadebasetime = int(level.difficultysettings["_encstr_BE1116D98B2A83683A9F1BF1FD115835B027570B83724120"][var_1]);
    var_3.gs.playergrenaderangetime = int(level.difficultysettings["_encstr_937917E08D2CE595278E9C2BDC0B2356492C739D2B51D2D6B2"][var_1]);
    var_3.gs.playerdoublegrenadetime = int(level.difficultysettings["_encstr_9B0918C163855E2B3988DBD5C4B1CA749359B98532CA155AADCA"][var_1]);
    var_3.gs.min_sniper_burst_delay_time = level.difficultysettings["_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2"][var_1];
    var_3.gs.max_sniper_burst_delay_time = level.difficultysettings["_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59"][var_1];
    var_3.gs.misstimeconstant = level.difficultysettings["_encstr_879611A3DF4BC621E1D539F57DDE20FDC25B19"][var_1];
    var_3.gs.misstimedistancefactor = level.difficultysettings["_encstr_9B9517AD2D379BA2A5D6CA11A5CDA32CCDB1ACC80B368EDB27"][var_1];
    var_3.gs.double_grenades_allowed = level.difficultysettings["_encstr_8EA718295277AEF8CFCF47651DF56865DF0BC631CA4B5068E7CC"][var_1];
  }

  anim.pain_test = level.difficultysettings["_encstr_99F70A0E16A59BFA1D95E647"][var_1];
  anim.min_sniper_burst_delay_time = level.difficultysettings["_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2"][var_1];
  anim.max_sniper_burst_delay_time = level.difficultysettings["_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59"][var_1];
  setsaveddvar("_encstr_B1A30B6A82A9F4A6311354A682", level.difficultysettings["_encstr_9201129BD76AE5F009B65AF5DCE3380E8247092B"][var_1]);
}

update_player_attacker_accuracy() {
  if(!isDefined(self.baseignorerandombulletdamage))
    self.baseignorerandombulletdamage = 0;

  self.ignorerandombulletdamage = self.baseignorerandombulletdamage;
  self.attackeraccuracy = self.gs.player_attacker_accuracy;
}

get_player_gameskill() {
  return level.gameskill;
}