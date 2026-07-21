/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_vista_cloud.gsc
***********************************************/

init() {
  level._effect["_encstr_AD060C6B086AE8E597F13890ADCA"] = loadfx("_encstr_97A32D673387794BDD83EB3139BC3BC2B656C11B58BCBCCAB32B37A3BC9DCC3C7D2693FA9D5ACDE8B0D7B9E8BD936B");

  if(!scripts\mp\flags::levelflag("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  _id_12800();
}

_id_12800() {
  var_0 = "_encstr_A1AA18A605E7A358A65BC617091F43707D783F5F77C681FF95C9";
  var_1 = "_encstr_86D50F8B1C3BE8FFA1EF8B8FD35B30E8CD";
  var_2 = "_encstr_99920A34543BE1295F23C028";
  var_3 = getdvarint("_encstr_A5AC1C9BC196CF2E287FBEB93F40B687B1BB13B20BE0D725696FACB71B28", 0);
  atv_trail(var_0, var_1, var_2, var_3);
  var_4 = getdvarint("_encstr_9331194B1146FF1E182FEEC94F10E6B76E6B0223B888B7551893F4", 0);

  if(istrue(var_4) && level._effect["_encstr_AD060C6B086AE8E597F13890ADCA"] != 0 && !isDefined(level._id_138FA)) {
    level._id_138FA = spawnfx(level._effect["_encstr_AD060C6B086AE8E597F13890ADCA"], (95588, -136838, 12687), anglesToForward((0, 131.247, 0)), anglestoup((0, 131.247, 0)));
    level._id_138FA unmarkkeyframedmover(1);
    triggerfx(level._id_138FA);
  } else if(!istrue(var_4) && isDefined(level._id_138FA))
    level._id_138FA delete();
}

atv_trail(var_0, var_1, var_2, var_3) {
  var_4 = rungwperif_planes(var_0, var_1);

  if(isDefined(var_4)) {
    if(istrue(var_3))
      _id_131BE(var_4, var_2, 1);
    else
      _id_131BE(var_4, var_2, 0);
  }
}

_id_131BE(var_0, var_1, var_2) {
  if(istrue(var_2))
    var_0 setscriptablepartstate(var_1, "_encstr_BE8B08E323FB2BCD6268");
  else
    var_0 setscriptablepartstate(var_1, "_encstr_95DF070DD22319CA9B");
}

rungwperif_planes(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_2.size == 0) {
    return;
  }
  foreach(var_4 in var_2) {
    if(var_4.type == var_0)
      return var_4;
  }

  return;
}