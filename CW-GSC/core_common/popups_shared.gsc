/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\popups_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace popups;

function private autoexec __init__system__() {
  system::register(#"popups", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
}

function init() {
  level.contractsettings = spawnStruct();
  level.contractsettings.waittime = 4.2;
  level.killstreaksettings = spawnStruct();
  level.killstreaksettings.waittime = 3;
  level.ranksettings = spawnStruct();
  level.ranksettings.waittime = 3;
  level.startmessage = spawnStruct();
  level.startmessagedefaultduration = 2;
  level.endmessagedefaultduration = 2;
  level.challengesettings = spawnStruct();
  level.challengesettings.waittime = 3;
  level.teammessage = spawnStruct();
  level.teammessage.waittime = 3;
  level.momentumnotifywaittime = 0;
  level.momentumnotifywaitlasttime = 0;
  level.teammessagequeuemax = 8;

  level thread popupsfromconsole();
  level thread devgui_notif_init();

  callback::on_connecting(&on_player_connect);
  callback::add_callback(#"team_message", &on_team_message);
}

function on_player_connect() {
  if(isDefined(self) && !function_3132f113(self)) {
    self.resetgameoverhudrequired = 0;

    if(!level.hardcoremode) {
      if(shoulddisplayteammessages()) {
        self.teammessagequeue = [];
      }
    }
  }
}

function devgui_notif_getgunleveltablename() {
  if(sessionmodeiscampaigngame()) {
    return # "gamedata/weapons/cp/cp_gunlevels.csv";
  }

  if(sessionmodeiszombiesgame()) {
    return # "gamedata/weapons/zm/zm_gunlevels.csv";
  }

  return # "gamedata/weapons/mp/mp_gunlevels.csv";
}

function devgui_notif_getchallengestablecount() {
  if(sessionmodeiscampaigngame()) {
    return 1;
  }

  if(sessionmodeiszombiesgame()) {
    return 6;
  }

  return 6;
}

function devgui_notif_getchallengestablename(tableid) {
  if(sessionmodeiscampaigngame()) {
    return (#"gamedata/stats/cp/statsmilestones" + tableid + "<dev string:x38>");
  }

  if(sessionmodeiszombiesgame()) {
    return (#"gamedata/stats/zm/statsmilestones" + tableid + "<dev string:x38>");
  }

  return # "gamedata/stats/mp/statsmilestones" + tableid + "<dev string:x38>";
}

function devgui_create_weapon_levels_table() {
  level.tbl_weaponids = [];

  for(i = 0; i < 1024; i++) {
    iteminfo = getunlockableiteminfofromindex(i, 0);

    if(isDefined(iteminfo)) {
      group_s = iteminfo.itemgroupname;

      if(issubstr(group_s, "<dev string:x40>") || group_s == "<dev string:x4b>") {
        reference_s = iteminfo.namehash;

        if(reference_s != "<dev string:x53>") {
          level.tbl_weaponids[i][# "reference"] = reference_s;
          level.tbl_weaponids[i][# "group"] = group_s;
          level.tbl_weaponids[i][# "count"] = iteminfo.count;
          level.tbl_weaponids[i][# "attachment"] = iteminfo.attachments;
        }
      }
    }
  }
}

function devgui_notif_init() {
  setDvar(#"scr_notif_devgui_rank", 0);
  setDvar(#"scr_notif_devgui_gun_lvl_xp", 0);
  setDvar(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
  setDvar(#"scr_notif_devgui_gun_lvl_item_index", 0);
  setDvar(#"scr_notif_devgui_gun_lvl_rank_id", 0);

  if(isdedicated()) {
    return;
  }

  util::add_devgui("<dev string:x57>", "<dev string:x7f>");
  util::add_devgui("<dev string:xa5>", "<dev string:xd0>");
  util::add_devgui("<dev string:xf9>", "<dev string:x136>");
  util::add_devgui("<dev string:x163>", "<dev string:x1b3>");
  util::add_devgui("<dev string:x1e0>", "<dev string:x227>");
  util::add_devgui("<dev string:x254>", "<dev string:x2a0>");
  util::add_devgui("<dev string:x2cd>", "<dev string:x312>");
  util::add_devgui("<dev string:x33f>", "<dev string:x38e>");
  level thread function_a65863ce();
}

function function_a65863ce() {
  level endon(#"game_ended");

  while(true) {
    if(getdvarint(#"hash_5b32141cac382fa3", 0) > 0) {
      util::remove_devgui("<dev string:x3bb>");
      level thread notif_devgui_gun_rank();
      setDvar(#"hash_5b32141cac382fa3", 0);
    } else if(getdvarint(#"hash_4ccabf785218a1e0", 0) > 0) {
      util::remove_devgui("<dev string:x3e1>");
      level thread notif_devgui_rank();
      setDvar(#"hash_4ccabf785218a1e0", 0);
    } else {
      dvarval = getdvarint(#"hash_3873da9b7bf24d7c", 0);

      if(dvarval) {
        switch (dvarval) {
          case 1:
            menu = "<dev string:x40a>";
            break;
          case 2:
            menu = "<dev string:x445>";
            break;
          case 3:
            menu = "<dev string:x493>";
            break;
          case 4:
            menu = "<dev string:x4d8>";
            break;
          case 5:
            menu = "<dev string:x522>";
            break;
          case 6:
            menu = "<dev string:x565>";
            break;
          default:
            menu = undefined;
            break;
        }

        if(isDefined(menu)) {
          util::remove_devgui(menu);
          level thread function_43b5625e(dvarval);
          setDvar(#"hash_3873da9b7bf24d7c", 0);
        }
      }
    }

    wait 2;
  }
}

function function_43b5625e(tablenum) {
  notif_challenges_devgui_base = "<dev string:x5b2>";
  tablename = devgui_notif_getchallengestablename(tablenum);
  rows = tablelookuprowcount(tablename);

  for(j = 1; j < rows; j++) {
    challengeid = tablelookupcolumnforrow(tablename, j, 0);

    if(challengeid != "<dev string:x53>" && strisint(tablelookupcolumnforrow(tablename, j, 0))) {
      challengestring = tablelookupcolumnforrow(tablename, j, 5);
      type = tablelookupcolumnforrow(tablename, j, 3);
      challengetier = int(tablelookupcolumnforrow(tablename, j, 1));
      challengetierstring = "<dev string:x53>" + challengetier;

      if(challengetier < 10) {
        challengetierstring = "<dev string:x5de>" + challengetier;
      }

      name = tablelookupcolumnforrow(tablename, j, 5);
      devgui_cmd_challenge_path = notif_challenges_devgui_base + function_9e72a96(type) + "<dev string:x5e3>" + function_9e72a96(name) + "<dev string:x5e3>" + challengetierstring + "<dev string:x5e8>" + challengeid;
      util::waittill_can_add_debug_command();
      adddebugcommand(devgui_cmd_challenge_path + "<dev string:x5f1>" + "<dev string:x5f7>" + "<dev string:x5fc>" + "<dev string:x605>" + "<dev string:x627>" + j + "<dev string:x5fc>" + "<dev string:x62c>" + "<dev string:x627>" + tablenum + "<dev string:x650>");

      if(int(challengeid) % 10) {
        waitframe(1);
      }
    }
  }

  level thread notif_devgui_challenges_think();
}

function notif_devgui_rank() {
  if(!isDefined(level.ranktable)) {
    return;
  }

  notif_rank_devgui_base = "<dev string:x657>";

  for(i = 1; i < level.ranktable.size; i++) {
    display_level = i + 1;

    if(display_level < 10) {
      display_level = "<dev string:x5de>" + display_level;
    }

    util::waittill_can_add_debug_command();
    adddebugcommand(notif_rank_devgui_base + display_level + "<dev string:x5f1>" + "<dev string:x5f7>" + "<dev string:x683>" + "<dev string:x627>" + i + "<dev string:x650>");
  }

  waitframe(1);
  level thread notif_devgui_rank_up_think();
}

function notif_devgui_rank_up_think() {
  for(;;) {
    rank_number = getdvarint(#"scr_notif_devgui_rank", 0);

    if(rank_number == 0) {
      waitframe(1);
      continue;
    }

    level.players[0] rank::codecallback_rankup({
      #rank: rank_number, #prestige: 0, #unlock_tokens_added: 1
    });
    setDvar(#"scr_notif_devgui_rank", 0);
    wait 1;
  }
}

function notif_devgui_gun_rank() {
  notif_gun_rank_devgui_base = "<dev string:x69c>";
  gunlevel_rankid_col = 0;
  gunlevel_gunref_col = 2;
  gunlevel_attachment_unlock_col = 3;
  gunlevel_xpgained_col = 4;
  level flag::wait_till("<dev string:x6c7>");

  if(!isDefined(level.tbl_weaponids)) {
    devgui_create_weapon_levels_table();
  }

  if(!isDefined(level.tbl_weaponids)) {
    return;
  }

  a_weapons = [];
  a_weapons[# "assault"] = [];
  a_weapons[# "tactical"] = [];
  a_weapons[# "smg"] = [];
  a_weapons[# "lmg"] = [];
  a_weapons[# "shotgun"] = [];
  a_weapons[# "sniper"] = [];
  a_weapons[# "pistol"] = [];
  a_weapons[# "launcher"] = [];
  a_weapons[# "knife"] = [];
  gun_levels_table = devgui_notif_getgunleveltablename();

  foreach(weapon in level.tbl_weaponids) {
    gun = [];
    gun[# "ref"] = weapon[# "reference"];
    gun[# "itemindex"] = getitemindexfromref(weapon[# "reference"]);
    gun[# "attachments"] = [];
    gun_weapon_attachments = weapon[# "attachment"];

    if(isDefined(gun_weapon_attachments) && isarray(gun_weapon_attachments)) {
      foreach(attachment in gun_weapon_attachments) {
        gun[# "attachments"][attachment] = [];
        gun[# "attachments"][attachment][# "itemindex"] = getattachmenttableindex(attachment);
        gun[# "attachments"][attachment][# "rankid"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun[# "ref"], gunlevel_attachment_unlock_col, attachment, gunlevel_rankid_col);
        gun[# "attachments"][attachment][# "xp"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun[# "ref"], gunlevel_attachment_unlock_col, attachment, gunlevel_xpgained_col);
      }
    }

    switch (weapon[# "group"]) {
      case # "weapon_pistol":
        if(weapon[# "reference"] != "<dev string:x6de>") {
          arrayinsert(a_weapons[# "pistol"], gun, 0);
        }

        break;
      case # "weapon_launcher":
        arrayinsert(a_weapons[# "launcher"], gun, 0);
        break;
      case # "weapon_assault":
        arrayinsert(a_weapons[# "assault"], gun, 0);
        break;
      case # "weapon_tactical":
        arrayinsert(a_weapons[# "tactical"], gun, 0);
        break;
      case # "weapon_smg":
        arrayinsert(a_weapons[# "smg"], gun, 0);
        break;
      case # "weapon_lmg":
        arrayinsert(a_weapons[# "lmg"], gun, 0);
        break;
      case # "weapon_cqb":
        arrayinsert(a_weapons[# "shotgun"], gun, 0);
        break;
      case # "weapon_sniper":
        arrayinsert(a_weapons[# "sniper"], gun, 0);
        break;
      case # "weapon_knife":
        arrayinsert(a_weapons[# "knife"], gun, 0);
        break;
      default:
        break;
    }
  }

  foreach(group_name, gun_group in a_weapons) {
    foreach(gun, attachment_group in gun_group) {
      foreach(attachment, attachment_data in attachment_group[# "attachments"]) {
        devgui_cmd_gun_path = notif_gun_rank_devgui_base + function_9e72a96(group_name) + "<dev string:x5e3>" + function_9e72a96(gun_group[gun][# "ref"]) + "<dev string:x5e3>" + function_9e72a96(attachment);
        util::waittill_can_add_debug_command();
        adddebugcommand(devgui_cmd_gun_path + "<dev string:x5f1>" + "<dev string:x5f7>" + "<dev string:x5fc>" + "<dev string:x6ed>" + "<dev string:x627>" + attachment_data[# "xp"] + "<dev string:x5fc>" + "<dev string:x70c>" + "<dev string:x627>" + attachment_data[# "itemindex"] + "<dev string:x5fc>" + "<dev string:x739>" + "<dev string:x627>" + gun_group[gun][# "itemindex"] + "<dev string:x5fc>" + "<dev string:x760>" + "<dev string:x627>" + attachment_data[# "rankid"] + "<dev string:x650>");
      }
    }

    waitframe(1);
  }

  level thread notif_devgui_gun_level_think();
}

function notif_devgui_gun_level_think() {
  for(;;) {
    weapon_item_index = getdvarint(#"scr_notif_devgui_gun_lvl_item_index", 0);

    if(weapon_item_index == 0) {
      waitframe(1);
      continue;
    }

    xp_reward = getdvarint(#"scr_notif_devgui_gun_lvl_xp", 0);
    attachment_index = getdvarint(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
    rank_id = getdvarint(#"scr_notif_devgui_gun_lvl_rank_id", 0);
    level.players[0] persistence::codecallback_gunchallengecomplete({
      #reward: xp_reward, #attachment_index: attachment_index, #item_index: weapon_item_index, #rank_id: rank_id
    });
    setDvar(#"scr_notif_devgui_gun_lvl_xp", 0);
    setDvar(#"scr_notif_devgui_gun_lvl_attachment_index", 0);
    setDvar(#"scr_notif_devgui_gun_lvl_item_index", 0);
    setDvar(#"scr_notif_devgui_gun_lvl_rank_id", 0);
    wait 1;
  }
}

function notif_devgui_challenges_think() {
  self notify("<dev string:x784>");
  self endon("<dev string:x784>");
  setDvar(#"scr_notif_devgui_challenge_row", 0);
  setDvar(#"scr_notif_devgui_challenge_table", 0);

  for(;;) {
    row = getdvarint(#"scr_notif_devgui_challenge_row", 0);
    table = getdvarint(#"scr_notif_devgui_challenge_table", 0);

    if(table < 1 || table > devgui_notif_getchallengestablecount()) {
      waitframe(1);
      continue;
    }

    player = level.players[0];
    tablename = devgui_notif_getchallengestablename(table);

    if(row < 1 || row > tablelookuprowcount(tablename)) {
      waitframe(1);
      continue;
    }

    type = tablelookupcolumnforrow(tablename, row, 3);
    itemindex = 0;

    if(type == "<dev string:x798>") {
      type = 0;
    } else if(type == "<dev string:x7a2>") {
      itemindex = 4;
      type = 3;
    } else if(type == "<dev string:x7ab>") {
      itemindex = 1;
      type = 4;
    } else if(type == "<dev string:x7b9>") {
      type = 2;
    } else if(type == "<dev string:x7c5>") {
      type = 5;
    } else {
      itemindex = getdvarint(#"scr_challenge_itemindex", 0);

      if(itemindex == 0) {
        currentweaponname = player.currentweapon.name;
        itemindex = getitemindexfromref(currentweaponname);

        if(itemindex == 0) {
          itemindex = 225;
        }
      }

      type = 1;
    }

    xpreward = int(tablelookupcolumnforrow(tablename, row, 6));
    challengeid = int(tablelookupcolumnforrow(tablename, row, 0));
    maxvalue = int(tablelookupcolumnforrow(tablename, row, 2));
    player persistence::codecallback_challengecomplete({
      #reward: xpreward, #max: maxvalue, #row: row, #table_number: table - 1, #challenge_type: type, #item_index: itemindex, #challenge_index: challengeid
    });
    setDvar(#"scr_notif_devgui_challenge_row", 0);
    setDvar(#"scr_notif_devgui_challenge_table", 0);
    wait 1;
  }
}

function popupsfromconsole() {
  while(true) {
    timeout = getdvarfloat(#"scr_popuptime", 1);

    if(timeout == 0) {
      timeout = 1;
    }

    wait timeout;
    medal = getdvarint(#"scr_popupmedal", 0);
    challenge = getdvarint(#"scr_popupchallenge", 0);
    rank = getdvarint(#"scr_popuprank", 0);
    gun = getdvarint(#"scr_popupgun", 0);
    contractpass = getdvarint(#"scr_popupcontractpass", 0);
    contractfail = getdvarint(#"scr_popupcontractfail", 0);
    gamemodemsg = getdvarint(#"scr_gamemodeslideout", 0);
    teammsg = getdvarint(#"scr_teamslideout", 0);
    challengeindex = getdvarint(#"scr_challengeindex", 1);

    for(i = 0; i < medal; i++) {
      level.players[0] medals::codecallback_medal({
        #medal_index: 2
      });
    }

    for(i = 0; i < challenge; i++) {
      level.players[0] persistence::codecallback_challengecomplete({
        #reward: 1000, #max: 10, #row: 19, #table_numuber: 0, #challenge_type: 0, #item_index: 0, #challenge_index: 18
      });
      level.players[0] persistence::codecallback_challengecomplete({
        #reward: 1000, #max: 1, #row: 21, #table_number: 0, #challenge_type: 0, #item_index: 0, #challenge_index: 20
      });
      rewardxp = 500;
      maxval = 1;
      row = 1;
      tablenumber = 0;
      challengetype = 1;
      itemindex = 111;
      challengeindex = 0;
      maxval = 50;
      row = 1;
      tablenumber = 2;
      challengetype = 1;
      itemindex = 20;
      challengeindex = 512;
      maxval = 150;
      row = 100;
      tablenumber = 2;
      challengetype = 4;
      itemindex = 1;
      challengeindex = 611;
      level.players[0] persistence::codecallback_challengecomplete({
        #reward: rewardxp, #max: maxval, #row: row, #table_number: tablenumber, #challenge_type: challengetype, #item_index: itemindex, #challenge_index: challengeindex
      });
    }

    for(i = 0; i < rank; i++) {
      level.players[0] rank::codecallback_rankup({
        #rank: 4, #prestige: 0, #unlock_tokens_added: 1
      });
    }

    for(i = 0; i < gun; i++) {
      level.players[0] persistence::codecallback_gunchallengecomplete({
        #reward: 0, #attachment_index: 20, #item_index: 25, #rank_id: 0
      });
    }

    for(i = 0; i < teammsg; i++) {
      player = level.players[0];

      if(isDefined(level.players[1])) {
        player = level.players[1];
      }

      level.players[0] displayteammessagetoall(#"hash_286f843fea185e5", player);
    }

    reset = getdvarint(#"scr_popupreset", 1);

    if(reset) {
      if(medal) {
        setDvar(#"scr_popupmedal", 0);
      }

      if(challenge) {
        setDvar(#"scr_popupchallenge", 0);
      }

      if(gun) {
        setDvar(#"scr_popupgun", 0);
      }

      if(rank) {
        setDvar(#"scr_popuprank", 0);
      }

      if(contractpass) {
        setDvar(#"scr_popupcontractpass", 0);
      }

      if(contractfail) {
        setDvar(#"scr_popupcontractfail", 0);
      }

      if(gamemodemsg) {
        setDvar(#"scr_gamemodeslideout", 0);
      }

      if(teammsg) {
        setDvar(#"scr_teamslideout", 0);
      }
    }
  }
}

function displaykillstreakteammessagetoall(killstreak, player) {
  if(!isDefined(level.killstreaks[killstreak])) {
    return;
  }

  if(!isDefined(level.killstreaks[killstreak].script_bundle)) {
    return;
  }

  if(!isDefined(level.killstreaks[killstreak].script_bundle.var_bc2f6af9)) {
    return;
  }

  self displayteammessagetoall(level.killstreaks[killstreak].script_bundle.var_bc2f6af9, player);
}

function displaykillstreakhackedteammessagetoall(killstreak, player) {
  if(!isDefined(level.killstreaks[killstreak])) {
    return;
  }

  if(!isDefined(level.killstreaks[killstreak].script_bundle)) {
    return;
  }

  if(!isDefined(level.killstreaks[killstreak].script_bundle.var_6417048f)) {
    return;
  }

  self displayteammessagetoall(level.killstreaks[killstreak].script_bundle.var_6417048f, player);
}

function shoulddisplayteammessages() {
  if(level.hardcoremode == 1 || level.splitscreen == 1 || sessionmodeiscampaigngame() || level.var_c6dc0337 === 1) {
    return false;
  }

  return true;
}

function function_eb9328f3() {
  self notify(#"received teammessage");
  self callback::callback(#"team_message");
}

function displayteammessagetoall(message, player) {
  if(!shoulddisplayteammessages()) {
    return;
  }

  for(i = 0; i < level.players.size; i++) {
    cur_player = level.players[i];

    if(cur_player isempjammed()) {
      continue;
    }

    size = cur_player.teammessagequeue.size;

    if(size >= level.teammessagequeuemax) {
      continue;
    }

    cur_player.teammessagequeue[size] = spawnStruct();
    cur_player.teammessagequeue[size].notifyhash = # "player_callout";
    cur_player.teammessagequeue[size].message = message;
    cur_player.teammessagequeue[size].player = player;
    cur_player function_eb9328f3();
  }
}

function displayteammessagetoteam(message, player, team, var_fd214505, var_aba8941, var_1dd0326a, var_265441a6, var_8fa431fa) {
  function_bed391aa(#"player_callout", message, player, team, var_fd214505, var_aba8941, var_1dd0326a, var_265441a6, var_8fa431fa);
}

function function_87604884(message, player, team, var_fd214505, var_aba8941) {
  function_bed391aa(#"inventory_callout", message, player, team, var_fd214505, var_aba8941);
}

function private function_bed391aa(notifyhash, message, player, team, var_fd214505, var_aba8941, var_1dd0326a, var_265441a6, var_8fa431fa) {
  if(!shoulddisplayteammessages()) {
    return;
  }

  for(i = 0; i < level.players.size; i++) {
    cur_player = level.players[i];

    if(cur_player.team != team) {
      continue;
    }

    if(cur_player isempjammed()) {
      continue;
    }

    size = cur_player.teammessagequeue.size;

    if(size >= level.teammessagequeuemax) {
      continue;
    }

    cur_player.teammessagequeue[size] = spawnStruct();
    cur_player.teammessagequeue[size].notifyhash = notifyhash;
    cur_player.teammessagequeue[size].message = message;
    cur_player.teammessagequeue[size].player = player;
    cur_player.teammessagequeue[size].var_fd214505 = var_fd214505;
    cur_player.teammessagequeue[size].var_aba8941 = var_aba8941;
    cur_player.teammessagequeue[size].var_1dd0326a = var_1dd0326a;
    cur_player.teammessagequeue[size].var_265441a6 = var_265441a6;
    cur_player.teammessagequeue[size].var_8fa431fa = var_8fa431fa;
    callback::callback(#"hash_41781454d98b676a", cur_player.teammessagequeue[size]);
    cur_player function_eb9328f3();
  }
}

function on_team_message() {
  if(!shoulddisplayteammessages()) {
    return;
  }

  function_921657e4();
}

function function_921657e4() {
  while(self.teammessagequeue.size > 0) {
    nextnotifydata = self.teammessagequeue[0];
    arrayremoveindex(self.teammessagequeue, 0, 0);

    if(!isDefined(nextnotifydata.player) || !isPlayer(nextnotifydata.player)) {
      continue;
    }

    if(self isempjammed()) {
      continue;
    }

    notifyhash = nextnotifydata.notifyhash;
    var_1dd0326a = -1;
    var_fd214505 = -1;
    var_aba8941 = -1;
    var_265441a6 = -1;
    var_8fa431fa = -1;

    if(isDefined(nextnotifydata.var_1dd0326a)) {
      var_1dd0326a = nextnotifydata.var_1dd0326a;
    }

    if(isDefined(nextnotifydata.var_fd214505)) {
      var_fd214505 = nextnotifydata.var_fd214505;
    }

    if(isDefined(nextnotifydata.var_aba8941)) {
      var_aba8941 = nextnotifydata.var_aba8941;
    }

    if(isDefined(nextnotifydata.var_265441a6)) {
      var_265441a6 = nextnotifydata.var_265441a6;
    }

    if(isDefined(nextnotifydata.var_8fa431fa)) {
      var_8fa431fa = nextnotifydata.var_8fa431fa;
    }

    self luinotifyevent(notifyhash, 7, nextnotifydata.message, nextnotifydata.player getentitynumber(), var_fd214505, var_aba8941, var_1dd0326a, var_265441a6, var_8fa431fa);
  }
}