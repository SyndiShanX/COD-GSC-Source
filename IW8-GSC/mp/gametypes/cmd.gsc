/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\cmd.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = "_encstr_B1190443FFA0";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 1200);

    if(1)
      scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 5);
    else
      scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 0);

    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::setovertimelimitdvar(300);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.disablebuddyspawn = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.ontimelimit = ::ontimelimit;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.lastcaptime = gettime();
  level.resetuiomnvargamemode = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::resetuiomnvargamemode;
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.cmdattackingteam = "_encstr_A7A408B9CA5D1D4E2C63";
  level.cmddefendingteam = "_encstr_A7A408B9CA5D1D4E2C63";
  level.timerstoppedforgamemode = 0;
  level.extratime = 0;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_87420C2C826B38C83697432A5324";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2C30DC06FBD8177D266831BFFFB5B"] = "_encstr_B2C30DC06FBD8177D266831BFFFB5B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6260B26DB5B98F51D16DAAC73"] = "_encstr_B6260B26DB5B98F51D16DAAC73";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F850A13DBDA31AF8DED6E1D"] = "_encstr_957D0F22AF0F26E910DDF7B8E7A23B2DE0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A24E0EDB8FF96A176091AF734B507E72"] = "_encstr_932B132978C232A6DA8D7BFD5168F7B3752B90760F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ACA10DAE80E31A1FC960CB8FF8C11C"] = "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB3D0DE25FE81EF7B7188A42230553"] = "_encstr_AB3D0DE25FE81EF7B7188A42230553";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA920D59E6CA6B2FAF4CDBD631FAB0"] = "_encstr_96D50DB638514326450683D863A990";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95920D7910C5AB2FB9D6A72D9ABFED"] = "_encstr_88D50D4CF6B626BE59CDB2AD2FAFC4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93E61365C8514FA84FF8120AC077A727692DFB1D55"] = "_encstr_8E061206578F71FF1FAA7830F377B34947D31D8D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84B513CA73CADABC7D98BDDAC4AF0E63B0B9D156C8"] = "_encstr_BDAF1226DED613FA959BAC6BF20E8D16DC472B91";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_86660ED8DEE0F5DB4CA6EB1B8DB76CAD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_86660ED8DEE0F5DB4CA6EB1B8DB76CAD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_85A11586ED338FC04A8BE192776DFB57BA96861B879AA9"] = "_encstr_A3A20CDB4CA9FAB26B892CCDDCCB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8EF21C069F98575236B28F0A117164AC7F08EF41316359E101BA2B84BFCB"] = "_encstr_A2E80F7A801EB7EAA0B31731B1C036F732";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_967A178DF61CBEED269AD706F55B1CEBACAB0E862785D1CA37"] = "_encstr_B1970DA85BBA260F32E58F18FB7A59";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7071EDF770AE9B883A216F31967ED68E6D3772FED72A1F5E71B08A3C26B2D18"] = "_encstr_A94A10367B5B38BDAB37C8F585E84716B1DA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A60515D0982317180B0859F616CAE1CE0D70B3EA089A18"] = "_encstr_97650B17BD28A94F3680626A28";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD4D1C367B38EBDB264DBE987D581D47C26CD67DD6E0D7CC0B9CB48C2C1A"] = "_encstr_8A740E56366A37088CA7D86813D9C177";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8BA1C51CAFB9848B6429F7B4F1FD0DC7732495E7253D0580E32FBD999C4"] = "_encstr_A6C20E1BAFA3CDAF81A8CDA7D26D18C4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B221F3648AB484519B33FB3778D6E2DA5FB7F1F27D361E199C79DC13A5445BAFA"] = "_encstr_8A57146B32A34880EDAF233DBD9508062F9B03D34BCF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A68420B268BFF755804DFF990F905D4769C2098AF019D3816B61C7D60B70A48B8758"] = "_encstr_A18215AB2F722F900909DFF2FD380A2E01BF538F339DC0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A1AF1767309A3898AAA87726716858CE5D2B0AB392F01BBDAA"] = "_encstr_B80E0A62F3927E405B5B7583";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93031E2FD8ABF75A7582698A601BA384D110B75750433F2263A7AC5257E94A4B"] = "_encstr_86010D7350936533B7BF0B0397F78A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9A451E38D23A97C0BB5290DF0FCBC9BD276AB8516AD25F59DF5003760953315F"] = "_encstr_8F4C0DC80FAB793739DF0D84F74251";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8CC21119F711F68EE4A07CB21270819FAEBB1BA8933B9CA9817D56D63BA6289F330E7"] = "_encstr_A2CB13135DE6ACE6FA95E659B6971BB01CD157E459";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A606225A80570FAD6855D7A12788352F71FA1172E821BBE93889DFFD5B48FCCBAFB30A4B"] = "_encstr_8A8D14A5B753D5F02F2FB029D5E1B81FBB1B330D6F4A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9A421538D23A97C0BB52905E0FEF6BCFE79A08E0FA9631"] = "_encstr_88D50AED2635F5C61BEDB16D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8FCD1C8DB70EF5B789A97D19D7B0E8D18536B6BE5BE0F5330B395A19160D"] = "_encstr_96D50DF6205047A05809A11053A6C0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AAB1C367B07EBB7C4D4EB64FA915999CA9B91F5B683FACC2C4ED232B01A"] = "_encstr_97CC0D92C07F46377EBDEDE6C5A0F3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B62A17FF48FA3E2F1E22A7C21F40D007B0D572920E09734747"] = "_encstr_AC240E47FA0C693533C2D13B6BE7EED0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84231EB1B70ED7DE89A6D723EB581DA31636B67DD6E0AF595707434E2C1D599B"] = "_encstr_93A7116BF810550B1FE3D7DFB74FB39CD0A164";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_855C1E8DBDC1BEED98A9F546AF91CA3356CD19BE5B1C7D56AE0E344E2CD156E6"] = "_encstr_AA261193F829918D2391287BEEB935F5E71B40";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B19B21C86FA02617E22418B671CA4D29158FA150BF58FEDBEB010D1D92F2BD11549778"] = "_encstr_A10D170842BF63E373D9067E8F4F283BA59B1B203B538B3B1F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3CD22B740331FB28D7A81D2C8BB9AED3868CF63A8689CF9FB0F993FC57932A2C1A8BF87"] = "_encstr_9A3D186F6585E2C22889424A66A8163AE9A3CFB7C135AB9AF831";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4771547EF6281C0FBCA8E3BA1FF07C9BF79ED2B8C8E80"] = "_encstr_A6960E9852DBC0D03E1293812763A895";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7871C8DDBC1F5F62653FA99AF2C1D8E1636D6AFDA38FACC589CD2322C34"] = "_encstr_936F11EE85395634DE57DCACEB58D1E8B01BB6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A62A1C8EE0B9A90F29380FB67901FDC27B88D70959E1E14E11C0CF1390B8"] = "_encstr_81C7118B79C035CAF0ABF7A7972D426ED020C7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83FA1F36ED83D7ED89A6AF99EB56E6CAAD5ED7360BC1AF6BE0FA99B0394B190BA1"] = "_encstr_8AC417CB7E5A2B1BC2EFA7832F0A5058EDD0F181A2A448CE5A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8FE320C288113957A9EA87E368110BFF434089EA20912F5FA0CFBFAE1FDBDF478360"] = "_encstr_A1B918836FE382F0203B409B69CDA59FADF3D7DF13C353068A02";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9191707AFA241B73B0A4EFB613F47893F2DA9E95A4EA05D17"] = "_encstr_953D11DB4CA9FA36DE73DC479CEAB1E8D27B37";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B46C1E41C8BFCF0F5BBAEFF3AF9A880B971A3376B5BAC90A9D29AC363FDC55F7"] = "_encstr_956314D8B7CD6ED127AE36A3B4B7DCF5C23AE816D8DA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8D81E131783F995A54D1E675959A821B74003412DA2EFD3FBCB81DA91A30773"] = "_encstr_BEDE14C218C037E390E3736CF350AD3F7DF10A2A40AD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE3C21F75F32D190ABBAFE6BF16FD8C88DB1076FF99A89E98BC1B1ABEB738E906305A7"] = "_encstr_A5031A1BF6DC9BD1C9AB6C474BBD9B7DB2DC2BADE58D0B383AAE9CB2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_867522BB0758095FD6A001CFEEBDA37F58B30F08AFE08FD709DB1952B30FF3F28041AD9B"] = "_encstr_92031B9FE7BAE6C01A3319F3DCFFE808E27B1B3B1732A7A8340B232987";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD0A156AD09B81E763D0A1FB875AF7F790DF02834366DC"] = "_encstr_B1970DA85BBA260F32E58F18FB7A59";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88021CD6E08857F2CE2D8F3A5FE59AA698688F51D8E00F5A97F55F730B9B"] = "_encstr_85A91040100DDB552BA37B2FE2AFC5E36E5A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5AD179A4097CF6DA81597E46788F287B5BB23B20BE7BB2708"] = "_encstr_BE9D08406E524F21876B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CDE1EF6C0A877D22ECD6FDABF47AB94D8A96C7138832F0AFDD1BBCB2BF5E2EB"] = "_encstr_B6C70BCCEDC4AF85E8470B36D6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA901E6CB7E0D77B4C35BED0D719563359B9C8D7DA1CF556AB07D04EB01DB2B9"] = "_encstr_8F450B523DADE69955DE554D37";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5FC128108033E9B0222874F4B59106A5C4C1B97"] = "_encstr_ADF817375F2BA28B7308DB87E1AB511B87E57B2E36713AB679";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD6A12D8F638FADE13A6FA6CDBE6E856CD8E958C"] = "_encstr_B19C0EDBC4D4D71BDEB9D159CDA35691";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ADDC0E9F374AA9FDF312901AD9EFA510"] = "_encstr_A1ED17E87BA5104B417617A78BDB655806C73810FF6C4B331A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B27F091BBDE0F5A1B7B18C"] = "_encstr_937216983FEEB1AB5335C8EE8D4BA7994BCF98D037B9E859";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2AB146CF638BEED5D8E1CBD9B8EB1B007D1EA9356C8"] = "_encstr_AD8515DEE0D8F16892E707F98FEB5BF3A80553E019979E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ABF6186CBD83AFC47BD689C163C2E6E8CA91EB5847599BB2DACB"] = "_encstr_B8D61770FFE1E653BDB31345A53DE189F329B20320788E576B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92391B97C72FE17270A866EA60E8B68B0D79DF17695C7B2118D01FF5FA"] = "_encstr_BE5D1AE63F9536235DDB42E16B2360B2D493F6A0C0F002F85B0A5833";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81D7106CED83AF26F6B513192B33AECDB291"] = "_encstr_A24915AF98190BA01BE3997EBB58251EEFF12B5368BAD7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA4A14734B7333AF1111E729B829692B89AEE11CD758"] = "_encstr_AAE0102B1C3CD8FD5327ABB3FB4BBF98D735";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD0314E64BA3C9AC0ED74CAFDAC1F59958C92D2316A1"] = "_encstr_8B2513B384947055EB8F1FC7ABE2A8484B5A798BED";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BEA414A8974463E323C90EA05DFB4F29B903F0881FE0"] = "_encstr_824312B2BB09BAD08896AE318F2B0762AA887080";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB71147F8B5B4D1D20E1EE473BA0C1680E53AB84408A"] = "_encstr_BA9E0FCDB41DE4AC07D7BBA1CD0E85BBB9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82DF14331383B0459BD1494F55DA715DE066189C7640"] = "_encstr_8C4B10EBF0E52BBF684F9B6FD38802AF8C88";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A58216AAC3915BE58B7152E7C8A3E7923BE7F462BFC9623B"] = "_encstr_8C4B10EBF0E52BBF684F9B6FD38802AF8C88";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B9A16B313605A5FF73ECF1140CF7F57B0C9503A9BC8275F"] = "_encstr_AC5912B3C869E2EF7BC00A15EEE18FEAC9107B1A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA21164B7C5CB89D334725F7E75BC858F59290E3E6A4C84E"] = "_encstr_AFB510C230B86A4237B7D743395EDBB17878";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8892163796E89359C17DCCAF5B0EFACAAB38D093C2E82B6E"] = "_encstr_95D0126E96D19CAC1CF5B1F637DC3A9B0E2CEE73";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_840F166ED23AE42B83D768BE5BC1BECABAE01AC90B3ACAB9"] = "_encstr_8E901026E1E57261AB61DD6FF6BBCBFF1F7A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9F1116CBD0EEBED93C8CAC97D2C8EE8C28DB5"] = "_encstr_BD0E0D65F398DD93AF6B734B5336CA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AE2138B70919F17B0A115D04FCBB162D17DAB8E98"] = "_encstr_91EF0FED93462B93EB992C63D826B036B5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_976817EE0FA38EBF34B21818CB0A6B811797E6DE999B90FB18"] = "_encstr_991B13B3635863122150EAA2F01F0E43515D0C3583";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8897126CF638D72BCD566BCBF513E41632C6B2CB"] = "_encstr_8DA80E4F18428183B76A8E021960A17B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2A8142EF7E9FF0B9FD7C36F98D31F63A0F2C9C34279"] = "_encstr_959910D0DB37E858B3ACF58DDE8D85E8B291";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A78B176CBD0EFA1AF6DC8E169D56F5950F1DC958C61D96ED73"] = "_encstr_82E1138210428047C75F9FA710DB1853F0651897B5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A2C11976F8A67C6A36FC7DAFB58EA8833AE28"] = "_encstr_A2B70D4C4E2B85D886FAC163B0DCA3";
  thread ongameended();
  level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"] = loadfx("_encstr_A11629ECCC3C5EEB39958BD52BB9A3DCBCAD83BE9D0BD6561C63B0E579673387D7DCB5B5AFDC2D3B372C1B");
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_84D5111B30CDF1AFB0254F6B4979A38309E883", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_A50909B1B54694AEC6CA9B"));
  setdynamicdvar("_encstr_A5B91EFBDEDD08C7C27C699F366BA8B8AA73792FBB9B216A47700F11CA7BF07A", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_A34A16B1AA4B2320D6FC53A71E777079C7A34DB9E2236D58"));
  setdynamicdvar("_encstr_84CD1CB3069219563A6347C38753AB98595B7888EDCCB099D23F61CB935A", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_BAF214856C1D5A9DB0E82DF6E688AC8D2C9724B08D99"));
  setdynamicdvar("_encstr_BA9C1CCDB19CBE6CD619FA858D8EA5B38547D27BDC88951B16F290C26E59", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_86C114AF5ED84A0C3F5B53B8C50D07C419F83EA98F75"));
  setdynamicdvar("_encstr_A7401E5F57B679EBE8F1A1B649D824130EE30BDF1D5793A9D058AE3F80907DDB", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_BADF166C161C1D57C92B44EAC9C28EB4F673A1CACD8E5927"));
  setdynamicdvar("_encstr_AF211CBB768BBF666390599290719BAF23ED14351631DBAC3FB8308AE0A5", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_9A5F14667189C02BB318A1FDF6C133DAB8E5714FB0F0"));
  setdynamicdvar("_encstr_9BF01C7FA8FBE78A1BF5190E6F09B37543303BEFD8710412479856864EDB", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_8C2E147708EF6DE58B29E11376572358EF8D2D30E32D"));
  setdynamicdvar("_encstr_9BB41B57069B67F2DD4919F8C7E294312BAB02CB026795FE9305F95720", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_8E6A13CB40F8837B7BC079947CE8B65E4D9E6B77FE"));
  setdynamicdvar("_encstr_8CB819376C27D76C6B91D71A7B63C822BA392C1DA5DEB9090BD866", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_81D11186BD8D9111AE4E851DB47B37092C36CC"));
  setdynamicdvar("_encstr_9B88196ED89CBE365B19EB43BDC64688AE9CB0A34BED37842CCD59", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_8E2111A1ED8D46445DC9B01D4BDBE690856EB2"));
  setdynamicdvar("_encstr_ADA61A9BC639FA36D68CBE355DB3D94D1C85EEDC09CA86C29D96BDE4", getmatchrulesdata("_encstr_A54F08D16A2B95B8B3C9", "_encstr_A9DE1202086F47D79B3FFFEE56C1C30EA570DA3B"));
  setdynamicdvar("_encstr_95D1186E36C9D76C5B46AF663658B31A2C0E8EAB4E2B15A5D62B", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA"));
  setdynamicdvar("_encstr_A3091BC74FF048DE401AB064747AA4A07FC7831E5AB168E8711BF0DFD8", getmatchrulesdata("_encstr_9BEB08778773D4A6BBBF", "_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60"));
  setdynamicdvar("_encstr_A1A8192E27CA3108A95949E70F0B33D37D398F57B30703C989A8D0", getmatchrulesdata("_encstr_ADFC082954FBC58E38B9", "_encstr_872E110972A365F0CA35CF9F5637682DAF0A20"));
  setdynamicdvar("_encstr_ABE611A08802495777D28EE8CE910EEBA38385", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_8218041DF5FA", 0);
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.cmdrules = scripts\mp\utility\dvars::dvarintvalue("_encstr_A50909B1B54694AEC6CA9B", 1, 1, 3);
  level.tieractivationdelay = [];
  level.tieractivationdelay[0] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_A34A16B1AA4B2320D6FC53A71E777079C7A34DB9E2236D58", 15, 0, 60);
  level.tieractivationdelay[1] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_BAF214856C1D5A9DB0E82DF6E688AC8D2C9724B08D99", 15, 0, 60);
  level.tieractivationdelay[2] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86C114AF5ED84A0C3F5B53B8C50D07C419F83EA98F75", 15, 0, 60);
  level.tiercapturetime = [];
  level.tiercapturetime[0] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_BADF166C161C1D57C92B44EAC9C28EB4F673A1CACD8E5927", 10, 0, 60);
  level.tiercapturetime[1] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_9A5F14667189C02BB318A1FDF6C133DAB8E5714FB0F0", 10, 0, 60);
  level.tiercapturetime[2] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8C2E147708EF6DE58B29E11376572358EF8D2D30E32D", 10, 0, 60);
  level.tierholdtime = [];
  level.tierholdtime[0] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8E6A13CB40F8837B7BC079947CE8B65E4D9E6B77FE", 30, 0, 60);
  level.tierholdtime[1] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_81D11186BD8D9111AE4E851DB47B37092C36CC", 30, 0, 60);
  level.tierholdtime[2] = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8E2111A1ED8D46445DC9B01D4BDBE690856EB2", 45, 0, 60);
  level.juggspawnbehavior = scripts\mp\utility\dvars::dvarintvalue("_encstr_A9DE1202086F47D79B3FFFEE56C1C30EA570DA3B", 1, 0, 3);
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA", 10, 0, 30);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60", 0, 0, 1);
  level.hvtspawnpos = scripts\mp\utility\dvars::dvarintvalue("_encstr_872E110972A365F0CA35CF9F5637682DAF0A20", 1, 0, 2);
  level.overtime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_85ED0E179550E2533320C25888191FDB", 300, 0, 300);
  scripts\mp\utility\game::setovertimelimitdvar(level.overtime);
  level.persistentbombtimer = 0;
  level.persistentdomtimer = 1;

  if(istrue(level.persistentbombtimer))
    level.bombtimer = 60;
  else
    level.bombtimer = 30;

  if(level.cmdrules == 1) {
    level.planttime = 2;
    level.defusetime = 2;
  } else {
    level.planttime = level.tiercapturetime[2];
    level.defusetime = level.tiercapturetime[2];
    level.bombtimer = 3;
  }

  level.controltoprogress = 1;
  setDvar("_encstr_93D40B313707EF7C697184C4BC", 200.0);
  level.forcedobjectiveindex = getdvarint("_encstr_87D7149BC627F5365B19EB33BD39C6ACBED2E6192B1E", -1);

  if(level.forcedobjectiveindex != -1) {
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_BE630CD7BD584DEB1888DCEFECB0", 2);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 2);
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_85730D60523A2308A47708E073FB80", 1);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
  }
}

ontimelimit() {
  if(level.cmdrules == 2) {
    if(level.cmddefendingteam != "_encstr_A7A408B9CA5D1D4E2C63")
      cmd_endgame(level.cmddefendingteam, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8F6E11DED5E883DE6ED17D9195CCCA378C5991"]);
    else
      level thread scripts\mp\gamelogic::endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
  } else if(scripts\mp\utility\game::inovertime())
    level thread scripts\mp\gamelogic::endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
  else
    level thread scripts\mp\gamelogic::endgame("_encstr_8B6D0940CC35339149DA08", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

seticonnames() {
  level.iconcapture = "_encstr_966916F0068F90489B770BE1B7822888679E796B6BFD081D";
  level.iconcontested = "_encstr_B2C518985FBFCD77B3E60B977D0A4D0B27E72038EB4D7BE9BACF";
  level.icondefend = "_encstr_814715294E5F68A90309DBA34D88809B29BF3DD4E73294";
  level.icondefusing = "_encstr_ADCE170170186DD1DFD28AF31F07D2F3B7099BDF30C82355AF";
  level.iconlosing = "_encstr_AB75152DF7376A01773FA39F7734B044087B42066CDD4A";
  level.iconneutral = "_encstr_956C16431F62A061D7FE82BB65A1A0E51943C3F3FB1BFF63";
  level.iconplanting = "_encstr_933317EA11C83B513053E1D077F8251B78EB3212D81D9FD558";
  level.icontaking = "_encstr_AAFE1522A86F35D74B2FE1E03050CB7BE7E82A9A50D52F";
  level.icontarget = "_encstr_A2BC15B4C6B737EBDD585E0EB796B98EAF1D2C3976ACA3";
}

onstartgametype() {
  seticonnames();

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_9B670F283D38CD76C3438B8DFF062DA7D5");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_9B670F283D38CD76C3438B8DFF062DA7D5");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_964615086EAD9DA5BF6883B71B556D601C7F9141DFB9ED");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_B404149E2125A8685125958A6A5E11D335F509299C2A");
  }

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");
  initspecatatorcameras();
  thread loopspectatorlocations();
  setupobjectives();
  initspawns();
  setupdestructibledoors();

  if(level.mapname == "_encstr_86C80BFFA9E82221A818377E10")
    init_mp_faridah();

  thread startgame();
  _encstr_91E429B96CE4A5078E6E795BE0E5B358DA563ACB1CAC6EF2139CC2238DAC2FBEE6072C7773954E17D9376C::inittankspawns();
}

init_mp_faridah() {
  initschoolmgturret();
  thread initksbonuscrates();
  thread initpropaganda();
}

initpropaganda() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = (435, 0, 625);
  var_1 = (0, 0, 0);
  level.propagandaent = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  level.propagandaent show();
  level.propagandaent playLoopSound("_encstr_B619213A6B38D7CA6B47AF6B077D660B39D2C80B1AEBC14EB7830BD9C2CD2358F51BC1");
}

initschoolmgturret() {
  var_0 = (260, -1415, 150);
  var_1 = (0, 90, 0);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  var_3 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_2.origin, "_encstr_831C13D1EF4317B433165ED3E15B4B37078B57051B", 0);
  var_3.angles = var_2.angles;
  var_3 linkTo(var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 16), (0, 0, 0));
  var_3 setModel("_encstr_97361AEE590B0EDEE6F55B3BAF4C392CECBDA603F5135836D87BDCE5");
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_4 = getcompleteweaponname("_encstr_831C13D1EF4317B433165ED3E15B4B37078B57051B");
  var_3.objweapon = var_4;
  var_5 = var_3 gettagorigin("_encstr_A7B5118BE17CAFCB70059A9511F912BF1D59C2");
  var_6 = scripts\mp\gameobjects::createhintobject(var_5, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_922B1009ADCF297B4732705EEB77AE182704", &"_encstr_9AD1207C0B2970EB3751DFD7818FAF789B3033E2D0FF38CE1F39A7A759676DB1EF59");
  var_6 linkTo(var_3, "_encstr_A7B5118BE17CAFCB70059A9511F912BF1D59C2", (0, 0, 5), (0, 0, 0));
  var_6 thread turretthink(var_3);
  var_3.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (255, -1425, 210));
}

turretthink(var_0) {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self makeunusable();
    var_1.prevweapon = var_1 getcurrentweapon();
    var_1.useweapon = "_encstr_831C13D1EF4317B433165ED3E15B4B37078B57051B";
    var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

    while(var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1.useweapon, 1) == 0)
      waitframe();

    var_1 controlturreton(var_0);
    thread endturretusewatch(var_1, var_0);
    thread endturretonplayer(var_1);
    self waittill("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");

    if(isDefined(var_1)) {
      var_1 controlturretoff(var_0);
      var_1 switchtoweaponimmediate(var_1.prevweapon);
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.useweapon);
    }

    self makeusable();
  }
}

endturretusewatch(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(var_0 useButtonPressed())
    waitframe();

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
      break;
    }

    waitframe();
  }
}

endturretonplayer(var_0) {
  var_0 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_8C850F1558E1177B8BC8731AE08773EFB9");
}

initksbonuscrates() {
  wait 2.0;
  var_0 = (1125, -1675, 100);
  givekscratetoteam("_encstr_9A8507BA4040188D08", var_0, "_encstr_B270105ECB28E94BC5CFABAB937D524C5053");
  var_0 = (-1150, -575, 100);
  givekscratetoteam("_encstr_9A8507BA4040188D08", var_0, "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A");
}

initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "_encstr_9B8E06A6CD13AF4B";
  var_0 = scripts\engine\utility::getStructArray("_encstr_A7B213D1BF0A90383892BEF03E708136621B7D134F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_4) {
      switch (var_6.script_label) {
        case "_encstr_A11E11297F3177A8BC8C718B399B08B94AE3FB":
          setteammapposition(var_3, game["_encstr_991C0AB9ED5B57161FE89B83"], var_6);
          break;
        case "_encstr_8C500F3ADBFAC2F02DB9EB6CB0DACA39B0":
          setteammapposition(var_3, game["_encstr_B6A70A23CA6659DC91CAE4DC"], var_6);
          break;
      }
    }
  }
}

setteammapposition(var_0, var_1, var_2) {
  if(!isDefined(level.spectatorcameras[var_0]))
    level.spectatorcameras[var_0] = [];

  level.spectatorcameras[var_0][var_1] = var_2;
}

loopspectatorlocations() {
  var_0 = 0;

  for(;;) {
    if(getdvarint("_encstr_840915A357F6079890B74927DF90C38B995FA7D30ABB17", 0) == 1) {
      if(isalive(level.players[0]))
        level.players[0] suicide();

      var_1 = getdvarint("_encstr_8C6E15D2E86287072863A03E23E87F2B10B74AE5553508", -1);

      if(var_1 != -1)
        var_0 = var_1;

      updatespectatorcamera("_encstr_B29105FAA8F367" + var_0);
      var_2 = getdvarfloat("_encstr_A10915BBE1B6EF4EF069F7D37BA89713571E4242A887AF", 1.0);
      wait(var_2);
      var_0++;

      if(var_0 > 4)
        var_0 = 0;

      if(getdvarint("_encstr_840915A357F6079890B74927DF90C38B995FA7D30ABB17", 0) == 0)
        level.players[0] notify("_encstr_A3D50C33DE93B159EBCD1CB0DDB9");

      continue;
    }

    waitframe();
  }
}

setupdestructibledoors() {
  if(!isDefined(level.destructibles) || !isDefined(level.destructibles["_encstr_A77D12CAA06F9B4BD3C604016ED8DFE9F958E223"])) {
    return;
  }
  foreach(var_1 in level.destructibles["_encstr_A77D12CAA06F9B4BD3C604016ED8DFE9F958E223"]) {
    var_2 = getdoorowner(var_1.ents[0].origin);
    var_1 scripts\mp\destructible::assigninteractteam(scripts\mp\utility\teams::getenemyteams(var_2));
  }
}

getdoorowner(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.objectives) {
    if(!isDefined(var_4.defaultownerteam)) {
      continue;
    }
    var_5 = distance2dsquared(var_0, var_4.curorigin);

    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1.defaultownerteam;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A6201A37836EEB5A593842BA1F57228FF1884BAF30431F6381CF0AB3");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_A23D18C16A81B7C00C1FC0D0CF37F8970A104B5609FB5189E2AB");
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_881E149932D9EF8844678888878F205FC2DD8113CFB3", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_9209127D37E6875DC901C3EBE83755BF999BF1FB", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(var_1 in level.objectives) {
    var_1.spawnpoints = [];
    var_1.spawnpoints[game["_encstr_991C0AB9ED5B57161FE89B83"]] = [];
    var_1.spawnpoints[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = [];
  }

  foreach(var_4 in level.spawnpoints) {
    if(isDefined(var_4.script_noteworthy)) {
      var_5 = var_4.script_noteworthy;

      if(var_4.classname == "_encstr_881E149932D9EF8844678888878F205FC2DD8113CFB3")
        level.objectives[var_5].spawnpoints[game["_encstr_991C0AB9ED5B57161FE89B83"]][level.objectives[var_5].spawnpoints[game["_encstr_991C0AB9ED5B57161FE89B83"]].size] = var_4;
      else if(var_4.classname == "_encstr_9209127D37E6875DC901C3EBE83755BF999BF1FB")
        level.objectives[var_5].spawnpoints[game["_encstr_B6A70A23CA6659DC91CAE4DC"]][level.objectives[var_5].spawnpoints[game["_encstr_B6A70A23CA6659DC91CAE4DC"]].size] = var_4;
    }
  }

  foreach(var_8, var_1 in level.objectives) {
    var_1.spawnsets = [];
    var_1.spawnsets[game["_encstr_991C0AB9ED5B57161FE89B83"]] = "_encstr_A7A111DABB8AA78B9917D266CEA1487B682A21" + var_8;
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnsets[game["_encstr_991C0AB9ED5B57161FE89B83"]], var_1.spawnpoints[game["_encstr_991C0AB9ED5B57161FE89B83"]]);
    var_1.spawnsets[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = "_encstr_BD9A0F7B4C9AA60758EE37D7853C4BE6AF" + var_8;
    scripts\mp\spawnlogic::registerspawnset(var_1.spawnsets[game["_encstr_B6A70A23CA6659DC91CAE4DC"]], var_1.spawnpoints[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]);
  }
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])
      var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];

    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8A290EB61CD76CAD327D6E0785DDE6FA" + var_0 + "_encstr_B4810709B378B9F3F5");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
    self.startspawnpoint = var_2;
  } else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, level.currentobjective.spawnsets[var_0]);

  return var_2;
}

setupobjectives() {
  level.currentobjective = undefined;
  level.objectives = [];
  setupbombzones();
  setupflags();
  setupareabrushes();
  setupteamoobtriggers();
  validateobjectives();
  thread ui_updatecmdprogress();
  thread disableobjectiveongameended();
  thread setupcaptureflares();
}

setupbombzones() {
  var_0 = getEntArray("_encstr_AF690D8368D3A74E0FA0E21BC875C7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size == 0) {
    return;
  }
  level._effect["_encstr_9A8C0F89BDDA26D7B20FC163B7E6B4DB73"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");
  level._effect["_encstr_9BF6123B2B1A5A8DC62B7DB20F0736BD6E96F6B9"] = loadfx("_encstr_99452E086F5158BE68AB4DBF6060FAEC0617407163328FFB6AD87A1FF05101E3028A6A5F5B7FB7C8DF603563D284C883");
  level._effect["_encstr_92901389CBAB79F5D84E615738AB8B589067B4EA88"] = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  level._effect["_encstr_8FEA176E88AAD7E059F9BF8ACD877A59C0F8B2A4357FF00758"] = loadfx("_encstr_BD0B40A52E583A8BE7B7C6881BAEB2B0F58C3729C2C780C2DE2BF912F167F618CC0B9387686AF89D0F23D05B1957ABE8257F0763EFD5E1D1375BA9A1215248907FD0");
  level.ddbombmodel = [];
  level.multibomb = 1;
  level.bombsplanted = 0;
  level.bombexploded = 0;
  level.bombplanted = 0;
  level.aplanted = 0;
  level.bplanted = 0;

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(var_3 == "_encstr_B84C027E")
      var_3 = "_encstr_B40703E96D";
    else
      var_3 = "_encstr_B20703DFCF";

    var_2.objectivekey = var_3;
    var_2 mapobjectiveicon();
    var_4 = _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::setupobjective(var_2);
    var_4 bombzone_ondisableobjective();
    var_4 scripts\mp\gameobjects::releaseid();
    level.objectives[var_4.objectivekey] = var_4;
    var_4.onbeginuse = ::bombzone_onbeginuse;
    var_4.onenduse = ::bombzone_onenduse;
    var_4.onuse = ::bombzone_onuseplantobject;
    var_4.ondisableobjective = ::bombzone_ondisableobjective;
    var_4.onenableobjective = ::bombzone_onenableobjective;
    var_4.onactivateobjective = ::bombzone_onactivateobjective;

    if(var_3 == "_encstr_B20703DFCF") {
      var_4 scripts\mp\gameobjects::setownerteam(game["_encstr_991C0AB9ED5B57161FE89B83"]);
      continue;
    }

    var_4 scripts\mp\gameobjects::setownerteam(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
  }
}

setupflags() {
  var_0 = getEntArray("_encstr_B19109D8BDC1F599B185CE", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_9A1412D8BD07F5CC8DB0B3FADE3B599393B44656", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size == 0) {
    return;
  }
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++)
    var_2[var_2.size] = var_0[var_3];

  var_4 = [];

  if(var_1.size > 0) {
    foreach(var_6 in var_1) {
      var_7 = var_6.script_noteworthy;
      var_4[var_7] = var_6;
    }
  }

  foreach(var_6 in var_2) {
    var_7 = var_6.script_noteworthy;

    if(isDefined(var_4[var_7]))
      var_6 = var_4[var_7];

    var_6.objectivekey = var_7;
    var_6 mapobjectiveicon(var_7);
    var_10 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_6);
    var_10.flagmodel delete();
    var_10.flagmodel = undefined;
    var_10.outlineent = undefined;
    var_10 dompoint_ondisableobjective();
    level.objectives[var_10.objectivekey] = var_10;
    var_10.onbeginuse = ::dompoint_onbeginuse;
    var_10.onuse = ::dompoint_onuse;
    var_10.onenduse = ::dompoint_onenduse;
    var_10.oncontested = ::dompoint_oncontested;
    var_10.onuncontested = ::dompoint_onuncontested;
    var_10.ondisableobjective = ::dompoint_ondisableobjective;
    var_10.onenableobjective = ::dompoint_onenableobjective;
    var_10.onactivateobjective = ::dompoint_onactivateobjective;
    var_10 thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_BA19049F4B2D", 0);
  }
}

disabledomflagscriptable() {
  thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_BA19049F4B2D", 0);
}

setupareabrushes() {
  var_0 = getEntArray("_encstr_8D4210EF80FB690B7F0DE87F83D96EB322C2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_834E1876925B5722BF3B5291F5B8DAD357C9160A98108181D7D3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEntArray("_encstr_885F17C6B738D7F4DE9BB2BEECA5E6AB588DD7CC9CB456CD8C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEntArray("_encstr_99051671C550D91ADA8BF3FF93C2E6C0199D7E092DADB053", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = getEntArray("_encstr_AFCC1DB1DEC1BEA7BDCD597D3BD237ABB0B1F5664E2D95DC8CEB07AE1BE695", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = getEntArray("_encstr_82C61C1F4FB779F2F8B02FB9AB10231387F1679F255502B9519B237D2318", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_7 in level.objectives) {
    if(isDefined(var_7.scriptable)) {
      var_7.scriptable delete();
      var_7.scriptable = undefined;
    }
  }

  if(isDefined(var_0)) {
    foreach(var_10 in var_0) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].neutralbrush))
        level.objectives[var_11].neutralbrush = [];

      level.objectives[var_11].neutralbrush[level.objectives[var_11].neutralbrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_1) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].contestedbrush))
        level.objectives[var_11].contestedbrush = [];

      level.objectives[var_11].contestedbrush[level.objectives[var_11].contestedbrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_2) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].friendlybrush))
        level.objectives[var_11].friendlybrush = [];

      level.objectives[var_11].friendlybrush[level.objectives[var_11].friendlybrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_3) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].enemybrush))
        level.objectives[var_11].enemybrush = [];

      level.objectives[var_11].enemybrush[level.objectives[var_11].enemybrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_4) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].friendlypulsebrush))
        level.objectives[var_11].friendlypulsebrush = [];

      level.objectives[var_11].friendlypulsebrush[level.objectives[var_11].friendlypulsebrush.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_5) {
      var_11 = var_10.script_noteworthy;

      if(!isDefined(level.objectives[var_11].enemypulsebrush))
        level.objectives[var_11].enemypulsebrush = [];

      level.objectives[var_11].enemypulsebrush[level.objectives[var_11].enemypulsebrush.size] = var_10;
      var_10 hide();
    }
  }
}

setupteamoobtriggers() {
  var_0 = getEntArray("_encstr_87B41061D560E9A04BF3F7FDB3B2F5280CAA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;

    if(!isDefined(level.objectives[var_3].oobtriggers))
      level.objectives[var_3].oobtriggers = [];

    if(isDefined(var_2.target)) {
      var_4 = getscriptablearray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_5 = [];

      foreach(var_7 in var_4) {
        var_8 = var_5.size;
        var_5[var_8] = var_7;

        if(isDefined(var_7.script_noteworthy)) {
          var_5[var_8].drawcount = int(var_7.script_noteworthy);
          continue;
        }

        var_5[var_8].drawcount = 1;
      }

      var_2.visuals = var_5;
      var_2 thread updateoobvisuals("_encstr_BA19049F4B2D");
    }

    level.objectives[var_3].oobtriggers[var_2.script_label] = var_2;
  }
}

validateobjectives() {
  if(level.objectives.size == 0) {} else if((level.objectives.size - 2) % 2 == 0) {}

  level.midpointobjectiveindex = int(floor((level.objectives.size - 2) / 2));
  level.currentobjectiveindex = level.midpointobjectiveindex;
  level.previousobjectiveindex = level.currentobjectiveindex;

  foreach(var_1 in level.objectives) {
    if(level.cmdrules == 1) {
      if(var_1.objectivekey == "_encstr_B20703DFCF" || var_1.objectivekey == "_encstr_B40703E96D")
        continue;
    }

    var_2 = int(var_1.objectivekey);
    var_3 = int(clamp(floor(abs(var_2 - 2)), 0, 2));
    var_1.tierindex = var_3;
    var_1.activationdelay = level.tieractivationdelay[var_3];
    var_1.captureduration = level.tiercapturetime[var_3];
    var_1.holdtime = level.tierholdtime[var_3];
    var_1 scripts\mp\gameobjects::disableobject();
    var_1.firsttime = 1;

    if(level.cmdrules == 1) {
      switch (var_3) {
        case 1:
        case 0:
          var_1 scripts\mp\gameobjects::setcapturebehavior("_encstr_92FC0B5BB01A6B73D09459526B");
          var_1.ignorestomp = 1;
          break;
        case 2:
          if(var_2 < level.midpointobjectiveindex)
            var_1.defaultownerteam = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
          else
            var_1.defaultownerteam = game["_encstr_991C0AB9ED5B57161FE89B83"];

          break;
      }

      continue;
    }

    var_1.firsttime = 1;
    var_1 scripts\mp\gameobjects::setcapturebehavior("_encstr_820E07FAE8780B3A4C");

    if(var_2 == level.midpointobjectiveindex) {
      continue;
    }
    if(var_2 < level.midpointobjectiveindex) {
      var_1.defaultownerteam = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
      continue;
    }

    var_1.defaultownerteam = game["_encstr_991C0AB9ED5B57161FE89B83"];
  }
}

startgame() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 1);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  updateteamscores();
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);

  if(level.cmdrules == 2)
    level scripts\mp\gamelogic::pausetimer();

  updatecurrentobjective(level.currentobjectiveindex);
}

updatecurrentobjective(var_0) {
  if(level.forcedobjectiveindex != -1)
    var_0 = level.forcedobjectiveindex;

  if(!isDefined(level.objectives[scripts\engine\utility::string(var_0)])) {
    return;
  }
  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective))
    level.currentobjective[[level.currentobjective.ondisableobjective]]();

  level.previousobjectiveindex = level.currentobjectiveindex;
  level.currentobjectiveindex = var_0;
  updatespectatorcamera("_encstr_B29105FAA8F367" + level.currentobjectiveindex);
  level.currentobjective = level.objectives[scripts\engine\utility::string(var_0)];
  setomnvar("_encstr_8CAF13E5091F09B377816028AB0A6B606B9760D692", var_0);
  updateoobtriggers();

  if(isDefined(level.currentobjective.onenableobjective))
    level.currentobjective[[level.currentobjective.onenableobjective]]();

  thread ui_updatecmdholdprogress();
  updateteamscores();

  if(level.currentobjective.activationdelay > 0) {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex)
      level scripts\mp\gamelogic::pausetimer();

    level.activationdelaystarttime = gettime();
    var_1 = level.currentobjective.activationdelay;
    ui_updatezonetimer(var_1);
    ui_updatezonetimerpausedness(0);
    ui_updatecmdownerteam("_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E");
    ui_updatecmdcapturestatus("_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E", 0);
    wait 3.0;
    showsplashtoteam("_encstr_AF1904A7F929", "_encstr_B84F0BCA10C77F1B0BF57F45C1");
    scripts\mp\utility\dialog::statusdialog(getvoforobjective("_encstr_9A8507BA4040188D08", "_encstr_99BA051555C8D3"), "_encstr_9A8507BA4040188D08", 1);
    scripts\mp\utility\dialog::statusdialog(getvoforobjective("_encstr_8E8405EA382B2A", "_encstr_99BA051555C8D3"), "_encstr_8E8405EA382B2A", 1);
    level.currentobjective.firsttime = 0;
    var_2 = gettime();

    foreach(var_4 in level.players)
    var_4.lastsitreptime = var_2;

    wait(var_1 - 3.0);
    level.activationdelaystarttime = undefined;
  }

  if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex)
    level scripts\mp\gamelogic::resumetimer();

  if(isDefined(level.currentobjective.onactivateobjective))
    level.currentobjective[[level.currentobjective.onactivateobjective]]();

  showsplashtoteam("_encstr_AF1904A7F929", "_encstr_85480DD87B0E7D5836A32D3B0BD1B2");
  var_6 = 0;

  switch (level.currentobjective.tierindex) {
    case 0:
      var_6 = 0;
      break;
    case 1:
      var_6 = 5;
      break;
    case 2:
      var_6 = 10;
      break;
  }

  scripts\mp\gamelogic::updatewavespawndelay(var_6);
  scripts\mp\utility\dialog::statusdialog("_encstr_A5FC128108033E9B0222874F4B59106A5C4C1B97", "_encstr_9A8507BA4040188D08", 0);
  scripts\mp\utility\dialog::statusdialog("_encstr_A5FC128108033E9B0222874F4B59106A5C4C1B97", "_encstr_8E8405EA382B2A", 0);
}

getfirsttimevoforobjective(var_0) {
  var_1 = "_encstr_8A560969F2C350806E9A57" + level.currentobjectiveindex + "_encstr_BA4C02DF" + level.mapname;
  return var_1;
}

getvoforobjective(var_0, var_1) {
  var_2 = "_encstr_B40101";
  var_3 = 0;
  var_4 = var_0 == "_encstr_9A8507BA4040188D08" && level.previousobjectiveindex > level.currentobjectiveindex || var_0 == "_encstr_8E8405EA382B2A" && level.previousobjectiveindex < level.currentobjectiveindex;

  if(var_1 == "_encstr_99BA051555C8D3" && level.currentobjective.firsttime)
    var_2 = getfirsttimevoforobjective(var_0);
  else {
    switch (level.currentobjectiveindex) {
      case 4:
      case 0:
        var_3 = 0;

        switch (var_1) {
          case "_encstr_99BA051555C8D3":
            var_2 = "_encstr_8A560969F2C350806E9A57" + level.currentobjectiveindex + scripts\engine\utility::ter_op(var_4, "_encstr_A99109AF7113A8B78F4A1E", "_encstr_9B41097D9159332BCD23EB") + level.mapname;
            break;
          case "_encstr_AB3D0DE25FE81EF7B7188A42230553":
            if(level.currentobjectiveindex == 0)
              var_2 = "_encstr_BA5A1036DE83BE89B76B89831BB0B91DAC46" + scripts\engine\utility::ter_op(var_0 == "_encstr_9A8507BA4040188D08", "_encstr_82D609AF5847959BACB6CB", "_encstr_9B850CEB581DCC275A59CD23B197");
            else
              var_2 = "_encstr_BA5A1036DE83BE89B76B89831BB0B91DAC46" + scripts\engine\utility::ter_op(var_0 == "_encstr_8E8405EA382B2A", "_encstr_82D609AF5847959BACB6CB", "_encstr_9B850CEB581DCC275A59CD23B197");

            break;
          case "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C":
            var_3 = 1;
            break;
        }

        break;
      case 3:
      case 2:
      case 1:
        switch (var_1) {
          case "_encstr_99BA051555C8D3":
            var_2 = "_encstr_8A560969F2C350806E9A57" + level.currentobjectiveindex + scripts\engine\utility::ter_op(var_4, "_encstr_A99109AF7113A8B78F4A1E", "_encstr_9B41097D9159332BCD23EB") + level.mapname;
            break;
          case "_encstr_885D0FD0B73619BEC6DB37CCD2C9DA2B19":
          case "_encstr_A9560A597395AD5EFA379536":
          case "_encstr_B6CC0586B78D46":
            var_3 = 1;
            break;
        }

        break;
    }

    if(var_2 == "_encstr_B40101") {
      if(var_3)
        var_2 = "_encstr_B29105FAA8F367" + var_1;
      else
        var_2 = "_encstr_8A560969F2C350806E9A57" + level.currentobjectiveindex + "_encstr_BA4C02DF" + var_1 + "_encstr_BA4C02DF" + level.mapname;
    }
  }

  return var_2;
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(isDefined(var_4) && scripts\mp\utility\weapon::iskillstreakweapon(var_4.basename)) {
    return;
  }
  switch (level.currentobjective.id) {
    case "_encstr_87D9083A6F628DDB5F1F":
      _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
      break;
    case "_encstr_BED80ABE90F30A6F7A40FBDF":
      _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_awardgenericbombzonemedals(var_1, self);
      break;
  }
}

onplayerconnect(var_0) {
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;

  foreach(var_2 in level.objectives) {
    if(isDefined(var_2.neutralbrush))
      var_2 hidebrushes(var_0);
  }

  var_0 thread updatefloorbrushwaitforjoined();
}

decayholdtime(var_0) {
  self endon("_encstr_85DA13C26831CB55D845D4F721C0DD43F5C02A5A53");

  for(;;) {
    if(isDefined(var_0)) {
      self.teamholdtimers[var_0] = self.teamholdtimers[var_0] - level.framedurationseconds;

      if(self.teamholdtimers[var_0] <= 0.0) {
        self.teamholdtimers[var_0] = 0.0;
        break;
      }
    }

    waitframe();
  }
}

dompoint_holdtimer(var_0, var_1) {
  level endon("_encstr_841E0AB3B0AD598AB9465946");
  self notify("_encstr_85DA13C26831CB55D845D4F721C0DD43F5C02A5A53");
  self endon("_encstr_85DA13C26831CB55D845D4F721C0DD43F5C02A5A53");
  level.inobjectiveot = 0;
  ui_updatecmdownerteam(var_0);

  if(istrue(level.persistentdomtimer)) {
    var_2 = self.teamholdtimers[var_0];
    self.holdteam = var_0;
  } else
    var_2 = level.currentobjective.holdtime;

  var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(var_2 > 0) {
    thread decayholdtime(var_0);
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_3, "_encstr_91250BD812AF23D27F60B82144"), var_3, 1);
    var_4 = 0;

    if(level.currentobjectiveindex != 2 && var_2 > 5.0) {
      var_5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var_0);

      if(isDefined(var_5)) {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5, getcapturedialog("_encstr_B1CF098D5838A3D5C95623"));
        var_4 = var_4 + var_5 getselfobjcaptureddialog("_encstr_B1CF098D5838A3D5C95623");
      }
    }

    if(var_4 > 0)
      wait(var_4);

    var_6 = 0;
    var_5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var_0);

    if(isDefined(var_5) && var_2 > 5.0 + var_4) {
      var_6 = level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5, "_encstr_B87B195FDAB0C8EA7AA86EF15BE19907EF2BBA5A81E54375CA639A");

      if(!isDefined(var_6))
        var_6 = 0;
    }

    var_4 = var_4 + var_6;
    wait(var_6);

    if(var_2 > 5.0 + var_4)
      scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_0, "_encstr_B6CC0586B78D46"), var_0, 1);

    if(var_2 - var_4 > 0)
      wait(var_2 - var_4);
    else
      wait(var_2);

    var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];

    if(istrue(level.controltoprogress) && level.currentobjective.touchlist[var_3].size > 0) {
      level.inobjectiveot = 1;
      ui_updatecmdcapturestatus("_encstr_8B6D0940CC35339149DA08", level.currentobjective.stalemate);

      for(;;) {
        if(level.currentobjective.touchlist[var_3].size == 0) {
          break;
        }

        waitframe();
      }

      level.inobjectiveot = 0;
    }
  }

  var_7 = 0;
  var_8 = level.currentobjectiveindex;

  if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    var_8--;

    if(level.currentobjectiveindex <= level.midpointobjectiveindex) {
      var_7 = 1;

      if(level.currentobjective.tierindex == 1) {
        spawnjuggcate(var_0, "_encstr_AA7B09475984AF0F6F0F0B");
        spawnjuggcate(scripts\mp\utility\game::getotherteam(var_0)[0], "_encstr_8E460991ACCC59378C56C9");
      } else if(level.currentobjective.tierindex == 0) {
        if(isDefined(level.propagandaent))
          level.propagandaent stoploopsound();
      }
    }
  } else {
    var_8++;

    if(level.currentobjectiveindex >= level.midpointobjectiveindex) {
      var_7 = 1;

      if(level.currentobjective.tierindex == 1) {
        spawnjuggcate(var_0, "_encstr_AA7B09475984AF0F6F0F0B");
        spawnjuggcate(scripts\mp\utility\game::getotherteam(var_0)[0], "_encstr_8E460991ACCC59378C56C9");
      } else if(level.currentobjective.tierindex == 0) {
        if(isDefined(level.propagandaent))
          level.propagandaent playLoopSound("_encstr_B619213A6B38D7CA6B47AF6B077D660B39D2C80B1AEBC14EB7830BD9C2CD2358F51BC1");
      }
    }
  }

  if(0 && var_7)
    scripts\mp\gamescore::giveteamscoreforobjective(var_0, 1, 0);

  if(self.tierindex == 0) {
    if(isDefined(var_1))
      var_1 thread givekillstreak("_encstr_851904B59B34", 1);
    else {
      var_5 = getclosestplayeronteam(level.currentobjective.trigger.origin, var_0);
      var_5 thread givekillstreak("_encstr_851904B59B34", 1);
    }
  }

  updateteamscores();

  if(var_2 > 0)
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_0, "_encstr_885D0FD0B73619BEC6DB37CCD2C9DA2B19"), var_0, 1);

  showsplashtoteam(var_0, "_encstr_A7491673CF90C197AF2B6B6373F5C389589DE1FD7598D507");
  showsplashtoteam(var_3, "_encstr_863E13C7BF03A810710A938BB25D60E00AD3B3537F");

  if(level.forcedobjectiveindex != -1) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_0, 1, 0);
    cmd_endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"]);
  } else if(scripts\mp\utility\game::inovertime())
    scripts\mp\gamescore::giveteamscoreforobjective(var_0, 1, 0);
  else {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex) {
      level.extratime = level.extratime + 90;
      var_9 = scripts\mp\gamelogic::gettimeremaining();
      setgameendtime(gettime() + int(var_9));
      level scripts\mp\gamelogic::resumetimer();
    }

    updatecurrentobjective(var_8);
  }
}

dompoint_cancelholdtimer() {
  if(!istrue(level.persistentdomtimer)) {
    return;
  }
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(isDefined(self.holdteam) && self.holdteam == var_0) {
    ui_updatezonetimerpausedness(1);
    self notify("_encstr_85DA13C26831CB55D845D4F721C0DD43F5C02A5A53");
    self.holdteam = undefined;
  }
}

givekscratetoteam(var_0, var_1, var_2) {}

createkscrate(var_0, var_1, var_2) {}

cratethink(var_0, var_1) {
  self endon("_encstr_A517132A055FFBA18B687763D8068882E3A674E6F6");
  self endon("_encstr_AD75063D571AE108");
  var_2 = scripts\engine\utility::drop_to_ground(self.origin + (7, 9, 0), 50, -200, (0, 0, 1));
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2 + (0, 0, 0));
  var_3 setModel("_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5");
  var_3.angles = self.angles + (-80, 120, 90);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_4.angles = self.angles + (0, 30, 0);
  var_4 playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
  waitframe();
  playFXOnTag(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 = &"_encstr_84621F6383AC13CAB1815810A15731FBE498E4F318152306E901E1F9A94F7CC77F";
  var_6 = undefined;

  switch (var_1) {
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      var_5 = &"_encstr_88D527699426C4A6154AA22869A9BE122593A2A97925AA3A74A294270AAA15F50AA43469AA82F58E13";
      var_6 = "_encstr_B8870DB2499093F968DF1F22BB60BF";
      break;
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
      var_5 = &"_encstr_84C92C50A979CD975FE68D8112C7DF841B09296932BFB247D44E95E7B7CF7F5FB3B1F4F149313C474C5588EF24D4";
      var_6 = "_encstr_88F42386D523BED28DB7B9F5DA4B8D1BB91D9C2BC2ADEB362757B4CDCAFAB54BDCDCB4C62B";
      break;
    case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
      var_5 = &"_encstr_86E62B8FE92CE499199EEF966A7F11B8D4794B674225288029B7E75A488F49769C59DBCF51DC5B88CBAF7907D9";
      var_6 = "_encstr_82D41B345D467D5A6CB773F56DB4D863CD47279516B6D7853816B1D095";
      break;
  }

  self.useobj = scripts\mp\gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 24, "_encstr_BA110C20C7C0F307EDF9111CB7A1", var_6, var_5, -1, undefined, "_encstr_BD1805CB69C063", 250, 360, 100, 360);
  self.useobj linkTo(self);

  if(var_1 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    thread gainedjuggupdater(var_0);
    thread removedjuggupdater(var_0);
  }

  for(;;) {
    self waittill("_encstr_B1CF098D5838A3D5C95623", var_7);

    if(isPlayer(var_7)) {
      var_7 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      var_7.ui_securing = undefined;
    }

    switch (var_1) {
      case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
        if(!var_7 thread givejuggernaut()) {
          continue;
        }
        break;
      case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
        var_7 thread givekillstreak("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", 1);
        wait 3.0;
        break;
      case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
        var_7 thread givekillstreak("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", 1);
        wait 3.0;
        break;
    }

    var_7 playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
    stopFXOnTag(level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"], var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_4 stoploopsound();
    var_4 delete();
    var_4 = undefined;
    var_3 delete();
    var_3 = undefined;
    scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

gainedjuggupdater(var_0) {
  self endon("_encstr_AD75063D571AE108");

  foreach(var_2 in level.players) {
    if(var_2.team == var_0 && istrue(var_2.isjuggernaut))
      self disableplayeruse(var_2);
  }

  for(;;) {
    level waittill("_encstr_AA9F129C5197F8F327B118F82ABFBB3333F91D8D", var_2);

    if(var_2.team == var_0)
      self disableplayeruse(var_2);
  }
}

removedjuggupdater(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_962013E2CD5B72FE21B0E70BAB59A79A3DD0AE5B2D", var_1);

    if(var_1.team == var_0)
      self enableplayeruse(var_1);
  }
}

givekillstreak(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_0);
  scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(var_2, "_encstr_8261067B1D34AC27");

  if(istrue(var_1)) {
    wait 0.1;
    self notify("_encstr_A25E0C6803E1FB519321F8603FBA");
  }
}

bombzone_warningklaxon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  var_0 = game["_encstr_813F06832D8A18FE"]["_encstr_861A0E1BBD387D33D2DC2CD838EA9BA1"].size;
  var_1 = randomint(var_0);

  foreach(var_3 in level.players)
  var_3 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_861A0E1BBD387D33D2DC2CD838EA9BA1"][var_1]);

  wait 2.0;
  wait 16.0;
}

bombzone_holdtimer(var_0) {
  if(!isDefined(level.currentobjective)) {
    return;
  }
  level endon("_encstr_841E0AB3B0AD598AB9465946");
  level endon("_encstr_AB3D0DE25FE81EF7B7188A42230553");
  self notify("_encstr_B4C613453F52B659FF0D314EBCD7A0FD994F23C3D3");
  self endon("_encstr_B4C613453F52B659FF0D314EBCD7A0FD994F23C3D3");
  var_1 = level.currentobjective.defaultownerteam;
  var_2 = scripts\mp\utility\game::getotherteam(level.currentobjective.defaultownerteam)[0];
  scripts\mp\objidpoolmanager::objective_show_team_progress(level.currentobjective.objidnum, var_2);
  level.timelimitoverride = 0;

  if(var_0 > 0) {
    ui_updatezonetimer(var_0);
    wait(var_0);

    if(istrue(level.controltoprogress)) {
      var_2 = scripts\mp\utility\game::getotherteam(level.currentobjective.defaultownerteam)[0];
      var_3 = 0;

      for(;;) {
        if(!var_3) {
          var_3 = 1;
          ui_updatecmdcapturestatus("_encstr_8B6D0940CC35339149DA08", level.currentobjective.stalemate);
        }

        if(level.currentobjective.touchlist[var_2].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  foreach(var_5 in level.players)
  var_5 setplayermusicstate("_encstr_AB2B19A85B7BF1B91367E7F7F3C976280DF6738DC6DE6078BABBD1");

  thread scripts\mp\music_and_dialog::suspensemusic();
  var_7 = level.currentobjectiveindex;
  var_8 = level.currentobjective scripts\mp\gameobjects::getownerteam();

  if(var_8 == game["_encstr_991C0AB9ED5B57161FE89B83"])
    var_7--;
  else
    var_7++;

  updatecurrentobjective(var_7);
}

bombhandler(var_0, var_1, var_2) {
  if(level.gameended) {
    return;
  }
  if(var_1 == "_encstr_860808CB78E2984063BA") {
    self.bombexploded = 1;
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
    scripts\mp\gamescore::giveteamscoreforobjective(var_2, 1, 0);
    cmd_endgame(var_2, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"]);
  } else {}
}

resetbombzone() {
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  self.id = "_encstr_BED80ABE90F30A6F7A40FBDF";
  self.useweapon = getcompleteweaponname("_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B");
  self.bombexploded = undefined;
}

cmd_endgame(var_0, var_1) {
  level.docmdoutro = 1;
  var_2 = undefined;

  if(level.mapname == "_encstr_86C80BFFA9E82221A818377E10") {
    var_2 = spawnStruct();

    if(var_0 == "_encstr_9A8507BA4040188D08") {
      var_2.origin = (-207, -4711, 211);
      var_2.angles = (7, 64, 0);
    } else if(var_0 == "_encstr_8E8405EA382B2A") {
      var_2.origin = (1945, 4423, 670);
      var_2.angles = (15, 244, 0);
    } else {}
  }

  foreach(var_4 in level.players) {
    if(!isai(var_4))
      var_4 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);

    var_4 thread playendofmatchtransition(var_2);
  }

  var_6 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0];
  var_7 = game["_encstr_96040B1D59B0AD35B1F64E599B"][scripts\mp\utility\game::getotherteam(var_0)[0]];

  if(var_7 > var_6) {
    var_8 = var_7 - var_6 + 1;
    scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_8, 0);
  }

  thread scripts\mp\gamelogic::endgame(var_0, var_1);
  wait 0.65;
  level notify("_encstr_AF8715E8C3C3C717AFA9274548B9B981702D0DE88307D5");
  wait 5.0;
  level notify("_encstr_AA9716B1D619FA1B7BB94796DCAE2BBE3B58D656F5B27346");
}

dompoint_onbeginuse(var_0) {
  dompoint_cancelholdtimer();
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onusebegin(var_0);
  self.didstatusnotify = 1;
  thread updateflares(var_0.team);
  ui_updatecmdcapturestatus(var_0.team, self.stalemate);

  if(var_0.team == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
    if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4) {
      var_1 = scripts\mp\gameobjects::getownerteam();

      if(var_0.team != var_1) {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, getcapturedialog("_encstr_A2260A46B118ECC3B65B3BE7"));
        var_0 getselfobjcaptureddialog("_encstr_8AD1096F4D428DC321FB3B");
      } else
        var_0 getselfobjcaptureddialog("_encstr_B669098CAC99BA6E96E63B");
    } else
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, getcapturedialog("_encstr_A2260A46B118ECC3B65B3BE7"));
  }

  var_2 = scripts\mp\utility\game::getotherteam(var_0.team)[0];

  if(var_2 == scripts\mp\gameobjects::getownerteam())
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_0.team, "_encstr_BD560A12308B65DFDE9E4950"), var_2, 0);
  else
    scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_0.team, "_encstr_A9560A597395AD5EFA379536"), var_2, 0);

  foreach(var_0 in level.players)
  updatefloorbrush(var_0);
}

dompoint_onuse(var_0) {
  if(istrue(level.persistentdomtimer)) {
    ui_updatezonetimerpausedness(0);
    self.lastcaptime = gettime();
    self.firstcapture = 0;
  }

  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse(var_0);
  var_1 = scripts\mp\gameobjects::getownerteam();
  thread updateflares(var_1);

  foreach(var_3 in level.players)
  updatefloorbrush(var_3);

  level.usestartspawns = 0;
  var_5 = scripts\mp\utility\game::getotherteam(var_1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_5, undefined, undefined, "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", "_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_0);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      level.cmdattackingteam = var_1;
      level.cmddefendingteam = var_5;
      level scripts\mp\gamelogic::pausetimer();
    } else {
      level.extratime = level.extratime + 90;
      var_6 = scripts\mp\gamelogic::gettimeremaining();
      setgameendtime(gettime() + int(var_6));
    }
  }

  if(level.currentobjectiveindex == 0) {
    var_7 = level.objectives["_encstr_B40703E96D"] scripts\mp\gameobjects::getownerteam();

    if(var_1 != var_7)
      level.objectives["_encstr_B40703E96D"] bombzone_onuseplantobject(var_0);
    else
      level.objectives["_encstr_B40703E96D"] bombzone_onusedefuseobject(var_0);
  } else if(level.currentobjectiveindex == 4) {
    var_7 = level.objectives["_encstr_B20703DFCF"] scripts\mp\gameobjects::getownerteam();

    if(var_1 != var_7)
      level.objectives["_encstr_B20703DFCF"] bombzone_onuseplantobject(var_0);
    else
      level.objectives["_encstr_B20703DFCF"] bombzone_onusedefuseobject(var_0);
  } else {
    thread dompoint_holdtimer(var_1, var_0);
    showsplashtoteam(var_1, "_encstr_96FE12B7CF73D838EF9D017E07DAF80D2A4B310B");
    showsplashtoteam(var_5, "_encstr_AB860FD8DE0EEB86EDC691AF599B95DAF2");
  }

  if(self == level.currentobjective)
    ui_updatecmdcapturestatus("_encstr_A7A408B9CA5D1D4E2C63", 0);
}

dompoint_onenduse(var_0, var_1, var_2) {
  if(self != level.currentobjective) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
  var_3 = scripts\mp\gameobjects::getownerteam();
  var_4 = scripts\engine\utility::ter_op(var_3 == "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A7C5056BD931D1", var_3);
  thread updateflares(var_4);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      var_3 = scripts\mp\gameobjects::getownerteam();
      ui_updatecmdcapturestatus("_encstr_A7A408B9CA5D1D4E2C63", 0);

      if(istrue(level.persistentdomtimer) && self.objectivekey != "_encstr_934C0218" && self.objectivekey != "_encstr_AC4C024A") {
        if(var_3 != "_encstr_A7A408B9CA5D1D4E2C63") {
          ui_updatezonetimerpausedness(0);
          self.lastcaptime = gettime();
          thread dompoint_holdtimer(var_3);
        }
      }
    }
  } else if(!var_2) {
    var_3 = scripts\mp\gameobjects::getownerteam();
    ui_updatecmdcapturestatus("_encstr_A7A408B9CA5D1D4E2C63", 0);

    if(istrue(level.persistentdomtimer) && self.objectivekey != "_encstr_934C0218" && self.objectivekey != "_encstr_AC4C024A") {
      if(var_3 != "_encstr_A7A408B9CA5D1D4E2C63") {
        ui_updatezonetimerpausedness(0);
        self.lastcaptime = gettime();
        thread dompoint_holdtimer(var_3);
      }
    }
  }

  foreach(var_1 in level.players)
  updatefloorbrush(var_1);
}

dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }
  dompoint_cancelholdtimer();
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_oncontested();
  thread updateflares("_encstr_B85C0AD87B9B8E95CD8E2B46");
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63") {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex)
      level scripts\mp\gamelogic::resumetimer();
  }

  ui_updatecmdcapturestatus(var_0, 1);
  var_1 = var_0;

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    var_1 = self.claimteam;

  if(var_1 != "_encstr_8BBA05185F8B99")
    scripts\mp\utility\dialog::statusdialog("_encstr_AD6A12D8F638FADE13A6FA6CDBE6E856CD8E958C", var_1, 0);

  foreach(var_3 in level.players)
  updatefloorbrush(var_3);
}

dompoint_onuncontested(var_0) {
  if(self != level.currentobjective) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuncontested(var_0);
  self.didstatusnotify = 1;
  var_1 = scripts\mp\gameobjects::getownerteam();

  if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    if(level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex)
      level scripts\mp\gamelogic::resumetimer();
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A7C5056BD931D1", var_1);
  thread updateflares(var_2);

  if(level.cmdrules == 2) {
    if(level.currentobjectiveindex == level.midpointobjectiveindex) {
      if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63" && self.touchlist[scripts\mp\utility\game::getotherteam(var_1)[0]].size == 0) {
        ui_updatezonetimerpausedness(0);
        self.lastcaptime = gettime();
        thread dompoint_holdtimer(var_1);
      }
    }
  } else if(istrue(level.persistentdomtimer) && level.currentobjectiveindex != 0 && level.currentobjectiveindex != 4) {
    if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63" && self.touchlist[scripts\mp\utility\game::getotherteam(var_1)[0]].size == 0) {
      ui_updatezonetimerpausedness(0);
      self.lastcaptime = gettime();
      thread dompoint_holdtimer(var_1);
    }
  }

  ui_updatecmdcapturestatus("_encstr_A7A408B9CA5D1D4E2C63", 0);

  foreach(var_4 in level.players)
  updatefloorbrush(var_4);
}

dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  scripts\engine\utility::delaythread(0.1, ::disabledomflagscriptable);
  thread updateflares("_encstr_BA19049F4B2D");

  foreach(var_1 in level.players)
  updatefloorbrush(var_1, 1);
}

dompoint_onenableobjective() {
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, 1);
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);

  if(istrue(level.persistentdomtimer)) {
    if(!isDefined(self.teamholdtimers))
      self.teamholdtimers = [];

    self.teamholdtimers["_encstr_9A8507BA4040188D08"] = self.holdtime;
    self.teamholdtimers["_encstr_8E8405EA382B2A"] = self.holdtime;
    self.firstcapture = 1;
    self.holdteam = undefined;
  }

  if(isDefined(self.defaultownerteam)) {
    scripts\mp\gameobjects::setownerteam(self.defaultownerteam);
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(self.defaultownerteam, 0);
    thread updateflares(self.defaultownerteam);
  } else {
    scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_A7C5056BD931D1", 0);
    thread updateflares("_encstr_A7C5056BD931D1");
  }

  if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4)
    thread bombzone_warningklaxon();

  if(getdvarint("_encstr_84941453788589D31BFF2C2C85025FCAE9F09B3AE05D", 0) != 0)
    _encstr_91E429B96CE4A5078E6E795BE0E5B358DA563ACB1CAC6EF2139CC2238DAC2FBEE6072C7773954E17D9376C::tryspawnneutralbradleycmd(level.currentobjectiveindex);

  foreach(var_1 in level.players)
  updatefloorbrush(var_1);
}

dompoint_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("_encstr_B2EB1E52833FA6C7D85E0914F8A0972BC9603BBB111B1E63B0BC112C8DC88374");
  var_0 = scripts\mp\gameobjects::getownerteam();
  ui_updatecmdownerteam(var_0);
  ui_updatecmdcapturestatus("_encstr_A7A408B9CA5D1D4E2C63", 0);
  scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  thread awardcapturepoints();
  level.flagcapturetime = self.captureduration;

  if(self.tierindex == 2) {
    if(level.cmdrules == 1)
      level.flagcapturetime = 5.0;

    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

  if(level.cmdrules == 1) {
    if(level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4)
      thread bombzone_holdtimer(self.holdtime);
  }
}

bombzone_onbeginuse(var_0) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onbeginuse(var_0);
}

bombzone_onenduse(var_0, var_1, var_2) {
  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onenduse(var_0, var_1, var_2);
}

bombzone_onuseplantobject(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  scripts\mp\objidpoolmanager::objective_show_team_progress(level.currentobjective.objidnum, var_1);
  showsplashtoteam("_encstr_AF1904A7F929", "_encstr_82F00CC207D9B959A066A87460D1");
  level.flagcapturetime = 15.0;

  if(istrue(level.persistentbombtimer)) {
    if(!isDefined(level.basefusetimers)) {
      level.basefusetimers = [];
      level.basefusetimers["_encstr_9A8507BA4040188D08"] = level.bombtimer;
      level.basefusetimers["_encstr_8E8405EA382B2A"] = level.bombtimer;
    }

    level.bombtimer = level.basefusetimers[var_1];
    level.lastbombplanttime = gettime();
  }

  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onuseplantobject(var_0);
  var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_823D0EC15A6B08B045F55569EC2E1865"].size;
  var_4 = randomint(var_3);

  foreach(var_6 in level.players)
  var_6 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_823D0EC15A6B08B045F55569EC2E1865"][var_4]);

  if(var_0.team == "_encstr_9A8507BA4040188D08")
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, getcapturedialog("_encstr_B41B0883B10BDCA39519"));

  if(0)
    scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, 1, 0);

  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_1, "_encstr_AB3D0DE25FE81EF7B7188A42230553"), var_1, 1);
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_2, "_encstr_AB3D0DE25FE81EF7B7188A42230553"), var_2, 1);

  if(isDefined(level.zoneendtime))
    level.zoneendtime = int(level.zoneendtime - gettime());

  if(level.cmdrules == 1)
    ui_updatebombtimer();

  ui_updatecmdownerteam(var_0.team);
}

bombzone_onusedefuseobject(var_0) {
  if(!level.bombplanted) {
    return;
  }
  showsplashtoteam("_encstr_AF1904A7F929", "_encstr_A51D0C2F326F7F1AADCE3B0E2717");
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  level.flagcapturetime = 5.0;

  if(istrue(level.persistentbombtimer))
    level.basefusetimers[var_1] = level.basefusetimers[var_1] - (gettime() - level.lastbombplanttime) / 1000;

  level.bombsplanted = level.bombsplanted - 1;

  if(self.objectivekey == "_encstr_B20703DFCF")
    level.aplanted = 0;
  else
    level.bplanted = 0;

  _encstr_A9042687EF43D3E804AA982892B7981F6A5F311B3B5AA64A27C638663EAFB0C6B38F8DBB2AC26EE0::bombzone_onusedefuseobject(var_0);

  if(scripts\mp\utility\game::getotherteam(var_0.team)[0] == "_encstr_9A8507BA4040188D08") {
    var_3 = getclosestplayeronteam(level.currentobjective.trigger.origin, scripts\mp\utility\game::getotherteam(var_0.team)[0]);

    if(isDefined(var_3))
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_3, getcapturedialog("_encstr_9A7B088CCA335D37CA91"));
  }

  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_1, "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C"), var_1, 1);
  scripts\mp\utility\dialog::statusdialog(getvoforobjective(var_2, "_encstr_ACA10DAE80E31A1FC960CB8FF8C11C"), var_2, 1);
  var_0 notify("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C" + self.objectivekey);
  self notify("_encstr_9A7B088CCA335D37CA91");
  resetbombzone();

  if(isDefined(level.zoneendtime))
    thread bombzone_holdtimer(level.zoneendtime / 1000);

  ui_updatecmdownerteam(var_0.team);
}

bombzone_ondisableobjective() {
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
}

bombzone_onenableobjective() {
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget);
}

bombzone_onactivateobjective() {
  scripts\mp\utility\sound::playsoundonplayers("_encstr_B2EB1E52833FA6C7D85E0914F8A0972BC9603BBB111B1E63B0BC112C8DC88374");
  ui_updatecmdownerteam("_encstr_A7A408B9CA5D1D4E2C63");
  ui_updatecmdcapturestatus("_encstr_A7A408B9CA5D1D4E2C63", 0);
  level.planttime = self.captureduration;
  level.defusetime = self.captureduration;
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  thread bombzone_holdtimer(self.holdtime);
}

ui_updatezonetimer(var_0) {
  level.zoneendtime = int(gettime() + 1000 * var_0);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
}

ui_updatebombtimer() {
  var_0 = int(gettime() + 1000 * level.bombtimer);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", var_0);
}

ui_updatezonetimerpausedness(var_0) {
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", var_0);
}

getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0)
      return var_3;
  }

  return var_1;
}

ui_updatecmdcapturestatus(var_0, var_1) {
  var_2 = -1;

  if(istrue(level.inobjectiveot)) {
    if(var_1)
      var_2 = -4;
    else
      var_2 = -5;
  } else if(var_1)
    var_2 = -2;
  else {
    switch (var_0) {
      case "_encstr_9A8507BA4040188D08":
        var_2 = 2;
        break;
      case "_encstr_8E8405EA382B2A":
        var_2 = 1;
        break;
      case "_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E":
        var_2 = -3;
        break;
      case "_encstr_8B6D0940CC35339149DA08":
        var_2 = -4;
        break;
      case "_encstr_83270B204F9E4157D3C463FCDB":
      default:
        break;
    }
  }

  setomnvar("_encstr_BA85143DB1D86EA7EA71AEC38B9B35BE62FF5497B70B", var_2);
}

ui_updatecmdownerteam(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "_encstr_9A8507BA4040188D08":
      var_1 = 2;
      break;
    case "_encstr_8E8405EA382B2A":
      var_1 = 1;
      break;
    case "_encstr_9651163DED73B2AF161BE85AD958474BDE9BD7465663585E":
      var_1 = -3;
      break;
    case "_encstr_83270B204F9E4157D3C463FCDB":
    default:
      break;
  }

  setomnvar("_encstr_B47812BBF4379A87178720CB0BF5D85F8D8009D1", var_1);
}

ui_updatecmdprogress() {
  for(;;) {
    if(isDefined(level.currentobjective))
      setomnvar("_encstr_A18B18EA96FAD85B91EB8D2C38A3BA3959BE0EE4DBECE42B3737", level.currentobjective scripts\mp\gameobjects::getcaptureprogress());
    else
      setomnvar("_encstr_A18B18EA96FAD85B91EB8D2C38A3BA3959BE0EE4DBECE42B3737", 0);

    waitframe();
  }
}

ui_updatecmdholdprogress() {
  self notify("_encstr_B22C1988B2F1C323A35905F5136FEDE1A54AB8299B152FBB9F538E");
  self endon("_encstr_B22C1988B2F1C323A35905F5136FEDE1A54AB8299B152FBB9F538E");

  for(;;) {
    if(isDefined(level.currentobjective) && isDefined(level.currentobjective.teamholdtimers) && isDefined(level.currentobjective.holdtime) && level.currentobjective.holdtime > 0) {
      setomnvar("_encstr_A1121DEA2DAFC6AD327D7BDD73B293D7C14E7BCEC92B3737D70B36B14B56B9", 1.0 - level.currentobjective.teamholdtimers["_encstr_9A8507BA4040188D08"] / level.currentobjective.holdtime);
      setomnvar("_encstr_A5A81BFB80AF3FED987FA7A705C872873F5BD2420BE5A7A2696BB8B117", 1.0 - level.currentobjective.teamholdtimers["_encstr_8E8405EA382B2A"] / level.currentobjective.holdtime);
    } else {
      setomnvar("_encstr_A1121DEA2DAFC6AD327D7BDD73B293D7C14E7BCEC92B3737D70B36B14B56B9", 0);
      setomnvar("_encstr_A5A81BFB80AF3FED987FA7A705C872873F5BD2420BE5A7A2696BB8B117", 0);
    }

    waitframe();
  }
}

getcurrentvalue() {
  if(!isDefined(level.currentobjective))
    return 0.5;

  var_0 = getcenterfrac(level.currentobjectiveindex);
  var_1 = 0.0;
  var_2 = level.currentobjective scripts\mp\gameobjects::getownerteam();
  var_3 = 0.0;
  var_4 = 0.03;
  var_5 = 0.0;

  if(isDefined(level.activationdelaystarttime) && level.previousobjectiveindex != level.currentobjectiveindex) {
    if(isDefined(level.currentobjective.defaultownerteam)) {
      var_1 = var_4;

      if(var_2 == "_encstr_9A8507BA4040188D08")
        var_1 = var_1 * -1.0;

      var_4 = var_4 * 2;
    }

    var_3 = 1.0;
    var_6 = gettime();
    var_7 = (var_6 - level.activationdelaystarttime) / (level.currentobjective.activationdelay * 1000);
    var_5 = (abs(getcenterfrac(level.previousobjectiveindex) - var_0) - var_4) * var_7;

    if(level.currentobjectiveindex < level.previousobjectiveindex) {
      var_5 = var_5 * -1.0;
      var_4 = var_4 * -1.0;
    }

    var_0 = getcenterfrac(level.previousobjectiveindex);
  } else {
    var_2 = level.currentobjective scripts\mp\gameobjects::getownerteam();

    if(var_2 != "_encstr_A7A408B9CA5D1D4E2C63") {
      var_1 = var_4;

      if(var_2 == "_encstr_9A8507BA4040188D08")
        var_1 = var_1 * -1.0;

      if(isDefined(level.currentobjective.claimteam) && level.currentobjective.claimteam != "_encstr_8BBA05185F8B99") {
        if(level.currentobjective.claimteam != var_2) {
          var_4 = var_4 * 2;
          var_3 = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();

          if(level.currentobjective.claimteam == "_encstr_9A8507BA4040188D08")
            var_3 = var_3 * -1.0;
        }
      }
    } else {
      var_3 = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();

      if(isDefined(level.currentobjective.claimteam) && level.currentobjective.claimteam != "_encstr_8BBA05185F8B99") {
        if(level.currentobjective.claimteam == "_encstr_9A8507BA4040188D08")
          var_3 = var_3 * -1.0;
      } else if(isDefined(level.currentobjective.lastclaimteam)) {
        if(level.currentobjective.lastclaimteam == "_encstr_9A8507BA4040188D08")
          var_3 = var_3 * -1.0;
      }
    }
  }

  return var_0 + var_1 + var_3 * var_4 + var_5;
}

getcenterfrac(var_0) {
  var_1 = 0.0;

  switch (var_0) {
    case 0:
      var_1 = 0.0;
      break;
    case 1:
      var_1 = 0.25;
      break;
    case 2:
      var_1 = 0.5;
      break;
    case 3:
      var_1 = 0.75;
      break;
    case 4:
      var_1 = 1.0;
      break;
  }

  return var_1;
}

updateteamscores() {
  if(1) {
    scripts\mp\gamescore::_setteamscore("_encstr_9A8507BA4040188D08", 0, 0);
    scripts\mp\gamescore::_setteamscore("_encstr_8E8405EA382B2A", 0, 0);
  }
}

spawnjuggcate(var_0, var_1) {
  var_2 = level.juggspawnbehavior;

  if(var_1 == "_encstr_AA7B09475984AF0F6F0F0B" && var_2 != 1 && var_2 != 3) {
    return;
  }
  if(var_1 == "_encstr_8E460991ACCC59378C56C9" && var_2 != 2 && var_2 != 3) {
    return;
  }
  if(!isDefined(level.juggcrates)) {
    level.juggcrates = [];
    level.juggcrates["_encstr_9A8507BA4040188D08"] = [];
    level.juggcrates["_encstr_8E8405EA382B2A"] = [];
  }

  if(isDefined(level.juggcrates[var_0][var_1])) {
    return;
  }
  var_3 = undefined;

  switch (level.mapname) {
    case "_encstr_86C80BFFA9E82221A818377E10":
      if(var_1 == "_encstr_AA7B09475984AF0F6F0F0B") {
        if(var_0 == "_encstr_9A8507BA4040188D08")
          var_3 = (250, -2040, 215);
        else
          var_3 = (786, 2413, 260);
      } else if(var_1 == "_encstr_8E460991ACCC59378C56C9") {
        if(var_0 == "_encstr_9A8507BA4040188D08")
          var_3 = (25, -4630, 10);
        else
          var_3 = (1480, 4375, -40);
      }

      break;
    case "_encstr_A7A009FAF3BFE16A7B2BF2":
      if(var_1 == "_encstr_AA7B09475984AF0F6F0F0B") {
        if(var_0 == "_encstr_9A8507BA4040188D08")
          var_3 = (2775, 2375, 360);
        else
          var_3 = (-60, -260, 450);
      } else if(var_1 == "_encstr_8E460991ACCC59378C56C9") {
        if(var_0 == "_encstr_9A8507BA4040188D08")
          var_3 = (-2680, -855, 250);
        else
          var_3 = (2365, 4360, 360);
      }

      break;
  }

  if(isDefined(var_3)) {
    level.juggcrates[var_0][var_1] = givekscratetoteam(var_0, var_3, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
    level.juggcrates[var_0][var_1] thread removeondeath(var_0, var_1);
  }
}

removeondeath(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  level.juggcrates[var_0][var_1] = undefined;
}

givejuggernaut() {
  if(!isPlayer(self))
    return 0;

  if(istrue(self.isjuggernaut))
    return 0;

  if(isDefined(self.lightarmorhp))
    scripts\mp\perks\perkfunctions::unsetlightarmor();

  scripts\mp\lightarmor::setlightarmorvalue(self, 500, 1, 0);
  self disableweaponpickup();
  scripts\mp\weapons::setplantedequipmentuse(0);
  scripts\common\utility::allow_offhand_weapons(0);

  if(scripts\mp\utility\perk::_hasperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B"))
    scripts\mp\utility\perk::removeperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B");

  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweapon);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self.secondaryweapon);
  var_0 = "_encstr_87131233FF6A6649CD69F8E07265AB9326AF4937";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self givemaxammo(var_0);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_0);
  scripts\mp\juggernaut::jugg_setModel();
  self.juggoverlay = newclienthudelem(self);
  self.juggoverlay.x = 0;
  self.juggoverlay.y = 0;
  self.juggoverlay.alignx = "_encstr_A5AD056A019C63";
  self.juggoverlay.aligny = "_encstr_AC190479FF92";
  self.juggoverlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.juggoverlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.juggoverlay setshader("_encstr_A9701619AE8B904F33A7AFC7FB7A0E20315E86F1D7CC1077", 640, 480);
  self.juggoverlay.sort = -10;
  self.juggoverlay.archived = 1;
  self.juggoverlay.alpha = 1.0;
  self.health = self.maxhealth;
  self.isjuggernaut = 1;
  self.movespeedscaler = 0.75;
  scripts\mp\utility\perk::giveperk("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3");
  scripts\mp\utility\perk::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\mp\utility\perk::giveperk("_encstr_884116A03B678768CF3C6DE337BF704B0AA349F0223E1363");
  thread juggernautsounds();
  thread juggremover();
  level notify("_encstr_AA9F129C5197F8F327B118F82ABFBB3333F91D8D", self);
  return 1;
}

juggernautsounds() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_823A0D15B56780187BFA0870F31F4D");

  for(;;)
    wait 3.0;
}

juggremover() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread removejuggongameended();
  thread removejuggonteamchangeordeath();
  self waittill("_encstr_8D85134BD3CDB7E02C089B48B24773C94F6BAD99AF");

  if(isDefined(self.lightarmorhp))
    scripts\mp\perks\perkfunctions::unsetlightarmor();

  self enableweaponpickup();
  scripts\mp\weapons::setplantedequipmentuse(1);
  scripts\common\utility::allow_offhand_weapons(1);
  self.juggoverlay destroy();
  scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_87131233FF6A6649CD69F8E07265AB9326AF4937");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweapon);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweapon);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.primaryweapon);
  self.movespeedscaler = 1.0;
  scripts\mp\utility\perk::removeperk("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3");
  scripts\mp\utility\perk::removeperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\mp\utility\perk::removeperk("_encstr_884116A03B678768CF3C6DE337BF704B0AA349F0223E1363");
  self.isjuggernaut = 0;
  level notify("_encstr_962013E2CD5B72FE21B0E70BAB59A79A3DD0AE5B2D", self);
  self notify("_encstr_823A0D15B56780187BFA0870F31F4D");
}

removejuggongameended() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_823A0D15B56780187BFA0870F31F4D");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8D85134BD3CDB7E02C089B48B24773C94F6BAD99AF");
}

removejuggonteamchangeordeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_823A0D15B56780187BFA0870F31F4D");
  scripts\engine\utility::_id_143A7("_encstr_AD75063D571AE108", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_A94D10C67BDC3A7D53BACE7695E4E616BA1D");
  self notify("_encstr_8D85134BD3CDB7E02C089B48B24773C94F6BAD99AF");
}

updatefloorbrush(var_0, var_1) {
  if(!isDefined(self.neutralbrush)) {
    return;
  }
  var_2 = self.ownerteam;
  var_3 = self.claimteam;
  var_4 = var_0.team;
  var_5 = var_0 ismlgspectator();

  if(var_5)
    var_4 = var_0 getmlgspectatorteam();

  if(istrue(var_1))
    hidebrushes(var_0);
  else if(istrue(self.stalemate))
    showcontestedbrush(var_0);
  else if(var_2 == "_encstr_A7A408B9CA5D1D4E2C63") {
    if(var_3 != "_encstr_8BBA05185F8B99") {
      if(var_4 == var_3)
        showfriendlybrush(var_0);
      else
        showenemybrush(var_0);
    } else
      showneutralbrush(var_0);
  } else if(var_4 == var_2)
    showfriendlybrush(var_0);
  else
    showenemybrush(var_0);

  updatecapturebrush(var_0);
}

updatecapturebrush(var_0) {
  if(1) {
    return;
  }
  if(!isDefined(self.neutralbrush)) {
    return;
  }
  var_1 = scripts\mp\gameobjects::getclaimteam();
  var_2 = var_0.team;
  var_3 = var_0 ismlgspectator();

  if(var_3)
    var_2 = var_0 getmlgspectatorteam();

  if(istrue(self.stalemate))
    hidecapturebrush(var_0);
  else if(var_1 == "_encstr_8BBA05185F8B99")
    hidecapturebrush(var_0);
  else if(var_2 == var_1)
    showfriendlycapturebrush(var_0);
  else
    showenemycapturebrush(var_0);
}

showneutralbrush(var_0) {
  foreach(var_2 in self.friendlybrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.enemybrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.contestedbrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.neutralbrush)
  var_2 showtoplayer(var_0);
}

showfriendlybrush(var_0) {
  foreach(var_2 in self.friendlybrush)
  var_2 showtoplayer(var_0);

  foreach(var_2 in self.enemybrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.contestedbrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.neutralbrush)
  var_2 hidefromplayer(var_0);
}

showenemybrush(var_0) {
  foreach(var_2 in self.friendlybrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.enemybrush)
  var_2 showtoplayer(var_0);

  foreach(var_2 in self.contestedbrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.neutralbrush)
  var_2 hidefromplayer(var_0);
}

showcontestedbrush(var_0) {
  foreach(var_2 in self.friendlybrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.enemybrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.contestedbrush)
  var_2 showtoplayer(var_0);

  foreach(var_2 in self.neutralbrush)
  var_2 hidefromplayer(var_0);
}

hidebrushes(var_0) {
  foreach(var_2 in self.friendlybrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.enemybrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.contestedbrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.neutralbrush)
  var_2 hidefromplayer(var_0);
}

showfriendlycapturebrush(var_0) {
  foreach(var_2 in self.friendlypulsebrush)
  var_2 showtoplayer(var_0);

  foreach(var_2 in self.enemypulsebrush)
  var_2 hidefromplayer(var_0);
}

showenemycapturebrush(var_0) {
  foreach(var_2 in self.friendlypulsebrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.enemypulsebrush)
  var_2 showtoplayer(var_0);
}

hidecapturebrush(var_0) {
  foreach(var_2 in self.friendlypulsebrush)
  var_2 hidefromplayer(var_0);

  foreach(var_2 in self.enemypulsebrush)
  var_2 hidefromplayer(var_0);
}

updatefloorbrushwaitforjoined() {}

applythermal() {
  self visionsetthermalforplayer("_encstr_B60A15ABAB38AB4AE13741AE77D9F75F8D4AC4EE815F1A");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

startspectatorview() {
  waitframe();
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  var_0 = level.spectatorcameras[level.currentspectatorcamref][self.team];
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self.deathspectatepos = var_1;
  self.deathspectateangles = var_2;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self getvieworigin());
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.angles = var_2;
  self.spectatorcament = var_3;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  thread dohalfwayflash();
  var_3 movecameratomappos(self, var_1, var_2);
}

dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }
  removethermal();
  thread runslamzoomonspawn();
}

updatespectatorcamera(var_0) {
  level.currentspectatorcamref = var_0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.spectatorcament)) {
      var_3 = var_2.team;
      var_4 = getdvarint("_encstr_82C8145F57B679EBE8F1A1B6493035638797CB9F3B51", -1);

      if(var_4 != -1)
        var_3 = scripts\engine\utility::ter_op(var_4 == 0, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

      var_5 = level.spectatorcameras[level.currentspectatorcamref][var_3];
      var_2.spectatorcament movecameratomappos(var_2, var_5.origin, var_5.angles);
    }
  }
}

movecameratomappos(var_0, var_1, var_2) {
  var_0 endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_3 = 1.0;
  var_4 = 1.0;
  self moveTo(var_1, 1.0, 0.5, 0.5);
  var_0 playlocalsound("_encstr_8867179032B9E625040796C93205D5E02FFAA21721E86F3D6B");
  var_0 setclienttriggeraudiozonepartialwithfade("_encstr_AC230AABDAA970F821572333", 0.5, "_encstr_AB1904853B28");
  self rotateTo(var_2, 1.0, 0.5, 0.5);
  var_0 thread startoperatorsound();
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 = var_5 * (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0.spectatorcament)) {
    self moveTo(var_1 + var_5, 15.0, 1.0, 1.0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_5, 1000);
  }
}

runslamzoomonspawn() {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self cameralinkTo(self.spectatorcament, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.2);
  self.spectatorcament moveTo(var_0, 0.5);
  self playlocalsound("_encstr_A39D1618AAE7A00982B7171B57BACE084F80C0D0153F38B0");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("_encstr_B40101", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");
  self cameraunlink();
  self.spectatorcament delete();
  wait 1.0;
  var_2 = gettime();

  if(!isDefined(self.lastsitreptime) || var_2 < self.lastsitreptime + 30000 || var_2 < level.lastteamstatustime[self.team] + 5000) {
    return;
  }
  scripts\mp\utility\dialog::sitrepdialogonplayer(getsitreplocname());
  thread playselfbattlechatter(self, "_encstr_82A713A8EAB2D599F730F0782BF786BB1FF2E82012", "_encstr_83D60E66B71B36237F8AB868D2D97DA9", 2.5, 1);
}

playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

startoperatorsound() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 0.5;
}

ongameended() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.objectives)
  var_1 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
}

playendofmatchtransition(var_0) {
  self setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", 0);
  waitframe();
  var_1 = 10;
  var_2 = var_1;

  for(var_2 = 1; var_2 <= var_1; var_2++) {
    waitframe();
    self setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", var_2 / var_1);
  }

  if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::isusingremote() && isDefined(var_0)) {
    var_3 = distance2dsquared(self.origin, var_0.origin);

    if(var_3 > 40000) {
      var_4 = self cloneplayer(0);
      var_4 startragdoll(1);
    }
  }

  thread scripts\mp\playerlogic::spawnintermission(var_0, "_encstr_AF8C0A1B6A1D6045925B4F7D");
  waitframe();
  var_1 = 4;
  var_2 = var_1;

  for(var_2 = var_1 - 1; var_2 >= 0; var_2--) {
    waitframe();
    self setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", var_2 / var_1);
  }
}

getsitreplocname() {
  var_0 = "_encstr_A614081F91EB605D2B11" + level.currentobjectiveindex + "_encstr_BA4C02DF" + level.mapname;
  return var_0;
}

getcapturedialog(var_0) {
  var_1 = "_encstr_8A560969F2C350806E9A57" + level.currentobjectiveindex + "_encstr_BA4C02DF" + var_0 + "_encstr_BA4C02DF" + level.mapname;
  return var_1;
}

getselfobjcaptureddialog(var_0) {
  var_1 = "_encstr_B40101";
  var_2 = "_encstr_B40101";
  var_3 = 0;

  switch (level.currentobjectiveindex) {
    case 0:
      if(var_0 == "_encstr_8AD1096F4D428DC321FB3B") {
        var_1 = "_encstr_91CA0C584EB62D73ECBE98B7B64C";
        var_2 = "_encstr_B4BA136CDBE0AF85E4B5B473B3AF137B6B98F591C8";
        var_3 = 1;
      } else if(var_0 == "_encstr_B669098CAC99BA6E96E63B") {
        var_1 = "_encstr_A24E0EDB8FF96A176091AF734B507E72";
        var_2 = "_encstr_BE331510B778EEC50AADDE48C7820513C307E0B80F52C1";
        var_3 = 1;
      }

      break;
    case 1:
      if(var_0 == "_encstr_A2260A46B118ECC3B65B3BE7")
        var_2 = "_encstr_B40101";
      else if(var_0 == "_encstr_B1CF098D5838A3D5C95623") {
        if(self.team == "_encstr_8E8405EA382B2A") {
          var_1 = "_encstr_965E13DE26359BCAD85D39B2917D7695372B9CA5C6";
          var_2 = "_encstr_AF6B188368D3A70F1BB8929BF86F491FA94F1C2D7E99B3D99DC0";
        } else if(level.mapname == "_encstr_86C80BFFA9E82221A818377E10") {
          var_1 = "_encstr_9BE112785DB2938D23AB6A99FCD89307C0FF8710";
          var_2 = "_encstr_BA0817566008D7B3CEA9CFD7B9F87A21B0AB4B9A59C08F9F95";
        } else {
          var_1 = "_encstr_965E13DE26359BCAD85D39B2917D7695372B9CA5C6";
          var_2 = "_encstr_AF6B188368D3A70F1BB8929BF86F491FA94F1C2D7E99B3D99DC0";
        }
      }

      break;
    case 2:
      if(var_0 == "_encstr_A2260A46B118ECC3B65B3BE7")
        var_2 = "_encstr_B40101";
      else if(var_0 == "_encstr_B1CF098D5838A3D5C95623") {
        var_1 = "_encstr_965E13DE26359BCAD85D39B2917D7695372B9CA5C6";
        var_2 = "_encstr_AF6B188368D3A70F1BB8929BF86F491FA94F1C2D7E99B3D99DC0";
      }

      break;
    case 3:
      if(var_0 == "_encstr_A2260A46B118ECC3B65B3BE7")
        var_2 = "_encstr_B40101";
      else if(var_0 == "_encstr_B1CF098D5838A3D5C95623") {
        if(level.mapname == "_encstr_86C80BFFA9E82221A818377E10") {
          var_1 = "_encstr_B24115EDC4353795B1AE4EB219F577169CAC1ADEBADC95";
          var_2 = "_encstr_BD841A8DDBE0EB77B093B243ED5DE6CAAFB15883D15D4E2BC8F54619";
        } else {
          var_1 = "_encstr_965E13DE26359BCAD85D39B2917D7695372B9CA5C6";
          var_2 = "_encstr_AF6B188368D3A70F1BB8929BF86F491FA94F1C2D7E99B3D99DC0";
        }
      }

      break;
    case 4:
      if(var_0 == "_encstr_8AD1096F4D428DC321FB3B") {
        var_1 = "_encstr_91CA0C584EB62D73ECBE98B7B64C";
        var_2 = "_encstr_B4BA136CDBE0AF85E4B5B473B3AF137B6B98F591C8";
        var_3 = 1;
      } else if(var_0 == "_encstr_B669098CAC99BA6E96E63B") {
        var_1 = "_encstr_A24E0EDB8FF96A176091AF734B507E72";
        var_2 = "_encstr_BE331510B778EEC50AADDE48C7820513C307E0B80F52C1";
        var_3 = 1;
      }

      break;
  }

  var_4 = 0;

  if(var_3 && !scripts\mp\battlechatter_mp::saidtoorecently(var_2)) {
    scripts\mp\battlechatter_mp::updatechatter(var_2);
    thread playselfbattlechatter(self, var_1, var_2, 1.5);
  } else if(!var_3)
    thread playselfbattlechatter(self, var_1, var_2, 1.5);

  var_5 = scripts\engine\utility::ter_op(self.team == "_encstr_9A8507BA4040188D08", "_encstr_8BE4053B1FD34F", "_encstr_AA8305594B131B");

  if(level.mapname == "_encstr_86C80BFFA9E82221A818377E10")
    var_5 = scripts\engine\utility::ter_op(self.team == "_encstr_9A8507BA4040188D08", "_encstr_8BE4053B1FD34F", "_encstr_918305A77EDB3B");

  var_6 = "_encstr_84690847F92EFD1A5F1F" + var_5 + "_encstr_BA4C02DF" + var_1;
  return lookupsoundlength(var_6) / 1000;
}

playselfbattlechatter(var_0, var_1, var_2, var_3, var_4) {
  if(isai(self)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_3))
    wait(var_3);

  var_5 = scripts\engine\utility::ter_op(self.team == "_encstr_9A8507BA4040188D08", "_encstr_8BE4053B1FD34F", "_encstr_AA8305594B131B");

  if(level.mapname == "_encstr_86C80BFFA9E82221A818377E10")
    var_5 = scripts\engine\utility::ter_op(var_0.team == "_encstr_9A8507BA4040188D08", "_encstr_8BE4053B1FD34F", "_encstr_918305A77EDB3B");

  var_6 = "_encstr_84690847F92EFD1A5F1F" + var_5 + "_encstr_BA4C02DF" + var_1;

  if(isDefined(var_4)) {
    var_7 = var_6;

    if(soundexists(var_7))
      var_6 = var_7;
  }

  var_0 queuedialogforplayer(var_6, var_2, 2);
}

getclosestplayeronteam(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.players) {
    if(var_5.team == var_1 && scripts\mp\utility\player::isreallyalive(var_5)) {
      var_6 = distance2dsquared(var_5.origin, var_0);

      if(!isDefined(var_3) || var_6 < var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

disableobjectiveongameended() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.ondisableobjective))
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
}

setupcaptureflares() {
  if(getdvarint("_encstr_A1E10F07FE0267970A58E7A0709122378E", 0) != 1) {
    return;
  }
  wait 2.0;
  var_0 = [];
  var_0[var_0.size] = spawnflare((350, -3580, -35), (0, -151, 0));
  var_0[var_0.size] = spawnflare((345, -3650, -35), (0, 140, 0));
  var_0[var_0.size] = spawnflare((235, -3655, -35), (0, 50, 0));
  var_0[var_0.size] = spawnflare((230, -3575, -35), (0, -40, 0));
  level.objectives["_encstr_934C0218"].scriptables = var_0;
  var_1 = [];
  var_1[var_1.size] = spawnflare((-457, -2006, 204), (0, 331, 0), 0);
  var_1[var_1.size] = spawnflare((-31, -1915, 192), (45, 48, 0), 0);
  var_1[var_1.size] = spawnflare((-319, -1706, 209), (0, 130, 0), 0);
  var_1[var_1.size] = spawnflare((-545, -1805, 207), (0, 130, 0), 0);
  var_1[var_1.size] = spawnflare((-302, -2137, 152), (0, 234, 0));
  level.objectives["_encstr_A34C02BB"].scriptables = var_1;
  var_2 = [];
  var_2[var_2.size] = spawnflare((420, -23, 17), (5, 208, 0));
  var_2[var_2.size] = spawnflare((458, 59, 109), (0, 342, 0), 0);
  var_2[var_2.size] = spawnflare((380, -267, 17), (0, 186, 0));
  var_2[var_2.size] = spawnflare((210, 126, 18), (5, 125, 0));
  var_2[var_2.size] = spawnflare((675, 118, 18), (0, 41, 0));
  var_2[var_2.size] = spawnflare((638, -180, 18), (5, 356, 0));
  var_2[var_2.size] = spawnflare((417, 105, 69), (75, 285, 0), 0);
  var_2[var_2.size] = spawnflare((426, -177, 17), (5, 73, 0), 0);
  var_2[var_2.size] = spawnflare((509, -116, 69), (55, 82, 0), 0);
  var_2[var_2.size] = spawnflare((331, 60, 63), (0, 309, 0), 0);
  var_2[var_2.size] = spawnflare((578, 65, 62), (40, 197, 0), 0);
  level.objectives["_encstr_A74C0222"].scriptables = var_2;
  var_3 = [];
  var_3[var_3.size] = spawnflare((812, 2074, 222), (35, 326, 0), 0);
  var_3[var_3.size] = spawnflare((431, 1882, 241), (5, 86, 0), 0);
  var_3[var_3.size] = spawnflare((762, 2333, 226), (15, 345, 0), 0);
  var_3[var_3.size] = spawnflare((609, 1861, 223), (65, 339, 0), 0);
  var_3[var_3.size] = spawnflare((580, 2150, 212), (0, 272, 0), 0);
  level.objectives["_encstr_A14C023B"].scriptables = var_3;
  var_4 = [];
  var_4[var_4.size] = spawnflare((1300, 3335, 12), (0, 40, 0));
  var_4[var_4.size] = spawnflare((1305, 3430, -2), (0, -47, 0));
  var_4[var_4.size] = spawnflare((1430, 3435, -3), (0, -135, 0));
  var_4[var_4.size] = spawnflare((1430, 3350, 3), (0, 140, 0));
  level.objectives["_encstr_AC4C024A"].scriptables = var_4;

  if(getdvarint("_encstr_A9E81523903ADFF30F589F9713FF3B9F17C7312D8E3BE2", 0) == 1)
    thread debugcaptureflares();
}

spawnflare(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2)
    var_3 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));

  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3 + (0, 0, 2));
  var_4.angles = var_1 + (0, 180, 0);
  var_4 setModel("_encstr_A221163A6F3309E0B7E590EB6B3F264E2BECBAE46AF314A1");
  return var_4;
}

updateflares(var_0) {
  if(getdvarint("_encstr_A1E10F07FE0267970A58E7A0709122378E", 0) != 1) {
    return;
  }
  self notify("_encstr_B1830D503B9CD919BA77E96752925F");
  self endon("_encstr_B1830D503B9CD919BA77E96752925F");

  while(!isDefined(self.scriptables))
    waitframe();

  foreach(var_2 in self.scriptables)
  var_2 setscriptablepartstate("_encstr_912B0778976260C323", var_0);
}

debugcaptureflares() {
  var_0 = 0;

  for(;;) {
    var_1 = 0;

    switch (var_0) {
      case 0:
        var_1 = "_encstr_9A8507BA4040188D08";
        break;
      case 1:
        var_1 = "_encstr_8E8405EA382B2A";
        break;
      case 2:
        var_1 = "_encstr_B85C0AD87B9B8E95CD8E2B46";
        break;
      case 3:
        var_1 = "_encstr_A7C5056BD931D1";
        break;
    }

    foreach(var_3 in level.objectives) {
      if(!isDefined(var_3.scriptables)) {
        continue;
      }
      foreach(var_5 in var_3.scriptables)
      var_5 setscriptablepartstate("_encstr_912B0778976260C323", var_1);
    }

    var_0++;

    if(var_0 > 3)
      var_0 = 0;

    wait 3.0;
  }
}

mapobjectiveicon(var_0) {
  switch (level.mapname) {
    case "_encstr_86C80BFFA9E82221A818377E10":
      switch (self.objectivekey) {
        case "_encstr_934C0218":
          self.iconname = "_encstr_830D0AEBC47B6B31DC964756";
          break;
        case "_encstr_A34C02BB":
          self.iconname = "_encstr_B24B085FB84940DAEF01";
          break;
        case "_encstr_A74C0222":
          self.iconname = "_encstr_B8410C4102BAB0E8BB5B9DFF67E3";
          break;
        case "_encstr_A14C023B":
          self.iconname = "_encstr_BA400B4FB421C35FD180A3DBC8";
          break;
        case "_encstr_AC4C024A":
          self.iconname = "_encstr_830D0AEBC47B6B31DC964756";
          break;
        default:
          self.iconname = "_encstr_B40101";
          break;
      }

      break;
    default:
      switch (self.objectivekey) {
        case "_encstr_934C0218":
          self.iconname = "_encstr_8CE109F9C12B467226CB9F";
          break;
        case "_encstr_A34C02BB":
          self.iconname = "_encstr_8CE109F9C12B467226CB9F";
          break;
        case "_encstr_A74C0222":
          self.iconname = "_encstr_8CE109F9C12B467226CB9F";
          break;
        case "_encstr_A14C023B":
          self.iconname = "_encstr_8CE109F9C12B467226CB9F";
          break;
        case "_encstr_AC4C024A":
          self.iconname = "_encstr_8CE109F9C12B467226CB9F";
          break;
        default:
          self.iconname = "_encstr_B40101";
          break;
      }

      break;
  }
}

updateoobtriggers() {
  if(!isDefined(level.currentobjective.oobtriggers)) {
    return;
  }
  level notify("_encstr_AAB812BA07192C3ACA9ED3482A272D9DD99593E6");

  foreach(var_1 in level.players) {
    if(isDefined(level.currentobjective.oobtriggers["_encstr_9A8507BA4040188D08"]))
      level.currentobjective.oobtriggers["_encstr_9A8507BA4040188D08"] thread updateoobvisuals("_encstr_8E8405EA382B2A");

    if(isDefined(level.currentobjective.oobtriggers["_encstr_8E8405EA382B2A"]))
      level.currentobjective.oobtriggers["_encstr_8E8405EA382B2A"] thread updateoobvisuals("_encstr_9A8507BA4040188D08");
  }
}

updateoobvisuals(var_0) {
  self notify("_encstr_B47E1183D3F8B9937D57FFB31D13ABE588F8BA");
  self endon("_encstr_B47E1183D3F8B9937D57FFB31D13ABE588F8BA");

  while(!isDefined(self.visuals))
    waitframe();

  foreach(var_2 in self.visuals) {
    for(var_3 = 0; var_3 < var_2.drawcount; var_3++)
      var_2 setscriptablepartstate("_encstr_917509E648C510D3A7781F" + var_3, var_0);
  }

  level waittill("_encstr_AAB812BA07192C3ACA9ED3482A272D9DD99593E6");

  foreach(var_2 in self.visuals) {
    for(var_3 = 0; var_3 < var_2.drawcount; var_3++)
      var_2 setscriptablepartstate("_encstr_917509E648C510D3A7781F" + var_3, "_encstr_BA19049F4B2D");
  }
}

awardcapturepoints() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  level endon("_encstr_83DD1A1BAF8E40FDC7D2B33BFB6B2509A519BDB933BAB0304B4A0841");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    var_2 = 0.0;

    while(var_2 < var_0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 = var_2 + level.framedurationseconds;

      if(self.stalemate)
        var_2 = 0.0;
    }

    var_3 = self.claimteam;

    if(var_3 == "_encstr_8BBA05185F8B99") {
      continue;
    }
    if(!self.stalemate) {
      foreach(var_5 in self.touchlist[var_3])
      var_5.player thread scripts\mp\utility\points::giveunifiedpoints("_encstr_88400B20CA22FF68F30FE06E02");
    }
  }
}

showsplashtoteam(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_0 == "_encstr_AF1904A7F929" || var_3.team == var_0)
      var_3 thread scripts\mp\hud_message::showsplash(var_1);
  }
}