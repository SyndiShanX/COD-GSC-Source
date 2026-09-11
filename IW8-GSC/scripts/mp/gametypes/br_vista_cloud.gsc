/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_vista_cloud.gsc
***************************************************/

function init() {
  level._effect["storm_cloud"] = loadfx("vfx/iw8_br/gameplay/event/vfx_br_vista_storm");

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  ref_12800();
}

function ref_12800() {
  var_0 = "br_vista_mushroom_cloud";
  var_1 = "vista_mushroom";
  var_2 = "vista_vfx";
  var_3 = getdvarint("scr_br_vista_mushroom_cloud", 0);
  atv_trail(var_0, var_1, var_2, var_3);
  var_4 = getdvarint("scr_br_vista_storm_cloud", 0);

  if(istrue(var_4) && level._effect["storm_cloud"] != 0 && !isDefined(level.ref_138fa)) {
    level.ref_138fa = spawnfx(level._effect["storm_cloud"], (95588, -136838, 12687), anglesToForward((0, 131.247, 0)), anglestoup((0, 131.247, 0)));
    level.ref_138fa unmarkkeyframedmover(1);
    triggerfx(level.ref_138fa);
    return;
  }

  if(!istrue(var_4) && isDefined(level.ref_138fa)) {
    level.ref_138fa delete();
    return;
  }
}

function atv_trail(var_0, var_1, var_2, var_3) {
  var_4 = rungwperif_planes(var_0, var_1);

  if(isDefined(var_4)) {
    if(istrue(var_3)) {
      ref_131be(var_4, var_2, 1);
      return;
    }

    ref_131be(var_4, var_2, 0);
    return;
  }
}

function ref_131be(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    var_0 setscriptablepartstate(var_1, "visible");
    return;
  }

  var_0 setscriptablepartstate(var_1, "hidden");
}

function rungwperif_planes(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius(var_1, "targetname");

  if(var_2.size == 0) {
    return;
  }

  foreach(var_4 in var_2) {
    if(var_4.type == var_0) {
      return var_4;
    }
  }
}