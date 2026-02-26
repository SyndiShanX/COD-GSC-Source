/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\dev_class.gsc
***********************************************/

#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\dev;
#namespace dev_class;

function dev_cac_init() {
  dev_cac_overlay = 0;
  dev_cac_camera_on = 0;
  level thread dev_cac_gdt_update_think();

  for(;;) {
    wait 0.5;
    reset = 1;

    if(getdvarstring(#"scr_disable_cac_2") != "<dev string:x38>") {
      continue;
    }

    host = util::gethostplayer();

    if(!isDefined(level.dev_cac_player)) {
      level.dev_cac_player = host;
    }

    switch (getdvarstring(#"devgui_dev_cac")) {
      case 0:
        reset = 0;
        break;
      case # "dpad_body":
        host thread dev_cac_dpad_think("<dev string:x3c>", &dev_cac_cycle_body, "<dev string:x38>");
        break;
      case # "dpad_head":
        host thread dev_cac_dpad_think("<dev string:x44>", &dev_cac_cycle_head, "<dev string:x38>");
        break;
      case # "dpad_character":
        host thread dev_cac_dpad_think("<dev string:x4c>", &dev_cac_cycle_character, "<dev string:x38>");
        break;
      case # "next_player":
        dev_cac_cycle_player(1);
        break;
      case # "prev_player":
        dev_cac_cycle_player(0);
        break;
      case # "cac_overlay":
        level notify(#"dev_cac_overlay_think");

        if(!dev_cac_overlay) {
          level thread dev_cac_overlay_think();
        }

        dev_cac_overlay = !dev_cac_overlay;
        break;
      case # "best_bullet_armor":
        dev_cac_set_model_range(&sort_greatest, "<dev string:x59>");
        break;
      case # "worst_bullet_armor":
        dev_cac_set_model_range(&sort_least, "<dev string:x59>");
        break;
      case # "best_explosive_armor":
        dev_cac_set_model_range(&sort_greatest, "<dev string:x69>");
        break;
      case # "worst_explosive_armor":
        dev_cac_set_model_range(&sort_least, "<dev string:x69>");
        break;
      case # "best_mobility":
        dev_cac_set_model_range(&sort_greatest, "<dev string:x7c>");
        break;
      case # "worst_mobility":
        dev_cac_set_model_range(&sort_least, "<dev string:x7c>");
        break;
      case # "camera":
        dev_cac_camera_on = !dev_cac_camera_on;
        dev_cac_camera(dev_cac_camera_on);
        break;
      case # "dpad_camo":
        host thread dev_cac_dpad_think("<dev string:x88>", &dev_cac_cycle_render_options, "<dev string:x88>");
        break;
      case # "dpad_meleecamo":
        host thread dev_cac_dpad_think("<dev string:x90>", &dev_cac_cycle_render_options, "<dev string:x90>");
        break;
      case # "dpad_lens":
        host thread dev_cac_dpad_think("<dev string:x9d>", &dev_cac_cycle_render_options, "<dev string:x9d>");
        break;
      case # "dpad_reticle":
        host thread dev_cac_dpad_think("<dev string:xa5>", &dev_cac_cycle_render_options, "<dev string:xa5>");
        break;
      case # "hash_175b7e6688ef31a6":
        host thread dev_cac_dpad_think("<dev string:xb0>", &dev_cac_cycle_render_options, "<dev string:xc6>");
        break;
      case # "hash_4293810c7550f275":
        host thread dev_cac_dpad_think("<dev string:xdc>", &dev_cac_cycle_render_options, "<dev string:xf0>");
        break;
      case # "hash_69d8a058583621e4":
        host thread dev_cac_dpad_think("<dev string:x104>", &dev_cac_cycle_render_options, "<dev string:x11e>");
        break;
      case # "hash_69d8a15858362397":
        host thread dev_cac_dpad_think("<dev string:x137>", &dev_cac_cycle_render_options, "<dev string:x151>");
        break;
      case # "hash_69d8a2585836254a":
        host thread dev_cac_dpad_think("<dev string:x16a>", &dev_cac_cycle_render_options, "<dev string:x184>");
        break;
      case # "hash_69d8a358583626fd":
        host thread dev_cac_dpad_think("<dev string:x19d>", &dev_cac_cycle_render_options, "<dev string:x1b7>");
        break;
      case # "hash_69d89c5858361b18":
        host thread dev_cac_dpad_think("<dev string:x1d0>", &dev_cac_cycle_render_options, "<dev string:x1ea>");
        break;
      case # "hash_69d89d5858361ccb":
        host thread dev_cac_dpad_think("<dev string:x203>", &dev_cac_cycle_render_options, "<dev string:x21d>");
        break;
      case # "hash_69d89e5858361e7e":
        host thread dev_cac_dpad_think("<dev string:x236>", &dev_cac_cycle_render_options, "<dev string:x250>");
        break;
      case # "hash_69d89f5858362031":
        host thread dev_cac_dpad_think("<dev string:x269>", &dev_cac_cycle_render_options, "<dev string:x283>");
        break;
      case # "hash_6197bff71b874ed0":
        host thread dev_cac_dpad_think("<dev string:x29c>", &dev_cac_cycle_render_options, "<dev string:x2a9>");
        break;
      case # "hash_6197c0f71b875083":
        host thread dev_cac_dpad_think("<dev string:x2b5>", &dev_cac_cycle_render_options, "<dev string:x2c2>");
        break;
      case # "hash_6197c1f71b875236":
        host thread dev_cac_dpad_think("<dev string:x2ce>", &dev_cac_cycle_render_options, "<dev string:x2db>");
        break;
      case # "hash_6197c2f71b8753e9":
        host thread dev_cac_dpad_think("<dev string:x2e7>", &dev_cac_cycle_render_options, "<dev string:x2f4>");
        break;
      case # "dpad_reticle_color":
        host thread dev_cac_dpad_think("<dev string:x300>", &dev_cac_cycle_render_options, "<dev string:x311>");
        break;
      case # "dpad_facepaint_pattern":
        host thread dev_cac_dpad_think("<dev string:x322>", &dev_cac_cycle_render_options, "<dev string:x337>");
        break;
      case # "dpad_facepaint_color":
        host thread dev_cac_dpad_think("<dev string:x34c>", &dev_cac_cycle_render_options, "<dev string:x35f>");
        break;
      case # "dpad_reset":
        host notify(#"dev_cac_dpad_think");
        break;
    }

    if(reset) {
      setDvar(#"devgui_dev_cac", "<dev string:x38>");
    }
  }
}

function dev_cac_camera(on) {
  if(on) {
    self setclientthirdperson(1);
    setDvar(#"cg_thirdpersonangle", 185);
    setDvar(#"cg_thirdpersonrange", 138);
    setDvar(#"cg_fov", 20);
    return;
  }

  self setclientthirdperson(0);
  setDvar(#"cg_fov", getdvarstring(#"cg_fov_default"));
}

function dev_cac_dpad_think(part_name, cycle_function, tag) {
  self notify(#"dev_cac_dpad_think");
  self endon(#"dev_cac_dpad_think", #"disconnect");
  iprintln("<dev string:x372>" + part_name + "<dev string:x37f>");
  iprintln("<dev string:x397>" + part_name + "<dev string:x3a0>");
  dpad_left = 0;
  dpad_right = 0;
  level.dev_cac_player thread highlight_player();

  for(;;) {
    self setactionslot(3, "<dev string:x38>");
    self setactionslot(4, "<dev string:x38>");

    if(!dpad_left && self buttonPressed("<dev string:x3b9>")) {
      [[cycle_function]](0, tag);
      dpad_left = 1;
    } else if(!self buttonPressed("<dev string:x3b9>")) {
      dpad_left = 0;
    }

    if(!dpad_right && self buttonPressed("<dev string:x3c6>")) {
      [[cycle_function]](1, tag);
      dpad_right = 1;
    } else if(!self buttonPressed("<dev string:x3c6>")) {
      dpad_right = 0;
    }

    waitframe(1);
  }
}

function next_in_list(value, list) {
  if(!isDefined(value)) {
    return list[0];
  }

  for(i = 0; i < list.size; i++) {
    if(value == list[i]) {
      if(isDefined(list[i + 1])) {
        value = list[i + 1];
      } else {
        value = list[0];
      }

      break;
    }
  }

  return value;
}

function prev_in_list(value, list) {
  if(!isDefined(value)) {
    return list[0];
  }

  for(i = 0; i < list.size; i++) {
    if(value == list[i]) {
      if(isDefined(list[i - 1])) {
        value = list[i - 1];
      } else {
        value = list[list.size - 1];
      }

      break;
    }
  }

  return value;
}

function dev_cac_set_player_model() {
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
}

function dev_cac_cycle_body(forward, tag) {
  if(!dev_cac_player_valid()) {
    return;
  }

  player = level.dev_cac_player;
  keys = getarraykeys(level.cac_functions[#"set_body_model"]);

  if(tag) {
    player.cac_body_type = next_in_list(player.cac_body_type, keys);
  } else {
    player.cac_body_type = prev_in_list(player.cac_body_type, keys);
  }

  player dev_cac_set_player_model();
}

function dev_cac_cycle_head(forward, tag) {
  if(!dev_cac_player_valid()) {
    return;
  }

  player = level.dev_cac_player;
  keys = getarraykeys(level.cac_functions[#"set_head_model"]);

  if(tag) {
    player.cac_head_type = next_in_list(player.cac_head_type, keys);
  } else {
    player.cac_head_type = prev_in_list(player.cac_head_type, keys);
  }

  player.cac_hat_type = "<dev string:x3d4>";
  player dev_cac_set_player_model();
}

function dev_cac_cycle_character(forward, tag) {
  if(!dev_cac_player_valid()) {
    return;
  }

  player = level.dev_cac_player;
  keys = getarraykeys(level.cac_functions[#"set_body_model"]);

  if(tag) {
    player.cac_body_type = next_in_list(player.cac_body_type, keys);
  } else {
    player.cac_body_type = prev_in_list(player.cac_body_type, keys);
  }

  player.cac_hat_type = "<dev string:x3d4>";
  player dev_cac_set_player_model();
}

function dev_cac_cycle_render_options(forward, tag, count) {
  if(!dev_cac_player_valid()) {
    return;
  }

  level.dev_cac_player function_fda57e3c(tag, forward, count);
}

function dev_cac_player_valid() {
  return isDefined(level.dev_cac_player) && level.dev_cac_player.sessionstate == "<dev string:x3dc>";
}

function dev_cac_cycle_player(forward) {
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    if(forward) {
      level.dev_cac_player = next_in_list(level.dev_cac_player, players);
    } else {
      level.dev_cac_player = prev_in_list(level.dev_cac_player, players);
    }

    if(dev_cac_player_valid()) {
      level.dev_cac_player thread highlight_player();
      return;
    }
  }

  level.dev_cac_player = undefined;
}

function highlight_player() {
  self sethighlighted(1);
  wait 1;
  self sethighlighted(0);
}

function dev_cac_overlay_think() {
  hud = dev_cac_overlay_create();
  level thread dev_cac_overlay_update(hud);
  level waittill(#"dev_cac_overlay_think");
  dev_cac_overlay_destroy(hud);
}

function dev_cac_overlay_update(hud) {}

function dev_cac_overlay_destroy(hud) {
  for(i = 0; i < hud.menu.size; i++) {
    hud.menu[i] destroy();
  }

  hud destroy();
  setDvar(#"player_debugsprint", 0);
}

function dev_cac_overlay_create() {
  x = -80;
  y = 140;
  menu_name = "<dev string:x3e7>";
  hud = dev::new_hud(menu_name, undefined, x, y, 1);
  hud setshader(#"white", 185, 285);
  hud.alignx = "<dev string:x3f8>";
  hud.aligny = "<dev string:x400>";
  hud.sort = 10;
  hud.alpha = 0.6;
  hud.color = (0, 0, 0.5);
  x_offset = 100;
  hud.menu[0] = dev::new_hud(menu_name, "<dev string:x407>", x + 5, y + 10, 1.3);
  hud.menu[1] = dev::new_hud(menu_name, "<dev string:x40f>", x + 5, y + 25, 1);
  hud.menu[2] = dev::new_hud(menu_name, "<dev string:x419>", x + 5, y + 35, 1);
  hud.menu[3] = dev::new_hud(menu_name, "<dev string:x424>", x + 5, y + 45, 1);
  hud.menu[4] = dev::new_hud(menu_name, "<dev string:x42f>", x + 5, y + 55, 1);
  hud.menu[5] = dev::new_hud(menu_name, "<dev string:x43f>", x + 5, y + 70, 1);
  hud.menu[6] = dev::new_hud(menu_name, "<dev string:x419>", x + 5, y + 80, 1);
  hud.menu[7] = dev::new_hud(menu_name, "<dev string:x42f>", x + 5, y + 90, 1);
  hud.menu[8] = dev::new_hud(menu_name, "<dev string:x44b>", x + 5, y + 100, 1);
  hud.menu[9] = dev::new_hud(menu_name, "<dev string:x45d>", x + 5, y + 110, 1);
  hud.menu[10] = dev::new_hud(menu_name, "<dev string:x473>", x + 5, y + 120, 1);
  hud.menu[11] = dev::new_hud(menu_name, "<dev string:x489>", x + 5, y + 135, 1);
  hud.menu[12] = dev::new_hud(menu_name, "<dev string:x419>", x + 5, y + 145, 1);
  hud.menu[13] = dev::new_hud(menu_name, "<dev string:x42f>", x + 5, y + 155, 1);
  hud.menu[14] = dev::new_hud(menu_name, "<dev string:x49b>", x + 5, y + 170, 1);
  hud.menu[15] = dev::new_hud(menu_name, "<dev string:x419>", x + 5, y + 180, 1);
  hud.menu[16] = dev::new_hud(menu_name, "<dev string:x42f>", x + 5, y + 190, 1);
  hud.menu[17] = dev::new_hud(menu_name, "<dev string:x4b0>", x + 5, y + 205, 1);
  hud.menu[18] = dev::new_hud(menu_name, "<dev string:x4ba>", x + 5, y + 215, 1);
  hud.menu[19] = dev::new_hud(menu_name, "<dev string:x4c5>", x + 5, y + 225, 1);
  hud.menu[20] = dev::new_hud(menu_name, "<dev string:x4d4>", x + 5, y + 235, 1);
  hud.menu[21] = dev::new_hud(menu_name, "<dev string:x4e0>", x + 5, y + 245, 1);
  hud.menu[22] = dev::new_hud(menu_name, "<dev string:x4f0>", x + 5, y + 255, 1);
  hud.menu[23] = dev::new_hud(menu_name, "<dev string:x4ff>", x + 5, y + 265, 1);
  hud.menu[24] = dev::new_hud(menu_name, "<dev string:x50c>", x + 5, y + 275, 1);
  x_offset = 65;
  hud.menu[25] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 35, 1);
  hud.menu[26] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 45, 1);
  hud.menu[27] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 55, 1);
  x_offset = 100;
  hud.menu[28] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 80, 1);
  hud.menu[29] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 90, 1);
  hud.menu[30] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 100, 1);
  hud.menu[31] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 110, 1);
  hud.menu[32] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 120, 1);
  hud.menu[33] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 145, 1);
  hud.menu[34] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 155, 1);
  hud.menu[35] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 180, 1);
  hud.menu[36] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 190, 1);
  x_offset = 65;
  hud.menu[37] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 215, 1);
  hud.menu[38] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 225, 1);
  hud.menu[39] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 235, 1);
  hud.menu[40] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 245, 1);
  hud.menu[41] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 255, 1);
  hud.menu[42] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 265, 1);
  hud.menu[43] = dev::new_hud(menu_name, "<dev string:x38>", x + x_offset, y + 275, 1);
  return hud;
}

function color(value) {
  r = 1;
  g = 1;
  b = 0;
  color = (0, 0, 0);

  if(value > 0) {
    r -= value;
  } else {
    g += value;
  }

  c = (r, g, b);
  return c;
}

function dev_cac_gdt_update_think() {
  for(;;) {
    waitresult = level waittill(#"gdt_update");
    asset = waitresult.asset;
    keyvalue = waitresult.keyvalue;
    keyvalue = strtok(keyvalue, "<dev string:x518>");
    key = keyvalue[0];

    switch (key) {
      case # "armorbullet":
        key = "<dev string:x59>";
        break;
      case # "armorexplosive":
        key = "<dev string:x69>";
        break;
      case # "movespeed":
        key = "<dev string:x7c>";
        break;
      case # "sprinttimetotal":
        key = "<dev string:x51d>";
        break;
      case # "sprinttimecooldown":
        key = "<dev string:x532>";
        break;
      default:
        key = undefined;
        break;
    }

    if(!isDefined(key)) {
      continue;
    }

    value = float(keyvalue[1]);
    level.cac_attributes[key][asset] = value;
    players = getplayers();

    for(i = 0; i < players.size; i++) {}
  }
}

function sort_greatest(func, attribute, greatest) {
  keys = getarraykeys(level.cac_functions[func]);
  greatest = keys[0];

  for(i = 0; i < keys.size; i++) {
    if(level.cac_attributes[attribute][keys[i]] > level.cac_attributes[attribute][greatest]) {
      greatest = keys[i];
    }
  }

  return greatest;
}

function sort_least(func, attribute, least) {
  keys = getarraykeys(level.cac_functions[func]);
  least = keys[0];

  for(i = 0; i < keys.size; i++) {
    if(level.cac_attributes[attribute][keys[i]] < level.cac_attributes[attribute][least]) {
      least = keys[i];
    }
  }

  return least;
}

function dev_cac_set_model_range(sort_function, attribute) {
  if(!dev_cac_player_valid()) {
    return;
  }

  player = level.dev_cac_player;
  player.cac_body_type = [[sort_function]]("<dev string:x54a>", attribute);
  player.cac_head_type = [[sort_function]]("<dev string:x55c>", attribute);
  player.cac_hat_type = [[sort_function]]("<dev string:x56e>", attribute);
  player dev_cac_set_player_model();
}