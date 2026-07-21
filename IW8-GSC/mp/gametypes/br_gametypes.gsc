/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametypes.gsc
***********************************************/

init() {
  level.disable_super_in_turret = spawnStruct();
  level.disable_super_in_turret.funcs = [];
  level.disable_super_in_turret.lmg_guys = [];
  level.disable_super_in_turret.move_ent = [];
  level.disable_super_in_turret.data = [];
  level.disable_super_in_turret.name = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101");
  level.disable_super_in_turret._id_12E05 = ::_id_12E05;
  level.disable_super_in_turret.unset_relic_aggressive_melee_params = ::unset_relic_aggressive_melee_params;
  level.disable_super_in_turret.tutorial_showtext = ::tutorial_showtext;

  if(level.disable_super_in_turret.name == "_encstr_8BBA05185F8B99")
    level.disable_super_in_turret.name = "_encstr_B40101";

  if(scripts\mp\utility\game::privatematch())
    _id_140D3();

  switch (level.disable_super_in_turret.name) {
    case "_encstr_86B508A91DA668F6226B":
      _encstr_BE6F2D6EB193D207A3375EDA83F23B58ADB2D197E0ACDC5E4C27F53B16B695E8BCE0ACFA8DDEB9D19CBDB1B8B3E68D::init();
      break;
    case "_encstr_866209ECEDB1197DEE0B4E":
    case "_encstr_BE180419DAE9":
      _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::init();
      break;
    case "_encstr_8F0E0583E4DB83":
      _encstr_8C9D2AD05F059188B39BAA4BD1861F33EAA86BB8BA618F17921E716F391139F3C92A8D0ED09B7DCB26F7BBD6::init();
      break;
    case "_encstr_AFDD05A6AB763B":
      _encstr_AC96303B47F878B7C3E3BA53A3CF5C1E4060FB8363D558CD2EFB8757078051247B91B5C85A10882755DB35D333B468EFC33E::init();
      break;
    case "_encstr_B18D0B5281530117EDEAC82033":
      _encstr_95E3306EC6935AE01DE6976B07F29D58DA5647E583B2B9BC13E4AFB32CB6CA1DE538B2F5D64B9B9D3736B0CB2B395CD99BB1::init();
      break;
    case "_encstr_87A205AF50D049":
      _encstr_83892ADAB6ED9A609B809E9FB0D82F42BBDD63D0A77BF3F7A19067AF40C8E5DB4BEFAFC1818B9AC9C5D0DFB7::init();
      break;
    case "_encstr_A919041BADA2":
      _encstr_8BA42933AAA31728E0029FD883166F8BB9E3230FF7738386CAA2793726728DDBEB80E73F95E2E32A3AA3AF::init();
      break;
    case "_encstr_85EE090C9DD0A62F3CA1B3":
      _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::init();
      break;
    case "_encstr_91190446A2B3":
      _encstr_810A290B2BF3F8F91BD2C0751F9F11A99BAFA36BE0ED88C69303412A88E52A83FB030F46DD606B3A97DF46::init();
      break;
    case "_encstr_A11804CEC338":
      _encstr_A621294F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD464177773BAA6C1AD0E7EF88DA88FE8FDE56::init();
      break;
    case "_encstr_A519044B436F":
      _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::init();
      break;
    case "_encstr_AD300C932B4C969CD1D0AF911346":
    case "_encstr_A254085207A6B7334B5A":
      _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::init();
      break;
    case "_encstr_A1D0081CC297B1EDB08C":
      _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::init();
      break;
    case "_encstr_A11804C81332":
      _encstr_88A5299A8793C1120B06B811419FAA97D8B7B311F2772BE6FEE3B9A84F75458DB862138137EEEA4634BE2B::init();
      break;
    case "_encstr_AAEF05B85A86E9":
      _encstr_AB142AB96C275AC13AE65EB6C1F2B3B0B6AC475EE0B29BCB31C9F5EC856B2BE8971C95FAA3324C195C9DB96C::init();
      break;
    case "_encstr_91070301C2":
      break;
    case "_encstr_8F94079C2BB3B2C21B":
      _encstr_85BA2C5B708D3CA3D3EE7F2507D0B746CB28B373500B7226C956072797A067CB4B182AA9A8D36B4781B14E5FB689::init();
      break;
    case "_encstr_BE6E094EB2B3CA1663F564":
      _encstr_A1AF2E47361A237BCB8BB657837A4F09550B0B3B90D06B98EE1A37F14AF8D595FFF98B3793980B7D71BA377AD280DAF6::init();
      break;
    case "_encstr_A95E0A98B78C2FC6F6AB9B1D":
      _encstr_BE892FF37E20B3A7F9EB480F4347E49013405B170BD24FBFAB2B78C8D210D51020A367CF0285029B86D0F3D0D1C242633B::init();
      break;
    case "_encstr_B4F40EE8C95685E657C92BAF43EA731D":
      _encstr_A238334E2ED323E39C2FA2B80BEF596B4AD745D3421ADFC0723319F037F5D189D33AB548DB834B714BC778E8E718EBC5AB353CE6F6::init();
      break;
    case "_encstr_816E079685517D0975":
      _encstr_AACC2CE68DE44B1CA3DCE55B0EBC3B0BAD5647E5C1959B79314EBED90BB559D1CB3859BEC9ABB5891B2B17D9DC1B::init();
      break;
    case "_encstr_BAA110C9BA5BC48D56D74BB9D92CCD4BBDE6":
      _encstr_8EB9354A267D0AD02B300E0F4028BFF22B4D1340178B63473193D75FD058756BBB5FDF71FE03DA52D850DF6F80D32943737865A5EC77F2::init();
      break;
    case "_encstr_831904FDF363":
      _encstr_8A8D2987EF43D3E804AA982892B7981F6A5F311B3B5AA64A2AC29E61FEADF0CD83F39BCF1B93EA8A479A01::init();
      break;
    case "_encstr_BD1D06DA5D98651B":
      _encstr_96AB2B37B1394BC13A37BC6BC1E5B3C26B568EE53895E6BC4C27F5B30B5B2B3AE50756AFC4C991B73B71CEB9D8::init();
      break;
    case "_encstr_B41904A39593":
      _encstr_972529932770BC2BD59B0ED20380BF7650832C1199A0420EF693017A0989CF6B5851B5AFF918CAC22CABDA::init();
      break;
    case "_encstr_A11904D82B38":
      _encstr_AC5329EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6FE3500FA333A39A19809D93FDA0278B::init();
      break;
    case "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95":
    case "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8":
      _encstr_B84C35676F9E32D038FB45DD730A0F4AF98BE3C7F14DDBF7D0E341A7492055534B392FE79DE51279784B84A103088E9AA697D7AA2F164A::init();
      break;
    case "_encstr_97AB06BBB583D1F5":
      _encstr_84C12B5E3BD36173A35AF239F730FFD7D02193E3D16512359063A108C71355D1A3137F37DE65F773D0C074024E::init();
      break;
    case "_encstr_920A0862BD63CB5FC758":
      _encstr_A7232D8B3F68A4C33D63E6CA2BB8A71E38AB04F971886A76EEBBF95211E1E79360298D57CD60B25305B143CEB9C627::init();
      break;
    case "_encstr_8AE1099A0B999F2D28AF15":
      _encstr_BA6F2E3318E5A43B7B56C78DEF285FEE73B0CBEBE8939A8E513EAFBF0F081F73A3B04201407393170BAF9BB5B0919FFE::init();
      break;
    case "_encstr_9286085A21B8034D3863":
      _encstr_87BD2DF34710DC4BB5FB6E72A3205F96B0238C71F92BE2EE563361DAE9696F0BF8B115CF6BF86D8B88EB9A5631BEBF::init();
      break;
    case "_encstr_AD51088015D1E2D47930":
      _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::init();
      break;
    case "_encstr_BDC40FADBA1BE8969B17BA2C23FA0ED959":
      _encstr_8894343736E44B1CD1CDBCB61CE53BC26BB2E8CBE0CA9BE598C9FAB3B0ADAC1DCBE056EBAD57638E5AB95CEA8546EB1CD995C5B39BB1::init();
      break;
    case "_encstr_B40101":
      break;
    default:
      break;
  }
}

setup_vehicle_wave_by_player_count() {
  exitlevel(0);
}

_id_140D3() {
  if(!getdvarint("_encstr_85EB1D0BBFE8A90BBE6693BB4E943FDD98299174DBD9EFCFE9D9CB33B3653F", 1)) {
    return;
  }
  var_0 = getDvar("_encstr_A9821A50C790BF4DD348621DF7AB59EBFC8D29B14EF3829C2A9F2073", "_encstr_B40101");
  var_1 = getDvar("_encstr_8CED1C3FBB4A29FE0331B3FB5907A038261CB3991FF710B1679BEAA3C2B7", "_encstr_B40101");
  var_2 = strtok(var_0, "_encstr_974C0246");
  var_3 = strtok(var_1, "_encstr_974C0246");

  foreach(var_5 in var_2) {
    if(level.disable_super_in_turret.name == var_5)
      return;
  }

  foreach(var_5 in var_3) {
    if(level.disable_super_in_turret.name == var_5) {
      setup_vehicle_wave_by_player_count();
      return;
    }
  }

  switch (level.disable_super_in_turret.name) {
    case "_encstr_A11804C81332":
    case "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95":
    case "_encstr_AD300C932B4C969CD1D0AF911346":
    case "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8":
    case "_encstr_A254085207A6B7334B5A":
    case "_encstr_87A205AF50D049":
    case "_encstr_866209ECEDB1197DEE0B4E":
    case "_encstr_8AE1099A0B999F2D28AF15":
    case "_encstr_BE180419DAE9":
    case "_encstr_B40101":
      return;
  }

  setup_vehicle_wave_by_player_count();
}

_id_12B11(var_0, var_1) {
  if(isDefined(level.disable_super_in_turret.funcs[var_0]))
    scripts\mp\utility\script::laststand_dogtags("_encstr_8CBF24DEBF9233B3AC4758D173F78943DA63D3671758C3D8636AD8D86BED4199A31EC3676A96" + var_0 + "_encstr_A2920A0291CACCB49B5923C5");

  level.disable_super_in_turret.funcs[var_0] = var_1;
}

_id_12E08(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return [[level.disable_super_in_turret.funcs[var_0]]](var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_12E05(var_0, var_1, var_2) {
  if(isDefined(level.disable_super_in_turret.funcs[var_0])) {
    if(isDefined(var_2))
      return [[level.disable_super_in_turret.funcs[var_0]]](var_1, var_2);
    else if(isDefined(var_1))
      return [[level.disable_super_in_turret.funcs[var_0]]](var_1);
    else
      return [[level.disable_super_in_turret.funcs[var_0]]]();
  }
}

_id_12E06(var_0, var_1, var_2, var_3) {
  if(isDefined(level.disable_super_in_turret.funcs[var_0]))
    return [[level.disable_super_in_turret.funcs[var_0]]](var_1, var_2, var_3);
}

_id_12E07(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.disable_super_in_turret.funcs[var_0]))
    return [[level.disable_super_in_turret.funcs[var_0]]](var_1, var_2, var_3, var_4);
}

_id_13F25(var_0) {
  level.disable_super_in_turret.funcs[var_0] = undefined;
}

tutorial_showtext(var_0) {
  return isDefined(level.disable_super_in_turret.funcs[var_0]);
}

load_sequence_3_vfx(var_0) {
  level.disable_super_in_turret.lmg_guys[var_0] = 1;
}

unset_relic_aggressive_melee(var_0) {
  return isDefined(level.disable_super_in_turret) && istrue(level.disable_super_in_turret.lmg_guys[var_0]);
}

move_molotov_mortar(var_0) {
  level.disable_super_in_turret.move_ent[var_0] = 1;
}

unset_relic_aggressive_melee_params(var_0) {
  return isDefined(level.disable_super_in_turret) && istrue(level.disable_super_in_turret.move_ent[var_0]);
}

_id_12B10(var_0, var_1) {
  level.disable_super_in_turret.data[var_0] = var_1;
}

reinforcement_manager(var_0) {
  return level.disable_super_in_turret.data[var_0];
}

tutorial_pullchute(var_0) {
  return isDefined(level.disable_super_in_turret.data[var_0]);
}