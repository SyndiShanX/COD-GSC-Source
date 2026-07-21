/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\autosentry.gsc
***********************************************/

init() {
  level.sentrytype = [];
  level.sentrytype["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"] = "_encstr_9B2F0D5B9D2BB782A7B02BF27821B8";
  level.sentrytype["_encstr_86470DCD959BE893BCFAB943B7B1DA"] = "_encstr_86470DCD959BE893BCFAB943B7B1DA";
  level.sentrytype["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"] = "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4";
  level.sentrysettings = [];
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"] = spawnStruct();
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].health = 999999;
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].maxhealth = 100;
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].sentrymodeon = "_encstr_9B1807D39B48FD93A3";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].sentrymodeoff = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].weaponinfo = "_encstr_83E410671762BD18E941108972DD50600A2B";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].modelbase = "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].modelgood = "_encstr_88C61A37BA832B93D71DE47B07A12FD75B83D71CC6C2B195AD95738E";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].modelbad = "_encstr_BD0A1FAF3D5A6806477363C81BB3BB01B5906F21DCC690C5D71AF893F1737FF88D";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].modeldestroyed = "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].hintstring = &"_encstr_9A190E9AA82715A4959714A4862D5582";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].headicon = 1;
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].teamsplash = "_encstr_9BDB12AE9B9546BE37AB0E56E47DA339F60ED0E5";
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].shouldsplash = 0;
  level.sentrysettings["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].lightfxtag = "_encstr_B2BF0708BA770F795B";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"] = spawnStruct();
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].health = 999999;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].maxhealth = 670;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].burstmin = 20;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].burstmax = 120;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].pausemin = 0.15;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].pausemax = 0.35;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].sentrymodeon = "_encstr_9B1807D39B48FD93A3";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].sentrymodeoff = "_encstr_84FD0F03BB736BB3C36E7AF251911725E0";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].timeout = 90.0;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].spinuptime = 0.05;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].overheattime = 8.0;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].cooldowntime = 0.1;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].fxtime = 0.3;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].streakname = "_encstr_86470DCD959BE893BCFAB943B7B1DA";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].weaponinfo = "_encstr_93EF10678060C4934B101AD460275AA7A890";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].scriptable = "_encstr_844413D7CFF1BE487FCE70CEF25D30757B8FC7535B";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].modelbase = "_encstr_87C914071970F2AB41DBF73D1393F189DC8BEB3FDFA9";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].modelgood = "_encstr_8C1318C7D9B0326B019BB77D5340B1491C4B2BFF9FE9B9573040";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].modelbad = "_encstr_A56E1CCF8BDA9E6867E2E9804B12A0D8F2477D0F1F02488072BCD61B37EC";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].modeldestroyed = "_encstr_AA031E407BB7B907391A0D80B3836B66E7A710A99F5DF6C1A202FD964DEBABC9";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].hintstring = &"_encstr_9A190E9AA82715A4959714A4862D5582";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].headicon = 1;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].teamsplash = "_encstr_A1EA12680FA5310783B4102E4C7967D9068BD8F0";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].destroyedsplash = "_encstr_93AB1F8D2CD88DF6EA3AAF8C2B378E39ED2F9591FA9B59CD8E27E5BE6E0DBD1BD6";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].shouldsplash = 1;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].votimeout = "_encstr_8A6C15B9CAE6E8C9F2EB9B437BD8DABE8E2DDA2BF657A3";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].vodestroyed = "_encstr_A13D159BCADC3AC997FAB9A1BD8DDAF5462B9B4793EDF2";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].scorepopup = "_encstr_998811915937D193ED5E95C8D7CD2BCD1D9397";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].lightfxtag = "_encstr_B2BF0708BA770F795B";
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].iskillstreak = 1;
  level.sentrysettings["_encstr_86470DCD959BE893BCFAB943B7B1DA"].headiconoffset = 75;
  level._effect["_encstr_AF3613176712CD6879D1E0DB475A708D5A8BD7A34B"] = loadfx("_encstr_8BD02E489AE05F69B762A58845F3D89F0CA21018D33A73E14F8B981C26BB9E77773990B87AD2A1393F94A896353FC013");
  level._effect["_encstr_A716129F78982C7B93C83768475162C401417F1B"] = loadfx("_encstr_8D6736ECCCF05E4BEEDCBCEB3995C5ABCA378E6E97D6E0CBB3991EFAD92B735639B436EB56E2AE2D1CB659378EF5AC870EF51B3B5C9DCC3C");
  level._effect["_encstr_8EB5114A2545DBD28A517F7BC883B3D34F4912"] = loadfx("_encstr_A312318B744AE6F280DBC550E86B36E0AB02990BB50B47AF0A588A4D7FE87010F0720402D9B13C982899351B52930A563A6F62");
  level._effect["_encstr_AB82109309907B327807B3A50F80BF8F4903"] = loadfx("_encstr_832538406B88083B931340605AEA530BFD47D8F0E6253B7F6B6FE36877C2A5B625E7A8A803FFF19BE2D95E87CE4B97FE9A6FF828BF8AC57D3A38");
  level._effect["_encstr_AFAA147201D8DC8323275F2B5FC6DA3F48486EBAF928"] = loadfx("_encstr_8CC534B3331E5E5AEEB9CBD79C59C557B26ED1CDF2B50EF29DCC0FFA9BAC373A4ECBEBDC34BD1B6DD71B86B0C9CECABED583C5D999E1");
  level._effect["_encstr_99041473474E801EBB4FDF91F762EA910B5EDB09EFA6"] = loadfx("_encstr_8F0C2DB3CC1E792DBB73BCD7C9595C572BE6E837CB6BC197CECCF07DDC2B73E8E4F27DB90DB78D5BFAB98D272B2BE6");
  level._effect["_encstr_957E12CD95DC8EE4E5AFE6D0F6C6ADBE1316CDCA"] = loadfx("_encstr_95452BA072084730FF1FB89832DF7B8B374B289B5EE531E523761B902BE740415A73F9B8C2BD4FC0AF9AAFFE15");
  level._effect["_encstr_8C1E149AF5950B227AA1AFCB0811E361451FA7946517"] = loadfx("_encstr_ACA72D5BD95170931BB607779EB36305FBC7F373E0C13290FBBA0B907F1FF028753B58DB741F1FC2AE3867F9C4C386");
  level._effect["_encstr_AA2617F3993DB38D02AF2860E8593287E743E091EF636A98F3"] = loadfx("_encstr_B1892E43A8928F3247347D69FE1BCB9D5998C3EF4AE8289E6DA4B0116633F24403A0F76788ED7382E7CD3DD7E0CD2A78");
  level._effect["_encstr_8C9D13D0473D8C98F0594841EF42134F7B10C938BD"] = loadfx("_encstr_81DA35D9CC3CF2A577735EEBE4AC8BEA566EE86E5EDA1CBC67CCF0FACDCAE61D93F2AFCD43ED6CB67D83C9B753FAA3935896D8C59D99C3");
  level._effect["_encstr_B4DA11D2BDCD536A32D9E79340293BA9AB4E5E"] = loadfx("_encstr_BDA32E25534B5898AF13E5066A6580AD72FFA9B7DEA2BFE2C65FD21ED24D30655B7F073F5BEA8E38D7F69B91AD26489B");
}

tryuseautosentry(var_0, var_1) {
  var_2 = givesentry("_encstr_8E600F37A8A33D66EF21CFE84239028B95");

  if(var_2)
    scripts\common\utility::_id_13E0A(level._id_11B2A, level.sentrysettings["_encstr_8E600F37A8A33D66EF21CFE84239028B95"].streakname, self.origin);

  return var_2;
}

tryusesam(var_0, var_1) {
  var_2 = givesentry("_encstr_962C0B9B16ADBE47EAE49C568E");

  if(var_2)
    scripts\common\utility::_id_13E0A(level._id_11B2A, level.sentrysettings["_encstr_962C0B9B16ADBE47EAE49C568E"].streakname, self.origin);

  return var_2;
}

tryuseshocksentry(var_0) {
  var_1 = givesentry("_encstr_86470DCD959BE893BCFAB943B7B1DA", undefined, var_0);

  if(var_1)
    scripts\common\utility::_id_13E0A(level._id_11B2A, var_0.streakname, self.origin);
  else
    waitframe();

  return var_1;
}

tryusemanualturret(var_0) {
  var_1 = givesentry("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", undefined, var_0);

  if(var_1)
    scripts\common\utility::_id_13E0A(level._id_11B2A, var_0.streakname, self.origin);
  else
    waitframe();

  return var_1;
}

givesentry(var_0, var_1, var_2) {
  self.last_sentry = var_0;

  if(!isDefined(self.placedsentries))
    self.placedsentries = [];

  if(!isDefined(self.placedsentries[var_0]))
    self.placedsentries[var_0] = [];

  var_3 = 1;

  if(isDefined(var_1))
    var_3 = var_1;

  var_4 = createsentryforplayer(var_0, self, var_3, var_2);

  if(isDefined(var_2))
    var_2.sentrygun = var_4;

  removeperks();
  self.carriedsentry = var_4;
  var_5 = setcarryingsentry(var_4, 1, var_3);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;

  if(isDefined(var_4))
    return 1;
  else
    return 0;
}

setcarryingsentry(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 sentry_setcarried(self, var_2, var_3);
  scripts\common\utility::allow_usability(0);
  allowweaponsforsentry(0);
  scripts\common\utility::allow_melee(0);

  if(!isai(self)) {
    self notifyonplayercommand("_encstr_BE8C0D62A1DA2EC351D8A50D0363DA", "_encstr_A9E60828803C73F11780");
    self notifyonplayercommand("_encstr_BE8C0D62A1DA2EC351D8A50D0363DA", "_encstr_85D21AE322E335C047434F596D2BC333A837576EFFD586FE998ACDF7");
    self notifyonplayercommand("_encstr_88E60E81D22801BF13B062A8CBEBB31F", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");

    if(!self isconsoleplayer()) {
      self notifyonplayercommand("_encstr_88E60E81D22801BF13B062A8CBEBB31F", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
      self notifyonplayercommand("_encstr_88E60E81D22801BF13B062A8CBEBB31F", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
      self notifyonplayercommand("_encstr_88E60E81D22801BF13B062A8CBEBB31F", "_encstr_A55C0EAAE22E11D0BF66B6214FFB312F");
    }
  }

  for(;;) {
    var_4 = scripts\engine\utility::_id_143AF("_encstr_BE8C0D62A1DA2EC351D8A50D0363DA", "_encstr_88E60E81D22801BF13B062A8CBEBB31F", "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003", "_encstr_AB770C81EB09798E707B29137D77");

    if(!isDefined(var_0)) {
      allowweaponsforsentry(1);
      scripts\common\utility::allow_usability(1);
      thread enablemeleeforsentry();
      return 1;
    }

    if(var_4 == "_encstr_88E60E81D22801BF13B062A8CBEBB31F" || var_4 == "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003" || var_4 == "_encstr_AB770C81EB09798E707B29137D77") {
      if(!var_1 && (var_4 == "_encstr_88E60E81D22801BF13B062A8CBEBB31F" || var_4 == "_encstr_AB770C81EB09798E707B29137D77")) {
        continue;
      }
      var_0 sentry_setcancelled(var_4 == "_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003" && !isDefined(var_0.firstplacement));
      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    var_0 sentry_setplaced(var_2);
    return 1;
  }
}

enablemeleeforsentry() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 0.25;
  scripts\common\utility::allow_melee(1);
}

removeweapons() {
  if(self hasweapon("_encstr_9AF3124BBB8DAFC94B7B1D3734D2593623FADAC1")) {
    self.restoreweapon = "_encstr_9AF3124BBB8DAFC94B7B1D3734D2593623FADAC1";
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_9AF3124BBB8DAFC94B7B1D3734D2593623FADAC1");
  }
}

removeperks() {
  if(scripts\mp\utility\perk::_hasperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B")) {
    self.restoreperk = "_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B";
    scripts\mp\utility\perk::removeperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\mp\utility\perk::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  waitframe();
  restoreperks();
}

createsentryforplayer(var_0, var_1, var_2, var_3) {
  var_4 = level.sentrysettings[var_0].weaponinfo;
  var_5 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_1.origin, var_4);
  var_5.angles = var_1.angles;
  var_5.streakinfo = var_3;
  var_5 sentry_initsentry(var_0, var_1, var_2);
  var_5 thread sentry_destroyongameend();
  var_5 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_5 scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentry_empstarted);
  var_5 scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentry_empcleared);
  return var_5;
}

sentry_initsentry(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  self.sentrytype = var_0;
  self.canbeplaced = 1;
  self setModel(level.sentrysettings[var_0].modelbase);
  self setnodeploy(1);

  if(level.sentrysettings[var_0].shouldsplash)
    self.shouldsplash = 1;
  else
    self.shouldsplash = 0;

  self.firstplacement = 1;
  self setCanDamage(1);

  switch (var_0) {
    case "_encstr_8DF50C800BE73B5B8B3A2DAD59C7":
    case "_encstr_8CF50CA02BC71B7BAB1ACD4DB957":
    case "_encstr_9AF50C3B36D73AD593935947AF64":
    case "_encstr_BAF50C9D8DD71D5D39E4AC47F526":
    case "_encstr_96730A1FE06EFCDB75AEC7BB":
    case "_encstr_AB0E115BB4DC4B76D5CDAF8EAE934ECA3AFA86":
    case "_encstr_A70E11BDC35870D75B4BB6E51B6B73A5584F2A":
    case "_encstr_A10E11C8323D7B4167D610FDA513AB3BE3F98A":
    case "_encstr_930E11F51B6D22DF13B0B70370AB82AAE1B86A":
    case "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355":
      self setleftarc(80);
      self setrightarc(80);
      self setbottomarc(50);
      self setdefaultdroppitch(0.0);
      self.originalowner = var_1;
      break;
    case "_encstr_A3D6109BC693B05B4CB159AFD1D59339ACA3":
    case "_encstr_962C0B9B16ADBE47EAE49C568E":
      self maketurretinoperable();
      self setleftarc(180);
      self setrightarc(180);
      self settoparc(80);
      self setdefaultdroppitch(-89.0);
      self.laser_on = 0;
      var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E"));
      var_4 linkTo(self);
      self.killcament = var_4;
      self.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
      break;
    case "_encstr_86470DCD959BE893BCFAB943B7B1DA":
      self maketurretinoperable();
      var_5 = anglesToForward(self.angles);
      var_6 = self gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E") + (0, 0, 10);
      var_6 = var_6 - var_5 * 20;
      var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
      var_4 linkTo(self);
      self.killcament = var_4;
      break;
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      var_5 = anglesToForward(self.angles);
      var_6 = self gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E") + (0, 0, 10);
      var_6 = var_6 - var_5 * 20;
      var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
      var_4 linkTo(self);
      self.killcament = var_4;
      break;
    default:
      self maketurretinoperable();
      self setdefaultdroppitch(-89.0);
      break;
  }

  self setturretmodechangewait(1);
  sentry_setinactive();
  sentry_setowner(var_1);

  if(var_3)
    thread sentry_timeout();

  switch (var_0) {
    case "_encstr_AB0E115BB4DC4B76D5CDAF8EAE934ECA3AFA86":
    case "_encstr_A70E11BDC35870D75B4BB6E51B6B73A5584F2A":
    case "_encstr_A10E11C8323D7B4167D610FDA513AB3BE3F98A":
    case "_encstr_930E11F51B6D22DF13B0B70370AB82AAE1B86A":
    case "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355":
      self.momentum = 0;
      self.heatlevel = 0;
      self.overheated = 0;
      thread sentry_heatmonitor();
      break;
    case "_encstr_8DF50C800BE73B5B8B3A2DAD59C7":
    case "_encstr_8CF50CA02BC71B7BAB1ACD4DB957":
    case "_encstr_9AF50C3B36D73AD593935947AF64":
    case "_encstr_BAF50C9D8DD71D5D39E4AC47F526":
    case "_encstr_96730A1FE06EFCDB75AEC7BB":
      self.momentum = 0;
      self.heatlevel = 0;
      self.cooldownwaittime = 0;
      self.overheated = 0;
      thread turret_heatmonitor();
      thread turret_coolmonitor();
      break;
    case "_encstr_A3D6109BC693B05B4CB159AFD1D59339ACA3":
    case "_encstr_962C0B9B16ADBE47EAE49C568E":
    case "_encstr_86470DCD959BE893BCFAB943B7B1DA":
      self.momentum = 0;
      thread sentry_handleuse(var_2);
      thread sentry_beepsounds();
      break;
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      self.momentum = 0;
      thread sentry_handlemanualuse();
      thread sentry_handlealteratepickup(var_2);
      break;
    case "_encstr_9B2F0D5B9D2BB782A7B02BF27821B8":
      thread sentry_handleuse(0);
      thread sentry_beepsounds();
      break;
    default:
      thread sentry_handleuse(var_2);
      thread sentry_attacktargets();
      thread sentry_beepsounds();
      break;
  }
}

sentry_setteamheadicon() {
  var_0 = level.sentrysettings[self.sentrytype].headiconoffset;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self.owner)) {
    return;
  }
  var_1 = self.owner;
  var_2 = var_1.team;
  self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var_0, undefined, undefined, undefined, undefined, 1);
}

sentry_clearteamheadicon() {
  var_0 = level.sentrysettings[self.sentrytype].headiconoffset;

  if(!isDefined(var_0)) {
    return;
  }
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
}

sentry_destroyongameend() {
  self endon("_encstr_AD75063D571AE108");
  level scripts\engine\utility::_id_143A5("_encstr_935E0F139CF6D76E1A7B3AEB6E1D85E4D1", "_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_AD75063D571AE108");
}

sentry_handledamage() {
  self endon("_encstr_A93B084AF782F0DA4A04");
  var_0 = level.sentrysettings[self.sentrytype].maxhealth;
  var_1 = 0;

  if(self.owner scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E")) {
    var_2 = self.weapon_name;

    if(isDefined(var_2)) {
      switch (var_2) {
        default:
      }
    }
  }

  var_0 = var_0 + int(var_1);
  scripts\mp\damage::monitordamage(var_0, "_encstr_9B1807D39B48FD93A3", ::sentryhandledeathdamage, ::sentrymodifydamage, 1);
}

sentrymodifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;

  if(var_3 == "_encstr_8DED0A21C79B660BC7588981")
    var_6 = self.maxhealth * 0.34;

  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4);
  return var_6;
}

sentryhandledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = level.sentrysettings[self.sentrytype];

  if(var_6.iskillstreak) {
    var_7 = scripts\mp\damage::onkillstreakkilled(var_6.streakname, var_1, var_2, var_3, var_4, var_6.scorepopup, var_6.vodestroyed, var_6.destroyedsplash);

    if(var_7) {
      var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
      return;
    }
  } else {
    var_8 = undefined;
    var_9 = var_1;

    if(isDefined(var_9) && isDefined(self.owner)) {
      if(isDefined(var_1.owner) && isPlayer(var_1.owner))
        var_9 = var_1.owner;

      if(self.owner scripts\mp\utility\player::isenemy(var_9))
        var_8 = var_9;
    }

    if(isDefined(var_8)) {
      var_8 thread scripts\mp\events::supershutdown(self.owner);
      var_8 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    }

    self notify("_encstr_AD75063D571AE108");
  }
}

sentry_empstarted(var_0) {
  self.disabled = 1;
  self setdefaultdroppitch(40);
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self cleartargetentity();
  self setscriptablepartstate("_encstr_AD5B07B65DD39ED8AC", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8ED90887F39B73AD5BFF", "_encstr_930B07BB1B6B3854FF");
}

sentry_empcleared(var_0) {
  if(var_0) {
    return;
  }
  self setdefaultdroppitch(-89.0);
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
  self setscriptablepartstate("_encstr_8ED90887F39B73AD5BFF", "_encstr_A7A408B9CA5D1D4E2C63");
  self.disabled = undefined;
}

sentry_handledeath() {
  self endon("_encstr_A93B084AF782F0DA4A04");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.owner))
    self.owner.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(self.owner.placedsentries[self.sentrytype], self);

  if(!isDefined(self)) {
    return;
  }
  self cleartargetentity();
  self laseroff();
  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);

  if(isDefined(self.fxentdeletelist) && self.fxentdeletelist.size > 0) {
    foreach(var_1 in self.fxentdeletelist) {
      if(isDefined(var_1))
        var_1 delete();
    }

    self.fxentdeletelist = undefined;
  }

  sentry_setinactive();
  self setdefaultdroppitch(40);
  self setsentryowner(undefined);

  if(isDefined(self.inuseby))
    self useby(self.inuseby);

  self setturretminimapvisible(0);

  if(isDefined(self.ownertrigger))
    self.ownertrigger delete();

  self playSound("_encstr_9ACF13F5970FE2C913880BAFF84983BBEDA0786F75");

  switch (self.sentrytype) {
    case "_encstr_96730A1FE06EFCDB75AEC7BB":
    case "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355":
      self.forcedisable = 1;
      self turretfiredisable();
      break;
    default:
      break;
  }

  if(isDefined(self.inuseby)) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_A716129F78982C7B93C83768475162C401417F1B"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
    self.inuseby.turret_overheat_bar scripts\mp\hud_util::destroyelem();
    self.inuseby restoreperks();
    self.inuseby restoreweapons();
    self notify("_encstr_990D093256B156D1B4B93B");
    wait 1.0;
    stopFXOnTag(scripts\engine\utility::getfx("_encstr_A716129F78982C7B93C83768475162C401417F1B"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    stopFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
  } else {
    self playSound("_encstr_ACB215AFFF55B3E84BB1C150DF9CAD986F9FA3737743FA");
    self setscriptablepartstate("_encstr_83320ADDB7DB01AB8F3FF8E8", "_encstr_84AC07D798315292CF");
    wait 5;
    playFX(scripts\engine\utility::getfx("_encstr_A716129F78982C7B93C83768475162C401417F1B"), self.origin + (0, 0, 10));
    self notify("_encstr_990D093256B156D1B4B93B");
  }

  scripts\mp\weapons::equipmentdeletevfx();

  if(isDefined(self.killcament))
    self.killcament delete();

  if(isDefined(self.airlookatent))
    self.airlookatent delete();

  if(isDefined(self.manualpickuptrigger))
    self.manualpickuptrigger delete();

  scripts\mp\utility\print::printgameaction("_encstr_AB1420B52DC61BCD3AE4CAB0AD02B23732AC46085A109B1AB78DB6EBCD2B73E8275E", self.owner);
  self delete();
}

sentry_handleuse(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(self.sentrytype == "_encstr_962C0B9B16ADBE47EAE49C568E" || self.sentrytype == "_encstr_A3D6109BC693B05B4CB159AFD1D59339ACA3")
      self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);

    var_1.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(var_1.placedsentries[self.sentrytype], self);
    var_1 setcarryingsentry(self, 0, var_0);
  }
}

turret_handlepickup(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0.ownertrigger)) {
    return;
  }
  var_1 = 0;

  for(;;) {
    if(isalive(self) && self istouching(var_0.ownertrigger) && !isDefined(var_0.inuseby) && !isDefined(var_0.carriedby) && self isonground()) {
      if(self useButtonPressed()) {
        var_1 = 0;

        while(self useButtonPressed()) {
          var_1 = var_1 + level.framedurationseconds;
          waitframe();
        }

        if(var_1 >= 0.5) {
          continue;
        }
        var_1 = 0;

        while(!self useButtonPressed() && var_1 < 0.5) {
          var_1 = var_1 + level.framedurationseconds;
          waitframe();
        }

        if(var_1 >= 0.5) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(self)) {
          continue;
        }
        var_0 setmode(level.sentrysettings[var_0.sentrytype].sentrymodeoff);
        thread setcarryingsentry(var_0, 0);
        var_0.ownertrigger delete();
        return;
      }
    }

    waitframe();
  }
}

turret_handleuse() {
  self notify("_encstr_B1A91063C046A39FBBF95B6BE839F09BA307");
  self endon("_encstr_AC5B11536B465B1DD0867C0698682C629DFF9F");
  self endon("_encstr_990D093256B156D1B4B93B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.forcedisable = 0;
  var_0 = (1, 0.9, 0.7);
  var_1 = (1, 0.65, 0);
  var_2 = (1, 0.25, 0);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(isDefined(self.carriedby)) {
      continue;
    }
    if(isDefined(self.inuseby)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_3)) {
      continue;
    }
    var_3 removeperks();
    var_3 removeweapons();
    self.inuseby = var_3;
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    sentry_setowner(var_3);
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
    var_3 thread turret_shotmonitor(self);
    var_3.turret_overheat_bar = var_3 scripts\mp\hud_util::createbar(var_0, 100, 6);
    var_3.turret_overheat_bar scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A146079E6DF9115CFD", 0, -70);
    var_3.turret_overheat_bar.alpha = 0.65;
    var_3.turret_overheat_bar.bar.alpha = 0.65;
    var_4 = 0;

    for(;;) {
      if(!scripts\mp\utility\player::isreallyalive(var_3)) {
        self.inuseby = undefined;
        var_3.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        break;
      }

      if(!var_3 isusingturret()) {
        self notify("_encstr_913A1090E16F51DD23796783228188930353");
        self.inuseby = undefined;
        var_3.turret_overheat_bar scripts\mp\hud_util::destroyelem();
        var_3 restoreperks();
        var_3 restoreweapons();
        self setHintString(level.sentrysettings[self.sentrytype].hintstring);
        self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
        sentry_setowner(self.originalowner);
        self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
        break;
      }

      if(self.heatlevel >= level.sentrysettings[self.sentrytype].overheattime)
        var_5 = 1;
      else
        var_5 = self.heatlevel / level.sentrysettings[self.sentrytype].overheattime;

      var_3.turret_overheat_bar scripts\mp\hud_util::updatebar(var_5);

      if(scripts\engine\utility::string_starts_with(self.sentrytype, "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355"))
        var_6 = "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355";

      if(self.forcedisable || self.overheated) {
        self turretfiredisable();
        var_3.turret_overheat_bar.bar.color = var_2;
        var_4 = 0;
      } else if(self.heatlevel > level.sentrysettings[self.sentrytype].overheattime * 0.75 && scripts\engine\utility::string_starts_with(self.sentrytype, "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355")) {
        var_3.turret_overheat_bar.bar.color = var_1;

        if(randomintrange(0, 10) < 6)
          self turretfireenable();
        else
          self turretfiredisable();

        if(!var_4) {
          var_4 = 1;
          thread playheatfx();
        }
      } else {
        var_3.turret_overheat_bar.bar.color = var_0;
        self turretfireenable();
        var_4 = 0;
        self notify("_encstr_BE690F1038845E50656583101090C917AF");
      }

      wait 0.05;
    }

    self setdefaultdroppitch(0.0);
  }
}

sentry_handleownerdisconnect() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_9A1113D05DF5399A60EE5B83F065AC89E8F88D4593");
  self endon("_encstr_9A1113D05DF5399A60EE5B83F065AC89E8F88D4593");
  childthread sentry_watchownerstatus("_encstr_8D820B49520F0EC02DDE6367EC");
  childthread sentry_watchownerstatus("_encstr_81170C244F9CBDE72C01BB99A298");
  childthread sentry_watchownerstatus("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
}

sentry_watchownerstatus(var_0) {
  self.owner waittill(var_0);
  self notify("_encstr_AD75063D571AE108");
}

sentry_setowner(var_0) {
  self.owner = var_0;
  self setsentryowner(self.owner);
  self setturretminimapvisible(1, self.sentrytype);

  if(level.teambased) {
    self.team = self.owner.team;
    self setturretteam(self.team);
  }

  thread sentry_handleownerdisconnect();
}

sentry_moving_platform_death(var_0) {
  self notify("_encstr_AD75063D571AE108");
}

sentry_setplaced(var_0) {
  if(isDefined(self.owner)) {
    var_1 = self.owner.placedsentries[self.sentrytype].size;
    self.owner.placedsentries[self.sentrytype][var_1] = self;

    if(var_1 + 1 > 2)
      self.owner.placedsentries[self.sentrytype][0] notify("_encstr_AD75063D571AE108");

    self.owner allowweaponsforsentry(1);
    self.owner scripts\common\utility::allow_usability(1);
    self.owner thread enablemeleeforsentry();
    self.owner enableworldup(1);
  }

  self setModel(level.sentrysettings[self.sentrytype].modelbase);

  if(self getmode() == "_encstr_849007B268BD03DFD8")
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);

  if(self.sentrytype == "_encstr_86470DCD959BE893BCFAB943B7B1DA") {}

  thread sentry_handledamage();
  thread sentry_handledeath();
  self setsentrycarrier(undefined);
  self setCanDamage(1);

  switch (self.sentrytype) {
    case "_encstr_8DF50C800BE73B5B8B3A2DAD59C7":
    case "_encstr_8CF50CA02BC71B7BAB1ACD4DB957":
    case "_encstr_9AF50C3B36D73AD593935947AF64":
    case "_encstr_BAF50C9D8DD71D5D39E4AC47F526":
    case "_encstr_96730A1FE06EFCDB75AEC7BB":
    case "_encstr_AB0E115BB4DC4B76D5CDAF8EAE934ECA3AFA86":
    case "_encstr_A70E11BDC35870D75B4BB6E51B6B73A5584F2A":
    case "_encstr_A10E11C8323D7B4167D610FDA513AB3BE3F98A":
    case "_encstr_930E11F51B6D22DF13B0B70370AB82AAE1B86A":
    case "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355":
      if(var_0) {
        self.angles = self.carriedby.angles;

        if(isalive(self.originalowner))
          self.originalowner scripts\mp\utility\lower_message::setlowermessage("_encstr_93CB0C0388A9A39B3178C4BCD811", level.sentrysettings[self.sentrytype].ownerhintstring, 3.0, undefined, undefined, undefined, undefined, undefined, 1);

        self.ownertrigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin + (0, 0, 1), 0, 105, 64);
        self.ownertrigger enablelinkTo();
        self.ownertrigger linkTo(self);
        self.originalowner thread turret_handlepickup(self);
        thread turret_handleuse();
      }

      break;
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      self setdefaultdroppitch(30.0);
      break;
    default:
      break;
  }

  sentry_makesolid();

  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("_encstr_91B411BAE0190B1D59FA26BDB64C6E17AEC219");
  }

  self.carriedby forceusehintoff();
  self.carriedby = undefined;
  self.firstplacement = undefined;

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
    self.owner notify("_encstr_86680B9BCAEEF5DCACE68E932F", self);
  }

  sentry_setactive(var_0);
  var_2 = spawnStruct();

  if(isDefined(self.moving_platform))
    var_2.linkparent = self.moving_platform;

  var_2.endonstring = "_encstr_A93B084AF782F0DA4A04";
  var_2.deathoverridecallback = ::sentry_moving_platform_death;
  thread scripts\mp\movers::handle_moving_platforms(var_2);

  if(self.sentrytype != "_encstr_A1EE0CA817AC336BF3F39EA6CFCB")
    self playSound("_encstr_931A11C275C203937A69DC3F0D89CB65633853");

  self notify("_encstr_B8B00782A191CB07D9");
}

sentry_setcancelled(var_0) {
  if(isDefined(self.carriedby)) {
    var_1 = self.carriedby;
    var_1 forceusehintoff();
    var_1.iscarrying = undefined;
    var_1.carrieditem = undefined;
    var_1 allowweaponsforsentry(1);
    var_1 scripts\common\utility::allow_usability(1);
    var_1 thread enablemeleeforsentry();
    var_1 enableworldup(1);

    if(isDefined(self.bombsquadmodel))
      self.bombsquadmodel delete();
  }

  if(isDefined(var_0) && var_0)
    scripts\mp\weapons::equipmentdeletevfx();

  self delete();
}

sentry_setcarried(var_0, var_1, var_2) {
  if(isDefined(self.originalowner)) {} else {}

  if(self.sentrytype == "_encstr_86470DCD959BE893BCFAB943B7B1DA")
    self setscriptablepartstate("_encstr_AD5B07B65DD39ED8AC", "_encstr_A7A408B9CA5D1D4E2C63", 0);

  self setModel(level.sentrysettings[self.sentrytype].modelgood);
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  sentry_makenotsolid();
  var_0 enableworldup(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  self.pickupenabled = var_1;
  thread sentry_oncarrierdeathoremp(var_0, var_2);
  var_0 thread updatesentryplacement(self);
  thread sentry_oncarrierdisconnect(var_0);
  thread sentry_oncarrierchangedteam(var_0);
  thread sentry_ongameended();
  scripts\cp_mp\emp_debuff::allow_emp(0);
  self setdefaultdroppitch(-89.0);
  sentry_setinactive();

  if(isDefined(self getlinkedparent()))
    self unlink();

  self notify("_encstr_A93B084AF782F0DA4A04");

  if(isDefined(self.bombsquadmodel))
    self.bombsquadmodel hide();
}

updatesentryplacement(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_B8B00782A191CB07D9");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.canbeplaced = 1;
  var_1 = -1;

  for(;;) {
    var_2 = self canplayerplacesentry(1, 40);
    var_0.origin = var_2["_encstr_97FE07DE392D76D2CD"];
    var_0.angles = var_2["_encstr_A7610758E6CED8569B"];
    var_3 = scripts\engine\utility::array_combine(level.turrets, level.microturrets, level.supertrophy.trophies, level.mines);
    var_4 = var_0 getistouchingentities(var_3);
    var_0.canbeplaced = self isonground() && var_2["_encstr_9B7C07725D17A39473"] && abs(var_0.origin[2] - self.origin[2]) < 30 && !scripts\mp\utility\entity::istouchingboundstrigger(self) && var_4.size == 0;

    if(isDefined(var_2["_encstr_850E077B0BF30318B9"]))
      var_0.moving_platform = var_2["_encstr_850E077B0BF30318B9"];
    else
      var_0.moving_platform = undefined;

    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelgood);
        var_0 placehinton();
      } else {
        var_0 setModel(level.sentrysettings[var_0.sentrytype].modelbad);
        var_0 cannotplacehinton();
      }
    }

    var_1 = var_0.canbeplaced;
    wait 0.05;
  }
}

sentry_oncarrierdeathoremp(var_0, var_1) {
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_AB770C81EB09798E707B29137D77");

  if(self.canbeplaced && !istrue(var_1))
    sentry_setplaced(self.pickupenabled);
  else
    sentry_setcancelled(0);
}

sentry_oncarrierdisconnect(var_0) {
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self delete();
}

sentry_oncarrierchangedteam(var_0) {
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self delete();
}

sentry_ongameended(var_0) {
  self endon("_encstr_B8B00782A191CB07D9");
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self delete();
}

sentry_setactive(var_0) {
  self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);

  if(var_0) {
    self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
    self setHintString(level.sentrysettings[self.sentrytype].hintstring);
    self makeusable();
  }

  foreach(var_2 in level.players) {
    switch (self.sentrytype) {
      case "_encstr_8DF50C800BE73B5B8B3A2DAD59C7":
      case "_encstr_8CF50CA02BC71B7BAB1ACD4DB957":
      case "_encstr_9AF50C3B36D73AD593935947AF64":
      case "_encstr_BAF50C9D8DD71D5D39E4AC47F526":
      case "_encstr_96730A1FE06EFCDB75AEC7BB":
      case "_encstr_AB0E115BB4DC4B76D5CDAF8EAE934ECA3AFA86":
      case "_encstr_A70E11BDC35870D75B4BB6E51B6B73A5584F2A":
      case "_encstr_A10E11C8323D7B4167D610FDA513AB3BE3F98A":
      case "_encstr_930E11F51B6D22DF13B0B70370AB82AAE1B86A":
      case "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355":
        if(var_0)
          self enableplayeruse(var_2);

        break;
      default:
        scripts\mp\utility\killstreak::addtoactivekillstreaklist(self.sentrytype, "_encstr_912912A962ED2193D37ABDA74B57DDA5950B1858", self.owner, 0, 1, 70, "_encstr_A93B084AF782F0DA4A04");

        if(var_2 == self.owner && var_0)
          self enableplayeruse(var_2);
        else
          self disableplayeruse(var_2);

        break;
    }
  }

  var_4 = level.sentrysettings[self.sentrytype].teamsplash;

  if(self.shouldsplash) {
    level thread scripts\mp\hud_util::teamplayercardsplash(var_4, self.owner);
    self.shouldsplash = 0;
  }

  if(self.sentrytype == "_encstr_962C0B9B16ADBE47EAE49C568E")
    thread sam_attacktargets();

  if(self.sentrytype == "_encstr_A3D6109BC693B05B4CB159AFD1D59339ACA3")
    thread scrambleturretattacktargets();

  if(self.sentrytype == "_encstr_86470DCD959BE893BCFAB943B7B1DA")
    thread sentryshocktargets();

  scripts\cp_mp\emp_debuff::allow_emp(1);
}

sentry_setinactive() {
  if(self.sentrytype == "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4") {
    self setHintString("_encstr_B40101");
    self makeunusable();
  }

  self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
}

sentry_makesolid() {
  self solid();
}

sentry_makenotsolid() {
  self notsolid();
}

isfriendlytosentry(var_0) {
  if(level.teambased && self.team == var_0.team)
    return 1;

  return 0;
}

sentry_attacktargets() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("_encstr_857D12B3C82B1A3A99CE63DEB55392D891B8477F", "_encstr_A36A07BB6038639701");

    if(self isfiringturret()) {
      thread sentry_burstfirestart();
      continue;
    }

    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_timeout() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.sentrysettings[self.sentrytype].timeout;

  if(isDefined(var_0) && var_0 == 0) {
    return;
  }
  while(var_0) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self.carriedby))
      var_0 = max(0, var_0 - 1.0);
  }

  if(isDefined(self.owner)) {
    if(isDefined(level.sentrysettings[self.sentrytype].votimeout))
      self.owner scripts\mp\utility\dialog::playkillstreakdialogonplayer(level.sentrysettings[self.sentrytype].votimeout, undefined, undefined, self.owner.origin);
  }

  self notify("_encstr_AD75063D571AE108");
}

sentry_targetlocksound() {
  self endon("_encstr_AD75063D571AE108");
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  wait 0.1;
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  wait 0.1;
  self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_laser_burstfirestart() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;

  if(isDefined(self.supportturret) && self.supportturret) {
    var_0 = 0.05;
    var_3 = 50;
  } else {
    var_0 = 0.5 / (self.listoffoundturrets.size + 1);
    var_3 = var_1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = self getturrettarget(1);

    if(!isDefined(var_5)) {
      break;
    }

    self shootturret();
    wait(var_0);
  }

  self notify("_encstr_95580BBDFF2B3915C483E0C0CA");
  self cleartargetentity();
}

sentry_burstfirestart() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  sentry_spinup();
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;
  var_3 = level.sentrysettings[self.sentrytype].pausemin;
  var_4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self.overheated; var_6++) {
      self shootturret();
      self notify("_encstr_8FCA0D31D5D8C656E8BE664B4E2B19");
      self.heatlevel = self.heatlevel + var_0;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

sentry_burstfirestop() {
  self notify("_encstr_99210EE61DBD1CD7DCA1EDBDE8A537CE");
}

turret_shotmonitor(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_913A1090E16F51DD23796783228188930353");
  var_1 = weaponfiretime(level.sentrysettings[var_0.sentrytype].weaponinfo);

  for(;;) {
    var_0 waittill("_encstr_BDBA0C4757C927CA477DCC5A4EAC");
    var_0.heatlevel = var_0.heatlevel + var_1;
    var_0.cooldownwaittime = var_1;
  }
}

sentry_heatmonitor() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level.sentrysettings[self.sentrytype].overheattime;
  var_4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_1)
      wait(var_0);
    else
      self.heatlevel = max(0, self.heatlevel - 0.05);

    if(self.heatlevel > var_3) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "_encstr_AB0E115BB4DC4B76D5CDAF8EAE934ECA3AFA86":
        case "_encstr_A70E11BDC35870D75B4BB6E51B6B73A5584F2A":
        case "_encstr_A10E11C8323D7B4167D610FDA513AB3BE3F98A":
        case "_encstr_930E11F51B6D22DF13B0B70370AB82AAE1B86A":
        case "_encstr_8B040F58C3D5C0E7FB5AE195B8B85BD355":
          playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
          break;
        default:
          break;
      }

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var_4);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("_encstr_BE690F1038845E50656583101090C917AF");
    }

    var_1 = self.heatlevel;
    wait 0.05;
  }
}

turret_heatmonitor() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = level.sentrysettings[self.sentrytype].overheattime;

  for(;;) {
    if(self.heatlevel > var_0) {
      self.overheated = 1;
      thread playheatfx();

      switch (self.sentrytype) {
        case "_encstr_96730A1FE06EFCDB75AEC7BB":
          playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
          break;
        default:
          break;
      }

      while(self.heatlevel)
        wait 0.1;

      self.overheated = 0;
      self notify("_encstr_BE690F1038845E50656583101090C917AF");
    }

    wait 0.05;
  }
}

turret_coolmonitor() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0)
        self.heatlevel = max(0, self.heatlevel - 0.05);
      else
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
    }

    wait 0.05;
  }
}

playheatfx() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE690F1038845E50656583101090C917AF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");
  self endon("_encstr_935C10831B165E2D9B3BAF0DAC58D1BE993C");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AF3613176712CD6879D1E0DB475A708D5A8BD7A34B"), self, "_encstr_A14F0AE336178944BA076F41");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

playsmokefx() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE690F1038845E50656583101090C917AF");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AB82109309907B327807B3A50F80BF8F4903"), self, "_encstr_8E300878E04AE8B18198");
    wait 0.4;
  }
}

sentry_beepsounds() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby))
      self playSound("_encstr_A68410B329B05B125827C7DD6D415E476DE3");
  }
}

sam_attacktargets() {
  self endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.samtargetent = undefined;
  self.sammissilegroups = [];

  for(;;) {
    self.samtargetent = sam_acquiretarget();
    sam_fireontarget();
    wait 0.05;
  }
}

sam_acquiretarget() {
  var_0 = self gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E");

  if(!isDefined(self.samtargetent)) {
    if(level.teambased) {
      var_1 = [];
      var_2 = undefined;
      var_3 = scripts\mp\utility\teams::getenemyteams(self.team);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
        var_2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

      if(istrue(var_2) && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1)) {
        foreach(var_5 in var_3) {
          foreach(var_12, var_7 in level.squaddata[var_5]) {
            var_8 = var_5 + var_12;

            foreach(var_10 in level.uavmodels[var_8])
            var_1[var_1.size] = var_10;
          }
        }
      } else {
        foreach(var_15 in var_3) {
          foreach(var_17 in level.uavmodels[var_15])
          var_1[var_1.size] = var_17;
        }
      }

      foreach(var_17 in var_1) {
        if(isDefined(var_17.isleaving) && var_17.isleaving) {
          continue;
        }
        if(sighttracepassed(var_0, var_17.origin, 0, self))
          return var_17;
      }

      foreach(var_23 in level.littlebirds) {
        if(isDefined(var_23.team) && var_23.team == self.team) {
          continue;
        }
        if(sighttracepassed(var_0, var_23.origin, 0, self))
          return var_23;
      }

      foreach(var_26 in level.helis) {
        if(isDefined(var_26.team) && var_26.team == self.team) {
          continue;
        }
        if(sighttracepassed(var_0, var_26.origin, 0, self))
          return var_26;
      }

      foreach(var_17 in level.remote_uav) {
        if(!isDefined(var_17)) {
          continue;
        }
        if(isDefined(var_17.team) && var_17.team == self.team) {
          continue;
        }
        if(sighttracepassed(var_0, var_17.origin, 0, self, var_17))
          return var_17;
      }
    } else {
      foreach(var_17 in level.uavmodels) {
        if(isDefined(var_17.isleaving) && var_17.isleaving) {
          continue;
        }
        if(isDefined(var_17.owner) && isDefined(self.owner) && var_17.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_17.origin, 0, self))
          return var_17;
      }

      foreach(var_23 in level.littlebirds) {
        if(isDefined(var_23.owner) && isDefined(self.owner) && var_23.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_23.origin, 0, self))
          return var_23;
      }

      foreach(var_26 in level.helis) {
        if(isDefined(var_26.owner) && isDefined(self.owner) && var_26.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_26.origin, 0, self))
          return var_26;
      }

      foreach(var_17 in level.remote_uav) {
        if(!isDefined(var_17)) {
          continue;
        }
        if(isDefined(var_17.owner) && isDefined(self.owner) && var_17.owner == self.owner) {
          continue;
        }
        if(sighttracepassed(var_0, var_17.origin, 0, self, var_17))
          return var_17;
      }
    }

    self cleartargetentity();
    return undefined;
  } else {
    if(!sighttracepassed(var_0, self.samtargetent.origin, 0, self)) {
      self cleartargetentity();
      return undefined;
    }

    return self.samtargetent;
  }
}

sam_fireontarget() {
  if(isDefined(self.samtargetent)) {
    if(self.samtargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.samtargetent = undefined;
      self cleartargetentity();
      return;
    }

    self settargetentity(self.samtargetent);
    self waittill("_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");

    if(!isDefined(self.samtargetent)) {
      return;
    }
    if(!self.laser_on) {
      thread sam_watchlaser();
      thread sam_watchcrashing();
      thread sam_watchleaving();
      thread sam_watchlineofsight();
    }

    wait 2.0;

    if(!isDefined(self.samtargetent)) {
      return;
    }
    if(self.samtargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.samtargetent = undefined;
      self cleartargetentity();
      return;
    }

    var_0 = [];
    var_0[0] = self gettagorigin("_encstr_AF2F102313472E94AFA6FB678636CF05ED4A");
    var_0[1] = self gettagorigin("_encstr_9A2F10A3E82F096B7960A5A90EC3078D43EA");
    var_0[2] = self gettagorigin("_encstr_B277108467C78FDDB061D8E113A38BF9628F");
    var_0[3] = self gettagorigin("_encstr_B4771069E1A7814ED799C87063878B507F2A");
    var_1 = self.sammissilegroups.size;

    for(var_2 = 0; var_2 < 4; var_2++) {
      if(!isDefined(self.samtargetent)) {
        return;
      }
      if(isDefined(self.carriedby)) {
        return;
      }
      self shootturret();
      var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_AB1312B92CD6D7C139DED4B28D47B436B2EBD61C"), var_0[var_2], self.samtargetent.origin, self.owner);
      var_3 missile_settargetEnt(self.samtargetent);
      var_3 missile_setflightmodedirect();
      var_3.samturret = self;
      var_3.sammissilegroup = var_1;
      self.sammissilegroups[var_1][var_2] = var_3;
      level notify("_encstr_918112AE79AFF6FB7C1BA8708217E7A9D7F23DAD", self.owner, var_3, self.samtargetent);

      if(var_2 == 3) {
        break;
      }

      wait 0.25;
    }

    level notify("_encstr_B4340A9BA073713BB0AEF5EC", self.owner, self.sammissilegroups[var_1], self.samtargetent);
    wait 3.0;
  }
}

sam_watchlineofsight() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent) {
    var_0 = self gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E");

    if(!sighttracepassed(var_0, self.samtargetent.origin, 0, self, self.samtargetent)) {
      self cleartargetentity();
      self.samtargetent = undefined;
      break;
    }

    wait 0.05;
  }
}

sam_watchlaser() {
  self endon("_encstr_AD75063D571AE108");
  self laseron();
  self.laser_on = 1;

  while(isDefined(self.samtargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
    waitframe();

  self laseroff();
  self.laser_on = 0;
}

sam_watchcrashing() {
  self endon("_encstr_AD75063D571AE108");
  self.samtargetent endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.samtargetent.helitype)) {
    return;
  }
  self.samtargetent waittill("_encstr_86BD0980BBC647A80FDE04");
  self cleartargetentity();
  self.samtargetent = undefined;
}

sam_watchleaving() {
  self endon("_encstr_AD75063D571AE108");
  self.samtargetent endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.samtargetent.model)) {
    return;
  }
  if(self.samtargetent.model == "_encstr_969D16675643D21B8D56EBAEB067FA37D1B01DB46CF5AD83") {
    self.samtargetent waittill("_encstr_BA2D081B2B58B32D37EC");
    self cleartargetentity();
    self.samtargetent = undefined;
  }
}

scrambleturretattacktargets() {
  self endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.scrambletargetent = undefined;

  for(;;) {
    self.scrambletargetent = scramble_acquiretarget();

    if(isDefined(self.scrambletargetent) && isDefined(self.scrambletargetent.scrambled) && !self.scrambletargetent.scrambled)
      scrambletarget();

    wait 0.05;
  }
}

scramble_acquiretarget() {
  return sam_acquiretarget();
}

scrambletarget() {
  if(isDefined(self.scrambletargetent)) {
    if(self.scrambletargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.scrambletargetent = undefined;
      self cleartargetentity();
      return;
    }

    self settargetentity(self.scrambletargetent);
    self waittill("_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");

    if(!isDefined(self.scrambletargetent)) {
      return;
    }
    if(!self.laser_on) {
      thread scramble_watchlaser();
      thread scramble_watchcrashing();
      thread scramble_watchleaving();
      thread scramble_watchlineofsight();
    }

    wait 2.0;

    if(!isDefined(self.scrambletargetent)) {
      return;
    }
    if(self.scrambletargetent == level.gunship.planemodel && !isDefined(level.gunshipplayer)) {
      self.scrambletargetent = undefined;
      self cleartargetentity();
      return;
    }

    if(!isDefined(self.scrambletargetent)) {
      return;
    }
    if(isDefined(self.carriedby)) {
      return;
    }
    self shootturret();
    thread setscrambled();
    self notify("_encstr_AD75063D571AE108");
  }
}

setscrambled() {
  var_0 = self.scrambletargetent;
  var_0 notify("_encstr_92980F37B139B0AD89C659D766A5275991", self.owner);
  var_0 endon("_encstr_92980F37B139B0AD89C659D766A5275991");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread scripts\mp\killstreaks\helicopter::heli_targeting();
  var_0.scrambled = 1;
  var_0.secondowner = self.owner;
  var_0 notify("_encstr_B4F70E099CA6E8E88207492B3B8AB5B0");
  wait 30;

  if(isDefined(var_0)) {
    var_0.scrambled = 0;
    var_0.secondowner = undefined;
    var_0 thread scripts\mp\killstreaks\helicopter::heli_targeting();
  }
}

scramble_watchlineofsight() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent) {
    var_0 = self gettagorigin("_encstr_9A1E0A3A85B3F5632CB9954E");

    if(!sighttracepassed(var_0, self.scrambletargetent.origin, 0, self, self.scrambletargetent)) {
      self cleartargetentity();
      self.scrambletargetent = undefined;
      break;
    }

    wait 0.05;
  }
}

scramble_watchlaser() {
  self endon("_encstr_AD75063D571AE108");
  self laseron();
  self.laser_on = 1;

  while(isDefined(self.scrambletargetent) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent)
    wait 0.05;

  self laseroff();
  self.laser_on = 0;
}

scramble_watchcrashing() {
  self endon("_encstr_AD75063D571AE108");
  self.scrambletargetent endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.scrambletargetent.helitype)) {
    return;
  }
  self.scrambletargetent waittill("_encstr_86BD0980BBC647A80FDE04");
  self cleartargetentity();
  self.scrambletargetent = undefined;
}

scramble_watchleaving() {
  self endon("_encstr_AD75063D571AE108");
  self.scrambletargetent endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.scrambletargetent.model)) {
    return;
  }
  if(self.scrambletargetent.model == "_encstr_969D16675643D21B8D56EBAEB067FA37D1B01DB46CF5AD83") {
    self.scrambletargetent waittill("_encstr_BA2D081B2B58B32D37EC");
    self cleartargetentity();
    self.scrambletargetent = undefined;
  }
}

sentryshocktargets() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A93B084AF782F0DA4A04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread watchsentryshockpickup();
  self.airlookatent = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self.airlookatent linkTo(self, "_encstr_A14F0AE336178944BA076F41");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143B9(1, "_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");

    if(var_0 == "_encstr_995408F398012F656821") {
      continue;
    }
    self.sentryshocktargetent = self getturrettarget(1);

    if(isDefined(self.sentryshocktargetent) && scripts\mp\utility\player::isreallyalive(self.sentryshocktargetent)) {
      thread shocktarget(self.sentryshocktargetent);
      self waittill("_encstr_A5310C82B81DE7C7791BDAC9A061");
    }
  }
}

searchforshocksentryairtarget() {
  if(isDefined(level.uavmodels)) {
    if(level.teambased) {
      var_0 = undefined;
      var_1 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
        var_0 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

      if(istrue(var_0) && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1)) {
        foreach(var_3 in var_1) {
          foreach(var_10, var_5 in level.squaddata[var_3]) {
            var_6 = var_3 + var_10;

            foreach(var_8 in level.uavmodels[var_6]) {
              if(targetvisibleinfront(var_8))
                return var_8;
            }
          }
        }
      } else {
        foreach(var_3 in var_1) {
          foreach(var_8 in level.uavmodels[var_3]) {
            if(targetvisibleinfront(var_8))
              return var_8;
          }
        }
      }
    } else {
      foreach(var_8 in level.uavmodels) {
        if(var_8.owner == self.owner) {
          continue;
        }
        if(targetvisibleinfront(var_8))
          return var_8;
      }
    }
  }

  if(isDefined(level.helis)) {
    foreach(var_19 in level.helis) {
      if(var_19.streakname != "_encstr_B88607820996877650") {
        continue;
      }
      if(level.teambased && var_19.team == self.owner.team) {
        continue;
      }
      if(!level.teambased && var_19.owner == self.owner) {
        continue;
      }
      if(targetvisibleinfront(var_19))
        return var_19;
    }
  }
}

targetvisibleinfront(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = 0;
  var_2 = self gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_3 = var_0.origin;
  var_4 = vectorNormalize(var_3 - var_2);
  var_5 = anglesToForward(self.angles);
  var_6 = [self, self.owner, var_0];
  var_7 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);

  if(scripts\engine\trace::ray_trace_passed(var_2, var_3, var_6, var_7) && vectordot(var_5, var_4) > 0.25 && distance2dsquared(var_2, var_3) > 10000)
    var_1 = 1;

  return var_1;
}

shootshocksentrysamtarget(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A93B084AF782F0DA4A04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setmode("_encstr_849007B268BD03DFD8");
  thread setshocksamtargetEnt(var_0, var_1);
  self.sentryshocksamtarget = undefined;
  self waittill("_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");
  thread marktargetlaser(var_0);
  self playSound("_encstr_A96917DC34F66CB57D6EACCD1D93E5F5360DC2C9D9CAF5AB1C");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AFAA147201D8DC8323275F2B5FC6DA3F48486EBAF928"), self, "_encstr_9A1E0A3A85B3F5632CB9954E");
  sentry_spinup();
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_AFAA147201D8DC8323275F2B5FC6DA3F48486EBAF928"), self, "_encstr_9A1E0A3A85B3F5632CB9954E");
  self notify("_encstr_99570D833B0773A33905B9AA33982F");
  self setscriptablepartstate("_encstr_8E91052EE76BF5", "_encstr_930B07BB1B6B3854FF");
  var_2 = 2;
  var_3 = 1;

  while(isDefined(var_0) && targetvisibleinfront(var_0)) {
    var_4 = self gettagorigin("_encstr_A14F0AE336178944BA076F41");
    var_5 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_998D1868A26D11B3E757B6234FA758FF15CAF0E01A857B2E6F80"), var_4, var_0.origin, self.owner);
    var_5 missile_settargetEnt(var_0);
    var_5 missile_setflightmodedirect();
    var_5.killcament = self.killcament;
    var_5.streakinfo = self.streakinfo;
    self setscriptablepartstate("_encstr_AD5B07B65DD39ED8AC", "_encstr_88780599B4E495" + var_3, 0);
    level notify("_encstr_BA531D9D376FDAE27D30073B983185420756A415ADD7B131A0982707802867", self.owner, var_5, var_0);
    var_3++;

    if(var_3 > 2)
      var_3 = 1;

    wait(var_2);
  }

  self setscriptablepartstate("_encstr_AD5B07B65DD39ED8AC", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self notify("_encstr_866F1358472D852D3727E0802BC55F2DB706A10B63");
  var_1 unlink();
  var_1.origin = self gettagorigin("_encstr_A14F0AE336178944BA076F41");
  var_1 linkTo(self, "_encstr_A14F0AE336178944BA076F41");
  self setmode("_encstr_9B1807D39B48FD93A3");
  self cleartargetentity();
  self setscriptablepartstate("_encstr_8E91052EE76BF5", "_encstr_A7C5056BD931D1");
  sentry_spindown();
  self notify("_encstr_A5310C82B81DE7C7791BDAC9A061");
}

sentry_handlemanualuse() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    while(var_0 isusingturret()) {
      if(var_0 attackButtonPressed())
        self shootturret();

      waitframe();
    }

    waitframe();
  }
}

sentry_handlealteratepickup(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner notifyonplayercommand("_encstr_A581152DC7939AE108715F0FD023CA536FE7B426BACB33", "_encstr_A6E60A229B175A3B48A543AB");
  self.manualpickuptrigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, 128, 128);
  self.manualpickuptrigger enablelinkTo();
  self.manualpickuptrigger linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  for(;;) {
    if(isDefined(self.carriedby))
      waitframe();

    if(!self.owner istouching(self.manualpickuptrigger))
      waitframe();

    self.owner waittill("_encstr_A581152DC7939AE108715F0FD023CA536FE7B426BACB33");
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    self.owner.placedsentries[self.sentrytype] = scripts\engine\utility::array_remove(self.owner.placedsentries[self.sentrytype], self);
    self.owner setcarryingsentry(self, 0, var_0);
  }
}

setshocksamtargetEnt(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A93B084AF782F0DA4A04");
  self endon("_encstr_866F1358472D852D3727E0802BC55F2DB706A10B63");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_2 = self gettagorigin("_encstr_8E300878E04AE8B18198");
    var_3 = var_0.origin;
    var_4 = vectorNormalize(var_3 - var_2);
    var_5 = var_2 + var_4 * 500;
    var_1 unlink();
    var_1.origin = var_5;
    var_1 linkTo(self);
    self settargetentity(var_1);
    waitframe();
  }
}

watchsentryshockpickup() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_A93B084AF782F0DA4A04");

    if(isDefined(self.sentryshocktargetent))
      self.sentryshocktargetent = undefined;

    if(isDefined(self.sentryshocksamtarget))
      self.sentryshocksamtarget = undefined;

    self cleartargetentity();
  }
}

shocktarget(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A93B084AF782F0DA4A04");

  if(!isDefined(var_0)) {
    return;
  }
  thread marktargetlaser(var_0);
  self playSound("_encstr_A96917DC34F66CB57D6EACCD1D93E5F5360DC2C9D9CAF5AB1C");
  sentry_spinup();
  self notify("_encstr_99570D833B0773A33905B9AA33982F");
  level thread scripts\mp\battlechatter_mp::saytoself(var_0, "_encstr_85B2162AB8A06F9A93F9ABDFE1C6A2898026A3F6D3B01D23");
  var_1 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);

  while(isDefined(var_0) && scripts\mp\utility\player::isreallyalive(var_0) && isDefined(self getturrettarget(1)) && self getturrettarget(1) == var_0 && !scripts\mp\utility\outline::outlineoccluded(self gettagorigin("_encstr_A14F0AE336178944BA076F41"), var_0 getEye())) {
    self shootturret();
    wait(var_1);
  }

  self.sentryshocktargetent = undefined;
  self cleartargetentity();
  sentry_spindown();
  self notify("_encstr_A5310C82B81DE7C7791BDAC9A061");
}

missileburstfire(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A93B084AF782F0DA4A04");
  var_1 = 3;
  var_2 = 1;

  while(var_1 > 0) {
    if(!isDefined(var_0)) {
      return;
    }
    if(!isDefined(self.owner)) {
      return;
    }
    var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_930A189F1DEDD0568F913358BACF82D1C762CB2D81D79008277B"), self gettagorigin("_encstr_A14F0AE336178944BA076F41"), var_0.origin, self.owner);
    var_3 missile_settargetEnt(var_0, gettargetoffset(var_0));
    var_3.killcament = self.killcament;
    var_3.streakinfo = self.streakinfo;
    self setscriptablepartstate("_encstr_AD5B07B65DD39ED8AC", "_encstr_88780599B4E495" + var_2, 0);
    var_2++;

    if(var_2 > 2)
      var_2 = 1;

    var_3 thread watchtargetchange(var_0);
    var_1--;
    wait 0.2;
  }
}

gettargetoffset(var_0) {
  var_1 = (0, 0, 40);
  var_2 = var_0 getstance();

  switch (var_2) {
    case "_encstr_A5AD069B231F0BAF":
      var_1 = (0, 0, 40);
      break;
    case "_encstr_B13D076BED70539F23":
      var_1 = (0, 0, 20);
      break;
    case "_encstr_922406F1A6FD5E05":
      var_1 = (0, 0, 5);
      break;
  }

  return var_1;
}

watchtargetchange(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      self missile_settargetEnt(var_0 getcorpseentity());
      break;
    }

    waitframe();
  }
}

marktargetlaser(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self laseron();
  self.laser_on = 1;
  scripts\engine\utility::_id_143A5("_encstr_A5310C82B81DE7C7791BDAC9A061", "_encstr_A93B084AF782F0DA4A04");
  self laseroff();
  self.laser_on = 0;
}

watchshockdamage(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A5310C82B81DE7C7791BDAC9A061");
  var_1 = undefined;

  for(;;) {
    self waittill("_encstr_B6B10F0D8906786367394991622F2CB89F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_2 == var_0) {
      var_12 = 100;
      var_13 = scripts\mp\utility\player::getplayersinradiusview(var_8, var_12, var_2.team, self.owner);
      playFX(scripts\engine\utility::getfx("_encstr_AA2617F3993DB38D02AF2860E8593287E743E091EF636A98F3"), var_8);

      if(var_13.size > 0) {
        foreach(var_15 in var_13) {
          if(var_15.player != var_2) {
            var_15.player dodamage(5, var_8, self.owner, self, var_6, var_7);
            var_16 = undefined;
            var_17 = undefined;

            if(var_15.visiblelocations.size > 1) {
              var_17 = randomint(var_15.visiblelocations.size);
              var_16 = var_15.visiblelocations[var_17];
            } else
              var_16 = var_15.visiblelocations[0];

            playfxbetweenpoints(scripts\engine\utility::getfx("_encstr_B4DA11D2BDCD536A32D9E79340293BA9AB4E5E"), var_8, vectortoangles(var_16 - var_8), var_16);
          }
        }
      }
    }
  }
}

allowweaponsforsentry(var_0) {
  if(var_0) {
    scripts\common\utility::allow_weapon(1);
    thread scripts\mp\supers::unstowsuperweapon();
  } else {
    thread scripts\mp\supers::allowsuperweaponstow();
    scripts\common\utility::allow_weapon(0);
  }
}

placehinton() {
  var_0 = self.sentrytype;

  if(var_0 == "_encstr_9B2F0D5B9D2BB782A7B02BF27821B8") {
    self.owner forceusehinton(&"_encstr_A1CD1F13AA147DA9A2C9AAAF6A0A9728C428D08AFAA9AA288A29D72A49A7A09095");
    return;
  } else
    self.owner forceusehinton(&"_encstr_A5600DA6157215A495F205C405862A");
}

cannotplacehinton() {
  var_0 = self.sentrytype;

  if(var_0 == "_encstr_9B2F0D5B9D2BB782A7B02BF27821B8") {
    self.owner forceusehinton(&"_encstr_84E12688E7EF2F0571FD3D2FE3014597077C20206F584B0D39CF25273701D2F7D6F6797994B7E3B0");
    return;
  } else
    self.owner forceusehinton(&"_encstr_B21B14A68A938A2956F234507293F451D728C450868A");
}