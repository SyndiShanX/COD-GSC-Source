/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_mendota.gsc
************************************************/

activate_punchcard() {}

activate_gas_trap() {}

init() {
  _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::init();
  level thread _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::enabledskiplaststand();
  level thread _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::enable_traversals_for_bombers();
  level thread _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::init();
  test_anim_ai();
  level thread time_reduction_bonus();
  level thread testaccessoryvfx();
  level thread teamstarttime();
  level thread toggleusbstickinhand();
  level thread subtract_from_spawn_count_from_group();
  level thread init_locations();
  level._id_13364 = 1;
  level._id_133D7 = 1;
  level.disable_back_light = 1;
  level._encstr_85531EA9C4DB7118F503C8E8E337B0BD12AA1EA31FA23F20DA6FA068E72EA9EF = level._id_11BCE._encstr_85531EA9C4DB7118F503C8E8E337B0BD12AA1EA31FA23F20DA6FA068E72EA9EF;
  level._id_142D1 = "_encstr_B23915B26BC8B7F089ABF3E453E8BFCF09613AAA1035A7";
  level._encstr_B2011828C9171F67C897152022632A439313B07A51E047EDB5D7 = "_encstr_A91218AF98F65783979BEA25F78D1A375983EF179808BC1AE9A7";
  level.train_hurt_damage_watcher = [];
}

test_anim_ai() {
  level._id_11BCE = spawnStruct();
  level._id_11BCE.juggernaut_setupexecute = getdvarint("_encstr_BDAC233656AB3728E5C35010B339A68962BFA7BDEDA36FF3CD5FF868975EFE298AE42C4B43");

  if(isDefined(level._id_11BCE.juggernaut_setupexecute) && level._id_11BCE.juggernaut_setupexecute > 0)
    level._id_12CA7 = level._id_11BCE.juggernaut_setupexecute;

  level._id_11BCE._id_127B6 = getdvarfloat("_encstr_B28F1FB91B4E7DB5B2DC8CDE8E85AF0EC6579B2395E44493DEC1A0B227B1ACCDA3", 0.3);
  level._id_11BCE._id_127B5 = getdvarfloat("_encstr_86381EAFC76BE0383DC5E9806BE171AF62671D1977D325885F5A75D855DDB0E5", 0);
  level._id_11BCE._id_127BE = getdvarfloat("_encstr_8FC11FBB0F5819676510A21A7B4F770A40DB2E34ABE0540F1DCBD9A24396D7C5D8", 0.6);
  level._id_11BCE._id_12C9A = getdvarfloat("_encstr_868521CD1B9CAF6BACB98C7B3A58AF272BDC1CC2DDDCAF1DB4ADACFA469599C2EAD8A3", 5);
  level._id_11BCE._id_12C99 = getdvarfloat("_encstr_AF3F28AE3BEAC9A98D7520688957EF8AC17353F0C888E81B8220508106484D57B8C12BEFC0C9AB51DCC5", 2);
  level._id_11BCE._id_1385A = getdvarint("_encstr_9ADA2937C64EAFDAB2E646EDA32CF5B93A0B4E1D96B9D9AF4E2B6E0E2CBBE6FA477BADAC73EBD8DEEA738E", 0);
  level._id_11BCE._id_13857 = getDvar("_encstr_A35726BE6BC3E6CB4FFA23507366F73BB31146B5C90B2967F5F21010BA3B697667BD472F57E396C3", "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  level._id_11BCE._id_13858 = getDvar("_encstr_AC5726B39865A9CFD9580C0F6D613FEAC1102BBBA0051FCF1030113C888BDB393F98827328EDD922", "_encstr_B805127C9C59D94398C193AE10710632593B0577");
  level._id_11BCE._id_13856 = getDvar("_encstr_A32A24CFC7C60995D820FF055BC09F839D5B43ABBB60326F78E8B6CF5008FC9979FBC3531399", "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
  level._id_11BCE.triage_glass_break = getdvarint("_encstr_BD2025CD6CE4F5DA2B9B19EDD116BEA5DCE89536FACD56AC7DCCC9A5599B23B197D78C9CEDC1DC", 0);
  level._id_11BCE._encstr_8AEA13F673BE96B9A3B2D8AF0E5A1BD6BAC1F5C30E = getdvarint("_encstr_A1F31FDC1BC9F5B556CD19B73A85FAF637F55AE6E859B17DE04B36B5EA1C7D870E", 25);
  level._id_11BCE._id_11FE8 = getdvarint("_encstr_B1EC2A9F728A6EE8F73AD167A30E9EBDF507789D3B35613FFB297F0B3D50AFFBDFE9B8F83926AB4947E13839", 1);
  level._id_11BCE._id_11FE7 = getdvarint("_encstr_93F6299BD8C9EBB5AC9B32ED3AC2BEEDCDAF96CD3AACC67D0796B1B5EA1CD78539DADE9CEB27ACCCB4C61B", 1);
  level._id_11BCE._id_11FE6 = getdvarint("_encstr_911F2842880AD6136FD0CA1FBB7FA110CD0F11580C1F4D11233B4B085F3BD10F909F10013BC7AF93136B", 1);
  level._id_11BCE._id_11FEA = getdvarint("_encstr_AB232B8F8706C95518E03FC59B0B5F02D0676F034125422FD868F6CC5360979BB7BBC7A3AF5B2ACB10F16ED249", 1);
  level._id_11BCE._id_11FE9 = getdvarfloat("_encstr_955F2F03590E4765689534378960A13FB8763A5A436D43D198E32B0B93107977DCA903022B33739709D1351A5318BCAF08", 6);
  level._id_11BCE._id_14199 = getdvarvector("_encstr_888023371BC97D5B2BE646F61D85F5CE56A1B48DC695BEA5B538EAC637B2FACECAC61DBD9C", (0, 0, 0.5));
  level._id_11BCE._id_14198 = getdvarfloat("_encstr_9AE32697DED51790DA204928D1E811B3176B8FEA9413317BE520FBC3906229778F37602773DF5511", 150.0);
  level._id_11BCE.train_lootcrates_save_offsets = getdvarint("_encstr_BA51185A366D79FD39E83317109197423DD5A715B0FB233DA020", 1);
  level._id_11BCE._id_11BEA = getdvarint("_encstr_84E423889F62E6D35265C558FBCA6F68D11361C0C31CF999D9CE4BDE1672539609FB232803", 2);
  level._id_11BCE._id_11B48 = getdvarint("_encstr_8FF123A33F9B791B35FE534FEB5A08ADC2F2D15CCACB95B366108A5A17502B1764A88949C0", 6);
  level._id_11BCE.infil_light_dvars = getdvarint("_encstr_8A2C1EB7630A67054143D31A8B47216915A128A881501EBB3FCD5769D56B3845", 30);
  level._id_11BCE._id_11BEB = getdvarint("_encstr_92B11C6A264B0988451E6327404BD912E0D0FF7C863DCB6B25A307804990", 20);
  level._id_11BCE._id_11B49 = getdvarint("_encstr_8CB11CE603AB8EB3379258F8CBCE1F8003BC65D1A79FD3FBDD1B89E0B2A0", 30);
  level._id_11BCE._id_11F1E = getdvarint("_encstr_BAB91E1F9B6A09597F0251388B4718E005E44BA93F178895ABBB0EC3A23F46F8", 1);
  level._id_11BCE.train_get_num_of_anim_ents = [];
  level._id_11BCE.train_get_num_of_anim_ents["_encstr_A94C02B6"] = getdvarint("_encstr_96101FAE20EB510367808B5773468030E134DDA95060DFB22336132B099DF060EB", 2000);
  level._id_11BCE.train_get_num_of_anim_ents["_encstr_A74C0277"] = getdvarint("_encstr_9B1F1F3E4E8B48C5F9A3497821895F2F29F3BB43375061E69DBBB9C57117C39B3B", 6000);
  level._id_11BCE.trial_fetch_mission_table = getdvarfloat("_encstr_923D1A9713F29156ABA9F84243479EB04E7C3357B59CC0305BE2F0E9", 60);
  level._id_11BCE.trial_explosive_clear = getdvarfloat("_encstr_A1491A336A93F840D2179BC940F11B3687B3493E1237A3716B0993FB", 90);
  level._id_11BCE._encstr_9130145ACDA3B21B465AC2D8BDCE1BEDDB638CBDDDCD = getdvarfloat("_encstr_A93C1E9B1B93FADAE11C7D5AE63A561BAF462D0B63DE3BBE8DBD7BD832B7DDCD", 30.0);
  level._id_11BCE._encstr_8BBC099B5EE399E1655288 = getdvarint("_encstr_A7D412B96C27FA5BF01CBEB49B3A59B1FADA58F0", 150);
  level._id_11BCE._encstr_BA930B5AE6E82B8D39ACDC563A = getdvarfloat("_encstr_8BAC14731E7AB18043EB9061F0995F90574B470660F4", 3);
  level._id_11BCE.vo_while_reviving = getdvarint("_encstr_887F26371BC97D5B2BE646F61D85F56D96B136CD47C9CA85ADAFC89637B0138DCABED8A59C6C1B59", 8);
  level._id_11BCE._encstr_85531EA9C4DB7118F503C8E8E337B0BD12AA1EA31FA23F20DA6FA068E72EA9EF = getdvarint("_encstr_B8EB2A5780D3FF726398AF65FD132984D8A0C3931809314B4938755B6D1D3359C140B797D98775028748BB12", 30);
  level._id_11BCE._encstr_AB9B1AD80BC3E9B40BF9C229C8732929EFB9A918C7A585B2552378A2 = getdvarint("_encstr_BD41226EC639D799D2CD2CB1AF1BB4C9BE915AB93A7D6627BDDAFA66272B9BB9DEBEC13A", 6000);
  level._id_11BCE._encstr_97701D332DC99B3AB1A54E6C1BACB6B0E132D2CDA33327DBD66CB2371D2B27 = getdvarint("_encstr_AC73238B0AE2EE112963AFB3384E1103D720C1ABD774072A61E907F3E7BBF01FA0700BD9ED", 30000);

  switch (getdvarint("_encstr_B1631997FF53D810E51D017883C9490E5A132F219FE996C03D3709", 1)) {
    case 0:
      level._id_11BCE.groundentity = [0, 120, 90, 75, 60, 45, 30, 0];
      level._id_11BCE.ground_spawners = [1, 150, 120, 120, 105, 105, 150, 10];
      break;
    case 2:
      level._id_11BCE.groundentity = [0, 120, 90, 60, 45, 45, 30, 0];
      level._id_11BCE.ground_spawners = [1, 150, 120, 90, 90, 90, 150, 10];
      break;
    case 3:
      level._id_11BCE.groundentity = [0, 30, 10, 10, 10, 10, 30, 0];
      level._id_11BCE.ground_spawners = [1, 20, 10, 10, 10, 10, 10, 10];
      break;
    case 4:
      level._id_11BCE.groundentity = [0, 90, 75, 60, 45, 30, 0];
      level._id_11BCE.ground_spawners = [1, 120, 120, 105, 90, 150, 10];
      break;
    case 5:
      level._id_11BCE.groundentity = [0, 30, 10, 10, 10, 30, 0];
      level._id_11BCE.ground_spawners = [1, 20, 10, 10, 10, 150, 10];
      break;
    case 1:
    default:
      level._id_11BCE.groundentity = [0, 120, 90, 75, 60, 45, 45, 0];
      level._id_11BCE.ground_spawners = [1, 150, 135, 135, 120, 105, 105, 10];
      break;
  }

  if(getdvarint("_encstr_A9462717A7D3506570D085621389509471386B52A9BBF7F2588E95CB0993AB0983426BA5D7C4782A78", 0))
    level.delaystreamtomovingplane = 1;

  if(getdvarint("_encstr_8501269B1B93D7DA2BB932B74785FA232C73CE2B9C39EDA3D2992F1AEA9B1D7BAD5AF485E8A5BDCD", 1)) {
    level.isbotpracticematch = getdvarfloat("_encstr_B485217F779659C588508F550B702F22E795A7BFFD2002948079C0568028545A480F7B", 20);
    level.isbrgametypefuncdefined = [];
  }

  setDvar("_encstr_994C161B30CDF1AB53B87566CDD853076FE852B2805937CB", 1);
}

time_reduction_bonus() {
  level.tread_sfx = [];
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("_encstr_B6EC1793C99ED7362007ADB031217A6744213B6AD6F9E7AAD0", 20), ::translate_and_rotate_from_level_overrides);
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("_encstr_8F981A92FEB5A13A1399DF93F86EE2CA47075ACF481F1A545908F7CB", 40), ::transitionac130tomovinganim);
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("_encstr_864218CD8D9CBE1339FAB6C338AF9C5977B03946EB34CA8567F2", 60), ::trap_room_ents);
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("_encstr_BAE61AEE8E73EF013A3F50F0EB7F5BC38BB6E6FD696A47A914E7E888", 80), ::trap_timer_running);
  level.tread_sfx[level.tread_sfx.size] = tree_think(getdvarint("_encstr_96EC199B1BC9D7319CEBD687E0D793CA77584E32AFDCE8E4A5D62B", 100), ::trap_door_nvg_reset);
}

teamstarttime() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_13F25("_encstr_85DC0CB2A8BE0795B831C9C57B28");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_13F25("_encstr_A549125D02CF7BE7E581E8980BFF55355FB9DDC3");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_85DC0CB2A8BE0795B831C9C57B28", ::circletimer);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::_id_126F1);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_81EC15B516C11A959B1D9527645ACDC28D68D2E48D36B2", ::_id_12181);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_96F01524FD4B55733DBAD0A152521F686743BD2844D71B", ::_id_12181);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_938917C18D85CB56391DAE8D85D928AED17B5DA5735D16D28E", ::_id_125BD);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_86342022A8D774B7E8B66875B67377FB0758F95A01692FEFC387546DC7583FC04BF0", ::assignspectatortospectateplayer);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8F351F39D6AB5F8FECFFB840AB1923CBF27CA1B36DF23911CCAF0839EF5C98339A", ::_id_11B16);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A549125D02CF7BE7E581E8980BFF55355FB9DDC3", ::droponplayerdeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A4319E0710B51CAC6649BE8B2B33B4DD36D17ABDC83956D875BD0", ::playerdropplunderondeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AC0212205BFB68E398F4B8856F9130F645CD7B63", ::_id_12356);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A3520F98B579CF8963A77888B39D632B92", ::onusecompleted);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8503121B0B7315C25B9528B436ADAB83897BDEA3", ::get_chopper_minigun_start_node);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_837E130AB898A0C97307176749BCC2ED5821069650", ::_encstr_837E130AB898A0CB7307176749ACC2ED5821069650);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BDB80B883AF4FB3F9F23F2F528", ::_id_13A36);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A9AA0E883DC1080E933F2903C3CADDF8", ::initcratedata);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_85CF15FB58113912AD660FC6D3953BE01DE87F47C0689D", ::_id_12646);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BE1E0F5A85968803C329ED980B5183B325", ::_id_12A7C);

  if(getdvarint("_encstr_A2EE19283FC2466D834921B39A89AD882AFF3048676BD805FAAD2D", 0) == 0) {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3", ::init_relic_aggressive_melee);
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_B1130F58C89145BD6813990CA473335A36", ::being_hacked);
  }

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  level thread _id_14148();
}

_id_126F1(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;

  if(!istrue(level.br_infils_disabled))
    self waittill("_encstr_8F9C0E528823754F286C8799F07117BD");
  else
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  scripts\mp\hud_message::showsplash("_encstr_91301C984EFAB358D659E8F2C1CAFAAD59738CBDD12CF5DDB2638DBDB595");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A5F909EC0B5B2B8EF20ECA", self, 0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1", self, 0);

  if(istrue(self.tutorial_usingparachute))
    level _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_872514BBE31FE24FD0FED25A53F88C29F90B37335B46", self, 1, 0, 4.5);

  if(!istrue(level.br_infils_disabled)) {
    self waittill("_encstr_8F7D08C66A0125438523");

    if(isDefined(game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2140B22D9CD77E4F9C1756BE7"]))
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A2140B22D9CD77E4F9C1756BE7", self, 0);

    while(!self isonground())
      waitframe();
  } else
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);
  wait 1;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A208140EDD37501DDFDA401011353D488743158B26F7", self, 0);
}

iscarriablescriptable() {
  self waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      onplayerdisconnect(var_1);
  }

  foreach(var_4 in level._id_13748) {
    if(isDefined(level._id_13457)) {
      [[level._id_13457._id_13738]](var_4.total, var_4.bridge_tank_move_sfx, var_4.nextplayertospectate);
      [[level._id_13457._id_1373B]](var_4._id_12D24);
    }
  }

  if(istrue(level._id_145C1) && isDefined(level._id_13457))
    [[level._id_13457._id_145C1]]();
}

onplayerdisconnect(var_0) {}

init_relic_gas_martyr(var_0, var_1) {
  var_2 = init_relic_grounded(var_1);
  var_2 init_relic_gun_game(var_0);
  var_2 init_relic_headbullets(var_0);
  return var_2;
}

init_relic_grounded(var_0) {
  if(isDefined(var_0))
    return var_0;

  var_1 = spawnStruct();
  var_1.total = 0;
  var_1.set_flag_after_vo = 0;
  var_1.bridge_tank_move_sfx = 0;
  var_1.nextplayertospectate = 0;
  var_1._id_12D24 = 0;
  var_1._id_122EF = 0;
  var_1.openrightblimadoor = 0;
  return var_1;
}

init_relic_gun_game(var_0) {
  self.total = var_0 train_play_anim();
  self.set_flag_after_vo = var_0 train_move_test_train_car_thread();
  self.bridge_tank_move_sfx = var_0 train_minimap_icon_attach();
  self.nextplayertospectate = var_0 train_minimap_icon_detach();
  self._id_12D24 = var_0 trap_consoles();
}

init_relic_headbullets(var_0) {
  if(!isDefined(var_0.spectatetestonprematchfadedone))
    self._id_122EF = 1;
  else
    self._id_122EF = var_0.spectatetestonprematchfadedone;

  if(!isDefined(var_0.spawntimestamp))
    self.openrightblimadoor = 0;
  else
    self.openrightblimadoor = var_0.spawntimestamp;
}

init_relic_healthpacks(var_0, var_1) {
  var_2 = init_relic_landlocked(var_1);
  var_2 init_relic_hideobjicons(var_0);
  return var_2;
}

init_relic_landlocked(var_0) {
  if(isDefined(var_0))
    return var_0;

  var_1 = spawnStruct();
  var_1.total = 0;
  var_1.set_flag_after_vo = 0;
  var_1.bridge_tank_move_sfx = 0;
  var_1.nextplayertospectate = 0;
  var_1._id_12D24 = 0;
  return var_1;
}

init_relic_hideobjicons(var_0) {
  self.total = self.total + var_0.total;
  self.set_flag_after_vo = self.set_flag_after_vo + var_0.set_flag_after_vo;
  self.bridge_tank_move_sfx = self.bridge_tank_move_sfx + var_0.bridge_tank_move_sfx;
  self.nextplayertospectate = self.nextplayertospectate + var_0.nextplayertospectate;

  if(var_0._id_12D24 > self._id_12D24)
    self._id_12D24 = var_0._id_12D24;
}

setupkeybindings(var_0, var_1) {
  if(isDefined(level._id_13457)) {
    [[level._id_13457._id_12540]](var_0, var_1.total, var_1.bridge_tank_move_sfx, var_1.nextplayertospectate);
    [[level._id_13457._id_12650]](var_0, var_1._id_12D24);
    [[level._id_13457._id_125D1]](var_0, var_1._id_122EF);
    [[level._id_13457._id_12556]](var_0, var_1.openrightblimadoor);
  }
}

_id_11BCF(var_0, var_1) {
  switch (var_0.type) {
    case "_encstr_AC7B1160BB2FC0A38247E0751EC9E3E86C9F98":
    case "_encstr_AA751A4CE4637BDEA3D7D62B9B32DEE8C2BE4BE61DCA36BEB4C6ED73":
    case "_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED":
      var_0 trainent(var_1);
      return 1;
  }

  return 0;
}

testaccessoryvfx() {
  if(getdvarint("_encstr_8AEA15371BE4F5B52B37C8B78E58FAE0368597A3ACCDE8", 0))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");

  level.decoyassists = ::groundz;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A9C319ABE6958ADBB6CAE651DB94ACECD2D995A29585D6B5B03AAC");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_97C92259EBD4B00CB16F0D0577CBDE286303C073172C0837DA0F2309AF239D711D9D8929");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8C100FC793A0BFF07F07F30773956AE520");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A1B50F226F23E2F0A1FB78932245C75325");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_95F80E992D399B1D345A93B18DB295F6");

  if(getdvarint("_encstr_874B185B708DB1EB13F83D3007DEE347D548D3A3907F752308D3", 1) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");

  if(getdvarint("_encstr_A2EE19283FC2466D834921B39A89AD882AFF3048676BD805FAAD2D", 0) == 0) {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_A92C15EAC13B1A65AF90871768635B829B7636673B4B83");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC");
  }
}

toggleusbstickinhand() {
  waittillframeend;
  level thread superterrainlightbakelodoverride();
  level thread _id_127F7();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B33("_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED", ::trial_gethitmarkerpriority);
}

_id_127F7() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8C4512C19C95E9E6141B0BBC2BC9B496D8B1AC32", ::onplayerkilled);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97D311FBD1FDFCADD2C9E888A7D50FD3890F07", ::dangercircletick);
  level thread _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::init();
  level._id_126C2 = [];
  level._id_13748 = [];

  foreach(var_1 in level.players) {
    var_1 trial_dogtags();
    var_2 = var_1 getentitynumber();
    level._id_126C2[var_2] = init_relic_grounded();
    level._id_13748[var_1.team] = init_relic_landlocked(level._id_13748[var_1.team]);
    var_1 _id_12604();
  }

  level thread iscarriablescriptable();
}

subtract_from_spawn_count_from_group() {
  wait 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_A56C0FE7AFFA9D904122E9A64B09C8C762";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1"] = "_encstr_8FBD147A21B9870BD0C14D6FF16892D7C8FB12D38980";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A208140EDD37501DDFDA401011353D488743158B26F7"] = "_encstr_997C18B73743ADDBCD43EBB4E6E8ACD87DB0D9C25A36589863B2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BEB1130FC8CBEB4A5B2E493A1D5F93A231C0438730"] = "_encstr_86FA1BBDCD86DA7BCD43FA8DB49CC66356F51BD8DECD597DA3B4A385E6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99E70E06C86A1A92A533B8DCA190BA5A"] = "_encstr_A1B51F0227A062C8C0982197E446BFBBAFE0D7596FB357901A52CF93FF0597E82F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3CF18B740B02C128F750F47C8AB8AE6B9303F6329C8964BEB01"] = "_encstr_BDCC17B7CDD0D6EDDC86FAB49BA3B263FAB08DC5574B9CB291";
}

achievementtrackerforkills() {}

dangercircletick(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_1;
  isbotmedicrole(var_2, var_3, level.dogtags, ::train_associate_models_with_brushes);
  isbotmedicrole(var_2, var_3, level.train_hurt_damage_watcher, ::train_get_anim_ents_index);
  isbotmedicrole(var_2, var_3, level.shutdownattractionicontrigger, _encstr_8ACF2EEE8E7383433C8F4258EB0FF9CB2AB7E573A2FA7F601293B96887991333515BD5F73AF23D56FCBB30A042B7CBBF::shut_down_laser_trap);
}

isbotmedicrole(var_0, var_1, var_2, var_3) {
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    if(isDefined(var_6) && distance2dsquared(var_6.origin, var_0) > var_4)
      var_6[[var_3]]();
  }
}

_id_11B16() {
  return 0;
}

_id_125BD(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0)) {
    if(level._id_11BCE._id_12C9A) {
      self.chopper_boss_combat_actions = 1;
      var_2 = level._id_11BCE._id_12C9A;
      wait 3;

      while(istrue(self.killcam))
        waitframe();

      thread _id_1336E(var_2);
      thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(self, 0, 1);
      wait(var_2);
      self.chopper_boss_combat_actions = undefined;
      return 1;
    }
  }

  return 0;
}

_id_13DCB(var_0) {
  return 1;
}

assignspectatortospectateplayer(var_0, var_1) {
  var_0 notify("_encstr_B43F2B467380716238AFC36F37DDCAA4B8FBB34DEFF0057A0DE3DB677989B2F14003FB56C068EE726691876F1B");

  if(istrue(level.endmatchcameratransitions))
    return 0;

  if(!isDefined(var_1) || !isPlayer(var_1) || !isalive(var_1) && !isDefined(var_1._id_1391A))
    return 0;

  if(var_0.team == var_1.team)
    return 0;

  if(!scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_8A2A0B936CCCC3078547970A8B"))
    return 0;

  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 1);

  if(var_2.size == 0)
    return 0;

  thread cargo_truck_mg_mp_init(var_0);
  return 1;
}

cargo_truck_mg_mp_init(var_0) {
  level endon("_encstr_918D15899CA638B0DDB982D8B0CBB2273715DC8C4BB93B");
  var_0 endon("_encstr_B43F2B467380716238AFC36F37DDCAA4B8FBB34DEFF0057A0DE3DB677989B2F14003FB56C068EE726691876F1B");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_126AB();
  var_0 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", var_0 getentitynumber());
  wait 1.0;
  var_1 = _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::regive_killstreak_after_use(var_0);
  thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::assignspectatortospectateplayer(var_0, var_1);
}

onplayerspawned() {
  if(isDefined(level._id_142D1))
    self visionsetnakedforplayer(level._id_142D1, 0);

  thread _id_14012();
  trial_dogtags();
}

onplayerkilled(var_0) {
  if(!istrue(level.disable_super_in_turret._id_12CA4))
    thread juggerbear();

  var_1 = var_0.inflictor;
  var_2 = var_0.attacker;

  if(isDefined(var_2) && (!isDefined(var_1) || var_1.classname != "_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B" && var_1.classname != "_encstr_85FE0DD5727A27098513298817CA23")) {
    var_3 = getdvarint("_encstr_AFCD22B9C6C9BE26C9EB5BE138BE96733A95C6F58C4EBDE00EAC46EBDBDC7D46CA581DA1", 5);
    level thread train_initcollision(self, var_2, var_3);
  }

  if(getdvarint("_encstr_874B185B708DB1EB13F83D3007DEE347D548D3A3907F752308D3", 1) == 0 && !istrue(level.disable_super_in_turret._id_12CA4))
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::trygulagspawn();

  if(istrue(level.disable_super_in_turret.brlootchoppercratedestroycallback))
    _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_845B19233551F8851B93AD93E3535C50FA8B48189EB0E0C862BFA5(var_2, self);
}

_id_14148() {
  while(!isDefined(level.vehicles) || !isDefined(level.vehicles.damagecallbacks))
    wait 0.1;

  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_8C190467402B", ::_id_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", ::_id_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_85DE05A6B2AC0E", ::_id_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_9A120A1D8536F5E4ED3BB293", ::_id_14202);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", ::_id_14202);
}

_id_14202(var_0) {
  if(isDefined(var_0.direction_vec) && isDefined(var_0.meansofdeath) && isexplosivedamagemod(var_0.meansofdeath)) {
    var_1 = level._id_11BCE._id_14199;
    var_2 = level._id_11BCE._id_14198;
    self _meth_87C1(var_0.direction_vec + var_1, var_2);
  }

  return 1;
}

_id_12604() {
  if(!isDefined(self._id_12EB0)) {
    var_0 = getcompleteweaponname(level._id_11BCE._id_13857);
    var_1 = scripts\mp\class::fixcollision(level._id_11BCE._id_13858, "_encstr_96C8098FDBB937AFFB32F2", undefined, -1);
    var_2 = getcompleteweaponname(level._id_11BCE._id_13856);
    var_3 = scripts\mp\equipment::getequipmentreffromweapon(var_2);
    self giveweapon(var_0);
    self giveweapon(var_1);
    self switchtoweaponimmediate(var_1);
    self assignweaponprimaryslot(var_1);
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9", var_1.clipsize * 2);
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
    self notify("_encstr_B2110C63C02DC5E92388229F9D75");
    scripts\mp\equipment::giveequipment(var_3, "_encstr_BA7F0830B3A7859B60B0");
    scripts\mp\weapons::fixupplayerweapons(self, var_1);
  } else
    _id_125FB();

  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::scriptablescurid(150);
}

trial_active_fob(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  if(var_3 == 0) {
    return;
  }
  if(isDefined(var_0) && isDefined(var_1))
    return trial_alternate_progression(var_0, var_1, var_3);

  if(isDefined(var_2))
    return trial_ai_spawn_far(var_2, var_0, var_3);
}

trial_alternate_progression(var_0, var_1, var_2) {
  if(!train_array(var_0)) {
    return;
  }
  var_3 = trial_ai_spawn_far(var_0.origin, var_0, var_2);
  var_3 trial_callback_ai_damage(var_0, var_1);
  return var_3;
}

train_array(var_0) {
  if(isagent(var_0))
    return 0;

  return 1;
}

trial_combo(var_0) {
  if(level._id_11BCE.triage_glass_break >= 1) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_3 in var_1)
  self disablescriptableplayeruse(var_3);
}

trial_callback_ai_damage(var_0, var_1) {
  var_1 = train_sfx_init(var_1);
  self.team = var_0.team;
  self.victim = var_0;
  self.victimteam = var_0.team;
  self.attacker = var_1;
  self.attackerteam = var_1.team;
  self.owner = var_0;
  self.ownerteam = var_0.team;
}

trial_ai_spawn_far(var_0, var_1, var_2) {
  var_3 = trial_active_ring(var_0, var_1, var_2);
  var_3 trial_celebration_flares(var_2);
  var_3 trial_dlog_clear(var_2);
  var_3 trial_combo(var_1);
  var_3 trial_dlog_lava(var_1);
  return var_3;
}

trial_gethitmarkerpriority() {
  self.spawntime = gettime();
  var_0 = train_elements_enable(self.count);
  trial_celebration_flares(var_0);
}

trial_active_ring(var_0, var_1, var_2) {
  var_0 = var_0 + trial_callback_ai_killed(var_1);
  var_3 = trial_ai(var_0, var_1, var_2);
  var_3.spawntime = gettime();
  return var_3;
}

trial_ai(var_0, var_1, var_2) {
  var_3 = undefined;

  switch (var_2) {
    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
      var_3 = trial_dlog_arm_course(var_0, var_1);
      break;
    case 5:
    case 4:
    case 3:
    case 2:
    case 1:
    default:
      var_3 = trial_ai_jugg(var_0);
      break;
  }

  return var_3;
}

trial_dlog_arm_course(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1))
    var_2 = var_1 getentitynumber();

  var_3 = easepower("_encstr_AA751A4CE4637BDEA3D7D62B9B32DEE8C2BE4BE61DCA36BEB4C6ED73", var_0, undefined, undefined, var_2);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_3);
  return var_3;
}

trial_ai_jugg(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setModel("_encstr_B4A81ADDA8E0E93BC7958F1F8B78035D48F6966206B0AD52AD57A3DF");
  return var_1;
}

trial_callback_ai_killed(var_0) {
  if(!isDefined(var_0))
    return (0, 0, 14);

  var_1 = (0, 0, 0);
  var_2 = var_0.angles;

  if(var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var_2 = self getworldupreferenceangles();
    var_1 = anglestoup(var_2);

    if(var_1[2] < 0)
      return (0, 0, -14);
  }

  return (0, 0, 14);
}

trial_celebration_flares(var_0) {
  trial_dlog_race(var_0);
  trial_civilians_killed();
  trial_delete_out_of_bounds();
}

trial_dlog_race(var_0) {
  var_1 = undefined;

  if(train_wzcircle_override())
    var_1 = "_encstr_B40101" + self getentitynumber();
  else
    var_1 = self.index;

  self.start_reach_wind_room = var_1;
  level.dogtags[var_1] = self;
  trial_dlog_sniper(var_0);
}

trial_dlog_sniper(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.count = trial_dogtag_setup(var_0);
}

trial_dlog_clear(var_0) {
  if(train_wzcircle_override())
    trial_dlog_func(var_0);
  else
    trial_dlog_gun(var_0);
}

trial_dlog_func(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  switch (var_0) {
    case 2:
      self hudoutlineenable("_encstr_966414C71D2B13C445B879C250917BFBA68C4245BD30");
      break;
    case 3:
      self hudoutlineenable("_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD");
      break;
    case 4:
      self hudoutlineenable("_encstr_8D6B15DEAEE8D84BCD957D8CB2C1D143BE07AE4E38C6CA");
      break;
    case 5:
      self hudoutlineenable("_encstr_96AE15674513800375C947242F6863285787EB2916E22F");
      break;
    case 1:
    default:
      self hudoutlineenable("_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099");
      break;
  }
}

trial_dlog_gun(var_0) {
  if(!isDefined(var_0))
    var_0 = 6;

  switch (var_0) {
    case 7:
      self setscriptablepartstate("_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED", "_encstr_932906F74A6F1818");
      break;
    case 8:
      self setscriptablepartstate("_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED", "_encstr_8690056688C20D");
      break;
    case 9:
      self setscriptablepartstate("_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED", "_encstr_B8BC07D01BBF370877");
      break;
    case 10:
      self setscriptablepartstate("_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED", "_encstr_8419044EB232");
      break;
    case 6:
    default:
      self setscriptablepartstate("_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED", "_encstr_998806DD1A96D12B");
      break;
  }
}

trial_civilians_killed() {
  if(level.dogtags.size > level._id_11BCE._encstr_8BBC099B5EE399E1655288)
    level.dogtags = scripts\engine\utility::array_removeundefined(level.dogtags);

  if(level.dogtags.size > level._id_11BCE._encstr_8BBC099B5EE399E1655288) {
    var_0 = undefined;

    foreach(var_2 in level.dogtags) {
      if(!isDefined(var_0) || var_2.spawntime < var_0.spawntime)
        var_0 = var_2;
    }

    var_0 train_associate_models_with_brushes();
  }
}

trial_delete_out_of_bounds() {
  if(!train_wzcircle_override()) {
    return;
  }
  self setasgametypeobjective();
  trial_dlog_jugg();
}

trial_dlog_jugg() {
  var_0 = train_play_anim_init();

  if(isDefined(level.dogtags[var_0].objidnum)) {
    if(level.dogtags[var_0].objidnum != -1) {
      var_1 = level.dogtags[var_0].objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
      scripts\mp\objidpoolmanager::update_objective_onentity(var_1, level.dogtags[var_0]);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 22);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(level.dogtags[var_0].objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(level.dogtags[var_0].objidnum, 0);
      level.dogtags[var_0] scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8D701AD8D9A3D7CD4C1A2C4F6BC02F0B49DF82890FABA35586805851", "_encstr_8ECD1123407BEFC751BD31889F2789592B50D7");
      level.dogtags[var_0] scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      getbnetigrbattlepassxpmultiplier(var_1, 8858, 9843);
      getscriptcachecontents(var_1, 0.5, 1.0);
    }
  }
}

trial_dlog_lava(var_0, var_1) {
  if(!train_wzcircle_override()) {
    return;
  }
  thread trial_dlog_pitcher(var_0, var_1);
}

trial_dlog_pitcher(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1))
    var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

  var_2 = self.origin;
  var_3 = self.angles;

  if(isDefined(var_0)) {
    var_2 = var_0.origin;
    var_3 = var_0.angles;
  }

  var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, var_2, var_3, var_0, undefined, undefined, undefined, 1);
  var_5 = var_4.origin;
  var_6 = abs(self.origin[2] - var_5[2]);
  var_7 = getdvarint("_encstr_979A08F619C1EA8361C7", 800);
  var_8 = sqrt(2 * var_6 / var_7) + 0.5;
  var_9 = trajectorycalculateinitialvelocity(self.origin, var_5, (0, 0, -1 * var_7), var_8);
  self movegravity(var_9, var_8);
  wait(var_8);
  self.origin = var_5;

  if(isDefined(var_4.set_force_aitype_armored)) {
    self linkTo(var_4.set_force_aitype_armored);
    self.set_force_aitype_armored = var_4.set_force_aitype_armored;
  }
}

trial_dlog_gunslinger() {
  self.offset3d = (0, 0, 16);
  self.curorigin = self.origin;
  scripts\mp\gameobjects::requestid(1, 1);
  self.type = "_encstr_8CC00AABB9599E984D2BD81D";
  self.numtouching["_encstr_8E8405EA382B2A"] = 0;
  self.numtouching["_encstr_9A8507BA4040188D08"] = 0;
}

train_initcollision(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_2 = int(var_2);

  while(var_2 > 0) {
    var_3 = train_elements_enable(var_2);
    trial_active_fob(var_0, var_1, undefined, var_3);
    var_2 = var_2 - trial_dogtag_setup(var_3);
    waitframe();
  }
}

trainent(var_0) {
  var_0 = train_sfx_init(var_0);

  if(_encstr_970111AFD53D526C0199B67DB1A8A47A1D6743(var_0)) {
    var_1 = train_scriptable_attach_delay();
    var_2 = _encstr_BA8015F830D387810935908D973079B3B3C4CD0B6D375D(var_0, var_1, "_encstr_AD2307ECC9EDABDC32");
    self.count = var_2;

    if(var_2 <= 0)
      train_associate_models_with_brushes(var_0);
  }
}

_encstr_A11714D2CD3ACA8DAF8D7BB163B21B1D958C6BD2CD1B(var_0, var_1, var_2) {
  if(_encstr_970111AFD53D526C0199B67DB1A8A47A1D6743(var_0))
    var_0 _encstr_BA8015F830D387810935908D973079B3B3C4CD0B6D375D(var_0, var_1, var_2);
}

_encstr_970111AFD53D526C0199B67DB1A8A47A1D6743(var_0) {
  var_1 = var_0 train_mover_test();
  var_2 = var_0 traincylestolink();
  return var_1 < var_2;
}

_encstr_BA8015F830D387810935908D973079B3B3C4CD0B6D375D(var_0, var_1, var_2) {
  traintracefails(var_0, var_1);
  traintracesuccesses(var_0);
  traintracerelpos(var_0);
  _encstr_927019331DC34BF027CF18C89735AEE93A853DC9B79A1B99CC3748(var_0);
  var_3 = var_0 train_stopper(var_1);
  transition_parachutestate(var_0);
  var_0 playlocalsound("_encstr_ADBB11D0D0107FE9C5BCA11851F34B0A403D28");
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_encstr_9A601EC616B073C3395378FBE39F8635402F787B4830AFB90F0A9033BF80D227(var_0, var_1, var_2);

  if(level._id_11BCE._encstr_BA930B5AE6E82B8D39ACDC563A >= 0) {
    var_4 = var_0 train_mover_test();
    var_5 = var_0 traincylestolink();

    if(var_4 >= var_5)
      level thread _encstr_BE4C0CB4CDA32BB1FA932B372B1D(var_0, level._id_11BCE._encstr_BA930B5AE6E82B8D39ACDC563A);
  }

  return var_3;
}

train_sfx_init(var_0) {
  if(isDefined(var_0.owner))
    return var_0.owner;

  return var_0;
}

_encstr_927019331DC34BF027CF18C89735AEE93A853DC9B79A1B99CC3748(var_0) {
  if(!isDefined(var_0._encstr_A92D1F6E58237B70EE40ABCB08A0670283EF75A53C1F42A636E8B79F58D91FFB75) || !var_0._encstr_A92D1F6E58237B70EE40ABCB08A0670283EF75A53C1F42A636E8B79F58D91FFB75)
    var_0 thread _encstr_B242130258AD0F855949D9DB1760CA735BD1CAEAC1();
}

_encstr_B242130258AD0F855949D9DB1760CA735BD1CAEAC1() {
  self._encstr_A92D1F6E58237B70EE40ABCB08A0670283EF75A53C1F42A636E8B79F58D91FFB75 = 1;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A3CF18B740B02C128F750F47C8AB8AE6B9303F6329C8964BEB01", self);
  thread _encstr_8EBE15969B8E56B1F523B4B01BB7768DF6F68D46EDBBB9();
}

_encstr_8EBE15969B8E56B1F523B4B01BB7768DF6F68D46EDBBB9() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B28110A395C2D67DB2B12DAD5A37B0475919");
  wait(level._id_11BCE._encstr_9130145ACDA3B21B465AC2D8BDCE1BEDDB638CBDDDCD);
  self._encstr_A92D1F6E58237B70EE40ABCB08A0670283EF75A53C1F42A636E8B79F58D91FFB75 = 0;
}

traintracefails(var_0, var_1) {
  var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_1301E("_encstr_A62611B63BBECAB395CD3AEBD237E85636BE99", var_1);

  if(!train_vfx_init(var_0))
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
}

trainmove() {
  transient_world_autolod_enabled("_encstr_ADBB11D0D0107FE9C5BCA11851F34B0A403D28");
}

transient_world_autolod_enabled(var_0) {
  var_1 = self.origin;
  playsoundatpos(var_1, var_0);
}

traintracesuccesses(var_0) {
  transient_prefab_group(var_0);
  trainwaittime(var_0);
}

transient_prefab_group(var_0) {
  if(train_vfx_init(var_0)) {
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_820E0A2AE8981DBA528588DC", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_820E0A2AE8981DBA528588DC", var_0.pers["_encstr_820E0A2AE8981DBA528588DC"]);
  } else if(train_wzcircle_time_subtractfrom()) {
    var_0 scripts\mp\utility\stats::incpersstat("_encstr_B64E070F391562989D", 1);
    var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B64E070F391562989D", var_0.pers["_encstr_B64E070F391562989D"]);
  }
}

trainwaittime(var_0) {
  if(train_vfx_init(var_0))
    _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::allyonuse(var_0);
  else if(train_wzcircle_time_subtractfrom())
    _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::enemyonuse(var_0);
}

traintracerelpos(var_0) {
  var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_AC7B1160BB2FC0A38247E0751EC9E3E86C9F98");

  if(train_vfx_init(var_0)) {
    if(isDefined(level.dogtagallyonusecb) && !level.gameended)
      self thread[[level.dogtagallyonusecb]](var_0);
  } else if(isDefined(level.dogtagenemyonusecb) && !level.gameended)
    self thread[[level.dogtagenemyonusecb]](var_0);
}

_encstr_AD1A0E289D7C2039E1BFC7FB8B7BF530() {
  var_0 = self.scriptablename;

  if(!isDefined(var_0) && isDefined(self.tracknonoobplayerlocation))
    var_0 = self.tracknonoobplayerlocation.type;

  if(!isDefined(var_0))
    return 0;

  if(var_0 == "_encstr_AA751A4CE4637BDEA3D7D62B9B32DEE8C2BE4BE61DCA36BEB4C6ED73" || var_0 == "_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED" || var_0 == "_encstr_AC7B1160BB2FC0A38247E0751EC9E3E86C9F98")
    return 1;

  return 0;
}

train_wzcircle_time_subtractfrom() {
  return isDefined(self.victim);
}

train_vfx_init(var_0) {
  if(!train_wzcircle_time_subtractfrom())
    return 0;

  return var_0.pers["_encstr_8AEF05472BC2D6"] == self.victimteam;
}

traincar_hurt(var_0) {
  if(!train_wzcircle_time_subtractfrom())
    return 0;

  return var_0 == self.victim;
}

train_wzcircle_override() {
  if(isent(self))
    return 1;

  return 0;
}

train_play_anim_init() {
  if(isDefined(self.entity))
    return self.entity.start_reach_wind_room;

  return self.start_reach_wind_room;
}

train_scriptable_attach_delay() {
  if(isDefined(self.entity)) {
    if(!isDefined(self.entity.count))
      return 1;

    return self.entity.count;
  }

  if(!isDefined(self.count))
    return 1;

  return self.count;
}

train_elements_enable(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 >= 20)
    return 10;
  else if(var_0 >= 10)
    return 9;
  else if(var_0 >= 5)
    return 8;
  else if(var_0 >= 3)
    return 7;
  else if(var_0 >= 1)
    return 6;

  return 0;
}

trial_dogtag_setup(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = 0;

  switch (var_0) {
    case 7:
    case 2:
      var_1 = 3;
      break;
    case 8:
    case 3:
      var_1 = 5;
      break;
    case 9:
    case 4:
      var_1 = 10;
      break;
    case 10:
    case 5:
      var_1 = 20;
      break;
    case 6:
    case 1:
    default:
      var_1 = 1;
      break;
  }

  return var_1;
}

train_associate_models_with_brushes(var_0) {
  thread train_attach_useable_ammorestocklocation(var_0);
}

train_attach_useable_ammorestocklocation(var_0) {
  train_attach_models_to_assembly(var_0);
  train_car_audio();
  waitframe();

  if(isDefined(self)) {
    self notify("_encstr_AD75063D571AE108");
    train_attach_brushes_to_models();
    train_attach_player_hurts();
  }
}

train_attach_models_to_assembly(var_0) {
  if(train_wzcircle_time_subtractfrom()) {
    thread _encstr_8E6A24A7203BB7AB6BC8378D3AC8BFD649956B70FFFF0ADD6096DB295F7BD0CBD918C827A8F6::removetags(self.victim.guid, undefined, var_0);
    train_collision_item_valid();
  }
}

train_collision_item_valid() {
  self.victim notify("_encstr_96640CDC1749DF0253F87AE350B9");
}

train_car_audio() {
  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.origin);
  self notify("_encstr_88F20627959BCAE8");
}

train_attach_brushes_to_models() {
  var_0 = train_play_anim_init();

  if(isDefined(var_0) && isDefined(level.dogtags[var_0])) {
    if(!isDefined(level.dogtags[var_0].skipminimapids)) {
      level.dogtags[var_0] scripts\mp\gameobjects::releaseid();
      self notify("_encstr_8BE208E31FA8E1631D65");
    }

    level.dogtags[var_0] = undefined;
  }
}

train_attach_player_hurts() {
  if(isDefined(self.entity))
    self.entity delete();
  else {
    if(train_wzcircle_override()) {
      self delete();
      return;
    }

    self freescriptable();
  }
}

tree_think(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.spotlight_sweep_to_loc_safe = var_0;
  var_2.playerwaittillstreamhintcomplete = var_1;
  return var_2;
}

_encstr_BE4C0CB4CDA32BB1FA932B372B1D(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", var_1);
  var_0.spawnvector = 0;
  var_0.spawnselectionmarker = 0;
  var_0.spawnpoint_setspawnpoint = 0;
  var_0.spawntvfix = 0;
  var_0.splashtime_helis = 0;
  var_0 trial_dogtags();
}

transition_parachutestate(var_0) {
  thread trap_toggle_logic(var_0);

  if(!train_vfx_init(var_0))
    trap_door_nvg_reset_catch(var_0);
}

trap_toggle_logic(var_0) {
  trenchdebug(var_0);
  triage_door_clip(var_0);
  traversenotvalid(var_0);
  traversal_disabled_by_management(var_0);
  var_0 thread _id_124EF();
}

trap_door_nvg_reset_catch(var_0) {
  for(var_1 = 0; var_1 <= level.tread_sfx.size; var_1++) {
    if(trap_room_dogtag_revive(var_0, var_1)) {
      var_0[[level.tread_sfx[var_1].playerwaittillstreamhintcomplete]]();
      var_0 trap_room_turret_init();
    }
  }
}

trap_room_dogtag_revive(var_0, var_1) {
  var_2 = var_0 train_mover_test();
  var_3 = var_0 trap_consoles();

  if(!isDefined(level.tread_sfx[var_3]))
    return 0;

  var_4 = var_2 >= level.tread_sfx[var_3].spotlight_sweep_to_loc_safe;
  var_5 = var_1 == var_3;
  return var_4 && var_5;
}

trenchdebug(var_0) {
  if(isDefined(var_0.vehicle)) {
    return;
  }
  if(level._id_11BCE._id_11FEA == 1)
    var_0 thread _id_124EE();
}

triage_door_clip(var_0) {
  var_1 = self.count;

  if(!isDefined(var_1))
    var_1 = 1;

  if(train_vfx_init(var_0))
    var_0 scripts\mp\rank::giverankxp("_encstr_82780B3A2C76BE46CAE6A5B219", level._id_11BCE._encstr_8AEA13F673BE96B9A3B2D8AF0E5A1BD6BAC1F5C30E * var_1);
  else
    var_0 scripts\mp\rank::giverankxp("_encstr_96590EE82CB3D71BDE36B1ACD88E598C", level._id_11BCE._encstr_8AEA13F673BE96B9A3B2D8AF0E5A1BD6BAC1F5C30E * var_1);
}

travelspeed(var_0) {
  if(level._id_11BCE._id_11FE6 == 1)
    var_0 thread transition_to_airfield();
}

traversenotvalid(var_0) {
  if(level._id_11BCE._id_11FE8 == 1)
    self.health = self.maxhealth;
}

traversal_disabled_by_management(var_0) {
  if(level._id_11BCE._id_11FE7 == 1) {
    var_0.br_armorhealth = var_0.br_maxarmorhealth;
    var_0 setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", 1);
    var_0 scripts\mp\equipment\armor_plate::debug_state(var_0.br_armorhealth);
  }
}

transition_to_airfield() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

triage_ai_campers() {
  trap_room_wave_settings("_encstr_851904B59B34");
}

trap_toggle_fx_logic() {
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper("_encstr_96F610C7E33F527201D9B5BD3029AC9B1841", 1, 0, 0);
  thread scripts\mp\hud_message::showsplash("_encstr_A98E1B4002F9FAC407D18C301807C70EE373A79642BBAB9FF05F8A17C1");
}

_encstr_849A189BF8835224388AA238E74B7017C28554F87E60C8320D17() {
  _encstr_B4261223B803BFF939060B043BB34759D7E430BA("_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1", "_encstr_931426D9B3EF3C80DDE591831807A9F1AFCA91E0BB6F788835EC4BB10FEA30C97B31EB2903E724D0");
}

trap_room_ents() {
  _encstr_B4261223B803BFF939060B043BB34759D7E430BA("_encstr_B8AD206D636A18C8CC6928014F88E0C0426FE3F99B425060F5BF3038357C2306AABB", "_encstr_87012889E3BF0CB0EDD54153E8D779C1FFBAC1D06B9FA8B845BC7B41DF7C609FCB633E5BC2F777509D93");
}

transition_to_next_section() {
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper("_encstr_83341156B3EB23ABBF5F40A07FCA4669B35D4F", 1, 0, 0);
  thread scripts\mp\hud_message::showsplash("_encstr_A98E1B4002F9FAC407D18C301807C70EE373A79642BBAB9FF05F8A17C1");
}

transitionplayersoutofac130cinematic() {
  trap_room_wave_settings("_encstr_A2E60C6BC099B7E1A0A93A398F48");
}

translate_and_rotate_from_level_overrides() {
  _encstr_B4261223B803BFF939060B043BB34759D7E430BA("_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28", "_encstr_A54D235E020F99BB25D228589BFF0F105FB6D5407C9FC693CD2BA8F841172B6B5F2DEFC6CB");
}

transitionac130tomovinganim() {
  thread scripts\mp\hud_message::showsplash("_encstr_AD5222E892EFF7D66B3050B7A097A0D0214D1A2F2B1BB9FADA2DD378171B4E3C4ADCFF4B");

  if(getdvarint("_encstr_8A2B19B7630A67054143D31A8B47214B3BA6C0E0189611DB3D0DE3", 1)) {
    var_0 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_encstr_B6411A5EF299AF2B05DFF060CF4D43C9E25DCF530E725B93E1A37028(self, "_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3");
    var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::cantakepickup(var_0);

    if(var_1 == 1) {
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::onusecompleted(var_0, 1);
      return;
    }

    if(var_1 == 15) {
      var_2 = scripts\engine\utility::ter_op(isDefined(self.equipment["_encstr_91B50734CA58631D1A"]), scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A"), 0);
      var_3 = scripts\mp\equipment::getequipmentmaxammo(level.br_pickups.br_equipname["_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69"]);

      if(var_2 < var_3) {
        scripts\mp\equipment::setequipmentslotammo("_encstr_91B50734CA58631D1A", var_3);
        return;
      }

      return;
    }

    return;
  } else
    _encstr_B4261223B803BFF939060B043BB34759D7E430BA("_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3", undefined);
}

trap_trigger_logic() {
  _encstr_B4261223B803BFF939060B043BB34759D7E430BA("_encstr_87FD19B083BD774063E708F4B67BC92DE7F94060CA92B7F943CF8F", undefined);
}

traps_disabled() {
  trap_room_wave_settings("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895");
}

transitionplayerstoac130cinematic() {
  thread scripts\mp\hud_message::showsplash("_encstr_84E92213DB4F41D742A0585E3D8B0D4BE763B030FF1AD98B6AC14DDBD3935B960CE71028");
  start_mine_caves();
}

trap_timer_running() {
  _encstr_B4261223B803BFF939060B043BB34759D7E430BA("_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768", "_encstr_8E412726E4D73B58B6CAE8BCE095EBB556B9917B1D16EB5A9B3AB2B1D736F60B46DEEAE8BE91C97BC1");
}

treerootnodesizebitcount() {
  thread scripts\mp\hud_message::showsplash("_encstr_A6B7223B205EDA4A097B190E68031274E688BFE7401314D251AF1AC245D7BA29E8C86F13");
  scripts\mp\perks\perks::bears();
}

transition_snd_org() {
  trap_room_wave_settings("_encstr_8FFA10EB3033E5B2613B4D05176949BDF950");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B1500D4F35DDB28C219B971B9120CC", self, undefined, undefined, 1);
}

trap_door_nvg_reset() {
  thread scripts\mp\hud_message::showsplash("_encstr_82B322B235290F5F6949AB63F3B56F452BE52C37817059078043B23AFE98877CD87FB388");
  var_0 = isDefined(self.streakdata.streaks[1]);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar("_encstr_9B7310AFD59D7A46303148D96B5882726203", var_0, 1);
}

_encstr_B4261223B803BFF939060B043BB34759D7E430BA(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_encstr_A58619826BA7933D70E6CB278B943828D026E3C85D06B9EFA0568B(self, var_0, 1, var_2);

  if(isDefined(var_1))
    thread scripts\mp\hud_message::showsplash(var_1);
}

trap_room_wave_settings(var_0) {
  var_1 = isDefined(self.streakdata.streaks[1]);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar(var_0, var_1, 1);

  if(!level.gameended)
    thread scripts\mp\hud_message::showkillstreaksplash(var_0);
}

train_play_anim() {
  var_0 = 0;
  var_0 = var_0 + train_move_test_train_car_thread();
  var_0 = var_0 + train_minimap_icon_attach();
  var_0 = var_0 + train_minimap_icon_detach();
  return var_0;
}

train_mover_test() {
  if(!isDefined(self.splashtime_helis))
    self.splashtime_helis = 0;

  return self.splashtime_helis;
}

train_move_test_train_car_thread() {
  if(!isDefined(self.spawntvfix))
    self.spawntvfix = 0;

  return self.spawntvfix;
}

train_minimap_icon_attach() {
  if(!isDefined(self.spawnpoint_setspawnpoint))
    self.spawnpoint_setspawnpoint = 0;

  return self.spawnpoint_setspawnpoint;
}

train_minimap_icon_detach() {
  if(!isDefined(self.spawnselectionmarker))
    self.spawnselectionmarker = 0;

  return self.spawnselectionmarker;
}

train_stopper(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_0 = int(var_0);
  var_1 = train_mover_test();
  var_2 = traincylestolink();
  var_3 = 0;

  if(var_1 + var_0 > var_2) {
    var_4 = var_2 - var_1;
    var_3 = var_0 - var_4;
    var_0 = var_4;
  }

  if(train_wzcircle_time_subtractfrom()) {
    if(train_vfx_init(self))
      train_stop(var_0);
    else
      train_tag_array(var_0);
  } else
    train_tagoffset_array(var_0);

  trial_dogtags();
  return var_3;
}

traincylestolink() {
  var_0 = level.tread_sfx[level.tread_sfx.size - 1];
  return var_0.spotlight_sweep_to_loc_safe;
}

train_track_velocity(var_0) {
  self.splashtime_helis = train_mover_test();

  if(isDefined(var_0))
    self.splashtime_helis = self.splashtime_helis + var_0;
  else
    self.splashtime_helis++;
}

train_tagoffset_array(var_0) {
  self.spawntvfix = train_move_test_train_car_thread();

  if(isDefined(var_0))
    self.spawntvfix = self.spawntvfix + var_0;
  else
    self.spawntvfix++;

  train_track_velocity(var_0);
}

train_stop(var_0) {
  self.spawnpoint_setspawnpoint = train_minimap_icon_attach();

  if(isDefined(var_0))
    self.spawnpoint_setspawnpoint = self.spawnpoint_setspawnpoint + var_0;
  else
    self.spawnpoint_setspawnpoint++;
}

train_tag_array(var_0) {
  self.spawnselectionmarker = train_minimap_icon_detach();

  if(isDefined(var_0))
    self.spawnselectionmarker = self.spawnselectionmarker + var_0;
  else
    self.spawnselectionmarker++;

  train_track_velocity(var_0);
}

train_init_as_vehicle(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_0 = int(var_0);

  for(var_1 = 0; var_1 < var_0; var_1++)
    train_init_lootcrates_on_train();

  trial_dogtags();
}

train_init_lootcrates_on_train() {
  self.splashtime_helis = train_mover_test();
  self.splashtime_helis--;

  if(self.splashtime_helis < 0)
    self.splashtime_helis = 0;
}

trial_dogtags() {
  var_0 = train_mover_test();
  var_1 = trap_consoles();
  var_2 = trap_array();
  var_3 = propremovefromcircle();
  var_4 = 0;
  var_4 = var_4 + var_0 * 100000;
  var_4 = var_4 + var_1 * 1000;
  var_4 = var_4 + int(floor(var_2 * 100)) * 10;
  var_4 = var_4 + var_3;
  self setclientomnvar("_encstr_A1DA1C1B2BF1B69DC8C1C8D7AF3EF7689B41A12291E7F73BA5F7B81B93F9", var_4);
}

trap_room_turret_init() {
  self.spawnvector = trap_consoles();
  self.spawnvector++;
  trial_dogtags();
}

trap_consoles() {
  if(!isDefined(self.spawnvector))
    self.spawnvector = 0;

  return self.spawnvector;
}

trap_array() {
  var_0 = train_mover_test();
  var_1 = 0;

  for(var_2 = 0; var_2 < level.tread_sfx.size; var_2++) {
    var_3 = level.tread_sfx[var_2].spotlight_sweep_to_loc_safe;

    if(var_0 > var_1 && var_0 < var_3)
      return (var_0 - var_1) / (var_3 - var_1);

    var_1 = var_3;
  }

  return 0.0;
}

init_locations() {
  if(isDefined(level._id_11E18.seq3_tanksettings)) {
    var_0 = 0;
    var_1 = "_encstr_A907037FD5";

    foreach(var_3 in level._id_11E18.seq3_tanksettings) {
      var_4 = var_1 + scripts\engine\utility::string(var_0);
      _id_12AEA(var_4, 1, var_3);
      var_0++;
    }
  }

  if(!isDefined(level._id_11BCE.area_structs) || level._id_11BCE.area_structs.size <= 0)
    _id_12AEA("_encstr_8B1608EC43B8D647A113", 1, (0, 0, 0));
}

_id_12AEA(var_0, var_1, var_2) {
  if(!isDefined(level._id_11BCE.area_structs))
    level._id_11BCE.area_structs = [];

  var_1 = getdvarint("_encstr_8F171D7F17BB30C8CD353950DBB121D1028FD3C997B26091F7CF8029C48CE9" + var_0, var_1);

  if(var_1 <= 0) {
    return;
  }
  var_2._id_13902 = var_0;
  var_2.spotlights = var_1;
  var_2._id_140B7 = var_2.origin;
  level._id_11BCE.area_structs[var_0] = var_2;
}

groundz() {
  _id_12FDC();
  level thread bindingpc();

  if(getdvarint("_encstr_A2EE19283FC2466D834921B39A89AD882AFF3048676BD805FAAD2D", 0) == 0) {
    if(istrue(level._id_11BCE._id_1409D))
      level.grouptorewards = (0, 0, 0);

    level.br_level.br_circledelaytimes = level._id_11BCE.groundentity;
    level.br_level.br_circleclosetimes = level._id_11BCE.ground_spawners;

    if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
      level.br_level.br_circleradii = [16000, 16000, 12500, 9500, 6500, 2000, 300, 0];
      level.br_level.br_circleminimapradii = [9000, 9000, 7750, 6500, 4500, 3500, 2500];
      level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0];
      level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0];
    } else {
      level.br_level.br_circleradii = [72500, 72500, 50000, 32500, 20000, 11500, 7000, 2000, 0];
      level.br_level.br_circleminimapradii = [10500, 10500, 10500, 9000, 8000, 6500, 5500, 5500];
      level.br_level.default_player_connect_black_screen = [0, 0, 0, 0, 0, 0, 0, 0];
      level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
    }
  }
}

_id_12FDC() {
  level._id_11BCE._id_12E2C = _id_12D7F();
  var_0 = level._id_11BCE._id_12E2C._id_140B7;
  level.grouptorewards = _encstr_A2A81BADF63BCAEB1CED5AB9A3EB31BCF5CDCAA3F5C85AB98E2CDC6CCA(var_0, _encstr_AD431BBF089B2FB6CBE79F1AFB9D66FAE650DAA74FD348D7122718FBBD(var_0), level._id_11BCE._encstr_AB9B1AD80BC3E9B40BF9C229C8732929EFB9A918C7A585B2552378A2);
}

_id_12D7F() {
  if(isDefined(level._id_11BCE._id_13903) && level._id_11BCE._id_13903 != "_encstr_A31207CBF788523281") {
    foreach(var_2, var_1 in level._id_11BCE.area_structs) {
      if(level._id_11BCE._id_13903 == var_2)
        return var_1;
    }
  }

  if(level._id_11BCE.area_structs.size == 1) {
    foreach(var_4 in level._id_11BCE.area_structs)
    return var_4;
  }

  var_6 = 0;

  foreach(var_1 in level._id_11BCE.area_structs)
  var_6 = var_6 + var_1.spotlights;

  var_9 = randomintrange(0, var_6);

  foreach(var_1 in level._id_11BCE.area_structs) {
    if(var_9 < var_1.spotlights)
      return var_1;

    var_9 = var_9 - var_1.spotlights;
  }

  level._id_11BCE.area_structs = scripts\engine\utility::array_randomize(level._id_11BCE.area_structs);
  return level._id_11BCE.area_structs[0];
}

bindingpc() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_855514074BB1B2DF6058F2BED078170A9DFDC3971566");
  var_0 = (0, 0, 0);

  foreach(var_2 in level._id_11E18.wait_for_player_eliminated)
  var_0 = var_0 + var_2;

  var_0 = var_0 / level._id_11E18.wait_for_player_eliminated.size;
  var_4 = level._id_11BCE._encstr_97701D332DC99B3AB1A54E6C1BACB6B0E132D2CDA33327DBD66CB2371D2B27;
  level.br_level.default_class_chosen[1] = _encstr_813B256149D283B2178483D011C788082858397B25D8D864EF05DA3EE8098BCF2F70E595B9EFA0(level.br_level.default_class_chosen[1], var_0, var_4);
  level.br_level.default_class_chosen[0] = level.br_level.default_class_chosen[1];
  level.br_level.default_class_chosen[2] = _encstr_813B256149D283B2178483D011C788082858397B25D8D864EF05DA3EE8098BCF2F70E595B9EFA0(level.br_level.default_class_chosen[2], var_0, var_4);
  _encstr_96B6236C43ACC6D6FA9939B2DCDC7BBE07DBD237D19BAFADDBB359FA2DCCAFE6AC59C8B291(3, 1, 1);
  _encstr_96B6236C43ACC6D6FA9939B2DCDC7BBE07DBD237D19BAFADDBB359FA2DCCAFE6AC59C8B291(4, 1, 0);
  _encstr_96B6236C43ACC6D6FA9939B2DCDC7BBE07DBD237D19BAFADDBB359FA2DCCAFE6AC59C8B291(5, 1, 0);
  level.br_level.default_class_chosen[6] = level.br_level.default_class_chosen[8];
  level.br_level.default_class_chosen[6] = _encstr_A2A81BADF63BCAEB1CED5AB9A3EB31BCF5CDCAA3F5C85AB98E2CDC6CCA(level.br_level.default_class_chosen[6], level._id_11BCE._id_12E2C._id_140B7, 500);
  level.br_level.default_class_chosen[7] = level.br_level.default_class_chosen[8];

  for(var_5 = 9; var_5 < level.br_level.default_class_chosen.size; var_5++) {
    if(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(level.br_level.default_class_chosen[var_5], 1)) {
      var_6 = distance2d(level.br_level.default_class_chosen[var_5], level.grouptorewards);
      level.br_level.default_class_chosen[var_5] = _encstr_A2A81BADF63BCAEB1CED5AB9A3EB31BCF5CDCAA3F5C85AB98E2CDC6CCA(level.br_level.default_class_chosen[var_5], level.grouptorewards, var_6 / 2);
    }
  }
}

_encstr_96B6236C43ACC6D6FA9939B2DCDC7BBE07DBD237D19BAFADDBB359FA2DCCAFE6AC59C8B291(var_0, var_1, var_2) {
  var_3 = level.br_level.default_class_chosen[var_0];
  var_4 = level.br_level.br_circleradii[var_0];
  var_5 = _encstr_97B91E2FE009CB1A0F84229F760512AFF370BF9398233FE255306E94DEC7DA5D(var_0);
  var_6 = var_5["_encstr_8D800929E3570DC82ED15B"];
  var_7 = var_5["_encstr_AF6008D2C950D7B230BB"];

  if(var_1 && var_2) {
    if(var_6 && var_7)
      return;
  }

  if(var_1 && !var_6) {
    var_8 = distance2d(var_3, level._id_11BCE._id_12E2C._id_140B7) - var_4;
    level.br_level.default_class_chosen[var_0] = _encstr_A2A81BADF63BCAEB1CED5AB9A3EB31BCF5CDCAA3F5C85AB98E2CDC6CCA(var_3, level._id_11BCE._id_12E2C._id_140B7, var_8 + 5000);
  }

  if(var_2 && !var_7) {
    var_8 = distance2d(var_3, level._id_11BCE._id_12E2C._id_140B7) - var_4;
    level.br_level.default_class_chosen[var_0] = _encstr_A2A81BADF63BCAEB1CED5AB9A3EB31BCF5CDCAA3F5C85AB98E2CDC6CCA(var_3, level._id_11BCE._id_12E2C._id_140B7, var_8 + 5000);
  }
}

_encstr_97B91E2FE009CB1A0F84229F760512AFF370BF9398233FE255306E94DEC7DA5D(var_0) {
  var_1 = [];
  var_2 = 0;
  var_3 = 0;
  var_4 = level.br_level.default_class_chosen[var_0];
  var_5 = level.br_level.br_circleradii[var_0];

  foreach(var_7 in level._id_11E18.seq3_tanksettings) {
    if(scripts\engine\utility::updatescrapassistdata(var_7.origin, var_4, var_5))
      var_2++;
  }

  foreach(var_10 in level._id_11E18.wait_for_player_eliminated) {
    if(scripts\engine\utility::updatescrapassistdata(var_10, var_4, var_5))
      var_3++;
  }

  var_1["_encstr_8D800929E3570DC82ED15B"] = var_2;
  var_1["_encstr_AF6008D2C950D7B230BB"] = var_3;
  return var_1;
}

_encstr_813B256149D283B2178483D011C788082858397B25D8D864EF05DA3EE8098BCF2F70E595B9EFA0(var_0, var_1, var_2) {
  var_3 = distance2d(var_0, var_1);

  if(var_3 > var_2) {
    var_4 = var_3 - var_2;
    return _encstr_A2A81BADF63BCAEB1CED5AB9A3EB31BCF5CDCAA3F5C85AB98E2CDC6CCA(var_0, var_1, var_4);
  }

  return var_0;
}

_id_12181() {
  var_0 = getdvarvector("_encstr_8E141949237FCCB06D91315FBB9450061BCA66900BCF7EA0446C3B", level.grouptorewards);
  return var_0;
}

init_relic_aggressive_melee() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path(var_0, var_1);
  return var_2;
}

being_hacked() {
  thread vehomn_getleveldata();
}

vehomn_getleveldata() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = distance(self._id_12205.startpt, self._id_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed() - 5;
  wait(var_1);

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "_encstr_969105B1C4CC81" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
      var_3 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
    }
  }
}

superterrainlightbakelodoverride() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_B2C90C70705B9588598F42D30305");
  var_0.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_0.dummymodel = "_encstr_ADDE1E7842637B689EB24B0FCBC69335BB7A31202AB7A5F9E2EA7F6DE2A1C0A6";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = ::trial_enemy_dont_drop_weapon;
  var_0.capturecallback = ::trial_enemy_quota;
  var_0.destroyoncapture = 1;
}

train_handle_collide_crate_br(var_0) {
  level notify("_encstr_A77E18D237D195C6FA8D9C16D12BEBCAD92BE6D1BE36A1CA1B5B");
  level endon("_encstr_A77E18D237D195C6FA8D9C16D12BEBCAD92BE6D1BE36A1CA1B5B");

  if(_encstr_ADA92F8703C2106F837BA0903396AC185D9D012BB8EF3818F343A63B4B8BD18076F59D9B5E1311F46B2A3BE0F2621C188E::_encstr_83200F6F2FF4E3A5207875FEF130E11BDD()) {
    var_1 = _encstr_ADA92F8703C2106F837BA0903396AC185D9D012BB8EF3818F343A63B4B8BD18076F59D9B5E1311F46B2A3BE0F2621C188E::_encstr_8F2517980553351AEDCB8067A3FB73DA03933DD9C37508D6E1();
    wait(var_1);
  }

  level thread _id_13571();
}

_id_13571(var_0) {
  if(!level._id_11BCE.train_lootcrates_save_offsets) {
    return;
  }
  if(!istrue(var_0))
    wait(randomintrange(level._id_11BCE._id_11BEB, level._id_11BCE._id_11B49));

  var_1 = [];
  [level._id_11E18.score_event_headshot, var_3] = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::sappliedstages();

  if(isDefined(var_3)) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4.index = level._id_11E18.score_event_headshot;
    var_4.type = "_encstr_A74C0277";
    var_1[var_1.size] = var_4;
  }

  [level._id_11E18.wait_and_destroy, var_3] = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::vehicletrail();

  if(isDefined(var_3)) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4.index = level._id_11E18.wait_and_destroy;
    var_4.type = "_encstr_A94C02B6";
    var_1[var_1.size] = var_4;
  }

  if(var_1.size > 0) {
    foreach(var_7 in level.players)
    var_7 scripts\mp\hud_message::showsplash("_encstr_ACA320D95B1F7997BAFF5C3B9FB33F09FBFDF1B28BC7F919EBCA3B8DCF1FF3A04D21");
  }

  for(var_9 = 0; var_9 < var_1.size; var_9++) {
    var_10 = randomint(360);

    for(var_11 = 0; var_11 < level._id_11BCE._id_11F1E; var_11++) {
      var_12 = var_10 + 90;
      var_13 = 0;
      var_14 = undefined;

      for(var_15 = 0; var_15 < 360; var_15 = var_15 + 10) {
        var_16 = (0, var_12 + var_15, 0);
        var_17 = anglesToForward(var_16);
        var_4 = var_1[var_9];
        var_14 = var_4.origin + var_17 * level._id_11BCE.train_get_num_of_anim_ents[var_4.type];

        if(!_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_14) || updatesquadleaderpassstateforteam(var_14)) {
          continue;
        }
        if(!isDefined(level.br_circle.dangercircleent) || _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_14)) {
          var_13 = 1;
          break;
        } else {}
      }

      if(!var_13) {
        break;
      }

      var_10 = var_12;
      var_18 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_14);
      var_18 = var_18 + (0, 0, 2000);
      var_19 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "_encstr_B2C90C70705B9588598F42D30305", var_18, (0, randomint(360), 0));
      var_19.trial_flares = var_1[var_9];
      var_20 = randomfloatrange(level._id_11BCE.trial_fetch_mission_table, level._id_11BCE.trial_explosive_clear) * 1000;
      var_19.trial_flares.expiretime = gettime() + var_20;
      level.train_hurt_damage_watcher[level.train_hurt_damage_watcher.size] = var_19;
      var_19 thread train_handle_collide_mines();
      var_19 thread train_horn_sfx();
    }
  }
}

updatesquadleaderpassstateforteam(var_0) {
  var_1 = getEntArray("_encstr_85FE0DD5727A27098513298817CA23", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3))
      return 1;
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(var_3 in level.outofboundstriggers) {
      if(ispointinvolume(var_0, var_3))
        return 1;
    }
  }

  return 0;
}

trial_enemy_dont_drop_weapon(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }
}

trial_enemy_quota(var_0) {
  thread trial_flare_destruct_missile(self);
  self notify("_encstr_B1CF098D5838A3D5C95623");
  var_1 = train_elements_enable(level._id_11BCE.infil_light_dvars);
  var_2 = trial_ai_spawn_far(self.origin + (0, 0, 16), undefined, var_1);

  if(isDefined(self.objectiveiconid))
    objective_delete(self.objectiveiconid);

  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.molotov_delete_oldest_trigger.origin);
  self.molotov_delete_oldest_trigger delete();
}

trial_flare_destruct_missile(var_0) {
  var_1 = var_0.trial_flares;
  level.train_hurt_damage_watcher = scripts\engine\utility::array_remove(level.train_hurt_damage_watcher, var_0);
  var_2 = 0;

  foreach(var_4 in level.train_hurt_damage_watcher) {
    if(isDefined(var_4) && var_4.trial_flares.type == var_1.type && var_4.trial_flares.index == var_1.index) {
      var_2 = 1;
      break;
    }
  }

  if(!var_2) {
    if(var_1.type == "_encstr_A94C02B6")
      level._id_11E18.wait_and_destroy = undefined;
    else
      level._id_11E18.score_event_headshot = undefined;
  }
}

train_handle_collide_mines() {
  var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(self.origin, 50, -3000);
  self.molotov_delete_oldest_trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + (0, 0, 3));
  self.molotov_delete_oldest_trigger setModel("_encstr_AAD412E6C69CEBB9B6DBD659D7CE9C9537583256");
  wait 1.0;
  self.molotov_delete_oldest_trigger playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
  self.molotov_delete_oldest_trigger setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9");
}

train_horn_sfx() {
  self setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A98F06181E4BCA85");
}

train_get_anim_ents_index() {
  if(isDefined(self) && !istrue(self.isdestroyed))
    thread train_get_anim_to_play();
}

train_get_anim_to_play() {
  self.molotov_delete_oldest_trigger delete();
  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.origin);
  trial_flare_destruct_missile(self);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

circletimer(var_0) {
  if(istrue(level.disable_super_in_turret._id_12CA4)) {
    var_1 = _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::rocket_attack_min_cooldown();

    if(var_0 >= var_1)
      _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::loadoutcustomperkdiscount();
  }

  if(var_0 >= 2)
    level._id_11BCE._id_12C9A = level._id_11BCE._id_12C9A + level._id_11BCE._id_12C99;

  if(var_0 == level._id_11BCE.vo_while_reviving) {
    _getrandomlocations::vehicle_spawn_abandonedtimeoutcallback(1);
    _getrandomlocations::sequence_progression(1);
  }

  if(var_0 >= level._id_11BCE._id_11BEA && var_0 <= level._id_11BCE._id_11B48)
    thread train_handle_collide_crate_br(var_0);

  return 0;
}

lb_dmg_factor_tail_stabilizer() {
  foreach(var_1 in level.train_hurt_damage_watcher)
  var_1 train_get_anim_ents_index();
}

initcratedata(var_0) {
  _encstr_8723303A560D7A807B60BEBF90F84F229BFD4330475B939701706FDF58A84F1A7D050A6DA0876BE3EBE077AF6823B6B217AE::initcratedata(var_0);
}

active_fob_think() {}

_encstr_81041AADDBECB2D783BD5ACD8EAF89BCD7375947D7C156E4D895DC8E(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = var_1 - var_0;
  return var_0 + var_3 * var_2;
}

_encstr_A2A81BADF63BCAEB1CED5AB9A3EB31BCF5CDCAA3F5C85AB98E2CDC6CCA(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = vectorNormalize(var_1 - var_0);
  return var_0 + var_3 * var_2;
}

_encstr_AD431BBF089B2FB6CBE79F1AFB9D66FAE650DAA74FD348D7122718FBBD(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level._id_11E18.wait_for_player_eliminated) {
    var_5 = distance2dsquared(var_0, var_4);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_2 = var_5;
      var_1 = var_4;
    }
  }

  return var_1;
}

_id_124EE() {
  if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.suit)) {
    return;
  }
  if(self.operatorcustomization.suit == "_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B") {
    thread _id_1247E();
    return;
  }

  self._id_12147 = self.operatorcustomization.suit;
  self.operatorcustomization.suit = "_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B";
  scripts\mp\utility\player::_setsuit("_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B");
  thread _id_1247E();
}

_id_1247E() {
  self notify("_encstr_880812DE335B81880D27C8E0E74CC6C7535ECEDD");
  self endon("_encstr_880812DE335B81880D27C8E0E74CC6C7535ECEDD");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143B9(level._id_11BCE._id_11FE9, "_encstr_AD75063D571AE108");

  if(isDefined(self._id_12147) && self.operatorcustomization.suit != self._id_12147) {
    self.operatorcustomization.suit = self._id_12147;
    scripts\mp\utility\player::_setsuit(self._id_12147);
    self._id_12147 = undefined;
  }
}

_id_124EF() {
  self notify("_encstr_873521DB506F07BF784F8B65E1E944930468B272FB35E7726839957A9FA04ABB3B608B");
  self endon("_encstr_873521DB506F07BF784F8B65E1E944930468B272FB35E7726839957A9FA04ABB3B608B");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self refreshsprinttime();
  var_0 = 0;
  thread transient_world_proxy_collision_distance();
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::giveperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::giveperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  while(var_0 < level._id_11BCE._id_11FE9) {
    if(self issupersprinting())
      self refreshsprinttime();

    wait 0.1;
    var_0 = var_0 + 0.1;
  }

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    if(isDefined(self.perks["_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862"]))
      scripts\mp\utility\perk::removeperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");

    if(isDefined(self.perks["_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27"]))
      scripts\mp\utility\perk::removeperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");

    if(isDefined(self.perks["_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218"]))
      scripts\mp\utility\perk::removeperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
}

transient_world_proxy_collision_distance() {
  self notify("_encstr_A17D0C78BA323B7B8774B3B97DEB");
  waitframe();
  self setclientomnvar("_encstr_8C1F1B1BF3F74B2278E8E7BB58D1FEC27D9569D36B2B526AC6E0BFB3A0", 4);
  var_0 = level._id_11BCE._id_11FE9;
  var_1 = gettime() + var_0 * 1000;
  self setclientomnvar("_encstr_96FC169BD7814FE8E91BA11BC7CDB30D2A0B5711AFCA9DD0", var_1);
  scripts\engine\utility::_id_143BA(level._id_11BCE._id_11FE9, "_encstr_A17D0C78BA323B7B8774B3B97DEB", "_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_8C1F1B1BF3F74B2278E8E7BB58D1FEC27D9569D36B2B526AC6E0BFB3A0", 0);
}

_id_12646() {
  if(isalive(self)) {
    _id_14012();
    trial_dogtags();
  }
}

_id_12A7C() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_13F25("_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846");
}

_id_14012() {
  if(!istrue(level.disable_super_in_turret._id_12CA4) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    if(propremovefromcircle()) {
      if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken())
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
    } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken())
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();
  }
}

_id_1336E(var_0) {
  waittillframeend;
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_131A2(1);
  thread spawn_drones(var_0);
}

spawn_drones(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    wait(var_0);

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_131A2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

propremovefromcircle() {
  if(!isDefined(self.spawnsystem_init))
    self.spawnsystem_init = level._id_11BCE._id_1385A;

  return self.spawnsystem_init;
}

start_mine_caves() {
  self.spawnsystem_init = propremovefromcircle();
  self.spawnsystem_init++;

  if(!isDefined(self.spectatetestonprematchfadedone))
    self.spectatetestonprematchfadedone = self.spawnsystem_init;
  else if(self.spawnsystem_init > self.spectatetestonprematchfadedone)
    self.spectatetestonprematchfadedone = self.spawnsystem_init;

  _id_14012();
  trial_dogtags();
}

juggerbear() {
  self.spawnsystem_init = propremovefromcircle();
  self.spawnsystem_init--;

  if(!isDefined(self.spawntimestamp))
    self.spawntimestamp = 1;
  else
    self.spawntimestamp++;

  if(self.spawnsystem_init < 0)
    self.spawnsystem_init = 0;
}

_id_125FC() {
  var_0 = spawnStruct();
  var_0._id_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_0.should_use_velo_forward = self.should_use_velo_forward;
  var_0.callprecisionairstrikeonlocation = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename))
      var_1[var_1.size] = var_4;
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);

    if(var_7.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB" || var_7.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0") {
      var_0.brtdm_config[var_8] = self getweaponammoclip(var_7);
      var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);
    } else {
      var_0.brtdm_config[var_8] = weaponclipsize(var_7);
      var_0.brtruck_ontimelimit[var_8] = int(max(self getweaponammostock(var_7), weaponclipsize(var_7)));
    }

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7))
      var_0.brtruck_cleanupents[var_8] = weaponclipsize(var_7);

    if(getsubstr(var_8, 0, 4) == "_encstr_9B83050BD88EF5") {
      continue;
    }
    var_0._id_12889[var_0._id_12889.size] = var_7;
  }

  var_10 = self getweaponslistoffhands();

  foreach(var_12 in var_10) {
    if(var_12.basename == "_encstr_A51B0B2BD260444AAFCD6F86E2") {
      continue;
    }
    var_13 = self getweaponammoclip(var_12);

    if(var_13 <= 0) {
      continue;
    }
    var_0.offhands[var_0.offhands.size] = var_12;
    var_14 = createheadicon(var_12);
    var_0.brtdm_config[var_14] = var_13;
  }

  foreach(var_18, var_17 in self.equipment)
  var_0.nvidiaansel_overridecollisionradius[var_17] = var_18;

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent)
    var_0.super = self.equipment["_encstr_BEB406F03B72BB3B"];

  if(isDefined(self.streakdata.streaks[1]))
    var_0.vo_one_remain = self.streakdata.streaks[1].streakname;

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    var_0.gasmaskhealth = self.gasmaskhealth;
    var_0.plunderpads = self.plunderpads;
    var_0.plundersilentcountdownendtime = self.plundersilentcountdownendtime;
  }

  self._id_12EB0 = var_0;
}

_id_125FB() {
  _unlinkcorpsefromvehicle::_id_125FB();
  thread _id_13FAB();
  thread _id_12CC3();
}

_id_13FAB() {
  self endon("_encstr_AD75063D571AE108");
  wait 1;
  trial_dogtags();
  self.spawnsystem_init = propremovefromcircle();

  if(self.spawnsystem_init == 0)
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8A3B0C4380167252EF374EC310D7", self);
}

_id_12CC3() {
  var_0 = train_mover_test();

  if(var_0 >= 80)
    scripts\mp\perks\perks::bears();
}

droponplayerdeath(var_0) {
  _id_125FC();
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::minplunderextractions(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missiontime(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::mintokensdropondeath(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missedinfilplayerhandler(var_1);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::hangar_doors_opening_quadrace();
  return 1;
}

playerdropplunderondeath(var_0, var_1) {
  if(scripts\mp\utility\game::updatehistoryhud(self))
    return 1;

  if(istrue(level.gameended))
    return 1;

  if(isDefined(self.plundercount) && self.plundercount > 0)
    var_2 = self.plundercount;
  else
    var_2 = 0;

  if(istrue(self.unicornpoints)) {
    var_3 = 0;
    var_4 = level.endgametutorial_func._id_127B5;
  } else {
    var_3 = int(var_2 * level._id_11BCE._id_127BE + 0.5);
    var_4 = int(level._id_11BCE._id_127B5 + var_2 * level._id_11BCE._id_127B6 + 0.5);
  }

  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_3);

  if(var_4 <= 0) {
    return;
  }
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::ml_p3_func(var_4, var_0);
  return 1;
}

_id_12356(var_0, var_1, var_2, var_3) {
  if(var_0 != "_encstr_AAFC1592206975172B30F5F5B0F1CF7B9BB1AACAB8C3ED")
    return var_2;

  if(istrue(var_3.playersetattractiontype))
    return getdvarint("_encstr_A70E1D3AD7DBB696BB8FF0E35AB9C22058A7FDC12847C236A3C613AFFB0E1B", 10);
  else if(istrue(var_3._encstr_B4FF10DBA588EA4A18C37E82991072E2DD13))
    return getdvarint("_encstr_B8B91E9BC6E4EB4CE4FA5B3CE07D2DDC47B21BEB664E959B73DBBE36EDD5B91D", 10);
  else
    return getdvarint("_encstr_A7C81D1B3E4568439DE1535ACF77D4F203E80919674156417F0770C8A36DB1", 1);
}

onusecompleted(var_0) {
  if(!isDefined(var_0.tracknonoobplayerlocation))
    return 0;

  return _id_11BCF(var_0.tracknonoobplayerlocation, self);
}

_id_13A36(var_0) {
  var_0.count = var_0.tracknonoobplayerlocation.count;
  return var_0.tracknonoobplayerlocation.count;
}

get_chopper_minigun_start_node(var_0) {
  var_1 = self;

  if(_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_encstr_A9EF0C543E3A303CD5B5F1C3D8D5(var_0.scriptablename) || var_0 _encstr_AD1A0E289D7C2039E1BFC7FB8B7BF530()) {
    if(_encstr_970111AFD53D526C0199B67DB1A8A47A1D6743(var_1))
      return 1;
    else
      return 2;
  }
}

_encstr_837E130AB898A0CB7307176749ACC2ED5821069650(var_0, var_1, var_2, var_3) {
  if((_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_encstr_A9EF0C543E3A303CD5B5F1C3D8D5(var_0.scriptablename) || var_0 _encstr_AD1A0E289D7C2039E1BFC7FB8B7BF530()) && istrue(var_1))
    return 1;
}