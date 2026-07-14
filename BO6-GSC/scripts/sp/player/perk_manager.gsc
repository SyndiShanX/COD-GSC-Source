/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\perk_manager.gsc
**********************************************/

#using scripts\common\system;
#using scripts\engine\utility;
#namespace perk_manager;

function private autoexec __init__system__() {
  system::register(#"perk_manager", undefined, &pre_main, undefined);
}

function player_init() {
  assert(isPlayer(self));
  player = self;
  perksactive = [];

  if(isDefined(level.perk_manager)) {
    foreach(perkslot in level.perk_manager.perkslots) {
      perkindex = level.player getplayerprogression("\x1d\x14\x17\xfdQ\xbb@\xf0\\'", perkslot);

      if(isDefined(perkindex) && perkindex > 0 && perkindex <= level.perk_manager.maxindex) {
        perksactive[perksactive.size] = perkindex;
      }
    }
  }

  player player_set(perksactive);
}

function function_44fc97316ed81e7(perkname, setfunc, unsetfunc, initfunc) {
  function_fee58cef825dd8c3(perkname, 1, setfunc, unsetfunc, initfunc);
}

function function_dba42d77c0bae3cd(perkname, setfunc, unsetfunc, initfunc) {
  function_fee58cef825dd8c3(perkname, 0, setfunc, unsetfunc, initfunc);
}

function private pre_main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  if(!isDefined(level.player)) {
    level.player = getEntArray("K_p\x84a\x01", #classname)[0];
  }

  if(!isDefined(level.perk_manager)) {
    level.perk_manager = spawnStruct();
    level.perk_manager.maxindex = -1;
    level.perk_manager.perkslots = [];

    if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.perk_list)) {
      str_list = level.gametypebundle.perk_list ?? level.gamemodebundle.perk_list;
      perklist = getscriptbundle("M\xb3\xc2w\xee/Q,\xb6" + str_list);

      if(isDefined(perklist)) {
        level.perk_manager.perks = [];

        level.perk_manager.perks_index = [];

        level thread function_42b22b8c8b67c49d();

        foreach(index, var_6f9ec424fac32b3d in perklist.perk_list) {
          if(isDefined(var_6f9ec424fac32b3d.ref) && isDefined(var_6f9ec424fac32b3d.bundle)) {
            function_df76ca64d2ae83ae(var_6f9ec424fac32b3d);
            level.perk_manager.perks[index] = var_6f9ec424fac32b3d.ref;
            level.perk_manager.maxindex = index;

            level.perk_manager.perks_index[var_6f9ec424fac32b3d.ref] = index;
          }
        }
      }
    }
  }

  level function_7afecf13c07f1252();

  level.player utility::delaythread(0.05, &player_init);
}

function private player_set(perksarray) {
  assert(isPlayer(self));
  player = self;

  if(isDefined(player.active_perks)) {
    foreach(perkname in player.active_perks) {
      var_eab6fa698a77574d = 1;
      callbackdata = function_da3105b36bc7992a(perkname);

      if(isDefined(callbackdata)) {
        var_eab6fa698a77574d = istrue(callbackdata.var_eab6fa698a77574d);

        if(isDefined(callbackdata.unsetfunc)) {
          player thread[[callbackdata.unsetfunc]]();
        }
      }

      player unsetperk(perkname, var_eab6fa698a77574d);
    }
  }

  player.active_perks = [];

  foreach(perkindex in perksarray) {
    perkname = level.perk_manager.perks[perkindex];
    player.active_perks[player.active_perks.size] = perkname;
    var_eab6fa698a77574d = 1;
    callbackdata = function_da3105b36bc7992a(perkname);

    if(isDefined(callbackdata)) {
      var_eab6fa698a77574d = istrue(callbackdata.var_eab6fa698a77574d);

      if(isDefined(callbackdata.setfunc)) {
        player thread[[callbackdata.setfunc]]();
      }
    }

    player setperk(perkname, var_eab6fa698a77574d);
  }

  player thread function_7134d6ced4dae6f3();
}

function private function_da3105b36bc7992a(perkname) {
  callbackdata = level.perk_manager.perkcallbacks[perkname];
  return callbackdata;
}

function private function_fee58cef825dd8c3(perkname, var_eab6fa698a77574d, setfunc, unsetfunc, initfunc) {
  assert(isDefined(perkname));
  assert(isDefined(var_eab6fa698a77574d));

  if(isDefined(setfunc)) {
    assert(isfunction(setfunc));
  }

  if(isDefined(unsetfunc)) {
    assert(isfunction(unsetfunc));
  }

  if(isDefined(initfunc)) {
    assert(isfunction(initfunc));
    self[[initfunc]]();
  }

  assert(isDefined(level.perk_manager));

  if(!isDefined(level.perk_manager.perkcallbacks)) {
    level.perk_manager.perkcallbacks = [];
  }

  assert(!isDefined(level.perk_manager.perkcallbacks[perkname]), "<dev string:x24>" + perkname + "<dev string:x3c>");
  callbackdata = spawnStruct();
  callbackdata.var_eab6fa698a77574d = var_eab6fa698a77574d;
  callbackdata.setfunc = setfunc;
  callbackdata.unsetfunc = unsetfunc;
  level.perk_manager.perkcallbacks[perkname] = callbackdata;
}

function private function_df76ca64d2ae83ae(var_6f9ec424fac32b3d) {
  perk = getscriptbundle(var_6f9ec424fac32b3d.bundle);

  if(isDefined(perk)) {
    slotname = perk.slottype;

    if(isDefined(slotname)) {
      thread function_92b087a8fd4e1622(var_6f9ec424fac32b3d, slotname);

      level.perk_manager.perkslots[slotname] = slotname;

      level.perk_manager.perkassetref[var_6f9ec424fac32b3d.bundle] = var_6f9ec424fac32b3d.ref;
    }
  }
}

function private function_92b087a8fd4e1622(var_6f9ec424fac32b3d, slotname) {
  if(isDefined(slotname)) {
    dvarname = "<dev string:x55>" + slotname;
    dvarhash = hashcat(@ "hash_beefdd8182d9100", slotname);
    setdvarifuninitialized(dvarhash, "<dev string:x68>");
    level waittill("<dev string:x6c>");

    if(!isDefined(level.perk_manager.var_3b0ae5b7160dabc0)) {
      level.perk_manager.var_3b0ae5b7160dabc0 = [];
    }

    if(!isDefined(level.perk_manager.var_3b0ae5b7160dabc0[slotname])) {
      cmd = "<dev string:x87>" + slotname + "<dev string:xa3>" + dvarname + "<dev string:xb3>";
      adddebugcommand(cmd);
      level.perk_manager.var_3b0ae5b7160dabc0[slotname] = 1;
    }

    cmd = "<dev string:x87>" + slotname + "<dev string:xbe>" + var_6f9ec424fac32b3d.ref + "<dev string:xc3>" + dvarname + "<dev string:xce>" + var_6f9ec424fac32b3d.ref + "<dev string:xd3>";
    adddebugcommand(cmd);
    level thread function_b980be416c548d73(slotname, dvarname, dvarhash);
  }
}

function private function_42b22b8c8b67c49d() {
  wait 1;
  setdvarifuninitialized(@ "hash_e73a18b1dfc9e66d", "<dev string:xd9>");
  setdvarifuninitialized(@ "hash_3972e840eba26779", "<dev string:xd9>");
  cmd = "<dev string:xde>";
  adddebugcommand(cmd);
  cmd = "<dev string:x126>";
  adddebugcommand(cmd);
  cmd = "<dev string:x168>";
  adddebugcommand(cmd);
  level thread function_b980be416c548d73("<dev string:x1aa>", "<dev string:x1b3>", @ "hash_e73a18b1dfc9e66d");
  level thread function_b980be416c548d73("<dev string:x1cb>", "<dev string:x1d3>", @ "hash_3972e840eba26779");
  level notify("<dev string:x6c>");
}

function private function_b980be416c548d73(slotname, dvarname, dvarhash) {
  self notify("<dev string:x1ea>" + slotname);
  self endon("<dev string:x1ea>" + slotname);
  waittillframeend();
  lastdvarval = "<dev string:x68>";

  while(true) {
    curdvarval = getDvar(dvarhash, "<dev string:x68>");

    if(curdvarval != lastdvarval) {
      if(slotname == "<dev string:x1aa>") {
        if(int(curdvarval)) {
          function_4f77d4159192c245();
          setDvar(dvarhash, 0);
          curdvarval = getDvar(dvarhash, "<dev string:x68>");
        }
      } else if(slotname == "<dev string:x1cb>") {} else {
        perkindex = level.perk_manager.perks_index[curdvarval];

        if(isDefined(perkindex)) {
          level.player setplayerprogression("<dev string:x204>", slotname, perkindex);
        } else {
          level.player setplayerprogression("<dev string:x204>", slotname, 0);
        }
      }

      level.player thread player_init();
    }

    lastdvarval = curdvarval;
    wait 1;
  }
}

function private function_34ca79bd65b0b950(perkassethash) {
  specialty = level.perk_manager.perkassetref[perkassethash];
  perk = getscriptbundle(perkassethash);

  if(isDefined(perk) && isDefined(specialty) && isint(level.perk_manager.perks_index[specialty])) {
    level.player setplayerprogression("<dev string:x204>", perk.slottype, level.perk_manager.perks_index[specialty]);
  }
}

function function_4f77d4159192c245() {
  if(!isDefined(level.perk_manager.perkassetref)) {
    return;
  }

  foreach(specialty in level.perk_manager.perkassetref) {
    perk = getscriptbundle(perkassethash);

    if(!isDefined(perk)) {
      continue;
    }

    level.player setplayerprogression("<dev string:x204>", perk.slottype, 0);
  }
}

function function_7afecf13c07f1252(devconfig, force) {
  if(!function_c0ce26d439bc989f() && !istrue(force)) {
    return;
  }

  if(isstring(devconfig)) {
    devconfig = getscriptbundle("<dev string:x212>" + devconfig);
  } else if(isxhashasset(devconfig)) {
    devconfig = getscriptbundle(devconfig);
  }

  if(!isstruct(devconfig)) {
    mapinfo = function_cbe75068ad1ba418();

    if(isDefined(mapinfo.devconfig) && mapinfo.devconfig != % "") {
      devconfig = getscriptbundle(mapinfo.devconfig);
    }
  }

  if(isstruct(devconfig)) {
    function_4f77d4159192c245();

    if(isDefined(devconfig.var_d48dcfd84dce5f55)) {
      foreach(perk in devconfig.var_d48dcfd84dce5f55) {
        function_34ca79bd65b0b950(perk.perk);
      }
    }

    if(isDefined(devconfig.perksrandom)) {
      foreach(randompool in devconfig.perksrandom) {
        pool = utility::array_randomize(arraycopy(randompool.perksrandom));

        for(count = 0; count < (randompool.perksrandomcount ?? 0) && count < pool.size; count++) {
          function_34ca79bd65b0b950(pool[count].perk);
        }
      }
    }

    if(isDefined(devconfig.resources)) {
      foreach(resource in devconfig.resources) {
        amount = level.player getplayerprogression("<dev string:x228>", resource.resource);
        amount = max(amount, resource.amount);
        level.player setplayerprogression("<dev string:x228>", resource.resource, int(amount));
      }
    }
  }
}

function private function_7134d6ced4dae6f3(clear) {
  self notify("\xb5\x8e<f\xb6\xa4'\xff\x9a\xfb\xf7n\x8b\xe5\xee\xbc");
  self endon("\xb5\x8e<f\xb6\xa4'\xff\x9a\xfb\xf7n\x8b\xe5\xee\xbc");

  if(isDefined(self.var_9e73358103cfdbf6)) {
    foreach(hudelem in self.var_9e73358103cfdbf6) {
      hudelem destroy();
    }
  }

  self.var_9e73358103cfdbf6 = [];

  if(istrue(clear) || !getdvarint(@ "hash_3972e840eba26779", 0)) {
    return;
  }

  y = 0;

  if(isDefined(self.active_perks)) {
    foreach(perk in self.active_perks) {
      hudelem = newhudelem();
      hudelem.alignx = "<dev string:x234>";
      hudelem.x = 5;
      hudelem.y = 280 + y;
      hudelem.fontscale = 1;
      hudelem.color = (0.6, 0.6, 0.6);
      hudelem.horzalign = "<dev string:x23c>";
      hudelem.vertalign = "<dev string:x23c>";
      hudelem setdevtext(perk);
      self.var_9e73358103cfdbf6[self.var_9e73358103cfdbf6.size] = hudelem;
      y -= 10;
    }
  }

  wait 10;
  thread function_7134d6ced4dae6f3(1);
}

# /