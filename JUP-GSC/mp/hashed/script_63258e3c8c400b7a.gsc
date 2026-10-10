/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_63258e3c8c400b7a.gsc
*************************************************/

#namespace namespace_e32cfb70bef6259e;

function function_f245f059d32d19d1(luielemname, assethash) {
  luielem = spawnStruct();
  luielem.menuname = luielemname;

  if(!isDefined(level.var_eae5a4af1df80588)) {
    level.var_eae5a4af1df80588 = [];
  }

  if(!isDefined(level.var_eae5a4af1df80588[assethash])) {
    level.var_eae5a4af1df80588[assethash] = 1;
  }

  luielem.regid = level.var_eae5a4af1df80588[assethash];
  level.var_eae5a4af1df80588[assethash]++;
  luielem.var_b6017d7dcc83fdb6 = 0;
  return luielem;
}

function function_12e2ab1f2879518a(player, flags) {
  if(!isDefined(flags)) {
    flags = 0;
  }

  luielem = self;
  luielem.var_b6017d7dcc83fdb6 = 1;
  player openluielem(luielem.menuname, luielem.regid, flags);
}

function function_e98e8bd148625cd0(player) {
  luielem = self;
  luielem.var_b6017d7dcc83fdb6 = 0;
  player closeluielem(luielem.menuname, luielem.regid);
}

function function_23de77f715d51c8b(player) {
  luielem = self;
  return player function_2b845d725b2e174(luielem.menuname, luielem.regid);
}

function function_2c7278ea5ca893e5(player, data, value) {
  luielem = self;
  player function_6cdcaf34ab57e074(luielem.menuname, luielem.regid, data, value);
}