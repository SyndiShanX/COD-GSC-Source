/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tweakables.gsc
***********************************************/

gettweakabledvarvalue(var_0, var_1) {
  switch (var_0) {
    case "_encstr_8C1F05DAFD911A":
      var_2 = level.rules[var_1].dvar;
      break;
    case "_encstr_B472054FE12550":
      var_2 = level.gametweaks[var_1].dvar;
      break;
    case "_encstr_8AEF05472BC2D6":
      var_2 = level.teamtweaks[var_1].dvar;
      break;
    case "_encstr_8BB007E03658CBCAE4":
      var_2 = level.playertweaks[var_1].dvar;
      break;
    case "_encstr_959506B911C79707":
      var_2 = level.classtweaks[var_1].dvar;
      break;
    case "_encstr_AC20072B9FA9487832":
      var_2 = level.weapontweaks[var_1].dvar;
      break;
    case "_encstr_B67B0A1A2C279107DBB49BA3":
      var_2 = level.hardpointtweaks[var_1].dvar;
      break;
    case "_encstr_88190486BA32":
      var_2 = level.hudtweaks[var_1].dvar;
      break;
    default:
      var_2 = undefined;
      break;
  }

  var_3 = getdvarint(var_2);
  return var_3;
}

gettweakabledvar(var_0, var_1) {
  switch (var_0) {
    case "_encstr_8C1F05DAFD911A":
      var_2 = level.rules[var_1].dvar;
      break;
    case "_encstr_B472054FE12550":
      var_2 = level.gametweaks[var_1].dvar;
      break;
    case "_encstr_8AEF05472BC2D6":
      var_2 = level.teamtweaks[var_1].dvar;
      break;
    case "_encstr_8BB007E03658CBCAE4":
      var_2 = level.playertweaks[var_1].dvar;
      break;
    case "_encstr_959506B911C79707":
      var_2 = level.classtweaks[var_1].dvar;
      break;
    case "_encstr_AC20072B9FA9487832":
      var_2 = level.weapontweaks[var_1].dvar;
      break;
    case "_encstr_B67B0A1A2C279107DBB49BA3":
      var_2 = level.hardpointtweaks[var_1].dvar;
      break;
    case "_encstr_88190486BA32":
      var_2 = level.hudtweaks[var_1].dvar;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

gettweakablevalue(var_0, var_1) {
  switch (var_0) {
    case "_encstr_8C1F05DAFD911A":
      var_2 = level.rules[var_1].value;
      break;
    case "_encstr_B472054FE12550":
      var_2 = level.gametweaks[var_1].value;
      break;
    case "_encstr_8AEF05472BC2D6":
      var_2 = level.teamtweaks[var_1].value;
      break;
    case "_encstr_8BB007E03658CBCAE4":
      var_2 = level.playertweaks[var_1].value;
      break;
    case "_encstr_959506B911C79707":
      var_2 = level.classtweaks[var_1].value;
      break;
    case "_encstr_AC20072B9FA9487832":
      var_2 = level.weapontweaks[var_1].value;
      break;
    case "_encstr_B67B0A1A2C279107DBB49BA3":
      var_2 = level.hardpointtweaks[var_1].value;
      break;
    case "_encstr_88190486BA32":
      var_2 = level.hudtweaks[var_1].value;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

gettweakablelastvalue(var_0, var_1) {
  switch (var_0) {
    case "_encstr_8C1F05DAFD911A":
      var_2 = level.rules[var_1].lastvalue;
      break;
    case "_encstr_B472054FE12550":
      var_2 = level.gametweaks[var_1].lastvalue;
      break;
    case "_encstr_8AEF05472BC2D6":
      var_2 = level.teamtweaks[var_1].lastvalue;
      break;
    case "_encstr_8BB007E03658CBCAE4":
      var_2 = level.playertweaks[var_1].lastvalue;
      break;
    case "_encstr_959506B911C79707":
      var_2 = level.classtweaks[var_1].lastvalue;
      break;
    case "_encstr_AC20072B9FA9487832":
      var_2 = level.weapontweaks[var_1].lastvalue;
      break;
    case "_encstr_B67B0A1A2C279107DBB49BA3":
      var_2 = level.hardpointtweaks[var_1].lastvalue;
      break;
    case "_encstr_88190486BA32":
      var_2 = level.hudtweaks[var_1].lastvalue;
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

settweakabledvar(var_0, var_1, var_2) {
  switch (var_0) {
    case "_encstr_8C1F05DAFD911A":
      var_3 = level.rules[var_1].dvar;
      break;
    case "_encstr_B472054FE12550":
      var_3 = level.gametweaks[var_1].dvar;
      break;
    case "_encstr_8AEF05472BC2D6":
      var_3 = level.teamtweaks[var_1].dvar;
      break;
    case "_encstr_8BB007E03658CBCAE4":
      var_3 = level.playertweaks[var_1].dvar;
      break;
    case "_encstr_959506B911C79707":
      var_3 = level.classtweaks[var_1].dvar;
      break;
    case "_encstr_AC20072B9FA9487832":
      var_3 = level.weapontweaks[var_1].dvar;
      break;
    case "_encstr_B67B0A1A2C279107DBB49BA3":
      var_3 = level.hardpointtweaks[var_1].dvar;
      break;
    case "_encstr_88190486BA32":
      var_3 = level.hudtweaks[var_1].dvar;
      break;
    default:
      var_3 = undefined;
      break;
  }

  setDvar(var_3, var_2);
}

settweakablevalue(var_0, var_1, var_2) {
  switch (var_0) {
    case "_encstr_8C1F05DAFD911A":
      level.rules[var_1].value = var_2;
      break;
    case "_encstr_B472054FE12550":
      level.gametweaks[var_1].value = var_2;
      break;
    case "_encstr_8AEF05472BC2D6":
      level.teamtweaks[var_1].value = var_2;
      break;
    case "_encstr_8BB007E03658CBCAE4":
      level.playertweaks[var_1].value = var_2;
      break;
    case "_encstr_959506B911C79707":
      level.classtweaks[var_1].value = var_2;
      break;
    case "_encstr_AC20072B9FA9487832":
      level.weapontweaks[var_1].value = var_2;
      break;
    case "_encstr_B67B0A1A2C279107DBB49BA3":
      level.hardpointtweaks[var_1].value = var_2;
      break;
    case "_encstr_88190486BA32":
      level.hudtweaks[var_1].v = var_2;
      break;
    default:
      break;
  }
}

settweakablelastvalue(var_0, var_1, var_2) {
  switch (var_0) {
    case "_encstr_8C1F05DAFD911A":
      level.rules[var_1].lastvalue = var_2;
      break;
    case "_encstr_B472054FE12550":
      level.gametweaks[var_1].lastvalue = var_2;
      break;
    case "_encstr_8AEF05472BC2D6":
      level.teamtweaks[var_1].lastvalue = var_2;
      break;
    case "_encstr_8BB007E03658CBCAE4":
      level.playertweaks[var_1].lastvalue = var_2;
      break;
    case "_encstr_959506B911C79707":
      level.classtweaks[var_1].lastvalue = var_2;
      break;
    case "_encstr_AC20072B9FA9487832":
      level.weapontweaks[var_1].lastvalue = var_2;
      break;
    case "_encstr_B67B0A1A2C279107DBB49BA3":
      level.hardpointtweaks[var_1].lastvalue = var_2;
      break;
    case "_encstr_88190486BA32":
      level.hudtweaks[var_1].lastvalue = var_2;
      break;
    default:
      break;
  }
}

registertweakable(var_0, var_1, var_2, var_3) {
  if(isstring(var_3))
    var_3 = getDvar(var_2, var_3);
  else
    var_3 = getdvarint(var_2, var_3);

  switch (var_0) {
    case "_encstr_8C1F05DAFD911A":
      if(!isDefined(level.rules[var_1]))
        level.rules[var_1] = spawnStruct();

      level.rules[var_1].value = var_3;
      level.rules[var_1].lastvalue = var_3;
      level.rules[var_1].dvar = var_2;
      break;
    case "_encstr_B472054FE12550":
      if(!isDefined(level.gametweaks[var_1]))
        level.gametweaks[var_1] = spawnStruct();

      level.gametweaks[var_1].value = var_3;
      level.gametweaks[var_1].lastvalue = var_3;
      level.gametweaks[var_1].dvar = var_2;
      break;
    case "_encstr_8AEF05472BC2D6":
      if(!isDefined(level.teamtweaks[var_1]))
        level.teamtweaks[var_1] = spawnStruct();

      level.teamtweaks[var_1].value = var_3;
      level.teamtweaks[var_1].lastvalue = var_3;
      level.teamtweaks[var_1].dvar = var_2;
      break;
    case "_encstr_8BB007E03658CBCAE4":
      if(!isDefined(level.playertweaks[var_1]))
        level.playertweaks[var_1] = spawnStruct();

      level.playertweaks[var_1].value = var_3;
      level.playertweaks[var_1].lastvalue = var_3;
      level.playertweaks[var_1].dvar = var_2;
      break;
    case "_encstr_959506B911C79707":
      if(!isDefined(level.classtweaks[var_1]))
        level.classtweaks[var_1] = spawnStruct();

      level.classtweaks[var_1].value = var_3;
      level.classtweaks[var_1].lastvalue = var_3;
      level.classtweaks[var_1].dvar = var_2;
      break;
    case "_encstr_AC20072B9FA9487832":
      if(!isDefined(level.weapontweaks[var_1]))
        level.weapontweaks[var_1] = spawnStruct();

      level.weapontweaks[var_1].value = var_3;
      level.weapontweaks[var_1].lastvalue = var_3;
      level.weapontweaks[var_1].dvar = var_2;
      break;
    case "_encstr_B67B0A1A2C279107DBB49BA3":
      if(!isDefined(level.hardpointtweaks[var_1]))
        level.hardpointtweaks[var_1] = spawnStruct();

      level.hardpointtweaks[var_1].value = var_3;
      level.hardpointtweaks[var_1].lastvalue = var_3;
      level.hardpointtweaks[var_1].dvar = var_2;
      break;
    case "_encstr_88190486BA32":
      if(!isDefined(level.hudtweaks[var_1]))
        level.hudtweaks[var_1] = spawnStruct();

      level.hudtweaks[var_1].value = var_3;
      level.hudtweaks[var_1].lastvalue = var_3;
      level.hudtweaks[var_1].dvar = var_2;
      break;
  }
}

init() {
  level.clienttweakables = [];
  level.tweakablesinitialized = 1;
  level.rules = [];
  level.gametweaks = [];
  level.teamtweaks = [];
  level.playertweaks = [];
  level.classtweaks = [];
  level.weapontweaks = [];
  level.hardpointtweaks = [];
  level.hudtweaks = [];
  registertweakable("_encstr_B472054FE12550", "_encstr_8F170C57538A2E88D8F7FB901DB4", "_encstr_96E9159EFE039FF179A720F96782C91F9AA21DA6D48AA1", 20);
  registertweakable("_encstr_B472054FE12550", "_encstr_BA5F1176E40BC695382BC94BDB327DD8EDD638", "_encstr_A5021A9B36E4FA9D856BACF53BC9588DB2E02B4EA5BD23AFB1ED5B38", 30);
  registertweakable("_encstr_B472054FE12550", "_encstr_8DEF0E30E63BA241CF8A8030326521BB", "_encstr_B80817528380F1C006B5F5B17015F9AF7B43891F3BA457F31A", 0);
  registertweakable("_encstr_B472054FE12550", "_encstr_AA820D597390A73BE74BE15B26FEA2", "_encstr_86E7166FB8EBF7DA7301E7117F01229F1350BF9B582101A2", 1);
  registertweakable("_encstr_B472054FE12550", "_encstr_813D0DBF280F4875CF0391BBBBE3A5", "_encstr_BE2516DB6F38792F07109239BBE77F2EA0D35455A9987AEF", 1);
  registertweakable("_encstr_B472054FE12550", "_encstr_8DCC1157845BED1F3ADB20901347EFBBC724ED", "_encstr_8D711AF8DB2640CF4E2A3D4F7F4103675F8BC2504AA3A5539CA8984D", 0);
  registertweakable("_encstr_B472054FE12550", "_encstr_B8030F3F95EB6B583B40E7F3F0D0074367", "_encstr_B455180E100E50BFB2C36A6E705F2FC9418B40D456E36C6AB3C8", 0);
  registertweakable("_encstr_B472054FE12550", "_encstr_95E7116E5DD28D9623590EB79637A336ED6EB9", "_encstr_BAE01A6E369CD776856B56BECDEA2DB19623B2E0ED2D9B47D8B76EDC", 0);
  registertweakable("_encstr_8AEF05472BC2D6", "_encstr_A64512E8CA58AD6D4BB136C1DE4BE61D36F69BCD", "_encstr_95071B6EC6E47D3A2B58B6FAD1592CDAD696361BC1DBA5371D36BDCD37", 0);
  registertweakable("_encstr_8AEF05472BC2D6", "_encstr_B6270766991D5E0759", "_encstr_A621104F98CBD7CB5B27C5719C7583A9D3C0", 0);
  registertweakable("_encstr_8AEF05472BC2D6", "_encstr_93D513E05BBF6FF84878800380F9440388CD23506F", "_encstr_A6A51C6EB193FAE82B0BADF5E8B285B5ADD2638DB90758BB3746AC1B2C97", 0);
  registertweakable("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A", "_encstr_856E15E68D93D7E0D80BF25639FADA163CA1AC0B8DD134", 100);
  registertweakable("_encstr_8BB007E03658CBCAE4", "_encstr_A5510A30AA778D28B3C97D51", "_encstr_BE7315A211E8277359AB87CFB5E8FA51B89BD2EBC9A0A4", 0);
  registertweakable("_encstr_8BB007E03658CBCAE4", "_encstr_8F731442B0C02C22FF93D7AFC1148A7CB859BECA28C0", "_encstr_86A61F93C99ED7B2D07BB9AD3521FA4F46836A3A90FDF768B873D4A72308028760", "_encstr_8BBA05185F8B99");
  registertweakable("_encstr_8BB007E03658CBCAE4", "_encstr_823F10A0FA2F91A384EA5B47E5EDC8EBE712", "_encstr_874F1B0F078649C8D081F8C7DB71E822D7819B9BCDA57295A84BF4CDD1", 6);
  registertweakable("_encstr_8BB007E03658CBCAE4", "_encstr_B86B0D2570C53FAA82811F4872C4E2", "_encstr_BD781816114E3717BA7E6371622989074D6381C601A033E25018", 1);
  registertweakable("_encstr_8BB007E03658CBCAE4", "_encstr_8E9A129B0178B77741D0E27AFBAF8F2BE0830D15", "_encstr_81EB1DCD36C9FAC11B58E55627D76EE84EACC2DAA537B3DD0B96D147D25B95", 5);
  registertweakable("_encstr_AC20072B9FA9487832", "_encstr_86680A58D8D8F6DDCC272C3B", "_encstr_8817165F88DBC7EB6B17B26D8877C28C6080D783B8113753", 1);
  registertweakable("_encstr_AC20072B9FA9487832", "_encstr_83FB0B168D63DBEECDD6B75BAC", "_encstr_81EF16CD36C9FADD5958C1F6E6D72CD88DEDEEE6B5B7B595", 1);
  registertweakable("_encstr_AC20072B9FA9487832", "_encstr_B48E0BCE18F0FFFBB459FFBFB9", "_encstr_AD1C166BDE7AF1B4429FC1F78BC9F7300CB5934185D158E3", 1);
  registertweakable("_encstr_AC20072B9FA9487832", "_encstr_8D1B082CB1B1DBBBB1D0", "_encstr_8FE513B3E9BEF753B85BD0C76D419E63E9ED8B3A9B", 1);
  registertweakable("_encstr_AC20072B9FA9487832", "_encstr_99130FD711FAC037BF19EE08389F76A753", "_encstr_862B1A82EE85911FC178BB3FF87EC16A61700B3EC1CB8B5DA8C8E747", 1);
  registertweakable("_encstr_AC20072B9FA9487832", "_encstr_97C10A37E43B607F0A9B9830", "_encstr_ADBC1520CB937FF707A9037842015BFAA0302FD3C8AAF0", 1);
  registertweakable("_encstr_AC20072B9FA9487832", "_encstr_BE500B4A8548B7C3ED087073D7", "_encstr_8DF2162037CA5E5FFAFEA7201571BBE00CEFF858877E510F", 1);
  registertweakable("_encstr_B67B0A1A2C279107DBB49BA3", "_encstr_AA8F0F872DF2EFC349EBB858BB6C590D4B", "_encstr_A3451D86238BAE99167378E09A2C5D03E7C981F1B737D1F53BAA3008D2024B", 1);
  registertweakable("_encstr_B67B0A1A2C279107DBB49BA3", "_encstr_8D6B09C28DD8DEBBAE85D9", "_encstr_B61517E6867BE758318360B88F41D0F9F1AED1E11DC34BA10E", 1);
  registertweakable("_encstr_B67B0A1A2C279107DBB49BA3", "_encstr_A5200C87B0E0123C500349B215FB", "_encstr_A3E31A27A3224183378B2993622F48D0B13991E147CB98551BC320BA", 1);
  registertweakable("_encstr_B67B0A1A2C279107DBB49BA3", "_encstr_B6A810588D36DEBB86B2B1A5D87B1C1D2BE4", "_encstr_BE481EB96C93FAA10B9323077B5AB9E8AFB08D8DBDEE34AC632D36BD1CD1CA27", 1);
  registertweakable("_encstr_88190486BA32", "_encstr_BDB00D37D0F6BB7B899A2D1BDECD6E", "_encstr_9383147DA1B7C03BCF2978A80223D7598B598EF80EBF", 1);
  setDvar("_encstr_9383147DA1B7C03BCF2978A80223D7598B598EF80EBF", 1);
}