/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\outline.gsc
***********************************************/

#using script_2342b8aad723994e;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\outline;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\join_team_aggregator;
#namespace outline;

function init() {
  level.outlineids = 0;
  level.outlineents = [];
  level.outlineidspending = [];
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&outlineonplayerdisconnect);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&outlineonplayerjoinedteam);
  namespace_c31609f90efcf2ca::registeronplayerjoinsquadcallback(&outlineonplayerjoinedsquad);
  level thread outlineidswatchpending();
}

function outlineenableinternal(var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, type, var_fa3b23d51c2dc7, squadindex) {
  assertex(type != "<dev string:x1c>" || isDefined(var_fa3b23d51c2dc7), "<dev string:x24>");
  assertex(type != "<dev string:x77>" || isDefined(var_fa3b23d51c2dc7) && isDefined(squadindex), "<dev string:x80>");

  if(!isDefined(var_f20913fec7561c5f.outlines)) {
    var_f20913fec7561c5f.outlines = [];
  }

  oinfo = spawnStruct();
  oinfo.isdisabled = 0;
  oinfo.priority = outlineprioritygroupmap(prioritygroup);
  oinfo.playersvisibleto = playersvisibleto;
  oinfo.playersvisibletopending = [];
  oinfo.hudoutlineassetname = hudoutlineassetname;
  oinfo.type = type;
  oinfo.team = var_fa3b23d51c2dc7;
  oinfo.sessionsquadid = squadindex;
  id = outlinegenerateuniqueid();
  var_f20913fec7561c5f.outlines[id] = oinfo;
  outlineaddtogloballist(var_f20913fec7561c5f);
  var_cda6602a02c53ba3 = [];

  foreach(player in oinfo.playersvisibleto) {
    if(!canoutlineforplayer(player)) {
      oinfo.playersvisibletopending[oinfo.playersvisibletopending.size] = player;
      level.outlineidspending[id] = var_f20913fec7561c5f;
      continue;
    }

    var_25a840a406e8542a = outlinegethighestinfoforplayer(var_f20913fec7561c5f, player);

    if(!isDefined(var_25a840a406e8542a) || var_25a840a406e8542a == oinfo || var_25a840a406e8542a.priority == oinfo.priority) {
      var_cda6602a02c53ba3[var_cda6602a02c53ba3.size] = player;
    }
  }

  if(var_cda6602a02c53ba3.size > 0) {
    if(scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
      var_f20913fec7561c5f function_3430d5003d0cc9f(var_cda6602a02c53ba3, prioritygroup);
    } else {
      var_f20913fec7561c5f _hudoutlineenableforclients(var_cda6602a02c53ba3, oinfo.hudoutlineassetname);
    }
  }

  return id;
}

function outlinedisableinternal(id, var_420a996e67989dc4) {
  if(!isDefined(var_420a996e67989dc4)) {
    level.outlineents = array_removeundefined(level.outlineents);
    return;
  } else if(!isDefined(var_420a996e67989dc4.outlines)) {
    outlineremovefromgloballist(var_420a996e67989dc4);
    return;
  }

  var_77c349ecef6fb0d9 = var_420a996e67989dc4.outlines[id];

  if(!isDefined(var_77c349ecef6fb0d9) || var_77c349ecef6fb0d9.isdisabled) {
    return;
  }

  var_77c349ecef6fb0d9.isdisabled = 1;

  foreach(player in var_77c349ecef6fb0d9.playersvisibleto) {
    if(!isDefined(player)) {
      continue;
    }

    if(!canoutlineforplayer(player)) {
      var_77c349ecef6fb0d9.playersvisibletopending[var_77c349ecef6fb0d9.playersvisibletopending.size] = player;
      level.outlineidspending[id] = var_420a996e67989dc4;
      continue;
    }

    var_25a840a406e8542a = outlinegethighestinfoforplayer(var_420a996e67989dc4, player);

    if(isDefined(var_25a840a406e8542a)) {
      if(var_25a840a406e8542a.priority <= var_77c349ecef6fb0d9.priority) {
        var_420a996e67989dc4 _hudoutlineenableforclient(player, var_25a840a406e8542a.hudoutlineassetname);
      }

      continue;
    }

    if(scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
      var_420a996e67989dc4 scripts\mp\outline::function_32dfa50c47325abe(player, "equipment", 1);
      continue;
    }

    var_420a996e67989dc4 hudoutlinedisableforclient(player);
  }

  if(var_77c349ecef6fb0d9.playersvisibletopending.size == 0) {
    var_420a996e67989dc4.outlines[id] = undefined;

    if(var_420a996e67989dc4.outlines.size == 0) {
      outlineremovefromgloballist(var_420a996e67989dc4);
    }
  }
}

function hudoutline_channels_init() {
  self.hudoutlinechannels = [];
  self.var_2876398bde7a4cf4 = "outline_depth_white";
  hudoutline_add_channel_internal("default", 0, self.var_2876398bde7a4cf4);
}

function hudoutline_add_channel_internal(channelname, priority, outlineasset) {
  if(!isDefined(self.hudoutlinechannels)) {
    scripts\mp\outline::hudoutline_channels_init();
  }

  if(function_bf76e3eaccf13673(self.hudoutlinechannels, channelname) == -1) {
    channelsize = self.hudoutlinechannels.size;
    index = ter_op(channelsize > 0, channelsize, 0);

    for(i = 0; i < channelsize; i++) {
      if(self.hudoutlinechannels[i].channelpriority >= priority) {
        index = i;
        break;
      }
    }

    channelstruct = spawnStruct();
    channelstruct.channelname = channelname;
    channelstruct.channelpriority = priority;
    channelstruct.outlineasset = outlineasset;
    channelstruct.var_41272a9c461e0853 = [];
    self.hudoutlinechannels = array_insert(self.hudoutlinechannels, channelstruct, index);
  }
}

function hudoutline_enable_internal(viewer, channelname, hudoutlineasset) {
  if(!isDefined(channelname)) {
    channelname = "default";
  }

  if(!isDefined(self.hudoutlinechannels)) {
    hudoutline_channels_init();
  }

  channelindex = function_bf76e3eaccf13673(self.hudoutlinechannels, channelname);

  if(channelindex == -1) {
    if(!isDefined(hudoutlineasset)) {
      hudoutlineasset = self.var_2876398bde7a4cf4;
    }

    hudoutline_add_channel_internal(channelname, self.hudoutlinechannels[0].channelpriority - 1, hudoutlineasset);
    channelindex = function_bf76e3eaccf13673(self.hudoutlinechannels, channelname);
  }

  if(channelname != "default" && isDefined(hudoutlineasset) && self.hudoutlinechannels[channelindex].outlineasset != hudoutlineasset && function_370c25acb4da9fe9(channelname, self)) {
    self.hudoutlinechannels[channelindex].outlineasset = hudoutlineasset;
    function_a2d9562a736f54e3(channelname, self, hudoutlineasset);
  }

  if(!isDefined(self.hudoutlinecurchannel)) {
    hudoutline_activate_channel(channelname, viewer);
  }

  var_a948959983e82f10 = self.hudoutlinecurchannel.channelpriority;
  var_c8446d6318008d2c = self.hudoutlinechannels[channelindex].channelpriority;

  if(!array_contains(self.hudoutlinechannels[channelindex].var_41272a9c461e0853, viewer)) {
    self.hudoutlinechannels[channelindex].var_41272a9c461e0853 = array_add(self.hudoutlinechannels[channelindex].var_41272a9c461e0853, viewer);
  }

  if(self.hudoutlinecurchannel.channelname != channelname && var_a948959983e82f10 < var_c8446d6318008d2c) {
    hudoutline_activate_channel(channelname, viewer);
    return;
  }

  if(self.hudoutlinecurchannel.channelname == channelname) {
    function_f980012fc1b73aee(self, channelname, viewer);
    return;
  }

  if(self.hudoutlinecurchannel.channelname != channelname && var_a948959983e82f10 > var_c8446d6318008d2c && !array_contains(self.hudoutlinecurchannel.var_41272a9c461e0853, viewer)) {
    hudoutline_activate_channel(channelname, viewer);
  }
}

function function_bf76e3eaccf13673(var_a531b6ffdacf9ab5, channelname) {
  for(i = 0; i < var_a531b6ffdacf9ab5.size; i++) {
    if(var_a531b6ffdacf9ab5[i].channelname == channelname) {
      return i;
    }
  }

  return -1;
}

function function_370c25acb4da9fe9(channelname, ent) {
  channelindex = function_bf76e3eaccf13673(self.hudoutlinechannels, channelname);

  if(channelindex >= 0 && self.hudoutlinechannels[channelindex].var_41272a9c461e0853.size > 0) {
    return true;
  }

  return false;
}

function function_f980012fc1b73aee(ent, channelname, viewer) {
  if(!function_2bd2083ae492439a(ent, viewer)) {
    function_af1ed457ea26863c(ent, channelname, viewer);
    return;
  }

  foreach(outlinechannel in self.hudoutlinechannels) {
    channelindex = function_bf76e3eaccf13673(self.hudoutlinechannels, channelname);

    if(channelindex >= 0 && outlinechannel.channelpriority > self.hudoutlinechannels[channelindex].channelpriority && array_contains(outlinechannel.var_41272a9c461e0853, viewer)) {
      return;
    }
  }

  function_af1ed457ea26863c(ent, channelname, viewer);
}

function function_2bd2083ae492439a(ent, viewer) {
  foreach(channel in ent.hudoutlinechannels) {
    if(array_contains(channel.var_41272a9c461e0853, viewer)) {
      return true;
    }
  }

  return false;
}

function function_a2d9562a736f54e3(channelname, ent, hudoutlineasset) {
  channelindex = function_bf76e3eaccf13673(self.hudoutlinechannels, channelname);

  if(channelindex >= 0) {
    foreach(viewer in self.hudoutlinechannels[channelindex].var_41272a9c461e0853) {
      ent hudoutlineenableforclient(viewer, hudoutlineasset);
    }
  }
}

function function_af1ed457ea26863c(ent, channelname, viewer) {
  channelindex = function_bf76e3eaccf13673(self.hudoutlinechannels, channelname);

  if(channelindex >= 0) {
    channel = self.hudoutlinechannels[channelindex];
    ent hudoutlineenableforclient(viewer, channel.outlineasset);

    if(!array_contains(channel.var_41272a9c461e0853, viewer)) {
      self.hudoutlinechannels[channelindex].var_41272a9c461e0853 = array_add(channel.var_41272a9c461e0853, viewer);
    }
  }
}

function hudoutline_activate_channel(channelname, viewer) {
  if(isDefined(self.hudoutlinecurchannel) && self.hudoutlinecurchannel.channelname != channelname && array_contains(self.hudoutlinecurchannel.var_41272a9c461e0853, viewer)) {
    function_32dfa50c47325abe(viewer, self.hudoutlinecurchannel.channelname, 0);
  }

  self.hudoutlinecurchannel = self.hudoutlinechannels[function_bf76e3eaccf13673(self.hudoutlinechannels, channelname)];
  function_f980012fc1b73aee(self, channelname, viewer);
}

function function_32dfa50c47325abe(var_10afc5ce5a1feebe, channelname, var_d6ee45fafd47e3cc) {
  if(!isDefined(var_d6ee45fafd47e3cc)) {
    var_d6ee45fafd47e3cc = 0;
  }

  channelindex = function_bf76e3eaccf13673(self.hudoutlinechannels, channelname);
  channel = self.hudoutlinechannels[channelindex];

  if(isDefined(channel)) {
    for(i = 0; i < channel.var_41272a9c461e0853.size; i++) {
      if(channel.var_41272a9c461e0853[i] == var_10afc5ce5a1feebe) {
        self hudoutlinedisableforclient(var_10afc5ce5a1feebe);

        if(var_d6ee45fafd47e3cc) {
          self.hudoutlinechannels[channelindex].var_41272a9c461e0853 = array_remove_index(channel.var_41272a9c461e0853, i, 0);
        }

        break;
      }
    }

    for(i = self.hudoutlinechannels.size - 1; i >= 0; i--) {
      if(self.hudoutlinechannels[i].channelpriority > channel.channelpriority) {
        continue;
      }

      if(array_contains(self.hudoutlinechannels[i].var_41272a9c461e0853, var_10afc5ce5a1feebe)) {
        hudoutline_activate_channel(self.hudoutlinechannels[i].channelname, var_10afc5ce5a1feebe);
        break;
      }
    }
  }
}

function outlinerefreshinternal(var_420a996e67989dc4) {
  if(!isDefined(var_420a996e67989dc4.outlines) || var_420a996e67989dc4.outlines.size == 0) {
    return;
  }

  foreach(oinfo in var_420a996e67989dc4.outlines) {
    if(!isDefined(oinfo) || oinfo.isdisabled) {
      continue;
    }

    foreach(player in oinfo.playersvisibleto) {
      if(!isDefined(player)) {
        continue;
      }

      var_25a840a406e8542a = outlinegethighestinfoforplayer(var_420a996e67989dc4, player);

      if(isDefined(var_25a840a406e8542a)) {
        var_420a996e67989dc4 _hudoutlineenableforclient(player, var_25a840a406e8542a.hudoutlineassetname);
      }
    }
  }
}

function outlineonplayerdisconnect(player) {
  outlineremoveplayerfromvisibletoarrays(player);
  outlinedisableinternalall(player);
}

function outlineonplayerjoinedteam(player) {
  if(!isDefined(player.team) || player.team == "spectator" || player.team == "codcaster") {
    return;
  }

  thread outlineonplayerjoinedteam_onfirstspawn(player);
}

function outlineonplayerjoinedteam_onfirstspawn(player) {
  player notify("outlineOnPlayerJoinedTeam_onFirstSpawn");
  player endon("outlineOnPlayerJoinedTeam_onFirstSpawn");
  player endon("disconnect");
  player waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(player);
  outlinedisableinternalall(player);
  outlineaddplayertoexistingallandteamoutlines(player);
}

function outlineonplayerjoinedsquad(player) {
  assertex(isDefined(player.team) && player.team != "<dev string:xe5>", "<dev string:xf2>");
  thread outlineonplayerjoinedsquad_onfirstspawn(player);
}

function outlineonplayerjoinedsquad_onfirstspawn(player) {
  player notify("outlineOnPlayerJoinedSquad_onFirstSpawn");
  player endon("outlineOnPlayerJoinedSquad_onFirstSpawn");
  player endon("disconnect");
  player waittill("spawned_player");
  outlineremoveplayerfromvisibletoarrays(player, 1);
  outlineaddplayertoexistingsquadoutlines(player);
}

function outlineremoveplayerfromvisibletoarrays(player, var_e1f59b5642da1702) {
  level.outlineents = array_removeundefined(level.outlineents);

  foreach(var_420a996e67989dc4 in level.outlineents) {
    var_8408cba753aba3e3 = 0;

    if(!isDefined(var_420a996e67989dc4) || !isDefined(var_420a996e67989dc4.outlines)) {
      continue;
    }

    foreach(oinfo in var_420a996e67989dc4.outlines) {
      if(!isDefined(oinfo.playersvisibleto)) {
        continue;
      }

      if(istrue(var_e1f59b5642da1702)) {
        if(oinfo.type != "SQUAD") {
          continue;
        }
      }

      oinfo.playersvisibleto = array_removeundefined(oinfo.playersvisibleto);

      if(isDefined(player) && array_contains(oinfo.playersvisibleto, player)) {
        oinfo.playersvisibleto = array_remove(oinfo.playersvisibleto, player);
        var_8408cba753aba3e3 = 1;
      }
    }

    if(var_8408cba753aba3e3 && isDefined(var_420a996e67989dc4) && isDefined(player)) {
      var_420a996e67989dc4 hudoutlinedisableforclient(player);
    }
  }
}

function outlineaddplayertoexistingallandteamoutlines(player) {
  foreach(var_420a996e67989dc4 in level.outlineents) {
    if(!isDefined(var_420a996e67989dc4) || !isDefined(var_420a996e67989dc4.outlines)) {
      continue;
    }

    var_25a840a406e8542a = undefined;

    foreach(oinfo in var_420a996e67989dc4.outlines) {
      if(oinfo.type == "ALL" || oinfo.type == "TEAM" && oinfo.team == player.team) {
        if(!array_contains(oinfo.playersvisibleto, player)) {
          oinfo.playersvisibleto[oinfo.playersvisibleto.size] = player;
        } else {
          assertmsg("<dev string:x136>");
        }

        if(!isDefined(var_25a840a406e8542a) || oinfo.priority > var_25a840a406e8542a.priority) {
          var_25a840a406e8542a = oinfo;
        }
      }
    }

    if(isDefined(var_25a840a406e8542a)) {
      var_420a996e67989dc4 _hudoutlineenableforclient(player, var_25a840a406e8542a.hudoutlineassetname);
    }
  }
}

function outlineaddplayertoexistingsquadoutlines(player) {
  if(!isDefined(player.sessionsquadid)) {
    assertmsg("<dev string:x1df>");
  }

  foreach(var_420a996e67989dc4 in level.outlineents) {
    if(!isDefined(var_420a996e67989dc4) || !isDefined(var_420a996e67989dc4.outlines)) {
      continue;
    }

    var_25a840a406e8542a = undefined;

    foreach(oinfo in var_420a996e67989dc4.outlines) {
      if(oinfo.type == "SQUAD" && oinfo.team == player.team && isDefined(oinfo.sessionsquadid) && oinfo.sessionsquadid == player.sessionsquadid) {
        if(!array_contains(oinfo.playersvisibleto, player)) {
          oinfo.playersvisibleto[oinfo.playersvisibleto.size] = player;
        } else {
          assertmsg("<dev string:x244>");
        }

        if(!isDefined(var_25a840a406e8542a) || oinfo.priority > var_25a840a406e8542a.priority) {
          var_25a840a406e8542a = oinfo;
        }
      }
    }

    if(isDefined(var_25a840a406e8542a)) {
      var_420a996e67989dc4 _hudoutlineenableforclient(player, var_25a840a406e8542a.hudoutlineassetname);
    }
  }
}

function outlinedisableinternalall(var_420a996e67989dc4) {
  if(!isDefined(var_420a996e67989dc4) || !isDefined(var_420a996e67989dc4.outlines) || var_420a996e67989dc4.outlines.size == 0) {
    return;
  }

  foreach(id, _ in var_420a996e67989dc4.outlines) {
    outlinedisableinternal(id, var_420a996e67989dc4);
  }
}

function outlineaddtogloballist(var_420a996e67989dc4) {
  if(!array_contains(level.outlineents, var_420a996e67989dc4)) {
    level.outlineents[level.outlineents.size] = var_420a996e67989dc4;
  }
}

function outlineremovefromgloballist(var_420a996e67989dc4) {
  level.outlineents = array_remove(level.outlineents, var_420a996e67989dc4);
}

function outlinegethighestpriorityid(var_420a996e67989dc4) {
  result = -1;

  if(!isDefined(var_420a996e67989dc4.outlines) || var_420a996e67989dc4.size == 0) {
    return result;
  }

  var_25a840a406e8542a = undefined;

  foreach(id, oinfo in var_420a996e67989dc4.outlines) {
    if(!isDefined(oinfo) || oinfo.isdisabled) {
      continue;
    }

    if(!isDefined(var_25a840a406e8542a) || oinfo.priority > var_25a840a406e8542a.priority) {
      var_25a840a406e8542a = oinfo;
      result = id;
    }
  }

  return result;
}

function outlinegethighestinfoforplayer(var_420a996e67989dc4, player) {
  var_25a840a406e8542a = undefined;

  if(!isDefined(var_420a996e67989dc4.outlines) || var_420a996e67989dc4.size == 0) {
    return var_25a840a406e8542a;
  }

  foreach(oinfo in var_420a996e67989dc4.outlines) {
    if(!isDefined(oinfo) || oinfo.isdisabled) {
      continue;
    }

    if(array_contains(oinfo.playersvisibleto, player) && (!isDefined(var_25a840a406e8542a) || oinfo.priority > var_25a840a406e8542a.priority)) {
      var_25a840a406e8542a = oinfo;
    }
  }

  return var_25a840a406e8542a;
}

function outlinegenerateuniqueid() {
  assertex(isDefined(level.outlineids), "<dev string:x2f1>");
  level.outlineids++;
  return level.outlineids;
}

function outlineprioritygroupmap(prioritygroup) {
  prioritygroup = tolower(prioritygroup);
  priority = undefined;

  switch (prioritygroup) {
    case #"hash_981112ec5a4f9d1b":
      priority = 0;
      break;
    case #"hash_5b627208a88fd4c5":
      priority = 1;
      break;
    case #"hash_93c71e7b6c0b81d7":
      priority = 2;
      break;
    case #"hash_ab671284a3fc4e3d":
      priority = 3;
      break;
    case #"hash_ddbe11dc920809f1":
      priority = 4;
      break;
    case #"hash_1cac65e1b8bf24a7":
      priority = 5;
      break;
    case #"hash_1f9d0ab7b01d7818":
      priority = 6;
      break;
    case #"hash_df6b3b2585101bc7":
      priority = 7;
      break;
    case #"hash_6d308d6c437ce11c":
      priority = 8;
      break;
    default:
      assertmsg("<dev string:x346>" + prioritygroup);
      priority = 0;
      break;
  }

  return priority;
}

function outlineiddowatch() {
  foreach(index, ent in level.outlineidspending) {
    if(!isDefined(ent)) {
      continue;
    }

    if(!isDefined(ent.outlines)) {
      continue;
    }

    oinfo = ent.outlines[index];

    if(!isDefined(oinfo)) {
      continue;
    }

    if(oinfo.playersvisibletopending.size > 0) {
      if(outlinerefreshpending(ent, index)) {
        level.outlineidspending[index] = undefined;
      }
    }
  }
}

function outlineidswatchpending() {
  while(true) {
    waittillframeend();
    outlineiddowatch();
    waitframe();
  }
}

function outlinerefreshpending(var_420a996e67989dc4, id) {
  oinfo = var_420a996e67989dc4.outlines[id];

  foreach(index, player in oinfo.playersvisibletopending) {
    if(!isDefined(player)) {
      continue;
    }

    if(canoutlineforplayer(player)) {
      var_25a840a406e8542a = outlinegethighestinfoforplayer(var_420a996e67989dc4, player);

      if(isDefined(var_25a840a406e8542a) && var_25a840a406e8542a.hudoutlineassetname != "invisible") {
        var_420a996e67989dc4 hudoutlineenableforclient(player, var_25a840a406e8542a.hudoutlineassetname);
      } else {
        var_420a996e67989dc4 hudoutlinedisableforclient(player);
      }

      oinfo.playersvisibletopending[index] = undefined;
    }
  }

  oinfo.playersvisibletopending = array_removeundefined(oinfo.playersvisibletopending);

  if(oinfo.playersvisibletopending.size == 0) {
    if(oinfo.isdisabled) {
      var_420a996e67989dc4.outlines[id] = undefined;
    }

    if(var_420a996e67989dc4.outlines.size == 0) {
      outlineremovefromgloballist(var_420a996e67989dc4);
    }

    return true;
  }

  return false;
}

function canoutlineforplayer(player) {
  return player.sessionstate != "spectator";
}

function function_3430d5003d0cc9f(var_cda6602a02c53ba3, prioritygroup) {
  foreach(operator in var_cda6602a02c53ba3) {
    scripts\mp\outline::hudoutline_enable_internal(operator, prioritygroup);
  }
}

function _hudoutlineenableforclient(client, hudoutlineassetname) {
  if(hudoutlineassetname == "invisible") {
    self hudoutlinedisableforclient(client);
    return;
  }

  self hudoutlineenableforclient(client, hudoutlineassetname);
}

function _hudoutlineenableforclients(var_b66f9e35e36435bb, hudoutlineassetname) {
  if(hudoutlineassetname == "invisible") {
    self hudoutlinedisableforclients(var_b66f9e35e36435bb);
    return;
  }

  self hudoutlineenableforclients(var_b66f9e35e36435bb, hudoutlineassetname);
}