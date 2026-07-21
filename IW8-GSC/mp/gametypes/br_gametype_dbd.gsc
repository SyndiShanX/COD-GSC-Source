/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_dbd.gsc
***********************************************/

init() {
  setDvar("_encstr_976C1A9B6CC9FA31397D2C8D1D0E39B2B5B0E88D4336F65846EDBA3A", "_encstr_86DD1AB18DC2379B47C2893695BE319C23C4C8BE389CCA6B0B471B34");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A3511399F56AFBE9595B700BE79DA369C29D0714CF", ::modifyplayerdamage);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A9DC0F9AB5C75A7E1C30A79B90300912A9", ::_id_1264B);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A33A0DC9823F814FC12D95A14D37EB", ::_id_12803);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C", ::_id_12604);

  if(getdvarint("_encstr_8D7C1E081FE2664DA3A9455E7FA9BDE9508F1B686FB75813EB8B49D5D6A2FD71", 0) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8CE711B1A5E88E1B2B24B439329A072CDDB96E");

  if(getdvarint("_encstr_8B2519B3069219D6CB8F31C59BE1242B501C39E82FD73896935727", 0) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_AA630C8E27D51B5B4D1CC2DD9BDC");

  if(getdvarint("_encstr_95DD186BDE7AF13E3367E9EDA3C97C780834118DC7EF9065BAC3", 0) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A1270BA8AAA7E16FCB71AC285B");

  if(getdvarint("_encstr_B84D1C676F9E51C2087E971EF1891E0A7B93BF93DB50ABB9D8E34DE3C9D8", 0) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_AC4D0F4B90F1F252451D2A6AFF13AB869B");

  if(getdvarint("_encstr_8C3B177EAB0326154A29C0F8B229E5B983598E79050FA97133", 0) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_B82C0A0FA3DB1FBBD177D09B");

  if(getdvarint("_encstr_B6751EEE3B93B6A5FA995068C259750913A97EE9957FB8F723A2F8980B6E0941", 0) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_99D711CD7D55A852E1F919D46AF97F6F1808B6");

  level._id_11C95 = ::_id_11C95;
  level.disable_super_in_turret.iscodecorrect = getdvarint("_encstr_8BD71A2B9FC889EB5E86325A09203B7A901FA78E3948CAFB8F985AD2", 3550);
  level.disable_super_in_turret.iscontender = getdvarint("_encstr_97761B78D27A57A13BA7CD36746728FB668AF8285BD76F19739247354D", 1);
  level.disable_super_in_turret.iscloseto = getdvarfloat("_encstr_B49D1A7616EB7789B2C790B833C76143437FE7F16E52DB938B63B030", 2.5);
  level.disable_super_in_turret.iscrossbowbolt = getdvarint("_encstr_A3451B86238BAE8DD2A178702AA167033FC58E75BF7F30F7FE2A3060A3", 4);
  level.disable_super_in_turret.iscopiedclass = getdvarint("_encstr_B1D71DB936277D314EF523C491F59BDECDDBDC59B90DED47B9CDC1E419B6CE", 275);
  level.disable_super_in_turret._encstr_827813B1AE27E456DC47D5375AD956C937853643E0 = getdvarint("_encstr_99FC1EEA59A06F0A1E9FCFABDBC4A29A40E1A57990082743FDF5B7C33BE08AC5", 300);
  level.disable_super_in_turret._encstr_A98A1870124AFAC473558C26C08BD085C54322F1043ACB83D847 = getdvarint("_encstr_BA4A22F347105103B67EDA8221185B9418239C57FF58229BC870A359496B370BC9991DF7", 0);
}

_id_12803() {
  if(getdvarint("_encstr_ACAC24CF7758EF64392129CD36641C17EAFD5B01EA4571B3F7CD41706A4DB5EF9243A77DE0B9", 1) == 0) {
    return;
  }
  setDvar("_encstr_8EB10B48F101F2EBF4BEDDDCD6", getdvarint("_encstr_A2A119371B27D79827F5322619D7990BB13643594B3B0D47DA5A37", 1120));
  setDvar("_encstr_B8610BC5BCB99F08E167979F37", getdvarint("_encstr_BAA119CDB19CBE4C27D7238991EB990BB1C6D02BD2CEA11DD6C21E", 1121));
  setDvar("_encstr_B6A30B7A9AC413984596A2D429", getdvarint("_encstr_A2A119371B27D79827F5322619D7990BB13643594B3B0D47DA5A37", 1120));
  setDvar("_encstr_91210B8D31359451D7313824D9", getdvarint("_encstr_BAA119CDB19CBE4C27D7238991EB990BB1C6D02BD2CEA11DD6C21E", 1121));
}

modifyplayerdamage(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.objweapon);

  if(var_0.objweapon.classname == "_encstr_850707F7E5833355B8" && (var_0.shitloc == "_encstr_81CC0586952C91" || var_0.shitloc == "_encstr_A6CC076A05751852B3") && !usefailvehiclemsg(var_1)) {
    var_2 = var_0.attacker;
    var_3 = var_0.victim;
    var_4 = var_3.br_maxarmorhealth + var_3.maxhealth;
    var_5 = distancesquared(var_2.origin, var_3.origin);

    if(level._encstr_8C791A1EBE37BBFEB81837634971A1532BDD2914A68F0239C0880727 == 0 && var_0.damage >= level.disable_super_in_turret._encstr_827813B1AE27E456DC47D5375AD956C937853643E0 && var_5 < level.disable_super_in_turret.iscodecorrect * level.disable_super_in_turret.iscodecorrect)
      return var_4;

    if(level.disable_super_in_turret._encstr_A98A1870124AFAC473558C26C08BD085C54322F1043ACB83D847 == 1 && var_5 < level.disable_super_in_turret.iscodecorrect * level.disable_super_in_turret.iscodecorrect) {
      if(!istrue(var_3.isjuggernaut))
        return var_4;
      else
        return var_3.br_maxarmorhealth + var_3.juggcontext.prevmaxhealth;
    } else
      return max(level.disable_super_in_turret.iscopiedclass, var_0.damage);
  }

  return var_0.damage;
}

usefailvehiclemsg(var_0) {
  return var_0 == "_encstr_82660D691C902EABA8293197FB038E" || var_0 == "_encstr_88F60EF477AA1917C80F0C3A6946EACA" || var_0 == "_encstr_92DF0ED45BDA2E53D81F08FF1B5F9FC2" || var_0 == "_encstr_A1E90DBB8CDA89536851CF8BDD6B66" || var_0 == "_encstr_928210A17CC2BF6265499B129B43DFB323EF" || var_0 == "_encstr_8BE10EBF5ACEE07BAFE44BB1605A936F" || var_0 == "_encstr_B2050D9B944F0F7A41AB41B8220B1A" || var_0 == "_encstr_99B310905209D5DBA9FAC38B62BB2FE0850A" || var_0 == "_encstr_81A6117B61F155DBB8B032EA3B0BCF1AAA13B6";
}

_id_1264B(var_0) {
  if(istrue(self.adrenalinepoweractive))
    return int(level.disable_super_in_turret.iscontender * level.disable_super_in_turret.iscrossbowbolt);

  return int(level.disable_super_in_turret.iscontender);
}

_id_11C95(var_0) {
  return int(var_0 * level.disable_super_in_turret.iscloseto);
}

_id_12604() {
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::searchcircleorigin(0, 1, 0);
}