/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\lui_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\core\_multi_extracam;
#using scripts\shared\_character_customization;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using_animtree("all_player");
#namespace lui;

function autoexec __init__sytem__() {
  system::register("lui_shared", & __init__, undefined, undefined);
}

function __init__() {
  level.client_menus = associativearray();
  callback::on_localclient_connect( & on_player_connect);
}

function on_player_connect(localclientnum) {
  level thread client_menus(localclientnum);
}

function initmenudata(localclientnum) {
  assert(!isdefined(level.client_menus[localclientnum]));
  level.client_menus[localclientnum] = associativearray();
}

function createextracamxcamdata(menu_name, localclientnum, extracam_index, target_name, xcam, sub_xcam, xcam_frame) {
  assert(isdefined(level.client_menus[localclientnum][menu_name]));
  menu_data = level.client_menus[localclientnum][menu_name];
  extracam_data = spawnstruct();
  extracam_data.extracam_index = extracam_index;
  extracam_data.target_name = target_name;
  extracam_data.xcam = xcam;
  extracam_data.sub_xcam = sub_xcam;
  extracam_data.xcam_frame = xcam_frame;
  if(!isdefined(menu_data.extra_cams)) {
    menu_data.extra_cams = [];
  } else if(!isarray(menu_data.extra_cams)) {
    menu_data.extra_cams = array(menu_data.extra_cams);
  }
  menu_data.extra_cams[menu_data.extra_cams.size] = extracam_data;
}

function createcustomextracamxcamdata(menu_name, localclientnum, extracam_index, camera_function) {
  assert(isdefined(level.client_menus[localclientnum][menu_name]));
  menu_data = level.client_menus[localclientnum][menu_name];
  extracam_data = spawnstruct();
  extracam_data.extracam_index = extracam_index;
  extracam_data.camera_function = camera_function;
  if(!isdefined(menu_data.extra_cams)) {
    menu_data.extra_cams = [];
  } else if(!isarray(menu_data.extra_cams)) {
    menu_data.extra_cams = array(menu_data.extra_cams);
  }
  menu_data.extra_cams[menu_data.extra_cams.size] = extracam_data;
}

function addmenuexploders(menu_name, localclientnum, exploder) {
  assert(isdefined(level.client_menus[localclientnum][menu_name]));
  menu_data = level.client_menus[localclientnum][menu_name];
  if(isarray(exploder)) {
    foreach(expl in exploder) {
      if(!isdefined(menu_data.exploders)) {
        menu_data.exploders = [];
      } else if(!isarray(menu_data.exploders)) {
        menu_data.exploders = array(menu_data.exploders);
      }
      menu_data.exploders[menu_data.exploders.size] = expl;
    }
  } else {
    if(!isdefined(menu_data.exploders)) {
      menu_data.exploders = [];
    } else if(!isarray(menu_data.exploders)) {
      menu_data.exploders = array(menu_data.exploders);
    }
    menu_data.exploders[menu_data.exploders.size] = exploder;
  }
}

function linktocustomcharacter(menu_name, localclientnum, target_name) {
  assert(isdefined(level.client_menus[localclientnum][menu_name]));
  menu_data = level.client_menus[localclientnum][menu_name];
  assert(!isdefined(menu_data.custom_character));
  model = getent(localclientnum, target_name, "targetname");
  if(!isdefined(model)) {
    model = util::spawn_model(localclientnum, "tag_origin");
    model.targetname = target_name;
  }
  model useanimtree($all_player);
  menu_data.custom_character = character_customization::create_character_data_struct(model, localclientnum);
  model hide();
}

function getcharacterdataformenu(menu_name, localclientnum) {
  if(isdefined(level.client_menus[localclientnum][menu_name])) {
    return level.client_menus[localclientnum][menu_name].custom_character;
  }
  return undefined;
}

function createcameramenu(menu_name, localclientnum, target_name, xcam, sub_xcam, xcam_frame = undefined, custom_open_fn = undefined, custom_close_fn = undefined) {
  assert(!isdefined(level.client_menus[localclientnum][menu_name]));
  level.client_menus[localclientnum][menu_name] = spawnstruct();
  menu_data = level.client_menus[localclientnum][menu_name];
  menu_data.target_name = target_name;
  menu_data.xcam = xcam;
  menu_data.sub_xcam = sub_xcam;
  menu_data.xcam_frame = xcam_frame;
  menu_data.custom_open_fn = custom_open_fn;
  menu_data.custom_close_fn = custom_close_fn;
  return menu_data;
}

function createcustomcameramenu(menu_name, localclientnum, camera_function, has_state, custom_open_fn = undefined, custom_close_fn = undefined) {
  assert(!isdefined(level.client_menus[localclientnum][menu_name]));
  level.client_menus[localclientnum][menu_name] = spawnstruct();
  menu_data = level.client_menus[localclientnum][menu_name];
  menu_data.camera_function = camera_function;
  menu_data.has_state = has_state;
  menu_data.custom_open_fn = custom_open_fn;
  menu_data.custom_close_fn = custom_close_fn;
  return menu_data;
}

function setup_menu(localclientnum, menu_data, previous_menu) {
  if(isdefined(previous_menu) && isdefined(level.client_menus[localclientnum][previous_menu.menu_name])) {
    previous_menu_info = level.client_menus[localclientnum][previous_menu.menu_name];
    if(isdefined(previous_menu_info.custom_close_fn)) {
      if(isarray(previous_menu_info.custom_close_fn)) {
        foreach(fn in previous_menu_info.custom_close_fn) {
          [
            [fn]
          ](localclientnum, previous_menu_info);
        }
      } else {
        [
          [previous_menu_info.custom_close_fn]
        ](localclientnum, previous_menu_info);
      }
    }
    if(isdefined(previous_menu_info.extra_cams)) {
      foreach(extracam_data in previous_menu_info.extra_cams) {
        multi_extracam::extracam_reset_index(localclientnum, extracam_data.extracam_index);
      }
    }
    level notify(previous_menu.menu_name + "_closed");
    if(isdefined(previous_menu_info.camera_function)) {
      stopmaincamxcam(localclientnum);
    } else if(isdefined(previous_menu_info.xcam)) {
      stopmaincamxcam(localclientnum);
    }
    if(isdefined(previous_menu_info.custom_character)) {
      previous_menu_info.custom_character.charactermodel hide();
    }
    if(isdefined(previous_menu_info.exploders)) {
      foreach(exploder in previous_menu_info.exploders) {
        killradiantexploder(localclientnum, exploder);
      }
    }
  }
  if(isdefined(menu_data) && isdefined(level.client_menus[localclientnum][menu_data.menu_name])) {
    new_menu = level.client_menus[localclientnum][menu_data.menu_name];
    if(isdefined(new_menu.custom_character)) {
      new_menu.custom_character.charactermodel show();
    }
    if(isdefined(new_menu.exploders)) {
      foreach(exploder in new_menu.exploders) {
        playradiantexploder(localclientnum, exploder);
      }
    }
    if(isdefined(new_menu.camera_function)) {
      if(new_menu.has_state === 1) {
        level thread[[new_menu.camera_function]](localclientnum, menu_data.menu_name, menu_data.state);
      } else {
        level thread[[new_menu.camera_function]](localclientnum, menu_data.menu_name);
      }
    } else if(isdefined(new_menu.xcam)) {
      camera_ent = struct::get(new_menu.target_name);
      if(isdefined(camera_ent)) {
        playmaincamxcam(localclientnum, new_menu.xcam, 0, new_menu.sub_xcam, "", camera_ent.origin, camera_ent.angles);
      }
    }
    if(isdefined(new_menu.custom_open_fn)) {
      if(isarray(new_menu.custom_open_fn)) {
        foreach(fn in new_menu.custom_open_fn) {
          [
            [fn]
          ](localclientnum, new_menu);
        }
      } else {
        [
          [new_menu.custom_open_fn]
        ](localclientnum, new_menu);
      }
    }
    if(isdefined(new_menu.extra_cams)) {
      foreach(extracam_data in new_menu.extra_cams) {
        if(isdefined(extracam_data.camera_function)) {
          if(new_menu.has_state === 1) {
            level thread[[extracam_data.camera_function]](localclientnum, menu_data.menu_name, extracam_data, menu_data.state);
          } else {
            level thread[[extracam_data.camera_function]](localclientnum, menu_data.menu_name, extracam_data);
          }
          continue;
        }
        camera_ent = multi_extracam::extracam_init_index(localclientnum, extracam_data.target_name, extracam_data.extracam_index);
        if(isdefined(camera_ent)) {
          if(isdefined(extracam_data.xcam_frame)) {
            camera_ent playextracamxcam(extracam_data.xcam, 0, extracam_data.sub_xcam, extracam_data.xcam_frame);
            continue;
          }
          camera_ent playextracamxcam(extracam_data.xcam, 0, extracam_data.sub_xcam);
        }
      }
    }
  }
}

function client_menus(localclientnum) {
  level endon("disconnect");
  clientmenustack = array();
  while (true) {
    level waittill("menu_change" + localclientnum, menu_name, status, state);
    menu_index = undefined;
    for (i = 0; i < clientmenustack.size; i++) {
      if(clientmenustack[i].menu_name == menu_name) {
        menu_index = i;
        break;
      }
    }
    if(status === "closeToMenu" && isdefined(menu_index)) {
      topmenu = undefined;
      for (i = 0; i < menu_index; i++) {
        popped = array::pop_front(clientmenustack, 0);
        if(!isdefined(topmenu)) {
          topmenu = popped;
        }
      }
      setup_menu(localclientnum, clientmenustack[0], topmenu);
      continue;
    }
    statechange = isdefined(menu_index) && status !== "closed" && clientmenustack[menu_index].state !== state && (!(!isdefined(clientmenustack[menu_index].state) && !isdefined(state)));
    updateonly = statechange && menu_index !== 0;
    if(updateonly) {
      clientmenustack[i].state = state;
    } else {
      if(status === "closed" || statechange && isdefined(menu_index)) {
        popped = undefined;
        if(getdvarint("ui_execdemo_e3") == 1) {
          while (menu_index >= 0) {
            if(!isdefined(popped)) {
              popped = array::pop_front(clientmenustack, 0);
            }
            menu_index--;
          }
        } else {
          assert(menu_index == 0);
          popped = array::pop_front(clientmenustack, 0);
        }
        setup_menu(localclientnum, clientmenustack[0], popped);
      }
      if(status === "opened" && (!isdefined(menu_index) || statechange)) {
        menu_data = spawnstruct();
        menu_data.menu_name = menu_name;
        menu_data.state = state;
        lastmenu = (clientmenustack.size > 0 ? clientmenustack[0] : undefined);
        setup_menu(localclientnum, menu_data, lastmenu);
        array::push_front(clientmenustack, menu_data);
      }
    }
  }
}

function screen_fade(n_time, n_target_alpha = 1, n_start_alpha = 0, str_color = "black", b_force_close_menu = 0) {
  if(self == level) {
    foreach(player in level.players) {
      player thread _screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
    }
  } else {
    self thread _screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
  }
}

function screen_fade_out(n_time, str_color) {
  screen_fade(n_time, 1, 0, str_color, 0);
  wait(n_time);
}

function screen_fade_in(n_time, str_color) {
  screen_fade(n_time, 0, 1, str_color, 1);
  wait(n_time);
}

function screen_close_menu() {
  if(self == level) {
    foreach(player in level.players) {
      player thread _screen_close_menu();
    }
  } else {
    self thread _screen_close_menu();
  }
}

function private _screen_close_menu() {
  self notify("_screen_fade");
  self endon("_screen_fade");
  self endon("disconnect");
  if(isdefined(self.screen_fade_menus)) {
    str_menu = "FullScreenBlack";
    if(isdefined(self.screen_fade_menus[str_menu])) {
      closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
      self.screen_fade_menus[str_menu] = undefined;
    }
    str_menu = "FullScreenWhite";
    if(isdefined(self.screen_fade_menus[str_menu])) {
      closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
      self.screen_fade_menus[str_menu] = undefined;
    }
  }
}

function private _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu) {
  self notify("_screen_fade");
  self endon("_screen_fade");
  self endon("disconnect");
  self endon("entityshutdown");
  if(!isdefined(self.screen_fade_menus)) {
    self.screen_fade_menus = [];
  }
  if(!isdefined(v_color)) {
    v_color = (0, 0, 0);
  }
  n_time_ms = int(n_time * 1000);
  str_menu = "FullScreenBlack";
  if(isstring(v_color)) {
    switch (v_color) {
      case "black": {
        v_color = (0, 0, 0);
        break;
      }
      case "white": {
        v_color = (1, 1, 1);
        break;
      }
      default: {
        assertmsg("");
      }
    }
  }
  lui_menu = "";
  if(isdefined(self.screen_fade_menus[str_menu])) {
    s_menu = self.screen_fade_menus[str_menu];
    lui_menu = s_menu.lui_menu;
    closeluimenu(self.localclientnum, lui_menu);
    n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
  }
  lui_menu = createluimenu(self.localclientnum, str_menu);
  self.screen_fade_menus[str_menu] = spawnstruct();
  self.screen_fade_menus[str_menu].lui_menu = lui_menu;
  self.screen_fade_menus[str_menu].n_start_alpha = n_start_alpha;
  self.screen_fade_menus[str_menu].n_target_alpha = n_target_alpha;
  self.screen_fade_menus[str_menu].n_target_time = n_time_ms;
  self.screen_fade_menus[str_menu].n_start_time = gettime();
  self set_color(lui_menu, v_color);
  setluimenudata(self.localclientnum, lui_menu, "startAlpha", n_start_alpha);
  setluimenudata(self.localclientnum, lui_menu, "endAlpha", n_target_alpha);
  setluimenudata(self.localclientnum, lui_menu, "fadeOverTime", n_time_ms);
  openluimenu(self.localclientnum, lui_menu);
  wait(n_time);
  if(b_force_close_menu || n_target_alpha == 0) {
    closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
    self.screen_fade_menus[str_menu] = undefined;
  }
}

function set_color(menu, color) {
  setluimenudata(self.localclientnum, menu, "red", color[0]);
  setluimenudata(self.localclientnum, menu, "green", color[1]);
  setluimenudata(self.localclientnum, menu, "blue", color[2]);
}