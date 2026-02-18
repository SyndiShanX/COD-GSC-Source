/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4a55d8dd1b0d927e.csc
***********************************************/

#using script_4a04e1760d0523d3;
#using script_7222862da5baa189;
#using script_72587ba89a212e22;
#using script_79b2f8ff99dd484;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\laststand;
#using scripts\weapons\listening_device;
#namespace namespace_e51f0bc1;

function init() {
  init_clientfields();
  function_dd83b835();
  callback::on_localclient_connect(&on_localclient_connect);
  dirtybomb_usebar::register(undefined, undefined);
  encodedradio_usebar::register(undefined, undefined);
  level flag::wait_till(#"item_world_reset");
  level.var_34edd2a7 = 1;
  function_b324ff43();
}

function init_clientfields() {
  clientfield::register("missile", "" + # "hash_51901507983013f5", 28000, 1, "int", &function_fd43b4c0, 0, 0);
  clientfield::register("toplayer", "using_bomb", 28000, 1, "int", &function_18272d54, 0, 0);
  clientfield::register("toplayer", "killed_by_client_num", 28000, 4, "int", &function_d4209aa4, 0, 0);
  clientfield::register("toplayer", "killed_by_role", 28000, 2, "int", &function_224355c0, 0, 0);
  clientfield::register("toplayer", "to_player_notification", 28000, 5, "int", &function_cee5c029, 0, 0);
  clientfield::register("world", "wanted_client_num", 28000, 5, "int", &function_1e427c79, 0, 0);
  clientfield::register("world", "bomb_id", 28000, 2, "int", &function_50394a1c, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_732102339886b628", 28000, 1, "int", &function_9d843b2d, 0, 0);
  clientfield::register("missile", "" + # "hash_7850e541b1606b4a", 28000, 1, "int", &function_9d843b2d, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_3b8f220452f1fe4c", 28000, 1, "int", &function_14082bc6, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_3cb0242230f3f716", 28000, 2, "int", &function_d3bf8e92, 0, 0);
  clientfield::register("vehicle", "" + # "hash_508b8b3b9ba62e53", 28000, 1, "int", &function_ca974780, 0, 0);
}

function function_dd83b835() {
  namespace_681edb36::function_dd83b835();
}

function function_b324ff43() {
  callback::add_weapon_type(#"listening_device_spy", &listening_device::function_9eeebbfd);
  mapname = util::get_map_name();

  if(isDefined(mapname)) {
    switch (mapname) {
      case # "mp_tundra":
        level.var_8ddf6d3d.var_151e2c9b = 1100;
        level.var_96492769.var_151e2c9b = 1100;
        break;
      case # "mp_nuketown6":
        level.var_8ddf6d3d.var_151e2c9b = 1000;
        level.var_96492769.var_151e2c9b = 1000;
        break;
      case # "mp_cliffhanger":
        level.var_8ddf6d3d.var_151e2c9b = 900;
        level.var_96492769.var_151e2c9b = 900;
        break;
      case # "mp_apocalypse":
        level.var_8ddf6d3d.var_151e2c9b = 850;
        level.var_96492769.var_151e2c9b = 850;
        break;
      default:
        level.var_8ddf6d3d.var_151e2c9b = 1200;
        level.var_96492769.var_151e2c9b = 1200;
        break;
    }
  }
}

function on_localclient_connect(localclientnum) {
  var_2612e01d = function_1df4c3b0(localclientnum, #"hash_950d3dccba39e08");
  var_1e885680 = getuimodel(var_2612e01d, "count");
  setuimodelvalue(var_1e885680, 4);
}

function function_fd43b4c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self function_c2e69953(1);
    return;
  }

  self function_c2e69953(0);
}

function private function_18272d54(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_53f712e3 = function_604c9983(fieldname, "fly_uranium_priming_lp");
    self thread function_6e9e7ead(fieldname);
    return;
  }

  self notify(#"hash_470a1e2ae77ad9f2");

  if(isDefined(self.var_53f712e3)) {
    function_d48752e(fieldname, self.var_53f712e3);
    self.var_53f712e3 = undefined;
  }
}

function private function_6e9e7ead(localclientnum) {
  if(is_true(self.var_16778c9b)) {
    return;
  }

  self.var_16778c9b = 1;
  self waittill(#"death");
  self.var_16778c9b = 0;

  if(isDefined(self.var_53f712e3)) {
    function_d48752e(localclientnum, self.var_53f712e3);
    self.var_53f712e3 = undefined;
  }
}

function private function_cee5c029(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump != 0) {
    data = self function_fb566490(fieldname, bwastimejump);

    if(isDefined(data)) {
      function_c79ecd60(fieldname, data.text0, data.var_d86d7aad, data.icon0, data.text1, data.var_66b29739, data.icon1, data.text2, data.var_9c7902e5, data.var_7d9f780e, data.text3, data.var_cab95f65);
    }
  }
}

function function_50394a1c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.bomb_id = bwastimejump;
}

function private function_d4209aa4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == -1) {
    return;
  }

  level.var_58624fd1 = bwastimejump;
}

function private function_224355c0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    return;
  }

  level.var_7dfc60c = bwastimejump;
}

function private function_1e427c79(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump > 25) {
    return;
  }

  level.var_f6d9803b = bwasdemojump;
}

function private function_fb566490(local_client_num, notification_id) {
  data = {};
  data.text0 = undefined;
  data.var_d86d7aad = -1;
  data.icon0 = undefined;
  data.text1 = undefined;
  data.var_66b29739 = -1;
  data.icon1 = undefined;
  data.text2 = undefined;
  data.var_9c7902e5 = -1;
  data.var_7d9f780e = undefined;
  data.text3 = undefined;
  data.var_cab95f65 = -1;

  switch (notification_id) {
    case 1:
      data.text0 = # "hash_6659fcbeb05f5fcd";
      break;
    case 2:
      data.text0 = # "hash_3cfae1a933247193";
      break;
    case 3:
      data.text0 = # "hash_9e806c0e4a84941";
      break;
    case 4:
      data.text0 = # "hash_570f97a650d32de8";
      break;
    case 5:
      data.text0 = # "hash_e9642258a6981a1";
      break;
    case 6:
      data.text0 = # "hash_7f1bd561d7dff6f1";
      break;
    case 7:
      data.text0 = # "hash_48031fac2f4e8be6";
      break;
    case 8:
      data.text0 = function_b6937957(#"hash_3763a12e14c36e62", level.bomb_id);
      break;
    case 9:
      data.text0 = function_b6937957(#"hash_76b66f2f20eb5575", level.bomb_id);
      break;
    case 10:
      data.text0 = # "hash_48e294b6d739a396";
      break;
    case 11:
      if(isDefined(level.var_58624fd1) && isDefined(level.var_7dfc60c)) {
        var_3de81fb5 = function_70873aee(local_client_num, level.var_58624fd1);

        if(!isDefined(var_3de81fb5)) {
          data = undefined;
          break;
        }

        data.text0 = # "hash_57a05e18a658b499";
        data.icon1 = # "hash_102615ce832ca8a3" + var_3de81fb5;
        attacker = function_8565908c(local_client_num, level.var_58624fd1);

        if(isDefined(attacker)) {
          data.text2 = attacker getplayername();
        } else if(isDefined(level.deadplayers[level.var_58624fd1])) {
          data.text2 = level.deadplayers[level.var_58624fd1];
        }

        data.var_7d9f780e = function_30f7f6f8(level.var_7dfc60c);
        var_5e8846d4 = self getentitynumber();
        var_c7901c77 = function_f714ed75(local_client_num, var_5e8846d4);
        data.var_66b29739 = function_ce46473d(level.var_7dfc60c, var_c7901c77, 1);
        data.var_9c7902e5 = data.var_66b29739;
      }

      break;
    case 14:
      data.text0 = # "hash_3f1e1e5e0e4d5e12";
      break;
    case 16:
      if(isDefined(level.var_f6d9803b) && level.var_f6d9803b <= 25) {
        data.text0 = # "hash_5bc837648123a58c";
        player = function_8565908c(local_client_num, level.var_f6d9803b);

        if(isDefined(player)) {
          var_4fe888f3 = function_70873aee(local_client_num, level.var_f6d9803b);
          data.icon1 = # "hash_102615ce832ca8a3" + var_4fe888f3;
          data.text2 = player getplayername();
          data.var_9c7902e5 = -1;
        }
      }

      break;
    case 17:
      data.text0 = # "hash_65a5599a49c71133";
      break;
  }

  return data;
}

function private function_b6937957(var_365b725e, bomb_id) {
  string = var_365b725e;
  var_b0173f91 = "A";

  if(isDefined(bomb_id)) {
    switch (bomb_id) {
      case 0:
        var_b0173f91 = "A";
        break;
      case 1:
        var_b0173f91 = "B";
        break;
      case 2:
        var_b0173f91 = "C";
        break;
    }
  }

  string = sprintf(string, var_b0173f91);
  return string;
}

function private function_bb229046(var_d27e5654) {
  switch (var_d27e5654) {
    case 1:
      return # "hash_7c7ec5df89677b85";
    case 2:
      return # "hash_63b124245343a63b";
    case 3:
      return # "hash_7cc89aaafecf74c7";
  }

  return undefined;
}

function private function_8565908c(local_client_num, client_num) {
  players = getplayers(local_client_num);

  foreach(player in players) {
    if(isDefined(player) && player getentitynumber() == client_num) {
      return player;
    }
  }

  return undefined;
}

function private function_70873aee(local_client_num, client_num) {
  var_22f25e2d = function_1df4c3b0(local_client_num, #"spy_global");

  for(index = 0; index < 25; index++) {
    playermodel = getuimodel(var_22f25e2d, hash(isDefined(index) ? "" + index : ""));

    if(isDefined(playermodel)) {
      var_ef8e260c = getuimodel(playermodel, #"clientnum");
      playerclientnum = getuimodelvalue(var_ef8e260c);

      if(playerclientnum == client_num) {
        return index;
      }
    }
  }

  return undefined;
}

function private function_f714ed75(local_client_num, client_num) {
  var_ee6a1fe4 = function_5051595f(local_client_num, client_num);

  if(isDefined(var_ee6a1fe4)) {
    return getuimodelvalue(getuimodel(var_ee6a1fe4, #"spyRole"));
  }

  return 0;
}

function function_5051595f(local_client_num, client_num) {
  var_22f25e2d = function_1df4c3b0(local_client_num, #"spy_global");

  for(index = 0; index < 25; index++) {
    playermodel = getuimodel(var_22f25e2d, hash(isDefined(index) ? "" + index : ""));

    if(isDefined(playermodel)) {
      var_ef8e260c = getuimodel(playermodel, #"clientnum");
      playerclientnum = getuimodelvalue(var_ef8e260c);

      if(playerclientnum == client_num) {
        return playermodel;
      }
    }
  }

  return undefined;
}

function function_8c4ed692(var_d790eb21, var_46c0f051) {
  if(var_d790eb21 == var_46c0f051) {
    return true;
  }

  if(var_d790eb21 != 1 && var_46c0f051 != 1) {
    return true;
  }

  return false;
}

function function_ce46473d(var_668494d8, var_9b867835, var_b98754b) {
  if(!isDefined(var_668494d8) || !isDefined(var_9b867835) || var_668494d8 == 0 || var_9b867835 == 0) {
    return -1;
  }

  var_9d569de1 = function_8c4ed692(var_668494d8, var_9b867835);

  if(var_9d569de1 && var_668494d8 == 1) {
    return 3;
  }

  if(var_9b867835 == 1) {
    return 0;
  }

  if(isDefined(var_b98754b) && var_b98754b == 1) {
    if(var_9d569de1 == 1) {
      return 3;
    } else {
      return 0;
    }
  }

  return -1;
}

function private function_30f7f6f8(var_d27e5654) {
  switch (var_d27e5654) {
    case 1:
      return # "hash_6ba53a7edd3e9e8f";
    case 2:
      return # "hash_30aa21feb2c3d1b1";
    case 3:
      return # "hash_6faacb106ef0ae85";
    default:
      return undefined;
  }
}

function private function_9d843b2d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  level endon(#"game_ended");
  local_player = function_5c10bd79(fieldname);

  if(isDefined(local_player.var_d27e5654)) {
    var_d27e5654 = local_player.var_d27e5654;
  }

  if(bwasdemojump) {
    self flag::set("should_play_render");

    while(isDefined(self) && self flag::get("should_play_render")) {
      if(var_d27e5654 === 1 && !self function_d2503806(#"hash_312ceb838675b80")) {
        self playrenderoverridebundle(#"hash_312ceb838675b80");
        waitframe(1);
        continue;
      }

      waitframe(1);
      continue;
    }

    return;
  }

  self flag::clear("should_play_render");
  self stoprenderoverridebundle(#"hash_312ceb838675b80");
}

function private function_14082bc6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  level endon(#"game_ended");

  if(bwasdemojump) {
    while(isDefined(self)) {
      if(!self function_d2503806(#"hash_312ceb838675b80")) {
        self playrenderoverridebundle(#"hash_312ceb838675b80");
        waitframe(1);
        continue;
      }

      waitframe(1);
    }
  }
}

function private function_d3bf8e92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level endon(#"game_ended");

  if(isDefined(self.var_bdc8969f)) {
    self.var_bdc8969f delete();
  }

  range = undefined;

  if(bwasdemojump == 1) {
    range = 2000;
  } else if(bwasdemojump == 2) {
    range = 1500;
  } else if(bwasdemojump == 3) {
    range = 1000;
  } else {
    return;
  }

  local_player = function_5c10bd79(fieldname);

  if(isDefined(local_player.var_d27e5654)) {
    var_bdc8969f = spawn(fieldname, self.origin, "script_model");
    var_bdc8969f setModel(#"tag_origin");

    if(local_player.var_d27e5654 == 1) {
      var_bdc8969f setcompassicon("ui_icon_minimap_spy_location_circle_friendly");
    } else {
      var_bdc8969f setcompassicon("ui_icon_minimap_spy_location_circle_enemy");
    }

    var_bdc8969f function_5e00861(range, 1);
    self.var_bdc8969f = var_bdc8969f;
  }
}

function private function_ca974780(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self function_811196d1(1);
    return;
  }

  self function_811196d1(0);
}