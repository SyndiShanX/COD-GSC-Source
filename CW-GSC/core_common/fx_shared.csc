/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\fx_shared.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace fx;

function private autoexec __init__system__() {
  system::register(#"fx", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_localclient_connect(&player_init);
  callback::on_spawned(&on_player_spawned);
  function_1725d99a();
}

function on_player_spawned(localclientnum) {
  if(self function_21c0fa55() && getdvarint(#"hash_c11502c9fcc6e8d", 0)) {
    self thread function_3b26f98c(localclientnum);
  }
}

function player_init(clientnum) {
  if(!isDefined(level.createfxent)) {
    return;
  }

  creatingexploderarray = 0;

  if(!isDefined(level.createfxexploders)) {
    creatingexploderarray = 1;
    level.createfxexploders = [];
  }

  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];

    if(!isDefined(level._createfxforwardandupset)) {
      if(!isDefined(level._createfxforwardandupset)) {
        ent set_forward_and_up_vectors();
      }
    }

    if(ent.v[# "type"] == "loopfx") {
      ent thread loop_thread(clientnum);
    }

    if(ent.v[# "type"] == "oneshotfx") {
      ent thread oneshot_thread(clientnum);
    }

    if(ent.v[# "type"] == "soundfx") {
      ent thread loop_sound(clientnum);
    }

    if(creatingexploderarray && ent.v[# "type"] == "exploder") {
      if(!isDefined(level.createfxexploders[ent.v[# "exploder"]])) {
        level.createfxexploders[ent.v[# "exploder"]] = [];
      }

      ent.v[# "exploder_id"] = exploder::getexploderid(ent);
      level.createfxexploders[ent.v[# "exploder"]][level.createfxexploders[ent.v[# "exploder"]].size] = ent;
    }
  }

  level._createfxforwardandupset = 1;
}

function validate(fxid, origin) {
  if(!isDefined(level._effect[fxid])) {
    assertmsg("<dev string:x38>" + fxid + "<dev string:x4f>" + origin);
  }
}

function create_loop_sound() {
  ent = spawnStruct();

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v[# "type"] = "soundfx";
  ent.v[# "fxid"] = "No FX";
  ent.v[# "soundalias"] = "nil";
  ent.v[# "angles"] = (0, 0, 0);
  ent.v[# "origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

function create_effect(type, fxid) {
  ent = spawnStruct();

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  level.createfxent[level.createfxent.size] = ent;
  ent.v = [];
  ent.v[# "type"] = type;
  ent.v[# "fxid"] = fxid;
  ent.v[# "angles"] = (0, 0, 0);
  ent.v[# "origin"] = (0, 0, 0);
  ent.drawn = 1;
  return ent;
}

function create_oneshot_effect(fxid) {
  ent = create_effect("oneshotfx", fxid);
  ent.v[# "delay"] = -15;
  return ent;
}

function create_loop_effect(fxid) {
  ent = create_effect("loopfx", fxid);
  ent.v[# "delay"] = 0.5;
  return ent;
}

function set_forward_and_up_vectors() {
  self.v[# "up"] = anglestoup(self.v[# "angles"]);
  self.v[# "forward"] = anglesToForward(self.v[# "angles"]);
}

function oneshot_thread(clientnum) {
  if(self.v[# "delay"] > 0) {
    wait self.v[# "delay"];
  }

  create_trigger(clientnum);
}

function report_num_effects() {}

function loop_sound(clientnum) {
  if(clientnum != 0) {
    return;
  }

  self notify(#"stop_loop");

  if(isDefined(self.v[# "soundalias"]) && self.v[# "soundalias"] != "nil") {
    if(isDefined(self.v[# "stopable"]) && self.v[# "stopable"]) {
      thread sound::loop_fx_sound(clientnum, self.v[# "soundalias"], self.v[# "origin"], "stop_loop");
      return;
    }

    thread sound::loop_fx_sound(clientnum, self.v[# "soundalias"], self.v[# "origin"]);
  }
}

function lightning(normalfunc, flashfunc) {
  [[flashfunc]]();
  wait randomfloatrange(0.05, 0.1);
  [[normalfunc]]();
}

function loop_thread(clientnum) {
  if(isDefined(self.fxstart)) {
    level waittill("start fx" + self.fxstart);
  }

  while(true) {
    create_looper(clientnum);

    if(isDefined(self.timeout)) {
      thread loop_stop(clientnum, self.timeout);
    }

    if(isDefined(self.fxstop)) {
      level waittill("stop fx" + self.fxstop);
    } else {
      return;
    }

    if(isDefined(self.looperfx)) {
      deletefx(clientnum, self.looperfx);
    }

    if(isDefined(self.fxstart)) {
      level waittill("start fx" + self.fxstart);
      continue;
    }

    return;
  }
}

function loop_stop(clientnum, timeout) {
  self endon(#"death");
  wait timeout;

  if(isDefined(self.looper)) {
    deletefx(clientnum, self.looper);
  }
}

function create_looper(clientnum) {
  self thread loop(clientnum);
  loop_sound(clientnum);
}

function loop(clientnum) {
  validate(self.v[# "fxid"], self.v[# "origin"]);
  self.looperfx = playFX(clientnum, level._effect[self.v[# "fxid"]], self.v[# "origin"], self.v[# "forward"], self.v[# "up"], self.v[# "delay"], self.v[# "primlightfrac"], self.v[# "lightoriginoffs"]);

  while(true) {
    if(isDefined(self.v[# "delay"])) {
      wait self.v[# "delay"];
    }

    while(isfxplaying(clientnum, self.looperfx)) {
      wait 0.25;
    }

    self.looperfx = playFX(clientnum, level._effect[self.v[# "fxid"]], self.v[# "origin"], self.v[# "forward"], self.v[# "up"], 0, self.v[# "primlightfrac"], self.v[# "lightoriginoffs"]);
  }
}

function create_trigger(clientnum) {
  validate(self.v[# "fxid"], self.v[# "origin"]);

  if(getdvarint(#"debug_fx", 0) > 0) {
    println("<dev string:x59>" + self.v[# "fxid"]);
  }

  self.looperfx = playFX(clientnum, level._effect[self.v[# "fxid"]], self.v[# "origin"], self.v[# "forward"], self.v[# "up"], self.v[# "delay"], self.v[# "primlightfrac"], self.v[# "lightoriginoffs"]);
  loop_sound(clientnum);
}

function function_3539a829(local_client_num, friendly_fx, enemy_fx, tag) {
  if(self function_ca024039()) {
    return util::playFXOnTag(local_client_num, friendly_fx, self, tag);
  }

  return util::playFXOnTag(local_client_num, enemy_fx, self, tag);
}

function function_94d3d1d(local_client_num, friendly_fx, enemy_fx, origin) {
  if(self function_ca024039()) {
    return playFX(local_client_num, friendly_fx, origin);
  }

  return playFX(local_client_num, enemy_fx, origin);
}

function blinky_light(localclientnum, tagname, friendlyfx, enemyfx) {
  self endon(#"death");
  self endon(#"stop_blinky_light");
  self.lighttagname = tagname;
  self util::waittill_dobj(localclientnum);
  self thread blinky_emp_wait(localclientnum);

  while(true) {
    if(isDefined(self.stunned) && self.stunned) {
      wait 0.1;
      continue;
    }

    if(isDefined(self)) {
      self function_3539a829(localclientnum, friendlyfx, enemyfx, self.lighttagname);
    }

    util::server_wait(localclientnum, 0.5, 0.016);
  }
}

function stop_blinky_light(localclientnum) {
  self notify(#"stop_blinky_light");

  if(!isDefined(self.blinkylightfx)) {
    return;
  }

  stopfx(localclientnum, self.blinkylightfx);
  self.blinkylightfx = undefined;
}

function blinky_emp_wait(localclientnum) {
  self endon(#"death");
  self endon(#"stop_blinky_light");
  self waittill(#"emp");
  self stop_blinky_light(localclientnum);
}

function function_3b26f98c(localclientnum) {
  self notify(#"hash_348eb868068f5fa3");
  self endon(#"death", #"hash_348eb868068f5fa3");

  while(true) {
    self waittill(#"weapon_fired");
    self postfx::playpostfxbundle(#"hash_6d2d4591d1249a6e");
    n_lerp_time = getdvarint(#"hash_3f9892863b8f6bb0", 50);
    var_cfd68180 = getdvarfloat(#"hash_1e859abbf35194ee", -1);
    self util::lerp_generic(localclientnum, n_lerp_time, &function_29150e99, 0, var_cfd68180, #"hash_31ad23226325090", #"hash_6d2d4591d1249a6e");
    self util::lerp_generic(localclientnum, n_lerp_time, &function_29150e99, var_cfd68180, 0.15, #"hash_31ad23226325090", #"hash_6d2d4591d1249a6e");
    self util::lerp_generic(localclientnum, n_lerp_time, &function_29150e99, 0.15, 0, #"hash_31ad23226325090", #"hash_6d2d4591d1249a6e");
    self codestoppostfxbundle(#"hash_6d2d4591d1249a6e");
  }
}

function function_29150e99(current_time, elapsed_time, local_client_num, duration, var_8a5c2b54, var_dc3fdb72, constant, postfx) {
  percent = local_client_num / duration;
  amount = var_dc3fdb72 * percent + var_8a5c2b54 * (1 - percent);
  self function_116b95e5(postfx, constant, amount);
}

function private function_1725d99a() {
  function_5ac4dc99("_internal_dof_i_target_type", -1);
  function_5ac4dc99("_internal_dof_i_target_entnum", -1);
  function_5ac4dc99("_internal_dof_v_target_origin", (-1, -1, -1));
  function_5ac4dc99("_internal_dof_i_playernum", -1);
  function_5ac4dc99("_internal_dof_s_target_tag", "-1");
  function_5ac4dc99("_internal_dof_f_fstop", -1);
  function_5ac4dc99("_internal_dof_f_fstop_time", -1);
  function_5ac4dc99("_internal_dof_f_focus_time", -1);
  function_5ac4dc99("_internal_dof_i_refcounter", 0);
  function_cd140ee9("_internal_dof_i_refcounter", &function_a795470c);
  function_5ac4dc99("_internal_fob_i_playernum", -1);
  function_5ac4dc99("_internal_fob_f_fstop", 1);
  function_5ac4dc99("_internal_fob_f_fstop_time", -1);
  function_5ac4dc99("_internal_fob_i_refcounter", 0);
  function_5ac4dc99("_internal_debug_dof", 0);
  function_cd140ee9("_internal_fob_i_refcounter", &function_5409b584);
}

function function_a795470c() {
  players = getlocalplayers();

  foreach(player in players) {
    if(player getentitynumber() == getdvarint(#"_internal_dof_i_playernum", -1)) {
      var_1498bcbe = undefined;
      var_3ed74fac = getdvarint(#"_internal_dof_i_target_entnum", -1);

      if(var_3ed74fac == -1) {
        var_3ed74fac = undefined;
      }

      var_dc3df1b8 = getdvarint(#"_internal_dof_i_target_type", -1);

      if(var_dc3df1b8 == -1) {
        var_dc3df1b8 = undefined;
      }

      var_1436aa92 = getdvarstring(#"_internal_dof_s_target_tag", "-1");

      if(var_1436aa92 == "-1") {
        var_1436aa92 = undefined;
      }

      f_fstop = getdvarfloat(#"_internal_dof_f_fstop", -1);

      if(f_fstop == -1) {
        f_fstop = undefined;
      }

      f_fstop_time = getdvarfloat(#"_internal_dof_f_fstop_time", -1);

      if(f_fstop_time == -1) {
        f_fstop_time = undefined;
      }

      var_bef008a5 = getdvarfloat(#"_internal_dof_f_focus_time", -1);

      if(var_bef008a5 == -1) {
        var_bef008a5 = undefined;
      }

      if(var_3ed74fac == -999) {
        var_1498bcbe = getdvarvector(#"hash_7c405920e0b200ee", (-1, -1, -1));
        var_1436aa92 = undefined;
      } else {
        ents = getentarraybytype(0, var_dc3df1b8);

        foreach(ent in ents) {
          entnum = ent getentitynumber();

          if(entnum == var_3ed74fac) {
            var_1498bcbe = ent;
            break;
          }
        }
      }

      player thread lighting_target_dof(var_1498bcbe, f_fstop, var_bef008a5, f_fstop_time, var_1436aa92);
      break;
    }
  }
}

function function_5409b584() {
  players = getlocalplayers();

  foreach(player in players) {
    if(player getentitynumber() == getdvarint(#"_internal_fob_i_playernum", -1)) {
      var_904e61ce = getdvarfloat(#"_internal_fob_f_fstop", 1);

      if(var_904e61ce == -1) {
        var_904e61ce = undefined;
      }

      var_f7259b16 = getdvarfloat(#"_internal_fob_f_fstop_time", -1);

      if(var_f7259b16 == -1) {
        var_f7259b16 = undefined;
      }

      player thread function_82104e32(var_904e61ce, var_f7259b16);
    }
  }
}

function function_82104e32(var_904e61ce, var_f7259b16, var_ff9d26ff) {
  self notify(#"hash_1481a83e14539c4");
  self endon(#"hash_1481a83e14539c4");
  self endon(#"death");

  if(!isDefined(var_904e61ce)) {
    var_904e61ce = 1;
  }

  if(!isDefined(var_f7259b16)) {
    var_f7259b16 = 0.1;
  }

  if(!isDefined(var_ff9d26ff)) {
    var_ff9d26ff = var_f7259b16;
  }

  self function_9e574055(2);
  playernum = self getentitynumber();
  self function_1816c600(var_904e61ce, var_f7259b16);
  var_eb618ad5 = 500 / var_ff9d26ff;
  prev_time = undefined;

  while(playernum == getdvarint(#"_internal_fob_i_playernum", -1)) {
    if(isDefined(prev_time)) {
      var_a122c423 = gettime() - prev_time;
      var_56eeee5f = self trace_distance();
      var_99faea6 = self function_78bf7752();
      var_2ae21772 = undefined;

      if(abs(var_56eeee5f - var_99faea6) > 1) {
        var_1957b598 = var_eb618ad5 * var_a122c423 * 0.001;

        if(var_99faea6 > var_56eeee5f) {
          var_2ae21772 = var_99faea6 - var_1957b598;

          if(var_2ae21772 < var_56eeee5f) {
            var_2ae21772 = var_56eeee5f;
          }
        } else {
          var_2ae21772 = var_99faea6 + var_1957b598;

          if(var_2ae21772 > var_56eeee5f) {
            var_2ae21772 = var_56eeee5f;
          }
        }

        if(var_2ae21772 < 0) {
          var_2ae21772 = 0;
        } else if(var_2ae21772 > 500) {
          var_2ae21772 = 500;
        }

        self function_d7be9a9f(var_2ae21772, 0);
      }
    }

    prev_time = gettime();
    waitframe(1);
  }

  self function_c2856ebd(0.5);
}

function trace_distance() {
  tracedist = 500;
  playereye = self getEye();
  var_a6cb20ff = self getplayerangles();

  if(isDefined(self.dof_ref_ent)) {
    playerangles = combineangles(self.dof_ref_ent.angles, var_a6cb20ff);
  } else {
    playerangles = var_a6cb20ff;
  }

  playerforward = vectornormalize(anglesToForward(playerangles));
  trace = bulletTrace(playereye, playereye + playerforward * tracedist, 1, self);
  dist = distance(playereye, trace[# "position"]);

  if(getdvarint(#"_internal_debug_dof", 0) == 1) {
    var_cba8e949 = 1;
    debugstar(trace[# "position"], var_cba8e949, (0, 1, 0));
    print3d(trace[# "position"], "<dev string:x6c>" + dist, (0, 1, 0), 1, 0.2, var_cba8e949);
  }

  return dist;
}

function lighting_target_dof(var_e4db2d63, var_904e61ce, var_ff9d26ff, var_f7259b16, tag) {
  self notify(#"hash_1481a83e14539c4");
  self endon(#"hash_1481a83e14539c4");
  self endon(#"death");

  if(!isDefined(var_e4db2d63)) {
    iprintlnbold("<dev string:x79>");

    return;
  }

  if(!isDefined(var_ff9d26ff)) {
    var_ff9d26ff = 0.05;
  }

  if(!isDefined(var_f7259b16)) {
    var_f7259b16 = 0.05;
  }

  self function_9e574055(2);
  var_ae5fe668 = max(var_ff9d26ff, var_f7259b16);
  playernum = self getentitynumber();

  while(playernum == getdvarint(#"_internal_dof_i_playernum", -1)) {
    target_origin = undefined;

    if(isDefined(var_e4db2d63)) {
      if(isvec(var_e4db2d63)) {
        target_origin = var_e4db2d63;
        focus_dist = distance(self getEye(), target_origin);
      } else if(isDefined(tag)) {
        ent = var_e4db2d63;
        target_origin = ent gettagorigin(tag);
        focus_dist = distance(self getEye(), target_origin);
      } else {
        ent = var_e4db2d63;
        target_origin = ent.origin;
        focus_dist = distance(self getEye(), target_origin);
      }
    } else {
      focus_dist = 500;
    }

    self function_1816c600(var_904e61ce, var_f7259b16);
    self function_d7be9a9f(focus_dist, var_ff9d26ff);

    wait_frames = int(ceil(var_ae5fe668 * 50));
    debugstar(target_origin, wait_frames, (0, 1, 0));
    print3d(target_origin, "<dev string:x94>" + focus_dist, (0, 1, 0), 1, 0.5, wait_frames);

    wait var_ae5fe668;
  }

  self function_c2856ebd(0.05);
}