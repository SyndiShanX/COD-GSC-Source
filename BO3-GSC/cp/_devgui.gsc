/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_devgui.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_accolades;
#using scripts\cp\_challenges;
#using scripts\cp\_decorations;
#using scripts\cp\_laststand;
#using scripts\cp\_skipto;
#using scripts\cp\gametypes\_save;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\dev_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\load_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons_shared;
#namespace devgui;

function autoexec __init__sytem__() {
  system::register("", &__init__, undefined, undefined);
}

function __init__() {
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  setdvar("", 0);
  setdvar("", "");
  setdvar("", 0);
  setdvar("", 0);
  setdvar("", "");
  thread devgui_think();
  thread devgui_weapon_think();
  thread devgui_weapon_asset_name_display_think();
  thread devgui_test_chart_think();
  thread init_debug_center_screen();
  level thread dev::body_customization_devgui(2);
  callback::on_start_gametype(&devgui_player_commands);
  callback::on_connect(&devgui_player_connect);
  callback::on_disconnect(&devgui_player_disconnect);
}

function devgui_player_commands() {
  level flag::wait_till("");
  rootclear = "";
  adddebugcommand(rootclear);
  players = getplayers();
  foreach(player in getplayers()) {
    rootclear = ("" + player.playername) + "";
    adddebugcommand(rootclear);
  }
  thread devgui_player_weapons();
  level.player_devgui_base = "";
  devgui_add_player_commands(level.player_devgui_base, "", 0);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    ip1 = i + 1;
    devgui_add_player_commands(level.player_devgui_base, players[i].playername, ip1);
  }
}

function devgui_player_connect() {
  if(!isDefined(level.player_devgui_base)) {
    return;
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i] != self) {
      continue;
    }
    devgui_add_player_commands(level.player_devgui_base, players[i].playername, i + 1);
  }
}

function devgui_player_disconnect() {
  if(!isDefined(level.player_devgui_base)) {
    return;
  }
  rootclear = ("" + self.playername) + "";
  util::add_queued_debug_command(rootclear);
}

function devgui_add_player_commands(root, pname, index) {
  player_devgui_root = (root + pname) + "";
  pid = "" + index;
  devgui_add_player_command(player_devgui_root, pid, "", 1, "");
  devgui_add_player_command(player_devgui_root, pid, "", 2, "");
  devgui_add_player_command(player_devgui_root, pid, "", 3, "");
  devgui_add_player_command(player_devgui_root, pid, "", 4, "");
  devgui_add_player_command(player_devgui_root, pid, "", 5, "");
  devgui_add_player_command(player_devgui_root, pid, "", 6, "");
  devgui_add_player_command(player_devgui_root, pid, "", 7, "");
  devgui_add_player_command(player_devgui_root, pid, "", 8, "");
  devgui_add_player_command(player_devgui_root, pid, "", 9, "");
  devgui_add_player_command(player_devgui_root, pid, "", 10, "");
  devgui_add_player_command(player_devgui_root, pid, "", 11, "");
  devgui_add_player_command(player_devgui_root, pid, "", 12, "");
  devgui_add_player_command(player_devgui_root, pid, "", 13, "");
  devgui_add_player_command(player_devgui_root, pid, "", 14, "");
  devgui_add_player_command(player_devgui_root, pid, "", 15, "");
  devgui_add_player_command(player_devgui_root, pid, "", 16, "");
  devgui_add_player_command(player_devgui_root, pid, "", 17, "");
  devgui_add_player_command(player_devgui_root, pid, "", 18, "");
  devgui_add_player_command(player_devgui_root, pid, "", 19, "");
  devgui_add_player_command(player_devgui_root, pid, "", 20, "");
  devgui_add_player_command(player_devgui_root, pid, "", 21, "");
  devgui_add_player_command(player_devgui_root, pid, "", 22, "");
  devgui_add_player_command(player_devgui_root, pid, "", 23, "");
  devgui_add_player_command(player_devgui_root, pid, "", 24, "");
  devgui_add_player_command(player_devgui_root, pid, "", 25, "");
  devgui_add_player_command(player_devgui_root, pid, "", 26, "");
  devgui_add_player_command(player_devgui_root, pid, "", 27, "");
  devgui_add_player_command(player_devgui_root, pid, "", 28, "");
  devgui_add_player_command(player_devgui_root, pid, "", 29, "");
  devgui_add_player_command(player_devgui_root, pid, "", 30, "");
  devgui_add_player_command(player_devgui_root, pid, "", 31, "");
  devgui_add_player_command(player_devgui_root, pid, "", 32, "");
  devgui_add_player_command(player_devgui_root, pid, "", 33, "");
}

function devgui_add_player_command(root, pid, cmdname, cmdindex, cmddvar) {
  adddebugcommand((((((((((root + cmdname) + "") + "") + "") + pid) + "") + "") + "") + cmddvar) + "");
}

function devgui_handle_player_command(cmd, playercallback, pcb_param) {
  pid = getdvarint("");
  if(pid > 0) {
    player = getplayers()[pid - 1];
    if(isDefined(player)) {
      if(isDefined(pcb_param)) {
        player thread[[playercallback]](pcb_param);
      } else {
        player thread[[playercallback]]();
      }
    }
  } else {
    array::thread_all(getplayers(), playercallback, pcb_param);
  }
  setdvar("", "");
}

function devgui_think() {
  for(;;) {
    cmd = getdvarstring("");
    if(cmd == "") {
      wait(0.05);
      continue;
    }
    switch (cmd) {
      case "": {
        devgui_handle_player_command(cmd, &devgui_give_health);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &devgui_toggle_ammo);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &devgui_toggle_ignore);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &devgui_invulnerable, 1);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &devgui_invulnerable, 0);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &devgui_kill);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &devgui_revive);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &devgui_toggle_infinitesolo);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_cac73614, 100);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_cac73614, 1000);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_9f78d70e, 100);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_9f78d70e, 1000);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_d7b26538);
      }
      case "": {
        devgui_handle_player_command(cmd, &function_fcd3cf3f);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_192ef5eb);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 0);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 1);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 2);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 3);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 4);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 5);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 6);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 7);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 8);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 9);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_b79fb0fe, 10);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_f61fdbaf);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_408729cd);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_4edb34ed);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_4533d882);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_cac73614, 1000000);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_e2643869);
        break;
      }
      case "": {
        devgui_handle_player_command(cmd, &function_9c35ef50, "");
      }
      case "": {
        break;
      }
      default: {
        if(isDefined(level.custom_devgui)) {
          if(isarray(level.custom_devgui)) {
            foreach(devgui in level.custom_devgui) {
              if(isDefined([
                  [devgui]
                ](cmd)) && [
                  [devgui]
                ](cmd)) {
                break;
              }
            }
          } else {
            [
              [level.custom_devgui]
            ](cmd);
          }
        }
        break;
      }
    }
    setdvar("", "");
    wait(0.5);
  }
}

function function_9c35ef50(stat_name) {
  self challenges::function_96ed590f(stat_name, 50);
}

function function_e2643869() {
  var_c02de660 = skipto::function_23eda99c();
  foreach(mission in var_c02de660) {
    self addplayerstat("" + getsubstr(getmissionname(mission), 0, 3), 1);
  }
}

function function_4533d882() {
  for(itemindex = 1; itemindex < 76; itemindex++) {
    self setdstat("", itemindex, "", "", "", 999);
  }
}

function function_4edb34ed() {
  for(itemindex = 1; itemindex < 76; itemindex++) {
    self setdstat("", itemindex, "", 1000000);
  }
}

function function_408729cd() {
  if(!isDefined(getrootmapname())) {
    return;
  }
  foreach(mission in skipto::function_23eda99c()) {
    self setdstat("", mission, "", 4, 1);
  }
}

function function_192ef5eb() {
  if(isDefined(self.var_f0080358) && self.var_f0080358) {
    self closeluimenu(self.var_f0080358);
  }
  self.var_f0080358 = self openluimenu("");
  self waittill("menuresponse", menu, response);
  while(response != "") {
    self waittill("menuresponse", menu, response);
  }
  self closeluimenu(self.var_f0080358);
}

function function_b79fb0fe(var_b931f6fe) {
  a_decorations = self getdecorations();
  self givedecoration(a_decorations[var_b931f6fe].name);
  uploadstats(self);
}

function function_f61fdbaf() {
  var_c02de660 = skipto::function_23eda99c();
  foreach(mission_name in var_c02de660) {
    self setdstat("", mission_name, "", 1);
  }
}

function function_d7b26538() {
  var_c02de660 = skipto::function_23eda99c();
  foreach(mission in var_c02de660) {
    for(i = 0; i < 10; i++) {
      self setdstat("", mission, "", i, 1);
    }
  }
}

function function_fcd3cf3f() {
  var_c02de660 = skipto::function_23eda99c();
  foreach(mission_name in var_c02de660) {
    self setdstat("", mission_name, "", 1);
  }
}

function function_cac73614(var_735c65d7) {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  self addrankxpvalue("", var_735c65d7);
}

function function_9f78d70e(var_735c65d7) {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  weaponnum = int(tablelookup("", 3, self.currentweapon.rootweapon.displayname, 0));
  var_b51b0d94 = self getdstat("", weaponnum, "");
  self setdstat("", weaponnum, "", var_735c65d7 + var_b51b0d94);
}

function devgui_invulnerable(onoff) {
  if(onoff) {
    self enableinvulnerability();
  } else {
    self disableinvulnerability();
  }
}

function devgui_kill() {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  if(isalive(self)) {
    self disableinvulnerability();
    death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
    self dodamage(self.health + 666, self.origin + death_from);
  }
}

function devgui_toggle_ammo() {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self notify("devgui_toggle_ammo");
  self endon("devgui_toggle_ammo");
  self.ammo4evah = !(isDefined(self.ammo4evah) && self.ammo4evah);
  while(isDefined(self) && self.ammo4evah) {
    weapon = self getcurrentweapon();
    if(weapon != level.weaponnone) {
      self setweaponoverheating(0, 0);
      max = weapon.maxammo;
      if(isDefined(max)) {
        self setweaponammostock(weapon, max);
      }
    }
    wait(1);
  }
}

function devgui_toggle_ignore() {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self.ignoreme = !self.ignoreme;
}

function devgui_toggle_infinitesolo() {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self.infinite_solo_revives = !self.infinite_solo_revives;
}

function devgui_revive() {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self reviveplayer();
  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
    self.revivetrigger = undefined;
  }
  self laststand::cleanup_suicide_hud();
  self laststand::laststand_enable_player_weapons();
  self allowjump(1);
  self.ignoreme = 0;
  self disableinvulnerability();
  self.laststand = undefined;
  self notify("player_revived", self);
}

function maintain_maxhealth(maxhealth) {
  self endon("disconnect");
  self endon("devgui_give_health");
  while(true) {
    wait(1);
    if(self.maxhealth != maxhealth) {
      self.maxhealth = maxhealth;
      self.health = self.maxhealth;
    }
  }
}

function devgui_give_health() {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self notify("devgui_give_health");
  if(self.maxhealth >= 2000 && isDefined(self.orgmaxhealth)) {
    self.maxhealth = self.orgmaxhealth;
  } else {
    self.orgmaxhealth = self.maxhealth;
    self.maxhealth = 2000;
    self thread maintain_maxhealth(self.maxhealth);
  }
  self.health = self.maxhealth;
}

function devgui_player_weapons() {
  if(isDefined(game[""]) && game[""]) {
    return;
  }
  level flag::wait_till("");
  wait(0.1);
  a_weapons = enumerateweapons("");
  a_weapons_cp = [];
  a_grenades_cp = [];
  a_misc_cp = [];
  for(i = 0; i < a_weapons.size; i++) {
    if(weapons::is_primary_weapon(a_weapons[i]) || weapons::is_side_arm(a_weapons[i])) {
      arrayinsert(a_weapons_cp, a_weapons[i], 0);
      continue;
    }
    if(weapons::is_grenade(a_weapons[i])) {
      arrayinsert(a_grenades_cp, a_weapons[i], 0);
      continue;
    }
    arrayinsert(a_misc_cp, a_weapons[i], 0);
  }
  player_devgui_base_cp = "";
  adddebugcommand((((player_devgui_base_cp + "") + "") + "") + "");
  adddebugcommand((((player_devgui_base_cp + "") + "") + "") + "");
  adddebugcommand((((player_devgui_base_cp + "") + "") + "") + "");
  devgui_add_player_weapons(player_devgui_base_cp, "", 0, a_grenades_cp, "");
  devgui_add_player_weapons(player_devgui_base_cp, "", 0, a_weapons_cp, "");
  devgui_add_player_weapons(player_devgui_base_cp, "", 0, a_misc_cp, "");
  devgui_add_player_gun_attachments(player_devgui_base_cp, "", 0, a_weapons_cp, "");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    ip1 = i + 1;
    adddebugcommand((((player_devgui_base_cp + players[i].playername) + "") + "") + "");
    adddebugcommand((((player_devgui_base_cp + players[i].playername) + "") + "") + "");
    adddebugcommand((((player_devgui_base_cp + players[i].playername) + "") + "") + "");
    devgui_add_player_weapons(player_devgui_base_cp, players[i].playername, ip1, a_grenades_cp, "");
    devgui_add_player_weapons(player_devgui_base_cp, players[i].playername, ip1, a_weapons_cp, "");
    devgui_add_player_weapons(player_devgui_base_cp, players[i].playername, ip1, a_misc_cp, "");
    devgui_add_player_gun_attachments(player_devgui_base_cp, players[i].playername, ip1, a_weapons_cp, "");
  }
  game[""] = 1;
}

function devgui_add_player_gun_attachments(root, pname, index, a_weapons, weapon_type) {
  player_devgui_root = ((((root + pname) + "") + "") + weapon_type) + "";
  attachments = [];
  foreach(weapon in a_weapons) {
    foreach(supportedattachment in weapon.supportedattachments) {
      array::add(attachments, supportedattachment, 0);
    }
  }
  pid = "" + index;
  foreach(att in attachments) {
    devgui_add_player_attachment_command(player_devgui_root, pid, att, 1);
  }
}

function devgui_add_player_weapons(root, pname, index, a_weapons, weapon_type) {
  player_devgui_root = ((((root + pname) + "") + "") + weapon_type) + "";
  pid = "" + index;
  if(isDefined(a_weapons)) {
    for(i = 0; i < a_weapons.size; i++) {
      if(weapon_type == "") {
        attachments = [];
      } else {
        attachments = a_weapons[i].supportedattachments;
      }
      name = a_weapons[i].name;
      if(attachments.size) {
        devgui_add_player_weap_command((player_devgui_root + name) + "", pid, name, i + 1);
        foreach(att in attachments) {
          if(att != "") {
            devgui_add_player_weap_command((player_devgui_root + name) + "", pid, (name + "") + att, i + 1);
          }
        }
      } else {
        devgui_add_player_weap_command(player_devgui_root, pid, name, i + 1);
      }
      wait(0.05);
    }
  }
}

function devgui_add_player_weap_command(root, pid, weap_name, cmdindex) {
  adddebugcommand((((((((((root + weap_name) + "") + "") + "") + pid) + "") + "") + "") + weap_name) + "");
}

function devgui_add_player_attachment_command(root, pid, attachment_name, cmdindex) {
  adddebugcommand((((((((((root + attachment_name) + "") + "") + "") + pid) + "") + "") + "") + attachment_name) + "");
}

function devgui_weapon_think() {
  for(;;) {
    weapon_name = getdvarstring("");
    if(weapon_name != "") {
      devgui_handle_player_command(weapon_name, &devgui_give_weapon, weapon_name);
      setdvar("", "");
    }
    attachmentname = getdvarstring("");
    if(attachmentname != "") {
      devgui_handle_player_command(attachmentname, &devgui_give_attachment, attachmentname);
      setdvar("", "");
    }
    wait(0.5);
  }
}

function devgui_weapon_asset_name_display_think() {
  update_time = 0.5;
  print_duration = int(update_time / 0.05);
  printlnbold_update = int(1 / update_time);
  printlnbold_counter = 0;
  colors = [];
  colors[colors.size] = (1, 1, 1);
  colors[colors.size] = (1, 0, 0);
  colors[colors.size] = (0, 1, 0);
  colors[colors.size] = (1, 1, 0);
  colors[colors.size] = (1, 0, 1);
  colors[colors.size] = (0, 1, 1);
  for(;;) {
    wait(update_time);
    display = getdvarint("");
    if(!display) {
      continue;
    }
    if(!printlnbold_counter) {
      iprintlnbold(level.players[0] getcurrentweapon().name);
    }
    printlnbold_counter++;
    if(printlnbold_counter >= printlnbold_update) {
      printlnbold_counter = 0;
    }
    color_index = 0;
    for(i = 1; i < level.players.size; i++) {
      player = level.players[i];
      weapon = player getcurrentweapon();
      if(!isDefined(weapon) || level.weaponnone == weapon) {
        continue;
      }
      print3d(player gettagorigin(""), weapon.name, colors[color_index], 1, 0.15, print_duration);
      color_index++;
      if(color_index >= colors.size) {
        color_index = 0;
      }
    }
    color_index = 0;
    ai_list = getaiarray();
    for(i = 0; i < ai_list.size; i++) {
      ai = ai_list[i];
      if(isvehicle(ai)) {
        weapon = ai.turretweapon;
      } else {
        weapon = ai.weapon;
      }
      if(!isDefined(weapon) || level.weaponnone == weapon) {
        continue;
      }
      print3d(ai gettagorigin(""), weapon.name, colors[color_index], 1, 0.15, print_duration);
      color_index++;
      if(color_index >= colors.size) {
        color_index = 0;
      }
    }
  }
}

function devgui_test_chart_think() {
  wait(0.05);
  old_val = getdvarint("");
  for(;;) {
    val = getdvarint("");
    if(old_val != val) {
      if(isDefined(level.test_chart_model)) {
        level.test_chart_model delete();
        level.test_chart_model = undefined;
      }
      if(val) {
        player = getplayers()[0];
        direction = player getplayerangles();
        direction_vec = anglesToForward((0, direction[1], 0));
        scale = 120;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        level.test_chart_model = spawn("", player getEye() + direction_vec);
        level.test_chart_model setModel("");
        level.test_chart_model.angles = (0, direction[1], 0) + vectorscale((0, 1, 0), 90);
      }
    }
    old_val = val;
    wait(0.05);
  }
}

function devgui_give_weapon(weapon_name) {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self notify("devgui_give_ammo");
  self endon("devgui_give_ammo");
  currentweapon = self getcurrentweapon();
  split = strtok(weapon_name, "");
  switch (split.size) {
    case 1:
    default: {
      weapon = getweapon(split[0]);
      break;
    }
    case 2: {
      weapon = getweapon(split[0], split[1]);
      break;
    }
    case 3: {
      weapon = getweapon(split[0], split[1], split[2]);
      break;
    }
    case 4: {
      weapon = getweapon(split[0], split[1], split[2], split[3]);
      break;
    }
    case 5: {
      weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
      break;
    }
  }
  if(currentweapon != weapon) {
    if(getdvarint("")) {
      adddebugcommand("" + weapon_name);
      wait(0.05);
    } else {
      self takeweapon(currentweapon);
      self giveweapon(weapon);
      self switchtoweapon(weapon);
    }
    max = weapon.maxammo;
    if(max) {
      self setweaponammostock(weapon, max);
    }
  }
}

function devgui_give_attachment(attachment_name) {
  /
  #
  assert(isDefined(self));
  assert(isplayer(self));
  assert(isalive(self));
  self notify("devgui_give_attachment");
  self endon("devgui_give_attachment");
  currentweapon = self getcurrentweapon();
  attachmentsupported = 0;
  split = strtok(currentweapon.name, "");
  foreach(attachment in currentweapon.supportedattachments) {
    if(attachment == attachment_name) {
      attachmentsupported = 1;
    }
  }
  if(attachmentsupported == 0) {
    iprintlnbold((("" + attachment_name) + "") + split[0]);
    attachmentsstring = "";
    if(currentweapon.supportedattachments.size == 0) {
      attachmentsstring = attachmentsstring + "";
    }
    foreach(attachment in currentweapon.supportedattachments) {
      attachmentsstring = attachmentsstring + ("" + attachment);
    }
    iprintlnbold(attachmentsstring);
    return;
  }
  foreach(currentattachment in split) {
    if(currentattachment == attachment_name) {
      iprintlnbold((("" + attachment_name) + "") + currentweapon.name);
      return;
    }
  }
  split[split.size] = attachment_name;
  for(index = split.size; index < 9; index++) {
    split[index] = "";
  }
  self takeweapon(currentweapon);
  newweapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6], split[7], split[8]);
  self giveweapon(newweapon);
  self switchtoweapon(newweapon);
}

function init_debug_center_screen() {
  zero_idle_movement = "";
  for(;;) {
    if(getdvarint("")) {
      if(!isDefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0) {
        thread debug_center_screen();
        zero_idle_movement = getdvarstring("");
        if(isDefined(zero_idle_movement) && zero_idle_movement == "") {
          setdvar("", "");
          zero_idle_movement = "";
        }
      }
    } else {
      level notify("hash_8e42baed");
      if(zero_idle_movement == "") {
        setdvar("", "");
        zero_idle_movement = "";
      }
    }
    wait(0.05);
  }
}

function debug_center_screen() {
  level.center_screen_debug_hudelem_active = 1;
  wait(0.1);
  level.center_screen_debug_hudelem1 = newclienthudelem(level.players[0]);
  level.center_screen_debug_hudelem1.alignx = "";
  level.center_screen_debug_hudelem1.aligny = "";
  level.center_screen_debug_hudelem1.fontscale = 1;
  level.center_screen_debug_hudelem1.alpha = 0.5;
  level.center_screen_debug_hudelem1.x = 320 - 1;
  level.center_screen_debug_hudelem1.y = 240;
  level.center_screen_debug_hudelem1 setshader("", 1000, 1);
  level.center_screen_debug_hudelem2 = newclienthudelem(level.players[0]);
  level.center_screen_debug_hudelem2.alignx = "";
  level.center_screen_debug_hudelem2.aligny = "";
  level.center_screen_debug_hudelem2.fontscale = 1;
  level.center_screen_debug_hudelem2.alpha = 0.5;
  level.center_screen_debug_hudelem2.x = 320 - 1;
  level.center_screen_debug_hudelem2.y = 240;
  level.center_screen_debug_hudelem2 setshader("", 1, 480);
  level waittill("hash_8e42baed");
  level.center_screen_debug_hudelem1 destroy();
  level.center_screen_debug_hudelem2 destroy();
  level.center_screen_debug_hudelem_active = 0;
}