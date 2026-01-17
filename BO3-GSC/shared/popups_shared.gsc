/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\popups_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\medals_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons_shared;
#namespace popups;

function autoexec __init__sytem__() {
  system::register("popups", &__init__, undefined, undefined);
}

function __init__() {
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
  level.regulargamemessages = spawnStruct();
  level.regulargamemessages.waittime = 6;
  level.wagersettings = spawnStruct();
  level.wagersettings.waittime = 3;
  level.momentumnotifywaittime = 0;
  level.momentumnotifywaitlasttime = 0;
  level.teammessagequeuemax = 8;
  level thread popupsfromconsole();
  level thread function_9a14a686();
  callback::on_connecting(&on_player_connect);
}

function on_player_connect() {
  self.resetgameoverhudrequired = 0;
  self thread displaypopupswaiter();
  if(!level.hardcoremode) {
    self thread displayteammessagewaiter();
  }
}

function devgui_notif_getgunleveltablename() {
  if(sessionmodeiscampaigngame()) {
    return "";
  }
  if(sessionmodeiszombiesgame()) {
    return "";
  }
  return "";
}

function devgui_notif_getchallengestablecount() {
  if(sessionmodeiscampaigngame()) {
    return 4;
  }
  if(sessionmodeiszombiesgame()) {
    return 4;
  }
  return 6;
}

function devgui_notif_getchallengestablename(tableid) {
  if(sessionmodeiscampaigngame()) {
    return ("" + tableid) + "";
  }
  if(sessionmodeiszombiesgame()) {
    return ("" + tableid) + "";
  }
  return ("" + tableid) + "";
}

function set_statstable_id() {
  if(!isDefined(level.statstableid)) {
    level.statstableid = tablelookupfindcoreasset(util::getstatstablename());
  }
}

function devgui_create_weapon_levels_table() {
  level.tbl_weaponids = [];
  set_statstable_id();
  if(!isDefined(level.statstableid)) {
    return;
  }
  for(i = 0; i < 256; i++) {
    itemrow = tablelookuprownum(level.statstableid, 0, i);
    if(itemrow > -1) {
      group_s = tablelookupcolumnforrow(level.statstableid, itemrow, 2);
      if(issubstr(group_s, "") || group_s == "") {
        reference_s = tablelookupcolumnforrow(level.statstableid, itemrow, 4);
        if(reference_s != "") {
          weapon = getweapon(reference_s);
          level.tbl_weaponids[i][""] = reference_s;
          level.tbl_weaponids[i][""] = group_s;
          level.tbl_weaponids[i][""] = int(tablelookupcolumnforrow(level.statstableid, itemrow, 5));
          level.tbl_weaponids[i][""] = tablelookupcolumnforrow(level.statstableid, itemrow, 8);
        }
      }
    }
  }
}

function function_9a14a686() {
  if(isdedicated()) {
    return;
  }
  if((getdvarint("", -999)) == -999) {
    setdvar("", 0);
  }
  var_deda26ca = "";
  util::function_e2ac06bb(var_deda26ca + "", ("" + "") + "");
  while(true) {
    if(getdvarint("", 0) > 0) {
      util::function_181cbd1a(var_deda26ca);
      level thread devgui_notif_init();
      break;
    }
    wait(1);
  }
}

function devgui_notif_init() {
  setdvar("", 0);
  setdvar("", 0);
  setdvar("", 0);
  setdvar("", 0);
  setdvar("", 0);
  if(isdedicated()) {
    return;
  }
  level thread notif_devgui_rank();
  level thread notif_devgui_gun_rank();
  if(!sessionmodeiscampaigngame()) {
    level thread notif_devgui_challenges();
  }
}

function notif_devgui_rank() {
  if(!isDefined(level.ranktable)) {
    return;
  }
  notif_rank_devgui_base = "";
  for(i = 1; i < level.ranktable.size; i++) {
    display_level = i + 1;
    if(display_level < 10) {
      display_level = "" + display_level;
    }
    adddebugcommand(((((((notif_rank_devgui_base + display_level) + "") + "") + "") + "") + i) + "");
    if((i % 10) == 0) {
      wait(0.05);
    }
  }
  wait(0.05);
  level thread notif_devgui_rank_up_think();
}

function notif_devgui_rank_up_think() {
  for(;;) {
    rank_number = getdvarint("");
    if(rank_number == 0) {
      wait(0.05);
      continue;
    }
    level.players[0] rank::codecallback_rankup(rank_number, 0, 1);
    setdvar("", 0);
    wait(1);
  }
}

function notif_devgui_gun_rank() {
  notif_gun_rank_devgui_base = "";
  gunlevel_rankid_col = 0;
  gunlevel_gunref_col = 2;
  gunlevel_attachment_unlock_col = 3;
  gunlevel_xpgained_col = 4;
  level flag::wait_till("");
  if(!isDefined(level.tbl_weaponids)) {
    devgui_create_weapon_levels_table();
  }
  if(!isDefined(level.tbl_weaponids)) {
    return;
  }
  a_weapons = [];
  a_weapons[""] = [];
  a_weapons[""] = [];
  a_weapons[""] = [];
  a_weapons[""] = [];
  a_weapons[""] = [];
  a_weapons[""] = [];
  a_weapons[""] = [];
  a_weapons[""] = [];
  gun_levels_table = devgui_notif_getgunleveltablename();
  foreach(weapon in level.tbl_weaponids) {
    gun = [];
    gun[""] = weapon[""];
    gun[""] = getitemindexfromref(weapon[""]);
    gun[""] = [];
    gun_weapon_attachments = strtok(weapon[""], "");
    foreach(attachment in gun_weapon_attachments) {
      gun[""][attachment] = [];
      gun[""][attachment][""] = getattachmenttableindex(attachment);
      gun[""][attachment][""] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun[""], gunlevel_attachment_unlock_col, attachment, gunlevel_rankid_col);
      gun[""][attachment][""] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun[""], gunlevel_attachment_unlock_col, attachment, gunlevel_xpgained_col);
    }
    switch (weapon[""]) {
      case "": {
        if(weapon[""] != "") {
          arrayinsert(a_weapons[""], gun, 0);
        }
        break;
      }
      case "": {
        arrayinsert(a_weapons[""], gun, 0);
        break;
      }
      case "": {
        arrayinsert(a_weapons[""], gun, 0);
        break;
      }
      case "": {
        arrayinsert(a_weapons[""], gun, 0);
        break;
      }
      case "": {
        arrayinsert(a_weapons[""], gun, 0);
        break;
      }
      case "": {
        arrayinsert(a_weapons[""], gun, 0);
        break;
      }
      case "": {
        arrayinsert(a_weapons[""], gun, 0);
        break;
      }
      case "": {
        arrayinsert(a_weapons[""], gun, 0);
        break;
      }
      default: {
        break;
      }
    }
  }
  foreach(group_name, gun_group in a_weapons) {
    foreach(gun, attachment_group in gun_group) {
      foreach(attachment, attachment_data in attachment_group[""]) {
        devgui_cmd_gun_path = ((((notif_gun_rank_devgui_base + group_name) + "") + gun_group[gun][""]) + "") + attachment;
        adddebugcommand(((((((((((((((((((devgui_cmd_gun_path + "") + "") + "") + "") + "") + attachment_data[""]) + "") + "") + "") + attachment_data[""]) + "") + "") + "") + gun_group[gun][""]) + "") + "") + "") + attachment_data[""]) + "");
      }
    }
    wait(0.05);
  }
  level thread notif_devgui_gun_level_think();
}

function notif_devgui_gun_level_think() {
  for(;;) {
    weapon_item_index = getdvarint("");
    if(weapon_item_index == 0) {
      wait(0.05);
      continue;
    }
    xp_reward = getdvarint("");
    attachment_index = getdvarint("");
    rank_id = getdvarint("");
    level.players[0] persistence::codecallback_gunchallengecomplete(xp_reward, attachment_index, weapon_item_index, rank_id);
    setdvar("", 0);
    setdvar("", 0);
    setdvar("", 0);
    setdvar("", 0);
    wait(1);
  }
}

function notif_devgui_challenges() {
  notif_challenges_devgui_base = "";
  for(i = 1; i <= devgui_notif_getchallengestablecount(); i++) {
    tablename = devgui_notif_getchallengestablename(i);
    rows = tablelookuprowcount(tablename);
    for(j = 1; j < rows; j++) {
      challengeid = tablelookupcolumnforrow(tablename, j, 0);
      if(challengeid != "" && strisint(tablelookupcolumnforrow(tablename, j, 0))) {
        challengestring = tablelookupcolumnforrow(tablename, j, 5);
        type = tablelookupcolumnforrow(tablename, j, 3);
        challengetier = int(tablelookupcolumnforrow(tablename, j, 1));
        challengetierstring = "" + challengetier;
        if(challengetier < 10) {
          challengetierstring = "" + challengetier;
        }
        name = tablelookupcolumnforrow(tablename, j, 5);
        devgui_cmd_challenge_path = (((((notif_challenges_devgui_base + type) + "") + makelocalizedstring(name) + "") + challengetierstring) + "") + challengeid;
        adddebugcommand(((((((((((devgui_cmd_challenge_path + "") + "") + "") + "") + "") + j) + "") + "") + "") + i) + "");
        if((int(challengeid) % 10) == 0) {
          wait(0.05);
        }
      }
    }
  }
  level thread notif_devgui_challenges_think();
}

function notif_devgui_challenges_think() {
  setdvar("", 0);
  setdvar("", 0);
  for(;;) {
    row = getdvarint("");
    table = getdvarint("");
    if(table < 1 || table > devgui_notif_getchallengestablecount()) {
      wait(0.05);
      continue;
    }
    tablename = devgui_notif_getchallengestablename(table);
    if(row < 1 || row > tablelookuprowcount(tablename)) {
      wait(0.05);
      continue;
    }
    type = tablelookupcolumnforrow(tablename, row, 3);
    itemindex = 0;
    if(type == "") {
      type = 0;
    } else {
      if(type == "") {
        itemindex = 4;
        type = 3;
      } else {
        if(type == "") {
          itemindex = 1;
          type = 4;
        } else {
          if(type == "") {
            type = 2;
          } else {
            if(type == "") {
              type = 5;
            } else {
              itemindex = 23;
              type = 1;
            }
          }
        }
      }
    }
    xpreward = int(tablelookupcolumnforrow(tablename, row, 6));
    challengeid = int(tablelookupcolumnforrow(tablename, row, 0));
    maxvalue = int(tablelookupcolumnforrow(tablename, row, 2));
    level.players[0] persistence::codecallback_challengecomplete(xpreward, maxvalue, row, table - 1, type, itemindex, challengeid);
    setdvar("", 0);
    setdvar("", 0);
    wait(1);
  }
}

function popupsfromconsole() {
  while(true) {
    timeout = getdvarfloat("", 1);
    if(timeout == 0) {
      timeout = 1;
    }
    wait(timeout);
    medal = getdvarint("", 0);
    challenge = getdvarint("", 0);
    rank = getdvarint("", 0);
    gun = getdvarint("", 0);
    contractpass = getdvarint("", 0);
    contractfail = getdvarint("", 0);
    gamemodemsg = getdvarint("", 0);
    teammsg = getdvarint("", 0);
    challengeindex = getdvarint("", 1);
    for(i = 0; i < medal; i++) {
      level.players[0] medals::codecallback_medal(86);
    }
    for(i = 0; i < challenge; i++) {
      level.players[0] persistence::codecallback_challengecomplete(1000, 10, 19, 0, 0, 0, 18);
      level.players[0] persistence::codecallback_challengecomplete(1000, 1, 21, 0, 0, 0, 20);
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
      level.players[0] persistence::codecallback_challengecomplete(rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex);
    }
    for(i = 0; i < rank; i++) {
      level.players[0] rank::codecallback_rankup(4, 0, 1);
    }
    for(i = 0; i < gun; i++) {
      level.players[0] persistence::codecallback_gunchallengecomplete(0, 20, 25, 0);
    }
    for(i = 0; i < contractpass; i++) {
      level.players[0] persistence::add_contract_to_queue(12, 1);
    }
    for(i = 0; i < contractfail; i++) {
      level.players[0] persistence::add_contract_to_queue(12, 0);
    }
    for(i = 0; i < teammsg; i++) {
      player = level.players[0];
      if(isDefined(level.players[1])) {
        player = level.players[1];
      }
      level.players[0] displayteammessagetoall(&"", player);
    }
    reset = getdvarint("", 1);
    if(reset) {
      if(medal) {
        setdvar("", 0);
      }
      if(challenge) {
        setdvar("", 0);
      }
      if(gun) {
        setdvar("", 0);
      }
      if(rank) {
        setdvar("", 0);
      }
      if(contractpass) {
        setdvar("", 0);
      }
      if(contractfail) {
        setdvar("", 0);
      }
      if(gamemodemsg) {
        setdvar("", 0);
      }
      if(teammsg) {
        setdvar("", 0);
      }
    }
  }
}

function displaykillstreakteammessagetoall(killstreak, player) {
  if(!isDefined(level.killstreaks[killstreak])) {
    return;
  }
  if(!isDefined(level.killstreaks[killstreak].inboundtext)) {
    return;
  }
  message = level.killstreaks[killstreak].inboundtext;
  self displayteammessagetoall(message, player);
}

function displaykillstreakhackedteammessagetoall(killstreak, player) {
  if(!isDefined(level.killstreaks[killstreak])) {
    return;
  }
  if(!isDefined(level.killstreaks[killstreak].hackedtext)) {
    return;
  }
  message = level.killstreaks[killstreak].hackedtext;
  self displayteammessagetoall(message, player);
}

function shoulddisplayteammessages() {
  if(level.hardcoremode == 1 || level.splitscreen == 1) {
    return false;
  }
  return true;
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
    cur_player.teammessagequeue[size].message = message;
    cur_player.teammessagequeue[size].player = player;
    cur_player notify("hash_f0fa2450");
  }
}

function displayteammessagetoteam(message, player, team) {
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
    cur_player.teammessagequeue[size].message = message;
    cur_player.teammessagequeue[size].player = player;
    cur_player notify("hash_f0fa2450");
  }
}

function displayteammessagewaiter() {
  if(!shoulddisplayteammessages()) {
    return;
  }
  self endon("disconnect");
  level endon("game_ended");
  self.teammessagequeue = [];
  for(;;) {
    if(self.teammessagequeue.size == 0) {
      self waittill("hash_f0fa2450");
    }
    if(self.teammessagequeue.size > 0) {
      nextnotifydata = self.teammessagequeue[0];
      arrayremoveindex(self.teammessagequeue, 0, 0);
      if(!isDefined(nextnotifydata.player) || !isplayer(nextnotifydata.player)) {
        continue;
      }
      if(self isempjammed()) {
        continue;
      }
      self luinotifyevent(&"player_callout", 2, nextnotifydata.message, nextnotifydata.player.entnum);
    }
    wait(level.teammessage.waittime);
  }
}

function displaypopupswaiter() {
  self endon("disconnect");
  self.ranknotifyqueue = [];
  if(!isDefined(self.pers["challengeNotifyQueue"])) {
    self.pers["challengeNotifyQueue"] = [];
  }
  if(!isDefined(self.pers["contractNotifyQueue"])) {
    self.pers["contractNotifyQueue"] = [];
  }
  self.messagenotifyqueue = [];
  self.startmessagenotifyqueue = [];
  self.wagernotifyqueue = [];
  while(isDefined(level) && isDefined(level.gameended) && !level.gameended) {
    if(!isDefined(self) || !isDefined(self.startmessagenotifyqueue) || !isDefined(self.messagenotifyqueue)) {
      break;
    }
    if(self.startmessagenotifyqueue.size == 0 && self.messagenotifyqueue.size == 0) {
      self waittill("hash_2528173");
    }
    waittillframeend();
    if(!isDefined(level)) {
      break;
    }
    if(!isDefined(level.gameended)) {
      break;
    }
    if(level.gameended) {
      break;
    }
    if(self.startmessagenotifyqueue.size > 0) {
      nextnotifydata = self.startmessagenotifyqueue[0];
      arrayremoveindex(self.startmessagenotifyqueue, 0, 0);
      if(isDefined(nextnotifydata.duration)) {
        duration = nextnotifydata.duration;
      } else {
        duration = level.startmessagedefaultduration;
      }
      self hud_message::shownotifymessage(nextnotifydata, duration);
      wait(duration);
    } else {
      if(self.messagenotifyqueue.size > 0) {
        nextnotifydata = self.messagenotifyqueue[0];
        arrayremoveindex(self.messagenotifyqueue, 0, 0);
        if(isDefined(nextnotifydata.duration)) {
          duration = nextnotifydata.duration;
        } else {
          duration = level.regulargamemessages.waittime;
        }
        self hud_message::shownotifymessage(nextnotifydata, duration);
      } else {
        wait(1);
      }
    }
  }
}

function milestonenotify(index, itemindex, type, tier) {
  level.globalchallenges++;
  if(!isDefined(type)) {
    type = "global";
  }
  size = self.pers["challengeNotifyQueue"].size;
  self.pers["challengeNotifyQueue"][size] = [];
  self.pers["challengeNotifyQueue"][size]["tier"] = tier;
  self.pers["challengeNotifyQueue"][size]["index"] = index;
  self.pers["challengeNotifyQueue"][size]["itemIndex"] = itemindex;
  self.pers["challengeNotifyQueue"][size]["type"] = type;
  self notify("hash_2528173");
}