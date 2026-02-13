/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2067.gsc
*************************************************/

init() {
  level._id_7AB3 = _func_0305();
  _id_D56E(scripts\mp\tweakables::_id_6E14("team", "fftype"));
  _id_3B8D(getDvar("#x315af23e89f368200"));

  for(;;) {
    _id_FD25();
    wait 5;
  }
}

_id_FD25() {
  var_0 = scripts\mp\tweakables::_id_6E14("team", "fftype");

  if(level._id_5FA5 != var_0) {
    _id_D56E(var_0);
  }
}

_id_3B8D(var_0) {
  var_1 = getEntArray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_0 == "dm") {
      if(isDefined(var_3._id_CD6C) && var_3._id_CD6C != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "tdm") {
      if(isDefined(var_3._id_CD70) && var_3._id_CD70 != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "ctf") {
      if(isDefined(var_3._id_CD6B) && var_3._id_CD6B != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "hq") {
      if(isDefined(var_3._id_CD6D) && var_3._id_CD6D != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "sd") {
      if(isDefined(var_3._id_CD6F) && var_3._id_CD6F != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "koth" || var_0 == "kspoint" || var_0 == "mendota") {
      if(isDefined(var_3._id_CD6E) && var_3._id_CD6E != "1") {
        var_3 delete();
      }
    }
  }
}

_id_D56E(var_0) {
  level._id_5FA5 = var_0;
  setDvar("#x3bcc03bfe1a06efd4", var_0);
  setDvar("#x3757315ddd429394c", var_0);
}