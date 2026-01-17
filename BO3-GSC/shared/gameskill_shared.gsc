/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\gameskill_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\weaponlist;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\util_shared;
#namespace gameskill;

function autoexec init() {
  level.gameskill = 0;
}

function setskill(reset, skill_override) {
  if(!isDefined(level.script)) {
    level.script = tolower(getdvarstring("mapname"));
  }
  if(!(isDefined(reset) && reset)) {
    if(isDefined(level.b_gameskillset) && level.b_gameskillset) {
      return;
    }
    level.global_damage_func_ads = &empty_kill_func;
    level.global_damage_func = &empty_kill_func;
    level.global_kill_func = &empty_kill_func;
    util::set_console_status();
    thread playerhealthdebug();
    if(util::coopgame()) {
      thread coop_player_threat_bias_adjuster();
      thread coop_enemy_accuracy_scalar_watcher();
      thread coop_friendly_accuracy_scalar_watcher();
    }
    level.b_gameskillset = 1;
  }
  replay_single_mission = getdvarint("ui_singlemission");
  if(replay_single_mission == 1) {
    single_mission_difficulty = getdvarint("ui_singlemission_difficulty");
    if(single_mission_difficulty >= 0) {
      skill_override = single_mission_difficulty;
    }
  }
  level thread update_skill_level(skill_override);
  if(!isDefined(level.player_attacker_accuracy_multiplier)) {
    level.player_attacker_accuracy_multiplier = 1;
  }
  anim.run_accuracy = 0.5;
  level.auto_adjust_threatbias = 1;
  anim.pain_test = &pain_protection;
  set_difficulty_from_locked_settings();
}

function apply_difficulty_var_with_func(difficulty_func) {
  level.playerhealth_regularregendelay = get_player_health_regular_regen_delay();
  level.worthydamageratio = get_worthy_damage_ratio();
  if(level.auto_adjust_threatbias) {
    thread apply_threat_bias_to_all_players(difficulty_func);
  }
  level.longregentime = get_long_regen_time();
  anim.player_attacker_accuracy = get_base_enemy_accuracy() * level.player_attacker_accuracy_multiplier;
  anim.dog_hits_before_kill = get_dog_hits_before_kill();
  anim.dog_health = get_dog_health();
  anim.dog_presstime = get_dog_press_time();
  setsaveddvar("ai_accuracyDistScale", 1);
  thread coop_damage_and_accuracy_scaling(difficulty_func);
}

function apply_threat_bias_to_all_players(difficulty_func) {
  level flag::wait_till("all_players_connected");
  players = level.players;
  for(i = 0; i < players.size; i++) {
    players[i].threatbias = int(get_player_threat_bias());
  }
}

function coop_damage_and_accuracy_scaling(difficulty_func) {}

function set_difficulty_from_locked_settings() {
  apply_difficulty_var_with_func(&get_locked_difficulty_val);
}

function get_locked_difficulty_val(msg, ignored) {
  return level.difficultysettings[msg][level.currentdifficulty];
}

function always_pain() {
  return false;
}

function pain_protection() {
  if(!pain_protection_check()) {
    return 0;
  }
  return randomint(100) > (get_enemy_pain_chance() * 100);
}

function pain_protection_check() {
  if(!isalive(self.enemy)) {
    return false;
  }
  if(!isplayer(self.enemy)) {
    return false;
  }
  if(!isalive(level.painai) || level.painai.a.script != "pain") {
    level.painai = self;
  }
  if(self == level.painai) {
    return false;
  }
  if(self.damageweapon != level.weaponnone && self.damageweapon.isboltaction) {
    return false;
  }
  return true;
}

function playerhealthdebug() {
  setdvar("", "");
  waittillframeend();
  while(true) {
    while(true) {
      if(getdvarstring("") != "") {
        break;
      }
      wait(0.5);
    }
    thread printhealthdebug();
    while(true) {
      if(getdvarstring("") == "") {
        break;
      }
      wait(0.5);
    }
    level notify("stop_printing_grenade_timers");
    destroyhealthdebug();
  }
}

function printhealthdebug() {
  level notify("stop_printing_health_bars");
  level endon("stop_printing_health_bars");
  y = 40;
  level.healthbarhudelems = [];
  level.healthbarkeys[0] = "Health";
  level.healthbarkeys[1] = "No Hit Time";
  level.healthbarkeys[2] = "No Die Time";
  if(!isDefined(level.playerinvultimeend)) {
    level.playerinvultimeend = 0;
  }
  if(!isDefined(level.player_deathinvulnerabletimeout)) {
    level.player_deathinvulnerabletimeout = 0;
  }
  for(i = 0; i < level.healthbarkeys.size; i++) {
    key = level.healthbarkeys[i];
    textelem = newhudelem();
    textelem.x = 150;
    textelem.y = y;
    textelem.alignx = "left";
    textelem.aligny = "top";
    textelem.horzalign = "fullscreen";
    textelem.vertalign = "fullscreen";
    textelem settext(key);
    bgbar = newhudelem();
    bgbar.x = 150 + 79;
    bgbar.y = y + 1;
    bgbar.z = 1;
    bgbar.alignx = "left";
    bgbar.aligny = "top";
    bgbar.horzalign = "fullscreen";
    bgbar.vertalign = "fullscreen";
    bgbar.maxwidth = 3;
    bgbar setshader("white", bgbar.maxwidth, 10);
    bgbar.color = vectorscale((1, 1, 1), 0.5);
    bar = newhudelem();
    bar.x = 150 + 80;
    bar.y = y + 2;
    bar.alignx = "left";
    bar.aligny = "top";
    bar.horzalign = "fullscreen";
    bar.vertalign = "fullscreen";
    bar setshader("black", 1, 8);
    bar.sort = 1;
    textelem.bar = bar;
    textelem.bgbar = bgbar;
    textelem.key = key;
    y = y + 10;
    level.healthbarhudelems[key] = textelem;
  }
  level flag::wait_till("all_players_spawned");
  while(true) {
    wait(0.05);
    players = level.players;
    for(i = 0; i < level.healthbarkeys.size && players.size > 0; i++) {
      key = level.healthbarkeys[i];
      player = players[0];
      width = 0;
      if(i == 0) {
        width = (player.health / player.maxhealth) * 300;
        level.healthbarhudelems[key] settext((level.healthbarkeys[0] + " ") + player.health);
      } else {
        if(i == 1) {
          width = ((level.playerinvultimeend - gettime()) / 1000) * 40;
        } else if(i == 2) {
          width = ((level.player_deathinvulnerabletimeout - gettime()) / 1000) * 40;
        }
      }
      width = int(max(width, 1));
      width = int(min(width, 300));
      bar = level.healthbarhudelems[key].bar;
      bar setshader("black", width, 8);
      bgbar = level.healthbarhudelems[key].bgbar;
      if((width + 2) > bgbar.maxwidth) {
        bgbar.maxwidth = width + 2;
        bgbar setshader("white", bgbar.maxwidth, 10);
        bgbar.color = vectorscale((1, 1, 1), 0.5);
      }
    }
  }
}

function destroyhealthdebug() {
  level notify("stop_printing_health_bars");
  if(!isDefined(level.healthbarhudelems)) {
    return;
  }
  for(i = 0; i < level.healthbarkeys.size; i++) {
    level.healthbarhudelems[level.healthbarkeys[i]].bgbar destroy();
    level.healthbarhudelems[level.healthbarkeys[i]].bar destroy();
    level.healthbarhudelems[level.healthbarkeys[i]] destroy();
  }
}

function axisaccuracycontrol() {
  self endon("long_death");
  self endon("death");
  if(isDefined(level.script) && level.script != "core_frontend") {
    self coop_axis_accuracy_scaler();
  }
}

function alliesaccuracycontrol() {
  self endon("long_death");
  self endon("death");
  self coop_allies_accuracy_scaler();
}

function playerhurtcheck() {
  self endon("death");
  self endon("killhurtcheck");
  self.hurtagain = 0;
  for(;;) {
    self waittill("damage", amount, attacker, dir, point, mod);
    if(isDefined(attacker) && isplayer(attacker) && attacker.team == self.team) {
      continue;
    }
    self.hurtagain = 1;
    self.damagepoint = point;
    self.damageattacker = attacker;
    if(isDefined(mod) && mod == "MOD_BURNED") {
      self setburn(0.5);
      self playSound("chr_burn");
    }
    invulworthyhealthdrop = (amount / self.maxhealth) >= level.worthydamageratio;
    death_invuln_time = 0;
    if(self.health <= 1 && self player_eligible_for_death_invulnerability()) {
      invulworthyhealthdrop = 1;
      player_death_invulnerability_time = get_player_death_invulnerable_time();
      coop_death_invulnerability_time_modifier = get_coop_player_death_invulnerable_time_modifier();
      death_invuln_time = player_death_invulnerability_time * coop_death_invulnerability_time_modifier;
      self.eligible_for_death_invulnerability = 0;
      self thread monitor_player_death_invulnerability_eligibility();
      level.player_deathinvulnerabletimeout = gettime() + death_invuln_time;
    }
    oldratio = self.health / self.maxhealth;
    level notify("hit_again");
    health_add = 0;
    hurttime = gettime();
    if(!isDefined(level.disable_damage_blur)) {
      self startfadingblur(3, 0.8);
    }
    if(!invulworthyhealthdrop) {
      continue;
    }
    if(self flag::get("player_is_invulnerable")) {
      continue;
    }
    self flag::set("player_is_invulnerable");
    level notify("player_becoming_invulnerable");
    if(death_invuln_time < get_player_hit_invuln_time()) {
      invultime = get_player_hit_invuln_time();
    } else {
      invultime = death_invuln_time;
    }
    self thread playerinvul(invultime);
  }
}

function playerhealthregen() {
  self endon("death");
  self endon("disconnect");
  self endon("removehealthregen");
  if(!isDefined(self.flag)) {
    self.flag = [];
    self.flags_lock = [];
  }
  if(!isDefined(self.flag["player_has_red_flashing_overlay"])) {
    self flag::init("player_has_red_flashing_overlay");
    self flag::init("player_is_invulnerable");
  }
  self flag::clear("player_has_red_flashing_overlay");
  self flag::clear("player_is_invulnerable");
  self thread increment_take_cover_warnings_on_death();
  self settakecoverwarnings();
  self thread healthoverlay();
  oldratio = 1;
  health_add = 0;
  veryhurt = 0;
  playerjustgotredflashing = 0;
  invultime = 0;
  hurttime = 0;
  newhealth = 0;
  self.attackeraccuracy = 1;
  self.oldattackeraccuracy = 1;
  self.ignorebulletdamage = 0;
  self thread playerhurtcheck();
  if(!isDefined(self.veryhurt)) {
    self.veryhurt = 0;
  }
  self.bolthit = 0;
  for(;;) {
    wait(0.05);
    waittillframeend();
    if(self.health == self.maxhealth) {
      if(self flag::get("player_has_red_flashing_overlay")) {
        flag::clear("player_has_red_flashing_overlay");
      }
      playerjustgotredflashing = 0;
      veryhurt = 0;
      continue;
    }
    if(self.health <= 0) {
      return;
    }
    wasveryhurt = veryhurt;
    health_ratio = self.health / self.maxhealth;
    if(health_ratio <= get_health_overlay_cutoff()) {
      veryhurt = 1;
      self thread cover_warning_check();
      if(!wasveryhurt) {
        hurttime = gettime();
        self flag::set("player_has_red_flashing_overlay");
        playerjustgotredflashing = 1;
      }
    }
    if(self.hurtagain) {
      hurttime = gettime();
      self.hurtagain = 0;
    }
    if(health_ratio >= oldratio) {
      if((gettime() - hurttime) < level.playerhealth_regularregendelay) {
        continue;
      }
      if(veryhurt) {
        self.veryhurt = 1;
        newhealth = health_ratio;
        if(gettime() > (hurttime + level.longregentime)) {
          newhealth = newhealth + 0.1;
        }
        if(newhealth >= 1) {
          reducetakecoverwarnings();
        }
      } else {
        newhealth = 1;
        self.veryhurt = 0;
      }
      if(newhealth > 1) {
        newhealth = 1;
      }
      if(newhealth <= 0) {
        return;
      }
      self setnormalhealth(newhealth);
      oldratio = self.health / self.maxhealth;
      continue;
    }
  }
}

function reducetakecoverwarnings() {
  players = level.players;
  if(isDefined(players[0]) && isalive(players[0])) {
    takecoverwarnings = getlocalprofileint("takeCoverWarnings");
    if(takecoverwarnings > 0) {
      takecoverwarnings--;
      setlocalprofilevar("takeCoverWarnings", takecoverwarnings);
      debugtakecoverwarnings();
    }
  }
}

function debugtakecoverwarnings() {
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "") {
    iprintln("", getlocalprofileint("") - 3);
  }
}

function playerinvul(timer) {
  self endon("death");
  self endon("disconnect");
  self.oldattackeraccuracy = self.attackeraccuracy;
  if(timer > 0) {
    self.attackeraccuracy = 0;
    self.ignorebulletdamage = 1;
    level.playerinvultimeend = gettime() + (timer * 1000);
    wait(timer);
  }
  self.attackeraccuracy = self.oldattackeraccuracy;
  self.ignorebulletdamage = 0;
  self flag::clear("player_is_invulnerable");
}

function grenadeawareness() {
  if(self.team == "allies") {
    self.grenadeawareness = 0.9;
    return;
  }
  if(self.team == "axis") {
    if(isDefined(level.gameskill) && level.gameskill >= 2) {
      if(randomint(100) < 33) {
        self.grenadeawareness = 0.2;
      } else {
        self.grenadeawareness = 0.5;
      }
    } else {
      if(randomint(100) < 33) {
        self.grenadeawareness = 0;
      } else {
        self.grenadeawareness = 0.2;
      }
    }
  }
}

function playerheartbeatloop(healthcap) {
  self endon("disconnect");
  self endon("killed_player");
  wait(2);
  player = self;
  ent = undefined;
  for(;;) {
    wait(0.2);
    if(player.health >= healthcap) {
      if(isDefined(ent)) {
        ent stoploopsound(1.5);
        level thread delayed_delete(ent, 1.5);
      }
      continue;
    }
    ent = spawn("script_origin", self.origin);
    ent playLoopSound("", 0.5);
  }
}

function delayed_delete(ent, time) {
  wait(time);
  ent delete();
  ent = undefined;
}

function healthfadeoffwatcher(overlay, timetofadeout) {
  self notify("new_style_health_overlay_done");
  self endon("new_style_health_overlay_done");
  while(!(isDefined(level.disable_damage_overlay) && level.disable_damage_overlay) && timetofadeout > 0) {
    wait(0.05);
    timetofadeout = timetofadeout - 0.05;
  }
  if(isDefined(level.disable_damage_overlay) && level.disable_damage_overlay) {
    overlay.alpha = 0;
    overlay fadeovertime(0.05);
  }
}

function new_style_health_overlay() {}

function healthoverlay() {
  self endon("disconnect");
  self endon("nohealthoverlay");
  new_style_health_overlay();
}

function add_hudelm_position_internal(aligny) {
  if(level.console) {
    self.fontscale = 2;
  } else {
    self.fontscale = 1.6;
  }
  self.x = 0;
  self.y = -36;
  self.alignx = "center";
  self.aligny = "bottom";
  self.horzalign = "center";
  self.vertalign = "middle";
  if(!isDefined(self.background)) {
    return;
  }
  self.background.x = 0;
  self.background.y = -40;
  self.background.alignx = "center";
  self.background.aligny = "middle";
  self.background.horzalign = "center";
  self.background.vertalign = "middle";
  if(level.console) {
    self.background setshader("popmenu_bg", 650, 52);
  } else {
    self.background setshader("popmenu_bg", 650, 42);
  }
  self.background.alpha = 0.5;
}

function create_warning_elem(player) {
  level notify("hud_elem_interupt");
  hudelem = newhudelem();
  hudelem add_hudelm_position_internal();
  hudelem thread destroy_warning_elem_when_mission_failed(player);
  hudelem settext(&"GAME_GET_TO_COVER");
  hudelem.fontscale = 1.85;
  hudelem.alpha = 1;
  hudelem.color = (1, 0.6, 0);
  return hudelem;
}

function play_hurt_vox() {
  if(isDefined(self.veryhurt)) {
    if(self.veryhurt == 0) {
      if(randomintrange(0, 1) == 1) {
        playsoundatposition("chr_breathing_hurt_start", self.origin);
      }
    }
  }
}

function waittillplayerishitagain() {
  level endon("hit_again");
  self waittill("damage");
}

function destroy_warning_elem_when_mission_failed(player) {
  self endon("being_destroyed");
  self endon("death");
  level flag::wait_till("missionfailed");
  self thread destroy_warning_elem(1);
}

function destroy_warning_elem(fadeout) {
  self notify("being_destroyed");
  self.beingdestroyed = 1;
  if(fadeout) {
    self fadeovertime(0.5);
    self.alpha = 0;
    wait(0.5);
  }
  self util::death_notify_wrapper();
  self destroy();
}

function maychangecoverwarningalpha(coverwarning) {
  if(!isDefined(coverwarning)) {
    return false;
  }
  if(isDefined(coverwarning.beingdestroyed)) {
    return false;
  }
  return true;
}

function fontscaler(scale, timer) {
  self endon("death");
  scale = scale * 2;
  dif = scale - self.fontscale;
  self changefontscaleovertime(timer);
  self.fontscale = self.fontscale + dif;
}

function cover_warning_check() {
  level endon("missionfailed");
  if(self shouldshowcoverwarning()) {
    coverwarning = create_warning_elem(self);
    level.cover_warning_hud = coverwarning;
    coverwarning endon("death");
    stopflashingbadlytime = gettime() + level.longregentime;
    yellow_fac = 0.7;
    while(gettime() < stopflashingbadlytime && isalive(self)) {
      for(i = 0; i < 7; i++) {
        yellow_fac = yellow_fac + 0.03;
        coverwarning.color = (1, yellow_fac, 0);
        wait(0.05);
      }
      for(i = 0; i < 7; i++) {
        yellow_fac = yellow_fac - 0.03;
        coverwarning.color = (1, yellow_fac, 0);
        wait(0.05);
      }
    }
    if(maychangecoverwarningalpha(coverwarning)) {
      coverwarning fadeovertime(0.5);
      coverwarning.alpha = 0;
    }
    wait(0.5);
    wait(5);
    coverwarning destroy();
  }
}

function shouldshowcoverwarning() {
  return false;
}

function fadefunc(overlay, coverwarning, severity, mult, hud_scaleonly) {
  fadeintime = 0.8 * 0.1;
  stayfulltime = 0.8 * (0.1 + (severity * 0.2));
  fadeouthalftime = 0.8 * (0.1 + (severity * 0.1));
  fadeoutfulltime = 0.8 * 0.3;
  remainingtime = (((0.8 - fadeintime) - stayfulltime) - fadeouthalftime) - fadeoutfulltime;
  assert(remainingtime >= -0.001);
  if(remainingtime < 0) {
    remainingtime = 0;
  }
  halfalpha = 0.8 + (severity * 0.1);
  leastalpha = 0.5 + (severity * 0.3);
  overlay fadeovertime(fadeintime);
  overlay.alpha = mult * 1;
  if(maychangecoverwarningalpha(coverwarning)) {
    if(!hud_scaleonly) {
      coverwarning fadeovertime(fadeintime);
      coverwarning.alpha = mult * 1;
    }
  }
  if(isDefined(coverwarning)) {
    coverwarning thread fontscaler(1, fadeintime);
  }
  wait(fadeintime + stayfulltime);
  overlay fadeovertime(fadeouthalftime);
  overlay.alpha = mult * halfalpha;
  if(maychangecoverwarningalpha(coverwarning)) {
    if(!hud_scaleonly) {
      coverwarning fadeovertime(fadeouthalftime);
      coverwarning.alpha = mult * halfalpha;
    }
  }
  wait(fadeouthalftime);
  overlay fadeovertime(fadeoutfulltime);
  overlay.alpha = mult * leastalpha;
  if(maychangecoverwarningalpha(coverwarning)) {
    if(!hud_scaleonly) {
      coverwarning fadeovertime(fadeoutfulltime);
      coverwarning.alpha = mult * leastalpha;
    }
  }
  if(isDefined(coverwarning)) {
    coverwarning thread fontscaler(0.9, fadeoutfulltime);
  }
  wait(fadeoutfulltime);
  wait(remainingtime);
}

function healthoverlay_remove(overlay) {
  self endon("disconnect");
  self util::waittill_any("noHealthOverlay", "death");
  overlay fadeovertime(3.5);
  overlay.alpha = 0;
}

function settakecoverwarnings() {
  ispregameplaylevel = level.script == "training" || level.script == "cargoship" || level.script == "coup";
  if(getlocalprofileint("takeCoverWarnings") == -1 || ispregameplaylevel) {
    setlocalprofilevar("takeCoverWarnings", 9);
  }
  debugtakecoverwarnings();
}

function increment_take_cover_warnings_on_death() {
  if(!isplayer(self)) {
    return;
  }
  level notify("new_cover_on_death_thread");
  level endon("new_cover_on_death_thread");
  self waittill("death");
  if(!self flag::get("player_has_red_flashing_overlay")) {
    return;
  }
  if(level.gameskill > 1) {
    return;
  }
  warnings = getlocalprofileint("takeCoverWarnings");
  if(warnings < 10) {
    setlocalprofilevar("takeCoverWarnings", warnings + 1);
  }
  debugtakecoverwarnings();
}

function empty_kill_func(type, loc, point, attacker, amount) {}

function update_skill_level(skill_override) {
  level notify("update_skill_from_profile");
  level endon("update_skill_from_profile");
  level.gameskilllowest = 9999;
  level.gameskillhighest = 0;
  n_last_gameskill = -1;
  while(!isDefined(skill_override)) {
    level.gameskill = getlocalprofileint("g_gameskill");
    if(level.gameskill != n_last_gameskill) {
      if(!isDefined(level.gameskill)) {
        level.gameskill = 0;
      }
      setdvar("saved_gameskill", level.gameskill);
      switch (level.gameskill) {
        case 0: {
          setdvar("currentDifficulty", "easy");
          level.currentdifficulty = "easy";
          break;
        }
        case 1: {
          setdvar("currentDifficulty", "normal");
          level.currentdifficulty = "normal";
          break;
        }
        case 2: {
          setdvar("currentDifficulty", "hardened");
          level.currentdifficulty = "hardened";
          break;
        }
        case 3: {
          setdvar("currentDifficulty", "veteran");
          level.currentdifficulty = "veteran";
          break;
        }
        case 4: {
          setdvar("currentDifficulty", "realistic");
          level.currentdifficulty = "realistic";
          break;
        }
      }
      println("" + level.gameskill);
      n_last_gameskill = level.gameskill;
      if(level.gameskill < level.gameskilllowest) {
        level.gameskilllowest = level.gameskill;
        matchrecordsetleveldifficultyforindex(2, level.gameskill);
      }
      if(level.gameskill > level.gameskillhighest) {
        level.gameskillhighest = level.gameskill;
        matchrecordsetleveldifficultyforindex(3, level.gameskill);
      }
      foreach(player in getplayers()) {
        player clientfield::set_player_uimodel("serverDifficulty", level.gameskill);
      }
    }
    wait(1);
  }
}

function coop_enemy_accuracy_scalar_watcher() {
  level flagsys::wait_till("load_main_complete");
  level flag::wait_till("all_players_connected");
  while(level.players.size > 1) {
    players = getplayers("allies");
    level.coop_enemy_accuracy_scalar = get_coop_enemy_accuracy_modifier();
    wait(0.5);
  }
}

function coop_friendly_accuracy_scalar_watcher() {
  level flagsys::wait_till("load_main_complete");
  level flag::wait_till("all_players_connected");
  while(level.players.size > 1) {
    players = getplayers("allies");
    level.coop_friendly_accuracy_scalar = get_coop_friendly_accuracy_modifier();
    wait(0.5);
  }
}

function coop_axis_accuracy_scaler() {
  self endon("death");
  initialvalue = self.baseaccuracy;
  self.baseaccuracy = initialvalue * get_coop_enemy_accuracy_modifier();
  wait(randomfloatrange(3, 5));
}

function coop_allies_accuracy_scaler() {
  self endon("death");
  initialvalue = self.baseaccuracy;
  while(level.players.size > 1) {
    if(!isDefined(level.coop_friendly_accuracy_scalar)) {
      wait(0.5);
      continue;
    }
    self.baseaccuracy = initialvalue * level.coop_friendly_accuracy_scalar;
    wait(randomfloatrange(3, 5));
  }
}

function coop_player_threat_bias_adjuster() {
  while(true) {
    wait(5);
    if(level.auto_adjust_threatbias) {
      players = getplayers("allies");
      for(i = 0; i < players.size; i++) {
        enable_auto_adjust_threatbias(players[i]);
      }
    }
  }
}

function enable_auto_adjust_threatbias(player) {
  level.auto_adjust_threatbias = 1;
  players = level.players;
  level.coop_player_threatbias_scalar = get_coop_friendly_threat_bias_scalar();
  if(!isDefined(level.coop_player_threatbias_scalar)) {
    level.coop_player_threatbias_scalar = 1;
  }
  player.threatbias = int(get_player_threat_bias() * level.coop_player_threatbias_scalar);
}

function setdiffstructarrays() {
  reload = 0;
  reload = 1;
  if(reload || !isDefined(level.s_game_difficulty)) {
    level.s_game_difficulty = [];
    level.s_game_difficulty[0] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_easy");
    level.s_game_difficulty[1] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_medium");
    level.s_game_difficulty[2] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_hard");
    level.s_game_difficulty[3] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_veteran");
    level.s_game_difficulty[4] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_realistic");
  }
}

function get_player_threat_bias() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].threatbias;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_player_xp_difficulty_multiplier() {
  setdiffstructarrays();
  diff_xp_mult = level.s_game_difficulty[level.gameskill].difficulty_xp_multiplier;
  if(isDefined(diff_xp_mult)) {
    return diff_xp_mult;
  }
  return 1;
}

function get_health_overlay_cutoff() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].healthoverlaycutoff;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_enemy_pain_chance() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].enemypainchance;
  modifier = get_coop_enemy_pain_chance_modifier();
  if(isDefined(diff_struct_value)) {
    diff_struct_value = modifier * diff_struct_value;
    return diff_struct_value;
  }
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_player_death_invulnerable_time() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].player_deathinvulnerabletime;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_base_enemy_accuracy() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].base_enemy_accuracy;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_player_difficulty_health() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].playerdifficultyhealth;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_player_hit_invuln_time() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].playerhitinvulntime;
  modifier = get_coop_hit_invulnerability_modifier();
  if(isDefined(diff_struct_value)) {
    diff_struct_value = modifier * diff_struct_value;
    return diff_struct_value;
  }
  return 0;
}

function get_miss_time_constant() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].misstimeconstant;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_miss_time_reset_delay() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].misstimeresetdelay;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_miss_time_distance_factor() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].misstimedistancefactor;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_dog_health() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].dog_health;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_dog_press_time() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].dog_presstime;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_dog_hits_before_kill() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].dog_hits_before_kill;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_long_regen_time() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].longregentime;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_player_health_regular_regen_delay() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].playerhealth_regularregendelay;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_worthy_damage_ratio() {
  setdiffstructarrays();
  diff_struct_value = level.s_game_difficulty[level.gameskill].worthydamageratio;
  if(isDefined(diff_struct_value)) {
    return diff_struct_value;
  }
  return 0;
}

function get_coop_enemy_accuracy_modifier() {
  setdiffstructarrays();
  switch (level.players.size) {
    case 1: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].one_player_coopenemyaccuracyscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 2: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].two_player_coopenemyaccuracyscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 3: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].three_player_coopenemyaccuracyscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 4: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].four_player_coopenemyaccuracyscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
  }
  return 1;
}

function get_coop_friendly_accuracy_modifier() {
  setdiffstructarrays();
  switch (level.players.size) {
    case 1: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].one_player_coopfriendlyaccuracyscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 2: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].two_player_coopfriendlyaccuracyscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 3: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].three_player_coopfriendlyaccuracyscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 4: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].four_player_coopfriendlyaccuracyscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    default: {
      return 1;
    }
  }
}

function get_coop_friendly_threat_bias_scalar() {
  setdiffstructarrays();
  switch (level.players.size) {
    case 1: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].one_player_coopfriendlythreatbiasscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 2: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].two_player_coopfriendlythreatbiasscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 3: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].three_player_coopfriendlythreatbiasscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 4: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].four_player_coopfriendlythreatbiasscalar;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    default: {
      return 1;
    }
  }
}

function get_coop_player_health_modifier() {
  setdiffstructarrays();
  switch (level.players.size) {
    case 1: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].one_player_coopplayerdifficultyhealth;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 2: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].two_player_coopplayerdifficultyhealth;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 3: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].three_player_coopplayerdifficultyhealth;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 4: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].four_player_coopplayerdifficultyhealth;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    default: {
      return 1;
    }
  }
}

function get_coop_player_death_invulnerable_time_modifier() {
  setdiffstructarrays();
  switch (level.players.size) {
    case 1: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].one_player_deathinvulnerabletimemodifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 2: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].two_player_deathinvulnerabletimemodifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 3: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].three_player_deathinvulnerabletimemodifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 4: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].four_player_deathinvulnerabletimemodifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    default: {
      return 1;
    }
  }
}

function get_coop_hit_invulnerability_modifier() {
  setdiffstructarrays();
  switch (level.players.size) {
    case 1: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].one_player_hit_invulnerability_modifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 2: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].two_player_hit_invulnerability_modifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 3: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].three_player_hit_invulnerability_modifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 4: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].four_player_hit_invulnerability_modifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
  }
  return 1;
}

function get_coop_enemy_pain_chance_modifier() {
  setdiffstructarrays();
  switch (level.players.size) {
    case 1: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].one_player_enemy_pain_chance_modifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 2: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].two_player_enemy_pain_chance_modifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 3: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].three_player_enemy_pain_chance_modifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
    case 4: {
      diff_struct_value = level.s_game_difficulty[level.gameskill].four_player_enemy_pain_chance_modifier;
      if(isDefined(diff_struct_value)) {
        return diff_struct_value;
      } else {
        return 0;
      }
      break;
    }
  }
  return 1;
}

function get_general_difficulty_level() {
  value = (level.gameskill + level.players.size) - 1;
  if(value < 0) {
    value = 0;
  }
  return value;
}

function player_eligible_for_death_invulnerability() {
  player = self;
  if(level.gameskill >= 4) {
    return 0;
  }
  if(!isDefined(self.eligible_for_death_invulnerability)) {
    self.eligible_for_death_invulnerability = 1;
  }
  return self.eligible_for_death_invulnerability;
}

function monitor_player_death_invulnerability_eligibility() {
  self endon("disconnect");
  self endon("death");
  while(!self.eligible_for_death_invulnerability) {
    if(self.health >= self.maxhealth) {
      self.eligible_for_death_invulnerability = 1;
    }
    wait(0.05);
  }
}

function adjust_damage_for_player_health(player, eattacker, einflictor, idamage, weapon, shitloc, smeansofdamage) {
  coop_healthscalar = get_coop_player_health_modifier();
  player_difficulty_health = get_player_difficulty_health() * coop_healthscalar;
  player_damage_difficulty_modifier = 100 / player_difficulty_health;
  idamage = idamage * player_damage_difficulty_modifier;
  return idamage;
}

function adjust_melee_damage(player, eattacker, einflictor, idamage, weapon, shitloc, smeansofdamage) {
  if(smeansofdamage == "MOD_MELEE" || smeansofdamage == "MOD_MELEE_WEAPON_BUTT" && isentity(eattacker)) {
    idamage = idamage / 5;
    if(idamage > 40) {
      playerforward = anglesToForward(player.angles);
      toattacker = vectornormalize(eattacker.origin - player.origin);
      if(vectordot(playerforward, toattacker) < 0.342) {
        idamage = 40;
      }
    }
  }
  return idamage;
}

function accuracy_buildup_over_time_init() {
  self endon("death");
  self.baseaccuracy = self.accuracy;
}

function accuracy_buildup_before_fire(ai) {
  self endon("death");
  if(getdvarint("ai_codeGameskill")) {
    return;
  }
  while(true) {
    if(isDefined(ai.enemy)) {
      if(isplayer(ai.enemy)) {
        if(!isDefined(ai.lastenemyshotat)) {
          ai.lastenemyshotat = ai.enemy;
          ai.buildupaccuracymodifier = 0;
          ai.shoottimestart = gettime();
          ai.lastshottime = ai.shoottimestart;
        }
        if(ai.enemy != ai.lastenemyshotat) {
          ai.lastenemyshotat = ai.enemy;
          ai.buildupaccuracymodifier = 0;
          ai.shoottimestart = gettime();
          ai.lastshottime = ai.shoottimestart;
        } else {
          ai.miss_time_constant = get_miss_time_constant();
          ai.miss_time_distance_factor = get_miss_time_distance_factor();
          ai.miss_time_reset_delay = get_miss_time_reset_delay();
          if(ai.accuratefire) {
            ai.miss_time_reset_delay = ai.miss_time_reset_delay * 2;
          }
          shottime = gettime();
          timeshooting = shottime - ai.shoottimestart;
          distance = distance(ai.origin, ai.enemy.origin);
          misstime = ai.miss_time_constant * 1000;
          accuracybuilduptime = misstime + (distance * ai.miss_time_distance_factor);
          targetfacingangle = anglesToForward(ai.enemy.angles);
          anglefromtarget = vectornormalize(ai.origin - ai.enemy.origin);
          if(vectordot(targetfacingangle, anglefromtarget) < 0.7) {
            accuracybuilduptime = accuracybuilduptime * 2;
          }
          if((shottime - ai.lastshottime) > ai.miss_time_reset_delay) {
            ai.buildupaccuracymodifier = 0;
            ai.shoottimestart = shottime;
            timeshooting = 0;
          }
          if(timeshooting > accuracybuilduptime) {
            ai.buildupaccuracymodifier = 1;
          }
          if(timeshooting <= accuracybuilduptime && timeshooting > (accuracybuilduptime * 0.66)) {
            ai.buildupaccuracymodifier = 0.66;
          }
          if(timeshooting <= (accuracybuilduptime * 0.66) && timeshooting > (accuracybuilduptime * 0.33)) {
            ai.buildupaccuracymodifier = 0.33;
          }
          if(timeshooting <= (accuracybuilduptime * 0.33)) {
            ai.buildupaccuracymodifier = 0;
          }
          ai.lastshottime = shottime;
        }
      } else {
        ai.buildupaccuracymodifier = 1;
      }
      ai.accuracy = ai.baseaccuracy * ai.buildupaccuracymodifier;
    }
    self waittill("about_to_shoot");
  }
}