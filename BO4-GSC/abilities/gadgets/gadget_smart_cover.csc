/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_smart_cover.csc
****************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\deployable;

#namespace smart_cover;

init_shared() {
  callback::on_localplayer_spawned(&on_local_player_spawned);
  clientfield::register("scriptmover", "smartcover_placed", 1, 5, "float", &smartcover_placed, 0, 0);
  clientfield::register("clientuimodel", "hudItems.smartCoverState", 1, 1, "int", undefined, 0, 0);
  clientfield::register("scriptmover", "start_smartcover_microwave", 1, 1, "int", &smartcover_start_microwave, 0, 0);
  level.smartcoversettings = spawnStruct();
  level.smartcoversettings.previewmodels = [];
  level.smartcoversettings.var_aef370a9 = [];
  level.smartcoversettings.weapon = getweapon(#"ability_smart_cover");
  deployable::register_deployable(level.smartcoversettings.weapon, 1);

  if(sessionmodeismultiplayergame()) {
    level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_mp");
  } else if(sessionmodeiswarzonegame()) {
    level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_wz");
  } else if(sessionmodeiscampaigngame()) {
    level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_cp");
  }

  setupdvars();
}

setupdvars() {
  setdvar(#"hash_25f7092e7c7b66f2", 0);
  setdvar(#"hash_4332205cbf1cc384", 0);
  setdvar(#"smartcover_drawtime", 1000);
  setdvar(#"hash_436fc2fad44e9041", 1);
  setdvar(#"hash_1d8eb304f5cf8033", 1);
  setdvar(#"smartcover_tracedistance", level.smartcoversettings.bundle.var_1f0ae388);
  setdvar(#"hash_13c23fd3a4387b84", 8);
  setdvar(#"hash_55a8dba3350b8b7c", 4);
  setdvar(#"hash_4f4ce3cb18b004bc", 10);
  setdvar(#"hash_417afa70d515fba5", isDefined(level.smartcoversettings.bundle.var_76d79155) ? level.smartcoversettings.bundle.var_76d79155 : 0);
  setdvar(#"hash_71f8bd4cd30de4b3", isDefined(level.smartcoversettings.bundle.var_e35fc674) ? level.smartcoversettings.bundle.var_e35fc674 : 0);
  setdvar(#"hash_39a564d4801c4b2e", isDefined(level.smartcoversettings.bundle.var_1f0ae388) ? level.smartcoversettings.bundle.var_1f0ae388 : 0);
}

smartcover_start_microwave(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.smartcoversettings.bundle.var_f4e0e7d7) && level.smartcoversettings.bundle.var_f4e0e7d7 && newval == 1) {
    self thread startmicrowavefx(localclientnum);
    return;
  }

  if(newval == 0) {
    self notify(#"beam_stop");
  }
}

smartcover_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(!isDefined(level.smartcoversettings.bundle.deployanim)) {
    return;
  }

  self useanimtree("generic");

  if(newval == 1) {
    self setanimrestart(level.smartcoversettings.bundle.deployanim, 1, 0, 1);
    return;
  }

  if(bwastimejump) {
    currentanimtime = self getanimtime(level.smartcoversettings.bundle.deployanim);
    var_f56117a2 = 1 - newval;

    if(var_f56117a2 < currentanimtime) {
      self setanimtime(level.smartcoversettings.bundle.deployanim, var_f56117a2);
    }
  }
}

function_112e3e89(localclientnum) {
  if(!isDefined(level.smartcoversettings.previewmodels[localclientnum])) {
    return;
  }

  foreach(previewmodel in level.smartcoversettings.previewmodels[localclientnum]) {
    previewmodel hide();
  }
}

function_fd04d5d5(localclientnum) {
  player = self;
  player function_112e3e89(localclientnum);
  level.smartcoversettings.var_aef370a9[localclientnum] = 0;
}

function_1c2930c7(localclientnum) {
  player = function_5c10bd79(localclientnum);
  player notify(#"hash_5c7dbac0591cb11f");
  player endon(#"hash_5c7dbac0591cb11f", #"game_ended");
  level endon(#"game_ended");
  level.smartcoversettings.var_aef370a9[localclientnum] = 1;
  function_722fc669(localclientnum);
  var_ccfe777 = 0;

  while(true) {
    waitframe(1);
    player = function_5c10bd79(localclientnum);

    if(!isDefined(player)) {
      break;
    }

    var_b43e8dc2 = player function_287dcf4b(level.smartcoversettings.bundle.var_63aab046, level.smartcoversettings.bundle.maxwidth, 1, 1, level.smartcoversettings.smartcoverweapon);

    if(!isDefined(var_b43e8dc2) && !var_ccfe777) {
      var_ccfe777 = 1;
      player function_112e3e89(localclientnum);
      player function_bf191832(0, (0, 0, 0), (0, 0, 0));
      continue;
    } else if(isDefined(var_b43e8dc2) && var_ccfe777) {
      var_ccfe777 = 0;
    } else if(!isDefined(var_b43e8dc2)) {
      player function_bf191832(0, (0, 0, 0), (0, 0, 0));
      continue;
    }

    if(isDefined(level.smartcoversettings.bundle.var_8fa9aac4) ? level.smartcoversettings.bundle.var_8fa9aac4 : 0) {
      if(var_b43e8dc2.var_bf9ca9b0) {
        previewmodel = player function_8fb44aff(localclientnum, var_b43e8dc2.origin, var_b43e8dc2.angles, var_b43e8dc2.isvalid, 0, 1);
        continue;
      }

      previewmodel = player function_8fb44aff(localclientnum, var_b43e8dc2.origin, var_b43e8dc2.angles, var_b43e8dc2.isvalid, 2, 3);
      previewmodel function_dbaf4647(localclientnum);
      previewmodel function_5a8becdc(localclientnum, player, var_b43e8dc2, 1);
    }
  }
}

function_59605cb(localclientnum) {
  player = self;
  player notify(#"hash_5c7dbac0591cb11f");
  player function_fd04d5d5(localclientnum);
}

function_17d973ec(localclientnum) {
  player = function_5c10bd79(localclientnum);
  player notify(#"hash_5c39bdc22418d792");
  player endon(#"hash_5c39bdc22418d792");

  if(!isDefined(player.smartcover)) {
    player.smartcover = spawnStruct();
  }
}

function_5d802b86(localclientnum) {
  player = self;
  player endon(#"disconnect");
  player waittill(#"death");
  player function_59605cb(localclientnum);
  player notify(#"hash_5c39bdc22418d792");
}

on_local_player_spawned(localclientnum) {}

function_641491ac(localclientnum, modelname) {
  previewmodel = spawn(localclientnum, (0, 0, 0), "script_model");
  previewmodel setModel(modelname);
  previewmodel hide();
  previewmodel notsolid();
  return previewmodel;
}

function_722fc669(localclientnum) {
  player = self;

  if(isDefined(level.smartcoversettings.previewmodels[localclientnum])) {
    return;
  }

  level.smartcoversettings.previewmodels[localclientnum] = [];
  level.smartcoversettings.previewmodels[localclientnum][0] = function_641491ac(localclientnum, level.smartcoversettings.bundle.placementmodel);
  level.smartcoversettings.previewmodels[localclientnum][1] = function_641491ac(localclientnum, level.smartcoversettings.bundle.var_46732914);
  level.smartcoversettings.previewmodels[localclientnum][2] = function_641491ac(localclientnum, level.smartcoversettings.bundle.var_1b5c037d);
  level.smartcoversettings.previewmodels[localclientnum][3] = function_641491ac(localclientnum, level.smartcoversettings.bundle.var_76ac23f2);
}

function_8fb44aff(localclientnum, origin, angles, isvalid, var_eb65925c, var_4b3e5e0a) {
  player = self;
  previewmodel = undefined;
  var_80f43370 = undefined;
  var_ff5a387e = isvalid ? var_eb65925c : var_4b3e5e0a;

  for(var_a6932c26 = 0; var_a6932c26 < level.smartcoversettings.previewmodels[localclientnum].size; var_a6932c26++) {
    if(var_a6932c26 == var_ff5a387e) {
      continue;
    }

    level.smartcoversettings.previewmodels[localclientnum][var_a6932c26] hide();
  }

  level.smartcoversettings.previewmodels[localclientnum][var_ff5a387e].origin = origin;
  level.smartcoversettings.previewmodels[localclientnum][var_ff5a387e].angles = angles;
  level.smartcoversettings.previewmodels[localclientnum][var_ff5a387e] show();
  player function_bf191832(0, origin, angles);
  return level.smartcoversettings.previewmodels[localclientnum][var_ff5a387e];
}

function_d66a0190(row, column) {
  cellindex = row * level.smartcoversettings.bundle.rowcount + column;

  if(cellindex < 10) {
    return ("joint_0" + cellindex);
  }

  return "joint_" + cellindex;
}

function_dbaf4647(localclientnum) {
  smartcover = self;

  for(rowindex = 0; rowindex < level.smartcoversettings.bundle.rowcount; rowindex++) {
    for(colindex = 1; colindex <= level.smartcoversettings.bundle.colcount; colindex++) {
      celllabel = function_d66a0190(rowindex, colindex);
      smartcover showpart(localclientnum, celllabel);
    }
  }
}

function_5a8becdc(localclientnum, player, buildinfo, var_4b1c8937) {
  smartcover = self;
  cellheight = level.smartcoversettings.bundle.maxheight / level.smartcoversettings.bundle.rowcount;
  cellwidth = level.smartcoversettings.bundle.maxwidth / level.smartcoversettings.bundle.colcount;
  var_b963136f = int(buildinfo.width / cellwidth);
  var_227adab7 = buildinfo.width - cellwidth * var_b963136f;

  if(var_227adab7 > 0 && var_227adab7 / 2 < level.smartcoversettings.bundle.var_3dfbdbeb && var_b963136f + 2 <= level.smartcoversettings.bundle.colcount) {
    var_b963136f += 2;
  }

  var_9de92bd5 = int(buildinfo.height / cellheight);
  var_2582dbd = buildinfo.height - cellheight * var_9de92bd5;

  if(var_2582dbd > 0 && var_2582dbd < level.smartcoversettings.bundle.var_3dfbdbeb && var_2582dbd < level.smartcoversettings.bundle.rowcount) {
    var_9de92bd5++;
  }

  cellstoremove = [];
  var_e465f403 = level.smartcoversettings.bundle.rowcount - var_9de92bd5;

  for(rowindex = 0; rowindex < var_e465f403; rowindex++) {
    rownum = level.smartcoversettings.bundle.rowcount - rowindex - 1;

    for(colindex = 1; colindex < level.smartcoversettings.bundle.colcount; colindex++) {
      celllabel = function_d66a0190(rownum, colindex);
      smartcover hidepart(localclientnum, celllabel);
    }
  }

  var_f636c423 = level.smartcoversettings.bundle.colcount - var_b963136f;

  for(var_688bc60 = 0; var_688bc60 < int(var_f636c423 / 2); var_688bc60++) {
    cola = var_688bc60 + 1;
    colb = level.smartcoversettings.bundle.colcount - var_688bc60;

    for(rowindex = 0; rowindex < level.smartcoversettings.bundle.rowcount; rowindex++) {
      microwave_sh_turr = function_d66a0190(rowindex, cola);
      var_1ffc0b2e = function_d66a0190(rowindex, colb);
      smartcover hidepart(localclientnum, microwave_sh_turr);
      smartcover hidepart(localclientnum, var_1ffc0b2e);
    }
  }
}

debug_trace(origin, trace) {
  if(trace[#"fraction"] < 1) {
    color = (0.95, 0.05, 0.05);
  } else {
    color = (0.05, 0.95, 0.05);
  }

  sphere(trace[#"position"], 5, color, 0.75, 1, 10, 100);
  util::debug_line(origin, trace[#"position"], color, 100);
}

startmicrowavefx(localclientnum) {
  turret = self;
  turret endon(#"death");
  turret endon(#"beam_stop");
  turret.should_update_fx = 1;
  angles = turret.angles;
  origin = turret.origin + (0, 0, 30);
  microwavefxent = spawn(localclientnum, origin, "script_model");
  microwavefxent setModel(#"tag_microwavefx");
  microwavefxent.angles = angles;
  microwavefxent.fxhandles = [];
  microwavefxent.fxnames = [];
  microwavefxent.fxhashs = [];
  self thread cleanupfx(localclientnum, microwavefxent);
  wait 0.3;

  while(true) {
    if(getdvarint(#"scr_microwave_turret_fx_debug", 0)) {
      turret.should_update_fx = 1;
      microwavefxent.fxhashs[#"center"] = 0;
    }

    if(turret.should_update_fx == 0) {
      wait 1;
      continue;
    }

    if(isDefined(level.last_microwave_turret_fx_trace) && level.last_microwave_turret_fx_trace == gettime()) {
      waitframe(1);
      continue;
    }

    angles = turret.angles;
    origin = turret.origin + (0, 0, 30);
    forward = anglesToForward(angles);
    forward = vectorscale(forward, (isDefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) + 40);
    var_e2e9fefa = anglesToForward(angles + (0, 55 / 3, 0));
    var_e2e9fefa = vectorscale(var_e2e9fefa, (isDefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) + 40);
    trace = bulletTrace(origin, origin + forward, 0, turret);
    traceright = bulletTrace(origin, origin - var_e2e9fefa, 0, turret);
    traceleft = bulletTrace(origin, origin + var_e2e9fefa, 0, turret);

    if(getdvarint(#"scr_microwave_turret_fx_debug", 0)) {
      debug_trace(origin, trace);
      debug_trace(origin, traceright);
      debug_trace(origin, traceleft);
    }

    need_to_rebuild = microwavefxent microwavefxhash(trace, origin, "center");
    need_to_rebuild |= microwavefxent microwavefxhash(traceright, origin, "right");
    need_to_rebuild |= microwavefxent microwavefxhash(traceleft, origin, "left");
    level.last_microwave_turret_fx_trace = gettime();

    if(!need_to_rebuild) {
      wait 1;
      continue;
    }

    wait 0.1;
    microwavefxent playmicrowavefx(localclientnum, trace, traceright, traceleft, origin, turret.team);
    turret.should_update_fx = 0;
    wait 1;
  }
}

microwavefxhash(trace, origin, name) {
  hash = 0;
  counter = 2;

  for(i = 0; i < 5; i++) {
    endofhalffxsq = (i * 150 + 125) * (i * 150 + 125);
    endoffullfxsq = (i * 150 + 200) * (i * 150 + 200);
    tracedistsq = distancesquared(origin, trace[#"position"]);

    if(tracedistsq >= endofhalffxsq || i == 0) {
      if(tracedistsq < endoffullfxsq) {
        hash += 1;
      } else {
        hash += counter;
      }
    }

    counter *= 2;
  }

  if(!isDefined(self.fxhashs[name])) {
    self.fxhashs[name] = 0;
  }

  last_hash = self.fxhashs[name];
  self.fxhashs[name] = hash;
  return last_hash != hash;
}

cleanupfx(localclientnum, microwavefxent) {
  self waittill(#"death", #"beam_stop");

  foreach(handle in microwavefxent.fxhandles) {
    if(isDefined(handle)) {
      stopfx(localclientnum, handle);
    }
  }

  microwavefxent delete();
}

play_fx_on_tag(localclientnum, fxname, tag, team) {
  if(!isDefined(self.fxhandles[tag]) || fxname != self.fxnames[tag]) {
    stop_fx_on_tag(localclientnum, fxname, tag);
    self.fxnames[tag] = fxname;
    self.fxhandles[tag] = util::playFXOnTag(localclientnum, fxname, self, tag);
    setfxteam(localclientnum, self.fxhandles[tag], team);
  }
}

stop_fx_on_tag(localclientnum, fxname, tag) {
  if(isDefined(self.fxhandles[tag])) {
    stopfx(localclientnum, self.fxhandles[tag]);
    self.fxhandles[tag] = undefined;
    self.fxnames[tag] = undefined;
  }
}

render_debug_sphere(tag, color, fxname) {
  if(getdvarint(#"scr_microwave_turret_fx_debug", 0)) {
    origin = self gettagorigin(tag);
    sphere(origin, 2, color, 0.75, 1, 10, 100);
  }
}

stop_or_start_fx(localclientnum, fxname, tag, start, team) {
  if(start) {
    self play_fx_on_tag(localclientnum, fxname, tag, team);

    if(fxname == "<dev string:x38>") {
      render_debug_sphere(tag, (0.5, 0.5, 0), fxname);
    } else {
      render_debug_sphere(tag, (0, 1, 0), fxname);
    }

    return;
  }

  stop_fx_on_tag(localclientnum, fxname, tag);

  render_debug_sphere(tag, (1, 0, 0), fxname);
}

playmicrowavefx(localclientnum, trace, traceright, traceleft, origin, team) {
  for(i = 0; i < 5; i++) {
    endofhalffxsq = (i * 150 + 125) * (i * 150 + 125);
    endoffullfxsq = (i * 150 + 200) * (i * 150 + 200);
    tracedistsq = distancesquared(origin, trace[#"position"]);
    startfx = tracedistsq >= endofhalffxsq || i == 0;
    fxname = tracedistsq > endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave" : "weapon/fx8_equip_smart_cover_microwave_sm";

    switch (i) {
      case 0:
        self play_fx_on_tag(localclientnum, fxname, "tag_fx11", team);
        break;
      case 1:
        break;
      case 2:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx32", startfx, team);
        break;
      case 3:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx42", startfx, team);
        self stop_or_start_fx(localclientnum, fxname, "tag_fx43", startfx, team);
        break;
      case 4:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx53", startfx, team);
        break;
    }

    tracedistsq = distancesquared(origin, traceleft[#"position"]);
    startfx = tracedistsq >= endofhalffxsq;
    fxname = tracedistsq > endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave" : "weapon/fx8_equip_smart_cover_microwave_sm";

    switch (i) {
      case 0:
        break;
      case 1:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx22", startfx, team);
        break;
      case 2:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx33", startfx, team);
        break;
      case 3:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx44", startfx, team);
        break;
      case 4:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx54", startfx, team);
        self stop_or_start_fx(localclientnum, fxname, "tag_fx55", startfx, team);
        break;
    }

    tracedistsq = distancesquared(origin, traceright[#"position"]);
    startfx = tracedistsq >= endofhalffxsq;
    fxname = tracedistsq > endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave" : "weapon/fx8_equip_smart_cover_microwave_sm";

    switch (i) {
      case 0:
        break;
      case 1:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx21", startfx, team);
        break;
      case 2:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx31", startfx, team);
        break;
      case 3:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx41", startfx, team);
        break;
      case 4:
        self stop_or_start_fx(localclientnum, fxname, "tag_fx51", startfx, team);
        self stop_or_start_fx(localclientnum, fxname, "tag_fx52", startfx, team);
        break;
    }
  }
}