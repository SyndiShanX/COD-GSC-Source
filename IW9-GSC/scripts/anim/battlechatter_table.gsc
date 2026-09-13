/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_table.gsc
************************************************/

bctable_setfiles(category, _id_466B5C66CB068EDF, _id_466B5D66CB069112, _id_466B5E66CB069345, _id_466B5766CB0683E0, _id_466B5866CB068613, _id_466B5966CB068846) {
  anim.bctable[category] = [];

  if(isDefined(anim.bctabledeck))
    anim.bctabledeck[category] = undefined;

  if(isDefined(anim.bctablelast))
    anim.bctablelast[category] = undefined;

  if(isDefined(_id_466B5C66CB068EDF))
    bctable_addfile(category, _id_466B5C66CB068EDF);

  if(isDefined(_id_466B5D66CB069112))
    bctable_addfile(category, _id_466B5D66CB069112);

  if(isDefined(_id_466B5E66CB069345))
    bctable_addfile(category, _id_466B5E66CB069345);

  if(isDefined(_id_466B5766CB0683E0))
    bctable_addfile(category, _id_466B5766CB0683E0);

  if(isDefined(_id_466B5866CB068613))
    bctable_addfile(category, _id_466B5866CB068613);

  if(isDefined(_id_466B5966CB068846))
    bctable_addfile(category, _id_466B5966CB068846);
}

bctable_addfile(category, _id_615B735DDA2A4C94) {
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_E37A12D937D7DAD9 = tolower(tablelookupbyrow(_id_615B735DDA2A4C94, _id_CB89110314447B2F, 0));
    _id_1A7BD761BF8E6AD4 = tolower(tablelookupbyrow(_id_615B735DDA2A4C94, _id_CB89110314447B2F, 1));
    _id_37BCCD17FEA9D291 = [];

    for(;;) {
      alias = tolower(tablelookupbyrow(_id_615B735DDA2A4C94, _id_CB89110314447B2F, _id_37BCCD17FEA9D291.size + 2));

      if(alias == "") {
        break;
      }

      _id_37BCCD17FEA9D291[_id_37BCCD17FEA9D291.size] = alias;
    }

    if(_id_E37A12D937D7DAD9 == "" && _id_1A7BD761BF8E6AD4 == "" && _id_37BCCD17FEA9D291.size == 0) {
      break;
    }

    if(_id_E37A12D937D7DAD9 == "")
      _id_E37A12D937D7DAD9 = "all";

    if(_id_1A7BD761BF8E6AD4 == "")
      _id_1A7BD761BF8E6AD4 = "all";

    key = bctable_categorykey(_id_E37A12D937D7DAD9, _id_1A7BD761BF8E6AD4);

    if(!isDefined(anim.bctable[category][key]))
      anim.bctable[category][key] = [];

    _id_A61C75B156FC1EE0 = anim.bctable[category][key].size;
    anim.bctable[category][key][_id_A61C75B156FC1EE0] = _id_37BCCD17FEA9D291;
    _id_CB89110314447B2F++;
  }
}

bctable_pickaliasset(category, type, modifier) {
  key = bctable_categorykey(type, modifier);

  if(!bctable_exists(category, type, modifier))
    return undefined;

  if(!isDefined(anim.bctabledeck) || !isDefined(anim.bctabledeck[category]) || !isDefined(anim.bctabledeck[category][key])) {
    anim.bctabledeck[category][key] = [];

    for(index = 0; index < anim.bctable[category][key].size; index++)
      anim.bctabledeck[category][key][index] = index;

    _id_99675918F5AA101D = anim.bctabledeck[category][key].size;

    if(_id_99675918F5AA101D >= 3)
      anim.bctabledeck[category][key] = scripts\engine\utility::array_randomize(anim.bctabledeck[category][key]);

    if(_id_99675918F5AA101D >= 2) {
      if(isDefined(anim.bctablelast) && isDefined(anim.bctablelast[category][key]) && anim.bctablelast[category][key] == anim.bctabledeck[category][key][_id_99675918F5AA101D - 1]) {
        temp = anim.bctabledeck[category][key][0];
        anim.bctabledeck[category][key][0] = anim.bctabledeck[category][key][_id_99675918F5AA101D - 1];
        anim.bctabledeck[category][key][_id_99675918F5AA101D - 1] = temp;
      }
    }
  }

  if(anim.bctabledeck[category][key].size == 0)
    return undefined;

  _id_7F5B77FF7B97AC80 = anim.bctabledeck[category][key].size - 1;
  _id_01065D9A6B1649A1 = anim.bctabledeck[category][key][_id_7F5B77FF7B97AC80];
  result = anim.bctable[category][key][_id_01065D9A6B1649A1];
  anim.bctabledeck[category][key][_id_7F5B77FF7B97AC80] = undefined;

  if(anim.bctabledeck[category][key].size == 0)
    anim.bctabledeck[category][key] = undefined;

  anim.bctablelast[category][key] = _id_01065D9A6B1649A1;
  return result;
}

bctable_exists(category, type, modifier) {
  if(!isDefined(anim.bctable) || !isDefined(anim.bctable[category]))
    return 0;

  key = bctable_categorykey(type, modifier);

  if(!isDefined(anim.bctable[category][key]))
    return 0;

  if(anim.bctable[category][key].size == 0)
    return 0;

  return 1;
}

bctable_categorykey(type, modifier) {
  if(!isDefined(type))
    type = "all";

  if(!isDefined(modifier))
    modifier = "all";

  return tolower(type) + "_" + tolower(modifier);
}