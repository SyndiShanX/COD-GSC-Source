/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_table.gsc
************************************************/

#using scripts\engine\utility;
#namespace battlechatter_table;

function bctable_setfiles(category, filename1, filename2, filename3, filename4, filename5, filename6) {
  anim.bctable[category] = [];

  if(isDefined(anim.bctabledeck)) {
    anim.bctabledeck[category] = undefined;
  }

  if(isDefined(anim.bctablelast)) {
    anim.bctablelast[category] = undefined;
  }

  if(isDefined(filename1)) {
    bctable_addfile(category, filename1);
  }

  if(isDefined(filename2)) {
    bctable_addfile(category, filename2);
  }

  if(isDefined(filename3)) {
    bctable_addfile(category, filename3);
  }

  if(isDefined(filename4)) {
    bctable_addfile(category, filename4);
  }

  if(isDefined(filename5)) {
    bctable_addfile(category, filename5);
  }

  if(isDefined(filename6)) {
    bctable_addfile(category, filename6);
  }
}

function bctable_addfile(category, filename) {
  for(row = 0; true; row++) {
    tbltype = tolower(tablelookupbyrow(filename, row, 0));
    tblmodifier = tolower(tablelookupbyrow(filename, row, 1));
    var_834052d8ee898ca0 = [];

    while(true) {
      alias = tolower(tablelookupbyrow(filename, row, var_834052d8ee898ca0.size + 2));

      if(alias == "") {
        break;
      }

      var_834052d8ee898ca0[var_834052d8ee898ca0.size] = alias;
    }

    if(tbltype == "" && tblmodifier == "" && var_834052d8ee898ca0.size == 0) {
      break;
    }

    if(tbltype == "") {
      tbltype = "\xc0\xc6J";
    }

    if(tblmodifier == "") {
      tblmodifier = "\xc0\xc6J";
    }

    key = bctable_categorykey(tbltype, tblmodifier);

    if(!isDefined(anim.bctable[category][key])) {
      anim.bctable[category][key] = [];
    }

    size = anim.bctable[category][key].size;
    anim.bctable[category][key][size] = var_834052d8ee898ca0;
  }
}

function bctable_pickaliasset(category, type, modifier) {
  key = bctable_categorykey(type, modifier);

  if(!bctable_exists(category, type, modifier)) {
    println("<dev string:x24>" + modifier);
    return undefined;
  }

  if(!(isDefined(anim.bctabledeck[category]) && isDefined(anim.bctabledeck) && isDefined(anim.bctabledeck[category][key]))) {
    anim.bctabledeck[category][key] = [];

    for(index = 0; index < anim.bctable[category][key].size; index++) {
      anim.bctabledeck[category][key][index] = index;
    }

    decksize = anim.bctabledeck[category][key].size;

    if(decksize >= 3) {
      anim.bctabledeck[category][key] = utility::array_randomize(anim.bctabledeck[category][key]);
    }

    if(decksize >= 2) {
      if(isDefined(anim.bctablelast) && isDefined(anim.bctablelast[category][key]) && anim.bctablelast[category][key] == anim.bctabledeck[category][key][decksize - 1]) {
        temp = anim.bctabledeck[category][key][0];
        anim.bctabledeck[category][key][0] = anim.bctabledeck[category][key][decksize - 1];
        anim.bctabledeck[category][key][decksize - 1] = temp;
      }
    }
  }

  if(anim.bctabledeck[category][key].size == 0) {
    return undefined;
  }

  deckindex = anim.bctabledeck[category][key].size - 1;
  tableindex = anim.bctabledeck[category][key][deckindex];
  result = anim.bctable[category][key][tableindex];
  assert(isDefined(result));
  anim.bctabledeck[category][key][deckindex] = undefined;

  if(anim.bctabledeck[category][key].size == 0) {
    anim.bctabledeck[category][key] = undefined;
  }

  anim.bctablelast[category][key] = tableindex;
  return result;
}

function bctable_exists(category, type, modifier) {
  if(!(isDefined(anim.bctable) && isDefined(anim.bctable[category]))) {
    return false;
  }

  key = bctable_categorykey(type, modifier);

  if(!isDefined(anim.bctable[category][key])) {
    return false;
  }

  if(anim.bctable[category][key].size == 0) {
    return false;
  }

  return true;
}

function bctable_categorykey(type, modifier) {
  if(!isDefined(type)) {
    type = "\xc0\xc6J";
  }

  if(!isDefined(modifier)) {
    modifier = "\xc0\xc6J";
  }

  return tolower(type) + "w" + tolower(modifier);
}