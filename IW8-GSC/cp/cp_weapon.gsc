/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_weapon.gsc
***********************************************/

weaponsinit() {
  level.maxperplayerexplosives = max(scripts\cp\utility::getintproperty("_encstr_A6531BDF5BAAC999AFA317B92B43C1E080B5253BD89218D09FAAEBA1C3", 2), 4);
  level.riotshieldxpbullets = scripts\cp\utility::getintproperty("_encstr_9A6E18E33EC3F71A537B3359208B17F3B90B484A4D6863E74108", 15);
  level.build_weapon_name_func = ::_buildweaponcustom;
  level.has_weapon_variation = ::has_weapon_variation;
  level.get_weapon_level = ::get_weapon_level;
  level.can_upgrade = ::can_upgrade;
  level.weaponconfigs = [];
  level.pap = [];
  level.dropped_weapons = [];
  level.invalid_drop_weapons = [];
  level.wavessurvivedthroughweapon = 0;
  level.weaponobtained = 0;
  level.downswithweapon = 0;
  level.weaponkills = 0;
  level.weaponrootcache = [];
  level.dropped_weapon_func = ::drop_script_weapon_from_ai;
  level.fnbuildweapon = ::buildweapon;
  level.fnscriptedweaponassignment = ::getscriptedweapon;
  buildweaponmap();
  buildattachmentmaps();
  scripts\cp\cp_weapons::cp_weapons_init();
  initeffects();
  setupminesettings();
  setupconfigs();
  level.custom_proj_func = [];
  level thread custom_gl_proj_func_init();
  level thread onplayerconnect();
  iteminits();
  scripts\cp\cp_outline_utility::initoutlineoccluders();
  scripts\engine\utility::array_thread(getEntArray("_encstr_97710C6B2DCD1BAF3AD54E4E598E", "_encstr_AC110A7F14873B5B3D073009"), ::turret_monitoruse);
  thread scripts\cp\powers\coop_molotov::molotov_init();

  if(isDefined(level.custom_initializeweaponpickups))
    [[level.custom_initializeweaponpickups]]();
  else
    initializeweaponpickups();

  thread scripts\cp\cp_claymore::claymore_init();
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_init();
  thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  thread scripts\cp\cp_accessories::init();
  thread scripts\mp\trials\trial_jugg::decoy_init();
  level thread hackexclusionlist();
}

hackexclusionlist() {
  wait 10;
  var_0 = [getcompleteweaponname(level.sentrysettings["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].weaponinfo), getcompleteweaponname("_encstr_B29611E09732D6F763B5882D4F3AD118B75748"), getcompleteweaponname("_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6"), getcompleteweaponname("_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB"), getcompleteweaponname("_encstr_969E11D61673EA0B8DF58EAE39272B477DB61C"), getcompleteweaponname("_encstr_82A519087A32E9D8DF1F7DFF3BB340BFDE5259A8324B23B36F4507"), getcompleteweaponname("_encstr_B80E0DD3FF027E48DD5E7582AF27A8"), getcompleteweaponname("_encstr_88F90EF65F8E7A1AEED5251AE97F9788"), getcompleteweaponname("_encstr_88710EC26CC49918FA1A815BB5AFADC1"), getcompleteweaponname("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"), getcompleteweaponname("_encstr_826813691C902EB9B0A5507FFF574ABB61A2B1EBA3"), getcompleteweaponname("_encstr_B4E9147053F0F70EFB580FA689A0BB721C4F3B7918E1"), getcompleteweaponname("_encstr_9508192DEE707DB0239CB273851B2DDCCAF5B658C9DA9539D7B1C1"), getcompleteweaponname("_encstr_84E81558CF28E6D952A6C1D5FC290BE9CA07B018070B5B"), getcompleteweaponname("_encstr_925A0D5378D1F9A709266A69A89133"), getcompleteweaponname("_encstr_84E81558CF28E6D952A6C1D5FC290BE9CA07B018070B5B"), getcompleteweaponname("_encstr_865111D227E024F720718BB2FA21086791AD98"), getcompleteweaponname("_encstr_BD3D0E6DE6AFD995DCAC4EA5B1FAB6C1"), getcompleteweaponname("_encstr_8EF616E23BF8930708B7041D3FB0CE7798330A8A6350A73A"), getcompleteweaponname("_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1"), getcompleteweaponname("_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0"), getcompleteweaponname("_encstr_8C361472BBB7831B8D2A40C001E3CB5BBF5505E00DB3"), getcompleteweaponname("_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039"), getcompleteweaponname("_encstr_92DE17977AFB484F531F29931F9DDAD3D9374F9127C097511B"), getcompleteweaponname("_encstr_92A9117975A0C3607947CB3EB0171706D1E8AB"), getcompleteweaponname("_encstr_88B315C0779050074319F608A8597BB9FAD740C837552B"), getcompleteweaponname("_encstr_91C41BA8C32123D1BB7DBF217FFB9BA5D20AC8815AC655A84F82A8A948"), getcompleteweaponname("_encstr_8AF40D5B6EEBDA85396DB293F5B50E"), getcompleteweaponname("_encstr_A28F1523CA1CB1BDBCFA38858DBEB9B2E6D1E4BC7D6B0E"), getcompleteweaponname("_encstr_B65F184BDC3AB236EBE05D8ED75D6E13BEA5CDFA4758C46359A3"), getcompleteweaponname("_encstr_A7FB114B37E8958DEB6C58C61BD7C186B7E62B"), getcompleteweaponname("_encstr_BA6811A240D9779BCE25797BB51633FC07684A"), getcompleteweaponname("_encstr_9BDA102D73D156D8F533ED57DC91FABA374C"), getcompleteweaponname("_encstr_91D510B0F75059CB1D1F4D760ADDDB672D1F"), getcompleteweaponname("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83"), getcompleteweaponname("_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38"), getcompleteweaponname("_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2"), getcompleteweaponname("_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8"), getcompleteweaponname("_encstr_8F7F1323EA8B41BC6F3BD81EA0FD13607820678251"), getcompleteweaponname("_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B"), getcompleteweaponname("_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0"), getcompleteweaponname("_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A"), getcompleteweaponname("_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB"), getcompleteweaponname("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E"), getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE")];
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_combine(level.additional_laststand_weapon_exclusion, var_0);
}

blank(var_0) {}

initeffects() {
  level._effect["_encstr_A16C1257AD31DBC1D568921AA857471BE805C6FC"] = loadfx("_encstr_8D7D35200BE8684F72E2C5F83D5B0F28519B78902B9A79031A4AE85CD7B3A7718513D8F0E734F01D2136B1EBADBA5FD9F1DF588A13FE6A");
  level._effect["_encstr_B4C5113B8257F7315EAC6B6DC349B8B0EFBA72"] = loadfx("_encstr_8D7D35200BE8684F72E2C5F83D5B0F28519B78902B9A79031A4AE85CD7B3A7718513D8F0E734F01D2136B1EBADBA5FD9F1DF588A13FE6A");
  level._effect["_encstr_9B12096789A1B13BC3F8E3"] = loadfx("_encstr_A97F2678CDC07E4F02DE27A7C5CB90CFFA05A4534DE3329CE09C38C307D2F5EB78D7D67AFD233D39");
  level._effect["_encstr_9B4416277A6351B8ED4237B459FBE0D8143D31EDB648638F"] = loadfx("_encstr_8E372AFD761072B6BFDB5908321B5898ECC4416F0CFA788F8723182BAA53383005339FCB98A2F8C09FBAE810");
  level._effect["_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"] = loadfx("_encstr_A11831EC333C7936DB27ACE5AD075E6DB4C6B1CD1DE495B05BB9799DCCE1D79BD9F5C816D60BCECAF54CD8166CB56EADEDDACA");
  level._effect["_encstr_861E11938B2350E0A0598A7D97C053EF155417"] = loadfx("_encstr_BEFD3525AED8BA0E079301404A531020340C89A7448220474FFB5053E28BE0A84F96315DE1A16895B311119A6BF3A070E4FFBD6D765758");
  level.kinetic_pulse_fx["_encstr_AD8A06BB8B582ADB"] = loadfx("_encstr_AF5B2DB333E1792DBBB9F2BE4EB2B8BA56DC8ECDCBB50EE59D99C3F5DA96E6B23A2D6CFA38AEC66E56D7B934DB36DA");
  level._effect["_encstr_A35718B469C7E6DF8A4A50207267F73BD71FCA3DFF270813B593"] = loadfx("_encstr_B26427D07CBA4670EBEB5D9FBB7ADAB5EB3BBDF6506018FA13E2380F36D02F78C5A98773A285B0F8A3");
  level._effect["_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"] = loadfx("_encstr_A11831EC333C7936DB27ACE5AD075E6DB4C6B1CD1DE495B05BB9799DCCE1D79BD9F5C816D60BCECAF54CD8166CB56EADEDDACA");
  level._effect["_encstr_8B4615CB407F5F8FF1039D99196857A31DFD52C2E8C51B"] = loadfx("_encstr_8843337DF690F2335F0F908643CFF7E86F5BF1EFD7BD502873F2728E3AA720D042A9673F0562B043137A299073776D709A76C535B0");
  level._effect["_encstr_BD401E0ECA3759D1E42C8EA5B773AFC9C2A51BB3BAB9F556E1E063F6374B7BB9"] = loadfx("_encstr_B4153A20F288C7B07F9F3806AF0379BFB77B8878DEE39B49BBBF168BB93BE1E39AE2F8A3367BC5222F1DA3FF9C6729A1C6EBC02B6B941F7B9216A4F3");
  level._effect["_encstr_84AC1383783153A2971E6EA5F4EF0A107BE02F3398"] = loadfx("_encstr_8BA832769CF8B62DB36F9065332F5F787D27020960EE292EA64419173AA6405011D656425071373539AB1CC1351FE5EFAA959AE8");
  level._effect["_encstr_AA7608ECD89B6BDE5B59"] = loadfx("_encstr_995B39B33387F2D2DD70D76BC1BCAC2ED5A5E0DA599B8E97B9B6F6B559AF7639B2E658C8B279B399F0D76ED6BDAD56D7CE39B29BFA36A117EC993C");
  level._effect["_encstr_B26817A0E1F0F7D97670535399811BD160E03116F718731658"] = loadfx("_encstr_B21932ECCC1EE5B4DD83F55B83CB56C55DB4075BCADCE8BC67331ED7C3AD2DDA5662C0E4FAA3A12B4EB5B4E82BEB98B7BA73B12B");
  level._effect["_encstr_A64E0FFB592DB01BAF375BFE5AE3CF8805"] = loadfx("_encstr_8EEE332DA6A0C2036F2F4E309336CDF83B31A9E34D8DA07803A2A27E6AE771A81491B3D5CF72D890AB8AD903F28BBD19EFF0B9F197");
}

setupminesettings() {
  var_0 = 70;
  level.claymoredetectiondot = cos(var_0);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.75;
  level.claymoredetonateradius = 192;
  level.minedetectiongraceperiod = 0.3;
  level.minedetectionradius = 150;
  level.minedetectionheight = 20;
  level.minedamageradius = 256;
  level.minedamagemin = 600;
  level.minedamagemax = 1200;
  level.minedamagehalfheight = 300;
  level.mineselfdestructtime = 600;
  level.mine_launch = loadfx("_encstr_B1A22CB3330FF2B1BD9C595E4B6B38858D3A37CB26DBBAE68D2D73D9EB1359E8A3CBBE1B85579BC6A1BE23B427D1");
  level.mine_explode = loadfx("_encstr_AFDE2BEC33C3E5C6DE9CCA7956C3C1C6CB4CDB5DB9C62DCD9DFA31CAD13AE5D7953C1C1BBD9B4BDBCDB8673387");
  level.delayminetime = 1.5;
  level.c4explodethisframe = 0;
  level.mines = [];
}

setupconfigs() {
  var_0 = spawnStruct();
  var_0.mine_beacon["_encstr_88BF06FD784A6393"] = loadfx("_encstr_BEA72680AB48C8EFD282A5985FEB1BC8A87F90D84BA7F8B33A2C25A8369707D1ECC73078BA967169");
  var_0.mine_beacon["_encstr_ACFC091AE8AB2FCBE15119"] = loadfx("_encstr_B45B2316ADA0ADDFDB1B4A768D233FB41877B5812520C9BB7170923A4E8C13AC38ED341C63");
  level.weaponconfigs["_encstr_9AAE0876FCB7603101DB"] = var_0;
  var_0 = spawnStruct();
  var_0.armingdelay = 1.5;
  var_0.detectionradius = 232;
  var_0.detectionheight = 512;
  var_0.detectiongraceperiod = 1;
  var_0.headiconoffset = 20;
  var_0.killcamoffset = 12;
  level.weaponconfigs["_encstr_96D117C193B71E4BB5A547BCF5CA1E83C6BD37A59D56FA5B38"] = var_0;
  var_0 = spawnStruct();
  var_1 = 800;
  var_2 = 200;
  var_0.radius_max_sq = var_1 * var_1;
  var_0.radius_min_sq = var_2 * var_2;
  var_0.onexplodesfx = "_encstr_A3B8194750D0AB5260070B2F6D17DAF579D9784AC8C9542B473D07";
  var_0.vfxradius = 72;
  level.weaponconfigs["_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683"] = var_0;
}

iteminits() {
  clustergrenadeinit();
  throwingknifec4init();
}

throwingknifec4init() {
  level._effect["_encstr_8BC01814B1F0BDB7DBB80A3240233BF7A0A1878D0988058F75F1"] = loadfx("_encstr_A30A31D35BA0705C902F88F86A3AAF137FDF839EBE314BBD537733CB5BBF08B0D3E72AC050A7EBE338EAA96EA9F10A1D4E565B");
}

clustergrenadeinit() {
  level._effect["_encstr_97C21736E45FE379CFBB9938E2250B5977AF4D335083A89137"] = loadfx("_encstr_8FD638EBD85BF7A063569F8698E1217D756310E2A54B587A854FABF79A50BB56C3DFB0A849CAF7203F9F2345AA424289DB50E8881073F67C1C33");
}

getweapongunsmithattachmenttable(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  var_2 = scripts\cp\utility::getweaponrootname(var_1);
  return "_encstr_A6180D78E2C8B8C335E317A3B3AB3E" + getsubstr(var_2, 4) + "_encstr_8B0911EB858EE80B6CA16B2BE6479B71B137D9";
}

getcompletenameforweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;
  var_8 = strtok(var_7, "_encstr_BA4C02DF");
  var_9 = 0;

  if(var_8[0] == "_encstr_B419040BB1A3")
    var_9++;

  if(var_8[var_9] == "_encstr_921904C3C7E2")
    return;
  else if(var_8[var_9] == "_encstr_B21904D2EE0E") {
    var_10 = var_0;

    if(!isDefined(var_1))
      var_11 = ["_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"];
    else
      var_11 = var_1;

    if(!isDefined(var_2))
      var_12 = "_encstr_8BBA05185F8B99";
    else
      var_12 = var_2;

    if(!isDefined(var_3))
      var_13 = "_encstr_8BBA05185F8B99";
    else
      var_13 = var_3;

    if(!isDefined(var_4))
      var_14 = -1;
    else
      var_14 = var_4;

    if(!isDefined(var_5))
      var_15 = 0;
    else
      var_15 = var_5;

    if(!isDefined(var_6))
      var_16 = "_encstr_8BBA05185F8B99";
    else
      var_16 = var_6;

    return createheadicon(buildweapon(var_10, var_11, var_12, var_13, var_14, 1, 1, var_15, var_16));
  }
}

turret_monitoruse() {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    thread turret_playerthread(var_0);
  }
}

turret_playerthread(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", isundefinedweapon());
  self waittill("_encstr_AC37121DAEE4C95647F5235958C6A35A3B0BA395");
  var_0 notify("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0 getcurrentweapon());
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.hits = 0;
    var_0 thread onplayerspawned();
    var_0 thread watchmissileusage();
    var_0 thread sniperdustwatcher();
    var_0 thread watchjavelinusage();
    var_0 thread updatelastweapon();
    var_0 thread watchchangeweapon();
    var_0 thread scripts\cp\equipment\cp_stinger::watchlauncherusage();
  }
}

watchjavelinusage() {
  scripts\cp\equipment\cp_javelin::javelinusageloop();
}

watchchangeweapon() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0)) {
      dochangeweapon(var_0);

      if(scripts\cp\utility::turn_off_sniper_laser()) {
        for(var_1 = 0; var_1 < self.primaryweapons.size; var_1++) {
          var_2 = self.primaryweapons[var_1].basename;
          var_3 = scripts\cp\utility::strip_suffix(var_2, "_encstr_851A049F8337");

          if(var_1 < 2)
            self setplayerdata("_encstr_850703B7D9", "_encstr_AB1413BB2C67594DBAE4ECB4D91636ABB22C07DBDC", var_1, var_3);
        }
      }
    }

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }
}

dochangeweapon(var_0) {
  updateweaponspeed(var_0);
  updatelastweaponobj(var_0);
  updatelauncherusage();
  _id_13FD2(var_0);
  _id_12F87(var_0);
  updateweaponperks();
  updatedefaultflinchreduction();
  scripts\mp\mp_agent_damage::updateweaponchangetime();
  riotshieldonweaponchange(var_0);

  if(isDefined(self.suit) && self.suit == "_encstr_AB6C0C1784D2171608824D4727A0")
    thread scripts\cp_mp\gestures::_id_13E1A();
}

_id_12F87(var_0) {
  if(istrue(level.loadout_updateammo)) {
    return;
  }
  if(_id_132F2(var_0)) {
    scripts\common\utility::allow_mount_top(0, "_encstr_9AC7158F6126F16B43F889EC57239ED59D404E1E3EE9BF");
    scripts\common\utility::allow_mount_side(0, "_encstr_9AC7158F6126F16B43F889EC57239ED59D404E1E3EE9BF");
    thread _id_12F88();
  }
}

_id_12F88() {
  scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  scripts\common\utility::allow_mount_top(1, "_encstr_9AC7158F6126F16B43F889EC57239ED59D404E1E3EE9BF");
  scripts\common\utility::allow_mount_side(1, "_encstr_9AC7158F6126F16B43F889EC57239ED59D404E1E3EE9BF");
}

_id_132F2(var_0) {
  var_1 = scripts\cp\utility::getweaponrootname(var_0);

  if(var_1 == "_encstr_9B750F97DF33D94448F6CA54A96882F2EB" && var_0 hasattachment("_encstr_8BB111E63ADB1BD6E685DDEBE6A595279316C3"))
    return 1;

  return 0;
}

_id_13FD2(var_0) {
  self notify("_encstr_95350FCADC197D19932CEC1239CAB03A0D");

  if(getweapongroup(var_0) == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9") {
    if(unlockables(var_0))
      thread terminal_pusher_approach_array(var_0);
  }
}

terminal_pusher_approach_array(var_0) {
  var_0.unlockableindex = 1;
  thread _id_138DA(var_0);
}

_id_138DA(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A5("_encstr_95350FCADC197D19932CEC1239CAB03A0D", "_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    var_0.unlockableindex = undefined;
}

unlockables(var_0) {
  var_1 = getweaponammopoolname(var_0);
  return var_1 == "_encstr_86AB0F5D54A082E9275E059A6AE9AF8821";
}

updateweaponspeed(var_0) {
  if(var_0.basename == "_encstr_8BBA05185F8B99")
    return;
  else if(scripts\cp\utility::issuperweapon(var_0.basename)) {
    scripts\cp\cp_loadout::updatemovespeedscale();
    return;
  } else if(scripts\cp\utility::iskillstreakweapon(var_0.basename))
    return;
  else if(var_0.basename == "_encstr_A393109FCF38E936DA97CCE3177050314CB8") {
    scripts\cp\cp_loadout::updatemovespeedscale();
    return;
  } else if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0" && var_0.inventorytype != "_encstr_B4DC085639F9C2779108") {
    return;
  }
  scripts\cp\cp_loadout::updatemovespeedscale();
}

updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }
  var_0 = undefined;
  var_1 = _id_14584(self.currentweapon);

  if(var_1 == 4)
    var_0 = 0.85;
  else if(var_1 == 3)
    var_0 = 0.2;
  else if(var_1 == 2)
    var_0 = 0.08;
  else if(var_1 == 1)
    var_0 = 0.25;
  else
    var_0 = 0.05;

  updateviewkickscale(var_0);
}

updateviewkickscale(var_0) {
  if(isDefined(var_0))
    self.viewkickscale = var_0;

  if(isDefined(self.overchargeviewkickscale))
    var_0 = self.overchargeviewkickscale;
  else if(isDefined(self.overrideviewkickscale)) {
    var_0 = self.overrideviewkickscale;
    var_1 = _id_14584(self getcurrentweapon());

    if(var_1 == 1)
      var_0 = self.overrideviewkickscalepistol;
    else if(var_1 == 3)
      var_0 = self._id_1218D;
    else if(var_1 == 2)
      var_0 = self._id_1218E;
    else if(var_1 == 4)
      var_0 = self.overrideviewkickscalesniper;
  } else if(isDefined(self.viewkickscale))
    var_0 = self.viewkickscale;
  else
    var_0 = 1.0;

  var_0 = clamp(var_0, 0.0, 1.0);
  self setviewkickscale(var_0);
}

_id_14584(var_0) {
  var_1 = "_encstr_8BBA05185F8B99";
  var_2 = -1;

  if(isDefined(var_0) && !nullweapon(var_0)) {
    var_1 = weaponclass(var_0);

    switch (var_1) {
      case "_encstr_8D940738966ED1DB8D":
        var_2 = 1;
        break;
      case "_encstr_850707F7E5833355B8":
        if(getweapongroup(var_0) == "_encstr_A1710B57AD31DBCDCDF1422A60") {
          if(var_0.basename == "_encstr_8D06112DDDE0EB6EE6BEB5B463BD271CFAD61C")
            var_2 = 2;
          else
            var_2 = 3;
        } else
          var_2 = 4;

        break;
      default:
        var_2 = 0;
    }
  }

  return var_2;
}

updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

doweaponperkupdate(var_0) {
  var_1 = self getcurrentweapon();
  weaponattachmentperkupdate(var_1, var_0);
  weaponperkupdate(var_1, var_0);
  return var_1;
}

weaponperkupdate(var_0, var_1) {
  if(!getqueuedspleveltransients(var_1)) {
    var_2 = scripts\cp\utility::getweaponrootname(var_1.basename);
    var_3 = weaponperkmap(var_2);

    if(isDefined(var_3))
      scripts\cp\perks\cp_perks::removeperk(var_3);
  }

  if(!getqueuedspleveltransients(var_0)) {
    var_4 = scripts\cp\utility::getweaponrootname(var_0.basename);
    var_5 = weaponperkmap(var_4);

    if(isDefined(var_5))
      scripts\cp\utility::giveperk(var_5);
  }
}

weaponperkmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].perk))
    return level.weaponmapdata[var_0].perk;

  return undefined;
}

weaponattachmentperkupdate(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(!getqueuedspleveltransients(var_1)) {
    var_3 = getweaponattachments(var_1);

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_5 in var_3) {
        var_6 = attachmentperkmap(var_5);

        if(!isDefined(var_6)) {
          continue;
        }
        scripts\cp\perks\cp_perks::removeperk(var_6);
      }
    }
  }

  if(!getqueuedspleveltransients(var_0)) {
    var_2 = getweaponattachments(var_0);

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_9 in var_2) {
        var_6 = attachmentperkmap(var_9);

        if(!isDefined(var_6)) {
          continue;
        }
        scripts\cp\utility::giveperk(var_6);
      }
    }
  }
}

attachmentperkmap(var_0) {
  if(isDefined(level.attachmentmap_attachtoperk[var_0]))
    return level.attachmentmap_attachtoperk[var_0];

  return undefined;
}

updatelastweaponobj(var_0) {
  self.lastweaponobj = var_0;

  if(isnormallastweapon(var_0))
    self.lastnormalweaponobj = var_0;

  if(isdroppableweapon(var_0))
    self.lastdroppableweaponobj = var_0;

  if(iscacprimaryorsecondary(var_0))
    self.lastcacweaponobj = var_0;
}

_id_13C57() {
  for(;;) {
    self waittill("_encstr_B89B11B393CACDC2C859AF8357638D13B08DD6", var_0);

    if(!nullweapon(var_0) && var_0.basename == "_encstr_9AAE0876FCB7603101DB" && scripts\cp\utility::isriotshield(self getcurrentweapon()))
      self._id_1207E = 1;
  }
}

_id_13C5D() {
  if(!istrue(self._id_1207E)) {
    var_0 = self getheldoffhand();

    if(!nullweapon(var_0) && var_0.basename != "_encstr_9AAE0876FCB7603101DB" && scripts\cp\utility::isriotshield(self getcurrentweapon()) && scripts\cp\utility::valuehud(var_0))
      self._id_1207E = 1;
  }
}

_id_13C58(var_0) {
  self notify("_encstr_9560241D392C6CAD252DF6A3A934D256D832BED6DB9BA51DB727D4865A56D8230AD1E8C21B1A");
  self endon("_encstr_9560241D392C6CAD252DF6A3A934D256D832BED6DB9BA51DB727D4865A56D8230AD1E8C21B1A");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_972412923398FB27DBD8AAC281B8B377988B3B68");
  childthread _id_13C57();

  if(isDefined(var_0))
    self._id_1443A = var_0;
  else if(!isDefined(self._id_1443A))
    self._id_1443A = 0;

  while(scripts\cp\utility::riotshield_hasweapon()) {
    _id_13C5D();
    var_1 = scripts\cp\cp_laststand::player_in_laststand(self);

    if(!var_1) {
      if(istrue(self._id_1443A)) {
        self.watch_for_heli_bosses_dead = 1;
        self.watch_for_heli_death = gettime() + 1300;
      } else if(isDefined(self.watch_for_heli_death) && gettime() >= self.watch_for_heli_death) {
        self.watch_for_heli_bosses_dead = undefined;
        self.watch_for_heli_death = undefined;
      }

      self._id_1443A = 0;
    } else {
      self.watch_for_heli_bosses_dead = undefined;
      self.watch_for_heli_death = undefined;
      self._id_1443A = 1;
    }

    if(self isonladder())
      _id_13C5A();
    else if(self isinexecutionattack())
      _id_13C5A();
    else if(self isinexecutionvictim())
      _id_13C5B();
    else if(self isparachuting() || self isskydiving())
      _id_13C5A();
    else if(istrue(self.watch_for_heli_bosses_dead))
      _id_13C5A();
    else if(istrue(self._id_1207E)) {
      if(nullweapon(self getheldoffhand())) {
        self._id_1207E = undefined;
        _id_13C5C();
      } else
        _id_13C5A();
    } else
      _id_13C5C();

    waitframe();
  }

  _id_13C5C();
}

_id_13C5A() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(!var_1) {
    if(var_0)
      scripts\cp\utility::riotshield_move(1);
    else
      scripts\cp\utility::riotshield_attach(0, riotshield_getmodel());
  }
}

_id_13C59() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(!var_0) {
    if(var_1)
      scripts\cp\utility::riotshield_move(0);
    else
      scripts\cp\utility::riotshield_attach(1, riotshield_getmodel());
  }
}

_id_13C5B() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(var_0)
    scripts\cp\utility::riotshield_detach(1);

  if(var_1)
    scripts\cp\utility::riotshield_detach(0);
}

_id_13C5C() {
  if(scripts\cp\utility::riotshield_hasweapon()) {
    var_0 = scripts\cp\utility::isriotshield(self getcurrentweapon());

    if(var_0) {
      _id_13C59();
      return;
    }

    _id_13C5A();
    return;
  } else {
    var_1 = isDefined(self.riotshieldmodel);
    var_2 = isDefined(self.riotshieldmodelstowed);

    if(var_1)
      scripts\cp\utility::riotshield_detach(1);

    if(var_2)
      scripts\cp\utility::riotshield_detach(0);
  }
}

riotshieldonweaponchange(var_0) {
  if(scripts\cp\utility::riotshield_hasweapon())
    thread _id_13C58();
  else {
    _id_13C5C();
    _id_12D4E();
    self notify("_encstr_972412923398FB27DBD8AAC281B8B377988B3B68");
  }
}

_id_12D4E(var_0) {
  self.watch_for_heli_bosses_dead = undefined;
  self.watch_for_heli_death = undefined;
  self._id_1443A = undefined;

  if(istrue(var_0)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
  }
}

get_enemies_in_range(var_0, var_1, var_2, var_3) {
  var_4 = cos(var_3);
  var_5 = var_1 * var_1;
  var_6 = [];

  foreach(var_8 in level.spawned_enemies) {
    if(distancesquared(var_0, var_8.origin) < var_5) {
      if(scripts\engine\utility::within_fov(var_0, var_2.angles, var_8.origin, var_4))
        var_6[var_6.size] = var_8;
    }
  }

  return var_6;
}

sniperdustwatcher() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");

    if(self getstance() != "_encstr_922406F1A6FD5E05") {
      continue;
    }
    var_1 = self getcurrentweapon();

    if(var_1.classname != "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33") {
      continue;
    }
    var_2 = anglesToForward(self.angles);

    if(!isDefined(var_0) || gettime() - var_0 > 2000) {
      var_0 = gettime();
      continue;
    }
  }
}

unset_scriptable_part_state_after_time(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  self setscriptablepartstate("_encstr_96390B3F9BB7FCA569EBAB6AD5", "_encstr_8882099673858D1D4B6756");
  var_1 notify("_encstr_81241B82D3A8472A14A9AA8ACDF950F0676AB49B1E37123D2769387DA0");

  if(isDefined(self))
    self delete();
}

watchmissileusage() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread listen_for_custom_proj_dvar();

  for(;;) {
    var_0 = waittill_missile_fire();
    var_1 = undefined;

    switch (var_0.weapon_name) {
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
        var_1 = self.missilelaunchertarget;
        break;
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
        var_1 = self.javelin.target;
        break;
      case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
        var_0 thread launch_custom_gl_projectile(var_0.owner);
        break;
      case "_encstr_B6CE1C27B2ADF6A395DA5AE6B95AB156AF83C9ED352B1B1D2DC62BBEB5C1":
        var_0 thread grenade_earthquake();
        break;
      case "_encstr_AA7608ECD89B6BDE5B59":
        var_0 thread smokegrenadeused(1);
        break;
      case "_encstr_ADBD0780C4884FEE86":
        var_0 thread watchconcussiongrenadeexplode();
        break;
      case "_encstr_873708FFA8104C0AAEC1":
        break;
      case "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5":
        thread scripts\cp\equipment\cp_thermite::thermite_used(var_0, 1);
        break;
      case "_encstr_8435070CAC0F080BD2":
        thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(var_0, 1);
        break;
      default:
        break;
    }

    if(scripts\cp_mp\utility\weapon_utility::islockonlauncher(var_0.weapon_name) && isDefined(var_1)) {
      var_0._id_119A0 = var_1;
      level notify("_encstr_A1B90EC33B80328870DB219DE446B39B", self, var_0, var_1);
      thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(var_1, var_0);
    }

    if(isPlayer(self) && isDefined(var_0))
      var_0.adsfire = scripts\cp\utility::isplayerads();
  }
}

issmallmissile(var_0) {
  return 0;
}

isexplosivemissile(var_0) {
  var_1 = getweaponbasename(var_0);

  switch (var_1) {
    case "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7":
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      return 0;
  }

  return 1;
}

listen_for_custom_proj_dvar() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 = getDvar("_encstr_822B0CB673DBFED705D1A8A0CADC", "_encstr_8BBA05185F8B99");

    if(var_0 != "_encstr_8BBA05185F8B99")
      self.gl_proj_override = var_0;

    wait 0.1;
  }
}

launch_custom_gl_projectile(var_0) {
  var_1 = get_custom_gl_projectile(var_0);

  if(isDefined(var_1)) {
    self delete();

    if(isDefined(level.custom_proj_func[var_1]))
      level thread[[level.custom_proj_func[var_1]]](var_0);
  }
}

get_custom_gl_projectile(var_0) {
  if(isDefined(var_0.gl_proj_override))
    return var_0.gl_proj_override;

  return undefined;
}

custom_gl_proj_func_init() {
  level.custom_proj_func["_encstr_864F0BA20F102BE378C3C8020A"] = ::launchconcertinabomb;
  level.custom_proj_func["_encstr_8D7609A4F337C2C9C2BDB7"] = ::launchthermite;
  level.custom_proj_func["_encstr_8DCB085BEF657B4DCF0B"] = ::launchmolotov;
  level.custom_proj_func["_encstr_9301076F8808DCFA41"] = ::launchstickytimedgrenade;
  level.custom_proj_func["_encstr_8B07036CD0"] = ::launchc4grenade;
}

create_new_projectile(var_0, var_1) {
  var_2 = anglesToForward(var_1 getplayerangles());
  var_2 = var_2 * 2000;

  if(var_1 tagexists("_encstr_A14F0AE336178944BA076F41"))
    var_3 = var_1 gettagorigin("_encstr_A14F0AE336178944BA076F41");
  else
    var_3 = var_1 getEye();

  var_4 = var_1 launchgrenade(var_0, var_3, var_2);
  var_4.owner = var_1;
  return var_4;
}

launchthermite(var_0) {
  var_1 = create_new_projectile("_encstr_AC5911C3C04BE2CF58550D3F6F03FFAC971B0B", var_0);
  var_0 thread scripts\cp\equipment\cp_thermite::thermite_used(var_1);
}

launchmolotov(var_0) {
  var_1 = create_new_projectile("_encstr_BA730BF8AFF178988293F158B9", var_0);
  var_0 thread scripts\cp\powers\coop_molotov::molotov_used(var_1);
  self delete();
}

launchstickytimedgrenade(var_0) {
  var_1 = create_new_projectile("_encstr_92A70ABB8267F5E0D89F6351", var_0);
  var_0 thread semtexused(var_1);
  self delete();
}

launchc4grenade(var_0) {
  var_1 = create_new_projectile("_encstr_9AAE0876FCB7603101DB", var_0);
  var_0 thread scripts\cp\cp_c4::c4_used(var_1);
  self delete();
}

launchexplosivetiplogic(var_0) {
  self waittill("_encstr_860808CB78E2984063BA", var_1, var_2, var_3, var_4);
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_5 setModel("_encstr_AF3B1C2F6B92C3F06E1FE6FB457708061AE3ABB11F699580BD72A8302B35");
  var_5 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_878807108A42A309BB", 0);
  var_5.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_5.origin, 0, 125, 72);
  var_5.trigger thread watch_for_thermite_triggered(var_0);
  wait 0.5;
  var_6 = 1;

  while(var_6 <= 10) {
    var_7 = var_6 + 1;
    var_6 = var_7;
    wait 0.5;
  }

  var_5 thread bolt_destroy();
}

wait_for_crate_drop_to_ground(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0.origin + (0, 0, -100), 0, -5000);
  var_2 = 900;
  var_3 = 1000;
  var_4 = 0;

  for(;;) {
    if(distancesquared(var_0.origin, var_1) <= var_2)
      return var_1;

    if(var_4 >= var_3)
      return var_1;

    var_4 = var_4 + 50;
    waitframe();
  }
}

watch_for_thermite_triggered(var_0) {
  self endon("_encstr_868715957319AFA30D954E6BB41DB2F5A39C5ACED9CA39");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isPlayer(var_1)) {
      continue;
    }
    if(!var_1 scripts\cp\utility::is_soldier_agent()) {
      continue;
    }
    if(isalive(var_1) && !istrue(var_1.marked_for_death)) {
      var_1.marked_for_death = 1;
      thread watch_for_victim_death(var_1);
      var_1 thread scripts\cp\utility::damage_over_time(var_1, var_0, 2.5, 100, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    }
  }
}

watch_for_victim_death(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  var_0.marked_for_death = undefined;
  playFX(level._effect["_encstr_BE4D113BCCC3FAD1432B93D64B1D95BEB2378C"], var_0.origin);
  self delete();
}

bolt_destroy() {
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_92B1082E2D4B458DC014", 0);
  self notify("_encstr_868715957319AFA30D954E6BB41DB2F5A39C5ACED9CA39");

  if(isDefined(self.trigger))
    self.trigger delete();

  self delete();
}

waitfortriggernotify(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isPlayer(var_1)) {
      continue;
    }
    if(!var_1 scripts\cp\utility::is_soldier_agent()) {
      continue;
    }
    if(isalive(var_1) && !istrue(var_1.marked_for_death)) {
      var_1.marked_for_death = 1;
      var_1 thread scripts\cp\utility::damage_over_time(var_1, var_0, 5, 100, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    }
  }
}

launchconcertinabomb(var_0) {
  self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1, var_2);
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, 500, 72);
  var_3 thread waitfortriggernotify(var_0);
  wait 6;
  var_3 delete();
}

removelinkafterdelay(var_0, var_1) {
  wait(var_1);

  if(scripts\engine\utility::array_contains(level.strrazorlinks, var_0))
    level.strrazorlinks = scripts\engine\utility::array_remove(level.strrazorlinks, var_0);
}

lockonlaunchers_gettargetarray(var_0) {
  var_1 = [];
  var_2 = 0;
  var_3 = lockonlaunchers_gettargetvehiclerefs();

  if(level.teambased) {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if(isDefined(var_5) && isalive(var_5) && (var_5.team != self.team || var_2))
          var_1[var_1.size] = var_5;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_8 in level.activekillstreaks) {
        if(isDefined(var_8.affectedbylockon) && (var_8.team != self.team || var_2))
          var_1[var_1.size] = var_8;
      }
    }

    if(isDefined(level.special_lockon_target_list)) {
      foreach(var_11 in level.special_lockon_target_list)
      var_1[var_1.size] = var_11;
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var_14 in level.cratedropdata.ac130s) {
          if(var_14.team != self.team || var_2)
            var_1[var_1.size] = var_14;
        }
      }
    }

    foreach(var_17 in var_3) {
      var_18 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_17);

      foreach(var_20 in var_18) {
        if(!scripts\cp_mp\vehicles\vehicle::_id_141B9(var_20, self) || var_2)
          var_1[var_1.size] = var_20;
      }
    }
  } else {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if((!isDefined(var_5) || !isalive(var_5)) && !var_2) {
          continue;
        }
        var_1[var_1.size] = var_5;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_8 in level.activekillstreaks) {
        if(isDefined(var_8.affectedbylockon) && (isDefined(var_8.owner) && var_8.owner != self || var_2))
          var_1[var_1.size] = var_8;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var_14 in level.cratedropdata.ac130s) {
          if(var_14.owner != self || var_2)
            var_1[var_1.size] = var_14;
        }
      }
    }

    foreach(var_17 in var_3) {
      var_18 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_17);

      foreach(var_20 in var_18) {
        if(!isDefined(var_20.owner)) {
          var_1[var_1.size] = var_20;
          continue;
        }

        if(var_20.owner != self || var_2)
          var_1[var_1.size] = var_20;
      }
    }
  }

  foreach(var_34 in var_1) {
    if(!isvector(var_34.origin))
      var_1 = scripts\engine\utility::array_remove(var_1, var_34);
  }

  return var_1;
}

lockonlaunchers_gettargetvehiclerefs() {
  return ["_encstr_86510C82737817CD40B38B720A15", "_encstr_8C190467402B", "_encstr_8AD40926E431B1C07B0EB3", "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_8FE608B268BFF756987D", "_encstr_91CD07D045CF0B0BB8", "_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_85DE05A6B2AC0E", "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_AF390B295782C3585F1B21D8C4", "_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_911904464232"];
}

add_to_special_lockon_target_list(var_0) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  if(!scripts\engine\utility::array_contains(level.special_lockon_target_list, var_0))
    level.special_lockon_target_list = scripts\engine\utility::array_add(level.special_lockon_target_list, var_0);
}

remove_from_special_lockon_target_list(var_0) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  if(scripts\engine\utility::array_contains(level.special_lockon_target_list, var_0))
    level.special_lockon_target_list = scripts\engine\utility::array_remove(level.special_lockon_target_list, var_0);
}

getrandomdirection(var_0, var_1) {
  var_2 = anglestoup(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglesToForward(var_1);
  var_5 = randomint(360);
  var_6 = randomint(360);
  var_7 = cos(var_6) * sin(var_5);
  var_8 = sin(var_6) * sin(var_5);
  var_9 = cos(var_5);
  var_10 = (var_7 * var_3 + var_8 * var_4 + var_9 * var_2) / 0.33;
  return -1 * var_10;
}

waittill_missile_fire() {
  self waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0, var_1);

  if(isDefined(var_0)) {
    if(!isDefined(var_0.weapon_name)) {
      if(var_1.isalternate) {
        var_2 = scripts\cp\utility::attachmentmap_tobase(var_1.underbarrel);

        switch (var_2) {
          case "_encstr_ADBD0780C4884FEE86":
            var_0.weapon_name = "_encstr_ADBD0780C4884FEE86";
            break;
          case "_encstr_873708FFA8104C0AAEC1":
            var_0.weapon_name = "_encstr_873708FFA8104C0AAEC1";
            break;
          case "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5":
            var_0.weapon_name = "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5";
            break;
          case "_encstr_8435070CAC0F080BD2":
            var_0.weapon_name = "_encstr_8435070CAC0F080BD2";
            break;
          case "_encstr_AA7608ECD89B6BDE5B59":
            var_0.weapon_name = "_encstr_AA7608ECD89B6BDE5B59";
            break;
          case "_encstr_8A07035972":
          default:
            var_0.weapon_name = "_encstr_8A07035972";
            break;
        }
      } else
        var_0.weapon_name = var_1.basename;
    }

    if(!isDefined(var_0.owner))
      var_0.owner = self;

    if(!isDefined(var_0.team))
      var_0.team = self.team;
  }

  return var_0;
}

onplayerspawned() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    self.currentweaponatspawn = self getcurrentweapon();
    self.empendtime = 0;
    self.concussionendtime = 0;
    self.hits = 0;

    if(!isDefined(self.trackingweapon)) {
      self.trackingweapon = isundefinedweapon();
      self.trackingweaponshots = 0;
      self.trackingweaponkills = 0;
      self.trackingweaponhits = 0;
      self.trackingweaponheadshots = 0;
      self.trackingweapondeaths = 0;
    }

    _id_12D4E(1);
    thread watchgrenadeusage();
    thread scripts\mp\trials\trial_gun_course::x1ops3();
    thread stancerecoiladjuster();
    thread initlauncherlogic();
    self.lasthittime = [];
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    thread watchforweaponchange();
    thread watchforweapondropped();
    thread monitorlauncherspawnedgrenades();
    self.currentweaponatspawn = undefined;
    self.trophyremainingammo = undefined;
  }
}

initlauncherlogic() {
  var_0 = self getcurrentweapon();

  switch (var_0.basename) {
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      thread scripts\cp\agents\gametype_cp_specops::missilelauncherusageloop();
      break;
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
  }
}

updatelauncherusage() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\cp\utility::getweaponrootname(var_0.basename);

  switch (var_1) {
    default:
      break;
    case "_encstr_A5090EB4DD83D78D16BE3B4EED5BACB7":
      thread scripts\cp\agents\gametype_cp_specops::initmissilelauncherusage();
      break;
    case "_encstr_97EF0EA5BB70FA1BB0AFD4D56396593A":
      thread scripts\cp\equipment\cp_javelin::javelin_reset();
      break;
    case "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD":
      thread scripts\cp\vehicles\vehicle_damage_cp::teleport_text_updated();
      break;
    case "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A":
      thread scripts\cp_mp\utility\omnvar_utility::tr_vis_facing_dist_add_override();
      break;
    case "_encstr_A6AE10032092892E28FFF91A34B95007CB0A":
      thread scripts\cp\utility\cp_safehouse_util::tr_vis_facing_dist_add_override();
      break;
  }

  self notify("_encstr_B1C80D5D9E631E21A65378089A7FD5");

  if(scripts\cp\utility::_hasperk("_encstr_A9F31F6EC1AC6C2D0BD8E8E57DCC2CE6E8C9B236F616C8D73685D5378D345693B9")) {
    var_2 = weaponclass(var_0.basename) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0";

    if(var_2 && !istrue(self.fastreloadlaunchers)) {
      scripts\cp\utility::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
      self.fastreloadlaunchers = 1;
    } else if(istrue(self.fastreloadlaunchers)) {
      scripts\cp\utility::_unsetperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (var_1) {
    default:
      break;
    case "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD":
      thread scripts\cp\vehicles\vehicle_damage_cp::initarmor(var_0);
      break;
    case "_encstr_A5090EB4DD83D78D16BE3B4EED5BACB7":
      thread scripts\cp\agents\gametype_cp_specops::missilelauncherusageloop();
      break;
    case "_encstr_97EF0EA5BB70FA1BB0AFD4D56396593A":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
    case "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A":
      thread scripts\cp_mp\utility\omnvar_utility::_id_1403E(var_0);
      break;
    case "_encstr_A6AE10032092892E28FFF91A34B95007CB0A":
      thread scripts\cp\utility\cp_safehouse_util::_id_1403E(var_0);
      break;
  }
}

watchforweapondropped() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_845F16C37644280358FFADFFCF72577BE687EB58DAA8C0CD");
  self endon("_encstr_845F16C37644280358FFADFFCF72577BE687EB58DAA8C0CD");

  for(;;) {
    self waittill("_encstr_B8E20FBB59851CF6E6AF91E4DBC107B232", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1))
      self.storedweapons[var_1.basename] = undefined;
  }
}

monitorlauncherspawnedgrenades() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");

  for(;;) {
    var_0 = waittill_grenade_fire();

    if(isDefined(var_0.weapon_name)) {
      if(glprox_trygetweaponname(var_0.weapon_name) == "_encstr_8B700CA0CD3977AF47CAA02BF7E8")
        semtexused(var_0);

      switch (var_0.weapon_name) {
        case "_encstr_AC5911C3C04BE2CF58550D3F6F03FFAC971B0B":
        case "_encstr_99410C4B48C39AB7D0CD95B769DB":
          thread scripts\cp\equipment\cp_thermite::thermite_used(var_0);
          break;
        case "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA":
        case "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170":
        case "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83":
        case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
          scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(var_0);
          break;
      }
    }
  }
}

glprox_trygetweaponname(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return var_0;

  if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    return var_0;

  if(getweaponbasename(var_0) == "_encstr_992D0EA3AF07D840EC9AC37880F7D887") {
    if(isstring(var_0) && scripts\cp\utility::isaltmodeweapon(var_0) || issameweapon(var_0) && var_0.isalternate) {
      var_1 = getweaponattachments(var_0);
      var_0 = var_1[0];
    } else
      var_0 = getweaponbasename(var_0);
  }

  return var_0;
}

stancerecoiladjuster() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");

  if(!isPlayer(self)) {
    return;
  }
  self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_A6E308B2DCE8B0B936B2");
  self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_B44609DFE7078F394E1651");

  if(!self isconsoleplayer() && !isai(self)) {
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_B1680E47C3E2A4204C7F417BE53D486B");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_A38B0C43A0B047C20783E360451D");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_ACF70A27C7824C50E45D6358");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_92700A11DD726DD11CCFD010");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_A75407A4F05EE24E57");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_AA1207A507C9B7732B");
  }

  for(;;) {
    scripts\engine\utility::_id_143A6("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_9A1A0D9B0E395ADC47AF98B2CEA59B", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
    wait 0.5;

    if(isDefined(self.onhelisniper) && self.onhelisniper) {
      continue;
    }
    var_0 = self getstance();
    stancerecoilupdate(var_0);
  }
}

stancerecoilupdate(var_0) {
  var_1 = self getcurrentprimaryweapon();
  var_2 = 0;

  if(isrecoilreducingweapon(var_1))
    var_2 = getrecoilreductionvalue();

  if(var_0 == "_encstr_922406F1A6FD5E05") {
    var_3 = var_1.classname;

    if(isDefined(var_3)) {
      if(var_3 == "_encstr_A3710BEEACC2E0B737EB36B676") {
        setrecoilscale(0, 40);
        return;
      }

      if(var_3 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33") {
        if(var_1 hasattachment("_encstr_82820C411AC33E28E59A2F0D85CF", 1)) {
          setrecoilscale(0, 20 + var_2);
          return;
        }

        setrecoilscale(0, 40 + var_2);
        return;
        return;
      }

      return;
      return;
    }

    setrecoilscale();
    return;
  } else if(var_0 == "_encstr_B13D076BED70539F23") {
    var_3 = var_1.classname;

    if(isDefined(var_3)) {
      if(var_3 == "_encstr_A3710BEEACC2E0B737EB36B676") {
        setrecoilscale(0, 10);
        return;
      }

      if(var_3 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33") {
        if(var_1 hasattachment("_encstr_82820C411AC33E28E59A2F0D85CF", 1)) {
          setrecoilscale(0, 10 + var_2);
          return;
        }

        setrecoilscale(0, 20 + var_2);
        return;
        return;
      }

      return;
      return;
    }

    setrecoilscale();
    return;
  } else if(var_2 > 0)
    setrecoilscale(0, var_2);
  else
    setrecoilscale();
}

setrecoilscale(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(self.recoilscale))
    self.recoilscale = var_0;
  else
    self.recoilscale = self.recoilscale + var_0;

  if(isDefined(var_1)) {
    if(isDefined(self.recoilscale) && var_1 < self.recoilscale)
      var_1 = self.recoilscale;

    var_2 = 100 - var_1;
  } else
    var_2 = 100 - self.recoilscale;

  if(var_2 < 0)
    var_2 = 0;

  if(var_2 > 100)
    var_2 = 100;

  if(var_2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var_2);
}

isrecoilreducingweapon(var_0) {
  if(nullweapon(var_0))
    return 0;

  var_1 = 0;

  if(var_0 hasattachment("_encstr_8A9F09375D2EA3F3F08B27", 1) || var_0 hasattachment("_encstr_B67B0B5B07378DF61CB2D7D36B", 1) || var_0 hasattachment("_encstr_BD580D72438B60EB199E5B43A00397", 1))
    var_1 = 1;

  return var_1;
}

getrecoilreductionvalue() {
  if(!isDefined(self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"]))
    self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"] = 0;

  return self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"] * 40;
}

watchforweaponchange() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self notify("_encstr_998215D72F13178C1DF0A30958AB42EF88964079301977");
  self endon("_encstr_998215D72F13178C1DF0A30958AB42EF88964079301977");

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);

    if(nullweapon(var_0)) {
      continue;
    }
    if(isvalidweapon(var_0))
      self.last_valid_weapon = var_0;

    if(!isDefined(self.storedweapons))
      self.storedweapons = [];

    if(!isDefined(self.storedweapons[var_0.basename]))
      self.storedweapons[var_0.basename] = createheadicon(var_0);

    thread updatelauncherusage();

    if(scripts\cp\utility::iskillstreakweapon(var_0)) {
      continue;
    }
    if(is_launcher(var_0) && !is_killstreak_weapon(var_0)) {
      if(self.class == "_encstr_8DEF05BDE933E0")
        var_0 = add_launcher_xmags(var_0);
      else
        var_0 = _id_12BDA(var_0);

      if(isDefined(level.set_relics)) {
        if(isDefined(level.set_relics["_encstr_87FC1730F2BD7BC1CFCA0876BB4F6B4F249A7848C916BBD837"]))
          self disableemptyclipweaponswitch(1);
      }

      continue;
    }

    if(isDefined(level.set_relics)) {
      if(isDefined(level.set_relics["_encstr_87FC1730F2BD7BC1CFCA0876BB4F6B4F249A7848C916BBD837"]))
        self disableemptyclipweaponswitch(0);
    }
  }
}

minigamefinishcount(var_0) {
  var_0 notify("_encstr_86AE11C8CB3511FB5F6EB4A07587E0EB9F0310");
  var_1 = ["_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB", "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB"];
  var_2 = "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB";

  foreach(var_4 in var_1) {
    if(var_0 hasweapon(var_4))
      var_2 = var_4;
  }

  var_6 = getcompleteweaponname(var_2);
  var_7 = var_0 dropitem(var_6);
  var_7 thread watchweaponpickup();
}

_id_1447D(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_91D70BC8AF032B0F1B734F731A");
  var_0 endon("_encstr_86AE11C8CB3511FB5F6EB4A07587E0EB9F0310");
  var_0 notify("_encstr_9928118B3E1C705BA0DF5D5B0FCB90B9AD9530");
  var_0 endon("_encstr_9928118B3E1C705BA0DF5D5B0FCB90B9AD9530");

  for(;;) {
    var_2 = var_0 getweaponammoclip(var_1);

    if(var_2 <= 0) {
      var_0 takeweapon(var_1);
      return;
    }

    waitframe();
  }
}

_id_12349(var_0) {
  if(var_0.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
    return 1;

  if(var_0.basename == "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB")
    return 1;

  return 0;
}

_id_139CF(var_0, var_1) {
  if(var_1.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
    return 0;

  if(var_1.basename == "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB")
    return 0;

  return _id_124AD(var_0);
}

_id_124AD(var_0) {
  var_1 = ["_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB", "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB"];

  foreach(var_3 in var_1) {
    if(var_0 hasweapon(var_3))
      return 1;
  }

  return 0;
}

is_launcher(var_0) {
  var_1 = weaponclass(var_0);

  if(var_1 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
    return 1;

  switch (var_0.basename) {
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      return 1;
  }

  return 0;
}

is_killstreak_weapon(var_0) {
  switch (var_0.basename) {
    case "_encstr_A3F90EBB3B32C3D21E5A2DFA07B72A93":
    case "_encstr_9A710EF13EAB468A3FDA77BA08E79683":
      return 1;
    default:
      return 0;
  }
}

add_launcher_xmags(var_0) {
  var_1 = "_encstr_87DC10FB6DA2A9A7401E50377A4398EB377A";

  switch (var_0.basename) {
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      var_1 = "_encstr_87DC10FB6DA2A9A7401E50377A4398EB377A";
      break;
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      var_1 = "_encstr_A9B5103CB5169D37D7C6C1FAD4AED8B456E8";
      break;
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
      var_1 = "_encstr_87720FE1DAC2EC6EBE1BC1D7ADB3DB3699";
      break;
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      var_1 = "_encstr_81F31083736EEF67D11617E7FD69F272A1D7";
      break;
    default:
      break;
  }

  if(!var_0 hasattachment(var_1))
    var_0 = addattachmenttoweapon(var_0, var_1, 1);

  return var_0;
}

_id_12BDA(var_0) {
  var_1 = "_encstr_87DC10FB6DA2A9A7401E50377A4398EB377A";

  switch (var_0.basename) {
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      var_1 = "_encstr_87DC10FB6DA2A9A7401E50377A4398EB377A";
      break;
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      var_1 = "_encstr_A9B5103CB5169D37D7C6C1FAD4AED8B456E8";
      break;
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
      var_1 = "_encstr_87720FE1DAC2EC6EBE1BC1D7ADB3DB3699";
      break;
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      var_1 = "_encstr_81F31083736EEF67D11617E7FD69F272A1D7";
      break;
    default:
      break;
  }

  if(var_0 hasattachment(var_1))
    remove_attachment(var_1, self, var_0);

  return var_0;
}

isfistweapon(var_0) {
  var_0 = scripts\cp\utility::getweaponrootname(var_0);
  return var_0 == "_encstr_A7ED0AD79F73990E28334B92";
}

isvalidweapon(var_0) {
  var_1 = level.additional_laststand_weapon_exclusion;
  var_2 = undefined;

  if(issameweapon(var_0))
    var_2 = var_0;
  else
    var_2 = asmdevgetallstates(var_0);

  if(nullweapon(var_2))
    return 0;
  else if(isDefined(var_1) && scripts\engine\utility::array_contains(var_1, var_2))
    return 0;
  else if(scripts\cp\utility::is_melee_weapon(var_2, 1))
    return 0;
  else
    return 1;
}

updatesavedlastweapon() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  var_0 = self.currentweaponatspawn;

  if(isDefined(self.saved_lastweaponhack))
    var_0 = self.saved_lastweaponhack;

  self.saved_lastweapon = var_0;

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);

    if(nullweapon(var_1)) {
      self.saved_lastweapon = var_0;
      continue;
    }

    var_2 = weaponinventorytype(var_1);
    self[[level.move_speed_scale]]();
    self.saved_lastweapon = var_0;

    if(isdroppableweapon(self.saved_lastweapon))
      self.lastdroppableweaponobj = self.saved_lastweapon;

    var_0 = var_1;
  }
}

bomber_spawn_origin_array_init() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0, var_1);
    var_0.owner = self;

    switch (var_1.basename) {
      case "_encstr_BA730BF8AFF178988293F158B9":
        level thread scripts\cp\powers\coop_molotov::bomber_shouldusetraversals(self, var_0);
        break;
      case "_encstr_B8D30758E3EE7827BA":
        thread scripts\cp\equipment\cp_gas_grenade::gas_used(var_0);
        break;
      case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
        var_0 thread watchconcussiongrenadeexplode();
        break;
    }
  }
}

watchgrenadeusage() {
  self notify("_encstr_9571127F17D326D8E73A0178E6ACF875DB7FC7D3");
  self endon("_encstr_9571127F17D326D8E73A0178E6ACF875DB7FC7D3");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self.throwinggrenade = undefined;
  self.gotpullbacknotify = 0;

  if(!isDefined(self.plantedlethalequip)) {
    self.plantedlethalequip = [];
    self.plantedtacticalequip = [];
  }

  for(;;) {
    self waittill("_encstr_B89B11B393CACDC2C859AF8357638D13B08DD6", var_0);
    var_1 = self getthrowbackweapon();

    if(!nullweapon(var_1)) {
      continue;
    }
    var_2 = var_0.basename;
    thread watchoffhandcancel();
    self.throwinggrenade = var_2;

    if(var_2 == "_encstr_9AAE0876FCB7603101DB")
      thread beginc4tracking();

    begingrenadetracking();
    self.throwinggrenade = undefined;
  }
}

watchoffhandcancel() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_9B620D8F0DC07577C551F16A3826BF");
  self waittill("_encstr_9A630C851C886BC33D8221E3EEB1");

  if(isDefined(self.changingweapon) && self.changingweapon != self getcurrentweapon())
    self.changingweapon = undefined;
}

beginc4tracking() {
  self notify("_encstr_B496104CCA762DDC68868A272CD8B52D733B");
  self endon("_encstr_B496104CCA762DDC68868A272CD8B52D733B");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A6("_encstr_9B620D8F0DC07577C551F16A3826BF", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_9A630C851C886BC33D8221E3EEB1");
  self.changingweapon = undefined;
}

dudgrenadeused(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread ownerdisconnectcleanup(var_0);
  thread scripts\cp\utility::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self waittill("_encstr_860808CB78E2984063BA", var_1);
  self delete();
}

begingrenadetracking() {
  self endon("_encstr_9A630C851C886BC33D8221E3EEB1");
  var_0 = gettime();
  var_1 = waittill_grenade_fire();

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_1.weapon_name)) {
    return;
  }
  self.changingweapon = undefined;

  switch (var_1.weapon_name) {
    case "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E":
      thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(var_1);
      break;
    case "_encstr_A9B40FB4DD837DD6DBD8BDA3DECEBE3DD6":
    case "_encstr_BA730BF8AFF178988293F158B9":
      thread scripts\cp\powers\coop_molotov::molotov_used(var_1);
      self.waittill_any_timeout_no_endon_death_4 = gettime();
      break;
    case "_encstr_84E81558CF28E6D952A6C1D5FC290BE9CA07B018070B5B":
    case "_encstr_9508192DEE707DB0239CB273851B2DDCCAF5B658C9DA9539D7B1C1":
    case "_encstr_B4E9147053F0F70EFB580FA689A0BB721C4F3B7918E1":
    case "_encstr_826813691C902EB9B0A5507FFF574ABB61A2B1EBA3":
      scripts\cp\crafting_system::throwcrate(var_1);
      break;
    case "_encstr_BAE70F650B12EFA13AD74838BB45FEFD2A":
      var_1 thread dudgrenadeused(self);
      var_1 thread grenade_earthquake();
      break;
    case "_encstr_A65517E81AAC93DA7B4CC2C9D26CAF3B4E5673C28CB2F56B0E":
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
    case "_encstr_914A1099390B3BFA9DC9B2DC16232BFA9E6B":
      if(gettime() - var_0 > 1000)
        var_1.iscooked = 1;

      var_1 thread _id_144D9();
      var_1.originalowner = self;
      break;
    case "_encstr_A99213D77C53903D97DB1E01C34FF8C8AFCD277D15":
      var_1.clusterticks = var_1.ticks;

      if(var_1.ticks >= 1)
        var_1.iscooked = 1;

      var_1.originalowner = self;
      var_1 thread clustergrenadeused();
      var_1 thread grenade_earthquake();
      break;
    case "_encstr_8AFE12BA923B5DC078856737ADE510157B79D063":
    case "_encstr_BDA70A2F5F1AF5F8A009AA40":
    case "_encstr_92A70ABB8267F5E0D89F6351":
      thread semtexused(var_1);
      break;
    case "_encstr_B8D30758E3EE7827BA":
      thread scripts\cp\equipment\cp_gas_grenade::gas_used(var_1);
      break;
    case "_encstr_8C2E0D5B1078EEF508EBB81DE067A3":
      thread scripts\mp\equipment\hb_sensor::hb_sensor_used(var_1);
      break;
    case "_encstr_9AAE0876FCB7603101DB":
      thread scripts\cp\cp_c4::c4_used(var_1);
      break;
    case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
      thread scripts\cp\cp_claymore::claymore_use(var_1);
      break;
    case "_encstr_81430B218B3F7018458997D78A":
      thread scripts\cp\equipment\cp_at_mine::at_mine_use(var_1);
      break;
    case "_encstr_92EA0A290B32FF88A90170EB":
      thread scripts\cp\equipment\cp_trophy_system::trophy_used(var_1);
      break;
    case "_encstr_B635099C3C8FEDFB88E9EB":
      thread scripts\cp\crafting_system::_id_12C8B(var_1);
      break;
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
      var_1 thread watchconcussiongrenadeexplode();
      break;
    case "_encstr_8C5A1231DEEA37D82D9BD9F5312BA33AE5AFADC1":
      thread mineused(var_1, ::spawnmine);
      break;
    case "_encstr_8D2E157420B63003616B9F8F7D2394379AC5F72748E1C1":
    case "_encstr_AACD13E8A1E47BDD4B9BECDACDA5332B6C43F5B5C1":
    case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
      level thread throwingknifeused(self, var_1, var_1.weapon_name);
      break;
    case "_encstr_95E8104FDBDA7D272B1CAE3637B793AFAD0E":
      var_1 delete();
      break;
    case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
      var_1 thread smokegrenadeused();
      break;
    case "_encstr_83B20F81360389C45B1755530BF2AFD0B8":
      var_1 thread watchgasgrenadeexplode();
      break;
    case "_encstr_A14A0DD37BFF6FA915219DF36F7D98":
      break;
    case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
      var_1.ninebangticks = var_1.ticks;
      var_1 thread _id_144A9();

      if(var_1.ticks >= 1)
        var_1.iscooked = 1;

      break;
    case "_encstr_BE8B116725FA28FB5178B2CF85017912618763":
      thread scripts\mp\trials\trial_jugg::decoy_used(var_1);
      break;
  }

  if(isDefined(var_1)) {
    var_1 thread scripts\cp\cp_player_battlechatter::grenadeproximitytracking();
    scripts\cp\cp_player_battlechatter::ongrenadeuse(var_1);
  }
}

extinguishonexplode(var_0) {
  thread scripts\cp\utility::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_1 = self.owner;
  self waittill("_encstr_860808CB78E2984063BA", var_2);
  level notify("_encstr_87051569430389C06AD9777DC7D7404DCFBAA193BAD733", var_2, var_0, var_1);
}

ninebangexplodewaiter() {
  thread scripts\cp\utility::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self waittill("_encstr_860808CB78E2984063BA", var_0);
  thread doninebang(var_0, self.owner, self.ninebangticks);
  ninebangdoempdamage(var_0, self.owner, self.ninebangticks);
}

ninebangdoempdamage(var_0, var_1, var_2) {
  if(var_2 >= 5) {
    playsoundatpos(var_0, "_encstr_AD5F1CB25B83D7CE4E2BCD58C859D759C31C1BED1959D7192B99585DD847");
    var_3 = level.players;

    foreach(var_5 in var_3)
    var_5 notify("_encstr_93F60B2B5BC1EB912C5BB0ECB2", self.owner, 8.0);
  }
}

doninebang(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = level.weaponconfigs[self.weapon_name];
  wait(randomfloatrange(0.25, 0.5));

  for(var_4 = 1; var_4 < var_2; var_4++) {
    var_5 = getninebangsubexplosionpos(var_0, var_3.vfxradius);
    playFX(var_3.onexplodevfx, var_5);

    foreach(var_7 in level.players) {
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive() || var_7.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
        continue;
      }
      var_8 = var_7 getEye();
      var_9 = distancesquared(var_0, var_8);

      if(var_9 > var_3.radius_max_sq) {
        continue;
      }
      if(!scripts\engine\trace::_bullet_trace_passed(var_0, var_8, 0, var_7)) {
        continue;
      }
      if(var_9 <= var_3.radius_min_sq)
        var_10 = 1.0;
      else
        var_10 = 1.0 - (var_9 - var_3.radius_min_sq) / (var_3.radius_max_sq - var_3.radius_min_sq);

      var_11 = anglesToForward(var_7 getplayerangles());
      var_12 = var_0 - var_8;
      var_12 = vectorNormalize(var_12);
      var_13 = 0.5 * (1.0 + vectordot(var_11, var_12));
      var_14 = 1;
      var_7 notify("_encstr_ABE70A08F0C68B546D12A8E7", var_0, var_10, var_13, var_1, var_14);
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

getninebangsubexplosionpos(var_0, var_1) {
  var_2 = (randomfloatrange(-1.0 * var_1, var_1), randomfloatrange(-1.0 * var_1, var_1), 0);
  var_3 = var_0 + var_2;
  var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 0, undefined, 0, 0, 0, 0, 0);

  if(var_4["_encstr_A53009A25003666B9818C6"] < 1)
    var_3 = var_0 + var_4["_encstr_A53009A25003666B9818C6"] * var_2;

  return var_3;
}

rat_executevisuals(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self playlocalsound("_encstr_A18E11CA972BD71CD58DCDACAF833639D7D84E");
  self setscriptablepartstate("_encstr_8F6E0EE485E8FACA2F957DC1D5D8E6B2", "_encstr_930B07BB1B6B3854FF");
  scripts\engine\utility::_id_143BA(var_0, "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_8F6E0EE485E8FACA2F957DC1D5D8E6B2", "_encstr_8882099673858D1D4B6756");
}

handleratvisionburst(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread rat_executevisuals(2.4);
}

isinvalidzone(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray("_encstr_95FC1783EDBB5993D7CA87361BD5B9A5B7B9F5D9DBD8D55B2B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_5)) {
    if(isDefined(level.neil) && isDefined(level.neil.upper_body)) {
      if(var_5 == level.neil || var_5 == level.neil.upper_body)
        return 0;
    }

    if(isDefined(level.boat_vehicle)) {
      if(var_5 == level.boat_vehicle)
        return 0;
    }

    if(isDefined(var_5.targetname) && var_5.targetname == "_encstr_8220185B80FF69728B43E2F2F7BA4A1D33EFAEDB31A88FD0A323")
      return 0;
  }

  if(isDefined(var_1))
    var_6 = scripts\engine\utility::array_combine(var_6, var_1);

  foreach(var_8 in var_6) {
    if(ispointinvolume(var_0, var_8))
      return 0;
  }

  if(istrue(var_4) && !ispointonnavmesh(var_0))
    return 0;

  if(istrue(var_3)) {
    if(navtrace(var_2.origin, var_0))
      return 0;
  }

  return 1;
}

placeequipmentfailed(var_0, var_1, var_2, var_3) {
  if(isPlayer(self))
    self playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");

  if(istrue(var_1)) {
    var_4 = undefined;

    if(isPlayer(self)) {
      if(isDefined(var_3))
        var_4 = spawnfxforclient(scripts\engine\utility::getfx("_encstr_8B4615CB407F5F8FF1039D99196857A31DFD52C2E8C51B"), var_2, self, anglesToForward(var_3), anglestoup(var_3));
      else
        var_4 = spawnfxforclient(scripts\engine\utility::getfx("_encstr_8B4615CB407F5F8FF1039D99196857A31DFD52C2E8C51B"), var_2, self);
    } else
      var_4 = spawnfx(scripts\engine\utility::getfx("_encstr_8B4615CB407F5F8FF1039D99196857A31DFD52C2E8C51B"), var_2);

    triggerfx(var_4);
    thread placeequipmentfailedcleanup(var_4);
  }
}

placeequipmentfailedcleanup(var_0) {
  wait 2;
  var_0 delete();
}

spawnmine(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = (0, randomfloat(360), 0);

  var_4 = level.weaponconfigs[var_2];
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_5.angles = var_3;
  var_5.owner = var_1;
  var_5.weapon_name = var_2;
  var_5.config = var_4;
  var_5 setModel(var_4.model);
  var_5 setotherent(var_1);
  var_5.killcamoffset = (0, 0, 4);
  var_5.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin + var_5.killcamoffset);
  var_5.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
  var_1 onlethalequipmentplanted(var_5);

  if(isDefined(var_4.mine_beacon))
    var_5 thread doblinkinglight("_encstr_B2BF0708BA770F795B", var_4.mine_beacon["_encstr_ACFC091AE8AB2FCBE15119"], var_4.mine_beacon["_encstr_88BF06FD784A6393"]);

  var_6 = undefined;

  if(self != level)
    var_6 = self getlinkedparent();

  var_5 explosivehandlemovers(var_6);
  var_5 thread mineproximitytrigger(var_6);
  var_5 thread grenade_earthquake();
  var_5 thread mineselfdestruct();
  var_5 thread mineexplodeonnotify();
  level thread monitordisownedequipment(var_1, var_5);
  return var_5;
}

mineselfdestruct() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  wait(level.mineselfdestructtime + randomfloat(0.4));
  self notify("_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A");
  self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B");
}

mineexplodeonnotify() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = self.owner;

  var_1 = self.config;
  var_2 = var_1.vfxtag;

  if(!isDefined(var_2))
    var_2 = "_encstr_B2BF0708BA770F795B";

  var_3 = self gettagorigin(var_2);

  if(!isDefined(var_3))
    var_3 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  self notify("_encstr_860808CB78E2984063BA", var_3);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();

  if(isDefined(var_1.onexplodefunc))
    self thread[[var_1.onexplodefunc]]();

  if(isDefined(var_1.onexplodesfx))
    self playSound(var_1.onexplodesfx);

  var_4 = scripts\engine\utility::ter_op(isDefined(var_1.onexplodevfx), var_1.onexplodevfx, level.mine_explode);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemin), var_1.minedamagemin, level.minedamagemin);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemax), var_1.minedamagemax, level.minedamagemax);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1.minedamageradius), var_1.minedamageradius, level.minedamageradius);
  self radiusdamage(self.origin, var_7, var_6, var_5, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self.weapon_name);
  wait 0.2;
  deleteexplosive();
}

mineproximitytrigger(var_0) {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_921D09D9D9C0090D7275B4");
  var_1 = self.config;
  wait(var_1.armtime);

  if(isDefined(var_1.mine_beacon))
    thread doblinkinglight("_encstr_B2BF0708BA770F795B", var_1.mine_beacon["_encstr_ACFC091AE8AB2FCBE15119"], var_1.mine_beacon["_encstr_88BF06FD784A6393"]);

  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  var_2.owner = self;
  var_2.team = var_2.owner.team;
  thread minedeletetrigger(var_2);

  if(isDefined(var_0)) {
    var_2 enablelinkTo();
    var_2 linkTo(var_0);
  }

  self.damagearea = var_2;

  for(;;) {
    var_2 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(isPlayer(var_3)) {
      wait 0.05;
      continue;
    }

    if(var_3 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self playSound(self.config.ontriggeredsfx);
  explosivetrigger(var_3, level.minedetectiongraceperiod, "_encstr_B6A2056BD2E659");
  self thread[[self.config.ontriggeredfunc]]();
}

minedeletetrigger(var_0) {
  scripts\engine\utility::_id_143A7("_encstr_879C0F95E0B8AD31855D17376F25ABE550", "_encstr_887B0FB5B4DC95FA322B6E4727BDF29523", "_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A", "_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    var_0 delete();
}

doblinkinglight(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getfx("_encstr_A16C1257AD31DBC1D568921AA857471BE805C6FC");

  if(!isDefined(var_2))
    var_2 = scripts\engine\utility::getfx("_encstr_B4C5113B8257F7315EAC6B6DC349B8B0EFBA72");

  self.blinkinglightfx["_encstr_ACFC091AE8AB2FCBE15119"] = var_1;
  self.blinkinglightfx["_encstr_88BF06FD784A6393"] = var_2;
  self.blinkinglighttag = var_0;
  thread updateblinkinglight(var_1, var_2, var_0);
  self waittill("_encstr_AD75063D571AE108");
  stopblinkinglight();
}

updateblinkinglight(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_93F60B2B5BC1EB912C5BB0ECB2");
  var_3 = ::checkteam;

  if(!level.teambased)
    var_3 = ::checkplayer;

  var_4 = randomfloatrange(0.05, 0.25);
  wait(var_4);
  childthread onjointeamblinkinglight(var_0, var_1, var_2, var_3);

  foreach(var_6 in level.players) {
    if(isDefined(var_6)) {
      if(self.owner[[var_3]](var_6))
        playfxontagforclients(var_0, self, var_2, var_6);
      else
        playfxontagforclients(var_1, self, var_2, var_6);

      wait 0.05;
    }
  }
}

checkplayer(var_0) {
  return self == var_0;
}

checkteam(var_0) {
  return self.team == var_0.team;
}

onjointeamblinkinglight(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_93F60B2B5BC1EB912C5BB0ECB2");

  for(;;) {
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298", var_4);

    if(self.owner[[var_3]](var_4)) {
      playfxontagforclients(var_0, self, var_2, var_4);
      continue;
    }

    playfxontagforclients(var_1, self, var_2, var_4);
  }
}

stopblinkinglight() {
  if(isalive(self) && isDefined(self.blinkinglightfx)) {
    stopFXOnTag(self.blinkinglightfx["_encstr_ACFC091AE8AB2FCBE15119"], self, self.blinkinglighttag);
    stopFXOnTag(self.blinkinglightfx["_encstr_88BF06FD784A6393"], self, self.blinkinglighttag);
    self.blinkinglightfx = undefined;
    self.blinkinglighttag = undefined;
  }
}

_id_144D9() {
  var_0 = self.owner.name;
  self waittill("_encstr_860808CB78E2984063BA", var_1);
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_1, "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", var_0);
}

_id_144A9() {
  var_0 = self.owner.name;
  self waittill("_encstr_860808CB78E2984063BA", var_1);
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_1, "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", var_0);
}

watchgasgrenadeexplode() {
  var_0 = self.owner;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_860808CB78E2984063BA", var_1);
  thread ongasgrenadeimpact(var_0, var_1);
}

ongasgrenadeimpact(var_0, var_1) {
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1, 0, 128, 160);
  var_2.owner = var_0;
  var_3 = 128;
  var_4 = spawnfx(scripts\engine\utility::getfx("_encstr_A35718B469C7E6DF8A4A50207267F73BD71FCA3DFF270813B593"), var_1);
  triggerfx(var_4);
  wait 1.0;

  for(var_5 = 8.0; var_5 > 0.0; var_5 = var_5 - 0.2) {
    var_6 = undefined;

    if(isDefined(level.spawned_enemies))
      var_6 = level.spawned_enemies;
    else
      var_6 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

    foreach(var_8 in var_6) {
      if(isDefined(var_8.agent_type) && (var_8.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_8.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73" || var_8.agent_type == "_encstr_9BE008764102938025A5" || var_8.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B")) {
        continue;
      }
      var_9 = getdamagefromzombietype(var_8);

      if(isalive(var_8))
        var_8 applygaseffect(var_0, var_1, var_2, var_2, int(var_9));
    }

    wait 0.2;
  }

  var_4 delete();
  wait 2.0;
  var_2 delete();

  foreach(var_8 in scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A")) {
    if(isalive(var_8))
      var_8.flame_damage_time = undefined;
  }
}

getdamagefromzombietype(var_0) {
  if(isalive(var_0)) {
    if(istrue(var_0.is_suicide_bomber))
      return int(min(1000, var_0.maxhealth * 0.25));
    else
      return int(min(1000, var_0.maxhealth * 0.1));
  } else
    return 150;
}

applygaseffect(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(self) && self istouching(var_2)) {
    if(var_0 scripts\cp\utility::isenemy(self)) {
      var_3 radiusdamage(self.origin, 1, var_4, var_4, var_0, "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421", "_encstr_83B20F81360389C45B1755530BF2AFD0B8");
      self.flame_damage_time = gettime() + 200;
    }
  }
}

throwingknifeused(var_0, var_1, var_2) {
  if(var_2 == "_encstr_AACD13E8A1E47BDD4B9BECDACDA5332B6C43F5B5C1") {
    var_1 makeunusable();
    var_1 thread recordthrowingknifetraveldist();
  }

  thread throwingknifedamagedvictim(var_0, var_1);
  var_3 = undefined;
  var_4 = undefined;
  var_1 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_3, var_4);
  var_5 = isDefined(var_4) && var_4 == "_encstr_B4C70C6907F228B8FCCCF1C8F7CA";
  var_6 = isDefined(var_4) && var_4 == "_encstr_8AD30BA3E631B1687D87E39838";

  if(isDefined(var_3) && (isPlayer(var_3) || isagent(var_3)) && var_5)
    var_3 notify("_encstr_A6FF0B47103080F03A87404BC3", var_1);

  if(isDefined(var_3) && (isPlayer(var_3) || isagent(var_3)) && !var_6 && !var_5) {
    if(var_2 == "_encstr_AACD13E8A1E47BDD4B9BECDACDA5332B6C43F5B5C1")
      throwingknifec4detonate(var_1, var_3, var_0);
  }

  var_1.equipmentref = "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";
  var_1 thread watchgrenadedeath();

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_7);
    var_7 scripts\cp\cp_powers::power_adjustcharges(1, "_encstr_BA7F0830B3A7859B60B0");
  }
}

throwingknifedamagedvictim(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 waittill("_encstr_B6B10F0D8906786367394991622F2CB89F", var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_3) && var_3 == var_1) {
      if(var_7 == "_encstr_A96419E83493F6BBA53776B5B9B433953AAC36CA83EDE4E8EBADE0" && !isDefined(var_1.knifeteleownerinvalid)) {
        throwingknifeteleport(var_1, var_2, var_0, 1);
        var_1.giveknifeback = 1;
      }

      break;
    }
  }
}

watchgrenadedeath() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.knife_trigger))
    self.knife_trigger delete();
}

throwingknifeused_trygiveknife(var_0, var_1, var_2) {
  var_3 = var_0 getweaponammoclip(var_2);
  var_4 = 2;
  var_5 = undefined;

  if(var_3 >= var_4)
    var_5 = 0;
  else {
    var_0 setweaponammoclip(var_2, var_3 + 1);
    var_0 thread scripts\cp\cp_damagefeedback::hudicontype("_encstr_92590EFBF91ED25750D8D7DC30B88E8A");
    var_5 = 1;
  }

  return var_5;
}

throwingknifeteleport(var_0, var_1, var_2, var_3) {
  var_2 playlocalsound("_encstr_A15F1406549FF0979CAA186832B9912923C59708A233");
  var_2 playsoundonmovingent("_encstr_A2F7182A80BBABCC40FD4156F3B953CF51D98362EB8DB74570CF");
  playsoundatpos(var_0.origin, "_encstr_85E81221AACF50388436838525E160A9D312996B");
  thread throwingknifeteleport_fxstartburst(var_2, var_1);
  var_4 = var_1 getcorpseentity();

  if(isDefined(var_4))
    var_4 notsolid();

  var_5 = [];

  foreach(var_7 in level.characters) {
    if(!isDefined(var_7) || !isalive(var_7) || var_7 == var_1 || var_7 == var_2 || !var_2 scripts\cp\utility::isenemy(var_7)) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  var_5 = sortbydistance(var_5, var_1.origin);
  var_9 = var_2 gettagorigin("_encstr_A130085D3FD8D8A80F60");
  var_10 = var_1.origin;
  var_11 = var_1.origin + (0, 0, var_9[2] - var_2.origin[2]);
  var_12 = var_2.angles;

  foreach(var_14 in var_5) {
    var_15 = (var_14.origin[0], var_14.origin[1], var_14 gettagorigin("_encstr_A130085D3FD8D8A80F60")[2]);

    if(distancesquared(var_14.origin, var_1.origin) < 230400 && sighttracepassed(var_11, var_15, 0, undefined)) {
      var_12 = vectortoangles(var_15 - var_11);
      break;
    }
  }

  var_2 setOrigin(var_1.origin, !var_3);
  var_2 setplayerangles(var_12);
  throwingknifeteleport_fxendburst(var_2, var_1);
}

throwingknifeteleport_fxstartburst(var_0, var_1) {
  var_2 = var_1.origin - var_0.origin;
  var_3 = var_0.origin + (0, 0, 32);
  var_4 = vectorNormalize(var_2);
  var_5 = vectorNormalize(vectorcross(var_2, (0, 0, 1)));
  var_6 = vectorcross(var_5, var_4);
  var_7 = axistoangles(var_4, var_5, var_6);
  var_8 = 0;

  if(var_8) {
    var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_9.angles = var_7;
    var_9 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_9 hidefromplayer(var_0);
    waitframe();
    playfxontagforteam(scripts\engine\utility::getfx("_encstr_A95F1E9D330FEBD6E64B9959F5D1CA8D567D9BA3B03947AFCC4E2D597346C6F2"), var_9, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0.team);
    wait 3.0;
    var_9 delete();
  } else {
    var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
    var_10.angles = var_7;
    var_10 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_10 hidefromplayer(var_0);
    waitframe();

    foreach(var_12 in level.players)
    var_10 hidefromplayer(var_12);

    playFXOnTag(scripts\engine\utility::getfx("_encstr_99671863C773415348F92D0127FB911BBD1FBCFEABDD35287011"), var_10, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 3.0;
    var_10 delete();
  }
}

recordthrowingknifetraveldist() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.disttravelled = 0;
  var_0 = self.origin;

  for(;;) {
    var_1 = scripts\engine\utility::_id_143BA(0.15, "_encstr_AD75063D571AE108", "_encstr_8DE90E4D31C35370B84D709B4B6DEE42");

    if(!isDefined(self)) {
      break;
    }

    var_2 = distance(var_0, self.origin);
    self.disttravelled = self.disttravelled + var_2;
    var_0 = self.origin;

    if(var_1 != "_encstr_995408F398012F656821") {
      break;
    }
  }
}

throwingknifeteleport_fxendburst(var_0, var_1) {}

throwingknifec4detonate(var_0, var_1, var_2) {
  var_1 playSound("_encstr_8CC11113B4DBE61C2D5B59D7591EC1C6B78C95");
  playFX(scripts\engine\utility::getfx("_encstr_8BC01814B1F0BDB7DBB80A3240233BF7A0A1878D0988058F75F1"), var_0.origin);
  var_0 radiusdamage(var_0.origin, 180, 1200, 600, var_2, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_0.weapon_name);
  var_0 thread grenade_earthquake();
  var_0 notify("_encstr_860808CB78E2984063BA", var_0.origin);
  var_0 delete();
}

throwingknifeused_recordownerinvalid(var_0, var_1) {
  var_1 endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  var_1.knifeteleownerinvalid = 1;
}

watchconcussiongrenadeexplode() {
  thread endondeath();
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_0 = self.owner.name;
  self waittill("_encstr_860808CB78E2984063BA", var_1);
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_1, "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", var_0);
  childthread stunenemiesinrange(var_1, self.owner);
  childthread stunplayersinrange(var_1, self.owner);
}

stunplayersinrange(var_0, var_1) {
  var_2 = level.players;
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, var_2, undefined, 24, 256);

  foreach(var_5 in var_3) {
    if((scripts\cp\utility::is_friendly_damage(var_5, var_1) && var_5 != var_1) == 0)
      var_5 thread stundamageonplayers(var_5, var_1, var_0);
  }
}

stundamageonplayers(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = 3;

  if(var_0 == var_1) {
    var_3 = 2;
    var_4 = 2;
  }

  var_5 = 1 - distance(var_0.origin, var_2) / 512;

  if(var_5 < 0)
    var_5 = 0;

  var_6 = var_3 + var_4 * var_5;
  var_1 notify("_encstr_931A09C264736B36580A55");
  var_0 notify("_encstr_83F70A36ED73D8AECD37B223", var_1);
  var_0 scripts\cp\utility::setplayerstunned();
  var_0 thread cleanupconcussionstun(var_6);
  var_0 shellshock("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", var_6);
  var_0.concussionendtime = gettime() + var_6 * 1000;
}

cleanupconcussionstun(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  scripts\cp\utility::setplayerunstunned();
}

stunenemiesinrange(var_0, var_1) {
  var_2 = scripts\engine\utility::array_combine(scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A"), scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_9B920B8EAC166BFAD186E49595"));
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, var_2, undefined, 24, 500);

  foreach(var_5 in var_3)
  var_5 thread fx_stun_damage(var_5, var_1);
}

fx_stun_damage(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.stun_hit_time)) {
    if(gettime() > var_0.stun_hit_time) {
      var_0.allowpain = 1;
      var_0.stun_hit_time = gettime() + 1000;
      var_0.stunned = 1;
      var_0 thread _id_12ABB();
    } else
      return;
  } else {
    var_0.allowpain = 1;
    var_0.stun_hit_time = gettime() + 1000;
    var_0.stunned = 1;
    var_0 thread _id_12ABB();
  }

  var_0 dodamage(1, var_0.origin, var_1, var_1, "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421", "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B");
  wait 10;
  var_0.allowpain = 0;
  var_0.stunned = undefined;
}

_id_12ABB() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BD8019ABDBBD58F8215F272F27DBB70859F973E1470598AD3A7F05");
  self endon("_encstr_BD8019ABDBBD58F8215F272F27DBB70859F973E1470598AD3A7F05");

  if(self.baseaccuracy != 0)
    self._id_11FBD = self.baseaccuracy;

  self.baseaccuracy = 0;

  while(istrue(self.stunned))
    waitframe();

  if(isDefined(self._id_11FBD))
    self.baseaccuracy = self._id_11FBD;
}

mineused(var_0, var_1) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 thread minethrown(self, var_0.weapon_name, var_1);
}

minethrown(var_0, var_1, var_2, var_3) {
  self.owner = var_0;
  self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_4);

  if(!isDefined(var_0)) {
    return;
  }
  if(var_1 != "_encstr_A14A0DD37BFF6FA915219DF36F7D98") {
    if(isDefined(var_4) && isDefined(var_4.owner)) {
      if(isDefined(var_3))
        self.owner[[var_3]](self);

      self delete();
      return;
    }
  }

  var_5 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"];

  if(var_5["_encstr_A53009A25003666B9818C6"] == 1) {
    var_6 = getgroundposition(self.origin, 12, 0, 32);
    var_5["_encstr_820E07FAE8780B3A4C"] = var_5["_encstr_820E07FAE8780B3A4C"] * -1;
  }

  var_7 = vectorNormalize(var_5["_encstr_820E07FAE8780B3A4C"]);
  var_8 = vectortoangles(var_7);
  var_8 = var_8 + (90, 0, 0);
  var_9 = [[var_2]](var_6, var_0, var_1, var_8);
  var_9 thread minedamagemonitor();
  self delete();
}

minedamagemonitor() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A");
  self endon("_encstr_AD75063D571AE108");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(isDefined(var_9) && isendstr(var_9.basename, "_encstr_AF1809ABEB255B61E9A01A")) {
      continue;
    }
    if(isDefined(self.owner) && var_0 != self.owner && !scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      switch (var_9.basename) {
        case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
        case "_encstr_AAE3152B1D2710FDA1C785A3CB6AB5B8CAF35121099D80":
        case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
        case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
          continue;
      }
    }

    break;
  }

  self notify("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");

  if(isDefined(var_4) && (issubstr(var_4, "_encstr_911B0C7DA090E9A7F799FD50DD48") || issubstr(var_4, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")))
    self.waschained = 1;

  if(isDefined(var_8) && var_8 &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;

  if(isDefined(var_0))
    self.damagedby = var_0;

  self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_0);
}

is_hive_explosion(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_0.classname))
    return 0;

  return var_0.classname == "_encstr_96010BDCD8392D073A164C1B2B" && var_1 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
}

claymoredetonation(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);

  if(isDefined(var_0)) {
    var_1 enablelinkTo();
    var_1 linkTo(var_0);
  }

  thread deleteondeath(var_1);

  for(;;) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(getdvarint("_encstr_93FA129BD8C9EB8D8D58BCADB7E4CA8CAC3157EC") != 1) {
      if(isDefined(self.owner)) {
        if(var_2 == self.owner) {
          continue;
        }
        if(isDefined(var_2.owner) && var_2.owner == self.owner)
          continue;
      }

      if(!scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_2, 0))
        continue;
    }

    if(lengthsquared(var_2 getentityvelocity()) < 10) {
      continue;
    }
    var_3 = abs(var_2.origin[2] - self.origin[2]);

    if(var_3 > 128) {
      continue;
    }
    if(!var_2 shouldaffectclaymore(self)) {
      continue;
    }
    if(var_2 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  explosivetrigger(var_2, level.claymoredetectiongraceperiod, "_encstr_9BD1091BC62CBCB5F6E4CA");
  self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B");
}

explosivetrigger(var_0, var_1, var_2) {
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_930B07BB1B6B3854FF", 0);

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("_encstr_9AE514B0EB4D49F30A0D35BB29B22350B127D8E82BE5")) {
    var_0 notify("_encstr_B2DA0E0B339B87A7ABD599C70BD35FC0", var_2);
    var_1 = level.delayminetime;
  }

  wait(var_1);
}

shouldaffectclaymore(var_0) {
  if(isDefined(var_0.disabled))
    return 0;

  var_1 = self.origin + (0, 0, 32);
  var_2 = var_1 - var_0.origin;
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectordot(var_2, var_3);

  if(var_4 < level.claymoredetectionmindist)
    return 0;

  var_2 = vectorNormalize(var_2);
  var_5 = vectordot(var_2, var_3);
  return var_5 > level.claymoredetectiondot;
}

deleteondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
  wait 0.05;

  if(isDefined(var_0)) {
    if(isDefined(var_0.trigger))
      var_0.trigger delete();

    var_0 delete();
  }
}

c4empdamage() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_93F60B2B5BC1EB912C5BB0ECB2", var_0, var_1);
    equipmentempstunvfx();
    self.disabled = 1;
    self notify("_encstr_921D09D9D9C0090D7275B4");
    wait(var_1);
    self.disabled = undefined;
    self notify("_encstr_A18008BD35E222F01BD0");
  }
}

equipmentempstunvfx() {
  playFXOnTag(scripts\engine\utility::getfx("_encstr_9B12096789A1B13BC3F8E3"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

c4implode(var_0, var_1, var_2) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.5;
  var_2 radiusdamage(var_0, 256, 1200, 600, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9AAE0876FCB7603101DB");
  thread c4_earthquake();
}

resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
}

onlethalequipmentplanted(var_0, var_1, var_2) {
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);

    if(self.plantedlethalequip.size >= level.maxperplayerexplosives) {
      if(istrue(var_2))
        self.plantedlethalequip[0] notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B");
      else
        self.plantedlethalequip[0] deleteexplosive();
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = var_0;
  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;
  level notify("_encstr_88120D27D858FD694191F62D850392");
}

bankingoverlimitwillendot(var_0) {
  var_1 = var_0 getentitynumber();
  level.mines[var_1] = var_0;
}

watchc4altdetonate(var_0) {
  self notify("_encstr_A712138F58DB3BDAE77D3E6D4501C2D440C84F0BC0");
  self endon("_encstr_A712138F58DB3BDAE77D3E6D4501C2D440C84F0BC0");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AC8F0AC94174F85AFA901D30");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var_1 = 0;

      while(self useButtonPressed()) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      var_1 = 0;

      while(!self useButtonPressed() && var_1 < 0.5) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      if(!self.plantedlethalequip.size) {
        return;
      }
      self notify("_encstr_B83B0D87608B574ADB2DC5BD9FD112");
    }

    wait 0.05;
  }
}

watchc4altdetonation() {
  self notify("_encstr_8C0D1503F178BB526EA1C70B5985CAE4F8B83E4B68484E");
  self endon("_encstr_8C0D1503F178BB526EA1C70B5985CAE4F8B83E4B68484E");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_B83B0D87608B574ADB2DC5BD9FD112");
    var_0 = self getcurrentweapon();

    if(var_0.basename != "_encstr_9AAE0876FCB7603101DB")
      c4detonateallcharges();
  }
}

watchc4detonation() {
  self notify("_encstr_B80512FB97C11A585D9A53DFF0B00662693B4535");
  self endon("_encstr_B80512FB97C11A585D9A53DFF0B00662693B4535");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = getcompleteweaponname("_encstr_9AAE0876FCB7603101DB");

  for(;;) {
    self waittillmatch("_encstr_BDE80911CA4B20E0D6FC4B", var_0);
    c4detonateallcharges();
  }
}

c4detonateallcharges() {
  foreach(var_1 in self.plantedlethalequip) {
    if(isDefined(var_1) && var_1.weapon_name == "_encstr_9AAE0876FCB7603101DB") {
      var_1 thread waitanddetonate(0.1);
      scripts\engine\utility::array_remove(self.plantedlethalequip, var_1);
    }
  }

  self notify("_encstr_B6E80AE6BBC14D331DEBF38F", 0);
  waittillframeend;
  self notify("_encstr_AC8F0AC94174F85AFA901D30");
}

waitanddetonate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  waittillenabled();
  self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B");
}

waittillenabled() {
  if(!isDefined(self.disabled)) {
    return;
  }
  self waittill("_encstr_A18008BD35E222F01BD0");
}

clustergrenadeused() {
  var_0 = self.originalowner;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread ownerdisconnectcleanup(var_0);
  var_1 = [];

  for(var_2 = 0; var_2 < 4; var_2++)
    var_1[var_2] = 0.2;

  var_3 = 0;

  foreach(var_5 in var_1)
  var_3 = var_3 + var_5;

  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_7 linkTo(self);
  var_7 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_7 setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
  var_7 thread deathdelaycleanup(self, var_3 + 5);
  var_7 thread ownerdisconnectcleanup(self.owner);
  var_7.threwback = self.threwback;
  var_8 = var_0 scripts\cp\utility::_launchgrenade("_encstr_99D61DC3BDD548D321F29EDF1B9A706F8050A04BF55DD39E52037843475F03", self.origin, (0, 0, 0));
  var_8 linkTo(self);
  var_8 thread deathdelaycleanup(self, var_3);
  var_8 thread ownerdisconnectcleanup(self.owner);
  thread scripts\cp\utility::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self waittill("_encstr_860808CB78E2984063BA", var_9);
  thread clustergrenadeexplode(var_9, var_1, var_0, var_7);
}

clustergrenadeexplode(var_0, var_1, var_2, var_3) {
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_5 = 0;
  var_6 = var_0 + (0, 0, 3);
  var_7 = var_6 + (0, 0, -5);
  var_8 = physics_raycast(var_6, var_7, var_4, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(isDefined(var_8) && var_8.size > 0)
    var_5 = 1;

  var_9 = scripts\engine\utility::ter_op(var_5, (0, 0, 32), (0, 0, 2));
  var_10 = var_0 + var_9;
  var_11 = randomint(90) - 45;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);

  for(var_12 = 0; var_12 < 4; var_12++) {
    var_3.shellshockondamage = scripts\engine\utility::ter_op(var_12 == 0, 1, undefined);
    var_3 radiusdamage(var_0, 256, 800, 400, var_2, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A99213D77C53903D97DB1E01C34FF8C8AFCD277D15");
    var_13 = scripts\engine\utility::ter_op(var_12 < 4, 90 * var_12 + var_11, randomint(360));
    var_14 = scripts\engine\utility::ter_op(var_5, 110, 90);
    var_15 = scripts\engine\utility::ter_op(var_5, 12, 45);
    var_16 = var_14 + randomint(var_15 * 2) - var_15;
    var_17 = randomint(60) + 30;
    var_18 = cos(var_13) * sin(var_16);
    var_19 = sin(var_13) * sin(var_16);
    var_20 = cos(var_16);
    var_21 = (var_18, var_19, var_20) * var_17;
    var_6 = var_10;
    var_7 = var_10 + var_21;
    var_8 = physics_raycast(var_6, var_7, var_4, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

    if(isDefined(var_8) && var_8.size > 0)
      var_7 = var_8[0]["_encstr_BD260953AA97E3F014279D"];

    playFX(scripts\engine\utility::getfx("_encstr_97C21736E45FE379CFBB9938E2250B5977AF4D335083A89137"), var_7);

    switch (var_12) {
      case 0:
        playsoundatpos(var_7, "_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");
        break;
      case 3:
        playsoundatpos(var_7, "_encstr_9589141FB48B48F55FE356192B63A1F06715DF9B2E37");
        break;
      default:
        playsoundatpos(var_7, "_encstr_8689148D635DB9A3ACC9EB2B3C1C36F62359D7DA5AC8");
    }

    wait(var_1[var_12]);
  }
}

deathdelaycleanup(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  wait(var_1);
  self delete();
}

ownerdisconnectcleanup(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self delete();
}

semtexused(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0.originalowner = self;
  var_0 setentityowner(self);
  var_0 setotherent(self);
  var_0 thread semtex_watch_cleanup();
  var_0 thread semtex_watch_fuse();
  var_1 = var_0.owner.name;
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_2);
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_0.origin, "_encstr_92A70ABB8267F5E0D89F6351", var_1);
  var_0 thread grenade_earthquake();
  var_0 explosivehandlemovers(undefined);
}

semtex_watch_fuse() {
  self endon("_encstr_AD75063D571AE108");
  wait 2;
  thread semtex_explode();
}

semtex_explode() {
  thread semtex_delete(0.1);
}

semtex_destroy() {
  thread semtex_delete(0.1);
}

semtex_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  self.exploding = 1;
  wait(var_0);
  self delete();
}

semtex_watch_cleanup() {
  self endon("_encstr_AD75063D571AE108");
  semtex_watch_cleanup_end_early();

  if(isDefined(self))
    thread semtex_destroy();
}

semtex_watch_cleanup_end_early() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;)
    waitframe();
}

canweaponhaveattachment(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponattachmentsbasenames(var_0);

  foreach(var_1 in var_2) {}
}

doesattachmentconflict(var_0, var_1) {
  foreach(var_3 in level.br_pickups.br_pickupconflicts[var_1]) {
    if(attachmentisdefault(var_0))
      continue;
    else {
      var_4 = scripts\cp\utility::attachmentmap_tobase(var_0);

      if(var_4 == var_3)
        return 1;
    }
  }

  return 0;
}

attachmentisdefault(var_0) {
  return isDefined(var_0) && (scripts\engine\utility::string_starts_with(var_0, "_encstr_B21904E4CAD8") || scripts\engine\utility::string_starts_with(var_0, "_encstr_AA5606FD1AF05085") || scripts\engine\utility::string_starts_with(var_0, "_encstr_B69B0589C236B6") || scripts\engine\utility::string_starts_with(var_0, "_encstr_B61904B60BB3") || scripts\engine\utility::string_starts_with(var_0, "_encstr_AF2206AF7DE90BA7") || scripts\engine\utility::string_starts_with(var_0, "_encstr_BAEA09CD8A5F11CF9A9A90") || scripts\engine\utility::string_starts_with(var_0, "_encstr_849208231881C2DF7879"));
}

hasattachmentconflictwithweapon(var_0, var_1) {
  return hasattachmentconflict(getweaponattachments(var_0), var_1);
}

hasattachmentconflict(var_0, var_1) {
  if(var_1 == -1)
    return 1;

  foreach(var_3 in var_0) {
    if(doesattachmentconflict(var_3, var_1))
      return 1;
  }

  return 0;
}

removeattachmentsandgiveweapon(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(self) || !isPlayer(self)) {
    return;
  }
  var_2 = var_1;
  var_3 = self getweaponammoclip(var_2);
  var_4 = self getweaponammostock(var_2);
  var_5 = scripts\cp\utility::getweaponattachmentsbasenames(var_2);

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    if(scripts\engine\utility::array_contains(var_5, var_0[var_6]))
      var_5 = scripts\engine\utility::array_remove(var_5, var_0[var_6]);
  }

  scripts\cp\cp_weapons::_takeweapon(var_2);
  var_7 = scripts\cp\utility::getweaponrootname(var_2.basename);
  var_8 = buildweaponuniqueattachments(var_7, var_5, -1);

  if(isDefined(var_2.attachments)) {
    foreach(var_10 in var_2.attachments)
    var_2 = var_2 withoutattachment(var_10);
  }

  foreach(var_13 in var_8)
  var_2 = var_2 withattachment(var_13);

  self giveweapon(var_2);
  self setweaponammoclip(var_2, var_3);
  self setweaponammostock(var_2, var_4);
  self switchtoweapon(var_2);
}

remove_attachment(var_0, var_1, var_2) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return;
  }
  var_3 = [];
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_2)) {
    if(issameweapon(var_2))
      var_3[var_3.size] = var_2;
    else
      var_3[var_3.size] = asmdevgetallstates(var_2);
  } else
    var_3 = var_1 getweaponslistall();

  foreach(var_7 in var_3) {
    if(var_7 hasattachment(var_0, 1)) {
      var_8 = scripts\cp\utility::getrawbaseweaponname(var_7);
      var_9 = getweaponbasename(var_7);
      var_1 takeweapon(var_7);
      var_10 = getweaponattachments(var_7);

      foreach(var_12 in var_10) {
        if(issubstr(var_12, var_0)) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_12);
          break;
        }
      }

      if(isDefined(level.build_weapon_name_func))
        var_5 = var_1[[level.build_weapon_name_func]](var_9, var_10);

      if(isDefined(var_5)) {
        var_3 = self getweaponslistprimaries();

        foreach(var_2 in var_3) {
          if(issubstr(var_2.basename, var_5.basename)) {
            if(var_2.isalternate) {
              var_9 = getweaponbasename(var_2);

              if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_9)) {
                var_5 = var_5 getaltweapon();
                break;
              }
            }
          }
        }

        var_1 scripts\cp\utility::_giveweapon(var_5, -1, -1, 1);
        var_1 switchtoweapon(var_5);
      }
    }
  }
}

has_weapon_variation(var_0) {
  var_1 = self getweaponslistall();
  var_2 = undefined;

  if(issameweapon(var_0))
    var_2 = var_0.basename;
  else
    var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = scripts\cp\utility::getrawbaseweaponname(var_2);
    var_6 = scripts\cp\utility::getrawbaseweaponname(var_4);

    if(var_5 == var_6)
      return 1;
  }

  return 0;
}

has_weapon_variation_without_attachments(var_0, var_1) {
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    if(var_1 == var_4.basename) {
      var_5 = [];

      foreach(var_7 in var_4.attachments)
      var_5[var_5.size] = scripts\cp\utility::attachmentmap_tobase(var_7);

      foreach(var_10 in var_0) {
        if(scripts\engine\utility::array_contains(var_5, var_10))
          return 0;
        else
          return 1;
      }
    }
  }

  return 0;
}

get_weapon_variation_obj(var_0) {
  var_1 = self getweaponslistall();
  var_2 = [];
  var_3 = undefined;

  if(issameweapon(var_0))
    var_3 = var_0.basename;
  else
    var_3 = var_0;

  foreach(var_5 in var_1) {
    var_6 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_7 = scripts\cp\utility::getrawbaseweaponname(var_5);

    if(var_6 == var_7)
      var_2[var_2.size] = var_5;
  }

  return var_2;
}

buildattachmentmaps() {
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.weaponattachments = [];
  var_0 = [];
  var_1 = 1;

  for(var_2 = tablelookupbyrow("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", var_1, 0); var_2 != "_encstr_B40101"; var_2 = tablelookupbyrow("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", var_1, 0)) {
    if(scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_2))
      var_0[var_0.size] = var_2;

    var_1++;
  }

  var_3 = [];
  var_4 = 1;

  for(var_5 = tablelookupbyrow("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", 0, var_4); var_5 != "_encstr_B40101"; var_5 = tablelookupbyrow("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", 0, var_4)) {
    var_3[var_5] = var_4;
    var_4++;
  }

  level.attachmentmap_basetounique = [];

  foreach(var_2 in var_0) {
    foreach(var_10, var_8 in var_3) {
      var_9 = tablelookup("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", 0, var_2, var_8);

      if(var_9 == "_encstr_B40101") {
        continue;
      }
      if(!isDefined(level.attachmentmap_basetounique[var_2]))
        level.attachmentmap_basetounique[var_2] = [];

      level.attachmentmap_basetounique[var_2][var_10] = var_9;

      if(!isDefined(level.attachmentmap_uniquetobase[var_9])) {
        level.attachmentmap_uniquetobase[var_9] = var_10;
        continue;
      }

      if(level.attachmentmap_uniquetobase[var_9] != var_10) {}
    }
  }

  foreach(var_20, var_13 in level.weaponmapdata) {
    var_14 = getsubstr(var_20, 4);
    var_15 = "_encstr_A6180D78E2C8B8C335E317A3B3AB3E" + var_14 + "_encstr_B4501101DB40BFBAFE0B777F7B2872A66003C3";

    if(!tableexists(var_15)) {
      continue;
    }
    level.weaponattachments[var_20] = [];
    var_1 = 1;
    var_16 = tablelookupbyrow(var_15, var_1, 0);
    var_17 = tablelookupbyrow(var_15, var_1, 1);

    for(var_18 = "_encstr_81190AE02D6813A73FCC124E" + var_14 + "_encstr_AF5214EB0B478EC2C6A16B56E647AF968CCD71D8DCB3"; var_16 != "_encstr_B40101"; var_17 = tablelookupbyrow(var_15, var_1, 1)) {
      if(var_17 != "_encstr_B40101") {
        var_19 = tablelookup(var_18, 0, var_17, 1);

        if(var_19 != "_encstr_B40101")
          level.weaponattachments[var_20][var_19] = var_19;
      }

      var_1++;
      var_16 = tablelookupbyrow(var_15, var_1, 0);
    }
  }

  level.attachmentmap_attachtoperk = [];
  level.carrier_remove_carriable_weapon = [];
  level.carry_ref = [];
  level.carryobjects_onjuggernaut = [];
  var_21 = getattachmentlistuniquenames();

  foreach(var_23 in var_21) {
    var_24 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_23, 2);
    var_25 = scripts\cp\utility::attachmentmap_tobase(var_23);

    if(var_24 != "_encstr_B40101" && isDefined(var_25)) {
      var_26 = level.carry_ref[var_25];

      if(!isDefined(var_26))
        level.carry_ref[var_25] = var_24;
      else if(var_24 != var_26)
        level.carryobjects_onjuggernaut[var_23] = var_24;
    }

    var_27 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_23, 12);

    if(var_27 != "_encstr_B40101")
      level.attachmentmap_attachtoperk[var_23] = var_27;

    var_28 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_23, 13);

    if(var_28 != "_encstr_B40101")
      level.attachmentmap_uniquetoextra[var_23] = var_28;

    var_29 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_23, 9);

    if(var_29 != "_encstr_B40101")
      level.carrier_remove_carriable_weapon[var_23] = var_29;
  }

  level.attachmentmap_conflicts = [];
  var_31 = 1;

  for(var_32 = tablelookupbyrow("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798", var_31, 0); var_32 != "_encstr_B40101"; var_32 = tablelookupbyrow("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798", var_31, 0)) {
    var_33 = 1;

    for(var_34 = tablelookupbyrow("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798", 0, var_33); var_34 != "_encstr_B40101"; var_34 = tablelookupbyrow("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798", 0, var_33)) {
      if(var_32 != var_34) {
        var_35 = tablelookupbyrow("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798", var_31, var_33);
        var_36 = scripts\engine\utility::alphabetize([var_32, var_34]);
        var_37 = var_36[0] + "_encstr_BA4C02DF" + var_36[1];

        if(var_35 == "_encstr_BE07036548" && !isDefined(level.attachmentmap_conflicts[var_37]))
          level.attachmentmap_conflicts[var_37] = 1;
        else if(var_35 != "_encstr_B40101")
          level.attachmentmap_conflicts[var_37] = var_35;
      }

      var_33++;
    }

    var_31++;
  }
}

getattachmentlistuniquenames() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 0, var_1, 4); var_2 != "_encstr_B40101"; var_2 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 0, var_1, 4)) {
    var_0[var_2] = var_2;
    var_1++;
  }

  return var_0;
}

create_zombie_base_to_unique_map(var_0, var_1, var_2, var_3) {
  if(var_0 == "_encstr_BACB074025B01AAA28") {
    foreach(var_5 in var_1) {
      foreach(var_9, var_7 in var_2) {
        var_8 = tablelookup(var_3, 0, var_5, var_7);

        if(var_8 == "_encstr_B40101") {
          continue;
        }
        if(!isDefined(level.attachmentmap_basetounique[var_5]))
          level.attachmentmap_basetounique[var_5] = [];

        if(var_8 == "_encstr_8BBA05185F8B99") {
          level.attachmentmap_basetounique[var_5][var_9] = undefined;
          continue;
        }

        level.attachmentmap_basetounique[var_5][var_9] = var_8;
      }
    }
  }
}

grenade_earthquake(var_0) {
  self notify("_encstr_B634131C229FD5F315ED57E0536AFD3819631192B0");
  self endon("_encstr_B634131C229FD5F315ED57E0536AFD3819631192B0");
  thread endondeath();
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0)
    self waittill("_encstr_860808CB78E2984063BA", var_1);
  else
    var_1 = self.origin;

  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_1);
  earthquake(0.5, 0.75, var_1, 800);

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distancesquared(var_1, var_3.origin) > 360000) {
      continue;
    }
    if(var_3 damageconetrace(var_1))
      var_3 thread dirteffect(var_1);

    var_3 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }
}

c4_earthquake() {
  thread endondeath();
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self waittill("_encstr_860808CB78E2984063BA", var_0);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0);
  earthquake(0.4, 0.75, var_0, 512);

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distance(var_0, var_2.origin) > 512) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread dirteffect(var_0);

    var_2 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }
}

endondeath() {
  self waittill("_encstr_AD75063D571AE108");
  waittillframeend;
  self notify("_encstr_BDF90C4D10A95F47E990CAF2D83B");
}

dirteffect(var_0) {
  self notify("_encstr_B1140B19D2C94715CC662BD83A");
  self endon("_encstr_B1140B19D2C94715CC662BD83A");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = ["_encstr_AD75063D571AE108", "_encstr_B2BE0788BAF573592F"];
  var_7 = self getcurrentweapon();

  if(var_4 > 0 && var_4 > 0.5 && var_7.basename != "_encstr_9AF3124BBB8DAFC94B7B1D3734D2593623FADAC1")
    scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
  else if(abs(var_4) < 0.866) {
    if(var_5 > 0)
      scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
    else
      scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2.0);
  }
}

shellshockondamage(var_0, var_1) {
  if(isflashbanged()) {
    return;
  }
  if(var_0 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_0 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_0 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_0 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_0 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B") {
    if(var_1 > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction)
        self shellshock("_encstr_95DB0A895E650BBC4267E7C9", self.shellshockreduction);
      else
        self shellshock("_encstr_95DB0A895E650BBC4267E7C9", 0.5);
    }
  }
}

isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

waittill_grenade_fire() {
  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0, var_1, var_2, var_3);

    if(isDefined(self.throwinggrenade) && var_1.basename != self.throwinggrenade) {
      continue;
    }
    if(isDefined(var_0)) {
      if(!isDefined(var_0.weapon_obj))
        var_0.weapon_obj = var_1;

      if(!isDefined(var_0.weapon_name))
        var_0.weapon_name = var_1.basename;

      if(!isDefined(var_0.owner))
        var_0.owner = self;

      if(!isDefined(var_0.team))
        var_0.team = self.team;

      if(!isDefined(var_0.ticks) && isDefined(self.throwinggrenade))
        var_0.ticks = scripts\cp\utility::roundup(4 * var_2);
    }

    grenadeinitialize(var_0, var_1, var_2, var_3);

    if(!scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(self.throwndyinggrenade)) {
      self notify("_encstr_8F5712A74BF1DA7151B7490D603A6FF7D733FBBA", var_0, var_1.basename);
      self.throwndyinggrenade = 1;
    }

    if(istrue(var_0.threwback))
      scripts\cp\cp_powers::power_adjustcharges(1, "_encstr_BA7F0830B3A7859B60B0");

    return var_0;
  }
}

grenadestuckto(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    var_0.stuckenemyentity = var_1;
    var_1.stuckbygrenade = var_0;
  } else if(level.teambased && scripts\engine\utility::is_equal(var_1.team, self.team))
    var_0.isstuck = "_encstr_ACFC091AE8AB2FCBE15119";
  else {
    var_3 = undefined;

    if(!isDefined(var_0.weapon_name)) {
      return;
    }
    switch (var_0.weapon_name) {
      case "_encstr_92A70ABB8267F5E0D89F6351":
        var_3 = "_encstr_91860D9BACB63AB2F07DE63AD56CD6";
        break;
      case "_encstr_BA730BF8AFF178988293F158B9":
        var_3 = "_encstr_B40E0E5D2A316ADB653B19B813A3B72C";
        break;
      case "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7":
        var_3 = "_encstr_AAE6199062FE4D01CFDF05F08F5F6B19A63A402B1B9987FB5FC302";
        break;
      case "_encstr_99410C4B48C39AB7D0CD95B769DB":
        var_3 = "_encstr_A9C018A3D0954E5B96E8567D581D8EC2C6AD95937DCD47D5B1B5";
        break;
    }

    var_0.isstuck = "_encstr_88BF06FD784A6393";
    var_0.stuckenemyentity = var_1;
    var_1.stuckbygrenade = var_0;
    self notify("_encstr_844F149F9B026050043F861B63FD882A592F15135F6B");

    if(isPlayer(var_1))
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_A9460F7FBDF1486510D00461F32B4556B0");
  }
}

grenadestucktosplash(var_0, var_1) {
  var_2 = self;

  if(isPlayer(var_1) && isDefined(var_0)) {
    if(isDefined(var_2.owner))
      var_2 = var_2.owner;

    var_2 scripts\cp\cp_hud_message::showsplash(var_0);
  }
}

can_use_attachment(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self getcurrentweapon();

  var_2 = getweaponbasename(var_1);
  var_3 = var_1.classname;
  var_4 = get_possible_attachments_by_weaponclass(var_3, var_2, var_0);

  if(!var_4)
    return 0;

  return 1;
}

add_attachment_to_weapon(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1)) {
    if(issameweapon(var_1))
      var_4 = var_1;
    else
      var_4 = asmdevgetallstates(var_1);
  } else
    var_4 = scripts\cp\utility::getvalidtakeweapon();

  var_5 = getweaponbasename(var_4);
  var_6 = 0;
  var_7 = getweaponattachments(var_4);
  var_8 = scripts\cp\utility::getcurrentcamoname(var_4);
  var_9 = return_weapon_name_with_like_attachments(var_4, var_0, var_7, undefined, var_8);

  if(!isDefined(var_9))
    return 0;

  var_10 = asmdevgetallstates(var_9);

  if(nullweapon(var_10))
    return 0;

  var_11 = var_4.isalternate;

  if(var_10 hasattachment("_encstr_8E5F063CDA2C3BCD", 1))
    var_6 = 1;

  if(isDefined(var_0)) {
    if(!issubstr(var_0, "_encstr_88190407B038")) {
      var_12 = self getweaponammoclip(var_4);
      var_13 = self getweaponammostock(var_4);

      if(var_10 hasattachment("_encstr_AD9C07E0478148252A", 1))
        var_14 = self getweaponammoclip(var_4, "_encstr_A5AD056A019C63");
      else
        var_14 = undefined;

      self takeweapon(var_4);
      scripts\cp\utility::_giveweapon(var_10, undefined, undefined, 1);

      if(var_10 hasattachment("_encstr_8E5F063CDA2C3BCD", 1) && !var_6)
        var_12 = weaponclipsize(var_10);

      self setweaponammoclip(var_10, var_12);
      self setweaponammostock(var_10, var_13);

      if(isDefined(var_14))
        self setweaponammoclip(var_10, var_14, "_encstr_A5AD056A019C63");
    } else {
      self takeweapon(var_4);
      scripts\cp\utility::_giveweapon(var_10, undefined, undefined, 0);
      self givemaxammo(var_10);
    }
  }

  self playlocalsound("_encstr_AF121598727EC9C6FB598BFE3527E8B3E2FAB051BBD505");
  var_15 = self getweaponslistprimaries();

  foreach(var_1 in var_15) {
    if(issubstr(var_1.basename, var_10.basename)) {
      if(var_1.isalternate) {
        var_17 = getweaponbasename(var_1);

        if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_17) || var_11) {
          var_10 = var_10 getaltweapon();
          break;
        }
      }
    }
  }

  if(istrue(var_3))
    return 1;

  if(istrue(var_2))
    self switchtoweaponimmediate(var_10);
  else
    self switchtoweapon(var_10);

  return 1;
}

isforgefreezeweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0)) {
    if(var_0 == "_encstr_B6271396DDCDD766DB27D9AC3393B256F4CA7D9EAD" || var_0 == "_encstr_AF5918D3773301C44FCB0971B2030D9838FD378D0581C09FDB17" || var_0 == "_encstr_A959185ABBDCEB997B279D5699E4592BD3B2D7A75BFAE02C38C8" || var_0 == "_encstr_8AFE12BA923B5DC078856737ADE510157B79D063")
      return 1;
  }

  return 0;
}

issteeldragon(var_0) {
  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1))
    return 0;

  return var_1 == "_encstr_A9D113B477E67DE6E859B26346E42C767BDCAF4FAD";
}

is_perk_attachment(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 == "_encstr_92B50AC8BDABC4D8AC8E580E")
    return 1;

  return 0;
}

is_arcane_attachment(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0, "_encstr_8719040B93AD"))
    return 1;

  if(issubstr(var_0, "_encstr_BD2A077E6B3841FAA5"))
    return 1;

  return 0;
}

is_mod_attachment(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0, "_encstr_971904693082"))
    return 1;

  return 0;
}

is_default_attachment(var_0, var_1) {
  var_2 = scripts\cp\utility::weaponattachdefaultmap(var_1);

  if(!isDefined(var_2) || var_2.size < 1)
    return 0;

  foreach(var_4 in var_2) {
    if(var_0 == var_4)
      return 1;
  }

  return 0;
}

is_pap_attachment(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0, "_encstr_88190407B038"))
    return 1;

  return 0;
}

get_possible_attachments_by_weaponclass(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_1))
    return 0;

  if(!isDefined(var_2))
    return 0;

  var_3 = [];
  var_4 = scripts\cp\utility::getbaseweaponname(var_1);

  if(isDefined(level.attachmentmap_basetounique[var_4])) {
    if(isDefined(level.attachmentmap_basetounique[var_4][var_2])) {
      if(level.attachmentmap_basetounique[var_4][var_2] != "_encstr_8BBA05185F8B99")
        return 1;
      else
        return 0;
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_0])) {
    if(isDefined(level.attachmentmap_basetounique[var_0][var_2])) {
      if(level.attachmentmap_basetounique[var_0][var_2] != "_encstr_8BBA05185F8B99")
        return 1;
      else
        return 0;
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_4])) {
    var_5 = getarraykeys(level.attachmentmap_basetounique[var_4]);

    foreach(var_7 in var_5) {
      if(level.attachmentmap_basetounique[var_4][var_7] == var_2) {
        if(level.attachmentmap_basetounique[var_4][var_7] != "_encstr_8BBA05185F8B99")
          return 1;
        else
          return 0;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_0])) {
    var_5 = getarraykeys(level.attachmentmap_basetounique[var_0]);

    foreach(var_7 in var_5) {
      if(level.attachmentmap_basetounique[var_0][var_7] == var_2) {
        if(level.attachmentmap_basetounique[var_0][var_7] != "_encstr_8BBA05185F8B99")
          return 1;
        else
          return 0;
      }
    }
  }

  return 0;
}

return_weapon_name_with_like_attachments(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    if(issameweapon(var_0))
      var_5 = var_0;
    else
      var_5 = asmdevgetallstates(var_0);
  } else
    var_5 = self getcurrentweapon();

  var_6 = getweaponbasename(var_5);
  var_7 = scripts\cp\utility::get_weapon_variant_id(self, var_5);
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = undefined;
  var_13 = [];
  var_14 = 7;
  var_15 = [];
  var_16 = 1;
  var_17 = [];
  var_18 = 1;
  var_19 = [];
  var_20 = 1;
  var_21 = [];
  var_22 = 1;
  var_23 = [];
  var_24 = 1;
  var_25 = [];
  var_26 = 12;
  var_27 = var_5.classname;

  if(var_5 hasattachment("_encstr_8E5F063CDA2C3BCD", 1))
    var_9 = 1;

  var_28 = get_possible_attachments_by_weaponclass(var_27, var_6, var_1);

  if(!var_28 && isDefined(var_1)) {
    if(!istrue(var_3))
      scripts\cp\utility::setlowermessage("_encstr_A1ED0CD847AE3307A2B39D2F4E0A", &"_encstr_AC4B1697E174F051090BA5AD675F88C79D092B73C9EF0B38", 3);

    return undefined;
  }

  if(!isDefined(var_2))
    var_2 = getweaponattachments(var_5);

  if(scripts\cp\utility::has_zombie_perk("_encstr_B6E3170395B6D0F759E7237BFBA649C93D4AFC0F818925B1C5")) {
    if(get_possible_attachments_by_weaponclass(var_27, var_6, "_encstr_92B50AC8BDABC4D8AC8E580E"))
      var_2[var_2.size] = "_encstr_92B50AC8BDABC4D8AC8E580E";
  }

  if(isDefined(var_1)) {
    if(weaponclass(var_0) == "_encstr_A1100738A33A638123") {
      if(issubstr(var_1, "_encstr_99F70A2C27AD5E2B1BB1DE77")) {
        foreach(var_30 in var_2) {
          if(issubstr(var_30, "_encstr_847206E6D616E4E8"))
            var_2 = scripts\engine\utility::array_remove(var_2, var_30);
        }
      }
    }
  }

  var_2 = scripts\engine\utility::array_remove_duplicates(var_2);
  var_2 = scripts\engine\utility::array_removeundefined(var_2);

  if(var_2.size > 0 && var_2.size <= var_26) {
    foreach(var_33 in var_2) {
      if(is_pap_attachment(var_33)) {
        if(var_17.size < var_18) {
          var_17[var_17.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(is_arcane_attachment(var_33)) {
        if(var_23.size < var_24) {
          var_23[var_23.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(is_mod_attachment(var_33)) {
        if(var_19.size < var_20) {
          var_19[var_19.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(is_default_attachment(var_33, scripts\cp\utility::getweaponrootname(var_6))) {
        if(var_21.size < var_22) {
          var_21[var_21.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(is_perk_attachment(var_33)) {
        if(var_15.size < var_16) {
          var_15[var_15.size] = var_33;
          var_25[var_25.size] = var_33;
        } else
          continue;

        continue;
      }

      if(var_13.size < var_14) {
        var_13[var_13.size] = var_33;
        var_25[var_25.size] = var_33;
        continue;
      }

      continue;
    }
  }

  if(isDefined(var_1)) {
    var_35 = scripts\cp\utility::attachmentmap_tobase(var_1);

    if(isDefined(var_35) && var_35 != "_encstr_8BBA05185F8B99") {
      for(var_36 = 0; var_36 < var_25.size; var_36++) {
        var_37 = scripts\cp\utility::attachmentmap_tobase(var_25[var_36]);

        if(var_37 == var_35) {
          var_25[var_36] = var_1;
          var_8 = 1;
          break;
        }
      }
    }

    var_38 = scripts\cp\utility::getattachmenttype(var_1);

    if(isDefined(var_38) && var_38 != "_encstr_8BBA05185F8B99") {
      if(!var_8) {
        if(is_pap_attachment(var_1)) {
          if(var_17.size < var_18) {
            var_17[var_17.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_17[var_17.size] = var_1;
                var_25[var_36] = var_1;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(is_arcane_attachment(var_1)) {
          if(var_23.size < var_24) {
            var_23[var_23.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_23[var_15.size] = var_1;
                var_25[var_36] = var_1;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(is_perk_attachment(var_1)) {
          if(var_15.size < var_16) {
            var_15[var_15.size] = var_1;
            var_25[var_25.size] = var_1;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_15[var_15.size] = var_1;
                var_25[var_36] = var_1;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(var_13.size < var_14) {
          var_13[var_13.size] = var_1;
          var_25[var_25.size] = var_1;
        } else {
          for(var_36 = 0; var_36 < var_25.size; var_36++) {
            var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

            if(var_39 == var_38) {
              var_13[var_13.size] = var_1;
              var_25[var_36] = var_1;
              var_8 = 1;
              break;
            }
          }

          if(!var_8)
            return undefined;
        }
      } else if(is_perk_attachment(var_1)) {
        var_17[var_17.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(is_pap_attachment(var_1)) {
        var_15[var_15.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(is_arcane_attachment(var_1)) {
        var_23[var_23.size] = var_1;
        var_25[var_25.size] = var_1;
      } else {
        var_13[var_13.size] = var_1;
        var_25[var_25.size] = var_1;
      }
    } else if(isDefined(var_1)) {
      if(is_perk_attachment(var_1)) {
        var_15[var_15.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(is_pap_attachment(var_1)) {
        var_17[var_17.size] = var_1;
        var_25[var_25.size] = var_1;
      } else if(is_arcane_attachment(var_1)) {
        var_23[var_23.size] = var_1;
        var_25[var_25.size] = var_1;
      } else {
        var_13[var_13.size] = var_1;
        var_25[var_25.size] = var_1;
      }
    }
  }

  var_40 = scripts\cp\utility::getweaponrootname(var_6);
  var_41 = isDefined(self.weapon_build_models[scripts\cp\utility::getrawbaseweaponname(var_5)]);

  if(!isDefined(var_4) && var_41)
    var_10 = scripts\cp\utility::getweaponcamo(var_40);
  else
    var_10 = var_4;

  if(var_41) {
    var_42 = 0;

    foreach(var_30 in var_25) {
      if(issubstr(var_30, "_encstr_BE91055A80D60F")) {
        var_42 = 1;
        var_12 = undefined;
        break;
      }
    }

    if(!var_42)
      var_12 = scripts\cp\utility::getweaponcosmeticattachment(var_40);

    var_11 = scripts\cp\utility::getweaponreticle(var_40);
    var_45 = scripts\cp\utility::getweaponpaintjobid(var_40);
  } else {
    var_12 = undefined;
    var_11 = undefined;
    var_45 = undefined;
  }

  foreach(var_30 in var_25) {
    if(issubstr(var_30, "_encstr_BD2A077E6B3841FAA5") || issubstr(var_30, "_encstr_8719040B93AD")) {
      foreach(var_48 in var_25) {
        if(var_30 == var_48) {
          continue;
        }
        if(issubstr(var_48, "_encstr_BE91055A80D60F"))
          var_25 = scripts\engine\utility::array_remove(var_25, var_48);
      }

      var_12 = undefined;
    }
  }

  var_51 = scripts\cp\utility::mpbuildweaponname(var_40, var_25, var_10, var_11, var_7, self getentitynumber(), self.clientid, var_45, var_12);

  if(isDefined(var_51))
    return var_51;
  else
    return createheadicon(var_5);
}

getattachmenttypeslist(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponattachmentarrayfromstats(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = scripts\cp\utility::getattachmenttype(var_5);

    if(isDefined(var_1) && scripts\cp\utility::listhasattachment(var_1, var_5)) {
      continue;
    }
    if(!isDefined(var_3[var_6]))
      var_3[var_6] = [];

    var_7 = var_3[var_6];
    var_7[var_7.size] = var_5;
    var_3[var_6] = var_7;
  }

  return var_3;
}

getattachmentlistbasenames() {
  var_0 = [];
  var_1 = ["_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", "_encstr_B6C91AC60E5EB1C1BE16A347C26CA1B559733AE858268DB2E21B373B"];

  foreach(var_3 in var_1) {
    var_4 = 0;

    for(var_5 = tablelookup(var_3, 0, var_4, 5); var_5 != "_encstr_B40101"; var_5 = tablelookup(var_3, 0, var_4, 5)) {
      var_6 = tablelookup(var_3, 0, var_4, 2);

      if(var_6 != "_encstr_8BBA05185F8B99" && !scripts\engine\utility::array_contains(var_0, var_5))
        var_0[var_0.size] = var_5;

      var_4++;
    }
  }

  return var_0;
}

getweaponattachmentarray(var_0) {
  var_1 = [];
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_3 = scripts\cp\utility::coop_getweaponclass(var_0);

  if(isDefined(level.attachmentmap_basetounique[var_2]))
    var_1 = scripts\engine\utility::array_combine(var_1, level.attachmentmap_basetounique[var_2]);

  if(isDefined(level.attachmentmap_basetounique[var_3]))
    var_1 = scripts\engine\utility::array_combine(var_1, level.attachmentmap_basetounique[var_3]);

  return var_1;
}

isvalidzombieweapon(var_0) {
  if(!isDefined(level.weaponrefs)) {
    level.weaponrefs = [];

    foreach(var_2 in level.weaponlist)
    level.weaponrefs[createheadicon(var_2)] = 1;
  }

  if(isDefined(level.weaponrefs[var_0]))
    return 1;

  return 0;
}

setweaponlaser_internal() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A30711DF7BF8551B910AAF6F778A3152FA879B");
  self.perkweaponlaseron = 0;
  var_0 = self getcurrentweapon();

  for(;;) {
    setweaponlaser_waitforlaserweapon(var_0);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1.0);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      disableweaponlaser();
    }
  }
}

setweaponlaser_waitforlaserweapon(var_0) {
  for(;;) {
    if(isDefined(var_0) && (var_0.basename == "_encstr_97B60B071863F71A7306699DF7" || var_0.basename == "_encstr_B6090E3AFBF261AA88BBC37B3AB7D7E3")) {
      break;
    }

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);
  }
}

setweaponlaser_monitorads() {
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

  for(;;) {
    if(!isDefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0) {
      if(self playerads() > 0.6) {
        if(self.perkweaponlaseron == 1) {
          self.perkweaponlaseron = 0;
          disableweaponlaser();
        }
      } else if(self.perkweaponlaseron == 0) {
        self.perkweaponlaseron = 1;
        enableweaponlaser();
      }
    }

    waitframe();
  }
}

setweaponlaser_monitorweaponswitchstart(var_0) {
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

  for(;;) {
    self waittill("_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");
    childthread setweaponlaser_onweaponswitchstart(var_0);
  }
}

setweaponlaser_onweaponswitchstart(var_0) {
  self notify("_encstr_9B9B23B30B60135F7FDB2A026447CF5788975726F74026531070E19B2825B74CE979D1A219");
  self endon("_encstr_9B9B23B30B60135F7FDB2A026447CF5788975726F74026531070E19B2825B74CE979D1A219");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    disableweaponlaser();
  }

  wait(var_0);
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    enableweaponlaser();
  }
}

enableweaponlaser() {
  if(!isDefined(self.weaponlasercalls))
    self.weaponlasercalls = 0;

  self.weaponlasercalls++;
  self laseron();
}

disableweaponlaser() {
  self.weaponlasercalls--;

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
  }
}

ondetonateexplosive(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread cleanupexplosivesondeath();
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B");

  if(isDefined(var_0))
    self.owner notify(var_0, 1);
  else
    self.owner notify("_encstr_9A730F38DBDD59C9B9FA8D43F5EAE65932", 1);

  self detonate(self.owner);
}

cleanupexplosivesondeath() {
  self endon("_encstr_829012BF09C0C5DB2559F7179BD5F2282091B503");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self getentitynumber();
  var_1 = self.killcament;
  var_2 = self.trigger;
  var_3 = self.sensor;
  self waittill("_encstr_AD75063D571AE108");
  cleanupequipment(var_0, var_1, var_2, var_3);
}

cleanupequipment(var_0, var_1, var_2, var_3) {
  if(isDefined(self.weapon_name)) {
    if(self.weapon_name == "_encstr_9AAE0876FCB7603101DB")
      self.owner notify("_encstr_B6E80AE6BBC14D331DEBF38F", 0);
    else if(self.weapon_name == "_encstr_8C5A1231DEEA37D82D9BD9F5312BA33AE5AFADC1")
      self.owner notify("_encstr_96AD1626B7BA738DB4E69DFA89AC3AE8CBF5AEC13285E895", 0);
    else if(self.weapon_name == "_encstr_81DD0FCD8EB436AD97F5DA2DDCACFADA07")
      self.owner notify("_encstr_B63D13D673FAAF081927384BFB5DC6CB131F47DD8F", 0);
    else if(self.weapon_name == "_encstr_A14A0DD37BFF6FA915219DF36F7D98")
      self.owner notify("_encstr_919711019ABC60706F42CD6949679FB8D6F4BB", 0);
    else if(self.weapon_name == "_encstr_B20A10E34652C7A1BFF832BA5881674F882F")
      self.owner notify("_encstr_A9441E13ABF3C566C8A318A2D38A485931A027B0CAB9E739388F102A0CFF8F80", 0);
  }

  if(isDefined(var_0))
    level.mines[var_0] = undefined;

  if(isDefined(var_1))
    var_1 delete();

  if(isDefined(var_2))
    var_2 delete();

  if(isDefined(var_3))
    var_3 delete();
}

monitordamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_5))
    var_5 = 0;

  self setCanDamage(1);
  self.health = 9999999;
  self.maxhealth = var_0;
  self.damagetaken = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  for(var_6 = 1; var_6; var_6 = monitordamageoneshot(var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_20, var_1, var_2, var_3, var_4)) {
    self waittill("_encstr_B2BE0788BAF573592F", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20);

    if(var_5)
      self playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");

    if(isDefined(self.helitype) && self.helitype == "_encstr_A3780B731385FBD498E1FC0219") {
      if(!isDefined(self.attackers))
        self.attackers = [];

      var_21 = "_encstr_B40101";

      if(isDefined(var_8) && isPlayer(var_8))
        var_21 = var_8 scripts\cp\utility::getuniqueid();

      if(isDefined(self.attackers[var_21]))
        self.attackers[var_21] = self.attackers[var_21] + var_7;
      else
        self.attackers[var_21] = var_7;
    }
  }
}

monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isDefined(self))
    return 0;

  if(isDefined(var_1) && !scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_1)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506") {} else
      return 1;
  }

  var_15 = var_0;

  if(isDefined(var_9)) {
    if(non_player_should_ignore_damage(var_1, var_9, var_10, var_4))
      return 1;
  }

  var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);

  if(!isDefined(var_13))
    var_13 = scripts\cp\cp_damage::modifydamage;

  var_15 = self[[var_13]](var_16);

  if(var_15 <= 0)
    return 1;

  self.wasdamaged = 1;
  self.damagetaken = self.damagetaken + var_15;
  self.health = 2147483647;

  if(istrue(var_14))
    scripts\cp\utility::killstreakhit(var_1, var_9, self, var_4, var_15);

  if(isDefined(var_1)) {
    if(isPlayer(var_1))
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback(var_11);
  }

  if(self.damagetaken >= self.maxhealth) {
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);
    self thread[[var_12]](var_16);
    return 0;
  }

  return 1;
}

non_player_should_ignore_damage(var_0, var_1, var_2, var_3) {
  if(non_player_should_ignore_damage_signature(var_0, var_1, var_2, var_3))
    return 1;

  if(isDefined(var_1.basename)) {
    if(var_3 != "_encstr_8DED0A21C79B660BC7588981") {
      switch (var_1.basename) {
        case "_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A":
        case "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B":
          return 1;
      }
    }

    if(var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83") {
      switch (var_1.basename) {
        case "_encstr_81430B218B3F7018458997D78A":
        case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
        case "_encstr_9AAE0876FCB7603101DB":
        case "_encstr_99410C4B48C39AB7D0CD95B769DB":
        case "_encstr_92A70ABB8267F5E0D89F6351":
          return 1;
      }
    } else {
      switch (var_1.basename) {
        case "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB":
        case "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18":
        case "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1":
        case "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E":
        case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
        case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
        case "_encstr_B8D30758E3EE7827BA":
          return 1;
      }
    }
  }

  return 0;
}

non_player_should_ignore_damage_signature(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.ignoredamagesignatures))
    return 0;

  if(isDefined(var_1) && isstring(var_1))
    var_1 = getcompleteweaponname(var_1);

  foreach(var_5 in self.ignoredamagesignatures) {
    if(!isDefined(var_5))
      return 0;

    if(var_5.checkattacker) {
      if(!isDefined(var_5.attacker)) {
        non_player_remove_ignore_damage_signature(var_5.id);
        continue;
      } else if(!isDefined(var_0))
        continue;
      else if(var_0 != var_5.attacker)
        continue;
    }

    if(var_5.checkobjweapon) {
      if(!isDefined(var_1) || nullweapon(var_1))
        continue;
      else if(var_1 != var_5.objweapon)
        continue;
    }

    if(var_5.checkinflictor) {
      if(!isDefined(var_5.inflictor)) {
        non_player_remove_ignore_damage_signature(var_5.id);
        continue;
      } else if(!isDefined(var_2))
        continue;
      else if(var_2 != var_5.inflictor)
        continue;
    }

    if(var_5.checkmeansofdeath) {
      if(!isDefined(var_3))
        continue;
      else if(var_3 != var_5.meansofdeath)
        continue;
    }

    return 1;
  }

  return 0;
}

non_player_remove_ignore_damage_signature(var_0) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }
  self.ignoredamagesignatures[var_0] = undefined;
}

non_player_add_ignore_damage_signature(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.ignoredamageid))
    self.ignoredamageid = 0;

  if(!isDefined(self.ignoredamagesignatures))
    self.ignoredamagesignatures = [];

  var_4 = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(var_1) && isstring(var_1))
    var_1 = getcompleteweaponname(var_1);

  var_5 = spawnStruct();
  var_5.id = var_4;
  var_5.attacker = var_0;
  var_5.objweapon = var_1;
  var_5.inflictor = var_2;
  var_5.meansofdeath = var_3;
  var_5.checkattacker = isDefined(var_0);
  var_5.checkobjweapon = isDefined(var_1) && !nullweapon(var_1);
  var_5.checkinflictor = isDefined(var_2);
  var_5.checkmeansofdeath = isDefined(var_3);
  self.ignoredamagesignatures[var_4] = var_5;
  return var_4;
}

explosivehandlemovers(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.linkparent = var_0;
  var_2.deathoverridecallback = ::movingplatformdetonate;
  var_2.endonstring = "_encstr_AD75063D571AE108";

  if(!isDefined(var_1) || !var_1)
    var_2.invalidparentoverridecallback = scripts\cp\cp_movers::moving_platform_empty_func;

  thread scripts\cp\cp_movers::handle_moving_platforms(var_2);
}

movingplatformdetonate(var_0) {
  if(!isDefined(var_0.lasttouchedplatform) || !isDefined(var_0.lasttouchedplatform.destroyexplosiveoncollision) || var_0.lasttouchedplatform.destroyexplosiveoncollision)
    self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B");
}

makeexplosiveusable() {
  if(self.owner scripts\cp_mp\utility\player_utility::_isalive()) {
    self setotherent(self.owner);
    self.trigger = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin + getexplosiveusableoffset());
    self.trigger.owner = self;
    thread equipmentwatchuse(self.owner, 1);
  }
}

equipmentwatchuse(var_0, var_1) {
  self notify("_encstr_913712386F3F41C8D2F7E5B92B87EBBF1BD7C388");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_913712386F3F41C8D2F7E5B92B87EBBF1BD7C388");
  self.trigger setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self.trigger scripts\cp\cp_equipment::setexplosiveusablehintstring(self.weapon_name);
  self.trigger scripts\cp\utility::setselfusable(var_0);
  self.trigger thread scripts\cp\utility::notusableforjoiningplayers(var_0);

  if(isDefined(var_1) && var_1)
    thread updatetriggerposition();

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    var_0 notify("_encstr_9A3C117B6B0602C5284EC7CA23C808BAED8D93", self.weapon_name);
    var_0 setweaponammostock(self.weapon_name, var_0 getweaponammostock(self.weapon_name) + 1);
    deleteexplosive();
    self notify("_encstr_AD75063D571AE108");
  }
}

updatetriggerposition() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(isDefined(self) && isDefined(self.trigger)) {
      self.trigger.origin = self.origin + getexplosiveusableoffset();

      if(isDefined(self.bombsquadmodel))
        self.bombsquadmodel.origin = self.origin;
    } else
      return;

    wait 0.05;
  }
}

deleteexplosive(var_0) {
  if(isDefined(self)) {
    if(isDefined(self.deletefunc)) {
      self thread[[self.deletefunc]]();
      self notify("_encstr_829012BF09C0C5DB2559F7179BD5F2282091B503");
    } else {
      var_1 = self getentitynumber();
      var_2 = self.killcament;
      var_3 = self.trigger;
      var_4 = self.sensor;
      cleanupequipment(var_1, var_2, var_3, var_4);
      self notify("_encstr_829012BF09C0C5DB2559F7179BD5F2282091B503");
      self delete();
    }
  }
}

ontacticalequipmentplanted(var_0, var_1, var_2) {
  var_0.equipmentref = var_1;
  var_0.deletefunc = var_2;
  var_0.planted = 1;

  if(!istrue(var_0.issuper)) {
    if(self.plantedtacticalequip.size) {
      self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);

      if(self.plantedtacticalequip.size && self.plantedtacticalequip.size >= getmaxplantedtacticalequip(self))
        self.plantedtacticalequip[0] deleteexplosive();
    }

    self.plantedtacticalequip[self.plantedtacticalequip.size] = var_0;
  }

  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;
  level notify("_encstr_88120D27D858FD694191F62D850392");
}

getmaxplantedtacticalequip(var_0) {
  var_1 = 0;
  var_1 = 4;
  return var_1;
}

equipmentdeathvfx(var_0) {
  var_1 = spawnfx(scripts\engine\utility::getfx("_encstr_861E11938B2350E0A0598A7D97C053EF155417"), self.origin);
  triggerfx(var_1);

  if(!isDefined(var_0) || var_0 == 0)
    self playSound("_encstr_86630F6EACB91DC92FFAAC1E1C8DBD8CAC");

  var_1 thread scripts\cp\utility::delayentdelete(1);
}

equipmentdeletevfx() {
  var_0 = spawnfx(scripts\engine\utility::getfx("_encstr_8B4615CB407F5F8FF1039D99196857A31DFD52C2E8C51B"), self.origin);
  triggerfx(var_0);
  self playSound("_encstr_BDA11887DF79028B02DCD893ABE0B00820224FFB209A10D80E4B");
  var_0 thread scripts\cp\utility::delayentdelete(1);
}

monitordisownedequipment(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A6("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 deleteexplosive();
}

isprimaryweapon(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return 0;

  if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  if(weaponinventorytype(var_0) != "_encstr_BA7F0830B3A7859B60B0")
    return 0;

  switch (weaponclass(var_0)) {
    case "_encstr_BE1904DCDA9D":
    case "_encstr_8D940738966ED1DB8D":
    case "_encstr_850707F7E5833355B8":
    case "_encstr_A1100738A33A638123":
    case "_encstr_BE0703A54C":
    case "_encstr_965306392D3336B2":
    case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
      return 1;
    default:
      return 0;
  }
}

getexplosiveusableoffset() {
  var_0 = anglestoup(self.angles);
  return 10 * var_0;
}

isknifeonly(var_0) {
  var_1 = getweaponbasename(var_0);
  return issubstr(var_1, "_encstr_A59306426009CA07");
}

is_incompatible_weapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  if(isDefined(level.ammoincompatibleweaponslist)) {
    if(scripts\engine\utility::array_contains(level.ammoincompatibleweaponslist, var_1))
      return 1;
  }

  return 0;
}

isbulletweapon(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return 0;

  if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  if(scripts\cp\utility::isriotshield(var_0) || isknifeonly(var_0))
    return 0;

  if(isDefined(var_0.inventorytype) && var_0.inventorytype == "_encstr_A6F50BE0BADBF520E957EDF159")
    return 0;

  switch (weaponclass(var_0)) {
    case "_encstr_BE1904DCDA9D":
    case "_encstr_8D940738966ED1DB8D":
    case "_encstr_850707F7E5833355B8":
    case "_encstr_A1100738A33A638123":
    case "_encstr_BE0703A54C":
    case "_encstr_965306392D3336B2":
      return 1;
    default:
      return 0;
  }
}

is_explosive_kill(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_9AAB15F4EDD626A52BF5C29CB6C2EC2B3223B737F55BC1":
    case "_encstr_8AFE12BA923B5DC078856737ADE510157B79D063":
    case "_encstr_BE7612A2731819435BD7FF939B702A5408FE98AD":
    case "_encstr_8B76125B2A543086C2379FBDF78AC7A0F549ADB3":
    case "_encstr_AACD13E8A1E47BDD4B9BECDACDA5332B6C43F5B5C1":
    case "_encstr_A99213D77C53903D97DB1E01C34FF8C8AFCD277D15":
    case "_encstr_BDA70A2F5F1AF5F8A009AA40":
    case "_encstr_9AAE0876FCB7603101DB":
    case "_encstr_914A1099390B3BFA9DC9B2DC16232BFA9E6B":
    case "_encstr_92A70ABB8267F5E0D89F6351":
      return 1;
    default:
      return 0;
  }
}

get_weapon_level(var_0) {
  if(!isPlayer(self))
    return int(1);

  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  if(isDefined(self.pap[var_1]))
    return self.pap[var_1].lvl;

  var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);

  if(isDefined(self.pap[var_2]))
    return self.pap[var_2].lvl;

  return int(1);
}

can_upgrade(var_0, var_1) {
  if(!isDefined(level.pap))
    return 0;

  if(isDefined(level.max_pap_func))
    return [[level.max_pap_func]](var_0, var_1);

  if(isDefined(var_0))
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_0);
  else
    return 0;

  if(!isDefined(var_2))
    return 0;

  if(!isDefined(level.pap[var_2])) {
    var_3 = getsubstr(var_2, 0, var_2.size - 1);

    if(!isDefined(level.pap[var_3]))
      return 0;
  }

  if(istrue(var_1) && isDefined(self.pap[var_2]) && self.pap[var_2].lvl <= min(level.pap_max + 1, 2))
    return 1;

  if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl >= level.pap_max)
    return 0;
  else
    return 1;
}

get_pap_camo(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_1)) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_1))
      var_3 = undefined;
    else if(isDefined(level.pap_1_camo) && isDefined(var_0) && var_0 == 2)
      var_3 = level.pap_1_camo;
    else if(isDefined(level.pap_2_camo) && isDefined(var_0) && var_0 == 3)
      var_3 = level.pap_2_camo;

    switch (var_1) {
      case "_encstr_AB7E09E2881E27B4C85DA4":
        var_2 = "_encstr_B4B615704BF3FFC9EF23E66B07BBF13708724940C2FA9B";
        var_3 = "_encstr_8392077BDB70C5EA3F";
        break;
      case "_encstr_87D80B1A6182E9DF5DDD54432B":
        var_2 = "_encstr_A5A11796BBDCF599C21BB25B2B1B1DAC93FAA7ADD738B00726";
        var_3 = "_encstr_869207668E020F8BFA";
        break;
      case "_encstr_82BB0BE8BF89C85EA32BE9C3DB":
        var_2 = "_encstr_BE65170FB77458F3105A9FD7EBB09BBD08A60269EF03D078C6";
        var_3 = "_encstr_9B92076C2CD67B91C4";
        break;
      case "_encstr_92C90C99ED393B95339395AC3DCA":
        if(var_0 == 2)
          var_2 = "_encstr_AF5918D3773301C44FCB0971B2030D9838FD378D0581C09FDB17";
        else if(var_0 == 3)
          var_2 = "_encstr_A959185ABBDCEB997B279D5699E4592BD3B2D7A75BFAE02C38C8";

        var_4 = 1;
        break;
      case "_encstr_961904BF105A":
        if(var_0 == 2)
          var_2 = "_encstr_A90A1071F7A2C9A71B81C19BE8E09B3EF0E3";
        else if(var_0 == 3)
          var_2 = "_encstr_A20A1003CF665603D89A290832391929D312";

        var_4 = 1;
        break;
      case "_encstr_B62609371A9C594619569C":
        var_2 = "_encstr_8A6F15B4EE73BECDD04E2B2323599CBE4FADBE83160789";
        var_3 = "_encstr_8B92075E37537AA2F3";
        break;
    }
  }

  return var_3;
}

validate_current_weapon(var_0, var_1, var_2) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_2)]))
    var_2 = level.weapon_upgrade_path[getweaponbasename(var_2)];
  else if(isDefined(var_1)) {
    switch (var_1) {
      case "_encstr_AF1904F3CFA8":
        if(var_0 == 2)
          var_2 = "_encstr_BE63160FB774588380BA51FBEF189FBDB8A619E3D5BFB078";
        else if(var_0 == 3)
          var_2 = "_encstr_BE63160FB774588380BA51FBEF189FBDB8A619E3D5BFB078";

        break;
      case "_encstr_A77205F710E016":
        if(var_0 == 2)
          var_2 = "_encstr_8D7511B98FA389CCA2B1776680E853AB47C8EB";
        else if(var_0 == 3)
          var_2 = "_encstr_8D7511B98FA389CCA2B1776680E853AB47C8EB";

        break;
      case "_encstr_B1CB0859917FF833E352":
        if(var_0 == 2)
          var_2 = "_encstr_999B0FC47322C7423F4F23EF99D5A93DC0";
        else if(var_0 == 3)
          var_2 = "_encstr_999B0FC47322C7423F4F23EF99D5A93DC0";

        break;
      case "_encstr_A6F307234BEFF26827":
        if(var_0 == 2)
          var_2 = "_encstr_83EA1297DFB4D95BA030CC57890192F2ED770F6B";
        else if(var_0 == 3)
          var_2 = "_encstr_83EA1297DFB4D95BA030CC57890192F2ED770F6B";

        break;
      case "_encstr_961904BF105A":
        if(var_0 == 2)
          var_2 = "_encstr_A90A1071F7A2C9A71B81C19BE8E09B3EF0E3";
        else if(var_0 == 3)
          var_2 = "_encstr_A20A1003CF665603D89A290832391929D312";

        break;
      case "_encstr_ABCC07DA161D16E62C":
        if(var_0 == 2)
          var_2 = "_encstr_BAA91358AB4F81CA925B534527598AA88FC2C1F342";
        else if(var_0 == 3)
          var_2 = "_encstr_95A9135ADDDCBE6D0B47C2B92CFA4FB6FA8385388C";

        break;
      case "_encstr_87910A37ABDC8DA1EA1B6D6E":
        if(var_0 == 2)
          var_2 = "_encstr_99B71651D782E9FBFD8062DACBDED75A6955DD9F31E8EACE";
        else if(var_0 == 3)
          var_2 = "_encstr_8BB7168017FF2E1DEB2D1E93C3A25F132F8B38B9F341039D";

        break;
      default:
        return var_2;
    }
  }

  return var_2;
}

watchplayermelee() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_83470C2D85B1F9E7FEDDF40887A4", var_0);
    var_1 = var_0.basename;

    if(self.meleekill == 0) {
      if(var_1 == "_encstr_965013B4EEB9AF33969BE8DC7D9ED6FAC69C58E656" || var_1 == "_encstr_A7EA14D79FF4990E28334B92AEE85DD125ED7F7707F0" || var_1 == "_encstr_9A681384F78327A02DAB65D71E735031FF4BB9F805" || var_1 == "_encstr_A31913D2BBCD7D33D26EE8DCD79EADD78ED23B5993") {
        if(self.kung_fu_vo == 0) {
          self.kung_fu_vo = 1;
          thread scripts\cp\cp_vo::try_to_play_vo("_encstr_87CD0CB595D82B56EB0E5D371BD0", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_9ACC05B41B7F32", 1, 0, 0, 1);
          thread kung_fu_vo_wait();
        } else {
          self.kung_fu_vo = 1;
          self notify("_encstr_95AD11DA5DB9CEEB3357BED9EDFA4EB29B2BD1");
          thread scripts\cp\cp_vo::try_to_play_vo("_encstr_87CD0CB595D82B56EB0E5D371BD0", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_9ACC05B41B7F32", 1, 0, 0, 1, 60);
          thread kung_fu_vo_wait();
        }
      } else
        thread scripts\cp\cp_vo::try_to_play_vo("_encstr_A5F80BAD2B1B2BACBEADD26E6E", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_9ACC05B41B7F32", 1, 0, 0, 1, 20);

      continue;
    }

    if(issubstr(var_1, "_encstr_ABCC07DA161D16E62C") && self.vo_prefix == "_encstr_A6190490B3C6") {
      thread scripts\cp\cp_vo::try_to_play_vo("_encstr_9567152B673245D05FDA03B9C6413809B9F7AB910F7A1F", "_encstr_A2DC104EC2D9B27D8DF65B5BB2CDD1BEB3DE", "_encstr_9ACC05B41B7F32", 1, 0, 0, 1);
      continue;
    }

    if((issubstr(var_1, "_encstr_A77205F710E016") || issubstr(var_1, "_encstr_B1CB0859917FF833E352") || issubstr(var_1, "_encstr_B40B0BE249FFC21DABAF8AD7C9") || issubstr(var_1, "_encstr_ADB10FDC6825418985216801A24F01D009")) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("_encstr_8D340EAD2B369556BE6E38B2B12D0BB1", "_encstr_A2DC104EC2D9B27D8DF65B5BB2CDD1BEB3DE", "_encstr_9ACC05B41B7F32", 1, 0, 0, 1);
      continue;
    }

    if(issubstr(var_1, "_encstr_ABAA0A0CEC37A90BA820EBEF") && scripts\cp\utility::is_melee_weapon(var_1) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("_encstr_95890C03BDCDF87DB7A2913BBA13", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_9ACC05B41B7F32", 1, 0, 0, 1);
      self.meleekill = 0;
      continue;
    }

    if((var_1 == "_encstr_8B060B2DDDE6BE0B0F95FAD3D6" || var_1 == "_encstr_A90A1071F7A2C9A71B81C19BE8E09B3EF0E3" || var_1 == "_encstr_A20A1003CF665603D89A290832391929D312") && scripts\cp\utility::is_melee_weapon(var_1) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("_encstr_BD900D0DAB633FFFC01B7B42A02637", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_9ACC05B41B7F32", 1, 0, 0, 1);
      self.meleekill = 0;
    }
  }
}

kung_fu_vo_wait() {
  self endon("_encstr_95AD11DA5DB9CEEB3357BED9EDFA4EB29B2BD1");
  wait 4;
  self.kung_fu_vo = 0;
}

watchweaponfired() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self notify("_encstr_8F8A118F071BAAD4FFEB33D06ACD26F173CA2A");
  self endon("_encstr_8F8A118F071BAAD4FFEB33D06ACD26F173CA2A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 1;
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || nullweapon(var_0)) {
      continue;
    }
    self waittill("_encstr_957F0699A5E4ACC8", var_0);
    var_0 = self getcurrentweapon();
    var_1 = self getammocount(var_0);
    var_2 = weaponclipsize(var_0);

    if(var_2 == 0) {
      continue;
    }
    var_3 = var_1 / var_2;

    if(scripts\cp\utility::is_melee_weapon(var_0) || issubstr(var_0.basename, "_encstr_A67F06F597DFEB6A") || issubstr(var_0.basename, "_encstr_88460641F5D618BD")) {
      continue;
    }
    if(var_1 <= 5 && var_1 > 0 && self getweaponammostock(var_0) == 0 || self getweaponammostock(var_0) > 0 && var_1 / self getweaponammostock(var_0) < 0.1) {} else if(var_1 == 0 && (var_0.basename != "_encstr_96C41462489F3967EBEEB9A37211633E5BE8BA9930A9" && !nullweapon(var_0)))
      scripts\cp\cp_vo::try_to_play_vo("_encstr_AA0B0DCDB03BD7DEBAA3EB16D6B5BD", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_BE19041BDEDD", 3, 0, 0, 0, 20);

    if(var_0.basename == "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9" || var_0.basename == "_encstr_88710EC26CC49918FA1A815BB5AFADC1" || var_0.basename == "_encstr_88F90EF65F8E7A1AEED5251AE97F9788")
      continue;
  }
}

getitemweaponname() {
  var_0 = self.classname;
  var_1 = getsubstr(var_0, 7);
  return var_1;
}

watchweaponpickup(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = getitemweaponname();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2, var_3);
    var_4 = var_2 getcurrentweapon();
    var_2 thread watchpickupcomplete(var_1, var_4);
    var_2 notify("_encstr_914C0EDDB20B837BB97D38D2365BAB83", var_1);
    var_5 = fixupplayerweapons(var_2, var_1);

    if(isDefined(var_3) || var_5) {
      break;
    }
  }

  if(isDefined(var_3)) {
    var_2 notify("_encstr_9A361BFBC758CB067DD15334F19550F30FD23B40D0A0806030DAF41B12");
    var_6 = var_3 getitemweaponname();
    var_7 = asmdevgetallstates(var_6);

    if(isDefined(var_2.tookweaponfrom[var_6])) {
      var_3.owner = var_2.tookweaponfrom[var_6];
      var_2.tookweaponfrom[var_6] = undefined;
    }

    var_3.objweapon = var_7.basename;
    var_3.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
    var_3 thread watchweaponpickup();
  }

  var_2.tookweaponfrom[var_1] = self.owner;
}

fixupplayerweapons(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 1;
  var_4 = 1;
  var_5 = undefined;

  if(issameweapon(var_1))
    var_5 = createheadicon(var_1);
  else
    var_5 = var_1;

  foreach(var_7 in var_2) {
    if(isDefined(var_0.primaryweaponobj) && var_0.primaryweaponobj == var_7) {
      var_3 = 0;
      continue;
    }

    if(isDefined(var_0.secondaryweaponobj) && var_0.secondaryweaponobj == var_7)
      var_4 = 0;
  }

  if(var_3) {
    var_0.primaryweapon = var_5;
    var_0.primaryweaponobj = asmdevgetallstates(var_5);
  } else if(var_4) {
    var_0.secondaryweapon = var_5;
    var_0.secondaryweaponobj = asmdevgetallstates(var_5);
  }

  return var_3 || var_4;
}

watchpickupcomplete(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_956C167F17D326D8F0FCC1D8E3B8C9683A3BD1D3FB6A5B2A");
  self endon("_encstr_956C167F17D326D8F0FCC1D8E3B8C9683A3BD1D3FB6A5B2A");
  var_2 = self.currentweapon;
  var_3 = 0;

  if(isstring(var_0))
    var_0 = asmdevgetallstates(var_0);

  if(var_2 == var_0)
    var_3 = 1;
  else {
    for(;;) {
      waitframe();
      var_4 = self.currentweapon;

      if(isnullweapon(var_2, var_4, 0)) {
        continue;
      }
      if(isnullweapon(var_0, var_4, 0))
        var_3 = 1;
      else
        var_3 = 0;

      break;
    }
  }

  if(var_3) {
    if(var_0.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
      scripts\cp\killstreaks\juggernaut_cp::juggernautweaponpickedup(var_0, var_1);

    thread notifyuiofpickedupweapon();
    self notify("_encstr_A6251833B4DCD29BA1EB382DC6B5EA07AFDE33FADD56161CF6E6", var_0, var_1);
  }
}

notifyuiofpickedupweapon() {
  self setclientomnvar("_encstr_AD81115796EBDD2B0B0EF69BBE38D28DB5BA83", 0);
}

watchweaponusage(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8749111B6081BEC3B7E5313888F87FC2D338A2");
  self endon("_encstr_8749111B6081BEC3B7E5313888F87FC2D338A2");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_1);
    var_2 = self getcurrentweapon();

    if(!isDefined(var_2) || nullweapon(var_2)) {
      continue;
    }
    if(!scripts\cp\utility::isinventoryprimaryweapon(var_2)) {
      continue;
    }
    if(isDefined(level.updateonusepassivesfunc))
      thread[[level.updateonusepassivesfunc]](self, createheadicon(var_2));

    var_3 = gettime();

    if(!isDefined(self.lastshotfiredtime))
      self.lastshotfiredtime = 0;

    var_4 = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = var_3;

    if(isai(self)) {
      continue;
    }
    var_5 = getweaponbasename(var_2);

    if(!isDefined(self.shotsfiredwithweapon[var_5]))
      self.shotsfiredwithweapon[var_5] = 1;
    else
      self.shotsfiredwithweapon[var_5]++;

    if(!isDefined(self.accuracy_shots_fired))
      self.accuracy_shots_fired = 1;
    else
      self.accuracy_shots_fired++;

    scripts\cp\cp_persistence::increment_player_career_shots_fired(self);

    if(isDefined(var_5)) {
      if(isDefined(self.hitsthismag[var_5]))
        thread hitsthismag_update(var_5, var_2);
    }
  }
}

hitsthismag_update(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = var_1.basename;
  self endon("_encstr_964B10FB13653909D14C0E3707608019C7DF" + var_0);
  self.hitsthismag[var_0]--;
  wait 0.1;
  self notify("_encstr_AF8F0C1B6C17D8D0522F777F37EA", var_1);
  self.consecutivehitsperweapon[var_0] = 0;
  self.hitsthismag[var_0] = weaponclipsize(var_1);
}

watchweaponchange() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self notify("_encstr_BDC912D4362BAF6837CF58C8FF5645F1029D4455");
  self endon("_encstr_BDC912D4362BAF6837CF58C8FF5645F1029D4455");
  self.hitsthismag = [];
  var_0 = getweaponbasename(self getcurrentweapon());
  hitsthismag_init(var_0);

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);
    var_0 = var_1.basename;
    weapontracking_init(var_0);

    if(isDefined(self.weapon_passives[var_1.basename])) {} else {}

    hitsthismag_init(var_0);
  }
}

harpoon_impale_additional_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!issubstr(var_0, "_encstr_83BF0820F70B83E5E740"))
    return;
  else {
    var_2 startragdoll();
    var_8 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
    var_9 = var_3 + var_4 * 4096;
    var_10 = scripts\engine\trace::ray_trace_detail(var_3, var_9, undefined, var_8, undefined, 1);
    var_9 = var_10["_encstr_BD260953AA97E3F014279D"] - var_4 * 12;
    var_11 = length(var_9 - var_3);
    var_12 = var_11 / 1250;
    var_12 = clamp(var_12, 0.05, 1);
    wait 0.05;
    var_13 = var_4;
    var_14 = anglestoup(var_1.angles);
    var_15 = vectorcross(var_13, var_14);
    var_16 = scripts\engine\utility::spawn_tag_origin(var_3, axistoangles(var_13, var_15, var_14));
    var_16 moveTo(var_9, var_12);
    var_17 = spawnragdollconstraint(var_2, var_5, var_6, var_7);
    var_17.origin = var_16.origin;
    var_17.angles = var_16.angles;
    var_17 linkTo(var_16);
    thread play_explosion_post_impale(var_9, var_1);
    thread impale_cleanup(var_2, var_16, var_12 + 0.05, var_17);
  }
}

impale_cleanup(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::_id_143BA(var_2, "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 delete();
  var_1 delete();
}

play_explosion_post_impale(var_0, var_1) {
  wait 2;
  var_1 radiusdamage(var_0, 500, 1000, 500, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  playFX(level._effect["_encstr_BD401E0ECA3759D1E42C8EA5B773AFC9C2A51BB3BAB9F556E1E063F6374B7BB9"], var_0);
}

weapontracking_init(var_0) {
  if(!isDefined(var_0) || var_0 == "_encstr_8BBA05185F8B99") {
    return;
  }
  if(!isDefined(self.shotsfiredwithweapon[var_0]))
    self.shotsfiredwithweapon[var_0] = 0;

  if(!isDefined(self.shotsontargetwithweapon[var_0]))
    self.shotsontargetwithweapon[var_0] = 0;

  if(!isDefined(self.headshots[var_0]))
    self.headshots[var_0] = 0;

  if(!isDefined(self.wavesheldwithweapon[var_0]))
    self.wavesheldwithweapon[var_0] = 1;

  if(!isDefined(self.downsperweaponlog[var_0]))
    self.downsperweaponlog[var_0] = 0;

  if(!isDefined(self.killsperweaponlog[var_0]))
    self.killsperweaponlog[var_0] = 0;
}

hitsthismag_init(var_0) {
  if(!isDefined(var_0) || var_0 == "_encstr_8BBA05185F8B99") {
    return;
  }
  if(scripts\cp\utility::isinventoryprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0]))
    self.hitsthismag[var_0] = weaponclipsize(var_0);
}

addattachmenttoweapon(var_0, var_1, var_2) {
  var_3 = self.currentweapon;
  var_4 = var_3;
  var_0 = undefined;
  var_5 = scripts\cp\utility::attachmentmap_tounique(var_1, var_4);
  var_6 = 0;

  if(var_3.attachments.size == 0) {
    if(var_4 canuseattachment(var_5))
      var_6 = 1;
    else
      var_6 = 0;
  } else {
    for(var_7 = 0; var_7 < var_3.attachments.size; var_7++) {
      if(var_4 canuseattachment(var_5) && attachmentsconflict(var_3.attachments[var_7], var_5, var_4) == "_encstr_B40101") {
        var_6 = 1;
        continue;
      }

      var_6 = 0;
      break;
    }
  }

  if(var_6)
    var_0 = var_4 withattachment(var_5);

  if(!isDefined(var_0)) {
    if(!isbot(self)) {}

    return undefined;
  }

  var_8 = self getweaponammoclip(var_0);
  var_9 = self getweaponammostock(var_0);

  if(istrue(var_2)) {
    var_8 = weaponclipsize(var_0);
    var_9 = weaponmaxammo(var_0);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
  self giveweapon(var_0);
  self setweaponammoclip(var_0, var_8);
  self setweaponammostock(var_0, var_9);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0);
  fixupplayerweapons(self, var_0);
  return var_0;
}

player_has_silencer(var_0) {
  if(!isDefined(var_0))
    var_0 = self getcurrentweapon();

  return var_0 hasattachment("_encstr_8ACA070BAB18273B36", 1);
}

_buildweaponcustom(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_0;
  var_10 = strtok(var_9, "_encstr_BA4C02DF");
  var_11 = 0;

  if(var_10[0] == "_encstr_B419040BB1A3")
    var_11++;

  if(var_10[var_11] == "_encstr_921904C3C7E2")
    return;
  else if(var_10[var_11] == "_encstr_B21904D2EE0E") {
    var_12 = var_0;

    if(!isDefined(var_1))
      var_1 = [];

    if(!isDefined(var_2))
      var_2 = "_encstr_8BBA05185F8B99";

    if(!isDefined(var_3))
      var_3 = "_encstr_8BBA05185F8B99";

    if(!isDefined(var_4))
      var_4 = -1;

    if(!isDefined(var_5))
      var_5 = [];

    if(!isDefined(var_6))
      var_6 = "_encstr_8BBA05185F8B99";

    if(!isDefined(var_7))
      var_7 = [];

    if(!isDefined(var_8))
      var_8 = 0;

    if(!isPlayer(self))
      return buildweapon(var_12, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    else
      return buildweapon(var_12, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

weaponsupportslaserir(var_0) {
  switch (var_0) {
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB":
    case "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1":
    case "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C":
    case "_encstr_BED80D7C9C59D95BF870DBDFA9F018":
      return 0;
  }

  if(scripts\cp\utility::iskillstreakweapon(var_0))
    return 0;

  var_1 = weaponclass(var_0);
  return var_1 == "_encstr_965306392D3336B2" || var_1 == "_encstr_BE0703A54C" || var_1 == "_encstr_850707F7E5833355B8" || var_1 == "_encstr_BE1904DCDA9D" || var_1 == "_encstr_A1100738A33A638123";
}

checkforinvalidattachments(var_0, var_1) {
  var_2 = getcompleteweaponname(var_1);
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_2 canuseattachment(var_5)) {
      var_3[var_3.size] = var_5;
      continue;
    }

    thread invalidattachmentwarning(var_5, var_1);
  }

  return var_3;
}

invalidattachmentwarning(var_0, var_1) {
  var_2 = "_encstr_9A85153850905884D8FBCE08336BDF0BC06F5735E3FAF1" + var_0 + "_encstr_A1720516F8209A" + var_1;

  if(isDefined(self) && isPlayer(self)) {
    if(getdvarint("_encstr_A90F0DE66C39AF1CC6B0E5A395CDE8", 0) == 1)
      self iprintlnbold(var_2);
    else {}
  }
}

doesweaponhaveattachmenttype(var_0, var_1, var_2) {
  var_3 = [];

  if(istrue(var_2))
    var_3 = var_0.others;
  else
    var_3 = var_0.attachments;

  if(hasattachmenttype(var_3, var_1))
    return 1;
  else
    return 0;
}

hasattachmenttype(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(scripts\cp\utility::attachmentmap_tobase(var_3) == var_1)
      return 1;
  }

  return 0;
}

hasscope(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\cp\utility::getattachmenttype(var_2) == "_encstr_851F05E3C813A5")
      return 1;
  }

  return 0;
}

getreticleindex(var_0) {
  if(!isDefined(var_0))
    return undefined;

  var_1 = int(tablelookup("_encstr_87B614A0123F80A55B87EFE9AF01FF48042F40F97ACE", 1, var_0, 5));

  if(!isDefined(var_1) || var_1 == 0)
    return undefined;

  return var_1;
}

buildweaponuniqueattachments(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 < 0)
    var_2 = undefined;

  var_1 = scripts\cp\utility::weaponattachremoveextraattachments(var_1, var_0);
  var_1 = scripts\engine\utility::array_remove(var_1, "_encstr_8BBA05185F8B99");
  var_3 = scripts\cp\utility::weaponattachdefaultmap(var_0);
  var_4 = scripts\cp\utility::buildweaponassetname(var_0, var_2);
  var_5 = var_1;

  for(var_6 = 0; var_6 < var_5.size; var_6++)
    var_5[var_6] = scripts\cp\utility::attachmentmap_tobase(var_5[var_6]);

  if(isDefined(var_3)) {
    var_7 = var_3;

    for(var_6 = 0; var_6 < var_7.size; var_6++)
      var_7[var_6] = scripts\cp\utility::attachmentmap_tobase(var_7[var_6]);

    var_5 = scripts\engine\utility::array_combine_unique(var_5, var_7);
  }

  var_8 = [];

  if(var_5.size > 0) {
    var_5 = scripts\cp\utility::filterattachments(var_5);

    for(var_9 = 0; var_9 < var_5.size; var_9++)
      var_8[var_9] = scripts\cp\utility::attachmentmap_tounique(var_5[var_9], var_4);
  }

  var_10 = [];

  foreach(var_12 in var_8) {
    var_13 = scripts\cp\utility::attachmentmap_toextra(var_12);

    if(isDefined(var_13))
      var_10[var_10.size] = scripts\cp\utility::attachmentmap_tounique(var_13, var_4);
  }

  if(var_10.size > 0)
    var_8 = scripts\engine\utility::array_combine_unique(var_8, var_10);

  if(isDefined(var_2)) {
    var_15 = scripts\cp\utility::getweaponvariantattachments(var_4, var_2);

    foreach(var_17 in var_15)
    var_8[var_8.size] = var_17;
  }

  var_19 = undefined;
  return var_8;
}

applyflashfromdamage(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.usingremote))
    return 0;

  if(isDefined(var_0.vehicle))
    return 0;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(scripts\cp\utility::is_friendly_damage(var_0, var_1) && var_0 != var_1)
    return 0;

  var_4 = distance(var_2, var_0.origin);
  var_5 = 0;

  if(var_1 == var_0) {
    if(var_4 > 384)
      return 0;
    else
      var_5 = 1;
  }

  var_6 = 0;
  var_7 = 0;

  if(var_4 >= 512 || !scripts\engine\utility::within_fov(var_1.origin, var_1 getplayerangles(), var_2, 0.5)) {
    var_6 = 3;
    var_7 = 0.25;
  } else if(var_4 <= 256) {
    var_6 = 5;
    var_7 = 0.75;
  } else {
    var_8 = 1 - (var_4 - 256) / 256;
    var_6 = 3 + var_8 * 2;
    var_7 = 0.25 + var_8 * 0.5;
  }

  if(var_3) {
    var_0 = var_1;
    var_6 = max(3, var_6 * 0.75);
    var_7 = max(0.25, var_7 * 0.75);
  } else if(var_5) {
    var_6 = max(3, var_6 * 0.75);
    var_7 = max(0.25, var_7 * 0.75);
  }

  if(isPlayer(var_0)) {
    var_0 shellshock("_encstr_81890DA344E67BB8E372C5BF61E86B", var_6);
    var_0.flashendtime = gettime() + var_6 * 1000;
    var_0 thread flashrumbleloop(var_7);
  } else if(var_0 scripts\cp\utility::is_zombie_agent() || var_0.agent_type == "_encstr_A7E80E1818902B623DBA872BD4C1184C" || var_0.unittype == "_encstr_958C08CDDBD8325A959C")
    stunenemiesinrange(var_2, var_1);
  else {
    var_0 shellshock("_encstr_81890DA344E67BB8E372C5BF61E86B", var_6);
    var_0.flashendtime = gettime() + var_6 * 1000;
    var_0 thread flashrumbleloop(var_7);
  }

  return 1;
}

isflashgrenadedamage(var_0, var_1) {
  return var_0.basename == "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683" && var_1 != "_encstr_A1ED0BA9FF84562B60BA073E83";
}

flashrumbleloop(var_0) {
  self endon("_encstr_ADAD16871485D8F8E7BA8810739726589D9F5715A4EE38BB");
  self endon("_encstr_833212DCF5FA0FE8BF1378A04BD4011F525DC05F");
  self notify("_encstr_833212DCF5FA0FE8BF1378A04BD4011F525DC05F");
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
    wait 0.05;
  }
}

giveequipmentasaweapon(var_0) {
  switch (var_0) {
    case "_encstr_8DCB085BEF657B4DCF0B":
      self.last_weapon = self getcurrentweapon();
      self giveweapon("_encstr_A9B40FB4DD837DD6DBD8BDA3DECEBE3DD6");
      self switchtoweapon("_encstr_A9B40FB4DD837DD6DBD8BDA3DECEBE3DD6");
      break;
    case "_encstr_8DEF0EB6FA1FA1578C69B8E8A2220779":
      self.last_weapon = self getcurrentweapon();
      self giveweapon("_encstr_9AAE0876FCB7603101DB");
      self switchtoweapon("_encstr_9AAE0876FCB7603101DB");
      break;
  }
}

watch_for_dropped_weapons() {
  for(;;) {
    level waittill("_encstr_9A1C120B2DAFDDCA1638DB37BE919C7B83E0AC32");
    var_0 = getweaponarray();

    foreach(var_2 in var_0)
    var_2 setusepriority(1, 1);
  }
}

drop_script_weapon_from_ai(var_0, var_1) {
  var_2 = var_0.basename;

  if(scripts\engine\utility::array_contains(level.invalid_drop_weapons, var_2)) {
    return;
  }
  var_3 = var_0.attachments;
  var_4 = getDvar("_encstr_AC48175780D3FFD3631FAAA7FE0FDBB73978DBAF18AE392B69", "_encstr_B40101");

  if(var_4 != "_encstr_B40101")
    var_3 = scripts\engine\utility::array_add(var_3, var_4);

  if(_id_124AE())
    var_5 = 1;
  else
    var_5 = undefined;

  var_6 = spawn_script_weapon(var_2, var_3, self.origin + (0, 0, 32), self.angles, var_5);

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = getweapongroup(var_0);
  scripts\cp_mp\utility\weapon_utility::dropweaponfordeathlaunch(var_6, var_7);

  if(!isDefined(var_6)) {
    return;
  }
  var_6 update_dropped_weapon_priorities();
  var_8 = getsubstr(var_6.classname, 7, var_6.classname.size);
  var_6 _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::setscriptammo(var_8, self);
  var_6 thread delete_weapon_after_time();
  var_6 thread watchweaponpickup();
}

_id_124AE() {
  if(level.script == "_encstr_841F0DB138EBDCDE7D56DC472C1D59")
    return 1;

  return 0;
}

delete_weapon_after_time() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  wait 30;
  remove_from_weapon_array(self);
  self delete();
}

update_dropped_weapon_priorities() {
  self setusepriority(1, 1);
  self setuserange(72);
}

initializeweaponpickups() {
  if(level.gametype == "_encstr_B1BC09D6E3C9BBA3EFB318") {
    return;
  }
  if(isDefined(level.custom_allowedweaponnames))
    var_0 = level.custom_allowedweaponnames;
  else
    var_0 = ["_encstr_A9FA0E8BE3BF871942571010A378F033", "_encstr_A3850ED02338F9BEDA6FF9E3EB22A3CA", "_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065", "_encstr_A2650D3B7B57574AFFAF4BDCA3811A", "_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C", "_encstr_9106102387E011DF472978E0722F376ADAB9", "_encstr_8C160DAFE71BF161681EB5BCB0F8FC", "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6", "_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D", "_encstr_A1E70FBB8CDA89535851E1C3D9EB66A97A", "_encstr_9AB60FB477707DB1DAFA6DD263DB1364C4", "_encstr_92DF0ED45BDA2E53D81F08FF1B5F9FC2", "_encstr_A52C0E7020307103407898128DC7C6CB", "_encstr_8BE20ED75722A6731BF84F3064CA126B", "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD"];

  var_1 = scripts\engine\utility::getStructArray("_encstr_914C0EDDB20B837BB97D38D2365BAB83", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters)) {
      var_4 = getcompletenameforweapon(var_3.script_parameters + "_encstr_851A049F8337");
      var_5 = spawn("_encstr_B2010820C5337B67C8CF" + var_4, var_3.origin);
      var_5 itemweaponsetammo(weaponclipsize(var_4), weaponmaxammo(var_4));
      var_5 thread watchweaponpickup();
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  var_7 = [];
  var_8 = [];

  foreach(var_14, var_10 in level.weaponmapdata) {
    foreach(var_4 in var_0) {
      if(var_14 == var_4) {
        var_12 = strtok(var_14, "_encstr_BA4C02DF");

        if(var_12[0] == "_encstr_B21904D2EE0E") {
          var_7[var_7.size] = var_14;
          level.attachmentmap[var_14] = pullattachmentsforweapon(var_14);
        }
      }
    }
  }

  var_7 = eliminatenullweapons(var_7);
  var_15 = 0;
  var_16 = 0;

  for(var_17 = var_1.size; var_16 < var_17; var_16++) {
    var_15 = randomintrange(0, var_7.size);
    var_18 = attachmentroll(var_7[var_15]);

    foreach(var_20 in var_18) {
      foreach(var_22 in var_18) {
        if(var_20 == var_22) {
          continue;
        }
        if(!attachmentscompatible(var_20, var_22))
          var_18 = scripts\engine\utility::array_remove(var_18, var_22);
      }
    }

    var_4 = getcompletenameforweapon(var_7[var_15]);
    var_5 = spawn("_encstr_B2010820C5337B67C8CF" + var_4, var_1[var_16].origin);

    if(isDefined(var_1[var_16].angles))
      var_5.angles = var_1[var_16].angles;
    else
      var_5.angles = (0, 0, 0);

    var_5 itemweaponsetammo(weaponclipsize(var_4), weaponmaxammo(var_4));
    var_5 thread watchweaponpickup();
  }
}

attachmentroll(var_0) {
  var_1 = [];

  if(isDefined(level.attachmentmap[var_0])) {
    var_2 = scripts\engine\utility::array_randomize(level.attachmentmap[var_0]);
    var_3 = attachmentrollcount();

    for(var_4 = 0; var_4 < var_3 && var_4 < var_2.size; var_4++)
      var_1[var_1.size] = var_2[var_4];
  }

  return var_1;
}

attachmentrollcount() {
  var_0 = randomint(100);

  if(var_0 < 50)
    return 0;
  else if(var_0 < 80)
    return 1;
  else if(var_0 < 95)
    return 2;
  else if(var_0 < 100)
    return 3;

  return 0;
}

pullattachmentsforweapon(var_0) {
  foreach(var_3, var_2 in level.attachmentmap_basetounique) {
    if(var_0 == var_3)
      return returnarraywithoutdefaults(var_2, var_0);
  }
}

returnarraywithoutdefaults(var_0, var_1) {
  foreach(var_4, var_3 in level.weaponmapdata) {
    if(var_1 == var_4) {
      if(scripts\engine\utility::array_contains(var_0, "_encstr_92B50AC8BDABC4D8AC8E580E"))
        var_0 = scripts\engine\utility::array_remove(var_0, "_encstr_92B50AC8BDABC4D8AC8E580E");

      if(scripts\engine\utility::array_contains(var_0, "_encstr_BDD211C92B8D7BDCCD4BB156B91BACC9BE6CC1"))
        var_0 = scripts\engine\utility::array_remove(var_0, "_encstr_BDD211C92B8D7BDCCD4BB156B91BACC9BE6CC1");

      if(isDefined(var_3.attachdefaults))
        return scripts\engine\utility::array_remove_array(var_0, var_3.attachdefaults);
    }
  }
}

eliminatenullweapons(var_0) {
  var_1 = ["_encstr_87610AB4EE83FAD6374B3395", "_encstr_A7ED0AD79F73990E28334B92", "_encstr_82200E7710825F228B4362D2DBEB8E1A", "_encstr_8BBA05185F8B99", "_encstr_A9E51023082D2FF913B8A9134707B8DF290B", "_encstr_A3580FB37FEAE6D38AE92380E265BB39A3", "_encstr_93580F4BBBE0AFC24EBE19BAB6B697C66E", "_encstr_8EF4120387DA5772B528A25C906463B05F38F38F"];
  var_2 = [];

  if(isstruct(scripts\engine\utility::random(var_0))) {
    foreach(var_5, var_4 in var_0) {
      if(!scripts\engine\utility::array_contains(var_1, var_5))
        var_2[var_5] = var_4;
    }

    return var_2;
  }

  return scripts\engine\utility::array_remove_array(var_0, var_1);
}

choosepassive() {
  for(;;) {
    var_0 = scripts\engine\utility::random(level.lootpassivesstructs);

    foreach(var_3, var_2 in level.cp_weapon_passives) {
      if(var_0.name == var_3)
        return var_0;
      else
        continue;
    }

    waitframe();
  }
}

makeexplosiveunusuabletag() {
  self notify("_encstr_8EAF167AA07FFFB792AFFCE7C658B307FB30631318C5F54F");
  self makeunusable();
}

isplantedequipment(var_0) {
  return isDefined(level.mines[var_0 getentitynumber()]) || istrue(var_0.planted);
}

assignlootpassivetoweapon(var_0, var_1) {
  var_2 = choosepassive();

  if(isDefined(var_2.attachmentref))
    return getcompleteweaponname(var_0, [var_2.attachmentref]);
  else {
    var_3 = scripts\cp\utility::getweaponrootname(var_0);
    var_4 = getcompleteweaponname(var_0);
    var_1.weapon_passives[var_3] = var_2;
    return var_4;
  }
}

grenadeinpullback() {
  return !nullweapon(self getheldoffhand());
}

getgrenadeinpullback() {
  var_0 = self getheldoffhand();

  if(isDefined(self.gestureweapon) && var_0 == asmdevgetallstates(self.gestureweapon))
    var_0 = isundefinedweapon();

  return var_0;
}

grenadeinitialize(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.weapon_object))
    var_0.weapon_object = var_1;

  if(!isDefined(var_0.weapon_name))
    var_0.weapon_name = var_1.basename;

  if(!isDefined(var_0.owner))
    var_0.owner = self;

  if(!isDefined(var_0.team))
    var_0.team = self.team;

  if(!isDefined(var_0.tickpercent))
    var_0.tickpercent = var_2;

  if(!isDefined(var_0.ticks) && isDefined(var_0.tickpercent))
    var_0.ticks = scripts\cp\utility::roundup(4 * var_2);

  var_4 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_1);

  if(isDefined(var_4)) {
    var_0.equipmentref = var_4;
    var_0.isequipment = 1;
  }

  var_0.threwback = isDefined(var_3);
}

allow_weapon_first_raise_anims(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("_encstr_9B2F104E936BEF03BD189A33D0737D7F6006", var_0, var_1);

  if(isDefined(var_2) && var_2)
    setsaveddvar("_encstr_9A140B5349B4B4A02A282A8AA4", 0);
  else if(isDefined(var_2) && !var_2)
    setsaveddvar("_encstr_9A140B5349B4B4A02A282A8AA4", 1);
}

updatelastweapon() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastdroppableweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);
    self.lastweaponobj = var_0;

    if(isnormallastweapon(var_0))
      self.lastnormalweaponobj = var_0;

    if(isdroppableweapon(var_0))
      self.lastdroppableweaponobj = var_0;

    if(iscacprimaryorsecondary(var_0))
      self.lastcacweaponobj = var_0;
  }
}

isnormallastweapon(var_0) {
  if(var_0.basename == "_encstr_8BBA05185F8B99")
    return 0;

  if(var_0.classname == "_encstr_A7AF07D1EF1B06683C")
    return 0;

  if(scripts\cp\utility::issuperweapon(var_0.basename))
    return 0;

  if(scripts\cp\utility::iskillstreakweapon(var_0.basename))
    return 0;

  if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0" && var_0.inventorytype != "_encstr_B4DC085639F9C2779108")
    return 0;

  return 1;
}

iscacprimaryweapon(var_0) {
  switch (getweapongroup(var_0)) {
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
    case "_encstr_AF710BF4355A9195B0FF0AEAD0":
    case "_encstr_8ACC0DEC0F42B1A0263F50189B45B9":
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
    case "_encstr_A3710BEEACC2E0B737EB36B676":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
      return 1;
    default:
      return 0;
  }
}

getweapongroup(var_0) {
  if(!isDefined(var_0))
    return "_encstr_8261067B1D34AC27";

  if(issameweapon(var_0) && nullweapon(var_0))
    return "_encstr_8261067B1D34AC27";

  if(isstring(var_0) && (var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_AA7809476984573B7FCDE9"))
    return "_encstr_8261067B1D34AC27";

  var_1 = scripts\cp\utility::getweaponrootname(var_0);
  var_2 = scripts\cp\utility::weapongroupmap(var_1);

  if(!isDefined(var_2)) {
    if(scripts\cp\utility::issuperweapon(var_0))
      var_2 = "_encstr_BEB406F03B72BB3B";
    else if(scripts\cp\utility::isenvironmentweapon(var_0))
      var_2 = "_encstr_BADE0AEE56581CF6B9FAD6CE";
    else if(scripts\cp\utility::iskillstreakweapon(var_0))
      var_2 = "_encstr_85CE0B9770B02C73A1760F06D2";
    else
      var_2 = "_encstr_8261067B1D34AC27";
  }

  return var_2;
}

iscacsecondaryweapon(var_0) {
  switch (getweapongroup(var_0)) {
    case "_encstr_BA2816DDB25807DE9BAF5B168D0D4BCDB2EB834BDC3A7B63":
    case "_encstr_88670C4077366F270E071EC9720C":
    case "_encstr_82EF0C97EDA73962101FCEFF0171":
    case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
    case "_encstr_8D200E63B9A7DBC550975D5D99600FAA":
      return 1;
    default:
      return 0;
  }
}

iscacprimaryorsecondary(var_0) {
  return iscacprimaryweapon(var_0) || iscacsecondaryweapon(var_0);
}

iscacmeleeweapon(var_0) {
  return getweapongroup(var_0) == "_encstr_8ACC0DEC0F42B1A0263F50189B45B9";
}

isdroppableweapon(var_0) {
  if(var_0.basename == "_encstr_8BBA05185F8B99")
    return 0;

  if(isfistweapon(var_0.basename))
    return 0;

  if(isDefined(self) && istrue(self.inlaststand))
    return 0;

  if(scripts\cp\utility::iskillstreakweapon(var_0.basename))
    return 0;

  if(scripts\cp\utility::issuperweapon(var_0.basename))
    return 0;

  if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0")
    return 0;

  if(var_0.classname == "_encstr_A7AF07D1EF1B06683C")
    return 0;

  if(!iscacprimaryweapon(var_0.basename) && !iscacsecondaryweapon(var_0.basename))
    return 0;

  return 1;
}

gui_giveattachment() {
  var_0 = getDvar("_encstr_8FCD13CDB14EF5B3A5D995B01D3AC28DA1D656DC1D");

  if(isDefined(var_0)) {
    foreach(var_2 in level.players)
    gui_giveattachment_internal(var_2, var_0);
  }
}

gui_giveattachment_internal(var_0, var_1) {
  var_2 = var_0.currentweapon;
  var_0 dropitem(var_2);
  var_2 = var_2 getnoaltweapon();
  var_3 = scripts\cp\utility::getweaponattachmentsbasenames(var_2);
  var_4 = 0;

  if(scripts\engine\utility::array_contains(var_3, var_1))
    var_4 = 1;
  else {
    var_5 = scripts\cp\utility::attachmentmap_tounique(var_1, var_2);

    if(!var_2 canuseattachment(var_5)) {
      if(!isbot(var_0))
        var_0 iprintlnbold("_encstr_AC1225F16508E6737341D6CA6BD57FDE50FB552EB962EF37A6B18B62D0AEB293404BD8A735DA26" + var_5);

      var_4 = 1;
    }
  }

  if(var_4) {
    var_0 giveweapon(var_2);
    return;
  }

  var_6 = var_3;
  var_6[var_6.size] = var_1;
  var_7 = scripts\cp\utility::getweaponrootname(var_2.basename);
  var_8 = buildweaponuniqueattachments(var_7, var_6, -1);

  if(isDefined(var_2.attachments)) {
    foreach(var_10 in var_2.attachments)
    var_2 = var_2 withoutattachment(var_10);
  }

  foreach(var_13 in var_8)
  var_2 = var_2 withattachment(var_13);

  var_15 = getweaponattachments(var_2);

  if(var_15.size > 12) {
    var_0 iprintlnbold("_encstr_83A22A82C6C2BCAC9301790809DE3A01C2634E561623BC080D586E80896440B01D8E588D86DAAC37476EA308" + createheadicon(var_2));
    return;
  }

  var_0 giveweapon(var_2);
  var_0 setweaponammoclip(var_2, weaponclipsize(var_2));
  var_0 setweaponammostock(var_2, weaponmaxammo(var_2));
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_2);
  fixupplayerweapons(var_0, var_2);
}

watchgunsmithdebugui() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread watchplayergunsmithdebugui();
  }
}

watchplayergunsmithdebugui() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_BE2F143CE5198797F7487B7320E70C77935D8CB50E23") {
      var_2 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 0, var_1, 4);
      gui_giveattachment_internal(self, var_2);
    }
  }
}

create_weapon_pickups() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_914C0EDDB20B837BB97D38D2365BAB83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = strtok(var_0[var_1].script_noteworthy, "_encstr_BE4C0295");
    var_3 = var_2[0];
    var_4 = [];

    if(var_2.size > 1) {
      var_5 = strtok(var_2[1], "_encstr_974C0246");

      for(var_6 = 0; var_6 < var_5.size; var_6++)
        var_4[var_4.size] = var_5[var_6];
    }

    var_3 = spawn_script_weapon(var_3, var_4, var_0[var_1].origin, var_0[var_1].angles);
  }
}

spawn_script_weapon(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = [];

  if(!isarray(var_1))
    var_1 = [var_1];

  var_5 = undefined;

  if(getdvarint("_encstr_96CD13CD1B39D70BA57D27B0E6C8DB6BF5DD56851C", 0) != 0)
    var_5 = buildweaponwithrandomattachments(var_0, var_1);
  else
    var_5 = buildweapon(var_0, var_1, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1, undefined, undefined, undefined, var_4);

  var_6 = createheadicon(var_5);
  var_7 = spawn("_encstr_B2010820C5337B67C8CF" + var_6, var_2);

  if(isDefined(var_7)) {
    if(scripts\cp\utility::turn_off_sniper_laser())
      var_7 itemweaponsetammo(weaponclipsize(var_7), 0);
    else
      var_7 itemweaponsetammo(weaponclipsize(var_7), weaponclipsize(var_7));

    var_7.angles = var_3;
    add_to_weapon_array(var_7);
    var_7 thread scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", ::remove_from_weapon_array);
  }

  return var_7;
}

add_to_weapon_array(var_0) {
  level.dropped_weapons[level.dropped_weapons.size] = var_0;
}

remove_from_weapon_array(var_0) {
  if(isDefined(var_0)) {
    if(scripts\engine\utility::array_contains(level.dropped_weapons, var_0))
      level.dropped_weapons = scripts\engine\utility::array_remove(level.dropped_weapons, var_0);
  }
}

smokegrenadeused(var_0) {
  thread scripts\cp\utility::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_1 = self.owner.name;

  if(istrue(var_0)) {
    self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_6, var_2, var_3, var_4, var_5, var_7);
    thread _id_13426(var_6);
  } else
    self waittill("_encstr_860808CB78E2984063BA", var_6);

  level notify("_encstr_95D618A2C95F32ED66A85337D899A49A6755E81A21F70B398808", var_6, 330, 9.25, 1);

  foreach(var_9 in getaiarray("_encstr_8E8405EA382B2A"))
  var_9 childthread scripts\asm\gesture::ai_request_gesture("_encstr_97F50888E2AB71501FA6");

  thread smokegrenadeexplode(var_6, var_1);
  thread sfx_smoke_grenade_smoke(var_6);

  if(isDefined(self.owner))
    self.owner thread monitorsmokeactive();
}

smokegrenadeexplode(var_0, var_1) {
  wait 1;
  var_2 = scripts\cp\cp_outline_utility::addoutlineoccluder(var_0, 330);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3 show();
  var_4 = getEnt("_encstr_B1601D97C782C250DF5FC33905C9900D39173B37AB5B805834348B763AE55A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_4)) {
    level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_3, "_encstr_8823119675DAFF897F878020BB99612B219D8F", var_1);
    var_3 clonebrushmodeltoscriptmodel(var_4);
    var_3 setmovertransparentvolume();
  } else
    var_3 delete();

  wait 8.25;

  if(isDefined(var_3))
    var_3 delete();

  scripts\cp\cp_outline_utility::removeoutlineoccluder(var_2);
}

sfx_smoke_grenade_smoke(var_0) {
  wait 0.2;
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
  var_1 playLoopSound("_encstr_8618179BB5B7ADB2BECE4ECA37C22395FA37B67BD659AFD80E");
  var_1 scripts\cp_mp\ent_manager::registerspawncount(1);
  wait 5.25;
  thread scripts\engine\utility::play_sound_in_space("_encstr_8CF1199B2FF7F85B795F46C5F57291E11FFF4868AF953621A2C4B1", var_0);
  wait 0.3;
  var_1 scripts\cp_mp\ent_manager::deregisterspawn();
  var_1 stoploopsound();
  var_1 delete();
}

_id_13426(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("_encstr_AA7608ECD89B6BDE5B59"), var_0, anglestoup((0, 90, 0)));
}

monitorsmokeactive() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8ED415B977C0FF40574A9F7AF81F8F21162DB26BD79ADE");
  self endon("_encstr_8ED415B977C0FF40574A9F7AF81F8F21162DB26BD79ADE");
  scripts\cp\utility::printgameaction("_encstr_9A7518B95BBDDA95103BC956E6C2C859100BD8D14BCE2C47CA46", self);
  self.hasactivesmokegrenade = 1;
  var_0 = scripts\engine\utility::_id_143B9(9.25, "_encstr_AD75063D571AE108");
  self.hasactivesmokegrenade = 0;
  scripts\cp\utility::printgameaction("_encstr_A13E1A9BDADEB595023B3995B985195602232B161B8ED23B0B1DAC46", self);
}

buildweaponwithrandomattachments(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = scripts\cp\utility::getweaponrootname(var_0);

  if(!isai(self)) {
    return;
  }
  return getweapon(var_10, weaponclass(var_0));
}

getweapon(var_0, var_1) {
  var_2 = [];

  if(isarray(var_0)) {
    var_2 = var_0;
    var_0 = var_0[randomint(var_0.size)];
  } else
    var_2 = [var_0];

  if(var_0 == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB") {}

  if(1)
    return getweapon_aq(var_1, var_0, var_2);

  if(issubstr(tolower(self.classname), "_encstr_91F10657B788C729"))
    return getweapon_aq(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_B8FF0DF1C37D6BBFBAAF5655429377"))
    return getweapon_ru(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_8D190BEBCDC1593AB9B9C2D3BE"))
    return getweapon_ru(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_8A890787506FA09857"))
    return getweapon_hero(var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_B87C0A274BA9511A9A2B66C7"))
    return getweapon_hero(var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_BD6706B053A74B97"))
    return getweapon_sas(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_B45C063F8548FE17"))
    return getweapon_reb(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_8F2407590E959B5DF0"))
    return getweapon_so15(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_88A21091BBE7C617BA88B69F7F194A9F985F"))
    return getweapon_so15(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_encstr_AA3D07EBEACDAD6CAF"))
    return getweapon_usmc(var_1, var_0, var_2);
  else
    return buildweapon(var_0);

  return var_0;
}

getweapon_hero(var_0, var_1) {
  if(issubstr(tolower(self.classname), "_encstr_87B90BE6147580A0E9A7F1FBDB")) {
    switch (var_0) {
      case "_encstr_9106102387E011DF472978E0722F376ADAB9":
        return make_weapon_special("_encstr_B2BA0CA06AF7415E7BA97EF5B753");
      case "_encstr_92DF0ED45BDA2E53D81F08FF1B5F9FC2":
        return make_weapon_special("_encstr_8FE50C9208356B590845C9D87B28");
    }
  } else if(issubstr(tolower(self.classname), "_encstr_91240C0972AF1D107F60BF2549E3")) {
    switch (var_0) {
      case "_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065":
        return make_weapon_special("_encstr_A6B30A8390E304AE91A7F57A");
      case "_encstr_A32A0FA7EFE3098B8006FCC79BB0ADE210":
        return make_weapon_special("_encstr_87730DA1C2C82D4EBE9BB95AC1B29C");
    }
  } else if(issubstr(tolower(self.classname), "_encstr_A2ED0B4913D5E37751442BB9DF")) {
    switch (var_0) {
      case "_encstr_858110A5BB0EEB16C97DADB134859C1B5AB2":
        return make_weapon_special("_encstr_B83D084CA3BAB509B143");
    }
  } else if(issubstr(tolower(self.classname), "_encstr_B4A90C5188A8F28AD891A3C79FFD")) {
    switch (var_0) {
      case "_encstr_BAB10F67F72A59E09850B24028F0060E50":
        return make_weapon_special("_encstr_A60B0E6B4157F7BAEAE1D7F241A87617");
      case "_encstr_99550F225BABC7E65077BBB13990FBCE96":
        return make_weapon_special("_encstr_9AFA09133BBFA638D969E5");
    }
  } else if(issubstr(tolower(self.classname), "_encstr_BA500C51B343ABFF7EA82763B8B0")) {
    switch (var_0) {
      case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
        return make_weapon_special("_encstr_9B3909ACC6BB5B98CF0F10");
    }
  } else if(issubstr(tolower(self.classname), "_encstr_8C6F10D94079E119A9573820256923BA609E")) {
    switch (var_0) {
      case "_encstr_8BE20ED75722A6731BF84F3064CA126B":
        return make_weapon_special("_encstr_A5CF0E190E2A5BE8031791AB4FCB20C0");
    }
  }

  if(getdvarint("_encstr_A94A17371B9CAFC90B37C8F6B5EE561638DBCDBE8C2B13AB76"))
    iprintln("_encstr_ABAE2BB9F6A34077344BA3B236A59BD12B464802806E5BA53807A5E6CE04CDB1392D1CD1AC460489575A6346C5");

  return make_weapon(var_0, []);
}

getweapon_aq(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "_encstr_965306392D3336B2":
    case "_encstr_AD07034A38":
      var_5["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 45;
      var_5["_encstr_95FA0EA5EE1CFA5827D733B08DB45B16"] = 35;
      var_5["_encstr_A9FA0E8BE3BF871942571010A378F033"] = 20;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_A1B50AB34B01F3D8501868A5", "_encstr_A28305178878FF", "_encstr_9539066128083785", "_encstr_877A067A5714507E"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_AAC00736D0F8CE77E0", "_encstr_8AC0074B3B47309AF2", "_encstr_85E508032BD7D638C537", "_encstr_91E90AB98EDE8DB6CCED6319"];
          var_3["_encstr_B8A20530467FE8"] = [50, "_encstr_8CC806AC2E036A82", "_encstr_8E5F063CDA2C3BCD"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8CDA09374D13A3C330FB93", "_encstr_874F0A5F2B0F9BDC2081FC85"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_A98B0840112B5A452B54"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_8A07035972", "_encstr_AA7608ECD89B6BDE5B59", "_encstr_97D506F770BFFFBB", "_encstr_ADBD0780C4884FEE86"];
          break;
        case "_encstr_A9FA0E8BE3BF871942571010A378F033":
          var_3["_encstr_810B070B2B8730D3FB"] = [10, "_encstr_9539066128083785", "_encstr_A30D0B98D7308F8AC8591702E9", "_encstr_A1B50AB34B01F3D8501868A5"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_AAC00736D0F8CE77E0", "_encstr_8AC0074B3B47309AF2", "_encstr_9BC007FBBD680FA49F"];
          var_3["_encstr_B8A20530467FE8"] = [20, "_encstr_8E5F063CDA2C3BCD"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8CDA09374D13A3C330FB93", "_encstr_874F0A5F2B0F9BDC2081FC85"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_A98B0840112B5A452B54"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_88270B9BE59120260B9BFD6343"];
          break;
        case "_encstr_95FA0EA5EE1CFA5827D733B08DB45B16":
          var_3["_encstr_810B070B2B8730D3FB"] = [20, "_encstr_9539066128083785"];
          var_3["_encstr_B8A20530467FE8"] = [20, "_encstr_8E5F063CDA2C3BCD"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8B7208D9AA51B88FA2D7"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_858E09935E8397836868F3", "_encstr_A98B0840112B5A452B54"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_A6770BE5021FC8BBB422EA02BF", "_encstr_82910B7A09C0C5AAAD535F53A7"];
          break;
      }

      break;
    case "_encstr_A11804C86B39":
      var_5["_encstr_A52C0E7020307103407898128DC7C6CB"] = 50;
      var_5["_encstr_95FA0EA5EE1CFA5827D733B08DB45B16"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_A52C0E7020307103407898128DC7C6CB":
          var_3["_encstr_810B070B2B8730D3FB"] = [75, "_encstr_B8FB06FF97EA2708", "_encstr_8BEB08833B38890A08A7"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_AAC00736D0F8CE77E0", "_encstr_8AC0074B3B47309AF2"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_A98B0840112B5A452B54", "_encstr_A39B07DDDFC235D08A", "_encstr_858E09935E8397836868F3"];
          var_3["_encstr_9B6B081A7BABC93A37DE"] = [50, "_encstr_9B6B081A7BABC93A37DE"];
          var_3["_encstr_B8A20530467FE8"] = [35, "_encstr_8E5F063CDA2C3BCD"];
          break;
        case "_encstr_95FA0EA5EE1CFA5827D733B08DB45B16":
          var_3["_encstr_810B070B2B8730D3FB"] = [20, "_encstr_9539066128083785"];
          var_3["_encstr_B8A20530467FE8"] = [20, "_encstr_8E5F063CDA2C3BCD"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8B7208D9AA51B88FA2D7"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_858E09935E8397836868F3", "_encstr_A98B0840112B5A452B54"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_A6770BE5021FC8BBB422EA02BF", "_encstr_82910B7A09C0C5AAAD535F53A7"];
          break;
      }

      break;
    case "_encstr_AFDD05A6AB763B":
      return "_encstr_BD060D9B3F48B9098FC1A169DAA7B4";
    case "_encstr_A1470989E6EB65D9D83F30":
      return "_encstr_BA090ED4634AD742CFC7BBABA36F5A77";
    case "_encstr_9A190463ADB3":
      var_5["_encstr_A2650D3B7B57574AFFAF4BDCA3811A"] = 50;
      var_5["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 35;
      var_5["_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065"] = 15;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_A2650D3B7B57574AFFAF4BDCA3811A":
          var_3["_encstr_A3C7077A7067DF7FF0"] = [75, "_encstr_95C3065A833B8F37"];
          var_3["_encstr_B8A20530467FE8"] = [100, "_encstr_8CC806AC2E036A82", "_encstr_8E5F063CDA2C3BCD"];
          break;
        case "_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065":
          var_3["_encstr_A915089310535272F196"] = [100, "_encstr_A98B0840112B5A452B54"];
          var_3["_encstr_B8A20530467FE8"] = [100, "_encstr_8CC806AC2E036A82", "_encstr_8E5F063CDA2C3BCD"];
          break;
        case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_A1B50AB34B01F3D8501868A5", "_encstr_A28305178878FF", "_encstr_9539066128083785", "_encstr_877A067A5714507E"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_AAC00736D0F8CE77E0", "_encstr_8AC0074B3B47309AF2", "_encstr_85E508032BD7D638C537", "_encstr_91E90AB98EDE8DB6CCED6319"];
          var_3["_encstr_B8A20530467FE8"] = [50, "_encstr_8CC806AC2E036A82", "_encstr_8E5F063CDA2C3BCD"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8CDA09374D13A3C330FB93", "_encstr_874F0A5F2B0F9BDC2081FC85"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_A98B0840112B5A452B54"];
          break;
      }

      break;
    case "_encstr_8D940738966ED1DB8D":
      var_5["_encstr_9106102387E011DF472978E0722F376ADAB9"] = 50;
      var_5["_encstr_8BE20ED75722A6731BF84F3064CA126B"] = 35;

      switch (var_1) {
        case "_encstr_9106102387E011DF472978E0722F376ADAB9":
          var_3["_encstr_B8A20530467FE8"] = [35, "_encstr_8E5F063CDA2C3BCD"];
        case "_encstr_8BE20ED75722A6731BF84F3064CA126B":
          var_3["_encstr_B8A20530467FE8"] = [35, "_encstr_8E5F063CDA2C3BCD"];
          break;
      }

      break;
    case "_encstr_A65B084B38A76BEFC350":
      var_5["_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06"] = 50;
      var_5["_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253"] = 35;

      switch (var_1) {
        case "_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06":
          var_3["_encstr_9BC007FBBD680FA49F"] = [80, "_encstr_85E508032BD7D638C537", "_encstr_AAC00736D0F8CE77E0", "_encstr_8AC0074B3B47309AF2", "_encstr_9BC007FBBD680FA49F"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_858E09935E8397836868F3", "_encstr_A98B0840112B5A452B54"];
          break;
        case "_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253":
          var_3["_encstr_810B070B2B8730D3FB"] = [100, "_encstr_B8FB06FF97EA2708"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [75, "_encstr_85E508032BD7D638C537", "_encstr_AAC00736D0F8CE77E0", "_encstr_8AC0074B3B47309AF2", "_encstr_9BC007FBBD680FA49F"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_858E09935E8397836868F3", "_encstr_A98B0840112B5A452B54"];
          break;
      }

      break;
    case "_encstr_BE1904DCDA9D":
      var_5["_encstr_826B0D691C902EABB02913EB9F638B"] = 90;
      var_5["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 10;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_826B0D691C902EABB02913EB9F638B":
          var_3["_encstr_810B070B2B8730D3FB"] = [100, "_encstr_B22C08B072BFF181D30A"];
          break;
        case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_A1B50AB34B01F3D8501868A5", "_encstr_A28305178878FF", "_encstr_9539066128083785", "_encstr_877A067A5714507E"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [100, "_encstr_8AC0074B3B47309AF2"];
          var_3["_encstr_B8A20530467FE8"] = [50, "_encstr_8E5F063CDA2C3BCD"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8CDA09374D13A3C330FB93", "_encstr_874F0A5F2B0F9BDC2081FC85"];
          var_3["_encstr_A915089310535272F196"] = [100, "_encstr_91A51015B15250F37F9B3B6052073588EA0C"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_8A07035972", "_encstr_AA7608ECD89B6BDE5B59", "_encstr_97D506F770BFFFBB", "_encstr_ADBD0780C4884FEE86"];
          break;
      }

      break;
    case "_encstr_850707F7E5833355B8":
      var_5["_encstr_82660D691C902EABA8293197FB038E"] = 50;
      var_5["_encstr_A52C0E7020307103407898128DC7C6CB"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_A52C0E7020307103407898128DC7C6CB":
          var_3["_encstr_810B070B2B8730D3FB"] = [100, "_encstr_B8FB06FF97EA2708"];
          var_3["_encstr_9B6B081A7BABC93A37DE"] = [100, "_encstr_9B6B081A7BABC93A37DE"];
          var_3["_encstr_B8A20530467FE8"] = [35, "_encstr_8E5F063CDA2C3BCD"];
          break;
        case "_encstr_82660D691C902EABA8293197FB038E":
          var_3["_encstr_810B070B2B8730D3FB"] = [100, "_encstr_B8FB06FF97EA2708"];
          var_3["_encstr_9B6B081A7BABC93A37DE"] = [100, "_encstr_9B6B081A7BABC93A37DE"];
          var_3["_encstr_B8A20530467FE8"] = [35, "_encstr_8E5F063CDA2C3BCD"];
          break;
      }

      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

getweapon_ru(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "_encstr_965306392D3336B2":
      var_5["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 70;
      var_5["_encstr_AC5B11276F638919E0863E8278603213977BC2"] = 30;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
          var_3["_encstr_810B070B2B8730D3FB"] = [70, "_encstr_86C312AF5E7BAA8E6B0A45D8D38007C95B90A2F9", "_encstr_A33912F98243B7B7D4018D888FEFC98B78FBC2FE", "_encstr_AF6914926D116B8F215083AAA071C7EF29C71B2C5F13", "_encstr_9A691442E5A941B822AB65F3B92B5131A777AB1B50AF"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [100, "_encstr_83B21103731F68C24B37472F1F121BD8A7DB03", "_encstr_81B810D235CF2273D05857B760683CAA01EC", "_encstr_9761120B917BA62FB46052DA4E1F179CB03FC437", "_encstr_A5C812CF9B380723528F2BD59FE1AA412C984C44"];
          var_3["_encstr_B8A20530467FE8"] = [20, "_encstr_A9C50E23E4D5ADDCF5C2B6A51BDB866E"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_A11C11CE93B4836759278EEB2CB6D28DB743DC", "_encstr_8F6510809BE421C86FA0786F835770D71B57", "_encstr_A11C11CE93B4836759278EEB2CB6D28DB743DC"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_84250FC458391BB63BAF855B4B36ED689B", "_encstr_AD5510DE4106CF4B0F332E80A8A90940DBE7"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_93EC0A7FB846D742618C4A83"];
          var_3["_encstr_8261067B1D34AC27"] = [15, "_encstr_A99A0C5109A7C1952C5B79988202"];
          break;
        case "_encstr_AC5B11276F638919E0863E8278603213977BC2":
          var_3["_encstr_810B070B2B8730D3FB"] = [70, "_encstr_B1F60E0303F402A5785EF7FEF330B86F", "_encstr_BAF60EE42B66C656E1AF2B5837E8C0C8", "_encstr_BDCC0C34BDD8DEEB59169B3A0C89", "_encstr_857812E778880F99BBC7A29B97FB51D9F3B06327"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_A18A11E6477BD8DAA1EB856EB42B3939586246", "_encstr_8A0B11DBF30F1EF0BDFF5B77E127E05EDF5F7B", "_encstr_97491173CBF0C794C8E7011BA3501A5B2F8B9F"];
          var_3["_encstr_B8A20530467FE8"] = [20, "_encstr_9A2810F06B16766ED72C375AB2E4E4856264"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8B7208D9AA51B88FA2D7"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_83CD129816398D57B9D1F585DC2DAC3939161364", "_encstr_A6CE13CA01F2E88202C00CF92BB7DB9DEB06E7FFDE", "_encstr_8D241289C2C936DEDC767D85E6D2AC9CE42C6264"];
          var_3["_encstr_8261067B1D34AC27"] = [15, "_encstr_9B6B081A7BABC93A37DE"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_88270B9BE59120260B9BFD6343"];
          break;
      }

      break;
    case "_encstr_A11804C86B39":
      switch (var_1) {
        case "_encstr_92DF0ED45BDA2E53D81F08FF1B5F9FC2":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_812011C8EB2003AF72E50F9DF1CAC3689D2E7A"];
          var_3["_encstr_8261067B1D34AC27"] = [100, "_encstr_B87B0D413AB3D5FB9AAD7BC759E74B"];
          break;
      }

      break;
    case "_encstr_A1470989E6EB65D9D83F30":
      break;
    case "_encstr_9A190463ADB3":
      switch (var_1) {
        case "_encstr_A2650D3B7B57574AFFAF4BDCA3811A":
          var_3["_encstr_8261067B1D34AC27"] = [50, "_encstr_9BF00C3BF8BBD7FA7FFF148CE937"];
          break;
      }

      break;
    case "_encstr_8D940738966ED1DB8D":
      break;
    case "_encstr_A65B084B38A76BEFC350":
      var_5["_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06"] = 50;
      var_5["_encstr_8A5C0FA8E32097400C0797904EA782221F"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_B1F60E0303F402A5785EF7FEF330B86F", "_encstr_BAF60EE42B66C656E1AF2B5837E8C0C8"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_85F51126836A5FF8FE3779E8CF05F18FC7FB3F"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_99AC12C22FD3578C4F18C389E0B705C7A82B1F28", "_encstr_8AD51126E6937DA8F8845F70B853357F5FCF4F"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [25, "_encstr_8AEB127693D2078DABB9E8AF4EDB6BCAB7E07381"];
          var_3["_encstr_8261067B1D34AC27"] = [50, "_encstr_A99A0C5109A7C1952C5B79988202"];
          break;
        case "_encstr_8A5C0FA8E32097400C0797904EA782221F":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_B1F60E0303F402A5785EF7FEF330B86F", "_encstr_BAF60EE42B66C656E1AF2B5837E8C0C8"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [75, "_encstr_88371073DB384990451F5127CF0AF9429A67", "_encstr_93EF0F670840D30269101D126623CBC943"];
          var_3["_encstr_B8A20530467FE8"] = [75, "_encstr_9A6B0EC7F2CB4308C66AE6F7D953DBE7"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_9A22113185393743ED39D1EBF69B1B85E498C8", "_encstr_86180F138539B5B4C8BEEDE6B1C293C491", "_encstr_A59F1026B0C9C6DBDC3BAFDB9BD8584E8991"];
          var_3["_encstr_8261067B1D34AC27"] = [50, "_encstr_9B6B081A7BABC93A37DE"];
          break;
      }

      break;
    case "_encstr_BE1904DCDA9D":
      var_5["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 70;
      var_5["_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065"] = 30;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_B1F60E0303F402A5785EF7FEF330B86F", "_encstr_BAF60EE42B66C656E1AF2B5837E8C0C8", "_encstr_BDCC0C34BDD8DEEB59169B3A0C89"];
          var_3["_encstr_B8A20530467FE8"] = [30, "_encstr_8CD00D8C39EAB6DCD72C5D767B6333"];
          var_3["_encstr_8261067B1D34AC27"] = [50, "_encstr_A30D0BF0D3D00F8868421252CF"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_AB1E10CB83060B5048633BC939A06702D115"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_8C610C76E4961C3BAC393A375BD9", "_encstr_83050B9D9C4B1C859BCECDD6B3"];
          break;
        case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
          var_3["_encstr_A915089310535272F196"] = [100, "_encstr_AD5510DE4106CF4B0F332E80A8A90940DBE7"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [100, "_encstr_A5C812CF9B380723528F2BD59FE1AA412C984C44", "_encstr_83B21103731F68C24B37472F1F121BD8A7DB03", "_encstr_81B810D235CF2273D05857B760683CAA01EC", "_encstr_81B810D235CF2273D05857B760683CAA01EC"];
          var_3["_encstr_B8A20530467FE8"] = [100, "_encstr_ABF70F6C8563B9DA3BF585AD4BD8F6686E", "_encstr_997B14B11663CD5B9D234EBAD6E6EBC2ADB4B1DE0D9B"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_A11C11CE93B4836759278EEB2CB6D28DB743DC", "_encstr_92E710295AA1487F32475F2B5F6A316814E3"];
          var_3["_encstr_8261067B1D34AC27"] = [50, "_encstr_A99A0C5109A7C1952C5B79988202"];
          var_3["_encstr_810B070B2B8730D3FB"] = [70, "_encstr_A33912F98243B7B7D4018D888FEFC98B78FBC2FE", "_encstr_AF6914926D116B8F215083AAA071C7EF29C71B2C5F13", "_encstr_9A691442E5A941B822AB65F3B92B5131A777AB1B50AF"];
          break;
      }

      break;
    case "_encstr_850707F7E5833355B8":
      switch (var_1) {
        case "_encstr_82660D691C902EABA8293197FB038E":
          var_3["_encstr_8261067B1D34AC27"] = [100, "_encstr_B87B0D413AB3D5FB9AAD7BC759E74B"];
          break;
      }

      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

getweapon_reb(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "_encstr_965306392D3336B2":
      var_5["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 50;
      var_5["_encstr_A9FA0E8BE3BF871942571010A378F033"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
          var_3["_encstr_810B070B2B8730D3FB"] = [10, "_encstr_86C312AF5E7BAA8E6B0A45D8D38007C95B90A2F9"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_847611E647F6C6D6365BB37D0BDAA536ED1A73", "_encstr_83B21103731F68C24B37472F1F121BD8A7DB03", "_encstr_81B810D235CF2273D05857B760683CAA01EC", "_encstr_9761120B917BA62FB46052DA4E1F179CB03FC437"];
          var_3["_encstr_B8A20530467FE8"] = [20, "_encstr_A9C50E23E4D5ADDCF5C2B6A51BDB866E", "_encstr_97B90E17A849F7BA6703A51DD5B723C1"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_A11C11CE93B4836759278EEB2CB6D28DB743DC", "_encstr_8F6510809BE421C86FA0786F835770D71B57", "_encstr_A7DC105F2B0F9BDC49817CC418F0B407593B"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_84250FC458391BB63BAF855B4B36ED689B", "_encstr_A26F10DFB86860E8976147C34C2FFF27FBAB"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_93EC0A7FB846D742618C4A83"];
          var_3["_encstr_8261067B1D34AC27"] = [15, "_encstr_991911AA65B9AF961F887A420ACF413F735151"];
          break;
        case "_encstr_A9FA0E8BE3BF871942571010A378F033":
          var_3["_encstr_810B070B2B8730D3FB"] = [15, "_encstr_857812E778880F99BBC7A29B97FB51D9F3B06327"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_9B570EE63AB736DA1A7D9985D838862C", "_encstr_93F20EFE3CF721874DA95060B26259B9", "_encstr_84B90EE6A3DEC6B5CDD799C2D8380D0B"];
          var_3["_encstr_B8A20530467FE8"] = [20, "_encstr_AB9A0D2809FF29AB37F6D1C8286989"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8B7208D9AA51B88FA2D7"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_A7190F787AF2A998C3E728BCF913A3699E", "_encstr_8F610FA8AA22076B07A478EC8943F3D94E", "_encstr_82BF10A9BE9A70DB0233E9B78B0A11B02816"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_88270B9BE59120260B9BFD6343"];
          break;
      }

      break;
    case "_encstr_A11804C86B39":
      switch (var_1) {
        case "_encstr_A52C0E7020307103407898128DC7C6CB":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_AD0111E67383C96E6CDB1CB2BEAD96B1DBE407", "_encstr_8FCA0F3BE9E636F6E0CAF55B2D63DB7207"];
          var_3["_encstr_B8A20530467FE8"] = [30, "_encstr_8C5D0D3CDAC2B3DCEBDA5AC6B7C9C1"];
          var_3["_encstr_8261067B1D34AC27"] = [40, "_encstr_B87B0D413AB3D5FB9AAD7BC759E74B"];
          break;
      }

      break;
    case "_encstr_A1470989E6EB65D9D83F30":
      break;
    case "_encstr_9A190463ADB3":
      var_5["_encstr_A2650D3B7B57574AFFAF4BDCA3811A"] = 50;
      var_5["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 35;
      var_5["_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065"] = 15;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_A2650D3B7B57574AFFAF4BDCA3811A":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_8AF30E93ACCCD8953CEBBB2B37D10689", "_encstr_857812E778880F99BBC7A29B97FB51D9F3B06327", "_encstr_BDCC0C34BDD8DEEB59169B3A0C89"];
          var_3["_encstr_A3C7077A7067DF7FF0"] = [75, "_encstr_9BF00C3BF8BBD7FA7FFF148CE937"];
          var_3["_encstr_B8A20530467FE8"] = [35, "_encstr_A3E40C4038F0BA3EEE23B098FC98", "_encstr_84A90C8B88B34D139717EC64718F"];
          break;
        case "_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_8AF30E93ACCCD8953CEBBB2B37D10689", "_encstr_8BD10CF0CA25CFEE9F71AE2518F6", "_encstr_BDCC0C34BDD8DEEB59169B3A0C89"];
          var_3["_encstr_AB9B07E086B369B41B"] = [100, "_encstr_8A420E70F798444A4C7FF938774F3B5E"];
          var_3["_encstr_95190460FFF8"] = [100, "_encstr_AA5C13F33F8D3BDD4F58533B08BF99C79B947764C4", "_encstr_ABDC0E0A1109F31D70EF3915A7086513"];
          var_3["_encstr_93EF057BE801C2"] = [50, "_encstr_92AE0D2A255A09094D174F21D071AA"];
          break;
        case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
          var_3["_encstr_A915089310535272F196"] = [100, "_encstr_84250FC458391BB63BAF855B4B36ED689B"];
          var_3["_encstr_A3C7077A7067DF7FF0"] = [50, "_encstr_87BD0EE253835D1B20B92A3220B71203"];
          var_3["_encstr_B8A20530467FE8"] = [100, "_encstr_AC87145FD858B40A2FD572AB49EFE1414070FBE7CA9B", "_encstr_9A870F9A28403085A8179EAA906DD85C2B"];
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_886D14E4AC9936B2C3B9A3588936AC7DBB95DC1D814C", "_encstr_86C312AF5E7BAA8E6B0A45D8D38007C95B90A2F9", "_encstr_A33912F98243B7B7D4018D888FEFC98B78FBC2FE"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [75, "_encstr_847611E647F6C6D6365BB37D0BDAA536ED1A73"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_A7DC105F2B0F9BDC49817CC418F0B407593B"];
          var_3["_encstr_8261067B1D34AC27"] = [50, "_encstr_991911AA65B9AF961F887A420ACF413F735151"];
          break;
      }

      break;
    case "_encstr_8D940738966ED1DB8D":
      break;
    case "_encstr_A65B084B38A76BEFC350":
      switch (var_1) {
        case "_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06":
          var_3["_encstr_9BC007FBBD680FA49F"] = [100, "_encstr_85F51126836A5FF8FE3779E8CF05F18FC7FB3F", "_encstr_8B9810DC47DBD8DA1ABE27ED6BACF61C9B0C", "_encstr_8FB910035580E7BCB9A173BA28F3F5C2F31F", "_encstr_83A4109B47DEB16D9BFA93DBB5CAB7C16E81"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_99AC12C22FD3578C4F18C389E0B705C7A82B1F28", "_encstr_8AD51126E6937DA8F8845F70B853357F5FCF4F"];
          break;
      }

      break;
    case "_encstr_BE1904DCDA9D":
      var_5["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 70;
      var_5["_encstr_826B0D691C902EABB02913EB9F638B"] = 15;
      var_5["_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D"] = 15;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "_encstr_826B0D691C902EABB02913EB9F638B":
          var_3["_encstr_810B070B2B8730D3FB"] = [50, "_encstr_9BFD0B5FE73D8C4D4F2CAF38C0", "_encstr_8AF30E93ACCCD8953CEBBB2B37D10689", "_encstr_B1F60E0303F402A5785EF7FEF330B86F", "_encstr_BAF60EE42B66C656E1AF2B5837E8C0C8"];
          break;
        case "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6":
          var_3["_encstr_A915089310535272F196"] = [100, "_encstr_AD5510DE4106CF4B0F332E80A8A90940DBE7"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [100, "_encstr_A5C812CF9B380723528F2BD59FE1AA412C984C44", "_encstr_81B810D235CF2273D05857B760683CAA01EC", "_encstr_81B810D235CF2273D05857B760683CAA01EC"];
          var_3["_encstr_B8A20530467FE8"] = [100, "_encstr_ABF70F6C8563B9DA3BF585AD4BD8F6686E", "_encstr_997B14B11663CD5B9D234EBAD6E6EBC2ADB4B1DE0D9B"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_A11C11CE93B4836759278EEB2CB6D28DB743DC", "_encstr_92E710295AA1487F32475F2B5F6A316814E3"];
          var_3["_encstr_810B070B2B8730D3FB"] = [30, "_encstr_886D14E4AC9936B2C3B9A3588936AC7DBB95DC1D814C", "_encstr_886D14E4AC9936B2C3B9A3588936AC7DBB95DC1D814C", "_encstr_AF6914926D116B8F215083AAA071C7EF29C71B2C5F13"];
          break;
        case "_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D":
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_8E4F0FB38550376C6DD0514A104B62F7C3", "_encstr_A7C20E5FDBB0113F994960C048AF1663", "_encstr_BDD10EB9D1DEC66DDCF56B385883B0A9"];
          var_3["_encstr_B8A20530467FE8"] = [35, "_encstr_A3DA0D4639AEDAE6F5DA0E2C07C2A9"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [35, "_encstr_8C610C76E4961C3BAC393A375BD9"];
          var_3["_encstr_810B070B2B8730D3FB"] = [30, "_encstr_B256149C59991BACE1AFEEB2DC1D0313EB969CDBDCDC", "_encstr_B1F60E0303F402A5785EF7FEF330B86F", "_encstr_BAF60EE42B66C656E1AF2B5837E8C0C8", "_encstr_9BFD0B5FE73D8C4D4F2CAF38C0"];
          break;
      }

      break;
    case "_encstr_850707F7E5833355B8":
      switch (var_1) {
        case "_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C":
          var_3["_encstr_810B070B2B8730D3FB"] = [100, "_encstr_9158126EDC83E49B1BB783567D0BD838340BA981", "_encstr_8C2310DB7AAF7A3F5B701FEF1073E082CBB7"];
          var_3["_encstr_A915089310535272F196"] = [50, "_encstr_AA680F23A0E3DD2271109ED5EF31FACD03", "_encstr_BE8F11E627EB26D952D0B44146A0FBC282E667"];
          var_3["_encstr_9B6B081A7BABC93A37DE"] = [100, "_encstr_885E09D8B0B959E4C219B9"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [50, "_encstr_A6160F1F8C2DE85A5B11F158CB63070292", "_encstr_A7860FCD1DBD36B686FA0B36380D58A603", "_encstr_A3430F8634FF299F92A150636B6C432B5A"];
          var_3["_encstr_8261067B1D34AC27"] = [25, "_encstr_BA920A9896E07B8CB9CD1C27"];
          var_3["_encstr_B8A20530467FE8"] = [35, "_encstr_93250EC9556E08965732901B8A876D6A"];
          break;
      }

      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

getweapon_sas(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "_encstr_965306392D3336B2":
      return make_weapon_special("_encstr_96AA0737B0B9FA8539");
    case "_encstr_A11804C86B39":
      break;
    case "_encstr_A1470989E6EB65D9D83F30":
      break;
    case "_encstr_9A190463ADB3":
      break;
    case "_encstr_8D940738966ED1DB8D":
      return make_weapon_special("_encstr_A60B0E6B4157F7BAEAE1D7F241A87617");
    case "_encstr_A65B084B38A76BEFC350":
      break;
    case "_encstr_BE1904DCDA9D":
      break;
    case "_encstr_850707F7E5833355B8":
      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

getweapon_so15(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "_encstr_965306392D3336B2":
      break;
    case "_encstr_A11804C86B39":
      break;
    case "_encstr_A1470989E6EB65D9D83F30":
      break;
    case "_encstr_9A190463ADB3":
      break;
    case "_encstr_8D940738966ED1DB8D":
      if(level.script == "_encstr_AC890B1398B9BBCA2953F5ED43" || level.script == "_encstr_973C1269B3EE87A41138EBB2406F9E0B202BF5F3")
        return make_weapon_special("_encstr_B460132B20C97EEE5B0F4F6AC9D967046F50A232E0");
      else
        return make_weapon_special("_encstr_A60B0E6B4157F7BAEAE1D7F241A87617");
    case "_encstr_A65B084B38A76BEFC350":
      break;
    case "_encstr_BE1904DCDA9D":
      break;
    case "_encstr_850707F7E5833355B8":
      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

getweapon_usmc(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "_encstr_965306392D3336B2":
      switch (var_1) {
        case "_encstr_8C160DAFE71BF161681EB5BCB0F8FC":
          var_3["_encstr_810B070B2B8730D3FB"] = [85, "_encstr_8AF30E93ACCCD8953CEBBB2B37D10689", "_encstr_97F30E20E22F611123977465933BF365", "_encstr_8C570C0DED1B7B7DDD2B371D0C26", "_encstr_AD82121636ED9DFABBAC371D6098BEA539B7736E", "_encstr_9BFD0B5FE73D8C4D4F2CAF38C0"];
          var_3["_encstr_9BC007FBBD680FA49F"] = [70, "_encstr_A9010D87B392D6301CA1D0A854FD02", "_encstr_A7A50DCDE8DBD86D6EFADA4BDA2B86", "_encstr_A3820DC42C6C5BD75BB4DAAC0D1F89", "_encstr_A7820DC4B08DADF56BA5DA56D0E346"];
          var_3["_encstr_B8A20530467FE8"] = [50, "_encstr_84D60CAB40EBFFEFF6A179634D73", "_encstr_A5350C12C80F690F981ACD94A9AB", "_encstr_86350CE238FFF99F08AA7D2439BB"];
          var_3["_encstr_BE2906CF4DE0B27F"] = [50, "_encstr_AB45097102C9209CFA7B51", "_encstr_8B7208D9AA51B88FA2D7", "_encstr_8A610C7639960E3BB29347C19CF6", "_encstr_95060BECE4D2C1B073D93893BD"];
          var_3["_encstr_A915089310535272F196"] = [70, "_encstr_91FE0F5E364B8F680F93F0B1F75140EB57", "_encstr_AC300EA8BB457D2BD7DD030AAD02528D"];
          var_3["_encstr_B86F0DDB5E372B1EAB0A5B43524B56"] = [15, "_encstr_A6770BE5021FC8BBB422EA02BF"];
          var_3["_encstr_A28D0A2BDC1989853993B2B1"] = [65, "_encstr_8DA90B8F58028E0B6B61854235", "_encstr_979105A70F05D8", "_encstr_8F1D06CA9E890FC7", "_encstr_972E0C369637950BE4C493B0DAAC", "_encstr_91EC068D0B372B93", "_encstr_9B6B081A7BABC93A37DE"];
          var_3["_encstr_8261067B1D34AC27"] = [50, "_encstr_85580C43433671ED3018376BD2DA", "_encstr_AD580CDAC18EB74867C2692A4AF2"];
          break;
      }

      break;
    case "_encstr_A11804C86B39":
      break;
    case "_encstr_A1470989E6EB65D9D83F30":
      break;
    case "_encstr_9A190463ADB3":
      break;
    case "_encstr_8D940738966ED1DB8D":
      break;
    case "_encstr_A65B084B38A76BEFC350":
      break;
    case "_encstr_BE1904DCDA9D":
      break;
    case "_encstr_850707F7E5833355B8":
      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

make_weapon_special(var_0) {
  switch (var_0) {
    case "_encstr_9B3909ACC6BB5B98CF0F10":
      var_0 = make_weapon("_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6", ["_encstr_991911AA65B9AF961F887A420ACF413F735151", "_encstr_85E00F26B06C6DFA58DAA5D8BD0D73E313", "_encstr_A26F10DFB86860E8976147C34C2FFF27FBAB", "_encstr_97B90E17A849F7BA6703A51DD5B723C1", "_encstr_A7DC105F2B0F9BDC49817CC418F0B407593B"]);
      break;
    case "_encstr_8FE50C9208356B590845C9D87B28":
      var_0 = make_weapon("_encstr_92DF0ED45BDA2E53D81F08FF1B5F9FC2", ["_encstr_81280F86E540468A700AE94A43F3D572B1", "_encstr_B28A0D392B6C7DB5B4D6AC6286F198", "_encstr_A31712CBF56933B20EB7D05EE8FA72218787B943", "_encstr_97460FFF2B180E1BF88BEFEFF3B7676482", "_encstr_81920D10E6A739715A7F13833A3367"]);
      break;
    case "_encstr_B2BA0CA06AF7415E7BA97EF5B753":
      var_0 = make_weapon("_encstr_9106102387E011DF472978E0722F376ADAB9", ["_encstr_93830FFEAD47260B8C6AC86267B26B9AEA", "_encstr_AA820F5547F1C7BDEF10F32E0BEA67F1DE", "_encstr_B4D911D239C3527DF6488F9F1063694F0B490A"]);
      break;
    case "_encstr_A6B30A8390E304AE91A7F57A":
      var_0 = make_weapon("_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065", ["_encstr_92AE0D2A255A09094D174F21D071AA", "_encstr_BA2B0F9993DB738EAF2CAEB37B3699F189", "_encstr_864E0D42375817EB40F208227A3112", "_encstr_83B9119BA0394A57E0F19FD9154927954D9077"]);
      break;
    case "_encstr_87730DA1C2C82D4EBE9BB95AC1B29C":
      var_0 = make_weapon("_encstr_990E1AB477E0F5CD377D4391C9EDAD95DB7D1385D88DD29BD12DD86E", ["_encstr_9B8E1B2C8823D7E0789701B07B923813EA7530BE26AA816843CB48F01F", "_encstr_929E0E3D498322702E89ECCBE098D710", "_encstr_95CF0E4E568DD70D1927B7D6B2DB3E89", "_encstr_B2C90F11919E9B112A9342CF9205D8291B", "_encstr_8E2B106A98D79DD316C3949A68785F65492A", "_encstr_AC960E254F50C9BBC1E2B853F28FD10A"]);
      break;
    case "_encstr_96AA0737B0B9FA8539":
      var_0 = make_weapon("_encstr_99550F225BABC7E65077BBB13990FBCE96", ["_encstr_8C570C0DED1B7B7DDD2B371D0C26", "_encstr_9B6B081A7BABC93A37DE", "_encstr_930E0E321D7741D390A0770242838CEF", "_encstr_B1EB0FBD52CEE879CF4AC167A79A13794B", "_encstr_963D10358A2D80D59752F0583A122E3281A1", "_encstr_8B9A0E5B16D9D7DA5AD8F6869966C798"]);
      break;
    case "_encstr_9AFA09133BBFA638D969E5":
      var_0 = make_weapon("_encstr_99550F225BABC7E65077BBB13990FBCE96", ["_encstr_9A350ED80B0645883BEF0C0DBB03DB8B", "_encstr_9B6B081A7BABC93A37DE", "_encstr_930E0E321D7741D390A0770242838CEF", "_encstr_B1EB0FBD52CEE879CF4AC167A79A13794B", "_encstr_963D10358A2D80D59752F0583A122E3281A1", "_encstr_8B9A0E5B16D9D7DA5AD8F6869966C798"]);
      break;
    case "_encstr_B83D084CA3BAB509B143":
      var_0 = make_weapon("_encstr_858110A5BB0EEB16C97DADB134859C1B5AB2", ["_encstr_B174080FE868A13913EE", "_encstr_8AF30E93ACCCD8953CEBBB2B37D10689", "_encstr_87100BCD961BB237B156270C86", "_encstr_9B6B081A7BABC93A37DE", "_encstr_8A7A0F56A3589068B0D0E033F26C5DC1E6", "_encstr_919A102D893EB8706FE2C0E99B0313B091B1", "_encstr_8B8711FA902F0B830160A958DF553DC30D61AF", "_encstr_BD180FD57B80697776C0C2FB685B6F199A"]);
      break;
    case "_encstr_A60B0E6B4157F7BAEAE1D7F241A87617":
      var_0 = make_weapon("_encstr_BAB10F67F72A59E09850B24028F0060E50", ["_encstr_8F680EC9ACC6AFC158385833910C3E91", "_encstr_8DA10EB558767DC1C2381666C806E3C8", "_encstr_AC47109E3DB2E9B147D30B807FC3A3B90B32"]);
      break;
    case "_encstr_B460132B20C97EEE5B0F4F6AC9D967046F50A232E0":
      var_0 = make_weapon("_encstr_BAB10F67F72A59E09850B24028F0060E50", ["_encstr_84680EC2C3A9CF1AD741EF7F0F72B703", "_encstr_99A10E1D3142A19F98834F9267E25FE2", "_encstr_8C4710CD1BA58C56D71C0B380BCC2303BEC9"]);
      break;
    case "_encstr_A5CF0E190E2A5BE8031791AB4FCB20C0":
      var_0 = make_weapon("_encstr_8BE20ED75722A6731BF84F3064CA126B", ["_encstr_88860D9356D8BEECEDB1CC2313E326", "_encstr_95030DDAC276BE3BED6333C889F898", "_encstr_93070F9F142C50DD1712B0D82A8AAFC852"]);
      break;
    case "_encstr_B67D14596E47854759AF1D2B0BB9CAE4EB0EE42DB12B":
      var_0 = make_weapon("_encstr_99550F225BABC7E65077BBB13990FBCE96", ["_encstr_9A350ED80B0645883BEF0C0DBB03DB8B", "_encstr_9B6B081A7BABC93A37DE", "_encstr_87100BCD961BB237B156270C86", "_encstr_930E0E321D7741D390A0770242838CEF", "_encstr_8B9A0E5B16D9D7DA5AD8F6869966C798", "_encstr_AAC00736D0F8CE77E0"]);
      break;
    case "_encstr_A9DB0E5FBEE11A64B9E1F3BF38532D73":
      var_0 = make_weapon("_encstr_99550F225BABC7E65077BBB13990FBCE96", ["_encstr_8AF30E93ACCCD8953CEBBB2B37D10689", "_encstr_9B6B081A7BABC93A37DE", "_encstr_87100BCD961BB237B156270C86", "_encstr_930E0E321D7741D390A0770242838CEF", "_encstr_8B9A0E5B16D9D7DA5AD8F6869966C798", "_encstr_AAC00736D0F8CE77E0"]);
      break;
    default:
      var_0 = undefined;
  }

  return var_0;
}

make_weapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._weapons))
    level._weapons = spawnStruct();

  if(!isDefined(var_1))
    var_1 = [];

  if(!issameweapon(var_0)) {
    var_6 = strtok(var_0, "_encstr_BE4C0295");

    if(var_6.size > 1) {
      var_0 = var_6[0];
      var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::array_remove(var_6, var_6[0]));
    }
  } else {
    if(nullweapon(var_0))
      return var_0;

    var_0 = getweaponbasename(var_0);
  }

  if(istrue(var_5))
    var_7 = ::makeweaponfromstring;
  else
    var_7 = ::getcompleteweaponname;

  var_8 = var_0;

  if(issubstr(var_0, "_encstr_851A049F8337"))
    var_8 = scripts\cp\utility::getweaponrootname(var_0);

  var_9 = scripts\cp\utility::weaponattachdefaultmap(var_8);
  var_9 = removeconflictingattachments(var_1, var_9);
  var_1 = scripts\engine\utility::array_combine(var_1, var_9);
  var_10 = scripts\cp\utility::buildweaponassetname(var_8, var_4);
  var_11 = [];

  foreach(var_13 in var_1) {
    if(issubstr(var_13, "_encstr_854C021F")) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_13);
      var_1[var_1.size] = strtok(var_13, "_encstr_854C021F")[0];
      var_11[var_11.size] = var_13;
    }
  }

  var_15 = buildweaponuniqueattachments(var_8, var_1, var_4);
  var_15 = checkforinvalidattachments(var_15, var_10);
  var_1 = var_15;

  if(isDefined(var_4))
    var_16 = call[[var_7]](var_10, var_1, var_2, var_3, var_4);
  else if(isDefined(var_3))
    var_16 = call[[var_7]](var_10, var_1, var_2, var_3);
  else if(isDefined(var_2))
    var_16 = call[[var_7]](var_10, var_1, var_2);
  else if(isDefined(var_1))
    var_16 = call[[var_7]](var_10, var_1);
  else
    var_16 = call[[var_7]](var_10);

  foreach(var_13 in var_11) {
    var_6 = strtok(var_13, "_encstr_854C021F");
    var_16 = var_16 withattachment(var_6[0], int(var_6[1]));
  }

  return var_16;
}

removeconflictingattachments(var_0, var_1) {
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_B61904310B39", "_encstr_97DD07C766BF821C86");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_A98B0840112B5A452B54", "_encstr_92ED07277352F5E08F");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_95A3082BA8EBCBFB578D", "_encstr_884F07107B76D5B947");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_B1AD067FC8C8B2A7", "_encstr_8F8206A61AFA808F");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_8719041B0BB1", "_encstr_96A20532C95497");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_8CC806AC2E036A82", "_encstr_96A20532C95497");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_8E5F063CDA2C3BCD", "_encstr_96A20532C95497");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_8E1F05C92C6CB6", "_encstr_96A20532C95497");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_8E1F05C92C6CB6", "_encstr_93C206EE01634A9F");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_A3CA081B50EDAB3D60A9", "_encstr_B8FB06FF97EA2708");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_A28305178878FF", "_encstr_B8FB06FF97EA2708");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_AA1C072756CC63ACF0", "_encstr_B8FB06FF97EA2708");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_BACC05C9770D68", "_encstr_B8FB06FF97EA2708");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_AD7205BC929AE9", "_encstr_8C29062A13EBA3B1");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_8B1F05A32782D6", "_encstr_8B1F05A32782D6");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "_encstr_A79809E505DB3DF9B97B39", "_encstr_A79809E505DB3DF9B97B39");
  return var_1;
}

removeconflictingdefaultattachment(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  foreach(var_6 in var_0) {
    if(issubstr(var_6, var_3))
      var_4 = 1;

    if(isstartstr(var_6, var_2) || istrue(var_4)) {
      for(var_7 = 0; var_7 < var_1.size; var_7++) {
        if(issubstr(var_1[var_7], var_3)) {
          var_1 = scripts\engine\utility::array_remove_index(var_1, var_7);
          return var_1;
        }
      }
    }
  }

  return var_1;
}

randomize_weapon(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::get_random_attachments(var_1, var_2);
  var_4 = make_weapon(var_0, var_3);
  return var_4;
}

getscriptedweapon(var_0, var_1) {
  if(!isDefined(var_0))
    return isundefinedweapon();

  if(!isarray(var_0) && var_0 == "_encstr_B40101")
    return isundefinedweapon();

  if(isDefined(var_1) && var_1 == "_encstr_AF53086E4B46ACC2E4B5")
    var_2 = getweapon(var_0, "_encstr_8D940738966ED1DB8D");
  else
    var_2 = getweapon(var_0, self.scriptedweaponclassprimary);

  return var_2;
}

printweapon() {
  self notify("_encstr_BE7B11F2A350582627FDB7B3E95CBA8150282D");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE7B11F2A350582627FDB7B3E95CBA8150282D");

  for(;;) {
    var_0 = 72;

    if(isDefined(self) && isDefined(self.weapon)) {
      if(isDefined(self.weapon.basename)) {}

      if(isDefined(self.weapon.attachments)) {
        var_1 = var_0 - 1.5;

        foreach(var_4, var_3 in self.weapon.attachments)
        var_1 = var_1 - 1.4;
      }
    }

    waitframe();
  }
}

create_weapon_in_script(var_0, var_1) {
  if(!isDefined(level.fnscriptedweaponassignment)) {
    self.usescriptedweapon = undefined;

    if(!isDefined(var_0))
      var_2 = isundefinedweapon();
    else if(!isarray(var_0) && var_0 == "_encstr_B40101")
      var_2 = isundefinedweapon();
    else if(isarray(var_0))
      var_2 = getcompleteweaponname(var_0[randomint(var_0.size)]);
    else
      var_2 = getcompleteweaponname(var_0);

    if(!nullweapon(var_2)) {
      self.scriptedweaponfailed = 1;

      if(isDefined(var_1) && var_1 == "_encstr_AF53086E4B46ACC2E4B5")
        self.scriptedweaponfailed_sidearmarray = var_0;
      else
        self.scriptedweaponfailed_primaryarray = var_0;
    }

    return var_2;
  } else
    return [[level.fnscriptedweaponassignment]](var_0, var_1);
}

buildweapon_variant(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = weaponattachcustomtoidmap(var_0, var_3);

  if(!isDefined(var_7))
    var_7 = [];

  return buildweapon_attachmentidmap(var_0, var_7, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", var_3, var_4, var_5, var_6);
}

buildweapon_attachmentidmap(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];
  var_9 = [];

  foreach(var_12, var_11 in var_1) {
    var_8[var_8.size] = var_12;
    var_9[var_9.size] = var_11;
  }

  return buildweapon(var_0, var_8, var_2, var_3, var_4, var_9, var_5, var_6, var_7);
}

buildweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(var_0 != "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB") {
    if(issubstr(var_0, "_encstr_851A049F8337"))
      var_0 = scripts\cp\utility::getweaponrootname(var_0);
  }

  if(isDefined(var_1)) {} else
    var_1 = [];

  if(!isDefined(var_2))
    var_2 = "_encstr_8BBA05185F8B99";

  if(isDefined(var_4) && var_4 < 0)
    var_4 = undefined;

  var_9 = scripts\cp\utility::buildweaponassetname(var_0, var_4);
  var_10 = buildweaponattachmentidmap(var_1, var_5);

  if(istrue(var_8)) {
    if(weaponsupportslaserir(var_9)) {
      var_11 = getweaponnvgattachment(var_9);

      if(!scripts\engine\utility::array_contains(var_1, var_11)) {
        var_1[var_1.size] = var_11;

        if(var_10.size > 0)
          var_10[var_11] = 0;
      }
    }
  }

  var_12 = buildweaponuniqueattachmenttoidmap(var_0, var_1, var_4, var_10);

  if(isDefined(var_6) && var_6 != "_encstr_8BBA05185F8B99")
    var_12[var_6] = 0;

  var_12 = filterinvalidattachmentsfromidmap(var_12, var_9);
  var_1 = [];
  var_5 = [];

  foreach(var_15, var_14 in var_12) {
    var_1[var_1.size] = var_15;
    var_5[var_5.size] = var_14;
  }

  var_16 = getcompleteweaponname(var_9, [], undefined, var_2, var_4);

  for(var_17 = 0; var_17 < var_1.size; var_17++)
    var_16 = var_16 withattachment(var_1[var_17], var_5[var_17]);

  if(isDefined(var_7)) {
    for(var_17 = 0; var_17 < var_7.size; var_17++) {
      if(!isDefined(var_7[var_17])) {
        continue;
      }
      var_18 = var_7[var_17];

      if("_encstr_8C07031127" != getsubstr(var_18, 0, 2))
        var_18 = "_encstr_8C07031127" + var_7[var_17];

      var_16 = var_16 setsticker(var_17, var_18);
    }
  }

  if(isDefined(var_16.scope) && !isstartstr(var_16.scope, "_encstr_88B90DB49CEDCD378C95992C578D8E")) {
    var_19 = getreticleindex(var_3);

    if(isDefined(var_19))
      var_16 = var_16 withreticle(var_19);
  }

  return var_16;
}

buildweaponattachmentidmap(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_1)) {
    foreach(var_5, var_4 in var_0) {
      if(var_5 < var_1.size) {
        var_2[var_4] = var_1[var_5];
        continue;
      }

      var_2[var_4] = 0;
    }
  }

  return var_2;
}

buildweaponuniqueattachmenttoidmap(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && var_2 < 0)
    var_2 = undefined;

  if(!isDefined(var_3))
    var_3 = [];

  var_1 = scripts\engine\utility::array_remove(var_1, "_encstr_8BBA05185F8B99");
  var_3 = scripts\engine\utility::array_remove_key(var_3, "_encstr_8BBA05185F8B99");

  if(var_1.size > 0 && var_3.size == 0) {
    foreach(var_5 in var_1)
    var_3[var_5] = 0;
  }

  var_7 = weaponattachdefaulttoidmap(var_0, var_2);
  var_8 = scripts\cp\utility::buildweaponassetname(var_0, var_2);
  var_9 = [];

  if(isDefined(var_7))
    var_9 = combinedefaultandcustomattachmentidmaps(var_7, var_3);

  var_10 = [];

  if(var_9.size > 0) {
    var_9 = filterattachmenttoidmap(var_9, var_0);

    foreach(var_5, var_12 in var_9) {
      var_13 = scripts\cp\utility::attachmentmap_tounique(var_5, var_8);
      var_10[var_13] = var_12;
    }
  }

  var_14 = [];
  var_15 = 0;
  var_16 = undefined;

  foreach(var_23, var_12 in var_10) {
    var_18 = scripts\cp\utility::attachmentmap_toextra(var_23);

    if(isDefined(var_18)) {
      var_19 = 0;

      if(isDefined(var_2)) {
        var_20 = scripts\cp\utility::attachmentmap_tobase(var_18);
        var_19 = attachmentmap_extratovariantid(var_20, var_0, var_2);
      }

      var_21 = scripts\cp\utility::attachmentmap_tounique(var_18, var_8);
      var_14[var_21] = var_19;
    }

    var_22 = scripts\cp\utility::attachmentmap_tobase(var_23);

    if(!isDefined(var_16) && scripts\cp\utility::tv_station_fastrope_two_infil_rider_start_targetname(var_22))
      var_16 = var_23;

    if(!var_15 && (scripts\cp\utility::useeventtype(var_22) || scripts\cp\utility::useeventtimestamp(var_23)))
      var_15 = 1;
  }

  if(var_14.size > 0)
    var_10 = scripts\engine\utility::array_combine_unique_keys(var_10, var_14);

  if(isDefined(var_16) && var_15) {
    var_16 = scripts\engine\utility::ter_op(var_16 == "_encstr_A7AC0DC616D8DCD6D9EBB6A56DB20D", "_encstr_8F7C1046AE3217C0849FB09867A5334F4A57", "_encstr_A1990773BF80C75CD9");
    var_10[var_16] = 0;
  }

  return var_10;
}

combinedefaultandcustomattachmentidmaps(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(scripts\engine\utility::array_contains_key(var_1, var_5)) {
      continue;
    }
    var_2[var_5] = var_4;
  }

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = var_4;

  return var_2;
}

useprophudserver(var_0) {
  if(!issameweapon(var_0))
    return 0;

  switch (var_0.basename) {
    case "_encstr_998712A5DD837D9BCDD7A1C89CBD6BACDBFAD607":
      if(var_0 hasattachment("_encstr_A39B07DDDFC235D08A", 1))
        return 1;
      else
        return 0;

      break;
    case "_encstr_A7A112BAEFD8269AFB470280CE9D487B68210261":
      if(var_0 hasattachment("_encstr_979A07DA7B286267F1", 1))
        return 1;
      else
        return 0;

      break;
    case "_encstr_97411261BC027FA61D095A72B80FCB76CB30FDF0":
      if(var_0 hasattachment("_encstr_979A07DA7B286267F1", 1))
        return 1;
      else
        return 0;

      break;
    case "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1":
      if(var_0 hasattachment("_encstr_979A07DA7B286267F1", 1))
        return 1;
      else
        return 0;

      break;
    case "_encstr_93D811967783AFB9DAEB5BC1C2E0B0D4F5AD83":
      if(var_0 hasattachment("_encstr_979A07DA7B286267F1", 1))
        return 1;
      else
        return 0;

      break;
    default:
      if(var_0 hasattachment("_encstr_979A07DA7B286267F1", 1)) {
        return 1;
        return;
      }

      return 0;
      return;
  }
}

filterattachmenttoidmap(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  foreach(var_6, var_5 in var_0)
  var_3[var_3.size] = var_6;

  if(var_3.size > 0) {
    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      var_6 = var_3[var_7];

      if(var_6 == "_encstr_8BBA05185F8B99") {
        continue;
      }
      var_8 = 1;

      for(var_9 = 0; var_9 < var_2.size; var_9++) {
        if(var_6 == var_2[var_9]) {
          var_8 = 0;
          break;
        }

        var_10 = attachmentsconflict(var_6, var_2[var_9], var_1);

        if(var_10 != "_encstr_B40101") {
          var_8 = 0;
          var_2 = scripts\engine\utility::array_remove_index(var_2, var_9);
          var_11 = [];
          var_11 = strtok(var_10, "_encstr_974C0246");

          foreach(var_14, var_13 in var_11)
          var_3 = scripts\engine\utility::array_insert(var_3, var_13, var_7 + 1 + var_14);

          break;
        }
      }

      if(var_8)
        var_2[var_2.size] = var_6;
    }
  }

  var_15 = [];

  foreach(var_6 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_0[var_6]), var_0[var_6], 0);
    var_15[var_6] = var_5;
  }

  return var_15;
}

filterinvalidattachmentsfromidmap(var_0, var_1) {
  var_2 = getcompleteweaponname(var_1);
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    if(var_2 canuseattachment(var_6)) {
      var_3[var_6] = var_5;
      continue;
    }

    thread invalidattachmentwarning(var_6, var_1);
  }

  return var_3;
}

attachmentscompatible(var_0, var_1) {
  if(scripts\cp\utility::attachmentiscosmetic(var_0) && scripts\cp\utility::attachmentiscosmetic(var_1))
    return 0;

  var_0 = scripts\cp\utility::attachmentmap_tobase(var_0);
  var_1 = scripts\cp\utility::attachmentmap_tobase(var_1);
  var_2 = 1;

  if(var_0 == var_1)
    var_2 = 0;
  else if(isDefined(level.attachmentmap_conflicts)) {
    var_3 = scripts\engine\utility::alphabetize([var_0, var_1]);
    var_2 = !isDefined(level.attachmentmap_conflicts[var_3[0] + "_encstr_BA4C02DF" + var_3[1]]);
  } else if(var_0 != "_encstr_8BBA05185F8B99" && var_1 != "_encstr_8BBA05185F8B99") {
    var_4 = tablelookuprownum("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798", 0, var_1);

    if(tablelookup("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798", 0, var_0, var_4) == "_encstr_BE07036548")
      var_2 = 0;
  }

  return var_2;
}

attachmentsconflict(var_0, var_1, var_2) {
  if(scripts\cp\utility::attachmentiscosmetic(var_0) && scripts\cp\utility::attachmentiscosmetic(var_1))
    return var_0;

  var_3 = undefined;

  if(issameweapon(var_2))
    var_3 = createheadicon(var_2);
  else
    var_3 = var_2;

  var_4 = scripts\cp\utility::attachmentmap_tounique(var_0, var_3);
  var_5 = scripts\cp\utility::attachmentmap_tounique(var_1, var_3);

  if(add_head_icon_on_allies(var_4, var_5))
    return var_0;

  if(add_head_icon_on_allies(var_5, var_4))
    return var_0;

  var_0 = scripts\cp\utility::attachmentmap_tobase(var_0);
  var_1 = scripts\cp\utility::attachmentmap_tobase(var_1);
  var_6 = "_encstr_B40101";

  if(var_0 == var_1)
    var_6 = var_0;
  else if(isDefined(level.attachmentmap_conflicts)) {
    var_7 = scripts\engine\utility::alphabetize([var_0, var_1]);
    var_8 = var_7[0] + "_encstr_BA4C02DF" + var_7[1];

    if(isDefined(level.attachmentmap_conflicts[var_8])) {
      if(level.attachmentmap_conflicts[var_8] == "_encstr_BE07036548")
        var_6 = var_0;
      else
        var_6 = level.attachmentmap_conflicts[var_8];
    }
  }

  return var_6;
}

add_head_icon_on_allies(var_0, var_1) {
  var_2 = carryitemomnvar(var_0);
  var_3 = carryiteminfo(var_1);
  return isDefined(var_2) && isDefined(var_3) && var_3 == var_2;
}

carryiteminfo(var_0) {
  if(isDefined(level.carrier_remove_carriable_weapon[var_0]))
    return level.carrier_remove_carriable_weapon[var_0];

  return undefined;
}

carryitemomnvar(var_0) {
  if(isDefined(level.carryobjects_onjuggernaut[var_0]))
    return level.carryobjects_onjuggernaut[var_0];

  var_1 = scripts\cp\utility::attachmentmap_tobase(var_0);

  if(isDefined(level.carry_ref[var_1]))
    return level.carry_ref[var_1];

  return undefined;
}

attachmentmap_extratovariantid(var_0, var_1, var_2) {
  var_3 = var_1 + "_encstr_854C021F" + var_2;

  if(isDefined(level.weaponlootmapdata[var_3]) && isDefined(level.weaponlootmapdata[var_3].attachextratoidmap) && isDefined(level.weaponlootmapdata[var_3].attachextratoidmap[var_0]))
    return level.weaponlootmapdata[var_3].attachextratoidmap[var_0];

  return 0;
}

weaponattachdefaulttoidmap(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0 + "_encstr_854C021F" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].attachdefaulttoidmap))
      return level.weaponlootmapdata[var_2].attachdefaulttoidmap;
  }

  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].attachdefaulttoidmap))
    return level.weaponmapdata[var_0].attachdefaulttoidmap;

  return undefined;
}

getweaponnvgattachment(var_0) {
  return "_encstr_9B6B081A7BABC93A37DE";
}

weaponattachcustomtoidmap(var_0, var_1) {
  if(isDefined(var_1) && var_1 >= 0) {
    var_2 = var_0 + "_encstr_854C021F" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].attachcustomtoidmap))
      return level.weaponlootmapdata[var_2].attachcustomtoidmap;
  }

  return undefined;
}

buildweaponmap() {
  level.weaponmapdata = [];
  level._id_14589 = [];
  var_0 = tablelookupgetnumrows("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_1, 0);
    var_3 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 4);

    if(var_3 != "_encstr_B40101" && scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_3)) {
      level.weaponmapdata[var_3] = spawnStruct();
      var_4 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 0);

      if(var_4 != "_encstr_B40101")
        level.weaponmapdata[var_3].number = var_4;

      var_5 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 1);

      if(var_5 != "_encstr_B40101") {
        level.weaponmapdata[var_3].group = var_5;
        var_6 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 41);

        if(var_6 != "_encstr_B40101") {
          var_7 = int(var_6);

          if(var_7 > -1) {
            if(!isDefined(level._id_14589[var_5]))
              level._id_14589[var_5] = [];

            level._id_14589[var_5][level._id_14589[var_5].size] = var_3;
          } else
            level.weaponmapdata[var_3]._id_13EFC = 1;
        }
      }

      var_8 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 5);

      if(var_8 != "_encstr_B40101")
        level.weaponmapdata[var_3].assetname = var_8;

      var_9 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 44);

      if(var_9 != "_encstr_B40101")
        level.weaponmapdata[var_3].perk = var_9;

      var_10 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 9);
      var_11 = parseattachdefaulttoidmap(var_10);

      if(isDefined(var_11))
        level.weaponmapdata[var_3].attachdefaulttoidmap = var_11;

      var_12 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_2, 8);

      if(var_12 != "_encstr_B40101") {
        var_12 = float(var_12);
        level.weaponmapdata[var_3].speed = var_12;
      }
    }
  }

  level.weaponlootmapdata = [];
  var_1 = -1;

  for(;;) {
    var_1++;
    var_13 = tablelookupbyrow("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", var_1, 0);

    if(var_13 == "_encstr_B40101") {
      break;
    }

    var_3 = tablelookupbyrow("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", var_1, 1);

    if(!scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_3)) {
      continue;
    }
    var_14 = tablelookupbyrow("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", var_1, 6);
    var_15 = getweaponvarianttablename(var_3);
    var_16 = tablelookup(var_15, 1, var_14, 0);

    if(var_16 == "_encstr_B40101") {
      continue;
    }
    var_17 = var_3 + "_encstr_854C021F" + var_16;
    level.weaponlootmapdata[var_17] = spawnStruct();
    level.weaponlootmapdata[var_17].variantid = int(var_16);
    var_18 = tablelookup(var_15, 1, var_14, 3);

    if(var_18 != "_encstr_B40101")
      level.weaponlootmapdata[var_17].assetoverridename = var_18;

    var_19 = tablelookup("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", 6, var_14, 5);
    level.weaponlootmapdata[var_17].update_focus_fire_objective = int(var_16) != 0 && int(var_19) == 99;
    var_20 = tablelookup(var_15, 1, var_14, 4);
    var_11 = parseattachdefaulttoidmap(var_20);

    if(isDefined(var_11)) {
      if(isDefined(level.weaponmapdata[var_3].attachdefaulttoidmap))
        var_11 = scripts\engine\utility::array_combine_unique_keys(var_11, level.weaponmapdata[var_3].attachdefaulttoidmap);

      level.weaponlootmapdata[var_17].attachdefaulttoidmap = var_11;
    }

    var_21 = [];

    for(var_22 = 5; var_22 <= 15; var_22++) {
      var_23 = tablelookup(var_15, 1, var_14, var_22);

      if(var_23 != "_encstr_B40101") {
        var_24 = strtok(var_23, "_encstr_854C021F");

        if(var_24.size == 2)
          var_21[var_24[0]] = int(var_24[1]);
        else
          var_21[var_24[0]] = 0;
      }
    }

    if(var_21.size > 0)
      level.weaponlootmapdata[var_17].attachcustomtoidmap = var_21;

    var_25 = tablelookup(var_15, 1, var_14, 16);

    if(var_25 != "_encstr_B40101") {
      var_26 = [];
      var_27 = strtok(var_25, "_encstr_974C0246");

      foreach(var_29 in var_27) {
        var_30 = strtok(var_29, "_encstr_854C021F");

        if(var_30.size != 2) {
          continue;
        }
        var_26[var_30[0]] = int(var_30[1]);
      }

      if(var_26.size > 0)
        level.weaponlootmapdata[var_17].attachextratoidmap = var_26;
    }
  }
}

getweaponvarianttablename(var_0) {
  if(scripts\cp\utility::isstrstart(var_0, "_encstr_83C5052DBBC1FA"))
    var_0 = getsubstr(var_0, 4);

  return "_encstr_A6180D78E2C8B8C335E317A3B3AB3E" + var_0 + "_encstr_A1B90E013381F3F8505878B735CE9FD3";
}

parseattachdefaulttoidmap(var_0) {
  if(var_0 != "_encstr_B40101") {
    var_1 = strtok(var_0, "_encstr_974C0246");
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = strtok(var_4, "_encstr_854C021F");

      if(getdvarint("_encstr_AA3F176EC6C9EB6EB236B26C8E994BC92BAF2BDCC2131B5619", 1) == 0) {
        if(scripts\engine\utility::string_starts_with(var_5[0], "_encstr_990B07B8532D18FE21"))
          continue;
      }

      if(var_5.size == 2) {
        var_2[var_5[0]] = int(var_5[1]);
        continue;
      }

      var_2[var_5[0]] = 0;
    }

    return var_2;
  }

  return undefined;
}

monitordisownedgrenade(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_88120D27D858FD694191F62D850392");
  var_0 scripts\engine\utility::_id_143A6("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_1))
    var_1 delete();
}

riotshield_getmodel() {
  return "_encstr_9B5415EEB2B007DB9B7DDDB5BE3996ED1D9B342D59D823";
}

setignoreriotshieldxp() {
  self.ignoreriotshieldxp = 1;
}

clearignoreriotshieldxp() {
  self.ignoreriotshieldxp = undefined;
}

ispickedupweapon(var_0) {
  if(iscacprimaryweapon(var_0) || iscacsecondaryweapon(var_0)) {
    var_1 = undefined;

    if(issameweapon(var_0))
      var_1 = createheadicon(var_0 getnoaltweapon());
    else if(isstring(var_0)) {
      var_1 = var_0;

      if(issubstr(var_1, "_encstr_9B83050BD88EF5"))
        var_1 = getsubstr(var_1, 4, var_0.size);
    }

    var_2 = isDefined(self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"]) && self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"] == var_1;
    var_3 = isDefined(self.pers["_encstr_85891093AA774080F789052B879FB0971F72"]) && self.pers["_encstr_85891093AA774080F789052B879FB0971F72"] == var_1;

    if(!var_2 && !var_3)
      return 1;
  }

  return 0;
}

isvehicleweapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
    case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_BE2610C077D0B2630B5683EB7B6E472168F1":
    case "_encstr_99E107C0F71E86B363":
    case "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213":
    case "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0":
    case "_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148":
    case "_encstr_8CBA0AD33D120153A1AFA040":
    case "_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E":
    case "_encstr_AB6F081B8D7949AFC813":
    case "_encstr_A2CF0C31B4B37D985A2746D76B07":
    case "_encstr_B2F60B166F934917E1C5C7BA1B":
    case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
    case "_encstr_92B90BC2C11BBEE4AE6ED7AD0E":
    case "_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9":
    case "_encstr_A7A70785E89DD7AD0E":
    case "_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C":
    case "_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43":
    case "_encstr_88E90F60526BE39B37B026C8BBEA614FB1":
    case "_encstr_8D7B0D3007F3805512A6C759B18AB1":
      return 1;
    default:
      return 0;
  }
}

attachmentsfilterforstats(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(attachmentlogsstats(var_4, var_1))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

attachmentlogsstats(var_0, var_1) {
  if(scripts\cp\utility::attachmentiscosmetic(var_0))
    return 0;

  if(!carriedpunchcard(var_1, var_0))
    return 0;

  if(scripts\engine\utility::string_starts_with(var_0, "_encstr_8B4F0BC6C23747E63A16E6C8AF"))
    return 0;

  return 1;
}

carriedpunchcard(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponrootname(var_0);
  var_3 = level.weaponattachments[var_2];
  return isDefined(var_3) && isDefined(var_3[var_1]);
}

_id_12BBB(var_0) {
  switch (var_0) {
    case "_encstr_A9F90E09660BF37B52AF4010AB6B5139":
    case "_encstr_91D30B98AF82FABB1A37C877AA":
    case "_encstr_885E09D8B0B959E4C219B9":
      var_0 = "_encstr_91EC068D0B372B93";
      break;
    case "_encstr_AB1A088A2B783257C1BB":
    case "_encstr_9BD30A0BAB18273B3621B3DF":
    case "_encstr_93D30AD8438B4F581830430B":
    case "_encstr_A3D30A9BD263B29B6C959C19":
    case "_encstr_979A07DA7B286267F1":
      var_0 = "_encstr_AD3E09B95A632BDC6CCA27";
      break;
    case "_encstr_8FF70FF37033E3D36FB50D45145BAABA59":
    case "_encstr_8B4A094CB0276C57DC47C8":
    case "_encstr_95A3082BA8EBCBFB578D":
    case "_encstr_91A51015B15250F37F9B3B6052073588EA0C":
    case "_encstr_A39B07DDDFC235D08A":
    case "_encstr_858E09935E8397836868F3":
    case "_encstr_A98B0840112B5A452B54":
      var_0 = "_encstr_A98B0840112B5A452B54";
      break;
  }

  return var_0;
}

mapweapon(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_0))
    var_3 = getcompleteweaponname("_encstr_8BBA05185F8B99");

  var_4 = 0;

  if(var_3.basename != "_encstr_8BBA05185F8B99") {
    switch (var_3.basename) {
      case "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7":
        var_3 = getcompleteweaponname("_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0");
        break;
      case "_encstr_85430BD44B30713715784912C3":
      case "_encstr_831C13D1EF4317B433165ED3E15B4B37078B57051B":
        var_3 = getcompleteweaponname("_encstr_91D8142DDDC17D3A5D4E4E2BA3EBD4601B58B1D7AD38");
        break;
      case "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8":
      case "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83":
        var_3 = getcompleteweaponname("_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0");
        break;
      case "_encstr_8A9B18CDA79A41114F78E7C8AB7719A3EB6702DFB1F277A75BF3":
      case "_encstr_BADF128E579CD726C90B46D895F2EBB537FAB6E0":
        var_3 = getcompleteweaponname("_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1");
        break;
      case "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E":
        var_3 = getcompleteweaponname("_encstr_8BBA05185F8B99");
        break;
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_1.objweapon)) {
      var_3 = getcompleteweaponname(var_1.objweapon.basename);
      var_4 = 1;
    } else if(isDefined(var_1.weapon_name)) {
      var_3 = getcompleteweaponname(var_1.weapon_name);
      var_4 = 1;
    }
  }

  if(var_4 && !istrue(var_2))
    var_3 = mapweapon(var_3, var_1, 1);

  return var_3;
}