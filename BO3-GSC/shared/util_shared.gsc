/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\util_shared.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using_animtree("generic");
#using_animtree("all_player");
#namespace util;

function empty(a, b, c, d, e) {}

function wait_network_frame(n_count = 1) {
  if(numremoteclients()) {
    for(i = 0; i < n_count; i++) {
      snapshot_ids = getsnapshotindexarray();
      acked = undefined;
      while(!isDefined(acked)) {
        level waittill("snapacknowledged");
        acked = snapshotacknowledged(snapshot_ids);
      }
    }
  } else {
    wait(0.1 * n_count);
  }
}

function streamer_wait(n_stream_request_id, n_wait_frames = 0, n_timeout = 0, b_bonuszm_streamer_fallback = 1) {
  level endon("loading_movie_done");
  if(n_wait_frames > 0) {
    wait_network_frame(n_wait_frames);
  }
  if(sessionmodeiscampaignzombiesgame() && (isDefined(b_bonuszm_streamer_fallback) && b_bonuszm_streamer_fallback)) {
    if(!n_timeout) {
      n_timeout = 7;
    }
  }
  timeout = gettime() + (n_timeout * 1000);
  if(self == level) {
    n_num_streamers_ready = 0;
    do {
      wait_network_frame();
      n_num_streamers_ready = 0;
      foreach(player in getplayers()) {
        if((isDefined(n_stream_request_id) ? player isstreamerready(n_stream_request_id) : player isstreamerready())) {
          n_num_streamers_ready++;
        }
      }
      if(n_timeout > 0 && gettime() > timeout) {
        break;
      }
    }
    while(n_num_streamers_ready < max(1, getplayers().size));
  } else {
    self endon("disconnect");
    do {
      wait_network_frame();
      if(n_timeout > 0 && gettime() > timeout) {
        break;
      }
    }
    while(!(isDefined(n_stream_request_id) ? self isstreamerready(n_stream_request_id) : self isstreamerready()));
  }
}

function draw_debug_line(start, end, timer) {
  for(i = 0; i < (timer * 20); i++) {
    line(start, end, (1, 1, 0.5));
    wait(0.05);
  }
}

function debug_line(start, end, color, alpha, depthtest, duration) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  if(!isDefined(alpha)) {
    alpha = 1;
  }
  if(!isDefined(depthtest)) {
    depthtest = 0;
  }
  if(!isDefined(duration)) {
    duration = 100;
  }
  line(start, end, color, alpha, depthtest, duration);
}

function debug_spherical_cone(origin, domeapex, angle, slices, color, alpha, depthtest, duration) {
  if(!isDefined(slices)) {
    slices = 10;
  }
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  if(!isDefined(alpha)) {
    alpha = 1;
  }
  if(!isDefined(depthtest)) {
    depthtest = 0;
  }
  if(!isDefined(duration)) {
    duration = 100;
  }
  sphericalcone(origin, domeapex, angle, slices, color, alpha, depthtest, duration);
}

function debug_sphere(origin, radius, color, alpha, time) {
  if(!isDefined(time)) {
    time = 1000;
  }
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  sides = int(10 * (1 + (int(radius) % 100)));
  sphere(origin, radius, color, alpha, 1, sides, time);
}

function waittillend(msg) {
  self waittillmatch(msg);
}

function track(spot_to_track) {
  if(isDefined(self.current_target)) {
    if(spot_to_track == self.current_target) {
      return;
    }
  }
  self.current_target = spot_to_track;
}

function waittill_string(msg, ent) {
  if(msg != "death") {
    self endon("death");
  }
  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

function waittill_level_string(msg, ent, otherent) {
  otherent endon("death");
  ent endon("die");
  level waittill(msg);
  ent notify("returned", msg);
}

function waittill_multiple(...) {
  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;
  for(i = 0; i < vararg.size; i++) {
    self thread _waitlogic(s_tracker, vararg[i]);
  }
  if(s_tracker._wait_count > 0) {
    s_tracker waittill("waitlogic_finished");
  }
}

function waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

function break_glass(n_radius = 50) {
  n_radius = float(n_radius);
  if(n_radius == -1) {
    v_origin_offset = (0, 0, 0);
    n_radius = 100;
  } else {
    v_origin_offset = vectorscale((0, 0, 1), 40);
  }
  glassradiusdamage(self.origin + v_origin_offset, n_radius, 500, 500);
}

function waittill_multiple_ents(...) {
  a_ents = [];
  a_notifies = [];
  for(i = 0; i < vararg.size; i++) {
    if(i % 2) {
      if(!isDefined(a_notifies)) {
        a_notifies = [];
      } else if(!isarray(a_notifies)) {
        a_notifies = array(a_notifies);
      }
      a_notifies[a_notifies.size] = vararg[i];
      continue;
    }
    if(!isDefined(a_ents)) {
      a_ents = [];
    } else if(!isarray(a_ents)) {
      a_ents = array(a_ents);
    }
    a_ents[a_ents.size] = vararg[i];
  }
  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;
  for(i = 0; i < a_ents.size; i++) {
    ent = a_ents[i];
    if(isDefined(ent)) {
      ent thread _waitlogic(s_tracker, a_notifies[i]);
    }
  }
  if(s_tracker._wait_count > 0) {
    s_tracker waittill("waitlogic_finished");
  }
}

function _waitlogic(s_tracker, notifies) {
  s_tracker._wait_count++;
  if(!isDefined(notifies)) {
    notifies = [];
  } else if(!isarray(notifies)) {
    notifies = array(notifies);
  }
  notifies[notifies.size] = "death";
  waittill_any_array(notifies);
  s_tracker._wait_count--;
  if(s_tracker._wait_count == 0) {
    s_tracker notify("waitlogic_finished");
  }
}

function waittill_any_return(string1, string2, string3, string4, string5, string6, string7) {
  if(!isDefined(string1) || string1 != "death" && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death") && (!isDefined(string6) || string6 != "death") && (!isDefined(string7) || string7 != "death")) {
    self endon("death");
  }
  ent = spawnStruct();
  if(isDefined(string1)) {
    self thread waittill_string(string1, ent);
  }
  if(isDefined(string2)) {
    self thread waittill_string(string2, ent);
  }
  if(isDefined(string3)) {
    self thread waittill_string(string3, ent);
  }
  if(isDefined(string4)) {
    self thread waittill_string(string4, ent);
  }
  if(isDefined(string5)) {
    self thread waittill_string(string5, ent);
  }
  if(isDefined(string6)) {
    self thread waittill_string(string6, ent);
  }
  if(isDefined(string7)) {
    self thread waittill_string(string7, ent);
  }
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_any_ex(...) {
  s_common = spawnStruct();
  e_current = self;
  n_arg_index = 0;
  if(strisnumber(vararg[0])) {
    n_timeout = vararg[0];
    n_arg_index++;
    if(n_timeout > 0) {
      s_common thread _timeout(n_timeout);
    }
  }
  if(isarray(vararg[n_arg_index])) {
    a_params = vararg[n_arg_index];
    n_start_index = 0;
  } else {
    a_params = vararg;
    n_start_index = n_arg_index;
  }
  for(i = n_start_index; i < a_params.size; i++) {
    if(!isstring(a_params[i])) {
      e_current = a_params[i];
      continue;
    }
    if(isDefined(e_current)) {
      e_current thread waittill_string(a_params[i], s_common);
    }
  }
  s_common waittill("returned", str_notify);
  s_common notify("die");
  return str_notify;
}

function waittill_any_array_return(a_notifies) {
  if(isinarray(a_notifies, "death")) {
    self endon("death");
  }
  s_tracker = spawnStruct();
  foreach(str_notify in a_notifies) {
    if(isDefined(str_notify)) {
      self thread waittill_string(str_notify, s_tracker);
    }
  }
  s_tracker waittill("returned", msg);
  s_tracker notify("die");
  return msg;
}

function waittill_any(str_notify1, str_notify2, str_notify3, str_notify4, str_notify5, str_notify6) {
  assert(isDefined(str_notify1));
  waittill_any_array(array(str_notify1, str_notify2, str_notify3, str_notify4, str_notify5, str_notify6));
}

function waittill_any_array(a_notifies) {
  if(!isDefined(a_notifies)) {
    a_notifies = [];
  } else if(!isarray(a_notifies)) {
    a_notifies = array(a_notifies);
  }
  assert(isDefined(a_notifies[0]), "");
  for(i = 1; i < a_notifies.size; i++) {
    if(isDefined(a_notifies[i])) {
      self endon(a_notifies[i]);
    }
  }
  self waittill(a_notifies[0]);
}

function waittill_any_timeout(n_timeout, string1, string2, string3, string4, string5) {
  if(!isDefined(string1) || string1 != "death" && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death")) {
    self endon("death");
  }
  ent = spawnStruct();
  if(isDefined(string1)) {
    self thread waittill_string(string1, ent);
  }
  if(isDefined(string2)) {
    self thread waittill_string(string2, ent);
  }
  if(isDefined(string3)) {
    self thread waittill_string(string3, ent);
  }
  if(isDefined(string4)) {
    self thread waittill_string(string4, ent);
  }
  if(isDefined(string5)) {
    self thread waittill_string(string5, ent);
  }
  ent thread _timeout(n_timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function waittill_level_any_timeout(n_timeout, otherent, string1, string2, string3, string4, string5) {
  otherent endon("death");
  ent = spawnStruct();
  if(isDefined(string1)) {
    level thread waittill_level_string(string1, ent, otherent);
  }
  if(isDefined(string2)) {
    level thread waittill_level_string(string2, ent, otherent);
  }
  if(isDefined(string3)) {
    level thread waittill_level_string(string3, ent, otherent);
  }
  if(isDefined(string4)) {
    level thread waittill_level_string(string4, ent, otherent);
  }
  if(isDefined(string5)) {
    level thread waittill_level_string(string5, ent, otherent);
  }
  if(isDefined(otherent)) {
    otherent thread waittill_string("death", ent);
  }
  ent thread _timeout(n_timeout);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function _timeout(delay) {
  self endon("die");
  wait(delay);
  self notify("returned", "timeout");
}

function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));
  if(isDefined(ent2) && isDefined(string2)) {
    ent2 endon(string2);
  }
  if(isDefined(ent3) && isDefined(string3)) {
    ent3 endon(string3);
  }
  if(isDefined(ent4) && isDefined(string4)) {
    ent4 endon(string4);
  }
  if(isDefined(ent5) && isDefined(string5)) {
    ent5 endon(string5);
  }
  if(isDefined(ent6) && isDefined(string6)) {
    ent6 endon(string6);
  }
  if(isDefined(ent7) && isDefined(string7)) {
    ent7 endon(string7);
  }
  ent1 waittill(string1);
}

function waittill_any_ents_two(ent1, string1, ent2, string2) {
  assert(isDefined(ent1));
  assert(isDefined(string1));
  if(isDefined(ent2) && isDefined(string2)) {
    ent2 endon(string2);
  }
  ent1 waittill(string1);
}

function isflashed() {
  if(!isDefined(self.flashendtime)) {
    return 0;
  }
  return gettime() < self.flashendtime;
}

function isstunned() {
  if(!isDefined(self.flashendtime)) {
    return 0;
  }
  return gettime() < self.flashendtime;
}

function single_func(entity = level, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  if(isDefined(arg6)) {
    return entity[[func]](arg1, arg2, arg3, arg4, arg5, arg6);
  }
  if(isDefined(arg5)) {
    return entity[[func]](arg1, arg2, arg3, arg4, arg5);
  }
  if(isDefined(arg4)) {
    return entity[[func]](arg1, arg2, arg3, arg4);
  }
  if(isDefined(arg3)) {
    return entity[[func]](arg1, arg2, arg3);
  }
  if(isDefined(arg2)) {
    return entity[[func]](arg1, arg2);
  }
  if(isDefined(arg1)) {
    return entity[[func]](arg1);
  }
  return entity[[func]]();
}

function new_func(func, arg1, arg2, arg3, arg4, arg5, arg6) {
  s_func = spawnStruct();
  s_func.func = func;
  s_func.arg1 = arg1;
  s_func.arg2 = arg2;
  s_func.arg3 = arg3;
  s_func.arg4 = arg4;
  s_func.arg5 = arg5;
  s_func.arg6 = arg6;
  return s_func;
}

function call_func(s_func) {
  return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

function single_thread(entity, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entity), "");
  if(isDefined(arg6)) {
    entity thread[[func]](arg1, arg2, arg3, arg4, arg5, arg6);
  } else {
    if(isDefined(arg5)) {
      entity thread[[func]](arg1, arg2, arg3, arg4, arg5);
    } else {
      if(isDefined(arg4)) {
        entity thread[[func]](arg1, arg2, arg3, arg4);
      } else {
        if(isDefined(arg3)) {
          entity thread[[func]](arg1, arg2, arg3);
        } else {
          if(isDefined(arg2)) {
            entity thread[[func]](arg1, arg2);
          } else {
            if(isDefined(arg1)) {
              entity thread[[func]](arg1);
            } else {
              entity thread[[func]]();
            }
          }
        }
      }
    }
  }
}

function script_delay() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return true;
  }
  if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    if(self.script_delay_max > self.script_delay_min) {
      wait(randomfloatrange(self.script_delay_min, self.script_delay_max));
    } else {
      wait(self.script_delay_min);
    }
    return true;
  }
  return false;
}

function timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  if(isDefined(n_time)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s delay_notify(n_time, "timeout");
  }
  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function create_flags_and_return_tokens(flags) {
  tokens = strtok(flags, " ");
  for(i = 0; i < tokens.size; i++) {
    if(!level flag::exists(tokens[i])) {
      level flag::init(tokens[i], undefined, 1);
    }
  }
  return tokens;
}

function fileprint_start(file) {
  filename = file;
  file = openfile(filename, "");
  level.fileprint = file;
  level.fileprintlinecount = 0;
  level.fileprint_filename = filename;
}

function fileprint_map_start(file) {
  file = ("" + file) + "";
  fileprint_start(file);
  level.fileprint_mapentcount = 0;
  fileprint_map_header(1);
}

function fileprint_chk(file, str) {
  level.fileprintlinecount++;
  if(level.fileprintlinecount > 400) {
    wait(0.05);
    level.fileprintlinecount++;
    level.fileprintlinecount = 0;
  }
  fprintln(file, str);
}

function fileprint_map_header(binclude_blank_worldspawn = 0) {
  assert(isDefined(level.fileprint));
  fileprint_chk(level.fileprint, "");
  fileprint_chk(level.fileprint, "");
  fileprint_chk(level.fileprint, "");
  if(!binclude_blank_worldspawn) {
    return;
  }
  fileprint_map_entity_start();
  fileprint_map_keypairprint("", "");
  fileprint_map_entity_end();
}

function fileprint_map_keypairprint(key1, key2) {
  /
  #
  assert(isDefined(level.fileprint));
  fileprint_chk(level.fileprint, ((("" + key1) + "") + key2) + "");
}

function fileprint_map_entity_start() {
  /
  #
  assert(!isDefined(level.fileprint_entitystart));
  level.fileprint_entitystart = 1;
  assert(isDefined(level.fileprint));
  fileprint_chk(level.fileprint, "" + level.fileprint_mapentcount);
  fileprint_chk(level.fileprint, "");
  level.fileprint_mapentcount++;
}

function fileprint_map_entity_end() {
  /
  #
  assert(isDefined(level.fileprint_entitystart));
  assert(isDefined(level.fileprint));
  level.fileprint_entitystart = undefined;
  fileprint_chk(level.fileprint, "");
}

function fileprint_end() {
  /
  #
  assert(!isDefined(level.fileprint_entitystart));
  saved = closefile(level.fileprint);
  if(saved != 1) {
    println("");
    println("");
    println("");
    println("" + level.fileprint_filename);
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
    println("");
  }
  level.fileprint = undefined;
  level.fileprint_filename = undefined;
}

function fileprint_radiant_vec(vector) {
  string = ((((("" + vector[0]) + "") + vector[1]) + "") + vector[2]) + "";
  return string;
}

function death_notify_wrapper(attacker, damagetype) {
  level notify("face", "death", self);
  self notify("death", attacker, damagetype);
}

function damage_notify_wrapper(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags) {
  level notify("face", "damage", self);
  self notify("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags);
}

function explode_notify_wrapper() {
  level notify("face", "explode", self);
  self notify("explode");
}

function alert_notify_wrapper() {
  level notify("face", "alert", self);
  self notify("alert");
}

function shoot_notify_wrapper() {
  level notify("face", "shoot", self);
  self notify("shoot");
}

function melee_notify_wrapper() {
  level notify("face", "melee", self);
  self notify("melee");
}

function isusabilityenabled() {
  return !self.disabledusability;
}

function _disableusability() {
  self.disabledusability++;
  self disableusability();
}

function _enableusability() {
  self.disabledusability--;
  assert(self.disabledusability >= 0);
  if(!self.disabledusability) {
    self enableusability();
  }
}

function resetusability() {
  self.disabledusability = 0;
  self enableusability();
}

function _disableweapon() {
  if(!isDefined(self.disabledweapon)) {
    self.disabledweapon = 0;
  }
  self.disabledweapon++;
  self disableweapons();
}

function _enableweapon() {
  if(self.disabledweapon > 0) {
    self.disabledweapon--;
    if(!self.disabledweapon) {
      self enableweapons();
    }
  }
}

function isweaponenabled() {
  return !self.disabledweapon;
}

function orient_to_normal(normal) {
  hor_normal = (normal[0], normal[1], 0);
  hor_length = length(hor_normal);
  if(!hor_length) {
    return (0, 0, 0);
  }
  hor_dir = vectornormalize(hor_normal);
  neg_height = normal[2] * -1;
  tangent = (hor_dir[0] * neg_height, hor_dir[1] * neg_height, hor_length);
  plant_angle = vectortoangles(tangent);
  return plant_angle;
}

function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self endon("death");
  if(isDefined(str_endon)) {
    self endon(str_endon);
  }
  if(isstring(time_or_notify)) {
    self waittill(time_or_notify);
  } else {
    wait(time_or_notify);
  }
  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self thread _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self endon("entityshutdown");
  if(isDefined(str_endon)) {
    self endon(str_endon);
  }
  wait_network_frame(n_frames);
  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function delay_notify(time_or_notify, str_notify, str_endon, arg1, arg2, arg3, arg4, arg5) {
  self thread _delay_notify(time_or_notify, str_notify, str_endon, arg1, arg2, arg3, arg4, arg5);
}

function _delay_notify(time_or_notify, str_notify, str_endon, arg1, arg2, arg3, arg4, arg5) {
  self endon("death");
  if(isDefined(str_endon)) {
    self endon(str_endon);
  }
  if(isstring(time_or_notify)) {
    self waittill(time_or_notify);
  } else {
    wait(time_or_notify);
  }
  self notify(str_notify, arg1, arg2, arg3, arg4, arg5);
}

function get_closest_player(org, str_team) {
  players = getplayers(str_team);
  return arraysort(players, org, 1, 1)[0];
}

function registerclientsys(ssysname) {
  if(!isDefined(level._clientsys)) {
    level._clientsys = [];
  }
  if(level._clientsys.size >= 32) {
    /
    #
    assertmsg("");
    return;
  }
  if(isDefined(level._clientsys[ssysname])) {
    /
    #
    assertmsg("" + ssysname);
    return;
  }
  level._clientsys[ssysname] = spawnStruct();
  level._clientsys[ssysname].sysid = clientsysregister(ssysname);
}

function setclientsysstate(ssysname, ssysstate, player) {
  if(!isDefined(level._clientsys)) {
    /
    #
    assertmsg("");
    return;
  }
  if(!isDefined(level._clientsys[ssysname])) {
    /
    #
    assertmsg("" + ssysname);
    return;
  }
  if(isDefined(player)) {
    player clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
  } else {
    clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
    level._clientsys[ssysname].sysstate = ssysstate;
  }
}

function getclientsysstate(ssysname) {
  if(!isDefined(level._clientsys)) {
    /
    #
    assertmsg("");
    return "";
  }
  if(!isDefined(level._clientsys[ssysname])) {
    /
    #
    assertmsg(("" + ssysname) + "");
    return "";
  }
  if(isDefined(level._clientsys[ssysname].sysstate)) {
    return level._clientsys[ssysname].sysstate;
  }
  return "";
}

function clientnotify(event) {
  if(level.clientscripts) {
    if(isplayer(self)) {
      setclientsysstate("levelNotify", event, self);
    } else {
      setclientsysstate("levelNotify", event);
    }
  }
}

function coopgame() {
  return sessionmodeissystemlink() || (sessionmodeisonlinegame() || issplitscreen());
}

function is_looking_at(ent_or_org, n_dot_range = 0.67, do_trace = 0, v_offset) {
  assert(isDefined(ent_or_org), "");
  v_point = (isvec(ent_or_org) ? ent_or_org : ent_or_org.origin);
  if(isvec(v_offset)) {
    v_point = v_point + v_offset;
  }
  b_can_see = 0;
  b_use_tag_eye = 0;
  if(isplayer(self) || isai(self)) {
    b_use_tag_eye = 1;
  }
  n_dot = self math::get_dot_direction(v_point, 0, 1, "forward", b_use_tag_eye);
  if(n_dot > n_dot_range) {
    if(do_trace) {
      v_eye = self get_eye();
      b_can_see = sighttracepassed(v_eye, v_point, 0, ent_or_org);
    } else {
      b_can_see = 1;
    }
  }
  return b_can_see;
}

function get_eye() {
  if(isplayer(self)) {
    linked_ent = self getlinkedent();
    if(isDefined(linked_ent) && getdvarint("cg_cameraUseTagCamera") > 0) {
      camera = linked_ent gettagorigin("tag_camera");
      if(isDefined(camera)) {
        return camera;
      }
    }
  }
  pos = self getEye();
  return pos;
}

function is_ads() {
  return self playerads() > 0.5;
}

function spawn_model(model_name, origin, angles, n_spawnflags = 0, b_throttle = 0) {
  if(b_throttle) {
    spawner::global_spawn_throttle(1);
  }
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }
  model = spawn("script_model", origin, n_spawnflags);
  model setModel(model_name);
  if(isDefined(angles)) {
    model.angles = angles;
  }
  return model;
}

function spawn_anim_model(model_name, origin, angles, n_spawnflags = 0, b_throttle) {
  model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
  model useanimtree($generic);
  model.animtree = "generic";
  return model;
}

function spawn_anim_player_model(model_name, origin, angles, n_spawnflags = 0) {
  model = spawn_model(model_name, origin, angles, n_spawnflags);
  model useanimtree($all_player);
  model.animtree = "all_player";
  return model;
}

function waittill_player_looking_at(origin, arc_angle_degrees = 90, do_trace, e_ignore) {
  self endon("death");
  arc_angle_degrees = absangleclamp360(arc_angle_degrees);
  dot = cos(arc_angle_degrees * 0.5);
  while(!is_player_looking_at(origin, dot, do_trace, e_ignore)) {
    wait(0.05);
  }
}

function waittill_player_not_looking_at(origin, dot, do_trace) {
  self endon("death");
  while(is_player_looking_at(origin, dot, do_trace)) {
    wait(0.05);
  }
}

function is_player_looking_at(origin, dot, do_trace, ignore_ent) {
  assert(isplayer(self), "");
  if(!isDefined(dot)) {
    dot = 0.7;
  }
  if(!isDefined(do_trace)) {
    do_trace = 1;
  }
  eye = self get_eye();
  delta_vec = vectornormalize(origin - eye);
  view_vec = anglesToForward(self getplayerangles());
  new_dot = vectordot(delta_vec, view_vec);
  if(new_dot >= dot) {
    if(do_trace) {
      return bullettracepassed(origin, eye, 0, ignore_ent);
    }
    return 1;
  }
  return 0;
}

function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4) {
  self endon(endonstring);
  if(isDefined(endonstring2)) {
    self endon(endonstring2);
  }
  if(isDefined(endonstring3)) {
    self endon(endonstring3);
  }
  if(isDefined(endonstring4)) {
    self endon(endonstring4);
  }
  wait(waittime);
  return true;
}

function waittillendonthreaded(waitcondition, callback, endcondition1, endcondition2, endcondition3) {
  if(isDefined(endcondition1)) {
    self endon(endcondition1);
  }
  if(isDefined(endcondition2)) {
    self endon(endcondition2);
  }
  if(isDefined(endcondition3)) {
    self endon(endcondition3);
  }
  self waittill(waitcondition);
  if(isDefined(callback)) {
    [[callback]](waitcondition);
  }
}

function new_timer(n_timer_length) {
  s_timer = spawnStruct();
  s_timer.n_time_created = gettime();
  s_timer.n_length = n_timer_length;
  return s_timer;
}

function get_time() {
  t_now = gettime();
  return t_now - self.n_time_created;
}

function get_time_in_seconds() {
  return get_time() / 1000;
}

function get_time_frac(n_end_time = self.n_length) {
  return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

function get_time_left() {
  if(isDefined(self.n_length)) {
    n_current_time = get_time_in_seconds();
    return max(self.n_length - n_current_time, 0);
  }
  return -1;
}

function is_time_left() {
  return get_time_left() != 0;
}

function timer_wait(n_wait) {
  if(isDefined(self.n_length)) {
    n_wait = min(n_wait, get_time_left());
  }
  wait(n_wait);
  n_current_time = get_time_in_seconds();
  return n_current_time;
}

function is_primary_damage(meansofdeath) {
  if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET") {
    return true;
  }
  return false;
}

function delete_on_death(ent) {
  ent endon("death");
  self waittill("death");
  if(isDefined(ent)) {
    ent delete();
  }
}

function delete_on_death_or_notify(e_to_delete, str_notify, str_clientfield = undefined) {
  e_to_delete endon("death");
  self waittill_either("death", str_notify);
  if(isDefined(e_to_delete)) {
    if(isDefined(str_clientfield)) {
      e_to_delete clientfield::set(str_clientfield, 0);
      wait(0.1);
    }
    e_to_delete delete();
  }
}

function wait_till_not_touching(e_to_check, e_to_touch) {
  assert(isDefined(e_to_check), "");
  assert(isDefined(e_to_touch), "");
  e_to_check endon("death");
  e_to_touch endon("death");
  while(e_to_check istouching(e_to_touch)) {
    wait(0.05);
  }
}

function any_player_is_touching(ent, str_team) {
  foreach(player in getplayers(str_team)) {
    if(isalive(player) && player istouching(ent)) {
      return true;
    }
  }
  return false;
}

function waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
  return true;
}

function set_console_status() {
  if(!isDefined(level.console)) {
    level.console = getdvarstring("consoleGame") == "true";
  } else {
    assert(level.console == getdvarstring("") == "", "");
  }
  if(!isDefined(level.consolexenon)) {
    level.xenon = getdvarstring("xenonGame") == "true";
  } else {
    assert(level.xenon == getdvarstring("") == "", "");
  }
}

function waittill_asset_loaded(str_type, str_name) {}

function script_wait(called_from_spawner = 0) {
  coop_scalar = 1;
  if(called_from_spawner) {
    players = getplayers();
    if(players.size == 2) {
      coop_scalar = 0.7;
    } else {
      if(players.size == 3) {
        coop_scalar = 0.4;
      } else if(players.size == 4) {
        coop_scalar = 0.1;
      }
    }
  }
  starttime = gettime();
  if(isDefined(self.script_wait)) {
    wait(self.script_wait * coop_scalar);
    if(isDefined(self.script_wait_add)) {
      self.script_wait = self.script_wait + self.script_wait_add;
    }
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait(randomfloatrange(self.script_wait_min, self.script_wait_max) * coop_scalar);
    if(isDefined(self.script_wait_add)) {
      self.script_wait_min = self.script_wait_min + self.script_wait_add;
      self.script_wait_max = self.script_wait_max + self.script_wait_add;
    }
  }
  return gettime() - starttime;
}

function is_killstreaks_enabled() {
  return isDefined(level.killstreaksenabled) && level.killstreaksenabled;
}

function is_flashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

function magic_bullet_shield(ent = self) {
  ent.allowdeath = 0;
  ent.magic_bullet_shield = 1;
  ent notify("_stop_magic_bullet_shield_debug");
  level thread debug_magic_bullet_shield_death(ent);
  assert(isalive(ent), "");
  if(isai(ent)) {
    if(isactor(ent)) {
      ent bloodimpact("hero");
    }
    ent.attackeraccuracy = 0.1;
  }
}

function debug_magic_bullet_shield_death(guy) {
  targetname = "none";
  if(isDefined(guy.targetname)) {
    targetname = guy.targetname;
  }
  guy endon("stop_magic_bullet_shield");
  guy endon("_stop_magic_bullet_shield_debug");
  guy waittill("death");
  assert(!isDefined(guy), "" + targetname);
}

function spawn_player_clone(player, animname) {
  playerclone = spawn("script_model", player.origin);
  playerclone.angles = player.angles;
  bodymodel = player getcharacterbodymodel();
  playerclone setModel(bodymodel);
  headmodel = player getcharacterheadmodel();
  if(isDefined(headmodel)) {
    playerclone attach(headmodel, "");
  }
  helmetmodel = player getcharacterhelmetmodel();
  if(isDefined(helmetmodel)) {
    playerclone attach(helmetmodel, "");
  }
  bodyrenderoptions = player getcharacterbodyrenderoptions();
  playerclone setbodyrenderoptions(bodyrenderoptions, bodyrenderoptions, bodyrenderoptions);
  playerclone useanimtree($all_player);
  if(isDefined(animname)) {
    playerclone animscripted("clone_anim", playerclone.origin, playerclone.angles, animname);
  }
  playerclone.health = 100;
  playerclone setowner(player);
  playerclone.team = player.team;
  playerclone solid();
  return playerclone;
}

function stop_magic_bullet_shield(ent = self) {
  ent.allowdeath = 1;
  ent.magic_bullet_shield = undefined;
  if(isai(ent)) {
    if(isactor(ent)) {
      ent bloodimpact("normal");
    }
    ent.attackeraccuracy = 1;
  }
  ent notify("stop_magic_bullet_shield");
}

function is_one_round() {
  if(level.roundlimit == 1) {
    return true;
  }
  return false;
}

function is_first_round() {
  if(level.roundlimit > 1 && game["roundsplayed"] == 0) {
    return true;
  }
  return false;
}

function is_lastround() {
  if(level.roundlimit > 1 && game["roundsplayed"] >= (level.roundlimit - 1)) {
    return true;
  }
  return false;
}

function get_rounds_won(team) {
  return game["roundswon"][team];
}

function get_other_teams_rounds_won(skip_team) {
  roundswon = 0;
  foreach(team in level.teams) {
    if(team == skip_team) {
      continue;
    }
    roundswon = roundswon + game["roundswon"][team];
  }
  return roundswon;
}

function get_rounds_played() {
  return game["roundsplayed"];
}

function is_round_based() {
  if(level.roundlimit != 1 && level.roundwinlimit != 1) {
    return true;
  }
  return false;
}

function within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

function button_held_think(which_button) {
  self endon("disconnect");
  if(!isDefined(self._holding_button)) {
    self._holding_button = [];
  }
  self._holding_button[which_button] = 0;
  time_started = 0;
  while(true) {
    if(self._holding_button[which_button]) {
      if(!self[[level._button_funcs[which_button]]]()) {
        self._holding_button[which_button] = 0;
      }
    } else {
      if(self[[level._button_funcs[which_button]]]()) {
        if(time_started == 0) {
          time_started = gettime();
        }
        if((gettime() - time_started) > 250) {
          self._holding_button[which_button] = 1;
        }
      } else if(time_started != 0) {
        time_started = 0;
      }
    }
    wait(0.05);
  }
}

function use_button_held() {
  init_button_wrappers();
  if(!isDefined(self._use_button_think_threaded)) {
    self thread button_held_think(0);
    self._use_button_think_threaded = 1;
  }
  return self._holding_button[0];
}

function stance_button_held() {
  init_button_wrappers();
  if(!isDefined(self._stance_button_think_threaded)) {
    self thread button_held_think(1);
    self._stance_button_think_threaded = 1;
  }
  return self._holding_button[1];
}

function ads_button_held() {
  init_button_wrappers();
  if(!isDefined(self._ads_button_think_threaded)) {
    self thread button_held_think(2);
    self._ads_button_think_threaded = 1;
  }
  return self._holding_button[2];
}

function attack_button_held() {
  init_button_wrappers();
  if(!isDefined(self._attack_button_think_threaded)) {
    self thread button_held_think(3);
    self._attack_button_think_threaded = 1;
  }
  return self._holding_button[3];
}

function button_right_held() {
  init_button_wrappers();
  if(!isDefined(self._dpad_right_button_think_threaded)) {
    self thread button_held_think(6);
    self._dpad_right_button_think_threaded = 1;
  }
  return self._holding_button[6];
}

function waittill_use_button_pressed() {
  while(!self usebuttonpressed()) {
    wait(0.05);
  }
}

function waittill_use_button_held() {
  while(!self use_button_held()) {
    wait(0.05);
  }
}

function waittill_stance_button_pressed() {
  while(!self stancebuttonpressed()) {
    wait(0.05);
  }
}

function waittill_stance_button_held() {
  while(!self stance_button_held()) {
    wait(0.05);
  }
}

function waittill_attack_button_pressed() {
  while(!self attackbuttonpressed()) {
    wait(0.05);
  }
}

function waittill_ads_button_pressed() {
  while(!self adsbuttonpressed()) {
    wait(0.05);
  }
}

function waittill_vehicle_move_up_button_pressed() {
  while(!self vehiclemoveupbuttonpressed()) {
    wait(0.05);
  }
}

function init_button_wrappers() {
  if(!isDefined(level._button_funcs)) {
    level._button_funcs[0] = &usebuttonpressed;
    level._button_funcs[2] = &adsbuttonpressed;
    level._button_funcs[3] = &attackbuttonpressed;
    level._button_funcs[1] = &stancebuttonpressed;
    level._button_funcs[6] = &actionslotfourbuttonpressed;
    level._button_funcs[4] = &up_button_pressed;
    level._button_funcs[5] = &down_button_pressed;
  }
}

function up_button_held() {
  init_button_wrappers();
  if(!isDefined(self._up_button_think_threaded)) {
    self thread button_held_think(4);
    self._up_button_think_threaded = 1;
  }
  return self._holding_button[4];
}

function down_button_held() {
  init_button_wrappers();
  if(!isDefined(self._down_button_think_threaded)) {
    self thread button_held_think(5);
    self._down_button_think_threaded = 1;
  }
  return self._holding_button[5];
}

function up_button_pressed() {
  return self buttonpressed("") || self buttonpressed("");
}

function waittill_up_button_pressed() {
  while(!self up_button_pressed()) {
    wait(0.05);
  }
}

function down_button_pressed() {
  return self buttonpressed("") || self buttonpressed("");
}

function waittill_down_button_pressed() {
  while(!self down_button_pressed()) {
    wait(0.05);
  }
}

function freeze_player_controls(b_frozen = 1) {
  if(isDefined(level.hostmigrationtimer)) {
    b_frozen = 1;
  }
  if(b_frozen || !level.gameended) {
    self freezecontrols(b_frozen);
  }
}

function is_bot() {
  return isplayer(self) && isDefined(self.pers["isBot"]) && self.pers["isBot"] != 0;
}

function ishacked() {
  return isDefined(self.hacked) && self.hacked;
}

function getlastweapon() {
  last_weapon = undefined;
  if(isDefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon)) {
    last_weapon = self.lastnonkillstreakweapon;
  } else if(isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
    last_weapon = self.lastdroppableweapon;
  }
  return last_weapon;
}

function isenemyplayer(player) {
  assert(isDefined(player));
  if(!isplayer(player)) {
    return false;
  }
  if(level.teambased) {
    if(player.team == self.team) {
      return false;
    }
  } else if(player == self) {
    return false;
  }
  return true;
}

function waittillslowprocessallowed() {
  while(level.lastslowprocessframe == gettime()) {
    wait(0.05);
  }
  level.lastslowprocessframe = gettime();
}

function get_start_time() {
  return getmicrosecondsraw();
}

function note_elapsed_time(start_time, label = "unknown") {
  elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
  if(!isDefined(start_time)) {
    return;
  }
  elapsed_time = elapsed_time * 0.001;
  if(!level.orbis) {
    elapsed_time = int(elapsed_time);
  }
  msg = ((label + "") + elapsed_time) + "";
  iprintln(msg);
}

function get_elapsed_time(start_time, end_time = getmicrosecondsraw()) {
  if(!isDefined(start_time)) {
    return undefined;
  }
  elapsed_time = end_time - start_time;
  if(elapsed_time < 0) {
    elapsed_time = elapsed_time + -2147483648;
  }
  return elapsed_time;
}

function mayapplyscreeneffect() {
  assert(isDefined(self));
  assert(isplayer(self));
  return !isDefined(self.viewlockedentity);
}

function waittillnotmoving() {
  if(self ishacked()) {
    wait(0.05);
    return;
  }
  if(self.classname == "grenade") {
    self waittill("stationary");
  } else {
    prevorigin = self.origin;
    while(true) {
      wait(0.15);
      if(self.origin == prevorigin) {
        break;
      }
      prevorigin = self.origin;
    }
  }
}

function waittillrollingornotmoving() {
  if(self ishacked()) {
    wait(0.05);
    return "stationary";
  }
  movestate = self waittill_any_return("stationary", "rolling");
  return movestate;
}

function getstatstablename() {
  if(sessionmodeiscampaigngame()) {
    return "gamedata/stats/cp/cp_statstable.csv";
  }
  if(sessionmodeiszombiesgame()) {
    return "gamedata/stats/zm/zm_statstable.csv";
  }
  return "gamedata/stats/mp/mp_statstable.csv";
}

function getweaponclass(weapon) {
  if(weapon == level.weaponnone) {
    return undefined;
  }
  if(!weapon.isvalid) {
    return undefined;
  }
  if(!isDefined(level.weaponclassarray)) {
    level.weaponclassarray = [];
  }
  if(isDefined(level.weaponclassarray[weapon])) {
    return level.weaponclassarray[weapon];
  }
  baseweaponparam = [[level.get_base_weapon_param]](weapon);
  baseweaponindex = getbaseweaponitemindex(baseweaponparam);
  weaponclass = tablelookup(getstatstablename(), 0, baseweaponindex, 2);
  level.weaponclassarray[weapon] = weaponclass;
  return weaponclass;
}

function isusingremote() {
  return isDefined(self.usingremote);
}

function deleteaftertime(time) {
  assert(isDefined(self));
  assert(isDefined(time));
  assert(time >= 0.05);
  self thread deleteaftertimethread(time);
}

function deleteaftertimethread(time) {
  self endon("death");
  wait(time);
  self delete();
}

function waitfortime(time = 0) {
  if(time > 0) {
    wait(time);
  }
}

function waitfortimeandnetworkframe(time = 0) {
  start_time_ms = gettime();
  wait_network_frame();
  elapsed_time = (gettime() - start_time_ms) * 0.001;
  remaining_time = time - elapsed_time;
  if(remaining_time > 0) {
    wait(remaining_time);
  }
}

function deleteaftertimeandnetworkframe(time) {
  assert(isDefined(self));
  waitfortimeandnetworkframe(time);
  self delete();
}

function drawcylinder(pos, rad, height, duration, stop_notify, color, alpha) {
  if(!isDefined(duration)) {
    duration = 0;
  }
  level thread drawcylinder_think(pos, rad, height, duration, stop_notify, color, alpha);
}

function drawcylinder_think(pos, rad, height, seconds, stop_notify, color, alpha) {
  if(isDefined(stop_notify)) {
    level endon(stop_notify);
  }
  stop_time = gettime() + (seconds * 1000);
  currad = rad;
  curheight = height;
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  if(!isDefined(alpha)) {
    alpha = 1;
  }
  for(;;) {
    if(seconds > 0 && stop_time <= gettime()) {
      return;
    }
    for(r = 0; r < 20; r++) {
      theta = (r / 20) * 360;
      theta2 = ((r + 1) / 20) * 360;
      line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, alpha);
      line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, alpha);
      line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, alpha);
    }
    wait(0.05);
  }
}

function get_team_alive_players_s(teamname) {
  teamplayers_s = spawn_array_struct();
  if(isDefined(teamname) && isDefined(level.aliveplayers) && isDefined(level.aliveplayers[teamname])) {
    for(i = 0; i < level.aliveplayers[teamname].size; i++) {
      teamplayers_s.a[teamplayers_s.a.size] = level.aliveplayers[teamname][i];
    }
  }
  return teamplayers_s;
}

function get_other_teams_alive_players_s(teamnametoignore) {
  teamplayers_s = spawn_array_struct();
  if(isDefined(teamnametoignore) && isDefined(level.aliveplayers)) {
    foreach(team in level.teams) {
      if(team == teamnametoignore) {
        continue;
      }
      foreach(player in level.aliveplayers[team]) {
        teamplayers_s.a[teamplayers_s.a.size] = player;
      }
    }
  }
  return teamplayers_s;
}

function get_all_alive_players_s() {
  allplayers_s = spawn_array_struct();
  if(isDefined(level.aliveplayers)) {
    keys = getarraykeys(level.aliveplayers);
    for(i = 0; i < keys.size; i++) {
      team = keys[i];
      for(j = 0; j < level.aliveplayers[team].size; j++) {
        allplayers_s.a[allplayers_s.a.size] = level.aliveplayers[team][j];
      }
    }
  }
  return allplayers_s;
}

function spawn_array_struct() {
  s = spawnStruct();
  s.a = [];
  return s;
}

function gethostplayer() {
  players = getplayers();
  for(index = 0; index < players.size; index++) {
    if(players[index] ishost()) {
      return players[index];
    }
  }
}

function gethostplayerforbots() {
  players = getplayers();
  for(index = 0; index < players.size; index++) {
    if(players[index] ishostforbots()) {
      return players[index];
    }
  }
}

function get_array_of_closest(org, array, excluders = [], max = array.size, maxdist) {
  maxdists2rd = undefined;
  if(isDefined(maxdist)) {
    maxdists2rd = maxdist * maxdist;
  }
  dist = [];
  index = [];
  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i])) {
      continue;
    }
    if(isinarray(excluders, array[i])) {
      continue;
    }
    if(isvec(array[i])) {
      length = distancesquared(org, array[i]);
    } else {
      length = distancesquared(org, array[i].origin);
    }
    if(isDefined(maxdists2rd) && maxdists2rd < length) {
      continue;
    }
    dist[dist.size] = length;
    index[index.size] = i;
  }
  for(;;) {
    change = 0;
    for(i = 0; i < (dist.size - 1); i++) {
      if(dist[i] <= (dist[i + 1])) {
        continue;
      }
      change = 1;
      temp = dist[i];
      dist[i] = dist[i + 1];
      dist[i + 1] = temp;
      temp = index[i];
      index[i] = index[i + 1];
      index[i + 1] = temp;
    }
    if(!change) {
      break;
    }
  }
  newarray = [];
  if(max > dist.size) {
    max = dist.size;
  }
  for(i = 0; i < max; i++) {
    newarray[i] = array[index[i]];
  }
  return newarray;
}

function set_lighting_state(n_state) {
  if(isDefined(n_state)) {
    self.lighting_state = n_state;
  } else {
    self.lighting_state = level.lighting_state;
  }
  if(isDefined(self.lighting_state)) {
    if(self == level) {
      if(isDefined(level.activeplayers)) {
        foreach(player in level.activeplayers) {
          player set_lighting_state(level.lighting_state);
        }
      }
    } else {
      if(isplayer(self)) {
        self setlightingstate(self.lighting_state);
      } else {
        assertmsg("");
      }
    }
  }
}

function set_sun_shadow_split_distance(f_distance) {
  if(isDefined(f_distance)) {
    self.sun_shadow_split_distance = f_distance;
  } else {
    self.sun_shadow_split_distance = level.sun_shadow_split_distance;
  }
  if(isDefined(self.sun_shadow_split_distance)) {
    if(self == level) {
      if(isDefined(level.activeplayers)) {
        foreach(player in level.activeplayers) {
          player set_sun_shadow_split_distance(level.sun_shadow_split_distance);
        }
      }
    } else {
      if(isplayer(self)) {
        self setsunshadowsplitdistance(self.sun_shadow_split_distance);
      } else {
        assertmsg("");
      }
    }
  }
}

function auto_delete(n_mode = 1, n_min_time_alive = 0, n_dist_horizontal = 0, n_dist_vertical = 0) {
  self endon("death");
  self notify("__auto_delete__");
  self endon("__auto_delete__");
  level flag::wait_till("all_players_spawned");
  if(isDefined(level.heroes) && isinarray(level.heroes, self)) {
    return;
  }
  if(n_mode & 16 || n_mode == 1 || n_mode == 8) {
    n_mode = n_mode | 2;
    n_mode = n_mode | 4;
  }
  n_think_time = 1;
  n_tests_to_do = 2;
  n_dot_check = 0;
  if(n_mode & 16) {
    n_think_time = 0.2;
    n_tests_to_do = 1;
    n_dot_check = 0.4;
  }
  n_test_count = 0;
  while(true) {
    do {
      wait(randomfloatrange(n_think_time - (n_think_time / 3), n_think_time + (n_think_time / 3)));
    }
    while(isDefined(self.birthtime) && ((gettime() - self.birthtime) / 1000) < n_min_time_alive);
    n_tests_passed = 0;
    foreach(player in level.players) {
      if(n_dist_horizontal && distance2dsquared(self.origin, player.origin) < n_dist_horizontal) {
        continue;
      }
      if(n_dist_vertical && (abs(self.origin[2] - player.origin[2])) < n_dist_vertical) {
        continue;
      }
      v_eye = player getEye();
      b_behind = 0;
      if(n_mode & 2) {
        v_facing = anglesToForward(player getplayerangles());
        v_to_ent = vectornormalize(self.origin - v_eye);
        n_dot = vectordot(v_facing, v_to_ent);
        if(n_dot < n_dot_check) {
          b_behind = 1;
          if(!n_mode & 1) {
            n_tests_passed++;
            continue;
          }
        }
      }
      if(n_mode & 4) {
        if(!self sightconetrace(v_eye, player)) {
          if(b_behind || !n_mode & 1) {
            n_tests_passed++;
          }
        }
      }
    }
    if(n_tests_passed == level.players.size) {
      n_test_count++;
      if(n_test_count < n_tests_to_do) {
        continue;
      }
      self notify("_disable_reinforcement");
      self delete();
    } else {
      n_test_count = 0;
    }
  }
}

function query_ents(&a_kvps_match, b_match_all = 1, &a_kvps_ingnore, b_ignore_spawners = 0, b_match_substrings = 0) {
  a_ret = [];
  if(b_match_substrings) {
    a_all_ents = getEntArray();
    b_first = 1;
    foreach(k, v in a_kvps_match) {
      a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
      if(b_first) {
        a_ret = a_ents;
        b_first = 0;
        continue;
      }
      if(b_match_all) {
        a_ret = arrayintersect(a_ret, a_ents);
        continue;
      }
      a_ret = arraycombine(a_ret, a_ents, 0, 0);
    }
    if(isDefined(a_kvps_ingnore)) {
      foreach(k, v in a_kvps_ingnore) {
        a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
        a_ret = array::exclude(a_ret, a_ents);
      }
    }
  } else {
    b_first = 1;
    foreach(k, v in a_kvps_match) {
      a_ents = getEntArray(v, k);
      if(b_first) {
        a_ret = a_ents;
        b_first = 0;
        continue;
      }
      if(b_match_all) {
        a_ret = arrayintersect(a_ret, a_ents);
        continue;
      }
      a_ret = arraycombine(a_ret, a_ents, 0, 0);
    }
    if(isDefined(a_kvps_ingnore)) {
      foreach(k, v in a_kvps_ingnore) {
        a_ents = getEntArray(v, k);
        a_ret = array::exclude(a_ret, a_ents);
      }
    }
  }
  return a_ret;
}

function _query_ents_by_substring_helper(&a_ents, str_value, str_key = "targetname", b_ignore_spawners = 0) {
  a_ret = [];
  foreach(ent in a_ents) {
    if(b_ignore_spawners && isspawner(ent)) {
      continue;
    }
    switch (str_key) {
      case "targetname": {
        if(isstring(ent.targetname) && issubstr(ent.targetname, str_value)) {
          if(!isDefined(a_ret)) {
            a_ret = [];
          } else if(!isarray(a_ret)) {
            a_ret = array(a_ret);
          }
          a_ret[a_ret.size] = ent;
        }
        break;
      }
      case "script_noteworthy": {
        if(isstring(ent.script_noteworthy) && issubstr(ent.script_noteworthy, str_value)) {
          if(!isDefined(a_ret)) {
            a_ret = [];
          } else if(!isarray(a_ret)) {
            a_ret = array(a_ret);
          }
          a_ret[a_ret.size] = ent;
        }
        break;
      }
      case "classname": {
        if(isstring(ent.classname) && issubstr(ent.classname, str_value)) {
          if(!isDefined(a_ret)) {
            a_ret = [];
          } else if(!isarray(a_ret)) {
            a_ret = array(a_ret);
          }
          a_ret[a_ret.size] = ent;
        }
        break;
      }
      case "vehicletype": {
        if(isstring(ent.vehicletype) && issubstr(ent.vehicletype, str_value)) {
          if(!isDefined(a_ret)) {
            a_ret = [];
          } else if(!isarray(a_ret)) {
            a_ret = array(a_ret);
          }
          a_ret[a_ret.size] = ent;
        }
        break;
      }
      case "script_string": {
        if(isstring(ent.script_string) && issubstr(ent.script_string, str_value)) {
          if(!isDefined(a_ret)) {
            a_ret = [];
          } else if(!isarray(a_ret)) {
            a_ret = array(a_ret);
          }
          a_ret[a_ret.size] = ent;
        }
        break;
      }
      case "script_color_axis": {
        if(isstring(ent.script_color_axis) && issubstr(ent.script_color_axis, str_value)) {
          if(!isDefined(a_ret)) {
            a_ret = [];
          } else if(!isarray(a_ret)) {
            a_ret = array(a_ret);
          }
          a_ret[a_ret.size] = ent;
        }
        break;
      }
      case "script_color_allies": {
        if(isstring(ent.script_color_axis) && issubstr(ent.script_color_axis, str_value)) {
          if(!isDefined(a_ret)) {
            a_ret = [];
          } else if(!isarray(a_ret)) {
            a_ret = array(a_ret);
          }
          a_ret[a_ret.size] = ent;
        }
        break;
      }
      default: {
        assert(("" + str_key) + "");
      }
    }
  }
  return a_ret;
}

function get_weapon_by_name(weapon_name) {
  split = strtok(weapon_name, "+");
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
    case 6: {
      weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5]);
      break;
    }
    case 7: {
      weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6]);
      break;
    }
    case 8: {
      weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6], split[7]);
      break;
    }
    case 9: {
      weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6], split[7], split[8]);
      break;
    }
  }
  return weapon;
}

function is_female() {
  gender = self getplayergendertype(currentsessionmode());
  b_female = 0;
  if(isDefined(gender) && gender == "female") {
    b_female = 1;
  }
  return b_female;
}

function positionquery_pointarray(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent) {
  if(isDefined(reachableby_ent)) {
    queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent);
  } else {
    queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing);
  }
  pointarray = [];
  foreach(pointstruct in queryresult.data) {
    if(!isDefined(pointarray)) {
      pointarray = [];
    } else if(!isarray(pointarray)) {
      pointarray = array(pointarray);
    }
    pointarray[pointarray.size] = pointstruct.origin;
  }
  return pointarray;
}

function totalplayercount() {
  count = 0;
  foreach(team in level.teams) {
    count = count + level.playercount[team];
  }
  return count;
}

function isrankenabled() {
  return isDefined(level.rankenabled) && level.rankenabled;
}

function isoneround() {
  if(level.roundlimit == 1) {
    return true;
  }
  return false;
}

function isfirstround() {
  if(level.roundlimit > 1 && game["roundsplayed"] == 0) {
    return true;
  }
  return false;
}

function islastround() {
  if(level.roundlimit > 1 && game["roundsplayed"] >= (level.roundlimit - 1)) {
    return true;
  }
  return false;
}

function waslastround() {
  if(level.forcedend) {
    return true;
  }
  if(isDefined(level.shouldplayovertimeround)) {
    if([[level.shouldplayovertimeround]]()) {
      level.nextroundisovertime = 1;
      return false;
    }
    if(isDefined(game["overtime_round"])) {
      return true;
    }
  }
  if(hitroundlimit() || hitscorelimit() || hitroundwinlimit()) {
    return true;
  }
  return false;
}

function hitroundlimit() {
  if(level.roundlimit <= 0) {
    return 0;
  }
  return getroundsplayed() >= level.roundlimit;
}

function anyteamhitroundwinlimit() {
  foreach(team in level.teams) {
    if(getroundswon(team) >= level.roundwinlimit) {
      return true;
    }
  }
  return false;
}

function anyteamhitroundlimitwithdraws() {
  tie_wins = game["roundswon"]["tie"];
  foreach(team in level.teams) {
    if((getroundswon(team) + tie_wins) >= level.roundwinlimit) {
      return true;
    }
  }
  return false;
}

function getroundwinlimitwinningteam() {
  max_wins = 0;
  winning_team = undefined;
  foreach(team in level.teams) {
    wins = getroundswon(team);
    if(!isDefined(winning_team)) {
      max_wins = wins;
      winning_team = team;
      continue;
    }
    if(wins == max_wins) {
      winning_team = "tie";
      continue;
    }
    if(wins > max_wins) {
      max_wins = wins;
      winning_team = team;
    }
  }
  return winning_team;
}

function hitroundwinlimit() {
  if(!isDefined(level.roundwinlimit) || level.roundwinlimit <= 0) {
    return false;
  }
  if(anyteamhitroundwinlimit()) {
    return true;
  }
  if(anyteamhitroundlimitwithdraws()) {
    if(getroundwinlimitwinningteam() != "tie") {
      return true;
    }
  }
  return false;
}

function any_team_hit_score_limit() {
  foreach(team in level.teams) {
    if(game["teamScores"][team] >= level.scorelimit) {
      return true;
    }
  }
  return false;
}

function hitscorelimit() {
  if(level.scoreroundwinbased) {
    return false;
  }
  if(level.scorelimit <= 0) {
    return false;
  }
  if(level.teambased) {
    if(any_team_hit_score_limit()) {
      return true;
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isDefined(player.pointstowin) && player.pointstowin >= level.scorelimit) {
        return true;
      }
    }
  }
  return false;
}

function get_current_round_score_limit() {
  return level.roundscorelimit * (game["roundsplayed"] + 1);
}

function any_team_hit_round_score_limit() {
  round_score_limit = get_current_round_score_limit();
  foreach(team in level.teams) {
    if(game["teamScores"][team] >= round_score_limit) {
      return true;
    }
  }
  return false;
}

function hitroundscorelimit() {
  if(level.roundscorelimit <= 0) {
    return false;
  }
  if(level.teambased) {
    if(any_team_hit_round_score_limit()) {
      return true;
    }
  } else {
    roundscorelimit = get_current_round_score_limit();
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isDefined(player.pointstowin) && player.pointstowin >= roundscorelimit) {
        return true;
      }
    }
  }
  return false;
}

function getroundswon(team) {
  return game["roundswon"][team];
}

function getotherteamsroundswon(skip_team) {
  roundswon = 0;
  foreach(team in level.teams) {
    if(team == skip_team) {
      continue;
    }
    roundswon = roundswon + game["roundswon"][team];
  }
  return roundswon;
}

function getroundsplayed() {
  return game["roundsplayed"];
}

function isroundbased() {
  if(level.roundlimit != 1 && level.roundwinlimit != 1) {
    return true;
  }
  return false;
}

function getcurrentgamemode() {
  if(gamemodeismode(6)) {
    return "leaguematch";
  }
  return "publicmatch";
}

function ground_position(v_start, n_max_dist = 5000, n_ground_offset = 0, e_ignore, b_ignore_water = 0, b_ignore_glass = 0) {
  v_trace_start = v_start + (0, 0, 5);
  v_trace_end = v_trace_start + (0, 0, (n_max_dist + 5) * -1);
  a_trace = groundtrace(v_trace_start, v_trace_end, 0, e_ignore, b_ignore_water, b_ignore_glass);
  if(a_trace["surfacetype"] != "none") {
    return a_trace["position"] + (0, 0, n_ground_offset);
  }
  return v_start;
}

function delayed_notify(str_notify, f_delay_seconds) {
  wait(f_delay_seconds);
  if(isDefined(self)) {
    self notify(str_notify);
  }
}

function delayed_delete(str_notify, f_delay_seconds) {
  assert(isentity(self));
  wait(f_delay_seconds);
  if(isDefined(self) && isentity(self)) {
    self delete();
  }
}

function do_chyron_text(str_1_full, str_1_short, str_2_full, str_2_short, str_3_full, str_3_short, str_4_full, str_4_short, str_5_full = "", str_5_short = "", n_duration = 12) {
  level.chyron_text_active = 1;
  level flagsys::set("chyron_active");
  foreach(player in level.players) {
    player thread player_set_chyron_menu(str_1_full, str_1_short, str_2_full, str_2_short, str_3_full, str_3_short, str_4_full, str_4_short, str_5_full, str_5_short, n_duration);
  }
  level waittill("chyron_menu_closed");
  level.chyron_text_active = undefined;
  level flagsys::clear("chyron_active");
}

function player_set_chyron_menu(str_1_full, str_1_short, str_2_full, str_2_short, str_3_full, str_3_short, str_4_full, str_4_short, str_5_full = "", str_5_short = "", n_duration) {
  self endon("disconnect");
  assert(isDefined(n_duration), "");
  menuhandle = self openluimenu("CPChyron");
  self setluimenudata(menuhandle, "line1full", str_1_full);
  self setluimenudata(menuhandle, "line1short", str_1_short);
  self setluimenudata(menuhandle, "line2full", str_2_full);
  self setluimenudata(menuhandle, "line2short", str_2_short);
  mapname = getdvarstring("mapname");
  hideline3full = 0;
  if(mapname == "cp_mi_eth_prologue" && sessionmodeiscampaignzombiesgame()) {
    hideline3full = 1;
  }
  if(!hideline3full) {
    self setluimenudata(menuhandle, "line3full", str_3_full);
    self setluimenudata(menuhandle, "line3short", str_3_short);
  }
  if(!sessionmodeiscampaignzombiesgame()) {
    self setluimenudata(menuhandle, "line4full", str_4_full);
    self setluimenudata(menuhandle, "line4short", str_4_short);
    self setluimenudata(menuhandle, "line5full", str_5_full);
    self setluimenudata(menuhandle, "line5short", str_5_short);
  }
  waittillframeend();
  self notify("chyron_menu_open");
  level notify("chyron_menu_open");
  do {
    self waittill("menuresponse", menu, response);
  }
  while(menu != "CPChyron" || response != "closed");
  self notify("chyron_menu_closed");
  level notify("chyron_menu_closed");
  wait(5);
  self closeluimenu(menuhandle);
}

function get_next_safehouse(str_next_map) {
  switch (str_next_map) {
    case "cp_mi_sing_biodomes":
    case "cp_mi_sing_blackstation":
    case "cp_mi_sing_sgen": {
      return "cp_sh_singapore";
    }
    case "cp_mi_cairo_aquifer":
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_lotus": {
      return "cp_sh_cairo";
    }
    default: {
      return "cp_sh_mobile";
    }
  }
}

function is_safehouse() {
  mapname = tolower(getdvarstring("mapname"));
  if(mapname == "cp_sh_cairo" || mapname == "cp_sh_mobile" || mapname == "cp_sh_singapore") {
    return true;
  }
  return false;
}

function is_new_cp_map() {
  mapname = tolower(getdvarstring("mapname"));
  switch (mapname) {
    case "cp_mi_cairo_aquifer":
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_lotus":
    case "cp_mi_cairo_ramses":
    case "cp_mi_eth_prologue":
    case "cp_mi_sing_biodomes":
    case "cp_mi_sing_blackstation":
    case "cp_mi_sing_chinatown":
    case "cp_mi_sing_sgen":
    case "cp_mi_sing_vengeance":
    case "cp_mi_zurich_coalescene":
    case "cp_mi_zurich_newworld": {
      return true;
    }
    default: {
      return false;
    }
  }
}

function add_queued_debug_command(cmd) {
  if(!isDefined(level.dbg_cmd_queue)) {
    level thread queued_debug_commands();
  }
  if(isDefined(level.dbg_cmd_queue)) {
    array::push(level.dbg_cmd_queue, cmd, 0);
  }
}

function queued_debug_commands() {
  self notify("queued_debug_commands");
  self endon("queued_debug_commands");
  if(!isDefined(level.dbg_cmd_queue)) {
    level.dbg_cmd_queue = [];
  }
  while(true) {
    wait(0.05);
    if(level.dbg_cmd_queue.size == 0) {
      level.dbg_cmd_queue = undefined;
      return;
    }
    cmd = array::pop_front(level.dbg_cmd_queue, 0);
    adddebugcommand(cmd);
  }
}

function player_lock_control() {
  if(self == level) {
    foreach(e_player in level.activeplayers) {
      e_player freeze_player_controls(1);
      e_player scene::set_igc_active(1);
      level notify("disable_cybercom", e_player, 1);
      e_player show_hud(0);
    }
  } else {
    self freeze_player_controls(1);
    self scene::set_igc_active(1);
    level notify("disable_cybercom", self, 1);
    self show_hud(0);
  }
}

function player_unlock_control() {
  if(self == level) {
    foreach(e_player in level.activeplayers) {
      e_player freeze_player_controls(0);
      e_player scene::set_igc_active(0);
      level notify("enable_cybercom", e_player);
      e_player show_hud(1);
    }
  } else {
    self freeze_player_controls(0);
    self scene::set_igc_active(0);
    level notify("enable_cybercom", e_player);
    self show_hud(1);
  }
}

function show_hud(b_show) {
  if(b_show) {
    if(!(isDefined(self.fullscreen_black_active) && self.fullscreen_black_active)) {
      if(!self flagsys::get("playing_movie_hide_hud")) {
        if(!scene::is_igc_active()) {
          if(!(isDefined(self.dont_show_hud) && self.dont_show_hud)) {
            self setclientuivisibilityflag("hud_visible", 1);
          }
        }
      }
    }
  } else {
    self setclientuivisibilityflag("hud_visible", 0);
  }
}

function array_copy_if_array(any_var) {
  return (isarray(any_var) ? arraycopy(any_var) : any_var);
}

function is_item_purchased(ref) {
  itemindex = getitemindexfromref(ref);
  return (itemindex >= 256 ? 0 : self isitempurchased(itemindex));
}

function has_purchased_perk_equipped(ref) {
  return self hasperk(ref) && self is_item_purchased(ref);
}

function has_purchased_perk_equipped_with_specific_stat(single_perk_ref, stats_table_ref) {
  if(isplayer(self)) {
    return self hasperk(single_perk_ref) && self is_item_purchased(stats_table_ref);
  }
  return 0;
}

function has_flak_jacket_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped("specialty_flakjacket");
}

function has_blind_eye_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat("specialty_nottargetedbyairsupport", "specialty_nottargetedbyairsupport|specialty_nokillstreakreticle");
}

function has_ghost_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped("specialty_gpsjammer");
}

function has_tactical_mask_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat("specialty_stunprotection", "specialty_stunprotection|specialty_flashprotection|specialty_proximityprotection");
}

function has_hacker_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat("specialty_showenemyequipment", "specialty_showenemyequipment|specialty_showscorestreakicons|specialty_showenemyvehicles");
}

function has_cold_blooded_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat("specialty_nottargetedbyaitank", "specialty_nottargetedbyaitank|specialty_nottargetedbyraps|specialty_nottargetedbysentry|specialty_nottargetedbyrobot|specialty_immunenvthermal");
}

function has_hard_wired_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat("specialty_immunecounteruav", "specialty_immunecounteruav|specialty_immuneemp|specialty_immunetriggerc4|specialty_immunetriggershock|specialty_immunetriggerbetty|specialty_sixthsensejammer|specialty_trackerjammer|specialty_immunesmoke");
}

function has_gung_ho_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat("specialty_sprintfire", "specialty_sprintfire|specialty_sprintgrenadelethal|specialty_sprintgrenadetactical|specialty_sprintequipment");
}

function has_fast_hands_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat("specialty_fastweaponswitch", "specialty_fastweaponswitch|specialty_sprintrecovery|specialty_sprintfirerecovery");
}

function has_scavenger_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped("specialty_scavenger");
}

function has_jetquiet_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat("specialty_jetquiet", "specialty_jetnoradar|specialty_jetquiet");
}

function has_awareness_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped("specialty_loudenemies");
}

function has_ninja_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped("specialty_quieter");
}

function has_toughness_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped("specialty_bulletflinch");
}

function str_strip_lh(str) {
  if(strendswith(str, "_lh")) {
    return getsubstr(str, 0, str.size - 3);
  }
  return str;
}

function trackwallrunningdistance() {
  self endon("disconnect");
  self.movementtracking.wallrunning = spawnStruct();
  self.movementtracking.wallrunning.distance = 0;
  self.movementtracking.wallrunning.count = 0;
  self.movementtracking.wallrunning.time = 0;
  while(true) {
    self waittill("wallrun_begin");
    startpos = self.origin;
    starttime = gettime();
    self.movementtracking.wallrunning.count++;
    self waittill("wallrun_end");
    self.movementtracking.wallrunning.distance = self.movementtracking.wallrunning.distance + distance(startpos, self.origin);
    self.movementtracking.wallrunning.time = self.movementtracking.wallrunning.time + (gettime() - starttime);
  }
}

function tracksprintdistance() {
  self endon("disconnect");
  self.movementtracking.sprinting = spawnStruct();
  self.movementtracking.sprinting.distance = 0;
  self.movementtracking.sprinting.count = 0;
  self.movementtracking.sprinting.time = 0;
  while(true) {
    self waittill("sprint_begin");
    startpos = self.origin;
    starttime = gettime();
    self.movementtracking.sprinting.count++;
    self waittill("sprint_end");
    self.movementtracking.sprinting.distance = self.movementtracking.sprinting.distance + distance(startpos, self.origin);
    self.movementtracking.sprinting.time = self.movementtracking.sprinting.time + (gettime() - starttime);
  }
}

function trackdoublejumpdistance() {
  self endon("disconnect");
  self.movementtracking.doublejump = spawnStruct();
  self.movementtracking.doublejump.distance = 0;
  self.movementtracking.doublejump.count = 0;
  self.movementtracking.doublejump.time = 0;
  while(true) {
    self waittill("doublejump_begin");
    startpos = self.origin;
    starttime = gettime();
    self.movementtracking.doublejump.count++;
    self waittill("doublejump_end");
    self.movementtracking.doublejump.distance = self.movementtracking.doublejump.distance + distance(startpos, self.origin);
    self.movementtracking.doublejump.time = self.movementtracking.doublejump.time + (gettime() - starttime);
  }
}

function getplayspacecenter() {
  minimaporigins = getEntArray("minimap_corner", "targetname");
  if(minimaporigins.size) {
    return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
  }
  return (0, 0, 0);
}

function getplayspacemaxwidth() {
  minimaporigins = getEntArray("minimap_corner", "targetname");
  if(minimaporigins.size) {
    x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
    y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
    return max(x, y);
  }
  return 0;
}

function function_e2ac06bb(menu_path, commands) {
  adddebugcommand(((("devgui_cmd \"" + menu_path) + "\" \"") + commands) + "\"\n");
}

function function_181cbd1a(menu_path) {
  adddebugcommand(("devgui_remove \"" + menu_path) + "\"\n");
}

function function_a4c90358(counter_name, amount) {
  if(getdvarint("live_enableCounters", 0)) {
    incrementcounter(counter_name, amount);
  }
}

function function_ad904acd() {
  if(getdvarint("live_enableCounters", 0)) {
    forceuploadcounters();
  }
}

function function_522d8c7d(amount) {
  if(getdvarint("ui_enablePromoTracking", 0)) {
    function_a4c90358("zmhd_thermometer", amount);
  }
}