/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_so_rts_main.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_music;
#include maps\_vehicle;
#include maps\sp_killstreaks\_killstreaks;
#include maps\_so_rts_precache;
#include maps\_so_rts_rules;
#include maps\_so_rts_ai;
#include maps\_so_rts_catalog;
#include maps\_so_rts_poi;
#include maps\_so_rts_support;
#include maps\_so_rts_main;
#include maps\_so_rts_event;
#include maps\_so_rts_squad;
#include maps\_so_rts_enemy;
#include maps\_so_rts_player;
#include maps\_endmission;

freezecontrolonconnect() {
  flag_wait("all_players_connected");

  foreach(player in getplayers())
  player freezecontrols(1);
}

preload() {
  screen_fade_out(0);
  level thread freezecontrolonconnect();
  level.friendlyfiredisabled = 1;

  if(level.era == "twentytwenty")
    level.supportseliteanimations = 1;

  maps\sp_killstreaks\_killstreaks::preload();
  globals_init();
  maps\_so_rts_precache::main();
  maps\_so_rts_rules::preload();
  maps\_so_rts_ai::ai_preload();
  maps\_so_rts_catalog::preload();
  maps\_so_rts_poi::preload();
  level thread maps\_so_rts_support::hud_message_queue();
  anim_init();
}

postload() {
  maps\_so_rts_support::mp_ents_cleanup();
  level.prevent_player_damage = maps\_so_rts_main::callback_preventplayerdamage;
  level.overrideplayerdamage = maps\_so_rts_main::callback_playerdamage;
  level.onplayerkilled = ::onplayerkilled;
  onplayerkilled_callback(::onplayerkilled);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  println("########################################### PLAY RIP ");
  println("inflictor:" + isDefined(einflictor) ? einflictor : "unk");
  println("attacker:" + isDefined(attacker) ? attacker : "unk");
  println("damage:" + idamage);
  println("sMeansOfDeath:" + isDefined(smeansofdeath) ? smeansofdeath : "unk");
  println("sWeapon:" + isDefined(sweapon) ? sweapon : "unk");

  assert(0);
}

globals_init() {
  if(!isDefined(level.rts))
    level.rts = spawnstruct();

  flag_init("start_rts");
  flag_init("start_rts_enemy");
  flag_init("rts_game_over");
  flag_init("rts_start_clock");
  flag_init("fps_mode");
  flag_init("rts_mode");
  flag_init("rts_hud_on");
  flag_init("block_input");
  flag_init("block_button_press");
  flag_init("fps_mode_locked_out");
  flag_init("rts_mode_locked_out");
  flag_init("unit_select_locked_out");
  setdvar("ui_specops", "1");
  setsaveddvar("compass", "1");
  setdvar("old_compass", "1");
  setdvar("ui_hideminimap", "0");
  level.rts.objectivenum = 10;
  level.rts.ally_cam_active = 0;
  level.rts.additiontargets["axis"] = [];
  level.rts.additiontargets["allies"] = [];
  level.rts.trace_ents = [];
  level.rts.trace_blockers = getentarray("rts_trace_blocker", "targetname");
  game["entity_headicon_allies"] = "hud_specops_ui_deltasupport";
  game["entity_headicon_axis"] = "hudicon_spetsnaz_ctf_flag_carry";
  level.teambased = 0;
  level.rts.fov = 65;
  level.rts.static_trans_time = 1200.0;
  level.rts.static_trans_time_half = level.rts.static_trans_time * 0.5;
  level.rts.static_trans_time_nearhalf = level.rts.static_trans_time_half * 0.7;
  level.rts.lastfpspoint = level.rts.player_startpos;
  level.rts.last_teammate = undefined;
  setsaveddvar("ai_eventDistFootstep", 512);
  setsaveddvar("ai_eventDistFootstepLite", 256);
  setsaveddvar("ai_eventDistNewEnemy", 512);
  setsaveddvar("ai_eventDistPain", 256);
  setsaveddvar("ai_eventDistReact", 128);
  setsaveddvar("ai_eventDistDeath", 256);
  setsaveddvar("ai_eventDistExplosion", 1024);
  setsaveddvar("ai_eventDistGrenadePing", 256);
  setsaveddvar("ai_eventDistProjPing", 128);
  setsaveddvar("ai_eventDistGunShot", 1024);
  setsaveddvar("ai_eventDistSilencedShot", 128);
  setsaveddvar("ai_eventDistBullet", 1024);
  setsaveddvar("ai_eventDistBulletRunning", 1024);
  setsaveddvar("ai_eventDistProjImpact", 300);
  setsaveddvar("ai_eventDistBadPlace", 256);
  rpc("clientscripts/_so_rts", "initTransitionTime", 1.2);
}

#using_animtree("player");
#using_animtree("bigdog");

anim_init() {
  add_scene("plant_network_intruder", "player_tag_origin");
  add_player_anim("player_body", % int_motion_sensor_pullout, 1, 0);
  add_scene("player_death", "player_tag_origin");
  add_player_anim("player_body", % int_war_mode_player_death, 0);
  level.scr_anim["dropoff_claw"]["claw_touchdown"] = % ai_claw_mk2_warmode_touchdown;
  precache_assets();
}

checkpoint_save_restored() {
}

set_uimapname() {
  cur_level = level.player getdstat("PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue");
  next_level_name = tablelookup("sp/levelLookup.csv", 0, cur_level + 1, 1);
  setdvar("ui_mapname", next_level_name);
}

main() {
  onsaverestored_callback(::checkpoint_save_restored);
  wait_for_first_player();
  set_uimapname();
  maps\_so_rts_support::setupmapboundary();
  level thread maps\sp_killstreaks\_killstreaks::init();
  level.killstreakscountsdisabled = 1;
  level.rts.player = getplayers()[0];
  level.rts.player.force_minigame = 1;
  level.rts.lastfpspoint = level.rts.player.origin;
  level.rts.player thread player_deathshieldwatch();
  level.rts.player setclientdvar("cg_aggressiveCullRadius", 100);
  maps\_so_rts_rules::init();
  maps\_so_rts_event::init();
  maps\_so_rts_ai::ai_init();
  maps\_so_rts_catalog::init();
  maps\_so_rts_poi::init();
  maps\_so_rts_squad::init();
  level thread maps\_so_rts_enemy::enemy_player();
  level thread maps\_so_rts_player::friendly_player();
  infantry = maps\_so_rts_squad::getsquadsbytype("infantry", level.rts.player.team).size;
  mechanized = maps\_so_rts_squad::getsquadsbytype("mechanized", level.rts.player.team).size;
  level thread maps\_so_rts_rules::rules_setgametimer();

  maps\_so_rts_support::setup_devgui();

  if(isDefined(level.rts.allied_base) && isDefined(level.rts.allied_base.entity))
    level.rts.player_startpos = level.rts.allied_base.entity.origin;
  else
    level.rts.player_startpos = getplayers()[0].origin;

  node_disconnects();
  wait 1;
  flag_set("start_rts");
  wait 0.05;
  maps\_so_rts_support::toggle_damage_indicators(1);
  level thread maps\_endmission::restartmissionluilistener();
  level thread main_think();
  disablegrenadesuicide();
  level.rts.ground = undefined;
}

node_disconnects() {
  spots = getentarray("node_disconnect", "targetname");

  foreach(spot in spots) {
    nodes = getnodesinradius(spot.origin, spot.radius, 0);

    foreach(node in nodes)
    deletepathnode(node);
  }

  array_thread(spots, ::spot_delete);
}

spot_delete() {
  self delete();
}

staticeffect(duration, rampup, rampdn) {
  self endon("disconnect");
  static = newclienthudelem(self);
  static.horzalign = "fullscreen";
  static.vertalign = "fullscreen";
  static setshader("tow_filter_overlay_no_signal", 640, 480);
  static.archive = 1;
  static.sort = 20;

  if(isDefined(rampup)) {
    s_timer = new_timer();
    f_alpha = 0;
    static.alpha = 0;

    while(static.alpha < 1.0) {
      static.alpha = f_alpha;
      n_current_time = s_timer get_time_in_seconds();
      f_alpha = lerpfloat(f_alpha, 1.0, n_current_time / rampup);
      wait 0.05;
    }
  }

  static.alpha = 1.0;
  wait(duration);

  if(isDefined(rampdn)) {
    s_timer = new_timer();
    f_alpha = 1;
    static.alpha = 1;

    while(static.alpha > 0) {
      static.alpha = f_alpha;
      n_current_time = s_timer get_time_in_seconds();
      f_alpha = lerpfloat(f_alpha, 0, n_current_time / rampdn);
      wait 0.05;
    }
  }

  static destroy();
}

player_eyeinthesky(fastlink, showui, altshader) {
  if(!isDefined(fastlink))
    fastlink = 0;

  if(!isDefined(showui))
    showui = 1;

  if(!isDefined(altshader))
    altshader = 0;

  if(flag("rts_mode_locked_out")) {
    return;
  }
  if(flag("rts_mode")) {
    return;
  }
  level notify("eye_in_the_sky");
  flag_clear("fps_mode");
  flag_set("block_input");
  level.rts.player freezecontrols(1);
  level.rts.player allowads(0);
  level.rts.player.ignoreme = 1;
  level.rts.player enableinvulnerability();
  level.rts.player.takedamage = 0;
  level.rts.targetteammate = undefined;
  level.rts.targetteamenemy = undefined;
  level.rts.minplayerz = level.rts.game_rules.minplayerz;
  level.rts.maxplayerz = level.rts.game_rules.maxplayerz;
  level.rts.minviewangle = -20;
  level.rts.maxviewangle = 89;

  if(!isDefined(level.rts.playerlinkobj)) {
    level.rts.playerlinkobj = spawn("script_model", level.rts.player.origin);
    level.rts.playerlinkobj setmodel("tag_origin");
    level.rts.playerlinkobj.angles = (0, level.rts.player.angles[1], 0);

    if(isDefined(fastlink) && fastlink)
      level.rts.player playerlinkto(level.rts.playerlinkobj, undefined, 1, 0, 0, 0, 0);
  }

  level.rts.player disableweapons();
  level.rts.player disableoffhandweapons();
  level.rts.player enableinvulnerability();
  level.rts.player hideviewmodel();
  level.rts.player allowstand(1);
  level.rts.player setstance("stand");
  level.rts.player allowcrouch(0);
  level.rts.player allowprone(0);
  level.rts.player thread take_weapons();

  if(isDefined(fastlink) && fastlink) {
    level notify("switch_fullstatic");
    level notify("switch_complete");
  } else {
    level.rts.player thread maps\_so_rts_support::do_switch_transition();
    level waittill("switch_fullstatic");
  }

  level notify("rts_ON");

  if(altshader == 0) {
    level clientnotify("rts_ON");
    level.rts.player setclientflag(3);
  } else {
    level clientnotify("rts_ON_alt");
    level.rts.player setclientflag(4);
  }

  setsaveddvar("vc_lut", -3);
  maps\_so_rts_support::toggle_damage_indicators(0);
  level thread rts_menu();
  level.rts.playerlinkobj_moveincforward = undefined;
  level.rts.ground = undefined;
  maps\_so_rts_support::playerlinkobj_defaultpos();
  level.rts.player unlink();
  level.rts.player playerlinkto(level.rts.playerlinkobj, undefined, 1, 0, 0, 0, 0);

  if(!(isDefined(fastlink) && fastlink))
    wait 0.4;

  flag_set("rts_mode");
  flag_clear("block_input");
  level.rts.player freezecontrols(0);
  level thread eyeinthesky_controls();

  if(isDefined(showui) && showui) {
    level thread maps\_so_rts_support::unitreticletracker();
    luinotifyevent(&"rts_hud_visibility", 1, 1);
    luinotifyevent(&"rts_toggle_minimap", 2, 1, 1000);
  }

  level.rts.player.ignoreme = 1;
  level.rts.player enableinvulnerability();
  level.rts.player.takedamage = 1;
  level.rts.player.ally = undefined;
  wait 0.1;

  if(isDefined(level.rts.activesquad))
    package_highlightunits(level.rts.activesquad);
}

eyeinthesky_controls() {
  level endon("rts_terminated");
  maps\_so_rts_support::debounceallbuttons();

  while(flag("rts_mode")) {
    if(flag("block_input")) {
      wait 0.05;
      continue;
    }

    dirty = 0;
    movement = level.rts.player getnormalizedmovement();
    zoom = level.rts.player getnormalizedcameramovement();

    if(level.rts.game_rules.camera_mode == 1) {
      if(zoom[0] > 0.1 || zoom[0] < 0.1 * -1) {
        level.rts.playerlinkobj.origin = level.rts.playerlinkobj.origin - (0, 0, 64 * zoom[0]);
        level.rts.ground = undefined;
        dirty = 1;
      }

      if(zoom[1] > 0.1 || zoom[1] < 0.1 * -1) {
        maps\_so_rts_support::playerlinkobj_rotate(4 * (zoom[1] * -1));
        level.rts.playerlinkobj_moveincforward = undefined;
        dirty = 1;
      }
    } else if(level.rts.game_rules.camera_mode == 0) {
      pitch = zoom[0];
      yaw = zoom[1];

      if(level.wiiu && level.rts.player getcontrollertype() == "remote") {
        deadzoneheight = getlocalprofilefloat("wiiu_aim_deadzone_height");

        if(pitch > 0)
          pitch = clamp((pitch - deadzoneheight) / (1.0 - deadzoneheight), 0.0, 1.0);
        else
          pitch = clamp((pitch + deadzoneheight) / (1.0 - deadzoneheight), -1.0, 0.0);

        deadzonewidth = getlocalprofilefloat("wiiu_aim_deadzone_width");

        if(yaw > 0)
          yaw = clamp((yaw - deadzonewidth) / (1.0 - deadzonewidth), 0.0, 1.0);
        else
          yaw = clamp((yaw + deadzonewidth) / (1.0 - deadzonewidth), -1.0, 0.0);
      }

      playerlinkobj_orient(pitch * -1 * 4, yaw * -1 * 4);
      level.rts.ground = undefined;
      dirty = 1;
      level.rts.playerlinkobj_moveincforward = undefined;
    }

    if(movement[0] > 0.1 || movement[0] < 0.1 * -1 || movement[1] > 0.1 || movement[1] < 0.1 * -1) {
      maps\_so_rts_support::playerlinkobj_moveobj(movement[0], movement[1]);
      level.rts.ground = undefined;
      dirty = 1;
    }

    buttonpressed = maps\_so_rts_support::getbuttonpress();

    switch (buttonpressed) {
      case "NO_INPUT":
        break;
      case "BUTTON_BACK":
      case "BUTTON_BACK_LONG":
        maps\_so_rts_event::trigger_event("switch_character");
        thread player_in_control();
        break;
      case "BUTTON_LSHLDR":
        maps\_so_rts_catalog::package_commandunitrts(level.rts.activesquad);
        break;
      case "BUTTON_LSHLDR_LONG":
      case "BUTTON_RTRIG_LONG":
        level.rts.activesquad = 99;
        package_highlightunits(level.rts.activesquad);
        maps\_so_rts_catalog::package_commandunitrts(level.rts.activesquad);
        break;
      case "BUTTON_RTRIG":
        maps\_so_rts_catalog::package_commandunitrts(level.rts.activesquad);
        break;
    }

    if(dirty)
      maps\_so_rts_support::playerlinkobj_viewclamp();

    update_reticle_icon(1);
    wait 0.05;
  }

  update_reticle_icon(0);
}

player_switch_lockswitch() {
  self endon("death");
  level endon("switch_complete");
  curangles = self.angles;
  curorigin = self.origin;

  while(true) {
    if(self.ai_ref.species == "human" || self.ai_ref.species == "dog" || self.ai_ref.species == "robot_actor")
      self forceteleport(curorigin, curangles);
    else if(self.ai_ref.species == "vehicle") {
      self.origin = curorigin;
      self.angles = curangles;
    }

    wait 0.05;
  }
}

player_in_control(lockswitch, nostatic) {
  if(!isDefined(lockswitch))
    lockswitch = 0;

  if(!isDefined(nostatic))
    nostatic = 0;

  if(flag("fps_mode_locked_out")) {
    return;
  }
  if(flag("fps_mode")) {
    return;
  }
  if(isDefined(level.rts.targetpoi))
    luinotifyevent(&"rts_deselect_poi", 1, level.rts.targetpoi getentitynumber());

  if(isDefined(level.rts.targetteamenemy))
    luinotifyevent(&"rts_deselect_enemy", 1, level.rts.targetteamenemy getentitynumber());

  if(isDefined(level.rts.targetteammate))
    luinotifyevent(&"rts_deselect", 1, level.rts.targetteammate getentitynumber());

  targetent = level.rts.last_teammate;

  if(isDefined(level.rts.targetteammate))
    targetent = level.rts.targetteammate;

  level.rts.targetteammate = undefined;

  if(!isDefined(targetent) || !maps\_so_rts_ai::ai_istakeoverpossible(targetent)) {
    return;
  }
  level.rts.player give_weapons();

  if(isDefined(lockswitch) && lockswitch)
    targetent thread player_switch_lockswitch();

  level notify("player_in_control");

  if(isDefined(targetent.classname) && targetent.classname == "script_vehicle")
    targetent veh_magic_bullet_shield(1);
  else
    targetent.takedamage = 0;

  targetent.selectable = 0;
  flag_clear("rts_mode");
  flag_set("block_input");
  level.rts.player freezecontrols(1);
  level.rts.player playsound("evt_command_switch_static_shrt");

  if(!(isDefined(nostatic) && nostatic)) {
    level.rts.player enableinvulnerability();
    level.rts.player thread maps\_so_rts_support::do_switch_transition(targetent);
  }

  targetent notify("taken_control_over");
  level notify("taken_control_over", targetent);

  if(!(isDefined(nostatic) && nostatic))
    level waittill("switch_fullstatic");

  level clientnotify("rts_OFF");
  level notify("rts_OFF");
  setsaveddvar("vc_lut", 0);
  maps\_so_rts_support::toggle_damage_indicators(1);
  maps\_so_rts_support::playerlinkobj_zoom(0, 0);
  level.rts.player clearclientflag(3);
  level thread fps_menu();
  level.rts.player enableweapons();
  level.rts.player enableoffhandweapons();
  level.rts.player unlink();

  if(isDefined(level.rts.playerlinkobj)) {
    level.rts.playerlinkobj delete();
    level.rts.playerlinkobj = undefined;
  }

  targetent = level.rts.player maps\_so_rts_ai::takeoverselected(targetent);
  level.rts.player showviewmodel();
  level.rts.player allowstand(1);
  level.rts.player setstance("stand");
  level.rts.player allowcrouch(1);
  level.rts.player allowprone(1);
  level.rts.player allowads(1);
  level.disable_damage_overlay = 0;

  if(!(isDefined(nostatic) && nostatic)) {
    level waittill("switch_complete");

    if(!(isDefined(targetent.classname) && targetent.classname == "script_vehicle")) {
      level.rts.player.ignoreme = 0;
      level.rts.player disableinvulnerability();
    }
  } else
    level notify("switch_complete");

  if(isDefined(level.rts.targetteamenemy)) {
    luinotifyevent(&"rts_deselect_enemy", 1, level.rts.targetteamenemy getentitynumber());
    level.rts.targetteamenemy = undefined;
  }

  flag_set("fps_mode");
  flag_clear("block_input");
  level.rts.player freezecontrols(0);
  level.rts.lastsquadselected = level.rts.player.ally.squadid;
  level thread player_in_control_controls();
  luinotifyevent(&"rts_hud_visibility", 1, 0);
  level notify("player_in_control");
}

player_in_control_controls() {
  level endon("rts_terminated");
  maps\_so_rts_support::debounceallbuttons();

  while(flag("fps_mode")) {
    if(flag("block_input")) {
      wait 0.05;
      continue;
    }

    buttonpressed = maps\_so_rts_support::getbuttonpress();

    switch (buttonpressed) {
      case "NO_INPUT":
        break;
      case "BUTTON_BACK":
      case "BUTTON_BACK_LONG":
        maps\_so_rts_event::trigger_event("switch_command");
        rts_go_rts();
        break;
      case "BUTTON_LSHLDR":
        if(!isDefined(level.rts.activesquad))
          maps\_so_rts_catalog::package_highlightunits(level.rts.player.ally.squadid);

        maps\_so_rts_catalog::package_commandunitfps(level.rts.activesquad);
        break;
      case "BUTTON_LSHLDR_LONG":
        level.rts.activesquad = 99;
        package_highlightunits(level.rts.activesquad);
        maps\_so_rts_catalog::package_commandunitfps(level.rts.activesquad);
        break;
    }

    wait 0.05;
  }
}

rts_go_rts(restore) {
  if(!isDefined(restore))
    restore = 1;

  if(flag("rts_mode_locked_out")) {
    return;
  }
  if(flag("rts_mode")) {
    return;
  }
  if(isDefined(level.rts.player.attacked_by_dog)) {
    return;
  }
  if(getdvarint(#"_id_F5F48599") == 1) {
    return;
  }
  level.rts.lastfpspoint = level.rts.player.origin;
  flag_set("block_input");
  level notify("rts_go");
  level.rts.player notify("rts_go");
  level.rts.player freezecontrols(1);
  level.rts.player allowads(0);
  level.rts.player.ignoreme = 1;
  level.rts.player enableinvulnerability();
  level.rts.player.takedamage = 0;
  level.rts.player stopshellshock();
  level.rts.player notify("empGrenadeShutOff");

  if(isDefined(level.rts.player.hud_damagefeedback))
    level.rts.player.hud_damagefeedback.alpha = 0;

  level.rts.player thread staticeffect(0.3, 0.5, 0.5);
  level.rts.player playsound("evt_command_switch_static");
  wait 0.5;

  if(restore)
    level.rts.player maps\_so_rts_ai::restorereplacement();

  level thread player_eyeinthesky(1, 1);
  level waittill("switch_fullstatic");
}

create_player_corpse(spawner, origin, angles) {
  self notify("create_player_corpse");
  self endon("create_player_corpse");

  if(!isDefined(angles))
    angles = level.rts.player.angles;

  if(!isDefined(origin)) {
    trace = bullettrace(level.rts.player.origin + vectorscale((0, 0, -1), 72.0), level.rts.player.origin + vectorscale((0, 0, 1), 72.0), 1, level.rts.player);
    origin = trace["position"] + vectorscale((0, 0, 1), 6.0);
  }

  level waittill("switch_fullstatic");
  ai = simple_spawn_single(spawner, undefined, undefined, undefined, undefined, undefined, undefined, 1);

  if(isDefined(ai)) {
    ai forceteleport(origin, angles);
    ai kill();

    println("creating corpse at:" + origin + " with angles:" + angles);

  }
}

callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  self endon("disconnect");

  if(smeansofdeath == "MOD_TRIGGER_HURT")
    return 0;

  self.last_attacker = eattacker;

  if(isDefined(eattacker) && eattacker == self) {
    self.blockalldamage = 0;
    level notify("rts_player_damaged");
    return idamage;
  }

  if(isDefined(self.blockalldamage) && gettime() < self.blockalldamage)
    return 0;

  if(flag("fps_mode")) {
    idamage = int(idamage * level.rts.game_rules.player_dmg_reducerfps);

    if(idamage >= self.health && (smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_EXPLOSIVE"))
      idamage = self.health - 2;
  }

  if(isDefined(self.armor) && self.armor > 0) {
    self.armor = self.armor - idamage;

    if(self.armor > 0)
      idamage = 0;
    else {
      idamage = self.armor * -1;
      self.armor = undefined;
    }
  }

  if(idamage > self.health) {
    println("Player taking death damage and is about to be killed");

  }

  if(idamage > 0)
    level notify("rts_player_damaged");

  time = gettime();

  if(isDefined(level.rts.player.last_damaged_at) && level.rts.player.last_damaged_at == time)
    idamage = level.rts.player.health - 2;

  level.rts.player.last_damaged_at = time;
  return idamage;
}

delayed_body_delete() {
  level waittill_any("switch_nearfullstatic", "switch_fullstatic");
  delete_models_from_scene("player_death");
  level.rts.player hideviewmodel();
  level.rts.player enableinvulnerability();
}

player_deathshieldwatch() {
  level endon("rts_terminated");
  self enabledeathshield(1);

  while(true) {
    self waittill("deathshield");
    level notify("deathshield");
    assert(isDefined(self.ally));

    println("DEATHSHIELD AT: " + gettime());

    if(isDefined(self.blockalldamage) && gettime() < self.blockalldamage) {
      continue;
    }
    maps\_so_rts_event::trigger_event("player_died");
    flag_set("block_input");
    self freezecontrols(1);

    if(isDefined(self.ally.ai_ref) && self.ally.ai_ref.species == "human" && !isDefined(self.ally.vehicle)) {
      level thread create_player_corpse(self.ally.ai_ref.ref, self.origin, self.angles);

      if(isDefined(self.last_attacker) && self.last_attacker != self) {
        maps\_so_rts_support::hide_player_hud();
        player_tag_origin = spawn("script_model", self.origin);
        player_tag_origin.angles = self.angles;
        player_tag_origin setmodel("tag_origin");
        player_tag_origin.targetname = "player_tag_origin";
        level thread run_scene("player_death");
        wait_network_frame();
        player_bod = get_model_or_models_from_scene("player_death", "player_body");
        level.player shellshock("death", 3.0);
        scene_wait("player_death");

        if(!(isDefined(level.rts.disabledelayeddeathbodydelete) && level.rts.disabledelayeddeathbodydelete))
          level thread delayed_body_delete();

        player_tag_origin delete();
      }
    }

    if(isDefined(self.failondeath) && self.failondeath) {
      maps\_so_rts_rules::mission_complete(0, self);
      flag_clear("block_input");
      self freezecontrols(0);
      return;
    }

    if(flag("fps_mode")) {
      maps\_so_rts_squad::removedeadfromsquad(self.ally.squadid);

      if(level.rts.squads[self.ally.squadid].members.size == 0)
        nextsquad = maps\_so_rts_squad::getnextvalidsquad(self.ally.squadid);
      else {
        numvalid = 0;

        foreach(guy in level.rts.squads[self.ally.squadid].members) {
          if(isDefined(level.rts.player.ally.vehicle) && guy == level.rts.player.ally.vehicle) {
            continue;
          }
          if(!maps\_so_rts_ai::ai_istakeoverpossible(guy)) {
            continue;
          }
          numvalid++;
        }

        if(numvalid > 0)
          nextsquad = self.ally.squadid;
        else
          nextsquad = maps\_so_rts_squad::getnextvalidsquad(self.ally.squadid);
      }

      if(nextsquad == -1) {
        maps\_so_rts_event::trigger_event("died_all_pkgs");
        level.rts.lastfpspoint = level.rts.player.origin;
        level thread rts_go_rts(0);
      } else {
        maps\_so_rts_event::trigger_event("forceswitch_" + level.rts.squads[nextsquad].pkg_ref.ref);
        maps\_so_rts_main::player_nextavailunit(nextsquad, 1);
      }

      luinotifyevent(&"rts_remove_ai", 1, self getentitynumber());

      if(isDefined(self.viewlockedentity) && self.viewlockedentity.health > 0)
        self.viewlockedentity kill();
    }
  }
}

callback_preventplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  self endon("disconnect");

  if(smeansofdeath == "MOD_TRIGGER_HURT")
    return true;

  if(self player_flag("player_is_invulnerable"))
    return true;

  if(isDefined(self.blockalldamage) && gettime() < self.blockalldamage) {
    self playrumbleonentity("damage_light");

    println("@$@ Player took no damage due to blockAllDamage being set(" + gettime() + ")");

    return true;
  }

  return false;
}

player_nextavailunit(nextsquad, playerdied) {
  if(isDefined(level.rts.player_nextavailunitcb)) {
    [
      [level.rts.player_nextavailunitcb]
    ](nextsquad, playerdied);
    return;
  }

  if(!isDefined(nextsquad))
    nextsquad = maps\_so_rts_squad::getnextvalidsquad();
  else {
    maps\_so_rts_squad::removedeadfromsquad(nextsquad);

    if(!(isDefined(level.rts.squads[nextsquad].selectable) && level.rts.squads[nextsquad].selectable))
      nextsquad = maps\_so_rts_squad::getnextvalidsquad();
  }

  if(nextsquad != -1)
    level thread squadselectnextaiandtakeover(nextsquad, playerdied);
  else {
    maps\_so_rts_event::trigger_event("died_all_pkgs");
    level.rts.lastfpspoint = level.rts.player.origin;
    level thread rts_go_rts();
    self.ally = undefined;
  }
}

fps_onlymode(ignoreexclusion) {
  flag_set("rts_mode_locked_out");

  if(flag("rts_mode")) {
    allies = getaiarray("allies");
    alive = [];

    for(i = 0; i < allies.size; i++) {
      if(!(isDefined(level.rts.squads[allies[i].squadid].selectable) && level.rts.squads[allies[i].squadid].selectable) || !(isDefined(allies[i].rts_unloaded) && allies[i].rts_unloaded)) {
        continue;
      }
      alive[alive.size] = allies[i];
    }

    allies = alive;

    if(allies.size == 0) {
      level thread maps\_so_rts_rules::mission_complete(0);
      return;
    }
  }

  if(isarray(ignoreexclusion)) {
    foreach(item in ignoreexclusion) {
      for(i = 0; i < level.rts.packages.size; i++) {
        if(level.rts.packages[i].ref == item)
          continue;
      }
    }
  } else {
    for(i = 0; i < level.rts.packages.size; i++) {
      if(level.rts.packages[i].ref == ignoreexclusion)
        continue;
    }
  }
}

rts_menu() {
  level notify("hide_hint");
  setsaveddvar("hud_showStance", "0");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("cg_drawCrosshair", 0);

  foreach(player in getplayers()) {
    player cleardamageindicator();
    player setclientdvars("cg_drawfriendlynames", 0);
    player setclientuivisibilityflag("hud_visible", 1);
  }

  luinotifyevent(&"hud_hide_shadesHud");
}

fps_menu() {
  maps\_so_rts_support::show_player_hud();
}

main_think() {
  flag_wait("start_rts");
  level.rts.start_time = gettime();

  while(!flag("rts_game_over"))
    wait 0.25;

  if(!flag("rts_mode")) {
    flag_clear("rts_mode_locked_out");
    level.rts.lastfpspoint = level.rts.player.origin;
  }

  level notify("rts_terminated");
  maps\_so_rts_support::time_countdown_delete();
  maps\_so_rts_support::hide_player_hud();
  maps\_so_rts_support::toggle_damage_indicators(0);
  update_reticle_icon(0);

  foreach(squad in level.rts.squads)
  luinotifyevent(&"rts_remove_squad", 1, squad.id);

  rpc("clientscripts/_so_rts", "toggle_satellite_RemoteMissile", 0, 0);
}

update_reticle_icon(in_rts_mode) {
  if(level.wiiu) {
    controllertype = level.rts.player getcontrollertype();

    if(controllertype == "remote" && in_rts_mode) {
      setsaveddvar("wiiu_reticleOverrideMaterial", "hud_rts_reticle");
      setsaveddvar("wiiu_reticleOverrideSize", "88.0");
    } else
      setsaveddvar("wiiu_reticleOverrideMaterial", "");
  }
}