/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_so_rts.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_audio;
#include clientscripts\_ambientpackage;
#include clientscripts\_so_rts_fxanim;

rts_init(hologram_material_name) {
  level.hologrammateialname = hologram_material_name;
  register_clientflag_callback("player", 1, ::toggle_satellite_hotness);
  register_clientflag_callback("player", 2, ::toggle_satellite_remotemissile);
  register_clientflag_callback("player", 3, ::toggle_reticle);
  register_clientflag_callback("player", 4, ::toggle_reticle_alt);
  register_clientflag_callback("actor", 5, ::gpr_updated);
  register_clientflag_callback("actor", 6, ::entity_died);
  register_clientflag_callback("vehicle", 5, ::gpr_updated);
  register_clientflag_callback("vehicle", 7, ::entity_died);
  register_clientflag_callback("scriptmover", 5, ::gpr_updated);
  register_clientflag_callback("scriptmover", 8, ::entity_died);
  waitforclient(0);
  thread rtsaudiotransitions();
  players = getlocalplayers();

  for(i = 0; i < players.size; i++) {
    init_filter_satellite_transition(players[i]);
    init_filter_rts_hologram(players[i], hologram_material_name);
    init_filter_hud_outline(players[i]);
  }

  level.rts_mode = 0;
  level.satellite_duration = 1.2;
  level.holdfullstatic = 0;
  level.entities = [];
  level.healthsound = "chr_health";
  level.playerhealthsystemoverride = ::rtshealthsystem;
  setclientdvar("cg_thirdPersonRange", 300);
  clientscripts\_so_rts_fxanim::init(0);
}

entity_died(localclientnum, set, newent) {
  self target_unit_highlight(localclientnum, 0, 0);
  self sethudoutlinecolor(0);
  arrayremovevalue(level.entities, self);
}

gpr_updated(localclientnum, set, newent) {
  signbit = self.gpr & -2147483648;
  self.gpr = self.gpr & 2147483647;
  data = self.gpr & 268435455;
  op = self.gpr >> 28;

  if(signbit != 0)
    op = op | 8;

  switch (op) {
    case 2:
      val = data & 65535;

      if(val > 0)
        self target_unit_highlight(localclientnum, 1, val);
      else
        self target_unit_highlight(localclientnum, 0, 0);

      break;
    case 1:
      val = data & 65535;

      if(val == 0)
        self.sonarteam = "axis";
      else if(val == 1)
        self.sonarteam = "allies";

      level.entities = remove_the_dead(level.entities);

      if(!isinarray(level.entities, self))
        level.entities[level.entities.size] = self;

      self thread set_rampsonarcolor(localclientnum);
      self update_hudoutline();
      break;
    case 4:
      self.squadid = data & 65535;
      break;
  }

  if(isDefined(level.gpr_cb))
    [[level.gpr_cb]](localclientnum, op, data);
}

inittransitiontime(time) {
  level.satellite_duration = time;
}

holdswitchstatic(set) {
  level.holdfullstatic = set;
}

set_rampsonarcolor(localclientnum) {
  self mapshaderconstant(localclientnum, 3, "ScriptVector7");
  unused = 0;
  self setshaderconstant(localclientnum, 3, 1, unused, unused, unused);
  waitinc = 0.0666667;
  inc = -0.0166667;
  cur = 1;
  steps = 60;

  while(isDefined(self) && steps > 0) {
    if(cur < 0)
      cur = 0;

    self setshaderconstant(localclientnum, 3, cur, unused, unused, unused);
    cur = cur + inc;
    steps--;
    wait(waitinc);
  }

  if(isDefined(self))
    self setshaderconstant(localclientnum, 3, 0, unused, unused, unused);
}

set_sonarpulse(localclientnum) {
  self notify("orange_julius");
  self endon("orange_julius");
  self endon("death");
  self mapshaderconstant(localclientnum, 3, "ScriptVector7");
  unused = 0;
  self setshaderconstant(localclientnum, 3, 0, unused, unused, unused);
  waitinc = 0.0166667;
  increment = 0.0166667 * 0.65;
  cur = 0;

  while(isDefined(self)) {
    steps = 60;

    if(cur == 0)
      inc = increment;
    else
      inc = increment * -1;

    while(isDefined(self) && steps > 0) {
      if(cur < 0)
        cur = 0;

      if(cur > 1)
        cur = 1;

      self setshaderconstant(localclientnum, 3, cur, unused, unused, unused);
      cur = cur + inc;
      steps--;
      wait(waitinc);
    }
  }
}

set_squadishighlighted(squadid, forced) {
  if(!isDefined(forced))
    forced = 0;

  foreach(ent in level.entities)
  ent notify("orange_julius");

  if(squadid != -1) {
    if(level.rts_mode || forced) {
      squad = [];

      foreach(ent in level.entities) {
        if(isDefined(ent) && isDefined(ent.squadid) && ent.squadid == squadid)
          squad[squad.size] = ent;
      }

      foreach(ent in squad) {
        ent sethudoutlinecolor(3);
        ent thread set_sonarpulse(0);
      }
    }
  } else
    update_all_hudoutlines();
}

update_hudoutline(forced, onlyenemy) {
  if(!isDefined(forced))
    forced = 0;

  if(!isDefined(onlyenemy))
    onlyenemy = 0;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.sonar_forced) && level.sonar_forced)
    forced = 1;

  if(isDefined(level.sonar_onlyenemy) && level.sonar_onlyenemy)
    onlyenemy = 1;

  if(level.rts_mode || forced) {
    self setshaderconstant(0, 3, 0, 0, 0, 0);

    if(self.sonarteam == "axis")
      self sethudoutlinecolor(1);
    else if(self.sonarteam == "allies" && onlyenemy == 0)
      self sethudoutlinecolor(2);
  } else {
    self notify("orange_julius");
    self sethudoutlinecolor(0);
  }
}

remove_the_dead(arrayin) {
  alive = [];

  for(i = 0; i < arrayin.size; i++) {
    if(isDefined(arrayin[i]))
      alive[alive.size] = arrayin[i];
  }

  return alive;
}

update_all_hudoutlines(forced, onlyenemy) {
  if(!isDefined(forced))
    forced = 0;

  if(!isDefined(onlyenemy))
    onlyenemy = 0;

  level.entities = remove_the_dead(level.entities);

  for(i = 0; i < level.entities.size; i++)
    level.entities[i] update_hudoutline(forced, onlyenemy);
}

force_all_hudoutlineson(on, onlyenemy) {
  if(!isDefined(onlyenemy))
    onlyenemy = 0;

  if(on) {
    enable_filter_hud_outline(level.localplayers[0], 2, 0);
    update_all_hudoutlines(1, onlyenemy);
    level.sonar_forced = 1;
    level.sonar_onlyenemy = 1;
  } else {
    disable_filter_hud_outline(level.localplayers[0], 2, 0);
    level.sonar_forced = undefined;
    level.sonar_onlyenemy = undefined;
  }
}

target_unit_highlight(localclientnum, onoff, progvalue) {
  if(onoff < 0)
    onoff = -1;

  if(onoff > 0)
    onoff = onoff | 1;

  if(isDefined(self.max_health) && isDefined(self.health))
    health = (self.max_health << 16) + self.health;
  else
    health = -1;

  self settargethighlight(localclientnum, onoff, progvalue, health);
}

toggle_reticle(localclientnum, set, newent) {
  if(!isDefined(level.targeting_reticle))
    level.targeting_reticle = 0;

  if(!level.targeting_reticle && set) {
    enable_filter_rts_hologram(level.localplayers[localclientnum], 0, level.hologrammateialname);
    set_filter_rts_hologram_radius(level.localplayers[localclientnum], 0, 120);
  } else if(level.targeting_reticle && !set)
    disable_filter_rts_hologram(level.localplayers[localclientnum], 0);

  level.targeting_reticle = set;

  println("**** reticle - client**** (" + set + ")");
}

toggle_reticle_alt(localclientnum, set, newent) {
  if(!isDefined(level.targeting_reticle_alt))
    level.targeting_reticle_alt = 0;

  if(!level.targeting_reticle_alt && set) {
    enable_filter_rts_hologram_no_sonar(level.localplayers[localclientnum], 3, level.hologrammateialname);
    set_filter_rts_hologram_radius(level.localplayers[localclientnum], 3, 120);
  } else if(level.targeting_reticle_alt && !set)
    disable_filter_rts_hologram_no_sonar(level.localplayers[localclientnum], 3);

  level.targeting_reticle_alt = set;

  println("**** reticle_alt - client**** (" + set + ")");
}

toggle_satellite_hotness(localclientnum, set, newent) {
  if(!isDefined(level.satellitetransisionactive))
    level.satellitetransisionactive = 0;

  println("**** satellite - client**** set(" + set + ") active (" + level.satellitetransisionactive + ")");

  if(!level.satellitetransisionactive && set) {
    level.satellitetransisionactive = 1;
    level thread satellite_transition(localclientnum, level.satellite_duration);
  } else if(level.satellitetransisionactive && !set)
    level.satellitetransisionactive = 0;
}

toggle_satellite_remotemissile(localclientnum, set, newent) {
  if(!isDefined(level.satellitetransisionactive))
    level.satellitetransisionactive = 0;

  if(!level.satellitetransisionactive && set) {
    enable_filter_satellite_transition(level.localplayers[localclientnum], 1);
    level.satellitetransisionactive = 1;
    set_filter_satellite_transition_amount(level.localplayers[localclientnum], 1, 0.7);
  } else if(level.satellitetransisionactive && !set) {
    disable_filter_satellite_transition(level.localplayers[localclientnum], 1);
    level.satellitetransisionactive = 0;
    set_filter_satellite_transition_amount(level.localplayers[localclientnum], 1, 0.0);
  }

  println("**** (" + gettime() + ") remoteMissile - client**** (" + set + ")");
}

satellite_transition(localclientnum, duration) {
  enable_filter_satellite_transition(level.localplayers[localclientnum], 1);
  starttime = getrealtime();
  currenttime = starttime;
  elapsedtime = 0;
  halftime = duration * 0.5;
  statictime = 0.15;
  heldtime = 0;
  totalduration = duration + statictime;

  while(elapsedtime < totalduration) {
    lasttime = currenttime;
    wait 0.01;
    currenttime = getrealtime();
    elapsedtime = (currenttime - starttime - heldtime) / 1000.0;

    if(elapsedtime > totalduration)
      elapsedtime = totalduration;

    if(elapsedtime < halftime)
      val = elapsedtime / halftime;
    else {
      if(elapsedtime < halftime + statictime)
        val = 1;
      else
        val = 1 - (elapsedtime - halftime - statictime) / halftime;

      if(level.holdfullstatic) {
        val = 1;
        heldtime = heldtime + (currenttime - lasttime);
      }
    }

    println("**** satellite - client**** (" + val + ")");

    set_filter_satellite_transition_amount(level.localplayers[localclientnum], 1, val);
  }

  disable_filter_satellite_transition(level.localplayers[localclientnum], 1);
}

lerp_fov_overtime(time, dest) {
  basefov = getdvarfloat(#"cg_fov");
  incs = int(time / 0.01);
  incfov = (dest - basefov) / incs;
  currentfov = basefov;

  if(incfov == 0) {
    return;
  }
  for(i = 0; i < incs; i++) {
    currentfov = currentfov + incfov;
    setclientdvar("cg_fov", currentfov);
    wait 0.01;
  }

  setclientdvar("cg_fov", dest);
}

rtsaudiotransitions() {
  level.vehicle_sound_ent = undefined;
  level.sndendmenu = undefined;
  level thread rtsambientpackage();
  level thread waitfor_rtson();
  level thread waitfor_rtsoff();
  level thread waitfor_povon();
  level thread waitfor_characterswitch();
  level thread vehicleloopsounds("rts_intoclaw", "evt_rts_claw_1stperson_lp");
  level thread vehicleloopsounds("rts_intomtl", "evt_rts_metalstorm_1stperson_lp");
  level thread vehicleloopsounds("rts_intoquad", "evt_rts_quadrotor_1stperson_lp");
  level thread waitfor_endmenu();
}

waitfor_endmenu() {
  level waittill("sndEndMenu");
  level.sndendmenu = 1;
}

rtsambientpackage() {
  declareambientroom("rts_commandcenter");
  setambientroomreverb("rts_commandcenter", "dockside_small_room", 1, 1);
  setambientroomcontext("rts_commandcenter", "ringoff_plr", "indoor");
  setambientroomtone("rts_commandcenter", "amb_command_center_bg", 3, 1.5);
}

waitfor_rtson() {
  while(true) {
    note = level waittill_any_return("rts_ON", "rts_ON_alt");

    if(!isDefined(level.sndendmenu)) {
      activateambientroom(0, "rts_commandcenter", 80);
      snd_set_snapshot("spl_rts_commandcenter");
      level thread commandservosounds();
    }

    level.rts_mode = 1;

    if(note == "rts_ON")
      update_all_hudoutlines();
  }
}

waitfor_rtsoff() {
  while(true) {
    level waittill("rts_OFF");
    deactivateambientroom(0, "rts_commandcenter", 80);
    snd_set_snapshot("default");
    level.rts_mode = 0;
    update_all_hudoutlines();
  }
}

waitfor_povon() {
  while(true) {
    msg = level waittill_any_return("takeover_quadrotor_pkg", "takeover_metalstorm_pkg", "takeover_bigdog_pkg", "rts_ON", "rts_OFF", "infantry_ally_reg_pkg", "takeover_infantry_ally_reg_pkg");

    switch (msg) {
      case "takeover_quadrotor_pkg":
        setsoundcontext("grass", "in_grass");
        level.healthsound = "chr_quad_health";
        break;
      case "takeover_metalstorm_pkg":
        setsoundcontext("grass", "in_grass");
        level.healthsound = "chr_asd_health";
        break;
      case "takeover_bigdog_pkg":
        setsoundcontext("grass", "in_grass");
        level.healthsound = "chr_bigdog_health";
        break;
      case "rts_ON":
        setglobalfutz("spl_war_command", 1.0);
        setsoundcontext("grass", "no_grass");
        level.healthsound = "chr_health";
        break;
      default:
        setglobalfutz("no_gfutz", 0.0);
        setsoundcontext("grass", "no_grass");
        level.healthsound = "chr_health";
        break;
    }
  }
}

waitfor_povoff() {
  while(true) {
    msg = level waittill_any_return("restore_quadrotor_pkg", "restore_metalstorm_pkg", "restore_bigdog_pkg", "chr_swtch_start", "rts_OFF");

    switch (msg) {
      case "restore_quadrotor_pkg":
        setsoundcontext("grass", "no_grass");
        break;
      case "restore_metalstorm_pkg":
        setsoundcontext("grass", "no_grass");
        break;
      case "restore_bigdog_pkg":
        setsoundcontext("grass", "no_grass");
        break;
      case "rts_OFF":
        setglobalfutz("no_gfutz", 0.0);
        setsoundcontext("grass", "no_grass");
        break;
      default:
        setglobalfutz("no_gfutz", 0.0);
        setsoundcontext("grass", "no_grass");
        break;
    }
  }
}

waitfor_characterswitch() {
  while(true) {
    level waittill("chr_swtch_start");
    snd_set_snapshot("spl_rts_character_switch");
    playsound(0, "evt_command_switch_static", (0, 0, 0));
    level waittill("chr_swtch_end");
    snd_set_snapshot("default");
  }
}

commandservosounds() {
  player = getlocalplayers()[0];
  pan_volume = 0;
  move_volume = 0;
  pansoundent = spawn(0, (0, 0, 0), "script_origin");
  movesoundent = spawn(0, (0, 0, 0), "script_origin");
  panlooper = pansoundent playloopsound("evt_rts_cmd_pan_lp", 0.1);
  movelooper = movesoundent playloopsound("evt_rts_cmd_move_lp", 0.1);

  while(level.rts_mode == 1) {
    pan = player getnormalizedcameramovement();
    move = player getnormalizedmovement();
    pan = abs(pan[0]);
    move = abs(move[0]);

    if(pan > 0)
      pan_volume = 1;
    else
      pan_volume = 0;

    if(move > 0)
      move_volume = 1;
    else
      move_volume = 0;

    setsoundvolume(panlooper, pan_volume);
    setsoundvolume(movelooper, move_volume);
    wait 0.05;
  }

  pansoundent delete();
  movesoundent delete();
}

vehicleloopsounds(string, alias) {
  if(!isDefined(level.vehicle_sound_ent))
    level.vehicle_sound_ent = spawn(0, (0, 0, 0), "script_origin");

  while(true) {
    level waittill(string);
    level.vehicle_sound_ent playloopsound(alias, 1);
    level waittill_any("chr_swtch_start", "rts_ON");
    level.vehicle_sound_ent stoploopsound(1);
  }
}

rtshealthsystem(clientnum) {
  wait 1;
  level setup_room_and_context();
  level.health_ambient_room_change = 0;
  max_health = getlocalclientmaxhealth(0);
  last_health = 0;
  health_snapshot = "cmn_dying_plr";
  level.tst_health = 0.0;
  level.tst_last_health = 0.0;
  level.tst_snap_value = 0;

  if(isDefined(level.playerrtshealthsystemoverride)) {
    level thread[[level.playerrtshealthsystemoverride]](0);
    return;
  }

  setsoundcontext("health", "full");
  sethealthsnapshot(health_snapshot, 1);

  for(;;) {
    wait 0.02;
    health = getlocalclienthealth(0);

    if(health > 60) {
      if(level.health_ambient_room_change) {
        setsoundcontext("health", "full");
        playsound(0, level.healthsound + "_out", (0, 0, 0));
        deactivateambientroom(0, "health", 100);
        level.health_ambient_room_change = 0;
        level notify("pain_out");
      }

      health_scale = 0;
    } else {
      if(!level.health_ambient_room_change) {
        setsoundcontext("health", "half");
        playsound(0, level.healthsound + "_in", (0, 0, 0));
        activateambientroom(0, "health", 100);
        level.health_ambient_room_change = 1;
      }

      health_scale = scale_speed(40, 0, 0, 1, health);
    }

    sethealthsnapshot(health_snapshot, health_scale);

    level.tst_health = health;
    level.tst_last_health = last_health;
    level.tst_snap_value = health_scale;
    last_health = health;

  }
}