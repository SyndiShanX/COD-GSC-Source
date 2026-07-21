/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58263.gsc
***********************************************/

all_players_pushed_past_pos() {}

init() {
  level._effect["_encstr_823E1E63CA4B08B8C4EC6337EB2C0869C763DEC902CF40F0D8C0415F1B144820"] = loadfx("_encstr_8190367327B8BA73BB32672523064C0B757F3BC80E1102B4C25B6F2DCB2F984819938226347950612A6B773F9F73C0B0B0EAA8B85AD19028");
  level._effect["_encstr_BEC21A502E7061E387930B6F88FBD9C1978BA93960D2DF8A3110AB30"] = loadfx("_encstr_8293323B69608F0A2CE1F70B9DF81239209132052130C7B38C59EFF385DED973B85BE84118185CCA5525E7EF8BA601ABF8806317");
  level._effect["_encstr_8F7F21AC6A4B06B359BB58AFA0F363F9D03A0712D1A737138D48FD313F93AD21B048D3"] = loadfx("_encstr_8E01399DEC70B8D74C88293D4367BA31058843E9E323C66C46200F1EBAFA57277CAB80C7EAC48A4D42B34F6F8832EFFF3195CDDB17A08A0FC3E8A8");
  level._effect["_encstr_A29C22673387D7982733AF365A1DE5FAADB4631B2B93EB76C2DCAFB3B2731DEBED0EACCD"] = loadfx("_encstr_A5FC36232923304A636867532B5E204A454F03D54AF90820E85271A9FE9F3F0E1174B0F70AAC3129BF1BCF1FC24A7F531DD243708D638DA8");
  level._effect["_encstr_B6E824A3F1F86712164F5F97C33D6BAFB8F8DDAD0993DF1AE7A757CB33E883F790E095F2A1C8"] = loadfx("_encstr_851C38B69533F760A77FD1FA530F90FF103D83384EF3121CCD8358BE8272378E5C3CBBEFFA39211A82660FA8C607A1938FD59D11EE8D3248177C");
  level._effect["_encstr_B6FC26CE99E1D7139C33D7B1D2E82FF5D6B463B19527AF7685E6AFB163BDD58CFA462D373A58CDD1"] = loadfx("_encstr_AF313AC69CA216FC4F5A61AA1027B7E7F8F54844A72A4E43057069A2F837E197D0E5B9FFCA708B0D3B58510A58CF295F28C03D7C48392792F1E84A33");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8F220C3BC1D17391C2B85469FBB2", ::_id_13E26, undefined, ::_id_13E0E);
  scripts\mp\utility\sound::besttime("_encstr_8B1F0E80A241517818BA873042389B2A");
  scripts\engine\scriptable::scriptable_addusedcallback(::scriptable_used);
  scripts\engine\scriptable::_id_12F57(::scriptable_used);
  test_bag_pickup();
  _handlevehiclerepair::init();
  timesincelastdeath();
  level thread testsplashes();

  if(level.gulagloadoutindex.gulagmatchclocksounds == "_encstr_9A640BC515F8B7C733E3C0F1E5")
    level thread _id_144A3();

  waitframe();

  if(isDefined(level.disable_super_in_turret))
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B33("_encstr_AAAD1EF8FB62F88809C747CBA1F84B237A6F46AA8E4A6BB8D3F1C3EBB983323A", ::settings_group);
}

scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }
  if(isDefined(var_0) && isDefined(var_0.type)) {
    if(var_0.type == "_encstr_AAAD1EF8FB62F88809C747CBA1F84B237A6F46AA8E4A6BB8D3F1C3EBB983323A") {
      var_0 notify("_encstr_92A716B9420373311CA96169CD0269BFDF5A30E17A57AD80");
      var_3 gwperifvfx_plumes();
      var_3 thread _id_144A1();
      var_3 thread _id_144A2();
    }
  }
}

testsplashes() {
  waitframe();

  if(!isDefined(game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"]))
    game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"] = [];

  hack_addkilltriggers("_encstr_8F481CC07FACFA6F7A9C8981F7832721EEE708983F5B30D13209F0180D2A", "_encstr_ABF01FE3B09E1A5B4328164EAB4D41A3A0217F4320B049B18FDB9D85180D1A6689");
  hack_addkilltriggers("_encstr_A1441B0EE4FB4B5EDB0FC0F807FA96BB820FF18BF1A2D360B45BE093CF", "_encstr_9AAE1EF5B0B781358E29F0F07262B7798F6F8D7805C7AA277452B8906A7CA5F0");
  hack_addkilltriggers("_encstr_9A6321869B182FBF3752B8F1E59D8637486F3871674087BC8DFAC032A3861567B8CB40", "_encstr_8367248BEA4F558E0968E2E7232617B257691B454D9D92184F9BA2B8EEF37340AF0A67E42183");
  hack_addkilltriggers("_encstr_82D81ACEC128B3C05BA3C1910DB3D6F01F9B8B77308181EE654CBD7A", "_encstr_AF571DC97829E8CE7719A9B1520310A87CC76DBB0C0CE8966742C118CA37BE");
  hack_addkilltriggers("_encstr_8A011AD2C8DD0F39A82B6C64DB88F1F30961CB3A332033EF48399769", "_encstr_8E7E1DF9D3C106A821910139441A89CE3AE749614F4B5D904737E9536DFF60");
  hack_addkilltriggers("_encstr_9A3F1D376B8D23EFF088858D2110273A689BF7D79F3DAA98B050F859B95032", "_encstr_842A20825B79E10E9F07BE06A03847F24A5F379AC2A5CB1FD44998A8700319C26276");
  hack_addkilltriggers("_encstr_8CF21E803FECBA2F3ADC49413743E7E12EA748D87F94712972453BC0CD6AE34B", "_encstr_AC7321FABBCF499321C6EB51A30A272107B1C5F3A37D472141678212E793F005A091CB");
  hack_addkilltriggers("_encstr_BA5419B1A51D2FFA6D5AB1C65639BE6EE2D58532FAC82B1CB17BBC", "_encstr_B6C31C5773EF722A7199E3FF38CBCFAA7F181A8A5D3B4A7FB960A3CBE882");
  hack_addkilltriggers("_encstr_86321B0278D9705748AB747CB5B38FBF05E06A3B61412FB3A037417C5D", "_encstr_8A751EDDF0192DAB81A7C0D063CA46672251C5500F92C3F66C6778B813F1FB93");
  hack_addkilltriggers("_encstr_84501B97F713EBA10B3CE0F827FA6926BB6F0B1197BABD8057D549F3CF", "_encstr_86551EF5D83105F3D9CFB8B83BE26EBFDA89F687730AC11E845F10E03B09C3FB");
  hack_addkilltriggers("_encstr_A35C1ECF9305AB67682D3D05B9985FA2D0137F5F1727B201F068B24F16D0A98B", "_encstr_AB9621C8830789AA09CFD229E85D4E23DFEFC9F8EFA5BBF9513380032816DD09D86AF3");
  hack_addkilltriggers("_encstr_9A401F376B8D23EFF088858D2110273A689BF7D79FBFCA9978903AD79E2825323E", "_encstr_97BA223287FA98C9587D986C4327AFD8B67D59CD2BD6BCBEB0D82EAB96E4AC7D9BB2B039");
  hack_addkilltriggers("_encstr_B8AC1A6F0FEB1349D3E448408F9211CFC297D3FB8BA15F30F37C13DB", "_encstr_ACBF1DE44396F3EAB391426A10ADE9BF48B8789457FA57322783FA6260CB1A");
  hack_addkilltriggers("_encstr_BA5B1A36D2A3F27DB54BB16359397DDC2E57B019FA0B8D8BBAB439B2", "_encstr_A7201D9C090166CBB7E6322A2816479E08DF03F17BA8AFB76F991B73106EE7");
  hack_addkilltriggers("_encstr_8711178D961DBCAFB596C61BAC4EEBC9C2C84BAE6EBECC859C", "_encstr_B6901A71C061A0962F51D1F90A4BD870840FA5F34454505EAFDA89C3");
  hack_addkilltriggers("_encstr_8BF618E90808A709F3807B34C2FED145504533A59799A2A396F5", "_encstr_BECB1B61F0AFE0CEEA7FCDD7BB03802023812B599FF1AB062153CBDBFB");
  hack_addkilltriggers("_encstr_9AB921B196E8E57DD64B8DD82B9CF5E485324BEAB9FA232DE63796E0588EACBE998527", "_encstr_8C3D242083D1CD4397472E9658F3AE978499E880DAF42BBB9764A3963BC7735BAB82092022CA");
  hack_addkilltriggers("_encstr_8464224B93ABC7C9CF58CAC2D0153113E18DD9D53696FB0CA7B082FBE821F7EFB8E5596A", "_encstr_961A253D10F9CD4B6187E0F043AA26070271AE376FF2BB537783B07807D99BBB1B67B0C887AA7D");
}

hack_addkilltriggers(var_0, var_1) {
  game["_encstr_B2DA070A5F8BAB87AF"][var_0] = var_1;
  game["_encstr_BA3712519726E1676C6FC09A1191B019D5D80A1F"][var_0] = 1;
}

gunless() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");
  var_0 = 5;
  var_1 = 0;

  for(;;) {
    if(self.vehomncontrols != var_1) {
      var_2 = undefined;

      if(self.vehomncontrols - var_1 >= 2) {
        var_2 = "_encstr_9A6321869B182FBF3752B8F1E59D8637486F3871674087BC8DFAC032A3861567B8CB40";
        var_0 = 8;
      } else {
        var_2 = "_encstr_A1441B0EE4FB4B5EDB0FC0F807FA96BB820FF18BF1A2D360B45BE093CF";
        var_0 = 5;
      }

      if(isDefined(var_2))
        thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward(var_2, self.owner);

      var_1 = self.vehomncontrols;
    }

    wait(var_0);
  }
}

gunbutt(var_0, var_1, var_2, var_3) {
  var_4 = distance2d(self.origin, var_2.origin) <= level.gulagloadoutindex.gulagwinnerrestoregunandammo;
  var_5 = scripts\engine\utility::ter_op(var_4, var_0, var_1);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward(var_5, var_2, 1, 0, var_3);
}

timesincelastdeath() {
  var_0 = [];
  var_0["_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996"] = 2;
  var_0["_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3"] = 0.2;
  var_0["_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926"] = 0.1;
  _handlevehiclerepair::_id_11A45("_encstr_A5A9149A80955761E013A4BC13703937B7984322A9E5", var_0);
}

test_bag_pickup() {
  if(!isDefined(level.gulagloadoutindex)) {
    level.gulagloadoutindex = spawnStruct();
    level.gulagloadoutindex.instances = [];
    level.gulagloadoutindex.laststandweapon = undefined;
    level.gulagtableloadout = 0;
  }

  level.gulagloadoutindex._id_11B43 = getdvarfloat("_encstr_8C0C2302B14887E27B2127C767135AFCA83BB10D69F07F1A46096F6B53D0723CD1E0751601", 1);
  level.gulagloadoutindex._id_1288C = getdvarfloat("_encstr_8D6E1BF8DB2640CE4CBB214F57C3036B4DCA89F00AC7A155B7A37045D1", 3.5);
  level.gulagloadoutindex.leave_pool_behind_after_deactivation = getdvarfloat("_encstr_91A52037B352317667FB9A46123FB9E02F1AE7815D3B68C86F9390486A0F6D704565", 30);
  level.gulagloadoutindex.lifetime = getdvarint("_encstr_81FE193F57FB70F881F3DA16DC797811628BEFB9D7E22508A98D41", 120);
  level.gulagloadoutindex._id_12EC1 = getdvarfloat("_encstr_97AC17FF760E87C7A1A3E8A9A2C7219A720341564ED279C103", 1);
  level.gulagloadoutindex._id_129E2 = getdvarfloat("_encstr_8654237E1EE37FD1D163605937F908A13AC2E006765ADB5B93B728184B0D61F9E1EB6301CF", 95.0) * level.gulagloadoutindex._id_12EC1;
  level.gulagloadoutindex._id_129E0 = getdvarint("_encstr_A3301BC06AC2DF09CF04CBD0E3371071EFE32970E21FCB838F07D937D8", 15000) * level.gulagloadoutindex._id_12EC1;
  level.gulagloadoutindex._id_129E1 = getdvarint("_encstr_87301BEBB1E69F3EA019815FDF58059B850BA14359B53FF358679D61FD", 2000) * level.gulagloadoutindex._id_12EC1;
  level.gulagloadoutindex.thermiteburnout = getdvarint("_encstr_B46B2A7B31B3D72F58BD9B594A937B18B57BC9AC9878A1BFB31587B963EBE7809B79B067C840F1376A6978A9", 90);
  level.gulagloadoutindex.is_cs_script_origin = getdvarint("_encstr_A797286606FB67B9B91B08411FC11049D2EAC8E3DDA2C920995331901FED49877AD9D77D327981684357", 6);
  level.gulagloadoutindex.is_cs_scriptable = getdvarint("_encstr_88233396F60B974949CBD8F1AF916039825A18130D1299702983E1206FBD99572A8907AD622951B813E7D99007C4F38323ED7325FA", 3);
  level.gulagloadoutindex.is_current_solution_correct = getdvarint("_encstr_B4B03B3736E4EB8DD2E8F2D76DD2C68D56937DD2732DD19685D8F5C858DA0BCECAEB3856C9EBD1D28DB6D76B5D8D1D9683D85AAC39EB5937B089D8958C", 0);
  level.gulagloadoutindex.is_cover_node = getdvarint("_encstr_83C5296E1B93FA6C2DA3BCBEB62D63B1CA4ED732B0AD859DCA7D6BD58DA34BC1362FFA91AE932C47B4DBCD", 30);
  level.gulagloadoutindex.start_coop_escape_end_camera = getdvarint("_encstr_8F962C92FEB5A13B70C08F0F20A8FC5A638E118CD0477A415BB1BBE35046A0B2D3AC2443D049429AA1A8FB3FC859", 2250);
  level.gulagloadoutindex.gulagloadouts = getdvarint("_encstr_AD0D2877F3127136273B5A86D2FF79206F5AA7CF917AC8893F61B3A9CB4FAE7886B77D3F0165604D6BEB", 2);
  level.gulagloadoutindex.gulagloadouttable = getdvarint("_encstr_8780302E4EB32FE1E153B089C709D8916AB2B0BEA4CB1F48D5E73058B36773E1F21B9028BEB2CD51AA37B048477128774A07", 90);
  level.gulagloadoutindex._id_14295 = getdvarint("_encstr_A2962ECB508E677AFCA39379DA0ADB3B7205D11BBB0B665C87670B08B0DB2F2A592A53BD71EF731F0F70AE4DD8FAAE93", 0.1);
  level.gulagloadoutindex._id_14296 = getdvarint("_encstr_83153063403607A6B8CBDAB9AFD3349C687AF11319414E21239B6A8880303087696658BFE5BDE107F8811B82A085C2A1206B", 3.5);
  level.gulagloadoutindex._id_14294 = getdvarint("_encstr_AF0E273EEB436657CCDB685102E411587782503446D3AE9B7542E00839FCD3F19B074025CCA770FF5F", 0);
  level.gulagloadoutindex._id_142A2 = getdvarint("_encstr_99D92973C790D187BB9B8BD14083F355708D27FE55686977D030420BAEEECB4D1819834FD7D02E170B287A", 3000);
  level.gulagloadoutindex._id_142A1 = getdvarint("_encstr_84F735687F82062F72C36B601C2A6928FD4381D8C330DEF3EA6D6DFE79A2A1B035B398195FD25091C1175384CC5B93F886C79020FF964B", 15);
  level.gulagloadoutindex._id_1215B = getdvarint("_encstr_BA0129CDC693D78DB41DF2AF5B9636C65627F57B5D1DCA27FAECB46ED2F6CDAF9B59E8EBB2DCB04C3659C8", 0);
  level.gulagloadoutindex._id_1215C = getdvarint("_encstr_8C6D32D2E8628707A823B32037685BCA309A29E7DD24E0EB51304066E7C75810E6829B4969EAB024F28B13D9D9020B7BE28002C1", 4000);
  level.gulagloadoutindex.gulagwinnertableloadout = getdvarint("_encstr_B8422DF6966BF72929EBF8D18F7180D9A27A78FFADB24DF30DC3C1B8CB9CF95F1AA9668F076A33DBCFE3E8286BADD3", 100);
  level.gulagloadoutindex.gulagwinnerrestoregunandammo = getdvarint("_encstr_A35626BE6BC3E6D74C5BE8D1826491D8F702D0B8C5378B673523E1335AFA3F131BAA45AE50E7F069", level.gulagloadoutindex._id_129E0 + level.gulagloadoutindex.gulagwinnertableloadout);
  level.gulagloadoutindex.gulagmatchclocksounds = getDvar("_encstr_A736216ED893AF6C4BD12FFAB64BD836CA397D19D29B85318D95D7B737BE599D56E6A3", "_encstr_9A640BC515F8B7C733E3C0F1E5");
  level.gulagloadoutindex.gulagplayerlost = getdvarint("_encstr_8FC826B98DE4F536D2E897FA6D4B1BD8AC27AF46D237851336ACEBDB37AFB9D11AFAB12D276C3695", 3);
  level.gulagloadoutindex.gulagplayerwatchfordeath = getdvarint("_encstr_9538352328860F272809C7093420F078112BF994F00B020D2883BF09B91632A7332F1AD58D5F80EB9EEA5550317861CB1053389C9F770B", 120);
}

_id_13E26(var_0) {
  var_1 = _id_13E27(var_0);

  if(!var_1) {
    var_2 = undefined;

    if(level.gulagloadoutindex.instances.size >= level.gulagloadoutindex._id_11B43)
      var_2 = "_encstr_836027D51BA1F6192535869F2FC9113848F7975FCFB9A3D9731CECF4C7E231411043FFE38FE1635955";
    else if(!_id_124C5())
      var_2 = "_encstr_B1912A90497D34121535BED55114413D93A9F20D525165AFB42598138A49BE35A81421C48A7DD1493D559C22";
    else
      var_2 = "_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_2);
  }

  return var_1;
}

_id_13E0E() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8F220C3BC1D17391C2B85469FBB2", self);
  var_0._id_133CE = 1;
  return _id_13E27(var_0, 1);
}

_id_13E27(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(level.gulagloadoutindex.instances.size >= level.gulagloadoutindex._id_11B43)
    return 0;

  if(level.gulagtableloadout)
    return 0;

  if(isDefined(level.gulagloadoutindex.laststandweapon) && isPlayer(level.gulagloadoutindex.laststandweapon))
    return 0;

  if(!_id_124C5())
    return 0;

  if(self isparachuting() || self isskydiving() || self isonladder())
    return 0;

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown))
    return 0;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  thread _id_1248C(var_0);

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.streakname, self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_B47106834B35B9CF" + var_0.streakname, self);

  return 1;
}

gunnerdamagemodifier() {
  scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  thread scripts\mp\hud_message::showsplash("_encstr_A7EB1BFFA355FB3738704D55E9A86F62A3CB735B13F541D0E8595E1F63");
  _handlevehiclerepair::_id_13673("_encstr_A5A9149A80955761E013A4BC13703937B7984322A9E5", self.origin, 8, 0);
  thread scripts\mp\rank::giverankxp("_encstr_8E771568E26B8B962FE1B9A1C5635E27961A58F07A47F9", 500);
  thread scripts\mp\rank::scoreeventpopup("_encstr_8E771568E26B8B962FE1B9A1C5635E27961A58F07A47F9");
}

gwperifvfx_plumes() {
  if(!istrue(self.setupzombierespawnglobaltimer))
    self.setupzombierespawnglobaltimer = 1;
  else
    return;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = undefined;

    if(var_1 == self) {
      var_2 = "_encstr_969A1A9827F452C7C23451690F6BFF194BDFA0B023BD490FABDF5964";
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B8AC1A6F0FEB1349D3E448408F9211CFC297D3FB8BA15F30F37C13DB", var_1);
    } else if(var_1.team == self.team) {
      var_2 = "_encstr_8E231A8D2D8E97F5DAA5361B2B9CF5588D2EBAB4E42B327D16C663F2";
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_BA5B1A36D2A3F27DB54BB16359397DDC2E57B019FA0B8D8BBAB439B2", var_1);
    } else {
      if(distance2d(self.origin, var_1.origin) < 3000)
        var_2 = "_encstr_AD121BD8D247CB7DB55A8DC62B27FA16D8B8EAB4E4ACC8FA95B959B5E5";

      gunbutt("_encstr_9A401F376B8D23EFF088858D2110273A689BF7D79FBFCA9978903AD79E2825323E", "_encstr_A35C1ECF9305AB67682D3D05B9985FA2D0137F5F1727B201F068B24F16D0A98B", var_1);
    }

    if(!isDefined(var_2)) {
      continue;
    }
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_1, var_2);
  }
}

allowreuseofalldropbags() {}

_id_1248C(var_0) {
  if(!isDefined(level.gulagloadoutindex.laststandweapon))
    level.gulagloadoutindex.laststandweapon = self;

  var_1 = scripts\mp\utility\weapon::getweaponrootname("_encstr_AC8B0FC7C074F3495A781470F242179827");
  var_2 = scripts\mp\class::fixcollision(var_1, undefined, undefined, -1, undefined, undefined, 0);
  var_0.weaponobj = var_2;
  var_0.laststandplayers = 0;
  self.gulagwinnerloadout = var_0;
  _id_1246A(0);
  _id_12469(0);
  self giveweapon(var_2);
  self setweaponammostock(var_2, 0);
  self setweaponammoclip(var_2, 0);
  scripts\mp\supers::allowsuperweaponstow();
  var_3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("_encstr_AC8B0FC7C074F3495A781470F242179827", 0, 1);
  var_4 = 1;

  if(!istrue(var_3)) {
    scripts\mp\supers::unstowsuperweapon();

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_2);
    else
      self takeweapon("_encstr_AC8B0FC7C074F3495A781470F242179827");

    var_4 = 0;
  }

  scripts\mp\weapons::fixupplayerweapons(self, var_2);
  thread _id_144A4(var_2);
  thread _id_144A5(var_2);
  thread _id_144A8(var_0);
  thread _id_144A0();
  return var_4;
}

_id_1246A(var_0) {
  self allowstand(var_0);
  self allowprone(var_0);
  self allowsprint(var_0);
  self allowmovement(var_0);
}

_id_12469(var_0) {
  if(scripts\common\utility::trial_ui_retry_disabled() != var_0)
    scripts\common\utility::brjugg_droponplayerdeath(var_0, "_encstr_8F220C3BC1D17391C2B85469FBB2");

  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_killstreaks(var_0);
  scripts\common\utility::allow_crate_use(var_0);
  scripts\mp\equipment::allow_equipment(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
  scripts\common\utility::brjugg_onplayerkilled(var_0);
  scripts\common\utility::allow_usability(var_0);
  scripts\common\utility::allow_weapon_pickup(var_0);
  scripts\common\utility::allow_vehicle_use(var_0);
}

_id_12477(var_0, var_1) {
  if(!isDefined(var_0) || !var_0)
    scripts\mp\utility\inventory::switchtolastweapon();

  if(isDefined(level.gulagloadoutindex.laststandweapon) && level.gulagloadoutindex.laststandweapon == self)
    level.gulagloadoutindex.laststandweapon = undefined;

  _id_1246A(1);
  _id_12469(1);

  if(!isDefined(var_1) || !var_1) {
    if(!istrue(self.gulagwinnerloadout.laststandplayers))
      playernumlivesvo();
  }

  thread _id_144A7();
}

allowskydivecutparachute() {}

_id_144A8(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AF1A12A7E5A83B6CE9615CE3DA118B42F1613F53");
  self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);
  var_2 = gettime();
  var_3 = var_2 + level.gulagloadoutindex._id_1288C * 1000;

  while(gettime() < var_3) {
    if(self getcurrentweapon() != var_1 || isDefined(level.gulagloadoutindex.laststandweapon) && level.gulagloadoutindex.laststandweapon != self) {
      _id_12477(0, 0);
      return;
    }

    waitframe();
  }

  if(level.gulagloadoutindex.instances.size >= level.gulagloadoutindex._id_11B43) {
    _id_12477(0, 0);
    return;
  } else {
    self.gulagwinnerloadout.laststandplayers = 1;
    _id_12477(0, 1);
  }

  for(;;) {
    if(self getcurrentweapon().basename != "_encstr_AC8B0FC7C074F3495A781470F242179827") {
      var_4 = thread _id_124DC();
      break;
    }

    waitframe();
  }
}

_id_144A7() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(self hasweapon("_encstr_AC8B0FC7C074F3495A781470F242179827")) {
    if(self getcurrentweapon().basename != "_encstr_AC8B0FC7C074F3495A781470F242179827") {
      self takeweapon("_encstr_AC8B0FC7C074F3495A781470F242179827");
      self.gulagwinnerloadout = undefined;
      break;
    }

    waitframe();
  }

  waitframe();
  self notify("_encstr_AF1A12A7E5A83B6CE9615CE3DA118B42F1613F53");
}

_id_144A4(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AF1A12A7E5A83B6CE9615CE3DA118B42F1613F53");

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);

    if(self hasweapon(var_0) && var_1 != var_0) {
      if(!self isonladder() && !(var_1.ismelee && self ismeleeing()) && var_1.basename != "_encstr_B60816BAAB286D9BE1BF79AE2BC31FB38B8B856008975D73") {
        var_2 = self.gulagwinnerloadout.laststandplayers;
        _id_12477(1, var_2);
      }
    }
  }
}

_id_144A0() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF1A12A7E5A83B6CE9615CE3DA118B42F1613F53");
  self endon("_encstr_962F151B968EF2F5D6D21BC6AC9CFA19B2C1B1F6F295C8");

  if(isDefined(level.gulagloadoutindex.laststandweapon))
    level.gulagloadoutindex.laststandweapon = undefined;

  while(isalive(self))
    waitframe();

  _id_12485();
}

_id_144A5(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AF1A12A7E5A83B6CE9615CE3DA118B42F1613F53");

  for(;;) {
    self waittill("_encstr_88A80D134FDE4B2FA8A7CBBF2B45DD", var_1);

    if(var_1 == var_0) {
      if(!isDefined(self.gulagwinnerloadout)) {
        break;
      }

      waitframe();
      var_2 = self.gulagwinnerloadout.laststandplayers;
      _id_12477(var_2, var_2);
    }

    waitframe();
  }
}

_id_144A1() {
  if(level.gulagloadoutindex.gulagmatchclocksounds != "_encstr_92FE0F2A3004296FB193F8E36B69EAE3B6") {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_AA011BC07FACFA6F7A9C8981F7832761F5C35858DF6FF3CBB306F31D0A");
  self endon("_encstr_AA011BC07FACFA6F7A9C8981F7832761F5C35858DF6FF3CBB306F31D0A");
  var_0 = 0;

  for(;;) {
    if(istrue(level.usegulag)) {
      if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
        if(!var_0 && _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::run_hud_logic() <= level.gulagloadoutindex.gulagplayerwatchfordeath) {
          thread scripts\mp\hud_message::showsplash("_encstr_B69C1D63D3A05877BA38DAE2810E3F5710AB1AE453886977D091E2FA6868E7");
          var_0 = 1;
        }
      }

      if(istrue(level.gulag.shutdown)) {
        if(isDefined(scripts\mp\killstreaks\killstreaks::getequippedkillstreakbyname("_encstr_8F220C3BC1D17391C2B85469FBB2")))
          thread gunnerdamagemodifier();

        break;
      }
    }

    wait 1.0;
  }
}

_id_144A2() {
  if(level.gulagloadoutindex.gulagmatchclocksounds != "_encstr_9A640BC515F8B7C733E3C0F1E5") {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);

    if(var_0 >= level.gulagloadoutindex.gulagplayerlost && (!istrue(level.br_circle_disabled) || getdvarint("_encstr_B4181013C9FAC64BC9D86395F507585DDC59", 0) != 1)) {
      if(isDefined(scripts\mp\killstreaks\killstreaks::getequippedkillstreakbyname("_encstr_8F220C3BC1D17391C2B85469FBB2")))
        thread gunnerdamagemodifier();

      break;
    }
  }
}

_id_144A3() {
  if(level.gulagloadoutindex.gulagmatchclocksounds != "_encstr_9A640BC515F8B7C733E3C0F1E5") {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);

    if(var_0 >= level.gulagloadoutindex.gulagplayerlost && (!istrue(level.br_circle_disabled) || getdvarint("_encstr_B4181013C9FAC64BC9D86395F507585DDC59", 0) != 1)) {
      level.gulagtableloadout = 1;

      if(getdvarint("_encstr_AAF62372C138F79228454B3773D85B0828EB2D3FFE20822AFF0F2317ADF5F279019165C531") == 1)
        _handlevehiclerepair::_id_11A46("_encstr_A798166F84291F38BE13B870CFC3B04942AA5D6E1F22F763", "_encstr_AAAD1EF8FB62F88809C747CBA1F84B237A6F46AA8E4A6BB8D3F1C3EBB983323A");

      break;
    }
  }
}

settings_group() {
  thread _id_1444A();
}

_id_1444A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_92A716B9420373311CA96169CD0269BFDF5A30E17A57AD80");

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);

    if(!isDefined(self)) {
      break;
    }

    if(var_0 >= 3) {
      self freescriptable();
      break;
    }
  }
}

addtoc130infil() {}

_id_124C5() {
  var_0 = self getgroundentity();

  if(isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0" && self isonground())
    return 1;

  return 0;
}

_id_124DC() {
  self notify("_encstr_962F151B968EF2F5D6D21BC6AC9CFA19B2C1B1F6F295C8");
  var_0 = physics_raycast(self.origin + (0, 0, 30), self.origin + (0, 0, -1500), scripts\engine\trace::create_solid_ai_contents(1), self, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1, undefined);

  if(!isDefined(var_0) || var_0.size == 0) {
    var_1 = self.angles;
    var_2 = self.origin;
  } else {
    var_3 = var_0[0]["_encstr_820E07FAE8780B3A4C"];
    var_4 = vectorcross(var_3, anglesToForward(self.angles) * -1.0);
    var_5 = vectorcross(var_3, var_4);
    var_1 = axistoangles(var_5, var_4, var_3);
    var_2 = var_0[0]["_encstr_BD260953AA97E3F014279D"] + var_3;
  }

  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_6 setModel("_encstr_969A20F81BE670BB9277C8E40DB9857B418F38E06FAB690FEADED6F8E6E2D783B523");
  var_6 setotherent(self);
  var_6.owner = self;
  var_6.team = self.team;
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("_encstr_B6E824A3F1F86712164F5F97C33D6BAFB8F8DDAD0993DF1AE7A757CB33E883F790E095F2A1C8"), var_6, "_encstr_96300853C30FB940C275");
  var_6._id_13290 = easepower("_encstr_82F826F32318235261102A6230DF8EEFB3937F7B4B606B9F5561923B70EBC57F8977DBEDC8A9A722", self.origin);
  waitframe();
  var_6._id_13290 setscriptablepartstate("_encstr_96F31926F14BB277FC6AD090E3191DAB57653CAE518FF9D7A78230", "_encstr_9A7712319CA55999B10BCD56F5CEC2DCAF9B99E1");
  var_6.origin = var_2;
  var_6.angles = var_1;
  var_6.height = scripts\cp_mp\parachute::getc130height() * 2;
  var_6.initialwinningteam = 0;
  var_6._id_129E0 = int(level.gulagloadoutindex._id_129E0);
  var_6._id_129E1 = int(level.gulagloadoutindex._id_129E1);
  var_6._id_129DF = var_6._id_129E1;
  var_6.impactshoulddestroyent = gettime();
  var_6.impactfunc_stun = var_6.impactshoulddestroyent + level.gulagloadoutindex.leave_pool_behind_after_deactivation * 1000;
  var_6.sfx_infil_hackney_heli2_rope = 0;
  var_6 thread gun_buildoverrideattachmentlist();
  var_6 thread gwinputtypesused();
  var_6 thread gun_createrandomweapon();
  level.gulagloadoutindex.instances = scripts\engine\utility::array_add(level.gulagloadoutindex.instances, var_6);
  level.gulagloadoutindex.laststandweapon = undefined;
  var_6.vehomncontrols = 0;
  self allowcrouch(0);
  self allowprone(0);
  waitframe();
  self allowcrouch(1);
  self allowprone(1);
  var_7 = ["_encstr_82D81ACEC128B3C05BA3C1910DB3D6F01F9B8B77308181EE654CBD7A", "_encstr_8A011AD2C8DD0F39A82B6C64DB88F1F30961CB3A332033EF48399769"];
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward(scripts\engine\utility::random(var_7), var_6.owner, 1, 1);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztutdropcash("_encstr_BA5419B1A51D2FFA6D5AB1C65639BE6EE2D58532FAC82B1CB17BBC", var_6.team, var_6.owner);

  foreach(var_9 in level.players) {
    if(var_9.team == var_6.team) {
      continue;
    }
    gunbutt("_encstr_8CF21E803FECBA2F3ADC49413743E7E12EA748D87F94712972453BC0CD6AE34B", "_encstr_9A3F1D376B8D23EFF088858D2110273A689BF7D79F3DAA98B050F859B95032", var_9);
  }

  return var_6;
}

gun_buildoverrideattachmentlist() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");
  var_0 = int(level.gulagloadoutindex.leave_pool_behind_after_deactivation);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(1, 0, 3, self.origin);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13369();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(self._id_129E0);
  self.trackriotshield_tryarm = spawnStruct();
  self.trackriotshield_tryarm _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(1, 0, 2, self.origin);
  self.trackriotshield_tryarm _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13369();
  self.trackriotshield_tryarm _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(self._id_129E1);
  var_1 = (0, 0, self.height / 2);
  var_2 = self.origin - var_1;
  self.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, self._id_129E0, self.height);
  scripts\mp\utility\trigger::makeenterexittrigger(self.trigger, ::guy_pushes_building, ::guy_pushes_terminal, undefined, undefined, ::_id_13DA5);
  self.trigger.gulagloadoutindex = self;
  gunship_assignedtargetmarkers_onnewai();
  thread hack_laser_trap_control();
  var_3 = int(level.gulagloadoutindex.leave_pool_behind_after_deactivation / 2);
  var_4 = 0;

  for(;;) {
    if(var_0 <= 0) {
      thread gun_remove_fake();
      self notify("_encstr_8C5318B15AA3F2BE6DB48D8DB2E4BEB737D723591D7B73581DCA");
      break;
    }

    if(!var_4 && var_0 == var_3) {
      foreach(var_6 in level.players)
      gunbutt("_encstr_86321B0278D9705748AB747CB5B38FBF05E06A3B61412FB3A037417C5D", "_encstr_84501B97F713EBA10B3CE0F827FA6926BB6F0B1197BABD8057D549F3CF", var_6);

      var_4 = 1;
    }

    var_0--;
    wait 1.0;
  }
}

hack_laser_trap_control() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8C5318B15AA3F2BE6DB48D8DB2E4BEB737D723591D7B73581DCA");
  var_0 = gettime();
  wait 1.0;

  while(!self.sfx_infil_hackney_heli2_rope) {
    var_1 = (self.impactfunc_stun - gettime()) / 1000;

    foreach(var_3 in self.trigger.triggerenterents) {
      var_4 = hack_started(var_1);
      var_3 playlocalsound(var_4);
      var_0 = gettime();
    }

    wait 1.0;
  }
}

hack_started(var_0) {
  if(var_0 > 20)
    return "_encstr_B61216E504A9835B0F9B0850A75AF6D7F2ABD0EDDF424F40";
  else if(var_0 > 10)
    return "_encstr_A9B919BAA5F5B507D7E8A56BCA4EBEB1F6EACD8E23DBDDE6AF2603";
  else if(var_0 > 5)
    return "_encstr_88981FAE96AF5B83EB474B6B5693BE36B75737A332DEBB37F586C21B66AF6EB21B";
  else if(var_0 > 1.5)
    return "_encstr_962A22AB96EBDA07BEE85AD6AC9CFAD8B7D5B947C8BDEEB9FA17BA8539E89593F5B9B28D";
  else
    return "_encstr_B6AF180B8909B0EFAF8BE810E26330885D0DB5B12CED983887F7";
}

gunship_assignedtargetmarkers_onnewai() {
  var_0 = "_encstr_85C0205803C3E04B9E2FE58F4344703137AB9361AA073898342CB3977BACB88937A3";
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_1, self.origin + (0, 0, 50));
  objective_setplayintro(var_1, 1);
  objective_setshowoncompass(var_1, 1);
  objective_setshowdistance(var_1, 1);
  getbnetigrbattlepassxpmultiplier(var_1, self._id_129E1, self._id_129E1 * 2);
  getscriptcachecontents(var_1, 0.5, 0.7);
  scripts\mp\objidpoolmanager::update_objective_icon(var_1, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 50);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_1, self.team);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 1);
  self._id_11F64 = var_1;
}

gun_remove_fake() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_B6E824A3F1F86712164F5F97C33D6BAFB8F8DDAD0993DF1AE7A757CB33E883F790E095F2A1C8"), self, "_encstr_96300853C30FB940C275");
  self setModel("_encstr_B2AA202DE5C5912F9D8BA664C8A722F09092CE9F025777D657D9EFBE90E8814BCA1C");
  self.sfx_infil_hackney_heli2_rope = 1;
  var_0 = playFX(scripts\engine\utility::getfx("_encstr_823E1E63CA4B08B8C4EC6337EB2C0869C763DEC902CF40F0D8C0415F1B144820"), self.origin);
  self._id_13290 freescriptable();
  self._id_13290 = undefined;
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(self._id_11F64);

  if(level.gulagloadoutindex._id_14294)
    var_0 unmarkkeyframedmover(1);

  level thread gunship_watchgameend(self, 2.0);
  thread gunless();
  thread gunship_getbombingpoint();
  self setscriptablepartstate("_encstr_A2BB06B0D8B43BAC", "_encstr_860808CB78E2984063BA");
  thread track_target_group_complete();

  if(level.gulagloadoutindex._id_1215B)
    thread gw_fobs_init();

  self.trigger _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(1, 0, 2, self.origin);
  self.trigger _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13369();
  self.onscavengerbagpickup = gettime();
  self.onriskplayerkilled = self.onscavengerbagpickup + level.gulagloadoutindex.leave_pool_behind_after_deactivation * 1000;
  var_1 = 3.0;

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    thread gunbutt("_encstr_8BF618E90808A709F3807B34C2FED145504533A59799A2A396F5", "_encstr_8711178D961DBCAFB596C61BAC4EEBC9C2C84BAE6EBECC859C", var_3, var_1);
  }

  thread gunship_detachplayerfromintro();
  var_5 = 0;

  for(;;) {
    var_6 = gettime();
    var_7 = (var_6 - self.onscavengerbagpickup) / 1000;
    var_5 = var_7 / level.gulagloadoutindex._id_129E2;
    var_5 = clamp(var_5, 0, 1);
    self._id_129DF = self._id_129E1 * (1.0 - var_5) + self._id_129E0 * var_5;
    self.angles = (0, var_5 * 179.0, 0);
    var_8 = 1;
    var_9 = self.height;
    var_10 = 0.4;
    var_11 = var_5 * (self.height * var_10);
    self.initialwinningteam = clamp(var_11, var_8, var_9);
    self.trigger _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(self._id_129DF);
    waitframe();
  }
}

gunship_getbombingpoint() {
  wait 0.15;

  if(isDefined(level.deposit_from_compromised_convoy_delayed) && isDefined(level.deposit_from_compromised_convoy_delayed._id_1363D))
    var_0 = scripts\engine\utility::array_combine_unique(level.players, level.deposit_from_compromised_convoy_delayed._id_1363D);
  else
    var_0 = level.players;

  foreach(var_2 in var_0) {
    if(self.team == var_2.team && self.owner != var_2) {
      continue;
    }
    var_3 = distance(var_2.origin, self.origin) < self._id_129E1;

    if(var_3) {
      var_2 dodamage(level.gulagloadoutindex.thermiteburnout, var_2.origin, self.owner, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_AC8B0FC7C074F3495A781470F242179827");

      if(!isagent(var_2) && self.team != var_2.team && var_2.br_armorhealth == 0 && var_2.health - level.gulagloadoutindex.thermiteburnout <= 0)
        self.vehomncontrols++;
    }
  }

  wait 0.15;
  self.trackriotshield_tryarm.mapcircle delete();
}

gwinputtypesused() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = self._id_129E0 + level.gulagloadoutindex.gulagwinnertableloadout;
    var_3 = distance2d(self.origin, var_1.origin) <= var_2;

    if(var_3)
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_1, "_encstr_964A14D7306D3A5F10C84D3C6B239811BBE196EDF773");
  }
}

gunship_detachplayerfromintro() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(level.gulagloadoutindex.lifetime);
  level.gulagloadoutindex.instances = scripts\engine\utility::array_remove(level.gulagloadoutindex.instances, self);

  foreach(var_1 in level.players) {
    gun_game_primary_weapon(var_1);
    var_1 notify("_encstr_8873112B9BE8102FE270A2AAD946F7CF6063B4");
    var_1 gunship_origin_override(self.trigger.gulagloadoutindex);
    var_1 hack_airport_combat_init(0);
  }

  wait 0.5;

  if(self.vehomncontrols == 0)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8F481CC07FACFA6F7A9C8981F7832721EEE708983F5B30D13209F0180D2A", self.owner, 1, 1);

  var_3 = 3.0;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    thread gunbutt("_encstr_8464224B93ABC7C9CF58CAC2D0153113E18DD9D53696FB0CA7B082FBE821F7EFB8E5596A", "_encstr_9AB921B196E8E57DD64B8DD82B9CF5E485324BEAB9FA232DE63796E0588EACBE998527", var_1, var_3);
  }

  self.mapcircle delete();
  self.trigger.mapcircle delete();
  self.trigger delete();
  track_settings();
  self notify("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");
  self delete();
}

h(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self._id_124FF))
    self._id_124FF = [];

  var_4 = var_3 getentitynumber();

  if(!isDefined(self._id_124FF[var_4]))
    self._id_124FF[var_4] = [];

  var_5[0] = var_0;
  var_5[1] = var_1;
  var_5[2] = var_2;
  var_6[3] = var_3;
  self._id_124FF[var_4][self._id_124FF[var_4].size] = var_5;
  return var_5;
}

hack_airport_combat_init(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(self.gulagstreamexit)) {
    stopfxontagforclients(scripts\engine\utility::getfx("_encstr_8F7F21AC6A4B06B359BB58AFA0F363F9D03A0712D1A737138D48FD313F93AD21B048D3"), self, "_encstr_AADA07DBF19A4A81D7", self);
    self.gulagstreamexit = undefined;
  }

  if(var_0) {
    self.gulagstreamexit = scripts\engine\utility::getfx("_encstr_8F7F21AC6A4B06B359BB58AFA0F363F9D03A0712D1A737138D48FD313F93AD21B048D3");
    playfxontagforclients(self.gulagstreamexit, self, "_encstr_AADA07DBF19A4A81D7", self);
  }
}

gun_game_primary_weapon(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self notify("_encstr_8290157E88A3D96922433B33B356912BE8D032C9C3C890");
  var_1 = var_0 getentitynumber();
  var_2 = 4;
  var_3 = 0;

  if(!isDefined(self._id_124FF)) {
    return;
  }
  if(!isDefined(self._id_124FF[var_1])) {
    return;
  }
  foreach(var_5 in self._id_124FF[var_1]) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_5[2];
    var_9 = stopfxontagforclients(var_6, var_7, var_8, var_0);
    var_10 = isPlayer(var_7) || isbot(var_7) || isagent(var_7);

    if(!var_10)
      var_7 delete();

    var_3++;

    if(var_3 >= 4) {
      var_3 = 0;
      waitframe();
    }
  }
}

track_target_group_complete() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");
  self._id_142A3 = [];
  self._id_142A4 = [];
  wait(level.gulagloadoutindex._id_14295);
  self.track_get_teleport_velocity = gettime();
  self.track_get_teleport_target = self.track_get_teleport_velocity + level.gulagloadoutindex.lifetime * 1000;
  thread track_timer_think();

  for(;;) {
    var_0 = gettime();
    var_1 = (var_0 - self.track_get_teleport_velocity) / 1000;
    var_2 = var_1 / level.gulagloadoutindex._id_129E2;
    var_2 = clamp(var_2, 0, 1);
    self._id_129DF = self._id_129E1 * (1.0 - var_2) + self._id_129E0 * var_2;
    waitframe();
  }
}

track_timer_think() {
  var_0 = spawnStruct();
  var_1 = self._id_129E0;
  var_0._id_11A58 = self.origin + (var_1 * -1, var_1 * -1, 0);
  var_0._id_11A59 = self.origin + (var_1, var_1 * -1, 0);
  var_0._id_14039 = self.origin + (var_1 * -1, var_1, 0);
  var_0._id_1403A = self.origin + (var_1, var_1, 0);
  var_2 = level.gulagloadoutindex._id_142A1;
  var_3 = self._id_129E0 * 2;
  var_4 = var_3 / var_2;
  var_5 = (self.origin[0] - self._id_129E0, self.origin[1] - self._id_129E0, 0);
  trackcarpunches(self.origin);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    for(var_7 = 0; var_7 < var_2; var_7++) {
      var_8 = var_4 * var_6;
      var_9 = (var_8, 0, 0);
      var_10 = var_4 * var_7;
      var_11 = (0, var_10, 0);
      var_12 = var_5 + var_9 + var_11;

      if(distance2d(var_12, self.origin) < self._id_129E0)
        trackcarpunches(var_12);
    }
  }

  track_last_good_position();
}

trackcarpunches(var_0) {
  var_1 = spawnStruct();
  var_1.index = self._id_142A3.size;
  var_1.origin = var_0;
  var_1.angles = (0, 0, 0);
  var_1.state = "_encstr_9B9406CE2CC64B23";
  var_1.parent = undefined;
  var_1._id_14293 = undefined;
  var_2 = distance(var_1.origin, self.origin);
  var_1.loot_getitemcountlefthand = self._id_129E0 - var_2;
  self._id_142A3[self._id_142A3.size] = var_1;
}

track_last_good_position() {
  trackcashevent(self._id_142A3[0]);

  foreach(var_1 in self._id_142A3) {
    if(var_1.state != "_encstr_9B9406CE2CC64B23") {
      continue;
    }
    var_2 = 500;

    if(var_1.loot_getitemcountlefthand <= var_2) {
      continue;
    }
    trackcashevent(var_1);
  }
}

trackcashevent(var_0) {
  if(var_0.state != "_encstr_9B9406CE2CC64B23") {
    return;
  }
  var_0.state = "_encstr_9B5A0916F76A63C9D40FB0";
  var_1 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39"]);
  var_2 = (0, 0, 100000);
  var_3 = var_0.origin + var_2;
  var_4 = var_0.origin - var_2;
  var_5 = [];
  var_6 = physics_raycast(var_3, var_4, var_1, var_5, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);
  var_7 = var_0.origin;

  if(isDefined(var_6) && var_6.size > 0)
    var_7 = var_6[0]["_encstr_BD260953AA97E3F014279D"];

  var_8 = scripts\engine\utility::ter_op(var_0.loot_getitemcountlefthand < 3000, 200, 1500);
  var_0._id_14293 = spawnfx(scripts\engine\utility::getfx("_encstr_B6FC26CE99E1D7139C33D7B1D2E82FF5D6B463B19527AF7685E6AFB163BDD58CFA462D373A58CDD1"), var_7 + (0, 0, randomfloatrange(0, var_8)));

  if(level.gulagloadoutindex._id_14294)
    var_0._id_14293 unmarkkeyframedmover(1);

  self._id_142A4[self._id_142A4.size] = var_0;
  var_9 = risk_flagspawncount();

  foreach(var_11 in self._id_142A3) {
    if(var_11.state != "_encstr_9B9406CE2CC64B23") {
      continue;
    }
    var_12 = distance2d(var_0.origin, var_11.origin);

    if(var_12 <= level.gulagloadoutindex._id_142A2) {
      var_11.parent = var_0;
      var_11.state = "_encstr_B45509B71086457A32D37A";
      var_11.color = var_9;
    }
  }

  var_0 thread track_is_operational(self);
}

track_is_operational(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");

  for(;;) {
    if(scripts\engine\utility::updatescrapassistdata(self.origin, var_0.origin, var_0._id_129DF + 1500)) {
      if(isDefined(self._id_14293))
        triggerfx(self._id_14293);

      break;
    }

    wait 1.0;
  }
}

track_settings() {
  foreach(var_1 in self._id_142A4) {
    if(isDefined(var_1._id_14293))
      var_1._id_14293 delete();
  }

  self._id_142A3 = [];
  self._id_142A4 = [];
  self notify("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");
}

risk_flagspawncount() {
  var_0 = randomfloatrange(0.4, 1);
  var_1 = randomfloatrange(0.3, 0.6);
  var_2 = randomfloatrange(0.3, 1);
  return (var_0, var_1, var_2);
}

guy_pushes_building(var_0, var_1) {
  var_2 = var_0;
  var_2 thread gun_create_fake(var_1.gulagloadoutindex);
  var_2 thread hack_console_activation_func(var_1.gulagloadoutindex, 3.5);

  if(!scripts\engine\utility::array_contains(var_1.gulagloadoutindex._id_12658, var_2)) {
    var_3 = var_2 getentitynumber();
    var_1.gulagloadoutindex._id_12658[var_3] = var_2;
  }
}

guy_pushes_terminal(var_0, var_1) {
  var_2 = var_0;
  var_2 gunship_origin_override(var_1.gulagloadoutindex);
}

gun_createrandomweapon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");

  if(!isDefined(self._id_12658))
    self._id_12658 = [];

  for(;;) {
    foreach(var_1 in self._id_12658) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = distance2d(self.origin, var_1.origin);

      if(var_2 >= level.gulagloadoutindex._id_129E0) {
        var_1 gunship_watchgameend(self);
        self._id_12658 = scripts\engine\utility::array_remove(self._id_12658, var_1);
      }
    }

    wait 1.0;
  }
}

hack_console_activation_func(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(var_0.sfx_infil_hackney_heli2_rope) {
    return;
  }
  if(isDefined(var_1))
    wait(var_1);

  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  self setclientomnvar("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 2);
  var_2 = int(var_0.impactfunc_stun);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 0, 9, var_2);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 1);
  setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", var_2);
}

gunship_watchgameend(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 0);
}

_id_13DBB() {
  while(!isDefined(level.player))
    waitframe();

  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 5.0;
  setomnvar("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 2);
  var_0 = gettime() + 60000;
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 0, 9, var_0);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 1);
  var_1 = 0;
  var_2 = gettime();
  var_3 = var_0;
  setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", var_0);
}

gun_create_fake(var_0) {
  while(!var_0.sfx_infil_hackney_heli2_rope)
    waitframe();

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_ADF612365B1963A79048BBA3306B6F6A956D3FEA");
  self endon("_encstr_ADF612365B1963A79048BBA3306B6F6A956D3FEA");
  self endon("_encstr_8873112B9BE8102FE270A2AAD946F7CF6063B4");
  var_0 endon("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");
  wait 0.1;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(gunship_watchintrodisown(var_0) && gun_course_forward()) {
      if(!istrue(self.start_coop_escape)) {
        self visionsetnakedforplayer("_encstr_A37013C62DE8F2AFB52D36365693AF96E6FAD90BDC", 0);
        self.start_coop_escape = 1;
        hack_airport_combat_init(1);
      }

      var_1 = level.gulagloadoutindex.is_cs_script_origin;

      if(level.gulagloadoutindex.is_current_solution_correct) {
        var_2 = (gettime() - var_0.onscavengerbagpickup) / 1000;

        if(var_2 <= level.gulagloadoutindex.is_cover_node)
          var_1 = level.gulagloadoutindex.is_cs_script_origin * level.gulagloadoutindex.is_cs_scriptable;
      }

      if(scripts\cp_mp\gasmask::hasgasmask(self)) {
        if(!_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::ks_circlecount(self))
          _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrepositoryref("_encstr_8F220C3BC1D17391C2B85469FBB2");

        scripts\cp_mp\gasmask::processdamage(var_1);
      } else {
        if(scripts\mp\utility\killstreak::isjuggernaut())
          var_1 = _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::_id_11C95(var_1);

        if(self.team == var_0.team)
          var_3 = self;
        else
          var_3 = var_0.owner;

        if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor())
          _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagearmor(var_1);
        else
          self dodamage(var_1, self.origin, var_3, undefined, undefined, "_encstr_AC8B0FC7C074F3495A781470F242179827", "_encstr_8B86073AF9350F8288");

        if(isPlayer(self)) {
          _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_id_13E18();

          if(self.team != var_0.team && self.br_armorhealth == 0 && self.health - level.gulagloadoutindex.is_cs_script_origin <= 0)
            var_0.vehomncontrols++;
        }
      }
    } else
      gunship_origin_override(var_0);

    wait 1.0;
  }
}

gunship_origin_override(var_0) {
  if(!gunship_watchownerexitaction()) {
    return;
  }
  self visionsetnakedforplayer("_encstr_B40101", 0);
  hack_airport_combat_init(0);
  self.start_coop_escape = 0;

  if(scripts\cp_mp\gasmask::hasgasmask(self))
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8F220C3BC1D17391C2B85469FBB2");

  if(!isalive(self))
    self notify("_encstr_8873112B9BE8102FE270A2AAD946F7CF6063B4");
}

gw_fobs_init() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A71216DF18DB21A9B7D3756DCD6D61C48020077F68D16472");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1.gulagwinnerrestoreloadout))
        var_1.gulagwinnerrestoreloadout = 0;

      if(istrue(var_1.start_coop_escape) || istrue(var_1.start_death_from_above_sequence))
        continue;
      else {
        var_2 = self._id_129DF + level.gulagloadoutindex._id_1215C;
        var_3 = distance2d(var_1.origin, self.origin) <= var_2;

        if(var_3 && !var_1.gulagwinnerrestoreloadout) {
          var_1 visionsetnakedforplayer("_encstr_81221548F72462F7F26401197F3BAFC89D6F483127C9FB", 0.5);
          continue;
        }

        if(var_1.gulagwinnerrestoreloadout) {
          var_1 visionsetnakedforplayer("_encstr_B40101", 0.2);
          var_1.gulagwinnerrestoreloadout = 0;
        }
      }
    }

    wait 1.0;
  }
}

gun_course_forward() {
  if(!isalive(self))
    return 0;

  if(istrue(self.start_death_from_above_sequence))
    return 0;

  if(istrue(self.gulag) && istrue(self.inrespawnc130))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 0;

  if(istrue(self._id_14439))
    return 0;

  if(istrue(self.unset_relic_thirdperson))
    return 0;

  if(istrue(self.gulag)) {
    if(istrue(self.gulagarena) || istrue(self.jailed))
      return 0;
  }

  return 1;
}

gwsiege_config() {
  var_0 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39"]);
  var_1 = (0, 0, 50);
  var_2 = 1;
  var_3 = level.gulagloadoutindex.start_coop_escape_end_camera + var_2;
  var_4 = self.origin + var_1;
  var_5 = self.origin - var_3;
  var_6 = [];

  if(isPlayer(self))
    var_6[0] = self;

  var_7 = physics_raycast(var_4, var_5, var_0, var_6, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_7[0])) {
    var_8 = var_7[0]["_encstr_BD260953AA97E3F014279D"];

    if(self.origin[2] - var_8[2] < level.gulagloadoutindex.start_coop_escape_end_camera)
      return 1;
  }

  return 0;
}

gunship_watchintrodisown(var_0) {
  var_1 = gwsiege_config();

  if(distance(self.origin, var_0.origin) < var_0._id_129DF && var_1)
    return 1;

  var_2 = distance2d(self.origin, var_0.origin) <= var_0._id_129DF;
  var_3 = var_0.initialwinningteam / 2;
  var_4 = abs(var_0.origin[2] - self.origin[2]) <= var_0.initialwinningteam / 2;

  if(var_2 && var_1)
    return 1;

  return 0;
}

_encstr_BEED1FFB4B38C00F132072EA8B607F3A70DF794ED908CDFBCF38BAB271CAAFB560(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  return var_2 gunship_watchintrodisown(var_1);
}

gunship_watchownerexitaction() {
  var_0 = 0;

  foreach(var_2 in level.gulagloadoutindex.instances) {
    if(!isDefined(var_2.trigger)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_2.trigger.triggerenterents, self)) {
      var_3 = gunship_watchintrodisown(var_2);

      if(!var_3)
        var_0++;
    }
  }

  return level.gulagloadoutindex.instances.size == var_0 || level.gulagloadoutindex.instances.size == 0;
}

_id_13DA5(var_0, var_1) {
  if(isPlayer(var_0) || isbot(var_0) || isagent(var_0))
    return 0;

  return 1;
}

_id_12485() {
  var_0 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_0, self.origin, self.angles, self);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_AAAD1EF8FB62F88809C747CBA1F84B237A6F46AA8E4A6BB8D3F1C3EBB983323A", var_1);
}

playernumlivesvo() {
  var_0 = level.gametype == "_encstr_B607038AAB";

  if(var_0)
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar("_encstr_8F220C3BC1D17391C2B85469FBB2", 0, 0);
  else {
    scripts\mp\killstreaks\killstreaks::clearkillstreaks();
    scripts\mp\killstreaks\killstreaks::awardkillstreak("_encstr_8F220C3BC1D17391C2B85469FBB2", "_encstr_8261067B1D34AC27");
  }
}

adjustactivespawnlogic() {}