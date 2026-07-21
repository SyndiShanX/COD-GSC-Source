/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58262.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8B820C8D96391B1B59FAC1ACB2B6", ::_id_13E25, undefined, ::_id_13E0D);
  var_0 = "_encstr_82820C619AC3B660A7A71123810C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A57310656BEB89C60B1243A17B21C36B278F"] = var_0 + "_encstr_AB430576C3D388";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_972214AC79FF33CAADD9B146143D497DA9D0C0353863"] = var_0 + "_encstr_A3BD09C633595885CA97A1";
}

weapongivenchoppergunner(var_0) {
  return 1;
}

_id_13E24() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8B820C8D96391B1B59FAC1ACB2B6", self);
  return _id_13E25(var_0);
}

_id_13E0D() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8B820C8D96391B1B59FAC1ACB2B6", self);
  var_0._id_133CE = 1;
  return _id_13E25(var_0, 1);
}

_id_13E25(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  if(!istrue(var_1)) {
    var_2 = getcompleteweaponname("_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039");
    var_3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, var_2);

    if(!istrue(var_3))
      return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  var_4 = gulag_intro_vo(var_0);

  if(!istrue(var_4))
    return var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.streakname, self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_B47106834B35B9CF" + var_0.streakname, self);

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1);

  if(istrue(var_1))
    scripts\mp\utility\dialog::playkillstreakusedialog(var_0.streakname);

  return 1;
}

gulag_intro_vo(var_0) {
  if(!isDefined(level._id_13ACA))
    return 0;

  if(!isDefined(level.br_circle.circleindex))
    return 0;

  if(!isDefined(level._id_13ACA[self.team]))
    level._id_13ACA[self.team] = 0;

  var_1 = level._id_13ACA[self.team] + level.br_circle.circleindex + 1;

  for(var_2 = var_1; var_2 < level.gulag_tutorial_vo.size; var_2++)
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12972(self.team);

  return 1;
}