/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\load_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\debug_shared;
#using scripts\shared\doors_shared;
#using scripts\shared\drown;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\player_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_raps;
#using scripts\shared\visionset_mgr_shared;
#namespace load;

function autoexec __init__sytem__() {
  system::register("load", &__init__, undefined, undefined);
}

function autoexec first_frame() {
  level.first_frame = 1;
  wait(0.05);
  level.first_frame = undefined;
}

function __init__() {
  level thread t7_cleanup_output();
  level thread level_notify_listener();
  level thread client_notify_listener();
  level thread load_checkpoint_on_notify();
  level thread save_checkpoint_on_notify();
  if(sessionmodeiscampaigngame()) {
    level.game_mode_suffix = "_cp";
  } else {
    if(sessionmodeiszombiesgame()) {
      level.game_mode_suffix = "_zm";
    } else {
      level.game_mode_suffix = "_mp";
    }
  }
  level.script = tolower(getdvarstring("mapname"));
  level.clientscripts = getdvarstring("cg_usingClientScripts") != "";
  level.campaign = "american";
  level.clientscripts = getdvarstring("cg_usingClientScripts") != "";
  level flag::init("all_players_connected");
  level flag::init("all_players_spawned");
  level flag::init("first_player_spawned");
  if(!isDefined(level.timeofday)) {
    level.timeofday = "day";
  }
  if(getdvarstring("scr_RequiredMapAspectratio") == "") {
    setDvar("scr_RequiredMapAspectratio", "1");
  }
  setDvar("r_waterFogTest", 0);
  setDvar("tu6_player_shallowWaterHeight", "0.0");
  util::registerclientsys("levelNotify");
  level thread all_players_spawned();
  level thread keep_time();
  level thread count_network_frames();
  callback::on_spawned(&on_spawned);
  self thread playerdamagerumble();
  array::thread_all(getEntArray("water", "targetname"), &water_think);
  array::thread_all_ents(getEntArray("badplace", "targetname"), &badplace_think);
  weapon_ammo();
  set_objective_text_colors();
  link_ents();
  init_push_out_threshold();
}

function init_push_out_threshold() {
  push_out_threshold = getdvarfloat("tu16_physicsPushOutThreshold", -1);
  if(push_out_threshold != -1) {
    setDvar("tu16_physicsPushOutThreshold", 20);
  }
}

function count_network_frames() {
  level.network_frame = 0;
  while(true) {
    util::wait_network_frame();
    level.network_frame++;
  }
}

function keep_time() {
  while(true) {
    level.time = gettime();
    wait(0.05);
  }
}

function add_cleanup_msg(msg) {
  if(!isDefined(level.cleanup_msgs)) {
    level.cleanup_msgs = [];
  } else if(!isarray(level.cleanup_msgs)) {
    level.cleanup_msgs = array(level.cleanup_msgs);
  }
  level.cleanup_msgs[level.cleanup_msgs.size] = msg;
}

function t7_cleanup_output() {
  level.cleanup_msgs = array("", "", "");
  wait(1);
  println("");
  foreach(msg in level.cleanup_msgs) {
    println("");
  }
  println("");
}

function level_notify_listener() {
  while(true) {
    val = getdvarstring("");
    if(val != "") {
      toks = strtok(val, "");
      if(toks.size == 3) {
        level notify(toks[0], toks[1], toks[2]);
      } else {
        if(toks.size == 2) {
          level notify(toks[0], toks[1]);
        } else {
          level notify(toks[0]);
        }
      }
      setDvar("", "");
    }
    wait(0.2);
  }
}

function client_notify_listener() {
  while(true) {
    val = getdvarstring("");
    if(val != "") {
      util::clientnotify(val);
      setDvar("", "");
    }
    wait(0.2);
  }
}

function load_checkpoint_on_notify() {
  while(true) {
    level waittill("save");
    checkpointcreate();
    checkpointcommit();
  }
}

function save_checkpoint_on_notify() {
  while(true) {
    level waittill("load");
    checkpointrestore();
  }
}

function weapon_ammo() {
  ents = getEntArray();
  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].classname) && getsubstr(ents[i].classname, 0, 7) == "weapon_") {
      weap = ents[i];
      change_ammo = 0;
      clip = undefined;
      extra = undefined;
      if(isDefined(weap.script_ammo_clip)) {
        clip = weap.script_ammo_clip;
        change_ammo = 1;
      }
      if(isDefined(weap.script_ammo_extra)) {
        extra = weap.script_ammo_extra;
        change_ammo = 1;
      }
      if(change_ammo) {
        if(!isDefined(clip)) {
          assertmsg(((("" + weap.classname) + "") + weap.origin) + "");
        }
        if(!isDefined(extra)) {
          assertmsg(((("" + weap.classname) + "") + weap.origin) + "");
        }
        weap itemweaponsetammo(clip, extra);
        weap itemweaponsetammo(clip, extra, 1);
      }
    }
  }
}

function badplace_think(badplace) {
  if(!isDefined(level.badplaces)) {
    level.badplaces = 0;
  }
  level.badplaces++;
  badplace_box("badplace" + level.badplaces, -1, badplace.origin, badplace.radius, "all");
}

function playerdamagerumble() {
  while(true) {
    self waittill("damage", amount);
    if(isDefined(self.specialdamage)) {
      continue;
    }
    self playrumbleonentity("damage_heavy");
  }
}

function map_is_early_in_the_game() {
  if(isDefined(level.testmap)) {
    return 1;
  }
  if(!isDefined(level.early_level[level.script])) {
    level.early_level[level.script] = 0;
  }
  return isDefined(level.early_level[level.script]) && level.early_level[level.script];
}

function player_throwgrenade_timer() {
  self endon("death");
  self endon("disconnect");
  self.lastgrenadetime = 0;
  while(true) {
    while(!self isthrowinggrenade()) {
      wait(0.05);
    }
    self.lastgrenadetime = gettime();
    while(self isthrowinggrenade()) {
      wait(0.05);
    }
  }
}

function player_special_death_hint() {
  self endon("disconnect");
  self thread player_throwgrenade_timer();
  if(issplitscreen() || util::coopgame()) {
    return;
  }
  self waittill("death", attacker, cause, weapon, inflicter);
  if(cause != "MOD_GAS" && cause != "MOD_GRENADE" && cause != "MOD_GRENADE_SPLASH" && cause != "MOD_SUICIDE" && cause != "MOD_EXPLOSIVE" && cause != "MOD_PROJECTILE" && cause != "MOD_PROJECTILE_SPLASH") {
    return;
  }
  if(level.gameskill >= 2) {
    if(!map_is_early_in_the_game()) {
      return;
    }
  }
  if(cause == "MOD_EXPLOSIVE") {
    if(isDefined(attacker) && (attacker.classname == "script_vehicle" || isDefined(attacker.create_fake_vehicle_damage))) {
      level notify("new_quote_string");
      setDvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
      self thread explosive_vehice_death_indicator_hudelement();
      return;
    }
    if(isDefined(inflicter) && isDefined(inflicter.destructibledef)) {
      if(issubstr(inflicter.destructibledef, "barrel_explosive")) {
        level notify("new_quote_string");
        setDvar("ui_deadquote", "@SCRIPT_EXPLODING_BARREL_DEATH");
        return;
      }
      if(isDefined(inflicter.destructiblecar) && inflicter.destructiblecar) {
        level notify("new_quote_string");
        setDvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
        self thread explosive_vehice_death_indicator_hudelement();
        return;
      }
    }
  }
  if(cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH") {
    if(!weapon.istimeddetonation || !weapon.isgrenadeweapon) {
      return;
    }
    level notify("new_quote_string");
    if(weapon.name == "explosive_bolt") {
      setDvar("ui_deadquote", "@SCRIPT_EXPLOSIVE_BOLT_DEATH");
      thread explosive_arrow_death_indicator_hudelement();
    } else {
      setDvar("ui_deadquote", "@SCRIPT_GRENADE_DEATH");
      thread grenade_death_indicator_hudelement();
    }
    return;
  }
}

function grenade_death_text_hudelement(textline1, textline2) {
  self.failingmission = 1;
  setDvar("ui_deadquote", "");
  wait(0.5);
  fontelem = newhudelem();
  fontelem.elemtype = "font";
  fontelem.font = "default";
  fontelem.fontscale = 1.5;
  fontelem.x = 0;
  fontelem.y = -60;
  fontelem.alignx = "center";
  fontelem.aligny = "middle";
  fontelem.horzalign = "center";
  fontelem.vertalign = "middle";
  fontelem settext(textline1);
  fontelem.foreground = 1;
  fontelem.alpha = 0;
  fontelem fadeovertime(1);
  fontelem.alpha = 1;
  fontelem.hidewheninmenu = 1;
  if(isDefined(textline2)) {
    fontelem = newhudelem();
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = 1.5;
    fontelem.x = 0;
    fontelem.y = -60 + (level.fontheight * fontelem.fontscale);
    fontelem.alignx = "center";
    fontelem.aligny = "middle";
    fontelem.horzalign = "center";
    fontelem.vertalign = "middle";
    fontelem settext(textline2);
    fontelem.foreground = 1;
    fontelem.alpha = 0;
    fontelem fadeovertime(1);
    fontelem.alpha = 1;
    fontelem.hidewheninmenu = 1;
  }
}

function grenade_death_indicator_hudelement() {
  self endon("disconnect");
  wait(0.5);
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = 68;
  overlayicon setshader("hud_grenadeicon_256", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  overlaypointer.x = 0;
  overlaypointer.y = 25;
  overlaypointer setshader("hud_grenadepointer", 50, 25);
  overlaypointer.alignx = "center";
  overlaypointer.aligny = "middle";
  overlaypointer.horzalign = "center";
  overlaypointer.vertalign = "middle";
  overlaypointer.foreground = 1;
  overlaypointer.alpha = 0;
  overlaypointer fadeovertime(1);
  overlaypointer.alpha = 1;
  overlaypointer.hidewheninmenu = 1;
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

function explosive_arrow_death_indicator_hudelement() {
  self endon("disconnect");
  wait(0.5);
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = 68;
  overlayicon setshader("hud_explosive_arrow_icon", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  overlaypointer.x = 0;
  overlaypointer.y = 25;
  overlaypointer setshader("hud_grenadepointer", 50, 25);
  overlaypointer.alignx = "center";
  overlaypointer.aligny = "middle";
  overlaypointer.horzalign = "center";
  overlaypointer.vertalign = "middle";
  overlaypointer.foreground = 1;
  overlaypointer.alpha = 0;
  overlaypointer fadeovertime(1);
  overlaypointer.alpha = 1;
  overlaypointer.hidewheninmenu = 1;
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

function explosive_dart_death_indicator_hudelement() {
  self endon("disconnect");
  wait(0.5);
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = 68;
  overlayicon setshader("hud_monsoon_titus_arrow", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  overlaypointer.x = 0;
  overlaypointer.y = 25;
  overlaypointer setshader("hud_grenadepointer", 50, 25);
  overlaypointer.alignx = "center";
  overlaypointer.aligny = "middle";
  overlaypointer.horzalign = "center";
  overlaypointer.vertalign = "middle";
  overlaypointer.foreground = 1;
  overlaypointer.alpha = 0;
  overlaypointer fadeovertime(1);
  overlaypointer.alpha = 1;
  overlaypointer.hidewheninmenu = 1;
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

function explosive_nitrogen_tank_death_indicator_hudelement() {
  self endon("disconnect");
  wait(0.5);
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = 68;
  overlayicon setshader("hud_monsoon_nitrogen_barrel", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  overlaypointer.x = 0;
  overlaypointer.y = 25;
  overlaypointer setshader("hud_grenadepointer", 50, 25);
  overlaypointer.alignx = "center";
  overlaypointer.aligny = "middle";
  overlaypointer.horzalign = "center";
  overlaypointer.vertalign = "middle";
  overlaypointer.foreground = 1;
  overlaypointer.alpha = 0;
  overlaypointer fadeovertime(1);
  overlaypointer.alpha = 1;
  overlaypointer.hidewheninmenu = 1;
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

function explosive_vehice_death_indicator_hudelement() {
  self endon("disconnect");
  wait(0.5);
  overlayicon = newclienthudelem(self);
  overlayicon.x = 0;
  overlayicon.y = -10;
  overlayicon setshader("hud_exploding_vehicles", 50, 50);
  overlayicon.alignx = "center";
  overlayicon.aligny = "middle";
  overlayicon.horzalign = "center";
  overlayicon.vertalign = "middle";
  overlayicon.foreground = 1;
  overlayicon.alpha = 0;
  overlayicon fadeovertime(1);
  overlayicon.alpha = 1;
  overlayicon.hidewheninmenu = 1;
  overlaypointer = newclienthudelem(self);
  self thread grenade_death_indicator_hudelement_cleanup(overlayicon, overlaypointer);
}

function grenade_death_indicator_hudelement_cleanup(hudelemicon, hudelempointer) {
  self endon("disconnect");
  self waittill("spawned");
  hudelemicon destroy();
  hudelempointer destroy();
}

function special_death_indicator_hudelement(shader, iwidth, iheight, fdelay = 0.5, x, y) {
  wait(fdelay);
  overlay = newclienthudelem(self);
  if(isDefined(x)) {
    overlay.x = x;
  } else {
    overlay.x = 0;
  }
  if(isDefined(y)) {
    overlay.y = y;
  } else {
    overlay.y = 40;
  }
  overlay setshader(shader, iwidth, iheight);
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.horzalign = "center";
  overlay.vertalign = "middle";
  overlay.foreground = 1;
  overlay.alpha = 0;
  overlay fadeovertime(1);
  overlay.alpha = 1;
  overlay.hidewheninmenu = 1;
  self thread special_death_death_indicator_hudelement_cleanup(overlay);
}

function special_death_death_indicator_hudelement_cleanup(overlay) {
  self endon("disconnect");
  self waittill("spawned");
  overlay destroy();
}

function water_think() {
  assert(isDefined(self.target));
  targeted = getent(self.target, "targetname");
  assert(isDefined(targeted));
  waterheight = targeted.origin[2];
  targeted = undefined;
  level.depth_allow_prone = 8;
  level.depth_allow_crouch = 33;
  level.depth_allow_stand = 50;
  while(true) {
    wait(0.05);
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(players[i].inwater) {
        players[i] allowprone(1);
        players[i] allowcrouch(1);
        players[i] allowstand(1);
      }
    }
    self waittill("trigger", other);
    if(!isPlayer(other)) {
      continue;
    }
    while(true) {
      players = getplayers();
      players_in_water_count = 0;
      for(i = 0; i < players.size; i++) {
        if(players[i] istouching(self)) {
          players_in_water_count++;
          players[i].inwater = 1;
          playerorg = players[i] getorigin();
          d = playerorg[2] - waterheight;
          if(d > 0) {
            continue;
          }
          newspeed = int(level.default_run_speed - (abs(d * 5)));
          if(newspeed < 50) {
            newspeed = 50;
          }
          assert(newspeed <= 190);
          if(abs(d) > level.depth_allow_crouch) {
            players[i] allowcrouch(0);
          } else {
            players[i] allowcrouch(1);
          }
          if(abs(d) > level.depth_allow_prone) {
            players[i] allowprone(0);
          } else {
            players[i] allowprone(1);
          }
          continue;
        }
        if(players[i].inwater) {
          players[i].inwater = 0;
        }
      }
      if(players_in_water_count == 0) {
        break;
      }
      wait(0.5);
    }
    wait(0.05);
  }
}

function indicate_start(start) {
  hudelem = newhudelem();
  hudelem.alignx = "left";
  hudelem.aligny = "middle";
  hudelem.x = 70;
  hudelem.y = 400;
  hudelem.label = start;
  hudelem.alpha = 0;
  hudelem.fontscale = 3;
  wait(1);
  hudelem fadeovertime(1);
  hudelem.alpha = 1;
  wait(5);
  hudelem fadeovertime(1);
  hudelem.alpha = 0;
  wait(1);
  hudelem destroy();
}

function calculate_map_center() {
  if(!isDefined(level.mapcenter)) {
    nodes = getallnodes();
    if(isDefined(nodes[0])) {
      level.nodesmins = nodes[0].origin;
      level.nodesmaxs = nodes[0].origin;
    } else {
      level.nodesmins = (0, 0, 0);
      level.nodesmaxs = (0, 0, 0);
    }
    for(index = 0; index < nodes.size; index++) {
      if(nodes[index].type == "BAD NODE") {
        println("", nodes[index].origin);
        continue;
      }
      origin = nodes[index].origin;
      level.nodesmins = math::expand_mins(level.nodesmins, origin);
      level.nodesmaxs = math::expand_maxs(level.nodesmaxs, origin);
    }
    level.mapcenter = math::find_box_center(level.nodesmins, level.nodesmaxs);
    println("", level.mapcenter);
    setmapcenter(level.mapcenter);
  }
}

function set_objective_text_colors() {
  my_textbrightness_default = "1.0 1.0 1.0";
  my_textbrightness_90 = "0.9 0.9 0.9";
  my_textbrightness_85 = "0.85 0.85 0.85";
  if(level.script == "armada") {
    setsaveddvar("con_typewriterColorBase", my_textbrightness_90);
    return;
  }
  setsaveddvar("con_typewriterColorBase", my_textbrightness_default);
}

function lerp_trigger_dvar_value(trigger, dvar, value, time) {
  trigger.lerping_dvar[dvar] = 1;
  steps = time * 20;
  curr_value = getdvarfloat(dvar);
  diff = (curr_value - value) / steps;
  for(i = 0; i < steps; i++) {
    curr_value = curr_value - diff;
    setsaveddvar(dvar, curr_value);
    wait(0.05);
  }
  setsaveddvar(dvar, value);
  trigger.lerping_dvar[dvar] = 0;
}

function set_fog_progress(progress) {
  anti_progress = 1 - progress;
  startdist = (self.script_start_dist * anti_progress) + (self.script_start_dist * progress);
  halfwaydist = (self.script_halfway_dist * anti_progress) + (self.script_halfway_dist * progress);
  color = (self.script_color * anti_progress) + (self.script_color * progress);
  setvolfog(startdist, halfwaydist, self.script_halfway_height, self.script_base_height, color[0], color[1], color[2], 0.4);
}

function ascii_logo() {
  println("");
}

function all_players_spawned() {
  level flag::wait_till("all_players_connected");
  waittillframeend();
  level.host = util::gethostplayer();
  while(true) {
    if(getnumconnectedplayers() == 0) {
      wait(0.05);
      continue;
    }
    players = getplayers();
    count = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i].sessionstate == "playing") {
        count++;
      }
    }
    wait(0.05);
    if(count > 0) {
      level flag::set("first_player_spawned");
    }
    if(count == players.size) {
      break;
    }
  }
  level flag::set("all_players_spawned");
}

function shock_onpain() {
  self endon("death");
  self endon("disconnect");
  self endon("killonpainmonitor");
  if(getdvarstring("blurpain") == "") {
    setDvar("blurpain", "on");
  }
  while(true) {
    oldhealth = self.health;
    self waittill("damage", damage, attacker, direction_vec, point, mod);
    if(isDefined(level.shock_onpain) && !level.shock_onpain) {
      continue;
    }
    if(isDefined(self.shock_onpain) && !self.shock_onpain) {
      continue;
    }
    if(self.health < 1) {
      continue;
    }
    if(mod == "MOD_PROJECTILE") {
      continue;
    } else {
      if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH") {
        self shock_onexplosion(damage);
      } else if(getdvarstring("blurpain") == "on") {
        self shellshock("pain", 0.5);
      }
    }
  }
}

function shock_onexplosion(damage) {
  time = 0;
  multiplier = self.maxhealth / 100;
  scaled_damage = damage * multiplier;
  if(scaled_damage >= 90) {
    time = 4;
  } else {
    if(scaled_damage >= 50) {
      time = 3;
    } else {
      if(scaled_damage >= 25) {
        time = 2;
      } else if(scaled_damage > 10) {
        time = 1;
      }
    }
  }
}

function shock_ondeath() {
  self waittill("death");
  if(isDefined(level.shock_ondeath) && !level.shock_ondeath) {
    return;
  }
  if(isDefined(self.shock_ondeath) && !self.shock_ondeath) {
    return;
  }
  if(isDefined(self.specialdeath)) {
    return;
  }
  if(getdvarstring("r_texturebits") == "16") {
    return;
  }
}

function on_spawned() {
  if(!isDefined(self.player_inited) || !self.player_inited) {
    if(sessionmodeiscampaigngame()) {
      self thread shock_ondeath();
      self thread shock_onpain();
    }
    wait(0.05);
    if(isDefined(self)) {
      self.player_inited = 1;
    }
  }
}

function link_ents() {
  foreach(ent in getEntArray()) {
    if(isDefined(ent.linkto)) {
      e_link = getent(ent.linkto, "linkname");
      if(isDefined(e_link)) {
        ent enablelinkto();
        ent linkto(e_link);
      }
    }
  }
}

function art_review() {
  str_dvar = getdvarstring("art_review");
  switch (str_dvar) {
    case "": {
      setDvar("art_review", "0");
      break;
    }
    case "1":
    case "2": {
      hud = hud::createserverfontstring("objective", 1.2);
      hud hud::setpoint("CENTER", "CENTER", 0, -200);
      hud.sort = 1001;
      hud.color = (1, 0, 0);
      hud settext("ART REVIEW");
      hud.foreground = 0;
      hud.hidewheninmenu = 0;
      if(sessionmodeiszombiesgame()) {
        setDvar("zombie_cheat", "2");
        if(str_dvar == "1") {
          setDvar("zombie_devgui", "power_on");
        }
      } else {
        foreach(trig in trigger::get_all()) {
          trig triggerenable(0);
        }
      }
      level waittill("forever");
      break;
    }
  }
}