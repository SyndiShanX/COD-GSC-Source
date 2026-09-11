/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_table.gsc
************************************************/

function bctable_setfiles(var0, var1, var2, var3, var4, var5, var6) {
  anim.bctable[var0] = [];

  if(isDefined(anim.bctabledeck)) {
    anim.bctabledeck[var0] = undefined;
  }

  if(isDefined(anim.bctablelast)) {
    anim.bctablelast[var0] = undefined;
  }

  if(isDefined(var1)) {
    bctable_addfile(var0, var1);
  }

  if(isDefined(var2)) {
    bctable_addfile(var0, var2);
  }

  if(isDefined(var3)) {
    bctable_addfile(var0, var3);
  }

  if(isDefined(var4)) {
    bctable_addfile(var0, var4);
  }

  if(isDefined(var5)) {
    bctable_addfile(var0, var5);
  }

  if(isDefined(var6)) {
    bctable_addfile(var0, var6);
    return;
  }
}

function bctable_addfile(var0, var1) {
  for(var2 = 0;; var2++) {
    var3 = tolower(tablelookupbyrow(var1, var2, 0));
    var4 = tolower(tablelookupbyrow(var1, var2, 1));

    for(var5 = [];; var5 = var6) {
      var6 = tolower(tablelookupbyrow(var1, var2, var5.size + 2));

      if(var6 == "") {
        break;
      }
    }

    if(var3 == "" && var4 == "" && var5.size == 0) {
      break;
    }

    if(var3 == "") {
      var3 = "all";
    }

    if(var4 == "") {
      var4 = "all";
    }

    var7 = bctable_categorykey(var3, var4);

    if(!isDefined(anim.bctable[var0][var7])) {
      anim.bctable[var0][var7] = [];
    }

    var8 = anim.bctable[var0][var7].size;
    anim.bctable[var0][var7][var8] = var5;
  }
}

function bctable_pickaliasset(var0, var1, var2) {
  var3 = bctable_categorykey(var1, var2);

  if(!bctable_exists(var0, var1, var2)) {
    return undefined;
  }

  if(!isDefined(anim.bctabledeck) || !isDefined(anim.bctabledeck[var0]) || !isDefined(anim.bctabledeck[var0][var3])) {
    anim.bctabledeck[var0][var3] = [];

    for(var4 = 0; var4 < anim.bctable[var0][var3].size; var4++) {
      anim.bctabledeck[var0][var3][var4] = var4;
    }

    var5 = anim.bctabledeck[var0][var3].size;

    if(var5 >= 3) {
      anim.bctabledeck[var0][var3] = scripts\engine\utility::array_randomize(anim.bctabledeck[var0][var3]);
    }

    if(var5 >= 2) {
      if(isDefined(anim.bctablelast) && isDefined(anim.bctablelast[var0][var3]) && anim.bctablelast[var0][var3] == anim.bctabledeck[var0][var3][var5 - 1]) {
        var6 = anim.bctabledeck[var0][var3][0];
        anim.bctabledeck[var0][var3][0] = anim.bctabledeck[var0][var3][var5 - 1];
        anim.bctabledeck[var0][var3][var5 - 1] = var6;
      }
    }
  }

  if(anim.bctabledeck[var0][var3].size == 0) {
    return undefined;
  }

  var7 = anim.bctabledeck[var0][var3].size - 1;
  var8 = anim.bctabledeck[var0][var3][var7];
  var9 = anim.bctable[var0][var3][var8];
  anim.bctabledeck[var0][var3][var7] = undefined;

  if(anim.bctabledeck[var0][var3].size == 0) {
    anim.bctabledeck[var0][var3] = undefined;
  }

  anim.bctablelast[var0][var3] = var8;
  return var9;
}

function bctable_exists(var0, var1, var2) {
  if(!isDefined(anim.bctable) || !isDefined(anim.bctable[var0])) {
    return false;
  }

  var3 = bctable_categorykey(var1, var2);

  if(!isDefined(anim.bctable[var0][var3])) {
    return false;
  }

  if(anim.bctable[var0][var3].size == 0) {
    return false;
  }

  return true;
}

function bctable_categorykey(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "all";
  }

  if(!isDefined(var1)) {
    var1 = "all";
  }

  return tolower(var0) + "_" + tolower(var1);
}