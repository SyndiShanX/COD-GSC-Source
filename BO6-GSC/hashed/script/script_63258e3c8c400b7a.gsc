/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_63258e3c8c400b7a.gsc
*****************************************************/

#namespace lui_elems;

function function_408bce745a74d79c(luielemname, assethash) {
  luielem = spawnStruct();
  luielem.menuname = luielemname;

  if(!isDefined(level.luielemregistrations)) {
    level.luielemregistrations = [];
  }

  if(!isDefined(level.luielemregistrations[assethash])) {
    level.luielemregistrations[assethash] = 1;
  }

  luielem.regid = level.luielemregistrations[assethash];
  level.luielemregistrations[assethash]++;
  luielem.var_ed2f150a9ce55b3b = 0;
  return luielem;
}

function function_33638b78bd8f3ecf(player, flags) {
  if(!isDefined(flags)) {
    flags = 0;
  }

  luielem = self;
  luielem.var_ed2f150a9ce55b3b = 1;
  player openluielem(luielem.menuname, luielem.regid, flags);
}

function function_584186d2702f7cb9(player) {
  luielem = self;
  luielem.var_ed2f150a9ce55b3b = 0;
  player closeluielem(luielem.menuname, luielem.regid);
}

function function_d032a65d50c54326(player) {
  luielem = self;
  return player function_8b68770d248a6c6d(luielem.menuname, luielem.regid);
}

function function_be160d9d4ca95880(player, data, value) {
  luielem = self;
  player function_6c9d7aab07ebb5f5(luielem.menuname, luielem.regid, data, value);
}