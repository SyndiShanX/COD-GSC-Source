/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\battlechatter_table.gsc
***********************************************/

#using scripts\core_common\array_shared;
#namespace battlechatter_table;

function function_c5dda35e(category, ...) {
  level.bctable[category] = [];

  foreach(filename in vararg) {
    if(isarray(filename)) {
      foreach(file in filename) {
        function_b8e1addf(category, file);
      }

      continue;
    }

    function_b8e1addf(category, filename);
  }
}

function function_b8e1addf(category, filename) {
  for(row = 0; true; row++) {
    tbltype = tablelookupcolumnforrow(filename, row, 0);

    if(!isDefined(tbltype)) {
      return;
    }

    tbltype = tolower(tbltype);
    tblmodifier = tolower(tablelookupcolumnforrow(filename, row, 1));
    var_40b9a488 = tolower(tablelookupcolumnforrow(filename, row, 2));
    var_4ef5dd5c = tolower(tablelookupcolumnforrow(filename, row, 3));
    var_c605de16 = [];

    while(true) {
      alias = tablelookupcolumnforrow(filename, row, var_c605de16.size + 4);

      if(!isDefined(alias) || alias == "") {
        break;
      }

      var_c605de16[var_c605de16.size] = tolower(alias);
    }

    if(tbltype == "" && tblmodifier == "" && var_c605de16.size == 0) {
      break;
    }

    if(tbltype == "") {
      tbltype = "all";
    }

    if(tblmodifier == "") {
      tblmodifier = "all";
    }

    key = categorykey(category, tbltype, tblmodifier);
    level.bctable[category][key] = {
      #probability: float(var_40b9a488), #delay: float(var_4ef5dd5c), #var_df2220dd: var_c605de16
    };
  }
}

function function_4e83ff35(category, type, modifier) {
  key = categorykey(category, type, modifier);

  if(!exists(category, type, modifier)) {
    return 0;
  }

  return level.bctable[category][key].probability;
}

function function_2d2570e3(category, type, modifier) {
  key = categorykey(category, type, modifier);

  if(!exists(category, type, modifier)) {
    return 0;
  }

  return level.bctable[category][key].delay;
}

function function_ac3d3b19(category, type, modifier) {
  key = categorykey(category, type, modifier);

  if(!exists(category, type, modifier)) {
    return undefined;
  }

  return level.bctable[category][key].var_df2220dd;
}

function exists(category, type, modifier) {
  if(!isDefined(level.bctable) || !isDefined(level.bctable[category])) {
    return false;
  }

  key = categorykey(category, type, modifier);

  if(!isstruct(level.bctable[category][key])) {
    return false;
  }

  if(level.bctable[category][key].var_df2220dd.size == 0) {
    return false;
  }

  return true;
}

function private categorykey(category, type = "all", modifier = "all") {
  if(category == "combat") {
    return modifier;
  }

  return tolower("" + type) + "_" + tolower("" + modifier);
}