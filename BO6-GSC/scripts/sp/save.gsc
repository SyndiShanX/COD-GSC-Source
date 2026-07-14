/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\save.gsc
**************************************/

#using scripts\engine\utility;
#namespace save;

function private autoexec init() {
  if(!isDefined(world.loadout)) {
    world.loadout = [];
  }

  if(!isDefined(world.mapdata)) {
    world.mapdata = [];
  }

  if(!isDefined(world.playerdata)) {
    world.playerdata = [];
  }

  missionid = function_cdb126c98f2e8e79();

  if(!isDefined(world.mapdata[missionid][#"persistent"])) {
    world.mapdata[missionid][#"persistent"] = spawnStruct();
  }

  if(!isDefined(world.mapdata[missionid][#"transient"])) {
    world.mapdata[missionid][#"transient"] = spawnStruct();
  }

  var_e4db86ccfe66d7ad = getDvar(@ "hash_814341cb86787cf9", "");

  if(!isDefined(var_e4db86ccfe66d7ad) || var_e4db86ccfe66d7ad.size == 0 || var_e4db86ccfe66d7ad === level.mapbundle.startpoint) {
    function_d95a7f9d141b45cd(#"transient");
  }

  utility::registersharedfunc(#"save", #"set_player_data", &function_2be49230a9e6f761);
  utility::registersharedfunc(#"save", #"hash_216b53601f207a16", &function_1d3508467f5df46d);
  utility::registersharedfunc(#"save", #"hash_53c18e205c9f9e5e", &function_8f269b6bf1f57f53);
}

function clear_all() {
  level.var_3bcfb8b91ea39072 = 1;
  function_8f269b6bf1f57f53();
  function_90af0e7a555370b2();
  init();
}

function function_cdb126c98f2e8e79() {
  var_bcaf510693478f81 = function_3070708ca54c9ed7();

  if(isDefined(var_bcaf510693478f81)) {
    return var_bcaf510693478f81;
  }

  return getxhashasset(getDvar(@ "g_mapname", ""));
}

function function_37f09add1d5aaa86(dataname = undefined, missionname = undefined) {
  if(!isDefined(dataname)) {
    dataname = #"transient";
  }

  if(!isDefined(missionname)) {
    missionname = function_cdb126c98f2e8e79();
  }

  if(!isxhashasset(missionname)) {
    missionname = getxhashasset(missionname);
  }

  if(!isDefined(world.mapdata)) {
    world.mapdata = [];
  }

  if(!isDefined(world.mapdata[missionname])) {
    world.mapdata[missionname] = [];
  }

  if(!isDefined(world.mapdata[missionname][dataname])) {
    world.mapdata[missionname][dataname] = spawnStruct();
  }

  return world.mapdata[missionname][dataname];
}

function function_d95a7f9d141b45cd(dataname = undefined, missionname = undefined) {
  if(!isDefined(dataname)) {
    dataname = #"transient";
  }

  if(!isDefined(missionname)) {
    missionname = function_cdb126c98f2e8e79();
  }

  if(!isxhashasset(missionname)) {
    missionname = getxhashasset(missionname);
  }

  if(isDefined(world.mapdata) && isDefined(world.mapdata[missionname])) {
    if(isDefined(dataname)) {
      if(isDefined(world.mapdata[missionname][dataname])) {
        world.mapdata[missionname][dataname] = spawnStruct();
      }

      return;
    }

    foreach(dataname, value in world.mapdata[missionname]) {
      world.mapdata[missionname][dataname] = spawnStruct();
    }
  }
}

function function_90af0e7a555370b2() {
  world.mapdata = [];
}

function function_ad371fc394563bb8() {
  missionname = function_cdb126c98f2e8e79();
  level.var_310e8088c7e90a13 = [];

  if(isDefined(world.mapdata[missionname])) {
    foreach(dataname, value in world.mapdata[missionname]) {
      level.var_310e8088c7e90a13[dataname] = structcopy(world.mapdata[missionname][dataname], 1);
    }
  }
}

function function_65a2f01120465563() {
  missionname = function_cdb126c98f2e8e79();

  if(isDefined(level.var_310e8088c7e90a13)) {
    foreach(dataname, value in level.var_310e8088c7e90a13) {
      world.mapdata[missionname][dataname] = structcopy(level.var_310e8088c7e90a13[dataname], 1);
    }
  }
}

function function_2be49230a9e6f761(name, value) {
  campaignmode = "Y\xc1";

  if(!isDefined(world.playerdata)) {
    world.playerdata = [];
  }

  if(!isDefined(world.playerdata[campaignmode])) {
    world.playerdata[campaignmode] = [];
  }

  world.playerdata[campaignmode][name] = value;
}

function function_1d3508467f5df46d(name, defval) {
  campaignmode = "Y\xc1";

  if(isDefined(world.playerdata[campaignmode][name])) {
    return world.playerdata[campaignmode][name];
  }

  return defval;
}

function function_8f269b6bf1f57f53() {
  campaignmode = "Y\xc1";

  if(isDefined(world.playerdata) && isDefined(world.playerdata[campaignmode])) {
    world.playerdata[campaignmode] = [];
  }
}