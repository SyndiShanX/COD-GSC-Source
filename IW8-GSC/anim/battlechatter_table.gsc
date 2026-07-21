/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\battlechatter_table.gsc
***********************************************/

bctable_setfiles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  anim.bctable[var_0] = [];

  if(isDefined(anim.bctabledeck))
    anim.bctabledeck[var_0] = undefined;

  if(isDefined(anim.bctablelast))
    anim.bctablelast[var_0] = undefined;

  if(isDefined(var_1))
    bctable_addfile(var_0, var_1);

  if(isDefined(var_2))
    bctable_addfile(var_0, var_2);

  if(isDefined(var_3))
    bctable_addfile(var_0, var_3);

  if(isDefined(var_4))
    bctable_addfile(var_0, var_4);

  if(isDefined(var_5))
    bctable_addfile(var_0, var_5);

  if(isDefined(var_6))
    bctable_addfile(var_0, var_6);
}

bctable_addfile(var_0, var_1) {
  var_2 = 0;

  for(;;) {
    var_3 = tolower(tablelookupbyrow(var_1, var_2, 0));
    var_4 = tolower(tablelookupbyrow(var_1, var_2, 1));
    var_5 = [];

    for(;;) {
      var_6 = tolower(tablelookupbyrow(var_1, var_2, var_5.size + 2));

      if(var_6 == "") {
        break;
      }

      var_5[var_5.size] = var_6;
    }

    if(var_3 == "" && var_4 == "" && var_5.size == 0) {
      break;
    }

    if(var_3 == "")
      var_3 = "all";

    if(var_4 == "")
      var_4 = "all";

    var_7 = bctable_categorykey(var_3, var_4);

    if(!isDefined(anim.bctable[var_0][var_7]))
      anim.bctable[var_0][var_7] = [];

    var_8 = anim.bctable[var_0][var_7].size;
    anim.bctable[var_0][var_7][var_8] = var_5;
    var_2++;
  }
}

bctable_pickaliasset(var_0, var_1, var_2) {
  var_3 = bctable_categorykey(var_1, var_2);

  if(!bctable_exists(var_0, var_1, var_2))
    return undefined;

  if(!isDefined(anim.bctabledeck) || !isDefined(anim.bctabledeck[var_0]) || !isDefined(anim.bctabledeck[var_0][var_3])) {
    anim.bctabledeck[var_0][var_3] = [];

    for(var_4 = 0; var_4 < anim.bctable[var_0][var_3].size; var_4++)
      anim.bctabledeck[var_0][var_3][var_4] = var_4;

    var_5 = anim.bctabledeck[var_0][var_3].size;

    if(var_5 >= 3)
      anim.bctabledeck[var_0][var_3] = scripts\engine\utility::array_randomize(anim.bctabledeck[var_0][var_3]);

    if(var_5 >= 2) {
      if(isDefined(anim.bctablelast) && isDefined(anim.bctablelast[var_0][var_3]) && anim.bctablelast[var_0][var_3] == anim.bctabledeck[var_0][var_3][var_5 - 1]) {
        var_6 = anim.bctabledeck[var_0][var_3][0];
        anim.bctabledeck[var_0][var_3][0] = anim.bctabledeck[var_0][var_3][var_5 - 1];
        anim.bctabledeck[var_0][var_3][var_5 - 1] = var_6;
      }
    }
  }

  if(anim.bctabledeck[var_0][var_3].size == 0)
    return undefined;

  var_7 = anim.bctabledeck[var_0][var_3].size - 1;
  var_8 = anim.bctabledeck[var_0][var_3][var_7];
  var_9 = anim.bctable[var_0][var_3][var_8];
  anim.bctabledeck[var_0][var_3][var_7] = undefined;

  if(anim.bctabledeck[var_0][var_3].size == 0)
    anim.bctabledeck[var_0][var_3] = undefined;

  anim.bctablelast[var_0][var_3] = var_8;
  return var_9;
}

bctable_exists(var_0, var_1, var_2) {
  if(!isDefined(anim.bctable) || !isDefined(anim.bctable[var_0]))
    return 0;

  var_3 = bctable_categorykey(var_1, var_2);

  if(!isDefined(anim.bctable[var_0][var_3]))
    return 0;

  if(anim.bctable[var_0][var_3].size == 0)
    return 0;

  return 1;
}

bctable_categorykey(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "all";

  if(!isDefined(var_1))
    var_1 = "all";

  return tolower(var_0) + "_" + tolower(var_1);
}