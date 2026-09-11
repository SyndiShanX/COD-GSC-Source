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
  var0 = "br_vista_mushroom_cloud";
  var1 = "vista_mushroom";
  var2 = "vista_vfx";
  var3 = getdvarint("scr_br_vista_mushroom_cloud", 0);
  atv_trail(var0, var1, var2, var3);
  var4 = getdvarint("scr_br_vista_storm_cloud", 0);

  if(istrue(var4) && level._effect["storm_cloud"] != 0 && !isDefined(level.ref_138fa)) {
    level.ref_138fa = spawnfx(level._effect["storm_cloud"], (95588, -136838, 12687), anglesToForward((0, 131.247, 0)), anglestoup((0, 131.247, 0)));
    level.ref_138fa unmarkkeyframedmover(1);
    triggerfx(level.ref_138fa);
    return;
  }

  if(!istrue(var4) && isDefined(level.ref_138fa)) {
    level.ref_138fa delete();
    return;
  }
}

function atv_trail(var0, var1, var2, var3) {
  var4 = rungwperif_planes(var0, var1);

  if(isDefined(var4)) {
    if(istrue(var3)) {
      ref_131be(var4, var2, 1);
      return;
    }

    ref_131be(var4, var2, 0);
    return;
  }
}

function ref_131be(var0, var1, var2) {
  if(istrue(var2)) {
    var0 setscriptablepartstate(var1, "visible");
    return;
  }

  var0 setscriptablepartstate(var1, "hidden");
}

function rungwperif_planes(var0, var1) {
  var2 = getentitylessscriptablearrayinradius(var1, "targetname");

  if(var2.size == 0) {
    return;
  }

  foreach(var4 in var2) {
    if(var4.type == var0) {
      return var4;
    }
  }
}