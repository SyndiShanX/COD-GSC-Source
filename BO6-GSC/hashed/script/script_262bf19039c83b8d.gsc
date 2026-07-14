/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_262bf19039c83b8d.gsc
*****************************************************/

#using scripts\common\interactive_map;
#using scripts\engine\sp\objectives;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player;
#namespace namespace_239da5d9480323b9;

function function_597d619ed4cbd074(var_3a56a0c1a85f34fd, var_dbcc9e7a80734df6, var_663376f0279e84d6, var_c103e70d49c14725 = 0, var_fe4ac4bb68a5227 = 1, var_bd7f09191d7e9870 = 1, var_e3edeb270b611c8e = "\xf7>\x97\x02!\xd8\xcd\xdb{\x17c\x9e0E\xf3g\xe2g\xfc", var_bcb74589715e04e0 = "\xe94\x9d\x85o\xbb\x8c\x99{\xd29\v\x8e\xe0\xab\xdcf\xb2\xea\x06", var_b18a6f12704efcf4 = undefined) {
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  assert(isDefined(level.interactive_map), "<dev string:x24>");
  level.interactive_map.var_3a56a0c1a85f34fd = var_3a56a0c1a85f34fd;
  level.interactive_map.var_dbcc9e7a80734df6 = var_dbcc9e7a80734df6;
  level.interactive_map.var_663376f0279e84d6 = var_663376f0279e84d6;
  level.interactive_map.var_b18a6f12704efcf4 = var_b18a6f12704efcf4;
  level.interactive_map.var_fe4ac4bb68a5227 = var_fe4ac4bb68a5227;
  level.interactive_map.var_e3edeb270b611c8e = var_e3edeb270b611c8e;
  level.interactive_map.var_7fb7f650b86f4ea3 = var_bcb74589715e04e0;
  level.interactive_map.var_bd7f09191d7e9870 = var_bd7f09191d7e9870;
  level.interactive_map.var_c103e70d49c14725 = var_c103e70d49c14725;
  level.interactive_map.var_89e239813756b162 = 0;
  level.interactive_map.var_575d922e5ad24bae = 0;
  interactive_map::function_8d11d0e2b8d5d9a8("d\xa3\x89\xdb\xed\xab9\x1a\xbe\xbc\xa1M\xce\xb1\x13\x19\b&\x91\xf2[\x19\xbb", &interact_mark_objective);
  interactive_map::function_8d11d0e2b8d5d9a8("\x1f2\xdfR\x12~b\xf2]\xf4\xae\xd5\x92\xb17\xc7\x87~ \x91vN\xec\xfb\xb6", &interact_unmark_objective);

  if(var_c103e70d49c14725) {
    interactive_map::function_8d11d0e2b8d5d9a8("H\xb0\xf1Y\x91\xd7\xbb\xf8]\x19gX\x9e\x12[Js\x9e\xd0XX", &interact_set_waypoint);
    interactive_map::function_8d11d0e2b8d5d9a8("\xd2\xdc\xd1+\xe4\xc2cG\xebr\xac\xb5\xf6\xec\xb2_\xdday\xe0\xf6Zn\xa3", &interact_remove_waypoint);
    level.interactive_map.var_aea4399657c7cdb8 = utility::function_94c66bbed3da2a18((0, 0, 0), (0, 0, 0));
    level.interactive_map.var_aea4399657c7cdb8 interactive_map::function_187764da72df9b5("\x91\xca\xcc\v\xab\xd8:", "0Gf(c:A\x06");
    level.interactive_map.var_aea4399657c7cdb8 interactive_map::function_da866d7717db055a("\x04\xe1\xa6\xba\x9d\x96\xcb\xba\xd2>\x81\xcd\xd0`\xbez\x1a");
    objectives::objective_add("\xe7DoX\xdb9\xae~\xc61p\xc5", "\xe3\x93}=nD", level.interactive_map.var_aea4399657c7cdb8.origin, undefined, undefined, "\x93\xf0F\x9a^$\x94<\xfc\x94\t>\a\x7f\xa3\x15\xb6\xa0`\xb6z\b\x01\xbb5\x11`V\xb8j\xc053", undefined, 1);
  } else {
    level.interactive_map.var_89e239813756b162 = 1;
  }

  if(var_fe4ac4bb68a5227 && !isDefined(level.var_993fce341d482275)) {
    level.var_993fce341d482275 = utility::function_94c66bbed3da2a18((0, 0, 0), (0, 0, 0));
    level.var_993fce341d482275 interactive_map::function_187764da72df9b5("\x91\xca\xcc\v\xab\xd8:", "\xd7-c%e\xa4\x05\xdc\xdb\xdb\xe4n+\x15j\xf7G");
    level.var_993fce341d482275 interactive_map::function_da866d7717db055a("\x04\xe1\xa6\xba\x9d\x96\xcb\xba\xd2>\x81\xcd\xd0`\xbez\x1a");
  }

  level thread function_bd123ffbd9c03a72();

  if(isDefined(var_b18a6f12704efcf4)) {
    level thread function_9752eaf3a6993f8c();
  }
}

function private function_9752eaf3a6993f8c() {
  self notify("\x13\xea\xc8P&\xc9u\xc0\x8bW\x18T`\xf2P\xf8");
  self endon("\x13\xea\xc8P&\xc9u\xc0\x8bW\x18T`\xf2P\xf8");

  while(true) {
    level waittill("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
    self thread[[level.interactive_map.var_b18a6f12704efcf4]]();
  }
}

function private function_bd123ffbd9c03a72() {
  level waittill("\v\x9d\xf0P\x1cf\x04\x9f\x98\xf6\x11\xe6\xa8\x81\x9c\xe0/\xcewqn\x97<");
  function_86fcdedaff7c7ac0();
}

function private interact_mark_objective(val, val2) {
  allowinteract = 1;

  if(isDefined(level.interactive_map.var_663376f0279e84d6)) {
    allowinteract = [[level.interactive_map.var_663376f0279e84d6]]();
  }

  if(!allowinteract) {
    return;
  }

  waitframe();
  function_a52fd629ed0642fe(1);
  function_86fcdedaff7c7ac0();
  waitframe();
  data = interactive_map::function_f38215e32b2e60c6(val);

  if(!isDefined(data.object)) {
    return;
  }

  level.interactive_map.marked_object = data.object;
  level.interactive_map.marked_object interactive_map::function_da866d7717db055a(level.interactive_map.var_e3edeb270b611c8e);

  if(level.interactive_map.var_fe4ac4bb68a5227) {
    level.var_993fce341d482275 interactive_map::function_da866d7717db055a("7\x98,O\xe8\x9dT\xb4\xc3\xa1\xb6G\xa6\v\xb1\xd0c");
  }

  if(isDefined(level.interactive_map.var_3a56a0c1a85f34fd)) {
    obj_name = self[[level.interactive_map.var_3a56a0c1a85f34fd]](data);

    if(level.interactive_map.var_bd7f09191d7e9870 && isDefined(obj_name)) {
      obj_index = objectives::_objective_getindexforname(obj_name);
      level.interactive_map.marked_object.index = obj_index;
      objective_state(obj_index, "\x96\x99\x05\x0en\x80\xc0");
      objective_icon(obj_index, "\xe7]\x7f\xb3\xedZ\x9b\xd3\xb0n\x1b\xf8\xcbj\x88\xf1;\xbde\xdb\x0f-u\xcf-r\xf8\xff\xdb_Re\x1f\xf2j+\xd4");
      objective_position(obj_index, objective_getlocation(obj_index, 0));
      objective_setshowoncompass(obj_index, 1);
    }
  }

  ping_objectives();
}

function private interact_unmark_objective(val, val2) {
  shouldresetobject = 0;
  data = interactive_map::function_f38215e32b2e60c6(val);

  if(isDefined(data.object) && isDefined(level.interactive_map.marked_object) && data.object == level.interactive_map.marked_object) {
    shouldresetobject = 1;
  }

  function_a52fd629ed0642fe(shouldresetobject);
}

function private function_a52fd629ed0642fe(var_31b853ee82825ada) {
  if(var_31b853ee82825ada) {
    if(isDefined(level.interactive_map.marked_object) && isDefined(level.interactive_map.marked_object.index)) {
      objective_state(level.interactive_map.marked_object.index, "\xe3\x93}=nD");
      objective_setshowoncompass(level.interactive_map.marked_object.index, 0);
      level.interactive_map.marked_object interactive_map::function_da866d7717db055a(level.interactive_map.var_7fb7f650b86f4ea3);
      level.interactive_map.marked_object = undefined;
    }

    if(level.interactive_map.var_fe4ac4bb68a5227) {
      level.var_993fce341d482275 interactive_map::function_da866d7717db055a("\x04\xe1\xa6\xba\x9d\x96\xcb\xba\xd2>\x81\xcd\xd0`\xbez\x1a");
    }
  }

  if(isDefined(level.interactive_map.var_dbcc9e7a80734df6)) {
    self[[level.interactive_map.var_dbcc9e7a80734df6]]();
  }
}

function private interact_set_waypoint(val, val2) {
  waitframe();
  function_a52fd629ed0642fe(1);
  waitframe();
  level notify("\xf28\x98u\x94\xec.\x92\x93\x91\x87\x7f\x12\xacn");
  data = interactive_map::function_f38215e32b2e60c6(val);
  world_loc = data.position;

  if(isDefined(level.var_4dfcb70dde13c16e)) {
    world_loc = (world_loc[0], world_loc[1], level.var_4dfcb70dde13c16e);
  } else {
    world_loc = (world_loc[0], world_loc[1], self.origin[2] + 60);
    offset = 200;

    while(offset < 7000) {
      ret = trace::ray_trace(world_loc + (0, 0, offset), world_loc - (0, 0, offset));

      if(ret[")\x9a\x94]\xee}s"] != "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
        world_loc = ret["\xc1\xbd\xdci\xe8i{7"] + (0, 0, 60);
        break;
      }

      offset *= 2;
    }
  }

  function_2340155ca3b59752(world_loc);
}

function private interact_remove_waypoint(val, val2) {
  function_86fcdedaff7c7ac0();
  ping_objectives();
}

function private function_2340155ca3b59752(world_loc) {
  level notify("\xf28\x98u\x94\xec.\x92\x93\x91\x87\x7f\x12\xacn");
  thread reach_waypoint(world_loc);
  level.interactive_map.var_aea4399657c7cdb8.origin = world_loc;
  level.interactive_map.var_aea4399657c7cdb8 interactive_map::function_da866d7717db055a("7\x98,O\xe8\x9dT\xb4\xc3\xa1\xb6G\xa6\v\xb1\xd0c");
  objectives::objective_set_position("\xe7DoX\xdb9\xae~\xc61p\xc5", world_loc);
  objectives::objective_set_state("\xe7DoX\xdb9\xae~\xc61p\xc5", "\x96\x99\x05\x0en\x80\xc0");
  obj_index = objectives::_objective_getindexforname("\xe7DoX\xdb9\xae~\xc61p\xc5");
  objective_setshowoncompass(obj_index, 1);
  objectives::function_c189022d1ae40deb("\xe7DoX\xdb9\xae~\xc61p\xc5", 1);
  ping_objectives();
}

function private function_86fcdedaff7c7ac0() {
  if(istrue(level.interactive_map.var_c103e70d49c14725)) {
    level.interactive_map.var_aea4399657c7cdb8 interactive_map::function_da866d7717db055a("\x04\xe1\xa6\xba\x9d\x96\xcb\xba\xd2>\x81\xcd\xd0`\xbez\x1a");
    level notify("\xf28\x98u\x94\xec.\x92\x93\x91\x87\x7f\x12\xacn");
    objectives::objective_set_state("\xe7DoX\xdb9\xae~\xc61p\xc5", "\xe3\x93}=nD");
    obj_index = objectives::_objective_getindexforname("\xe7DoX\xdb9\xae~\xc61p\xc5");
    objective_setshowoncompass(obj_index, 0);
    objectives::function_c189022d1ae40deb("\xe7DoX\xdb9\xae~\xc61p\xc5", 0);
  }
}

function private reach_waypoint(waypoint_origin, range = 500) {
  waypoint_trigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", waypoint_origin - (0, 0, range), 0, range, range * 2);
  waypoint_trigger thread function_73340efcb48d74ce("+\x15\xefFMN\xc2\xb8\n*\xc7\x15Pok\xee");
  msg = level utility::waittill_any_return("\xf28\x98u\x94\xec.\x92\x93\x91\x87\x7f\x12\xacn", "+\x15\xefFMN\xc2\xb8\n*\xc7\x15Pok\xee");

  if(msg == "+\x15\xefFMN\xc2\xb8\n*\xc7\x15Pok\xee") {
    function_86fcdedaff7c7ac0();
    function_a52fd629ed0642fe(1);
  }

  waypoint_trigger delete();
}

function private function_73340efcb48d74ce(notify_str) {
  level endon("\xf28\x98u\x94\xec.\x92\x93\x91\x87\x7f\x12\xacn");
  self waittill("\x91`\xb1\xe7T\x97>");
  level notify(notify_str);
}

function private ping_objectives() {
  level.player player_sp::set_focus_objectives_update_display(1);
  level notify("\x03\xf6\x16\xc1\x8e\x9e#\xcbz\xb0\x97\xb9\xbc\xb0L\x1d[\xbc");
}