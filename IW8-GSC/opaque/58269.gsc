/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58269.gsc
***********************************************/

init() {
  if(!getdvarint("_encstr_AD1A206BDE7AF13E3367C1F1B74AFD783FB4508D85C360EEBA87CF8FDF82CF88D48F", 0)) {
    return;
  }
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_A3340BD89A06AFCBFF2F46C8F0", ::_id_13E2D, undefined, ::_id_13E10);
}

_id_13E2D(var_0, var_1) {
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

  var_4 = _id_1239E(var_0);

  if(!istrue(var_4))
    return var_4;

  _id_1239F();
  return 1;
}

_id_13E10() {}

_id_1239E(var_0) {
  var_1 = self;
  var_2 = spawnStruct();
  var_2.origin = var_1.origin + (100, 0, 0);
  var_2.angles = var_1.angles;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_3 setModel("_encstr_AF991C1915C91725664AF1500921FB91015B54F7F567EAE313F15CE2A063");
  var_3.angles = var_2.angles;
  var_3 makeusable();
  var_3 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_3 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_3 sethintdisplayfov(120);
  var_3 setusefov(120);
  var_3 setuserange(80);
  var_3 setusepriority(-1);
  var_3 setHintString(&"_encstr_A62114B70160D09F1D330D71863320947539A337B147");
  var_3 sethinttag("_encstr_BA300854E318F1FF9699");
  var_3 setuseprioritymax();
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_4, "_encstr_AF5A081BBAC993AC73A3", var_2.origin, "_encstr_BAEF1FC38D6B16D3DEFA60E19274E1C89F1456CDF10F5E29C5E230886A81B5604B");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_4);
  } else {}

  return 1;
}

_id_1239F() {
  var_0 = self;
  wait 5;
  iprintlnbold("_encstr_8D6710A089828EAAA88009E92C80559A8A44");
}