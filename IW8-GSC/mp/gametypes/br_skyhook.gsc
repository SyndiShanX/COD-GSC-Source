/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_skyhook.gsc
***********************************************/

init() {
  if(!getdvarint("_encstr_AF5F159BB1C9FA6E5BCB86DEEDB5B9AF569B2C891B958C", 0)) {
    return;
  }
  isplatepouch();
  initanimtree();
  tr_vis_radius_override_lod2();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_B1781B083BC11A4ACB44A858C1061BDA1BAD6E1A47CDE1D951C188CCF7", ::_id_1284A);
  scripts\engine\scriptable::_id_12F5B("_encstr_88B708B9DA2F0DF6EDAD", ::_id_13409);
  scripts\engine\scriptable::_id_12F5B("_encstr_AB561186E4ABE9D85F87D950AB7C5115F20EFD", ::_encstr_A9A51CB67BF718C7C592A8502A9E9BD1A71BBE23D86BE125ED5A88A00277);
  scripts\engine\scriptable::_id_12F5A(::_encstr_960222DCD8392D073A164C1B2BEB6EB59734DBB7D67DC1B12CD89546FA3216B558B3CA46);
  scripts\mp\utility\sound::besttime("_encstr_99210ECA5CD55A1CD7CD6DE5D0BDB7D6");
  level thread _id_13406();
}

tr_vis_radius_override_lod2() {
  level._id_13400 = spawnStruct();
  level._id_13400.chopper_boss_destroyed_func = getdvarint("_encstr_AF5F159BB1C9FA6E5BCB86DEEDB5B9AF569B2C891B958C", 0);
  level._id_13400.card_angles = getdvarint("_encstr_A29D1A371B27D7DCB69734F6DBDA7D0BCDB12B9BA3FA0D56D2D934A3", 3500);
  level._id_13400.cardstruct = getdvarint("_encstr_A16018A723A2C18E9FBB28F0E2A750F83ABB0365DC4120DBEF12", 2.8);
  level._id_13400.card_origin = getdvarint("_encstr_AFB819C271884723BAFBA3472F5229B158D9FF0D0B89134B85EB9B", 1500);
  level._id_13400.car_think = getdvarfloat("_encstr_96D720F258DEB7A3421199C84FA461DFA72F68C0F37791A6AEF3E0650B1FB00348C6", 1.0);
  level._id_13400.watch_rpg_use = getdvarfloat("_encstr_A5B0228A39C00F7BF2B39B8FF7AAE164F0434516B051FE7256B7C7E3D958EBA3A8083EDA", 2000);
  level._id_13400.watchbombuseinternal = getdvarfloat("_encstr_AF761C1BB6BB579B8FCB136847D01EE489C3E6035BC973CF9BEB0B18D7DB", 1500);
  level._id_13400.watchbombuse = getdvarfloat("_encstr_97CC1893B8454957F833E0EFC06D1F4D8B90CA2A4847FB771015", 1);
  level._id_13400.playerhumanprestream = getdvarint("_encstr_A6E11C37D8E4AFCDB6BC86BDDED6EB99DB9C8D95F5E058E4858DA1AB3AAC", 1);
  level._id_13400.bullets_can_damage = getdvarint("_encstr_9BAE239B8DE4F56EB59734BDBDB6FA895D8DC62BA39BFAC8586B0B762BEB31C2C663DBEDCD", 1);
  level._id_13400.chopperexfil_sh060_start = getdvarint("_encstr_BA891B3EBB4E70DF1A136CDF686A1FB622CC4CBFB00D3FD81551721B01", 2000);
  level._id_13400._id_12C2D = getdvarint("_encstr_9BEA18B29F4DCF227CB30308603A11936FA280A8B2D861FFAFA1", 5);
  level._id_13400.open_door_to_next_objective = getdvarfloat("_encstr_AB392A92FEB5A12B30A8CBCF7BE8CFBA6B81DD0D5025F9453AC8D3C70880BEB2E7B06503494952988078CF4B", 4.0);
  level._id_13400.arenaflag_previewflag = getdvarfloat("_encstr_992329E6D8C9D7DCDAE50DBDDEADAFC485D81BDBB7B97D0B16FA47EAE49C59D1D7D6AEC6A3D23836962B9C", 6.0);
  level._id_13400._id_12928 = getdvarfloat("_encstr_92692E270F0E1923343A2450C0CF27526189FAF8F706497BC7F17B33E98A980FABC5F845A37ABD317D73A077FBB75DA5", 0.0);
  level._id_13400._id_12929 = getdvarfloat("_encstr_859C2C8EEE138F4343C75868B76B1E2DCAD58918456AC70B20BF98788FA8F37FC33FF61D5C121D760BDF20605FC2", 0.5);
  level._id_13400.iskillstreakvehicleinflictor = loadfx("_encstr_8FD046D9330FF2B4DDE07D319C97D2CDB116E6C8CBCA17AB4B38CB98164EE4B0CE2BD7C42C63C6DBDE37F2EC99E1FA8958272716D92BEB26C28DC6BDB7DCEB56E1E0B1BDDC2DBDE6");
  level._id_13400._id_12C32 = loadfx("_encstr_925E435333C1E58FCB0347723E18573A01C05AEAE2432AB7600F0F6A5F9B73C64F48B1020839A52798780776E4A2FFCEEB68EB8A50F3D15BB1515C97084837921B10428240");
  level._id_13400.cantakedamage = loadfx("_encstr_91F4437E340ABEA4173219C2488F9C77202FFEE4F8F18F6BF38806FAC84D12F7B985479A673823B597500EB3987181A3D1F6D2118CA1A73EB358C23AE885C92FC95E468E9B");
  level._id_13400._id_12C33 = loadfx("_encstr_960C422C08AAD20B2F32676313D59C717037E19970C83F8312301050F89DC2486FAB07323828771EA818880AA3091D3F1AC318A78EF18E908E161BEB430EFB2FF9517372");
  level._id_13400._id_12C34 = loadfx("_encstr_876B2E3B993CCBB4BBE0FA98E497CEC2AD5983D8C297BC3B330FF58939AF6C166E34EBCCBA631DDEB9FA33A5361BAE0E");
  level._id_13400._encstr_96820FE30E42CD0B9859F133C76060EB3F = getdvarint("_encstr_B63726E61B93D7E0B03916D8D05D8E95BEDECE56E4A12B588CAFBB0B9C374B37CEEB270B19D2AB9B", 2000);
  level._id_13400._encstr_AC850F0FD89BB64A3D5439EC4DDB6248A3 = getdvarint("_encstr_8FA726573F931838A15AE1B9C49D504DF9A7C5F383DADD88FC792BF16A7E607012FF710B477213E8", 3000);
  level._id_13400._encstr_A2CE13BBB039B95A9B76F51D4BD659DB573ABE6BDC = getdvarint("_encstr_A79B2A6606FB67DBB103C8A013DD135B71AD5CE5DAB2EB219C9F70B853EE48955AD9D57BF5DAB7EB5487B830", 45000);
  level._id_13400._id_1284A = getdvarint("_encstr_844427E78F23A8907B4810C8F553B9777BFFBF5B573A08A0B7A638639A14E82302474FD9B782C7A0A5", 200);
  level._id_13400._encstr_BAB00D13C9C012FD98C5F7B1887807 = getdvarint("_encstr_95C4194B867B4FF2FFE89AE270D7213BD07DB2DD2B03EFB199B813", 100);
  level._id_13400.aq_ontimerexpired = reader();
  level._id_13400.areas_remaining = [];
  level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58 = getentitylessscriptablearrayinradius("_encstr_8BDA259221D8214305FBBB9BEBB83B6360C8CADB99B0FC2AC8B797C7D95822D36173456671D0BC", "_encstr_AC110A7F14873B5B3D073009");
  level._id_13400._encstr_ADA5134BBEB95B9786EDDEB5D7B29BD1DC7DDAC2E1 = getdvarfloat("_encstr_970E15670FA32810FBC8904875D3397D3A3B1FB7AF3A03", -1);
  setdvarifuninitialized("_encstr_B28824ABDFC219DBD7DEED3DB9CB951710302BE18141921816B73E46933ABE935E110973C71B", 0);
}

reader() {
  var_0 = [];

  if(isDefined(level._id_12178)) {
    foreach(var_2 in level._id_12178)
    var_0[var_0.size] = var_2;

    return var_0;
  }

  switch (getDvar("_encstr_9570084B1793A090CDFF")) {
    case "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319":
      break;
    case "_encstr_AD2B10B5E0EBA1ADB9969BC659EB8E56E61D":
      var_0[var_0.size] = [(770, -527, 502), (0, 0, 0)];
      break;
    case "_encstr_8F340F3992796F28DFDFE808E736C1FF27":
      break;
    case "_encstr_85D50EA533513E583F402B4B8621F10F":
      var_0[var_0.size] = [(0, -1870, -2), (0, 45, 0)];
      var_0[var_0.size] = [(500, -1870, -2), (0, 45, 0)];
      var_0[var_0.size] = [(1000, -1870, -2), (0, 45, 0)];
      break;
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      var_0[var_0.size] = [(288, -2209, -2), (0, 0, 0)];
      var_0[var_0.size] = [(288, -2009, -2), (0, 0, 0)];
      break;
    case "_encstr_8D200EC21BB88FC238EB405D29B18AB6":
    case "_encstr_AF690B8DE7364F0A17C0C3EA12":
      var_0[var_0.size] = [(-6062.5, -329, 83), (0, 17, 0)];
      var_0[var_0.size] = [(-1279, -10389, 152), (0, 0, 0)];
      var_0[var_0.size] = [(3597, 3099, 192), (0, 196, 0)];
      var_0[var_0.size] = [(-3729.5, 8587.25, 151), (0, 347, 0)];
      break;
  }

  return var_0;
}

_id_13406() {
  waitframe();
  _id_135D3();

  if(!getdvarint("_encstr_A6612583376021374A2A8AE2F092FFE96085091A51B0B7BFEF60122A997D179FE8278162F9687F", 0))
    _encstr_8A5E16782279BFA8C1B79FC08CA0C5F00B199B29B9961D51();

  while(!isDefined(level.matchcountdowntime) && !scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F"))
    wait 1;

  level._id_13400.choosejuggernautcratemodel = 1;
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  level._id_13400.choosejuggernautcratemodel = undefined;
  level notify("_encstr_BE6E114EB29BE016BBE6BEE65B9743DBEDB5CD");

  if(getdvarint("_encstr_B8D224F8E76E785F7C830BC8AFBAE18AA708921760BD814B2BF952C978B73FC32D634F4897BC", 0) == 1) {
    _id_12C94();
    _encstr_962E2293566EE016EEDCD7376D5E43DBB7ADCDF5C895E6D193F6BC9532BEC16316B1B291();
  } else {
    _id_12C93();

    if(!getdvarint("_encstr_A6612583376021374A2A8AE2F092FFE96085091A51B0B7BFEF60122A997D179FE8278162F9687F", 0))
      _encstr_A9B11827CACD380BEE37FA37DAF2A1DBF6B537FA071B2C3695C8();
  }
}

_id_135D3() {
  if(!level._id_13400.aq_ontimerexpired.size) {
    return;
  }
  level._id_13400.aq_ontimerexpired = scripts\engine\utility::array_randomize(level._id_13400.aq_ontimerexpired);
  var_0 = 0;

  if(getdvarint("_encstr_8F3A1D677EC5DFAA186FCB85E7F8914D67CAAB7050F0A2BDAF3B53F077A8E7", 0))
    var_0 = randomintrange(1, level._id_13400.aq_ontimerexpired.size + 1);
  else if(getdvarfloat("_encstr_8DD11D5E8B2306172C6B4070E2C4975B8331E458DF53095D16B288B03A9FAB", 1.0))
    var_0 = getdvarfloat("_encstr_8DD11D5E8B2306172C6B4070E2C4975B8331E458DF53095D16B288B03A9FAB", 1.0) * level._id_13400.aq_ontimerexpired.size;

  if(var_0 > 0) {
    for(var_1 = level._id_13400.aq_ontimerexpired.size - 1; var_1 >= var_0; var_1--)
      level._id_13400.aq_ontimerexpired = scripts\engine\utility::array_remove_index(level._id_13400.aq_ontimerexpired, var_1);
  }

  foreach(var_6, var_3 in level._id_13400.aq_ontimerexpired) {
    if(level._id_13400._encstr_ADA5134BBEB95B9786EDDEB5D7B29BD1DC7DDAC2E1 > -1) {
      if(var_6 >= level._id_13400._encstr_ADA5134BBEB95B9786EDDEB5D7B29BD1DC7DDAC2E1) {
        break;
      }
    }

    var_4 = easepower("_encstr_81F81373C7905CCB35393AE281988F9490B917E74F", var_3[0]);
    var_4 setscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_AB0703DBB9");
    var_4 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A7C5056BD931D1");
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3[0]);
    var_5 setModel("_encstr_8F0D2663DAD76B2D3696D158C95ED7375BF2D0F6DB5B7DB20FE8E485D8A34BDEDCBEC098EBB1A199");
    var_5.angles = var_3[1];
    var_4.chopperexfil_sfx_before_sh070 = var_5;
    var_4.chopperexfil_skip_ascend0 = var_5.angles;
    var_5._id_133FA = var_4;
    var_5 _id_13401();
    var_5.animname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
    var_5 scripts\common\anim::setanimtree();
    var_5 thread scripts\common\anim::anim_single_solo(var_5, "_encstr_A3970EFDCF4737180A1D88EE90CA5F3F");
    var_5 chopperexfil_sitting_wind();
    var_4 thread _encstr_8FB81503DA42CBBDBF5B731AC0FB74EBFBB78C8BE3697B();
    var_4 thread modevalidatekillcam();
    level._id_13400.areas_remaining[level._id_13400.areas_remaining.size] = var_4;
  }

  if(!isDefined(level._id_13BEB))
    level._id_13BEB = 0;

  level._id_13BEB = level._id_13BEB + level._id_13400.areas_remaining.size;
}

_encstr_8A5E16782279BFA8C1B79FC08CA0C5F00B199B29B9961D51() {
  if(!level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58.size) {
    return;
  }
  level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58 = scripts\engine\utility::array_randomize(level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58);
  var_0 = 0;

  if(getdvarint("_encstr_8F3A1D677EC5DFAA186FCB85E7F8914D67CAAB7050F0A2BDAF3B53F077A8E7", 0))
    var_0 = randomintrange(1, level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58.size + 1);
  else if(getdvarfloat("_encstr_8DD11D5E8B2306172C6B4070E2C4975B8331E458DF53095D16B288B03A9FAB", 1.0))
    var_0 = getdvarfloat("_encstr_8DD11D5E8B2306172C6B4070E2C4975B8331E458DF53095D16B288B03A9FAB", 1.0) * level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58.size;

  if(var_0 > 0) {
    level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58 = scripts\engine\utility::array_randomize(level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58);

    for(var_1 = level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58.size - 1; var_1 >= var_0; var_1--)
      level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58 = scripts\engine\utility::array_remove_index(level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58, var_1);
  }

  foreach(var_3 in level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58) {
    var_3 _encstr_B4DA1DD2BDF9E16B70E88B8F40280F5BB1C75ECF9507DA96D94093BF40E0ED();
    var_3 _encstr_AAB30C603AEF51C044078395292B();
    var_3 thread _encstr_92091E63BA22ABDDDFA001CBC8399667FB08EFE94D09F367CDE9FB22C077CFEB();
    var_3 thread modevalidatekillcam();
  }
}

_encstr_B4DA1DD2BDF9E16B70E88B8F40280F5BB1C75ECF9507DA96D94093BF40E0ED() {
  self setscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_87660AB0D9B05A360B896359");
}

_encstr_9B441A7F7F7367BB6C8303AFD8E7D9D814BE3FEDD1A175DB474A62CE() {
  self setscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_A22A07C493EDB62BCD");
}

_id_12C93() {
  foreach(var_1 in level._id_13400.areas_remaining) {
    if(isDefined(var_1.chopperexfil_sfx_before_sh070))
      var_1.chopperexfil_sfx_before_sh070 delete();
  }

  foreach(var_1 in level._id_13400.areas_remaining) {
    var_1 setscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_AB0703DBB9");
    var_1 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A7C5056BD931D1");
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_4 setModel("_encstr_8F0D2663DAD76B2D3696D158C95ED7375BF2D0F6DB5B7DB20FE8E485D8A34BDEDCBEC098EBB1A199");
    var_4.angles = var_1.chopperexfil_skip_ascend0;
    var_4._id_133FA = var_1;
    var_1.chopperexfil_sfx_before_sh070 = var_4;
    var_1.chopperexfil_sfx_before_sh070 _id_13401();
    var_4.animname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
    var_4 scripts\common\anim::setanimtree();
    var_4 thread scripts\common\anim::anim_single_solo(var_4, "_encstr_A3970EFDCF4737180A1D88EE90CA5F3F");
    var_4 chopperexfil_sitting_wind();
    var_1 thread _encstr_8FB81503DA42CBBDBF5B731AC0FB74EBFBB78C8BE3697B();
    var_1 thread modevalidatekillcam();
  }
}

_encstr_A9B11827CACD380BEE37FA37DAF2A1DBF6B537FA071B2C3695C8() {
  foreach(var_1 in level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58) {
    var_1 _encstr_B4DA1DD2BDF9E16B70E88B8F40280F5BB1C75ECF9507DA96D94093BF40E0ED();
    var_1 _encstr_AAB30C603AEF51C044078395292B();
    var_1 thread _encstr_92091E63BA22ABDDDFA001CBC8399667FB08EFE94D09F367CDE9FB22C077CFEB();
    var_1 thread modevalidatekillcam();
  }
}

_id_12C94() {
  foreach(var_1 in level._id_13400.areas_remaining) {
    if(isDefined(var_1.chopperexfil_sfx_before_sh070))
      var_1.chopperexfil_sfx_before_sh070 delete();
  }

  foreach(var_1 in level._id_13400.areas_remaining) {
    var_1 setscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_A22A07C493EDB62BCD");
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_4 setModel("_encstr_A7B622EA83601F0C1031879F2FF957FB1D7B5262EBC33705490D818BDBD14AA6D0F13AEF");
    var_4 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A22A07C493EDB62BCD");
    var_4.angles = var_1.chopperexfil_skip_ascend0;
    var_4._id_133FA = var_1;
    var_1.chopperexfil_sfx_before_sh070 = var_4;
    var_1 thread _encstr_8FB81503DA42CBBDBF5B731AC0FB74EBFBB78C8BE3697B();
  }
}

_encstr_962E2293566EE016EEDCD7376D5E43DBB7ADCDF5C895E6D193F6BC9532BEC16316B1B291() {
  foreach(var_1 in level._id_13400._encstr_A6F51661B987F6D0E94BE7DB48CD704A3F11DB48A22F3D58) {
    var_1 _encstr_9B441A7F7F7367BB6C8303AFD8E7D9D814BE3FEDD1A175DB474A62CE();
    var_1 thread _encstr_92091E63BA22ABDDDFA001CBC8399667FB08EFE94D09F367CDE9FB22C077CFEB();
  }
}

chopperexfil_sitting_wind() {
  self setCanDamage(1);
  self.health = level._id_13400.chopperexfil_sh060_start;
  self.maxhealth = level._id_13400.chopperexfil_sh060_start;
  thread chopperexfil_sh010_start();
  thread _encstr_8E211A892C8DC6F6DBB9AFD87B1BC65ACD2DB737BEBBB0D136862BE4();
  self physics_registerforcollisioncallback();
  self _meth_87DE(1);

  if(level._id_13400._id_12928)
    self._id_133FA thread _id_135B8();
}

_encstr_AAB30C603AEF51C044078395292B() {
  self.health = level._id_13400.chopperexfil_sh060_start;
  self.maxhealth = level._id_13400.chopperexfil_sh060_start;

  if(level._id_13400._id_12928)
    thread _id_135B8();
}

_id_135B8() {
  self notify("_encstr_AC5B174F69CF5B0C89037A06BB381F331EC7DB6F2FED52DFE8");
  self endon("_encstr_AC5B174F69CF5B0C89037A06BB381F331EC7DB6F2FED52DFE8");
  self.chopper_boss_drone_target_array = 1;
  wait(level._id_13400._id_12928);
  self.chopper_boss_drone_target_array = undefined;
}

modevalidatekillcam() {
  level endon("_encstr_BE6E114EB29BE016BBE6BEE65B9743DBEDB5CD");
  self.capacity = [];
  self waittill("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");

  foreach(var_1 in self.capacity) {
    var_2 = var_1 getentitynumber();
    self._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B[var_2] _id_133FC(var_1);
    self._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B[var_2] stoploopsound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
    playerstartarenasetcontrols(var_1, var_1 getentitynumber(), self);
  }
}

_id_13409(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "_encstr_BA19049F4B2D") {
    if(var_2 == "_encstr_A22A07C493EDB62BCD" && var_3.plundercount >= level._id_13400._id_12C2D) {
      var_3 thread scripts\mp\hud_message::showsplash("_encstr_96561AE4AC325983D8B7E5EB982C1B8DED7BDCAFE4AC07855A275691");
      var_0.chopperexfil_sfx_before_sh070 _id_13401();
      var_0 notify("_encstr_84E3104BC0FFB70FC8DF1A159988D4531539", var_3);
    } else {
      if(var_2 != "_encstr_AB0703DBB9" || istrue(var_3._id_140AF) || !get_any_player_spectating(var_0, var_3)) {
        playsoundatpos(var_0.origin, "_encstr_82AC1682309030A2F89F3FF3FB1F0A79901EFF8F08F8C5CA");
        return;
      }

      level thread atv_vehicle(var_0, var_3);
    }
  }
}

_encstr_A9A51CB67BF718C7C592A8502A9E9BD1A71BBE23D86BE125ED5A88A00277(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "_encstr_BA19049F4B2D") {
    if(var_2 == "_encstr_A22A07C493EDB62BCD" && var_3.plundercount >= level._id_13400._id_12C2D) {
      var_3 thread scripts\mp\hud_message::showsplash("_encstr_96561AE4AC325983D8B7E5EB982C1B8DED7BDCAFE4AC07855A275691");
      var_0 notify("_encstr_84E3104BC0FFB70FC8DF1A159988D4531539", var_3);
    } else {
      if(var_2 != "_encstr_AB0703DBB9" || istrue(var_3._id_140AF) || !get_any_player_spectating(var_0, var_3)) {
        playsoundatpos(var_0.origin, "_encstr_82AC1682309030A2F89F3FF3FB1F0A79901EFF8F08F8C5CA");
        return;
      }

      level thread atv_vehicle(var_0, var_3);
    }
  }
}

_encstr_8FB81503DA42CBBDBF5B731AC0FB74EBFBB78C8BE3697B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BE6E114EB29BE016BBE6BEE65B9743DBEDB5CD");
  self waittill("_encstr_84E3104BC0FFB70FC8DF1A159988D4531539", var_0);
  var_0 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1261E(level._id_13400._id_12C2D);
  playsoundatpos(self.origin, "_encstr_ABE60FA0C8C03A9577B28EF2CFA9093A95");
  playFX(level._id_13400._id_12C32, self.origin + (0, 0, 4000));
  playFX(level._id_13400._id_12C34, self.origin + (0, 0, 16));
  wait 0.25;
  playFX(level._id_13400._id_12C33, self.origin);
  self setscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_AB0703DBB9");
  self setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A7C5056BD931D1");
  self.chopperexfil_sfx_before_sh070 chopperexfil_sitting_wind();
  self.chopperexfil_sfx_before_sh070.animname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  self.chopperexfil_sfx_before_sh070 scripts\common\anim::setanimtree();
  self.chopperexfil_sfx_before_sh070 thread scripts\common\anim::anim_single_solo(self.chopperexfil_sfx_before_sh070, "_encstr_A3970EFDCF4737180A1D88EE90CA5F3F");
  thread _encstr_8FB81503DA42CBBDBF5B731AC0FB74EBFBB78C8BE3697B();
  thread modevalidatekillcam();
}

_encstr_92091E63BA22ABDDDFA001CBC8399667FB08EFE94D09F367CDE9FB22C077CFEB() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BE6E114EB29BE016BBE6BEE65B9743DBEDB5CD");
  self waittill("_encstr_84E3104BC0FFB70FC8DF1A159988D4531539", var_0);
  var_0 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1261E(level._id_13400._id_12C2D);
  playsoundatpos(self.origin, "_encstr_ABE60FA0C8C03A9577B28EF2CFA9093A95");
  playFX(level._id_13400._id_12C32, self.origin + (0, 0, 4000));
  playFX(level._id_13400._id_12C34, self.origin + (0, 0, 16));
  wait 0.25;
  playFX(level._id_13400._id_12C33, self.origin);
  _encstr_B4DA1DD2BDF9E16B70E88B8F40280F5BB1C75ECF9507DA96D94093BF40E0ED();
  _encstr_AAB30C603AEF51C044078395292B();
  thread _encstr_92091E63BA22ABDDDFA001CBC8399667FB08EFE94D09F367CDE9FB22C077CFEB();
  thread modevalidatekillcam();
}

atv_vehicle(var_0, var_1) {
  if(!get_any_player_spectating(var_0, var_1)) {
    return;
  }
  if(getdvarint("_encstr_BE042A12A15897F30A4B13177F2279E3782BCA1C19307CAA480303734356425BB8D00525765036223E31570B", 1)) {
    if(isDefined(var_1.get_search_turret_target_player)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_99E91506C96A0BC2A122215D97489BCA21EF92C0686FA2")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_99E91506C96A0BC2A122215D97489BCA21EF92C0686FA2")]](var_0);
        return 0;
      }
    }
  }

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_encstr_BA6B1C12A0F3B5AFA8A36C79B6938F3A0FCB3A5AE05FEAF7C185506458FA(var_1);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0.capacity[var_0.capacity.size] = var_1;
  var_1._id_140AF = 1;
  var_1.shouldskiplaststand = 1;

  if(isDefined(var_1.get_search_turret_target_player))
    var_1.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_subway_train_hit_damage_multiplier(0);

  var_2 = var_1 getentitynumber();
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_3 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(!isDefined(var_0._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B))
    var_0._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B = [];

  var_0._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B[var_2] = var_3;
  _id_1246F(var_1);
  var_0 thread _id_13405();
  var_1.usingascender = 1;
  level.initpostmain++;
  var_1 scripts\common\utility::allow_usability(0);
  var_4 = var_0.ascendstructend;
  var_5 = var_0.ascendstructout;
  var_3 dontinterpolate();
  var_3.origin = var_0.origin + (0, 0, 28);
  var_3.angles = var_1.angles;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_6 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_6 setModel("_encstr_A13B15AF9A177AB7201DBE7703362D2329BF6BB85EB097");
  var_6 showonlytoplayer(var_1);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_7 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_7 setModel("_encstr_A13B15AF9A177AB7201DBE7703362D2329BF6BB85EB097");
  var_7 hide();

  if(!isDefined(var_0._encstr_83EA16B78F9DD949B8714F9589D0823260012F1B75332217))
    var_0._encstr_83EA16B78F9DD949B8714F9589D0823260012F1B75332217 = [];

  var_0._encstr_83EA16B78F9DD949B8714F9589D0823260012F1B75332217[var_2] = var_6;

  if(!isDefined(var_0._encstr_841D172CAFB2D70BB9B19537322B27DADBC8561BDD7BE4C646))
    var_0._encstr_841D172CAFB2D70BB9B19537322B27DADBC8561BDD7BE4C646 = [];

  var_0._encstr_841D172CAFB2D70BB9B19537322B27DADBC8561BDD7BE4C646[var_2] = var_7;
  var_1 thread ascenddeathlistener(var_0, var_2);
  var_1.chopper_boss_damage_monitor = 0;
  var_8 = var_3 _id_133FB(var_1, var_6, var_7);

  if(!var_8) {
    playerstartarenasetcontrols(var_1, var_2, var_0);
    playsoundatpos(var_0.origin, "_encstr_82AC1682309030A2F89F3FF3FB1F0A79901EFF8F08F8C5CA");
    return;
  }

  var_1 childthread _id_133FE();
  var_1 thread _id_12505();
  var_3 thread _id_133FD(var_1, var_6, var_7);
  var_3 playLoopSound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_3 moveTo(var_3.origin + (0, 0, level._id_13400.card_angles), level._id_13400.cardstruct, level._id_13400.cardstruct);
  playfxontagforclients(level._id_13400.cantakedamage, var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_1);
  wait(level._id_13400.cardstruct * 0.35);
  var_1.chopper_boss_damage_monitor = 1;
  wait(level._id_13400.cardstruct * 0.65);
  stopFXOnTag(level._id_13400.cantakedamage, var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 notify("_encstr_86531F22176324977032CA62EA17C0FF602A1BEA105801BDA2D654A8D3235A6A45");
  var_3 thread _id_133FC(var_1, var_6, var_7);
  var_3 stoploopsound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_1 playlocalsound("_encstr_83761ADC1BE4FAC4E4BED2CDCC4B36D74DD5B5C1AF371DB4E6CEACE4", var_1);
  var_1 earthquakeforplayer(0.2, 1.5, var_1.origin, 1000);
  var_9 = "_encstr_A18008BD35E222F01BD0";

  if(isDefined(var_1.operatorcustomization) && isDefined(var_1.operatorcustomization.disabledebugdialogue))
    var_9 = var_9 + var_1.operatorcustomization.disabledebugdialogue;

  var_1 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", var_9, 0);
  var_1 setisinfilskydive(1);
  var_3 movegravity(anglesToForward(var_1 getplayerangles(1)) * level._id_13400.watch_rpg_use + (0, 0, level._id_13400.watchbombuseinternal), level._id_13400.watchbombuse);
  var_1._id_140BC = anglesToForward(var_1 getplayerangles(1)) * level._id_13400.watch_rpg_use;
  wait(level._id_13400.watchbombuse - 0.1);
  var_1 setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 1);
  var_1 thread _id_13403();
  playerstartarenasetcontrols(var_1, var_2, var_0);
  var_0.capacity = scripts\engine\utility::array_remove(var_0.capacity, var_1);
}

_id_133FE() {
  self endon("_encstr_86531F22176324977032CA62EA17C0FF602A1BEA105801BDA2D654A8D3235A6A45");

  for(;;) {
    self earthquakeforplayer(0.2, 1.5, self.origin, 1000);
    wait(randomfloatrange(0.5, 1.0));
  }
}

_id_13405() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.inuse = 1;
  wait 1.0;
  self.inuse = undefined;
}

_id_12505() {
  self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 3);

  while(isalive(self)) {
    if(self isonground()) {
      self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 0);
      return;
    }

    waitframe();
  }

  if(isDefined(self))
    self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 0);
}

playerstartarenasetcontrols(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
    var_0 setisinfilskydive(0);
  }

  if(isDefined(var_2._encstr_83EA16B78F9DD949B8714F9589D0823260012F1B75332217[var_1])) {
    var_2._encstr_83EA16B78F9DD949B8714F9589D0823260012F1B75332217[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2._encstr_83EA16B78F9DD949B8714F9589D0823260012F1B75332217[var_1] delete();
  }

  if(isDefined(var_2._encstr_841D172CAFB2D70BB9B19537322B27DADBC8561BDD7BE4C646[var_1])) {
    var_2._encstr_841D172CAFB2D70BB9B19537322B27DADBC8561BDD7BE4C646[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2._encstr_841D172CAFB2D70BB9B19537322B27DADBC8561BDD7BE4C646[var_1] delete();
  }

  var_2 thread cleanupascenduse(var_0);
  var_2 thread handleownervisibility(var_0, var_1);

  if(isDefined(var_0)) {
    if(!istrue(level.client_activate))
      var_0 skydive_setbasejumpingstatus(1);

    var_0.player_rig stopanimScripted();
    var_0.usingascender = 0;
    var_0._id_140AF = 0;
  }

  level.initpostmain--;

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_140BC))
      var_0 setvelocity(var_0._id_140BC);

    var_0._id_140BC = undefined;

    if(istrue(var_0.chopper_boss_damage_monitor) && !istrue(level.client_activate) && !scripts\mp\utility\player::unset_relic_trex(var_0))
      var_0 skydive_beginfreefall();

    var_0 notify("_encstr_A9F81186E4ABE9D85F87D91BAF65F329B2CB75");
  }
}

_id_1246F(var_0) {
  if(var_0 getstance() != "_encstr_A5AD069B231F0BAF")
    var_0 setstance("_encstr_A5AD069B231F0BAF");

  var_0 allowmelee(0);
  var_0 allowads(0);
  var_0 allowfire(0);

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
      var_1 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

      if(istrue(var_1))
        var_0 disableweaponswitch();
    }
  } else {
    var_0 disableoffhandweapons();
    var_0 scripts\common\utility::allow_killstreaks(0);
    var_0 scripts\common\utility::allow_supers(0);
    var_0 disableweaponswitch();
  }
}

get_any_player_spectating(var_0, var_1) {
  if(istrue(level._id_13400.choosejuggernautcratemodel))
    return 0;

  if(istrue(var_0.inuse))
    return 0;

  if(var_1 isswitchingweapon())
    return 0;

  if(var_1.currentweapon.basename == "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817")
    return 0;

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(var_1.tracking_max_health))
    return 0;

  if(istrue(var_1.inlaststand))
    return 0;

  if(istrue(var_1.isreviving))
    return 0;

  if(istrue(var_1.isjuggernaut))
    return 0;

  if(var_1 isskydiving())
    return 0;

  if(var_1 isparachuting())
    return 0;

  if(istrue(var_1.iszombie))
    return 0;

  var_2 = max(level._id_13BEB, 30);
  var_3 = getdvarint("_encstr_841F21B9B14ED7C2CD3659E68C599CFAF66756C927D23259F5D60B0FEB58D8A3963BCA", var_2);

  if(var_3 != -1)
    var_2 = var_3;

  if(level.initpostmain >= var_2)
    return 0;

  return 1;
}

cleanupascenduse(var_0) {
  if(isDefined(var_0)) {
    var_0 allowmelee(1);
    var_0 allowads(1);
    var_0 allowfire(1);

    if(istrue(var_0.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
        var_1 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

        if(istrue(var_1))
          var_0 enableweaponswitch();
      }
    } else if(!istrue(var_0.inlaststand)) {
      var_0 enableoffhandweapons();
      var_0 enableweaponswitch();
      var_0 scripts\common\utility::allow_killstreaks(1);
      var_0 scripts\common\utility::allow_supers(1);
    } else
      var_0 thread watch_for_ashes_achievement();
  }

  waitframe();

  if(isDefined(var_0)) {
    if(!istrue(var_0._encstr_88F711724FAFA067E86789DAE654EFA8EB5891)) {
      var_0 allowmelee(1);
      var_0 enableweaponswitch();
      var_0 _meth_87E5();
      var_0 thread scripts\mp\utility\infilexfil::takegunless();
    }

    var_0 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
    var_0 scripts\common\utility::allow_usability(1);
  }
}

watch_for_ashes_achievement() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self._encstr_88F711724FAFA067E86789DAE654EFA8EB5891 = 1;
  self allowmelee(0);
  scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self allowmelee(1);
  self enableoffhandweapons();
  self enableweaponswitch();
  self _meth_87E5();
  scripts\common\utility::allow_killstreaks(1);
  scripts\common\utility::allow_supers(1);
  thread scripts\mp\utility\infilexfil::takegunless();
  self._encstr_88F711724FAFA067E86789DAE654EFA8EB5891 = undefined;
}

ascenddeathlistener(var_0, var_1) {
  self endon("_encstr_A9F81186E4ABE9D85F87D91BAF65F329B2CB75");
  scripts\engine\utility::waittill_any_ents(self, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", self, "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B", level, "_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self))
    self stopanimscriptsceneevent();

  var_0._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B[var_1] stoploopsound("_encstr_B1641FB5BB81C7D0F45D66B942CB98888A4F0D479B4A14083B376E10AA8F983F12");
  var_0.capacity = scripts\engine\utility::array_remove(var_0.capacity, self);
  playerstartarenasetcontrols(self, var_1, var_0);
}

handleownervisibility(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 unlink();

    if(!var_0 scripts\common\utility::can_be_executed())
      var_0 scripts\common\utility::allow_execution_victim(1);
  }

  if(isDefined(self._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B[var_1])) {
    self._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    self._encstr_A5E21697F1729F7373F74878479B0E1BFB661DA8972A8D3B[var_1] delete();
  }
}

_encstr_8E211A892C8DC6F6DBB9AFD87B1BC65ACD2DB737BEBBB0D136862BE4() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BE6E114EB29BE016BBE6BEE65B9743DBEDB5CD");
  self endon("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_4[2] > self.origin[2] + 2500 && isDefined(var_7) && var_7 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_7 thread _encstr_A5D4156DD2D8D87D675686D28DC656D7232B1B85F295C8(var_4);
      self dodamage(self.health + 1, var_4, var_7, var_7, "_encstr_8D4E0A501FCB898912CB3FA3");
    }
  }
}

_encstr_A5D4156DD2D8D87D675686D28DC656D7232B1B85F295C8(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait 0.15;

  if(isalive(self))
    self dodamage(99999, var_0);
}

chopperexfil_sh010_start() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BE6E114EB29BE016BBE6BEE65B9743DBEDB5CD");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_9) && isDefined(var_9.magazine)) {
      switch (var_9.magazine) {
        case "_encstr_93931296D86BFFF828B323961829F3CFB587923B":
          var_0 = 300;
          break;
        case "_encstr_8A77125EB62A2F4B930B423123D58077C2CA6FFB":
          if(var_3[2] >= self.origin[2] + 2500)
            thread _encstr_ACE91E5FC2908A698D78603B05FF63C3FFD48F3F633F90C68A43EA2B8BFBE8D0(3, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

          break;
      }
    }

    if(var_0 < 2) {
      continue;
    }
    if(var_3[2] <= self.origin[2] + 2500) {
      self.health = self.health + var_0;
      continue;
    }

    if(istrue(self._id_133FA.chopper_boss_drone_target_array))
      var_0 = int(var_0 * level._id_13400._id_12929);

    if(isPlayer(var_1))
      var_1 scripts\mp\damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", self.health == 0, 0, 1, "_encstr_A2FB098A2035874AB0F358");
    else if(isDefined(var_1.owner) && isPlayer(var_1.owner))
      var_1.owner scripts\mp\damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", self.health == 0, 0, 1, "_encstr_A2FB098A2035874AB0F358");

    if(isDefined(var_1) && isDefined(var_1.currentweapon) && isDefined(var_1.currentweapon.basename) && var_1.currentweapon.basename == "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83")
      self.health = self.health - int(var_0 * (level._id_13400.arenaflag_previewflag - 1.0));

    if(isDefined(var_4) && var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")
      self.health = self.health - int(var_0 * (level._id_13400.open_door_to_next_objective - 1.0));

    if(isDefined(var_9) && isDefined(var_9.basename) && var_9.basename == "_encstr_95E70D8EDBDA85F5839CED35F5B683")
      self.health = 0;

    if(self.health <= 0) {
      break;
    }

    if(isDefined(var_9) && isDefined(var_9.magazine)) {
      switch (var_9.magazine) {
        case "_encstr_A9B01326DEB13A2B0F3863F6D7C6C9DB37B9267B77":
          thread _encstr_9AA31E6685DAACF5ACE183B1ED37D2DBB9F5C885DAB03B56EB8CB21B0BF2CAC8(2.05, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
          break;
        case "_encstr_B460120A50F13BBB302E75574EBB570237D042D3":
          thread _encstr_ACE91E5FC2908A698D78603B05FF63C3FFD48F3F633F90C68A43EA2B8BFBE8D0(4, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
          break;
      }
    }
  }

  if(isDefined(var_1.model) && var_1.model == "_encstr_8849273B59D0BECD867D5BD263F585D2C9AF4616D8C143C2F5BBE9D7D1EAC9932BA37D581D1DB0C634" && isDefined(var_1.owner) && isPlayer(var_1.owner))
    var_1.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]]("_encstr_ABD70578F3D02C", 500);

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_1.currentweapon) && isDefined(var_1.currentweapon.basename) && var_1.currentweapon.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
    var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]]("_encstr_ABD70578F3D02C", 500);

  chopperexfil_sh050_start();
}

_encstr_960222DCD8392D073A164C1B2BEB6EB59734DBB7D67DC1B12CD89546FA3216B558B3CA46(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_2) || !isDefined(var_2.classname) || var_2.classname != "_encstr_8BDA259221D8214305FBBB9BEBB83B6360C8CADB99B0FC2AC8B797C7D95822D36173456671D0BC") {
    return;
  }
  if(var_3 < 2) {
    return;
  }
  if(var_8[2] <= var_2.origin[2] + 4450 || var_8[2] >= var_2.origin[2] + 4900) {
    return;
  }
  if(istrue(var_2.chopper_boss_drone_target_array))
    var_3 = int(var_3 * level._id_13400._id_12929);

  if(isPlayer(var_1))
    var_1 scripts\mp\damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", var_2.health == 0, 0, 1, "_encstr_A2FB098A2035874AB0F358");
  else if(isDefined(var_1.owner) && isPlayer(var_1.owner))
    var_1.owner scripts\mp\damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", var_2.health == 0, 0, 1, "_encstr_A2FB098A2035874AB0F358");

  if(isDefined(var_1.model) && var_1.model == "_encstr_821619CEAC0DAFCD1AD7ADB4B1F5582D9CFA9185D8E034B0F5EE9E" || var_1.model == "_encstr_871219BCED2B66779B69C8E072690BF82BAFCEB84DBBE9BDB9F348" || var_1.model == "_encstr_85D41FBE622213315B412967412BFDC7C80A1B6FD5D090F180594FD393B3D6725D" || var_1.model == "_encstr_8F1922DE15A8424943D84A7170A3FA27C00E42413410978D2151F2BAA88BB6A35978D5FF")
    level thread vfx_htown_stab_blink_1(var_1, var_2.origin);

  if(isDefined(var_1) && isDefined(var_1.currentweapon) && isDefined(var_1.currentweapon.basename) && var_1.currentweapon.basename == "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83")
    var_3 = int(var_3 * level._id_13400.arenaflag_previewflag);

  if(isDefined(var_5) && var_5 == 3 || var_5 == 4 || var_5 == 5 || var_5 == 6 || var_5 == 7 || var_5 == 16)
    var_3 = int(var_3 * level._id_13400.open_door_to_next_objective);

  if(isDefined(var_0) && isDefined(var_0.model) && var_0.model == "_encstr_88451B47E35980334B4BFB23F2F7FDB92B49FDC79DFB298E636111687F")
    var_3 = level._id_13400._id_1284A;

  var_2.health = var_2.health - var_3;

  if(isDefined(var_6) && isDefined(var_6.basename) && var_6.basename == "_encstr_95E70D8EDBDA85F5839CED35F5B683")
    var_2.health = 0;

  if(var_2.health <= 0) {
    if(isDefined(var_1.model) && var_1.model == "_encstr_8849273B59D0BECD867D5BD263F585D2C9AF4616D8C143C2F5BBE9D7D1EAC9932BA37D581D1DB0C634" && isDefined(var_1.owner) && isPlayer(var_1.owner))
      var_1.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]]("_encstr_ABD70578F3D02C", 500);

    if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_1.currentweapon) && isDefined(var_1.currentweapon.basename) && var_1.currentweapon.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]]("_encstr_ABD70578F3D02C", 500);

    var_2 _encstr_AB2F19495E6468B8E2A39FC9832AF67804B9F12142C450607B97D1(var_0, var_1);
  }
}

_encstr_9AA31E6685DAACF5ACE183B1ED37D2DBB9F5C885DAB03B56EB8CB21B0BF2CAC8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");
  wait(var_0);
  self dodamage(var_1, var_4, var_2, undefined, undefined, undefined, var_4);
}

_encstr_ACE91E5FC2908A698D78603B05FF63C3FFD48F3F633F90C68A43EA2B8BFBE8D0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");

  for(var_12 = 0; var_12 < var_0; var_12 = var_12 + 0.25) {
    wait 0.25;

    if(scripts\mp\utility\player::isreallyalive(var_2))
      var_2 scripts\mp\damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", self.health == 0, 0, 1, "_encstr_A2FB098A2035874AB0F358");
  }

  self dodamage(level._id_13400._encstr_BAB00D13C9C012FD98C5F7B1887807 * var_0, var_4, var_2, undefined, undefined, undefined, var_4);
}

_id_1284A(var_0, var_1, var_2) {
  if(getdvarint("_encstr_AF5F159BB1C9FA6E5BCB86DEEDB5B9AF569B2C891B958C", 0)) {
    if(isDefined(var_0["_encstr_AA1C0886968EA32FE056"]) && var_0["_encstr_AA1C0886968EA32FE056"] == "_encstr_88D90F8067B4334BB3F7082D0DCB53FB11" && isDefined(var_0["_encstr_850E077B0BF30318B9"]) && isDefined(var_0["_encstr_850E077B0BF30318B9"].model) && var_0["_encstr_850E077B0BF30318B9"].model == "_encstr_8F0D2663DAD76B2D3696D158C95ED7375BF2D0F6DB5B7DB20FE8E485D8A34BDEDCBEC098EBB1A199") {
      wait 0.3;

      if(var_0["_encstr_BD260953AA97E3F014279D"][2] > var_0["_encstr_850E077B0BF30318B9"].origin[2] + 2500) {
        if(isDefined(var_2))
          var_0["_encstr_850E077B0BF30318B9"] dodamage(level._id_13400._id_1284A, var_0["_encstr_BD260953AA97E3F014279D"], undefined, var_2);
        else
          var_0["_encstr_850E077B0BF30318B9"] dodamage(level._id_13400._id_1284A, var_0["_encstr_BD260953AA97E3F014279D"]);

        if(var_0["_encstr_850E077B0BF30318B9"].health <= 0)
          var_2.brattractions++;
      }
    }
  }
}

chopperexfil_sh050_start() {
  self._id_133FA setscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_A22A07C493EDB62BCD");
  self._id_133FA _id_13402();
  playFX(level._id_13400.iskillstreakvehicleinflictor, self._id_133FA.origin + (0, 0, 4500));
  self._id_133FA setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_ACCB09CA870E63F5B9991E");
  self._id_133FA notify("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");
  radiusdamage(self.origin + (0, 0, 4500), 512, 100, 100, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB");
}

_encstr_AB2F19495E6468B8E2A39FC9832AF67804B9F12142C450607B97D1(var_0, var_1) {
  self setscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD", "_encstr_A22A07C493EDB62BCD");
  playFX(level._id_13400.iskillstreakvehicleinflictor, self.origin + (0, 0, 4500));
  self notify("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");

  if(isDefined(var_0) && isDefined(var_0.model) && var_0.model == "_encstr_88451B47E35980334B4BFB23F2F7FDB92B49FDC79DFB298E636111687F")
    var_1.brattractions++;

  waitframe();
  radiusdamage(self.origin + (0, 0, 4500), 512, 100, 100, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB");
}

vfx_htown_stab_blink_1(var_0, var_1) {
  wait 0.15;

  if(scripts\mp\utility\player::isreallyalive(var_0))
    var_0 dodamage(9999, var_1);
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

initanimtree() {
  level.scr_animtree["_encstr_82DC0DC6CB18BB5744B8C3978DEFB0"] = #animtree;
  level.scr_anim["_encstr_82DC0DC6CB18BB5744B8C3978DEFB0"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = % _encstr_99AF19B09809CA87707FA381A21A1F602FE82107A84598F0237868;
  level.scr_animname["_encstr_82DC0DC6CB18BB5744B8C3978DEFB0"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = "_encstr_99AF19B09809CA87707FA381A21A1F602FE82107A84598F0237868";
  level.scr_eventanim["_encstr_82DC0DC6CB18BB5744B8C3978DEFB0"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = "_encstr_A3970EFDCF4737180A1D88EE90CA5F3F";
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_B41D0F939523CA83B1DBCB7D56E61D599C"] = % _encstr_B80E19F3CFC139D8D15A75944753B4AF8F10257E039DDB3863887A;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_B41D0F939523CA83B1DBCB7D56E61D599C"] = "_encstr_B80E19F3CFC139D8D15A75944753B4AF8F10257E039DDB3863887A";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_B41D0F939523CA83B1DBCB7D56E61D599C"] = "_encstr_B41D0F939523CA83B1DBCB7D56E61D599C";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = % _encstr_A509183BB5F5592EF5E42B8CAC1C8DB7CBFA63B7DB0EEBE01B4E;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = "_encstr_A509183BB5F5592EF5E42B8CAC1C8DB7CBFA63B7DB0EEBE01B4E";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = "_encstr_A3970EFDCF4737180A1D88EE90CA5F3F";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_815B0E5D2FFA0D40A415FA36BF88B03D"] = % _encstr_B14B18D9D6AF95B8EB9C95322BE01BBDCB7D2B3C5A8EEBC18D27;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_815B0E5D2FFA0D40A415FA36BF88B03D"] = "_encstr_B14B18D9D6AF95B8EB9C95322BE01BBDCB7D2B3C5A8EEBC18D27";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_815B0E5D2FFA0D40A415FA36BF88B03D"] = "_encstr_815B0E5D2FFA0D40A415FA36BF88B03D";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_B41D0F939523CA83B1DBCB7D56E61D599C"] = % _encstr_97181E643131B228C1B3B2F81B59D18F53E7CBFDA3034679FB43B0A0601C18DB;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_B41D0F939523CA83B1DBCB7D56E61D599C"] = "_encstr_97181E643131B228C1B3B2F81B59D18F53E7CBFDA3034679FB43B0A0601C18DB";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_B41D0F939523CA83B1DBCB7D56E61D599C"] = "_encstr_B41D0F939523CA83B1DBCB7D56E61D599C";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = % _encstr_8D481DDDB5D75617F593B2C8591C36EDBCEBB1DBED38BE0B6E36957346569C;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = "_encstr_8D481DDDB5D75617F593B2C8591C36EDBCEBB1DBED38BE0B6E36957346569C";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_A3970EFDCF4737180A1D88EE90CA5F3F"] = "_encstr_A3970EFDCF4737180A1D88EE90CA5F3F";
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_815B0E5D2FFA0D40A415FA36BF88B03D"] = % _encstr_97ED1DDDB6BE2B5CAF39CA912B071BB75E7D2BF0D247AF58DC8DB273462BC9;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_815B0E5D2FFA0D40A415FA36BF88B03D"] = "_encstr_97ED1DDDB6BE2B5CAF39CA912B071BB75E7D2BF0D247AF58DC8DB273462BC9";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_815B0E5D2FFA0D40A415FA36BF88B03D"] = "_encstr_815B0E5D2FFA0D40A415FA36BF88B03D";
}

_id_133FB(var_0, var_1, var_2) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
  var_0 thread _id_13404("_encstr_8BB007E03658CBCAE4", var_0.origin, var_0.angles);
  var_1.animname = "_encstr_9690073295D94B8D59";
  var_1 scripts\common\anim::setanimtree();
  var_2.animname = "_encstr_9690073295D94B8D59";
  var_2 scripts\common\anim::setanimtree();
  var_2 hide();
  var_3 = "_encstr_B2AE149D158949D9E69E950B62470AD639E5A1076BD5";
  var_4 = "_encstr_B41D0F939523CA83B1DBCB7D56E61D599C";
  var_5 = var_0.origin - self.origin;
  var_6 = vectorNormalize(var_5) * length((-16.12, 9.073, 0));
  var_7 = rotatevector((-16.12, 9.073, 0), (0, var_0.angles[1] - -35.985, 0));
  var_8 = self.origin + var_7;
  var_0 scripts\common\utility::allow_execution_victim(0);
  self._id_140BB = self.origin;
  self.origin = var_0.origin;
  self moveTo(self._id_140BB, 0.4, 0.1, 0.1);
  self._id_140B3 = self.angles;
  self.angles = var_0 getplayerangles();
  self rotateTo(self._id_140B3, 0.4, 0.1, 0.1);
  var_0.player_rig moveTo(var_8, 0.4, 0.1, 0.1);
  var_9 = vectortoangles(-1 * (var_6[0], var_6[1], 0));
  var_0.player_rig rotateTo(var_9, 0.4, 0.1, 0.1);
  var_10 = var_0 scripts\mp\utility\infilexfil::givegunless();

  if(!var_10)
    return 0;

  var_0 disableweaponswitch();
  var_0 _meth_87E4();
  var_0.player_rig linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", -1 * var_6, (0, 0, 0));
  var_1 linkTo(var_0.player_rig, var_3, (0, 0, 0), (0, 0, 0));
  var_2 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_0.player_rig showonlytoplayer(var_0);
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_4);
  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_4);
  waitframe();
  thread scripts\common\anim::anim_single_solo(var_2, var_4);
  var_11 = 0.1;
  wait(var_11);
  var_2 show();

  if(!getdvarint("_encstr_87AC267BCF98D9DFA232A2DAD88A378A20AFF7CF49F09C13DD0B4A1323D03B49B03F9B7DE578276B", 0))
    var_2 hidefromplayer(var_0);

  var_12 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"][var_4]) - var_11;
  wait(var_12 * 0.55);
  var_0 earthquakeforplayer(0.1, 0.25, var_0.origin, 1000);
  wait(var_12 * 0.45);
  return 1;
}

#using_animtree("_encstr_B40101");

_id_13404(var_0, var_1, var_2) {
  self.animname = var_0;

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  self predictstreampos(var_1);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_1, 0, 0, self);
  var_3.angles = var_2;
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig hide(1);
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = scripts\mp\utility\infilexfil::handledofnotetrack;
  self playerlinktodelta(self.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 70, 70, 30, 30, 1);
  self notify("_encstr_A9920CF579D7F1B6CBAAD963B24B");
  scripts\engine\utility::_id_143A5("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();

    if(!istrue(self._encstr_88F711724FAFA067E86789DAE654EFA8EB5891)) {
      self allowmelee(1);
      self enableweaponswitch();
      self _meth_87E5();
      thread scripts\mp\utility\infilexfil::takegunless();
    }
  }

  if(isDefined(var_3))
    var_3 delete();
}

_id_13401() {
  self setModel("_encstr_8F0D2663DAD76B2D3696D158C95ED7375BF2D0F6DB5B7DB20FE8E485D8A34BDEDCBEC098EBB1A199");
  self setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_87660AB0D9B05A360B896359");
}

_id_13402() {
  self.chopperexfil_sfx_before_sh070 setModel("_encstr_A7B622EA83601F0C1031879F2FF957FB1D7B5262EBC33705490D818BDBD14AA6D0F13AEF");
  self.chopperexfil_sfx_before_sh070 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A22A07C493EDB62BCD");
}

_id_133FD(var_0, var_1, var_2) {
  var_3 = "_encstr_A3970EFDCF4737180A1D88EE90CA5F3F";
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_3);
  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_3);
  thread scripts\common\anim::anim_single_solo(var_2, var_3);
}

_id_133FC(var_0, var_1, var_2) {
  var_3 = "_encstr_815B0E5D2FFA0D40A415FA36BF88B03D";
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_3);
  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_3);

  if(isDefined(var_2)) {
    var_2 scripts\cp_mp\ent_manager::deregisterspawn();
    var_2 delete();
  }
}

_id_13403() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(!self isonground()) {
    var_0 = scripts\common\utility::playersincylinder(self.origin, level._id_13400._encstr_96820FE30E42CD0B9859F133C76060EB3F, undefined, level._id_13400._encstr_AC850F0FD89BB64A3D5439EC4DDB6248A3);
    var_1 = self.team;

    foreach(var_3 in var_0) {
      if(scripts\mp\utility\game::updatehistoryhud(var_3)) {
        continue;
      }
      var_4 = var_1 == var_3.team;

      if(var_4) {
        continue;
      }
      var_5 = !scripts\mp\utility\player::isreallyalive(var_3) || istrue(var_3.inlaststand);

      if(var_5) {
        continue;
      }
      var_6 = var_3 isparachuting() || var_3 isinfreefall();

      if(var_6) {
        continue;
      }
      var_7 = gettime();
      var_8 = isDefined(var_3.showteamlittlebirds) && var_7 - var_3.showteamlittlebirds < level._id_13400._encstr_A2CE13BBB039B95A9B76F51D4BD659DB573ABE6BDC;

      if(var_8) {
        continue;
      }
      var_3.showteamlittlebirds = var_7;

      if(var_3 scripts\cp_mp\utility\game_utility::_id_140A8())
        var_9 = "_encstr_B89B05311BD04E";
      else {
        var_10 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::disableannouncer(var_3);
        var_9 = game["_encstr_8F8206ACFA5A81B5"][var_10];
      }

      var_3 queuedialogforplayer(level.audio_railyard_fires[var_9], "_encstr_AD0419E42B9BC12CEE9B5A37CE7D56B959B52FFA96B9F52CC95685", 2);
    }

    waitframe();
  }
}

isplatepouch() {
  _encstr_86272063EE5BD1037B9032D850808A4F614F53F7470393A82283E9789593B5978ED7::_id_12B21(::isplacementplayerobstructed);
  level thread isplayerbrsquadleader();
}

isplayerbrsquadleader() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.player))
    waitframe();
}

isplacementplayerobstructed(var_0, var_1) {
  switch (var_0) {
    case "_encstr_A9E50E23D03103FF0F809FD263FF9BB3":
      level._id_13400.aq_ontimerexpired = [[level.players[0].origin, level.players[0].angles]];
      _id_135D3();
  }
}

_encstr_A29C1E462B265DD9F546B2371D9CBDCB7D310B1B637BEDE6BE19B263B0CB598C(var_0, var_1, var_2) {
  wait(var_2);

  if(isDefined(var_0.chopperexfil_sfx_before_sh070))
    var_0.chopperexfil_sfx_before_sh070 dodamage(999999, var_1.origin + (0, 0, 4000));
  else
    var_0 _encstr_AB2F19495E6468B8E2A39FC9832AF67804B9F12142C450607B97D1();
}