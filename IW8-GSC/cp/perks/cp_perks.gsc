/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\perks\cp_perks.gsc
***********************************************/

initperks() {
  init_core_mp_perks();
}

init_each_perk() {
  if(!isDefined(level.health_scalar))
    level.health_scalar = 1;

  level.extra_charge_func = ::should_give_extra_charge;
  self.perk_data = [];
  self.perk_data["_encstr_9B180BCD938A68FB62D1C27B20"] = 100 * level.health_scalar;
  self.perk_data["_encstr_939F1253D0677DFD2FACB3028159CFBF711CA1DB"] = 1;
  self.perk_data["_encstr_86FA0DB595C6592B7D9B1B853658E4"] = 1.0;
  self.perk_data["_encstr_9601125B5936AC56AF378E5D73EB4EB046B45DB9"] = 0;
  self.perk_data["_encstr_8C5B1339CAECB49DACD71D96B62BFAB98DB08D859C"] = 1.0;
  self.perk_data["_encstr_9A9B12677FDB97EF32F74DF3577FCB60B1C0D960"] = 1.0;
  self.perk_data["_encstr_8D92153956CEA59DACD746C2DA0B9D95FA37D8161B1693"] = 1.0;
  self.perk_data["_encstr_9A7818ACF0831BF6E6A5B359FAC8B0B60BEC59AFDCC685C6C227"] = 1.0;
  self.perk_data["_encstr_A33E0ED0FF02B17136C3B1588745E8F1"] = 1;
  self.perk_data["_encstr_93320EBA51C53B5EC85BEAFF6BD8E577"] = 4;
  self.perk_data["_encstr_A2872499E4962B9B32D82FD7CA1E1C36DE6EB4B3ACF5C885B558ECB2D7932B8C571BD1A5DE37"] = 1;
  self.perk_data["_encstr_841A21AC37B25BCBAFB2E138367B37D29DCAF519586BC27656AFC9AC91ABC61DB4DEE6"] = 1;
  self.perk_data["_encstr_866A1598EAD8C6598EF58C0BADB0EC95FACDD885B1B04E"] = 1.0;
  self.perk_data["_encstr_995214C2933079D235D97F6B235E9B8F58D9FE8DA9E0"] = 1;
  self.perk_data["_encstr_BAB41A1F8CAFF8D93B62361B9A73B7B0C4E473CF0FD3101EDB6A6961"] = 0;
  self.perk_data["_encstr_87951CB9A3CA85B1E843EBEECA16C1DE37EBE6EDB4CD567DCDC62CB158C9"] = 1;
  self.perk_data["_encstr_B8971AB943DE4EE8BE9CB073762BEB23B0B5C276B2F5B9D8C2C60B4E"] = 1;
  self.perk_data["_encstr_830D160DD28333B49C56F546C2B658CE56AFCD6CC2C685C9"] = 1;
  self.perk_data["_encstr_88441577E012C0B05389F941B2DFFC68E15BDFCB94BE40"] = 1;
  self.perk_data["_encstr_8EC41D1F53B6ABF1C8B0AFB9C8703C1285978B8F2357A2A551FBA63EC0386A"] = 1;
  self.perk_data["_encstr_8C2514CA90EEAB3F60971DE437F8C67B058B42F278BE"] = 0;
  self.perk_data["_encstr_8CB91B96CD369CAC0BCD5919FA6BC2A3B2392D58B1E67DEE0BD8C6B23A"] = 0;
  self.perk_data["_encstr_A2061A07DC2B90299C3AA0D022393F4B9746158B3EFF9E5B83E2A078"] = 0;
  self.perk_data["_encstr_932916FF506F3817571253396AD34398078F257BC3D4F8D5"] = 0;
  self.perk_data["_encstr_8C2514CA90EEAB3F60971DE437F8C67B058B42F278BE"] = 0;
  self.perk_data["_encstr_8CB91B96CD369CAC0BCD5919FA6BC2A3B2392D58B1E67DEE0BD8C6B23A"] = 0;
  self.perk_data["_encstr_A2061A07DC2B90299C3AA0D022393F4B9746158B3EFF9E5B83E2A078"] = 0;
  self.perk_data["_encstr_932916FF506F3817571253396AD34398078F257BC3D4F8D5"] = 0;
  self.perk_data["_encstr_A70F123AFB9BF1921E6B70E95DB963A6F083BE13"] = 1;
  self.perk_data["_encstr_A7FC1707DF3703BAA890F740C923B5A8F6C5500B5709985870"] = 1;
  self.perk_data["_encstr_93E02467088B9231A670DFD76099E579711061DAE12B6B756BC1D7A3E870CA2117BE7655DF75"] = 1;
  self.perk_data["_encstr_AC3E1DF0C28D1B3177B7D5405F9FD8EB75ABB1504B254FEBC7A3564F74B703"] = 1;
  self.perk_data["_encstr_8F7F11A31AFA808F433BB81D41E85B78803B51"] = 0;
  thread scripts\cp\cp_agent_damage::_id_13C35();
  init_class_changed_values();
}

init_class_changed_values() {
  self setaimspreadmovementscale(1.0);
  self notify("_encstr_8AEC175673C8F5B52B32D2B1EB1A2BC236D186FA4E95CE2B73");

  if(isDefined(self.old_view_kick)) {
    self setviewkickscale(self.old_view_kick);
    self.old_view_kick = undefined;
  }

  if(isDefined(self.old_recoil_scale)) {
    self player_recoilscaleon(100);
    self.old_recoil_scale = undefined;
  }
}

get_perk(var_0) {
  if(isDefined(self.perk_data[var_0]))
    return self.perk_data[var_0];
}

set_perk(var_0, var_1) {
  if(isDefined(self.perk_data[var_0]))
    self.perk_data[var_0] = var_1;
}

blank() {}

medic_speed_buff() {
  self.perk_data["_encstr_9A9B12677FDB97EF32F74DF3577FCB60B1C0D960"] = 1.12;
  self.movespeedscaler = 1.12;
  thread scripts\cp\cp_loadout::updatemovespeedscale();
}

medic_health_regen(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8AEC175673C8F5B52B32D2B1EB1A2BC236D186FA4E95CE2B73");
  self endon("_encstr_B4FB0D299CBE80F8A2A7273177CBBE");
  var_1 = var_0 > 0.0;

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(var_3.medic_regeneration)) {
        if(var_1 && distancesquared(self.origin, var_3.origin) > var_0)
          continue;
      }
    }

    wait 1.0;
  }
}

medic_regenerate_health_once() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.medic_regeneration = 1;
  wait 1.0;
  self.health = int(min(self.maxhealth, self.health + 5.0));
  self.medic_regeneration = undefined;
}

should_give_extra_charge(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_A71C18E89AB3BB3B07E330B8FB77C35F9C2290C9234FF511C30D":
      case "_encstr_BACF11F977CB38367772D19B982B65B8E6D46B":
      case "_encstr_81580B52FF3F7F3D195A6A61A7":
      case "_encstr_8B960D1CF6DD599CD7C247A94BCD56":
      case "_encstr_B8F514D0A28B93131F1C5B4EEF57B87D7708B8908AA7":
      case "_encstr_A76F0D83DB77B239AF372BB54756E1":
      case "_encstr_ABE813B8E843EAD21733C8EF4C832F8BBB8581C741":
      case "_encstr_87CB0E0B177C92B2411875BD7030E71B":
      case "_encstr_A5B00F4AB8E8356BE8A99BA7CDA9827CD0":
      case "_encstr_A22A16E07BEE5693EB9B732C83B934EDE83AE4B2E658C895":
      case "_encstr_8D7C09102FE7216D71A66D":
      case "_encstr_8E910FA7E764B78317A2C973305A28B33B":
        return self.perk_data["_encstr_A33E0ED0FF02B17136C3B1588745E8F1"];
      default:
        break;
    }
  }

  return undefined;
}

reload_on_kill() {
  for(;;) {
    self waittill("_encstr_A1AA0B2233D402E9A6B945A30D");
    var_0 = self getcurrentprimaryweapon();
    var_1 = self getammocount(var_0);
    var_2 = int(min(var_1, weaponclipsize(var_0)));
    var_3 = var_1 - var_2;
    self setweaponammoclip(var_0, var_2);
    self setweaponammostock(var_0, var_3);
    wait 0.1;
  }
}

give_fast_fire() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0)
  scripts\cp\cp_weapon::addattachmenttoweapon(var_2, "_encstr_92B50AC8BDABC4D8AC8E580E");
}

give_bullet_penetration() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0)
  scripts\cp\cp_weapon::addattachmenttoweapon(var_2, "_encstr_841804CCB635");
}

reduce_recoil() {
  self.old_view_kick = self getviewkickscale();
  self.overchargeviewkickscale = 0;
  self.old_recoil_scale = self player_getrecoilscale();
  self player_recoilscaleon(0);
  self.onhelisniper = 1;
  scripts\cp\cp_weapon::updateviewkickscale();
}

_id_12BEE() {
  if(isDefined(self.old_recoil_scale)) {
    if(self.old_recoil_scale != -1)
      self player_recoilscaleon(self.old_recoil_scale);
    else
      self player_recoilscaleon(100);

    self.old_recoil_scale = undefined;
  }

  self.overchargeviewkickscale = undefined;
  self.onhelisniper = undefined;
  scripts\cp\cp_weapon::updateviewkickscale();
}

reduce_bullet_spread() {
  scripts\cp\utility::giveperk("_encstr_A1C919E233105BA29FF1F3FFAF36AB9C8079DBEEC988F54BE787CF");
  self setaimspreadmovementscale(0.1);
}

run_deadeye_charge_watcher() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88511B2BCA378FB9AF2175FD21F786BF9C823088920107D1C34B0BE502");
  self endon("_encstr_B4FB0D299CBE80F8A2A7273177CBBE");
  self.deadeye_charge = undefined;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = 500;

  for(;;) {
    if(self adsButtonPressed()) {
      var_3 = gettime();

      if(!isDefined(var_0)) {
        var_0 = var_3;
        var_1 = var_3 + var_2;
      } else if(var_3 > var_1) {
        if(!istrue(self.deadeye_charge)) {}

        self.deadeye_charge = 1;
      }
    } else {
      self.deadeye_charge = undefined;
      var_0 = undefined;
      var_1 = undefined;
    }

    wait 0.05;
  }
}

init_core_mp_perks() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.scriptperks["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = 1;
  level.scriptperks["_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F"] = 1;
  level.scriptperks["_encstr_966512DB9F092FC45BF0CB1381BF3BE3A190584F"] = 1;
  level.scriptperks["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = 1;
  level.scriptperks["_encstr_AD781843325528832AF3A1A32743DD10E78B095EDFBDD84523BF"] = 1;
  level.perksetfuncs["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = ::setmomentum;
  level.perkunsetfuncs["_encstr_ADF91332D73BC291D160DBF7E1885FEA83607B2B31"] = ::unsetmomentum;
  level.perksetfuncs["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = ::setfreefall;
  level.perkunsetfuncs["_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"] = ::unsetfreefall;
  level.perksetfuncs["_encstr_AD781843325528832AF3A1A32743DD10E78B095EDFBDD84523BF"] = ::setremotedefuse;
  level.perkunsetfuncs["_encstr_AD781843325528832AF3A1A32743DD10E78B095EDFBDD84523BF"] = ::unsetremotedefuse;
  level.scriptperks["_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B"] = 1;
  level.extraperkmap["_encstr_963D111F88AFE85B6F2253FA39630D3083FC4B"] = ["_encstr_AC191F77E0D7903307BAFB429197F5C06F5AFFE98ABCA085D7C2B0685A8BA6D0C7", "_encstr_81A71D7BE920D6B7A79063BBDE0CCF8AC0B7F2FF4BA8DC6F58CB4AE2E15053"];
  level.scriptperks["_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913"] = 1;
  level.extraperkmap["_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913"] = ["_encstr_AAA715470821F3025BA9BBF0181FABBDABE8A397B0D92D"];
  level.perksetfuncs["_encstr_AAA715470821F3025BA9BBF0181FABBDABE8A397B0D92D"] = ::setovercharge;
  level.perkunsetfuncs["_encstr_AAA715470821F3025BA9BBF0181FABBDABE8A397B0D92D"] = ::unsetovercharge;
  registerscriptperk("_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F", undefined, undefined, ["_encstr_B8251D93206B463FB9B9FCF9D823F78E99300B6A2047BF171313E015ED88FB"]);
  registerscriptperk("_encstr_B8251D93206B463FB9B9FCF9D823F78E99300B6A2047BF171313E015ED88FB", ::give_restock, ::take_restock);
  registerscriptperk("_encstr_A925123F2B991E48CFE833A7EF1C3D73384F6733", undefined, undefined, ["_encstr_87FB22DCE0B26CD20BB1A3BCFAA56B0727F667CA32AF334B95B1C8AF5D1CCE930B4695CD", "_encstr_845E1F43325528832AF3A1A32702DFE0FCCFEB5E5FB1C0C95257ABB9EFAB17E085"]);
  registerscriptperk("_encstr_87FB22DCE0B26CD20BB1A3BCFAA56B0727F667CA32AF334B95B1C8AF5D1CCE930B4695CD");
  registerscriptperk("_encstr_845E1F43325528832AF3A1A32702DFE0FCCFEB5E5FB1C0C95257ABB9EFAB17E085", ::give_tune_up, ::take_tune_up);
  registerscriptperk("_encstr_BDD614CD83951BD28563D1977D8BAEA5C66D7D99963C", undefined, undefined, ["_encstr_977E25B90ECAB14BC2C6D1CBF5935932D58D59D74E593B2BDCD791AC6316F2EBF69BAFDA961BB1", "_encstr_AADA2ABF034A2A8996F583BA26E0C7714BBF7D11A84D49231AD65D63F9C65FB7A7603E7818D2FB76D4E04570"]);
  registerscriptperk("_encstr_977E25B90ECAB14BC2C6D1CBF5935932D58D59D74E593B2BDCD791AC6316F2EBF69BAFDA961BB1", ::_id_131B9, ::_id_13F6D);
  registerscriptperk("_encstr_AADA2ABF034A2A8996F583BA26E0C7714BBF7D11A84D49231AD65D63F9C65FB7A7603E7818D2FB76D4E04570", ::setreduceregendelayonobjective, ::unsetreduceregendelayonobjective);
  registerscriptperk("_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F", ::sethardline, ::unsethardline);
  registerscriptperk("_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC", ::give_amped, ::take_amped, ["_encstr_A9F31F6EC1AC6C2D0BD8E8E57DCC2CE6E8C9B236F616C8D73685D5378D345693B9"]);
  registerscriptperk("_encstr_A9F31F6EC1AC6C2D0BD8E8E57DCC2CE6E8C9B236F616C8D73685D5378D345693B9", ::setfastreloadlaunchers, ::unsetfastreloadlaunchers);
  registerscriptperk("_encstr_964616CBE2F359E0193A0BB817C54BF098D340205BB0F765", undefined, undefined, ["_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728"]);
  registerscriptperk("_encstr_8B4717FBC37D5F8CD0399C8947A0D3A71F7BD282494E2FC728", ::setoverkill, ::unsetoverkill, []);
  registerscriptperk("_encstr_A15715DCE059D85A0B631D2FEB9BE89C0B47AC3BD237E8", undefined, undefined, ["_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947"]);
  registerscriptperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947", ::setkillstreaktoscorestreak, ::unsetkillstreaktoscorestreak);
  registerscriptperk("_encstr_8B8117CD07B21B5A5863D12FAF37AE9CD9594B1B8DB0E66C95", undefined, undefined, ["_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756"]);
  registerscriptperk("_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756", ::setsixthsense, ::unsetsixthsense);
  level thread sixthsense_think();
  registerscriptperk("_encstr_92B519E6C12BC6D22C8D1D2FEB56F0474EC2D76E434E2C83DC95C6", undefined, undefined, ["_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953", "_encstr_8D33136E83B28D96C28D3ABCAF6E43C92C1CB9568D"]);
  registerscriptperk("_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953", ::give_shrapnel, ::take_shrapnel);
  registerscriptperk("_encstr_8D33136E83B28D96C28D3ABCAF6E43C92C1CB9568D");
  registerscriptperk("_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6", undefined, undefined, ["_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3"]);
  registerscriptperk("_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2", undefined, undefined, ["_encstr_990810B8796F28FB0B6193B21770B42573B3", "_encstr_9BE11576794291812199EB1AC7CE893B61FEEBF084616D", "_encstr_818B1DB9C1AC8D962C1B47CBAF37D20FE834EBDC2BB99BCAAF96B6B5D573B2", "_encstr_8D08176EC1956C2D16D83ABCFAA1ACB09347982759B0B5959C"]);
  registerscriptperk("_encstr_990810B8796F28FB0B6193B21770B42573B3", ::setghost, ::unsetghost, ["_encstr_916914E63856D85AB08DE85EF53B1C6E9A16ADDA5693"]);
  registerscriptperk("_encstr_9BE11576794291812199EB1AC7CE893B61FEEBF084616D");
  registerscriptperk("_encstr_818B1DB9C1AC8D962C1B47CBAF37D20FE834EBDC2BB99BCAAF96B6B5D573B2");
  registerscriptperk("_encstr_AD22156EC1AC1BD2B0B18EF2AF471636D7C9AC37B4E6E8", undefined, undefined, ["_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA", "_encstr_9733153383D563C1D1CA237FE6259ACFE7E085E20FEE93", "_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D", "_encstr_8BA31B339B413F3148C5C45A3F677FADBFF3425B7D5DAFF3CDA31A1F63"]);
  registerscriptperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA", ::setstunresistance, ::unsetstunresistance, ["_encstr_B4DB15D237DB22713140FBD7C148317BA1D85A8C15610A"]);
  registerscriptperk("_encstr_9733153383D563C1D1CA237FE6259ACFE7E085E20FEE93");
  registerscriptperk("_encstr_B4DB15D237DB22713140FBD7C148317BA1D85A8C15610A", ::sethardshell, ::unsethardshell);
  registerscriptperk("_encstr_A6C41D1BE397CEB79B31C5A0416C60D3E0BC4B3F2679CA879043630B2A6F4D", ::setgasgrenaderesist, ::unsetgasgrenaderesist);
  registerscriptperk("_encstr_8BA31B339B413F3148C5C45A3F677FADBFF3425B7D5DAFF3CDA31A1F63");
  registerscriptperk("_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F", undefined, undefined, ["_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9", "_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532", "_encstr_B14C19CD07B28DB42C1BD1BCFADCDBC16385CBB29C8E2CC9EC561D", "_encstr_83371CE0BB1D19A37A7D65EB9973E50150DF4088338F9073422350FB2B8B"]);
  registercodeperkinfo("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7", ::setblindeye, ::unsetblindeye);
  registerscriptperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9", ::setnoscopeoutline, ::unsetnoscopeoutline);
  registerscriptperk("_encstr_83371CE0BB1D19A37A7D65EB9973E50150DF4088338F9073422350FB2B8B");
  registerscriptperk("_encstr_AF8F161B6A1D60CB923B796BDF2A05C8A680065057543871", undefined, undefined, ["_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC"]);
  registerscriptperk("_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC");
  registerscriptperk("_encstr_BE67199EB795D9604B6C4398C138E396AB83BB1964916A93D7B735", undefined, undefined, ["_encstr_9B63139B09C036574770439BFEAD93EF088D051565", "_encstr_85A318D237DB22713140FBD7C1E8317BBFC5DACB13591A8538A8"]);
  registerscriptperk("_encstr_9B63139B09C036574770439BFEAD93EF088D051565", ::setengineer, ::unsetengineer, ["_encstr_B1011D12C3E0AB520F61634F1F20DBF41048CD1F58687C3A5E3973374BDA63"]);
  registerscriptperk("_encstr_85A318D237DB22713140FBD7C1E8317BBFC5DACB13591A8538A8", ::setmarkequipment, ::unsetmarkequipment);
  registerscriptperk("_encstr_B1011D12C3E0AB520F61634F1F20DBF41048CD1F58687C3A5E3973374BDA63", ::setoutlinekillstreaks, ::unsetoutlinekillstreaks);
  level thread _id_1309D();
  registerscriptperk("_encstr_9A360EC74F39AA043E1D2333C71D30C3", undefined, undefined, ["_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19", "_encstr_B86B0F0F88EB3F6A91A01141914B12E24B", "_encstr_9B2A145B1F89AF44DB704B930119FC132004D2C13E10", "_encstr_A73B1A6E1C2BB12D0BB18ECBF59BD039C238B959D8FAC9B26EA5DC3A"]);
  registerscriptperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19", ::setblastshield, ::unsetblastshield);
  registerscriptperk("_encstr_B86B0F0F88EB3F6A91A01141914B12E24B");
  registerscriptperk("_encstr_A73B1A6E1C2BB12D0BB18ECBF59BD039C238B959D8FAC9B26EA5DC3A");
  registerscriptperk("_encstr_A98E15C8705AAAC417D19C23490BD537C957A61343BFAB", undefined, undefined, ["_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B", "_encstr_AA4E16C3AB50AB4B8813914B4F9FB261C839C2687B58BAFD"]);
  registerscriptperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B", ::settracker, ::unsettracker, ["_encstr_A9B916B9C1568D9658D8D1CBBE8EE4B036D6AC4EFA1C9CF6"]);
  registerscriptperk("_encstr_AA4E16C3AB50AB4B8813914B4F9FB261C839C2687B58BAFD");
  registerscriptperk("_encstr_BE321990CB6D69D3EAEDD55B09C21310DFDFB0C8BF0101E1B29544");
  registerscriptperk("_encstr_BE3F1BD740773093A7DA9B22F1235BC80BA36B6FF35DC0ED83133089BA", ::setviewkickoverride, ::unsetviewkickoverride);
  registerscriptperk("_encstr_AC11173F08972B182333F88A89BD3551FE9AA4C388352C50DF");
  registerscriptperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3", ::_id_13094, ::_id_13F31);
}

registerscriptperk(var_0, var_1, var_2, var_3) {
  registerperk(var_0, 1, var_1, var_2, var_3);
}

registercodeperkinfo(var_0, var_1, var_2, var_3) {
  registerperk(var_0, 0, var_1, var_2, var_3);
}

registerperk(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_1))
    level.scriptperks[var_0] = 1;

  if(isDefined(var_2))
    level.perksetfuncs[var_0] = var_2;

  if(isDefined(var_3))
    level.perkunsetfuncs[var_0] = var_3;

  if(isDefined(var_4))
    level.extraperkmap[var_0] = var_4;
}

setovercharge() {
  self setclientomnvar("_encstr_B6E70E6310C157539DCDAFBBD33E8A95", 1);
}

unsetovercharge() {
  self setclientomnvar("_encstr_B6E70E6310C157539DCDAFBBD33E8A95", 0);
}

setfreefall() {}

unsetfreefall() {}

setremotedefuse() {}

unsetremotedefuse() {}

sethardshell() {
  self.shellshockreduction = 0.25;
}

unsethardshell() {
  self.shellshockreduction = 0;
}

setgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive())
    return;
}

unsetgasgrenaderesist() {
  if(scripts\cp_mp\utility\player_utility::_isalive())
    return;
}

_id_131B9() {}

_id_13F6D() {}

setreduceregendelayonobjective() {}

unsetreduceregendelayonobjective() {}

sethardline() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_BA11121877DE0F07A320901790D8D36060E3150F");

  if(scripts\cp\utility::tryingtoleave()) {
    return;
  }
  thread _id_12DE9();
  self.hardlineactive["_encstr_A1F308589BCD96CD476E"] = 0;
}

unsethardline() {
  self.hardlineactive = undefined;
  self notify("_encstr_BA11121877DE0F07A320901790D8D36060E3150F");
}

_id_12DE9() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BA11121877DE0F07A320901790D8D36060E3150F");
  var_0 = 7;

  for(;;) {
    if(isDefined(self.hostdamagefactormedium) && self.hostdamagefactormedium > var_0)
      scriptable_addusedcallbackbypart();

    waitframe();
  }
}

scriptable_addusedcallbackbypart() {
  var_0 = undefined;
  var_0 = ["_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6", "_encstr_A9941ED5621570B0D3095843027FF5886DC627470A3F208FBB421689EB37AD50", "_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6"];
  var_1 = scripts\engine\utility::random(var_0);
  scripts\cp\loot_system::give_munition(var_1, self);
  wait 10;
}

setfastreloadlaunchers() {}

unsetfastreloadlaunchers() {}

setoverkill() {}

unsetoverkill() {}

setkillstreaktoscorestreak() {}

unsetkillstreaktoscorestreak() {}

sixthsense_think_internal() {
  var_0 = scripts\engine\trace::create_default_contents(1);
  var_1 = 0;
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = getsystemtimeinmicroseconds();

  foreach(var_21, var_7 in level.sixth_sense_players) {
    if(!isDefined(var_7)) {
      level.sixth_sense_players[var_21] = undefined;
      break;
    }

    var_8 = 0;
    var_9 = var_7 getEye();
    var_10 = var_7.team;
    var_11 = anglesToForward(var_7 getplayerangles());

    foreach(var_13 in level.spawned_enemies) {
      if(var_2 >= 25) {
        var_2 = 0;
        waitframe();
      }

      if(!isDefined(var_7)) {
        level.sixth_sense_players[var_21] = undefined;
        break;
      }

      if(!var_7 scripts\cp\utility::_hasperk("_encstr_827816B90E56C696C2C6D1BCD7CD96E147A1AF9BCA9B3756")) {
        continue;
      }
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!isDefined(var_13)) {
        continue;
      }
      if(!var_13 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(var_13.team == var_10) {
        continue;
      }
      if(distancesquared(var_13.origin, var_9) > 16000000) {
        continue;
      }
      if(!var_13 triggerbloodmoneyendcameras(var_7)) {
        continue;
      }
      if(isDefined(var_13.vehicle)) {
        continue;
      }
      var_2++;
      var_14 = var_13 getEye();
      var_15 = anglesToForward(var_13 getplayerangles());
      var_16 = var_9 - var_14;
      var_3 = var_14 - var_9;
      var_17 = vectordot(var_16, var_15);

      if(var_17 <= 0) {
        continue;
      }
      var_18 = 0.984808;
      var_19 = length(var_16);

      if(var_17 < var_18 * var_19) {
        continue;
      }
      var_17 = vectordot(var_11, vectorNormalize(var_3));

      if(var_17 < 0.382683) {
        var_2 = var_2 + 2;

        if(scripts\engine\trace::ray_trace_detail_passed(var_14, var_9, var_7, var_0)) {
          var_8 = var_8 | var_7 roof_rpg_covers(var_13);
          break;
        }
      }
    }

    var_7 updatesixthsensevfx(var_8);
  }
}

triggerbloodmoneyendcameras(var_0) {
  if(istrue(self.juggernaut))
    return 1;

  if(isDefined(self.unittype) && self.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B")
    return 1;

  var_1 = self.weapon;
  var_2 = scripts\cp\cp_weapon::getweapongroup(var_1);

  switch (var_2) {
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
      return 1;
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
      if(distancesquared(self.origin, var_0.origin) > 160000)
        return 1;

      break;
  }

  return 0;
}

sixthsense_think() {
  level.sixth_sense_players = [];

  for(;;) {
    waitframe();
    sixthsense_think_internal();
  }
}

setsixthsense() {
  self.sixthsenselastactivetime = 0;
  self.sixthsensestate = 0;
  updatesixthsensevfx(0);
  var_0 = self getentitynumber();
  level.sixth_sense_players[var_0] = self;
}

unsetsixthsense() {
  updatesixthsensevfx(0);
  self.sixthsenselastactivetime = undefined;
  self.sixthsensestate = undefined;
  self.sixthsensesource = undefined;
  self notify("_encstr_8648116DEDDDF844EF41406A1BF3EE10B553DB");
  var_0 = self getentitynumber();
  level.sixth_sense_players[var_0] = undefined;
}

updatesixthsensevfx(var_0) {
  self setclientomnvar("_encstr_8F090D605A191B594785485C94BFE3", var_0);
}

roof_rpg_covers(var_0) {
  var_1 = anglesToForward(self getplayerangles());
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_0.origin - self.origin;
  var_4 = (var_3[0], var_3[1], var_3[2]);
  var_4 = vectorNormalize(var_4);
  var_5 = vectordot(var_2, var_4);

  if(var_5 >= 0.92388)
    return 2;
  else if(var_5 >= 0.5)
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var_2, var_0.origin), 4, 1);
  else if(var_5 >= 0.5)
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var_2, var_0.origin), 128, 64);
  else if(var_5 >= -0.707107)
    return scripts\engine\utility::ter_op(scripts\asm\soldier\mp\melee::isleft2d(self.origin, var_2, var_0.origin), 32, 8);
  else
    return 16;
}

setghost() {
  self.perk_data["_encstr_995214C2933079D235D97F6B235E9B8F58D9FE8DA9E0"] = 0.5;
}

unsetghost() {
  self.perk_data["_encstr_995214C2933079D235D97F6B235E9B8F58D9FE8DA9E0"] = 1;
}

setstunresistance(var_0) {
  if(!isDefined(var_0))
    var_0 = 4;

  var_0 = int(var_0);

  if(var_0 == 10)
    self.stunscalar = 0;
  else
    self.stunscalar = var_0 / 10;
}

unsetstunresistance() {
  self.stunscalar = 1;
}

setblindeye() {}

unsetblindeye() {}

setnoscopeoutline() {}

unsetnoscopeoutline() {}

setengineer() {
  thread engineer_enablemarksafterprematch();
}

engineer_enablemarksafterprematch() {
  self endon("_encstr_9A960E077D9A97B9BFF84FEBD50BAAE8");
  self enableentitymarks("_encstr_BE8F0A272F9B2BE97268AE8B", 1000000);
  self.perkengineerset = 1;
  thread markedentities_think();
}

unsetengineer() {
  if(istrue(self.perkengineerset)) {
    self disableentitymarks("_encstr_BE8F0A272F9B2BE97268AE8B");
    self.perkengineerset = undefined;
  }

  self notify("_encstr_9A960E077D9A97B9BFF84FEBD50BAAE8");
}

brjugg_initdialog() {
  if(!isDefined(level.teamdata))
    level.teamdata = [];

  if(!isDefined(level.teamdata["_encstr_9A8507BA4040188D08"]))
    level.teamdata["_encstr_9A8507BA4040188D08"] = [];

  if(!isDefined(level.teamdata["_encstr_9A8507BA4040188D08"]["_encstr_9775086022BE1B413B8B"]))
    level.teamdata["_encstr_9A8507BA4040188D08"]["_encstr_9775086022BE1B413B8B"] = level.players;

  var_0 = getentitylessscriptablearrayinradius(undefined, undefined, self.origin, 2000);

  foreach(var_2 in var_0) {
    if(issubstr(var_2.type, "_encstr_9A221031C936F67B8EAFB5AEE64BA3A5DE37")) {
      var_2.pavelow_boss_destroyed_watch = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
      var_2.pavelow_boss_destroyed_watch.angles = var_2.angles;
      var_2.pavelow_boss_destroyed_watch setModel("_encstr_A21323C218C02BA648D5756A9F206DF7F8B64A8A8230728A212D6750E998B22F16AB11322B");
      var_2.pavelow_boss_destroyed_watch enableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");
      scripts\cp\cp_outline_utility::outlineenableforplayer(var_2.pavelow_boss_destroyed_watch, self, "_encstr_BEF91B4763529D08D52A560815ACE8D68A9FF197AF5BE538F8C519CDFB", "_encstr_960D052F10EBF0");
    }

    waitframe();
  }
}

_id_11A96() {
  var_0 = ["_encstr_9A221031C936F67B8EAFB5AEE64BA3A5DE37", "_encstr_87ED182B3028C75A5918E59BF80BA399107867AF7003045357A7", "_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6", "_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6", "_encstr_81451C220A596028C3CEF3B70D88C34A2A3D2056A2219C8F1B8873298A92", "_encstr_95381F01A0893F3F8B5F9758752030D850A8F993506B232109ADBF1FE096F287F1", "_encstr_AFC31F4B25894AD71046FDC358C0F4E2D08537B7CDAD9283F02EF5CC13F821EABD", "_encstr_A61020A15B19EF80706627C3CADBA1291F9A816FF8271853D0C141C242D396EB2FA5", "_encstr_97DC21C666B99207E389CF57F8B8D43A67F001FF45E9DA5F6A50FB3B8856BB02FD9DD2", "_encstr_A9941ED5621570B0D3095843027FF5886DC627470A3F208FBB421689EB37AD50", "_encstr_824E21061D73FFE8053755F3E8505158F8A0914715D5E6FFA447678D66CF981EC33D93", "_encstr_96131B9AF3897F1D686FB59535B8E3AFA0E8C1E2FBD4E7D73065B19DE9", "_encstr_996D24691BFDB78089C1A8C37370A3C87708E77082E51FE8570A30FD619BE3B3A604A04B073F", "_encstr_975922828B1B27203351024718096D7B9FBD2F1D10375EF92B3B136E7C5F3BB8D3D4A25B", "_encstr_A6851DA2CBB137553027CDDD6DF0DB776820094B5398834CA067E1C321C8A5", "_encstr_856B17FA48010D6F4368ADCD98884BD45F739113E8D5829F7B", "_encstr_99C614C4398DB7B78EEBD6D5375AA3A5DBDCBE5DC23B", "_encstr_B2B91B70AB21D59D248E9A6B2B904B9C7FCD210FFA727B22D913D49F5B"];

  foreach(var_2 in var_0) {
    var_3 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, var_2);
    var_4 = 0;

    foreach(var_6 in var_3) {
      var_6 setscriptablepartstate(var_2, "_encstr_BE8B08E323FB2BCD6268");
      var_4++;

      if(var_4 % 20)
        wait 0.1;
    }

    wait 0.1;
  }
}

_id_11A8D() {
  var_0 = 10;
  level._id_1215F = [];
  level._id_1215E = [];

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level._id_1215F[var_1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    level._id_1215F[var_1].angles = (0, 0, 0);
    level._id_1215F[var_1] setModel("_encstr_A21323C218C02BA648D5756A9F206DF7F8B64A8A8230728A212D6750E998B22F16AB11322B");
    level._id_1215F[var_1] enableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");
  }

  thread _id_11CE7();
}

_id_11CE7() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(scripts\cp\utility::_hasperk("_encstr_9B63139B09C036574770439BFEAD93EF088D051565"))
      prohibited_weapon_list_from_vehicle();

    wait 0.1;
  }
}

prohibited_weapon_list_from_vehicle() {
  var_0 = 1000;
  var_1 = 10;
  var_2 = ["_encstr_9A221031C936F67B8EAFB5AEE64BA3A5DE37", "_encstr_87ED182B3028C75A5918E59BF80BA399107867AF7003045357A7", "_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6", "_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6", "_encstr_81451C220A596028C3CEF3B70D88C34A2A3D2056A2219C8F1B8873298A92", "_encstr_95381F01A0893F3F8B5F9758752030D850A8F993506B232109ADBF1FE096F287F1", "_encstr_AFC31F4B25894AD71046FDC358C0F4E2D08537B7CDAD9283F02EF5CC13F821EABD", "_encstr_A61020A15B19EF80706627C3CADBA1291F9A816FF8271853D0C141C242D396EB2FA5", "_encstr_97DC21C666B99207E389CF57F8B8D43A67F001FF45E9DA5F6A50FB3B8856BB02FD9DD2", "_encstr_A9941ED5621570B0D3095843027FF5886DC627470A3F208FBB421689EB37AD50", "_encstr_824E21061D73FFE8053755F3E8505158F8A0914715D5E6FFA447678D66CF981EC33D93", "_encstr_96131B9AF3897F1D686FB59535B8E3AFA0E8C1E2FBD4E7D73065B19DE9", "_encstr_996D24691BFDB78089C1A8C37370A3C87708E77082E51FE8570A30FD619BE3B3A604A04B073F", "_encstr_975922828B1B27203351024718096D7B9FBD2F1D10375EF92B3B136E7C5F3BB8D3D4A25B", "_encstr_A6851DA2CBB137553027CDDD6DF0DB776820094B5398834CA067E1C321C8A5", "_encstr_856B17FA48010D6F4368ADCD98884BD45F739113E8D5829F7B", "_encstr_99C614C4398DB7B78EEBD6D5375AA3A5DBDCBE5DC23B", "_encstr_B2B91B70AB21D59D248E9A6B2B904B9C7FCD210FFA727B22D913D49F5B"];
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = getentitylessscriptablearrayinradius(undefined, undefined, self.origin, var_0, var_5);

    foreach(var_8 in var_6)
    var_3[var_3.size] = var_8;
  }

  var_3 = sortbydistance(var_3, self.origin);
  var_11 = level._id_1215F;
  var_12 = [];
  var_13 = [];

  for(var_14 = 0; var_14 < var_3.size; var_14++) {
    if(!isDefined(level._id_1215E[var_3[var_14].index]))
      var_13[var_13.size] = var_3[var_14];
  }

  if(var_13.size > 0) {
    var_15 = 0;

    for(var_14 = 0; var_14 < min(var_13.size, var_1); var_14++) {
      for(var_16 = 0; var_16 < level._id_1215F.size; var_16++) {
        if(isDefined(var_12[var_16])) {
          continue;
        }
        if(isDefined(level._id_1215F[var_16]))
          level._id_1215F[var_16] dontinterpolate();

        level._id_1215F[var_16].origin = var_13[var_14].origin;
        level._id_1215F[var_16].angles = var_13[var_14].angles;
        level._id_1215F[var_16].index = var_13[var_14].index;
        level._id_1215E[level._id_1215F[var_16].index] = undefined;
        level._id_1215E[var_13[var_14].index] = level._id_1215F[var_16];
        unmarkent(level._id_1215F[var_16]);
        var_12[var_16] = var_13[var_14];
        break;
      }
    }
  }
}

unmarkent(var_0) {
  var_0 filterinplayermarks(undefined);
  self.markequipmentstate.markedents = scripts\engine\utility::array_remove(self.markequipmentstate.markedents, var_0);
  var_0 notify("_encstr_AA460B4BD0A9A7BA70BB5634F7" + self getentitynumber());
}

setmarkequipment() {
  self enabletargetmarks();
  thread markequipment_monitorlook();
}

unsetmarkequipment() {
  if(isDefined(self.markequipmentstate)) {
    foreach(var_1 in self.markequipmentstate.markedents) {
      if(isDefined(var_1))
        unmarkent(var_1);
    }
  }

  self.markequipmentstate = undefined;
  self disabletargetmarks();
  self notify("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");
}

markequipment_monitorlook() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");

  if(!isDefined(self.markequipmentstate)) {
    self.markequipmentstate = spawnStruct();
    self.markequipmentstate.markingtime = 0;
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markedents = [];
    self.markequipmentstate.markedentindex = 0;
    self.markequipmentstate.pastmarkedents = [];
    self.markequipmentstate.pastmarkedentindex = 0;
  }

  for(;;) {
    self waittill("_encstr_AC8B15DBC172FA8B19901980D2873C09AEB87FA5FA1085", var_0);
    var_1 = isDefined(var_0) && !isDefined(self.markequipmentstate.markingent);
    self.markequipmentstate.markingent = var_0;
    self.markequipmentstate.markingtime = 0;

    if(var_1)
      thread markequipment_updatestate();
  }
}

_id_1309D() {
  level._id_12FBE = 6000;
  level._id_12FC0 = 1500;
  level._id_12FBF = 1000;
}

markequipment_updatestate() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");
  var_0 = gettime();
  var_1 = 0;

  if(self entityhasmark("_encstr_A1940FD903FBCF747BC05AA328652FEF30", self.markequipmentstate.markingent))
    var_1 = level._id_12FBE;
  else if(self entityhasmark("_encstr_85CE0B9770B02C73A1760F06D2", self.markequipmentstate.markingent))
    var_1 = level._id_12FC0;
  else if(self entityhasmark("_encstr_BE8F0A272F9B2BE97268AE8B", self.markequipmentstate.markingent))
    var_1 = level._id_12FBF;
  else {}

  var_2 = var_1 * var_1;

  while(isDefined(self.markequipmentstate.markingent) && !istrue(self.ishacking)) {
    if(self entitymarkfilteredin(self.markequipmentstate.markingent)) {
      break;
    }

    if(isDefined(self.vehicle) && self.vehicle == self.markequipmentstate.markingent) {
      break;
    }

    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self)) {
      break;
    }

    if(distancesquared(self.origin, self.markequipmentstate.markingent.origin) > var_2) {
      break;
    }

    var_3 = gettime();
    var_4 = var_3 - var_0;
    self.markequipmentstate.markingtime = self.markequipmentstate.markingtime + var_4;

    if(!scripts\engine\utility::array_contains(self.markequipmentstate.markedents, self.markequipmentstate.markingent)) {
      if(scripts\cp\utility::isplayerads()) {
        var_5 = self.markequipmentstate.markedentindex;
        var_6 = self.markequipmentstate.markedents[var_5];

        if(isDefined(var_6)) {
          var_6 filterinplayermarks(undefined);
          outlinehelper_updateentityoutline(var_6);
        }

        self.markequipmentstate.markingent filterinplayermarks(self.team);
        outlinehelper_updateentityoutline(self.markequipmentstate.markingent);
        self.markequipmentstate.markedents[var_5] = self.markequipmentstate.markingent;
        self.markequipmentstate.markedentindex = (var_5 + 1) % 999;

        if(!scripts\engine\utility::array_contains(self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent)) {
          self.markequipmentstate.pastmarkedents[self.markequipmentstate.pastmarkedentindex] = self.markequipmentstate.markingent;
          self.markequipmentstate.pastmarkedentindex++;
        } else {}

        thread unmarkafterduration(self.markequipmentstate.markingent);
        break;
      }
    }

    var_0 = var_3;
    waitframe();
  }

  if(!istrue(self.ishacking)) {
    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    self setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  }

  self.markequipmentstate.markingent = undefined;
  self.markequipmentstate.markingtime = 0;
}

unmarkafterduration(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");
  self endon("_encstr_AA460B4BD0A9A7BA70BB5634F7" + self getentitynumber());
  wait(getdvarint("_encstr_B42E1D0BA7A822CFED2BC858412B53EDB728700AD68CC7344FD8EEE580A55B"));

  if(isDefined(var_0) && isDefined(self))
    unmarkent(var_0);
}

unmarkonownershipchange(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B331111772A77784287ABB0B33F3DD09180A9");
  self endon("_encstr_AA460B4BD0A9A7BA70BB5634F7" + self getentitynumber());

  for(;;)
    wait 0.5;
}

outlinehelper_updateentityoutline(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 getentitynumber();
    outlinehelper_disableentityoutline(var_1);
    outlinehelper_enableentityoutline(var_0);
  }
}

outlinehelper_enableentityoutline(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 getentitynumber();
  var_2 = self.entityoutlines[var_1];

  if(isDefined(var_2)) {
    return;
  }
  var_3 = undefined;

  if(self entitymarkfilteredin(var_0)) {
    var_3 = spawnStruct();
    var_3.prioritygroup = "_encstr_849E0E70308587819F95CBA0EE30483B";
    var_3.hudoutlineassetname = "_encstr_86AA0FCD07B7A38EB2E47DE80B4EB3AC3A";
    outlinehelper_verifydata(var_3);
  }

  var_4 = self entitymarkfilteredin(var_0);

  if(self entityhasmark("_encstr_A1940FD903FBCF747BC05AA328652FEF30", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "_encstr_849E0E70308587819F95CBA0EE30483B";
      var_3.hudoutlineassetname = "_encstr_993E1E3B88D71BD351CEAF9C6F9B57E75959221210B992EB6BBD998B688137EA";
    } else {
      var_3.prioritygroup = "_encstr_960D052F10EBF0";
      var_3.hudoutlineassetname = "_encstr_B67D20DC0EF6D1475939D7737B3AC2E4ECACE8EBB54B1BC66E4727AC2CB5EB2C5A93";
    }

    outlinehelper_verifydata(var_3);
  } else if(self entityhasmark("_encstr_85CE0B9770B02C73A1760F06D2", var_0)) {
    if(!isDefined(var_0.model)) {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "_encstr_849E0E70308587819F95CBA0EE30483B";
      var_3.hudoutlineassetname = "_encstr_82441AB2373FBC589D33A101813A1FE7AB7990038D839BB875DDA19F";
    } else {
      var_3.prioritygroup = "_encstr_960D052F10EBF0";
      var_3.hudoutlineassetname = "_encstr_93111C72976FF3CC1150B76BA06B91DBC7A53BE1F28BAAECFB080B4FF860";
    }

    outlinehelper_verifydata(var_3);
  } else if(self entityhasmark("_encstr_BE8F0A272F9B2BE97268AE8B", var_0)) {
    if(isDefined(var_0.equipmentref) && var_0.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506") {
      return;
    }
    var_3 = spawnStruct();

    if(var_4) {
      var_3.prioritygroup = "_encstr_849E0E70308587819F95CBA0EE30483B";
      var_3.hudoutlineassetname = "_encstr_B6BF1923523FF06D0AABD799FFA33CB0DC6169FBBB9188A962F389";
    } else {
      var_3.prioritygroup = "_encstr_960D052F10EBF0";
      var_3.hudoutlineassetname = "_encstr_BEF91B4763529D08D52A560815ACE8D68A9FF197AF5BE538F8C519CDFB";
    }

    outlinehelper_verifydata(var_3);
  }

  if(isDefined(var_3)) {
    var_2 = spawnStruct();
    self.entityoutlines[var_1] = var_2;
    var_2.list = [];
    var_2.ent = var_0;
    var_5 = getchildoutlineents(var_0);

    foreach(var_7 in var_5) {
      var_8 = scripts\cp\cp_outline_utility::outlineenableforplayer(var_7, self, var_3.hudoutlineassetname, var_3.prioritygroup);
      var_9 = spawnStruct();
      var_9.ent = var_7;
      var_9.id = var_8;
      var_10 = var_7 getentitynumber();
      var_2.list[var_10] = var_9;
    }
  }
}

getchildoutlineents(var_0) {
  if(!isDefined(var_0))
    return [];

  if(!isDefined(var_0.childoutlineents))
    return [var_0];

  return var_0.childoutlineents;
}

outlinehelper_verifydata(var_0) {
  if(!isDefined(var_0.getplayers))
    var_0.getplayers = ::outlinehelper_getallplayers;

  if(!isDefined(var_0.validplayer))
    var_0.validplayer = ::outlinehelper_validplayer;

  if(!isDefined(var_0.hudoutlineassetname))
    var_0.hudoutlineassetname = "_encstr_A6DD112B13A8F33B2BD5672E97F006A3C429D3";

  if(!isDefined(var_0.prioritygroup))
    var_0.prioritygroup = "_encstr_960D052F10EBF0";

  if(!isDefined(var_0.waittime))
    var_0.waittime = 0.1;
}

outlinehelper_getallplayers(var_0, var_1) {
  return level.players;
}

outlinehelper_validplayer(var_0) {
  return 1;
}

outlinehelper_disableentityoutline(var_0) {
  if(isDefined(var_0)) {
    var_1 = self.entityoutlines[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1.list)
      scripts\cp\cp_outline_utility::outlinedisable(var_3.id, var_3.ent);

      self.entityoutlines[var_0] = undefined;
    }
  }
}

setoutlinekillstreaks() {
  thread outlinekillstreaks_enablemarksafterprematch();
}

outlinekillstreaks_enablemarksafterprematch() {
  self endon("_encstr_862617A3AD5FDD13C8A0E8F849A8AA5A630D55DF452D8561B2");
  self enableentitymarks("_encstr_85CE0B9770B02C73A1760F06D2", 1000000);
  self enableentitymarks("_encstr_A1940FD903FBCF747BC05AA328652FEF30", 1000000);
  self.perkoutlinekillstreaksset = 1;
}

unsetoutlinekillstreaks() {
  if(istrue(self.perkoutlinekillstreaksset)) {
    self disableentitymarks("_encstr_85CE0B9770B02C73A1760F06D2");
    self disableentitymarks("_encstr_A1940FD903FBCF747BC05AA328652FEF30");
    self.perkoutlinekillstreaksset = undefined;
  }

  self notify("_encstr_862617A3AD5FDD13C8A0E8F849A8AA5A630D55DF452D8561B2");
}

_id_11B0B(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = var_4 getentitynumber();

    if(!scripts\engine\utility::array_contains(var_1, var_5))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

markedentities_think() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.entityoutlines = [];

  for(;;) {
    self waittill("_encstr_A51F0EB71123523E31C179F6951A15A7", var_0, var_1, var_2);

    if(isDefined(var_0)) {
      foreach(var_4 in var_0)
      outlinehelper_disableentityoutline(var_4);

      if(isDefined(self.markequipmentstate)) {
        self.markequipmentstate.markedents = _id_11B0B(self.markequipmentstate.markedents, var_0);

        if(self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size)
          self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
      }
    }

    if(isDefined(var_1)) {
      foreach(var_7 in var_1)
      outlinehelper_disableentityoutline(var_7);
    }

    if(isDefined(var_2)) {
      foreach(var_10 in var_2)
      outlinehelper_enableentityoutline(var_10);
    }
  }
}

setblastshield() {
  set_perk("_encstr_841A21AC37B25BCBAFB2E138367B37D29DCAF519586BC27656AFC9AC91ABC61DB4DEE6", 0.5);
}

unsetblastshield() {
  set_perk("_encstr_841A21AC37B25BCBAFB2E138367B37D29DCAF519586BC27656AFC9AC91ABC61DB4DEE6", 1);
}

settracker() {
  thread runtrackkillstreakuse();
  thread _id_12DFD();
}

unsettracker() {
  self notify("_encstr_B1BB1013EB2A8AD765F3C973156DD05CFFE1");
}

runtrackkillstreakuse() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9A3D156B5D0782DB51C8C48D8D180C4BED93EF4FEB38BA");

  for(;;) {
    if(scripts\cp\utility::isusingremote()) {
      waitframe();
      scripts\cp\utility::takeperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");

      while(scripts\cp\utility::isusingremote())
        waitframe();

      scripts\cp\utility::giveperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
      break;
    }

    waitframe();
  }
}

_id_12DFD() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B1BB1013EB2A8AD765F3C973156DD05CFFE1");
  var_0 = cos(70);
  var_1 = 0;
  self._id_142B0 = [];
  self.outlineids = [];
  var_2 = 5000;

  for(;;) {
    var_3 = level.spawned_enemies;

    foreach(var_5 in var_3) {
      if(var_1 >= 20) {
        var_1 = 0;
        waitframe();
      }

      if(!isDefined(var_5)) {
        continue;
      }
      if(var_5 scripts\cp\coop_stealth::_id_132D7()) {
        if(isDefined(var_5.fnisinstealthcombat) && var_5[[var_5.fnisinstealthcombat]]())
          continue;
      } else if(isDefined(var_5.current_stealth_state)) {
        if(var_5.current_stealth_state != "_encstr_914B078DB09BAB0BB1" && var_5.current_stealth_state != "_encstr_85BB067A08A3FAB3")
          continue;
      } else
        continue;

      var_1++;
      var_6 = var_5 getentitynumber();
      var_7 = scripts\engine\utility::within_fov(self getEye(), self getplayerangles(), var_5.origin, var_0);

      if(!var_7) {
        continue;
      }
      var_8 = sighttracepassed(self getEye(), var_5 getEye(), 0, undefined);

      if(!var_8) {
        if(isDefined(self._id_142B0[var_6])) {
          var_9 = gettime();
          var_10 = var_9 - var_2;

          if(self._id_142B0[var_6] < var_10) {} else {
            var_5 awardobjtimeforcarrier(var_6, self);
            var_5 thread _id_13F75(self, 5);
          }
        } else {}

        continue;
      }

      var_9 = gettime();
      self._id_142B0[var_6] = var_9;
      var_5 _id_12BE6(var_6, self);
    }

    var_1 = 0;
    waitframe();
  }
}

awardobjtimeforcarrier(var_0, var_1) {
  if(!isDefined(var_1.outlineids[var_0]))
    var_1.outlineids[var_0] = scripts\cp\cp_outline_utility::outlineenableforplayer(self, var_1, "_encstr_851510A39042189B5C38D18F72E308667D7B", "_encstr_BE8F0A272F9B2BE97268AE8B");
}

_id_13F75(var_0, var_1) {
  self endon("_encstr_A6A30C8E390B1BD6FA2BCD56DABC");
  var_2 = self getentitynumber();
  wait(var_1);
  _id_12BE6(var_2, var_0);
}

_id_12BE6(var_0, var_1) {
  var_2 = var_1.outlineids[var_0];

  if(isDefined(var_2)) {
    scripts\cp\cp_outline_utility::outlinedisable(var_2, self);
    var_1.outlineids[var_0] = undefined;
  }

  self notify("_encstr_A6A30C8E390B1BD6FA2BCD56DABC");
}

setviewkickoverride() {
  self.overrideviewkickscale = 0.05;
  self._id_1218D = 0.05;
  self._id_1218E = 0.02;
  self.overrideviewkickscalesniper = 0.3;
  self.overrideviewkickscalepistol = 0.05;
  scripts\cp\cp_weapon::updateviewkickscale();
}

unsetviewkickoverride() {
  self.overrideviewkickscale = undefined;
  self._id_1218D = undefined;
  self._id_1218E = undefined;
  self.overrideviewkickscalesniper = undefined;
  self.overrideviewkickscalepistol = undefined;
  scripts\cp\cp_weapon::updateviewkickscale();
}

_id_13094() {
  self.perk_data["_encstr_86FA0DB595C6592B7D9B1B853658E4"] = 2;
}

_id_13F31() {
  self.perk_data["_encstr_86FA0DB595C6592B7D9B1B853658E4"] = 1;
}

give_tune_up() {
  set_perk("_encstr_A70F123AFB9BF1921E6B70E95DB963A6F083BE13", 1.3);
}

take_tune_up() {
  set_perk("_encstr_A70F123AFB9BF1921E6B70E95DB963A6F083BE13", 1);
}

give_restock() {
  thread recharge_lethals_over_time(30);
}

take_restock() {
  self notify("_encstr_ACD40D5C9748B7C9FD383B4380373C");
}

recharge_lethals_over_time(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACD40D5C9748B7C9FD383B4380373C");
  thread _id_12C5F();
  thread _id_12C5D();
  thread _id_13F8B();

  for(;;) {
    self._id_12141 = register_chopper_boss_combat_actions(self, "_encstr_BA7F0830B3A7859B60B0");
    self._id_12142 = register_chopper_boss_combat_actions(self, "_encstr_AC8F0AE74163F85AAA380AD8");
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_1, var_2, var_3, var_4);
    var_5 = register_chopper_boss_combat_actions(self, "_encstr_BA7F0830B3A7859B60B0");

    if(!isDefined(var_5))
      var_5 = self._id_12141;

    if(var_2.basename == var_5)
      thread kill_drone_turret(self, var_0);

    var_6 = register_chopper_boss_combat_actions(self, "_encstr_AC8F0AE74163F85AAA380AD8");

    if(!isDefined(var_6))
      var_6 = self._id_12142;

    if(var_2.basename == var_6)
      thread kill_furthest_enemy(self, var_0);
  }
}

_id_13F8B() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACD40D5C9748B7C9FD383B4380373C");

  for(;;) {
    self waittill("_encstr_BDD60FC17BDD2BE4CDFAD507910B8E95C8");
    self._id_12141 = register_chopper_boss_combat_actions(self, "_encstr_BA7F0830B3A7859B60B0");
    self._id_12142 = register_chopper_boss_combat_actions(self, "_encstr_AC8F0AE74163F85AAA380AD8");
  }
}

_id_12C5F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_ACD40D5C9748B7C9FD383B4380373C");
  self._id_14388 = 0;
  self._id_14387 = 0;
  self setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", -1);
  self setclientomnvar("_encstr_BE9F1C4DAC0129419C43D0B0B7B2196F1AD646DC07B9D96B7F6770E07FEB", 0);
  self setclientomnvar("_encstr_A1BC1E5D96D7E80B361D96D85863AF27CAB1432CC97659FA0E9CBD9DE42BB99B", 0);
}

_id_12C5D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACD40D5C9748B7C9FD383B4380373C");
  var_0 = 30;
  self waittill("_encstr_BD3B15285AD599F9CB3FD75C0C17C3273AE25850F22BD5");

  if(race_get_next_checkpoint(self, "_encstr_BA7F0830B3A7859B60B0") < race_init(self, "_encstr_BA7F0830B3A7859B60B0"))
    thread kill_drone_turret(self, var_0);

  if(race_get_next_checkpoint(self, "_encstr_AC8F0AE74163F85AAA380AD8") < race_init(self, "_encstr_AC8F0AE74163F85AAA380AD8"))
    thread kill_furthest_enemy(self, var_0);
}

kill_drone_turret(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACD40D5C9748B7C9FD383B4380373C");
  self endon("_encstr_B64D16535807C851130B6F7DB01FBC5FA309B6421E53B4FD");

  if(istrue(var_0._id_14387)) {
    return;
  }
  thread _id_138C5("_encstr_BE9F1C4DAC0129419C43D0B0B7B2196F1AD646DC07B9D96B7F6770E07FEB", "_encstr_BA7F0830B3A7859B60B0");
  var_0._id_14387 = 1;
  _id_13FAC("_encstr_BE9F1C4DAC0129419C43D0B0B7B2196F1AD646DC07B9D96B7F6770E07FEB", var_1, 0);
  var_0._id_14387 = 0;
  var_0 scripts\cp\cp_powers::power_addammo(race_is_player_driving_vehicle(var_0, "_encstr_BA7F0830B3A7859B60B0"), 1);

  if(race_get_next_checkpoint(var_0, "_encstr_BA7F0830B3A7859B60B0") < race_init(var_0, "_encstr_BA7F0830B3A7859B60B0"))
    var_0 thread kill_drone_turret(self, var_1);
  else
    var_0 notify("_encstr_9BA60DF0F713D3876294E80DEDCAEB");
}

kill_furthest_enemy(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACD40D5C9748B7C9FD383B4380373C");
  self endon("_encstr_B64D16535807C851130B6F7DB01FBC5FA309B6421E53B4FD");

  if(istrue(var_0._id_14388)) {
    return;
  }
  thread _id_138C5("_encstr_A1BC1E5D96D7E80B361D96D85863AF27CAB1432CC97659FA0E9CBD9DE42BB99B", "_encstr_AC8F0AE74163F85AAA380AD8");
  var_0._id_14388 = 1;
  _id_13FAC("_encstr_A1BC1E5D96D7E80B361D96D85863AF27CAB1432CC97659FA0E9CBD9DE42BB99B", var_1, 1);
  var_0._id_14388 = 0;
  var_0 scripts\cp\cp_powers::power_addammo(race_is_player_driving_vehicle(var_0, "_encstr_AC8F0AE74163F85AAA380AD8"), 1);

  if(race_get_next_checkpoint(var_0, "_encstr_AC8F0AE74163F85AAA380AD8") < race_init(var_0, "_encstr_AC8F0AE74163F85AAA380AD8"))
    var_0 thread kill_furthest_enemy(self, var_1);
  else
    var_0 notify("_encstr_9BA60DF0F713D3876294E80DEDCAEB");
}

_id_13FAC(var_0, var_1, var_2) {
  self setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", -1);
  var_3 = gettime();
  var_4 = var_3 + var_1 * 1000;
  var_5 = gettime();

  while(var_5 < var_4) {
    while(istrue(self.inlaststand)) {
      self setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", -1);
      self setclientomnvar(var_0, 0);
      waitframe();
    }

    var_5 = gettime();
    var_6 = (var_5 - var_3) / (var_4 - var_3);
    self setclientomnvar(var_0, var_6);
    wait 0.1;
  }

  self setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", var_2);
  self setclientomnvar(var_0, 0);
}

_id_138C5(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ACD40D5C9748B7C9FD383B4380373C");
  self endon("_encstr_9BA60DF0F713D3876294E80DEDCAEB");

  while(istrue(self.inlaststand) || race_get_next_checkpoint(self, var_1) < race_init(self, var_1))
    waitframe();

  self notify("_encstr_B64D16535807C851130B6F7DB01FBC5FA309B6421E53B4FD");

  if(var_1 == "_encstr_BA7F0830B3A7859B60B0")
    self._id_14387 = 0;
  else
    self._id_14388 = 0;

  self setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", -1);
  self setclientomnvar(var_0, 0);
}

register_chopper_boss_combat_actions(var_0, var_1) {
  foreach(var_3 in var_0.powers) {
    if(var_3.slot == var_1)
      return var_3.weaponuse;
  }
}

race_is_player_driving_vehicle(var_0, var_1) {
  foreach(var_4, var_3 in var_0.powers) {
    if(var_3.slot == var_1)
      return var_4;
  }
}

race_get_next_checkpoint(var_0, var_1) {
  foreach(var_3 in var_0.powers) {
    if(var_3.slot == var_1)
      return var_3.charges;
  }
}

race_init(var_0, var_1) {
  foreach(var_3 in var_0.powers) {
    if(var_3.slot == var_1)
      return var_3.maxcharges;
  }
}

give_amped() {
  scripts\cp\utility::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\cp\utility::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  scripts\cp\utility::giveperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\cp\utility::giveperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
}

take_amped() {}

give_shrapnel() {}

take_shrapnel() {}

setmomentum() {
  thread runmomentum();
}

runmomentum() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");

  for(;;) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.movespeedscaler = 1;

      if(isDefined(level.move_speed_scale))
        self[[level.move_speed_scale]]();
    }

    wait 0.1;
  }
}

graduallyincreasespeed() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  thread momentum_monitormovement();
  thread momentum_monitordamage();

  for(var_0 = 0; var_0 < 0.08; var_0 = var_0 + 0.01) {
    self.movespeedscaler = self.movespeedscaler + 0.01;

    if(isDefined(level.move_speed_scale))
      self[[level.move_speed_scale]]();

    wait 0.4375;
  }

  self playlocalsound("_encstr_8ED00D32E85178BB50A33F95512BA8");
  self notify("_encstr_A92313E83FEDD1A53333D1F00D5AB1DE5BDB20D07B");
  thread momentum_endaftermax();
  self waittill("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
}

momentum_endaftermax() {
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
  self waittill("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
  self playlocalsound("_encstr_B2600E507538875308214A770FDADBB4");
}

momentum_monitormovement() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
        break;
      }
    }

    waitframe();
  }
}

momentum_monitordamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B2BE0788BAF573592F");
  self notify("_encstr_95CD0FADF6B559CD1D57B6F53959B92B8E");
}

unsetmomentum() {
  self notify("_encstr_86F20F5BDED6569B475DDABEAECDE6CA3A");
}

watchcombatspeedscaler() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self.pistolcombatspeedscalar = 1.0;
  self.aliensnarespeedscalar = 1.0;
  self.aliensnarecount = 0;
  self.combatspeedscalar = getcombatspeedscalar();
  self[[level.move_speed_scale]]();

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);
    var_1 = self getcurrentweapon();
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);

    if(isDefined(var_2)) {
      if(var_2 == "_encstr_991904B6EE39" || var_2 == "_encstr_8CD208BB70DBCFABA3B1" || var_2 == "_encstr_AD6105DA0C2787" || var_2 == "_encstr_B61804B26BB1")
        self.pistolcombatspeedscalar = 1.1;
      else
        self.pistolcombatspeedscalar = 1.0;

      wait 0.05;
      updatecombatspeedscalar();
    }

    wait 0.05;
  }
}

updatecombatspeedscalar() {
  self.combatspeedscalar = getcombatspeedscalar();
  self[[level.move_speed_scale]]();
}

getcombatspeedscalar() {
  return self.pistolcombatspeedscalar * self.aliensnarespeedscalar;
}

removeperk(var_0) {
  scripts\cp\utility::_unsetperk(var_0);
  scripts\cp\utility::_unsetextraperks(var_0);
}